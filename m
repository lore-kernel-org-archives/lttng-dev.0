From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Difference in metadata between per-PID and
	per-UID	traces
Date: Tue, 10 Sep 2013 16:17:51 -0400
Message-ID: <20130910201751.GA14222__20018.3925721378$1378844327$gmane$org@Krystal>
References: <48CF5AC71E61DB46B70D0F388054EFFD2678ED56@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VJUNk-0000KO-R7
	for lttng-dev@lists.lttng.org; Tue, 10 Sep 2013 16:17:58 -0400
Content-Disposition: inline
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD2678ED56@VAL-E-02.valcartier.drdc-rddc.gc.ca>
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
>    I notice that the metadata of per-PID user-space traces has three attr=
ibutes which are dropped from the equivalent per-UID trace:
> =

> Per-PID trace:
> =

> env {
> 	hostname =3D "sds-dut-vb";
> 	domain =3D "ust";
> 	tracer_name =3D "lttng-ust";
> 	tracer_major =3D 2;
> 	tracer_minor =3D 3;
> 	tracer_patchlevel =3D 0;
> 	vpid =3D 7024;
> 	procname =3D "simple";
> };
> =

> Per-UID trace:
> =

> env {
> 	hostname =3D "sds-dut-vb";
> 	domain =3D "ust";
> 	tracer_name =3D "lttng-ust";
> 	tracer_major =3D 2;
> 	tracer_minor =3D 3;
> };
> =

>    The trace data are the same in this case (two trace sessions capturing=
 the same events in parallel), so this change in metadata only shows up in =
babeltrace's output (when using '-f all -n all' for example).
> =

>    Is this intentional?

Yes

>  It does mean per-UID traces "anonymize" the event data slightly.  And wh=
y is "tracer_patchlevel" dropped alongside the process-related attributes?

Because different processes could use different tracer versions.

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
