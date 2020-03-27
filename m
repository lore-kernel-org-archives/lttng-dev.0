From: Valentin Grigorev via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: LTTng user-space callstacks
Date: Fri, 27 Mar 2020 18:05:11 +0300
Message-ID: <CABhb4usXJ+ks30tQa5ozOhsBJ1ZYLts2AQXr0g2Npw0g_pms-Q@mail.gmail.com>
References: <CABhb4uuE2QD8Asejaa+mjLPEVQAZrCxU6pwLp=QFqb2N3vD9nw@mail.gmail.com>
 <2022773652.13655.1585251677207.JavaMail.zimbra@efficios.com>
 <1834419.usQuhbGJ8B@agathebauer>
 <CABhb4usOZOFUwQL85c5wW5K5VSMXx+CVwFmBb_ia+wJ1TJsxVw@mail.gmail.com>
 <570185028.14544.1585317308324.JavaMail.zimbra@efficios.com>
Reply-To: Valentin Grigorev <valentin.grigorev@jetbrains.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1532427371160882968=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by lists.lttng.org (Postfix) with ESMTPS id 48plXS6CTLz1WRD
 for <lttng-dev@lists.lttng.org>; Fri, 27 Mar 2020 11:05:28 -0400 (EDT)
Received: by mail-ot1-x333.google.com with SMTP id z5so9743510oth.9
 for <lttng-dev@lists.lttng.org>; Fri, 27 Mar 2020 08:05:28 -0700 (PDT)
In-Reply-To: <570185028.14544.1585317308324.JavaMail.zimbra@efficios.com>
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

--===============1532427371160882968==
Content-Type: multipart/alternative; boundary="00000000000080287c05a1d76e86"

--00000000000080287c05a1d76e86
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hmm, I don't know unfortunately, it should be checked

Best regards,
Valentin Grigorev


On Fri, Mar 27, 2020 at 4:55 PM Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> Last time I checked, the main issue with perf's handling of cases that
> lack frame pointers
> is that they grab a ~2-4kB worth of stack data into the trace, and then
> post-process it
> with libunwind. This might be OK for sampling use-cases, but is not
> something I consider
> appropriate for tracing due to considerably increased use of tracing
> throughput.
>
> Has the situation changed on the perf side ?
>
> Thanks,
>
> Mathieu
>
> ----- On Mar 27, 2020, at 9:44 AM, Valentin Grigorev <
> valentin.grigorev@jetbrains.com> wrote:
>
> Yeah, as far as I know, perf [1] is successfully using libunwind to
> provide callstacks. Probably, LTTng team should think about it too, if
> there are no serious obstacles.
>
> [1]: https://perf.wiki.kernel.org/index.php/Main_Page
>
>
> Best regards,
> Valentin Grigorev
>
>
> On Thu, Mar 26, 2020 at 11:53 PM Milian Wolff <milian.wolff@kdab.com>
> wrote:
>
>> On Donnerstag, 26. M=C3=A4rz 2020 20:41:17 CET Mathieu Desnoyers via ltt=
ng-dev
>> wrote:
>> > ----- On Mar 26, 2020, at 1:39 PM, lttng-dev <lttng-dev@lists.lttng.or=
g>
>>
>> wrote:
>> > > Hello!
>> > >
>> > > Currently, callstack collection in LTTng is only available for
>> > > kernel-space
>> > > events with context fields callstack-kernel and callstack-user .
>> > >
>> > > Is it expected that callstack collection for LTTng-UST will be added
>> too?
>> > > And if it is expected, then how soon?
>> >
>> > Hi Valentin,
>> >
>> > It is something that would be interesting and useful, but a lot of wor=
k
>> > would be needed to have stack-walking this is fast enough and reentran=
t
>> wrt
>> > signal handlers. Unfortunately, the backtrace(3) functions do not meet
>> > those requirements.
>> >
>> > Also, for gathering user-space callstacks from the kernel tracer, it
>> only
>> > works if all user-space is compiled with frame pointers. This is also =
a
>> > limitation that would require a lot of work to overcome neatly.
>> >
>> > None of those features are currently on any roadmap due to lack of
>> customers
>> > showing interest in getting this done.
>>
>> libunwind [1] should meet the requirements you need. It is high
>> performance
>> thanks to extensive caching, signal safe and does not rely on frame
>> pointers.
>>
>> [1]: https://github.com/libunwind/libunwind
>>
>> --
>> Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
>> KDAB (Deutschland) GmbH, a KDAB Group company
>> Tel: +49-30-521325470
>> KDAB - The Qt, C++ and OpenGL Experts
>
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--00000000000080287c05a1d76e86
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hmm, I don&#39;t know unfortunately, it should be che=
cked</div><br clear=3D"all"><div><div dir=3D"ltr" class=3D"gmail_signature"=
 data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div>Best regards,</di=
