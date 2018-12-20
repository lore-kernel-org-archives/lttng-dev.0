From: Yonghong Yan <yanyh15@gmail.com>
Subject: Re: TP_ARGS for TRACEPOINT_EVENT_CLASS and
 TRACEPOINT_EVENT_INSTANCE
Date: Thu, 20 Dec 2018 12:21:32 -0500
Message-ID: <CACJEY84HU4jdKWdo_6ZJO88MYhHN7XvQ-2uDSQAjE-6L06zwiw__6486.24456157467$1545326388$gmane$org@mail.gmail.com>
References: <CACJEY862Ytj85N+sidwaq1JEQ+FCiAFo7x5JGuTb992mUrYkdg@mail.gmail.com>
 <CAB4xu_0JxAfA9QtU-NHgtoTOh6c_eT+zQPBvXNr_HZgKE6GvWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1863655459866778394=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by lists.lttng.org (Postfix) with ESMTPS id 43LJTP1DNjz16LJ
 for <lttng-dev@lists.lttng.org>; Thu, 20 Dec 2018 12:21:45 -0500 (EST)
Received: by mail-pl1-x62a.google.com with SMTP id u18so1176817plq.7
 for <lttng-dev@lists.lttng.org>; Thu, 20 Dec 2018 09:21:44 -0800 (PST)
In-Reply-To: <CAB4xu_0JxAfA9QtU-NHgtoTOh6c_eT+zQPBvXNr_HZgKE6GvWA@mail.gmail.com>
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

--===============1863655459866778394==
Content-Type: multipart/alternative; boundary="0000000000004acec4057d775d73"

--0000000000004acec4057d775d73
Content-Type: text/plain; charset="UTF-8"

Then why bother to require to have the TP_ARGS in
TRACEPOINT_EVENT_INSTANCE?

Yonghong

On Thu, Dec 20, 2018 at 11:56 AM Philippe Proulx <eeppeliteloop@gmail.com>
wrote:

