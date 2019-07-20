From: Zvi Vered <veredz72@gmail.com>
Subject: Re: Understand userspace events in babeltrace output
Date: Sat, 20 Jul 2019 06:49:31 +0300
Message-ID: <CABRndgxTgBDvDX0KqQ6CtJswKCziwryqYnsvUq7rOXV=gu5JVA__41265.9705428936$1563594866$gmane$org@mail.gmail.com>
References: <CABRndgykKYN-OxyDKDp1Nn4J0Ta4p54_kB5Wh9B5-AUSsdxLsg@mail.gmail.com>
 <20190719204839.GA11115@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4229295623044789815=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 by lists.lttng.org (Postfix) with ESMTPS id 45rDWk5NqSz1Gx8
 for <lttng-dev@lists.lttng.org>; Fri, 19 Jul 2019 23:54:10 -0400 (EDT)
Received: by mail-yb1-xb29.google.com with SMTP id s41so10545138ybe.12
 for <lttng-dev@lists.lttng.org>; Fri, 19 Jul 2019 20:54:10 -0700 (PDT)
In-Reply-To: <20190719204839.GA11115@joraj-alpa>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============4229295623044789815==
Content-Type: multipart/alternative; boundary="0000000000009824bd058e14cb98"

--0000000000009824bd058e14cb98
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,

Thank you very much !

Best regards,
Zvika

On Fri, Jul 19, 2019 at 11:48 PM Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> Hi Zvi,
>
> On Fri, Jul 19, 2019 at 05:28:48PM +0300, Zvi Vered wrote:
> > Hello,
> >
> > Using babeltrace I created a text trace.
> > How can I understand it ?
>
> Here lies the heavy work!
>
> >
> > For example:
> > I logged userspace events. One of my threads is called: RSPOn3
>
> As far as I can tell sched_* are not userspace events they are
> "kernelspace"
> events.
>
> > I can see the following lines:
> >
> > sched_switch: { cpu_id = 0 }, { prev_comm = "RSPOn3", prev_tid = 27307,
> > prev_prio = -58, prev_state = 1, next_comm = "swapper/0", next_tid = 0,
> > next_prio = 20 }
> >
> > sched_wakeup: { cpu_id = 0 }, { comm = "RSPOn3", tid = 27307, prio = -58,
> > success = 1, target_cpu = 0 }
> >
> > sched_switch: { cpu_id = 0 }, { prev_comm = "swapper/0", prev_tid = 0,
> > prev_prio = 20, prev_state = 0, next_comm = "RSPOn3", next_tid = 27307,
> > next_prio = -58 }
> >
> > sched_switch: { cpu_id = 0 }, { prev_comm = "RSPOn3", prev_tid = 27307,
> > prev_prio = -58, prev_state = 1, next_comm = "swapper/0", next_tid = 0,
> > next_prio = 20 }
> >
> > How can I know the meaning of each field in each line ?
>
> You will need to understand the kernel state transition of the scheduler.
> There
> is multiple ways to go about it.
>
> You could use TraceCompass[1][2] or lttng-analyses[3] to ease/complement
> your
> learning experience a bit.
>
> You could dive in the kernel source code and understand the control flow
> surrounding each events and understand the significance of the events
> payload.
>
> Another interesting place to look is the kernel trace documentation [4].
> Some
> subsystems have clear explanation regarding each tracepoint [5].
>
> > 1. sched_switch, sched_wakeup
> > 2. prev_comm
> > 3. prev_state
> > 4. next_comm
> >
> > If a task is blocked (e.g waiting for TCP) and then runs for some time
> and
> > then waits again, how this will be logged ?
>
> Babeltrace is a trace converter, it does not perform any analysis.
> TraceCompass
> and lttng-analyses might have analysis fitting your needs.
>
> Cheers
>
> [1] https://www.eclipse.org/tracecompass/
> [2]
> https://archive.eclipse.org/tracecompass/doc/stable/org.eclipse.tracecompass.doc.user/LTTng-Kernel-Analysis.html#LTTng_Kernel_Analysis
> [3] https://github.com/lttng/lttng-analyses
> [4] https://www.kernel.org/doc/Documentation/trace/
> [5] https://www.kernel.org/doc/Documentation/trace/events-kmem.txt
>
> --
> Jonathan Rajotte-Julien
> EfficiOS
>

