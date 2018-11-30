From: =?UTF-8?B?U3p5bW9uIFLEhXBhxYJh?= <rompacz00@gmail.com>
Subject: Error: Unable to list kernel events: Kernel tracer not
 available
Date: Sat, 1 Dec 2018 00:22:05 +0100
Message-ID: <CAN=_VanV7dh13y8Y787W-zgAisUiEejhKD+4EO2qwWCPXWk79g__31355.7466179647$1543620056$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1428468084456159282=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 by lists.lttng.org (Postfix) with ESMTPS id 4369Qf66WHzx9t
 for <lttng-dev@lists.lttng.org>; Fri, 30 Nov 2018 18:22:18 -0500 (EST)
Received: by mail-io1-xd31.google.com with SMTP id x6so5888656ioa.9
 for <lttng-dev@lists.lttng.org>; Fri, 30 Nov 2018 15:22:18 -0800 (PST)
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

--===============1428468084456159282==
Content-Type: multipart/alternative; boundary="000000000000ecd37c057bea1109"

--000000000000ecd37c057bea1109
Content-Type: text/plain; charset="UTF-8"

Hello,

I'm new to lttng so I tried to follow the 'Quick Start' tutorial from
lttng.org.

I have installed LTTng Stable 2.10 PPA (lttng-tools, lttng-modules-dkms,
liblttng-ust-dev). At very beginning I am facing a problem with kernel
tracking:

~/lttng_train$ sudo lttng create my
Session my created.
Traces will be written in /home/szymon/lttng-traces/my-20181130-222008
~/lttng_train$ sudo lttng list --kernel
Error: Unable to list kernel events: Kernel tracer not available
Error: Command error

Any ideas? Thanks for support!

Additional info:

~/lttng_train$ dpkg -l | grep lttng
 ii  liblttng-ctl0:amd64
2.10.5-1~ubuntu16.04.1                       amd64        LTTng
control and utility library
 ii  liblttng-ust-ctl4:amd64
2.10.2-1~ubuntu16.04.1                       amd64        LTTng 2.0
Userspace Tracer (trace control library)
 ii  liblttng-ust-dev:amd64
2.10.2-1~ubuntu16.04.1                       amd64        LTTng 2.0
Userspace Tracer (development files)
 ii  liblttng-ust-python-agent0:amd64
2.10.2-1~ubuntu16.04.1                       amd64        LTTng 2.0
Userspace Tracer (Python agent native library)
 ii  liblttng-ust0:amd64
2.10.2-1~ubuntu16.04.1                       amd64        LTTng 2.0
Userspace Tracer (tracing libraries)
 ii  lttng-modules-dkms
2.10.8-1~ubuntu16.04.1                       all          Linux Trace
Toolkit (LTTng) kernel modules (DKMS)
 ii  lttng-tools
2.10.5-1~ubuntu16.04.1                       amd64        LTTng
control and utility programs

~$ uname -a
Linux szymon 4.4.0-98-generic #121-Ubuntu SMP Tue Oct 10 14:24:03 UTC
2017 x86_64 x86_64 x86_64 GNU/Linux

~$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 16.04.5 LTS
Release:    16.04
Codename:   xenial

~/lttng_train$ ps aux | grep lttng-sessiond
root      7862  0.0  0.3 859960 10880 ?        Ssl  19:12   0:00
/usr/bin/lttng-sessiond
szymon   14853  0.0  0.0  15440   936 pts/1    S+   22:21   0:00 grep
--color=auto lttng-sessiond

~/lttng_train$ lsmod | grep lttng
~/

~/lttng_train$ sudo lttng-sessiond -vvv
DEBUG1 - 00:16:41.328643679 [16578/16578]: [sessiond configuration]
DEBUG1 - 00:16:41.328715142 [16578/16578]: 	verbose:                       3
DEBUG1 - 00:16:41.328723618 [16578/16578]: 	verbose consumer:              0
DEBUG1 - 00:16:41.328729230 [16578/16578]: 	quiet mode:                    False
DEBUG1 - 00:16:41.328735428 [16578/16578]: 	agent_tcp_port:
    [5345, 5354]
