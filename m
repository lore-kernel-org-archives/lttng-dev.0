From: Brian Rossa <br@f0cal.com>
Subject: Re: "Hands-free" tracepoints using LD_PRELOAD
Date: Fri, 25 Jan 2019 04:04:51 -0500
Message-ID: <CAF=Zobz-eX1gXC6EL8q0KFL3tspR8U99yz-kbHcUqkBafA=Meg__8517.53453477926$1548407133$gmane$org@mail.gmail.com>
References: <CAF=ZobxSoNuto2U9NTihytCpdNODfH8Bv6JtGCym_g6hg3Uz4w@mail.gmail.com>
 <CADcCL0gLBOs1L0sqOsPg3+nyHp0sVFGK2ymk0-pw4QRGO7UhGw@mail.gmail.com>
 <CAF=ZobwMe56-9nb+o=jYcpJVuhxEsHthLCHrkFt8KhEaK5bODQ@mail.gmail.com>
 <20190122191748.GB17450@joraj-alpa>
 <CAF=ZobxxA5Ms1PbEebpGvCKPn4-WuHAkHb0eqvJYgM_m4YG9_w@mail.gmail.com>
 <CADcCL0iBwaZfFU+R=Nhu-kDZpkxS_018j0xVwz5vh_5tto434w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0702175613840597881=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 by lists.lttng.org (Postfix) with ESMTPS id 43mClm3cNcznW3
 for <lttng-dev@lists.lttng.org>; Fri, 25 Jan 2019 04:05:08 -0500 (EST)
Received: by mail-lj1-x234.google.com with SMTP id s5-v6so7700313ljd.12
 for <lttng-dev@lists.lttng.org>; Fri, 25 Jan 2019 01:05:08 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com.
 [209.85.208.181])
 by smtp.gmail.com with ESMTPSA id r4sm1384058lfe.60.2019.01.25.01.05.04
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 01:05:04 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id q2-v6so7719227lji.10
 for <lttng-dev@lists.lttng.org>; Fri, 25 Jan 2019 01:05:04 -0800 (PST)
In-Reply-To: <CADcCL0iBwaZfFU+R=Nhu-kDZpkxS_018j0xVwz5vh_5tto434w@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Francis Deslauriers <francis.deslauriers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0702175613840597881==
Content-Type: multipart/alternative; boundary="00000000000063d4c70580449f08"

--00000000000063d4c70580449f08
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Francis,

These are great suggestions, thanks!

#Third idea:
> Do you know of tracef() [3] ? Using it, you can save any string to a
> UST trace. As a first step, you could directly replace your calls to
> spdlog by calls to tracef. It's an highly inefficient way of using
> LTTng, but it works (and probably lower overhead than writing to a
> file).
>

Replacing spdlog::debug(...) with tracef(...) may be an easy way for me to
get familiar with LTTNg workflows without having to go through a complete
port.

This brings up an interesting question, though, and the answer may motivate
me to close the gap further: What kind of latency reduction can I expect
from moving from spdlog to LLTng? I know this is ill-posed without knowing
more about how many pseudo-tracepoints I'm implementing, the log message
sizes that I'm pushing to disk, etc, etc., but something notional would
help my motivation.


> You mentioned that you wrap structures with ostreams to output them in
> text format. Can you explain this a bit more?
>

I'm just implementing what spdlog suggests:
https://github.com/gabime/spdlog#user-defined-types

Cheers!
~br

On Thu, Jan 24, 2019 at 11:06 AM Francis Deslauriers <
francis.deslauriers@efficios.com> wrote:

