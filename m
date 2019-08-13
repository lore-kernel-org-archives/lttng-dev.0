From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-modules 3/3] Introduce
 LTTNG_KERNEL_SESSION_SET_CREATION_TIME
Date: Tue, 13 Aug 2019 14:14:25 -0400
Message-ID: <20190813181425.9536-3-jonathan.rajotte-julien__17923.63765869$1565720166$gmane$org@efficios.com>
References: <20190813181425.9536-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 467LTl73PTzsV4
 for <lttng-dev@lists.lttng.org>; Tue, 13 Aug 2019 14:14:51 -0400 (EDT)
In-Reply-To: <20190813181425.9536-1-jonathan.rajotte-julien@efficios.com>
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

Add trace_creation_datetime to the metadata env field

This allows a viewer to get more information regarding the creation time
of a trace. This information is normally inferred from the trace
hierarchy.

The ABI expects an ISO8601 compliant string value. We leave the
formatting to the trace controller.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---

This should also be backported to 2.11 allowing Babeltrace 2 to merge
traces from archived data (rotation) and output a trace with similar
lttng tree hierarchy.

---
 lttng-abi.c    | 27 +++++++++++++++++++++++++++
 lttng-abi.h    |  7 +++++++
 lttng-events.c | 13 +++++++++----
 lttng-events.h |  1 +
 4 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/lttng-abi.c b/lttng-abi.c
index aab2cac..cc8f183 100644
--- a/lttng-abi.c
+++ b/lttng-abi.c
@@ -470,6 +470,23 @@ int lttng_abi_session_set_name(struct lttng_session *session,
 	return 0;
 }
 
+static
+int lttng_abi_session_set_creation_time(struct lttng_session *session,
+		struct lttng_kernel_session_creation_time *time)
+{
+	size_t len;
+
+	len = strnlen(time->iso8601, LTTNG_KERNEL_SESSION_CREATION_TIME_ISO8601_LEN);
+
+	if (len == LTTNG_KERNEL_SESSION_CREATION_TIME_ISO8601_LEN) {
+		/* Time is too long/malformed */
+		return -EINVAL;
+	}
+
+	strcpy(session->creation_time, time->iso8601);
+	return 0;
+}
+
 /**
  *	lttng_session_ioctl - lttng session fd ioctl
  *
@@ -589,6 +606,16 @@ long lttng_session_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			return -EFAULT;
 		return lttng_abi_session_set_name(session, &name);
 	}
+	case LTTNG_KERNEL_SESSION_SET_CREATION_TIME:
+	{
+		struct lttng_kernel_session_creation_time time;
+
+		if (copy_from_user(&time,
+				(struct lttng_kernel_session_creation_time __user *) arg,
+				sizeof(struct lttng_kernel_session_creation_time)))
+			return -EFAULT;
+		return lttng_abi_session_set_creation_time(session, &time);
+	}
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/lttng-abi.h b/lttng-abi.h
index 0dd9a9f..c292de0 100644
--- a/lttng-abi.h
+++ b/lttng-abi.h
@@ -21,6 +21,7 @@
 
 #define LTTNG_KERNEL_SYM_NAME_LEN	256
 #define LTTNG_KERNEL_SESSION_NAME_LEN	256
+#define LTTNG_KERNEL_SESSION_CREATION_TIME_ISO8601_LEN	26
 
 enum lttng_kernel_instrumentation {
 	LTTNG_KERNEL_TRACEPOINT	= 0,
@@ -124,6 +125,10 @@ struct lttng_kernel_session_name {
 	char name[LTTNG_KERNEL_SESSION_NAME_LEN];
 } __attribute__((packed));
 
+struct lttng_kernel_session_creation_time {
+	char iso8601[LTTNG_KERNEL_SESSION_CREATION_TIME_ISO8601_LEN];
+} __attribute__((packed));
+
 enum lttng_kernel_calibrate_type {
 	LTTNG_KERNEL_CALIBRATE_KRETPROBE,
 };
@@ -219,6 +224,8 @@ struct lttng_kernel_filter_bytecode {
 #define LTTNG_KERNEL_SESSION_STATEDUMP		_IO(0xF6, 0x5C)
 #define LTTNG_KERNEL_SESSION_SET_NAME		\
 	_IOR(0xF6, 0x5D, struct lttng_kernel_session_name)
+#define LTTNG_KERNEL_SESSION_SET_CREATION_TIME		\
+	_IOR(0xF6, 0x5E, struct lttng_kernel_session_creation_time)
 
 /* Channel FD ioctl */
 #define LTTNG_KERNEL_STREAM			_IO(0xF6, 0x62)
diff --git a/lttng-events.c b/lttng-events.c
index 2e7670b..38cd444 100644
--- a/lttng-events.c
+++ b/lttng-events.c
@@ -2514,15 +2514,16 @@ error:
 }
 
 static
-int print_metadata_session_name(struct lttng_session *session)
+int print_metadata_escaped_field(struct lttng_session *session, const char *field,
+		const char *field_value)
 {
 	int ret;
 
-	ret = lttng_metadata_printf(session, "	trace_name = \"");
+	ret = lttng_metadata_printf(session, "	%s = \"", field);
 	if (ret)
 		goto error;
 
-	ret = print_escaped_ctf_string(session, session->name);
+	ret = print_escaped_ctf_string(session, field_value);
 	if (ret)
 		goto error;
 
@@ -2619,7 +2620,11 @@ int _lttng_session_metadata_statedump(struct lttng_session *session)
 	if (ret)
 		goto end;
 
-	ret = print_metadata_session_name(session);
+	ret = print_metadata_escaped_field(session, "trace_name", session->name);
+	if (ret)
+		goto end;
+	ret = print_metadata_escaped_field(session, "trace_creation_datetime",
+			session->creation_time);
 	if (ret)
 		goto end;
 
diff --git a/lttng-events.h b/lttng-events.h
index bdd73ff..8fe36a7 100644
--- a/lttng-events.h
+++ b/lttng-events.h
@@ -522,6 +522,7 @@ struct lttng_session {
 	/* Hash table of events */
 	struct lttng_event_ht events_ht;
 	char name[LTTNG_KERNEL_SESSION_NAME_LEN];
+	char creation_time[LTTNG_KERNEL_SESSION_CREATION_TIME_ISO8601_LEN];
 };
 
 struct lttng_metadata_cache {
-- 
2.17.1
