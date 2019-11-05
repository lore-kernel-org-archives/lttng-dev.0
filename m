From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Use pkgconfig to detect and
 configure liblttng-ust
Date: Tue, 5 Nov 2019 00:19:09 -0500
Message-ID: <20191105051909.GB8933__28137.8816974879$1572931173$gmane$org@gmail.com>
References: <20191024153622.17457-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 by lists.lttng.org (Postfix) with ESMTPS id 476dJ20jqrzrWD
 for <lttng-dev@lists.lttng.org>; Tue,  5 Nov 2019 00:19:13 -0500 (EST)
Received: by mail-qt1-f193.google.com with SMTP id o49so27647542qta.7
 for <lttng-dev@lists.lttng.org>; Mon, 04 Nov 2019 21:19:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20191024153622.17457-1-mjeanson@efficios.com>
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
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Merged in master.

Thanks!
J=E9r=E9mie

On Thu, Oct 24, 2019 at 11:36:22AM -0400, Michael Jeanson wrote:
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
>  configure.ac                                  | 25 +++++++++----------
>  src/bin/lttng-consumerd/Makefile.am           |  2 +-
>  src/bin/lttng-sessiond/Makefile.am            |  2 +-
>  src/common/ust-consumer/Makefile.am           |  2 +-
>  tests/regression/tools/filtering/Makefile.am  |  2 +-
>  .../ust/baddr-statedump/Makefile.am           |  2 +-
>  tests/regression/ust/daemon/Makefile.am       |  2 +-
>  tests/regression/ust/exit-fast/Makefile.am    |  2 +-
>  tests/regression/ust/fork/Makefile.am         |  4 +--
>  .../ust/high-throughput/Makefile.am           |  2 +-
>  tests/regression/ust/libc-wrapper/Makefile.am |  2 +-
>  tests/regression/ust/linking/Makefile.am      | 10 ++++----
>  .../regression/ust/low-throughput/Makefile.am |  2 +-
>  tests/regression/ust/multi-lib/Makefile.am    |  6 ++---
>  .../regression/ust/multi-session/Makefile.am  |  2 +-
>  tests/regression/ust/overlap/demo/Makefile.am |  4 +--
>  .../ust/type-declarations/Makefile.am         |  3 ++-
>  tests/unit/Makefile.am                        |  4 +--
>  .../testapp/gen-ust-events-ns/Makefile.am     |  2 +-
>  .../utils/testapp/gen-ust-events/Makefile.am  |  2 +-
>  .../testapp/gen-ust-nevents-str/Makefile.am   |  2 +-
>  .../utils/testapp/gen-ust-nevents/Makefile.am |  2 +-
>  .../utils/testapp/gen-ust-tracef/Makefile.am  |  2 +-
>  23 files changed, 44 insertions(+), 44 deletions(-)
> =

> diff --git a/configure.ac b/configure.ac
> index e57f53631..dd708883b 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -560,19 +560,18 @@ AC_ARG_WITH([lttng-ust],
>    [with_lttng_ust=3Dyes]
>  )
>  =

