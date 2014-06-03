From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: userspace-rcu on ARMv7 (Beagle Bone Black)
Date: Tue, 3 Jun 2014 18:33:29 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD359AF532__27618.5932606042$1401820590$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WrtWh-0001I3-IQ
 for lttng-dev@lists.lttng.org; Tue, 03 Jun 2014 14:33:41 -0400
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

   I've tried deploying userspace-rcu onto a bare, out-of-the-box Beagle Bo=
ne Black (running Angstrom GNU/Linux v2012.12 (Core edition) on kernel 3.8.=
13).  The dependencies seem to be all there (libc6 (2.4 vs. 2.16-r15), auto=
make (1.10 vs. 1.12.3-r2.1), libtool (2.2 vs. 2.4.2-r5)).

   The bootstrap and configure steps bring no surprises, with minor differe=
nces with respect to a Ubuntu deployment (BBB has gawk, Ubuntu has mawk; th=
e maximum command line length is 32 768 for BBB, 1 572 864 for Ubuntu; BBB =
is missing mt; BBB's gcc -static does not work; where Ubuntu checks for the=
 mfence instruction, BBB checks for the dmb instruction).

   The make step, however, seems to go into an infinite loop.  It invokes a=
utomake-1.12 --foreign, then config/missing --run autoconf, repeat.

   Anyone know why?  And how to fix it?

   (Using userspace-rcu-0.8.0-2)

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
