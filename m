From: Ranganadh Kanitmahanti <ranganadh1991@yahoo.com>
Subject: Re: Trace loss in Lttng
Date: Wed, 7 Jan 2015 04:03:11 +0000 (UTC)
Message-ID: <838808914.3483515.1420603391301.JavaMail.yahoo__44570.0925578878$1420603499$gmane$org@jws10968.mail.sg3.yahoo.com>
References: <CA+jJMxvtm+jBbn1-hqQoBcG0+P9sLz+J1uZYD5jFigUpBDa=Zw@mail.gmail.com>
 <1917307066.1594933.1419855582576.JavaMail.yahoo@jws10968.mail.sg3.yahoo.com>
Reply-To: Ranganadh Kanitmahanti <ranganadh1991@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1875688520=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from nm20-vm2.bullet.mail.sg3.yahoo.com ([106.10.149.129])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <ranganadh1991@yahoo.com>) id 1Y8hq3-0006LK-Ge
 for lttng-dev@lists.lttng.org; Tue, 06 Jan 2015 23:03:24 -0500
In-Reply-To: <1917307066.1594933.1419855582576.JavaMail.yahoo@jws10968.mail.sg3.yahoo.com>
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

--===============1875688520==
Content-Type: multipart/alternative;
	boundary="----=_Part_3483514_1907828722.1420603391294"
Content-Length: 10597

------=_Part_3483514_1907828722.1420603391294
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi ,
 Thank you, events_discarded may be of some help for us.=C2=A0 Our main req=
uirement is to find the number of discarded events per session
Ex: We use lttng_create_session() to create an session and then enabled cer=
tain events using lttng_enable_event(). The events=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 come=C2=A0 from different processes.=20
Now, as a whole, can we get the number of discarded events for the whole se=
ssion??=20

Thanks & Regards,K.V.Ranganadh.

     On Monday, 29 December 2014 5:49 PM, Ranganadh Kanitmahanti <ranganadh=
1991@yahoo.com> wrote:
  =20

 Hi Jeremie,
Thank you, events_discarded may be of some help for us.=C2=A0 Our main requ=
irement is to find the number of discarded events per session
Ex: We use lttng_create_session() to create an session and then enabled cer=
tain events using lttng_enable_event(). The events=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 come=C2=A0 from different processes.=20
Now, as a whole, can we get the number of discarded events for the whole se=
ssion??=20

Thanks &Regards,K.V.Ranganadh.

     On Tuesday, 9 December 2014 10:10 PM, J=C3=A9r=C3=A9mie Galarneau <jer=
emie.galarneau@efficios.com> wrote:
  =20

 On Tue, Dec 9, 2014 at 12:20 AM, Ranganadh Kanitmahanti
<ranganadh1991@yahoo.com> wrote:
> Hi,
>
> I am using Lttng in an application. I have enabled heavy traces and I hav=
e
> found that there is a loss in traces.=C2=A0 Is there any way of knowing i=
f there
> is any trace loss or any information regarding about it . Are there any A=
PI
> calls to know about them.

