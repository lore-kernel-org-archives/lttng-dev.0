Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2213CC47DDB
	for <lttng-dev@archiver.kernel.org>; Fri, 26 Jan 2024 17:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1706289523;
	bh=NouLWjDNovb1shTizuxaQm/7TTWcp+/wVzfvzZKADSs=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=iEUFN7lKY80WkYsErNT6kXP28Z9KbzMCS+FW/kDasm9ULy0DYHIUhNInpFtq1X4Ll
	 x2Jt5dU9KzlYBWAhNC+63JRt7L/oChKvtRsxUqCcNoEl9oplo+36f2LQaQZtyixyYb
	 ZZl9aiu+4P8hr5WWgXXbbOMbmObUO8gJcYOaHlvgdKunvfl7w62MFGhi6Bo1q7o925
	 dfeQ4o1zP8toaza/PwIEHB4XuairM7WenxM6Y3V711ekGCehUY/2gphT3blGdArvpr
	 G1Ja4vU3SkrkOWGRV4wvrwMOW0y6JRIURm0OAkT2qOXtQTRg/4v167OesgHfqAk0ge
	 RATFfW++Sn7rg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TM4D20SSWz1mXb;
	Fri, 26 Jan 2024 12:18:42 -0500 (EST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 by lists.lttng.org (Postfix) with ESMTPS id 4TM4Cz6wftz1mbN
 for <lttng-dev@lists.lttng.org>; Fri, 26 Jan 2024 12:18:38 -0500 (EST)
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-42a49d42f06so3603661cf.2
 for <lttng-dev@lists.lttng.org>; Fri, 26 Jan 2024 09:18:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706289517; x=1706894317;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jM4koSiU+BBtA6jU4NMshv+nTnFqTI8xjMAiVfChLfM=;
 b=BKmeM0YHLuR3zgPPoXIeeHO4dxpYAMqwTHlc/GKrhYFRXjOUud/aPtCDHlnumpVjpW
 UMlYZ/Bf9ujQ4LipKdyhIN7h+7kqopfnoueENYC0qtnCoy8/Nk9rM2hOKluShL9sIKwp
 V+43o5VSfcg+a2Y/m3td4As14385zs8+gumUc1NDyVuaLK5NmhIzc6AEpUSBfl8deL61
 VGRlEcsG50ntDARdryGk6IK1LsOKKwad21lA8tBW9bVNCXmlXGaWyUrWBc2LGUzvr+RK
 f5Aogvbnj3jHq/bIpba76IYz3vKgxviyGF13bajy3tcJisqKsujO9Q8psLoDVl7fKfbr
 K+lw==
X-Gm-Message-State: AOJu0YwbfWV5QxMng9PssOWY3i2C6a4zLaoy9gzxnsbiq5PhNT2P3l0f
 5W7iFOfzTPsOZgNfSkHFQp6LAU8ZJodTJ9eyHMAUOMgxkHWXyCTKo6zbnmk58lXpITAMqg/f3L9
 bS0g=
X-Google-Smtp-Source: AGHT+IGbw4ubtwLWqqQ6wb4IdxU+cRC7IQyB1N0+t1mIROI/0j5Y4VmTrYNddh+egbrW2phn6IaqHw==
X-Received: by 2002:ad4:5fc9:0:b0:686:ac63:ef34 with SMTP id
 jq9-20020ad45fc9000000b00686ac63ef34mr205626qvb.8.1706289517388; 
 Fri, 26 Jan 2024 09:18:37 -0800 (PST)
Received: from newton ([72.53.240.227]) by smtp.gmail.com with ESMTPSA id
 nh10-20020a056214390a00b00686a22aeafasm671885qvb.18.2024.01.26.09.18.36
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 09:18:36 -0800 (PST)
Date: Fri, 26 Jan 2024 12:18:33 -0500
To: lttng-dev@lists.lttng.org
Message-ID: <20240126171833.cppkzs4pl2f4scf6@newton>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [lttng-dev] [PATCH] Compile fixes for RHEL 9.3 kernels
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
From: Martin Hicks via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Martin Hicks <martin@sr-research.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>


I'm not sure when some of these changes were backported, but the
unmodified lttng-modules compiles vs. 5.14.0-162.23.1

This disables the kmem and compaction modules.  I don't believe getting
these to compile will be easy, as the required struct declarations are
in vmlinux.h, and haven't been moved into mm/internal.h and mm/slab.h in
the RHEL sources.

Signed-off-by: Martin Hicks <martin@sr-research.com>
---
 include/instrumentation/events/compaction.h |  3 ++-
 include/instrumentation/events/jbd2.h       |  3 ++-
 include/instrumentation/events/kmem.h       | 12 +++++++++---
 include/instrumentation/events/skb.h        |  3 ++-
 include/wrapper/kprobes.h                   |  3 ++-
 src/lttng-statedump-impl.c                  |  3 ++-
 src/probes/Kbuild                           |  6 ++++--
 7 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/instrumentation/events/compaction.h b/include/instrumentation/events/compaction.h
index 31d0a422..7d0c2623 100644
--- a/include/instrumentation/events/compaction.h
+++ b/include/instrumentation/events/compaction.h
@@ -54,7 +54,8 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(compaction_isolate_template,
 	TP_ARGS(start_pfn, end_pfn, nr_scanned, nr_taken)
 )
 
-#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(5,18,0))
+#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(5,18,0) || \
+    LTTNG_RHEL_KERNEL_RANGE(5,14,0,163,0,0, 5,15,0,0,0,0))
 LTTNG_TRACEPOINT_EVENT_MAP(mm_compaction_migratepages,
 
 	compaction_migratepages,
diff --git a/include/instrumentation/events/jbd2.h b/include/instrumentation/events/jbd2.h
index b00777fa..eccac06d 100644
--- a/include/instrumentation/events/jbd2.h
+++ b/include/instrumentation/events/jbd2.h
@@ -237,7 +237,8 @@ LTTNG_TRACEPOINT_EVENT(jbd2_update_log_tail,
 	)
 )
 
