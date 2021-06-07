Return-Path: <SRS0=w+6D=LB=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE11C47094
	for <lttng-dev@archiver.kernel.org>; Mon,  7 Jun 2021 21:37:57 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 540DD61208
	for <lttng-dev@archiver.kernel.org>; Mon,  7 Jun 2021 21:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 540DD61208
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FzRYX5Rkyz8Pg;
	Mon,  7 Jun 2021 17:37:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1623101873;
	bh=PspkxnNv37WLPZyUQVUCcOG6g+FzBbfnBfyZdGTQg0E=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ZZsX8Bt7oSp2ttagz9mx75WqodcuGk0ROXMlzPezQgTYDpL8kRsZHLWhtI+ZPoANg
	 pgs/VYgpzyKKLqSiNnlAQu5yTbUhde0uPoqRPBS39y054Y74ChHIM0zb8P+/R+1Iuy
	 G1YNjd1q6Vbpm2aIjclkv5sMnt35FYEy5/c6Y4Fzn9UGWT58Pd+AUoyqgZc7C6Koem
	 JxVSDMRVVIsDjFl6k9PFGek2NVhYSWzF2uB6mzMwWwBbMFWz4hh5JDaXOv+OpSrcyw
	 uPEumWC08Bckk83BMUkibv6y7yjeIuGwl5ikpGKUUlihxBSb12niuDEOkIDRYEubGM
	 Kb7MBJmuGbzKA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FzRYV2snlz83R
 for <lttng-dev@lists.lttng.org>; Mon,  7 Jun 2021 17:37:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 16ED433AAF1
 for <lttng-dev@lists.lttng.org>; Mon,  7 Jun 2021 17:37:44 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id P-Joozu3c_3i; Mon,  7 Jun 2021 17:37:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 0B27933AECD;
 Mon,  7 Jun 2021 17:37:43 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0B27933AECD
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id bb0eKpnusqG2; Mon,  7 Jun 2021 17:37:43 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id F2D8633AECA;
 Mon,  7 Jun 2021 17:37:42 -0400 (EDT)
Date: Mon, 7 Jun 2021 17:37:42 -0400 (EDT)
To: MONTET Julien <julien.montet@reseau.eseo.fr>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1243846196.16607.1623101862930.JavaMail.zimbra@efficios.com>
In-Reply-To: <PR3PR02MB6202A92FD29EA41CDB8CAE56D1389@PR3PR02MB6202.eurprd02.prod.outlook.com>
References: <PR3PR02MB6202F326FC88DD8F3EF90596D13B9@PR3PR02MB6202.eurprd02.prod.outlook.com>
 <947236961.14801.1623079468191.JavaMail.zimbra@efficios.com>
 <PR3PR02MB6202A92FD29EA41CDB8CAE56D1389@PR3PR02MB6202.eurprd02.prod.outlook.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - GC90 (Linux)/8.8.15_GA_4026)
Thread-Topic: LTTng 32 bits on 64 bits systems - kernel events... but no
 user-event
Thread-Index: AQHXWTyXrFTi8gSpG0+XSeNSyXv/wIZFEyc2pMOhZpp2G8V5yA==
Subject: Re: [lttng-dev] LTTng 32 bits on 64 bits systems - kernel events...
 but no user-event
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Julien,

A fix is on the way for libfd-tracker lib problem: 

https://review.lttng.org/c/lttng-tools/+/6045 

> Thank you ! The following modification is working :
> lttng-sessiond --consumerd32-libdir=/usr/local/lib32
> --consumerd32-path=/usr/local/lib32/lttng/libexec/lttng-consumerd --daemonize

Glad we could help.

Cheers
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
