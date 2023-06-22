Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BC5EB64DA
	for <lttng-dev@archiver.kernel.org>; Thu, 22 Jun 2023 19:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1687463795;
	bh=qRrFbVE1JKElVaxJO2pNvpXJqfAv/QSNOQAXF7xsexM=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=lWbrTTY7UpvNbcltV2bx1+8YsIKCRxmfoxOTpGeCCr7yTY8ST3ULB5R2JEWdWz01A
	 ca1SzxtoNAinaVzX3eFf1tusnz6phP4sPtBzF+VJTLo43nDyhN/s7GBKArMKQW/DoL
	 QsUFy+xo9TuSRdSs5VwG0sRSXmj4Wb8zAa9GkqzgmhkoKqFydfVhZV+wvTGVgr7vIl
	 csuZbqVJ+3uv8mVENtPTYY5Bk61HOfDiWRRZDAH47Q6FrQQRM6eoBo47BePp3Rjq1u
	 AZ1YjMkzizGYvVtV1nSIulfmc54IvnAlGybri45MsZsQ4qo17wqf4sLdpNLV/3vmgB
	 MJ7cgXzu6IvAQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QnB2p4hHrz20DH;
	Thu, 22 Jun 2023 15:56:34 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QnB2m1yMRz205g
 for <lttng-dev@lists.lttng.org>; Thu, 22 Jun 2023 15:56:32 -0400 (EDT)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QnB2l1dP9z19Mh;
 Thu, 22 Jun 2023 15:56:31 -0400 (EDT)
Message-ID: <9e5fbcf0-bf3d-c0b3-c45b-2e440e8276e1@efficios.com>
Date: Thu, 22 Jun 2023 15:56:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Olivier Dion <odion@efficios.com>, paulmck@kernel.org
Cc: lttng-dev@lists.lttng.org
References: <20230515201718.9809-1-odion@efficios.com>
 <20230515201718.9809-3-odion@efficios.com>
 <c7834f41-c033-4c53-96e8-0ad728c2a285@paulmck-laptop>
 <ffec193e-7060-3fe2-6526-c54e89e992e6@efficios.com>
 <105bad2a-9fed-4353-a434-a571ce9da7ac@paulmck-laptop> <87zg4rl1du.fsf@laura>
In-Reply-To: <87zg4rl1du.fsf@laura>
Subject: Re: [lttng-dev] [PATCH 02/11] urcu/uatomic: Use atomic builtins if
 configured
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

On 6/22/23 15:53, Olivier Dion wrote:
> On Thu, 22 Jun 2023, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
>> I suggest C11 volatile atomic load/store.  Load/store fusing is permitted
>> for non-volatile atomic loads and stores, and such fusing can ruin your
>> code's entire day.  ;-)
> 
> Good catch.  Seems like not a problem on GCC (yet), but Clang is extremely
> aggressive and seems to do store fusing on some corner cases [0].

I don't think this is an example of store fusing, but rather just that 
the compiler can eliminate stores to static variables which are 
otherwise unused, making the entire variable useless.

Thanks,

Mathieu

> 
> However, I do not find any simple reproducer of load/store fusing.  Do
> you have example of such fusing, or is this a precaution?  In the
> meantime, back to reading the standard to be certain :-)
> 
>   [0] https://godbolt.org/z/odKG9a75a
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
