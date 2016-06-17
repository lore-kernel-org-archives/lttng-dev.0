From: Ravi Inder Singh <raviinder@gmail.com>
Subject: In Redhat 7.1 kmod-lttng-modules is not installed
Date: Fri, 17 Jun 2016 08:53:25 -0400
Message-ID: <CA+=s6Bag3Pz6FkbLAmu2BEC_wbpC1ON=qrjvF=G6iVdd1N8NyQ__5350.98954937911$1466168051$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7592484539028982212=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
 [209.85.161.181])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 1380EA33F5
 for <lttng-dev@lists.lttng.org>; Fri, 17 Jun 2016 12:53:46 +0000 (UTC)
Received: by mail-yw0-f181.google.com with SMTP id z186so70516805ywd.2
 for <lttng-dev@lists.lttng.org>; Fri, 17 Jun 2016 05:53:46 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============7592484539028982212==
Content-Type: multipart/alternative; boundary=94eb2c0649b249cce3053578d8d2

--94eb2c0649b249cce3053578d8d2
Content-Type: text/plain; charset=UTF-8

Hi all,
1)
RHEL 7.1 OS version is :-

*****************************************************************8
cat /etc/*release
NAME="Red Hat Enterprise Linux Workstation"
VERSION="7.1 (Maipo)"
ID="rhel"
ID_LIKE="fedora"
VERSION_ID="7.1"
PRETTY_NAME="Red Hat Enterprise Linux Workstation 7.1 (Maipo)"
ANSI_COLOR="0;31"
CPE_NAME="cpe:/o:redhat:enterprise_linux:7.1:GA:workstation"
HOME_URL="https://www.redhat.com/"
BUG_REPORT_URL="https://bugzilla.redhat.com/"
*********************************************************************
2)  I installed everything but when i start kernel tracer it throws me
error "Kernel Tracer not available"


 lttng enable-event --kernel allError: Event all: Kernel tracer not
available (channel channel0, session auto-20160616-165319)


Issue i beleive is while installing kernel modules it give me following
warnings.
Here is output.


root # yum install  kmod-lttng-modules
Loaded plugins: langpacks, product-id, subscription-manager
This system is not registered to Red Hat Subscription Management. You can
use subscription-manager to register.
Resolving Dependencies
--> Running transaction check
---> Package kmod-lttng-modules.x86_64 0:2.8.0-1.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================================================================================================================
 Package                                       Arch
     Version                                 Repository
                   Size
================================================================================================================================================================================
Installing:
 kmod-lttng-modules                            x86_64
     2.8.0-1.el7                             EfficiOS-RHEL7-x86-64
                   281 k

Transaction Summary
================================================================================================================================================================================
Install  1 Package

Total download size: 281 k
Installed size: 2.5 M
Is this ok [y/d/N]: y
Downloading packages:
kmod-lttng-modules-2.8.0-1.el7.x86_64.rpm

 | 281 kB  00:00:00
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : kmod-lttng-modules-2.8.0-1.el7.x86_64

                     1/1
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-kvm.ko
needs unknown symbol lttng_probe_unregister
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-kvm.ko
needs unknown symbol lttng_probe_register
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-kvm.ko
needs unknown symbol lttng_pid_tracker_lookup
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-sock.ko
needs unknown symbol lttng_probe_unregister
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-sock.ko
needs unknown symbol lttng_probe_register
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-sock.ko
needs unknown symbol lttng_pid_tracker_lookup
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-metadata-client.ko
needs unknown symbol lttng_transport_unregister
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-metadata-client.ko
needs unknown symbol lttng_transport_register
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-printk.ko
needs unknown symbol lttng_probe_unregister
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-printk.ko
needs unknown symbol lttng_probe_register
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-printk.ko
needs unknown symbol lttng_pid_tracker_lookup
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-napi.ko
needs unknown symbol lttng_probe_unregister
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-napi.ko
needs unknown symbol lttng_probe_register
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-napi.ko
needs unknown symbol lttng_pid_tracker_lookup
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-client-mmap-discard.ko
needs unknown symbol lttng_transport_unregister
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-client-mmap-discard.ko
needs unknown symbol lttng_transport_register
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-kmem.ko
needs unknown symbol lttng_probe_unregister
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-kmem.ko
needs unknown symbol lttng_probe_register
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-kmem.ko
needs unknown symbol lttng_pid_tracker_lookup
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-compaction.ko
needs unknown symbol lttng_probe_unregister
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-compaction.ko
needs unknown symbol lttng_probe_register
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-compaction.ko
needs unknown symbol lttng_pid_tracker_lookup
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-client-overwrite.ko
needs unknown symbol lttng_transport_unregister
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-client-overwrite.ko
needs unknown symbol lttng_transport_register
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-client-mmap-overwrite.ko
needs unknown symbol lttng_transport_unregister
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-client-mmap-overwrite.ko
needs unknown symbol lttng_transport_register
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-x86-exceptions.ko
needs unknown symbol lttng_probe_unregister
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-x86-exceptions.ko
needs unknown symbol lttng_probe_register
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-x86-exceptions.ko
needs unknown symbol lttng_pid_tracker_lookup
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-sunrpc.ko
needs unknown symbol lttng_probe_unregister
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-sunrpc.ko
needs unknown symbol lttng_probe_register
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-sunrpc.ko
needs unknown symbol lttng_pid_tracker_lookup
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-signal.ko
needs unknown symbol lttng_probe_unregister
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-signal.ko
needs unknown symbol lttng_probe_register
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-signal.ko
needs unknown symbol lttng_pid_tracker_lookup
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-module.ko
needs unknown symbol lttng_probe_unregister
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-module.ko
needs unknown symbol lttng_probe_register
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-module.ko
needs unknown symbol lttng_pid_tracker_lookup
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-client-discard.ko
needs unknown symbol lttng_transport_unregister
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-client-discard.ko
needs unknown symbol lttng_transport_register
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-timer.ko
needs unknown symbol lttng_probe_unregister
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-timer.ko
needs unknown symbol lttng_probe_register
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-timer.ko
needs unknown symbol lttng_pid_tracker_lookup
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-net.ko
needs unknown symbol lttng_probe_unregister
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-net.ko
needs unknown symbol lttng_probe_register
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-net.ko
needs unknown symbol lttng_pid_tracker_lookup
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/tests/probes/lttng-test.ko
needs unknown symbol lttng_probe_unregister
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/tests/probes/lttng-test.ko
needs unknown symbol lttng_probe_register
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/tests/probes/lttng-test.ko
needs unknown symbol lttng_pid_tracker_lookup
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-writeback.ko
needs unknown symbol lttng_probe_unregister
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-workqueue.ko
needs unknown symbol lttng_pid_tracker_lookup
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-irq.ko
needs unknown symbol lttng_probe_unregister
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-irq.ko
needs unknown symbol lttng_probe_register
depmod: WARNING:
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-irq.ko
needs unknown symbol lttng_pid_tracker_lookup
  Verifying  : kmod-lttng-modules-2.8.0-1.el7.x86_64

                     1/1

Installed:
  kmod-lttng-modules.x86_64 0:2.8.0-1.el7



Complete!

--94eb2c0649b249cce3053578d8d2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi all,=C2=A0</div><div>1)=C2=A0</div>RHEL 7.1 OS ver=
sion is :-=C2=A0<div><div><br></div><div>**********************************=
*******************************8</div><div>cat /etc/*release=C2=A0</div><di=
v>NAME=3D&quot;Red Hat Enterprise Linux Workstation&quot;</div><div>VERSION=
=3D&quot;7.1 (Maipo)&quot;</div><div>ID=3D&quot;rhel&quot;</div><div>ID_LIK=
E=3D&quot;fedora&quot;</div><div>VERSION_ID=3D&quot;7.1&quot;</div><div>PRE=
TTY_NAME=3D&quot;Red Hat Enterprise Linux Workstation 7.1 (Maipo)&quot;</di=
v><div>ANSI_COLOR=3D&quot;0;31&quot;</div><div>CPE_NAME=3D&quot;cpe:/o:redh=
at:enterprise_linux:7.1:GA:workstation&quot;</div><div>HOME_URL=3D&quot;<a =
href=3D"https://www.redhat.com/">https://www.redhat.com/</a>&quot;</div><di=
v>BUG_REPORT_URL=3D&quot;<a href=3D"https://bugzilla.redhat.com/">https://b=
ugzilla.redhat.com/</a>&quot;</div><div>***********************************=
**********************************</div><div>2) =C2=A0I installed everythin=
g but when i start kernel tracer it throws me error &quot;Kernel Tracer not=
 available&quot;</div><div><br></div><div><br></div><div>=C2=A0lttng enable=
-event --kernel allError: Event all: Kernel tracer not available (channel c=
hannel0, session auto-20160616-165319)<br></div><div><br></div><div><br></d=
iv><div>Issue i beleive is while installing kernel modules it give me follo=
wing warnings.=C2=A0</div><div>Here is output.=C2=A0</div></div><div><br></=
div><div><br></div><div><div>root # yum install =C2=A0kmod-lttng-modules</d=
iv><div>Loaded plugins: langpacks, product-id, subscription-manager</div><d=
iv>This system is not registered to Red Hat Subscription Management. You ca=
n use subscription-manager to register.</div><div>Resolving Dependencies</d=
iv><div>--&gt; Running transaction check</div><div>---&gt; Package kmod-ltt=
ng-modules.x86_64 0:2.8.0-1.el7 will be installed</div><div>--&gt; Finished=
 Dependency Resolution</div><div><br></div><div>Dependencies Resolved</div>=
<div><br></div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D</div><div>=C2=A0Package =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Arch =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Versio=
n =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Repository =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Size</div><div>=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>Inst=
alling:</div><div>=C2=A0kmod-lttng-modules =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x86_64 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A02.8.0-1.el7 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EfficiOS-RHEL7-=
x86-64 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0281 k</div><div><br></div><div>Transaction S=
ummary</div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D</div><div>Install =C2=A01 Package</div><div><br></div=
><div>Total download size: 281 k</div><div>Installed size: 2.5 M</div><div>=
Is this ok [y/d/N]: y</div><div>Downloading packages:</div><div>kmod-lttng-=
modules-2.8.0-1.el7.x86_64.rpm =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 281 kB =C2=A000:00=
:00 =C2=A0 =C2=A0=C2=A0</div><div>Running transaction check</div><div>Runni=
ng transaction test</div><div>Transaction test succeeded</div><div>Running =
transaction</div><div>=C2=A0 Installing : kmod-lttng-modules-2.8.0-1.el7.x8=
6_64 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01/1=C2=A0</div><div>=
depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modu=
les/probes/lttng-probe-kvm.ko needs unknown symbol lttng_probe_unregister</=
div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/l=
ttng-modules/probes/lttng-probe-kvm.ko needs unknown symbol lttng_probe_reg=
ister</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-up=
dates/lttng-modules/probes/lttng-probe-kvm.ko needs unknown symbol lttng_pi=
d_tracker_lookup</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86=
_64/weak-updates/lttng-modules/probes/lttng-probe-sock.ko needs unknown sym=
bol lttng_probe_unregister</div><div>depmod: WARNING: /lib/modules/3.10.0-2=
29.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-sock.ko needs u=
nknown symbol lttng_probe_register</div><div>depmod: WARNING: /lib/modules/=
3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-sock.ko=
 needs unknown symbol lttng_pid_tracker_lookup</div><div>depmod: WARNING: /=
lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buf=
fer-metadata-client.ko needs unknown symbol lttng_transport_unregister</div=
><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttn=
g-modules/lttng-ring-buffer-metadata-client.ko needs unknown symbol lttng_t=
ransport_register</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x8=
6_64/weak-updates/lttng-modules/probes/lttng-probe-printk.ko needs unknown =
symbol lttng_probe_unregister</div><div>depmod: WARNING: /lib/modules/3.10.=
0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-printk.ko ne=
eds unknown symbol lttng_probe_register</div><div>depmod: WARNING: /lib/mod=
ules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-pr=
intk.ko needs unknown symbol lttng_pid_tracker_lookup</div><div>depmod: WAR=
NING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/=
lttng-probe-napi.ko needs unknown symbol lttng_probe_unregister</div><div>d=
epmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modul=
es/probes/lttng-probe-napi.ko needs unknown symbol lttng_probe_register</di=
v><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/ltt=
ng-modules/probes/lttng-probe-napi.ko needs unknown symbol lttng_pid_tracke=
r_lookup</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak=
-updates/lttng-modules/lttng-ring-buffer-client-mmap-discard.ko needs unkno=
wn symbol lttng_transport_unregister</div><div>depmod: WARNING: /lib/module=
s/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-client=
-mmap-discard.ko needs unknown symbol lttng_transport_register</div><div>de=
pmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-module=
s/probes/lttng-probe-kmem.ko needs unknown symbol lttng_probe_unregister</d=
iv><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lt=
tng-modules/probes/lttng-probe-kmem.ko needs unknown symbol lttng_probe_reg=
ister</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-up=
dates/lttng-modules/probes/lttng-probe-kmem.ko needs unknown symbol lttng_p=
id_tracker_lookup</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x8=
6_64/weak-updates/lttng-modules/probes/lttng-probe-compaction.ko needs unkn=
own symbol lttng_probe_unregister</div><div>depmod: WARNING: /lib/modules/3=
.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-compacti=
on.ko needs unknown symbol lttng_probe_register</div><div>depmod: WARNING: =
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-=
probe-compaction.ko needs unknown symbol lttng_pid_tracker_lookup</div><div=
>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-mod=
ules/lttng-ring-buffer-client-overwrite.ko needs unknown symbol lttng_trans=
port_unregister</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_=
64/weak-updates/lttng-modules/lttng-ring-buffer-client-overwrite.ko needs u=
nknown symbol lttng_transport_register</div><div>depmod: WARNING: /lib/modu=
les/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-clie=
nt-mmap-overwrite.ko needs unknown symbol lttng_transport_unregister</div><=
div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-=
modules/lttng-ring-buffer-client-mmap-overwrite.ko needs unknown symbol ltt=
ng_transport_register</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el=
7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-x86-exceptions.ko ne=
eds unknown symbol lttng_probe_unregister</div><div>depmod: WARNING: /lib/m=
odules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-=
x86-exceptions.ko needs unknown symbol lttng_probe_register</div><div>depmo=
d: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/p=
robes/lttng-probe-x86-exceptions.ko needs unknown symbol lttng_pid_tracker_=
lookup</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-u=
pdates/lttng-modules/probes/lttng-probe-sunrpc.ko needs unknown symbol lttn=
g_probe_unregister</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x=
86_64/weak-updates/lttng-modules/probes/lttng-probe-sunrpc.ko needs unknown=
 symbol lttng_probe_register</div><div>depmod: WARNING: /lib/modules/3.10.0=
-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-sunrpc.ko nee=
ds unknown symbol lttng_pid_tracker_lookup</div><div>depmod: WARNING: /lib/=
modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe=
-signal.ko needs unknown symbol lttng_probe_unregister</div><div>depmod: WA=
RNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes=
/lttng-probe-signal.ko needs unknown symbol lttng_probe_register</div><div>=
depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modu=
les/probes/lttng-probe-signal.ko needs unknown symbol lttng_pid_tracker_loo=
kup</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-upda=
tes/lttng-modules/probes/lttng-probe-module.ko needs unknown symbol lttng_p=
robe_unregister</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_=
64/weak-updates/lttng-modules/probes/lttng-probe-module.ko needs unknown sy=
mbol lttng_probe_register</div><div>depmod: WARNING: /lib/modules/3.10.0-22=
9.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-module.ko needs =
unknown symbol lttng_pid_tracker_lookup</div><div>depmod: WARNING: /lib/mod=
ules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-cli=
ent-discard.ko needs unknown symbol lttng_transport_unregister</div><div>de=
pmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-module=
s/lttng-ring-buffer-client-discard.ko needs unknown symbol lttng_transport_=
register</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak=
-updates/lttng-modules/probes/lttng-probe-timer.ko needs unknown symbol ltt=
ng_probe_unregister</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.=
x86_64/weak-updates/lttng-modules/probes/lttng-probe-timer.ko needs unknown=
 symbol lttng_probe_register</div><div>depmod: WARNING: /lib/modules/3.10.0=
-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-timer.ko need=
s unknown symbol lttng_pid_tracker_lookup</div><div>depmod: WARNING: /lib/m=
odules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-=
net.ko needs unknown symbol lttng_probe_unregister</div><div>depmod: WARNIN=
G: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/ltt=
ng-probe-net.ko needs unknown symbol lttng_probe_register</div><div>depmod:=
 WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/pro=
bes/lttng-probe-net.ko needs unknown symbol lttng_pid_tracker_lookup</div><=
div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-=
modules/tests/probes/lttng-test.ko needs unknown symbol lttng_probe_unregis=
ter</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-upda=
tes/lttng-modules/tests/probes/lttng-test.ko needs unknown symbol lttng_pro=
be_register</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/w=
eak-updates/lttng-modules/tests/probes/lttng-test.ko needs unknown symbol l=
ttng_pid_tracker_lookup</div><div>depmod: WARNING: /lib/modules/3.10.0-229.=
el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-writeback.ko needs=
 unknown symbol lttng_probe_unregister</div><div>depmod: WARNING: /lib/modu=
les/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-wor=
kqueue.ko needs unknown symbol lttng_pid_tracker_lookup<br></div><div>depmo=
d: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/p=
robes/lttng-probe-irq.ko needs unknown symbol lttng_probe_unregister</div><=
div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-=
modules/probes/lttng-probe-irq.ko needs unknown symbol lttng_probe_register=
</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates=
/lttng-modules/probes/lttng-probe-irq.ko needs unknown symbol lttng_pid_tra=
cker_lookup</div><div>=C2=A0 Verifying =C2=A0: kmod-lttng-modules-2.8.0-1.e=
l7.x86_64 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01/1=C2=A0</di=
v><div><br></div><div>Installed:</div><div>=C2=A0 kmod-lttng-modules.x86_64=
 0:2.8.0-1.el7 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0</div><div><br></div><div>Co=
mplete!</div></div><div><br></div><div><br></div></div>

--94eb2c0649b249cce3053578d8d2--

--===============7592484539028982212==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7592484539028982212==--
