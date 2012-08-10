From: Danny Serres <danny.serres@efficios.com>
Subject: [lttng-ust PATCH] Python module
Date: Fri, 10 Aug 2012 13:42:35 -0400
Message-ID: <1344620555-4776-1-git-send-email-danny.serres__30608.6109522314$1344620599$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <danny.serres@efficios.com>) id 1SztEL-0006tY-F6
	for lttng-dev@lists.lttng.org; Fri, 10 Aug 2012 13:42:37 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Danny Serres <danny.serres@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Proof of concept:
A simple library to create tracepoints and allow
tracing in Python programs.

To build, configure with Python:
  ./configure --with-python

To use, import the module in Python:
  import lttngust

Signed-off-by: Danny Serres <danny.serres@efficios.com>
---
 Makefile.am                     |    4 +
 README                          |    4 +
 configure.ac                    |   31 ++++++
 liblttng-ust-python/Makefile.am |   13 +++
 liblttng-ust-python/README      |    8 ++
 liblttng-ust-python/lttngust.c  |  198 +++++++++++++++++++++++++++++++++++++++
 liblttng-ust-python/lttngust.h  |  103 ++++++++++++++++++++
 7 files changed, 361 insertions(+)
 create mode 100644 liblttng-ust-python/Makefile.am
 create mode 100644 liblttng-ust-python/README
 create mode 100644 liblttng-ust-python/lttngust.c
 create mode 100644 liblttng-ust-python/lttngust.h

diff --git a/Makefile.am b/Makefile.am
index e61735d..d43aeab 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -13,6 +13,10 @@ if BUILD_JNI_INTERFACE
 SUBDIRS += liblttng-ust-java
 endif
 
+if USE_PYTHON
+SUBDIRS += liblttng-ust-python
+endif
+
 #temporarily disabled
 # liblttng-ust-malloc
 
diff --git a/README b/README
index 55c72df..c9a455d 100644
--- a/README
+++ b/README
@@ -170,3 +170,7 @@ PACKAGE CONTENTS:
   - liblttng-ust-java
     A simple library that uses JNI to allow tracing in java programs.
     See liblttng-ust-java/README for build instructions.
