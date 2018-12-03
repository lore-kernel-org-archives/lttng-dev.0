From: =?UTF-8?B?U3p5bW9uIFLEhXBhxYJh?= <rompacz00@gmail.com>
Subject: Re: Error: Unable to list kernel events: Kernel tracer
 not available
Date: Mon, 3 Dec 2018 12:30:18 +0100
Message-ID: <CAN=_Va=ibpRorwzkryNdjfJ5-L4U4V1kgddA6sXeqQ6ye0DYYA__15035.647530067$1543836517$gmane$org@mail.gmail.com>
References: <CAN=_VanV7dh13y8Y787W-zgAisUiEejhKD+4EO2qwWCPXWk79g@mail.gmail.com>
 <20181201000518.GA28340@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3668895936074733289=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 by lists.lttng.org (Postfix) with ESMTPS id 437jV11xGxzxFX
 for <lttng-dev@lists.lttng.org>; Mon,  3 Dec 2018 06:30:33 -0500 (EST)
Received: by mail-io1-xd2f.google.com with SMTP id f14so4669331iol.4
 for <lttng-dev@lists.lttng.org>; Mon, 03 Dec 2018 03:30:32 -0800 (PST)
In-Reply-To: <20181201000518.GA28340@joraj-alpa>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jonathan.rajotte-julien@efficios.com, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============3668895936074733289==
Content-Type: multipart/alternative; boundary="00000000000002b23c057c1c7a50"

--00000000000002b23c057c1c7a50
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for response.
Please check console logs here: https://paste.debian.net/1054148

Thanks in advance for further support.
Szymon



sob., 1 gru 2018 o 01:05 Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> napisa=C5=82(a):

