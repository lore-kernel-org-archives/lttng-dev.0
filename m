From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 lttng-tools] Backported to glibc 2.8
Date: Wed, 23 Apr 2014 08:33:10 +0000 (UTC)
Message-ID: <331505440.5719.1398241990150.JavaMail.zimbra__36032.5885857039$1398242066$gmane$org@efficios.com>
References: <20140410193412.GB28773@dalia>
 <1397855673-5758-1-git-send-email-jderehag@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1WcscG-0004nU-Al
 for lttng-dev@lists.lttng.org; Wed, 23 Apr 2014 04:33:21 -0400
In-Reply-To: <1397855673-5758-1-git-send-email-jderehag@hotmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jesper Derehag <jderehag@hotmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Jesper Derehag" <jderehag@hotmail.com>
> To: dgoulet@efficios.com
> Cc: lttng-dev@lists.lttng.org
> Sent: Friday, April 18, 2014 11:14:33 PM
> Subject: [lttng-dev] [PATCH v2 lttng-tools] Backported to glibc 2.8
> 
> This patch enables lttng-tools to run on top of glibc 2.8.
> Overall it fixes 2 things:
> 1. No support for epoll_create1(..) and EPOLL_CLOEXEC.
> 2. No support for htobe/betoh
> 
> For 1, we revert back to epoll_create() and then sets CLOEXEC
> through fcntl instead.
> For 2, we define htobe/betoh as part of the compat/endian.h
> and make sure that any users of those functions actually
> include compat/endian.h instead of implicit include of
> system endian.h

Hi Jesper,

The coding style comments I gave for the endianness support
in Babeltrace (mainly style of comments) also apply to this
patch.

Thanks,

Mathieu