--0000000000009824bd058e14cb98
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jonathan,<div><br></div><div>Thank you very much !</div=
><div><br></div><div>Best regards,</div><div>Zvika=C2=A0</div></div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 1=
9, 2019 at 11:48 PM Jonathan Rajotte-Julien &lt;<a href=3D"mailto:jonathan.=
rajotte-julien@efficios.com">jonathan.rajotte-julien@efficios.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Zvi,<br=
>
<br>
On Fri, Jul 19, 2019 at 05:28:48PM +0300, Zvi Vered wrote:<br>
&gt; Hello,<br>
&gt; <br>
&gt; Using babeltrace I created a text trace.<br>
&gt; How can I understand it ?<br>
<br>
Here lies the heavy work!<br>
<br>
&gt; <br>
&gt; For example:<br>
&gt; I logged userspace events. One of my threads is called: RSPOn3<br>
<br>
As far as I can tell sched_* are not userspace events they are &quot;kernel=
space&quot;<br>
events.<br>
<br>
&gt; I can see the following lines:<br>
&gt; <br>
&gt; sched_switch: { cpu_id =3D 0 }, { prev_comm =3D &quot;RSPOn3&quot;, pr=
ev_tid =3D 27307,<br>
&gt; prev_prio =3D -58, prev_state =3D 1, next_comm =3D &quot;swapper/0&quo=
t;, next_tid =3D 0,<br>
&gt; next_prio =3D 20 }<br>
&gt; <br>
&gt; sched_wakeup: { cpu_id =3D 0 }, { comm =3D &quot;RSPOn3&quot;, tid =3D=
 27307, prio =3D -58,<br>
&gt; success =3D 1, target_cpu =3D 0 }<br>
&gt; <br>
&gt; sched_switch: { cpu_id =3D 0 }, { prev_comm =3D &quot;swapper/0&quot;,=
 prev_tid =3D 0,<br>
&gt; prev_prio =3D 20, prev_state =3D 0, next_comm =3D &quot;RSPOn3&quot;, =
next_tid =3D 27307,<br>
&gt; next_prio =3D -58 }<br>
&gt; <br>
&gt; sched_switch: { cpu_id =3D 0 }, { prev_comm =3D &quot;RSPOn3&quot;, pr=
ev_tid =3D 27307,<br>
&gt; prev_prio =3D -58, prev_state =3D 1, next_comm =3D &quot;swapper/0&quo=
t;, next_tid =3D 0,<br>
&gt; next_prio =3D 20 }<br>
&gt; <br>
&gt; How can I know the meaning of each field in each line ?<br>
<br>
You will need to understand the kernel state transition of the scheduler. T=
here<br>
is multiple ways to go about it.<br>
<br>
You could use TraceCompass[1][2] or lttng-analyses[3] to ease/complement yo=
ur<br>
learning experience a bit.<br>
<br>
You could dive in the kernel source code and understand the control flow<br=
>
surrounding each events and understand the significance of the events paylo=
ad.<br>
<br>
Another interesting place to look is the kernel trace documentation [4]. So=
me<br>
subsystems have clear explanation regarding each tracepoint [5].<br>
<br>
&gt; 1. sched_switch, sched_wakeup<br>
&gt; 2. prev_comm<br>
&gt; 3. prev_state<br>
&gt; 4. next_comm<br>
&gt; <br>
&gt; If a task is blocked (e.g waiting for TCP) and then runs for some time=
 and<br>
&gt; then waits again, how this will be logged ?<br>
<br>
Babeltrace is a trace converter, it does not perform any analysis. TraceCom=
pass<br>
and lttng-analyses might have analysis fitting your needs.<br>
<br>
Cheers<br>
<br>
[1] <a href=3D"https://www.eclipse.org/tracecompass/" rel=3D"noreferrer" ta=
rget=3D"_blank">https://www.eclipse.org/tracecompass/</a><br>
[2] <a href=3D"https://archive.eclipse.org/tracecompass/doc/stable/org.ecli=
pse.tracecompass.doc.user/LTTng-Kernel-Analysis.html#LTTng_Kernel_Analysis"=
 rel=3D"noreferrer" target=3D"_blank">https://archive.eclipse.org/tracecomp=
ass/doc/stable/org.eclipse.tracecompass.doc.user/LTTng-Kernel-Analysis.html=
#LTTng_Kernel_Analysis</a><br>
[3] <a href=3D"https://github.com/lttng/lttng-analyses" rel=3D"noreferrer" =
target=3D"_blank">https://github.com/lttng/lttng-analyses</a><br>
[4] <a href=3D"https://www.kernel.org/doc/Documentation/trace/" rel=3D"nore=
ferrer" target=3D"_blank">https://www.kernel.org/doc/Documentation/trace/</=
a><br>
[5] <a href=3D"https://www.kernel.org/doc/Documentation/trace/events-kmem.t=
xt" rel=3D"noreferrer" target=3D"_blank">https://www.kernel.org/doc/Documen=
tation/trace/events-kmem.txt</a><br>
<br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</blockquote></div>

--0000000000009824bd058e14cb98--

--===============4229295623044789815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4229295623044789815==--
