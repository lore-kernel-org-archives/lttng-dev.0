Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB159C54EE9
	for <lttng-dev@archiver.kernel.org>; Thu,  8 Sep 2022 14:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1662647066;
	bh=XjMWYdyNeLvAi0Y/Jk47poXARcUFd0C7Nwx2g3KuGq4=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=gzQp5Xl50xP++uYshWPIO31hm7+ord3nCWll7hC9DlL9veIk2LmiHLm+k8nGwnij5
	 Ni1HVrW2iaRxAogKciq+YDw1dQm/qFEJ5StMDJvqnZOEvPfpLdtPX8tfF4OOjxohPt
	 qcQ61ZRQcpdPbHJ7ersyaGyILSywKY6yb04c/P3qoubIpp57gsZwUFEL+3Zl9JbajC
	 Z6zQyzMyphzkXs+bz+IfZEW94nZBIH8ADkrx0o5Dj0XcnDkMndikPlA6qnEY+rdp/k
	 ZV7lPMrEePGTiChQRnfJTVEyM7wSybYakZan1xr8KFCbK7T/I+zcPN7lhODSaub0P1
	 kr/1+UnIqSyxg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MNhG10Vqwz20CF;
	Thu,  8 Sep 2022 10:24:25 -0400 (EDT)
Received: from magratgarlick.emantor.de (magratgarlick.emantor.de
 [IPv6:2a01:4f8:c17:c88::2])
 by lists.lttng.org (Postfix) with ESMTPS id 4MNXHq2r7nz1ymw
 for <lttng-dev@lists.lttng.org>; Thu,  8 Sep 2022 04:25:27 -0400 (EDT)
Received: by magratgarlick.emantor.de (Postfix, from userid 114)
 id 0350B96FAA; Thu,  8 Sep 2022 10:25:26 +0200 (CEST)
Received: from localhost (unknown [IPv6:2a0a:edc0:0:701:5806:8e5b:63f4:337d])
 by magratgarlick.emantor.de (Postfix) with ESMTPSA id 2D81C96FA6;
 Thu,  8 Sep 2022 10:25:25 +0200 (CEST)
To: lttng-dev@lists.lttng.org
Cc: Rouven Czerwinski <r.czerwinski@pengutronix.de>
Date: Thu,  8 Sep 2022 10:25:23 +0200
Message-Id: <20220908082523.906444-1-r.czerwinski@pengutronix.de>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 08 Sep 2022 10:24:23 -0400
Subject: [lttng-dev] [PATCH lttng-modules] Add new tracepoints for
 drm_scheduler
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

Allows usage of the drm_gpu_scheduler tracepoints within lttng.

Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
---
 .../events/drm_gpu_scheduler.h                | 63 +++++++++++++++++++
 src/probes/Kbuild                             |  7 +++
 src/probes/lttng-probe-drm-sched.c            | 26 ++++++++
 3 files changed, 96 insertions(+)
 create mode 100644 include/instrumentation/events/drm_gpu_scheduler.h
 create mode 100644 src/probes/lttng-probe-drm-sched.c

