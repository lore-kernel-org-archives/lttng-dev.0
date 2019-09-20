From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: Move initialization of
 queue_pipe_fd after null check of handle
Date: Fri, 20 Sep 2019 11:07:55 -0400
Message-ID: <20190920150756.7959-1-jonathan.rajotte-julien__47475.0937473559$1568992100$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 46ZcXh1p6rzqLS
 for <lttng-dev@lists.lttng.org>; Fri, 20 Sep 2019 11:08:03 -0400 (EDT)
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

Fixes coverity #1399732

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/bin/lttng-sessiond/rotation-thread.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/bin/lttng-sessiond/rotation-thread.c b/src/bin/lttng-sessiond/rotation-thread.c
index 7bd6c6819..1ee3974f0 100644
--- a/src/bin/lttng-sessiond/rotation-thread.c
+++ b/src/bin/lttng-sessiond/rotation-thread.c
@@ -832,8 +832,6 @@ void *thread_rotation(void *data)
 	int ret;
 	struct rotation_thread_handle *handle = data;
 	struct rotation_thread thread;
-	const int queue_pipe_fd = lttng_pipe_get_readfd(
-			handle->rotation_timer_queue->event_pipe);
 
 	DBG("[rotation-thread] Started rotation thread");
 
@@ -842,6 +840,10 @@ void *thread_rotation(void *data)
 		goto end;
 	}
 
+	/* Must be after null checking of handle for const assignment */
+	const int queue_pipe_fd = lttng_pipe_get_readfd(
+			handle->rotation_timer_queue->event_pipe);
+
 	rcu_register_thread();
 	rcu_thread_online();
 
-- 
2.17.1
