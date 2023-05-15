Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93EAC77B7D
	for <lttng-dev@archiver.kernel.org>; Mon, 15 May 2023 20:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684181905;
	bh=b8saz8a0rZ0pM3OBWQSwDnmr8JJZ+9XTNGTIrHAniFo=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=NoMH+++hjTN85wtKjKvNctn+yeYRbpZnHhKjrda1vvzSWWlwi43hu5KqrilgRXjWl
	 MEjIjYr42HGTrzAK9X3tvg5ZpxSAhrik6CtDNXSxgtBlvmE19oQRmwB+T/0wrxyxQ6
	 lUWzg57CTFRVXj/SfFeuMo3GV4qrdX69d0Ch/Owg0X9W9HILbHM76SQ4xefVDfTr2g
	 jkbqo9sxXEfpDDCgGK/+affHzuAuLh5yaeJjl3hBYB4SZYI9duWuorpSPaNvqjyrd2
	 FdwzlSq/SZ3cxY0By93E/2cm7IxnVqQIuQjxzzoVYd+DblwuH6CmrsiMjOx7kGmT3c
	 EzqdpXzZW5g+Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QKrKX6n1nz1F02;
	Mon, 15 May 2023 16:18:24 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QKrKM6Kq9z1Dh8
 for <lttng-dev@lists.lttng.org>; Mon, 15 May 2023 16:18:15 -0400 (EDT)
Received: from laura.hitronhub.home (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QKrKM55wLz12q0;
 Mon, 15 May 2023 16:18:15 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Mon, 15 May 2023 16:17:12 -0400
Message-Id: <20230515201718.9809-6-odion@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515201718.9809-1-odion@efficios.com>
References: <20230515201718.9809-1-odion@efficios.com>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH 05/11] urcu/system: Use atomic builtins if
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
2.39.2

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
