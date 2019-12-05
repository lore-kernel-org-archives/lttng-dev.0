From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH babeltrace-1.5 4/6] Fix: lib/iterator.c:
 unbalanced ctx put (leak)
Date: Thu,  5 Dec 2019 01:58:07 -0500
Message-ID: <20191205065809.16728-5-mathieu.desnoyers__13881.4885796577$1575529241$gmane$org@efficios.com>
References: <20191205065809.16728-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 47T64S1Ydvz10V0
 for <lttng-dev@lists.lttng.org>; Thu,  5 Dec 2019 01:58:16 -0500 (EST)
In-Reply-To: <20191205065809.16728-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Missing context put in iterator init error path.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 lib/iterator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/iterator.c b/lib/iterator.c
index 639a2d29..77093217 100644
--- a/lib/iterator.c
+++ b/lib/iterator.c
@@ -778,6 +778,8 @@ int bt_iter_init(struct bt_iter *iter,
 error:
 	bt_heap_free(iter->stream_heap);
 error_heap_init:
+	bt_context_put(ctx);
+	iter->ctx = NULL;
 	g_free(iter->stream_heap);
 	iter->stream_heap = NULL;
 error_ctx:
@@ -812,6 +814,7 @@ void bt_iter_fini(struct bt_iter *iter)
 	}
 	iter->ctx->current_iterator = NULL;
 	bt_context_put(iter->ctx);
+	iter->ctx = NULL;
 }
 
 void bt_iter_destroy(struct bt_iter *iter)
-- 
2.17.1
