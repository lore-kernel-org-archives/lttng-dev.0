From: Brian Rossa <br@f0cal.com>
Subject: Re: "Hands-free" tracepoints using LD_PRELOAD
Date: Tue, 29 Jan 2019 17:33:06 -0500
Message-ID: <CAF=Zobw_4A6-fYNiPqY30dWFKY=x0OXZ4EVVwVacmvRGWPZqsg__15236.9739183754$1548801224$gmane$org@mail.gmail.com>
References: <CAF=ZobxSoNuto2U9NTihytCpdNODfH8Bv6JtGCym_g6hg3Uz4w@mail.gmail.com>
 <CADcCL0gLBOs1L0sqOsPg3+nyHp0sVFGK2ymk0-pw4QRGO7UhGw@mail.gmail.com>
 <CAF=ZobwMe56-9nb+o=jYcpJVuhxEsHthLCHrkFt8KhEaK5bODQ@mail.gmail.com>
 <20190122191748.GB17450@joraj-alpa>
 <CAF=ZobxxA5Ms1PbEebpGvCKPn4-WuHAkHb0eqvJYgM_m4YG9_w@mail.gmail.com>
 <CADcCL0iBwaZfFU+R=Nhu-kDZpkxS_018j0xVwz5vh_5tto434w@mail.gmail.com>
 <CAF=Zobz-eX1gXC6EL8q0KFL3tspR8U99yz-kbHcUqkBafA=Meg@mail.gmail.com>
 <CAB4xu_3vz4xbecUg2BPj8QZGDdggO22pzTsDFAXXm9dGQkLfAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1671865659607077499=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by lists.lttng.org (Postfix) with ESMTPS id 43q1VZ0X4hzn1g
 for <lttng-dev@lists.lttng.org>; Tue, 29 Jan 2019 17:33:25 -0500 (EST)
Received: by mail-lf1-x130.google.com with SMTP id l10so15885245lfh.9
 for <lttng-dev@lists.lttng.org>; Tue, 29 Jan 2019 14:33:25 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com.
 [209.85.208.174])
 by smtp.gmail.com with ESMTPSA id y24sm3688692lfj.17.2019.01.29.14.33.21
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 14:33:22 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id t18-v6so18987253ljd.4
 for <lttng-dev@lists.lttng.org>; Tue, 29 Jan 2019 14:33:21 -0800 (PST)
In-Reply-To: <CAB4xu_3vz4xbecUg2BPj8QZGDdggO22pzTsDFAXXm9dGQkLfAw@mail.gmail.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1671865659607077499==
Content-Type: multipart/alternative; boundary="000000000000700e8e0580a0611e"

--000000000000700e8e0580a0611e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok, after further review and some performance analysis on spdlog, I'm
considering skipping the tracef(...) step and jumping to a tracepoint-based
approach. I believe I can use code generation to create both (1) the
tracepoint definitions and (2) function interposition (LD_PRELOAD) shims
calling to #1. This may take some time, but I'll ping this thread if I
encounter any issues. Thanks! ~br

On Fri, Jan 25, 2019 at 9:35 AM Philippe Proulx <eeppeliteloop@gmail.com>
wrote:

