From: Mohamad Gebai <mohamad.gebai@gmail.com>
Subject: [PATCH lttng-modules 1/1] Add new tracepoint in KVM.
Date: Thu,  3 Oct 2013 00:11:23 -0400
Message-ID: <1380773483-9088-1-git-send-email-mohamad.gebai__23596.3317369626$1380773581$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f41.google.com ([209.85.128.41])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mohamad.gebai@gmail.com>) id 1VRaGz-00018G-61
	for lttng-dev@lists.lttng.org; Thu, 03 Oct 2013 00:12:21 -0400
Received: by mail-qe0-f41.google.com with SMTP id 1so1343454qee.14
	for <lttng-dev@lists.lttng.org>; Wed, 02 Oct 2013 21:12:15 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Mohamad Gebai <mohamad.gebai@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

New tracepoint added in kvm: kvm_write_tsc_offset.

Signed-off-by: Mohamad Gebai <mohamad.gebai@polymtl.ca>
---
 .../events/lttng-module/arch/x86/kvm/trace.h       |   21 ++++++++++++++++++++
 .../events/mainline/arch/x86/kvm/trace.h           |   21 ++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/instrumentation/events/lttng-module/arch/x86/kvm/trace.h b/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
index 8e71a7f..0823a9d 100644
--- a/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
+++ b/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
@@ -761,6 +761,27 @@ TRACE_EVENT(
 		  __entry->gpa_match ? "GPA" : "GVA")
 )
 
+TRACE_EVENT(kvm_write_tsc_offset,
+	TP_PROTO(unsigned int vcpu_id, __u64 previous_tsc_offset,
+		 __u64 next_tsc_offset),
+	TP_ARGS(vcpu_id, previous_tsc_offset, next_tsc_offset),
+
+	TP_STRUCT__entry(
+		__field( unsigned int,	vcpu_id				)
+		__field(	__u64,	previous_tsc_offset		)
+		__field(	__u64,	next_tsc_offset			)
+	),
+
+	TP_fast_assign(
+		tp_assign(vcpu_id, vcpu_id)
+		tp_assign(previous_tsc_offset, previous_tsc_offset)
+		tp_assign(next_tsc_offset, next_tsc_offset)
+	),
+
+	TP_printk("vcpu=%u prev=%llu next=%llu", __entry->vcpu_id,
+		  __entry->previous_tsc_offset, __entry->next_tsc_offset)
+)
+
 #ifdef CONFIG_X86_64
 
 #define host_clocks					\
diff --git a/instrumentation/events/mainline/arch/x86/kvm/trace.h b/instrumentation/events/mainline/arch/x86/kvm/trace.h
index fe5e00e..545245d 100644
--- a/instrumentation/events/mainline/arch/x86/kvm/trace.h
+++ b/instrumentation/events/mainline/arch/x86/kvm/trace.h
@@ -756,6 +756,27 @@ TRACE_EVENT(
 		  __entry->gpa_match ? "GPA" : "GVA")
 );
 
+TRACE_EVENT(kvm_write_tsc_offset,
+	TP_PROTO(unsigned int vcpu_id, __u64 previous_tsc_offset,
+		 __u64 next_tsc_offset),
+	TP_ARGS(vcpu_id, previous_tsc_offset, next_tsc_offset),
+
+	TP_STRUCT__entry(
+		__field( unsigned int,	vcpu_id				)
+		__field(	__u64,	previous_tsc_offset		)
+		__field(	__u64,	next_tsc_offset			)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_id		= vcpu_id;
+		__entry->previous_tsc_offset	= previous_tsc_offset;
+		__entry->next_tsc_offset	= next_tsc_offset;
+	),
+
+	TP_printk("vcpu=%u prev=%llu next=%llu", __entry->vcpu_id,
+		  __entry->previous_tsc_offset, __entry->next_tsc_offset)
+);
+
 #ifdef CONFIG_X86_64
 
 #define host_clocks					\
-- 
1.7.10.4
