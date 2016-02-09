From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH babeltrace 3/3] Handle negative time and offset
	from Epoch
Date: Tue,  9 Feb 2016 13:27:24 -0500
Message-ID: <1455042444-23148-3-git-send-email-mathieu.desnoyers__6753.0503533364$1455042604$gmane$org@efficios.com>
References: <1455042444-23148-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1aTD1E-0007e3-9o
 for lttng-dev@lists.lttng.org; Tue, 09 Feb 2016 13:28:14 -0500
In-Reply-To: <1455042444-23148-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Handle cases where a trace have a negative offset from Epoch.
If Epoch is arbitrary (e.g. embedded system starting at 0, without any
network access), the "0" can be used as correlation point between
various components, and some components could start before the
correlation point. Therefore, especially in traces where the time is
meant to be shown in nanoseconds or cycles from the correlation point,
it also makes sense to have a negative time value.

It introduces API-breaking changes in the C and Python APIs, since we
need to be able to return negative time values, which were previously
used as errors (-1ULL).

The --offset and --offset-ns command line parameters can now take
negative offset (seconds and nanoseconds) values too.

The [sec.ns] format is used as fallback so we don't attempt to pass
a negative time value to POSIX time-formatting APIs.

This also fixes an inaccurate return value in an error path of
bt_ctf_event_populate_event_header().

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 bindings/python/nativebt.i                         |  42 ++++----
 converter/babeltrace.c                             |   4 +-
 formats/ctf-text/ctf-text.c                        |   2 +-
 formats/ctf/ctf.c                                  | 120 +++++++++++++++------
 formats/ctf/events-private.h                       |  10 +-
 formats/ctf/events.c                               |  11 +-
 formats/ctf/ir/clock.c                             |  33 +++---
 formats/ctf/ir/event.c                             |   6 +-
 .../ctf/metadata/ctf-visitor-generate-io-struct.c  |   4 +-
 include/babeltrace/babeltrace-internal.h           |   8 +-
 include/babeltrace/clock-internal.h                |   3 +-
 include/babeltrace/ctf-ir/clock-internal.h         |   6 +-
 include/babeltrace/ctf-ir/clock.h                  |  26 +++--
 include/babeltrace/ctf-ir/metadata.h               |  10 +-
 include/babeltrace/ctf/events.h                    |   8 +-
 include/babeltrace/ctf/types.h                     |   6 +-
 include/babeltrace/format.h                        |  10 +-
 include/babeltrace/trace-handle-internal.h         |   8 +-
 include/babeltrace/trace-handle.h                  |  25 +++--
 lib/context.c                                      |  72 +++++++++----
 lib/trace-handle.c                                 |  38 +++----
 tests/lib/test_ctf_writer.c                        |  55 +++++++---
 tests/lib/test_seek.c                              |  26 ++---
 23 files changed, 332 insertions(+), 201 deletions(-)

diff --git a/bindings/python/nativebt.i b/bindings/python/nativebt.i
index ac1f858..e1d8378 100644
--- a/bindings/python/nativebt.i
+++ b/bindings/python/nativebt.i
@@ -206,14 +206,16 @@ void bt_trace_handle_destroy(struct bt_trace_handle *bt);
 %rename("_bt_trace_handle_get_path") bt_trace_handle_get_path(struct bt_context *ctx,
 		int handle_id);
 %rename("_bt_trace_handle_get_timestamp_begin") bt_trace_handle_get_timestamp_begin(
-		struct bt_context *ctx, int handle_id, enum bt_clock_type type);
+		struct bt_context *ctx, int handle_id, enum bt_clock_type type,
+                int64_t *timestamp);
 %rename("_bt_trace_handle_get_timestamp_end") bt_trace_handle_get_timestamp_end(
-		struct bt_context *ctx, int handle_id, enum bt_clock_type type);
+		struct bt_context *ctx, int handle_id, enum bt_clock_type type,
+                int64_t *timestamp);
 const char *bt_trace_handle_get_path(struct bt_context *ctx, int handle_id);
-uint64_t bt_trace_handle_get_timestamp_begin(struct bt_context *ctx, int handle_id,
-		enum bt_clock_type type);
-uint64_t bt_trace_handle_get_timestamp_end(struct bt_context *ctx, int handle_id,
-		enum bt_clock_type type);
+int bt_trace_handle_get_timestamp_begin(struct bt_context *ctx, int handle_id,
+		enum bt_clock_type type, int64_t *timestamp);
+int bt_trace_handle_get_timestamp_end(struct bt_context *ctx, int handle_id,
+		enum bt_clock_type type, int64_t *timestamp);
 
 %rename("_bt_ctf_event_get_handle_id") bt_ctf_event_get_handle_id(
 		const struct bt_ctf_event *event);
@@ -241,7 +243,7 @@ struct bt_ctf_event *bt_ctf_iter_read_event(struct bt_ctf_iter *iter);
 		bt_ctf_event *event, enum bt_ctf_scope scope);
 %rename("_bt_ctf_event_name") bt_ctf_event_name(const struct bt_ctf_event *ctf_event);
 %rename("_bt_ctf_get_timestamp") bt_ctf_get_timestamp(
-		const struct bt_ctf_event *ctf_event);
+		const struct bt_ctf_event *ctf_event, int64_t *timestamp);
 %rename("_bt_ctf_get_cycles") bt_ctf_get_cycles(
 		const struct bt_ctf_event *ctf_event);
 
@@ -287,7 +289,7 @@ struct bt_ctf_event *bt_ctf_iter_read_event(struct bt_ctf_iter *iter);
 const struct bt_definition *bt_ctf_get_top_level_scope(const struct bt_ctf_event *ctf_event,
 		enum bt_ctf_scope scope);
 const char *bt_ctf_event_name(const struct bt_ctf_event *ctf_event);
