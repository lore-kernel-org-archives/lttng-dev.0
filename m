Return-Path: <SRS0=dYoO=KP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051CFC433ED
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 15:09:17 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E7460C3D
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 15:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E7460C3D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FmCnQ6z9Sz1rxb;
	Thu, 20 May 2021 11:09:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621523355;
	bh=p/wXWIrfLTzQn4YnQb5wQ9o0dQEn8bOCBAyo4YffWFU=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Au7/P4e7kgKz6GTWA9h66fGq3t61uxnLPl8u2wvMWC+yyIowAL5lMimTL0Pwisf+8
	 C7CSn6ANrUDSr1MblFN+Ur5Dmfc/cveJKty/S+ezcF8FL66QJhYw8tkS2IrmLEMrfH
	 lpBRWLRCFuf33fdvEIdt/orJSAu03fjFcyWsB4x5yfNlrluccq9MORHPHL3uRcPBZC
	 8KlaXQSCsS3VzDcmd8Djr+lp2oBk7POOq2V3XZ/AlW+dGxe9QWfLF4HJAk80KsZ8pu
	 eVMTrgC59XMIku45PZCwuCMC1e50euAhztfuuMfzXEbWzS0f0kMC/1t1JHQVfTi6sc
	 y8IT4UN14e6hg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FmCnP5kbKz1rrj
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 11:09:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 789E83363C6;
 Thu, 20 May 2021 11:09:07 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id rQJa5E5YfqUB; Thu, 20 May 2021 11:09:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D4CF7336907;
 Thu, 20 May 2021 11:09:06 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D4CF7336907
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id hwQX_KgVWmAa; Thu, 20 May 2021 11:09:06 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id C42B633647E;
 Thu, 20 May 2021 11:09:06 -0400 (EDT)
Date: Thu, 20 May 2021 11:09:06 -0400 (EDT)
To: Norbert Lange <nolange79@gmail.com>
Message-ID: <186729016.52398.1621523346736.JavaMail.zimbra@efficios.com>
In-Reply-To: <201689209.52304.1621519010729.JavaMail.zimbra@efficios.com>
References: <PR3PR02MB6202C5373D6CECC72EBF45DAD12B9@PR3PR02MB6202.eurprd02.prod.outlook.com>
 <CADYdroOAiKwD_um-ONn=UfNQrOxjs0fM-7ozhUNc18jUQX9cQw@mail.gmail.com>
 <AM7PR02MB6194C2E06B14077092AA06A0D12A9@AM7PR02MB6194.eurprd02.prod.outlook.com>
 <CADYdroNm+rLkqXV3tjtQ94_PQM_mTiHvmx3JzJG5h2YHbRfguA@mail.gmail.com>
 <851697925.52293.1621518874455.JavaMail.zimbra@efficios.com>
 <201689209.52304.1621519010729.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF88 (Linux)/8.8.15_GA_4007)
Thread-Topic: LTTng - Xenomai : different results between timestamp-lttng and
 rt_time_read()
Thread-Index: LenyeMWsOSMGTQnSnZcKgfCjkToz+cAr/zmFWrIaQ6M=
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>, lttng-dev <lttng-dev@lists.lttng.org>,
 Xenomai <xenomai@xenomai.org>, MONTET Julien <julien.montet@reseau.eseo.fr>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

----- On May 20, 2021, at 9:56 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On May 20, 2021, at 9:54 AM, lttng-dev lttng-dev@lists.lttng.org wrote:
> 
>> ----- On May 20, 2021, at 5:11 AM, lttng-dev lttng-dev@lists.lttng.org wrote:
>> 
>>> Am Do., 20. Mai 2021 um 10:28 Uhr schrieb MONTET Julien
>>> <julien.montet@reseau.eseo.fr>:
>>>>
>>>> Hi Norbert,
>>>>
>>>> Thank you for your answer !
>>>>
>>>> Yes, I am using a Xenomai cobalt - xenomai is 3.1
>>>> cat /proc/xenomai/version => 3.1
>>>>
>>>> After the installation, I tested "test tools" in /proc/xenomai/ and it worked
>>>> nice.
>>> 
>>> Just asked to make sure, thought the scripts usual add some -xeno tag
>>> to the kernel version.
>>> 
>>>> What do you mean by "it might deadlock really good" ?
>>> 
>>> clock_gettime will either use a syscall (kills realtime always) or is
>>> optimized via VDSO (which very likely is your case).
>>> 
>>> What happens is that the kernel will take a spinlock, then write new
>>> values, then releases the spinlock.
>>> your program will aswell spin (but just to see if the spinlock is
>>> free), read the values and interpolates them.
>>> 
>>> But if your program interrupts the kernel while the kernel holds the
>>> lock (all on the same cpu core), then it will spin forever and the
>>> kernel will never execute.
>> 
>> Just one clarification: the specific locking strategy used by the
>> Linux kernel monotonic clock vDSO is a "seqlock", where the kernel
>> sets a bit which keeps concurrent readers looping until they observe
> 
> When I say "sets a bit", I actually mean "increment a sequence counter",
> and readers observe either odd or even state, thus knowing whether
> they need to retry, and whether the value read before/after reading
> the data structure changed.

Looking again at the Linux kernel's kernel/time/vsyscall.c implementation
of vdso_update_{begin,end}, I notice that interrupts are disabled across
the entire update. So I understand that the Interrupt pipeline (I-pipe)
interrupt gets delivered even when the kernel disables interrupts. Did
you consider modifying the I-pipe kernel patch to change the vdso update so
it updates the vdso from within an I-pipe virq handler ?

AFAIU this would allow Xenomai userspace to use the Linux kernel vDSO
clock sources.

Thanks,

Mathieu

> 
> Thanks,
> 
> Mathieu
> 
>> a consistent value. With Xenomai it indeed appears to be prone to
>> deadlock if a high priority Xenomai thread interrupts the kernel
>> while the write seqlock is held, and then proceeds to loop forever
>> on the read-side of the seqlock.
>> 
>> Note that for the in-kernel tracer clock read use-case, which
>> needs to be able to happen from NMI context, I've contributed a
>> modified version of the seqlock to the Linux kernel:
>> 
>> https://lwn.net/Articles/831540/ The seqcount latch lock type
>> 
>> It basically keeps two copies of the clock data structures, so the
>> read-side never has to loop waiting for the updater: it simply gets
>> redirected to the "stable" copy of the data.
>> 
>> The trade-off here is that with the latch lock used for clocks, a
>> reader may observe time going slightly backwards between two clock
>> reads when reading while specific clock rate adjustments are made
>> by an updater. The clock user needs to be aware of this.
>> 
>> Thanks,
>> 
>> Mathieu
>> 
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
