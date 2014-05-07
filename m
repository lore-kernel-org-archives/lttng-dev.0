From: Jessica Foest <jessica.foest@gmail.com>
Subject: Re: babeltrace
Date: Wed, 7 May 2014 19:53:08 -0400
Message-ID: <CAPxN80BRHcyEsVPBAQC-xaaYwZv0Mqzik2SehaXtnrs2Wsdoow__2238.44480137831$1399506848$gmane$org@mail.gmail.com>
References: <CAPxN80BCJuB0u_5pk_a=aWw2gQ99eWK_cRnQ4_Kw6Sf8dEaJCg@mail.gmail.com>
 <534FEA8C.8040504@ericsson.com>
 <CA+jJMxum9CmGNDgkqjW3EVCokWx=f-k-iiAjEsXVfY2EjjxmMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1825557571=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jessica.foest@gmail.com>) id 1WiBeD-0000mo-Qq
 for lttng-dev@lists.lttng.org; Wed, 07 May 2014 19:53:16 -0400
Received: by mail-ob0-f175.google.com with SMTP id wo20so2124292obc.34
 for <lttng-dev@lists.lttng.org>; Wed, 07 May 2014 16:53:08 -0700 (PDT)
In-Reply-To: <CA+jJMxum9CmGNDgkqjW3EVCokWx=f-k-iiAjEsXVfY2EjjxmMg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1825557571==
Content-Type: multipart/alternative; boundary=089e0118226cf987f704f8d810c3

--089e0118226cf987f704f8d810c3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all

i just want to have all the fields in my selected trace represented in a
separated  column.
Because when using TMF for example all fields of the context of the event
are represented in one global field .

i need to have every field in a separate column, that's the point , No
mystery :)

CSV or excel is just a format , but what i need is a way to parse the CTF
trace and get every event and every field of the context with its value
separately.
Can you help me to do it ?



2014-04-17 14:35 GMT-04:00 J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@e=
fficios.com
>:

> On Thu, Apr 17, 2014 at 10:51 AM, Matthew Khouzam
> <matthew.khouzam@ericsson.com> wrote:
> > Hi Jessica,
> >
> > <Shameless plug>How about opening it in TMF and right clicking export t=
o
> > text in the events table?</plug>
> >
>
> The plug may be over, but the shameless tag is still open! ;-)
>
> > I am just curious, why do you need to get out of CTF, if a log is ctf,
> > chances are it's
> > WAaaaaaaAAAAAAAaaaaaAAAAAAAaaaaaaaaaaaaaayYYYYYyyyyYYYyyyYYYyyyYYYyy to
> > big for excel, or even calc.
> >
>
> Good point, I'd be curious to know the use case for converting a
> complete trace to CSV.
>
> J=C3=A9r=C3=A9mie
>
> > br,
> > Matthew
> > On 14-04-16 04:31 PM, Jessica Foest wrote:
> >> Hi all
> >>
> >> i know that the default output format of babeltrace is text .
> >> what are the others output format supported by babeltrace ?
> >>
> >> in my case , i need to convert the CTF log file of lttng to a CSV file
> >> , did tou have any idea about how can i do it ?
> >>
> >> thanks
> >>
> >>
> >> _______________________________________________
> >> lttng-dev mailing list
> >> lttng-dev@lists.lttng.org
> >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>
> --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--089e0118226cf987f704f8d810c3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all=C2=A0<div><br></div><div>i just want to have all th=
e fields in my selected trace represented in a separated =C2=A0column.</div=
><div>Because when using TMF for example all fields of the context of the e=
vent are represented in one global field .</div>
<div><br></div><div>i need to have every field in a separate column, that&#=
39;s the point , No mystery :)</div><div><br></div><div>CSV or excel is jus=
t a format , but what i need is a way to parse the CTF trace and get every =
event and every field of the context with its value separately.</div>
<div>Can you help me to do it ?</div><div><br></div></div><div class=3D"gma=
il_extra"><br><br><div class=3D"gmail_quote">2014-04-17 14:35 GMT-04:00 J=
=C3=A9r=C3=A9mie Galarneau <span dir=3D"ltr">&lt;<a href=3D"mailto:jeremie.=
galarneau@efficios.com" target=3D"_blank">jeremie.galarneau@efficios.com</a=
>&gt;</span>:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"">On Thu, Apr 17, 2014 at 10:5=
1 AM, Matthew Khouzam<br>
&lt;<a href=3D"mailto:matthew.khouzam@ericsson.com">matthew.khouzam@ericsso=
n.com</a>&gt; wrote:<br>
&gt; Hi Jessica,<br>
&gt;<br>
&gt; &lt;Shameless plug&gt;How about opening it in TMF and right clicking e=
xport to<br>
&gt; text in the events table?&lt;/plug&gt;<br>
&gt;<br>
<br>
</div>The plug may be over, but the shameless tag is still open! ;-)<br>
<div class=3D""><br>
&gt; I am just curious, why do you need to get out of CTF, if a log is ctf,=
<br>
&gt; chances are it&#39;s<br>
&gt; WAaaaaaaAAAAAAAaaaaaAAAAAAAaaaaaaaaaaaaaayYYYYYyyyyYYYyyyYYYyyyYYYyy t=
o<br>
&gt; big for excel, or even calc.<br>
&gt;<br>
<br>
</div>Good point, I&#39;d be curious to know the use case for converting a<=
br>
complete trace to CSV.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
J=C3=A9r=C3=A9mie<br>
</font></span><div class=3D"im HOEnZb"><br>
&gt; br,<br>
&gt; Matthew<br>
&gt; On 14-04-16 04:31 PM, Jessica Foest wrote:<br>
&gt;&gt; Hi all<br>
&gt;&gt;<br>
&gt;&gt; i know that the default output format of babeltrace is text .<br>
&gt;&gt; what are the others output format supported by babeltrace ?<br>
&gt;&gt;<br>
&gt;&gt; in my case , i need to convert the CTF log file of lttng to a CSV =
file<br>
&gt;&gt; , did tou have any idea about how can i do it ?<br>
&gt;&gt;<br>
&gt;&gt; thanks<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; lttng-dev mailing list<br>
&gt;&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng=
.org</a><br>
&gt;&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-d=
ev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng=
-dev</a><br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
<br>
<br>
<br>
</div><div class=3D"im HOEnZb">--<br>
J=C3=A9r=C3=A9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
<br>
</div><div class=3D"HOEnZb"><div class=3D"h5">_____________________________=
__________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
</div></div></blockquote></div><br></div>

--089e0118226cf987f704f8d810c3--


--===============1825557571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1825557571==--
