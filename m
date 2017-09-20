From: liguang li <liguang.lee6@gmail.com>
Subject: Re: Babeltrace performance issue in live-reading mode
Date: Wed, 20 Sep 2017 17:12:36 +0800
Message-ID: <CAMYaK0SQkdjs_gp+4fwBL1BH1oqEiqYnN6PXq-H-=ApMRbe-bg__32539.9668458433$1505917613$gmane$org@mail.gmail.com>
References: <CAMYaK0TVYEgM_qxCExiFn6BcgZ58+KXKqx72h_0Gv4g2JN40Yg@mail.gmail.com>
 <20170918151857.afnn5n6ntzhyzfnw@psrcode-TP-X230>
 <CAMYaK0TGprotjj0v-HayqHAaKpJaTXgqqYh55CK9JmOKBO-U8A@mail.gmail.com>
 <20170919145707.5wh3e23zet7jm3bc@psrcode-TP-X230>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7690801513370286940=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-x22a.google.com (mail-qk0-x22a.google.com
 [IPv6:2607:f8b0:400d:c09::22a])
 by lists.lttng.org (Postfix) with ESMTPS id 3xxvCT5RnTzt46
 for <lttng-dev@lists.lttng.org>; Wed, 20 Sep 2017 09:12:37 +0000 (UTC)
Received: by mail-qk0-x22a.google.com with SMTP id b23so2088858qkg.1
 for <lttng-dev@lists.lttng.org>; Wed, 20 Sep 2017 02:12:37 -0700 (PDT)
In-Reply-To: <20170919145707.5wh3e23zet7jm3bc@psrcode-TP-X230>
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

--===============7690801513370286940==
Content-Type: multipart/alternative; boundary="001a1147409275958305599b60d1"

--001a1147409275958305599b60d1
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 19, 2017 at 10:57 PM, Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> On Tue, Sep 19, 2017 at 03:53:27PM +0800, liguang li wrote:
> >    Hi,
> >    On Mon, Sep 18, 2017 at 11:18 PM, Jonathan Rajotte-Julien
> >    <[1]jonathan.rajotte-julien@efficios.com> wrote:
> >
> >      Hi,
> >      On Mon, Sep 18, 2017 at 11:32:07AM +0800, liguang li wrote:
> >      >    Hi,
> >      >
> >      >    Create a session in live-reading mode, run a application which
> >      having very
> >      >    high event throughput, then prints
> >      >    the events with babeltrace. We found the live trace viewer are
> >      viewing
> >      >    events a few seconds ago, and as time
> >
> >      Could you provide us the version used for babeltrace, lttng-tools
> and
> >      lttng-ust?
> >
> >     Babeltrace: 1.5.1
>
> Update to babeltrace 1.5.3.
>
> >     Lttng-tools: 2.8.6
>
> Update to lttng-tools 2.8.8
>
> >     Lttng-ust: 2.8.2
> >
> >      >    goes on, the delay will be bigger and bigger.
> >
> >      A similar issues was observed a couple months ago, which implicated
> >      multiple delayed ack
> >      problems during communication between lttng-relayd and babeltrace.
> >
> >      The following fixes were merged:
> >
> >      [1]
> >      [2]https://github.com/lttng/lttng-tools/commit/
> b6025e9476332b75eb8184345c3eb3e924780088
> >      [2]
> >      [3]https://github.com/efficios/babeltrace/commit/
> de417d04317ca3bc30f59685a9d19de670e4b11d
> >      [3]
> >      [4]https://github.com/efficios/babeltrace/commit/
> 4594dbd8f7c2af2446a3e310bee74ba4a2e9d648
> >
> >      In the event that you are already using an updated version of
> babeltrace
> >      and
> >      lttng-tools, it would be pertinent to provide us with a simple
> >      reproducer so we
> >      can assess the issue.
>
> The version you are using does not include the mentioned fixes. Please
> update
> and redo your experiment.
>
>
Test this issue in the version you have listed, the issue still exists.


