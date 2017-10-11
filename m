From: avkumar <anilzoom@gmail.com>
Subject: How to user perf probes and module tracepoints in lttng
Date: Wed, 11 Oct 2017 16:10:38 -0500
Message-ID: <CANaS5jp1rE6Vnb1zmBgb+Gd5N_XLjFsH+HR7zD-UAo8FfYL43g__48332.7691596516$1507757051$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5802361627162804698=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt0-x234.google.com (mail-qt0-x234.google.com
 [IPv6:2607:f8b0:400d:c0d::234])
 by lists.lttng.org (Postfix) with ESMTPS id 3yC68H6mdHz10qw
 for <lttng-dev@lists.lttng.org>; Wed, 11 Oct 2017 21:10:39 +0000 (UTC)
Received: by mail-qt0-x234.google.com with SMTP id 1so9424613qtn.3
 for <lttng-dev@lists.lttng.org>; Wed, 11 Oct 2017 14:10:39 -0700 (PDT)
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

--===============5802361627162804698==
Content-Type: multipart/alternative; boundary="001a114faa2605be84055b4bdbac"

--001a114faa2605be84055b4bdbac
Content-Type: text/plain; charset="UTF-8"

Perf probes:
How can we add the dynamic trace points created by perf probe into lttng?
When I add the perf probe as kprobe type I get missing tracepoint error, If
I add the perf probe as tracepoint , Lttng does not complain but it does
not collect any data when the tracepoint is hit.

perf probe -l
  probe:tcp_gro        (on tcp_gro_receive@net/ipv4/tcp_offload.c with addr
len)

lttng enable-event -k --probe=tcp_gro
Error: Missing event name(s).

When I add it as a trace point

lttng enable-event -k probe:tcp_gro
Kernel event probe:tcp_gro created in channel channel0]

it does not give any error but no data is collected



Module tracepoints:
I created module tracepoints in the kernel and compiled the trace points.
The header file is in the driver module directory. When I write the
adaptation layer for lttng, it does not compile as it is not able to fien
the header file. I have given fill path name to the header file and still
it does not work.


Thanks

--001a114faa2605be84055b4bdbac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Perf probes:</div><div>How can we add the dynamic tra=
ce points created by perf probe into lttng? When I add the perf probe as kp=
robe type I get missing tracepoint error, If I add the perf probe as tracep=
oint , Lttng does not complain but it does not collect any data when the tr=
acepoint is hit.=C2=A0</div><div><br></div><div><div>perf probe -l</div><di=
v>=C2=A0 probe:tcp_gro =C2=A0 =C2=A0 =C2=A0 =C2=A0(on tcp_gro_receive@net/i=
pv4/tcp_offload.c with addr len)</div></div><div><br></div><div><div>lttng =
enable-event -k --probe=3Dtcp_gro</div><div>Error: Missing event name(s).</=
div></div><div><br></div><div>When I add it as a trace point</div><div><br>=
</div><div><div>lttng enable-event -k probe:tcp_gro</div><div>Kernel event =
probe:tcp_gro created in channel channel0]</div></div><div><br></div><div>i=
t does not give any error but no data is collected</div><div><br></div><div=
><br></div><div><br></div>Module tracepoints:<div>I created module tracepoi=
nts in the kernel and compiled the trace points. The header file is in the =
driver module directory. When I write the adaptation layer for lttng, it do=
es not compile as it is not able to fien the header file. I have given fill=
 path name to the header file and still it does not work.</div><div><br></d=
iv><div><br></div><div>Thanks</div><div><br></div><div><br></div><div><br><=
/div><div><br></div></div>

--001a114faa2605be84055b4bdbac--

--===============5802361627162804698==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5802361627162804698==--
