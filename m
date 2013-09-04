From: Zifei Tong <soariez@gmail.com>
Subject: [RFC PATCH lttng-tools 2/2] Implement dynamic
	instrumentation with dyninst
Date: Wed,  4 Sep 2013 19:00:41 +0800
Message-ID: <1378292441-18272-2-git-send-email-soariez__43534.8695646555$1378292589$gmane$org@gmail.com>
References: <CAJ7wx-EDBibZ-MO7pWfGGBdx+2yzN7pENpWpEoWAj7r5hDSGSA@mail.gmail.com>
	<1378292441-18272-1-git-send-email-soariez@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <soariez@gmail.com>) id 1VHAqC-0001QY-GF
	for lttng-dev@lists.lttng.org; Wed, 04 Sep 2013 07:01:44 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so141335pbc.29
	for <lttng-dev@lists.lttng.org>; Wed, 04 Sep 2013 04:01:34 -0700 (PDT)
In-Reply-To: <1378292441-18272-1-git-send-email-soariez@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This patch provides a *very* basic implementation of dynamic
instrumentation support using dyninst library. More tests and
refactoring need to be done.

An explicit type conversion added in rculfhash-internal.h to make the
code compile with C++ compilers.

Macros _GNU_SOURCE are wrapped with guards to bypass g++ warning:
"_GNU_SOURCE" redefined

Automake will choose g++ as linker if a c++ source file appears in the
SOURCES list conditionally regardless the actually value of condition
variable. This will prevent lttng-tools compiling without a c++ compiler.
Thus we should manually choose a proper linker in Makefile.am.

See: http://permalink.gmane.org/gmane.comp.sysutils.automake.bugs/4184

You can also view the patch at:
https://github.com/5kg/lttng-tools/commit/fc2ca02a6915a4da513d47c7386e4a13f6629538
---
 configure.ac                                      |  16 +++
 src/bin/lttng-sessiond/Makefile.am                |  12 ++
 src/bin/lttng-sessiond/ust-instrument-dyninst.cpp | 142 ++++++++++++++++++++++
 src/common/hashtable/rculfhash-internal.h         |   2 +-
 src/common/sessiond-comm/inet.h                   |   2 +
 src/common/sessiond-comm/inet6.h                  |   2 +
 src/common/sessiond-comm/sessiond-comm.h          |   2 +
 src/common/sessiond-comm/unix.h                   |   2 +
 tests/unit/Makefile.am                            |   9 ++
 9 files changed, 188 insertions(+), 1 deletion(-)
 create mode 100644 src/bin/lttng-sessiond/ust-instrument-dyninst.cpp

diff --git a/configure.ac b/configure.ac
index 32efa93..f616465 100644
--- a/configure.ac
+++ b/configure.ac
@@ -293,8 +293,24 @@ AX_CONFIG_FEATURE(
 )
 AM_CONDITIONAL([COMPAT_EPOLL], [ test "$enable_epoll" = "yes" ])
 
+# Option to build with dyninst
+# TODO: support custom prefix
+AC_ARG_WITH([dyninst],
+	AS_HELP_STRING([--with-dyninst],[Build with dyninst library [default=no]]),
+	[has_dyninst=$withval],
+	[has_dyninst=no])
+
+# TODO: check library and header
+AS_IF([test "x$has_dyninst" != "xno"], [
+	AC_DEFINE([HAVE_DYNINST], [1], [has dyninst library])
+	AC_DEFINE([HAVE_UST_INSTRUMENT_PROBE], [1], [have ust instrument probe])
+	build_with_dyninst=yes
+])
+AM_CONDITIONAL([HAVE_DYNINST], [test "x$build_with_dyninst" = "xyes"])
+
 AC_SYS_LARGEFILE
 AC_PROG_CC
+AC_PROG_CXX
 LT_INIT
 AC_PROG_YACC
 AC_PROG_LEX
diff --git a/src/bin/lttng-sessiond/Makefile.am b/src/bin/lttng-sessiond/Makefile.am
index dce17cb..4d6779c 100644
--- a/src/bin/lttng-sessiond/Makefile.am
+++ b/src/bin/lttng-sessiond/Makefile.am
@@ -33,6 +33,9 @@ if HAVE_LIBLTTNG_UST_CTL
 lttng_sessiond_SOURCES += trace-ust.c ust-registry.c ust-app.c \
 			ust-consumer.c ust-consumer.h ust-thread.c \
 			ust-metadata.c ust-clock.h
+if HAVE_DYNINST
+lttng_sessiond_SOURCES += ust-instrument-dyninst.cpp
+endif
 endif
 
 # Add main.c at the end for compile order
