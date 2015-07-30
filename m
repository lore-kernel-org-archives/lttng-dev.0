From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH v2 2/2] Test the viewer detach
	command
Date: Thu, 30 Jul 2015 11:52:34 -0400
Message-ID: <1438271554-30895-2-git-send-email-jdesfossez__35759.1219748885$1438271642$gmane$org@efficios.com>
References: <1438271554-30895-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZKq8V-0005PY-Dx
 for lttng-dev@lists.lttng.org; Thu, 30 Jul 2015 11:52:55 -0400
In-Reply-To: <1438271554-30895-1-git-send-email-jdesfossez@efficios.com>
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
 tests/regression/tools/live/live_test.c | 58 ++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/tests/regression/tools/live/live_test.c b/tests/regression/tools/live/live_test.c
index b447733..31231f0 100644
--- a/tests/regression/tools/live/live_test.c
+++ b/tests/regression/tools/live/live_test.c
@@ -50,7 +50,7 @@
 #define LIVE_TIMER 2000000
 
 /* Number of TAP tests in this file */
-#define NUM_TESTS 8
+#define NUM_TESTS 11
 #define mmap_size 524288
 
 int ust_consumerd32_fd;
@@ -282,6 +282,53 @@ error:
 	return -1;
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
+	ret_len = lttng_live_send(control_sock, &cmd, sizeof(cmd));
+	if (ret_len < 0) {
+		fprintf(stderr, "[error] Error sending cmd\n");
+		ret = ret_len;
+		goto error;
+	}
+
+	ret_len = lttng_live_send(control_sock, &rq, sizeof(rq));
+	if (ret_len < 0) {
+		fprintf(stderr, "Error sending attach request\n");
+		ret = ret_len;
+		goto error;
+	}
+
+	ret_len = lttng_live_recv(control_sock, &resp, sizeof(resp));
+	if (ret_len < 0) {
+		fprintf(stderr, "[error] Error receiving detach session reply\n");
+		ret = ret_len;
+		goto error;
+	}
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
@@ -656,5 +703,14 @@ int main(int argc, char **argv)
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