-#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,0,0))
+#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,0,0) || \
+     LTTNG_RHEL_KERNEL_RANGE(5,14,0,163,0,0, 5,15,0,0,0,0))
 
 #ifdef CONFIG_LTTNG_EXPERIMENTAL_BITWISE_ENUM
 LTTNG_TRACEPOINT_ENUM(req_op,
diff --git a/include/instrumentation/events/kmem.h b/include/instrumentation/events/kmem.h
index dd22192f..f2e2d11d 100644
--- a/include/instrumentation/events/kmem.h
+++ b/include/instrumentation/events/kmem.h
@@ -61,7 +61,9 @@ LTTNG_TRACEPOINT_EVENT(kmem_cache_alloc,
 			(s->flags & SLAB_ACCOUNT)) : false)
 	)
 )
-#elif (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,0,0))
+#elif (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,0,0) || \
+	LTTNG_RHEL_KERNEL_RANGE(5,14,0,163,0,0, 5,15,0,0,0,0))
+
 LTTNG_TRACEPOINT_EVENT_CLASS(kmem_alloc,
 
 	TP_PROTO(unsigned long call_site,
@@ -141,7 +143,9 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(kmem_alloc, kmem_cache_alloc,
 )
 #endif
 
-#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,0,0))
+#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,0,0) || \
+	LTTNG_RHEL_KERNEL_RANGE(5,14,0,163,0,0, 5,15,0,0,0,0))
+
 LTTNG_TRACEPOINT_EVENT_CLASS(kmem_alloc_node,
 
 	TP_PROTO(unsigned long call_site,
@@ -359,7 +363,9 @@ LTTNG_TRACEPOINT_EVENT_MAP(mm_page_alloc, kmem_mm_page_alloc,
 	)
 )
 
-#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(5,19,0))
+#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(5,19,0) || \
+	LTTNG_RHEL_KERNEL_RANGE(5,14,0,163,0,0, 5,15,0,0,0,0))
+
 LTTNG_TRACEPOINT_EVENT_CLASS(kmem_mm_page,
 
 	TP_PROTO(struct page *page, unsigned int order, int migratetype,
diff --git a/include/instrumentation/events/skb.h b/include/instrumentation/events/skb.h
index 08704b98..9e32aa6e 100644
--- a/include/instrumentation/events/skb.h
+++ b/include/instrumentation/events/skb.h
@@ -77,7 +77,8 @@ LTTNG_TRACEPOINT_EVENT_MAP(kfree_skb,
 )
 #endif
 
-#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,3,0))
+#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,3,0) || \
+    LTTNG_RHEL_KERNEL_RANGE(5,14,0,163,0,0, 5,15,0,0,0,0))
 LTTNG_TRACEPOINT_EVENT_MAP(consume_skb,
 
 	skb_consume,
diff --git a/include/wrapper/kprobes.h b/include/wrapper/kprobes.h
index 51d32b7c..d906bcba 100644
--- a/include/wrapper/kprobes.h
+++ b/include/wrapper/kprobes.h
@@ -30,7 +30,8 @@ struct kretprobe *lttng_get_kretprobe(struct kretprobe_instance *ri)
 #endif /* LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(5,11,0) */
 
 
-#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(5,18,0))
+#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(5,18,0) || \
+    LTTNG_RHEL_KERNEL_RANGE(5,14,0,163,0,0, 5,15,0,0,0,0))
 static inline
 unsigned long lttng_get_kretprobe_retaddr(struct kretprobe_instance *ri)
 {
diff --git a/src/lttng-statedump-impl.c b/src/lttng-statedump-impl.c
index 22e3628b..0b09027a 100644
--- a/src/lttng-statedump-impl.c
+++ b/src/lttng-statedump-impl.c
@@ -191,7 +191,8 @@ enum lttng_process_status {
 };
 
 
-#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,0,0))
+#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,0,0) || \
+    LTTNG_RHEL_KERNEL_RANGE(5,14,0,163,0,0, 5,15,0,0,0,0))
 
 #define LTTNG_PART_STRUCT_TYPE struct block_device
 
diff --git a/src/probes/Kbuild b/src/probes/Kbuild
index 73a15844..71ad8e4c 100644
--- a/src/probes/Kbuild
+++ b/src/probes/Kbuild
@@ -15,7 +15,8 @@ kmem_dep = $(srctree)/mm/slab.h
 kmem_dep_wildcard = $(wildcard $(kmem_dep))
 kmem_dep_check = $(shell \
 if [ \( $(VERSION) -ge 7 \
-   -o \( $(VERSION) -eq 6 -a $(PATCHLEVEL) -ge 0 \) \) -a \
+   -o \( $(VERSION) -eq 6 -a $(PATCHLEVEL) -ge 0 \) \
+   -o \( $(RHEL_API_VERSION) -gt 1622301 \) \) -a \
    -z "$(kmem_dep_wildcard)" ] ; then \
   echo "warn" ; \
 else \
@@ -166,7 +167,8 @@ ifneq ($(CONFIG_COMPACTION),)
   compaction_dep_wildcard = $(wildcard $(compaction_dep))
   compaction_dep_check = $(shell \
   if [ \( $(VERSION) -ge 6 \
-     -o \( $(VERSION) -eq 5 -a $(PATCHLEVEL) -ge 18 \) \) -a \
+     -o \( $(VERSION) -eq 5 -a $(PATCHLEVEL) -ge 18 \) \
+     -o \( $(RHEL_API_VERSION) -gt 1622301 \) \) -a \
      -z "$(compaction_dep_wildcard)" ] ; then \
     echo "warn" ; \
   else \
-- 
2.39.3

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
