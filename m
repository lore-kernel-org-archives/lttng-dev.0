From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 9/9] sessiond: use epoll()/poll()
 instead of select()
Date: Fri,  3 May 2019 09:55:47 -0400
Message-ID: <20190503135547.12968-10-mathieu.desnoyers__31101.11144358$1556911604$gmane$org@efficios.com>
References: <20190503135547.12968-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44wYZ73vfhz1KYx
 for <lttng-dev@lists.lttng.org>; Fri,  3 May 2019 09:55:59 -0400 (EDT)
In-Reply-To: <20190503135547.12968-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com, joraj@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The select(2) system call is an ancient ABI limited to processes
containing at most FD_SETSIZE file descriptors overall (typically
1024).

This select call will fail if the target file descriptor is above
FD_SETSIZE in a session daemon containing many file descriptors.
This is unlikely to happen in normal use given than
sessiond_init_thread_quit_pipe() is called early by main(). Odd
scenarios could trigger this, for instance if the parent process leaves
a large number of file descriptors open, or if a library which
allocates file descriptors is LD_PRELOADed with the sessiond.

Never use select, use the lttng epoll/poll wrapper instead.

This patch depends on "Change lttng_poll_wait behaviour of compat-poll
to match compat-epoll" posted by Yannick Lamarre.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Yannick Lamarre <ylamarre@efficios.com>
---
 src/bin/lttng-sessiond/lttng-sessiond.h |  2 +-
 src/bin/lttng-sessiond/main.c           |  2 +-
 src/bin/lttng-sessiond/thread-utils.c   | 39 ++++++++++++++-------------------
 3 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/src/bin/lttng-sessiond/lttng-sessiond.h b/src/bin/lttng-sessiond/lttng-sessiond.h
index d321fced..6810e896 100644
--- a/src/bin/lttng-sessiond/lttng-sessiond.h
+++ b/src/bin/lttng-sessiond/lttng-sessiond.h
@@ -161,7 +161,7 @@ extern struct consumer_data kconsumer_data;
 
 int sessiond_init_thread_quit_pipe(void);
 int sessiond_check_thread_quit_pipe(int fd, uint32_t events);
-int sessiond_wait_for_quit_pipe(unsigned int timeout_us);
+int sessiond_wait_for_quit_pipe(int timeout_ms);
 int sessiond_notify_quit_pipe(void);
 void sessiond_close_quit_pipe(void);
 
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index 57324820..a6719a4d 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -1833,7 +1833,7 @@ int main(int argc, char **argv)
 	 */
 
 	/* Initiate teardown once activity occurs on the quit pipe. */
-	sessiond_wait_for_quit_pipe(-1U);
+	sessiond_wait_for_quit_pipe(-1);
 
 stop_threads:
 	/*
diff --git a/src/bin/lttng-sessiond/thread-utils.c b/src/bin/lttng-sessiond/thread-utils.c
index 16ae9d69..e1c02290 100644
--- a/src/bin/lttng-sessiond/thread-utils.c
+++ b/src/bin/lttng-sessiond/thread-utils.c
@@ -73,41 +73,36 @@ int sessiond_check_thread_quit_pipe(int fd, uint32_t events)
  * Returns 1 if the caller should quit, 0 if the timeout was reached, and
  * -1 if an error was encountered.
  */
-int sessiond_wait_for_quit_pipe(unsigned int timeout_us)
+int sessiond_wait_for_quit_pipe(int timeout_ms)
 {
 	int ret;
-	fd_set read_fds;
-	struct timeval timeout;
-
-	FD_ZERO(&read_fds);
-	FD_SET(thread_quit_pipe[0], &read_fds);
-	memset(&timeout, 0, sizeof(timeout));
-	timeout.tv_sec = timeout_us / USEC_PER_SEC;
-	timeout.tv_usec = timeout_us % USEC_PER_SEC;
-
-	while (true) {
-		ret = select(thread_quit_pipe[0] + 1, &read_fds, NULL, NULL,
-				timeout_us != -1U ? &timeout : NULL);
-		if (ret < 0 && errno == EINTR) {
-			/* Retry on interrupt. */
-			continue;
-		} else {
-			break;
-		}
-	}
+	struct lttng_poll_event events;
 
+	ret = lttng_poll_create(&events, 1, LTTNG_CLOEXEC);
+	if (ret < 0) {
+		PERROR("Failure in lttng_poll_create");
+		return -1;
+	}
+	ret = lttng_poll_add(&events, thread_quit_pipe[0], LPOLLIN | LPOLLERR);
+	if (ret < 0) {
+		PERROR("Failure in lttng_poll_add");
+		ret = -1;
+		goto end;
+	}
+	ret = lttng_poll_wait(&events, timeout_ms);
 	if (ret > 0) {
 		/* Should quit. */
 		ret = 1;
 	} else if (ret < 0 && errno != EINTR) {
 		/* Unknown error. */
-		PERROR("Failed to select() thread quit pipe");
+		PERROR("Failed to epoll()/poll() thread quit pipe");
 		ret = -1;
 	} else {
 		/* Timeout reached. */
 		ret = 0;
 	}
-
+end:
+	lttng_poll_clean(&events);
 	return ret;
 }
 
-- 
2.11.0
