From: Jan Glauber <jan.glauber@gmail.com>
Subject: [RFC PATCH 1/2] Resurrect LTT type parser
Date: Fri, 19 Apr 2013 12:20:29 +0200
Message-ID: <3401d96aafec4a5e2ca84879d0fe2d84599ccf6c.1366364119.git.jan.glauber__34583.7119887166$1366366898$gmane$org@gmail.com>
References: <cover.1366364119.git.jan.glauber@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ea0-f177.google.com ([209.85.215.177])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jan.glauber@gmail.com>) id 1UT8RO-00051O-LW
	for lttng-dev@lists.lttng.org; Fri, 19 Apr 2013 06:21:14 -0400
Received: by mail-ea0-f177.google.com with SMTP id q14so1661384eaj.8
	for <lttng-dev@lists.lttng.org>; Fri, 19 Apr 2013 03:21:08 -0700 (PDT)
In-Reply-To: <cover.1366364119.git.jan.glauber@gmail.com>
In-Reply-To: <cover.1366364119.git.jan.glauber@gmail.com>
References: <cover.1366364119.git.jan.glauber@gmail.com>
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

Parse legacy LTT trace type format strings.
Resurrected from lttng-ust (serialize.c) git commit id: 31607b3
and slightly adopted to be useable by babeltrace-legacy.

Signed-off-by: Jan Glauber <jan.glauber@gmail.com>
---
 converter/ltt-type-parser.c          |  303 ++++++++++++++++++++++++++++++++++
 include/babeltrace/ltt-type-parser.h |   17 ++
 2 files changed, 320 insertions(+)
 create mode 100644 converter/ltt-type-parser.c
 create mode 100644 include/babeltrace/ltt-type-parser.h

