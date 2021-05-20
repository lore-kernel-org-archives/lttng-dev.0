Return-Path: <SRS0=dYoO=KP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61817C433B4
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 13:54:45 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A553860FF3
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 13:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A553860FF3
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FmB7R1jFZz1rZw;
	Thu, 20 May 2021 09:54:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621518883;
	bh=No89yfSNhPnTINUwJxosMCl5xQdFz0pLX4gezFcQli8=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=kokzCZTh0oqfdKCMp4mJBKJ4P6Z+VgO2C6hoRHwc9MEXM3TRbsslevFMJ+16z/cVh
	 4Ect1B3Nv48Y48YcE9yLvu7JYEuaSBziaKhWPCwHAdJUXzL5fBf248OcSZWStNERWQ
	 Tvb+XA1Vd//Bp7SnA06eTqfA1vHz3TcwulyhBII7QVuE1d1kDxGSTpHb27X4300sy2
	 iSlgf3dYbKDEpR1rUovV4HA5JCalB4YGUjP0OrFb+VLkqVFEzojZeLxZn+fmyLjXuu
	 mHacdQ83dGPXEIH1FCQyyUpD/L/qvpB9yfYR2FVthM4+v+ckIyBLpwVmbRxiTWeDmC
	 aCjHMVNR7QLcQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FmB7Q0mRCz1rjF
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 09:54:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 0F3E0335D91
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 09:54:35 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Xligu5xzw4t3; Thu, 20 May 2021 09:54:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 90402335C1E;
 Thu, 20 May 2021 09:54:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 90402335C1E
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id uHcffIqA8Z5v; Thu, 20 May 2021 09:54:34 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 87679335D15;
 Thu, 20 May 2021 09:54:34 -0400 (EDT)
Date: Thu, 20 May 2021 09:54:34 -0400 (EDT)
To: Norbert Lange <nolange79@gmail.com>
Cc: MONTET Julien <julien.montet@reseau.eseo.fr>, 
 lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <851697925.52293.1621518874455.JavaMail.zimbra@efficios.com>
In-Reply-To: <CADYdroNm+rLkqXV3tjtQ94_PQM_mTiHvmx3JzJG5h2YHbRfguA@mail.gmail.com>
References: <PR3PR02MB6202C5373D6CECC72EBF45DAD12B9@PR3PR02MB6202.eurprd02.prod.outlook.com>
 <CADYdroOAiKwD_um-ONn=UfNQrOxjs0fM-7ozhUNc18jUQX9cQw@mail.gmail.com>
 <AM7PR02MB6194C2E06B14077092AA06A0D12A9@AM7PR02MB6194.eurprd02.prod.outlook.com>
 <CADYdroNm+rLkqXV3tjtQ94_PQM_mTiHvmx3JzJG5h2YHbRfguA@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF88 (Linux)/8.8.15_GA_4007)
Thread-Topic: LTTng - Xenomai : different results between timestamp-lttng and
 rt_time_read()
Thread-Index: LenyeMWsOSMGTQnSnZcKgfCjkToz+Q==
Subject: Re: [lttng-dev] LTTng - Xenomai : different results between
 timestamp-lttng and rt_time_read()
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

----- On May 20, 2021, at 5:11 AM, lttng-dev lttng-dev@lists.lttng.org wrote:

> Am Do., 20. Mai 2021 um 10:28 Uhr schrieb MONTET Julien
> <julien.montet@reseau.eseo.fr>:
>>
>> Hi Norbert,
>>
>> Thank you for your answer !
>>
>> Yes, I am using a Xenomai cobalt - xenomai is 3.1
>> cat /proc/xenomai/version => 3.1
>>
>> After the installation, I tested "test tools" in /proc/xenomai/ and it worked
>> nice.
> 
> Just asked to make sure, thought the scripts usual add some -xeno tag
> to the kernel version.
> 
>> What do you mean by "it might deadlock really good" ?
> 
> clock_gettime will either use a syscall (kills realtime always) or is
> optimized via VDSO (which very likely is your case).
> 
> What happens is that the kernel will take a spinlock, then write new
> values, then releases the spinlock.
> your program will aswell spin (but just to see if the spinlock is
> free), read the values and interpolates them.
> 
> But if your program interrupts the kernel while the kernel holds the
> lock (all on the same cpu core), then it will spin forever and the
> kernel will never execute.

Just one clarification: the specific locking strategy used by the
Linux kernel monotonic clock vDSO is a "seqlock", where the kernel
sets a bit which keeps concurrent readers looping until they observe
a consistent value. With Xenomai it indeed appears to be prone to
deadlock if a high priority Xenomai thread interrupts the kernel
while the write seqlock is held, and then proceeds to loop forever
on the read-side of the seqlock.

Note that for the in-kernel tracer clock read use-case, which
needs to be able to happen from NMI context, I've contributed a
modified version of the seqlock to the Linux kernel:

https://lwn.net/Articles/831540/ The seqcount latch lock type

It basically keeps two copies of the clock data structures, so the
read-side never has to loop waiting for the updater: it simply gets
redirected to the "stable" copy of the data.

The trade-off here is that with the latch lock used for clocks, a
reader may observe time going slightly backwards between two clock
reads when reading while specific clock rate adjustments are made
by an updater. The clock user needs to be aware of this.

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
