Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D05C43334
	for <lttng-dev@archiver.kernel.org>; Wed, 22 Jun 2022 13:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1655904008;
	bh=iHr/a1+Gkb6Fht+6GaRYxl9Jl10/R/UVbmHXRlOwssQ=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=hCEwV/I89t2sxCvJjFfbTaF3MSVxccIkUU1Y0Euc3j+hnOopmrB6iSlR9MrP5WaUX
	 +wmDNqEbAhB6j8gw4K9uuk8RpTyuc8fDXp3KQvPyybTCQs0PDebHJr6kwDyCUzvmYb
	 urDmo2/Lcy9aFdV2AAvfZG2SLrf7Xpkn00MOWBGZaqE0eZqaANi0ATaE8+pOB4dzjc
	 nGNCeV73Jk5b7FscsbKvZ8IejPskkyahzjbzA+1w0l+54wRsyePUpQ1uvSS8+xhIzN
	 bnF0o/xxcLX/E321iw5yEXVqqLX4XAP42DGr83u9WbyPpWpxMypbFylispRhV78pBw
	 3wTf3J7B36uyQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LSkWr06v3zDRK;
	Wed, 22 Jun 2022 09:20:08 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4LSkWp22FLzCTv
 for <lttng-dev@lists.lttng.org>; Wed, 22 Jun 2022 09:20:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8A5CC287D3F
 for <lttng-dev@lists.lttng.org>; Wed, 22 Jun 2022 09:19:59 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id yEMZ-6euHPlw; Wed, 22 Jun 2022 09:19:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 12BFD287D3D;
 Wed, 22 Jun 2022 09:19:59 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 12BFD287D3D
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id zoEE0CFGIcbz; Wed, 22 Jun 2022 09:19:59 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 07461287D3C;
 Wed, 22 Jun 2022 09:19:59 -0400 (EDT)
Date: Wed, 22 Jun 2022 09:19:58 -0400 (EDT)
To: Minlan Wang <wangminlan@szsandstone.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, paulmck <paulmck@kernel.org>
Message-ID: <1420937751.21327.1655903998961.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220622074535.GA269641@localhost.localdomain>+6EDBC2C12E8A16E5>
References: <20220614035533.GA174967@localhost.localdomain>
 <20220615034900.GA187807@localhost.localdomain>
 <396090936.61897.1655302558168.JavaMail.zimbra@efficios.com>
 <20220616080912.GA246781@localhost.localdomain>
 <1711122492.5944.1655473043420.JavaMail.zimbra@efficios.com>
 <20220621035206.GA267474@localhost.localdomain>
 <1843612610.17820.1655817158376.JavaMail.zimbra@efficios.com>
 <20220622074535.GA269641@localhost.localdomain>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - FF100
 (Linux)/8.8.15_GA_4304)
Thread-Topic: ***UNCHECKED*** Re: Re: urcu workqueue thread uses 99% of cpu
 while workqueue is empty
Thread-Index: /dYvM5tb7eJkihrmAnXa3+eAc0+3EA==
Subject: Re: [lttng-dev] ***UNCHECKED*** Re: Re: urcu workqueue thread uses
 99% of cpu while	workqueue is empty
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

----- On Jun 22, 2022, at 3:45 AM, Minlan Wang wangminlan@szsandstone.com wrote:

[...]

Hi Minlan,

> --
> 1.8.3.1
> 
> 
> And the lttng session is configured to trace these events:
> kernel: syscall futex

On the kernel side, in addition to the syscall futex, I would really like to see what
happens in the scheduler, mainly the wait/wakeup tracepoints. This can be added by using:

lttng enable-event -k 'sched_*'

This should help us confirm whether we indeed have a situation where queued wake ups
happen to wake up a wait happening only later, which is unexpected by the current liburcu
userspace code.

[...]

> ---
> 
> The babletrace output of this session is pretty big, 6 MB in size, i put it in
> the attachment trace_0622.tar.bz2.
> Let my know if your mailbox can't handle such big attachment.

It would be even better if you can share the binary trace, because then it's easy to
load it in trace compass, cut away time ranges that don't matter, and lots of other
useful stuff.

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
