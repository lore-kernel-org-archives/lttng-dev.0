From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 3/3] Handle empty streams on iterator
	init
Date: Wed, 27 Nov 2013 10:06:03 -0500
Message-ID: <1385564763-1374-3-git-send-email-jdesfossez__30639.694320462$1385565044$gmane$org@efficios.com>
References: <1385564763-1374-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1Vlgh1-0007WZ-8K
	for lttng-dev@lists.lttng.org; Wed, 27 Nov 2013 10:06:27 -0500
In-Reply-To: <1385564763-1374-1-git-send-email-jdesfossez@efficios.com>
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

In live trace streaming, we can create an iterator with inactive
streams. This patch allows inactive streams to be considered as valid.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 lib/iterator.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/iterator.c b/lib/iterator.c
index 155fcbe..3280f4a 100644
--- a/lib/iterator.c
+++ b/lib/iterator.c
@@ -725,7 +725,7 @@ int bt_iter_init(struct bt_iter *iter,
 				if (ret == EOF) {
 					ret = 0;
 					continue;
-				} else if (ret) {
+				} else if (ret != 0 && ret != EAGAIN) {
 					goto error;
 				}
 				/* Add to heap */
@@ -821,6 +821,13 @@ reinsert:
 	removed = bt_heap_replace_max(iter->stream_heap, file_stream);
 	assert(removed == file_stream);
 
+	file_stream = bt_heap_maximum(iter->stream_heap);
+	if (file_stream->pos.content_size == 0) {
+		ret = EAGAIN;
+	} else {
+		ret = 0;
+	}
+
 end:
 	return ret;
 }
-- 
1.8.3.2
