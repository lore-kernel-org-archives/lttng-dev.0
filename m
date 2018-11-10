From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools 1/2] Fix: Connect timeout
 arithmetic in inet/inet6 (v2)
Date: Sat, 10 Nov 2018 09:20:35 -0500 (EST)
Message-ID: <2118485872.3540.1541859635725.JavaMail.zimbra__23260.6958634735$1541859558$gmane$org@efficios.com>
References: <20181109224047.18750-1-mathieu.desnoyers@efficios.com>
 <20181109231311.GB27438@joraj-alpa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42sfLr2qqjzrP4
 for <lttng-dev@lists.lttng.org>; Sat, 10 Nov 2018 09:20:36 -0500 (EST)
In-Reply-To: <20181109231311.GB27438@joraj-alpa>
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

----- On Nov 9, 2018, at 6:13 PM, Jonathan Rajotte jonathan.rajotte-julien@efficios.com wrote:

> As discussed on IRC, could you make sure to test it manually at least once since
> the problematic scenario is never tested by regression test.
> Looks much better than my first attempt but we never know.
> 
> You can force delay locally using tc.
> 
> Something like:
> 
>    LTTNG_NETWORK_SOCKET_TIMEOUT=4000 lttng-sessiond -b -vvv
>    lttng-relayd -b
>    lttng create --live
>    sudo tc qdisc add dev lo root netem delay 10000ms
>    lttng enable-event -u -a
>    #Should see errors of connection timeout taking around 4 secs, validate using
>    #the logs.
> 
>    sudo tc qdisc del dev lo root netem delay 10000ms
> 
> You can also do the opposite for delays to validate working connect that take a
> long time.

Let's test it on Monday. Meanwhile I'll send an updated version taking your
comments into account.

> 
> As Simon pointed out, unit tests would be even better for these new functions.
> Something like test_utils_expand_path.c perhaps? A regression test would be nice
> but I'm not sure how we would do it based on the current test framework.
> 
> Other comments inline for stuff I did not see the first time.
> 
> On Fri, Nov 09, 2018 at 05:40:46PM -0500, Mathieu Desnoyers wrote:
>> The nanoseconds part of the timespec struct time_a is not always
>> bigger than time_b since it wrap around each seconds.
>> 
>> Use 64-bit arithmetic to perform the difference.
>> 
>> Merge/move duplicated code into utils.c.
>> 
>> This function is really doing two things. Split it into timespec_to_ms()
>> and timespec_abs_diff().
>> 
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> ---
>> Changes since v1:
>> - Use NSEC_PER_SEC constant.
>> ---
>>  src/common/common.h              |  5 +++++
>>  src/common/sessiond-comm/inet.c  | 28 ++++++++--------------------
>>  src/common/sessiond-comm/inet6.c | 28 ++++++++--------------------
>>  src/common/utils.c               | 31 +++++++++++++++++++++++++++++++
>>  4 files changed, 52 insertions(+), 40 deletions(-)
>> 
>> diff --git a/src/common/common.h b/src/common/common.h
>> index 41eb0361..48f39e0e 100644
>> --- a/src/common/common.h
>> +++ b/src/common/common.h
>> @@ -19,9 +19,14 @@
>>  #ifndef _COMMON_H
>>  #define _COMMON_H
>>  
>> +#include <time.h>
>> +
>>  #include "error.h"
>>  #include "macros.h"
>>  #include "runas.h"
>>  #include "readwrite.h"
>>  
> 
> Given the current format of common.h, wouldn't it be better to have a
> timespec_ops.h file with these declaration in it? I guess it can be done in a
> later commit to minimize backporting since it is not necessary for the fix.

We already have a src/common/time.h. I'll move it there. Good point!

> 
> Please add a comment explaining behaviour on error and what it represent.

Done.

Next time, to facilitate reading through your comments, please delete diff hunks
that are not relevant to the comments when you reply. This helps everyone reading
through the comments without having to scroll down many pages of code. Otherwise
it's just too easy to miss a small one-liner comment in a forest of diff.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
