Return-Path: <SRS0=L1Ep=JQ=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF950C43460
	for <lttng-dev@archiver.kernel.org>; Mon, 19 Apr 2021 15:54:48 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3236F6128C
	for <lttng-dev@archiver.kernel.org>; Mon, 19 Apr 2021 15:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3236F6128C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FPBGG465Gz1WVL;
	Mon, 19 Apr 2021 11:54:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1618847687;
	bh=GZrMJx9PmkDgEr0bXDrunxlMGLpseTjep85hPuxsB7k=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=p1IdBN4UdPGdsxdX/5+0uOieRUrVeG2YXTch6BLXfNBRlJnRHWPtQa7TZXTiMuGu4
	 O6StXdOXL8EAi6DdNsO+13WxYeGzE4qJES099TNCoHmQyaW2dgSf5O0RAoK4NemJfj
	 a+E25KwEPIBZs03vn6aL1VmkCutX9+REkHtkS2peLQlc71ze9jQoNdHB8Cxo36fYe7
	 u7Y7Nan7ckhNygv/+Gw1Vmwp6rpADJyxHHGs62kOl1pCH2hi/dZeWYp0BxDXavAgRo
	 kq62YfuSPQP7LwHJp6N10cR4OT1OdWmN8oIQJdOi5P1RdnLQWshjx5Dl9NmYAHW7nJ
	 0bTNkCPh+M70g==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FPBGD38FYz1Yqc
 for <lttng-dev@lists.lttng.org>; Mon, 19 Apr 2021 11:54:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id DEB862DCC47
 for <lttng-dev@lists.lttng.org>; Mon, 19 Apr 2021 11:54:38 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id EWc3ilsSvCDY; Mon, 19 Apr 2021 11:54:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id DECCC2DCDE1;
 Mon, 19 Apr 2021 11:54:37 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com DECCC2DCDE1
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id EpZrKNZCokVD; Mon, 19 Apr 2021 11:54:37 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id D368B2DCDD2;
 Mon, 19 Apr 2021 11:54:37 -0400 (EDT)
Date: Mon, 19 Apr 2021 11:54:37 -0400 (EDT)
To: Duncan Sands <baldrick@free.fr>
Cc: paulmck <paulmck@kernel.org>, lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <2073969799.507.1618847677716.JavaMail.zimbra@efficios.com>
In-Reply-To: <66ce5b4b-1992-26ab-9d76-e6a30ab2bbba@free.fr>
References: <1680415903.81652.1618584736742.JavaMail.zimbra@efficios.com>
 <0b613c40-24b4-6836-d47b-705ac0e46386@free.fr>
 <612661965.84539.1618605578871.JavaMail.zimbra@efficios.com>
 <7972b031-59b9-7fb5-6379-58bcec13a769@free.fr>
 <1645001619.285.1618846305316.JavaMail.zimbra@efficios.com>
 <66ce5b4b-1992-26ab-9d76-e6a30ab2bbba@free.fr>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: liburcu: LTO breaking rcu_dereference on arm64 and possibly
 other architectures ?
Thread-Index: 3nNQj6fp80fiMHHApJwrkbEJTPDwMQ==
Subject: Re: [lttng-dev] liburcu: LTO breaking rcu_dereference on arm64 and
 possibly other architectures ?
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

----- On Apr 19, 2021, at 11:41 AM, Duncan Sands baldrick@free.fr wrote:

> Hi Mathieu,
> 
> On 4/19/21 5:31 PM, Mathieu Desnoyers wrote:
>> ----- On Apr 19, 2021, at 5:41 AM, Duncan Sands baldrick@free.fr wrote:
>> 
>> 
>>>
>>>> Quick question: should we use __atomic_load() or atomic_load_explicit() (C) and
>>>> (std::atomic<__typeof__(x)>)(x)).load() (C++) ?
>>>
>>> If both are available, is there any advantage to using the C++ version when
>>> compiling C++?  As opposed to using the C11 one for both C and C++?
>> 
>> I recently noticed that using C11/C++11 atomic load explicit is not a good
>> fit for rcu_dereference, because we want the type to be a pointer, not an
>> _Atomic type. gcc appears to accept a looser typing, but clang has issues
>> trying to build that code.
> 
> in the long run maybe the original variables should be declared with the
> appropriate atomic type from the get-go.

Considering that rcu_dereference is public API, we would have to wait until we
do a major soname ABI bump _and_ an API break to do that, which I am very
reluctant to do, especially for the API break part.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
