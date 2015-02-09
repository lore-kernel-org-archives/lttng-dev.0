From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: [diamon-discuss] Parsing external datasources in
 trace compass for regions of interest in a trace
Date: Mon, 09 Feb 2015 13:49:39 -0500
Message-ID: <54D90143.5040401__6426.30672450668$1423507827$gmane$org@efficios.com>
References: <54D53C96.8030805@ericsson.com>
 <1226582540.88170.1423261373714.JavaMail.zimbra@efficios.com>
 <54D54848.3040807@efficios.com> <54D8FF55.7040602@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([85.12.144.25])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1YKtP1-0000Tu-IR
 for lttng-dev@lists.lttng.org; Mon, 09 Feb 2015 13:49:49 -0500
In-Reply-To: <54D8FF55.7040602@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Matthew Khouzam <matthew.khouzam@ericsson.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: diamon-discuss@lists.linuxfoundation.org, lttng-dev@lists.lttng.org, tracecompass developer discussions <tracecompass-dev@eclipse.org>
List-Id: lttng-dev@lists.lttng.org

On 15-02-09 01:41 PM, Matthew Khouzam wrote:
> Great feedback. I think for a first draft, this will work out swimmingly.
> 
> Right now, I was actually finding the first group of [], splitting with
> "," [1], then for every timestamp, creating a bookmark.
That's a good first start I think.

> 
> so [12:20:23 , 12:23:22] some range
> would give
> bookmark 1-> 12:20:23 -> some range start
> bookmark 2-> 12:23:22 -> some range end
I'm not sure exactly how clear it will be with overlapping ranges in the
TraceCompass list of bookmarks, but I guess it will be handled in a next
phase.

> 
> and
> [22:33:44 ] [key : value] [name = value] [id -> ref ] ...
> would parse as everything after the timestamp would be read as a string.
> 
> text [22:33:44] text2
> would discard text.
> 
> Is this ok?
Yes, let's start with that. As we discussed, if we need to output
differently from the analyses, we will make the changes.

> [1]note, it will not work with https://github.com/lttng/lttng-analyses
> where dash is used.
Oh if you are referring to the "Work in progress" section, you are
right, don't worry about this, it is a prototype and cannot even be used
from the scripts in the master branch. When this is ready it will use
the standard format.

Thanks,

Julien

> 
> On 15-02-06 06:03 PM, Julien Desfossez wrote:
>>
>> On 15-02-06 05:22 PM, Mathieu Desnoyers wrote:
>>> ----- Original Message -----
>>>> From: "Matthew Khouzam" <matthew.khouzam@ericsson.com>
>>>> To: "tracecompass developer discussions" <tracecompass-dev@eclipse.org>, diamon-discuss@lists.linuxfoundation.org,
>>>> lttng-dev@lists.lttng.org
>>>> Sent: Friday, February 6, 2015 5:13:42 PM
>>>> Subject: [diamon-discuss] Parsing external datasources in trace compass for regions of interest in a trace
>>>>
>>>> Hello,
>>>>
>>>> I am right now looking getting external datasources to supply
>>>> information for a trace, like a region of interest.
>>>>
>>>> Background: we can run an analysis on a trace manually, in python, excel
>>>> or what have you and come up with something interesting, like: around
>>>> 12:30pm something happened to a trace. Let's dig deeper with tracecompass.
>>>>
>>>> To make this work: we need to find a way to import the data, so we
>>>> should agree on a standard data standard. I personally like the LTTng
>>>> analysis outputs so I am picking that for now. :)
>>>>
>>>> Here are some formats that could be acceptable as regions of interest
>>>>  * [2015-01-15 12:18:37.216484041, 2015-01-15 12:18:53.821580313] name
>>>>  * [2015-01-15 12:18:37.216484041, 2015-01-15 12:18:53.821580313] name
>>>> boookmark
>>>>  * [ 2015-01-15 12:18:37.216484041] name boookmark
>>>>  * [12:18:37.216484041] name boookmark
>>>>  * [ 12:18:37.216484041, 12:18:53.821580313] name boookmark
>>>>  * [ 2014-12-12 17:29:43.802588035] name with space
>>>>  * [ 2014-12-12 17:29:43] irrational title
>>>>  * [17:29:43.802588035] rational title
>>>>  * [ 17:29:43] test test test
>>>>  * [17:29:43,17:29:44] thing
>>>>  * [12:18:37.216484041   ] (no text)
>>>>
>>>> When there is one timestamp, we will create one bookmark.
>>>> When there is a range, we would create two bookmarks in a given trace,
>>>> the first one being appended with " start" the second with " end"
>>>>
>>>> This should allow tracecompass to marginally benefit from the lttng
>>>> analyses that are looking pretty nice, and later perhaps from tcp
>>>> analyses from tshark and syslog stuff.
>>>>
>>>> Does anyone have an objection to this way of working?
>>> Do you intend on supporting timestamps that appear elsewhere than
>>> the beginning of lines ? Do you consider all text at the right of
>>> the timestamp or timestamp range to be part of the naming of the
>>> region of interest linked to the timestamp/timestamp range ?
>>>
>>> Julien, did we want to reserve [] for only timestamp range or
>>> we also want them for single timestamps ?
>> Right now the [] are only valid with time ranges (they are not accepted
>> with --begin and --end). I don't mind allowing the brackets for all
>> timestamps (like in dmesg), we still have the "," to identify if it's a
>> range or not.
>> But for convenience, they will remain optional for --begin and --end.
>>
>> We just have to keep in mind, that [32,64] could be a range of
>> values/frequency and not necessarily timestamps.
>>
>> Julien
> 
