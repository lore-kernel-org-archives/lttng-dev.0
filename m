From: Paul Woegerer <paul_woegerer@mentor.com>
Subject: [RFC PATCH lttng-ust] Implement register_done waiting
	via LD_AUDIT
Date: Tue, 1 Jul 2014 16:47:09 +0200
Message-ID: <1404226029-9092-1-git-send-email-paul_woegerer__34114.2698577189$1404226148$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Paul_Woegerer@mentor.com>) id 1X1zLX-0005pR-MV
 for lttng-dev@lists.lttng.org; Tue, 01 Jul 2014 10:47:53 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Paul Woegerer <paul_woegerer@mentor.com>
---
 include/ust-comm.h                 |  34 +++++++++++++
 liblttng-ust/Makefile.am           |   5 +-
 liblttng-ust/lttng-ust-comm.c      | 100 +++++--------------------------------
 liblttng-ust/lttng-ust-startmain.c |  95 +++++++++++++++++++++++++++++++++++
 4 files changed, 145 insertions(+), 89 deletions(-)
 create mode 100644 liblttng-ust/lttng-ust-startmain.c

diff --git a/include/ust-comm.h b/include/ust-comm.h
index b9bbb39..b08892b 100644
--- a/include/ust-comm.h
+++ b/include/ust-comm.h
@@ -28,6 +28,7 @@
 
 #include <limits.h>
 #include <unistd.h>
+#include <stdio.h>
 #include <lttng/ust-abi.h>
 #include <lttng/ust-error.h>
 #include <lttng/ust-compiler.h>
@@ -238,4 +239,37 @@ int ustcomm_register_channel(int sock,
 int ustcomm_setsockopt_rcv_timeout(int sock, unsigned int msec);
 int ustcomm_setsockopt_snd_timeout(int sock, unsigned int msec);
 
+/*
+ * Get notify_sock timeout, in ms.
+ * -1: don't wait. 0: wait forever. >0: timeout, in ms.
+ */
+static inline
+long ustcomm_get_timeout(void)
+{
+	static const char *str_timeout;
+	static int got_timeout_env;
+
+	long constructor_delay_ms = LTTNG_UST_DEFAULT_CONSTRUCTOR_TIMEOUT_MS;
+
+	if (!got_timeout_env) {
+		str_timeout = getenv("LTTNG_UST_REGISTER_TIMEOUT");
+		got_timeout_env = 1;
+	}
+	if (str_timeout)
+		constructor_delay_ms = strtol(str_timeout, NULL, 10);
+	return constructor_delay_ms;
+}
+
+struct ustcomm_ctor_semname
+{
+	char name[NAME_MAX-4];
+};
+
+static inline
+const char *ustcomm_get_ctor_semname(struct ustcomm_ctor_semname *semname)
+{
+	snprintf(semname->name, sizeof(semname->name), "/lttng-ust-ctor_sem_%d", getpid());
+	return semname->name;
+}
+
 #endif	/* _LTTNG_UST_COMM_H */
diff --git a/liblttng-ust/Makefile.am b/liblttng-ust/Makefile.am
index e2e1baa..0c45f04 100644
--- a/liblttng-ust/Makefile.am
+++ b/liblttng-ust/Makefile.am
@@ -3,7 +3,7 @@ AM_CFLAGS = -fno-strict-aliasing
 
 noinst_LTLIBRARIES = liblttng-ust-runtime.la liblttng-ust-support.la
 
-lib_LTLIBRARIES = liblttng-ust-tracepoint.la liblttng-ust.la
+lib_LTLIBRARIES = liblttng-ust-startmain.la liblttng-ust-tracepoint.la liblttng-ust.la
 
 liblttng_ust_tracepoint_la_SOURCES = \
 	tracepoint.c \
@@ -66,6 +66,9 @@ liblttng_ust_support_la_SOURCES = \
 	lttng-ring-buffer-metadata-client.h \
 	lttng-ring-buffer-metadata-client.c
 
+liblttng_ust_startmain_la_SOURCES = \
+	lttng-ust-startmain.c
+
 liblttng_ust_la_SOURCES =
 
 liblttng_ust_la_LDFLAGS = -no-undefined -version-info $(LTTNG_UST_LIBRARY_VERSION)
diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
index 5df33f5..0d40c12 100644
--- a/liblttng-ust/lttng-ust-comm.c
+++ b/liblttng-ust/lttng-ust-comm.c
@@ -172,7 +172,7 @@ void ust_unlock(void)
  * - timeout (ensuring applications are resilient to session
  *   daemon problems).
  */
-static sem_t constructor_wait;
+static sem_t *ctor_sem_ptr;
 /*
  * Doing this for both the global and local sessiond.
  */
@@ -277,9 +277,6 @@ static const char *cmd_name_mapping[] = {
 	[ LTTNG_UST_EXCLUSION ] = "Add exclusions to event",
 };
 
-static const char *str_timeout;
-static int got_timeout_env;
-
 extern void lttng_ring_buffer_client_overwrite_init(void);
 extern void lttng_ring_buffer_client_overwrite_rt_init(void);
 extern void lttng_ring_buffer_client_discard_init(void);
@@ -374,64 +371,10 @@ int setup_local_apps(void)
 	return 0;
 }
 
