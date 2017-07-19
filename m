From: Nalin Pai <nalinpai@gmail.com>
Subject: Re: lttng questions
Date: Wed, 19 Jul 2017 15:05:13 -0700
Message-ID: <CALVR4zD=Ht8DCc5WnA6YAK-Mub+x1+2ScyUHSbW1Xjn5834ORQ__31221.4302867234$1500561012$gmane$org@mail.gmail.com>
References: <CALVR4zBENdRfGxAPwTuNxUhS5CJgJ5qzzrcnx5vMGZdg7BqmDg@mail.gmail.com>
 <CAB4xu_3Ypj-J17FcBMdKZHMfyKdf=E_3G63EaoARQ3Ur4EcT0Q@mail.gmail.com>
 <CALVR4zDEA9iOEW5hCYaADnPHH2Ev1JoPD+Gdnv4aiphaWQceOQ@mail.gmail.com>
 <CALVR4zDU5L-eLg_ywdmDjCb5j5XeF_Z37Zy+LTVkgnaPHAXmzw@mail.gmail.com>
 <CAB4xu_2skG2wz_Gu24D4r_evk_GpCBeNuVz8v_i4PrL1wmG2dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6659001329416459784=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ua0-x22d.google.com (mail-ua0-x22d.google.com
 [IPv6:2607:f8b0:400c:c08::22d])
 by lists.lttng.org (Postfix) with ESMTPS id 3xCWNg40wwz13rS
 for <lttng-dev@lists.lttng.org>; Wed, 19 Jul 2017 22:07:31 +0000 (UTC)
Received: by mail-ua0-x22d.google.com with SMTP id u4so10146252uaa.1
 for <lttng-dev@lists.lttng.org>; Wed, 19 Jul 2017 15:05:15 -0700 (PDT)
In-Reply-To: <CAB4xu_2skG2wz_Gu24D4r_evk_GpCBeNuVz8v_i4PrL1wmG2dA@mail.gmail.com>
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

--===============6659001329416459784==
Content-Type: multipart/alternative; boundary="001a114ecc249467960554b2d34c"

--001a114ecc249467960554b2d34c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Is there an ETA for 2.11?

-Nalin

On Wed, Jul 19, 2017 at 1:24 PM, Philippe Proulx <eeppeliteloop@gmail.com>
wrote:

