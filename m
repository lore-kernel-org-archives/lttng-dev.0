From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: getgrnam is not MT-Safe,
 use getgrnam_r
Date: Mon,  1 Apr 2019 16:33:41 -0400
Message-ID: <20190401203341.29236-1-jonathan.rajotte-julien__7594.94621758989$1554150844$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44Y3vw1xk1z18Hc
 for <lttng-dev@lists.lttng.org>; Mon,  1 Apr 2019 16:33:48 -0400 (EDT)
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

Running the test suite under a Yocto musl build resulted in musl
coredump due to double freeing.

We get the following backtraces:

0  a_crash () at ./arch/x86_64/atomic_arch.h:108
1  unmap_chunk (self=<optimized out>) at src/malloc/malloc.c:515
2  free (p=<optimized out>) at src/malloc/malloc.c:526
3  0x00007f46d9dc3849 in __getgrent_a (f=f@entry=0x7f46d9d1f7e0, gr=gr@entry=0x7f46d9e24460 <gr>, line=line@entry=0x7f46d9e26058 <line>, size=size@entry=0x7f46d92db550, mem=mem@entry=0x7f46d9e26050 <mem>, nmem=nmem@entry=0x7f46d92db558, res=0x7f46d92db548) at src/passwd/getgrent_a.c:45
4  0x00007f46d9dc2e6b in __getgr_a (name=0x487242 "tracing", gid=gid@entry=0, gr=gr@entry=0x7f46d9e24460 <gr>, buf=buf@entry=0x7f46d9e26058 <line>, size=size@entry=0x7f46d92db550, mem=mem@entry=0x7f46d9e26050 <mem>, nmem=0x7f46d92db558, res=0x7f46d92db548) at src/passwd/getgr_a.c:30
5  0x00007f46d9dc3733 in getgrnam (name=<optimized out>) at src/passwd/getgrent.c:37
6  0x0000000000460b29 in utils_get_group_id (name=<optimized out>) at ../../../lttng-tools-2.10.6/src/common/utils.c:1241
7  0x000000000044ee69 in thread_manage_health (data=<optimized out>) at ../../../../lttng-tools-2.10.6/src/bin/lttng-sessiond/main.c:4115
8  0x00007f46d9de1541 in start (p=<optimized out>) at src/thread/pthread_create.c:195
9  0x00007f46d9dee661 in __clone () at src/thread/x86_64/clone.s:22

From another run:

0  a_crash () at ./arch/x86_64/atomic_arch.h:108
1  unmap_chunk (self=<optimized out>) at src/malloc/malloc.c:515
2  free (p=<optimized out>) at src/malloc/malloc.c:526
3  0x00007f5abc210849 in __getgrent_a (f=f@entry=0x7f5abc2733e0, gr=gr@entry=0x7f5abc271460 <gr>, line=line@entry=0x7f5abc273058 <line>, size=size@entry=0x7f5abaef5510, mem=mem@entry=0x7f5abc273050 <mem>, nmem=nmem@entry=0x7f5abaef5518, res=0x7f5abaef5508) at src/passwd/getgrent_a.c:45
4  0x00007f5abc20fe6b in __getgr_a (name=0x487242 "tracing", gid=gid@entry=0, gr=gr@entry=0x7f5abc271460 <gr>, buf=buf@entry=0x7f5abc273058 <line>, size=size@entry=0x7f5abaef5510, mem=mem@entry=0x7f5abc273050 <mem>, nmem=0x7f5abaef5518, res=0x7f5abaef5508) at src/passwd/getgr_a.c:30
5  0x00007f5abc210733 in getgrnam (name=<optimized out>) at src/passwd/getgrent.c:37
6  0x0000000000460b29 in utils_get_group_id (name=<optimized out>) at ../../../lttng-tools-2.10.6/src/common/utils.c:1241
7  0x000000000042dee4 in notification_channel_socket_create () at ../../../../lttng-tools-2.10.6/src/bin/lttng-sessiond/notification-thread.c:238
8  init_thread_state (state=0x7f5abaef5560, handle=0x7f5abbf9be40) at ../../../../lttng-tools-2.10.6/src/bin/lttng-sessiond/notification-thread.c:375
9  thread_notification (data=0x7f5abbf9be40) at ../../../../lttng-tools-2.10.6/src/bin/lttng-sessiond/notification-thread.c:495
10 0x00007f5abc22e541 in start (p=<optimized out>) at src/thread/pthread_create.c:195
11 0x00007f5abc23b661 in __clone () at src/thread/x86_64/clone.s:22

