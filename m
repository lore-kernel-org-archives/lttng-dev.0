From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-modules v2 1/2] Blacklist: kprobe for arm
Date: Thu,  7 Mar 2019 14:57:59 -0500
Message-ID: <20190307195800.17911-1-jonathan.rajotte-julien__17182.6155202993$1551988706$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44FhJN0xKgz1Jc1
 for <lttng-dev@lists.lttng.org>; Thu,  7 Mar 2019 14:58:11 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 11F89B885F
 for <lttng-dev@lists.lttng.org>; Thu,  7 Mar 2019 14:58:11 -0500 (EST)
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

This upstream kernel commit broke optimized kprobe.

commit e46daee53bb50bde38805f1823a182979724c229
Author: Kees Cook <keescook@chromium.org>
Date:   Tue Oct 30 22:12:56 2018 +0100

    ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE

    The arm compiler internally interprets an inline assembly label
    as an unsigned long value, not a pointer. As a result, under
    CONFIG_FORTIFY_SOURCE, the address of a label has a size of 4 bytes,
    which was tripping the runtime checks. Instead, we can just cast the label
    (as done with the size calculations earlier).

    Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1639397

    Reported-by: William Cohen <wcohen@redhat.com>
    Fixes: 6974f0c4555e ("include/linux/string.h: add the option of fortified string.h functions")
    Cc: stable@vger.kernel.org
    Acked-by: Laura Abbott <labbott@redhat.com>
    Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
    Tested-by: William Cohen <wcohen@redhat.com>
    Signed-off-by: Kees Cook <keescook@chromium.org>
    Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

It was introduced in the 4.20 cycle.
It was also backported to the 4.19 and 4.14 branch.

This issue is fixed upstream by [1] and is present in the 5.0 kernel
release.

[1] 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c

The fix was backported to 4.20, 4.19 and 4.14 branch.
It is included starting at:
    v5.0.0
    v4.20.13
    v4.19.26
    v4.14.104

Fixes #1174

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---

v2: Fixed missing subject for commit introducing the issue kernel side.

---
 blacklist/kprobes.h       | 23 +++++++++++++++++++++++
 probes/lttng-kprobes.c    |  1 +
 probes/lttng-kretprobes.c |  1 +
 3 files changed, 25 insertions(+)
 create mode 100644 blacklist/kprobes.h

diff --git a/blacklist/kprobes.h b/blacklist/kprobes.h
new file mode 100644
index 0000000..6c1d7a5
--- /dev/null
+++ b/blacklist/kprobes.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR LGPL-2.1)
+ *
+ * blacklist/kprobes.h
+ *
+ * Blacklist of kernel for buggy kprobes implementation.
+ *
+ * Copyright (C) 2019 Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
+ */
+
+#ifndef _LTTNG_BLACKLIST_KPROBES_H
+#define _LTTNG_BLACKLIST_KPROBES_H
+
+#include <lttng-kernel-version.h>
+
+#if LTTNG_KERNEL_RANGE(4,20,0, 4,20,13) \
+	|| LTTNG_KERNEL_RANGE(4,19,9, 4,19,26) \
+	|| LTTNG_KERNEL_RANGE(4,14,87, 4,14,104)
+# if defined(CONFIG_ARM) && defined(CONFIG_OPTPROBES)
+#  error "Your kernel is known to have buggy optimized kprobes implementation. Fixed by commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c \"ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction\" in Linux. Disable CONFIG_OPTPROBES or upgrade your kernel."
+# endif /* #if defined(CONFIG_ARM) && defined(CONFIG_OPTPROBES) */
+#endif
+
+#endif /* _LTTNG_BLACKLIST_KPROBES_H */
diff --git a/probes/lttng-kprobes.c b/probes/lttng-kprobes.c
index 131333b..c0a15e4 100644
--- a/probes/lttng-kprobes.c
+++ b/probes/lttng-kprobes.c
@@ -15,6 +15,7 @@
 #include <wrapper/vmalloc.h>
 #include <wrapper/irqflags.h>
 #include <lttng-tracer.h>
+#include <blacklist/kprobes.h>
 
 static
 int lttng_kprobes_handler_pre(struct kprobe *p, struct pt_regs *regs)
diff --git a/probes/lttng-kretprobes.c b/probes/lttng-kretprobes.c
index 84eca9b..4b18d46 100644
--- a/probes/lttng-kretprobes.c
+++ b/probes/lttng-kretprobes.c
@@ -16,6 +16,7 @@
 #include <wrapper/vmalloc.h>
 #include <wrapper/irqflags.h>
 #include <lttng-tracer.h>
+#include <blacklist/kprobes.h>
 
 enum lttng_kretprobe_type {
 	EVENT_ENTRY = 0,
-- 
2.17.1
