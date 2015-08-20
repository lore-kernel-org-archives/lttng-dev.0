From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 1/2] Support ctf index version 1.1
Date: Wed, 19 Aug 2015 21:19:57 -0400
Message-ID: <1440033598-14124-1-git-send-email-jdesfossez__49773.0465991937$1440033690$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZSEWZ-0000oA-2b
 for lttng-dev@lists.lttng.org; Wed, 19 Aug 2015 21:20:14 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com, jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Produced by LTTng as of 2.8 (no compatibility breakage with 1.0)

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 formats/ctf/ctf.c                  | 10 +++++++++-
 include/babeltrace/ctf/ctf-index.h |  5 ++++-
 include/babeltrace/ctf/types.h     |  3 +++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index 74fcb5b..c5bb6eb 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -1547,6 +1547,8 @@ begin:
 	packet_index.ts_cycles.timestamp_end = 0;
 	packet_index.events_discarded = 0;
 	packet_index.events_discarded_len = 0;
+	packet_index.stream_instance_id = 0;
+	packet_index.packet_seq_num = 0;
 
 	/* read and check header, set stream id (and check) */
 	if (file_stream->parent.trace_packet_header) {
@@ -1833,7 +1835,7 @@ int import_stream_packet_index(struct ctf_trace *td,
 	struct ctf_packet_index *ctf_index = NULL;
 	struct ctf_packet_index_file_hdr index_hdr;
 	struct packet_index index;
-	uint32_t packet_index_len;
+	uint32_t packet_index_len, index_minor;
 	int ret = 0;
 	int first_packet = 1;
 	size_t len;
@@ -1861,6 +1863,8 @@ int import_stream_packet_index(struct ctf_trace *td,
 		ret = -1;
 		goto error;
 	}
+	index_minor = be32toh(index_hdr.index_minor);
+
 	packet_index_len = be32toh(index_hdr.packet_index_len);
 	if (packet_index_len == 0) {
 		fprintf(stderr, "[error] Packet index length cannot be 0.\n");
@@ -1887,6 +1891,10 @@ int import_stream_packet_index(struct ctf_trace *td,
 		index.events_discarded_len = 64;
 		index.data_offset = -1;
 		stream_id = be64toh(ctf_index->stream_id);
+		if (index_minor >= 1) {
+			index.stream_instance_id = be64toh(ctf_index->stream_instance_id);
+			index.packet_seq_num = be64toh(ctf_index->packet_seq_num);
+		}
 
 		if (!first_packet) {
 			/* add index to packet array */
diff --git a/include/babeltrace/ctf/ctf-index.h b/include/babeltrace/ctf/ctf-index.h
index b39b523..8880c2f 100644
--- a/include/babeltrace/ctf/ctf-index.h
+++ b/include/babeltrace/ctf/ctf-index.h
@@ -29,7 +29,7 @@
 
 #define CTF_INDEX_MAGIC 0xC1F1DCC1
 #define CTF_INDEX_MAJOR 1
-#define CTF_INDEX_MINOR 0
+#define CTF_INDEX_MINOR 1
 
 /*
  * Header at the beginning of each index file.
@@ -55,6 +55,9 @@ struct ctf_packet_index {
 	uint64_t timestamp_end;
 	uint64_t events_discarded;
 	uint64_t stream_id;
+	/* CTF_INDEX 1.0 limit */
+	uint64_t stream_instance_id;	/* ID of the channel instance */
+	uint64_t packet_seq_num;	/* packet sequence number */
 } __attribute__((__packed__));
 
 #endif /* LTTNG_INDEX_H */
diff --git a/include/babeltrace/ctf/types.h b/include/babeltrace/ctf/types.h
index c336632..cc8acbf 100644
--- a/include/babeltrace/ctf/types.h
+++ b/include/babeltrace/ctf/types.h
@@ -58,6 +58,9 @@ struct packet_index {
 	uint64_t events_discarded_len;	/* length of the field, in bits */
 	struct packet_index_time ts_cycles;	/* timestamp in cycles */
 	struct packet_index_time ts_real;	/* realtime timestamp */
+	/* CTF_INDEX 1.0 limit */
+	uint64_t stream_instance_id;	/* ID of the channel instance */
+	uint64_t packet_seq_num;	/* packet sequence number */
 };
 
 /*
-- 
1.9.1
