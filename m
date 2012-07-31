From: Danny Serres <serres@live.ca>
Subject: Re: [lttng-tools PATCH] lttng-tools python module
Date: Tue, 31 Jul 2012 17:09:14 -0400
Message-ID: <BLU170-W44E847CBD308DF9FB9C783C0C50__6983.09957883811$1343769008$gmane$org@phx.gbl>
References: <1343326167-11522-1-git-send-email-danny.serres@efficios.com>,
	<50182739.3030604@polymtl.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0329447577=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from blu0-omc3-s34.blu0.hotmail.com ([65.55.116.109])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <serres@live.ca>) id 1SwJgu-0000eZ-7w
	for lttng-dev@lists.lttng.org; Tue, 31 Jul 2012 17:09:20 -0400
In-Reply-To: <50182739.3030604@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: david.goulet@polymtl.ca, danny.serres@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0329447577==
Content-Type: multipart/alternative;
	boundary="_bcc428a7-6e0a-442d-90c4-5194ad73a6e7_"

--_bcc428a7-6e0a-442d-90c4-5194ad73a6e7_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




> Date: Tue=2C 31 Jul 2012 14:43:05 -0400
> From: david.goulet@polymtl.ca
> To: danny.serres@efficios.com
> CC: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] [lttng-tools PATCH] lttng-tools python module
>=20
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Hi Danny=2C
>=20
> Sorry for the delay!
>=20
> First=2C thanks for this great work. I have a couple of "requests" before=
 I put
