From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools 02/14] Added a low-level endian
 conversion function check in configure.ac to add support for systems where
 only BSD-like 'betoh*(...)' functions are available (such as Android when
 compiling with Bionic).
Date: Mon, 06 May 2013 15:04:40 -0400
Message-ID: <5187FEC8.4030707__18324.2738050923$1367867129$gmane$org@efficios.com>
References: <1367864331-15212-1-git-send-email-charlesbriere.flatzo@gmail.com>
	<1367864331-15212-2-git-send-email-charlesbriere.flatzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UZQiP-0000kp-0J
	for lttng-dev@lists.lttng.org; Mon, 06 May 2013 15:04:49 -0400
In-Reply-To: <1367864331-15212-2-git-send-email-charlesbriere.flatzo@gmail.com>
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
> From: Pierre-Luc St-Charles <pierre-luc.st-charles@polymtl.ca>
> 
> Signed-off-by: Pierre-Luc St-Charles <pierre-luc.st-charles@polymtl.ca>
> ---
>  configure.ac                   | 10 ++++++++++
>  src/bin/lttng-relayd/cmd-2-2.c |  1 +
>  src/bin/lttng-relayd/main.c    |  1 +
>  src/common/compat/endian.h     |  6 +++++-
>  src/common/relayd/relayd.c     |  1 +
>  5 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index eee025a..618d203 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -123,6 +123,16 @@ AC_CHECK_LIB([pthread], [pthread_create], [],
>  ]
>  )
>  
> +# Check low-level endian compat functions
> +AC_CHECK_DECL(be64toh, [], 
> +[
> +	AC_CHECK_DECL(betoh64, [AC_DEFINE_UNQUOTED([LTTNG_HAVE_BETOH64], 1, [Has BSD-style endian conversion operations.])], 
> +	[
> +		AC_MSG_ERROR([Cannot find be64toh, betoh64 or any similar functions.])
> +	])
> +]
> +)
> +
>  # Check libpopt
>  AC_CHECK_LIB([popt], [poptGetContext], [],
>  [
> diff --git a/src/bin/lttng-relayd/cmd-2-2.c b/src/bin/lttng-relayd/cmd-2-2.c
> index 0450fbf..09ff7f5 100644
> --- a/src/bin/lttng-relayd/cmd-2-2.c
> +++ b/src/bin/lttng-relayd/cmd-2-2.c
> @@ -22,6 +22,7 @@
>  
>  #include <common/common.h>
>  #include <common/sessiond-comm/relayd.h>
> +#include <common/compat/endian.h>
>  
>  #include "cmd-generic.h"
>  #include "cmd-2-1.h"
> diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
> index 9a2b3bd..0bf3ead 100644
> --- a/src/bin/lttng-relayd/main.c
> +++ b/src/bin/lttng-relayd/main.c
> @@ -43,6 +43,7 @@
>  #include <common/common.h>
>  #include <common/compat/poll.h>
>  #include <common/compat/socket.h>
> +#include <common/compat/endian.h>
>  #include <common/defaults.h>
>  #include <common/futex.h>
>  #include <common/sessiond-comm/sessiond-comm.h>
> diff --git a/src/common/compat/endian.h b/src/common/compat/endian.h
> index 2850866..b7f66cc 100644
> --- a/src/common/compat/endian.h
> +++ b/src/common/compat/endian.h
> @@ -15,11 +15,15 @@
>   * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>   */
>  
> -#ifdef _COMPAT_ENDIAN_H
> +#ifndef _COMPAT_ENDIAN_H
>  #define _COMPAT_ENDIAN_H
>  
>  #ifdef __linux__
>  #include <endian.h>
> +#ifdef LTTNG_HAVE_BETOH64
> +#define be64toh(x) betoh64(x)
> +#define be32toh(x) betoh32(x)
> +#endif // LTTNG_HAVE_BETOH64

Please don't use "//" for comments and instead use /* */.

It's used in some other patches so I'll only flag it once.

Thanks!

>  #elif defined(__FreeBSD__)
>  #include <machine/endian.h>
>  #else
> diff --git a/src/common/relayd/relayd.c b/src/common/relayd/relayd.c
> index 82bcf5f..ba7bd13 100644
> --- a/src/common/relayd/relayd.c
> +++ b/src/common/relayd/relayd.c
> @@ -26,6 +26,7 @@
>  #include <common/common.h>
>  #include <common/defaults.h>
>  #include <common/sessiond-comm/relayd.h>
> +#include <common/compat/endian.h>
>  
>  #include "relayd.h"
>  
