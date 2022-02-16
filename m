Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9431EC433F5
	for <lttng-dev@archiver.kernel.org>; Wed, 16 Feb 2022 20:53:29 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JzVY35k5xzLV;
	Wed, 16 Feb 2022 15:53:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1645044808;
	bh=IZAza8/YzcjcFEfqlSwWnZaPcq/qJuqfakG0jaWzS8I=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=GDtVbeDjkBq/FR/lkCv1saT/7uvh+s9I0ZgGtzITkpTi+xS0okrWVrlalsrEd+8Ri
	 3F1dolNrSmX+cTmohlVZIN5UuElRYIO4ZhTjqJRPUoNlD92gXs9sRsvLWrbZB0KcSZ
	 k3GUGPqlbNAihrfq0iJCYOksMktOIF+UpPxs3M5T1s/Cq8u23BpQMjYpy5f0pQwIi4
	 FSTP57sVV8NigRKL0dY3n7C7Aj8uuSqAziDQMVtpelYlB9q2AUZEC1ALGFz/rc/aAt
	 VprruwBP6j3HfmF6n0zy3ngijlmaEGWlms5WqPeZ1czZZFACqgwXe6qz5uVVvRKJkL
	 VJvJL2cYMYScg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4JzVY23Rncz12
 for <lttng-dev@lists.lttng.org>; Wed, 16 Feb 2022 15:53:26 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id E69122E7E64
 for <lttng-dev@lists.lttng.org>; Wed, 16 Feb 2022 15:53:20 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id PUoo9iVoyxUJ; Wed, 16 Feb 2022 15:53:20 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 890523B819B;
 Wed, 16 Feb 2022 15:53:20 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 890523B819B
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id moUcRB77xdgZ; Wed, 16 Feb 2022 15:53:20 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 7E07D3B8037;
 Wed, 16 Feb 2022 15:53:20 -0500 (EST)
Date: Wed, 16 Feb 2022 15:53:20 -0500 (EST)
To: yaowenbin <yaowenbin1@huawei.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, wuxu wu <wuxu.wu@huawei.com>, 
 h00486469 <hewenliang4@huawei.com>, paulmck <paulmck@kernel.org>
Message-ID: <2033818248.4933.1645044800494.JavaMail.zimbra@efficios.com>
In-Reply-To: <bb4a9de6-3adb-bec0-1bf1-22dd25a8d5c0@huawei.com>
References: <bb4a9de6-3adb-bec0-1bf1-22dd25a8d5c0@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF97 (Linux)/8.8.15_GA_4232)
Thread-Topic: QSBR: Use xor operation to replace add operation when changing
 rcu_gp.ctr value
Thread-Index: D3Uw2vxR5CfFTlBaIi6VTGjLlcVVmw==
Subject: Re: [lttng-dev] [PATCH] QSBR: Use xor operation to replace add
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

----- On Feb 16, 2022, at 2:35 AM, lttng-dev lttng-dev@lists.lttng.org wrote:

> It is enough to have three values of rcu_gp.ctr, 00 for INACTIVE,
> 01 or 11 for ACTIVE. So it is possible to replace add operation
> with xor operation when changing rcu_gp.ctr value.

What is missing here is a description justifying why this change is useful.

What is inherently better about XOR compared to ADD or even binary-OR ?

If it's about performance, then a benchmark on relevant architectures
would be useful. But I suspect that if end users care that much about the
performance of urcu_qsbr_synchronize_rcu(), they might be doing something
wrong.

Thanks,

Mathieu

> 
> Signed-off-by: yaowenbin <yaowenbin1@huawei.com>
> ---
> src/urcu-qsbr.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/urcu-qsbr.c b/src/urcu-qsbr.c
> index 3709412..46135f9 100644
> --- a/src/urcu-qsbr.c
> +++ b/src/urcu-qsbr.c
> @@ -391,7 +391,7 @@ void urcu_qsbr_synchronize_rcu(void)
> 		goto out;
> 
> 	/* Increment current G.P. */
> -	CMM_STORE_SHARED(urcu_qsbr_gp.ctr, urcu_qsbr_gp.ctr + URCU_QSBR_GP_CTR);
> +	CMM_STORE_SHARED(urcu_qsbr_gp.ctr, urcu_qsbr_gp.ctr ^ URCU_QSBR_GP_CTR);
> 
> 	/*
> 	 * Must commit urcu_qsbr_gp.ctr update to memory before waiting for
> --
> 2.27.0
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
