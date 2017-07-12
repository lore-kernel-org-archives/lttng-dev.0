From: Saty Anand <satyanandiam@gmail.com>
Subject: cross-compiling LTTNG for android on arm64
Date: Wed, 12 Jul 2017 15:55:07 +0530
Message-ID: <CAEj5SC4wFV=sfpddaNbdipcsLT7A2s31vGCT79y_vqyH1W5TwA__25272.0813420185$1499868981$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6102170217734461164=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wr0-x22a.google.com (mail-wr0-x22a.google.com
 [IPv6:2a00:1450:400c:c0c::22a])
 by lists.lttng.org (Postfix) with ESMTPS id 3x6w9Z3jylz13fB
 for <lttng-dev@lists.lttng.org>; Wed, 12 Jul 2017 10:26:58 +0000 (UTC)
Received: by mail-wr0-x22a.google.com with SMTP id 77so27408720wrb.1
 for <lttng-dev@lists.lttng.org>; Wed, 12 Jul 2017 03:25:09 -0700 (PDT)
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

--===============6102170217734461164==
Content-Type: multipart/alternative; boundary="001a11442d40eda1c805541c3aba"

--001a11442d40eda1c805541c3aba
Content-Type: text/plain; charset="UTF-8"

Hi all

I've been trying to compile LTTng for android on arm architecture. Taking
reference from https://lists.lttng.org/pipermail/lttng-dev/2013-
February/019652.html I've been building Lttng-UST and Lttng-tools.
Cross-compiling the kernel is having some issues:

Using the following command to cross-compile Lttng modules:
make KERNELDIR=/local....../obj/KERNEL_OBJ/ ARCH=arm64
CROSS_COMPILE=/local/..../prebuilts/gcc/linux-x86/
aarch64/aarch64-linuxandroid-4.9/bin/aarch64-linux-android-
But it gives the following errors:

error: conflicting types for 'trace_sched_migrate_task'
 void trace_##_name(_proto);
      ^
/local/......./../lttng_pos/lttng-modules-2.9.3/probes/../probes/lttng-tracepoint-event-impl.h:54:2:
note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP'
  LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(map, name, map, PARAMS(proto),
PARAMS(args))
  ^
