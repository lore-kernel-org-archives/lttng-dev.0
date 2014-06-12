From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Debian specific userspace RCU configure override
 (ARMv7 Beagle Bone Black)
Date: Thu, 12 Jun 2014 13:51:06 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD359C1140__4654.98484340987$1402581114$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1Wv5PM-0000D8-G0
 for lttng-dev@lists.lttng.org; Thu, 12 Jun 2014 09:51:15 -0400
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

>   Recall that building lttng-ust on a Beagle Bone Black (Angstrom GNU/Lin=
ux v2012.12 (Core edition) on kernel 3.8.13), =

>the make fails at the CCLD of libringbuffer_la-ring_buffer_frontend.lo wit=
h an unexpected (and so far unexplained) =

>group of "Error: selected processor does not support ARM mode 'dmb'" (25 t=
imes).
>
> [...]
>   At this point I can only try lttng-tools in its "kernel tracing only" m=
ode.  [...]
>
>   I run into trouble quickly, however.  The CC of common/hashtable/rculfh=
ash.lo runs into "Error: selected processor =

>does not support ARM mode 'dmb'" (8 times).  The make aborts at this point.

   Progress on this front.  I did one thing: I edited userspace-rcu/urcu/ar=
ch/arm.h to comment out the #ifdef CONFIG_RCU_ARM_HAVE_DMB defines so that =
userspace-rcu builds "dmb-less".  Once rebuilt and re-installed, I can then=
 move on to try lttng-tools again, and this time it passes the rculfhash.lo=
 step.  It dies much later for a completely unrelated reason which I expect=
 to fix shortly.  At this point I also expect a rebuild of lttng-ust would =
succeed.

   So it looks like the problem is that the makefiles of lttng-tools and lt=
tng-ust somehow impose too strong an architecture constraint on their linke=
r (i.e. dmb-less generic ARM instead of ARMv7 with dmb).

   I hope this helps.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC) Cyber s=E9curit=E9 pour les missions essentielles (CME) =
| Mission Critical Cyber Security (MCCS) RDDC - Centre de recherches de Val=
cartier | DRDC - Valcartier Research Centre
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada <http://www.valcartier.drdc-r=
ddc.gc.ca/>
