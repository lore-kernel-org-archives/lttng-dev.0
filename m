From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH] Fix: relayd protocol version
Date: Mon,  5 Aug 2013 15:10:18 -0400
Message-ID: <1375729818-6183-1-git-send-email-jdesfossez__20855.4133693271$1375729973$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1V6QAp-0003vz-TI
	for lttng-dev@lists.lttng.org; Mon, 05 Aug 2013 15:10:37 -0400
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

Since we heritate the relayd protocol version from the sessiond and
relayd version, use the VERSION macro instead of additionnal fields.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 src/bin/lttng-sessiond/cmd.c      |   11 +++++++++--
 src/common/sessiond-comm/relayd.h |    3 ---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
index 84594ad..07366af 100644
--- a/src/bin/lttng-sessiond/cmd.c
+++ b/src/bin/lttng-sessiond/cmd.c
@@ -491,9 +491,16 @@ static int create_connect_relayd(struct lttng_uri *uri,
 {
 	int ret;
 	struct lttcomm_relayd_sock *rsock;
+	uint32_t major, minor;
 
-	rsock = lttcomm_alloc_relayd_sock(uri, RELAYD_VERSION_COMM_MAJOR,
-			RELAYD_VERSION_COMM_MINOR);
+	ret = sscanf(VERSION, "%10u.%10u", &major, &minor);
+	if (ret < 2) {
+		ERR("Error in scanning version");
+		ret = -1;
+		goto error;
+	}
+
+	rsock = lttcomm_alloc_relayd_sock(uri, major, minor);
 	if (!rsock) {
 		ret = LTTNG_ERR_FATAL;
 		goto error;
diff --git a/src/common/sessiond-comm/relayd.h b/src/common/sessiond-comm/relayd.h
index aa99248..836327c 100644
--- a/src/common/sessiond-comm/relayd.h
+++ b/src/common/sessiond-comm/relayd.h
@@ -27,9 +27,6 @@
 #include <lttng/lttng.h>
 #include <common/defaults.h>
 
-#define RELAYD_VERSION_COMM_MAJOR             2
-#define RELAYD_VERSION_COMM_MINOR             2
-
 /*
  * lttng-relayd communication header.
  */
-- 
1.7.10.4
