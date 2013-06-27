From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS 2.2 PATCH] Fix: send per-pid session id in
	channel creation
Date: Thu, 27 Jun 2013 17:57:06 -0400
Message-ID: <1372370226-24980-1-git-send-email-jdesfossez__219.252418219362$1372370249$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1UsKBQ-0005VC-MT
	for lttng-dev@lists.lttng.org; Thu, 27 Jun 2013 17:56:53 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

The registry indexing for per-pid sessions is done with a per-pid session id.
So for per-pid buffers, we need to send the per-pid session id as well as the
global session id to the consumer in order to give it enough information if it
needs to request metadata later.

This patch adds the session_id_per_pid to the channel creation message and to
the consumer. When the sessiond receives a metadata_request, depending on the
buffer type (per-pid or per-uid), it selects the right id to do the registry
lookup.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 src/bin/lttng-sessiond/consumer.c            |    4 +++-
 src/bin/lttng-sessiond/consumer.h            |    3 ++-
 src/bin/lttng-sessiond/ust-consumer.c        |   11 ++++++-----
 src/common/consumer.c                        |    4 +++-
 src/common/consumer.h                        |    8 +++++++-
 src/common/kernel-consumer/kernel-consumer.c |    2 +-
 src/common/sessiond-comm/sessiond-comm.h     |    4 +++-
 src/common/ust-consumer/ust-consumer.c       |   18 ++++++++++++------
 8 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/src/bin/lttng-sessiond/consumer.c b/src/bin/lttng-sessiond/consumer.c
index 2e20878..345a5a1 100644
--- a/src/bin/lttng-sessiond/consumer.c
+++ b/src/bin/lttng-sessiond/consumer.c
@@ -684,7 +684,8 @@ void consumer_init_ask_channel_comm_msg(struct lttcomm_consumer_msg *msg,
 		unsigned char *uuid,
 		uint32_t chan_id,
 		uint64_t tracefile_size,
-		uint64_t tracefile_count)
+		uint64_t tracefile_count,
+		uint64_t session_id_per_pid)
 {
 	assert(msg);
 
@@ -700,6 +701,7 @@ void consumer_init_ask_channel_comm_msg(struct lttcomm_consumer_msg *msg,
 	msg->u.ask_channel.output = output;
 	msg->u.ask_channel.type = type;
 	msg->u.ask_channel.session_id = session_id;
+	msg->u.ask_channel.session_id_per_pid = session_id_per_pid;
 	msg->u.ask_channel.uid = uid;
 	msg->u.ask_channel.gid = gid;
 	msg->u.ask_channel.relayd_id = relayd_id;
diff --git a/src/bin/lttng-sessiond/consumer.h b/src/bin/lttng-sessiond/consumer.h
index 09f4545..ae28ca8 100644
--- a/src/bin/lttng-sessiond/consumer.h
+++ b/src/bin/lttng-sessiond/consumer.h
@@ -202,7 +202,8 @@ void consumer_init_ask_channel_comm_msg(struct lttcomm_consumer_msg *msg,
 		unsigned char *uuid,
 		uint32_t chan_id,
 		uint64_t tracefile_size,
-		uint64_t tracefile_count);
+		uint64_t tracefile_count,
+		uint64_t session_id_per_pid);
 void consumer_init_stream_comm_msg(struct lttcomm_consumer_msg *msg,
 		enum lttng_consumer_command cmd,
 		uint64_t channel_key,
diff --git a/src/bin/lttng-sessiond/ust-consumer.c b/src/bin/lttng-sessiond/ust-consumer.c
index 367e92c..e287fae 100644
--- a/src/bin/lttng-sessiond/ust-consumer.c
+++ b/src/bin/lttng-sessiond/ust-consumer.c
@@ -157,7 +157,8 @@ static int ask_channel_creation(struct ust_app_session *ua_sess,
 			registry->uuid,
 			chan_id,
 			ua_chan->tracefile_size,
-			ua_chan->tracefile_count);
+			ua_chan->tracefile_count,
+			ua_sess->id);
 
 	health_code_update();
 
@@ -445,7 +446,7 @@ int ust_consumer_metadata_request(struct consumer_socket *socket)
 		goto end;
 	}
 
