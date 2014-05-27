From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH babeltrace] ctf-writer: Add support for the
	cpu_id field
Date: Tue, 27 May 2014 10:08:22 +0200
Message-ID: <1401178102-9731-1-git-send-email-bigeasy__10954.7732551166$1401178164$gmane$org@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from www.linutronix.de ([62.245.132.108] helo=Galois.linutronix.de)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>) id 1WpCQv-0006tv-QP
 for lttng-dev@lists.lttng.org; Tue, 27 May 2014 04:08:31 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev@lists.lttng.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: lttng-dev@lists.lttng.org

This patch attempts to add support for cpu_id which could be recorded
within the trace. The lttng tracer provides a CPU field in its traces
and this aims to offer the same functionality and the same file format.
The way this is implemented right now it requires to flush the stream
each time the CPU id has been changed. What might work as well is to
assign each CPU to a specific stream.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 bindings/python/babeltrace.i.in                 |  8 +++++++
 formats/ctf/writer/stream.c                     | 28 +++++++++++++++++++++++++
 include/babeltrace/ctf-writer/stream-internal.h |  1 +
 include/babeltrace/ctf-writer/stream.h          | 12 +++++++++++
 4 files changed, 49 insertions(+)

diff --git a/bindings/python/babeltrace.i.in b/bindings/python/babeltrace.i.in
index 0f81c40..ca443fc 100644
--- a/bindings/python/babeltrace.i.in
+++ b/bindings/python/babeltrace.i.in
@@ -1364,6 +1364,7 @@ void bt_ctf_event_put(struct bt_ctf_event *event);
 %rename("_bt_ctf_stream_class_get") bt_ctf_stream_class_get(struct bt_ctf_stream_class *stream_class);
 %rename("_bt_ctf_stream_class_put") bt_ctf_stream_class_put(struct bt_ctf_stream_class *stream_class);
 %rename("_bt_ctf_stream_append_discarded_events") bt_ctf_stream_append_discarded_events(struct bt_ctf_stream *stream, uint64_t event_count);
+%rename("_bt_ctf_stream_append_cpu_id") bt_ctf_stream_append_cpu_id(struct bt_ctf_stream *stream, uint64_t cpu_id);
 %rename("_bt_ctf_stream_append_event") bt_ctf_stream_append_event(struct bt_ctf_stream *stream, struct bt_ctf_event *event);
 %rename("_bt_ctf_stream_flush") bt_ctf_stream_flush(struct bt_ctf_stream *stream);
 %rename("_bt_ctf_stream_get") bt_ctf_stream_get(struct bt_ctf_stream *stream);
