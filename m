From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: [PATCH lttng-tools] Fix: nsec diff can be negative
 leading to expeditive connection timeout
Date: Thu, 08 Nov 2018 17:26:39 -0500
Message-ID: <237752dff54ba084bc7dcb4b117a66e6__22340.7221994878$1541715887$gmane$org@polymtl.ca>
References: <20181108220805.10307-1-jonathan.rajotte-julien@efficios.com>
 <4ad12a9087c92cd4e2141f53bbd98493@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca (smtp.polymtl.ca [132.207.4.11])
 by lists.lttng.org (Postfix) with ESMTPS id 42rdDk0pVmzqkL
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 17:26:45 -0500 (EST)
Received: from simark.ca (simark.ca [158.69.221.121]) (authenticated bits=0)
 by smtp.polymtl.ca (8.14.7/8.14.7) with ESMTP id wA8MQemg001323
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Thu, 8 Nov 2018 17:26:45 -0500
In-Reply-To: <4ad12a9087c92cd4e2141f53bbd98493@polymtl.ca>
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
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

On 2018-11-08 17:17, Simon Marchi wrote:
> On 2018-11-08 17:08, Jonathan Rajotte wrote:
>> The nanoseconds part of the timespec struct time_a is not always
>> bigger than time_b since it wrap around each seconds.
>> 
>> Use the absolute value of the nanosecond difference to perform
>> unsigned long operation.
>> 
>> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
>> ---
>>  src/common/sessiond-comm/inet.c  | 2 +-
>>  src/common/sessiond-comm/inet6.c | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/src/common/sessiond-comm/inet.c 
>> b/src/common/sessiond-comm/inet.c
>> index e0b3e7a96..cb6f45357 100644
>> --- a/src/common/sessiond-comm/inet.c
>> +++ b/src/common/sessiond-comm/inet.c
>> @@ -124,7 +124,7 @@ unsigned long time_diff_ms(struct timespec 
>> *time_a,
>>  	unsigned long result_ms;
>> 
>>  	sec_diff = time_a->tv_sec - time_b->tv_sec;
>> -	nsec_diff = time_a->tv_nsec - time_b->tv_nsec;
>> +	nsec_diff = labs(time_a->tv_nsec - time_b->tv_nsec);
>> 
>>  	result_ms = sec_diff * MSEC_PER_SEC;
>>  	result_ms += nsec_diff / NSEC_PER_MSEC;
>> diff --git a/src/common/sessiond-comm/inet6.c 
>> b/src/common/sessiond-comm/inet6.c
>> index dfb5fc5d1..b73802d48 100644
>> --- a/src/common/sessiond-comm/inet6.c
>> +++ b/src/common/sessiond-comm/inet6.c
>> @@ -122,7 +122,7 @@ unsigned long time_diff_ms(struct timespec 
>> *time_a,
>>  	unsigned long result_ms;
>> 
>>  	sec_diff = time_a->tv_sec - time_b->tv_sec;
>> -	nsec_diff = time_a->tv_nsec - time_b->tv_nsec;
>> +	nsec_diff = labs(time_a->tv_nsec - time_b->tv_nsec);
>> 
>>  	result_ms = sec_diff * MSEC_PER_SEC;
>>  	result_ms += nsec_diff / NSEC_PER_MSEC;
> 
> That doesn't look right either.  With
> 
> time_a = 2.9 s
> time_b = 3.1 s
> 
> it will result in
> 
> sec_diff = 1 s
> nsec_diff = 0.8 s
> 
> Added, the result will be 1.8 seconds, when actually we expect 0.2 s.
> You probably have no choice but do the "borrowing" by hand, like we
> did when learning subtraction in elementary school :).  Maybe this
> deserves some unit tests, since it's apparently easy to get it wrong.

Actually, see here for an example:

https://www.gnu.org/software/libc/manual/html_node/Elapsed-Time.html

Simon
