From: Lars Persson <lars.persson@axis.com>
Subject: [PATCH lttng-modules] Move pipe override to the arch
	specific pointers_override.h
Date: Tue,  8 Sep 2015 15:20:15 +0200
Message-ID: <1441718415-23808-1-git-send-email-larper__2524.16157532043$1441718484$gmane$org@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from bastet.se.axis.com ([195.60.68.11])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <lars.persson@axis.com>) id 1ZZIp5-0006tp-Lv
 for lttng-dev@lists.lttng.org; Tue, 08 Sep 2015 09:20:33 -0400
Received: from localhost (localhost [127.0.0.1])
 by bastet.se.axis.com (Postfix) with ESMTP id 5746F181C3
 for <lttng-dev@lists.lttng.org>; Tue,  8 Sep 2015 15:20:23 +0200 (CEST)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 08TlE9KeWS4c for <lttng-dev@lists.lttng.org>;
 Tue,  8 Sep 2015 15:20:22 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
 by bastet.se.axis.com (Postfix) with ESMTP id 7EA50180D8
 for <lttng-dev@lists.lttng.org>; Tue,  8 Sep 2015 15:20:22 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id 5A5E012B9
 for <lttng-dev@lists.lttng.org>; Tue,  8 Sep 2015 15:20:22 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
 by boulder.se.axis.com (Postfix) with ESMTP id 456BABFE
 for <lttng-dev@lists.lttng.org>; Tue,  8 Sep 2015 15:20:22 +0200 (CEST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Lars Persson <larper@axis.com>
List-Id: lttng-dev@lists.lttng.org

The MIPS architecture has a non-standard calling convention for pipe()
and cannot use the provided override for the pipe event.

Signed-off-by: Lars Persson <larper@axis.com>
---
 .../headers/arm-32-syscalls-3.4.25_pointers_override.h         |  9 +++++++++
 .../headers/powerpc-32-syscalls-3.0.34_pointers_override.h     |  9 +++++++++
 instrumentation/syscalls/headers/syscalls_pointers_override.h  | 10 ----------
 .../headers/x86-32-syscalls-3.1.0-rc6_pointers_override.h      | 10 ++++++++++
 .../headers/x86-64-syscalls-3.10.0-rc7_pointers_override.h     |  9 +++++++++
 5 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/instrumentation/syscalls/headers/arm-32-syscalls-3.4.25_pointers_override.h b/instrumentation/syscalls/headers/arm-32-syscalls-3.4.25_pointers_override.h
index d515e1d..b27eedb 100644
--- a/instrumentation/syscalls/headers/arm-32-syscalls-3.4.25_pointers_override.h
+++ b/instrumentation/syscalls/headers/arm-32-syscalls-3.4.25_pointers_override.h
@@ -18,6 +18,15 @@ SC_LTTNG_TRACEPOINT_EVENT(mmap2,
 	)
 )
 
+#define OVERRIDE_32_pipe
+SC_LTTNG_TRACEPOINT_EVENT(pipe,
+	TP_PROTO(sc_exit(long ret,) int * fildes),
+	TP_ARGS(sc_exit(ret,) fildes),
+	TP_FIELDS(sc_exit(ctf_integer(long, ret, ret))
+		sc_out(ctf_user_array(int, fildes, fildes, 2))
+	)
+)
+
 #else	/* CREATE_SYSCALL_TABLE */
 
 #define OVERRIDE_TABLE_32_execve
diff --git a/instrumentation/syscalls/headers/powerpc-32-syscalls-3.0.34_pointers_override.h b/instrumentation/syscalls/headers/powerpc-32-syscalls-3.0.34_pointers_override.h
index b9e83bc..1fd3ec4 100644
--- a/instrumentation/syscalls/headers/powerpc-32-syscalls-3.0.34_pointers_override.h
+++ b/instrumentation/syscalls/headers/powerpc-32-syscalls-3.0.34_pointers_override.h
@@ -16,6 +16,15 @@ SC_LTTNG_TRACEPOINT_EVENT(mmap2,
 	)
 )
 