> On Fri, Jan 25, 2019 at 4:05 AM Brian Rossa <br@f0cal.com> wrote:
> >
> > Francis,
> >
> > These are great suggestions, thanks!
> >
> >> #Third idea:
> >> Do you know of tracef() [3] ? Using it, you can save any string to a
> >> UST trace. As a first step, you could directly replace your calls to
> >> spdlog by calls to tracef. It's an highly inefficient way of using
> >> LTTng, but it works (and probably lower overhead than writing to a
> >> file).
> >
> >
> > Replacing spdlog::debug(...) with tracef(...) may be an easy way for me
> to get familiar with LTTNg workflows without having to go through a
> complete port.
>
> However please note that spdlog uses {fmt} while tracef() uses a
> vsnprintf()-family function, so you would need to adapt the format
> strings too.
>
> Phil
>
> >
> > This brings up an interesting question, though, and the answer may
> motivate me to close the gap further: What kind of latency reduction can =
I
> expect from moving from spdlog to LLTng? I know this is ill-posed without
> knowing more about how many pseudo-tracepoints I'm implementing, the log
> message sizes that I'm pushing to disk, etc, etc., but something notional
> would help my motivation.
> >
> >>
> >> You mentioned that you wrap structures with ostreams to output them in
> >> text format. Can you explain this a bit more?
> >
> >
> > I'm just implementing what spdlog suggests:
> https://github.com/gabime/spdlog#user-defined-types
> >
> > Cheers!
> > ~br
> >
> > On Thu, Jan 24, 2019 at 11:06 AM Francis Deslauriers <
> francis.deslauriers@efficios.com> wrote:
> >>
> >> "
> >>
> >> Le mer. 23 janv. 2019, =C3=A0 19 h 20, Brian Rossa <br@f0cal.com> a =
=C3=A9crit :
> >> >
> >> > Jonathan,
> >> >
> >> > Responses below:
> >> >
> >> >> AFAIK, lttng does not have an equivalent.
> >> >
> >> >
> >> > I believe my code could significantly reduce the need for
> hand-writing the tracepoints. But I won't likely take on a port to LTTng
> immediately, as a "vanilla" interposition approach seems to be meeting my
> requirements.
> >> >
> >> >>
> >> >> > Step #2 is particularly problematic due to
> >> >> > ambiguities in the mangling grammar, and will need support going
> forward to
> >> >> > generalize well.
> >> >>
> >> >> What is the status of this step in your project?
> >> >
> >> >
> >> > I demangle the symbol name using c++filt and then use regex to
> extract the list of argument types. Using something like
> ItaniumPartialDemangler would be better.
> >>
> >> Hi Brian,
> >>
> >> If you have a list of the argument types, you can programmatically
> >> generate the tracepoint descriptions and callsites accordingly. The
> >> main blocker I see here is tracing arguments that are pointers to
> >> classes or containers. We need to be able to map each argument with a
> >> CTF type [1]. It's easy enough for int, float and char * but it's
> >> harder for complex structs and data structures.
> >>
> >> You mentioned that you wrap structures with ostreams to output them in
> >> text format. Can you explain this a bit more?
> >>
> >> Here are a few ideas:
> >>
> >> #First idea
> >> If you are already defining the printing format and order of each of
> >> the fields of each structures in your libfoo.so maybe you could do the
> >> same but in LTTng-UST format. See "my-custom-structure.h" example [2].
> >>
> >> #Second idea:
> >> If you prefer not convert those ostreams wrappers to ctf wrapper, you
> >> could reuse them to generate CTF_STRINGs.
> >> 1. Simple data types (int, float, char*) are mapped directly to CTF
> types,
> >> 2. Complex data types are wrapped with ostream function,
> >> 3. Complex data types are saved in the trace as CTF_STRING using the
> ostream.
> >> All this could be done by the boilerplate scripts I mentioned earlier.
> >> By using string format for some argument, you don't get the full power
> >> of LTTng but it will still be faster that saving everything in text.
> >>
> >> #Third idea:
> >> Do you know of tracef() [3] ? Using it, you can save any string to a
> >> UST trace. As a first step, you could directly replace your calls to
> >> spdlog by calls to tracef. It's an highly inefficient way of using
> >> LTTng, but it works (and probably lower overhead than writing to a
> >> file).
> >>
> >> [1]: https://lttng.org/man/3/lttng-ust/v2.10/
> >> [2]: https://lttng.org/docs/v2.10/#doc-defining-tracepoints
> >> [3]: https://lttng.org/docs/v2.10/#doc-tracef
> >>
> >> Thank you,
> >> Francis
> >>
> >> >
> >> >>
> >> >> What are the problems that make your implementation "error-pone"?
> >> >
> >> >
> >> > Use of regex as above.
> >> >
> >> >>
> >> >> Would you mind linking us to said project so we can have a look?
> >> >
> >> >
> >> > It's a project for my employer, and I would need to keep the source
> closed until I can get an OK. A signal of interest from LTTng would be
> helpful there. In the meantime, I think it would be fine to share as
> read-only with the LTTng maintainers if someone wants to send me a Github
> username.
> >> >
> >> >>
> >> >> I would be interested in seeing at first lttng tracepoint used as
> Francis
> >> >> demonstrated and see from there were this project can go.
> >> >
> >> > ...
> >> >>
> >> >> > I would be happy to contribute some or all of my implementation i=
f
> it's
> >> >> > something that the LTTng community would be interested in
> supporting and
> >> >> > extending.
> >> >>
> >> >> We are clearly open for discussion and helping you improve the
> project. I am not
> >> >> so sure on supporting and extending it. Others might have a
> different opinion.
> >> >
> >> >
> >> > Sounds good. Looking forward to connecting via personal email.
> >> >
> >> > Cheers!
> >> > ~br
> >> >
> >> >
> >> > On Tue, Jan 22, 2019 at 2:17 PM Jonathan Rajotte-Julien <
> jonathan.rajotte-julien@efficios.com> wrote:
> >> >>
> >> >> Hi Brian,
> >> >>
> >> >> On Tue, Jan 22, 2019 at 01:30:23PM -0500, Brian Rossa wrote:
> >> >> >    4. Boilerplate that does the typical `log(...); auto return_va=
l
> =3D
> >> >> >    dlsym(...); log(...); return return_val;` gets generated.
> >> >>
> >> >> As proposed by Francis, this is when you need to "generate" a
> corresponding
> >> >> tracepoint definition and call the tracepoint() call with the
> appropriate
> >> >> arguments.
> >> >>
> >> >> As Francis demonstrated we do not see any reason for lttng-ust not
> to work here
> >> >> given that you compile the libshim object correctly.
> >> >>
> >> >> >    5. `log(...)` is a thin interface to spdlog
> >> >> >    <https://github.com/gabime/spdlog> that handles
> `__attribute__`-based
> >> >> >    setup and teardown of a logger.
> >> >> >
> >> >> > So at the end of the day, the shim developer provides:
> >> >> >
> >> >> >    - The whitelist of mangled names
> >> >> >    - Implementations of struct "wrappers" that provide custom
> ostream
> >> >> >    operators
> >> >> >    - A map between type names and wrapper names
> >> >> >
> >> >> > The machinery here seems fairly general-purpose, but I don't
> presume to be
> >> >> > an expert. My implementation is somewhat error-prone, and my main
> hope in
> >> >> > reaching out to the mailing list was that LTTng already had some
> of these
> >> >> > steps better-implemented.
> >> >>
> >> >> AFAIK, lttng does not have an equivalent.
> >> >>
> >> >> > Step #2 is particularly problematic due to
> >> >> > ambiguities in the mangling grammar, and will need support going
> forward to
> >> >> > generalize well.
> >> >>
> >> >> What is the status of this step in your project?
> >> >>
> >> >> What are the problems that make your implementation "error-pone"?
> >> >>
> >> >> Would you mind linking us to said project so we can have a look?
> >> >>
> >> >> I would be interested in seeing at first lttng tracepoint used as
> Francis
> >> >> demonstrated and see from there were this project can go.
> >> >>
> >> >> >
> >> >> > I would be happy to contribute some or all of my implementation i=
f
> it's
> >> >> > something that the LTTng community would be interested in
> supporting and
> >> >> > extending.
> >> >>
> >> >> We are clearly open for discussion and helping you improve the
> project. I am not
> >> >> so sure on supporting and extending it. Others might have a
> different opinion.
> >> >>
> >> >>
> >> >> Cheers
> >> >>
> >> >> --
> >> >> Jonathan Rajotte-Julien
> >> >> EfficiOS
> >>
> >>
> >>
> >> --
> >> Francis Deslauriers
> >> Computer Engineer
> >> EfficiOS inc.
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--000000000000700e8e0580a0611e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Ok, after further review and some performance analysi=
s on spdlog, I&#39;m considering skipping the tracef(...) step and jumping =
to a tracepoint-based approach. I believe I can use code generation to crea=
te both (1) the tracepoint definitions and (2) function interposition (LD_P=
RELOAD) shims calling to #1. This may take some time, but I&#39;ll ping thi=
s thread if I encounter any issues. Thanks! ~br<br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 25, 20=
19 at 9:35 AM Philippe Proulx &lt;<a href=3D"mailto:eeppeliteloop@gmail.com=
">eeppeliteloop@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">On Fri, Jan 25, 2019 at 4:05 AM Brian Rossa &lt;<a href=3D"mailto:br@=
f0cal.com" target=3D"_blank">br@f0cal.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Francis,<br>
&gt;<br>
&gt; These are great suggestions, thanks!<br>
&gt;<br>
&gt;&gt; #Third idea:<br>
&gt;&gt; Do you know of tracef() [3] ? Using it, you can save any string to=
 a<br>
