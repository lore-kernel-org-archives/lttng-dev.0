Return-Path: <SRS0=dYoO=KP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE884C433ED
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 15:38:30 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79489610A2
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 15:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79489610A2
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FmDR9157Yz1rd6;
	Thu, 20 May 2021 11:38:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621525109;
	bh=qwQUbiYJN2mhqUUB7w26jAicW3pmKRlwlULVAeMdQOY=;
	h=To:Cc:References:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ZSEZmgBkoINLLf6jKlgntMqlDXJs4iOjTFcvc8x+VpswlCyCZz5IJQdSLefnAkAoe
	 adFOguVEUxUA4QxTLdCwOlKgT5jQoyfLjjQsjh9mgy35NOOR8Qcd5VWWy6kuHY711i
	 N1c89A5j7od9tqsXyPlFnd0vQluiCKZaCrZ7dSay0lJ/M7AQHvMzyXtb2KMldTHHUe
	 pMEjW7Dnl73jkMsh8x0p56uJhQy2HQ4xujGvRq9M8jQoXX4cegGke4LUt4Xqp5Qekn
	 7YhrPhvPQ/azRxO2Cx/iczMi/vBmCt3UW5uvl0HR8c9U0Ev60XFit6UKYhjd3pOTOn
	 Y76E1czq8Ua/w==
Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by lists.lttng.org (Postfix) with ESMTPS id 4FmDR74K0sz1rXy
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 11:38:27 -0400 (EDT)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 14KFYrpF010734
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 May 2021 17:34:54 +0200
Received: from [167.87.240.49] ([167.87.240.49])
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 14KFYqiR024658;
 Thu, 20 May 2021 17:34:53 +0200
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Norbert Lange <nolange79@gmail.com>
Cc: MONTET Julien <julien.montet@reseau.eseo.fr>,
 lttng-dev <lttng-dev@lists.lttng.org>, Xenomai <xenomai@xenomai.org>
References: <PR3PR02MB6202C5373D6CECC72EBF45DAD12B9@PR3PR02MB6202.eurprd02.prod.outlook.com>
 <CADYdroOAiKwD_um-ONn=UfNQrOxjs0fM-7ozhUNc18jUQX9cQw@mail.gmail.com>
 <AM7PR02MB6194C2E06B14077092AA06A0D12A9@AM7PR02MB6194.eurprd02.prod.outlook.com>
 <CADYdroNm+rLkqXV3tjtQ94_PQM_mTiHvmx3JzJG5h2YHbRfguA@mail.gmail.com>
 <851697925.52293.1621518874455.JavaMail.zimbra@efficios.com>
 <201689209.52304.1621519010729.JavaMail.zimbra@efficios.com>
 <186729016.52398.1621523346736.JavaMail.zimbra@efficios.com>
Message-ID: <d82e8eb6-9cb4-3873-5952-648d73d8f0ac@siemens.com>
Date: Thu, 20 May 2021 17:34:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <186729016.52398.1621523346736.JavaMail.zimbra@efficios.com>
Content-Language: en-US
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
From: Jan Kiszka via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 20.05.21 17:09, Mathieu Desnoyers wrote:
> ----- On May 20, 2021, at 9:56 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
> 
>> ----- On May 20, 2021, at 9:54 AM, lttng-dev lttng-dev@lists.lttng.org wrote:
>>
>>> ----- On May 20, 2021, at 5:11 AM, lttng-dev lttng-dev@lists.lttng.org wrote:
>>>
>>>> Am Do., 20. Mai 2021 um 10:28 Uhr schrieb MONTET Julien
>>>> <julien.montet@reseau.eseo.fr>:
>>>>>
>>>>> Hi Norbert,
>>>>>
>>>>> Thank you for your answer !
>>>>>
>>>>> Yes, I am using a Xenomai cobalt - xenomai is 3.1
>>>>> cat /proc/xenomai/version => 3.1
>>>>>
>>>>> After the installation, I tested "test tools" in /proc/xenomai/ and it worked
>>>>> nice.
>>>>
>>>> Just asked to make sure, thought the scripts usual add some -xeno tag
>>>> to the kernel version.
>>>>
>>>>> What do you mean by "it might deadlock really good" ?
>>>>
>>>> clock_gettime will either use a syscall (kills realtime always) or is
>>>> optimized via VDSO (which very likely is your case).
>>>>
>>>> What happens is that the kernel will take a spinlock, then write new
>>>> values, then releases the spinlock.
>>>> your program will aswell spin (but just to see if the spinlock is
>>>> free), read the values and interpolates them.
>>>>
>>>> But if your program interrupts the kernel while the kernel holds the
>>>> lock (all on the same cpu core), then it will spin forever and the
>>>> kernel will never execute.
>>>
>>> Just one clarification: the specific locking strategy used by the
>>> Linux kernel monotonic clock vDSO is a "seqlock", where the kernel
>>> sets a bit which keeps concurrent readers looping until they observe
>>
>> When I say "sets a bit", I actually mean "increment a sequence counter",
>> and readers observe either odd or even state, thus knowing whether
>> they need to retry, and whether the value read before/after reading
>> the data structure changed.
> 
> Looking again at the Linux kernel's kernel/time/vsyscall.c implementation
> of vdso_update_{begin,end}, I notice that interrupts are disabled across
> the entire update. So I understand that the Interrupt pipeline (I-pipe)
> interrupt gets delivered even when the kernel disables interrupts. Did
> you consider modifying the I-pipe kernel patch to change the vdso update so
> it updates the vdso from within an I-pipe virq handler ?
> 
> AFAIU this would allow Xenomai userspace to use the Linux kernel vDSO
> clock sources.

In fact, this is what happens with upcoming Xenomai 3.2, based on the
Dovetail kernel patch (replacement of I-pipe). Implies kernel 5.10.

For I-pipe, we have the CLOCK_HOST_REALTIME infrastructure to obtain the
kernel's view on CLOCK_REALTIME from within an Xenomai task. That is
available up to kernel 5.4.

HTH,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
