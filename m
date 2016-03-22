From: Alexis Martin <alexis.martin@inria.fr>
Subject: lttng-modules build fail on Jetson TK1
Date: Tue, 22 Mar 2016 15:07:14 +0100
Message-ID: <461CE2C8-305B-44A9-8D0D-0C89E909F8F3__23778.4839388498$1458670326$gmane$org@inria.fr>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/mixed; boundary="===============7461550620733854526=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 7133AA07A3
 for <lttng-dev@lists.lttng.org>; Tue, 22 Mar 2016 14:07:16 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============7461550620733854526==
Content-Type: multipart/alternative; boundary="Apple-Mail=_D23F6AA7-D323-4EE9-A94E-B686ECE03EDB"


--Apple-Mail=_D23F6AA7-D323-4EE9-A94E-B686ECE03EDB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi,

I=E2=80=99m trying to install lttng on my Jetson TK1, but I can=E2=80=99t =
build the lttng kernel module.

I=E2=80=99m running the last kernel available from JetPack2.1, Linux for =
Tegra r21.4, which is a LTS ubuntu 14.04.4 LTS (GNU/Linux =
3.10.40-gdacac96 armv7l)
This kernel satisfies configuration required =
(CONFIG_MODULES,CONFIG_KALLSYMS,CONFIG_HIGH_RES_TIMERS,CONFIG_TRACEPOINTS)=
.

I=E2=80=99m using the git tree on tag v2.8.0-rc1. Installation of =
userspace-rcu, lttng-ust, and lttng-tools was fine, but when I build =
lttng-modules I got this error related to the TP_FIELDS macro:

