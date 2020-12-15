Return-Path: <SRS0=KqGB=FT=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47143C4361B
	for <lttng-dev@archiver.kernel.org>; Tue, 15 Dec 2020 16:29:13 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47F652078B
	for <lttng-dev@archiver.kernel.org>; Tue, 15 Dec 2020 16:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F652078B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CwNxf1lWbzDkn;
	Tue, 15 Dec 2020 11:29:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1608049751;
	bh=IniYRYzMHGdNOH0iKW6OecrHhJ/hJ607APELWdb3//U=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=untBRudlShY/631NJj4EPjj/sMI/Lrl+WfwaTSNAokDbmetsXCPQV2+yNXCbEXd66
	 f6wTI7KdFjBjEKHIGkNZcValikXUHoKRxwyjuWXLUHZNk2ySo2azouV0DAkgZOx7Hi
	 Sxwzm/CmuXLDezaOvBcROJT1dPQe6SLi2h7aho70mKZ3LjHmM3MSx7N9t9BcPyEA0v
	 QJaJehi+XVIl5vSUWOow17KIHPVyjcgEMIF5xffi/uaBeQBHr3wTtpAdyRspa/fMKD
	 ZmrP4Yb6r+hdEEliaDb38sakVyPCbL1ovRI7gPVsNtNOadq1hcqS416Kuhtw97hh/C
	 LjcBs05oRD1vA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4CwNxc44DvzDxK
 for <lttng-dev@lists.lttng.org>; Tue, 15 Dec 2020 11:29:08 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 740E272D8;
 Tue, 15 Dec 2020 11:29:06 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id nJNpH7KVZGY3; Tue, 15 Dec 2020 11:29:06 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4BF0672D7;
 Tue, 15 Dec 2020 11:29:06 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4BF0672D7
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 2F_m9fVEaPh0; Tue, 15 Dec 2020 11:29:06 -0500 (EST)
Received: from multivac.lan (96-127-212-112.qc.cable.ebox.net [96.127.212.112])
 by mail.efficios.com (Postfix) with ESMTPSA id 25C3B760E;
 Tue, 15 Dec 2020 11:29:06 -0500 (EST)
To: lttng-dev@lists.lttng.org
Date: Tue, 15 Dec 2020 11:28:48 -0500
Message-Id: <20201215162850.78638-2-mjeanson@efficios.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215162850.78638-1-mjeanson@efficios.com>
References: <20201215162850.78638-1-mjeanson@efficios.com>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH urcu 2/4] Blacklist GCC 4.4.0,
 4.4.1 and 4.4.2 on ARM
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

GCC added __sync_synchronize() in 4.4.0 but it was broken on ARM until
4.4.3, see the GCC bug report for more details :

  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=42263

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Change-Id: I629e3c8b4baaccb34b2311e220f30d0ad8b69a19
---
 include/urcu/arch/arm.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/urcu/arch/arm.h b/include/urcu/arch/arm.h
index 5d1c608..e904b06 100644
--- a/include/urcu/arch/arm.h
+++ b/include/urcu/arch/arm.h
@@ -70,6 +70,15 @@ extern "C" {
 # endif
 #endif
 
+/*
+ * https://gcc.gnu.org/bugzilla/show_bug.cgi?id=42263
+ */
+#ifdef URCU_GCC_VERSION
+# if URCU_GCC_VERSION >= 40400 && URCU_GCC_VERSION <= 40402
+#  error Your gcc version has a non-functional __sync_synchronize()
+# endif
+#endif
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.29.2

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
