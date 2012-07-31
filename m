From: David Goulet <david.goulet@polymtl.ca>
Subject: Re: [lttng-tools PATCH] lttng-tools python module
Date: Tue, 31 Jul 2012 14:43:05 -0400
Message-ID: <50182739.3030604__14396.1786794991$1343760352$gmane$org@polymtl.ca>
References: <1343326167-11522-1-git-send-email-danny.serres@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <david.goulet@polymtl.ca>) id 1SwHPV-0007uH-FL
	for lttng-dev@lists.lttng.org; Tue, 31 Jul 2012 14:43:14 -0400
In-Reply-To: <1343326167-11522-1-git-send-email-danny.serres@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Danny Serres <danny.serres@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Danny,

Sorry for the delay!

First, thanks for this great work. I have a couple of "requests" before I put
all that upstream.

Can you add the generated files into .gitignore please. I get this:

#	src/python/lttng.i
#	src/python/lttng.py
#	src/python/lttng_wrap.c

There is also forgotten whitespaces in src/python/lttng.i.in (first carac.)

+               char *__repr__() {
(times 5)

Apart from those minor issues, I have two questions about this patch. First,
why is the python module in src/ and not in extras/ ? I consider src/ to be
supported and stable code shipped with the installation and/or in packages.
Also, the src/ directory is the core code of lttng-tools and this module is
more an extra useful tool.

Second, _IF_ this goes into src/, please move the tests to the tests/
directory else we are going to make it self contained in extras/ which is good
right now.

Last thing, could it be possible to have a small how-to/tutorial in the doc/
directory so people know that this exist and how to install it and use it ?
(Also add it to the README in PACKAGE CONTENTS). A swig2 dependency will be
added with this module so this howto should mention that this depends on that
software. (swig2.0 package on Debian/Ubuntu).

I might be wrong on some point so don't hesitate to argue and comment! :)

Cheers!
David

On 26/07/12 02:09 PM, Danny Serres wrote:
> The lttng-tools Python module can be used to directly control the
> lttng-tools API inside Python, using 'import lttng'.
> 
> Therefore, it becomes possible to create a trace, add events, start/stop
> tracing, destroy a session and so on from within Python.
> 
> The module does not include URI-related functions.
> 
> SWIG >= 2.0 is used to create the wrapper and its 'warning md variable
> unused' bug is patched in Makefile.am.
> 
> In the interface file, struct and enum are directly copied from lttng.h
> (all changes must be made in both files).
> 
> Signed-off-by: Danny Serres <danny.serres@efficios.com> Signed-off-by:
> Yannick Brosseau <yannick.brosseau@gmail.com> --- config/ax_pkg_swig.m4
> |  135 ++++++ configure.ac                |   43 ++ src/Makefile.am
> |    4 + src/python/Makefile.am      |   25 ++ src/python/lttng.i.in
> | 1023 +++++++++++++++++++++++++++++++++++++++++++ 
> src/python/tests/example.py |  109 +++++ src/python/tests/run.sh     |    1
> + src/python/tests/tests.py   |  310 +++++++++++++ 8 files changed, 1650
> insertions(+) create mode 100644 config/ax_pkg_swig.m4 create mode 100644
> src/python/Makefile.am create mode 100644 src/python/lttng.i.in create mode
> 100644 src/python/tests/example.py create mode 100644
> src/python/tests/run.sh create mode 100644 src/python/tests/tests.py
> 
> diff --git a/config/ax_pkg_swig.m4 b/config/ax_pkg_swig.m4 new file mode
> 100644 index 0000000..e112f3d --- /dev/null +++ b/config/ax_pkg_swig.m4 @@
> -0,0 +1,135 @@ +#
> ===========================================================================
>
> 
+#        http://www.gnu.org/software/autoconf-archive/ax_pkg_swig.html
> +#
> ===========================================================================
>
> 
+#
> +# SYNOPSIS +# +#   AX_PKG_SWIG([major.minor.micro], [action-if-found],
> [action-if-not-found]) +# +# DESCRIPTION +# +#   This macro searches for a
> SWIG installation on your system. If found, +#   then SWIG is AC_SUBST'd;
> if not found, then $SWIG is empty.  If SWIG is +#   found, then SWIG_LIB is
> set to the SWIG library path, and AC_SUBST'd. +# +#   You can use the
> optional first argument to check if the version of the +#   available SWIG
> is greater than or equal to the value of the argument. It +#   should have
> the format: N[.N[.N]] (N is a number between 0 and 999. Only +#   the first
> N is mandatory.) If the version argument is given (e.g. +#   1.3.17),
> AX_PKG_SWIG checks that the swig package is this version number +#   or
> higher. +# +#   As usual, action-if-found is executed if SWIG is found,
> otherwise +#   action-if-not-found is executed. +# +#   In configure.in,
> use as: +# +#     AX_PKG_SWIG(1.3.17, [], [ AC_MSG_ERROR([SWIG is required
> to build..]) ]) +#     AX_SWIG_ENABLE_CXX +#
> AX_SWIG_MULTI_MODULE_SUPPORT +#     AX_SWIG_PYTHON +# +# LICENSE +# +#
> Copyright (c) 2008 Sebastian Huber <sebastian-huber@web.de> +#   Copyright
> (c) 2008 Alan W. Irwin <irwin@beluga.phys.uvic.ca> +#   Copyright (c) 2008
> Rafael Laboissiere <rafael@laboissiere.net> +#   Copyright (c) 2008 Andrew
> Collier <colliera@ukzn.ac.za> +#   Copyright (c) 2011 Murray Cumming
> <murrayc@openismus.com> +# +#   This program is free software; you can
> redistribute it and/or modify it +#   under the terms of the GNU General
> Public License as published by the +#   Free Software Foundation; either
> version 2 of the License, or (at your +#   option) any later version. +# +#
> This program is distributed in the hope that it will be useful, but +#
> WITHOUT ANY WARRANTY; without even the implied warranty of +#
> MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General +#
> Public License for more details. +# +#   You should have received a copy of
> the GNU General Public License along +#   with this program. If not, see
> <http://www.gnu.org/licenses/>. +# +#   As a special exception, the
> respective Autoconf Macro's copyright owner +#   gives unlimited permission
> to copy, distribute and modify the configure +#   scripts that are the
> output of Autoconf when processing the Macro. You +#   need not follow the
> terms of the GNU General Public License when using +#   or distributing
> such scripts, even though portions of the text of the +#   Macro appear in
> them. The GNU General Public License (GPL) does govern +#   all other use
> of the material that constitutes the Autoconf Macro. +# +#   This special
> exception to the GPL applies to versions of the Autoconf +#   Macro
> released by the Autoconf Archive. When you make and distribute a +#
> modified version of the Autoconf Macro, you may extend this special +#
> exception to the GPL to apply to your modified version as well. + +#serial
> 8 + +AC_DEFUN([AX_PKG_SWIG],[ +        # Ubuntu has swig 2.0 as
> /usr/bin/swig2.0 +        AC_PATH_PROGS([SWIG],[swig swig2.0]) +        if
> test -z "$SWIG" ; then +                m4_ifval([$3],[$3],[:]) +
> elif test -n "$1" ; then +                AC_MSG_CHECKING([SWIG version]) +
> [swig_version=`$SWIG -version 2>&1 | grep 'SWIG Version' | sed
> 's/.*\([0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\).*/\1/g'`] +
> AC_MSG_RESULT([$swig_version]) +                if test -n "$swig_version"
> ; then +                        # Calculate the required version number
> components +                        [required=$1] +
> [required_major=`echo $required | sed 's/[^0-9].*//'`] +
> if test -z "$required_major" ; then +
> [required_major=0] +                        fi +
> [required=`echo $required | sed 's/[0-9]*[^0-9]//'`] +
> [required_minor=`echo $required | sed 's/[^0-9].*//'`] +
> if test -z "$required_minor" ; then +
> [required_minor=0] +                        fi +
> [required=`echo $required | sed 's/[0-9]*[^0-9]//'`] +
> [required_patch=`echo $required | sed 's/[^0-9].*//'`] +
> if test -z "$required_patch" ; then +
> [required_patch=0] +                        fi +                        #
> Calculate the available version number components +
> [available=$swig_version] +                        [available_major=`echo
> $available | sed 's/[^0-9].*//'`] +                        if test -z
> "$available_major" ; then +
> [available_major=0] +                        fi +
> [available=`echo $available | sed 's/[0-9]*[^0-9]//'`] +
> [available_minor=`echo $available | sed 's/[^0-9].*//'`] +
> if test -z "$available_minor" ; then +
> [available_minor=0] +                        fi +
> [available=`echo $available | sed 's/[0-9]*[^0-9]//'`] +
> [available_patch=`echo $available | sed 's/[^0-9].*//'`] +
> if test -z "$available_patch" ; then +
> [available_patch=0] +                        fi +                        #
> Convert the version tuple into a single number for easier comparison. +
> # Using base 100 should be safe since SWIG internally uses BCD values +
> # to encode its version number. +
> required_swig_vernum=`expr $required_major \* 10000 \ +
> \+ $required_minor \* 100 \+ $required_patch` +
> available_swig_vernum=`expr $available_major \* 10000 \ +
> \+ $available_minor \* 100 \+ $available_patch` + +
> if test $available_swig_vernum -lt $required_swig_vernum; then +
> AC_MSG_WARN([SWIG version >= $1 is required.  You have $swig_version.]) +
> SWIG='' +                                m4_ifval([$3],[$3],[]) +
> else +                                AC_MSG_CHECKING([for SWIG library]) +
> SWIG_LIB=`$SWIG -swiglib` +
> AC_MSG_RESULT([$SWIG_LIB]) +
> m4_ifval([$2],[$2],[]) +                        fi +                else +
> AC_MSG_WARN([cannot determine SWIG version]) +
> SWIG='' +                        m4_ifval([$3],[$3],[]) +
> fi +        fi +        AC_SUBST([SWIG_LIB]) +]) diff --git a/configure.ac
> b/configure.ac index 17e6b67..97167de 100644 --- a/configure.ac +++
> b/configure.ac @@ -154,6 +154,40 @@ AC_CHECK_LIB([c], [open_memstream], ] 
> )
> 
> +# For Python +# SWIG version needed or newer: +swig_version=2.0.0 + 
> +AC_ARG_ENABLE([python], +
> [AC_HELP_STRING([--disable-python], +                              [do not
> compile Python bindings])], +              [], [enable_python=yes]) + 
> +AM_CONDITIONAL([USE_PYTHON], [test "x${enable_python:-yes}" = xyes]) + +if
> test "x${enable_python:-yes}" = xyes; then +  AC_MSG_NOTICE([You may
> configure with --disable-python ]dnl +[if you do not need Python
> bindings.]) + +  AX_PKG_SWIG($swig_version, [], [ AC_MSG_ERROR([SWIG
> $swig_version or newer is needed]) ]) +  AM_PATH_PYTHON + +
> AC_ARG_VAR([PYTHON_INCLUDE], [Include flags for python, bypassing
> python-config]) +  AC_ARG_VAR([PYTHON_CONFIG], [Path to python-config]) +
> AS_IF([test -z "$PYTHON_INCLUDE"], [ +    AS_IF([test -z "$PYTHON_CONFIG"],
> [ +      AC_PATH_PROGS([PYTHON_CONFIG], +
> [python$PYTHON_VERSION-config python-config], +                    [no], +
> [`dirname $PYTHON`]) +      AS_IF([test "$PYTHON_CONFIG" = no],
> [AC_MSG_ERROR([cannot find python-config for $PYTHON.])]) +    ]) +
> AC_MSG_CHECKING([python include flags]) +    PYTHON_INCLUDE=`$PYTHON_CONFIG
> --includes` +    AC_MSG_RESULT([$PYTHON_INCLUDE]) +  ]) +fi + # Option to
> only build the consumer daemon and its libraries 
> AC_ARG_WITH([consumerd-only], AS_HELP_STRING([--with-consumerd-only],[Only
> build the consumer daemon [default=no]]), @@ -214,6 +248,7 @@
> AC_CONFIG_FILES([ src/bin/lttng-sessiond/Makefile 
> src/bin/lttng-relayd/Makefile src/bin/lttng/Makefile +	src/python/Makefile 
> tests/Makefile tests/kernel/Makefile tests/tools/Makefile @@ -260,6 +295,14
> @@ AS_IF([test "x$lttng_ust_support" = "xyes"],[ AS_ECHO("Disabled") ])
> 
> +#Python binding enabled/disabled +AS_ECHO_N("Python binding: ") 
> +AS_IF([test "x${enable_python:-yes}" = xyes], [ +	AS_ECHO("Enabled") +],[ 
> +	AS_ECHO("Disabled") +]) + # Do we build only the consumerd, or
> everything AS_IF([test "x$consumerd_only" = "xyes"],[ AS_ECHO("Only the
> consumerd daemon will be built.") diff --git a/src/Makefile.am
> b/src/Makefile.am index 103337c..a65a5c1 100644 --- a/src/Makefile.am +++
> b/src/Makefile.am @@ -1 +1,5 @@ SUBDIRS = common lib bin + +if USE_PYTHON 
> +SUBDIRS += python +endif diff --git a/src/python/Makefile.am
> b/src/python/Makefile.am new file mode 100644 index 0000000..b67d550 ---
> /dev/null +++ b/src/python/Makefile.am @@ -0,0 +1,25 @@ +lttng.i:
> lttng.i.in +	sed "s/LTTNG_VERSION_STR/LTTng $(PACKAGE_VERSION)/g"
> <lttng.i.in >lttng.i + +AM_CFLAGS = -I$(PYTHONINC) -I../lib/lttng-ctl
> -I../common \ +	      $(BUDDY_CFLAGS) + +EXTRA_DIST = lttng.i 
> +python_PYTHON = lttng.py +pyexec_LTLIBRARIES = _lttng.la + 
> +MAINTAINERCLEANFILES = lttng_wrap.c lttng.py + +_lttng_la_SOURCES =
> lttng_wrap.c + +_lttng_la_LDFLAGS = -module + +_lttng_la_LIBADD =
> ../lib/lttng-ctl/liblttng-ctl.la 		\ +
> ../common/sessiond-comm/libsessiond-comm.la + +lttng_wrap.c: lttng.i +
> $(SWIG) -python -I. -I$(top_srcdir)/src/common/sessiond-comm lttng.i +	sed
> -i "s/Python.h/python$(PYTHON_VERSION)\/Python.h/g" lttng_wrap.c +	sed -i
> "s/PyObject \*m, \*d, \*md;/PyObject \*m, \*d;\n#if
> defined(SWIGPYTHON_BUILTIN)\nPyObject *md;\n#endif/g" lttng_wrap.c +	sed -i
> "s/md = d/d/g" lttng_wrap.c +	sed -i
> "s/(void)public_symbol;/(void)public_symbol;\n  md = d;/g" lttng_wrap.c 
> diff --git a/src/python/lttng.i.in b/src/python/lttng.i.in new file mode
> 100644 index 0000000..4f3cfeb --- /dev/null +++ b/src/python/lttng.i.in @@
> -0,0 +1,1023 @@ +%define DOCSTRING +"LTTNG_VERSION_STR + +The  LTTng
> project  aims at providing highly efficient tracing tools for Linux. +It's
> tracers help tracking down performance issues and debugging problems
> involving +multiple concurrent processes and threads. Tracing across
> multiple systems is also possible." +%enddef + 
> +%module(docstring=DOCSTRING) lttng + +%include "typemaps.i" +%include
> "pyabc.i" +%{ +#define SWIG_FILE_WITH_INIT +#include <lttng/lttng.h> +%} + 
> +typedef unsigned int uint32_t; +typedef int int32_t; +typedef unsigned
> long long uint64_t; +typedef long pid_t; + + +//
> ============================================= +//		ENUMS +//
> ============================================= + +%rename("DOMAIN_KERNEL")
> LTTNG_DOMAIN_KERNEL; +%rename("DOMAIN_UST") LTTNG_DOMAIN_UST; +enum
> lttng_domain_type { +	LTTNG_DOMAIN_KERNEL                   = 1, +
> LTTNG_DOMAIN_UST                      = 2, +}; + +%rename("EVENT_ALL")
> LTTNG_EVENT_ALL; +%rename("EVENT_TRACEPOINT") LTTNG_EVENT_TRACEPOINT; 
> +%rename("EVENT_PROBE") LTTNG_EVENT_PROBE; 
> +%rename("EVENT_FUNCTION")LTTNG_EVENT_FUNCTION; 
> +%rename("EVENT_FUNCTION_ENTRY") LTTNG_EVENT_FUNCTION_ENTRY; 
> +%rename("EVENT_NOOP") LTTNG_EVENT_NOOP; +%rename("EVENT_SYSCALL")
> LTTNG_EVENT_SYSCALL; +enum lttng_event_type { +	LTTNG_EVENT_ALL
> = -1, +	LTTNG_EVENT_TRACEPOINT                = 0, +	LTTNG_EVENT_PROBE
> = 1, +	LTTNG_EVENT_FUNCTION                  = 2, +
> LTTNG_EVENT_FUNCTION_ENTRY            = 3, +	LTTNG_EVENT_NOOP
> = 4, +	LTTNG_EVENT_SYSCALL                   = 5, +}; + 
> +%rename("EVENT_LOGLEVEL_ALL") LTTNG_EVENT_LOGLEVEL_ALL; 
> +%rename("EVENT_LOGLEVEL_RANGE") LTTNG_EVENT_LOGLEVEL_RANGE; 
> +%rename("EVENT_LOGLEVEL_SINGLE") LTTNG_EVENT_LOGLEVEL_SINGLE; +enum
> lttng_loglevel_type { +	LTTNG_EVENT_LOGLEVEL_ALL              = 0, +
> LTTNG_EVENT_LOGLEVEL_RANGE            = 1, +	LTTNG_EVENT_LOGLEVEL_SINGLE
> = 2, +}; + +%rename("LOGLEVEL_EMERG") LTTNG_LOGLEVEL_EMERG; 
> +%rename("LOGLEVEL_ALERT") LTTNG_LOGLEVEL_ALERT; +%rename("LOGLEVEL_CRIT")
> LTTNG_LOGLEVEL_CRIT; +%rename("LOGLEVEL_ERR") LTTNG_LOGLEVEL_ERR; 
> +%rename("LOGLEVEL_WARNING") LTTNG_LOGLEVEL_WARNING; 
> +%rename("LOGLEVEL_NOTICE") LTTNG_LOGLEVEL_NOTICE; 
> +%rename("LOGLEVEL_INFO") LTTNG_LOGLEVEL_INFO; 
> +%rename("LOGLEVEL_DEBUG_SYSTEM") LTTNG_LOGLEVEL_DEBUG_SYSTEM; 
> +%rename("LOGLEVEL_DEBUG_PROGRAM") LTTNG_LOGLEVEL_DEBUG_PROGRAM; 
> +%rename("LOGLEVEL_DEBUG_PROCESS") LTTNG_LOGLEVEL_DEBUG_PROCESS; 
> +%rename("LOGLEVEL_DEBUG_MODULE") LTTNG_LOGLEVEL_DEBUG_MODULE; 
> +%rename("LOGLEVEL_DEBUG_UNIT") LTTNG_LOGLEVEL_DEBUG_UNIT; 
> +%rename("LOGLEVEL_DEBUG_FUNCTION") LTTNG_LOGLEVEL_DEBUG_FUNCTION; 
> +%rename("LOGLEVEL_DEBUG_LINE") LTTNG_LOGLEVEL_DEBUG_LINE; 
> +%rename("LOGLEVEL_DEBUG") LTTNG_LOGLEVEL_DEBUG; +enum lttng_loglevel { +
> LTTNG_LOGLEVEL_EMERG                  = 0, +        LTTNG_LOGLEVEL_ALERT
> = 1, +        LTTNG_LOGLEVEL_CRIT                   = 2, +
> LTTNG_LOGLEVEL_ERR                    = 3, +        LTTNG_LOGLEVEL_WARNING
> = 4, +        LTTNG_LOGLEVEL_NOTICE                 = 5, +
> LTTNG_LOGLEVEL_INFO                   = 6, +
> LTTNG_LOGLEVEL_DEBUG_SYSTEM           = 7, +
> LTTNG_LOGLEVEL_DEBUG_PROGRAM          = 8, +
> LTTNG_LOGLEVEL_DEBUG_PROCESS          = 9, +
> LTTNG_LOGLEVEL_DEBUG_MODULE           = 10, +
> LTTNG_LOGLEVEL_DEBUG_UNIT             = 11, +
> LTTNG_LOGLEVEL_DEBUG_FUNCTION         = 12, +
> LTTNG_LOGLEVEL_DEBUG_LINE             = 13, +        LTTNG_LOGLEVEL_DEBUG
> = 14, +}; + +%rename("EVENT_SPLICE") LTTNG_EVENT_SPLICE; 
> +%rename("EVENT_MMAP") LTTNG_EVENT_MMAP; +enum lttng_event_output { +
> LTTNG_EVENT_SPLICE                    = 0, +	LTTNG_EVENT_MMAP
> = 1, +}; + +%rename("EVENT_CONTEXT_PID") LTTNG_EVENT_CONTEXT_PID; 
> +%rename("EVENT_CONTEXT_PERF_COUNTER") LTTNG_EVENT_CONTEXT_PERF_COUNTER; 
> +%rename("EVENT_CONTEXT_PROCNAME") LTTNG_EVENT_CONTEXT_PROCNAME; 
> +%rename("EVENT_CONTEXT_PRIO") LTTNG_EVENT_CONTEXT_PRIO; 
> +%rename("EVENT_CONTEXT_NICE") LTTNG_EVENT_CONTEXT_NICE; 
> +%rename("EVENT_CONTEXT_VPID") LTTNG_EVENT_CONTEXT_VPID; 
> +%rename("EVENT_CONTEXT_TID") LTTNG_EVENT_CONTEXT_TID; 
> +%rename("EVENT_CONTEXT_VTID") LTTNG_EVENT_CONTEXT_VTID; 
> +%rename("EVENT_CONTEXT_PPID") LTTNG_EVENT_CONTEXT_PPID; 
> +%rename("EVENT_CONTEXT_VPPID") LTTNG_EVENT_CONTEXT_VPPID; 
> +%rename("EVENT_CONTEXT_PTHREAD_ID") LTTNG_EVENT_CONTEXT_PTHREAD_ID; +enum
> lttng_event_context_type { +	LTTNG_EVENT_CONTEXT_PID               = 0, +
> LTTNG_EVENT_CONTEXT_PERF_COUNTER      = 1, +	LTTNG_EVENT_CONTEXT_PROCNAME
> = 2, +	LTTNG_EVENT_CONTEXT_PRIO              = 3, +
> LTTNG_EVENT_CONTEXT_NICE              = 4, +	LTTNG_EVENT_CONTEXT_VPID
> = 5, +	LTTNG_EVENT_CONTEXT_TID               = 6, +
> LTTNG_EVENT_CONTEXT_VTID              = 7, +	LTTNG_EVENT_CONTEXT_PPID
> = 8, +	LTTNG_EVENT_CONTEXT_VPPID             = 9, +
> LTTNG_EVENT_CONTEXT_PTHREAD_ID        = 10, +}; + 
> +%rename("CALIBRATE_FUNCTION") LTTNG_CALIBRATE_FUNCTION; +enum
> lttng_calibrate_type { +	LTTNG_CALIBRATE_FUNCTION              = 0, +}; + 
> + + +// ============================================= +//		TYPEMAPS +//
> ============================================= + +//list_sessions 
> +%typemap(argout) struct lttng_session **sessions{ + +	int l =
> PyInt_AsSsize_t($result); +	if (l >= 0) +	{ +		PyObject *sessions =
> PyList_New(0); +		int i; +		for(i=0; i<l; i++) +		{ +			PyObject *tmp =
> PyTuple_New(4); +			PyObject *name = PyString_FromString((*$1)[i].name); +
> PyObject *path = PyString_FromString((*$1)[i].path); +			PyObject *enabled
> = PyInt_FromSize_t((*$1)[i].enabled); +			PyObject *padding =
> PyString_FromString((*$1)[i].padding); + +			PyTuple_SetItem(tmp, 0,
> name); +			PyTuple_SetItem(tmp, 1, path); +			PyTuple_SetItem(tmp, 2,
> enabled); +			PyTuple_SetItem(tmp, 3, padding); +			PyList_Append(sessions,
> tmp); +		} +		$result = sessions; +	} +} +%typemap(in,numinputs=0) struct
> lttng_session **sessions (struct lttng_session *temp){ +	$1=&temp; +} + 
> +//list_domains +%typemap(argout) struct lttng_domain **domains{ + +	int l
> = PyInt_AsSsize_t($result); +	if (l >= 0) +	{ +		PyObject *dom =
> PyList_New(0); +		int i; +		for(i=0; i<l; i++) +		{ +			PyObject *tmp =
> PyTuple_New(5); +			PyObject *type = PyInt_FromSize_t((*$1)[i].type); +
> PyObject *execname = PyString_FromString((*$1)[i].attr.exec_name); +
> PyObject *pid = PyInt_FromSize_t((*$1)[i].attr.pid); +			PyObject *padding
> = PyString_FromString((*$1)[i].padding); +			PyObject *attrpadding =
> PyString_FromString((*$1)[i].attr.padding); + +			PyTuple_SetItem(tmp, 0,
> type); +			PyTuple_SetItem(tmp, 1, padding); +			PyTuple_SetItem(tmp, 2,
> pid); +			PyTuple_SetItem(tmp, 3, execname); +			PyTuple_SetItem(tmp, 4,
> attrpadding); +			PyList_Append(dom, tmp); +		} +		$result = dom; +	} +} 
> +%typemap(in,numinputs=0) struct lttng_domain **domains (struct
> lttng_domain *temp){ +	$1=&temp; +} + +//list_channels +%typemap(argout)
> struct lttng_channel **channels{ + +	int l = PyInt_AsSsize_t($result); +	if
> (l >= 0) +	{ +		PyObject *chan = PyList_New(0); +		int i; +		for(i=0; i<l;
> i++) +		{ +			PyObject *tmp = PyTuple_New(4); +			PyObject *name =
> PyString_FromString((*$1)[i].name); +			PyObject *enabled =
> PyInt_FromSize_t((*$1)[i].enabled); +			PyObject *padding =
> PyString_FromString((*$1)[i].padding); + +			PyObject *attrtmp =
> PyTuple_New(7); +			PyObject *overwrite =
> PyInt_FromLong((*$1)[i].attr.overwrite); +			PyObject *subbuf =
> PyInt_FromSize_t((*$1)[i].attr.subbuf_size); +			PyObject *num =
> PyInt_FromSize_t((*$1)[i].attr.num_subbuf); +			PyObject *switchtimer =
> PyInt_FromSize_t((*$1)[i].attr.switch_timer_interval); +			PyObject
> *readtimer = PyInt_FromSize_t((*$1)[i].attr.read_timer_interval); +
> PyObject *output = PyInt_FromSize_t((*$1)[i].attr.output); +			PyObject
> *attrpad = PyString_FromString((*$1)[i].attr.padding); + +
> PyTuple_SetItem(attrtmp, 0, overwrite); +			PyTuple_SetItem(attrtmp, 1,
> subbuf); +			PyTuple_SetItem(attrtmp, 2, num); +			PyTuple_SetItem(attrtmp,
> 3, switchtimer); +			PyTuple_SetItem(attrtmp, 4, readtimer); +
> PyTuple_SetItem(attrtmp, 5, output); +			PyTuple_SetItem(attrtmp, 6,
> attrpad); + +			PyTuple_SetItem(tmp, 0, name); +			PyTuple_SetItem(tmp, 1,
> enabled); +			PyTuple_SetItem(tmp, 2, padding); +			PyTuple_SetItem(tmp, 3,
> attrtmp); +			PyList_Append(chan, tmp); +		} +		$result = chan; +	} +} 
> +%typemap(in,numinputs=0) struct lttng_channel **channels (struct
> lttng_channel *temp){ +	$1=&temp; +} + +//list_events & list_tracepoints 
> +%typemap(argout) struct lttng_event **events{ + +	int l =
> PyInt_AsSsize_t($result); +	if (l >= 0) +	{ +		PyObject *events =
> PyList_New(0); +		int i; +		for(i=0; i<l; i++) +		{ +			PyObject *tmp =
> PyTuple_New(10); +			PyObject *name = PyString_FromString((*$1)[i].name); +
> PyObject *type = PyInt_FromSize_t((*$1)[i].type); +			PyObject
> *logleveltype = PyInt_FromSize_t((*$1)[i].loglevel_type); +			PyObject
> *loglevel = PyInt_FromLong((*$1)[i].loglevel); +			PyObject *enabled =
> PyInt_FromLong((*$1)[i].enabled); +			PyObject *pid =
> PyInt_FromSize_t((*$1)[i].pid); +			PyObject *padding =
> PyString_FromString((*$1)[i].padding); +			PyObject *attrpadding =
> PyString_FromString((*$1)[i].attr.padding); + +			PyObject *probe =
> PyTuple_New(4); +			PyObject *addr =
> PyInt_FromSize_t((*$1)[i].attr.probe.addr); +			PyObject *offset =
> PyInt_FromSize_t((*$1)[i].attr.probe.offset); +			PyObject *symbolname =
> PyString_FromString((*$1)[i].attr.probe.symbol_name); +			PyObject
> *probepad = PyString_FromString((*$1)[i].attr.probe.padding); + +
> PyObject *function = PyTuple_New(2); +			PyObject *f_symbolname =
> PyString_FromString((*$1)[i].attr.ftrace.symbol_name); +			PyObject *f_pad
> = PyString_FromString((*$1)[i].attr.ftrace.padding); + +
> PyTuple_SetItem(function, 0, f_symbolname); +			PyTuple_SetItem(function,
> 1, f_pad); + +			PyTuple_SetItem(probe, 0, addr); +
> PyTuple_SetItem(probe, 1, offset); +			PyTuple_SetItem(probe, 2,
> symbolname); +			PyTuple_SetItem(probe, 3, probepad); + +
> PyTuple_SetItem(tmp, 0, name); +			PyTuple_SetItem(tmp, 1, type); +
> PyTuple_SetItem(tmp, 2, logleveltype); +			PyTuple_SetItem(tmp, 3,
> loglevel); +			PyTuple_SetItem(tmp, 4, enabled); +			PyTuple_SetItem(tmp,
> 5, pid); +			PyTuple_SetItem(tmp, 6, padding); +			PyTuple_SetItem(tmp, 7,
> probe); +			PyTuple_SetItem(tmp, 8, function); +			PyTuple_SetItem(tmp, 9,
> attrpadding); +			PyList_Append(events, tmp); +		} +		$result = events; +
> } +} +%typemap(in,numinputs=0) struct lttng_event **events (struct
> lttng_event *temp){ +	$1=&temp; +} + + + +//
> ============================================= +//		FUNCTIONS +//
> ============================================= + +%rename("create")
> lttng_create_session(const char *name, const char *path); 
> +%rename("destroy") lttng_destroy_session(const char *name); 
> +%rename("_lttng_create_handle") lttng_create_handle(const char
> *session_name, struct lttng_domain *domain); 
> +%rename("_lttng_destroy_handle") lttng_destroy_handle(struct lttng_handle
> *handle); +%rename("_lttng_list_sessions") lttng_list_sessions(struct
> lttng_session **sessions); +%rename("_lttng_list_domains")
> lttng_list_domains(const char *session_name, struct lttng_domain
> **domains); +%rename("_lttng_list_channels") lttng_list_channels(struct
> lttng_handle *handle,struct lttng_channel **channels); 
> +%rename("_lttng_list_events") lttng_list_events(struct lttng_handle
> *handle, const char *channel_name, struct lttng_event **events); 
> +%rename("_lttng_list_tracepoints") lttng_list_tracepoints(struct
> lttng_handle *handle, struct lttng_event **events); 
> +%rename("session_daemon_alive") lttng_session_daemon_alive(void); 
> +%rename("set_tracing_group") lttng_set_tracing_group(const char *name); 
> +%rename("strerror") lttng_strerror(int code); 
> +%rename("_lttng_register_consumer") lttng_register_consumer(struct
> lttng_handle *handle, const char *socket_path); +%rename("start")
> lttng_start_tracing(const char *session_name); +%rename("stop")
> lttng_stop_tracing(const char *session_name); 
> +%rename("_lttng_add_context") lttng_add_context(struct lttng_handle
> *handle, struct lttng_event_context *ctx, const char *event_name, const
> char *channel_name); +%rename("_lttng_enable_event")
> lttng_enable_event(struct lttng_handle *handle,	struct lttng_event *ev,
> const char *channel_name); +%rename("_lttng_enable_channel")
> lttng_enable_channel(struct lttng_handle *handle, struct lttng_channel
> *chan); +%rename("_lttng_disable_event") lttng_disable_event(struct
> lttng_handle *handle, const char *name, const char *channel_name); 
> +%rename("_lttng_disable_channel") lttng_disable_channel(struct
> lttng_handle *handle, const char *name); +%rename("_lttng_calibrate")
> lttng_calibrate(struct lttng_handle *handle, struct lttng_calibrate
> *calibrate); +%rename("channel_set_default_attr")
> lttng_channel_set_default_attr(struct lttng_domain *domain, struct
> lttng_channel_attr *attr); + +//Redefined functions +struct lttng_handle
> *lttng_create_handle(const char *session_name, +		struct lttng_domain
> *domain); +void lttng_destroy_handle(struct lttng_handle *handle); +int
> lttng_list_channels(struct lttng_handle *handle,struct lttng_channel
> **channels); +int lttng_list_events(struct lttng_handle *handle, +		const
> char *channel_name, struct lttng_event **events); +int
> lttng_list_tracepoints(struct lttng_handle *handle, struct lttng_event
> **events); +int lttng_add_context(struct lttng_handle *handle, struct
> lttng_event_context *ctx, +		const char *event_name,	const char
> *channel_name); +int lttng_enable_event(struct lttng_handle *handle, +
> struct lttng_event *ev, const char *channel_name); +int
> lttng_enable_channel(struct lttng_handle *handle, struct lttng_channel
> *chan); +int lttng_disable_event(struct lttng_handle *handle, +		const char
> *name, const char *channel_name); +int lttng_disable_channel(struct
> lttng_handle *handle, const char *name); +int lttng_calibrate(struct
> lttng_handle *handle, struct lttng_calibrate *calibrate); +int
> lttng_register_consumer(struct lttng_handle *handle, const char
> *socket_path); +int lttng_list_sessions(struct lttng_session **sessions); 
> +int lttng_list_domains(const char *session_name, struct lttng_domain
> **domains); + +//Functions not needing redefinition 
> +%feature("docstring")"create(str name, str path) -> int + +Create a new
> tracing session using name and path. +Returns size of returned session
> payload data or a negative error code." +int lttng_create_session(const
> char *name, const char *path); + + +%feature("docstring")"destroy(str name)
> -> int + +Tear down tracing session using name. +Returns size of returned
> session payload data or a negative error code." +int
> lttng_destroy_session(const char *name); + + 
> +%feature("docstring")"session_daemon_alive() -> int + +Check if session
> daemon is alive. +Return 1 if alive or 0 if not. +On error returns a
> negative value." +int lttng_session_daemon_alive(void); + + 
> +%feature("docstring")"set_tracing_group(str name) -> int + +Sets the
> tracing_group variable with name. +This function allocates memory pointed
> to by tracing_group. +On success, returns 0, on error, returns -1 (null
> name) or -ENOMEM." +int lttng_set_tracing_group(const char *name); + + 
> +%feature("docstring")"strerror(int code) -> char + +Returns a human
> readable string describing +the error code (a negative value)." +const char
> *lttng_strerror(int code); + + +%feature("docstring")"start(str
> session_name) -> int + +Start tracing for all traces of the session. 
> +Returns size of returned session payload data or a negative error code." 
> +int lttng_start_tracing(const char *session_name); + + 
> +%feature("docstring")"stop(str session_name) -> int + +Stop tracing for
> all traces of the session. +Returns size of returned session payload data
> or a negative error code." +int lttng_stop_tracing(const char
> *session_name); + + +%feature("docstring")"channel_set_default_attr(Domain
> domain, ChannelAttr attr) + +Set default channel attributes. +If either or
> both of the arguments are null, attr content is zeroe'd." +void
> lttng_channel_set_default_attr(struct lttng_domain *domain, struct
> lttng_channel_attr *attr); + + +//
> ============================================= +//	Python redefinition of
> some functions +//	(List and Handle-related) +//
> ============================================= + +%feature("docstring")"" 
> +%pythoncode %{ + +def list_sessions(): +	""" +	list_sessions() -> dict + +
> Ask the session daemon for all available sessions. +	Returns a dict of
> Session instances, the key is the name; +	on error, returns a negative
> value. +	""" + +	ses_list = _lttng_list_sessions() +	if type(ses_list) is
> int: +		return ses_list + +	sessions = {} + +	for ses_elements in
> ses_list: +		ses = Session() +		ses.name = ses_elements[0] +		ses.path =
> ses_elements[1] +		ses.enabled = ses_elements[2] +		ses.padding =
> ses_elements[3] + +		sessions[ses.name] = ses + +	return sessions + + +def
> list_domains(session_name): +	""" +	list_domains(str session_name) -> list 
> + +	Ask the session daemon for all available domains of a session. +
> Returns a list of Domain instances; +	on error, returns a negative value. +
> """ + +	dom_list = _lttng_list_domains(session_name) +	if type(dom_list) is
> int: +		return dom_list + +	domains = [] + +	for dom_elements in dom_list: 
> +		dom = Domain() +		dom.type = dom_elements[0] +		dom.paddinf =
> dom_elements[1] +		dom.attr.pid = dom_elements[2] +		dom.attr.exec_name =
> dom_elements[3] +		dom.attr.padding = dom_elements[4] + +
> domains.append(dom) + +	return domains + + +def list_channels(handle): +
> """ +	list_channels(Handle handle) -> dict + +	Ask the session daemon for
> all available channels of a session. +	Returns a dict of Channel instances,
> the key is the name; +	on error, returns a negative value. +	""" + +	try: +
> chan_list = _lttng_list_channels(handle._h) +	except AttributeError: +
> raise TypeError("in method 'list_channels', argument 1 must be a Handle
> instance") + +	if type(chan_list) is int: +		return chan_list + +	channels
> = {} + +	for channel_elements in chan_list: +		chan = Channel() +
> chan.name = channel_elements[0] +		chan.enabled = channel_elements[1] +
> chan.padding = channel_elements[2] +		chan.attr.overwrite =
> channel_elements[3][0] +		chan.attr.subbuf_size = channel_elements[3][1] +
> chan.attr.num_subbuf = channel_elements[3][2] +
> chan.attr.switch_timer_interval = channel_elements[3][3] +
> chan.attr.read_timer_interval = channel_elements[3][4] +		chan.attr.output
> = channel_elements[3][5] +		chan.attr.padding = channel_elements[3][6] + +
> channels[chan.name] = chan + +	return channels + + +def list_events(handle,
> channel_name): +	""" +	list_events(Handle handle, str channel_name) ->
> dict + +	Ask the session daemon for all available events of a session
> channel. +	Returns a dict of Event instances, the key is the name; +	on
> error, returns a negative value. +	""" + +	try: +		ev_list =
> _lttng_list_events(handle._h, channel_name) +	except AttributeError: +
> raise TypeError("in method 'list_events', argument 1 must be a Handle
> instance") + +	if type(ev_list) is int: +		return ev_list + +	events = {} 
> + +	for ev_elements in ev_list: +		ev = Event() +		ev.name =
> ev_elements[0] +		ev.type = ev_elements[1] +		ev.loglevel_type =
> ev_elements[2] +		ev.loglevel = ev_elements[3] +		ev.enabled =
> ev_elements[4] +		ev.pid = ev_elements[5] +		ev.attr.padding =
> ev_elements[6] +		ev.attr.probe.addr = ev_elements[7][0] +
> ev.attr.probe.offset = ev_elements[7][1] +		ev.attr.probe.symbol_name =
> ev_elements[7][2] +		ev.attr.probe.padding = ev_elements[7][3] +
> ev.attr.ftrace.symbol_name = ev_elements[8][0] +		ev.attr.ftrace.padding =
> ev_elements[8][1] +		ev.attr.padding = ev_elements[9] + +		events[ev.name]
> = ev + +	return events + + +def list_tracepoints(handle): +	""" +
> list_tracepoints(Handle handle) -> dict + +	Returns a dict of Event
> instances, the key is the name; +	on error, returns a negative value. +
> """ + +	try: +		ev_list = _lttng_list_tracepoints(handle._h) +	except
> AttributeError: +		raise TypeError("in method 'list_tracepoints', argument
> 1 must be a Handle instance") + +	if type(ev_list) is int: +		return
> ev_list + +	events = {} + +	for ev_elements in ev_list: +		ev = Event() +
> ev.name = ev_elements[0] +		ev.type = ev_elements[1] +		ev.loglevel_type =
> ev_elements[2] +		ev.loglevel = ev_elements[3] +		ev.enabled =
> ev_elements[4] +		ev.pid = ev_elements[5] +		ev.attr.padding =
> ev_elements[6] +		ev.attr.probe.addr = ev_elements[7][0] +
> ev.attr.probe.offset = ev_elements[7][1] +		ev.attr.probe.symbol_name =
> ev_elements[7][2] +		ev.attr.probe.padding = ev_elements[7][3] +
> ev.attr.ftrace.symbol_name = ev_elements[8][0] +		ev.attr.ftrace.padding =
> ev_elements[8][1] +		ev.attr.padding = ev_elements[9] + +		events[ev.name]
> = ev + +	return events + + +def register_consumer(handle, socket_path): +
> """ +	register_consumer(Handle handle, str socket_path) -> int + +	Register
> an outside consumer. +	Returns size of returned session payload data or a
> negative error code. +	""" + +	try: +		return
> _lttng_register_consumer(handle._h, socket_path) +	except AttributeError: +
> raise TypeError("in method 'register_consumer', argument 1 must be a Handle
> instance") + + +def add_context(handle, event_context, event_name,
> channel_name): +	""" +	add_context(Handle handle, EventContext ctx, +
> str event_name, str channel_name) -> int + +	Add context to event and/or
> channel. +	If event_name is None, the context is applied to all events of
> the channel. +	If channel_name is None, a lookup of the event's channel is
> done. +	If both are None, the context is applied to all events of all
> channels. +	Returns the size of the returned payload data or a negative
> error code. +	""" + +	try: +		return _lttng_add_context(handle._h,
> event_context, event_name, channel_name) +	except AttributeError: +		raise
> TypeError("in method 'add_context', argument 1 must be a Handle instance") 
> + + +def enable_event(handle, event, channel_name): +	""" +
> enable_event(Handle handle, Event event, +		    str channel_name) -> int + 
> +	Enable event(s) for a channel. +	If no event name is specified, all
> events are enabled. +	If no channel name is specified, the default
> 'channel0' is used. +	Returns size of returned session payload data or a
> negative error code. +	""" + +	try: +		return
> _lttng_enable_event(handle._h, event, channel_name) +	except
> AttributeError: +		raise TypeError("in method 'enable_event', argument 1
> must be a Handle instance") + + +def enable_channel(handle, channel): +
> """ +	enable_channel(Handle handle, Channel channel -> int + +	Enable
> channel per domain +	Returns size of returned session payload data or a
> negative error code. +	""" + +	try: +		return
> _lttng_enable_channel(handle._h, channel) +	except AttributeError: +		raise
> TypeError("in method 'enable_channel', argument 1 must be a Handle
> instance") + + +def disable_event(handle, name, channel_name): +	""" +
> disable_event(Handle handle, str name, str channel_name) -> int + +	Disable
> event(s) of a channel and domain. +	If no event name is specified, all
> events are disabled. +	If no channel name is specified, the default
> 'channel0' is used. +	Returns size of returned session payload data or a
> negative error code +	""" + +	try: +		return
> _lttng_disable_event(handle._h, name, channel_name) +	except
> AttributeError: +		raise TypeError("in method 'disable_event', argument 1
> must be a Handle instance") + + +def disable_channel(handle, name): +	""" +
> disable_channel(Handle handle, str name) -> int + +	All tracing will be
> stopped for registered events of the channel. +	Returns size of returned
> session payload data or a negative error code. +	""" + +	try: +		return
> _lttng_disable_channel(handle._h, name) +	except AttributeError: +		raise
> TypeError("in method 'disable_channel', argument 1 must be a Handle
> instance") + + +def calibrate(handle, calibrate): +	""" +	calibrate(Handle
> handle, Calibrate calibrate) -> int + +	Quantify LTTng overhead. +	Returns
> size of returned session payload data or a negative error code. +	""" + +
> try: +		return _lttng_calibrate(handle._h, calibrate) +	except
> AttributeError: +		raise TypeError("in method 'calibrate', argument 1 must
> be a Handle instance") +%} + + +//
> ============================================= +//		Handle class +//   Used
> to prevent freeing unallocated memory +//
> ============================================= + +%feature("docstring")"" 
> +%feature("autodoc", "1"); + +%pythoncode %{ +class Handle: +        """ +
> Manages a handle. +	Takes two arguments: (str session_name, Domain domain) 
> +	""" + +	__frozen = False + +	def __init__(self, session_name, domain): +
> if type(session_name) is not str: +			raise TypeError("in method
> '__init__', argument 2 of type 'str'") +		if type(domain) is not Domain and
> domain is not None: +			raise TypeError("in method '__init__', argument 3
> of type 'lttng.Domain'") + +		self._sname = session_name +		if domain is
> None: +			self._domtype = None +		else: +			self._domtype = domain.type +
> self._h = _lttng_create_handle(session_name, domain) +		self.__frozen =
> True + +	def __del__(self): +		_lttng_destroy_handle(self._h) + +	def
> __repr__(self): +		if self._domtype == 1: +			domstr = "DOMAIN_KERNEL" +
> elif self._domtype == 2: +			domstr = "DOMAIN_UST" +		else: +			domstr =
> self._domtype + +		return "lttng.Handle; session('{}'),
> domain.type({})".format( +			self._sname, domstr) + +	def __setattr__(self,
> attr, val): +		if self.__frozen: +			raise NotImplementedError("cannot
> modify attributes") +		else: +			self.__dict__[attr] = val +%} + + +//
> ============================================= +//		STRUCTURES +//
> ============================================= + +%rename("Domain")
> lttng_domain; +%rename("EventContext") lttng_event_context; 
> +%rename("Event") lttng_event; +%rename("Calibrate") lttng_calibrate; 
> +%rename("ChannelAttr") lttng_channel_attr; +%rename("Channel")
> lttng_channel; +%rename("Session") lttng_session; + +struct lttng_domain{ +
> enum lttng_domain_type type; +	char padding[LTTNG_DOMAIN_PADDING1]; + +
> union { +		pid_t pid; +		char exec_name[NAME_MAX]; +		char
> padding[LTTNG_DOMAIN_PADDING2]; +	} attr; + +	%extend { + 		char
> *__repr__() { +			static char temp[256]; +			switch ( $self->type ) { +
> case 1: +				sprintf(temp, "lttng.Domain; type(DOMAIN_KERNEL)"); +
> break; +			case 2: +				sprintf(temp, "lttng.Domain; type(DOMAIN_UST)"); +
> break; +			default: +				sprintf(temp, "lttng.Domain; type(%i)",
> $self->type); +				break; +			} +			return &temp[0]; +		} +	} +}; + +struct
> lttng_event_context { +	enum lttng_event_context_type ctx; +	char
> padding[LTTNG_EVENT_CONTEXT_PADDING1]; + +	union { +		struct
> lttng_event_perf_counter_ctx perf_counter; +		char
> padding[LTTNG_EVENT_CONTEXT_PADDING2]; +	} u; + +	%extend { + 		char
> *__repr__() { +			static char temp[256]; +			switch ( $self->ctx ) { +
> case 0: +				sprintf(temp, "lttng.EventContext; ctx(EVENT_CONTEXT_PID)"); +
> break; +			case 1: +				sprintf(temp, "lttng.EventContext;
> ctx(EVENT_CONTEXT_PERF_COUNTER)"); +				break; +			case 2: +
> sprintf(temp, "lttng.EventContext; ctx(EVENT_CONTEXT_PROCNAME)"); +
> break; +			case 3: +				sprintf(temp, "lttng.EventContext;
> ctx(EVENT_CONTEXT_PRIO)"); +				break; +			case 4: +				sprintf(temp,
> "lttng.EventContext; ctx(EVENT_CONTEXT_NICE)"); +				break; +			case 5: +
> sprintf(temp, "lttng.EventContext; ctx(EVENT_CONTEXT_VPID)"); +				break; +
> case 6: +				sprintf(temp, "lttng.EventContext; ctx(EVENT_CONTEXT_TID)"); +
> break; +			case 7: +				sprintf(temp, "lttng.EventContext;
> ctx(EVENT_CONTEXT_VTID)"); +				break; +			case 8: +				sprintf(temp,
> "lttng.EventContext; ctx(EVENT_CONTEXT_PPID)"); +				break; +			case 9: +
> sprintf(temp, "lttng.EventContext; ctx(EVENT_CONTEXT_VPPID)"); +				break; 
> +			case 10: +				sprintf(temp, "lttng.EventContext;
> ctx(EVENT_CONTEXT_PTHREAD_ID)"); +				break; +			default: +
> sprintf(temp, "lttng.EventContext; type(%i)", $self->ctx); +				break; +
> } +			return &temp[0]; +		} +	} +}; + +struct lttng_event_probe_attr { +
> uint64_t addr; +	uint64_t offset; +	char
> symbol_name[LTTNG_SYMBOL_NAME_LEN]; +	char
> padding[LTTNG_EVENT_PROBE_PADDING1]; +}; + +struct
> lttng_event_function_attr { +	char symbol_name[LTTNG_SYMBOL_NAME_LEN]; +
> char padding[LTTNG_EVENT_FUNCTION_PADDING1]; +}; + +struct lttng_event { +
> enum lttng_event_type type; +	char name[LTTNG_SYMBOL_NAME_LEN]; + +	enum
> lttng_loglevel_type loglevel_type; +	int loglevel; + +	int32_t enabled; +
> pid_t pid; + +	char padding[LTTNG_EVENT_PADDING1]; + +	union { +		struct
> lttng_event_probe_attr probe; +		struct lttng_event_function_attr ftrace; 
> + +		char padding[LTTNG_EVENT_PADDING2]; +	} attr; + +	%extend { + 		char
> *__repr__() { +			static char temp[512]; +			char evtype[50]; +			char
> logtype[50]; + +			switch ( $self->type ) { +			case -1: +
> sprintf(evtype, "EVENT_ALL"); +				break; +			case 0: +				sprintf(evtype,
> "EVENT_TRACEPOINT"); +				break; +			case 1: +				sprintf(evtype,
> "EVENT_PROBE"); +				break; +			case 2: +				sprintf(evtype,
> "EVENT_FUNCTION"); +				break; +			case 3: +				sprintf(evtype,
> "EVENT_FUNCTION_ENTRY"); +				break; +			case 4: +				sprintf(evtype,
> "EVENT_NOOP"); +				break; +			case 5: +				sprintf(evtype,
> "EVENT_SYSCALL"); +				break; +			default: +				sprintf(evtype, "%i",
> $self->type); +				break; +			} + +			switch ( $self->loglevel_type ) { +
> case 0: +				sprintf(logtype, "EVENT_LOGLEVEL_ALL"); +				break; +			case
> 1: +				sprintf(logtype, "EVENT_LOGLEVEL_RANGE"); +				break; +			case 2: +
> sprintf(logtype, "EVENT_LOGLEVEL_SINGLE"); +				break; +			default: +
> sprintf(logtype, "%i", $self->loglevel_type); +				break; +			} + +
> sprintf(temp, "lttng.Event; name('%s'), type(%s), " +
> "loglevel_type(%s), loglevel(%i), " +				"enabled(%s), pid(%i)", +
> $self->name, evtype, logtype, $self->loglevel, +				$self->enabled ? "True"
> : "False", $self->pid); +			return &temp[0]; +		} +	} +}; + +struct
> lttng_calibrate { +	enum lttng_calibrate_type type; +	char
> padding[LTTNG_CALIBRATE_PADDING1]; + +	%extend { + 		char *__repr__() { +
> static char temp[256]; +			switch ( $self->type ) { +			case 0: +
> sprintf(temp, "lttng.Calibrate; type(CALIBRATE_FUNCTION)"); +				break; +
> default: +				sprintf(temp, "lttng.Calibrate; type(%i)", $self->type); +
> break; +			} +			return &temp[0]; +		} +	} +}; + +struct lttng_channel_attr
> { +	int overwrite; +	uint64_t subbuf_size; +	uint64_t num_subbuf; +
> unsigned int switch_timer_interval; +	unsigned int read_timer_interval; +
> enum lttng_event_output output; + +	char
> padding[LTTNG_CHANNEL_ATTR_PADDING1]; + +	%extend { + 		char *__repr__() { 
> +			static char temp[256]; +			char evout[25]; + +			switch ( $self->output
> ) { +			case 0: +				sprintf(evout, "EVENT_SPLICE"); +				break; +			case
> 1: +				sprintf(evout, "EVENT_MMAP"); +				break; +			default: +
> sprintf(evout, "%i", $self->output); +				break; +			} +			sprintf(temp,
> "lttng.ChannelAttr; overwrite(%i), subbuf_size(%lu), " +
> "num_subbuf(%lu), switch_timer_interval(%u), " +
> "read_timer_interval(%u), output(%s)", +				$self->overwrite,
> $self->subbuf_size, $self->num_subbuf, +				$self->switch_timer_interval,
> $self->read_timer_interval, +				evout); +			return &temp[0]; +		} +	} +}; 
> + +struct lttng_channel { +	char name[LTTNG_SYMBOL_NAME_LEN]; +	uint32_t
> enabled; +	struct lttng_channel_attr attr; +	char
> padding[LTTNG_CHANNEL_PADDING1]; + +	%extend { + 		char *__repr__() { +
> static char temp[512]; +			sprintf(temp, "lttng.Channel; name('%s'),
> enabled(%s)", +				$self->name, $self->enabled ? "True" : "False"); +
> return &temp[0]; +		} +	} +}; + +struct lttng_session { +	char
> name[NAME_MAX]; +	char path[PATH_MAX]; +	uint32_t enabled; +	char
> padding[LTTNG_SESSION_PADDING1]; + +	%extend { + 		char *__repr__() { +
> static char temp[512]; +			sprintf(temp, "lttng.Session; name('%s'),
> path('%s'), enabled(%s)", +				$self->name, $self->path, +
> $self->enabled ? "True" : "False"); +			return &temp[0]; +		} +	} +}; diff
> --git a/src/python/tests/example.py b/src/python/tests/example.py new file
> mode 100644 index 0000000..9703170 --- /dev/null +++
> b/src/python/tests/example.py @@ -0,0 +1,109 @@ +#This example shows
> basically how to use the lttng-tools python module + +from lttng import * 
> + +# This error will be raised is something goes wrong +class
> LTTngError(Exception): +	def __init__(self, value): +		self.value = value +
> def __str__(self): +		return repr(self.value) + +#Setting up the domain to
> use +dom = Domain() +dom.type = DOMAIN_KERNEL + +#Setting up a channel to
> use +channel = Channel() +channel.name = "mychan" +channel.attr.overwrite =
> 0 +channel.attr.subbuf_size = 4096 +channel.attr.num_subbuf = 8 
> +channel.attr.switch_timer_interval = 0 +channel.attr.read_timer_interval =
> 200 +channel.attr.output = EVENT_SPLICE + +#Setting up some events that
> will be used +event = Event() +event.type = EVENT_TRACEPOINT 
> +event.loglevel_type = EVENT_LOGLEVEL_ALL + +sched_switch = Event() 
> +sched_switch.name = "sched_switch" +sched_switch.type = EVENT_TRACEPOINT 
> +sched_switch.loglevel_type = EVENT_LOGLEVEL_ALL + +sched_process_exit =
> Event() +sched_process_exit.name = "sched_process_exit" 
> +sched_process_exit.type = EVENT_TRACEPOINT 
> +sched_process_exit.loglevel_type = EVENT_LOGLEVEL_ALL + 
> +sched_process_free = Event() +sched_process_free.name =
> "sched_process_free" +sched_process_free.type = EVENT_TRACEPOINT 
> +sched_process_free.loglevel_type = EVENT_LOGLEVEL_ALL + + +#Creating a new
> session +res = create("test","/lttng-traces/test") +if res<0: +	raise
> LTTngError(strerror(res)) + +#Creating handle +han = None +han =
> Handle("test", dom) +if han is None: +	raise LTTngError("Handle not
> created") + +#Enabling the kernel channel +res = enable_channel(han,
> channel) +if res<0: +	raise LTTngError(strerror(res)) + +#Enabling some
> events in given channel +#To enable all events in default channel, use 
> +#enable_event(han, event, None) +res = enable_event(han, sched_switch,
> channel.name) +if res<0: +	raise LTTngError(strerror(res)) + +res =
> enable_event(han, sched_process_exit, channel.name) +if res<0: +	raise
> LTTngError(strerror(res)) + +res = enable_event(han, sched_process_free,
> channel.name) +if res<0: +	raise LTTngError(strerror(res)) + +#Disabling an
> event +res = disable_event(han, sched_switch.name, channel.name) +if
> res<0: +	raise LTTngError(strerror(res)) + +#Getting a list of the
> channels +l = list_channels(han) +if type(l) is int: +		raise
> LTTngError(strerror(l)) + +#Starting the trace +res = start("test") +if
> res<0: +	raise LTTngError(strerror(res)) + +#Stopping the trace +res =
> stop("test") +if res<0: +	raise LTTngError(strerror(res)) + +#Disabling a
> channel +res = disable_channel(han, channel.name) +if res<0: +	raise
> LTTngError(strerror(res)) + +#Destroying the handle +del han + +#Destroying
> the session +res = destroy("test") +if res<0: +	raise
> LTTngError(strerror(res)) diff --git a/src/python/tests/run.sh
> b/src/python/tests/run.sh new file mode 100644 index 0000000..7de819b ---
> /dev/null +++ b/src/python/tests/run.sh @@ -0,0 +1 @@ +python tests.py diff
> --git a/src/python/tests/tests.py b/src/python/tests/tests.py new file mode
> 100644 index 0000000..a4be981 --- /dev/null +++
> b/src/python/tests/tests.py @@ -0,0 +1,310 @@ +import unittest +import os 
> +import time +from lttng import * + +class TestLttngPythonModule
> (unittest.TestCase): + +	def test_kernel_all_events(self): +		dom =
> Domain() +		dom.type = DOMAIN_KERNEL + +		event = Event() +		event.type =
> EVENT_TRACEPOINT +		event.loglevel_type = EVENT_LOGLEVEL_ALL + +		han =
> Handle("test_kernel_all_ev", dom) + +		r =
> create("test_kernel_all_ev","/lttng-traces/test") +
> self.assertGreaterEqual(r, 0, strerror(r)) + +		r = enable_event(han,
> event, None) +		self.assertGreaterEqual(r, 0, strerror(r)) + +		r =
> start("test_kernel_all_ev") +		self.assertGreaterEqual(r, 0, strerror(r)) +
> time.sleep(2) + +		r = stop("test_kernel_all_ev") +
> self.assertGreaterEqual(r, 0, strerror(r)) + +		r =
> destroy("test_kernel_all_ev") +		self.assertGreaterEqual(r, 0,
> strerror(r)) + + +	def test_kernel_event(self): + +		dom = Domain() +
> dom.type = DOMAIN_KERNEL + +		channel = Channel() +		channel.name="mychan" 
> +		channel.attr.overwrite = 0 +		channel.attr.subbuf_size = 4096 +
> channel.attr.num_subbuf = 8 +		channel.attr.switch_timer_interval = 0 +
> channel.attr.read_timer_interval = 200 +		channel.attr.output =
> EVENT_SPLICE + +		sched_switch = Event() +		sched_switch.name =
> "sched_switch" +		sched_switch.type = EVENT_TRACEPOINT +
> sched_switch.loglevel_type = EVENT_LOGLEVEL_ALL + +		sched_process_exit =
> Event() +		sched_process_exit.name = "sched_process_exit" +
> sched_process_exit.type = EVENT_TRACEPOINT +
> sched_process_exit.loglevel_type = EVENT_LOGLEVEL_ALL + +
> sched_process_free = Event() +		sched_process_free.name =
> "sched_process_free" +		sched_process_free.type = EVENT_TRACEPOINT +
> sched_process_free.loglevel_type = EVENT_LOGLEVEL_ALL + +		han =
> Handle("test_kernel_event", dom) + +		#Create session test +		r =
> create("test_kernel_event","/lttng-traces/test") +
> self.assertGreaterEqual(r, 0, strerror(r)) + +		#Enabling channel tests +
> r = enable_channel(han, channel) +		self.assertGreaterEqual(r, 0,
> strerror(r)) + +		#Enabling events tests +		r = enable_event(han,
> sched_switch, channel.name) +		self.assertGreaterEqual(r, 0, strerror(r)) 
> + +		r = enable_event(han, sched_process_exit, channel.name) +
> self.assertGreaterEqual(r, 0, strerror(r)) + +		r = enable_event(han,
> sched_process_free, channel.name) +		self.assertGreaterEqual(r, 0,
> strerror(r)) + +		#Disabling events tests +		r = disable_event(han,
> sched_switch.name, channel.name) +		self.assertGreaterEqual(r, 0,
> strerror(r)) + +		r = disable_event(han, sched_process_free.name,
> channel.name) +		self.assertGreaterEqual(r, 0, strerror(r)) + +		#Renabling
> events tests +		r = enable_event(han, sched_switch, channel.name) +
> self.assertGreaterEqual(r, 0, strerror(r)) + +		r = enable_event(han,
> sched_process_free, channel.name) +		self.assertGreaterEqual(r, 0,
> strerror(r)) + +		#Start, stop, destroy +		r = start("test_kernel_event") +
> self.assertGreaterEqual(r, 0, strerror(r)) +		time.sleep(2) + +		r =
> stop("test_kernel_event") +		self.assertGreaterEqual(r, 0, strerror(r)) + +
> r=disable_channel(han, channel.name) +		self.assertGreaterEqual(r, 0,
> strerror(r)) + +		r=destroy("test_kernel_event") +
> self.assertGreaterEqual(r, 0, strerror(r)) + + + +	def
> test_ust_all_events(self): +		dom = Domain() +		dom.type = DOMAIN_UST + +
> event = Event() +		event.type = EVENT_TRACEPOINT +		event.loglevel_type =
> EVENT_LOGLEVEL_ALL + +		han = Handle("test_ust_all_ev", dom) + +		r =
> create("test_ust_all_ev","/lttng-traces/test") +
> self.assertGreaterEqual(r, 0, strerror(r)) + +		r = enable_event(han,
> event, None) +		self.assertGreaterEqual(r, 0, strerror(r)) + +		r =
> start("test_ust_all_ev") +		self.assertGreaterEqual(r, 0, strerror(r)) +
> time.sleep(2) + +		r = stop("test_ust_all_ev") +
> self.assertGreaterEqual(r, 0, strerror(r)) + +		r =
> destroy("test_ust_all_ev") +		self.assertGreaterEqual(r, 0, strerror(r)) + 
> + +	def test_ust_event(self): + +		dom = Domain() +		dom.type = DOMAIN_UST 
> + +		channel = Channel() +		channel.name="mychan" +		channel.attr.overwrite
> = 0 +		channel.attr.subbuf_size = 4096 +		channel.attr.num_subbuf = 8 +
> channel.attr.switch_timer_interval = 0 +		channel.attr.read_timer_interval
> = 200 +		channel.attr.output = EVENT_MMAP + +		ev1 = Event() +		ev1.name =
> "tp1" +		ev1.type = EVENT_TRACEPOINT +		ev1.loglevel_type =
> EVENT_LOGLEVEL_ALL + +		ev2 = Event() +		ev2.name = "ev2" +		ev2.type =
> EVENT_TRACEPOINT +		ev2.loglevel_type = EVENT_LOGLEVEL_ALL + +		ev3 =
> Event() +		ev3.name = "ev3" +		ev3.type = EVENT_TRACEPOINT +
> ev3.loglevel_type = EVENT_LOGLEVEL_ALL + +		han = Handle("test_ust_event",
> dom) + +		#Create session test +		r =
> create("test_ust_event","/lttng-traces/test") +		self.assertGreaterEqual(r,
> 0, strerror(r)) + +		#Enabling channel tests +		r = enable_channel(han,
> channel) +		self.assertGreaterEqual(r, 0, strerror(r)) + +		#Enabling
> events tests +		r = enable_event(han, ev1, channel.name) +
> self.assertGreaterEqual(r, 0, strerror(r)) + +		r = enable_event(han, ev2,
> channel.name) +		self.assertGreaterEqual(r, 0, strerror(r)) + +		r =
> enable_event(han, ev3, channel.name) +		self.assertGreaterEqual(r, 0,
> strerror(r)) + +		#Disabling events tests +		r = disable_event(han,
> ev1.name, channel.name) +		self.assertGreaterEqual(r, 0, strerror(r)) + +
> r = disable_event(han, ev3.name, channel.name) +
> self.assertGreaterEqual(r, 0, strerror(r)) + +		#Renabling events tests +
> r = enable_event(han, ev1, channel.name) +		self.assertGreaterEqual(r, 0,
> strerror(r)) + +		r = enable_event(han, ev3, channel.name) +
> self.assertGreaterEqual(r, 0, strerror(r)) + +		#Start, stop +		r =
> start("test_ust_event") +		self.assertGreaterEqual(r, 0, strerror(r)) +
> time.sleep(2) + +		r = stop("test_ust_event") +		self.assertGreaterEqual(r,
> 0, strerror(r)) + +		#Restart/restop +		r = start("test_ust_event") +
> self.assertGreaterEqual(r, 0, strerror(r)) +		time.sleep(2) + +		r =
> stop("test_ust_event") +		self.assertGreaterEqual(r, 0, strerror(r)) + +
> #Disabling channel and destroy +		r=disable_channel(han, channel.name) +
> self.assertGreaterEqual(r, 0, strerror(r)) + +
> r=destroy("test_ust_event") +		self.assertGreaterEqual(r, 0, strerror(r)) 
> + + +	def test_other_functions(self): +		dom = Domain() +
> dom.type=DOMAIN_KERNEL + +		event=Event() +		event.type=EVENT_TRACEPOINT +
> event.loglevel_type=EVENT_LOGLEVEL_ALL + +		calib = Calibrate() +
> calib.type = CALIBRATE_FUNCTION + +		ctx = EventContext() +
> ctx.type=EVENT_CONTEXT_PID + +		chattr = ChannelAttr() +		chattr.overwrite
> = 0 +		chattr.subbuf_size = 4096 +		chattr.num_subbuf = 8 +
> chattr.switch_timer_interval = 0 +		chattr.read_timer_interval = 200 +
> chattr.output = EVENT_SPLICE + +		han = Handle("test_otherf" , dom) + +		r
> = create("test_otherf","/lttng-traces/test") +		self.assertGreaterEqual(r,
> 0, strerror(r)) + +		r = enable_event(han, event, None) +
> self.assertGreaterEqual(r, 0, strerror(r)) + +		#Calibrate test +		r =
> calibrate(han , calib) +		self.assertGreaterEqual(r, 0, strerror(r)) + +
> #Context test +		r = add_context(han, ctx, "sched_switch", "channel0") +
> self.assertGreaterEqual(r, 0, strerror(r)) +		#Any channel +		r =
> add_context(han, ctx, "sched_wakeup", None) +		self.assertGreaterEqual(r,
> 0, strerror(r)) +		#All events +		r = add_context(han, ctx, None, None) +
> self.assertGreaterEqual(r, 0, strerror(r)) + +		#Def. channel attr +
> channel_set_default_attr(dom, chattr) +		channel_set_default_attr(None,
> None) + +		#Ses Daemon alive +		r = session_daemon_alive() +
> self.assertTrue(r == 1 or r == 0, strerror(r)) + +		#Setting trace group +
> r = set_tracing_group("testing") +		self.assertGreaterEqual(r, 0,
> strerror(r)) + + +		r = start("test_otherf") +		self.assertGreaterEqual(r,
> 0, strerror(r)) +		time.sleep(2) + +		r = stop("test_otherf") +
> self.assertGreaterEqual(r, 0, strerror(r)) + +		del han + +		r =
> destroy("test_otherf") +		self.assertGreaterEqual(r, 0, strerror(r)) + + 
> +if __name__ == "__main__": +	# CHECK IF ROOT +	if os.geteuid() == 0: +
> #Make sure session names don't already exist: +
> destroy("test_kernel_event") +		destroy("test_kernel_all_events") +
> destroy("test_ust_all_events") +		destroy("test_ust_event") +
> destroy("test_otherf") + +		unittest.main() +	else: +		print('Script must
> be run as root')
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJQGCc4AAoJEELoaioR9I02f68IAKCipHU8psxIkXyUECveu57F
1ZPe9wzanUrb5eaiLH07mmbVJf/1Bu08eLfiuu1naaV0ZZIa2DenTXHcuC4orGbE
/8KVBYidgDWIzY8lJOnw6wg+zB2ibnfTqtyhNE9Rqgesq6o776QfFgSkqzfQq/2m
BxOsE1jKzx6JbgdquO32KBAyQAgyQu8Z9aJUYgAd3peqrx19pwnWhgnY88rtAzNi
5ktGj6btK4HAcQ62Q8pmTTaOR0y5sBb7STDYF2pcNMPU3TeLBjkRhl/djva0C7t/
hPiL8IVT4AYC0y72Oof0kuSgaGIyHAxujAGHeOnOQP3KXhAvrow/bhJodbIo3pU=
=lEVV
-----END PGP SIGNATURE-----
