From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 2/3] lttng-ctl: notifications: use
 epoll()/poll() instead of select()
Date: Thu, 16 May 2019 15:08:51 -0400
Message-ID: <20190516190852.16946-2-mathieu.desnoyers__9913.99628562562$1558034047$gmane$org@efficios.com>
References: <20190516190852.16946-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 454gvC10V7zyrX
 for <lttng-dev@lists.lttng.org>; Thu, 16 May 2019 15:08:55 -0400 (EDT)
In-Reply-To: <20190516190852.16946-1-mathieu.desnoyers@efficios.com>
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

The select(2) system call is an ancient ABI limited to processes
containing at most FD_SETSIZE file descriptors overall (typically
1024).

Those notification APIs will fail if the target file descriptor
is above FD_SETSIZE in a process containing many file descriptors.

Never use select, use the lttng epoll/poll wrapper instead.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/lib/lttng-ctl/channel.c | 76 ++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 31 deletions(-)

diff --git a/src/lib/lttng-ctl/channel.c b/src/lib/lttng-ctl/channel.c
index 5271aa13..bcecc65f 100644
--- a/src/lib/lttng-ctl/channel.c
+++ b/src/lib/lttng-ctl/channel.c
@@ -26,8 +26,7 @@
 #include <common/defaults.h>
 #include <assert.h>
 #include "lttng-ctl-helper.h"
-#include <sys/select.h>
-#include <sys/time.h>
+#include <common/compat/poll.h>
 
 static
 int handshake(struct lttng_notification_channel *channel);
