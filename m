From: liguang li <liguang.lee6@gmail.com>
Subject: Re: Babeltrace performance issue in live-reading mode
Date: Wed, 11 Oct 2017 18:44:25 +0800
Message-ID: <CAMYaK0QBmug12risvr1_7ws5OhrCiXbfDD7+m6vSwwpYs2-c2A__41352.9056743302$1507731387$gmane$org@mail.gmail.com>
References: <CAMYaK0TVYEgM_qxCExiFn6BcgZ58+KXKqx72h_0Gv4g2JN40Yg@mail.gmail.com>
 <20170918151857.afnn5n6ntzhyzfnw@psrcode-TP-X230>
 <CAMYaK0TGprotjj0v-HayqHAaKpJaTXgqqYh55CK9JmOKBO-U8A@mail.gmail.com>
 <20170919145707.5wh3e23zet7jm3bc@psrcode-TP-X230>
 <CAMYaK0SQkdjs_gp+4fwBL1BH1oqEiqYnN6PXq-H-=ApMRbe-bg@mail.gmail.com>
 <cdf53e97-49f0-e6d4-e4b2-0bca6ab84534@efficios.com>
 <CAMYaK0TEWZGtZnvO5aDw5CZi8Rr1tXdoaBrkDRO6k-biydVn_g@mail.gmail.com>
 <05dc30ee-bf01-1960-3ec6-54018dd4512d@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3617188247168674311=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt0-x229.google.com (mail-qt0-x229.google.com
 [IPv6:2607:f8b0:400d:c0d::229])
 by lists.lttng.org (Postfix) with ESMTPS id 3yBrFk6YbWzyn9
 for <lttng-dev@lists.lttng.org>; Wed, 11 Oct 2017 10:44:26 +0000 (UTC)
Received: by mail-qt0-x229.google.com with SMTP id 1so3761777qtn.3
 for <lttng-dev@lists.lttng.org>; Wed, 11 Oct 2017 03:44:26 -0700 (PDT)
In-Reply-To: <05dc30ee-bf01-1960-3ec6-54018dd4512d@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============3617188247168674311==
Content-Type: multipart/alternative; boundary="001a114175588192a8055b431bee"

--001a114175588192a8055b431bee
Content-Type: text/plain; charset="UTF-8"

Hi,


On Thu, Sep 21, 2017 at 11:03 PM, Jonathan Rajotte Julien <
Jonathan.rajotte-julien@efficios.com> wrote:

