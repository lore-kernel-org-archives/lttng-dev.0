Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48CCC00144
	for <lttng-dev@archiver.kernel.org>; Mon,  1 Aug 2022 14:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1659364635;
	bh=wmsBzpxgsVYwGcOsDNuFI4b0u+MhKadqbFC9GGSb+hc=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=pG+q+N1dzlPPLIeFvmhtKx95rz/GGjWP2W/mH5/uMsaYGLwGGZfF1rBwoZyB+2fSS
	 z8JdQurAPpYVo5wPYuTKHx1GEy278g7Sq3xzg/tJvPtcSjOpplIqbHma6raeTR9LI3
	 coJD+oicNA6ljOcz7Dy0ifCTFDyAd5yAP1aam0kfLMaaO+F3ARJz62sSfyliyFvesA
	 yJVRLtFw0BmjRMRqdEMVtyA6w4fpmgK0+rozv3HCFq4v/K514td8yPy6z/6FvV+UwC
	 FWhY3c+ot+U76UTWEuyewUbjLmWoeg/Te7F4FXCEiZA7UcT2iL3JB1BDFL3gST7eDg
	 oJDRtREnedgPA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LxLLM2VBdz11CW;
	Mon,  1 Aug 2022 10:37:15 -0400 (EDT)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by lists.lttng.org (Postfix) with ESMTPS id 4LxLLK6bYsz11GB
 for <lttng-dev@lists.lttng.org>; Mon,  1 Aug 2022 10:37:13 -0400 (EDT)
Received: by mail-wr1-x431.google.com with SMTP id q30so9964877wra.11
 for <lttng-dev@lists.lttng.org>; Mon, 01 Aug 2022 07:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tU7WW2WpwAASn5QtLmbwC8jmGL+V1qKBKhPzj0QMxdI=;
 b=Rp2CyiN5yxPrVeTnsV0WozbyCQr/YUp4qkIKVXsVA7WVHm4oDKRgvrS9nrKmeCjvJR
 0asyLuGkojK7yCZ/KnVBDwfe/ExLK2pUS0Tfr8cdACEbKv0OICFJMRdeapYDvoQyBp74
 dYAtO7CjYhyFlvEw+TdMyvAoC9aVnh6gpzO0Cd/p4EK/Bdr0DanN2/NNq3tyicGkvytx
 wFquEMGA9+o6BIjLNzhm4oALoY7883exz1Jdbr2MatwgsJIujlEpXuNeWSfCukZhBWV3
 JM9yBxzqnEbbShRyRKckqIAHCPSsuWO68VoaeFdPvEjFdYxcgazYtWgajBx5qv3eadzL
 hpDw==
X-Gm-Message-State: ACgBeo1WOV9N84F0pA//rtKsGWdVISRw8stmV180XZATt4IxLSrRJS9s
 gtxYp7M/1bMrOUtfU8wT5f5zqdbuJQA=
X-Google-Smtp-Source: AA6agR7ltVD2eeugWIZxMprlaK+RKWZ/d9F8YB9kufNkLpjX/Qx3sluGy+pfMoiMXsH6gZJPOeFJFQ==
X-Received: by 2002:a05:6000:1686:b0:220:66b1:d897 with SMTP id
 y6-20020a056000168600b0022066b1d897mr2181048wrd.653.1659364632499; 
 Mon, 01 Aug 2022 07:37:12 -0700 (PDT)
Received: from lano-work.. ([80.120.136.76]) by smtp.gmail.com with ESMTPSA id
 p18-20020a5d4592000000b0021f73c66198sm7912500wrq.1.2022.08.01.07.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Aug 2022 07:37:12 -0700 (PDT)
X-Google-Original-From: Norbert Lange <norbert.lange@andritz.com>
To: lttng-dev@lists.lttng.org
Date: Mon,  1 Aug 2022 16:36:59 +0200
Message-Id: <20220801143700.160380-1-norbert.lange@andritz.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH v2 1/2] lttng_ust_init_thread: initialise cached
 context values
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
From: Norbert Lange via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Norbert Lange <nolange79@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

From: Norbert Lange <nolange79@gmail.com>

Modify all relevant *_alloc_tls functions so that they take
flags for 'init'. Rename them to init_thread for consistency.

So far define one flag LTTNG_UST_INIT_THREAD_CONTEXT_CACHE,
this will warm up cached values so less is done during
the first tracepoint.

The function 'lttng_ust_init_thread' will use all available
flags, software can opt-in to do work early instead
of lazily during tracepoints.

Signed-off-by: Norbert Lange <nolange79@gmail.com>
---
v1 -> v2:

