From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH 5/9] Extract the lost packets and
	discarded events counters
Date: Mon, 13 Jul 2015 11:28:05 -0400
Message-ID: <1436801289-17554-6-git-send-email-jdesfossez__18848.430660046$1436801539$gmane$org@efficios.com>
References: <1436801289-17554-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZEfed-0008PM-8o
 for lttng-dev@lists.lttng.org; Mon, 13 Jul 2015 11:28:31 -0400
In-Reply-To: <1436801289-17554-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com, mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

lttng list, now shows the number of discarded events (discard mode) or
lost packets (overwrite mode).

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 include/lttng/channel.h                      |   5 +-
 src/bin/lttng-sessiond/buffer-registry.c     |  39 +++++++
 src/bin/lttng-sessiond/buffer-registry.h     |   5 +
 src/bin/lttng-sessiond/cmd.c                 |  94 ++++++++++++++-
 src/bin/lttng-sessiond/consumer.c            | 108 +++++++++++++++++
 src/bin/lttng-sessiond/consumer.h            |   4 +
 src/bin/lttng-sessiond/trace-ust.h           |   2 +
 src/bin/lttng-sessiond/ust-app.c             | 122 ++++++++++++++++++-
 src/bin/lttng-sessiond/ust-app.h             |  25 ++++
 src/bin/lttng/commands/list.c                |   2 +
 src/common/config/config-session-abi.h       |   2 +
 src/common/config/config.c                   |   2 +
 src/common/config/session.xsd                |   2 +
 src/common/consumer.c                        |   1 +
 src/common/consumer.h                        |  13 +++
 src/common/kernel-consumer/kernel-consumer.c | 114 ++++++++++++++++++
 src/common/kernel-ctl/kernel-ctl.c           |   6 +
 src/common/kernel-ctl/kernel-ctl.h           |   1 +
 src/common/kernel-ctl/kernel-ioctl.h         |   2 +
 src/common/mi-lttng.c                        |  16 +++
 src/common/mi_lttng.xsd                      |   2 +
 src/common/sessiond-comm/sessiond-comm.h     |   8 ++
 src/common/ust-consumer/ust-consumer.c       | 167 +++++++++++++++++++++++++++
 src/common/ust-consumer/ust-consumer.h       |   7 ++
 24 files changed, 743 insertions(+), 6 deletions(-)

