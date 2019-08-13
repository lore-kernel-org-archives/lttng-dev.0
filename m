From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-modules 1/3] Introduce
 LTTNG_KERNEL_SESSION_SET_NAME
Date: Tue, 13 Aug 2019 14:14:23 -0400
Message-ID: <20190813181425.9536-1-jonathan.rajotte-julien__38197.1242067934$1565720099$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 467LTb4nvZzsTg
 for <lttng-dev@lists.lttng.org>; Tue, 13 Aug 2019 14:14:43 -0400 (EDT)
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

The tracer controller (lttng-sessiond) can now inform the kernel tracer
of the name of the created session. This will allow the tracer to
propagate the information inside the trace metadata under a "env" field.

This information is normally inferred from the generated folder
structure where a trace rests.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---

This should also be backported to 2.11 allowing Babeltrace 2 to merge
traces from archived data (rotation) and output a trace with similar
lttng tree hierarchy.

---
 lttng-abi.c    | 27 +++++++++++++++++++++++++++
 lttng-abi.h    | 10 +++++++++-
 lttng-events.h |  1 +
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/lttng-abi.c b/lttng-abi.c
index ca94379..aab2cac 100644
--- a/lttng-abi.c
+++ b/lttng-abi.c
@@ -453,6 +453,23 @@ fd_error:
 	return ret;
 }
 
+static
+int lttng_abi_session_set_name(struct lttng_session *session,
+		struct lttng_kernel_session_name *name)
+{
+	size_t len;
+
+	len = strnlen(name->name, LTTNG_KERNEL_SESSION_NAME_LEN);
+
+	if (len == LTTNG_KERNEL_SESSION_NAME_LEN) {
+		/* Name is too long/malformed */
+		return -EINVAL;
+	}
+
+	strcpy(session->name, name->name);
+	return 0;
+}
+
 /**
  *	lttng_session_ioctl - lttng session fd ioctl
  *
@@ -562,6 +579,16 @@ long lttng_session_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		return lttng_session_metadata_regenerate(session);
 	case LTTNG_KERNEL_SESSION_STATEDUMP:
 		return lttng_session_statedump(session);
+	case LTTNG_KERNEL_SESSION_SET_NAME:
+	{
+		struct lttng_kernel_session_name name;
+
+		if (copy_from_user(&name,
+				(struct lttng_kernel_session_name __user *) arg,
+				sizeof(struct lttng_kernel_session_name)))
+			return -EFAULT;
+		return lttng_abi_session_set_name(session, &name);
+	}
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/lttng-abi.h b/lttng-abi.h
index 83bf931..0dd9a9f 100644
--- a/lttng-abi.h
+++ b/lttng-abi.h
@@ -17,9 +17,10 @@
  * should be increased when an incompatible ABI change is done.
  */
 #define LTTNG_MODULES_ABI_MAJOR_VERSION		2
-#define LTTNG_MODULES_ABI_MINOR_VERSION		3
+#define LTTNG_MODULES_ABI_MINOR_VERSION		4
 
 #define LTTNG_KERNEL_SYM_NAME_LEN	256
+#define LTTNG_KERNEL_SESSION_NAME_LEN	256
 
 enum lttng_kernel_instrumentation {
 	LTTNG_KERNEL_TRACEPOINT	= 0,
@@ -119,6 +120,10 @@ struct lttng_kernel_tracer_abi_version {
 	uint32_t minor;
 } __attribute__((packed));
 
+struct lttng_kernel_session_name {
+	char name[LTTNG_KERNEL_SESSION_NAME_LEN];
+} __attribute__((packed));
+
 enum lttng_kernel_calibrate_type {
 	LTTNG_KERNEL_CALIBRATE_KRETPROBE,
 };
@@ -209,8 +214,11 @@ struct lttng_kernel_filter_bytecode {
  */
 #define LTTNG_KERNEL_SESSION_LIST_TRACKER_PIDS	_IO(0xF6, 0x58)
 #define LTTNG_KERNEL_SESSION_METADATA_REGEN	_IO(0xF6, 0x59)
+
 /* 0x5A and 0x5B are reserved for a future ABI-breaking cleanup. */
 #define LTTNG_KERNEL_SESSION_STATEDUMP		_IO(0xF6, 0x5C)
+#define LTTNG_KERNEL_SESSION_SET_NAME		\
+	_IOR(0xF6, 0x5D, struct lttng_kernel_session_name)
 
 /* Channel FD ioctl */
 #define LTTNG_KERNEL_STREAM			_IO(0xF6, 0x62)
diff --git a/lttng-events.h b/lttng-events.h
index 1903706..bdd73ff 100644
--- a/lttng-events.h
+++ b/lttng-events.h
@@ -521,6 +521,7 @@ struct lttng_session {
 	struct list_head enablers_head;
 	/* Hash table of events */
 	struct lttng_event_ht events_ht;
+	char name[LTTNG_KERNEL_SESSION_NAME_LEN];
 };
 
 struct lttng_metadata_cache {
-- 
2.17.1
