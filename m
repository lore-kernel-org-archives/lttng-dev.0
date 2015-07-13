From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH 9/9] Store the instance id and
	packet_seq_num in indexes
Date: Mon, 13 Jul 2015 11:28:09 -0400
Message-ID: <1436801289-17554-10-git-send-email-jdesfossez__40571.9767710709$1436801782$gmane$org@efficios.com>
References: <1436801289-17554-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZEfei-0008Ph-Mr
 for lttng-dev@lists.lttng.org; Mon, 13 Jul 2015 11:28:33 -0400
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

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 src/bin/lttng-relayd/main.c                  | 12 +++++++++---
 src/common/index/ctf-index.h                 |  7 +++++--
 src/common/kernel-consumer/kernel-consumer.c | 14 ++++++++++++++
 src/common/relayd/relayd.c                   |  5 +++++
 src/common/sessiond-comm/relayd.h            |  2 ++
 src/common/ust-consumer/ust-consumer.c       | 14 ++++++++++++++
 6 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index a554aed..c2c4a01 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -1127,7 +1127,8 @@ static void destroy_session(struct relay_session *session,
  * Copy index data from the control port to a given index object.
  */
 static void copy_index_control_data(struct relay_index *index,
-		struct lttcomm_relayd_index *data)
+		struct lttcomm_relayd_index *data,
+		struct relay_connection *conn)
 {
 	assert(index);
 	assert(data);
@@ -1143,6 +1144,11 @@ static void copy_index_control_data(struct relay_index *index,
 	index->index_data.timestamp_end = data->timestamp_end;
 	index->index_data.events_discarded = data->events_discarded;
 	index->index_data.stream_id = data->stream_id;
+
+	if (conn->minor >= 7) {
+		index->index_data.stream_instance_id = data->stream_instance_id;
+		index->index_data.packet_seq_num = data->packet_seq_num;
+	}
 }
 
 /*
@@ -2041,7 +2047,7 @@ int relay_recv_index(struct lttcomm_relayd_hdr *recv_hdr,
 		stream->indexes_in_flight++;
 	}
 
-	copy_index_control_data(index, &index_info);
+	copy_index_control_data(index, &index_info, conn);
 	if (stream->ctf_stream_id == -1ULL) {
 		stream->ctf_stream_id = be64toh(index_info.stream_id);
 	}
@@ -2054,7 +2060,7 @@ int relay_recv_index(struct lttcomm_relayd_hdr *recv_hdr,
 		 */
 		relay_index_add(index, &wr_index);
 		if (wr_index) {
-			copy_index_control_data(wr_index, &index_info);
+			copy_index_control_data(wr_index, &index_info, conn);
 			free(index);
 		}
 	} else {
diff --git a/src/common/index/ctf-index.h b/src/common/index/ctf-index.h
index 0efa888..95dd5f7 100644
--- a/src/common/index/ctf-index.h
+++ b/src/common/index/ctf-index.h
@@ -29,7 +29,7 @@
 
 #define CTF_INDEX_MAGIC 0xC1F1DCC1
 #define CTF_INDEX_MAJOR 1
-#define CTF_INDEX_MINOR 0
+#define CTF_INDEX_MINOR 1
 
 /*
  * Header at the beginning of each index file.
@@ -54,7 +54,10 @@ struct ctf_packet_index {
 	uint64_t timestamp_begin;
 	uint64_t timestamp_end;
 	uint64_t events_discarded;
-	uint64_t stream_id;
+	uint64_t stream_id;		/* ID of the channel */
+	/* CTF_INDEX 1.0 limit */
+	uint64_t stream_instance_id;	/* ID of the channel instance */
+	uint64_t packet_seq_num;	/* packet sequence number */
 } __attribute__((__packed__));
 
 #endif /* LTTNG_INDEX_H */
diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
index 66c40c2..17dbce6 100644
--- a/src/common/kernel-consumer/kernel-consumer.c
+++ b/src/common/kernel-consumer/kernel-consumer.c
@@ -1093,6 +1093,20 @@ static int get_index_values(struct ctf_packet_index *index, int infd)
 	}
 	index->stream_id = htobe64(index->stream_id);
 
+	ret = kernctl_get_instance_id(infd, &index->stream_instance_id);
+	if (ret < 0) {
+		PERROR("kernctl_get_instance_id");
+		goto error;
+	}
+	index->stream_instance_id = htobe64(index->stream_instance_id);
+
+	ret = kernctl_get_sequence_number(infd, &index->packet_seq_num);
+	if (ret < 0) {
+		PERROR("kernctl_get_sequence_number");
+		goto error;
+	}
+	index->packet_seq_num = htobe64(index->packet_seq_num);
+
 error:
 	return ret;
 }
diff --git a/src/common/relayd/relayd.c b/src/common/relayd/relayd.c
index 47db408..586a4e9 100644
--- a/src/common/relayd/relayd.c
+++ b/src/common/relayd/relayd.c
@@ -828,6 +828,11 @@ int relayd_send_index(struct lttcomm_relayd_sock *rsock,
 	msg.events_discarded = index->events_discarded;
 	msg.stream_id = index->stream_id;
 
+	if (rsock->minor >= 7) {
+		msg.stream_instance_id = index->stream_instance_id;
+		msg.packet_seq_num = index->packet_seq_num;
+	}
+
 	/* Send command */
 	ret = send_command(rsock, RELAYD_SEND_INDEX, &msg, sizeof(msg), 0);
 	if (ret < 0) {
diff --git a/src/common/sessiond-comm/relayd.h b/src/common/sessiond-comm/relayd.h
index ff56d3a..924434e 100644
--- a/src/common/sessiond-comm/relayd.h
+++ b/src/common/sessiond-comm/relayd.h
@@ -162,6 +162,8 @@ struct lttcomm_relayd_index {
 	uint64_t timestamp_end;
 	uint64_t events_discarded;
 	uint64_t stream_id;
+	uint64_t stream_instance_id;
+	uint64_t packet_seq_num;
 } LTTNG_PACKED;
 
 /*
diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index 282580a..c0a0e7e 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -2053,6 +2053,20 @@ static int get_index_values(struct ctf_packet_index *index,
 	}
 	index->stream_id = htobe64(index->stream_id);
 
+	ret = ustctl_get_instance_id(ustream, &index->stream_instance_id);
+	if (ret < 0) {
+		PERROR("ustctl_get_instance_id");
+		goto error;
+	}
+	index->stream_instance_id = htobe64(index->stream_instance_id);
+
+	ret = ustctl_get_sequence_number(ustream, &index->packet_seq_num);
+	if (ret < 0) {
+		PERROR("ustctl_get_sequence_number");
+		goto error;
+	}
+	index->packet_seq_num = htobe64(index->packet_seq_num);
+
 error:
 	return ret;
 }
-- 
1.9.1
