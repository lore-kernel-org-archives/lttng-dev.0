From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 lttng-ust] Fix: python invocation through
 env
Date: Wed, 2 Apr 2014 21:31:36 +0000 (UTC)
Message-ID: <1738615472.5249.1396474296626.JavaMail.zimbra__27075.5693935373$1396519713$gmane$org@efficios.com>
References: <1396845262.585.1395775224524.JavaMail.zimbra@efficios.com>
 <1395907026-934-1-git-send-email-jderehag@hotmail.com>
 <1245840009.4951.1396456496843.JavaMail.zimbra@efficios.com>
 <DUB123-W344B6947DA2B156762D18BDD6D0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0546165376=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1WVSl6-00033p-O3
 for lttng-dev@lists.lttng.org; Wed, 02 Apr 2014 17:31:50 -0400
In-Reply-To: <DUB123-W344B6947DA2B156762D18BDD6D0@phx.gbl>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jesper Derehag <jderehag@hotmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0546165376==
Content-Type: multipart/alternative;
	boundary="----=_Part_5248_1125401743.1396474296624"

------=_Part_5248_1125401743.1396474296624
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Allright, merged. 

Thanks! 

Mathieu 

----- Original Message -----

> From: "Jesper Derehag" <jderehag@hotmail.com>
> To: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org
> Sent: Wednesday, April 2, 2014 3:57:10 PM
> Subject: RE: [lttng-dev] [PATCH v2 lttng-ust] Fix: python invocation through
> env

> Yes of course.
> I simply forgot to add it. (My following patch on backporting to glibc 2.8
> have it already).

> > Date: Wed, 2 Apr 2014 16:34:56 +0000
> > From: mathieu.desnoyers@efficios.com
> > To: jderehag@hotmail.com
> > CC: lttng-dev@lists.lttng.org
> > Subject: Re: [lttng-dev] [PATCH v2 lttng-ust] Fix: python invocation
> > through env
> >
> > For the next patches, please add a
> >
> > Signed-off-by: Name Lastname <email>
> >
> > line at the end of the patch description to follow the
> > LTTng project's use of developer's certificate of origin.
> >
> > Please let me know if I can add your signed-off-by as:
> >
> > Signed-off-by: Jesper Derehag <jderehag@hotmail.com>
> >
> > to this patch so I can merge it.
> >
> > If you wonder what it means, see:
> >
> > http://elinux.org/Developer_Certificate_Of_Origin
> >
> > Thanks!
> >
> > Mathieu
> >
> > ----- Original Message -----
> > > From: jderehag@hotmail.com
> > > To: lttng-dev@lists.lttng.org
> > > Sent: Thursday, March 27, 2014 3:57:06 AM
> > > Subject: [lttng-dev] [PATCH v2 lttng-ust] Fix: python invocation through
> > > env
> > >
> > > From: Jesper Derehag <jderehag@hotmail.com>
> > >
> > > This modification calls the interpreter through env instead of
> > > directly, which should be more portable for those distros which do not
> > > install
> > > python into /usr/bin/.
> > > ---
> > > tools/lttng-gen-tp | 2 +-
> > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/lttng-gen-tp b/tools/lttng-gen-tp
> > > index c49e8a5..a3a01f2 100755
> > > --- a/tools/lttng-gen-tp
> > > +++ b/tools/lttng-gen-tp
> > > @@ -1,4 +1,4 @@
> > > -#!/usr/bin/python
> > > +#!/usr/bin/env python
> > > #
> > > # Copyright (c) 2012 Yannick Brosseau <yannick.brosseau@gmail.com>
> > > #
> > > --
> > > 1.7.9.5
> > >
> > >
> > > _______________________________________________
> > > lttng-dev mailing list
> > > lttng-dev@lists.lttng.org
> > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > >
> >
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_5248_1125401743.1396474296624
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div>Allright, merged.<br></div><div>=
<br></div><div>Thanks!<br></div><div><br></div><div>Mathieu<br></div><div><=
br></div><div><br></div><hr id=3D"zwchr"><blockquote style=3D"border-left:2=
px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:no=
rmal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,san=
s-serif;font-size:12pt;"><b>From: </b>"Jesper Derehag" &lt;jderehag@hotmail=
.com&gt;<br><b>To: </b>"mathieu desnoyers" &lt;mathieu.desnoyers@efficios.c=
om&gt;<br><b>Cc: </b>lttng-dev@lists.lttng.org<br><b>Sent: </b>Wednesday, A=
pril 2, 2014 3:57:10 PM<br><b>Subject: </b>RE: [lttng-dev] [PATCH v2 lttng-=
ust] Fix: python invocation through env<br><div><br></div>

