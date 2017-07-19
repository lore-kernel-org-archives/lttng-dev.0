From: Nalin Pai <nalinpai@gmail.com>
Subject: Re: lttng questions
Date: Wed, 19 Jul 2017 12:05:35 -0700
Message-ID: <CALVR4zDU5L-eLg_ywdmDjCb5j5XeF_Z37Zy+LTVkgnaPHAXmzw__6519.88183749399$1500560961$gmane$org@mail.gmail.com>
References: <CALVR4zBENdRfGxAPwTuNxUhS5CJgJ5qzzrcnx5vMGZdg7BqmDg@mail.gmail.com>
 <CAB4xu_3Ypj-J17FcBMdKZHMfyKdf=E_3G63EaoARQ3Ur4EcT0Q@mail.gmail.com>
 <CALVR4zDEA9iOEW5hCYaADnPHH2Ev1JoPD+Gdnv4aiphaWQceOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5628787058977508155=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ua0-x22a.google.com (mail-ua0-x22a.google.com
 [IPv6:2607:f8b0:400c:c08::22a])
 by lists.lttng.org (Postfix) with ESMTPS id 3xCRPP4zN6z13dC
 for <lttng-dev@lists.lttng.org>; Wed, 19 Jul 2017 19:07:53 +0000 (UTC)
Received: by mail-ua0-x22a.google.com with SMTP id f9so6755198uaf.4
 for <lttng-dev@lists.lttng.org>; Wed, 19 Jul 2017 12:05:37 -0700 (PDT)
In-Reply-To: <CALVR4zDEA9iOEW5hCYaADnPHH2Ev1JoPD+Gdnv4aiphaWQceOQ@mail.gmail.com>
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

--===============5628787058977508155==
Content-Type: multipart/alternative; boundary="94eb2c07ddc224c4ba0554b051d3"

--94eb2c07ddc224c4ba0554b051d3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

More questions.

I notice that filter expression parser does not validate to check if the
field-name in the expression is valid or whether the expression value is
consistent with the field type (e.g check that expression value is integer
if field type is integer). Are there any plans of stricter checking of
expressions? If the user makes a mistake while typing out the expression is
there any feedback to indicate the error?

Thanks,
Nalin

On Wed, Jul 19, 2017 at 10:11 AM, Nalin Pai <nalinpai@gmail.com> wrote:

