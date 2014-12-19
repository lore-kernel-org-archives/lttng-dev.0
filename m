From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Re: [tracecompass-dev] Unreadable traces
Date: Fri, 19 Dec 2014 11:23:11 -0500
Message-ID: <549450EF.4070605__22849.8795455836$1419006260$gmane$org@ericsson.com>
References: <549435F9.3070804@keymile.com> <54944E26.4020102@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg20.ericsson.net ([198.24.6.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <matthew.khouzam@ericsson.com>) id 1Y20Ko-0001S5-Q0
 for lttng-dev@lists.lttng.org; Fri, 19 Dec 2014 11:23:27 -0500
In-Reply-To: <54944E26.4020102@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: tracecompass-dev@eclipse.org, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Upon further inspection/reflexion, your clock was set at 0, but you are
probably in gmt-5, so you are in 1969 according to the trace, the trace
stores the offset as an unsigned long, so it relies on a rollover. I
would suggest that this is an undocumented feature in lttng. To be more
"correct" it would be nice if the clock offset were a signed long
instead of an unsigned one, this way we can handle the rather common
case of people in the east or west coast (or anywhere west of gmt-0)
working on embedded systems where their clocks are set to 0.

Any thoughts?

Matthew


On 14-12-19 11:11 AM, Matthew Khouzam wrote:
> Hi, this is  a very interesting trace!
>
> The clock offset is 18446744073709551571 ns, or 300 years in the future...
> babeltrace parses the date as follows [1969-12-31 19:13:09.028388290]
> (babeltrace --clock-date)
> tracecompass fails.
>
> How did you take this trace?
> I am kinda more comfortable keeping the trace failing for now, but if
> you have a use case where the clock can be offset by such a large
> number, please share the use case, I have a couple of ideas on how to
> extend it. :)
>
> BR
> Matthew
>
> PS. We love these test cases, keep em coming!
>
> On 14-12-19 09:28 AM, Gerlando Falauto wrote:
>> Hi,
>>
>> it's me again ;-)
>>
>> I'm playing around with Tracecompass and everything seems to be
>> working fine on a test platform.
>>
>> However, when tracing on the card we actually need to investigate, I
>> get unreadable traces. What happens is that I don't get the typical
>> mole icon under Tracing / Traces / Kernel after importing. Nor can I
>> double click on the icon and get the diagram.
>>
>> Attached are two trace instances where it's working and where it's
>> broken, respectively. Traces were obtained by running
>>
>> lttng create
>> lttng enable-event sched_switch,sched_wakeup -k
>> lttng start; lttng stop
>>
>> I tried to track it down and the culprit seems to be related to this
>> kernel setting:
>>
>> +CONFIG_RT_GROUP_SCHED=y
>>
>> Any ideas what could be wrong?
>>
>> Notice how babeltrace seems to work in both cases.
>>
>> Thank you!
>> Gerlando
>>
>>
>> _______________________________________________
>> tracecompass-dev mailing list
>> tracecompass-dev@eclipse.org
>> To change your delivery options, retrieve your password, or unsubscribe from this list, visit
>> https://dev.eclipse.org/mailman/listinfo/tracecompass-dev
> _______________________________________________
> tracecompass-dev mailing list
> tracecompass-dev@eclipse.org
> To change your delivery options, retrieve your password, or unsubscribe from this list, visit
> https://dev.eclipse.org/mailman/listinfo/tracecompass-dev
