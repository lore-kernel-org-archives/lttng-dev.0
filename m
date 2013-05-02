From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace RFC PATCH 17/28] Add MinGW implementation
	of sleep
Date: Thu, 2 May 2013 11:58:44 +0000
Message-ID: <009B25148989C6458484484699278506E537E940__19036.398191429$1367495967$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UXsA0-00026u-NA
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 07:58:52 -0400
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
 include/babeltrace/compat/unistd.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/babeltrace/compat/unistd.h b/include/babeltrace/compat/unistd.h
index f275b22..448e047 100644
--- a/include/babeltrace/compat/unistd.h
+++ b/include/babeltrace/compat/unistd.h
@@ -16,6 +16,8 @@ int fpathconf (int fd, int name)
 	return MAX_PATH;
 }
 
+#define sleep(x) Sleep(1000 * (x))
+
 #endif
 
 #endif
\ No newline at end of file
-- 
1.8.1.msysgit.1
