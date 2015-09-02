From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: kernel track/untrack error
	handling
Date: Wed,  2 Sep 2015 10:45:07 -0400
Message-ID: <1441205107-28934-1-git-send-email-mathieu.desnoyers__14559.1885121123$1441205213$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZX9Hs-00054X-E2
 for lttng-dev@lists.lttng.org; Wed, 02 Sep 2015 10:45:29 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Fixes: #918

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/kernel.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/src/bin/lttng-sessiond/kernel.c b/src/bin/lttng-sessiond/kernel.c
index 570747f..381b83e 100644
--- a/src/bin/lttng-sessiond/kernel.c
+++ b/src/bin/lttng-sessiond/kernel.c
@@ -379,16 +379,46 @@ error:
 
 int kernel_track_pid(struct ltt_kernel_session *session, int pid)
 {
+	int ret;
+
 	DBG("Kernel track PID %d for session id %" PRIu64 ".",
 			pid, session->id);
-	return kernctl_track_pid(session->fd, pid);
+	ret = kernctl_track_pid(session->fd, pid);
+	if (!ret) {
+		return LTTNG_OK;
+	}
+	switch (errno) {
+	case EINVAL:
+		return LTTNG_ERR_INVALID;
+	case ENOMEM:
+		return LTTNG_ERR_NOMEM;
+	case EEXIST:
+		return LTTNG_ERR_PID_TRACKED;
+	default:
+		return LTTNG_ERR_UNK;
+	}
 }
 
 int kernel_untrack_pid(struct ltt_kernel_session *session, int pid)
 {
+	int ret;
+
 	DBG("Kernel untrack PID %d for session id %" PRIu64 ".",
 			pid, session->id);
-	return kernctl_untrack_pid(session->fd, pid);
+	ret = kernctl_untrack_pid(session->fd, pid);
+	if (!ret) {
+		return LTTNG_OK;
+	}
+	switch (errno) {
+	case EINVAL:
+		return LTTNG_ERR_INVALID;
+	case ENOMEM:
+		return LTTNG_ERR_NOMEM;
+	case ENOENT:
+		return LTTNG_ERR_PID_NOT_TRACKED;
+	default:
+		return LTTNG_ERR_UNK;
+	}
 }
 
 ssize_t kernel_list_tracker_pids(struct ltt_kernel_session *session,
-- 
2.1.4
