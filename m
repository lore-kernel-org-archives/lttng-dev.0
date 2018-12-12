From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: notification thread: RCU-safe
 reclaim of hash table nodes
Date: Wed, 12 Dec 2018 12:16:44 -0500
Message-ID: <20181212171644.16634-1-mathieu.desnoyers__45863.9194061563$1544634897$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 43FNlT3BpDz170Q
 for <lttng-dev@lists.lttng.org>; Wed, 12 Dec 2018 12:16:53 -0500 (EST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com, joraj@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Nodes that are put in a rculfhash hash table created with the
"auto resize" flag need to beware that a worker thread can access the
hash table nodes as a RCU reader concurrently, and that this worker
thread can modify the hash table content, effectively adding and
removing "bucket" nodes, and changing the size of the hash table
index.

Therefore, even though only a single thread reads and updates the hash
table, a grace period is needed before reclaiming the memory holding
the rculfhash nodes.

Moreover, handle_notification_thread_command_add_channel() misses a
RCU read-side lock around iteration on the triggers hash table. Failure
to hold this read-side lock could cause segmentation faults when
accessing hash table objects if a hash table resize is done by the
worker thread in parallel with iteration over the hash table.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 .../lttng-sessiond/notification-thread-events.c    | 73 +++++++++++++++++++---
 .../lttng-sessiond/notification-thread-internal.h  |  4 ++
 2 files changed, 70 insertions(+), 7 deletions(-)

diff --git a/src/bin/lttng-sessiond/notification-thread-events.c b/src/bin/lttng-sessiond/notification-thread-events.c
index 1233bf30..ba4e5a05 100644
--- a/src/bin/lttng-sessiond/notification-thread-events.c
+++ b/src/bin/lttng-sessiond/notification-thread-events.c
@@ -70,6 +70,8 @@ struct lttng_channel_trigger_list {
 	struct cds_list_head list;
 	/* Node in the channel_triggers_ht */
 	struct cds_lfht_node channel_triggers_ht_node;
+	/* call_rcu delayed reclaim. */
+	struct rcu_head rcu_node;
 };
 
 /*
@@ -116,6 +118,8 @@ struct lttng_session_trigger_list {
 struct lttng_trigger_ht_element {
 	struct lttng_trigger *trigger;
 	struct cds_lfht_node node;
+	/* call_rcu delayed reclaim. */
+	struct rcu_head rcu_node;
 };
 
 struct lttng_condition_list_element {
@@ -132,6 +136,8 @@ struct notification_client_list {
 	const struct lttng_trigger *trigger;
 	struct cds_list_head list;
 	struct cds_lfht_node notification_trigger_ht_node;
+	/* call_rcu delayed reclaim. */
+	struct rcu_head rcu_node;
 };
 
 struct notification_client {
@@ -198,6 +204,8 @@ struct notification_client {
 			struct lttng_dynamic_buffer buffer;
 		} outbound;
 	} communication;
+	/* call_rcu delayed reclaim. */
+	struct rcu_head rcu_node;
 };
 
 struct channel_state_sample {
@@ -206,6 +214,8 @@ struct channel_state_sample {
 	uint64_t highest_usage;
 	uint64_t lowest_usage;
 	uint64_t channel_total_consumed;
+	/* call_rcu delayed reclaim. */
+	struct rcu_head rcu_node;
 };
 
 static unsigned long hash_channel_key(struct channel_key *key);
@@ -501,6 +511,12 @@ enum lttng_object_type get_condition_binding_object(
 }
 
 static
+void free_channel_info_rcu(struct rcu_head *node)
+{
+	free(caa_container_of(node, struct channel_info, rcu_node));
+}
+
+static
 void channel_info_destroy(struct channel_info *channel_info)
 {
 	if (!channel_info) {
@@ -515,7 +531,13 @@ void channel_info_destroy(struct channel_info *channel_info)
 	if (channel_info->name) {
 		free(channel_info->name);
 	}
-	free(channel_info);
+	call_rcu(&channel_info->rcu_node, free_channel_info_rcu);
+}
+
+static
+void free_session_info_rcu(struct rcu_head *node)
+{
+	free(caa_container_of(node, struct session_info, rcu_node));
 }
 
 /* Don't call directly, use the ref-counting mechanism. */
@@ -539,7 +561,7 @@ void session_info_destroy(void *_data)
 			&session_info->sessions_ht_node);
 	rcu_read_unlock();
 	free(session_info->name);
-	free(session_info);
+	call_rcu(&session_info->rcu_node, free_session_info_rcu);
 }
 
 static
@@ -1099,6 +1121,12 @@ end:
 }
 
 static
