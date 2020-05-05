From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Subject: [PATCH lttng-modules] Unbreak LTTng for kernel 5.7
Date: Tue,  5 May 2020 09:25:50 -0400
Message-ID: <20200505132550.24537-1-mathieu.desnoyers@efficios.com>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49GgV41fKbz1qmt
 for <lttng-dev@lists.lttng.org>; Tue,  5 May 2020 09:26:20 -0400 (EDT)
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, rostedt@goodmis.org, Alexei Starovoitov <ast@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, akpm@linux-foundation.org
List-Id: lttng-dev@lists.lttng.org

Linux commit 0bd476e6c67190b5eb7b6e105c8db8ff61103281 ("kallsyms:
unexport kallsyms_lookup_name() and kallsyms_on_each_symbol()") breaks
LTTng-modules by removing symbols used by the LTTng-modules out-of-tree
tracer.

I pointed this out when the change was originally considered before the
5.7 merge window. This generated some discussion but it did not lead to
any concrete proposal to fix the issue. [1]

The commit has been merged in the 5.7 merge window. At that point, as
maintainer of LTTng, I immediately raised a flag about this issue,
proposing an alternative approach to solve this: expose the few symbols
needed by LTTng to GPL modules. This was NACKed on the ground that the
Linux kernel cannot export GPL symbols when there are no in-tree
users. [2]

Steven Rostedt has shown interest in merging LTTng-modules upstream.
LTTng-modules being LGPL, this is very much doable. I have prepared a
tree of LTTng-modules "for upstreaming" and sent it to him privately so
he can review it. Even if in an ideal scenario LTTng-modules is merged
for the following merge window, it leaves LTTng-modules broken on the
5.7 kernel.

In order to ensure that the LTTng-modules kernel tracer continues working
for my end users on kernels 5.7 onwards, as a very last resort, this is
with great reluctance that I created this fix for LTTng modules. It
basically uses kprobes to lookup the kallsyms_lookup_name symbol, and
continues using kallsyms_lookup_name as before.

Link: https://lore.kernel.org/r/20200302192811.n6o5645rsib44vco@localhost [1]
Link: https://lore.kernel.org/r/20200409193543.18115-1-mathieu.desnoyers@efficios.com [2]
Link: https://lwn.net/Articles/817988/
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Will Deacon <will@kernel.org>
CC: akpm@linux-foundation.org
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>
CC: rostedt@goodmis.org
CC: Alexei Starovoitov <ast@kernel.org>
---
 Makefile           |  1 +
 README.md          |  1 +
 wrapper/kallsyms.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++
 wrapper/kallsyms.h | 20 +++++++++++--
 4 files changed, 90 insertions(+), 2 deletions(-)
 create mode 100644 wrapper/kallsyms.c

diff --git a/Makefile b/Makefile
index c977996..6e6c2fe 100644
--- a/Makefile
+++ b/Makefile
@@ -77,6 +77,7 @@ ifneq ($(KERNELRELEASE),)
   lttng-wrapper-objs := wrapper/page_alloc.o \
                         wrapper/random.o \
                         wrapper/trace-clock.o \
+                        wrapper/kallsyms.o \
                         wrapper/irqdesc.o \
                         wrapper/fdtable.o \
                         lttng-wrapper-impl.o
diff --git a/README.md b/README.md
index 450f363..7b04cd8 100644
--- a/README.md
+++ b/README.md
@@ -66,6 +66,7 @@ Make sure your target kernel has the following config options enabled:
   - `CONFIG_TRACEPOINTS`: kernel tracepoint instrumentation
      (enabled as a side-effect of any of the perf/ftrace/blktrace
      instrumentation features).
+  - `CONFIG_KPROBES` (5.7+): use kallsyms for kernel 5.7 and newer.
 
 
 ### Supported (optional) kernel config options
diff --git a/wrapper/kallsyms.c b/wrapper/kallsyms.c
new file mode 100644
index 0000000..6af77f5
--- /dev/null
+++ b/wrapper/kallsyms.c
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR LGPL-2.1-only)
+ *
+ * wrapper/kallsyms.c
+ *
+ * Wrapper around kallsyms. Using kprobes to get its address when available.
+ *
+ * Can we mainline LTTng already so we don't have to waste our time doing this
+ * kind of hack ?
+ *
+ * Copyright (C) 2020 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#include <linux/kprobes.h>
+#include <linux/module.h>
+#include <wrapper/kallsyms.h>
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5,7,0))
+
+#ifndef CONFIG_KPROBES
+# error "LTTng-modules requires CONFIG_KPROBES on kernels >= 5.7.0"
+#endif
+
+static
+unsigned long (*kallsyms_lookup_name_sym)(const char *name);
+
+static
+int dummy_kprobe_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	return 0;
+}
+
+static
+unsigned long do_get_kallsyms(void)
+{
+	struct kprobe probe;
+	int ret;
+	unsigned long addr;
+
+	memset(&probe, 0, sizeof(probe));
+	probe.pre_handler = dummy_kprobe_handler;
+	probe.symbol_name = "kallsyms_lookup_name";
+	ret = register_kprobe(&probe);
+	if (ret)
+		return 0;
+	addr = (unsigned long)probe.addr;
+#ifdef CONFIG_ARM
+#ifdef CONFIG_THUMB2_KERNEL
+	if (addr)
+		addr |= 1; /* set bit 0 in address for thumb mode */
+#endif
+#endif
+	unregister_kprobe(&probe);
+	return addr;
+}
+
+unsigned long wrapper_kallsyms_lookup_name(const char *name)
+{
+	if (!kallsyms_lookup_name_sym) {
+		kallsyms_lookup_name_sym = (void *)do_get_kallsyms();
+	}
+	if (kallsyms_lookup_name_sym)
+		return kallsyms_lookup_name_sym(name);
+	else {
+		printk_once(KERN_WARNING "LTTng requires kallsyms_lookup_name\n");
+		return 0;
+	}
+}
+EXPORT_SYMBOL_GPL(wrapper_kallsyms_lookup_name);
+
+#endif
diff --git a/wrapper/kallsyms.h b/wrapper/kallsyms.h
index 0e4fcee..7f4d830 100644
--- a/wrapper/kallsyms.h
+++ b/wrapper/kallsyms.h
@@ -14,6 +14,7 @@
 #define _LTTNG_WRAPPER_KALLSYMS_H
 
 #include <linux/kallsyms.h>
