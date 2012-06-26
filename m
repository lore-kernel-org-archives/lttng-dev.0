From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [UST PATCH] Add a multi-thread version of
	the	'hello' test program
Date: Tue, 26 Jun 2012 08:02:23 -0400
Message-ID: <20120626120222.GA17072__8938.4020226591$1340712173$gmane$org@Krystal>
References: <1340667760-28686-1-git-send-email-alexmonthy@voxpopuli.im>
	<20120626060356.GC11445@Krystal> <4FE960A2.7080109@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SjUTQ-0000cU-OZ
	for lttng-dev@lists.lttng.org; Tue, 26 Jun 2012 08:02:24 -0400
Content-Disposition: inline
In-Reply-To: <4FE960A2.7080109@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Alexandre Montplaisir (alexmonthy@voxpopuli.im) wrote:
> On 12-06-26 02:03 AM, Mathieu Desnoyers wrote:
> > * Alexandre Montplaisir (alexmonthy@voxpopuli.im) wrote:
> >> [...]
> >> diff --git a/tests/hello-mt/README b/tests/hello-mt/README
> >> new file mode 100644
> >> index 0000000..0584dca
> >> --- /dev/null
> >> +++ b/tests/hello-mt/README
> >> @@ -0,0 +1,11 @@
> >> +This is a multi-threaded version of the "hello" test program. It uses OpenMP for
> >> +parallelization, and as such requires at least GCC 4.2.
> > Hrm. This adds a dependency on gcc 4.2. The entire project will fail to
> > build because of this test on other compiler, older gcc, right ? We
> > should have a configure.ac check that tests openmp availability. So I
> > won't merge this for now.
> 
> Staying up late, aren't we? ;)

Nah, I'm in Sweden at the moment, I was doing my morning email catchup
;)

> 
> Oh ok, I thought we said the other day that GCC 4.2 was old enough to
> not be worth testing for. In any case, here's a patch to check for
> OpenMP at configure time (goes on top of the previous one).
> 
> Two caveats however:
> - Since the main part of the project doesn't use OpenMP, I don't think
> we want to turn the "-fopenmp" CFLAG on for the whole thing. So I just
> hard-coded "-fopenmp" for this test only. I don't know if any other
> compiler uses some other flag to turn on the OpenMP support, but we only
> support GCC anyway, don't we?

Specific to the hello-mt directory makes sense. gcc-specific makes sense
too I guess, since we detect its availability with autoconf.

> 
> - The autoconf macro requires Autoconf 2.62. Current Debian stable has
> 2.67, I don't know if it's a big problem.

Can you respin this patch after looking at:
https://bugs.launchpad.net/inkscape/+bug/984836

they check if the AC_OPENMP macro is available, and mark openmp as
unavailable if it is not. This would allow us to still only depend on
autotools 2.50.

Thanks,

Mathieu

> 
> 
> Good night,
> Alex
> 
> >
> > Thanks,
> >
> > Mathieu
> >
> >
> 

> From 496a74a33dc47b61c37b14e0fb0ad5bdeacaf03b Mon Sep 17 00:00:00 2001
> From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
> Date: Tue, 26 Jun 2012 02:56:19 -0400
> Subject: [UST PATCH] Only build the hello-mt test if OpenMP is available
> 
> Since this test is the only part in the whole tree that uses
> OpenMP, we'll simply set the CFLAG manually for this test
> rather than using it project-wide.
> 
> Signed-off-by: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
> ---
>  README                     |    2 +-
>  configure.ac               |   10 ++++++++++
>  tests/hello-mt/Makefile.am |    4 ++++
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/README b/README
> index 52aebd8..b9df1e6 100644
> --- a/README
> +++ b/README
> @@ -30,7 +30,7 @@ This source tree is based on the autotools suite from GNU to simplify
>  portability. Here are some things you should have on your system in order to
>  compile the git repository tree :
>  
> -- GNU autotools (automake >=1.10, autoconf >=2.50, autoheader >=2.50)
> +- GNU autotools (automake >=1.10, autoconf >=2.62, autoheader >=2.62)
>    (make sure your system wide "automake" points to a recent version!)
>  - GNU Libtool >=2.2
>    (for more information, go to http://www.gnu.org/software/autoconf/)
> diff --git a/configure.ac b/configure.ac
> index 0a50ed0..1924d0b 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -271,6 +271,16 @@ AS_IF([test "x$with_sdt" = "xyes"],[
>  	])
>  ])
>  
> +#Check for OpenMP, if available we will build the test that uses it
> +AC_OPENMP()
> +AS_IF([ test "x$ac_cv_prog_c_openmp" != "xunsupported" && test "x$ac_cv_prog_c_openmp" != "x"],[
> +	openmp_available=yes
> +],[
> +	openmp_available=no
> +])
> +AM_CONDITIONAL([BUILD_OPENMP_TEST], [test "x$openmp_available" = "xyes"])
> +
> +
>  #currently disabled.
>  	#tests/hello2/Makefile
>  	#tests/basic/Makefile
> diff --git a/tests/hello-mt/Makefile.am b/tests/hello-mt/Makefile.am
> index 4b7e16d..98ecc6f 100644
> --- a/tests/hello-mt/Makefile.am
> +++ b/tests/hello-mt/Makefile.am
> @@ -1,3 +1,5 @@
> +if BUILD_OPENMP_TEST
> +
>  AM_CPPFLAGS = -I$(top_srcdir)/include -Wsystem-headers
>  AM_CFLAGS = -fopenmp
>  
> @@ -11,3 +13,5 @@ endif
>  if LTTNG_UST_BUILD_WITH_LIBC_DL
>  hello_LDADD += -lc
>  endif
> +
> +endif
> -- 
> 1.7.10.4
> 


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