> On Wed, Jul 19, 2017 at 3:05 PM, Nalin Pai <nalinpai@gmail.com> wrote:
> > More questions.
> >
> > I notice that filter expression parser does not validate to check if th=
e
> > field-name in the expression is valid or whether the expression value i=
s
> > consistent with the field type (e.g check that expression value is
> integer
> > if field type is integer). Are there any plans of stricter checking of
> > expressions? If the user makes a mistake while typing out the expressio=
n
> is
> > there any feedback to indicate the error?
>
> It cannot be indicated to the user at event rule creation time
> (lttng enable-event) because future events could match an event rule
> you create now.
>
> When a field's type is not what it should be according to the event
> rule's filter expression, then the whole filter expression evaluates to
> 0 (false), thus the whole event rule is considered not satisfied.
>
> >
> > Thanks,
> > Nalin
> >
> > On Wed, Jul 19, 2017 at 10:11 AM, Nalin Pai <nalinpai@gmail.com> wrote:
> >>
> >> Thanks for your answers. I have a question on event filters. We will b=
e
> >> representing IPv6 addresses as arrays of bytes. We would like to be
> able to
> >> filter on IPv6 address fields. Does lttng filtering on arrays and
> sequences?
> >> If yes, then what's the filter expression format for this.
>
> This is an upcoming feature, probably part of 2.11, but I could be wrong
> (about the version).
>
> Phil
>
> >>
> >> Thanks,
> >> Nalin
> >>
> >>
> >>
> >> On Sun, Jul 16, 2017 at 4:49 PM, Philippe Proulx <
> eeppeliteloop@gmail.com>
> >> wrote:
> >>>
> >>> On Sun, Jul 16, 2017 at 2:28 PM, Nalin Pai <nalinpai@gmail.com> wrote=
:
> >>> >
> >>> > Hello,
> >>> >
> >>> > We are looking at using lttng as a solution for all our trace and
> debug
> >>> > requirements. We want to get away from traditional file based strin=
g
> format
> >>> > logging and move to lttng, which then gives us the flexibility of
> dumping
> >>> > the traces to file or the network. With this background, I have
> several
> >>> > questions for the team.
> >>> >
> >>> > 1) CTF supports struct fields. I don=E2=80=99t see any ctf_ macros =
in lttng
> >>> > that will allow us to define tracepoints having struct fields. Is
> there a
> >>> > way to do this that I am missing?
> >>>
> >>> Complex CTF types (except a few very specific exceptions) are not
> >>> supported in LTTng-UST, the user space LTTng tracer. If you need a
> >>> structure data type, then you need to "explode" it, perhaps with fiel=
d
> >>> name prefixes, as of the latest version of LTTng. For example:
> >>> `my_struct_user_id`, `my_struct_msg_id`, `my_struct_msg`.
> >>>
> >>> >
> >>> > 2) Display hints. Sometimes there is a need to display certain fiel=
ds
> >>> > in a particular way, e.g. IP and MAC addresses. While the tracepoin=
t
> >>> > definition for these fields are going to be integers or sequences o=
f
> >>> > integers, we would like babeltrace to display these fields in a
> certain
> >>> > format. Short of modifying babeltrace to recognize these fields by
> their
> >>> > names and handle them specially, is there any other way of achievin=
g
> the
> >>> > same?
> >>>
> >>> In the short- to medium-term, with Babeltrace 2.0 (currently in "pre"
> >>> development stage), you can create your own sink component to do
> >>> something with events. The default textual display is called
> >>> sink.text.pretty. If you need a modified version of this sink
> >>> component class, you could copy its source and create your own
> >>> modified plugin which, as you wrote, would recognize the fields by
> >>> name, etc. You could then run the CLI as such:
> >>>
> >>>     babeltrace /path/to/trace
> >>> --component=3Dsink.my-plugin.my-component-class
> >>>
> >>> I can't comment on Trace Compass/LTTng Scope.
> >>>
> >>> I see no other way for the moment. CTF 2 will have a way to indicate
> >>> that specific fields are to be displayed using a given format string,
> >>> for example, but its specification is not available currently (only a
> >>> proposal is available here
> >>> <http://diamon.org/ctf/files/CTF2-PROP-1.0.html>). Babeltrace 2.1 wil=
l
> >>> support CTF 2, after which a future version of LTTng will produce it.
> >>>
> >>> Phil
> >>>
> >>> >
> >>> > -Nalin
> >>> >
> >>> >
> >>> >
> >>> >
> >>> > _______________________________________________
> >>> > lttng-dev mailing list
> >>> > lttng-dev@lists.lttng.org
> >>> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >>> >
> >>
> >>
> >
>

--001a114ecc249467960554b2d34c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Is there an ETA for 2.11?<div><br></div><div>-Nalin</div><=
/div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Jul =
19, 2017 at 1:24 PM, Philippe Proulx <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:eeppeliteloop@gmail.com" target=3D"_blank">eeppeliteloop@gmail.com</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On Wed, =
Jul 19, 2017 at 3:05 PM, Nalin Pai &lt;<a href=3D"mailto:nalinpai@gmail.com=
">nalinpai@gmail.com</a>&gt; wrote:<br>
&gt; More questions.<br>
&gt;<br>
&gt; I notice that filter expression parser does not validate to check if t=
he<br>
&gt; field-name in the expression is valid or whether the expression value =
is<br>
&gt; consistent with the field type (e.g check that expression value is int=
eger<br>
&gt; if field type is integer). Are there any plans of stricter checking of=
<br>
&gt; expressions? If the user makes a mistake while typing out the expressi=
on is<br>
&gt; there any feedback to indicate the error?<br>
<br>
</span>It cannot be indicated to the user at event rule creation time<br>
(lttng enable-event) because future events could match an event rule<br>
you create now.<br>
<br>
When a field&#39;s type is not what it should be according to the event<br>
rule&#39;s filter expression, then the whole filter expression evaluates to=
<br>
0 (false), thus the whole event rule is considered not satisfied.<br>
<span class=3D""><br>
&gt;<br>
&gt; Thanks,<br>
&gt; Nalin<br>
&gt;<br>
&gt; On Wed, Jul 19, 2017 at 10:11 AM, Nalin Pai &lt;<a href=3D"mailto:nali=
npai@gmail.com">nalinpai@gmail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Thanks for your answers. I have a question on event filters. We wi=
ll be<br>
&gt;&gt; representing IPv6 addresses as arrays of bytes. We would like to b=
e able to<br>
&gt;&gt; filter on IPv6 address fields. Does lttng filtering on arrays and =
sequences?<br>
&gt;&gt; If yes, then what&#39;s the filter expression format for this.<br>
<br>
</span>This is an upcoming feature, probably part of 2.11, but I could be w=
rong<br>
(about the version).<br>
<br>
Phil<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;&gt;<br>
&gt;&gt; Thanks,<br>
&gt;&gt; Nalin<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On Sun, Jul 16, 2017 at 4:49 PM, Philippe Proulx &lt;<a href=3D"ma=
ilto:eeppeliteloop@gmail.com">eeppeliteloop@gmail.com</a>&gt;<br>
&gt;&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On Sun, Jul 16, 2017 at 2:28 PM, Nalin Pai &lt;<a href=3D"mail=
to:nalinpai@gmail.com">nalinpai@gmail.com</a>&gt; wrote:<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; Hello,<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; We are looking at using lttng as a solution for all our t=
race and debug<br>
&gt;&gt;&gt; &gt; requirements. We want to get away from traditional file b=
ased string format<br>
&gt;&gt;&gt; &gt; logging and move to lttng, which then gives us the flexib=
ility of dumping<br>
&gt;&gt;&gt; &gt; the traces to file or the network. With this background, =
I have several<br>
&gt;&gt;&gt; &gt; questions for the team.<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; 1) CTF supports struct fields. I don=E2=80=99t see any ct=
f_ macros in lttng<br>
&gt;&gt;&gt; &gt; that will allow us to define tracepoints having struct fi=
elds. Is there a<br>
&gt;&gt;&gt; &gt; way to do this that I am missing?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Complex CTF types (except a few very specific exceptions) are =
not<br>
&gt;&gt;&gt; supported in LTTng-UST, the user space LTTng tracer. If you ne=
ed a<br>
&gt;&gt;&gt; structure data type, then you need to &quot;explode&quot; it, =
perhaps with field<br>
&gt;&gt;&gt; name prefixes, as of the latest version of LTTng. For example:=
<br>
&gt;&gt;&gt; `my_struct_user_id`, `my_struct_msg_id`, `my_struct_msg`.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; 2) Display hints. Sometimes there is a need to display ce=
rtain fields<br>
&gt;&gt;&gt; &gt; in a particular way, e.g. IP and MAC addresses. While the=
 tracepoint<br>
