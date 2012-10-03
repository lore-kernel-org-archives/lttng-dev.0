From: David Goulet <dgoulet@efficios.com>
Subject: Re: [LTTNG-TOOLS PATCH v5] ABI with support for compat
 32/64 bits
Date: Wed, 03 Oct 2012 09:40:20 -0400
Message-ID: <506C4044.7000603__17995.8144588911$1349271719$gmane$org@efficios.com>
References: <1349204606-6473-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TJPBb-0005W7-9K
	for lttng-dev@lists.lttng.org; Wed, 03 Oct 2012 09:40:27 -0400
In-Reply-To: <1349204606-6473-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This look good to me. There is a small change I would make though to the
open_metadata call where the old_channel is not in the if - else{}
statement but I'll do it before merging it. Don't bother sending back a
version.

Acked.

David

Julien Desfossez:
> The current ABI does not work for compat 32/64 bits.
> This patch moves the current ABI as old-abi and provides a new ABI in
> which all the structures exchanged between user and kernel-space are
> packed. Also this new ABI moves the "int overwrite" member of the
> struct lttng_kernel_channel to remove the alignment added by the
> compiler.
> 
> A patch for lttng-modules has been developed in parallel to this one
> to support the new ABI. These 2 patches have been tested in all
> possible configurations (applied or not) on 64-bit and 32-bit kernels
> (with CONFIG_COMPAT) and a user-space in 32 and 64-bit.
> 
> Here are the results of the tests :
> k 64 compat     | u 32 compat     | OK
> k 64 compat     | u 64 compat     | OK
> k 64 compat     | u 32 non-compat | KO
> k 64 compat     | u 64 non-compat | OK
> 
> k 64 non-compat | u 64 compat     | OK
> k 64 non-compat | u 32 compat     | KO
> k 64 non-compat | u 64 non-compat | OK
> k 64 non-compat | u 32 non-compat | KO
> 
> k 32 compat     | u compat        | OK
> k 32 compat     | u non-compat    | OK
> 
> k 32 non-compat | u compat        | OK
> k 32 non-compat | u non-compat    | OK
> 
> The results are as expected :
> - on 32-bit user-space and kernel, every configuration works.
> - on 64-bit user-space and kernel, every configuration works.
> - with 32-bit user-space on a 64-bit kernel the only configuration
>   where it works is when the compat patch is applied everywhere.
> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
>  src/bin/lttng-sessiond/trace-kernel.h |    1 +
>  src/common/kernel-ctl/kernel-ctl.c    |  224 ++++++++++++++++++++++++++++++---
>  src/common/kernel-ctl/kernel-ctl.h    |    1 +
>  src/common/kernel-ctl/kernel-ioctl.h  |   74 +++++++----
>  src/common/lttng-kernel-old.h         |  115 +++++++++++++++++
>  src/common/lttng-kernel.h             |   31 +++--
>  6 files changed, 397 insertions(+), 49 deletions(-)
>  create mode 100644 src/common/lttng-kernel-old.h
> 
> diff --git a/src/bin/lttng-sessiond/trace-kernel.h b/src/bin/lttng-sessiond/trace-kernel.h
> index f04d9e7..c86cc27 100644
> --- a/src/bin/lttng-sessiond/trace-kernel.h
> +++ b/src/bin/lttng-sessiond/trace-kernel.h
> @@ -22,6 +22,7 @@
>  
>  #include <lttng/lttng.h>
>  #include <common/lttng-kernel.h>
> +#include <common/lttng-kernel-old.h>
>  
>  #include "consumer.h"
>  
> diff --git a/src/common/kernel-ctl/kernel-ctl.c b/src/common/kernel-ctl/kernel-ctl.c
> index 1396cd9..a93d251 100644
> --- a/src/common/kernel-ctl/kernel-ctl.c
> +++ b/src/common/kernel-ctl/kernel-ctl.c
> @@ -18,38 +18,175 @@
>  
>  #define __USE_LINUX_IOCTL_DEFS
>  #include <sys/ioctl.h>
> +#include <string.h>
>  
>  #include "kernel-ctl.h"
>  #include "kernel-ioctl.h"
>  
> +/*
> + * This flag indicates which version of the kernel ABI to use. The old
> + * ABI (namespace _old) does not support a 32-bit user-space when the
> + * kernel is 64-bit. The old ABI is kept here for compatibility but is
> + * deprecated and will be removed eventually.
> + */
> +static int lttng_kernel_use_old_abi = -1;
> +
> +/*
> + * Execute the new or old ioctl depending on the ABI version.
> + * If the ABI version is not determined yet (lttng_kernel_use_old_abi = -1),
> + * this function tests if the new ABI is available and otherwise fallbacks
> + * on the old one.
> + * This function takes the fd on which the ioctl must be executed and the old
> + * and new request codes.
> + * It returns the return value of the ioctl executed.
> + */
> +static inline int compat_ioctl_no_arg(int fd, unsigned long oldname,
> +		unsigned long newname)
> +{
> +	int ret;
> +
> +	if (lttng_kernel_use_old_abi == -1) {
> +		ret = ioctl(fd, newname);
> +		if (!ret) {
> +			lttng_kernel_use_old_abi = 0;
> +			goto end;
> +		}
> +		lttng_kernel_use_old_abi = 1;
> +	}
> +	if (lttng_kernel_use_old_abi) {
> +		ret = ioctl(fd, oldname);
> +	} else {
> +		ret = ioctl(fd, newname);
> +	}
> +
> +end:
> +	return ret;
> +}
> +
>  int kernctl_create_session(int fd)
>  {
> -	return ioctl(fd, LTTNG_KERNEL_SESSION);
> +	return compat_ioctl_no_arg(fd, LTTNG_KERNEL_OLD_SESSION,
> +			LTTNG_KERNEL_SESSION);
>  }
>  
>  /* open the metadata global channel */
>  int kernctl_open_metadata(int fd, struct lttng_channel_attr *chops)
>  {
> -	return ioctl(fd, LTTNG_KERNEL_METADATA, chops);
> +	struct lttng_kernel_old_channel old_channel;
> +	struct lttng_kernel_channel channel;
> +
> +	if (lttng_kernel_use_old_abi) {
> +		old_channel.overwrite = chops->overwrite;
> +		old_channel.subbuf_size = chops->subbuf_size;
> +		old_channel.num_subbuf = chops->num_subbuf;
> +		old_channel.switch_timer_interval = chops->switch_timer_interval;
> +		old_channel.read_timer_interval = chops->read_timer_interval;
> +		old_channel.output = chops->output;
> +		memcpy(old_channel.padding, chops->padding, sizeof(old_channel.padding));
> +
> +		return ioctl(fd, LTTNG_KERNEL_OLD_METADATA, &old_channel);
> +	}
> +
> +	channel.overwrite = chops->overwrite;
> +	channel.subbuf_size = chops->subbuf_size;
> +	channel.num_subbuf = chops->num_subbuf;
> +	channel.switch_timer_interval = chops->switch_timer_interval;
> +	channel.read_timer_interval = chops->read_timer_interval;
> +	channel.output = chops->output;
> +	memcpy(channel.padding, chops->padding, sizeof(channel.padding));
> +
> +	return ioctl(fd, LTTNG_KERNEL_METADATA, &channel);
>  }
>  
>  int kernctl_create_channel(int fd, struct lttng_channel_attr *chops)
>  {
> -	return ioctl(fd, LTTNG_KERNEL_CHANNEL, chops);
> +	struct lttng_kernel_channel channel;
> +
> +	if (lttng_kernel_use_old_abi) {
> +		struct lttng_kernel_old_channel old_channel;
> +
> +		old_channel.overwrite = chops->overwrite;
> +		old_channel.subbuf_size = chops->subbuf_size;
> +		old_channel.num_subbuf = chops->num_subbuf;
> +		old_channel.switch_timer_interval = chops->switch_timer_interval;
> +		old_channel.read_timer_interval = chops->read_timer_interval;
> +		old_channel.output = chops->output;
> +		memcpy(old_channel.padding, chops->padding, sizeof(old_channel.padding));
> +
> +		return ioctl(fd, LTTNG_KERNEL_OLD_CHANNEL, &old_channel);
> +	}
> +
> +	channel.overwrite = chops->overwrite;
> +	channel.subbuf_size = chops->subbuf_size;
> +	channel.num_subbuf = chops->num_subbuf;
> +	channel.switch_timer_interval = chops->switch_timer_interval;
> +	channel.read_timer_interval = chops->read_timer_interval;
> +	channel.output = chops->output;
> +	memcpy(channel.padding, chops->padding, sizeof(channel.padding));
> +
> +	return ioctl(fd, LTTNG_KERNEL_CHANNEL, &channel);
>  }
>  
>  int kernctl_create_stream(int fd)
>  {
> -	return ioctl(fd, LTTNG_KERNEL_STREAM);
> +	return compat_ioctl_no_arg(fd, LTTNG_KERNEL_OLD_STREAM,
> +			LTTNG_KERNEL_STREAM);
>  }
>  
>  int kernctl_create_event(int fd, struct lttng_kernel_event *ev)
>  {
> +	if (lttng_kernel_use_old_abi) {
> +		struct lttng_kernel_old_event old_event;
> +
> +		memcpy(old_event.name, ev->name, sizeof(old_event.name));
> +		old_event.instrumentation = ev->instrumentation;
> +		switch (ev->instrumentation) {
> +		case LTTNG_KERNEL_KPROBE:
> +			old_event.u.kprobe.addr = ev->u.kprobe.addr;
> +			old_event.u.kprobe.offset = ev->u.kprobe.offset;
> +			memcpy(old_event.u.kprobe.symbol_name,
> +				ev->u.kprobe.symbol_name,
> +				sizeof(old_event.u.kprobe.symbol_name));
> +			break;
> +		case LTTNG_KERNEL_KRETPROBE:
> +			old_event.u.kretprobe.addr = ev->u.kretprobe.addr;
> +			old_event.u.kretprobe.offset = ev->u.kretprobe.offset;
> +			memcpy(old_event.u.kretprobe.symbol_name,
> +				ev->u.kretprobe.symbol_name,
> +				sizeof(old_event.u.kretprobe.symbol_name));
> +			break;
> +		case LTTNG_KERNEL_FUNCTION:
> +			memcpy(old_event.u.ftrace.symbol_name,
> +					ev->u.ftrace.symbol_name,
> +					sizeof(old_event.u.ftrace.symbol_name));
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		return ioctl(fd, LTTNG_KERNEL_OLD_EVENT, &old_event);
> +	}
>  	return ioctl(fd, LTTNG_KERNEL_EVENT, ev);
>  }
>  
>  int kernctl_add_context(int fd, struct lttng_kernel_context *ctx)
>  {
> +	if (lttng_kernel_use_old_abi) {
> +		struct lttng_kernel_old_context old_ctx;
> +
> +		old_ctx.ctx = ctx->ctx;
> +		/* only type that uses the union */
> +		if (ctx->ctx == LTTNG_KERNEL_CONTEXT_PERF_COUNTER) {
> +			old_ctx.u.perf_counter.type =
> +				ctx->u.perf_counter.type;
> +			old_ctx.u.perf_counter.config =
> +				ctx->u.perf_counter.config;
> +			memcpy(old_ctx.u.perf_counter.name,
> +				ctx->u.perf_counter.name,
> +				sizeof(old_ctx.u.perf_counter.name));
> +		}
> +		return ioctl(fd, LTTNG_KERNEL_OLD_CONTEXT, &old_ctx);
> +	}
>  	return ioctl(fd, LTTNG_KERNEL_CONTEXT, ctx);
>  }
>  
> @@ -57,44 +194,98 @@ int kernctl_add_context(int fd, struct lttng_kernel_context *ctx)
>  /* Enable event, channel and session ioctl */
>  int kernctl_enable(int fd)
>  {
> -	return ioctl(fd, LTTNG_KERNEL_ENABLE);
> +	return compat_ioctl_no_arg(fd, LTTNG_KERNEL_OLD_ENABLE,
> +			LTTNG_KERNEL_ENABLE);
>  }
>  
>  /* Disable event, channel and session ioctl */
>  int kernctl_disable(int fd)
>  {
> -	return ioctl(fd, LTTNG_KERNEL_DISABLE);
> +	return compat_ioctl_no_arg(fd, LTTNG_KERNEL_OLD_DISABLE,
> +			LTTNG_KERNEL_DISABLE);
>  }
>  
>  int kernctl_start_session(int fd)
>  {
> -	return ioctl(fd, LTTNG_KERNEL_SESSION_START);
> +	return compat_ioctl_no_arg(fd, LTTNG_KERNEL_OLD_SESSION_START,
> +			LTTNG_KERNEL_SESSION_START);
>  }
>  
>  int kernctl_stop_session(int fd)
>  {
> -	return ioctl(fd, LTTNG_KERNEL_SESSION_STOP);
> +	return compat_ioctl_no_arg(fd, LTTNG_KERNEL_OLD_SESSION_STOP,
> +			LTTNG_KERNEL_SESSION_STOP);
>  }
>  
> -
>  int kernctl_tracepoint_list(int fd)
>  {
> -	return ioctl(fd, LTTNG_KERNEL_TRACEPOINT_LIST);
> +	return compat_ioctl_no_arg(fd, LTTNG_KERNEL_OLD_TRACEPOINT_LIST,
> +			LTTNG_KERNEL_TRACEPOINT_LIST);
>  }
>  
>  int kernctl_tracer_version(int fd, struct lttng_kernel_tracer_version *v)
>  {
> -	return ioctl(fd, LTTNG_KERNEL_TRACER_VERSION, v);
> +	int ret;
> +
> +	if (lttng_kernel_use_old_abi == -1) {
> +		ret = ioctl(fd, LTTNG_KERNEL_TRACER_VERSION, v);
> +		if (!ret) {
> +			lttng_kernel_use_old_abi = 0;
> +			goto end;
> +		}
> +		lttng_kernel_use_old_abi = 1;
> +	}
> +	if (lttng_kernel_use_old_abi) {
> +		struct lttng_kernel_old_tracer_version old_v;
> +
> +		ret = ioctl(fd, LTTNG_KERNEL_OLD_TRACER_VERSION, &old_v);
> +		if (ret) {
> +			goto end;
> +		}
> +		v->major = old_v.major;
> +		v->minor = old_v.minor;
> +		v->patchlevel = old_v.patchlevel;
> +	} else {
> +		ret = ioctl(fd, LTTNG_KERNEL_TRACER_VERSION, v);
> +	}
> +
> +end:
> +	return ret;
>  }
>  
>  int kernctl_wait_quiescent(int fd)
>  {
> -	return ioctl(fd, LTTNG_KERNEL_WAIT_QUIESCENT);
> +	return compat_ioctl_no_arg(fd, LTTNG_KERNEL_OLD_WAIT_QUIESCENT,
> +			LTTNG_KERNEL_WAIT_QUIESCENT);
>  }
>  
>  int kernctl_calibrate(int fd, struct lttng_kernel_calibrate *calibrate)
>  {
> -	return ioctl(fd, LTTNG_KERNEL_CALIBRATE, calibrate);
> +	int ret;
> +
> +	if (lttng_kernel_use_old_abi == -1) {
> +		ret = ioctl(fd, LTTNG_KERNEL_CALIBRATE, calibrate);
> +		if (!ret) {
> +			lttng_kernel_use_old_abi = 0;
> +			goto end;
> +		}
> +		lttng_kernel_use_old_abi = 1;
> +	}
> +	if (lttng_kernel_use_old_abi) {
> +		struct lttng_kernel_old_calibrate old_calibrate;
> +
> +		old_calibrate.type = calibrate->type;
> +		ret = ioctl(fd, LTTNG_KERNEL_OLD_CALIBRATE, &old_calibrate);
> +		if (ret) {
> +			goto end;
> +		}
> +		calibrate->type = old_calibrate.type;
> +	} else {
> +		ret = ioctl(fd, LTTNG_KERNEL_CALIBRATE, calibrate);
> +	}
> +
> +end:
> +	return ret;
>  }
>  
>  
> @@ -193,10 +384,3 @@ int kernctl_set_stream_id(int fd, unsigned long *stream_id)
>  {
>  	return ioctl(fd, RING_BUFFER_SET_STREAM_ID, stream_id);
>  }
> -
> -/* Get the offset of the stream_id in the packet header */
> -int kernctl_get_net_stream_id_offset(int fd, unsigned long *offset)
> -{
> -	return ioctl(fd, LTTNG_KERNEL_STREAM_ID_OFFSET, offset);
> -
> -}
> diff --git a/src/common/kernel-ctl/kernel-ctl.h b/src/common/kernel-ctl/kernel-ctl.h
> index 18712d9..85a3a18 100644
> --- a/src/common/kernel-ctl/kernel-ctl.h
> +++ b/src/common/kernel-ctl/kernel-ctl.h
> @@ -21,6 +21,7 @@
>  
>  #include <lttng/lttng.h>
>  #include <common/lttng-kernel.h>
> +#include <common/lttng-kernel-old.h>
>  
>  int kernctl_create_session(int fd);
>  int kernctl_open_metadata(int fd, struct lttng_channel_attr *chops);
> diff --git a/src/common/kernel-ctl/kernel-ioctl.h b/src/common/kernel-ctl/kernel-ioctl.h
> index 35942be..8e22632 100644
> --- a/src/common/kernel-ctl/kernel-ioctl.h
> +++ b/src/common/kernel-ctl/kernel-ioctl.h
> @@ -49,37 +49,69 @@
>  /* map stream to stream id for network streaming */
>  #define RING_BUFFER_SET_STREAM_ID           _IOW(0xF6, 0x0D, unsigned long)
>  
> +/* Old ABI (without support for 32/64 bits compat) */
> +/* LTTng file descriptor ioctl */
> +#define LTTNG_KERNEL_OLD_SESSION                _IO(0xF6, 0x40)
> +#define LTTNG_KERNEL_OLD_TRACER_VERSION         \
> +		_IOR(0xF6, 0x41, struct lttng_kernel_old_tracer_version)
> +#define LTTNG_KERNEL_OLD_TRACEPOINT_LIST        _IO(0xF6, 0x42)
> +#define LTTNG_KERNEL_OLD_WAIT_QUIESCENT         _IO(0xF6, 0x43)
> +#define LTTNG_KERNEL_OLD_CALIBRATE		\
> +	_IOWR(0xF6, 0x44, struct lttng_kernel_old_calibrate)
> +
> +/* Session FD ioctl */
> +#define LTTNG_KERNEL_OLD_METADATA               \
> +		_IOW(0xF6, 0x50, struct lttng_kernel_old_channel)
> +#define LTTNG_KERNEL_OLD_CHANNEL                \
> +		_IOW(0xF6, 0x51, struct lttng_kernel_old_channel)
> +#define LTTNG_KERNEL_OLD_SESSION_START          _IO(0xF6, 0x52)
> +#define LTTNG_KERNEL_OLD_SESSION_STOP           _IO(0xF6, 0x53)
> +
> +/* Channel FD ioctl */
> +#define LTTNG_KERNEL_OLD_STREAM                 _IO(0xF6, 0x60)
> +#define LTTNG_KERNEL_OLD_EVENT                  \
> +		_IOW(0xF6, 0x61, struct lttng_kernel_old_event)
> +#define LTTNG_KERNEL_OLD_STREAM_ID_OFFSET       \
> +		_IOR(0xF6, 0x62, unsigned long)
>  
> +/* Event and Channel FD ioctl */
> +#define LTTNG_KERNEL_OLD_CONTEXT                \
> +		_IOW(0xF6, 0x70, struct lttng_kernel_old_context)
> +
> +/* Event, Channel and Session ioctl */
> +#define LTTNG_KERNEL_OLD_ENABLE                 _IO(0xF6, 0x80)
> +#define LTTNG_KERNEL_OLD_DISABLE                _IO(0xF6, 0x81)
> +
> +
> +/* Current ABI (with suport for 32/64 bits compat) */
>  /* LTTng file descriptor ioctl */
> -#define LTTNG_KERNEL_SESSION                _IO(0xF6, 0x40)
> -#define LTTNG_KERNEL_TRACER_VERSION         \
> -		_IOR(0xF6, 0x41, struct lttng_kernel_tracer_version)
> -#define LTTNG_KERNEL_TRACEPOINT_LIST        _IO(0xF6, 0x42)
> -#define LTTNG_KERNEL_WAIT_QUIESCENT         _IO(0xF6, 0x43)
> +#define LTTNG_KERNEL_SESSION			_IO(0xF6, 0x45)
> +#define LTTNG_KERNEL_TRACER_VERSION		\
> +	_IOR(0xF6, 0x46, struct lttng_kernel_tracer_version)
> +#define LTTNG_KERNEL_TRACEPOINT_LIST		_IO(0xF6, 0x47)
> +#define LTTNG_KERNEL_WAIT_QUIESCENT		_IO(0xF6, 0x48)
>  #define LTTNG_KERNEL_CALIBRATE			\
> -	_IOWR(0xF6, 0x44, struct lttng_kernel_calibrate)
> +	_IOWR(0xF6, 0x49, struct lttng_kernel_calibrate)
>  
>  /* Session FD ioctl */
> -#define LTTNG_KERNEL_METADATA               \
> -		_IOW(0xF6, 0x50, struct lttng_channel_attr)
> -#define LTTNG_KERNEL_CHANNEL                \
> -		_IOW(0xF6, 0x51, struct lttng_channel_attr)
> -#define LTTNG_KERNEL_SESSION_START          _IO(0xF6, 0x52)
> -#define LTTNG_KERNEL_SESSION_STOP           _IO(0xF6, 0x53)
> +#define LTTNG_KERNEL_METADATA			\
> +	_IOW(0xF6, 0x54, struct lttng_kernel_channel)
> +#define LTTNG_KERNEL_CHANNEL			\
> +	_IOW(0xF6, 0x55, struct lttng_kernel_channel)
> +#define LTTNG_KERNEL_SESSION_START		_IO(0xF6, 0x56)
> +#define LTTNG_KERNEL_SESSION_STOP		_IO(0xF6, 0x57)
>  
>  /* Channel FD ioctl */
> -#define LTTNG_KERNEL_STREAM                 _IO(0xF6, 0x60)
> -#define LTTNG_KERNEL_EVENT                  \
> -		_IOW(0xF6, 0x61, struct lttng_kernel_event)
> -#define LTTNG_KERNEL_STREAM_ID_OFFSET       \
> -		_IOR(0xF6, 0x62, unsigned long)
> +#define LTTNG_KERNEL_STREAM			_IO(0xF6, 0x62)
> +#define LTTNG_KERNEL_EVENT			\
> +	_IOW(0xF6, 0x63, struct lttng_kernel_event)
>  
>  /* Event and Channel FD ioctl */
> -#define LTTNG_KERNEL_CONTEXT                \
> -		_IOW(0xF6, 0x70, struct lttng_kernel_context)
> +#define LTTNG_KERNEL_CONTEXT			\
> +	_IOW(0xF6, 0x71, struct lttng_kernel_context)
>  
>  /* Event, Channel and Session ioctl */
> -#define LTTNG_KERNEL_ENABLE                 _IO(0xF6, 0x80)
> -#define LTTNG_KERNEL_DISABLE                _IO(0xF6, 0x81)
> +#define LTTNG_KERNEL_ENABLE			_IO(0xF6, 0x82)
> +#define LTTNG_KERNEL_DISABLE			_IO(0xF6, 0x83)
>  
>  #endif /* _LTT_KERNEL_IOCTL_H */
> diff --git a/src/common/lttng-kernel-old.h b/src/common/lttng-kernel-old.h
> new file mode 100644
> index 0000000..1b8999a
> --- /dev/null
> +++ b/src/common/lttng-kernel-old.h
> @@ -0,0 +1,115 @@
> +/*
> + * Copyright (C) 2011 - Julien Desfossez <julien.desfossez@polymtl.ca>
> + *                      Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + *                      David Goulet <david.goulet@polymtl.ca>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2 only,
> + * as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#ifndef _LTTNG_KERNEL_OLD_H
> +#define _LTTNG_KERNEL_OLD_H
> +
> +#include <stdint.h>
> +#include <common/lttng-kernel.h>
> +
> +/*
> + * LTTng DebugFS ABI structures.
> + *
> + * This is the kernel ABI copied from lttng-modules tree.
> + */
> +
> +/* Perf counter attributes */
> +struct lttng_kernel_old_perf_counter_ctx {
> +	uint32_t type;
> +	uint64_t config;
> +	char name[LTTNG_KERNEL_SYM_NAME_LEN];
> +};
> +
> +/* Event/Channel context */
> +#define LTTNG_KERNEL_OLD_CONTEXT_PADDING1  16
> +#define LTTNG_KERNEL_OLD_CONTEXT_PADDING2  LTTNG_KERNEL_SYM_NAME_LEN + 32
> +struct lttng_kernel_old_context {
> +	enum lttng_kernel_context_type ctx;
> +	char padding[LTTNG_KERNEL_OLD_CONTEXT_PADDING1];
> +
> +	union {
> +		struct lttng_kernel_old_perf_counter_ctx perf_counter;
> +		char padding[LTTNG_KERNEL_OLD_CONTEXT_PADDING2];
> +	} u;
> +};
> +
> +struct lttng_kernel_old_kretprobe {
> +	uint64_t addr;
> +
> +	uint64_t offset;
> +	char symbol_name[LTTNG_KERNEL_SYM_NAME_LEN];
> +};
> +
> +/*
> + * Either addr is used, or symbol_name and offset.
> + */
> +struct lttng_kernel_old_kprobe {
> +	uint64_t addr;
> +
> +	uint64_t offset;
> +	char symbol_name[LTTNG_KERNEL_SYM_NAME_LEN];
> +};
> +
> +/* Function tracer */
> +struct lttng_kernel_old_function {
> +	char symbol_name[LTTNG_KERNEL_SYM_NAME_LEN];
> +};
> +
> +#define LTTNG_KERNEL_OLD_EVENT_PADDING1    16
> +#define LTTNG_KERNEL_OLD_EVENT_PADDING2    LTTNG_KERNEL_SYM_NAME_LEN + 32
> +struct lttng_kernel_old_event {
> +	char name[LTTNG_KERNEL_SYM_NAME_LEN];
> +	enum lttng_kernel_instrumentation instrumentation;
> +	char padding[LTTNG_KERNEL_OLD_EVENT_PADDING1];
> +
> +	/* Per instrumentation type configuration */
> +	union {
> +		struct lttng_kernel_old_kretprobe kretprobe;
> +		struct lttng_kernel_old_kprobe kprobe;
> +		struct lttng_kernel_old_function ftrace;
> +		char padding[LTTNG_KERNEL_OLD_EVENT_PADDING2];
> +	} u;
> +};
> +
> +struct lttng_kernel_old_tracer_version {
> +	uint32_t major;
> +	uint32_t minor;
> +	uint32_t patchlevel;
> +};
> +
> +struct lttng_kernel_old_calibrate {
> +	enum lttng_kernel_calibrate_type type;	/* type (input) */
> +};
> +
> +/*
> + * kernel channel
> + */
> +#define LTTNG_KERNEL_OLD_CHANNEL_PADDING1 LTTNG_SYMBOL_NAME_LEN + 32
> +struct lttng_kernel_old_channel {
> +	int overwrite;                      /* 1: overwrite, 0: discard */
> +	uint64_t subbuf_size;               /* bytes */
> +	uint64_t num_subbuf;                /* power of 2 */
> +	unsigned int switch_timer_interval; /* usec */
> +	unsigned int read_timer_interval;   /* usec */
> +	enum lttng_event_output output;     /* splice, mmap */
> +
> +	char padding[LTTNG_KERNEL_OLD_CHANNEL_PADDING1];
> +};
> +
> +#endif /* _LTTNG_KERNEL_OLD_H */
> diff --git a/src/common/lttng-kernel.h b/src/common/lttng-kernel.h
> index dbeb6aa..fa8ba61 100644
> --- a/src/common/lttng-kernel.h
> +++ b/src/common/lttng-kernel.h
> @@ -59,7 +59,7 @@ struct lttng_kernel_perf_counter_ctx {
>  	uint32_t type;
>  	uint64_t config;
>  	char name[LTTNG_KERNEL_SYM_NAME_LEN];
> -};
> +}__attribute__((packed));
>  
>  /* Event/Channel context */
>  #define LTTNG_KERNEL_CONTEXT_PADDING1  16
> @@ -72,14 +72,14 @@ struct lttng_kernel_context {
>  		struct lttng_kernel_perf_counter_ctx perf_counter;
>  		char padding[LTTNG_KERNEL_CONTEXT_PADDING2];
>  	} u;
> -};
> +}__attribute__((packed));
>  
>  struct lttng_kernel_kretprobe {
>  	uint64_t addr;
>  
>  	uint64_t offset;
>  	char symbol_name[LTTNG_KERNEL_SYM_NAME_LEN];
> -};
> +}__attribute__((packed));
>  
>  /*
>   * Either addr is used, or symbol_name and offset.
> @@ -89,12 +89,12 @@ struct lttng_kernel_kprobe {
>  
>  	uint64_t offset;
>  	char symbol_name[LTTNG_KERNEL_SYM_NAME_LEN];
> -};
> +}__attribute__((packed));
>  
>  /* Function tracer */
>  struct lttng_kernel_function {
>  	char symbol_name[LTTNG_KERNEL_SYM_NAME_LEN];
> -};
> +}__attribute__((packed));
>  
>  #define LTTNG_KERNEL_EVENT_PADDING1    16
>  #define LTTNG_KERNEL_EVENT_PADDING2    LTTNG_KERNEL_SYM_NAME_LEN + 32
> @@ -110,13 +110,13 @@ struct lttng_kernel_event {
>  		struct lttng_kernel_function ftrace;
>  		char padding[LTTNG_KERNEL_EVENT_PADDING2];
>  	} u;
> -};
> +}__attribute__((packed));
>  
>  struct lttng_kernel_tracer_version {
>  	uint32_t major;
>  	uint32_t minor;
>  	uint32_t patchlevel;
> -};
> +}__attribute__((packed));
>  
>  enum lttng_kernel_calibrate_type {
>  	LTTNG_KERNEL_CALIBRATE_KRETPROBE,
> @@ -124,6 +124,21 @@ enum lttng_kernel_calibrate_type {
>  
>  struct lttng_kernel_calibrate {
>  	enum lttng_kernel_calibrate_type type;	/* type (input) */
> -};
> +}__attribute__((packed));
> +
> +/*
> + * kernel channel
> + */
> +#define LTTNG_KERNEL_CHANNEL_PADDING1 LTTNG_SYMBOL_NAME_LEN + 32
> +struct lttng_kernel_channel {
> +	uint64_t subbuf_size;               /* bytes */
> +	uint64_t num_subbuf;                /* power of 2 */
> +	unsigned int switch_timer_interval; /* usec */
> +	unsigned int read_timer_interval;   /* usec */
> +	enum lttng_event_output output;     /* splice, mmap */
> +
> +	int overwrite;                      /* 1: overwrite, 0: discard */
> +	char padding[LTTNG_KERNEL_CHANNEL_PADDING1];
> +}__attribute__((packed));
>  
>  #endif /* _LTTNG_KERNEL_H */
