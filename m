From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: [LTTNG-TOOLS PATCH] On-disk multiple tracefiles
 circular buffer
Date: Fri, 8 Mar 2013 20:31:33 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD026695__29434.5600218096$1362774797$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UE3xf-0000af-Cp
	for lttng-dev@lists.lttng.org; Fri, 08 Mar 2013 15:32:15 -0500
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: "Painchaud, Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

-----Message d'origine-----
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> I having similar questions as Daniel about tracefile-size and tracefile-c=
ount.
>
> For each stream, do we have max size used on disk =3D size * count or siz=
e used =3D size ?

   My understanding is that the maximum size on disk of a stream (channel) =
would be size*count*CPUs*processes, where processes is the number of user-s=
pace processes emitting events on that channel (this number can theoretical=
ly be quite large); for the kernel this number is 1.

> If there is a doubt about the semantic, maybe using clearer terms that do=
n't need to be explained might help. I guess the confusion here is:
> what is a tracefile exactly ? The notion of "stream" is much clearer than=
 "tracefile" in the CTF spec, so we might want to consider:
>
>--stream-chunks-num NUM: each stream, on disk, is divided in at most
>   NUM chunks (one file per chunk). When the maximum number of chunks is
>   reached, oldest chunks are deleted for this stream, thus creating
>   a flight recorder on disk.
>
>--stream-chunks-size SIZE: chunk size. Must be a multiple of
>   subbuf-size. Default value: subbuffer size.

   According to the CTF spec ("Event Stream: An ordered sequence of events,=
 containing a subset of the trace event types."), an event stream is an LTT=
ng channel.  This is clearly not the same thing as an on-disk file (and its=
 corresponding file stream).  This would mean:

--stream-chunks-num NUM: each file stream (a channel, CPU ID, originating p=
rocess ID triplet),
   on disk, is divided in at most NUM chunks (one file per chunk).  When th=
e maximum
   number of chunks is reached, the oldest chunks are overwritten by this s=
tream, thus
   creating a circular flight recorder on disk.

> Actually, you might want to consider that the stream-chunk-size need to b=
e a multiple of the subbuffer size. The check needs to be more strict.

   Good idea.  Not necessarily a power of two, though.

##########

   On a somewhat related topic, I find the CTF (1.8.2) spec confusing in se=
ctions 5 and 6:

> 5. Event Packet Header
>
> The event packet header consists of two parts: the "event packet header"
> is the same for all streams of a trace. The second part, the "event
> packet context", is described on a per-stream basis. Both are described
> in the TSDL meta-data. The packets are aligned on architecture-page-sized
> addresses.
[...]
> 5.1 Event Packet Header Description
[...]
> 5.2 Event Packet Context Description
[...]
> 6. Event Structure
>
> The overall structure of an event is:
>
> 1 - Stream Packet Context (as specified by the stream meta-data)
>  2 - Event Header (as specified by the stream meta-data)
>   3 - Stream Event Context (as specified by the stream meta-data)
>    4 - Event Context (as specified by the event meta-data)
>     5 - Event Payload (as specified by the event meta-data)
[...]
> 6.1 Event Header
[...]
> 6.1.1 Type 1 - Few event IDs
[...]
> 6.1.2 Type 2 - Many event IDs
[...]
> 6.2 Event Context
>
> The event context contains information relative to the current event.
> The choice and meaning of this information is specified by the TSDL
> stream and event meta-data descriptions. The stream context is applied
> to all events within the stream. The stream context structure follows
> the event header. The event context is applied to specific events. Its
> structure follows the stream context structure.
[...]
> 6.3 Event Payload
>
> An event payload contains fields specific to a given event type. The fiel=
ds
> belonging to an event type are described in the event-specific meta-data
> within a structure type.

   The babeltrace output labels the following structured fields in each eve=
nt record:

stream.packet.context
stream.event.header
stream.event.context
event.context
event.fields

   They match section 6:

> 1 - Stream Packet Context (as specified by the stream meta-data)
>  2 - Event Header (as specified by the stream meta-data)
>   3 - Stream Event Context (as specified by the stream meta-data)
>    4 - Event Context (as specified by the event meta-data)
>     5 - Event Payload (as specified by the event meta-data)

   But where does section 5 fit in?  There is no "Event Packet Header" or "=
Event Packet Context" in the above.  Section 3 mentions that "The event str=
eam header will therefore be referred to as the 'event packet header' throu=
ghout the rest of this document."  Judging by the C structs described, the =
lack of a Stream Packet Context struct in section 6, and the babeltrace out=
put, I'm pretty sure that the "stream packet context" is the "event packet =
context" and that it also subsumes the "event packet header" (a.k.a. "event=
 stream header").  But it would be nice if this were actually stated in the=
 CTF spec.

   I would also like to know if LTTng can populate the "Event Context" (6.4=
) of a trace, or if this is something only other CTF producers may do.  I h=
aven't yet been able to produce any traces that have that field in them, an=
d don't see how to do so.

Daniel U. Thibault
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)
Protection des syst=E8mes et contremesures (PSC) / Systems Protection & Cou=
ntermeasures (SPC)
2459 route de la Bravoure
Qu=E9bec, QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada / Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