> Hi,
>
> On 2017-09-21 05:34 AM, liguang li wrote:
> > Hi,
> >
> > On Wed, Sep 20, 2017 at 10:58 PM, Jonathan Rajotte Julien <
> Jonathan.rajotte-julien@efficios.com <mailto:Jonathan.rajotte-
> julien@efficios.com>> wrote:
> >
> >     Hi,
> >
> >     On 2017-09-20 05:12 AM, liguang li wrote:
> >     >
> >     >
> >     > On Tue, Sep 19, 2017 at 10:57 PM, Jonathan Rajotte-Julien <
> jonathan.rajotte-julien@efficios.com <mailto:jonathan.rajotte-
> julien@efficios.com> <mailto:jonathan.rajotte-julien@efficios.com <mailto:
> jonathan.rajotte-julien@efficios.com>>> wrote:
> >     >
> >     >     On Tue, Sep 19, 2017 at 03:53:27PM +0800, liguang li wrote:
> >     >     >    Hi,
> >     >     >    On Mon, Sep 18, 2017 at 11:18 PM, Jonathan Rajotte-Julien
> >     >     >    <[1]jonathan.rajotte-julien@efficios.com <mailto:
> jonathan.rajotte-julien@efficios.com> <mailto:jonathan.rajotte-
> julien@efficios.com <mailto:jonathan.rajotte-julien@efficios.com>>> wrote:
> >     >     >
> >     >     >      Hi,
> >     >     >      On Mon, Sep 18, 2017 at 11:32:07AM +0800, liguang li
> wrote:
> >     >     >      >    Hi,
> >     >     >      >
> >     >     >      >    Create a session in live-reading mode, run a
> application which
> >     >     >      having very
> >     >     >      >    high event throughput, then prints
> >     >     >      >    the events with babeltrace. We found the live
> trace viewer are
> >     >     >      viewing
> >     >     >      >    events a few seconds ago, and as time
> >     >     >
> >     >     >      Could you provide us the version used for babeltrace,
> lttng-tools and
> >     >     >      lttng-ust?
> >     >     >
> >     >     >     Babeltrace: 1.5.1
> >     >
> >     >     Update to babeltrace 1.5.3.
> >     >
> >     >     >     Lttng-tools: 2.8.6
> >     >
> >     >     Update to lttng-tools 2.8.8
> >     >
> >     >     >     Lttng-ust: 2.8.2
> >     >     >
> >     >     >      >    goes on, the delay will be bigger and bigger.
> >     >     >
> >     >     >      A similar issues was observed a couple months ago,
> which implicated
> >     >     >      multiple delayed ack
> >     >     >      problems during communication between lttng-relayd and
> babeltrace.
> >     >     >
> >     >     >      The following fixes were merged:
> >     >     >
> >     >     >      [1]
> >     >     >      [2]https://github.com/lttng/lttng-tools/commit/
> b6025e9476332b75eb8184345c3eb3e924780088 <https://github.com/lttng/
> lttng-tools/commit/b6025e9476332b75eb8184345c3eb3e924780088> <
> https://github.com/lttng/lttng-tools/commit/b6025e9476332b75eb8184345c3eb3
> e924780088 <https://github.com/lttng/lttng-tools/commit/
> b6025e9476332b75eb8184345c3eb3e924780088>>
> >     >     >      [2]
> >     >     >      [3]https://github.com/efficios/babeltrace/commit/
> de417d04317ca3bc30f59685a9d19de670e4b11d <https://github.com/efficios/
> babeltrace/commit/de417d04317ca3bc30f59685a9d19de670e4b11d> <
> https://github.com/efficios/babeltrace/commit/
> de417d04317ca3bc30f59685a9d19de670e4b11d <https://github.com/efficios/
> babeltrace/commit/de417d04317ca3bc30f59685a9d19de670e4b11d>>
> >     >     >      [3]
> >     >     >      [4]https://github.com/efficios/babeltrace/commit/
> 4594dbd8f7c2af2446a3e310bee74ba4a2e9d648 <https://github.com/efficios/
> babeltrace/commit/4594dbd8f7c2af2446a3e310bee74ba4a2e9d648> <
> https://github.com/efficios/babeltrace/commit/
> 4594dbd8f7c2af2446a3e310bee74ba4a2e9d648 <https://github.com/efficios/
> babeltrace/commit/4594dbd8f7c2af2446a3e310bee74ba4a2e9d648>>
> >     >     >
> >     >     >      In the event that you are already using an updated
> version of babeltrace
> >     >     >      and
> >     >     >      lttng-tools, it would be pertinent to provide us with a
> simple
> >     >     >      reproducer so we
> >     >     >      can assess the issue.
> >     >
> >     >     The version you are using does not include the mentioned
> fixes. Please update
> >     >     and redo your experiment.
> >     >
> >     >
> >     > Test this issue in the version you have listed, the issue still
> exists.
> >
> >     Given that previous versions had a major timing problem there I
> would expect to have some improvement.
> >
> >     In that case, we will need a lot more information on your
> benchmarking strategy.
> >     We will need a simple reproducer, your benchmark code (r,gnuplot
> etc.), your overall methodology
> >     to be able to reproduce the issue locally. Otherwise, it will be
> very hard
> >     to come to any conclusion.
> >
> >
> > Sorry, we can not provide the detailed information about the benchmark
> code due to the company regulations.
> >
> >
> >     >
> >     >
> >     >     Cheers
> >     >
> >     >     >
> >     >     >
> >     >     >     Steps:
> >     >     >     lttng create session --live -U net://*
> >     >     >     lttng enable-channel -s session -u ch1
> >     >     >     lttng enable-event -s session -c ch1 -u -a
> >     >     >     lttng start
> >     >     >
> >     >     >     Run a high event throughput application, which is
> multithreaded
> >     >     >    application>
> >     >
> >     > In the multithreaded application, each tracepoint will have the
> wall
> >     > time of the system,then we can easily reproduce this issue through
> >     > comparing the time of recorded event and the system wall time.
> >     >
> >     >
> >     >     >     babeltrace -i lttng-live net://*
> >     >     >
> >     >     >     After a while, we found the timestamp of the event in
> the babeltrace is
> >     >     >    different with the time in host
> >     >     >     which run the application. And the delay will be bigger
> and bigger with
> >     >     >    time goes.
> >     >     >
> >     >     >
> >     >     >      Cheers
> >     >     >      >    I checked the source code, found Babeltrace in
> live-reading mode
> >     >     >      will read
> >     >     >      >    the recorded events in the CTF
> >     >     >      >    files, and then parse and print it in a single
> thread. The process
> >     >     >      is a
> >     >     >      >    little slow, do you have any ideas to
> >     >     >      >    improve the process.
> >     >
> >     >
> >     > From my understanding of the source code, the process of parse and
> >     > print event will consume a lot of time. For example, the
> multithreaded
> >     > application will consume 3 CPUs, in a specified time,3 subbuffers
> will
> >     > be filled and sent to lttng-relayd daemon, recorded into the CTF
> files.
> >     > If in the specified time, babeltrace only handled 2 subbuffers'
> event,
> >     > thenthe issue will happens.
> >
> >     Did you perform a bisection for where the delay come from? Reception
> of packet? formatting of event?
>
> ?
>
> >     What is the throughput of the application?
>
>
> ?
> This is a key element if anyone want to test at home. It can be expressed
> in event/s, event/ms.
>
> >     How many tracepoint definition>     Does babeltrace catch up if a
> quiescent period is given?
> >
> >
> > I think so.
> >
> >
> >     Could you provide us with statistics, timing data, etc.?
> >
> >     What type of delay are we talking about?
> >
> >
> > For example, the system wall time is 5:18 PM now, but the Babeltrace is
> still printing events which
> > have time 5:10 PM. Then stop running the application, the Babeltrace
> still need some times to print
> > the recorded events.
> >
> > I think the root cause is that the parsing and printing process is a bit
> slow. So i want to know if there
> > are any method to improve the performance of this process.
>
> A simple experiment would be to run a bounded workload
> to perform a quick timing evaluation of babeltrace with a streamed trace
> (on disk) and in live mode.
> Calculate the time (time babeltrace path_to_streamed_trace) it takes
> babeltrace to read the on disk trace
> and perform the same experiment with a live trace. It is important to
> bound your experiment
> and have mostly the same workload in both experiment.
>
>
I made a simple example to illustrate the issue which i had met.

