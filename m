Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CE8C001B0
	for <lttng-dev@archiver.kernel.org>; Tue, 15 Aug 2023 12:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1692103057;
	bh=5KiGYFTJos+bHPLGerWVBSDH9b3flrSTC5p8w8QjNvo=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=DWkjqIJqAr8A2E9xU+1RwsBx8/smCrX/KnARmloXiAlf8HLWbz7DB73oyVlcEkKBY
	 qDyg5D0+zS/kePfBWkWRp0lng/rifCwFzG0mx0rai5fe0UZN8Z1tysxEScf8dlxYvB
	 sXuuvt5Jy1+XxNM8w52xi5T+bIFmlXUk/BkspofFhrRrEVxnuhk+jG5II/WfLUxuV+
	 YB0cXky0lht471azc1CUKdk2ZZCxIk1oXpou9tAoLGvmJNqtJBYDn5xmo1l8M1ov5Z
	 miH1dnK8/M4JvJApZ2U9CtWNzJ0pnjg0jK7dgT0Q+HfKixEBKrhBWxawOcxjIBHHp/
	 SNRMahbg1sIIw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RQ9lN26yKz2Mgk;
	Tue, 15 Aug 2023 08:37:36 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4RQ9lL3Kw7z2MF6
 for <lttng-dev@lists.lttng.org>; Tue, 15 Aug 2023 08:37:34 -0400 (EDT)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4RQ9lK5tPFz1LHw;
 Tue, 15 Aug 2023 08:37:33 -0400 (EDT)
Message-ID: <df134b32-9e1b-8deb-14fc-b09f02e2e678@efficios.com>
Date: Tue, 15 Aug 2023 08:38:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Olivier Dion <odion@efficios.com>, lttng-dev <lttng-dev@lists.lttng.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
References: <87v8gzuc3g.fsf@laura> <87jztxjpxa.fsf@laura>
In-Reply-To: <87jztxjpxa.fsf@laura>
Subject: Re: [lttng-dev] [RFC] Deprecating RCU signal flavor
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

On 8/14/23 17:05, Olivier Dion via lttng-dev wrote:
> 
> After discussing it with Mathieu, we agree on the following 3 phases for
> deprecating the signal flavor:
> 
>   1) liburcu-signal will be implemented in term of liburcu-mb. The only
>   difference between the two flavors will be the public header files,
>   linked symbols and library name.  Note that this add a regression in
>   term of performance, since the implementation of liburcu-mb adds memory
>   barriers on the reader side which are not present in the original
>   liburcu-signal implementation.
> 
>   2) Adding the deprecated attribute to every public functions exposed by
>   the liburcu-signal flavor.  At this point, tests for liburcu-signal
>   will also be removed from the project.  There will be no more support
>   for this flavor.
> 
>   3) Removing the liburcu-signal flavor completely from the project.
> 
> Finally, here is a tentative versions release of mine for each phase:
> 
>   1) 0.15.0 [October 2023] (also TSAN support yay!)
> 
>   2) 0.15.1
> 
>   3) 0.16.0 || 1.0.0 (maybe a major bump since this is an API breaking
>   change)

There is a distinction between the version number of the liburcu project 
(0.14) and the ABI soname for the shared objects. We may be able to do 
step (3) without going to 1.0.0 (I don't see removal of the urcu-signal 
flavor a strong enough motivation for hitting 1.0.0 yet).

Technically speaking, given that we would be removing the entire 
liburcu-signal.so shared object, we would not be changing _symbols_ 
within an existing shared object, therefore I'm not even sure we need to 
bump the soname for all the other remaining shared objects.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
