From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools 14/14] Cleaned up
	configure.ac:	Replaced space indents by tabs,
	regrouped AC_ARG_WITH's, generalized the coding style,
	fixed a bad AS_HELP_STRING.
Date: Mon, 6 May 2013 15:28:38 -0400
Message-ID: <20130506192838.GA21679__31840.7980063514$1367868557$gmane$org@Krystal>
References: <1367864331-15212-1-git-send-email-charlesbriere.flatzo@gmail.com>
	<1367864331-15212-14-git-send-email-charlesbriere.flatzo@gmail.com>
	<51880356.4050009@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UZR5V-00013H-HA
	for lttng-dev@lists.lttng.org; Mon, 06 May 2013 15:28:41 -0400
Content-Disposition: inline
In-Reply-To: <51880356.4050009@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: Charles Briere <charlesbriere.flatzo@gmail.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* David Goulet (dgoulet@efficios.com) wrote:
> Why?

cleaning up the configure.ac is a good thing. However, this patch should
probably be split into 3 patches.

1) Cleanup: configure.ac: replace space indents by tabs
2) Cleanup: configure.ac: regroup AC_ARG_WITH
3) Error message fix: configure.ac: fix bad AS_HELP_STRING

Not sure about "generalized coding style" though. It might require more
explanation.

Thanks,

Mathieu

