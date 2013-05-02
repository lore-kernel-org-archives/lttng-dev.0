From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace RFC PATCH 02/28] Move memstream.h to compat
	directory
Date: Thu, 2 May 2013 11:46:42 +0000
Message-ID: <009B25148989C6458484484699278506E537E83D__44018.8163928271$1367495256$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UXryL-0001o1-SO
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 07:46:50 -0400
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
Memstream header file is moved to babeltrace/compat/memstream.h .
---
 formats/ctf/Makefile.am               |   3 +-
 formats/ctf/ctf.c                     |   2 +-
 formats/ctf/memstream.h               | 236 ----------------------------------
 include/Makefile.am                   |   1 +
 include/babeltrace/compat/memstream.h | 236 ++++++++++++++++++++++++++++++++++
 5 files changed, 239 insertions(+), 239 deletions(-)
 delete mode 100644 formats/ctf/memstream.h
 create mode 100644 include/babeltrace/compat/memstream.h

diff --git a/formats/ctf/Makefile.am b/formats/ctf/Makefile.am
index d803b69..6dcc1bb 100644
--- a/formats/ctf/Makefile.am
+++ b/formats/ctf/Makefile.am
@@ -9,8 +9,7 @@ libbabeltrace_ctf_la_SOURCES = \
 	events.c \
 	iterator.c \
 	callbacks.c \
-	events-private.h \
-	memstream.h
+	events-private.h
 
 # Request that the linker keeps all static libraries objects.
 libbabeltrace_ctf_la_LDFLAGS = \
diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index c424e36..d77c93a 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -51,7 +51,7 @@
 #include "metadata/ctf-parser.h"
 #include "metadata/ctf-ast.h"
 #include "events-private.h"
-#include "memstream.h"
+#include "babeltrace/compat/memstream.h"
 
 #define LOG2_CHAR_BIT	3
 
