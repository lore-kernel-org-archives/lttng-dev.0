From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: run_command_wait() handle
 partial write
Date: Thu, 13 Dec 2018 13:56:35 -0500
Message-ID: <20181213185635.8019-1-mathieu.desnoyers__9103.91749716855$1544727282$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 43G2w64Wqdz1721
 for <lttng-dev@lists.lttng.org>; Thu, 13 Dec 2018 13:56:38 -0500 (EST)
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

Use lttng_write() to handle partial writes (writing less than the
requested amount of bytes) as well as ret = -1, errno = EINTR.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/notification-thread-commands.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/bin/lttng-sessiond/notification-thread-commands.c b/src/bin/lttng-sessiond/notification-thread-commands.c
index 11275ffc..129cf4ee 100644
--- a/src/bin/lttng-sessiond/notification-thread-commands.c
+++ b/src/bin/lttng-sessiond/notification-thread-commands.c
@@ -44,9 +44,9 @@ int run_command_wait(struct notification_thread_handle *handle,
 	cds_list_add_tail(&cmd->cmd_list_node,
 			&handle->cmd_queue.list);
 	/* Wake-up thread. */
-	ret = write(lttng_pipe_get_writefd(handle->cmd_queue.event_pipe),
+	ret = lttng_write(lttng_pipe_get_writefd(handle->cmd_queue.event_pipe),
 			&notification_counter, sizeof(notification_counter));
-	if (ret < 0) {
+	if (ret != sizeof(notification_counter)) {
 		PERROR("write to notification thread's queue event fd");
 		/*
 		 * Remove the command from the list so the notification
-- 
2.11.0
