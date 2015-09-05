From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: consumer signal handling race
Date: Sat,  5 Sep 2015 19:58:29 -0400
Message-ID: <1441497509-8083-1-git-send-email-mathieu.desnoyers__22244.6897802458$1441497579$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZYNLz-0005Fz-Fv
 for lttng-dev@lists.lttng.org; Sat, 05 Sep 2015 19:58:40 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

If a signal comes in after ctx has been destroyed, it will try to use a
closed file descriptor.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-consumerd/lttng-consumerd.c | 10 ++++++++--
 src/bin/lttng-sessiond/main.c             |  1 -
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/src/bin/lttng-consumerd/lttng-consumerd.c b/src/bin/lttng-consumerd/lttng-consumerd.c
index 764cf4c..0d34fee 100644
--- a/src/bin/lttng-consumerd/lttng-consumerd.c
+++ b/src/bin/lttng-consumerd/lttng-consumerd.c
@@ -109,7 +109,9 @@ static void sighandler(int sig)
 		return;
 	}
 
-	lttng_consumer_should_exit(ctx);
+	if (ctx) {
+		lttng_consumer_should_exit(ctx);
+	}
 }
 
 /*
@@ -312,6 +314,7 @@ int main(int argc, char **argv)
 {
 	int ret = 0, retval = 0;
 	void *status;
+	struct lttng_consumer_local_data *tmp_ctx;
 
 	if (set_signal_handler()) {
 		retval = -1;
@@ -626,7 +629,10 @@ exit_health_thread:
 exit_health_pipe:
 
 exit_init_data:
-	lttng_consumer_destroy(ctx);
+	tmp_ctx = ctx;
+	ctx = NULL;
+	cmm_barrier();	/* Clear ctx for signal handler. */
+	lttng_consumer_destroy(tmp_ctx);
 	lttng_consumer_cleanup();
 
 	if (health_consumerd) {
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index 2983cbf..7c48e4d 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -712,7 +712,6 @@ static void sessiond_cleanup(void)
 	wait_consumer(&ustconsumer64_data);
 	wait_consumer(&ustconsumer32_data);
 
-
 	DBG("Cleaning up all agent apps");
 	agent_app_ht_clean();
 
-- 
2.1.4
