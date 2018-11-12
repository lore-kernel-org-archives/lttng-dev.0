From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools 1/2] Fix: Connect timeout
 arithmetic in inet/inet6 (v2)
Date: Mon, 12 Nov 2018 14:28:11 -0500 (EST)
Message-ID: <185811237.3981.1542050891325.JavaMail.zimbra__48986.3851610155$1542051089$gmane$org@efficios.com>
References: <20181109224047.18750-1-mathieu.desnoyers@efficios.com>
 <20181109231311.GB27438@joraj-alpa>
 <2118485872.3540.1541859635725.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42v14y4SwYzrW8
 for <lttng-dev@lists.lttng.org>; Mon, 12 Nov 2018 14:28:18 -0500 (EST)
In-Reply-To: <2118485872.3540.1541859635725.JavaMail.zimbra@efficios.com>
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

----- On Nov 10, 2018, at 9:20 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Nov 9, 2018, at 6:13 PM, Jonathan Rajotte
> jonathan.rajotte-julien@efficios.com wrote:
> 
>> As discussed on IRC, could you make sure to test it manually at least once since
>> the problematic scenario is never tested by regression test.
>> Looks much better than my first attempt but we never know.
>> 
>> You can force delay locally using tc.
>> 
>> Something like:
>> 
>>    LTTNG_NETWORK_SOCKET_TIMEOUT=4000 lttng-sessiond -b -vvv
>>    lttng-relayd -b
>>    lttng create --live
>>    sudo tc qdisc add dev lo root netem delay 10000ms
>>    lttng enable-event -u -a
>>    #Should see errors of connection timeout taking around 4 secs, validate using
>>    #the logs.
>> 
>>    sudo tc qdisc del dev lo root netem delay 10000ms
>> 
>> You can also do the opposite for delays to validate working connect that take a
>> long time.
> 
> Let's test it on Monday. Meanwhile I'll send an updated version taking your
> comments into account.
> 

It seems to work fine with my patch applied.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