> -AS_IF([test "x$with_lttng_ust" =3D "xyes"],
> -  [
> -    AC_CHECK_LIB([lttng-ust-ctl], [ustctl_recv_channel_from_consumer],
> -      [
> -        AC_DEFINE([HAVE_LIBLTTNG_UST_CTL], [1])
> -      ],
> -      [
> -        AC_MSG_FAILURE([Cannot find LTTng-UST >=3D 2.2.x. Use [LDFLAGS]=
=3D-Ldir and [CPPFLAGS]=3D-Idir to specify its location, or specify --witho=
ut-lttng-ust to build lttng-tools without LTTng-UST support.])
> -      ],
> -      [-lurcu-common -lurcu-bp -lurcu-cds -lrt -ldl]
> -    )
> -  ]
> -)
> +AS_IF([test "x$with_lttng_ust" =3D "xyes"], [
> +  AC_DEFINE([HAVE_LIBLTTNG_UST_CTL], [1])
> +
> +  # Check for liblttng-ust
> +  PKG_CHECK_MODULES([UST], [lttng-ust >=3D $major_version.$minor_version=
])
> +
> +  # Check for liblttng-ust-ctl
> +  PKG_CHECK_MODULES([UST_CTL], [lttng-ust-ctl >=3D $major_version.$minor=
_version])
> +
> +  AM_CPPFLAGS=3D"$AM_CPPFLAGS $UST_CFLAGS"
> +])
> +
>  AM_CONDITIONAL([HAVE_LIBLTTNG_UST_CTL], [test "x$with_lttng_ust" =3D "xy=
es"])
>  =

>  =

> diff --git a/src/bin/lttng-consumerd/Makefile.am b/src/bin/lttng-consumer=
d/Makefile.am
> index 9d54309cf..0659a34a0 100644
> --- a/src/bin/lttng-consumerd/Makefile.am
> +++ b/src/bin/lttng-consumerd/Makefile.am
> @@ -16,5 +16,5 @@ lttng_consumerd_LDADD =3D \
>  lttng_consumerd_LDFLAGS =3D -rdynamic
>  =

>  if HAVE_LIBLTTNG_UST_CTL
> -lttng_consumerd_LDADD +=3D -llttng-ust-ctl
> +lttng_consumerd_LDADD +=3D $(UST_CTL_LIBS)
>  endif
> diff --git a/src/bin/lttng-sessiond/Makefile.am b/src/bin/lttng-sessiond/=
Makefile.am
> index 296ec148b..ebb8cb284 100644
> --- a/src/bin/lttng-sessiond/Makefile.am
> +++ b/src/bin/lttng-sessiond/Makefile.am
> @@ -78,5 +78,5 @@ lttng_sessiond_LDADD =3D -lurcu-common -lurcu $(KMOD_LI=
BS) \
>  =

>  =

>  if HAVE_LIBLTTNG_UST_CTL
> -lttng_sessiond_LDADD +=3D -llttng-ust-ctl
> +lttng_sessiond_LDADD +=3D $(UST_CTL_LIBS)
>  endif
> diff --git a/src/common/ust-consumer/Makefile.am b/src/common/ust-consume=
r/Makefile.am
> index 1acdc7f12..1df8b53c0 100644
> --- a/src/common/ust-consumer/Makefile.am
> +++ b/src/common/ust-consumer/Makefile.am
> @@ -5,7 +5,7 @@ noinst_LTLIBRARIES =3D libust-consumer.la
>  libust_consumer_la_SOURCES =3D ust-consumer.c ust-consumer.h
>  =

>  libust_consumer_la_LIBADD =3D \
> -			-llttng-ust-ctl \
> +			$(UST_CTL_LIBS) \
>  			$(top_builddir)/src/common/relayd/librelayd.la
>  =

>  endif
> diff --git a/tests/regression/tools/filtering/Makefile.am b/tests/regress=
ion/tools/filtering/Makefile.am
> index b214fc1d6..5900a2093 100644
> --- a/tests/regression/tools/filtering/Makefile.am
> +++ b/tests/regression/tools/filtering/Makefile.am
> @@ -3,7 +3,7 @@ AM_CPPFLAGS +=3D -I$(top_srcdir)/tests -I$(srcdir)
>  if HAVE_LIBLTTNG_UST_CTL
>  noinst_PROGRAMS =3D gen-ust-events
>  gen_ust_events_SOURCES =3D gen-ust-events.c tp.c tp.h
> -gen_ust_events_LDADD =3D -llttng-ust -lurcu-bp $(DL_LIBS)
> +gen_ust_events_LDADD =3D $(UST_LIBS) $(DL_LIBS)
>  endif
>  =

>  noinst_SCRIPTS =3D test_unsupported_op test_invalid_filter test_valid_fi=
lter
> diff --git a/tests/regression/ust/baddr-statedump/Makefile.am b/tests/reg=
ression/ust/baddr-statedump/Makefile.am
> index bf51f9483..253c9029f 100644
> --- a/tests/regression/ust/baddr-statedump/Makefile.am
> +++ b/tests/regression/ust/baddr-statedump/Makefile.am
> @@ -6,7 +6,7 @@ AM_CPPFLAGS +=3D -I$(srcdir) -g
>  =

>  noinst_PROGRAMS =3D prog
>  prog_SOURCES =3D prog.c tp.c tp.h
> -prog_LDADD =3D -llttng-ust $(DL_LIBS)
> +prog_LDADD =3D $(UST_LIBS) $(DL_LIBS)
>  =

>  noinst_SCRIPTS =3D test_baddr-statedump test_baddr-statedump.py
>  EXTRA_DIST =3D test_baddr-statedump test_baddr-statedump.py
> diff --git a/tests/regression/ust/daemon/Makefile.am b/tests/regression/u=
st/daemon/Makefile.am
> index 1a52b634b..632f131d8 100644
> --- a/tests/regression/ust/daemon/Makefile.am
> +++ b/tests/regression/ust/daemon/Makefile.am
> @@ -2,7 +2,7 @@ AM_CPPFLAGS +=3D -I$(srcdir)
>  =

>  noinst_PROGRAMS =3D daemon
>  daemon_SOURCES =3D daemon.c ust_tests_daemon.h
> -daemon_LDADD =3D -llttng-ust -llttng-ust-fork $(DL_LIBS)
> +daemon_LDADD =3D $(UST_LIBS) -llttng-ust-fork $(DL_LIBS)
>  =

>  noinst_SCRIPTS =3D test_daemon test_daemon.py
>  EXTRA_DIST =3D test_daemon test_daemon.py
> diff --git a/tests/regression/ust/exit-fast/Makefile.am b/tests/regressio=
n/ust/exit-fast/Makefile.am
> index 06cda46a5..c39dc9a44 100644
> --- a/tests/regression/ust/exit-fast/Makefile.am
> +++ b/tests/regression/ust/exit-fast/Makefile.am
> @@ -2,7 +2,7 @@ AM_CPPFLAGS +=3D -I$(srcdir)
>  =

>  noinst_PROGRAMS =3D exit-fast
>  exit_fast_SOURCES =3D exit-fast.c ust_tests_exitfast.h
> -exit_fast_LDADD =3D -llttng-ust $(DL_LIBS)
> +exit_fast_LDADD =3D $(UST_LIBS) $(DL_LIBS)
>  =

>  noinst_SCRIPTS =3D test_exit-fast test_exit-fast.py
>  EXTRA_DIST =3D test_exit-fast test_exit-fast.py
> diff --git a/tests/regression/ust/fork/Makefile.am b/tests/regression/ust=
/fork/Makefile.am
> index 2c79db658..0c6ca2aa7 100644
> --- a/tests/regression/ust/fork/Makefile.am
> +++ b/tests/regression/ust/fork/Makefile.am
> @@ -2,10 +2,10 @@ AM_CPPFLAGS +=3D -I$(srcdir)
>  =

>  noinst_PROGRAMS =3D fork fork2
>  fork_SOURCES =3D fork.c ust_tests_fork.h
> -fork_LDADD =3D -llttng-ust -llttng-ust-fork $(DL_LIBS)
> +fork_LDADD =3D $(UST_LIBS) -llttng-ust-fork $(DL_LIBS)
>  =

>  fork2_SOURCES =3D fork2.c
> -fork2_LDADD =3D -llttng-ust -llttng-ust-fork $(DL_LIBS)
> +fork2_LDADD =3D $(UST_LIBS) -llttng-ust-fork $(DL_LIBS)
>  =

>  noinst_SCRIPTS =3D test_fork test_fork.py
>  EXTRA_DIST =3D test_fork test_fork.py
> diff --git a/tests/regression/ust/high-throughput/Makefile.am b/tests/reg=
ression/ust/high-throughput/Makefile.am
> index f71dfd4df..1bb87af49 100644
> --- a/tests/regression/ust/high-throughput/Makefile.am
> +++ b/tests/regression/ust/high-throughput/Makefile.am
> @@ -2,7 +2,7 @@ AM_CPPFLAGS +=3D -I$(srcdir)
>  =

>  noinst_PROGRAMS =3D gen-events
>  gen_events_SOURCES =3D main.c tp.c tp.h
> -gen_events_LDADD =3D -llttng-ust $(DL_LIBS)
> +gen_events_LDADD =3D $(UST_LIBS) $(DL_LIBS)
>  =

>  noinst_SCRIPTS =3D test_high_throughput
>  EXTRA_DIST =3D test_high_throughput
> diff --git a/tests/regression/ust/libc-wrapper/Makefile.am b/tests/regres=
sion/ust/libc-wrapper/Makefile.am
> index 2a800728e..e1f1fec58 100644
> --- a/tests/regression/ust/libc-wrapper/Makefile.am
> +++ b/tests/regression/ust/libc-wrapper/Makefile.am
> @@ -1,6 +1,6 @@
>  noinst_PROGRAMS =3D prog
>  prog_SOURCES =3D prog.c
> -prog_LDADD =3D -llttng-ust -llttng-ust-libc-wrapper
> +prog_LDADD =3D $(UST_LIBS) -llttng-ust-libc-wrapper
>  =

>  noinst_SCRIPTS =3D test_libc-wrapper test_libc-wrapper.py
>  EXTRA_DIST =3D test_libc-wrapper test_libc-wrapper.py
> diff --git a/tests/regression/ust/linking/Makefile.am b/tests/regression/=
ust/linking/Makefile.am
> index c8585698d..febb6e3c1 100644
> --- a/tests/regression/ust/linking/Makefile.am
> +++ b/tests/regression/ust/linking/Makefile.am
> @@ -9,7 +9,7 @@ LIBS =3D
>  # Build a version of the test app with built-in tracepoints
>  demo_builtin_SOURCES =3D demo.c tp.c tp2.c tp3.c ust_tests_demo.h \
>  	ust_tests_demo2.h ust_tests_demo3.h
> -demo_builtin_LDADD =3D -llttng-ust $(DL_LIBS)
> +demo_builtin_LDADD =3D $(UST_LIBS) $(DL_LIBS)
>  demo_builtin_CFLAGS =3D -Werror=3Dold-style-definition $(AM_CFLAGS)
>  =

>  # Build a version statically linked to the providers
> @@ -21,13 +21,13 @@ liblttng_ust_provider_ust_tests_demo_static_la_SOURCE=
S =3D \
>  	tp.c ust_tests_demo.h \
>  	tp2.c ust_tests_demo2.h
>  liblttng_ust_provider_ust_tests_demo_static_la_LIBADD =3D \
> -	-llttng-ust
> +	$(UST_LIBS)
>  =

>  # contains ust_tests_demo3.h provider probes
>  liblttng_ust_provider_ust_tests_demo3_static_la_SOURCES =3D \
>  	tp3.c ust_tests_demo3.h
>  liblttng_ust_provider_ust_tests_demo3_static_la_LIBADD =3D \
> -	-llttng-ust
> +	$(UST_LIBS)
>  =

>  demo_static_SOURCES =3D demo.c
>  demo_static_LDADD =3D liblttng-ust-provider-ust-tests-demo-static.la \
> @@ -58,14 +58,14 @@ noinst_LTLIBRARIES +=3D liblttng-ust-provider-ust-tes=
ts-demo.la \
>  liblttng_ust_provider_ust_tests_demo_la_SOURCES =3D \
>  	tp.c ust_tests_demo.h \
>  	tp2.c ust_tests_demo2.h
> -liblttng_ust_provider_ust_tests_demo_la_LIBADD =3D -llttng-ust
> +liblttng_ust_provider_ust_tests_demo_la_LIBADD =3D $(UST_LIBS)
>  liblttng_ust_provider_ust_tests_demo_la_LDFLAGS =3D \
>  	$(FORCE_SHARED_LIB_OPTIONS)
>  =

>  #contains ust_tests_demo3.h provider probes
>  liblttng_ust_provider_ust_tests_demo3_la_SOURCES =3D \
>  	tp3.c ust_tests_demo3.h
> -liblttng_ust_provider_ust_tests_demo3_la_LIBADD =3D -llttng-ust
> +liblttng_ust_provider_ust_tests_demo3_la_LIBADD =3D $(UST_LIBS)
>  liblttng_ust_provider_ust_tests_demo3_la_LDFLAGS =3D \
>  	$(FORCE_SHARED_LIB_OPTIONS)
>  =

> diff --git a/tests/regression/ust/low-throughput/Makefile.am b/tests/regr=
ession/ust/low-throughput/Makefile.am
> index 95022b9f9..aacb83716 100644
> --- a/tests/regression/ust/low-throughput/Makefile.am
> +++ b/tests/regression/ust/low-throughput/Makefile.am
> @@ -2,7 +2,7 @@ AM_CPPFLAGS +=3D -I$(srcdir)
>  =

>  noinst_PROGRAMS =3D gen-events
>  gen_events_SOURCES =3D main.c tp.c tp.h
> -gen_events_LDADD =3D -llttng-ust -lurcu $(DL_LIBS)
> +gen_events_LDADD =3D $(UST_LIBS) $(DL_LIBS)
>  =

>  noinst_SCRIPTS =3D test_low_throughput
>  EXTRA_DIST =3D test_low_throughput
> diff --git a/tests/regression/ust/multi-lib/Makefile.am b/tests/regressio=
n/ust/multi-lib/Makefile.am
> index 17ccf3e64..0ce46a7ff 100644
> --- a/tests/regression/ust/multi-lib/Makefile.am
> +++ b/tests/regression/ust/multi-lib/Makefile.am
> @@ -7,12 +7,12 @@ exec_with_callsites_LDFLAGS =3D -ldl $(POPT_LIBS)
>  exec_with_callsites_CFLAGS =3D $(POPT_CFLAGS) $(AM_CFLAGS) -DHAS_CALLSIT=
ES=3D1
>  =

>  exec_without_callsites_SOURCES =3D multi-lib-test.c
> -exec_without_callsites_LDFLAGS =3D -ldl $(POPT_LIBS) -llttng-ust
> +exec_without_callsites_LDFLAGS =3D -ldl $(POPT_LIBS) $(UST_LIBS)
>  exec_without_callsites_LDADD =3D probes.o
>  exec_without_callsites_CFLAGS =3D $(POPT_CFLAGS) $(AM_CFLAGS) -DHAS_CALL=
SITES=3D0
>  =

>  PROBES_SRC=3Dprobes.c probes.h
> -PROBES_LDF=3D-shared -module -llttng-ust -avoid-version -rpath $(abs_bui=
lddir)/.libs/
> +PROBES_LDF=3D-shared -module $(UST_LIBS) -avoid-version -rpath $(abs_bui=
lddir)/.libs/
>  PROBES_CF=3D$(AM_CFLAGS) $(AM_CPPFLAGS) $(CFLAGS) $(CPPFLAGS) -c -I$(src=
dir)/
>  =

>  probes.o: probes.c probes.h
> @@ -29,7 +29,7 @@ noinst_LTLIBRARIES =3D libprobes_a.la libprobes_a_prime=
.la \
>  noinst_LTLIBRARIES +=3D libcallsites_1.la libcallsites_2.la
>  =

>  CALLSITES_SRC=3Dcallsites.c callsites.h
> -CALLSITES_LDF=3D-shared -module -llttng-ust -avoid-version -rpath $(abs_=
builddir)/.libs/
> +CALLSITES_LDF=3D-shared -module $(UST_LIBS) -avoid-version -rpath $(abs_=
builddir)/.libs/
>  CALLSITES_CF=3D-c -I.
>  =

>  libprobes_a_la_SOURCES =3D $(PROBES_SRC)
> diff --git a/tests/regression/ust/multi-session/Makefile.am b/tests/regre=
ssion/ust/multi-session/Makefile.am
> index 204ae7bcf..0d807a878 100644
> --- a/tests/regression/ust/multi-session/Makefile.am
> +++ b/tests/regression/ust/multi-session/Makefile.am
> @@ -2,7 +2,7 @@ AM_CFLAGS +=3D -I$(srcdir)
>  =

>  noinst_PROGRAMS =3D gen-nevents
>  gen_nevents_SOURCES =3D gen-nevents.c tp.c ust_gen_nevents.h
> -gen_nevents_LDADD =3D -llttng-ust -lurcu-bp $(DL_LIBS)
> +gen_nevents_LDADD =3D $(UST_LIBS) $(DL_LIBS)
>  =

>  noinst_SCRIPTS =3D test_multi_session
>  EXTRA_DIST =3D test_multi_session
> diff --git a/tests/regression/ust/overlap/demo/Makefile.am b/tests/regres=
sion/ust/overlap/demo/Makefile.am
> index fbb399cd4..348adbe90 100644
> --- a/tests/regression/ust/overlap/demo/Makefile.am
> +++ b/tests/regression/ust/overlap/demo/Makefile.am
> @@ -21,12 +21,12 @@ FORCE_SHARED_LIB_OPTIONS =3D -module -shared -avoid-v=
ersion \
>  liblttng_ust_provider_ust_tests_demo_la_SOURCES =3D \
>  	tp.c ust_tests_demo.h \
>  	tp2.c ust_tests_demo2.h
> -liblttng_ust_provider_ust_tests_demo_la_LIBADD =3D -llttng-ust
> +liblttng_ust_provider_ust_tests_demo_la_LIBADD =3D $(UST_LIBS)
>  liblttng_ust_provider_ust_tests_demo_la_LDFLAGS =3D $(FORCE_SHARED_LIB_O=
PTIONS)
>  =

>  #contains ust_tests_demo3.h provider probes
>  liblttng_ust_provider_ust_tests_demo3_la_SOURCES =3D tp3.c ust_tests_dem=
o3.h
> -liblttng_ust_provider_ust_tests_demo3_la_LIBADD =3D -llttng-ust
> +liblttng_ust_provider_ust_tests_demo3_la_LIBADD =3D $(UST_LIBS)
>  liblttng_ust_provider_ust_tests_demo3_la_LDFLAGS =3D $(FORCE_SHARED_LIB_=
OPTIONS)
>  =

>  noinst_LTLIBRARIES =3D liblttng-ust-provider-ust-tests-demo.la \
> diff --git a/tests/regression/ust/type-declarations/Makefile.am b/tests/r=
egression/ust/type-declarations/Makefile.am
> index db39b1cc3..dd4eda26b 100644
> --- a/tests/regression/ust/type-declarations/Makefile.am
> +++ b/tests/regression/ust/type-declarations/Makefile.am
> @@ -2,7 +2,8 @@ AM_CPPFLAGS +=3D -I$(srcdir)
>  =

>  noinst_PROGRAMS =3D type-declarations
>  type_declarations_SOURCES =3D type-declarations.c ust_tests_td.h
> -type_declarations_LDADD =3D -llttng-ust $(DL_LIBS)
> +type_declarations_LDADD =3D $(UST_LIBS) $(DL_LIBS)
> +type_declarations_CPPFLAGS =3D $(UST_CFLAGS) $(DL_CFLAGS) $(AM_CPPFLAGS)
>  =

>  noinst_SCRIPTS =3D test_type_declarations test_type_declarations.py
>  EXTRA_DIST =3D test_type_declarations test_type_declarations.py
> diff --git a/tests/unit/Makefile.am b/tests/unit/Makefile.am
> index 460e2f752..dd83bc636 100644
> --- a/tests/unit/Makefile.am
> +++ b/tests/unit/Makefile.am
> @@ -105,7 +105,7 @@ test_session_LDADD =3D $(LIBTAP) $(LIBCOMMON) $(LIBRE=
LAYD) $(LIBSESSIOND_COMM) \
>  test_session_LDADD +=3D $(SESSIOND_OBJS)
>  =

>  if HAVE_LIBLTTNG_UST_CTL
> -test_session_LDADD +=3D -llttng-ust-ctl
> +test_session_LDADD +=3D $(UST_CTL_LIBS)
>  endif
>  =

>  # UST data structures unit test
> @@ -113,7 +113,7 @@ if HAVE_LIBLTTNG_UST_CTL
>  test_ust_data_SOURCES =3D test_ust_data.c
>  test_ust_data_LDADD =3D $(LIBTAP) $(LIBCOMMON) $(LIBRELAYD) $(LIBSESSION=
D_COMM) \
>  		      $(LIBHASHTABLE) $(DL_LIBS) -lrt -lurcu-common -lurcu \
> -		      -llttng-ust-ctl \
> +		      $(UST_CTL_LIBS) \
>  		      $(KMOD_LIBS) \
>  		      $(top_builddir)/src/lib/lttng-ctl/liblttng-ctl.la \
>  		      $(top_builddir)/src/common/kernel-ctl/libkernel-ctl.la \
> diff --git a/tests/utils/testapp/gen-ust-events-ns/Makefile.am b/tests/ut=
ils/testapp/gen-ust-events-ns/Makefile.am
> index 39f991240..ad9203c4e 100644
> --- a/tests/utils/testapp/gen-ust-events-ns/Makefile.am
> +++ b/tests/utils/testapp/gen-ust-events-ns/Makefile.am
> @@ -4,7 +4,7 @@ AM_CPPFLAGS +=3D -I$(top_srcdir)/tests/utils -I$(srcdir) \
>  if HAVE_LIBLTTNG_UST_CTL
>  noinst_PROGRAMS =3D gen-ust-events-ns
>  gen_ust_events_ns_SOURCES =3D gen-ust-events-ns.c tp.c tp.h
> -gen_ust_events_ns_LDADD =3D -llttng-ust -lurcu-bp -llttng-ust-fork \
> +gen_ust_events_ns_LDADD =3D $(UST_LIBS) -llttng-ust-fork \
>  		$(top_builddir)/tests/utils/libtestutils.la \
>  		$(DL_LIBS) $(POPT_LIBS)
>  endif
> diff --git a/tests/utils/testapp/gen-ust-events/Makefile.am b/tests/utils=
/testapp/gen-ust-events/Makefile.am
> index 3169b6ef4..38e620d75 100644
> --- a/tests/utils/testapp/gen-ust-events/Makefile.am
> +++ b/tests/utils/testapp/gen-ust-events/Makefile.am
> @@ -4,7 +4,7 @@ AM_CPPFLAGS +=3D -I$(top_srcdir)/tests/utils -I$(srcdir) \
>  if HAVE_LIBLTTNG_UST_CTL
>  noinst_PROGRAMS =3D gen-ust-events
>  gen_ust_events_SOURCES =3D gen-ust-events.c tp.c tp.h
> -gen_ust_events_LDADD =3D -llttng-ust -lurcu-bp \
> +gen_ust_events_LDADD =3D $(UST_LIBS) \
>  		$(top_builddir)/tests/utils/libtestutils.la \
>  		$(DL_LIBS)
>  endif
> diff --git a/tests/utils/testapp/gen-ust-nevents-str/Makefile.am b/tests/=
utils/testapp/gen-ust-nevents-str/Makefile.am
> index 5f07e795b..0e961b4c4 100644
> --- a/tests/utils/testapp/gen-ust-nevents-str/Makefile.am
> +++ b/tests/utils/testapp/gen-ust-nevents-str/Makefile.am
> @@ -4,7 +4,7 @@ AM_CPPFLAGS +=3D -I$(srcdir) -I$(top_srcdir)/tests/utils \
>  if HAVE_LIBLTTNG_UST_CTL
>  noinst_PROGRAMS =3D gen-ust-nevents-str
>  gen_ust_nevents_str_SOURCES =3D gen-ust-nevents-str.c tp.c tp.h
> -gen_ust_nevents_str_LDADD =3D -llttng-ust -lurcu-bp \
> +gen_ust_nevents_str_LDADD =3D $(UST_LIBS) \
>  		$(top_builddir)/tests/utils/libtestutils.la \
>  		$(DL_LIBS)
>  endif
> diff --git a/tests/utils/testapp/gen-ust-nevents/Makefile.am b/tests/util=
s/testapp/gen-ust-nevents/Makefile.am
> index 33c2d41ef..c20910bd8 100644
> --- a/tests/utils/testapp/gen-ust-nevents/Makefile.am
> +++ b/tests/utils/testapp/gen-ust-nevents/Makefile.am
> @@ -4,7 +4,7 @@ AM_CPPFLAGS +=3D -I$(srcdir) -I$(top_srcdir)/tests/utils \
>  if HAVE_LIBLTTNG_UST_CTL
>  noinst_PROGRAMS =3D gen-ust-nevents
>  gen_ust_nevents_SOURCES =3D gen-ust-nevents.c tp.c tp.h
> -gen_ust_nevents_LDADD =3D -llttng-ust -lurcu-bp \
> +gen_ust_nevents_LDADD =3D $(UST_LIBS) \
>  		$(top_builddir)/tests/utils/libtestutils.la \
>  		$(DL_LIBS)
>  endif
> diff --git a/tests/utils/testapp/gen-ust-tracef/Makefile.am b/tests/utils=
/testapp/gen-ust-tracef/Makefile.am
> index 60ed301d1..8e88c0e0c 100644
> --- a/tests/utils/testapp/gen-ust-tracef/Makefile.am
> +++ b/tests/utils/testapp/gen-ust-tracef/Makefile.am
> @@ -4,5 +4,5 @@ AM_CPPFLAGS +=3D -I$(srcdir) \
>  if HAVE_LIBLTTNG_UST_CTL
>  noinst_PROGRAMS =3D gen-ust-tracef
>  gen_ust_tracef_SOURCES =3D gen-ust-tracef.c
> -gen_ust_tracef_LDADD =3D -llttng-ust $(DL_LIBS)
> +gen_ust_tracef_LDADD =3D $(UST_LIBS) $(DL_LIBS)
>  endif
> -- =

> 2.17.1
> =