/local/......./../lttng_pos/lttng-modules-2.9.3/probes/../probes/lttng-tracepoint-event-impl.h:96:2:
note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT_MAP'
  LTTNG_TRACEPOINT_EVENT_MAP(name, name,    \
  ^
/local/...../../lttng_pos/lttng-modules-2.9.3/probes/../instrumentation/events/lttng-module/sched.h:285:1:
note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT'
 LTTNG_TRACEPOINT_EVENT(sched_migrate_task,
 ^
In file included from /local/..../kernel/include/linux/module.h:18:0,
                 from
/local/....../../lttng_pos/lttng-modules-2.9.3/probes/lttng-probe-sched.c:23:
/local/....../kernel/include/linux/tracepoint.h:168:21: note: previous
definition of 'trace_sched_migrate_task' was here
  static inline void trace_##name(proto)    \
                     ^
/local/..../kernel/include/linux/tracepoint.h:275:3: note: in expansion of
macro '__DECLARE_TRACE'
   __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args), 1, \
   ^
/local/.../kernel/include/linux/tracepoint.h:405:2: note: in expansion of
macro 'DECLARE_TRACE'
  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
  ^
/local/..../kernel/include/trace/events/sched.h:580:1: note: in expansion
of macro 'TRACE_EVENT'
 TRACE_EVENT(sched_migrate_task,

Am I not compiling the kernel modules how it's supposed to be?

Thank you
Saty Anand

--001a11442d40eda1c805541c3aba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi all</div><div><br></div><div>I&#39;ve been trying =
to compile LTTng for android on arm architecture. Taking reference from <a =
href=3D"https://lists.lttng.org/pipermail/lttng-dev/2013-February/019652.ht=
ml" target=3D"_blank">https://lists.lttng.org/<wbr>pipermail/lttng-dev/2013=
-<wbr>February/019652.html</a> I&#39;ve been building Lttng-UST and Lttng-t=
ools. Cross-compiling the kernel is having some issues:</div><div><br></div=
><div><span><span>Using the following command to cross-compile Lttng module=
s:</span></span></div><div><span><span>make KERNELDIR=3D/local....../obj/<w=
br>KERNEL_OBJ/ ARCH=3Darm64 CROSS_COMPILE=3D/local/..../<wbr>prebuilts/gcc/=
linux-x86/<wbr>aarch64/aarch64-linuxandroid-<wbr>4.9/bin/aarch64-linux-andr=
oid-</span></span></div><span><div>But it gives the following errors:</div>=
<div><br></div><div>error: conflicting types for &#39;trace_sched_migrate_t=
ask&#39;<br>=C2=A0void trace_##_name(_proto);<br>=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ^<br>/local/......./../lttng_pos/lttng-modules-2.9.3/probes/../probe=
s/lttng-tracepoint-event-impl.h:54:2: note: in expansion of macro &#39;LTTN=
G_TRACEPOINT_EVENT_INSTANCE_MAP&#39;<br>=C2=A0 LTTNG_TRACEPOINT_EVENT_INSTA=
NCE_MAP(map, name, map, PARAMS(proto), PARAMS(args))<br>=C2=A0 ^<br>/local/=
......./../lttng_pos/lttng-modules-2.9.3/probes/../probes/lttng-tracepoint-=
event-impl.h:96:2: note: in expansion of macro &#39;LTTNG_TRACEPOINT_EVENT_=
MAP&#39;<br>=C2=A0 LTTNG_TRACEPOINT_EVENT_MAP(name, name,=C2=A0=C2=A0=C2=A0=
 \<br>=C2=A0 ^<br>/local/...../../lttng_pos/lttng-modules-2.9.3/probes/../i=
nstrumentation/events/lttng-module/sched.h:285:1: note: in expansion of mac=
ro &#39;LTTNG_TRACEPOINT_EVENT&#39;<br>=C2=A0LTTNG_TRACEPOINT_EVENT(sched_m=
igrate_task,<br>=C2=A0^<br>In file included from /local/..../kernel/include=
/linux/module.h:18:0,<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from /local/....../../lttn=
g_pos/lttng-modules-2.9.3/probes/lttng-probe-sched.c:23:<br>/local/....../k=
ernel/include/linux/tracepoint.h:168:21: note: previous definition of &#39;=
trace_sched_migrate_task&#39; was here<br>=C2=A0 static inline void trace_#=
#name(proto)=C2=A0=C2=A0=C2=A0 \<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ^<br>/local/..../kernel/include/linux/tracepoint.h:275:3: note: in e=
xpansion of macro &#39;__DECLARE_TRACE&#39;<br>=C2=A0=C2=A0 __DECLARE_TRACE=
(name, PARAMS(proto), PARAMS(args), 1, \<br>=C2=A0=C2=A0 ^<br>/local/.../ke=
rnel/include/linux/tracepoint.h:405:2: note: in expansion of macro &#39;DEC=
LARE_TRACE&#39;<br>=C2=A0 DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))<=
br>=C2=A0 ^<br>/local/..../kernel/include/trace/events/sched.h:580:1: note:=
 in expansion of macro &#39;TRACE_EVENT&#39;<br>=C2=A0TRACE_EVENT(sched_mig=
rate_task,<br></div><div><br></div><div>Am I not compiling the kernel modul=
es how it&#39;s supposed to be? </div><div><br></div><div>Thank you</div><d=
iv>Saty Anand<span><span><br></span></span></div><span></span></span></div>

--001a11442d40eda1c805541c3aba--

--===============6102170217734461164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6102170217734461164==--