@@ -51,4 +54,13 @@ lttng_sessiond_LDADD = -lrt -lurcu-common -lurcu \
 
 if HAVE_LIBLTTNG_UST_CTL
 lttng_sessiond_LDADD += -llttng-ust-ctl
+if HAVE_DYNINST
+lttng_sessiond_LDADD += -ldyninstAPI
+endif
+endif
+
+if HAVE_DYNINST
+lttng_sessiond_LINK = $(CXXLINK)
+else
+lttng_sessiond_LINK = $(LINK)
 endif
diff --git a/src/bin/lttng-sessiond/ust-instrument-dyninst.cpp b/src/bin/lttng-sessiond/ust-instrument-dyninst.cpp
new file mode 100644
index 0000000..76fa345
--- /dev/null
+++ b/src/bin/lttng-sessiond/ust-instrument-dyninst.cpp
@@ -0,0 +1,142 @@
+/*
+ * Copyright (C) 2013 - Zifei Tong <soariez@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2 only,
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <dyninst/BPatch.h>
+#include <dyninst/BPatch_object.h>
+#include <dyninst/BPatch_function.h>
+#include <dyninst/BPatch_point.h>
+#include <dyninst/Symtab.h>
+
+extern "C" {
+#include "ust-app.h"
+#include "ust-instrument.h"
+}
+
+namespace {
+
+BPatch_object* findMatchObject(BPatch_image* image, const char* path)
+{
+	std::vector<BPatch_object*> objects;
+	image->getObjects(objects);
+	for (int i = 0; i < objects.size(); i++) {
+		if (objects[i]->pathName() == path) {
+			return objects[i];
+		}
+	}
+	return NULL;
+}
+
+}
+
+int ust_instrument_probe(struct ust_app* app,
+		const char* object_path,
+		const char* name,
+		enum lttng_ust_instrumentation instrumentation,
+		uint64_t addr,
+		const char *symbol,
+		uint64_t offset)
+{
+	BPatch bpatch;
+	BPatch_process *proc = bpatch.processAttach(object_path, app->pid);
+	BPatch_image *image = proc->getImage();
+	int ret;
+
+	BPatch_object *object = findMatchObject(image, object_path);
+	if (object == NULL) {
+		ERR("Can not find object %s in process %d", object_path, app->pid);
+		proc->detach(true);
+		return -1;
+	}
+
+	Dyninst::Address address;
+	if (symbol[0] != '\0') {
+		/* symbol+offset provided */
+		Dyninst::SymtabAPI::Symtab *symtab = Dyninst::SymtabAPI::convert(object);
+		std::vector<Dyninst::SymtabAPI::Symbol *> symbols;
+		ret = symtab->findSymbol(symbols, name,
+				Dyninst::SymtabAPI::Symbol::ST_UNKNOWN);
+
+		if (!ret) {
+			ERR("Can not find symbol %s in process %d", symbol, app->pid);
+			proc->detach(true);
+			return -1;
+		}
+		if (symbols.size() > 1) {
+			ERR("Multiple instances of symbol %s founded in process %d", symbol, app->pid);
+			proc->detach(true);
+			return -1;
+		}
+		address = object->fileOffsetToAddr(symbols[0]->getOffset() + offset);
+	} else {
+		/* addr (offset) provided */
+		address = object->fileOffsetToAddr(addr);
+	}
+
+	std::vector<BPatch_point*> points;
+	std::vector<BPatch_function *> functions;
+	std::vector<BPatch_point *>* func_points;
+	switch (instrumentation) {
+	case LTTNG_UST_PROBE:
+		image->findPoints(address, points);
+	case LTTNG_UST_FUNCTION:
+		image->findFunction(address, functions);
+		if (functions.size() > 1) {
+			ERR("Multiple functions founded in process %d", symbol, app->pid);
+			proc->detach(true);
+			return -1;
+		}
+
+		func_points = functions[0]->findPoint(BPatch_entry);
+		points.insert(points.end(), func_points->begin(), func_points->end());
+		func_points = functions[0]->findPoint(BPatch_exit);
+		points.insert(points.end(), func_points->begin(), func_points->end());
+	default:
+		ERR("Multiple instances of symbol %s founded in process %d", symbol, app->pid);
+		proc->detach(true);
+		return -1;
+	}
+
+	std::vector<BPatch_function *> probes;
+	/* For now, assume there is a function wrap the tracepoint, e.g.
+	 * void tptest() { tracepoint(tptest); }
+	*/
+	image->findFunction(name, probes);
+	if (probes.size() == 0) {
+		ERR("Can not find probe wrapper %s in process %d", name, app->pid);
+		proc->detach(true);
+		return -1;
+	}
+	if (probes.size() > 1) {
+		ERR("Multiple instances of probe wrapper %s founded in process %d", name, app->pid);
+		proc->detach(true);
+		return -1;
+	}
+
+	std::vector<BPatch_snippet*> args;
+	BPatch_funcCallExpr call_probe(*probes[0], args);
+
+	for (int i = 0; i < points.size(); i++) {
+		if (proc->insertSnippet(call_probe, *points[i]) == NULL) {
+			ERR("Insert snippet failed in process %d", name, app->pid);
+			proc->detach(true);
+			return -1;
+		}
+	}
+
+	proc->detach(true);
+	return 0;
+}
diff --git a/src/common/hashtable/rculfhash-internal.h b/src/common/hashtable/rculfhash-internal.h
index e3a59ba..5030779 100644
--- a/src/common/hashtable/rculfhash-internal.h
+++ b/src/common/hashtable/rculfhash-internal.h
@@ -168,7 +168,7 @@ struct cds_lfht *__default_alloc_cds_lfht(
 {
 	struct cds_lfht *ht;
 
-	ht = calloc(1, cds_lfht_size);
+	ht = (struct cds_lfht *) calloc(1, cds_lfht_size);
 	assert(ht);
 
 	ht->mm = mm;
diff --git a/src/common/sessiond-comm/inet.h b/src/common/sessiond-comm/inet.h
index 89716b8..3e8bdbe 100644
--- a/src/common/sessiond-comm/inet.h
+++ b/src/common/sessiond-comm/inet.h
@@ -18,7 +18,9 @@
 #ifndef _LTTCOMM_INET_H
 #define _LTTCOMM_INET_H
 
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <limits.h>
 
 #include "sessiond-comm.h"
diff --git a/src/common/sessiond-comm/inet6.h b/src/common/sessiond-comm/inet6.h
index 4cb4dca..7fb8450 100644
--- a/src/common/sessiond-comm/inet6.h
+++ b/src/common/sessiond-comm/inet6.h
@@ -18,7 +18,9 @@
 #ifndef _LTTCOMM_INET6_H
 #define _LTTCOMM_INET6_H
 
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <limits.h>
 
 #include "sessiond-comm.h"
diff --git a/src/common/sessiond-comm/sessiond-comm.h b/src/common/sessiond-comm/sessiond-comm.h
index 294e185..2b233f9 100644
--- a/src/common/sessiond-comm/sessiond-comm.h
+++ b/src/common/sessiond-comm/sessiond-comm.h
@@ -25,7 +25,9 @@
 #ifndef _LTTNG_SESSIOND_COMM_H
 #define _LTTNG_SESSIOND_COMM_H
 
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <limits.h>
 #include <lttng/lttng.h>
 #include <lttng/snapshot-internal.h>
diff --git a/src/common/sessiond-comm/unix.h b/src/common/sessiond-comm/unix.h
index 19b91ce..f3f98b5 100644
--- a/src/common/sessiond-comm/unix.h
+++ b/src/common/sessiond-comm/unix.h
@@ -18,7 +18,9 @@
 #ifndef _LTTCOMM_UNIX_H
 #define _LTTCOMM_UNIX_H
 
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <limits.h>
 #include <sys/un.h>
 
diff --git a/tests/unit/Makefile.am b/tests/unit/Makefile.am
index f517fdc..474db14 100644
--- a/tests/unit/Makefile.am
+++ b/tests/unit/Makefile.am
@@ -57,10 +57,19 @@ UST_DATA_TRACE=$(top_builddir)/src/bin/lttng-sessiond/trace-ust.o \
 		   $(top_builddir)/src/common/.libs/uri.o \
 		   $(top_builddir)/src/common/.libs/utils.o
 
+if HAVE_DYNINST
+UST_DATA_TRACE += $(top_builddir)/src/bin/lttng-sessiond/ust-instrument-dyninst.o
+endif
+
 test_ust_data_SOURCES = test_ust_data.c
 test_ust_data_LDADD = $(LIBTAP) $(LIBCOMMON) $(LIBSESSIOND_COMM) $(LIBHASHTABLE) \
 					  -lrt -llttng-ust-ctl
 test_ust_data_LDADD += $(UST_DATA_TRACE)
+
+if HAVE_DYNINST
+test_ust_data_LDADD += -lstdc++ -ldyninstAPI
+endif
+
 endif
 
 # Kernel data structures unit test
-- 
1.8.4
