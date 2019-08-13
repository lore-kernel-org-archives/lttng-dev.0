From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools v2 3/4] Support
 LTTNG_KERNEL_SESSION_SET_NAME of lttng-modules
Date: Tue, 13 Aug 2019 16:25:18 -0400
Message-ID: <20190813202519.31043-3-jonathan.rajotte-julien__8721.6582078085$1565728011$gmane$org@efficios.com>
References: <20190813202519.31043-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 467PNZ0h3dzr5k
 for <lttng-dev@lists.lttng.org>; Tue, 13 Aug 2019 16:25:34 -0400 (EDT)
In-Reply-To: <20190813202519.31043-1-jonathan.rajotte-julien@efficios.com>
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

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/bin/lttng-sessiond/kernel.c      | 14 ++++++++++++++
 src/common/kernel-ctl/kernel-ctl.c   | 10 ++++++++++
 src/common/kernel-ctl/kernel-ctl.h   |  1 +
 src/common/kernel-ctl/kernel-ioctl.h |  2 ++
 src/common/lttng-kernel.h            |  8 ++++++++
 5 files changed, 35 insertions(+)

diff --git a/src/bin/lttng-sessiond/kernel.c b/src/bin/lttng-sessiond/kernel.c
index b4fc995ce..7793ba6bc 100644
--- a/src/bin/lttng-sessiond/kernel.c
+++ b/src/bin/lttng-sessiond/kernel.c
@@ -125,6 +125,20 @@ int kernel_create_session(struct ltt_session *session, int tracer_fd)
 
 	DBG("Kernel session created (fd: %d)", lks->fd);
 
+	/*
+	 * This is necessary since the creation time is present in the session
+	 * name when it is generated.
+	 */
+	if (session->has_auto_generated_name) {
+		ret = kernctl_session_set_name(lks->fd, DEFAULT_SESSION_NAME);
+	} else {
+		ret = kernctl_session_set_name(lks->fd, session->name);
+	}
+	if (ret) {
+		WARN("Could not set kernel session name for session %" PRIu64 " name: %s",
+			session->id, session->name);
+	}
+
 	return 0;
 
 error:
diff --git a/src/common/kernel-ctl/kernel-ctl.c b/src/common/kernel-ctl/kernel-ctl.c
index 047d40a34..6a37015ae 100644
--- a/src/common/kernel-ctl/kernel-ctl.c
+++ b/src/common/kernel-ctl/kernel-ctl.c
@@ -238,6 +238,16 @@ int kernctl_session_regenerate_statedump(int fd)
 	return LTTNG_IOCTL_CHECK(fd, LTTNG_KERNEL_SESSION_STATEDUMP);
 }
 
+int kernctl_session_set_name(int fd, const char *name)
+{
+	struct lttng_kernel_session_name session_name;
+
+	strncpy(session_name.name, name, LTTNG_KERNEL_SESSION_NAME_LEN);
+
+	return LTTNG_IOCTL_CHECK(fd, LTTNG_KERNEL_SESSION_SET_NAME,
+			&session_name);
+}
+
 int kernctl_create_stream(int fd)
 {
 	return compat_ioctl_no_arg(fd, LTTNG_KERNEL_OLD_STREAM,
diff --git a/src/common/kernel-ctl/kernel-ctl.h b/src/common/kernel-ctl/kernel-ctl.h
index 841c31da0..884929ac1 100644
--- a/src/common/kernel-ctl/kernel-ctl.h
+++ b/src/common/kernel-ctl/kernel-ctl.h
@@ -67,6 +67,7 @@ int kernctl_list_tracker_pids(int fd);
 
 int kernctl_session_regenerate_metadata(int fd);
 int kernctl_session_regenerate_statedump(int fd);
+int kernctl_session_set_name(int fd, const char *name);
 
 /* Buffer operations */
 
diff --git a/src/common/kernel-ctl/kernel-ioctl.h b/src/common/kernel-ctl/kernel-ioctl.h
index e7ff50b24..ce910e96f 100644
--- a/src/common/kernel-ctl/kernel-ioctl.h
+++ b/src/common/kernel-ctl/kernel-ioctl.h
@@ -145,6 +145,8 @@
 #define LTTNG_KERNEL_SESSION_METADATA_REGEN	_IO(0xF6, 0x59)
 /* 0x5A and 0x5B are reserved for a future ABI-breaking cleanup. */
 #define LTTNG_KERNEL_SESSION_STATEDUMP		_IO(0xF6, 0x5C)
+#define LTTNG_KERNEL_SESSION_SET_NAME		\
+	_IOR(0xF6, 0x5D, struct lttng_kernel_session_name)
 
 /* Channel FD ioctl */
 #define LTTNG_KERNEL_STREAM			_IO(0xF6, 0x62)
diff --git a/src/common/lttng-kernel.h b/src/common/lttng-kernel.h
index cd1a15f67..001a16e2d 100644
--- a/src/common/lttng-kernel.h
+++ b/src/common/lttng-kernel.h
@@ -27,6 +27,7 @@
 
 #define LTTNG_KERNEL_SYM_NAME_LEN  256
 #define LTTNG_KERNEL_MAX_UPROBE_NUM  32
+#define LTTNG_KERNEL_SESSION_NAME_LEN	256
 
 /*
  * LTTng DebugFS ABI structures.
@@ -178,4 +179,11 @@ struct lttng_kernel_filter_bytecode {
 	char data[0];
 } LTTNG_PACKED;
 
+/*
+ * kernel session name
+ */
+struct lttng_kernel_session_name {
+	char name[LTTNG_KERNEL_SESSION_NAME_LEN];
+} LTTNG_PACKED;
+
 #endif /* _LTTNG_KERNEL_H */
-- 
2.17.1
