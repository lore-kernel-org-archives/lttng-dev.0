From: Jonah Graham <jonah@kichwacoders.com>
Subject: Re: Status of MinGW support for babeltrace (either 1.x
	or 2.x)
Date: Tue, 15 Aug 2017 19:25:34 +0100
Message-ID: <CAPmGMviXJU9ekxs_Dj7=RaLHPAxTS6eF7hvYNuaJ5nfQO7ELOQ__17248.0573099621$1502821551$gmane$org@mail.gmail.com>
References: <CAPmGMvh9C2E7y3uDkdHqTizkuPAd9nuPn4OvOjvjDyCqyxhCag@mail.gmail.com>
 <CAB4xu_3HM+5At3=opwrZuzz9G7tqbg1JLxxgL0-F86m_+Zqc+w@mail.gmail.com>
 <CAPmGMvjaO3Gj8PZdLD1UC6AVMi9mAbc03M+-=E7mMQybbE5qPg@mail.gmail.com>
 <CAB4xu_1QPYi_isqgf6i6-6_z6XXR_0hBGV7mBvskBypCkGNJsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3851033520844642743=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sasl.smtp.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
 by lists.lttng.org (Postfix) with ESMTPS id 3xX1BJ0rkNzD4J
 for <lttng-dev@lists.lttng.org>; Tue, 15 Aug 2017 18:25:43 +0000 (UTC)
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
 by pb-smtp2.pobox.com (Postfix) with ESMTP id 2CAA49A893
 for <lttng-dev@lists.lttng.org>; Tue, 15 Aug 2017 14:25:37 -0400 (EDT)
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
 by pb-smtp2.pobox.com (Postfix) with ESMTP id 258919A892
 for <lttng-dev@lists.lttng.org>; Tue, 15 Aug 2017 14:25:37 -0400 (EDT)
