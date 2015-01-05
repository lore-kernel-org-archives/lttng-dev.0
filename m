From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 4/6] Fix: call
	lttng_poll_set_max_size before start threads
Date: Mon,  5 Jan 2015 16:43:06 -0500
Message-ID: <1420494188-20782-4-git-send-email-mathieu.desnoyers__9296.36503938145$1420494329$gmane$org@efficios.com>
References: <1420494188-20782-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Y8FQq-0005cJ-M5
 for lttng-dev@lists.lttng.org; Mon, 05 Jan 2015 16:43:25 -0500
In-Reply-To: <1420494188-20782-1-git-send-email-mathieu.desnoyers@efficios.com>
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

This changes the location of lttng_poll_set_max_size() call within
sessiond main() to call it before creating the ht_cleanup thread. This
fix is only needed on top of the main refactoring patch.

This fix also adds checks for lttng_poll_set_max_size() error values.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-consumerd/lttng-consumerd.c |  5 ++++-
 src/bin/lttng-relayd/live.c               |  5 ++++-
 src/bin/lttng-relayd/main.c               |  5 ++++-
 src/bin/lttng-sessiond/main.c             | 10 +++++++---
 4 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/src/bin/lttng-consumerd/lttng-consumerd.c b/src/bin/lttng-consumerd/lttng-consumerd.c
index b43e8f1..7122d06 100644
--- a/src/bin/lttng-consumerd/lttng-consumerd.c
+++ b/src/bin/lttng-consumerd/lttng-consumerd.c
@@ -346,7 +346,10 @@ int main(int argc, char **argv)
 	}
 
 	/* Set up max poll set size */
-	lttng_poll_set_max_size();
+	if (lttng_poll_set_max_size()) {
+		retval = -1;
+		goto exit_init_data;
+	}
 
 	if (*command_sock_path == '\0') {
 		switch (opt_type) {
diff --git a/src/bin/lttng-relayd/live.c b/src/bin/lttng-relayd/live.c
index 756efbe..3728005 100644
--- a/src/bin/lttng-relayd/live.c
+++ b/src/bin/lttng-relayd/live.c
@@ -2102,7 +2102,10 @@ int relayd_live_create(struct lttng_uri *uri,
 	cds_wfcq_init(&viewer_conn_queue.head, &viewer_conn_queue.tail);
 
 	/* Set up max poll set size */
-	lttng_poll_set_max_size();
+	if (lttng_poll_set_max_size()) {
+		retval = -1;
+		goto exit_init_data;
+	}
 
 	/* Setup the dispatcher thread */
 	ret = pthread_create(&live_dispatcher_thread, NULL,
diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index 94bb4cb..d09b0c6 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -2850,7 +2850,10 @@ int main(int argc, char **argv)
 	cds_wfcq_init(&relay_conn_queue.head, &relay_conn_queue.tail);
 
 	/* Set up max poll set size */
-	lttng_poll_set_max_size();
+	if (lttng_poll_set_max_size()) {
+		retval = -1;
+		goto exit_init_data;
+	}
 
 	/* Initialize communication library */
 	lttcomm_init();
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index 2649b55..6bc7b1e 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -5205,6 +5205,12 @@ int main(int argc, char **argv)
 		goto exit_ht_cleanup_pipe;
 	}
 
+	/* Set up max poll set size */
+	if (lttng_poll_set_max_size()) {
+		retval = -1;
+		goto exit_set_max_size;
+	}
+
 	/* Create thread to clean up RCU hash tables */
 	ret = pthread_create(&ht_cleanup_thread, NULL,
 			thread_ht_cleanup, (void *) NULL);
@@ -5539,9 +5545,6 @@ int main(int argc, char **argv)
 	 */
 	session_list_ptr = session_get_list();
 
-	/* Set up max poll set size */
-	lttng_poll_set_max_size();
-
 	cmd_init();
 
 	/* Check for the application socket timeout env variable. */
@@ -5771,6 +5774,7 @@ exit_init_data:
 		retval = -1;
 	}
 exit_ht_cleanup:
+exit_set_max_size:
 
 	utils_close_pipe(ht_cleanup_pipe);
 exit_ht_cleanup_pipe:
-- 
2.1.1
