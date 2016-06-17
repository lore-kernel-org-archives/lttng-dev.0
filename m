From: Ravi Inder Singh <raviinder@gmail.com>
Subject: Re: In Redhat 7.1 kmod-lttng-modules is not installed
Date: Fri, 17 Jun 2016 10:42:19 -0400
Message-ID: <CA+=s6BZjdaMYhkbT1oRrUb0gZoWCdD3bRuoGWu3Z-VvY+VtROA__26539.0896740884$1466174669$gmane$org@mail.gmail.com>
References: <CA+=s6Bag3Pz6FkbLAmu2BEC_wbpC1ON=qrjvF=G6iVdd1N8NyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4369922810359542043=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-f180.google.com (mail-yw0-f180.google.com
 [209.85.161.180])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id BBEF7A33F5
 for <lttng-dev@lists.lttng.org>; Fri, 17 Jun 2016 14:42:40 +0000 (UTC)
Received: by mail-yw0-f180.google.com with SMTP id b75so14693309ywe.1
 for <lttng-dev@lists.lttng.org>; Fri, 17 Jun 2016 07:42:40 -0700 (PDT)
In-Reply-To: <CA+=s6Bag3Pz6FkbLAmu2BEC_wbpC1ON=qrjvF=G6iVdd1N8NyQ@mail.gmail.com>
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

--===============4369922810359542043==
Content-Type: multipart/alternative; boundary=001a114fb268c17d9b05357a5def

--001a114fb268c17d9b05357a5def
Content-Type: text/plain; charset=UTF-8

