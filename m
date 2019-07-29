From: Ravindra Kumar Meena <rmeena840@gmail.com>
Subject: Re: What is _prev_state in sched_switch?
Date: Mon, 29 Jul 2019 14:37:20 +0530
Message-ID: <CAEWVvORgCQW8ScJZctu7dzT3QaO0PY50qmR-Aov9YHV1GkB+JQ__47989.5139973209$1564391297$gmane$org@mail.gmail.com>
References: <CAEWVvOS48D3Jfp4==qrrODzdSSjo+-UOuvZyya1O_f2t9B9Z1A@mail.gmail.com>
 <0e850b02-3fec-a335-3f37-8579ad1b704d@gydle.com>
 <CAEWVvOSu4vbiDpMCCTHdP59xNaMsAJ74orA52amRaFfoN7jfXQ@mail.gmail.com>
 <18d63d8c-da2d-54c3-3a9a-1d77a5a3a675@gydle.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3804972026821716219=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by lists.lttng.org (Postfix) with ESMTPS id 45xv3g2wMBz16qR
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2019 05:07:59 -0400 (EDT)
Received: by mail-wr1-x444.google.com with SMTP id r1so60933191wrl.7
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2019 02:07:59 -0700 (PDT)
In-Reply-To: <18d63d8c-da2d-54c3-3a9a-1d77a5a3a675@gydle.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Sebastien Boisvert <sboisvert@gydle.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============3804972026821716219==
Content-Type: multipart/alternative; boundary="00000000000066c27b058ece3aba"

--00000000000066c27b058ece3aba
Content-Type: text/plain; charset="UTF-8"

>
> >     On 2019-07-24 2:44 a.m., Ravindra Kumar Meena wrote:
> >     > Hi,
> >     >
> >     > I had a looked at TraceCompass example. I came across sched_swithc
> event in present in the metadata.
> >     >
> >     > event {
> >     > name = "sched_switch";
> >     > id = 27;
> >     > stream_id = 0;
> >     > fields := struct {
> >     > integer { size = 8; align = 8; signed = 0; encoding = UTF8; base =
> 10; } _prev_comm[16];
> >     > integer { size = 32; align = 8; signed = 1; encoding = none; base
> = 10; } _prev_tid;
> >     > integer { size = 32; align = 8; signed = 1; encoding = none; base
> = 10; } _prev_prio;
> >     > integer { size = 64; align = 8; signed = 1; encoding = none; base
> = 10; } _prev_state;
> >     > integer { size = 8; align = 8; signed = 0; encoding = UTF8; base =
> 10; } _next_comm[16];
> >     > integer { size = 32; align = 8; signed = 1; encoding = none; base
> = 10; } _next_tid;
> >     > integer { size = 32; align = 8; signed = 1; encoding = none; base
> = 10; } _next_prio;
> >     > };
> >     > };
> >     >
> >     > All event.fields variables are clear to me but what does
> _prev_state do here? I had a looked at its babeltrace output but found no
> pattern in _prev_state value.
>
> In the Linux kernel, the tracepoint for sched_switch does not have the
> field prev_state:
>
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/tracepoint.h?id=52a6e82ac27288f591c750f201de5c3e6ef24385#n465
>
>
> In lttng-modules, however, there is the field prev_state:
>
>
> http://git.lttng.org/?p=lttng-modules.git;a=blob;f=instrumentation/events/lttng-module/sched.h;h=77d77b2aeeddbe6ac34e2228b077734721f45b18;hb=4ea9b7c98ade603b08f0d945f4d99bc079eb57b6#l237
>
>
> My guess would be that prev_state is the previous state of the thread
> (TID):
>
Okay. The above link was somewhat helpful but I still didn't get what is
the meaning of {0, 1, 1026, 4096} values in _prev_state.

In babeltrace output _prev_state have { 0, 1, 1026, 4096 } values.

The example can be found here
https://github.com/tuxology/tracevizlab/blob/master/labs/TraceCompassTutorialTraces.tgz

At folder "102-tracing-wget-critical-path/wget-first-call" babeltrace gives
following output.

babeltrace . | grep sched_switch

