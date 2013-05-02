From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace RFC PATCH 01/28] Move uuid.h to compat
	directory
Date: Thu, 2 May 2013 11:46:35 +0000
Message-ID: <009B25148989C6458484484699278506E537E82D__24489.8263518282$1367495234$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UXryF-0001nw-PC
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 07:46:43 -0400
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Mathieu Desnoyers (mathieu.desnoyers@efficios.com)" <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Move build-specific files to a compat directory.
UUID header file uuid.h is now moved from babeltrace/uuid to
babeltrace/compat/uuid.h .
---
 converter/babeltrace-log.c                         |   2 +-
 formats/ctf/ctf.c                                  |   2 +-
 .../ctf/metadata/ctf-visitor-generate-io-struct.c  |   2 +-
 include/Makefile.am                                |   2 +-
 include/babeltrace/compat/uuid.h                   | 129 +++++++++++++++++++++
 include/babeltrace/ctf-ir/metadata.h               |   2 +-
 include/babeltrace/uuid.h                          | 129 ---------------------
 7 files changed, 134 insertions(+), 134 deletions(-)
 create mode 100644 include/babeltrace/compat/uuid.h
 delete mode 100644 include/babeltrace/uuid.h

diff --git a/converter/babeltrace-log.c b/converter/babeltrace-log.c
index 563a90f..52a2fe1 100644
--- a/converter/babeltrace-log.c
+++ b/converter/babeltrace-log.c
@@ -45,7 +45,7 @@
 
 #include <babeltrace/babeltrace-internal.h>
 #include <babeltrace/ctf/types.h>
-#include <babeltrace/uuid.h>
+#include <babeltrace/compat/uuid.h>
 #include <babeltrace/endian.h>
 
 #define USEC_PER_SEC 1000000UL
diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index 58f937d..c424e36 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -33,7 +33,7 @@
 #include <babeltrace/ctf/events-internal.h>
 #include <babeltrace/trace-handle-internal.h>
 #include <babeltrace/context-internal.h>
-#include <babeltrace/uuid.h>
+#include <babeltrace/compat/uuid.h>
 #include <babeltrace/endian.h>
 #include <inttypes.h>
 #include <stdio.h>
diff --git a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
index 0002fe4..23c4f2f 100644
--- a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
+++ b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
@@ -36,7 +36,7 @@
 #include <babeltrace/list.h>
 #include <babeltrace/types.h>
 #include <babeltrace/ctf/metadata.h>
-#include <babeltrace/uuid.h>
+#include <babeltrace/compat/uuid.h>
 #include <babeltrace/endian.h>
 #include <babeltrace/ctf/events-internal.h>
 #include "ctf-scanner.h"
diff --git a/include/Makefile.am b/include/Makefile.am
index 6a65b5c..4617ee2 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -31,6 +31,6 @@ noinst_HEADERS = \
 	babeltrace/ctf/types.h \
 	babeltrace/ctf/callbacks-internal.h \
 	babeltrace/trace-handle-internal.h \
-	babeltrace/uuid.h \
+	babeltrace/compat/uuid.h \
 	babeltrace/endian.h \
 	babeltrace/mmap-align.h
diff --git a/include/babeltrace/compat/uuid.h b/include/babeltrace/compat/uuid.h
new file mode 100644
index 0000000..2ce7467
--- /dev/null
+++ b/include/babeltrace/compat/uuid.h
@@ -0,0 +1,129 @@
+#ifndef _BABELTRACE_UUID_H
+#define _BABELTRACE_UUID_H
+
+/*
+ * babeltrace/uuid.h
+ *
+ * Copyright (C) 2011   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <config.h>
+
+/* Includes final \0. */
+#define BABELTRACE_UUID_STR_LEN		37
+#define BABELTRACE_UUID_LEN		16
+
+#ifdef BABELTRACE_HAVE_LIBUUID
+#include <uuid/uuid.h>
+
+static inline
+int babeltrace_uuid_generate(unsigned char *uuid_out)
+{
+	uuid_generate(uuid_out);
+	return 0;
+}
+
+static inline
+int babeltrace_uuid_unparse(const unsigned char *uuid_in, char *str_out)
+{
+	uuid_unparse(uuid_in, str_out);
+	return 0;
+}
+
+static inline
+int babeltrace_uuid_parse(const char *str_in, unsigned char *uuid_out)
+{
+	return uuid_parse(str_in, uuid_out);
+}
+
+static inline
+int babeltrace_uuid_compare(const unsigned char *uuid_a,
+		const unsigned char *uuid_b)
+{
+	return uuid_compare(uuid_a, uuid_b);
+}
+
+#elif defined(BABELTRACE_HAVE_LIBC_UUID)
+#include <uuid.h>
+#include <stdint.h>
+#include <string.h>
+#include <stdlib.h>
+
+static inline
+int babeltrace_uuid_generate(unsigned char *uuid_out)
+{
+	uint32_t status;
+
+	uuid_create((uuid_t *) uuid_out, &status);
+	if (status == uuid_s_ok)
+		return 0;
+	else
+		return -1;
+}
+
+static inline
+int babeltrace_uuid_unparse(const unsigned char *uuid_in, char *str_out)
+{
+	uint32_t status;
+	char *alloc_str;
+	int ret;
+
+	uuid_to_string((uuid_t *) uuid_in, &alloc_str, &status);
+	if (status == uuid_s_ok) {
+		strcpy(str_out, alloc_str);
+		ret = 0;
+	} else {
+		ret = -1;
+	}
+	free(alloc_str);
+	return ret;
+}
+
+static inline
+int babeltrace_uuid_parse(const char *str_in, unsigned char *uuid_out)
+{
+	uint32_t status;
+
+	uuid_from_string(str_in, (uuid_t *) uuid_out, &status);
+	if (status == uuid_s_ok)
+		return 0;
+	else
+		return -1;
+}
+
+static inline
+int babeltrace_uuid_compare(const unsigned char *uuid_a,
+		const unsigned char *uuid_b)
+{
+	uint32_t status;
+
+	uuid_compare((uuid_t *) uuid_a, (uuid_t *) uuid_b, &status);
+	if (status == uuid_s_ok)
+		return 0;
+	else
+		return -1;
+}
+
+#else
+#error "Babeltrace needs to have a UUID generator configured."
+#endif
+
+#endif /* _BABELTRACE_UUID_H */
diff --git a/include/babeltrace/ctf-ir/metadata.h b/include/babeltrace/ctf-ir/metadata.h
index 3d684fb..5e92984 100644
--- a/include/babeltrace/ctf-ir/metadata.h
+++ b/include/babeltrace/ctf-ir/metadata.h
@@ -33,7 +33,7 @@
 #include <babeltrace/ctf/types.h>
 #include <sys/types.h>
 #include <dirent.h>