Run the application for about 60 seconds, the trace is stored on disk. The
time of reading the trace using babeltrace is about 150 seconds. The speed
of processing is much lower than generating the trace.

I think the performance of babeltrace in live mode will not greater than
reading the trace on disk. So in live mode, timestamp of the event will
have delay (printing event with timestamp of few minutes ago), i wonder to
know if there are any methods to improve the performance of babeltrace in
live mode.

Regards,
Liguang


> This will give us a rough estimate of the disparity between both scenario.
>
> Cheers
>

--001a114175588192a8055b431bee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi,<br><br></div></div><div class=3D"gmail_extra=
"><br><div class=3D"gmail_quote">On Thu, Sep 21, 2017 at 11:03 PM, Jonathan=
 Rajotte Julien <span dir=3D"ltr">&lt;<a href=3D"mailto:Jonathan.rajotte-ju=
lien@efficios.com" target=3D"_blank">Jonathan.rajotte-julien@efficios.com</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">H=
i,<br>
<span class=3D"gmail-"><br>
On 2017-09-21 05:34 AM, liguang li wrote:<br>
&gt; Hi,<br>
&gt;<br>
</span><span class=3D"gmail-">&gt; On Wed, Sep 20, 2017 at 10:58 PM, Jonath=
an Rajotte Julien &lt;<a href=3D"mailto:Jonathan.rajotte-julien@efficios.co=
m">Jonathan.rajotte-julien@<wbr>efficios.com</a> &lt;mailto:<a href=3D"mail=
to:Jonathan.rajotte-julien@efficios.com">Jonathan.rajotte-<wbr>julien@effic=
ios.com</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0On 2017-09-20 05:12 AM, liguang li wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
</span><span class=3D"gmail-">&gt;=C2=A0 =C2=A0 =C2=A0&gt; On Tue, Sep 19, =
2017 at 10:57 PM, Jonathan Rajotte-Julien &lt;<a href=3D"mailto:jonathan.ra=
jotte-julien@efficios.com">jonathan.rajotte-julien@<wbr>efficios.com</a> &l=
t;mailto:<a href=3D"mailto:jonathan.rajotte-julien@efficios.com">jonathan.r=
ajotte-<wbr>julien@efficios.com</a>&gt; &lt;mailto:<a href=3D"mailto:jonath=
an.rajotte-julien@efficios.com">jonathan.rajotte-<wbr>julien@efficios.com</=
a> &lt;mailto:<a href=3D"mailto:jonathan.rajotte-julien@efficios.com">jonat=
han.rajotte-<wbr>julien@efficios.com</a>&gt;&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0On Tue, Sep 19, 2017 at 03:=
53:27PM +0800, liguang li wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 Hi,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 On Mon, S=
ep 18, 2017 at 11:18 PM, Jonathan Rajotte-Julien<br>
</span><span class=3D"gmail-">&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=
=A0&gt;=C2=A0 =C2=A0 &lt;[1]<a href=3D"mailto:jonathan.rajotte-julien@effic=
ios.com">jonathan.rajotte-julien@<wbr>efficios.com</a> &lt;mailto:<a href=
=3D"mailto:jonathan.rajotte-julien@efficios.com">jonathan.rajotte-<wbr>juli=
en@efficios.com</a>&gt; &lt;mailto:<a href=3D"mailto:jonathan.rajotte-julie=
n@efficios.com">jonathan.rajotte-<wbr>julien@efficios.com</a> &lt;mailto:<a=
 href=3D"mailto:jonathan.rajotte-julien@efficios.com">jonathan.rajotte-<wbr=
