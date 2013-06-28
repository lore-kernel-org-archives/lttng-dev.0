From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: [LTTng-modules PATCH] The msg part of the
 printk:console event was 1 character too long
Date: Fri, 28 Jun 2013 15:53:41 -0400
Message-ID: <51CDE9C5.7060406__19237.6638217413$1372449267$gmane$org@gmail.com>
References: <1372447954-4360-1-git-send-email-yannick.brosseau@gmail.com>
	<20130628194304.GB24942@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1Usejt-0007lo-LM
	for lttng-dev@lists.lttng.org; Fri, 28 Jun 2013 15:53:49 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so4864363ief.40
	for <lttng-dev@lists.lttng.org>; Fri, 28 Jun 2013 12:53:44 -0700 (PDT)
In-Reply-To: <20130628194304.GB24942@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 2013-06-28 15:43, Mathieu Desnoyers wrote:
> * Yannick Brosseau (yannick.brosseau@gmail.com) wrote:
>> Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
>> ---
>>  instrumentation/events/lttng-module/printk.h |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/instrumentation/events/lttng-module/printk.h b/instrumentation/events/lttng-module/printk.h
>> index 4c744f9..f4b6028 100644
>> --- a/instrumentation/events/lttng-module/printk.h
>> +++ b/instrumentation/events/lttng-module/printk.h
>> @@ -19,7 +19,7 @@ TRACE_EVENT_CONDITION(console,
>>  
>>  	TP_STRUCT__entry(
>>  		__dynamic_array_text(char, msg,
>> -			min_t(unsigned, end - start, MSG_TRACE_MAX_LEN) + 1)
> this was taken from the Linux kernel mainline instrumentation, no ?
>
> Has this been fixed upstream ? If so, can you cite the commit in the
> changelog ?
>
>
It's not changed upstream. From what I see, ftrace does the right thing,
but not LTTng. Will check perf and see if I can reproduce the problem
directly with the upstream kernel.
