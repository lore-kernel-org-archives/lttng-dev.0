From: Jessica Foest <jessica.foest@gmail.com>
Subject: Re: babeltrace
Date: Tue, 13 May 2014 15:27:44 -0400
Message-ID: <CAPxN80Dv4oPhVT=xVNQ0i5b37as4U_i42Xogpp-tCFpBq4WkBg__16160.6568879963$1400009332$gmane$org@mail.gmail.com>
References: <CAPxN80BCJuB0u_5pk_a=aWw2gQ99eWK_cRnQ4_Kw6Sf8dEaJCg@mail.gmail.com>
 <534FEA8C.8040504@ericsson.com>
 <CA+jJMxum9CmGNDgkqjW3EVCokWx=f-k-iiAjEsXVfY2EjjxmMg@mail.gmail.com>
 <CAPxN80BRHcyEsVPBAQC-xaaYwZv0Mqzik2SehaXtnrs2Wsdoow@mail.gmail.com>
 <536B2BA4.7060107@voxpopuli.im>
 <CAFXXi0=C3_fSHUNsGYu3xPw8oS84A=bRyeig0R714GfPsvc6=g@mail.gmail.com>
 <536BA864.10608@voxpopuli.im>
 <CAPxN80DHt6nMQjL24szbZsYbkd1du97ExokjPBQX40QwuX70+w@mail.gmail.com>
 <CAPxN80CzV2Y9XJkrqv+vzFOF40OLm1tf7Grgh+n0MOR_UuMmdg@mail.gmail.com>
 <CAPxN80CigEdS6x6EE1czpShX1v8cqXh4TwXfY-=_3NuyQLxkKA@mail.gmail.com>
 <CA+jJMxvvhQsQsuN_AbR9_+Zf3qGTkJK7e9y0fwTbiVES_W0Wzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1259833156=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jessica.foest@gmail.com>) id 1WkIMf-0006OC-UQ
 for lttng-dev@lists.lttng.org; Tue, 13 May 2014 15:27:55 -0400
Received: by mail-ob0-f172.google.com with SMTP id wp18so958065obc.31
 for <lttng-dev@lists.lttng.org>; Tue, 13 May 2014 12:27:44 -0700 (PDT)
In-Reply-To: <CA+jJMxvvhQsQsuN_AbR9_+Zf3qGTkJK7e9y0fwTbiVES_W0Wzg@mail.gmail.com>
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

--===============1259833156==
Content-Type: multipart/alternative; boundary=001a1134a210e2d01004f94d0e07

--001a1134a210e2d01004f94d0e07
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thanks a lot J=C3=A9r=C3=A9mie :)


2014-05-13 14:48 GMT-04:00 J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@e=
fficios.com
>:

> Hi Jessica,
>
> I suggest you start by looking at this example in Babeltrace's
> tree[1]. These will show you how to read a CTF trace's events from a
> Python script.
>
> As for formatting the events as CSV, there is a section dedicated to
> this topic in Python's documentation [2].
>
> Regards,
> J=C3=A9r=C3=A9mie
>
> [1]
> https://bugs.lttng.org/projects/babeltrace/repository/revisions/master/en=
try/bindings/python/examples/example-api-test.py
> [2] https://docs.python.org/3.4/library/csv.html
>
> On Mon, May 12, 2014 at 7:24 PM, Jessica Foest <jessica.foest@gmail.com>
> wrote:
> > Thanks for your detailed responses :)
> > Actually i will begin by taking my own trace that i will configure it i=
n
> > advance ( same event type , and i will add the different event context
> that
> > i need ) .
> > It's my first time to develop with python and i don't really know the
> > architecture of babeltrace , So can you help me and tell me how to
> proceed
> > to filter my data from CTF to the output Format that i will choose ?
> > I'm only interested on kernel space tracing .
> >
> >
> > 2014-05-08 17:29 GMT-04:00 Jessica Foest <jessica.foest@gmail.com>:
> >
> >> i work only on kernel space event .
> >>
> >>
> >> 2014-05-08 17:10 GMT-04:00 Jessica Foest <jessica.foest@gmail.com>:
> >>
> >>> Thanks for your detailed responses :)
> >>> Actually i will begin by taking my own trace that i will configure it
> in
> >>> advance ( same event type , and i will add the different event contex=
t
> that
> >>> i need ) .
> >>> It's my first time to develop with python and i don't really know the
> >>> architecture of babeltrace , So can you help me and tell me how to
> proceed
> >>> to filter my data from CTF to the output Format that i will choose ?
> >>>
> >>>
> >>> 2014-05-08 11:53 GMT-04:00 Alexandre Montplaisir
> >>> <alexmonthy@voxpopuli.im>:
> >>>
> >>>>
> >>>>> To avoid doing a complete first pass of the trace, you can just
> >>>>> iterate on the event types as described in the metadata, and take
> note
> >>>>> of all the possible field you can find in the trace. Then, during
> your
> >>>>> only pass, you already know all your "columns".
> >>>>
> >>>>
> >>>> That's true. Although right now TMF doesn't have an API to ask a tra=
ce
> >>>> "give me all the event types you have", other than just reading the
> trace ;)
> >>>>
> >>>> wrt CTF, it's possible to have events in the metadata that don't
> >>>> actually show up in the trace. But that's not really a problem, at
> worst
> >>>> you'd end up with empty columns.
> >>>
> >>>
> >>
> >
>
>
>
> --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>