> 
> Signed-off-by: Jesper Derehag <jderehag@hotmail.com>
> Tested-by: Jesper Derehag <jderehag@hotmail.com>
> ---
>  src/bin/lttng-relayd/cmd-2-2.c               |  2 +
>  src/bin/lttng-relayd/cmd-2-4.c               |  2 +
>  src/bin/lttng-relayd/live.c                  |  1 +
>  src/bin/lttng-relayd/main.c                  |  1 +
>  src/bin/lttng-sessiond/jul-thread.c          |  2 +
>  src/bin/lttng-sessiond/jul.c                 |  2 +
>  src/common/compat/compat-epoll.c             |  2 +-
>  src/common/compat/endian.h                   | 92
>  +++++++++++++++++++++++++++-
>  src/common/compat/poll.h                     | 29 +++++++++
>  src/common/consumer-timer.c                  |  1 +
>  src/common/consumer.c                        |  1 +
>  src/common/index/index.c                     |  1 +
>  src/common/kernel-consumer/kernel-consumer.c |  1 +
>  src/common/relayd/relayd.c                   |  1 +
>  src/common/ust-consumer/ust-consumer.c       |  1 +
>  tests/regression/tools/live/live_test.c      |  2 +
>  16 files changed, 139 insertions(+), 2 deletions(-)
> 
> diff --git a/src/bin/lttng-relayd/cmd-2-2.c b/src/bin/lttng-relayd/cmd-2-2.c
> index b7299a5..978a11e 100644
> --- a/src/bin/lttng-relayd/cmd-2-2.c
> +++ b/src/bin/lttng-relayd/cmd-2-2.c
> @@ -23,6 +23,8 @@
>  #include <common/common.h>
>  #include <common/sessiond-comm/relayd.h>
>  
> +#include <common/compat/endian.h>
> +
>  #include "cmd-generic.h"
>  #include "cmd-2-1.h"
>  #include "utils.h"
> diff --git a/src/bin/lttng-relayd/cmd-2-4.c b/src/bin/lttng-relayd/cmd-2-4.c
> index 3196383..6d927a0 100644
> --- a/src/bin/lttng-relayd/cmd-2-4.c
> +++ b/src/bin/lttng-relayd/cmd-2-4.c
> @@ -23,6 +23,8 @@
>  #include <common/common.h>
>  #include <common/sessiond-comm/relayd.h>
>  
> +#include <common/compat/endian.h>
> +
>  #include "cmd-generic.h"
>  #include "lttng-relayd.h"
>  
> diff --git a/src/bin/lttng-relayd/live.c b/src/bin/lttng-relayd/live.c
> index c60f7e4..d8517d2 100644
> --- a/src/bin/lttng-relayd/live.c
> +++ b/src/bin/lttng-relayd/live.c
> @@ -43,6 +43,7 @@
>  #include <common/common.h>
>  #include <common/compat/poll.h>
>  #include <common/compat/socket.h>
> +#include <common/compat/endian.h>
>  #include <common/defaults.h>
>  #include <common/futex.h>
>  #include <common/index/index.h>
> diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
> index a93151a..93b08fc 100644
> --- a/src/bin/lttng-relayd/main.c
> +++ b/src/bin/lttng-relayd/main.c
> @@ -44,6 +44,7 @@
>  #include <common/common.h>
>  #include <common/compat/poll.h>
>  #include <common/compat/socket.h>
> +#include <common/compat/endian.h>
>  #include <common/defaults.h>
>  #include <common/daemonize.h>
>  #include <common/futex.h>
> diff --git a/src/bin/lttng-sessiond/jul-thread.c
> b/src/bin/lttng-sessiond/jul-thread.c
> index cc694df..9859a10 100644
> --- a/src/bin/lttng-sessiond/jul-thread.c
> +++ b/src/bin/lttng-sessiond/jul-thread.c
> @@ -23,6 +23,8 @@
>  #include <common/uri.h>
>  #include <common/utils.h>
>  
> +#include <common/compat/endian.h>
> +
>  #include "fd-limit.h"
>  #include "jul-thread.h"
>  #include "lttng-sessiond.h"
> diff --git a/src/bin/lttng-sessiond/jul.c b/src/bin/lttng-sessiond/jul.c
> index 7bb0d75..da4cf67 100644
> --- a/src/bin/lttng-sessiond/jul.c
> +++ b/src/bin/lttng-sessiond/jul.c
> @@ -22,6 +22,8 @@
>  #include <common/common.h>
>  #include <common/sessiond-comm/jul.h>
>  
> +#include <common/compat/endian.h>
> +
>  #include "jul.h"
>  #include "ust-app.h"
>  #include "utils.h"
> diff --git a/src/common/compat/compat-epoll.c
> b/src/common/compat/compat-epoll.c
> index ecd09a0..368fae1 100644
> --- a/src/common/compat/compat-epoll.c
> +++ b/src/common/compat/compat-epoll.c
> @@ -81,7 +81,7 @@ int compat_epoll_create(struct lttng_poll_event *events,
> int size, int flags)
>  		size = poll_max_size;
>  	}
>  
> -	ret = epoll_create1(flags);
> +	ret = compat_glibc_epoll_create(size, flags);
>  	if (ret < 0) {
>  		/* At this point, every error is fatal */
>  		PERROR("epoll_create1");
> diff --git a/src/common/compat/endian.h b/src/common/compat/endian.h
> index 2850866..3b18ca3 100644
> --- a/src/common/compat/endian.h
> +++ b/src/common/compat/endian.h
> @@ -15,11 +15,101 @@
>   * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>   */
>  
> -#ifdef _COMPAT_ENDIAN_H
> +#ifndef _COMPAT_ENDIAN_H
>  #define _COMPAT_ENDIAN_H
>  
>  #ifdef __linux__
>  #include <endian.h>
> +
> +/* htobe/betoh are not defined for glibc <2.9, so add them
> + * explicitly if they are missing */
> +#ifdef __USE_BSD
> +/* Conversion interfaces.  */
> +# include <byteswap.h>
> +
> +# if __BYTE_ORDER == __LITTLE_ENDIAN
> +#  ifndef htobe16
> +#   define htobe16(x) __bswap_16(x)
> +#  endif
> +#  ifndef htole16
> +#   define htole16(x) (x)
> +#  endif
> +#  ifndef be16toh
> +#   define be16toh(x) __bswap_16(x)
> +#  endif
> +#  ifndef le16toh
> +#   define le16toh(x) (x)
> +#  endif
> +
> +#  ifndef htobe32
> +#   define htobe32(x) __bswap_32(x)
> +#  endif
> +#  ifndef htole32
> +#   define htole32(x) (x)
> +#  endif
> +#  ifndef be32toh
> +#   define be32toh(x) __bswap_32(x)
> +#  endif
> +#  ifndef le32toh
> +#   define le32toh(x) (x)
> +#  endif
> +
> +#  ifndef htobe64
> +#   define htobe64(x) __bswap_64(x)
> +#  endif
> +#  ifndef htole64
> +#   define htole64(x) (x)
> +#  endif
> +#  ifndef be64toh
> +#   define be64toh(x) __bswap_64(x)
> +#  endif
> +#  ifndef le64toh
> +#   define le64toh(x) (x)
> +#  endif
> +
> +# else /* __BYTE_ORDER == __LITTLE_ENDIAN */
> +#  ifndef htobe16
> +#   define htobe16(x) (x)
> +#  endif
> +#  ifndef htole16
> +#   define htole16(x) __bswap_16(x)
> +#  endif
> +#  ifndef be16toh
> +#   define be16toh(x) (x)
> +#  endif
> +#  ifndef le16toh
> +#   define le16toh(x) __bswap_16(x)
> +#  endif
> +
> +#  ifndef htobe32
> +#   define htobe32(x) (x)
> +#  endif
> +#  ifndef htole32
> +#   define htole32(x) __bswap_32(x)
> +#  endif
> +#  ifndef be32toh
> +#   define be32toh(x) (x)
> +#  endif
> +#  ifndef le32toh
> +#   define le32toh(x) __bswap_32(x)
> +#  endif
> +
> +#  ifndef htobe64
> +#   define htobe64(x) (x)
> +#  endif
> +#  ifndef htole64
> +#   define htole64(x) __bswap_64(x)
> +#  endif
> +#  ifndef be64toh
> +#   define be64toh(x) (x)
> +#  endif
> +#  ifndef le64toh
> +#   define le64toh(x) __bswap_64(x)
> +#  endif
> +
> +# endif /* __BYTE_ORDER == __LITTLE_ENDIAN */
> +#endif /* __USE_BSD */
> +
>  #elif defined(__FreeBSD__)
>  #include <machine/endian.h>
>  #else
> diff --git a/src/common/compat/poll.h b/src/common/compat/poll.h
> index b019b42..90fe813 100644
> --- a/src/common/compat/poll.h
> +++ b/src/common/compat/poll.h
> @@ -52,6 +52,8 @@ static inline void __lttng_poll_free(void *events)
>  #ifdef HAVE_EPOLL
>  #include <sys/epoll.h>
>  #include <stdio.h>
> +#include <features.h>
> +#include <common/compat/fcntl.h>
>  
>  /* See man epoll(7) for this define path */
>  #define COMPAT_EPOLL_PROC_PATH "/proc/sys/fs/epoll/max_user_watches"
> @@ -71,7 +73,15 @@ enum {
>  	LPOLLNVAL = EPOLLHUP,
>  	LPOLLRDHUP = EPOLLRDHUP,
>  	/* Close on exec feature of epoll */
> +#if __GLIBC_PREREQ(2, 9)
>  	LTTNG_CLOEXEC = EPOLL_CLOEXEC,
> +#else
> +	/* EPOLL_CLOEXEC was added in glibc 2.8 (usually used in conjunction
> +	 * with epoll_create1(..)), but since neither EPOLL_CLOEXEC exists nor
> +	 * epoll_create1(..), we set it to FD_CLOEXEC so that we can pass it
> +	 * directly to fcntl(..) instead */
> +	LTTNG_CLOEXEC = FD_CLOEXEC,
> +#endif
>  };
>  
>  struct compat_epoll_event {
> @@ -115,6 +125,25 @@ extern int compat_epoll_create(struct lttng_poll_event
> *events,
>  #define lttng_poll_create(events, size, flags) \
>  	compat_epoll_create(events, size, flags)
>  
> +#if __GLIBC_PREREQ(2, 9)
> +static inline int compat_glibc_epoll_create(int size
> __attribute__((unused)),
> +		int flags)
> +{
> +	return epoll_create1(flags);
> +}
> +#else
> +static inline int compat_glibc_epoll_create(int size, int flags)
> +{
> +	/* epoll_create1 was added in glibc 2.9, but unfortunatly reverting to
> +	 * epoll_create(..) also means that we loose the possibility to
> +	 * directly set the EPOLL_CLOEXEC, so try and do it anyway but through
> +	 * fcntl(..). */
> +	int efd = epoll_create(size);
> +	assert(fcntl(efd, F_SETFD, flags) != -1);
> +	return efd;
> +}
> +#endif
> +
>  /*
>   * Wait on epoll set with the number of fd registered to the
>   lttng_poll_event
>   * data structure (events).
> diff --git a/src/common/consumer-timer.c b/src/common/consumer-timer.c
> index dc6f2f7..c659bf6 100644
> --- a/src/common/consumer-timer.c
> +++ b/src/common/consumer-timer.c
> @@ -23,6 +23,7 @@
>  
>  #include <bin/lttng-consumerd/health-consumerd.h>
>  #include <common/common.h>
> +#include <common/compat/endian.h>
>  #include <common/kernel-ctl/kernel-ctl.h>
>  #include <common/kernel-consumer/kernel-consumer.h>
>  #include <common/consumer-stream.h>
> diff --git a/src/common/consumer.c b/src/common/consumer.c
> index e80ac6b..cba4a60 100644
> --- a/src/common/consumer.c
> +++ b/src/common/consumer.c
> @@ -34,6 +34,7 @@
>  #include <common/common.h>
>  #include <common/utils.h>
>  #include <common/compat/poll.h>
> +#include <common/compat/endian.h>
>  #include <common/index/index.h>
>  #include <common/kernel-ctl/kernel-ctl.h>
>  #include <common/sessiond-comm/relayd.h>
> diff --git a/src/common/index/index.c b/src/common/index/index.c
> index abc0985..a462a63 100644
> --- a/src/common/index/index.c
> +++ b/src/common/index/index.c
> @@ -24,6 +24,7 @@
>  
>  #include <common/common.h>
>  #include <common/defaults.h>
> +#include <common/compat/endian.h>
>  #include <common/utils.h>
>  
>  #include "index.h"
> diff --git a/src/common/kernel-consumer/kernel-consumer.c
> b/src/common/kernel-consumer/kernel-consumer.c
> index d15329f..57dc2ba 100644
> --- a/src/common/kernel-consumer/kernel-consumer.c
> +++ b/src/common/kernel-consumer/kernel-consumer.c
> @@ -35,6 +35,7 @@
>  #include <common/sessiond-comm/sessiond-comm.h>
>  #include <common/sessiond-comm/relayd.h>
>  #include <common/compat/fcntl.h>
> +#include <common/compat/endian.h>
>  #include <common/pipe.h>
>  #include <common/relayd/relayd.h>
>  #include <common/utils.h>
> diff --git a/src/common/relayd/relayd.c b/src/common/relayd/relayd.c
> index 3de19c2..38ebdbd 100644
> --- a/src/common/relayd/relayd.c
> +++ b/src/common/relayd/relayd.c
> @@ -25,6 +25,7 @@
>  
>  #include <common/common.h>
>  #include <common/defaults.h>
> +#include <common/compat/endian.h>
>  #include <common/sessiond-comm/relayd.h>
>  #include <common/index/ctf-index.h>
>  
> diff --git a/src/common/ust-consumer/ust-consumer.c
> b/src/common/ust-consumer/ust-consumer.c
> index 9f2e739..b8c1a3c 100644
> --- a/src/common/ust-consumer/ust-consumer.c
> +++ b/src/common/ust-consumer/ust-consumer.c
> @@ -37,6 +37,7 @@
>  #include <common/sessiond-comm/sessiond-comm.h>
>  #include <common/relayd/relayd.h>
>  #include <common/compat/fcntl.h>
> +#include <common/compat/endian.h>
>  #include <common/consumer-metadata-cache.h>
>  #include <common/consumer-stream.h>
>  #include <common/consumer-timer.h>
> diff --git a/tests/regression/tools/live/live_test.c
> b/tests/regression/tools/live/live_test.c
> index aff8977..d2c9050 100644
> --- a/tests/regression/tools/live/live_test.c
> +++ b/tests/regression/tools/live/live_test.c
> @@ -43,6 +43,8 @@
>  #include <bin/lttng-relayd/lttng-viewer-abi.h>
>  #include <common/index/ctf-index.h>
>  
> +#include <common/compat/endian.h>
> +
>  #define SESSION1 "test1"
>  #define RELAYD_URL "net://localhost"
>  #define LIVE_TIMER 2000000
> --
> 1.9.1
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
