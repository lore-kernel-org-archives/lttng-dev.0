From: Rocky Dunlap <rsdunlapiv@gmail.com>
Subject: Fwd: Using Babeltrace to write CTF for MPI application
Date: Wed, 5 Apr 2017 11:37:54 -0600
Message-ID: <CAK-w0Dd_BiPJHLEOf6Fk-NGzeBCku8ARsxXBkUvJERXs3-hCKA__1906.3240536072$1491413905$gmane$org@mail.gmail.com>
References: <CAK-w0DeOHsrygOt4CLVBB55edg6W+hrEzX2+A-UwFn6E14HDoQ@mail.gmail.com>
 <e60c08f5-189c-bacc-b4bc-5438c6a36476@efficios.com>
 <CAK-w0DeNJ2CjfALbf5qLcN8FL6BWYumDZs-xk3ea_BL_xxWKKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9185456341115603328=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vk0-x230.google.com (mail-vk0-x230.google.com
 [IPv6:2607:f8b0:400c:c05::230])
 by lists.lttng.org (Postfix) with ESMTPS id 3vytNw19XHzl8S
 for <lttng-dev@lists.lttng.org>; Wed,  5 Apr 2017 17:38:39 +0000 (UTC)
Received: by mail-vk0-x230.google.com with SMTP id r69so13784352vke.2
 for <lttng-dev@lists.lttng.org>; Wed, 05 Apr 2017 10:38:16 -0700 (PDT)
In-Reply-To: <CAK-w0DeNJ2CjfALbf5qLcN8FL6BWYumDZs-xk3ea_BL_xxWKKw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============9185456341115603328==
Content-Type: multipart/alternative; boundary=94eb2c097a386f49b3054c6edb02

--94eb2c097a386f49b3054c6edb02
Content-Type: text/plain; charset=UTF-8

Apologies... I meant to reply to the list.


---------- Forwarded message ----------
From: Rocky Dunlap <rsdunlapiv@gmail.com>
Date: Wed, Apr 5, 2017 at 10:13 AM
Subject: Re: [lttng-dev] Using Babeltrace to write CTF for MPI application
To: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>


Jonathan,

I started with barectf and I really like it!  It works great for basic
cases.  Unfortunately, it only supports simple event structures right now,
so for this reason I switched to the babeltrace CTF library, which has full
support for CTF.

Rocky

On Tue, Apr 4, 2017 at 5:52 PM, Jonathan Rajotte Julien <
Jonathan.rajotte-julien@efficios.com> wrote:

> Hi Rocky,
>
> Not sure if pertinent but did you take a look at the barectf [1] project?
>
> Cheers
>
> [1] https://github.com/efficios/barectf
>
> On 2017-04-04 05:29 PM, Rocky Dunlap wrote:
> > I am instrumenting an MPI application to output a custom application
> trace in CTF using Babeltrace 1.5.2.  I would like to end up with a single
> trace with multiple streams, one per process.  All streams share the same
> stream class (and metadata). All processes have access to the same file
> system.  I am using the C CTF writer API using this test as an example:
> > https://github.com/efficios/babeltrace/blob/stable-1.5/tests
> /lib/test_ctf_writer.c
> >
> > What I have in mind is something like this: process 0 would be
> responsible for writing the metadata and its own stream, while all other
> processes would only need to write their own stream.
> >
> > The issue I have run into is that the individual stream file names are
> determined by appending stream->id to the stream filename and the stream id
> is determined behind the scenes as stream->id =
> stream_class->next_stream_id++.  Since each process has its own address
> space, all processes want stream id of 0.
> >
> > Is there a way using the current API to explicitly set the stream id so
> that each process will write to a separate file?
> >
> > I'm also open for suggestions on the overall approach.  The main reason
> to have each process as a separate stream in a single trace is so that I
> can open the entire trace in an analysis tool like TraceCompass and see all
> processes together.
> >
> > Rocky
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
>
> --
> Jonathan R. Julien
> Efficios
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--94eb2c097a386f49b3054c6edb02
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Apologies... I meant to reply to the list.<div><br></div><=
div><br><div class=3D"gmail_quote">---------- Forwarded message ----------<=
br>From: <b class=3D"gmail_sendername">Rocky Dunlap</b> <span dir=3D"ltr">&=
lt;<a href=3D"mailto:rsdunlapiv@gmail.com">rsdunlapiv@gmail.com</a>&gt;</sp=
an><br>Date: Wed, Apr 5, 2017 at 10:13 AM<br>Subject: Re: [lttng-dev] Using=
 Babeltrace to write CTF for MPI application<br>To: Jonathan Rajotte Julien=
 &lt;<a href=3D"mailto:Jonathan.rajotte-julien@efficios.com">Jonathan.rajot=
