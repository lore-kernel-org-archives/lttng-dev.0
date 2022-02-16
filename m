Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B49C433FE
	for <lttng-dev@archiver.kernel.org>; Wed, 16 Feb 2022 17:01:57 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JzPPw0qD3zKn;
	Wed, 16 Feb 2022 12:01:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1645030916;
	bh=KUkTG7YV9lvZ7JpYtiGN+EGcgrIiG7Cl6Qf3J8brAY0=;
	h=Date:To:CC:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=pPlEwxY1cJduUJoxZPoc5x07XVB+rwu9W6gdSh5GGv72Nry8IYl+je+uTNYZgyJ0t
	 XAA4aXlxFGFw/l5GmUjDGZMbNU/BlYzIXAzJEMlFhBFfaia3MmCUeE6K8nWstP4Wtr
	 fu9Jgz7yHhUHVoMMKpyhLtAAzzYGGyN1mDKZAoqAPquT1FHjvd2BV9ziwrIF7L3OBr
	 lJa7BWMpfyZXsVuBkTKE4FH03tbJ0hUyfut0aFUaZhG+2tFLKfft2iZvvVEJeicPb9
	 Sx2dWKqzollhyO3PE/w/YxG7X6X6eEq4HRcQmoLHRH/bBcEyxzs8yOerCYo4i1lU7u
	 eHv/eZmmHZBaQ==
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by lists.lttng.org (Postfix) with ESMTPS id 4Jz9F63rcyz17cg
 for <lttng-dev@lists.lttng.org>; Wed, 16 Feb 2022 02:53:30 -0500 (EST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Jz8pF0mj7z91xd
 for <lttng-dev@lists.lttng.org>; Wed, 16 Feb 2022 15:33:41 +0800 (CST)
Received: from dggpeml500002.china.huawei.com (7.185.36.158) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Feb 2022 15:35:18 +0800
Received: from [10.174.179.208] (10.174.179.208) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Feb 2022 15:35:18 +0800
Message-ID: <bb4a9de6-3adb-bec0-1bf1-22dd25a8d5c0@huawei.com>
Date: Wed, 16 Feb 2022 15:35:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
To: <lttng-dev@lists.lttng.org>
CC: <yaowenbin1@huawei.com>, <wuxu.wu@huawei.com>, "hewenliang (C)"
 <hewenliang4@huawei.com>
X-Originating-IP: [10.174.179.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Wed, 16 Feb 2022 12:01:54 -0500
Subject: [lttng-dev] [PATCH] QSBR: Use xor operation to replace add
 operation when changing rcu_gp.ctr value
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

It is enough to have three values of rcu_gp.ctr, 00 for INACTIVE,
01 or 11 for ACTIVE. So it is possible to replace add operation
with xor operation when changing rcu_gp.ctr value.

Signed-off-by: yaowenbin <yaowenbin1@huawei.com>
---
 src/urcu-qsbr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/urcu-qsbr.c b/src/urcu-qsbr.c
index 3709412..46135f9 100644
--- a/src/urcu-qsbr.c
+++ b/src/urcu-qsbr.c
@@ -391,7 +391,7 @@ void urcu_qsbr_synchronize_rcu(void)
 		goto out;

 	/* Increment current G.P. */
-	CMM_STORE_SHARED(urcu_qsbr_gp.ctr, urcu_qsbr_gp.ctr + URCU_QSBR_GP_CTR);
+	CMM_STORE_SHARED(urcu_qsbr_gp.ctr, urcu_qsbr_gp.ctr ^ URCU_QSBR_GP_CTR);

 	/*
 	 * Must commit urcu_qsbr_gp.ctr update to memory before waiting for
-- 
2.27.0
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
