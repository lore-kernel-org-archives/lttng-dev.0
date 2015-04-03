From: Chidhu R <chid1989@gmail.com>
Subject: Re: Printing complex data types with LTTng
Date: Fri, 3 Apr 2015 13:26:47 -0700
Message-ID: <CAL1ZhOOHWw3BprGNGtOEahAohKvjvy1Zc1mr_DOmo9RyC0ARVw__18923.2114622884$1428092930$gmane$org@mail.gmail.com>
References: <CAL1ZhONSOm9F8GkQ_z9LSkKwPGzg0C-BROu1AmxtCsZJLnzRzg@mail.gmail.com>
 <CA+jJMxuPQWT0qMXdZRRv3Nw_zCf=1MDcKg1EM30itOsnyO9BEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0174330766=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <chid1989@gmail.com>) id 1Ye8Bh-0005Id-KO
 for lttng-dev@lists.lttng.org; Fri, 03 Apr 2015 16:27:39 -0400
Received: by lbbzk7 with SMTP id zk7so68575963lbb.0
 for <lttng-dev@lists.lttng.org>; Fri, 03 Apr 2015 13:27:27 -0700 (PDT)
In-Reply-To: <CA+jJMxuPQWT0qMXdZRRv3Nw_zCf=1MDcKg1EM30itOsnyO9BEA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Philippe Proulx <philippe.proulx@efficios.com>, =?UTF-8?Q?Genevi=C3=A8ve_Bastien?= <genevieve.bastien@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

--===============0174330766==
Content-Type: multipart/alternative; boundary=001a11c350b8e423aa0512d7c68f

--001a11c350b8e423aa0512d7c68f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Great. Thanks for the response. I wish that patch rolls out soon.

BTW, did you mean there is a different approach with the current version of
LTTng?

-- Chid

On Fri, Apr 3, 2015 at 7:28 AM, J=C3=A9r=C3=A9mie Galarneau <
jeremie.galarneau@efficios.com> wrote:

> On Tue, Mar 31, 2015 at 12:39 PM, Chidhu R <chid1989@gmail.com> wrote:
> > Hi,
> >
> > I wanted to know if there is a way to print complex data types, given t=
he
> > pointer to it.
> >
> > For ex,
> >
> > class Msg {
> > int a;
> > char *str
> > };
> >
> > // Create an object for Msg
> > // pass the address of the object to LTTng and make LTTng print the
> values
> > of a and str. I do not want to dereference the pointer and send the
> > individual values. Or, if there is a function which can be written to
> > dereference the values and this function could be called each time I pa=
ss
> > the address of the object is also fine.
> >
> > Is there a way to achieve this with LTTng?
>
> Not for the moment. Genevi=C3=A8ve Bastien (CC-ed) has worked on it and
> proposed a patch set. However, I'm not sure of the status of this
> feature. I think Mathieu wanted to go with a different approach.
>
> Regards,
> J=C3=A9r=C3=A9mie
>
> >
> > Thanks
> > Chid
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
>
>
>
> --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>

--001a11c350b8e423aa0512d7c68f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Great. Thanks for the response. I wish that patch rolls ou=
t soon.<div><br></div><div>BTW, did you mean there is a different approach =
with the current version of LTTng?</div><div><br></div><div>-- Chid</div></=
div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Apr 3=
, 2015 at 7:28 AM, J=C3=A9r=C3=A9mie Galarneau <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:jeremie.galarneau@efficios.com" target=3D"_blank">jeremie.galar=
neau@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><=
div class=3D"HOEnZb"><div class=3D"h5">On Tue, Mar 31, 2015 at 12:39 PM, Ch=
idhu R &lt;<a href=3D"mailto:chid1989@gmail.com">chid1989@gmail.com</a>&gt;=
 wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I wanted to know if there is a way to print complex data types, given =
the<br>
&gt; pointer to it.<br>
&gt;<br>
&gt; For ex,<br>
&gt;<br>
&gt; class Msg {<br>
&gt; int a;<br>
&gt; char *str<br>
&gt; };<br>
&gt;<br>
&gt; // Create an object for Msg<br>
&gt; // pass the address of the object to LTTng and make LTTng print the va=
lues<br>
&gt; of a and str. I do not want to dereference the pointer and send the<br=
>
&gt; individual values. Or, if there is a function which can be written to<=
br>
&gt; dereference the values and this function could be called each time I p=
ass<br>
&gt; the address of the object is also fine.<br>
&gt;<br>
&gt; Is there a way to achieve this with LTTng?<br>
<br>
</div></div>Not for the moment. Genevi=C3=A8ve Bastien (CC-ed) has worked o=
n it and<br>
proposed a patch set. However, I&#39;m not sure of the status of this<br>
feature. I think Mathieu wanted to go with a different approach.<br>
<br>
Regards,<br>
J=C3=A9r=C3=A9mie<br>
<br>
&gt;<br>
&gt; Thanks<br>
&gt; Chid<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
&gt;<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
<br>
--<br>
J=C3=A9r=C3=A9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</font></span></blockquote></div><br></div>

--001a11c350b8e423aa0512d7c68f--


--===============0174330766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0174330766==--
