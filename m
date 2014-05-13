From: Gerlando Falauto <gerlando.falauto@keymile.com>
Subject: Re: [PATCH] tracef: add extern "C" wrapper
Date: Tue, 13 May 2014 15:52:47 +0200
Message-ID: <537223AF.5060403__17880.8181816295$1399989235$gmane$org@keymile.com>
References: <1399973626-6405-1-git-send-email-gerlando.falauto@keymile.com>
 <453977100.15626.1399988508324.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-de.keymile.com ([195.8.104.250])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <prvs=0210a591ee=gerlando.falauto@keymile.com>)
 id 1WkD8Z-0004Jp-Us
 for lttng-dev@lists.lttng.org; Tue, 13 May 2014 09:53:03 -0400
In-Reply-To: <453977100.15626.1399988508324.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

On 05/13/2014 03:41 PM, Mathieu Desnoyers wrote:
> Sorry, I missed your patch and already committed a different
> fix. Please let me know if my fix has any issue.
>
> We usually encompass the entire header file (except #include)
> with extern C by the way.

Yes, I figured encompassing the #include would not be a good idea, 
that's why I changed it afterwards. But the first fix was working for me 
just as well.
The rest of the file is just a #define so it doesn't really make any 
difference.

It's all up to you I believe.

Thank you,
Gerlando

>
> Thanks,
>
> Mathieu
>
> ----- Original Message -----
>> From: "Gerlando Falauto" <gerlando.falauto@keymile.com>
>> To: lttng-dev@lists.lttng.org
>> Cc: "Gerlando Falauto" <gerlando.falauto@keymile.com>
>> Sent: Tuesday, May 13, 2014 5:33:46 AM
>> Subject: [lttng-dev] [PATCH] tracef: add extern "C" wrapper
>>
>> Add an extern "C" wrapper so that tracef.h can be included
>> (and the tracef() function can be used) from C++ files, too.
>>
>> Signed-off-by: Gerlando Falauto <gerlando.falauto@keymile.com>
>> ---
>>   include/lttng/tracef.h | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/include/lttng/tracef.h b/include/lttng/tracef.h
>> index 16a984b..45d0587 100644
>> --- a/include/lttng/tracef.h
>> +++ b/include/lttng/tracef.h
>> @@ -25,9 +25,17 @@
>>
>>   #include <lttng/lttng-ust-tracef.h>
>>
>> +#ifdef __cplusplus
>> +extern "C" {
>> +#endif
>> +
>>   extern
>>   void _lttng_ust_tracef(const char *fmt, ...);
>>
>> +#ifdef __cplusplus
>> +}
>> +#endif
>> +
>>   #define tracef(fmt, ...)						\
>>   	do {								\
>>   		STAP_PROBEV(tracepoint_lttng_ust_tracef, event, ## __VA_ARGS__); \
>> --
>> 1.8.0.1
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>
