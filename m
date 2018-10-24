From: Alok Priyadarshi <alokpr@gmail.com>
Subject: Adding thread timestamp to event context
Date: Wed, 24 Oct 2018 15:05:08 -0700
Message-ID: <CADwgpi8Nvz4--8V16mU=GoQN5z9dUSvphuSQ3eOL3m0RVYxEeQ__29374.8839795173$1540418603$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6238573106779717526=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 by lists.lttng.org (Postfix) with ESMTPS id 42gPSx24Ttzgdv
 for <lttng-dev@lists.lttng.org>; Wed, 24 Oct 2018 18:05:21 -0400 (EDT)
Received: by mail-yb1-xb31.google.com with SMTP id d18-v6so2815830yba.4
 for <lttng-dev@lists.lttng.org>; Wed, 24 Oct 2018 15:05:21 -0700 (PDT)
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

--===============6238573106779717526==
Content-Type: multipart/alternative; boundary="000000000000958ee7057900ae9b"

--000000000000958ee7057900ae9b
Content-Type: text/plain; charset="UTF-8"

I am trying to add a thread timestamp to trace events. By thread timestamp
I mean the value returned by clock_gettime(CLOCK_THREAD_CPUTIME_ID):
https://linux.die.net/man/3/clock_gettime

I could do this by creating custom events, but I am wondering if there is
already a way to add this information to event context. I have tried using
the following arguments to lttng-add-context, but none of them add any
additional information:
perf:cpu:cpu-cycles
perf:cpu:cycles
perf:thread:cpu-cycles
perf:thread:cycles

Note that I have only enabled userspace events. I use the following
sequence of commands to capture trace:
lttng create
lttng enable-event --userspace --all
lttng add-context --userspace -t vpid -t vtid -t perf:thread:cycles
lttng start
lttng stop

--000000000000958ee7057900ae9b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I am trying to add a thread timestamp to trace events. By =
thread timestamp I mean the value returned by=C2=A0clock_gettime(CLOCK_THRE=
AD_CPUTIME_ID):<div><a href=3D"https://linux.die.net/man/3/clock_gettime">h=
ttps://linux.die.net/man/3/clock_gettime</a><br></div><div><br></div><div>I=
 could do this by creating custom events, but I am wondering if there is al=
ready a way to add this information to event context. I have tried using th=
e following arguments to lttng-add-context, but none of them add any additi=
onal information:</div><div><div>perf:cpu:cpu-cycles</div><div>perf:cpu:cyc=
les</div></div><div><div>perf:thread:cpu-cycles</div><div>perf:thread:cycle=
s</div></div><div><br></div><div>Note that I have only enabled userspace ev=
ents. I use the following sequence of commands to capture trace:</div><div>=
<div>lttng create</div><div>lttng enable-event --userspace --all</div><div>=
lttng add-context --userspace -t vpid -t vtid -t perf:thread:cycles</div><d=
iv>lttng start</div><div>lttng stop</div></div><div><br></div></div>

--000000000000958ee7057900ae9b--

--===============6238573106779717526==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6238573106779717526==--
