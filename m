From: Jesper Derehag <jderehag@hotmail.com>
Subject: Re: [PATCH v2 lttng-ust] Fix: python invocation through
 env
Date: Wed, 2 Apr 2014 19:57:10 +0000
Message-ID: <DUB123-W344B6947DA2B156762D18BDD6D0__21130.5869197988$1396519119$gmane$org@phx.gbl>
References: <1396845262.585.1395775224524.JavaMail.zimbra@efficios.com>
 <1395907026-934-1-git-send-email-jderehag@hotmail.com>,
 <1245840009.4951.1396456496843.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1980700456=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from dub0-omc2-s18.dub0.hotmail.com ([157.55.1.157])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jderehag@hotmail.com>) id 1WVRHg-0002TY-OQ
 for lttng-dev@lists.lttng.org; Wed, 02 Apr 2014 15:57:22 -0400
In-Reply-To: <1245840009.4951.1396456496843.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1980700456==
Content-Type: multipart/alternative;
	boundary="_ead60d95-43f2-4a18-9fa1-3b0404a8e52f_"

--_ead60d95-43f2-4a18-9fa1-3b0404a8e52f_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Yes of course.
I simply forgot to add it. (My following patch on backporting to glibc 2.8 =
have it already).

> Date: Wed=2C 2 Apr 2014 16:34:56 +0000
> From: mathieu.desnoyers@efficios.com
> To: jderehag@hotmail.com
> CC: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] [PATCH v2 lttng-ust] Fix: python invocation thro=
ugh env
>=20
> For the next patches=2C please add a=20
>=20
> Signed-off-by: Name Lastname <email>
>=20
> line at the end of the patch description to follow the
> LTTng project's use of developer's certificate of origin.
>=20
> Please let me know if I can add your signed-off-by as:
>=20
> Signed-off-by: Jesper Derehag <jderehag@hotmail.com>
>=20
> to this patch so I can merge it.
>=20
> If you wonder what it means=2C see:
>=20
> http://elinux.org/Developer_Certificate_Of_Origin
>=20
> Thanks!
>=20
> Mathieu
>=20
> ----- Original Message -----
> > From: jderehag@hotmail.com
> > To: lttng-dev@lists.lttng.org
> > Sent: Thursday=2C March 27=2C 2014 3:57:06 AM
> > Subject: [lttng-dev] [PATCH v2 lttng-ust] Fix: python invocation throug=
h env
> >=20
> > From: Jesper Derehag <jderehag@hotmail.com>
> >=20
> > This modification calls the interpreter through env instead of
> > directly=2C which should be more portable for those distros which do no=
t
> > install
> > python into /usr/bin/.
> > ---
> >  tools/lttng-gen-tp |    2 +-
> >  1 file changed=2C 1 insertion(+)=2C 1 deletion(-)
> >=20
> > diff --git a/tools/lttng-gen-tp b/tools/lttng-gen-tp
> > index c49e8a5..a3a01f2 100755
> > --- a/tools/lttng-gen-tp
> > +++ b/tools/lttng-gen-tp
> > @@ -1=2C4 +1=2C4 @@
> > -#!/usr/bin/python
> > +#!/usr/bin/env python
> >  #
> >  # Copyright (c)  2012 Yannick Brosseau <yannick.brosseau@gmail.com>
> >  #
> > --
> > 1.7.9.5
> >=20
> >=20
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >=20
>=20
> --=20
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
 		 	   		  =