DEBUG1 - 00:16:41.328741084 [16578/16578]: 	application socket timeout:    5
DEBUG1 - 00:16:41.328761096 [16578/16578]: 	no-kernel:                     False
DEBUG1 - 00:16:41.328776829 [16578/16578]: 	background:                    False
DEBUG1 - 00:16:41.328788328 [16578/16578]: 	daemonize:                     False
DEBUG1 - 00:16:41.328800092 [16578/16578]: 	signal parent on start:        False
DEBUG1 - 00:16:41.328812153 [16578/16578]: 	tracing group name:
    tracing
DEBUG1 - 00:16:41.328823395 [16578/16578]: 	kmod_probe_list:               None
DEBUG1 - 00:16:41.328834022 [16578/16578]: 	kmod_extra_probe_list:         None
DEBUG1 - 00:16:41.328848328 [16578/16578]: 	rundir:
    /var/run/lttng
DEBUG1 - 00:16:41.328857048 [16578/16578]: 	application socket path:
    /var/run/lttng/lttng-ust-sock-7
DEBUG1 - 00:16:41.328866302 [16578/16578]: 	client socket path:
    /var/run/lttng/client-lttng-sessiond
DEBUG1 - 00:16:41.328881494 [16578/16578]: 	wait shm path:
    /lttng-ust-wait-7
DEBUG1 - 00:16:41.328890337 [16578/16578]: 	health socket path:
    /var/run/lttng/sessiond-health
DEBUG1 - 00:16:41.328896087 [16578/16578]: 	LTTNG_UST_CLOCK_PLUGIN:        None
DEBUG1 - 00:16:41.328902562 [16578/16578]: 	pid file path:
    /var/run/lttng/lttng-sessiond.pid
DEBUG1 - 00:16:41.328909781 [16578/16578]: 	lock file path:
    /var/run/lttng/lttng-sessiond.lck
DEBUG1 - 00:16:41.328916938 [16578/16578]: 	session load path:             None
DEBUG1 - 00:16:41.328924592 [16578/16578]: 	agent port file path:
    /var/run/lttng/agent.port
DEBUG1 - 00:16:41.328936395 [16578/16578]: 	consumerd32 path:
    /var/run/lttng/ustconsumerd32
DEBUG1 - 00:16:41.328947517 [16578/16578]: 	consumerd32 bin path:
    Unknown
DEBUG1 - 00:16:41.328961683 [16578/16578]: 	consumerd32 lib dir:
    Unknown
DEBUG1 - 00:16:41.328970009 [16578/16578]: 	consumerd32 err unix sock
path:/var/run/lttng/ustconsumerd32/error
DEBUG1 - 00:16:41.328977730 [16578/16578]: 	consumerd32 cmd unix sock
path:/var/run/lttng/ustconsumerd32/command
DEBUG1 - 00:16:41.328985023 [16578/16578]: 	consumerd64 path:
    /var/run/lttng/ustconsumerd64
DEBUG1 - 00:16:41.328992714 [16578/16578]: 	consumerd64 bin path:
    /usr/lib/x86_64-linux-gnu/lttng/libexec/lttng-consumerd
DEBUG1 - 00:16:41.329005793 [16578/16578]: 	consumerd64 lib dir:
    /usr/lib/x86_64-linux-gnu
DEBUG1 - 00:16:41.329017089 [16578/16578]: 	consumerd64 err unix sock
path:/var/run/lttng/ustconsumerd64/error
DEBUG1 - 00:16:41.329028919 [16578/16578]: 	consumerd64 cmd unix sock
path:/var/run/lttng/ustconsumerd64/command
DEBUG1 - 00:16:41.329040967 [16578/16578]: 	kconsumerd path:
    /var/run/lttng/kconsumerd
DEBUG1 - 00:16:41.329053218 [16578/16578]: 	kconsumerd err unix sock
path: /var/run/lttng/kconsumerd/error
DEBUG1 - 00:16:41.329064330 [16578/16578]: 	kconsumerd cmd unix sock
path: /var/run/lttng/kconsumerd/command
DEBUG3 - 00:16:41.329076040 [16578/16578]: Creating LTTng run
directory: /var/run/lttng (in create_lttng_rundir() at main.c:5306)
Error: A session daemon is already running.
DEBUG1 - 00:16:41.329161207 [16578/16578]: Cleaning up options (in
sessiond_cleanup_options() at main.c:648)
DEBUG1 - 00:16:41.329178082 [16578/16578]: Destroying run_as worker
(in run_as_destroy_worker() at runas.c:709)

Regards,

