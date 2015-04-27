From: Michael Haberler <mail17@mah.priv.at>
Subject: Re: introduction  & usage of LTTNG in machinekit
Date: Mon, 27 Apr 2015 22:41:05 +0200
Message-ID: <AC8E2872-A806-4F43-A1E1-0E077697979D__12631.7450115041$1430167330$gmane$org@mah.priv.at>
References: <887B7027-5FE6-4D13-B35A-7DCBD785DC57@mah.priv.at>
 <711173584.2718642.1427481342189.JavaMail.zimbra@polymtl.ca>
 <8187A8CE-F16D-4CDE-B969-380DE308A8D5@mah.priv.at>
 <826926538.3126946.1427639461728.JavaMail.zimbra@polymtl.ca>
 <76BAB974-2B32-469C-82AD-4D5630AFA28E@mah.priv.at>
 <381678352.13569741.1430055111345.JavaMail.zimbra@polymtl.ca>
 <A0DF7795-1940-45E4-A12B-ED0D340883D4@mah.priv.at>
 <1024078202.13732013.1430137815501.JavaMail.zimbra@polymtl.ca>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mah2.mah.priv.at ([86.59.12.251] helo=mah.priv.at)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mail17@mah.priv.at>) id 1Ymppy-0004wa-Rj
 for lttng-dev@lists.lttng.org; Mon, 27 Apr 2015 16:41:08 -0400
In-Reply-To: <1024078202.13732013.1430137815501.JavaMail.zimbra@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michel Dagenais <michel.dagenais@polymtl.ca>
Cc: =?utf-8?Q?Rafa=C3=ABl_Blanchet-Lecomte?= <rafael.blanchet-lecomte@polymtl.ca>, lttng-dev@lists.lttng.org, =?utf-8?Q?Alexander_R=C3=B6ssler?= <mail@roessler.systems>
List-Id: lttng-dev@lists.lttng.org


> Am 27.04.2015 um 14:30 schrieb Michel Dagenais <michel.dagenais@polymtl.ca>:
> 
> 
>> That said, the folks which have timing problems have not caught on yet.. it
>> looks some more guidance, examples and a bit of a machinekit-specific
>> writeup is needed, competing with the other 247 priority projects on my desk
>> ;)
> 
> If we can reproduce easily the problems, bad latency on Linux Prempt-RT in a specific configuration, we can take care of tracing and diagnosing the problems. Otherwise, the users will have to activate the tracing themselves on their setup and we can guide them for the diagnosis. 

The problem at hand has these characteristics:

- it happens only on low-end ARM platforms
- the code is part of the trajectory planner, which involves fp and transcendental functions
- the code is executed from a period Xenomai thread and once in a while execution time exceeds the cycle time budget
- no interrupts, system call, or Xenomai API call is involved, so kernel or ipipe tracing will not help to narrow it down

my idea was to insert trace points in the tp code and one triggered on 'time window exceeded' so one could look backwards in history to determine which span of code used excessive time; does this sound reasonable?

Alex (in cc) has a test case which reproducibly triggers the problem

> 
>> Let me add a question out of the blue: I've read the literature on observing
>> time and distributed systems and am aware of the theoretical issues, as well
>> as clock synchronisation. Still - has any thought been given to merge traces
>> of several systems based on synchronisation points (known causality),
>> well-synchronized  clocks, or other forms of hardware synchronisation?
> 
> I suppose that you mean something like this which we offer in TraceCompass:
> 
> http://archive.eclipse.org/tracecompass/doc/org.eclipse.tracecompass.doc.user/Trace-synchronization.html
> 
> We have two use cases supported already, distributed systems exchanging packets through TCP and physical / virtual machines communicating through vmenter / exit and tracepoints on both sides of those transitions. This framework can easily be extended to other cases. We could in the future make it available declaratively (define event types and unique identifiers that should be used to match causality-related events).

That's pretty impressive. I'll try to reproduce an example and think through how this could fit into what we're doing.

Background is - we're getting more into supporting fieldbus-connected components, some of which might run our code, so distributed tracing would become an option

with CANbus in particular, an open question is if driving a remote motion controller is within the range of bus throughput; ballpark - no, but there are some drives which have quite intelligent features and it might work. If not, it would help to know where we loose out, and up to which rates it would still work.

It would good to have such a tool at hand, and the developers aware of it, and how to use it. I could actually see a use case for mixed software tracing and hardware-visible events, like from a logic analyzer.

The other area where I could find use for such a capability is UI/server interaction (could it be there might be much wider interest for this than just me?)

Those is a more 'researchy' applications than the one above though. That one we need to nail.

- Michael
