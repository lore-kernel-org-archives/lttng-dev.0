From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools v2 4/4] Support
 LTTNG_KERNEL_SESSION_SET_CREATION_DATETIME of lttng-modules
Date: Tue, 13 Aug 2019 16:25:19 -0400
Message-ID: <20190813202519.31043-4-jonathan.rajotte-julien__41627.7002704859$1565728047$gmane$org@efficios.com>
References: <20190813202519.31043-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 467PNZ6fx1zr5n
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
 src/bin/lttng-sessiond/kernel.c      |  6 ++++++
 src/common/kernel-ctl/kernel-ctl.c   | 15 +++++++++++++++
 src/common/kernel-ctl/kernel-ctl.h   |  1 +
 src/common/kernel-ctl/kernel-ioctl.h |  2 ++
 src/common/lttng-kernel.h            |  8 ++++++++
 5 files changed, 32 insertions(+)

diff --git a/src/bin/lttng-sessiond/kernel.c b/src/bin/lttng-sessiond/kernel.c
index 7793ba6bc..cedb9346c 100644
--- a/src/bin/lttng-sessiond/kernel.c
+++ b/src/bin/lttng-sessiond/kernel.c
@@ -139,6 +139,12 @@ int kernel_create_session(struct ltt_session *session, int tracer_fd)
 			session->id, session->name);
 	}
 
+	ret = kernctl_session_set_creation_time(lks->fd, session->creation_time);
+	if (ret) {
+		WARN("Could not set kernel session creation time for session %" PRIu64 " name: %s",
+			session->id, session->name);
+	}
+
 	return 0;
 
 error:
diff --git a/src/common/kernel-ctl/kernel-ctl.c b/src/common/kernel-ctl/kernel-ctl.c
index 6a37015ae..8c0025c93 100644
--- a/src/common/kernel-ctl/kernel-ctl.c
+++ b/src/common/kernel-ctl/kernel-ctl.c
@@ -25,6 +25,7 @@
 #include <errno.h>
 #include <stdarg.h>
 #include <assert.h>
+#include <common/time.h>
 
 #include "kernel-ctl.h"
 #include "kernel-ioctl.h"
@@ -248,6 +249,20 @@ int kernctl_session_set_name(int fd, const char *name)
 			&session_name);
 }
 
+int kernctl_session_set_creation_time(int fd, time_t time)
+{
+	int ret;
+	struct lttng_kernel_session_creation_time creation_time;
+
+	ret = time_t_to_ISO8601(creation_time.iso8601, sizeof(creation_time.iso8601), time);
+	if (ret) {
+		return -1;
+	}
+
+	return LTTNG_IOCTL_CHECK(fd, LTTNG_KERNEL_SESSION_SET_CREATION_TIME,
+			&creation_time);
+}
+
 int kernctl_create_stream(int fd)
 {
 	return compat_ioctl_no_arg(fd, LTTNG_KERNEL_OLD_STREAM,
diff --git a/src/common/kernel-ctl/kernel-ctl.h b/src/common/kernel-ctl/kernel-ctl.h
index 884929ac1..053e7df63 100644
--- a/src/common/kernel-ctl/kernel-ctl.h
+++ b/src/common/kernel-ctl/kernel-ctl.h
@@ -68,6 +68,7 @@ int kernctl_list_tracker_pids(int fd);
 int kernctl_session_regenerate_metadata(int fd);
 int kernctl_session_regenerate_statedump(int fd);
 int kernctl_session_set_name(int fd, const char *name);
+int kernctl_session_set_creation_time(int fd, time_t time);
 
 /* Buffer operations */
 
diff --git a/src/common/kernel-ctl/kernel-ioctl.h b/src/common/kernel-ctl/kernel-ioctl.h
index ce910e96f..8d39abbe3 100644
--- a/src/common/kernel-ctl/kernel-ioctl.h
+++ b/src/common/kernel-ctl/kernel-ioctl.h
@@ -147,6 +147,8 @@
 #define LTTNG_KERNEL_SESSION_STATEDUMP		_IO(0xF6, 0x5C)
 #define LTTNG_KERNEL_SESSION_SET_NAME		\
 	_IOR(0xF6, 0x5D, struct lttng_kernel_session_name)
+#define LTTNG_KERNEL_SESSION_SET_CREATION_TIME		\
+	_IOR(0xF6, 0x5E, struct lttng_kernel_session_creation_time)
 
 /* Channel FD ioctl */
 #define LTTNG_KERNEL_STREAM			_IO(0xF6, 0x62)
diff --git a/src/common/lttng-kernel.h b/src/common/lttng-kernel.h
index 001a16e2d..2fd14dc1e 100644
--- a/src/common/lttng-kernel.h
+++ b/src/common/lttng-kernel.h
@@ -28,6 +28,7 @@
 #define LTTNG_KERNEL_SYM_NAME_LEN  256
 #define LTTNG_KERNEL_MAX_UPROBE_NUM  32
 #define LTTNG_KERNEL_SESSION_NAME_LEN	256
+#define LTTNG_KERNEL_SESSION_CREATION_TIME_ISO8601_LEN	26
 
 /*
  * LTTng DebugFS ABI structures.
@@ -186,4 +187,11 @@ struct lttng_kernel_session_name {
 	char name[LTTNG_KERNEL_SESSION_NAME_LEN];
 } LTTNG_PACKED;
 
+/*
+ * kernel session creation datetime
+ */
+struct lttng_kernel_session_creation_time {
+	char iso8601[LTTNG_KERNEL_SESSION_CREATION_TIME_ISO8601_LEN];
+} LTTNG_PACKED;
+
 #endif /* _LTTNG_KERNEL_H */
-- 
2.17.1
