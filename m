From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace PATCH 22/23] MinGW implementation of
	[v]asprintf
Date: Wed, 22 May 2013 08:08:21 +0000
Message-ID: <009B25148989C6458484484699278506E5383016__13228.6006155939$1369210142$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1Uf462-0006eU-0t
	for lttng-dev@lists.lttng.org; Wed, 22 May 2013 04:08:30 -0400
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Mathieu Desnoyers (mathieu.desnoyers@efficios.com)" <mathieu.desnoyers@efficios.com>, =?iso-8859-1?Q?J=E9r=E9mie_Galarneau_=28jeremie=2Egalarneau=40efficios=2E?= =?iso-8859-1?Q?com=29?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

---
 include/babeltrace/compat/stdio.h | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/include/babeltrace/compat/stdio.h b/include/babeltrace/compat/stdio.h
index be64e60..cce3c70 100644
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
@@ -13,6 +17,41 @@ static inline void funlockfile(FILE * filehandle)
 	return;
 }
 
+static inline
+int vasprintf(char ** strp, const char * fmt, va_list argv)
+{
+	int ret;
+	char * buf;
+	size_t size = 100;
+
+	/* allocate even bigger chunks of memory until the string fits */
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
+
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