> "
>
> Le mer. 23 janv. 2019, =C3=A0 19 h 20, Brian Rossa <br@f0cal.com> a =C3=
=A9crit :
> >
> > Jonathan,
> >
> > Responses below:
> >
> >> AFAIK, lttng does not have an equivalent.
> >
> >
> > I believe my code could significantly reduce the need for hand-writing
> the tracepoints. But I won't likely take on a port to LTTng immediately, =
as
> a "vanilla" interposition approach seems to be meeting my requirements.
> >
> >>
> >> > Step #2 is particularly problematic due to
> >> > ambiguities in the mangling grammar, and will need support going
> forward to
> >> > generalize well.
> >>
> >> What is the status of this step in your project?
> >
> >
> > I demangle the symbol name using c++filt and then use regex to extract
> the list of argument types. Using something like ItaniumPartialDemangler
> would be better.
>
> Hi Brian,
>
> If you have a list of the argument types, you can programmatically
> generate the tracepoint descriptions and callsites accordingly. The
> main blocker I see here is tracing arguments that are pointers to
> classes or containers. We need to be able to map each argument with a
> CTF type [1]. It's easy enough for int, float and char * but it's
> harder for complex structs and data structures.
>
> You mentioned that you wrap structures with ostreams to output them in
> text format. Can you explain this a bit more?
>
> Here are a few ideas:
>
> #First idea
> If you are already defining the printing format and order of each of
> the fields of each structures in your libfoo.so maybe you could do the
> same but in LTTng-UST format. See "my-custom-structure.h" example [2].
>
> #Second idea:
> If you prefer not convert those ostreams wrappers to ctf wrapper, you
> could reuse them to generate CTF_STRINGs.
> 1. Simple data types (int, float, char*) are mapped directly to CTF types=
,
> 2. Complex data types are wrapped with ostream function,
> 3. Complex data types are saved in the trace as CTF_STRING using the
> ostream.
> All this could be done by the boilerplate scripts I mentioned earlier.
> By using string format for some argument, you don't get the full power
> of LTTng but it will still be faster that saving everything in text.
>
> #Third idea:
> Do you know of tracef() [3] ? Using it, you can save any string to a
> UST trace. As a first step, you could directly replace your calls to
> spdlog by calls to tracef. It's an highly inefficient way of using
> LTTng, but it works (and probably lower overhead than writing to a
> file).
>
> [1]: https://lttng.org/man/3/lttng-ust/v2.10/
> [2]: https://lttng.org/docs/v2.10/#doc-defining-tracepoints
> [3]: https://lttng.org/docs/v2.10/#doc-tracef
>
> Thank you,
> Francis
>
> >
> >>
> >> What are the problems that make your implementation "error-pone"?
> >
> >
> > Use of regex as above.
> >
> >>
> >> Would you mind linking us to said project so we can have a look?
> >
> >
> > It's a project for my employer, and I would need to keep the source
> closed until I can get an OK. A signal of interest from LTTng would be
> helpful there. In the meantime, I think it would be fine to share as
> read-only with the LTTng maintainers if someone wants to send me a Github
> username.
> >
> >>
> >> I would be interested in seeing at first lttng tracepoint used as
> Francis
> >> demonstrated and see from there were this project can go.
> >
> > ...
> >>
> >> > I would be happy to contribute some or all of my implementation if
> it's
> >> > something that the LTTng community would be interested in supporting
> and
> >> > extending.
> >>
> >> We are clearly open for discussion and helping you improve the project=
.
> I am not
> >> so sure on supporting and extending it. Others might have a different
> opinion.
> >
> >
> > Sounds good. Looking forward to connecting via personal email.
> >
> > Cheers!
> > ~br
> >
> >
> > On Tue, Jan 22, 2019 at 2:17 PM Jonathan Rajotte-Julien <
> jonathan.rajotte-julien@efficios.com> wrote:
> >>
> >> Hi Brian,
> >>
> >> On Tue, Jan 22, 2019 at 01:30:23PM -0500, Brian Rossa wrote:
> >> >    4. Boilerplate that does the typical `log(...); auto return_val =
=3D
> >> >    dlsym(...); log(...); return return_val;` gets generated.
> >>
> >> As proposed by Francis, this is when you need to "generate" a
> corresponding
> >> tracepoint definition and call the tracepoint() call with the
> appropriate
> >> arguments.
> >>
> >> As Francis demonstrated we do not see any reason for lttng-ust not to
> work here
> >> given that you compile the libshim object correctly.
> >>
> >> >    5. `log(...)` is a thin interface to spdlog
> >> >    <https://github.com/gabime/spdlog> that handles
> `__attribute__`-based
> >> >    setup and teardown of a logger.
> >> >
> >> > So at the end of the day, the shim developer provides:
> >> >
> >> >    - The whitelist of mangled names
> >> >    - Implementations of struct "wrappers" that provide custom ostrea=
m
> >> >    operators
> >> >    - A map between type names and wrapper names
> >> >
> >> > The machinery here seems fairly general-purpose, but I don't presume
> to be
> >> > an expert. My implementation is somewhat error-prone, and my main
> hope in
> >> > reaching out to the mailing list was that LTTng already had some of
> these
> >> > steps better-implemented.
> >>
> >> AFAIK, lttng does not have an equivalent.
> >>
> >> > Step #2 is particularly problematic due to
> >> > ambiguities in the mangling grammar, and will need support going
> forward to
> >> > generalize well.
> >>
> >> What is the status of this step in your project?
> >>
> >> What are the problems that make your implementation "error-pone"?
> >>
> >> Would you mind linking us to said project so we can have a look?
> >>
> >> I would be interested in seeing at first lttng tracepoint used as
> Francis
> >> demonstrated and see from there were this project can go.
> >>
> >> >
> >> > I would be happy to contribute some or all of my implementation if
> it's
> >> > something that the LTTng community would be interested in supporting
> and
> >> > extending.
> >>
> >> We are clearly open for discussion and helping you improve the project=
.
> I am not
> >> so sure on supporting and extending it. Others might have a different
> opinion.
> >>
> >>
> >> Cheers
> >>
> >> --
> >> Jonathan Rajotte-Julien
> >> EfficiOS
>
>
>
> --
> Francis Deslauriers
> Computer Engineer
> EfficiOS inc.
>