> Thanks for your answers. I have a question on event filters. We will be
> representing IPv6 addresses as arrays of bytes. We would like to be able =
to
> filter on IPv6 address fields. Does lttng filtering on arrays and
> sequences? If yes, then what's the filter expression format for this.
>
> Thanks,
> Nalin
>
>
>
> On Sun, Jul 16, 2017 at 4:49 PM, Philippe Proulx <eeppeliteloop@gmail.com=
>
> wrote:
>
>> On Sun, Jul 16, 2017 at 2:28 PM, Nalin Pai <nalinpai@gmail.com> wrote:
>> >
>> > Hello,
>> >
>> > We are looking at using lttng as a solution for all our trace and debu=
g
>> requirements. We want to get away from traditional file based string for=
mat
>> logging and move to lttng, which then gives us the flexibility of dumpin=
g
>> the traces to file or the network. With this background, I have several
>> questions for the team.
>> >
>> > 1) CTF supports struct fields. I don=E2=80=99t see any ctf_ macros in =
lttng
>> that will allow us to define tracepoints having struct fields. Is there =
a
>> way to do this that I am missing?
>>
>> Complex CTF types (except a few very specific exceptions) are not
>> supported in LTTng-UST, the user space LTTng tracer. If you need a
>> structure data type, then you need to "explode" it, perhaps with field
>> name prefixes, as of the latest version of LTTng. For example:
>> `my_struct_user_id`, `my_struct_msg_id`, `my_struct_msg`.
>>
>> >
>> > 2) Display hints. Sometimes there is a need to display certain fields
>> in a particular way, e.g. IP and MAC addresses. While the tracepoint
>> definition for these fields are going to be integers or sequences of
>> integers, we would like babeltrace to display these fields in a certain
>> format. Short of modifying babeltrace to recognize these fields by their
>> names and handle them specially, is there any other way of achieving the
>> same?
>>
>> In the short- to medium-term, with Babeltrace 2.0 (currently in "pre"
>> development stage), you can create your own sink component to do
>> something with events. The default textual display is called
>> sink.text.pretty. If you need a modified version of this sink
>> component class, you could copy its source and create your own
>> modified plugin which, as you wrote, would recognize the fields by
>> name, etc. You could then run the CLI as such:
>>
>>     babeltrace /path/to/trace --component=3Dsink.my-plugin.my-
>> component-class
>>
>> I can't comment on Trace Compass/LTTng Scope.
>>
>> I see no other way for the moment. CTF 2 will have a way to indicate
>> that specific fields are to be displayed using a given format string,
>> for example, but its specification is not available currently (only a
>> proposal is available here
>> <http://diamon.org/ctf/files/CTF2-PROP-1.0.html>). Babeltrace 2.1 will
>> support CTF 2, after which a future version of LTTng will produce it.
>>
>> Phil
>>
>> >
>> > -Nalin
>> >
>> >
>> >
>> >
>> > _______________________________________________
>> > lttng-dev mailing list
>> > lttng-dev@lists.lttng.org
>> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>> >
>>
>
>

--94eb2c07ddc224c4ba0554b051d3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">More questions.<div><br></div><div>I notice that filter ex=
pression parser does not validate to check if the field-name in the express=
ion is valid or whether the expression value is consistent with the field t=
ype (e.g check that expression value is integer if field type is integer). =
Are there any plans of stricter checking of expressions? If the user makes =
a mistake while typing out the expression is there any feedback to indicate=
 the error?</div><div><br></div><div>Thanks,</div><div>Nalin</div></div><di=
v class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Jul 19, 2017=
 at 10:11 AM, Nalin Pai <span dir=3D"ltr">&lt;<a href=3D"mailto:nalinpai@gm=
ail.com" target=3D"_blank">nalinpai@gmail.com</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex"><div dir=3D"ltr">Thanks for your answers. I have=
 a question on event filters. We will be representing IPv6 addresses as arr=
ays of bytes. We would like to be able to filter on IPv6 address fields. Do=
es lttng filtering on arrays and sequences? If yes, then what&#39;s the fil=
ter expression format for this.<div><br></div><div>Thanks,</div><div>Nalin<=
br><div><br></div><div><br></div></div></div><div class=3D"HOEnZb"><div cla=
ss=3D"h5"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Sun,=
 Jul 16, 2017 at 4:49 PM, Philippe Proulx <span dir=3D"ltr">&lt;<a href=3D"=
mailto:eeppeliteloop@gmail.com" target=3D"_blank">eeppeliteloop@gmail.com</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span>On Sun, Jul 16=
, 2017 at 2:28 PM, Nalin Pai &lt;<a href=3D"mailto:nalinpai@gmail.com" targ=
et=3D"_blank">nalinpai@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hello,<br>
&gt;<br>
&gt; We are looking at using lttng as a solution for all our trace and debu=
g requirements. We want to get away from traditional file based string form=
at logging and move to lttng, which then gives us the flexibility of dumpin=
g the traces to file or the network. With this background, I have several q=
uestions for the team.<br>
&gt;<br>
&gt; 1) CTF supports struct fields. I don=E2=80=99t see any ctf_ macros in =
lttng that will allow us to define tracepoints having struct fields. Is the=
re a way to do this that I am missing?<br>
<br>
</span>Complex CTF types (except a few very specific exceptions) are not<br=
>
supported in LTTng-UST, the user space LTTng tracer. If you need a<br>
structure data type, then you need to &quot;explode&quot; it, perhaps with =
field<br>
name prefixes, as of the latest version of LTTng. For example:<br>
`my_struct_user_id`, `my_struct_msg_id`, `my_struct_msg`.<br>
<span><br>
&gt;<br>
&gt; 2) Display hints. Sometimes there is a need to display certain fields =
in a particular way, e.g. IP and MAC addresses. While the tracepoint defini=
tion for these fields are going to be integers or sequences of integers, we=
 would like babeltrace to display these fields in a certain format. Short o=
f modifying babeltrace to recognize these fields by their names and handle =
them specially, is there any other way of achieving the same?<br>
<br>
</span>In the short- to medium-term, with Babeltrace 2.0 (currently in &quo=
t;pre&quot;<br>
development stage), you can create your own sink component to do<br>
something with events. The default textual display is called<br>
sink.text.pretty. If you need a modified version of this sink<br>
component class, you could copy its source and create your own<br>
modified plugin which, as you wrote, would recognize the fields by<br>
name, etc. You could then run the CLI as such:<br>
<br>
=C2=A0 =C2=A0 babeltrace /path/to/trace --component=3Dsink.my-plugin.my-<wb=
r>component-class<br>
<br>
I can&#39;t comment on Trace Compass/LTTng Scope.<br>
<br>
I see no other way for the moment. CTF 2 will have a way to indicate<br>
that specific fields are to be displayed using a given format string,<br>
for example, but its specification is not available currently (only a<br>
proposal is available here<br>
&lt;<a href=3D"http://diamon.org/ctf/files/CTF2-PROP-1.0.html" rel=3D"noref=
errer" target=3D"_blank">http://diamon.org/ctf/files/C<wbr>TF2-PROP-1.0.htm=
l</a>&gt;). Babeltrace 2.1 will<br>
support CTF 2, after which a future version of LTTng will produce it.<br>
<br>
Phil<br>
<br>
&gt;<br>
&gt; -Nalin<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; ______________________________<wbr>_________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bi<wbr>n/=
mailman/listinfo/lttng-dev</a><br>
&gt;<br>
</blockquote></div><br></div>
</div></div></blockquote></div><br></div>

--94eb2c07ddc224c4ba0554b051d3--

--===============5628787058977508155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5628787058977508155==--
