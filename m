From: liguang li <liguang.lee6@gmail.com>
Subject: Re: Babeltrace performance issue in live-reading mode
Date: Thu, 21 Sep 2017 17:34:34 +0800
Message-ID: <CAMYaK0TEWZGtZnvO5aDw5CZi8Rr1tXdoaBrkDRO6k-biydVn_g__45027.9875928119$1506004472$gmane$org@mail.gmail.com>
References: <CAMYaK0TVYEgM_qxCExiFn6BcgZ58+KXKqx72h_0Gv4g2JN40Yg@mail.gmail.com>
 <20170918151857.afnn5n6ntzhyzfnw@psrcode-TP-X230>
 <CAMYaK0TGprotjj0v-HayqHAaKpJaTXgqqYh55CK9JmOKBO-U8A@mail.gmail.com>
 <20170919145707.5wh3e23zet7jm3bc@psrcode-TP-X230>
 <CAMYaK0SQkdjs_gp+4fwBL1BH1oqEiqYnN6PXq-H-=ApMRbe-bg@mail.gmail.com>
 <cdf53e97-49f0-e6d4-e4b2-0bca6ab84534@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2298720117342283576=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-x230.google.com (mail-qk0-x230.google.com
 [IPv6:2607:f8b0:400d:c09::230])
 by lists.lttng.org (Postfix) with ESMTPS id 3xyWfN3qLgzCwt
 for <lttng-dev@lists.lttng.org>; Thu, 21 Sep 2017 09:34:36 +0000 (UTC)
Received: by mail-qk0-x230.google.com with SMTP id u67so5175673qkg.6
 for <lttng-dev@lists.lttng.org>; Thu, 21 Sep 2017 02:34:36 -0700 (PDT)
In-Reply-To: <cdf53e97-49f0-e6d4-e4b2-0bca6ab84534@efficios.com>
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

--===============2298720117342283576==
Content-Type: multipart/alternative; boundary="94eb2c070154e691ca0559afccbb"

--94eb2c070154e691ca0559afccbb
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, Sep 20, 2017 at 10:58 PM, Jonathan Rajotte Julien <
Jonathan.rajotte-julien@efficios.com> wrote:

> Hi,
>
> On 2017-09-20 05:12 AM, liguang li wrote:
> >
> >
> > On Tue, Sep 19, 2017 at 10:57 PM, Jonathan Rajotte-Julien <
> jonathan.rajotte-julien@efficios.com <mailto:jonathan.rajotte-
> julien@efficios.com>> wrote:
> >
> >     On Tue, Sep 19, 2017 at 03:53:27PM +0800, liguang li wrote:
> >     >    Hi,
> >     >    On Mon, Sep 18, 2017 at 11:18 PM, Jonathan Rajotte-Julien
> >     >    <[1]jonathan.rajotte-julien@efficios.com <mailto:
> jonathan.rajotte-julien@efficios.com>> wrote:
> >     >
> >     >      Hi,
> >     >      On Mon, Sep 18, 2017 at 11:32:07AM +0800, liguang li wrote:
> >     >      >    Hi,
> >     >      >
> >     >      >    Create a session in live-reading mode, run a application
> which
> >     >      having very
> >     >      >    high event throughput, then prints
> >     >      >    the events with babeltrace. We found the live trace
> viewer are
> >     >      viewing
> >     >      >    events a few seconds ago, and as time
> >     >
> >     >      Could you provide us the version used for babeltrace,
> lttng-tools and
> >     >      lttng-ust?
> >     >
> >     >     Babeltrace: 1.5.1
> >
> >     Update to babeltrace 1.5.3.
> >
> >     >     Lttng-tools: 2.8.6
> >
> >     Update to lttng-tools 2.8.8
> >
> >     >     Lttng-ust: 2.8.2
> >     >
> >     >      >    goes on, the delay will be bigger and bigger.
> >     >
> >     >      A similar issues was observed a couple months ago, which
> implicated
> >     >      multiple delayed ack
> >     >      problems during communication between lttng-relayd and
> babeltrace.
> >     >
> >     >      The following fixes were merged:
> >     >
> >     >      [1]
> >     >      [2]https://github.com/lttng/lttng-tools/commit/
> b6025e9476332b75eb8184345c3eb3e924780088 <https://github.com/lttng/
> lttng-tools/commit/b6025e9476332b75eb8184345c3eb3e924780088>
> >     >      [2]
> >     >      [3]https://github.com/efficios/babeltrace/commit/
> de417d04317ca3bc30f59685a9d19de670e4b11d <https://github.com/efficios/
> babeltrace/commit/de417d04317ca3bc30f59685a9d19de670e4b11d>
> >     >      [3]
> >     >      [4]https://github.com/efficios/babeltrace/commit/
> 4594dbd8f7c2af2446a3e310bee74ba4a2e9d648 <https://github.com/efficios/
> babeltrace/commit/4594dbd8f7c2af2446a3e310bee74ba4a2e9d648>
> >     >
> >     >      In the event that you are already using an updated version of
> babeltrace
> >     >      and
> >     >      lttng-tools, it would be pertinent to provide us with a simple
> >     >      reproducer so we
> >     >      can assess the issue.
> >
> >     The version you are using does not include the mentioned fixes.
> Please update
> >     and redo your experiment.
> >
> >
> > Test this issue in the version you have listed, the issue still exists.
>
> Given that previous versions had a major timing problem there I would
> expect to have some improvement.
>
> In that case, we will need a lot more information on your benchmarking
> strategy.
> We will need a simple reproducer, your benchmark code (r,gnuplot etc.),
> your overall methodology
> to be able to reproduce the issue locally. Otherwise, it will be very hard
> to come to any conclusion.
>
>
Sorry, we can not provide the detailed information about the benchmark code
due to the company regulations.


