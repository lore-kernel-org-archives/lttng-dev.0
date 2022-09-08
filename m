Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C49C38145
	for <lttng-dev@archiver.kernel.org>; Thu,  8 Sep 2022 14:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1662647071;
	bh=A1FqS7eXfCpfdCt9C1DwFvmPdiLr0uDraeu4iDgdx0k=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=nhoP7BcLQyBYDX4XrcRPNas10T5UFNPJX6GjbNW+TdLRdN4T7rvCR20UIvcwamrp9
	 h1QzGpPduQhPaoBfdM8a5FffXL4ujTWMtdyNr/lurDdQ4L+QDH+sNCAKK4+BeuZVJP
	 308Qvu23FIix5QXWY/t6Sja4xeXJFLkJs9xVaoZmhNdCFt11bEVKgb8/1Jogi/+SeH
	 Pi00AlvDBW/ntbAuH+wSAXpMASb+XfxKswJN3ee62XsuLG3wMRc9C6emWya1R2Tq6q
	 JugcEpeSN2iSRrN7G4mUajslraZfZDkFq1CwY7lupOCm1/q5IhTi/3kHT2tjx+ryHi
	 9mNQcZf2ffc2A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MNhG70dFQz20Lk;
	Thu,  8 Sep 2022 10:24:31 -0400 (EDT)
Received: from magratgarlick.emantor.de (magratgarlick.emantor.de
 [78.46.208.201])
 by lists.lttng.org (Postfix) with ESMTPS id 4MNXPC5Plxz20J1
 for <lttng-dev@lists.lttng.org>; Thu,  8 Sep 2022 04:30:07 -0400 (EDT)
Received: by magratgarlick.emantor.de (Postfix, from userid 114)
 id 2BEF696FA7; Thu,  8 Sep 2022 10:24:16 +0200 (CEST)
Received: from localhost (unknown [IPv6:2a0a:edc0:0:701:5806:8e5b:63f4:337d])
 by magratgarlick.emantor.de (Postfix) with ESMTPSA id 61DF696FA5;
 Thu,  8 Sep 2022 10:24:15 +0200 (CEST)
To: lttng-dev@lists.lttng.org
Cc: Rouven Czerwinski <r.czerwinski@pengutronix.de>
Date: Thu,  8 Sep 2022 10:23:51 +0200
Message-Id: <20220908082351.906021-1-r.czerwinski@pengutronix.de>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 08 Sep 2022 10:24:23 -0400
Subject: [lttng-dev] [PATCH lttng-modules] Add new tracepoints for dma_fence
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Rouven Czerwinski via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Rouven Czerwinski <r.czerwinski@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Allows usage of dma_fence tracepoints from lttng.

Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
---
 include/instrumentation/events/dma_fence.h | 83 ++++++++++++++++++++++
 src/probes/Kbuild                          |  7 ++
 src/probes/lttng-probe-dma-fence.c         | 32 +++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 include/instrumentation/events/dma_fence.h
 create mode 100644 src/probes/lttng-probe-dma-fence.c

