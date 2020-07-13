Return-Path: <SRS0=7o6r=AY=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E09C433E0
	for <lttng-dev@archiver.kernel.org>; Mon, 13 Jul 2020 19:43:49 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B12142068F
	for <lttng-dev@archiver.kernel.org>; Mon, 13 Jul 2020 19:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="ypQg3xT2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12142068F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4B5Dbk6cSCz1W3f;
	Mon, 13 Jul 2020 15:43:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1594669427;
	bh=yHJBoMYnE7RvnumqJkiKubt+zHFZ7yUSP3amPqahOio=;
	h=To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ypQg3xT22AX7JttN4MBtRfJTPrcEufBxIa3r5UM2Ube2+VLXo6Kfgod8OT81AN5Oa
	 0tDfhP+m9iNUX7Fid2kQ/kogIRlBbi6Bxd5nkNDtvipayoOcY0vKp2xex/9BhAHq4L
	 +L8HqgX9v5VbuPyWFxF39A8aqPKvZ4jihA8PeSdRsxRUBQ/wx1eWJf8pXcmlgWQwyu
	 Y8anvtOHMb5MCm+Wax07T8t6kDp/AhVlZzQf57cWYYa5e8ZvUBpNBKpWdxZmtaTdmD
	 JBEqubl2stMCkdHuxszuUmFCJ6//V1/KS5BbP+gJ3YuMlHuAL3BUeVoxVZZQQsr/QX
	 aF1ze7DxY0/sw==
Received: from smtp.polymtl.ca (smtp.polymtl.ca [132.207.4.11])
 by lists.lttng.org (Postfix) with ESMTPS id 4B5Dbj3Tdxz1WBp
 for <lttng-dev@lists.lttng.org>; Mon, 13 Jul 2020 15:43:45 -0400 (EDT)
Received: from localhost (modemcable059.101-200-24.mc.videotron.ca
 [24.200.101.59])
 by smtp.polymtl.ca (8.14.7/8.14.7) with ESMTP id 06DJhYEU020748
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT); 
 Mon, 13 Jul 2020 15:43:38 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.polymtl.ca 06DJhYEU020748
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
In-Reply-To: <1150223945.10384.1594666728119.JavaMail.zimbra@efficios.com>
References: <20200711152907.676582-1-olivier.dion@polymtl.ca>
 <756801034.9565.1594561774215.JavaMail.zimbra@efficios.com>
 <87tuycybqx.fsf@clara>
 <1851244021.9798.1594646692671.JavaMail.zimbra@efficios.com>
 <87r1tfxx1l.fsf@clara>
 <2029726158.10046.1594654110710.JavaMail.zimbra@efficios.com>
 <87lfjnxngn.fsf@clara>
 <1150223945.10384.1594666728119.JavaMail.zimbra@efficios.com>
Date: Mon, 13 Jul 2020 15:44:56 -0400
Message-ID: <87pn8z6vyf.fsf@clara>
MIME-Version: 1.0
X-Poly-FromMTA: (modemcable059.101-200-24.mc.videotron.ca [24.200.101.59]) at
 Mon, 13 Jul 2020 19:43:34 +0000
Subject: Re: [lttng-dev] [PATCH lttng-ust] Add ctor/dtor priorities for
 tracepoints/events
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Olivier Dion via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Olivier Dion <olivier.dion@polymtl.ca>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200713194456.aF1wqEBMzQtoVDjwnm6XwD8W0slR66FGGxDAiafajgE@z>

