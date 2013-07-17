From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: lttng-tools: trace-kernel.c stutters?
Date: Wed, 17 Jul 2013 13:41:36 -0400
Message-ID: <20130717174135.GA25228__28704.4805860662$1374082949$gmane$org@Krystal>
References: <48CF5AC71E61DB46B70D0F388054EFFD1BE22E73@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UzVjN-0001Lk-Kb
	for lttng-dev@lists.lttng.org; Wed, 17 Jul 2013 13:41:43 -0400
Content-Disposition: inline
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD1BE22E73@VAL-E-02.valcartier.drdc-rddc.gc.ca>
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

Fixed by:

commit 91b23e997053fb552662f1ad07273f029e00d2e4
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Wed Jul 17 13:40:15 2013 -0400

    Cleanup: remove redundant assignment
    =

    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu

* Thibault, Daniel (Daniel.Thibault@drdc-rddc.gc.ca) wrote:
> lttng-tools-2.2.0\src\bin\lttng-sessiond\trace-kernel.c, lines 190-198:
> =

> 	case LTTNG_EVENT_FUNCTION:
> 		attr->instrumentation =3D LTTNG_KERNEL_KRETPROBE;
> 		attr->u.kretprobe.addr =3D ev->attr.probe.addr;
> 		attr->u.kretprobe.offset =3D ev->attr.probe.offset;
> 		attr->u.kretprobe.offset =3D ev->attr.probe.offset;
> 		strncpy(attr->u.kretprobe.symbol_name,
> 				ev->attr.probe.symbol_name, LTTNG_KERNEL_SYM_NAME_LEN);
> 		attr->u.kretprobe.symbol_name[LTTNG_KERNEL_SYM_NAME_LEN - 1] =3D '\0';
> 		break;
> =

>    Line 194 just repeats line 193.
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
