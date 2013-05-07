From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: babeltrace output format
Date: Tue, 7 May 2013 09:10:53 -0400
Message-ID: <20130507131053.GF4186__17033.7193333127$1367932288$gmane$org@Krystal>
References: <48CF5AC71E61DB46B70D0F388054EFFD022E1A@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UZhfT-0001ZR-5h
	for lttng-dev@lists.lttng.org; Tue, 07 May 2013 09:10:55 -0400
Content-Disposition: inline
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD022E1A@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <dthibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Painchaud,
	Frederic" <fpaincha@drdc-rddc.gc.ca>, "Couture,
	Mario" <mcoutur@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

* Thibault, Daniel (dthibault@drdc-rddc.gc.ca) wrote:
> Is anyone else bothered by the slight irregularity of babeltrace's output?
> =

> Here is the same trace record printed using various babeltrace settings. =
 In all cases I used '-f trace:hostname --no-delta', varying only the '-n' =
part:
> =

> -n scope
> [11:02:08.064705355] edge-vb-u12 exit_syscall: stream.packet.context =3D =
{ 0 }, stream.event.context =3D { 1, 943, "whoopsie", 943, 109 }, event.fie=
lds =3D 8
> -n payload
> [11:02:08.064705355] edge-vb-u12 exit_syscall: { 0 }, { 1, 943, "whoopsie=
", 943, 109 }, { ret =3D 8 }
> -n none
> [11:02:08.064705355] edge-vb-u12 exit_syscall: { 0 }, { 1, 943, "whoopsie=
", 943, 109 }, 8
> -n all
> timestamp =3D 11:02:08.064705355, trace:hostname =3D edge-vb-u12, name =
=3D exit_syscall, stream.packet.context =3D { cpu_id =3D 0 }, stream.event.=
context =3D { ppid =3D 1, tid =3D 943, procname =3D "whoopsie", pid =3D 943=
, perf_major_faults =3D 109 }, event.fields =3D { ret =3D 8 }
> =

> Now compare just the payload part:
> =

> -n scope
> event.fields =3D 8
> -n payload
> { ret =3D 8 }
> -n none
> 8
> -n all
> event.fields =3D { ret =3D 8 }
> =

> It turns out the payload is bracketed by {} except when it has size zero =
or one and its contents are unlabelled.  Indeed, with an empty payload I ca=
n get a trailing "{ }" or "" (that is to say, the record ends with a comma)=
 depending on the labelling.  However, notice that for the stream.packet.co=
ntext this does not happen, maybe because the underlying structure has actu=
ally six fields instead of the lone one normally shown (you can get all six=
 printed using --verbose):
> =

> -n scope
> stream.packet.context =3D { 0 },
> -n payload
> { 0 },
> -n none
> { 0 },
> -n all
> stream.packet.context =3D { cpu_id =3D 0 },
> -v
> { timestamp_begin =3D 4196192044293, timestamp_end =3D 4196224429641, con=
tent_size =3D 2096768, packet_size =3D 2097152, events_discarded =3D 0, cpu=
_id =3D 0 },
> =

> This variability could make babeltrace's text output more difficult to pa=
rse than necessary, since one would have to handle the occasionally-disappe=
aring curly brackets.
> =

> Is this worth filing a bug over?

Yes, thanks,

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
> Qu=E9bec, QC=A0 G3J 1X5
> CANADA
> Vox=A0: (418) 844-4000 x4245
> Fax=A0: (418) 844-4538
> NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada=A0/ Government of Canada
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
