From: Pierre-Luc St-Charles <pierre-luc.st-charles@polymtl.ca>
Subject: Re: [PATCH lttng-tools 14/14] Cleaned up configure.ac:
 Replaced space indents by tabs, regrouped AC_ARG_WITH's,
 generalized the coding style, fixed a bad AS_HELP_STRING.
Date: Mon, 6 May 2013 15:43:13 -0400
Message-ID: <CA+umk=orZ1Oq6xRtJWuC7109V3wOH5B0eLS7e86+sqPn5QcqXg__44590.5445413247$1367869441$gmane$org@mail.gmail.com>
References: <1367864331-15212-1-git-send-email-charlesbriere.flatzo@gmail.com>
	<1367864331-15212-14-git-send-email-charlesbriere.flatzo@gmail.com>
	<51880356.4050009@efficios.com> <20130506192838.GA21679@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0065148600=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-da0-f51.google.com ([209.85.210.51])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <b0mb00z.it@gmail.com>) id 1UZRJf-0001BV-T8
	for lttng-dev@lists.lttng.org; Mon, 06 May 2013 15:43:20 -0400
Received: by mail-da0-f51.google.com with SMTP id h15so1927199dan.38
	for <lttng-dev@lists.lttng.org>; Mon, 06 May 2013 12:43:14 -0700 (PDT)
In-Reply-To: <20130506192838.GA21679@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Charles Briere <charlesbriere.flatzo@gmail.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0065148600==
Content-Type: multipart/alternative; boundary=047d7b86c1ec54aeab04dc11e9e8

--047d7b86c1ec54aeab04dc11e9e8
Content-Type: text/plain; charset=ISO-8859-1

Hmm, I agree the 3+ patch split might be a better idea; as for the
'generalized coding style', it was more of a parenthesis usage &
positionning cleanup to make sure the same style was applied everywhere (I
tried to pick whatever style was the most present at the time). There were
a lot of floating brackets here and there, and some function arguments were
not properly tabbed. These changes fixed most (?) of these issues while
keeping readability in mind.

We'll get working on all these fixes in the next few days, but for now,
thanks for the comments!