> Cheers
>
> >
> >
> >     Steps:
> >     lttng create session --live -U net://*
> >     lttng enable-channel -s session -u ch1
> >     lttng enable-event -s session -c ch1 -u -a
> >     lttng start
> >
> >     Run a high event throughput application, which is multithreaded
> >    application.
>

In the multithreaded application, each tracepoint will have the wall
time of the system,then we can easily reproduce this issue through
comparing the time of recorded event and the system wall time.


> >     babeltrace -i lttng-live net://*
> >
> >     After a while, we found the timestamp of the event in the babeltrace
> is
> >    different with the time in host
> >     which run the application. And the delay will be bigger and bigger
> with
> >    time goes.
> >
> >
> >      Cheers
> >      >    I checked the source code, found Babeltrace in live-reading
> mode
> >      will read
> >      >    the recorded events in the CTF
> >      >    files, and then parse and print it in a single thread. The
> process
> >      is a
> >      >    little slow, do you have any ideas to
> >      >    improve the process.
>

From my understanding of the source code, the process of parse and
print event will consume a lot of time. For example, the multithreaded
application will consume 3 CPUs, in a specified time,3 subbuffers will
be filled and sent to lttng-relayd daemon, recorded into the CTF files.
If in the specified time, babeltrace only handled 2 subbuffers' event,
thenthe issue will happens.


> >      >    Thanks,
> >      >    Liguang
> >
> >      > _______________________________________________
> >      > lttng-dev mailing list
> >      > [5]lttng-dev@lists.lttng.org
> >      > [6]https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
> >      --
> >      Jonathan Rajotte-Julien
> >      EfficiOS
> >
> > References
> >
> >    Visible links
> >    1. mailto:jonathan.rajotte-julien@efficios.com
> >    2. https://github.com/lttng/lttng-tools/commit/
> b6025e9476332b75eb8184345c3eb3e924780088
> >    3. https://github.com/efficios/babeltrace/commit/
> de417d04317ca3bc30f59685a9d19de670e4b11d
> >    4. https://github.com/efficios/babeltrace/commit/
> 4594dbd8f7c2af2446a3e310bee74ba4a2e9d648
> >    5. mailto:lttng-dev@lists.lttng.org
> >    6. https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Jonathan Rajotte-Julien
> EfficiOS
>

--001a1147409275958305599b60d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Sep 19, 2017 at 10:57 PM, Jonathan Rajotte-Julien <span dir=3D"=
ltr">&lt;<a href=3D"mailto:jonathan.rajotte-julien@efficios.com" target=3D"=
_blank">jonathan.rajotte-julien@efficios.com</a>&gt;</span> wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex"><span class=3D"">On Tue, Sep 19, 2017 at 03:53:27=
PM +0800, liguang li wrote:<br>
&gt;=C2=A0 =C2=A0 Hi,<br>
</span><span class=3D"">&gt;=C2=A0 =C2=A0 On Mon, Sep 18, 2017 at 11:18 PM,=
 Jonathan Rajotte-Julien<br>
</span><span class=3D"">&gt;=C2=A0 =C2=A0 &lt;[1]<a href=3D"mailto:jonathan=
.rajotte-julien@efficios.com">jonathan.rajotte-julien@<wbr>efficios.com</a>=
&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Hi,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 On Mon, Sep 18, 2017 at 11:32:07AM +0800, liguang =
li wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 Hi,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 Create a session in live-reading=
 mode, run a application which<br>
&gt;=C2=A0 =C2=A0 =C2=A0 having very<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 high event throughput, then prin=
ts<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 the events with babeltrace. We f=
ound the live trace viewer are<br>
&gt;=C2=A0 =C2=A0 =C2=A0 viewing<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 events a few seconds ago, and as=
 time<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Could you provide us the version used for babeltra=