> >
> >
> >     Cheers
> >
> >     >
> >     >
> >     >     Steps:
> >     >     lttng create session --live -U net://*
> >     >     lttng enable-channel -s session -u ch1
> >     >     lttng enable-event -s session -c ch1 -u -a
> >     >     lttng start
> >     >
> >     >     Run a high event throughput application, which is multithreaded
> >     >    application>
> >
> > In the multithreaded application, each tracepoint will have the wall
> > time of the system,then we can easily reproduce this issue through
> > comparing the time of recorded event and the system wall time.
> >
> >
> >     >     babeltrace -i lttng-live net://*
> >     >
> >     >     After a while, we found the timestamp of the event in the
> babeltrace is
> >     >    different with the time in host
> >     >     which run the application. And the delay will be bigger and
> bigger with
> >     >    time goes.
> >     >
> >     >
> >     >      Cheers
> >     >      >    I checked the source code, found Babeltrace in
> live-reading mode
> >     >      will read
> >     >      >    the recorded events in the CTF
> >     >      >    files, and then parse and print it in a single thread.
> The process
> >     >      is a
> >     >      >    little slow, do you have any ideas to
> >     >      >    improve the process.
> >
> >
> > From my understanding of the source code, the process of parse and
> > print event will consume a lot of time. For example, the multithreaded
> > application will consume 3 CPUs, in a specified time,3 subbuffers will
> > be filled and sent to lttng-relayd daemon, recorded into the CTF files.
> > If in the specified time, babeltrace only handled 2 subbuffers' event,
> > thenthe issue will happens.
>
> Did you perform a bisection for where the delay come from? Reception of
> packet? formatting of event?
> What is the throughput of the application?
> How many tracepoint definition?
> Does babeltrace catch up if a quiescent period is given?
>

I think so.


> Could you provide us with statistics, timing data, etc.?
>
What type of delay are we talking about?
>
>
For example, the system wall time is 5:18 PM now, but the Babeltrace is
still printing events which
have time 5:10 PM. Then stop running the application, the Babeltrace still
need some times to print
the recorded events.

I think the root cause is that the parsing and printing process is a bit
slow. So i want to know if there
are any method to improve the performance of this process.

Regards,
Liguang

--
> Jonathan R. Julien
> Efficios
>

