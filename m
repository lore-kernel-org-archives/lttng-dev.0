From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: User-space tracing by the root lttng-sessiond
Date: Tue, 14 May 2013 03:05:45 -0400
Message-ID: <20130514070545.GA5213__39677.2607732148$1368515177$gmane$org@Krystal>
References: <48CF5AC71E61DB46B70D0F388054EFFD12D1201A@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Uc9Ix-0006g4-5l
	for lttng-dev@lists.lttng.org; Tue, 14 May 2013 03:05:47 -0400
Content-Disposition: inline
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD12D1201A@VAL-E-02.valcartier.drdc-rddc.gc.ca>
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
>    I ran a little experiment whose results surprised me.  Using a non-tra=
cing group user account, I first made sure I had a root lttng-sessiond runn=
ing and a user-space lttng-sessiond.  In the first I set up a trace for som=
e kernel events plus all user-space events.  In the second I set up a trace=
 for all user-space events only.  Both traces were started, then the lttng-=
ust/doc/examples/easy-ust/sample demo was run to generate the user-space ev=
ents.  Then both traces were stopped and destroyed.
> =

>    I noted there were three lttng-consumerd daemons: one in user-space, t=
he other two owned by root.  Presumably one is servicing the kernel events =
while the other is servicing the user-space events.

yes

>  (Question: If there were several users active at once, would there be se=
veral root user-space lttng-consumerd daemons or still just one?)

no

> =

>    As expected, both traces show the sample user-space events (with no lo=
sses, it turns out).  What surprised me, however, is that the pairs of even=
ts were not in synch. Since they're all coming out of the same trace provid=
er, I would expect the time-stamp to be issued once (by the tracepoint prov=
ider), and then two copies of the event to go into the two trace buffers fo=
r eventual storage.  Could it be that the tracepoint provider instead issue=
s two separate events, one for each of its clients?

yes

>  (For the record, the pairs of events were out of synch by at least 4187 =
ns (670 times out of 100 000), and as much as 3 326 405 ns (once); in 93% o=
f the time root event lags after the user-space event)

can be caused by interruption (for 4k ns) and preemption (for the 3s
hit).

> =

>    This seems problematic to me, since multiple traces capturing the same=
 event won't be able to reconcile their copies with each other.

since timestamps have to match the event physical order in the streams,
we need to assign one timestamp for each buffer. no way around this.

and yes, tracing is not stopping the world, so you can expect to have
slight timing inaccuracy like this. It's a trade-off between perfect
timing accuracy and tracer overhead.

Thanks,

Mathieu


> =

> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection & C=
ountermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l Cyber Security (MCCS)
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> 2459 route de la Bravoure
> Qu=E9bec QC=A0 G3J 1X5
> CANADA
> Vox=A0: (418) 844-4000 x4245
> Fax=A0: (418) 844-4538
> NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada=A0| Government of Canada
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
