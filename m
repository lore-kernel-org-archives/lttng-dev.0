From: <Bingfeng.Zhao@emc.com>
Subject: Re: some questions on lttng
Date: Sun, 22 Jul 2012 23:27:48 -0400
Message-ID: <4B3E7C3D6AE874479212F4D6AE0AFD1F02C7FF08D3__46335.5974447497$1343014145$gmane$org@MX28A.corp.emc.com>
References: <4B3E7C3D6AE874479212F4D6AE0AFD1F02C7FF0741@MX28A.corp.emc.com>
	<4B3E7C3D6AE874479212F4D6AE0AFD1F02C7FF0805@MX28A.corp.emc.com>
	<20120720172618.GA19112@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from hop-nat-141.emc.com ([168.159.213.141]
	helo=mexforward.lss.emc.com) by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Bingfeng.Zhao@emc.com>) id 1St9Jz-00089q-VB
	for lttng-dev@lists.lttng.org; Sun, 22 Jul 2012 23:28:36 -0400
In-Reply-To: <20120720172618.GA19112@Krystal>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com, tglx@linutronix.de
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org



> -----Original Message-----
> From: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com]
> Sent: Saturday, July 21, 2012 1:26 AM
> To: Zhao, Bingfeng; tglx@linutronix.de
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] some questions on lttng
> 
> * Bingfeng.Zhao@emc.com (Bingfeng.Zhao@emc.com) wrote:
> > Anyone can answer our questions? Mathieu?
> 
> sorry for the slow reply, I've been swamped in filtering implementation lately,
> 
> >
> > From: Bingfeng.Zhao@emc.com [mailto:Bingfeng.Zhao@emc.com]
> > Sent: Wednesday, July 18, 2012 5:54 PM
> > To: lttng-dev@lists.lttng.org
> > Subject: [lttng-dev] some questions on lttng
> >
> > Hello the dev list,
> > We encounter some basic questions when try to adapt the LTTNG in our poject.
> >
> > 1.   When the trace is enabled and all are well configurated, we get
> > trace messages collected under the session folder. The question is
> > whether it is possible that some traces will lost when the trace
> > messages are huge. How will LTTNG do if the consumer deamon cannot
> > fast enough to copy the trace message from trace buffer?
> 
> There are currently two ways to configure the channels: discard and overwrite
> mode.
> 
> In discard mode, upon buffer full condition, events are discarded, and we keep
> track of the number of events discarded in the packet headers, so the trace viewer
> can print warnings about discarded events within a specific time-frame.
> 
> In overwrite mode, upon buffer full condition, the oldest subbuffer
> (packet) is overwritten. We will soon add a sequence counter to the packet header,
> so the trace viewer can show when a packet is missing in the stream (either due to
> being overwritten by the tracer or due to UDP packet loss in network streaming).
> 
> If the message (event) is too large to fit within a packet, it is discarded,
> incrementing the event discarded counter accordingly (so the viewer can show this
> information from the packet header).
> 
> It would be interesting to implement a "blocking" mode that makes the application
> block if buffer is full. This makes the tracer much more intrusive, and if something
> goes wrong in the session daemon or consumer daemon, the app hangs, but it
> might be interesting for logging purposes, if you care about _never_ losing an
> event. I would recommend to use this kind of feature in debugging setups, not in
> production, at the beginning, since it would make the sessiond/consumerd critical
> (if they die, the application hangs. I don't want to see this happen in production).
> 
Thanks for the explanation, I got you point. However I'm at a different scenario. 
Normally the trace is off by default, that is there is no session created and started.
The trace call definitely should not block anything. Ideally it should not trigger at all 
and I believe that is what lttng does now.

If I find something wrong, I would like enable the trace at once and try to figure out 
what happen. At this time, (possible) lost event will make the trouble shooting much 
difficult (example for those rare race condition issues) as you cannot reason about 
what you collected if there are some messages lost. So all the meaning of static trace 
may lost and such scenario is not rare in production.

> >
> > 2.   For user space trace, currectly seems we cannot set the flush
> > interval. How can we control the flush internal for UST? If no, is
> > there hardcoded or random flash interval? Or there is no time based
> > flush mechanism at all for UST?
> 
> The flush interval will only be useful for live streaming, which is not supported yet.
> Currently, UST does a subbuffer switch (flush) each time the subbuffer cannot hold
> the next event to write. I plan to implement this periodic flush at the consumer
> daemon level, so it will be less intrusive within the application. Adding timers to a
> traced application without its knowledge would likely be a nightware waiting to
> happen.
> 
> >
> > 3.   For a severe kernel panic can we extrace buffered trace messages
> > from LTTNG internal buffer in full memory core dump file? Is there
> > tools on this we can leverage?
> 
> Not yet, but it's a feature we look forward to see coming. At some point in the past,
> I remember there was a patch to lcrash that was supporting extraction of lttng 0.x
> buffers from a crashed kernel image. However, LTTng 2.0 data structure layout is
> quite different, so this work would have to be redone. I'm aware that Thomas
> Gleixner is working on "Shrinking core dump on the fly" (see the Tracing Summit
> schedule at http://tracingsummit.org/wiki/TracingSummit2012). Maybe he has a
> few words to say on this, and some recommendations.
> 
> One related thing that would be interesting to implement is a libringbuffer backend
> that uses video card memory buffers that survive reboots. Given that lttng
> libringbuffer is very modular, it should be straightforward to implement.
> 
> Thanks!
> 
> Mathieu
> 
> >
> > Thank you,
> > - Bingfeng
> >
> 
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
> 
> --
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant EfficiOS Inc.
> http://www.efficios.com
