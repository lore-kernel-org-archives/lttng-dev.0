Return-Path: <SRS0=7o6r=AY=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0615BC43470
	for <lttng-dev@archiver.kernel.org>; Mon, 13 Jul 2020 13:25:04 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B9EE2072D
	for <lttng-dev@archiver.kernel.org>; Mon, 13 Jul 2020 13:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="F0MjNwhe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9EE2072D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4B54Bj5dXVz1W55;
	Mon, 13 Jul 2020 09:25:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1594646702;
	bh=yv5XB3dZL1Xe5SCMvpEsK7oUBG8fF7XBeDxO3qi/LQo=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=F0MjNwhenJvvfXb1jNVUsEJPG7JS5Y65Blu+4NbzBqRrtk1VjhMRI/p//CDlwfuUG
	 LTK7KpnzfRDyd7fzyPZsOGqdn1838bBNGUbvkzC2OK/o3efu+dQleLPvZcTJlEXhYT
	 7jCacoiXh3IEHxq4sNrd2CUAwCnqAICpj7yUnE/EsLMDE6VVP0qp+qw76snNBTCze3
	 RHQzvO/SxUmBEBm58hZ75Cp1MK4WjImi0ukM8lkJz2Qaac5r+tsRK2+glifrVXoFfq
	 teMEO2/90MxC/t2gWAvZtOfu4gxyX4Q8GSHMYrrbogOKupAEGQ8M5IOZkAv5p7tdBr
	 HLj5lk6GO7JiQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4B54Bg43Mvz1Vqm
 for <lttng-dev@lists.lttng.org>; Mon, 13 Jul 2020 09:24:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 1A4D42A1E1A
 for <lttng-dev@lists.lttng.org>; Mon, 13 Jul 2020 09:24:53 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id vXudN9nQ3dn7; Mon, 13 Jul 2020 09:24:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C58AA2A1E19;
 Mon, 13 Jul 2020 09:24:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C58AA2A1E19
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id VOvKg3R92O2R; Mon, 13 Jul 2020 09:24:52 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id BACCF2A1E18;
 Mon, 13 Jul 2020 09:24:52 -0400 (EDT)
Date: Mon, 13 Jul 2020 09:24:52 -0400 (EDT)
To: Olivier Dion <olivier.dion@polymtl.ca>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1851244021.9798.1594646692671.JavaMail.zimbra@efficios.com>
In-Reply-To: <87tuycybqx.fsf@clara>
References: <20200711152907.676582-1-olivier.dion@polymtl.ca>
 <756801034.9565.1594561774215.JavaMail.zimbra@efficios.com>
 <87tuycybqx.fsf@clara>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: Add ctor/dtor priorities for tracepoints/events
Thread-Index: Nk11WyoSAsFRKDbKluVT+2bg/XK9ZA==
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
Message-ID: <20200713132452.CbmgXRtytnLXxXAhQP0Z4H1MdFYyG31HMOzXpcImgVo@z>

----- On Jul 12, 2020, at 11:49 AM, Olivier Dion olivier.dion@polymtl.ca wrote:

> On Sun, 12 Jul 2020, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>> ----- On Jul 11, 2020, at 11:29 AM, lttng-dev lttng-dev@lists.lttng.org wrote:
>>
>>> Some library might want to generate events in their ctor/dtor.  If
>>> LTTng initialize/finalize its tracepoints/events at the wrong time,
>>> events are lost.
>>> 
>>> Order of execution of the ctor/dtor is determined by priority.  When
>>> some priorities are equal, the order of execution seems to be
>>> determined by:
>>> 
>>>	   a) Order of appearance if in the same compilation unit
>>> 
>>>	   b) Order of link if in different compilation units
>>> 
>>>	   c) Order of load by ld-linux.so or dlopen(3) for
>>>	      share objects
>>
>> I recall different rules about constructor priorities. Can you provide
>> links to documentation stating the priority order you describe above ?
> 
> I haven't found any documentation on that.  This is purely empirical.
> Although I'm sure that we can dig something if chatting on GCC's IRC.

If it is not documented, then I am reluctant on depending on a behavior
which may be what happens today, but may not be the same for past/future
toolchains.

> 
>> Also, we should compare two approaches to fulfill your goal:
>> one alternative would be to have application/library constructors
>> explicitly call tracepoint constructors if they wish to use them.
> 
> I would prefer this way.  The former solution might not work in some
> cases (e.g. with LD_PRELOAD and priority =101) and I prefer explicit
> initialization in that case.
> 
> I don't see any cons for the second approach, except making the symbols
> table a few bytes larger.  I'll post a patch soon so we can compare and
> try to find more documentation on ctor priority.

And users will have to explicitly call the constructor on which they
depend, but I don't see it as a huge burden.

Beware though that there are a few configurations which can be used for
probe providers (see lttng-ust(3)).

Thanks,

Mathieu

> 
> --
> Olivier Dion
> PolyMtl

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
