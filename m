From: Brian Rossa <br@f0cal.com>
Subject: Re: "Hands-free" tracepoints using LD_PRELOAD
Date: Wed, 23 Jan 2019 19:20:16 -0500
Message-ID: <CAF=ZobxxA5Ms1PbEebpGvCKPn4-WuHAkHb0eqvJYgM_m4YG9_w__16956.6268030152$1548341012$gmane$org@mail.gmail.com>
References: <CAF=ZobxSoNuto2U9NTihytCpdNODfH8Bv6JtGCym_g6hg3Uz4w@mail.gmail.com>
 <CADcCL0gLBOs1L0sqOsPg3+nyHp0sVFGK2ymk0-pw4QRGO7UhGw@mail.gmail.com>
 <CAF=ZobwMe56-9nb+o=jYcpJVuhxEsHthLCHrkFt8KhEaK5bODQ@mail.gmail.com>
 <20190122191748.GB17450@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5212458394983094977=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 by lists.lttng.org (Postfix) with ESMTPS id 43lN8y0smQzpDG
 for <lttng-dev@lists.lttng.org>; Wed, 23 Jan 2019 19:20:33 -0500 (EST)
Received: by mail-lj1-x230.google.com with SMTP id l15-v6so3630588lja.9
 for <lttng-dev@lists.lttng.org>; Wed, 23 Jan 2019 16:20:33 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com.
 [209.85.167.47])
 by smtp.gmail.com with ESMTPSA id z15-v6sm835327ljb.9.2019.01.23.16.20.30
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Jan 2019 16:20:30 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id n18so2983873lfh.6
 for <lttng-dev@lists.lttng.org>; Wed, 23 Jan 2019 16:20:30 -0800 (PST)
In-Reply-To: <20190122191748.GB17450@joraj-alpa>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============5212458394983094977==
Content-Type: multipart/alternative; boundary="00000000000088a73e0580292d81"

--00000000000088a73e0580292d81
Content-Type: text/plain; charset="UTF-8"

Jonathan,

Responses below:

AFAIK, lttng does not have an equivalent.
>

I believe my code could significantly reduce the need for hand-writing the
tracepoints. But I won't likely take on a port to LTTng immediately, as a
"vanilla" interposition approach seems to be meeting my requirements.


> > Step #2 is particularly problematic due to
> > ambiguities in the mangling grammar, and will need support going forward
> to
> > generalize well.
>
> What is the status of this step in your project?
>

I demangle the symbol name using c++filt and then use regex to extract the
list of argument types. Using something like ItaniumPartialDemangler would
be better.


> What are the problems that make your implementation "error-pone"?
>

Use of regex as above.


> Would you mind linking us to said project so we can have a look?
>

It's a project for my employer, and I would need to keep the source closed
until I can get an OK. A signal of interest from LTTng would be helpful
there. In the meantime, I think it would be fine to share as read-only with
the LTTng maintainers if someone wants to send me a Github username.


> I would be interested in seeing at first lttng tracepoint used as Francis
> demonstrated and see from there were this project can go.
>
...

> > I would be happy to contribute some or all of my implementation if it's
> > something that the LTTng community would be interested in supporting and
> > extending.
>
> We are clearly open for discussion and helping you improve the project. I
> am not
> so sure on supporting and extending it. Others might have a different
> opinion.
>

Sounds good. Looking forward to connecting via personal email.

Cheers!
~br


On Tue, Jan 22, 2019 at 2:17 PM Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> Hi Brian,
>
> On Tue, Jan 22, 2019 at 01:30:23PM -0500, Brian Rossa wrote:
> >    4. Boilerplate that does the typical `log(...); auto return_val =
> >    dlsym(...); log(...); return return_val;` gets generated.
>
> As proposed by Francis, this is when you need to "generate" a corresponding
> tracepoint definition and call the tracepoint() call with the appropriate
> arguments.
>
> As Francis demonstrated we do not see any reason for lttng-ust not to work
> here
> given that you compile the libshim object correctly.
>
> >    5. `log(...)` is a thin interface to spdlog
> >    <https://github.com/gabime/spdlog> that handles `__attribute__`-based
> >    setup and teardown of a logger.
> >
> > So at the end of the day, the shim developer provides:
> >
> >    - The whitelist of mangled names
> >    - Implementations of struct "wrappers" that provide custom ostream
> >    operators
> >    - A map between type names and wrapper names
> >
> > The machinery here seems fairly general-purpose, but I don't presume to
> be
> > an expert. My implementation is somewhat error-prone, and my main hope in
> > reaching out to the mailing list was that LTTng already had some of these
> > steps better-implemented.
>
> AFAIK, lttng does not have an equivalent.
>
> > Step #2 is particularly problematic due to
> > ambiguities in the mangling grammar, and will need support going forward
> to
> > generalize well.
>
> What is the status of this step in your project?
>
> What are the problems that make your implementation "error-pone"?
>
> Would you mind linking us to said project so we can have a look?
>
> I would be interested in seeing at first lttng tracepoint used as Francis
> demonstrated and see from there were this project can go.
>
> >
> > I would be happy to contribute some or all of my implementation if it's
> > something that the LTTng community would be interested in supporting and
> > extending.
>
> We are clearly open for discussion and helping you improve the project. I
> am not
> so sure on supporting and extending it. Others might have a different
> opinion.
>
>
> Cheers
>
> --
> Jonathan Rajotte-Julien
> EfficiOS
>

