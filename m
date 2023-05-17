Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA81C77B75
	for <lttng-dev@archiver.kernel.org>; Wed, 17 May 2023 16:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684339722;
	bh=yZ5wqOVbSDm3R+kFIPHDbIgwGNZ15jkRiUSAJvmc3XE=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=Lt8HM9tPfl09nCbA9IJXq+NKXN1mSsIC/O9HRxr0pq88fv1+LNR6SSLrorC5F+0VQ
	 7aRsxfCelgwh9k9z2tfmWONxUhD0OAURGtCcJP1ehd5+M3n8i/xFhbzR7F4BPzwIbl
	 ubBlgYWqhwX18ziIGQZk/i/bPT/j+aQ5j49+/R+HiIA2o9RjEUTxIrD7mnyDpGgTk4
	 mzQrG28I3pp7QO2o9xrVlnKJiiEQbklmlZcsEGpq5u4MbdysWWzN5tXCfjTJX3ZAXa
	 jUFlPSO/7c/Xd4xcUKD7CEnMJouespRBACsNT9I1BsEJwu1i1WCyPd4kdiAD38qvMU
	 NAwGCZs8sVp/A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QLyhT3Zg8z1FX4;
	Wed, 17 May 2023 12:08:41 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QLyhR4jxXz1FCB
 for <lttng-dev@lists.lttng.org>; Wed, 17 May 2023 12:08:39 -0400 (EDT)
Received: from [172.16.0.135] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QLygk6Tthz12fh;
 Wed, 17 May 2023 12:08:02 -0400 (EDT)
Message-ID: <2d953bd2-6544-3357-1424-fa44731e2bf5@efficios.com>
Date: Wed, 17 May 2023 12:08:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Brian Hutchinson <b.hutchman@gmail.com>, lttng-dev@lists.lttng.org
References: <CAFZh4h8C5ZVHGWsBW2iaVYi56t=SsmuiSGZPLf0KpQO9LwfeMQ@mail.gmail.com>
In-Reply-To: <CAFZh4h8C5ZVHGWsBW2iaVYi56t=SsmuiSGZPLf0KpQO9LwfeMQ@mail.gmail.com>
Subject: Re: [lttng-dev] Trying to understand use of lttng enable-event
 --kernel --userspace-probe=
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2023-05-16 22:11, Brian Hutchinson via lttng-dev wrote:
> Hi,
> 
> I'm trying to figure out how to use uprobes with lttng.
> 
> I can't use a normal uprobe for a line number just using the address I
> want to probe obtained from objdump?  As in:
> 
> echo 'p /usr/local/bin/my_app:0x2c3a8' >>
> /sys/kernel/debug/tracing/uprobe_events
> 
> ... which isn't a function entry, it's just a line of code I want to probe on.
> 
> This link says it has to be elf or sdt:
> https://lttng.org/man/1/lttng-enable-event/v2.11/#doc-opt--userspace-probe
> 
> So can I not probe on just a line of code by specifying an address???
> 
> It doesn't look like these methods above will do what I'm wanting to
> do.  I've tried to find examples of using enable-event --kernel
> --userspace-probe= but there doesn't appear to be many.
> 

There are examples here:

https://lttng.org/docs/v2.13/#doc-enabling-disabling-events

Indeed inserting a lttng-modules uprobe within functions is not 
supported at the moment, mainly because we prefer to err towards safety 
and don't have the validation in place to prevent corrupting the 
program's instructions if an end user would try to insert a uprobe at an 
address which is not an instruction boundary.

So we only support inserting uprobe on functions and SDT probes at
the moment.

Thanks,

Mathieu


> Thanks,
> 
> Brian
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
