Return-Path: <SRS0=7o6r=AY=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015CBC433E2
	for <lttng-dev@archiver.kernel.org>; Mon, 13 Jul 2020 15:18:13 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9213D2075B
	for <lttng-dev@archiver.kernel.org>; Mon, 13 Jul 2020 15:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="AwQ8xinK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9213D2075B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4B56jG6shKz1VRM;
	Mon, 13 Jul 2020 11:18:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1594653491;
	bh=HMzBfhl+rZuxfR5TQIslTTZi5tneLl+QVcvu513r1Sc=;
	h=To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=AwQ8xinKWMoiz23eYDT2I6xUXFG82+ULZlk+uZucixkxNCH+bDlmwvnTXJSH95yKc
	 6yOCujtJIjkHQKWQji25D6TiQr92/a5aKvAEHBpn2oMdNxIDDcNnkbCArIO5BsSPK/
	 BLVrGy4LO7MsR3uPMzuI4WauRgoDoUwslYADQs2TitOBgaKfdq3Y/5or9k/Zb7p1wK
	 5OCj/eBmtCxjTddc0ih5vqJ+PeKUvwjwCTxAf5Rd/YqSW2wAF9SvfzG55OpNb6YX3t
	 bRVAdQu71ENJTzmFFepkgbfWSvVTN8HRGKJI+RAF4y4LoMsEPcE1RlikqzpBFS/Ej1
	 O/ja3pcDjrK5Q==
Received: from smtp.polymtl.ca (smtp.polymtl.ca [132.207.4.11])
 by lists.lttng.org (Postfix) with ESMTPS id 4B56jF2pLTz1W7m
 for <lttng-dev@lists.lttng.org>; Mon, 13 Jul 2020 11:18:08 -0400 (EDT)
Received: from localhost (modemcable059.101-200-24.mc.videotron.ca
 [24.200.101.59])
 by smtp.polymtl.ca (8.14.7/8.14.7) with ESMTP id 06DFHuXg023821
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT); 
 Mon, 13 Jul 2020 11:18:01 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.polymtl.ca 06DFHuXg023821
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
In-Reply-To: <1851244021.9798.1594646692671.JavaMail.zimbra@efficios.com>
References: <20200711152907.676582-1-olivier.dion@polymtl.ca>
 <756801034.9565.1594561774215.JavaMail.zimbra@efficios.com>
 <87tuycybqx.fsf@clara>
 <1851244021.9798.1594646692671.JavaMail.zimbra@efficios.com>
Date: Mon, 13 Jul 2020 11:19:18 -0400
Message-ID: <87r1tfxx1l.fsf@clara>
MIME-Version: 1.0
X-Poly-FromMTA: (modemcable059.101-200-24.mc.videotron.ca [24.200.101.59]) at
 Mon, 13 Jul 2020 15:17:56 +0000
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
Message-ID: <20200713151918.RW68IL5cy6OMyLSW4lUW8oKXyqTqER5ajaZQPNpD6vQ@z>

On Mon, 13 Jul 2020, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> ----- On Jul 12, 2020, at 11:49 AM, Olivier Dion olivier.dion@polymtl.ca wrote:
>
>> On Sun, 12 Jul 2020, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>> ----- On Jul 11, 2020, at 11:29 AM, lttng-dev lttng-dev@lists.lttng.org wrote:
>>>
>>>> Some library might want to generate events in their ctor/dtor.  If
>>>> LTTng initialize/finalize its tracepoints/events at the wrong time,
>>>> events are lost.
>>>> 
>>>> Order of execution of the ctor/dtor is determined by priority.  When
>>>> some priorities are equal, the order of execution seems to be
>>>> determined by:
>>>> 
>>>>	   a) Order of appearance if in the same compilation unit
>>>> 
>>>>	   b) Order of link if in different compilation units
>>>> 
>>>>	   c) Order of load by ld-linux.so or dlopen(3) for
>>>>	      share objects
>>>
>>> I recall different rules about constructor priorities. Can you provide
>>> links to documentation stating the priority order you describe above ?
>> 
>> I haven't found any documentation on that.  This is purely empirical.
>> Although I'm sure that we can dig something if chatting on GCC's IRC.
>
> If it is not documented, then I am reluctant on depending on a behavior
> which may be what happens today, but may not be the same for past/future
> toolchains.

Agree.

>>> Also, we should compare two approaches to fulfill your goal:
>>> one alternative would be to have application/library constructors
>>> explicitly call tracepoint constructors if they wish to use them.
>> 
>> I would prefer this way.  The former solution might not work in some
>> cases (e.g. with LD_PRELOAD and priority =101) and I prefer explicit
>> initialization in that case.
>> 
>> I don't see any cons for the second approach, except making the symbols
>> table a few bytes larger.  I'll post a patch soon so we can compare and
>> try to find more documentation on ctor priority.
>
> And users will have to explicitly call the constructor on which they
> depend, but I don't see it as a huge burden.

The burden is small indeed.  But users should pay close attention to
release the references in a destructor too.

> Beware though that there are a few configurations which can be used for
> probe providers (see lttng-ust(3)).

I'm not following you here.  I don't see any configuration for provider
except TRACEPOINT_LOGLEVEL.  What should I be aware of?

-- 
Olivier Dion
PolyMtl
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
