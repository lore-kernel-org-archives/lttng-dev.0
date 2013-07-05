From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: On lost events
Date: Fri, 5 Jul 2013 18:13:12 -0400
Message-ID: <20130705221312.GA28331__15633.2246181139$1373062433$gmane$org@Krystal>
References: <51D5ED4E.2000305@ericsson.com> <20130704222948.GB8852@Krystal>
	<51D71672.8020804@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UvEFg-0000pY-77
	for lttng-dev@lists.lttng.org; Fri, 05 Jul 2013 18:13:16 -0400
Content-Disposition: inline
In-Reply-To: <51D71672.8020804@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Matthew Khouzam <matthew.khouzam@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Matthew Khouzam (matthew.khouzam@ericsson.com) wrote:
> Quick question. Some traces have overlapping packets, so in that case,
> the lost events are between the last event of a previous packet and the
> first event of the next packet, which just happens to be the previous
> packet's end time?

"Some traces have overlapping packets"

do you mean

"Some traces have overlapping packets"

or

"Some streams have overlapping packets"

?

> On 13-07-04 06:29 PM, Mathieu Desnoyers wrote:
> > * Matthew Khouzam (matthew.khouzam@ericsson.com) wrote:
> >> Hi tracing werewolves,
> >>
> >> I want to clear up some stuff about lost events.
> >>
> >> Lost events are caused, in lttng 2.x when the tracer does not have
> >> enough memory available to write an event. This can be due to:
> >> * events coming in too fast (faster than we can write them)
> >> * a given event being too large
> >> * we have an event that does a nested wrap around
> >>
> >> LTTng will not write the whole packet that is lost.
> > LTTng does not write an _event_ discarded at all. However, a packet
> > "lost" is a different thing: it only happens in overwrite mode, when we
> > overwrite a packet.
> >
> >> It uses a ring
> >> buffer and the packet will just be overwritten in the buffer, but a
> >> counter will be incremented.
> > For an _event_ discarded, we're not even writing it into the buffer.
> >
> >> The counter is written in the packet header in the CTF trace.
> > Indeed, the event lost counters are written in the packet in the ctf
> > trace.
> >
> >> When reading a trace, if you just read the packet headers, you will see
> >> something as follows:
> >>
> >> Packet 1:
> >> ts_begin: 100
> >> ts_end: 200
> >> discarded: 0
> >>
> >> Packet 2:
> >> ts_begin: 300
> >> ts_end: 400
> >> discarded: 100
> >>
> >> Packet 3:
> >> ts_begin: 500
> >> ts_end: 600
> >> discarded: 100
> >>
> >> Packet 4:
> >> ts_begin: 650
> >> ts_end: 750
> >> discarded: 200
> >>
> >> With this example, the lost events are located between packets 1, 2 and
> >> packets 3,4.
> >>
> >> If the events are too large, they are discarded in the current packet,
> >> lttng does not split events into packets (yet?), and this is lost during
> >> a current packet.
> >>
> >> That means if the events are lost between 1 and 2, they are potentially
> >> in the range of [200-400] but probably in [200-300]
> >> The next lost event are between 3 and 4 (events discarded is a total
> >> count, not local to that packet), so 100 events are also lost between
> >> [600-750] but likely in between [600-650]. If you can confirm that all
> >> events WITH CONTEXTS are smaller than the packet sizes, I think it's a
> >> shoe in that it's between the packets and not containing the next packet.
> > "and not contained in the next packet".
> >
> > Thanks,
> >
> > Mathieu
> >
> >> Hope this clarifies some issues, it did for me!
> >>
> >> Matthew
> >>
> >> _______________________________________________
> >> lttng-dev mailing list
> >> lttng-dev@lists.lttng.org
> >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
