From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 2.2] Fix: sessiond: use uint64_t for
	all	session ids
Date: Fri, 28 Jun 2013 12:19:51 -0400
Message-ID: <20130628161951.GB21417__38041.467316407$1372436432$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UsbOr-00065G-Pw
	for lttng-dev@lists.lttng.org; Fri, 28 Jun 2013 12:19:53 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/src/bin/lttng-sessiond/buffer-registry.c b/src/bin/lttng-sessiond/buffer-registry.c
index e64e437..93da2f1 100644
--- a/src/bin/lttng-sessiond/buffer-registry.c
+++ b/src/bin/lttng-sessiond/buffer-registry.c
@@ -104,7 +104,7 @@ void buffer_reg_init_uid_registry(void)
  *
  * Return 0 on success else a negative value and regp is untouched.
  */
-int buffer_reg_uid_create(int session_id, uint32_t bits_per_long, uid_t uid,
+int buffer_reg_uid_create(uint64_t session_id, uint32_t bits_per_long, uid_t uid,
 		enum lttng_domain_type domain, struct buffer_reg_uid **regp)
 {
 	int ret = 0;
@@ -140,7 +140,7 @@ int buffer_reg_uid_create(int session_id, uint32_t bits_per_long, uid_t uid,
 	cds_lfht_node_init(&reg->node.node);
 	*regp = reg;
 
-	DBG3("Buffer registry per UID created id: %d, ABI: %u, uid: %d, domain: %d",
+	DBG3("Buffer registry per UID created id: %" PRIu64 ", ABI: %u, uid: %d, domain: %d",
 			session_id, bits_per_long, uid, domain);
 
 	return 0;
@@ -162,7 +162,7 @@ void buffer_reg_uid_add(struct buffer_reg_uid *reg)
 
 	assert(reg);
 
-	DBG3("Buffer registry per UID adding to global registry with id: %d",
+	DBG3("Buffer registry per UID adding to global registry with id: %" PRIu64 ,
 			reg->session_id);
 
 	rcu_read_lock();
@@ -178,7 +178,7 @@ void buffer_reg_uid_add(struct buffer_reg_uid *reg)
  *
  * Return the object pointer or NULL on error.
  */
-struct buffer_reg_uid *buffer_reg_uid_find(int session_id,
+struct buffer_reg_uid *buffer_reg_uid_find(uint64_t session_id,
 		uint32_t bits_per_long, uid_t uid)
 {
 	struct lttng_ht_node_u64 *node;
@@ -191,7 +191,7 @@ struct buffer_reg_uid *buffer_reg_uid_find(int session_id,
 	key.bits_per_long = bits_per_long;
 	key.uid = uid;
 
-	DBG3("Buffer registry per UID find id: %d, ABI: %u, uid: %d",
+	DBG3("Buffer registry per UID find id: %" PRIu64 ", ABI: %u, uid: %d",
 			session_id, bits_per_long, uid);
 
 	/* Custom lookup function since it's a different key. */
@@ -214,7 +214,7 @@ void buffer_reg_init_pid_registry(void)
 {
 	/* Should be called once. */
 	assert(!buffer_registry_pid);
-	buffer_registry_pid = lttng_ht_new(0, LTTNG_HT_TYPE_ULONG);
+	buffer_registry_pid = lttng_ht_new(0, LTTNG_HT_TYPE_U64);
 	assert(buffer_registry_pid);
 
 	DBG3("Global buffer per PID registry initialized");
@@ -225,7 +225,7 @@ void buffer_reg_init_pid_registry(void)
  *
  * Return 0 on success else a negative value and regp is untouched.
  */
-int buffer_reg_pid_create(int session_id, struct buffer_reg_pid **regp)
+int buffer_reg_pid_create(uint64_t session_id, struct buffer_reg_pid **regp)
 {
 	int ret = 0;
 	struct buffer_reg_pid *reg = NULL;
@@ -255,10 +255,11 @@ int buffer_reg_pid_create(int session_id, struct buffer_reg_pid **regp)
 		goto error_session;
 	}
 
-	lttng_ht_node_init_ulong(&reg->node, reg->session_id);
+	lttng_ht_node_init_u64(&reg->node, reg->session_id);
 	*regp = reg;
 
-	DBG3("Buffer registry per PID created with session id: %d", session_id);
+	DBG3("Buffer registry per PID created with session id: %" PRIu64,
+			session_id);
 
 	return 0;
 
@@ -276,11 +277,11 @@ void buffer_reg_pid_add(struct buffer_reg_pid *reg)
 {
 	assert(reg);
 
-	DBG3("Buffer registry per PID adding to global registry with id: %d",
+	DBG3("Buffer registry per PID adding to global registry with id: %" PRIu64,
 			reg->session_id);
 
 	rcu_read_lock();
-	lttng_ht_add_unique_ulong(buffer_registry_pid, &reg->node);
+	lttng_ht_add_unique_u64(buffer_registry_pid, &reg->node);
 	rcu_read_unlock();
 }
 
@@ -290,17 +291,17 @@ void buffer_reg_pid_add(struct buffer_reg_pid *reg)
  *
  * Return the object pointer or NULL on error.
  */
-struct buffer_reg_pid *buffer_reg_pid_find(int session_id)
+struct buffer_reg_pid *buffer_reg_pid_find(uint64_t session_id)
 {
-	struct lttng_ht_node_ulong *node;
+	struct lttng_ht_node_u64 *node;
 	struct lttng_ht_iter iter;
 	struct buffer_reg_pid *reg = NULL;
 	struct lttng_ht *ht = buffer_registry_pid;
 
-	DBG3("Buffer registry per PID find id: %d", session_id);
+	DBG3("Buffer registry per PID find id: %" PRIu64, session_id);
 
-	lttng_ht_lookup(ht, (void *)((unsigned long) session_id), &iter);
-	node = lttng_ht_iter_get_node_ulong(&iter);
+	lttng_ht_lookup(ht, &session_id, &iter);
+	node = lttng_ht_iter_get_node_u64(&iter);
 	if (!node) {
 		goto end;
 	}
@@ -594,8 +595,8 @@ static void rcu_free_buffer_reg_uid(struct rcu_head *head)
 
 static void rcu_free_buffer_reg_pid(struct rcu_head *head)
 {
-	struct lttng_ht_node_ulong *node =
-		caa_container_of(head, struct lttng_ht_node_ulong, head);
+	struct lttng_ht_node_u64 *node =
+		caa_container_of(head, struct lttng_ht_node_u64, head);
 	struct buffer_reg_pid *reg =
 		caa_container_of(node, struct buffer_reg_pid, node);
 
@@ -617,7 +618,7 @@ void buffer_reg_uid_destroy(struct buffer_reg_uid *regp,
 		return;
 	}
 
-	DBG3("Buffer registry per UID destroy with id: %d, ABI: %u, uid: %d",
+	DBG3("Buffer registry per UID destroy with id: %" PRIu64 ", ABI: %u, uid: %d",
 			regp->session_id, regp->bits_per_long, regp->uid);
 
 	if (!consumer) {
@@ -679,7 +680,8 @@ void buffer_reg_pid_destroy(struct buffer_reg_pid *regp)
 		return;
 	}
 
-	DBG3("Buffer registry per PID destroy with id: %d", regp->session_id);
+	DBG3("Buffer registry per PID destroy with id: %" PRIu64,
+			regp->session_id);
 
 	/* This registry is only used by UST. */
 	call_rcu(&regp->node.head, rcu_free_buffer_reg_pid);
diff --git a/src/bin/lttng-sessiond/buffer-registry.h b/src/bin/lttng-sessiond/buffer-registry.h
index d77a071..cb976dc 100644
--- a/src/bin/lttng-sessiond/buffer-registry.h
+++ b/src/bin/lttng-sessiond/buffer-registry.h
@@ -71,7 +71,7 @@ struct buffer_reg_uid {
 	 * Keys to match this object in a hash table. The following three variables
 	 * identify a unique per UID buffer registry.
 	 */
-	int session_id;		/* Unique tracing session id. */
+	uint64_t session_id;	/* Unique tracing session id. */
 	int bits_per_long;	/* ABI */
 	uid_t uid;			/* Owner. */
 
@@ -88,20 +88,20 @@ struct buffer_reg_uid {
  * Registry object for per PID buffers.
  */
 struct buffer_reg_pid {
-	int session_id;
+	uint64_t session_id;
 
 	struct buffer_reg_session *registry;
 
 	/* Indexed by session id. */
-	struct lttng_ht_node_ulong node;
+	struct lttng_ht_node_u64 node;
 };
 
 /* Buffer registry per UID. */
 void buffer_reg_init_uid_registry(void);
-int buffer_reg_uid_create(int session_id, uint32_t bits_per_long, uid_t uid,
+int buffer_reg_uid_create(uint64_t session_id, uint32_t bits_per_long, uid_t uid,
 		enum lttng_domain_type domain, struct buffer_reg_uid **regp);
 void buffer_reg_uid_add(struct buffer_reg_uid *reg);
-struct buffer_reg_uid *buffer_reg_uid_find(int session_id,
+struct buffer_reg_uid *buffer_reg_uid_find(uint64_t session_id,
 		uint32_t bits_per_long, uid_t uid);
 void buffer_reg_uid_remove(struct buffer_reg_uid *regp);
 void buffer_reg_uid_destroy(struct buffer_reg_uid *regp,
@@ -109,9 +109,9 @@ void buffer_reg_uid_destroy(struct buffer_reg_uid *regp,
 
 /* Buffer registry per PID. */
 void buffer_reg_init_pid_registry(void);
-int buffer_reg_pid_create(int session_id, struct buffer_reg_pid **regp);
+int buffer_reg_pid_create(uint64_t session_id, struct buffer_reg_pid **regp);
 void buffer_reg_pid_add(struct buffer_reg_pid *reg);
-struct buffer_reg_pid *buffer_reg_pid_find(int session_id);
+struct buffer_reg_pid *buffer_reg_pid_find(uint64_t session_id);
 void buffer_reg_pid_remove(struct buffer_reg_pid *regp);
 void buffer_reg_pid_destroy(struct buffer_reg_pid *regp);
 
diff --git a/src/bin/lttng-sessiond/trace-ust.c b/src/bin/lttng-sessiond/trace-ust.c
index 2c63ef0..65fe84b 100644
--- a/src/bin/lttng-sessiond/trace-ust.c
+++ b/src/bin/lttng-sessiond/trace-ust.c
@@ -20,6 +20,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <inttypes.h>
 
 #include <common/common.h>
 #include <common/defaults.h>
@@ -181,7 +182,7 @@ error:
  *
  * Return pointer to structure or NULL.
  */
-struct ltt_ust_session *trace_ust_create_session(unsigned int session_id)
+struct ltt_ust_session *trace_ust_create_session(uint64_t session_id)
 {
 	struct ltt_ust_session *lus;
 
@@ -646,7 +647,7 @@ void trace_ust_destroy_session(struct ltt_ust_session *session)
 
 	assert(session);
 
-	DBG2("Trace UST destroy session %u", session->id);
+	DBG2("Trace UST destroy session %" PRIu64, session->id);
 
 	/* Cleaning up UST domain */
 	destroy_domain_global(&session->domain_global);
diff --git a/src/bin/lttng-sessiond/trace-ust.h b/src/bin/lttng-sessiond/trace-ust.h
index dcb45c2..f5df133 100644
--- a/src/bin/lttng-sessiond/trace-ust.h
+++ b/src/bin/lttng-sessiond/trace-ust.h
@@ -79,7 +79,7 @@ struct ltt_ust_domain_global {
 
 /* UST session */
 struct ltt_ust_session {
-	int id;    /* Unique identifier of session */
+	uint64_t id;    /* Unique identifier of session */
 	int start_trace;
 	struct ltt_ust_domain_global domain_global;
 	/* UID/GID of the user owning the session */
@@ -153,7 +153,7 @@ struct ltt_ust_channel *trace_ust_find_channel_by_name(struct lttng_ht *ht,
 /*
  * Create functions malloc() the data structure.
  */
-struct ltt_ust_session *trace_ust_create_session(unsigned int session_id);
+struct ltt_ust_session *trace_ust_create_session(uint64_t session_id);
 struct ltt_ust_channel *trace_ust_create_channel(struct lttng_channel *attr);
 struct ltt_ust_event *trace_ust_create_event(struct lttng_event *ev,
 		struct lttng_filter_bytecode *filter);
diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 0f553a6..eea0d8c 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -40,24 +40,38 @@
 #include "ust-ctl.h"
 #include "utils.h"
 
-/* Next available channel key. */
-static unsigned long next_channel_key;
-static unsigned long next_session_id;
+/* Next available channel key. Access under next_channel_key_lock. */
+static uint64_t _next_channel_key;
+static pthread_mutex_t next_channel_key_lock = PTHREAD_MUTEX_INITIALIZER;
+
+/* Next available session ID. Access under next_session_id_lock. */
+static uint64_t _next_session_id;
+static pthread_mutex_t next_session_id_lock = PTHREAD_MUTEX_INITIALIZER;
 
 /*
- * Return the atomically incremented value of next_channel_key.
+ * Return the incremented value of next_channel_key.
  */
-static inline unsigned long get_next_channel_key(void)
+static uint64_t get_next_channel_key(void)
 {
-	return uatomic_add_return(&next_channel_key, 1);
+	uint64_t ret;
+
+	pthread_mutex_lock(&next_channel_key_lock);
+	ret = ++_next_channel_key;
+	pthread_mutex_unlock(&next_channel_key_lock);
+	return ret;
 }
 
 /*
  * Return the atomically incremented value of next_session_id.
  */
-static inline unsigned long get_next_session_id(void)
+static uint64_t get_next_session_id(void)
 {
-	return uatomic_add_return(&next_session_id, 1);
+	uint64_t ret;
+
+	pthread_mutex_lock(&next_session_id_lock);
+	ret = ++_next_session_id;
+	pthread_mutex_unlock(&next_session_id_lock);
+	return ret;
 }
 
 static void copy_channel_attr_to_ustctl(
@@ -1503,7 +1517,7 @@ void __lookup_session_by_app(struct ltt_ust_session *usess,
 			struct ust_app *app, struct lttng_ht_iter *iter)
 {
 	/* Get right UST app session from app */
-	lttng_ht_lookup(app->sessions, (void *)((unsigned long) usess->id), iter);
+	lttng_ht_lookup(app->sessions, &usess->id, iter);
 }
 
 /*
@@ -1514,10 +1528,10 @@ static struct ust_app_session *lookup_session_by_app(
 		struct ltt_ust_session *usess, struct ust_app *app)
 {
 	struct lttng_ht_iter iter;
-	struct lttng_ht_node_ulong *node;
+	struct lttng_ht_node_u64 *node;
 
 	__lookup_session_by_app(usess, app, &iter);
-	node = lttng_ht_iter_get_node_ulong(&iter);
+	node = lttng_ht_iter_get_node_u64(&iter);
 	if (node == NULL) {
 		goto error;
 	}
@@ -1667,7 +1681,7 @@ static int create_ust_app_session(struct ltt_ust_session *usess,
 
 	ua_sess = lookup_session_by_app(usess, app);
 	if (ua_sess == NULL) {
-		DBG2("UST app pid: %d session id %d not found, creating it",
+		DBG2("UST app pid: %d session id %" PRIu64 " not found, creating it",
 				app->pid, usess->id);
 		ua_sess = alloc_ust_app_session(app);
 		if (ua_sess == NULL) {
@@ -1725,9 +1739,9 @@ static int create_ust_app_session(struct ltt_ust_session *usess,
 		ua_sess->handle = ret;
 
 		/* Add ust app session to app's HT */
-		lttng_ht_node_init_ulong(&ua_sess->node,
-				(unsigned long) ua_sess->tracing_id);
-		lttng_ht_add_unique_ulong(app->sessions, &ua_sess->node);
+		lttng_ht_node_init_u64(&ua_sess->node,
+				ua_sess->tracing_id);
+		lttng_ht_add_unique_u64(app->sessions, &ua_sess->node);
 
 		DBG2("UST app session created successfully with handle %d", ret);
 	}
@@ -1864,7 +1878,7 @@ static int enable_ust_app_channel(struct ust_app_session *ua_sess,
 	lttng_ht_lookup(ua_sess->channels, (void *)uchan->name, &iter);
 	ua_chan_node = lttng_ht_iter_get_node_str(&iter);
 	if (ua_chan_node == NULL) {
-		DBG2("Unable to find channel %s in ust session id %u",
+		DBG2("Unable to find channel %s in ust session id %" PRIu64,
 				uchan->name, ua_sess->tracing_id);
 		goto error;
 	}
@@ -2719,7 +2733,7 @@ struct ust_app *ust_app_create(struct ust_register_msg *msg, int sock)
 
 	lta->v_major = msg->major;
 	lta->v_minor = msg->minor;
-	lta->sessions = lttng_ht_new(0, LTTNG_HT_TYPE_ULONG);
+	lta->sessions = lttng_ht_new(0, LTTNG_HT_TYPE_U64);
 	lta->ust_objd = lttng_ht_new(0, LTTNG_HT_TYPE_ULONG);
 	lta->notify_sock = -1;
 
@@ -3188,7 +3202,7 @@ int ust_app_disable_channel_glb(struct ltt_ust_session *usess,
 		goto error;
 	}
 
-	DBG2("UST app disabling channel %s from global domain for session id %d",
+	DBG2("UST app disabling channel %s from global domain for session id %" PRIu64,
 			uchan->name, usess->id);
 
 	rcu_read_lock();
@@ -3249,7 +3263,7 @@ int ust_app_enable_channel_glb(struct ltt_ust_session *usess,
 		goto error;
 	}
 
-	DBG2("UST app enabling channel %s to global domain for session id %d",
+	DBG2("UST app enabling channel %s to global domain for session id %" PRIu64,
 			uchan->name, usess->id);
 
 	rcu_read_lock();
@@ -3297,7 +3311,8 @@ int ust_app_disable_event_glb(struct ltt_ust_session *usess,
 	struct ust_app_event *ua_event;
 
 	DBG("UST app disabling event %s for all apps in channel "
-			"%s for session id %d", uevent->attr.name, uchan->name, usess->id);
+			"%s for session id %" PRIu64,
+			uevent->attr.name, uchan->name, usess->id);
 
 	rcu_read_lock();
 
@@ -3320,7 +3335,7 @@ int ust_app_disable_event_glb(struct ltt_ust_session *usess,
 		lttng_ht_lookup(ua_sess->channels, (void *)uchan->name, &uiter);
 		ua_chan_node = lttng_ht_iter_get_node_str(&uiter);
 		if (ua_chan_node == NULL) {
-			DBG2("Channel %s not found in session id %d for app pid %d."
+			DBG2("Channel %s not found in session id %" PRIu64 " for app pid %d."
 					"Skipping", uchan->name, usess->id, app->pid);
 			continue;
 		}
@@ -3363,7 +3378,7 @@ int ust_app_disable_all_event_glb(struct ltt_ust_session *usess,
 	struct ust_app_event *ua_event;
 
 	DBG("UST app disabling all event for all apps in channel "
-			"%s for session id %d", uchan->name, usess->id);
+			"%s for session id %" PRIu64, uchan->name, usess->id);
 
 	rcu_read_lock();
 
@@ -3421,7 +3436,7 @@ int ust_app_create_channel_glb(struct ltt_ust_session *usess,
 	assert(usess);
 	assert(uchan);
 
-	DBG2("UST app adding channel %s to UST domain for session id %d",
+	DBG2("UST app adding channel %s to UST domain for session id %" PRIu64,
 			uchan->name, usess->id);
 
 	rcu_read_lock();
@@ -3501,7 +3516,7 @@ int ust_app_enable_event_glb(struct ltt_ust_session *usess,
 	struct ust_app_channel *ua_chan;
 	struct ust_app_event *ua_event;
 
-	DBG("UST app enabling event %s for all apps for session id %d",
+	DBG("UST app enabling event %s for all apps for session id %" PRIu64,
 			uevent->attr.name, usess->id);
 
 	/*
@@ -3574,7 +3589,7 @@ int ust_app_create_event_glb(struct ltt_ust_session *usess,
 	struct ust_app_session *ua_sess;
 	struct ust_app_channel *ua_chan;
 
-	DBG("UST app creating event %s for all apps for session id %d",
+	DBG("UST app creating event %s for all apps for session id %" PRIu64,
 			uevent->attr.name, usess->id);
 
 	rcu_read_lock();
@@ -3861,7 +3876,7 @@ static int destroy_trace(struct ltt_ust_session *usess, struct ust_app *app)
 	int ret;
 	struct ust_app_session *ua_sess;
 	struct lttng_ht_iter iter;
-	struct lttng_ht_node_ulong *node;
+	struct lttng_ht_node_u64 *node;
 
 	DBG("Destroy tracing for ust app pid %d", app->pid);
 
@@ -3872,7 +3887,7 @@ static int destroy_trace(struct ltt_ust_session *usess, struct ust_app *app)
 	}
 
 	__lookup_session_by_app(usess, app, &iter);
-	node = lttng_ht_iter_get_node_ulong(&iter);
+	node = lttng_ht_iter_get_node_u64(&iter);
 	if (node == NULL) {
 		/* Session is being or is deleted. */
 		goto end;
@@ -4035,7 +4050,7 @@ void ust_app_global_update(struct ltt_ust_session *usess, int sock)
 	assert(usess);
 	assert(sock >= 0);
 
-	DBG2("UST app global update for app sock %d for session id %d", sock,
+	DBG2("UST app global update for app sock %d for session id %" PRIu64, sock,
 			usess->id);
 
 	rcu_read_lock();
diff --git a/src/bin/lttng-sessiond/ust-app.h b/src/bin/lttng-sessiond/ust-app.h
index 30835e0..c533fbf 100644
--- a/src/bin/lttng-sessiond/ust-app.h
+++ b/src/bin/lttng-sessiond/ust-app.h
@@ -175,10 +175,10 @@ struct ust_app_session {
 	 * Tracing session ID. Multiple ust app session can have the same tracing
 	 * session id making this value NOT unique to the object.
 	 */
-	int tracing_id;
+	uint64_t tracing_id;
 	uint64_t id;	/* Unique session identifier */
 	struct lttng_ht *channels; /* Registered channels */
-	struct lttng_ht_node_ulong node;
+	struct lttng_ht_node_u64 node;
 	char path[PATH_MAX];
 	/* UID/GID of the application owning the session */
 	uid_t uid;

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
