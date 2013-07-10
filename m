From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH lttng-ust] callsite: add "ip" context
	(from	ust/callsite branch)
Date: Wed, 10 Jul 2013 09:13:34 -0400
Message-ID: <20130710131334.GB1921__36918.854880105$1373462049$gmane$org@Krystal>
References: <3406262.FNouyoFuSc@atv-pwoegere-l3.atv.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UwuDB-0003HB-1F
	for lttng-dev@lists.lttng.org; Wed, 10 Jul 2013 09:13:37 -0400
Content-Disposition: inline
In-Reply-To: <3406262.FNouyoFuSc@atv-pwoegere-l3.atv.mentorg.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Woegerer, Paul (Paul_Woegerer@mentor.com) wrote:
> Hi Mathieu,
> 
> it would be great if your patch 'callsite: add "ip" context'
> from branch ust/callsite could get merged to master.
> (I fixed the conflicts, so it should apply without issues)
> 
> Your patch is the first step to enable lttng users to easily
> look up the place in source that emitted a given event.
> 
> Also it allow us to get rid of our custom header file (that
> did basically the same but as an extra payload field).
> 
> Other patches will follow to make things work for events that
> are emitted from shared objects ( as already discussed here:
> https://bugs.lttng.org/issues/474 ).

Sounds like a good idea!

Merged as:

commit 96f85541c4e3773d3d1579f04f84633bc9bb6696
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Wed Jul 10 09:08:07 2013 -0400

    callsite: add "ip" context
    
    Add caller's instruction pointer context.
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>


> 
> Thanks,
> Paul
> 
> -- 
> Paul Woegerer, SW Development Engineer
> Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
> Mentor Graphics, Embedded Software Division
> 
> From 96c9c0672f230801098f71cfa99b4739351848f0 Mon Sep 17 00:00:00 2001
> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date: Tue, 16 Oct 2012 13:00:57 -0400
> Subject: [PATCH] callsite: add "ip" context
> 
> Add caller's instruction pointer context.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  include/lttng/ringbuffer-config.h    | 11 ++++--
>  include/lttng/tracepoint.h           |  9 ++++-
>  include/lttng/ust-abi.h              |  1 +
>  include/lttng/ust-events.h           |  1 +
>  include/lttng/ust-tracepoint-event.h |  1 +
>  liblttng-ust/Makefile.am             |  1 +
>  liblttng-ust/lttng-context-ip.c      | 73 ++++++++++++++++++++++++++++++++++++
>  liblttng-ust/lttng-events.c          |  2 +
>  8 files changed, 94 insertions(+), 5 deletions(-)
>  create mode 100644 liblttng-ust/lttng-context-ip.c
> 
> diff --git a/include/lttng/ringbuffer-config.h b/include/lttng/ringbuffer-config.h
> index 42889cc..3b7d348 100644
> --- a/include/lttng/ringbuffer-config.h
> +++ b/include/lttng/ringbuffer-config.h
> @@ -218,7 +218,8 @@ struct lttng_ust_lib_ring_buffer_config {
>   * UST. Fields need to be only added at the end, never reordered, never
>   * removed.
>   */
> -#define LTTNG_UST_RING_BUFFER_CTX_PADDING	24
> +#define LTTNG_UST_RING_BUFFER_CTX_PADDING	\
> +		(24 - sizeof(int) - sizeof(void *))
>  struct lttng_ust_lib_ring_buffer_ctx {
>  	/* input received by lib_ring_buffer_reserve(), saved here. */
>  	struct channel *chan;		/* channel */
> @@ -246,7 +247,9 @@ struct lttng_ust_lib_ring_buffer_ctx {
>  					 */
>  	uint64_t tsc;			/* time-stamp counter value */
>  	unsigned int rflags;		/* reservation flags */
> -	char padding[LTTNG_UST_RING_BUFFER_CTX_PADDING];
> +	unsigned int padding1;		/* padding to realign on pointer */
> +	void *ip;			/* caller ip address */
> +	char padding2[LTTNG_UST_RING_BUFFER_CTX_PADDING];
>  };
>  
>  /**
> @@ -276,7 +279,9 @@ void lib_ring_buffer_ctx_init(struct lttng_ust_lib_ring_buffer_ctx *ctx,
>  	ctx->cpu = cpu;
>  	ctx->rflags = 0;
>  	ctx->handle = handle;
> -	memset(ctx->padding, 0, LTTNG_UST_RING_BUFFER_CTX_PADDING);
> +	ctx->padding1 = 0;
> +	ctx->ip = 0;
> +	memset(ctx->padding2, 0, LTTNG_UST_RING_BUFFER_CTX_PADDING);
>  }
>  
>  /*
> diff --git a/include/lttng/tracepoint.h b/include/lttng/tracepoint.h
> index 0327c11..b3b01cc 100644
> --- a/include/lttng/tracepoint.h
> +++ b/include/lttng/tracepoint.h
> @@ -145,11 +145,16 @@ extern "C" {
>  #define _TP_ARGS_DATA_VAR(...)		_TP_DATA_VAR_N(_TP_NARGS(0, ##__VA_ARGS__), ##__VA_ARGS__)
>  #define _TP_PARAMS(...)			__VA_ARGS__
>  
> +/*
> + * The tracepoint cb is marked always inline so we can distinguish
> + * between caller's ip addresses within the probe using the return
> + * address.
> + */
>  #define _DECLARE_TRACEPOINT(_provider, _name, ...)			 		\
>  extern struct tracepoint __tracepoint_##_provider##___##_name;				\
> -static inline lttng_ust_notrace								\
> +static inline __attribute__((always_inline)) lttng_ust_notrace				\
>  void __tracepoint_cb_##_provider##___##_name(_TP_ARGS_PROTO(__VA_ARGS__));		\
> -static inline										\
> +static											\
>  void __tracepoint_cb_##_provider##___##_name(_TP_ARGS_PROTO(__VA_ARGS__))		\
>  {											\
>  	struct tracepoint_probe *__tp_probe;						\
> diff --git a/include/lttng/ust-abi.h b/include/lttng/ust-abi.h
> index df61cde..4cc138e 100644
> --- a/include/lttng/ust-abi.h
> +++ b/include/lttng/ust-abi.h
> @@ -137,6 +137,7 @@ enum lttng_ust_context_type {
>  	LTTNG_UST_CONTEXT_VPID			= 1,
>  	LTTNG_UST_CONTEXT_PTHREAD_ID		= 2,
>  	LTTNG_UST_CONTEXT_PROCNAME		= 3,
> +	LTTNG_UST_CONTEXT_IP			= 4,
>  };
>  
>  #define LTTNG_UST_CONTEXT_PADDING1	16
> diff --git a/include/lttng/ust-events.h b/include/lttng/ust-events.h
> index 329ed3a..f40c044 100644
> --- a/include/lttng/ust-events.h
> +++ b/include/lttng/ust-events.h
> @@ -565,6 +565,7 @@ int lttng_add_vtid_to_ctx(struct lttng_ctx **ctx);
>  int lttng_add_vpid_to_ctx(struct lttng_ctx **ctx);
>  int lttng_add_pthread_id_to_ctx(struct lttng_ctx **ctx);
>  int lttng_add_procname_to_ctx(struct lttng_ctx **ctx);
> +int lttng_add_ip_to_ctx(struct lttng_ctx **ctx);
>  void lttng_context_vtid_reset(void);
>  void lttng_context_vpid_reset(void);
>  
> diff --git a/include/lttng/ust-tracepoint-event.h b/include/lttng/ust-tracepoint-event.h
> index 777913a..bb3a05d 100644
> --- a/include/lttng/ust-tracepoint-event.h
> +++ b/include/lttng/ust-tracepoint-event.h
> @@ -533,6 +533,7 @@ void __event_probe__##_provider##___##_name(_TP_ARGS_DATA_PROTO(_args))	      \
>  	__event_align = __event_get_align__##_provider##___##_name(_TP_ARGS_VAR(_args)); \
>  	lib_ring_buffer_ctx_init(&__ctx, __chan->chan, __event, __event_len,  \
>  				 __event_align, -1, __chan->handle);	      \
> +	__ctx.ip = __builtin_return_address(0);				      \
>  	__ret = __chan->ops->event_reserve(&__ctx, __event->id);	      \
>  	if (__ret < 0)							      \
>  		return;							      \
> diff --git a/liblttng-ust/Makefile.am b/liblttng-ust/Makefile.am
> index bda7ee8..1e6401a 100644
> --- a/liblttng-ust/Makefile.am
> +++ b/liblttng-ust/Makefile.am
> @@ -25,6 +25,7 @@ liblttng_ust_runtime_la_SOURCES = \
>  	lttng-context-vpid.c \
>  	lttng-context-pthread-id.c \
>  	lttng-context-procname.c \
> +	lttng-context-ip.c \
>  	lttng-context.c \
>  	lttng-events.c \
>  	lttng-filter.c \
> diff --git a/liblttng-ust/lttng-context-ip.c b/liblttng-ust/lttng-context-ip.c
> new file mode 100644
> index 0000000..6f3edf8
> --- /dev/null
> +++ b/liblttng-ust/lttng-context-ip.c
> @@ -0,0 +1,73 @@
> +/*
> + * lttng-context-ip.c
> + *
> + * LTTng UST Instruction Pointer Context.
> + *
> + * Copyright (C) 2009-2012 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; only
> + * version 2.1 of the License.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + */
> +
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <lttng/ust-events.h>
> +#include <lttng/ust-tracer.h>
> +#include <lttng/ringbuffer-config.h>
> +
> +static
> +size_t ip_get_size(size_t offset)
> +{
> +	size_t size = 0;
> +
> +	size += lib_ring_buffer_align(offset, lttng_alignof(void *));
> +	size += sizeof(void *);
> +	return size;
> +}
> +
> +static
> +void ip_record(struct lttng_ctx_field *field,
> +		 struct lttng_ust_lib_ring_buffer_ctx *ctx,
> +		 struct lttng_channel *chan)
> +{
> +	void *ip;
> +
> +	ip = ctx->ip;
> +	lib_ring_buffer_align_ctx(ctx, lttng_alignof(ip));
> +	chan->ops->event_write(ctx, &ip, sizeof(ip));
> +}
> +
> +int lttng_add_ip_to_ctx(struct lttng_ctx **ctx)
> +{
> +	struct lttng_ctx_field *field;
> +
> +	field = lttng_append_context(ctx);
> +	if (!field)
> +		return -ENOMEM;
> +	if (lttng_find_context(*ctx, "ip")) {
> +		lttng_remove_context_field(ctx, field);
> +		return -EEXIST;
> +	}
> +	field->event_field.name = "ip";
> +	field->event_field.type.atype = atype_integer;
> +	field->event_field.type.u.basic.integer.size = sizeof(void *) * CHAR_BIT;
> +	field->event_field.type.u.basic.integer.alignment = lttng_alignof(void *) * CHAR_BIT;
> +	field->event_field.type.u.basic.integer.signedness = lttng_is_signed_type(void *);
> +	field->event_field.type.u.basic.integer.reverse_byte_order = 0;
> +	field->event_field.type.u.basic.integer.base = 16;
> +	field->event_field.type.u.basic.integer.encoding = lttng_encode_none;
> +	field->get_size = ip_get_size;
> +	field->record = ip_record;
> +	return 0;
> +}
> diff --git a/liblttng-ust/lttng-events.c b/liblttng-ust/lttng-events.c
> index 34c708f..26601a6 100644
> --- a/liblttng-ust/lttng-events.c
> +++ b/liblttng-ust/lttng-events.c
> @@ -740,6 +740,8 @@ int lttng_attach_context(struct lttng_ust_context *context_param,
>  		return lttng_add_vpid_to_ctx(ctx);
>  	case LTTNG_UST_CONTEXT_PROCNAME:
>  		return lttng_add_procname_to_ctx(ctx);
> +	case LTTNG_UST_CONTEXT_IP:
> +		return lttng_add_ip_to_ctx(ctx);
>  	default:
>  		return -EINVAL;
>  	}
> -- 
> 1.8.1.4
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
