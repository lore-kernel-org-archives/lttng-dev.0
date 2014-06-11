From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Debian specific userspace RCU configure override
 (ARMv7 Beagle Bone Black)
Date: Wed, 11 Jun 2014 20:25:00 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD359C1035__37305.9296668091$1402518385$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1Wup5D-0002WD-F4
 for lttng-dev@lists.lttng.org; Wed, 11 Jun 2014 16:25:25 -0400
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

   Recall that building lttng-ust on a Beagle Bone Black (Angstrom GNU/Linu=
x v2012.12 (Core edition) on kernel 3.8.13), the make fails at the CCLD of =
libringbuffer_la-ring_buffer_frontend.lo with an unexpected (and so far une=
xplained) group of "Error: selected processor does not support ARM mode 'dm=
b'" (25 times).

   lttng-modules installs with no trouble once a few minor adjustments are =
made to the dependencies (turns out the linux-headers package is called ker=
nel-dev on the BBB).  The install is rather disappointing because the facto=
ry-supplied kernel has CONFIG_TRACEPOINTS turned off.  All the other requir=
ed/desirable kernel switches are turned on.

   userspace-rcu is also successfully installed.

   At this point I can only try lttng-tools in its "kernel tracing only" mo=
de.  Once again bootstrap and configure go smoothly.  It reports:

Target architecture: armv7l
Lttng-UST support: Disabled
Python binding: Disabled
All binaries will be built

   I run into trouble quickly, however.  The CC of common/hashtable/rculfha=
sh.lo runs into "Error: selected processor does not support ARM mode 'dmb'"=
 (8 times).  The make aborts at this point.

   How can this be fixed?  I'm open to "forcing" the Makefile at this point=
, as a stop-gap.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Cent=
re
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
