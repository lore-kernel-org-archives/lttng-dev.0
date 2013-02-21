From: Julien Desfossez <julien.desfossez@polymtl.ca>
Subject: Re: Typo in lttngtop.c
Date: Thu, 21 Feb 2013 15:21:31 -0500
Message-ID: <512681CB.2060508__40774.425402242$1361478143$gmane$org@polymtl.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD01C763@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([93.20.26.243])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <julien.desfossez@polymtl.ca>) id 1U8ceC-0006Gg-I0
	for lttng-dev@lists.lttng.org; Thu, 21 Feb 2013 15:21:40 -0500
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD01C763@VAL-E-01.valcartier.drdc-rddc.gc.ca>
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

On 13-02-21 03:07 PM, Thibault, Daniel wrote:
> check_field_requirements() reads in part:
> =

> if (*tid_check =3D=3D 0) {
> 	if (strncmp(name, "tid", 3) =3D=3D 0)
> 		(*tid_check)++;
> }
> if (*pid_check =3D=3D 0) {
> 	if (strncmp(name, "tid", 3) =3D=3D 0)
> 		(*pid_check)++;
> }
> =

>    Shouldn't that second if check for "pid" instead of "tid"?
Indeed.
Fixed in master and live branches.

Thanks,

Julien

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
> =