&gt;&gt; UST trace. As a first step, you could directly replace your calls =
to<br>
&gt;&gt; spdlog by calls to tracef. It&#39;s an highly inefficient way of u=
sing<br>
&gt;&gt; LTTng, but it works (and probably lower overhead than writing to a=
<br>
&gt;&gt; file).<br>
&gt;<br>
&gt;<br>
&gt; Replacing spdlog::debug(...) with tracef(...) may be an easy way for m=
e to get familiar with LTTNg workflows without having to go through a compl=
ete port.<br>
<br>
However please note that spdlog uses {fmt} while tracef() uses a<br>
vsnprintf()-family function, so you would need to adapt the format<br>
strings too.<br>
<br>
Phil<br>
<br>
&gt;<br>
&gt; This brings up an interesting question, though, and the answer may mot=
ivate me to close the gap further: What kind of latency reduction can I exp=
ect from moving from spdlog to LLTng? I know this is ill-posed without know=
ing more about how many pseudo-tracepoints I&#39;m implementing, the log me=
ssage sizes that I&#39;m pushing to disk, etc, etc., but something notional=
 would help my motivation.<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; You mentioned that you wrap structures with ostreams to output the=
m in<br>
&gt;&gt; text format. Can you explain this a bit more?<br>
&gt;<br>
&gt;<br>
&gt; I&#39;m just implementing what spdlog suggests: <a href=3D"https://git=
hub.com/gabime/spdlog#user-defined-types" rel=3D"noreferrer" target=3D"_bla=
nk">https://github.com/gabime/spdlog#user-defined-types</a><br>
&gt;<br>
&gt; Cheers!<br>
&gt; ~br<br>
&gt;<br>
&gt; On Thu, Jan 24, 2019 at 11:06 AM Francis Deslauriers &lt;<a href=3D"ma=
ilto:francis.deslauriers@efficios.com" target=3D"_blank">francis.deslaurier=
s@efficios.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; &quot;<br>
&gt;&gt;<br>
&gt;&gt; Le mer. 23 janv. 2019, =C3=A0 19 h 20, Brian Rossa &lt;<a href=3D"=
mailto:br@f0cal.com" target=3D"_blank">br@f0cal.com</a>&gt; a =C3=A9crit :<=
br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Jonathan,<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Responses below:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; AFAIK, lttng does not have an equivalent.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I believe my code could significantly reduce the need for han=
d-writing the tracepoints. But I won&#39;t likely take on a port to LTTng i=
mmediately, as a &quot;vanilla&quot; interposition approach seems to be mee=
ting my requirements.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt; Step #2 is particularly problematic due to<br>
&gt;&gt; &gt;&gt; &gt; ambiguities in the mangling grammar, and will need s=
upport going forward to<br>
&gt;&gt; &gt;&gt; &gt; generalize well.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; What is the status of this step in your project?<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I demangle the symbol name using c++filt and then use regex t=
o extract the list of argument types. Using something like ItaniumPartialDe=
mangler would be better.<br>
&gt;&gt;<br>
&gt;&gt; Hi Brian,<br>
&gt;&gt;<br>
&gt;&gt; If you have a list of the argument types, you can programmatically=
<br>
&gt;&gt; generate the tracepoint descriptions and callsites accordingly. Th=
e<br>
&gt;&gt; main blocker I see here is tracing arguments that are pointers to<=
br>
&gt;&gt; classes or containers. We need to be able to map each argument wit=
h a<br>
&gt;&gt; CTF type [1]. It&#39;s easy enough for int, float and char * but i=
t&#39;s<br>
&gt;&gt; harder for complex structs and data structures.<br>
&gt;&gt;<br>
&gt;&gt; You mentioned that you wrap structures with ostreams to output the=
m in<br>
&gt;&gt; text format. Can you explain this a bit more?<br>
&gt;&gt;<br>
&gt;&gt; Here are a few ideas:<br>
&gt;&gt;<br>
&gt;&gt; #First idea<br>
&gt;&gt; If you are already defining the printing format and order of each =
of<br>
&gt;&gt; the fields of each structures in your libfoo.so maybe you could do=
 the<br>
