From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH userspace-rcu] Add MIPS support
Date: Tue, 10 Jul 2012 11:10:19 -0400
Message-ID: <20120710151019.GB7990__15634.8455384888$1341933058$gmane$org@Krystal>
References: <CAHfNoqunTWL0YQW8oO1BFtO3nbR6sAMmDCKp0_ET8x-kLn9eJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Soc4y-0000uZ-PQ
	for lttng-dev@lists.lttng.org; Tue, 10 Jul 2012 11:10:20 -0400
Content-Disposition: inline
In-Reply-To: <CAHfNoqunTWL0YQW8oO1BFtO3nbR6sAMmDCKp0_ET8x-kLn9eJg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Ralf Baechle <ralf.baechle@gmail.com>
Cc: lttng-dev@lists.lttng.org, Paul McKenney <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

* Ralf Baechle (ralf.baechle@gmail.com) wrote:
> From: Ralf Baechle <ralf@linux-mips.org>
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Merged as the following commit, thanks !

commit e1259cb17954e4e03954ba7376d3ed61649116cd
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Tue Jul 10 11:03:08 2012 -0400

    Add MIPS support
    
    [ Edit by Mathieu Desnoyers: add explanations about supported
    MIPS architectures, extracted from conversation with Ralf Baechle:
    
    * Supported architectures
    
    Ralf Baechle (edited by Mathieu Desnoyers):
    
    This code works on all MIPS architecture variants.  The memory barrier
    instruction, SYNC, was introduced for MIPS II.  The original MIPS I
    instruction set doesn't have SYNC nor SMP support in the processor
    architecture itself so SMP required horrible kludges in the system
    hardware.  I think it's safe to say that Linux/MIPS will never support
    any of these MIPS I SMP systems.  In the unlikely case this happens
    anyway, we have a (Linux) kernel emulation of the SYNC instruction.
    Voila - full binary compatibility across all MIPS processors and the
    oldest hardware pays the performance penalty.
    
    * Choice of barrier for cmm_mb()/cmm_rmb()/cmm_wmb()
    
    Ralf Baechle:
    "RMI (aka Netlogic and now Broadcom) XLR processor cores can be
    configured to permit LD-LD, LD-ST, ST-LD and ST-ST reordering; default
    is only ST-ST reordering.  To allow Linux to eventually enable full
    reordering cmm_mb(), cmm_rmb() and cmm_wmb() all should perform SYNC
    and a compiler barrier."
    
    * No-op choice for cmm_read_barrier_depends():
    
    Ralf Baechle:
    "Technically there is nothing in the MIPS architecture spec that would
    keep a MIPS implementation from reordering as freely as an Alpha or
    even more liberally.  In practice most do strong ordering.  However
    there is no MIPS implementation that makes full use of all the rope
    provided.  So in theory a paranoid implementation of
    cmm_read_barrier_depends() for MIPS should perform a SYNC.  In reality
    it's not necessary and no sane MIPS core designer would implement
    something that would design a core that need a non-empty
    cmm_read_barrier_depends().  The reason why my patch had an empty one
    is that I was using the Alpha code as a template."
    
    Mathieu Desnoyers:
    Moreover, the Linux kernel chooses a no-op for MIPS
    read_barrier_depends() implementation, so any MIPS architecture that
    would be as weak as Alpha would break the Linux kernel before breaking
    the userspace RCU library.
    
    * No need to put ".set noreorder" in cmm_mb() inline assembly:
    
    Ralf Baechle:
    "Certain instructions such as SYNC won't get reordered." ]
    
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
    CC: Paul McKenney <paulmck@linux.vnet.ibm.com>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

diff --git a/configure.ac b/configure.ac
index 6935939..30fc045 100644
--- a/configure.ac
+++ b/configure.ac
@@ -63,6 +63,7 @@ AS_CASE([$host_cpu],
 	[alpha*], [ARCHTYPE="alpha"],
 	[ia64], [ARCHTYPE="gcc"],
 	[arm*], [ARCHTYPE="arm"],
+	[mips*], [ARCHTYPE="mips"],
 	[ARCHTYPE="unknown"]
 )
 
diff --git a/urcu/arch/mips.h b/urcu/arch/mips.h
new file mode 100644
index 0000000..54c3c52
--- /dev/null
+++ b/urcu/arch/mips.h
@@ -0,0 +1,51 @@
+#ifndef _URCU_ARCH_MIPS_H
+#define _URCU_ARCH_MIPS_H
+
+/*
+ * arch_mips.h: trivial definitions for the MIPS architecture.
+ *
+ * Copyright (c) 2010 Paolo Bonzini <pbonzini@redhat.com>
+ * Copyright (c) 2012 Ralf Baechle <ralf@linux-mips.org>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#include <urcu/compiler.h>
+#include <urcu/config.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define cmm_mb()			__asm__ __volatile__ (		    \
+					"	.set	mips2		\n" \
+					"	sync			\n" \
+					"	.set	mips0		\n" \
+					:::"memory")
+
+typedef unsigned long long cycles_t;
+
+static inline cycles_t caa_get_cycles(void)
+{
+	return 0;	/* not supported */
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#include <urcu/arch/generic.h>
+
+#endif /* _URCU_ARCH_MIPS_H */
diff --git a/urcu/uatomic/mips.h b/urcu/uatomic/mips.h
new file mode 100644
index 0000000..bd7ca7f
--- /dev/null
+++ b/urcu/uatomic/mips.h
@@ -0,0 +1,32 @@
+#ifndef _URCU_UATOMIC_ARCH_MIPS_H
+#define _URCU_UATOMIC_ARCH_MIPS_H
+
+/*
+ * Atomic exchange operations for the MIPS architecture. Let GCC do it.
+ *
+ * Copyright (c) 2010 Paolo Bonzini <pbonzini@redhat.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to
+ * deal in the Software without restriction, including without limitation the
+ * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
+ * sell copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ */
+
+#include <urcu/compiler.h>
+#include <urcu/system.h>
+#include <urcu/uatomic/generic.h>
+
+#endif /* _URCU_UATOMIC_ARCH_MIPS_H */


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
