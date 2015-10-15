From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH lttng-tools] Relay protocol: check string
	lengths
Date: Thu, 15 Oct 2015 16:47:14 -0400
Message-ID: <1444942034-31928-1-git-send-email-mathieu.desnoyers__35890.2181651958$1444942101$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZmpQt-00063J-1P
 for lttng-dev@lists.lttng.org; Thu, 15 Oct 2015 16:47:28 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com, mjeanson@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Ensure that string lengths are not longer than what the protocol
supports on both send and receive. Ensure that path lengths fit in the
local filename length limits on the receive side. Ensure that strings
exchanged in the relay protocol are zero-terminated.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-relayd/cmd-2-1.c | 17 +++++++++++++++--
 src/bin/lttng-relayd/cmd-2-2.c | 17 +++++++++++++++--
 src/bin/lttng-relayd/cmd-2-4.c | 16 +++++++++++++++-
 src/common/relayd/relayd.c     | 24 ++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/src/bin/lttng-relayd/cmd-2-1.c b/src/bin/lttng-relayd/cmd-2-1.c
index 958a2e0..dfea5c3 100644
--- a/src/bin/lttng-relayd/cmd-2-1.c
+++ b/src/bin/lttng-relayd/cmd-2-1.c
@@ -38,6 +38,7 @@ int cmd_recv_stream_2_1(struct relay_connection *conn,
 	struct lttcomm_relayd_add_stream stream_info;
 	char *path_name = NULL;
 	char *channel_name = NULL;
+	size_t len;
 
 	ret = cmd_recv(conn->sock, &stream_info, sizeof(stream_info));
 	if (ret < 0) {
@@ -45,17 +46,29 @@ int cmd_recv_stream_2_1(struct relay_connection *conn,
 		goto error;
 	}
 
+	len = strnlen(stream_info.pathname, sizeof(stream_info.pathname));
+	/* Ensure that NULL-terminated and fits in local filename length. */
+	if (len == sizeof(stream_info.pathname) || len >= NAME_MAX) {
+		ret = -ENAMETOOLONG;
+		ERR("Path name too long");
+		goto error;
+	}
 	path_name = create_output_path(stream_info.pathname);
 	if (!path_name) {
 		PERROR("Path name allocation");
 		ret = -ENOMEM;
 		goto error;
 	}
-
+	len = strnlen(stream_info.channel_name, sizeof(stream_info.channel_name));
+	if (len == sizeof(stream_info.channel_name) || len >= DEFAULT_STREAM_NAME_LEN) {
+		ret = -ENAMETOOLONG;
+		ERR("Channel name too long");
+		goto error;
+	}
 	channel_name = strdup(stream_info.channel_name);
 	if (!channel_name) {
 		ret = -errno;
-		PERROR("Path name allocation");
+		PERROR("Channel name allocation");
 		goto error;
 	}
 
diff --git a/src/bin/lttng-relayd/cmd-2-2.c b/src/bin/lttng-relayd/cmd-2-2.c
index efe681e..d52a7f1 100644
--- a/src/bin/lttng-relayd/cmd-2-2.c
+++ b/src/bin/lttng-relayd/cmd-2-2.c
@@ -41,6 +41,7 @@ int cmd_recv_stream_2_2(struct relay_connection *conn,
 	struct lttcomm_relayd_add_stream_2_2 stream_info;
 	char *path_name = NULL;
 	char *channel_name = NULL;
+	size_t len;
 
 	ret = cmd_recv(conn->sock, &stream_info, sizeof(stream_info));
 	if (ret < 0) {
@@ -48,17 +49,29 @@ int cmd_recv_stream_2_2(struct relay_connection *conn,
 		goto error;
 	}
 
+	len = strnlen(stream_info.pathname, sizeof(stream_info.pathname));
+	/* Ensure that NULL-terminated and fits in local filename length. */
+	if (len == sizeof(stream_info.pathname) || len >= NAME_MAX) {
+		ret = -ENAMETOOLONG;
+		ERR("Path name too long");
+		goto error;
+	}
 	path_name = create_output_path(stream_info.pathname);
 	if (!path_name) {
 		PERROR("Path name allocation");
 		ret = -ENOMEM;
 		goto error;
 	}
-
+	len = strnlen(stream_info.channel_name, sizeof(stream_info.channel_name));
+	if (len == sizeof(stream_info.channel_name) || len >= DEFAULT_STREAM_NAME_LEN) {
+		ret = -ENAMETOOLONG;
+		ERR("Channel name too long");
+		goto error;
+	}
 	channel_name = strdup(stream_info.channel_name);
 	if (!channel_name) {
 		ret = -errno;
-		PERROR("Path name allocation");
+		PERROR("Channel name allocation");
 		goto error;
 	}
 
diff --git a/src/bin/lttng-relayd/cmd-2-4.c b/src/bin/lttng-relayd/cmd-2-4.c
index 438de5d..720eb77 100644
--- a/src/bin/lttng-relayd/cmd-2-4.c
+++ b/src/bin/lttng-relayd/cmd-2-4.c
@@ -35,15 +35,29 @@ int cmd_create_session_2_4(struct relay_connection *conn,
 {
 	int ret;
 	struct lttcomm_relayd_create_session_2_4 session_info;
+	size_t len;
 
 	ret = cmd_recv(conn->sock, &session_info, sizeof(session_info));
 	if (ret < 0) {
 		LTTNG_ERR("Unable to recv session info version 2.4");
 		goto error;
 	}
-
+	len = strnlen(session_info.session_name, sizeof(session_info.session_name));
+	/* Ensure that NULL-terminated and fits in local filename length. */
+	if (len == sizeof(session_info.session_name) || len >= NAME_MAX) {
+		ret = -ENAMETOOLONG;
+		ERR("Session name too long");
+		goto error;
+	}
 	strncpy(session_name, session_info.session_name,
 			sizeof(session_info.session_name));
+
+	len = strnlen(session_info.hostname, sizeof(session_info.hostname));
+	if (len == sizeof(session_info.hostname) || len >= LTTNG_HOST_NAME_MAX) {
+		ret = -ENAMETOOLONG;
+		ERR("Session name too long");
+		goto error;
+	}
 	strncpy(hostname, session_info.hostname,
 			sizeof(session_info.hostname));
 	*live_timer = be32toh(session_info.live_timer);
diff --git a/src/common/relayd/relayd.c b/src/common/relayd/relayd.c
index 4b94a2c..f71c6ac 100644
--- a/src/common/relayd/relayd.c
+++ b/src/common/relayd/relayd.c
@@ -129,7 +129,15 @@ static int relayd_create_session_2_4(struct lttcomm_relayd_sock *rsock,
 	int ret;
 	struct lttcomm_relayd_create_session_2_4 msg;
 
+	if (strlen(session_name) >= sizeof(msg.session_name)) {
+		ret = -1;
+		goto error;
+	}
 	strncpy(msg.session_name, session_name, sizeof(msg.session_name));
+	if (strlen(hostname) >= sizeof(msg.hostname)) {
+		ret = -1;
+		goto error;
+	}
 	strncpy(msg.hostname, hostname, sizeof(msg.hostname));
 	msg.live_timer = htobe32(session_live_timer);
 	msg.snapshot = htobe32(snapshot);
@@ -247,7 +255,15 @@ int relayd_add_stream(struct lttcomm_relayd_sock *rsock, const char *channel_nam
 	/* Compat with relayd 2.1 */
 	if (rsock->minor == 1) {
 		memset(&msg, 0, sizeof(msg));
+		if (strlen(channel_name) >= sizeof(msg.channel_name)) {
+			ret = -1;
+			goto error;
+		}
 		strncpy(msg.channel_name, channel_name, sizeof(msg.channel_name));
+		if (strlen(pathname) >= sizeof(msg.pathname)) {
+			ret = -1;
+			goto error;
+		}
 		strncpy(msg.pathname, pathname, sizeof(msg.pathname));
 
 		/* Send command */
@@ -258,7 +274,15 @@ int relayd_add_stream(struct lttcomm_relayd_sock *rsock, const char *channel_nam
 	} else {
 		memset(&msg_2_2, 0, sizeof(msg_2_2));
 		/* Compat with relayd 2.2+ */
+		if (strlen(channel_name) >= sizeof(msg_2_2.channel_name)) {
+			ret = -1;
+			goto error;
+		}
 		strncpy(msg_2_2.channel_name, channel_name, sizeof(msg_2_2.channel_name));
+		if (strlen(pathname) >= sizeof(msg_2_2.pathname)) {
+			ret = -1;
+			goto error;
+		}
 		strncpy(msg_2_2.pathname, pathname, sizeof(msg_2_2.pathname));
 		msg_2_2.tracefile_size = htobe64(tracefile_size);
 		msg_2_2.tracefile_count = htobe64(tracefile_count);
-- 
2.1.4
