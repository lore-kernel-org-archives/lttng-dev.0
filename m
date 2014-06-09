From: "Brosseau, Yannick" <yannick.brosseau@gmail.com>
Subject: Re: babeltrace test failures on some architectures
Date: Mon, 9 Jun 2014 10:32:23 -0400
Message-ID: <CAEzWAeLEvv8FbHfwq8=sMeDW49DjO_gKoZ99z1Ff9s+dR6GuJQ__35586.7974729792$1402324412$gmane$org@mail.gmail.com>
References: <20140604184126.GA26877@helmut>
 <CA+jJMxtn8XiLjT5NVURv5K8kECPPoPs1WF-0zTakJmRW=CO3mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1454304826=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <yannick.brosseau@gmail.com>) id 1Wu0cf-0000ag-2v
 for lttng-dev@lists.lttng.org; Mon, 09 Jun 2014 10:32:35 -0400
Received: by mail-qa0-f43.google.com with SMTP id m5so8007392qaj.30
 for <lttng-dev@lists.lttng.org>; Mon, 09 Jun 2014 07:32:23 -0700 (PDT)
In-Reply-To: <CA+jJMxtn8XiLjT5NVURv5K8kECPPoPs1WF-0zTakJmRW=CO3mg@mail.gmail.com>
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

--===============1454304826==
Content-Type: multipart/alternative; boundary=001a11c16ba85aea4404fb681408

--001a11c16ba85aea4404fb681408
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

J=C3=A9r=C3=A9mie, the end of the build.log seem to contains the tests outp=
ut.


On Mon, Jun 9, 2014 at 10:16 AM, J=C3=A9r=C3=A9mie Galarneau <
jeremie.galarneau@efficios.com> wrote:

> Hi Jon,
>
> Would it be possible to run the tests on these machines and provide
> the TAP output?
>
> Thanks,
> J=C3=A9r=C3=A9mie
>
> On Wed, Jun 4, 2014 at 2:41 PM, Jon Bernard <jbernard@debian.org> wrote:
> > I noticed babeltrace is having test failures on armel, hurd-i386,
> > kfreebsd-{amd64,i386}, and sparc.  These were passing in version 1.1 an=
d
> > the failures appeared in 1.2.  Here are links to the build logs:
> >
> >     armel:
> https://buildd.debian.org/status/fetch.php?pkg=3Dbabeltrace&arch=3Darmel&=
ver=3D1.2.1-2&stamp=3D1395846913
> >     hurd-i386:
> https://buildd.debian.org/status/fetch.php?pkg=3Dbabeltrace&arch=3Dhurd-i=
386&ver=3D1.2.1-2&stamp=3D1398158394
> >     kfreebsd-amd64:
> https://buildd.debian.org/status/architecture.php?a=3Dkfreebsd-amd64&suit=
e=3Dsid
> >     kfreebsd-i386:
> https://buildd.debian.org/status/fetch.php?pkg=3Dbabeltrace&arch=3Dkfreeb=
sd-i386&ver=3D1.2.1-2&stamp=3D1395842518
> >     sparc:
> https://buildd.debian.org/status/fetch.php?pkg=3Dbabeltrace&arch=3Dsparc&=
ver=3D1.2.1-2&stamp=3D1395859546
> >
> >     buildd page:
> https://buildd.debian.org/status/package.php?p=3Dbabeltrace
> >
> > Cheers,
> >
> > --
> > Jon
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

--001a11c16ba85aea4404fb681408
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">J=C3=A9r=C3=A9mie, the end of the build.log seem to contai=
ns the tests output. <br></div><div class=3D"gmail_extra"><br><br><div clas=
s=3D"gmail_quote">On Mon, Jun 9, 2014 at 10:16 AM, J=C3=A9r=C3=A9mie Galarn=
eau <span dir=3D"ltr">&lt;<a href=3D"mailto:jeremie.galarneau@efficios.com"=
 target=3D"_blank">jeremie.galarneau@efficios.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Jon,<br>