There is no way to know from the application while the trace is being
captured. I wonder what form such a mechanism would take to,
basically, query the tracer/ring buffer for the events_discarded
counter... This would arguably be of little use in per-uid mode (since
a user's apps share the same buffer), but I could see this being
useful in per-pid mode.
Any ideas?

J=C3=A9r=C3=A9mie

>
> Thanks & Regards.,
> K.V.Ranganadh.
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

   =20

   
------=_Part_3483514_1907828722.1420603391294
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:He=
lveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, Sans-Serif;fo=
nt-size:12px"><div id=3D"yiv7273670832"><div id=3D"yui_3_16_0_1_14206032855=
57_20082"><div id=3D"yui_3_16_0_1_1420603285557_20081" style=3D"color:#000;=
background-color:#fff;font-family:HelveticaNeue, Helvetica Neue, Helvetica,=
 Arial, Lucida Grande, Sans-Serif;font-size:12px;"><div id=3D"yiv7273670832=
"><div id=3D"yui_3_16_0_1_1420603285557_20080"><div id=3D"yui_3_16_0_1_1420=
603285557_20079" style=3D"color:#000;background-color:#fff;font-family:Helv=
eticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, Sans-Serif;font=
-size:12px;"><div dir=3D"ltr" id=3D"yiv7273670832yui_3_16_0_1_1420603285557=
_8290"><span>Hi ,</span></div><div dir=3D"ltr" id=3D"yiv7273670832yui_3_16_=
0_1_1420603285557_8289"><br clear=3D"none"><span></span></div><div dir=3D"l=
tr"><span></span></div> <div id=3D"yui_3_16_0_1_1420603285557_20094" class=
=3D"yiv7273670832qtdSeparateBR">Thank
 you, events_discarded may be of some help for us.&nbsp; Our main requireme=
nt
 is to find the number of discarded events per session<br class=3D"" style=
=3D"" clear=3D"none"><div style=3D"" class=3D"" dir=3D"ltr" id=3D"yiv539873=
8188yui_3_16_0_1_1419855527555_3358"><span style=3D"" class=3D"" id=3D"yiv5=
398738188yui_3_16_0_1_1419855527555_3357">Ex:
 We use lttng_create_session() to create an session and then enabled=20
certain events using lttng_enable_event(). The events&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; come&nbsp; from=20
different processes. <br class=3D"" style=3D"" clear=3D"none">Now, as a who=
le, can we get the number of discarded events for the whole session?? <br c=
lass=3D"" style=3D"" clear=3D"none"></span></div><div style=3D"" class=3D""=
 dir=3D"ltr" id=3D"yiv5398738188yui_3_16_0_1_1419855527555_3377"><div id=3D=
"yui_3_16_0_1_1420603285557_20140"><br><span style=3D"" class=3D"" id=3D"yi=
v5398738188yui_3_16_0_1_1419855527555_3357"></span></div><div dir=3D"ltr" i=
d=3D"yui_3_16_0_1_1420603285557_20141"><span style=3D"" class=3D"" id=3D"yi=
v5398738188yui_3_16_0_1_1419855527555_3357">Thanks &amp; Regards,</span></d=
iv><div id=3D"yui_3_16_0_1_1420603285557_20142" dir=3D"ltr"><span style=3D"=
" class=3D"" id=3D"yiv5398738188yui_3_16_0_1_1419855527555_3357">K.V.Rangan=
adh.<br style=3D"" class=3D"" clear=3D"none"></span></div></div><div id=3D"=
yui_3_16_0_1_1420603285557_20139" style=3D"" class=3D"" dir=3D"ltr"><br sty=
le=3D"" class=3D""></div></div><div class=3D"yiv7273670832yqt6906803983" id=
=3D"yiv7273670832yqt51822"><div class=3D"yiv7273670832yqt0491201076" id=3D"=
yiv7273670832yqt85231"><div class=3D"yiv7273670832yahoo_quoted" style=3D"di=
splay: block;"> <div style=3D"font-family:HelveticaNeue, Helvetica Neue, He=
lvetica, Arial, Lucida Grande, Sans-Serif;font-size:12px;"> <div style=3D"f=
ont-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, =
Sans-Serif;font-size:12px;"> <div dir=3D"ltr"> <font size=3D"2" face=3D"Ari=
al"> On Monday, 29 December 2014 5:49 PM, Ranganadh Kanitmahanti &lt;rangan=
adh1991@yahoo.com&gt; wrote:<br clear=3D"none"> </font> </div>  <br clear=
=3D"none"><br clear=3D"none"> <div class=3D"yiv7273670832y_msg_container"><=
div id=3D"yiv7273670832"><div><div style=3D"color:#000;background-color:#ff=
f;font-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grand=
e, Sans-Serif;font-size:12px;"><div dir=3D"ltr" id=3D"yiv7273670832yui_3_16=
_0_1_1419855527555_3355"><span>Hi Jeremie,</span></div><div dir=3D"ltr" id=
=3D"yiv7273670832yui_3_16_0_1_1419855527555_3358"><br clear=3D"none"><span>=
</span><span id=3D"yiv7273670832yui_3_16_0_1_1419855527555_3357">Thank you,=
 events_discarded may be of some help for us.&nbsp; Our main requirement is=
 to find the number of discarded events per session<br class=3D"yiv72736708=
32" style=3D"" clear=3D"none">Ex: We use lttng_create_session() to create a=
n session and then enabled certain events using lttng_enable_event(). The e=
vents&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; come&nbsp; from different processes. <b=
r class=3D"yiv7273670832" style=3D"" clear=3D"none">Now, as a whole, can we=
 get the number of discarded events for the whole session?? <br class=3D"yi=
v7273670832" style=3D"" clear=3D"none"></span></div><div dir=3D"ltr" id=3D"=
yiv7273670832yui_3_16_0_1_1419855527555_3377"><span id=3D"yiv7273670832yui_=
3_16_0_1_1419855527555_3357"><br clear=3D"none"></span></div><div dir=3D"lt=
r" id=3D"yiv7273670832yui_3_16_0_1_1419855527555_3380"><span id=3D"yiv72736=
70832yui_3_16_0_1_1419855527555_3357">Thanks &amp;Regards,</span></div><div=
 dir=3D"ltr" id=3D"yiv7273670832yui_3_16_0_1_1419855527555_3378">K.V.Rangan=
adh.</div><div class=3D"yiv7273670832qtdSeparateBR"><br clear=3D"none"><br =
clear=3D"none"></div><div class=3D"yiv7273670832yqt5931670193" id=3D"yiv727=
3670832yqt88478"><div class=3D"yiv7273670832yahoo_quoted" style=3D"display:=
block;"> <div style=3D"font-family:HelveticaNeue, Helvetica Neue, Helvetica=
, Arial, Lucida Grande, Sans-Serif;font-size:12px;"> <div style=3D"font-fam=
ily:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, Sans-Se=
rif;font-size:12px;"> <div dir=3D"ltr"> <font size=3D"2" face=3D"Arial"> On=
 Tuesday, 9 December 2014 10:10 PM, J=C3=A9r=C3=A9mie Galarneau &lt;jeremie=
.galarneau@efficios.com&gt; wrote:<br clear=3D"none"> </font> </div>  <br c=
lear=3D"none"><br clear=3D"none"> <div class=3D"yiv7273670832y_msg_containe=
r">On Tue, Dec 9, 2014 at 12:20 AM, Ranganadh Kanitmahanti<br clear=3D"none=
">&lt;<a rel=3D"nofollow" shape=3D"rect" ymailto=3D"mailto:ranganadh1991@ya=
hoo.com" target=3D"_blank" href=3D"mailto:ranganadh1991@yahoo.com">ranganad=
h1991@yahoo.com</a>&gt; wrote:<br clear=3D"none">&gt; Hi,<br clear=3D"none"=
>&gt;<br clear=3D"none">&gt; I am using Lttng in an application. I have ena=
bled heavy traces and I have<br clear=3D"none">&gt; found that there is a l=
oss in traces.&nbsp; Is there any way of knowing if there<br clear=3D"none"=
>&gt; is any trace loss or any information regarding about it . Are there a=
ny API<br clear=3D"none">&gt; calls to know about them.<br clear=3D"none"><=
br clear=3D"none">There is no way to know from the application while the tr=
ace is being<br clear=3D"none">captured. I wonder what form such a mechanis=
m would take to,<br clear=3D"none">basically, query the tracer/ring buffer =
for the events_discarded<br clear=3D"none">counter... This would arguably b=
e of little use in per-uid mode (since<br clear=3D"none">a user's apps shar=
e the same buffer), but I could see this being<br clear=3D"none">useful in =
per-pid mode.<br clear=3D"none">Any ideas?<br clear=3D"none"><br clear=3D"n=
one">J=C3=A9r=C3=A9mie<div class=3D"yiv7273670832yqt1967503046" id=3D"yiv72=
73670832yqtfd90429"><br clear=3D"none"><br clear=3D"none">&gt;<br clear=3D"=
none">&gt; Thanks &amp; Regards.,<br clear=3D"none">&gt; K.V.Ranganadh.</di=
v><br clear=3D"none">&gt;<br clear=3D"none">&gt; __________________________=
_____________________<br clear=3D"none">&gt; lttng-dev mailing list<br clea=
r=3D"none">&gt; <a rel=3D"nofollow" shape=3D"rect" ymailto=3D"mailto:lttng-=
dev@lists.lttng.org" target=3D"_blank" href=3D"mailto:lttng-dev@lists.lttng=
.org">lttng-dev@lists.lttng.org</a><br clear=3D"none">&gt; <a rel=3D"nofoll=
ow" shape=3D"rect" target=3D"_blank" href=3D"http://lists.lttng.org/cgi-bin=
/mailman/listinfo/lttng-dev">http://lists.lttng.org/cgi-bin/mailman/listinf=
o/lttng-dev</a><br clear=3D"none">&gt;<br clear=3D"none"><br clear=3D"none"=
><br clear=3D"none"><br clear=3D"none">-- <br clear=3D"none">J=C3=A9r=C3=A9=
mie Galarneau<br clear=3D"none">EfficiOS Inc.<br clear=3D"none"><a rel=3D"n=
ofollow" shape=3D"rect" target=3D"_blank" href=3D"http://www.efficios.com/"=
>http://www.efficios.com</a><br clear=3D"none"><br clear=3D"none"></div>  <=
/div> </div>  </div></div> </div></div></div><br clear=3D"none"><br clear=
=3D"none"></div>  </div> </div>  </div></div></div> </div></div></div></div=
></div></div></div></body></html>
------=_Part_3483514_1907828722.1420603391294--


--===============1875688520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1875688520==--
