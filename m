From: Tony Jones <tonyj@suse.de>
Subject: [PATCH lttng-modules] correctly version kvm events to
 build against v3.0 kernel
Date: Fri, 21 Feb 2014 12:17:28 -0800
Message-ID: <5307B458.6000007__17594.7801945314$1393013926$gmane$org@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <tonyj@suse.de>) id 1WGwXN-0000Wc-PS
	for lttng-dev@lists.lttng.org; Fri, 21 Feb 2014 15:17:42 -0500
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

Cleanly build against v3.0 kernel.  I didn't add versioning for mainline commit 0d460ffc as it's build compatible.

Signed-off-by: Tony Jones <tonyj@suse.de>
---

diff --git a/instrumentation/events/lttng-module/arch/x86/kvm/trace.h b/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
index 5eec169..7fc1f9c 100644
--- a/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
+++ b/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
@@ -4,7 +4,9 @@
 #include <linux/tracepoint.h>
 #include <asm/vmx.h>
 #include <asm/svm.h>
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0))
 #include <asm/clocksource.h>
+#endif
 #include <linux/version.h>
 #include <../arch/x86/kvm/lapic.h>
 #include <../arch/x86/kvm/kvm_cache_regs.h>
@@ -714,13 +716,23 @@ TRACE_EVENT(kvm_emulate_insn,
 		),
 
 	TP_fast_assign(
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0))
+		tp_assign(rip, vcpu->arch.emulate_ctxt.decode.fetch.start)
+	  	tp_assign(csbase, kvm_x86_ops->get_segment_base(vcpu, VCPU_SREG_CS))
+		tp_assign(len, vcpu->arch.emulate_ctxt.decode.eip
+			       - vcpu->arch.emulate_ctxt.decode.fetch.start)
+		tp_memcpy(insn,
+		       vcpu->arch.emulate_ctxt.decode.fetch.data,
+		       15)
+#else
 		tp_assign(rip, vcpu->arch.emulate_ctxt.fetch.start)
-	  tp_assign(csbase, kvm_x86_ops->get_segment_base(vcpu, VCPU_SREG_CS))
+	  	tp_assign(csbase, kvm_x86_ops->get_segment_base(vcpu, VCPU_SREG_CS))
 		tp_assign(len, vcpu->arch.emulate_ctxt._eip
 			       - vcpu->arch.emulate_ctxt.fetch.start)
 		tp_memcpy(insn,
 		       vcpu->arch.emulate_ctxt.fetch.data,
 		       15)
+#endif
 		tp_assign(flags, kei_decode_mode(vcpu->arch.emulate_ctxt.mode))
 		tp_assign(failed, failed)
 		),
@@ -784,6 +796,7 @@ TRACE_EVENT(kvm_write_tsc_offset,
 )
 #endif
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0))
 #ifdef CONFIG_X86_64
 
 #define host_clocks					\
@@ -844,6 +857,7 @@ TRACE_EVENT(kvm_track_tsc,
 )
 
 #endif /* CONFIG_X86_64 */
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0) */
 
 #endif /* _TRACE_KVM_H */
