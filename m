From: Lai Jiangshan <eag0628@gmail.com>
Subject: Re: [PATCH 2/2] urcu: add notice to URCU_TLS() for it
	is not async-signal-safe
Date: Fri, 10 Aug 2012 00:16:05 +0800
Message-ID: <CACvQF53CY6UuoZzDzT-VE25wAyaNa_r=0vsOdTVzVF6dmScH1g__14025.0276461758$1344532727$gmane$org@mail.gmail.com>
References: <1344414673-14714-1-git-send-email-laijs@cn.fujitsu.com>
	<1344414673-14714-2-git-send-email-laijs@cn.fujitsu.com>
	<20120809141417.GC9064@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <eag0628@gmail.com>) id 1SzVP9-0003iX-FO
	for lttng-dev@lists.lttng.org; Thu, 09 Aug 2012 12:16:11 -0400
Received: by qcsc21 with SMTP id c21so467758qcs.35
	for <lttng-dev@lists.lttng.org>; Thu, 09 Aug 2012 09:16:05 -0700 (PDT)
In-Reply-To: <20120809141417.GC9064@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

OK for me. Please do it.

On Thu, Aug 9, 2012 at 10:14 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> * Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
>> Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
>> ---
>>  urcu/tls-compat.h |   14 ++++++++++++++
>>  1 files changed, 14 insertions(+), 0 deletions(-)
>>
>> diff --git a/urcu/tls-compat.h b/urcu/tls-compat.h
>> index 192a536..b7bf363 100644
>> --- a/urcu/tls-compat.h
>> +++ b/urcu/tls-compat.h
>> @@ -59,6 +59,20 @@ extern "C" {
>>
>>  #else /* #ifndef CONFIG_RCU_TLS */
>>
>> +/*
>> + * NOTE: URCU_TLS() is NOT async-signal-safe, you can't use it
>> + * inside any function which can be called from signal handler.
>> + *
>> + * But if pthread_getspecific() is async-signal-safe in your
>> + * platform, you can make URCU_TLS() async-signal-safe via:
>> + * ensuring the first call to URCU_TLS() of a given TLS variable of
>> + * all threads is called earliest from a non-signal handler function.
>> + *
>> + * Exmaple: In any thread, the first call of URCU_TLS(rcu_reader)
>> + * is called from rcu_register_thread(), so we can ensure all later
>> + * URCU_TLS(rcu_reader) in any thread is async-signal-safe.
>
> Hrm. We could also just block all signals within type *__tls_access_ ##
> name(void)  (in tls-compat.h) and make sure it is async-signal-safe I
> guess ? I would prefer that solution: it would make the code more robust
> for a rarely taken performance hit.
>
> Thoughts ?
>
> Thanks,
>
> Mathieu
>
>> + */
>> +
>>  # include <pthread.h>
>>
>>  struct urcu_tls {
>> --
>> 1.7.4.4
>>
>
> --
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