--00000000000063d4c70580449f08
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Francis,</div><div><br></div><div>These are great sug=
gestions, thanks!</div><div><br><div><div class=3D"gmail_quote"></div></div=
></div><div dir=3D"ltr"><div><div><div class=3D"gmail_quote"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
#Third idea:<br>
Do you know of tracef() [3] ? Using it, you can save any string to a<br>
UST trace. As a first step, you could directly replace your calls to<br>
spdlog by calls to tracef. It&#39;s an highly inefficient way of using<br>
LTTng, but it works (and probably lower overhead than writing to a<br>
file).<br></blockquote><div><br></div></div></div></div></div><div dir=3D"l=
tr"><div><div><div class=3D"gmail_quote"><div>Replacing spdlog::debug(...) =
with tracef(...) may be an easy way for me to get familiar with LTTNg workf=
lows without having to go through a complete port.</div><div><br></div><div=
>This brings up an interesting question, though, and the answer may motivat=
e me to close the gap further: What kind of latency reduction can I expect =
from moving from spdlog to LLTng? I know this is ill-posed without knowing =
more about how many pseudo-tracepoints I&#39;m implementing, the log messag=
e sizes that I&#39;m pushing to disk, etc, etc., but something notional wou=
ld help my motivation.</div><div>=C2=A0</div><div><div class=3D"gmail_quote=
"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
You mentioned that you wrap structures with ostreams to output them in<br>
text format. Can you explain this a bit more?<br>
</blockquote></div>=C2=A0</div><div>I&#39;m just implementing what spdlog s=
uggests: <a href=3D"https://github.com/gabime/spdlog#user-defined-types">ht=
tps://github.com/gabime/spdlog#user-defined-types</a><br></div></div></div>=
</div></div><div dir=3D"ltr"><div><br></div><div>Cheers!</div><div>~br<br><=
/div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"m_211019=
1321372128786m_455641889000109838gmail_attr">On Thu, Jan 24, 2019 at 11:06 =
AM Francis Deslauriers &lt;<a href=3D"mailto:francis.deslauriers@efficios.c=
om" target=3D"_blank">francis.deslauriers@efficios.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">&quot;<br>
<br>
Le mer. 23 janv. 2019, =C3=A0 19 h 20, Brian Rossa &lt;<a href=3D"mailto:br=
@f0cal.com" target=3D"_blank">br@f0cal.com</a>&gt; a =C3=A9crit :<br>
&gt;<br>
&gt; Jonathan,<br>
&gt;<br>
&gt; Responses below:<br>
&gt;<br>
&gt;&gt; AFAIK, lttng does not have an equivalent.<br>
&gt;<br>
&gt;<br>
&gt; I believe my code could significantly reduce the need for hand-writing=
 the tracepoints. But I won&#39;t likely take on a port to LTTng immediatel=
