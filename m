From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Debian specific userspace RCU configure override
 (ARMv7 Beagle Bone Black)
Date: Thu, 12 Jun 2014 16:46:20 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD359C1188__45401.5228235677$1402591624$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1Wv88x-0001I1-7A
 for lttng-dev@lists.lttng.org; Thu, 12 Jun 2014 12:46:29 -0400
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

----------------------------------------------------------------------
> Date: Thu, 12 Jun 2014 13:51:06 +0000
>   Progress on this front.  I did one thing: I edited userspace-rcu/urcu/a=
rch/arm.h to comment =

>out the #ifdef CONFIG_RCU_ARM_HAVE_DMB defines so that userspace-rcu build=
s "dmb-less".  =

>Once rebuilt and re-installed, I can then move on to try lttng-tools again=
, and this time it passes =

>the rculfhash.lo step.  It dies much later for a completely unrelated reas=
on which I expect to fix =

>shortly.  At this point I also expect a rebuild of lttng-ust would succeed.

   Turns out this new make error is obscure (only 8 hits in Google, 3 of wh=
ich are in Chinese).

make[5]: Entering directory '/usr/src/lttng-tools-2.3.0/src/lib/lttng-ctl/f=
ilter'
  LEX      filter-lexer.c
flex: fatal internal error, exec failed
make[5]: *** [filter-lexer.c] Error 141

   It turns out /usr/bin/flex is unusable on the BBB's Angstrom distributio=
n!  It is only runnable in calls like 'flex --help' or 'flex --version'.  A=
s soon as you try to process any .l file, it will choke with an error 141. =
 This is because /usr/bin/flex uses a hard-wired reference to the m4 execut=
able where it lay on the machine where the Angstrom image was cross-compile=
d!  (Thanks to Rob Clark for finding this out, http://gstreamer-devel.96612=
5.n4.nabble.com/Installation-error-td969071.html)  The ugly but simple fix =
is to create a symbolic link at the place flex looks for m4:

# mkdir -p /build/v2012.12/build/tmp-angstrom_v2012_12-eglibc/sysroots/x86_=
64-linux/usr/bin
# ln -s /usr/bin/m4 /build/v2012.12/build/tmp-angstrom_v2012_12-eglibc/sysr=
oots/x86_64-linux/usr/bin/m4

   Equivalently, invocations of flex must be preceded by setting the enviro=
nment variable M4 =3D /usr/bin/m4.  Which is what userspace-rcu must someho=
w do to actually install without tripping over this bug.

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
Gouvernement du Canada | Government of Canada <http://www.valcartier.drdc-r=
ddc.gc.ca/>