&gt;&gt;&gt; &gt; definition for these fields are going to be integers or s=
equences of<br>
&gt;&gt;&gt; &gt; integers, we would like babeltrace to display these field=
s in a certain<br>
&gt;&gt;&gt; &gt; format. Short of modifying babeltrace to recognize these =
fields by their<br>
&gt;&gt;&gt; &gt; names and handle them specially, is there any other way o=
f achieving the<br>
&gt;&gt;&gt; &gt; same?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; In the short- to medium-term, with Babeltrace 2.0 (currently i=
n &quot;pre&quot;<br>
&gt;&gt;&gt; development stage), you can create your own sink component to =
do<br>
&gt;&gt;&gt; something with events. The default textual display is called<b=
r>
&gt;&gt;&gt; sink.text.pretty. If you need a modified version of this sink<=
br>
&gt;&gt;&gt; component class, you could copy its source and create your own=
<br>
&gt;&gt;&gt; modified plugin which, as you wrote, would recognize the field=
s by<br>
&gt;&gt;&gt; name, etc. You could then run the CLI as such:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0babeltrace /path/to/trace<br>
&gt;&gt;&gt; --component=3Dsink.my-plugin.my-<wbr>component-class<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I can&#39;t comment on Trace Compass/LTTng Scope.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I see no other way for the moment. CTF 2 will have a way to in=
dicate<br>
&gt;&gt;&gt; that specific fields are to be displayed using a given format =
string,<br>
&gt;&gt;&gt; for example, but its specification is not available currently =
(only a<br>
&gt;&gt;&gt; proposal is available here<br>
&gt;&gt;&gt; &lt;<a href=3D"http://diamon.org/ctf/files/CTF2-PROP-1.0.html"=
 rel=3D"noreferrer" target=3D"_blank">http://diamon.org/ctf/files/<wbr>CTF2=
-PROP-1.0.html</a>&gt;). Babeltrace 2.1 will<br>
&gt;&gt;&gt; support CTF 2, after which a future version of LTTng will prod=
uce it.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Phil<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; -Nalin<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; ______________________________<wbr>_________________<br>
&gt;&gt;&gt; &gt; lttng-dev mailing list<br>
&gt;&gt;&gt; &gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@li=
sts.lttng.org</a><br>
&gt;&gt;&gt; &gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listin=
fo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/=
cgi-<wbr>bin/mailman/listinfo/lttng-dev</a><br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;<br>
</div></div></blockquote></div><br></div>

--001a114ecc249467960554b2d34c--

--===============6659001329416459784==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6659001329416459784==--
