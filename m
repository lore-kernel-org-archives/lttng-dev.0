From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: lttngtop dependencies
Date: Tue, 21 Oct 2014 14:44:15 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD6207057A__25864.1360946514$1413902709$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1Xgafc-0004DL-Pa
 for lttng-dev@lists.lttng.org; Tue, 21 Oct 2014 10:44:23 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Currently, the lttngtop/README mentions only the following dependencies:

* gcc 3.2 or better
* libc6 development librairies (Debian : libc6, libc6-dev) (Fedora : glibc,=
 glibc)
* glib 2.22 or better development libraries (Debian : libglib2.0-0, libglib=
2.0-dev) (Fedora : glib2, glib2-devel)
* libpopt >=3D 1.13 development libraries (Debian : libpopt-dev) (Fedora : =
popt)
* ncurses development libraries (Debian : libncurses5-dev)
* babeltrace >=3D 1.2.0 development library

   However, since 19 October 2013 (http://git.lttng.org/?p=3Dlttngtop.git;a=
=3Dcommitdiff;h=3D16b22a0fe150f4923b9902e802bbf28bacce8d0e), lttngtop depen=
ds on lttng-tools (for lttng/lttng.h, lttng/lttngtop-helper.h and later hea=
ders, needed to handle live traces).  This must be added to the README (not=
 to mention any DEBIAN/control package files).

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Cent=
re
2459 route de la Bravoure
Qu=E9bec QC=A0 G3J 1X5
CANADA
Vox=A0: (418) 844-4000 x4245
Fax=A0: (418) 844-4538
NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada=A0| Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