-#include <babeltrace/uuid.h>
+#include <babeltrace/compat/uuid.h>
 #include <assert.h>
 #include <glib.h>
 
diff --git a/include/babeltrace/uuid.h b/include/babeltrace/uuid.h
deleted file mode 100644
index 2ce7467..0000000
--- a/include/babeltrace/uuid.h
+++ /dev/null
@@ -1,129 +0,0 @@
-#ifndef _BABELTRACE_UUID_H
-#define _BABELTRACE_UUID_H
-
-/*
- * babeltrace/uuid.h
- *
- * Copyright (C) 2011   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
- * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
- */
-
-#include <config.h>
-
-/* Includes final \0. */
-#define BABELTRACE_UUID_STR_LEN		37
-#define BABELTRACE_UUID_LEN		16
-
-#ifdef BABELTRACE_HAVE_LIBUUID
-#include <uuid/uuid.h>
-
-static inline
-int babeltrace_uuid_generate(unsigned char *uuid_out)
-{
-	uuid_generate(uuid_out);
-	return 0;
-}
-
-static inline
-int babeltrace_uuid_unparse(const unsigned char *uuid_in, char *str_out)
-{
-	uuid_unparse(uuid_in, str_out);
-	return 0;
-}
-
-static inline
-int babeltrace_uuid_parse(const char *str_in, unsigned char *uuid_out)
-{
-	return uuid_parse(str_in, uuid_out);
-}
-
-static inline
-int babeltrace_uuid_compare(const unsigned char *uuid_a,
-		const unsigned char *uuid_b)
-{
-	return uuid_compare(uuid_a, uuid_b);
-}
-
-#elif defined(BABELTRACE_HAVE_LIBC_UUID)
-#include <uuid.h>
-#include <stdint.h>
-#include <string.h>
-#include <stdlib.h>
-
-static inline
-int babeltrace_uuid_generate(unsigned char *uuid_out)
-{
-	uint32_t status;
-
-	uuid_create((uuid_t *) uuid_out, &status);
-	if (status == uuid_s_ok)
-		return 0;
-	else
-		return -1;
-}
-
-static inline
-int babeltrace_uuid_unparse(const unsigned char *uuid_in, char *str_out)
-{
-	uint32_t status;
-	char *alloc_str;
-	int ret;
-
-	uuid_to_string((uuid_t *) uuid_in, &alloc_str, &status);
-	if (status == uuid_s_ok) {
-		strcpy(str_out, alloc_str);
-		ret = 0;
-	} else {
-		ret = -1;
-	}
-	free(alloc_str);
-	return ret;
-}
-
-static inline
-int babeltrace_uuid_parse(const char *str_in, unsigned char *uuid_out)
-{
-	uint32_t status;
-
-	uuid_from_string(str_in, (uuid_t *) uuid_out, &status);
-	if (status == uuid_s_ok)
-		return 0;
-	else
-		return -1;
-}
-
-static inline
-int babeltrace_uuid_compare(const unsigned char *uuid_a,
-		const unsigned char *uuid_b)
-{
-	uint32_t status;
-
-	uuid_compare((uuid_t *) uuid_a, (uuid_t *) uuid_b, &status);
-	if (status == uuid_s_ok)
-		return 0;
-	else
-		return -1;
-}
-
-#else
-#error "Babeltrace needs to have a UUID generator configured."
-#endif
-
-#endif /* _BABELTRACE_UUID_H */
-- 
1.8.1.msysgit.1
