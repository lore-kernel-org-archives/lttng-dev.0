Return-Path: <SRS0=L1Ep=JQ=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA50C433B4
	for <lttng-dev@archiver.kernel.org>; Mon, 19 Apr 2021 15:50:00 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D560610CC
	for <lttng-dev@archiver.kernel.org>; Mon, 19 Apr 2021 15:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D560610CC
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FPB8k02p8z1YVR;
	Mon, 19 Apr 2021 11:49:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1618847398;
	bh=HCQDkv2bnSm0dF7+1ieMSUlBPzS0T/2CheQkPxiHmZ8=;
	h=To:Cc:References:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=bnf8225V0736zQTCXRuDkxn677wdwkwvVSO+YFxbFXRzGw37GIkC3NvJ0kcrdEPvK
	 LLfuZDUcuNUTnGzBIVZUnDqZXDjdJwjZrHumwIxMqeJPPfposh9VWU1w33sNI3rseY
	 RWjvvsvXMxYJJEE0Nj5qsba67MXuu3b3dv73AT2uncOA0NJdjldboY3fUfEQR31L+x
	 uziyoW3YLpsDcyEai9uvPhI5wKE2XNn77GpWSRTo6nDe4t89e2+PBoLQ84LEDvQ/xf
	 Oitt72LCV7lD33wSOIhUMYDGYfMJhw66HxQR1PjtHeheClWNoWRXEi/tXXUNhIvWf7
	 IgOldvuaCqigw==
Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
 by lists.lttng.org (Postfix) with ESMTP id 4FPB8g3ghbz1YnM
 for <lttng-dev@lists.lttng.org>; Mon, 19 Apr 2021 11:49:54 -0400 (EDT)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by smtpfb1-g21.free.fr (Postfix) with ESMTP id 08963DF9EFC
 for <lttng-dev@lists.lttng.org>; Mon, 19 Apr 2021 17:41:36 +0200 (CEST)
Received: from [IPv6:2a01:e0a:255:1000:9758:d0a7:7a4a:7b3e] (unknown
 [IPv6:2a01:e0a:255:1000:9758:d0a7:7a4a:7b3e])
 (Authenticated sender: duncan.sands@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 6A773780306;
 Mon, 19 Apr 2021 17:41:16 +0200 (CEST)
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 paulmck <paulmck@kernel.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
References: <1680415903.81652.1618584736742.JavaMail.zimbra@efficios.com>
 <0b613c40-24b4-6836-d47b-705ac0e46386@free.fr>
 <612661965.84539.1618605578871.JavaMail.zimbra@efficios.com>
 <7972b031-59b9-7fb5-6379-58bcec13a769@free.fr>
 <1645001619.285.1618846305316.JavaMail.zimbra@efficios.com>
Message-ID: <66ce5b4b-1992-26ab-9d76-e6a30ab2bbba@free.fr>
Date: Mon, 19 Apr 2021 17:41:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1645001619.285.1618846305316.JavaMail.zimbra@efficios.com>
Content-Language: en-US
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
From: Duncan Sands via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Duncan Sands <baldrick@free.fr>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Mathieu,

On 4/19/21 5:31 PM, Mathieu Desnoyers wrote:
> ----- On Apr 19, 2021, at 5:41 AM, Duncan Sands baldrick@free.fr wrote:
> 
> 
>>
>>> Quick question: should we use __atomic_load() or atomic_load_explicit() (C) and
>>> (std::atomic<__typeof__(x)>)(x)).load() (C++) ?
>>
>> If both are available, is there any advantage to using the C++ version when
>> compiling C++?  As opposed to using the C11 one for both C and C++?
> 
> I recently noticed that using C11/C++11 atomic load explicit is not a good
> fit for rcu_dereference, because we want the type to be a pointer, not an
> _Atomic type. gcc appears to accept a looser typing, but clang has issues
> trying to build that code.

in the long run maybe the original variables should be declared with the 
appropriate atomic type from the get-go.

> So I plan to use __atomic(p, v, __ATOMIC_CONSUME) instead in both C and C++.
> 
> Also, I'll drop the cmm_smp_read_barrier_depends() when using __ATOMIC_CONSUME,
> because AFAIU their memory ordering semantics are redundant for rcu_dereference.

Yeah, keeping the barrier makes no sense in that case.

> 
> Here is the resulting commit for review on gerrit:
> 
> https://review.lttng.org/c/userspace-rcu/+/5455 Fix: use __atomic_load() rather than atomic load explicit [NEW]

Looks good to me (I didn't test it though).

Ciao, Duncan.
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
