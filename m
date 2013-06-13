From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: [BABELTRACE PATCH] Move some validation in
	ctf_packet_seek in the SEEK_CUR section
Date: Thu, 13 Jun 2013 16:21:41 -0400
Message-ID: <1371154901-5779-1-git-send-email-yannick.brosseau__12995.6358731308$1371154961$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1UnE21-0003uW-VW
	for lttng-dev@lists.lttng.org; Thu, 13 Jun 2013 16:22:06 -0400
Received: by mail-ie0-f178.google.com with SMTP id u16so4917879iet.23
	for <lttng-dev@lists.lttng.org>; Thu, 13 Jun 2013 13:22:00 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The test that the current position is not already over the end of the trace apply only
for the SEEK_CUR (seek next packet) section. A SEEK_SET can bring back the current position
pointer to a valid position.

Also add a unit test to validate the seeking at the last event of the trace.

Fixes #551

Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
---
 formats/ctf/ctf.c      |   17 +++++++--------
 tests/lib/test-seeks.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 10 deletions(-)

diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index bb94e52..ed3defd 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -670,7 +670,7 @@ int ctf_fini_pos(struct ctf_stream_pos *pos)
 
 /*
  * for SEEK_CUR: go to next packet.
- * for SEEK_POS: go to packet numer (index).
+ * for SEEK_SET: go to packet numer (index).
  */
 void ctf_packet_seek(struct bt_stream_pos *stream_pos, size_t index, int whence)
 {
@@ -682,6 +682,7 @@ void ctf_packet_seek(struct bt_stream_pos *stream_pos, size_t index, int whence)
 	off_t off;
 	struct packet_index *packet_index;
 
+	/* Test precondition (whence valid values) */
 	switch (whence) {
 	case SEEK_CUR:
 	case SEEK_SET:	/* Fall-through */
@@ -729,19 +730,17 @@ void ctf_packet_seek(struct bt_stream_pos *stream_pos, size_t index, int whence)
 		pos->offset = 0;
 	} else {
 	read_next_packet:
-		if (pos->cur_index >= pos->packet_cycles_index->len) {
-			pos->offset = EOF;
-			return;
-		}
-		if (pos->cur_index >= pos->packet_real_index->len) {
-			pos->offset = EOF;
-			return;
-		}
 		switch (whence) {
 		case SEEK_CUR:
 		{
 			uint64_t events_discarded_diff;
 
+			if (pos->cur_index >= pos->packet_cycles_index->len) {
+				pos->offset = EOF;
+			}
+			if (pos->cur_index >= pos->packet_real_index->len) {
+				pos->offset = EOF;
+			}
 			if (pos->offset == EOF) {
 				return;
 			}
diff --git a/tests/lib/test-seeks.c b/tests/lib/test-seeks.c
index 47bb42e..a7b1360 100644
--- a/tests/lib/test-seeks.c
+++ b/tests/lib/test-seeks.c
@@ -32,7 +32,7 @@
 #include "common.h"
 #include "tap.h"
 
-#define NR_TESTS	23
+#define NR_TESTS	29
 
 void run_seek_begin(char *path, uint64_t expected_begin)
 {
@@ -134,6 +134,58 @@ void run_seek_last(char *path, uint64_t expected_last)
 	bt_context_put(ctx);
 }
 
+void run_seek_time_at_last(char *path, uint64_t expected_last)
+{
+	struct bt_context *ctx;
+	struct bt_ctf_iter *iter;
+	struct bt_ctf_event *event;
+	struct bt_iter_pos newpos;
+	int ret;
+	uint64_t timestamp_last;
+
+	/* Open the trace */
+	ctx = create_context_with_path(path);
+	if (!ctx) {
+		plan_skip_all("Cannot create valid context");
+	}
+
+	/* Create iterator with null last and end */
+	iter = bt_ctf_iter_create(ctx, NULL, NULL);
+	if (!iter) {
+		plan_skip_all("Cannot create valid iterator");
+	}
+
+	event = bt_ctf_iter_read_event(iter);
+
+	ok(event, "Event valid at beginning");
+
+	/* Seek to last */
+	newpos.type = BT_SEEK_TIME;
+	newpos.u.seek_time = expected_last;
+	ret = bt_iter_set_pos(bt_ctf_get_iter(iter), &newpos);
+
+	ok(ret == 0, "Seek time at last retval %d", ret);
+
+	event = bt_ctf_iter_read_event(iter);
+
+	ok(event, "Event valid at last position");
+
+	timestamp_last = bt_ctf_get_timestamp(event);
+
+	ok1(timestamp_last == expected_last);
+
+	/* Try to read next event */
+	ret = bt_iter_next(bt_ctf_get_iter(iter));
+
+	ok(ret == 0, "iter next should return an error");
+
+	event = bt_ctf_iter_read_event(iter);
+
+	ok(event == 0, "Event after last should be invalid");
+
+	bt_context_put(ctx);
+}
+
 void run_seek_cycles(char *path,
 		uint64_t expected_begin,
 		uint64_t expected_last)
@@ -242,6 +294,7 @@ int main(int argc, char **argv)
 	}
 
 	run_seek_begin(path, expected_begin);
+	run_seek_time_at_last(path, expected_last);
 	run_seek_last(path, expected_last);
 	run_seek_cycles(path, expected_begin, expected_last);
 
-- 
1.7.10.4