The problem was easily reproducible (~6 crash on ~300 runs). A prototype fix
using mutex around the getgrnam yielded no crash in over 1000 runs. This
patch yielded the same results as the prototype fix.

Unfortunately we cannot rely on a mutex in liblttng-ctl since we cannot
enforce the locking for the application using the lib.

Use getgrnam_r instead.

The previous implementation of utils_get_group_id returned the gid of
the root group (0) on error/not found. lttng_check_tracing_group needs
to know if an error/not found occured, returning the root group is not
enough. We now return the gid via the passed parameter. The caller is
responsible for either defaulting to the root group or propagating the
error.

We also do not want to warn when used in liblttng-ctl context. We might
want to move the warning elsewhere in the future. For now, pass a bool
if we need to warn or not.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/bin/lttng-consumerd/health-consumerd.c   | 10 ++-
 src/bin/lttng-relayd/health-relayd.c         | 20 ++++--
 src/bin/lttng-sessiond/health.c              | 10 ++-
 src/bin/lttng-sessiond/main.c                | 14 +++-
 src/bin/lttng-sessiond/notification-thread.c | 10 ++-
 src/common/utils.c                           | 75 +++++++++++++++++---
 src/common/utils.h                           |  4 +-
 src/lib/lttng-ctl/lttng-ctl.c                |  8 +--
 8 files changed, 122 insertions(+), 29 deletions(-)

