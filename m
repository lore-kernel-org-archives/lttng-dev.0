Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97A0C001B0
	for <lttng-dev@archiver.kernel.org>; Thu, 22 Jun 2023 19:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1687463632;
	bh=9vvo0a6klr8213LVBuTR/hmEDXZqxBUgz3GE2eVMF4o=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=pyO2qfEUjXknLrMRuaoEnNm64fLjaTi9XapXgwm3Q2Hl22H09M9qkQ2xn3XMwl9xK
	 bn3fJLVUGG13I2iEk3AO2BjsyBxVHYnx1WnndKwGqZ/wrQHOX8nPayyIFkTNaKViPw
	 Iarg6BooOtkC7aJy/bDHDI3L02ywPvX564qHcsPs94bX89O46Wxm82yBksyPBdjhjN
	 XZ3Kzti5vFAARjxzyTrNCdo5b45HA9L7EjOA+ytivk05l0m9Cs5NKJ76v/6b0QQ+cQ
	 YGAYoGkiKRwjBVH4A6VaFx/sxf70FvBWH9r7EvHaWXln9j+0pIGdE5USwAN0UpvTmC
	 BVGKUn4QNZHAA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Qn9zh5jQxz205d;
	Thu, 22 Jun 2023 15:53:52 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4Qn9zg07S4z20B2
 for <lttng-dev@lists.lttng.org>; Thu, 22 Jun 2023 15:53:51 -0400 (EDT)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4Qn9zf5hxjz19FS;
 Thu, 22 Jun 2023 15:53:50 -0400 (EDT)
Message-ID: <a46bfc35-e409-ecb8-d6d1-43ffabf46e63@efficios.com>
Date: Thu, 22 Jun 2023 15:54:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: paulmck@kernel.org
Cc: Olivier Dion <odion@efficios.com>, lttng-dev@lists.lttng.org
References: <20230515201718.9809-1-odion@efficios.com>
 <20230515201718.9809-3-odion@efficios.com>
 <c7834f41-c033-4c53-96e8-0ad728c2a285@paulmck-laptop>
 <ffec193e-7060-3fe2-6526-c54e89e992e6@efficios.com>
 <105bad2a-9fed-4353-a434-a571ce9da7ac@paulmck-laptop>
In-Reply-To: <105bad2a-9fed-4353-a434-a571ce9da7ac@paulmck-laptop>
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

On 6/22/23 14:32, Paul E. McKenney wrote:
> On Thu, Jun 22, 2023 at 11:55:55AM -0400, Mathieu Desnoyers wrote:
>> On 6/21/23 19:19, Paul E. McKenney wrote:
>> [...]
>>>> diff --git a/include/urcu/uatomic/builtins-generic.h b/include/urcu/uatomic/builtins-generic.h
>>>> new file mode 100644
>>>> index 0000000..8e6a9b5
>>>> --- /dev/null
>>>> +++ b/include/urcu/uatomic/builtins-generic.h
>>>> @@ -0,0 +1,85 @@
>>>> +/*
>>>> + * urcu/uatomic/builtins-generic.h
>>>> + *
>>>> + * Copyright (c) 2023 Olivier Dion <odion@efficios.com>
>>>> + *
>>>> + * This library is free software; you can redistribute it and/or
>>>> + * modify it under the terms of the GNU Lesser General Public
>>>> + * License as published by the Free Software Foundation; either
>>>> + * version 2.1 of the License, or (at your option) any later version.
>>>> + *
>>>> + * This library is distributed in the hope that it will be useful,
>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>>> + * Lesser General Public License for more details.
>>>> + *
>>>> + * You should have received a copy of the GNU Lesser General Public
>>>> + * License along with this library; if not, write to the Free Software
>>>> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>>>> + */
>>>> +
>>>> +#ifndef _URCU_UATOMIC_BUILTINS_GENERIC_H
>>>> +#define _URCU_UATOMIC_BUILTINS_GENERIC_H
>>>> +
>>>> +#include <urcu/system.h>
>>>> +
>>>> +#define uatomic_set(addr, v) __atomic_store_n(addr, v, __ATOMIC_RELAXED)
>>>> +
>>>> +#define uatomic_read(addr) __atomic_load_n(addr, __ATOMIC_RELAXED)
>>>
>>> Does this lose the volatile semantics that the old-style definitions
>>> had?
>>>
>>
>> Yes.
>>
>> [...]
>>
>>>> +++ b/include/urcu/uatomic/builtins-x86.h
>>>> @@ -0,0 +1,85 @@
>>>> +/*
>>>> + * urcu/uatomic/builtins-x86.h
>>>> + *
>>>> + * Copyright (c) 2023 Olivier Dion <odion@efficios.com>
>>>> + *
>>>> + * This library is free software; you can redistribute it and/or
>>>> + * modify it under the terms of the GNU Lesser General Public
>>>> + * License as published by the Free Software Foundation; either
>>>> + * version 2.1 of the License, or (at your option) any later version.
>>>> + *
>>>> + * This library is distributed in the hope that it will be useful,
>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>>> + * Lesser General Public License for more details.
>>>> + *
>>>> + * You should have received a copy of the GNU Lesser General Public
>>>> + * License along with this library; if not, write to the Free Software
>>>> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>>>> + */
>>>> +
>>>> +#ifndef _URCU_UATOMIC_BUILTINS_X86_H
>>>> +#define _URCU_UATOMIC_BUILTINS_X86_H
>>>> +
>>>> +#include <urcu/system.h>
>>>> +
>>>> +#define uatomic_set(addr, v) __atomic_store_n(addr, v, __ATOMIC_RELAXED)
>>>> +
>>>> +#define uatomic_read(addr) __atomic_load_n(addr, __ATOMIC_RELAXED)
>>>
>>> And same question here.
>>
>> Yes, this opens interesting questions:
>>
>> * what semantic do we want for uatomic_read/set ?
>>
>> * what semantic do we want for CMM_LOAD_SHARED/CMM_STORE_SHARED ?
>>
>> * do we want to allow load/store-shared to work on variables larger than a
>> word ? (e.g. on a uint64_t on a 32-bit architecture, or on a structure)
>>
>> * what are the guarantees of a volatile type ?
>>
>> * what are the guarantees of a load/store relaxed in C11 ?
>>
>> Does the delta between volatile and C11 relaxed guarantees matter ?
>>
>> Is there an advantage to use C11 load/store relaxed over volatile ? Should
>> we combine both C11 load/store _and_ volatile ? Should we use
>> atomic_signal_fence instead ?
> 
> I suggest C11 volatile atomic load/store.  Load/store fusing is permitted
> for non-volatile atomic loads and stores, and such fusing can ruin your
> code's entire day.  ;-)

I'm OK with erring towards a safer approach, but just out of curiosity, 
do you have examples of compilers doing load or store fusion on C11 or 
C++11 relaxed atomics, or is it out of caution due to lack of explicit 
guarantees in the standards ?

Does this lack of guarantee about fusion also apply to other MO such as 
acquire, release and seq.cst. ?

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