> all that upstream.
>=20
> Can you add the generated files into .gitignore please. I get this:
>=20
> #	src/python/lttng.i
> #	src/python/lttng.py
> #	src/python/lttng_wrap.c
>=20
> There is also forgotten whitespaces in src/python/lttng.i.in (first carac=
.)
>=20
> +               char *__repr__() {
> (times 5)

Fixed

>=20
> Apart from those minor issues=2C I have two questions about this patch. F=
irst=2C
> why is the python module in src/ and not in extras/ ? I consider src/ to =
be
> supported and stable code shipped with the installation and/or in package=
s.
> Also=2C the src/ directory is the core code of lttng-tools and this modul=
e is
> more an extra useful tool.
>=20
> Second=2C _IF_ this goes into src/=2C please move the tests to the tests/
> directory else we are going to make it self contained in extras/ which is=
 good
> right now.
>=20

From what I've seen so far=2C other projects all have a top python dir whic=
h includes
the Python-related file.  I'll wait on approval on doing this before postin=
g a new version.

> Last thing=2C could it be possible to have a small how-to/tutorial in the=
 doc/
> directory so people know that this exist and how to install it and use it=
 ?
> (Also add it to the README in PACKAGE CONTENTS). A swig2 dependency will =
be
> added with this module so this howto should mention that this depends on =
that
> software. (swig2.0 package on Debian/Ubuntu).
>=20
Done

Thanks
Danny

> I might be wrong on some point so don't hesitate to argue and comment! :)
>=20
> Cheers!
> David
>=20
> On 26/07/12 02:09 PM=2C Danny Serres wrote:
> > The lttng-tools Python module can be used to directly control the
> > lttng-tools API inside Python=2C using 'import lttng'.
> >=20
> > Therefore=2C it becomes possible to create a trace=2C add events=2C sta=
rt/stop
> > tracing=2C destroy a session and so on from within Python.
> >=20
> > The module does not include URI-related functions.
> >=20
> > SWIG >=3D 2.0 is used to create the wrapper and its 'warning md variabl=
e
> > unused' bug is patched in Makefile.am.
> >=20
> > In the interface file=2C struct and enum are directly copied from lttng=
.h
> > (all changes must be made in both files).
> >=20
> > Signed-off-by: Danny Serres <danny.serres@efficios.com> Signed-off-by:
> > Yannick Brosseau <yannick.brosseau@gmail.com> --- config/ax_pkg_swig.m4
> > |  135 ++++++ configure.ac                |   43 ++ src/Makefile.am
> > |    4 + src/python/Makefile.am      |   25 ++ src/python/lttng.i.in
> > | 1023 +++++++++++++++++++++++++++++++++++++++++++=20
> > src/python/tests/example.py |  109 +++++ src/python/tests/run.sh     | =
   1
> > + src/python/tests/tests.py   |  310 +++++++++++++ 8 files changed=2C 1=
650
> > insertions(+) create mode 100644 config/ax_pkg_swig.m4 create mode 1006=
44
> > src/python/Makefile.am create mode 100644 src/python/lttng.i.in create =
mode
> > 100644 src/python/tests/example.py create mode 100644
> > src/python/tests/run.sh create mode 100644 src/python/tests/tests.py
> >=20
> > diff --git a/config/ax_pkg_swig.m4 b/config/ax_pkg_swig.m4 new file mod=
e
> > 100644 index 0000000..e112f3d --- /dev/null +++ b/config/ax_pkg_swig.m4=
 @@
> > -0=2C0 +1=2C135 @@ +#
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >
> >=20
> +#        http://www.gnu.org/software/autoconf-archive/ax_pkg_swig.html
> > +#
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >
> >=20
> +#
> > +# SYNOPSIS +# +#   AX_PKG_SWIG([major.minor.micro]=2C [action-if-found=
]=2C
> > [action-if-not-found]) +# +# DESCRIPTION +# +#   This macro searches fo=
r a
> > SWIG installation on your system. If found=2C +#   then SWIG is AC_SUBS=
T'd=3B
> > if not found=2C then $SWIG is empty.  If SWIG is +#   found=2C then SWI=
G_LIB is
> > set to the SWIG library path=2C and AC_SUBST'd. +# +#   You can use the
> > optional first argument to check if the version of the +#   available S=
WIG
> > is greater than or equal to the value of the argument. It +#   should h=
ave
> > the format: N[.N[.N]] (N is a number between 0 and 999. Only +#   the f=
irst
> > N is mandatory.) If the version argument is given (e.g. +#   1.3.17)=2C
> > AX_PKG_SWIG checks that the swig package is this version number +#   or
> > higher. +# +#   As usual=2C action-if-found is executed if SWIG is foun=
d=2C
> > otherwise +#   action-if-not-found is executed. +# +#   In configure.in=
=2C
> > use as: +# +#     AX_PKG_SWIG(1.3.17=2C []=2C [ AC_MSG_ERROR([SWIG is r=
equired
> > to build..]) ]) +#     AX_SWIG_ENABLE_CXX +#
> > AX_SWIG_MULTI_MODULE_SUPPORT +#     AX_SWIG_PYTHON +# +# LICENSE +# +#
> > Copyright (c) 2008 Sebastian Huber <sebastian-huber@web.de> +#   Copyri=
ght
> > (c) 2008 Alan W. Irwin <irwin@beluga.phys.uvic.ca> +#   Copyright (c) 2=
008
> > Rafael Laboissiere <rafael@laboissiere.net> +#   Copyright (c) 2008 And=
rew
> > Collier <colliera@ukzn.ac.za> +#   Copyright (c) 2011 Murray Cumming
> > <murrayc@openismus.com> +# +#   This program is free software=3B you ca=
n
> > redistribute it and/or modify it +#   under the terms of the GNU Genera=
l
> > Public License as published by the +#   Free Software Foundation=3B eit=
her
> > version 2 of the License=2C or (at your +#   option) any later version.=
 +# +#
> > This program is distributed in the hope that it will be useful=2C but +=
#
> > WITHOUT ANY WARRANTY=3B without even the implied warranty of +#
> > MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Genera=
l +#
> > Public License for more details. +# +#   You should have received a cop=
y of
> > the GNU General Public License along +#   with this program. If not=2C =
see
> > <http://www.gnu.org/licenses/>. +# +#   As a special exception=2C the
> > respective Autoconf Macro's copyright owner +#   gives unlimited permis=
sion
> > to copy=2C distribute and modify the configure +#   scripts that are th=
e
> > output of Autoconf when processing the Macro. You +#   need not follow =
the
> > terms of the GNU General Public License when using +#   or distributing
> > such scripts=2C even though portions of the text of the +#   Macro appe=
ar in
> > them. The GNU General Public License (GPL) does govern +#   all other u=
se
> > of the material that constitutes the Autoconf Macro. +# +#   This speci=
al
> > exception to the GPL applies to versions of the Autoconf +#   Macro
> > released by the Autoconf Archive. When you make and distribute a +#
> > modified version of the Autoconf Macro=2C you may extend this special +=
#
> > exception to the GPL to apply to your modified version as well. + +#ser=
ial
> > 8 + +AC_DEFUN([AX_PKG_SWIG]=2C[ +        # Ubuntu has swig 2.0 as
> > /usr/bin/swig2.0 +        AC_PATH_PROGS([SWIG]=2C[swig swig2.0]) +     =
   if
> > test -z "$SWIG" =3B then +                m4_ifval([$3]=2C[$3]=2C[:]) +
> > elif test -n "$1" =3B then +                AC_MSG_CHECKING([SWIG versi=
on]) +
> > [swig_version=3D`$SWIG -version 2>&1 | grep 'SWIG Version' | sed
> > 's/.*\([0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\).*/\1/g'`] +
> > AC_MSG_RESULT([$swig_version]) +                if test -n "$swig_versi=
on"
> > =3B then +                        # Calculate the required version numb=
er
> > components +                        [required=3D$1] +
> > [required_major=3D`echo $required | sed 's/[^0-9].*//'`] +
> > if test -z "$required_major" =3B then +
> > [required_major=3D0] +                        fi +
> > [required=3D`echo $required | sed 's/[0-9]*[^0-9]//'`] +
> > [required_minor=3D`echo $required | sed 's/[^0-9].*//'`] +
> > if test -z "$required_minor" =3B then +
> > [required_minor=3D0] +                        fi +
> > [required=3D`echo $required | sed 's/[0-9]*[^0-9]//'`] +
> > [required_patch=3D`echo $required | sed 's/[^0-9].*//'`] +
> > if test -z "$required_patch" =3B then +
> > [required_patch=3D0] +                        fi +                     =
   #
> > Calculate the available version number components +
> > [available=3D$swig_version] +                        [available_major=
=3D`echo
> > $available | sed 's/[^0-9].*//'`] +                        if test -z
> > "$available_major" =3B then +
> > [available_major=3D0] +                        fi +
> > [available=3D`echo $available | sed 's/[0-9]*[^0-9]//'`] +
> > [available_minor=3D`echo $available | sed 's/[^0-9].*//'`] +
> > if test -z "$available_minor" =3B then +
> > [available_minor=3D0] +                        fi +
> > [available=3D`echo $available | sed 's/[0-9]*[^0-9]//'`] +
> > [available_patch=3D`echo $available | sed 's/[^0-9].*//'`] +
> > if test -z "$available_patch" =3B then +
> > [available_patch=3D0] +                        fi +                    =
    #
> > Convert the version tuple into a single number for easier comparison. +
> > # Using base 100 should be safe since SWIG internally uses BCD values +
> > # to encode its version number. +
> > required_swig_vernum=3D`expr $required_major \* 10000 \ +
> > \+ $required_minor \* 100 \+ $required_patch` +
> > available_swig_vernum=3D`expr $available_major \* 10000 \ +
> > \+ $available_minor \* 100 \+ $available_patch` + +
> > if test $available_swig_vernum -lt $required_swig_vernum=3B then +
> > AC_MSG_WARN([SWIG version >=3D $1 is required.  You have $swig_version.=
]) +
> > SWIG=3D'' +                                m4_ifval([$3]=2C[$3]=2C[]) +
> > else +                                AC_MSG_CHECKING([for SWIG library=
]) +
> > SWIG_LIB=3D`$SWIG -swiglib` +
> > AC_MSG_RESULT([$SWIG_LIB]) +
> > m4_ifval([$2]=2C[$2]=2C[]) +                        fi +               =
 else +
> > AC_MSG_WARN([cannot determine SWIG version]) +
> > SWIG=3D'' +                        m4_ifval([$3]=2C[$3]=2C[]) +
> > fi +        fi +        AC_SUBST([SWIG_LIB]) +]) diff --git a/configure=
.ac
> > b/configure.ac index 17e6b67..97167de 100644 --- a/configure.ac +++
> > b/configure.ac @@ -154=2C6 +154=2C40 @@ AC_CHECK_LIB([c]=2C [open_memst=
ream]=2C ]=20
> > )
> >=20
> > +# For Python +# SWIG version needed or newer: +swig_version=3D2.0.0 +=
=20
> > +AC_ARG_ENABLE([python]=2C +
> > [AC_HELP_STRING([--disable-python]=2C +                              [d=
o not
> > compile Python bindings])]=2C +              []=2C [enable_python=3Dyes=
]) +=20
> > +AM_CONDITIONAL([USE_PYTHON]=2C [test "x${enable_python:-yes}" =3D xyes=
]) + +if
> > test "x${enable_python:-yes}" =3D xyes=3B then +  AC_MSG_NOTICE([You ma=
y
> > configure with --disable-python ]dnl +[if you do not need Python
> > bindings.]) + +  AX_PKG_SWIG($swig_version=2C []=2C [ AC_MSG_ERROR([SWI=
G
> > $swig_version or newer is needed]) ]) +  AM_PATH_PYTHON + +
> > AC_ARG_VAR([PYTHON_INCLUDE]=2C [Include flags for python=2C bypassing
> > python-config]) +  AC_ARG_VAR([PYTHON_CONFIG]=2C [Path to python-config=
]) +
> > AS_IF([test -z "$PYTHON_INCLUDE"]=2C [ +    AS_IF([test -z "$PYTHON_CON=
FIG"]=2C
> > [ +      AC_PATH_PROGS([PYTHON_CONFIG]=2C +
> > [python$PYTHON_VERSION-config python-config]=2C +                    [n=
o]=2C +
> > [`dirname $PYTHON`]) +      AS_IF([test "$PYTHON_CONFIG" =3D no]=2C
> > [AC_MSG_ERROR([cannot find python-config for $PYTHON.])]) +    ]) +
> > AC_MSG_CHECKING([python include flags]) +    PYTHON_INCLUDE=3D`$PYTHON_=
CONFIG
> > --includes` +    AC_MSG_RESULT([$PYTHON_INCLUDE]) +  ]) +fi + # Option =
to
> > only build the consumer daemon and its libraries=20
> > AC_ARG_WITH([consumerd-only]=2C AS_HELP_STRING([--with-consumerd-only]=
=2C[Only
> > build the consumer daemon [default=3Dno]])=2C @@ -214=2C6 +248=2C7 @@
> > AC_CONFIG_FILES([ src/bin/lttng-sessiond/Makefile=20
> > src/bin/lttng-relayd/Makefile src/bin/lttng/Makefile +	src/python/Makef=
ile=20
> > tests/Makefile tests/kernel/Makefile tests/tools/Makefile @@ -260=2C6 +=
295=2C14
> > @@ AS_IF([test "x$lttng_ust_support" =3D "xyes"]=2C[ AS_ECHO("Disabled"=
) ])
> >=20
> > +#Python binding enabled/disabled +AS_ECHO_N("Python binding: ")=20
> > +AS_IF([test "x${enable_python:-yes}" =3D xyes]=2C [ +	AS_ECHO("Enabled=
") +]=2C[=20
> > +	AS_ECHO("Disabled") +]) + # Do we build only the consumerd=2C or
> > everything AS_IF([test "x$consumerd_only" =3D "xyes"]=2C[ AS_ECHO("Only=
 the
> > consumerd daemon will be built.") diff --git a/src/Makefile.am
> > b/src/Makefile.am index 103337c..a65a5c1 100644 --- a/src/Makefile.am +=
++
> > b/src/Makefile.am @@ -1 +1=2C5 @@ SUBDIRS =3D common lib bin + +if USE_=
PYTHON=20
> > +SUBDIRS +=3D python +endif diff --git a/src/python/Makefile.am
> > b/src/python/Makefile.am new file mode 100644 index 0000000..b67d550 --=
-
> > /dev/null +++ b/src/python/Makefile.am @@ -0=2C0 +1=2C25 @@ +lttng.i:
> > lttng.i.in +	sed "s/LTTNG_VERSION_STR/LTTng $(PACKAGE_VERSION)/g"
> > <lttng.i.in >lttng.i + +AM_CFLAGS =3D -I$(PYTHONINC) -I../lib/lttng-ctl
> > -I../common \ +	      $(BUDDY_CFLAGS) + +EXTRA_DIST =3D lttng.i=20
> > +python_PYTHON =3D lttng.py +pyexec_LTLIBRARIES =3D _lttng.la +=20
> > +MAINTAINERCLEANFILES =3D lttng_wrap.c lttng.py + +_lttng_la_SOURCES =
=3D
> > lttng_wrap.c + +_lttng_la_LDFLAGS =3D -module + +_lttng_la_LIBADD =3D
> > ../lib/lttng-ctl/liblttng-ctl.la 		\ +
> > ../common/sessiond-comm/libsessiond-comm.la + +lttng_wrap.c: lttng.i +
> > $(SWIG) -python -I. -I$(top_srcdir)/src/common/sessiond-comm lttng.i +	=
sed
> > -i "s/Python.h/python$(PYTHON_VERSION)\/Python.h/g" lttng_wrap.c +	sed =
-i
> > "s/PyObject \*m=2C \*d=2C \*md=3B/PyObject \*m=2C \*d=3B\n#if
> > defined(SWIGPYTHON_BUILTIN)\nPyObject *md=3B\n#endif/g" lttng_wrap.c +	=
sed -i
> > "s/md =3D d/d/g" lttng_wrap.c +	sed -i
> > "s/(void)public_symbol=3B/(void)public_symbol=3B\n  md =3D d=3B/g" lttn=
g_wrap.c=20
> > diff --git a/src/python/lttng.i.in b/src/python/lttng.i.in new file mod=
e
> > 100644 index 0000000..4f3cfeb --- /dev/null +++ b/src/python/lttng.i.in=
 @@
> > -0=2C0 +1=2C1023 @@ +%define DOCSTRING +"LTTNG_VERSION_STR + +The  LTTn=
g
> > project  aims at providing highly efficient tracing tools for Linux. +I=
t's
> > tracers help tracking down performance issues and debugging problems
> > involving +multiple concurrent processes and threads. Tracing across
> > multiple systems is also possible." +%enddef +=20
> > +%module(docstring=3DDOCSTRING) lttng + +%include "typemaps.i" +%includ=
e
> > "pyabc.i" +%{ +#define SWIG_FILE_WITH_INIT +#include <lttng/lttng.h> +%=
} +=20
> > +typedef unsigned int uint32_t=3B +typedef int int32_t=3B +typedef unsi=
gned
> > long long uint64_t=3B +typedef long pid_t=3B + + +//
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D +//		ENU=
MS +//
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D + +%rena=
me("DOMAIN_KERNEL")
> > LTTNG_DOMAIN_KERNEL=3B +%rename("DOMAIN_UST") LTTNG_DOMAIN_UST=3B +enum
> > lttng_domain_type { +	LTTNG_DOMAIN_KERNEL                   =3D 1=2C +
> > LTTNG_DOMAIN_UST                      =3D 2=2C +}=3B + +%rename("EVENT_=
ALL")
> > LTTNG_EVENT_ALL=3B +%rename("EVENT_TRACEPOINT") LTTNG_EVENT_TRACEPOINT=
=3B=20
> > +%rename("EVENT_PROBE") LTTNG_EVENT_PROBE=3B=20
> > +%rename("EVENT_FUNCTION")LTTNG_EVENT_FUNCTION=3B=20
> > +%rename("EVENT_FUNCTION_ENTRY") LTTNG_EVENT_FUNCTION_ENTRY=3B=20
> > +%rename("EVENT_NOOP") LTTNG_EVENT_NOOP=3B +%rename("EVENT_SYSCALL")
> > LTTNG_EVENT_SYSCALL=3B +enum lttng_event_type { +	LTTNG_EVENT_ALL
> > =3D -1=2C +	LTTNG_EVENT_TRACEPOINT                =3D 0=2C +	LTTNG_EVEN=
T_PROBE
> > =3D 1=2C +	LTTNG_EVENT_FUNCTION                  =3D 2=2C +
> > LTTNG_EVENT_FUNCTION_ENTRY            =3D 3=2C +	LTTNG_EVENT_NOOP
> > =3D 4=2C +	LTTNG_EVENT_SYSCALL                   =3D 5=2C +}=3B +=20
> > +%rename("EVENT_LOGLEVEL_ALL") LTTNG_EVENT_LOGLEVEL_ALL=3B=20
> > +%rename("EVENT_LOGLEVEL_RANGE") LTTNG_EVENT_LOGLEVEL_RANGE=3B=20
> > +%rename("EVENT_LOGLEVEL_SINGLE") LTTNG_EVENT_LOGLEVEL_SINGLE=3B +enum
> > lttng_loglevel_type { +	LTTNG_EVENT_LOGLEVEL_ALL              =3D 0=2C =
+
> > LTTNG_EVENT_LOGLEVEL_RANGE            =3D 1=2C +	LTTNG_EVENT_LOGLEVEL_S=
INGLE
> > =3D 2=2C +}=3B + +%rename("LOGLEVEL_EMERG") LTTNG_LOGLEVEL_EMERG=3B=20
> > +%rename("LOGLEVEL_ALERT") LTTNG_LOGLEVEL_ALERT=3B +%rename("LOGLEVEL_C=
RIT")
> > LTTNG_LOGLEVEL_CRIT=3B +%rename("LOGLEVEL_ERR") LTTNG_LOGLEVEL_ERR=3B=20
> > +%rename("LOGLEVEL_WARNING") LTTNG_LOGLEVEL_WARNING=3B=20
> > +%rename("LOGLEVEL_NOTICE") LTTNG_LOGLEVEL_NOTICE=3B=20
> > +%rename("LOGLEVEL_INFO") LTTNG_LOGLEVEL_INFO=3B=20
> > +%rename("LOGLEVEL_DEBUG_SYSTEM") LTTNG_LOGLEVEL_DEBUG_SYSTEM=3B=20
> > +%rename("LOGLEVEL_DEBUG_PROGRAM") LTTNG_LOGLEVEL_DEBUG_PROGRAM=3B=20
> > +%rename("LOGLEVEL_DEBUG_PROCESS") LTTNG_LOGLEVEL_DEBUG_PROCESS=3B=20
> > +%rename("LOGLEVEL_DEBUG_MODULE") LTTNG_LOGLEVEL_DEBUG_MODULE=3B=20
> > +%rename("LOGLEVEL_DEBUG_UNIT") LTTNG_LOGLEVEL_DEBUG_UNIT=3B=20
> > +%rename("LOGLEVEL_DEBUG_FUNCTION") LTTNG_LOGLEVEL_DEBUG_FUNCTION=3B=20
> > +%rename("LOGLEVEL_DEBUG_LINE") LTTNG_LOGLEVEL_DEBUG_LINE=3B=20
> > +%rename("LOGLEVEL_DEBUG") LTTNG_LOGLEVEL_DEBUG=3B +enum lttng_loglevel=
 { +
> > LTTNG_LOGLEVEL_EMERG                  =3D 0=2C +        LTTNG_LOGLEVEL_=
ALERT
> > =3D 1=2C +        LTTNG_LOGLEVEL_CRIT                   =3D 2=2C +
> > LTTNG_LOGLEVEL_ERR                    =3D 3=2C +        LTTNG_LOGLEVEL_=
WARNING
> > =3D 4=2C +        LTTNG_LOGLEVEL_NOTICE                 =3D 5=2C +
> > LTTNG_LOGLEVEL_INFO                   =3D 6=2C +
> > LTTNG_LOGLEVEL_DEBUG_SYSTEM           =3D 7=2C +
> > LTTNG_LOGLEVEL_DEBUG_PROGRAM          =3D 8=2C +
> > LTTNG_LOGLEVEL_DEBUG_PROCESS          =3D 9=2C +
> > LTTNG_LOGLEVEL_DEBUG_MODULE           =3D 10=2C +
> > LTTNG_LOGLEVEL_DEBUG_UNIT             =3D 11=2C +
> > LTTNG_LOGLEVEL_DEBUG_FUNCTION         =3D 12=2C +
> > LTTNG_LOGLEVEL_DEBUG_LINE             =3D 13=2C +        LTTNG_LOGLEVEL=
_DEBUG
> > =3D 14=2C +}=3B + +%rename("EVENT_SPLICE") LTTNG_EVENT_SPLICE=3B=20
> > +%rename("EVENT_MMAP") LTTNG_EVENT_MMAP=3B +enum lttng_event_output { +
> > LTTNG_EVENT_SPLICE                    =3D 0=2C +	LTTNG_EVENT_MMAP
> > =3D 1=2C +}=3B + +%rename("EVENT_CONTEXT_PID") LTTNG_EVENT_CONTEXT_PID=
=3B=20
> > +%rename("EVENT_CONTEXT_PERF_COUNTER") LTTNG_EVENT_CONTEXT_PERF_COUNTER=
=3B=20
> > +%rename("EVENT_CONTEXT_PROCNAME") LTTNG_EVENT_CONTEXT_PROCNAME=3B=20
> > +%rename("EVENT_CONTEXT_PRIO") LTTNG_EVENT_CONTEXT_PRIO=3B=20
> > +%rename("EVENT_CONTEXT_NICE") LTTNG_EVENT_CONTEXT_NICE=3B=20
> > +%rename("EVENT_CONTEXT_VPID") LTTNG_EVENT_CONTEXT_VPID=3B=20
> > +%rename("EVENT_CONTEXT_TID") LTTNG_EVENT_CONTEXT_TID=3B=20
> > +%rename("EVENT_CONTEXT_VTID") LTTNG_EVENT_CONTEXT_VTID=3B=20
> > +%rename("EVENT_CONTEXT_PPID") LTTNG_EVENT_CONTEXT_PPID=3B=20
> > +%rename("EVENT_CONTEXT_VPPID") LTTNG_EVENT_CONTEXT_VPPID=3B=20
> > +%rename("EVENT_CONTEXT_PTHREAD_ID") LTTNG_EVENT_CONTEXT_PTHREAD_ID=3B =
+enum
> > lttng_event_context_type { +	LTTNG_EVENT_CONTEXT_PID               =3D =
0=2C +
> > LTTNG_EVENT_CONTEXT_PERF_COUNTER      =3D 1=2C +	LTTNG_EVENT_CONTEXT_PR=
OCNAME
> > =3D 2=2C +	LTTNG_EVENT_CONTEXT_PRIO              =3D 3=2C +
> > LTTNG_EVENT_CONTEXT_NICE              =3D 4=2C +	LTTNG_EVENT_CONTEXT_VP=
ID
> > =3D 5=2C +	LTTNG_EVENT_CONTEXT_TID               =3D 6=2C +
> > LTTNG_EVENT_CONTEXT_VTID              =3D 7=2C +	LTTNG_EVENT_CONTEXT_PP=
ID
> > =3D 8=2C +	LTTNG_EVENT_CONTEXT_VPPID             =3D 9=2C +
> > LTTNG_EVENT_CONTEXT_PTHREAD_ID        =3D 10=2C +}=3B +=20
> > +%rename("CALIBRATE_FUNCTION") LTTNG_CALIBRATE_FUNCTION=3B +enum
> > lttng_calibrate_type { +	LTTNG_CALIBRATE_FUNCTION              =3D 0=2C=
 +}=3B +=20
> > + + +// =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D +/=
/		TYPEMAPS +//
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D + +//lis=
t_sessions=20
> > +%typemap(argout) struct lttng_session **sessions{ + +	int l =3D
> > PyInt_AsSsize_t($result)=3B +	if (l >=3D 0) +	{ +		PyObject *sessions =
=3D
> > PyList_New(0)=3B +		int i=3B +		for(i=3D0=3B i<l=3B i++) +		{ +			PyObj=
ect *tmp =3D
> > PyTuple_New(4)=3B +			PyObject *name =3D PyString_FromString((*$1)[i].n=
ame)=3B +
> > PyObject *path =3D PyString_FromString((*$1)[i].path)=3B +			PyObject *=
enabled
> > =3D PyInt_FromSize_t((*$1)[i].enabled)=3B +			PyObject *padding =3D
> > PyString_FromString((*$1)[i].padding)=3B + +			PyTuple_SetItem(tmp=2C 0=
=2C
> > name)=3B +			PyTuple_SetItem(tmp=2C 1=2C path)=3B +			PyTuple_SetItem(t=
mp=2C 2=2C
> > enabled)=3B +			PyTuple_SetItem(tmp=2C 3=2C padding)=3B +			PyList_Appe=
nd(sessions=2C
> > tmp)=3B +		} +		$result =3D sessions=3B +	} +} +%typemap(in=2Cnuminputs=
=3D0) struct
> > lttng_session **sessions (struct lttng_session *temp){ +	$1=3D&temp=3B =
+} +=20
> > +//list_domains +%typemap(argout) struct lttng_domain **domains{ + +	in=
t l
> > =3D PyInt_AsSsize_t($result)=3B +	if (l >=3D 0) +	{ +		PyObject *dom =
=3D
> > PyList_New(0)=3B +		int i=3B +		for(i=3D0=3B i<l=3B i++) +		{ +			PyObj=
ect *tmp =3D
> > PyTuple_New(5)=3B +			PyObject *type =3D PyInt_FromSize_t((*$1)[i].type=
)=3B +
> > PyObject *execname =3D PyString_FromString((*$1)[i].attr.exec_name)=3B =
+
> > PyObject *pid =3D PyInt_FromSize_t((*$1)[i].attr.pid)=3B +			PyObject *=
padding
> > =3D PyString_FromString((*$1)[i].padding)=3B +			PyObject *attrpadding =
=3D
> > PyString_FromString((*$1)[i].attr.padding)=3B + +			PyTuple_SetItem(tmp=
=2C 0=2C
> > type)=3B +			PyTuple_SetItem(tmp=2C 1=2C padding)=3B +			PyTuple_SetIte=
m(tmp=2C 2=2C
> > pid)=3B +			PyTuple_SetItem(tmp=2C 3=2C execname)=3B +			PyTuple_SetIte=
m(tmp=2C 4=2C
> > attrpadding)=3B +			PyList_Append(dom=2C tmp)=3B +		} +		$result =3D do=
m=3B +	} +}=20
> > +%typemap(in=2Cnuminputs=3D0) struct lttng_domain **domains (struct
> > lttng_domain *temp){ +	$1=3D&temp=3B +} + +//list_channels +%typemap(ar=
gout)
> > struct lttng_channel **channels{ + +	int l =3D PyInt_AsSsize_t($result)=
=3B +	if
> > (l >=3D 0) +	{ +		PyObject *chan =3D PyList_New(0)=3B +		int i=3B +		fo=
r(i=3D0=3B i<l=3B
> > i++) +		{ +			PyObject *tmp =3D PyTuple_New(4)=3B +			PyObject *name =
=3D
> > PyString_FromString((*$1)[i].name)=3B +			PyObject *enabled =3D
> > PyInt_FromSize_t((*$1)[i].enabled)=3B +			PyObject *padding =3D
> > PyString_FromString((*$1)[i].padding)=3B + +			PyObject *attrtmp =3D
> > PyTuple_New(7)=3B +			PyObject *overwrite =3D
> > PyInt_FromLong((*$1)[i].attr.overwrite)=3B +			PyObject *subbuf =3D
> > PyInt_FromSize_t((*$1)[i].attr.subbuf_size)=3B +			PyObject *num =3D
> > PyInt_FromSize_t((*$1)[i].attr.num_subbuf)=3B +			PyObject *switchtimer=
 =3D
> > PyInt_FromSize_t((*$1)[i].attr.switch_timer_interval)=3B +			PyObject
> > *readtimer =3D PyInt_FromSize_t((*$1)[i].attr.read_timer_interval)=3B +
> > PyObject *output =3D PyInt_FromSize_t((*$1)[i].attr.output)=3B +			PyOb=
ject
> > *attrpad =3D PyString_FromString((*$1)[i].attr.padding)=3B + +
> > PyTuple_SetItem(attrtmp=2C 0=2C overwrite)=3B +			PyTuple_SetItem(attrt=
mp=2C 1=2C
> > subbuf)=3B +			PyTuple_SetItem(attrtmp=2C 2=2C num)=3B +			PyTuple_SetI=
tem(attrtmp=2C
> > 3=2C switchtimer)=3B +			PyTuple_SetItem(attrtmp=2C 4=2C readtimer)=3B =
+
> > PyTuple_SetItem(attrtmp=2C 5=2C output)=3B +			PyTuple_SetItem(attrtmp=
=2C 6=2C
> > attrpad)=3B + +			PyTuple_SetItem(tmp=2C 0=2C name)=3B +			PyTuple_SetI=
tem(tmp=2C 1=2C
> > enabled)=3B +			PyTuple_SetItem(tmp=2C 2=2C padding)=3B +			PyTuple_Set=
Item(tmp=2C 3=2C
> > attrtmp)=3B +			PyList_Append(chan=2C tmp)=3B +		} +		$result =3D chan=
=3B +	} +}=20
> > +%typemap(in=2Cnuminputs=3D0) struct lttng_channel **channels (struct
> > lttng_channel *temp){ +	$1=3D&temp=3B +} + +//list_events & list_tracep=
oints=20
> > +%typemap(argout) struct lttng_event **events{ + +	int l =3D
> > PyInt_AsSsize_t($result)=3B +	if (l >=3D 0) +	{ +		PyObject *events =3D
> > PyList_New(0)=3B +		int i=3B +		for(i=3D0=3B i<l=3B i++) +		{ +			PyObj=
ect *tmp =3D
> > PyTuple_New(10)=3B +			PyObject *name =3D PyString_FromString((*$1)[i].=
name)=3B +
> > PyObject *type =3D PyInt_FromSize_t((*$1)[i].type)=3B +			PyObject
> > *logleveltype =3D PyInt_FromSize_t((*$1)[i].loglevel_type)=3B +			PyObj=
ect
> > *loglevel =3D PyInt_FromLong((*$1)[i].loglevel)=3B +			PyObject *enable=
d =3D
> > PyInt_FromLong((*$1)[i].enabled)=3B +			PyObject *pid =3D
> > PyInt_FromSize_t((*$1)[i].pid)=3B +			PyObject *padding =3D
> > PyString_FromString((*$1)[i].padding)=3B +			PyObject *attrpadding =3D
> > PyString_FromString((*$1)[i].attr.padding)=3B + +			PyObject *probe =3D
> > PyTuple_New(4)=3B +			PyObject *addr =3D
> > PyInt_FromSize_t((*$1)[i].attr.probe.addr)=3B +			PyObject *offset =3D
> > PyInt_FromSize_t((*$1)[i].attr.probe.offset)=3B +			PyObject *symbolnam=
e =3D
> > PyString_FromString((*$1)[i].attr.probe.symbol_name)=3B +			PyObject
> > *probepad =3D PyString_FromString((*$1)[i].attr.probe.padding)=3B + +
> > PyObject *function =3D PyTuple_New(2)=3B +			PyObject *f_symbolname =3D
> > PyString_FromString((*$1)[i].attr.ftrace.symbol_name)=3B +			PyObject *=
f_pad
> > =3D PyString_FromString((*$1)[i].attr.ftrace.padding)=3B + +
> > PyTuple_SetItem(function=2C 0=2C f_symbolname)=3B +			PyTuple_SetItem(f=
unction=2C
> > 1=2C f_pad)=3B + +			PyTuple_SetItem(probe=2C 0=2C addr)=3B +
> > PyTuple_SetItem(probe=2C 1=2C offset)=3B +			PyTuple_SetItem(probe=2C 2=
=2C
> > symbolname)=3B +			PyTuple_SetItem(probe=2C 3=2C probepad)=3B + +
> > PyTuple_SetItem(tmp=2C 0=2C name)=3B +			PyTuple_SetItem(tmp=2C 1=2C ty=
pe)=3B +
> > PyTuple_SetItem(tmp=2C 2=2C logleveltype)=3B +			PyTuple_SetItem(tmp=2C=
 3=2C
> > loglevel)=3B +			PyTuple_SetItem(tmp=2C 4=2C enabled)=3B +			PyTuple_Se=
tItem(tmp=2C
> > 5=2C pid)=3B +			PyTuple_SetItem(tmp=2C 6=2C padding)=3B +			PyTuple_Se=
tItem(tmp=2C 7=2C
> > probe)=3B +			PyTuple_SetItem(tmp=2C 8=2C function)=3B +			PyTuple_SetI=
tem(tmp=2C 9=2C
> > attrpadding)=3B +			PyList_Append(events=2C tmp)=3B +		} +		$result =3D=
 events=3B +
> > } +} +%typemap(in=2Cnuminputs=3D0) struct lttng_event **events (struct
> > lttng_event *temp){ +	$1=3D&temp=3B +} + + + +//
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D +//		FUN=
CTIONS +//
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D + +%rena=
me("create")
> > lttng_create_session(const char *name=2C const char *path)=3B=20
> > +%rename("destroy") lttng_destroy_session(const char *name)=3B=20
> > +%rename("_lttng_create_handle") lttng_create_handle(const char
> > *session_name=2C struct lttng_domain *domain)=3B=20
> > +%rename("_lttng_destroy_handle") lttng_destroy_handle(struct lttng_han=
dle
> > *handle)=3B +%rename("_lttng_list_sessions") lttng_list_sessions(struct
> > lttng_session **sessions)=3B +%rename("_lttng_list_domains")
> > lttng_list_domains(const char *session_name=2C struct lttng_domain
> > **domains)=3B +%rename("_lttng_list_channels") lttng_list_channels(stru=
ct
> > lttng_handle *handle=2Cstruct lttng_channel **channels)=3B=20
> > +%rename("_lttng_list_events") lttng_list_events(struct lttng_handle
> > *handle=2C const char *channel_name=2C struct lttng_event **events)=3B=
=20
> > +%rename("_lttng_list_tracepoints") lttng_list_tracepoints(struct
> > lttng_handle *handle=2C struct lttng_event **events)=3B=20
> > +%rename("session_daemon_alive") lttng_session_daemon_alive(void)=3B=20
> > +%rename("set_tracing_group") lttng_set_tracing_group(const char *name)=
=3B=20
> > +%rename("strerror") lttng_strerror(int code)=3B=20
> > +%rename("_lttng_register_consumer") lttng_register_consumer(struct
> > lttng_handle *handle=2C const char *socket_path)=3B +%rename("start")
> > lttng_start_tracing(const char *session_name)=3B +%rename("stop")
> > lttng_stop_tracing(const char *session_name)=3B=20
> > +%rename("_lttng_add_context") lttng_add_context(struct lttng_handle
> > *handle=2C struct lttng_event_context *ctx=2C const char *event_name=2C=
 const
> > char *channel_name)=3B +%rename("_lttng_enable_event")
> > lttng_enable_event(struct lttng_handle *handle=2C	struct lttng_event *e=
v=2C
> > const char *channel_name)=3B +%rename("_lttng_enable_channel")
> > lttng_enable_channel(struct lttng_handle *handle=2C struct lttng_channe=
l
> > *chan)=3B +%rename("_lttng_disable_event") lttng_disable_event(struct
> > lttng_handle *handle=2C const char *name=2C const char *channel_name)=
=3B=20
> > +%rename("_lttng_disable_channel") lttng_disable_channel(struct
> > lttng_handle *handle=2C const char *name)=3B +%rename("_lttng_calibrate=
")
> > lttng_calibrate(struct lttng_handle *handle=2C struct lttng_calibrate
> > *calibrate)=3B +%rename("channel_set_default_attr")
> > lttng_channel_set_default_attr(struct lttng_domain *domain=2C struct
> > lttng_channel_attr *attr)=3B + +//Redefined functions +struct lttng_han=
dle
> > *lttng_create_handle(const char *session_name=2C +		struct lttng_domain
> > *domain)=3B +void lttng_destroy_handle(struct lttng_handle *handle)=3B =
+int
> > lttng_list_channels(struct lttng_handle *handle=2Cstruct lttng_channel
> > **channels)=3B +int lttng_list_events(struct lttng_handle *handle=2C +	=
	const
> > char *channel_name=2C struct lttng_event **events)=3B +int
> > lttng_list_tracepoints(struct lttng_handle *handle=2C struct lttng_even=
t
> > **events)=3B +int lttng_add_context(struct lttng_handle *handle=2C stru=
ct
> > lttng_event_context *ctx=2C +		const char *event_name=2C	const char
> > *channel_name)=3B +int lttng_enable_event(struct lttng_handle *handle=
=2C +
> > struct lttng_event *ev=2C const char *channel_name)=3B +int
> > lttng_enable_channel(struct lttng_handle *handle=2C struct lttng_channe=
l
> > *chan)=3B +int lttng_disable_event(struct lttng_handle *handle=2C +		co=
nst char
> > *name=2C const char *channel_name)=3B +int lttng_disable_channel(struct
> > lttng_handle *handle=2C const char *name)=3B +int lttng_calibrate(struc=
t
> > lttng_handle *handle=2C struct lttng_calibrate *calibrate)=3B +int
> > lttng_register_consumer(struct lttng_handle *handle=2C const char
> > *socket_path)=3B +int lttng_list_sessions(struct lttng_session **sessio=
ns)=3B=20
> > +int lttng_list_domains(const char *session_name=2C struct lttng_domain
> > **domains)=3B + +//Functions not needing redefinition=20
> > +%feature("docstring")"create(str name=2C str path) -> int + +Create a =
new
> > tracing session using name and path. +Returns size of returned session
> > payload data or a negative error code." +int lttng_create_session(const
> > char *name=2C const char *path)=3B + + +%feature("docstring")"destroy(s=
tr name)
> > -> int + +Tear down tracing session using name. +Returns size of return=
ed
> > session payload data or a negative error code." +int
> > lttng_destroy_session(const char *name)=3B + +=20
> > +%feature("docstring")"session_daemon_alive() -> int + +Check if sessio=
n
> > daemon is alive. +Return 1 if alive or 0 if not. +On error returns a
> > negative value." +int lttng_session_daemon_alive(void)=3B + +=20
> > +%feature("docstring")"set_tracing_group(str name) -> int + +Sets the
> > tracing_group variable with name. +This function allocates memory point=
ed
> > to by tracing_group. +On success=2C returns 0=2C on error=2C returns -1=
 (null
> > name) or -ENOMEM." +int lttng_set_tracing_group(const char *name)=3B + =
+=20
> > +%feature("docstring")"strerror(int code) -> char + +Returns a human
> > readable string describing +the error code (a negative value)." +const =
char
> > *lttng_strerror(int code)=3B + + +%feature("docstring")"start(str
> > session_name) -> int + +Start tracing for all traces of the session.=20
> > +Returns size of returned session payload data or a negative error code=
."=20
> > +int lttng_start_tracing(const char *session_name)=3B + +=20
> > +%feature("docstring")"stop(str session_name) -> int + +Stop tracing fo=
r
> > all traces of the session. +Returns size of returned session payload da=
ta
> > or a negative error code." +int lttng_stop_tracing(const char
> > *session_name)=3B + + +%feature("docstring")"channel_set_default_attr(D=
omain
> > domain=2C ChannelAttr attr) + +Set default channel attributes. +If eith=
er or
> > both of the arguments are null=2C attr content is zeroe'd." +void
> > lttng_channel_set_default_attr(struct lttng_domain *domain=2C struct
> > lttng_channel_attr *attr)=3B + + +//
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D +//	Pyth=
on redefinition of
> > some functions +//	(List and Handle-related) +//
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D + +%feat=
ure("docstring")""=20
> > +%pythoncode %{ + +def list_sessions(): +	""" +	list_sessions() -> dict=
 + +
> > Ask the session daemon for all available sessions. +	Returns a dict of
> > Session instances=2C the key is the name=3B +	on error=2C returns a neg=
ative
> > value. +	""" + +	ses_list =3D _lttng_list_sessions() +	if type(ses_list=
) is
> > int: +		return ses_list + +	sessions =3D {} + +	for ses_elements in
> > ses_list: +		ses =3D Session() +		ses.name =3D ses_elements[0] +		ses.p=
ath =3D
> > ses_elements[1] +		ses.enabled =3D ses_elements[2] +		ses.padding =3D
> > ses_elements[3] + +		sessions[ses.name] =3D ses + +	return sessions + +=
 +def
> > list_domains(session_name): +	""" +	list_domains(str session_name) -> l=
ist=20
> > + +	Ask the session daemon for all available domains of a session. +
> > Returns a list of Domain instances=3B +	on error=2C returns a negative =
value. +
> > """ + +	dom_list =3D _lttng_list_domains(session_name) +	if type(dom_li=
st) is
> > int: +		return dom_list + +	domains =3D [] + +	for dom_elements in dom_=
list:=20
> > +		dom =3D Domain() +		dom.type =3D dom_elements[0] +		dom.paddinf =3D
> > dom_elements[1] +		dom.attr.pid =3D dom_elements[2] +		dom.attr.exec_na=
me =3D
> > dom_elements[3] +		dom.attr.padding =3D dom_elements[4] + +
> > domains.append(dom) + +	return domains + + +def list_channels(handle): =
+
> > """ +	list_channels(Handle handle) -> dict + +	Ask the session daemon f=
or
> > all available channels of a session. +	Returns a dict of Channel instan=
ces=2C
> > the key is the name=3B +	on error=2C returns a negative value. +	""" + =
+	try: +
> > chan_list =3D _lttng_list_channels(handle._h) +	except AttributeError: =
+
> > raise TypeError("in method 'list_channels'=2C argument 1 must be a Hand=
le
> > instance") + +	if type(chan_list) is int: +		return chan_list + +	chann=
els
> > =3D {} + +	for channel_elements in chan_list: +		chan =3D Channel() +
> > chan.name =3D channel_elements[0] +		chan.enabled =3D channel_elements[=
1] +
> > chan.padding =3D channel_elements[2] +		chan.attr.overwrite =3D
> > channel_elements[3][0] +		chan.attr.subbuf_size =3D channel_elements[3]=
[1] +
> > chan.attr.num_subbuf =3D channel_elements[3][2] +
> > chan.attr.switch_timer_interval =3D channel_elements[3][3] +
> > chan.attr.read_timer_interval =3D channel_elements[3][4] +		chan.attr.o=
utput
> > =3D channel_elements[3][5] +		chan.attr.padding =3D channel_elements[3]=
[6] + +
> > channels[chan.name] =3D chan + +	return channels + + +def list_events(h=
andle=2C
> > channel_name): +	""" +	list_events(Handle handle=2C str channel_name) -=
>
> > dict + +	Ask the session daemon for all available events of a session
> > channel. +	Returns a dict of Event instances=2C the key is the name=3B =
+	on
> > error=2C returns a negative value. +	""" + +	try: +		ev_list =3D
> > _lttng_list_events(handle._h=2C channel_name) +	except AttributeError: =
+
> > raise TypeError("in method 'list_events'=2C argument 1 must be a Handle
> > instance") + +	if type(ev_list) is int: +		return ev_list + +	events =
=3D {}=20
> > + +	for ev_elements in ev_list: +		ev =3D Event() +		ev.name =3D
> > ev_elements[0] +		ev.type =3D ev_elements[1] +		ev.loglevel_type =3D
> > ev_elements[2] +		ev.loglevel =3D ev_elements[3] +		ev.enabled =3D
> > ev_elements[4] +		ev.pid =3D ev_elements[5] +		ev.attr.padding =3D
> > ev_elements[6] +		ev.attr.probe.addr =3D ev_elements[7][0] +
> > ev.attr.probe.offset =3D ev_elements[7][1] +		ev.attr.probe.symbol_name=
 =3D
> > ev_elements[7][2] +		ev.attr.probe.padding =3D ev_elements[7][3] +
> > ev.attr.ftrace.symbol_name =3D ev_elements[8][0] +		ev.attr.ftrace.padd=
ing =3D
> > ev_elements[8][1] +		ev.attr.padding =3D ev_elements[9] + +		events[ev.=
name]
> > =3D ev + +	return events + + +def list_tracepoints(handle): +	""" +
> > list_tracepoints(Handle handle) -> dict + +	Returns a dict of Event
> > instances=2C the key is the name=3B +	on error=2C returns a negative va=
lue. +
> > """ + +	try: +		ev_list =3D _lttng_list_tracepoints(handle._h) +	except
> > AttributeError: +		raise TypeError("in method 'list_tracepoints'=2C arg=
ument
> > 1 must be a Handle instance") + +	if type(ev_list) is int: +		return
> > ev_list + +	events =3D {} + +	for ev_elements in ev_list: +		ev =3D Eve=
nt() +
> > ev.name =3D ev_elements[0] +		ev.type =3D ev_elements[1] +		ev.loglevel=
_type =3D
> > ev_elements[2] +		ev.loglevel =3D ev_elements[3] +		ev.enabled =3D
> > ev_elements[4] +		ev.pid =3D ev_elements[5] +		ev.attr.padding =3D
> > ev_elements[6] +		ev.attr.probe.addr =3D ev_elements[7][0] +
> > ev.attr.probe.offset =3D ev_elements[7][1] +		ev.attr.probe.symbol_name=
 =3D
> > ev_elements[7][2] +		ev.attr.probe.padding =3D ev_elements[7][3] +
> > ev.attr.ftrace.symbol_name =3D ev_elements[8][0] +		ev.attr.ftrace.padd=
ing =3D
> > ev_elements[8][1] +		ev.attr.padding =3D ev_elements[9] + +		events[ev.=
name]
> > =3D ev + +	return events + + +def register_consumer(handle=2C socket_pa=
th): +
> > """ +	register_consumer(Handle handle=2C str socket_path) -> int + +	Re=
gister
> > an outside consumer. +	Returns size of returned session payload data or=
 a
> > negative error code. +	""" + +	try: +		return
> > _lttng_register_consumer(handle._h=2C socket_path) +	except AttributeEr=
ror: +
> > raise TypeError("in method 'register_consumer'=2C argument 1 must be a =
Handle
> > instance") + + +def add_context(handle=2C event_context=2C event_name=
=2C
> > channel_name): +	""" +	add_context(Handle handle=2C EventContext ctx=2C=
 +
> > str event_name=2C str channel_name) -> int + +	Add context to event and=
/or
> > channel. +	If event_name is None=2C the context is applied to all event=
s of
> > the channel. +	If channel_name is None=2C a lookup of the event's chann=
el is
> > done. +	If both are None=2C the context is applied to all events of all
> > channels. +	Returns the size of the returned payload data or a negative
> > error code. +	""" + +	try: +		return _lttng_add_context(handle._h=2C
> > event_context=2C event_name=2C channel_name) +	except AttributeError: +=
		raise
> > TypeError("in method 'add_context'=2C argument 1 must be a Handle insta=
nce")=20
> > + + +def enable_event(handle=2C event=2C channel_name): +	""" +
> > enable_event(Handle handle=2C Event event=2C +		    str channel_name) -=
> int +=20
> > +	Enable event(s) for a channel. +	If no event name is specified=2C all
> > events are enabled. +	If no channel name is specified=2C the default
> > 'channel0' is used. +	Returns size of returned session payload data or =
a
> > negative error code. +	""" + +	try: +		return
> > _lttng_enable_event(handle._h=2C event=2C channel_name) +	except
> > AttributeError: +		raise TypeError("in method 'enable_event'=2C argumen=
t 1
> > must be a Handle instance") + + +def enable_channel(handle=2C channel):=
 +
> > """ +	enable_channel(Handle handle=2C Channel channel -> int + +	Enable
> > channel per domain +	Returns size of returned session payload data or a
> > negative error code. +	""" + +	try: +		return
> > _lttng_enable_channel(handle._h=2C channel) +	except AttributeError: +	=
	raise
> > TypeError("in method 'enable_channel'=2C argument 1 must be a Handle
> > instance") + + +def disable_event(handle=2C name=2C channel_name): +	""=
" +
> > disable_event(Handle handle=2C str name=2C str channel_name) -> int + +=
	Disable
> > event(s) of a channel and domain. +	If no event name is specified=2C al=
l
> > events are disabled. +	If no channel name is specified=2C the default
> > 'channel0' is used. +	Returns size of returned session payload data or =
a
> > negative error code +	""" + +	try: +		return
> > _lttng_disable_event(handle._h=2C name=2C channel_name) +	except
> > AttributeError: +		raise TypeError("in method 'disable_event'=2C argume=
nt 1
> > must be a Handle instance") + + +def disable_channel(handle=2C name): +=
	""" +
> > disable_channel(Handle handle=2C str name) -> int + +	All tracing will =
be
> > stopped for registered events of the channel. +	Returns size of returne=
d
> > session payload data or a negative error code. +	""" + +	try: +		return
> > _lttng_disable_channel(handle._h=2C name) +	except AttributeError: +		r=
aise
> > TypeError("in method 'disable_channel'=2C argument 1 must be a Handle
> > instance") + + +def calibrate(handle=2C calibrate): +	""" +	calibrate(H=
andle
> > handle=2C Calibrate calibrate) -> int + +	Quantify LTTng overhead. +	Re=
turns
> > size of returned session payload data or a negative error code. +	""" +=
 +
> > try: +		return _lttng_calibrate(handle._h=2C calibrate) +	except
> > AttributeError: +		raise TypeError("in method 'calibrate'=2C argument 1=
 must
> > be a Handle instance") +%} + + +//
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D +//		Han=
dle class +//   Used
> > to prevent freeing unallocated memory +//
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D + +%feat=
ure("docstring")""=20
> > +%feature("autodoc"=2C "1")=3B + +%pythoncode %{ +class Handle: +      =
  """ +
> > Manages a handle. +	Takes two arguments: (str session_name=2C Domain do=
main)=20
> > +	""" + +	__frozen =3D False + +	def __init__(self=2C session_name=2C d=
omain): +
> > if type(session_name) is not str: +			raise TypeError("in method
> > '__init__'=2C argument 2 of type 'str'") +		if type(domain) is not Doma=
in and
> > domain is not None: +			raise TypeError("in method '__init__'=2C argume=
nt 3
> > of type 'lttng.Domain'") + +		self._sname =3D session_name +		if domain=
 is
> > None: +			self._domtype =3D None +		else: +			self._domtype =3D domain.=
type +
> > self._h =3D _lttng_create_handle(session_name=2C domain) +		self.__froz=
en =3D
> > True + +	def __del__(self): +		_lttng_destroy_handle(self._h) + +	def
> > __repr__(self): +		if self._domtype =3D=3D 1: +			domstr =3D "DOMAIN_KE=
RNEL" +
> > elif self._domtype =3D=3D 2: +			domstr =3D "DOMAIN_UST" +		else: +			d=
omstr =3D
> > self._domtype + +		return "lttng.Handle=3B session('{}')=2C
> > domain.type({})".format( +			self._sname=2C domstr) + +	def __setattr__=
(self=2C
> > attr=2C val): +		if self.__frozen: +			raise NotImplementedError("canno=
t
> > modify attributes") +		else: +			self.__dict__[attr] =3D val +%} + + +/=
/
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D +//		STR=
UCTURES +//
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D + +%rena=
me("Domain")
> > lttng_domain=3B +%rename("EventContext") lttng_event_context=3B=20
> > +%rename("Event") lttng_event=3B +%rename("Calibrate") lttng_calibrate=
=3B=20
> > +%rename("ChannelAttr") lttng_channel_attr=3B +%rename("Channel")
> > lttng_channel=3B +%rename("Session") lttng_session=3B + +struct lttng_d=
omain{ +
> > enum lttng_domain_type type=3B +	char padding[LTTNG_DOMAIN_PADDING1]=3B=
 + +
> > union { +		pid_t pid=3B +		char exec_name[NAME_MAX]=3B +		char
> > padding[LTTNG_DOMAIN_PADDING2]=3B +	} attr=3B + +	%extend { + 		char
> > *__repr__() { +			static char temp[256]=3B +			switch ( $self->type ) {=
 +
> > case 1: +				sprintf(temp=2C "lttng.Domain=3B type(DOMAIN_KERNEL)")=3B =
+
> > break=3B +			case 2: +				sprintf(temp=2C "lttng.Domain=3B type(DOMAIN_=
UST)")=3B +
> > break=3B +			default: +				sprintf(temp=2C "lttng.Domain=3B type(%i)"=
=2C
> > $self->type)=3B +				break=3B +			} +			return &temp[0]=3B +		} +	} +}=
=3B + +struct
> > lttng_event_context { +	enum lttng_event_context_type ctx=3B +	char
> > padding[LTTNG_EVENT_CONTEXT_PADDING1]=3B + +	union { +		struct
> > lttng_event_perf_counter_ctx perf_counter=3B +		char
> > padding[LTTNG_EVENT_CONTEXT_PADDING2]=3B +	} u=3B + +	%extend { + 		cha=
r
> > *__repr__() { +			static char temp[256]=3B +			switch ( $self->ctx ) { =
+
> > case 0: +				sprintf(temp=2C "lttng.EventContext=3B ctx(EVENT_CONTEXT_P=
ID)")=3B +
> > break=3B +			case 1: +				sprintf(temp=2C "lttng.EventContext=3B
> > ctx(EVENT_CONTEXT_PERF_COUNTER)")=3B +				break=3B +			case 2: +
> > sprintf(temp=2C "lttng.EventContext=3B ctx(EVENT_CONTEXT_PROCNAME)")=3B=
 +
> > break=3B +			case 3: +				sprintf(temp=2C "lttng.EventContext=3B
> > ctx(EVENT_CONTEXT_PRIO)")=3B +				break=3B +			case 4: +				sprintf(tem=
p=2C
> > "lttng.EventContext=3B ctx(EVENT_CONTEXT_NICE)")=3B +				break=3B +			c=
ase 5: +
> > sprintf(temp=2C "lttng.EventContext=3B ctx(EVENT_CONTEXT_VPID)")=3B +		=
		break=3B +
> > case 6: +				sprintf(temp=2C "lttng.EventContext=3B ctx(EVENT_CONTEXT_T=
ID)")=3B +
> > break=3B +			case 7: +				sprintf(temp=2C "lttng.EventContext=3B
> > ctx(EVENT_CONTEXT_VTID)")=3B +				break=3B +			case 8: +				sprintf(tem=
p=2C
> > "lttng.EventContext=3B ctx(EVENT_CONTEXT_PPID)")=3B +				break=3B +			c=
ase 9: +
> > sprintf(temp=2C "lttng.EventContext=3B ctx(EVENT_CONTEXT_VPPID)")=3B +	=
			break=3B=20
> > +			case 10: +				sprintf(temp=2C "lttng.EventContext=3B
> > ctx(EVENT_CONTEXT_PTHREAD_ID)")=3B +				break=3B +			default: +
> > sprintf(temp=2C "lttng.EventContext=3B type(%i)"=2C $self->ctx)=3B +			=
	break=3B +
> > } +			return &temp[0]=3B +		} +	} +}=3B + +struct lttng_event_probe_att=
r { +
> > uint64_t addr=3B +	uint64_t offset=3B +	char
> > symbol_name[LTTNG_SYMBOL_NAME_LEN]=3B +	char
> > padding[LTTNG_EVENT_PROBE_PADDING1]=3B +}=3B + +struct
> > lttng_event_function_attr { +	char symbol_name[LTTNG_SYMBOL_NAME_LEN]=
=3B +
> > char padding[LTTNG_EVENT_FUNCTION_PADDING1]=3B +}=3B + +struct lttng_ev=
ent { +
> > enum lttng_event_type type=3B +	char name[LTTNG_SYMBOL_NAME_LEN]=3B + +=
	enum
> > lttng_loglevel_type loglevel_type=3B +	int loglevel=3B + +	int32_t enab=
led=3B +
> > pid_t pid=3B + +	char padding[LTTNG_EVENT_PADDING1]=3B + +	union { +		s=
truct
> > lttng_event_probe_attr probe=3B +		struct lttng_event_function_attr ftr=
ace=3B=20
> > + +		char padding[LTTNG_EVENT_PADDING2]=3B +	} attr=3B + +	%extend { + =
		char
> > *__repr__() { +			static char temp[512]=3B +			char evtype[50]=3B +			c=
har
> > logtype[50]=3B + +			switch ( $self->type ) { +			case -1: +
> > sprintf(evtype=2C "EVENT_ALL")=3B +				break=3B +			case 0: +				sprint=
f(evtype=2C
> > "EVENT_TRACEPOINT")=3B +				break=3B +			case 1: +				sprintf(evtype=2C
> > "EVENT_PROBE")=3B +				break=3B +			case 2: +				sprintf(evtype=2C
> > "EVENT_FUNCTION")=3B +				break=3B +			case 3: +				sprintf(evtype=2C
> > "EVENT_FUNCTION_ENTRY")=3B +				break=3B +			case 4: +				sprintf(evtyp=
e=2C
> > "EVENT_NOOP")=3B +				break=3B +			case 5: +				sprintf(evtype=2C
> > "EVENT_SYSCALL")=3B +				break=3B +			default: +				sprintf(evtype=2C "=
%i"=2C
> > $self->type)=3B +				break=3B +			} + +			switch ( $self->loglevel_type=
 ) { +
> > case 0: +				sprintf(logtype=2C "EVENT_LOGLEVEL_ALL")=3B +				break=3B =
+			case
> > 1: +				sprintf(logtype=2C "EVENT_LOGLEVEL_RANGE")=3B +				break=3B +		=
	case 2: +
> > sprintf(logtype=2C "EVENT_LOGLEVEL_SINGLE")=3B +				break=3B +			defaul=
t: +
> > sprintf(logtype=2C "%i"=2C $self->loglevel_type)=3B +				break=3B +			}=
 + +
> > sprintf(temp=2C "lttng.Event=3B name('%s')=2C type(%s)=2C " +
> > "loglevel_type(%s)=2C loglevel(%i)=2C " +				"enabled(%s)=2C pid(%i)"=
=2C +
> > $self->name=2C evtype=2C logtype=2C $self->loglevel=2C +				$self->enab=
led ? "True"
> > : "False"=2C $self->pid)=3B +			return &temp[0]=3B +		} +	} +}=3B + +st=
ruct
> > lttng_calibrate { +	enum lttng_calibrate_type type=3B +	char
> > padding[LTTNG_CALIBRATE_PADDING1]=3B + +	%extend { + 		char *__repr__()=
 { +
> > static char temp[256]=3B +			switch ( $self->type ) { +			case 0: +
> > sprintf(temp=2C "lttng.Calibrate=3B type(CALIBRATE_FUNCTION)")=3B +				=
break=3B +
> > default: +				sprintf(temp=2C "lttng.Calibrate=3B type(%i)"=2C $self->t=
ype)=3B +
> > break=3B +			} +			return &temp[0]=3B +		} +	} +}=3B + +struct lttng_ch=
annel_attr
> > { +	int overwrite=3B +	uint64_t subbuf_size=3B +	uint64_t num_subbuf=3B=
 +
> > unsigned int switch_timer_interval=3B +	unsigned int read_timer_interva=
l=3B +
> > enum lttng_event_output output=3B + +	char
> > padding[LTTNG_CHANNEL_ATTR_PADDING1]=3B + +	%extend { + 		char *__repr_=
_() {=20
> > +			static char temp[256]=3B +			char evout[25]=3B + +			switch ( $self=
->output
> > ) { +			case 0: +				sprintf(evout=2C "EVENT_SPLICE")=3B +				break=3B =
+			case
> > 1: +				sprintf(evout=2C "EVENT_MMAP")=3B +				break=3B +			default: +
> > sprintf(evout=2C "%i"=2C $self->output)=3B +				break=3B +			} +			spri=
ntf(temp=2C
> > "lttng.ChannelAttr=3B overwrite(%i)=2C subbuf_size(%lu)=2C " +
> > "num_subbuf(%lu)=2C switch_timer_interval(%u)=2C " +
> > "read_timer_interval(%u)=2C output(%s)"=2C +				$self->overwrite=2C
> > $self->subbuf_size=2C $self->num_subbuf=2C +				$self->switch_timer_int=
erval=2C
> > $self->read_timer_interval=2C +				evout)=3B +			return &temp[0]=3B +		=
} +	} +}=3B=20
> > + +struct lttng_channel { +	char name[LTTNG_SYMBOL_NAME_LEN]=3B +	uint3=
2_t
> > enabled=3B +	struct lttng_channel_attr attr=3B +	char
> > padding[LTTNG_CHANNEL_PADDING1]=3B + +	%extend { + 		char *__repr__() {=
 +
> > static char temp[512]=3B +			sprintf(temp=2C "lttng.Channel=3B name('%s=
')=2C
> > enabled(%s)"=2C +				$self->name=2C $self->enabled ? "True" : "False")=
=3B +
> > return &temp[0]=3B +		} +	} +}=3B + +struct lttng_session { +	char
> > name[NAME_MAX]=3B +	char path[PATH_MAX]=3B +	uint32_t enabled=3B +	char
> > padding[LTTNG_SESSION_PADDING1]=3B + +	%extend { + 		char *__repr__() {=
 +
> > static char temp[512]=3B +			sprintf(temp=2C "lttng.Session=3B name('%s=
')=2C
> > path('%s')=2C enabled(%s)"=2C +				$self->name=2C $self->path=2C +
> > $self->enabled ? "True" : "False")=3B +			return &temp[0]=3B +		} +	} +=
}=3B diff
> > --git a/src/python/tests/example.py b/src/python/tests/example.py new f=
ile
> > mode 100644 index 0000000..9703170 --- /dev/null +++
> > b/src/python/tests/example.py @@ -0=2C0 +1=2C109 @@ +#This example show=
s
> > basically how to use the lttng-tools python module + +from lttng import=
 *=20
> > + +# This error will be raised is something goes wrong +class
> > LTTngError(Exception): +	def __init__(self=2C value): +		self.value =3D=
 value +
> > def __str__(self): +		return repr(self.value) + +#Setting up the domain=
 to
> > use +dom =3D Domain() +dom.type =3D DOMAIN_KERNEL + +#Setting up a chan=
nel to
> > use +channel =3D Channel() +channel.name =3D "mychan" +channel.attr.ove=
rwrite =3D
> > 0 +channel.attr.subbuf_size =3D 4096 +channel.attr.num_subbuf =3D 8=20
> > +channel.attr.switch_timer_interval =3D 0 +channel.attr.read_timer_inte=
rval =3D
> > 200 +channel.attr.output =3D EVENT_SPLICE + +#Setting up some events th=
at
> > will be used +event =3D Event() +event.type =3D EVENT_TRACEPOINT=20
> > +event.loglevel_type =3D EVENT_LOGLEVEL_ALL + +sched_switch =3D Event()=
=20
> > +sched_switch.name =3D "sched_switch" +sched_switch.type =3D EVENT_TRAC=
EPOINT=20
> > +sched_switch.loglevel_type =3D EVENT_LOGLEVEL_ALL + +sched_process_exi=
t =3D
> > Event() +sched_process_exit.name =3D "sched_process_exit"=20
> > +sched_process_exit.type =3D EVENT_TRACEPOINT=20
> > +sched_process_exit.loglevel_type =3D EVENT_LOGLEVEL_ALL +=20
> > +sched_process_free =3D Event() +sched_process_free.name =3D
> > "sched_process_free" +sched_process_free.type =3D EVENT_TRACEPOINT=20
> > +sched_process_free.loglevel_type =3D EVENT_LOGLEVEL_ALL + + +#Creating=
 a new
> > session +res =3D create("test"=2C"/lttng-traces/test") +if res<0: +	rai=
se
> > LTTngError(strerror(res)) + +#Creating handle +han =3D None +han =3D
> > Handle("test"=2C dom) +if han is None: +	raise LTTngError("Handle not
> > created") + +#Enabling the kernel channel +res =3D enable_channel(han=
=2C
> > channel) +if res<0: +	raise LTTngError(strerror(res)) + +#Enabling some
> > events in given channel +#To enable all events in default channel=2C us=
e=20
> > +#enable_event(han=2C event=2C None) +res =3D enable_event(han=2C sched=
_switch=2C
> > channel.name) +if res<0: +	raise LTTngError(strerror(res)) + +res =3D
> > enable_event(han=2C sched_process_exit=2C channel.name) +if res<0: +	ra=
ise
> > LTTngError(strerror(res)) + +res =3D enable_event(han=2C sched_process_=
free=2C
> > channel.name) +if res<0: +	raise LTTngError(strerror(res)) + +#Disablin=
g an
> > event +res =3D disable_event(han=2C sched_switch.name=2C channel.name) =
+if
> > res<0: +	raise LTTngError(strerror(res)) + +#Getting a list of the
> > channels +l =3D list_channels(han) +if type(l) is int: +		raise
> > LTTngError(strerror(l)) + +#Starting the trace +res =3D start("test") +=
if
> > res<0: +	raise LTTngError(strerror(res)) + +#Stopping the trace +res =
=3D
> > stop("test") +if res<0: +	raise LTTngError(strerror(res)) + +#Disabling=
 a
> > channel +res =3D disable_channel(han=2C channel.name) +if res<0: +	rais=
e
> > LTTngError(strerror(res)) + +#Destroying the handle +del han + +#Destro=
ying
> > the session +res =3D destroy("test") +if res<0: +	raise
> > LTTngError(strerror(res)) diff --git a/src/python/tests/run.sh
> > b/src/python/tests/run.sh new file mode 100644 index 0000000..7de819b -=
--
> > /dev/null +++ b/src/python/tests/run.sh @@ -0=2C0 +1 @@ +python tests.p=
y diff
> > --git a/src/python/tests/tests.py b/src/python/tests/tests.py new file =
mode
> > 100644 index 0000000..a4be981 --- /dev/null +++
> > b/src/python/tests/tests.py @@ -0=2C0 +1=2C310 @@ +import unittest +imp=
ort os=20
> > +import time +from lttng import * + +class TestLttngPythonModule
> > (unittest.TestCase): + +	def test_kernel_all_events(self): +		dom =3D
> > Domain() +		dom.type =3D DOMAIN_KERNEL + +		event =3D Event() +		event.=
type =3D
> > EVENT_TRACEPOINT +		event.loglevel_type =3D EVENT_LOGLEVEL_ALL + +		han=
 =3D
> > Handle("test_kernel_all_ev"=2C dom) + +		r =3D
> > create("test_kernel_all_ev"=2C"/lttng-traces/test") +
> > self.assertGreaterEqual(r=2C 0=2C strerror(r)) + +		r =3D enable_event(=
han=2C
> > event=2C None) +		self.assertGreaterEqual(r=2C 0=2C strerror(r)) + +		r=
 =3D
> > start("test_kernel_all_ev") +		self.assertGreaterEqual(r=2C 0=2C strerr=
or(r)) +
> > time.sleep(2) + +		r =3D stop("test_kernel_all_ev") +
> > self.assertGreaterEqual(r=2C 0=2C strerror(r)) + +		r =3D
> > destroy("test_kernel_all_ev") +		self.assertGreaterEqual(r=2C 0=2C
> > strerror(r)) + + +	def test_kernel_event(self): + +		dom =3D Domain() +
> > dom.type =3D DOMAIN_KERNEL + +		channel =3D Channel() +		channel.name=
=3D"mychan"=20
> > +		channel.attr.overwrite =3D 0 +		channel.attr.subbuf_size =3D 4096 +
> > channel.attr.num_subbuf =3D 8 +		channel.attr.switch_timer_interval =3D=
 0 +
> > channel.attr.read_timer_interval =3D 200 +		channel.attr.output =3D
> > EVENT_SPLICE + +		sched_switch =3D Event() +		sched_switch.name =3D
> > "sched_switch" +		sched_switch.type =3D EVENT_TRACEPOINT +
> > sched_switch.loglevel_type =3D EVENT_LOGLEVEL_ALL + +		sched_process_ex=
it =3D
> > Event() +		sched_process_exit.name =3D "sched_process_exit" +
> > sched_process_exit.type =3D EVENT_TRACEPOINT +
> > sched_process_exit.loglevel_type =3D EVENT_LOGLEVEL_ALL + +
> > sched_process_free =3D Event() +		sched_process_free.name =3D
> > "sched_process_free" +		sched_process_free.type =3D EVENT_TRACEPOINT +
> > sched_process_free.loglevel_type =3D EVENT_LOGLEVEL_ALL + +		han =3D
> > Handle("test_kernel_event"=2C dom) + +		#Create session test +		r =3D
> > create("test_kernel_event"=2C"/lttng-traces/test") +
> > self.assertGreaterEqual(r=2C 0=2C strerror(r)) + +		#Enabling channel t=
ests +
> > r =3D enable_channel(han=2C channel) +		self.assertGreaterEqual(r=2C 0=
=2C
> > strerror(r)) + +		#Enabling events tests +		r =3D enable_event(han=2C
> > sched_switch=2C channel.name) +		self.assertGreaterEqual(r=2C 0=2C stre=
rror(r))=20
> > + +		r =3D enable_event(han=2C sched_process_exit=2C channel.name) +
> > self.assertGreaterEqual(r=2C 0=2C strerror(r)) + +		r =3D enable_event(=
han=2C
> > sched_process_free=2C channel.name) +		self.assertGreaterEqual(r=2C 0=
=2C
> > strerror(r)) + +		#Disabling events tests +		r =3D disable_event(han=2C
> > sched_switch.name=2C channel.name) +		self.assertGreaterEqual(r=2C 0=2C
> > strerror(r)) + +		r =3D disable_event(han=2C sched_process_free.name=2C
> > channel.name) +		self.assertGreaterEqual(r=2C 0=2C strerror(r)) + +		#R=
enabling
> > events tests +		r =3D enable_event(han=2C sched_switch=2C channel.name)=
 +
> > self.assertGreaterEqual(r=2C 0=2C strerror(r)) + +		r =3D enable_event(=
han=2C
> > sched_process_free=2C channel.name) +		self.assertGreaterEqual(r=2C 0=
=2C
> > strerror(r)) + +		#Start=2C stop=2C destroy +		r =3D start("test_kernel=
_event") +
> > self.assertGreaterEqual(r=2C 0=2C strerror(r)) +		time.sleep(2) + +		r =
=3D
> > stop("test_kernel_event") +		self.assertGreaterEqual(r=2C 0=2C strerror=
(r)) + +
> > r=3Ddisable_channel(han=2C channel.name) +		self.assertGreaterEqual(r=
=2C 0=2C
> > strerror(r)) + +		r=3Ddestroy("test_kernel_event") +
> > self.assertGreaterEqual(r=2C 0=2C strerror(r)) + + + +	def
> > test_ust_all_events(self): +		dom =3D Domain() +		dom.type =3D DOMAIN_U=
ST + +
> > event =3D Event() +		event.type =3D EVENT_TRACEPOINT +		event.loglevel_=
type =3D
> > EVENT_LOGLEVEL_ALL + +		han =3D Handle("test_ust_all_ev"=2C dom) + +		r=
 =3D
> > create("test_ust_all_ev"=2C"/lttng-traces/test") +
> > self.assertGreaterEqual(r=2C 0=2C strerror(r)) + +		r =3D enable_event(=
han=2C
> > event=2C None) +		self.assertGreaterEqual(r=2C 0=2C strerror(r)) + +		r=
 =3D
> > start("test_ust_all_ev") +		self.assertGreaterEqual(r=2C 0=2C strerror(=
r)) +
> > time.sleep(2) + +		r =3D stop("test_ust_all_ev") +
> > self.assertGreaterEqual(r=2C 0=2C strerror(r)) + +		r =3D
> > destroy("test_ust_all_ev") +		self.assertGreaterEqual(r=2C 0=2C strerro=
r(r)) +=20
> > + +	def test_ust_event(self): + +		dom =3D Domain() +		dom.type =3D DOM=
AIN_UST=20
> > + +		channel =3D Channel() +		channel.name=3D"mychan" +		channel.attr.o=
verwrite
> > =3D 0 +		channel.attr.subbuf_size =3D 4096 +		channel.attr.num_subbuf =
=3D 8 +
> > channel.attr.switch_timer_interval =3D 0 +		channel.attr.read_timer_int=
erval
> > =3D 200 +		channel.attr.output =3D EVENT_MMAP + +		ev1 =3D Event() +		e=
v1.name =3D
> > "tp1" +		ev1.type =3D EVENT_TRACEPOINT +		ev1.loglevel_type =3D
> > EVENT_LOGLEVEL_ALL + +		ev2 =3D Event() +		ev2.name =3D "ev2" +		ev2.ty=
pe =3D
> > EVENT_TRACEPOINT +		ev2.loglevel_type =3D EVENT_LOGLEVEL_ALL + +		ev3 =
=3D
> > Event() +		ev3.name =3D "ev3" +		ev3.type =3D EVENT_TRACEPOINT +
> > ev3.loglevel_type =3D EVENT_LOGLEVEL_ALL + +		han =3D Handle("test_ust_=
event"=2C
> > dom) + +		#Create session test +		r =3D
> > create("test_ust_event"=2C"/lttng-traces/test") +		self.assertGreaterEq=
ual(r=2C
> > 0=2C strerror(r)) + +		#Enabling channel tests +		r =3D enable_channel(=
han=2C
> > channel) +		self.assertGreaterEqual(r=2C 0=2C strerror(r)) + +		#Enabli=
ng
> > events tests +		r =3D enable_event(han=2C ev1=2C channel.name) +
> > self.assertGreaterEqual(r=2C 0=2C strerror(r)) + +		r =3D enable_event(=
han=2C ev2=2C
> > channel.name) +		self.assertGreaterEqual(r=2C 0=2C strerror(r)) + +		r =
=3D
> > enable_event(han=2C ev3=2C channel.name) +		self.assertGreaterEqual(r=
=2C 0=2C
> > strerror(r)) + +		#Disabling events tests +		r =3D disable_event(han=2C
> > ev1.name=2C channel.name) +		self.assertGreaterEqual(r=2C 0=2C strerror=
(r)) + +
> > r =3D disable_event(han=2C ev3.name=2C channel.name) +
> > self.assertGreaterEqual(r=2C 0=2C strerror(r)) + +		#Renabling events t=
ests +
> > r =3D enable_event(han=2C ev1=2C channel.name) +		self.assertGreaterEqu=
al(r=2C 0=2C
> > strerror(r)) + +		r =3D enable_event(han=2C ev3=2C channel.name) +
> > self.assertGreaterEqual(r=2C 0=2C strerror(r)) + +		#Start=2C stop +		r=
 =3D
> > start("test_ust_event") +		self.assertGreaterEqual(r=2C 0=2C strerror(r=
)) +
> > time.sleep(2) + +		r =3D stop("test_ust_event") +		self.assertGreaterEq=
ual(r=2C
> > 0=2C strerror(r)) + +		#Restart/restop +		r =3D start("test_ust_event")=
 +
> > self.assertGreaterEqual(r=2C 0=2C strerror(r)) +		time.sleep(2) + +		r =
=3D
> > stop("test_ust_event") +		self.assertGreaterEqual(r=2C 0=2C strerror(r)=
) + +
> > #Disabling channel and destroy +		r=3Ddisable_channel(han=2C channel.na=
me) +
> > self.assertGreaterEqual(r=2C 0=2C strerror(r)) + +
> > r=3Ddestroy("test_ust_event") +		self.assertGreaterEqual(r=2C 0=2C stre=
rror(r))=20
> > + + +	def test_other_functions(self): +		dom =3D Domain() +
> > dom.type=3DDOMAIN_KERNEL + +		event=3DEvent() +		event.type=3DEVENT_TRA=
CEPOINT +
> > event.loglevel_type=3DEVENT_LOGLEVEL_ALL + +		calib =3D Calibrate() +
> > calib.type =3D CALIBRATE_FUNCTION + +		ctx =3D EventContext() +
> > ctx.type=3DEVENT_CONTEXT_PID + +		chattr =3D ChannelAttr() +		chattr.ov=
erwrite
> > =3D 0 +		chattr.subbuf_size =3D 4096 +		chattr.num_subbuf =3D 8 +
> > chattr.switch_timer_interval =3D 0 +		chattr.read_timer_interval =3D 20=
0 +
> > chattr.output =3D EVENT_SPLICE + +		han =3D Handle("test_otherf" =2C do=
m) + +		r
> > =3D create("test_otherf"=2C"/lttng-traces/test") +		self.assertGreaterE=
qual(r=2C
> > 0=2C strerror(r)) + +		r =3D enable_event(han=2C event=2C None) +
> > self.assertGreaterEqual(r=2C 0=2C strerror(r)) + +		#Calibrate test +		=
r =3D
> > calibrate(han =2C calib) +		self.assertGreaterEqual(r=2C 0=2C strerror(=
r)) + +
> > #Context test +		r =3D add_context(han=2C ctx=2C "sched_switch"=2C "cha=
nnel0") +
> > self.assertGreaterEqual(r=2C 0=2C strerror(r)) +		#Any channel +		r =3D
> > add_context(han=2C ctx=2C "sched_wakeup"=2C None) +		self.assertGreater=
Equal(r=2C
> > 0=2C strerror(r)) +		#All events +		r =3D add_context(han=2C ctx=2C Non=
e=2C None) +
> > self.assertGreaterEqual(r=2C 0=2C strerror(r)) + +		#Def. channel attr =
+
> > channel_set_default_attr(dom=2C chattr) +		channel_set_default_attr(Non=
e=2C
> > None) + +		#Ses Daemon alive +		r =3D session_daemon_alive() +
> > self.assertTrue(r =3D=3D 1 or r =3D=3D 0=2C strerror(r)) + +		#Setting =
trace group +
> > r =3D set_tracing_group("testing") +		self.assertGreaterEqual(r=2C 0=2C
> > strerror(r)) + + +		r =3D start("test_otherf") +		self.assertGreaterEqu=
al(r=2C
> > 0=2C strerror(r)) +		time.sleep(2) + +		r =3D stop("test_otherf") +
> > self.assertGreaterEqual(r=2C 0=2C strerror(r)) + +		del han + +		r =3D
> > destroy("test_otherf") +		self.assertGreaterEqual(r=2C 0=2C strerror(r)=
) + +=20
> > +if __name__ =3D=3D "__main__": +	# CHECK IF ROOT +	if os.geteuid() =3D=
=3D 0: +
> > #Make sure session names don't already exist: +
> > destroy("test_kernel_event") +		destroy("test_kernel_all_events") +
> > destroy("test_ust_all_events") +		destroy("test_ust_event") +
> > destroy("test_otherf") + +		unittest.main() +	else: +		print('Script mu=
st
> > be run as root')
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.12 (GNU/Linux)
>=20
> iQEcBAEBAgAGBQJQGCc4AAoJEELoaioR9I02f68IAKCipHU8psxIkXyUECveu57F
> 1ZPe9wzanUrb5eaiLH07mmbVJf/1Bu08eLfiuu1naaV0ZZIa2DenTXHcuC4orGbE
> /8KVBYidgDWIzY8lJOnw6wg+zB2ibnfTqtyhNE9Rqgesq6o776QfFgSkqzfQq/2m
> BxOsE1jKzx6JbgdquO32KBAyQAgyQu8Z9aJUYgAd3peqrx19pwnWhgnY88rtAzNi
> 5ktGj6btK4HAcQ62Q8pmTTaOR0y5sBb7STDYF2pcNMPU3TeLBjkRhl/djva0C7t/
> hPiL8IVT4AYC0y72Oof0kuSgaGIyHAxujAGHeOnOQP3KXhAvrow/bhJodbIo3pU=3D
> =3DlEVV
> -----END PGP SIGNATURE-----
 		 	   		  =

--_bcc428a7-6e0a-442d-90c4-5194ad73a6e7_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Tahoma
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'>
<br><br><div><div id=3D"SkyDrivePlaceholder"></div>&gt=3B Date: Tue=2C 31 J=
ul 2012 14:43:05 -0400<br>&gt=3B From: david.goulet@polymtl.ca<br>&gt=3B To=
: danny.serres@efficios.com<br>&gt=3B CC: lttng-dev@lists.lttng.org<br>&gt=
=3B Subject: Re: [lttng-dev] [lttng-tools PATCH] lttng-tools python module<=
br>&gt=3B <br>&gt=3B -----BEGIN PGP SIGNED MESSAGE-----<br>&gt=3B Hash: SHA=
1<br>&gt=3B <br>&gt=3B Hi Danny=2C<br>&gt=3B <br>&gt=3B Sorry for the delay=
!<br>&gt=3B <br>&gt=3B First=2C thanks for this great work. I have a couple=
 of "requests" before I put<br>&gt=3B all that upstream.<br>&gt=3B <br>&gt=
=3B Can you add the generated files into .gitignore please. I get this:<br>=
&gt=3B <br>&gt=3B #	src/python/lttng.i<br>&gt=3B #	src/python/lttng.py<br>&=
gt=3B #	src/python/lttng_wrap.c<br>&gt=3B <br>&gt=3B There is also forgotte=
n whitespaces in src/python/lttng.i.in (first carac.)<br>&gt=3B <br>&gt=3B =
+               char *__repr__() {<br>&gt=3B (times 5)<br><br>Fixed<br><br>=
&gt=3B <br>&gt=3B Apart from those minor issues=2C I have two questions abo=
ut this patch. First=2C<br>&gt=3B why is the python module in src/ and not =
in extras/ ? I consider src/ to be<br>&gt=3B supported and stable code ship=
ped with the installation and/or in packages.<br>&gt=3B Also=2C the src/ di=
rectory is the core code of lttng-tools and this module is<br>&gt=3B more a=
n extra useful tool.<br>&gt=3B <br>&gt=3B Second=2C _IF_ this goes into src=
/=2C please move the tests to the tests/<br>&gt=3B directory else we are go=
ing to make it self contained in extras/ which is good<br>&gt=3B right now.=
<br>&gt=3B <br><br>From what I've seen so far=2C other projects all have a =
top python dir which includes<br>the Python-related file.&nbsp=3B I'll wait=
 on approval on doing this before posting a new version.<br><br>&gt=3B Last=
 thing=2C could it be possible to have a small how-to/tutorial in the doc/<=
br>&gt=3B directory so people know that this exist and how to install it an=
d use it ?<br>&gt=3B (Also add it to the README in PACKAGE CONTENTS). A swi=
g2 dependency will be<br>&gt=3B added with this module so this howto should=
 mention that this depends on that<br>&gt=3B software. (swig2.0 package on =
Debian/Ubuntu).<br>&gt=3B <br>Done<br><br>Thanks<br>Danny<br><br>&gt=3B I m=
ight be wrong on some point so don't hesitate to argue and comment! :)<br>&=
gt=3B <br>&gt=3B Cheers!<br>&gt=3B David<br>&gt=3B <br>&gt=3B On 26/07/12 0=
2:09 PM=2C Danny Serres wrote:<br>&gt=3B &gt=3B The lttng-tools Python modu=
le can be used to directly control the<br>&gt=3B &gt=3B lttng-tools API ins=
ide Python=2C using 'import lttng'.<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B Ther=
efore=2C it becomes possible to create a trace=2C add events=2C start/stop<=
br>&gt=3B &gt=3B tracing=2C destroy a session and so on from within Python.=
<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B The module does not include URI-related=
 functions.<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B SWIG &gt=3B=3D 2.0 is used t=
o create the wrapper and its 'warning md variable<br>&gt=3B &gt=3B unused' =
bug is patched in Makefile.am.<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B In the in=
terface file=2C struct and enum are directly copied from lttng.h<br>&gt=3B =
&gt=3B (all changes must be made in both files).<br>&gt=3B &gt=3B <br>&gt=
=3B &gt=3B Signed-off-by: Danny Serres &lt=3Bdanny.serres@efficios.com&gt=
=3B Signed-off-by:<br>&gt=3B &gt=3B Yannick Brosseau &lt=3Byannick.brosseau=
@gmail.com&gt=3B --- config/ax_pkg_swig.m4<br>&gt=3B &gt=3B |  135 ++++++ c=
onfigure.ac                |   43 ++ src/Makefile.am<br>&gt=3B &gt=3B |    =
4 + src/python/Makefile.am      |   25 ++ src/python/lttng.i.in<br>&gt=3B &=
gt=3B | 1023 +++++++++++++++++++++++++++++++++++++++++++ <br>&gt=3B &gt=3B =
src/python/tests/example.py |  109 +++++ src/python/tests/run.sh     |    1=
<br>&gt=3B &gt=3B + src/python/tests/tests.py   |  310 +++++++++++++ 8 file=
s changed=2C 1650<br>&gt=3B &gt=3B insertions(+) create mode 100644 config/=
ax_pkg_swig.m4 create mode 100644<br>&gt=3B &gt=3B src/python/Makefile.am c=
reate mode 100644 src/python/lttng.i.in create mode<br>&gt=3B &gt=3B 100644=
 src/python/tests/example.py create mode 100644<br>&gt=3B &gt=3B src/python=
/tests/run.sh create mode 100644 src/python/tests/tests.py<br>&gt=3B &gt=3B=
 <br>&gt=3B &gt=3B diff --git a/config/ax_pkg_swig.m4 b/config/ax_pkg_swig.=
m4 new file mode<br>&gt=3B &gt=3B 100644 index 0000000..e112f3d --- /dev/nu=
ll +++ b/config/ax_pkg_swig.m4 @@<br>&gt=3B &gt=3B -0=2C0 +1=2C135 @@ +#<br=
>&gt=3B &gt=3B =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<br>&gt=3B &gt=3B<br>&gt=3B &gt=3B <br>&gt=3B +#        http=
://www.gnu.org/software/autoconf-archive/ax_pkg_swig.html<br>&gt=3B &gt=3B =
+#<br>&gt=3B &gt=3B =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br>&gt=3B &gt=3B<br>&gt=3B &gt=3B <br>&gt=3B +#<br>&g=
t=3B &gt=3B +# SYNOPSIS +# +#   AX_PKG_SWIG([major.minor.micro]=2C [action-=
if-found]=2C<br>&gt=3B &gt=3B [action-if-not-found]) +# +# DESCRIPTION +# +=
#   This macro searches for a<br>&gt=3B &gt=3B SWIG installation on your sy=
stem. If found=2C +#   then SWIG is AC_SUBST'd=3B<br>&gt=3B &gt=3B if not f=
ound=2C then $SWIG is empty.  If SWIG is +#   found=2C then SWIG_LIB is<br>=
&gt=3B &gt=3B set to the SWIG library path=2C and AC_SUBST'd. +# +#   You c=
an use the<br>&gt=3B &gt=3B optional first argument to check if the version=
 of the +#   available SWIG<br>&gt=3B &gt=3B is greater than or equal to th=
e value of the argument. It +#   should have<br>&gt=3B &gt=3B the format: N=
[.N[.N]] (N is a number between 0 and 999. Only +#   the first<br>&gt=3B &g=
t=3B N is mandatory.) If the version argument is given (e.g. +#   1.3.17)=
=2C<br>&gt=3B &gt=3B AX_PKG_SWIG checks that the swig package is this versi=
on number +#   or<br>&gt=3B &gt=3B higher. +# +#   As usual=2C action-if-fo=
und is executed if SWIG is found=2C<br>&gt=3B &gt=3B otherwise +#   action-=
if-not-found is executed. +# +#   In configure.in=2C<br>&gt=3B &gt=3B use a=
s: +# +#     AX_PKG_SWIG(1.3.17=2C []=2C [ AC_MSG_ERROR([SWIG is required<b=
r>&gt=3B &gt=3B to build..]) ]) +#     AX_SWIG_ENABLE_CXX +#<br>&gt=3B &gt=
=3B AX_SWIG_MULTI_MODULE_SUPPORT +#     AX_SWIG_PYTHON +# +# LICENSE +# +#<=
br>&gt=3B &gt=3B Copyright (c) 2008 Sebastian Huber &lt=3Bsebastian-huber@w=
eb.de&gt=3B +#   Copyright<br>&gt=3B &gt=3B (c) 2008 Alan W. Irwin &lt=3Bir=
win@beluga.phys.uvic.ca&gt=3B +#   Copyright (c) 2008<br>&gt=3B &gt=3B Rafa=
el Laboissiere &lt=3Brafael@laboissiere.net&gt=3B +#   Copyright (c) 2008 A=
ndrew<br>&gt=3B &gt=3B Collier &lt=3Bcolliera@ukzn.ac.za&gt=3B +#   Copyrig=
ht (c) 2011 Murray Cumming<br>&gt=3B &gt=3B &lt=3Bmurrayc@openismus.com&gt=
=3B +# +#   This program is free software=3B you can<br>&gt=3B &gt=3B redis=
tribute it and/or modify it +#   under the terms of the GNU General<br>&gt=
=3B &gt=3B Public License as published by the +#   Free Software Foundation=
=3B either<br>&gt=3B &gt=3B version 2 of the License=2C or (at your +#   op=
tion) any later version. +# +#<br>&gt=3B &gt=3B This program is distributed=
 in the hope that it will be useful=2C but +#<br>&gt=3B &gt=3B WITHOUT ANY =
WARRANTY=3B without even the implied warranty of +#<br>&gt=3B &gt=3B MERCHA=
NTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General +#<br>&g=
t=3B &gt=3B Public License for more details. +# +#   You should have receiv=
ed a copy of<br>&gt=3B &gt=3B the GNU General Public License along +#   wit=
h this program. If not=2C see<br>&gt=3B &gt=3B &lt=3Bhttp://www.gnu.org/lic=
enses/&gt=3B. +# +#   As a special exception=2C the<br>&gt=3B &gt=3B respec=
tive Autoconf Macro's copyright owner +#   gives unlimited permission<br>&g=
t=3B &gt=3B to copy=2C distribute and modify the configure +#   scripts tha=
t are the<br>&gt=3B &gt=3B output of Autoconf when processing the Macro. Yo=
u +#   need not follow the<br>&gt=3B &gt=3B terms of the GNU General Public=
 License when using +#   or distributing<br>&gt=3B &gt=3B such scripts=2C e=
ven though portions of the text of the +#   Macro appear in<br>&gt=3B &gt=
=3B them. The GNU General Public License (GPL) does govern +#   all other u=
se<br>&gt=3B &gt=3B of the material that constitutes the Autoconf Macro. +#=
 +#   This special<br>&gt=3B &gt=3B exception to the GPL applies to version=
s of the Autoconf +#   Macro<br>&gt=3B &gt=3B released by the Autoconf Arch=
ive. When you make and distribute a +#<br>&gt=3B &gt=3B modified version of=
 the Autoconf Macro=2C you may extend this special +#<br>&gt=3B &gt=3B exce=
ption to the GPL to apply to your modified version as well. + +#serial<br>&=
gt=3B &gt=3B 8 + +AC_DEFUN([AX_PKG_SWIG]=2C[ +        # Ubuntu has swig 2.0=
 as<br>&gt=3B &gt=3B /usr/bin/swig2.0 +        AC_PATH_PROGS([SWIG]=2C[swig=
 swig2.0]) +        if<br>&gt=3B &gt=3B test -z "$SWIG" =3B then +         =
       m4_ifval([$3]=2C[$3]=2C[:]) +<br>&gt=3B &gt=3B elif test -n "$1" =3B=
 then +                AC_MSG_CHECKING([SWIG version]) +<br>&gt=3B &gt=3B [=
swig_version=3D`$SWIG -version 2&gt=3B&amp=3B1 | grep 'SWIG Version' | sed<=
br>&gt=3B &gt=3B 's/.*\([0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\).*/\1/g'`] +=
<br>&gt=3B &gt=3B AC_MSG_RESULT([$swig_version]) +                if test -=
n "$swig_version"<br>&gt=3B &gt=3B =3B then +                        # Calc=
ulate the required version number<br>&gt=3B &gt=3B components +            =
            [required=3D$1] +<br>&gt=3B &gt=3B [required_major=3D`echo $req=
uired | sed 's/[^0-9].*//'`] +<br>&gt=3B &gt=3B if test -z "$required_major=
" =3B then +<br>&gt=3B &gt=3B [required_major=3D0] +                       =
 fi +<br>&gt=3B &gt=3B [required=3D`echo $required | sed 's/[0-9]*[^0-9]//'=
`] +<br>&gt=3B &gt=3B [required_minor=3D`echo $required | sed 's/[^0-9].*//=
'`] +<br>&gt=3B &gt=3B if test -z "$required_minor" =3B then +<br>&gt=3B &g=
t=3B [required_minor=3D0] +                        fi +<br>&gt=3B &gt=3B [r=
equired=3D`echo $required | sed 's/[0-9]*[^0-9]//'`] +<br>&gt=3B &gt=3B [re=
quired_patch=3D`echo $required | sed 's/[^0-9].*//'`] +<br>&gt=3B &gt=3B if=
 test -z "$required_patch" =3B then +<br>&gt=3B &gt=3B [required_patch=3D0]=
 +                        fi +                        #<br>&gt=3B &gt=3B Ca=
lculate the available version number components +<br>&gt=3B &gt=3B [availab=
le=3D$swig_version] +                        [available_major=3D`echo<br>&g=
t=3B &gt=3B $available | sed 's/[^0-9].*//'`] +                        if t=
est -z<br>&gt=3B &gt=3B "$available_major" =3B then +<br>&gt=3B &gt=3B [ava=
ilable_major=3D0] +                        fi +<br>&gt=3B &gt=3B [available=
=3D`echo $available | sed 's/[0-9]*[^0-9]//'`] +<br>&gt=3B &gt=3B [availabl=
e_minor=3D`echo $available | sed 's/[^0-9].*//'`] +<br>&gt=3B &gt=3B if tes=
t -z "$available_minor" =3B then +<br>&gt=3B &gt=3B [available_minor=3D0] +=
                        fi +<br>&gt=3B &gt=3B [available=3D`echo $available=
 | sed 's/[0-9]*[^0-9]//'`] +<br>&gt=3B &gt=3B [available_patch=3D`echo $av=
ailable | sed 's/[^0-9].*//'`] +<br>&gt=3B &gt=3B if test -z "$available_pa=
tch" =3B then +<br>&gt=3B &gt=3B [available_patch=3D0] +                   =
     fi +                        #<br>&gt=3B &gt=3B Convert the version tup=
le into a single number for easier comparison. +<br>&gt=3B &gt=3B # Using b=
ase 100 should be safe since SWIG internally uses BCD values +<br>&gt=3B &g=
t=3B # to encode its version number. +<br>&gt=3B &gt=3B required_swig_vernu=
m=3D`expr $required_major \* 10000 \ +<br>&gt=3B &gt=3B \+ $required_minor =
\* 100 \+ $required_patch` +<br>&gt=3B &gt=3B available_swig_vernum=3D`expr=
 $available_major \* 10000 \ +<br>&gt=3B &gt=3B \+ $available_minor \* 100 =
\+ $available_patch` + +<br>&gt=3B &gt=3B if test $available_swig_vernum -l=
t $required_swig_vernum=3B then +<br>&gt=3B &gt=3B AC_MSG_WARN([SWIG versio=
n &gt=3B=3D $1 is required.  You have $swig_version.]) +<br>&gt=3B &gt=3B S=
WIG=3D'' +                                m4_ifval([$3]=2C[$3]=2C[]) +<br>&=
gt=3B &gt=3B else +                                AC_MSG_CHECKING([for SWI=
G library]) +<br>&gt=3B &gt=3B SWIG_LIB=3D`$SWIG -swiglib` +<br>&gt=3B &gt=
=3B AC_MSG_RESULT([$SWIG_LIB]) +<br>&gt=3B &gt=3B m4_ifval([$2]=2C[$2]=2C[]=
) +                        fi +                else +<br>&gt=3B &gt=3B AC_M=
SG_WARN([cannot determine SWIG version]) +<br>&gt=3B &gt=3B SWIG=3D'' +    =
                    m4_ifval([$3]=2C[$3]=2C[]) +<br>&gt=3B &gt=3B fi +     =
   fi +        AC_SUBST([SWIG_LIB]) +]) diff --git a/configure.ac<br>&gt=3B=
 &gt=3B b/configure.ac index 17e6b67..97167de 100644 --- a/configure.ac +++=
<br>&gt=3B &gt=3B b/configure.ac @@ -154=2C6 +154=2C40 @@ AC_CHECK_LIB([c]=
=2C [open_memstream]=2C ] <br>&gt=3B &gt=3B )<br>&gt=3B &gt=3B <br>&gt=3B &=
gt=3B +# For Python +# SWIG version needed or newer: +swig_version=3D2.0.0 =
+ <br>&gt=3B &gt=3B +AC_ARG_ENABLE([python]=2C +<br>&gt=3B &gt=3B [AC_HELP_=
STRING([--disable-python]=2C +                              [do not<br>&gt=
=3B &gt=3B compile Python bindings])]=2C +              []=2C [enable_pytho=
n=3Dyes]) + <br>&gt=3B &gt=3B +AM_CONDITIONAL([USE_PYTHON]=2C [test "x${ena=
ble_python:-yes}" =3D xyes]) + +if<br>&gt=3B &gt=3B test "x${enable_python:=
-yes}" =3D xyes=3B then +  AC_MSG_NOTICE([You may<br>&gt=3B &gt=3B configur=
e with --disable-python ]dnl +[if you do not need Python<br>&gt=3B &gt=3B b=
indings.]) + +  AX_PKG_SWIG($swig_version=2C []=2C [ AC_MSG_ERROR([SWIG<br>=
&gt=3B &gt=3B $swig_version or newer is needed]) ]) +  AM_PATH_PYTHON + +<b=
r>&gt=3B &gt=3B AC_ARG_VAR([PYTHON_INCLUDE]=2C [Include flags for python=2C=
 bypassing<br>&gt=3B &gt=3B python-config]) +  AC_ARG_VAR([PYTHON_CONFIG]=
=2C [Path to python-config]) +<br>&gt=3B &gt=3B AS_IF([test -z "$PYTHON_INC=
LUDE"]=2C [ +    AS_IF([test -z "$PYTHON_CONFIG"]=2C<br>&gt=3B &gt=3B [ +  =
    AC_PATH_PROGS([PYTHON_CONFIG]=2C +<br>&gt=3B &gt=3B [python$PYTHON_VERS=
ION-config python-config]=2C +                    [no]=2C +<br>&gt=3B &gt=
=3B [`dirname $PYTHON`]) +      AS_IF([test "$PYTHON_CONFIG" =3D no]=2C<br>=
&gt=3B &gt=3B [AC_MSG_ERROR([cannot find python-config for $PYTHON.])]) +  =
  ]) +<br>&gt=3B &gt=3B AC_MSG_CHECKING([python include flags]) +    PYTHON=
_INCLUDE=3D`$PYTHON_CONFIG<br>&gt=3B &gt=3B --includes` +    AC_MSG_RESULT(=
[$PYTHON_INCLUDE]) +  ]) +fi + # Option to<br>&gt=3B &gt=3B only build the =
consumer daemon and its libraries <br>&gt=3B &gt=3B AC_ARG_WITH([consumerd-=
only]=2C AS_HELP_STRING([--with-consumerd-only]=2C[Only<br>&gt=3B &gt=3B bu=
ild the consumer daemon [default=3Dno]])=2C @@ -214=2C6 +248=2C7 @@<br>&gt=
=3B &gt=3B AC_CONFIG_FILES([ src/bin/lttng-sessiond/Makefile <br>&gt=3B &gt=
=3B src/bin/lttng-relayd/Makefile src/bin/lttng/Makefile +	src/python/Makef=
ile <br>&gt=3B &gt=3B tests/Makefile tests/kernel/Makefile tests/tools/Make=
file @@ -260=2C6 +295=2C14<br>&gt=3B &gt=3B @@ AS_IF([test "x$lttng_ust_sup=
port" =3D "xyes"]=2C[ AS_ECHO("Disabled") ])<br>&gt=3B &gt=3B <br>&gt=3B &g=
t=3B +#Python binding enabled/disabled +AS_ECHO_N("Python binding: ") <br>&=
gt=3B &gt=3B +AS_IF([test "x${enable_python:-yes}" =3D xyes]=2C [ +	AS_ECHO=
("Enabled") +]=2C[ <br>&gt=3B &gt=3B +	AS_ECHO("Disabled") +]) + # Do we bu=
ild only the consumerd=2C or<br>&gt=3B &gt=3B everything AS_IF([test "x$con=
sumerd_only" =3D "xyes"]=2C[ AS_ECHO("Only the<br>&gt=3B &gt=3B consumerd d=
aemon will be built.") diff --git a/src/Makefile.am<br>&gt=3B &gt=3B b/src/=
Makefile.am index 103337c..a65a5c1 100644 --- a/src/Makefile.am +++<br>&gt=
=3B &gt=3B b/src/Makefile.am @@ -1 +1=2C5 @@ SUBDIRS =3D common lib bin + +=
if USE_PYTHON <br>&gt=3B &gt=3B +SUBDIRS +=3D python +endif diff --git a/sr=
c/python/Makefile.am<br>&gt=3B &gt=3B b/src/python/Makefile.am new file mod=
e 100644 index 0000000..b67d550 ---<br>&gt=3B &gt=3B /dev/null +++ b/src/py=
thon/Makefile.am @@ -0=2C0 +1=2C25 @@ +lttng.i:<br>&gt=3B &gt=3B lttng.i.in=
 +	sed "s/LTTNG_VERSION_STR/LTTng $(PACKAGE_VERSION)/g"<br>&gt=3B &gt=3B &l=
t=3Blttng.i.in &gt=3Blttng.i + +AM_CFLAGS =3D -I$(PYTHONINC) -I../lib/lttng=
-ctl<br>&gt=3B &gt=3B -I../common \ +	      $(BUDDY_CFLAGS) + +EXTRA_DIST =
=3D lttng.i <br>&gt=3B &gt=3B +python_PYTHON =3D lttng.py +pyexec_LTLIBRARI=
ES =3D _lttng.la + <br>&gt=3B &gt=3B +MAINTAINERCLEANFILES =3D lttng_wrap.c=
 lttng.py + +_lttng_la_SOURCES =3D<br>&gt=3B &gt=3B lttng_wrap.c + +_lttng_=
la_LDFLAGS =3D -module + +_lttng_la_LIBADD =3D<br>&gt=3B &gt=3B ../lib/lttn=
g-ctl/liblttng-ctl.la 		\ +<br>&gt=3B &gt=3B ../common/sessiond-comm/libses=
siond-comm.la + +lttng_wrap.c: lttng.i +<br>&gt=3B &gt=3B $(SWIG) -python -=
I. -I$(top_srcdir)/src/common/sessiond-comm lttng.i +	sed<br>&gt=3B &gt=3B =
-i "s/Python.h/python$(PYTHON_VERSION)\/Python.h/g" lttng_wrap.c +	sed -i<b=
r>&gt=3B &gt=3B "s/PyObject \*m=2C \*d=2C \*md=3B/PyObject \*m=2C \*d=3B\n#=
if<br>&gt=3B &gt=3B defined(SWIGPYTHON_BUILTIN)\nPyObject *md=3B\n#endif/g"=
 lttng_wrap.c +	sed -i<br>&gt=3B &gt=3B "s/md =3D d/d/g" lttng_wrap.c +	sed=
 -i<br>&gt=3B &gt=3B "s/(void)public_symbol=3B/(void)public_symbol=3B\n  md=
 =3D d=3B/g" lttng_wrap.c <br>&gt=3B &gt=3B diff --git a/src/python/lttng.i=
.in b/src/python/lttng.i.in new file mode<br>&gt=3B &gt=3B 100644 index 000=
0000..4f3cfeb --- /dev/null +++ b/src/python/lttng.i.in @@<br>&gt=3B &gt=3B=
 -0=2C0 +1=2C1023 @@ +%define DOCSTRING +"LTTNG_VERSION_STR + +The  LTTng<b=
r>&gt=3B &gt=3B project  aims at providing highly efficient tracing tools f=
or Linux. +It's<br>&gt=3B &gt=3B tracers help tracking down performance iss=
ues and debugging problems<br>&gt=3B &gt=3B involving +multiple concurrent =
processes and threads. Tracing across<br>&gt=3B &gt=3B multiple systems is =
also possible." +%enddef + <br>&gt=3B &gt=3B +%module(docstring=3DDOCSTRING=
) lttng + +%include "typemaps.i" +%include<br>&gt=3B &gt=3B "pyabc.i" +%{ +=
#define SWIG_FILE_WITH_INIT +#include &lt=3Blttng/lttng.h&gt=3B +%} + <br>&=
gt=3B &gt=3B +typedef unsigned int uint32_t=3B +typedef int int32_t=3B +typ=
edef unsigned<br>&gt=3B &gt=3B long long uint64_t=3B +typedef long pid_t=3B=
 + + +//<br>&gt=3B &gt=3B =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D +//		ENUMS +//<br>&gt=3B &gt=3B =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D + +%rename("DOMAIN_KERNEL")<br>&gt=3B &gt=3B=
 LTTNG_DOMAIN_KERNEL=3B +%rename("DOMAIN_UST") LTTNG_DOMAIN_UST=3B +enum<br=
>&gt=3B &gt=3B lttng_domain_type { +	LTTNG_DOMAIN_KERNEL                   =
=3D 1=2C +<br>&gt=3B &gt=3B LTTNG_DOMAIN_UST                      =3D 2=2C =
+}=3B + +%rename("EVENT_ALL")<br>&gt=3B &gt=3B LTTNG_EVENT_ALL=3B +%rename(=
"EVENT_TRACEPOINT") LTTNG_EVENT_TRACEPOINT=3B <br>&gt=3B &gt=3B +%rename("E=
VENT_PROBE") LTTNG_EVENT_PROBE=3B <br>&gt=3B &gt=3B +%rename("EVENT_FUNCTIO=
N")LTTNG_EVENT_FUNCTION=3B <br>&gt=3B &gt=3B +%rename("EVENT_FUNCTION_ENTRY=
") LTTNG_EVENT_FUNCTION_ENTRY=3B <br>&gt=3B &gt=3B +%rename("EVENT_NOOP") L=
TTNG_EVENT_NOOP=3B +%rename("EVENT_SYSCALL")<br>&gt=3B &gt=3B LTTNG_EVENT_S=
YSCALL=3B +enum lttng_event_type { +	LTTNG_EVENT_ALL<br>&gt=3B &gt=3B =3D -=
1=2C +	LTTNG_EVENT_TRACEPOINT                =3D 0=2C +	LTTNG_EVENT_PROBE<b=
r>&gt=3B &gt=3B =3D 1=2C +	LTTNG_EVENT_FUNCTION                  =3D 2=2C +=
<br>&gt=3B &gt=3B LTTNG_EVENT_FUNCTION_ENTRY            =3D 3=2C +	LTTNG_EV=
ENT_NOOP<br>&gt=3B &gt=3B =3D 4=2C +	LTTNG_EVENT_SYSCALL                   =
=3D 5=2C +}=3B + <br>&gt=3B &gt=3B +%rename("EVENT_LOGLEVEL_ALL") LTTNG_EVE=
NT_LOGLEVEL_ALL=3B <br>&gt=3B &gt=3B +%rename("EVENT_LOGLEVEL_RANGE") LTTNG=
_EVENT_LOGLEVEL_RANGE=3B <br>&gt=3B &gt=3B +%rename("EVENT_LOGLEVEL_SINGLE"=
) LTTNG_EVENT_LOGLEVEL_SINGLE=3B +enum<br>&gt=3B &gt=3B lttng_loglevel_type=
 { +	LTTNG_EVENT_LOGLEVEL_ALL              =3D 0=2C +<br>&gt=3B &gt=3B LTTN=
G_EVENT_LOGLEVEL_RANGE            =3D 1=2C +	LTTNG_EVENT_LOGLEVEL_SINGLE<br=
>&gt=3B &gt=3B =3D 2=2C +}=3B + +%rename("LOGLEVEL_EMERG") LTTNG_LOGLEVEL_E=
MERG=3B <br>&gt=3B &gt=3B +%rename("LOGLEVEL_ALERT") LTTNG_LOGLEVEL_ALERT=
=3B +%rename("LOGLEVEL_CRIT")<br>&gt=3B &gt=3B LTTNG_LOGLEVEL_CRIT=3B +%ren=
ame("LOGLEVEL_ERR") LTTNG_LOGLEVEL_ERR=3B <br>&gt=3B &gt=3B +%rename("LOGLE=
VEL_WARNING") LTTNG_LOGLEVEL_WARNING=3B <br>&gt=3B &gt=3B +%rename("LOGLEVE=
L_NOTICE") LTTNG_LOGLEVEL_NOTICE=3B <br>&gt=3B &gt=3B +%rename("LOGLEVEL_IN=
FO") LTTNG_LOGLEVEL_INFO=3B <br>&gt=3B &gt=3B +%rename("LOGLEVEL_DEBUG_SYST=
EM") LTTNG_LOGLEVEL_DEBUG_SYSTEM=3B <br>&gt=3B &gt=3B +%rename("LOGLEVEL_DE=
BUG_PROGRAM") LTTNG_LOGLEVEL_DEBUG_PROGRAM=3B <br>&gt=3B &gt=3B +%rename("L=
OGLEVEL_DEBUG_PROCESS") LTTNG_LOGLEVEL_DEBUG_PROCESS=3B <br>&gt=3B &gt=3B +=
%rename("LOGLEVEL_DEBUG_MODULE") LTTNG_LOGLEVEL_DEBUG_MODULE=3B <br>&gt=3B =
&gt=3B +%rename("LOGLEVEL_DEBUG_UNIT") LTTNG_LOGLEVEL_DEBUG_UNIT=3B <br>&gt=
=3B &gt=3B +%rename("LOGLEVEL_DEBUG_FUNCTION") LTTNG_LOGLEVEL_DEBUG_FUNCTIO=
N=3B <br>&gt=3B &gt=3B +%rename("LOGLEVEL_DEBUG_LINE") LTTNG_LOGLEVEL_DEBUG=
_LINE=3B <br>&gt=3B &gt=3B +%rename("LOGLEVEL_DEBUG") LTTNG_LOGLEVEL_DEBUG=
=3B +enum lttng_loglevel { +<br>&gt=3B &gt=3B LTTNG_LOGLEVEL_EMERG         =
         =3D 0=2C +        LTTNG_LOGLEVEL_ALERT<br>&gt=3B &gt=3B =3D 1=2C +=
        LTTNG_LOGLEVEL_CRIT                   =3D 2=2C +<br>&gt=3B &gt=3B L=
TTNG_LOGLEVEL_ERR                    =3D 3=2C +        LTTNG_LOGLEVEL_WARNI=
NG<br>&gt=3B &gt=3B =3D 4=2C +        LTTNG_LOGLEVEL_NOTICE                =
 =3D 5=2C +<br>&gt=3B &gt=3B LTTNG_LOGLEVEL_INFO                   =3D 6=2C=
 +<br>&gt=3B &gt=3B LTTNG_LOGLEVEL_DEBUG_SYSTEM           =3D 7=2C +<br>&gt=
=3B &gt=3B LTTNG_LOGLEVEL_DEBUG_PROGRAM          =3D 8=2C +<br>&gt=3B &gt=
=3B LTTNG_LOGLEVEL_DEBUG_PROCESS          =3D 9=2C +<br>&gt=3B &gt=3B LTTNG=
_LOGLEVEL_DEBUG_MODULE           =3D 10=2C +<br>&gt=3B &gt=3B LTTNG_LOGLEVE=
L_DEBUG_UNIT             =3D 11=2C +<br>&gt=3B &gt=3B LTTNG_LOGLEVEL_DEBUG_=
FUNCTION         =3D 12=2C +<br>&gt=3B &gt=3B LTTNG_LOGLEVEL_DEBUG_LINE    =
         =3D 13=2C +        LTTNG_LOGLEVEL_DEBUG<br>&gt=3B &gt=3B =3D 14=2C=
 +}=3B + +%rename("EVENT_SPLICE") LTTNG_EVENT_SPLICE=3B <br>&gt=3B &gt=3B +=
%rename("EVENT_MMAP") LTTNG_EVENT_MMAP=3B +enum lttng_event_output { +<br>&=
gt=3B &gt=3B LTTNG_EVENT_SPLICE                    =3D 0=2C +	LTTNG_EVENT_M=
MAP<br>&gt=3B &gt=3B =3D 1=2C +}=3B + +%rename("EVENT_CONTEXT_PID") LTTNG_E=
VENT_CONTEXT_PID=3B <br>&gt=3B &gt=3B +%rename("EVENT_CONTEXT_PERF_COUNTER"=
) LTTNG_EVENT_CONTEXT_PERF_COUNTER=3B <br>&gt=3B &gt=3B +%rename("EVENT_CON=
TEXT_PROCNAME") LTTNG_EVENT_CONTEXT_PROCNAME=3B <br>&gt=3B &gt=3B +%rename(=
"EVENT_CONTEXT_PRIO") LTTNG_EVENT_CONTEXT_PRIO=3B <br>&gt=3B &gt=3B +%renam=
e("EVENT_CONTEXT_NICE") LTTNG_EVENT_CONTEXT_NICE=3B <br>&gt=3B &gt=3B +%ren=
ame("EVENT_CONTEXT_VPID") LTTNG_EVENT_CONTEXT_VPID=3B <br>&gt=3B &gt=3B +%r=
ename("EVENT_CONTEXT_TID") LTTNG_EVENT_CONTEXT_TID=3B <br>&gt=3B &gt=3B +%r=
ename("EVENT_CONTEXT_VTID") LTTNG_EVENT_CONTEXT_VTID=3B <br>&gt=3B &gt=3B +=
%rename("EVENT_CONTEXT_PPID") LTTNG_EVENT_CONTEXT_PPID=3B <br>&gt=3B &gt=3B=
 +%rename("EVENT_CONTEXT_VPPID") LTTNG_EVENT_CONTEXT_VPPID=3B <br>&gt=3B &g=
t=3B +%rename("EVENT_CONTEXT_PTHREAD_ID") LTTNG_EVENT_CONTEXT_PTHREAD_ID=3B=
 +enum<br>&gt=3B &gt=3B lttng_event_context_type { +	LTTNG_EVENT_CONTEXT_PI=
D               =3D 0=2C +<br>&gt=3B &gt=3B LTTNG_EVENT_CONTEXT_PERF_COUNTE=
R      =3D 1=2C +	LTTNG_EVENT_CONTEXT_PROCNAME<br>&gt=3B &gt=3B =3D 2=2C +	=
LTTNG_EVENT_CONTEXT_PRIO              =3D 3=2C +<br>&gt=3B &gt=3B LTTNG_EVE=
NT_CONTEXT_NICE              =3D 4=2C +	LTTNG_EVENT_CONTEXT_VPID<br>&gt=3B =
&gt=3B =3D 5=2C +	LTTNG_EVENT_CONTEXT_TID               =3D 6=2C +<br>&gt=
=3B &gt=3B LTTNG_EVENT_CONTEXT_VTID              =3D 7=2C +	LTTNG_EVENT_CON=
TEXT_PPID<br>&gt=3B &gt=3B =3D 8=2C +	LTTNG_EVENT_CONTEXT_VPPID            =
 =3D 9=2C +<br>&gt=3B &gt=3B LTTNG_EVENT_CONTEXT_PTHREAD_ID        =3D 10=
=2C +}=3B + <br>&gt=3B &gt=3B +%rename("CALIBRATE_FUNCTION") LTTNG_CALIBRAT=
E_FUNCTION=3B +enum<br>&gt=3B &gt=3B lttng_calibrate_type { +	LTTNG_CALIBRA=
TE_FUNCTION              =3D 0=2C +}=3B + <br>&gt=3B &gt=3B + + +// =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D +//		TYPEMAPS +//<br=
>&gt=3B &gt=3B =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 + +//list_sessions <br>&gt=3B &gt=3B +%typemap(argout) struct lttng_sessio=
n **sessions{ + +	int l =3D<br>&gt=3B &gt=3B PyInt_AsSsize_t($result)=3B +	=
if (l &gt=3B=3D 0) +	{ +		PyObject *sessions =3D<br>&gt=3B &gt=3B PyList_Ne=
w(0)=3B +		int i=3B +		for(i=3D0=3B i&lt=3Bl=3B i++) +		{ +			PyObject *tmp=
 =3D<br>&gt=3B &gt=3B PyTuple_New(4)=3B +			PyObject *name =3D PyString_Fro=
mString((*$1)[i].name)=3B +<br>&gt=3B &gt=3B PyObject *path =3D PyString_Fr=
omString((*$1)[i].path)=3B +			PyObject *enabled<br>&gt=3B &gt=3B =3D PyInt=
_FromSize_t((*$1)[i].enabled)=3B +			PyObject *padding =3D<br>&gt=3B &gt=3B=
 PyString_FromString((*$1)[i].padding)=3B + +			PyTuple_SetItem(tmp=2C 0=2C=
<br>&gt=3B &gt=3B name)=3B +			PyTuple_SetItem(tmp=2C 1=2C path)=3B +			PyT=
uple_SetItem(tmp=2C 2=2C<br>&gt=3B &gt=3B enabled)=3B +			PyTuple_SetItem(t=
mp=2C 3=2C padding)=3B +			PyList_Append(sessions=2C<br>&gt=3B &gt=3B tmp)=
=3B +		} +		$result =3D sessions=3B +	} +} +%typemap(in=2Cnuminputs=3D0) st=
ruct<br>&gt=3B &gt=3B lttng_session **sessions (struct lttng_session *temp)=
{ +	$1=3D&amp=3Btemp=3B +} + <br>&gt=3B &gt=3B +//list_domains +%typemap(ar=
gout) struct lttng_domain **domains{ + +	int l<br>&gt=3B &gt=3B =3D PyInt_A=
sSsize_t($result)=3B +	if (l &gt=3B=3D 0) +	{ +		PyObject *dom =3D<br>&gt=
=3B &gt=3B PyList_New(0)=3B +		int i=3B +		for(i=3D0=3B i&lt=3Bl=3B i++) +	=
	{ +			PyObject *tmp =3D<br>&gt=3B &gt=3B PyTuple_New(5)=3B +			PyObject *t=
ype =3D PyInt_FromSize_t((*$1)[i].type)=3B +<br>&gt=3B &gt=3B PyObject *exe=
cname =3D PyString_FromString((*$1)[i].attr.exec_name)=3B +<br>&gt=3B &gt=
=3B PyObject *pid =3D PyInt_FromSize_t((*$1)[i].attr.pid)=3B +			PyObject *=
padding<br>&gt=3B &gt=3B =3D PyString_FromString((*$1)[i].padding)=3B +			P=
yObject *attrpadding =3D<br>&gt=3B &gt=3B PyString_FromString((*$1)[i].attr=
.padding)=3B + +			PyTuple_SetItem(tmp=2C 0=2C<br>&gt=3B &gt=3B type)=3B +	=
		PyTuple_SetItem(tmp=2C 1=2C padding)=3B +			PyTuple_SetItem(tmp=2C 2=2C<b=
r>&gt=3B &gt=3B pid)=3B +			PyTuple_SetItem(tmp=2C 3=2C execname)=3B +			Py=
Tuple_SetItem(tmp=2C 4=2C<br>&gt=3B &gt=3B attrpadding)=3B +			PyList_Appen=
d(dom=2C tmp)=3B +		} +		$result =3D dom=3B +	} +} <br>&gt=3B &gt=3B +%type=
map(in=2Cnuminputs=3D0) struct lttng_domain **domains (struct<br>&gt=3B &gt=
=3B lttng_domain *temp){ +	$1=3D&amp=3Btemp=3B +} + +//list_channels +%type=
map(argout)<br>&gt=3B &gt=3B struct lttng_channel **channels{ + +	int l =3D=
 PyInt_AsSsize_t($result)=3B +	if<br>&gt=3B &gt=3B (l &gt=3B=3D 0) +	{ +		P=
yObject *chan =3D PyList_New(0)=3B +		int i=3B +		for(i=3D0=3B i&lt=3Bl=3B<=
br>&gt=3B &gt=3B i++) +		{ +			PyObject *tmp =3D PyTuple_New(4)=3B +			PyOb=
ject *name =3D<br>&gt=3B &gt=3B PyString_FromString((*$1)[i].name)=3B +			P=
yObject *enabled =3D<br>&gt=3B &gt=3B PyInt_FromSize_t((*$1)[i].enabled)=3B=
 +			PyObject *padding =3D<br>&gt=3B &gt=3B PyString_FromString((*$1)[i].pa=
dding)=3B + +			PyObject *attrtmp =3D<br>&gt=3B &gt=3B PyTuple_New(7)=3B +	=
		PyObject *overwrite =3D<br>&gt=3B &gt=3B PyInt_FromLong((*$1)[i].attr.ove=
rwrite)=3B +			PyObject *subbuf =3D<br>&gt=3B &gt=3B PyInt_FromSize_t((*$1)=
[i].attr.subbuf_size)=3B +			PyObject *num =3D<br>&gt=3B &gt=3B PyInt_FromS=
ize_t((*$1)[i].attr.num_subbuf)=3B +			PyObject *switchtimer =3D<br>&gt=3B =
&gt=3B PyInt_FromSize_t((*$1)[i].attr.switch_timer_interval)=3B +			PyObjec=
t<br>&gt=3B &gt=3B *readtimer =3D PyInt_FromSize_t((*$1)[i].attr.read_timer=
_interval)=3B +<br>&gt=3B &gt=3B PyObject *output =3D PyInt_FromSize_t((*$1=
)[i].attr.output)=3B +			PyObject<br>&gt=3B &gt=3B *attrpad =3D PyString_Fr=
omString((*$1)[i].attr.padding)=3B + +<br>&gt=3B &gt=3B PyTuple_SetItem(att=
rtmp=2C 0=2C overwrite)=3B +			PyTuple_SetItem(attrtmp=2C 1=2C<br>&gt=3B &g=
t=3B subbuf)=3B +			PyTuple_SetItem(attrtmp=2C 2=2C num)=3B +			PyTuple_Set=
Item(attrtmp=2C<br>&gt=3B &gt=3B 3=2C switchtimer)=3B +			PyTuple_SetItem(a=
ttrtmp=2C 4=2C readtimer)=3B +<br>&gt=3B &gt=3B PyTuple_SetItem(attrtmp=2C =
5=2C output)=3B +			PyTuple_SetItem(attrtmp=2C 6=2C<br>&gt=3B &gt=3B attrpa=
d)=3B + +			PyTuple_SetItem(tmp=2C 0=2C name)=3B +			PyTuple_SetItem(tmp=2C=
 1=2C<br>&gt=3B &gt=3B enabled)=3B +			PyTuple_SetItem(tmp=2C 2=2C padding)=
=3B +			PyTuple_SetItem(tmp=2C 3=2C<br>&gt=3B &gt=3B attrtmp)=3B +			PyList=
_Append(chan=2C tmp)=3B +		} +		$result =3D chan=3B +	} +} <br>&gt=3B &gt=
=3B +%typemap(in=2Cnuminputs=3D0) struct lttng_channel **channels (struct<b=
r>&gt=3B &gt=3B lttng_channel *temp){ +	$1=3D&amp=3Btemp=3B +} + +//list_ev=
ents &amp=3B list_tracepoints <br>&gt=3B &gt=3B +%typemap(argout) struct lt=
tng_event **events{ + +	int l =3D<br>&gt=3B &gt=3B PyInt_AsSsize_t($result)=
=3B +	if (l &gt=3B=3D 0) +	{ +		PyObject *events =3D<br>&gt=3B &gt=3B PyLis=
t_New(0)=3B +		int i=3B +		for(i=3D0=3B i&lt=3Bl=3B i++) +		{ +			PyObject =
*tmp =3D<br>&gt=3B &gt=3B PyTuple_New(10)=3B +			PyObject *name =3D PyStrin=
g_FromString((*$1)[i].name)=3B +<br>&gt=3B &gt=3B PyObject *type =3D PyInt_=
FromSize_t((*$1)[i].type)=3B +			PyObject<br>&gt=3B &gt=3B *logleveltype =
=3D PyInt_FromSize_t((*$1)[i].loglevel_type)=3B +			PyObject<br>&gt=3B &gt=
=3B *loglevel =3D PyInt_FromLong((*$1)[i].loglevel)=3B +			PyObject *enable=
d =3D<br>&gt=3B &gt=3B PyInt_FromLong((*$1)[i].enabled)=3B +			PyObject *pi=
d =3D<br>&gt=3B &gt=3B PyInt_FromSize_t((*$1)[i].pid)=3B +			PyObject *padd=
ing =3D<br>&gt=3B &gt=3B PyString_FromString((*$1)[i].padding)=3B +			PyObj=
ect *attrpadding =3D<br>&gt=3B &gt=3B PyString_FromString((*$1)[i].attr.pad=
ding)=3B + +			PyObject *probe =3D<br>&gt=3B &gt=3B PyTuple_New(4)=3B +			P=
yObject *addr =3D<br>&gt=3B &gt=3B PyInt_FromSize_t((*$1)[i].attr.probe.add=
r)=3B +			PyObject *offset =3D<br>&gt=3B &gt=3B PyInt_FromSize_t((*$1)[i].a=
ttr.probe.offset)=3B +			PyObject *symbolname =3D<br>&gt=3B &gt=3B PyString=
_FromString((*$1)[i].attr.probe.symbol_name)=3B +			PyObject<br>&gt=3B &gt=
=3B *probepad =3D PyString_FromString((*$1)[i].attr.probe.padding)=3B + +<b=
r>&gt=3B &gt=3B PyObject *function =3D PyTuple_New(2)=3B +			PyObject *f_sy=
mbolname =3D<br>&gt=3B &gt=3B PyString_FromString((*$1)[i].attr.ftrace.symb=
ol_name)=3B +			PyObject *f_pad<br>&gt=3B &gt=3B =3D PyString_FromString((*=
$1)[i].attr.ftrace.padding)=3B + +<br>&gt=3B &gt=3B PyTuple_SetItem(functio=
n=2C 0=2C f_symbolname)=3B +			PyTuple_SetItem(function=2C<br>&gt=3B &gt=3B=
 1=2C f_pad)=3B + +			PyTuple_SetItem(probe=2C 0=2C addr)=3B +<br>&gt=3B &g=
t=3B PyTuple_SetItem(probe=2C 1=2C offset)=3B +			PyTuple_SetItem(probe=2C =
2=2C<br>&gt=3B &gt=3B symbolname)=3B +			PyTuple_SetItem(probe=2C 3=2C prob=
epad)=3B + +<br>&gt=3B &gt=3B PyTuple_SetItem(tmp=2C 0=2C name)=3B +			PyTu=
ple_SetItem(tmp=2C 1=2C type)=3B +<br>&gt=3B &gt=3B PyTuple_SetItem(tmp=2C =
2=2C logleveltype)=3B +			PyTuple_SetItem(tmp=2C 3=2C<br>&gt=3B &gt=3B logl=
evel)=3B +			PyTuple_SetItem(tmp=2C 4=2C enabled)=3B +			PyTuple_SetItem(tm=
p=2C<br>&gt=3B &gt=3B 5=2C pid)=3B +			PyTuple_SetItem(tmp=2C 6=2C padding)=
=3B +			PyTuple_SetItem(tmp=2C 7=2C<br>&gt=3B &gt=3B probe)=3B +			PyTuple_=
SetItem(tmp=2C 8=2C function)=3B +			PyTuple_SetItem(tmp=2C 9=2C<br>&gt=3B =
&gt=3B attrpadding)=3B +			PyList_Append(events=2C tmp)=3B +		} +		$result =
=3D events=3B +<br>&gt=3B &gt=3B } +} +%typemap(in=2Cnuminputs=3D0) struct =
lttng_event **events (struct<br>&gt=3B &gt=3B lttng_event *temp){ +	$1=3D&a=
mp=3Btemp=3B +} + + + +//<br>&gt=3B &gt=3B =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D +//		FUNCTIONS +//<br>&gt=3B &gt=3B =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D + +%rename("create")=
<br>&gt=3B &gt=3B lttng_create_session(const char *name=2C const char *path=
)=3B <br>&gt=3B &gt=3B +%rename("destroy") lttng_destroy_session(const char=
 *name)=3B <br>&gt=3B &gt=3B +%rename("_lttng_create_handle") lttng_create_=
handle(const char<br>&gt=3B &gt=3B *session_name=2C struct lttng_domain *do=
main)=3B <br>&gt=3B &gt=3B +%rename("_lttng_destroy_handle") lttng_destroy_=
handle(struct lttng_handle<br>&gt=3B &gt=3B *handle)=3B +%rename("_lttng_li=
st_sessions") lttng_list_sessions(struct<br>&gt=3B &gt=3B lttng_session **s=
essions)=3B +%rename("_lttng_list_domains")<br>&gt=3B &gt=3B lttng_list_dom=
ains(const char *session_name=2C struct lttng_domain<br>&gt=3B &gt=3B **dom=
ains)=3B +%rename("_lttng_list_channels") lttng_list_channels(struct<br>&gt=
=3B &gt=3B lttng_handle *handle=2Cstruct lttng_channel **channels)=3B <br>&=
gt=3B &gt=3B +%rename("_lttng_list_events") lttng_list_events(struct lttng_=
handle<br>&gt=3B &gt=3B *handle=2C const char *channel_name=2C struct lttng=
_event **events)=3B <br>&gt=3B &gt=3B +%rename("_lttng_list_tracepoints") l=
ttng_list_tracepoints(struct<br>&gt=3B &gt=3B lttng_handle *handle=2C struc=
t lttng_event **events)=3B <br>&gt=3B &gt=3B +%rename("session_daemon_alive=
") lttng_session_daemon_alive(void)=3B <br>&gt=3B &gt=3B +%rename("set_trac=
ing_group") lttng_set_tracing_group(const char *name)=3B <br>&gt=3B &gt=3B =
+%rename("strerror") lttng_strerror(int code)=3B <br>&gt=3B &gt=3B +%rename=
("_lttng_register_consumer") lttng_register_consumer(struct<br>&gt=3B &gt=
=3B lttng_handle *handle=2C const char *socket_path)=3B +%rename("start")<b=
r>&gt=3B &gt=3B lttng_start_tracing(const char *session_name)=3B +%rename("=
stop")<br>&gt=3B &gt=3B lttng_stop_tracing(const char *session_name)=3B <br=
>&gt=3B &gt=3B +%rename("_lttng_add_context") lttng_add_context(struct lttn=
g_handle<br>&gt=3B &gt=3B *handle=2C struct lttng_event_context *ctx=2C con=
st char *event_name=2C const<br>&gt=3B &gt=3B char *channel_name)=3B +%rena=
me("_lttng_enable_event")<br>&gt=3B &gt=3B lttng_enable_event(struct lttng_=
handle *handle=2C	struct lttng_event *ev=2C<br>&gt=3B &gt=3B const char *ch=
annel_name)=3B +%rename("_lttng_enable_channel")<br>&gt=3B &gt=3B lttng_ena=
ble_channel(struct lttng_handle *handle=2C struct lttng_channel<br>&gt=3B &=
gt=3B *chan)=3B +%rename("_lttng_disable_event") lttng_disable_event(struct=
<br>&gt=3B &gt=3B lttng_handle *handle=2C const char *name=2C const char *c=
hannel_name)=3B <br>&gt=3B &gt=3B +%rename("_lttng_disable_channel") lttng_=
disable_channel(struct<br>&gt=3B &gt=3B lttng_handle *handle=2C const char =
*name)=3B +%rename("_lttng_calibrate")<br>&gt=3B &gt=3B lttng_calibrate(str=
uct lttng_handle *handle=2C struct lttng_calibrate<br>&gt=3B &gt=3B *calibr=
ate)=3B +%rename("channel_set_default_attr")<br>&gt=3B &gt=3B lttng_channel=
_set_default_attr(struct lttng_domain *domain=2C struct<br>&gt=3B &gt=3B lt=
tng_channel_attr *attr)=3B + +//Redefined functions +struct lttng_handle<br=
>&gt=3B &gt=3B *lttng_create_handle(const char *session_name=2C +		struct l=
ttng_domain<br>&gt=3B &gt=3B *domain)=3B +void lttng_destroy_handle(struct =
lttng_handle *handle)=3B +int<br>&gt=3B &gt=3B lttng_list_channels(struct l=
ttng_handle *handle=2Cstruct lttng_channel<br>&gt=3B &gt=3B **channels)=3B =
+int lttng_list_events(struct lttng_handle *handle=2C +		const<br>&gt=3B &g=
t=3B char *channel_name=2C struct lttng_event **events)=3B +int<br>&gt=3B &=
gt=3B lttng_list_tracepoints(struct lttng_handle *handle=2C struct lttng_ev=
ent<br>&gt=3B &gt=3B **events)=3B +int lttng_add_context(struct lttng_handl=
e *handle=2C struct<br>&gt=3B &gt=3B lttng_event_context *ctx=2C +		const c=
har *event_name=2C	const char<br>&gt=3B &gt=3B *channel_name)=3B +int lttng=
_enable_event(struct lttng_handle *handle=2C +<br>&gt=3B &gt=3B struct lttn=
g_event *ev=2C const char *channel_name)=3B +int<br>&gt=3B &gt=3B lttng_ena=
ble_channel(struct lttng_handle *handle=2C struct lttng_channel<br>&gt=3B &=
gt=3B *chan)=3B +int lttng_disable_event(struct lttng_handle *handle=2C +		=
const char<br>&gt=3B &gt=3B *name=2C const char *channel_name)=3B +int lttn=
g_disable_channel(struct<br>&gt=3B &gt=3B lttng_handle *handle=2C const cha=
r *name)=3B +int lttng_calibrate(struct<br>&gt=3B &gt=3B lttng_handle *hand=
le=2C struct lttng_calibrate *calibrate)=3B +int<br>&gt=3B &gt=3B lttng_reg=
ister_consumer(struct lttng_handle *handle=2C const char<br>&gt=3B &gt=3B *=
socket_path)=3B +int lttng_list_sessions(struct lttng_session **sessions)=
=3B <br>&gt=3B &gt=3B +int lttng_list_domains(const char *session_name=2C s=
truct lttng_domain<br>&gt=3B &gt=3B **domains)=3B + +//Functions not needin=
g redefinition <br>&gt=3B &gt=3B +%feature("docstring")"create(str name=2C =
str path) -&gt=3B int + +Create a new<br>&gt=3B &gt=3B tracing session usin=
g name and path. +Returns size of returned session<br>&gt=3B &gt=3B payload=
 data or a negative error code." +int lttng_create_session(const<br>&gt=3B =
&gt=3B char *name=2C const char *path)=3B + + +%feature("docstring")"destro=
y(str name)<br>&gt=3B &gt=3B -&gt=3B int + +Tear down tracing session using=
 name. +Returns size of returned<br>&gt=3B &gt=3B session payload data or a=
 negative error code." +int<br>&gt=3B &gt=3B lttng_destroy_session(const ch=
ar *name)=3B + + <br>&gt=3B &gt=3B +%feature("docstring")"session_daemon_al=
ive() -&gt=3B int + +Check if session<br>&gt=3B &gt=3B daemon is alive. +Re=
turn 1 if alive or 0 if not. +On error returns a<br>&gt=3B &gt=3B negative =
value." +int lttng_session_daemon_alive(void)=3B + + <br>&gt=3B &gt=3B +%fe=
ature("docstring")"set_tracing_group(str name) -&gt=3B int + +Sets the<br>&=
gt=3B &gt=3B tracing_group variable with name. +This function allocates mem=
ory pointed<br>&gt=3B &gt=3B to by tracing_group. +On success=2C returns 0=
=2C on error=2C returns -1 (null<br>&gt=3B &gt=3B name) or -ENOMEM." +int l=
ttng_set_tracing_group(const char *name)=3B + + <br>&gt=3B &gt=3B +%feature=
("docstring")"strerror(int code) -&gt=3B char + +Returns a human<br>&gt=3B =
&gt=3B readable string describing +the error code (a negative value)." +con=
st char<br>&gt=3B &gt=3B *lttng_strerror(int code)=3B + + +%feature("docstr=
ing")"start(str<br>&gt=3B &gt=3B session_name) -&gt=3B int + +Start tracing=
 for all traces of the session. <br>&gt=3B &gt=3B +Returns size of returned=
 session payload data or a negative error code." <br>&gt=3B &gt=3B +int ltt=
ng_start_tracing(const char *session_name)=3B + + <br>&gt=3B &gt=3B +%featu=
re("docstring")"stop(str session_name) -&gt=3B int + +Stop tracing for<br>&=
gt=3B &gt=3B all traces of the session. +Returns size of returned session p=
ayload data<br>&gt=3B &gt=3B or a negative error code." +int lttng_stop_tra=
cing(const char<br>&gt=3B &gt=3B *session_name)=3B + + +%feature("docstring=
")"channel_set_default_attr(Domain<br>&gt=3B &gt=3B domain=2C ChannelAttr a=
ttr) + +Set default channel attributes. +If either or<br>&gt=3B &gt=3B both=
 of the arguments are null=2C attr content is zeroe'd." +void<br>&gt=3B &gt=
=3B lttng_channel_set_default_attr(struct lttng_domain *domain=2C struct<br=
>&gt=3B &gt=3B lttng_channel_attr *attr)=3B + + +//<br>&gt=3B &gt=3B =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D +//	Python redefinit=
ion of<br>&gt=3B &gt=3B some functions +//	(List and Handle-related) +//<br=
>&gt=3B &gt=3B =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 + +%feature("docstring")"" <br>&gt=3B &gt=3B +%pythoncode %{ + +def list_s=
essions(): +	""" +	list_sessions() -&gt=3B dict + +<br>&gt=3B &gt=3B Ask th=
e session daemon for all available sessions. +	Returns a dict of<br>&gt=3B =
&gt=3B Session instances=2C the key is the name=3B +	on error=2C returns a =
negative<br>&gt=3B &gt=3B value. +	""" + +	ses_list =3D _lttng_list_session=
s() +	if type(ses_list) is<br>&gt=3B &gt=3B int: +		return ses_list + +	ses=
sions =3D {} + +	for ses_elements in<br>&gt=3B &gt=3B ses_list: +		ses =3D =
Session() +		ses.name =3D ses_elements[0] +		ses.path =3D<br>&gt=3B &gt=3B =
ses_elements[1] +		ses.enabled =3D ses_elements[2] +		ses.padding =3D<br>&g=
t=3B &gt=3B ses_elements[3] + +		sessions[ses.name] =3D ses + +	return sess=
ions + + +def<br>&gt=3B &gt=3B list_domains(session_name): +	""" +	list_dom=
ains(str session_name) -&gt=3B list <br>&gt=3B &gt=3B + +	Ask the session d=
aemon for all available domains of a session. +<br>&gt=3B &gt=3B Returns a =
list of Domain instances=3B +	on error=2C returns a negative value. +<br>&g=
t=3B &gt=3B """ + +	dom_list =3D _lttng_list_domains(session_name) +	if typ=
e(dom_list) is<br>&gt=3B &gt=3B int: +		return dom_list + +	domains =3D [] =
+ +	for dom_elements in dom_list: <br>&gt=3B &gt=3B +		dom =3D Domain() +		=
dom.type =3D dom_elements[0] +		dom.paddinf =3D<br>&gt=3B &gt=3B dom_elemen=
ts[1] +		dom.attr.pid =3D dom_elements[2] +		dom.attr.exec_name =3D<br>&gt=
=3B &gt=3B dom_elements[3] +		dom.attr.padding =3D dom_elements[4] + +<br>&=
gt=3B &gt=3B domains.append(dom) + +	return domains + + +def list_channels(=
handle): +<br>&gt=3B &gt=3B """ +	list_channels(Handle handle) -&gt=3B dict=
 + +	Ask the session daemon for<br>&gt=3B &gt=3B all available channels of =
a session. +	Returns a dict of Channel instances=2C<br>&gt=3B &gt=3B the ke=
y is the name=3B +	on error=2C returns a negative value. +	""" + +	try: +<b=
r>&gt=3B &gt=3B chan_list =3D _lttng_list_channels(handle._h) +	except Attr=
ibuteError: +<br>&gt=3B &gt=3B raise TypeError("in method 'list_channels'=
=2C argument 1 must be a Handle<br>&gt=3B &gt=3B instance") + +	if type(cha=
n_list) is int: +		return chan_list + +	channels<br>&gt=3B &gt=3B =3D {} + =
+	for channel_elements in chan_list: +		chan =3D Channel() +<br>&gt=3B &gt=
=3B chan.name =3D channel_elements[0] +		chan.enabled =3D channel_elements[=
1] +<br>&gt=3B &gt=3B chan.padding =3D channel_elements[2] +		chan.attr.ove=
rwrite =3D<br>&gt=3B &gt=3B channel_elements[3][0] +		chan.attr.subbuf_size=
 =3D channel_elements[3][1] +<br>&gt=3B &gt=3B chan.attr.num_subbuf =3D cha=
nnel_elements[3][2] +<br>&gt=3B &gt=3B chan.attr.switch_timer_interval =3D =
channel_elements[3][3] +<br>&gt=3B &gt=3B chan.attr.read_timer_interval =3D=
 channel_elements[3][4] +		chan.attr.output<br>&gt=3B &gt=3B =3D channel_el=
ements[3][5] +		chan.attr.padding =3D channel_elements[3][6] + +<br>&gt=3B =
&gt=3B channels[chan.name] =3D chan + +	return channels + + +def list_event=
s(handle=2C<br>&gt=3B &gt=3B channel_name): +	""" +	list_events(Handle hand=
le=2C str channel_name) -&gt=3B<br>&gt=3B &gt=3B dict + +	Ask the session d=
aemon for all available events of a session<br>&gt=3B &gt=3B channel. +	Ret=
urns a dict of Event instances=2C the key is the name=3B +	on<br>&gt=3B &gt=
=3B error=2C returns a negative value. +	""" + +	try: +		ev_list =3D<br>&gt=
=3B &gt=3B _lttng_list_events(handle._h=2C channel_name) +	except Attribute=
Error: +<br>&gt=3B &gt=3B raise TypeError("in method 'list_events'=2C argum=
ent 1 must be a Handle<br>&gt=3B &gt=3B instance") + +	if type(ev_list) is =
int: +		return ev_list + +	events =3D {} <br>&gt=3B &gt=3B + +	for ev_eleme=
nts in ev_list: +		ev =3D Event() +		ev.name =3D<br>&gt=3B &gt=3B ev_elemen=
ts[0] +		ev.type =3D ev_elements[1] +		ev.loglevel_type =3D<br>&gt=3B &gt=
=3B ev_elements[2] +		ev.loglevel =3D ev_elements[3] +		ev.enabled =3D<br>&=
gt=3B &gt=3B ev_elements[4] +		ev.pid =3D ev_elements[5] +		ev.attr.padding=
 =3D<br>&gt=3B &gt=3B ev_elements[6] +		ev.attr.probe.addr =3D ev_elements[=
7][0] +<br>&gt=3B &gt=3B ev.attr.probe.offset =3D ev_elements[7][1] +		ev.a=
ttr.probe.symbol_name =3D<br>&gt=3B &gt=3B ev_elements[7][2] +		ev.attr.pro=
be.padding =3D ev_elements[7][3] +<br>&gt=3B &gt=3B ev.attr.ftrace.symbol_n=
ame =3D ev_elements[8][0] +		ev.attr.ftrace.padding =3D<br>&gt=3B &gt=3B ev=
_elements[8][1] +		ev.attr.padding =3D ev_elements[9] + +		events[ev.name]<=
br>&gt=3B &gt=3B =3D ev + +	return events + + +def list_tracepoints(handle)=
: +	""" +<br>&gt=3B &gt=3B list_tracepoints(Handle handle) -&gt=3B dict + +=
	Returns a dict of Event<br>&gt=3B &gt=3B instances=2C the key is the name=
=3B +	on error=2C returns a negative value. +<br>&gt=3B &gt=3B """ + +	try:=
 +		ev_list =3D _lttng_list_tracepoints(handle._h) +	except<br>&gt=3B &gt=
=3B AttributeError: +		raise TypeError("in method 'list_tracepoints'=2C arg=
ument<br>&gt=3B &gt=3B 1 must be a Handle instance") + +	if type(ev_list) i=
s int: +		return<br>&gt=3B &gt=3B ev_list + +	events =3D {} + +	for ev_elem=
ents in ev_list: +		ev =3D Event() +<br>&gt=3B &gt=3B ev.name =3D ev_elemen=
ts[0] +		ev.type =3D ev_elements[1] +		ev.loglevel_type =3D<br>&gt=3B &gt=
=3B ev_elements[2] +		ev.loglevel =3D ev_elements[3] +		ev.enabled =3D<br>&=
gt=3B &gt=3B ev_elements[4] +		ev.pid =3D ev_elements[5] +		ev.attr.padding=
 =3D<br>&gt=3B &gt=3B ev_elements[6] +		ev.attr.probe.addr =3D ev_elements[=
7][0] +<br>&gt=3B &gt=3B ev.attr.probe.offset =3D ev_elements[7][1] +		ev.a=
ttr.probe.symbol_name =3D<br>&gt=3B &gt=3B ev_elements[7][2] +		ev.attr.pro=
be.padding =3D ev_elements[7][3] +<br>&gt=3B &gt=3B ev.attr.ftrace.symbol_n=
ame =3D ev_elements[8][0] +		ev.attr.ftrace.padding =3D<br>&gt=3B &gt=3B ev=
_elements[8][1] +		ev.attr.padding =3D ev_elements[9] + +		events[ev.name]<=
br>&gt=3B &gt=3B =3D ev + +	return events + + +def register_consumer(handle=
=2C socket_path): +<br>&gt=3B &gt=3B """ +	register_consumer(Handle handle=
=2C str socket_path) -&gt=3B int + +	Register<br>&gt=3B &gt=3B an outside c=
onsumer. +	Returns size of returned session payload data or a<br>&gt=3B &gt=
=3B negative error code. +	""" + +	try: +		return<br>&gt=3B &gt=3B _lttng_r=
egister_consumer(handle._h=2C socket_path) +	except AttributeError: +<br>&g=
t=3B &gt=3B raise TypeError("in method 'register_consumer'=2C argument 1 mu=
st be a Handle<br>&gt=3B &gt=3B instance") + + +def add_context(handle=2C e=
vent_context=2C event_name=2C<br>&gt=3B &gt=3B channel_name): +	""" +	add_c=
ontext(Handle handle=2C EventContext ctx=2C +<br>&gt=3B &gt=3B str event_na=
me=2C str channel_name) -&gt=3B int + +	Add context to event and/or<br>&gt=
=3B &gt=3B channel. +	If event_name is None=2C the context is applied to al=
l events of<br>&gt=3B &gt=3B the channel. +	If channel_name is None=2C a lo=
okup of the event's channel is<br>&gt=3B &gt=3B done. +	If both are None=2C=
 the context is applied to all events of all<br>&gt=3B &gt=3B channels. +	R=
eturns the size of the returned payload data or a negative<br>&gt=3B &gt=3B=
 error code. +	""" + +	try: +		return _lttng_add_context(handle._h=2C<br>&g=
t=3B &gt=3B event_context=2C event_name=2C channel_name) +	except Attribute=
Error: +		raise<br>&gt=3B &gt=3B TypeError("in method 'add_context'=2C argu=
ment 1 must be a Handle instance") <br>&gt=3B &gt=3B + + +def enable_event(=
handle=2C event=2C channel_name): +	""" +<br>&gt=3B &gt=3B enable_event(Han=
dle handle=2C Event event=2C +		    str channel_name) -&gt=3B int + <br>&gt=
=3B &gt=3B +	Enable event(s) for a channel. +	If no event name is specified=
=2C all<br>&gt=3B &gt=3B events are enabled. +	If no channel name is specif=
ied=2C the default<br>&gt=3B &gt=3B 'channel0' is used. +	Returns size of r=
eturned session payload data or a<br>&gt=3B &gt=3B negative error code. +	"=
"" + +	try: +		return<br>&gt=3B &gt=3B _lttng_enable_event(handle._h=2C eve=
nt=2C channel_name) +	except<br>&gt=3B &gt=3B AttributeError: +		raise Type=
Error("in method 'enable_event'=2C argument 1<br>&gt=3B &gt=3B must be a Ha=
ndle instance") + + +def enable_channel(handle=2C channel): +<br>&gt=3B &gt=
=3B """ +	enable_channel(Handle handle=2C Channel channel -&gt=3B int + +	E=
nable<br>&gt=3B &gt=3B channel per domain +	Returns size of returned sessio=
n payload data or a<br>&gt=3B &gt=3B negative error code. +	""" + +	try: +	=
	return<br>&gt=3B &gt=3B _lttng_enable_channel(handle._h=2C channel) +	exce=
pt AttributeError: +		raise<br>&gt=3B &gt=3B TypeError("in method 'enable_c=
hannel'=2C argument 1 must be a Handle<br>&gt=3B &gt=3B instance") + + +def=
 disable_event(handle=2C name=2C channel_name): +	""" +<br>&gt=3B &gt=3B di=
sable_event(Handle handle=2C str name=2C str channel_name) -&gt=3B int + +	=
Disable<br>&gt=3B &gt=3B event(s) of a channel and domain. +	If no event na=
me is specified=2C all<br>&gt=3B &gt=3B events are disabled. +	If no channe=
l name is specified=2C the default<br>&gt=3B &gt=3B 'channel0' is used. +	R=
eturns size of returned session payload data or a<br>&gt=3B &gt=3B negative=
 error code +	""" + +	try: +		return<br>&gt=3B &gt=3B _lttng_disable_event(=
handle._h=2C name=2C channel_name) +	except<br>&gt=3B &gt=3B AttributeError=
: +		raise TypeError("in method 'disable_event'=2C argument 1<br>&gt=3B &gt=
=3B must be a Handle instance") + + +def disable_channel(handle=2C name): +=
	""" +<br>&gt=3B &gt=3B disable_channel(Handle handle=2C str name) -&gt=3B =
int + +	All tracing will be<br>&gt=3B &gt=3B stopped for registered events =
of the channel. +	Returns size of returned<br>&gt=3B &gt=3B session payload=
 data or a negative error code. +	""" + +	try: +		return<br>&gt=3B &gt=3B _=
lttng_disable_channel(handle._h=2C name) +	except AttributeError: +		raise<=
br>&gt=3B &gt=3B TypeError("in method 'disable_channel'=2C argument 1 must =
be a Handle<br>&gt=3B &gt=3B instance") + + +def calibrate(handle=2C calibr=
ate): +	""" +	calibrate(Handle<br>&gt=3B &gt=3B handle=2C Calibrate calibra=
te) -&gt=3B int + +	Quantify LTTng overhead. +	Returns<br>&gt=3B &gt=3B siz=
e of returned session payload data or a negative error code. +	""" + +<br>&=
gt=3B &gt=3B try: +		return _lttng_calibrate(handle._h=2C calibrate) +	exce=
pt<br>&gt=3B &gt=3B AttributeError: +		raise TypeError("in method 'calibrat=
e'=2C argument 1 must<br>&gt=3B &gt=3B be a Handle instance") +%} + + +//<b=
r>&gt=3B &gt=3B =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D +//		Handle class +//   Used<br>&gt=3B &gt=3B to prevent freeing unallo=
cated memory +//<br>&gt=3B &gt=3B =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D + +%feature("docstring")"" <br>&gt=3B &gt=3B +%featur=
e("autodoc"=2C "1")=3B + +%pythoncode %{ +class Handle: +        """ +<br>&=
gt=3B &gt=3B Manages a handle. +	Takes two arguments: (str session_name=2C =
Domain domain) <br>&gt=3B &gt=3B +	""" + +	__frozen =3D False + +	def __ini=
t__(self=2C session_name=2C domain): +<br>&gt=3B &gt=3B if type(session_nam=
e) is not str: +			raise TypeError("in method<br>&gt=3B &gt=3B '__init__'=
=2C argument 2 of type 'str'") +		if type(domain) is not Domain and<br>&gt=
=3B &gt=3B domain is not None: +			raise TypeError("in method '__init__'=2C=
 argument 3<br>&gt=3B &gt=3B of type 'lttng.Domain'") + +		self._sname =3D =
session_name +		if domain is<br>&gt=3B &gt=3B None: +			self._domtype =3D N=
one +		else: +			self._domtype =3D domain.type +<br>&gt=3B &gt=3B self._h =
=3D _lttng_create_handle(session_name=2C domain) +		self.__frozen =3D<br>&g=
t=3B &gt=3B True + +	def __del__(self): +		_lttng_destroy_handle(self._h) +=
 +	def<br>&gt=3B &gt=3B __repr__(self): +		if self._domtype =3D=3D 1: +			d=
omstr =3D "DOMAIN_KERNEL" +<br>&gt=3B &gt=3B elif self._domtype =3D=3D 2: +=
			domstr =3D "DOMAIN_UST" +		else: +			domstr =3D<br>&gt=3B &gt=3B self._d=
omtype + +		return "lttng.Handle=3B session('{}')=2C<br>&gt=3B &gt=3B domai=
n.type({})".format( +			self._sname=2C domstr) + +	def __setattr__(self=2C<=
br>&gt=3B &gt=3B attr=2C val): +		if self.__frozen: +			raise NotImplemente=
dError("cannot<br>&gt=3B &gt=3B modify attributes") +		else: +			self.__dic=
t__[attr] =3D val +%} + + +//<br>&gt=3B &gt=3B =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D +//		STRUCTURES +//<br>&gt=3B &gt=3B =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D + +%rename("Domai=
n")<br>&gt=3B &gt=3B lttng_domain=3B +%rename("EventContext") lttng_event_c=
ontext=3B <br>&gt=3B &gt=3B +%rename("Event") lttng_event=3B +%rename("Cali=
brate") lttng_calibrate=3B <br>&gt=3B &gt=3B +%rename("ChannelAttr") lttng_=
channel_attr=3B +%rename("Channel")<br>&gt=3B &gt=3B lttng_channel=3B +%ren=
ame("Session") lttng_session=3B + +struct lttng_domain{ +<br>&gt=3B &gt=3B =
enum lttng_domain_type type=3B +	char padding[LTTNG_DOMAIN_PADDING1]=3B + +=
<br>&gt=3B &gt=3B union { +		pid_t pid=3B +		char exec_name[NAME_MAX]=3B +	=
	char<br>&gt=3B &gt=3B padding[LTTNG_DOMAIN_PADDING2]=3B +	} attr=3B + +	%e=
xtend { + 		char<br>&gt=3B &gt=3B *__repr__() { +			static char temp[256]=
=3B +			switch ( $self-&gt=3Btype ) { +<br>&gt=3B &gt=3B case 1: +				sprin=
tf(temp=2C "lttng.Domain=3B type(DOMAIN_KERNEL)")=3B +<br>&gt=3B &gt=3B bre=
ak=3B +			case 2: +				sprintf(temp=2C "lttng.Domain=3B type(DOMAIN_UST)")=
=3B +<br>&gt=3B &gt=3B break=3B +			default: +				sprintf(temp=2C "lttng.Do=
main=3B type(%i)"=2C<br>&gt=3B &gt=3B $self-&gt=3Btype)=3B +				break=3B +	=
		} +			return &amp=3Btemp[0]=3B +		} +	} +}=3B + +struct<br>&gt=3B &gt=3B =
lttng_event_context { +	enum lttng_event_context_type ctx=3B +	char<br>&gt=
=3B &gt=3B padding[LTTNG_EVENT_CONTEXT_PADDING1]=3B + +	union { +		struct<b=
r>&gt=3B &gt=3B lttng_event_perf_counter_ctx perf_counter=3B +		char<br>&gt=
=3B &gt=3B padding[LTTNG_EVENT_CONTEXT_PADDING2]=3B +	} u=3B + +	%extend { =
+ 		char<br>&gt=3B &gt=3B *__repr__() { +			static char temp[256]=3B +			sw=
itch ( $self-&gt=3Bctx ) { +<br>&gt=3B &gt=3B case 0: +				sprintf(temp=2C =
"lttng.EventContext=3B ctx(EVENT_CONTEXT_PID)")=3B +<br>&gt=3B &gt=3B break=
=3B +			case 1: +				sprintf(temp=2C "lttng.EventContext=3B<br>&gt=3B &gt=
=3B ctx(EVENT_CONTEXT_PERF_COUNTER)")=3B +				break=3B +			case 2: +<br>&gt=
=3B &gt=3B sprintf(temp=2C "lttng.EventContext=3B ctx(EVENT_CONTEXT_PROCNAM=
E)")=3B +<br>&gt=3B &gt=3B break=3B +			case 3: +				sprintf(temp=2C "lttng=
.EventContext=3B<br>&gt=3B &gt=3B ctx(EVENT_CONTEXT_PRIO)")=3B +				break=
=3B +			case 4: +				sprintf(temp=2C<br>&gt=3B &gt=3B "lttng.EventContext=
=3B ctx(EVENT_CONTEXT_NICE)")=3B +				break=3B +			case 5: +<br>&gt=3B &gt=
=3B sprintf(temp=2C "lttng.EventContext=3B ctx(EVENT_CONTEXT_VPID)")=3B +		=
		break=3B +<br>&gt=3B &gt=3B case 6: +				sprintf(temp=2C "lttng.EventCont=
ext=3B ctx(EVENT_CONTEXT_TID)")=3B +<br>&gt=3B &gt=3B break=3B +			case 7: =
+				sprintf(temp=2C "lttng.EventContext=3B<br>&gt=3B &gt=3B ctx(EVENT_CONT=
EXT_VTID)")=3B +				break=3B +			case 8: +				sprintf(temp=2C<br>&gt=3B &gt=
=3B "lttng.EventContext=3B ctx(EVENT_CONTEXT_PPID)")=3B +				break=3B +			c=
ase 9: +<br>&gt=3B &gt=3B sprintf(temp=2C "lttng.EventContext=3B ctx(EVENT_=
CONTEXT_VPPID)")=3B +				break=3B <br>&gt=3B &gt=3B +			case 10: +				sprin=
tf(temp=2C "lttng.EventContext=3B<br>&gt=3B &gt=3B ctx(EVENT_CONTEXT_PTHREA=
D_ID)")=3B +				break=3B +			default: +<br>&gt=3B &gt=3B sprintf(temp=2C "l=
ttng.EventContext=3B type(%i)"=2C $self-&gt=3Bctx)=3B +				break=3B +<br>&g=
t=3B &gt=3B } +			return &amp=3Btemp[0]=3B +		} +	} +}=3B + +struct lttng_e=
vent_probe_attr { +<br>&gt=3B &gt=3B uint64_t addr=3B +	uint64_t offset=3B =
+	char<br>&gt=3B &gt=3B symbol_name[LTTNG_SYMBOL_NAME_LEN]=3B +	char<br>&gt=
=3B &gt=3B padding[LTTNG_EVENT_PROBE_PADDING1]=3B +}=3B + +struct<br>&gt=3B=
 &gt=3B lttng_event_function_attr { +	char symbol_name[LTTNG_SYMBOL_NAME_LE=
N]=3B +<br>&gt=3B &gt=3B char padding[LTTNG_EVENT_FUNCTION_PADDING1]=3B +}=
=3B + +struct lttng_event { +<br>&gt=3B &gt=3B enum lttng_event_type type=
=3B +	char name[LTTNG_SYMBOL_NAME_LEN]=3B + +	enum<br>&gt=3B &gt=3B lttng_l=
oglevel_type loglevel_type=3B +	int loglevel=3B + +	int32_t enabled=3B +<br=
>&gt=3B &gt=3B pid_t pid=3B + +	char padding[LTTNG_EVENT_PADDING1]=3B + +	u=
nion { +		struct<br>&gt=3B &gt=3B lttng_event_probe_attr probe=3B +		struct=
 lttng_event_function_attr ftrace=3B <br>&gt=3B &gt=3B + +		char padding[LT=
TNG_EVENT_PADDING2]=3B +	} attr=3B + +	%extend { + 		char<br>&gt=3B &gt=3B =
*__repr__() { +			static char temp[512]=3B +			char evtype[50]=3B +			char<=
br>&gt=3B &gt=3B logtype[50]=3B + +			switch ( $self-&gt=3Btype ) { +			cas=
e -1: +<br>&gt=3B &gt=3B sprintf(evtype=2C "EVENT_ALL")=3B +				break=3B +	=
		case 0: +				sprintf(evtype=2C<br>&gt=3B &gt=3B "EVENT_TRACEPOINT")=3B +	=
			break=3B +			case 1: +				sprintf(evtype=2C<br>&gt=3B &gt=3B "EVENT_PROB=
E")=3B +				break=3B +			case 2: +				sprintf(evtype=2C<br>&gt=3B &gt=3B "E=
VENT_FUNCTION")=3B +				break=3B +			case 3: +				sprintf(evtype=2C<br>&gt=
=3B &gt=3B "EVENT_FUNCTION_ENTRY")=3B +				break=3B +			case 4: +				sprint=
f(evtype=2C<br>&gt=3B &gt=3B "EVENT_NOOP")=3B +				break=3B +			case 5: +		=
		sprintf(evtype=2C<br>&gt=3B &gt=3B "EVENT_SYSCALL")=3B +				break=3B +			=
default: +				sprintf(evtype=2C "%i"=2C<br>&gt=3B &gt=3B $self-&gt=3Btype)=
=3B +				break=3B +			} + +			switch ( $self-&gt=3Bloglevel_type ) { +<br>&=
gt=3B &gt=3B case 0: +				sprintf(logtype=2C "EVENT_LOGLEVEL_ALL")=3B +				=
break=3B +			case<br>&gt=3B &gt=3B 1: +				sprintf(logtype=2C "EVENT_LOGLEV=
EL_RANGE")=3B +				break=3B +			case 2: +<br>&gt=3B &gt=3B sprintf(logtype=
=2C "EVENT_LOGLEVEL_SINGLE")=3B +				break=3B +			default: +<br>&gt=3B &gt=
=3B sprintf(logtype=2C "%i"=2C $self-&gt=3Bloglevel_type)=3B +				break=3B =
+			} + +<br>&gt=3B &gt=3B sprintf(temp=2C "lttng.Event=3B name('%s')=2C ty=
pe(%s)=2C " +<br>&gt=3B &gt=3B "loglevel_type(%s)=2C loglevel(%i)=2C " +			=
	"enabled(%s)=2C pid(%i)"=2C +<br>&gt=3B &gt=3B $self-&gt=3Bname=2C evtype=
=2C logtype=2C $self-&gt=3Bloglevel=2C +				$self-&gt=3Benabled ? "True"<br=
>&gt=3B &gt=3B : "False"=2C $self-&gt=3Bpid)=3B +			return &amp=3Btemp[0]=
=3B +		} +	} +}=3B + +struct<br>&gt=3B &gt=3B lttng_calibrate { +	enum lttn=
g_calibrate_type type=3B +	char<br>&gt=3B &gt=3B padding[LTTNG_CALIBRATE_PA=
DDING1]=3B + +	%extend { + 		char *__repr__() { +<br>&gt=3B &gt=3B static c=
har temp[256]=3B +			switch ( $self-&gt=3Btype ) { +			case 0: +<br>&gt=3B =
&gt=3B sprintf(temp=2C "lttng.Calibrate=3B type(CALIBRATE_FUNCTION)")=3B +	=
			break=3B +<br>&gt=3B &gt=3B default: +				sprintf(temp=2C "lttng.Calibra=
te=3B type(%i)"=2C $self-&gt=3Btype)=3B +<br>&gt=3B &gt=3B break=3B +			} +=
			return &amp=3Btemp[0]=3B +		} +	} +}=3B + +struct lttng_channel_attr<br>=
&gt=3B &gt=3B { +	int overwrite=3B +	uint64_t subbuf_size=3B +	uint64_t num=
_subbuf=3B +<br>&gt=3B &gt=3B unsigned int switch_timer_interval=3B +	unsig=
ned int read_timer_interval=3B +<br>&gt=3B &gt=3B enum lttng_event_output o=
utput=3B + +	char<br>&gt=3B &gt=3B padding[LTTNG_CHANNEL_ATTR_PADDING1]=3B =
+ +	%extend { + 		char *__repr__() { <br>&gt=3B &gt=3B +			static char temp=
[256]=3B +			char evout[25]=3B + +			switch ( $self-&gt=3Boutput<br>&gt=3B =
&gt=3B ) { +			case 0: +				sprintf(evout=2C "EVENT_SPLICE")=3B +				break=
=3B +			case<br>&gt=3B &gt=3B 1: +				sprintf(evout=2C "EVENT_MMAP")=3B +		=
		break=3B +			default: +<br>&gt=3B &gt=3B sprintf(evout=2C "%i"=2C $self-&=
gt=3Boutput)=3B +				break=3B +			} +			sprintf(temp=2C<br>&gt=3B &gt=3B "l=
ttng.ChannelAttr=3B overwrite(%i)=2C subbuf_size(%lu)=2C " +<br>&gt=3B &gt=
=3B "num_subbuf(%lu)=2C switch_timer_interval(%u)=2C " +<br>&gt=3B &gt=3B "=
read_timer_interval(%u)=2C output(%s)"=2C +				$self-&gt=3Boverwrite=2C<br>=
&gt=3B &gt=3B $self-&gt=3Bsubbuf_size=2C $self-&gt=3Bnum_subbuf=2C +				$se=
lf-&gt=3Bswitch_timer_interval=2C<br>&gt=3B &gt=3B $self-&gt=3Bread_timer_i=
nterval=2C +				evout)=3B +			return &amp=3Btemp[0]=3B +		} +	} +}=3B <br>&=
gt=3B &gt=3B + +struct lttng_channel { +	char name[LTTNG_SYMBOL_NAME_LEN]=
=3B +	uint32_t<br>&gt=3B &gt=3B enabled=3B +	struct lttng_channel_attr attr=
=3B +	char<br>&gt=3B &gt=3B padding[LTTNG_CHANNEL_PADDING1]=3B + +	%extend =
{ + 		char *__repr__() { +<br>&gt=3B &gt=3B static char temp[512]=3B +			sp=
rintf(temp=2C "lttng.Channel=3B name('%s')=2C<br>&gt=3B &gt=3B enabled(%s)"=
=2C +				$self-&gt=3Bname=2C $self-&gt=3Benabled ? "True" : "False")=3B +<b=
r>&gt=3B &gt=3B return &amp=3Btemp[0]=3B +		} +	} +}=3B + +struct lttng_ses=
sion { +	char<br>&gt=3B &gt=3B name[NAME_MAX]=3B +	char path[PATH_MAX]=3B +=
	uint32_t enabled=3B +	char<br>&gt=3B &gt=3B padding[LTTNG_SESSION_PADDING1=
]=3B + +	%extend { + 		char *__repr__() { +<br>&gt=3B &gt=3B static char te=
mp[512]=3B +			sprintf(temp=2C "lttng.Session=3B name('%s')=2C<br>&gt=3B &g=
t=3B path('%s')=2C enabled(%s)"=2C +				$self-&gt=3Bname=2C $self-&gt=3Bpat=
h=2C +<br>&gt=3B &gt=3B $self-&gt=3Benabled ? "True" : "False")=3B +			retu=
rn &amp=3Btemp[0]=3B +		} +	} +}=3B diff<br>&gt=3B &gt=3B --git a/src/pytho=
n/tests/example.py b/src/python/tests/example.py new file<br>&gt=3B &gt=3B =
mode 100644 index 0000000..9703170 --- /dev/null +++<br>&gt=3B &gt=3B b/src=
/python/tests/example.py @@ -0=2C0 +1=2C109 @@ +#This example shows<br>&gt=
=3B &gt=3B basically how to use the lttng-tools python module + +from lttng=
 import * <br>&gt=3B &gt=3B + +# This error will be raised is something goe=
s wrong +class<br>&gt=3B &gt=3B LTTngError(Exception): +	def __init__(self=
=2C value): +		self.value =3D value +<br>&gt=3B &gt=3B def __str__(self): +=
		return repr(self.value) + +#Setting up the domain to<br>&gt=3B &gt=3B use=
 +dom =3D Domain() +dom.type =3D DOMAIN_KERNEL + +#Setting up a channel to<=
br>&gt=3B &gt=3B use +channel =3D Channel() +channel.name =3D "mychan" +cha=
nnel.attr.overwrite =3D<br>&gt=3B &gt=3B 0 +channel.attr.subbuf_size =3D 40=
96 +channel.attr.num_subbuf =3D 8 <br>&gt=3B &gt=3B +channel.attr.switch_ti=
mer_interval =3D 0 +channel.attr.read_timer_interval =3D<br>&gt=3B &gt=3B 2=
00 +channel.attr.output =3D EVENT_SPLICE + +#Setting up some events that<br=
>&gt=3B &gt=3B will be used +event =3D Event() +event.type =3D EVENT_TRACEP=
OINT <br>&gt=3B &gt=3B +event.loglevel_type =3D EVENT_LOGLEVEL_ALL + +sched=
_switch =3D Event() <br>&gt=3B &gt=3B +sched_switch.name =3D "sched_switch"=
 +sched_switch.type =3D EVENT_TRACEPOINT <br>&gt=3B &gt=3B +sched_switch.lo=
glevel_type =3D EVENT_LOGLEVEL_ALL + +sched_process_exit =3D<br>&gt=3B &gt=
=3B Event() +sched_process_exit.name =3D "sched_process_exit" <br>&gt=3B &g=
t=3B +sched_process_exit.type =3D EVENT_TRACEPOINT <br>&gt=3B &gt=3B +sched=
_process_exit.loglevel_type =3D EVENT_LOGLEVEL_ALL + <br>&gt=3B &gt=3B +sch=
ed_process_free =3D Event() +sched_process_free.name =3D<br>&gt=3B &gt=3B "=
sched_process_free" +sched_process_free.type =3D EVENT_TRACEPOINT <br>&gt=
=3B &gt=3B +sched_process_free.loglevel_type =3D EVENT_LOGLEVEL_ALL + + +#C=
reating a new<br>&gt=3B &gt=3B session +res =3D create("test"=2C"/lttng-tra=
ces/test") +if res&lt=3B0: +	raise<br>&gt=3B &gt=3B LTTngError(strerror(res=
)) + +#Creating handle +han =3D None +han =3D<br>&gt=3B &gt=3B Handle("test=
"=2C dom) +if han is None: +	raise LTTngError("Handle not<br>&gt=3B &gt=3B =
created") + +#Enabling the kernel channel +res =3D enable_channel(han=2C<br=
>&gt=3B &gt=3B channel) +if res&lt=3B0: +	raise LTTngError(strerror(res)) +=
 +#Enabling some<br>&gt=3B &gt=3B events in given channel +#To enable all e=
vents in default channel=2C use <br>&gt=3B &gt=3B +#enable_event(han=2C eve=
nt=2C None) +res =3D enable_event(han=2C sched_switch=2C<br>&gt=3B &gt=3B c=
hannel.name) +if res&lt=3B0: +	raise LTTngError(strerror(res)) + +res =3D<b=
r>&gt=3B &gt=3B enable_event(han=2C sched_process_exit=2C channel.name) +if=
 res&lt=3B0: +	raise<br>&gt=3B &gt=3B LTTngError(strerror(res)) + +res =3D =
enable_event(han=2C sched_process_free=2C<br>&gt=3B &gt=3B channel.name) +i=
f res&lt=3B0: +	raise LTTngError(strerror(res)) + +#Disabling an<br>&gt=3B =
&gt=3B event +res =3D disable_event(han=2C sched_switch.name=2C channel.nam=
e) +if<br>&gt=3B &gt=3B res&lt=3B0: +	raise LTTngError(strerror(res)) + +#G=
etting a list of the<br>&gt=3B &gt=3B channels +l =3D list_channels(han) +i=
f type(l) is int: +		raise<br>&gt=3B &gt=3B LTTngError(strerror(l)) + +#Sta=
rting the trace +res =3D start("test") +if<br>&gt=3B &gt=3B res&lt=3B0: +	r=
aise LTTngError(strerror(res)) + +#Stopping the trace +res =3D<br>&gt=3B &g=
t=3B stop("test") +if res&lt=3B0: +	raise LTTngError(strerror(res)) + +#Dis=
abling a<br>&gt=3B &gt=3B channel +res =3D disable_channel(han=2C channel.n=
ame) +if res&lt=3B0: +	raise<br>&gt=3B &gt=3B LTTngError(strerror(res)) + +=
#Destroying the handle +del han + +#Destroying<br>&gt=3B &gt=3B the session=
 +res =3D destroy("test") +if res&lt=3B0: +	raise<br>&gt=3B &gt=3B LTTngErr=
or(strerror(res)) diff --git a/src/python/tests/run.sh<br>&gt=3B &gt=3B b/s=
rc/python/tests/run.sh new file mode 100644 index 0000000..7de819b ---<br>&=
gt=3B &gt=3B /dev/null +++ b/src/python/tests/run.sh @@ -0=2C0 +1 @@ +pytho=
n tests.py diff<br>&gt=3B &gt=3B --git a/src/python/tests/tests.py b/src/py=
thon/tests/tests.py new file mode<br>&gt=3B &gt=3B 100644 index 0000000..a4=
be981 --- /dev/null +++<br>&gt=3B &gt=3B b/src/python/tests/tests.py @@ -0=
=2C0 +1=2C310 @@ +import unittest +import os <br>&gt=3B &gt=3B +import time=
 +from lttng import * + +class TestLttngPythonModule<br>&gt=3B &gt=3B (unit=
test.TestCase): + +	def test_kernel_all_events(self): +		dom =3D<br>&gt=3B =
&gt=3B Domain() +		dom.type =3D DOMAIN_KERNEL + +		event =3D Event() +		eve=
nt.type =3D<br>&gt=3B &gt=3B EVENT_TRACEPOINT +		event.loglevel_type =3D EV=
ENT_LOGLEVEL_ALL + +		han =3D<br>&gt=3B &gt=3B Handle("test_kernel_all_ev"=
=2C dom) + +		r =3D<br>&gt=3B &gt=3B create("test_kernel_all_ev"=2C"/lttng-=
traces/test") +<br>&gt=3B &gt=3B self.assertGreaterEqual(r=2C 0=2C strerror=
(r)) + +		r =3D enable_event(han=2C<br>&gt=3B &gt=3B event=2C None) +		self=
.assertGreaterEqual(r=2C 0=2C strerror(r)) + +		r =3D<br>&gt=3B &gt=3B star=
t("test_kernel_all_ev") +		self.assertGreaterEqual(r=2C 0=2C strerror(r)) +=
<br>&gt=3B &gt=3B time.sleep(2) + +		r =3D stop("test_kernel_all_ev") +<br>=
&gt=3B &gt=3B self.assertGreaterEqual(r=2C 0=2C strerror(r)) + +		r =3D<br>=
&gt=3B &gt=3B destroy("test_kernel_all_ev") +		self.assertGreaterEqual(r=2C=
 0=2C<br>&gt=3B &gt=3B strerror(r)) + + +	def test_kernel_event(self): + +	=
	dom =3D Domain() +<br>&gt=3B &gt=3B dom.type =3D DOMAIN_KERNEL + +		channe=
l =3D Channel() +		channel.name=3D"mychan" <br>&gt=3B &gt=3B +		channel.att=
r.overwrite =3D 0 +		channel.attr.subbuf_size =3D 4096 +<br>&gt=3B &gt=3B c=
hannel.attr.num_subbuf =3D 8 +		channel.attr.switch_timer_interval =3D 0 +<=
br>&gt=3B &gt=3B channel.attr.read_timer_interval =3D 200 +		channel.attr.o=
utput =3D<br>&gt=3B &gt=3B EVENT_SPLICE + +		sched_switch =3D Event() +		sc=
hed_switch.name =3D<br>&gt=3B &gt=3B "sched_switch" +		sched_switch.type =
=3D EVENT_TRACEPOINT +<br>&gt=3B &gt=3B sched_switch.loglevel_type =3D EVEN=
T_LOGLEVEL_ALL + +		sched_process_exit =3D<br>&gt=3B &gt=3B Event() +		sche=
d_process_exit.name =3D "sched_process_exit" +<br>&gt=3B &gt=3B sched_proce=
ss_exit.type =3D EVENT_TRACEPOINT +<br>&gt=3B &gt=3B sched_process_exit.log=
level_type =3D EVENT_LOGLEVEL_ALL + +<br>&gt=3B &gt=3B sched_process_free =
=3D Event() +		sched_process_free.name =3D<br>&gt=3B &gt=3B "sched_process_=
free" +		sched_process_free.type =3D EVENT_TRACEPOINT +<br>&gt=3B &gt=3B sc=
hed_process_free.loglevel_type =3D EVENT_LOGLEVEL_ALL + +		han =3D<br>&gt=
=3B &gt=3B Handle("test_kernel_event"=2C dom) + +		#Create session test +		=
r =3D<br>&gt=3B &gt=3B create("test_kernel_event"=2C"/lttng-traces/test") +=
<br>&gt=3B &gt=3B self.assertGreaterEqual(r=2C 0=2C strerror(r)) + +		#Enab=
ling channel tests +<br>&gt=3B &gt=3B r =3D enable_channel(han=2C channel) =
+		self.assertGreaterEqual(r=2C 0=2C<br>&gt=3B &gt=3B strerror(r)) + +		#En=
abling events tests +		r =3D enable_event(han=2C<br>&gt=3B &gt=3B sched_swi=
tch=2C channel.name) +		self.assertGreaterEqual(r=2C 0=2C strerror(r)) <br>=
&gt=3B &gt=3B + +		r =3D enable_event(han=2C sched_process_exit=2C channel.=
name) +<br>&gt=3B &gt=3B self.assertGreaterEqual(r=2C 0=2C strerror(r)) + +=
		r =3D enable_event(han=2C<br>&gt=3B &gt=3B sched_process_free=2C channel.=
name) +		self.assertGreaterEqual(r=2C 0=2C<br>&gt=3B &gt=3B strerror(r)) + =
+		#Disabling events tests +		r =3D disable_event(han=2C<br>&gt=3B &gt=3B s=
ched_switch.name=2C channel.name) +		self.assertGreaterEqual(r=2C 0=2C<br>&=
gt=3B &gt=3B strerror(r)) + +		r =3D disable_event(han=2C sched_process_fre=
e.name=2C<br>&gt=3B &gt=3B channel.name) +		self.assertGreaterEqual(r=2C 0=
=2C strerror(r)) + +		#Renabling<br>&gt=3B &gt=3B events tests +		r =3D ena=
ble_event(han=2C sched_switch=2C channel.name) +<br>&gt=3B &gt=3B self.asse=
rtGreaterEqual(r=2C 0=2C strerror(r)) + +		r =3D enable_event(han=2C<br>&gt=
=3B &gt=3B sched_process_free=2C channel.name) +		self.assertGreaterEqual(r=
=2C 0=2C<br>&gt=3B &gt=3B strerror(r)) + +		#Start=2C stop=2C destroy +		r =
=3D start("test_kernel_event") +<br>&gt=3B &gt=3B self.assertGreaterEqual(r=
=2C 0=2C strerror(r)) +		time.sleep(2) + +		r =3D<br>&gt=3B &gt=3B stop("te=
st_kernel_event") +		self.assertGreaterEqual(r=2C 0=2C strerror(r)) + +<br>=
&gt=3B &gt=3B r=3Ddisable_channel(han=2C channel.name) +		self.assertGreate=
rEqual(r=2C 0=2C<br>&gt=3B &gt=3B strerror(r)) + +		r=3Ddestroy("test_kerne=
l_event") +<br>&gt=3B &gt=3B self.assertGreaterEqual(r=2C 0=2C strerror(r))=
 + + + +	def<br>&gt=3B &gt=3B test_ust_all_events(self): +		dom =3D Domain(=
) +		dom.type =3D DOMAIN_UST + +<br>&gt=3B &gt=3B event =3D Event() +		even=
t.type =3D EVENT_TRACEPOINT +		event.loglevel_type =3D<br>&gt=3B &gt=3B EVE=
NT_LOGLEVEL_ALL + +		han =3D Handle("test_ust_all_ev"=2C dom) + +		r =3D<br=
>&gt=3B &gt=3B create("test_ust_all_ev"=2C"/lttng-traces/test") +<br>&gt=3B=
 &gt=3B self.assertGreaterEqual(r=2C 0=2C strerror(r)) + +		r =3D enable_ev=
ent(han=2C<br>&gt=3B &gt=3B event=2C None) +		self.assertGreaterEqual(r=2C =
0=2C strerror(r)) + +		r =3D<br>&gt=3B &gt=3B start("test_ust_all_ev") +		s=
elf.assertGreaterEqual(r=2C 0=2C strerror(r)) +<br>&gt=3B &gt=3B time.sleep=
(2) + +		r =3D stop("test_ust_all_ev") +<br>&gt=3B &gt=3B self.assertGreate=
rEqual(r=2C 0=2C strerror(r)) + +		r =3D<br>&gt=3B &gt=3B destroy("test_ust=
_all_ev") +		self.assertGreaterEqual(r=2C 0=2C strerror(r)) + <br>&gt=3B &g=
t=3B + +	def test_ust_event(self): + +		dom =3D Domain() +		dom.type =3D DO=
MAIN_UST <br>&gt=3B &gt=3B + +		channel =3D Channel() +		channel.name=3D"my=
chan" +		channel.attr.overwrite<br>&gt=3B &gt=3B =3D 0 +		channel.attr.subb=
uf_size =3D 4096 +		channel.attr.num_subbuf =3D 8 +<br>&gt=3B &gt=3B channe=
l.attr.switch_timer_interval =3D 0 +		channel.attr.read_timer_interval<br>&=
gt=3B &gt=3B =3D 200 +		channel.attr.output =3D EVENT_MMAP + +		ev1 =3D Eve=
nt() +		ev1.name =3D<br>&gt=3B &gt=3B "tp1" +		ev1.type =3D EVENT_TRACEPOIN=
T +		ev1.loglevel_type =3D<br>&gt=3B &gt=3B EVENT_LOGLEVEL_ALL + +		ev2 =3D=
 Event() +		ev2.name =3D "ev2" +		ev2.type =3D<br>&gt=3B &gt=3B EVENT_TRACE=
POINT +		ev2.loglevel_type =3D EVENT_LOGLEVEL_ALL + +		ev3 =3D<br>&gt=3B &g=
t=3B Event() +		ev3.name =3D "ev3" +		ev3.type =3D EVENT_TRACEPOINT +<br>&g=
t=3B &gt=3B ev3.loglevel_type =3D EVENT_LOGLEVEL_ALL + +		han =3D Handle("t=
est_ust_event"=2C<br>&gt=3B &gt=3B dom) + +		#Create session test +		r =3D<=
br>&gt=3B &gt=3B create("test_ust_event"=2C"/lttng-traces/test") +		self.as=
sertGreaterEqual(r=2C<br>&gt=3B &gt=3B 0=2C strerror(r)) + +		#Enabling cha=
nnel tests +		r =3D enable_channel(han=2C<br>&gt=3B &gt=3B channel) +		self=
.assertGreaterEqual(r=2C 0=2C strerror(r)) + +		#Enabling<br>&gt=3B &gt=3B =
events tests +		r =3D enable_event(han=2C ev1=2C channel.name) +<br>&gt=3B =
&gt=3B self.assertGreaterEqual(r=2C 0=2C strerror(r)) + +		r =3D enable_eve=
nt(han=2C ev2=2C<br>&gt=3B &gt=3B channel.name) +		self.assertGreaterEqual(=
r=2C 0=2C strerror(r)) + +		r =3D<br>&gt=3B &gt=3B enable_event(han=2C ev3=
=2C channel.name) +		self.assertGreaterEqual(r=2C 0=2C<br>&gt=3B &gt=3B str=
error(r)) + +		#Disabling events tests +		r =3D disable_event(han=2C<br>&gt=
=3B &gt=3B ev1.name=2C channel.name) +		self.assertGreaterEqual(r=2C 0=2C s=
trerror(r)) + +<br>&gt=3B &gt=3B r =3D disable_event(han=2C ev3.name=2C cha=
nnel.name) +<br>&gt=3B &gt=3B self.assertGreaterEqual(r=2C 0=2C strerror(r)=
) + +		#Renabling events tests +<br>&gt=3B &gt=3B r =3D enable_event(han=2C=
 ev1=2C channel.name) +		self.assertGreaterEqual(r=2C 0=2C<br>&gt=3B &gt=3B=
 strerror(r)) + +		r =3D enable_event(han=2C ev3=2C channel.name) +<br>&gt=
=3B &gt=3B self.assertGreaterEqual(r=2C 0=2C strerror(r)) + +		#Start=2C st=
op +		r =3D<br>&gt=3B &gt=3B start("test_ust_event") +		self.assertGreaterE=
qual(r=2C 0=2C strerror(r)) +<br>&gt=3B &gt=3B time.sleep(2) + +		r =3D sto=
p("test_ust_event") +		self.assertGreaterEqual(r=2C<br>&gt=3B &gt=3B 0=2C s=
trerror(r)) + +		#Restart/restop +		r =3D start("test_ust_event") +<br>&gt=
=3B &gt=3B self.assertGreaterEqual(r=2C 0=2C strerror(r)) +		time.sleep(2) =
+ +		r =3D<br>&gt=3B &gt=3B stop("test_ust_event") +		self.assertGreaterEqu=
al(r=2C 0=2C strerror(r)) + +<br>&gt=3B &gt=3B #Disabling channel and destr=
oy +		r=3Ddisable_channel(han=2C channel.name) +<br>&gt=3B &gt=3B self.asse=
rtGreaterEqual(r=2C 0=2C strerror(r)) + +<br>&gt=3B &gt=3B r=3Ddestroy("tes=
t_ust_event") +		self.assertGreaterEqual(r=2C 0=2C strerror(r)) <br>&gt=3B =
&gt=3B + + +	def test_other_functions(self): +		dom =3D Domain() +<br>&gt=
=3B &gt=3B dom.type=3DDOMAIN_KERNEL + +		event=3DEvent() +		event.type=3DEV=
ENT_TRACEPOINT +<br>&gt=3B &gt=3B event.loglevel_type=3DEVENT_LOGLEVEL_ALL =
+ +		calib =3D Calibrate() +<br>&gt=3B &gt=3B calib.type =3D CALIBRATE_FUNC=
TION + +		ctx =3D EventContext() +<br>&gt=3B &gt=3B ctx.type=3DEVENT_CONTEX=
T_PID + +		chattr =3D ChannelAttr() +		chattr.overwrite<br>&gt=3B &gt=3B =
=3D 0 +		chattr.subbuf_size =3D 4096 +		chattr.num_subbuf =3D 8 +<br>&gt=3B=
 &gt=3B chattr.switch_timer_interval =3D 0 +		chattr.read_timer_interval =
=3D 200 +<br>&gt=3B &gt=3B chattr.output =3D EVENT_SPLICE + +		han =3D Hand=
le("test_otherf" =2C dom) + +		r<br>&gt=3B &gt=3B =3D create("test_otherf"=
=2C"/lttng-traces/test") +		self.assertGreaterEqual(r=2C<br>&gt=3B &gt=3B 0=
=2C strerror(r)) + +		r =3D enable_event(han=2C event=2C None) +<br>&gt=3B =
&gt=3B self.assertGreaterEqual(r=2C 0=2C strerror(r)) + +		#Calibrate test =
+		r =3D<br>&gt=3B &gt=3B calibrate(han =2C calib) +		self.assertGreaterEqu=
al(r=2C 0=2C strerror(r)) + +<br>&gt=3B &gt=3B #Context test +		r =3D add_c=
ontext(han=2C ctx=2C "sched_switch"=2C "channel0") +<br>&gt=3B &gt=3B self.=
assertGreaterEqual(r=2C 0=2C strerror(r)) +		#Any channel +		r =3D<br>&gt=
=3B &gt=3B add_context(han=2C ctx=2C "sched_wakeup"=2C None) +		self.assert=
GreaterEqual(r=2C<br>&gt=3B &gt=3B 0=2C strerror(r)) +		#All events +		r =
=3D add_context(han=2C ctx=2C None=2C None) +<br>&gt=3B &gt=3B self.assertG=
reaterEqual(r=2C 0=2C strerror(r)) + +		#Def. channel attr +<br>&gt=3B &gt=
=3B channel_set_default_attr(dom=2C chattr) +		channel_set_default_attr(Non=
e=2C<br>&gt=3B &gt=3B None) + +		#Ses Daemon alive +		r =3D session_daemon_=
alive() +<br>&gt=3B &gt=3B self.assertTrue(r =3D=3D 1 or r =3D=3D 0=2C stre=
rror(r)) + +		#Setting trace group +<br>&gt=3B &gt=3B r =3D set_tracing_gro=
up("testing") +		self.assertGreaterEqual(r=2C 0=2C<br>&gt=3B &gt=3B strerro=
r(r)) + + +		r =3D start("test_otherf") +		self.assertGreaterEqual(r=2C<br>=
&gt=3B &gt=3B 0=2C strerror(r)) +		time.sleep(2) + +		r =3D stop("test_othe=
rf") +<br>&gt=3B &gt=3B self.assertGreaterEqual(r=2C 0=2C strerror(r)) + +	=
	del han + +		r =3D<br>&gt=3B &gt=3B destroy("test_otherf") +		self.assertG=
reaterEqual(r=2C 0=2C strerror(r)) + + <br>&gt=3B &gt=3B +if __name__ =3D=
=3D "__main__": +	# CHECK IF ROOT +	if os.geteuid() =3D=3D 0: +<br>&gt=3B &=
gt=3B #Make sure session names don't already exist: +<br>&gt=3B &gt=3B dest=
roy("test_kernel_event") +		destroy("test_kernel_all_events") +<br>&gt=3B &=
gt=3B destroy("test_ust_all_events") +		destroy("test_ust_event") +<br>&gt=
=3B &gt=3B destroy("test_otherf") + +		unittest.main() +	else: +		print('Sc=
ript must<br>&gt=3B &gt=3B be run as root')<br>&gt=3B -----BEGIN PGP SIGNAT=
URE-----<br>&gt=3B Version: GnuPG v1.4.12 (GNU/Linux)<br>&gt=3B <br>&gt=3B =
iQEcBAEBAgAGBQJQGCc4AAoJEELoaioR9I02f68IAKCipHU8psxIkXyUECveu57F<br>&gt=3B =
1ZPe9wzanUrb5eaiLH07mmbVJf/1Bu08eLfiuu1naaV0ZZIa2DenTXHcuC4orGbE<br>&gt=3B =
/8KVBYidgDWIzY8lJOnw6wg+zB2ibnfTqtyhNE9Rqgesq6o776QfFgSkqzfQq/2m<br>&gt=3B =
BxOsE1jKzx6JbgdquO32KBAyQAgyQu8Z9aJUYgAd3peqrx19pwnWhgnY88rtAzNi<br>&gt=3B =
5ktGj6btK4HAcQ62Q8pmTTaOR0y5sBb7STDYF2pcNMPU3TeLBjkRhl/djva0C7t/<br>&gt=3B =
hPiL8IVT4AYC0y72Oof0kuSgaGIyHAxujAGHeOnOQP3KXhAvrow/bhJodbIo3pU=3D<br>&gt=
=3B =3DlEVV<br>&gt=3B -----END PGP SIGNATURE-----<br></div> 		 	   		  </di=
v></body>
</html>=

--_bcc428a7-6e0a-442d-90c4-5194ad73a6e7_--


--===============0329447577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0329447577==--
