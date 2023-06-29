Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66226EB64D9
	for <lttng-dev@archiver.kernel.org>; Thu, 29 Jun 2023 18:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1688063364;
	bh=gSyjLLLW1P7NN+orzqPHgWYQZwh/LaLpXdPIKNWHhOU=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=k3OvQtWsWkqx03ss/1C1ldzhAUdHfwRn+LZLT7oyJX2pI13OXE1gmanrov1gdRQnD
	 +Z/ixe8m7JMKPoVNM1EQ2VW07C/VLJlocwMSPBxM7wjAQx8PUd8ogxFta5e8Hwt25W
	 FJY8gGRKVlbsLk2eVCit7OK589ifuQHhsmn3yyzPuCfflV57N7izm0zRMJmvx6m/lb
	 z41GckiXnzfahcwLmUJpRf43kanWaJDHTEA/nQaQ9H8ZVLk02Oc1Uw6mDyrflnBrat
	 KcXvdT2q4GB3WPWofygE4437N33Hs6VycXAQEAKjQMfbKc2kDETRXR26bwZiV6UmJZ
	 FcV4pKwtF2DNA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QsRmz46S2z228c;
	Thu, 29 Jun 2023 14:29:23 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QsRmx6fy6z22Lb
 for <lttng-dev@lists.lttng.org>; Thu, 29 Jun 2023 14:29:21 -0400 (EDT)
Received: from [192.168.18.2] (unknown [198.16.185.171])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QsRmx2lnmz19wy;
 Thu, 29 Jun 2023 14:29:21 -0400 (EDT)
Message-ID: <5e3c2974-8e00-5e6b-a9bc-4933c5f643c8@efficios.com>
Date: Thu, 29 Jun 2023 14:29:50 -0400
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
 <105bad2a-9fed-4353-a434-a571ce9da7ac@paulmck-laptop> <878rc2ji9z.fsf@laura>
In-Reply-To: <878rc2ji9z.fsf@laura>
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

On 6/29/23 13:22, Olivier Dion wrote:
> On Thu, 22 Jun 2023, "Paul E. McKenney" <paulmck@kernel.org> wrote:
>> On Thu, Jun 22, 2023 at 11:55:55AM -0400, Mathieu Desnoyers wrote:
>>> On 6/21/23 19:19, Paul E. McKenney wrote:
>> I suggest C11 volatile atomic load/store.  Load/store fusing is permitted
>> for non-volatile atomic loads and stores, and such fusing can ruin your
>> code's entire day.  ;-)
> 
> After some testing, I got a wall of warnings:
> 
>    -Wignored-qualifiers:
> 
>      Warn if the return type of a function has a type qualifier such as
>      "const".  For ISO C such a type qualifier has no effect, since the
>      value returned by a function is not an lvalue.  For C++, the warning
>      is only emitted for scalar types or "void".  ISO C prohibits
>      qualified "void" return types on function definitions, so such
>      return types always receive a warning even without this option.
> 
> Since we are using atomic builtins, for example load:
> 
>    type __atomic_load_n (type *ptr, int memorder)
> 
> If we put the qualifier volatile to TYPE, we end up with the same
> qualifier on the return value, triggering a warning for each atomic
> operation.
> 
> This seems to be only a problem when compiling in C++ [0] while in C it
> seems the compiler is more relaxed on this [1].
> 
> Ideas to make the toolchains happy? :-)

Change:

(__typeof__(*ptr) *volatile)(ptr);

(which applies the volatile to the pointer, rather than what is pointed to)

to either:

(volatile __typeof__(*ptr) *)(ptr);

or:

(__typeof__(*ptr) volatile *)(ptr);

Thanks,

Mathieu

> 
>    [0] https://godbolt.org/z/3nW14M3v1
>    [1] https://godbolt.org/z/TcTeMeKbW
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
