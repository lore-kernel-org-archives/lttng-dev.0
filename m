From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 2/4 v2] Use empty event name on
	disable -a for ust and agent domain
Date: Mon, 21 Sep 2015 18:43:55 -0400
Message-ID: <1442875437-15639-2-git-send-email-jonathan.rajotte-julien__46193.2254177102$1442875531$gmane$org@efficios.com>
References: <CA+jJMxvMk+jb3nNMv9fk=-REKGT2XC4KtihyDR7xCH7_S86h4w@mail.gmail.com>
 <1442875437-15639-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1Ze9oi-0003cG-8k
 for lttng-dev@lists.lttng.org; Mon, 21 Sep 2015 18:44:20 -0400
In-Reply-To: <1442875437-15639-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/bin/lttng-sessiond/cmd.c                            | 17 +++++++++++------
 .../ust/python-logging/test_python_logging.in           |  2 +-
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
index 0daeb9e..5a1cc7a 100644
--- a/src/bin/lttng-sessiond/cmd.c
+++ b/src/bin/lttng-sessiond/cmd.c
@@ -1280,10 +1280,12 @@ int cmd_disable_event(struct ltt_session *session,
 
 		switch (event->type) {
 		case LTTNG_EVENT_ALL:
-			if (strlen(event->name) == 1 &&
-					!strncmp(event->name, "*", 1)) {
-				ret = event_ust_disable_all_tracepoints(usess,
-						uchan);
+			/*
+			 * An empty event name means that everything
+			 * should be disabled.
+			 */
+			if (event->name[0] == '\0') {
+				ret = event_ust_disable_all_tracepoints(usess, uchan);
 			} else {
 				ret = event_ust_disable_tracepoint(usess, uchan,
 						event_name);
@@ -1323,8 +1325,11 @@ int cmd_disable_event(struct ltt_session *session,
 			ret = -LTTNG_ERR_UST_EVENT_NOT_FOUND;
 			goto error_unlock;
 		}
-		/* The wild card * means that everything should be disabled. */
-		if (strncmp(event->name, "*", 1) == 0 && strlen(event->name) == 1) {
+		/*
+		 * An empty event name means that everything
+		 * should be disabled.
+		 */
+		if (event->name[0] == '\0') {
 			ret = event_agent_disable_all(usess, agt);
 		} else {
 			ret = event_agent_disable(usess, agt, event_name);
diff --git a/tests/regression/ust/python-logging/test_python_logging.in b/tests/regression/ust/python-logging/test_python_logging.in
index 8aff408..d5a9b80 100755
--- a/tests/regression/ust/python-logging/test_python_logging.in
+++ b/tests/regression/ust/python-logging/test_python_logging.in
@@ -351,7 +351,7 @@ function test_python_disable_all()
 	enable_python_lttng_event $SESSION_NAME $EVENT_NAME
 	enable_python_lttng_event $SESSION_NAME $EVENT_NAME2
 
-	disable_python_lttng_event $SESSION_NAME '*'
+	disable_python_lttng_event $SESSION_NAME -a
 
 	start_lttng_tracing_ok $SESSION_NAME
 
-- 
2.1.4
