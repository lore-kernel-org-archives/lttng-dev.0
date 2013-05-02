From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace RFC PATCH 27/28] MinGW implementation of
	[v]asprintf
Date: Thu, 2 May 2013 12:07:50 +0000
Message-ID: <009B25148989C6458484484699278506E537E9E8__13518.4977007613$1367496518$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UXsIo-0002Jz-9k
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 08:07:58 -0400
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
 include/babeltrace/compat/stdio.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/babeltrace/compat/stdio.h b/include/babeltrace/compat/stdio.h
index be64e60..ce5bab2 100644
--- a/include/babeltrace/compat/stdio.h
+++ b/include/babeltrace/compat/stdio.h
@@ -4,6 +4,10 @@
 #include <stdio.h>
 
 #ifdef __MINGW32__
+
+#include <stdlib.h>
+#include <stdarg.h>
+
 static inline void flockfile (FILE * filehandle)
 {
 	return;
@@ -13,6 +17,40 @@ static inline void funlockfile(FILE * filehandle)
 	return;
 }
 
+static inline
+int vasprintf(char ** strp, const char * fmt, va_list argv)
+{
+	int ret;
+
+	/* allocate even bigger chunks of memory until the string fits */
+	char * buf;
+	size_t size = 100;
+	for(;;) {
+		buf = malloc(size);
+		if (buf == (char *)0) {
+			ret = -1;
+			break;
+		}
+		ret = vsnprintf(buf, size, fmt, argv);
+		if (ret < size)
+			break;
+		size = size + 100;
+		free(buf);
+	}
+	return ret;
+}
+
+static inline
+int asprintf(char ** strp, const char *fmt, ...)
+{
+	int ret;
+	va_list argv;
+	va_start(argv, fmt);
+	ret = vasprintf(strp, fmt, argv);
+	va_end(argv);
+	return ret;
+}
+
 #endif
 
 #endif
-- 
1.8.1.msysgit.1
