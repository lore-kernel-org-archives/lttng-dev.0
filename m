From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: [diamon-discuss] Parsing external datasources in
 trace compass for regions of interest in a trace
Date: Fri, 06 Feb 2015 18:03:36 -0500
Message-ID: <54D54848.3040807__39937.1425658048$1423263864$gmane$org@efficios.com>
References: <54D53C96.8030805@ericsson.com>
 <1226582540.88170.1423261373714.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([85.12.144.25])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1YJrw8-0005SA-Pv
 for lttng-dev@lists.lttng.org; Fri, 06 Feb 2015 18:03:47 -0500
In-Reply-To: <1226582540.88170.1423261373714.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Matthew Khouzam <matthew.khouzam@ericsson.com>
Cc: diamon-discuss@lists.linuxfoundation.org, lttng-dev@lists.lttng.org, tracecompass developer discussions <tracecompass-dev@eclipse.org>
List-Id: lttng-dev@lists.lttng.org



On 15-02-06 05:22 PM, Mathieu Desnoyers wrote:
> ----- Original Message -----
>> From: "Matthew Khouzam" <matthew.khouzam@ericsson.com>
>> To: "tracecompass developer discussions" <tracecompass-dev@eclipse.org>, diamon-discuss@lists.linuxfoundation.org,
>> lttng-dev@lists.lttng.org
>> Sent: Friday, February 6, 2015 5:13:42 PM
>> Subject: [diamon-discuss] Parsing external datasources in trace compass for regions of interest in a trace
>>
>> Hello,
>>
>> I am right now looking getting external datasources to supply
>> information for a trace, like a region of interest.
>>
>> Background: we can run an analysis on a trace manually, in python, excel
>> or what have you and come up with something interesting, like: around
>> 12:30pm something happened to a trace. Let's dig deeper with tracecompass.
>>
>> To make this work: we need to find a way to import the data, so we
>> should agree on a standard data standard. I personally like the LTTng
>> analysis outputs so I am picking that for now. :)
>>
>> Here are some formats that could be acceptable as regions of interest
>>  * [2015-01-15 12:18:37.216484041, 2015-01-15 12:18:53.821580313] name
>>  * [2015-01-15 12:18:37.216484041, 2015-01-15 12:18:53.821580313] name
>> boookmark
>>  * [ 2015-01-15 12:18:37.216484041] name boookmark
>>  * [12:18:37.216484041] name boookmark
>>  * [ 12:18:37.216484041, 12:18:53.821580313] name boookmark
>>  * [ 2014-12-12 17:29:43.802588035] name with space
>>  * [ 2014-12-12 17:29:43] irrational title
>>  * [17:29:43.802588035] rational title
>>  * [ 17:29:43] test test test
>>  * [17:29:43,17:29:44] thing
>>  * [12:18:37.216484041   ] (no text)
>>
>> When there is one timestamp, we will create one bookmark.
>> When there is a range, we would create two bookmarks in a given trace,
>> the first one being appended with " start" the second with " end"
>>
>> This should allow tracecompass to marginally benefit from the lttng
>> analyses that are looking pretty nice, and later perhaps from tcp
>> analyses from tshark and syslog stuff.
>>
>> Does anyone have an objection to this way of working?
> 
> Do you intend on supporting timestamps that appear elsewhere than
> the beginning of lines ? Do you consider all text at the right of
> the timestamp or timestamp range to be part of the naming of the
> region of interest linked to the timestamp/timestamp range ?
> 
> Julien, did we want to reserve [] for only timestamp range or
> we also want them for single timestamps ?

Right now the [] are only valid with time ranges (they are not accepted
with --begin and --end). I don't mind allowing the brackets for all
timestamps (like in dmesg), we still have the "," to identify if it's a
range or not.
But for convenience, they will remain optional for --begin and --end.

We just have to keep in mind, that [32,64] could be a range of
values/frequency and not necessarily timestamps.

Julien