y, as a &quot;vanilla&quot; interposition approach seems to be meeting my r=
equirements.<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; &gt; Step #2 is particularly problematic due to<br>
&gt;&gt; &gt; ambiguities in the mangling grammar, and will need support go=
ing forward to<br>
&gt;&gt; &gt; generalize well.<br>
&gt;&gt;<br>
&gt;&gt; What is the status of this step in your project?<br>
&gt;<br>
&gt;<br>
&gt; I demangle the symbol name using c++filt and then use regex to extract=
 the list of argument types. Using something like ItaniumPartialDemangler w=
ould be better.<br>
<br>
Hi Brian,<br>
<br>
If you have a list of the argument types, you can programmatically<br>
generate the tracepoint descriptions and callsites accordingly. The<br>
main blocker I see here is tracing arguments that are pointers to<br>
classes or containers. We need to be able to map each argument with a<br>
CTF type [1]. It&#39;s easy enough for int, float and char * but it&#39;s<b=
r>
harder for complex structs and data structures.<br>
<br>
You mentioned that you wrap structures with ostreams to output them in<br>
text format. Can you explain this a bit more?<br>
<br>
Here are a few ideas:<br>
<br>
#First idea<br>
If you are already defining the printing format and order of each of<br>
the fields of each structures in your libfoo.so maybe you could do the<br>
same but in LTTng-UST format. See &quot;my-custom-structure.h&quot; example=
 [2].<br>
<br>
#Second idea:<br>
If you prefer not convert those ostreams wrappers to ctf wrapper, you<br>
could reuse them to generate CTF_STRINGs.<br>
1. Simple data types (int, float, char*) are mapped directly to CTF types,<=
br>
2. Complex data types are wrapped with ostream function,<br>
3. Complex data types are saved in the trace as CTF_STRING using the ostrea=
m.<br>
All this could be done by the boilerplate scripts I mentioned earlier.<br>
By using string format for some argument, you don&#39;t get the full power<=
br>
of LTTng but it will still be faster that saving everything in text.<br>
<br>
#Third idea:<br>
Do you know of tracef() [3] ? Using it, you can save any string to a<br>
UST trace. As a first step, you could directly replace your calls to<br>
spdlog by calls to tracef. It&#39;s an highly inefficient way of using<br>
LTTng, but it works (and probably lower overhead than writing to a<br>
file).<br>
<br>
[1]: <a href=3D"https://lttng.org/man/3/lttng-ust/v2.10/" rel=3D"noreferrer=
" target=3D"_blank">https://lttng.org/man/3/lttng-ust/v2.10/</a><br>
[2]: <a href=3D"https://lttng.org/docs/v2.10/#doc-defining-tracepoints" rel=
=3D"noreferrer" target=3D"_blank">https://lttng.org/docs/v2.10/#doc-definin=
g-tracepoints</a><br>
[3]: <a href=3D"https://lttng.org/docs/v2.10/#doc-tracef" rel=3D"noreferrer=
" target=3D"_blank">https://lttng.org/docs/v2.10/#doc-tracef</a><br>
<br>
Thank you,<br>
Francis<br>
<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; What are the problems that make your implementation &quot;error-po=
ne&quot;?<br>
&gt;<br>
&gt;<br>
&gt; Use of regex as above.<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; Would you mind linking us to said project so we can have a look?<b=
r>
&gt;<br>
&gt;<br>
&gt; It&#39;s a project for my employer, and I would need to keep the sourc=
e closed until I can get an OK. A signal of interest from LTTng would be he=
lpful there. In the meantime, I think it would be fine to share as read-onl=
y with the LTTng maintainers if someone wants to send me a Github username.=
<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; I would be interested in seeing at first lttng tracepoint used as =
Francis<br>
&gt;&gt; demonstrated and see from there were this project can go.<br>
&gt;<br>
&gt; ...<br>
&gt;&gt;<br>
&gt;&gt; &gt; I would be happy to contribute some or all of my implementati=
on if it&#39;s<br>
&gt;&gt; &gt; something that the LTTng community would be interested in sup=
porting and<br>
&gt;&gt; &gt; extending.<br>
&gt;&gt;<br>
&gt;&gt; We are clearly open for discussion and helping you improve the pro=
ject. I am not<br>
&gt;&gt; so sure on supporting and extending it. Others might have a differ=
ent opinion.<br>
&gt;<br>
&gt;<br>
&gt; Sounds good. Looking forward to connecting via personal email.<br>
&gt;<br>
&gt; Cheers!<br>
&gt; ~br<br>
&gt;<br>
&gt;<br>
&gt; On Tue, Jan 22, 2019 at 2:17 PM Jonathan Rajotte-Julien &lt;<a href=3D=
"mailto:jonathan.rajotte-julien@efficios.com" target=3D"_blank">jonathan.ra=
jotte-julien@efficios.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hi Brian,<br>
&gt;&gt;<br>
&gt;&gt; On Tue, Jan 22, 2019 at 01:30:23PM -0500, Brian Rossa wrote:<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 4. Boilerplate that does the typical `log(...); =
auto return_val =3D<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 dlsym(...); log(...); return return_val;` gets g=
enerated.<br>
&gt;&gt;<br>
&gt;&gt; As proposed by Francis, this is when you need to &quot;generate&qu=
ot; a corresponding<br>
&gt;&gt; tracepoint definition and call the tracepoint() call with the appr=
opriate<br>
&gt;&gt; arguments.<br>
&gt;&gt;<br>
&gt;&gt; As Francis demonstrated we do not see any reason for lttng-ust not=
 to work here<br>