> On Thu, Dec 20, 2018 at 11:47 AM Yonghong Yan <yanyh15@gmail.com> wrote:
> >
> > I am looking at the following example from lttng-ust manual. The same
> TP_ARGS ( ... ) are repeated in both the TRACEPOINT_EVENT_CLASS and
> TRACEPOINT_EVENT_INSTANCE definition. My understanding is that it actually
> allows using different arguments, even in this example it is the same. Am I
> right?
>
> No it does not: they need to match.
>
> See <
> https://github.com/lttng/lttng-ust/commit/c75c0422c64f33c0102e1778cecc812c58b700e5
> >.
>
> Phil
>
> >
> > I also like the feature of having one TP_ARGS in the
> TRACEPOINT_EVENT_CLASS that declares the arguments for several
> TRACEPOINT_EVENT_INSTANCE so we do not need to have TP_ARGS in
> TRACEPOINT_EVENT_INSTANCE. Is that possible?
> >
> > Thank you
> > Yonghong
> >
> > TRACEPOINT_EVENT_CLASS(
> >     my_provider,
> >     my_tracepoint_class,
> >     TP_ARGS(
> >         int, my_integer_arg,
> >         struct app_struct *, app_struct_arg
> >     ),
> >     TP_FIELDS(
> >         ctf_integer(int, a, my_integer_arg)
> >         ctf_integer(unsigned long, b, app_struct_arg->b)
> >         ctf_string(c, app_struct_arg->c)
> >     )
> > )
> >
> > TRACEPOINT_EVENT_INSTANCE(
> >     my_provider,
> >     my_tracepoint_class,
> >     event_instance1,
> >     TP_ARGS(
> >         int, my_integer_arg,
> >         struct app_struct *, app_struct_arg
> >     )
> > )
> >
> > TRACEPOINT_EVENT_INSTANCE(
> >     my_provider,
> >     my_tracepoint_class,
> >     event_instance2,
> >     TP_ARGS(
> >         int, my_integer_arg,
> >         struct app_struct *, app_struct_arg
> >     )
> > )
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--0000000000004acec4057d775d73
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr" class=3D"gmail_signature=
" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><div=
>Then why bother to require to have the TP_ARGS in TRACEPOINT_EVENT_INSTANC=
E?=C2=A0</div><div><br></div><div>Yonghong</div><div><br></div></div></div>=
</div></div><div class=3D"gmail_quote"><div dir=3D"ltr">On Thu, Dec 20, 201=
8 at 11:56 AM Philippe Proulx &lt;<a href=3D"mailto:eeppeliteloop@gmail.com=
">eeppeliteloop@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On Thu, Dec 20, 2018 at 11:47 AM Yonghong Yan &lt;=
<a href=3D"mailto:yanyh15@gmail.com" target=3D"_blank">yanyh15@gmail.com</a=
>&gt; wrote:<br>
&gt;<br>
&gt; I am looking at the following example from lttng-ust manual. The same =
TP_ARGS ( ... ) are repeated in both the TRACEPOINT_EVENT_CLASS and TRACEPO=
INT_EVENT_INSTANCE definition. My understanding is that it actually allows =
using different arguments, even in this example it is the same. Am I right?=
<br>
<br>
No it does not: they need to match.<br>
<br>
See &lt;<a href=3D"https://github.com/lttng/lttng-ust/commit/c75c0422c64f33=
c0102e1778cecc812c58b700e5" rel=3D"noreferrer" target=3D"_blank">https://gi=
thub.com/lttng/lttng-ust/commit/c75c0422c64f33c0102e1778cecc812c58b700e5</a=
>&gt;.<br>
<br>
Phil<br>
<br>
&gt;<br>
&gt; I also like the feature of having one TP_ARGS in the TRACEPOINT_EVENT_=
CLASS that declares the arguments for several TRACEPOINT_EVENT_INSTANCE so =
we do not need to have TP_ARGS in TRACEPOINT_EVENT_INSTANCE. Is that possib=
le?<br>
&gt;<br>
&gt; Thank you<br>
&gt; Yonghong<br>
&gt;<br>
&gt; TRACEPOINT_EVENT_CLASS(<br>
&gt;=C2=A0 =C2=A0 =C2=A0my_provider,<br>
&gt;=C2=A0 =C2=A0 =C2=A0my_tracepoint_class,<br>
&gt;=C2=A0 =C2=A0 =C2=A0TP_ARGS(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int, my_integer_arg,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct app_struct *, app_struct_arg<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0),<br>
&gt;=C2=A0 =C2=A0 =C2=A0TP_FIELDS(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctf_integer(int, a, my_integer_arg)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctf_integer(unsigned long, b, app_str=
uct_arg-&gt;b)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctf_string(c, app_struct_arg-&gt;c)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0)<br>
&gt; )<br>
&gt;<br>
&gt; TRACEPOINT_EVENT_INSTANCE(<br>
&gt;=C2=A0 =C2=A0 =C2=A0my_provider,<br>
&gt;=C2=A0 =C2=A0 =C2=A0my_tracepoint_class,<br>
&gt;=C2=A0 =C2=A0 =C2=A0event_instance1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0TP_ARGS(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int, my_integer_arg,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct app_struct *, app_struct_arg<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0)<br>
&gt; )<br>
&gt;<br>
&gt; TRACEPOINT_EVENT_INSTANCE(<br>
&gt;=C2=A0 =C2=A0 =C2=A0my_provider,<br>
&gt;=C2=A0 =C2=A0 =C2=A0my_tracepoint_class,<br>
&gt;=C2=A0 =C2=A0 =C2=A0event_instance2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0TP_ARGS(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int, my_integer_arg,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct app_struct *, app_struct_arg<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0)<br>
&gt; )<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</a><br>
</blockquote></div></div>

--0000000000004acec4057d775d73--

--===============1863655459866778394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1863655459866778394==--
