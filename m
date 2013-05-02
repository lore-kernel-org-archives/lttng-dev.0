From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace RFC PATCH 18/28] Add MinGW implementation
	of strnlen
Date: Thu, 2 May 2013 12:00:08 +0000
Message-ID: <009B25148989C6458484484699278506E537E951__45262.8556792208$1367496048$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UXsBN-00029i-Aw
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 08:00:17 -0400
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
 compat/compat_strlib.c             | 23 +++++++++++++++++++++++
 formats/ctf/types/string.c         |  2 +-
 include/babeltrace/compat/string.h |  1 +
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/compat/compat_strlib.c b/compat/compat_strlib.c
index 3cbd455..980a8f5 100644
--- a/compat/compat_strlib.c
+++ b/compat/compat_strlib.c
@@ -50,6 +50,29 @@ int strerror_r(int errnum, char *buf, size_t buflen)
 	buf[buflen - 1] = '\0';
 	return 0;
 }
+
+size_t strnlen(const char *str, size_t maxlen)
+{
+	char * ptr;
+	size_t len;
+	ptr = (char *)str;
+	len = 0;
+
+	/* while there still are characters in the string */
+	while(*ptr != '\0') {
+		/* increment counter */
+		len++;
+		/* check that we do not exceed the given maximum */
+		if (len == maxlen) {
+			return len;
+		}
+		/* next character */
+		ptr++;
+
+	}
+	return len;
+}
+
 #endif
 
 int compat_strerror_r(int errnum, char *buf, size_t buflen)
diff --git a/formats/ctf/types/string.c b/formats/ctf/types/string.c
index a2433bf..a2f513d 100644
--- a/formats/ctf/types/string.c
+++ b/formats/ctf/types/string.c
@@ -29,7 +29,7 @@
 #include <babeltrace/babeltrace-internal.h>
 #include <babeltrace/ctf/types.h>
 #include <limits.h>		/* C99 limits */
-#include <string.h>
+#include <babeltrace/compat/string.h>
 
 int ctf_string_read(struct bt_stream_pos *ppos, struct bt_definition *definition)
 {
diff --git a/include/babeltrace/compat/string.h b/include/babeltrace/compat/string.h
index 501d003..82f411e 100644
--- a/include/babeltrace/compat/string.h
+++ b/include/babeltrace/compat/string.h
@@ -5,6 +5,7 @@
 
 #ifdef __MINGW32__
 char *strtok_r(char *str, const char *delim, char **nextp);
+size_t strnlen(const char *str, size_t maxlen);
 #endif
 
 int compat_strerror_r(int errnum, char *buf, size_t buflen);
-- 
1.8.1.msysgit.1
