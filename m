From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/1] Disable liblttng-ust-dl if dlinfo is
 not	available in C library.
Date: Mon, 7 Apr 2014 20:42:25 +0000 (UTC)
Message-ID: <794709247.8287.1396903345152.JavaMail.zimbra__1375.05906536735$1396903422$gmane$org@efficios.com>
References: <1396818161-20204-1-git-send-email-romain.naour@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1WXGNF-0002Hh-29
 for lttng-dev@lists.lttng.org; Mon, 07 Apr 2014 16:42:39 -0400
In-Reply-To: <1396818161-20204-1-git-send-email-romain.naour@openwide.fr>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Romain Naour <romain.naour@openwide.fr>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged into master and stable-2.4, thanks!

Mathieu

----- Original Message -----
> From: "Romain Naour" <romain.naour@openwide.fr>
> To: lttng-dev@lists.lttng.org
> Cc: "Romain Naour" <romain.naour@openwide.fr>
> Sent: Sunday, April 6, 2014 5:02:41 PM
> Subject: [lttng-dev] [PATCH 1/1] Disable liblttng-ust-dl if dlinfo is not	available in C library.
> 
> According to uClibc commit [1], dlinfo is not available.
> To be able to use LTTng UST with uClibc, we need to disable
> the Dynamic Linker Tracing functionality [2].
> 
> [1]
> http://git.uclibc.org/uClibc/commit/?id=f3c9dc499c5c787ddd8c4320f2d44d2ae6e40c22
> [2] http://lists.lttng.org/pipermail/lttng-dev/2014-February/022423.html
> 
> Signed-off-by: Romain Naour <romain.naour@openwide.fr>
> ---
>  Makefile.am  | 5 ++++-
>  configure.ac | 3 +++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile.am b/Makefile.am
> index b79d2dd..c907ff1 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -4,11 +4,14 @@ SUBDIRS = . include snprintf libringbuffer
> liblttng-ust-comm \
>  		liblttng-ust \
>  		liblttng-ust-ctl \
>  		liblttng-ust-fork \
> -		liblttng-ust-dl \
>  		liblttng-ust-libc-wrapper \
>  		liblttng-ust-cyg-profile \
>  		tools
>  
> +if HAVE_DLINFO
> +SUBDIRS += liblttng-ust-dl
> +endif
> +
>  if BUILD_JNI_INTERFACE
>  SUBDIRS += liblttng-ust-java liblttng-ust-jul
>  endif
> diff --git a/configure.ac b/configure.ac
> index b04d4e3..de6300e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -146,6 +146,9 @@ AC_C_INLINE
>  AC_FUNC_MALLOC
>  AC_CHECK_FUNCS([gettimeofday munmap socket strerror strtol sched_getcpu
>  sysconf])
>  
> +AC_CHECK_FUNCS([dlinfo])
> +AM_CONDITIONAL([HAVE_DLINFO], [test "${ac_cv_func_dlinfo}" = "yes"])
> +
>  CFLAGS="-Wall $CFLAGS"
>  
>  # URCU
> --
> 1.9.0
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
