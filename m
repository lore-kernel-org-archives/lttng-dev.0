From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: LTTng user-space callstacks
Date: Fri, 27 Mar 2020 09:55:08 -0400 (EDT)
Message-ID: <570185028.14544.1585317308324.JavaMail.zimbra@efficios.com>
References: <CABhb4uuE2QD8Asejaa+mjLPEVQAZrCxU6pwLp=QFqb2N3vD9nw@mail.gmail.com>
 <2022773652.13655.1585251677207.JavaMail.zimbra@efficios.com>
 <1834419.usQuhbGJ8B@agathebauer>
 <CABhb4usOZOFUwQL85c5wW5K5VSMXx+CVwFmBb_ia+wJ1TJsxVw@mail.gmail.com>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6937393945351188872=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 48pjzQ36hTz1WJw
 for <lttng-dev@lists.lttng.org>; Fri, 27 Mar 2020 09:55:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id CBB3127FF88
 for <lttng-dev@lists.lttng.org>; Fri, 27 Mar 2020 09:55:08 -0400 (EDT)
In-Reply-To: <CABhb4usOZOFUwQL85c5wW5K5VSMXx+CVwFmBb_ia+wJ1TJsxVw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Valentin Grigorev <valentin.grigorev@jetbrains.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============6937393945351188872==
Content-Type: multipart/alternative;
	boundary="=_5f79c5b3-a0dd-42b2-927a-7bafba043e85"

--=_5f79c5b3-a0dd-42b2-927a-7bafba043e85
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Last time I checked, the main issue with perf's handling of cases that lack=
 frame pointers=20
is that they grab a ~2-4kB worth of stack data into the trace, and then pos=
t-process it=20
with libunwind. This might be OK for sampling use-cases, but is not somethi=
ng I consider=20
appropriate for tracing due to considerably increased use of tracing throug=
hput.=20

Has the situation changed on the perf side ?=20

Thanks,=20

Mathieu=20

----- On Mar 27, 2020, at 9:44 AM, Valentin Grigorev <valentin.grigorev@jet=
brains.com> wrote:=20

> Yeah, as far as I know, perf [1] is successfully using libunwind to provi=
de
> callstacks. Probably, LTTng team should think about it too, if there are =
no
> serious obstacles.

> [1]: [ https://perf.wiki.kernel.org/index.php/Main_Page |
> https://perf.wiki.kernel.org/index.php/Main_Page ]

> Best regards,
> Valentin Grigorev

> On Thu, Mar 26, 2020 at 11:53 PM Milian Wolff < [ mailto:milian.wolff@kda=
b.com |
> milian.wolff@kdab.com ] > wrote:

>> On Donnerstag, 26. M=C3=A4rz 2020 20:41:17 CET Mathieu Desnoyers via ltt=
ng-dev
>> wrote:
>>> ----- On Mar 26, 2020, at 1:39 PM, lttng-dev < [
>> > mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ] >
>> wrote:
>> > > Hello!

>> > > Currently, callstack collection in LTTng is only available for
>> > > kernel-space
>> > > events with context fields callstack-kernel and callstack-user .

>> > > Is it expected that callstack collection for LTTng-UST will be added=
 too?
>> > > And if it is expected, then how soon?

>> > Hi Valentin,

>> > It is something that would be interesting and useful, but a lot of wor=
k
>> > would be needed to have stack-walking this is fast enough and reentran=
t wrt
>> > signal handlers. Unfortunately, the backtrace(3) functions do not meet
>> > those requirements.

>> > Also, for gathering user-space callstacks from the kernel tracer, it o=
nly
>> > works if all user-space is compiled with frame pointers. This is also =
a
>> > limitation that would require a lot of work to overcome neatly.

>> > None of those features are currently on any roadmap due to lack of cus=
tomers
>> > showing interest in getting this done.

>> libunwind [1] should meet the requirements you need. It is high performa=
nce
>> thanks to extensive caching, signal safe and does not rely on frame poin=
ters.

>> [1]: [ https://github.com/libunwind/libunwind |
>> https://github.com/libunwind/libunwind ]

>> --
>> Milian Wolff | [ mailto:milian.wolff@kdab.com | milian.wolff@kdab.com ] =
| Senior
>> Software Engineer
>> KDAB (Deutschland) GmbH, a KDAB Group company
>> Tel: +49-30-521325470
>> KDAB - The Qt, C++ and OpenGL Experts
--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

--=_5f79c5b3-a0dd-42b2-927a-7bafba043e85
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>Last time I checked, the main issue with pe=
rf's handling of cases that lack frame pointers<br></div><div>is that they =
grab a ~2-4kB worth of stack data into the trace, and then post-process it<=
/div><div>with libunwind. This might be OK for sampling use-cases, but is n=
ot something I consider</div><div>appropriate for tracing due to considerab=
ly increased use of tracing throughput.<br data-mce-bogus=3D"1"></div><div>=
<br data-mce-bogus=3D"1"></div><div>Has the situation changed on the perf s=
ide ?<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><di=
v>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div=
><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br></div><div><span id=3D=
"zwchr" data-marker=3D"__DIVIDER__">----- On Mar 27, 2020, at 9:44 AM, Vale=
ntin Grigorev &lt;valentin.grigorev@jetbrains.com&gt; wrote:<br></span></di=
v><div data-marker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px=
 solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:norm=
al;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-=
serif;font-size:12pt;"><div dir=3D"ltr"><div dir=3D"ltr"><div>Yeah, as far&=
nbsp;as I know, perf [1] is successfully using libunwind to provide callsta=
cks. Probably, LTTng team should think about it too, if there are no seriou=
s obstacles.</div><br><div>[1]:&nbsp;<a href=3D"https://perf.wiki.kernel.or=
g/index.php/Main_Page" target=3D"_blank" rel=3D"nofollow noopener noreferre=
r">https://perf.wiki.kernel.org/index.php/Main_Page</a><br data-mce-bogus=
=3D"1"></div><div dir=3D"ltr"><br></div><div dir=3D"ltr"><br clear=3D"all">=
<div><div dir=3D"ltr"><div>Best regards,</div><div>Valentin Grigorev</div><=
/div></div><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Mar 26, 2020 at 11:53 PM Milian Wolff &lt;<a href=
=3D"mailto:milian.wolff@kdab.com" target=3D"_blank" rel=3D"nofollow noopene=
r noreferrer">milian.wolff@kdab.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb( 204 , 204 , 204 );padding-left:1ex">On Donnerstag, 26. M=C3=A4rz 2020 =
20:41:17 CET Mathieu Desnoyers via lttng-dev <br>
wrote:<br>
&gt; ----- On Mar 26, 2020, at 1:39 PM, lttng-dev &lt;<a href=3D"mailto:ltt=
ng-dev@lists.lttng.org" target=3D"_blank" rel=3D"nofollow noopener noreferr=
er">lttng-dev@lists.lttng.org</a>&gt; <br>
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
Milian Wolff | <a href=3D"mailto:milian.wolff@kdab.com" target=3D"_blank" r=
el=3D"nofollow noopener noreferrer">milian.wolff@kdab.com</a> | Senior Soft=
ware Engineer<br>
KDAB (Deutschland) GmbH, a KDAB Group company<br>
Tel: +49-30-521325470<br>
KDAB - The Qt, C++ and OpenGL Experts</blockquote></div></div></div><br></b=
lockquote></div><div><br></div><div data-marker=3D"__SIG_POST__">-- <br></d=
iv><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div>=
</div></body></html>
--=_5f79c5b3-a0dd-42b2-927a-7bafba043e85--

--===============6937393945351188872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6937393945351188872==--
