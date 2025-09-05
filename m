Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20ADCCA0FED
	for <lttng-dev@archiver.kernel.org>; Fri,  5 Sep 2025 18:04:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cJPPT39TSz28t0
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1757095471;
	b=pTMQCB0fZH+wbW9Y59iXhPvxme0qtJ37NqEd16/Q2cwDk1CbVjNBJ+oJAzyghmGcv/Mw
	 mzyjfYCLCh5UfJztFpkY44a0J7uBaG7383PTysvneIun1xOyT9cwSwm1yqT6csL/APQlH
	 aD9FxUBy9RkDEmQj5Z6xW11a7Ls8FzFyLL2/ej8unn9M5sc1maTs3LqJ/dAXyIYPV4I76
	 cyG0fqJmrU6QG+wfL8/YHy2uQ8CEKKLYmC7tF6ZTmjutc4ECSJ8zUtpZYwl5aEX9F2Zmf
	 87X7bh0cG+zIkRiJAYHy+PqglUHDa9meSSEWXy+SIsB+96qxeIhNH+ybA/kVZ6QG/cg==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1757095471;
	h=DKIM-Signature:To:Subject:Date:Message-ID:MIME-Version:From:From;
	bh=12EpahFrErfhUFDkQ6Yga/RptJjBjHybWmNf2/ORbRQ=;
	b=Vjnd0/1bt4w1nwZLtaNdfdlJyf5uj4h1GaKzbRtfsUYz3AxDWsXZ8qSNrSzO1ubtT+Q3
	 ByeMzsH7mv5wXYh76ZSPGqPUo+HvnK5jJY3EkODR5t5msXSgUHFxoWIOAxVHQD0dfuZwW
	 dm1zynj0z9T1JQiDQT1yoWub6zQC54sFjj/sOfw6Wyga1Np6miekWeldXt6IXZ+OoEG1q
	 BKXjvSLhXkkFc567HoLfngkwH6EDLZHD+BKLWoFdyK5UbisBGy1f3EMixpbxoiKgE0ixp
	 AH0n1vLaxnA7qy3AymWq/MFuQ9Ci98iR0e5roeg3H56WNL6BYf1Rfg5GgPfUTzxXcBQ==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cJPPT39TSz28t0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1757095471;
	bh=12EpahFrErfhUFDkQ6Yga/RptJjBjHybWmNf2/ORbRQ=;
	h=To:Subject:In-Reply-To:References:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=dXDGg4YLeSeBWj10/+QR4mOTMllHMHs+QTGgxnv+lzd1Huaw10LoJQZIOtY6WKBua
	 gP58BlbsVyR5Xf0b50TJRnMXvgiyoDwtymlqWC1gmiy12TyEqnxCjjPQ1V57ofiW8O
	 MkqY63yxEUU3sgO1WXFstrgUj9gyD2Y6JHrsUeRPu9DMJUUi2f57kEgTUTEtg8M6v3
	 ew+Xq+fF10/6h34d8BeCImxAqjqy/tLkSahzBqJUQ1cj0fDSVwDmhNEsE1HWZ62KNP
	 1rqEQLCvYDT/1Hv3WcFenHg5ctHrVCyMZBgDB7KSKM/QSlrDHwAyGlvYUKR68EczK5
	 gVAX0ENF97JsQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4cJPPT39TSz28t0;
	Fri,  5 Sep 2025 14:04:29 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cJPPR67T5z28sy
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cJPPR67T5z28sy
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
 by lists.lttng.org (Postfix) with ESMTPS id 4cJPPR67T5z28sy
 for <lttng-dev@lists.lttng.org>; Fri,  5 Sep 2025 14:04:27 -0400 (EDT)
Received: from localhost (199-193-172-8.cpe.axion.ca [199.193.172.8])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4cJPPL22Z0z8Qt;
 Fri, 05 Sep 2025 14:04:22 -0400 (EDT)
To: Thobias Knudsen <thobknu@gmail.com>
Subject: Re: URCU feature request?
In-Reply-To: <CAKGpcioZbhyTUqLmNSnpuPw=jbi6eZV6ubbFQtvFD6VKn3wKxA@mail.gmail.com>
Organization: EfficiOS
References: <CAKGpciq6Cb6+hqsfn+_zPk+MqCg+b0M_Gc3jVxVvnEGcE8rdLw@mail.gmail.com>
 <CAKGpciqHpGqGJChLa8p4P4Xv7EyUPMxULHxeknOTyie8kHH6hg@mail.gmail.com>
 <3c49eadb-f310-46b2-984d-58a0c193cde9@efficios.com>
 <CAKGpcipt=fWJi9Y497C3vq03CXmPY6rXQqs8ZP9nDoTGdRKnAA@mail.gmail.com>
 <CAKGpcipfyp3Ds4J0OH96Mu4zVhCLJg8g6tqEnfcRscZ1T8EmVA@mail.gmail.com>
 <2f0dc1b4-3fcb-453c-aa42-4a1f85623300@paulmck-laptop>
 <CAKGpciq+ixOVGN7TXYaF336ZEL_mOejzic5BvaKbexwwn_aqOQ@mail.gmail.com>
 <BD1A29BD-2AD2-4092-B1A2-DFEFAE77AAEE@sury.org>
 <CAKGpcip6w2nVQ+vbtfFH1296xTi5HYX+68J8okecChsihejDQA@mail.gmail.com>
 <87y0qwwc6j.fsf@laura>
 <CAKGpcioZbhyTUqLmNSnpuPw=jbi6eZV6ubbFQtvFD6VKn3wKxA@mail.gmail.com>
Date: Fri, 05 Sep 2025 14:04:21 -0400
Message-ID: <87h5xg7p3u.fsf@laura>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
From: Olivier Dion via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Olivier Dion <odion@efficios.com>
Cc: lttng-dev@lists.lttng.org
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Thu, 04 Sep 2025, Thobias Knudsen <thobknu@gmail.com> wrote:
>> I am confuse about the overall discussion here.  Are we talking about
>> static checking of RCU pointers usage or runtime checking?
>>
>> Is is possible to see the implementation you made so I can understand
>> better?
>
> Sorry for being late to answer :/
> The library overrides a subset of urcu and lfht functions with macros and
> replaces them with other functions which checks in runtime if the functio=
ns
> are called in the correct order.
> here is the code: https://github.com/ThobiasKnudsen/urcu_lfht_safe

It looks like you want runtime verification for the usage of the API.
Did you know that URCU can now be compiled against ThreadSanitizer
(TSAN)?  If a user misuses the API or makes incorrect assumptions about
the guarantees offered by RCU, TSAN will most likely detect those
issues.  Coupled with the other debug features we already have, this
makes it very hard to not trigger an error path when the API is used
incorrectly.

Note that certain kind of errors could actually be flag at compile time
with the proper tooling.  For example, the Linux kernel uses a `__rcu'
attribute that Sparse can understand to flag improper use of
RCU=E2=80=91protected pointers.  I=E2=80=99d be very open to exposing somet=
hing similar
(an attribute) for static checkers.

[...]

Thanks,
Olivier
--=20
Olivier Dion
EfficiOS Inc.
https://www.efficios.com
