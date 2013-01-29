From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: The disable-libtool-linkdep-fixup configure option
Date: Tue, 29 Jan 2013 11:34:00 -0500
Message-ID: <3CA1A65C03C1A34C81BBC6272782E6969BDD05__31591.4559564137$1359477314$gmane$org@valcartierex01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1U0E8f-0003zi-VA
	for lttng-dev@lists.lttng.org; Tue, 29 Jan 2013 11:34:26 -0500
Content-class: urn:content-classes:message
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: =?iso-8859-1?Q?Painchaud=2C_Fr=E9d=E9ric?= <Frederic.Painchaud@drdc-rddc.gc.ca>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

The git.lttng.org packages lttng-ust and lttng-tools have a configure optio=
n named disable-libtool-linkdep-fixup.  The 'linkdep fixup', if I understan=
d correctly, serves to fix a problem with the version of the libtool packag=
e used with Debian systems (and possibly others), as described in http://bu=
gs.lttng.org/issues/321.  The fixup in question consists of changing occurr=
ences of the 'link_all_deplibs=3Dno' flag in config/libtool.m4 to 'link_all=
_deplibs=3Dunknown' instead.

The default value of the option is 'yes' (re: configure.ac), which means th=
e fixup is applied.  Setting the option to another value, such as 'no', mea=
ns the fixup is not applied.

Why then is the option named *disable*-libtool-linkdep-fixup?  Shouldn't it=
 be named *enable*-libtool-linkdep-fixup instead?

Daniel U. Thibault
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)
Protection des syst=E8mes et contremesures (PSC) / Systems Protection & Cou=
ntermeasures (SPC)
2459 route de la Bravoure
Qu=E9bec, QC=A0 G3J 1X5
CANADA
Vox=A0: (418) 844-4000 x4245
Fax=A0: (418) 844-4538
NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada=A0/ Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
