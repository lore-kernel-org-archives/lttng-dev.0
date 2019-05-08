From: Simon Marchi <simon.marchi@efficios.com>
Subject: Re: [PATCH babeltrace v2] Fix: bitfield: left shift
 undefined behavior
Date: Wed, 8 May 2019 12:08:27 -0400
Message-ID: <23cd90d8-daaf-9951-c183-9315e6d7db96__19155.3322061495$1557331734$gmane$org@efficios.com>
References: <20190508143901.1393-1-mathieu.desnoyers@efficios.com>
 <9020b4de-9c66-680f-f28f-6681ebae44c6@simark.ca>
 <634308112.1933.1557331191087.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44zhGv1D6xz1Jt1
 for <lttng-dev@lists.lttng.org>; Wed,  8 May 2019 12:08:38 -0400 (EDT)
In-Reply-To: <634308112.1933.1557331191087.JavaMail.zimbra@efficios.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Simon Marchi <simark@simark.ca>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>, Jonathan Rajotte-Julien <joraj@efficios.com>
List-Id: lttng-dev@lists.lttng.org

On 2019-05-08 11:59 a.m., Mathieu Desnoyers wrote:
> What compiler do you use, and which compilation flags ?
> (it works here)

"gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0", which is the system compiler on Ubuntu 18.04.

I just built with

  ./configure 'CFLAGS=-g3 -O0 -fsanitize=address -Wall'

and got some failures, the first one being

not ok 8 - Writing and reading back 0xC07EBC7, signed
#     Failed test (test_bitfield.c:run_test_signed() at line 224)
# Failed reading value written "signed char"-wise, with start=0 and length=29. Read FFFFFFFFFFFFFFC7
# 0xFFFFFFC7 0xFFFFFFEB 0x7 0xC 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0

The test passes without the patch.  If you can't reproduce it easily, I can dig
on my side.

>>>  
>>>  /*
>>>   * bt_bitfield_write - write integer to a bitfield in native endianness
>>> @@ -108,15 +113,15 @@ do {									\
>>>  									\
>>>  	/* Trim v high bits */						\
>>>  	if (__length < sizeof(__v) * CHAR_BIT)				\
>>> -		__v &= ~((~(typeof(__v)) 0) << __length);		\
>>> +		__v &= (typeof(__v)) ~(_bt_fill_mask(typeof(__v)) << __length); \
>>
>> Not a blocker, but this operation is done enough times that it might be worth
>> giving it a name and make a macro for it.  It could help make this big macro
>> more readable, and we could test it on its own if needed.
>>
>> /* Generate a mask of type `type` with the `length` least significant bits set.
>> */
>>
>> #define _bt_make_mask(type, length) \
>> 	((type) ~(_bt_fill_mask(type) << length))
> 
> Good point! Will do. Missing () around "length" though.

Right, and I should have mentioned I didn't actually test that macro, so handle with care!

Simon