> ubuntu@tegra-ubuntu:~/install-lttng/lttng-modules$ make=20
> make -C /lib/modules/3.10.40-gdacac96/build =
M=3D/home/ubuntu/install-lttng/lttng-modules CONFIG_LTTNG=3Dm modules
> make[1]: Entering directory `/usr/src/linux-headers-3.10.40-gdacac96'
>   CC [M]  =
/home/ubuntu/install-lttng/lttng-modules/lttng-ring-buffer-client-discard.=
o
>   CC [M]  =
/home/ubuntu/install-lttng/lttng-modules/lttng-ring-buffer-client-overwrit=
e.o
>   CC [M]  =
/home/ubuntu/install-lttng/lttng-modules/lttng-ring-buffer-metadata-client=
.o
>   CC [M]  =
/home/ubuntu/install-lttng/lttng-modules/lttng-ring-buffer-client-mmap-dis=
card.o
>   CC [M]  =
/home/ubuntu/install-lttng/lttng-modules/lttng-ring-buffer-client-mmap-ove=
rwrite.o
>   CC [M]  =
/home/ubuntu/install-lttng/lttng-modules/lttng-ring-buffer-metadata-mmap-c=
lient.o
>   CC [M]  /home/ubuntu/install-lttng/lttng-modules/lttng-clock.o
>   CC [M]  =
/home/ubuntu/install-lttng/lttng-modules/lttng-statedump-impl.o
>   CC [M]  /home/ubuntu/install-lttng/lttng-modules/wrapper/irqdesc.o
>   CC [M]  /home/ubuntu/install-lttng/lttng-modules/wrapper/fdtable.o
>   CC [M]  /home/ubuntu/install-lttng/lttng-modules/lttng-events.o
>   CC [M]  /home/ubuntu/install-lttng/lttng-modules/lttng-abi.o
>   CC [M]  /home/ubuntu/install-lttng/lttng-modules/lttng-probes.o
>   CC [M]  /home/ubuntu/install-lttng/lttng-modules/lttng-context.o
>   CC [M]  /home/ubuntu/install-lttng/lttng-modules/lttng-context-pid.o
>   CC [M]  =
/home/ubuntu/install-lttng/lttng-modules/lttng-context-procname.o
>   CC [M]  =
/home/ubuntu/install-lttng/lttng-modules/lttng-context-prio.o
>   CC [M]  =
/home/ubuntu/install-lttng/lttng-modules/lttng-context-nice.o
>   CC [M]  =
/home/ubuntu/install-lttng/lttng-modules/lttng-context-vpid.o
>   CC [M]  /home/ubuntu/install-lttng/lttng-modules/lttng-context-tid.o
>   CC [M]  =
/home/ubuntu/install-lttng/lttng-modules/lttng-context-vtid.o
>   CC [M]  =
/home/ubuntu/install-lttng/lttng-modules/lttng-context-ppid.o
>   CC [M]  =
/home/ubuntu/install-lttng/lttng-modules/lttng-context-vppid.o
>   CC [M]  =
/home/ubuntu/install-lttng/lttng-modules/lttng-context-cpu-id.o
>   CC [M]  =
/home/ubuntu/install-lttng/lttng-modules/lttng-context-interruptible.o
>   CC [M]  =
/home/ubuntu/install-lttng/lttng-modules/lttng-context-need-reschedule.o
>   CC [M]  /home/ubuntu/install-lttng/lttng-modules/lttng-calibrate.o
>   CC [M]  =
/home/ubuntu/install-lttng/lttng-modules/lttng-context-hostname.o
>   CC [M]  /home/ubuntu/install-lttng/lttng-modules/wrapper/random.o
>   CC [M]  /home/ubuntu/install-lttng/lttng-modules/probes/lttng.o
>   CC [M]  =
/home/ubuntu/install-lttng/lttng-modules/wrapper/trace-clock.o
>   CC [M]  =
/home/ubuntu/install-lttng/lttng-modules/wrapper/page_alloc.o
>   CC [M]  /home/ubuntu/install-lttng/lttng-modules/lttng-tracker-pid.o
>   CC [M]  /home/ubuntu/install-lttng/lttng-modules/lttng-filter.o
>   CC [M]  =
/home/ubuntu/install-lttng/lttng-modules/lttng-filter-interpreter.o
>   CC [M]  =
/home/ubuntu/install-lttng/lttng-modules/lttng-filter-specialize.o
>   CC [M]  =
/home/ubuntu/install-lttng/lttng-modules/lttng-filter-validator.o
>   CC [M]  =
/home/ubuntu/install-lttng/lttng-modules/probes/lttng-probe-user.o
>   CC [M]  /home/ubuntu/install-lttng/lttng-modules/lttng-syscalls.o
> =
/home/ubuntu/install-lttng/lttng-modules/instrumentation/syscalls/headers/=
arm-32-syscalls-3.4.25_integers.h:14:11: error: expected =E2=80=98)=E2=80=99=
 before =E2=80=98(=E2=80=99 token
>   TP_FIELDS()
>            ^
> /home/ubuntu/install-lttng/lttng-modules/lttng-syscalls.c:97:25: note: =
in definition of macro =E2=80=98PARAMS=E2=80=99
>  #define PARAMS(args...) args
>                          ^
> =
/home/ubuntu/install-lttng/lttng-modules/instrumentation/syscalls/headers/=
arm-32-syscalls-3.4.25_integers.h:13:1: note: in expansion of macro =
=E2=80=98SC_LTTNG_TRACEPOINT_EVENT_CLASS_NOARGS=E2=80=99
>  SC_LTTNG_TRACEPOINT_EVENT_CLASS_NOARGS(syscalls_noargs,
>  ^
> /home/ubuntu/install-lttng/lttng-modules/lttng-syscalls.c:286:41: =
error: array type has incomplete element type
>  static const struct trace_syscall_entry sc_table[] =3D {
>                                          ^
> In file included from =
/home/ubuntu/install-lttng/lttng-modules/instrumentation/syscalls/headers/=
arm-32-syscalls-3.4.25_integers.h:828:0,
>                  from =
/home/ubuntu/install-lttng/lttng-modules/instrumentation/syscalls/headers/=
syscalls_integers.h:10,
>                  from =
/home/ubuntu/install-lttng/lttng-modules/lttng-syscalls.c:287:
> =
/home/ubuntu/install-lttng/lttng-modules/instrumentation/syscalls/headers/=
arm-32-syscalls-3.4.25_integers_override.h:131:1: error: array index in =
non-array initializer
>  TRACE_SYSCALL_TABLE(mmap, mmap, 90, 6)
>  ^
> =
/home/ubuntu/install-lttng/lttng-modules/instrumentation/syscalls/headers/=
arm-32-syscalls-3.4.25_integers_override.h:131:1: error: (near =
initialization for =E2=80=98sc_table=E2=80=99)
> =
/home/ubuntu/install-lttng/lttng-modules/instrumentation/syscalls/headers/=
arm-32-syscalls-3.4.25_integers_override.h:131:1: error: field name not =
in record or union initializer
> =
/home/ubuntu/install-lttng/lttng-modules/instrumentation/syscalls/headers/=
arm-32-syscalls-3.4.25_integers_override.h:131:1: error: (near =
initialization for =E2=80=98sc_table=E2=80=99)
> /home/ubuntu/install-lttng/lttng-modules/lttng-syscalls.c:279:11: =
error: =E2=80=98__event_probe__syscall_entry_mmap=E2=80=99 undeclared =
here (not in a function)
>    .func =3D __event_probe__syscall_entry_##_template, \
> =E2=80=A6

Any idea of the cause of this error ?
I saw the file arm-32-syscalls-3.4.25_integers.h is auto-generated, =
should the number match my kernel version ?

Thanks,
=E2=80=94
Alexis Martin
PhD. Student
INRIA / LIG POLARIS-Team


--Apple-Mail=_D23F6AA7-D323-4EE9-A94E-B686ECE03EDB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D"">Hi,<div class=3D""><br class=3D""></div><div class=3D"">I=E2=80=
=99m trying to install lttng on my Jetson TK1, but I can=E2=80=99t build =
the lttng kernel module.</div><div class=3D""><br class=3D""></div><div =
class=3D"">I=E2=80=99m running the last kernel available from =
JetPack2.1, Linux for Tegra r21.4, which is a LTS ubuntu&nbsp;14.04.4 =
LTS&nbsp;(GNU/Linux 3.10.40-gdacac96 armv7l)</div><div class=3D"">This =
kernel satisfies configuration required (<span style=3D"font-family: =
Menlo; font-size: 11px;" class=3D"">CONFIG_MODULES,</span><span =
style=3D"font-family: Menlo; font-size: 11px;" =
class=3D"">CONFIG_KALLSYMS,</span><span style=3D"font-family: Menlo; =
font-size: 11px;" class=3D"">CONFIG_HIGH_RES_TIMERS,</span><span =
style=3D"font-family: Menlo; font-size: 11px;" =
class=3D"">CONFIG_TRACEPOINTS</span>).</div><div class=3D""><br =
class=3D""></div><div class=3D"">I=E2=80=99m using the git tree on tag =
v2.8.0-rc1. Installation of userspace-rcu, lttng-ust, and lttng-tools =
was fine, but when I build lttng-modules I got this error related to the =
TP_FIELDS macro:</div><div class=3D""><br class=3D""></div><div =
class=3D""><div style=3D"margin: 0px; font-size: 11px; line-height: =
normal; font-family: Menlo;" class=3D""></div><blockquote type=3D"cite" =
class=3D""><div style=3D"margin: 0px; font-size: 11px; line-height: =
normal; font-family: Menlo;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">ubuntu@tegra-ubuntu:~/install-lttng/lttng-modules$ =
make&nbsp;</span></div><div style=3D"margin: 0px; font-size: 11px; =
line-height: normal; font-family: Menlo;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D"">make -C =
/lib/modules/3.10.40-gdacac96/build =
M=3D/home/ubuntu/install-lttng/lttng-modules CONFIG_LTTNG=3Dm =
modules</span></div><div style=3D"margin: 0px; font-size: 11px; =
line-height: normal; font-family: Menlo;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D"">make[1]: =
Entering directory =
`/usr/src/linux-headers-3.10.40-gdacac96'</span></div><div =
style=3D"margin: 0px; font-size: 11px; line-height: normal; font-family: =
Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-ring-buffer-client-discard.=
o</span></div><div style=3D"margin: 0px; font-size: 11px; line-height: =
normal; font-family: Menlo;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D"">&nbsp; =
CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-ring-buffer-client-overwrit=
e.o</span></div><div style=3D"margin: 0px; font-size: 11px; line-height: =
normal; font-family: Menlo;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D"">&nbsp; =
CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-ring-buffer-metadata-client=
.o</span></div><div style=3D"margin: 0px; font-size: 11px; line-height: =
normal; font-family: Menlo;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D"">&nbsp; =
CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-ring-buffer-client-mmap-dis=
card.o</span></div><div style=3D"margin: 0px; font-size: 11px; =
line-height: normal; font-family: Menlo;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D"">&nbsp; =
CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-ring-buffer-client-mmap-ove=
rwrite.o</span></div><div style=3D"margin: 0px; font-size: 11px; =
line-height: normal; font-family: Menlo;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D"">&nbsp; =
CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-ring-buffer-metadata-mmap-c=
lient.o</span></div><div style=3D"margin: 0px; font-size: 11px; =
line-height: normal; font-family: Menlo;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D"">&nbsp; =
CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-clock.o</span></div><div =
style=3D"margin: 0px; font-size: 11px; line-height: normal; font-family: =
Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-statedump-impl.o</span></di=
v><div style=3D"margin: 0px; font-size: 11px; line-height: normal; =
font-family: Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/wrapper/irqdesc.o</span></div><di=
v style=3D"margin: 0px; font-size: 11px; line-height: normal; =
font-family: Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/wrapper/fdtable.o</span></div><di=
v style=3D"margin: 0px; font-size: 11px; line-height: normal; =
font-family: Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-events.o</span></div><div =
style=3D"margin: 0px; font-size: 11px; line-height: normal; font-family: =
Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-abi.o</span></div><div =
style=3D"margin: 0px; font-size: 11px; line-height: normal; font-family: =
Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-probes.o</span></div><div =
style=3D"margin: 0px; font-size: 11px; line-height: normal; font-family: =
Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-context.o</span></div><div =
style=3D"margin: 0px; font-size: 11px; line-height: normal; font-family: =
Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-context-pid.o</span></div><=
div style=3D"margin: 0px; font-size: 11px; line-height: normal; =
font-family: Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-context-procname.o</span></=
div><div style=3D"margin: 0px; font-size: 11px; line-height: normal; =
font-family: Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-context-prio.o</span></div>=
<div style=3D"margin: 0px; font-size: 11px; line-height: normal; =
font-family: Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-context-nice.o</span></div>=
<div style=3D"margin: 0px; font-size: 11px; line-height: normal; =
font-family: Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-context-vpid.o</span></div>=
<div style=3D"margin: 0px; font-size: 11px; line-height: normal; =
font-family: Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-context-tid.o</span></div><=
div style=3D"margin: 0px; font-size: 11px; line-height: normal; =
font-family: Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-context-vtid.o</span></div>=
<div style=3D"margin: 0px; font-size: 11px; line-height: normal; =
font-family: Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-context-ppid.o</span></div>=
<div style=3D"margin: 0px; font-size: 11px; line-height: normal; =
font-family: Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-context-vppid.o</span></div=
><div style=3D"margin: 0px; font-size: 11px; line-height: normal; =
font-family: Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-context-cpu-id.o</span></di=
v><div style=3D"margin: 0px; font-size: 11px; line-height: normal; =
font-family: Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-context-interruptible.o</sp=
an></div><div style=3D"margin: 0px; font-size: 11px; line-height: =
normal; font-family: Menlo;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D"">&nbsp; =
CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-context-need-reschedule.o</=
span></div><div style=3D"margin: 0px; font-size: 11px; line-height: =
normal; font-family: Menlo;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D"">&nbsp; =
CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-calibrate.o</span></div><di=
v style=3D"margin: 0px; font-size: 11px; line-height: normal; =
font-family: Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-context-hostname.o</span></=
div><div style=3D"margin: 0px; font-size: 11px; line-height: normal; =
font-family: Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/wrapper/random.o</span></div><div=
 style=3D"margin: 0px; font-size: 11px; line-height: normal; =
