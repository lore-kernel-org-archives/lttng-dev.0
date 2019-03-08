From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-ust] Move wait_shm_mmap initialization to
 library constructor
Date: Fri,  8 Mar 2019 10:01:12 -0500
Message-ID: <20190308150112.15412-1-jonathan.rajotte-julien__28764.5743855805$1552057306$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44G9gT588Jz16Pk
 for <lttng-dev@lists.lttng.org>; Fri,  8 Mar 2019 10:01:24 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id A444AB8C95
 for <lttng-dev@lists.lttng.org>; Fri,  8 Mar 2019 10:01:23 -0500 (EST)
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
List-Id: lttng-dev@lists.lttng.org

Prevent us from deadlocking ourself if some glibc implementation
decide to hold the dl_load_* locks on fork operation.

This happens on Yocto Rocko and up when performing python tracing (import
lttngust). Why Yocto decided to patch glibc this way is a mystery
(ongoing effort) [1][2][3].

Anyhow, we can prevent this by moving the initialization of the
wait_shm_mmap to the library constructor since the dl_load_* locks are
nestable mutex.

Nothing in the git log for the wait_shm_mmap indicate a specific reason
to why it was done inside the listener thread. Doing it inside
wait_for_sessiond can help in some corner cases were /dev/shm
(or the shm path) files are unlinked. This is not much of an advantage.

[1] From yocto master branch: ee9db1a9152e8757ce4d831ff9f4472ff5a57dad
[2] From OE-Core: f2e586ebf59a9b7d5b216fc92aeb892069a4b0c1
[3] https://www.mail-archive.com/openembedded-core@lists.openembedded.org/msg101186.html

This was tested on a Yocto Rocko qemu x86-64 image with python agent
enabled.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 liblttng-ust/lttng-ust-comm.c | 76 +++++++++++++++++++++++++++--------
 1 file changed, 60 insertions(+), 16 deletions(-)

diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
index eab2d8eb..61dbb41b 100644
--- a/liblttng-ust/lttng-ust-comm.c
+++ b/liblttng-ust/lttng-ust-comm.c
@@ -264,7 +264,7 @@ struct sock_info global_apps = {
 	.global = 1,
 
 	.root_handle = -1,
-	.allowed = 1,
+	.allowed = 0,
 	.thread_active = 0,
 
 	.sock_path = LTTNG_DEFAULT_RUNDIR "/" LTTNG_UST_SOCK_FILENAME,
@@ -343,6 +343,8 @@ extern void lttng_ring_buffer_client_discard_exit(void);
 extern void lttng_ring_buffer_client_discard_rt_exit(void);
 extern void lttng_ring_buffer_metadata_client_exit(void);
 
+static char *get_map_shm(struct sock_info *sock_info);
+
 ssize_t lttng_ust_read(int fd, void *buf, size_t len)
 {
 	ssize_t ret;
@@ -434,25 +436,48 @@ void print_cmd(int cmd, int handle)
 		lttng_ust_obj_get_name(handle), handle);
 }
 
