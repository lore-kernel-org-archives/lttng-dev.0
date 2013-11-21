From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: make a trace_event in a module (driver)
Date: Thu, 21 Nov 2013 14:23:08 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267A5634__4138.16733421317$1385043853$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VjVA2-00015X-2g
	for lttng-dev@lists.lttng.org; Thu, 21 Nov 2013 09:23:18 -0500
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
List-Id: lttng-dev@lists.lttng.org

> Date: Thu, 21 Nov 2013 10:48:59 +0100
> From: Klaus Dannecker <klaus.dannecker@gmx.de>
>
> now i have ubuntu 13.10 installed  in a vmware.
> but i have the same error!
>
>$ sudo make modules_install
> make -C /lib/modules/3.11.0-12-generic/build =

> M=3D/home/klaus/lttng_src/lttng-modules modules_install
> make[1]: Entering directory `/usr/src/linux-headers-3.11.0-12-generic'
>   INSTALL /home/klaus/lttng_src/lttng-modules/lib/lttng-lib-ring-buffer.ko
> Can't read private key
> ....
> lsmod | grep lttng
> -> no module found

   This seems to be a problem with Ubuntu 13, which now requires kernel mod=
ules to be signed (or is this a kernel 3.8.5 feature/requirement?).  It is =
surprisingly hard to find a simple workaround on the Web (I gave up after a=
 while).  Some threads seem to indicate the error can be ignored, so it may=
 just be a matter of making sure the 'make modules_install' doesn't give up=
 at that point.  Another possibility may be to install the kernel's "Linux =
Kernel Archives Verification Key" GPG key (see e.g. http://alien.slackbook.=
org/dokuwiki/doku.php?id=3Dlinux:kernelbuilding): 'gpg --keyserver wwwkeys.=
pgp.net --recv-keys 0x517D0F0E'

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
