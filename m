From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace RFC PATCH 26/28] Add MinGW implementation
	of getline
Date: Thu, 2 May 2013 12:06:51 +0000
Message-ID: <009B25148989C6458484484699278506E537E9DB__38937.4852333733$1367496454$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UXsHr-0002Iz-Fz
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 08:06:59 -0400
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

---
 compat/compat_strlib.c             | 40 ++++++++++++++++++++++++++++++++++++++
 include/babeltrace/compat/string.h |  2 ++
 2 files changed, 42 insertions(+)

diff --git a/compat/compat_strlib.c b/compat/compat_strlib.c
index 980a8f5..181cf66 100644
--- a/compat/compat_strlib.c
+++ b/compat/compat_strlib.c
@@ -2,6 +2,10 @@
 
 #ifdef __MINGW32__
 
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+
 char* strtok_r(
 	char *str,
 	const char *delim,
@@ -73,6 +77,42 @@ size_t strnlen(const char *str, size_t maxlen)
 	return len;
 }
 
+ssize_t getline(char **buf, size_t *len, FILE *stream)
+{
+	int c = EOF;
+	ssize_t count = (ssize_t)0;
+
+	if( feof( stream ) || ferror( stream ) )
+		return -1;
+
+	for(;;) {
+		/* read character from stream */
+		c = fgetc(stream);
+		if (c == EOF) {
+			break;
+		}
+		if (c == '\n') {
+			break;
+		}
+
+		/* store to *buf */
+		/* check if it fits - space for character and NUL */
+		if (count > *len - 2) {
+			/* have to allocate more space */
+			*len = *len + 100;
+			*buf = realloc(*buf, *len);
+			if (*buf == NULL) {
+				errno = ENOMEM;
+				return (ssize_t)-1;
+			}
+		}
+		(*buf)[count] = c;
+		count++;
+	}
+	(*buf)[count] = '\0';
+	return (count == (ssize_t)0) ? (ssize_t)-1 : (ssize_t)0;
+}
+
 #endif
 
 int compat_strerror_r(int errnum, char *buf, size_t buflen)
diff --git a/include/babeltrace/compat/string.h b/include/babeltrace/compat/string.h
index 82f411e..50f6ba1 100644
--- a/include/babeltrace/compat/string.h
+++ b/include/babeltrace/compat/string.h
@@ -2,10 +2,12 @@
 #define BABELTRACE_COMPAT_STRING_H
 
 #include <string.h>
+#include <stdio.h>
 
 #ifdef __MINGW32__
 char *strtok_r(char *str, const char *delim, char **nextp);
 size_t strnlen(const char *str, size_t maxlen);
+ssize_t getline(char **buf, size_t *len, FILE *stream);
 #endif
 
 int compat_strerror_r(int errnum, char *buf, size_t buflen);
-- 
1.8.1.msysgit.1
