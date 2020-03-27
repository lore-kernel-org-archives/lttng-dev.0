From: Valentin Grigorev via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: LTTng user-space callstacks
Date: Fri, 27 Mar 2020 16:44:19 +0300
Message-ID: <CABhb4usOZOFUwQL85c5wW5K5VSMXx+CVwFmBb_ia+wJ1TJsxVw@mail.gmail.com>
References: <CABhb4uuE2QD8Asejaa+mjLPEVQAZrCxU6pwLp=QFqb2N3vD9nw@mail.gmail.com>
 <2022773652.13655.1585251677207.JavaMail.zimbra@efficios.com>
 <1834419.usQuhbGJ8B@agathebauer>
Reply-To: Valentin Grigorev <valentin.grigorev@jetbrains.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6153713742388908343=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 by lists.lttng.org (Postfix) with ESMTPS id 48pjl84ZSwz1W27
 for <lttng-dev@lists.lttng.org>; Fri, 27 Mar 2020 09:44:36 -0400 (EDT)
Received: by mail-oi1-x243.google.com with SMTP id p125so8746369oif.10
 for <lttng-dev@lists.lttng.org>; Fri, 27 Mar 2020 06:44:36 -0700 (PDT)
In-Reply-To: <1834419.usQuhbGJ8B@agathebauer>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============6153713742388908343==
Content-Type: multipart/alternative; boundary="0000000000004cfc4d05a1d64d0c"

--0000000000004cfc4d05a1d64d0c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yeah, as far as I know, perf [1] is successfully using libunwind to provide
callstacks. Probably, LTTng team should think about it too, if there are no
serious obstacles.

[1]: https://perf.wiki.kernel.org/index.php/Main_Page


Best regards,
Valentin Grigorev


On Thu, Mar 26, 2020 at 11:53 PM Milian Wolff <milian.wolff@kdab.com> wrote=
:

> On Donnerstag, 26. M=C3=A4rz 2020 20:41:17 CET Mathieu Desnoyers via lttn=
g-dev
> wrote:
> > ----- On Mar 26, 2020, at 1:39 PM, lttng-dev <lttng-dev@lists.lttng.org=
>
>
> wrote:
> > > Hello!
> > >
> > > Currently, callstack collection in LTTng is only available for
> > > kernel-space
> > > events with context fields callstack-kernel and callstack-user .
> > >
> > > Is it expected that callstack collection for LTTng-UST will be added
> too?
> > > And if it is expected, then how soon?
> >
> > Hi Valentin,
> >
> > It is something that would be interesting and useful, but a lot of work
> > would be needed to have stack-walking this is fast enough and reentrant
> wrt
> > signal handlers. Unfortunately, the backtrace(3) functions do not meet
> > those requirements.
> >
> > Also, for gathering user-space callstacks from the kernel tracer, it on=
ly
> > works if all user-space is compiled with frame pointers. This is also a
> > limitation that would require a lot of work to overcome neatly.
> >
> > None of those features are currently on any roadmap due to lack of
> customers
> > showing interest in getting this done.
>
> libunwind [1] should meet the requirements you need. It is high
> performance
> thanks to extensive caching, signal safe and does not rely on frame
> pointers.
>
> [1]: https://github.com/libunwind/libunwind
>
> --
> Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
> KDAB (Deutschland) GmbH, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt, C++ and OpenGL Experts

--0000000000004cfc4d05a1d64d0c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Yeah, as far=C2=A0as I know, perf [1=
] is successfully using libunwind to provide callstacks. Probably, LTTng te=
am should think about it too, if there are no serious obstacles.</div><div>=
<br></div><div>[1]:=C2=A0<a href=3D"https://perf.wiki.kernel.org/index.php/=
Main_Page" target=3D"_blank">https://perf.wiki.kernel.org/index.php/Main_Pa=
ge</a></div><div dir=3D"ltr"><br></div><div dir=3D"ltr"><br clear=3D"all"><=
div><div dir=3D"ltr"><div>Best regards,</div><div>Valentin Grigorev</div></=
div></div><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Mar 26, 2020 at 11:53 PM Milian Wolff &lt;<a href=
=3D"mailto:milian.wolff@kdab.com" target=3D"_blank">milian.wolff@kdab.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 Donnerstag, 26. M=C3=A4rz 2020 20:41:17 CET Mathieu Desnoyers via lttng-de=
v <br>
wrote:<br>
&gt; ----- On Mar 26, 2020, at 1:39 PM, lttng-dev &lt;<a href=3D"mailto:ltt=
ng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a>&gt;=
 <br>
wrote:<br>
&gt; &gt; Hello!<br>
&gt; &gt; <br>
&gt; &gt; Currently, callstack collection in LTTng is only available for<br=
>
&gt; &gt; kernel-space<br>
&gt; &gt; events with context fields callstack-kernel and callstack-user .<=
br>
&gt; &gt; <br>
&gt; &gt; Is it expected that callstack collection for LTTng-UST will be ad=
ded too?<br>
&gt; &gt; And if it is expected, then how soon?<br>
&gt; <br>
&gt; Hi Valentin,<br>
&gt; <br>
&gt; It is something that would be interesting and useful, but a lot of wor=
k<br>
&gt; would be needed to have stack-walking this is fast enough and reentran=
t wrt<br>
&gt; signal handlers. Unfortunately, the backtrace(3) functions do not meet=
<br>
&gt; those requirements.<br>
&gt; <br>
&gt; Also, for gathering user-space callstacks from the kernel tracer, it o=
nly<br>
&gt; works if all user-space is compiled with frame pointers. This is also =
a<br>
&gt; limitation that would require a lot of work to overcome neatly.<br>
&gt; <br>
&gt; None of those features are currently on any roadmap due to lack of cus=
tomers<br>
&gt; showing interest in getting this done.<br>
<br>
libunwind [1] should meet the requirements you need. It is high performance=
 <br>
thanks to extensive caching, signal safe and does not rely on frame pointer=
s.<br>
<br>
[1]: <a href=3D"https://github.com/libunwind/libunwind" rel=3D"noreferrer" =
target=3D"_blank">https://github.com/libunwind/libunwind</a><br>
<br>
-- <br>
Milian Wolff | <a href=3D"mailto:milian.wolff@kdab.com" target=3D"_blank">m=
ilian.wolff@kdab.com</a> | Senior Software Engineer<br>
KDAB (Deutschland) GmbH, a KDAB Group company<br>
Tel: +49-30-521325470<br>
KDAB - The Qt, C++ and OpenGL Experts</blockquote></div></div></div>

--0000000000004cfc4d05a1d64d0c--

--===============6153713742388908343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6153713742388908343==--
