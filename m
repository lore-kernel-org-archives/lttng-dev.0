From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: Wrong configure check for
 UST perf event counters context support
Date: Thu, 26 Jun 2014 15:53:52 +0000 (UTC)
Message-ID: <48769898.4925.1403798032029.JavaMail.zimbra__47213.1978640848$1403798101$gmane$org@efficios.com>
References: <1403797348-3958-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1X0Bzn-0000I5-Eb
 for lttng-dev@lists.lttng.org; Thu, 26 Jun 2014 11:54:01 -0400
In-Reply-To: <1403797348-3958-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

merged, thanks!

Mathieu

----- Original Message -----
> From: "Christian Babeux" <christian.babeux@efficios.com>
> To: lttng-dev@lists.lttng.org
> Cc: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>, "Christian Babeux" <christian.babeux@efficios.com>
> Sent: Thursday, June 26, 2014 11:42:28 AM
> Subject: [PATCH lttng-ust] Fix: Wrong configure check for UST perf event counters context support
> 
> When building on non-x86 platforms, the build errors out with the following:
> 
>   CC       lttng-context-perf-counters.lo
> lttng-context-perf-counters.c:95:2: error: #error "Perf event counters are
> only supported on x86 so far."
> lttng-context-perf-counters.c: In function 'read_perf_counter':
> lttng-context-perf-counters.c:114:4: warning: implicit declaration of
> function 'rdpmc' [-Wimplicit-function-declaration]
> make[2]: *** [lttng-context-perf-counters.lo] Error 1
> 
> The configure script checks for the presence of the "perf_event.h" header to
> enable support for
> perf events counters. However, the current implementation is only available
> on x86,
> hence the build fails on platform where the perf header is available.
> 
> Fix this issue by detecting the architecture we are currently building and
> wether
> to enable or not the support for perf event counters context.
> 
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  configure.ac | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 76851db..4841f46 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -194,9 +194,23 @@ AC_CHECK_LIB([urcu-bp], [call_rcu_bp], [],
> [AC_MSG_ERROR([liburcu 0.6 or newer i
>  
>  # optional linux/perf_event.h
>  AC_CHECK_HEADERS([linux/perf_event.h], [have_perf_event=yes], [])
> -AM_CONDITIONAL([HAVE_PERF_EVENT], [test "x$have_perf_event" = "xyes"])
>  
> -if test "x$have_perf_event" = "xyes"; then
> +# Perf event counters are only supported on x86 so far.
> +AC_MSG_CHECKING([UST support for architecture perf event counters])
> +case $host_cpu in
> +changequote(,)dnl
> +	i[3456]86)
> +changequote([,])dnl
> +	UST_SUPPORT_FOR_ARCH_PERF_EVENT_COUNTERS=yes;;
> +	x86_64) UST_SUPPORT_FOR_ARCH_PERF_EVENT_COUNTERS=yes;;
> +	amd64) UST_SUPPORT_FOR_ARCH_PERF_EVENT_COUNTERS=yes;;
> +	*) UST_SUPPORT_FOR_ARCH_PERF_EVENT_COUNTERS=no;;
> +esac
> +AC_MSG_RESULT([$UST_SUPPORT_FOR_ARCH_PERF_EVENT_COUNTERS])
> +
> +AM_CONDITIONAL([HAVE_PERF_EVENT], [test "x$have_perf_event" = "xyes" -a
> "x$UST_SUPPORT_FOR_ARCH_PERF_EVENT_COUNTERS" = "xyes"])
> +
> +if test "x$have_perf_event" = "xyes" -a
> "x$UST_SUPPORT_FOR_ARCH_PERF_EVENT_COUNTERS" = "xyes"; then
>  AC_DEFINE([LTTNG_UST_HAVE_PERF_EVENT], [1])
>  fi
>  
> --
> 1.9.3
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