+#define OVERRIDE_32_pipe
+SC_LTTNG_TRACEPOINT_EVENT(pipe,
+	TP_PROTO(sc_exit(long ret,) int * fildes),
+	TP_ARGS(sc_exit(ret,) fildes),
+	TP_FIELDS(sc_exit(ctf_integer(long, ret, ret))
+		sc_out(ctf_user_array(int, fildes, fildes, 2))
+	)
+)
+
 #else	/* CREATE_SYSCALL_TABLE */
 
 #define OVERRIDE_TABLE_32_execve
diff --git a/instrumentation/syscalls/headers/syscalls_pointers_override.h b/instrumentation/syscalls/headers/syscalls_pointers_override.h
index a552908..c9478f4 100644
--- a/instrumentation/syscalls/headers/syscalls_pointers_override.h
+++ b/instrumentation/syscalls/headers/syscalls_pointers_override.h
@@ -41,16 +41,6 @@ SC_LTTNG_TRACEPOINT_EVENT(getcpu,
 	)
 )
 
-#define OVERRIDE_32_pipe
-#define OVERRIDE_64_pipe
-SC_LTTNG_TRACEPOINT_EVENT(pipe,
-	TP_PROTO(sc_exit(long ret,) int * fildes),
-	TP_ARGS(sc_exit(ret,) fildes),
-	TP_FIELDS(sc_exit(ctf_integer(long, ret, ret))
-		sc_out(ctf_user_array(int, fildes, fildes, 2))
-	)
-)
-
 #define OVERRIDE_32_pipe2
 #define OVERRIDE_64_pipe2
 SC_LTTNG_TRACEPOINT_EVENT(pipe2,
diff --git a/instrumentation/syscalls/headers/x86-32-syscalls-3.1.0-rc6_pointers_override.h b/instrumentation/syscalls/headers/x86-32-syscalls-3.1.0-rc6_pointers_override.h
index 05c8e21..7c804a6 100644
--- a/instrumentation/syscalls/headers/x86-32-syscalls-3.1.0-rc6_pointers_override.h
+++ b/instrumentation/syscalls/headers/x86-32-syscalls-3.1.0-rc6_pointers_override.h
@@ -10,6 +10,16 @@
 #  define OVERRIDE_32_chown16
 # endif
 
+#define OVERRIDE_32_pipe
+#define OVERRIDE_64_pipe
+SC_LTTNG_TRACEPOINT_EVENT(pipe,
+    TP_PROTO(sc_exit(long ret,) int * fildes),
+    TP_ARGS(sc_exit(ret,) fildes),
+    TP_FIELDS(sc_exit(ctf_integer(long, ret, ret))
+        sc_out(ctf_user_array(int, fildes, fildes, 2))
+    )
+)
+
 #else	/* CREATE_SYSCALL_TABLE */
 
 # ifndef CONFIG_UID16
diff --git a/instrumentation/syscalls/headers/x86-64-syscalls-3.10.0-rc7_pointers_override.h b/instrumentation/syscalls/headers/x86-64-syscalls-3.10.0-rc7_pointers_override.h
index af519cd..702cfb5 100644
--- a/instrumentation/syscalls/headers/x86-64-syscalls-3.10.0-rc7_pointers_override.h
+++ b/instrumentation/syscalls/headers/x86-64-syscalls-3.10.0-rc7_pointers_override.h
@@ -106,6 +106,15 @@ SC_LTTNG_TRACEPOINT_EVENT_CODE(accept,
 	)
 )
 
+#define OVERRIDE_64_pipe
+SC_LTTNG_TRACEPOINT_EVENT(pipe,
+	TP_PROTO(sc_exit(long ret,) int * fildes),
+	TP_ARGS(sc_exit(ret,) fildes),
+	TP_FIELDS(sc_exit(ctf_integer(long, ret, ret))
+		sc_out(ctf_user_array(int, fildes, fildes, 2))
+	)
+)
+
 #else	/* CREATE_SYSCALL_TABLE */
 
 #define OVERRIDE_TABLE_64_clone
-- 
2.1.4
