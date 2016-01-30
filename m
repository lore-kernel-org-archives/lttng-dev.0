From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules 1/2] Fix: Ubuntu kernel range
 for mm_page_alloc_extfrag
Date: Sat, 30 Jan 2016 17:26:58 +0000 (UTC)
Message-ID: <1261684579.8899.1454174818344.JavaMail.zimbra__27284.9286826842$1454174882$gmane$org@efficios.com>
References: <1454107563-22129-1-git-send-email-mjeanson@efficios.com>
 <90203921.8680.1454107943296.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aPZIj-0004FN-JI
 for lttng-dev@lists.lttng.org; Sat, 30 Jan 2016 12:27:10 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 323F334049E
 for <lttng-dev@lists.lttng.org>; Sat, 30 Jan 2016 17:27:04 +0000 (UTC)
In-Reply-To: <90203921.8680.1454107943296.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On Jan 29, 2016, at 5:52 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> Both patches merged into master, thanks!

(and into stable-2.7)

Mathieu

> 
> Mathieu
> 
> ----- On Jan 29, 2016, at 5:46 PM, Michael Jeanson mjeanson@efficios.com wrote:
> 
>> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
>> ---
>> instrumentation/events/lttng-module/kmem.h | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/instrumentation/events/lttng-module/kmem.h
>> b/instrumentation/events/lttng-module/kmem.h
>> index 25e58cb..cce8da4 100644
>> --- a/instrumentation/events/lttng-module/kmem.h
>> +++ b/instrumentation/events/lttng-module/kmem.h
>> @@ -211,7 +211,7 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(kmem_mm_page,
>> mm_page_pcpu_drain,
>> 	|| LTTNG_KERNEL_RANGE(3,18,10, 3,19,0)		\
>> 	|| LTTNG_DEBIAN_KERNEL_RANGE(3,16,7,9,0,0, 3,17,0,0,0,0)	\
>> 	|| LTTNG_UBUNTU_KERNEL_RANGE(3,13,11,50, 3,14,0,0)	\
>> -	|| LTTNG_UBUNTU_KERNEL_RANGE(3,16,7,38, 3,17,0,0))
>> +	|| LTTNG_UBUNTU_KERNEL_RANGE(3,16,7,34, 3,17,0,0))
>> 
>> LTTNG_TRACEPOINT_EVENT_MAP(mm_page_alloc_extfrag,
>> 
>> --
>> 2.7.0
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
