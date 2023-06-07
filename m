Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72620C7EE23
	for <lttng-dev@archiver.kernel.org>; Wed,  7 Jun 2023 18:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1686164103;
	bh=J7nok/61G6WLplkwJlh3vGz2AdhvxadwE1gessEaqPs=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=aDd+mm3vdRj3y8/LEPlvqbpuwfu7MoMsBCaCHk1yuPFG+SO9/eg3o/DHbNbHhzavq
	 Rj6CFXxNCO26pOZ+K8OGe3XnNYhgR4MLaKr/5d8eBYUvX5hE6Tp+TaSM+Lz8VFpbhZ
	 27vVHG0vUpdlmCb7IFGCDvgIKySbix3GHjpFL00Dvy7Z43QT0ydhxReeZofF55CjAh
	 q5vjR+JG+v4wfHdeCtNiLsthWQtl/pwtTl5l2n5ogA/zmyS+Ug0S3Qc5P85xb89lE0
	 FvzqHwLChbNkhzcDKVAxmm2akzwIhveQnzjH2s+WeX9YrxP5sxoctnOs4Dv1xkazBt
	 VAPTU572Y7ifw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QbxNl29rNz1Xsg;
	Wed,  7 Jun 2023 14:55:03 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QbxNf6RNYz1Y10
 for <lttng-dev@lists.lttng.org>; Wed,  7 Jun 2023 14:54:58 -0400 (EDT)
Received: from laura.hitronhub.home (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QbxNW6Bgfz16t3;
 Wed,  7 Jun 2023 14:54:51 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Wed,  7 Jun 2023 14:53:50 -0400
Message-Id: <20230607185359.8125-4-odion@efficios.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515201718.9809-1-odion@efficios.com>
References: <20230515201718.9809-1-odion@efficios.com>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH v2 03/12] urcu/arch/generic: Use atomic builtins
 if configured
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
From: Olivier Dion via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Olivier Dion <odion@efficios.com>
Cc: Olivier Dion <odion@efficios.com>, Tony Finch <dot@dotat.at>,
 "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

If configured to use atomic builtins, implement SMP memory barriers in
term of atomic builtins if the architecture does not implement its own
version.

Change-Id: Iddc4283606e0fce572e104d2d3f03b5c0d9926fb
Co-authored-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Olivier Dion <odion@efficios.com>
---
 include/urcu/arch/generic.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/urcu/arch/generic.h b/include/urcu/arch/generic.h
index be6e41e..e292c70 100644
--- a/include/urcu/arch/generic.h
+++ b/include/urcu/arch/generic.h
@@ -43,6 +43,14 @@ extern "C" {
  * GCC builtins) as well as cmm_rmb and cmm_wmb (defaulting to cmm_mb).
  */
 
+#ifdef CONFIG_RCU_USE_ATOMIC_BUILTINS
+
+# ifndef cmm_smp_mb
+#  define cmm_smp_mb() __atomic_thread_fence(__ATOMIC_SEQ_CST)
+# endif
+
+#endif	/* CONFIG_RCU_USE_ATOMIC_BUILTINS */
+
 #ifndef cmm_mb
 #define cmm_mb()    __sync_synchronize()
 #endif
-- 
2.40.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
