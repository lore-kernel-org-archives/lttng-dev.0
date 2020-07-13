Return-Path: <SRS0=7o6r=AY=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005ACC433E0
	for <lttng-dev@archiver.kernel.org>; Mon, 13 Jul 2020 15:28:42 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3AF4206F0
	for <lttng-dev@archiver.kernel.org>; Mon, 13 Jul 2020 15:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="lupZpPW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3AF4206F0
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4B56xN1gdvz1Vwr;
	Mon, 13 Jul 2020 11:28:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1594654120;
	bh=EGa0yHPUdGS9u7esEo6zNM14OVuP/zrHR0wj8gsEH5I=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=lupZpPW4h3KOlIX0xX5LD5YyNLRrUvHtZamG519RIWRCsIARRWZP/y7kvj9kbDt12
	 TPu0DJlKiIZpoYsVW8VazZC7IxRTuuDKHbcaFo5e9KE6z2ZbwdZF2QYea3hqNFzYje
	 LnkBnA4O27CZoHAOcw7M3jJVeYsuU13kIpgM3sATNhAcAHbdzFgVsOOuqbT9m5hJVm
	 G1FPsLyfjO6Rnr9sHoGwQf9bjEVZcTlbTiIv86IZyFW9cJSfeq4alYqzy6n9XyJcQC
	 4GeGViCjAutwyIXkfVXXYKD1ktXxnHuzlmzPMZKoFtW0FsJP9r3PWo1byh57gN/kxo
	 jDQAhgyUtZcgw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4B56xK5hvBz1VlD
 for <lttng-dev@lists.lttng.org>; Mon, 13 Jul 2020 11:28:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 29C152A2F35
 for <lttng-dev@lists.lttng.org>; Mon, 13 Jul 2020 11:28:31 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id AxgRS57GcLXO; Mon, 13 Jul 2020 11:28:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id CAA9C2A2F9B;
 Mon, 13 Jul 2020 11:28:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com CAA9C2A2F9B
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id mxXbWzK5l3RA; Mon, 13 Jul 2020 11:28:30 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id C14782A2F9A;
 Mon, 13 Jul 2020 11:28:30 -0400 (EDT)
Date: Mon, 13 Jul 2020 11:28:30 -0400 (EDT)
To: Olivier Dion <olivier.dion@polymtl.ca>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <2029726158.10046.1594654110710.JavaMail.zimbra@efficios.com>
In-Reply-To: <87r1tfxx1l.fsf@clara>
References: <20200711152907.676582-1-olivier.dion@polymtl.ca>
 <756801034.9565.1594561774215.JavaMail.zimbra@efficios.com>
 <87tuycybqx.fsf@clara>
 <1851244021.9798.1594646692671.JavaMail.zimbra@efficios.com>
 <87r1tfxx1l.fsf@clara>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: Add ctor/dtor priorities for tracepoints/events
Thread-Index: U4AE0j54qh8eIkPv45N7peNyJ3s4aw==
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200713152830.paza58PcS4SnkwsezkXCSf-z3bR22yGwiBjgdY-fFZ0@z>

----- On Jul 13, 2020, at 11:19 AM, Olivier Dion olivier.dion@polymtl.ca wrote:

> On Mon, 13 Jul 2020, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
[...]
> 
>>>> Also, we should compare two approaches to fulfill your goal:
>>>> one alternative would be to have application/library constructors
>>>> explicitly call tracepoint constructors if they wish to use them.
>>> 
>>> I would prefer this way.  The former solution might not work in some
>>> cases (e.g. with LD_PRELOAD and priority =101) and I prefer explicit
>>> initialization in that case.
>>> 
>>> I don't see any cons for the second approach, except making the symbols
>>> table a few bytes larger.  I'll post a patch soon so we can compare and
>>> try to find more documentation on ctor priority.
>>
>> And users will have to explicitly call the constructor on which they
>> depend, but I don't see it as a huge burden.
> 
> The burden is small indeed.  But users should pay close attention to
> release the references in a destructor too.
> 
>> Beware though that there are a few configurations which can be used for
>> probe providers (see lttng-ust(3)).
> 
> I'm not following you here.  I don't see any configuration for provider
> except TRACEPOINT_LOGLEVEL.  What should I be aware of?

See sections "Statically linking the tracepoint provider" and
"Dynamically loading the tracepoint provider" from lttng-ust(3). It's
especially the dynamic loading I am concerned about, because then it
becomes tricky for an instrumented .so (or app) to call the probe provider's
constructor without dlopening it beforehand, because there are no dependencies
from the instrumented module on probe symbols. And given you plan to call
this from a constructor, it means the dynamic loader lock is already held,
so even if we dlopen the probe provider from the instrumented constructor,
I am not sure the dlopen'd .so's constructor will be allowed to run
immediately.

Maybe one thing that could work for the dynamic loading case would be to:

- let the instrumented constructor dlopen its probe,
- from the instrumented constructor, use dlsym to get the probe's constructor
  symbols.
- call those constructors.

If this is common enough, maybe we would want to provide helpers for this.

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
