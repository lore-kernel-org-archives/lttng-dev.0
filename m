From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH RFC lttng-tools] New testpoint mechanism to
	instrument LTTng binaries for testing purpose
Date: Tue, 11 Sep 2012 16:56:18 -0400
Message-ID: <1347396978-4661-2-git-send-email-christian.babeux__44246.0286817097$1347397041$gmane$org@efficios.com>
References: <1347396978-4661-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TBXVk-0003WL-3i
	for lttng-dev@lists.lttng.org; Tue, 11 Sep 2012 16:56:44 -0400
Received: by mail-qa0-f41.google.com with SMTP id k30so2139350qaf.14
	for <lttng-dev@lists.lttng.org>; Tue, 11 Sep 2012 13:56:44 -0700 (PDT)
In-Reply-To: <1347396978-4661-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

This commit introduce two new macros: TESTPOINT_DECL(name) and
testpoint(name).

Here a quick example that show how to use the testpoint mechanism:

file: main.c

/* Testpoint declaration */
TESTPOINT_DECL(interesting_function)

void interesting_function(void)
{
        testpoint(interesting_function);
        /* Some processing that can fail */
        ...
}

int main(int argc, char *argv[])
{
        interesting_function();
        ...
        printf("End");
}

file: testpoint.c
void __testpoint_interesting_function(void)
{
        printf("In testpoint of interesting function!");
}

Compile:
gcc -o test main.c
gcc -fPIC -shared -o testpoint.so testpoint.c

Run:
> ./test
  End
> export LTTNG_TESTPOINT_ENABLE=1
> LD_PRELOAD=testpoint.so ./test
  In testpoint of interesting function!
  End
> export LTTNG_TESTPOINT_ENABLE=0
> LD_PRELOAD=testpoint.so ./test
  End

The testpoint mechanism is triggered via the preloading of a shared
object containing the appropriate testpoint symbols and by setting the
LTTNG_TESTPOINT_ENABLE environment variable.

The check on this environment variable is done on the application startup
with the help of a constructor (lttng_testpoint_check) which toggle a global
state variable indicating whether or not the testpoints should be activated.

When enabled, the testpoint() macro calls an underlying wrapper specific to
the testpoint and simply try to lookup the testpoint symbol via a dlsym()
call.

When disabled, the testpoint() call will only incur an additionnal test
per testpoint on a global variable. This performance 'hit' should be
acceptable for production use.

The testpoint mechanism should be *always on*. It can be explicitly
disabled via CFLAGS="-DNTESTPOINT" in a way similar to NDEBUG and assert().

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 configure.ac                     |  1 +
 src/common/Makefile.am           |  2 +-
 src/common/testpoint/Makefile.am |  6 +++
 src/common/testpoint/testpoint.c | 43 +++++++++++++++++++++
 src/common/testpoint/testpoint.h | 81 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 132 insertions(+), 1 deletion(-)
 create mode 100644 src/common/testpoint/Makefile.am
 create mode 100644 src/common/testpoint/testpoint.c
 create mode 100644 src/common/testpoint/testpoint.h

