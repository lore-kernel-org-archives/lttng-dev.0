From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [babeltrace RFC PATCH 1/2] Introduce nscanf to fix
	unbounded scanf()
Date: Thu, 20 Feb 2014 21:15:41 -0500
Message-ID: <1392948942-10604-1-git-send-email-mathieu.desnoyers__21475.4809778698$1392949119$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mathieu.desnoyers@efficios.com>) id 1WGfec-0000GT-Ol
	for lttng-dev@lists.lttng.org; Thu, 20 Feb 2014 21:16:01 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jeremie.galarneau@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/Makefile.am         |    3 +-
 include/babeltrace/nscanf.h |  103 +++++++++++
 lib/Makefile.am             |    4 +
 lib/nscanf.c                |  418 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 527 insertions(+), 1 deletion(-)
 create mode 100644 include/babeltrace/nscanf.h
 create mode 100644 lib/nscanf.c

diff --git a/include/Makefile.am b/include/Makefile.am
index d9996a7..2152a74 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -53,4 +53,5 @@ noinst_HEADERS = \
 	babeltrace/compat/string.h \
 	babeltrace/compat/utc.h \
 	babeltrace/endian.h \
-	babeltrace/mmap-align.h
+	babeltrace/mmap-align.h \
+	babeltrace/nscanf.h
diff --git a/include/babeltrace/nscanf.h b/include/babeltrace/nscanf.h
new file mode 100644
index 0000000..ec74c24
--- /dev/null
+++ b/include/babeltrace/nscanf.h
@@ -0,0 +1,103 @@
+#ifndef NSCANF_H
+#define NSCANF_H
+
+/*
+ * nscanf.h
+ *
+ * Secure scanf wrapper
+ *
+ * Copyright (c) 2014 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#include <stdarg.h>
+#include <stdio.h>
+
+/*
+ * Macro to generate "field_widths" argument.
+ *
+ * Example use:
+ *
+ * int ret;
+ * char numerator[20], denominator[20];
+ *
+ * ret = nscanf("%s/%s",
+ *    NSCANF_LEN(sizeof(numerator), sizeof(denominator)),
+ *    numerator, denominator);
+ *
+ */
+#define NSCANF_LEN(...)	\
+	(const ssize_t []) { __VA_ARGS__ }
+
+/*
+ * Common integer character max widths.
+ */
+#define NSCANF_LEN_u32	10
+#define NSCANF_LEN_s32	11
+#define NSCANF_LEN_o32	11
+#define NSCANF_LEN_x32	9
+#define NSCANF_LEN_u64	20
+#define NSCANF_LEN_s64	21
+#define NSCANF_LEN_o64	22
+#define NSCANF_LEN_x64	17
+
+/*
+ * field_widths is an array of ssize_t elements that specify the length
+ * of each following parameter (field width).
+ *
+ * UNLIKE TO THE REGULAR SCANF(3) FAMILY OF FUNCTIONS, FOR SECURITY
+ * REASONS, STRING CONVERSION ('s' AND '[' CONVERSION SPECIFIERS) WIDTH
+ * INCLUDE THE FINAL \0 FOR EACH STRING. FOR THOSE, A WIDTH OF 0 RETURN
+ * -1 WITH A EINVAL ERROR.
+ *
+ * The following scanf(3) features are not accepted. Those return -1
+ * with a EINVAL error:
+ * - 'n' conversion specification,
+ * - 'a' conversion specification,
+ * - Explicit maximum field width in the format string.
+ *
+ * A negative field width value skips field width validation for the
+ * associated conversion specification (use with care, only with
+ * pre-validated inputs!).
+
+ * Otherwise, the nscanf() family of functions behaves in the same way
+ * as scanf(3).
+ */
+extern int nscanf(const char *format,
+		const ssize_t *field_widths, ...)
+	__attribute__ ((__format__ (__scanf__, 1, 3)));
+
+extern int fnscanf(FILE *stream, const char *format,
+		const ssize_t *field_widths, ...)
+	__attribute__ ((__format__ (__scanf__, 2, 4)));
+
+extern int snscanf(const char *str, const char *format,
+		const ssize_t *field_widths, ...)
+	__attribute__ ((__format__ (__scanf__, 2, 4)));
+
+extern int vnscanf(const char *format,
+		const ssize_t *field_widths, va_list ap)
+	__attribute__ ((__format__ (__scanf__, 1, 0)));
+
+extern int vfnscanf(FILE *stream, const char *format,
+		const ssize_t *field_widths, va_list ap)
+	__attribute__ ((__format__ (__scanf__, 2, 0)));
+
+extern int vsnscanf(const char *str, const char *format,
+		const ssize_t *field_widths, va_list ap)
+	__attribute__ ((__format__ (__scanf__, 2, 0)));
+
+#endif /* NSCANF_H */
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 348b0a9..d707c93 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -4,6 +4,8 @@ AM_CFLAGS = $(PACKAGE_CFLAGS) -I$(top_srcdir)/include
 
 lib_LTLIBRARIES = libbabeltrace.la
 
