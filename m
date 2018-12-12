From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 2/2] Fix:
 handle_notification_thread_command: handle partial read
Date: Wed, 12 Dec 2018 15:11:15 -0500
Message-ID: <20181212201115.14997-2-mathieu.desnoyers__45737.9108797342$1544645376$gmane$org@efficios.com>
References: <20181212201115.14997-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 43FScl6VGQz1786
 for <lttng-dev@lists.lttng.org>; Wed, 12 Dec 2018 15:11:19 -0500 (EST)
In-Reply-To: <20181212201115.14997-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com, joraj@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Use lttng_read() to handle partial reads (returning less than the
requested amount of bytes) as well as ret = -1, errno == EINTR.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/notification-thread-events.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/bin/lttng-sessiond/notification-thread-events.c b/src/bin/lttng-sessiond/notification-thread-events.c
index 3482a7e8..9cc91cc4 100644
--- a/src/bin/lttng-sessiond/notification-thread-events.c
+++ b/src/bin/lttng-sessiond/notification-thread-events.c
@@ -2277,9 +2277,9 @@ int handle_notification_thread_command(
 	struct notification_thread_command *cmd;
 
 	/* Read the event pipe to put it back into a quiescent state. */
-	ret = read(lttng_pipe_get_readfd(handle->cmd_queue.event_pipe), &counter,
+	ret = lttng_read(lttng_pipe_get_readfd(handle->cmd_queue.event_pipe), &counter,
 			sizeof(counter));
-	if (ret == -1) {
+	if (ret != sizeof(counter)) {
 		goto error;
 	}
 
-- 
2.11.0
