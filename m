Return-Path: <SRS0=dYoO=KP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58EBC433ED
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 16:25:47 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C8F4606A5
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 16:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8F4606A5
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FmFTh3XJTz1s42;
	Thu, 20 May 2021 12:25:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621527945;
	bh=9EG9O/c0iPCnE/DD36geu/mFifwsF1UvcwKyeahZKQY=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=W/TzvglOZruB5++DZiwY+J3kB3DFz8E5IJtVI/FOqtR3Bn/lxRtRdlSP1DGVX2qh4
	 cxoGvKMXKsPXPityfmkc0RL/GcSBYX3eVIhfs5HB+8wqiD61Cm681zEHuIMwvXVZcJ
	 aFEU/TFs2Mu7Ak4nIHgT3UM4msdE4viYCizw8ZX+8eh307tGjl9FWF6+VPNguKqHiD
	 lyprEuycNPeQJ+XtRYXH7jzhtgW5qhZVgpDME4fVIVoVG9+8Nmd20VT6r2v3amSzKS
	 bZk0Qvb+W2nKHXZ8/hVgKDKFgNCBBkWlEyYW0VR8/tjBET7Ql0SQevq3z0DkZyG1Ve
	 IVdJ2zMUPYXLg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FmFTg1tCNz1s5q
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 12:25:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C697433712D
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 12:25:37 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id JrFcLH0Xo9vT; Thu, 20 May 2021 12:25:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id BD51A33712B;
 Thu, 20 May 2021 12:25:35 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BD51A33712B
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Zo2B7Qn1JfME; Thu, 20 May 2021 12:25:35 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id AF023336EF5;
 Thu, 20 May 2021 12:25:35 -0400 (EDT)
Date: Thu, 20 May 2021 12:25:35 -0400 (EDT)
To: Norbert Lange <nolange79@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <523808152.52514.1621527935563.JavaMail.zimbra@efficios.com>
In-Reply-To: <CADYdroPZTrNg+gYy9SLyDnUGUd1kNq3vkzzjSwJx9e7Tz68quw@mail.gmail.com>
References: <20210520121807.55428-1-nolange79@gmail.com>
 <1600729511.52338.1621520352970.JavaMail.zimbra@efficios.com>
 <CADYdroN3FF3Qs_B55s_Un2qOGz3sP=JMpV=QWRFcO7KVzL-8_A@mail.gmail.com>
 <982122605.52445.1621524098787.JavaMail.zimbra@efficios.com>
 <CADYdroPZTrNg+gYy9SLyDnUGUd1kNq3vkzzjSwJx9e7Tz68quw@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF88 (Linux)/8.8.15_GA_4007)
Thread-Topic: Improve tracelog handling, reduce exported functions
Thread-Index: A/ABAU9NCXIwzjHgoQs9TVyi/x7FvQ==
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

----- On May 20, 2021, at 11:54 AM, Norbert Lange nolange79@gmail.com wrote:
[...]

>> What prevents you from linking against lttng-ust.so again ?
> 
> I did not poke around enough with Lttng to be confident it wont have
> side effects,
> I really don't want it active in production. It doesn't seem there is
> much public knowledge with Xenomai either.
> lttng-ust.so will spawn threads, lttng-ust-tracepoint.so is mostly passive,

There is indeed a split between instrumentation and runtime threads done
with lttng-ust-tracepoint.so vs lttng-ust.so.

I understand that this split is missing for tracelog and tracef, and
would be a good thing to have.

I would be interested to move the tracelog and tracef implementation
from liblttng-ust.so to liblttng-ust-tracepoint.so, even this late
in the -rc cycle, because all users of tracelog/tracef need to link
against liblttng-ust-tracepoint.so anyway. So moving these symbols
should not affect anyone.

Can you give it a try and let me know if it works for you ?

> So Id want a dynamic tracepoint-provider than i can dlopen (so that
> the signal masks are inherited,
> I hope you dont touch them).

The signals are all blocked for lttng-ust listener threads. We don't
modify the signal masks in the tracepoint probes. Not sure which is
the target of your question though.

> 
> Of course I could just remove all lttng libraries on the production
> system aswell. Still doesnt change that
> tracelog and tracef doesnt work that way.

Would moving the tracelog/tracef implementation to liblttng-ust-tracepoint.so
solve your issues ?

> 
> I implemented my own tracelog/tracef using the normal lttng
> tracepoints for now, they totally break on source level with 2.13
> aswell ;)
> is it ok if I do this to access them:
> 
> #define TRACEPOINT_DEFINE
> #define TRACEPOINT_PROBE_DYNAMIC_LINKAGE
> // 2.12
> // #include <lttng/lttng-ust-tracelog.h>
> // #include <lttng/lttng-ust-tracef.h>
> // 2.13
> #include <lttng/tp/lttng-ust-tracelog.h>
> #include <lttng/tp/lttng-ust-tracef.h>
> 
> ie. I would load lttng-ust.so later and can then use those tracepoints.

Reimplementing the tracelog/tracef providers is not an intended use-case.
I'd very much prefer if we move their implementation to
liblttng-ust-tracepoint.so.

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