+noinst_LTLIBRARIES = libnscanf.la
+
 libbabeltrace_la_SOURCES = babeltrace.c \
 			   iterator.c \
 			   context.c \
@@ -17,3 +19,5 @@ libbabeltrace_la_LIBADD = \
 	prio_heap/libprio_heap.la \
 	$(top_builddir)/types/libbabeltrace_types.la \
 	$(top_builddir)/compat/libcompat.la
+
+libnscanf_la_SOURCES = nscanf.c
diff --git a/lib/nscanf.c b/lib/nscanf.c
new file mode 100644
index 0000000..9909eb6
--- /dev/null
+++ b/lib/nscanf.c
@@ -0,0 +1,418 @@
+/*
+ * nscanf.c
+ *
+ * Secure scanf wrapper
+ *
+ * Copyright (c) 2014 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <string.h>
+#include <stdarg.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <ctype.h>
+#include <assert.h>
+#include <babeltrace/babeltrace-internal.h>
+#include <babeltrace/nscanf.h>
+
+/* Max width of size_t printed as string (2^64) */
+#define NSCANF_NUM_WIDTH	20
+
+/*
+ * If returns 0, caller needs to free format_out.
+ */
+static
+int nscanf_prepare_fmt(const char *format,
+		char **format_out,
+		const ssize_t *field_widths)
+{
+	char *format_a, *dest_p;
+	size_t format_a_len;
+	const char *p, *prev_p;
+	int ret;
+	const ssize_t *fw_iter = field_widths;
+	size_t nr_fw = 0;
+
+	/*
+	 * Calculate number of field width to learn the format
+	 * allocation length we need.
+	 */
+	p = format;
+
+	while (*p != '\0') {
+		p = strchrnul(p, '%');
+		if (*p == '\0') {
+			break;
+		}
+		p++;	/* Include % */
+		switch (*p) {
+		case '%':	/* match %% */
+			p++;
+			continue;	/* restart loop */
+		case '*':	/* match %* */
+			p++;
+			break;		/* exit switch */
+		default:
+			break;		/* exit switch */
+		}
+
+		/* Match n$ part of %n$ */
+		prev_p = p;
+		for (;;) {
+			if (*p == '\0') {
+				errno = EINVAL;
+				return -1;
+			}
+			if (isdigit(*p)) {
+				p++;
+				continue;
+			}
+			if (*p == '$') {
+				p++;
+				/* This is the %n$ */
+				break;
+			}
+			/* This is not a %n$ */
+			p = prev_p;
+			break;
+		}
+
+		/*
+		 * 'a' can be either GNU extension (dynamic allocation)
+		 * or C99 conversion specifier. Refuse it due to
+		 * semantic uncertainty.
+		 */
+		if (*p == 'a') {
+			errno = EINVAL;
+			return -1;
+		}
+
+		/* Refuse explicit field width */
+		if (isdigit(*p)) {
+			/* unexpected numerical field len */
+			errno = EINVAL;
+			return -1;
+		}
+
+		/* Length modifiers */
+		switch (*p) {
+		case 'h':
+			/* 'h' or 'hh' */
+			p++;
+			if (*p == 'h') {
+				p++;
+			}
+			break;		/* exit switch */
+		case 'l':
+			/* 'l' or 'll' */
+			p++;
+			if (*p == 'l') {
+				p++;
+			}
+			break;		/* exit switch */
+		case 'j':
+		case 'z':
+		case 't':
+		case 'q':
+		case 'L':
+			p++;
+			break;		/* exit switch */
+		default:
+			/* no length modifier */
+			break;		/* exit switch */
+		}
+
+		/* conversion specifiers */
+		switch (*p) {
+		case '[':
+			/*
+			 * We need to understand the '[' conversion
+			 * specifier because it may contain an extra %
+			 * character.
+			 */
+			p++;
+			if (*p == '^') {
+				p++;
+			}
+			if (*p == ']') {
+				p++;
+			}
+			p = strchrnul(p, ']');
+			if (*p == '\0') {
+				/* Invalid: missing ']' */
+				errno = EINVAL;
+				return -1;
+			}
+			p++;		/* skip over ']' */
+			break;		/* exit switch */
+		case 'n':
+		case 'a':
+			/* Refuse the 'n' and 'a' specifiers */
+			errno = EINVAL;
+			return -1;
+		default:
+			/*
+			 * Leave other conversion specifier validation
+			 * to the scanf implementation.
+			 */
+			break;		/* exit switch */
+		}
+
+		/* Found one location for field width */
+		nr_fw++;
+	}
+	assert(strlen(format) == p - format);
+
+	/* Generate the format string with field width info */
+	format_a_len = p - format + 1 + (nr_fw * NSCANF_NUM_WIDTH);
+	format_a = malloc(format_a_len);
+	if (!format_a) {
+		errno = ENOMEM;
+		return -1;
+	}
+	format_a[0] = '\0';
+
+	p = format;
+	dest_p = format_a;
+
+	while (*p != '\0') {
+		prev_p = p;
+		p = strchrnul(p, '%');
+		if (*p == '\0') {
+			memcpy(dest_p, prev_p, p - prev_p);
+			break;
+		}
+		p++;	/* Include % */
+		memcpy(dest_p, prev_p, p - prev_p);
+		dest_p += p - prev_p;
+
+		switch (*p) {
+		case '%':	/* match %% */
+			*(dest_p++) = *(p++);
+			continue;	/* restart loop */
+		case '*':	/* match %* */
+			*(dest_p++) = *(p++);
+			break;		/* exit switch */
+		default:
+			break;		/* exit switch */
+		}
+
+		/* Match n$ part of %n$ */
+		prev_p = p;
+		for (;;) {
+			assert(*p != '\0');
+			if (isdigit(*p)) {
+				p++;
+				continue;
+			}
+			if (*p == '$') {
+				p++;
+				/* This is the %n$ */
+				memcpy(dest_p, prev_p, p - prev_p);
+				dest_p += p - prev_p;
+				break;
+			}
+			/* This is not a %n$ */
+			p = prev_p;
+			break;
+		}
+
+		assert(*p != 'a');
+		assert(!isdigit(*p));
+
+		/*
+		 * Print len into format string.
+		 */
+		if (*fw_iter >= 0) {
+			size_t width = *fw_iter;
+
+			switch (*p) {
+			case 's':
+			case '[':
+				if (!width) {
+					errno = EINVAL;
+					ret = -1;
+					goto end_error;
+				}
+				/*
+				 * Provide a dumb-proof API by including
+				 * the final '\0' within the width
+				 * received as argument, unlike scanf().
+				 * Adapt the width value for scanf()
+				 * here.
+				 */
+				width--;
+				break;
+			default:
+				break;
+			}
+			ret = sprintf(dest_p, "%zu", width);
+			if (ret < 0) {
+				goto end_error;
+			}
+			assert(ret <= NSCANF_NUM_WIDTH);
+			dest_p += ret;
+		}
+		fw_iter++;
+
+		/* Length modifiers */
+		switch (*p) {
+		case 'h':
+			/* 'h' or 'hh' */
+			*(dest_p++) = *(p++);
+			if (*p == 'h') {
+				*(dest_p++) = *(p++);
+			}
+			break;		/* exit switch */
+		case 'l':
+			/* 'l' or 'll' */
+			*(dest_p++) = *(p++);
+			if (*p == 'l') {
+				*(dest_p++) = *(p++);
+			}
+			break;		/* exit switch */
+		case 'j':
+		case 'z':
+		case 't':
+		case 'q':
+		case 'L':
+			*(dest_p++) = *(p++);
+			break;		/* exit switch */
+		default:
+			/* no length modifier */
+			break;		/* exit switch */
+		}
+
+		/* conversion specifiers */
+		assert(*p != 'n' && *p != 'a');
+		prev_p = p;
+		switch (*p) {
+		case '[':
+			/*
+			 * We need to understand the '[' conversion
+			 * specifier because it may contain an extra %
+			 * character.
+			 */
+			p++;
+			if (*p == '^') {
+				p++;
+			}
+			if (*p == ']') {
+				p++;
+			}
+			p = strchrnul(p, ']');
+			assert(*p != '\0');
+			p++;		/* skip over ']' */
+			memcpy(dest_p, prev_p, p - prev_p);
+			dest_p += p - prev_p;
+			break;		/* exit switch */
+		default:
+			/*
+			 * Leave other conversion specifier validation
+			 * to the scanf implementation.
+			 */
+			break;		/* exit switch */
+		}
+	}
+	*format_out = format_a;
+	return 0;
+
+end_error:
+	free(format_a);
+	return ret;
+}
+
+BT_HIDDEN
+int vsnscanf(const char *str, const char *format,
+		const ssize_t *field_widths, va_list ap)
+{
+	char *format_a;
+	int ret;
+
+	ret = nscanf_prepare_fmt(format, &format_a, field_widths);
+	if (ret < 0) {
+		goto end;
+	}
+	ret = vsscanf(str, format_a, ap);
+	free(format_a);
+end:
+	return ret;
+}
+
+BT_HIDDEN
+int snscanf(const char *str, const char *format,
+		const ssize_t *field_widths, ...)
+{
+	va_list ap;
+	int ret;
+
+	va_start(ap, field_widths);
+	ret = vsnscanf(str, format, field_widths, ap);
+	va_end(ap);
+	return ret;
+}
+
+BT_HIDDEN
+int vfnscanf(FILE *stream, const char *format,
+		const ssize_t *field_widths, va_list ap)
+{
+	char *format_a;
+	int ret;
+
+	ret = nscanf_prepare_fmt(format, &format_a, field_widths);
+	if (ret < 0) {
+		goto end;
+	}
+	ret = vfscanf(stream, format_a, ap);
+	free(format_a);
+end:
+	return ret;
+}
+
+BT_HIDDEN
+int fnscanf(FILE *stream, const char *format,
+		const ssize_t *field_widths, ...)
+{
+	va_list ap;
+	int ret;
+
+	va_start(ap, field_widths);
+	ret = vfnscanf(stream, format, field_widths, ap);
+	va_end(ap);
+	return ret;
+}
+
+BT_HIDDEN
+int vnscanf(const char *format,
+		const ssize_t *field_widths, va_list ap)
+{
+	return vfnscanf(stdin, format, field_widths, ap);
+}
+
+BT_HIDDEN
+int nscanf(const char *format, const ssize_t *field_widths, ...)
+{
+	va_list ap;
+	int ret;
+
+	va_start(ap, field_widths);
+	ret = vfnscanf(stdin, format, field_widths, ap);
+	va_end(ap);
+	return ret;
+}
-- 
1.7.10.4
