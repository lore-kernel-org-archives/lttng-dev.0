From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools v2] Fix: update apps on untrack only
 when session is active
Date: Mon, 18 Nov 2019 15:12:20 -0500
Message-ID: <20191118201220.7525-1-jonathan.rajotte-julien__27629.5901903481$1574107966$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 47H0Vm24Zhz1RC0
 for <lttng-dev@lists.lttng.org>; Mon, 18 Nov 2019 15:12:31 -0500 (EST)
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

This mimics what is done on the track side.

Fixes #1210

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---

Used wrong issue number.

---
 src/bin/lttng-sessiond/trace-ust.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/bin/lttng-sessiond/trace-ust.c b/src/bin/lttng-sessiond/trace-ust.c
index 486b53d30..a6c0c04ad 100644
--- a/src/bin/lttng-sessiond/trace-ust.c
+++ b/src/bin/lttng-sessiond/trace-ust.c
@@ -922,6 +922,7 @@ end:
 int trace_ust_untrack_pid(struct ltt_ust_session *session, int pid)
 {
 	int retval = LTTNG_OK;
+	bool should_update_apps = false;
 
 	if (pid == -1) {
 		/* Create empty tracker, replace old tracker. */
@@ -938,7 +939,7 @@ int trace_ust_untrack_pid(struct ltt_ust_session *session, int pid)
 		fini_pid_tracker(&tmp_tracker);
 
 		/* Remove session from all applications */
-		ust_app_global_update_all(session);
+		should_update_apps = true;
 	} else {
 		int ret;
 		struct ust_app *app;
@@ -957,9 +958,12 @@ int trace_ust_untrack_pid(struct ltt_ust_session *session, int pid)
 		/* Remove session from application. */
 		app = ust_app_find_by_pid(pid);
 		if (app) {
-			ust_app_global_update(session, app);
+			should_update_apps = true;
 		}
 	}
+	if (should_update_apps && session->active) {
+		ust_app_global_update_all(session);
+	}
 end:
 	return retval;
 }
-- 
2.17.1
