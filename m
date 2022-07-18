Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F53C433EF
	for <lttng-dev@archiver.kernel.org>; Mon, 18 Jul 2022 15:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1658159184;
	bh=A6TMx7zkIwVuretj/yzB+t/IJms/dYOF/JUqaE4cp4w=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=rQ+xTjVTR5Yjy27spAvo4QdRXn9GsqL64nrE7G+UCHGC1vhX4nDKsR6QSM2sYF35r
	 BGBz8FSqNjQGJZvtPjuU61P8u88thn+hqruhY8t6CGJ7XnoUOL1bXekqF6l9PGdgZy
	 xtEqzHJIS2bZhf/eKZwwtCh/RiTASRu/l38PS+ijsh1bZ0zC6cMPvQndvr18+5x2P1
	 SnwLlFmbXx7yh2tnrNAoGmKDwWLVul0WR6bWavQQtydTuMos8WFck95T0QtpmYatfc
	 RetxLlE7LqKWYlVN+ligzebN10DCUeiBRpsc/Kk4ebxV/5BtYU0xaWYXcIITH29Fjo
	 oh+Z9emJ+1zxw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LmmXc0smwzPBP;
	Mon, 18 Jul 2022 11:46:24 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4LmmXZ3t8rzPbL
 for <lttng-dev@lists.lttng.org>; Mon, 18 Jul 2022 11:46:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id E5CB1423C72
 for <lttng-dev@lists.lttng.org>; Mon, 18 Jul 2022 11:46:21 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id UL7uXIuiejTe; Mon, 18 Jul 2022 11:46:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5315B423E59;
 Mon, 18 Jul 2022 11:46:21 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5315B423E59
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Du8BAzARdR3I; Mon, 18 Jul 2022 11:46:21 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 4A255424203;
 Mon, 18 Jul 2022 11:46:21 -0400 (EDT)
Date: Mon, 18 Jul 2022 11:46:21 -0400 (EDT)
To: Norbert Lange <nolange79@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <659331176.71995.1658159181188.JavaMail.zimbra@efficios.com>
In-Reply-To: <CADYdroN9STUUxYZAYx2R-X2MjuGGF8kVOXEHG156ZTmnoiY9wQ@mail.gmail.com>
References: <CADYdroN3=pAe66crtsVT9aHE4T+bT61-tvHFKCuwZYkHhuyFjw@mail.gmail.com>
 <217443874.51651.1621450365666.JavaMail.zimbra@efficios.com>
 <CADYdroMVaMq6wdySyV-JGDyJaFpaLO1cHd2=hEb=WMpBHUz0Jg@mail.gmail.com>
 <1519877397.52210.1621517299822.JavaMail.zimbra@efficios.com>
 <CADYdroNEtUen6OiVSXeP7EgRrPGv6wW3FtV1-i0php5DoJQUFg@mail.gmail.com>
 <1054776587.52332.1621520134754.JavaMail.zimbra@efficios.com>
 <CADYdroN9STUUxYZAYx2R-X2MjuGGF8kVOXEHG156ZTmnoiY9wQ@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - FF100
 (Linux)/8.8.15_GA_4304)
Thread-Topic: reading context fields causes syscalls
Thread-Index: GR+EtlQe6HAA5P7YVQtU1TE6TYJN3A==
Subject: Re: [lttng-dev] reading context fields causes syscalls
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

----- On Jul 14, 2022, at 9:10 AM, Norbert Lange nolange79@gmail.com wrote:

> Hello Mathieu,
> 
> Am Do., 20. Mai 2021 um 16:16 Uhr schrieb Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com>:
>>
>> ----- On May 20, 2021, at 9:42 AM, Norbert Lange nolange79@gmail.com wrote:
>>
>> > Am Do., 20. Mai 2021 um 15:28 Uhr schrieb Mathieu Desnoyers
>> > <mathieu.desnoyers@efficios.com>:
>> >>
>> >> ----- On May 20, 2021, at 8:46 AM, Norbert Lange nolange79@gmail.com wrote:
>> >>
>> >> > Am Mi., 19. Mai 2021 um 20:52 Uhr schrieb Mathieu Desnoyers
>> >> > <mathieu.desnoyers@efficios.com>:
>> >> >>
>> >> >> ----- On May 19, 2021, at 8:11 AM, lttng-dev lttng-dev@lists.lttng.org wrote:
>> >> >>
>> >> >> > Hello,
>> >> >> >
>> >> >> > Several context fields will cause a syscall atleast the first time a
>> >> >> > tracepoint is
>> >> >> > recorded. For example all of the following:
>> >> >> >
>> >> >> > `lttng add-context -c chan --userspace --type=vpid --type=vtid --type=procname`
>> >> >> >
>> >> >> > Each of them seems cached in TLS however, and most should never change
>> >> >> > after startup.
>> >> >> >
>> >> >> > As I am using Lttng over Xenomai, syscalls are strictly forbidden, I
>> >> >> > would like to have some function that prepares all data, which I can
>> >> >> > call on each thread before it switches to realtime work.
>> >> >> >
>> >> >> > Kinda similar to urcu_bp_register_thread, I'd like to have some
>> >> >> > `lttng_ust_warmup_thread` function that fetches the context values
>> >> >> > that can be cached. (urcu_bp_register_thread should be called there
>> >> >> > aswell)
>> >> >> > I considered just doing a tracepoint, but AFAIK the channel can be
>> >> >> > changed/configured after the process is running. So this is not robust
>> >> >> > enough.
>> >> >>
>> >> >> The new lttng_ust_init_thread() API in lttng-ust 2.13 would be the right
>> >> >> place to do this I think:
>> >> >>
>> >> >> /*
>> >> >>  * Initialize this thread's LTTng-UST data structures. There is
>> >> >>  * typically no need to call this, because LTTng-UST initializes its
>> >> >>  * per-thread data structures lazily, but it should be called explicitly
>> >> >>  * upon creation of each thread before signal handlers nesting over
>> >> >>  * those threads use LTTng-UST tracepoints.
>> >> >>  */
>> >> >>
>> >> >> It would make sense that this new initialization helper also initializes
>> >> >> all contexts which cache the result of a system call. Considering that
>> >> >> contexts can be used from the filter and capture bytecode interpreter, as
>> >> >> well as contexts added to channels, I think we'd need to simply initialize
>> >> >> them all.
> 
> Any update on that, is there an list of open points/features for lttng?

Hi Norbert,

You can find a feature wish list for the LTTng-UST project here:

  https://bugs.lttng.org/projects/lttng-ust

One option you have is to implement a patch and send it our way for review. We will
then review it as time/bandwidth allows.

However, if you would like the EfficiOS team to do the implementation, testing, and
integration, please contact us in private so we can discuss our consulting services.

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
