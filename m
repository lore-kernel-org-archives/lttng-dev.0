From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: The disable-libtool-linkdep-fixup configure option
Date: Tue, 29 Jan 2013 12:20:59 -0500
Message-ID: <3CA1A65C03C1A34C81BBC6272782E6969BDD0C__14734.9101877355$1359480125$gmane$org@valcartierex01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1U0Es7-0004OT-Ta
	for lttng-dev@lists.lttng.org; Tue, 29 Jan 2013 12:21:24 -0500
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

> > The default value of the option is 'yes' (re: configure.ac), which mean=
s the fixup is applied.  Setting the option to another value, such as 'no',=
 means the fixup is not applied.
> > Why then is the option named *disable*-libtool-linkdep-fixup?  Shouldn'=
t it be named *enable*-libtool-linkdep-fixup instead?
>
>Because the option is enabled by default on all systems. This is to facili=
tate cross-compilation on Debian/Ubuntu systems.
>
> Christian

If you had to compare the following two command lines, which one would you =
say disabled the fixup?

./configure --disable-libtool-linkdep-fixup=3Dyes
./configure --disable-libtool-linkdep-fixup=3Dno

The first line is the current default, and it leaves the fixup enabled (rig=
ht?).  That's why I suspect enable-libtool-linkdep-fixup would be a more me=
aningful name.

Daniel U. Thibault
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)
Protection des syst=E8mes et contremesures (PSC) / Systems Protection & Cou=
ntermeasures (SPC)
2459 route de la Bravoure
Qu=E9bec, QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada / Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