+
+  - liblttng-ust-python
+    A simple library to allow tracing in Python programs.
+    See liblttng-ust-python/README for build instructions.
diff --git a/configure.ac b/configure.ac
index 4d40f75..e85bd0d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -144,6 +144,33 @@ AC_CHECK_LIB([urcu-bp], [synchronize_rcu_bp], [], [AC_MSG_ERROR([Cannot find lib
 AC_CHECK_LIB([urcu-bp], [call_rcu_bp], [], [AC_MSG_ERROR([liburcu 0.6 or newer is needed, please update your version or use [LDFLAGS]=-Ldir to specify the right location.])])
 
 
+# For Python
+AC_ARG_WITH([python],
+              [AS_HELP_STRING([--with-python],
+                              [compile with Python bindings])],
+              [enable_python=yes], [enable_python=no])
+
+AM_CONDITIONAL([USE_PYTHON], [test "x${enable_python:-yes}" = xyes])
+
+if test "x${enable_python:-yes}" = xyes; then
+  AM_PATH_PYTHON
+
+  AC_ARG_VAR([PYTHON_INCLUDE], [Include flags for python, bypassing python-config])
+  AC_ARG_VAR([PYTHON_CONFIG], [Path to python-config])
+  AS_IF([test -z "$PYTHON_INCLUDE"], [
+    AS_IF([test -z "$PYTHON_CONFIG"], [
+      AC_PATH_PROGS([PYTHON_CONFIG],
+                    [python$PYTHON_VERSION-config python-config],
+                    [no],
+                    [`dirname $PYTHON`])
+      AS_IF([test "$PYTHON_CONFIG" = no], [AC_MSG_ERROR([cannot find python-config for $PYTHON.])])
+    ])
+    AC_MSG_CHECKING([python include flags])
+    PYTHON_INCLUDE=`$PYTHON_CONFIG --includes`
+    AC_MSG_RESULT([$PYTHON_INCLUDE])
+  ])
+fi
+
 # Check for various supplementary host information (beyond the
 # triplet) which might affect the library format choices.  E.g., we
 # can be building with `i686-unknown-linux-gnu-gcc -m64'
@@ -300,6 +327,7 @@ AC_CONFIG_FILES([
 	liblttng-ust-fork/Makefile
 	liblttng-ust-java/Makefile
 	liblttng-ust-libc-wrapper/Makefile
+	liblttng-ust-python/Makefile
 	tools/Makefile
 	tests/Makefile
 	tests/hello/Makefile
@@ -327,6 +355,9 @@ AS_ECHO()
 AS_ECHO_N("Java support (JNI): ")
 AS_IF([test "x$jni_interface" = "xyes"], [AS_ECHO("Enabled")], [AS_ECHO("Disabled")])
 
+AS_ECHO_N("Python support:     ")
+AS_IF([test "x$enable_python" = "xyes"], [AS_ECHO("Enabled")], [AS_ECHO("Disabled")])
+
 AS_ECHO_N("sdt.h integration:  ")
 AS_IF([test "x$with_sdt" = "xyes"], [AS_ECHO("Enabled")], [AS_ECHO("Disabled")])
 
diff --git a/liblttng-ust-python/Makefile.am b/liblttng-ust-python/Makefile.am
new file mode 100644
index 0000000..993e0b9
--- /dev/null
+++ b/liblttng-ust-python/Makefile.am
@@ -0,0 +1,13 @@
+AM_CFLAGS = -I$(PYTHON_INCLUDE) -I$(top_srcdir)/include/
+
+pyexec_LTLIBRARIES = lttngust.la
+
+MAINTAINERCLEANFILES = lttngust.c
+
+lttngust_la_SOURCES = lttngust.c
+
+lttngust_la_LDFLAGS = -module
+
+lttngust_la_CFLAGS = $(AM_CFLAGS)
+
+lttngust_la_LIBADD = -lc -L$(top_builddir)/liblttng-ust/.libs ../liblttng-ust/liblttng-ust.la
diff --git a/liblttng-ust-python/README b/liblttng-ust-python/README
new file mode 100644
index 0000000..405ef62
--- /dev/null
+++ b/liblttng-ust-python/README
@@ -0,0 +1,8 @@
+This directory contains a simple API for instrumenting Python applications.
+
+Configuration to build this library:
+
+	./configure --with-python
+
+After building, you can use the generated module in a
+Python project ('import lttngust').
diff --git a/liblttng-ust-python/lttngust.c b/liblttng-ust-python/lttngust.c
new file mode 100644
index 0000000..39ecb1d
--- /dev/null
+++ b/liblttng-ust-python/lttngust.c
@@ -0,0 +1,198 @@
+#define TRACEPOINT_DEFINE
+#define TRACEPOINT_CREATE_PROBES
+
+#include <Python.h>
+#include "lttngust.h"
+
+/* Tracepoint with int value */
+static PyObject *
+lttngust_tracepointInt(PyObject *self, PyObject *args)
+{
+	const char *name;
+	int val;
+
+	if (!PyArg_ParseTuple(args, "si", &name, &val))
+		return NULL;
+	tracepoint(lttngust_python, int_event, name, val);
+
+	Py_INCREF(Py_None);
+	return Py_None;
+}
+
+/* Tracepoint with long value */
+static PyObject *
+lttngust_tracepointLong(PyObject *self, PyObject *args)
+{
+	const char *name;
+	long val;
+
+	if (!PyArg_ParseTuple(args, "sl", &name, &val))
+		return NULL;
+	tracepoint(lttngust_python, long_event, name, val);
+
+	Py_INCREF(Py_None);
+	return Py_None;
+}
+
+/* Tracepoint with string value */
+static PyObject *
+lttngust_tracepointString(PyObject *self, PyObject *args)
+{
+	const char *name;
+	const char *val;
+
+	if (!PyArg_ParseTuple(args, "ss", &name, &val))
+		return NULL;
+	tracepoint(lttngust_python, string_event, name, val);
+
+	Py_INCREF(Py_None);
+	return Py_None;
+}
+
+/* Tracepoint with double value */
+static PyObject *
+lttngust_tracepointDouble(PyObject *self, PyObject *args)
+{
+	const char *name;
+	double val;
+
+	if (!PyArg_ParseTuple(args, "sd", &name, &val))
+		return NULL;
+	tracepoint(lttngust_python, double_event, name, val);
+
+	Py_INCREF(Py_None);
+	return Py_None;
+}
+
+/* Tracepoint with complex object value */
+static PyObject *
+lttngust_tracepointComplex(PyObject *self, PyObject *args)
+{
+	const char *name;
+	Py_complex complex;
+	char val[256];
+
+	if (!PyArg_ParseTuple(args, "sD", &name, &complex))
+		return NULL;
+	sprintf(val, "%g+%gj", complex.real, complex.imag);
+	tracepoint(lttngust_python, complex_event, name, val);
+
+	Py_INCREF(Py_None);
+	return Py_None;
+}
+
+/* Tracepoint with bool(object) value */
+static PyObject *
+lttngust_tracepointBool(PyObject *self, PyObject *args)
+{
+	const char *name;
+	PyObject *obj;
+	char *val;
+
+
+	if (!PyArg_ParseTuple(args, "sO", &name, &obj))
+		return NULL;
+
+	if (PyObject_IsTrue(obj))
+		val = "True";
+	else
+		val = "False";
+
+	tracepoint(lttngust_python, bool_event, name, val);
+
+	Py_INCREF(Py_None);
+	return Py_None;
+}
+
+/* Tracepoint with repr(object) value */
+static PyObject *
+lttngust_tracepointRepr(PyObject *self, PyObject *args)
+{
+	const char *name;
+	PyObject *obj;
+	const char *repr;
+
+	if (!PyArg_ParseTuple(args, "sO", &name, &obj))
+		return NULL;
+
+	repr = PyString_AsString(PyObject_Repr(obj));
+	tracepoint(lttngust_python, obj_repr, name, repr);
+
+	Py_INCREF(Py_None);
+	return Py_None;
+}
+
+/* Tracepoint with message, loglevel TRACE_INFO */
+static PyObject *
+lttngust_tracepointMessage(PyObject *self, PyObject *args)
+{
+	const char *text;
+
+	if (!PyArg_ParseTuple(args, "s", &text))
+		return NULL;
+	tracepoint(lttngust_python, message, text);
+
+	Py_INCREF(Py_None);
+	return Py_None;
+}
+
+/* Tracepoint with warning, loglevel TRACE_WARNING */
+static PyObject *
+lttngust_tracepointWarning(PyObject *self, PyObject *args)
+{
+	const char *text;
+
+	if (!PyArg_ParseTuple(args, "s", &text))
+		return NULL;
+	tracepoint(lttngust_python, warning, text);
+
+	Py_INCREF(Py_None);
+	return Py_None;
+}
+
+
+/* Definition of Python methods */
+static PyMethodDef UstMethods[] = {
+
+	{"tracepointInt",  lttngust_tracepointInt, METH_VARARGS,
+		"tracepointInt(name, value)\n\nTracepoint with Int value."},
+
+	{"tracepointLong",  lttngust_tracepointLong, METH_VARARGS,
+		"tracepointLong(name, value)\n\nTracepoint with Long value."},
+
+	{"tracepointDouble",  lttngust_tracepointDouble, METH_VARARGS,
+		"tracepointDouble(name, value)\n\n"
+		"Tracepoint with Double value."},
+
+	{"tracepointComplex",  lttngust_tracepointComplex, METH_VARARGS,
+		"tracepointComplex(name, complex_number)\n\n"
+		"Tracepoint with Complex number value."},
+
+	{"tracepointString",  lttngust_tracepointString, METH_VARARGS,
+		"tracepointString(name, value)\n\n"
+		"Tracepoint with String value."},
+
+	{"tracepointBool",  lttngust_tracepointBool, METH_VARARGS,
+		"tracepointBool(name, object)\n\n"
+		"Tracepoint with Object value, uses bool()."},
+
+	{"tracepointRepr",  lttngust_tracepointRepr, METH_VARARGS,
+		"tracepointRepr(name, object)\n\n"
+		"Tracepoint with Object value, uses repr()."},
+
+	{"tracepointMessage",  lttngust_tracepointMessage, METH_VARARGS,
+		"tracepointMessage(text)\n\nTracepoint with string info."},
+
+	{"tracepointWarning",  lttngust_tracepointWarning, METH_VARARGS,
+		"tracepointWarning(text)\n\nTracepoint with string warning."},
+
+	{NULL, NULL, 0, NULL}        /* Sentinel */
+};
+
+
+/* Init module */
+PyMODINIT_FUNC
+initlttngust(void)
+{
+	(void) Py_InitModule("lttngust", UstMethods);
+}
diff --git a/liblttng-ust-python/lttngust.h b/liblttng-ust-python/lttngust.h
new file mode 100644
index 0000000..f668ee1
--- /dev/null
+++ b/liblttng-ust-python/lttngust.h
@@ -0,0 +1,103 @@
+#undef TRACEPOINT_PROVIDER
+#define TRACEPOINT_PROVIDER lttngust_python
+
+#undef TRACEPOINT_INCLUDE_FILE
+#define TRACEPOINT_INCLUDE_FILE ./lttngust.h
+
+#ifdef __cplusplus
+extern "C"{
+#endif /* __cplusplus */
+
+#if !defined(_lttngust_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
+#define _lttngust_H
+
+#include <lttng/tracepoint.h>
+
+/* Tracepoint with int value */
+TRACEPOINT_EVENT(lttngust_python, int_event,
+	TP_ARGS(const char *, name, int, val),
+	TP_FIELDS(
+		ctf_string(name, name)
+		ctf_integer(int, value, val)
+	)
+)
+
+/* Tracepoint with long value */
+TRACEPOINT_EVENT(lttngust_python, long_event,
+	TP_ARGS(const char *, name, long, val),
+	TP_FIELDS(
+		ctf_string(name, name)
+		ctf_integer(int, value, val)
+	)
+)
+
+/* Tracepoint with string value */
+TRACEPOINT_EVENT(lttngust_python, string_event,
+	TP_ARGS(const char *, name, const char *, val),
+	TP_FIELDS(
+		ctf_string(name, name)
+		ctf_string(value, val)
+	)
+)
+
+/* Tracepoint with double value */
+TRACEPOINT_EVENT(lttngust_python, double_event,
+	TP_ARGS(const char *, name, double, val),
+	TP_FIELDS(
+		ctf_string(name, name)
+		ctf_float(double, value, val)
+	)
+)
+
+/* Tracepoint with complex object value */
+TRACEPOINT_EVENT(lttngust_python, complex_event,
+	TP_ARGS(const char *, name, char *, val),
+	TP_FIELDS(
+		ctf_string(name, name)
+		ctf_string(value, val)
+	)
+)
+
+/* Tracepoint with bool(object) value */
+TRACEPOINT_EVENT(lttngust_python, bool_event,
+	TP_ARGS(const char *, name, char *, val),
+	TP_FIELDS(
+		ctf_string(name, name)
+		ctf_string(value, val)
+	)
+)
+
+/* Tracepoint with repr(object) value */
+TRACEPOINT_EVENT(lttngust_python, obj_repr,
+	TP_ARGS(const char *, name, const char *, repr),
+	TP_FIELDS(
+		ctf_string(name, name)
+		ctf_string(repr, repr)
+	)
+)
+
+/* Tracepoint with message, loglevel TRACE_INFO */
+TRACEPOINT_EVENT(lttngust_python, message,
+	TP_ARGS(const char *, text),
+	TP_FIELDS(
+		ctf_string(message, text)
+	)
+)
+TRACEPOINT_LOGLEVEL(lttngust_python, message, TRACE_INFO)
+
+/* Tracepoint with warning, loglevel TRACE_WARNING */
+TRACEPOINT_EVENT(lttngust_python, warning,
+	TP_ARGS(const char *, text),
+	TP_FIELDS(
+		ctf_string(message, text)
+	)
+)
+TRACEPOINT_LOGLEVEL(lttngust_python, warning, TRACE_WARNING)
+
+#endif /* _lttngust_H */
+
+#include <lttng/tracepoint-event.h>
+
+#ifdef __cplusplus
+}
+#endif /* __cplusplus */
-- 
1.7.9.5
