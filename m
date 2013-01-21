From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Odd dependency for lttng-ust
Date: Mon, 21 Jan 2013 09:52:55 -0500
Message-ID: <3CA1A65C03C1A34C81BBC6272782E696987880__11162.7368409701$1358780039$gmane$org@valcartierex01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1TxIkN-0002iU-Vp
	for lttng-dev@lists.lttng.org; Mon, 21 Jan 2013 09:53:16 -0500
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

I'm starting from a clean Ubuntu 12.04 installation after adding the variou=
s prerequisites of the git.lttng.org LTTng 2 packages:

LTTng 2 Packages (in the proper dependency order):

lttng-modules (2.1.0+-c6403de)
userspace-rcu (0.7.6-da9bed2)
lttng-ust (2.1.0+-340f776)
lttng-tools (2.1.1+-281047b)

Prerequisites installed:

automake
binutils-gold
bison
flex
libpopt-dev
libtool
libuuid1
python-dev
swig2.0
kernel's headers (i.e. linux-headers-generic)
texinfo
g++

After making and installing lttng-modules and userspace-rcu successfully, l=
ttng-ust's configure fails with:

checking for _cds_lfht_new in -lurcu-cds... no
configure: error: Cannot find
liburcu-cds lib, part of Userspace RCU 0.7 or better.

This occurs even though userspace-rcu installed /usr/local/lib/liburcu-cds.=
  It seems I must install liburcu-dev from the LTTng PPA (because the curre=
nt Ubuntu liburcu-dev is 0.6.7 while lttng-ust requires 0.7 or better) befo=
re I can configure lttng-ust properly.  This is a weird bootstrapping probl=
em: could the userspace-rcu package's install be incomplete?

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
