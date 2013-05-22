From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace PATCH 12/23] Add MinGW implementation of
	strtok_r
Date: Wed, 22 May 2013 08:06:52 +0000
Message-ID: <009B25148989C6458484484699278506E5382F73__2239.88605798713$1369210055$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1Uf44b-0006Vp-3J
	for lttng-dev@lists.lttng.org; Wed, 22 May 2013 04:07:01 -0400
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

Add an implementation for strtok_r for MinGW, where it is missing.
The Windows equivalent strtok_s seems to be missing in MinGW as well.
---
 include/babeltrace/compat/string.h | 39 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/include/babeltrace/compat/string.h b/include/babeltrace/compat/string.h
index 2584ecb..1db5837 100644
--- a/include/babeltrace/compat/string.h
+++ b/include/babeltrace/compat/string.h
@@ -5,6 +5,45 @@
 
 #ifdef __MINGW32__
 
+static inline char* strtok_r(
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
 static inline int compat_strerror_r(int errnum, char *buf, size_t buflen)
 {
 	/* non-recursive implementation of strerror_r */
-- 
1.8.1.msysgit.1
