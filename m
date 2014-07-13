From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH lttng-modules] Use 3.16
	ktime_get_mono_fast_ns() new API
Date: Sun, 13 Jul 2014 14:15:22 -0400
Message-ID: <1405275322-25572-1-git-send-email-mathieu.desnoyers__2829.88771000436$1405275391$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1X6OJF-00078w-Qy
 for lttng-dev@lists.lttng.org; Sun, 13 Jul 2014 14:15:39 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The new ktime_get_mono_fast_ns() API introduced in kernel 3.16 allows
tracing NMI handlers.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 Makefile              |    2 +-
 wrapper/trace-clock.c |   29 ++++++++++++++
 wrapper/trace-clock.h |  107 +++++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 124 insertions(+), 14 deletions(-)
 create mode 100644 wrapper/trace-clock.c

diff --git a/Makefile b/Makefile
index 606b5ec..9935e15 100644
--- a/Makefile
+++ b/Makefile
@@ -21,7 +21,7 @@ lttng-tracer-objs :=  lttng-events.o lttng-abi.o \
 			lttng-context-vtid.o lttng-context-ppid.o \
 			lttng-context-vppid.o lttng-calibrate.o \
 			lttng-context-hostname.o wrapper/random.o \
-			probes/lttng.o
+			probes/lttng.o wrapper/trace-clock.o
 
 obj-m += lttng-statedump.o
 lttng-statedump-objs := lttng-statedump-impl.o wrapper/irqdesc.o \
diff --git a/wrapper/trace-clock.c b/wrapper/trace-clock.c
new file mode 100644
index 0000000..ac44084
--- /dev/null
+++ b/wrapper/trace-clock.c
@@ -0,0 +1,29 @@
+/*
+ * wrapper/trace-clock.c
+ *
+ * Contains LTTng trace clock mapping to LTTng trace clock or mainline monotonic
+ * clock. This wrapper depends on CONFIG_HIGH_RES_TIMERS=y.
+ *
+ * Copyright (C) 2011-2012 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; only
+ * version 2.1 of the License.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#include "trace-clock.h"
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0))
+DEFINE_PER_CPU(local_t, lttng_last_tsc);
+EXPORT_PER_CPU_SYMBOL(lttng_last_tsc);
+#endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)) */
diff --git a/wrapper/trace-clock.h b/wrapper/trace-clock.h
index 9c0c806..68df48d 100644
--- a/wrapper/trace-clock.h
+++ b/wrapper/trace-clock.h
@@ -32,7 +32,9 @@
 #include <linux/ktime.h>
 #include <linux/time.h>
 #include <linux/hrtimer.h>
+#include <linux/percpu.h>
 #include <linux/version.h>
+#include <asm/local.h>
 #include "../lttng-kernel-version.h"
 #include "random.h"
 
