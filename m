From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Fix: Dead code when checking return
	value from (ust_app|kernel)_snapshot_record
Date: Mon, 29 Jul 2013 17:20:51 -0400
Message-ID: <1375132851-2751-1-git-send-email-christian.babeux__26321.5546649464$1375132929$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f52.google.com ([209.85.128.52])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1V3usN-0003Dv-Tm
	for lttng-dev@lists.lttng.org; Mon, 29 Jul 2013 17:21:14 -0400
Received: by mail-qe0-f52.google.com with SMTP id cz11so2561526qeb.25
	for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2013 14:21:02 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org, jdesfossez@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 src/bin/lttng-sessiond/cmd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
index 84594ad..e9fa3b4 100644
--- a/src/bin/lttng-sessiond/cmd.c
+++ b/src/bin/lttng-sessiond/cmd.c
@@ -2590,10 +2590,12 @@ static int record_kernel_snapshot(struct ltt_kernel_session *ksess,
 
 	ret = kernel_snapshot_record(ksess, output, wait, nb_streams);
 	if (ret < 0) {
-		ret = LTTNG_ERR_SNAPSHOT_FAIL;
 		if (ret == -EINVAL) {
 			ret = LTTNG_ERR_INVALID;
+			goto error_snapshot;
 		}
+
+		ret = LTTNG_ERR_SNAPSHOT_FAIL;
 		goto error_snapshot;
 	}
 
@@ -2646,10 +2648,12 @@ static int record_ust_snapshot(struct ltt_ust_session *usess,
 
 	ret = ust_app_snapshot_record(usess, output, wait, nb_streams);
 	if (ret < 0) {
-		ret = LTTNG_ERR_SNAPSHOT_FAIL;
 		if (ret == -EINVAL) {
 			ret = LTTNG_ERR_INVALID;
+			goto error_snapshot;
 		}
+
+		ret = LTTNG_ERR_SNAPSHOT_FAIL;
 		goto error_snapshot;
 	}
 
-- 
1.8.3.3
