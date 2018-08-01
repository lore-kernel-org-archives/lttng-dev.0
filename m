From: sai kiran <sai9951775108@gmail.com>
Subject: Re: LTTng streams not Hung up even session is destroyed
Date: Wed, 1 Aug 2018 22:05:30 +0530
Message-ID: <CAPB=nBs84oqYvPECThCoheHQZr6QGONBhSR1o61iB1bS7vbXdg__17073.2624982067$1533141859$gmane$org@mail.gmail.com>
References: <CAPB=nBs16oE95zHyX3xF6F895g1Phe=8AKFmsX185M8rZvyhEw@mail.gmail.com>
 <1098573093.6842.1532966434523.JavaMail.zimbra@efficios.com>
 <2025170812.6867.1532966515434.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1090613029200535110=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it0-x233.google.com (mail-it0-x233.google.com
 [IPv6:2607:f8b0:4001:c0b::233])
 by lists.lttng.org (Postfix) with ESMTPS id 41gf790wyGz14XT
 for <lttng-dev@lists.lttng.org>; Wed,  1 Aug 2018 12:35:32 -0400 (EDT)
Received: by mail-it0-x233.google.com with SMTP id h20-v6so10186642itf.2
 for <lttng-dev@lists.lttng.org>; Wed, 01 Aug 2018 09:35:32 -0700 (PDT)
In-Reply-To: <2025170812.6867.1532966515434.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1090613029200535110==
Content-Type: multipart/alternative; boundary="0000000000007657ec05726248c1"

--0000000000007657ec05726248c1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
 I'm using LTTng 2.9.4  version of lttng-tools, lttng-modules, and
lttng-ust. I'm doing tracing in Xilinx Zynq ZC706 evaluation kit.
the sequence of commands used for tracing:
Mode:
live mode.
For relay daemon:
lttng-relayd -L tcp://127.0.0.1:5344--output=3D/tmp/lttnglogs/
Session commds:
1) lttng create my-session --live --set-url=3Dnet://127.0.0.1
2) lttng enable-channel --kernel --subbuf-size=3D131072 --num-subbuf=3D8
channel0
3) lttng enable-channel -u --read-timer=3D2000000 channel0
4) lttng enable-event --kernel
sched_process_fork,sched_process_exit,irq_handler_entry,irq_handler_exit,sc=
hed_switch,sched_waking
-c channel0 --session=3Dmy-session
5) lttng enable-event -u kernelprofiler:kernelprofiler_task_drop -c
channel0 --session=3Dmysession
6) lttng start
7) lttng stop
8) lttng destroy

Here my application has a tracepoint of
"kernelprofiler:kernelprofiler_task_drop"
event.

Thanks,
T SAI KIRAN.







On Mon, Jul 30, 2018 at 9:31 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> Also, please add the lttng-dev mailing list in CC, as this is the
> appropriate forum for this
> type of question.
>
> Thanks,
>
> Mathieu
>
> ----- On Jul 30, 2018, at 12:00 PM, Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com> wrote:
>
> Please provide the versions of lttng-tools, lttng-modules and lttng-ust
> you are using.
>
> Also, please provide the exact sequence of commands you use to control
> tracing so we
> can try it out on our end.
>
> Thanks,
>
> Mathieu
>
> ----- On Jul 30, 2018, at 11:46 AM, sai kiran <sai9951775108@gmail.com>
> wrote:
>
> Hi,
>
> As I=E2=80=99m tracing both domain (kernel and user space) using LTTng wi=
th
> following configuration,
>
> Mode:
>
> *Live *mode.
>
> Kernel domain configuration:
>
> Sub buffer size =3D 131072,
>
> Number of sub buffers =3D 8,
>
> Switch-timer =3D 0,
>
> Reader-domain =3D 2000000.
>
>
>
> User domain configuration:
>
> Default sub buffer size and sub buffer count,
>
> Switch-timer =3D 0,
>
> Reader-domain =3D 2000000.
>
> After LTTng session is destroyed, no stream is =E2=80=9C*Hung up*=E2=80=
=9D. Continuously
> I=E2=80=99m getting data from =E2=80=9C*relay daemon*=E2=80=9D. I=E2=80=
=99ve killed consumer daemon, even
> though tracing data coming from relay daemon. Please help me. One more
> thing application is running infinitely.
>
>
>
> Thanks & Regards,
>
> T Sai Kiran
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--0000000000007657ec05726248c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div>=C2=A0I&#39;m using LTTng 2.9.4=C2=A0 version of l=
ttng-tools, lttng-modules, and lttng-ust. I&#39;m doing tracing in Xilinx Z=
ynq ZC706 evaluation kit.</div><div>the sequence of commands used for traci=
ng:</div><div>Mode:</div><div>live mode.</div><div>For relay daemon:</div><=
div>lttng-relayd -L tcp://127.0.0.1:5344--output=3D/tmp/lttnglogs/</div><di=
v>Session commds:</div><div>1) lttng create my-session --live --set-url=3Dn=
et://<a href=3D"http://127.0.0.1">127.0.0.1</a></div><div>2)=C2=A0lttng ena=
ble-channel --kernel --subbuf-size=3D131072 --num-subbuf=3D8 channel0</div>=
<div>3)=C2=A0lttng enable-channel -u --read-timer=3D2000000 channel0</div><=
div>4)=C2=A0lttng enable-event --kernel sched_process_fork,sched_process_ex=
it,irq_handler_entry,irq_handler_exit,sched_switch,sched_waking -c channel0=
 --session=3Dmy-session</div><div>5)=C2=A0lttng enable-event -u kernelprofi=
