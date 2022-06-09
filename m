Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2C6C433EF
	for <lttng-dev@archiver.kernel.org>; Thu,  9 Jun 2022 17:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1654797275;
	bh=ZvWenfeHlnIGrAY8pAxWOCHyv1HQv1Mb2iW+p1wAdBs=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=uEL4U5522QN23otqX6WwsEYjixZCtY/x8vIGkYDbVXzk85O6dZKrDXZGtS/AAR3Qw
	 p2j2IoLYYLRzyk7SxwMmGOpvnpb+Wq0AjBXjuZOC9ylOlk0j766EYWDc6vPOPVVqLH
	 jAdvJfV9VFcrHim6MA+F53s+DTdDK+bTdVYc6WytjGlXvBvdApcIMIaddvzjTc+rPS
	 +O+PO+HRgzt/yAn2psmRHy27gQrjXOgr/6y3HCLPugz4rGEEJ/b73ggXjuEkaFhYNy
	 0NGF7Ck7QySW7d6pfwj5j+RdtTylhw2fBPppCe6I6gAcQFcjmsWB9UvIcV1PnxLj5s
	 QKiBZelWtFWyA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LJsDV5lXWz6wm;
	Thu,  9 Jun 2022 13:54:34 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4LJsDT2c2wz6j0
 for <lttng-dev@lists.lttng.org>; Thu,  9 Jun 2022 13:54:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id BAF44411D5E
 for <lttng-dev@lists.lttng.org>; Thu,  9 Jun 2022 13:54:32 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 0Mq2yaRfWkbt; Thu,  9 Jun 2022 13:54:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 23637411BB6;
 Thu,  9 Jun 2022 13:54:32 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 23637411BB6
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id AIkOt_sd4GW1; Thu,  9 Jun 2022 13:54:32 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 187B9411970;
 Thu,  9 Jun 2022 13:54:32 -0400 (EDT)
Date: Thu, 9 Jun 2022 13:54:31 -0400 (EDT)
To: yaowenbin <yaowenbin1@huawei.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, h00486469 <hewenliang4@huawei.com>, 
 wuxu wu <wuxu.wu@huawei.com>, linfeilong <linfeilong@huawei.com>
Message-ID: <1171026491.43508.1654797271985.JavaMail.zimbra@efficios.com>
In-Reply-To: <9deb745d-bf26-9a9a-9f00-6a4c5104183d@huawei.com>
References: <9deb745d-bf26-9a9a-9f00-6a4c5104183d@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4272 (ZimbraWebClient - FF100
 (Linux)/8.8.15_GA_4257)
Thread-Topic: Use lu% instead ld% to print count
Thread-Index: 55YH6nisglD8ZN5UHiacp3AFyuWbJA==
Subject: Re: [lttng-dev] [PATCH] Use lu% instead ld% to print count
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

----- On Jun 8, 2022, at 11:08 PM, yaowenbin via lttng-dev lttng-dev@lists.lttng.org wrote:

> In ht_count_del function, the type of count variable is defined as unsigned
> long,
> so use lu% instead ld% to print it.

Merged into urcu master, stable-0.13 and stable-0.12 branches, thanks!

Mathieu

> 
> Signed-off-by: yaowenbin1 <yaowenbin1@huawei.com>
> ---
> src/rculfhash.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/rculfhash.c b/src/rculfhash.c
> index 8046f3a..872d6ff 100644
> --- a/src/rculfhash.c
> +++ b/src/rculfhash.c
> @@ -763,7 +763,7 @@ void ht_count_del(struct cds_lfht *ht, unsigned long size,
> unsigned long hash)
> 
> 	if ((count >> CHAIN_LEN_RESIZE_THRESHOLD) >= size)
> 		return;
> -	dbg_printf("del set global %ld\n", count);
> +	dbg_printf("del set global %lu\n", count);
> 	/*
> 	 * Don't shrink table if the number of nodes is below a
> 	 * certain threshold.
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
