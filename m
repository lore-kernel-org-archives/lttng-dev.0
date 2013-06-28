From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: [LTTng-module PATCH] Update prink:console tracepoint
	for 3.10 kernel
Date: Fri, 28 Jun 2013 01:14:29 -0400
Message-ID: <1372396469-23371-1-git-send-email-yannick.brosseau__26703.2707379714$1372448266$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1UseTp-0007c5-Qj
	for lttng-dev@lists.lttng.org; Fri, 28 Jun 2013 15:37:13 -0400
Received: by mail-oa0-f50.google.com with SMTP id k7so2748661oag.37
	for <lttng-dev@lists.lttng.org>; Fri, 28 Jun 2013 12:37:08 -0700 (PDT)
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

Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
---
 instrumentation/events/lttng-module/printk.h |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/instrumentation/events/lttng-module/printk.h b/instrumentation/events/lttng-module/printk.h
index 4c744f9..16f5716 100644
--- a/instrumentation/events/lttng-module/printk.h
+++ b/instrumentation/events/lttng-module/printk.h
@@ -9,6 +9,31 @@
 
 #define MSG_TRACE_MAX_LEN	2048
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0))
+TRACE_EVENT(console,
+        TP_PROTO(const char *text, size_t len),
+
+        TP_ARGS(text, len),
+
+        TP_STRUCT__entry(
+                __dynamic_array_text(char, msg, min_t(unsigned, len, MSG_TRACE_MAX_LEN))
+        ),
+
+        TP_fast_assign(
+                tp_memcpy_dyn(msg,
+                        ({
+                                char lmsg[MSG_TRACE_MAX_LEN + 1];
+				unsigned start = 0;
+                                if (len > MSG_TRACE_MAX_LEN) {
+                                        start = len - MSG_TRACE_MAX_LEN;
+					len = MSG_TRACE_MAX_LEN;
+				}
+                                memcpy(lmsg, text + start, len);
+                                lmsg[len] = 0;
+                                lmsg;
+                        })
+                )
+#else
 TRACE_EVENT_CONDITION(console,
 	TP_PROTO(const char *log_buf, unsigned start, unsigned end,
 		 unsigned log_buf_len),
@@ -54,6 +79,7 @@ TRACE_EVENT_CONDITION(console,
 				lmsg;
 			})
 		)
+#endif
 	),
 
 	TP_printk("%s", __get_str(msg))
-- 
1.7.10.4
