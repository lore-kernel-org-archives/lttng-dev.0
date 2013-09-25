From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] trace: drop LTTng Userspace Tracer backend
Date: Wed, 25 Sep 2013 11:28:39 +0200
Message-ID: <1380101319-29435-1-git-send-email-stefanha@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: qemu-devel@nongnu.org
Cc: lttng-dev@lists.lttng.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: lttng-dev@lists.lttng.org

The current LTTng Userspace Tracer backend does not build against modern
libraries.  LTTng has changed the library ABI several times, making it
difficult to support this backend.

Due to lack of users, remove this trace backend until someone turns up
who is willing to actively maintain it.

Details for anyone wishing to contribute an updated backend:

 * Header files have been renamed from <ust/*> to <lttng/*>
 * Tracepoint macros are no longer DECLARE_TRACE(name, TP_PROTO(args),
   TP_ARGS(argnames))
 * Probably more breakage

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 configure                        | 19 --------
 docs/tracing.txt                 | 11 +----
 scripts/tracetool/backend/ust.py | 93 ----------------------------------=
------
 3 files changed, 2 insertions(+), 121 deletions(-)
 delete mode 100644 scripts/tracetool/backend/ust.py

diff --git a/configure b/configure
index 05e16da..95a8a4f 100755
--- a/configure
+++ b/configure
@@ -3280,22 +3280,6 @@ if test "$?" -ne 0 ; then
 fi
=20
 ##########################################
-# For 'ust' backend, test if ust headers are present
-if test "$trace_backend" =3D "ust"; then
-  cat > $TMPC << EOF
-#include <ust/tracepoint.h>
-#include <ust/marker.h>
-int main(void) { return 0; }
-EOF
-  if compile_prog "" "" ; then
-    LIBS=3D"-lust -lurcu-bp $LIBS"
-    libs_qga=3D"-lust -lurcu-bp $libs_qga"
-  else
-    error_exit "Trace backend 'ust' missing libust header files"
-  fi
-fi
-
-##########################################
 # For 'dtrace' backend, test if 'dtrace' command is present
 if test "$trace_backend" =3D "dtrace"; then
   if ! has 'dtrace' ; then
@@ -4191,9 +4175,6 @@ if test "$trace_backend" =3D "stderr"; then
   echo "CONFIG_TRACE_STDERR=3Dy" >> $config_host_mak
   trace_default=3Dno
 fi
-if test "$trace_backend" =3D "ust"; then
-  echo "CONFIG_TRACE_UST=3Dy" >> $config_host_mak
-fi
 if test "$trace_backend" =3D "dtrace"; then
   echo "CONFIG_TRACE_DTRACE=3Dy" >> $config_host_mak
   if test "$trace_backend_stap" =3D "yes" ; then
diff --git a/docs/tracing.txt b/docs/tracing.txt
index bfc261b..3d0d620 100644
--- a/docs/tracing.txt
+++ b/docs/tracing.txt
@@ -135,9 +135,8 @@ the following monitor command:
=20
 The "tracetool" script automates tedious trace event code generation and=
 also
 keeps the trace event declarations independent of the trace backend.  Th=
e trace
-events are not tightly coupled to a specific trace backend, such as LTTn=
g or
-SystemTap.  Support for trace backends can be added by extending the "tr=
acetool"
-script.
+events are not tightly coupled to a specific trace backend, such as Syst=
emTap.
+Support for trace backends can be added by extending the "tracetool" scr=
ipt.
=20
 The trace backend is chosen at configure time and only one trace backend=
 can
 be built into the binary:
@@ -208,12 +207,6 @@ You must ensure that the same "trace-events" file wa=
s used to build QEMU,
 otherwise trace event declarations may have changed and output will not =
be
 consistent.
=20
-=3D=3D=3D LTTng Userspace Tracer =3D=3D=3D
-
-The "ust" backend uses the LTTng Userspace Tracer library.  There are no
-monitor commands built into QEMU, instead UST utilities should be used t=
o list,
-enable/disable, and dump traces.
-
 =3D=3D=3D SystemTap =3D=3D=3D
=20
 The "dtrace" backend uses DTrace sdt probes but has only been tested wit=
h
diff --git a/scripts/tracetool/backend/ust.py b/scripts/tracetool/backend=
/ust.py
deleted file mode 100644
index ea36995..0000000
--- a/scripts/tracetool/backend/ust.py
+++ /dev/null
@@ -1,93 +0,0 @@
-#!/usr/bin/env python
-# -*- coding: utf-8 -*-
-
-"""
-LTTng User Space Tracing backend.
-"""
-
-__author__     =3D "Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>"
-__copyright__  =3D "Copyright 2012, Llu=C3=ADs Vilanova <vilanova@ac.upc=
.edu>"
-__license__    =3D "GPL version 2 or (at your option) any later version"
-
-__maintainer__ =3D "Stefan Hajnoczi"
-__email__      =3D "stefanha@linux.vnet.ibm.com"
-
-
-from tracetool import out
-
-
-PUBLIC =3D True
-
-
-def c(events):
-    out('#include <ust/marker.h>',
-        '#undef mutex_lock',
-        '#undef mutex_unlock',
-        '#undef inline',
-        '#undef wmb',
-        '#include "trace.h"')
-
-    for e in events:
-        argnames =3D ", ".join(e.args.names())
-        if len(e.args) > 0:
-            argnames =3D ', ' + argnames
-
-            out('DEFINE_TRACE(ust_%(name)s);',
-                '',
-                'static void ust_%(name)s_probe(%(args)s)',
-                '{',
-                '    trace_mark(ust, %(name)s, %(fmt)s%(argnames)s);',
-                '}',
-                name =3D e.name,
-                args =3D e.args,
-                fmt =3D e.fmt,
-                argnames =3D argnames,
-                )
-
-        else:
-            out('DEFINE_TRACE(ust_%(name)s);',
-                '',
-                'static void ust_%(name)s_probe(%(args)s)',
-                '{',
-                '    trace_mark(ust, %(name)s, UST_MARKER_NOARGS);',
-                '}',
-                name =3D e.name,
-                args =3D e.args,
-                )
-
-    # register probes
-    out('',
-        'static void __attribute__((constructor)) trace_init(void)',
-        '{')
-
-    for e in events:
-        out('    register_trace_ust_%(name)s(ust_%(name)s_probe);',
-            name =3D e.name,
-            )
-
-    out('}')
-
-
-def h(events):
-    out('#include <ust/tracepoint.h>',
-        '#undef mutex_lock',
-        '#undef mutex_unlock',
-        '#undef inline',
-        '#undef wmb')
-
-    for e in events:
-        if len(e.args) > 0:
-            out('DECLARE_TRACE(ust_%(name)s, TP_PROTO(%(args)s), TP_ARGS=
(%(argnames)s));',
-                '#define trace_%(name)s trace_ust_%(name)s',
-                name =3D e.name,
-                args =3D e.args,
-                argnames =3D ", ".join(e.args.names()),
-                )
-
-        else:
-            out('_DECLARE_TRACEPOINT_NOARGS(ust_%(name)s);',
-                '#define trace_%(name)s trace_ust_%(name)s',
-                name =3D e.name,
-                )
-
-    out()
--=20
1.8.3.1