On Mon, May 6, 2013 at 3:28 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> * David Goulet (dgoulet@efficios.com) wrote:
> > Why?
>
> cleaning up the configure.ac is a good thing. However, this patch should
> probably be split into 3 patches.
>
> 1) Cleanup: configure.ac: replace space indents by tabs
> 2) Cleanup: configure.ac: regroup AC_ARG_WITH
> 3) Error message fix: configure.ac: fix bad AS_HELP_STRING
>
> Not sure about "generalized coding style" though. It might require more
> explanation.
>
> Thanks,
>
> Mathieu
>
> >
> > Thanks!
> > David
> >
> > Charles Briere:
> > > From: Pierre-Luc St-Charles <pierre-luc.st-charles@polymtl.ca>
> > >
> > > Signed-off-by: Pierre-Luc St-Charles <pierre-luc.st-charles@polymtl.ca
> >
> > > ---
> > >  configure.ac | 315
> ++++++++++++++++++++++++++++++++---------------------------
> > >  1 file changed, 171 insertions(+), 144 deletions(-)
> > >
> > > diff --git a/configure.ac b/configure.ac
> > > index 154b0a7..e4d2c6f 100644
> > > --- a/configure.ac
> > > +++ b/configure.ac
> > > @@ -17,27 +17,32 @@ AC_CONFIG_HEADERS([include/config.h])
> > >  AC_PROG_GREP
> > >  # libtool link_all_deplibs fixup. See
> http://bugs.lttng.org/issues/321.
> > >  AC_ARG_ENABLE(libtool-linkdep-fixup,
> > > -   AS_HELP_STRING([--disable-libtool-linkdep-fixup],
> > > -                   [disable the libtool fixup for linking all
> dependent libraries (link_all_deplibs)]),
> > > -   libtool_fixup=$enableval,
> > > -   libtool_fixup=yes)
> > > +[
> > > +   AS_HELP_STRING([--disable-libtool-linkdep-fixup],[disable the
> libtool fixup for linking all dependent libraries (link_all_deplibs)])
> > > +],
> > > +[
> > > +   libtool_fixup=$enableval
> > > +],
> > > +[
> > > +   libtool_fixup=yes
> > > +])
> > >
> > >  AS_IF([test "x$libtool_fixup" = "xyes"],
> > > -       [
> > > -       libtool_m4="$srcdir/config/libtool.m4"
> > > -       libtool_flag_pattern=".*link_all_deplibs\s*,\s*\$1\s*)"
> > > -       AC_MSG_CHECKING([for occurence(s) of link_all_deplibs = no in
> $libtool_m4])
> > > -       libtool_flag_pattern_count=$(grep -c
> "$libtool_flag_pattern\s*=\s*no" $libtool_m4)
> > > -       AS_IF([test $libtool_flag_pattern_count -ne 0],
> > > -       [
> > > -             AC_MSG_RESULT([$libtool_flag_pattern_count])
> > > -             AC_MSG_WARN([the detected libtool will not link all
> dependencies, forcing link_all_deplibs = unknown])
> > > -             sed -i
> "s/\($libtool_flag_pattern\)\s*=\s*no/\1=unknown/g" $libtool_m4
> > > -             ],
> > > -             [
> > > -             AC_MSG_RESULT([none])
> > > -             ])
> > > -       ])
> > > +[
> > > +   libtool_m4="$srcdir/config/libtool.m4"
> > > +   libtool_flag_pattern=".*link_all_deplibs\s*,\s*\$1\s*)"
> > > +   AC_MSG_CHECKING([for occurence(s) of link_all_deplibs = no in
> $libtool_m4])
> > > +   libtool_flag_pattern_count=$(grep -c
> "$libtool_flag_pattern\s*=\s*no" $libtool_m4)
> > > +   AS_IF([test $libtool_flag_pattern_count -ne 0],
> > > +   [
> > > +           AC_MSG_RESULT([$libtool_flag_pattern_count])
> > > +           AC_MSG_WARN([the detected libtool will not link all
> dependencies, forcing link_all_deplibs = unknown])
> > > +           sed -i "s/\($libtool_flag_pattern\)\s*=\s*no/\1=unknown/g"
> $libtool_m4
> > > +   ],
> > > +   [
> > > +           AC_MSG_RESULT([none])
> > > +   ])
> > > +])
> > >
> > >  AM_CONDITIONAL([NO_SHARED], [test x$enable_shared = xno])
> > >
> > > @@ -57,55 +62,55 @@ AC_CHECK_HEADERS([ \
> > >
> > >  # Babeltrace viewer check
> > >  AC_ARG_WITH([babeltrace-bin],
> > > -   AS_HELP_STRING([--with-babeltrace-bin],
> > > -   [Location of the babeltrace viewer executable (including the
> filename)]),
> > > +   AS_HELP_STRING([--with-babeltrace-bin], [Location of the
> babeltrace viewer executable (including the filename)]),
> > >     [BABELTRACE_BIN="$withval"],
> > >     [BABELTRACE_BIN=''])
> > >  AC_SUBST([BABELTRACE_BIN])
> > >
> > >  # lttv-gui
> > >  AC_ARG_WITH([lttv-gui-bin],
> > > -   AS_HELP_STRING([--with-lttv-gui-bin],
> > > -   [Location of the lttv GUI viewer executable (including the
> filename)]),
> > > -   [LTTV_GUI_BIN="$withval"],
> > > -   [LTTV_GUI_BIN=''])
> > > +   AS_HELP_STRING([--with-lttv-gui-bin], [Location of the lttv GUI
> viewer executable (including the filename)]),
> > > +   [LTTV_GUI_BIN="$withval"],
> > > +   [LTTV_GUI_BIN=''])
> > >  AC_SUBST([LTTV_GUI_BIN])
> > >
> > >  AC_ARG_WITH([consumerd32-bin],
> > > -   AS_HELP_STRING([--with-consumerd32-bin],
> > > -   [Location of the 32-bit consumerd executable (including the
> filename)]),
> > > +   AS_HELP_STRING([--with-consumerd32-bin], [Location of the 32-bit
> consumerd executable (including the filename)]),
> > >     [CONSUMERD32_BIN="$withval"],
> > >     [CONSUMERD32_BIN=''])
> > >  AC_SUBST([CONSUMERD32_BIN])
> > >
> > >  AC_ARG_WITH([consumerd64-bin],
> > > -   AS_HELP_STRING([--with-consumerd64-bin],
> > > -   [Location of the 64-bit consumerd executable (including the
> filename)]),
> > > +   AS_HELP_STRING([--with-consumerd64-bin], [Location of the 64-bit
> consumerd executable (including the filename)]),
> > >     [CONSUMERD64_BIN="$withval"],
> > >     [CONSUMERD64_BIN=''])
> > >  AC_SUBST([CONSUMERD64_BIN])
> > >
> > >  AC_ARG_WITH([consumerd32-libdir],
> > > -   AS_HELP_STRING([--with-consumerd32-libdir],
> > > -   [Directory containing the 32-bit consumerd libraries]),
> > > +   AS_HELP_STRING([--with-consumerd32-libdir], [Directory containing
> the 32-bit consumerd libraries]),
> > >     [CONSUMERD32_LIBDIR="$withval"],
> > >     [CONSUMERD32_LIBDIR=''])
> > >  AC_SUBST([CONSUMERD32_LIBDIR])
> > >
> > >  AC_ARG_WITH([consumerd64-libdir],
> > > -   AS_HELP_STRING([--with-consumerd64-libdir],
> > > -   [Directory containing the 64-bit consumerd libraries]),
> > > +   AS_HELP_STRING([--with-consumerd64-libdir], [Directory containing
> the 64-bit consumerd libraries]),
> > >     [CONSUMERD64_LIBDIR="$withval"],
> > >     [CONSUMERD64_LIBDIR=''])
> > >  AC_SUBST([CONSUMERD64_LIBDIR])
> > >
> > >  AC_ARG_WITH([sessiond-bin],
> > > -   AS_HELP_STRING([--with-sessiond-bin],
> > > -   [Location of the sessiond executable (including the filename)]),
> > > +   AS_HELP_STRING([--with-sessiond-bin], [Location of the sessiond
> executable (including the filename)]),
> > >     [SESSIOND_BIN="$withval"],
> > >     [SESSIOND_BIN=''])
> > >  AC_SUBST([SESSIOND_BIN])
> > >
> > > +# Option to only build the consumer daemon and its libraries
> > > +AC_ARG_WITH([consumerd-only],
> > > +   AS_HELP_STRING([--with-consumerd-only], [Only build the consumer
> daemon [default=no]]),
> > > +   [consumerd_only=$withval],
> > > +   [consumerd_only=no])
> > > +AM_CONDITIONAL([BUILD_CONSUMERD_ONLY], [test "x$consumerd_only" =
> "xyes"])
> > > +
> > >  AC_DEFINE_UNQUOTED([CONFIG_CONSUMERD32_BIN], "$CONSUMERD32_BIN",
> [Location of the 32-bit consumerd executable.])
> > >  AC_DEFINE_UNQUOTED([CONFIG_CONSUMERD64_BIN], "$CONSUMERD64_BIN",
> [Location of the 64-bit consumerd executable])
> > >  AC_DEFINE_UNQUOTED([CONFIG_CONSUMERD32_LIBDIR],
> "$CONSUMERD32_LIBDIR", [Search for consumerd 32-bit libraries in this
> location.])
> > > @@ -117,23 +122,24 @@ AC_DEFINE_UNQUOTED([CONFIG_SESSIOND_BIN],
> "$SESSIOND_BIN", [Location of the sess
> > >  # Check for pthread
> > >  AC_CHECK_LIB([pthread], [pthread_create], [],
> > >  [
> > > -    # Check for pthread in a bionic libc...
> > > +   # Check for pthread in a bionic libc...
> > >     AC_CHECK_LIB([c], [pthread_create], [],
> > >     [
> > > -       AC_MSG_ERROR([Cannot find libpthread. Use [LDFLAGS]=-Ldir to
> specify its location.])
> > > +           AC_MSG_ERROR([Cannot find libpthread. Use [LDFLAGS]=-Ldir
> to specify its location.])
> > >     ])
> > > -]
> > > -)
> > > +])
> > >
> > >  # Check low-level endian compat functions
> > >  AC_CHECK_DECL(be64toh, [],
> > >  [
> > > -   AC_CHECK_DECL(betoh64, [AC_DEFINE_UNQUOTED([LTTNG_HAVE_BETOH64],
> 1, [Has BSD-style endian conversion operations.])],
> > > +   AC_CHECK_DECL(betoh64,
> > > +   [
> > > +           AC_DEFINE_UNQUOTED([LTTNG_HAVE_BETOH64], 1, [Has BSD-style
> endian conversion operations.])
> > > +   ],
> > >     [
> > >             AC_MSG_ERROR([Cannot find be64toh, betoh64 or any similar
> functions.])
> > >     ])
> > > -]
> > > -)
> > > +])
> > >
> > >  # Check if gettid() is already defined
> > >  AC_CHECK_DECL(gettid,
> > > @@ -146,11 +152,10 @@ AC_CHECK_LIB([popt], [poptGetContext], [],
> > >  [
> > >     # Check for libpopt in oprofile for Android
> > >     AC_CHECK_LIB([oprofile_popt], [poptGetContext], [],
> > > -    [
> > > -        AC_MSG_ERROR([Cannot find libpopt. Use [LDFLAGS]=-Ldir to
> specify its location.])
> > > -    ])
> > > -]
> > > -)
> > > +   [
> > > +           AC_MSG_ERROR([Cannot find libpopt. Use [LDFLAGS]=-Ldir to
> specify its location.])
> > > +   ])
> > > +])
> > >
> > >  # Check for libuuid
> > >  AC_CHECK_LIB([uuid], [uuid_generate],
> > > @@ -176,8 +181,7 @@ AC_CHECK_LIB([uuid], [uuid_generate],
> > >                     AC_MSG_ERROR([Cannot find libuuid uuid_generate,
> libc uuid_create nor libext2_uuid uuid_generate. Use [LDFLAGS]=-Ldir to
> specify their location.])
> > >             ])
> > >     ])
> > > -]
> > > -)
> > > +])
> > >  AM_CONDITIONAL([LTTNG_BUILD_WITH_LIBUUID], [test "x$have_libuuid" =
> "xyes"])
> > >  AM_CONDITIONAL([LTTNG_BUILD_WITH_LIBC_UUID], [test "x$have_libc_uuid"
> = "xyes"])
> > >  AM_CONDITIONAL([LTTNG_BUILD_WITH_LIBEXT2_UUID], [test
> "x$have_libext2_uuid" = "xyes"])
> > > @@ -222,41 +226,59 @@ liburcu_version=">= 0.7.2"
> > >
> > >  # Check liburcu needed function calls
> > >  AC_CHECK_DECL([cds_list_add], [],
> > > -   [AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])],
> [[#include <urcu/list.h>]]
> > > -)
> > > +[
> > > +   AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])],
> [[#include <urcu/list.h>]
> > > +])
> > >  AC_CHECK_DECL([cds_wfq_init], [],
> > > -   [AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])],
> [[#include <urcu/wfqueue.h>]]
> > > -)
> > > +[
> > > +   AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])],
> [[#include <urcu/wfqueue.h>]
> > > +])
> > >  AC_CHECK_DECL([cds_wfq_dequeue_blocking], [],
> > > -    [AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])],
> [[#include <urcu/wfqueue.h>]]
> > > -)
> > > +[
> > > +   AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])],
> [[#include <urcu/wfqueue.h>]
> > > +])
> > >  AC_CHECK_DECL([futex_async], [],
> > > -   [AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])],
> [[#include <urcu/futex.h>]]
> > > -)
> > > +[
> > > +   AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])],
> [[#include <urcu/futex.h>]
> > > +])
> > >  AC_CHECK_DECL([rcu_thread_offline], [],
> > > -   [AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])],
> [[#include <urcu.h>]]
> > > -)
> > > +[
> > > +   AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])],
> [[#include <urcu.h>]
> > > +])
> > >  AC_CHECK_DECL([rcu_thread_online], [],
> > > -   [AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])],
> [[#include <urcu.h>]]
> > > -)
> > > +[
> > > +   AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])],
> [[#include <urcu.h>]
> > > +])
> > >  AC_CHECK_DECL([caa_likely], [],
> > > -   [AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])],
> [[#include <urcu.h>]]
> > > -)
> > > +[
> > > +   AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])],
> [[#include <urcu.h>]
> > > +])
> > >
> > >  # Check liblttng-ust-ctl library
> > >  AC_ARG_ENABLE(lttng-ust,
> > > -   AS_HELP_STRING([--disable-lttng-ust],[build without LTTng-UST
> (Userspace Tracing) support]),
> > > -   lttng_ust_support=$enableval, lttng_ust_support=yes)
> > > +[
> > > +   AS_HELP_STRING([--disable-lttng-ust],[build without LTTng-UST
> (Userspace Tracing) support])
> > > +],
> > > +[
> > > +   lttng_ust_support=$enableval
> > > +],
> > > +[
> > > +   lttng_ust_support=yes
> > > +])
> > >
> > > -AS_IF([test "x$lttng_ust_support" = "xyes"], [
> > > +AS_IF([test "x$lttng_ust_support" = "xyes"],
> > > +[
> > >     AC_CHECK_LIB([lttng-ust-ctl], [ustctl_set_filter],
> > > -           [
> > > -                   AC_DEFINE([HAVE_LIBLTTNG_UST_CTL], [1], [has
> LTTng-UST control support])
> > > -                   lttng_ust_ctl_found=yes
> > > -           ],
> > > -           [AC_MSG_ERROR([Cannot find LTTng-UST 2.1.x. Use
> [LDFLAGS]=-Ldir to specify its location, or specify --disable-lttng-ust to
> build lttng-tools without LTTng-UST support.])],
> > > -           [-lurcu-common -lurcu-bp -lurcu-cds -lc -lrt]
> > > -   )
> > > +   [
> > > +           AC_DEFINE([HAVE_LIBLTTNG_UST_CTL], [1], [has LTTng-UST
> control support])
> > > +           lttng_ust_ctl_found=yes
> > > +   ],
> > > +   [
> > > +           AC_MSG_ERROR([Cannot find LTTng-UST 2.1.x. Use
> [LDFLAGS]=-Ldir to specify its location, or specify --disable-lttng-ust to
> build lttng-tools without LTTng-UST support.])
> > > +   ],
> > > +   [
> > > +           -lurcu-common -lurcu-bp -lurcu-cds -lc -lrt
> > > +   ])
> > >  ])
> > >  AM_CONDITIONAL([HAVE_LIBLTTNG_UST_CTL], [test "x$lttng_ust_ctl_found"
> = xyes])
> > >  AC_CHECK_FUNCS([sched_getcpu sysconf sync_file_range])
> > > @@ -283,18 +305,15 @@ AM_CONDITIONAL([LTTNG_TOOLS_BUILD_WITH_LIBC_DL],
> [test "x$have_libc_dl" = "xyes"
> > >  AC_CHECK_LIB([c], [fmemopen],
> > >  [
> > >     AC_DEFINE_UNQUOTED([LTTNG_HAVE_FMEMOPEN], 1, [Has fmemopen
> support.])
> > > -]
> > > -)
> > > +])
> > >
> > >  # Check for open_memstream
> > >  AC_CHECK_LIB([c], [open_memstream],
> > >  [
> > >     AC_DEFINE_UNQUOTED([LTTNG_HAVE_OPEN_MEMSTREAM], 1, [Has
> open_memstream support.])
> > > -]
> > > -)
> > > +])
> > >
> > >  AC_ARG_VAR([LTTNG_RUNDIR], [Path to run directory, default to
> /var/run])
> > > -
> > >  AS_IF([test -n "$LTTNG_RUNDIR"],
> > >  [
> > >     lttng_rundir=$LTTNG_RUNDIR
> > > @@ -315,54 +334,49 @@ AC_DEFINE_UNQUOTED([DEFAULT_LTTNG_RUNDIR],
> ["$lttng_rundir"], [Location of the r
> > >  swig_version=2.0.0
> > >
> > >  AC_ARG_ENABLE([python-bindings],
> > > -              [AC_HELP_STRING([--enable-python-bindings],
> > > -                              [compile Python bindings])],
> > > -              [enable_python=yes], [enable_python=no])
> > > +[
> > > +   AS_HELP_STRING([--enable-python-bindings], [compile Python
> bindings])
> > > +],
> > > +[
> > > +   enable_python=yes
> > > +],
> > > +[
> > > +   enable_python=no
> > > +])
> > >
> > >  AM_CONDITIONAL([USE_PYTHON], [test "x${enable_python:-yes}" = xyes])
> > >
> > >  if test "x${enable_python:-yes}" = xyes; then
> > > -  AX_PKG_SWIG($swig_version, [], [ AC_MSG_ERROR([SWIG $swig_version
> or newer is needed]) ])
> > > -  AM_PATH_PYTHON
> > > -
> > > -  AC_ARG_VAR([PYTHON_INCLUDE], [Include flags for python, bypassing
> python-config])
> > > -  AC_ARG_VAR([PYTHON_CONFIG], [Path to python-config])
> > > -  AS_IF([test -z "$PYTHON_INCLUDE"], [
> > > -    AS_IF([test -z "$PYTHON_CONFIG"], [
> > > -      AC_PATH_PROGS([PYTHON_CONFIG],
> > > -                    [python$PYTHON_VERSION-config python-config],
> > > -                    [no],
> > > -                    [`dirname $PYTHON`])
> > > -      AS_IF([test "$PYTHON_CONFIG" = no], [AC_MSG_ERROR([cannot find
> python-config for $PYTHON. Do you have python-dev installed?])])
> > > -    ])
> > > -    AC_MSG_CHECKING([python include flags])
> > > -    PYTHON_INCLUDE=`$PYTHON_CONFIG --includes`
> > > -    AC_MSG_RESULT([$PYTHON_INCLUDE])
> > > -  ])
> > > -
> > > +   AX_PKG_SWIG($swig_version, [],
> > > +   [
> > > +           AC_MSG_ERROR([SWIG $swig_version or newer is needed])
> > > +   ])
> > > +   AM_PATH_PYTHON
> > > +   AC_ARG_VAR([PYTHON_INCLUDE], [Include flags for python, bypassing
> python-config])
> > > +   AC_ARG_VAR([PYTHON_CONFIG], [Path to python-config])
> > > +   AS_IF([test -z "$PYTHON_INCLUDE"],
> > > +   [
> > > +           AS_IF([test -z "$PYTHON_CONFIG"],
> > > +           [
> > > +                   AC_PATH_PROGS([PYTHON_CONFIG],
> [python$PYTHON_VERSION-config python-config], [no], [`dirname $PYTHON`])
> > > +                   AS_IF([test "$PYTHON_CONFIG" = no],
> > > +                   [
> > > +                           AC_MSG_ERROR([cannot find python-config
> for $PYTHON. Do you have python-dev installed?])
> > > +                   ])
> > > +           ])
> > > +           AC_MSG_CHECKING([python include flags])
> > > +           PYTHON_INCLUDE=`$PYTHON_CONFIG --includes`
> > > +           AC_MSG_RESULT([$PYTHON_INCLUDE])
> > > +   ])
> > >  else
> > > -    AC_MSG_NOTICE([You may configure with --enable-python-bindings
> ]dnl
> > > -[if you want Python bindings.])
> > > -
> > > +   AC_MSG_NOTICE([You may configure with --enable-python-bindings if
> you want Python bindings.])
> > >  fi
> > >
> > > -# Option to only build the consumer daemon and its libraries
> > > -AC_ARG_WITH([consumerd-only],
> > > -   AS_HELP_STRING([--with-consumerd-only],[Only build the consumer
> daemon [default=no]]),
> > > -   [consumerd_only=$withval],
> > > -   [consumerd_only=no])
> > > -AM_CONDITIONAL([BUILD_CONSUMERD_ONLY], [test "x$consumerd_only" =
> "xyes"])
> > > -
> > >  # Epoll check. If not present, the build will fallback on poll() API
> > > -AX_HAVE_EPOLL(
> > > -   [AX_CONFIG_FEATURE_ENABLE(epoll)],
> > > -   [AX_CONFIG_FEATURE_DISABLE(epoll)]
> > > -)
> > > -AX_CONFIG_FEATURE(
> > > -   [epoll], [This platform supports epoll(7)],
> > > -   [HAVE_EPOLL], [This platform supports epoll(7).],
> > > -   [enable_epoll="yes"], [enable_epoll="no"]
> > > -)
> > >
> +AX_HAVE_EPOLL([AX_CONFIG_FEATURE_ENABLE(epoll)],[AX_CONFIG_FEATURE_DISABLE(epoll)])
> > > +AX_CONFIG_FEATURE([epoll], [This platform supports epoll(7)],
> > > +           [HAVE_EPOLL], [This platform supports epoll(7).],
> > > +           [enable_epoll="yes"], [enable_epoll="no"])
> > >  AM_CONDITIONAL([COMPAT_EPOLL], [ test "$enable_epoll" = "yes" ])
> > >
> > >  AC_SYS_LARGEFILE
> > > @@ -455,37 +469,43 @@ AS_ECHO()
> > >  # Target architecture we're building for
> > >  target_arch=$host_cpu
> > >  [
> > > -for f in $CFLAGS; do
> > > -        if test $f = "-m32"; then
> > > +   for f in $CFLAGS; do
> > > +           if test $f = "-m32"; then
> > >                     target_arch="32-bit"
> > > -        elif test $f = "-m64"; then
> > > +           elif test $f = "-m64"; then
> > >                     target_arch="64-bit"
> > > -        fi
> > > -done
> > > +           fi
> > > +   done
> > >  ]
> > >  AS_ECHO_N("Target architecture: ")
> > >  AS_ECHO($target_arch)
> > >
> > >  # LTTng-UST enabled/disabled
> > >  AS_ECHO_N("Lttng-UST support: ")
> > > -AS_IF([test "x$lttng_ust_support" = "xyes"],[
> > > +AS_IF([test "x$lttng_ust_support" = "xyes"],
> > > +[
> > >     AS_ECHO("Enabled")
> > > -],[
> > > +],
> > > +[
> > >     AS_ECHO("Disabled")
> > >  ])
> > >
> > >  #Python binding enabled/disabled
> > >  AS_ECHO_N("Python binding: ")
> > > -AS_IF([test "x${enable_python:-yes}" = xyes], [
> > > +AS_IF([test "x${enable_python:-yes}" = xyes],
> > > +[
> > >     AS_ECHO("Enabled")
> > > -],[
> > > +],
> > > +[
> > >     AS_ECHO("Disabled")
> > >  ])
> > >
> > >  # Do we build only the consumerd, or everything
> > > -AS_IF([test "x$consumerd_only" = "xyes"],[
> > > +AS_IF([test "x$consumerd_only" = "xyes"],
> > > +[
> > >     AS_ECHO("Only the consumerd daemon will be built.")
> > > -],[
> > > +],
> > > +[
> > >     AS_ECHO("All binaries will be built.")
> > >  ])
> > >
> > > @@ -497,45 +517,52 @@ AS_ECHO_N("Libraries will be installed in: ")
> > >  AS_ECHO("`eval eval echo $libdir`")
> > >
> > >  # If we build the sessiond, print the paths it will use
> > > -AS_IF([test "x$consumerd_only" = "xno"],[
> > > +AS_IF([test "x$consumerd_only" = "xno"],
> > > +[
> > >     AS_ECHO()
> > >     AS_ECHO_N("The lttng command will look for the lttng-sessiond
> executable at: ")
> > > -   AS_IF([test "$SESSIOND_BIN" = ""],[
> > > +   AS_IF([test "$SESSIOND_BIN" = ""],
> > > +   [
> > >             AS_ECHO_N("`eval eval echo $bindir`")
> > >             AS_ECHO("/lttng-sessiond")
> > > -   ],[
> > > +   ],
> > > +   [
> > >             AS_ECHO("$SESSIOND_BIN")
> > >     ])
> > > -
> > >     AS_ECHO()
> > >     AS_ECHO("The sessiond daemon will look in the following
> directories: ")
> > >     AS_ECHO_N("32-bit consumerd executable at: ")
> > > -   AS_IF([test "$CONSUMERD32_BIN" = ""],[
> > > +   AS_IF([test "$CONSUMERD32_BIN" = ""],
> > > +   [
> > >             AS_ECHO_N("`eval eval echo $lttnglibexecdir`")
> > >             AS_ECHO("/lttng-consumerd")
> > > -   ],[
> > > +   ],
> > > +   [
> > >             AS_ECHO("$CONSUMERD32_BIN")
> > >     ])
> > > -
> > >     AS_ECHO_N("32-bit consumer libraries in:   ")
> > > -   AS_IF([test "$CONSUMERD32_LIBDIR" = ""],[
> > > +   AS_IF([test "$CONSUMERD32_LIBDIR" = ""],
> > > +   [
> > >             AS_ECHO("`eval eval echo $libdir`")
> > > -   ],[
> > > +   ],
> > > +   [
> > >             AS_ECHO("$CONSUMERD32_LIBDIR")
> > >     ])
> > > -
> > >     AS_ECHO_N("64-bit consumerd executable at: ")
> > > -   AS_IF([test "$CONSUMERD64_BIN" = ""],[
> > > +   AS_IF([test "$CONSUMERD64_BIN" = ""],
> > > +   [
> > >             AS_ECHO_N("`eval eval echo $lttnglibexecdir`")
> > >             AS_ECHO("/lttng-consumerd")
> > > -   ],[
> > > +   ],
> > > +   [
> > >             AS_ECHO("$CONSUMERD64_BIN")
> > >     ])
> > > -
> > >     AS_ECHO_N("64-bit consumer libraries in:   ")
> > > -   AS_IF([test "$CONSUMERD64_LIBDIR" = ""],[
> > > +   AS_IF([test "$CONSUMERD64_LIBDIR" = ""],
> > > +   [
> > >             AS_ECHO("`eval eval echo $libdir`")
> > > -   ],[
> > > +   ],
> > > +   [
> > >             AS_ECHO("$CONSUMERD64_LIBDIR")
> > >     ])
> > >  ])
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--047d7b86c1ec54aeab04dc11e9e8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hmm, I agree the 3+ patch split might be a better idea; as=
 for the &#39;generalized coding style&#39;, it was more of a parenthesis u=
sage &amp; positionning cleanup to make sure the same style was applied eve=
rywhere (I tried to pick whatever style was the most present at the time). =
There were a lot of floating brackets here and there, and some function arg=
uments were not properly tabbed. These changes fixed most (?) of these issu=
es while keeping readability in mind.<div>
<br></div><div style>We&#39;ll get working on all these fixes in the next f=
ew days, but for now, thanks for the comments!</div></div><div class=3D"gma=
il_extra"><br><br><div class=3D"gmail_quote">On Mon, May 6, 2013 at 3:28 PM=
, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoye=
rs@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</=
span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">* David Goulet (<a href=3D"mailto:dgoulet@ef=
ficios.com">dgoulet@efficios.com</a>) wrote:<br>
&gt; Why?<br>
<br>
cleaning up the <a href=3D"http://configure.ac" target=3D"_blank">configure=
.ac</a> is a good thing. However, this patch should<br>
probably be split into 3 patches.<br>
<br>
1) Cleanup: <a href=3D"http://configure.ac" target=3D"_blank">configure.ac<=
/a>: replace space indents by tabs<br>
2) Cleanup: <a href=3D"http://configure.ac" target=3D"_blank">configure.ac<=
/a>: regroup AC_ARG_WITH<br>
3) Error message fix: <a href=3D"http://configure.ac" target=3D"_blank">con=
figure.ac</a>: fix bad AS_HELP_STRING<br>
<br>
Not sure about &quot;generalized coding style&quot; though. It might requir=
e more<br>
explanation.<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<div><div class=3D"h5"><br>
&gt;<br>
&gt; Thanks!<br>
&gt; David<br>
&gt;<br>
&gt; Charles Briere:<br>
&gt; &gt; From: Pierre-Luc St-Charles &lt;<a href=3D"mailto:pierre-luc.st-c=
harles@polymtl.ca">pierre-luc.st-charles@polymtl.ca</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Pierre-Luc St-Charles &lt;<a href=3D"mailto:pierre=
-luc.st-charles@polymtl.ca">pierre-luc.st-charles@polymtl.ca</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt; =A0<a href=3D"http://configure.ac" target=3D"_blank">configure.ac=
</a> | 315 ++++++++++++++++++++++++++++++++---------------------------<br>
&gt; &gt; =A01 file changed, 171 insertions(+), 144 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/<a href=3D"http://configure.ac" target=3D"_blank">co=
nfigure.ac</a> b/<a href=3D"http://configure.ac" target=3D"_blank">configur=
e.ac</a><br>
&gt; &gt; index 154b0a7..e4d2c6f 100644<br>
&gt; &gt; --- a/<a href=3D"http://configure.ac" target=3D"_blank">configure=
.ac</a><br>
&gt; &gt; +++ b/<a href=3D"http://configure.ac" target=3D"_blank">configure=
.ac</a><br>
&gt; &gt; @@ -17,27 +17,32 @@ AC_CONFIG_HEADERS([include/config.h])<br>
&gt; &gt; =A0AC_PROG_GREP<br>
&gt; &gt; =A0# libtool link_all_deplibs fixup. See <a href=3D"http://bugs.l=
ttng.org/issues/321" target=3D"_blank">http://bugs.lttng.org/issues/321</a>=
.<br>
&gt; &gt; =A0AC_ARG_ENABLE(libtool-linkdep-fixup,<br>
&gt; &gt; - =A0 AS_HELP_STRING([--disable-libtool-linkdep-fixup],<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [disable the libtool fixup =
for linking all dependent libraries (link_all_deplibs)]),<br>
&gt; &gt; - =A0 libtool_fixup=3D$enableval,<br>
&gt; &gt; - =A0 libtool_fixup=3Dyes)<br>
&gt; &gt; +[<br>
&gt; &gt; + =A0 AS_HELP_STRING([--disable-libtool-linkdep-fixup],[disable t=
he libtool fixup for linking all dependent libraries (link_all_deplibs)])<b=
r>
&gt; &gt; +],<br>
&gt; &gt; +[<br>
&gt; &gt; + =A0 libtool_fixup=3D$enableval<br>
&gt; &gt; +],<br>
&gt; &gt; +[<br>
&gt; &gt; + =A0 libtool_fixup=3Dyes<br>
&gt; &gt; +])<br>
&gt; &gt;<br>
&gt; &gt; =A0AS_IF([test &quot;x$libtool_fixup&quot; =3D &quot;xyes&quot;],=
<br>
&gt; &gt; - =A0 =A0 =A0 [<br>
&gt; &gt; - =A0 =A0 =A0 libtool_m4=3D&quot;$srcdir/config/libtool.m4&quot;<=
br>
&gt; &gt; - =A0 =A0 =A0 libtool_flag_pattern=3D&quot;.*link_all_deplibs\s*,=
\s*\$1\s*)&quot;<br>
&gt; &gt; - =A0 =A0 =A0 AC_MSG_CHECKING([for occurence(s) of link_all_depli=
bs =3D no in $libtool_m4])<br>
&gt; &gt; - =A0 =A0 =A0 libtool_flag_pattern_count=3D$(grep -c &quot;$libto=
ol_flag_pattern\s*=3D\s*no&quot; $libtool_m4)<br>
&gt; &gt; - =A0 =A0 =A0 AS_IF([test $libtool_flag_pattern_count -ne 0],<br>
&gt; &gt; - =A0 =A0 =A0 [<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 AC_MSG_RESULT([$libtool_flag_pattern_co=
unt])<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 AC_MSG_WARN([the detected libtool will =
not link all dependencies, forcing link_all_deplibs =3D unknown])<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 sed -i &quot;s/\($libtool_flag_pattern\=
)\s*=3D\s*no/\1=3Dunknown/g&quot; $libtool_m4<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 ],<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 [<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 AC_MSG_RESULT([none])<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 ])<br>
&gt; &gt; - =A0 =A0 =A0 ])<br>
&gt; &gt; +[<br>
&gt; &gt; + =A0 libtool_m4=3D&quot;$srcdir/config/libtool.m4&quot;<br>
&gt; &gt; + =A0 libtool_flag_pattern=3D&quot;.*link_all_deplibs\s*,\s*\$1\s=
*)&quot;<br>
&gt; &gt; + =A0 AC_MSG_CHECKING([for occurence(s) of link_all_deplibs =3D n=
o in $libtool_m4])<br>
&gt; &gt; + =A0 libtool_flag_pattern_count=3D$(grep -c &quot;$libtool_flag_=
pattern\s*=3D\s*no&quot; $libtool_m4)<br>
&gt; &gt; + =A0 AS_IF([test $libtool_flag_pattern_count -ne 0],<br>
&gt; &gt; + =A0 [<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 AC_MSG_RESULT([$libtool_flag_pattern_count]=
)<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 AC_MSG_WARN([the detected libtool will not =
link all dependencies, forcing link_all_deplibs =3D unknown])<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 sed -i &quot;s/\($libtool_flag_pattern\)\s*=
=3D\s*no/\1=3Dunknown/g&quot; $libtool_m4<br>
&gt; &gt; + =A0 ],<br>
&gt; &gt; + =A0 [<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 AC_MSG_RESULT([none])<br>
&gt; &gt; + =A0 ])<br>
&gt; &gt; +])<br>
&gt; &gt;<br>
&gt; &gt; =A0AM_CONDITIONAL([NO_SHARED], [test x$enable_shared =3D xno])<br=
>
&gt; &gt;<br>
&gt; &gt; @@ -57,55 +62,55 @@ AC_CHECK_HEADERS([ \<br>
&gt; &gt;<br>
&gt; &gt; =A0# Babeltrace viewer check<br>
&gt; &gt; =A0AC_ARG_WITH([babeltrace-bin],<br>
&gt; &gt; - =A0 AS_HELP_STRING([--with-babeltrace-bin],<br>
&gt; &gt; - =A0 [Location of the babeltrace viewer executable (including th=
e filename)]),<br>
&gt; &gt; + =A0 AS_HELP_STRING([--with-babeltrace-bin], [Location of the ba=
beltrace viewer executable (including the filename)]),<br>
&gt; &gt; =A0 =A0 [BABELTRACE_BIN=3D&quot;$withval&quot;],<br>
&gt; &gt; =A0 =A0 [BABELTRACE_BIN=3D&#39;&#39;])<br>
&gt; &gt; =A0AC_SUBST([BABELTRACE_BIN])<br>
&gt; &gt;<br>
&gt; &gt; =A0# lttv-gui<br>
&gt; &gt; =A0AC_ARG_WITH([lttv-gui-bin],<br>
&gt; &gt; - =A0 AS_HELP_STRING([--with-lttv-gui-bin],<br>
&gt; &gt; - =A0 [Location of the lttv GUI viewer executable (including the =
filename)]),<br>
&gt; &gt; - =A0 [LTTV_GUI_BIN=3D&quot;$withval&quot;],<br>
&gt; &gt; - =A0 [LTTV_GUI_BIN=3D&#39;&#39;])<br>
&gt; &gt; + =A0 AS_HELP_STRING([--with-lttv-gui-bin], [Location of the lttv=
 GUI viewer executable (including the filename)]),<br>
&gt; &gt; + =A0 [LTTV_GUI_BIN=3D&quot;$withval&quot;],<br>
&gt; &gt; + =A0 [LTTV_GUI_BIN=3D&#39;&#39;])<br>
&gt; &gt; =A0AC_SUBST([LTTV_GUI_BIN])<br>
&gt; &gt;<br>
&gt; &gt; =A0AC_ARG_WITH([consumerd32-bin],<br>
&gt; &gt; - =A0 AS_HELP_STRING([--with-consumerd32-bin],<br>
&gt; &gt; - =A0 [Location of the 32-bit consumerd executable (including the=
 filename)]),<br>
&gt; &gt; + =A0 AS_HELP_STRING([--with-consumerd32-bin], [Location of the 3=
2-bit consumerd executable (including the filename)]),<br>
&gt; &gt; =A0 =A0 [CONSUMERD32_BIN=3D&quot;$withval&quot;],<br>
&gt; &gt; =A0 =A0 [CONSUMERD32_BIN=3D&#39;&#39;])<br>
&gt; &gt; =A0AC_SUBST([CONSUMERD32_BIN])<br>
&gt; &gt;<br>
&gt; &gt; =A0AC_ARG_WITH([consumerd64-bin],<br>
&gt; &gt; - =A0 AS_HELP_STRING([--with-consumerd64-bin],<br>
&gt; &gt; - =A0 [Location of the 64-bit consumerd executable (including the=
 filename)]),<br>
&gt; &gt; + =A0 AS_HELP_STRING([--with-consumerd64-bin], [Location of the 6=
4-bit consumerd executable (including the filename)]),<br>
&gt; &gt; =A0 =A0 [CONSUMERD64_BIN=3D&quot;$withval&quot;],<br>
&gt; &gt; =A0 =A0 [CONSUMERD64_BIN=3D&#39;&#39;])<br>
&gt; &gt; =A0AC_SUBST([CONSUMERD64_BIN])<br>
&gt; &gt;<br>
&gt; &gt; =A0AC_ARG_WITH([consumerd32-libdir],<br>
&gt; &gt; - =A0 AS_HELP_STRING([--with-consumerd32-libdir],<br>
&gt; &gt; - =A0 [Directory containing the 32-bit consumerd libraries]),<br>
&gt; &gt; + =A0 AS_HELP_STRING([--with-consumerd32-libdir], [Directory cont=
aining the 32-bit consumerd libraries]),<br>
&gt; &gt; =A0 =A0 [CONSUMERD32_LIBDIR=3D&quot;$withval&quot;],<br>
&gt; &gt; =A0 =A0 [CONSUMERD32_LIBDIR=3D&#39;&#39;])<br>
&gt; &gt; =A0AC_SUBST([CONSUMERD32_LIBDIR])<br>
&gt; &gt;<br>
&gt; &gt; =A0AC_ARG_WITH([consumerd64-libdir],<br>
&gt; &gt; - =A0 AS_HELP_STRING([--with-consumerd64-libdir],<br>
&gt; &gt; - =A0 [Directory containing the 64-bit consumerd libraries]),<br>
&gt; &gt; + =A0 AS_HELP_STRING([--with-consumerd64-libdir], [Directory cont=
aining the 64-bit consumerd libraries]),<br>
&gt; &gt; =A0 =A0 [CONSUMERD64_LIBDIR=3D&quot;$withval&quot;],<br>
&gt; &gt; =A0 =A0 [CONSUMERD64_LIBDIR=3D&#39;&#39;])<br>
&gt; &gt; =A0AC_SUBST([CONSUMERD64_LIBDIR])<br>
&gt; &gt;<br>
&gt; &gt; =A0AC_ARG_WITH([sessiond-bin],<br>
&gt; &gt; - =A0 AS_HELP_STRING([--with-sessiond-bin],<br>
&gt; &gt; - =A0 [Location of the sessiond executable (including the filenam=
e)]),<br>
&gt; &gt; + =A0 AS_HELP_STRING([--with-sessiond-bin], [Location of the sess=
iond executable (including the filename)]),<br>
&gt; &gt; =A0 =A0 [SESSIOND_BIN=3D&quot;$withval&quot;],<br>
&gt; &gt; =A0 =A0 [SESSIOND_BIN=3D&#39;&#39;])<br>
&gt; &gt; =A0AC_SUBST([SESSIOND_BIN])<br>
&gt; &gt;<br>
&gt; &gt; +# Option to only build the consumer daemon and its libraries<br>
&gt; &gt; +AC_ARG_WITH([consumerd-only],<br>
&gt; &gt; + =A0 AS_HELP_STRING([--with-consumerd-only], [Only build the con=
sumer daemon [default=3Dno]]),<br>
&gt; &gt; + =A0 [consumerd_only=3D$withval],<br>
&gt; &gt; + =A0 [consumerd_only=3Dno])<br>
&gt; &gt; +AM_CONDITIONAL([BUILD_CONSUMERD_ONLY], [test &quot;x$consumerd_o=
nly&quot; =3D &quot;xyes&quot;])<br>
&gt; &gt; +<br>
&gt; &gt; =A0AC_DEFINE_UNQUOTED([CONFIG_CONSUMERD32_BIN], &quot;$CONSUMERD3=
2_BIN&quot;, [Location of the 32-bit consumerd executable.])<br>
&gt; &gt; =A0AC_DEFINE_UNQUOTED([CONFIG_CONSUMERD64_BIN], &quot;$CONSUMERD6=
4_BIN&quot;, [Location of the 64-bit consumerd executable])<br>
&gt; &gt; =A0AC_DEFINE_UNQUOTED([CONFIG_CONSUMERD32_LIBDIR], &quot;$CONSUME=
RD32_LIBDIR&quot;, [Search for consumerd 32-bit libraries in this location.=
])<br>
&gt; &gt; @@ -117,23 +122,24 @@ AC_DEFINE_UNQUOTED([CONFIG_SESSIOND_BIN], &=
quot;$SESSIOND_BIN&quot;, [Location of the sess<br>
&gt; &gt; =A0# Check for pthread<br>
&gt; &gt; =A0AC_CHECK_LIB([pthread], [pthread_create], [],<br>
&gt; &gt; =A0[<br>
&gt; &gt; - =A0 =A0# Check for pthread in a bionic libc...<br>
&gt; &gt; + =A0 # Check for pthread in a bionic libc...<br>
&gt; &gt; =A0 =A0 AC_CHECK_LIB([c], [pthread_create], [],<br>
&gt; &gt; =A0 =A0 [<br>
&gt; &gt; - =A0 =A0 =A0 AC_MSG_ERROR([Cannot find libpthread. Use [LDFLAGS]=
=3D-Ldir to specify its location.])<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 AC_MSG_ERROR([Cannot find libpthread. Use [=
LDFLAGS]=3D-Ldir to specify its location.])<br>
&gt; &gt; =A0 =A0 ])<br>
&gt; &gt; -]<br>
&gt; &gt; -)<br>
&gt; &gt; +])<br>
&gt; &gt;<br>
&gt; &gt; =A0# Check low-level endian compat functions<br>
&gt; &gt; =A0AC_CHECK_DECL(be64toh, [],<br>
&gt; &gt; =A0[<br>
&gt; &gt; - =A0 AC_CHECK_DECL(betoh64, [AC_DEFINE_UNQUOTED([LTTNG_HAVE_BETO=
H64], 1, [Has BSD-style endian conversion operations.])],<br>
&gt; &gt; + =A0 AC_CHECK_DECL(betoh64,<br>
&gt; &gt; + =A0 [<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 AC_DEFINE_UNQUOTED([LTTNG_HAVE_BETOH64], 1,=
 [Has BSD-style endian conversion operations.])<br>
&gt; &gt; + =A0 ],<br>
&gt; &gt; =A0 =A0 [<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 AC_MSG_ERROR([Cannot find be64toh, betoh6=
4 or any similar functions.])<br>
&gt; &gt; =A0 =A0 ])<br>
&gt; &gt; -]<br>
&gt; &gt; -)<br>
&gt; &gt; +])<br>
&gt; &gt;<br>
&gt; &gt; =A0# Check if gettid() is already defined<br>
&gt; &gt; =A0AC_CHECK_DECL(gettid,<br>
&gt; &gt; @@ -146,11 +152,10 @@ AC_CHECK_LIB([popt], [poptGetContext], [],<=
br>
&gt; &gt; =A0[<br>
&gt; &gt; =A0 =A0 # Check for libpopt in oprofile for Android<br>
&gt; &gt; =A0 =A0 AC_CHECK_LIB([oprofile_popt], [poptGetContext], [],<br>
&gt; &gt; - =A0 =A0[<br>
&gt; &gt; - =A0 =A0 =A0 =A0AC_MSG_ERROR([Cannot find libpopt. Use [LDFLAGS]=
=3D-Ldir to specify its location.])<br>
&gt; &gt; - =A0 =A0])<br>
&gt; &gt; -]<br>
&gt; &gt; -)<br>
&gt; &gt; + =A0 [<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 AC_MSG_ERROR([Cannot find libpopt. Use [LDF=
LAGS]=3D-Ldir to specify its location.])<br>
&gt; &gt; + =A0 ])<br>
&gt; &gt; +])<br>
&gt; &gt;<br>
&gt; &gt; =A0# Check for libuuid<br>
&gt; &gt; =A0AC_CHECK_LIB([uuid], [uuid_generate],<br>
&gt; &gt; @@ -176,8 +181,7 @@ AC_CHECK_LIB([uuid], [uuid_generate],<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AC_MSG_ERROR([Cannot find=
 libuuid uuid_generate, libc uuid_create nor libext2_uuid uuid_generate. Us=
e [LDFLAGS]=3D-Ldir to specify their location.])<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 ])<br>
&gt; &gt; =A0 =A0 ])<br>
&gt; &gt; -]<br>
&gt; &gt; -)<br>
&gt; &gt; +])<br>
&gt; &gt; =A0AM_CONDITIONAL([LTTNG_BUILD_WITH_LIBUUID], [test &quot;x$have_=
libuuid&quot; =3D &quot;xyes&quot;])<br>
&gt; &gt; =A0AM_CONDITIONAL([LTTNG_BUILD_WITH_LIBC_UUID], [test &quot;x$hav=
e_libc_uuid&quot; =3D &quot;xyes&quot;])<br>
&gt; &gt; =A0AM_CONDITIONAL([LTTNG_BUILD_WITH_LIBEXT2_UUID], [test &quot;x$=
have_libext2_uuid&quot; =3D &quot;xyes&quot;])<br>
&gt; &gt; @@ -222,41 +226,59 @@ liburcu_version=3D&quot;&gt;=3D 0.7.2&quot;=
<br>
&gt; &gt;<br>
&gt; &gt; =A0# Check liburcu needed function calls<br>
&gt; &gt; =A0AC_CHECK_DECL([cds_list_add], [],<br>
&gt; &gt; - =A0 [AC_MSG_ERROR([liburcu $liburcu_version or newer is needed]=
)], [[#include &lt;urcu/list.h&gt;]]<br>
&gt; &gt; -)<br>
&gt; &gt; +[<br>
&gt; &gt; + =A0 AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])=
], [[#include &lt;urcu/list.h&gt;]<br>
&gt; &gt; +])<br>
&gt; &gt; =A0AC_CHECK_DECL([cds_wfq_init], [],<br>
&gt; &gt; - =A0 [AC_MSG_ERROR([liburcu $liburcu_version or newer is needed]=
)], [[#include &lt;urcu/wfqueue.h&gt;]]<br>
&gt; &gt; -)<br>
&gt; &gt; +[<br>
&gt; &gt; + =A0 AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])=
], [[#include &lt;urcu/wfqueue.h&gt;]<br>
&gt; &gt; +])<br>
&gt; &gt; =A0AC_CHECK_DECL([cds_wfq_dequeue_blocking], [],<br>
&gt; &gt; - =A0 =A0[AC_MSG_ERROR([liburcu $liburcu_version or newer is need=
ed])], [[#include &lt;urcu/wfqueue.h&gt;]]<br>
&gt; &gt; -)<br>
&gt; &gt; +[<br>
&gt; &gt; + =A0 AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])=
], [[#include &lt;urcu/wfqueue.h&gt;]<br>
&gt; &gt; +])<br>
&gt; &gt; =A0AC_CHECK_DECL([futex_async], [],<br>
&gt; &gt; - =A0 [AC_MSG_ERROR([liburcu $liburcu_version or newer is needed]=
)], [[#include &lt;urcu/futex.h&gt;]]<br>
&gt; &gt; -)<br>
&gt; &gt; +[<br>
&gt; &gt; + =A0 AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])=
], [[#include &lt;urcu/futex.h&gt;]<br>
&gt; &gt; +])<br>
&gt; &gt; =A0AC_CHECK_DECL([rcu_thread_offline], [],<br>
&gt; &gt; - =A0 [AC_MSG_ERROR([liburcu $liburcu_version or newer is needed]=
)], [[#include &lt;urcu.h&gt;]]<br>
&gt; &gt; -)<br>
&gt; &gt; +[<br>
&gt; &gt; + =A0 AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])=
], [[#include &lt;urcu.h&gt;]<br>
&gt; &gt; +])<br>
&gt; &gt; =A0AC_CHECK_DECL([rcu_thread_online], [],<br>
&gt; &gt; - =A0 [AC_MSG_ERROR([liburcu $liburcu_version or newer is needed]=
)], [[#include &lt;urcu.h&gt;]]<br>
&gt; &gt; -)<br>
&gt; &gt; +[<br>
&gt; &gt; + =A0 AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])=
], [[#include &lt;urcu.h&gt;]<br>
&gt; &gt; +])<br>
&gt; &gt; =A0AC_CHECK_DECL([caa_likely], [],<br>
&gt; &gt; - =A0 [AC_MSG_ERROR([liburcu $liburcu_version or newer is needed]=
)], [[#include &lt;urcu.h&gt;]]<br>
&gt; &gt; -)<br>
&gt; &gt; +[<br>
&gt; &gt; + =A0 AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])=
], [[#include &lt;urcu.h&gt;]<br>
&gt; &gt; +])<br>
&gt; &gt;<br>
&gt; &gt; =A0# Check liblttng-ust-ctl library<br>
&gt; &gt; =A0AC_ARG_ENABLE(lttng-ust,<br>
&gt; &gt; - =A0 AS_HELP_STRING([--disable-lttng-ust],[build without LTTng-U=
ST (Userspace Tracing) support]),<br>
&gt; &gt; - =A0 lttng_ust_support=3D$enableval, lttng_ust_support=3Dyes)<br=
>
&gt; &gt; +[<br>
&gt; &gt; + =A0 AS_HELP_STRING([--disable-lttng-ust],[build without LTTng-U=
ST (Userspace Tracing) support])<br>
&gt; &gt; +],<br>
&gt; &gt; +[<br>
&gt; &gt; + =A0 lttng_ust_support=3D$enableval<br>
&gt; &gt; +],<br>
&gt; &gt; +[<br>
&gt; &gt; + =A0 lttng_ust_support=3Dyes<br>
&gt; &gt; +])<br>
&gt; &gt;<br>
&gt; &gt; -AS_IF([test &quot;x$lttng_ust_support&quot; =3D &quot;xyes&quot;=
], [<br>
&gt; &gt; +AS_IF([test &quot;x$lttng_ust_support&quot; =3D &quot;xyes&quot;=
],<br>
&gt; &gt; +[<br>
&gt; &gt; =A0 =A0 AC_CHECK_LIB([lttng-ust-ctl], [ustctl_set_filter],<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 [<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AC_DEFINE([HAVE_LIBLTTNG_US=
T_CTL], [1], [has LTTng-UST control support])<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lttng_ust_ctl_found=3Dyes<b=
r>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 ],<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 [AC_MSG_ERROR([Cannot find LTTng-UST 2.1.x.=
 Use [LDFLAGS]=3D-Ldir to specify its location, or specify --disable-lttng-=
ust to build lttng-tools without LTTng-UST support.])],<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 [-lurcu-common -lurcu-bp -lurcu-cds -lc -lr=
t]<br>
&gt; &gt; - =A0 )<br>
&gt; &gt; + =A0 [<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 AC_DEFINE([HAVE_LIBLTTNG_UST_CTL], [1], [ha=
s LTTng-UST control support])<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 lttng_ust_ctl_found=3Dyes<br>
&gt; &gt; + =A0 ],<br>
&gt; &gt; + =A0 [<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 AC_MSG_ERROR([Cannot find LTTng-UST 2.1.x. =
Use [LDFLAGS]=3D-Ldir to specify its location, or specify --disable-lttng-u=
st to build lttng-tools without LTTng-UST support.])<br>
&gt; &gt; + =A0 ],<br>
&gt; &gt; + =A0 [<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 -lurcu-common -lurcu-bp -lurcu-cds -lc -lrt=
<br>
&gt; &gt; + =A0 ])<br>
&gt; &gt; =A0])<br>
&gt; &gt; =A0AM_CONDITIONAL([HAVE_LIBLTTNG_UST_CTL], [test &quot;x$lttng_us=
t_ctl_found&quot; =3D xyes])<br>
&gt; &gt; =A0AC_CHECK_FUNCS([sched_getcpu sysconf sync_file_range])<br>
&gt; &gt; @@ -283,18 +305,15 @@ AM_CONDITIONAL([LTTNG_TOOLS_BUILD_WITH_LIBC=
_DL], [test &quot;x$have_libc_dl&quot; =3D &quot;xyes&quot;<br>
&gt; &gt; =A0AC_CHECK_LIB([c], [fmemopen],<br>
&gt; &gt; =A0[<br>
&gt; &gt; =A0 =A0 AC_DEFINE_UNQUOTED([LTTNG_HAVE_FMEMOPEN], 1, [Has fmemope=
n support.])<br>
&gt; &gt; -]<br>
&gt; &gt; -)<br>
&gt; &gt; +])<br>
&gt; &gt;<br>
&gt; &gt; =A0# Check for open_memstream<br>
&gt; &gt; =A0AC_CHECK_LIB([c], [open_memstream],<br>
&gt; &gt; =A0[<br>
&gt; &gt; =A0 =A0 AC_DEFINE_UNQUOTED([LTTNG_HAVE_OPEN_MEMSTREAM], 1, [Has o=
pen_memstream support.])<br>
&gt; &gt; -]<br>
&gt; &gt; -)<br>
&gt; &gt; +])<br>
&gt; &gt;<br>
&gt; &gt; =A0AC_ARG_VAR([LTTNG_RUNDIR], [Path to run directory, default to =
/var/run])<br>
&gt; &gt; -<br>
&gt; &gt; =A0AS_IF([test -n &quot;$LTTNG_RUNDIR&quot;],<br>
&gt; &gt; =A0[<br>
&gt; &gt; =A0 =A0 lttng_rundir=3D$LTTNG_RUNDIR<br>
&gt; &gt; @@ -315,54 +334,49 @@ AC_DEFINE_UNQUOTED([DEFAULT_LTTNG_RUNDIR], =
[&quot;$lttng_rundir&quot;], [Location of the r<br>
&gt; &gt; =A0swig_version=3D2.0.0<br>
&gt; &gt;<br>
&gt; &gt; =A0AC_ARG_ENABLE([python-bindings],<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0[AC_HELP_STRING([--enable-python-bin=
dings],<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[com=
pile Python bindings])],<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0[enable_python=3Dyes], [enable_pytho=
n=3Dno])<br>
&gt; &gt; +[<br>
&gt; &gt; + =A0 AS_HELP_STRING([--enable-python-bindings], [compile Python =
bindings])<br>
&gt; &gt; +],<br>
&gt; &gt; +[<br>
&gt; &gt; + =A0 enable_python=3Dyes<br>
&gt; &gt; +],<br>
&gt; &gt; +[<br>
&gt; &gt; + =A0 enable_python=3Dno<br>
&gt; &gt; +])<br>
&gt; &gt;<br>
&gt; &gt; =A0AM_CONDITIONAL([USE_PYTHON], [test &quot;x${enable_python:-yes=
}&quot; =3D xyes])<br>
&gt; &gt;<br>
&gt; &gt; =A0if test &quot;x${enable_python:-yes}&quot; =3D xyes; then<br>
&gt; &gt; - =A0AX_PKG_SWIG($swig_version, [], [ AC_MSG_ERROR([SWIG $swig_ve=
rsion or newer is needed]) ])<br>
&gt; &gt; - =A0AM_PATH_PYTHON<br>
&gt; &gt; -<br>
&gt; &gt; - =A0AC_ARG_VAR([PYTHON_INCLUDE], [Include flags for python, bypa=
ssing python-config])<br>
&gt; &gt; - =A0AC_ARG_VAR([PYTHON_CONFIG], [Path to python-config])<br>
&gt; &gt; - =A0AS_IF([test -z &quot;$PYTHON_INCLUDE&quot;], [<br>
&gt; &gt; - =A0 =A0AS_IF([test -z &quot;$PYTHON_CONFIG&quot;], [<br>
&gt; &gt; - =A0 =A0 =A0AC_PATH_PROGS([PYTHON_CONFIG],<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[python$PYTHON_VERSION-c=
onfig python-config],<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[no],<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[`dirname $PYTHON`])<br>
&gt; &gt; - =A0 =A0 =A0AS_IF([test &quot;$PYTHON_CONFIG&quot; =3D no], [AC_=
MSG_ERROR([cannot find python-config for $PYTHON. Do you have python-dev in=
stalled?])])<br>
&gt; &gt; - =A0 =A0])<br>
&gt; &gt; - =A0 =A0AC_MSG_CHECKING([python include flags])<br>
&gt; &gt; - =A0 =A0PYTHON_INCLUDE=3D`$PYTHON_CONFIG --includes`<br>
&gt; &gt; - =A0 =A0AC_MSG_RESULT([$PYTHON_INCLUDE])<br>
&gt; &gt; - =A0])<br>
&gt; &gt; -<br>
&gt; &gt; + =A0 AX_PKG_SWIG($swig_version, [],<br>
&gt; &gt; + =A0 [<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 AC_MSG_ERROR([SWIG $swig_version or newer i=
s needed])<br>
&gt; &gt; + =A0 ])<br>
&gt; &gt; + =A0 AM_PATH_PYTHON<br>
&gt; &gt; + =A0 AC_ARG_VAR([PYTHON_INCLUDE], [Include flags for python, byp=
assing python-config])<br>
&gt; &gt; + =A0 AC_ARG_VAR([PYTHON_CONFIG], [Path to python-config])<br>
&gt; &gt; + =A0 AS_IF([test -z &quot;$PYTHON_INCLUDE&quot;],<br>
&gt; &gt; + =A0 [<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 AS_IF([test -z &quot;$PYTHON_CONFIG&quot;],=
<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 [<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AC_PATH_PROGS([PYTHON_CONFI=
G], [python$PYTHON_VERSION-config python-config], [no], [`dirname $PYTHON`]=
)<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AS_IF([test &quot;$PYTHON_C=
ONFIG&quot; =3D no],<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AC_MSG_ERRO=
R([cannot find python-config for $PYTHON. Do you have python-dev installed?=
])<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ])<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 ])<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 AC_MSG_CHECKING([python include flags])<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 PYTHON_INCLUDE=3D`$PYTHON_CONFIG --includes=
`<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 AC_MSG_RESULT([$PYTHON_INCLUDE])<br>
&gt; &gt; + =A0 ])<br>
&gt; &gt; =A0else<br>
&gt; &gt; - =A0 =A0AC_MSG_NOTICE([You may configure with --enable-python-bi=
ndings ]dnl<br>
&gt; &gt; -[if you want Python bindings.])<br>
&gt; &gt; -<br>
&gt; &gt; + =A0 AC_MSG_NOTICE([You may configure with --enable-python-bindi=
ngs if you want Python bindings.])<br>
&gt; &gt; =A0fi<br>
&gt; &gt;<br>
&gt; &gt; -# Option to only build the consumer daemon and its libraries<br>
&gt; &gt; -AC_ARG_WITH([consumerd-only],<br>
&gt; &gt; - =A0 AS_HELP_STRING([--with-consumerd-only],[Only build the cons=
umer daemon [default=3Dno]]),<br>
&gt; &gt; - =A0 [consumerd_only=3D$withval],<br>
&gt; &gt; - =A0 [consumerd_only=3Dno])<br>
&gt; &gt; -AM_CONDITIONAL([BUILD_CONSUMERD_ONLY], [test &quot;x$consumerd_o=
nly&quot; =3D &quot;xyes&quot;])<br>
&gt; &gt; -<br>
&gt; &gt; =A0# Epoll check. If not present, the build will fallback on poll=
() API<br>
&gt; &gt; -AX_HAVE_EPOLL(<br>
&gt; &gt; - =A0 [AX_CONFIG_FEATURE_ENABLE(epoll)],<br>
&gt; &gt; - =A0 [AX_CONFIG_FEATURE_DISABLE(epoll)]<br>
&gt; &gt; -)<br>
&gt; &gt; -AX_CONFIG_FEATURE(<br>
&gt; &gt; - =A0 [epoll], [This platform supports epoll(7)],<br>
&gt; &gt; - =A0 [HAVE_EPOLL], [This platform supports epoll(7).],<br>
&gt; &gt; - =A0 [enable_epoll=3D&quot;yes&quot;], [enable_epoll=3D&quot;no&=
quot;]<br>
&gt; &gt; -)<br>
&gt; &gt; +AX_HAVE_EPOLL([AX_CONFIG_FEATURE_ENABLE(epoll)],[AX_CONFIG_FEATU=
RE_DISABLE(epoll)])<br>
&gt; &gt; +AX_CONFIG_FEATURE([epoll], [This platform supports epoll(7)],<br=
>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 [HAVE_EPOLL], [This platform supports epoll=
(7).],<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 [enable_epoll=3D&quot;yes&quot;], [enable_e=
poll=3D&quot;no&quot;])<br>
&gt; &gt; =A0AM_CONDITIONAL([COMPAT_EPOLL], [ test &quot;$enable_epoll&quot=
; =3D &quot;yes&quot; ])<br>
&gt; &gt;<br>
&gt; &gt; =A0AC_SYS_LARGEFILE<br>
&gt; &gt; @@ -455,37 +469,43 @@ AS_ECHO()<br>
&gt; &gt; =A0# Target architecture we&#39;re building for<br>
&gt; &gt; =A0target_arch=3D$host_cpu<br>
&gt; &gt; =A0[<br>
&gt; &gt; -for f in $CFLAGS; do<br>
&gt; &gt; - =A0 =A0 =A0 =A0if test $f =3D &quot;-m32&quot;; then<br>
&gt; &gt; + =A0 for f in $CFLAGS; do<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 if test $f =3D &quot;-m32&quot;; then<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 target_arch=3D&quot;32-bi=
t&quot;<br>
&gt; &gt; - =A0 =A0 =A0 =A0elif test $f =3D &quot;-m64&quot;; then<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 elif test $f =3D &quot;-m64&quot;; then<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 target_arch=3D&quot;64-bi=
t&quot;<br>
&gt; &gt; - =A0 =A0 =A0 =A0fi<br>
&gt; &gt; -done<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 fi<br>
&gt; &gt; + =A0 done<br>
&gt; &gt; =A0]<br>
&gt; &gt; =A0AS_ECHO_N(&quot;Target architecture: &quot;)<br>
&gt; &gt; =A0AS_ECHO($target_arch)<br>
&gt; &gt;<br>
&gt; &gt; =A0# LTTng-UST enabled/disabled<br>
&gt; &gt; =A0AS_ECHO_N(&quot;Lttng-UST support: &quot;)<br>
&gt; &gt; -AS_IF([test &quot;x$lttng_ust_support&quot; =3D &quot;xyes&quot;=
],[<br>
&gt; &gt; +AS_IF([test &quot;x$lttng_ust_support&quot; =3D &quot;xyes&quot;=
],<br>
&gt; &gt; +[<br>
&gt; &gt; =A0 =A0 AS_ECHO(&quot;Enabled&quot;)<br>
&gt; &gt; -],[<br>
&gt; &gt; +],<br>
&gt; &gt; +[<br>
&gt; &gt; =A0 =A0 AS_ECHO(&quot;Disabled&quot;)<br>
&gt; &gt; =A0])<br>
&gt; &gt;<br>
&gt; &gt; =A0#Python binding enabled/disabled<br>
&gt; &gt; =A0AS_ECHO_N(&quot;Python binding: &quot;)<br>
&gt; &gt; -AS_IF([test &quot;x${enable_python:-yes}&quot; =3D xyes], [<br>
&gt; &gt; +AS_IF([test &quot;x${enable_python:-yes}&quot; =3D xyes],<br>
&gt; &gt; +[<br>
&gt; &gt; =A0 =A0 AS_ECHO(&quot;Enabled&quot;)<br>
&gt; &gt; -],[<br>
&gt; &gt; +],<br>
&gt; &gt; +[<br>
&gt; &gt; =A0 =A0 AS_ECHO(&quot;Disabled&quot;)<br>
&gt; &gt; =A0])<br>
&gt; &gt;<br>
&gt; &gt; =A0# Do we build only the consumerd, or everything<br>
&gt; &gt; -AS_IF([test &quot;x$consumerd_only&quot; =3D &quot;xyes&quot;],[=
<br>
&gt; &gt; +AS_IF([test &quot;x$consumerd_only&quot; =3D &quot;xyes&quot;],<=
br>
&gt; &gt; +[<br>
&gt; &gt; =A0 =A0 AS_ECHO(&quot;Only the consumerd daemon will be built.&qu=
ot;)<br>
&gt; &gt; -],[<br>
&gt; &gt; +],<br>
&gt; &gt; +[<br>
&gt; &gt; =A0 =A0 AS_ECHO(&quot;All binaries will be built.&quot;)<br>
&gt; &gt; =A0])<br>
&gt; &gt;<br>
&gt; &gt; @@ -497,45 +517,52 @@ AS_ECHO_N(&quot;Libraries will be installed=
 in: &quot;)<br>
&gt; &gt; =A0AS_ECHO(&quot;`eval eval echo $libdir`&quot;)<br>
&gt; &gt;<br>
&gt; &gt; =A0# If we build the sessiond, print the paths it will use<br>
&gt; &gt; -AS_IF([test &quot;x$consumerd_only&quot; =3D &quot;xno&quot;],[<=
br>
&gt; &gt; +AS_IF([test &quot;x$consumerd_only&quot; =3D &quot;xno&quot;],<b=
r>
&gt; &gt; +[<br>
&gt; &gt; =A0 =A0 AS_ECHO()<br>
&gt; &gt; =A0 =A0 AS_ECHO_N(&quot;The lttng command will look for the lttng=
-sessiond executable at: &quot;)<br>
&gt; &gt; - =A0 AS_IF([test &quot;$SESSIOND_BIN&quot; =3D &quot;&quot;],[<b=
r>
&gt; &gt; + =A0 AS_IF([test &quot;$SESSIOND_BIN&quot; =3D &quot;&quot;],<br=
>
&gt; &gt; + =A0 [<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 AS_ECHO_N(&quot;`eval eval echo $bindir`&=
quot;)<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 AS_ECHO(&quot;/lttng-sessiond&quot;)<br>
&gt; &gt; - =A0 ],[<br>
&gt; &gt; + =A0 ],<br>
&gt; &gt; + =A0 [<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 AS_ECHO(&quot;$SESSIOND_BIN&quot;)<br>
&gt; &gt; =A0 =A0 ])<br>
&gt; &gt; -<br>
&gt; &gt; =A0 =A0 AS_ECHO()<br>
&gt; &gt; =A0 =A0 AS_ECHO(&quot;The sessiond daemon will look in the follow=
ing directories: &quot;)<br>
&gt; &gt; =A0 =A0 AS_ECHO_N(&quot;32-bit consumerd executable at: &quot;)<b=
r>
&gt; &gt; - =A0 AS_IF([test &quot;$CONSUMERD32_BIN&quot; =3D &quot;&quot;],=
[<br>
&gt; &gt; + =A0 AS_IF([test &quot;$CONSUMERD32_BIN&quot; =3D &quot;&quot;],=
<br>
&gt; &gt; + =A0 [<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 AS_ECHO_N(&quot;`eval eval echo $lttnglib=
execdir`&quot;)<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 AS_ECHO(&quot;/lttng-consumerd&quot;)<br>
&gt; &gt; - =A0 ],[<br>
&gt; &gt; + =A0 ],<br>
&gt; &gt; + =A0 [<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 AS_ECHO(&quot;$CONSUMERD32_BIN&quot;)<br>
&gt; &gt; =A0 =A0 ])<br>
&gt; &gt; -<br>
&gt; &gt; =A0 =A0 AS_ECHO_N(&quot;32-bit consumer libraries in: =A0 &quot;)=
<br>
&gt; &gt; - =A0 AS_IF([test &quot;$CONSUMERD32_LIBDIR&quot; =3D &quot;&quot=
;],[<br>
&gt; &gt; + =A0 AS_IF([test &quot;$CONSUMERD32_LIBDIR&quot; =3D &quot;&quot=
;],<br>
&gt; &gt; + =A0 [<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 AS_ECHO(&quot;`eval eval echo $libdir`&qu=
ot;)<br>
&gt; &gt; - =A0 ],[<br>
&gt; &gt; + =A0 ],<br>
&gt; &gt; + =A0 [<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 AS_ECHO(&quot;$CONSUMERD32_LIBDIR&quot;)<=
br>
&gt; &gt; =A0 =A0 ])<br>
&gt; &gt; -<br>
&gt; &gt; =A0 =A0 AS_ECHO_N(&quot;64-bit consumerd executable at: &quot;)<b=
r>
&gt; &gt; - =A0 AS_IF([test &quot;$CONSUMERD64_BIN&quot; =3D &quot;&quot;],=
[<br>
&gt; &gt; + =A0 AS_IF([test &quot;$CONSUMERD64_BIN&quot; =3D &quot;&quot;],=
<br>
&gt; &gt; + =A0 [<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 AS_ECHO_N(&quot;`eval eval echo $lttnglib=
execdir`&quot;)<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 AS_ECHO(&quot;/lttng-consumerd&quot;)<br>
&gt; &gt; - =A0 ],[<br>
&gt; &gt; + =A0 ],<br>
&gt; &gt; + =A0 [<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 AS_ECHO(&quot;$CONSUMERD64_BIN&quot;)<br>
&gt; &gt; =A0 =A0 ])<br>
&gt; &gt; -<br>
&gt; &gt; =A0 =A0 AS_ECHO_N(&quot;64-bit consumer libraries in: =A0 &quot;)=
<br>
&gt; &gt; - =A0 AS_IF([test &quot;$CONSUMERD64_LIBDIR&quot; =3D &quot;&quot=
;],[<br>
&gt; &gt; + =A0 AS_IF([test &quot;$CONSUMERD64_LIBDIR&quot; =3D &quot;&quot=
;],<br>
&gt; &gt; + =A0 [<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 AS_ECHO(&quot;`eval eval echo $libdir`&qu=
ot;)<br>
&gt; &gt; - =A0 ],[<br>
&gt; &gt; + =A0 ],<br>
&gt; &gt; + =A0 [<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 AS_ECHO(&quot;$CONSUMERD64_LIBDIR&quot;)<=
br>
&gt; &gt; =A0 =A0 ])<br>
&gt; &gt; =A0])<br>
&gt;<br>
</div></div>&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
</font></span></blockquote></div><br></div>

--047d7b86c1ec54aeab04dc11e9e8--


--===============0065148600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0065148600==--
