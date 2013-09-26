From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: lttng snapshots and running traces
Date: Thu, 26 Sep 2013 14:33:19 -0400
Message-ID: <52447DEF.5030005__879.836225840513$1380220468$gmane$org@efficios.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD26793929@VAL-E-02.valcartier.drdc-rddc.gc.ca>	<52445DDD.9050808@efficios.com>
	<48CF5AC71E61DB46B70D0F388054EFFD2679396E@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([194.250.102.243])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1VPGNT-0002Bc-DY
	for lttng-dev@lists.lttng.org; Thu, 26 Sep 2013 14:33:33 -0400
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD2679396E@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org



On 13-09-26 02:13 PM, Thibault, Daniel wrote:
> -----Message d'origine-----
> De : Julien Desfossez [mailto:jdesfossez@efficios.com] =

> Envoy=E9 : 26 septembre 2013 12:16
> =

>> When the consumer needs to read a subbuffer, it performs a get_subbuf op=
eration. If this operation succeeds, =

>> the consumer has exclusive access to this subbuffer and so it can read i=
t safely. If it fails, it means the tracer is =

>> currently using it and in the case of snapshots, the consumer will just =
skip to the next one (up to the end =

>> position it defined at the beginning of the snapshot).
>> So if there are gaps for a stream in the recorded snapshot, their size w=
ill be a multiple of the subbuffer size.
>>
>> Julien
> =

>    Ah, so it occurs at the sub-buffer level.  Simple and efficient.
> =

>    Is the following scenario possible?  The consumer tries to get_subbuf,=
 and is denied access (because tracers are writing into it).  It then tries=
 to get the next sub-buffer, but the luck of task scheduling is such that b=
y the time it actually calls the request routine, the tracers have already =
overwritten the sub-buffer in question and gone on to the next one.  The ge=
t_subbuf succeeds and the consumer keeps doing its thing (the timestamps re=
main monotonically increasing, so there is no corruption).  The resulting s=
napshot on disk has a large jump in its timestamps, having lost a whole buf=
fer cycle's worth of event records.
> =

>    To complicate things, the tracers then stop (for lack of event occurre=
nces) in some sub-buffer ahead of the consumer's current position, but stil=
l short of the consumer's stop goal.  When the consumer skips over the busy=
 sub-buffer (where the tracers are "stuck"), it would read events that appa=
rently jump back in time (a whole buffer cycle's worth of time), so I guess=
 it would stop there and close the snapshot?

One important design note to understand this situation : even though we
write in a ring-buffer, the positions are free-running counters, they
"never" wrap-around (well, we are dealing with 64-bit counters). In
order to map a position to an actual subbuffer, we use a sort of modulo.
This operation gives us the actual subbuffer to use and also allows us
to detect if the tracer has already reused this subbuffer.

> =

>    On a somewhat related topic, how does the session daemon handle the co=
ntext added to a channel?  Is it a set of instructions (flags, really) sent=
 to the tracer, similar to filter pseudo-code (but much less complicated)?
The contexts are kind of "hooks" activated at the channel level that are
activated when an event is recorded. It is not code sent by the session
daemon to the tracer (unlike filters), the code to fetch the information
is already in the tracer. So it is basically the same kind of operation
as activating an event in a channel.

Julien

> =

> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection & C=
ountermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l Cyber Security (MCCS)
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> 2459 route de la Bravoure
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> =