diff --git a/include/lttng/channel.h b/include/lttng/channel.h
index 6ab0c7b..be65b7b 100644
--- a/include/lttng/channel.h
+++ b/include/lttng/channel.h
@@ -30,7 +30,7 @@ extern "C" {
  *
  * The structures should be initialized to zero before use.
  */
-#define LTTNG_CHANNEL_ATTR_PADDING1        LTTNG_SYMBOL_NAME_LEN + 12
+#define LTTNG_CHANNEL_ATTR_PADDING1        LTTNG_SYMBOL_NAME_LEN - 4 /* 252  */
 struct lttng_channel_attr {
 	int overwrite;                      /* 1: overwrite, 0: discard */
 	uint64_t subbuf_size;               /* bytes */
@@ -43,6 +43,9 @@ struct lttng_channel_attr {
 	uint64_t tracefile_count;           /* number of tracefiles */
 	/* LTTng 2.3 padding limit */
 	unsigned int live_timer_interval;   /* usec */
+	/* LTTng 2.7 padding limit */
+	uint64_t discarded_events;          /* events */
+	uint64_t lost_packets;              /* packets */
 
 	char padding[LTTNG_CHANNEL_ATTR_PADDING1];
 };
diff --git a/src/bin/lttng-sessiond/buffer-registry.c b/src/bin/lttng-sessiond/buffer-registry.c
index b4667a4..372153e 100644
--- a/src/bin/lttng-sessiond/buffer-registry.c
+++ b/src/bin/lttng-sessiond/buffer-registry.c
@@ -329,6 +329,45 @@ end:
 }
 
 /*
+ * Find the consumer channel key from a UST session per-uid channel key.
+ *
+ * Return the matching key or -1 if not found.
+ */
+int buffer_reg_uid_consumer_channel_key(
+		struct cds_list_head *buffer_reg_uid_list,
+		uint64_t usess_id, uint64_t chan_key,
+		uint64_t *consumer_chan_key)
+{
+	struct lttng_ht_iter iter;
+	struct buffer_reg_uid *uid_reg = NULL;
+	struct buffer_reg_session *session_reg = NULL;
+	struct buffer_reg_channel *reg_chan;
+	int ret;
+
+	rcu_read_lock();
+	/*
+	 * For the per-uid registry, we have to iterate since we don't have the
+	 * uid and bitness key.
+	 */
+	cds_list_for_each_entry(uid_reg, buffer_reg_uid_list, lnode) {
+		session_reg = uid_reg->registry;
+		cds_lfht_for_each_entry(session_reg->channels->ht,
+				&iter.iter, reg_chan, node.node) {
+			if (reg_chan->key == chan_key) {
+				*consumer_chan_key = reg_chan->consumer_key;
+				ret = 0;
+				goto end;
+			}
+		}
+	}
+	ret = -1;
+
+end:
+	rcu_read_unlock();
+	return ret;
+}
+
+/*
  * Allocate and initialize a buffer registry channel with the given key. Set
  * regp with the object pointer.
  *
diff --git a/src/bin/lttng-sessiond/buffer-registry.h b/src/bin/lttng-sessiond/buffer-registry.h
index 7a817ec..db1ce0c 100644
--- a/src/bin/lttng-sessiond/buffer-registry.h
+++ b/src/bin/lttng-sessiond/buffer-registry.h
@@ -150,4 +150,9 @@ void buffer_reg_stream_destroy(struct buffer_reg_stream *regp,
 /* Global registry. */
 void buffer_reg_destroy_registries(void);
 
+int buffer_reg_uid_consumer_channel_key(
+		struct cds_list_head *buffer_reg_uid_list,
+		uint64_t usess_id, uint64_t chan_key,
+		uint64_t *consumer_chan_key);
+
 #endif /* LTTNG_BUFFER_REGISTRY_H */
diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
index a6ce344..b972547 100644
--- a/src/bin/lttng-sessiond/cmd.c
+++ b/src/bin/lttng-sessiond/cmd.c
@@ -129,12 +129,93 @@ error:
 }
 
 /*
+ * Get run-time attributes if the session has been started (discarded events,
+ * lost packets).
+ */
+static int get_kernel_runtime_stats(struct ltt_session *session,
+		struct ltt_kernel_channel *kchan)
+{
+	int ret;
+
+	if (!session->has_been_started) {
+		ret = 0;
+		goto end;
+	}
+
+	ret = consumer_get_discarded_events(session->id, kchan->fd,
+			session->kernel_session->consumer,
+			&kchan->channel->attr.discarded_events);
+	if (ret < 0) {
+		goto end;
+	}
+
+	ret = consumer_get_lost_packets(session->id, kchan->fd,
+			session->kernel_session->consumer,
+			&kchan->channel->attr.lost_packets);
+	if (ret < 0) {
+		goto end;
+	}
+
+end:
+	return ret;
+}
+
+/*
+ * Get run-time attributes if the session has been started (discarded events,
+ * lost packets).
+ */
+static int get_ust_runtime_stats(struct ltt_session *session,
+		struct ltt_ust_channel *uchan,
+		struct lttng_channel *channel)
+{
+
+	int ret;
+	struct ltt_ust_session *usess;
+
+	if (!session) {
+		ret = -1;
+		goto end;
+	}
+	usess = session->ust_session;
+
+	if (!usess || !session->has_been_started) {
+		ret = 0;
+		goto end;
+	}
+
+	if (usess->buffer_type == LTTNG_BUFFER_PER_UID) {
+		ret = ust_app_uid_channel_runtime_stats(usess->id,
+				&usess->buffer_reg_uid_list,
+				usess->consumer, uchan->id,
+				channel->attr.overwrite,
+				&channel->attr.discarded_events,
+				&channel->attr.lost_packets);
+	} else if (usess->buffer_type == LTTNG_BUFFER_PER_PID) {
+		ret = ust_app_pid_channel_runtime_stats(usess,
+				uchan, usess->consumer,
+				channel->attr.overwrite,
+				&channel->attr.discarded_events,
+				&channel->attr.lost_packets);
+		channel->attr.discarded_events += uchan->per_pid_closed_app_discarded;
+		channel->attr.lost_packets += uchan->per_pid_closed_app_lost;
+
+	} else {
+		ERR("Unsupported buffer type");
+		ret = -1;
+		goto end;
+	}
+
+end:
+	return ret;
+}
+
+/*
  * Fill lttng_channel array of all channels.
  */
 static void list_lttng_channels(int domain, struct ltt_session *session,
 		struct lttng_channel *channels)
 {
-	int i = 0;
+	int i = 0, ret;
 	struct ltt_kernel_channel *kchan;
 
 	DBG("Listing channels for session %s", session->name);
@@ -145,6 +226,10 @@ static void list_lttng_channels(int domain, struct ltt_session *session,
 		if (session->kernel_session != NULL) {
 			cds_list_for_each_entry(kchan,
 					&session->kernel_session->channel_list.head, list) {
+				ret = get_kernel_runtime_stats(session, kchan);
+				if (ret < 0) {
+					goto end;
+				}
 				/* Copy lttng_channel struct to array */
 				memcpy(&channels[i], kchan->channel, sizeof(struct lttng_channel));
 				channels[i].enabled = kchan->enabled;
@@ -177,6 +262,10 @@ static void list_lttng_channels(int domain, struct ltt_session *session,
 				channels[i].attr.output = LTTNG_EVENT_MMAP;
 				break;
 			}
+			ret = get_ust_runtime_stats(session, uchan, &channels[i]);
+			if (ret < 0) {
+				break;
+			}
 			i++;
 		}
 		rcu_read_unlock();
@@ -185,6 +274,9 @@ static void list_lttng_channels(int domain, struct ltt_session *session,
 	default:
 		break;
 	}
+
+end:
+	return;
 }
 
 /*
diff --git a/src/bin/lttng-sessiond/consumer.c b/src/bin/lttng-sessiond/consumer.c
index 87d5f34..a73749f 100644
--- a/src/bin/lttng-sessiond/consumer.c
+++ b/src/bin/lttng-sessiond/consumer.c
@@ -1357,3 +1357,111 @@ error:
 	health_code_update();
 	return ret;
 }
+
+/*
+ * Ask the consumer the number of discarded events for a channel.
+ */
+int consumer_get_discarded_events(uint64_t session_id, uint64_t channel_key,
+		struct consumer_output *consumer, uint64_t *discarded)
+{
+	int ret;
+	struct consumer_socket *socket;
+	struct lttng_ht_iter iter;
+	struct lttcomm_consumer_msg msg;
+
+	assert(consumer);
+
+	DBG3("Consumer discarded events id %" PRIu64, session_id);
+
+	memset(&msg, 0, sizeof(msg));
+	msg.cmd_type = LTTNG_CONSUMER_DISCARDED_EVENTS;
+	msg.u.discarded_events.session_id = session_id;
+	msg.u.discarded_events.channel_key = channel_key;
+
+	/* Send command for each consumer */
+	rcu_read_lock();
+	cds_lfht_for_each_entry(consumer->socks->ht, &iter.iter, socket,
+			node.node) {
+		pthread_mutex_lock(socket->lock);
+		ret = consumer_socket_send(socket, &msg, sizeof(msg));
+		if (ret < 0) {
+			pthread_mutex_unlock(socket->lock);
+			goto error_unlock;
+		}
+
+		/*
+		 * No need for a recv reply status because the answer to the
+		 * command is the reply status message.
+		 */
+		ret = consumer_socket_recv(socket, discarded, sizeof(*discarded));
+		if (ret < 0) {
+			ERR("get discarded events");
+			pthread_mutex_unlock(socket->lock);
+			goto error_unlock;
+		}
+		pthread_mutex_unlock(socket->lock);
+	}
+	rcu_read_unlock();
+
+	DBG("Consumer discarded %" PRIu64 " events in session id %" PRIu64,
+			*discarded, session_id);
+	return 0;
+
+error_unlock:
+	rcu_read_unlock();
+	return -1;
+}
+
+/*
+ * Ask the consumer the number of lost packets for a channel.
+ */
+int consumer_get_lost_packets(uint64_t session_id, uint64_t channel_key,
+		struct consumer_output *consumer, uint64_t *lost)
+{
+	int ret;
+	struct consumer_socket *socket;
+	struct lttng_ht_iter iter;
+	struct lttcomm_consumer_msg msg;
+
+	assert(consumer);
+
+	DBG3("Consumer lost packets id %" PRIu64, session_id);
+
+	memset(&msg, 0, sizeof(msg));
+	msg.cmd_type = LTTNG_CONSUMER_LOST_PACKETS;
+	msg.u.lost_packets.session_id = session_id;
+	msg.u.lost_packets.channel_key = channel_key;
+
+	/* Send command for each consumer */
+	rcu_read_lock();
+	cds_lfht_for_each_entry(consumer->socks->ht, &iter.iter, socket,
+			node.node) {
+		pthread_mutex_lock(socket->lock);
+		ret = consumer_socket_send(socket, &msg, sizeof(msg));
+		if (ret < 0) {
+			pthread_mutex_unlock(socket->lock);
+			goto error_unlock;
+		}
+
+		/*
+		 * No need for a recv reply status because the answer to the
+		 * command is the reply status message.
+		 */
+		ret = consumer_socket_recv(socket, lost, sizeof(*lost));
+		if (ret < 0) {
+			ERR("get lost packets");
+			pthread_mutex_unlock(socket->lock);
+			goto error_unlock;
+		}
+		pthread_mutex_unlock(socket->lock);
+	}
+	rcu_read_unlock();
+
+	DBG("Consumer lost %" PRIu64 " packets in session id %" PRIu64,
+			*lost, session_id);
+	return 0;
+
+error_unlock:
+	rcu_read_unlock();
+	return -1;
+}
diff --git a/src/bin/lttng-sessiond/consumer.h b/src/bin/lttng-sessiond/consumer.h
index e4845f5..98270ef 100644
--- a/src/bin/lttng-sessiond/consumer.h
+++ b/src/bin/lttng-sessiond/consumer.h
@@ -277,6 +277,10 @@ int consumer_push_metadata(struct consumer_socket *socket,
 		uint64_t metadata_key, char *metadata_str, size_t len,
 		size_t target_offset);
 int consumer_flush_channel(struct consumer_socket *socket, uint64_t key);
+int consumer_get_discarded_events(uint64_t session_id, uint64_t channel_key,
+		struct consumer_output *consumer, uint64_t *discarded);
+int consumer_get_lost_packets(uint64_t session_id, uint64_t channel_key,
+		struct consumer_output *consumer, uint64_t *lost);
 
 /* Snapshot command. */
 int consumer_snapshot_channel(struct consumer_socket *socket, uint64_t key,
diff --git a/src/bin/lttng-sessiond/trace-ust.h b/src/bin/lttng-sessiond/trace-ust.h
index c4dbe06..3b31751 100644
--- a/src/bin/lttng-sessiond/trace-ust.h
+++ b/src/bin/lttng-sessiond/trace-ust.h
@@ -66,6 +66,8 @@ struct ltt_ust_channel {
 	struct lttng_ht_node_str node;
 	uint64_t tracefile_size;
 	uint64_t tracefile_count;
+	uint64_t per_pid_closed_app_discarded;
+	uint64_t per_pid_closed_app_lost;
 };
 
 /* UST domain global (LTTNG_DOMAIN_UST) */
diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 564de69..ca17e6f 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -359,6 +359,31 @@ void delete_ust_app_channel_rcu(struct rcu_head *head)
 }
 
 /*
+ * Extract the lost packet or discarded events counter when the channel is
+ * being deleted and store the value in the parent channel so we can
+ * access it from lttng list and at stop/destroy.
+ */
+static
+void per_pid_lost_discarded(struct ust_app_channel *ua_chan)
+{
+	uint64_t discarded = 0, lost = 0;
+
+	if (ua_chan->attr.type != LTTNG_UST_CHAN_PER_CPU) {
+		return;
+	}
+
+	if (ua_chan->attr.overwrite) {
+		consumer_get_lost_packets(ua_chan->usess->id, ua_chan->key,
+				ua_chan->usess->consumer, &lost);
+	} else {
+		consumer_get_discarded_events(ua_chan->usess->id, ua_chan->key,
+				ua_chan->usess->consumer, &discarded);
+	}
+	ua_chan->uchan->per_pid_closed_app_discarded += discarded;
+	ua_chan->uchan->per_pid_closed_app_lost += lost;
+}
+
+/*
  * Delete ust app channel safely. RCU read lock must be held before calling
  * this function.
  */
@@ -405,6 +430,7 @@ void delete_ust_app_channel(int sock, struct ust_app_channel *ua_chan,
 		if (registry) {
 			ust_registry_channel_del_free(registry, ua_chan->key);
 		}
+		per_pid_lost_discarded(ua_chan);
 	}
 
 	if (ua_chan->obj != NULL) {
@@ -847,7 +873,9 @@ error_free:
 static
 struct ust_app_channel *alloc_ust_app_channel(char *name,
 		struct ust_app_session *ua_sess,
-		struct lttng_ust_channel_attr *attr)
+		struct lttng_ust_channel_attr *attr,
+		struct ltt_ust_session *usess,
+		struct ltt_ust_channel *uchan)
 {
 	struct ust_app_channel *ua_chan;
 
@@ -885,6 +913,12 @@ struct ust_app_channel *alloc_ust_app_channel(char *name,
 	}
 	/* By default, the channel is a per cpu channel. */
 	ua_chan->attr.type = LTTNG_UST_CHAN_PER_CPU;
+	/*
+	 * Back pointers to the ust session and channel.
+	 * XXX
+	 */
+	ua_chan->usess = usess;
+	ua_chan->uchan = uchan;
 
 	DBG3("UST app channel %s allocated", ua_chan->name);
 
@@ -1690,7 +1724,8 @@ static void shadow_copy_session(struct ust_app_session *ua_sess,
 
 		DBG2("Channel %s not found on shadow session copy, creating it",
 				uchan->name);
-		ua_chan = alloc_ust_app_channel(uchan->name, ua_sess, &uchan->attr);
+		ua_chan = alloc_ust_app_channel(uchan->name, ua_sess, &uchan->attr,
+				usess, uchan);
 		if (ua_chan == NULL) {
 			/* malloc failed FIXME: Might want to do handle ENOMEM .. */
 			continue;
@@ -2781,7 +2816,8 @@ static int create_ust_app_channel(struct ust_app_session *ua_sess,
 		goto end;
 	}
 
-	ua_chan = alloc_ust_app_channel(uchan->name, ua_sess, &uchan->attr);
+	ua_chan = alloc_ust_app_channel(uchan->name, ua_sess, &uchan->attr,
+			usess, uchan);
 	if (ua_chan == NULL) {
 		/* Only malloc can fail here */
 		ret = -ENOMEM;
@@ -2898,7 +2934,8 @@ static int create_ust_app_metadata(struct ust_app_session *ua_sess,
 	}
 
 	/* Allocate UST metadata */
-	metadata = alloc_ust_app_channel(DEFAULT_METADATA_NAME, ua_sess, NULL);
+	metadata = alloc_ust_app_channel(DEFAULT_METADATA_NAME, ua_sess, NULL,
+			NULL, NULL);
 	if (!metadata) {
 		/* malloc() failed */
 		ret = -ENOMEM;
@@ -5362,3 +5399,80 @@ uint64_t ust_app_get_size_one_more_packet_per_stream(struct ltt_ust_session *use
 
 	return tot_size;
 }
+
+int ust_app_uid_channel_runtime_stats(uint64_t ust_session_id,
+		struct cds_list_head *buffer_reg_uid_list,
+		struct consumer_output *consumer, uint64_t uchan_id,
+		int overwrite, uint64_t *discarded, uint64_t *lost)
+{
+	int ret;
+	uint64_t consumer_chan_key;
+
+	ret = buffer_reg_uid_consumer_channel_key(
+			buffer_reg_uid_list, ust_session_id,
+			uchan_id, &consumer_chan_key);
+	if (ret < 0) {
+		goto end;
+	}
+
+	if (overwrite) {
+		ret = consumer_get_lost_packets(ust_session_id,
+				consumer_chan_key, consumer, lost);
+	} else {
+		ret = consumer_get_discarded_events(ust_session_id,
+				consumer_chan_key, consumer, discarded);
+	}
+
+end:
+	return ret;
+}
+
+int ust_app_pid_channel_runtime_stats(struct ltt_ust_session *usess,
+		struct ltt_ust_channel *uchan,
+		struct consumer_output *consumer, int overwrite,
+		uint64_t *discarded, uint64_t *lost)
+{
+	int ret = 0;
+	struct lttng_ht_iter iter;
+	struct lttng_ht_node_str *ua_chan_node;
+	struct ust_app *app;
+	struct ust_app_session *ua_sess;
+	struct ust_app_channel *ua_chan;
+
+	rcu_read_lock();
+	/*
+	 * Iterate over every registered applications, return when we
+	 * found one in the right session and channel.
+	 */
+	cds_lfht_for_each_entry(ust_app_ht->ht, &iter.iter, app, pid_n.node) {
+		struct lttng_ht_iter uiter;
+
+		ua_sess = lookup_session_by_app(usess, app);
+		if (ua_sess == NULL) {
+			continue;
+		}
+
+		/* Get channel */
+		lttng_ht_lookup(ua_sess->channels, (void *)uchan->name, &uiter);
+		ua_chan_node = lttng_ht_iter_get_node_str(&uiter);
+		/* If the session is found for the app, the channel must be there */
+		assert(ua_chan_node);
+
+		ua_chan = caa_container_of(ua_chan_node, struct ust_app_channel, node);
+
+		if (overwrite) {
+			ret = consumer_get_lost_packets(usess->id, ua_chan->key,
+					consumer, lost);
+			goto end;
+		} else {
+			ret = consumer_get_discarded_events(usess->id,
+					ua_chan->key, consumer, discarded);
+			goto end;
+		}
+		goto end;
+	}
+
+end:
+	rcu_read_unlock();
+	return ret;
+}
diff --git a/src/bin/lttng-sessiond/ust-app.h b/src/bin/lttng-sessiond/ust-app.h
index 38eaf6d..34e05e1 100644
--- a/src/bin/lttng-sessiond/ust-app.h
+++ b/src/bin/lttng-sessiond/ust-app.h
@@ -341,6 +341,14 @@ int ust_app_snapshot_record(struct ltt_ust_session *usess,
 uint64_t ust_app_get_size_one_more_packet_per_stream(
 		struct ltt_ust_session *usess, uint64_t cur_nr_packets);
 struct ust_app *ust_app_find_by_sock(int sock);
+int ust_app_uid_channel_runtime_stats(uint64_t ust_session_id,
+		struct cds_list_head *buffer_reg_uid_list,
+		struct consumer_output *consumer, uint64_t uchan_id,
+		int overwrite, uint64_t *discarded, uint64_t *lost);
+int ust_app_pid_channel_runtime_stats(struct ltt_ust_session *usess,
+		struct ltt_ust_channel *uchan,
+		struct consumer_output *consumer,
+		int overwrite, uint64_t *discarded, uint64_t *lost);
 
 static inline
 int ust_app_supported(void)
@@ -555,6 +563,23 @@ uint64_t ust_app_get_size_one_more_packet_per_stream(
 		struct ltt_ust_session *usess, uint64_t cur_nr_packets) {
 	return 0;
 }
+static inline
+int ust_app_uid_channel_runtime_stats(uint64_t ust_session_id,
+		struct cds_list_head *buffer_reg_uid_list,
+		struct consumer_output *consumer, int overwrite,
+		uint64_t uchan_id, uint64_t *discarded)
+{
+	return 0;
+}
+
+static inline
+int ust_app_pid_channel_runtime_stats(struct ltt_ust_session *usess,
+		struct ltt_ust_channel *uchan,
+		struct consumer_output *consumer,
+		int overwrite, uint64_t *discarded, uint64_t *lost)
+{
+	return 0;
+}
 
 #endif /* HAVE_LIBLTTNG_UST_CTL */
 
diff --git a/src/bin/lttng/commands/list.c b/src/bin/lttng/commands/list.c
index 1eac934..e8b376e 100644
--- a/src/bin/lttng/commands/list.c
+++ b/src/bin/lttng/commands/list.c
@@ -1082,6 +1082,8 @@ static void print_channel(struct lttng_channel *channel)
 	MSG("%sread timer interval: %u", indent6, channel->attr.read_timer_interval);
 	MSG("%strace file count: %" PRIu64, indent6, channel->attr.tracefile_count);
 	MSG("%strace file size (bytes): %" PRIu64, indent6, channel->attr.tracefile_size);
+	MSG("%sdiscarded events: %" PRIu64, indent6, channel->attr.discarded_events);
+	MSG("%slost packets: %" PRIu64, indent6, channel->attr.lost_packets);
 	switch (channel->attr.output) {
 		case LTTNG_EVENT_SPLICE:
 			MSG("%soutput: splice()", indent6);
diff --git a/src/common/config/config-session-abi.h b/src/common/config/config-session-abi.h
index c578af7..c2411c1 100644
--- a/src/common/config/config-session-abi.h
+++ b/src/common/config/config-session-abi.h
@@ -46,6 +46,8 @@ extern const char * const config_element_output_type;
 extern const char * const config_element_tracefile_size;
 extern const char * const config_element_tracefile_count;
 extern const char * const config_element_live_timer_interval;
+extern const char * const config_element_discarded_events;
+extern const char * const config_element_lost_packets;
 extern const char * const config_element_type;
 extern const char * const config_element_buffer_type;
 extern const char * const config_element_session;
diff --git a/src/common/config/config.c b/src/common/config/config.c
index a4b59ff..2ed61bc 100644
--- a/src/common/config/config.c
+++ b/src/common/config/config.c
@@ -96,6 +96,8 @@ const char * const config_element_output_type = "output_type";
 const char * const config_element_tracefile_size = "tracefile_size";
 const char * const config_element_tracefile_count = "tracefile_count";
 const char * const config_element_live_timer_interval = "live_timer_interval";
+const char * const config_element_discarded_events = "discarded_events";
+const char * const config_element_lost_packets = "lost_packets";
 const char * const config_element_type = "type";
 const char * const config_element_buffer_type = "buffer_type";
 const char * const config_element_session = "session";
diff --git a/src/common/config/session.xsd b/src/common/config/session.xsd
index 0a7458d..5f2e5ce 100644
--- a/src/common/config/session.xsd
+++ b/src/common/config/session.xsd
@@ -181,6 +181,8 @@ elementFormDefault="qualified" version="2.5">
 		<xs:element name="tracefile_size" type="uint64_type" default="0" minOccurs="0"/> <!-- bytes -->
 		<xs:element name="tracefile_count" type="uint64_type" default="0" minOccurs="0"/>
 		<xs:element name="live_timer_interval" type="uint32_type" default="0" minOccurs="0"/> <!-- usec -->
+		<xs:element name="discarded_events" type="uint64_type" default="0" minOccurs="0"/>
+		<xs:element name="lost_packets" type="uint64_type" default="0" minOccurs="0"/>
 		<xs:element name="events" type="event_list_type" minOccurs="0"/>
 		<xs:element name="contexts" type="event_context_list_type" minOccurs="0"/>
 	</xs:all>
diff --git a/src/common/consumer.c b/src/common/consumer.c
index effa5f8..5207ad1 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -562,6 +562,7 @@ struct lttng_consumer_stream *consumer_allocate_stream(uint64_t channel_key,
 	stream->monitor = monitor;
 	stream->endpoint_status = CONSUMER_ENDPOINT_ACTIVE;
 	stream->index_fd = -1;
+	stream->last_sequence_number = -1ULL;
 	pthread_mutex_init(&stream->lock, NULL);
 
 	/* If channel is the metadata, flag this stream as metadata. */
diff --git a/src/common/consumer.h b/src/common/consumer.h
index 509e24e..c47e860 100644
--- a/src/common/consumer.h
+++ b/src/common/consumer.h
@@ -58,6 +58,8 @@ enum lttng_consumer_command {
 	LTTNG_CONSUMER_SNAPSHOT_CHANNEL,
 	LTTNG_CONSUMER_SNAPSHOT_METADATA,
 	LTTNG_CONSUMER_STREAMS_SENT,
+	LTTNG_CONSUMER_DISCARDED_EVENTS,
+	LTTNG_CONSUMER_LOST_PACKETS,
 };
 
 /* State of each fd in consumer */
@@ -211,6 +213,10 @@ struct lttng_consumer_channel {
 	int nr_stream_fds;
 	char root_shm_path[PATH_MAX];
 	char shm_path[PATH_MAX];
+	/* Total number of discarded events for that channel. */
+	uint64_t discarded_events;
+	/* Total number of missed packets due to overwriting (overwrite). */
+	uint64_t lost_packets;
 };
 
 /*
@@ -337,6 +343,13 @@ struct lttng_consumer_stream {
 	 */
 	uint64_t ust_metadata_pushed;
 	/*
+	 * Copy of the last discarded event value to detect the overflow of
+	 * the counter.
+	 */
+	unsigned long last_discarded_events;
+	/* Copy of the sequence number of the last packet extracted. */
+	uint64_t last_sequence_number;
+	/*
 	 * FD of the index file for this stream.
 	 */
 	int index_fd;
diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
index e30d21b..52ab2ef 100644
--- a/src/common/kernel-consumer/kernel-consumer.c
+++ b/src/common/kernel-consumer/kernel-consumer.c
@@ -941,6 +941,66 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 
 		goto end_nosignal;
 	}
+	case LTTNG_CONSUMER_DISCARDED_EVENTS:
+	{
+		uint64_t ret;
+		struct lttng_consumer_channel *channel;
+		uint64_t id = msg.u.discarded_events.session_id;
+		uint64_t key = msg.u.discarded_events.channel_key;
+
+		channel = consumer_find_channel(key);
+		if (!channel) {
+			ERR("Kernel consumer discarded events channel %"
+					PRIu64 " not found", key);
+			ret_code = LTTCOMM_CONSUMERD_CHAN_NOT_FOUND;
+		}
+
+		DBG("Kernel consumer discarded events command for session id %"
+				PRIu64 ", channel key %" PRIu64, id, key);
+
+		ret = channel->discarded_events;
+
+		health_code_update();
+
+		/* Send back returned value to session daemon */
+		ret = lttcomm_send_unix_sock(sock, &ret, sizeof(ret));
+		if (ret < 0) {
+			PERROR("send discarded events");
+			goto error_fatal;
+		}
+
+		break;
+	}
+	case LTTNG_CONSUMER_LOST_PACKETS:
+	{
+		uint64_t ret;
+		struct lttng_consumer_channel *channel;
+		uint64_t id = msg.u.lost_packets.session_id;
+		uint64_t key = msg.u.lost_packets.channel_key;
+
+		channel = consumer_find_channel(key);
+		if (!channel) {
+			ERR("Kernel consumer lost packets channel %"
+					PRIu64 " not found", key);
+			ret_code = LTTCOMM_CONSUMERD_CHAN_NOT_FOUND;
+		}
+
+		DBG("Kernel consumer lost packets command for session id %"
+				PRIu64 ", channel key %" PRIu64, id, key);
+
+		ret = channel->lost_packets;
+
+		health_code_update();
+
+		/* Send back returned value to session daemon */
+		ret = lttcomm_send_unix_sock(sock, &ret, sizeof(ret));
+		if (ret < 0) {
+			PERROR("send lost packets");
+			goto error_fatal;
+		}
+
+		break;
+	}
 	default:
 		goto end_nosignal;
 	}
@@ -1052,6 +1112,56 @@ end:
 	return ret;
 }
 
+static
+int get_discarded_lost(struct lttng_consumer_stream *stream, unsigned long len)
+{
+	int ret;
+	uint64_t seq, discarded;
+
+	ret = kernctl_get_sequence_number(stream->wait_fd, &seq);
+	if (ret < 0) {
+		PERROR("kernctl_get_sequence_number");
+		goto end;
+	}
+	/*
+	 * Start the sequence when we extract the first packet in case we
+	 * don't start at 0 (connecting later a consumer for example).
+	 */
+	if (stream->last_sequence_number == -1ULL) {
+		stream->last_sequence_number = seq;
+	} else if  (seq < stream->last_sequence_number) {
+		int order = utils_get_count_order_ulong(len);
+		uint64_t overflow = 1ULL << order;
+
+		stream->chan->lost_packets += overflow - stream->last_sequence_number + seq;
+	} else if (seq > stream->last_sequence_number) {
+		stream->chan->lost_packets += seq - stream->last_sequence_number - 1;
+	} else {
+		/* seq == last_sequence_number */
+		assert(0);
+	}
+	stream->last_sequence_number = seq;
+
+	ret = kernctl_get_events_discarded(stream->wait_fd, &discarded);
+	if (ret < 0) {
+		PERROR("kernctl_get_events_discarded");
+		goto end;
+	}
+	if (discarded < stream->last_discarded_events) {
+		stream->chan->discarded_events += (2 ^ CAA_BITS_PER_LONG) -
+			stream->last_discarded_events + discarded;
+
+	} else {
+		stream->chan->discarded_events += discarded -
+			stream->last_discarded_events;
+	}
+	stream->last_discarded_events = discarded;
+
+	ret = 0;
+end:
+	return ret;
+}
+
 /*
  * Consume data on a file descriptor and write it on a trace file.
  */
@@ -1116,6 +1226,10 @@ ssize_t lttng_kconsumer_read_subbuffer(struct lttng_consumer_stream *stream,
 			}
 			goto end;
 		}
+		ret = get_discarded_lost(stream, len);
+		if (ret < 0) {
+			goto end;
+		}
 	} else {
 		write_index = 0;
 	}
diff --git a/src/common/kernel-ctl/kernel-ctl.c b/src/common/kernel-ctl/kernel-ctl.c
index 18cd955..b3be8be 100644
--- a/src/common/kernel-ctl/kernel-ctl.c
+++ b/src/common/kernel-ctl/kernel-ctl.c
@@ -533,3 +533,9 @@ int kernctl_get_current_timestamp(int fd, uint64_t *ts)
 {
 	return ioctl(fd, LTTNG_RING_BUFFER_GET_CURRENT_TIMESTAMP, ts);
 }
+
+/* Returns the packet sequence number of the current sub-buffer. */
+int kernctl_get_sequence_number(int fd, uint64_t *seq)
+{
+	return ioctl(fd, LTTNG_RING_BUFFER_GET_SEQ_NUM, seq);
+}
diff --git a/src/common/kernel-ctl/kernel-ctl.h b/src/common/kernel-ctl/kernel-ctl.h
index b71b285..ab8154c 100644
--- a/src/common/kernel-ctl/kernel-ctl.h
+++ b/src/common/kernel-ctl/kernel-ctl.h
@@ -99,5 +99,6 @@ int kernctl_get_content_size(int fd, uint64_t *content_size);
 int kernctl_get_packet_size(int fd, uint64_t *packet_size);
 int kernctl_get_stream_id(int fd, uint64_t *stream_id);
 int kernctl_get_current_timestamp(int fd, uint64_t *ts);
+int kernctl_get_sequence_number(int fd, uint64_t *seq);
 
 #endif /* _LTTNG_KERNEL_CTL_H */
diff --git a/src/common/kernel-ctl/kernel-ioctl.h b/src/common/kernel-ctl/kernel-ioctl.h
index e469b5f..d988a83 100644
--- a/src/common/kernel-ctl/kernel-ioctl.h
+++ b/src/common/kernel-ctl/kernel-ioctl.h
@@ -64,6 +64,8 @@
 #define LTTNG_RING_BUFFER_GET_STREAM_ID           _IOR(0xF6, 0x25, uint64_t)
 /* returns the current timestamp */
 #define LTTNG_RING_BUFFER_GET_CURRENT_TIMESTAMP   _IOR(0xF6, 0x26, uint64_t)
+/* returns the packet sequence number */
+#define LTTNG_RING_BUFFER_GET_SEQ_NUM             _IOR(0xF6, 0x27, uint64_t)
 
 /* Old ABI (without support for 32/64 bits compat) */
 /* LTTng file descriptor ioctl */
diff --git a/src/common/mi-lttng.c b/src/common/mi-lttng.c
index 44ff56f..4291431 100644
--- a/src/common/mi-lttng.c
+++ b/src/common/mi-lttng.c
@@ -903,6 +903,22 @@ int mi_lttng_channel_attr(struct mi_writer *writer,
 		goto end;
 	}
 
+	/* Discarded events */
+	ret = mi_lttng_writer_write_element_unsigned_int(writer,
+		config_element_discarded_events,
+		attr->discarded_events);
+	if (ret) {
+		goto end;
+	}
+
+	/* Lost packets */
+	ret = mi_lttng_writer_write_element_unsigned_int(writer,
+			config_element_lost_packets,
+			attr->lost_packets);
+	if (ret) {
+		goto end;
+	}
+
 	/* Closing attributes */
 	ret = mi_lttng_writer_close_element(writer);
 	if (ret) {
diff --git a/src/common/mi_lttng.xsd b/src/common/mi_lttng.xsd
index 3f0894e..60430b1 100644
--- a/src/common/mi_lttng.xsd
+++ b/src/common/mi_lttng.xsd
@@ -313,6 +313,8 @@ THE SOFTWARE.
 			<xs:element name="tracefile_size" type="uint64_type" default="0" minOccurs="0" /> <!-- bytes -->
 			<xs:element name="tracefile_count" type="uint64_type" default="0" minOccurs="0" />
 			<xs:element name="live_timer_interval" type="uint32_type" default="0" minOccurs="0" /> <!-- usec -->
+			<xs:element name="discarded_events" type="uint64_type" default="0" minOccurs="0" />
+			<xs:element name="lost_packets" type="uint64_type" default="0" minOccurs="0" />
 		</xs:all>
 	</xs:complexType>
 
diff --git a/src/common/sessiond-comm/sessiond-comm.h b/src/common/sessiond-comm/sessiond-comm.h
index 1e51ae1..3d08ab6 100644
--- a/src/common/sessiond-comm/sessiond-comm.h
+++ b/src/common/sessiond-comm/sessiond-comm.h
@@ -470,6 +470,14 @@ struct lttcomm_consumer_msg {
 			uint64_t channel_key;
 			uint64_t net_seq_idx;
 		} LTTNG_PACKED sent_streams;
+		struct {
+			uint64_t session_id;
+			uint64_t channel_key;
+		} LTTNG_PACKED discarded_events;
+		struct {
+			uint64_t session_id;
+			uint64_t channel_key;
+		} LTTNG_PACKED lost_packets;
 	} u;
 } LTTNG_PACKED;
 
diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index fbc3bbb..d39f4e6 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -1649,6 +1649,105 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 		health_code_update();
 		break;
 	}
+	case LTTNG_CONSUMER_DISCARDED_EVENTS:
+	{
+		uint64_t ret;
+		struct lttng_ht_iter iter;
+		struct lttng_ht *ht;
+		struct lttng_consumer_stream *stream;
+		uint64_t id = msg.u.discarded_events.session_id;
+		uint64_t key = msg.u.discarded_events.channel_key;
+
+		DBG("UST consumer discarded events command for session id %"
+				PRIu64, id);
+		rcu_read_lock();
+		pthread_mutex_lock(&consumer_data.lock);
+
+		ht = consumer_data.stream_list_ht;
+
+		/*
+		 * We only need a reference to the channel, but they are not
+		 * directly indexed, so we just use the first matching stream
+		 * to extract the information we need, we default to 0 if not
+		 * found (no events are dropped if the channel is not yet in
+		 * use).
+		 */
+		ret = 0;
+		cds_lfht_for_each_entry_duplicate(ht->ht,
+				ht->hash_fct(&id, lttng_ht_seed),
+				ht->match_fct, &id,
+				&iter.iter, stream, node_session_id.node) {
+			if (stream->chan->key == key) {
+				ret = stream->chan->discarded_events;
+				break;
+			}
+		}
+		pthread_mutex_unlock(&consumer_data.lock);
+		rcu_read_unlock();
+
+		DBG("UST consumer discarded events command for session id %"
+				PRIu64 ", channel key %" PRIu64, id, key);
+
+		health_code_update();
+
+		/* Send back returned value to session daemon */
+		ret = lttcomm_send_unix_sock(sock, &ret, sizeof(ret));
+		if (ret < 0) {
+			PERROR("send discarded events");
+			goto error_fatal;
+		}
+
+		break;
+	}
+	case LTTNG_CONSUMER_LOST_PACKETS:
+	{
+		uint64_t ret;
+		struct lttng_ht_iter iter;
+		struct lttng_ht *ht;
+		struct lttng_consumer_stream *stream;
+		uint64_t id = msg.u.lost_packets.session_id;
+		uint64_t key = msg.u.lost_packets.channel_key;
+
+		DBG("UST consumer lost packets command for session id %"
+				PRIu64, id);
+		rcu_read_lock();
+		pthread_mutex_lock(&consumer_data.lock);
+
+		ht = consumer_data.stream_list_ht;
+
+		/*
+		 * We only need a reference to the channel, but they are not
+		 * directly indexed, so we just use the first matching stream
+		 * to extract the information we need, we default to 0 if not
+		 * found (no packets lost if the channel is not yet in use).
+		 */
+		ret = 0;
+		cds_lfht_for_each_entry_duplicate(ht->ht,
+				ht->hash_fct(&id, lttng_ht_seed),
+				ht->match_fct, &id,
+				&iter.iter, stream, node_session_id.node) {
+			if (stream->chan->key == key) {
+				ret = stream->chan->lost_packets;
+				break;
+			}
+		}
+		pthread_mutex_unlock(&consumer_data.lock);
+		rcu_read_unlock();
+
+		DBG("UST consumer lost packets command for session id %"
+				PRIu64 ", channel key %" PRIu64, id, key);
+
+		health_code_update();
+
+		/* Send back returned value to session daemon */
+		ret = lttcomm_send_unix_sock(sock, &ret, sizeof(ret));
+		if (ret < 0) {
+			PERROR("send lost packets");
+			goto error_fatal;
+		}
+
+		break;
+	}
 	default:
 		break;
 	}
@@ -1791,6 +1890,16 @@ int lttng_ustconsumer_get_current_timestamp(
 	return ustctl_get_current_timestamp(stream->ustream, ts);
 }
 
+int lttng_ustconsumer_get_sequence_number(
+		struct lttng_consumer_stream *stream, uint64_t *seq)
+{
+	assert(stream);
+	assert(stream->ustream);
+	assert(seq);
+
+	return ustctl_get_sequence_number(stream->ustream, seq);
+}
+
 /*
  * Called when the stream signal the consumer that it has hang up.
  */
@@ -2077,6 +2186,58 @@ end:
 	return ret;
 }
 
+static
+int get_discarded_lost(struct lttng_consumer_stream *stream, unsigned long len)
+{
+	uint64_t seq, discarded;
+	int ret;
+
+	ret = ustctl_get_sequence_number(stream->ustream, &seq);
+	if (ret < 0) {
+		PERROR("ustctl_get_sequence_number");
+		goto end;
+	}
+	/*
+	 * Start the sequence when we extract the first packet in case we
+	 * don't start at 0 (connecting later a consumer for example).
+	 */
+	if (stream->last_sequence_number == -1ULL) {
+		stream->last_sequence_number = seq;
+	} else if  (seq < stream->last_sequence_number) {
+		int order = utils_get_count_order_ulong(len);
+		uint64_t overflow = 1ULL << order;
+
+		stream->chan->lost_packets += overflow -
+			stream->last_sequence_number + seq;
+	} else if (seq > stream->last_sequence_number) {
+		stream->chan->lost_packets += seq -
+			stream->last_sequence_number - 1;
+	} else {
+		/* seq == last_sequence_number */
+		assert(0);
+	}
+	stream->last_sequence_number = seq;
+
+	ret = ustctl_get_events_discarded(stream->ustream, &discarded);
+	if (ret < 0) {
+		PERROR("kernctl_get_events_discarded");
+		goto end;
+	}
+	if (discarded < stream->last_discarded_events) {
+		stream->chan->discarded_events += (2 ^ CAA_BITS_PER_LONG) -
+			stream->last_discarded_events + discarded;
+
+	} else {
+		stream->chan->discarded_events += discarded -
+			stream->last_discarded_events;
+	}
+	stream->last_discarded_events = discarded;
+	ret = 0;
+
+end:
+	return ret;
+}
+
 /*
  * Read subbuffer from the given stream.
  *
@@ -2160,6 +2321,12 @@ retry:
 		if (ret < 0) {
 			goto end;
 		}
+
+		ret = get_discarded_lost(stream, len);
+		if (ret < 0) {
+			PERROR("kernctl_get_events_discarded");
+			goto end;
+		}
 	} else {
 		write_index = 0;
 	}
diff --git a/src/common/ust-consumer/ust-consumer.h b/src/common/ust-consumer/ust-consumer.h
index 4357380..bde355c 100644
--- a/src/common/ust-consumer/ust-consumer.h
+++ b/src/common/ust-consumer/ust-consumer.h
@@ -67,6 +67,8 @@ void lttng_ustconsumer_flush_buffer(struct lttng_consumer_stream *stream,
 		int producer);
 int lttng_ustconsumer_get_current_timestamp(
 		struct lttng_consumer_stream *stream, uint64_t *ts);
+int lttng_ustconsumer_get_sequence_number(
+		struct lttng_consumer_stream *stream, uint64_t *seq);
 
 #else /* HAVE_LIBLTTNG_UST_CTL */
 
@@ -206,6 +208,11 @@ int lttng_ustconsumer_get_current_timestamp(
 {
 	return -ENOSYS;
 }
+int lttng_ustconsumer_get_sequence_number(
+		struct lttng_consumer_stream *stream, uint64_t *seq)
+{
+	return -ENOSYS;
+}
 static inline
 int lttng_ustconsumer_get_stream_id(struct lttng_consumer_stream *stream,
 		uint64_t *stream_id)
-- 
1.9.1
