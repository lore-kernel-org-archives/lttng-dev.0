Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F17C25B08
	for <lttng-dev@archiver.kernel.org>; Wed, 17 Aug 2022 15:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1660750068;
	bh=mkOXQC+JELfem9s8hcBC46OaL8j5l0vNxQpxozWLyEw=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ypjgayB4TRbXuUQ8Zq28tdL2F3XYfPTBlNTU3QuQDiPm186BSgGOIUBhqzrvwRW8H
	 FfssrYpJA06Vk+Rf90gHC1+uUefgM/RDBEWFJ1NDzaPouxec2OSbvwpLNdcjPbSSpW
	 CuqjCF5i/+hdR2XdplpI1L9OdEZxxoxfQkYUU6zSwFkaN97PWIkSNSfAQtpN9PV5sY
	 ds8Uv7Iuts9CVxyM6CNxgTjKeAr8ADUZPP5FApwc3HtA0xpHDOfRtmCGNf0/joDh+u
	 1nDcmCx0czXuqa1og5bt3LtBKN55znxSmN7hocp6p/GGMVg7jTpjIcmjm3mRVEnoHo
	 Bo69qedAmXqWw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4M7BjH4s06z1HdT;
	Wed, 17 Aug 2022 11:27:47 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4M7BjF6Fk4z1Hjj
 for <lttng-dev@lists.lttng.org>; Wed, 17 Aug 2022 11:27:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 709623668F3;
 Wed, 17 Aug 2022 11:27:29 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id gJsYAOZlWGUE; Wed, 17 Aug 2022 11:27:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 1940B366AE0;
 Wed, 17 Aug 2022 11:27:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1940B366AE0
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id IdRnTRvNcE0W; Wed, 17 Aug 2022 11:27:29 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 0F8C83668F2;
 Wed, 17 Aug 2022 11:27:29 -0400 (EDT)
Date: Wed, 17 Aug 2022 11:27:28 -0400 (EDT)
To: bruce ashfield <bruce.ashfield@gmail.com>
Message-ID: <1671185103.10716.1660750048986.JavaMail.zimbra@efficios.com>
In-Reply-To: <CADkTA4NkNEE=kmsiBeJ_UQ7bOZ07CtAEumy8Qfs5cvG=AA1X5Q@mail.gmail.com>
References: <20220803192327.3726094-1-bruce.ashfield@gmail.com>
 <65c3cadc-9053-ba31-67b3-30bb9294642d@efficios.com>
 <CADkTA4NkNEE=kmsiBeJ_UQ7bOZ07CtAEumy8Qfs5cvG=AA1X5Q@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4372 (ZimbraWebClient - FF103
 (Linux)/8.8.15_GA_4372)
Thread-Topic: compaction: make tracepoints condtional on CONFIG_COMPACTION
Thread-Index: gWxrDZ4X6fCQWpMM1aNezpNBq1CjOw==
Subject: Re: [lttng-dev] [PATCH] compaction: make tracepoints condtional on
 CONFIG_COMPACTION
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

----- On Aug 10, 2022, at 1:48 PM, Bruce Ashfield via lttng-dev lttng-dev@lists.lttng.org wrote:

> On Wed, Aug 10, 2022 at 11:20 AM Michael Jeanson <mjeanson@efficios.com> wrote:
>>
>> On 2022-08-03 15 h 23, Bruce Ashfield via lttng-dev wrote:
>> > Hi all,
>> >
>> > This was found during the update of the yocto project reference
>> > kernel to 5.19. Out of all the supported architectures, only
>> > mips failed during the build of lttng-modules.
>> >
>> > Specifically, it seems like the lack of CONFIG_COMPACTION being
>> > enabled in the kernel was the significant issue. Only one of the
>> > tracepoints blew up, but I can't see how any of them would be
>> > valid in this scenario, or why it would be limited to mips.
>> >
>> > While I don't think this is the right fix, this is what got me
>> > up and passing sanity testing, so I wanted to send the change
>> > and see what the actual, correct fix would be :)
>> >
>> > Cheers,
>> >
>> > Bruce
>>
>> Hi Bruce,
>>
>> Thanks for reporting this issue, I propose a simpler fix [1] of just
>> disabling the build of the compaction probe module when
>> CONFIG_COMPACTION is disabled in the kernel configuration.
>>
>> Can you confirm this patch fixes the issue on your side?
> 
> confirmed, it fixes the issue on my side.

Merged into lttng-modules master, stable-2.13, stable-2.12, thanks!

Mathieu

> 
> Bruce
> 
>>
>> Thanks,
>>
>> Michael
>>
>> [1] https://review.lttng.org/c/lttng-modules/+/8660
> 
> 
> 
> --
> - Thou shalt not follow the NULL pointer, for chaos and madness await
> thee at its end
> - "Use the force Harry" - Gandalf, Star Trek II
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
