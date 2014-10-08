From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: lttng-modules on Debian Wheezy BeagleBone Black
	rev. C
Date: Wed, 8 Oct 2014 21:09:09 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD5A23A947__224.642645525996$1412802590$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1XbyTz-0001Kz-9r
 for lttng-dev@lists.lttng.org; Wed, 08 Oct 2014 17:09:16 -0400
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

> arch/include/asm has a time.h but no timex.h.

   Correction:

   arch/arm/include/asm/mach has a time.h but no timex.h.

   Googling around, it seems the missing timex.h can either be ignored (by =
creating an empty file in the expected spot), or recovered from the full ke=
rnel source tree, at arch/arm/mach-<processor>/include/mach.  My problem is=
 identifying the correct one, if any.  Uname -i and uname -p both return 'u=
nknown' for the BeagleBone Black (while running Debian Wheezy, anyway).

   These files seem to serve mostly to #define the CLOCK_TICK_RATE, with va=
lues such as 512000, 1000000 and 38000000, 40000000.  Some mach-<processor>=
 directories do not have an include sub-directory.  Other mach-<processor> =
cases comment the CLOCK_TICK_RATE value as 'bogus'.  I'll try to resolve th=
is tomorrow.

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
Gouvernement du Canada=A0| Government of Canada <http://www.valcartier.drdc=
-rddc.gc.ca/>
