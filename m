From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools v2 1/4] Save registration time for
 app
Date: Tue, 13 Aug 2019 16:25:16 -0400
Message-ID: <20190813202519.31043-1-jonathan.rajotte-julien__49289.6555036836$1565727949$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 467PNV43Cfzr5K
 for <lttng-dev@lists.lttng.org>; Tue, 13 Aug 2019 16:25:30 -0400 (EDT)
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

Reuse the registration time for path generation.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/bin/lttng-sessiond/ust-app.c | 7 +++----
 src/bin/lttng-sessiond/ust-app.h | 5 +++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 4bee50496..443232e79 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -1831,15 +1831,12 @@ static void shadow_copy_channel(struct ust_app_channel *ua_chan,
 static void shadow_copy_session(struct ust_app_session *ua_sess,
 		struct ltt_ust_session *usess, struct ust_app *app)
 {
-	time_t rawtime;
 	struct tm *timeinfo;
 	char datetime[16];
 	int ret;
 	char tmp_shm_path[PATH_MAX];
 
-	/* Get date and time for unique app path */
-	time(&rawtime);
-	timeinfo = localtime(&rawtime);
+	timeinfo = localtime(&app->registration_time);
 	strftime(datetime, sizeof(datetime), "%Y%m%d-%H%M%S", timeinfo);
 
 	DBG2("Shadow copy of session handle %d", ua_sess->handle);
@@ -3376,6 +3373,8 @@ void ust_app_add(struct ust_app *app)
 	assert(app);
 	assert(app->notify_sock >= 0);
 
+	app->registration_time = time(NULL);
+
 	rcu_read_lock();
 
 	/*
diff --git a/src/bin/lttng-sessiond/ust-app.h b/src/bin/lttng-sessiond/ust-app.h
index b90ff4bce..d9279f0e4 100644
--- a/src/bin/lttng-sessiond/ust-app.h
+++ b/src/bin/lttng-sessiond/ust-app.h
@@ -298,6 +298,11 @@ struct ust_app {
 	 * to a negative value indicating that the agent application is gone.
 	 */
 	int agent_app_sock;
+	/*
+	 * Time at which the app is registred.
+	 * Used for path creation
+	 */
+	time_t registration_time;
 };
 
 #ifdef HAVE_LIBLTTNG_UST_CTL
-- 
2.17.1
