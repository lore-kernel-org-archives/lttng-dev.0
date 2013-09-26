From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: lttng snapshots and running traces
Date: Thu, 26 Sep 2013 15:54:30 -0400
Message-ID: <524490F6.5080604__23072.3717170351$1380225335$gmane$org@efficios.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD26793929@VAL-E-02.valcartier.drdc-rddc.gc.ca>	<52445DDD.9050808@efficios.com>	
	<48CF5AC71E61DB46B70D0F388054EFFD2679396E@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<52447DEF.5030005@efficios.com>
	<48CF5AC71E61DB46B70D0F388054EFFD267939F7@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([93.20.26.243])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1VPHe1-0006be-AN
	for lttng-dev@lists.lttng.org; Thu, 26 Sep 2013 15:54:43 -0400
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD267939F7@VAL-E-02.valcartier.drdc-rddc.gc.ca>
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



On 13-09-26 03:36 PM, Thibault, Daniel wrote:
> Envoy=E9 : 26 septembre 2013 14:33
> =

>>>    Is the following scenario possible?  The consumer tries to get_subbu=
f, and is denied access (because tracers
>>> are writing into it).  It then tries to get the next sub-buffer, but th=
e luck of task scheduling is such that by the =

>>> time it actually calls the request routine, the tracers have already ov=
erwritten the sub-buffer in question and =

>>> gone on to the next one.  The get_subbuf succeeds and the consumer keep=
s doing its thing (the timestamps =

>>> remain monotonically increasing, so there is no corruption).  The resul=
ting snapshot on disk has a large jump =

>>> in its timestamps, having lost a whole buffer cycle's worth of event re=
cords.
>>>
>>>    To complicate things, the tracers then stop (for lack of event occur=
rences) in some sub-buffer ahead of the =

>>> consumer's current position, but still short of the consumer's stop goa=
l.  When the consumer skips over the =

>>> busy sub-buffer (where the tracers are "stuck"), it would read events t=
hat apparently jump back in time (a =

>>> whole buffer cycle's worth of time), so I guess it would stop there and=
 close the snapshot?
>>
>> One important design note to understand this situation: even though we w=
rite in a ring-buffer, the positions =

>> are free-running counters, they "never" wrap-around (well, we are dealin=
g with 64-bit counters). In order to =

>> map a position to an actual subbuffer, we use a sort of modulo. This ope=
ration gives us the actual subbuffer =

>> to use and also allows us to detect if the tracer has already reused thi=
s subbuffer.
> =

>    Good to know, but it doesn't answer the question.   :-)
> =

>    If the tracers pass the consumer, and then the consumer passes the tra=
cers, does the consumer stop copying =

> the buffer contents to the snapshot trace?
> =

> * consumer reads a number of "pass n" sub-buffers (where n is the number =
of times the tracers have gone around)
> * tracers catch up with the consumer, skip ahead, write at least one whol=
e "pass n+1" sub-buffer
> * tracers then stop or slow down
> * consumer reads the "pass n+1" sub-buffer(s), then overtakes the tracers
> * consumer skips over the sub-buffer where the tracers are, finds a "pass=
 n" sub-buffer
> =

>    If the consumer doesn't close the trace at that point, it would corrup=
t the snapshot.
The consumer reads absolute positions in the ring-buffer, if a subbuffer
has been overwritten, it skips to the next until it reaches its end
position.
The consumer will never read data that has been recorded after it
started taking the snapshot.
That is why it is important to know that we deal with absolute positions.

Is that clearer ?

If you want to take a look, the code for the kernel is in the function
lttng_kconsumer_snapshot_channel in
src/common/kernel-consumer/kernel-consumer.c.
You will see that we take the begin and end positions, and then iterate
subbuffer by subbuffer, if a get_subbuff(absolute_position) fails it
means it has already been reused and we skip to the next.

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
