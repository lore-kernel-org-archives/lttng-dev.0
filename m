From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules 4/5] Fix: Revert "KVM: MMU: show
 mmu_valid_gen..." (v5.1)
Date: Mon, 18 Mar 2019 16:20:35 -0400
Message-ID: <20190318202036.17523-4-mjeanson__45601.3139382534$1552940586$gmane$org@efficios.com>
References: <20190318202036.17523-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44NSHh1YD0z17Xk
 for <lttng-dev@lists.lttng.org>; Mon, 18 Mar 2019 16:21:04 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 337621C8DA0
 for <lttng-dev@lists.lttng.org>; Mon, 18 Mar 2019 16:21:04 -0400 (EDT)
In-Reply-To: <20190318202036.17523-1-mjeanson@efficios.com>
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

See upstream commit :

  commit b59c4830ca185ba0e9f9e046fb1cd10a4a92627a
  Author: Sean Christopherson <sean.j.christopherson@intel.com>
  Date:   Tue Feb 5 13:01:30 2019 -0800

    Revert "KVM: MMU: show mmu_valid_gen in shadow page related tracepoints"

    ...as part of removing x86 KVM's fast invalidate mechanism, i.e. this
    is one part of a revert all patches from the series that introduced the
    mechanism[1].

    This reverts commit 2248b023219251908aedda0621251cffc548f258.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 .../events/lttng-module/arch/x86/kvm/mmutrace.h        | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/instrumentation/events/lttng-module/arch/x86/kvm/mmutrace.h b/instrumentation/events/lttng-module/arch/x86/kvm/mmutrace.h
index 39ec6a9..e25a774 100644
--- a/instrumentation/events/lttng-module/arch/x86/kvm/mmutrace.h
+++ b/instrumentation/events/lttng-module/arch/x86/kvm/mmutrace.h
@@ -14,7 +14,15 @@
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM kvm_mmu
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5,1,0))
+
+#define LTTNG_KVM_MMU_PAGE_FIELDS \
+	ctf_integer(__u64, gfn, (sp)->gfn) \
+	ctf_integer(__u32, role, (sp)->role.word) \
+	ctf_integer(__u32, root_count, (sp)->root_count) \
+	ctf_integer(bool, unsync, (sp)->unsync)
+
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
 
 #define LTTNG_KVM_MMU_PAGE_FIELDS \
 	ctf_integer(unsigned long, mmu_valid_gen, (sp)->mmu_valid_gen) \
-- 
2.17.1
