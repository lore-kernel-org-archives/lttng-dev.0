From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace 2/2] Extend test-bitfield coverage
Date: Sun, 12 May 2019 10:55:52 -0400 (EDT)
Message-ID: <404890182.16.1557672952767.JavaMail.zimbra__26223.636853841$1557673270$gmane$org@efficios.com>
References: <20190510174750.13152-1-mathieu.desnoyers@efficios.com>
 <20190510174750.13152-2-mathieu.desnoyers@efficios.com>
 <30e2e22b-1cb1-e2fa-e2c0-4e437133f943@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 4526TC758zz1K3F
 for <lttng-dev@lists.lttng.org>; Sun, 12 May 2019 10:55:59 -0400 (EDT)
In-Reply-To: <30e2e22b-1cb1-e2fa-e2c0-4e437133f943@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Simon Marchi <simon.marchi@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>, Jonathan Rajotte-Julien <joraj@efficios.com>
List-Id: lttng-dev@lists.lttng.org

----- On May 10, 2019, at 5:11 PM, Simon Marchi simon.marchi@efficios.com wrote:

> On 2019-05-10 1:47 p.m., Mathieu Desnoyers wrote:
>> test-bitfield was mainly testing various write unit size. Add
>> variations of read unit size as well.
>> 
>> Previously, the test was only covering input from a 32-bit integer.
>> Additionally test source and destination of 64-bit.
>> 
>> Change-Id: Ic2b7849140e04fe7cca3de576e31bfef8f0a03ae
> 
> Missing Signed-off-by?

Oops, yes.

> 
> LGTM, I just have some minor comments:
> 
>> +#ifndef HAS_FLS_U64
>> +static __attribute__((unused))
>> +unsigned int fls_u64(uint64_t x)
>>  {
>> -	int r = 32;
>> +	unsigned int r = 64;
>> +
>> +	if (!x)
>> +		return 0;
>> +
>> +	if (!(x & 0xFFFFFFFF00000000ULL)) {
>> +		x <<= 32;
>> +		r -= 32;
>> +	}
>> +	if (!(x & 0xFFFF000000000000ULL)) {
>> +		x <<= 16;
>> +		r -= 16;
>> +	}
>> +	if (!(x & 0xFF00000000000000ULL)) {
>> +		x <<= 8;
>> +		r -= 8;
>> +	}
>> +	if (!(x & 0xF000000000000000ULL)) {
>> +		x <<= 4;
>> +		r -= 4;
>> +	}
>> +	if (!(x & 0xC000000000000000ULL)) {
>> +		x <<= 2;
>> +		r -= 2;
>> +	}
>> +	if (!(x & 0x8000000000000000ULL)) {
>> +		x <<= 1;
>> +		r -= 1;
>> +	}
>> +	return r;
>> +}
>> +#endif
>> +
>> +#ifndef HAS_FLS_U32
>> +static __attribute__((unused))
> 
> The unused attributes, in both functions, should be unnecessary here, I suppose?

Yes, will remove.


> 
>>  void run_test(void)
>>  {
>>  	int i;
>> -	plan_tests(NR_TESTS * 2 + 6);
>> +	plan_tests(NR_TESTS * 8 + 24);
>>  
>>  	srand(time(NULL));
>>  
>> -	srcrand = 0;
>> +	srcrand_ui = 0;
>> +	srcrand_ull = 0;
>>  	run_test_unsigned();
> 
> Not a big deal (and orthogonal to the problem being addressed), but I was
> wondering, why
> the test values are passed through global variables, and not by parameter, such
> as

Historic evolution starting with a quick and dirty prototype back in 2010. I'll
do a cleanup patch on top to move this to parameter passing, which will be a patch
3 of the next patchset round.

Thanks!

Mathieu

> 
>    run_test_unsigned(0, 0);
> 
> Simon

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
