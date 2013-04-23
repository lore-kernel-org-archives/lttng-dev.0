From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Re: [RFC PATCH 0/2] babeltrace legacy LTT 2.6 converter
Date: Tue, 23 Apr 2013 17:11:33 -0400
Message-ID: <5176F905.4040109__28115.3043070391$1366751577$gmane$org@ericsson.com>
References: <cover.1366364119.git.jan.glauber@gmail.com>
	<51715CCB.90009@ericsson.com> <20130422125536.GA8755@hal>
	<51755C85.3070803@ericsson.com> <51755D8F.7070304@gmail.com>
	<20130423121401.GA14913@hal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg20.ericsson.net ([198.24.6.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1UUkVs-0005gk-V5
	for lttng-dev@lists.lttng.org; Tue, 23 Apr 2013 17:12:33 -0400
In-Reply-To: <20130423121401.GA14913@hal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jan Glauber <jan.glauber@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

No problems here. I was inquiring about this so that nobody is surprised
if all trace viewers features are not supported.
On 13-04-23 08:14 AM, Jan Glauber wrote:
> On Mon, Apr 22, 2013 at 11:55:59AM -0400, Yannick Brosseau wrote:
>> On 2013-04-22 11:51, Matthew Khouzam wrote:
>>> On 13-04-22 08:55 AM, Jan Glauber wrote:
>>>> On Fri, Apr 19, 2013 at 11:03:39AM -0400, Matthew Khouzam wrote:
>>>>> Hi Jan,
>>>>>
>>>>> I have a few questions about the patch:
>>>>> Does it handle lost events?
>>>>> I think we would need to bring in a state system for this
>>>> Hi Matthew,
>>>>
>>>> Not sure what you mean there. I thought lost events are not recorded so there is
>>>> nothing to convert. What I do convert is the events_lost counter of LTT. The
>>>> value is copied to the events_discarded of LTTng. At least that looked reasonable
>>>> to me. Can you elaborate why we would need a state machine there?
>>> In lttv, the control flow view and company needs a state system. The
>>> events in lttng 0.x and 2.0 are slightly different, so we won't see
>>> stuff like the current TID and file statuses. I'm just giving you the
>>> heads up that it may be not so trivial to get the info. The best thing
>>> to do IMO is look up events in LTTng 2.0 and try to match the ones you
>>> have in babeltrace to them.
>>> That way, it will work with lttv and eclipse.
>>>
>> I'm not sure either that I understand what you mean.
>>
>> The goal is just to convert traces, not create a whole state system.
>> When we will be able to get a converted trace, the viewers could adjust
>> to support them.
> Yannick is right, these patches are just for converting the raw trace data.
> Interpreting the converted trace data is then up to LTTV or Eclipse.
>
> Conversion of the trace data to the concrete CTF description LTTng 2.x is
> using would be quite hard and require also to convert the trace data itself
> (which I avoided so far...).
>
> -- Jan
>
>  
>> Yannick
