From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: Conditionnally disable tests
	requiring	shared libs support
Date: Mon, 5 Nov 2012 10:40:13 -0500
Message-ID: <20121105154013.GB7884__36366.6739817292$1352130047$gmane$org@Krystal>
References: <1352128641-26335-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TVOme-0005Oq-47
	for lttng-dev@lists.lttng.org; Mon, 05 Nov 2012 10:40:16 -0500
Content-Disposition: inline
In-Reply-To: <1352128641-26335-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Christian Babeux (christian.babeux@efficios.com) wrote:
> When building lttng-ust with shared library support explicitly
> disabled (e.g.: ./configure --disable-shared), libtool fail with
> a fatal error:
> 
>   CC       tp.lo
>   CC       tp2.lo
>   CCLD     liblttng-ust-provider-ust-tests-demo.la
> libtool: link: can not build a shared library
> libtool: link: See the libtool documentation for more information.
> libtool: link: Fatal configuration error.
> 
> The build should not fail because some tests require explicit shared
> library support, instead they should be skipped.
> 
> This patch detect that the --disable-shared flag was passed to the
> configure script and toggle the "NO_SHARED" Automake variable.
> Thus, the tests that require explicit shared library support can
> be skipped when the NO_SHARED variable is true.

merged into master and stable-2.0, thanks!

Mathieu

> 
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  configure.ac           | 2 ++
>  tests/demo/Makefile.am | 5 +++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/configure.ac b/configure.ac
> index 91ad8d9..87e89d5 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -64,6 +64,8 @@ AS_IF([test "x$libtool_fixup" = "xyes"],
>  		  ])
>  	    ])
>  
> +AM_CONDITIONAL([NO_SHARED], [test x$enable_shared = xno])
> +
>  # Checks for programs.
>  AC_PROG_CC
>  AC_PROG_CXX
> diff --git a/tests/demo/Makefile.am b/tests/demo/Makefile.am
> index 0e43255..76ab598 100644
> --- a/tests/demo/Makefile.am
> +++ b/tests/demo/Makefile.am
> @@ -6,6 +6,10 @@ AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include -Wsystem-headers
>  # libraries.
>  LIBS =
>  
> +if NO_SHARED
> +# Do not build this test if shared libraries support was
> +# explicitly disabled.
> +else
>  # Force the shared flag on the noinst libraries since they are
>  # only built static by default
>  FORCE_SHARED_LIB_OPTIONS = -module -shared -avoid-version \
> @@ -41,3 +45,4 @@ if LTTNG_UST_BUILD_WITH_LIBC_DL
>  demo_LDADD = -lc
>  endif
>  
> +endif
> -- 
> 1.8.0
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