+#include <linux/version.h>
 
 /*
  * PowerPC ABIv1 needs KALLSYMS_ALL to get the function descriptor,
@@ -25,12 +26,26 @@
 # endif
 #endif
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5,7,0))
+
+unsigned long wrapper_kallsyms_lookup_name(const char *name);
+
+#else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(5,7,0)) */
+
+static inline
+unsigned long wrapper_kallsyms_lookup_name(const char *name)
+{
+	return kallsyms_lookup_name(name);
+}
+
+#endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(5,7,0)) */
+
 static inline
 unsigned long kallsyms_lookup_funcptr(const char *name)
 {
 	unsigned long addr;
 
-	addr = kallsyms_lookup_name(name);
+	addr = wrapper_kallsyms_lookup_name(name);
 #ifdef CONFIG_ARM
 #ifdef CONFIG_THUMB2_KERNEL
 	if (addr)
@@ -43,6 +58,7 @@ unsigned long kallsyms_lookup_funcptr(const char *name)
 static inline
 unsigned long kallsyms_lookup_dataptr(const char *name)
 {
-	return kallsyms_lookup_name(name);
+	return wrapper_kallsyms_lookup_name(name);
 }
+
 #endif /* _LTTNG_WRAPPER_KALLSYMS_H */
-- 
2.17.1
