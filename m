From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [PATCH 24/28] Use babeltrace/compat/unistd instead of
	unistd
Date: Thu, 2 May 2013 12:05:07 +0000
Message-ID: <009B25148989C6458484484699278506E537E9B9__1374.41214542395$1367496356$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UXsGB-0002Gy-F9
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 08:05:15 -0400
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
 converter/babeltrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/converter/babeltrace.c b/converter/babeltrace.c
index d449ea7..b3b7d08 100644
--- a/converter/babeltrace.c
+++ b/converter/babeltrace.c
@@ -46,7 +46,7 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <babeltrace/compat/fcntl.h>
-#include <unistd.h>
+#include <babeltrace/compat/unistd.h>
 #include <inttypes.h>
 #include <babeltrace/compat/ftw.h>
 #include <babeltrace/compat/string.h>
-- 
1.8.1.msysgit.1