&gt;&gt; same but in LTTng-UST format. See &quot;my-custom-structure.h&quot=
; example [2].<br>
&gt;&gt;<br>
&gt;&gt; #Second idea:<br>
&gt;&gt; If you prefer not convert those ostreams wrappers to ctf wrapper, =
you<br>
&gt;&gt; could reuse them to generate CTF_STRINGs.<br>
&gt;&gt; 1. Simple data types (int, float, char*) are mapped directly to CT=
F types,<br>
&gt;&gt; 2. Complex data types are wrapped with ostream function,<br>
&gt;&gt; 3. Complex data types are saved in the trace as CTF_STRING using t=
he ostream.<br>
&gt;&gt; All this could be done by the boilerplate scripts I mentioned earl=
ier.<br>
&gt;&gt; By using string format for some argument, you don&#39;t get the fu=
ll power<br>
&gt;&gt; of LTTng but it will still be faster that saving everything in tex=
t.<br>
&gt;&gt;<br>
&gt;&gt; #Third idea:<br>
&gt;&gt; Do you know of tracef() [3] ? Using it, you can save any string to=
 a<br>
&gt;&gt; UST trace. As a first step, you could directly replace your calls =
to<br>
&gt;&gt; spdlog by calls to tracef. It&#39;s an highly inefficient way of u=
sing<br>
&gt;&gt; LTTng, but it works (and probably lower overhead than writing to a=
<br>
&gt;&gt; file).<br>
&gt;&gt;<br>
&gt;&gt; [1]: <a href=3D"https://lttng.org/man/3/lttng-ust/v2.10/" rel=3D"n=
oreferrer" target=3D"_blank">https://lttng.org/man/3/lttng-ust/v2.10/</a><b=
r>
&gt;&gt; [2]: <a href=3D"https://lttng.org/docs/v2.10/#doc-defining-tracepo=
ints" rel=3D"noreferrer" target=3D"_blank">https://lttng.org/docs/v2.10/#do=
c-defining-tracepoints</a><br>
&gt;&gt; [3]: <a href=3D"https://lttng.org/docs/v2.10/#doc-tracef" rel=3D"n=
oreferrer" target=3D"_blank">https://lttng.org/docs/v2.10/#doc-tracef</a><b=
r>
&gt;&gt;<br>
&gt;&gt; Thank you,<br>
&gt;&gt; Francis<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; What are the problems that make your implementation &quot=
;error-pone&quot;?<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Use of regex as above.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Would you mind linking us to said project so we can have =
a look?<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; It&#39;s a project for my employer, and I would need to keep =
the source closed until I can get an OK. A signal of interest from LTTng wo=
uld be helpful there. In the meantime, I think it would be fine to share as=
 read-only with the LTTng maintainers if someone wants to send me a Github =