ler:kernelprofiler_task_drop -c channel0 --session=3Dmysession</div><div>6)=
 lttng start</div><div>7) lttng stop</div><div>8) lttng destroy</div><div><=
br></div><div>Here my application has a tracepoint of=C2=A0 &quot;<span sty=
le=3D"font-size:small;background-color:rgb(255,255,255);text-decoration-sty=
le:initial;text-decoration-color:initial;float:none;display:inline">kernelp=
rofiler:kernelprofiler_task_drop&quot; event.</span></div><div><span style=
=3D"font-size:small;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial;float:none;display:inline"><br></spa=
n></div><div><span style=3D"font-size:small;background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial;float:none;d=
isplay:inline">Thanks,</span></div><div><span style=3D"font-size:small;back=
ground-color:rgb(255,255,255);text-decoration-style:initial;text-decoration=
-color:initial;float:none;display:inline">T SAI KIRAN.</span></div><div><br=
></div><div><br></div><div><br></div><div><br></div><div><br></div><div><br=
></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On M=
on, Jul 30, 2018 at 9:31 PM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desno=
yers@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><=
div><div style=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;col=
or:#000000"><div>Also, please add the lttng-dev mailing list in CC, as this=
 is the appropriate forum for this<br></div><div>type of question.<br></div=
><div><br></div><div>Thanks,<br></div><div><br></div><div>Mathieu<br></div>=
<div><div class=3D"h5"><div><br></div><div><span id=3D"m_407736821617411284=
0zwchr">----- On Jul 30, 2018, at 12:00 PM, Mathieu Desnoyers &lt;<a href=
=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoy=
ers@efficios.<wbr>com</a>&gt; wrote:<br></span></div><div><blockquote style=
=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5px;color:#0=
00;font-weight:normal;font-style:normal;text-decoration:none;font-family:He=
lvetica,Arial,sans-serif;font-size:12pt"><div style=3D"font-family:arial,he=
lvetica,sans-serif;font-size:12pt;color:#000000"><div>Please provide the ve=
rsions of lttng-tools, lttng-modules and lttng-ust you are using.<br></div>=
<br><div>Also, please provide the exact sequence of commands you use to con=
trol tracing so we<br></div><div>can try it out on our end.<br></div><br><d=
iv>Thanks,<br></div><br><div>Mathieu<br></div><br><div><span id=3D"m_407736=
8216174112840zwchr">----- On Jul 30, 2018, at 11:46 AM, sai kiran &lt;<a hr=
ef=3D"mailto:sai9951775108@gmail.com" target=3D"_blank">sai9951775108@gmail=
.com</a>&gt; wrote:<br></span></div><div><blockquote style=3D"border-left:2=
px solid #1010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:no=
rmal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,san=
s-serif;font-size:12pt"><div dir=3D"ltr">

















<p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font=
-family:Calibri,sans-serif">Hi,<span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font=
-family:Calibri,sans-serif">As I=E2=80=99m tracing both domain (kernel and =
user space) using LTTng with following configuration,<span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font=
-family:Calibri,sans-serif">Mode:<span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font=
-family:Calibri,sans-serif"><b>Live </b>mode.<span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font=
-family:Calibri,sans-serif">Kernel domain configuration:<span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font=
-family:Calibri,sans-serif">Sub buffer size =3D <span style=3D"font-size:10=
pt;font-family:&quot;Courier New&quot;;color:black">131072,</span><span sty=
le=3D"font-size:12pt;font-family:&quot;Courier New&quot;"><span></span></sp=
an></p>

<p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font=
-family:Calibri,sans-serif">Number of sub buffers =3D 8,<span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font=
-family:Calibri,sans-serif">Switch-timer =3D 0,<span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font=
-family:Calibri,sans-serif">Reader-domain =3D 2000000.<span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font=
-family:Calibri,sans-serif"><span>=C2=A0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font=
-family:Calibri,sans-serif">User domain configuration:<span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font=
-family:Calibri,sans-serif">Default sub buffer size and sub buffer count,<s=
pan></span></p>

<p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font=
-family:Calibri,sans-serif">Switch-timer =3D 0,<span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font=
-family:Calibri,sans-serif">Reader-domain =3D 2000000.<span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font=
-family:Calibri,sans-serif">After LTTng session is destroyed, no stream is =
=E2=80=9C<b>Hung up</b>=E2=80=9D. Continuously I=E2=80=99m getting data fro=
m =E2=80=9C<b>relay daemon</b>=E2=80=9D. I=E2=80=99ve killed consumer daemo=
n, even though tracing data coming from relay daemon. Please help me. One m=
ore thing application is running infinitely.<span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font=
-family:Calibri,sans-serif"><span>=C2=A0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font=
-family:Calibri,sans-serif">Thanks &amp; Regards,<span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font=
-family:Calibri,sans-serif">T Sai Kiran<span></span></p>





</div><br></blockquote></div><br><div>-- <br></div><div>Mathieu Desnoyers<b=
r>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">ht=
tp://www.efficios.com</a></div></div><br></blockquote></div><div><br></div>=
<div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"htt=
p://www.efficios.com" target=3D"_blank">http://www.efficios.com</a></div></=
div></div></div></div></blockquote></div><br></div>

--0000000000007657ec05726248c1--

--===============1090613029200535110==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1090613029200535110==--