&gt;&gt; given that you compile the libshim object correctly.<br>
&gt;&gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 5. `log(...)` is a thin interface to spdlog<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 &lt;<a href=3D"https://github.com/gabime/spdlog"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/gabime/spdlog</a>&=
gt; that handles `__attribute__`-based<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 setup and teardown of a logger.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; So at the end of the day, the shim developer provides:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 - The whitelist of mangled names<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 - Implementations of struct &quot;wrappers&quot;=
 that provide custom ostream<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 operators<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 - A map between type names and wrapper names<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; The machinery here seems fairly general-purpose, but I don&#3=
9;t presume to be<br>
&gt;&gt; &gt; an expert. My implementation is somewhat error-prone, and my =
main hope in<br>
&gt;&gt; &gt; reaching out to the mailing list was that LTTng already had s=
ome of these<br>
&gt;&gt; &gt; steps better-implemented.<br>
&gt;&gt;<br>
&gt;&gt; AFAIK, lttng does not have an equivalent.<br>
&gt;&gt;<br>
&gt;&gt; &gt; Step #2 is particularly problematic due to<br>
&gt;&gt; &gt; ambiguities in the mangling grammar, and will need support go=
ing forward to<br>
&gt;&gt; &gt; generalize well.<br>
&gt;&gt;<br>
&gt;&gt; What is the status of this step in your project?<br>
&gt;&gt;<br>
&gt;&gt; What are the problems that make your implementation &quot;error-po=
ne&quot;?<br>
&gt;&gt;<br>
&gt;&gt; Would you mind linking us to said project so we can have a look?<b=
r>
&gt;&gt;<br>
&gt;&gt; I would be interested in seeing at first lttng tracepoint used as =
Francis<br>
&gt;&gt; demonstrated and see from there were this project can go.<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I would be happy to contribute some or all of my implementati=
on if it&#39;s<br>
&gt;&gt; &gt; something that the LTTng community would be interested in sup=
porting and<br>
&gt;&gt; &gt; extending.<br>
&gt;&gt;<br>
&gt;&gt; We are clearly open for discussion and helping you improve the pro=
ject. I am not<br>
&gt;&gt; so sure on supporting and extending it. Others might have a differ=
ent opinion.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Cheers<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Jonathan Rajotte-Julien<br>
&gt;&gt; EfficiOS<br>
<br>
<br>
<br>
-- <br>
Francis Deslauriers<br>
Computer Engineer<br>
EfficiOS inc.<br>
</blockquote></div>
</div></div></div>

--00000000000063d4c70580449f08--

--===============0702175613840597881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0702175613840597881==--