<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 12pt;
font-family:Calibri
}
--></style>
<div dir=3D"ltr">Yes of course.<br>I simply forgot to add it. (My following=
 patch on backporting to glibc 2.8 have it already).<br><div><br></div>&gt;=
 Date: Wed, 2 Apr 2014 16:34:56 +0000<br>&gt; From: mathieu.desnoyers@effic=
ios.com<br>&gt; To: jderehag@hotmail.com<br>&gt; CC: lttng-dev@lists.lttng.=
org<br>&gt; Subject: Re: [lttng-dev] [PATCH v2 lttng-ust] Fix: python invoc=
ation through env<br>&gt; <br>&gt; For the next patches, please add a <br>&=
gt; <br>&gt; Signed-off-by: Name Lastname &lt;email&gt;<br>&gt; <br>&gt; li=
ne at the end of the patch description to follow the<br>&gt; LTTng project'=
s use of developer's certificate of origin.<br>&gt; <br>&gt; Please let me =
know if I can add your signed-off-by as:<br>&gt; <br>&gt; Signed-off-by: Je=
sper Derehag &lt;jderehag@hotmail.com&gt;<br>&gt; <br>&gt; to this patch so=
 I can merge it.<br>&gt; <br>&gt; If you wonder what it means, see:<br>&gt;=
 <br>&gt; http://elinux.org/Developer_Certificate_Of_Origin<br>&gt; <br>&gt=
; Thanks!<br>&gt; <br>&gt; Mathieu<br>&gt; <br>&gt; ----- Original Message =
-----<br>&gt; &gt; From: jderehag@hotmail.com<br>&gt; &gt; To: lttng-dev@li=
sts.lttng.org<br>&gt; &gt; Sent: Thursday, March 27, 2014 3:57:06 AM<br>&gt=
; &gt; Subject: [lttng-dev] [PATCH v2 lttng-ust] Fix: python invocation thr=
ough env<br>&gt; &gt; <br>&gt; &gt; From: Jesper Derehag &lt;jderehag@hotma=
il.com&gt;<br>&gt; &gt; <br>&gt; &gt; This modification calls the interpret=
er through env instead of<br>&gt; &gt; directly, which should be more porta=
ble for those distros which do not<br>&gt; &gt; install<br>&gt; &gt; python=
 into /usr/bin/.<br>&gt; &gt; ---<br>&gt; &gt;  tools/lttng-gen-tp |    2 +=
-<br>&gt; &gt;  1 file changed, 1 insertion(+), 1 deletion(-)<br>&gt; &gt; =
<br>&gt; &gt; diff --git a/tools/lttng-gen-tp b/tools/lttng-gen-tp<br>&gt; =
&gt; index c49e8a5..a3a01f2 100755<br>&gt; &gt; --- a/tools/lttng-gen-tp<br=
>&gt; &gt; +++ b/tools/lttng-gen-tp<br>&gt; &gt; @@ -1,4 +1,4 @@<br>&gt; &g=
t; -#!/usr/bin/python<br>&gt; &gt; +#!/usr/bin/env python<br>&gt; &gt;  #<b=
r>&gt; &gt;  # Copyright (c)  2012 Yannick Brosseau &lt;yannick.brosseau@gm=
ail.com&gt;<br>&gt; &gt;  #<br>&gt; &gt; --<br>&gt; &gt; 1.7.9.5<br>&gt; &g=
t; <br>&gt; &gt; <br>&gt; &gt; ____________________________________________=
___<br>&gt; &gt; lttng-dev mailing list<br>&gt; &gt; lttng-dev@lists.lttng.=
org<br>&gt; &gt; http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<=
br>&gt; &gt; <br>&gt; <br>&gt; -- <br>&gt; Mathieu Desnoyers<br>&gt; Effici=
OS Inc.<br>&gt; http://www.efficios.com<br> =09=09 =09   =09=09  </div>
</blockquote><div><br><br></div><div><br></div><div>-- <br></div><div><span=
 name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficio=
s.com<span name=3D"x"></span><br></div></div></body></html>
------=_Part_5248_1125401743.1396474296624--


--===============0546165376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0546165376==--