*   instead of a bool, use a flag variable
*   try to improve consistency for some funciton names

v1:

*   see https://lore.kernel.org/all/CADYdroN3=pAe66crtsVT9aHE4T+bT61-tvHFKCuwZYkHhuyFjw@mail.gmail.com/
*   Will update docs after review, and do some more tests
    during the week
---
 src/lib/lttng-ust/lttng-context-cgroup-ns.c   |  4 ++-
 src/lib/lttng-ust/lttng-context-ipc-ns.c      |  4 ++-
 src/lib/lttng-ust/lttng-context-net-ns.c      |  4 ++-
 .../lttng-ust/lttng-context-perf-counters.c   |  3 +-
 src/lib/lttng-ust/lttng-context-procname.c    |  4 ++-
 src/lib/lttng-ust/lttng-context-provider.c    |  4 +--
 src/lib/lttng-ust/lttng-context-time-ns.c     |  4 ++-
 src/lib/lttng-ust/lttng-context-uts-ns.c      |  4 ++-
 src/lib/lttng-ust/lttng-context-vtid.c        |  4 ++-
 src/lib/lttng-ust/lttng-probes.c              |  4 +--
 src/lib/lttng-ust/lttng-tracer-core.h         | 26 ++++++++------
 src/lib/lttng-ust/lttng-ust-comm.c            | 34 +++++++++----------
 src/lib/lttng-ust/lttng-ust-statedump.c       |  2 +-
 13 files changed, 61 insertions(+), 40 deletions(-)

diff --git a/src/lib/lttng-ust/lttng-context-cgroup-ns.c b/src/lib/lttng-ust/lttng-context-cgroup-ns.c
index 34523ea1..5accd2df 100644
--- a/src/lib/lttng-ust/lttng-context-cgroup-ns.c
+++ b/src/lib/lttng-ust/lttng-context-cgroup-ns.c
@@ -155,7 +155,9 @@ error_find_context:
 /*
  * Force a read (imply TLS allocation for dlopen) of TLS variables.
  */
-void lttng_cgroup_ns_alloc_tls(void)
+void lttng_ust_cgroup_ns_init_thread(int flags)
 {
 	asm volatile ("" : : "m" (URCU_TLS(cached_cgroup_ns)));
+	if (flags & LTTNG_UST_INIT_THREAD_CONTEXT_CACHE)
+		(void)get_cgroup_ns();
 }
diff --git a/src/lib/lttng-ust/lttng-context-ipc-ns.c b/src/lib/lttng-ust/lttng-context-ipc-ns.c
index 63401e8d..078e6461 100644
--- a/src/lib/lttng-ust/lttng-context-ipc-ns.c
+++ b/src/lib/lttng-ust/lttng-context-ipc-ns.c
@@ -153,7 +153,9 @@ error_find_context:
 /*
  * Force a read (imply TLS allocation for dlopen) of TLS variables.
  */
-void lttng_ipc_ns_alloc_tls(void)
+void lttng_ust_ipc_ns_init_thread(int flags)
 {
 	asm volatile ("" : : "m" (URCU_TLS(cached_ipc_ns)));
+	if (flags & LTTNG_UST_INIT_THREAD_CONTEXT_CACHE)
+		(void)get_ipc_ns();
 }
diff --git a/src/lib/lttng-ust/lttng-context-net-ns.c b/src/lib/lttng-ust/lttng-context-net-ns.c
index 960591c2..66fcb045 100644
--- a/src/lib/lttng-ust/lttng-context-net-ns.c
+++ b/src/lib/lttng-ust/lttng-context-net-ns.c
@@ -153,7 +153,9 @@ error_find_context:
 /*
  * Force a read (imply TLS allocation for dlopen) of TLS variables.
  */
-void lttng_net_ns_alloc_tls(void)
+void lttng_ust_net_ns_init_thread(int flags)
 {
 	asm volatile ("" : : "m" (URCU_TLS(cached_net_ns)));
+	if (flags & LTTNG_UST_INIT_THREAD_CONTEXT_CACHE)
+		(void)get_net_ns();
 }
diff --git a/src/lib/lttng-ust/lttng-context-perf-counters.c b/src/lib/lttng-ust/lttng-context-perf-counters.c
index 2db11436..52371a0d 100644
--- a/src/lib/lttng-ust/lttng-context-perf-counters.c
+++ b/src/lib/lttng-ust/lttng-context-perf-counters.c
@@ -87,9 +87,10 @@ static DEFINE_URCU_TLS(int, ust_perf_mutex_nest);
 /*
  * Force a read (imply TLS allocation for dlopen) of TLS variables.
  */
