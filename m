Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBCBC43334
	for <lttng-dev@archiver.kernel.org>; Mon, 18 Jul 2022 22:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1658181631;
	bh=TlP1XNEJkcj0aQTz3TwxDQ2eGbyifE+NrUyTHffKN9o=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=hGbjcCiOtzfOYRVd6Hk2JxeECytvuaHbkdZkCiDFSpWu670CZfY2CK5lcsbKD5MNR
	 P6K12NJ3y0bOp8yHBj3/ee72444KcVEX+lIV8obvn7h8JJDrHCYzeNPXY8+zA7VKzq
	 7sAgYDbM8/hAL/T/iRhc1586F3F1v5YFfSV8S/EVZAiA87v6FR2a1uaEg/c4Id9gOd
	 5kbG2OVdFJv2qO72hRqMjX1uTl2MHJwHjz7As4zuEP4YB23Idb+qvW8/B3T4oEAyPI
	 HIieMsNnfpYO1cHZdN5ZDfsnV4M1j9MG49upjINtAXndAhDquunqx81GJoMhqMyuvr
	 TZrbL7WGx2ihA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LmwrH11pGzPMj;
	Mon, 18 Jul 2022 18:00:31 -0400 (EDT)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by lists.lttng.org (Postfix) with ESMTPS id 4Lmwr80FdzzPMg
 for <lttng-dev@lists.lttng.org>; Mon, 18 Jul 2022 18:00:22 -0400 (EDT)
Received: by mail-ej1-x631.google.com with SMTP id b11so23771953eju.10
 for <lttng-dev@lists.lttng.org>; Mon, 18 Jul 2022 15:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OcF5aTaLFsHB6ryLio1gEgNcHRZgmpwm+3mSQH+lKb0=;
 b=ZTo72FASc/w+QmYoEW/oAxYW79WNOC40I9AWqRTScgKwOVa2vV5aS7g5WwuDia4MA4
 gsJA6VfIVOO1ET28ycCAJuPUek+WQgqsTu8SOy/InxE4ZigxgAsqyjUZeW/gOV8nxgJv
 f1xCUgff+2T6Nm65P0sDWW9pVr3yyiKYaEYkZVcmUqMtSG6o+fqhqwVFQ+h3jFTMIco+
 8XourQZlths/GSg0CRFtCmXw2wFbDY51B+Sxho6eVKjLEXWvWnYyMZdXif3vnRXKvo0G
 PZ5UlWsXJCkWKl/FST3qbH7E/A4hF6sRz+JeHz6rUy7Khie3YhI7NeVjkHeXCBut5mhu
 Jh1Q==
X-Gm-Message-State: AJIora8qlcUfRX8qhk5bwdkPloUH9ndY8rt8ob7nrWSNgZbqazofefmy
 AAAMj4Z6yDtJLrCjeK0AWHakuX6qCK4IEA==
X-Google-Smtp-Source: AGRyM1tHn3jL0qr1bSMe7oOdNpTmmWWr8fECB7QM6M7Ar89xurzBqLeA3Lor6IHlKKcZKO0hbJJMeA==
X-Received: by 2002:a17:906:a0cf:b0:726:cbdd:466b with SMTP id
 bh15-20020a170906a0cf00b00726cbdd466bmr27186336ejb.410.1658181621747; 
 Mon, 18 Jul 2022 15:00:21 -0700 (PDT)
Received: from debian-noppl.. (62-178-205-20.cable.dynamic.surfer.at.
 [62.178.205.20]) by smtp.gmail.com with ESMTPSA id
 u18-20020a05640207d200b0042dcbc3f302sm9231847edy.36.2022.07.18.15.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Jul 2022 15:00:21 -0700 (PDT)
To: lttng-dev@lists.lttng.org
Date: Mon, 18 Jul 2022 23:59:54 +0200
Message-Id: <20220718215955.124991-1-nolange79@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH 1/2] lttng_ust_init_thread: initialise cached
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

Modify all relevant *_alloc_tls functions so that they take an
argument for 'init'. Setting this to 'true' will read
the actual context value and store it into a thread local
cache.

The function 'lttng_ust_init_thread' will use this to
precalculate context values. Tracepoints can then avoid
systemcalls.

Signed-off-by: Norbert Lange <nolange79@gmail.com>
---
*   see https://lore.kernel.org/all/CADYdroN3=pAe66crtsVT9aHE4T+bT61-tvHFKCuwZYkHhuyFjw@mail.gmail.com/
*   Will update docs after review, and do some more tests
    during the week