diff --git a/include/instrumentation/events/drm_gpu_scheduler.h b/include/instrumentation/events/drm_gpu_scheduler.h
new file mode 100644
index 00000000..d217fcb2
--- /dev/null
+++ b/include/instrumentation/events/drm_gpu_scheduler.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM drm_sched
+
+#if !defined(LTTNG_TRACE_DRM_GPU_SCHEDULER_H) || defined(TRACE_HEADER_MULTI_READ)
+#define LTTNG_TRACE_DRM_GPU_SCHEDULER_H
+
+#include <lttng/tracepoint-event.h>
+
+LTTNG_TRACEPOINT_EVENT_CLASS(drm_sched_class,
+
+	TP_PROTO(struct drm_sched_job *sched_job, struct drm_sched_entity *entity),
+
+	TP_ARGS(sched_job, entity),
+
+	TP_FIELDS(
+		ctf_integer_hex(struct drm_sched_entity *, entity, entity)
+		ctf_integer_hex(struct dma_fence *, fence, &sched_job->s_fence->finished)
+		ctf_string(name, sched_job->sched->name)
+		ctf_integer(uint64_t, id, sched_job->id)
+		ctf_integer(u32, job_count, spsc_queue_count(&entity->job_queue))
+		ctf_integer(int, hw_job_count, atomic_read(&sched_job->sched->hw_rq_count))
+	)
+)
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(drm_sched_class,
+	drm_sched_job,
+	TP_PROTO(struct drm_sched_job *sched_job, struct drm_sched_entity *entity),
+	TP_ARGS(sched_job, entity)
+)
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(drm_sched_class,
+	drm_run_job,
+	TP_PROTO(struct drm_sched_job *sched_job, struct drm_sched_entity *entity),
+	TP_ARGS(sched_job, entity)
+)
+
+LTTNG_TRACEPOINT_EVENT(drm_sched_process_job,
+	TP_PROTO(struct drm_sched_fence *fence),
+	TP_ARGS(fence),
+
+	TP_FIELDS(
+		ctf_integer_hex(struct dma_fence *, fence, &fence->finished)
+	)
+)
+
+LTTNG_TRACEPOINT_EVENT(drm_sched_job_wait_dep,
+	TP_PROTO(struct drm_sched_job *sched_job, struct dma_fence *fence),
+	TP_ARGS(sched_job, fence),
+
+	TP_FIELDS(
+		ctf_string(name, sched_job->sched->name)
+		ctf_integer(uint64_t, id, sched_job->id)
+		ctf_integer_hex(struct dma_fence *, fence, fence)
+		ctf_integer(uint64_t, ctx, fence->context)
+		ctf_integer(unsigned, seqno, fence->seqno)
+	)
+)
+
+#endif /*  LTTNG_TRACE_DRM_SCHED_H */
+
+/* This part must be outside protection */
+#include <lttng/define_trace.h>
diff --git a/src/probes/Kbuild b/src/probes/Kbuild
index 7597389b..2846b0c7 100644
--- a/src/probes/Kbuild
+++ b/src/probes/Kbuild
@@ -104,6 +104,13 @@ ifneq ($(CONFIG_DMA_SHARED_BUFFER),)
       echo "lttng-probe-dma-fence.o" ; fi;)
 endif # CONFIG_DMA_SHARED_BUFFER
 
+ifneq ($(CONFIG_DRM_SCHED),)
+  obj-$(CONFIG_LTTNG) += $(shell \
+    if [ $(VERSION) -ge 5 \
+       -o \( $VERSION -eq 4 -a $(PATCHLEVEL) -ge 16 \) ] ; then \
+      echo "lttng-probe-drm-sched.o" ; fi;)
+endif # CONFIG_DRM_SCHED
+
 ifneq ($(CONFIG_BLOCK),)
   # need blk_cmd_buf_len
   ifneq ($(CONFIG_EVENT_TRACING),)
diff --git a/src/probes/lttng-probe-drm-sched.c b/src/probes/lttng-probe-drm-sched.c
new file mode 100644
index 00000000..fe8f9cb2
--- /dev/null
+++ b/src/probes/lttng-probe-drm-sched.c
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: (GPL-2.0-only or LGPL-2.1-only)
+ *
+ * probes/lttng-probe-drm-sched.c
+ *
+ * LTTng drm-sched probes.
+ *
+ * Copyright (C) 2022 Pengutronix, Rouven Czerwinski <entwicklung@pengutronix.de>
+ */
+#include <drm/gpu_scheduler.h>
+
+/*
+ * Create LTTng tracepoint probes.
+ */
+#define LTTNG_PACKAGE_BUILD
+#define CREATE_TRACE_POINTS
+#define TRACE_INCLUDE_PATH instrumentation/events
+
+#include <instrumentation/events/drm_gpu_scheduler.h>
+
+MODULE_LICENSE("GPL and additional rights");
+MODULE_AUTHOR("Rouven Czerwinski <r.czerwinski@pengutronix.de>");
+MODULE_DESCRIPTION("LTTng drm-gpu-scheduler probes");
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
