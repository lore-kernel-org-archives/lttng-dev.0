From: Mattias Johansson <matjo75@gmail.com>
Subject: Strange sequence of events
Date: Fri, 23 Jan 2015 10:29:57 +0100
Message-ID: <CAC1wc0BFK3UHKD0-O4U5miZEQxT5MeJmob4MyFzNBb7h9B3qYw__4759.91611970148$1422005442$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1307934772=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <matjo75@gmail.com>) id 1YEaZ1-0005hZ-Dg
 for lttng-dev@lists.lttng.org; Fri, 23 Jan 2015 04:30:06 -0500
Received: by mail-pa0-f42.google.com with SMTP id bj1so6554492pad.1
 for <lttng-dev@lists.lttng.org>; Fri, 23 Jan 2015 01:29:57 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1307934772==
Content-Type: multipart/alternative; boundary=047d7b5dbb66978da9050d4e6eed

--047d7b5dbb66978da9050d4e6eed
Content-Type: text/plain; charset=UTF-8

Hi lttng-people!

I have been using lttng to make a combined kernel and userspace trace and I
can't make sense of a simple sequence of events. I am using a two core cpu,
a custom distro (by yocto), linux kernel version is 3.12.15 with the
PREEMPT RT patches, the lttng probe module lttng-probe-sched loaded.
This is my strange sequence:

[13:26:17.542825060] (+0.000003659) unit1 sched_switch: { cpu_id = 1 }, {
pid = 2390 }, { prev_comm = "ThreadA", prev_tid = 2547, prev_prio = -19,
prev_state = 1024, next_comm = "KernelThreadB", next_tid = 2410, next_prio
= -51 }
[13:26:17.542831008] (+0.000005948) unit1 sched_migrate_task: { cpu_id = 0
}, { pid = 2408 }, { comm = "ThreadA", tid = 2547, prio = -19, orig_cpu =
1, dest_cpu = 0 }
[13:26:17.542837060] (+0.000003256) unit1 ust_event:my_ust_event: { cpu_id
= 1 }, { vtid = 2547 }, { }

ThreadA makes the userspace trace event 'my_ust_event'.

What is strange to me is either the timestamp of 'my_ust_event' is "wrong"
(it should have been a time before the sched_switch), or the cpu_id of the
ust_event is "wrong" (it should be 0 since ThreadA has been migrated to
cpu_id 0 at 13:26:17.542831008).

Or am I interpreting the sequence wrong?

Or could it be that the my_ust_event itself got interrupted and had already
sampled the cpu_id, and after the migration completed the event, thus the
trace is "correct"?

Thanks!
/Mattias

--047d7b5dbb66978da9050d4e6eed
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi lttng-people!<div><br></div><div>I have been using lttn=
g to make a combined kernel and userspace trace and I can&#39;t make sense =
of a simple sequence of events. I am using a two core cpu, a custom distro =
(by yocto), linux kernel version is 3.12.15 with the PREEMPT RT patches, th=
e lttng probe module lttng-probe-sched loaded.</div><div>This is my strange=
 sequence:</div><div><div><br></div><div>[13:26:17.542825060] (+0.000003659=
) unit1 sched_switch: { cpu_id =3D 1 }, { pid =3D 2390 }, { prev_comm =3D &=
quot;ThreadA&quot;, prev_tid =3D 2547, prev_prio =3D -19, prev_state =3D 10=
24, next_comm =3D &quot;KernelThreadB&quot;, next_tid =3D 2410, next_prio =
=3D -51 }</div><div>[13:26:17.542831008] (+0.000005948) unit1 sched_migrate=
_task: { cpu_id =3D 0 }, { pid =3D 2408 }, { comm =3D &quot;ThreadA&quot;, =
tid =3D 2547, prio =3D -19, orig_cpu =3D 1, dest_cpu =3D 0 }</div><div>[13:=
26:17.542837060] (+0.000003256) unit1 ust_event:my_ust_event: { cpu_id =3D =
1 }, { vtid =3D 2547 }, { }</div></div><div><br></div><div>ThreadA makes th=
e userspace trace event &#39;my_ust_event&#39;.</div><div><br></div><div>Wh=
at is strange to me is either the timestamp of &#39;my_ust_event&#39; is &q=
uot;wrong&quot; (it should have been a time before the sched_switch), or th=
e cpu_id of the ust_event is &quot;wrong&quot; (it should be 0 since=C2=A0T=
hreadA=C2=A0has=C2=A0been migrated to cpu_id 0 at 13:26:17.542831008).</div=
><div><br></div><div>Or am I interpreting the sequence wrong?</div><div><br=
></div><div>Or could it be that the=C2=A0my_ust_event=C2=A0itself got inter=
rupted and had already sampled the cpu_id,=C2=A0and after the migration com=
pleted the event, thus the trace is &quot;correct&quot;?</div><div><br></di=
v><div>Thanks!</div><div>/Mattias</div><div><br></div></div>

--047d7b5dbb66978da9050d4e6eed--


--===============1307934772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1307934772==--