>julien@efficios.com</a>&gt;&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 Hi=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 On=
 Mon, Sep 18, 2017 at 11:32:07AM +0800, liguang li wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 Hi,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 &g=
t;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 Create a session in live-reading mode, run a application wh=
ich<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 ha=
ving very<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 high event throughput, then prints<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 the events with babeltrace. We found the live trace viewer =
are<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 vi=
ewing<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 events a few seconds ago, and as time<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 Co=
uld you provide us the version used for babeltrace, lttng-tools and<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 lt=
tng-ust?<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Bab=
eltrace: 1.5.1<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Update to babeltrace 1.5.3.=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Ltt=
ng-tools: 2.8.6<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Update to lttng-tools 2.8.8=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Ltt=
ng-ust: 2.8.2<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 goes on, the delay will be bigger and bigger.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 A =
similar issues was observed a couple months ago, which implicated<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 mu=
ltiple delayed ack<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 pr=
oblems during communication between lttng-relayd and babeltrace.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 Th=
e following fixes were merged:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 [1=
]<br>
</span>&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =
=C2=A0 [2]<a href=3D"https://github.com/lttng/lttng-tools/commit/b6025e9476=
332b75eb8184345c3eb3e924780088" rel=3D"noreferrer" target=3D"_blank">https:=
//github.com/lttng/<wbr>lttng-tools/commit/<wbr>b6025e9476332b75eb8184345c3=
eb3<wbr>e924780088</a> &lt;<a href=3D"https://github.com/lttng/lttng-tools/=
commit/b6025e9476332b75eb8184345c3eb3e924780088" rel=3D"noreferrer" target=
=3D"_blank">https://github.com/lttng/<wbr>lttng-tools/commit/<wbr>b6025e947=
6332b75eb8184345c3eb3<wbr>e924780088</a>&gt; &lt;<a href=3D"https://github.=
com/lttng/lttng-tools/commit/b6025e9476332b75eb8184345c3eb3e924780088" rel=
=3D"noreferrer" target=3D"_blank">https://github.com/lttng/<wbr>lttng-tools=
/commit/<wbr>b6025e9476332b75eb8184345c3eb3<wbr>e924780088</a> &lt;<a href=
=3D"https://github.com/lttng/lttng-tools/commit/b6025e9476332b75eb8184345c3=
eb3e924780088" rel=3D"noreferrer" target=3D"_blank">https://github.com/lttn=
g/<wbr>lttng-tools/commit/<wbr>b6025e9476332b75eb8184345c3eb3<wbr>e92478008=
8</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 [2=
]<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 [3=
]<a href=3D"https://github.com/efficios/babeltrace/commit/de417d04317ca3bc3=
0f59685a9d19de670e4b11d" rel=3D"noreferrer" target=3D"_blank">https://githu=
b.com/<wbr>efficios/babeltrace/commit/<wbr>de417d04317ca3bc30f59685a9d19d<w=
br>e670e4b11d</a> &lt;<a href=3D"https://github.com/efficios/babeltrace/com=
mit/de417d04317ca3bc30f59685a9d19de670e4b11d" rel=3D"noreferrer" target=3D"=
_blank">https://github.com/efficios/<wbr>babeltrace/commit/<wbr>de417d04317=
ca3bc30f59685a9d19d<wbr>e670e4b11d</a>&gt; &lt;<a href=3D"https://github.co=
m/efficios/babeltrace/commit/de417d04317ca3bc30f59685a9d19de670e4b11d" rel=
=3D"noreferrer" target=3D"_blank">https://github.com/efficios/<wbr>babeltra=
ce/commit/<wbr>de417d04317ca3bc30f59685a9d19d<wbr>e670e4b11d</a> &lt;<a hre=
f=3D"https://github.com/efficios/babeltrace/commit/de417d04317ca3bc30f59685=
a9d19de670e4b11d" rel=3D"noreferrer" target=3D"_blank">https://github.com/e=
fficios/<wbr>babeltrace/commit/<wbr>de417d04317ca3bc30f59685a9d19d<wbr>e670=
e4b11d</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 [3=
]<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 [4=
]<a href=3D"https://github.com/efficios/babeltrace/commit/4594dbd8f7c2af244=
6a3e310bee74ba4a2e9d648" rel=3D"noreferrer" target=3D"_blank">https://githu=
b.com/<wbr>efficios/babeltrace/commit/<wbr>4594dbd8f7c2af2446a3e310bee74b<w=
br>a4a2e9d648</a> &lt;<a href=3D"https://github.com/efficios/babeltrace/com=
mit/4594dbd8f7c2af2446a3e310bee74ba4a2e9d648" rel=3D"noreferrer" target=3D"=
_blank">https://github.com/efficios/<wbr>babeltrace/commit/<wbr>4594dbd8f7c=
2af2446a3e310bee74b<wbr>a4a2e9d648</a>&gt; &lt;<a href=3D"https://github.co=
m/efficios/babeltrace/commit/4594dbd8f7c2af2446a3e310bee74ba4a2e9d648" rel=
=3D"noreferrer" target=3D"_blank">https://github.com/efficios/<wbr>babeltra=
ce/commit/<wbr>4594dbd8f7c2af2446a3e310bee74b<wbr>a4a2e9d648</a> &lt;<a hre=
f=3D"https://github.com/efficios/babeltrace/commit/4594dbd8f7c2af2446a3e310=
bee74ba4a2e9d648" rel=3D"noreferrer" target=3D"_blank">https://github.com/e=
fficios/<wbr>babeltrace/commit/<wbr>4594dbd8f7c2af2446a3e310bee74b<wbr>a4a2=
e9d648</a>&gt;&gt;<br>
<div><div class=3D"gmail-h5">&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=
=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 In=
 the event that you are already using an updated version of babeltrace<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 an=
