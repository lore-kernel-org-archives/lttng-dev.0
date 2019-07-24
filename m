From: Ravindra Kumar Meena <rmeena840@gmail.com>
Subject: Re: What is _prev_state in sched_switch?
Date: Wed, 24 Jul 2019 19:39:11 +0530
Message-ID: <CAEWVvOSu4vbiDpMCCTHdP59xNaMsAJ74orA52amRaFfoN7jfXQ__18172.3439645552$1563977385$gmane$org@mail.gmail.com>
References: <CAEWVvOS48D3Jfp4==qrrODzdSSjo+-UOuvZyya1O_f2t9B9Z1A@mail.gmail.com>
 <0e850b02-3fec-a335-3f37-8579ad1b704d@gydle.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4729499133926769790=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by lists.lttng.org (Postfix) with ESMTPS id 45txzp1kLFz1G79
 for <lttng-dev@lists.lttng.org>; Wed, 24 Jul 2019 10:09:26 -0400 (EDT)
Received: by mail-wm1-x330.google.com with SMTP id 207so41989993wma.1
 for <lttng-dev@lists.lttng.org>; Wed, 24 Jul 2019 07:09:26 -0700 (PDT)
In-Reply-To: <0e850b02-3fec-a335-3f37-8579ad1b704d@gydle.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Sebastien Boisvert <sboisvert@gydle.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============4729499133926769790==
Content-Type: multipart/alternative; boundary="00000000000041c78e058e6ddb76"

--00000000000041c78e058e6ddb76
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 24, 2019, 7:33 PM Sebastien Boisvert <sboisvert@gydle.com>
wrote:

>
>
> On 2019-07-24 2:44 a.m., Ravindra Kumar Meena wrote:
> > Hi,
> >
> > I had a looked at TraceCompass example. I came across sched_swithc event
> in present in the metadata.
> >
> > event {
> > name = "sched_switch";
> > id = 27;
> > stream_id = 0;
> > fields := struct {
> > integer { size = 8; align = 8; signed = 0; encoding = UTF8; base = 10; }
> _prev_comm[16];
> > integer { size = 32; align = 8; signed = 1; encoding = none; base = 10;
> } _prev_tid;
> > integer { size = 32; align = 8; signed = 1; encoding = none; base = 10;
> } _prev_prio;
> > integer { size = 64; align = 8; signed = 1; encoding = none; base = 10;
> } _prev_state;
> > integer { size = 8; align = 8; signed = 0; encoding = UTF8; base = 10; }
> _next_comm[16];
> > integer { size = 32; align = 8; signed = 1; encoding = none; base = 10;
> } _next_tid;
> > integer { size = 32; align = 8; signed = 1; encoding = none; base = 10;
> } _next_prio;
> > };
> > };
> >
> > All event.fields variables are clear to me but what does _prev_state do
> here? I had a looked at its babeltrace output but found no pattern in
> _prev_state value.
> >
> > Please attend this email ASAP.
>
> I think that writing "Please attend this email ASAP" is somehow rude.
>
Okay. Sorry for that. It won't happen again.

I want to know what _prev_state means in sched_switch event.

>

--00000000000041c78e058e6ddb76
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Jul 24, 2019, 7:33 PM Sebastien Boisvert &lt;<=
a href=3D"mailto:sboisvert@gydle.com">sboisvert@gydle.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><br>
<br>
On 2019-07-24 2:44 a.m., Ravindra Kumar Meena wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; I had a looked at TraceCompass example. I came across sched_swithc eve=
nt in present in the metadata.<br>
&gt; <br>
&gt; event {<br>
&gt; name =3D &quot;sched_switch&quot;;<br>
&gt; id =3D 27;<br>
&gt; stream_id =3D 0;<br>
&gt; fields :=3D struct {<br>
&gt; integer { size =3D 8; align =3D 8; signed =3D 0; encoding =3D UTF8; ba=
se =3D 10; } _prev_comm[16];<br>
&gt; integer { size =3D 32; align =3D 8; signed =3D 1; encoding =3D none; b=
ase =3D 10; } _prev_tid;<br>
&gt; integer { size =3D 32; align =3D 8; signed =3D 1; encoding =3D none; b=
ase =3D 10; } _prev_prio;<br>
&gt; integer { size =3D 64; align =3D 8; signed =3D 1; encoding =3D none; b=
ase =3D 10; } _prev_state;<br>
&gt; integer { size =3D 8; align =3D 8; signed =3D 0; encoding =3D UTF8; ba=
se =3D 10; } _next_comm[16];<br>
&gt; integer { size =3D 32; align =3D 8; signed =3D 1; encoding =3D none; b=
ase =3D 10; } _next_tid;<br>
&gt; integer { size =3D 32; align =3D 8; signed =3D 1; encoding =3D none; b=
ase =3D 10; } _next_prio;<br>
&gt; };<br>
&gt; };<br>
&gt; <br>
&gt; All event.fields variables are clear to me but what does _prev_state d=
o here? I had a looked at its babeltrace output but found no pattern in _pr=
ev_state value.<br>
&gt; <br>
&gt; Please attend this email ASAP.<br>
<br>
I think that writing &quot;Please attend this email ASAP&quot; is somehow r=
ude.<br></blockquote></div></div><div dir=3D"auto">Okay. Sorry for that. It=
 won&#39;t happen again.</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>I want to know what=C2=A0_prev_state means in sched_switch event.</div><di=
v dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--00000000000041c78e058e6ddb76--

--===============4729499133926769790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4729499133926769790==--
