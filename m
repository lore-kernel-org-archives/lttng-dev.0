From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [lttng-tools PATCH] Fix: don't keep vpid, procname,
	nor patchlevel	environment for per-uid buffers
Date: Thu, 28 Mar 2013 15:54:12 -0400
Message-ID: <20130328195412.GA1311__15279.716338455$1364500512$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1ULItq-0002xQ-Es
	for lttng-dev@lists.lttng.org; Thu, 28 Mar 2013 15:54:14 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index fdcad1c..221aa97 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -1499,7 +1499,9 @@ static int setup_buffer_reg_pid(struct ust_app_session *ua_sess,
 	ret = ust_registry_session_init(&reg_pid->registry->reg.ust, app,
 			app->bits_per_long, app->uint8_t_alignment,
 			app->uint16_t_alignment, app->uint32_t_alignment,
-			app->uint64_t_alignment, app->long_alignment, app->byte_order);
+			app->uint64_t_alignment, app->long_alignment,
+			app->byte_order, app->version.major,
+			app->version.minor);
 	if (ret < 0) {
 		goto error;
 	}
@@ -1550,10 +1552,12 @@ static int setup_buffer_reg_uid(struct ltt_ust_session *usess,
 	}
 
 	/* Initialize registry. */
-	ret = ust_registry_session_init(&reg_uid->registry->reg.ust, app,
+	ret = ust_registry_session_init(&reg_uid->registry->reg.ust, NULL,
 			app->bits_per_long, app->uint8_t_alignment,
 			app->uint16_t_alignment, app->uint32_t_alignment,
-			app->uint64_t_alignment, app->long_alignment, app->byte_order);
+			app->uint64_t_alignment, app->long_alignment,
+			app->byte_order, app->version.major,
+			app->version.minor);
 	if (ret < 0) {
 		goto error;
 	}
diff --git a/src/bin/lttng-sessiond/ust-metadata.c b/src/bin/lttng-sessiond/ust-metadata.c
index 2735169..b0f83d2 100644
--- a/src/bin/lttng-sessiond/ust-metadata.c
+++ b/src/bin/lttng-sessiond/ust-metadata.c
@@ -520,7 +520,9 @@ uint64_t measure_clock_offset(void)
  * Should be called with session registry mutex held.
  */
 int ust_metadata_session_statedump(struct ust_registry_session *session,
-		struct ust_app *app)
+		struct ust_app *app,
+		uint32_t major,
+		uint32_t minor)
 {
 	unsigned char *uuid_c;
 	char uuid_s[UUID_STR_LEN],
@@ -529,7 +531,6 @@ int ust_metadata_session_statedump(struct ust_registry_session *session,
 	char hostname[HOST_NAME_MAX];
 
 	assert(session);
-	assert(app);
 
 	uuid_c = session->uuid;
 
@@ -585,12 +586,10 @@ int ust_metadata_session_statedump(struct ust_registry_session *session,
 		"	domain = \"ust\";\n"
 		"	tracer_name = \"lttng-ust\";\n"
 		"	tracer_major = %u;\n"
-		"	tracer_minor = %u;\n"
-		"	tracer_patchlevel = %u;\n",
+		"	tracer_minor = %u;\n",
 		hostname,
-		app->version.major,
-		app->version.minor,
-		app->version.patchlevel
+		major,
+		minor
 		);
 	if (ret)
 		goto end;
@@ -601,8 +600,10 @@ int ust_metadata_session_statedump(struct ust_registry_session *session,
 	 */
 	if (app) {
 		ret = lttng_metadata_printf(session,
+			"	tracer_patchlevel = %u;\n"
 			"	vpid = %d;\n"
 			"	procname = \"%s\";\n",
+			app->version.patchlevel,
 			(int) app->pid,
 			app->name
 			);
diff --git a/src/bin/lttng-sessiond/ust-registry.c b/src/bin/lttng-sessiond/ust-registry.c
index 19cff09..6c483e4 100644
--- a/src/bin/lttng-sessiond/ust-registry.c
+++ b/src/bin/lttng-sessiond/ust-registry.c
@@ -452,13 +452,14 @@ int ust_registry_session_init(struct ust_registry_session **sessionp,
 		uint32_t uint32_t_alignment,
 		uint32_t uint64_t_alignment,
 		uint32_t long_alignment,
-		int byte_order)
+		int byte_order,
+		uint32_t major,
+		uint32_t minor)
 {
 	int ret;
 	struct ust_registry_session *session;
 
 	assert(sessionp);
-	assert(app);
 
 	session = zmalloc(sizeof(*session));
 	if (!session) {
@@ -487,7 +488,7 @@ int ust_registry_session_init(struct ust_registry_session **sessionp,
 	}
 
 	pthread_mutex_lock(&session->lock);
-	ret = ust_metadata_session_statedump(session, app);
+	ret = ust_metadata_session_statedump(session, app, major, minor);
 	pthread_mutex_unlock(&session->lock);
 	if (ret) {
 		ERR("Failed to generate session metadata (errno = %d)", ret);
diff --git a/src/bin/lttng-sessiond/ust-registry.h b/src/bin/lttng-sessiond/ust-registry.h
index 1500f74..3cd474b 100644
--- a/src/bin/lttng-sessiond/ust-registry.h
+++ b/src/bin/lttng-sessiond/ust-registry.h
@@ -216,7 +216,9 @@ int ust_registry_session_init(struct ust_registry_session **sessionp,
 		uint32_t uint32_t_alignment,
 		uint32_t uint64_t_alignment,
 		uint32_t long_alignment,
-		int byte_order);
+		int byte_order,
+		uint32_t major,
+		uint32_t minor);
 void ust_registry_session_destroy(struct ust_registry_session *session);
 
 int ust_registry_create_event(struct ust_registry_session *session,
@@ -230,7 +232,7 @@ void ust_registry_destroy_event(struct ust_registry_channel *chan,
 
 /* app can be NULL for registry shared across applications. */
 int ust_metadata_session_statedump(struct ust_registry_session *session,
-		struct ust_app *app);
+		struct ust_app *app, uint32_t major, uint32_t minor);
 int ust_metadata_channel_statedump(struct ust_registry_session *session,
 		struct ust_registry_channel *chan);
 int ust_metadata_event_statedump(struct ust_registry_session *session,

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
