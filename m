Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8623EB64D8
	for <lttng-dev@archiver.kernel.org>; Thu, 22 Jun 2023 15:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1687449346;
	bh=HjlCiN7l15pa1mFRRiLOmh1mlMOqqSrMho+QnIDktCw=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=j6FH4dj5VyAEbl4m9hmrPKwkqtaihCuZIwcuL/+hCS16gdlnkeYRX3q3Q9fRbhaRW
	 bqWg7yKDI5bA5h3hsbxfz9OqNfgAJ93jmln6oShAygfcZkduGuMQnj7NbSSpIuPuuq
	 VesYuG7cvK2fZFCB51JZJqVDsF2RoIjYjdWH2ItyP40hRDoa9nVjDkmsAeThQY0Sus
	 0fXq6Ra+LbrRaX8mrA+cbD6+1BnMCkh0TY2OdQRXW06VfoHM0RfVZM8GKOe0fA4Dl7
	 nfJuFexOlN7tR9D8LivZEXKz0s9oHqEPhl51dn4Q2nFhnkLn+zyC8yyaJGCes3WS1y
	 lDyS0OweZzBfw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Qn4hy234Pz20VD;
	Thu, 22 Jun 2023 11:55:46 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4Qn4hw6MYXz20VB
 for <lttng-dev@lists.lttng.org>; Thu, 22 Jun 2023 11:55:44 -0400 (EDT)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4Qn4hh0tSfz191S;
 Thu, 22 Jun 2023 11:55:32 -0400 (EDT)
Message-ID: <ffec193e-7060-3fe2-6526-c54e89e992e6@efficios.com>
Date: Thu, 22 Jun 2023 11:55:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: paulmck@kernel.org, Olivier Dion <odion@efficios.com>
Cc: lttng-dev@lists.lttng.org
References: <20230515201718.9809-1-odion@efficios.com>
 <20230515201718.9809-3-odion@efficios.com>
 <c7834f41-c033-4c53-96e8-0ad728c2a285@paulmck-laptop>
In-Reply-To: <c7834f41-c033-4c53-96e8-0ad728c2a285@paulmck-laptop>
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

On 6/21/23 19:19, Paul E. McKenney wrote:
[...]
>> diff --git a/include/urcu/uatomic/builtins-generic.h b/include/urcu/uatomic/builtins-generic.h
>> new file mode 100644
>> index 0000000..8e6a9b5
>> --- /dev/null
>> +++ b/include/urcu/uatomic/builtins-generic.h
>> @@ -0,0 +1,85 @@
>> +/*
>> + * urcu/uatomic/builtins-generic.h
>> + *
>> + * Copyright (c) 2023 Olivier Dion <odion@efficios.com>
>> + *
>> + * This library is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU Lesser General Public
>> + * License as published by the Free Software Foundation; either
>> + * version 2.1 of the License, or (at your option) any later version.
>> + *
>> + * This library is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * Lesser General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU Lesser General Public
>> + * License along with this library; if not, write to the Free Software
>> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>> + */
>> +
>> +#ifndef _URCU_UATOMIC_BUILTINS_GENERIC_H
>> +#define _URCU_UATOMIC_BUILTINS_GENERIC_H
>> +
>> +#include <urcu/system.h>
>> +
>> +#define uatomic_set(addr, v) __atomic_store_n(addr, v, __ATOMIC_RELAXED)
>> +
>> +#define uatomic_read(addr) __atomic_load_n(addr, __ATOMIC_RELAXED)
> 
> Does this lose the volatile semantics that the old-style definitions
> had?
> 

Yes.

[...]

>> +++ b/include/urcu/uatomic/builtins-x86.h
>> @@ -0,0 +1,85 @@
>> +/*
>> + * urcu/uatomic/builtins-x86.h
>> + *
>> + * Copyright (c) 2023 Olivier Dion <odion@efficios.com>
>> + *
>> + * This library is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU Lesser General Public
>> + * License as published by the Free Software Foundation; either
>> + * version 2.1 of the License, or (at your option) any later version.
>> + *
>> + * This library is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * Lesser General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU Lesser General Public
>> + * License along with this library; if not, write to the Free Software
>> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>> + */
>> +
>> +#ifndef _URCU_UATOMIC_BUILTINS_X86_H
>> +#define _URCU_UATOMIC_BUILTINS_X86_H
>> +
>> +#include <urcu/system.h>
>> +
>> +#define uatomic_set(addr, v) __atomic_store_n(addr, v, __ATOMIC_RELAXED)
>> +
>> +#define uatomic_read(addr) __atomic_load_n(addr, __ATOMIC_RELAXED)
> 
> And same question here.

Yes, this opens interesting questions:

* what semantic do we want for uatomic_read/set ?

* what semantic do we want for CMM_LOAD_SHARED/CMM_STORE_SHARED ?

* do we want to allow load/store-shared to work on variables larger than 
a word ? (e.g. on a uint64_t on a 32-bit architecture, or on a structure)

* what are the guarantees of a volatile type ?

* what are the guarantees of a load/store relaxed in C11 ?

Does the delta between volatile and C11 relaxed guarantees matter ?

Is there an advantage to use C11 load/store relaxed over volatile ? 
Should we combine both C11 load/store _and_ volatile ? Should we use 
atomic_signal_fence instead ?

Thanks,

Mathieu

> 
> 							Thanx, Paul
> 
>> +

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
