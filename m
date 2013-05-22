From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace PATCH 21/23] Add MinGW implementation of
	getline
Date: Wed, 22 May 2013 08:08:13 +0000
Message-ID: <009B25148989C6458484484699278506E538300B__22313.7779547416$1369210132$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1Uf45u-0006eB-3w
	for lttng-dev@lists.lttng.org; Wed, 22 May 2013 04:08:22 -0400
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
 include/babeltrace/compat/string.h | 42 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/include/babeltrace/compat/string.h b/include/babeltrace/compat/string.h
index 14e7b53..e2612f4 100644
--- a/include/babeltrace/compat/string.h
+++ b/include/babeltrace/compat/string.h
@@ -5,6 +5,10 @@
 
 #ifdef __MINGW32__
 
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+
 static inline char* strtok_r(
 	char *str,
 	const char *delim,
@@ -79,6 +83,44 @@ static inline int compat_strerror_r(int errnum, char *buf, size_t buflen)
 	buf[buflen - 1] = '\0';
 	return 0;
 }
+
+static inline
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
 #elif !defined(__linux__) || ((_POSIX_C_SOURCE >= 200112L || _XOPEN_SOURCE >= 600) && !defined(_GNU_SOURCE))
 
 /* XSI-compliant strerror_r */
-- 
1.8.1.msysgit.1
