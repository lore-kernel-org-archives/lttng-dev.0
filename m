From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Fix: relayd
	relay_cmd_pipe/thread_quit_pipe should be closed on exit/error.
Date: Fri, 20 Jul 2012 15:26:47 -0400
Message-ID: <1342812407-5225-1-git-send-email-christian.babeux__8432.03389454192$1342812480$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-gg0-f176.google.com ([209.85.161.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1SsIrO-0000i6-6h
	for lttng-dev@lists.lttng.org; Fri, 20 Jul 2012 15:27:34 -0400
Received: by ggnk4 with SMTP id k4so5164759ggn.35
	for <lttng-dev@lists.lttng.org>; Fri, 20 Jul 2012 12:27:28 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com, jdesfossez@efficios.com, mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Use the utils functions found in common/utils.h on pipes operations
(open/close).

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 src/bin/lttng-relayd/main.c | 57 +++++++++++----------------------------------
 1 file changed, 14 insertions(+), 43 deletions(-)

diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index bdefd16..795a694 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -49,6 +49,7 @@
 #include <common/hashtable/hashtable.h>
 #include <common/sessiond-comm/relayd.h>
 #include <common/uri.h>
+#include <common/utils.h>
 
 #include "lttng-relayd.h"
 
@@ -228,18 +229,13 @@ exit:
 static
 void cleanup(void)
 {
-	int i, ret;
-
 	DBG("Cleaning up");
 
-	for (i = 0; i < 2; i++) {
-		if (thread_quit_pipe[i] >= 0) {
-			ret = close(thread_quit_pipe[i]);
-			if (ret) {
-				PERROR("close");
-			}
-		}
-	}
+	/* Close thread quit pipes */
+	utils_close_pipe(thread_quit_pipe);
+
+	/* Close relay cmd pipes */
+	utils_close_pipe(relay_cmd_pipe);
 }
 
 /*
@@ -351,23 +347,10 @@ int set_signal_handler(void)
 static
 int init_thread_quit_pipe(void)
 {
-	int ret, i;
-
-	ret = pipe(thread_quit_pipe);
-	if (ret < 0) {
-		PERROR("thread quit pipe");
-		goto error;
-	}
+	int ret;
 
-	for (i = 0; i < 2; i++) {
-		ret = fcntl(thread_quit_pipe[i], F_SETFD, FD_CLOEXEC);
-		if (ret < 0) {
-			PERROR("fcntl");
-			goto error;
-		}
-	}
+	ret = utils_create_pipe_cloexec(thread_quit_pipe);
 
-error:
 	return ret;
 }
 
@@ -1444,23 +1427,10 @@ error_poll_create:
  */
 static int create_relay_cmd_pipe(void)
 {
-	int ret, i;
-
-	ret = pipe(relay_cmd_pipe);
-	if (ret < 0) {
-		PERROR("relay cmd pipe");
-		goto error;
-	}
+	int ret;
 
-	for (i = 0; i < 2; i++) {
-		ret = fcntl(relay_cmd_pipe[i], F_SETFD, FD_CLOEXEC);
-		if (ret < 0) {
-			PERROR("fcntl relay_cmd_pipe");
-			goto error;
-		}
-	}
+	ret = utils_create_pipe_cloexec(relay_cmd_pipe);
 
-error:
 	return ret;
 }
 
@@ -1480,7 +1450,7 @@ int main(int argc, char **argv)
 	/* Parse arguments */
 	progname = argv[0];
 	if ((ret = parse_args(argc, argv) < 0)) {
-		goto error;
+		goto exit;
 	}
 
 	if ((ret = set_signal_handler()) < 0) {
@@ -1492,7 +1462,7 @@ int main(int argc, char **argv)
 		ret = daemon(0, 0);
 		if (ret < 0) {
 			PERROR("daemon");
-			goto error;
+			goto exit;
 		}
 	}
 
@@ -1503,7 +1473,7 @@ int main(int argc, char **argv)
 		if (control_uri->port < 1024 || data_uri->port < 1024) {
 			ERR("Need to be root to use ports < 1024");
 			ret = -1;
-			goto error;
+			goto exit;
 		}
 	}
 
@@ -1568,6 +1538,7 @@ exit:
 	if (!ret) {
 		exit(EXIT_SUCCESS);
 	}
+
 error:
 	exit(EXIT_FAILURE);
 }
-- 
1.7.11.2
