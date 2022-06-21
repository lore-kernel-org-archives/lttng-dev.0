Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9469C433EF
	for <lttng-dev@archiver.kernel.org>; Tue, 21 Jun 2022 13:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1655817169;
	bh=/Eef2+Z3Y1Qa8czTh5gIN9rJWwnLLEAPk8TY2L7+x8s=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=xI0Hkg2ar4CLdLNTV9PHK3nXRwgbSO412HeQ6LGW/BRpPrPeHLQe3XmglvZwZzErg
	 Ygn3DG6YA635FyomS/ege/Iy7I7UIKsaxvQ5djz7a6F7d0KK31uxFVISmbU+rq/SLX
	 Ry8DqTXNuyS+aC6CUDZfUuG5XmpFvA//QxSyK1XaEAL7ME8XrpO+1RB5VTicCndu1c
	 BK72dglxYQf47yhQ+a+oTR5K2bDECeBYoMfSrn6GyeV5aZrqzqbKyDmo9pLENjyW5k
	 V2IdZmrBve4WJuOWpRf1NUTtxp0cJ3a/Fex76NHfDysA9oj9B5Esmqyomzc++NHuW7
	 /uQYYBh1yYMpQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LS6Pr5wW2zCF5;
	Tue, 21 Jun 2022 09:12:48 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4LS6Pp3fH0zCQh
 for <lttng-dev@lists.lttng.org>; Tue, 21 Jun 2022 09:12:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id E64CD3EAE27
 for <lttng-dev@lists.lttng.org>; Tue, 21 Jun 2022 09:12:38 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id iS_29MYFCHTv; Tue, 21 Jun 2022 09:12:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 7F4B23EADBC;
 Tue, 21 Jun 2022 09:12:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7F4B23EADBC
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id LYMJcAdYlYvf; Tue, 21 Jun 2022 09:12:38 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 72CB43EABC7;
 Tue, 21 Jun 2022 09:12:38 -0400 (EDT)
Date: Tue, 21 Jun 2022 09:12:38 -0400 (EDT)
To: Minlan Wang <wangminlan@szsandstone.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, paulmck <paulmck@kernel.org>
Message-ID: <1843612610.17820.1655817158376.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220621035206.GA267474@localhost.localdomain>+E7C500F72502E4B5>
References: <20220614035533.GA174967@localhost.localdomain>
 <765519142.60031.1655221996546.JavaMail.zimbra@efficios.com>
 <20220615034900.GA187807@localhost.localdomain>
 <396090936.61897.1655302558168.JavaMail.zimbra@efficios.com>
 <20220616080912.GA246781@localhost.localdomain>
 <1711122492.5944.1655473043420.JavaMail.zimbra@efficios.com>
 <20220621035206.GA267474@localhost.localdomain>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - FF100
 (Linux)/8.8.15_GA_4304)
Thread-Topic: ***UNCHECKED*** Re: urcu workqueue thread uses 99% of cpu while
 workqueue is empty
Thread-Index: Ywif8/eKcmyJDqempu6pPR+SGYuO7w==
Subject: Re: [lttng-dev] ***UNCHECKED*** Re: urcu workqueue thread uses 99%
	of cpu while	workqueue is empty
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

----- On Jun 20, 2022, at 11:52 PM, Minlan Wang wangminlan@szsandstone.com wrote:

> Hi, Mathieu,
> On Fri, Jun 17, 2022 at 09:37:23AM -0400, Mathieu Desnoyers wrote:
>> Can you try the following patch on top of v0.12.1 + your debug patch ?
>> 
>> diff --git a/src/workqueue.c b/src/workqueue.c
>> index eed1e21e..19fc89c8 100644
>> --- a/src/workqueue.c
>> +++ b/src/workqueue.c
>> @@ -142,6 +142,7 @@ static void futex_wait(int32_t *futex)
>>  
>>  		return;
>>  	}
>> +wait:
>>  	while ((ret = futex_async(futex, FUTEX_WAIT, -1, NULL, NULL, 0))) {
>>  		err = errno;
>>  		fprintf(stderr, "%lu: wq %p: %s failed, errno %d\n",
>> @@ -161,7 +162,16 @@ static void futex_wait(int32_t *futex)
>>  
>>  	fprintf(stderr, "%lu: wq %p: %s wait return %d\n",
>>  		pthread_self(), caa_container_of(futex, struct urcu_workqueue, futex), __func__,
>>  		ret);
>> -
>> +	/*
>> +	 * Prior queued wakeups can cause futex wait to return even
>> +	 * though the futex value is still -1. If this happens, wait
>> +	 * again.
>> +	 */
>> +	if (uatomic_read(futex) == -1) {
>> +		fprintf(stderr, "%lu: wq %p: %s futex == -1, wait again\n",
>> +			pthread_self(), caa_container_of(futex, struct urcu_workqueue, futex),
>> __func__);
>> +		goto wait;
>> +	}
>>  }
>>  
>>  static void futex_wake_up(int32_t *futex)
>> 
> I tried this patch on top of my debug patch, the issue disappeared.
> The log shows that "futex_wait futex == -1, wait again" did happen several
> times.
> I put the complete log in the attachment.

This means we appear to be on the right track. Good!

> 
>> 
>> We should not rely too much on the ordering of fprintf stderr output between
>> threads,
>> because those can be interleaved in any order (each fprintf to stderr is
>> unbuffered).
>> If we want more precision in the order of events I would recommend using
>> LTTng-UST for
>> fine-grained user-space tracing. This might explain why the futex has an
>> unexpected value
>> at line 2099.
> I tried this patch on top of previous 2 patches to use lttng_ust_tracepoint in
> workqueue.c, but always failed in compile example code with this error:
> ---
> make[5]: Entering directory
> `/home/mlwang/debug/userspace-rcu/doc/examples/rculfqueue'
>  CC       cds_lfq_enqueue.o
>  CCLD     cds_lfq_enqueue
> ../../../src/.libs//liburcu-cds.so: undefined reference to
> `lttng_ust_tracepoint_provider_workqueue'
> ---
> the patch is as following:
[...]
> --- a/src/workqueue.h
> +++ b/src/workqueue.h
> @@ -28,6 +28,7 @@
> #include <pthread.h>
> 
> #include <urcu/wfcqueue.h>
> +#include "workqueue_tp.h"
> 
> #ifdef __cplusplus
> extern "C" {
> diff --git a/src/workqueue_tp.c b/src/workqueue_tp.c
> new file mode 100644
> index 0000000..a5f9586
> --- /dev/null
> +++ b/src/workqueue_tp.c
> @@ -0,0 +1,4 @@
> +#define LTTNG_UST_TRACEPOINT_CREATE_PROBES
> +#define LTTNG_UST_TRACEPOINT_DEFINE
> +
> +#include "workqueue_tp.h"
> diff --git a/src/workqueue_tp.h b/src/workqueue_tp.h
> new file mode 100644
> index 0000000..e2bce31
> --- /dev/null
> +++ b/src/workqueue_tp.h
> @@ -0,0 +1,82 @@
> +#undef	LTTNG_UST_TRACEPOINT_PROVIDER
> +#define	LTTNG_UST_TRACEPOINT_PROVIVER workqueue

If you change "PROVIVER" into "PROVIDER" here, does it fix your issue ?

If that's not it, it should be something relatively simple with the build dependencies. Let me know
if it still does not work.

[...]

> --
> 1.8.3.1
> 
> Is "perf probe" accurate in tracing the futex event here?  Maybe i can try that.

I would prefer to use lttng-ust here to keep the footprint of the tracer minimal, so we do not
change the behavior too much by calling into the kernel.

Then we'll be able to correlate traces from lttng-ust and lttng-modules (kernel tracer) and
figure out what is happening both in user-space and kernel space, especially around futex and
scheduler activity within the kernel.

Thanks,

Mathieu

> 
> B.R
> Minlan

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
