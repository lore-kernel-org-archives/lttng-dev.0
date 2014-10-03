From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: ARMv7 Beagle Bone Black and the dmb instruction
Date: Fri, 3 Oct 2014 15:30:57 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD512311B3__48483.3516217352$1412350318$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1Xa4ox-0003Jd-O6
 for lttng-dev@lists.lttng.org; Fri, 03 Oct 2014 11:31:08 -0400
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

   This is a return to an issue first mentioned here in June 2014 ("Debian =
specific userspace RCU configure override (ARMv7 Beagle Bone Black)").

   I'm trying to install TTng on an ARMv7 Beagle Bone Black.  Lttng-modules=
 "installs" but adds nothing because the kernel has no CONFIG_TRACEPOINTS f=
lag.  So this will be a pure user-space installation.  Userspace-rcu instal=
ls without trouble, although I note that its configure log states "checking=
 for dmb instruction... yes".  Lttng-ust, however, fails completely to inst=
all.  I note that its configure log makes no mention of a dmb instruction -=
an omission?

   The make fails at /usr/src/lttng-ust-2.5.0/libringbuffer/libringbuffer_l=
a-ring_buffer_frontend.lo

CC libringbuffer_la-ring_buffer_frontend.lo
/tmp/ccsyYAoj.s: Assembler messages:
/tmp/ccsyYAoj.s:2678: Error: selected processor does not support ARM mode `=
dmb'
/tmp/ccsyYAoj.s:2692: Error: selected processor does not support ARM mode `=
dmb'
/tmp/ccsyYAoj.s:2725: Error: selected processor does not support ARM mode `=
dmb'
...
(22 more such errors)
...
Make[2]: *** [libringbuffer_la-ring_buffer_frontend.lo] Error 1

userspace-rcu is 0.8.0-64-(0.8.4-21)-718eb63
lttng-ust is 2.5.0-10-501f677

'Angstrom GNU/Linux v2012.12 (Core edition)' on kernel '3.8.13'.  No system=
tap, no Java or JNI.
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
