From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [LTTNG-TOOLS PATCH] On-disk multiple
	tracefiles	circular buffer
Date: Tue, 7 May 2013 12:02:02 -0400
Message-ID: <20130507160202.GD6601__31151.5497313396$1367942572$gmane$org@Krystal>
References: <48CF5AC71E61DB46B70D0F388054EFFD026695@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UZkLA-0003Dz-LS
	for lttng-dev@lists.lttng.org; Tue, 07 May 2013 12:02:08 -0400
Content-Disposition: inline
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD026695@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>, "Painchaud,
	Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

* Thibault, Daniel (Daniel.Thibault@drdc-rddc.gc.ca) wrote:
 [...]
>    On a somewhat related topic, I find the CTF (1.8.2) spec confusing
>    in sections 5 and 6:
> 
> > 5. Event Packet Header
> >
> > The event packet header consists of two parts: the "event packet header"
> > is the same for all streams of a trace. The second part, the "event
> > packet context", is described on a per-stream basis. Both are described
> > in the TSDL meta-data. The packets are aligned on architecture-page-sized
> > addresses.
> [...]
> > 5.1 Event Packet Header Description
> [...]
> > 5.2 Event Packet Context Description
> [...]
> > 6. Event Structure
> >
> > The overall structure of an event is:
> >
> > 1 - Stream Packet Context (as specified by the stream meta-data)
> >  2 - Event Header (as specified by the stream meta-data)
> >   3 - Stream Event Context (as specified by the stream meta-data)
> >    4 - Event Context (as specified by the event meta-data)
> >     5 - Event Payload (as specified by the event meta-data)
> [...]
> > 6.1 Event Header
> [...]
> > 6.1.1 Type 1 - Few event IDs
> [...]
> > 6.1.2 Type 2 - Many event IDs
> [...]
> > 6.2 Event Context
> >
> > The event context contains information relative to the current event.
> > The choice and meaning of this information is specified by the TSDL
> > stream and event meta-data descriptions. The stream context is applied
> > to all events within the stream. The stream context structure follows
> > the event header. The event context is applied to specific events. Its
> > structure follows the stream context structure.
> [...]
> > 6.3 Event Payload
> >
> > An event payload contains fields specific to a given event type. The fields
> > belonging to an event type are described in the event-specific meta-data
> > within a structure type.
> 
>    The babeltrace output labels the following structured fields in
>    each event record:
> 
> stream.packet.context
> stream.event.header
> stream.event.context
> event.context
> event.fields
> 
>    They match section 6:
> 
> > 1 - Stream Packet Context (as specified by the stream meta-data)
> >  2 - Event Header (as specified by the stream meta-data)
> >   3 - Stream Event Context (as specified by the stream meta-data)
> >    4 - Event Context (as specified by the event meta-data)
> >     5 - Event Payload (as specified by the event meta-data)
> 
>    But where does section 5 fit in?  There is no "Event Packet Header"
>    or "Event Packet Context" in the above.  Section 3 mentions that
>    "The event stream header will therefore be referred to as the
>    'event packet header' throughout the rest of this document."
>    Judging by the C structs described, the lack of a Stream Packet
>    Context struct in section 6, and the babeltrace output, I'm pretty
>    sure that the "stream packet context" is the "event packet context"
>    and that it also subsumes the "event packet header" (a.k.a. "event
>    stream header").  But it would be nice if this were actually stated
>    in the CTF spec.

I should not have put info about the packet headers/context within the
"6. Event Structure" section. I'm clarifying the title of section 6.2
too. Here is the fix:

commit 0b174d87e0f022a098caaeba1789c99a759bca30
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Tue May 7 12:00:51 2013 -0400

    Clarify event layout
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu



-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
