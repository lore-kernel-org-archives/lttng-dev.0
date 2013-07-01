From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: [LTTng-module PATCH 2/3] Point the x86-64 overrides to
	newly extracted 3.10-rc7 files
Date: Mon,  1 Jul 2013 12:37:15 -0400
Message-ID: <1372696636-5173-2-git-send-email-yannick.brosseau__40458.8802521632$1373040802$gmane$org@gmail.com>
References: <1372696636-5173-1-git-send-email-yannick.brosseau@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1Uv8ct-0006RL-F8
	for lttng-dev@lists.lttng.org; Fri, 05 Jul 2013 12:12:51 -0400
Received: by mail-ob0-f173.google.com with SMTP id wc20so3074054obb.32
	for <lttng-dev@lists.lttng.org>; Fri, 05 Jul 2013 09:12:46 -0700 (PDT)
In-Reply-To: <1372696636-5173-1-git-send-email-yannick.brosseau@gmail.com>
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
 instrumentation/syscalls/headers/syscalls_integers.h       |    2 +-
 instrumentation/syscalls/headers/syscalls_pointers.h       |    2 +-
 .../headers/x86-64-syscalls-3.0.4_integers_override.h      |    3 ---
 .../headers/x86-64-syscalls-3.0.4_pointers_override.h      |   12 ------------
 .../headers/x86-64-syscalls-3.10.0-rc7_integers_override.h |    3 +++
 .../headers/x86-64-syscalls-3.10.0-rc7_pointers_override.h |   12 ++++++++++++
 6 files changed, 17 insertions(+), 17 deletions(-)
 delete mode 100644 instrumentation/syscalls/headers/x86-64-syscalls-3.0.4_integers_override.h
 delete mode 100644 instrumentation/syscalls/headers/x86-64-syscalls-3.0.4_pointers_override.h
 create mode 100644 instrumentation/syscalls/headers/x86-64-syscalls-3.10.0-rc7_integers_override.h
 create mode 100644 instrumentation/syscalls/headers/x86-64-syscalls-3.10.0-rc7_pointers_override.h

diff --git a/instrumentation/syscalls/headers/syscalls_integers.h b/instrumentation/syscalls/headers/syscalls_integers.h
index 6a42909..ce0409f 100644
--- a/instrumentation/syscalls/headers/syscalls_integers.h
+++ b/instrumentation/syscalls/headers/syscalls_integers.h
@@ -1,5 +1,5 @@
 #ifdef CONFIG_X86_64
-#include "x86-64-syscalls-3.0.4_integers.h"
+#include "x86-64-syscalls-3.10.0-rc7_integers.h"
 #endif
 
 #ifdef CONFIG_X86_32
diff --git a/instrumentation/syscalls/headers/syscalls_pointers.h b/instrumentation/syscalls/headers/syscalls_pointers.h
index d78b036..f5ca566 100644
--- a/instrumentation/syscalls/headers/syscalls_pointers.h
+++ b/instrumentation/syscalls/headers/syscalls_pointers.h
@@ -1,5 +1,5 @@
 #ifdef CONFIG_X86_64
-#include "x86-64-syscalls-3.0.4_pointers.h"
+#include "x86-64-syscalls-3.10.0-rc7_pointers.h"
 #endif
 
 #ifdef CONFIG_X86_32
diff --git a/instrumentation/syscalls/headers/x86-64-syscalls-3.0.4_integers_override.h b/instrumentation/syscalls/headers/x86-64-syscalls-3.0.4_integers_override.h
deleted file mode 100644
index 5f971e7..0000000
--- a/instrumentation/syscalls/headers/x86-64-syscalls-3.0.4_integers_override.h
+++ /dev/null
@@ -1,3 +0,0 @@
-/*
- * this is a place-holder for x86_64 integer syscall definition override.
- */
diff --git a/instrumentation/syscalls/headers/x86-64-syscalls-3.0.4_pointers_override.h b/instrumentation/syscalls/headers/x86-64-syscalls-3.0.4_pointers_override.h
deleted file mode 100644
index 8aa2abc..0000000
--- a/instrumentation/syscalls/headers/x86-64-syscalls-3.0.4_pointers_override.h
+++ /dev/null
@@ -1,12 +0,0 @@
-#ifndef CREATE_SYSCALL_TABLE
-
-#else	/* CREATE_SYSCALL_TABLE */
-
-#define OVERRIDE_TABLE_64_sys_clone
-TRACE_SYSCALL_TABLE(sys_clone, sys_clone, 56, 5)
-#define OVERRIDE_TABLE_64_sys_execve
-TRACE_SYSCALL_TABLE(sys_execve, sys_execve, 59, 3)
-#define OVERRIDE_TABLE_64_sys_getcpu
-TRACE_SYSCALL_TABLE(sys_getcpu, sys_getcpu, 309, 3)
-
-#endif /* CREATE_SYSCALL_TABLE */
diff --git a/instrumentation/syscalls/headers/x86-64-syscalls-3.10.0-rc7_integers_override.h b/instrumentation/syscalls/headers/x86-64-syscalls-3.10.0-rc7_integers_override.h
new file mode 100644
index 0000000..5f971e7
--- /dev/null
+++ b/instrumentation/syscalls/headers/x86-64-syscalls-3.10.0-rc7_integers_override.h
@@ -0,0 +1,3 @@
+/*
+ * this is a place-holder for x86_64 integer syscall definition override.
+ */
diff --git a/instrumentation/syscalls/headers/x86-64-syscalls-3.10.0-rc7_pointers_override.h b/instrumentation/syscalls/headers/x86-64-syscalls-3.10.0-rc7_pointers_override.h
new file mode 100644
index 0000000..8aa2abc
--- /dev/null
+++ b/instrumentation/syscalls/headers/x86-64-syscalls-3.10.0-rc7_pointers_override.h
@@ -0,0 +1,12 @@
+#ifndef CREATE_SYSCALL_TABLE
+
+#else	/* CREATE_SYSCALL_TABLE */
+
+#define OVERRIDE_TABLE_64_sys_clone
+TRACE_SYSCALL_TABLE(sys_clone, sys_clone, 56, 5)
+#define OVERRIDE_TABLE_64_sys_execve
+TRACE_SYSCALL_TABLE(sys_execve, sys_execve, 59, 3)
+#define OVERRIDE_TABLE_64_sys_getcpu
+TRACE_SYSCALL_TABLE(sys_getcpu, sys_getcpu, 309, 3)
+
+#endif /* CREATE_SYSCALL_TABLE */
-- 
1.7.10.4
