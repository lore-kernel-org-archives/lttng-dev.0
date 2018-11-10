From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools 1/2] Fix: Connect timeout
 arithmetic in inet/inet6 (v2)
Date: Sat, 10 Nov 2018 09:13:44 -0500 (EST)
Message-ID: <1899289006.3531.1541859224958.JavaMail.zimbra__20030.7126426653$1541859110$gmane$org@efficios.com>
References: <20181109224047.18750-1-mathieu.desnoyers@efficios.com>
 <20181109234306.GC27438@joraj-alpa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42sfBy5NDmzrMs
 for <lttng-dev@lists.lttng.org>; Sat, 10 Nov 2018 09:13:46 -0500 (EST)
In-Reply-To: <20181109234306.GC27438@joraj-alpa>
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

----- On Nov 9, 2018, at 6:43 PM, Jonathan Rajotte jonathan.rajotte-julien@efficios.com wrote:

>> diff --git a/src/common/utils.c b/src/common/utils.c
>> index 3442bef8..5b4e1d3c 100644
>> --- a/src/common/utils.c
>> +++ b/src/common/utils.c

[...]

>> +LTTNG_HIDDEN
>> +int timespec_to_ms(struct timespec ts, unsigned long *ms)
>> +{
>> +	unsigned long res;
>> +
>> +	if (ts.tv_sec + 1 > ULONG_MAX / MSEC_PER_SEC) {
>> +		return -1;
>> +	}
> 
> This is not accurate. It return -1 for the all the following valid timespec:
> 
>   tv_sec = 4294967
>   0 < tv_nsec < 295000000
> 
> You will need to check multiplication and addition separately.

Good point! Changing the check for:

        if (ts.tv_sec + ts.tv_nsec / NSEC_PER_SEC > ULONG_MAX / MSEC_PER_SEC) {
                return -1;
        }

Indeed it appears to be valid to have tv_nsec greater than (1000000000-1)

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
