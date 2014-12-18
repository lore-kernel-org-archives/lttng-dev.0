From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 04/13] Missing error handling:
	ust_app_ht_alloc should return error status
Date: Wed, 17 Dec 2014 20:45:15 -0500
Message-ID: <1418867124-17343-5-git-send-email-mathieu.desnoyers__41848.3333349743$1418867254$gmane$org@efficios.com>
References: <1418867124-17343-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Y1Q9v-0006An-5r
 for lttng-dev@lists.lttng.org; Wed, 17 Dec 2014 20:45:44 -0500
In-Reply-To: <1418867124-17343-1-git-send-email-mathieu.desnoyers@efficios.com>
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

In preparation for having sessiond main() handle the error.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/ust-app.c | 12 +++++++++++-
 src/bin/lttng-sessiond/ust-app.h |  2 +-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 3abd127..9ab5f77 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -3438,11 +3438,21 @@ void ust_app_clean_list(void)
 /*
  * Init UST app hash table.
  */
-void ust_app_ht_alloc(void)
+int ust_app_ht_alloc(void)
 {
 	ust_app_ht = lttng_ht_new(0, LTTNG_HT_TYPE_ULONG);
+	if (!ust_app_ht) {
+		return -1;
+	}
 	ust_app_ht_by_sock = lttng_ht_new(0, LTTNG_HT_TYPE_ULONG);
+	if (!ust_app_ht_by_sock) {
+		return -1;
+	}
 	ust_app_ht_by_notify_sock = lttng_ht_new(0, LTTNG_HT_TYPE_ULONG);
+	if (!ust_app_ht_by_notify_sock) {
+		return -1;
+	}
+	return 0;
 }
 
 /*
diff --git a/src/bin/lttng-sessiond/ust-app.h b/src/bin/lttng-sessiond/ust-app.h
index d1e260f..2d3695c 100644
--- a/src/bin/lttng-sessiond/ust-app.h
+++ b/src/bin/lttng-sessiond/ust-app.h
@@ -313,7 +313,7 @@ int ust_app_add_ctx_channel_glb(struct ltt_ust_session *usess,
 void ust_app_global_update(struct ltt_ust_session *usess, int sock);
 
 void ust_app_clean_list(void);
-void ust_app_ht_alloc(void);
+int ust_app_ht_alloc(void);
 struct ust_app *ust_app_find_by_pid(pid_t pid);
 int ust_app_calibrate_glb(struct lttng_ust_calibrate *calibrate);
 struct ust_app_stream *ust_app_alloc_stream(void);
-- 
2.1.1