--94eb2c070154e691ca0559afccbb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div><div class=3D"gmail_extra"><br><div class=3D"g=
mail_quote">On Wed, Sep 20, 2017 at 10:58 PM, Jonathan Rajotte Julien <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:Jonathan.rajotte-julien@efficios.com" ta=
rget=3D"_blank">Jonathan.rajotte-julien@efficios.com</a>&gt;</span> wrote:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
On 2017-09-20 05:12 AM, liguang li wrote:<br>
<span class=3D"">&gt;<br>
&gt;<br>
&gt; On Tue, Sep 19, 2017 at 10:57 PM, Jonathan Rajotte-Julien &lt;<a href=
=3D"mailto:jonathan.rajotte-julien@efficios.com">jonathan.rajotte-julien@<w=
br>efficios.com</a> &lt;mailto:<a href=3D"mailto:jonathan.rajotte-julien@ef=
ficios.com">jonathan.rajotte-<wbr>julien@efficios.com</a>&gt;&gt; wrote:<br=
>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0On Tue, Sep 19, 2017 at 03:53:27PM +0800, liguang l=
i wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 Hi,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 On Mon, Sep 18, 2017 at 11:18 PM,=
 Jonathan Rajotte-Julien<br>
</span><span class=3D"">&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 &lt;[1]<a=
 href=3D"mailto:jonathan.rajotte-julien@efficios.com">jonathan.rajotte-juli=
en@<wbr>efficios.com</a> &lt;mailto:<a href=3D"mailto:jonathan.rajotte-juli=
en@efficios.com">jonathan.rajotte-<wbr>julien@efficios.com</a>&gt;&gt; wrot=
e:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 Hi,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 On Mon, Sep 18, 2017 at 11=
:32:07AM +0800, liguang li wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 Hi,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 Create a=
 session in live-reading mode, run a application which<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 having very<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 high eve=
nt throughput, then prints<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 the even=
ts with babeltrace. We found the live trace viewer are<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 viewing<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 events a=
 few seconds ago, and as time<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 Could you provide us the v=
ersion used for babeltrace, lttng-tools and<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 lttng-ust?<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Babeltrace: 1.5.1<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Update to babeltrace 1.5.3.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Lttng-tools: 2.8.6<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Update to lttng-tools 2.8.8<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Lttng-ust: 2.8.2<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 goes on,=
 the delay will be bigger and bigger.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 A similar issues was obser=
ved a couple months ago, which implicated<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 multiple delayed ack<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 problems during communicat=
ion between lttng-relayd and babeltrace.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 The following fixes were m=
erged:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 [1]<br>
</span>&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 [2]<a href=3D"https=
://github.com/lttng/lttng-tools/commit/b6025e9476332b75eb8184345c3eb3e92478=
0088" rel=3D"noreferrer" target=3D"_blank">https://github.com/lttng/<wbr>lt=
tng-tools/commit/<wbr>b6025e9476332b75eb8184345c3eb3<wbr>e924780088</a> &lt=
;<a href=3D"https://github.com/lttng/lttng-tools/commit/b6025e9476332b75eb8=
184345c3eb3e924780088" rel=3D"noreferrer" target=3D"_blank">https://github.=
com/lttng/<wbr>lttng-tools/commit/<wbr>b6025e9476332b75eb8184345c3eb3<wbr>e=
924780088</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 [2]<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 [3]<a href=3D"https://gith=
ub.com/efficios/babeltrace/commit/de417d04317ca3bc30f59685a9d19de670e4b11d"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/<wbr>efficios/babe=
ltrace/commit/<wbr>de417d04317ca3bc30f59685a9d19d<wbr>e670e4b11d</a> &lt;<a=
 href=3D"https://github.com/efficios/babeltrace/commit/de417d04317ca3bc30f5=
9685a9d19de670e4b11d" rel=3D"noreferrer" target=3D"_blank">https://github.c=
om/efficios/<wbr>babeltrace/commit/<wbr>de417d04317ca3bc30f59685a9d19d<wbr>=
e670e4b11d</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 [3]<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 [4]<a href=3D"https://gith=
ub.com/efficios/babeltrace/commit/4594dbd8f7c2af2446a3e310bee74ba4a2e9d648"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/<wbr>efficios/babe=
ltrace/commit/<wbr>4594dbd8f7c2af2446a3e310bee74b<wbr>a4a2e9d648</a> &lt;<a=
 href=3D"https://github.com/efficios/babeltrace/commit/4594dbd8f7c2af2446a3=
