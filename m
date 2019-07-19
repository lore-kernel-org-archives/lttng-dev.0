From: Zvi Vered <veredz72@gmail.com>
Subject: Understand userspace events in babeltrace output
Date: Fri, 19 Jul 2019 17:28:48 +0300
Message-ID: <CABRndgykKYN-OxyDKDp1Nn4J0Ta4p54_kB5Wh9B5-AUSsdxLsg__34259.4307194062$1563546822$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8835203996039577013=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 by lists.lttng.org (Postfix) with ESMTPS id 45qtlq6gSbz1GLD
 for <lttng-dev@lists.lttng.org>; Fri, 19 Jul 2019 10:33:27 -0400 (EDT)
Received: by mail-yb1-xb29.google.com with SMTP id p85so33725yba.2
 for <lttng-dev@lists.lttng.org>; Fri, 19 Jul 2019 07:33:27 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============8835203996039577013==
Content-Type: multipart/alternative; boundary="0000000000000015af058e099c56"

--0000000000000015af058e099c56
Content-Type: text/plain; charset="UTF-8"

Hello,

Using babeltrace I created a text trace.
How can I understand it ?

For example:
I logged userspace events. One of my threads is called: RSPOn3
I can see the following lines:

sched_switch: { cpu_id = 0 }, { prev_comm = "RSPOn3", prev_tid = 27307,
prev_prio = -58, prev_state = 1, next_comm = "swapper/0", next_tid = 0,
next_prio = 20 }

sched_wakeup: { cpu_id = 0 }, { comm = "RSPOn3", tid = 27307, prio = -58,
success = 1, target_cpu = 0 }

sched_switch: { cpu_id = 0 }, { prev_comm = "swapper/0", prev_tid = 0,
prev_prio = 20, prev_state = 0, next_comm = "RSPOn3", next_tid = 27307,
next_prio = -58 }

sched_switch: { cpu_id = 0 }, { prev_comm = "RSPOn3", prev_tid = 27307,
prev_prio = -58, prev_state = 1, next_comm = "swapper/0", next_tid = 0,
next_prio = 20 }

How can I know the meaning of each field in each line ?
1. sched_switch, sched_wakeup
2. prev_comm
3. prev_state
4. next_comm

If a task is blocked (e.g waiting for TCP) and then runs for some time and
then waits again, how this will be logged ?

Curently I need help only on userspace events.

Thank you,
Zvika

--0000000000000015af058e099c56
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br><div><br></div><div>Using babeltrace I created a=
 text trace.=C2=A0</div><div>How can I understand it ?</div><div><br></div>=
<div>For example:=C2=A0</div><div>I logged userspace events. One of my thre=
ads is called:=C2=A0RSPOn3</div><div>I can see the following lines:</div><d=
iv><br></div><div>sched_switch: { cpu_id =3D 0 }, { prev_comm =3D &quot;RSP=
On3&quot;, prev_tid =3D 27307, prev_prio =3D -58, prev_state =3D 1, next_co=
mm =3D &quot;swapper/0&quot;, next_tid =3D 0, next_prio =3D 20 }<br></div><=
div><br></div><div>sched_wakeup: { cpu_id =3D 0 }, { comm =3D &quot;RSPOn3&=
quot;, tid =3D 27307, prio =3D -58, success =3D 1, target_cpu =3D 0 }<br></=
div><div><br></div><div>sched_switch: { cpu_id =3D 0 }, { prev_comm =3D &qu=
ot;swapper/0&quot;, prev_tid =3D 0, prev_prio =3D 20, prev_state =3D 0, nex=
t_comm =3D &quot;RSPOn3&quot;, next_tid =3D 27307, next_prio =3D -58 }<br><=
/div><div><br></div><div>sched_switch: { cpu_id =3D 0 }, { prev_comm =3D &q=
uot;RSPOn3&quot;, prev_tid =3D 27307, prev_prio =3D -58, prev_state =3D 1, =
next_comm =3D &quot;swapper/0&quot;, next_tid =3D 0, next_prio =3D 20 }<br>=
</div><div><br></div><div>How can I know the meaning of each field in each =
line ?</div><div>1. sched_switch, sched_wakeup</div><div>2. prev_comm</div>=
<div>3. prev_state</div><div>4. next_comm</div><div><br></div><div>If a tas=
k is blocked (e.g waiting for TCP) and then runs for some time and then wai=
ts again, how this will be logged ?</div><div><br></div><div>Curently I nee=
d help only on userspace events.=C2=A0</div><div><br></div><div>Thank you,<=
/div><div>Zvika=C2=A0</div><div><br></div><div><br></div></div>

--0000000000000015af058e099c56--

--===============8835203996039577013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8835203996039577013==--
