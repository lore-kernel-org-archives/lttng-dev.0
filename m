From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: [PATCH lttng-ust] Add lttng_ust_notrace to static
 inline functions
Date: Tue, 8 Jul 2014 11:50:07 +0200
Message-ID: <53BBBECF.3020600__39214.6342470825$1404813070$gmane$org@mentor.com>
References: <1404741861-26337-1-git-send-email-paul_woegerer@mentor.com>
 <1716559010.9467.1404745056024.JavaMail.zimbra@efficios.com>
 <53BABDFB.6010900@mentor.com>
 <1796163414.9525.1404747980133.JavaMail.zimbra@efficios.com>
 <53BBB4A6.7030309@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Paul_Woegerer@mentor.com>) id 1X4S2T-0006F1-M0
 for lttng-dev@lists.lttng.org; Tue, 08 Jul 2014 05:50:21 -0400
In-Reply-To: <53BBB4A6.7030309@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 07/08/2014 11:06 AM, Woegerer, Paul wrote:
> If you don't mind using _Pragma (C99)
> (see: https://gcc.gnu.org/onlinedocs/cpp/Pragmas.html)
> we should be able to make this happen automatically (#ifdef
> TRACEPOINT_CREATE_PROBES _Pragma ... )

No need for _Pragma here. It's just:

diff --git a/include/lttng/tracepoint.h b/include/lttng/tracepoint.h
index c5a09d8..d89e718 100644
--- a/include/lttng/tracepoint.h
+++ b/include/lttng/tracepoint.h
@@ -23,6 +23,10 @@
  * SOFTWARE.
  */

+#ifdef TRACEPOINT_CREATE_PROBES
+#pragma GCC optimize ("no-instrument-functions")
+#endif
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <lttng/tracepoint-types.h>


--
Paul

> 
> 
> --
> Paul
> 
> 
> On 07/07/2014 05:46 PM, Mathieu Desnoyers wrote:
>> ----- Original Message -----
>>> From: "Paul Woegerer" <Paul_Woegerer@mentor.com>
>>> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
>>> Cc: lttng-dev@lists.lttng.org
>>> Sent: Monday, July 7, 2014 11:34:19 AM
>>> Subject: Re: [PATCH lttng-ust] Add lttng_ust_notrace to static inline functions
>>>
>>> On 07/07/2014 04:57 PM, Mathieu Desnoyers wrote:
>>>> Merged into master and stable-2.4, thanks!
>>>
>>> Thanks !
>>>
>>> Hmmm ... but what to do about static inline function cds_list_empty
>>> (included via lttng/ust-tracepoint-event.h -> urcu/rculist.h ->
>>> urcu/list.h). Would you accept a patch that introduces rcu_cds_notrace
>>> in urcu/compiler.h + respective changes in urcu/*.h ?
>>
>> It starts to look like a cat and mouse game honestly. Especially if
>> we consider "contexts", those can call external functions, which might
>> not have notrace attribute.
>>
>> I think the proper solution here would be to use a per-thread nesting
>> value, and check it in the finstrument-function callback, and return
>> immediately if we are nested.
>>
>> Thoughts ?
>>
>> Thanks,
>>
>> Mathieu
>>
>>>
>>> --
>>> Paul
>>>
>>>>
>>>> Mathieu
>>>>
>>>> ----- Original Message -----
>>>>> From: "Paul Woegerer" <paul_woegerer@mentor.com>
>>>>> To: lttng-dev@lists.lttng.org, "mathieu desnoyers"
>>>>> <mathieu.desnoyers@efficios.com>
>>>>> Cc: "Paul Woegerer" <paul_woegerer@mentor.com>
>>>>> Sent: Monday, July 7, 2014 10:04:21 AM
>>>>> Subject: [PATCH lttng-ust] Add lttng_ust_notrace to static inline
>>>>> functions
>>>>>
>>>>> The static inline functions
>>>>> __tracepoint_provider_mismatch_<TRACEPOINT_PROVIDER> and
>>>>> __tracepoint_provider_check_<TRACEPOINT_PROVIDER> are missing the
>>>>> lttng_ust_notrace attribute to prevent them from getting instrumented
>>>>> with -finstrument-functions (if e.g. defined in CFLAGS). This patch is
>>>>> adding the attribute to those functions.
>>>>>
>>>>> Signed-off-by: Paul Woegerer <paul_woegerer@mentor.com>
>>>>> ---
>>>>>  include/lttng/ust-tracepoint-event.h | 4 ++++
>>>>>  1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/include/lttng/ust-tracepoint-event.h
>>>>> b/include/lttng/ust-tracepoint-event.h
>>>>> index d12e8bb..8895310 100644
>>>>> --- a/include/lttng/ust-tracepoint-event.h
>>>>> +++ b/include/lttng/ust-tracepoint-event.h
>>>>> @@ -75,6 +75,8 @@
>>>>>  /* Reset all macros within TRACEPOINT_EVENT */
>>>>>  #include <lttng/ust-tracepoint-event-reset.h>
>>>>>  
>>>>> +static inline lttng_ust_notrace
>>>>> +void _TP_COMBINE_TOKENS(__tracepoint_provider_mismatch_,
>>>>> TRACEPOINT_PROVIDER)(void);
>>>>>  static inline
>>>>>  void _TP_COMBINE_TOKENS(__tracepoint_provider_mismatch_,
>>>>>  TRACEPOINT_PROVIDER)(void)
>>>>>  {
>>>>> @@ -88,6 +90,8 @@ void _TP_COMBINE_TOKENS(__tracepoint_provider_mismatch_,
>>>>> TRACEPOINT_PROVIDER)(vo
>>>>>  #define TRACEPOINT_EVENT_INSTANCE(_provider, _template, _name, _args)	\
>>>>>  	__tracepoint_provider_mismatch_##_provider();
>>>>>  
>>>>> +static inline lttng_ust_notrace
>>>>> +void _TP_COMBINE_TOKENS(__tracepoint_provider_check_,
>>>>> TRACEPOINT_PROVIDER)(void);
>>>>>  static inline
>>>>>  void _TP_COMBINE_TOKENS(__tracepoint_provider_check_,
>>>>>  TRACEPOINT_PROVIDER)(void)
>>>>>  {
>>>>> --
>>>>> 2.0.1
>>>>>
>>>>>
>>>>
>>>
>>>
>>> --
>>> Paul Woegerer, SW Development Engineer
>>> Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
>>> Mentor Graphics, Embedded Software Division
>>>
>>
> 
> 


-- 
Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division
