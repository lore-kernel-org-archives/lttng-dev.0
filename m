From: Alok Priyadarshi <alokpr@gmail.com>
Subject: Re: Adding thread timestamp to event context
Date: Thu, 25 Oct 2018 14:33:37 -0700
Message-ID: <CADwgpi-d6gDUB4djoBu_Va-STEGu-2mLm_xfLH=FXb0cd9_O8A__37722.8784062483$1540503113$gmane$org@mail.gmail.com>
References: <CADwgpi8Nvz4--8V16mU=GoQN5z9dUSvphuSQ3eOL3m0RVYxEeQ@mail.gmail.com>
 <125123961.343.1540472537413.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7036003976949172722=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw1-xc36.google.com (mail-yw1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by lists.lttng.org (Postfix) with ESMTPS id 42h0k72LkxzjyK
 for <lttng-dev@lists.lttng.org>; Thu, 25 Oct 2018 17:33:51 -0400 (EDT)
Received: by mail-yw1-xc36.google.com with SMTP id v199-v6so4241630ywg.1
 for <lttng-dev@lists.lttng.org>; Thu, 25 Oct 2018 14:33:50 -0700 (PDT)
In-Reply-To: <125123961.343.1540472537413.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============7036003976949172722==
Content-Type: multipart/alternative; boundary="000000000000c5bf2d0579145b41"

--000000000000c5bf2d0579145b41
Content-Type: text/plain; charset="UTF-8"

Thanks for your prompt response Mathieu. Can I expect this to happen
soonish?


On Thu, Oct 25, 2018 at 6:02 AM Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> ----- On Oct 24, 2018, at 11:05 PM, Alok Priyadarshi <alokpr@gmail.com>
> wrote:
>
> I am trying to add a thread timestamp to trace events. By thread timestamp
> I mean the value returned by clock_gettime(CLOCK_THREAD_CPUTIME_ID):
> https://linux.die.net/man/3/clock_gettime
>
> I could do this by creating custom events, but I am wondering if there is
> already a way to add this information to event context. I have tried using
> the following arguments to lttng-add-context, but none of them add any
> additional information:
> perf:cpu:cpu-cycles
> perf:cpu:cycles
> perf:thread:cpu-cycles
> perf:thread:cycles
>
> Note that I have only enabled userspace events. I use the following
> sequence of commands to capture trace:
> lttng create
> lttng enable-event --userspace --all
> lttng add-context --userspace -t vpid -t vtid -t perf:thread:cycles
> lttng start
> lttng stop
>
> We would need to extend lttng-ust implementation and lttng-tools to add
> those
> additional contexts. It would make sense to add these.
>
> Thanks,
>
> Mathieu
>
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--000000000000c5bf2d0579145b41
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for your prompt response Mathieu. Can I expect this=
 to happen soonish?<div><br></div></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr">On Thu, Oct 25, 2018 at 6:02 AM Mathieu Desnoyers &lt;<a href=
=3D"mailto:mathieu.desnoyers@efficios.com">mathieu.desnoyers@efficios.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><div style=3D"fo=
nt-family:arial,helvetica,sans-serif;font-size:12pt;color:#000000"><div><sp=
an id=3D"m_236129768240517735zwchr">----- On Oct 24, 2018, at 11:05 PM, Alo=
k Priyadarshi &lt;<a href=3D"mailto:alokpr@gmail.com" target=3D"_blank">alo=
kpr@gmail.com</a>&gt; wrote:<br></span></div></div></div><div><div style=3D=
"font-family:arial,helvetica,sans-serif;font-size:12pt;color:#000000"><div>=
<blockquote style=3D"border-left:2px solid #1010ff;margin-left:5px;padding-=
left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:no=
ne;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr">=
I am trying to add a thread timestamp to trace events. By thread timestamp =
I mean the value returned by=C2=A0clock_gettime(CLOCK_THREAD_CPUTIME_ID):<d=
iv><a href=3D"https://linux.die.net/man/3/clock_gettime" target=3D"_blank">=
https://linux.die.net/man/3/clock_gettime</a><br></div><br><div>I could do =
this by creating custom events, but I am wondering if there is already a wa=
y to add this information to event context. I have tried using the followin=
g arguments to lttng-add-context, but none of them add any additional infor=
mation:</div><div><div>perf:cpu:cpu-cycles</div><div>perf:cpu:cycles</div><=
/div><div><div>perf:thread:cpu-cycles</div><div>perf:thread:cycles</div></d=
iv><br><div>Note that I have only enabled userspace events. I use the follo=
wing sequence of commands to capture trace:</div><div><div>lttng create</di=
v><div>lttng enable-event --userspace --all</div><div>lttng add-context --u=
serspace -t vpid -t vtid -t perf:thread:cycles</div><div>lttng start</div><=
div>lttng stop</div></div></div></blockquote></div></div></div><div><div st=
yle=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;color:#000000"=
><div><div>We would need to extend lttng-ust implementation and lttng-tools=
 to add those<br></div><div>additional contexts. It would make sense to add=
 these.<br></div><div><br></div><div>Thanks,<br></div><div><br></div><div>M=
athieu<br></div><div><br></div><div><br></div><blockquote style=3D"border-l=
eft:2px solid #1010ff;margin-left:5px;padding-left:5px;color:#000;font-weig=
ht:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Aria=
l,sans-serif;font-size:12pt"><div dir=3D"ltr"><br></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-=
dev@lists.lttng.org</a><br><a href=3D"https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev" target=3D"_blank">https://lists.lttng.org/cgi-bin/ma=
ilman/listinfo/lttng-dev</a><br></blockquote></div></div></div><div><div st=
yle=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;color:#000000"=
><div><br></div><div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<b=
r><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios=
.com</a></div></div></div></blockquote></div>

--000000000000c5bf2d0579145b41--

--===============7036003976949172722==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7036003976949172722==--
