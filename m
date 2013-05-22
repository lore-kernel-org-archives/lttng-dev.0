From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace PATCH 06/23] Add MinGW implementation of
	strerror_r
Date: Wed, 22 May 2013 08:06:05 +0000
Message-ID: <009B25148989C6458484484699278506E5382F0C__23605.3503388122$1369210004$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1Uf43p-0006S3-3U
	for lttng-dev@lists.lttng.org; Wed, 22 May 2013 04:06:13 -0400
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

Add MinGW implementation of strerror_r.
Visual C runtime libraries include a function strerror_s,
but unfortunately the current release of MinGW32 does not provide
it. We have our own non-secure implementation instead.
---
 include/babeltrace/compat/string.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/babeltrace/compat/string.h b/include/babeltrace/compat/string.h
index 62cf1bf..2584ecb 100644
--- a/include/babeltrace/compat/string.h
+++ b/include/babeltrace/compat/string.h
@@ -3,7 +3,20 @@
 
 #include <string.h>
 
-#if !defined(__linux__) || ((_POSIX_C_SOURCE >= 200112L || _XOPEN_SOURCE >= 600) && !defined(_GNU_SOURCE))
+#ifdef __MINGW32__
+
+static inline int compat_strerror_r(int errnum, char *buf, size_t buflen)
+{
+	/* non-recursive implementation of strerror_r */
+	/* Windows function strerror_s is not available in MinGW32 */
+	char * retbuf;
+
+	retbuf = strerror(errnum);
+	strncpy(buf, retbuf, buflen);
+	buf[buflen - 1] = '\0';
+	return 0;
+}
+#elif !defined(__linux__) || ((_POSIX_C_SOURCE >= 200112L || _XOPEN_SOURCE >= 600) && !defined(_GNU_SOURCE))
 
 /* XSI-compliant strerror_r */
 static inline int compat_strerror_r(int errnum, char *buf, size_t buflen)
@@ -17,6 +30,7 @@ static inline int compat_strerror_r(int errnum, char *buf, size_t buflen)
 static inline int compat_strerror_r(int errnum, char *buf, size_t buflen)
 {
 	char * retbuf;
+
 	retbuf = strerror_r(errnum, buf, buflen);
 	if (retbuf != buf)
 		strcpy(buf, retbuf);
-- 
1.8.1.msysgit.1
