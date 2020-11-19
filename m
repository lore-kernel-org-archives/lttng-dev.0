Return-Path: <SRS0=mbq0=EZ=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0552BC63697
	for <lttng-dev@archiver.kernel.org>; Thu, 19 Nov 2020 16:44:19 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7B9E2222A
	for <lttng-dev@archiver.kernel.org>; Thu, 19 Nov 2020 16:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="TwNqtKLh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B9E2222A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CcQW33lZZz1KrV;
	Thu, 19 Nov 2020 11:44:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1605804256;
	bh=EslBSajPm3IaeK6TaPCc5euZbrUkJ8yyddhi3T5is5I=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=TwNqtKLhjLNvwBL+7fNppbFunv0+LdcCi4xC5B4eoiNt+BoPq85kJA0tIWfnL1rQW
	 lX0yU9AzAPisO8Q1ebXZkWvRtkdTY02siHOiJmSGhk8YXBNtYwwGS67Lk40jEIOEKa
	 J0ah4RSzU7dHfLci8nwwKiZdBFV41ZVZxhEKs4mOZ3ZYv9Z4V/HL74Ks//vgzagSGw
	 03kal4DN9CIrGa+xDA+O9kAaDIQGPgSmGugTchvadl2aBo/OZcUlVrzesxKjsSvIzB
	 AXZE4NiuaHzOEsM5zvIX9PPmkki+LpGU35aqRERDWgUXpk9Uf7DzUJzUI5lB0jWvCR
	 qdEKmhJeJZ0Iw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4CcQW16VXdz1KlQ
 for <lttng-dev@lists.lttng.org>; Thu, 19 Nov 2020 11:44:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 70D402EF7DA;
 Thu, 19 Nov 2020 11:44:07 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id ReDZi8uZfRQQ; Thu, 19 Nov 2020 11:44:07 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 25D9A2EFB98;
 Thu, 19 Nov 2020 11:44:07 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 25D9A2EFB98
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id M77O2M38CbSK; Thu, 19 Nov 2020 11:44:07 -0500 (EST)
Received: from multivac.lan (96-127-212-112.qc.cable.ebox.net [96.127.212.112])
 by mail.efficios.com (Postfix) with ESMTPSA id 023492EFB97;
 Thu, 19 Nov 2020 11:44:06 -0500 (EST)
To: lttng-dev@lists.lttng.org
Date: Thu, 19 Nov 2020 11:43:54 -0500
Message-Id: <20201119164354.516289-1-mjeanson@efficios.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH urcu] Add git-review config
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

Add .gitreview for contributors wishing to use gerrit for patch
reviews.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Change-Id: I7868b3fc3162246298f24bd90ac1a3bcf6083eb6
---
 .gitreview | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 .gitreview

diff --git a/.gitreview b/.gitreview
new file mode 100644
index 0000000..84299ac
--- /dev/null
+++ b/.gitreview
@@ -0,0 +1,7 @@
+[gerrit]
+host=review.lttng.org
+port=29418
+project=userspace-rcu.git
+defaultbranch=master
+defaultremote=review
+defaultrebase=0
-- 
2.29.2

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
