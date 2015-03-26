From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH 1/2] Command to detach a live viewer
	session
Date: Thu, 26 Mar 2015 12:57:51 -0400
Message-ID: <1427389072-3763-1-git-send-email-jdesfossez__28368.8070987866$1427389177$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1YbB6Y-0005Fk-Kn
 for lttng-dev@lists.lttng.org; Thu, 26 Mar 2015 12:58:10 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

The LTTNG_VIEWER_DETACH_SESSION command allows the viewer to detach from
the session it is currently attached to without requiring it to close
the network connection. This allows the relayd to release its reference
on the session and eventually clear it if it is destroyed on the
consumer.

Fixes: #853

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 src/bin/lttng-relayd/live.c             | 73 +++++++++++++++++++++++++++++++++
 src/bin/lttng-relayd/lttng-viewer-abi.h | 18 ++++++++
 2 files changed, 91 insertions(+)

diff --git a/src/bin/lttng-relayd/live.c b/src/bin/lttng-relayd/live.c
index 562a7fa..221ec43 100644
--- a/src/bin/lttng-relayd/live.c
+++ b/src/bin/lttng-relayd/live.c
@@ -1733,6 +1733,76 @@ end:
 	return ret;
 }
 
+/*
+ * Detach a viewer session.
+ *
+ * Return 0 on success or else a negative value.
+ */
+static
+int viewer_detach_session(struct relay_connection *conn)
+{
+	int ret, found;
+	struct lttng_viewer_detach_session_response resp;
+	struct lttng_viewer_detach_session_request request;
+	struct relay_session *session, *tmp_session;
+	uint64_t to_close;
+
+	DBG("Viewer detach session received");
+
+	assert(conn);
+
+	health_code_update();
+
+	/* Receive the request from the connected client. */
+	ret = recv_request(conn->sock, &request, sizeof(request));
+	if (ret < 0) {
+		goto end;
+	}
+	to_close = be64toh(request.session_id);
+
+	if (!conn->viewer_session) {
+		resp.status = htobe32(LTTNG_VIEWER_DETACH_SESSION_ERR);
+		goto send_reply;
+	}
+
+	health_code_update();
+
+	memset(&resp, 0, sizeof(resp));
+	DBG("Cleaning connection of session ID %" PRIu64, to_close);
+
+	found = 0;
+	rcu_read_lock();
+	cds_list_for_each_entry_safe(session, tmp_session,
+			&conn->viewer_session->sessions_head,
+			viewer_session_list) {
+		if (session->id == to_close) {
+			DBG("Cleaning connection of session ID %" PRIu64, session->id);
+			cleanup_session(conn, session);
+			found = 1;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	if (!found) {
+		resp.status = htobe32(LTTNG_VIEWER_DETACH_SESSION_ERR);
+	} else {
+		resp.status = htobe32(LTTNG_VIEWER_DETACH_SESSION_OK);
+	}
+
+send_reply:
+	health_code_update();
+	ret = send_response(conn->sock, &resp, sizeof(resp));
+	if (ret < 0) {
+		goto end;
+	}
+	health_code_update();
+	ret = 0;
+
+end:
+	return ret;
+}
+
 
 /*
  * live_relay_unknown_command: send -1 if received unknown command
@@ -1797,6 +1867,9 @@ int process_control(struct lttng_viewer_cmd *recv_hdr,
 	case LTTNG_VIEWER_CREATE_SESSION:
 		ret = viewer_create_session(conn);
 		break;
+	case LTTNG_VIEWER_DETACH_SESSION:
+		ret = viewer_detach_session(conn);
+		break;
 	default:
 		ERR("Received unknown viewer command (%u)", be32toh(recv_hdr->cmd));
 		live_relay_unknown_command(conn);
diff --git a/src/bin/lttng-relayd/lttng-viewer-abi.h b/src/bin/lttng-relayd/lttng-viewer-abi.h
index f9bce98..9b4bc1a 100644
--- a/src/bin/lttng-relayd/lttng-viewer-abi.h
+++ b/src/bin/lttng-relayd/lttng-viewer-abi.h
@@ -48,6 +48,7 @@ enum lttng_viewer_command {
 	LTTNG_VIEWER_GET_METADATA	= 6,
 	LTTNG_VIEWER_GET_NEW_STREAMS	= 7,
 	LTTNG_VIEWER_CREATE_SESSION	= 8,
+	LTTNG_VIEWER_DETACH_SESSION	= 9,
 };
 
 enum lttng_viewer_attach_return_code {
@@ -105,6 +106,11 @@ enum lttng_viewer_create_session_return_code {
 	LTTNG_VIEWER_CREATE_SESSION_ERR		= 2,
 };
 
+enum lttng_viewer_detach_session_return_code {
+	LTTNG_VIEWER_DETACH_SESSION_OK		= 1,
+	LTTNG_VIEWER_DETACH_SESSION_ERR		= 2,
+};
+
 struct lttng_viewer_session {
 	uint64_t id;
 	uint32_t live_timer;
@@ -232,4 +238,16 @@ struct lttng_viewer_create_session_response {
 	uint32_t status;
 } __attribute__((__packed__));
 
+/*
+ * LTTNG_VIEWER_DETACH_SESSION payload.
+ */
+struct lttng_viewer_detach_session_request {
+	uint64_t session_id;
+} __attribute__((__packed__));
+
+struct lttng_viewer_detach_session_response {
+	/* enum lttng_viewer_detach_session_return_code */
+	uint32_t status;
+} __attribute__((__packed__));
+
 #endif /* LTTNG_VIEWER_ABI_H */
-- 
1.9.1