-uint64_t bt_ctf_get_timestamp(const struct bt_ctf_event *ctf_event);
+int bt_ctf_get_timestamp(const struct bt_ctf_event *ctf_event, int64_t *timestamp);
 uint64_t bt_ctf_get_cycles(const struct bt_ctf_event *ctf_event);
 const struct bt_definition *bt_ctf_get_field(const struct bt_ctf_event *ctf_event,
 		const struct bt_definition *scope,
@@ -335,14 +337,14 @@ const struct bt_definition *bt_ctf_get_struct_field_index(const struct bt_defini
 %rename("_bt_ctf_clock_set_frequency") bt_ctf_clock_set_frequency(struct bt_ctf_clock *clock, uint64_t freq);
 %rename("_bt_ctf_clock_get_precision") bt_ctf_clock_get_precision(struct bt_ctf_clock *clock);
 %rename("_bt_ctf_clock_set_precision") bt_ctf_clock_set_precision(struct bt_ctf_clock *clock, uint64_t precision);
-%rename("_bt_ctf_clock_get_offset_s") bt_ctf_clock_get_offset_s(struct bt_ctf_clock *clock);
-%rename("_bt_ctf_clock_set_offset_s") bt_ctf_clock_set_offset_s(struct bt_ctf_clock *clock, uint64_t offset_s);
-%rename("_bt_ctf_clock_get_offset") bt_ctf_clock_get_offset(struct bt_ctf_clock *clock);
-%rename("_bt_ctf_clock_set_offset") bt_ctf_clock_set_offset(struct bt_ctf_clock *clock, uint64_t offset);
+%rename("_bt_ctf_clock_get_offset_s") bt_ctf_clock_get_offset_s(struct bt_ctf_clock *clock, int64_t *offset_s);
+%rename("_bt_ctf_clock_set_offset_s") bt_ctf_clock_set_offset_s(struct bt_ctf_clock *clock, int64_t offset_s);
+%rename("_bt_ctf_clock_get_offset") bt_ctf_clock_get_offset(struct bt_ctf_clock *clock, int64_t *offset);
+%rename("_bt_ctf_clock_set_offset") bt_ctf_clock_set_offset(struct bt_ctf_clock *clock, int64_t offset);
 %rename("_bt_ctf_clock_get_is_absolute") bt_ctf_clock_get_is_absolute(struct bt_ctf_clock *clock);
 %rename("_bt_ctf_clock_set_is_absolute") bt_ctf_clock_set_is_absolute(struct bt_ctf_clock *clock, int is_absolute);
-%rename("_bt_ctf_clock_get_time") bt_ctf_clock_get_time(struct bt_ctf_clock *clock);
-%rename("_bt_ctf_clock_set_time") bt_ctf_clock_set_time(struct bt_ctf_clock *clock, uint64_t time);
+%rename("_bt_ctf_clock_get_time") bt_ctf_clock_get_time(struct bt_ctf_clock *clock, int64_t *time);
+%rename("_bt_ctf_clock_set_time") bt_ctf_clock_set_time(struct bt_ctf_clock *clock, int64_t time);
 %rename("_bt_ctf_clock_get") bt_ctf_clock_get(struct bt_ctf_clock *clock);
 %rename("_bt_ctf_clock_put") bt_ctf_clock_put(struct bt_ctf_clock *clock);
 
@@ -354,14 +356,14 @@ uint64_t bt_ctf_clock_get_frequency(struct bt_ctf_clock *clock);
 int bt_ctf_clock_set_frequency(struct bt_ctf_clock *clock, uint64_t freq);
 uint64_t bt_ctf_clock_get_precision(struct bt_ctf_clock *clock);
 int bt_ctf_clock_set_precision(struct bt_ctf_clock *clock, uint64_t precision);
-uint64_t bt_ctf_clock_get_offset_s(struct bt_ctf_clock *clock);
-int bt_ctf_clock_set_offset_s(struct bt_ctf_clock *clock, uint64_t offset_s);
-uint64_t bt_ctf_clock_get_offset(struct bt_ctf_clock *clock);
-int bt_ctf_clock_set_offset(struct bt_ctf_clock *clock, uint64_t offset);
+int bt_ctf_clock_get_offset_s(struct bt_ctf_clock *clock, int64_t *offset_s);
+int bt_ctf_clock_set_offset_s(struct bt_ctf_clock *clock, int64_t offset_s);
+int bt_ctf_clock_get_offset(struct bt_ctf_clock *clock, int64_t *offset);
+int bt_ctf_clock_set_offset(struct bt_ctf_clock *clock, int64_t offset);
 int bt_ctf_clock_get_is_absolute(struct bt_ctf_clock *clock);
 int bt_ctf_clock_set_is_absolute(struct bt_ctf_clock *clock, int is_absolute);
-uint64_t bt_ctf_clock_get_time(struct bt_ctf_clock *clock);
-int bt_ctf_clock_set_time(struct bt_ctf_clock *clock, uint64_t time);
+int bt_ctf_clock_get_time(struct bt_ctf_clock *clock, int64_t *time);
+int bt_ctf_clock_set_time(struct bt_ctf_clock *clock, int64_t time);
 void bt_ctf_clock_get(struct bt_ctf_clock *clock);
 void bt_ctf_clock_put(struct bt_ctf_clock *clock);
 
diff --git a/converter/babeltrace.c b/converter/babeltrace.c
index c521ac1..326f856 100644
--- a/converter/babeltrace.c
+++ b/converter/babeltrace.c
@@ -349,7 +349,7 @@ static int parse_options(int argc, char **argv)
 				goto end;
 			}
 			errno = 0;
-			opt_clock_offset = strtoull(str, &endptr, 0);
+			opt_clock_offset = strtoll(str, &endptr, 0);
 			if (*endptr != '\0' || str == endptr || errno != 0) {
 				fprintf(stderr, "[error] Incorrect --clock-offset argument: %s\n", str);
 				ret = -EINVAL;
@@ -374,7 +374,7 @@ static int parse_options(int argc, char **argv)
 				goto end;
 			}
 			errno = 0;
-			opt_clock_offset_ns = strtoull(str, &endptr, 0);
+			opt_clock_offset_ns = strtoll(str, &endptr, 0);
 			if (*endptr != '\0' || str == endptr || errno != 0) {
 				fprintf(stderr, "[error] Incorrect --clock-offset-ns argument: %s\n", str);
 				ret = -EINVAL;
diff --git a/formats/ctf-text/ctf-text.c b/formats/ctf-text/ctf-text.c
index 2ba0823..9b1d2b4 100644
--- a/formats/ctf-text/ctf-text.c
+++ b/formats/ctf-text/ctf-text.c
@@ -42,7 +42,7 @@
 #include <unistd.h>
 #include <stdlib.h>
 
-#define NSEC_PER_SEC 1000000000ULL
+#define NSEC_PER_SEC 1000000000LL
 
 int opt_all_field_names,
 	opt_scope_field_names,
diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index 37ebdfc..d17bfab 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -71,7 +71,7 @@
 #define min(a, b)	(((a) < (b)) ? (a) : (b))
 #endif
 
-#define NSEC_PER_SEC 1000000000ULL
+#define NSEC_PER_SEC 1000000000LL
 
 #define INDEX_PATH "./index/%s.idx"
 
@@ -80,8 +80,8 @@ int opt_clock_cycles,
 	opt_clock_date,
 	opt_clock_gmt;
 
-uint64_t opt_clock_offset;
-uint64_t opt_clock_offset_ns;
+int64_t opt_clock_offset;
+int64_t opt_clock_offset_ns;
 
 extern int yydebug;
 
@@ -113,11 +113,13 @@ void ctf_set_handle(struct bt_trace_descriptor *descriptor,
 static
 int ctf_close_trace(struct bt_trace_descriptor *descriptor);
 static
-uint64_t ctf_timestamp_begin(struct bt_trace_descriptor *descriptor,
-		struct bt_trace_handle *handle, enum bt_clock_type type);
+int ctf_timestamp_begin(struct bt_trace_descriptor *descriptor,
+		struct bt_trace_handle *handle, enum bt_clock_type type,
+		int64_t *timestamp);
 static
-uint64_t ctf_timestamp_end(struct bt_trace_descriptor *descriptor,
-		struct bt_trace_handle *handle, enum bt_clock_type type);
+int ctf_timestamp_end(struct bt_trace_descriptor *descriptor,
+		struct bt_trace_handle *handle, enum bt_clock_type type,
+		int64_t *timestamp);
 static
 int ctf_convert_index_timestamp(struct bt_trace_descriptor *tdp);
 
@@ -158,17 +160,20 @@ struct bt_format ctf_format = {
 };
 
 static
-uint64_t ctf_timestamp_begin(struct bt_trace_descriptor *descriptor,
-		struct bt_trace_handle *handle, enum bt_clock_type type)
+int ctf_timestamp_begin(struct bt_trace_descriptor *descriptor,
+		struct bt_trace_handle *handle, enum bt_clock_type type,
+		int64_t *timestamp)
 {
 	struct ctf_trace *tin;
-	uint64_t begin = ULLONG_MAX;
-	int i, j;
+	int64_t begin = LLONG_MAX;
+	int i, j, ret;
 
 	tin = container_of(descriptor, struct ctf_trace, parent);
 
-	if (!tin)
+	if (!tin || !timestamp) {
+		ret = -EINVAL;
 		goto error;
+	}
 
 	/* for each stream_class */
 	for (i = 0; i < tin->streams->len; i++) {
@@ -189,8 +194,10 @@ uint64_t ctf_timestamp_begin(struct bt_trace_descriptor *descriptor,
 					parent);
 			stream_pos = &cfs->pos;
 
-			if (!stream_pos->packet_index)
+			if (!stream_pos->packet_index) {
+				ret = -EINVAL;
 				goto error;
+			}
 
 			if (stream_pos->packet_index->len <= 0)
 				continue;
@@ -205,29 +212,37 @@ uint64_t ctf_timestamp_begin(struct bt_trace_descriptor *descriptor,
 				if (index->ts_cycles.timestamp_begin < begin)
 					begin = index->ts_cycles.timestamp_begin;
 			} else {
+				ret = -EINVAL;
 				goto error;
 			}
 		}
 	}
-
-	return begin;
+	if (begin == LLONG_MAX) {
+		ret = -ENOENT;
+		goto error;
+	}
+	*timestamp = begin;
+	return 0;
 
 error:
-	return -1ULL;
+	return ret;
 }
 
 static
-uint64_t ctf_timestamp_end(struct bt_trace_descriptor *descriptor,
-		struct bt_trace_handle *handle, enum bt_clock_type type)
+int ctf_timestamp_end(struct bt_trace_descriptor *descriptor,
+		struct bt_trace_handle *handle, enum bt_clock_type type,
+		int64_t *timestamp)
 {
 	struct ctf_trace *tin;
-	uint64_t end = 0;
-	int i, j;
+	int64_t end = LLONG_MIN;
+	int i, j, ret;
 
 	tin = container_of(descriptor, struct ctf_trace, parent);
 
-	if (!tin)
+	if (!tin || !timestamp) {
+		ret = -EINVAL;
 		goto error;
+	}
 
 	/* for each stream_class */
 	for (i = 0; i < tin->streams->len; i++) {
@@ -248,8 +263,10 @@ uint64_t ctf_timestamp_end(struct bt_trace_descriptor *descriptor,
 					parent);
 			stream_pos = &cfs->pos;
 
-			if (!stream_pos->packet_index)
+			if (!stream_pos->packet_index) {
+				ret = -EINVAL;
 				goto error;
+			}
 
 			if (stream_pos->packet_index->len <= 0)
 				continue;
@@ -264,15 +281,20 @@ uint64_t ctf_timestamp_end(struct bt_trace_descriptor *descriptor,
 				if (index->ts_cycles.timestamp_end > end)
 					end = index->ts_cycles.timestamp_end;
 			} else {
+				ret = -EINVAL;
 				goto error;
 			}
 		}
 	}
-
-	return end;
+	if (end == LLONG_MIN) {
+		ret = -ENOENT;
+		goto error;
+	}
+	*timestamp = end;
+	return 0;
 
 error:
-	return -1ULL;
+	return ret;
 }
 
 /*
@@ -317,13 +339,15 @@ void ctf_update_timestamp(struct ctf_stream_definition *stream,
 static
 void ctf_print_timestamp_real(FILE *fp,
 			struct ctf_stream_definition *stream,
-			uint64_t timestamp)
+			int64_t timestamp)
 {
-	uint64_t ts_sec = 0, ts_nsec;
+	int64_t ts_sec = 0, ts_nsec;
+	uint64_t ts_sec_abs, ts_nsec_abs;
+	bool is_negative;
 
 	ts_nsec = timestamp;
 
-	/* Add command-line offset in ns*/
+	/* Add command-line offset in ns */
         ts_nsec += opt_clock_offset_ns;
 
 	/* Add command-line offset */
@@ -331,10 +355,40 @@ void ctf_print_timestamp_real(FILE *fp,
 
 	ts_sec += ts_nsec / NSEC_PER_SEC;
 	ts_nsec = ts_nsec % NSEC_PER_SEC;
+	if (ts_sec >= 0 && ts_nsec >= 0) {
+		is_negative = false;
+		ts_sec_abs = ts_sec;
+		ts_nsec_abs = ts_nsec;
+	} else if (ts_sec > 0 && ts_nsec < 0) {
+		is_negative = false;
+		ts_sec_abs = ts_sec - 1;
+		ts_nsec_abs = NSEC_PER_SEC + ts_nsec;
+	} else if (ts_sec == 0 && ts_nsec < 0) {
+		is_negative = true;
+		ts_sec_abs = ts_sec;
+		ts_nsec_abs = -ts_nsec;
+	} else if (ts_sec < 0 && ts_nsec > 0) {
+		is_negative = true;
+		ts_sec_abs = -(ts_sec + 1);
+		ts_nsec_abs = NSEC_PER_SEC - ts_nsec;
+	} else if (ts_sec < 0 && ts_nsec == 0) {
+		is_negative = true;
+		ts_sec_abs = -ts_sec;
+		ts_nsec_abs = ts_nsec;
+	} else {	/* (ts_sec < 0 && ts_nsec < 0) */
+		is_negative = true;
+		ts_sec_abs = -ts_sec;
+		ts_nsec_abs = -ts_nsec;
+	}
 
 	if (!opt_clock_seconds) {
 		struct tm tm;
-		time_t time_s = (time_t) ts_sec;
+		time_t time_s = (time_t) ts_sec_abs;
+
+		if (is_negative) {
+			fprintf(stderr, "[warning] Fallback to [sec.ns] for printing negative time value. Use --clock-seconds.\n");
+			goto seconds;
+		}
 
 		if (!opt_clock_gmt) {
 			struct tm *res;
@@ -368,12 +422,12 @@ void ctf_print_timestamp_real(FILE *fp,
 		}
 		/* Print time in HH:MM:SS.ns */
 		fprintf(fp, "%02d:%02d:%02d.%09" PRIu64,
-			tm.tm_hour, tm.tm_min, tm.tm_sec, ts_nsec);
+			tm.tm_hour, tm.tm_min, tm.tm_sec, ts_nsec_abs);
 		goto end;
 	}
 seconds:
-	fprintf(fp, "%3" PRIu64 ".%09" PRIu64,
-		ts_sec, ts_nsec);
+	fprintf(fp, "%s%" PRId64 ".%09" PRIu64,
+		is_negative ? "-" : "", ts_sec_abs, ts_nsec_abs);
 
 end:
 	return;
@@ -392,7 +446,7 @@ void ctf_print_timestamp_cycles(FILE *fp,
 
 void ctf_print_timestamp(FILE *fp,
 		struct ctf_stream_definition *stream,
-		uint64_t timestamp)
+		int64_t timestamp)
 {
 	if (opt_clock_cycles) {
 		ctf_print_timestamp_cycles(fp, stream, timestamp);
diff --git a/formats/ctf/events-private.h b/formats/ctf/events-private.h
index 9bea75d..c47fd7d 100644
--- a/formats/ctf/events-private.h
+++ b/formats/ctf/events-private.h
@@ -35,20 +35,20 @@
 #include <babeltrace/clock-internal.h>
 
 static inline
-uint64_t ctf_get_real_timestamp(struct ctf_stream_definition *stream,
-			uint64_t timestamp)
+int64_t ctf_get_real_timestamp(struct ctf_stream_definition *stream,
+			uint64_t ts_cycles)
 {
-	uint64_t ts_nsec;
+	int64_t ts_nsec;
 	struct ctf_trace *trace = stream->stream_class->trace;
 	struct trace_collection *tc = trace->parent.collection;
-	uint64_t tc_offset;
+	int64_t tc_offset;
 
 	if (tc->clock_use_offset_avg)
 		tc_offset = tc->single_clock_offset_avg;
 	else
 		tc_offset = clock_offset_ns(trace->parent.single_clock);
 
-	ts_nsec = clock_cycles_to_ns(stream->current_clock, timestamp);
+	ts_nsec = clock_cycles_to_ns(stream->current_clock, ts_cycles);
 	ts_nsec += tc_offset;	/* Add offset */
 	return ts_nsec;
 }
diff --git a/formats/ctf/events.c b/formats/ctf/events.c
index eff7072..f336dd8 100644
--- a/formats/ctf/events.c
+++ b/formats/ctf/events.c
@@ -315,18 +315,19 @@ int bt_ctf_event_get_handle_id(const struct bt_ctf_event *ctf_event)
 	return ret;
 }
 
-uint64_t bt_ctf_get_timestamp(const struct bt_ctf_event *ctf_event)
+int bt_ctf_get_timestamp(const struct bt_ctf_event *ctf_event, int64_t *timestamp)
 {
 	const struct ctf_event_definition *event;
 
-	if (!ctf_event)
-		return -1ULL;
+	if (!ctf_event || !timestamp)
+		return -1;
 
 	event = ctf_event->parent;
 	if (event && event->stream->has_timestamp)
-		return event->stream->real_timestamp;
+		*timestamp = event->stream->real_timestamp;
 	else
-		return -1ULL;
+		return -1;
+	return 0;
 }
 
 uint64_t bt_ctf_get_cycles(const struct bt_ctf_event *ctf_event)
diff --git a/formats/ctf/ir/clock.c b/formats/ctf/ir/clock.c
index d5c980a..bf2fbda 100644
--- a/formats/ctf/ir/clock.c
+++ b/formats/ctf/ir/clock.c
@@ -206,20 +206,21 @@ end:
 	return ret;
 }
 
-uint64_t bt_ctf_clock_get_offset_s(struct bt_ctf_clock *clock)
+int bt_ctf_clock_get_offset_s(struct bt_ctf_clock *clock, int64_t *offset_s)
 {
-	uint64_t ret = -1ULL;
+	int ret = 0;
 
-	if (!clock) {
+	if (!clock || !offset_s) {
+		ret = -1;
 		goto end;
 	}
 
-	ret = clock->offset_s;
+	*offset_s = clock->offset_s;
 end:
 	return ret;
 }
 
-int bt_ctf_clock_set_offset_s(struct bt_ctf_clock *clock, uint64_t offset_s)
+int bt_ctf_clock_set_offset_s(struct bt_ctf_clock *clock, int64_t offset_s)
 {
 	int ret = 0;
 
@@ -233,20 +234,21 @@ end:
 	return ret;
 }
 
-uint64_t bt_ctf_clock_get_offset(struct bt_ctf_clock *clock)
+int bt_ctf_clock_get_offset(struct bt_ctf_clock *clock, int64_t *offset)
 {
-	uint64_t ret = -1ULL;
+	int ret = 0;
 
-	if (!clock) {
+	if (!clock || !offset) {
+		ret = -1;
 		goto end;
 	}
 
-	ret = clock->offset;
+	*offset = clock->offset;
 end:
 	return ret;
 }
 
-int bt_ctf_clock_set_offset(struct bt_ctf_clock *clock, uint64_t offset)
+int bt_ctf_clock_set_offset(struct bt_ctf_clock *clock, int64_t offset)
 {
 	int ret = 0;
 
@@ -316,20 +318,21 @@ end:
 	return ret;
 }
 
-uint64_t bt_ctf_clock_get_time(struct bt_ctf_clock *clock)
+int bt_ctf_clock_get_time(struct bt_ctf_clock *clock, int64_t *time)
 {
-	uint64_t ret = -1ULL;
+	int ret = 0;
 
-	if (!clock) {
+	if (!clock || !time) {
+		ret = -1;
 		goto end;
 	}
 
-	ret = clock->time;
+	*time = clock->time;
 end:
 	return ret;
 }
 
-int bt_ctf_clock_set_time(struct bt_ctf_clock *clock, uint64_t time)
+int bt_ctf_clock_set_time(struct bt_ctf_clock *clock, int64_t time)
 {
 	int ret = 0;
 
diff --git a/formats/ctf/ir/event.c b/formats/ctf/ir/event.c
index a36779d..3988b16 100644
--- a/formats/ctf/ir/event.c
+++ b/formats/ctf/ir/event.c
@@ -1141,11 +1141,11 @@ int bt_ctf_event_populate_event_header(struct bt_ctf_event *event)
 			timestamp_field_type);
 		bt_put(timestamp_field_type);
 		if (mapped_clock) {
-			uint64_t timestamp = bt_ctf_clock_get_time(
-				mapped_clock);
+			int64_t timestamp;
 
+			ret = bt_ctf_clock_get_time(mapped_clock, &timestamp);
 			bt_put(mapped_clock);
-			if (timestamp == (uint64_t) -1ULL) {
+			if (ret) {
 				goto end;
 			}
 
diff --git a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
index 1831b2d..53d67d2 100644
--- a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
+++ b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
@@ -2404,7 +2404,7 @@ int ctf_clock_declaration_visit(FILE *fd, int depth, struct ctf_node *node,
 				ret = -EPERM;
 				goto error;
 			}
-			ret = get_unary_unsigned(&node->u.ctf_expression.right, &clock->offset_s);
+			ret = get_unary_signed(&node->u.ctf_expression.right, &clock->offset_s);
 			if (ret) {
 				fprintf(fd, "[error] %s: unexpected unary expression for clock offset_s\n", __func__);
 				ret = -EINVAL;
@@ -2416,7 +2416,7 @@ int ctf_clock_declaration_visit(FILE *fd, int depth, struct ctf_node *node,
 				ret = -EPERM;
 				goto error;
 			}
-			ret = get_unary_unsigned(&node->u.ctf_expression.right, &clock->offset);
+			ret = get_unary_signed(&node->u.ctf_expression.right, &clock->offset);
 			if (ret) {
 				fprintf(fd, "[error] %s: unexpected unary expression for clock offset\n", __func__);
 				ret = -EINVAL;
diff --git a/include/babeltrace/babeltrace-internal.h b/include/babeltrace/babeltrace-internal.h
index c934550..df6406d 100644
--- a/include/babeltrace/babeltrace-internal.h
+++ b/include/babeltrace/babeltrace-internal.h
@@ -164,8 +164,8 @@ struct trace_collection {
 	GPtrArray *array;	/* struct bt_trace_descriptor */
 	GHashTable *clocks;	/* struct ctf_clock */
 
-	uint64_t single_clock_offset_avg;
-	uint64_t offset_first;
+	int64_t single_clock_offset_avg;
+	int64_t offset_first;
 	int64_t delta_offset_first_sum;
 	int offset_nr;
 	int clock_use_offset_avg;
@@ -193,8 +193,8 @@ extern int opt_all_field_names,
 	opt_clock_gmt,
 	opt_clock_force_correlate;
 
-extern uint64_t opt_clock_offset;
-extern uint64_t opt_clock_offset_ns;
+extern int64_t opt_clock_offset;
+extern int64_t opt_clock_offset_ns;
 extern int babeltrace_ctf_console_output;
 
 #endif
diff --git a/include/babeltrace/clock-internal.h b/include/babeltrace/clock-internal.h
index cd6bdba..4bd4611 100644
--- a/include/babeltrace/clock-internal.h
+++ b/include/babeltrace/clock-internal.h
@@ -47,9 +47,10 @@ uint64_t clock_cycles_to_ns(struct ctf_clock *clock, uint64_t cycles)
  * is recommended to express the seconds in offset_s, otherwise there
  * will be a loss of precision caused by the limited size of the double
  * mantissa.
+ * This offset can be negative.
  */
 static inline
-uint64_t clock_offset_ns(struct ctf_clock *clock)
+int64_t clock_offset_ns(struct ctf_clock *clock)
 {
 	return clock->offset_s * 1000000000ULL
 			+ clock_cycles_to_ns(clock, clock->offset);
diff --git a/include/babeltrace/ctf-ir/clock-internal.h b/include/babeltrace/ctf-ir/clock-internal.h
index 135b1c5..e139781 100644
--- a/include/babeltrace/ctf-ir/clock-internal.h
+++ b/include/babeltrace/ctf-ir/clock-internal.h
@@ -40,9 +40,9 @@ struct bt_ctf_clock {
 	GString *description;
 	uint64_t frequency;
 	uint64_t precision;
-	uint64_t offset_s;	/* Offset in seconds */
-	uint64_t offset;	/* Offset in ticks */
-	uint64_t time;		/* Current clock value */
+	int64_t offset_s;	/* Offset in seconds */
+	int64_t offset;		/* Offset in ticks */
+	int64_t time;		/* Current clock value */
 	uuid_t uuid;
 	int uuid_set;
 	int absolute;
diff --git a/include/babeltrace/ctf-ir/clock.h b/include/babeltrace/ctf-ir/clock.h
index 1ac8ca9..e149d7f 100644
--- a/include/babeltrace/ctf-ir/clock.h
+++ b/include/babeltrace/ctf-ir/clock.h
@@ -139,10 +139,12 @@ extern int bt_ctf_clock_set_precision(struct bt_ctf_clock *clock,
  * Get the clock's offset in seconds from POSIX.1 Epoch, 1970-01-01.
  *
  * @param clock Clock instance.
+ * @param offset_s Pointer to clock offset in seconds (output).
  *
- * Returns the clock's offset in seconds, -1ULL on error.
+ * Returns 0 on success, a negative value on error.
  */
-extern uint64_t bt_ctf_clock_get_offset_s(struct bt_ctf_clock *clock);
+extern int bt_ctf_clock_get_offset_s(struct bt_ctf_clock *clock,
+		int64_t *offset_s);
 
 /*
  * bt_ctf_clock_set_offset_s: set a clock's offset in seconds.
@@ -156,7 +158,7 @@ extern uint64_t bt_ctf_clock_get_offset_s(struct bt_ctf_clock *clock);
  * Returns 0 on success, a negative value on error.
  */
 extern int bt_ctf_clock_set_offset_s(struct bt_ctf_clock *clock,
-		uint64_t offset_s);
+		int64_t offset_s);
 
 /*
  * bt_ctf_clock_get_offset: get a clock's offset in ticks.
@@ -164,10 +166,12 @@ extern int bt_ctf_clock_set_offset_s(struct bt_ctf_clock *clock,
  * Get the clock's offset in ticks from Epoch + offset_t.
  *
  * @param clock Clock instance.
+ * @param offset Clock offset in ticks from Epoch + offset_s (output).
  *
- * Returns the clock's offset in ticks from Epoch + offset_s, -1ULL on error.
+ * Returns 0 on success, a negative value on error.
  */
-extern uint64_t bt_ctf_clock_get_offset(struct bt_ctf_clock *clock);
+extern int bt_ctf_clock_get_offset(struct bt_ctf_clock *clock,
+		int64_t *offset);
 
 /*
  * bt_ctf_clock_set_offset: set a clock's offset in ticks.
@@ -180,7 +184,7 @@ extern uint64_t bt_ctf_clock_get_offset(struct bt_ctf_clock *clock);
  * Returns 0 on success, a negative value on error.
  */
 extern int bt_ctf_clock_set_offset(struct bt_ctf_clock *clock,
-		uint64_t offset);
+		int64_t offset);
 
 /*
  * bt_ctf_clock_get_is_absolute: get a clock's absolute attribute.
@@ -239,9 +243,13 @@ extern int bt_ctf_clock_set_uuid(struct bt_ctf_clock *clock,
  * Get the current time in nanoseconds since the clock's origin (offset and
  * offset_s attributes).
  *
- * Returns the clock's current time value, -1ULL on error.
+ * @param clock Clock instance.
+ * @param time Clock current time value (output).
+ *
+ * Returns 0 on success, a negative value on error.
  */
-extern uint64_t bt_ctf_clock_get_time(struct bt_ctf_clock *clock);
+extern int bt_ctf_clock_get_time(struct bt_ctf_clock *clock,
+		int64_t *time);
 
 /*
  * bt_ctf_clock_set_time: set a clock's current time value.
@@ -252,7 +260,7 @@ extern uint64_t bt_ctf_clock_get_time(struct bt_ctf_clock *clock);
  * Returns 0 on success, a negative value on error.
  */
 extern int bt_ctf_clock_set_time(struct bt_ctf_clock *clock,
-		uint64_t time);
+		int64_t time);
 
 /*
  * bt_ctf_clock_get and bt_ctf_clock_put: increment and decrement the
diff --git a/include/babeltrace/ctf-ir/metadata.h b/include/babeltrace/ctf-ir/metadata.h
index bc68580..187cfdb 100644
--- a/include/babeltrace/ctf-ir/metadata.h
+++ b/include/babeltrace/ctf-ir/metadata.h
@@ -111,10 +111,14 @@ struct ctf_clock {
 	/*
 	 * The offset from Epoch is: offset_s + (offset * (1/freq))
 	 * Coarse clock offset from Epoch (in seconds).
+	 * It can be negative.
 	 */
-	uint64_t offset_s;
-	/* Fine clock offset from Epoch, in (1/freq) units. */
-	uint64_t offset;
+	int64_t offset_s;
+	/*
+	 * Fine clock offset from Epoch, in (1/freq) units.
+	 * It can be negative.
+	 */
+	int64_t offset;
 	int absolute;
 
 	enum {					/* Fields populated mask */
diff --git a/include/babeltrace/ctf/events.h b/include/babeltrace/ctf/events.h
index 9f06801..a876470 100644
--- a/include/babeltrace/ctf/events.h
+++ b/include/babeltrace/ctf/events.h
@@ -109,10 +109,12 @@ const char *bt_ctf_event_name(const struct bt_ctf_event *event);
 uint64_t bt_ctf_get_cycles(const struct bt_ctf_event *event);
 
 /*
- * bt_ctf_get_timestamp: returns the timestamp of the event offsetted
- * with the system clock source (in ns) or -1ULL on error
+ * bt_ctf_get_timestamp: get the timestamp of the event offsetted
+ * with the system clock source (in ns) in *timestamp.
+ *
+ * Return 0 on success, or -1ULL on error.
  */
-uint64_t bt_ctf_get_timestamp(const struct bt_ctf_event *event);
+int bt_ctf_get_timestamp(const struct bt_ctf_event *event, int64_t *timestamp);
 
 /*
  * bt_ctf_get_field_list: obtain the list of fields for compound type
diff --git a/include/babeltrace/ctf/types.h b/include/babeltrace/ctf/types.h
index cc8acbf..39591c6 100644
--- a/include/babeltrace/ctf/types.h
+++ b/include/babeltrace/ctf/types.h
@@ -45,8 +45,8 @@
 struct bt_stream_callbacks;
 
 struct packet_index_time {
-	uint64_t timestamp_begin;
-	uint64_t timestamp_end;
+	int64_t timestamp_begin;
+	int64_t timestamp_end;
 };
 
 struct packet_index {
@@ -246,7 +246,7 @@ void ctf_pos_get_event(struct ctf_stream_pos *pos)
 }
 
 void ctf_print_timestamp(FILE *fp, struct ctf_stream_definition *stream,
-			uint64_t timestamp);
+			int64_t timestamp);
 int ctf_append_trace_metadata(struct bt_trace_descriptor *tdp,
 			FILE *metadata_fp);
 
diff --git a/include/babeltrace/format.h b/include/babeltrace/format.h
index dea8e0e..c9b84a6 100644
--- a/include/babeltrace/format.h
+++ b/include/babeltrace/format.h
@@ -73,10 +73,12 @@ struct bt_format {
 			struct bt_context *ctx);
 	void (*set_handle)(struct bt_trace_descriptor *descriptor,
 			struct bt_trace_handle *handle);
-	uint64_t (*timestamp_begin)(struct bt_trace_descriptor *descriptor,
-			struct bt_trace_handle *handle, enum bt_clock_type type);
-	uint64_t (*timestamp_end)(struct bt_trace_descriptor *descriptor,
-			struct bt_trace_handle *handle, enum bt_clock_type type);
+	int (*timestamp_begin)(struct bt_trace_descriptor *descriptor,
+			struct bt_trace_handle *handle, enum bt_clock_type type,
+			int64_t *timestamp);
+	int (*timestamp_end)(struct bt_trace_descriptor *descriptor,
+			struct bt_trace_handle *handle, enum bt_clock_type type,
+			int64_t *timestamp);
 	int (*convert_index_timestamp)(struct bt_trace_descriptor *descriptor);
 };
 
diff --git a/include/babeltrace/trace-handle-internal.h b/include/babeltrace/trace-handle-internal.h
index 5e9c1c6..924c730 100644
--- a/include/babeltrace/trace-handle-internal.h
+++ b/include/babeltrace/trace-handle-internal.h
@@ -46,10 +46,10 @@ struct bt_trace_handle {
 	struct bt_trace_descriptor *td;
 	struct bt_format *format;
 	char path[PATH_MAX];
-	uint64_t real_timestamp_begin;
-	uint64_t real_timestamp_end;
-	uint64_t cycles_timestamp_begin;
-	uint64_t cycles_timestamp_end;
+	int64_t real_timestamp_begin;
+	int64_t real_timestamp_end;
+	int64_t cycles_timestamp_begin;
+	int64_t cycles_timestamp_end;
 };
 
 /*
diff --git a/include/babeltrace/trace-handle.h b/include/babeltrace/trace-handle.h
index 96e4a81..55c850f 100644
--- a/include/babeltrace/trace-handle.h
+++ b/include/babeltrace/trace-handle.h
@@ -53,20 +53,25 @@ struct bt_ctf_event;
 const char *bt_trace_handle_get_path(struct bt_context *ctx, int handle_id);
 
 /*
- * bt_trace_handle_get_timestamp_begin : returns the creation time (in
- * nanoseconds or cycles depending on type) of the buffers of a trace
- * or -1ULL on error.
+ * bt_trace_handle_get_timestamp_begin : get the creation time (in
+ * nanoseconds or cycles depending on type) of the buffers of a trace.
+ *
+ * Returns 0 on success, -1 on error.
  */
-uint64_t bt_trace_handle_get_timestamp_begin(struct bt_context *ctx,
-		int handle_id, enum bt_clock_type type);
+int bt_trace_handle_get_timestamp_begin(struct bt_context *ctx,
+		int handle_id, enum bt_clock_type type,
+		int64_t *timestamp);
 
 /*
- * bt_trace_handle_get_timestamp_end : returns the destruction timestamp
- * (in nanoseconds or cycles depending on type) of the buffers of a trace
- * or -1ULL on error.
+ * bt_trace_handle_get_timestamp_end : get the destruction time
+ * (in nanoseconds or cycles depending on type) of the buffers of a
+ * trace.
+ *
+ * Returns 0 on success, -1 on error.
  */
-uint64_t bt_trace_handle_get_timestamp_end(struct bt_context *ctx,
-		int handle_id, enum bt_clock_type type);
+int bt_trace_handle_get_timestamp_end(struct bt_context *ctx,
+		int handle_id, enum bt_clock_type type,
+		int64_t *timestamp);
 
 /*
  * bt_ctf_event_get_handle_id : get the handle id associated with an event
diff --git a/lib/context.c b/lib/context.c
index 45aab34..3617bcd 100644
--- a/lib/context.c
+++ b/lib/context.c
@@ -115,7 +115,7 @@ int bt_context_add_trace(struct bt_context *ctx, const char *path,
 		fprintf(stderr, "[error] [Context] Creating trace handle %s .\n\n",
 				path);
 		ret = -1;
-		goto error;
+		goto error_close;
 	}
 	handle->format = fmt;
 	handle->td = td;
@@ -124,41 +124,67 @@ int bt_context_add_trace(struct bt_context *ctx, const char *path,
 		handle->path[PATH_MAX - 1] = '\0';
 	}
 
+	ret = bt_trace_collection_add(ctx->tc, td);
+	if (ret != 0)
+		goto error_destroy_handle;
+
 	if (fmt->set_handle)
 		fmt->set_handle(td, handle);
 	if (fmt->set_context)
 		fmt->set_context(td, ctx);
 
-	/* Add new handle to container */
-	g_hash_table_insert(ctx->trace_handles,
-		(gpointer) (unsigned long) handle->id,
-		handle);
-	ret = bt_trace_collection_add(ctx->tc, td);
-	if (ret != 0)
-		goto error;
-
 	if (fmt->convert_index_timestamp) {
 		ret = fmt->convert_index_timestamp(td);
 		if (ret < 0)
-			goto error;
+			goto error_collection_del;
+	}
+
+	if (fmt->timestamp_begin) {
+		ret = fmt->timestamp_begin(td, handle, BT_CLOCK_REAL,
+				&handle->real_timestamp_begin);
+		if (ret < 0 && ret != -ENOENT) {
+			ret = -1;
+			goto error_collection_del;
+		}
+	}
+	if (fmt->timestamp_end) {
+		ret = fmt->timestamp_end(td, handle, BT_CLOCK_REAL,
+				&handle->real_timestamp_end);
+		if (ret < 0 && ret != -ENOENT) {
+			ret = -1;
+			goto error_collection_del;
+		}
+	}
+	if (fmt->timestamp_begin) {
+		ret = fmt->timestamp_begin(td, handle, BT_CLOCK_CYCLES,
+				&handle->cycles_timestamp_begin);
+		if (ret < 0 && ret != -ENOENT) {
+			ret = -1;
+			goto error_collection_del;
+		}
+	}
+	if (fmt->timestamp_end) {
+		ret = fmt->timestamp_end(td, handle, BT_CLOCK_CYCLES,
+				&handle->cycles_timestamp_end);
+		if (ret < 0 && ret != -ENOENT) {
+			ret = -1;
+			goto error_collection_del;
+		}
 	}
 
-	if (fmt->timestamp_begin)
-		handle->real_timestamp_begin = fmt->timestamp_begin(td,
-				handle, BT_CLOCK_REAL);
-	if (fmt->timestamp_end)
-		handle->real_timestamp_end = fmt->timestamp_end(td, handle,
-				BT_CLOCK_REAL);
-	if (fmt->timestamp_begin)
-		handle->cycles_timestamp_begin = fmt->timestamp_begin(td,
-				handle, BT_CLOCK_CYCLES);
-	if (fmt->timestamp_end)
-		handle->cycles_timestamp_end = fmt->timestamp_end(td, handle,
-				BT_CLOCK_CYCLES);
+	/* Add new handle to container */
+	g_hash_table_insert(ctx->trace_handles,
+		(gpointer) (unsigned long) handle->id,
+		handle);
 
 	return handle->id;
 
-error:
+error_collection_del:
+	/* Remove from containers */
+	bt_trace_collection_remove(handle->td->ctx->tc, handle->td);
+error_destroy_handle:
+	bt_trace_handle_destroy(handle);
+error_close:
 	closeret = fmt->close_trace(td);
 	if (closeret) {
 		fprintf(stderr, "Error in close_trace callback\n");
diff --git a/lib/trace-handle.c b/lib/trace-handle.c
index d5b906a..b768a08 100644
--- a/lib/trace-handle.c
+++ b/lib/trace-handle.c
@@ -66,54 +66,56 @@ const char *bt_trace_handle_get_path(struct bt_context *ctx, int handle_id)
 	return handle->path;
 }
 
-uint64_t bt_trace_handle_get_timestamp_begin(struct bt_context *ctx,
-		int handle_id, enum bt_clock_type type)
+int bt_trace_handle_get_timestamp_begin(struct bt_context *ctx,
+		int handle_id, enum bt_clock_type type,
+		int64_t *timestamp)
 {
 	struct bt_trace_handle *handle;
-	uint64_t ret;
+	int ret = 0;
 
-	if (!ctx)
-		return -1ULL;
+	if (!ctx || !timestamp)
+		return -1;
 
 	handle = g_hash_table_lookup(ctx->trace_handles,
 			(gpointer) (unsigned long) handle_id);
 	if (!handle) {
-		ret = -1ULL;
+		ret = -1;
 		goto end;
 	}
 	if (type == BT_CLOCK_REAL) {
-		ret = handle->real_timestamp_begin;
+		*timestamp = handle->real_timestamp_begin;
 	} else if (type == BT_CLOCK_CYCLES) {
-		ret = handle->cycles_timestamp_begin;
+		*timestamp = handle->cycles_timestamp_begin;
 	} else {
-		ret = -1ULL;
+		ret = -1;
 	}
 
 end:
 	return ret;
 }
 
-uint64_t bt_trace_handle_get_timestamp_end(struct bt_context *ctx,
-		int handle_id, enum bt_clock_type type)
+int bt_trace_handle_get_timestamp_end(struct bt_context *ctx,
+		int handle_id, enum bt_clock_type type,
+		int64_t *timestamp)
 {
 	struct bt_trace_handle *handle;
-	uint64_t ret;
+	int ret = 0;
 
-	if (!ctx)
-		return -1ULL;
+	if (!ctx || !timestamp)
+		return -1;
 
 	handle = g_hash_table_lookup(ctx->trace_handles,
 			(gpointer) (unsigned long) handle_id);
 	if (!handle) {
-		ret = -1ULL;
+		ret = -1;
 		goto end;
 	}
 	if (type == BT_CLOCK_REAL) {
-		ret = handle->real_timestamp_end;
+		*timestamp = handle->real_timestamp_end;
 	} else if (type == BT_CLOCK_CYCLES) {
-		ret = handle->cycles_timestamp_end;
+		*timestamp = handle->cycles_timestamp_end;
 	} else {
-		ret = -1ULL;
+		ret = -1;
 	}
 
 end:
diff --git a/tests/lib/test_ctf_writer.c b/tests/lib/test_ctf_writer.c
index 596bb90..72d9b1c 100644
--- a/tests/lib/test_ctf_writer.c
+++ b/tests/lib/test_ctf_writer.c
@@ -57,7 +57,7 @@
 #define DEFAULT_CLOCK_IS_ABSOLUTE 0
 #define DEFAULT_CLOCK_TIME 0
 
-static uint64_t current_time = 42;
+static int64_t current_time = 42;
 
 /* Return 1 if uuids match, zero if different. */
 int uuid_match(const unsigned char *uuid_a, const unsigned char *uuid_b)
@@ -2656,8 +2656,11 @@ int main(int argc, char **argv)
 	const char *returned_clock_name;
 	const char *returned_clock_description;
 	const uint64_t frequency = 1123456789;
-	const uint64_t offset_s = 1351530929945824323;
-	const uint64_t offset = 1234567;
+	const int64_t offset_s = 1351530929945824323;
+	const int64_t offset = 1234567;
+	int64_t get_offset_s,
+		get_offset,
+		get_time;
 	const uint64_t precision = 10;
 	const int is_absolute = 0xFF;
 	char *metadata_string;
@@ -2899,18 +2902,26 @@ int main(int argc, char **argv)
 	ok(bt_ctf_clock_get_frequency(clock) == frequency,
 		"bt_ctf_clock_get_frequency returns the correct frequency once it is set");
 
-	ok(bt_ctf_clock_get_offset_s(clock) == DEFAULT_CLOCK_OFFSET_S,
+	ok(bt_ctf_clock_get_offset_s(clock, &get_offset_s) == 0,
+		"bt_ctf_clock_get_offset_s succeeds");
+	ok(get_offset_s == DEFAULT_CLOCK_OFFSET_S,
 		"bt_ctf_clock_get_offset_s returns the correct default offset (in seconds)");
 	ok(bt_ctf_clock_set_offset_s(clock, offset_s) == 0,
 		"Set clock offset (seconds)");
-	ok(bt_ctf_clock_get_offset_s(clock) == offset_s,
+	ok(bt_ctf_clock_get_offset_s(clock, &get_offset_s) == 0,
+		"bt_ctf_clock_get_offset_s succeeds");
+	ok(get_offset_s == offset_s,
 		"bt_ctf_clock_get_offset_s returns the correct default offset (in seconds) once it is set");
 
-	ok(bt_ctf_clock_get_offset(clock) == DEFAULT_CLOCK_OFFSET,
-		"bt_ctf_clock_get_frequency returns the correct default offset (in ticks)");
+	ok(bt_ctf_clock_get_offset(clock, &get_offset) == 0,
+		"bt_ctf_clock_get_offset succeeds");
+	ok(get_offset == DEFAULT_CLOCK_OFFSET,
+		"bt_ctf_clock_get_offset returns the correct default offset (in ticks)");
 	ok(bt_ctf_clock_set_offset(clock, offset) == 0, "Set clock offset");
-	ok(bt_ctf_clock_get_offset(clock) == offset,
-		"bt_ctf_clock_get_frequency returns the correct default offset (in ticks) once it is set");
+	ok(bt_ctf_clock_get_offset(clock, &get_offset) == 0,
+		"bt_ctf_clock_get_offset succeeds");
+	ok(get_offset == offset,
+		"bt_ctf_clock_get_offset returns the correct default offset (in ticks) once it is set");
 
 	ok(bt_ctf_clock_get_precision(clock) == DEFAULT_CLOCK_PRECISION,
 		"bt_ctf_clock_get_precision returns the correct default precision");
@@ -2926,11 +2937,15 @@ int main(int argc, char **argv)
 	ok(bt_ctf_clock_get_is_absolute(clock) == !!is_absolute,
 		"bt_ctf_clock_get_precision returns the correct is_absolute attribute once it is set");
 
-	ok(bt_ctf_clock_get_time(clock) == DEFAULT_CLOCK_TIME,
+	ok(bt_ctf_clock_get_time(clock, &get_time) == 0,
+		"bt_ctf_clock_get_time succeeds");
+	ok(get_time == DEFAULT_CLOCK_TIME,
 		"bt_ctf_clock_get_time returns the correct default time");
 	ok(bt_ctf_clock_set_time(clock, current_time) == 0,
 		"Set clock time");
-	ok(bt_ctf_clock_get_time(clock) == current_time,
+	ok(bt_ctf_clock_get_time(clock, &get_time) == 0,
+		"bt_ctf_clock_get_time succeeds");
+	ok(get_time == current_time,
 		"bt_ctf_clock_get_time returns the correct time once it is set");
 
 	ok(bt_ctf_writer_add_clock(writer, clock) == 0,
@@ -2973,14 +2988,20 @@ int main(int argc, char **argv)
 		"bt_ctf_clock_get_frequency correctly handles NULL");
 	ok(bt_ctf_clock_get_precision(NULL) == -1ULL,
 		"bt_ctf_clock_get_precision correctly handles NULL");
-	ok(bt_ctf_clock_get_offset_s(NULL) == -1ULL,
-		"bt_ctf_clock_get_offset_s correctly handles NULL");
-	ok(bt_ctf_clock_get_offset(NULL) == -1ULL,
-		"bt_ctf_clock_get_offset correctly handles NULL");
+	ok(bt_ctf_clock_get_offset_s(NULL, &get_offset_s) < 0,
+		"bt_ctf_clock_get_offset_s correctly handles NULL clock");
+	ok(bt_ctf_clock_get_offset_s(clock, NULL) < 0,
+		"bt_ctf_clock_get_offset_s correctly handles NULL output");
+	ok(bt_ctf_clock_get_offset(NULL, &get_offset) < 0,
+		"bt_ctf_clock_get_offset correctly handles NULL clock");
+	ok(bt_ctf_clock_get_offset(clock, NULL) < 0,
+		"bt_ctf_clock_get_offset correctly handles NULL output");
 	ok(bt_ctf_clock_get_is_absolute(NULL) < 0,
 		"bt_ctf_clock_get_is_absolute correctly handles NULL");
-	ok(bt_ctf_clock_get_time(NULL) == -1ULL,
-		"bt_ctf_clock_get_time correctly handles NULL");
+	ok(bt_ctf_clock_get_time(NULL, &get_time) < 0,
+		"bt_ctf_clock_get_time correctly handles NULL clock");
+	ok(bt_ctf_clock_get_time(clock, NULL) < 0,
+		"bt_ctf_clock_get_time correctly handles NULL output");
 
 	ok(bt_ctf_clock_set_description(NULL, NULL) < 0,
 		"bt_ctf_clock_set_description correctly handles NULL clock");
diff --git a/tests/lib/test_seek.c b/tests/lib/test_seek.c
index de2c934..38dd9eb 100644
--- a/tests/lib/test_seek.c
+++ b/tests/lib/test_seek.c
@@ -33,7 +33,7 @@
 #include <tap/tap.h>
 #include "common.h"
 
-#define NR_TESTS	29
+#define NR_TESTS	36
 
 void run_seek_begin(char *path, uint64_t expected_begin)
 {
@@ -42,8 +42,8 @@ void run_seek_begin(char *path, uint64_t expected_begin)
 	struct bt_ctf_event *event;
 	struct bt_iter_pos newpos;
 	int ret;
-	uint64_t timestamp_begin;
-	uint64_t timestamp_seek_begin;
+	int64_t timestamp_begin;
+	int64_t timestamp_seek_begin;
 	unsigned int nr_seek_begin_test;
 
 	nr_seek_begin_test = 5;
@@ -67,7 +67,7 @@ void run_seek_begin(char *path, uint64_t expected_begin)
 	ok(event, "Event valid");
 
 	/* Validate that the first timestamp is right */
-	timestamp_begin = bt_ctf_get_timestamp(event);
+	ok1(bt_ctf_get_timestamp(event, &timestamp_begin) == 0);
 
 	ok1(timestamp_begin == expected_begin);
 
@@ -81,7 +81,7 @@ void run_seek_begin(char *path, uint64_t expected_begin)
 
 	ok(event, "Event valid");
 
-	timestamp_seek_begin = bt_ctf_get_timestamp(event);
+	ok1(bt_ctf_get_timestamp(event, &timestamp_seek_begin) == 0);
 
 	ok1(timestamp_begin == timestamp_seek_begin);
 
@@ -96,7 +96,7 @@ void run_seek_last(char *path, uint64_t expected_last)
 	struct bt_ctf_event *event;
 	struct bt_iter_pos newpos;
 	int ret;
-	uint64_t timestamp_last;
+	int64_t timestamp_last;
 	unsigned int nr_seek_last_tests;
 
 	nr_seek_last_tests = 6;
@@ -129,7 +129,7 @@ void run_seek_last(char *path, uint64_t expected_last)
 
 	ok(event, "Event valid at last position");
 
-	timestamp_last = bt_ctf_get_timestamp(event);
+	ok1(bt_ctf_get_timestamp(event, &timestamp_last) == 0);
 
 	ok1(timestamp_last == expected_last);
 
@@ -152,7 +152,7 @@ void run_seek_time_at_last(char *path, uint64_t expected_last)
 	struct bt_ctf_event *event;
 	struct bt_iter_pos newpos;
 	int ret;
-	uint64_t timestamp_last;
+	int64_t timestamp_last;
 	unsigned int nr_seek_time_at_last_tests;
 
 	nr_seek_time_at_last_tests = 6;
@@ -188,7 +188,7 @@ void run_seek_time_at_last(char *path, uint64_t expected_last)
 
 	ok(event, "Event valid at last position");
 
-	timestamp_last = bt_ctf_get_timestamp(event);
+	ok1(bt_ctf_get_timestamp(event, &timestamp_last) == 0);
 
 	ok1(timestamp_last == expected_last);
 
@@ -213,7 +213,7 @@ void run_seek_cycles(char *path,
 	struct bt_ctf_event *event;
 	struct bt_iter_pos newpos;
 	int ret;
-	uint64_t timestamp;
+	int64_t timestamp;
 
 	unsigned int nr_seek_cycles_tests;
 
@@ -247,7 +247,7 @@ void run_seek_cycles(char *path,
 
 	ok(event, "Event valid at last position");
 
-	timestamp = bt_ctf_get_timestamp(event);
+	ok1(bt_ctf_get_timestamp(event, &timestamp) == 0);
 
 	ok1(timestamp == expected_last);
 
@@ -270,7 +270,7 @@ void run_seek_cycles(char *path,
 
 	ok(event, "Event valid at first position");
 
-	timestamp = bt_ctf_get_timestamp(event);
+	ok1(bt_ctf_get_timestamp(event, &timestamp) == 0);
 
 	ok1(timestamp == expected_begin);
 
@@ -284,7 +284,7 @@ void run_seek_cycles(char *path,
 
 	ok(event, "Event valid at last position");
 
-	timestamp = bt_ctf_get_timestamp(event);
+	ok1(bt_ctf_get_timestamp(event, &timestamp) == 0);
 
 	ok1(timestamp == expected_last);
 
-- 
2.1.4
