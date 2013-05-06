From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools 06/14] Adding signal compat in
 order to implement missing functions on Android
Date: Mon, 06 May 2013 15:08:46 -0400
Message-ID: <5187FFBE.2000305__21198.7099297859$1367867369$gmane$org@efficios.com>
References: <1367864331-15212-1-git-send-email-charlesbriere.flatzo@gmail.com>
	<1367864331-15212-6-git-send-email-charlesbriere.flatzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UZQmM-0000pA-1y
	for lttng-dev@lists.lttng.org; Mon, 06 May 2013 15:08:54 -0400
In-Reply-To: <1367864331-15212-6-git-send-email-charlesbriere.flatzo@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Charles Briere <charlesbriere.flatzo@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org



Charles Briere:
> Signed-off-by: Charles Briere <charlesbriere.flatzo@gmail.com>
> ---
>  src/common/compat/Makefile.am     |  3 ++-
>  src/common/compat/compat-signal.c | 14 ++++++++++++++
>  src/common/compat/signal.h        | 14 ++++++++++++++
>  src/common/consumer-timer.c       |  2 +-
>  src/common/runas.c                |  2 +-
>  5 files changed, 32 insertions(+), 3 deletions(-)
>  create mode 100644 src/common/compat/compat-signal.c
>  create mode 100644 src/common/compat/signal.h
> 
> diff --git a/src/common/compat/Makefile.am b/src/common/compat/Makefile.am
> index 537375b..124ef08 100644
> --- a/src/common/compat/Makefile.am
> +++ b/src/common/compat/Makefile.am
> @@ -9,4 +9,5 @@ COMPAT=compat-poll.c
>  endif
>  
>  libcompat_la_SOURCES = poll.h fcntl.h endian.h mman.h clone.h \
> -                       socket.h compat-fcntl.c uuid.h tid.h $(COMPAT)
> +                       socket.h compat-fcntl.c uuid.h tid.h \
> +                       compat-signal.c $(COMPAT)
> diff --git a/src/common/compat/compat-signal.c b/src/common/compat/compat-signal.c
> new file mode 100644
> index 0000000..aba30db
> --- /dev/null
> +++ b/src/common/compat/compat-signal.c

It does not seems that there is any license at the beginning of the file
(same for the header). Please check other files in compat/ and simply
copy the header and add your copyright.

> @@ -0,0 +1,14 @@
> +#include "signal.h"
> +#ifdef __ANDROID__
> +int __rt_sigtimedwait(const sigset_t *set, siginfo_t *info, const struct timespec *ts, long nr) {
> +  return syscall(__NR_rt_sigtimedwait, set, info, ts, nr);

This seems like a "two spaces" rather than a tab. The whole code base
uses tabs.

Thanks!
David

> +}
> +
> +int sigtimedwait(const sigset_t *set, siginfo_t *info, const struct timespec *ts) {
> +  return __rt_sigtimedwait(set,info,ts,_NSIG/8);
> +}
> +
> +int sigwaitinfo(const sigset_t *set, siginfo_t *info) {
> +  return sigtimedwait(set, info, NULL);
> +}
> +#endif
> diff --git a/src/common/compat/signal.h b/src/common/compat/signal.h
> new file mode 100644
> index 0000000..f7251d3
> --- /dev/null
> +++ b/src/common/compat/signal.h
> @@ -0,0 +1,14 @@
> +#ifndef LTTNG_COMPAT_SIGNAL_H
> +#define LTTNG_COMPAT_SIGNAL_H
> +
> +#include <signal.h>
> +#ifdef __ANDROID__
> +#include <sys/syscall.h>
> +#include <asm/unistd.h>
> +#include <linux/time.h>
> +int __rt_sigtimedwait(const sigset_t *set, siginfo_t *info, const struct timespec *ts, long nr);
> +int sigtimedwait(const sigset_t *set, siginfo_t *info, const struct timespec *ts);
> +int sigwaitinfo(const sigset_t *set, siginfo_t *info);
> +#endif // __ANDROID__
> +
> +#endif //LTTNG_COMPAT_SIGNAL_H
> diff --git a/src/common/consumer-timer.c b/src/common/consumer-timer.c
> index ef056d1..0ae369f 100644
> --- a/src/common/consumer-timer.c
> +++ b/src/common/consumer-timer.c
> @@ -19,8 +19,8 @@
>  #define _GNU_SOURCE
>  #include <assert.h>
>  #include <inttypes.h>
> -#include <signal.h>
>  
> +#include <common/compat/signal.h>
>  #include <common/common.h>
>  
>  #include "consumer-timer.h"
> diff --git a/src/common/runas.c b/src/common/runas.c
> index bd51cd4..0317cba 100644
> --- a/src/common/runas.c
> +++ b/src/common/runas.c
> @@ -28,12 +28,12 @@
>  #include <unistd.h>
>  #include <fcntl.h>
>  #include <sched.h>
> -#include <sys/signal.h>
>  
>  #include <common/common.h>
>  #include <common/utils.h>
>  #include <common/compat/mman.h>
>  #include <common/compat/clone.h>
> +#include <common/compat/signal.h>
>  
>  #include "runas.h"
>  
