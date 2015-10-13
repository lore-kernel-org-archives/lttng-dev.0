From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 2/2] Implement bt_getline
Date: Tue, 13 Oct 2015 14:44:06 -0400
Message-ID: <1444761846-9008-2-git-send-email-mathieu.desnoyers__43558.6275918924$1444761955$gmane$org@efficios.com>
References: <1444761846-9008-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Zm4Yc-0007DI-TT
 for lttng-dev@lists.lttng.org; Tue, 13 Oct 2015 14:44:21 -0400
In-Reply-To: <1444761846-9008-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com, mjeanson@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Implement our own getline to remove dependency from glibc 2.10+ and to
increase portability to other operating systems.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 converter/babeltrace-log.c        |   5 +-
 include/babeltrace/compat/stdio.h | 124 ++++++++++++++++++++++++++++++++++++++
 tests/lib/test_ctf_writer.c       |   7 ++-
 3 files changed, 130 insertions(+), 6 deletions(-)
 create mode 100644 include/babeltrace/compat/stdio.h

diff --git a/converter/babeltrace-log.c b/converter/babeltrace-log.c
index 5900b32..acbd0ee 100644
--- a/converter/babeltrace-log.c
+++ b/converter/babeltrace-log.c
@@ -24,8 +24,6 @@
  * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
- *
- * Depends on glibc 2.10 for getline().
  */
 
 #define _GNU_SOURCE
@@ -47,6 +45,7 @@
 #include <babeltrace/ctf/types.h>
 #include <babeltrace/compat/uuid.h>
 #include <babeltrace/compat/utc.h>
+#include <babeltrace/compat/stdio.h>
 #include <babeltrace/endian.h>
 
 #define NSEC_PER_USEC 1000UL
@@ -331,7 +330,7 @@ void trace_text(FILE *input, int output)
 	write_packet_header(&pos, s_uuid);
 	write_packet_context(&pos);
 	for (;;) {
-		len = getline(&line, &linesize, input);
+		len = bt_getline(&line, &linesize, input);
 		if (len < 0)
 			break;
 		nl = strrchr(line, '\n');
diff --git a/include/babeltrace/compat/stdio.h b/include/babeltrace/compat/stdio.h
new file mode 100644
index 0000000..0301e28
--- /dev/null
+++ b/include/babeltrace/compat/stdio.h
@@ -0,0 +1,124 @@
+#ifndef _BABELTRACE_COMPAT_STDIO_H
+#define _BABELTRACE_COMPAT_STDIO_H
+
+/*
+ * Copyright (C) 2015 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
+#include <stdio.h>
+#include <errno.h>
+#include <assert.h>
+
+#define BT_GETLINE_MINBUFLEN	64
+
+static inline
+char * _bt_getline_bufalloc(char **lineptr, size_t *n, size_t linelen)
+{
+	size_t buflen = *n;
+	char *buf = *lineptr;
+
+	if (buflen >= linelen && buf != NULL) {
+		return buf;
+	}
+	if (buf == NULL) {
+		buflen = BT_GETLINE_MINBUFLEN;
+	} else {
+		buflen = buflen << 1;
+		if (buflen < BT_GETLINE_MINBUFLEN) {
+			buflen = BT_GETLINE_MINBUFLEN;
+		}
+	}
+	/* Check below not strictly needed, extra safety. */
+	if (buflen < linelen) {
+		buflen = linelen;
+	}
+	buf = realloc(buf, buflen);
+	if (!buf) {
+		errno = ENOMEM;
+		return NULL;
+	}
+	*n = buflen;
+	*lineptr = buf;
+	return buf;
+}
+
+/*
+ * Returns line length (including possible final \n, excluding final
+ * \0). On end of file, returns -1 with nonzero feof(stream) and errno
+ * set to 0. On error, returns -1 with errno set.
+ *
+ * This interface is similar to the getline(3) man page part of the
+ * Linux man-pages project, release 3.74. One major difference from the
+ * Open Group POSIX specification is that this implementation does not
+ * necessarily set the ferror() flag on error (because it is internal to
+ * libc).
+ */
+static inline
+ssize_t bt_getline(char **lineptr, size_t *n, FILE *stream)
+{
+	size_t linelen = 0;
+	char *buf;
+	int found_eof = 0;
+
+	if (lineptr == NULL || n == NULL) {
+		errno = EINVAL;
+		return -1;
+	}
+	for (;;) {
+		char c;
+
+		c = fgetc(stream);
+		if (c == EOF) {
+			if (ferror(stream)) {
+				/* ferror() is set, errno set by fgetc(). */
+				return -1;
+			}
+			assert(feof(stream));
+			found_eof = 1;
+			break;
+		}
+		if (linelen == SSIZE_MAX) {
+			errno = EOVERFLOW;
+			return -1;
+		}
+		buf = _bt_getline_bufalloc(lineptr, n, ++linelen);
+		if (!buf) {
+			return -1;
+		}
+		buf[linelen - 1] = c;
+		if (c == '\n') {
+			break;
+		}
+	}
+	if (!linelen && found_eof) {
+		/* feof() is set. */
+		errno = 0;
+		return -1;
+	}
+	buf = _bt_getline_bufalloc(lineptr, n, ++linelen);
+	if (!buf) {
+		return -1;
+	}
+	buf[linelen - 1] = '\0';
+	return linelen - 1;	/* Count don't include final \0. */
+}
+
+#endif /* _BABELTRACE_COMPAT_STDIO_H */
diff --git a/tests/lib/test_ctf_writer.c b/tests/lib/test_ctf_writer.c
index b626a66..91ef81a 100644
--- a/tests/lib/test_ctf_writer.c
+++ b/tests/lib/test_ctf_writer.c
@@ -35,6 +35,7 @@
 #include <stdio.h>
 #include <sys/utsname.h>
 #include <babeltrace/compat/limits.h>
+#include <babeltrace/compat/stdio.h>
 #include <string.h>
 #include <assert.h>
 #include <sys/wait.h>
@@ -160,12 +161,12 @@ result:
 		rewind(metadata_fp);
 
 		/* Output the metadata and parser output as diagnostic */
-		while (getline(&line, &len, metadata_fp) > 0) {
+		while (bt_getline(&line, &len, metadata_fp) > 0) {
 			fprintf(stderr, "# %s", line);
 		}
 
 		rewind(parser_output_fp);
-		while (getline(&line, &len, parser_output_fp) > 0) {
+		while (bt_getline(&line, &len, parser_output_fp) > 0) {
 			fprintf(stderr, "# %s", line);
 		}
 
@@ -257,7 +258,7 @@ result:
 			diag("malloc error");
 		}
 		rewind(babeltrace_output_fp);
-		while (getline(&line, &len, babeltrace_output_fp) > 0) {
+		while (bt_getline(&line, &len, babeltrace_output_fp) > 0) {
 			diag("%s", line);
 		}
 
-- 
2.1.4