ce, lttng-tools and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 lttng-ust?<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Babeltrace: 1.5.1<br>
<br>
</span>Update to babeltrace 1.5.3.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0Lttng-tools: 2.8.6<br>
<br>
Update to lttng-tools 2.8.8<br>
<span class=3D""><br>
&gt;=C2=A0 =C2=A0 =C2=A0Lttng-ust: 2.8.2<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 goes on, the delay will be bigge=
r and bigger.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 A similar issues was observed a couple months ago,=
 which implicated<br>
&gt;=C2=A0 =C2=A0 =C2=A0 multiple delayed ack<br>
&gt;=C2=A0 =C2=A0 =C2=A0 problems during communication between lttng-relayd=
 and babeltrace.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 The following fixes were merged:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 [1]<br>
</span>&gt;=C2=A0 =C2=A0 =C2=A0 [2]<a href=3D"https://github.com/lttng/lttn=
g-tools/commit/b6025e9476332b75eb8184345c3eb3e924780088" rel=3D"noreferrer"=
 target=3D"_blank">https://github.com/lttng/<wbr>lttng-tools/commit/<wbr>b6=
025e9476332b75eb8184345c3eb3<wbr>e924780088</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 [2]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 [3]<a href=3D"https://github.com/efficios/babeltra=
ce/commit/de417d04317ca3bc30f59685a9d19de670e4b11d" rel=3D"noreferrer" targ=
et=3D"_blank">https://github.com/<wbr>efficios/babeltrace/commit/<wbr>de417=
d04317ca3bc30f59685a9d19d<wbr>e670e4b11d</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 [3]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 [4]<a href=3D"https://github.com/efficios/babeltra=
ce/commit/4594dbd8f7c2af2446a3e310bee74ba4a2e9d648" rel=3D"noreferrer" targ=
et=3D"_blank">https://github.com/<wbr>efficios/babeltrace/commit/<wbr>4594d=
bd8f7c2af2446a3e310bee74b<wbr>a4a2e9d648</a><br>
<span class=3D"">&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 In the event that you are already using an updated=
 version of babeltrace<br>
&gt;=C2=A0 =C2=A0 =C2=A0 and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 lttng-tools, it would be pertinent to provide us w=
ith a simple<br>
&gt;=C2=A0 =C2=A0 =C2=A0 reproducer so we<br>
&gt;=C2=A0 =C2=A0 =C2=A0 can assess the issue.<br>
<br>
</span>The version you are using does not include the mentioned fixes. Plea=
se update<br>
and redo your experiment.<br>
<br></blockquote><div><br></div><div>Test this issue in the version you hav=
e listed, the issue still exists.<br></div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">
Cheers<br>
<span class=3D""><br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0Steps:<br>
&gt;=C2=A0 =C2=A0 =C2=A0lttng create session --live -U net://*<br>
&gt;=C2=A0 =C2=A0 =C2=A0lttng enable-channel -s session -u ch1<br>
&gt;=C2=A0 =C2=A0 =C2=A0lttng enable-event -s session -c ch1 -u -a<br>
&gt;=C2=A0 =C2=A0 =C2=A0lttng start<br>
&gt;=C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0Run a high event throughput application, which is m=
ultithreaded<br>
&gt;=C2=A0 =C2=A0 application.<br></span></blockquote><div><br></div><div>I=
n the multithreaded application, each tracepoint will have the wall <br></d=
iv><div>time of the system,then we can easily reproduce this issue through<=
/div><div> comparing the time of recorded event and the system wall time.<b=
r></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">
&gt;=C2=A0 =C2=A0 =C2=A0babeltrace -i lttng-live net://*<br>
&gt;=C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0After a while, we found the timestamp of the event =
in the babeltrace is<br>
&gt;=C2=A0 =C2=A0 different with the time in host<br>
&gt;=C2=A0 =C2=A0 =C2=A0which run the application. And the delay will be bi=
gger and bigger with<br>
&gt;=C2=A0 =C2=A0 time goes.<br>
&gt;=C2=A0 =C2=A0 =C2=A0<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Cheers<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 I checked the source code, found=
 Babeltrace in live-reading mode<br>