---
 src/lib/lttng-ust/lttng-context-cgroup-ns.c |  4 +++-
 src/lib/lttng-ust/lttng-context-ipc-ns.c    |  4 +++-
 src/lib/lttng-ust/lttng-context-net-ns.c    |  4 +++-
 src/lib/lttng-ust/lttng-context-procname.c  |  4 +++-
 src/lib/lttng-ust/lttng-context-provider.c  |  4 ++--
 src/lib/lttng-ust/lttng-context-time-ns.c   |  4 +++-
 src/lib/lttng-ust/lttng-context-uts-ns.c    |  4 +++-
 src/lib/lttng-ust/lttng-context-vtid.c      |  4 +++-
 src/lib/lttng-ust/lttng-probes.c            |  4 ++--
 src/lib/lttng-ust/lttng-tracer-core.h       | 16 +++++++-------
 src/lib/lttng-ust/lttng-ust-comm.c          | 24 ++++++++++-----------
 src/lib/lttng-ust/lttng-ust-statedump.c     |  2 +-
 12 files changed, 46 insertions(+), 32 deletions(-)

diff --git a/src/lib/lttng-ust/lttng-context-cgroup-ns.c b/src/lib/lttng-ust/lttng-context-cgroup-ns.c
index 34523ea1..3eb5ab5b 100644
--- a/src/lib/lttng-ust/lttng-context-cgroup-ns.c
+++ b/src/lib/lttng-ust/lttng-context-cgroup-ns.c
@@ -155,7 +155,9 @@ error_find_context:
 /*
  * Force a read (imply TLS allocation for dlopen) of TLS variables.
  */
-void lttng_cgroup_ns_alloc_tls(void)
+void lttng_cgroup_ns_alloc_tls(bool init)
 {
 	asm volatile ("" : : "m" (URCU_TLS(cached_cgroup_ns)));
+	if (init)
+		(void)get_cgroup_ns();
 }
diff --git a/src/lib/lttng-ust/lttng-context-ipc-ns.c b/src/lib/lttng-ust/lttng-context-ipc-ns.c
index 63401e8d..b68b939f 100644
--- a/src/lib/lttng-ust/lttng-context-ipc-ns.c
+++ b/src/lib/lttng-ust/lttng-context-ipc-ns.c
@@ -153,7 +153,9 @@ error_find_context:
 /*
  * Force a read (imply TLS allocation for dlopen) of TLS variables.
  */
-void lttng_ipc_ns_alloc_tls(void)
+void lttng_ipc_ns_alloc_tls(bool init)
 {
 	asm volatile ("" : : "m" (URCU_TLS(cached_ipc_ns)));
+	if (init)
+		(void)get_ipc_ns();
 }
diff --git a/src/lib/lttng-ust/lttng-context-net-ns.c b/src/lib/lttng-ust/lttng-context-net-ns.c
index 960591c2..93e574ad 100644
--- a/src/lib/lttng-ust/lttng-context-net-ns.c
+++ b/src/lib/lttng-ust/lttng-context-net-ns.c
@@ -153,7 +153,9 @@ error_find_context:
 /*
  * Force a read (imply TLS allocation for dlopen) of TLS variables.
  */
-void lttng_net_ns_alloc_tls(void)
+void lttng_net_ns_alloc_tls(bool init)
 {
 	asm volatile ("" : : "m" (URCU_TLS(cached_net_ns)));
+	if (init)
+		(void)get_net_ns();
 }
diff --git a/src/lib/lttng-ust/lttng-context-procname.c b/src/lib/lttng-ust/lttng-context-procname.c
index b5bf77be..95f6fe42 100644
--- a/src/lib/lttng-ust/lttng-context-procname.c
+++ b/src/lib/lttng-ust/lttng-context-procname.c
@@ -122,7 +122,9 @@ error_find_context:
 /*
  * Force a read (imply TLS allocation for dlopen) of TLS variables.
  */
-void lttng_procname_alloc_tls(void)
+void lttng_procname_alloc_tls(bool init)
 {
 	asm volatile ("" : : "m" (URCU_TLS(cached_procname)[0]));
+	if (init)
+		(void)wrapper_getprocname();
 }
diff --git a/src/lib/lttng-ust/lttng-context-provider.c b/src/lib/lttng-ust/lttng-context-provider.c
index 4e7e429f..ba24aad7 100644
--- a/src/lib/lttng-ust/lttng-context-provider.c
+++ b/src/lib/lttng-ust/lttng-context-provider.c
@@ -67,7 +67,7 @@ struct lttng_ust_registered_context_provider *lttng_ust_context_provider_registe
 	size_t name_len = strlen(provider->name);
 	uint32_t hash;
 
-	lttng_ust_alloc_tls();
+	lttng_ust_alloc_tls(false);
 
 	/* Provider name starts with "$app.". */
 	if (strncmp("$app.", provider->name, strlen("$app.")) != 0)
