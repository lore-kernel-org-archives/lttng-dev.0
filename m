Return-Path: <SRS0=L1Ep=JQ=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9F8C433B4
	for <lttng-dev@archiver.kernel.org>; Mon, 19 Apr 2021 15:31:58 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D933D60FF3
	for <lttng-dev@archiver.kernel.org>; Mon, 19 Apr 2021 15:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D933D60FF3
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FP9lv1Fp5z1YVQ;
	Mon, 19 Apr 2021 11:31:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1618846315;
	bh=+jQ2NZziseW4iFB2Jx2t4eI4nG17VfIJBDc+oHMKhE0=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=0pzKyxb5feioLgAH1yKpxU5Fj2gB3dBpjkrbuHeR+i2erW5sMcGSm7XTN8Jca6hzX
	 C1aWCu6D3WBobpU/W+/uxStbebM7ZC8DhFE2TACHHv2yMBNyeE7MQbOzTbEeQFAPaG
	 QuxXwceXj4rKVsl6yyZc3F11q8s8lq5oObm/mUSJ1upGC6DNw6slrolNwdmM7tPFEE
	 iRsuQ/+balnRQtLPe6S9Z6uL9CCy/5+iuR2Y9mzYIvQTFpJlXmh0FKM5wwbcPme11K
	 CZTdlcoKbkbX1tBY0oFx5HcW7jzG45CMa5s6NW27aprWwbyXCTcAMUTpKbE4P1xxj9
	 dq5fk4X1bxVBw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FP9ls4xwXz1WLj
 for <lttng-dev@lists.lttng.org>; Mon, 19 Apr 2021 11:31:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 0BCFC2DC967
 for <lttng-dev@lists.lttng.org>; Mon, 19 Apr 2021 11:31:46 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id vFL1SnCaoW0d; Mon, 19 Apr 2021 11:31:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 904002DC8D3;
 Mon, 19 Apr 2021 11:31:45 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 904002DC8D3
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id lk1KznslQvk6; Mon, 19 Apr 2021 11:31:45 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 7E3E52DC9DD;
 Mon, 19 Apr 2021 11:31:45 -0400 (EDT)
Date: Mon, 19 Apr 2021 11:31:45 -0400 (EDT)
To: Duncan Sands <baldrick@free.fr>, paulmck <paulmck@kernel.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1645001619.285.1618846305316.JavaMail.zimbra@efficios.com>
In-Reply-To: <7972b031-59b9-7fb5-6379-58bcec13a769@free.fr>
References: <1680415903.81652.1618584736742.JavaMail.zimbra@efficios.com>
 <0b613c40-24b4-6836-d47b-705ac0e46386@free.fr>
 <612661965.84539.1618605578871.JavaMail.zimbra@efficios.com>
 <7972b031-59b9-7fb5-6379-58bcec13a769@free.fr>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: liburcu: LTO breaking rcu_dereference on arm64 and possibly
 other architectures ?
Thread-Index: 5wRiM4738o8hJu7t5gIasyRX88mAYw==
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

----- On Apr 19, 2021, at 5:41 AM, Duncan Sands baldrick@free.fr wrote:


> 
>> Quick question: should we use __atomic_load() or atomic_load_explicit() (C) and
>> (std::atomic<__typeof__(x)>)(x)).load() (C++) ?
> 
> If both are available, is there any advantage to using the C++ version when
> compiling C++?  As opposed to using the C11 one for both C and C++?

I recently noticed that using C11/C++11 atomic load explicit is not a good
fit for rcu_dereference, because we want the type to be a pointer, not an
_Atomic type. gcc appears to accept a looser typing, but clang has issues
trying to build that code.

So I plan to use __atomic(p, v, __ATOMIC_CONSUME) instead in both C and C++.

Also, I'll drop the cmm_smp_read_barrier_depends() when using __ATOMIC_CONSUME,
because AFAIU their memory ordering semantics are redundant for rcu_dereference.

Here is the resulting commit for review on gerrit:

https://review.lttng.org/c/userspace-rcu/+/5455 Fix: use __atomic_load() rather than atomic load explicit [NEW]

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