-void lttng_ust_perf_counter_alloc_tls(void)
+void lttng_ust_perf_counter_init_thread(int flags)
 {
 	asm volatile ("" : : "m" (URCU_TLS(ust_perf_mutex_nest)));
+	(void)flags;
 }
 
 void lttng_perf_lock(void)
diff --git a/src/lib/lttng-ust/lttng-context-procname.c b/src/lib/lttng-ust/lttng-context-procname.c
index b5bf77be..16f34c46 100644
--- a/src/lib/lttng-ust/lttng-context-procname.c
+++ b/src/lib/lttng-ust/lttng-context-procname.c
@@ -122,7 +122,9 @@ error_find_context:
 /*
  * Force a read (imply TLS allocation for dlopen) of TLS variables.
  */
-void lttng_procname_alloc_tls(void)
+void lttng_ust_procname_init_thread(int flags)
 {
 	asm volatile ("" : : "m" (URCU_TLS(cached_procname)[0]));
+	if (flags & LTTNG_UST_INIT_THREAD_CONTEXT_CACHE)
+		(void)wrapper_getprocname();
 }
diff --git a/src/lib/lttng-ust/lttng-context-provider.c b/src/lib/lttng-ust/lttng-context-provider.c
index 4e7e429f..5000657d 100644
--- a/src/lib/lttng-ust/lttng-context-provider.c
+++ b/src/lib/lttng-ust/lttng-context-provider.c
@@ -67,7 +67,7 @@ struct lttng_ust_registered_context_provider *lttng_ust_context_provider_registe
 	size_t name_len = strlen(provider->name);
 	uint32_t hash;
 
-	lttng_ust_alloc_tls();
+	lttng_ust_common_init_thread(0);
 
 	/* Provider name starts with "$app.". */
 	if (strncmp("$app.", provider->name, strlen("$app.")) != 0)
