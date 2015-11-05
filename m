From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace 1/3] Port: Add OSX endian.h compat
Date: Thu,  5 Nov 2015 12:51:53 -0500
Message-ID: <1446745915-1651-1-git-send-email-mjeanson__21413.7729410597$1446746020$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1ZuOhy-0004Ue-60
 for lttng-dev@lists.lttng.org; Thu, 05 Nov 2015 12:52:23 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

From: Alexis Martin <alexis.martin@inria.fr>

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 include/babeltrace/endian.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/babeltrace/endian.h b/include/babeltrace/endian.h
index f0299ad..c5e5d70 100644
--- a/include/babeltrace/endian.h
+++ b/include/babeltrace/endian.h
@@ -81,6 +81,44 @@
 #define BIG_ENDIAN     __BIG_ENDIAN
 #define PDP_ENDIAN     __PDP_ENDIAN
 #define BYTE_ORDER     __BYTE_ORDER
+
+#elif defined(__APPLE__)
+# include <machine/endian.h>
+# include <libkern/OSByteOrder.h>
+
+# if BYTE_ORDER == LITTLE_ENDIAN
+#  define htobe16(x) OSSwapConstInt16(x)
+#  define htole16(x) (x)
+#  define be16toh(x) OSSwapConstInt16(x)
+#  define le16toh(x) (x)
+
+#  define htobe32(x) OSSwapConstInt32(x)
+#  define htole32(x) (x)
+#  define be32toh(x) OSSwapConstInt32(x)
+#  define le32toh(x) (x)
+
+#  define htobe64(x) OSSwapConstInt64(x)
+#  define htole64(x) (x)
+#  define be64toh(x) OSSwapConstInt64(x)
+#  define le64toh(x) (x)
+
+# else /* BYTE_ORDER == LITTLE_ENDIAN */
+#  define htobe16(x) (x)
+#  define htole16(x) OSSwapConstInt16(x)
+#  define be16toh(x) (x)
+#  define le16toh(x) OSSwapConstInt16(x)
+
+#  define htobe32(x) (x)
+#  define htole32(x) OSSwapConstInt32(x)
+#  define be32toh(x) (x)
+#  define le32toh(x) OSSwapConstInt32(x)
+
+#  define htobe64(x) (x)
+#  define htole64(x) OSSwapConstInt64(x)
+#  define be64toh(x) (x)
+#  define le64toh(x) OSSwapConstInt64(x)
+#  endif
+
 #else
 #include <endian.h>
 
-- 
1.9.1
