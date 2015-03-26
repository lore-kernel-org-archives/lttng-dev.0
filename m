From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH 2/2] Test the viewer detach command
Date: Thu, 26 Mar 2015 12:57:52 -0400
Message-ID: <1427389072-3763-2-git-send-email-jdesfossez__37696.5064825073$1427389202$gmane$org@efficios.com>
References: <1427389072-3763-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1YbB6Y-0005Fl-SB
 for lttng-dev@lists.lttng.org; Thu, 26 Mar 2015 12:58:10 -0400
In-Reply-To: <1427389072-3763-1-git-send-email-jdesfossez@efficios.com>
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

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 tests/regression/tools/live/live_test.c | 64 ++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/tests/regression/tools/live/live_test.c b/tests/regression/tools/live/live_test.c
index e30c391..8d718f6 100644
--- a/tests/regression/tools/live/live_test.c
+++ b/tests/regression/tools/live/live_test.c
@@ -50,7 +50,7 @@
 #define LIVE_TIMER 2000000
 
 /* Number of TAP tests in this file */
-#define NUM_TESTS 8
+#define NUM_TESTS 11
 #define mmap_size 524288
 
 int ust_consumerd32_fd;
@@ -257,6 +257,59 @@ error:
 	return ret;
 }
 
+int detach_viewer_session(uint64_t id)
+{
+	struct lttng_viewer_cmd cmd;
+	struct lttng_viewer_detach_session_response resp;
+	struct lttng_viewer_detach_session_request rq;
+	int ret;
+	ssize_t ret_len;
+
+	cmd.cmd = htobe32(LTTNG_VIEWER_DETACH_SESSION);
+	cmd.data_size = sizeof(rq);
+	cmd.cmd_version = 0;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.session_id = htobe64(id);
+
+	do {
+		ret_len = send(control_sock, &cmd, sizeof(cmd), 0);
+	} while (ret_len < 0 && errno == EINTR);
+	if (ret_len < 0) {
+		fprintf(stderr, "[error] Error sending cmd\n");
+		ret = ret_len;
+		goto error;
+	}
+	assert(ret_len == sizeof(cmd));
+	do {
+		ret = send(control_sock, &rq, sizeof(rq), 0);
+	} while (ret < 0 && errno == EINTR);
+	if (ret < 0) {
+		fprintf(stderr, "Error sending attach request\n");
+		goto error;
+	}
+
+	do {
+		ret_len = recv(control_sock, &resp, sizeof(resp), 0);
+	} while (ret_len < 0 && errno == EINTR);
+	if (ret_len < 0) {
+		fprintf(stderr, "[error] Error receiving detach session reply\n");
+		ret = ret_len;
+		goto error;
+	}
+	assert(ret_len == sizeof(resp));
+
+	if (be32toh(resp.status) != LTTNG_VIEWER_DETACH_SESSION_OK) {
+		fprintf(stderr, "[error] Error detaching viewer session\n");
+		ret = -1;
+		goto error;
+	}
+	ret = 0;
+
+error:
+	return ret;
+}
+
 int attach_session(int id)
 {
 	struct lttng_viewer_cmd cmd;
@@ -643,5 +696,14 @@ int main(int argc, char **argv)
 			first_packet_stream_id, first_packet_offset,
 			first_packet_len);
 
+	ret = detach_viewer_session(session_id);
+	ok(ret == 0, "Detach viewer session");
+
+	ret = list_sessions(&session_id);
+	ok(ret > 0, "List sessions : %d session(s)", ret);
+
+	ret = attach_session(session_id);
+	ok(ret > 0, "Attach to session, %d streams received", ret);
+
 	return exit_status();
 }
-- 
1.9.1