diff --git a/formats/ctf/memstream.h b/formats/ctf/memstream.h
deleted file mode 100644
index d2a96cb..0000000
--- a/formats/ctf/memstream.h
+++ /dev/null
@@ -1,236 +0,0 @@
-#ifndef _BABELTRACE_FORMAT_CTF_MEMSTREAM_H
-#define _BABELTRACE_FORMAT_CTF_MEMSTREAM_H
-
-/*
- * format/ctf/memstream.h
- *
- * Copyright 2012 (c) - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
- *
- * memstream compatibility layer.
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
-#define _GNU_SOURCE
-#include <config.h>
-
-#ifdef BABELTRACE_HAVE_FMEMOPEN
-#include <stdio.h>
-
-static inline
-FILE *babeltrace_fmemopen(void *buf, size_t size, const char *mode)
-{
-	return fmemopen(buf, size, mode);
-}
-
-#else /* BABELTRACE_HAVE_FMEMOPEN */
-
-#include <stdlib.h>
-#include <stdio.h>
-
-/*
- * Fallback for systems which don't have fmemopen. Copy buffer to a
- * temporary file, and use that file as FILE * input.
- */
-static inline
-FILE *babeltrace_fmemopen(void *buf, size_t size, const char *mode)
-{
-	char tmpname[PATH_MAX];
-	size_t len;
-	FILE *fp;
-	int ret;
-
-	/*
-	 * Support reading only.
-	 */
-	if (strcmp(mode, "rb") != 0) {
-		return NULL;
-	}
-	strncpy(tmpname, "/tmp/babeltrace-tmp-XXXXXX", PATH_MAX);
-	ret = mkstemp(tmpname);
-	if (ret < 0) {
-		return NULL;
-	}
-	/*
-	 * We need to write to the file.
-	 */
-	fp = fdopen(ret, "w+");
-	if (!fp) {
-		goto error_unlink;
-	}
-	/* Copy the entire buffer to the file */
-	len = fwrite(buf, sizeof(char), size, fp);
-	if (len != size) {
-		goto error_close;
-	}
-	ret = fseek(fp, 0L, SEEK_SET);
-	if (ret < 0) {
-		perror("fseek");
-		goto error_close;
-	}
-	/* We keep the handle open, but can unlink the file on the VFS. */
-	ret = unlink(tmpname);
-	if (ret < 0) {
-		perror("unlink");
-	}
-	return fp;
-
-error_close:
-	ret = fclose(fp);
-	if (ret < 0) {
-		perror("close");
-	}
-error_unlink:
-	ret = unlink(tmpname);
-	if (ret < 0) {
-		perror("unlink");
-	}
-	return NULL;
-}
-
-#endif /* BABELTRACE_HAVE_FMEMOPEN */
-
-#ifdef BABELTRACE_HAVE_OPEN_MEMSTREAM
-
-#include <stdio.h>
-
-static inline
-FILE *babeltrace_open_memstream(char **ptr, size_t *sizeloc)
-{
-	return open_memstream(ptr, sizeloc);
-}
-
-static inline
-int babeltrace_close_memstream(char **buf, size_t *size, FILE *fp)
-{
-	return fclose(fp);
-}
-
-#else /* BABELTRACE_HAVE_OPEN_MEMSTREAM */
-
-#include <stdlib.h>
-#include <stdio.h>
-
-/*
- * Fallback for systems which don't have open_memstream. Create FILE *
- * with babeltrace_open_memstream, but require call to
- * babeltrace_close_memstream to flush all data written to the FILE *
- * into the buffer (which we allocate).
- */
-static inline
-FILE *babeltrace_open_memstream(char **ptr, size_t *sizeloc)
-{
-	char tmpname[PATH_MAX];
-	int ret;
-	FILE *fp;
-
-	strncpy(tmpname, "/tmp/babeltrace-tmp-XXXXXX", PATH_MAX);
-	ret = mkstemp(tmpname);
-	if (ret < 0) {
-		return NULL;
-	}
-	fp = fdopen(ret, "w+");
-	if (!fp) {
-		goto error_unlink;
-	}
-	/*
-	 * babeltrace_flush_memstream will update the buffer content
-	 * with read from fp. No need to keep the file around, just the
-	 * handle.
-	 */
-	ret = unlink(tmpname);
-	if (ret < 0) {
-		perror("unlink");
-	}
-	return fp;
-
-error_unlink:
-	ret = unlink(tmpname);
-	if (ret < 0) {
-		perror("unlink");
-	}
-	return NULL;
-}
-
-/* Get file size, allocate buffer, copy. */
-static inline
-int babeltrace_close_memstream(char **buf, size_t *size, FILE *fp)
-{
-	size_t len, n;
-	long pos;
-	int ret;
-
-	ret = fflush(fp);
-	if (ret < 0) {
-		perror("fflush");
-		return ret;
-	}
-	ret = fseek(fp, 0L, SEEK_END);
-	if (ret < 0) {
-		perror("fseek");
-		return ret;
-	}
-	pos = ftell(fp);
-	if (ret < 0) {
-		perror("ftell");
-		return ret;
-	}
-	*size = pos;
-	/* add final \0 */
-	*buf = calloc(pos + 1, sizeof(char));
-	if (!*buf) {
-		return -ENOMEM;
-	}
-	ret = fseek(fp, 0L, SEEK_SET);
-	if (ret < 0) {
-		perror("fseek");
-		goto error_free;
-	}
-	/* Copy the entire file into the buffer */
-	n = 0;
-	clearerr(fp);
-	while (!feof(fp) && !ferror(fp) && (*size - n > 0)) {
-		len = fread(*buf, sizeof(char), *size - n, fp);
-		n += len;
-	}
-	if (n != *size) {
-		ret = -1;
-		goto error_close;
-	}
-	ret = fclose(fp);
-	if (ret < 0) {
-		perror("fclose");
-		return ret;
-	}
-	return 0;
-
-error_close:
-	ret = fclose(fp);
-	if (ret < 0) {
-		perror("fclose");
-	}
-error_free:
-	free(*buf);
-	*buf = NULL;
-	return ret;
-}
-
-#endif /* BABELTRACE_HAVE_OPEN_MEMSTREAM */
-
-#endif /* _BABELTRACE_FORMAT_CTF_MEMSTREAM_H */
diff --git a/include/Makefile.am b/include/Makefile.am
index 4617ee2..eee2ac1 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -32,5 +32,6 @@ noinst_HEADERS = \
 	babeltrace/ctf/callbacks-internal.h \
 	babeltrace/trace-handle-internal.h \
 	babeltrace/compat/uuid.h \
+	babeltrace/compat/memstream.h \
 	babeltrace/endian.h \
 	babeltrace/mmap-align.h