@@ -101,7 +101,7 @@ end:
 
 void lttng_ust_context_provider_unregister(struct lttng_ust_registered_context_provider *reg_provider)
 {
-	lttng_ust_alloc_tls();
+	lttng_ust_common_init_thread(0);
 
 	if (ust_lock())
 		goto end;
diff --git a/src/lib/lttng-ust/lttng-context-time-ns.c b/src/lib/lttng-ust/lttng-context-time-ns.c
index ec32a1de..e84b7048 100644
--- a/src/lib/lttng-ust/lttng-context-time-ns.c
+++ b/src/lib/lttng-ust/lttng-context-time-ns.c
@@ -152,7 +152,9 @@ error_find_context:
 /*
  * Force a read (imply TLS allocation for dlopen) of TLS variables.
  */
-void lttng_time_ns_alloc_tls(void)
+void lttng_ust_time_ns_init_thread(int flags)
 {
 	asm volatile ("" : : "m" (URCU_TLS(cached_time_ns)));
+	if (flags & LTTNG_UST_INIT_THREAD_CONTEXT_CACHE)
+		(void)get_time_ns();
 }
diff --git a/src/lib/lttng-ust/lttng-context-uts-ns.c b/src/lib/lttng-ust/lttng-context-uts-ns.c
index 06a978fd..51d6092e 100644
--- a/src/lib/lttng-ust/lttng-context-uts-ns.c
+++ b/src/lib/lttng-ust/lttng-context-uts-ns.c
@@ -154,7 +154,9 @@ error_find_context:
 /*
  * Force a read (imply TLS allocation for dlopen) of TLS variables.
  */
-void lttng_uts_ns_alloc_tls(void)
+void lttng_ust_uts_ns_init_thread(int flags)
 {
 	asm volatile ("" : : "m" (URCU_TLS(cached_uts_ns)));
+	if (flags & LTTNG_UST_INIT_THREAD_CONTEXT_CACHE)
+		(void)get_uts_ns();
 }
diff --git a/src/lib/lttng-ust/lttng-context-vtid.c b/src/lib/lttng-ust/lttng-context-vtid.c
index 880e34b9..e9bbbf85 100644
--- a/src/lib/lttng-ust/lttng-context-vtid.c
+++ b/src/lib/lttng-ust/lttng-context-vtid.c
@@ -112,7 +112,9 @@ error_find_context:
 /*
  * Force a read (imply TLS allocation for dlopen) of TLS variables.
  */
-void lttng_vtid_alloc_tls(void)
+void lttng_ust_vtid_init_thread(int flags)
 {
 	asm volatile ("" : : "m" (URCU_TLS(cached_vtid)));
+	if (flags & LTTNG_UST_INIT_THREAD_CONTEXT_CACHE)
+		(void)wrapper_getvtid();
 }
diff --git a/src/lib/lttng-ust/lttng-probes.c b/src/lib/lttng-ust/lttng-probes.c
index e8e08ff1..2d47bf19 100644
--- a/src/lib/lttng-ust/lttng-probes.c
+++ b/src/lib/lttng-ust/lttng-probes.c
@@ -231,7 +231,7 @@ struct lttng_ust_registered_probe *lttng_ust_probe_register(const struct lttng_u
 {
 	struct lttng_ust_registered_probe *reg_probe = NULL;
 
-	lttng_ust_alloc_tls();
+	lttng_ust_common_init_thread(0);
 
 	/*
 	 * If version mismatch, don't register, but don't trigger assert
@@ -269,7 +269,7 @@ end:
 
 void lttng_ust_probe_unregister(struct lttng_ust_registered_probe *reg_probe)
 {
-	lttng_ust_alloc_tls();
+	lttng_ust_common_init_thread(0);
 
 	if (!reg_probe)
 		return;
diff --git a/src/lib/lttng-ust/lttng-tracer-core.h b/src/lib/lttng-ust/lttng-tracer-core.h
index eadc43ed..dd83a323 100644
--- a/src/lib/lttng-ust/lttng-tracer-core.h
+++ b/src/lib/lttng-ust/lttng-tracer-core.h
@@ -16,6 +16,11 @@
 #include <lttng/ust-ringbuffer-context.h>
 #include "common/logging.h"
 
+enum lttng_ust_init_thread_flags {
+	LTTNG_UST_INIT_THREAD_CONTEXT_CACHE = (1 << 0),
+	LTTNG_UST_INIT_THREAD_MASK = (LTTNG_UST_INIT_THREAD_CONTEXT_CACHE << 1) - 1,
+};
+
 struct lttng_ust_session;
 struct lttng_ust_channel_buffer;
 struct lttng_ust_ctx_field;
@@ -34,28 +39,28 @@ void ust_lock_nocheck(void)
 void ust_unlock(void)
 	__attribute__((visibility("hidden")));
 
-void lttng_ust_alloc_tls(void)
+void lttng_ust_common_init_thread(int flags)
 	__attribute__((visibility("hidden")));
 
-void lttng_vtid_alloc_tls(void)
+void lttng_ust_vtid_init_thread(int flags)
 	__attribute__((visibility("hidden")));
 
-void lttng_procname_alloc_tls(void)
+void lttng_ust_procname_init_thread(int flags)
 	__attribute__((visibility("hidden")));
 
-void lttng_cgroup_ns_alloc_tls(void)
+void lttng_ust_cgroup_ns_init_thread(int flags)
 	__attribute__((visibility("hidden")));
 
-void lttng_ipc_ns_alloc_tls(void)
+void lttng_ust_ipc_ns_init_thread(int flags)
 	__attribute__((visibility("hidden")));
 
-void lttng_net_ns_alloc_tls(void)
+void lttng_ust_net_ns_init_thread(int flags)
 	__attribute__((visibility("hidden")));
 
-void lttng_time_ns_alloc_tls(void)
+void lttng_ust_time_ns_init_thread(int flags)
 	__attribute__((visibility("hidden")));
 
-void lttng_uts_ns_alloc_tls(void)
+void lttng_ust_uts_ns_init_thread(int flags)
 	__attribute__((visibility("hidden")));
 
 const char *lttng_ust_obj_get_name(int id)
@@ -78,7 +83,7 @@ void lttng_event_notifier_notification_send(
 	__attribute__((visibility("hidden")));
 
 #ifdef HAVE_LINUX_PERF_EVENT_H
-void lttng_ust_perf_counter_alloc_tls(void)
+void lttng_ust_perf_counter_init_thread(int flags)
 	__attribute__((visibility("hidden")));
 
 void lttng_perf_lock(void)
@@ -88,8 +93,9 @@ void lttng_perf_unlock(void)
 	__attribute__((visibility("hidden")));
 #else /* #ifdef HAVE_LINUX_PERF_EVENT_H */
 static inline
-void lttng_ust_perf_counter_alloc_tls(void)
+void lttng_ust_perf_counter_init_thread(int flags)
 {
+	(void)flags;
 }
 static inline
 void lttng_perf_lock(void)
diff --git a/src/lib/lttng-ust/lttng-ust-comm.c b/src/lib/lttng-ust/lttng-ust-comm.c
index 7f34efe7..0a039fef 100644
--- a/src/lib/lttng-ust/lttng-ust-comm.c
+++ b/src/lib/lttng-ust/lttng-ust-comm.c
@@ -387,7 +387,7 @@ const char *get_lttng_home_dir(void)
  * Force a read (imply TLS allocation for dlopen) of TLS variables.
  */
 static
-void lttng_nest_count_alloc_tls(void)
+void lttng_ust_nest_count_alloc_tls(void)
 {
 	asm volatile ("" : : "m" (URCU_TLS(lttng_ust_nest_count)));
 }
@@ -402,26 +402,26 @@ void lttng_ust_mutex_nest_alloc_tls(void)
  * Allocate lttng-ust urcu TLS.
  */
 static
-void lttng_lttng_ust_urcu_alloc_tls(void)
+void lttng_ust_urcu_alloc_tls(void)
 {
 	(void) lttng_ust_urcu_read_ongoing();
 }
 
-void lttng_ust_alloc_tls(void)
+void lttng_ust_common_init_thread(int flags)
 {
-	lttng_lttng_ust_urcu_alloc_tls();
+	lttng_ust_urcu_alloc_tls();
 	lttng_ringbuffer_alloc_tls();
-	lttng_vtid_alloc_tls();
-	lttng_nest_count_alloc_tls();
-	lttng_procname_alloc_tls();
+	lttng_ust_vtid_init_thread(flags);
+	lttng_ust_nest_count_alloc_tls();
+	lttng_ust_procname_init_thread(flags);
 	lttng_ust_mutex_nest_alloc_tls();
-	lttng_ust_perf_counter_alloc_tls();
+	lttng_ust_perf_counter_init_thread(flags);
 	lttng_ust_common_alloc_tls();
-	lttng_cgroup_ns_alloc_tls();
-	lttng_ipc_ns_alloc_tls();
-	lttng_net_ns_alloc_tls();
-	lttng_time_ns_alloc_tls();
-	lttng_uts_ns_alloc_tls();
+	lttng_ust_cgroup_ns_init_thread(flags);
+	lttng_ust_ipc_ns_init_thread(flags);
+	lttng_ust_net_ns_init_thread(flags);
+	lttng_ust_time_ns_init_thread(flags);
+	lttng_ust_uts_ns_init_thread(flags);
 	lttng_ust_ring_buffer_client_discard_alloc_tls();
 	lttng_ust_ring_buffer_client_discard_rt_alloc_tls();
 	lttng_ust_ring_buffer_client_overwrite_alloc_tls();
@@ -446,7 +446,7 @@ void lttng_ust_init_thread(void)
 	 * ensure those are initialized before a signal handler nesting over
 	 * this thread attempts to use them.
 	 */
-	lttng_ust_alloc_tls();
+	lttng_ust_common_init_thread(LTTNG_UST_INIT_THREAD_MASK);
 }
 
 int lttng_get_notify_socket(void *owner)
@@ -1815,7 +1815,7 @@ void *ust_listener_thread(void *arg)
 	int sock, ret, prev_connect_failed = 0, has_waited = 0, fd;
 	long timeout;
 
-	lttng_ust_alloc_tls();
+	lttng_ust_common_init_thread(0);
 	/*
 	 * If available, add '-ust' to the end of this thread's
 	 * process name
@@ -2183,7 +2183,7 @@ void lttng_ust_ctor(void)
 	 * to be the dynamic linker mutex) and ust_lock, taken within
 	 * the ust lock.
 	 */
-	lttng_ust_alloc_tls();
+	lttng_ust_common_init_thread(0);
 
 	lttng_ust_loaded = 1;
 
@@ -2497,7 +2497,7 @@ void lttng_ust_before_fork(sigset_t *save_sigset)
 	int ret;
 
 	/* Allocate lttng-ust TLS. */
-	lttng_ust_alloc_tls();
+	lttng_ust_common_init_thread(0);
 
 	if (URCU_TLS(lttng_ust_nest_count))
 		return;
diff --git a/src/lib/lttng-ust/lttng-ust-statedump.c b/src/lib/lttng-ust/lttng-ust-statedump.c
index 309a98fa..bd95c043 100644
--- a/src/lib/lttng-ust/lttng-ust-statedump.c
+++ b/src/lib/lttng-ust/lttng-ust-statedump.c
@@ -557,7 +557,7 @@ void lttng_ust_dl_update(void *ip)
 	 * Force the allocation of lttng-ust TLS variables when called from
 	 * dlopen/dlclose instrumentation.
 	 */
-	lttng_ust_alloc_tls();
+	lttng_ust_common_init_thread(0);
 
 	data.exec_found = 0;
 	data.first = true;
-- 
2.35.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