username.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; I would be interested in seeing at first lttng tracepoint=
 used as Francis<br>
&gt;&gt; &gt;&gt; demonstrated and see from there were this project can go.=
<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; ...<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt; I would be happy to contribute some or all of my imp=
lementation if it&#39;s<br>
&gt;&gt; &gt;&gt; &gt; something that the LTTng community would be interest=
ed in supporting and<br>
&gt;&gt; &gt;&gt; &gt; extending.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; We are clearly open for discussion and helping you improv=
e the project. I am not<br>
&gt;&gt; &gt;&gt; so sure on supporting and extending it. Others might have=
 a different opinion.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Sounds good. Looking forward to connecting via personal email=
.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Cheers!<br>
&gt;&gt; &gt; ~br<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; On Tue, Jan 22, 2019 at 2:17 PM Jonathan Rajotte-Julien &lt;<=
a href=3D"mailto:jonathan.rajotte-julien@efficios.com" target=3D"_blank">jo=
nathan.rajotte-julien@efficios.com</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Hi Brian,<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; On Tue, Jan 22, 2019 at 01:30:23PM -0500, Brian Rossa wro=
te:<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 4. Boilerplate that does the typical `l=
og(...); auto return_val =3D<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 dlsym(...); log(...); return return_val=
;` gets generated.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; As proposed by Francis, this is when you need to &quot;ge=
nerate&quot; a corresponding<br>
&gt;&gt; &gt;&gt; tracepoint definition and call the tracepoint() call with=
 the appropriate<br>
