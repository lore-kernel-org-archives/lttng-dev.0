From: David Goulet <dgoulet@efficios.com>
Subject: [PATCH lttng-tools 4/4] Change the metadata hash table
	node
Date: Fri, 12 Oct 2012 10:30:35 -0400
Message-ID: <1350052235-12198-4-git-send-email-dgoulet__12655.3369606428$1350052296$gmane$org@efficios.com>
References: <1350052235-12198-1-git-send-email-dgoulet@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TMgGL-0003U7-Gr
	for lttng-dev@lists.lttng.org; Fri, 12 Oct 2012 10:30:53 -0400
In-Reply-To: <1350052235-12198-1-git-send-email-dgoulet@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: David Goulet <dgoulet@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Remove the use of the "waitfd_node" for metadata and index the "node" by
wait fd during stream allocation only for metadata stream.

This was done so the waitfd node could be used later on for the hash
table indexing stream by session id the traced data check command (soon
to be implemented).

Signed-off-by: David Goulet <dgoulet@efficios.com>
---
 src/common/consumer.c |   36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/src/common/consumer.c b/src/common/consumer.c
index 1fb9960..0c1a812 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -172,17 +172,6 @@ void consumer_free_stream(struct rcu_head *head)
 	free(stream);
 }
 
-static
-void consumer_free_metadata_stream(struct rcu_head *head)
-{
-	struct lttng_ht_node_ulong *node =
-		caa_container_of(head, struct lttng_ht_node_ulong, head);
-	struct lttng_consumer_stream *stream =
-		caa_container_of(node, struct lttng_consumer_stream, waitfd_node);
-
-	free(stream);
-}
-
 /*
  * RCU protected relayd socket pair free.
  */
@@ -417,8 +406,17 @@ struct lttng_consumer_stream *consumer_allocate_stream(
 	stream->metadata_flag = metadata_flag;
 	strncpy(stream->path_name, path_name, sizeof(stream->path_name));
 	stream->path_name[sizeof(stream->path_name) - 1] = '\0';
-	lttng_ht_node_init_ulong(&stream->waitfd_node, stream->wait_fd);
-	lttng_ht_node_init_ulong(&stream->node, stream->key);
+
+	/*
+	 * Index differently the metadata node because the thread is using an
+	 * internal hash table to match streams in the metadata_ht to the epoll set
+	 * file descriptor.
+	 */
+	if (metadata_flag) {
+		lttng_ht_node_init_ulong(&stream->node, stream->wait_fd);
+	} else {
+		lttng_ht_node_init_ulong(&stream->node, stream->key);
+	}
 
 	/*
 	 * The cpu number is needed before using any ustctl_* actions. Ignored for
@@ -1578,11 +1576,11 @@ static void destroy_stream_ht(struct lttng_ht *ht)
 	}
 
 	rcu_read_lock();
-	cds_lfht_for_each_entry(ht->ht, &iter.iter, stream, waitfd_node.node) {
+	cds_lfht_for_each_entry(ht->ht, &iter.iter, stream, node.node) {
 		ret = lttng_ht_del(ht, &iter);
 		assert(!ret);
 
-		call_rcu(&stream->waitfd_node.head, consumer_free_metadata_stream);
+		call_rcu(&stream->node.head, consumer_free_stream);
 	}
 	rcu_read_unlock();
 
@@ -1636,7 +1634,7 @@ void consumer_del_metadata_stream(struct lttng_consumer_stream *stream,
 	}
 
 	rcu_read_lock();
-	iter.iter.node = &stream->waitfd_node.node;
+	iter.iter.node = &stream->node.node;
 	ret = lttng_ht_del(ht, &iter);
 	assert(!ret);
 	rcu_read_unlock();
@@ -1707,7 +1705,7 @@ end:
 	}
 
 free_stream:
-	call_rcu(&stream->waitfd_node.head, consumer_free_metadata_stream);
+	call_rcu(&stream->node.head, consumer_free_stream);
 }
 
 /*
@@ -1756,7 +1754,7 @@ static int consumer_add_metadata_stream(struct lttng_consumer_stream *stream,
 	/* Steal stream identifier to avoid having streams with the same key */
 	consumer_steal_stream_key(stream->key, ht);
 
-	lttng_ht_add_unique_ulong(ht, &stream->waitfd_node);
+	lttng_ht_add_unique_ulong(ht, &stream->node);
 	rcu_read_unlock();
 
 	pthread_mutex_unlock(&consumer_data.lock);
@@ -1881,7 +1879,7 @@ restart:
 			assert(node);
 
 			stream = caa_container_of(node, struct lttng_consumer_stream,
-					waitfd_node);
+					node);
 
 			/* Check for error event */
 			if (revents & (LPOLLERR | LPOLLHUP)) {
-- 
1.7.10.4
