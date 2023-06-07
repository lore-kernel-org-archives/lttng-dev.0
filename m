Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA191C7EE23
	for <lttng-dev@archiver.kernel.org>; Wed,  7 Jun 2023 18:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1686164099;
	bh=Qghdac1OpH+mSb03rOd1gDi/KV41H1CSRaEtGaFSwdU=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=tRrIg7l/uVNrjeSaTAwgShfezXzQKVuxcPYmThOjjUxmXasoL5Q8EdaBQv9A6cUGM
	 uEH4727+K7BRNgqbpBmFDT+X3RBe2DnubJIyrc2TOR/YXQFMBDFKRFXBIyvN8enZub
	 FM9kdIUmdzU7MOqHsPLFnfmtL4CqPg0QfjA6BOB60+/vnAYy1ea8TgTNgAuh8EeATP
	 0naAnGUWzQYx8+P/hZgG58mG7kEY6LzmlJO2dD6SvloJqdw0RizgCRkj9eT9Jj/SAW
	 lPxVTLTihDG3adp7kGLaoDDasR7tMTnr1ONmf23ipkO7D9vGSFR2IatChkMkav67hL
	 MsHDftHx+h30w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QbxNg3R4Kz1Xvb;
	Wed,  7 Jun 2023 14:54:59 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QbxNX2Sbfz1XJt
 for <lttng-dev@lists.lttng.org>; Wed,  7 Jun 2023 14:54:52 -0400 (EDT)
Received: from laura.hitronhub.home (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QbxNX0Vfyz16yv;
 Wed,  7 Jun 2023 14:54:52 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Wed,  7 Jun 2023 14:53:51 -0400
Message-Id: <20230607185359.8125-5-odion@efficios.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515201718.9809-1-odion@efficios.com>
References: <20230515201718.9809-1-odion@efficios.com>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH v2 04/12] urcu/system: Use atomic builtins if
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
Cc: Olivier Dion <odion@efficios.com>, Tony Finch <dot@dotat.at>,
 "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

If configured to use atomic builtins, use them for implementing the
CMM_LOAD_SHARED and CMM_STORE_SHARED macros.

Change-Id: I3eaaaaf0d26c47aced6e94b40fd59c7b8baa6272
Co-authored-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Olivier Dion <odion@efficios.com>
---
 include/urcu/system.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/urcu/system.h b/include/urcu/system.h
index faae390..f184aad 100644
--- a/include/urcu/system.h
+++ b/include/urcu/system.h
@@ -19,9 +19,28 @@
  * all copies or substantial portions of the Software.
  */
 
+#include <urcu/config.h>
 #include <urcu/compiler.h>
 #include <urcu/arch.h>
 
+#ifdef CONFIG_RCU_USE_ATOMIC_BUILTINS
+
+#define CMM_LOAD_SHARED(x)			\
+	__atomic_load_n(&(x), __ATOMIC_RELAXED)
+
+#define _CMM_LOAD_SHARED(x) CMM_LOAD_SHARED(x)
+
+#define CMM_STORE_SHARED(x, v)					\
+	__extension__						\
+	({							\
+		__typeof__(v) _v = (v);				\
+		__atomic_store_n(&(x), _v, __ATOMIC_RELAXED);	\
+		_v;						\
+	})
+
+#define _CMM_STORE_SHARED(x, v) CMM_STORE_SHARED(x, v)
+
+#else
 /*
  * Identify a shared load. A cmm_smp_rmc() or cmm_smp_mc() should come
  * before the load.
@@ -56,4 +75,6 @@
 		_v = _v;	/* Work around clang "unused result" */	\
 	})
 
+#endif	/* CONFIG_RCU_USE_ATOMIC_BUILTINS */
+
 #endif /* _URCU_SYSTEM_H */
-- 
2.40.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
