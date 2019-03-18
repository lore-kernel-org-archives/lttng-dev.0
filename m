From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules 1/5] Fix: mm: create the new
 vm_fault_t type (v5.1)
Date: Mon, 18 Mar 2019 16:20:32 -0400
Message-ID: <20190318202036.17523-1-mjeanson__24219.5179381937$1552940484$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44NSHf4D4Zz17XM
 for <lttng-dev@lists.lttng.org>; Mon, 18 Mar 2019 16:21:02 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id F1B821C8D5D
 for <lttng-dev@lists.lttng.org>; Mon, 18 Mar 2019 16:21:00 -0400 (EDT)
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

See upstream commit:

  commit 3d3539018d2cbd12e5af4a132636ee7fd8d43ef0
  Author: Souptick Joarder <jrdr.linux@gmail.com>
  Date:   Thu Mar 7 16:31:14 2019 -0800

    mm: create the new vm_fault_t type

    Page fault handlers are supposed to return VM_FAULT codes, but some
    drivers/file systems mistakenly return error numbers.  Now that all
    drivers/file systems have been converted to use the vm_fault_t return
    type, change the type definition to no longer be compatible with 'int'.
    By making it an unsigned int, the function prototype becomes
    incompatible with a function which returns int.  Sparse will detect any
    attempts to return a value which is not a VM_FAULT code.

    VM_FAULT_SET_HINDEX and VM_FAULT_GET_HINDEX values are changed to avoid
    conflict with other VM_FAULT codes.
---
 lib/ringbuffer/ring_buffer_mmap.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/ringbuffer/ring_buffer_mmap.c b/lib/ringbuffer/ring_buffer_mmap.c
index 30dd93e..fab9458 100644
--- a/lib/ringbuffer/ring_buffer_mmap.c
+++ b/lib/ringbuffer/ring_buffer_mmap.c
@@ -20,7 +20,11 @@
 /*
  * fault() vm_op implementation for ring buffer file mapping.
  */
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5,1,0))
+static vm_fault_t lib_ring_buffer_fault_compat(struct vm_area_struct *vma, struct vm_fault *vmf)
+#else
 static int lib_ring_buffer_fault_compat(struct vm_area_struct *vma, struct vm_fault *vmf)
+#endif
 {
 	struct lib_ring_buffer *buf = vma->vm_private_data;
 	struct channel *chan = buf->backend.chan;
@@ -53,7 +57,13 @@ static int lib_ring_buffer_fault_compat(struct vm_area_struct *vma, struct vm_fa
 	return 0;
 }
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,11,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5,1,0))
+static vm_fault_t lib_ring_buffer_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	return lib_ring_buffer_fault_compat(vma, vmf);
+}
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(4,11,0))
 static int lib_ring_buffer_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
-- 
2.17.1