Simon

--000000000000ecd37c057bea1109
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br></div><div>Hello,<br></div><div>=
	  <p>I&#39;m new to lttng so I tried to follow the &#39;Quick Start&#39; t=
utorial from <a href=3D"http://lttng.org">lttng.org</a>.</p>

<p>I have installed LTTng Stable 2.10 PPA (lttng-tools, lttng-modules-dkms,=
 liblttng-ust-dev).=20
At very beginning I am facing a problem with kernel tracking:</p><pre><code=
>~/lttng_train$ sudo lttng create my
Session my created.
Traces will be written in /home/szymon/lttng-traces/my-20181130-222008
~/lttng_train$ sudo lttng list --kernel
Error: Unable to list kernel events: Kernel tracer not available
Error: Command error<br></code></pre><p>Any ideas? Thanks for support!</p>

<p>Additional info:</p><pre><code>~/lttng_train$ dpkg -l | grep lttng
 ii  liblttng-ctl0:amd64                         2.10.5-1~ubuntu16.04.1    =
                   amd64        LTTng control and utility library
 ii  liblttng-ust-ctl4:amd64                     2.10.2-1~ubuntu16.04.1    =
                   amd64        LTTng 2.0 Userspace Tracer (trace control l=
ibrary)
 ii  liblttng-ust-dev:amd64                      2.10.2-1~ubuntu16.04.1    =
                   amd64        LTTng 2.0 Userspace Tracer (development fil=
es)
 ii  liblttng-ust-python-agent0:amd64            2.10.2-1~ubuntu16.04.1    =
                   amd64        LTTng 2.0 Userspace Tracer (Python agent na=
tive library)
 ii  liblttng-ust0:amd64                         2.10.2-1~ubuntu16.04.1    =
                   amd64        LTTng 2.0 Userspace Tracer (tracing librari=
es)
 ii  lttng-modules-dkms                          2.10.8-1~ubuntu16.04.1    =
                   all          Linux Trace Toolkit (LTTng) kernel modules =
(DKMS)
 ii  lttng-tools                                 2.10.5-1~ubuntu16.04.1    =
                   amd64        LTTng control and utility programs

~$ uname -a
Linux szymon 4.4.0-98-generic #121-Ubuntu SMP Tue Oct 10 14:24:03 UTC 2017 =
x86_64 x86_64 x86_64 GNU/Linux

~$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 16.04.5 LTS
Release:    16.04
Codename:   xenial

~/lttng_train$ ps aux | grep lttng-sessiond
root      7862  0.0  0.3 859960 10880 ?        Ssl  19:12   0:00 /usr/bin/l=
ttng-sessiond
szymon   14853  0.0  0.0  15440   936 pts/1    S+   22:21   0:00 grep --col=
or=3Dauto lttng-sessiond

~/lttng_train$ lsmod | grep lttng
~/<br><br>~/lttng_train$ sudo lttng-sessiond -vvv<br>DEBUG1 - 00:16:41.3286=
43679 [16578/16578]: [sessiond configuration]<br>DEBUG1 - 00:16:41.32871514=
2 [16578/16578]: 	verbose:                       3<br>DEBUG1 - 00:16:41.328=
723618 [16578/16578]: 	verbose consumer:              0<br>DEBUG1 - 00:16:4=
1.328729230 [16578/16578]: 	quiet mode:                    False<br>DEBUG1 =
- 00:16:41.328735428 [16578/16578]: 	agent_tcp_port:                [5345, =
5354]<br>DEBUG1 - 00:16:41.328741084 [16578/16578]: 	application socket tim=
eout:    5<br>DEBUG1 - 00:16:41.328761096 [16578/16578]: 	no-kernel:       =
              False<br>DEBUG1 - 00:16:41.328776829 [16578/16578]: 	backgrou=
nd:                    False<br>DEBUG1 - 00:16:41.328788328 [16578/16578]: =
	daemonize:                     False<br>DEBUG1 - 00:16:41.328800092 [16578=
/16578]: 	signal parent on start:        False<br>DEBUG1 - 00:16:41.3288121=
53 [16578/16578]: 	tracing group name:            tracing<br>DEBUG1 - 00:16=
:41.328823395 [16578/16578]: 	kmod_probe_list:               None<br>DEBUG1=
 - 00:16:41.328834022 [16578/16578]: 	kmod_extra_probe_list:         None<b=