font-family: Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/probes/lttng.o</span></div><div =
style=3D"margin: 0px; font-size: 11px; line-height: normal; font-family: =
Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/wrapper/trace-clock.o</span></div=
><div style=3D"margin: 0px; font-size: 11px; line-height: normal; =
font-family: Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/wrapper/page_alloc.o</span></div>=
<div style=3D"margin: 0px; font-size: 11px; line-height: normal; =
font-family: Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-tracker-pid.o</span></div><=
div style=3D"margin: 0px; font-size: 11px; line-height: normal; =
font-family: Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-filter.o</span></div><div =
style=3D"margin: 0px; font-size: 11px; line-height: normal; font-family: =
Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-filter-interpreter.o</span>=
</div><div style=3D"margin: 0px; font-size: 11px; line-height: normal; =
font-family: Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-filter-specialize.o</span><=
/div><div style=3D"margin: 0px; font-size: 11px; line-height: normal; =
font-family: Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-filter-validator.o</span></=
div><div style=3D"margin: 0px; font-size: 11px; line-height: normal; =
font-family: Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/probes/lttng-probe-user.o</span><=
/div><div style=3D"margin: 0px; font-size: 11px; line-height: normal; =
font-family: Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; CC [M]&nbsp; =
/home/ubuntu/install-lttng/lttng-modules/lttng-syscalls.o</span></div><div=
 style=3D"margin: 0px; font-size: 11px; line-height: normal; =