@@ -101,7 +101,7 @@ end:
 
 void lttng_ust_context_provider_unregister(struct lttng_ust_registered_context_provider *reg_provider)
 {
-	lttng_ust_alloc_tls();
+	lttng_ust_alloc_tls(false);
 
 	if (ust_lock())
 		goto end;
diff --git a/src/lib/lttng-ust/lttng-context-time-ns.c b/src/lib/lttng-ust/lttng-context-time-ns.c
index ec32a1de..a957409b 100644
--- a/src/lib/lttng-ust/lttng-context-time-ns.c
+++ b/src/lib/lttng-ust/lttng-context-time-ns.c
@@ -152,7 +152,9 @@ error_find_context:
 /*
  * Force a read (imply TLS allocation for dlopen) of TLS variables.
  */
-void lttng_time_ns_alloc_tls(void)
+void lttng_time_ns_alloc_tls(bool init)
 {
 	asm volatile ("" : : "m" (URCU_TLS(cached_time_ns)));
+	if (init)
+		(void)get_time_ns();
 }
diff --git a/src/lib/lttng-ust/lttng-context-uts-ns.c b/src/lib/lttng-ust/lttng-context-uts-ns.c
index 06a978fd..0c802188 100644
--- a/src/lib/lttng-ust/lttng-context-uts-ns.c
+++ b/src/lib/lttng-ust/lttng-context-uts-ns.c
@@ -154,7 +154,9 @@ error_find_context:
 /*
  * Force a read (imply TLS allocation for dlopen) of TLS variables.
  */
-void lttng_uts_ns_alloc_tls(void)
+void lttng_uts_ns_alloc_tls(bool init)
 {
 	asm volatile ("" : : "m" (URCU_TLS(cached_uts_ns)));
+	if (init)
+		(void)get_uts_ns();
 }
diff --git a/src/lib/lttng-ust/lttng-context-vtid.c b/src/lib/lttng-ust/lttng-context-vtid.c
index 880e34b9..d3c9863e 100644
--- a/src/lib/lttng-ust/lttng-context-vtid.c
+++ b/src/lib/lttng-ust/lttng-context-vtid.c
@@ -112,7 +112,9 @@ error_find_context:
 /*
  * Force a read (imply TLS allocation for dlopen) of TLS variables.
  */
-void lttng_vtid_alloc_tls(void)
+void lttng_vtid_alloc_tls(bool init)
 {
 	asm volatile ("" : : "m" (URCU_TLS(cached_vtid)));
+	if (init)
+		(void)wrapper_getvtid();
 }
diff --git a/src/lib/lttng-ust/lttng-probes.c b/src/lib/lttng-ust/lttng-probes.c
index e8e08ff1..314cb7a0 100644
--- a/src/lib/lttng-ust/lttng-probes.c
+++ b/src/lib/lttng-ust/lttng-probes.c
@@ -231,7 +231,7 @@ struct lttng_ust_registered_probe *lttng_ust_probe_register(const struct lttng_u
 {
 	struct lttng_ust_registered_probe *reg_probe = NULL;
 
-	lttng_ust_alloc_tls();
+	lttng_ust_alloc_tls(false);
 
 	/*
 	 * If version mismatch, don't register, but don't trigger assert
@@ -269,7 +269,7 @@ end:
 
 void lttng_ust_probe_unregister(struct lttng_ust_registered_probe *reg_probe)
 {
-	lttng_ust_alloc_tls();
+	lttng_ust_alloc_tls(false);
 
 	if (!reg_probe)
 		return;
diff --git a/src/lib/lttng-ust/lttng-tracer-core.h b/src/lib/lttng-ust/lttng-tracer-core.h
index eadc43ed..dbb3bd9f 100644
--- a/src/lib/lttng-ust/lttng-tracer-core.h
+++ b/src/lib/lttng-ust/lttng-tracer-core.h
@@ -34,28 +34,28 @@ void ust_lock_nocheck(void)
 void ust_unlock(void)
 	__attribute__((visibility("hidden")));
 
-void lttng_ust_alloc_tls(void)
+void lttng_ust_alloc_tls(bool init)
 	__attribute__((visibility("hidden")));
 
-void lttng_vtid_alloc_tls(void)
+void lttng_vtid_alloc_tls(bool init)
 	__attribute__((visibility("hidden")));
 
-void lttng_procname_alloc_tls(void)
+void lttng_procname_alloc_tls(bool init)
 	__attribute__((visibility("hidden")));
 
-void lttng_cgroup_ns_alloc_tls(void)
+void lttng_cgroup_ns_alloc_tls(bool init)
 	__attribute__((visibility("hidden")));
 
-void lttng_ipc_ns_alloc_tls(void)
+void lttng_ipc_ns_alloc_tls(bool init)
 	__attribute__((visibility("hidden")));
 
-void lttng_net_ns_alloc_tls(void)
+void lttng_net_ns_alloc_tls(bool init)
 	__attribute__((visibility("hidden")));
 
-void lttng_time_ns_alloc_tls(void)
+void lttng_time_ns_alloc_tls(bool init)
 	__attribute__((visibility("hidden")));
 
-void lttng_uts_ns_alloc_tls(void)
+void lttng_uts_ns_alloc_tls(bool init)
 	__attribute__((visibility("hidden")));
 
 const char *lttng_ust_obj_get_name(int id)
diff --git a/src/lib/lttng-ust/lttng-ust-comm.c b/src/lib/lttng-ust/lttng-ust-comm.c
index 7f34efe7..ba0bd985 100644
--- a/src/lib/lttng-ust/lttng-ust-comm.c
+++ b/src/lib/lttng-ust/lttng-ust-comm.c
@@ -407,21 +407,21 @@ void lttng_lttng_ust_urcu_alloc_tls(void)
 	(void) lttng_ust_urcu_read_ongoing();
 }
 
-void lttng_ust_alloc_tls(void)
+void lttng_ust_alloc_tls(bool init)
 {
 	lttng_lttng_ust_urcu_alloc_tls();
 	lttng_ringbuffer_alloc_tls();
-	lttng_vtid_alloc_tls();
+	lttng_vtid_alloc_tls(init);
 	lttng_nest_count_alloc_tls();
-	lttng_procname_alloc_tls();
+	lttng_procname_alloc_tls(init);
 	lttng_ust_mutex_nest_alloc_tls();
 	lttng_ust_perf_counter_alloc_tls();
 	lttng_ust_common_alloc_tls();
-	lttng_cgroup_ns_alloc_tls();
-	lttng_ipc_ns_alloc_tls();
-	lttng_net_ns_alloc_tls();
-	lttng_time_ns_alloc_tls();
-	lttng_uts_ns_alloc_tls();
+	lttng_cgroup_ns_alloc_tls(init);
+	lttng_ipc_ns_alloc_tls(init);
+	lttng_net_ns_alloc_tls(init);
+	lttng_time_ns_alloc_tls(init);
+	lttng_uts_ns_alloc_tls(init);
 	lttng_ust_ring_buffer_client_discard_alloc_tls();
 	lttng_ust_ring_buffer_client_discard_rt_alloc_tls();
 	lttng_ust_ring_buffer_client_overwrite_alloc_tls();
@@ -446,7 +446,7 @@ void lttng_ust_init_thread(void)
 	 * ensure those are initialized before a signal handler nesting over
 	 * this thread attempts to use them.
 	 */
-	lttng_ust_alloc_tls();
+	lttng_ust_alloc_tls(true);
 }
 
 int lttng_get_notify_socket(void *owner)
@@ -1815,7 +1815,7 @@ void *ust_listener_thread(void *arg)
 	int sock, ret, prev_connect_failed = 0, has_waited = 0, fd;
 	long timeout;
 
-	lttng_ust_alloc_tls();
+	lttng_ust_alloc_tls(false);
 	/*
 	 * If available, add '-ust' to the end of this thread's
 	 * process name
@@ -2183,7 +2183,7 @@ void lttng_ust_ctor(void)
 	 * to be the dynamic linker mutex) and ust_lock, taken within
 	 * the ust lock.
 	 */
-	lttng_ust_alloc_tls();
+	lttng_ust_alloc_tls(false);
 
 	lttng_ust_loaded = 1;
 
@@ -2497,7 +2497,7 @@ void lttng_ust_before_fork(sigset_t *save_sigset)
 	int ret;
 
 	/* Allocate lttng-ust TLS. */
-	lttng_ust_alloc_tls();
+	lttng_ust_alloc_tls(false);
 
 	if (URCU_TLS(lttng_ust_nest_count))
 		return;
diff --git a/src/lib/lttng-ust/lttng-ust-statedump.c b/src/lib/lttng-ust/lttng-ust-statedump.c
index 309a98fa..ee180a0d 100644
--- a/src/lib/lttng-ust/lttng-ust-statedump.c
+++ b/src/lib/lttng-ust/lttng-ust-statedump.c
@@ -557,7 +557,7 @@ void lttng_ust_dl_update(void *ip)
 	 * Force the allocation of lttng-ust TLS variables when called from
 	 * dlopen/dlclose instrumentation.
 	 */
-	lttng_ust_alloc_tls();
+	lttng_ust_alloc_tls(false);
 
 	data.exec_found = 0;
 	data.first = true;
-- 
2.35.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
