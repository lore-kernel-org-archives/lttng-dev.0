From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH liburcu 2/2] Check for pthread in Libc
Date: Mon, 2 Dec 2013 05:54:58 +0000 (UTC)
Message-ID: <1937844089.78319.1385963698054.JavaMail.zimbra__337.140277452086$1386016514$gmane$org@efficios.com>
References: <1385949650-16725-1-git-send-email-charlesbriere.flatzo@gmail.com>
	<1385949650-16725-2-git-send-email-charlesbriere.flatzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VnMTF-0002K8-0Z
	for lttng-dev@lists.lttng.org; Mon, 02 Dec 2013 00:55:04 -0500
In-Reply-To: <1385949650-16725-2-git-send-email-charlesbriere.flatzo@gmail.com>
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

Both patches merged, thanks!

Mathieu

----- Original Message -----
> From: "Charles Briere" <charlesbriere.flatzo@gmail.com>
> To: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org, "Charles Briere" <charlesbriere.flatzo@gmail.com>
> Sent: Monday, December 2, 2013 3:00:50 AM
> Subject: [PATCH liburcu 2/2] Check for pthread in Libc
> 
> Some libc like Googles's Bionic for
> Android include pThread. Instead of checking
> for Android as in commit 58a052effb2305655ff1b7233c78ab24fc25257e
> this patch checks for pthread in libc as proposed
> by Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> Signed-off-by: Charles Briere <charlesbriere.flatzo@gmail.com>
> ---
>  Makefile.am                  | 2 +-
>  configure.ac                 | 9 +++++++++
>  tests/benchmark/Makefile.am  | 2 +-
>  tests/regression/Makefile.am | 2 +-
>  tests/unit/Makefile.am       | 2 +-
>  5 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/Makefile.am b/Makefile.am
> index 938027c..2f81bce 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -5,7 +5,7 @@ INCLUDES = -I$(top_builddir)/urcu
>  #Add the -version-info directly here since we are only building
>  # library that use the version-info
>  AM_LDFLAGS=-version-info $(URCU_LIBRARY_VERSION)
> -if !TARGET_IS_ANDROID
> +if !LIBC_INCLUDES_PTHREAD
>  AM_LDFLAGS+=-lpthread
>  endif
>  AM_CFLAGS=-Wall
> diff --git a/configure.ac b/configure.ac
> index 38e39e1..774094e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -165,6 +165,15 @@ AC_COMPILE_IFELSE([AC_LANG_SOURCE([[
>  	compat_futex_test=1
>  ])
>  
> +# Check for pthread
> +AC_CHECK_LIB([pthread], [pthread_create],
> +	[AM_CONDITIONAL(LIBC_INCLUDES_PTHREAD, false)],
> +	[AC_CHECK_LIB([c], [pthread_create],
> +		[AM_CONDITIONAL(LIBC_INCLUDES_PTHREAD, true)],
> +		[AC_MSG_ERROR([Cannot find libpthread. Use [LDFLAGS]=-Ldir to specify its
> location.])]
> +	)]
> +)
> +
>  AM_CONDITIONAL([COMPAT_FUTEX], [test "x$compat_futex_test" = "x1"])
>  AM_CONDITIONAL([COMPAT_ARCH], [test "x$SUBARCHTYPE" = "xx86compat"])
>  AM_CONDITIONAL([NO_SHARED], [test "x$enable_shared" = "xno"])
> diff --git a/tests/benchmark/Makefile.am b/tests/benchmark/Makefile.am
> index bf02189..e889f88 100644
> --- a/tests/benchmark/Makefile.am
> +++ b/tests/benchmark/Makefile.am
> @@ -1,4 +1,4 @@
> -if !TARGET_IS_ANDROID
> +if !LIBC_INCLUDES_PTHREAD
>  AM_LDFLAGS=-lpthread
>  endif
>  AM_CFLAGS=-I$(top_srcdir) -I$(top_builddir) -I$(top_srcdir)/tests/common -g
> diff --git a/tests/regression/Makefile.am b/tests/regression/Makefile.am
> index eb15699..80cb1bc 100644
> --- a/tests/regression/Makefile.am
> +++ b/tests/regression/Makefile.am
> @@ -1,4 +1,4 @@
> -if !TARGET_IS_ANDROID
> +if !LIBC_INCLUDES_PTHREAD
>  AM_LDFLAGS=-lpthread
>  endif
>  AM_CFLAGS=-I$(top_srcdir) -I$(top_builddir) -I$(top_srcdir)/tests/common -g
> diff --git a/tests/unit/Makefile.am b/tests/unit/Makefile.am
> index 2c89ca6..9efd74e 100644
> --- a/tests/unit/Makefile.am
> +++ b/tests/unit/Makefile.am
> @@ -1,4 +1,4 @@
> -if !TARGET_IS_ANDROID
> +if !LIBC_INCLUDES_PTHREAD
>  AM_LDFLAGS=-lpthread
>  endif
>  AM_CFLAGS=-I$(top_srcdir) -I$(top_builddir) -I$(top_srcdir)/tests/common -g
> --
> 1.8.4.2
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