[21:20:44.207247650] (+0.000000799) arnaud-desktop sched_switch: { cpu_id =
3 }, { prev_comm = "swapper/3", prev_tid = 0, prev_prio = 20, prev_state =
0, next_comm = "kworker/u8:2", next_tid = 8363, next_prio = 20 }
[21:20:44.207252919] (+0.000000085) arnaud-desktop sched_switch: { cpu_id =
3 }, { prev_comm = "kworker/u8:2", prev_tid = 8363, prev_prio = 20,
prev_state = 1026, next_comm = "swapper/3", next_tid = 0, next_prio = 20 }
[21:20:44.207253370] (+0.000000143) arnaud-desktop sched_switch: { cpu_id =
0 }, { prev_comm = "code", prev_tid = 3876, prev_prio = 20, prev_state = 0,
next_comm = "code", next_tid = 4140, next_prio = 20 }
[21:20:44.207257279] (+0.000000656) arnaud-desktop sched_switch: { cpu_id =
3 }, { prev_comm = "swapper/3", prev_tid = 0, prev_prio = 20, prev_state =
0, next_comm = "kworker/u8:2", next_tid = 8363, next_prio = 20 }
[21:20:44.207258485] (+0.000000903) arnaud-desktop sched_switch: { cpu_id =
3 }, { prev_comm = "kworker/u8:2", prev_tid = 8363, prev_prio = 20,
prev_state = 1026, next_comm = "swapper/3", next_tid = 0, next_prio = 20 }
[21:20:44.207270164] (+0.000000081) arnaud-desktop sched_switch: { cpu_id =
3 }, { prev_comm = "swapper/3", prev_tid = 0, prev_prio = 20, prev_state =
0, next_comm = "kworker/u8:2", next_tid = 8363, next_prio = 20 }

P.S: This is not a full babeltrace output.


-- 
*Ravindra Kumar Meena*,
B. Tech. Computer Science and Engineering,
Indian Institute of Technology (Indian School of Mines)
<https://www.iitism.ac.in/>, Dhanbad

--00000000000066c27b058ece3aba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">&gt;=C2=A0 =C2=A0 =C2=A0On 2019-07-24 2:44 a.m., Ravindr=
a Kumar Meena wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Hi,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I had a looked at TraceCompass example. I came=
 across sched_swithc event in present in the metadata.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; event {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; name =3D &quot;sched_switch&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; id =3D 27;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; stream_id =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; fields :=3D struct {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; integer { size =3D 8; align =3D 8; signed =3D =
0; encoding =3D UTF8; base =3D 10; } _prev_comm[16];<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; integer { size =3D 32; align =3D 8; signed =3D=
 1; encoding =3D none; base =3D 10; } _prev_tid;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; integer { size =3D 32; align =3D 8; signed =3D=
 1; encoding =3D none; base =3D 10; } _prev_prio;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; integer { size =3D 64; align =3D 8; signed =3D=
 1; encoding =3D none; base =3D 10; } _prev_state;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; integer { size =3D 8; align =3D 8; signed =3D =
0; encoding =3D UTF8; base =3D 10; } _next_comm[16];<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; integer { size =3D 32; align =3D 8; signed =3D=
 1; encoding =3D none; base =3D 10; } _next_tid;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; integer { size =3D 32; align =3D 8; signed =3D=
 1; encoding =3D none; base =3D 10; } _next_prio;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; };<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; };<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; All event.fields variables are clear to me but=
 what does _prev_state do here? I had a looked at its babeltrace output but=
 found no pattern in _prev_state value.<br><br>
In the Linux kernel, the tracepoint for sched_switch does not have the<br>
field prev_state:<br>
<br>
<a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it/tree/include/linux/tracepoint.h?id=3D52a6e82ac27288f591c750f201de5c3e6ef=
24385#n465" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/pub=
/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/tracepoint.h?id=
=3D52a6e82ac27288f591c750f201de5c3e6ef24385#n465</a><br>
<br>
<br>
In lttng-modules, however, there is the field prev_state:<br>
<br>
<a href=3D"http://git.lttng.org/?p=3Dlttng-modules.git;a=3Dblob;f=3Dinstrum=
entation/events/lttng-module/sched.h;h=3D77d77b2aeeddbe6ac34e2228b077734721=
f45b18;hb=3D4ea9b7c98ade603b08f0d945f4d99bc079eb57b6#l237" rel=3D"noreferre=
r" target=3D"_blank">http://git.lttng.org/?p=3Dlttng-modules.git;a=3Dblob;f=
=3Dinstrumentation/events/lttng-module/sched.h;h=3D77d77b2aeeddbe6ac34e2228=
b077734721f45b18;hb=3D4ea9b7c98ade603b08f0d945f4d99bc079eb57b6#l237</a><br>
<br>
<br>
My guess would be that prev_state is the previous state of the thread (TID)=
:<br></blockquote><div>Okay. The above link was somewhat helpful but I stil=
l didn&#39;t get what is the meaning of {0, 1, 1026, 4096} values in _prev_=
state.=C2=A0</div><div><br></div><div>In babeltrace output _prev_state have=
 { 0, 1, 1026, 4096 } values.</div><div><br></div><div>The example can be f=
