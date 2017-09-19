From: liguang li <liguang.lee6@gmail.com>
Subject: Re: Babeltrace performance issue in live-reading mode
Date: Tue, 19 Sep 2017 15:53:27 +0800
Message-ID: <CAMYaK0TGprotjj0v-HayqHAaKpJaTXgqqYh55CK9JmOKBO-U8A__10809.2805756771$1505831440$gmane$org@mail.gmail.com>
References: <CAMYaK0TVYEgM_qxCExiFn6BcgZ58+KXKqx72h_0Gv4g2JN40Yg@mail.gmail.com>
 <20170918151857.afnn5n6ntzhyzfnw@psrcode-TP-X230>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3412829518447775327=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt0-x22e.google.com (mail-qt0-x22e.google.com
 [IPv6:2607:f8b0:400d:c0d::22e])
 by lists.lttng.org (Postfix) with ESMTPS id 3xxFVd3spSzC83
 for <lttng-dev@lists.lttng.org>; Tue, 19 Sep 2017 07:53:28 +0000 (UTC)
Received: by mail-qt0-x22e.google.com with SMTP id s18so2908773qta.3
 for <lttng-dev@lists.lttng.org>; Tue, 19 Sep 2017 00:53:28 -0700 (PDT)
In-Reply-To: <20170918151857.afnn5n6ntzhyzfnw@psrcode-TP-X230>
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

--===============3412829518447775327==
Content-Type: multipart/alternative; boundary="94eb2c062a7c97633c0559862792"

--94eb2c062a7c97633c0559862792
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, Sep 18, 2017 at 11:18 PM, Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> Hi,
>
> On Mon, Sep 18, 2017 at 11:32:07AM +0800, liguang li wrote:
> >    Hi,
> >
> >    Create a session in live-reading mode, run a application which having
> very
> >    high event throughput, then prints
> >    the events with babeltrace. We found the live trace viewer are viewing
> >    events a few seconds ago, and as time
>
> Could you provide us the version used for babeltrace, lttng-tools and
> lttng-ust?
>

 Babeltrace: 1.5.1
 Lttng-tools: 2.8.6
 Lttng-ust: 2.8.2

>    goes on, the delay will be bigger and bigger.
>
> A similar issues was observed a couple months ago, which implicated
> multiple delayed ack
> problems during communication between lttng-relayd and babeltrace.
>
> The following fixes were merged:
>
> [1] https://github.com/lttng/lttng-tools/commit/
> b6025e9476332b75eb8184345c3eb3e924780088
> [2] https://github.com/efficios/babeltrace/commit/
> de417d04317ca3bc30f59685a9d19de670e4b11d
> [3] https://github.com/efficios/babeltrace/commit/
> 4594dbd8f7c2af2446a3e310bee74ba4a2e9d648
>
> In the event that you are already using an updated version of babeltrace
> and
> lttng-tools, it would be pertinent to provide us with a simple reproducer
> so we
> can assess the issue.
>
>
 Steps:

 lttng create session --live -U net://*
 lttng enable-channel -s session -u ch1
 lttng enable-event -s session -c ch1 -u -a
 lttng start

 Run a high event throughput application, which is multithreaded
application.

 babeltrace -i lttng-live net://*

 After a while, we found the timestamp of the event in the babeltrace is
different with the time in host
 which run the application. And the delay will be bigger and bigger with
time goes.


> Cheers
>
> >    I checked the source code, found Babeltrace in live-reading mode will
> read
> >    the recorded events in the CTF
> >    files, and then parse and print it in a single thread. The process is
> a
> >    little slow, do you have any ideas to
> >    improve the process.
> >    Thanks,
> >    Liguang
>
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Jonathan Rajotte-Julien
> EfficiOS
>