r>DEBUG1 - 00:16:41.328848328 [16578/16578]: 	rundir:                      =
  /var/run/lttng<br>DEBUG1 - 00:16:41.328857048 [16578/16578]: 	application=
 socket path:       /var/run/lttng/lttng-ust-sock-7<br>DEBUG1 - 00:16:41.32=
8866302 [16578/16578]: 	client socket path:            /var/run/lttng/clien=
t-lttng-sessiond<br>DEBUG1 - 00:16:41.328881494 [16578/16578]: 	wait shm pa=
th:                 /lttng-ust-wait-7<br>DEBUG1 - 00:16:41.328890337 [16578=
/16578]: 	health socket path:            /var/run/lttng/sessiond-health<br>=
DEBUG1 - 00:16:41.328896087 [16578/16578]: 	LTTNG_UST_CLOCK_PLUGIN:        =
None<br>DEBUG1 - 00:16:41.328902562 [16578/16578]: 	pid file path:         =
        /var/run/lttng/lttng-sessiond.pid<br>DEBUG1 - 00:16:41.328909781 [1=
6578/16578]: 	lock file path:                /var/run/lttng/lttng-sessiond.=
lck<br>DEBUG1 - 00:16:41.328916938 [16578/16578]: 	session load path:      =
       None<br>DEBUG1 - 00:16:41.328924592 [16578/16578]: 	agent port file =
path:          /var/run/lttng/agent.port<br>DEBUG1 - 00:16:41.328936395 [16=
578/16578]: 	consumerd32 path:              /var/run/lttng/ustconsumerd32<b=
r>DEBUG1 - 00:16:41.328947517 [16578/16578]: 	consumerd32 bin path:        =
  Unknown<br>DEBUG1 - 00:16:41.328961683 [16578/16578]: 	consumerd32 lib di=
r:           Unknown<br>DEBUG1 - 00:16:41.328970009 [16578/16578]: 	consume=
rd32 err unix sock path:/var/run/lttng/ustconsumerd32/error<br>DEBUG1 - 00:=
16:41.328977730 [16578/16578]: 	consumerd32 cmd unix sock path:/var/run/ltt=
ng/ustconsumerd32/command<br>DEBUG1 - 00:16:41.328985023 [16578/16578]: 	co=
nsumerd64 path:              /var/run/lttng/ustconsumerd64<br>DEBUG1 - 00:1=
6:41.328992714 [16578/16578]: 	consumerd64 bin path:          /usr/lib/x86_=
64-linux-gnu/lttng/libexec/lttng-consumerd<br>DEBUG1 - 00:16:41.329005793 [=
16578/16578]: 	consumerd64 lib dir:           /usr/lib/x86_64-linux-gnu<br>=
DEBUG1 - 00:16:41.329017089 [16578/16578]: 	consumerd64 err unix sock path:=
/var/run/lttng/ustconsumerd64/error<br>DEBUG1 - 00:16:41.329028919 [16578/1=
6578]: 	consumerd64 cmd unix sock path:/var/run/lttng/ustconsumerd64/comman=
d<br>DEBUG1 - 00:16:41.329040967 [16578/16578]: 	kconsumerd path:          =
     /var/run/lttng/kconsumerd<br>DEBUG1 - 00:16:41.329053218 [16578/16578]=
: 	kconsumerd err unix sock path: /var/run/lttng/kconsumerd/error<br>DEBUG1=
 - 00:16:41.329064330 [16578/16578]: 	kconsumerd cmd unix sock path: /var/r=
un/lttng/kconsumerd/command<br>DEBUG3 - 00:16:41.329076040 [16578/16578]: C=
reating LTTng run directory: /var/run/lttng (in create_lttng_rundir() at ma=
in.c:5306)<br>Error: A session daemon is already running.<br>DEBUG1 - 00:16=
:41.329161207 [16578/16578]: Cleaning up options (in sessiond_cleanup_optio=
ns() at main.c:648)<br>DEBUG1 - 00:16:41.329178082 [16578/16578]: Destroyin=
g run_as worker (in run_as_destroy_worker() at runas.c:709)<br><br></code><=
/pre><pre><code>Regards, <br></code></pre><pre><code>Simon <br></code></pre=
></div></div></div>

--000000000000ecd37c057bea1109--

--===============1428468084456159282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1428468084456159282==--