--001a1134a210e2d01004f94d0e07
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks a lot J=C3=A9r=C3=A9mie :)</div><div class=3D"gmail=
_extra"><br><br><div class=3D"gmail_quote">2014-05-13 14:48 GMT-04:00 J=C3=
=A9r=C3=A9mie Galarneau <span dir=3D"ltr">&lt;<a href=3D"mailto:jeremie.gal=
arneau@efficios.com" target=3D"_blank">jeremie.galarneau@efficios.com</a>&g=
t;</span>:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Jessica,<br>
<br>
I suggest you start by looking at this example in Babeltrace&#39;s<br>
tree[1]. These will show you how to read a CTF trace&#39;s events from a<br=
>
Python script.<br>
<br>
As for formatting the events as CSV, there is a section dedicated to<br>
this topic in Python&#39;s documentation [2].<br>
<br>
Regards,<br>
J=C3=A9r=C3=A9mie<br>
<br>
[1] <a href=3D"https://bugs.lttng.org/projects/babeltrace/repository/revisi=
ons/master/entry/bindings/python/examples/example-api-test.py" target=3D"_b=
lank">https://bugs.lttng.org/projects/babeltrace/repository/revisions/maste=
r/entry/bindings/python/examples/example-api-test.py</a><br>

[2] <a href=3D"https://docs.python.org/3.4/library/csv.html" target=3D"_bla=
nk">https://docs.python.org/3.4/library/csv.html</a><br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
On Mon, May 12, 2014 at 7:24 PM, Jessica Foest &lt;<a href=3D"mailto:jessic=
a.foest@gmail.com">jessica.foest@gmail.com</a>&gt; wrote:<br>
&gt; Thanks for your detailed responses :)<br>
&gt; Actually i will begin by taking my own trace that i will configure it =
in<br>
&gt; advance ( same event type , and i will add the different event context=
 that<br>
&gt; i need ) .<br>
&gt; It&#39;s my first time to develop with python and i don&#39;t really k=
now the<br>
&gt; architecture of babeltrace , So can you help me and tell me how to pro=
ceed<br>
&gt; to filter my data from CTF to the output Format that i will choose ?<b=
r>
&gt; I&#39;m only interested on kernel space tracing .<br>
&gt;<br>
&gt;<br>
&gt; 2014-05-08 17:29 GMT-04:00 Jessica Foest &lt;<a href=3D"mailto:jessica=
.foest@gmail.com">jessica.foest@gmail.com</a>&gt;:<br>
&gt;<br>
&gt;&gt; i work only on kernel space event .<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; 2014-05-08 17:10 GMT-04:00 Jessica Foest &lt;<a href=3D"mailto:jes=
sica.foest@gmail.com">jessica.foest@gmail.com</a>&gt;:<br>
&gt;&gt;<br>
&gt;&gt;&gt; Thanks for your detailed responses :)<br>
&gt;&gt;&gt; Actually i will begin by taking my own trace that i will confi=
gure it in<br>
&gt;&gt;&gt; advance ( same event type , and i will add the different event=
 context that<br>
&gt;&gt;&gt; i need ) .<br>
&gt;&gt;&gt; It&#39;s my first time to develop with python and i don&#39;t =
really know the<br>
&gt;&gt;&gt; architecture of babeltrace , So can you help me and tell me ho=
w to proceed<br>
&gt;&gt;&gt; to filter my data from CTF to the output Format that i will ch=
oose ?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; 2014-05-08 11:53 GMT-04:00 Alexandre Montplaisir<br>
&gt;&gt;&gt; &lt;<a href=3D"mailto:alexmonthy@voxpopuli.im">alexmonthy@voxp=
opuli.im</a>&gt;:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; To avoid doing a complete first pass of the trace, you=
 can just<br>
&gt;&gt;&gt;&gt;&gt; iterate on the event types as described in the metadat=
a, and take note<br>
&gt;&gt;&gt;&gt;&gt; of all the possible field you can find in the trace. T=
hen, during your<br>
&gt;&gt;&gt;&gt;&gt; only pass, you already know all your &quot;columns&quo=
t;.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; That&#39;s true. Although right now TMF doesn&#39;t have a=
n API to ask a trace<br>
&gt;&gt;&gt;&gt; &quot;give me all the event types you have&quot;, other th=
an just reading the trace ;)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; wrt CTF, it&#39;s possible to have events in the metadata =
that don&#39;t<br>
&gt;&gt;&gt;&gt; actually show up in the trace. But that&#39;s not really a=
 problem, at worst<br>
&gt;&gt;&gt;&gt; you&#39;d end up with empty columns.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;<br>
<br>
<br>
<br>
</div></div><div class=3D"HOEnZb"><div class=3D"h5">--<br>
J=C3=A9r=C3=A9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</div></div></blockquote></div><br></div>

--001a1134a210e2d01004f94d0e07--


--===============1259833156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1259833156==--
