From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 3/4] Fix: undefined operation on
	last_relay_viewer_session_id
Date: Tue,  2 Dec 2014 17:21:11 -0500
Message-ID: <1417558872-25339-3-git-send-email-mathieu.desnoyers__1942.37655164233$1417558969$gmane$org@efficios.com>
References: <1417558872-25339-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Xvvp3-0005MM-AL
 for lttng-dev@lists.lttng.org; Tue, 02 Dec 2014 17:21:30 -0500
In-Reply-To: <1417558872-25339-1-git-send-email-mathieu.desnoyers@efficios.com>
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

Triggers compiler warning on 32-bit build.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-relayd/live.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/bin/lttng-relayd/live.c b/src/bin/lttng-relayd/live.c
index 93d458b..a437d1d 100644
--- a/src/bin/lttng-relayd/live.c
+++ b/src/bin/lttng-relayd/live.c
@@ -731,7 +731,12 @@ int viewer_connect(struct relay_connection *conn)
 	reply.major = htobe32(reply.major);
 	reply.minor = htobe32(reply.minor);
 	if (conn->type == RELAY_VIEWER_COMMAND) {
-		reply.viewer_session_id = htobe64(++last_relay_viewer_session_id);
+		/*
+		 * Increment outside of htobe64 macro, because can be used more than once
+		 * within the macro, and thus the operation may be undefined.
+		 */
+		last_relay_viewer_session_id++;
+		reply.viewer_session_id = htobe64(last_relay_viewer_session_id);
 	}
 
 	health_code_update();
-- 
2.1.1