d<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 lt=
tng-tools, it would be pertinent to provide us with a simple<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 re=
producer so we<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 ca=
n assess the issue.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0The version you are using d=
oes not include the mentioned fixes. Please update<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0and redo your experiment.<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Test this issue in the version you have listed=
, the issue still exists.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Given that previous versions had a major timing pro=
blem there I would expect to have some improvement.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0In that case, we will need a lot more information o=
n your benchmarking strategy.<br>
&gt;=C2=A0 =C2=A0 =C2=A0We will need a simple reproducer, your benchmark co=
de (r,gnuplot etc.), your overall methodology<br>
&gt;=C2=A0 =C2=A0 =C2=A0to be able to reproduce the issue locally. Otherwis=
e, it will be very hard<br>
&gt;=C2=A0 =C2=A0 =C2=A0to come to any conclusion.<br>
&gt;<br>
&gt;<br>
&gt; Sorry, we can not provide the detailed information about the benchmark=
 code due to the company regulations.<br>
&gt; =C2=A0<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Cheers<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Ste=
ps:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0ltt=
ng create session --live -U net://*<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0ltt=
ng enable-channel -s session -u ch1<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0ltt=
ng enable-event -s session -c ch1 -u -a<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0ltt=
ng start<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Run=
 a high event throughput application, which is multithreaded<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 applicati=
