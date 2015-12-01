From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: [PATCH urcu] Fix CPU_{SET,
 ZERO} configure checks when using -Werror
Date: Tue, 1 Dec 2015 15:45:40 -0500
Message-ID: <CAFXXi0ms8ahr203nCrWCB97x7NZc7YCQ7XwUaDgJ9gb4hB9THg__14503.6648995758$1449002865$gmane$org@mail.gmail.com>
References: <1448987994-18920-1-git-send-email-simon.marchi@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <thundersim@gmail.com>) id 1a3roW-00079O-1s
 for lttng-dev@lists.lttng.org; Tue, 01 Dec 2015 15:46:20 -0500
Received: by qgcc31 with SMTP id c31so15987211qgc.3
 for <lttng-dev@lists.lttng.org>; Tue, 01 Dec 2015 12:46:10 -0800 (PST)
In-Reply-To: <1448987994-18920-1-git-send-email-simon.marchi@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, didier.nadeau@polymtl.ca
List-Id: lttng-dev@lists.lttng.org

On 1 December 2015 at 11:39, Simon Marchi <simon.marchi@ericsson.com> wrote:
> I noticed a build failure in the tests when building with
> CFLAGS="-Werror".
>
>   In file included from test_urcu.c:38:0:
>   ../../tests/common/cpuset.h:38:0: error: "CPU_ZERO" redefined [-Werror]
>    # define CPU_ZERO(cpuset) do { *(cpuset) = 0; } while(0)
>    ^
>   In file included from /usr/include/pthread.h:23:0,
>                    from test_urcu.c:26:
>   /usr/include/sched.h:82:0: note: this is the location of the previous definition
>    # define CPU_ZERO(cpusetp)  __CPU_ZERO_S (sizeof (cpu_set_t), cpusetp)
>    ^
>
> The reason is that the configure check for CPU_ZERO (and CPU_SET) fails,
> because of a redefinition of _GNU_SOURCE:
>
>   configure:14733: checking whether CPU_ZERO works
>   configure:14749: gcc -std=gnu99 -c -Werror -pthread -D_GNU_SOURCE conftest.c >&5
>   conftest.c:61:0: error: "_GNU_SOURCE" redefined [-Werror]
>      #define _GNU_SOURCE
>    ^
>   conftest.c:24:0: note: this is the location of the previous definition
>    #define _GNU_SOURCE 1
>    ^
>   cc1: all warnings being treated as errors
>
> _GNU_SOURCE is defined 3 times in total:
>
>  1. On the command line with -D_GNU_SOURCE (which is equivalent to
>     #define _GNU_SOURCE 1):
>
>       CFLAGS="$CFLAGS -D_GNU_SOURCE"
>
>  2. By autoconf through AC_USE_SYSTEM_EXTENSIONS, introduced recently
>
>       https://www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.69/html_node/Posix-Variants.html#Posix-Variants
>
>  3. In the actual test code:
>
>       #define _GNU_SOURCE
>       #include <sched.h>
>       int main()
>       {
>               cpu_set_t foo; CPU_ZERO(&foo);
>               return 0;
>       }
>
> Possible fix #1:
>
> Change "#define _GNU_SOURCE" to "#define _GNU_SOURCE 1" in the test
> code.  Because redefinitions of macros with the same value are allowed,
> the error would disappear and everybody would be happy.
>
> Possible fix #2:
>
> Remove "#define _GNU_SOURCE" from the test code.  It is redundant to add
> it to CFLAGS for the lifetime of these checks, and also define it in the
> code.  That would also make everybody happy.
>
> Possible fix #3:
>
> Remove both -D_GNU_SOURCE from CFLAGS and "#define _GNU_SOURCE" from the
> test code.  AC_USE_SYSTEM_EXTENSIONS is made for exactly that, setting
> the macros that enable the quirks specific to each platform.  On non-GNU
> platforms, the macro is irrelevant anyway.  This would make everybody
> happy as well.
>
> Personally, I prefer #3.  That allows to remove the saved_CFLAGS thing,
> which is error-prone.
>
> This change was tested on Ubuntu 14.04 x86-64, with autoconf 2.69-6.
> It should ideally be tested on non-GNU platforms (which I don't easily
> have access to).  However, not defining _GNU_SOURCE on those platforms
> shouldn't break too many things.
> ---
>  configure.ac | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index e7e300b..0921874 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -264,8 +264,8 @@ AS_IF([test "x$def_smp_support" = "xyes"], [AC_DEFINE([CONFIG_RCU_SMP], [1])])
>  # Since we define _GNU_SOURCE in the sources, must do so too in the
>  # autoconf tests, as defining _GNU_SOURCE or not exposes
>  # sched_setaffinity bits differently.
> -saved_CFLAGS=$CFLAGS
> -CFLAGS="$CFLAGS -D_GNU_SOURCE"
> +#
> +# This is done through the autoconf macro AC_USE_SYSTEM_EXTENSIONS.
>
>  AC_CHECK_TYPES([cpu_set_t],
>         [have_cpu_set_t="yes"],
> @@ -276,7 +276,6 @@ AC_CHECK_TYPES([cpu_set_t],
>  AC_MSG_CHECKING([whether CPU_ZERO works])
>  AH_TEMPLATE([HAVE_CPU_ZERO], [Defined to 1 if we have CPU_ZERO and it works])
>  AC_COMPILE_IFELSE([AC_LANG_SOURCE([[
> -               #define _GNU_SOURCE
>                 #include <sched.h>
>                 int main()
>                 {
> @@ -295,7 +294,6 @@ AC_COMPILE_IFELSE([AC_LANG_SOURCE([[
>  AC_MSG_CHECKING([whether CPU_SET works])
>  AH_TEMPLATE([HAVE_CPU_SET], [Defined to 1 if we have CPU_SET and it works])
>  AC_COMPILE_IFELSE([AC_LANG_SOURCE([[
> -               #define _GNU_SOURCE
>                 #include <sched.h>
>                 int main()
>                 {
> --
> 2.5.1
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

Please note that this patch is for urcu.  The subject prefix I had set
([PATCH urcu]) appears in the message source, but not in the real
subject, I am not sure why.
