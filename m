Return-Path: <SRS0=5Vrj=EW=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9791C5519F
	for <lttng-dev@archiver.kernel.org>; Mon, 16 Nov 2020 12:25:28 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 767582224B
	for <lttng-dev@archiver.kernel.org>; Mon, 16 Nov 2020 12:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="VjPLoKKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767582224B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CZSvn1fCLz1JQQ;
	Mon, 16 Nov 2020 07:25:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1605529526;
	bh=oOVveeLxffTMol7fYl3DORbPjZgunY+SqoEPbWIMoKE=;
	h=To:CC:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=VjPLoKKqDt6L0R0JIMyDDNAbbj+CTBJyjS4/wiXDI5qiVuog7v9v4oOze9XmCeNVq
	 vVLL8lrdtKrc45wsiEWa4QtyA1V0ihurwXRCu5tio/y6DNr1S+wRpiaslVs6UaxVIm
	 Me8K/1/HtunshWOi2c0FfHW8B+bk7ushXZtUOYGLv5uyYq6B8lKJlf4klkEdRFO7hS
	 qsVmRrH8mDLcJbxpXzY1/AhPt9OYKLSUR43XYXYvI0v1L+j1cW9GSvyw/xrcTXbh+f
	 jrusRS6staH1c5NwhLZ1SShXu0CgYIOf8pSScgqQcNX2ToonQIWkhGt6dOTQ1lf2a7
	 qbcop5oXS+hGQ==
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by lists.lttng.org (Postfix) with ESMTPS id 4CZSvj1W2Sz1JKL
 for <lttng-dev@lists.lttng.org>; Mon, 16 Nov 2020 07:25:20 -0500 (EST)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CZStx3LlXzhbB5;
 Mon, 16 Nov 2020 20:24:41 +0800 (CST)
Received: from huawei.com (10.174.176.87) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Mon, 16 Nov 2020
 20:24:47 +0800
To: <lttng-dev@lists.lttng.org>, <mathieu.desnoyers@efficios.com>
CC: <hushiyuan@huawei.com>
Date: Mon, 16 Nov 2020 20:24:46 +0800
Message-ID: <20201116122446.30900-1-wangshuo47@huawei.com>
X-Mailer: git-send-email 2.19.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.176.87]
X-CFilter-Loop: Reflected
Subject: [lttng-dev] [PATCH] README: fix typo in README.md
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
From: Shuo Wang via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Shuo Wang <wangshuo47@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

	Dear Mathieu,

This mail may work.

Thank you,
Shuo

Signed-off-by: Shuo Wang <wangshuo47@huawei.com>
---
 README.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 2d6dcaa..dd7ebd1 100644
--- a/README.md
+++ b/README.md
@@ -388,7 +388,7 @@ For always-on debugging self-checks:
 	./configure --enable-rcu-debug
 
 For fine grained enabling of debugging self-checks, build
-urserspace-rcu with DEBUG_RCU defined and compile dependent
+userspace-rcu with DEBUG_RCU defined and compile dependent
 applications with DEBUG_RCU defined when necessary.
 
 Warning: Enabling this feature result in a performance penalty.
-- 
2.23.0

> Hi, 
> 
> This fix does not apply with "git am", probably due to the fact that the email is not 
> formatted as plain text without alteration by your email client. I recommend using 
> git send-email to send patches. Can you try sending it again in the proper format 
> expected by git am ? 
> 
> You will likely find useful information about why your email client changed the 
> patch formatting here: 
> 
> [ https://www.kernel.org/doc/html/v5.9/process/submitting-patches.html | https://www.kernel.org/doc/html/v5.9/process/submitting-patches.html ] 
> [ https://www.kernel.org/doc/html/v5.9/process/email-clients.html#email-clients | https://www.kernel.org/doc/html/v5.9/process/email-clients.html#email-clients ] 
> 
> Thanks, 
> 
> Mathieu 
> 
> ----- On Nov 13, 2020, at 4:28 AM, wangshuo (AF) <wangshuo47 at huawei.com> wrote: 
> 
> > README: fix typo in README.md
> 
> > Signed-off-by: Shuo Wang < [ mailto:wangshuo47 at huawei.com |
> > wangshuo47 at huawei.com ] >
> 
> > ---
> 
> > README.md | 2 +-
> 
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> > diff --git a/README.md b/README.md
> 
> > index 2d6dcaa..dd7ebd1 100644
> 
> > --- a/README.md
> 
> > +++ b/README.md
> 
> > @@ -388,7 +388,7 @@ For always-on debugging self-checks:
> 
> > ./configure --enable-rcu-debug
> 
> > For fine grained enabling of debugging self-checks, build
> 
> > -urserspace-rcu with DEBUG_RCU defined and compile dependent
> 
> > +userspace-rcu with DEBUG_RCU defined and compile dependent
> 
> > applications with DEBUG_RCU defined when necessary.
> 
> > Warning: Enabling this feature result in a performance penalty.
> 
> > --
> 
> > 2.23.0
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
