From: Jonah Graham <jonah@kichwacoders.com>
Subject: Re: Status of MinGW support for babeltrace (either 1.x
	or 2.x)
Date: Tue, 15 Aug 2017 18:09:16 +0100
Message-ID: <CAPmGMvjaO3Gj8PZdLD1UC6AVMi9mAbc03M+-=E7mMQybbE5qPg__29016.6465602399$1502816973$gmane$org@mail.gmail.com>
References: <CAPmGMvh9C2E7y3uDkdHqTizkuPAd9nuPn4OvOjvjDyCqyxhCag@mail.gmail.com>
 <CAB4xu_3HM+5At3=opwrZuzz9G7tqbg1JLxxgL0-F86m_+Zqc+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8728779255845582548=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sasl.smtp.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
 by lists.lttng.org (Postfix) with ESMTPS id 3xWzV90t8XzCng
 for <lttng-dev@lists.lttng.org>; Tue, 15 Aug 2017 17:09:20 +0000 (UTC)
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
 by pb-smtp2.pobox.com (Postfix) with ESMTP id A3A1897E74
 for <lttng-dev@lists.lttng.org>; Tue, 15 Aug 2017 13:09:18 -0400 (EDT)
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
 by pb-smtp2.pobox.com (Postfix) with ESMTP id 9BB2297E73
 for <lttng-dev@lists.lttng.org>; Tue, 15 Aug 2017 13:09:18 -0400 (EDT)
Received: from mail-it0-f48.google.com (unknown [209.85.214.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1644A97E71
 for <lttng-dev@lists.lttng.org>; Tue, 15 Aug 2017 13:09:18 -0400 (EDT)
Received: by mail-it0-f48.google.com with SMTP id 76so7021234ith.0
 for <lttng-dev@lists.lttng.org>; Tue, 15 Aug 2017 10:09:18 -0700 (PDT)
In-Reply-To: <CAB4xu_3HM+5At3=opwrZuzz9G7tqbg1JLxxgL0-F86m_+Zqc+w@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Philippe Proulx <eeppeliteloop@gmail.com>, mjeanson@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============8728779255845582548==
Content-Type: multipart/alternative; boundary="f403045d9adaea29110556cdd6e3"

--f403045d9adaea29110556cdd6e3
Content-Type: text/plain; charset="UTF-8"

Thank you both for the info. It looks like our timing is very good. I will
have a look at the staging branch too.

Our interest is in writing ctf files from our custom tools and then
analysing the traces in tracecompass. We were trying to decide between
libbabeltrace, barectf or spinning our own. With your goal of supporting
mingw, it seems that libbabeltrace is the best idea.

We'll do what we can to provide patches.

Thanks,
Jonah

On 15 Aug 2017 17:39, "Philippe Proulx" <eeppeliteloop@gmail.com> wrote:

> On Tue, Aug 15, 2017 at 12:12 PM, Jonah Graham <jonah@kichwacoders.com>
> wrote:
> >
> > Hello,
> >
> > Over the years I have seen some discussions and patches about getting
> > full MinGW support for babeltrace. I am interested in if someone can
> > provide an overview of the current state of MinGW.
> >
> > I have tried to build 1.5.3 and (probably as expected) there are
> > numerous compile issues (e.g. sys/mman.h)
> >
> > I have gotten further with current master (my primary interest is
> > libbabeltrace so the issues I have with cli/babeltrace.c and
> > tests/test_ctf_writer.c don't concern me too much yet). However when I
> > try to run a simple example (that works on Linux) it fails on
> > bt_ctf_stream_flush. I will debug further to identify the problem.
> > However If someone does have a mingw port working well any guidance on
> > building would be much appreciated.
>
> MinGW support is on its way for the Babeltrace 2.0 release, but I'm
> curious as to why your primary interest is libbabeltrace? Is it for CTF
> writer or for the trace reading API?
>
> Phil
>
> >
> > Thanks
> > Jonah
> >
> >
> > ~~~
> > Jonah Graham
> > Kichwa Coders Ltd.
> > www.kichwacoders.com
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--f403045d9adaea29110556cdd6e3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thank you both for the info. It looks like our timing is =
very good. I will have a look at the staging branch too.<div dir=3D"auto"><=
br></div><div dir=3D"auto">Our interest is in writing ctf files from our cu=
stom tools and then analysing the traces in tracecompass. We were trying to=
 decide between libbabeltrace, barectf or spinning our own. With your goal =
of supporting mingw, it seems that libbabeltrace is the best idea.</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">We&#39;ll do what we can to prov=
ide patches.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks,=C2=
=A0</div><div dir=3D"auto">Jonah =C2=A0</div></div><div class=3D"gmail_extr=
a"><br><div class=3D"gmail_quote">On 15 Aug 2017 17:39, &quot;Philippe Prou=
lx&quot; &lt;<a href=3D"mailto:eeppeliteloop@gmail.com" target=3D"_blank">e=
eppeliteloop@gmail.com</a>&gt; wrote:<br type=3D"attribution"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">On Tue, Aug 15, 2017 at 12:12 PM, Jonah Graham &lt;<a hre=
f=3D"mailto:jonah@kichwacoders.com">jonah@kichwacoders.com</a>&gt; wrote:<b=
r>
&gt;<br>
&gt; Hello,<br>
&gt;<br>
&gt; Over the years I have seen some discussions and patches about getting<=
br>
&gt; full MinGW support for babeltrace. I am interested in if someone can<b=
r>
&gt; provide an overview of the current state of MinGW.<br>
&gt;<br>
&gt; I have tried to build 1.5.3 and (probably as expected) there are<br>
&gt; numerous compile issues (e.g. sys/mman.h)<br>
&gt;<br>
&gt; I have gotten further with current master (my primary interest is<br>
&gt; libbabeltrace so the issues I have with cli/babeltrace.c and<br>
&gt; tests/test_ctf_writer.c don&#39;t concern me too much yet). However wh=
en I<br>
&gt; try to run a simple example (that works on Linux) it fails on<br>
&gt; bt_ctf_stream_flush. I will debug further to identify the problem.<br>
&gt; However If someone does have a mingw port working well any guidance on=
<br>
&gt; building would be much appreciated.<br>
<br>
MinGW support is on its way for the Babeltrace 2.0 release, but I&#39;m<br>
curious as to why your primary interest is libbabeltrace? Is it for CTF<br>
writer or for the trace reading API?<br>
<br>
Phil<br>
<br>
&gt;<br>
&gt; Thanks<br>
&gt; Jonah<br>
&gt;<br>
&gt;<br>
&gt; ~~~<br>
&gt; Jonah Graham<br>
&gt; Kichwa Coders Ltd.<br>
&gt; <a href=3D"http://www.kichwacoders.com" rel=3D"noreferrer" target=3D"_=
blank">www.kichwacoders.com</a><br>
&gt; ______________________________<wbr>_________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-<wbr>bin/=
mailman/listinfo/lttng-dev</a><br>
</blockquote></div></div>

--f403045d9adaea29110556cdd6e3--

--===============8728779255845582548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============8728779255845582548==--
