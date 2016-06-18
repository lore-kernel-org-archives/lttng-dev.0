From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: [PATCH lttng-tools] Fix: sessiond:
 ht_match_event(): check if filter is NULL
Date: Sat, 18 Jun 2016 11:00:18 -0400
Message-ID: <CAB4xu_09NkzJcQj2R6O+fCsgpkyiKsHEYkyvBckNhb9CBTGvEg__8902.45039850033$1466262072$gmane$org@mail.gmail.com>
References: <20160615213417.2946-1-janinesutto@gmail.com>
 <918783794.40478.1466217405502.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2320985558412892776=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-f194.google.com (mail-qk0-f194.google.com
 [209.85.220.194])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 6180EA09FA
 for <lttng-dev@lists.lttng.org>; Sat, 18 Jun 2016 15:00:48 +0000 (UTC)
Received: by mail-qk0-f194.google.com with SMTP id j2so16334865qkf.1
 for <lttng-dev@lists.lttng.org>; Sat, 18 Jun 2016 08:00:48 -0700 (PDT)
In-Reply-To: <918783794.40478.1466217405502.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Philippe Proulx <philippe.proulx@efficios.com>, lttng-dev <lttng-dev@lists.lttng.org>, Janine Sutto <janinesutto@gmail.com>
List-Id: lttng-dev@lists.lttng.org

--===============2320985558412892776==
Content-Type: multipart/alternative; boundary=001a1147f4b27c90eb05358ebc13

--001a1147f4b27c90eb05358ebc13
Content-Type: text/plain; charset=UTF-8

Oh, Janine hijacked my workstation again!

Philippe Proulx

On Fri, Jun 17, 2016 at 10:36 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> Received: from jsutto (cable-192.222.213.99.electronicbox.net.
>
> host mtl.efficios.com
> mtl.efficios.com has address 192.222.213.99
>
> Nice try Phil. ;-)
>
> We'll need the actual contributor name to merge this contribution
> however. I'm pretty sure there is no Mrs. Sutto at EfficiOS.
>
> Thanks,
>
> Mathieu
>
> ----- On Jun 15, 2016, at 5:34 PM, Janine Sutto janinesutto@gmail.com
> wrote:
>
> > It looks like an agent event's filter expression is NULL when
> > it's created with -a, for example:
> >
> >    lttng enable-event -j -a
> >
> > Since there's no check for this in ht_match_event(), strlen()
> > makes the session daemon segfault with this scenario:
> >
> >    lttng create
> >    lttng enable-event -j -a
> >    lttng disable-event -j -a
> >
> > Signed-off-by: Janine Sutto <janinesutto@gmail.com>
> > ---
> > src/bin/lttng-sessiond/agent.c | 11 +++++++++--
> > 1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/src/bin/lttng-sessiond/agent.c
> b/src/bin/lttng-sessiond/agent.c
> > index 8e1ef08..7cbbbde 100644
> > --- a/src/bin/lttng-sessiond/agent.c
> > +++ b/src/bin/lttng-sessiond/agent.c
> > @@ -143,11 +143,18 @@ static int ht_match_event(struct cds_lfht_node
> *node,
> >       }
> >
> >       /* Filter expression */
> > -     if (strncmp(event->filter_expression, key->filter_expression,
> > -                     strlen(event->filter_expression)) != 0) {
> > +     if (!!event->filter_expression ^ !!key->filter_expression) {
> > +             /* One has a filter expression, the other does not */
> >               goto no_match;
> >       }
> >
> > +     if (event->filter_expression) {
> > +             if (strncmp(event->filter_expression,
> key->filter_expression,
> > +                             strlen(event->filter_expression)) != 0) {
> > +                     goto no_match;
> > +             }
> > +     }
> > +
> >       return 1;
> >
> > no_match:
> > --
> > 2.8.3
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--001a1147f4b27c90eb05358ebc13
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Oh, Janine hijacked my workstation again!</div><div class=
=3D"gmail_extra"><br clear=3D"all"><div><div class=3D"gmail_signature" data=
-smartmail=3D"gmail_signature">Philippe Proulx</div></div>
<br><div class=3D"gmail_quote">On Fri, Jun 17, 2016 at 10:36 PM, Mathieu De=
snoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.=
com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span> wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">Received: from jsutto (<a href=3D"http:/=
/cable-192.222.213.99.electronicbox.net" rel=3D"noreferrer" target=3D"_blan=
k">cable-192.222.213.99.electronicbox.net</a>.<br>
<br>
host <a href=3D"http://mtl.efficios.com" rel=3D"noreferrer" target=3D"_blan=
k">mtl.efficios.com</a><br>
<a href=3D"http://mtl.efficios.com" rel=3D"noreferrer" target=3D"_blank">mt=
l.efficios.com</a> has address 192.222.213.99<br>
<br>
Nice try Phil. ;-)<br>
<br>
We&#39;ll need the actual contributor name to merge this contribution<br>
however. I&#39;m pretty sure there is no Mrs. Sutto at EfficiOS.<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
----- On Jun 15, 2016, at 5:34 PM, Janine Sutto <a href=3D"mailto:janinesut=
to@gmail.com">janinesutto@gmail.com</a> wrote:<br>
<br>
&gt; It looks like an agent event&#39;s filter expression is NULL when<br>
&gt; it&#39;s created with -a, for example:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 lttng enable-event -j -a<br>
&gt;<br>
&gt; Since there&#39;s no check for this in ht_match_event(), strlen()<br>
&gt; makes the session daemon segfault with this scenario:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 lttng create<br>
&gt;=C2=A0 =C2=A0 lttng enable-event -j -a<br>
&gt;=C2=A0 =C2=A0 lttng disable-event -j -a<br>
&gt;<br>
&gt; Signed-off-by: Janine Sutto &lt;<a href=3D"mailto:janinesutto@gmail.co=
m">janinesutto@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; src/bin/lttng-sessiond/agent.c | 11 +++++++++--<br>
&gt; 1 file changed, 9 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/src/bin/lttng-sessiond/agent.c b/src/bin/lttng-sessiond/a=
gent.c<br>
&gt; index 8e1ef08..7cbbbde 100644<br>
&gt; --- a/src/bin/lttng-sessiond/agent.c<br>
&gt; +++ b/src/bin/lttng-sessiond/agent.c<br>
&gt; @@ -143,11 +143,18 @@ static int ht_match_event(struct cds_lfht_node *=
node,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Filter expression */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (strncmp(event-&gt;filter_expression, key-&gt;=
filter_expression,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0strlen(event-&gt;filter_expression)) !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!!event-&gt;filter_expression ^ !!key-&gt;fil=
ter_expression) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* One has a filter e=
xpression, the other does not */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto no_match;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (event-&gt;filter_expression) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strncmp(event-&gt=
;filter_expression, key-&gt;filter_expression,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strlen(event-&gt;filter_expression)) !=
=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto no_match;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
&gt;<br>
&gt; no_match:<br>
&gt; --<br>
&gt; 2.8.3<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</a><br>
<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">--<br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">ht=
tp://www.efficios.com</a><br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5">_____________________=
__________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev</a><br>
</div></div></blockquote></div><br></div>

--001a1147f4b27c90eb05358ebc13--

--===============2320985558412892776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2320985558412892776==--
