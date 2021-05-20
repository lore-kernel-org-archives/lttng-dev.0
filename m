Return-Path: <SRS0=dYoO=KP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C928C433B4
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 14:15:45 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 909406109F
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 14:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909406109F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FmBbg2P0gz1rpM;
	Thu, 20 May 2021 10:15:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621520143;
	bh=Ua+sjgM1mDnDY5cFfialyoBWL9NTHTfcMePgk9z7Ws0=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=sW/sGYKf55u6aOgRt6/zLmbJ6Bv7dfgtYDk+OA3BUlII76T7C4wiBBfc022RYbLLv
	 40m4T4S/rAFmx++13AZENLO+YiGsNtJTVi3cg/5Y64aEh0aVajv3nV/1FGcCPnO3CZ
	 9JSA3pob3w/HQUlhjbikpvLjoRPKj2WTBVH/D2fFtt/SnddYTILmIFgpijtufpXOLq
	 ivvkx773T983WuFTxUFrwwptkc8yFo9fq5WPAwoVooRIqc3Yz7z7BhfiVuoKNDIhUx
	 S9elW5HO6zEDiRi7RAw4Fibt0vQgT2zaUWUHQetu2neBRuRwloAwILwWNty26qi1Pv
	 1VIh+Jzncp9hQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FmBbd26Gfz1rjM
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 10:15:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C3C80335ECD
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 10:15:35 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id trQ82YUfk6zp; Thu, 20 May 2021 10:15:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id E2B3D335C7E;
 Thu, 20 May 2021 10:15:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E2B3D335C7E
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id nNPAEay9G6Az; Thu, 20 May 2021 10:15:34 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id D67F3335E58;
 Thu, 20 May 2021 10:15:34 -0400 (EDT)
Date: Thu, 20 May 2021 10:15:34 -0400 (EDT)
To: Norbert Lange <nolange79@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1054776587.52332.1621520134754.JavaMail.zimbra@efficios.com>
In-Reply-To: <CADYdroNEtUen6OiVSXeP7EgRrPGv6wW3FtV1-i0php5DoJQUFg@mail.gmail.com>
References: <CADYdroN3=pAe66crtsVT9aHE4T+bT61-tvHFKCuwZYkHhuyFjw@mail.gmail.com>
 <217443874.51651.1621450365666.JavaMail.zimbra@efficios.com>
 <CADYdroMVaMq6wdySyV-JGDyJaFpaLO1cHd2=hEb=WMpBHUz0Jg@mail.gmail.com>
 <1519877397.52210.1621517299822.JavaMail.zimbra@efficios.com>
 <CADYdroNEtUen6OiVSXeP7EgRrPGv6wW3FtV1-i0php5DoJQUFg@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF88 (Linux)/8.8.15_GA_4007)
Thread-Topic: reading context fields causes syscalls
Thread-Index: 2fFl/h7xgLEiuBnIvvmQcEWG5YrhRg==
Subject: Re: [lttng-dev] reading context fields causes syscalls
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

----- On May 20, 2021, at 9:42 AM, Norbert Lange nolange79@gmail.com wrote:

