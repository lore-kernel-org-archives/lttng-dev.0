From: David Goulet <dgoulet@efficios.com>
Subject: [PATCH lttng-tools] Fix: Change sempahore to pthread
	conditions
Date: Mon, 24 Sep 2012 11:33:47 -0400
Message-ID: <1348500827-8921-1-git-send-email-dgoulet__15678.5996434794$1348500881$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TGAfW-0002hY-LN
	for lttng-dev@lists.lttng.org; Mon, 24 Sep 2012 11:33:58 -0400
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

Fixes #324

Signed-off-by: David Goulet <dgoulet@efficios.com>
---
 src/bin/lttng-sessiond/consumer.h |   21 +++++-
 src/bin/lttng-sessiond/main.c     |  127 ++++++++++++++++++++++++++++---------
 2 files changed, 116 insertions(+), 32 deletions(-)

diff --git a/src/bin/lttng-sessiond/consumer.h b/src/bin/lttng-sessiond/consumer.h
index 1337f32..6639bd8 100644
--- a/src/bin/lttng-sessiond/consumer.h
+++ b/src/bin/lttng-sessiond/consumer.h
@@ -18,8 +18,6 @@
 #ifndef _CONSUMER_H
 #define _CONSUMER_H
 
-#include <semaphore.h>
-
 #include <common/consumer.h>
 #include <common/hashtable/hashtable.h>
 #include <lttng/lttng.h>
