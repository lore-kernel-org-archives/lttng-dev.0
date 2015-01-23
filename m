From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Strange sequence of events
Date: Fri, 23 Jan 2015 19:07:43 +0000 (UTC)
Message-ID: <1046672071.40141.1422040062995.JavaMail.zimbra__48458.0242461108$1422040106$gmane$org@efficios.com>
References: <CAC1wc0BFK3UHKD0-O4U5miZEQxT5MeJmob4MyFzNBb7h9B3qYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0763425721=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YEja3-0000XK-Mu
 for lttng-dev@lists.lttng.org; Fri, 23 Jan 2015 14:07:45 -0500
In-Reply-To: <CAC1wc0BFK3UHKD0-O4U5miZEQxT5MeJmob4MyFzNBb7h9B3qYw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mattias Johansson <matjo75@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0763425721==
Content-Type: multipart/alternative;
	boundary="----=_Part_40140_1533468074.1422040062993"

------=_Part_40140_1533468074.1422040062993
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- Original Message -----

> From: "Mattias Johansson" <matjo75@gmail.com>
> To: lttng-dev@lists.lttng.org
> Sent: Friday, January 23, 2015 4:29:57 AM
> Subject: [lttng-dev] Strange sequence of events

> Hi lttng-people!

> I have been using lttng to make a combined kernel and userspace trace and I
> can't make sense of a simple sequence of events. I am using a two core cpu,
> a custom distro (by yocto), linux kernel version is 3.12.15 with the PREEMPT
> RT patches, the lttng probe module lttng-probe-sched loaded.
> This is my strange sequence:

> [13:26:17.542825060] (+0.000003659) unit1 sched_switch: { cpu_id = 1 }, { pid
> = 2390 }, { prev_comm = "ThreadA", prev_tid = 2547, prev_prio = -19,
> prev_state = 1024, next_comm = "KernelThreadB", next_tid = 2410, next_prio =
> -51 }
> [13:26:17.542831008] (+0.000005948) unit1 sched_migrate_task: { cpu_id = 0 },
> { pid = 2408 }, { comm = "ThreadA", tid = 2547, prio = -19, orig_cpu = 1,
> dest_cpu = 0 }
> [13:26:17.542837060] (+0.000003256) unit1 ust_event:my_ust_event: { cpu_id =
> 1 }, { vtid = 2547 }, { }

> ThreadA makes the userspace trace event 'my_ust_event'.

> What is strange to me is either the timestamp of 'my_ust_event' is "wrong"
> (it should have been a time before the sched_switch), or the cpu_id of the
> ust_event is "wrong" (it should be 0 since ThreadA has been migrated to
> cpu_id 0 at 13:26:17.542831008).

> Or am I interpreting the sequence wrong?

> Or could it be that the my_ust_event itself got interrupted and had already
> sampled the cpu_id, and after the migration completed the event, thus the
> trace is "correct"?

This last guess is the most likely. UST ring buffer reserve code looks like: 

lttng_event_reserve() 
- read current CPU number (A) 
- lib_ring_buffer_try_reserve() 
do { 
1) lib_ring_buffer_clock_read() (B) 
2) cmpxchg() to reserve space in ring buffer (C) 
} while cmpxchg fails 

So if we are preempted and migrated between (A) and (B), we could 
see the effect you are experiencing. The issue here is that userspace 
does not have a way to atomically read cpu number, read time, and reserve 
space in the ring buffer with respect to the scheduler (it cannot disable preemption). 
We would need kernel-level support for this. I have a few ideas on how this 
could be done, but it's only at the idea stage at the moment, and would require 
extending the kernel. It's far from simple, because we cannot disable preemption 
nor migration from user-space (it's on purpose, and a strict requirement from 
the Linux scheduler developers). 

Thoughts ? 

Thanks, 

Mathieu 

> Thanks!
> /Mattias

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_40140_1533468074.1422040062993
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div><br></div><hr id=3D"zwchr"><bloc=
kquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:=
5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;fo=
nt-family:Helvetica,Arial,sans-serif;font-size:12pt;"><b>From: </b>"Mattias=
 Johansson" &lt;matjo75@gmail.com&gt;<br><b>To: </b>lttng-dev@lists.lttng.o=