-	DBG("Metadata request received for session %u, key %" PRIu64,
+	DBG("Metadata request received for session %" PRIu64 ", key %" PRIu64,
 			request.session_id, request.key);
 
 	reg_uid = buffer_reg_uid_find(request.session_id,
@@ -454,10 +455,10 @@ int ust_consumer_metadata_request(struct consumer_socket *socket)
 		ust_reg = reg_uid->registry->reg.ust;
 	} else {
 		struct buffer_reg_pid *reg_pid =
-			buffer_reg_pid_find(request.session_id);
+			buffer_reg_pid_find(request.session_id_per_pid);
 		if (!reg_pid) {
-			DBG("PID registry not found for session id %u",
-					request.session_id);
+			DBG("PID registry not found for session id %" PRIu64,
+					request.session_id_per_pid);
 
 			msg.cmd_type = LTTNG_ERR_UND;
 			(void) consumer_send_msg(socket, &msg);
diff --git a/src/common/consumer.c b/src/common/consumer.c
index 540c59f..1b319f5 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -858,7 +858,8 @@ struct lttng_consumer_channel *consumer_allocate_channel(uint64_t key,
 		uint64_t relayd_id,
 		enum lttng_event_output output,
 		uint64_t tracefile_size,
-		uint64_t tracefile_count)
+		uint64_t tracefile_count,
+		uint64_t session_id_per_pid)
 {
 	struct lttng_consumer_channel *channel;
 
@@ -871,6 +872,7 @@ struct lttng_consumer_channel *consumer_allocate_channel(uint64_t key,
 	channel->key = key;
 	channel->refcount = 0;
 	channel->session_id = session_id;
+	channel->session_id_per_pid = session_id_per_pid;
 	channel->uid = uid;
 	channel->gid = gid;
 	channel->relayd_id = relayd_id;
diff --git a/src/common/consumer.h b/src/common/consumer.h
index 650397a..b3810e0 100644
--- a/src/common/consumer.h
+++ b/src/common/consumer.h
@@ -102,6 +102,11 @@ struct lttng_consumer_channel {
 	int refcount;
 	/* Tracing session id on the session daemon side. */
 	uint64_t session_id;
+	/*
+	 * Session id when requesting metadata to the session daemon for
+	 * a session with per-PID buffers.
+	 */
+	uint64_t session_id_per_pid;
 	/* Channel trace file path name. */
 	char pathname[PATH_MAX];
 	/* Channel name. */
@@ -472,7 +477,8 @@ struct lttng_consumer_channel *consumer_allocate_channel(uint64_t key,
 		uint64_t relayd_id,
 		enum lttng_event_output output,
 		uint64_t tracefile_size,
-		uint64_t tracefile_count);
+		uint64_t tracefile_count,
+		uint64_t session_id_per_pid);
 void consumer_del_stream(struct lttng_consumer_stream *stream,
 		struct lttng_ht *ht);
 void consumer_del_metadata_stream(struct lttng_consumer_stream *stream,
diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
index 11830fc..fc86965 100644
--- a/src/common/kernel-consumer/kernel-consumer.c
+++ b/src/common/kernel-consumer/kernel-consumer.c
@@ -144,7 +144,7 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 				msg.u.channel.name, msg.u.channel.uid, msg.u.channel.gid,
 				msg.u.channel.relayd_id, msg.u.channel.output,
 				msg.u.channel.tracefile_size,
-				msg.u.channel.tracefile_count);
+				msg.u.channel.tracefile_count, 0);
 		if (new_channel == NULL) {
 			lttng_consumer_send_error(ctx, LTTCOMM_CONSUMERD_OUTFD_ERROR);
 			goto end_nosignal;
diff --git a/src/common/sessiond-comm/sessiond-comm.h b/src/common/sessiond-comm/sessiond-comm.h
index c0b89a1..64c8d18 100644
--- a/src/common/sessiond-comm/sessiond-comm.h
+++ b/src/common/sessiond-comm/sessiond-comm.h
@@ -150,7 +150,8 @@ enum lttcomm_metadata_command {
  * per PID registry indexed by session id ignoring the other values.
  */
 struct lttcomm_metadata_request_msg {
-	unsigned int session_id; /* Tracing session id */
+	uint64_t session_id; /* Tracing session id */
+	uint64_t session_id_per_pid; /* Tracing session id for per-pid */
 	uint32_t bits_per_long; /* Consumer ABI */
 	uint32_t uid;
 	uint64_t key; /* Metadata channel key. */
@@ -342,6 +343,7 @@ struct lttcomm_consumer_msg {
 			uint32_t chan_id;			/* Channel ID on the tracer side. */
 			uint64_t tracefile_size;	/* bytes */
 			uint32_t tracefile_count;	/* number of tracefiles */
+			uint64_t session_id_per_pid;	/* Per-pid session ID. */
 		} LTTNG_PACKED ask_channel;
 		struct {
 			uint64_t key;
diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index f783d40..e8e36d7 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -114,13 +114,15 @@ error:
 static struct lttng_consumer_channel *allocate_channel(uint64_t session_id,
 		const char *pathname, const char *name, uid_t uid, gid_t gid,
 		int relayd_id, uint64_t key, enum lttng_event_output output,
-		uint64_t tracefile_size, uint64_t tracefile_count)
+		uint64_t tracefile_size, uint64_t tracefile_count,
+		uint64_t session_id_per_pid)
 {
 	assert(pathname);
 	assert(name);
 
-	return consumer_allocate_channel(key, session_id, pathname, name, uid, gid,
-			relayd_id, output, tracefile_size, tracefile_count);
+	return consumer_allocate_channel(key, session_id, pathname, name, uid,
+			gid, relayd_id, output, tracefile_size,
+			tracefile_count, session_id_per_pid);
 }
 
 /*
@@ -924,7 +926,8 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 				msg.u.ask_channel.relayd_id, msg.u.ask_channel.key,
 				(enum lttng_event_output) msg.u.ask_channel.output,
 				msg.u.ask_channel.tracefile_size,
-				msg.u.ask_channel.tracefile_count);
+				msg.u.ask_channel.tracefile_count,
+				msg.u.ask_channel.session_id_per_pid);
 		if (!channel) {
 			goto end_channel_error;
 		}
@@ -1500,10 +1503,13 @@ int lttng_ustconsumer_request_metadata(struct lttng_consumer_local_data *ctx,
 	}
 
 	request.session_id = channel->session_id;
+	request.session_id_per_pid = channel->session_id_per_pid;
 	request.uid = channel->uid;
 	request.key = channel->key;
-	DBG("Sending metadata request to sessiond, session %" PRIu64,
-			channel->session_id);
+	DBG("Sending metadata request to sessiond, session id %" PRIu64
+			", per-pid %" PRIu64,
+			channel->session_id,
+			channel->session_id_per_pid);
 
 	ret = lttcomm_send_unix_sock(ctx->consumer_metadata_socket, &request,
 			sizeof(request));
-- 
1.7.9.5