@@ -54,7 +52,24 @@ struct consumer_data {
 	enum lttng_consumer_type type;
 
 	pthread_t thread;	/* Worker thread interacting with the consumer */
-	sem_t sem;
+
+	/* Conditions used by the consumer thread to indicate readiness. */
+	pthread_cond_t cond;
+	pthread_condattr_t condattr;
+	pthread_mutex_t cond_mutex;
+
+	/*
+	 * This is a flag condition indicating that the consumer thread is ready
+	 * and connected to the lttng-consumerd daemon. This flag MUST only be
+	 * updated by locking the condition mutex above or before spawning a
+	 * consumer thread.
+	 *
+	 * A value of 0 means that the thread is NOT ready. A value of 1 means that
+	 * the thread consumer did connect successfully to the lttng-consumerd
+	 * daemon. A negative value indicates that there is been an error and the
+	 * thread as likely quit.
+	 */
+	int consumer_thread_is_ready;
 
 	/* Mutex to control consumerd pid assignation */
 	pthread_mutex_t pid_mutex;
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index 730ac65..2fb8700 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -21,7 +21,6 @@
 #include <grp.h>
 #include <limits.h>
 #include <pthread.h>
-#include <semaphore.h>
 #include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -81,7 +80,10 @@ static int is_root;			/* Set to 1 if the daemon is running as root */
 static pid_t ppid;          /* Parent PID for --sig-parent option */
 static char *rundir;
 
-/* Consumer daemon specific control data */
+/*
+ * Consumer daemon specific control data. Every value not initialized here is
+ * set to 0 by the static definition.
+ */
 static struct consumer_data kconsumer_data = {
 	.type = LTTNG_CONSUMER_KERNEL,
 	.err_unix_sock_path = DEFAULT_KCONSUMERD_ERR_SOCK_PATH,
@@ -90,6 +92,8 @@ static struct consumer_data kconsumer_data = {
 	.cmd_sock = -1,
 	.pid_mutex = PTHREAD_MUTEX_INITIALIZER,
 	.lock = PTHREAD_MUTEX_INITIALIZER,
+	.cond = PTHREAD_COND_INITIALIZER,
+	.cond_mutex = PTHREAD_MUTEX_INITIALIZER,
 };
 static struct consumer_data ustconsumer64_data = {
 	.type = LTTNG_CONSUMER64_UST,
@@ -99,6 +103,8 @@ static struct consumer_data ustconsumer64_data = {
 	.cmd_sock = -1,
 	.pid_mutex = PTHREAD_MUTEX_INITIALIZER,
 	.lock = PTHREAD_MUTEX_INITIALIZER,
+	.cond = PTHREAD_COND_INITIALIZER,
+	.cond_mutex = PTHREAD_MUTEX_INITIALIZER,
 };
 static struct consumer_data ustconsumer32_data = {
 	.type = LTTNG_CONSUMER32_UST,
@@ -108,6 +114,8 @@ static struct consumer_data ustconsumer32_data = {
 	.cmd_sock = -1,
 	.pid_mutex = PTHREAD_MUTEX_INITIALIZER,
 	.lock = PTHREAD_MUTEX_INITIALIZER,
+	.cond = PTHREAD_COND_INITIALIZER,
+	.cond_mutex = PTHREAD_MUTEX_INITIALIZER,
 };
 
 /* Shared between threads */
@@ -789,6 +797,20 @@ error_poll_create:
 }
 
 /*
+ * Signal pthread condition of the consumer data that the thread.
+ */
+static void signal_consumer_condition(struct consumer_data *data, int state)
+{
+	pthread_mutex_lock(&data->cond_mutex);
+
+	/* Indicates that the thread is ready for action! */
+	data->consumer_thread_is_ready = state;
+	(void) pthread_cond_signal(&data->cond);
+
+	pthread_mutex_unlock(&data->cond_mutex);
+}
+
+/*
  * This thread manage the consumer error sent back to the session daemon.
  */
 static void *thread_manage_consumer(void *data)
@@ -886,13 +908,13 @@ restart:
 		consumer_data->cmd_sock =
 			lttcomm_connect_unix_sock(consumer_data->cmd_unix_sock_path);
 		if (consumer_data->cmd_sock < 0) {
-			sem_post(&consumer_data->sem);
+			/* On error, signal condition and quit. */
+			signal_consumer_condition(consumer_data, -1);
 			PERROR("consumer connect");
 			goto error;
 		}
-		/* Signal condition to tell that the kconsumerd is ready */
-		sem_post(&consumer_data->sem);
-		DBG("consumer command socket ready");
+		signal_consumer_condition(consumer_data, 1);
+		DBG("Consumer command socket ready");
 	} else {
 		ERR("consumer error when waiting for SOCK_READY : %s",
 				lttcomm_get_readable_code(-code));
@@ -1446,59 +1468,106 @@ error_create_poll:
  */
 static int spawn_consumer_thread(struct consumer_data *consumer_data)
 {
-	int ret;
+	int ret, clock_ret;
 	struct timespec timeout;
 
-	timeout.tv_sec = DEFAULT_SEM_WAIT_TIMEOUT;
-	timeout.tv_nsec = 0;
+	/* Make sure we set the readiness flag to 0 because we are NOT ready */
+	consumer_data->consumer_thread_is_ready = 0;
 
-	/* Setup semaphore */
-	ret = sem_init(&consumer_data->sem, 0, 0);
-	if (ret < 0) {
-		PERROR("sem_init consumer semaphore");
+	/* Setup pthread condition */
+	ret = pthread_condattr_init(&consumer_data->condattr);
+	if (ret != 0) {
+		errno = ret;
+		PERROR("pthread_condattr_init consumer data");
+		goto error;
+	}
+
+	/*
+	 * Set the monotonic clock in order to make sure we DO NOT jump in time
+	 * between the clock_gettime() call and the timedwait call. See bug #324
+	 * for a more details and how we noticed it.
+	 */
+	ret = pthread_condattr_setclock(&consumer_data->condattr, CLOCK_MONOTONIC);
+	if (ret != 0) {
+		errno = ret;
+		PERROR("pthread_condattr_setclock consumer data");
 		goto error;
 	}
 
-	ret = pthread_create(&consumer_data->thread, NULL,
-			thread_manage_consumer, consumer_data);
+	ret = pthread_cond_init(&consumer_data->cond, &consumer_data->condattr);
+	if (ret != 0) {
+		errno = ret;
+		PERROR("pthread_cond_init consumer data");
+		goto error;
+	}
+
+	ret = pthread_create(&consumer_data->thread, NULL, thread_manage_consumer,
+			consumer_data);
 	if (ret != 0) {
 		PERROR("pthread_create consumer");
 		ret = -1;
 		goto error;
 	}
 
+	/* We are about to wait on a pthread condition */
+	pthread_mutex_lock(&consumer_data->cond_mutex);
+
 	/* Get time for sem_timedwait absolute timeout */
-	ret = clock_gettime(CLOCK_REALTIME, &timeout);
-	if (ret < 0) {
-		PERROR("clock_gettime spawn consumer");
-		/* Infinite wait for the kconsumerd thread to be ready */
-		ret = sem_wait(&consumer_data->sem);
-	} else {
-		/* Normal timeout if the gettime was successful */
-		timeout.tv_sec += DEFAULT_SEM_WAIT_TIMEOUT;
-		ret = sem_timedwait(&consumer_data->sem, &timeout);
+	clock_ret = clock_gettime(CLOCK_MONOTONIC, &timeout);
+	/*
+	 * Set the timeout for the condition timed wait even if the clock gettime
+	 * call fails since we might loop on that call and we want to avoid to
+	 * incremente the timeout too many times.
+	 */
+	timeout.tv_sec += DEFAULT_SEM_WAIT_TIMEOUT;
+
+	/* Make sure that ret is never set to ETIMEDOUT before reaching the loop */
+	ret = 0;
+
+	/*
+	 * Loop until the condition is reached or when a timeout is reached. Note
+	 * that the pthread_cond_timedwait(P) man page specifies that EINTR can NOT
+	 * be returned but the pthread_cond(3), from the glibc-doc, says that it is
+	 * possible. This loop does not take any chances and works with both of
+	 * them.
+	 */
+	while (!consumer_data->consumer_thread_is_ready && ret != ETIMEDOUT) {
+		if (clock_ret < 0) {
+			PERROR("clock_gettime spawn consumer");
+			/* Infinite wait for the consumerd thread to be ready */
+			ret = pthread_cond_wait(&consumer_data->cond,
+					&consumer_data->cond_mutex);
+		} else {
+			ret = pthread_cond_timedwait(&consumer_data->cond,
+					&consumer_data->cond_mutex, &timeout);
+		}
 	}
 
-	if (ret < 0) {
-		if (errno == ETIMEDOUT) {
+	/* Release the pthread condition */
+	pthread_mutex_unlock(&consumer_data->cond_mutex);
+
+	if (ret != 0) {
+		errno = ret;
+		if (ret == ETIMEDOUT) {
 			/*
 			 * Call has timed out so we kill the kconsumerd_thread and return
 			 * an error.
 			 */
-			ERR("The consumer thread was never ready. Killing it");
+			ERR("Condition timed out. The consumer thread was never ready."
+					" Killing it");
 			ret = pthread_cancel(consumer_data->thread);
 			if (ret < 0) {
 				PERROR("pthread_cancel consumer thread");
 			}
 		} else {
-			PERROR("semaphore wait failed consumer thread");
+			PERROR("pthread_cond_wait failed consumer thread");
 		}
 		goto error;
 	}
 
 	pthread_mutex_lock(&consumer_data->pid_mutex);
 	if (consumer_data->pid == 0) {
-		ERR("Kconsumerd did not start");
+		ERR("Consumerd did not start");
 		pthread_mutex_unlock(&consumer_data->pid_mutex);
 		goto error;
 	}
-- 
1.7.10.4
