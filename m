From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH] Bump relayd protocol version
Date: Mon,  5 Aug 2013 14:52:57 -0400
Message-ID: <1375728777-684-1-git-send-email-jdesfossez__49949.4215626784$1375728858$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1V6Pu1-0003H2-80
	for lttng-dev@lists.lttng.org; Mon, 05 Aug 2013 14:53:15 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

This should have been done for 2.3-rc1.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 src/common/sessiond-comm/relayd.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/common/sessiond-comm/relayd.h b/src/common/sessiond-comm/relayd.h
index aa99248..efbfdab 100644
--- a/src/common/sessiond-comm/relayd.h
+++ b/src/common/sessiond-comm/relayd.h
@@ -28,7 +28,7 @@
 #include <common/defaults.h>
 
 #define RELAYD_VERSION_COMM_MAJOR             2
-#define RELAYD_VERSION_COMM_MINOR             2
+#define RELAYD_VERSION_COMM_MINOR             3
 
 /*
  * lttng-relayd communication header.
-- 
1.7.10.4
