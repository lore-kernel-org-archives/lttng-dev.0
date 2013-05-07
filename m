From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [LTTNG-TOOLS PATCH] On-disk multiple
	tracefiles	circular buffer
Date: Tue, 7 May 2013 11:42:26 -0400
Message-ID: <20130507154226.GC6601__42172.3801097416$1367941391$gmane$org@Krystal>
References: <48CF5AC71E61DB46B70D0F388054EFFD026695@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UZk28-00032u-Kg
	for lttng-dev@lists.lttng.org; Tue, 07 May 2013 11:42:28 -0400
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
> -----Message d'origine-----
> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> =

> > I having similar questions as Daniel about tracefile-size and tracefile=
-count.
> >
> > For each stream, do we have max size used on disk =3D size * count or s=
ize used =3D size ?
> =

>    My understanding is that the maximum size on disk of a stream (channel=
) would be size*count*CPUs*processes, where processes is the number of user=
-space processes emitting events on that channel (this number can theoretic=
ally be quite large); for the kernel this number is 1.

Yes. For per-UID UST buffers the number is also close to 1 (1 per UID
per ABI).

> =

> > If there is a doubt about the semantic, maybe using clearer terms that =
don't need to be explained might help. I guess the confusion here is:
> > what is a tracefile exactly ? The notion of "stream" is much clearer th=
an "tracefile" in the CTF spec, so we might want to consider:
> >
> >--stream-chunks-num NUM: each stream, on disk, is divided in at most
> >   NUM chunks (one file per chunk). When the maximum number of chunks is
> >   reached, oldest chunks are deleted for this stream, thus creating
> >   a flight recorder on disk.
> >
> >--stream-chunks-size SIZE: chunk size. Must be a multiple of
> >   subbuf-size. Default value: subbuffer size.
> =

>    According to the CTF spec ("Event Stream: An ordered sequence of
>    events, containing a subset of the trace event types."), an event
>    stream is an LTTng channel.

Wrong. LTTng channel contains several streams (think of it like a class
of streams).

>  This is clearly not the same thing as
>    an on-disk file (and its corresponding file stream).  This would
>    mean:
> =

> --stream-chunks-num NUM: each file stream (a channel, CPU ID, originating=
 process ID triplet),
>    on disk, is divided in at most NUM chunks (one file per chunk).  When =
the maximum
>    number of chunks is reached, the oldest chunks are overwritten by this=
 stream, thus
>    creating a circular flight recorder on disk.
> =

> > Actually, you might want to consider that the stream-chunk-size need to=
 be a multiple of the subbuffer size. The check needs to be more strict.
> =

>    Good idea.  Not necessarily a power of two, though.

The UI has been fixed already, skipping the part above,

> =

> ##########
> =

>    On a somewhat related topic, I find the CTF (1.8.2) spec confusing in =
sections 5 and 6:
> =

> > 5. Event Packet Header
> >
> > The event packet header consists of two parts: the "event packet header"
> > is the same for all streams of a trace. The second part, the "event
> > packet context", is described on a per-stream basis. Both are described
> > in the TSDL meta-data. The packets are aligned on architecture-page-siz=
ed
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
> > An event payload contains fields specific to a given event type. The fi=
elds
> > belonging to an event type are described in the event-specific meta-data
> > within a structure type.
> =

>    The babeltrace output labels the following structured fields in
>    each event record:
> =

> stream.packet.context
> stream.event.header
> stream.event.context
> event.context
> event.fields
> =

>    They match section 6:
> =

> > 1 - Stream Packet Context (as specified by the stream meta-data)
> >  2 - Event Header (as specified by the stream meta-data)
> >   3 - Stream Event Context (as specified by the stream meta-data)
> >    4 - Event Context (as specified by the event meta-data)
> >     5 - Event Payload (as specified by the event meta-data)
> =

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

Will reply to this part in a separate email.

> =

>    I would also like to know if LTTng can populate the "Event Context"
>    (6.4) of a trace, or if this is something only other CTF producers
>    may do.  I haven't yet been able to produce any traces that have
>    that field in them, and don't see how to do so.

Currently lttng does not produce event context.

Thanks,

Mathieu

> =

> Daniel U. Thibault
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critica=
l Cyber Security (MCCS)
> Protection des syst=E8mes et contremesures (PSC) / Systems Protection & C=
ountermeasures (SPC)
> 2459 route de la Bravoure
> Qu=E9bec, QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada / Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
