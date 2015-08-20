From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 2/2] Output a warning if packets are
	lost
Date: Wed, 19 Aug 2015 21:19:58 -0400
Message-ID: <1440033598-14124-2-git-send-email-jdesfossez__25299.3850656368$1440033669$gmane$org@efficios.com>
References: <1440033598-14124-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZSEWZ-0000oB-NE
 for lttng-dev@lists.lttng.org; Wed, 19 Aug 2015 21:20:14 -0400
In-Reply-To: <1440033598-14124-1-git-send-email-jdesfossez@efficios.com>
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

Depends on the packet_seq_num fields available in the CTF index v1.1
(produced by LTTng 2.8).
Same limitation as the events discarded information: if a stream is
split in multiple files, the counters might not report the appropriate
information for now.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 formats/ctf/ctf.c                    | 40 +++++++++++++++++++++++++++++++-----
 include/babeltrace/ctf-ir/metadata.h |  2 ++
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index c5bb6eb..db237ad 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -420,16 +420,26 @@ void print_uuid(FILE *fp, unsigned char *uuid)
  * Given we have discarded counters of those two types merged into the
  * events_discarded counter, we need to use the union of those ranges:
  *   [ prev_timestamp_end, timestamp_end ]
+ *
+ * Lost packets occur if the tracer overwrote some subbuffer(s) before the
+ * consumer had time to extract them. We keep track of those gaps with the
+ * packet sequence number in each packet.
  */
 static
-void ctf_print_discarded(FILE *fp, struct ctf_stream_definition *stream)
+void ctf_print_discarded_lost(FILE *fp, struct ctf_stream_definition *stream)
 {
-	if (!stream->events_discarded || !babeltrace_ctf_console_output) {
+	if ((!stream->events_discarded && !stream->packets_lost) ||
+			!babeltrace_ctf_console_output) {
 		return;
 	}
 	fflush(stdout);
-	fprintf(fp, "[warning] Tracer discarded %" PRIu64 " events between [",
-		stream->events_discarded);
+	if (stream->events_discarded) {
+		fprintf(fp, "[warning] Tracer discarded %" PRIu64 " events between [",
+				stream->events_discarded);
+	} else if (stream->packets_lost) {
+		fprintf(fp, "[warning] Tracer lost %" PRIu64 " trace packets between [",
+				stream->packets_lost);
+	}
 	if (opt_clock_cycles) {
 		ctf_print_timestamp(fp, stream,
 				stream->prev.cycles.end);
@@ -800,6 +810,7 @@ void ctf_update_current_packet_index(struct ctf_stream_definition *stream,
 		struct packet_index *cur_index)
 {
 	uint64_t events_discarded_diff;
+	uint64_t packets_lost_diff = 0;
 
 	/* Update packet index time information */
 
@@ -827,6 +838,11 @@ void ctf_update_current_packet_index(struct ctf_stream_definition *stream,
 			prev_index->ts_real.timestamp_end;
 
 		events_discarded_diff -= prev_index->events_discarded;
+		/* packet_seq_num stays at 0 if not produced by the tracer */
+		if (cur_index->packet_seq_num) {
+			packets_lost_diff = cur_index->packet_seq_num -
+				prev_index->packet_seq_num - 1;
+		}
 		/*
 		 * Deal with 32-bit wrap-around if the tracer provided a
 		 * 32-bit field.
@@ -847,6 +863,7 @@ void ctf_update_current_packet_index(struct ctf_stream_definition *stream,
 				stream->current.real.begin;
 	}
 	stream->events_discarded = events_discarded_diff;
+	stream->packets_lost = packets_lost_diff;
 }
 
 /*
@@ -956,7 +973,7 @@ void ctf_packet_seek(struct bt_stream_pos *stream_pos, size_t index, int whence)
 		 * timestamps.
 		 */
 		if ((&file_stream->parent)->stream_class->trace->parent.collection) {
-			ctf_print_discarded(stderr, &file_stream->parent);
+			ctf_print_discarded_lost(stderr, &file_stream->parent);
 		}
 
 		packet_index = &g_array_index(pos->packet_index,
@@ -1695,6 +1712,19 @@ begin:
 			packet_index.events_discarded = bt_get_unsigned_int(field);
 			packet_index.events_discarded_len = bt_get_int_len(field);
 		}
+
+		/* read packet_seq_num from header */
+		len_index = bt_struct_declaration_lookup_field_index(
+				file_stream->parent.stream_packet_context->declaration,
+				g_quark_from_static_string("packet_seq_num"));
+		if (len_index >= 0) {
+			struct bt_definition *field;
+
+			field = bt_struct_definition_get_field_from_index(
+					file_stream->parent.stream_packet_context,
+					len_index);
+			packet_index.packet_seq_num = bt_get_unsigned_int(field);
+		}
 	} else {
 		/* Use file size for packet size */
 		packet_index.packet_size = filesize * CHAR_BIT;
diff --git a/include/babeltrace/ctf-ir/metadata.h b/include/babeltrace/ctf-ir/metadata.h
index 6753695..bc68580 100644
--- a/include/babeltrace/ctf-ir/metadata.h
+++ b/include/babeltrace/ctf-ir/metadata.h
@@ -74,6 +74,8 @@ struct ctf_stream_definition {
 
 	/* Event discarded information */
 	uint64_t events_discarded;
+	/* Trace packets lost */
+	uint64_t packets_lost;
 	struct ctf_stream_packet_timestamp prev;
 	struct ctf_stream_packet_timestamp current;
 	char path[PATH_MAX];			/* Path to stream. '\0' for mmap traces */
-- 
1.9.1
