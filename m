From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Updated easy-ust Makefile
Date: Wed, 15 May 2013 20:34:07 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD12D17FE9__32501.4786365957$1368650151$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD028E81@VAL-E-01.valcartier.drdc-rddc.gc.ca>
	<20130510142534.GB20313@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UciPq-0000L6-Va
	for lttng-dev@lists.lttng.org; Wed, 15 May 2013 16:35:15 -0400
In-Reply-To: <20130510142534.GB20313@Krystal>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "jeremie.galarneau@efficios.com" <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>, "Painchaud,
	Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

-----Message d'origine-----
De=A0: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com] =

Envoy=E9=A0: 10 mai 2013 10:26

> Every problem related to your distribution not having /usr/local/lib in l=
d.so.conf by default should be handled by adding documentation to the proje=
ct, not modifying makefiles.
>
> Jeremie will take care of adding this info to the documentation.

   My understanding is that adding ' LDFLAGS =3D -L/usr/local/lib' to the c=
ompilation calls will make no difference on distributions that do include /=
usr/local/lib by default.  Ubuntu does not, so it needs that LDFLAGS in ord=
er for its unmodified makefile to succeed.  Since this simple addition brea=
ks no other distro (as far as I know), why not make lttng-ust/doc/examples/=
easy-ust more inclusive?

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
