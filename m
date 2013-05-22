From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace PATCH 14/23] Add MinGW implementation of
	strnlen
Date: Wed, 22 May 2013 08:07:04 +0000
Message-ID: <009B25148989C6458484484699278506E5382F8A__30421.9758873389$1369210067$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1Uf44m-0006XU-Bd
	for lttng-dev@lists.lttng.org; Wed, 22 May 2013 04:07:12 -0400
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

Add an implementation of strnlen for MinGW, as it does not provide
that function in its runtime library.
---
 include/babeltrace/compat/string.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/babeltrace/compat/string.h b/include/babeltrace/compat/string.h
index 1db5837..14e7b53 100644
--- a/include/babeltrace/compat/string.h
+++ b/include/babeltrace/compat/string.h
@@ -44,6 +44,30 @@ static inline char* strtok_r(
 	return ret;
 }
 
+static inline
+size_t strnlen(const char *str, size_t maxlen)
+{
+	char * ptr;
+	size_t len;
+
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
 static inline int compat_strerror_r(int errnum, char *buf, size_t buflen)
 {
 	/* non-recursive implementation of strerror_r */
-- 
1.8.1.msysgit.1