&gt;&gt; &gt;&gt; arguments.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; As Francis demonstrated we do not see any reason for lttn=
g-ust not to work here<br>
&gt;&gt; &gt;&gt; given that you compile the libshim object correctly.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 5. `log(...)` is a thin interface to sp=
dlog<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 &lt;<a href=3D"https://github.com/gabim=
e/spdlog" rel=3D"noreferrer" target=3D"_blank">https://github.com/gabime/sp=
dlog</a>&gt; that handles `__attribute__`-based<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 setup and teardown of a logger.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; So at the end of the day, the shim developer provide=
s:<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 - The whitelist of mangled names<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 - Implementations of struct &quot;wrapp=
ers&quot; that provide custom ostream<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 operators<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 - A map between type names and wrapper =
names<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; The machinery here seems fairly general-purpose, but=
 I don&#39;t presume to be<br>
&gt;&gt; &gt;&gt; &gt; an expert. My implementation is somewhat error-prone=
, and my main hope in<br>
&gt;&gt; &gt;&gt; &gt; reaching out to the mailing list was that LTTng alre=
ady had some of these<br>
&gt;&gt; &gt;&gt; &gt; steps better-implemented.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; AFAIK, lttng does not have an equivalent.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt; Step #2 is particularly problematic due to<br>
&gt;&gt; &gt;&gt; &gt; ambiguities in the mangling grammar, and will need s=
upport going forward to<br>
&gt;&gt; &gt;&gt; &gt; generalize well.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; What is the status of this step in your project?<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; What are the problems that make your implementation &quot=
;error-pone&quot;?<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Would you mind linking us to said project so we can have =
a look?<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; I would be interested in seeing at first lttng tracepoint=
 used as Francis<br>
&gt;&gt; &gt;&gt; demonstrated and see from there were this project can go.=
<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; I would be happy to contribute some or all of my imp=
lementation if it&#39;s<br>
&gt;&gt; &gt;&gt; &gt; something that the LTTng community would be interest=
ed in supporting and<br>
&gt;&gt; &gt;&gt; &gt; extending.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; We are clearly open for discussion and helping you improv=
e the project. I am not<br>
&gt;&gt; &gt;&gt; so sure on supporting and extending it. Others might have=
 a different opinion.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Cheers<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; --<br>
&gt;&gt; &gt;&gt; Jonathan Rajotte-Julien<br>
&gt;&gt; &gt;&gt; EfficiOS<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Francis Deslauriers<br>
&gt;&gt; Computer Engineer<br>
&gt;&gt; EfficiOS inc.<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</a><br>
</blockquote></div>

--000000000000700e8e0580a0611e--

--===============1671865659607077499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1671865659607077499==--