> Hi Szymon,
>
> First thing to validate is if the modules compilation worked.
>
> Please give us the output of the following command:
>
>    ls -la /lib/modules/`uname -r`/extra
>
> Since you installed lttng-tools via the package repo, a service was
> installed
> to spawn lttng-sessiond.
>
> You can control the service using systemctl:
>
>    sudo systemctl stop lttng-sessiond.service
>    sudo systemctl start lttng-sessiond.service
>    sudo systemctl restart lttng-sessiond.service
>
> The output you gave us indicate that a sessiond is already running (the o=
ne
> started by the systemd service). Which is of no use.
>
> A colleague suggested that since you might have installed the modules
> package
> after the lttng-tools package, the modules were not present when
> lttng-sessiond
> service was started thus could not have been loaded.
>
> To test this hypothesis you can issue the following command followed by
> your
> test.
>
>    sudo systemctl restart lttng-sessiond.service
>    sleep 1
>    sudo lttng list -k
>
> If it doesn't work, stop the service and start a sessiond in verbose mode
> manually.
>
>    sudo systemctl stop lttng-sessiond.service
>    sudo lttng-sessiond -vvv --verbose-consumer
>
> This should give us more information.
>
> You can use a service like https://paste.debian.net/ to give us any of th=
e
> output if it ends up being more than ~20 lines.
>
> Thanks for using the mailing list instead of Stack Overflow. Once we find
> the
> problem we can update you SO thread with the solution.
>
> Cheers
>
> On Sat, Dec 01, 2018 at 12:22:05AM +0100, Szymon R=C4=85pa=C5=82a wrote:
> > Hello,
> >
> > I'm new to lttng so I tried to follow the 'Quick Start' tutorial from
> > lttng.org.
> >
> > I have installed LTTng Stable 2.10 PPA (lttng-tools, lttng-modules-dkms=
,
> > liblttng-ust-dev). At very beginning I am facing a problem with kernel
> > tracking:
> >
> > ~/lttng_train$ sudo lttng create my
> > Session my created.
> > Traces will be written in /home/szymon/lttng-traces/my-20181130-222008
> > ~/lttng_train$ sudo lttng list --kernel
> > Error: Unable to list kernel events: Kernel tracer not available
> > Error: Command error
> >
> > Any ideas? Thanks for support!
> >
> > Additional info:
> >
> > ~/lttng_train$ dpkg -l | grep lttng
> >  ii  liblttng-ctl0:amd64
> > 2.10.5-1~ubuntu16.04.1                       amd64        LTTng
> > control and utility library
> >  ii  liblttng-ust-ctl4:amd64
> > 2.10.2-1~ubuntu16.04.1                       amd64        LTTng 2.0
> > Userspace Tracer (trace control library)
> >  ii  liblttng-ust-dev:amd64
> > 2.10.2-1~ubuntu16.04.1                       amd64        LTTng 2.0
> > Userspace Tracer (development files)
> >  ii  liblttng-ust-python-agent0:amd64
> > 2.10.2-1~ubuntu16.04.1                       amd64        LTTng 2.0
> > Userspace Tracer (Python agent native library)
> >  ii  liblttng-ust0:amd64
> > 2.10.2-1~ubuntu16.04.1                       amd64        LTTng 2.0
> > Userspace Tracer (tracing libraries)
> >  ii  lttng-modules-dkms
> > 2.10.8-1~ubuntu16.04.1                       all          Linux Trace
> > Toolkit (LTTng) kernel modules (DKMS)
> >  ii  lttng-tools
> > 2.10.5-1~ubuntu16.04.1                       amd64        LTTng
> > control and utility programs
> >
> > ~$ uname -a
> > Linux szymon 4.4.0-98-generic #121-Ubuntu SMP Tue Oct 10 14:24:03 UTC
> > 2017 x86_64 x86_64 x86_64 GNU/Linux
> >
> > ~$ lsb_release -a
> > No LSB modules are available.
> > Distributor ID: Ubuntu
> > Description:    Ubuntu 16.04.5 LTS
> > Release:    16.04
> > Codename:   xenial
> >
> > ~/lttng_train$ ps aux | grep lttng-sessiond
> > root      7862  0.0  0.3 859960 10880 ?        Ssl  19:12   0:00
> > /usr/bin/lttng-sessiond
> > szymon   14853  0.0  0.0  15440   936 pts/1    S+   22:21   0:00 grep
> > --color=3Dauto lttng-sessiond
> >
> > ~/lttng_train$ lsmod | grep lttng
> > ~/
> >
> > ~/lttng_train$ sudo lttng-sessiond -vvv
> > DEBUG1 - 00:16:41.328643679 [16578/16578]: [sessiond configuration]
> > DEBUG1 - 00:16:41.328715142 [16578/16578]:    verbose:
>      3
> > DEBUG1 - 00:16:41.328723618 [16578/16578]:    verbose consumer:
>     0
> > DEBUG1 - 00:16:41.328729230 [16578/16578]:    quiet mode:
>     False
> > DEBUG1 - 00:16:41.328735428 [16578/16578]:    agent_tcp_port:
> >     [5345, 5354]
> > DEBUG1 - 00:16:41.328741084 [16578/16578]:    application socket
> timeout:    5
> > DEBUG1 - 00:16:41.328761096 [16578/16578]:    no-kernel:
>      False
> > DEBUG1 - 00:16:41.328776829 [16578/16578]:    background:
>     False
> > DEBUG1 - 00:16:41.328788328 [16578/16578]:    daemonize:
>      False
> > DEBUG1 - 00:16:41.328800092 [16578/16578]:    signal parent on start:
>     False
> > DEBUG1 - 00:16:41.328812153 [16578/16578]:    tracing group name:
> >     tracing
> > DEBUG1 - 00:16:41.328823395 [16578/16578]:    kmod_probe_list:
>      None
> > DEBUG1 - 00:16:41.328834022 [16578/16578]:    kmod_extra_probe_list:
>      None
> > DEBUG1 - 00:16:41.328848328 [16578/16578]:    rundir:
> >     /var/run/lttng
> > DEBUG1 - 00:16:41.328857048 [16578/16578]:    application socket path:
> >     /var/run/lttng/lttng-ust-sock-7
> > DEBUG1 - 00:16:41.328866302 [16578/16578]:    client socket path:
> >     /var/run/lttng/client-lttng-sessiond
> > DEBUG1 - 00:16:41.328881494 [16578/16578]:    wait shm path:
> >     /lttng-ust-wait-7
> > DEBUG1 - 00:16:41.328890337 [16578/16578]:    health socket path:
> >     /var/run/lttng/sessiond-health
> > DEBUG1 - 00:16:41.328896087 [16578/16578]:    LTTNG_UST_CLOCK_PLUGIN:
>     None
> > DEBUG1 - 00:16:41.328902562 [16578/16578]:    pid file path:
> >     /var/run/lttng/lttng-sessiond.pid
> > DEBUG1 - 00:16:41.328909781 [16578/16578]:    lock file path:
> >     /var/run/lttng/lttng-sessiond.lck
> > DEBUG1 - 00:16:41.328916938 [16578/16578]:    session load path:
>      None
> > DEBUG1 - 00:16:41.328924592 [16578/16578]:    agent port file path:
> >     /var/run/lttng/agent.port
> > DEBUG1 - 00:16:41.328936395 [16578/16578]:    consumerd32 path:
> >     /var/run/lttng/ustconsumerd32
> > DEBUG1 - 00:16:41.328947517 [16578/16578]:    consumerd32 bin path:
> >     Unknown
> > DEBUG1 - 00:16:41.328961683 [16578/16578]:    consumerd32 lib dir:
> >     Unknown
> > DEBUG1 - 00:16:41.328970009 [16578/16578]:    consumerd32 err unix sock
> > path:/var/run/lttng/ustconsumerd32/error
> > DEBUG1 - 00:16:41.328977730 [16578/16578]:    consumerd32 cmd unix sock
> > path:/var/run/lttng/ustconsumerd32/command
> > DEBUG1 - 00:16:41.328985023 [16578/16578]:    consumerd64 path:
> >     /var/run/lttng/ustconsumerd64
> > DEBUG1 - 00:16:41.328992714 [16578/16578]:    consumerd64 bin path:
> >     /usr/lib/x86_64-linux-gnu/lttng/libexec/lttng-consumerd
> > DEBUG1 - 00:16:41.329005793 [16578/16578]:    consumerd64 lib dir:
> >     /usr/lib/x86_64-linux-gnu
> > DEBUG1 - 00:16:41.329017089 [16578/16578]:    consumerd64 err unix sock
> > path:/var/run/lttng/ustconsumerd64/error
> > DEBUG1 - 00:16:41.329028919 [16578/16578]:    consumerd64 cmd unix sock
> > path:/var/run/lttng/ustconsumerd64/command
> > DEBUG1 - 00:16:41.329040967 [16578/16578]:    kconsumerd path:
> >     /var/run/lttng/kconsumerd
> > DEBUG1 - 00:16:41.329053218 [16578/16578]:    kconsumerd err unix sock
> > path: /var/run/lttng/kconsumerd/error
> > DEBUG1 - 00:16:41.329064330 [16578/16578]:    kconsumerd cmd unix sock
> > path: /var/run/lttng/kconsumerd/command
> > DEBUG3 - 00:16:41.329076040 [16578/16578]: Creating LTTng run
> > directory: /var/run/lttng (in create_lttng_rundir() at main.c:5306)
> > Error: A session daemon is already running.
> > DEBUG1 - 00:16:41.329161207 [16578/16578]: Cleaning up options (in
> > sessiond_cleanup_options() at main.c:648)
> > DEBUG1 - 00:16:41.329178082 [16578/16578]: Destroying run_as worker
> > (in run_as_destroy_worker() at runas.c:709)
> >
> > Regards,
> >
> > Simon
>
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Jonathan Rajotte-Julien
> EfficiOS
>

