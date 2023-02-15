Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39925C636D4
	for <lttng-dev@archiver.kernel.org>; Wed, 15 Feb 2023 19:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1676489631;
	bh=jfM0RXSFcAf0/MPWjLjCyRGn9zi19v/u4ZIO532wRMQ=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=p5bFkMFIXgmEnkhVz1vnikZM2URgYKiFJOhQAXc9yLmQknba+Zp21Xplfs+Hi5KtP
	 tlgl4hKSgIBNBBvLUqlc1R6bnMX2Nh2D5sQWgJMlh9JOVa+fN+t9KOxGPGxqdT/dvZ
	 LZMTjYmhbpnxetmbvzJpgddULsRYRJByh8WMyAXCklMAK1wtUaqIqaTF9j1Ltf8T7y
	 fzt62Ocfmvmv7E2iHJf9YI2SOvFnKmRhFfgzWVJR4VgIY1a0sUHy1+llo0IvZ/SSC4
	 oR0mbOdZXAOSdn0VJJ0SNzLkdtywu/evckF0Gy0X2jxFS0J32TbpFFJgcgkznfJZ1R
	 iiB4GS68X+3lA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PH7YB5b6Tz1fK3;
	Wed, 15 Feb 2023 14:33:50 -0500 (EST)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4PH7Y93rPXz1fK1
 for <lttng-dev@lists.lttng.org>; Wed, 15 Feb 2023 14:33:49 -0500 (EST)
Received: from [172.16.0.188] (192-222-180-24.qc.cable.ebox.net
 [192.222.180.24])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4PH7XZ63PHzlHy
 for <lttng-dev@lists.lttng.org>; Wed, 15 Feb 2023 14:33:18 -0500 (EST)
Message-ID: <2ccf0476-b0fd-7123-0822-521d78c95c29@efficios.com>
Date: Wed, 15 Feb 2023 14:33:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To: lttng-dev@lists.lttng.org
References: <CAJw2uSD1OacdHRbppqUk4tmDM7JXoTo1z2tF6eLUmcWke+a6aA@mail.gmail.com>
In-Reply-To: <CAJw2uSD1OacdHRbppqUk4tmDM7JXoTo1z2tF6eLUmcWke+a6aA@mail.gmail.com>
Subject: Re: [lttng-dev] Filtering tracing by process name or PID/TID
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

On 2023-02-15 04:09, Rengar Stinkt via lttng-dev wrote:
> Dear community,
> I only recently started working with lttng tracing due to work related 
> projects, so I am very new to this. I have done some research before 
> posting this but I can't seem to find an answer.
> I am running several CPU load tests for specific processes on different 
> devices using lttng and TraceCompass for visualization. I am running 
> into the issue that 99.9% of traced processes are not of value to me and 
> the tracing files get extremely big and hard to work with (filtering 
> with TraceCompass is very slow).
> Now I thought of filtering the processes before tracing and I found 
> filtering by PID and TID. The issue with this is that the PIDs and TIDs 
> are unique on each device but change between devices.
> I then found the command "htop -d 0.1 -u **String**" to see currently 
> running processes with a certain name.
> Now if I run this it shows me the running process IF they are running. I 
> have time triggered and event triggered processes. There are many 
> inconvenient workarounds to make it work, like triggering the events and 
> finding out the PID and then manually copying all of the IDs and pasting 
> them into "lttng track --kernel --pid=""". But I am trying to find a way 
> to either filter by name right away, avoiding relying on PIDs or at 
> least to have an automated process of doing it. But I am unfamiliar with 
> running code in the PuTTY terminal that we are using, so I am trying to 
> avoid this (for now). If this is the only option though, I will have to 
> look into it.
> Is there any way to filter by name right away like in the mentioned htop 
> command?
> Thank you so much in advance.

This would be:

lttng enable-event -k event_name --filter '$ctx.procname == "string"'

Where "string" can include wildcards as well.

Hoping this helps,

Mathieu


> Dom
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
