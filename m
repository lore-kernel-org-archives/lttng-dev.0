From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace RFC PATCH 09/28] Add MinGW implementation
	of strerror_r
Date: Thu, 2 May 2013 11:50:35 +0000
Message-ID: <009B25148989C6458484484699278506E537E8B6__44432.0524846718$1367495475$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UXs27-0001wb-Rz
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 07:50:44 -0400
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
 compat/compat_strlib.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/compat/compat_strlib.c b/compat/compat_strlib.c
index 9aabb07..7413e74 100644
--- a/compat/compat_strlib.c
+++ b/compat/compat_strlib.c
@@ -1,5 +1,17 @@
 #include <babeltrace/compat/string.h>
 
+#ifdef __MINGW32__
+int strerror_r(int errnum, char *buf, size_t buflen)
+{
+	/* non-recursive implementation of strerror_r */
+	char * retbuf;
+	retbuf = strerror(errnum);
+	strncpy(buf, retbuf, buflen);
+	buf[buflen - 1] = '\0';
+	return 0;
+}
+#endif
+
 int compat_strerror_r(int errnum, char *buf, size_t buflen)
 {
 #if !defined(__linux__) || ((_POSIX_C_SOURCE >= 200112L || _XOPEN_SOURCE >= 600) && !defined(_GNU_SOURCE))
-- 
1.8.1.msysgit.1
