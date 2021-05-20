Return-Path: <SRS0=dYoO=KP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93DEC43460
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 17:18:58 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00518610CC
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 17:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00518610CC
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FmGg450V5z1rmg;
	Thu, 20 May 2021 13:18:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621531137;
	bh=Rpb72W9nDVALFAPT+x49rz726nVVgtrDKfouljf+HL4=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=JmMQYgs5kx2q9/sm9OuG+QxvUUZZFYGrZvB5vjoH1DqqihI9Ovm4e81X2u4psHqC+
	 cEuUvCQfHWEcfF38Yw8mGATZi8xbFbJH17VB3Yb8KBoaeCR29vx4MFe4tf7PAP1mp8
	 AWEiRKMwdo7XsgaOPOiZyfVF6OXXN+mUzQgChHcPOmQDhBu88UuGu0GNT1XGinsRj/
	 MqfoJuQc+u/gQGFZ22oN3xHTLAjRVlze9/jASfe3YlMQDmCWWJIadi6x2uVrBwX4+w
	 w0IZ5RLKJiNrg5w6ELl1k5c59fKwxmXI7/Snb1/vEThfjNkMXWWR7zNt87BW3Sru0C
	 Z1mf/K1QF543w==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FmGg35ZyTz1rqB
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 13:18:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 79C4F337C10
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 13:18:48 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Wsq8CzPWpega; Thu, 20 May 2021 13:18:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5F4B6337B24;
 Thu, 20 May 2021 13:18:47 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5F4B6337B24
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 8vZbeUT2X1Ur; Thu, 20 May 2021 13:18:47 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 552C5337B90;
 Thu, 20 May 2021 13:18:47 -0400 (EDT)
Date: Thu, 20 May 2021 13:18:47 -0400 (EDT)
To: Norbert Lange <nolange79@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <154847626.52635.1621531127222.JavaMail.zimbra@efficios.com>
In-Reply-To: <CADYdroMFR3P7OmHt=U9bUUpkWOfqBWdn9f6c4N+J_g5G9WL=Cw@mail.gmail.com>
References: <20210520121807.55428-1-nolange79@gmail.com>
 <1600729511.52338.1621520352970.JavaMail.zimbra@efficios.com>
 <CADYdroN3FF3Qs_B55s_Un2qOGz3sP=JMpV=QWRFcO7KVzL-8_A@mail.gmail.com>
 <982122605.52445.1621524098787.JavaMail.zimbra@efficios.com>
 <CADYdroPZTrNg+gYy9SLyDnUGUd1kNq3vkzzjSwJx9e7Tz68quw@mail.gmail.com>
 <523808152.52514.1621527935563.JavaMail.zimbra@efficios.com>
 <CADYdroMFR3P7OmHt=U9bUUpkWOfqBWdn9f6c4N+J_g5G9WL=Cw@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF88 (Linux)/8.8.15_GA_4007)
Thread-Topic: Improve tracelog handling, reduce exported functions
Thread-Index: pFpTRorJJdCu4Fn4s4Ioge+Yk+hdXQ==
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



----- On May 20, 2021, at 12:51 PM, Norbert Lange nolange79@gmail.com wrote:

> Am Do., 20. Mai 2021 um 18:25 Uhr schrieb Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com>:
>>
>> ----- On May 20, 2021, at 11:54 AM, Norbert Lange nolange79@gmail.com wrote:
>> [...]
>>
>> >> What prevents you from linking against lttng-ust.so again ?
>> >
>> > I did not poke around enough with Lttng to be confident it wont have
>> > side effects,
>> > I really don't want it active in production. It doesn't seem there is
>> > much public knowledge with Xenomai either.
>> > lttng-ust.so will spawn threads, lttng-ust-tracepoint.so is mostly passive,
>>
>> There is indeed a split between instrumentation and runtime threads done
>> with lttng-ust-tracepoint.so vs lttng-ust.so.
>>
>> I understand that this split is missing for tracelog and tracef, and
>> would be a good thing to have.
>>
>> I would be interested to move the tracelog and tracef implementation
>> from liblttng-ust.so to liblttng-ust-tracepoint.so, even this late
>> in the -rc cycle, because all users of tracelog/tracef need to link
>> against liblttng-ust-tracepoint.so anyway. So moving these symbols
>> should not affect anyone.
>>
>> Can you give it a try and let me know if it works for you ?
> 
> Will take some time, whats the timeframe you need for feedback?

Here is the tentative commit:

https://review.lttng.org/c/lttng-ust/+/5927 Move tracef/tracelog symbols to liblttng-ust-tracepoint.so

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
