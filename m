From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace RFC PATCH 16/28] Add MinGW implementation
	of strtok_r
Date: Thu, 2 May 2013 11:57:27 +0000
Message-ID: <009B25148989C6458484484699278506E537E92F__30246.9980823391$1367495884$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UXs8k-00025D-4G
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 07:57:34 -0400
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
 converter/babeltrace.c             |  2 +-
 include/babeltrace/compat/string.h |  4 ++++
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/compat/compat_strlib.c b/compat/compat_strlib.c
index 7413e74..3cbd455 100644
--- a/compat/compat_strlib.c
+++ b/compat/compat_strlib.c
@@ -1,6 +1,46 @@
 #include <babeltrace/compat/string.h>
 
 #ifdef __MINGW32__
+
+char* strtok_r(
+	char *str,
+	const char *delim,
+	char **nextp)
+{
+	char *ret;
+
+	/* if str is NULL, continue from nextp */
+	if (str == NULL) {
+		str = *nextp;
+	}
+	/* skip the leading delimiter characters */
+	str += strspn(str, delim);
+
+	/* return NULL if all are delimiters */
+	if (*str == '\0') {
+		return NULL;
+	}
+	/* return the pointer to the first character that is not delimiter */
+	ret = str;
+
+	/* scan to the next delimiter */
+	str += strcspn(str, delim);
+
+	/* if we found a delimiter instead of a NUL */
+	if (*str) {
+		/* replace the delimiter with the NUL */
+		*str = '\0';
+		/* next time, scan from the character after NUL */
+		*nextp = str + 1;
+	}
+	else {
+		/* end of string: next time, scan at the end (NUL) again */
+		*nextp = str;
+	}
+
+	return ret;
+}
+
 int strerror_r(int errnum, char *buf, size_t buflen)
 {
 	/* non-recursive implementation of strerror_r */
diff --git a/converter/babeltrace.c b/converter/babeltrace.c
index 7b3db49..f4a9217 100644
--- a/converter/babeltrace.c
+++ b/converter/babeltrace.c
@@ -49,7 +49,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 #include <babeltrace/compat/ftw.h>
-#include <string.h>
+#include <babeltrace/compat/string.h>
 
 #include <babeltrace/ctf-ir/metadata.h>	/* for clocks */
 
diff --git a/include/babeltrace/compat/string.h b/include/babeltrace/compat/string.h
index 8591b7e..501d003 100644
--- a/include/babeltrace/compat/string.h
+++ b/include/babeltrace/compat/string.h
@@ -3,6 +3,10 @@
 
 #include <string.h>
 
+#ifdef __MINGW32__
+char *strtok_r(char *str, const char *delim, char **nextp);
+#endif
+
 int compat_strerror_r(int errnum, char *buf, size_t buflen);
 
 #endif
-- 
1.8.1.msysgit.1