>
> Hi all,
> 1)
> RHEL 7.1 OS version is :-
>
> *****************************************************************8
> cat /etc/*release
> NAME="Red Hat Enterprise Linux Workstation"
> VERSION="7.1 (Maipo)"
> ID="rhel"
> ID_LIKE="fedora"
> VERSION_ID="7.1"
> PRETTY_NAME="Red Hat Enterprise Linux Workstation 7.1 (Maipo)"
> ANSI_COLOR="0;31"
> CPE_NAME="cpe:/o:redhat:enterprise_linux:7.1:GA:workstation"
> HOME_URL="https://www.redhat.com/"
> BUG_REPORT_URL="https://bugzilla.redhat.com/"
> *********************************************************************
> 2)  I installed everything but when i start kernel tracer it throws me
> error "Kernel Tracer not available"
>
>
>  lttng enable-event --kernel allError: Event all: Kernel tracer not
> available (channel channel0, session auto-20160616-165319)
>
>
> Issue i beleive is while installing kernel modules it give me following
> warnings.
> Here is output.
>
>
> root # yum install  kmod-lttng-modules
> Loaded plugins: langpacks, product-id, subscription-manager
> This system is not registered to Red Hat Subscription Management. You can
> use subscription-manager to register.
> Resolving Dependencies
> --> Running transaction check
> ---> Package kmod-lttng-modules.x86_64 0:2.8.0-1.el7 will be installed
> --> Finished Dependency Resolution
>
> Dependencies Resolved
>
>
> ================================================================================================================================================================================
>  Package                                       Arch
>        Version                                 Repository
>                      Size
>
> ================================================================================================================================================================================
> Installing:
>  kmod-lttng-modules                            x86_64
>        2.8.0-1.el7                             EfficiOS-RHEL7-x86-64
>                      281 k
>
> Transaction Summary
>
> ================================================================================================================================================================================
> Install  1 Package
>
> Total download size: 281 k
> Installed size: 2.5 M
> Is this ok [y/d/N]: y
> Downloading packages:
> kmod-lttng-modules-2.8.0-1.el7.x86_64.rpm
>
>    | 281 kB  00:00:00
> Running transaction check
> Running transaction test
> Transaction test succeeded
> Running transaction
>   Installing : kmod-lttng-modules-2.8.0-1.el7.x86_64
>
>                      1/1
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-kvm.ko
> needs unknown symbol lttng_probe_unregister
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-kvm.ko
> needs unknown symbol lttng_probe_register
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-kvm.ko
> needs unknown symbol lttng_pid_tracker_lookup
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-sock.ko
> needs unknown symbol lttng_probe_unregister
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-sock.ko
> needs unknown symbol lttng_probe_register
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-sock.ko
> needs unknown symbol lttng_pid_tracker_lookup
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-metadata-client.ko
> needs unknown symbol lttng_transport_unregister
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-metadata-client.ko
> needs unknown symbol lttng_transport_register
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-printk.ko
> needs unknown symbol lttng_probe_unregister
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-printk.ko
> needs unknown symbol lttng_probe_register
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-printk.ko
> needs unknown symbol lttng_pid_tracker_lookup
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-napi.ko
> needs unknown symbol lttng_probe_unregister
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-napi.ko
> needs unknown symbol lttng_probe_register
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-napi.ko
> needs unknown symbol lttng_pid_tracker_lookup
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-client-mmap-discard.ko
> needs unknown symbol lttng_transport_unregister
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-client-mmap-discard.ko
> needs unknown symbol lttng_transport_register
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-kmem.ko
> needs unknown symbol lttng_probe_unregister
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-kmem.ko
> needs unknown symbol lttng_probe_register
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-kmem.ko
> needs unknown symbol lttng_pid_tracker_lookup
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-compaction.ko
> needs unknown symbol lttng_probe_unregister
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-compaction.ko
> needs unknown symbol lttng_probe_register
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-compaction.ko
> needs unknown symbol lttng_pid_tracker_lookup
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-client-overwrite.ko
> needs unknown symbol lttng_transport_unregister
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-client-overwrite.ko
> needs unknown symbol lttng_transport_register
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-client-mmap-overwrite.ko
> needs unknown symbol lttng_transport_unregister
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-client-mmap-overwrite.ko
> needs unknown symbol lttng_transport_register
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-x86-exceptions.ko
> needs unknown symbol lttng_probe_unregister
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-x86-exceptions.ko
> needs unknown symbol lttng_probe_register
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-x86-exceptions.ko
> needs unknown symbol lttng_pid_tracker_lookup
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-sunrpc.ko
> needs unknown symbol lttng_probe_unregister
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-sunrpc.ko
> needs unknown symbol lttng_probe_register
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-sunrpc.ko
> needs unknown symbol lttng_pid_tracker_lookup
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-signal.ko
> needs unknown symbol lttng_probe_unregister
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-signal.ko
> needs unknown symbol lttng_probe_register
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-signal.ko
> needs unknown symbol lttng_pid_tracker_lookup
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-module.ko
> needs unknown symbol lttng_probe_unregister
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-module.ko
> needs unknown symbol lttng_probe_register
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-module.ko
> needs unknown symbol lttng_pid_tracker_lookup
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-client-discard.ko
> needs unknown symbol lttng_transport_unregister
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-client-discard.ko
> needs unknown symbol lttng_transport_register
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-timer.ko
> needs unknown symbol lttng_probe_unregister
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-timer.ko
> needs unknown symbol lttng_probe_register
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-timer.ko
> needs unknown symbol lttng_pid_tracker_lookup
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-net.ko
> needs unknown symbol lttng_probe_unregister
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-net.ko
> needs unknown symbol lttng_probe_register
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-net.ko
> needs unknown symbol lttng_pid_tracker_lookup
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/tests/probes/lttng-test.ko
> needs unknown symbol lttng_probe_unregister
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/tests/probes/lttng-test.ko
> needs unknown symbol lttng_probe_register
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/tests/probes/lttng-test.ko
> needs unknown symbol lttng_pid_tracker_lookup
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-writeback.ko
> needs unknown symbol lttng_probe_unregister
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-workqueue.ko
> needs unknown symbol lttng_pid_tracker_lookup
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-irq.ko
> needs unknown symbol lttng_probe_unregister
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-irq.ko
> needs unknown symbol lttng_probe_register
> depmod: WARNING:
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-irq.ko
> needs unknown symbol lttng_pid_tracker_lookup
>   Verifying  : kmod-lttng-modules-2.8.0-1.el7.x86_64
>
>                      1/1
>
> Installed:
>   kmod-lttng-modules.x86_64 0:2.8.0-1.el7
>
>
>
> Complete!
>
>
>

--001a114fb268c17d9b05357a5def
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex"><div dir=3D"ltr"><div>Hi all,=C2=A0</div><div>1)=
=C2=A0</div>RHEL 7.1 OS version is :-=C2=A0<div><div><br></div><div>*******=
**********************************************************8</div><div>cat /=
etc/*release=C2=A0</div><div>NAME=3D&quot;Red Hat Enterprise Linux Workstat=
ion&quot;</div><div>VERSION=3D&quot;7.1 (Maipo)&quot;</div><div>ID=3D&quot;=
rhel&quot;</div><div>ID_LIKE=3D&quot;fedora&quot;</div><div>VERSION_ID=3D&q=
uot;7.1&quot;</div><div>PRETTY_NAME=3D&quot;Red Hat Enterprise Linux Workst=
ation 7.1 (Maipo)&quot;</div><div>ANSI_COLOR=3D&quot;0;31&quot;</div><div>C=
PE_NAME=3D&quot;cpe:/o:redhat:enterprise_linux:7.1:GA:workstation&quot;</di=
v><div>HOME_URL=3D&quot;<a href=3D"https://www.redhat.com/" target=3D"_blan=
k">https://www.redhat.com/</a>&quot;</div><div>BUG_REPORT_URL=3D&quot;<a hr=
ef=3D"https://bugzilla.redhat.com/" target=3D"_blank">https://bugzilla.redh=
at.com/</a>&quot;</div><div>***********************************************=
**********************</div><div>2) =C2=A0I installed everything but when i=
 start kernel tracer it throws me error &quot;Kernel Tracer not available&q=
uot;</div><div><br></div><div><br></div><div>=C2=A0lttng enable-event --ker=
nel allError: Event all: Kernel tracer not available (channel channel0, ses=
sion auto-20160616-165319)<br></div><div><br></div><div><br></div><div>Issu=
e i beleive is while installing kernel modules it give me following warning=
s.=C2=A0</div><div>Here is output.=C2=A0</div></div><div><br></div><div><br=
></div><div><div>root # yum install =C2=A0kmod-lttng-modules</div><div>Load=
ed plugins: langpacks, product-id, subscription-manager</div><div>This syst=
em is not registered to Red Hat Subscription Management. You can use subscr=
iption-manager to register.</div><div>Resolving Dependencies</div><div>--&g=
t; Running transaction check</div><div>---&gt; Package kmod-lttng-modules.x=
86_64 0:2.8.0-1.el7 will be installed</div><div>--&gt; Finished Dependency =
Resolution</div><div><br></div><div>Dependencies Resolved</div><div><br></d=
iv><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D</div><div>=C2=A0Package =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 Arch =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Version =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Repository =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Size</div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>Installing:</=
div><div>=C2=A0kmod-lttng-modules =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x86_64 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A02.8.0-1.el7 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EfficiOS-RHEL7-x86-64 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0281 k</div><div><br></div><div>Transaction Summary</div=
><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D</div><div>Install =C2=A01 Package</div><div><br></div><div>Total =
download size: 281 k</div><div>Installed size: 2.5 M</div><div>Is this ok [=
y/d/N]: y</div><div>Downloading packages:</div><div>kmod-lttng-modules-2.8.=
0-1.el7.x86_64.rpm =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 281 kB =C2=A000:00:00 =C2=A0 =C2=
=A0=C2=A0</div><div>Running transaction check</div><div>Running transaction=
 test</div><div>Transaction test succeeded</div><div>Running transaction</d=
iv><div>=C2=A0 Installing : kmod-lttng-modules-2.8.0-1.el7.x86_64 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01/1=C2=A0</div><div>depmod: WA=
RNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes=
/lttng-probe-kvm.ko needs unknown symbol lttng_probe_unregister</div><div>d=
epmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modul=
es/probes/lttng-probe-kvm.ko needs unknown symbol lttng_probe_register</div=
><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttn=
g-modules/probes/lttng-probe-kvm.ko needs unknown symbol lttng_pid_tracker_=
lookup</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-u=
pdates/lttng-modules/probes/lttng-probe-sock.ko needs unknown symbol lttng_=
probe_unregister</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86=
_64/weak-updates/lttng-modules/probes/lttng-probe-sock.ko needs unknown sym=
bol lttng_probe_register</div><div>depmod: WARNING: /lib/modules/3.10.0-229=
.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-sock.ko needs unk=
nown symbol lttng_pid_tracker_lookup</div><div>depmod: WARNING: /lib/module=
s/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-metada=
ta-client.ko needs unknown symbol lttng_transport_unregister</div><div>depm=
od: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/=
lttng-ring-buffer-metadata-client.ko needs unknown symbol lttng_transport_r=
egister</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-=
updates/lttng-modules/probes/lttng-probe-printk.ko needs unknown symbol ltt=
ng_probe_unregister</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.=
x86_64/weak-updates/lttng-modules/probes/lttng-probe-printk.ko needs unknow=
n symbol lttng_probe_register</div><div>depmod: WARNING: /lib/modules/3.10.=
0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-printk.ko ne=
eds unknown symbol lttng_pid_tracker_lookup</div><div>depmod: WARNING: /lib=
/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-prob=
e-napi.ko needs unknown symbol lttng_probe_unregister</div><div>depmod: WAR=
NING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/=
lttng-probe-napi.ko needs unknown symbol lttng_probe_register</div><div>dep=
mod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules=
/probes/lttng-probe-napi.ko needs unknown symbol lttng_pid_tracker_lookup</=
div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/l=
ttng-modules/lttng-ring-buffer-client-mmap-discard.ko needs unknown symbol =
lttng_transport_unregister</div><div>depmod: WARNING: /lib/modules/3.10.0-2=
29.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-client-mmap-disc=
ard.ko needs unknown symbol lttng_transport_register</div><div>depmod: WARN=
ING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-kmem.ko needs unknown symbol lttng_probe_unregister</div><div>de=
pmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-module=
s/probes/lttng-probe-kmem.ko needs unknown symbol lttng_probe_register</div=
><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttn=
g-modules/probes/lttng-probe-kmem.ko needs unknown symbol lttng_pid_tracker=
_lookup</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-=
updates/lttng-modules/probes/lttng-probe-compaction.ko needs unknown symbol=
 lttng_probe_unregister</div><div>depmod: WARNING: /lib/modules/3.10.0-229.=
el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-compaction.ko need=
s unknown symbol lttng_probe_register</div><div>depmod: WARNING: /lib/modul=
es/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-comp=
action.ko needs unknown symbol lttng_pid_tracker_lookup</div><div>depmod: W=
ARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng=
-ring-buffer-client-overwrite.ko needs unknown symbol lttng_transport_unreg=
ister</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-up=
dates/lttng-modules/lttng-ring-buffer-client-overwrite.ko needs unknown sym=
bol lttng_transport_register</div><div>depmod: WARNING: /lib/modules/3.10.0=
-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-client-mmap-ov=
erwrite.ko needs unknown symbol lttng_transport_unregister</div><div>depmod=
: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lt=
tng-ring-buffer-client-mmap-overwrite.ko needs unknown symbol lttng_transpo=
rt_register</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/w=
eak-updates/lttng-modules/probes/lttng-probe-x86-exceptions.ko needs unknow=
n symbol lttng_probe_unregister</div><div>depmod: WARNING: /lib/modules/3.1=
0.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-x86-except=
ions.ko needs unknown symbol lttng_probe_register</div><div>depmod: WARNING=
: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttn=
g-probe-x86-exceptions.ko needs unknown symbol lttng_pid_tracker_lookup</di=
v><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/ltt=
ng-modules/probes/lttng-probe-sunrpc.ko needs unknown symbol lttng_probe_un=
register</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak=
-updates/lttng-modules/probes/lttng-probe-sunrpc.ko needs unknown symbol lt=
tng_probe_register</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x=
86_64/weak-updates/lttng-modules/probes/lttng-probe-sunrpc.ko needs unknown=
 symbol lttng_pid_tracker_lookup</div><div>depmod: WARNING: /lib/modules/3.=
10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-signal.ko=
 needs unknown symbol lttng_probe_unregister</div><div>depmod: WARNING: /li=
b/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-pro=
be-signal.ko needs unknown symbol lttng_probe_register</div><div>depmod: WA=
RNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes=
/lttng-probe-signal.ko needs unknown symbol lttng_pid_tracker_lookup</div><=
div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-=
modules/probes/lttng-probe-module.ko needs unknown symbol lttng_probe_unreg=
ister</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-up=
dates/lttng-modules/probes/lttng-probe-module.ko needs unknown symbol lttng=
_probe_register</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_=
64/weak-updates/lttng-modules/probes/lttng-probe-module.ko needs unknown sy=
mbol lttng_pid_tracker_lookup</div><div>depmod: WARNING: /lib/modules/3.10.=
0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-client-discar=
d.ko needs unknown symbol lttng_transport_unregister</div><div>depmod: WARN=
ING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ri=
ng-buffer-client-discard.ko needs unknown symbol lttng_transport_register</=
div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/l=
ttng-modules/probes/lttng-probe-timer.ko needs unknown symbol lttng_probe_u=
nregister</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/wea=
k-updates/lttng-modules/probes/lttng-probe-timer.ko needs unknown symbol lt=
tng_probe_register</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x=
86_64/weak-updates/lttng-modules/probes/lttng-probe-timer.ko needs unknown =
symbol lttng_pid_tracker_lookup</div><div>depmod: WARNING: /lib/modules/3.1=
0.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-net.ko nee=
ds unknown symbol lttng_probe_unregister</div><div>depmod: WARNING: /lib/mo=
dules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-n=
et.ko needs unknown symbol lttng_probe_register</div><div>depmod: WARNING: =
/lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-=
probe-net.ko needs unknown symbol lttng_pid_tracker_lookup</div><div>depmod=
: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/te=
sts/probes/lttng-test.ko needs unknown symbol lttng_probe_unregister</div><=
div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-=
modules/tests/probes/lttng-test.ko needs unknown symbol lttng_probe_registe=
r</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-update=
s/lttng-modules/tests/probes/lttng-test.ko needs unknown symbol lttng_pid_t=
racker_lookup</div><div>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64=
/weak-updates/lttng-modules/probes/lttng-probe-writeback.ko needs unknown s=
ymbol lttng_probe_unregister</div><div>depmod: WARNING: /lib/modules/3.10.0=
-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-workqueue.ko =
needs unknown symbol lttng_pid_tracker_lookup<br></div><div>depmod: WARNING=
: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttn=
g-probe-irq.ko needs unknown symbol lttng_probe_unregister</div><div>depmod=
: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/pr=
obes/lttng-probe-irq.ko needs unknown symbol lttng_probe_register</div><div=
>depmod: WARNING: /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-mod=
ules/probes/lttng-probe-irq.ko needs unknown symbol lttng_pid_tracker_looku=
p</div><div>=C2=A0 Verifying =C2=A0: kmod-lttng-modules-2.8.0-1.el7.x86_64 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01/1=C2=A0</div><div><br=
></div><div>Installed:</div><div>=C2=A0 kmod-lttng-modules.x86_64 0:2.8.0-1=
.el7 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0</div><div><br></div><div>Complete!</d=
iv></div><div><br></div><div><br></div></div>
</blockquote></div><br></div></div>

--001a114fb268c17d9b05357a5def--

--===============4369922810359542043==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4369922810359542043==--