font-family: Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" =
class=3D"">/home/ubuntu/install-lttng/lttng-modules/instrumentation/syscal=
ls/headers/arm-32-syscalls-3.4.25_integers.h:14:11: error: expected =
=E2=80=98)=E2=80=99 before =E2=80=98(=E2=80=99 token</span></div><div =
style=3D"margin: 0px; font-size: 11px; line-height: normal; font-family: =
Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp; TP_FIELDS()</span></div><div =
style=3D"margin: 0px; font-size: 11px; line-height: normal; font-family: =
Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
^</span></div><div style=3D"margin: 0px; font-size: 11px; line-height: =
normal; font-family: Menlo;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">/home/ubuntu/install-lttng/lttng-modules/lttng-syscalls.c:97:25=
: note: in definition of macro =E2=80=98PARAMS=E2=80=99</span></div><div =
style=3D"margin: 0px; font-size: 11px; line-height: normal; font-family: =
Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;#define PARAMS(args...) =
args</span></div><div style=3D"margin: 0px; font-size: 11px; =
line-height: normal; font-family: Menlo;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; ^</span></div><div style=3D"margin: 0px; =
font-size: 11px; line-height: normal; font-family: Menlo;" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">/home/ubuntu/install-lttng/lttng-modules/instrumentation/syscal=
ls/headers/arm-32-syscalls-3.4.25_integers.h:13:1: note: in expansion of =
macro =E2=80=98SC_LTTNG_TRACEPOINT_EVENT_CLASS_NOARGS=E2=80=99</span></div=
><div style=3D"margin: 0px; font-size: 11px; line-height: normal; =
font-family: Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" =
class=3D"">&nbsp;SC_LTTNG_TRACEPOINT_EVENT_CLASS_NOARGS(syscalls_noargs,</=
span></div><div style=3D"margin: 0px; font-size: 11px; line-height: =
normal; font-family: Menlo;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;^</span></div><div style=3D"margin: 0px; font-size: =
11px; line-height: normal; font-family: Menlo;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">/home/ubuntu/install-lttng/lttng-modules/lttng-syscalls.c:286:4=
1: error: array type has incomplete element type</span></div><div =
style=3D"margin: 0px; font-size: 11px; line-height: normal; font-family: =
Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;static const struct =
trace_syscall_entry sc_table[] =3D {</span></div><div style=3D"margin: =
0px; font-size: 11px; line-height: normal; font-family: Menlo;" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; ^</span></div><div style=3D"margin: 0px; font-size: 11px; =
line-height: normal; font-family: Menlo;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D"">In file =
included from =
/home/ubuntu/install-lttng/lttng-modules/instrumentation/syscalls/headers/=
arm-32-syscalls-3.4.25_integers.h:828:0,</span></div><div style=3D"margin:=
 0px; font-size: 11px; line-height: normal; font-family: Menlo;" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
from =
/home/ubuntu/install-lttng/lttng-modules/instrumentation/syscalls/headers/=
syscalls_integers.h:10,</span></div><div style=3D"margin: 0px; =
font-size: 11px; line-height: normal; font-family: Menlo;" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
from =
/home/ubuntu/install-lttng/lttng-modules/lttng-syscalls.c:287:</span></div=
><div style=3D"margin: 0px; font-size: 11px; line-height: normal; =
font-family: Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" =
class=3D"">/home/ubuntu/install-lttng/lttng-modules/instrumentation/syscal=
ls/headers/arm-32-syscalls-3.4.25_integers_override.h:131:1: error: =
array index in non-array initializer</span></div><div style=3D"margin: =
0px; font-size: 11px; line-height: normal; font-family: Menlo;" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;TRACE_SYSCALL_TABLE(mmap, mmap, 90, 6)</span></div><div =
style=3D"margin: 0px; font-size: 11px; line-height: normal; font-family: =
Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;^</span></div><div style=3D"margin: =
0px; font-size: 11px; line-height: normal; font-family: Menlo;" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">/home/ubuntu/install-lttng/lttng-modules/instrumentation/syscal=
ls/headers/arm-32-syscalls-3.4.25_integers_override.h:131:1: error: =
(near initialization for =E2=80=98sc_table=E2=80=99)</span></div><div =
style=3D"margin: 0px; font-size: 11px; line-height: normal; font-family: =
Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" =
class=3D"">/home/ubuntu/install-lttng/lttng-modules/instrumentation/syscal=
ls/headers/arm-32-syscalls-3.4.25_integers_override.h:131:1: error: =
field name not in record or union initializer</span></div><div =
style=3D"margin: 0px; font-size: 11px; line-height: normal; font-family: =
Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" =
class=3D"">/home/ubuntu/install-lttng/lttng-modules/instrumentation/syscal=
ls/headers/arm-32-syscalls-3.4.25_integers_override.h:131:1: error: =
(near initialization for =E2=80=98sc_table=E2=80=99)</span></div><div =
style=3D"margin: 0px; font-size: 11px; line-height: normal; font-family: =
Menlo;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" =
class=3D"">/home/ubuntu/install-lttng/lttng-modules/lttng-syscalls.c:279:1=
1: error: =E2=80=98__event_probe__syscall_entry_mmap=E2=80=99 undeclared =
here (not in a function)</span></div><div style=3D"margin: 0px; =
font-size: 11px; line-height: normal; font-family: Menlo;" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;&nbsp; .func =3D =
__event_probe__syscall_entry_##_template, \</span></div><div =
style=3D"margin: 0px; font-size: 11px; line-height: normal; font-family: =
Menlo;" class=3D"">=E2=80=A6</div></blockquote><p style=3D"margin: 0px; =
font-size: 11px; line-height: normal; font-family: Menlo; min-height: =
13px;" class=3D""><br class=3D""></p><p style=3D"margin: 0px; =
line-height: normal; min-height: 13px;" class=3D"">Any idea of the cause =
of this error ?</p><div class=3D"">I saw the file&nbsp;<span =
style=3D"font-family: Menlo; font-size: 11px;" =
class=3D"">arm-32-syscalls-3.4.25_integers.h </span>is auto-generated, =
should the number match my kernel version ?</div><div class=3D""><br =
class=3D""></div><div class=3D"">Thanks,</div></div><div class=3D""><div =
class=3D"">
<div style=3D"color: rgb(0, 0, 0); letter-spacing: normal; orphans: =
auto; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div style=3D"color: rgb(0, 0, 0); letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div style=3D"color: rgb(0, 0, 0); letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div style=3D"color: rgb(0, 0, 0); letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div style=3D"color: rgb(0, 0, 0); letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D"">=E2=80=94<br class=3D"">Alexis Martin<br class=3D"">PhD. =
Student</div><div style=3D"color: rgb(0, 0, 0); letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D"">INRIA / LIG POLARIS-Team</div></div></div></div></div>
</div>
<br class=3D""></div></body></html>=

--Apple-Mail=_D23F6AA7-D323-4EE9-A94E-B686ECE03EDB--

--===============7461550620733854526==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7461550620733854526==--
