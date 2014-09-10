From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Odd file and path in lttng-tools tarball
Date: Wed, 10 Sep 2014 20:14:56 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD4EC61B86__36640.514949295$1410380185$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1XRoII-0008Mk-Bf
 for lttng-dev@lists.lttng.org; Wed, 10 Sep 2014 16:15:16 -0400
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

   In the almost-current tarball for lttng-tools (2.5.0-rc2-93, 6e7241f) (c=
urrent version is 2.5.0-rc2-101, 883d80f), there is an odd file present, pr=
esumably a leftover from testing:

tests/regression/tools/save-load/ /tmp/tmp.eAJ1f0oCZE/test-42/save-42.lttng

   (Note the folder named ' ')

   Surely that does not belong?  It has been there since the 24 Mar 2014 e0=
2b109 commit (2.4.0-rc2-184).

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