rg<br><b>Sent: </b>Friday, January 23, 2015 4:29:57 AM<br><b>Subject: </b>[=
lttng-dev] Strange sequence of events<br><div><br></div><div dir=3D"ltr">Hi=
 lttng-people!<div><br></div><div>I have been using lttng to make a combine=
d kernel and userspace trace and I can't make sense of a simple sequence of=
 events. I am using a two core cpu, a custom distro (by yocto), linux kerne=
l version is 3.12.15 with the PREEMPT RT patches, the lttng probe module lt=
tng-probe-sched loaded.</div><div>This is my strange sequence:</div><div><d=
iv><br></div><div>[13:26:17.542825060] (+0.000003659) unit1 sched_switch: {=
 cpu_id =3D 1 }, { pid =3D 2390 }, { prev_comm =3D "ThreadA", prev_tid =3D =
2547, prev_prio =3D -19, prev_state =3D 1024, next_comm =3D "KernelThreadB"=
, next_tid =3D 2410, next_prio =3D -51 }</div><div>[13:26:17.542831008] (+0=
.000005948) unit1 sched_migrate_task: { cpu_id =3D 0 }, { pid =3D 2408 }, {=
 comm =3D "ThreadA", tid =3D 2547, prio =3D -19, orig_cpu =3D 1, dest_cpu =
=3D 0 }</div><div>[13:26:17.542837060] (+0.000003256) unit1 ust_event:my_us=
t_event: { cpu_id =3D 1 }, { vtid =3D 2547 }, { }</div></div><div><br></div=
><div>ThreadA makes the userspace trace event 'my_ust_event'.</div><div><br=
></div><div>What is strange to me is either the timestamp of 'my_ust_event'=
 is "wrong" (it should have been a time before the sched_switch), or the cp=
u_id of the ust_event is "wrong" (it should be 0 since&nbsp;ThreadA&nbsp;ha=
s&nbsp;been migrated to cpu_id 0 at 13:26:17.542831008).</div><div><br></di=
v><div>Or am I interpreting the sequence wrong?</div><div><br></div><div>Or=
 could it be that the&nbsp;my_ust_event&nbsp;itself got interrupted and had=
 already sampled the cpu_id,&nbsp;and after the migration completed the eve=
nt, thus the trace is "correct"?</div></div></blockquote><div>This last gue=
ss is the most likely. UST ring buffer reserve code looks like:<br></div><d=
iv><br></div><div>lttng_event_reserve()</div><div>- read current CPU number=
 (A)<br></div><div>- lib_ring_buffer_try_reserve()</div><div>&nbsp; do {<br=
></div><div>&nbsp;&nbsp; 1) lib_ring_buffer_clock_read()&nbsp; (B)<br></div=
><div>&nbsp;&nbsp; 2) cmpxchg() to reserve space in ring buffer (C)<br></di=
v><div>&nbsp; } while cmpxchg fails<br></div><div><br></div><div>So if we a=
re preempted and migrated between (A) and (B), we could<br></div><div>see t=
he effect you are experiencing. The issue here is that userspace<br></div><=
div>does not have a way to atomically read cpu number, read time, and reser=
ve<br></div><div>space in the ring buffer with respect to the scheduler (it=
 cannot disable preemption).<br></div><div>We would need kernel-level suppo=
rt for this. I have a few ideas on how this<br></div><div>could be done, bu=
t it's only at the idea stage at the moment, and would require<br></div><di=
v>extending the kernel. It's far from simple, because we cannot disable pre=
emption<br></div><div>nor migration from user-space (it's on purpose, and a=
 strict requirement from<br></div><div>the Linux scheduler developers).<br>=
</div><div><br></div><div>Thoughts ?<br></div><div><br></div><div>Thanks,<b=
r></div><div><br></div><div>Mathieu<br></div><div><br></div><div><br></div>=
<blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-=
left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:no=
ne;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"=
><div><br></div><div>Thanks!</div><div>/Mattias</div><div><br></div></div><=
br>_______________________________________________<br>lttng-dev mailing lis=
t<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/li=
stinfo/lttng-dev<br></blockquote><div><br><br></div><div><br></div><div>-- =
<br></div><div><span name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<b=
r>http://www.efficios.com<span name=3D"x"></span><br></div></div></body></h=
tml>
------=_Part_40140_1533468074.1422040062993--


--===============0763425721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0763425721==--