+static
+int setup_global_apps(void)
+{
+	int ret = 0;
+	assert(!global_apps.wait_shm_mmap);
+
+	global_apps.wait_shm_mmap = get_map_shm(&global_apps);
+	if (!global_apps.wait_shm_mmap) {
+		WARN("Unable to get map shm for global apps. Disabling LTTng-UST global tracing.");
+		global_apps.allowed = 0;
+		ret = -EIO;
+		goto error;
+	}
+
+	global_apps.allowed = 1;
+error:
+	return ret;
+}
 static
 int setup_local_apps(void)
 {
+	int ret = 0;
 	const char *home_dir;
 	uid_t uid;
 
+	assert(!local_apps.wait_shm_mmap);
+
 	uid = getuid();
 	/*
 	 * Disallow per-user tracing for setuid binaries.
 	 */
 	if (uid != geteuid()) {
 		assert(local_apps.allowed == 0);
-		return 0;
+		ret = 0;
+		goto end;
 	}
 	home_dir = get_lttng_home_dir();
 	if (!home_dir) {
 		WARN("HOME environment variable not set. Disabling LTTng-UST per-user tracing.");
 		assert(local_apps.allowed == 0);
-		return -ENOENT;
+		ret = -ENOENT;
+		goto end;
 	}
 	local_apps.allowed = 1;
 	snprintf(local_apps.sock_path, PATH_MAX, "%s/%s/%s",
@@ -462,7 +487,16 @@ int setup_local_apps(void)
 	snprintf(local_apps.wait_shm_path, PATH_MAX, "/%s-%u",
 		LTTNG_UST_WAIT_FILENAME,
 		uid);
-	return 0;
+
+	local_apps.wait_shm_mmap = get_map_shm(&local_apps);
+	if (!local_apps.wait_shm_mmap) {
+		WARN("Unable to get map shm for local apps. Disabling LTTng-UST per-user tracing.");
+		local_apps.allowed = 0;
+		ret = -EIO;
+		goto end;
+	}
+end:
+	return ret;
 }
 
 /*
@@ -1305,19 +1339,17 @@ error:
 static
 void wait_for_sessiond(struct sock_info *sock_info)
 {
+	/* Use ust_lock to check if we should quit. */
 	if (ust_lock()) {
 		goto quit;
 	}
 	if (wait_poll_fallback) {
 		goto error;
 	}
-	if (!sock_info->wait_shm_mmap) {
-		sock_info->wait_shm_mmap = get_map_shm(sock_info);
-		if (!sock_info->wait_shm_mmap)
-			goto error;
-	}
 	ust_unlock();
 
+	assert(sock_info->wait_shm_mmap);
+
 	DBG("Waiting for %s apps sessiond", sock_info->name);
 	/* Wait for futex wakeup */
 	if (uatomic_read((int32_t *) sock_info->wait_shm_mmap))
@@ -1756,8 +1788,15 @@ void __attribute__((constructor)) lttng_ust_init(void)
 		PERROR("sem_init");
 	}
 
+	ret = setup_global_apps();
+	if (ret) {
+		assert(global_apps.allowed == 0);
+		DBG("global apps setup returned %d", ret);
+	}
+
 	ret = setup_local_apps();
 	if (ret) {
+		assert(local_apps.allowed == 0);
 		DBG("local apps setup returned %d", ret);
 	}
 
@@ -1781,14 +1820,18 @@ void __attribute__((constructor)) lttng_ust_init(void)
 		ERR("pthread_attr_setdetachstate: %s", strerror(ret));
 	}
 
-	pthread_mutex_lock(&ust_exit_mutex);
-	ret = pthread_create(&global_apps.ust_listener, &thread_attr,
-			ust_listener_thread, &global_apps);
-	if (ret) {
-		ERR("pthread_create global: %s", strerror(ret));
+	if (global_apps.allowed) {
+		pthread_mutex_lock(&ust_exit_mutex);
+		ret = pthread_create(&global_apps.ust_listener, &thread_attr,
+				ust_listener_thread, &global_apps);
+		if (ret) {
+			ERR("pthread_create global: %s", strerror(ret));
+		}
+		global_apps.thread_active = 1;
+		pthread_mutex_unlock(&ust_exit_mutex);
+	} else {
+		handle_register_done(&global_apps);
 	}
-	global_apps.thread_active = 1;
-	pthread_mutex_unlock(&ust_exit_mutex);
 
 	if (local_apps.allowed) {
 		pthread_mutex_lock(&ust_exit_mutex);
@@ -1859,6 +1902,7 @@ void lttng_ust_cleanup(int exiting)
 	cleanup_sock_info(&global_apps, exiting);
 	cleanup_sock_info(&local_apps, exiting);
 	local_apps.allowed = 0;
+	global_apps.allowed = 0;
 	/*
 	 * The teardown in this function all affect data structures
 	 * accessed under the UST lock by the listener thread. This
-- 
2.17.1
