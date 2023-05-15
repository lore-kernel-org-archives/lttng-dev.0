Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF475C7EE25
	for <lttng-dev@archiver.kernel.org>; Mon, 15 May 2023 20:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684181904;
	bh=FoJ7sUmeq42bZdOP/Epc7RU5ocsesbHuTeVw2WZWYfU=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=B9MACymTm0xiLuWFiA5BtC+nASb84Pxccn3qyc/kOhcWIvrnIZMk2VGyzyEWqCpFs
	 Dk7rkkj7uj/CVP1jqfcUrgvHc6qf9C99U/CIZDbbuBzYbVnjZ13lZgvNfkH5/0VLO+
	 LYVQKuSErdfy/Kp+ZT/QO+xfJFdvJhv1+pxBZCqaTMNEMt5JMPmYlgk1JTSA3uPgsX
	 UFqlw3cSth1YZFD9Bd855fXgKSA/sINz0h9tcHB2w4jd3ccjPSor9FHiN2LSSELV4W
	 FuTcDzJUU73JB0WTaeJFgBAf96D7f7TeKaMD20Q45gRtpkEdVzCTAMCWKkuK35JtNL
	 02D1MTqC46jCQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QKrKX3Pfbz1DYW;
	Mon, 15 May 2023 16:18:24 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QKrKM5VY0z1Df1
 for <lttng-dev@lists.lttng.org>; Mon, 15 May 2023 16:18:15 -0400 (EDT)
Received: from laura.hitronhub.home (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QKrKM2t6wz12jM;
 Mon, 15 May 2023 16:18:15 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Mon, 15 May 2023 16:17:10 -0400
Message-Id: <20230515201718.9809-4-odion@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515201718.9809-1-odion@efficios.com>
References: <20230515201718.9809-1-odion@efficios.com>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH 03/11] urcu/compiler: Use atomic builtins if
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

Use __atomic_signal_fence(__ATOMIC_SEQ_CST) for cmm_barrier() if
configured to use atomic builtins.

Change-Id: Ib168b50f1e97a8da861b92d6882c56db230ebb2c
Co-authored-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Olivier Dion <odion@efficios.com>
---
 include/urcu/compiler.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/urcu/compiler.h b/include/urcu/compiler.h
index 2f32b38..3604488 100644
--- a/include/urcu/compiler.h
+++ b/include/urcu/compiler.h
@@ -25,10 +25,16 @@
 # include <type_traits>	/* for std::remove_cv */
 #endif
 
+#include <urcu/config.h>
+
 #define caa_likely(x)	__builtin_expect(!!(x), 1)
 #define caa_unlikely(x)	__builtin_expect(!!(x), 0)
 
-#define	cmm_barrier()	__asm__ __volatile__ ("" : : : "memory")
+#ifdef CONFIG_RCU_USE_ATOMIC_BUILTINS
+#  define cmm_barrier() __atomic_signal_fence(__ATOMIC_SEQ_CST)
+#else
+#  define cmm_barrier() asm volatile ("" : : : "memory")
+#endif
 
 /*
  * Instruct the compiler to perform only a single access to a variable
-- 
2.39.2

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
