Return-Path: <SRS0=QQXA=KQ=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D38FC47076
	for <lttng-dev@archiver.kernel.org>; Fri, 21 May 2021 14:55:53 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17F061244
	for <lttng-dev@archiver.kernel.org>; Fri, 21 May 2021 14:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17F061244
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FmqRW0BKqz1scc;
	Fri, 21 May 2021 10:55:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621608951;
	bh=ktObnXIWhFRJAk8xjPYGS4roKbuweMUgofsi5EZKW7s=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=rxnDmaDEJCNIQH7ucuAAnJyqYvvSdAs1F1+yDzNus4L7HnkokSsa/6zmr+VZet6Mx
	 o3+6jlPkTKDzxS573LegGWwT6sBv4GMf50gA+mIYgWNKBy1djnUzaVeC+ShUzDihFw
	 7V0OydxHRuleEHehz81hQORHDhFH87P3uFlL8lYn95qsQe5oO5YJ7uiOle10xCoZmq
	 cv4LwEFM3/yFJtbDSvo84HJgEEvF2erQ8CWOUmwWwX6qtd2gqkSjTq7dGYUat1UVuU
	 H02W0iJ5xRB9AAQd2Y3tQpVsrxnbHNMfbQgCNIIDzAWN0zTHT/29y1yAS4DOnaF4tx
	 uwt/Wb6S/JPog==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FmqR72rRRz1scb
 for <lttng-dev@lists.lttng.org>; Fri, 21 May 2021 10:55:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 2F3A43478EB
 for <lttng-dev@lists.lttng.org>; Fri, 21 May 2021 10:55:24 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id FKHIp7Ggoeoz; Fri, 21 May 2021 10:55:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 26EAB3478EA;
 Fri, 21 May 2021 10:55:23 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 26EAB3478EA
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id ufw4DuGKRTPz; Fri, 21 May 2021 10:55:23 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 1AF7B347B64;
 Fri, 21 May 2021 10:55:23 -0400 (EDT)
Date: Fri, 21 May 2021 10:55:22 -0400 (EDT)
To: Norbert Lange <nolange79@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1296448182.54074.1621608922994.JavaMail.zimbra@efficios.com>
In-Reply-To: <CADYdroM_7LVxoe6rQxZvgSqW_97pFd3t2i37NSvuGOmG0H2Lzw@mail.gmail.com>
References: <20210520121807.55428-1-nolange79@gmail.com>
 <CADYdroN3FF3Qs_B55s_Un2qOGz3sP=JMpV=QWRFcO7KVzL-8_A@mail.gmail.com>
 <982122605.52445.1621524098787.JavaMail.zimbra@efficios.com>
 <CADYdroPZTrNg+gYy9SLyDnUGUd1kNq3vkzzjSwJx9e7Tz68quw@mail.gmail.com>
 <523808152.52514.1621527935563.JavaMail.zimbra@efficios.com>
 <CADYdroMFR3P7OmHt=U9bUUpkWOfqBWdn9f6c4N+J_g5G9WL=Cw@mail.gmail.com>
 <154847626.52635.1621531127222.JavaMail.zimbra@efficios.com>
 <CADYdroM_7LVxoe6rQxZvgSqW_97pFd3t2i37NSvuGOmG0H2Lzw@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF88 (Linux)/8.8.15_GA_4007)
Thread-Topic: Improve tracelog handling, reduce exported functions
Thread-Index: LWqpCTCYXU1Fj5X5nxkM2wsa6LrLpg==
Subject: Re: [lttng-dev] [PATCH lttng-ust] Improve tracelog handling,
 reduce exported functions
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



----- On May 20, 2021, at 1:43 PM, Norbert Lange nolange79@gmail.com wrote:

> Am Do., 20. Mai 2021 um 19:18 Uhr schrieb Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com>:
>>
>>
>>
>> ----- On May 20, 2021, at 12:51 PM, Norbert Lange nolange79@gmail.com wrote:
>>
>> > Am Do., 20. Mai 2021 um 18:25 Uhr schrieb Mathieu Desnoyers
>> > <mathieu.desnoyers@efficios.com>:
>> >>
>> >> ----- On May 20, 2021, at 11:54 AM, Norbert Lange nolange79@gmail.com wrote:
>> >> [...]
>> >>
>> >> >> What prevents you from linking against lttng-ust.so again ?
>> >> >
>> >> > I did not poke around enough with Lttng to be confident it wont have
>> >> > side effects,
>> >> > I really don't want it active in production. It doesn't seem there is
>> >> > much public knowledge with Xenomai either.
>> >> > lttng-ust.so will spawn threads, lttng-ust-tracepoint.so is mostly passive,
>> >>
>> >> There is indeed a split between instrumentation and runtime threads done
>> >> with lttng-ust-tracepoint.so vs lttng-ust.so.
>> >>
>> >> I understand that this split is missing for tracelog and tracef, and
>> >> would be a good thing to have.
>> >>
>> >> I would be interested to move the tracelog and tracef implementation
>> >> from liblttng-ust.so to liblttng-ust-tracepoint.so, even this late
>> >> in the -rc cycle, because all users of tracelog/tracef need to link
>> >> against liblttng-ust-tracepoint.so anyway. So moving these symbols
>> >> should not affect anyone.
>> >>
>> >> Can you give it a try and let me know if it works for you ?
>> >
>> > Will take some time, whats the timeframe you need for feedback?
>>
>> Here is the tentative commit:
>>
>> https://review.lttng.org/c/lttng-ust/+/5927 Move tracef/tracelog symbols to
>> liblttng-ust-tracepoint.so
> 
> Well... this is certainly an improvement. I am not completely happy
> though: "... users now link against
> liblttng-ust-tracepoint.so explicitly"

I'm abandoning this change for now.

It's too late in the rc cycle for doing an ABI breaking change. Also, this
can eventually be done gradually by introducing a new .so with new symbols,
and mapping the tracelog/tracef APIs to those new symbols in a future release.
So I don't think it justifies breaking ABI at this stage.

> 
> My homecooked solution currently works like this:
> 
> *) define the probes from <lttng/lttng-ust-tracelog.h> with
> TRACEPOINT_PROBE_DYNAMIC_LINKAGE,
>    link them in the application, together with other dynamic probes
> *) build a separate library with *other* tracepoints, lets call it
> libtracepoint.so
> *) don't link the application to any lttng library.
> 
> Which means:
> 
> 1) the application works without lttng libraries. tracepoints are no-ops
> 2) if available then liblttng-ust-tracepoint.so is loaded (constructor
> function from your headers). tracepoints are no-ops
> 3) if the application dlopen's libtracepoint.so and in turn
> liblttng-ust.so then tracepoints work.
> 
> I'd lose option 1 compared to reimplementing tracelog using homecooked
> lttng-ust-tracelog tracepoints.
> 
> So, are there any issues using <lttng/lttng-ust-tracelog.h> that way,
> it seems to work fine,
> are there mutliple competing instances now?
> (I am not re-using any bit from tracelog.h, I am just after using the
> tracepoint definition).
> 
> I mean I could dlsym all the functions, but tracelog has 1 per
> loglevel and really ugly long names ;)

I recommend that you re-use the parts of tracelog which are useful to
you, but that you implement your own events within your provider .so
with your own event names, so there is no clash with upstream lttng-ust.

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