diff --git a/include/babeltrace/compat/memstream.h b/include/babeltrace/compat/memstream.h
new file mode 100644
index 0000000..d2a96cb
--- /dev/null
+++ b/include/babeltrace/compat/memstream.h
@@ -0,0 +1,236 @@
+#ifndef _BABELTRACE_FORMAT_CTF_MEMSTREAM_H
+#define _BABELTRACE_FORMAT_CTF_MEMSTREAM_H
+
+/*
+ * format/ctf/memstream.h
+ *
+ * Copyright 2012 (c) - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * memstream compatibility layer.
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
+#define _GNU_SOURCE
+#include <config.h>
+
+#ifdef BABELTRACE_HAVE_FMEMOPEN
+#include <stdio.h>
+
+static inline
+FILE *babeltrace_fmemopen(void *buf, size_t size, const char *mode)
+{
+	return fmemopen(buf, size, mode);
+}
+
+#else /* BABELTRACE_HAVE_FMEMOPEN */
+
+#include <stdlib.h>
+#include <stdio.h>
+
+/*
+ * Fallback for systems which don't have fmemopen. Copy buffer to a
+ * temporary file, and use that file as FILE * input.
+ */
+static inline
+FILE *babeltrace_fmemopen(void *buf, size_t size, const char *mode)
+{
+	char tmpname[PATH_MAX];
+	size_t len;
+	FILE *fp;
+	int ret;
+
+	/*
+	 * Support reading only.
+	 */
+	if (strcmp(mode, "rb") != 0) {
+		return NULL;
+	}
+	strncpy(tmpname, "/tmp/babeltrace-tmp-XXXXXX", PATH_MAX);
+	ret = mkstemp(tmpname);
+	if (ret < 0) {
+		return NULL;
+	}
+	/*
+	 * We need to write to the file.
+	 */
+	fp = fdopen(ret, "w+");
+	if (!fp) {
+		goto error_unlink;
+	}
+	/* Copy the entire buffer to the file */
+	len = fwrite(buf, sizeof(char), size, fp);
+	if (len != size) {
+		goto error_close;
+	}
+	ret = fseek(fp, 0L, SEEK_SET);
+	if (ret < 0) {
+		perror("fseek");
+		goto error_close;
+	}
+	/* We keep the handle open, but can unlink the file on the VFS. */
+	ret = unlink(tmpname);
+	if (ret < 0) {
+		perror("unlink");
+	}
+	return fp;
+
+error_close:
+	ret = fclose(fp);
+	if (ret < 0) {
+		perror("close");
+	}
+error_unlink:
+	ret = unlink(tmpname);
+	if (ret < 0) {
+		perror("unlink");
+	}
+	return NULL;
+}
+
+#endif /* BABELTRACE_HAVE_FMEMOPEN */
+
+#ifdef BABELTRACE_HAVE_OPEN_MEMSTREAM
+
+#include <stdio.h>
+
+static inline
+FILE *babeltrace_open_memstream(char **ptr, size_t *sizeloc)
+{
+	return open_memstream(ptr, sizeloc);
+}
+
+static inline
+int babeltrace_close_memstream(char **buf, size_t *size, FILE *fp)
+{
+	return fclose(fp);
+}
+
+#else /* BABELTRACE_HAVE_OPEN_MEMSTREAM */
+
+#include <stdlib.h>
+#include <stdio.h>
+
+/*
+ * Fallback for systems which don't have open_memstream. Create FILE *
+ * with babeltrace_open_memstream, but require call to
+ * babeltrace_close_memstream to flush all data written to the FILE *
+ * into the buffer (which we allocate).
+ */
+static inline
+FILE *babeltrace_open_memstream(char **ptr, size_t *sizeloc)
+{
+	char tmpname[PATH_MAX];
+	int ret;
+	FILE *fp;
+
+	strncpy(tmpname, "/tmp/babeltrace-tmp-XXXXXX", PATH_MAX);
+	ret = mkstemp(tmpname);
+	if (ret < 0) {
+		return NULL;
+	}
+	fp = fdopen(ret, "w+");
+	if (!fp) {
+		goto error_unlink;
+	}
+	/*
+	 * babeltrace_flush_memstream will update the buffer content
+	 * with read from fp. No need to keep the file around, just the
+	 * handle.
+	 */
+	ret = unlink(tmpname);
+	if (ret < 0) {
+		perror("unlink");
+	}
+	return fp;
+
+error_unlink:
+	ret = unlink(tmpname);
+	if (ret < 0) {
+		perror("unlink");
+	}
+	return NULL;
+}
+
+/* Get file size, allocate buffer, copy. */
+static inline
+int babeltrace_close_memstream(char **buf, size_t *size, FILE *fp)
+{
+	size_t len, n;
+	long pos;
+	int ret;
+
+	ret = fflush(fp);
+	if (ret < 0) {
+		perror("fflush");
+		return ret;
+	}
+	ret = fseek(fp, 0L, SEEK_END);
+	if (ret < 0) {
+		perror("fseek");
+		return ret;
+	}
+	pos = ftell(fp);
+	if (ret < 0) {
+		perror("ftell");
+		return ret;
+	}
+	*size = pos;
+	/* add final \0 */
+	*buf = calloc(pos + 1, sizeof(char));
+	if (!*buf) {
+		return -ENOMEM;
+	}
+	ret = fseek(fp, 0L, SEEK_SET);
+	if (ret < 0) {
+		perror("fseek");
+		goto error_free;
+	}
+	/* Copy the entire file into the buffer */
+	n = 0;
+	clearerr(fp);
+	while (!feof(fp) && !ferror(fp) && (*size - n > 0)) {
+		len = fread(*buf, sizeof(char), *size - n, fp);
+		n += len;
+	}
+	if (n != *size) {
+		ret = -1;
+		goto error_close;
+	}
+	ret = fclose(fp);
+	if (ret < 0) {
+		perror("fclose");
+		return ret;
+	}
+	return 0;
+
+error_close:
+	ret = fclose(fp);
+	if (ret < 0) {
+		perror("fclose");
+	}
+error_free:
+	free(*buf);
+	*buf = NULL;
+	return ret;
+}
+
+#endif /* BABELTRACE_HAVE_OPEN_MEMSTREAM */
+
+#endif /* _BABELTRACE_FORMAT_CTF_MEMSTREAM_H */
-- 
1.8.1.msysgit.1
