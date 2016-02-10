From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Fix: configure.ac: check for possibly
 required	libs for clock_gettime
Date: Wed, 10 Feb 2016 13:22:35 +0000 (UTC)
Message-ID: <1742228155.15854.1455110555482.JavaMail.zimbra__40842.2812390656$1455110641$gmane$org@efficios.com>
References: <1455097190-11550-1-git-send-email-olofjn@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aTUjG-0007CW-T7
 for lttng-dev@lists.lttng.org; Wed, 10 Feb 2016 08:22:51 -0500
In-Reply-To: <1455097190-11550-1-git-send-email-olofjn@axis.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Olof Johansson <olof.johansson@axis.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

Merged into urcu master, and stable-0.9 branches.

Please use [PATCH urcu] in the title next time for patches on lttng-dev.
it makes it easier for us to know against which project the patch should
be applied.

Thanks!

Mathieu

----- On Feb 10, 2016, at 4:39 AM, Olof Johansson olof.johansson@axis.com wrote:

> From: Olof Johansson <olof.johansson@axis.com>
> 
> On some platforms, you have to link with rt to get clock_gettime. This
> solves errors like:
> 
> undefined reference to `clock_gettime'
> 
> Fixes: #996
> 
> Signed-off-by: Olof Johansson <olof.johansson@axis.com>
> ---
> configure.ac | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 39a7777..c3cf60e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -79,7 +79,6 @@ AC_FUNC_MMAP
> AC_FUNC_FORK
> AC_CHECK_FUNCS([ \
> 	atexit \
> -	clock_gettime \
> 	getcpuid \
> 	gettid \
> 	gettimeofday \
> @@ -215,6 +214,11 @@ AC_COMPILE_IFELSE([AC_LANG_SOURCE([[
> 	compat_futex_test=1
> ])
> 
> +# Search for clock_gettime
> +AC_SEARCH_LIBS([clock_gettime], [rt], [],
> +	[AC_MSG_ERROR([Cannot find clock_gettime function.])]
> +)
> +
> # Check for pthread
> AC_CHECK_LIB([pthread], [pthread_create],
> 	[AM_CONDITIONAL(LIBC_INCLUDES_PTHREAD, false)],
> --
> 2.1.4
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
