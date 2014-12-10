From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Errors compiling converted tp file
Date: Wed, 10 Dec 2014 15:51:16 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD6FBE18D6__43799.8840272941$1418226719$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1XyjXv-00037I-8p
 for lttng-dev@lists.lttng.org; Wed, 10 Dec 2014 10:51:24 -0500
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
Cc: Yan Grange <ygrange@gmail.com>
List-Id: lttng-dev@lists.lttng.org

----------------------------------------------------------------------
Date: Wed, 10 Dec 2014 16:16:06 +0100

> Thanks for that.  I have asked our sysadmin to install a newer version vi=
a this method. Even though he gets several severe-lloking errors in this pr=
ocess
>
> $ apt-get install liblttng-ust-dev
>
> Building initial module for 3.2.0-61-generic
> Errors were encountered while processing:
>  lttng-modules-dkms
>  Error!  Build of lttng-probe-printk.ko failed for: 3.2.0-61-generic (x86=
_64)
>
> In the make log, we find the following three lines:
>
> /var/lib/dkms/lttng-modules/2.5.x+stable+bzr633+pack21+201412020446~ubunt=
u12.04.1/build/probes/Makefile:30: File /usr/src/linux-headers-3.2.0-61-gen=
eric/virt/kvm/iodev.h not found. Probe "kvm" x86-specific is disabled. Use =
full kernel source tree to enable it.
> /var/lib/dkms/lttng-modules/2.5.x+stable+bzr633+pack21+201412020446~ubunt=
u12.04.1/build/probes/Makefile:142: Files /usr/src/linux-headers-3.2.0-61-g=
eneric/fs/btrfs/*.h not found. Probe "btrfs" is disabled. Use full kernel s=
ource tree to enable it.
> /var/lib/dkms/lttng-modules/2.5.x+stable+bzr633+pack21+201412020446~ubunt=
u12.04.1/build/probes/Makefile:158: Files /usr/src/linux-headers-3.2.0-61-g=
eneric/fs/ext4/*.h not found. Probe "ext4" is disabled. Use full kernel sou=
rce tree to enable it.
>
> The full kernel source tree is already installed. =


   Those three errors are inconsequential; they simply mean your kernel doe=
s not support kvm nor the btrfs and ext4 file systems (a common occurrence).

> However it actually works to create a header file from a tp file and comp=
ile (and run) the code. However I now get in trouble when executing:
>
> $ lttng list --userspace
> Error: Unable to list UST events: Undefined command
> Error: Command error
>
> So I guess something still went somewhat wrong but I can't really see wha=
t.
>
> Yan Grange

   In order to trace user-space, you must install, in sequence, the followi=
ng packages: userspace-rcu, lttng-ust, lttng-tools.  Was this done?

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