diff --git a/src/bin/lttng-consumerd/health-consumerd.c b/src/bin/lttng-consumerd/health-consumerd.c
index 1e2f31e48..6045401a4 100644
--- a/src/bin/lttng-consumerd/health-consumerd.c
+++ b/src/bin/lttng-consumerd/health-consumerd.c
@@ -184,8 +184,14 @@ void *thread_manage_health(void *data)
 	is_root = !getuid();
 	if (is_root) {
 		/* lttng health client socket path permissions */
-		ret = chown(health_unix_sock_path, 0,
-				utils_get_group_id(tracing_group_name));
+		gid_t gid;
+
+		ret = utils_get_group_id(tracing_group_name, true, &gid);
+		if (ret) {
+			gid = 0; /* Default to root group. */
+		}
+
+		ret = chown(health_unix_sock_path, 0, gid);
 		if (ret < 0) {
 			ERR("Unable to set group on %s", health_unix_sock_path);
 			PERROR("chown");
diff --git a/src/bin/lttng-relayd/health-relayd.c b/src/bin/lttng-relayd/health-relayd.c
index ba996621b..962e88c47 100644
--- a/src/bin/lttng-relayd/health-relayd.c
+++ b/src/bin/lttng-relayd/health-relayd.c
@@ -105,8 +105,14 @@ static int create_lttng_rundir_with_perm(const char *rundir)
 		int is_root = !getuid();
 
 		if (is_root) {
-			ret = chown(rundir, 0,
-					utils_get_group_id(tracing_group_name));
+			gid_t gid;
+
+			ret = utils_get_group_id(tracing_group_name, true, &gid);
+			if (ret) {
+				gid = 0; /* Default to root group.*/
+			}
+
+			ret = chown(rundir, 0, gid);
 			if (ret < 0) {
 				ERR("Unable to set group on %s", rundir);
 				PERROR("chown");
@@ -256,8 +262,14 @@ void *thread_manage_health(void *data)
 	is_root = !getuid();
 	if (is_root) {
 		/* lttng health client socket path permissions */
-		ret = chown(health_unix_sock_path, 0,
-				utils_get_group_id(tracing_group_name));
+		gid_t gid;
+
+		ret = utils_get_group_id(tracing_group_name, true, &gid);
+		if (ret) {
+			gid = 0; /* Default to root group */
+		}
+
+		ret = chown(health_unix_sock_path, 0, gid);
 		if (ret < 0) {
 			ERR("Unable to set group on %s", health_unix_sock_path);
 			PERROR("chown");
diff --git a/src/bin/lttng-sessiond/health.c b/src/bin/lttng-sessiond/health.c
index 921b45261..9e639837b 100644
--- a/src/bin/lttng-sessiond/health.c
+++ b/src/bin/lttng-sessiond/health.c
@@ -95,8 +95,14 @@ static void *thread_manage_health(void *data)
 
 	if (is_root) {
 		/* lttng health client socket path permissions */
-		ret = chown(config.health_unix_sock_path.value, 0,
-				utils_get_group_id(config.tracing_group_name.value));
+		gid_t gid;
+
+		ret = utils_get_group_id(config.tracing_group_name.value, true, &gid);
+		if (ret) {
+			gid = 0; /* Default to root group. */
+		}
+
+		ret = chown(config.health_unix_sock_path.value, 0, gid);
 		if (ret < 0) {
 			ERR("Unable to set group on %s", config.health_unix_sock_path.value);
 			PERROR("chown");
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index 24855b976..1cbd3c14c 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -1023,7 +1023,10 @@ static int set_permissions(char *rundir)
 	int ret;
 	gid_t gid;
 
-	gid = utils_get_group_id(config.tracing_group_name.value);
+	ret = utils_get_group_id(config.tracing_group_name.value, true, &gid);
+	if (ret) {
+		gid = 0; /* Default to root group */
+	}
 
 	/* Set lttng run dir */
 	ret = chown(rundir, 0, gid);
@@ -1134,7 +1137,14 @@ static int set_consumer_sockets(struct consumer_data *consumer_data)
 		goto error;
 	}
 	if (is_root) {
-		ret = chown(path, 0, utils_get_group_id(config.tracing_group_name.value));
+		gid_t gid;
+
+		ret = utils_get_group_id(config.tracing_group_name.value, true, &gid);
+		if (ret) {
+			gid = 0; /* Default to root group */
+		}
+
+		ret = chown(path, 0, gid);
 		if (ret < 0) {
 			ERR("Unable to set group on %s", path);
 			PERROR("chown");
diff --git a/src/bin/lttng-sessiond/notification-thread.c b/src/bin/lttng-sessiond/notification-thread.c
index b42b282e1..5a625eb3c 100644
--- a/src/bin/lttng-sessiond/notification-thread.c
+++ b/src/bin/lttng-sessiond/notification-thread.c
@@ -239,8 +239,14 @@ int notification_channel_socket_create(void)
 	}
 
 	if (getuid() == 0) {
-		ret = chown(sock_path, 0,
-				utils_get_group_id(config.tracing_group_name.value));
+		gid_t gid;
+
+		ret =  utils_get_group_id(config.tracing_group_name.value, true, &gid);
+		if (ret) {
+			gid = 0; /* Default to root group. */
+		}
+
+		ret = chown(sock_path, 0, gid);
 		if (ret) {
 			ERR("Failed to set the notification channel socket's group");
 			ret = -1;
diff --git a/src/common/utils.c b/src/common/utils.c
index 4c000e9b4..c79906a29 100644
--- a/src/common/utils.c
+++ b/src/common/utils.c
@@ -1477,24 +1477,77 @@ size_t utils_get_current_time_str(const char *format, char *dst, size_t len)
 }
 
 /*
- * Return the group ID matching name, else 0 if it cannot be found.
+ * Return 0 on success and set *gid to the group_ID matching the passed name.
+ * Else -1 if it cannot be found or an error occurred.
  */
 LTTNG_HIDDEN
-gid_t utils_get_group_id(const char *name)
+int utils_get_group_id(const char *name, bool warn, gid_t *gid)
 {
-	struct group *grp;
+	static volatile int warn_once;
 
-	grp = getgrnam(name);
-	if (!grp) {
-		static volatile int warn_once;
+	int ret;
+	long sys_len;
+	size_t len;
+	struct group grp;
+	struct group *result;
+	char *buffer = NULL;
 
-		if (!warn_once) {
-			WARN("No tracing group detected");
-			warn_once = 1;
+	/* Get the system limit if it exists */
+	sys_len = sysconf(_SC_GETGR_R_SIZE_MAX);
+	if (sys_len == -1) {
+		len = 1024;
+	} else {
+		len = (size_t) sys_len;
+	}
+
+	buffer = malloc(len);
+	if (!buffer) {
+		PERROR("getgrnam_r malloc");
+		ret = -1;
+		goto error;
+	}
+
+	while ((ret = getgrnam_r(name, &grp, buffer, len, &result)) == ERANGE)
+	{
+		/* Buffer is not big enough, increase its size. */
+		size_t new_len = 2 * len;
+		char *new_buffer = NULL;
+		if (new_len < len) {
+			ERR("getgrnam_r buffer size overflow");
+			ret = -1;
+			goto error;
+		}
+		len = new_len;
+		new_buffer = realloc(buffer, len);
+		if (!new_buffer) {
+			PERROR("getgrnam_r realloc");
+			ret = -1;
+			goto error;
 		}
-		return 0;
+		buffer = new_buffer;
+	}
+	if (ret != 0) {
+		PERROR("getgrnam_r");
+		ret = -1;
+		goto error;
+	}
+
+	/* Group not found. */
+	if (!result) {
+		ret = -1;
+		goto error;
+	}
+
+	*gid = result->gr_gid;
+	ret = 0;
+
+error:
+	free(buffer);
+	if (ret && warn && !warn_once) {
+		WARN("No tracing group detected");
+		warn_once = 1;
 	}
-	return grp->gr_gid;
+	return ret;
 }
 
 /*
diff --git a/src/common/utils.h b/src/common/utils.h
index 9e3fa60cd..9dc447378 100644
--- a/src/common/utils.h
+++ b/src/common/utils.h
@@ -22,6 +22,8 @@
 #include <unistd.h>
 #include <stdint.h>
 #include <getopt.h>
+#include <stdbool.h>
+#include <sys/types.h>
 
 #define KIBI_LOG2 10
 #define MEBI_LOG2 20
@@ -54,7 +56,7 @@ int utils_get_count_order_u64(uint64_t x);
 char *utils_get_home_dir(void);
 char *utils_get_user_home_dir(uid_t uid);
 size_t utils_get_current_time_str(const char *format, char *dst, size_t len);
-gid_t utils_get_group_id(const char *name);
+int utils_get_group_id(const char *name, bool warn, gid_t *gid);
 char *utils_generate_optstring(const struct option *long_options,
 		size_t opt_count);
 int utils_create_lock_file(const char *filepath);
diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
index 165fef4dc..403aa092b 100644
--- a/src/lib/lttng-ctl/lttng-ctl.c
+++ b/src/lib/lttng-ctl/lttng-ctl.c
@@ -241,15 +241,13 @@ end:
 LTTNG_HIDDEN
 int lttng_check_tracing_group(void)
 {
-	struct group *grp_tracing;	/* no free(). See getgrnam(3) */
-	gid_t *grp_list;
+	gid_t *grp_list, tracing_gid;
 	int grp_list_size, grp_id, i;
 	int ret = -1;
 	const char *grp_name = tracing_group;
 
 	/* Get GID of group 'tracing' */
-	grp_tracing = getgrnam(grp_name);
-	if (!grp_tracing) {
+	if (utils_get_group_id(grp_name, false, &tracing_gid)) {
 		/* If grp_tracing is NULL, the group does not exist. */
 		goto end;
 	}
@@ -274,7 +272,7 @@ int lttng_check_tracing_group(void)
 	}
 
 	for (i = 0; i < grp_list_size; i++) {
-		if (grp_list[i] == grp_tracing->gr_gid) {
+		if (grp_list[i] == tracing_gid) {
 			ret = 1;
 			break;
 		}
-- 
2.17.1
