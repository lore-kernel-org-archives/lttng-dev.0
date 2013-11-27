From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 1/3] Handle the inactive streams
Date: Wed, 27 Nov 2013 10:06:01 -0500
Message-ID: <1385564763-1374-1-git-send-email-jdesfossez__45073.7489307814$1385564841$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1Vlggy-0007V2-D2
	for lttng-dev@lists.lttng.org; Wed, 27 Nov 2013 10:06:22 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

When content_size == 0, just set the timestamp_end of the packet and
reinsert the stream in the heap.
This is required to handle the beacons of inactivity generated in
LTTng live trace streaming.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 formats/ctf/ctf.c |  5 +++++
 lib/iterator.c    | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index 794e428..5f263cd 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -471,6 +471,11 @@ int ctf_read_event(struct bt_stream_pos *ppos, struct ctf_stream_definition *str
 	 */
 	if (unlikely(pos->offset == EOF))
 		return EOF;
+
+	if (pos->content_size == 0) {
+		/* Stream is inactive for now (live reading). */
+		return EAGAIN;
+	}
 	assert(pos->offset < pos->content_size);
 
 	/* Read event header */
diff --git a/lib/iterator.c b/lib/iterator.c
index 009fcd3..155fcbe 100644
--- a/lib/iterator.c
+++ b/lib/iterator.c
@@ -65,6 +65,9 @@ static int stream_read_event(struct ctf_file_stream *sin)
 	ret = sin->pos.parent.event_cb(&sin->pos.parent, &sin->parent);
 	if (ret == EOF)
 		return EOF;
+	else if (ret == EAGAIN)
+		/* Stream is inactive for now (live reading). */
+		return EAGAIN;
 	else if (ret) {
 		fprintf(stderr, "[error] Reading event failed.\n");
 		return ret;
@@ -803,9 +806,17 @@ int bt_iter_next(struct bt_iter *iter)
 		assert(removed == file_stream);
 		ret = 0;
 		goto end;
+	} else if (ret == EAGAIN) {
+		/*
+		 * The stream is inactive for now, we just updated the timestamp_end
+		 * to skip over this stream up to a certain point in time.
+		 */
+		goto reinsert;
 	} else if (ret) {
 		goto end;
 	}
+
+reinsert:
 	/* Reinsert the file stream into the heap, and rebalance. */
 	removed = bt_heap_replace_max(iter->stream_heap, file_stream);
 	assert(removed == file_stream);
-- 
1.8.3.2
