From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust 1/4] Use a variable to select the
 dlopen lib in Makefiles
Date: Fri, 21 Dec 2018 16:07:51 -0500 (EST)
Message-ID: <755570605.8139.1545426471036.JavaMail.zimbra__22796.3156685748$1545426356$gmane$org@efficios.com>
References: <20181220202242.6119-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 43M1Rs259Fz15w1
 for <lttng-dev@lists.lttng.org>; Fri, 21 Dec 2018 16:07:53 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 6CE80A8A49
 for <lttng-dev@lists.lttng.org>; Fri, 21 Dec 2018 16:07:52 -0500 (EST)
In-Reply-To: <20181220202242.6119-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

All 4 patches merged into master, thanks!

Mathieu

----- On Dec 20, 2018, at 3:22 PM, Michael Jeanson mjeanson@efficios.com wrote:

> Instead of multiple conditionnals, it makes for cleaner and more
> readable Makefiles.
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> configure.ac                           |  8 +++-----
> liblttng-ust-cyg-profile/Makefile.am   | 17 ++++++-----------
> liblttng-ust-dl/Makefile.am            | 11 +++--------
> liblttng-ust-fd/Makefile.am            | 11 +++--------
> liblttng-ust-fork/Makefile.am          | 10 ++--------
> liblttng-ust-libc-wrapper/Makefile.am  | 18 +++++++-----------
> liblttng-ust/Makefile.am               | 22 ++++++----------------
> tests/benchmark/Makefile.am            | 14 +++-----------
> tests/ctf-types/Makefile.am            |  9 +--------
> tests/hello-many/Makefile.am           |  9 +--------
> tests/hello.cxx/Makefile.am            |  9 +--------
> tests/hello/Makefile.am                |  9 +--------
> tests/same_line_tracepoint/Makefile.am |  9 +--------
> tests/test-app-ctx/Makefile.am         |  9 +--------
> tests/ust-variant/Makefile.am          |  9 +--------
> 15 files changed, 40 insertions(+), 134 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 2ea15533..431ed21a 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -207,17 +207,18 @@ AH_TEMPLATE([LTTNG_UST_HAVE_PERF_EVENT], [Perf event
> integration via perf_event.
> 
> # Checks for libraries.
> AC_CHECK_LIB([dl], [dlopen], [
> -	have_libdl=yes
> 	libdl_name=dl
> +	DL_LIBS="-ldl"
> ], [
> 	#libdl not found, check for dlopen in libc.
> 	AC_CHECK_LIB([c], [dlopen], [
> -		have_libc_dl=yes
> 		libdl_name=c
> +		DL_LIBS="-lc"
> 	], [
> 		AC_MSG_ERROR([Cannot find dlopen in libdl nor libc. Use [LDFLAGS]=-Ldir to
> 		specify their location.])
> 	])
> ])
> +AC_SUBST(DL_LIBS)
> 
> # Check if libdl has dlmopen support.
> AH_TEMPLATE([HAVE_DLMOPEN], ["Define to 1 if dlmopen is available."])
> @@ -225,9 +226,6 @@ AC_CHECK_LIB([$libdl_name], [dlmopen],
> 	[AC_DEFINE([HAVE_DLMOPEN], [1])]
> )
> 
> -AM_CONDITIONAL([LTTNG_UST_BUILD_WITH_LIBDL], [test "x$have_libdl" = "xyes"])
> -AM_CONDITIONAL([LTTNG_UST_BUILD_WITH_LIBC_DL], [test "x$have_libc_dl" =
> "xyes"])
> -
> AC_CHECK_LIB([pthread], [pthread_create])
> AC_CHECK_LIB([pthread], [pthread_setname_np],
> 	AC_DEFINE([HAVE_PTHREAD_SETNAME_NP], [1], [Define to 1 if pthread_setname_np is
> 	available.]),
> diff --git a/liblttng-ust-cyg-profile/Makefile.am
> b/liblttng-ust-cyg-profile/Makefile.am
> index 3130282d..0ed2cd9c 100644
> --- a/liblttng-ust-cyg-profile/Makefile.am
> +++ b/liblttng-ust-cyg-profile/Makefile.am
> @@ -7,25 +7,20 @@ lib_LTLIBRARIES = liblttng-ust-cyg-profile.la \
> liblttng_ust_cyg_profile_la_SOURCES = \
> 	lttng-ust-cyg-profile.c \
> 	lttng-ust-cyg-profile.h
> +
> liblttng_ust_cyg_profile_la_LIBADD = \
> 	-L$(top_builddir)/liblttng-ust/.libs \
> -	-llttng-ust
> +	-llttng-ust \
> +	$(DL_LIBS)
> 
> liblttng_ust_cyg_profile_fast_la_SOURCES = \
> 	lttng-ust-cyg-profile-fast.c \
> 	lttng-ust-cyg-profile-fast.h
> +
> liblttng_ust_cyg_profile_fast_la_LIBADD = \
> 	-L$(top_builddir)/liblttng-ust/.libs \
> -	-llttng-ust
> -
> -if LTTNG_UST_BUILD_WITH_LIBDL
> -liblttng_ust_cyg_profile_la_LIBADD += -ldl
> -liblttng_ust_cyg_profile_fast_la_LIBADD += -ldl
> -endif
> -if LTTNG_UST_BUILD_WITH_LIBC_DL
> -liblttng_ust_cyg_profile_la_LIBADD += -lc
> -liblttng_ust_cyg_profile_fast_la_LIBADD += -lc
> -endif
> +	-llttng-ust \
> +	$(DL_LIBS)
> 
> noinst_SCRIPTS = run run-fast
> EXTRA_DIST = run run-fast
> diff --git a/liblttng-ust-dl/Makefile.am b/liblttng-ust-dl/Makefile.am
> index c0168f39..1f6d166a 100644
> --- a/liblttng-ust-dl/Makefile.am
> +++ b/liblttng-ust-dl/Makefile.am
> @@ -6,14 +6,9 @@ liblttng_ust_dl_la_SOURCES = \
> 	lttng-ust-dl.c \
> 	ust_dl.c \
> 	ust_dl.h
> -liblttng_ust_dl_la_LIBADD = \
> -	$(top_builddir)/liblttng-ust/liblttng-ust.la
> 
> -if LTTNG_UST_BUILD_WITH_LIBDL
> -liblttng_ust_dl_la_LIBADD += -ldl
> -endif
> -if LTTNG_UST_BUILD_WITH_LIBC_DL
> -liblttng_ust_dl_la_LIBADD += -lc
> -endif
> +liblttng_ust_dl_la_LIBADD = \
> +	$(top_builddir)/liblttng-ust/liblttng-ust.la \
> +	$(DL_LIBS)
> 
> liblttng_ust_dl_la_CFLAGS = -DUST_COMPONENT=liblttng-ust-dl $(AM_CFLAGS)
> diff --git a/liblttng-ust-fd/Makefile.am b/liblttng-ust-fd/Makefile.am
> index f7706634..57122ec7 100644
> --- a/liblttng-ust-fd/Makefile.am
> +++ b/liblttng-ust-fd/Makefile.am
> @@ -4,14 +4,9 @@ AM_CFLAGS += -fno-strict-aliasing
> lib_LTLIBRARIES = liblttng-ust-fd.la
> liblttng_ust_fd_la_SOURCES = \
> 	lttng-ust-fd.c
> -liblttng_ust_fd_la_LIBADD = \
> -	$(top_builddir)/liblttng-ust/liblttng-ust.la
> 
> -if LTTNG_UST_BUILD_WITH_LIBDL
> -liblttng_ust_fd_la_LIBADD += -ldl
> -endif
> -if LTTNG_UST_BUILD_WITH_LIBC_DL
> -liblttng_ust_fd_la_LIBADD += -lc
> -endif
> +liblttng_ust_fd_la_LIBADD = \
> +	$(top_builddir)/liblttng-ust/liblttng-ust.la \
> +	$(DL_LIBS)
> 
> liblttng_ust_fd_la_CFLAGS = -DUST_COMPONENT=liblttng-ust-fd $(AM_CFLAGS)
> diff --git a/liblttng-ust-fork/Makefile.am b/liblttng-ust-fork/Makefile.am
> index 2f0976d4..d05f5b93 100644
> --- a/liblttng-ust-fork/Makefile.am
> +++ b/liblttng-ust-fork/Makefile.am
> @@ -4,13 +4,7 @@ AM_CFLAGS += -fno-strict-aliasing
> lib_LTLIBRARIES = liblttng-ust-fork.la
> liblttng_ust_fork_la_SOURCES = ustfork.c
> liblttng_ust_fork_la_LIBADD = \
> -	$(top_builddir)/liblttng-ust/liblttng-ust.la
> -
> -if LTTNG_UST_BUILD_WITH_LIBDL
> -liblttng_ust_fork_la_LIBADD += -ldl
> -endif
> -if LTTNG_UST_BUILD_WITH_LIBC_DL
> -liblttng_ust_fork_la_LIBADD += -lc
> -endif
> +	$(top_builddir)/liblttng-ust/liblttng-ust.la \
> +	$(DL_LIBS)
> 
> liblttng_ust_fork_la_CFLAGS = -DUST_COMPONENT=liblttng-ust-fork $(AM_CFLAGS)
> diff --git a/liblttng-ust-libc-wrapper/Makefile.am
> b/liblttng-ust-libc-wrapper/Makefile.am
> index e73b4d88..e510a11a 100644
> --- a/liblttng-ust-libc-wrapper/Makefile.am
> +++ b/liblttng-ust-libc-wrapper/Makefile.am
> @@ -3,28 +3,24 @@ AM_CFLAGS += -fno-strict-aliasing
> 
> lib_LTLIBRARIES = liblttng-ust-libc-wrapper.la \
>   liblttng-ust-pthread-wrapper.la
> +
> liblttng_ust_libc_wrapper_la_SOURCES = \
> 	lttng-ust-malloc.c \
> 	ust_libc.h
> +
> liblttng_ust_libc_wrapper_la_LIBADD = \
> 	-L$(top_builddir)/liblttng-ust/.libs \
> -	-llttng-ust
> +	-llttng-ust \
> +	$(DL_LIBS)
> 
> liblttng_ust_pthread_wrapper_la_SOURCES = \
> 	lttng-ust-pthread.c \
> 	ust_pthread.h
> +
> liblttng_ust_pthread_wrapper_la_LIBADD = \
> 	-L$(top_builddir)/liblttng-ust/.libs \
> -	-llttng-ust
> -
> -if LTTNG_UST_BUILD_WITH_LIBDL
> -liblttng_ust_libc_wrapper_la_LIBADD += -ldl
> -liblttng_ust_pthread_wrapper_la_LIBADD += -ldl
> -endif
> -if LTTNG_UST_BUILD_WITH_LIBC_DL
> -liblttng_ust_libc_wrapper_la_LIBADD += -lc
> -liblttng_ust_pthread_wrapper_la_LIBADD += -lc
> -endif
> +	-llttng-ust \
> +	$(DL_LIBS)
> 
> noinst_SCRIPTS = run
> EXTRA_DIST = run
> diff --git a/liblttng-ust/Makefile.am b/liblttng-ust/Makefile.am
> index 57df3aed..ea4c8f61 100644
> --- a/liblttng-ust/Makefile.am
> +++ b/liblttng-ust/Makefile.am
> @@ -12,20 +12,16 @@ liblttng_ust_tracepoint_la_SOURCES = \
> 	lttng-tracer-core.h \
> 	jhash.h \
> 	error.h
> +
> liblttng_ust_tracepoint_la_LIBADD = \
> 	-lurcu-bp \
> 	-lpthread \
> -	$(top_builddir)/snprintf/libustsnprintf.la
> +	$(top_builddir)/snprintf/libustsnprintf.la \
> +	$(DL_LIBS)
> +
> liblttng_ust_tracepoint_la_LDFLAGS = -no-undefined -version-info
> $(LTTNG_UST_LIBRARY_VERSION)
> liblttng_ust_tracepoint_la_CFLAGS = -DUST_COMPONENT="liblttng_ust_tracepoint"
> $(AM_CFLAGS)
> 
> -if LTTNG_UST_BUILD_WITH_LIBDL
> -liblttng_ust_tracepoint_la_LIBADD += -ldl
> -endif
> -if LTTNG_UST_BUILD_WITH_LIBC_DL
> -liblttng_ust_tracepoint_la_LIBADD += -lc
> -endif
> -
> liblttng_ust_runtime_la_SOURCES = \
> 	lttng-ust-comm.c \
> 	lttng-ust-abi.c \
> @@ -106,13 +102,7 @@ liblttng_ust_la_LIBADD = \
> 	$(top_builddir)/snprintf/libustsnprintf.la \
> 	$(top_builddir)/liblttng-ust-comm/liblttng-ust-comm.la \
> 	liblttng-ust-tracepoint.la \
> -	liblttng-ust-runtime.la liblttng-ust-support.la
> -
> -if LTTNG_UST_BUILD_WITH_LIBDL
> -liblttng_ust_la_LIBADD += -ldl
> -endif
> -if LTTNG_UST_BUILD_WITH_LIBC_DL
> -liblttng_ust_la_LIBADD += -lc
> -endif
> +	liblttng-ust-runtime.la liblttng-ust-support.la \
> +	$(DL_LIBS)
> 
> liblttng_ust_la_CFLAGS = -DUST_COMPONENT="liblttng_ust" $(AM_CFLAGS)
> diff --git a/tests/benchmark/Makefile.am b/tests/benchmark/Makefile.am
> index 4ea420c6..ef9635c0 100644
> --- a/tests/benchmark/Makefile.am
> +++ b/tests/benchmark/Makefile.am
> @@ -2,20 +2,12 @@ AM_CPPFLAGS = -I$(top_srcdir)/include
> -I$(top_builddir)/include -Wsystem-headers
> 
> noinst_PROGRAMS = bench1 bench2
> bench1_SOURCES = bench.c tp.c ust_tests_benchmark.h
> -bench1_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la
> +bench1_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la $(DL_LIBS)
> +
> bench2_SOURCES = bench.c tp.c ust_tests_benchmark.h
> -bench2_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la
> +bench2_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la $(DL_LIBS)
> bench2_CFLAGS = -DTRACING $(AM_CFLAGS)
> 
> dist_noinst_SCRIPTS = test_benchmark ptime
> 
> extra_DIST = README
> -
> -if LTTNG_UST_BUILD_WITH_LIBDL
> -bench1_LDADD += -ldl
> -bench2_LDADD += -ldl
> -endif
> -if LTTNG_UST_BUILD_WITH_LIBC_DL
> -bench1_LDADD += -lc
> -bench2_LDADD += -lc
> -endif
> diff --git a/tests/ctf-types/Makefile.am b/tests/ctf-types/Makefile.am
> index a9b40b6a..42d803f2 100644
> --- a/tests/ctf-types/Makefile.am
> +++ b/tests/ctf-types/Makefile.am
> @@ -2,12 +2,5 @@ AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include
> -Wsystem-headers
> 
> noinst_PROGRAMS = ctf-types
> ctf_types_SOURCES = ctf-types.c tp.c ust_tests_ctf_types.h
> -ctf_types_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la
> +ctf_types_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la $(DL_LIBS)
> ctf_types_CFLAGS = -Werror=old-style-definition $(AM_CFLAGS)
> -
> -if LTTNG_UST_BUILD_WITH_LIBDL
> -ctf_types_LDADD += -ldl
> -endif
> -if LTTNG_UST_BUILD_WITH_LIBC_DL
> -ctf_types_LDADD += -lc
> -endif
> diff --git a/tests/hello-many/Makefile.am b/tests/hello-many/Makefile.am
> index 338b7986..ee648225 100644
> --- a/tests/hello-many/Makefile.am
> +++ b/tests/hello-many/Makefile.am
> @@ -2,12 +2,5 @@ AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include
> -Wsystem-headers
> 
> noinst_PROGRAMS = hello-many
> hello_many_SOURCES = hello-many.c tp.c ust_tests_hello_many.h
> -hello_many_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la
> +hello_many_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la $(DL_LIBS)
> hello_many_CFLAGS = -Werror=old-style-definition $(AM_CFLAGS)
> -
> -if LTTNG_UST_BUILD_WITH_LIBDL
> -hello_many_LDADD += -ldl
> -endif
> -if LTTNG_UST_BUILD_WITH_LIBC_DL
> -hello_many_LDADD += -lc
> -endif
> diff --git a/tests/hello.cxx/Makefile.am b/tests/hello.cxx/Makefile.am
> index f8a8f46d..4b0fb234 100644
> --- a/tests/hello.cxx/Makefile.am
> +++ b/tests/hello.cxx/Makefile.am
> @@ -2,11 +2,4 @@ AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include
> -Wsystem-headers
> 
> noinst_PROGRAMS = hello
> hello_SOURCES = hello.cpp tp-cpp.cpp ust_tests_hello.h
> -hello_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la
> -
> -if LTTNG_UST_BUILD_WITH_LIBDL
> -hello_LDADD += -ldl
> -endif
> -if LTTNG_UST_BUILD_WITH_LIBC_DL
> -hello_LDADD += -lc
> -endif
> +hello_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la $(DL_LIBS)
> diff --git a/tests/hello/Makefile.am b/tests/hello/Makefile.am
> index cb4d4626..d5e42d33 100644
> --- a/tests/hello/Makefile.am
> +++ b/tests/hello/Makefile.am
> @@ -2,12 +2,5 @@ AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include
> -Wsystem-headers
> 
> noinst_PROGRAMS = hello
> hello_SOURCES = hello.c tp.c ust_tests_hello.h
> -hello_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la
> +hello_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la $(DL_LIBS)
> hello_CFLAGS = -Werror=old-style-definition $(AM_CFLAGS)
> -
> -if LTTNG_UST_BUILD_WITH_LIBDL
> -hello_LDADD += -ldl
> -endif
> -if LTTNG_UST_BUILD_WITH_LIBC_DL
> -hello_LDADD += -lc
> -endif
> diff --git a/tests/same_line_tracepoint/Makefile.am
> b/tests/same_line_tracepoint/Makefile.am
> index 5cb4f36b..ae1f773d 100644
> --- a/tests/same_line_tracepoint/Makefile.am
> +++ b/tests/same_line_tracepoint/Makefile.am
> @@ -2,11 +2,4 @@ AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include
> -Wsystem-headers
> 
> noinst_PROGRAMS = same_line_tracepoint
> same_line_tracepoint_SOURCES = same_line_tracepoint.c ust_tests_sameline.h
> -same_line_tracepoint_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la
> -
> -if LTTNG_UST_BUILD_WITH_LIBDL
> -same_line_tracepoint_LDADD += -ldl
> -endif
> -if LTTNG_UST_BUILD_WITH_LIBC_DL
> -same_line_tracepoint_LDADD += -lc
> -endif
> +same_line_tracepoint_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la
> $(DL_LIBS)
> diff --git a/tests/test-app-ctx/Makefile.am b/tests/test-app-ctx/Makefile.am
> index cb4d4626..d5e42d33 100644
> --- a/tests/test-app-ctx/Makefile.am
> +++ b/tests/test-app-ctx/Makefile.am
> @@ -2,12 +2,5 @@ AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include
> -Wsystem-headers
> 
> noinst_PROGRAMS = hello
> hello_SOURCES = hello.c tp.c ust_tests_hello.h
> -hello_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la
> +hello_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la $(DL_LIBS)
> hello_CFLAGS = -Werror=old-style-definition $(AM_CFLAGS)
> -
> -if LTTNG_UST_BUILD_WITH_LIBDL
> -hello_LDADD += -ldl
> -endif
> -if LTTNG_UST_BUILD_WITH_LIBC_DL
> -hello_LDADD += -lc
> -endif
> diff --git a/tests/ust-variant/Makefile.am b/tests/ust-variant/Makefile.am
> index 5d741bdf..28e62009 100644
> --- a/tests/ust-variant/Makefile.am
> +++ b/tests/ust-variant/Makefile.am
> @@ -2,12 +2,5 @@ AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include
> -Wsystem-headers
> 
> noinst_PROGRAMS = ust-variant
> ust_variant_SOURCES = ust-variant.c
> -ust_variant_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la
> +ust_variant_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la $(DL_LIBS)
> ust_variant_CFLAGS = -Werror=old-style-definition $(AM_CFLAGS)
> -
> -if LTTNG_UST_BUILD_WITH_LIBDL
> -ust_variant_LDADD += -ldl
> -endif
> -if LTTNG_UST_BUILD_WITH_LIBC_DL
> -ust_variant_LDADD += -lc
> -endif
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
