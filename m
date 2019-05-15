From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools 2/9] Fix: tests: error handling
 in high throughput limits test
Date: Wed, 15 May 2019 18:36:29 -0400 (EDT)
Message-ID: <934576049.1892.1557959789884.JavaMail.zimbra__40413.3950521768$1557959809$gmane$org@efficios.com>
References: <20190503135547.12968-1-mathieu.desnoyers@efficios.com>
 <20190503135547.12968-3-mathieu.desnoyers@efficios.com>
 <20190515163127.GD14986@joraj-alpa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 4548YC5n6RzyxM
 for <lttng-dev@lists.lttng.org>; Wed, 15 May 2019 18:36:31 -0400 (EDT)
In-Reply-To: <20190515163127.GD14986@joraj-alpa>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>, Jonathan Rajotte-Julien <joraj@efficios.com>
List-Id: lttng-dev@lists.lttng.org

----- On May 15, 2019, at 12:31 PM, Jonathan Rajotte jonathan.rajotte-julien@efficios.com wrote:

>> @@ -168,8 +187,7 @@ skip $isroot "Root access is needed to set bandwith limits.
>> Skipping all tests."
>>  {
>>  
>>  	# Catch sigint and try to cleanup limits
>> -	trap interrupt_cleanup SIGTERM
>> -	trap interrupt_cleanup SIGINT
>> +	trap interrupt_cleanup SIGTERM SIGINT
>>  
>>  	BW_LIMITS=(3200 1600 800 400 200 100 50 25)
>>  	for BW in ${BW_LIMITS[@]};
>> @@ -177,6 +195,7 @@ skip $isroot "Root access is needed to set bandwith limits.
>> Skipping all tests."
>>  		diag "Test high-throughput with bandwidth limit set to ${BW}kbits"
>>  
>>  		set_bw_limit $BW
>> +		ok $? "Setting bandwidth limit"
> 
> In case of failure here we should force a reset since it could lead to long
> timeout/hang depending on which tc command failed?
> 
> This could also be done inside set_bw_limit at each stage.

I'll do this. Will be in v2 of this patch.

Thanks,

Mathieu

> 
>>  
>>  		start_lttng_sessiond
>>  		start_lttng_relayd "-o $TRACE_PATH"
>> @@ -185,5 +204,6 @@ skip $isroot "Root access is needed to set bandwith limits.
>> Skipping all tests."
>>  		stop_lttng_relayd
>>  		stop_lttng_sessiond
>>  		reset_bw_limit
>> +		ok $? "Reset bandwith limits"
>>  	done
>>  }
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
