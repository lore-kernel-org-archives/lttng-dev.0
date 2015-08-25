From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: race between kconsumerd and
	sessiond on tear down
Date: Tue, 25 Aug 2015 18:06:28 -0400
Message-ID: <1440540388-2721-1-git-send-email-jonathan.rajotte-julien__3928.05826054445$1440540462$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZUMMb-0000t1-2z
 for lttng-dev@lists.lttng.org; Tue, 25 Aug 2015 18:06:42 -0400
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

Kconsumerd and sessiond both have reference on lttng-module. This can lead to a race
on modprobe_remove_lttng_all which might fail to unload modules due to
certain modules not having a ref count equal to zero at the time.

waitpid is used to force a synchronization on the child (kconsumer) termination.

This also have been applied to ust consumers for the sake of consistency.

Fixes: #878

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/bin/lttng-sessiond/main.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index d284deb..efb00c7 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -587,6 +587,28 @@ static int generate_lock_file_path(char *path, size_t len)
 }
 
 /*
+ * Wait on consumer process termination
+ */
+static void wait_consumer(struct consumer_data *consumer_data)
+{
+	pid_t ret;
+	int status;
+	if (consumer_data->pid > 0) {
+		DBG("Waiting for complete teardown of consumerd (PID:%d)",
+				consumer_data->pid);
+		ret = waitpid(consumer_data->pid, &status, 0);
+		if (ret == -1) {
+			PERROR("consumerd waitpid pid:%d", consumer_data->pid)
+		}
+		if (!WIFEXITED(status)) {
+			PERROR("consumerd termination with error:%d",
+					WEXITSTATUS(ret));
+		}
+		consumer_data->pid = 0;
+	}
+}
+
+/*
  * Cleanup the session daemon's data structures.
  */
 static void sessiond_cleanup(void)
@@ -680,6 +702,11 @@ static void sessiond_cleanup(void)
 		}
 	}
 
+	wait_consumer(&kconsumer_data);
+	wait_consumer(&ustconsumer64_data);
+	wait_consumer(&ustconsumer32_data);
+
+
 	DBG("Cleaning up all agent apps");
 	agent_app_ht_clean();
 
@@ -1497,7 +1524,6 @@ error:
 
 	unlink(consumer_data->err_unix_sock_path);
 	unlink(consumer_data->cmd_unix_sock_path);
-	consumer_data->pid = 0;
 	pthread_mutex_unlock(&consumer_data->lock);
 
 	/* Cleanup metadata socket mutex. */
-- 
2.1.4