--00000000000088a73e0580292d81
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Jonathan,</div><div><br></div><div>Responses below:<b=
r></div><div></div><div><br></div><div><div class=3D"gmail_quote"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
AFAIK, lttng does not have an equivalent.<br></blockquote><div><br></div><d=
iv>I believe my code could significantly reduce the need for hand-writing t=
he tracepoints. But I won&#39;t likely take on a port to LTTng immediately,=
 as a &quot;vanilla&quot; interposition approach seems to be meeting my req=
uirements.<br></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
&gt; Step #2 is particularly problematic due to<br>
&gt; ambiguities in the mangling grammar, and will need support going forwa=
rd to<br>
&gt; generalize well.<br>
<br>
What is the status of this step in your project?<br></blockquote><div><br><=
/div><div>I demangle the symbol name using c++filt and then use regex to ex=
tract the list of argument types. Using something like ItaniumPartialDemang=
ler would be better.<br></div><div>=C2=A0<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
What are the problems that make your implementation &quot;error-pone&quot;?=
<br></blockquote><div><br></div><div>Use of regex as above.<br></div><div>=
=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Would you mind linking us to said project so we can have a look?<br></block=
quote><div><br></div><div>It&#39;s a project for my employer, and I would n=
eed to keep the source closed until I can get an OK. A signal of interest f=
rom LTTng would be helpful there. In the meantime, I think it would be fine=
 to share as read-only with the LTTng maintainers if someone wants to send =
me a Github username.</div><div>=C2=A0<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
I would be interested in seeing at first lttng tracepoint used as Francis<b=
r>
demonstrated and see from there were this project can go.<br></blockquote><=
div>...<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; I would be happy to contribute some or all of my implementation if it&=
#39;s<br>
&gt; something that the LTTng community would be interested in supporting a=
nd<br>
&gt; extending.<br>
<br>
We are clearly open for discussion and helping you improve the project. I a=
m not<br>
so sure on supporting and extending it. Others might have a different opini=
on.<br>
</blockquote></div></div><div><br></div><div>Sounds good. Looking forward t=
o connecting via personal email.</div><div><br></div><div>Cheers!</div><div=
>~br<br></div><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Tue, Jan 22, 2019 at 2:17 PM Jonathan Rajotte-Julien &l=
t;<a href=3D"mailto:jonathan.rajotte-julien@efficios.com">jonathan.rajotte-=
julien@efficios.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
Hi Brian,<br>
<br>
On Tue, Jan 22, 2019 at 01:30:23PM -0500, Brian Rossa wrote:<br>
&gt;=C2=A0 =C2=A0 4. Boilerplate that does the typical `log(...); auto retu=
rn_val =3D<br>
&gt;=C2=A0 =C2=A0 dlsym(...); log(...); return return_val;` gets generated.=
<br>
<br>
As proposed by Francis, this is when you need to &quot;generate&quot; a cor=
responding<br>
tracepoint definition and call the tracepoint() call with the appropriate<b=
r>
arguments.<br>
<br>
As Francis demonstrated we do not see any reason for lttng-ust not to work =
here<br>
given that you compile the libshim object correctly.<br>
<br>
&gt;=C2=A0 =C2=A0 5. `log(...)` is a thin interface to spdlog<br>
&gt;=C2=A0 =C2=A0 &lt;<a href=3D"https://github.com/gabime/spdlog" rel=3D"n=
oreferrer" target=3D"_blank">https://github.com/gabime/spdlog</a>&gt; that =
handles `__attribute__`-based<br>
&gt;=C2=A0 =C2=A0 setup and teardown of a logger.<br>
&gt; <br>
&gt; So at the end of the day, the shim developer provides:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 - The whitelist of mangled names<br>
&gt;=C2=A0 =C2=A0 - Implementations of struct &quot;wrappers&quot; that pro=
vide custom ostream<br>
&gt;=C2=A0 =C2=A0 operators<br>
&gt;=C2=A0 =C2=A0 - A map between type names and wrapper names<br>
&gt; <br>
&gt; The machinery here seems fairly general-purpose, but I don&#39;t presu=
me to be<br>
&gt; an expert. My implementation is somewhat error-prone, and my main hope=
 in<br>
&gt; reaching out to the mailing list was that LTTng already had some of th=
ese<br>
&gt; steps better-implemented.<br>
<br>
AFAIK, lttng does not have an equivalent.<br>
<br>
&gt; Step #2 is particularly problematic due to<br>
&gt; ambiguities in the mangling grammar, and will need support going forwa=
rd to<br>
&gt; generalize well.<br>
<br>
What is the status of this step in your project?<br>
<br>
What are the problems that make your implementation &quot;error-pone&quot;?=
<br>
<br>
Would you mind linking us to said project so we can have a look?<br>
<br>
I would be interested in seeing at first lttng tracepoint used as Francis<b=
r>
demonstrated and see from there were this project can go.<br>
<br>
&gt; <br>
&gt; I would be happy to contribute some or all of my implementation if it&=
#39;s<br>
&gt; something that the LTTng community would be interested in supporting a=
nd<br>
&gt; extending.<br>
<br>
We are clearly open for discussion and helping you improve the project. I a=
m not<br>
so sure on supporting and extending it. Others might have a different opini=
on.<br>
<br>
<br>
Cheers<br>
<br>
--<br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</blockquote></div></div></div>

--00000000000088a73e0580292d81--

--===============5212458394983094977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5212458394983094977==--