e310bee74ba4a2e9d648" rel=3D"noreferrer" target=3D"_blank">https://github.c=
om/efficios/<wbr>babeltrace/commit/<wbr>4594dbd8f7c2af2446a3e310bee74b<wbr>=
a4a2e9d648</a>&gt;<br>
<span class=3D"">&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 In the event that you are =
already using an updated version of babeltrace<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 and<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 lttng-tools, it would be p=
ertinent to provide us with a simple<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 reproducer so we<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 can assess the issue.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0The version you are using does not include the ment=
ioned fixes. Please update<br>
&gt;=C2=A0 =C2=A0 =C2=A0and redo your experiment.<br>
&gt;<br>
&gt;<br>
&gt; Test this issue in the version you have listed, the issue still exists=
.<br>
<br>
</span>Given that previous versions had a major timing problem there I woul=
d expect to have some improvement.<br>
<br>
In that case, we will need a lot more information on your benchmarking stra=
tegy.<br>
We will need a simple reproducer, your benchmark code (r,gnuplot etc.), you=
r overall methodology<br>
to be able to reproduce the issue locally. Otherwise, it will be very hard<=
br>
to come to any conclusion.<br>
<span class=3D""><br></span></blockquote><div><br></div><div>Sorry, we can =
not provide the detailed information about the benchmark code due to the co=
mpany regulations.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
><span class=3D"">
&gt; =C2=A0<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Cheers<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Steps:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0lttng create session --live=
 -U net://*<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0lttng enable-channel -s ses=
sion -u ch1<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0lttng enable-event -s sessi=
on -c ch1 -u -a<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0lttng start<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Run a high event throughput=
 application, which is multithreaded<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 application&gt;<br>
&gt;<br>
</span><span class=3D"">&gt; In the multithreaded application, each tracepo=
int will have the wall<br>
&gt; time of the system,then we can easily reproduce this issue through<br>
&gt; comparing the time of recorded event and the system wall time.<br>
&gt; =C2=A0<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0babeltrace -i lttng-live ne=
t://*<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0After a while, we found the=
 timestamp of the event in the babeltrace is<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 different with the time in host<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0which run the application. =
And the delay will be bigger and bigger with<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 time goes.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 Cheers<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 I checke=
d the source code, found Babeltrace in live-reading mode<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 will read<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 the reco=
rded events in the CTF<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 files, a=
nd then parse and print it in a single thread. The process<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 is a<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 little s=
low, do you have any ideas to<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 improve =
the process.<br>
&gt;<br>
&gt;<br>
&gt; From my understanding of the source code, the process of parse and<br>
&gt; print event will consume a lot of time. For example, the multithreaded=
<br>
&gt; application will consume 3 CPUs, in a specified time,3 subbuffers will=
<br>
&gt; be filled and sent to lttng-relayd daemon, recorded into the CTF files=
.<br>
&gt; If in the specified time, babeltrace only handled 2 subbuffers&#39; ev=
ent,<br>
&gt; thenthe issue will happens.<br>
<br>
</span>Did you perform a bisection for where the delay come from? Reception=
 of packet? formatting of event?<br>
What is the throughput of the application?<br>
How many tracepoint definition?<br>
Does babeltrace catch up if a quiescent period is given?<br></blockquote><d=
iv><br></div><div>I think so.<br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
Could you provide us with statistics, timing data, etc.?<br></blockquote><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
What type of delay are we talking about?<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br></font></span></blockquo=
te><br></div><div class=3D"gmail_quote">For example, the system wall time i=
s 5:18 PM now, but the Babeltrace is still printing events which</div><div =
class=3D"gmail_quote"> have time 5:10 PM. Then stop running the application=
, the Babeltrace still need some times to print</div><div class=3D"gmail_qu=
ote"> the recorded events.</div><div class=3D"gmail_quote"><br></div><div c=
lass=3D"gmail_quote"> I think the root cause is that the parsing and printi=
ng process is a bit slow. So i want to know if there</div><div class=3D"gma=
il_quote"> are any method to improve the performance of this process. <br><=
/div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Regard=
s,</div><div class=3D"gmail_quote">Liguang</div><div class=3D"gmail_quote">=
<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span c=
lass=3D"HOEnZb"><font color=3D"#888888">
--<br>
Jonathan R. Julien<br>
Efficios<br>
</font></span></blockquote></div><br></div></div></div>

--94eb2c070154e691ca0559afccbb--

--===============2298720117342283576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2298720117342283576==--