> Am Do., 20. Mai 2021 um 15:28 Uhr schrieb Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com>:
>>
>> ----- On May 20, 2021, at 8:46 AM, Norbert Lange nolange79@gmail.com wrote:
>>
>> > Am Mi., 19. Mai 2021 um 20:52 Uhr schrieb Mathieu Desnoyers
>> > <mathieu.desnoyers@efficios.com>:
>> >>
>> >> ----- On May 19, 2021, at 8:11 AM, lttng-dev lttng-dev@lists.lttng.org wrote:
>> >>
>> >> > Hello,
>> >> >
>> >> > Several context fields will cause a syscall atleast the first time a
>> >> > tracepoint is
>> >> > recorded. For example all of the following:
>> >> >
>> >> > `lttng add-context -c chan --userspace --type=vpid --type=vtid --type=procname`
>> >> >
>> >> > Each of them seems cached in TLS however, and most should never change
>> >> > after startup.
>> >> >
>> >> > As I am using Lttng over Xenomai, syscalls are strictly forbidden, I
>> >> > would like to have some function that prepares all data, which I can
>> >> > call on each thread before it switches to realtime work.
>> >> >
>> >> > Kinda similar to urcu_bp_register_thread, I'd like to have some
>> >> > `lttng_ust_warmup_thread` function that fetches the context values
>> >> > that can be cached. (urcu_bp_register_thread should be called there
>> >> > aswell)
>> >> > I considered just doing a tracepoint, but AFAIK the channel can be
>> >> > changed/configured after the process is running. So this is not robust
>> >> > enough.
>> >>
>> >> The new lttng_ust_init_thread() API in lttng-ust 2.13 would be the right
>> >> place to do this I think:
>> >>
>> >> /*
>> >>  * Initialize this thread's LTTng-UST data structures. There is
>> >>  * typically no need to call this, because LTTng-UST initializes its
>> >>  * per-thread data structures lazily, but it should be called explicitly
>> >>  * upon creation of each thread before signal handlers nesting over
>> >>  * those threads use LTTng-UST tracepoints.
>> >>  */
>> >>
>> >> It would make sense that this new initialization helper also initializes
>> >> all contexts which cache the result of a system call. Considering that
>> >> contexts can be used from the filter and capture bytecode interpreter, as
>> >> well as contexts added to channels, I think we'd need to simply initialize
>> >> them all.
>> >
>> > Yeah, just figured that it doesnt help at all if I do a tracepoint, as
>> > it might just be disabled ;)
>> > lttng_ust_init_thread() sounds right for that, maybe add one or 2 arguments for
>> > stuff you want initialized / dont want initialized over the default.
>> >
>> > I take that the downside of eager initialization is potentially wasted
>> > resources (now ignoring any one-time runtime cost).
>>
>> I would not want to introduce too much coupling between the application and
>> the tracer though. The public API I've added for the 2.13 release cycle takes
>> no argument, and I'm not considering changing that at this stage (we are already
>> at -rc2, so we're past the API freeze).
> 
> Ok, figured if that's preferred then nows the last chance

Actually I did an exception between rc1 and rc2 when I changed the probe provider's
API and ABI, but I don't expect to do any more breaking API/ABI changes onwards.
We have customers now using rc2 as a stable baseline, and I need a really strong
argument to break ABI at this stage.

Adding features to lttng_ust_init_thread() does not fit in that category. This should
have happened before -rc1 if we wished to do that.

> 
>>
>> I'd be open to adding an extra API with a different purpose though. Currently
>> lttng_ust_init_thread is meant to initialize per-thread data structures for
>> tracing signal handlers.
>>
>> Your use-case is different: you aim at tracing from a context which cannot
>> issue system calls. Basically, any attempt to issue a system call from that
>> thread after this is a no-go. I would be tempted to introduce something like
>> "lttng_ust_{set,clear}_thread_no_syscall" or such, which would have the
>> following
>> effects when set:
> 
> No systemcalls and no clock_gettime().

Right, no clock_gettime because of the seqlock.

>>
>> * Force immediate initialization of all thread's cached context information,
> 
> Definitely needed (adding context is often needed I guess)

Yes, although there are other contexts like the perf counters which fallback to
system calls when direct access to the performance counter registers is not
available from user-space. I wonder whether we want to somehow manage this
or require that the user knows not to use those in the wrong context.

> 
>> * Set a TLS variable flag indicating that the tracer should not do any system
>>   call whatsoever. The tracer could either use dummy data (zeroes), log an error,
>>   or abort() the process if a thread in no_syscall mode attempts to issue a system
>>   call. This could be dynamically selected by a new environment variable.
> 
> How this works is than Xenomai will generate a synchronous signal,
> which as default aborts. So fallbacks are nice, but error handling
> isn't necessary.

Ah ok good, one less thing to worry about on lttng's side then.

> 
> Somewhat offtopic, but why is lltng not using __thread for TLS access,
> usually I only see this for really old stuff?

LTTng-UST works on BSDs, Mac, Cygwin, Solaris and so forth. So we use liburcu's
"tls-compat" compatibility layer for TLS, which uses __thread whenever it's
available in the toochain, else it falls back on pthread keys.

> 
>> * Prevent threads in no_syscall mode from calling the write() system call on
>>   sub-buffer switch (of course the read-timer channel option is preferred).
> 
> Yeah, that was part of the last discussion. What would happen without
> write notification?
> Bufferstate is polled elsewhere too, or will it just be full forever?

Unless the "read-timer" option is set for the channel, the buffer will stay
in full state and the consumer won't attempt to read it.

> 
> Come to think of it, maybe it would be better to add some form of
> "tags" to software,
> (like a defined symbol or ELF .note section) which could prevent
> processes to be traced
> if in the wrong mode (no read-timer), or change what work the
> lttng_ust_init_thread function
> does.

Yes, I suspect those ideas are in the right direction. However, I wonder
how we would deal with different order of:

- dlopen of a .so which has this tag,
- creation of the thread,
- creation of the lttng-ust tracing session and channel setup.

Considering that those 3 steps may happen in any order.

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