> 
> Thanks!
> David
> 
> Charles Briere:
> > From: Pierre-Luc St-Charles <pierre-luc.st-charles@polymtl.ca>
> > 
> > Signed-off-by: Pierre-Luc St-Charles <pierre-luc.st-charles@polymtl.ca>
> > ---
> >  configure.ac | 315 ++++++++++++++++++++++++++++++++---------------------------
> >  1 file changed, 171 insertions(+), 144 deletions(-)
> > 
> > diff --git a/configure.ac b/configure.ac
> > index 154b0a7..e4d2c6f 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -17,27 +17,32 @@ AC_CONFIG_HEADERS([include/config.h])
> >  AC_PROG_GREP
> >  # libtool link_all_deplibs fixup. See http://bugs.lttng.org/issues/321.
> >  AC_ARG_ENABLE(libtool-linkdep-fixup,
> > -	AS_HELP_STRING([--disable-libtool-linkdep-fixup],
> > -			[disable the libtool fixup for linking all dependent libraries (link_all_deplibs)]),
> > -	libtool_fixup=$enableval,
> > -	libtool_fixup=yes)
> > +[
> > +	AS_HELP_STRING([--disable-libtool-linkdep-fixup],[disable the libtool fixup for linking all dependent libraries (link_all_deplibs)])
> > +],
> > +[
> > +	libtool_fixup=$enableval
> > +],
> > +[
> > +	libtool_fixup=yes
> > +])
> >  
> >  AS_IF([test "x$libtool_fixup" = "xyes"],
> > -	    [
> > -	    libtool_m4="$srcdir/config/libtool.m4"
> > -	    libtool_flag_pattern=".*link_all_deplibs\s*,\s*\$1\s*)"
> > -	    AC_MSG_CHECKING([for occurence(s) of link_all_deplibs = no in $libtool_m4])
> > -	    libtool_flag_pattern_count=$(grep -c "$libtool_flag_pattern\s*=\s*no" $libtool_m4)
> > -	    AS_IF([test $libtool_flag_pattern_count -ne 0],
> > -	    [
> > -		  AC_MSG_RESULT([$libtool_flag_pattern_count])
> > -		  AC_MSG_WARN([the detected libtool will not link all dependencies, forcing link_all_deplibs = unknown])
> > -		  sed -i "s/\($libtool_flag_pattern\)\s*=\s*no/\1=unknown/g" $libtool_m4
> > -		  ],
> > -		  [
> > -		  AC_MSG_RESULT([none])
> > -		  ])
> > -	    ])
> > +[
> > +	libtool_m4="$srcdir/config/libtool.m4"
> > +	libtool_flag_pattern=".*link_all_deplibs\s*,\s*\$1\s*)"
> > +	AC_MSG_CHECKING([for occurence(s) of link_all_deplibs = no in $libtool_m4])
> > +	libtool_flag_pattern_count=$(grep -c "$libtool_flag_pattern\s*=\s*no" $libtool_m4)
> > +	AS_IF([test $libtool_flag_pattern_count -ne 0],
> > +	[
> > +		AC_MSG_RESULT([$libtool_flag_pattern_count])
> > +		AC_MSG_WARN([the detected libtool will not link all dependencies, forcing link_all_deplibs = unknown])
> > +		sed -i "s/\($libtool_flag_pattern\)\s*=\s*no/\1=unknown/g" $libtool_m4
> > +	],
> > +	[
> > +		AC_MSG_RESULT([none])
> > +	])
> > +])
> >  
> >  AM_CONDITIONAL([NO_SHARED], [test x$enable_shared = xno])
> >  
> > @@ -57,55 +62,55 @@ AC_CHECK_HEADERS([ \
> >  
> >  # Babeltrace viewer check
> >  AC_ARG_WITH([babeltrace-bin],
> > -	AS_HELP_STRING([--with-babeltrace-bin],
> > -	[Location of the babeltrace viewer executable (including the filename)]),
> > +	AS_HELP_STRING([--with-babeltrace-bin], [Location of the babeltrace viewer executable (including the filename)]),
> >  	[BABELTRACE_BIN="$withval"],
> >  	[BABELTRACE_BIN=''])
> >  AC_SUBST([BABELTRACE_BIN])
> >  
> >  # lttv-gui
> >  AC_ARG_WITH([lttv-gui-bin],
> > -	AS_HELP_STRING([--with-lttv-gui-bin],
> > -   [Location of the lttv GUI viewer executable (including the filename)]),
> > -   [LTTV_GUI_BIN="$withval"],
> > -   [LTTV_GUI_BIN=''])
> > +	AS_HELP_STRING([--with-lttv-gui-bin], [Location of the lttv GUI viewer executable (including the filename)]),
> > +	[LTTV_GUI_BIN="$withval"],
> > +	[LTTV_GUI_BIN=''])
> >  AC_SUBST([LTTV_GUI_BIN])
> >  
> >  AC_ARG_WITH([consumerd32-bin],
> > -	AS_HELP_STRING([--with-consumerd32-bin],
> > -	[Location of the 32-bit consumerd executable (including the filename)]),
> > +	AS_HELP_STRING([--with-consumerd32-bin], [Location of the 32-bit consumerd executable (including the filename)]),
> >  	[CONSUMERD32_BIN="$withval"],
> >  	[CONSUMERD32_BIN=''])
> >  AC_SUBST([CONSUMERD32_BIN])
> >  
> >  AC_ARG_WITH([consumerd64-bin],
> > -	AS_HELP_STRING([--with-consumerd64-bin],
> > -	[Location of the 64-bit consumerd executable (including the filename)]),
> > +	AS_HELP_STRING([--with-consumerd64-bin], [Location of the 64-bit consumerd executable (including the filename)]),
> >  	[CONSUMERD64_BIN="$withval"],
> >  	[CONSUMERD64_BIN=''])
> >  AC_SUBST([CONSUMERD64_BIN])
> >  
> >  AC_ARG_WITH([consumerd32-libdir],
> > -	AS_HELP_STRING([--with-consumerd32-libdir],
> > -	[Directory containing the 32-bit consumerd libraries]),
> > +	AS_HELP_STRING([--with-consumerd32-libdir], [Directory containing the 32-bit consumerd libraries]),
> >  	[CONSUMERD32_LIBDIR="$withval"],
> >  	[CONSUMERD32_LIBDIR=''])
> >  AC_SUBST([CONSUMERD32_LIBDIR])
> >  
> >  AC_ARG_WITH([consumerd64-libdir],
> > -	AS_HELP_STRING([--with-consumerd64-libdir],
> > -	[Directory containing the 64-bit consumerd libraries]),
> > +	AS_HELP_STRING([--with-consumerd64-libdir], [Directory containing the 64-bit consumerd libraries]),
> >  	[CONSUMERD64_LIBDIR="$withval"],
> >  	[CONSUMERD64_LIBDIR=''])
> >  AC_SUBST([CONSUMERD64_LIBDIR])
> >  
> >  AC_ARG_WITH([sessiond-bin],
> > -	AS_HELP_STRING([--with-sessiond-bin],
> > -	[Location of the sessiond executable (including the filename)]),
> > +	AS_HELP_STRING([--with-sessiond-bin], [Location of the sessiond executable (including the filename)]),
> >  	[SESSIOND_BIN="$withval"],
> >  	[SESSIOND_BIN=''])
> >  AC_SUBST([SESSIOND_BIN])
> >  
> > +# Option to only build the consumer daemon and its libraries
> > +AC_ARG_WITH([consumerd-only],
> > +	AS_HELP_STRING([--with-consumerd-only], [Only build the consumer daemon [default=no]]),
> > +	[consumerd_only=$withval],
> > +	[consumerd_only=no])
> > +AM_CONDITIONAL([BUILD_CONSUMERD_ONLY], [test "x$consumerd_only" = "xyes"])
> > +
> >  AC_DEFINE_UNQUOTED([CONFIG_CONSUMERD32_BIN], "$CONSUMERD32_BIN", [Location of the 32-bit consumerd executable.])
> >  AC_DEFINE_UNQUOTED([CONFIG_CONSUMERD64_BIN], "$CONSUMERD64_BIN", [Location of the 64-bit consumerd executable])
> >  AC_DEFINE_UNQUOTED([CONFIG_CONSUMERD32_LIBDIR], "$CONSUMERD32_LIBDIR", [Search for consumerd 32-bit libraries in this location.])
> > @@ -117,23 +122,24 @@ AC_DEFINE_UNQUOTED([CONFIG_SESSIOND_BIN], "$SESSIOND_BIN", [Location of the sess
> >  # Check for pthread
> >  AC_CHECK_LIB([pthread], [pthread_create], [],
> >  [
> > -    # Check for pthread in a bionic libc...
> > +	# Check for pthread in a bionic libc...
> >  	AC_CHECK_LIB([c], [pthread_create], [], 
> >  	[
> > -	    AC_MSG_ERROR([Cannot find libpthread. Use [LDFLAGS]=-Ldir to specify its location.])
> > +		AC_MSG_ERROR([Cannot find libpthread. Use [LDFLAGS]=-Ldir to specify its location.])
> >  	])
> > -]
> > -)
> > +])
> >  
> >  # Check low-level endian compat functions
> >  AC_CHECK_DECL(be64toh, [], 
> >  [
> > -	AC_CHECK_DECL(betoh64, [AC_DEFINE_UNQUOTED([LTTNG_HAVE_BETOH64], 1, [Has BSD-style endian conversion operations.])], 
> > +	AC_CHECK_DECL(betoh64,
> > +	[
> > +		AC_DEFINE_UNQUOTED([LTTNG_HAVE_BETOH64], 1, [Has BSD-style endian conversion operations.])
> > +	],
> >  	[
> >  		AC_MSG_ERROR([Cannot find be64toh, betoh64 or any similar functions.])
> >  	])
> > -]
> > -)
> > +])
> >  
> >  # Check if gettid() is already defined
> >  AC_CHECK_DECL(gettid,
> > @@ -146,11 +152,10 @@ AC_CHECK_LIB([popt], [poptGetContext], [],
> >  [
> >  	# Check for libpopt in oprofile for Android
> >  	AC_CHECK_LIB([oprofile_popt], [poptGetContext], [], 
> > -    [
> > -        AC_MSG_ERROR([Cannot find libpopt. Use [LDFLAGS]=-Ldir to specify its location.])
> > -    ])
> > -]
> > -)
> > +	[
> > +		AC_MSG_ERROR([Cannot find libpopt. Use [LDFLAGS]=-Ldir to specify its location.])
> > +	])
> > +])
> >  
> >  # Check for libuuid
> >  AC_CHECK_LIB([uuid], [uuid_generate],
> > @@ -176,8 +181,7 @@ AC_CHECK_LIB([uuid], [uuid_generate],
> >  			AC_MSG_ERROR([Cannot find libuuid uuid_generate, libc uuid_create nor libext2_uuid uuid_generate. Use [LDFLAGS]=-Ldir to specify their location.])
> >  		])
> >  	])
> > -]
> > -)
> > +])
> >  AM_CONDITIONAL([LTTNG_BUILD_WITH_LIBUUID], [test "x$have_libuuid" = "xyes"])
> >  AM_CONDITIONAL([LTTNG_BUILD_WITH_LIBC_UUID], [test "x$have_libc_uuid" = "xyes"])
> >  AM_CONDITIONAL([LTTNG_BUILD_WITH_LIBEXT2_UUID], [test "x$have_libext2_uuid" = "xyes"])
> > @@ -222,41 +226,59 @@ liburcu_version=">= 0.7.2"
> >  
> >  # Check liburcu needed function calls
> >  AC_CHECK_DECL([cds_list_add], [],
> > -	[AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#include <urcu/list.h>]]
> > -)
> > +[
> > +	AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#include <urcu/list.h>]
> > +])
> >  AC_CHECK_DECL([cds_wfq_init], [],
> > -	[AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#include <urcu/wfqueue.h>]]
> > -)
> > +[
> > +	AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#include <urcu/wfqueue.h>]
> > +])
> >  AC_CHECK_DECL([cds_wfq_dequeue_blocking], [],
> > -    [AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#include <urcu/wfqueue.h>]]
> > -)
> > +[
> > +	AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#include <urcu/wfqueue.h>]
> > +])
> >  AC_CHECK_DECL([futex_async], [],
> > -	[AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#include <urcu/futex.h>]]
> > -)
> > +[
> > +	AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#include <urcu/futex.h>]
> > +])
> >  AC_CHECK_DECL([rcu_thread_offline], [],
> > -	[AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#include <urcu.h>]]
> > -)
> > +[
> > +	AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#include <urcu.h>]
> > +])
> >  AC_CHECK_DECL([rcu_thread_online], [],
> > -	[AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#include <urcu.h>]]
> > -)
> > +[
> > +	AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#include <urcu.h>]
> > +])
> >  AC_CHECK_DECL([caa_likely], [],
> > -	[AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#include <urcu.h>]]
> > -)
> > +[
> > +	AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#include <urcu.h>]
> > +])
> >  
> >  # Check liblttng-ust-ctl library
> >  AC_ARG_ENABLE(lttng-ust,
> > -	AS_HELP_STRING([--disable-lttng-ust],[build without LTTng-UST (Userspace Tracing) support]),
> > -	lttng_ust_support=$enableval, lttng_ust_support=yes)
> > +[
> > +	AS_HELP_STRING([--disable-lttng-ust],[build without LTTng-UST (Userspace Tracing) support])
> > +],
> > +[
> > +	lttng_ust_support=$enableval
> > +],
> > +[
> > +	lttng_ust_support=yes
> > +])
> >  
> > -AS_IF([test "x$lttng_ust_support" = "xyes"], [
> > +AS_IF([test "x$lttng_ust_support" = "xyes"],
> > +[
> >  	AC_CHECK_LIB([lttng-ust-ctl], [ustctl_set_filter],
> > -		[
> > -			AC_DEFINE([HAVE_LIBLTTNG_UST_CTL], [1], [has LTTng-UST control support])
> > -			lttng_ust_ctl_found=yes
> > -		],
> > -		[AC_MSG_ERROR([Cannot find LTTng-UST 2.1.x. Use [LDFLAGS]=-Ldir to specify its location, or specify --disable-lttng-ust to build lttng-tools without LTTng-UST support.])],
> > -		[-lurcu-common -lurcu-bp -lurcu-cds -lc -lrt]
> > -	)
> > +	[
> > +		AC_DEFINE([HAVE_LIBLTTNG_UST_CTL], [1], [has LTTng-UST control support])
> > +		lttng_ust_ctl_found=yes
> > +	],
> > +	[
> > +		AC_MSG_ERROR([Cannot find LTTng-UST 2.1.x. Use [LDFLAGS]=-Ldir to specify its location, or specify --disable-lttng-ust to build lttng-tools without LTTng-UST support.])
> > +	],
> > +	[
> > +		-lurcu-common -lurcu-bp -lurcu-cds -lc -lrt
> > +	])
> >  ])
> >  AM_CONDITIONAL([HAVE_LIBLTTNG_UST_CTL], [test "x$lttng_ust_ctl_found" = xyes])
> >  AC_CHECK_FUNCS([sched_getcpu sysconf sync_file_range])
> > @@ -283,18 +305,15 @@ AM_CONDITIONAL([LTTNG_TOOLS_BUILD_WITH_LIBC_DL], [test "x$have_libc_dl" = "xyes"
> >  AC_CHECK_LIB([c], [fmemopen],
> >  [
> >  	AC_DEFINE_UNQUOTED([LTTNG_HAVE_FMEMOPEN], 1, [Has fmemopen support.])
> > -]
> > -)
> > +])
> >  
> >  # Check for open_memstream
> >  AC_CHECK_LIB([c], [open_memstream],
> >  [
> >  	AC_DEFINE_UNQUOTED([LTTNG_HAVE_OPEN_MEMSTREAM], 1, [Has open_memstream support.])
> > -]
> > -)
> > +])
> >  
> >  AC_ARG_VAR([LTTNG_RUNDIR], [Path to run directory, default to /var/run])
> > -
> >  AS_IF([test -n "$LTTNG_RUNDIR"],
> >  [
> >  	lttng_rundir=$LTTNG_RUNDIR
> > @@ -315,54 +334,49 @@ AC_DEFINE_UNQUOTED([DEFAULT_LTTNG_RUNDIR], ["$lttng_rundir"], [Location of the r
> >  swig_version=2.0.0
> >  
> >  AC_ARG_ENABLE([python-bindings],
> > -              [AC_HELP_STRING([--enable-python-bindings],
> > -                              [compile Python bindings])],
> > -              [enable_python=yes], [enable_python=no])
> > +[
> > +	AS_HELP_STRING([--enable-python-bindings], [compile Python bindings])
> > +],
> > +[
> > +	enable_python=yes
> > +],
> > +[
> > +	enable_python=no
> > +])
> >  
> >  AM_CONDITIONAL([USE_PYTHON], [test "x${enable_python:-yes}" = xyes])
> >  
> >  if test "x${enable_python:-yes}" = xyes; then
> > -  AX_PKG_SWIG($swig_version, [], [ AC_MSG_ERROR([SWIG $swig_version or newer is needed]) ])
> > -  AM_PATH_PYTHON
> > -
> > -  AC_ARG_VAR([PYTHON_INCLUDE], [Include flags for python, bypassing python-config])
> > -  AC_ARG_VAR([PYTHON_CONFIG], [Path to python-config])
> > -  AS_IF([test -z "$PYTHON_INCLUDE"], [
> > -    AS_IF([test -z "$PYTHON_CONFIG"], [
> > -      AC_PATH_PROGS([PYTHON_CONFIG],
> > -                    [python$PYTHON_VERSION-config python-config],
> > -                    [no],
> > -                    [`dirname $PYTHON`])
> > -      AS_IF([test "$PYTHON_CONFIG" = no], [AC_MSG_ERROR([cannot find python-config for $PYTHON. Do you have python-dev installed?])])
> > -    ])
> > -    AC_MSG_CHECKING([python include flags])
> > -    PYTHON_INCLUDE=`$PYTHON_CONFIG --includes`
> > -    AC_MSG_RESULT([$PYTHON_INCLUDE])
> > -  ])
> > -
> > +	AX_PKG_SWIG($swig_version, [],
> > +	[
> > +		AC_MSG_ERROR([SWIG $swig_version or newer is needed])
> > +	])
> > +	AM_PATH_PYTHON
> > +	AC_ARG_VAR([PYTHON_INCLUDE], [Include flags for python, bypassing python-config])
> > +	AC_ARG_VAR([PYTHON_CONFIG], [Path to python-config])
> > +	AS_IF([test -z "$PYTHON_INCLUDE"],
> > +	[
> > +		AS_IF([test -z "$PYTHON_CONFIG"],
> > +		[
> > +			AC_PATH_PROGS([PYTHON_CONFIG], [python$PYTHON_VERSION-config python-config], [no], [`dirname $PYTHON`])
> > +			AS_IF([test "$PYTHON_CONFIG" = no],
> > +			[
> > +				AC_MSG_ERROR([cannot find python-config for $PYTHON. Do you have python-dev installed?])
> > +			])
> > +		])
> > +		AC_MSG_CHECKING([python include flags])
> > +		PYTHON_INCLUDE=`$PYTHON_CONFIG --includes`
> > +		AC_MSG_RESULT([$PYTHON_INCLUDE])
> > +	])
> >  else
> > -    AC_MSG_NOTICE([You may configure with --enable-python-bindings ]dnl
> > -[if you want Python bindings.])
> > -
> > +	AC_MSG_NOTICE([You may configure with --enable-python-bindings if you want Python bindings.])
> >  fi
> >  
> > -# Option to only build the consumer daemon and its libraries
> > -AC_ARG_WITH([consumerd-only],
> > -	AS_HELP_STRING([--with-consumerd-only],[Only build the consumer daemon [default=no]]),
> > -	[consumerd_only=$withval],
> > -	[consumerd_only=no])
> > -AM_CONDITIONAL([BUILD_CONSUMERD_ONLY], [test "x$consumerd_only" = "xyes"])
> > -
> >  # Epoll check. If not present, the build will fallback on poll() API
> > -AX_HAVE_EPOLL(
> > -	[AX_CONFIG_FEATURE_ENABLE(epoll)],
> > -	[AX_CONFIG_FEATURE_DISABLE(epoll)]
> > -)
> > -AX_CONFIG_FEATURE(
> > -	[epoll], [This platform supports epoll(7)],
> > -	[HAVE_EPOLL], [This platform supports epoll(7).],
> > -	[enable_epoll="yes"], [enable_epoll="no"]
> > -)
> > +AX_HAVE_EPOLL([AX_CONFIG_FEATURE_ENABLE(epoll)],[AX_CONFIG_FEATURE_DISABLE(epoll)])
> > +AX_CONFIG_FEATURE([epoll], [This platform supports epoll(7)],
> > +		[HAVE_EPOLL], [This platform supports epoll(7).],
> > +		[enable_epoll="yes"], [enable_epoll="no"])
> >  AM_CONDITIONAL([COMPAT_EPOLL], [ test "$enable_epoll" = "yes" ])
> >  
> >  AC_SYS_LARGEFILE
> > @@ -455,37 +469,43 @@ AS_ECHO()
> >  # Target architecture we're building for
> >  target_arch=$host_cpu
> >  [
> > -for f in $CFLAGS; do
> > -        if test $f = "-m32"; then
> > +	for f in $CFLAGS; do
> > +		if test $f = "-m32"; then
> >  			target_arch="32-bit"
> > -        elif test $f = "-m64"; then
> > +		elif test $f = "-m64"; then
> >  			target_arch="64-bit"
> > -        fi
> > -done
> > +		fi
> > +	done
> >  ]
> >  AS_ECHO_N("Target architecture: ")
> >  AS_ECHO($target_arch)
> >  
> >  # LTTng-UST enabled/disabled
> >  AS_ECHO_N("Lttng-UST support: ")
> > -AS_IF([test "x$lttng_ust_support" = "xyes"],[
> > +AS_IF([test "x$lttng_ust_support" = "xyes"],
> > +[
> >  	AS_ECHO("Enabled")
> > -],[
> > +],
> > +[
> >  	AS_ECHO("Disabled")
> >  ])
> >  
> >  #Python binding enabled/disabled
> >  AS_ECHO_N("Python binding: ")
> > -AS_IF([test "x${enable_python:-yes}" = xyes], [
> > +AS_IF([test "x${enable_python:-yes}" = xyes],
> > +[
> >  	AS_ECHO("Enabled")
> > -],[
> > +],
> > +[
> >  	AS_ECHO("Disabled")
> >  ])
> >  
> >  # Do we build only the consumerd, or everything
> > -AS_IF([test "x$consumerd_only" = "xyes"],[
> > +AS_IF([test "x$consumerd_only" = "xyes"],
> > +[
> >  	AS_ECHO("Only the consumerd daemon will be built.")
> > -],[
> > +],
> > +[
> >  	AS_ECHO("All binaries will be built.")
> >  ])
> >  
> > @@ -497,45 +517,52 @@ AS_ECHO_N("Libraries will be installed in: ")
> >  AS_ECHO("`eval eval echo $libdir`")
> >  
> >  # If we build the sessiond, print the paths it will use
> > -AS_IF([test "x$consumerd_only" = "xno"],[
> > +AS_IF([test "x$consumerd_only" = "xno"],
> > +[
> >  	AS_ECHO()
> >  	AS_ECHO_N("The lttng command will look for the lttng-sessiond executable at: ")
> > -	AS_IF([test "$SESSIOND_BIN" = ""],[
> > +	AS_IF([test "$SESSIOND_BIN" = ""],
> > +	[
> >  		AS_ECHO_N("`eval eval echo $bindir`")
> >  		AS_ECHO("/lttng-sessiond")
> > -	],[
> > +	],
> > +	[
> >  		AS_ECHO("$SESSIOND_BIN")
> >  	])
> > -
> >  	AS_ECHO()
> >  	AS_ECHO("The sessiond daemon will look in the following directories: ")
> >  	AS_ECHO_N("32-bit consumerd executable at: ")
> > -	AS_IF([test "$CONSUMERD32_BIN" = ""],[
> > +	AS_IF([test "$CONSUMERD32_BIN" = ""],
> > +	[
> >  		AS_ECHO_N("`eval eval echo $lttnglibexecdir`")
> >  		AS_ECHO("/lttng-consumerd")
> > -	],[
> > +	],
> > +	[
> >  		AS_ECHO("$CONSUMERD32_BIN")
> >  	])
> > -
> >  	AS_ECHO_N("32-bit consumer libraries in:   ")
> > -	AS_IF([test "$CONSUMERD32_LIBDIR" = ""],[
> > +	AS_IF([test "$CONSUMERD32_LIBDIR" = ""],
> > +	[
> >  		AS_ECHO("`eval eval echo $libdir`")
> > -	],[
> > +	],
> > +	[
> >  		AS_ECHO("$CONSUMERD32_LIBDIR")
> >  	])
> > -
> >  	AS_ECHO_N("64-bit consumerd executable at: ")
> > -	AS_IF([test "$CONSUMERD64_BIN" = ""],[
> > +	AS_IF([test "$CONSUMERD64_BIN" = ""],
> > +	[
> >  		AS_ECHO_N("`eval eval echo $lttnglibexecdir`")
> >  		AS_ECHO("/lttng-consumerd")
> > -	],[
> > +	],
> > +	[
> >  		AS_ECHO("$CONSUMERD64_BIN")
> >  	])
> > -
> >  	AS_ECHO_N("64-bit consumer libraries in:   ")
> > -	AS_IF([test "$CONSUMERD64_LIBDIR" = ""],[
> > +	AS_IF([test "$CONSUMERD64_LIBDIR" = ""],
> > +	[
> >  		AS_ECHO("`eval eval echo $libdir`")
> > -	],[
> > +	],
> > +	[
> >  		AS_ECHO("$CONSUMERD64_LIBDIR")
> >  	])
> >  ])
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
