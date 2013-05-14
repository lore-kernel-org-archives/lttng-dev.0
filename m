From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: User-space tracing by the root lttng-sessiond
Date: Tue, 14 May 2013 09:41:45 -0400
Message-ID: <20130514134145.GA28060__44814.6493793049$1368538939$gmane$org@Krystal>
References: <48CF5AC71E61DB46B70D0F388054EFFD12D1201A@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<20130514070545.GA5213@Krystal>
	<48CF5AC71E61DB46B70D0F388054EFFD12D1210D@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UcFUB-0001qJ-88
	for lttng-dev@lists.lttng.org; Tue, 14 May 2013 09:41:47 -0400
Content-Disposition: inline
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD12D1210D@VAL-E-02.valcartier.drdc-rddc.gc.ca>
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
> > >  (Question: If there were several users active at once, would there b=
e =

> > > several root user-space lttng-consumerd daemons or still just one?)
> >
> > no
> =

>    Please clarify: no, there will be several root user-space
>    lttng-consumerd daemons or no, there will be just one root
>    user-space lttng-consumerd daemon?

still just one.

> =

> > >    This seems problematic to me, since multiple traces capturing the =
same event won't be able to reconcile their copies with each other.
> >
> > since timestamps have to match the event physical order in the streams,=
 we need to assign one timestamp for each buffer. no way around this.
> =

>    Are the time-stamps issued by the tracepoint provider or by the
>    "buffer registrar" (i.e. the time-stamp is looked up when the event
>    is written to the buffer)?

the latter.

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
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