ound here=C2=A0<a href=3D"https://github.com/tuxology/tracevizlab/blob/mast=
er/labs/TraceCompassTutorialTraces.tgz">https://github.com/tuxology/tracevi=
zlab/blob/master/labs/TraceCompassTutorialTraces.tgz</a></div><div><br></di=
v><div>At folder &quot;102-tracing-wget-critical-path/wget-first-call&quot;=
 babeltrace gives following output.</div><div><br></div><div>babeltrace . |=
 grep sched_switch</div><div><br></div>[21:20:44.207247650] (+0.000000799) =
arnaud-desktop sched_switch: { cpu_id =3D 3 }, { prev_comm =3D &quot;swappe=
r/3&quot;, prev_tid =3D 0, prev_prio =3D 20, prev_state =3D 0, next_comm =
=3D &quot;kworker/u8:2&quot;, next_tid =3D 8363, next_prio =3D 20 }<br>[21:=
20:44.207252919] (+0.000000085) arnaud-desktop sched_switch: { cpu_id =3D 3=
 }, { prev_comm =3D &quot;kworker/u8:2&quot;, prev_tid =3D 8363, prev_prio =
=3D 20, prev_state =3D 1026, next_comm =3D &quot;swapper/3&quot;, next_tid =
=3D 0, next_prio =3D 20 }<br>[21:20:44.207253370] (+0.000000143) arnaud-des=
ktop sched_switch: { cpu_id =3D 0 }, { prev_comm =3D &quot;code&quot;, prev=
_tid =3D 3876, prev_prio =3D 20, prev_state =3D 0, next_comm =3D &quot;code=
&quot;, next_tid =3D 4140, next_prio =3D 20 }<br>[21:20:44.207257279] (+0.0=
00000656) arnaud-desktop sched_switch: { cpu_id =3D 3 }, { prev_comm =3D &q=
uot;swapper/3&quot;, prev_tid =3D 0, prev_prio =3D 20, prev_state =3D 0, ne=
xt_comm =3D &quot;kworker/u8:2&quot;, next_tid =3D 8363, next_prio =3D 20 }=
<br>[21:20:44.207258485] (+0.000000903) arnaud-desktop sched_switch: { cpu_=
id =3D 3 }, { prev_comm =3D &quot;kworker/u8:2&quot;, prev_tid =3D 8363, pr=
ev_prio =3D 20, prev_state =3D 1026, next_comm =3D &quot;swapper/3&quot;, n=
ext_tid =3D 0, next_prio =3D 20 }<br>[21:20:44.207270164] (+0.000000081) ar=
naud-desktop sched_switch: { cpu_id =3D 3 }, { prev_comm =3D &quot;swapper/=
3&quot;, prev_tid =3D 0, prev_prio =3D 20, prev_state =3D 0, next_comm =3D =
&quot;kworker/u8:2&quot;, next_tid =3D 8363, next_prio =3D 20 }</div><div c=
lass=3D"gmail_quote"><br></div><div class=3D"gmail_quote">P.S: This is not =
a full babeltrace output.</div><br clear=3D"all"><div><br></div>-- <br><div=
 dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"lt=
r"><font size=3D"4"><b>Ravindra Kumar Meena</b></font>,<div><span style=3D"=
color:rgb(102,102,102)">B. Tech. Computer Science and Engineering,<br></spa=
n></div><div><span style=3D"color:rgb(102,102,102)"><a href=3D"https://www.=
iitism.ac.in/" style=3D"color:rgb(17,85,204)" target=3D"_blank">Indian Inst=
itute of Technology (Indian School of Mines)</a>, Dhanbad</span></div></div=
></div></div></div></div>

--00000000000066c27b058ece3aba--

--===============3804972026821716219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3804972026821716219==--