+void free_notification_client_rcu(struct rcu_head *node)
+{
+	free(caa_container_of(node, struct notification_client, rcu_node));
+}
+
+static
 void notification_client_destroy(struct notification_client *client,
 		struct notification_thread_state *state)
 {
@@ -1120,7 +1148,7 @@ void notification_client_destroy(struct notification_client *client,
 	}
 	lttng_dynamic_buffer_reset(&client->communication.inbound.buffer);
 	lttng_dynamic_buffer_reset(&client->communication.outbound.buffer);
-	free(client);
+	call_rcu(&client->rcu_node, free_notification_client_rcu);
 }
 
 /*
@@ -1544,6 +1572,7 @@ int handle_notification_thread_command_add_channel(
 		goto error;
 	}
 
+	rcu_read_lock();
 	/* Build a list of all triggers applying to the new channel. */
 	cds_lfht_for_each_entry(state->triggers_ht, &iter, trigger_ht_element,
 			node) {
@@ -1556,6 +1585,7 @@ int handle_notification_thread_command_add_channel(
 
 		new_element = zmalloc(sizeof(*new_element));
 		if (!new_element) {
+			rcu_read_unlock();
 			goto error;
 		}
 		CDS_INIT_LIST_HEAD(&new_element->node);
@@ -1563,6 +1593,7 @@ int handle_notification_thread_command_add_channel(
 		cds_list_add(&new_element->node, &trigger_list);
 		trigger_count++;
 	}
+	rcu_read_unlock();
 
 	DBG("[notification-thread] Found %i triggers that apply to newly added channel",
 			trigger_count);
@@ -1598,6 +1629,20 @@ error:
 }
 
 static
+void free_channel_trigger_list_rcu(struct rcu_head *node)
+{
+	free(caa_container_of(node, struct lttng_channel_trigger_list,
+			rcu_node));
+}
+
+static
+void free_channel_state_sample_rcu(struct rcu_head *node)
+{
+	free(caa_container_of(node, struct channel_state_sample,
+			rcu_node));
+}
+
+static
 int handle_notification_thread_command_remove_channel(
 	struct notification_thread_state *state,
 	uint64_t channel_key, enum lttng_domain_type domain,
@@ -1639,7 +1684,7 @@ int handle_notification_thread_command_remove_channel(
 		free(trigger_list_element);
 	}
 	cds_lfht_del(state->channel_triggers_ht, node);
-	free(trigger_list);
+	call_rcu(&trigger_list->rcu_node, free_channel_trigger_list_rcu);
 
 	/* Free sampled channel state. */
 	cds_lfht_lookup(state->channel_state_ht,
@@ -1658,7 +1703,7 @@ int handle_notification_thread_command_remove_channel(
 				channel_state_ht_node);
 
 		cds_lfht_del(state->channel_state_ht, node);
-		free(sample);
+		call_rcu(&sample->rcu_node, free_channel_state_sample_rcu);
 	}
 
 	/* Remove the channel from the channels_ht and free it. */
@@ -2118,6 +2163,20 @@ error:
 }
 
 static
+void free_notification_client_list_rcu(struct rcu_head *node)
+{
+	free(caa_container_of(node, struct notification_client_list,
+			rcu_node));
+}
+
+static
+void free_lttng_trigger_ht_element_rcu(struct rcu_head *node)
+{
+	free(caa_container_of(node, struct lttng_trigger_ht_element,
+			rcu_node));
+}
+
+static
 int handle_notification_thread_command_unregister_trigger(
 		struct notification_thread_state *state,
 		struct lttng_trigger *trigger,
@@ -2186,7 +2245,7 @@ int handle_notification_thread_command_unregister_trigger(
 	}
 	cds_lfht_del(state->notification_trigger_clients_ht,
 			&client_list->notification_trigger_ht_node);
-	free(client_list);
+	call_rcu(&client_list->rcu_node, free_notification_client_list_rcu);
 
 	/* Remove trigger from triggers_ht. */
 	trigger_ht_element = caa_container_of(triggers_ht_node,
@@ -2198,7 +2257,7 @@ int handle_notification_thread_command_unregister_trigger(
 	action = lttng_trigger_get_action(trigger_ht_element->trigger);
 	lttng_action_destroy(action);
 	lttng_trigger_destroy(trigger_ht_element->trigger);
-	free(trigger_ht_element);
+	call_rcu(&trigger_ht_element->rcu_node, free_lttng_trigger_ht_element_rcu);
 end:
 	rcu_read_unlock();
 	if (_cmd_reply) {
diff --git a/src/bin/lttng-sessiond/notification-thread-internal.h b/src/bin/lttng-sessiond/notification-thread-internal.h
index 397159da..e217995f 100644
--- a/src/bin/lttng-sessiond/notification-thread-internal.h
+++ b/src/bin/lttng-sessiond/notification-thread-internal.h
@@ -53,6 +53,8 @@ struct session_info {
 		/* Identifier of the currently ongoing rotation. */
 		uint64_t id;
 	} rotation;
+	/* call_rcu delayed reclaim. */
+	struct rcu_head rcu_node;
 };
 
 struct channel_info {
@@ -68,6 +70,8 @@ struct channel_info {
 	struct cds_lfht_node channels_ht_node;
 	/* Node in the session_info's channels_ht. */
 	struct cds_lfht_node session_info_channels_ht_node;
+	/* call_rcu delayed reclaim. */
+	struct rcu_head rcu_node;
 };
 
 #endif /* NOTIFICATION_THREAD_INTERNAL_H */
-- 
2.11.0