v><div>Valentin Grigorev</div></div></div></div><br></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 27, 2020 at=
 4:55 PM Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios=
.com">mathieu.desnoyers@efficios.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><div><div style=3D"font-family:arial,he=
lvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><div>Last time I checke=
d, the main issue with perf&#39;s handling of cases that lack frame pointer=
s<br></div><div>is that they grab a ~2-4kB worth of stack data into the tra=
ce, and then post-process it</div><div>with libunwind. This might be OK for=
 sampling use-cases, but is not something I consider</div><div>appropriate =
for tracing due to considerably increased use of tracing throughput.<br></d=
iv><div><br></div><div>Has the situation changed on the perf side ?<br></di=
v><div><br></div><div>Thanks,<br></div><div><br></div><div>Mathieu<br></div=
><div><br></div><div><span id=3D"gmail-m_-582777752024684310zwchr">----- On=
 Mar 27, 2020, at 9:44 AM, Valentin Grigorev &lt;<a href=3D"mailto:valentin=
.grigorev@jetbrains.com" target=3D"_blank">valentin.grigorev@jetbrains.com<=
/a>&gt; wrote:<br></span></div><div><blockquote style=3D"border-left:2px so=
lid rgb(16,16,255);margin-left:5px;padding-left:5px;color:rgb(0,0,0);font-w=
eight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,A=
rial,sans-serif;font-size:12pt"><div dir=3D"ltr"><div dir=3D"ltr"><div>Yeah=
, as far=C2=A0as I know, perf [1] is successfully using libunwind to provid=
e callstacks. Probably, LTTng team should think about it too, if there are =
no serious obstacles.</div><br><div>[1]:=C2=A0<a href=3D"https://perf.wiki.=
kernel.org/index.php/Main_Page" rel=3D"nofollow noopener noreferrer" target=
=3D"_blank">https://perf.wiki.kernel.org/index.php/Main_Page</a><br></div><=
div dir=3D"ltr"><br></div><div dir=3D"ltr"><br clear=3D"all"><div><div dir=
=3D"ltr"><div>Best regards,</div><div>Valentin Grigorev</div></div></div><b=
r></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Thu, Mar 26, 2020 at 11:53 PM Milian Wolff &lt;<a href=3D"mailto:milia=
n.wolff@kdab.com" rel=3D"nofollow noopener noreferrer" target=3D"_blank">mi=
lian.wolff@kdab.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On Donnerstag, 26. M=C3=A4rz 2020 20:41:17 CET Mathieu D=
esnoyers via lttng-dev <br>
wrote:<br>
&gt; ----- On Mar 26, 2020, at 1:39 PM, lttng-dev &lt;<a href=3D"mailto:ltt=
ng-dev@lists.lttng.org" rel=3D"nofollow noopener noreferrer" target=3D"_bla=
nk">lttng-dev@lists.lttng.org</a>&gt; <br>
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
[1]: <a href=3D"https://github.com/libunwind/libunwind" rel=3D"noreferrer n=
ofollow noopener noreferrer" target=3D"_blank">https://github.com/libunwind=
/libunwind</a><br>
<br>
-- <br>
Milian Wolff | <a href=3D"mailto:milian.wolff@kdab.com" rel=3D"nofollow noo=
pener noreferrer" target=3D"_blank">milian.wolff@kdab.com</a> | Senior Soft=
ware Engineer<br>
KDAB (Deutschland) GmbH, a KDAB Group company<br>
Tel: +49-30-521325470<br>
KDAB - The Qt, C++ and OpenGL Experts</blockquote></div></div></div><br></b=
lockquote></div><div><br></div><div>-- <br></div><div>Mathieu Desnoyers<br>=
EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http=
://www.efficios.com</a></div></div></div></blockquote></div>

--00000000000080287c05a1d76e86--

--===============1532427371160882968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1532427371160882968==--
