Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C377C36006
	for <lttng-dev@archiver.kernel.org>; Tue, 17 Sep 2024 10:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1726567988;
	bh=PAAF53DQgaS1yQlK4gDjRZJD4tOCYqusg106eXVvFr0=;
	h=Date:To:References:Cc:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=g5QNjDbHDzJFwdb7zhEa1UV7aGVchuuXZRHNov0qHNwTRQmv6HNjl1SmKfxSnT+pj
	 4gv8uixIV5ww4nZMzIVYWjW+T952ERy3PtVG2djGAYrahdQGcqsFCcrHT1nWI3aJf5
	 deoByX6jIew9xFe8zBBXZqlFEqwnpamkSwmSApwv58rRQ3tZXfU5zqsOzw8uGREvR0
	 vjYXTRAXWky/7z7GdkNMwWBmLHQyDVWCGSHivEYGx7QDB97LMijC0NoR8dZRx+SRBe
	 S+dHqbPJloXs4wlRLk3TCV8nuL8L94qq0lQ3rjhdY+vIiwo4ZcOW9fimU16TYoIjzX
	 uQNJPtvr6a2/w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4X7HfW5Crrz1HbJ;
	Tue, 17 Sep 2024 06:13:07 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com
 [IPv6:2607:5300:203:b2ee::31e5])
 by lists.lttng.org (Postfix) with ESMTPS id 4X7HfV3QdKz1Hk8
 for <lttng-dev@lists.lttng.org>; Tue, 17 Sep 2024 06:13:06 -0400 (EDT)
Received: from [IPV6:2001:4bc9:a46:d7de:edc9:fc73:b785:1ddd] (unknown
 [IPv6:2001:4bc9:a46:d7de:edc9:fc73:b785:1ddd])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4X7HfT0Nbkz1LCq;
 Tue, 17 Sep 2024 06:13:04 -0400 (EDT)
Message-ID: <a8fe7a41-e0d3-4dd4-8713-172900f40664@efficios.com>
Date: Tue, 17 Sep 2024 12:12:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Akhil Veeraghanta <akhil.veeraghanta@outlook.com>,
 Akhil Veeraghanta via lttng-dev <lttng-dev@lists.lttng.org>
References: <LV8P222MB1013B292A6263022FF86BCB0E5612@LV8P222MB1013.NAMP222.PROD.OUTLOOK.COM>
Content-Language: en-US
Cc: Simon Marchi <simon.marchi@efficios.com>,
 Philippe Proulx <pproulx@efficios.com>
In-Reply-To: <LV8P222MB1013B292A6263022FF86BCB0E5612@LV8P222MB1013.NAMP222.PROD.OUTLOOK.COM>
Subject: Re: [lttng-dev] workqueue tracing symbols
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

On 2024-09-17 02:44, Akhil Veeraghanta via lttng-dev wrote:
> Hello,
> 
> We are trying to debug kernel work queue related issues in our system. 
> And as such, we've turned on workqueue_queue_work, 
> workqueue_active_work, workqueue_execute_start, workqueue_execute_end.
> 
> The tracepoint itself stores the function pointer which we can look up 
> from /proc/kallsyms manually.
> 
> We've been struggling to do this automatically, we've tried:
> 
>  1.
>     Using babeltrace2 to "convert" from lttng to lttng by just editing
>     the events in place. This doesn't work (atleast as easily) because
>     the event iterator is const.

Augmenting the CTF trace with extra symbolic information using
babeltrace2 would be the preferred way. We have examples on how to
do it with the debug-info babeltrace2 filter component. CCing
Philippe and Simon about this.

> 
>  2.
>     Loading the kallsyms file with "Configure Symbols" in trace compass
>     doesn't work either because it doesn't know that it can look up
>     functions in workqueue events from that file.
> 
>     Converting to a text based format like chrome trace and replacing
>     the fields works, but then we have to use chrome::tracing which
>     isn't as powerful.
> 
>     Before we go any futher modifying trace compass or writing a smarter
>     parser, is there a way we can trace the workqueues and do the lookup
>     properly?

Fetching the symbol information at tracing time would add a significant
overhead in terms of CPU cycles and wasted ring buffer space. Symbol
resolution should really be kept to post-processing unless there are
really no other options.

Thanks,

Mathieu


> 
>  3.
> 
> 
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
