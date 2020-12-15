Return-Path: <SRS0=KqGB=FT=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E6EC4361B
	for <lttng-dev@archiver.kernel.org>; Tue, 15 Dec 2020 16:29:17 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71ECE2078B
	for <lttng-dev@archiver.kernel.org>; Tue, 15 Dec 2020 16:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71ECE2078B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CwNxm2ptrzF0V;
	Tue, 15 Dec 2020 11:29:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1608049756;
	bh=EhlFIM/jLy5cygTa/8uQ4e7y/g+ToMIZZ6kAbmZvkMg=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=tK38XvXKy7ZR+gSG0Je+xdauIciz8MIK2TABU+Kast4206Y6zNZQIO20YsB8iAVFM
	 7kwRx04d3K3ZblD1lvhiUq31tIgVZJ02o0ape1gAOiQQqbThf757y7Gpyz+LHgDDiQ
	 i/pGg3BHa0uxr6hI6ygvh+IUiyKqs8Wi/U/fEDLv6o56nWT+ki7WXsTgeijqrWjdFr
	 ZQI1yp1GLkugVasX+xa2vujavF5fBaizNOZJ7v7Scwnu1UE53/ymzwM4M8W/yy31i6
	 9omrjSsG+JMqtChyVW6aePcUKQOH+jT7kXThXb6IgIAPZbLNrs+7nJs1FcHHI5J3QN
	 SB8u9M0lfMWcg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4CwNxc48H1zDxL
 for <lttng-dev@lists.lttng.org>; Tue, 15 Dec 2020 11:29:08 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4991C760C;
 Tue, 15 Dec 2020 11:29:03 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id UZ5YvvMkvQcV; Tue, 15 Dec 2020 11:29:03 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id E633C760B;
 Tue, 15 Dec 2020 11:29:02 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E633C760B
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id U4xuGsNCzMZ3; Tue, 15 Dec 2020 11:29:02 -0500 (EST)
Received: from multivac.lan (96-127-212-112.qc.cable.ebox.net [96.127.212.112])
 by mail.efficios.com (Postfix) with ESMTPSA id C028E73C5;
 Tue, 15 Dec 2020 11:29:02 -0500 (EST)
To: lttng-dev@lists.lttng.org
Date: Tue, 15 Dec 2020 11:28:47 -0500
Message-Id: <20201215162850.78638-1-mjeanson@efficios.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH urcu 1/4] Cleanup: Move ARM specific code to
 urcu/arch/arm.h
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Change-Id: I3e17308c5ae985789a2ac8361e9c9e958ff7d656
Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 include/urcu/arch/arm.h | 13 +++++++++++++
 include/urcu/compiler.h | 13 -------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/urcu/arch/arm.h b/include/urcu/arch/arm.h
index cb8f28d..5d1c608 100644
--- a/include/urcu/arch/arm.h
+++ b/include/urcu/arch/arm.h
@@ -57,6 +57,19 @@ extern "C" {
 #define __NR_membarrier		389
 #endif
 
+/*
+ * Error out for compilers with known bugs.
+ */
+
+/*
+ * http://gcc.gnu.org/bugzilla/show_bug.cgi?id=58854
+ */
+#ifdef URCU_GCC_VERSION
+# if URCU_GCC_VERSION >= 40800 && URCU_GCC_VERSION <= 40802
+#  error Your gcc version produces clobbered frame accesses
+# endif
+#endif
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/include/urcu/compiler.h b/include/urcu/compiler.h
index 511dbdf..4806ee3 100644
--- a/include/urcu/compiler.h
+++ b/include/urcu/compiler.h
@@ -108,23 +108,10 @@
 
 #define CAA_ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
 
-/*
- * Don't allow compiling with buggy compiler.
- */
-
 #ifdef __GNUC__
 # define URCU_GCC_VERSION	(__GNUC__ * 10000 \
 				+ __GNUC_MINOR__ * 100 \
 				+ __GNUC_PATCHLEVEL__)
-
-/*
- * http://gcc.gnu.org/bugzilla/show_bug.cgi?id=58854
- */
-# ifdef __ARMEL__
-#  if URCU_GCC_VERSION >= 40800 && URCU_GCC_VERSION <= 40802
-#   error Your gcc version produces clobbered frame accesses
-#  endif
-# endif
 #endif
 
 #endif /* _URCU_COMPILER_H */
-- 
2.29.2

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
