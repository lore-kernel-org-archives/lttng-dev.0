Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F119EB64D9
	for <lttng-dev@archiver.kernel.org>; Thu, 29 Jun 2023 18:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1688063600;
	bh=rXPKwVJkEVbUEVgdBOwVqcuG02nJwbY7csAoRsCK0gw=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=BL9IMCJFccpp6iYzl7uFd6Dir2jxviHS7A/SfLyltP6OY8bTc5klZHAk+l6k0wYmk
	 zGU7bbNKSdgz3hB9fXj1DN4JlQ14e0rYtYx4TPL14vs2yhm8crI1LmoiuwQIKhKsB7
	 C9yUDsYxHl8OIgm5L73zqHq1bjCtzJWxaaFC+iD9lcR2Pzy9v3qRjvHpUX+k16uGIM
	 T+XvxJs0mKcAJycfeT0NLo+V5ZqLP4HVAC4Ek+Y2NgOihOrwEg4JoDBbImVT2QNrw2
	 xZAX5mHj9lJ5D2q6PsKQFa0OEY8LeVLTJv66b5R2P3LtfYLezX/vvPn9AHlOlKMHaq
	 HZJa9msI0MaYQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QsRsX1nZZz22Gv;
	Thu, 29 Jun 2023 14:33:20 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QsRsS65Syz22Gs
 for <lttng-dev@lists.lttng.org>; Thu, 29 Jun 2023 14:33:16 -0400 (EDT)
Received: from [192.168.18.2] (unknown [198.16.185.171])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QsRsS1SfZz19f6;
 Thu, 29 Jun 2023 14:33:16 -0400 (EDT)
Message-ID: <1b98056b-7e94-36c1-21b3-0c2fd069e42b@efficios.com>
Date: Thu, 29 Jun 2023 14:33:45 -0400
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
 <875y76ji0g.fsf@laura>
In-Reply-To: <875y76ji0g.fsf@laura>
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

On 6/29/23 13:27, Olivier Dion wrote:
> On Thu, 29 Jun 2023, Olivier Dion <odion@efficios.com> wrote:
> 
>>    [0] https://godbolt.org/z/3nW14M3v1
>>    [1] https://godbolt.org/z/TcTeMeKbW
> 
> Sorry.  That was:
> 
>      [0] https://godbolt.org/z/ETcxnz4TW

Change

(volatile __typeof__(ptr))(ptr);

for:

(volatile __typeof__(*(ptr)) *)(ptr);

and:

void love_iso(int *x)
{
      __atomic_store_n(cast_volatile(&x), 1,
                       __ATOMIC_RELAXED);
}

for

void love_iso(int *x)
{
      __atomic_store_n(cast_volatile(x), 1,
                       __ATOMIC_RELAXED);
}

Thanks,

Mathieu


>      [1] https://godbolt.org/z/jMjh8YoM4
> -- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