te-julien@efficios.com</a>&gt;<br><br><br><div dir=3D"ltr">Jonathan,<div><b=
r></div><div>I started with barectf and I really like it!=C2=A0 It works gr=
eat for basic cases.=C2=A0 Unfortunately, it only supports simple event str=
uctures right now, so for this reason I switched to the babeltrace CTF libr=
ary, which has full support for CTF. =C2=A0</div><span class=3D"HOEnZb"><fo=
nt color=3D"#888888"><div><br></div><div>Rocky</div></font></span><div><div=
 class=3D"h5"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On =
Tue, Apr 4, 2017 at 5:52 PM, Jonathan Rajotte Julien <span dir=3D"ltr">&lt;=
<a href=3D"mailto:Jonathan.rajotte-julien@efficios.com" target=3D"_blank">J=
onathan.rajotte-julien@effic<wbr>ios.com</a>&gt;</span> wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">Hi Rocky,<br>
<br>
Not sure if pertinent but did you take a look at the barectf [1] project?<b=
r>
<br>
Cheers<br>
<br>
[1] <a href=3D"https://github.com/efficios/barectf" rel=3D"noreferrer" targ=
et=3D"_blank">https://github.com/efficios/ba<wbr>rectf</a><br>
<div><div class=3D"m_-1124128816296168230m_8318619965553724726h5"><br>
On 2017-04-04 05:29 PM, Rocky Dunlap wrote:<br>
&gt; I am instrumenting an MPI application to output a custom application t=
race in CTF using Babeltrace 1.5.2.=C2=A0 I would like to end up with a sin=
gle trace with multiple streams, one per process.=C2=A0 All streams share t=
he same stream class (and metadata). All processes have access to the same =
file system.=C2=A0 I am using the C CTF writer API using this test as an ex=
ample:<br>
&gt; <a href=3D"https://github.com/efficios/babeltrace/blob/stable-1.5/test=
s/lib/test_ctf_writer.c" rel=3D"noreferrer" target=3D"_blank">https://githu=
b.com/efficios/ba<wbr>beltrace/blob/stable-1.5/tests<wbr>/lib/test_ctf_writ=
er.c</a><br>
&gt;<br>
&gt; What I have in mind is something like this: process 0 would be respons=
ible for writing the metadata and its own stream, while all other processes=
 would only need to write their own stream.<br>
&gt;<br>
&gt; The issue I have run into is that the individual stream file names are=
 determined by appending stream-&gt;id to the stream filename and the strea=
m id is determined behind the scenes as stream-&gt;id =3D stream_class-&gt;=
next_stream_id++<wbr>.=C2=A0 Since each process has its own address space, =
all processes want stream id of 0.<br>
&gt;<br>
&gt; Is there a way using the current API to explicitly set the stream id s=
o that each process will write to a separate file?<br>
&gt;<br>
&gt; I&#39;m also open for suggestions on the overall approach.=C2=A0 The m=
ain reason to have each process as a separate stream in a single trace is s=
o that I can open the entire trace in an analysis tool like TraceCompass an=
d see all processes together.<br>
&gt;<br>
&gt; Rocky<br>
&gt;<br>
&gt;<br>
</div></div>&gt; ______________________________<wbr>_________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bi<wbr>n/=
mailman/listinfo/lttng-dev</a><br>
&gt;<br>
<span class=3D"m_-1124128816296168230m_8318619965553724726HOEnZb"><font col=
or=3D"#888888"><br>
--<br>
Jonathan R. Julien<br>
Efficios<br>
______________________________<wbr>_________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bi<wbr>n/mail=
man/listinfo/lttng-dev</a><br>
</font></span></blockquote></div><br></div></div></div></div>
</div><br></div></div>

--94eb2c097a386f49b3054c6edb02--

--===============9185456341115603328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============9185456341115603328==--
