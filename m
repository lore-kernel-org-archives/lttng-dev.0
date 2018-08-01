From: sai kiran <sai9951775108@gmail.com>
Subject: Re: LTTng streams not Hung up even session is destroyed
Date: Wed, 1 Aug 2018 23:11:39 +0530
Message-ID: <CAPB=nBvc8JMvrppOBOF+SDcH5k-e=Uoh9eb3fCQcqPBW1OLYkQ__46095.5633120195$1533148581$gmane$org@mail.gmail.com>
References: <CAPB=nBs16oE95zHyX3xF6F895g1Phe=8AKFmsX185M8rZvyhEw@mail.gmail.com>
 <1098573093.6842.1532966434523.JavaMail.zimbra@efficios.com>
 <2025170812.6867.1532966515434.JavaMail.zimbra@efficios.com>
 <CAPB=nBs84oqYvPECThCoheHQZr6QGONBhSR1o61iB1bS7vbXdg@mail.gmail.com>
 <20180801171307.GA23912@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9063592929895603798=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it0-x22d.google.com (mail-it0-x22d.google.com
 [IPv6:2607:f8b0:4001:c0b::22d])
 by lists.lttng.org (Postfix) with ESMTPS id 41ggbV0WbCz14l2
 for <lttng-dev@lists.lttng.org>; Wed,  1 Aug 2018 13:41:41 -0400 (EDT)
Received: by mail-it0-x22d.google.com with SMTP id h23-v6so10460347ita.5
 for <lttng-dev@lists.lttng.org>; Wed, 01 Aug 2018 10:41:41 -0700 (PDT)
In-Reply-To: <20180801171307.GA23912@joraj-alpa>
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
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============9063592929895603798==
Content-Type: multipart/alternative; boundary="0000000000000616e705726335ee"

--0000000000000616e705726335ee
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
The reason for reader timer option is, UST event throughput is very low so
if I don't use this option I'm not at all getting UST trace data. Even
though the difference between "reader-timer" and "switch-timer" is not
clear for me. Correct me if I wrong,

 "Switch-Timer": After switch timer expires, Consumer daemon will take the
current sub-buffer data and new trace data will be written to next
sub-buffer (if available). So switch between sub-buffer will happen.
"Reader-Timer": After Reader-Timer expires, Consumer daemon will check
sub-buffer is full or not. If Full then consumer daemon will take the data
or else consumer daemon won't take trace data.

I'm using my own application.

Thanks,
T SAI KIRAN.

On Wed, Aug 1, 2018 at 10:43 PM, Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> Hi Sai,
>
> On Wed, Aug 01, 2018 at 10:05:30PM +0530, sai kiran wrote:
> > Hi,
> >  I'm using LTTng 2.9.4  version of lttng-tools, lttng-modules, and
> > lttng-ust. I'm doing tracing in Xilinx Zynq ZC706 evaluation kit.
> > the sequence of commands used for tracing:
> > Mode:
> > live mode.
>
> What is the reason behind using the live feature here since you are runni=
ng
> things locally (lttng-relayd/--set-url 127.0.0.1)?
>
> Are you doing live analysis or performing analysis after the
> fact?
>
> In other word, what are you trying to achieve with tracing?
>
> I just want to make sure that you are using the most appropriate way of
> tracing
> to achieve your goal.
>
> > For relay daemon:
> > lttng-relayd -L tcp://127.0.0.1:5344--output=3D/tmp/lttnglogs/
> > Session commds:
> > 1) lttng create my-session --live --set-url=3Dnet://127.0.0.1
> > 2) lttng enable-channel --kernel --subbuf-size=3D131072 --num-subbuf=3D=
8
> > channel0
> > 3) lttng enable-channel -u --read-timer=3D2000000 channel0
>
> Are you sure you want to use the read-timer option?
>
> Using 2000000 as its value mean that userspace subbuffers status will onl=
y
> be checked
> upon each 2 seconds.
>
> > 4) lttng enable-event --kernel
> > sched_process_fork,sched_process_exit,irq_handler_
> entry,irq_handler_exit,sched_switch,sched_waking
> > -c channel0 --session=3Dmy-session
> > 5) lttng enable-event -u kernelprofiler:kernelprofiler_task_drop -c
> > channel0 --session=3Dmysession
> > 6) lttng start
> > 7) lttng stop
> > 8) lttng destroy
> >
> > Here my application has a tracepoint of
> > "kernelprofiler:kernelprofiler_task_drop"
> > event.
> >
>
> > > Hi,
> > >
> > > After LTTng session is destroyed, no stream is =E2=80=9C*Hung up*=E2=
=80=9D.
> Continuously
>
> What do you mean by "Hung up"? Are you using babeltrace and connecting to
> the
> lttng-relayd daemon on localhost?
>
> What is your expectation?
>
> Do you mean that you are still receiving data on babeltrace side even whe=
n
> performing a lttng stop/destroy command?
>
> > > I=E2=80=99m getting data from =E2=80=9C*relay daemon*=E2=80=9D. I=E2=
=80=99ve killed consumer daemon,
> even
> > > though tracing data coming from relay daemon.
>
> This can happen if babeltrace is "catching-up" on the data, keep in mind
> that
> lttng-relayd have the trace data and can continue to send information to =
a
> babeltrace client even if the consumerd/sessiond is killed or the session
> stopped/destroyed.
>
> > > Please help me. One more
> > > thing application is running infinitely.
>
> Which application? Your application? Babeltrace? lttng-sessiond?
>
> If you are talking about your application, could you provide a backtrace
> indicating that ust is the culprit here?
>
> Cheers
>
> --
> Jonathan Rajotte-Julien
> EfficiOS
>

