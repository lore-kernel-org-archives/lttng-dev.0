From: David Goulet <dgoulet@efficios.com>
Subject: [PATCH lttng-tools 1/4] Rename consumer threads and
	spawn them in daemon
Date: Fri, 12 Oct 2012 10:30:32 -0400
Message-ID: <1350052235-12198-1-git-send-email-dgoulet__38194.7423368276$1350052279$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TMgGG-0003Sk-Bb
	for lttng-dev@lists.lttng.org; Fri, 12 Oct 2012 10:30:48 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: David Goulet <dgoulet@efficios.com>
List-Id: lttng-dev@lists.lttng.org

The metadata thread is now created in the lttng-consumerd daemon so all
thread could be controlled inside the daemon.

This is the first step of a consumer thread refactoring which aims at
moving data and metadata stream operations inside a dedicated thread so
the session daemon thread does not block and is more efficient at adding
streams.

The most important concept is that a stream file descriptor MUST be
opened as quickly as we can than passed to the right thread (for UST
since they are already opened by the session daemon for the kernel).

Signed-off-by: David Goulet <dgoulet@efficios.com>
---
 src/bin/lttng-consumerd/lttng-consumerd.c |   18 ++++++++++-----
 src/common/consumer.c                     |   34 +++++++++--------------------
 src/common/consumer.h                     |    5 +++--
 3 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/src/bin/lttng-consumerd/lttng-consumerd.c b/src/bin/lttng-consumerd/lttng-consumerd.c
index 5952334..946fb02 100644
--- a/src/bin/lttng-consumerd/lttng-consumerd.c
+++ b/src/bin/lttng-consumerd/lttng-consumerd.c
@@ -356,23 +356,31 @@ int main(int argc, char **argv)
 	}
 	lttng_consumer_set_error_sock(ctx, ret);
 
-	/* Create the thread to manage the receive of fd */
-	ret = pthread_create(&threads[0], NULL, lttng_consumer_thread_receive_fds,
+	/* Create thread to manage the polling/writing of trace metadata */
+	ret = pthread_create(&threads[0], NULL, consumer_thread_metadata_poll,
+			(void *) ctx);
+	if (ret != 0) {
+		perror("pthread_create");
+		goto error;
+	}
+
+	/* Create thread to manage the polling/writing of trace data */
+	ret = pthread_create(&threads[1], NULL, consumer_thread_data_poll,
 			(void *) ctx);
 	if (ret != 0) {
 		perror("pthread_create");
 		goto error;
 	}
 
-	/* Create thread to manage the polling/writing of traces */
-	ret = pthread_create(&threads[1], NULL, lttng_consumer_thread_poll_fds,
+	/* Create the thread to manage the receive of fd */
+	ret = pthread_create(&threads[2], NULL, consumer_thread_sessiond_poll,
 			(void *) ctx);
 	if (ret != 0) {
 		perror("pthread_create");
 		goto error;
 	}
 
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < 3; i++) {
 		ret = pthread_join(threads[i], &status);
 		if (ret != 0) {
 			perror("pthread_join");
diff --git a/src/common/consumer.c b/src/common/consumer.c
index 242b05b..055de1b 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -1131,6 +1131,8 @@ void lttng_consumer_destroy(struct lttng_consumer_local_data *ctx)
 		PERROR("close");
 	}
 	utils_close_pipe(ctx->consumer_splice_metadata_pipe);
+	/* This should trigger the metadata thread to exit */
+	close(ctx->consumer_metadata_pipe[1]);
 
 	unlink(ctx->consumer_command_sock_path);
 	free(ctx);
@@ -1756,7 +1758,7 @@ error:
  * Thread polls on metadata file descriptor and write them on disk or on the
  * network.
  */
-void *lttng_consumer_thread_poll_metadata(void *data)
+void *consumer_thread_metadata_poll(void *data)
 {
 	int ret, i, pollfd;
 	uint32_t revents, nb_fd;
@@ -1939,7 +1941,7 @@ end:
  * This thread polls the fds in the set to consume the data and write
  * it to tracefile if necessary.
  */
-void *lttng_consumer_thread_poll_fds(void *data)
+void *consumer_thread_data_poll(void *data)
 {
 	int num_rdy, num_hup, high_prio, ret, i;
 	struct pollfd *pollfd = NULL;
@@ -1949,19 +1951,9 @@ void *lttng_consumer_thread_poll_fds(void *data)
 	int nb_fd = 0;
 	struct lttng_consumer_local_data *ctx = data;
 	ssize_t len;
-	pthread_t metadata_thread;
-	void *status;
 
 	rcu_register_thread();
 
-	/* Start metadata polling thread */
-	ret = pthread_create(&metadata_thread, NULL,
-			lttng_consumer_thread_poll_metadata, (void *) ctx);
-	if (ret < 0) {
-		PERROR("pthread_create metadata thread");
-		goto end;
-	}
-
 	local_stream = zmalloc(sizeof(struct lttng_consumer_stream));
 
 	while (1) {
@@ -2145,19 +2137,13 @@ end:
 
 	/*
 	 * Close the write side of the pipe so epoll_wait() in
-	 * lttng_consumer_thread_poll_metadata can catch it. The thread is
-	 * monitoring the read side of the pipe. If we close them both, epoll_wait
-	 * strangely does not return and could create a endless wait period if the
-	 * pipe is the only tracked fd in the poll set. The thread will take care
-	 * of closing the read side.
+	 * consumer_thread_metadata_poll can catch it. The thread is monitoring the
+	 * read side of the pipe. If we close them both, epoll_wait strangely does
+	 * not return and could create a endless wait period if the pipe is the
+	 * only tracked fd in the poll set. The thread will take care of closing
+	 * the read side.
 	 */
 	close(ctx->consumer_metadata_pipe[1]);
-	if (ret) {
-		ret = pthread_join(metadata_thread, &status);
-		if (ret < 0) {
-			PERROR("pthread_join metadata thread");
-		}
-	}
 
 	rcu_unregister_thread();
 	return NULL;
@@ -2167,7 +2153,7 @@ end:
  * This thread listens on the consumerd socket and receives the file
  * descriptors from the session daemon.
  */
-void *lttng_consumer_thread_receive_fds(void *data)
+void *consumer_thread_sessiond_poll(void *data)
 {
 	int sock, client_socket, ret;
 	/*
diff --git a/src/common/consumer.h b/src/common/consumer.h
index d0cd8fd..4b225e4 100644
--- a/src/common/consumer.h
+++ b/src/common/consumer.h
@@ -385,8 +385,9 @@ extern int lttng_consumer_get_produced_snapshot(
 		struct lttng_consumer_local_data *ctx,
 		struct lttng_consumer_stream *stream,
 		unsigned long *pos);
-extern void *lttng_consumer_thread_poll_fds(void *data);
-extern void *lttng_consumer_thread_receive_fds(void *data);
+extern void *consumer_thread_metadata_poll(void *data);
+extern void *consumer_thread_data_poll(void *data);
+extern void *consumer_thread_sessiond_poll(void *data);
 extern int lttng_consumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 		int sock, struct pollfd *consumer_sockpoll);
 
-- 
1.7.10.4