--94eb2c062a7c97633c0559862792
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div><div class=3D"gmail_extra"><br><div class=3D"g=
mail_quote">On Mon, Sep 18, 2017 at 11:18 PM, Jonathan Rajotte-Julien <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:jonathan.rajotte-julien@efficios.com" ta=
rget=3D"_blank">jonathan.rajotte-julien@efficios.com</a>&gt;</span> wrote:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On Mon, Sep 18, 2017 at 11:32:07AM +0800, liguang li wrote:<br>
&gt;=C2=A0 =C2=A0 Hi,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 Create a session in live-reading mode, run a application =
which having very<br>
&gt;=C2=A0 =C2=A0 high event throughput, then prints<br>
&gt;=C2=A0 =C2=A0 the events with babeltrace. We found the live trace viewe=
r are viewing<br>
&gt;=C2=A0 =C2=A0 events a few seconds ago, and as time<br>
<br>
</span>Could you provide us the version used for babeltrace, lttng-tools an=
d lttng-ust?<span class=3D""><br></span></blockquote><div><br></div><div>=
=C2=A0Babeltrace: 1.5.1</div><div>=C2=A0Lttng-tools: 2.8.6</div><div>=C2=A0=
Lttng-ust: 2.8.2</div><div><br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span c=
lass=3D"">
&gt;=C2=A0 =C2=A0 goes on, the delay will be bigger and bigger.<br>
<br>
</span>A similar issues was observed a couple months ago, which implicated =
multiple delayed ack<br>
problems during communication between lttng-relayd and babeltrace.<br>
<br>
The following fixes were merged:<br>
<br>
[1] <a href=3D"https://github.com/lttng/lttng-tools/commit/b6025e9476332b75=
eb8184345c3eb3e924780088" rel=3D"noreferrer" target=3D"_blank">https://gith=
ub.com/lttng/<wbr>lttng-tools/commit/<wbr>b6025e9476332b75eb8184345c3eb3<wb=
r>e924780088</a><br>
[2] <a href=3D"https://github.com/efficios/babeltrace/commit/de417d04317ca3=
bc30f59685a9d19de670e4b11d" rel=3D"noreferrer" target=3D"_blank">https://gi=
thub.com/efficios/<wbr>babeltrace/commit/<wbr>de417d04317ca3bc30f59685a9d19=
d<wbr>e670e4b11d</a><br>
[3] <a href=3D"https://github.com/efficios/babeltrace/commit/4594dbd8f7c2af=
2446a3e310bee74ba4a2e9d648" rel=3D"noreferrer" target=3D"_blank">https://gi=
thub.com/efficios/<wbr>babeltrace/commit/<wbr>4594dbd8f7c2af2446a3e310bee74=
b<wbr>a4a2e9d648</a><br>
<br>
In the event that you are already using an updated version of babeltrace an=
d<br>
lttng-tools, it would be pertinent to provide us with a simple reproducer s=
o we<br>
can assess the issue.<br>
<br></blockquote><div>=C2=A0</div><div>=C2=A0Steps:</div><div><br></div><di=
v>=C2=A0lttng create session --live -U net://*</div><div>=C2=A0lttng enable=
-channel -s session -u ch1</div><div>=C2=A0lttng enable-event -s session -c=
 ch1 -u -a</div><div>=C2=A0lttng start</div><div>=C2=A0</div><div>=C2=A0Run=
 a high event throughput application, which is multithreaded application.</=
div><div><br></div><div>=C2=A0babeltrace -i lttng-live net://*</div><div>=
=C2=A0</div><div>=C2=A0After a while, we found the timestamp of the event i=
n the babeltrace is different with the time in host</div><div>=C2=A0which r=
un the application. And the delay will be bigger and bigger with time goes.=
<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Cheers<br>
<span class=3D""><br>
&gt;=C2=A0 =C2=A0 I checked the source code, found Babeltrace in live-readi=
ng mode will read<br>
&gt;=C2=A0 =C2=A0 the recorded events in the CTF<br>
&gt;=C2=A0 =C2=A0 files, and then parse and print it in a single thread. Th=
e process is a<br>
&gt;=C2=A0 =C2=A0 little slow, do you have any ideas to<br>
&gt;=C2=A0 =C2=A0 improve the process.<br>
&gt;=C2=A0 =C2=A0 Thanks,<br>
&gt;=C2=A0 =C2=A0 Liguang<br>
<br>
</span>&gt; ______________________________<wbr>_________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-<wbr>bin/=
mailman/listinfo/lttng-dev</a><br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</font></span></blockquote></div><br></div></div></div>

--94eb2c062a7c97633c0559862792--

--===============3412829518447775327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3412829518447775327==--