diff --git a/include/instrumentation/events/dma_fence.h b/include/instrumentation/events/dma_fence.h
new file mode 100644
index 00000000..95d94ed5
--- /dev/null
+++ b/include/instrumentation/events/dma_fence.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM dma_fence
+
+#if !defined(LTTNG_TRACE_DMA_FENCE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define LTTNG_TRACE_DMA_FENCE_H
+
+#include <lttng/tracepoint-event.h>
+
+LTTNG_TRACEPOINT_EVENT_CLASS(dma_fence_class,
+
+	TP_PROTO(struct dma_fence *fence),
+
+	TP_ARGS(fence),
+
+	TP_FIELDS(
+		ctf_string(driver, fence->ops->get_driver_name(fence))
+		ctf_string(timeline, fence->ops->get_timeline_name(fence))
+		ctf_integer(unsigned int, context, fence->context)
+		ctf_integer(unsigned int, seqno, fence->seqno)
+	)
+)
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(dma_fence_class,
+	dma_fence_emit,
+
+	TP_PROTO(struct dma_fence *fence),
+
+	TP_ARGS(fence)
+)
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(dma_fence_class,
+	dma_fence_init,
+
+	TP_PROTO(struct dma_fence *fence),
+
+	TP_ARGS(fence)
+)
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(dma_fence_class,
+	dma_fence_destroy,
+
+	TP_PROTO(struct dma_fence *fence),
+
+	TP_ARGS(fence)
+)
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(dma_fence_class,
+	dma_fence_enable_signal,
+
+	TP_PROTO(struct dma_fence *fence),
+
+	TP_ARGS(fence)
+)
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(dma_fence_class,
+	dma_fence_signaled,
+
+	TP_PROTO(struct dma_fence *fence),
+
+	TP_ARGS(fence)
+)
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(dma_fence_class,
+	dma_fence_wait_start,
+
+	TP_PROTO(struct dma_fence *fence),
+
+	TP_ARGS(fence)
+)
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(dma_fence_class,
+	dma_fence_wait_end,
+
+	TP_PROTO(struct dma_fence *fence),
+
+	TP_ARGS(fence)
+)
+
+#endif /*  LTTNG_TRACE_DMA_FENCE_H */
+
+/* This part must be outside protection */
+#include <lttng/define_trace.h>
diff --git a/src/probes/Kbuild b/src/probes/Kbuild
index aa002534..7597389b 100644
--- a/src/probes/Kbuild
+++ b/src/probes/Kbuild
@@ -97,6 +97,13 @@ endif # CONFIG_X86
 
 obj-$(CONFIG_LTTNG) += lttng-probe-signal.o
 
+ifneq ($(CONFIG_DMA_SHARED_BUFFER),)
+  obj-$(CONFIG_LTTNG) += $(shell \
+    if [ $(VERSION) -ge 5 \
+       -o \( $VERSION -eq 4 -a $(PATCHLEVEL) -ge 9 \) ] ; then \
+      echo "lttng-probe-dma-fence.o" ; fi;)
+endif # CONFIG_DMA_SHARED_BUFFER
+
 ifneq ($(CONFIG_BLOCK),)
   # need blk_cmd_buf_len
   ifneq ($(CONFIG_EVENT_TRACING),)
diff --git a/src/probes/lttng-probe-dma-fence.c b/src/probes/lttng-probe-dma-fence.c
new file mode 100644
index 00000000..a6c9cd12
--- /dev/null
+++ b/src/probes/lttng-probe-dma-fence.c
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: (GPL-2.0-only or LGPL-2.1-only)
+ *
+ * probes/lttng-probe-dma-fence.c
+ *
+ * LTTng dma-fence probes.
+ *
+ * Copyright (C) 2022 Pengutronix, Rouven Czerwinski <entwicklung@pengutronix.de>
+ */
+
+#include <linux/dma-fence.h>
+/*
+ * Create the tracepoint static inlines from the kernel to validate that our
+ * trace event macros match the kernel we run on.
+ */
+#include <trace/events/dma_fence.h>
+
+/*
+ * Create LTTng tracepoint probes.
+ */
+#define LTTNG_PACKAGE_BUILD
+#define CREATE_TRACE_POINTS
+#define TRACE_INCLUDE_PATH instrumentation/events
+
+#include <instrumentation/events/dma_fence.h>
+
+MODULE_LICENSE("GPL and additional rights");
+MODULE_AUTHOR("Rouven Czerwinski <r.czerwinski@pengutronix.de>");
+MODULE_DESCRIPTION("LTTng dma-fence probes");
+MODULE_VERSION(__stringify(LTTNG_MODULES_MAJOR_VERSION) "."
+	__stringify(LTTNG_MODULES_MINOR_VERSION) "."
+	__stringify(LTTNG_MODULES_PATCHLEVEL_VERSION)
+	LTTNG_MODULES_EXTRAVERSION);
-- 
2.37.2

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
