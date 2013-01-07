From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Re: Reading cache misses in Userspace?
Date: Mon, 7 Jan 2013 14:10:42 -0500
Message-ID: <50EB1DB2.70109__29330.0712867223$1357585979$gmane$org@ericsson.com>
References: <50E8834D.1010802@gmx.de> <50EB10B8.80703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from imr4.ericy.com ([198.24.6.9])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1TsI7D-00022g-Mq
	for lttng-dev@lists.lttng.org; Mon, 07 Jan 2013 14:12:07 -0500
Received: from EUSAAHC001.ericsson.se ([147.117.188.75])
	by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id
	r07JOf7C016388
	for <lttng-dev@lists.lttng.org>; Mon, 7 Jan 2013 13:26:27 -0600
In-Reply-To: <50EB10B8.80703@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

This may be redundant, but if you enable kernel tracing, you can still
do your user space tracing and then correlate both of them to see what
was done when your cache misses go through the roof.

So that would be:
lttng create-session mySession
lttng enlable-event -a -k
lttng add-context -k perf:LLC-load-misses ...
lttng enable-event -a -u
lttng start
./yourapp
lttng stop
lttng destroy


Good luck,
Matthew

On 13-01-07 01:15 PM, Yannick Brosseau wrote:
> On 2013-01-05 14:47, Alexander Kampmann wrote:
>> hey,
>>
>> I would like to find out which part of my application causes most
>> cache misses. So I tried to add userspace events to my application. I
>> hoped LTTng would give me some mean of determining between which
>> tracepoints the most cache misses occur.
>>
>> I started a session like that:
>>
>> sudo lttng create session
>> sudo lttng enable-event -a -u
>> sudo lttng add-context -u -t perf:LLC-load-misses -t
>> perf:LLC-store-misses -t perf:LLC-prefetch-misses
>>
>> I get:
>>
>> Error: perf:LLC-prefetch-misses: UST invalid context
>> Error: perf:LLC-store-misses: UST invalid context
>> Error: perf:LLC-load-misses: UST invalid context
>>
>> Does this mean I can not add perf:LLC-* context to my userspace
>> events? Is there any way to figure out which part of my application
>> causes cache misses?
>>
>> If I use
>>
>> sudo lttng add-context -k -t perf:LLC-load-misses -t
>> perf:LLC-store-misses -t perf:LLC-prefetch-misses
>>
>> instead, I don't get an error, but the babeltrace output does not
>> contain any cache miss counts as well.
> This context will be added to kernel events only, so you will need to
> active some kernel event to see them.
> sudo lttng enable-event -a -k would do the trick. You can also only
> activate some events to reduce the size of the trace. The sched* events
> and maybe the syscall would be interesting to place the perf counter to
> some specific place of the application.
>
> Yannick
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
