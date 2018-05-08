From: Jonah Benton <jonah@jonah.com>
Subject: Error building lttng 2.10.5 on Fedora 27
Date: Tue, 8 May 2018 16:31:07 -0400
Message-ID: <CANoO=wR7RamMcg+1WH+MGecPYFcyBCkd0Ek-knL32ziWk5YCjg__11490.2045032524$1525811353$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6270967758324793982=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ot0-x232.google.com (mail-ot0-x232.google.com
 [IPv6:2607:f8b0:4003:c0f::232])
 by lists.lttng.org (Postfix) with ESMTPS id 40gWNG0L8fz18RQ
 for <lttng-dev@lists.lttng.org>; Tue,  8 May 2018 16:31:09 -0400 (EDT)
Received: by mail-ot0-x232.google.com with SMTP id t1-v6so37641726oth.8
 for <lttng-dev@lists.lttng.org>; Tue, 08 May 2018 13:31:09 -0700 (PDT)
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

--===============6270967758324793982==
Content-Type: multipart/alternative; boundary="00000000000090ee67056bb7aac3"

--00000000000090ee67056bb7aac3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi folks,

Looking forward to taking lttng for a spin.

I'm on:

[jbenton@localhost lttng-modules-2.10.5]$ uname -a
Linux localhost.localdomain 4.16.5-200.fc27.x86_64 #1 SMP Fri Apr 27
19:05:44 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux

Following along:

https://lttng.org/docs/v2.10/#doc-fedora

I'm failing to build:

[jbenton@localhost lttng-modules-2.10.5]$ make clean
make -C /lib/modules/4.16.5-200.fc27.x86_64/build
M=3D/home/jbenton/src/local/ksoftirq/lttng-modules-2.10.5 clean
make[1]: Entering directory '/usr/src/kernels/4.16.5-200.fc27.x86_64'
make[1]: Leaving directory '/usr/src/kernels/4.16.5-200.fc27.x86_64'

[jbenton@localhost lttng-modules-2.10.5]$ make
make -C /lib/modules/4.16.5-200.fc27.x86_64/build
M=3D/home/jbenton/src/local/ksoftirq/lttng-modules-2.10.5 CONFIG_LTTNG=3Dm
CONFIG_LTTNG_CLOCK_PLUGIN_TEST=3Dm modules
make[1]: Entering directory '/usr/src/kernels/4.16.5-200.fc27.x86_64'
  CC [M]
/home/jbenton/src/local/ksoftirq/lttng-modules-2.10.5/lttng-ring-buffer-cli=
ent-discard.o
...
  CC [M]
/home/jbenton/src/local/ksoftirq/lttng-modules-2.10.5/probes/lttng-probe-sc=
hed.o
  CC [M]
/home/jbenton/src/local/ksoftirq/lttng-modules-2.10.5/probes/lttng-probe-ir=
q.o
  CC [M]
/home/jbenton/src/local/ksoftirq/lttng-modules-2.10.5/probes/lttng-probe-ti=
mer.o
In file included from
/home/jbenton/src/local/ksoftirq/lttng-modules-2.10.5/probes/../probes/defi=
ne_trace.h:100:0,
                 from
/home/jbenton/src/local/ksoftirq/lttng-modules-2.10.5/probes/../instrumenta=
tion/events/lttng-module/timer.h:332,
                 from
/home/jbenton/src/local/ksoftirq/lttng-modules-2.10.5/probes/lttng-probe-ti=
mer.c:43:
/home/jbenton/src/local/ksoftirq/lttng-modules-2.10.5/probes/../probes/lttn=
g-tracepoint-event-impl.h:142:6:
error: conflicting types for =E2=80=98trace_hrtimer_start=E2=80=99
 void trace_##_name(_proto);
      ^

Thoughts?

Thanks!

Jonah

--00000000000090ee67056bb7aac3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi folks,<div><br></div><div>Looking forward to taking ltt=
ng for a spin.</div><div><br></div><div>I&#39;m on:</div><div><br></div><di=
v><div>[jbenton@localhost lttng-modules-2.10.5]$ uname -a</div><div>Linux l=
ocalhost.localdomain 4.16.5-200.fc27.x86_64 #1 SMP Fri Apr 27 19:05:44 UTC =
2018 x86_64 x86_64 x86_64 GNU/Linux</div></div><div><br></div><div>Followin=
g along:</div><div><br></div><div><a href=3D"https://lttng.org/docs/v2.10/#=
doc-fedora">https://lttng.org/docs/v2.10/#doc-fedora</a><br></div><div><br>=
</div><div>I&#39;m failing to build:</div><div><br></div><div><div>[jbenton=
@localhost lttng-modules-2.10.5]$ make clean</div><div>make -C /lib/modules=
/4.16.5-200.fc27.x86_64/build M=3D/home/jbenton/src/local/ksoftirq/lttng-mo=
dules-2.10.5 clean</div><div>make[1]: Entering directory &#39;/usr/src/kern=
els/4.16.5-200.fc27.x86_64&#39;</div><div>make[1]: Leaving directory &#39;/=
usr/src/kernels/4.16.5-200.fc27.x86_64&#39;</div><div><br></div><div>[jbent=
on@localhost lttng-modules-2.10.5]$ make</div><div>make -C /lib/modules/4.1=
6.5-200.fc27.x86_64/build M=3D/home/jbenton/src/local/ksoftirq/lttng-module=
s-2.10.5 CONFIG_LTTNG=3Dm CONFIG_LTTNG_CLOCK_PLUGIN_TEST=3Dm modules</div><=
div>make[1]: Entering directory &#39;/usr/src/kernels/4.16.5-200.fc27.x86_6=
4&#39;</div><div>=C2=A0 CC [M]=C2=A0 /home/jbenton/src/local/ksoftirq/lttng=
-modules-2.10.5/lttng-ring-buffer-client-discard.o</div></div><div>...</div=
><div><div>=C2=A0 CC [M]=C2=A0 /home/jbenton/src/local/ksoftirq/lttng-modul=
es-2.10.5/probes/lttng-probe-sched.o</div><div>=C2=A0 CC [M]=C2=A0 /home/jb=
enton/src/local/ksoftirq/lttng-modules-2.10.5/probes/lttng-probe-irq.o</div=
></div><div><div>=C2=A0 CC [M]=C2=A0 /home/jbenton/src/local/ksoftirq/lttng=
-modules-2.10.5/probes/lttng-probe-timer.o</div><div>In file included from =
/home/jbenton/src/local/ksoftirq/lttng-modules-2.10.5/probes/../probes/defi=
ne_trace.h:100:0,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0from /home/jbenton/src/local/ksoftirq/lttng-modules-2.10.5=
/probes/../instrumentation/events/lttng-module/timer.h:332,</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /home/jbent=
on/src/local/ksoftirq/lttng-modules-2.10.5/probes/lttng-probe-timer.c:43:</=
div><div>/home/jbenton/src/local/ksoftirq/lttng-modules-2.10.5/probes/../pr=
obes/lttng-tracepoint-event-impl.h:142:6: error: conflicting types for =E2=
=80=98trace_hrtimer_start=E2=80=99</div><div>=C2=A0void trace_##_name(_prot=
o);</div><div>=C2=A0 =C2=A0 =C2=A0 ^</div></div><div><br></div><div>Thought=
s?</div><div><br></div><div>Thanks!</div><div><br></div><div>Jonah</div><di=
v><br></div></div>

--00000000000090ee67056bb7aac3--

--===============6270967758324793982==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6270967758324793982==--