On Mon, 13 Jul 2020, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> ----- On Jul 13, 2020, at 2:46 PM, Olivier Dion olivier.dion@polymtl.ca wrote:
>
>> On Mon, 13 Jul 2020, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>> ----- On Jul 13, 2020, at 11:19 AM, Olivier Dion olivier.dion@polymtl.ca wrote:
>>>
>>>> On Mon, 13 Jul 2020, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>> [...]
>>>> 
>>>>>>> Also, we should compare two approaches to fulfill your goal:
>>>>>>> one alternative would be to have application/library constructors
>>>>>>> explicitly call tracepoint constructors if they wish to use them.
>>>>>> 
>>>>>> I would prefer this way.  The former solution might not work in some
>>>>>> cases (e.g. with LD_PRELOAD and priority =101) and I prefer explicit
>>>>>> initialization in that case.
>>>>>> 
>>>>>> I don't see any cons for the second approach, except making the symbols
>>>>>> table a few bytes larger.  I'll post a patch soon so we can compare and
>>>>>> try to find more documentation on ctor priority.
>>>>>
>>>>> And users will have to explicitly call the constructor on which they
>>>>> depend, but I don't see it as a huge burden.
>>>> 
>>>> The burden is small indeed.  But users should pay close attention to
>>>> release the references in a destructor too.
>>>> 
>>>>> Beware though that there are a few configurations which can be used for
>>>>> probe providers (see lttng-ust(3)).
>>>> 
>>>> I'm not following you here.  I don't see any configuration for provider
>>>> except TRACEPOINT_LOGLEVEL.  What should I be aware of?
>>>
>>> See sections "Statically linking the tracepoint provider" and
>>> "Dynamically loading the tracepoint provider" from lttng-ust(3). It's
>>> especially the dynamic loading I am concerned about, because then it
>>> becomes tricky for an instrumented .so (or app) to call the probe provider's
>>> constructor without dlopening it beforehand, because there are no dependencies
>>> from the instrumented module on probe symbols. And given you plan to call
>>> this from a constructor, it means the dynamic loader lock is already held,
>>> so even if we dlopen the probe provider from the instrumented constructor,
>>> I am not sure the dlopen'd .so's constructor will be allowed to run
>>> immediately.
>>>
>>> Maybe one thing that could work for the dynamic loading case would be to:
>>>
>>> - let the instrumented constructor dlopen its probe,
>>> - from the instrumented constructor, use dlsym to get the probe's constructor
>>>   symbols.
>>> - call those constructors.
>>>
>>> If this is common enough, maybe we would want to provide helpers for
>>> this.
>> 
>> Okay so to be clear.  __tracepoints__init() should be call first, then
>> __tracepoints__ptrs_init()
>
> I don't think the order matters. What makes you think otherwise ?

I assumed __tracepoints_init() initialized rcu, but apparently __ptrs do
the same and more.

>
>> and then dlsym(3) on
>> __lttng_events_init__provider() _if_ TRACEPOINT_PROBE_DYNAMIC_LINKAGE.
>
> Yes.
>
>> 
>> Reverse the steps in destructor.
>> 
>> And so would something along these lines work?
>> --------------------------------------------------------------------------------
>> #ifdef TRACEPOINT_PROBE_DYNAMIC_LINKAGE
>> 
>> #  define tracepoint_acquire(provider)                           \
>>        do {                                                     \
>>                void (*init)(void);                              \
>>                __tracepoints__init();                           \
>>                __tracepoints__ptrs_init();                      \
>
> Where is the dlopen() done ? What code is responsible for it ?

I assume here that the desired trace provider is part of a share object
that has already been dlopen() before.

Using RTLD_DEFAULT or simply NULL should find the correct symbol in the
executable if the share object that has the trace provider is _already_
loaded in memory.

Otherwise, the macro should be something like
'tracepoint_acquire(provider, so_path)' I guess?  And so this would
indeed require a dlopen() on so_path and so on.

>
>>                init = dlsym(RTLD_DEFAULT,                       \
>
> This should use the handled returned by dlopen.
>
>>                             "__lttng_events_init__" #provider); \
>>                if (init) {                                      \
>>                        init();                                  \
>>                }                                                \
>>        } while(0)
>> 
>
> We may want a dlclose on the release (?)

Yes of course!

>
>> #else
>> 
>> #  define tracepoint_acquire(provider)                                 \
>>        do {                                                           \
>>                __tracepoint__init();                                  \
>>                __tracepoints_ptrs_init();                             \
>>                _TP_COMBINE_TOKENS(__lttng_events_init__, provider)(); \
>>        } while(0)
>> 
>> #endif
>> --------------------------------------------------------------------------------
>> 
>> And then:
>> ----------------------------------------------------------------------
>> #include "my-trace.h"
>> 
>> __attribute__((constructor))
>> static void my_ctor(void)
>> {
>>        tracepoint_acquire(my_provider);
>>        tracepoint(my_provider, my_event, my_state);
>> }
>> 
>> __attribute__((destructor))
>> static void my_ctor(void)
>> {
>>        tracepoint_release(my_provider)
>> }
>> ----------------------------------------------------------------------
>> 
>> Of course, this requires making __tracepoints__* externally visibile.
>
> Why is that so ?

__tracepoints__init() is statically defined in every compilation units
that include the trace header.  So this one doesn't actually need to be
externally visible, my mistake.  Although I don't understand why this
initializer is duplicated across units.

However, __tracepoints__ptrs__init() is statically defined in one
compilation unit, the unit that has defined the TRACEPOINT_DEFINE macro.
So I guess that the pointer tables is unique for every exe/so.  If
that's the case, then this initializer should also be find with dlsym()?

-- 
Olivier Dion
PolyMtl
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