diff --git a/configure.ac b/configure.ac
index 7687280..8e61115 100644
--- a/configure.ac
+++ b/configure.ac
@@ -275,6 +275,7 @@ AC_CONFIG_FILES([
 	src/common/sessiond-comm/Makefile
 	src/common/compat/Makefile
 	src/common/relayd/Makefile
+	src/common/testpoint/Makefile
 	src/lib/Makefile
 	src/lib/lttng-ctl/Makefile
 	src/lib/lttng-ctl/filter/Makefile
diff --git a/src/common/Makefile.am b/src/common/Makefile.am
index ca48153..889b04e 100644
--- a/src/common/Makefile.am
+++ b/src/common/Makefile.am
@@ -1,6 +1,6 @@
 AM_CPPFLAGS =
 
-SUBDIRS = compat hashtable kernel-ctl sessiond-comm relayd kernel-consumer ust-consumer
+SUBDIRS = compat hashtable kernel-ctl sessiond-comm relayd kernel-consumer ust-consumer testpoint
 
 AM_CFLAGS = -fno-strict-aliasing
 
diff --git a/src/common/testpoint/Makefile.am b/src/common/testpoint/Makefile.am
new file mode 100644
index 0000000..7d3df16
--- /dev/null
+++ b/src/common/testpoint/Makefile.am
@@ -0,0 +1,6 @@
+AM_CPPFLAGS =
+
+noinst_LTLIBRARIES = libtestpoint.la
+
+libtestpoint_la_SOURCES = testpoint.h testpoint.c
+libtestpoint_la_LIBADD = -ldl
diff --git a/src/common/testpoint/testpoint.c b/src/common/testpoint/testpoint.c
new file mode 100644
index 0000000..2f6b108
--- /dev/null
+++ b/src/common/testpoint/testpoint.c
@@ -0,0 +1,43 @@
+/*
+ * Copyright (C) 2012 - Christian Babeux <christian.babeux@efficios.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2 only,
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef NTESTPOINT
+
+#include <stdlib.h> /* for getenv  */
+#include <string.h> /* for strncmp */
+
+#include "testpoint.h"
+
+const char *LTTNG_TESTPOINT_ENV_VAR = "LTTNG_TESTPOINT_ENABLE";
+
+int LTTNG_TESTPOINT_ACTIVATED;
+
+void lttng_testpoint_check(void)
+{
+	char *testpoint_env_val = NULL;
+
+	testpoint_env_val = getenv(LTTNG_TESTPOINT_ENV_VAR);
+	if (testpoint_env_val != NULL
+	    && (strncmp(testpoint_env_val, "1", 1) == 0)) {
+		LTTNG_TESTPOINT_ACTIVATED = 1;
+	} else {
+		LTTNG_TESTPOINT_ACTIVATED = 0;
+	}
+}
+
+#endif /* NTESTPOINT */
+
diff --git a/src/common/testpoint/testpoint.h b/src/common/testpoint/testpoint.h
new file mode 100644
index 0000000..a1ac920
--- /dev/null
+++ b/src/common/testpoint/testpoint.h
@@ -0,0 +1,81 @@
+/*
+ * Copyright (C) 2012 - Christian Babeux <christian.babeux@efficios.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2 only,
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifdef NTESTPOINT
+
+#define testpoint(name)
+#define TESTPOINT_DECL(name)
+
+#else /* NTESTPOINT */
+
+#ifndef __USE_GNU
+#define __USE_GNU /* for RTLD_DEFAULT */
+#endif
+
+#include <dlfcn.h> /* for dlsym */
+
+#define likely(x)    __builtin_expect(!!(x), 1)
+#define unlikely(x)  __builtin_expect(!!(x), 0)
+
+/* Environment variable used to enable the testpoints facilities. */
+extern const char *LTTNG_TESTPOINT_ENV_VAR;
+
+/* Toggled via the lttng_testpoint_check constructor. */
+extern int LTTNG_TESTPOINT_ACTIVATED;
+
+void __attribute__((constructor)) lttng_testpoint_check(void);
+
+#define testpoint(name)						\
+	do {							\
+		if (unlikely(LTTNG_TESTPOINT_ACTIVATED)) {	\
+			__testpoint_##name##_wrapper();		\
+		}						\
+	} while (0)
+
+/*
+ * One wrapper per testpoint is generated. This is to keep track
+ * of the symbol lookup status and the corresponding function
+ * pointer, if any.
+ */
+#define _TESTPOINT_DECL(_name)					\
+	static inline void __testpoint_##_name##_wrapper(void)	\
+	{							\
+		static void (*tp)(void);			\
+		static int found;				\
+								\
+		if (tp) {					\
+			tp();					\
+			return;					\
+		}						\
+								\
+		if (!found) {					\
+			tp = dlsym(RTLD_DEFAULT,		\
+				     "__testpoint_" #_name);	\
+			if (tp) {				\
+				found = 1;			\
+				tp();				\
+			} else {				\
+				found = -1;			\
+			}					\
+		}						\
+	}
+
+#define TESTPOINT_DECL(name)	\
+	_TESTPOINT_DECL(name)
+
+#endif /* NTESTPOINT */
+
-- 
1.7.11.4
