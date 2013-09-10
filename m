From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Difference in metadata between per-PID
	and	per-UIDtraces
Date: Tue, 10 Sep 2013 16:31:12 -0400
Message-ID: <20130910203112.GA14529__32512.5831798234$1378845132$gmane$org@Krystal>
References: <48CF5AC71E61DB46B70D0F388054EFFD2678ED56@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<20130910201751.GA14222@Krystal>
	<48CF5AC71E61DB46B70D0F388054EFFD2678ED71@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VJUaf-00017k-Fh
	for lttng-dev@lists.lttng.org; Tue, 10 Sep 2013 16:31:18 -0400
Content-Disposition: inline
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD2678ED71@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Thibault, Daniel (Daniel.Thibault@drdc-rddc.gc.ca) wrote:
> -----Message d'origine-----
> De=A0: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com] =

> Envoy=E9=A0: 10 septembre 2013 16:18
> =

> >  > And why is "tracer_patchlevel" dropped alongside the process-related=
 attributes?
> >
> > Because different processes could use different tracer versions.
> =

>    How is such a situation handled in the per-UID case?

There are version checks for each application. We don't keep this
information in the trace metadata, because it is shared across apps.

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