-/*
- * Get notify_sock timeout, in ms.
- * -1: don't wait. 0: wait forever. >0: timeout, in ms.
- */
-static
-long get_timeout(void)
-{
-	long constructor_delay_ms = LTTNG_UST_DEFAULT_CONSTRUCTOR_TIMEOUT_MS;
-
-	if (!got_timeout_env) {
-		str_timeout = getenv("LTTNG_UST_REGISTER_TIMEOUT");
-		got_timeout_env = 1;
-	}
-	if (str_timeout)
-		constructor_delay_ms = strtol(str_timeout, NULL, 10);
-	return constructor_delay_ms;
-}
-
 static
 long get_notify_sock_timeout(void)
 {
-	return get_timeout();
-}
-
-/*
- * Return values: -1: don't wait. 0: wait forever. 1: timeout wait.
- */
-static
-int get_constructor_timeout(struct timespec *constructor_timeout)
-{
-	long constructor_delay_ms;
-	int ret;
-
-	constructor_delay_ms = get_timeout();
-
-	switch (constructor_delay_ms) {
-	case -1:/* fall-through */
-	case 0:
-		return constructor_delay_ms;
-	default:
-		break;
-	}
-
-	/*
-	 * If we are unable to find the current time, don't wait.
-	 */
-	ret = clock_gettime(CLOCK_REALTIME, constructor_timeout);
-	if (ret) {
-		return -1;
-	}
-	constructor_timeout->tv_sec += constructor_delay_ms / 1000UL;
-	constructor_timeout->tv_nsec +=
-		(constructor_delay_ms % 1000UL) * 1000000UL;
-	if (constructor_timeout->tv_nsec >= 1000000000UL) {
-		constructor_timeout->tv_sec++;
-		constructor_timeout->tv_nsec -= 1000000000UL;
-	}
-	return 1;
+	return ustcomm_get_timeout();
 }
 
 static
@@ -482,7 +425,7 @@ int handle_register_done(struct sock_info *sock_info)
 	}
 	ret = uatomic_add_return(&sem_count, -1);
 	if (ret == 0) {
-		ret = sem_post(&constructor_wait);
+		ret = sem_post(ctor_sem_ptr);
 		assert(!ret);
 	}
 	return 0;
