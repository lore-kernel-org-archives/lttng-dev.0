From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: lttng-modules on Debian Wheezy BeagleBone Black rev. C
Date: Wed, 8 Oct 2014 18:00:53 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD5A23A900__39990.4936472469$1412791335$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1XbvXo-0000B7-7Y
 for lttng-dev@lists.lttng.org; Wed, 08 Oct 2014 14:01:08 -0400
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

   The BeagleBone Black rev. C boards come with Debian Wheezy installed (ke=
rnel 3.8.13-bone47, distro 'Debian GNU/Linux 7.4 (wheezy)').  The linux-hea=
ders are not supplied, but I found them at http://rcn-ee.net/deb/wheezy-arm=
hf/v3.8.13-bone47/linux-headers-3.8.13-bone47_1.0wheezy_armhf.deb.  Compila=
tion of lttng-modules (2.5.0-9-ac2440f) runs into a problem on its very fir=
st compilation, however.

  CC [M]  /usr/src/lttng-modules-2.5.0/lttng-ring-buffer-client-discard.o
In file included from include/linux/timex.h:65:0,
                 from include/linux/jiffies.h:8,
                 from include/linux/ktime.h:25,
                 from include/linux/timer.h:5,
                 from include/linux/workqueue.h:8,
                 from include/linux/srcu.h:34,
                 from include/linux/notifier.h:15,
                 from include/linux/memory_hotplug.h:6,
                 from include/linux/mmzone.h:761,
                 from include/linux/gfp.h:4,
                 from include/linux/kmod.h:22,
                 from include/linux/module.h:13,
                 from /usr/src/lttng-modules-2.5.0/lttng-ring-buffer-client=
-discard.c:23:
/usr/src/linux-headers-3.8.13-bone47/arch/include/asm/timex.h:18:24: fatal =
error: mach/timex.h: No such file or directory

   arch/include/asm has a time.h but no timex.h.

   Please advise.

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
