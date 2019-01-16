From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: run-as thread deadlock on
 itself in restart error path
Date: Wed, 16 Jan 2019 13:38:57 -0500
Message-ID: <20190116183857.24550-1-jonathan.rajotte-julien__6011.05151367864$1547663828$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 43fww95190znjH
 for <lttng-dev@lists.lttng.org>; Wed, 16 Jan 2019 13:39:05 -0500 (EST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

The deadlock was found using this backtrace

Thread 5:
0  __lll_lock_wait () at ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:135
1  0x00007efc6b650023 in __GI___pthread_mutex_lock (mutex=mutex@entry=0x55fc37128400 <worker_lock>) at ../nptl/pthread_mutex_lock.c:78
2  0x000055fc36efbe05 in run_as_destroy_worker () at runas.c:1233
3  0x000055fc36efc2e7 in run_as_restart_worker (worker=<optimized out>) at runas.c:998
4  run_as (cmd=cmd@entry=RUN_AS_UNLINK, data=data@entry=0x7efc5b7fa630, ret_value=ret_value@entry=0x7efc5b7fa510, uid=uid@entry=1000, gid=gid@entry=1000) at runas.c:1033
5  0x000055fc36efc9ce in run_as_unlink (path=path@entry=0x7efc5b7fb690 "/home/joraj/lttng-traces/auto-20190116-111518/20190116T111729-0500-33/kernel/index/channel0_3.idx", uid=uid@entry=1000, gid=gid@entry=1000) at runas.c :1120
6  0x000055fc36ef7feb in utils_unlink_stream_file (path_name=path_name@entry=0x7efc5b7fc7e0 "/home/joraj/lttng-traces/auto-20190116-111518/20190116T111729-0500-33/kernel/index", file_name=file_name@entry=0x7efc500085d4 "channel0_3", size=size@entry=0, count=count@entry=0, uid=uid@entry=1000, gid=gid@entry=1000, suffix=0x55fc36f19b26 ".idx") at utils.c:929
7  0x000055fc36f01d4e in lttng_index_file_create (path_name=path_name@entry=0x7efc500087a0 "/home/joraj/lttng-traces/auto-20190116-111518/20190116T111729-0500-33/kernel", stream_name=stream_name@entry=0x7efc500085d4 "channel0_3", uid=1000, gid=1000, size=0, count=0, major=1, minor=1) at index.c:79
8  0x000055fc36ed9475 in rotate_local_stream (ctx=<optimized out>, stream=0x7efc50008460) at consumer.c:4105
9  0x000055fc36ed98b5 in lttng_consumer_rotate_stream (ctx=ctx@entry=0x55fc37428d80, stream=stream@entry=0x7efc50008460, rotated=rotated@entry=0x7efc5b7fdb27) at consumer.c:4181
10 0x000055fc36ee354e in lttng_kconsumer_read_subbuffer (stream=stream@entry=0x7efc50008460, ctx=ctx@entry=0x55fc37428d80, rotated=rotated@entry=0x7efc5b7fdb27) at kernel-consumer.c:1740
11 0x000055fc36ed7a30 in lttng_consumer_read_subbuffer (stream=0x7efc50008460, ctx=0x55fc37428d80) at consumer.c:3383
12 0x000055fc36ed4b74 in consumer_thread_data_poll (data=0x55fc37428d80) at consumer.c:2751
13 0x00007efc6b64d6db in start_thread (arg=0x7efc5b7fe700) at pthread_create.c:463
14 0x00007efc6af6488f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95

The owner of the lock is itself:
  print worker_lock.__data.__owner
    $2 = 25725
  thread find 25725
    Thread 5 has target id 'Thread 0x7efc5b7fe700 (LWP 25725)'

The worker_lock is first taken in frame #4: run_as runas.c:1033

  pthread_mutex_lock(&worker_lock);
  if (use_clone()) {
...
    /*
     * If the worker thread crashed the errno is set to EIO. we log
     * the error and  start a new worker process.
     */
    if (ret == -1 && saved_errno == EIO) {
        DBG("Socket closed unexpectedly... "
        "Restarting the worker process");
->      ret = run_as_restart_worker(global_worker);
        if (ret == -1) {
          ERR("Failed to restart worker process.");
          goto err;
        }

Solution
========

Create run_as_restart_worker_no_lock which does not to take the lock on
execution.
Use run_as_restart_worker_no_lock at the run_as error path call site.
Use run_as_restart_worker_no_lock inside run_as_restart_worker while
holding the worker lock to provide identical behaviour to other call sites.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/common/runas.c | 89 ++++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 42 deletions(-)

diff --git a/src/common/runas.c b/src/common/runas.c
index d727cf417..9e6277078 100644
--- a/src/common/runas.c
+++ b/src/common/runas.c
@@ -986,6 +986,51 @@ error_procname_alloc:
 	return ret;
 }
 
+static
+void run_as_destroy_worker_no_lock(void)
+{
+	struct run_as_worker *worker = global_worker;
+
+	DBG("Destroying run_as worker");
+	if (!worker) {
+		return;
+	}
+	/* Close unix socket */
+	DBG("Closing run_as worker socket");
+	if (lttcomm_close_unix_sock(worker->sockpair[0])) {
+		PERROR("close");
+	}
+	worker->sockpair[0] = -1;
+	/* Wait for worker. */
+	for (;;) {
+		int status;
+		pid_t wait_ret;
+
+		wait_ret = waitpid(worker->pid, &status, 0);
+		if (wait_ret < 0) {
+			if (errno == EINTR) {
+				continue;
+			}
+			PERROR("waitpid");
+			break;
+		}
+
+		if (WIFEXITED(status)) {
+			LOG(WEXITSTATUS(status) == 0 ? PRINT_DBG : PRINT_ERR,
+					DEFAULT_RUN_AS_WORKER_NAME " terminated with status code %d",
+				        WEXITSTATUS(status));
+			break;
+		} else if (WIFSIGNALED(status)) {
+			ERR(DEFAULT_RUN_AS_WORKER_NAME " was killed by signal %d",
+					WTERMSIG(status));
+			break;
+		}
+	}
+	free(worker->procname);
+	free(worker);
+	global_worker = NULL;
+}
+
 static
 int run_as_restart_worker(struct run_as_worker *worker)
 {
@@ -995,7 +1040,7 @@ int run_as_restart_worker(struct run_as_worker *worker)
 	procname = worker->procname;
 
 	/* Close socket to run_as worker process and clean up the zombie process */
-	run_as_destroy_worker();
+	run_as_destroy_worker_no_lock();
 
 	/* Create a new run_as worker process*/
 	ret = run_as_create_worker_no_lock(procname);
@@ -1227,47 +1272,7 @@ int run_as_create_worker(const char *procname)
 LTTNG_HIDDEN
 void run_as_destroy_worker(void)
 {
-	struct run_as_worker *worker = global_worker;
-
-	DBG("Destroying run_as worker");
 	pthread_mutex_lock(&worker_lock);
-	if (!worker) {
-		goto end;
-	}
-	/* Close unix socket */
-	DBG("Closing run_as worker socket");
-	if (lttcomm_close_unix_sock(worker->sockpair[0])) {
-		PERROR("close");
-	}
-	worker->sockpair[0] = -1;
-	/* Wait for worker. */
-	for (;;) {
-		int status;
-		pid_t wait_ret;
-
-		wait_ret = waitpid(worker->pid, &status, 0);
-		if (wait_ret < 0) {
-			if (errno == EINTR) {
-				continue;
-			}
-			PERROR("waitpid");
-			break;
-		}
-
-		if (WIFEXITED(status)) {
-			LOG(WEXITSTATUS(status) == 0 ? PRINT_DBG : PRINT_ERR,
-					DEFAULT_RUN_AS_WORKER_NAME " terminated with status code %d",
-				        WEXITSTATUS(status));
-			break;
-		} else if (WIFSIGNALED(status)) {
-			ERR(DEFAULT_RUN_AS_WORKER_NAME " was killed by signal %d",
-					WTERMSIG(status));
-			break;
-		}
-	}
-	free(worker->procname);
-	free(worker);
-	global_worker = NULL;
-end:
+	run_as_destroy_worker_no_lock();
 	pthread_mutex_unlock(&worker_lock);
 }
-- 
2.17.1
