From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: Null check before destroying
 health_sessiond
Date: Fri, 20 Sep 2019 11:15:12 -0400
Message-ID: <20190920151512.12956-1-jonathan.rajotte-julien__21435.6738420733$1568992535$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 46Zcj53vnZzqMk
 for <lttng-dev@lists.lttng.org>; Fri, 20 Sep 2019 11:15:21 -0400 (EDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Fixes coverity #1399735

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/bin/lttng-sessiond/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index 5f99bdbf6..a428630f8 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -1819,7 +1819,9 @@ stop_threads:
 	lttng_pipe_destroy(ust64_channel_monitor_pipe);
 	lttng_pipe_destroy(kernel_channel_monitor_pipe);
 
-	health_app_destroy(health_sessiond);
+	if (health_sessiond) {
+		health_app_destroy(health_sessiond);
+	}
 exit_create_run_as_worker_cleanup:
 exit_options:
 	sessiond_cleanup_lock_file();
-- 
2.17.1