@@ -211,7 +210,7 @@ lttng_notification_channel_get_next_notification(
 	struct lttng_notification *notification = NULL;
 	enum lttng_notification_channel_status status =
 			LTTNG_NOTIFICATION_CHANNEL_STATUS_OK;
-	fd_set read_fds;
+	struct lttng_poll_event events;
 
 	if (!channel || !_notification) {
 		status = LTTNG_NOTIFICATION_CHANNEL_STATUS_INVALID;
@@ -241,9 +240,9 @@ lttng_notification_channel_get_next_notification(
 	}
 
 	/*
-	 * Block on select() instead of the message reception itself as the
-	 * recvmsg() wrappers always restard on EINTR. We choose to wait
-	 * using select() in order to:
+	 * Block on interruptible epoll/poll() instead of the message reception
+	 * itself as the recvmsg() wrappers always restart on EINTR. We choose
+	 * to wait using interruptible epoll/poll() in order to:
 	 *   1) Return if a signal occurs,
 	 *   2) Not deal with partially received messages.
 	 *
@@ -252,20 +251,28 @@ lttng_notification_channel_get_next_notification(
 	 * announced length, receive_message() will block on recvmsg()
 	 * and never return (even if a signal is received).
 	 */
-	FD_ZERO(&read_fds);
-	FD_SET(channel->socket, &read_fds);
-	ret = select(channel->socket + 1, &read_fds, NULL, NULL, NULL);
-	if (ret == -1) {
-		status = errno == EINTR ?
+	ret = lttng_poll_create(&events, 1, LTTNG_CLOEXEC);
+	if (ret < 0) {
+		status = LTTNG_NOTIFICATION_CHANNEL_STATUS_ERROR;
+		goto end_unlock;
+	}
+	ret = lttng_poll_add(&events, channel->socket, LPOLLIN | LPOLLERR);
+	if (ret < 0) {
+		status = LTTNG_NOTIFICATION_CHANNEL_STATUS_ERROR;
+		goto end_clean_poll;
+	}
+	ret = lttng_poll_wait_interruptible(&events, -1);
+	if (ret <= 0) {
+		status = (ret == -1 && errno == EINTR) ?
 			LTTNG_NOTIFICATION_CHANNEL_STATUS_INTERRUPTED :
 			LTTNG_NOTIFICATION_CHANNEL_STATUS_ERROR;
-		goto end_unlock;
+		goto end_clean_poll;
 	}
 
 	ret = receive_message(channel);
 	if (ret) {
 		status = LTTNG_NOTIFICATION_CHANNEL_STATUS_ERROR;
-		goto end_unlock;
+		goto end_clean_poll;
 	}
 
 	switch (get_current_message_type(channel)) {
@@ -274,7 +281,7 @@ lttng_notification_channel_get_next_notification(
 				channel);
 		if (!notification) {
 			status = LTTNG_NOTIFICATION_CHANNEL_STATUS_ERROR;
-			goto end_unlock;
+			goto end_clean_poll;
 		}
 		break;
 	case LTTNG_NOTIFICATION_CHANNEL_MESSAGE_TYPE_NOTIFICATION_DROPPED:
@@ -284,9 +291,11 @@ lttng_notification_channel_get_next_notification(
 	default:
 		/* Protocol error. */
 		status = LTTNG_NOTIFICATION_CHANNEL_STATUS_ERROR;
-		goto end_unlock;
+		goto end_clean_poll;
 	}
 
+end_clean_poll:
+	lttng_poll_clean(&events);
 end_unlock:
 	pthread_mutex_unlock(&channel->lock);
 	*_notification = notification;
@@ -387,11 +396,7 @@ lttng_notification_channel_has_pending_notification(
 	int ret;
 	enum lttng_notification_channel_status status =
 			LTTNG_NOTIFICATION_CHANNEL_STATUS_OK;
-	fd_set read_fds;
-	struct timeval timeout;
-
-	FD_ZERO(&read_fds);
-	memset(&timeout, 0, sizeof(timeout));
+	struct lttng_poll_event events;
 
 	if (!channel || !_notification_pending) {
 		status = LTTNG_NOTIFICATION_CHANNEL_STATUS_INVALID;
@@ -426,48 +431,57 @@ lttng_notification_channel_has_pending_notification(
 	 * message if we see data available on the socket. If the peer does
 	 * not respect the protocol, this may block indefinitely.
 	 */
-	FD_SET(channel->socket, &read_fds);
-	do {
-		ret = select(channel->socket + 1, &read_fds, NULL, NULL, &timeout);
-	} while (ret < 0 && errno == EINTR);
-
+	ret = lttng_poll_create(&events, 1, LTTNG_CLOEXEC);
+	if (ret < 0) {
+		status = LTTNG_NOTIFICATION_CHANNEL_STATUS_ERROR;
+		goto end_unlock;
+	}
+	ret = lttng_poll_add(&events, channel->socket, LPOLLIN | LPOLLERR);
+	if (ret < 0) {
+		status = LTTNG_NOTIFICATION_CHANNEL_STATUS_ERROR;
+		goto end_clean_poll;
+	}
+	/* timeout = 0: return immediately. */
+	ret = lttng_poll_wait_interruptible(&events, 0);
 	if (ret == 0) {
 		/* No data available. */
 		*_notification_pending = false;
-		goto end_unlock;
+		goto end_clean_poll;
 	} else if (ret < 0) {
 		status = LTTNG_NOTIFICATION_CHANNEL_STATUS_ERROR;
-		goto end_unlock;
+		goto end_clean_poll;
 	}
 
 	/* Data available on socket. */
 	ret = receive_message(channel);
 	if (ret) {
 		status = LTTNG_NOTIFICATION_CHANNEL_STATUS_ERROR;
-		goto end_unlock;
+		goto end_clean_poll;
 	}
 
 	switch (get_current_message_type(channel)) {
 	case LTTNG_NOTIFICATION_CHANNEL_MESSAGE_TYPE_NOTIFICATION:
 		ret = enqueue_notification_from_current_message(channel);
 		if (ret) {
-			goto end_unlock;
+			goto end_clean_poll;
 		}
 		*_notification_pending = true;
 		break;
 	case LTTNG_NOTIFICATION_CHANNEL_MESSAGE_TYPE_NOTIFICATION_DROPPED:
 		ret = enqueue_dropped_notification(channel);
 		if (ret) {
-			goto end_unlock;
+			goto end_clean_poll;
 		}
 		*_notification_pending = true;
 		break;
 	default:
 		/* Protocol error. */
 		status = LTTNG_NOTIFICATION_CHANNEL_STATUS_ERROR;
-		goto end_unlock;
+		goto end_clean_poll;
 	}
 
+end_clean_poll:
+	lttng_poll_clean(&events);
 end_unlock:
 	pthread_mutex_unlock(&channel->lock);
 end:
-- 
2.17.1
