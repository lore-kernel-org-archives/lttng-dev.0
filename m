From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: LTTV build failure in ubuntu 12.04
Date: Tue, 3 Dec 2013 13:23:29 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267B25FA__33959.9879495383$1386077059$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1Vnpx0-0000oZ-AQ
	for lttng-dev@lists.lttng.org; Tue, 03 Dec 2013 08:23:44 -0500
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: Aananth CN <c.n.aananth@gmail.com>
List-Id: lttng-dev@lists.lttng.org

Date: Mon, 25 Nov 2013 22:22:01 +0530
From: Aananth CN <c.n.aananth@gmail.com>

> I could not find lttv (viewer) on ubuntu, hence I built from source. I get
> following error. Could you please help me resolving this issue? (Am I
> missing something, should I install any other packages?)

lttv

Depends: automake (>=3D 1.10), gcc (>=3D 3.2), libtool (>=3D 2.2), libgtk2.=
0-dev (>=3D 2.4), libglib2.0-dev (>=3D 2.16), libpopt-dev (>=3D 1.14), libp=
ango1.0-dev (>=3D 1.20), libc6-dev (>=3D 2.4), babeltrace (>=3D 1.0.0)

Suggests: libglpk-dev, default-jdk

./bootstrap 2>&1 | tee bootstrap.log
LDFLAGS=3D-L/usr/local/lib ./configure 2>&1 | tee configure.log
make 2>&1 | tee make.log
make install 2>&1 | tee install.log
ldconfig

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