@@ -1390,10 +1333,9 @@ void lttng_ust_malloc_wrapper_init(void)
  */
 void __attribute__((constructor)) lttng_ust_init(void)
 {
-	struct timespec constructor_timeout;
 	sigset_t sig_all_blocked, orig_parent_mask;
 	pthread_attr_t thread_attr;
-	int timeout_mode;
+
 	int ret;
 
 	if (uatomic_xchg(&initialized, 1) == 1)
@@ -1431,10 +1373,14 @@ void __attribute__((constructor)) lttng_ust_init(void)
 	 */
 	lttng_ust_malloc_wrapper_init();
 
-	timeout_mode = get_constructor_timeout(&constructor_timeout);
-
-	ret = sem_init(&constructor_wait, 0, 0);
-	assert(!ret);
+	if (!ctor_sem_ptr) {
+		struct ustcomm_ctor_semname semname;
+		ustcomm_get_ctor_semname(&semname);
+		ctor_sem_ptr = sem_open(semname.name, O_CREAT | O_EXCL, S_IRWXU, 0);
+		if (ctor_sem_ptr == SEM_FAILED) {
+			PERROR("sem_open");
+		}
+	}
 
 	ret = setup_local_apps();
 	if (ret) {
@@ -1492,28 +1438,6 @@ void __attribute__((constructor)) lttng_ust_init(void)
 	if (ret) {
 		ERR("pthread_sigmask: %s", strerror(ret));
 	}
-
-	switch (timeout_mode) {
-	case 1:	/* timeout wait */
-		do {
-			ret = sem_timedwait(&constructor_wait,
-					&constructor_timeout);
-		} while (ret < 0 && errno == EINTR);
-		if (ret < 0 && errno == ETIMEDOUT) {
-			ERR("Timed out waiting for lttng-sessiond");
-		} else {
-			assert(!ret);
-		}
-		break;
-	case -1:/* wait forever */
-		do {
-			ret = sem_wait(&constructor_wait);
-		} while (ret < 0 && errno == EINTR);
-		assert(!ret);
-		break;
-	case 0:	/* no timeout */
-		break;
-	}
 }
 
 static
diff --git a/liblttng-ust/lttng-ust-startmain.c b/liblttng-ust/lttng-ust-startmain.c
new file mode 100644
index 0000000..7602839
--- /dev/null
+++ b/liblttng-ust/lttng-ust-startmain.c
@@ -0,0 +1,95 @@
+#include <errno.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <sys/types.h>
+#include <assert.h>
+#include <unistd.h>
+#include <time.h>
+#include <fcntl.h>
+#include <sys/stat.h>
+#include <semaphore.h>
+
+#include <lttng/ust-ctl.h>
+#include <ust-comm.h>
+#include "usterr.h"
+
+/*
+ * Return values: -1: don't wait. 0: wait forever. 1: timeout wait.
+ */
+static
+int get_constructor_timeout(struct timespec *constructor_timeout)
+{
+	long constructor_delay_ms;
+	int ret;
+
+	constructor_delay_ms = ustcomm_get_timeout();
+
+	switch (constructor_delay_ms) {
+	case -1:/* fall-through */
+	case 0:
+		return constructor_delay_ms;
+	default:
+		break;
+	}
+
+	/*
+	 * If we are unable to find the current time, don't wait.
+	 */
+	ret = clock_gettime(CLOCK_REALTIME, constructor_timeout);
+	if (ret) {
+		return -1;
+	}
+	constructor_timeout->tv_sec += constructor_delay_ms / 1000UL;
+	constructor_timeout->tv_nsec +=
+		(constructor_delay_ms % 1000UL) * 1000000UL;
+	if (constructor_timeout->tv_nsec >= 1000000000UL) {
+		constructor_timeout->tv_sec++;
+		constructor_timeout->tv_nsec -= 1000000000UL;
+	}
+	return 1;
+}
+
+unsigned int la_version(unsigned int version) {
+	return version;
+}
+
+void la_preinit(uintptr_t *cookie) {
+	struct timespec constructor_timeout;
+	struct ustcomm_ctor_semname semname;
+	sem_t *ctor_sem_ptr;
+	int ret;
+
+	ctor_sem_ptr = sem_open(ustcomm_get_ctor_semname(&semname), 0, 0);
+	if (ctor_sem_ptr == SEM_FAILED) {
+		PERROR("sem_open");
+	}
+	ret = sem_unlink(semname.name);
+	if (ret == -1) {
+		PERROR("sem_unlink");
+	}
+
+	switch (get_constructor_timeout(&constructor_timeout)) {
+	case 1:	/* timeout wait */
+		do {
+			ret = sem_timedwait(ctor_sem_ptr,
+					&constructor_timeout);
+		} while (ret < 0 && errno == EINTR);
+		if (ret < 0 && errno == ETIMEDOUT) {
+			ERR("Timed out waiting for lttng-sessiond");
+		} else {
+			assert(!ret);
+		}
+		break;
+	case -1:/* wait forever */
+		do {
+			ret = sem_wait(ctor_sem_ptr);
+		} while (ret < 0 && errno == EINTR);
+		assert(!ret);
+		break;
+	case 0:	/* no timeout */
+		break;
+	}
+}
-- 
2.0.0
