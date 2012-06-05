From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: [PATCH 2/2] Expose kernel tracer to user-space
Date: Tue,  5 Jun 2012 11:20:51 +0200
Message-ID: <1338888051-20879-3-git-send-email-francis.giraldeau__20584.0493356392$1338888099$gmane$org@gmail.com>
References: <1338888051-20879-1-git-send-email-francis.giraldeau@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lpp01m010-f48.google.com ([209.85.215.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <francis.giraldeau@gmail.com>) id 1Sbpww-0006sP-On
	for lttng-dev@lists.lttng.org; Tue, 05 Jun 2012 05:21:14 -0400
Received: by lagz14 with SMTP id z14so4789358lag.35
	for <lttng-dev@lists.lttng.org>; Tue, 05 Jun 2012 02:21:08 -0700 (PDT)
In-Reply-To: <1338888051-20879-1-git-send-email-francis.giraldeau@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

By writing to the file /proc/lttng, a user-space application creates a
kernel event. The event's payload is by default UTF-8 text, but any data
can be written, up to 1024 bytes. Null-character is optional and is not
enforced. The event uses sequence for space efficiency and to store any
data as payload.

Signed-off-by: Francis Giraldeau <francis.giraldeau@gmail.com>
---
 instrumentation/events/lttng-module/lttng.h |   21 +++++++++++++++++++++
 lttng-abi.c                                 |   20 ++++++++++++++++++++
 lttng-abi.h                                 |    1 +
 3 files changed, 42 insertions(+)

diff --git a/instrumentation/events/lttng-module/lttng.h b/instrumentation/events/lttng-module/lttng.h
index 6f3d6d1..cc36a8b 100644
--- a/instrumentation/events/lttng-module/lttng.h
+++ b/instrumentation/events/lttng-module/lttng.h
@@ -28,6 +28,27 @@ TRACE_EVENT(lttng_metadata,
 	TP_printk("")
 )
 
+TRACE_EVENT(lttng_uevent,
+
+	TP_PROTO(const char *str, size_t len),
+
+	TP_ARGS(str, len),
+
+	/*
+	 * Uses sequence to hold variable size data, by default considered
+	 * as text. Null-terminal character is optional and is not enforced.
+	 */
+	TP_STRUCT__entry(
+		__dynamic_array_text(char, text, len)
+	),
+
+	TP_fast_assign(
+		tp_memcpy_dyn_from_user(text, str)
+	),
+
+	TP_printk("")
+)
+
 #endif /*  _TRACE_LTTNG_H */
 
 /* This part must be outside protection */
diff --git a/lttng-abi.c b/lttng-abi.c
index 26a02ed..fa29e53 100644
--- a/lttng-abi.c
+++ b/lttng-abi.c
@@ -50,6 +50,10 @@
 #include "lttng-events.h"
 #include "lttng-tracer.h"
 
+/* include our own uevent tracepoint */
+#include "instrumentation/events/lttng-module/lttng.h"
+DEFINE_TRACE(lttng_uevent);
+
 /*
  * This is LTTng's own personal way to create a system call as an external
  * module. We use ioctl() on /proc/lttng.
@@ -252,9 +256,25 @@ long lttng_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	}
 }
 
+/*
+ * lttng_write_uevent - expose kernel tracer to user-space
+ */
+
+static
+ssize_t lttng_write_uevent(struct file *file, const char __user *user_buf,
+		    size_t count, loff_t *fpos)
+{
+	if (count > LTTNG_UEVENT_SIZE)
+		count = LTTNG_UEVENT_SIZE;
+
+	trace_lttng_uevent(user_buf, count);
+	return count;
+}
+
 static const struct file_operations lttng_fops = {
 	.owner = THIS_MODULE,
 	.unlocked_ioctl = lttng_ioctl,
+	.write = lttng_write_uevent,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = lttng_ioctl,
 #endif
diff --git a/lttng-abi.h b/lttng-abi.h
index dc230d8..f99b037 100644
--- a/lttng-abi.h
+++ b/lttng-abi.h
@@ -26,6 +26,7 @@
 #include <linux/fs.h>
 
 #define LTTNG_KERNEL_SYM_NAME_LEN	256
+#define LTTNG_UEVENT_SIZE		1024
 
 enum lttng_kernel_instrumentation {
 	LTTNG_KERNEL_TRACEPOINT	= 0,
-- 
1.7.9.5