on&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; In the multithreaded application, each tracepo=
int will have the wall<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; time of the system,then we can easily reproduc=
e this issue through<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; comparing the time of recorded event and the s=
ystem wall time.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0bab=
eltrace -i lttng-live net://*<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Aft=
er a while, we found the timestamp of the event in the babeltrace is<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 different=
 with the time in host<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0whi=
ch run the application. And the delay will be bigger and bigger with<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 time goes=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 Ch=
eers<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 I checked the source code, found Babeltrace in live-reading=
 mode<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 wi=
ll read<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 the recorded events in the CTF<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 files, and then parse and print it in a single thread. The =
process<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 is=
 a<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 little slow, do you have any ideas to<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 improve the process.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; From my understanding of the source code, the =
process of parse and<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; print event will consume a lot of time. For ex=
ample, the multithreaded<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; application will consume 3 CPUs, in a specifie=
d time,3 subbuffers will<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; be filled and sent to lttng-relayd daemon, rec=
orded into the CTF files.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; If in the specified time, babeltrace only hand=
led 2 subbuffers&#39; event,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; thenthe issue will happens.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Did you perform a bisection for where the delay com=
e from? Reception of packet? formatting of event?<br>
<br>
?<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0What is the throughput of the application?<br>
<br>
<br>
</div></div>?<br>
This is a key element if anyone want to test at home. It can be expressed i=
n event/s, event/ms.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0How many tracepoint definition&gt;=C2=A0 =C2=A0 =C2=
=A0Does babeltrace catch up if a quiescent period is given?<br>
<span class=3D"gmail-">&gt;<br>
&gt;<br>
&gt; I think so.<br>
&gt; =C2=A0<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Could you provide us with statistics, timing data, =
etc.?<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0What type of delay are we talking about?<br>
&gt;<br>
&gt;<br>
&gt; For example, the system wall time is 5:18 PM now, but the Babeltrace i=
s still printing events which<br>
&gt; have time 5:10 PM. Then stop running the application, the Babeltrace s=
till need some times to print<br>
&gt; the recorded events.<br>
&gt;<br>
&gt; I think the root cause is that the parsing and printing process is a b=
it slow. So i want to know if there<br>
&gt; are any method to improve the performance of this process.<br>
<br>
</span>A simple experiment would be to run a bounded workload<br>
to perform a quick timing evaluation of babeltrace with a streamed trace (o=
n disk) and in live mode.<br>
Calculate the time (time babeltrace path_to_streamed_trace) it takes babelt=
race to read the on disk trace<br>
and perform the same experiment with a live trace. It is important to bound=
 your experiment<br>
and have mostly the same workload in both experiment.<br>
<br></blockquote><div>=C2=A0</div><div>I made a simple example to illustrat=
e the issue which i had met.<br><div><br></div><div>Run
 the application for about 60 seconds, the trace is stored on disk. The=20
time of reading the trace using babeltrace is about 150 seconds. The=20
speed of processing is much lower than generating the trace. <br></div><div=
><br></div><div>I
 think the performance of babeltrace in live mode will not greater than=20
reading the trace on disk. So in live mode, timestamp of the event will hav=
e delay (printing event with timestamp of few minutes ago), i wonder to kno=
w if there are any methods=20
to improve the performance of babeltrace in live mode.</div><div><br></div>=
<div>Regards,</div><div>Liguang</div></div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
This will give us a rough estimate of the disparity between both scenario.<=
br>
<br>
Cheers<br>
</blockquote></div><br></div></div>

--001a114175588192a8055b431bee--

--===============3617188247168674311==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3617188247168674311==--