<br>
Would it be possible to run the tests on these machines and provide<br>
the TAP output?<br>
<br>
Thanks,<br>
J=C3=A9r=C3=A9mie<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
On Wed, Jun 4, 2014 at 2:41 PM, Jon Bernard &lt;<a href=3D"mailto:jbernard@=
debian.org">jbernard@debian.org</a>&gt; wrote:<br>
&gt; I noticed babeltrace is having test failures on armel, hurd-i386,<br>
&gt; kfreebsd-{amd64,i386}, and sparc. =C2=A0These were passing in version =
1.1 and<br>
&gt; the failures appeared in 1.2. =C2=A0Here are links to the build logs:<=
br>
&gt;<br>
&gt; =C2=A0 =C2=A0 armel: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http=
s://buildd.debian.org/status/fetch.php?pkg=3Dbabeltrace&amp;arch=3Darmel&am=
p;ver=3D1.2.1-2&amp;stamp=3D1395846913" target=3D"_blank">https://buildd.de=
bian.org/status/fetch.php?pkg=3Dbabeltrace&amp;arch=3Darmel&amp;ver=3D1.2.1=
-2&amp;stamp=3D1395846913</a><br>

&gt; =C2=A0 =C2=A0 hurd-i386: =C2=A0 =C2=A0 =C2=A0<a href=3D"https://buildd=
.debian.org/status/fetch.php?pkg=3Dbabeltrace&amp;arch=3Dhurd-i386&amp;ver=
=3D1.2.1-2&amp;stamp=3D1398158394" target=3D"_blank">https://buildd.debian.=
org/status/fetch.php?pkg=3Dbabeltrace&amp;arch=3Dhurd-i386&amp;ver=3D1.2.1-=
2&amp;stamp=3D1398158394</a><br>

&gt; =C2=A0 =C2=A0 kfreebsd-amd64: <a href=3D"https://buildd.debian.org/sta=
tus/architecture.php?a=3Dkfreebsd-amd64&amp;suite=3Dsid" target=3D"_blank">=
https://buildd.debian.org/status/architecture.php?a=3Dkfreebsd-amd64&amp;su=
ite=3Dsid</a><br>

&gt; =C2=A0 =C2=A0 kfreebsd-i386: =C2=A0<a href=3D"https://buildd.debian.or=
g/status/fetch.php?pkg=3Dbabeltrace&amp;arch=3Dkfreebsd-i386&amp;ver=3D1.2.=
1-2&amp;stamp=3D1395842518" target=3D"_blank">https://buildd.debian.org/sta=
tus/fetch.php?pkg=3Dbabeltrace&amp;arch=3Dkfreebsd-i386&amp;ver=3D1.2.1-2&a=
mp;stamp=3D1395842518</a><br>

&gt; =C2=A0 =C2=A0 sparc: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http=
s://buildd.debian.org/status/fetch.php?pkg=3Dbabeltrace&amp;arch=3Dsparc&am=
p;ver=3D1.2.1-2&amp;stamp=3D1395859546" target=3D"_blank">https://buildd.de=
bian.org/status/fetch.php?pkg=3Dbabeltrace&amp;arch=3Dsparc&amp;ver=3D1.2.1=
-2&amp;stamp=3D1395859546</a><br>

&gt;<br>
&gt; =C2=A0 =C2=A0 buildd page: =C2=A0 =C2=A0<a href=3D"https://buildd.debi=
an.org/status/package.php?p=3Dbabeltrace" target=3D"_blank">https://buildd.=
debian.org/status/package.php?p=3Dbabeltrace</a><br>
&gt;<br>
&gt; Cheers,<br>
&gt;<br>
&gt; --<br>
&gt; Jon<br>
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
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">--<br>
J=C3=A9r=C3=A9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
</div></div></blockquote></div><br></div>

--001a11c16ba85aea4404fb681408--


--===============1454304826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1454304826==--
