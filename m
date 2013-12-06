From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: No trace files are generated for UST
Date: Fri, 6 Dec 2013 14:48:51 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267B2DCF__19873.0944925503$1386341389$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
References: <6CFA219DE9CAD940989B83CA579159F91B43ACBFBE@SGSINEXC014.vestas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1Vowi3-0002qk-LS
	for lttng-dev@lists.lttng.org; Fri, 06 Dec 2013 09:48:56 -0500
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Manikandan Govindaswamy <magov@vestas.com>, =?iso-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

If:

$ gcc -o sample sample.o tp.o -ldl -llttng-ust

Fails with "error: cannot find -llttng-ust", then do this instead:

$ gcc -o sample sample.o tp.o -L/usr/local/lib -ldl -llttng-ust

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC) Cyber s=E9curit=E9 pour les missions essentielles (CME) =
| Mission Critical Cyber Security (MCCS) R & D pour la d=E9fense Canada - V=
alcartier (RDDC Valcartier) | Defence R&D Canada - Valcartier (DRDC Valcart=
ier)
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada <http://www.valcartier.drdc-r=
ddc.gc.ca/>
