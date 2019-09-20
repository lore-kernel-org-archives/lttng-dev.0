From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: Free new_chunk on error
Date: Fri, 20 Sep 2019 10:47:30 -0400
Message-ID: <20190920144730.163268-1-jonathan.rajotte-julien__38693.0082387821$1568990880$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 46Zc5D2vsVzqK5
 for <lttng-dev@lists.lttng.org>; Fri, 20 Sep 2019 10:47:44 -0400 (EDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Fixes coverity #1405775

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/common/trace-chunk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/common/trace-chunk.c b/src/common/trace-chunk.c
index 6770bd982..bad993bea 100644
--- a/src/common/trace-chunk.c
+++ b/src/common/trace-chunk.c
@@ -367,6 +367,8 @@ end:
 	return new_chunk;
 error_unlock:
 	pthread_mutex_unlock(&source_chunk->lock);
+	lttng_trace_chunk_fini(new_chunk);
+	free(new_chunk);
 	return NULL;
 }
 
-- 
2.17.1