Received: from mail-io0-f176.google.com (unknown [209.85.223.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9BE7C9A889
 for <lttng-dev@lists.lttng.org>; Tue, 15 Aug 2017 14:25:35 -0400 (EDT)
Received: by mail-io0-f176.google.com with SMTP id g35so5972554ioi.3
 for <lttng-dev@lists.lttng.org>; Tue, 15 Aug 2017 11:25:35 -0700 (PDT)
In-Reply-To: <CAB4xu_1QPYi_isqgf6i6-6_z6XXR_0hBGV7mBvskBypCkGNJsA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============3851033520844642743==
Content-Type: multipart/alternative; boundary="001a113edd26c35cd20556cee724"

--001a113edd26c35cd20556cee724
Content-Type: text/plain; charset="UTF-8"

On 15 Aug 2017 19:10, "Philippe Proulx" <eeppeliteloop@gmail.com> wrote:

On Tue, Aug 15, 2017 at 1:09 PM, Jonah Graham <jonah@kichwacoders.com>
wrote:
> Thank you both for the info. It looks like our timing is very good. I will
> have a look at the staging branch too.
>
> Our interest is in writing ctf files from our custom tools and then
> analysing the traces in tracecompass. We were trying to decide between
> libbabeltrace, barectf or spinning our own. With your goal of supporting
> mingw, it seems that libbabeltrace is the best idea.

You want to actually trace, that is, produce CTF events from your
application, or convert an existing trace format to CTF?


We want to trace. We're producing a variety of plain text formats at the
moment, and are losing information and scalability. They were designed to
be human readable so they don't fit back into tracecompass that well.


Phil

>
> We'll do what we can to provide patches.
>
> Thanks,
> Jonah
>
> On 15 Aug 2017 17:39, "Philippe Proulx" <eeppeliteloop@gmail.com> wrote:
>>
>> On Tue, Aug 15, 2017 at 12:12 PM, Jonah Graham <jonah@kichwacoders.com>
>> wrote:
>> >
>> > Hello,
>> >
>> > Over the years I have seen some discussions and patches about getting
>> > full MinGW support for babeltrace. I am interested in if someone can
>> > provide an overview of the current state of MinGW.
>> >
>> > I have tried to build 1.5.3 and (probably as expected) there are
>> > numerous compile issues (e.g. sys/mman.h)
>> >
>> > I have gotten further with current master (my primary interest is
>> > libbabeltrace so the issues I have with cli/babeltrace.c and
>> > tests/test_ctf_writer.c don't concern me too much yet). However when I
>> > try to run a simple example (that works on Linux) it fails on
>> > bt_ctf_stream_flush. I will debug further to identify the problem.
>> > However If someone does have a mingw port working well any guidance on
>> > building would be much appreciated.
>>
>> MinGW support is on its way for the Babeltrace 2.0 release, but I'm
>> curious as to why your primary interest is libbabeltrace? Is it for CTF
>> writer or for the trace reading API?
>>
>> Phil
>>
>> >
>> > Thanks
>> > Jonah
>> >
>> >
>> > ~~~
>> > Jonah Graham
>> > Kichwa Coders Ltd.
>> > www.kichwacoders.com
>> > _______________________________________________
>> > lttng-dev mailing list
>> > lttng-dev@lists.lttng.org
>> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--001a113edd26c35cd20556cee724
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On 15 Aug 2017 19:10, &quot;Philippe Proulx&quot; &lt;<a href=3D"=
mailto:eeppeliteloop@gmail.com">eeppeliteloop@gmail.com</a>&gt; wrote:<br t=
ype=3D"attribution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><div class=3D"quoted-text">On =
Tue, Aug 15, 2017 at 1:09 PM, Jonah Graham &lt;<a href=3D"mailto:jonah@kich=
wacoders.com">jonah@kichwacoders.com</a>&gt; wrote:<br>
&gt; Thank you both for the info. It looks like our timing is very good. I =
will<br>
&gt; have a look at the staging branch too.<br>
&gt;<br>
&gt; Our interest is in writing ctf files from our custom tools and then<br=
>
&gt; analysing the traces in tracecompass. We were trying to decide between=
<br>
&gt; libbabeltrace, barectf or spinning our own. With your goal of supporti=
ng<br>
&gt; mingw, it seems that libbabeltrace is the best idea.<br>
<br>
</div>You want to actually trace, that is, produce CTF events from your<br>
application, or convert an existing trace format to CTF?<br></blockquote></=
div></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">We want to tr=
ace. We&#39;re producing a variety of plain text formats at the moment, and=
 are losing information and scalability. They were designed to be human rea=
dable so they don&#39;t fit back into tracecompass that well.=C2=A0</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_extra"><div=
 class=3D"gmail_quote"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Phil<br>
<div class=3D"elided-text"><br>
&gt;<br>
&gt; We&#39;ll do what we can to provide patches.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Jonah<br>
&gt;<br>
&gt; On 15 Aug 2017 17:39, &quot;Philippe Proulx&quot; &lt;<a href=3D"mailt=
o:eeppeliteloop@gmail.com">eeppeliteloop@gmail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Tue, Aug 15, 2017 at 12:12 PM, Jonah Graham &lt;<a href=3D"mail=
to:jonah@kichwacoders.com">jonah@kichwacoders.com</a>&gt;<br>
&gt;&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Hello,<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Over the years I have seen some discussions and patches about=
 getting<br>
&gt;&gt; &gt; full MinGW support for babeltrace. I am interested in if some=
one can<br>
&gt;&gt; &gt; provide an overview of the current state of MinGW.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I have tried to build 1.5.3 and (probably as expected) there =
are<br>
&gt;&gt; &gt; numerous compile issues (e.g. sys/mman.h)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I have gotten further with current master (my primary interes=
t is<br>
&gt;&gt; &gt; libbabeltrace so the issues I have with cli/babeltrace.c and<=
br>
&gt;&gt; &gt; tests/test_ctf_writer.c don&#39;t concern me too much yet). H=
owever when I<br>
&gt;&gt; &gt; try to run a simple example (that works on Linux) it fails on=
<br>
&gt;&gt; &gt; bt_ctf_stream_flush. I will debug further to identify the pro=
blem.<br>
&gt;&gt; &gt; However If someone does have a mingw port working well any gu=
idance on<br>
&gt;&gt; &gt; building would be much appreciated.<br>
&gt;&gt;<br>
&gt;&gt; MinGW support is on its way for the Babeltrace 2.0 release, but I&=
#39;m<br>
&gt;&gt; curious as to why your primary interest is libbabeltrace? Is it fo=
r CTF<br>
&gt;&gt; writer or for the trace reading API?<br>
&gt;&gt;<br>
&gt;&gt; Phil<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Thanks<br>
&gt;&gt; &gt; Jonah<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; ~~~<br>
&gt;&gt; &gt; Jonah Graham<br>
&gt;&gt; &gt; Kichwa Coders Ltd.<br>
&gt;&gt; &gt; <a href=3D"http://www.kichwacoders.com" rel=3D"noreferrer" ta=
rget=3D"_blank">www.kichwacoders.com</a><br>
&gt;&gt; &gt; ______________________________<wbr>_________________<br>
&gt;&gt; &gt; lttng-dev mailing list<br>
&gt;&gt; &gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.=
lttng.org</a><br>
&gt;&gt; &gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/l=
ttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-=
<wbr>bin/mailman/listinfo/lttng-dev</a><br>
</div></blockquote></div><br></div></div></div>

--001a113edd26c35cd20556cee724--

--===============3851033520844642743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3851033520844642743==--