--00000000000002b23c057c1c7a50
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Thanks for response. <br></div><div>=
Please check console logs here: <a href=3D"https://paste.debian.net/1054148=
">https://paste.debian.net/1054148</a></div><div><br></div><div>Thanks in a=
dvance for further support.</div><div>Szymon<br></div><div><table class=3D"=
gmail-ajC" cellpadding=3D"0"><tbody><tr class=3D"gmail-ajv"><td colspan=3D"=
2" class=3D"gmail-gG"><span class=3D"gmail-gI"></span><br></td><td colspan=
=3D"2" class=3D"gmail-gL"><span class=3D"gmail-gI"><span></span></span><br>=
</td></tr></tbody></table> </div></div></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr">sob., 1 gru 2018 o 01:05=C2=A0Jonathan Rajotte-Julien &lt=
;<a href=3D"mailto:jonathan.rajotte-julien@efficios.com">jonathan.rajotte-j=
ulien@efficios.com</a>&gt; napisa=C5=82(a):<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">Hi Szymon,<br>
<br>
First thing to validate is if the modules compilation worked.<br>
<br>
Please give us the output of the following command:<br>
<br>
=C2=A0 =C2=A0ls -la /lib/modules/`uname -r`/extra<br>
<br>
Since you installed lttng-tools via the package repo, a service was install=
ed<br>
to spawn lttng-sessiond.<br>
<br>
You can control the service using systemctl:<br>
<br>
=C2=A0 =C2=A0sudo systemctl stop lttng-sessiond.service<br>
=C2=A0 =C2=A0sudo systemctl start lttng-sessiond.service<br>
=C2=A0 =C2=A0sudo systemctl restart lttng-sessiond.service<br>
<br>
The output you gave us indicate that a sessiond is already running (the one=
<br>
started by the systemd service). Which is of no use.<br>
<br>
A colleague suggested that since you might have installed the modules packa=
ge<br>
after the lttng-tools package, the modules were not present when lttng-sess=
iond<br>
service was started thus could not have been loaded.<br>
<br>
To test this hypothesis you can issue the following command followed by you=
r<br>
test.<br>
<br>
=C2=A0 =C2=A0sudo systemctl restart lttng-sessiond.service<br>
=C2=A0 =C2=A0sleep 1<br>
=C2=A0 =C2=A0sudo lttng list -k<br>
<br>
If it doesn&#39;t work, stop the service and start a sessiond in verbose mo=
de<br>
manually.<br>
<br>
=C2=A0 =C2=A0sudo systemctl stop lttng-sessiond.service<br>
=C2=A0 =C2=A0sudo lttng-sessiond -vvv --verbose-consumer<br>
<br>
This should give us more information.<br>
<br>
You can use a service like <a href=3D"https://paste.debian.net/" rel=3D"nor=
eferrer" target=3D"_blank">https://paste.debian.net/</a> to give us any of =
the<br>
output if it ends up being more than ~20 lines.<br>
<br>
Thanks for using the mailing list instead of Stack Overflow. Once we find t=
he<br>
problem we can update you SO thread with the solution.<br>
<br>
Cheers<br>
<br>
On Sat, Dec 01, 2018 at 12:22:05AM +0100, Szymon R=C4=85pa=C5=82a wrote:<br=
>
&gt; Hello,<br>
&gt; <br>
&gt; I&#39;m new to lttng so I tried to follow the &#39;Quick Start&#39; tu=
torial from<br>
&gt; <a href=3D"http://lttng.org" rel=3D"noreferrer" target=3D"_blank">lttn=
g.org</a>.<br>
&gt; <br>
&gt; I have installed LTTng Stable 2.10 PPA (lttng-tools, lttng-modules-dkm=
s,<br>
&gt; liblttng-ust-dev). At very beginning I am facing a problem with kernel=
<br>
&gt; tracking:<br>
&gt; <br>
&gt; ~/lttng_train$ sudo lttng create my<br>
&gt; Session my created.<br>
&gt; Traces will be written in /home/szymon/lttng-traces/my-20181130-222008=
<br>
&gt; ~/lttng_train$ sudo lttng list --kernel<br>
&gt; Error: Unable to list kernel events: Kernel tracer not available<br>
&gt; Error: Command error<br>
&gt; <br>
&gt; Any ideas? Thanks for support!<br>
&gt; <br>
&gt; Additional info:<br>
&gt; <br>
&gt; ~/lttng_train$ dpkg -l | grep lttng<br>
&gt;=C2=A0 ii=C2=A0 liblttng-ctl0:amd64<br>
&gt; 2.10.5-1~ubuntu16.04.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amd64=C2=A0 =C2=A0 =C2=A0 =C2=A0 LTTng<b=
r>
&gt; control and utility library<br>
&gt;=C2=A0 ii=C2=A0 liblttng-ust-ctl4:amd64<br>
&gt; 2.10.2-1~ubuntu16.04.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amd64=C2=A0 =C2=A0 =C2=A0 =C2=A0 LTTng 2=
.0<br>
&gt; Userspace Tracer (trace control library)<br>
&gt;=C2=A0 ii=C2=A0 liblttng-ust-dev:amd64<br>
&gt; 2.10.2-1~ubuntu16.04.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amd64=C2=A0 =C2=A0 =C2=A0 =C2=A0 LTTng 2=
.0<br>
&gt; Userspace Tracer (development files)<br>
&gt;=C2=A0 ii=C2=A0 liblttng-ust-python-agent0:amd64<br>
&gt; 2.10.2-1~ubuntu16.04.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amd64=C2=A0 =C2=A0 =C2=A0 =C2=A0 LTTng 2=
.0<br>
&gt; Userspace Tracer (Python agent native library)<br>
&gt;=C2=A0 ii=C2=A0 liblttng-ust0:amd64<br>
&gt; 2.10.2-1~ubuntu16.04.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amd64=C2=A0 =C2=A0 =C2=A0 =C2=A0 LTTng 2=
.0<br>
&gt; Userspace Tracer (tracing libraries)<br>
&gt;=C2=A0 ii=C2=A0 lttng-modules-dkms<br>
&gt; 2.10.8-1~ubuntu16.04.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0all=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Li=
nux Trace<br>
&gt; Toolkit (LTTng) kernel modules (DKMS)<br>
&gt;=C2=A0 ii=C2=A0 lttng-tools<br>
&gt; 2.10.5-1~ubuntu16.04.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amd64=C2=A0 =C2=A0 =C2=A0 =C2=A0 LTTng<b=
r>
&gt; control and utility programs<br>
&gt; <br>
&gt; ~$ uname -a<br>
&gt; Linux szymon 4.4.0-98-generic #121-Ubuntu SMP Tue Oct 10 14:24:03 UTC<=
br>
&gt; 2017 x86_64 x86_64 x86_64 GNU/Linux<br>
&gt; <br>
&gt; ~$ lsb_release -a<br>
&gt; No LSB modules are available.<br>
&gt; Distributor ID: Ubuntu<br>
&gt; Description:=C2=A0 =C2=A0 Ubuntu 16.04.5 LTS<br>
&gt; Release:=C2=A0 =C2=A0 16.04<br>
&gt; Codename:=C2=A0 =C2=A0xenial<br>
&gt; <br>
&gt; ~/lttng_train$ ps aux | grep lttng-sessiond<br>
&gt; root=C2=A0 =C2=A0 =C2=A0 7862=C2=A0 0.0=C2=A0 0.3 859960 10880 ?=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 Ssl=C2=A0 19:12=C2=A0 =C2=A00:00<br>
&gt; /usr/bin/lttng-sessiond<br>
&gt; szymon=C2=A0 =C2=A014853=C2=A0 0.0=C2=A0 0.0=C2=A0 15440=C2=A0 =C2=A09=
36 pts/1=C2=A0 =C2=A0 S+=C2=A0 =C2=A022:21=C2=A0 =C2=A00:00 grep<br>
&gt; --color=3Dauto lttng-sessiond<br>
&gt; <br>
&gt; ~/lttng_train$ lsmod | grep lttng<br>
&gt; ~/<br>
&gt; <br>
&gt; ~/lttng_train$ sudo lttng-sessiond -vvv<br>
&gt; DEBUG1 - 00:16:41.328643679 [16578/16578]: [sessiond configuration]<br=
>
&gt; DEBUG1 - 00:16:41.328715142 [16578/16578]:=C2=A0 =C2=A0 verbose:=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A03<br>
&gt; DEBUG1 - 00:16:41.328723618 [16578/16578]:=C2=A0 =C2=A0 verbose consum=
er:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
&gt; DEBUG1 - 00:16:41.328729230 [16578/16578]:=C2=A0 =C2=A0 quiet mode:=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 False<br=
>
&gt; DEBUG1 - 00:16:41.328735428 [16578/16578]:=C2=A0 =C2=A0 agent_tcp_port=
:<br>
&gt;=C2=A0 =C2=A0 =C2=A0[5345, 5354]<br>
&gt; DEBUG1 - 00:16:41.328741084 [16578/16578]:=C2=A0 =C2=A0 application so=
cket timeout:=C2=A0 =C2=A0 5<br>
&gt; DEBUG1 - 00:16:41.328761096 [16578/16578]:=C2=A0 =C2=A0 no-kernel:=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Fa=
lse<br>
&gt; DEBUG1 - 00:16:41.328776829 [16578/16578]:=C2=A0 =C2=A0 background:=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 False<br=
>
&gt; DEBUG1 - 00:16:41.328788328 [16578/16578]:=C2=A0 =C2=A0 daemonize:=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Fa=
lse<br>
&gt; DEBUG1 - 00:16:41.328800092 [16578/16578]:=C2=A0 =C2=A0 signal parent =
on start:=C2=A0 =C2=A0 =C2=A0 =C2=A0 False<br>
&gt; DEBUG1 - 00:16:41.328812153 [16578/16578]:=C2=A0 =C2=A0 tracing group =
name:<br>
&gt;=C2=A0 =C2=A0 =C2=A0tracing<br>
&gt; DEBUG1 - 00:16:41.328823395 [16578/16578]:=C2=A0 =C2=A0 kmod_probe_lis=
t:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0None<br>
&gt; DEBUG1 - 00:16:41.328834022 [16578/16578]:=C2=A0 =C2=A0 kmod_extra_pro=
be_list:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0None<br>
&gt; DEBUG1 - 00:16:41.328848328 [16578/16578]:=C2=A0 =C2=A0 rundir:<br>
&gt;=C2=A0 =C2=A0 =C2=A0/var/run/lttng<br>
&gt; DEBUG1 - 00:16:41.328857048 [16578/16578]:=C2=A0 =C2=A0 application so=
cket path:<br>
&gt;=C2=A0 =C2=A0 =C2=A0/var/run/lttng/lttng-ust-sock-7<br>
&gt; DEBUG1 - 00:16:41.328866302 [16578/16578]:=C2=A0 =C2=A0 client socket =
path:<br>
&gt;=C2=A0 =C2=A0 =C2=A0/var/run/lttng/client-lttng-sessiond<br>
&gt; DEBUG1 - 00:16:41.328881494 [16578/16578]:=C2=A0 =C2=A0 wait shm path:=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0/lttng-ust-wait-7<br>
&gt; DEBUG1 - 00:16:41.328890337 [16578/16578]:=C2=A0 =C2=A0 health socket =
path:<br>
&gt;=C2=A0 =C2=A0 =C2=A0/var/run/lttng/sessiond-health<br>
&gt; DEBUG1 - 00:16:41.328896087 [16578/16578]:=C2=A0 =C2=A0 LTTNG_UST_CLOC=
K_PLUGIN:=C2=A0 =C2=A0 =C2=A0 =C2=A0 None<br>
&gt; DEBUG1 - 00:16:41.328902562 [16578/16578]:=C2=A0 =C2=A0 pid file path:=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0/var/run/lttng/lttng-sessiond.pid<br>
&gt; DEBUG1 - 00:16:41.328909781 [16578/16578]:=C2=A0 =C2=A0 lock file path=
:<br>
&gt;=C2=A0 =C2=A0 =C2=A0/var/run/lttng/lttng-sessiond.lck<br>
&gt; DEBUG1 - 00:16:41.328916938 [16578/16578]:=C2=A0 =C2=A0 session load p=
ath:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0None<br>
&gt; DEBUG1 - 00:16:41.328924592 [16578/16578]:=C2=A0 =C2=A0 agent port fil=
e path:<br>
&gt;=C2=A0 =C2=A0 =C2=A0/var/run/lttng/agent.port<br>
&gt; DEBUG1 - 00:16:41.328936395 [16578/16578]:=C2=A0 =C2=A0 consumerd32 pa=
th:<br>
&gt;=C2=A0 =C2=A0 =C2=A0/var/run/lttng/ustconsumerd32<br>
&gt; DEBUG1 - 00:16:41.328947517 [16578/16578]:=C2=A0 =C2=A0 consumerd32 bi=
n path:<br>
&gt;=C2=A0 =C2=A0 =C2=A0Unknown<br>
&gt; DEBUG1 - 00:16:41.328961683 [16578/16578]:=C2=A0 =C2=A0 consumerd32 li=
b dir:<br>
&gt;=C2=A0 =C2=A0 =C2=A0Unknown<br>
&gt; DEBUG1 - 00:16:41.328970009 [16578/16578]:=C2=A0 =C2=A0 consumerd32 er=
r unix sock<br>
&gt; path:/var/run/lttng/ustconsumerd32/error<br>
&gt; DEBUG1 - 00:16:41.328977730 [16578/16578]:=C2=A0 =C2=A0 consumerd32 cm=
d unix sock<br>
&gt; path:/var/run/lttng/ustconsumerd32/command<br>
&gt; DEBUG1 - 00:16:41.328985023 [16578/16578]:=C2=A0 =C2=A0 consumerd64 pa=
th:<br>
&gt;=C2=A0 =C2=A0 =C2=A0/var/run/lttng/ustconsumerd64<br>
&gt; DEBUG1 - 00:16:41.328992714 [16578/16578]:=C2=A0 =C2=A0 consumerd64 bi=
n path:<br>
&gt;=C2=A0 =C2=A0 =C2=A0/usr/lib/x86_64-linux-gnu/lttng/libexec/lttng-consu=
merd<br>
&gt; DEBUG1 - 00:16:41.329005793 [16578/16578]:=C2=A0 =C2=A0 consumerd64 li=
b dir:<br>
&gt;=C2=A0 =C2=A0 =C2=A0/usr/lib/x86_64-linux-gnu<br>
&gt; DEBUG1 - 00:16:41.329017089 [16578/16578]:=C2=A0 =C2=A0 consumerd64 er=
r unix sock<br>
&gt; path:/var/run/lttng/ustconsumerd64/error<br>
&gt; DEBUG1 - 00:16:41.329028919 [16578/16578]:=C2=A0 =C2=A0 consumerd64 cm=
d unix sock<br>
&gt; path:/var/run/lttng/ustconsumerd64/command<br>
&gt; DEBUG1 - 00:16:41.329040967 [16578/16578]:=C2=A0 =C2=A0 kconsumerd pat=
h:<br>
&gt;=C2=A0 =C2=A0 =C2=A0/var/run/lttng/kconsumerd<br>
&gt; DEBUG1 - 00:16:41.329053218 [16578/16578]:=C2=A0 =C2=A0 kconsumerd err=
 unix sock<br>
&gt; path: /var/run/lttng/kconsumerd/error<br>
&gt; DEBUG1 - 00:16:41.329064330 [16578/16578]:=C2=A0 =C2=A0 kconsumerd cmd=
 unix sock<br>
&gt; path: /var/run/lttng/kconsumerd/command<br>
&gt; DEBUG3 - 00:16:41.329076040 [16578/16578]: Creating LTTng run<br>
&gt; directory: /var/run/lttng (in create_lttng_rundir() at main.c:5306)<br=
>
&gt; Error: A session daemon is already running.<br>
&gt; DEBUG1 - 00:16:41.329161207 [16578/16578]: Cleaning up options (in<br>
&gt; sessiond_cleanup_options() at main.c:648)<br>
&gt; DEBUG1 - 00:16:41.329178082 [16578/16578]: Destroying run_as worker<br=
>
&gt; (in run_as_destroy_worker() at runas.c:709)<br>
&gt; <br>
&gt; Regards,<br>
&gt; <br>
&gt; Simon<br>
<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</a><br>
<br>
<br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</blockquote></div>

--00000000000002b23c057c1c7a50--

--===============3668895936074733289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3668895936074733289==--
