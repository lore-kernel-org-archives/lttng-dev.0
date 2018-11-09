From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools 1/2] Fix: Connect timeout
 arithmetic in inet/inet6
Date: Fri, 9 Nov 2018 17:41:17 -0500 (EST)
Message-ID: <173329488.3421.1541803277072.JavaMail.zimbra__24675.1934210353$1541803575$gmane$org@efficios.com>
References: <20181109222749.27267-1-mathieu.desnoyers@efficios.com>
 <20181109223407.GA27438@joraj-alpa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 42sFW20bfczqYp
 for <lttng-dev@lists.lttng.org>; Fri,  9 Nov 2018 17:41:17 -0500 (EST)
In-Reply-To: <20181109223407.GA27438@joraj-alpa>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org



----- On Nov 9, 2018, at 5:34 PM, Jonathan Rajotte jonathan.rajotte-julien@efficios.com wrote:
[...]
>> +
>> +LTTNG_HIDDEN
>> +struct timespec timespec_abs_diff(struct timespec t1, struct timespec t2)
>> +{
>> +	uint64_t ts1 = (uint64_t) t1.tv_sec * INT64_C(1000000000) + (uint64_t)
>> t1.tv_nsec;
>> +	uint64_t ts2 = (uint64_t) t2.tv_sec * INT64_C(1000000000) + (uint64_t)
>> t2.tv_nsec;
> 
> Use NSEC_PER_SEC here.
> 
>> +	uint64_t diff = max(ts1, ts2) - min(ts1, ts2);
>> +	struct timespec res;
>> +
>> +	res.tv_sec = diff / INT64_C(1000000000);
> 
> Use NSEC_PER_SEC here.
> 
>> +	res.tv_nsec = diff % INT64_C(1000000000);
> 
> Use NSEC_PER_SEC here.

Fixing in v2, thanks,

Mathieu

> 
>> +	return res;
>> +}
>> --
>> 2.11.0
>> 
> 
> --
> Jonathan Rajotte-Julien
> EfficiOS

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