--_ead60d95-43f2-4a18-9fa1-3b0404a8e52f_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 12pt=3B
font-family:Calibri
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'>Yes of course.<br>I simply forgo=
t to add it. (My following patch on backporting to glibc 2.8 have it alread=
y).<br><br>> Date&#58=3B Wed=2C 2 Apr 2014 16&#58=3B34&#58=3B56 &#43=3B0000=
<br>> From&#58=3B mathieu.desnoyers&#64=3Befficios.com<br>> To&#58=3B jdere=
hag&#64=3Bhotmail.com<br>> CC&#58=3B lttng-dev&#64=3Blists.lttng.org<br>> S=
ubject&#58=3B Re&#58=3B &#91=3Blttng-dev&#93=3B &#91=3BPATCH v2 lttng-ust&#=
93=3B Fix&#58=3B python invocation through env<br>> <br>> For the next patc=
hes=2C please add a <br>> <br>> Signed-off-by&#58=3B Name Lastname &#60=3Be=
mail&#62=3B<br>> <br>> line at the end of the patch description to follow t=
he<br>> LTTng project&#39=3Bs use of developer&#39=3Bs certificate of origi=
n.<br>> <br>> Please let me know if I can add your signed-off-by as&#58=3B<=
br>> <br>> Signed-off-by&#58=3B Jesper Derehag &#60=3Bjderehag&#64=3Bhotmai=
l.com&#62=3B<br>> <br>> to this patch so I can merge it.<br>> <br>> If you =
wonder what it means=2C see&#58=3B<br>> <br>> http&#58=3B//elinux.org/Devel=
oper_Certificate_Of_Origin<br>> <br>> Thanks&#33=3B<br>> <br>> Mathieu<br>>=
 <br>> ----- Original Message -----<br>> &#62=3B From&#58=3B jderehag&#64=
=3Bhotmail.com<br>> &#62=3B To&#58=3B lttng-dev&#64=3Blists.lttng.org<br>> =
&#62=3B Sent&#58=3B Thursday=2C March 27=2C 2014 3&#58=3B57&#58=3B06 AM<br>=
> &#62=3B Subject&#58=3B &#91=3Blttng-dev&#93=3B &#91=3BPATCH v2 lttng-ust&=
#93=3B Fix&#58=3B python invocation through env<br>> &#62=3B <br>> &#62=3B =
From&#58=3B Jesper Derehag &#60=3Bjderehag&#64=3Bhotmail.com&#62=3B<br>> &#=
62=3B <br>> &#62=3B This modification calls the interpreter through env ins=
tead of<br>> &#62=3B directly=2C which should be more portable for those di=
stros which do not<br>> &#62=3B install<br>> &#62=3B python into /usr/bin/.=
<br>> &#62=3B ---<br>> &#62=3B  tools/lttng-gen-tp &#124=3B    2 &#43=3B-<b=
r>> &#62=3B  1 file changed=2C 1 insertion&#40=3B&#43=3B&#41=3B=2C 1 deleti=
on&#40=3B-&#41=3B<br>> &#62=3B <br>> &#62=3B diff --git a/tools/lttng-gen-t=
p b/tools/lttng-gen-tp<br>> &#62=3B index c49e8a5..a3a01f2 100755<br>> &#62=
=3B --- a/tools/lttng-gen-tp<br>> &#62=3B &#43=3B&#43=3B&#43=3B b/tools/ltt=
ng-gen-tp<br>> &#62=3B &#64=3B&#64=3B -1=2C4 &#43=3B1=2C4 &#64=3B&#64=3B<br=
>> &#62=3B -&#35=3B&#33=3B/usr/bin/python<br>> &#62=3B &#43=3B&#35=3B&#33=
=3B/usr/bin/env python<br>> &#62=3B  &#35=3B<br>> &#62=3B  &#35=3B Copyrigh=
t &#40=3Bc&#41=3B  2012 Yannick Brosseau &#60=3Byannick.brosseau&#64=3Bgmai=
l.com&#62=3B<br>> &#62=3B  &#35=3B<br>> &#62=3B --<br>> &#62=3B 1.7.9.5<br>=
> &#62=3B <br>> &#62=3B <br>> &#62=3B _____________________________________=
__________<br>> &#62=3B lttng-dev mailing list<br>> &#62=3B lttng-dev&#64=
=3Blists.lttng.org<br>> &#62=3B http&#58=3B//lists.lttng.org/cgi-bin/mailma=
n/listinfo/lttng-dev<br>> &#62=3B <br>> <br>> -- <br>> Mathieu Desnoyers<br=
>> EfficiOS Inc.<br>> http&#58=3B//www.efficios.com<br> 		 	   		  </div></=
body>
</html>=

--_ead60d95-43f2-4a18-9fa1-3b0404a8e52f_--


--===============1980700456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1980700456==--