&gt;=C2=A0 =C2=A0 =C2=A0 will read<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 the recorded events in the CTF<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 files, and then parse and print =
it in a single thread. The process<br>
&gt;=C2=A0 =C2=A0 =C2=A0 is a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 little slow, do you have any ide=
as to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 improve the process.<br></span><=
/blockquote><div><br></div><div>From my understanding of the source code, t=
he process of parse and <br></div><div>print event will consume a lot of ti=
me. For example, the multithreaded</div><div> application will consume 3 CP=
Us, in a specified time,3 subbuffers will</div><div> be filled and sent to =
lttng-relayd daemon, recorded into the CTF files. <br></div><div>If in the =
specified time, babeltrace only handled 2 subbuffers&#39; event,</div><div>=
 thenthe issue will happens.<br></div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex"><span class=3D"">
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 Thanks,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 Liguang<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ______________________________<wbr>__________=
_______<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; lttng-dev mailing list<br>
</span>&gt;=C2=A0 =C2=A0 =C2=A0 &gt; [5]<a href=3D"mailto:lttng-dev@lists.l=
ttng.org">lttng-dev@lists.lttng.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; [6]<a href=3D"https://lists.lttng.org/cgi-bin=
/mailman/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://l=
ists.lttng.org/<wbr>cgi-bin/mailman/listinfo/<wbr>lttng-dev</a><br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 --<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Jonathan Rajotte-Julien<br>
&gt;=C2=A0 =C2=A0 =C2=A0 EfficiOS<br>
&gt;<br>
&gt; References<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 Visible links<br>
&gt;=C2=A0 =C2=A0 1. mailto:<a href=3D"mailto:jonathan.rajotte-julien@effic=
ios.com">jonathan.rajotte-<wbr>julien@efficios.com</a><br>
&gt;=C2=A0 =C2=A0 2. <a href=3D"https://github.com/lttng/lttng-tools/commit=
/b6025e9476332b75eb8184345c3eb3e924780088" rel=3D"noreferrer" target=3D"_bl=
ank">https://github.com/lttng/<wbr>lttng-tools/commit/<wbr>b6025e9476332b75=
eb8184345c3eb3<wbr>e924780088</a><br>
&gt;=C2=A0 =C2=A0 3. <a href=3D"https://github.com/efficios/babeltrace/comm=
it/de417d04317ca3bc30f59685a9d19de670e4b11d" rel=3D"noreferrer" target=3D"_=
blank">https://github.com/efficios/<wbr>babeltrace/commit/<wbr>de417d04317c=
a3bc30f59685a9d19d<wbr>e670e4b11d</a><br>
&gt;=C2=A0 =C2=A0 4. <a href=3D"https://github.com/efficios/babeltrace/comm=
it/4594dbd8f7c2af2446a3e310bee74ba4a2e9d648" rel=3D"noreferrer" target=3D"_=
blank">https://github.com/efficios/<wbr>babeltrace/commit/<wbr>4594dbd8f7c2=
af2446a3e310bee74b<wbr>a4a2e9d648</a><br>
&gt;=C2=A0 =C2=A0 5. mailto:<a href=3D"mailto:lttng-dev@lists.lttng.org">lt=
tng-dev@lists.lttng.<wbr>org</a><br>
&gt;=C2=A0 =C2=A0 6. <a href=3D"https://lists.lttng.org/cgi-bin/mailman/lis=
tinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.o=
rg/cgi-<wbr>bin/mailman/listinfo/lttng-dev</a><br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</font></span></blockquote></div><br></div></div>

--001a1147409275958305599b60d1--

--===============7690801513370286940==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7690801513370286940==--
