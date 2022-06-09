Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855F9C43334
	for <lttng-dev@archiver.kernel.org>; Thu,  9 Jun 2022 15:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1654789341;
	bh=CO4HSJq4QclbHnt6Wb/BNj/JbD+RYtmL8oQT9d4kh6k=;
	h=Date:To:CC:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=pXSk+gNxtC6rdkgRQpIkbZ7uHTQKcJMj99l19qBdcvmgejoWNBXo6+wnW2EAXlesh
	 kgblIpmZYj1DeYP7KThwnDUC6faO7dTITzsabJmRE+GZ85leks+qdyRrGrP8xskQVj
	 s2O1oZgSJ8qo1Tnt+WL3GAYWl/cQZ20Lx9D30J2rVpnD/4jL1AmIiDYau8Zs2oYOgq
	 u0wl3RuK85O08HdCs4W2/B/4Js76+adLlbVWra9a/n8hAQSTupsakkLuvwauOmCbL7
	 R8HAcah7ael0sEVTPULJnGz9FcFL2rdy/Uo8+FBVrzD3VsrhPnBCpo4rM1l/GoP9o9
	 SZ5pnRONS43dg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LJpHw4Pk0z6qT;
	Thu,  9 Jun 2022 11:42:20 -0400 (EDT)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by lists.lttng.org (Postfix) with ESMTPS id 4LJV0w3b3sz6Sb
 for <lttng-dev@lists.lttng.org>; Wed,  8 Jun 2022 23:28:16 -0400 (EDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LJTXp36VWzjYRj
 for <lttng-dev@lists.lttng.org>; Thu,  9 Jun 2022 11:07:22 +0800 (CST)
Received: from dggpeml500002.china.huawei.com (7.185.36.158) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 11:08:43 +0800
Received: from [10.174.179.208] (10.174.179.208) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 11:08:43 +0800
Message-ID: <9deb745d-bf26-9a9a-9f00-6a4c5104183d@huawei.com>
Date: Thu, 9 Jun 2022 11:08:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
To: <lttng-dev@lists.lttng.org>
CC: "hewenliang (C)" <hewenliang4@huawei.com>, <wuxu.wu@huawei.com>,
 <linfeilong@huawei.com>, <yaowenbin1@huawei.com>
X-Originating-IP: [10.174.179.208]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 09 Jun 2022 11:42:19 -0400
Subject: [lttng-dev] [PATCH] Use lu% instead ld% to print count
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
From: yaowenbin via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: yaowenbin <yaowenbin1@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

In ht_count_del function, the type of count variable is defined as unsigned long,
so use lu% instead ld% to print it.

Signed-off-by: yaowenbin1 <yaowenbin1@huawei.com>
---
 src/rculfhash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/rculfhash.c b/src/rculfhash.c
index 8046f3a..872d6ff 100644
--- a/src/rculfhash.c
+++ b/src/rculfhash.c
@@ -763,7 +763,7 @@ void ht_count_del(struct cds_lfht *ht, unsigned long size, unsigned long hash)

 	if ((count >> CHAIN_LEN_RESIZE_THRESHOLD) >= size)
 		return;
-	dbg_printf("del set global %ld\n", count);
+	dbg_printf("del set global %lu\n", count);
 	/*
 	 * Don't shrink table if the number of nodes is below a
 	 * certain threshold.
-- 
2.27.0
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