--0000000000000616e705726335ee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div>The reason for reader timer option is, UST event t=
hroughput is very low so if I don&#39;t use this option I&#39;m not at all =
getting UST trace data. Even though the difference between &quot;reader-tim=
er&quot; and &quot;switch-timer&quot; is not clear for me. Correct me if I =
wrong,</div><div><br></div><div>=C2=A0&quot;Switch-Timer&quot;: After switc=
h timer expires, Consumer daemon will take the current sub-buffer data and =
new trace data will be written to next sub-buffer (if available). So switch=
 between sub-buffer will happen.</div><div>&quot;Reader-Timer&quot;: After =
Reader-Timer expires, Consumer daemon will check sub-buffer is full or not.=
 If Full then consumer daemon will take the data or else consumer daemon wo=
n&#39;t take trace data.</div><div><br></div><div>I&#39;m using my own appl=
ication.</div><div><br></div><div>Thanks,</div><div>T SAI KIRAN.</div></div=
><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Aug 1, 2=
018 at 10:43 PM, Jonathan Rajotte-Julien <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:jonathan.rajotte-julien@efficios.com" target=3D"_blank">jonathan.rajo=
tte-julien@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">Hi Sai,<br>
<span class=3D""><br>
On Wed, Aug 01, 2018 at 10:05:30PM +0530, sai kiran wrote:<br>
&gt; Hi,<br>
&gt;=C2=A0 I&#39;m using LTTng 2.9.4=C2=A0 version of lttng-tools, lttng-mo=
dules, and<br>
&gt; lttng-ust. I&#39;m doing tracing in Xilinx Zynq ZC706 evaluation kit.<=
br>
&gt; the sequence of commands used for tracing:<br>
&gt; Mode:<br>
&gt; live mode.<br>
<br>
</span>What is the reason behind using the live feature here since you are =
running<br>
things locally (lttng-relayd/--set-url 127.0.0.1)?<br>
<br>
Are you doing live analysis or performing analysis after the<br>
fact?<br>
<br>
In other word, what are you trying to achieve with tracing?<br>
<br>
I just want to make sure that you are using the most appropriate way of tra=
cing<br>
to achieve your goal.<br>
<span class=3D""><br>
&gt; For relay daemon:<br>
&gt; lttng-relayd -L tcp://127.0.0.1:5344--output=3D/<wbr>tmp/lttnglogs/<br=
>
&gt; Session commds:<br>
&gt; 1) lttng create my-session --live --set-url=3Dnet://<a href=3D"http://=
127.0.0.1" rel=3D"noreferrer" target=3D"_blank">127.0.0.1</a><br>
&gt; 2) lttng enable-channel --kernel --subbuf-size=3D131072 --num-subbuf=
=3D8<br>
&gt; channel0<br>
&gt; 3) lttng enable-channel -u --read-timer=3D2000000 channel0<br>
<br>
</span>Are you sure you want to use the read-timer option?<br>
<br>
Using 2000000 as its value mean that userspace subbuffers status will only =
be checked<br>
upon each 2 seconds.<br>
<span class=3D""><br>
&gt; 4) lttng enable-event --kernel<br>
&gt; sched_process_fork,sched_<wbr>process_exit,irq_handler_<wbr>entry,irq_=
handler_exit,sched_<wbr>switch,sched_waking<br>
&gt; -c channel0 --session=3Dmy-session<br>
&gt; 5) lttng enable-event -u kernelprofiler:kernelprofiler_<wbr>task_drop =
-c<br>
&gt; channel0 --session=3Dmysession<br>
&gt; 6) lttng start<br>
&gt; 7) lttng stop<br>
&gt; 8) lttng destroy<br>
&gt; <br>
&gt; Here my application has a tracepoint of<br>
&gt; &quot;kernelprofiler:<wbr>kernelprofiler_task_drop&quot;<br>
&gt; event.<br>
&gt; <br>
<br>
</span>&gt; &gt; Hi,<br>
&gt; &gt;<br>
&gt; &gt; After LTTng session is destroyed, no stream is =E2=80=9C*Hung up*=
=E2=80=9D. Continuously<br>
<br>
What do you mean by &quot;Hung up&quot;? Are you using babeltrace and conne=
cting to the<br>
lttng-relayd daemon on localhost?<br>
<br>
What is your expectation?<br>
<br>
Do you mean that you are still receiving data on babeltrace side even when<=
br>
performing a lttng stop/destroy command?<br>
<br>
&gt; &gt; I=E2=80=99m getting data from =E2=80=9C*relay daemon*=E2=80=9D. I=
=E2=80=99ve killed consumer daemon, even<br>
<span class=3D"">&gt; &gt; though tracing data coming from relay daemon.<br=
>
<br>
</span>This can happen if babeltrace is &quot;catching-up&quot; on the data=
, keep in mind that<br>
lttng-relayd have the trace data and can continue to send information to a<=
br>
babeltrace client even if the consumerd/sessiond is killed or the session<b=
r>
stopped/destroyed.<br>
<span class=3D""><br>
&gt; &gt; Please help me. One more<br>
&gt; &gt; thing application is running infinitely.<br>
<br>
</span>Which application? Your application? Babeltrace? lttng-sessiond?<br>
<br>
If you are talking about your application, could you provide a backtrace<br=
>
indicating that ust is the culprit here?<br>
<br>
Cheers<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</font></span></blockquote></div><br></div>

--0000000000000616e705726335ee--

--===============9063592929895603798==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============9063592929895603798==--