@@ -40,6 +42,88 @@
 #error "Linux kernels 3.10 and 3.11 introduce a deadlock in the timekeeping subsystem. Fixed by commit 7bd36014460f793c19e7d6c94dab67b0afcfcb7f \"timekeeping: Fix HRTICK related deadlock from ntp lock changes\" in Linux."
 #endif
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0))
+
+DECLARE_PER_CPU(local_t, lttng_last_tsc);
+
+#if (BITS_PER_LONG == 32)
+/*
+ * Fixup "src_now" using the 32 LSB from "last". We need to handle overflow and
+ * underflow of the 32nd bit. "last" can be above, below or equal to the 32 LSB
+ * of "src_now".
+ */
+static inline u64 trace_clock_fixup(u64 src_now, u32 last)
+{
+	u64 now;
+
+	now = src_now & 0xFFFFFFFF00000000ULL;
+	now |= (u64) last;
+	/* Detect overflow or underflow between now and last. */
+	if ((src_now & 0x80000000U) && !(last & 0x80000000U)) {
+		/*
+		 * If 32nd bit transitions from 1 to 0, and we move forward in
+		 * time from "now" to "last", then we have an overflow.
+		 */
+		if (((s32) now - (s32) last) < 0)
+			now += 0x0000000100000000ULL;
+	} else if (!(src_now & 0x80000000U) && (last & 0x80000000U)) {
+		/*
+		 * If 32nd bit transitions from 0 to 1, and we move backward in
+		 * time from "now" to "last", then we have an underflow.
+		 */
+		if (((s32) now - (s32) last) > 0)
+			now -= 0x0000000100000000ULL;
+	}
+	return now;
+}
+#else /* #if (BITS_PER_LONG == 32) */
+/*
+ * The fixup is pretty easy on 64-bit architectures: "last" is a 64-bit
+ * value, so we can use last directly as current time.
+ */
+static inline u64 trace_clock_fixup(u64 src_now, unsigned long last)
+{
+	return (u64) last;
+}
+#endif /* #else #if (BITS_PER_LONG == 32) */
+
+/*
+ * Always called with preemption disabled. Can be interrupted.
+ */
+static inline u64 trace_clock_monotonic_wrapper(void)
+{
+	u64 now;
+	unsigned long last, result;
+	local_t *last_tsc;
+
+	/* Use fast nmi-safe monotonic clock provided by the Linux kernel. */
+	last_tsc = &__get_cpu_var(lttng_last_tsc);
+	last = local_read(last_tsc);
+	/*
+	 * Read "last" before "now". It is not strictly required, but it ensures
+	 * that an interrupt coming in won't artificially trigger a case where
+	 * "now" < "last". This kind of situation should only happen if the
+	 * mono_fast time source goes slightly backwards.
+	 */
+	barrier();
+	now = ktime_get_mono_fast_ns();
+	if (((long) now - (long) last) < 0)
+		now = trace_clock_fixup(now, last);
+	result = local_cmpxchg(last_tsc, last, (unsigned long) now);
+	if (result == last) {
+		/* Update done. */
+		return now;
+	} else {
+		/*
+		 * Update not done, due to concurrent update. We can use
+		 * "result", since it has been sampled concurrently with our
+		 * time read, so it should not be far from "now".
+		 */
+		return trace_clock_fixup(now, result);
+	}
+}
+
+#else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)) */
 static inline u64 trace_clock_monotonic_wrapper(void)
 {
 	ktime_t ktime;
@@ -54,6 +138,7 @@ static inline u64 trace_clock_monotonic_wrapper(void)
 	ktime = ktime_get();
 	return ktime_to_ns(ktime);
 }
+#endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)) */
 
 static inline u32 trace_clock_read32(void)
 {
@@ -75,23 +160,19 @@ static inline int trace_clock_uuid(char *uuid)
 	return wrapper_get_bootid(uuid);
 }
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0))
 static inline int get_trace_clock(void)
 {
-	/*
-	 * LTTng: Using mainline kernel monotonic clock. NMIs will not be
-	 * traced, and expect significant performance degradation compared to
-	 * the LTTng trace clocks. Integration of the LTTng 0.x trace clocks
-	 * into LTTng 2.0 is planned in a near future.
-	 */
-	printk(KERN_WARNING "LTTng: Using mainline kernel monotonic clock.\n");
-	printk(KERN_WARNING "  * NMIs will not be traced,\n");
-	printk(KERN_WARNING "  * expect significant performance degradation compared to the\n");
-	printk(KERN_WARNING "    LTTng trace clocks.\n");
-	printk(KERN_WARNING "Integration of the LTTng 0.x trace clocks into LTTng 2.0 is planned\n");
-	printk(KERN_WARNING "in a near future.\n");
-
+	printk(KERN_WARNING "LTTng: Using mainline kernel monotonic fast clock, which is NMI-safe.\n");
+	return 0;
+}
+#else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)) */
+static inline int get_trace_clock(void)
+{
+	printk(KERN_WARNING "LTTng: Using mainline kernel monotonic clock. NMIs will not be traced.\n");
 	return 0;
 }
+#endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)) */
 
 static inline void put_trace_clock(void)
 {
-- 
1.7.10.4