diff --git a/converter/ltt-type-parser.c b/converter/ltt-type-parser.c
new file mode 100644
index 0000000..4290ee1
--- /dev/null
+++ b/converter/ltt-type-parser.c
@@ -0,0 +1,303 @@
+/*
+ * ltt-type-parser.c
+ *
+ * Parse legacy LTT trace type format strings.
+ * Resurrected from lttng-ust (serialize.c) git commit id: 31607b3
+ *   and slightly adopted to be useable by babeltrace-legacy.
+ *
+ * Copyright Mathieu Desnoyers, March 2007.
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
+#include <sys/types.h>
+#include <stdint.h>
+#include <string.h>
+#include "babeltrace/ltt-type-parser.h"
+
+/*
+ * Restrictions:
+ * Field width and precision are *not* supported.
+ * %n not supported.
+ */
+static const char *parse_c_type(const char *fmt, char *c_size,
+				enum ltt_type *c_type, char *base,
+				char *outfmt, int arch_size,
+				int size_long, int size_size_t)
+{
+	int qualifier;
+
+	/* process flags : ignore standard print formats for now. */
+repeat:
+	switch (*fmt) {
+	case '-':
+	case '+':
+	case ' ':
+	case '#':
+	case '0':
+		++fmt;
+		goto repeat;
+	}
+
+	/* get the conversion qualifier */
+	qualifier = -1;
+	if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L' ||
+	    *fmt == 'Z' || *fmt == 'z' || *fmt == 't' ||
+	    *fmt == 'S') {
+		qualifier = *fmt;
+		++fmt;
+		if (qualifier == 'l' && *fmt == 'l') {
+			qualifier = 'L';
+			++fmt;
+		}
+	}
+
+	if (outfmt) {
+		if (qualifier != -1)
+			*outfmt++ = (char)qualifier;
+		*outfmt++ = *fmt;
+		*outfmt = 0;
+	}
+
+	switch (*fmt) {
+	case 'c':
+		*base = 10;
+		*c_type = LTT_TYPE_UNSIGNED_INT;
+		*c_size = sizeof(unsigned char);
+		goto parse_end;
+	case 's':
+		*c_type = LTT_TYPE_STRING;
+		goto parse_end;
+	case 'p':
+		*base = 16;
+		*c_type = LTT_TYPE_UNSIGNED_INT;
+		*c_size = arch_size;
+		goto parse_end;
+	case 'd':
+	case 'i':
+		*base = 10;
+		*c_type = LTT_TYPE_SIGNED_INT;
+		break;
+	case 'o':
+		*base = 8;
+		*c_type = LTT_TYPE_UNSIGNED_INT;
+		break;
+	case 'u':
+		*base = 10;
+		*c_type = LTT_TYPE_UNSIGNED_INT;
+		break;
+	case 'x':
+	case 'X':
+		*base = 16;
+		*c_type = LTT_TYPE_UNSIGNED_INT;
+		break;
+	default:
+		if (!*fmt)
+			--fmt;
+		goto parse_end;
+	}
+	switch (qualifier) {
+	case 'L':
+		*c_size = sizeof(long long);
+		break;
+	case 'l':
+		*c_size = size_long;
+		break;
+	case 'Z':
+	case 'z':
+		*c_size = size_size_t;
+		break;
+	case 'h':
+		*c_size = sizeof(short);
+		break;
+	default:
+		*c_size = sizeof(int);
+	}
+
+parse_end:
+	return fmt;
+}
+
+static inline const char *parse_trace_type(const char *fmt,
+		char *trace_size, enum ltt_type *trace_type,
+		char *base, unsigned long *attributes,
+		int arch_size, int size_long, int size_size_t)
+{
+	int qualifier;
+
+	/* parse attributes. */
+repeat:
+	switch (*fmt) {
+	case 'n':
+		*attributes |= (1<<1);
+		++fmt;
+		goto repeat;
+	}
+
+	/* get the conversion qualifier */
+	qualifier = -1;
+	if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L' ||
+	    *fmt == 'Z' || *fmt == 'z' || *fmt == 't' ||
+	    *fmt == 'S' || *fmt == '1' || *fmt == '2' ||
+	    *fmt == '4' || *fmt == 8) {
+		qualifier = *fmt;
+		++fmt;
+		if (qualifier == 'l' && *fmt == 'l') {
+			qualifier = 'L';
+			++fmt;
+		}
+	}
+
+	switch (*fmt) {
+	case 'c':
+		*base = 10;
+		*trace_type = LTT_TYPE_UNSIGNED_INT;
+		*trace_size = sizeof(unsigned char);
+		goto parse_end;
+	case 's':
+		*trace_type = LTT_TYPE_STRING;
+		goto parse_end;
+	case 'p':
+		*base = 16;
+		*trace_type = LTT_TYPE_UNSIGNED_INT;
+		*trace_size = arch_size;
+		goto parse_end;
+	case 'd':
+	case 'i':
+		*base = 10;
+		*trace_type = LTT_TYPE_SIGNED_INT;
+		break;
+	case 'o':
+		*base = 8;
+		*trace_type = LTT_TYPE_UNSIGNED_INT;
+		break;
+	case 'u':
+		*base = 10;
+		*trace_type = LTT_TYPE_UNSIGNED_INT;
+		break;
+	case 'x':
+	case 'X':
+		*base = 16;
+		*trace_type = LTT_TYPE_UNSIGNED_INT;
+		break;
+	default:
+		if (!*fmt)
+			--fmt;
+		goto parse_end;
+	}
+	switch (qualifier) {
+	case 'L':
+		*trace_size = sizeof(long long);
+		break;
+	case 'l':
+		*trace_size = size_long;
+		break;
+	case 'Z':
+	case 'z':
+		*trace_size = size_size_t;
+		break;
+	case 'h':
+		*trace_size = sizeof(short);
+		break;
+	case '1':
+		*trace_size = sizeof(uint8_t);
+		break;
+	case '2':
+		*trace_size = sizeof(uint16_t);
+		break;
+	case '4':
+		*trace_size = sizeof(uint32_t);
+		break;
+	case '8':
+		*trace_size = sizeof(uint64_t);
+		break;
+	default:
+		*trace_size = sizeof(int);
+	}
+
+parse_end:
+	return fmt;
+}
+
+int parse_format(char *out, const char *fmt,
+		 int arch_size, int size_long, int size_size_t,
+		 int (*write) (char *p, char trace_size, char c_size,
+		 enum ltt_type c_type, char base, char *name))
+{
+	char trace_size = 0, c_size = 0;	/* 0 (unset), 1, 2, 4, 8 bytes */
+	char base = 0;                          /* 0 (unset), 10, 16 */
+	enum ltt_type trace_type = LTT_TYPE_NONE, c_type = LTT_TYPE_NONE;
+	unsigned long attributes = 0;
+	char name[256];
+	char *pname = name;
+	int len = 0;
+
+	memset(name, 0, sizeof(name));
+
+	for (; *fmt ; ++fmt) {
+		switch (*fmt) {
+		case '#':
+			/* tracetypes (#) */
+			++fmt;			/* skip first '#' */
+			if (*fmt == '#')	/* Escaped ## */
+				break;
+			attributes = 0;
+			fmt = parse_trace_type(fmt, &trace_size, &trace_type,
+					       &base, &attributes,
+					       arch_size, size_long, size_size_t);
+			break;
+		case '%':
+			/* c types (%) */
+			++fmt;			/* skip first '%' */
+			if (*fmt == '%')	/* Escaped %% */
+				break;
+			fmt = parse_c_type(fmt, &c_size, &c_type, &base, NULL,
+					   arch_size, size_long, size_size_t);
+			/*
+			 * Output c types if no trace types has been
+			 * specified.
+			 */
+			if (!trace_size)
+				trace_size = c_size;
+			if (trace_type == LTT_TYPE_NONE)
+				trace_type = c_type;
+			if (c_type == LTT_TYPE_STRING)
+				trace_type = LTT_TYPE_STRING;
+			/* perform write */
+			len += write(out + len, trace_size, c_size, trace_type,
+				     base, name);
+			trace_size = 0;
+			c_size = 0;
+			trace_type = LTT_TYPE_NONE;
+			c_size = LTT_TYPE_NONE;
+			attributes = 0;
+			memset(name, 0, sizeof(name));
+			pname = name;
+			break;
+		case ' ':
+			/* skip spaces */
+			continue;
+		default:
+			/* default is to copy the text as parameter name */
+			*pname = *fmt;
+			pname++;
+		}
+	}
+	return len;
+}
diff --git a/include/babeltrace/ltt-type-parser.h b/include/babeltrace/ltt-type-parser.h
new file mode 100644
index 0000000..85d9a92
--- /dev/null
+++ b/include/babeltrace/ltt-type-parser.h
@@ -0,0 +1,17 @@
+#ifndef _LTT_TYPE_PARSER_H
+#define _LTT_TYPE_PARSER_H
+
+#include <sys/types.h>
+
+enum ltt_type {
+	LTT_TYPE_SIGNED_INT,
+	LTT_TYPE_UNSIGNED_INT,
+	LTT_TYPE_STRING,
+	LTT_TYPE_NONE,
+};
+
+int parse_format(char *out, const char *fmt, int arch_size,
+		 int size_long, int size_size_t,
+		 int (*write) (char *p, char trace_size, char c_size,
+			       enum ltt_type c_type, char base, char *name));
+#endif
-- 
1.7.9.5