@@ -1375,6 +1376,7 @@ int bt_ctf_stream_class_add_event_class(struct bt_ctf_stream_class *stream_class
 void bt_ctf_stream_class_get(struct bt_ctf_stream_class *stream_class);
 void bt_ctf_stream_class_put(struct bt_ctf_stream_class *stream_class);
 void bt_ctf_stream_append_discarded_events(struct bt_ctf_stream *stream, uint64_t event_count);
+void bt_ctf_stream_append_cpu_id(struct bt_ctf_stream *stream, uint64_t cpu_id);
 int bt_ctf_stream_append_event(struct bt_ctf_stream *stream, struct bt_ctf_event *event);
 int bt_ctf_stream_flush(struct bt_ctf_stream *stream);
 void bt_ctf_stream_get(struct bt_ctf_stream *stream);
@@ -2103,6 +2105,12 @@ void bt_ctf_writer_put(struct bt_ctf_writer *writer);
 			_bt_ctf_stream_append_discarded_events(self._s, event_count)
 
 		"""
+		Set the current CPU for the events that occured.
+		"""
+		def append_cpu_id(self, cpu_id):
+			_bt_ctf_stream_append_cpu_id(self._s, cpu_id)
+
+		"""
 		Append "event" to the stream's current packet. The stream's associated clock
 		will be sampled during this call. The event shall not be modified after
 		being appended to a stream.
diff --git a/formats/ctf/writer/stream.c b/formats/ctf/writer/stream.c
index 4efb369..86eed3f 100644
--- a/formats/ctf/writer/stream.c
+++ b/formats/ctf/writer/stream.c
@@ -335,6 +335,16 @@ void bt_ctf_stream_append_discarded_events(struct bt_ctf_stream *stream,
 	stream->events_discarded += event_count;
 }
 
+void bt_ctf_stream_append_cpu_id(struct bt_ctf_stream *stream,
+		uint64_t cpu_id)
+{
+	if (!stream) {
+		return;
+	}
+
+	stream->cpu_id = cpu_id;
+}
+
 int bt_ctf_stream_append_event(struct bt_ctf_stream *stream,
 		struct bt_ctf_event *event)
 {
@@ -409,6 +419,12 @@ int bt_ctf_stream_flush(struct bt_ctf_stream *stream)
 	}
 
 	ret = set_structure_field_integer(stream_class->packet_context,
+		"cpu_id", stream->cpu_id);
+	if (ret) {
+		goto end;
+	}
+
+	ret = set_structure_field_integer(stream_class->packet_context,
 		"content_size", UINT64_MAX);
 	if (ret) {
 		goto end;
@@ -623,6 +639,8 @@ int init_packet_context(struct bt_ctf_stream_class *stream_class,
 		bt_ctf_field_type_structure_create();
 	struct bt_ctf_field_type *_uint64_t =
 		get_field_type(FIELD_TYPE_ALIAS_UINT64_T);
+	struct bt_ctf_field_type *_uint32_t =
+		get_field_type(FIELD_TYPE_ALIAS_UINT32_T);
 
 	if (!packet_context_type) {
 		ret = -1;
@@ -637,6 +655,10 @@ int init_packet_context(struct bt_ctf_stream_class *stream_class,
 	if (ret) {
 		goto end;
 	}
+	ret = bt_ctf_field_type_set_byte_order(_uint32_t, byte_order);
+	if (ret) {
+		goto end;
+	}
 
 	ret = bt_ctf_field_type_structure_add_field(packet_context_type,
 		_uint64_t, "timestamp_begin");
@@ -667,6 +689,11 @@ int init_packet_context(struct bt_ctf_stream_class *stream_class,
 	if (ret) {
 		goto end;
 	}
+	ret = bt_ctf_field_type_structure_add_field(packet_context_type,
+		_uint32_t, "cpu_id");
+	if (ret) {
+		goto end;
+	}
 
 	stream_class->packet_context_type = packet_context_type;
 	stream_class->packet_context = bt_ctf_field_create(packet_context_type);
@@ -680,6 +707,7 @@ int init_packet_context(struct bt_ctf_stream_class *stream_class,
 	}
 
 	bt_ctf_field_type_put(_uint64_t);
+	bt_ctf_field_type_put(_uint32_t);
 	return ret;
 }
 
diff --git a/include/babeltrace/ctf-writer/stream-internal.h b/include/babeltrace/ctf-writer/stream-internal.h
index 57dd992..8c14166 100644
--- a/include/babeltrace/ctf-writer/stream-internal.h
+++ b/include/babeltrace/ctf-writer/stream-internal.h
@@ -69,6 +69,7 @@ struct bt_ctf_stream {
 	GPtrArray *events;
 	struct ctf_stream_pos pos;
 	unsigned int flushed_packet_count;
+	uint32_t cpu_id;
 	uint64_t events_discarded;
 };
 
diff --git a/include/babeltrace/ctf-writer/stream.h b/include/babeltrace/ctf-writer/stream.h
index 22fb697..2f49810 100644
--- a/include/babeltrace/ctf-writer/stream.h
+++ b/include/babeltrace/ctf-writer/stream.h
@@ -116,6 +116,18 @@ extern void bt_ctf_stream_append_discarded_events(struct bt_ctf_stream *stream,
 		uint64_t event_count);
 
 /*
+ * bt_ctf_stream_append_cpu_id: set the CPU for the events.
+ *
+ * Set the CPU number on which the events occured.
+ *
+ * @param stream Stream instance.
+ * @param cpu_id CPU number for the event to record.
+ *
+ */
+extern void bt_ctf_stream_append_cpu_id(struct bt_ctf_stream *stream,
+		uint64_t cpu_id);
+
+/*
  * bt_ctf_stream_append_event: append an event to the stream.
  *
  * Append "event" to the stream's current packet. The stream's associated clock
-- 
2.0.0.rc4
