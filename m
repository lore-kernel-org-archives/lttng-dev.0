From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace RFC PATCH 07/28] Add MinGW specific
 definitions to endian.h
Date: Thu, 2 May 2013 11:48:09 +0000
Message-ID: <009B25148989C6458484484699278506E537E894__10848.7315745608$1367495332$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UXrzl-0001u9-Pj
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 07:48:17 -0400
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
 include/babeltrace/endian.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/babeltrace/endian.h b/include/babeltrace/endian.h
index 9eee0c1..f15a44f 100644
--- a/include/babeltrace/endian.h
+++ b/include/babeltrace/endian.h
@@ -29,6 +29,22 @@
 
 #ifdef __FreeBSD__
 #include <machine/endian.h>
+#elif defined(__MINGW32__)
+#ifndef __BIG_ENDIAN
+#define __BIG_ENDIAN 4321
+#endif
+#ifndef __LITTLE_ENDIAN
+#define __LITTLE_ENDIAN 1234
+#endif
+
+#ifndef __BYTE_ORDER
+#define __BYTE_ORDER __LITTLE_ENDIAN
+#endif
+
+#define LITTLE_ENDIAN  __LITTLE_ENDIAN
+#define BIG_ENDIAN     __BIG_ENDIAN
+#define PDP_ENDIAN     __PDP_ENDIAN
+#define BYTE_ORDER     __BYTE_ORDER
 #else
 #include <endian.h>
 #endif
-- 
1.8.1.msysgit.1
