Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74289C77B75
	for <lttng-dev@archiver.kernel.org>; Mon, 15 May 2023 20:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684181930;
	bh=mGjaYz7YzpTusj4lojCZ/FVvaSktrOx89wJn6YY5Lzo=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=T6/eOIuiDv4LFelT9NInqW+qghuVOr9nHXiNlveqqG8GHAtTE+WBZpZ6whBQgbIwm
	 u9MfjeAcYuYcYI6zMfkhYwoSQPb3SQ8Li8UBXz00mc6oAm6f6s2VCWCJ7+t6uxkHHm
	 O9IINL1p7lz7pIrFXW0Mx9CYimjhjbP6zJCwAMr88sBJ5emmjgL6GWejh62Fa0Sxqy
	 d1JMjnFwhfLi52GqbN2VBU6wjMBtj5sxeTH2pZbXhrcv0jDXcPTBtJvwail2OfjASM
	 tOWmA3PXZ0C89bveqqZuQbLeYuBlamemERoVeGaz5chusUfvOa12jzVtBbXmxsCoIP
	 PPDLyOV/FcaPA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QKrL24V40z1Dkg;
	Mon, 15 May 2023 16:18:50 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QKrKx5cjbz1F1Z
 for <lttng-dev@lists.lttng.org>; Mon, 15 May 2023 16:18:45 -0400 (EDT)
Received: from laura.hitronhub.home (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QKrKM3xhFz12py;
 Mon, 15 May 2023 16:18:15 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Mon, 15 May 2023 16:17:11 -0400
Message-Id: <20230515201718.9809-5-odion@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515201718.9809-1-odion@efficios.com>
References: <20230515201718.9809-1-odion@efficios.com>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH 04/11] urcu/arch/generic: Use atomic builtins if
 configured
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
Cc: Olivier Dion <odion@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>
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
2.39.2

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
