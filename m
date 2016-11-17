From: "Mark E. Dawson, Jr." <medawsonjr@yahoo.com>
Subject: Re: Removing timing overhead with tracepoint() <--
 query dropped by mailing list
Date: Thu, 17 Nov 2016 21:47:14 +0000 (UTC)
Message-ID: <1022607049.2377857.1479419234491__30652.9919886545$1479419442$gmane$org@mail.yahoo.com>
References: <9EF0E366B97A2444B715BD7861705886E293EE69@EX2010-CO-06.AERO.BALL.com>
 <162450272.4446.1479335231606.JavaMail.zimbra@efficios.com>
 <9EF0E366B97A2444B715BD7861705886E2942E56@EX2010-CO-06.AERO.BALL.com>
 <1321420326.5617.1479399119390.JavaMail.zimbra@efficios.com>
 <1484074426.2165170.1479403261514@mail.yahoo.com>
 <1384678026.6657.1479415650848.JavaMail.zimbra@efficios.com>
Reply-To: "Mark E. Dawson, Jr." <medawsonjr@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7466939609844669696=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from nm12-vm0.bullet.mail.bf1.yahoo.com
 (nm12-vm0.bullet.mail.bf1.yahoo.com [98.139.213.140])
 by lists.lttng.org (Postfix) with ESMTPS id 3tKZZy6d02zd7D
 for <lttng-dev@lists.lttng.org>; Thu, 17 Nov 2016 21:51:38 +0000 (UTC)
In-Reply-To: <1384678026.6657.1479415650848.JavaMail.zimbra@efficios.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============7466939609844669696==
Content-Type: multipart/alternative;
	boundary="----=_Part_2377856_717577019.1479419234488"

------=_Part_2377856_717577019.1479419234488
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Ah, so there's more than just the one way I suggested in my original query.=
 Perfect! Thanks, Mathieu!

      From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 To: "Mark E. Dawson, Jr." <medawsonjr@yahoo.com>=20
Cc: lttng-dev <lttng-dev@lists.lttng.org>; Michael Jeanson <mjeanson@effici=
os.com>
 Sent: Thursday, November 17, 2016 2:47 PM
 Subject: Re: Removing timing overhead with tracepoint() <-- query dropped =
by mailing list
  =20
#yiv8877469080 filtered {font-family:Calibri;panose-1:2 15 5 2 2 2 4 3 2 4;=
}#yiv8877469080 filtered {font-family:Tahoma;panose-1:2 11 6 4 3 5 4 4 2 4;=
}#yiv8877469080 filtered {font-family:Verdana;panose-1:2 11 6 4 3 5 4 4 2 4=
;}#yiv8877469080 p.yiv8877469080MsoNormal, #yiv8877469080 li.yiv8877469080M=
soNormal, #yiv8877469080 div.yiv8877469080MsoNormal {margin:0in;margin-bott=
om:.0001pt;font-size:11.0pt;}#yiv8877469080 a:link, #yiv8877469080 span.yiv=
8877469080MsoHyperlink {color:blue;text-decoration:underline;}#yiv887746908=
0 a:visited, #yiv8877469080 span.yiv8877469080MsoHyperlinkFollowed {color:p=
urple;text-decoration:underline;}#yiv8877469080 p.yiv8877469080MsoAcetate, =
#yiv8877469080 li.yiv8877469080MsoAcetate, #yiv8877469080 div.yiv8877469080=
MsoAcetate {margin:0in;margin-bottom:.0001pt;font-size:8.0pt;}#yiv887746908=
0 span.yiv8877469080BalloonTextChar {}#yiv8877469080 span.yiv8877469080Emai=
lStyle19 {color:windowtext;font-weight:normal;font-style:normal;text-decora=
tion:none none;}#yiv8877469080 span.yiv8877469080EmailStyle20 {color:#1F497=
D;font-weight:normal;font-style:normal;text-decoration:none none;}#yiv88774=
69080 .yiv8877469080MsoChpDefault {font-size:10.0pt;}#yiv8877469080 filtere=
d {margin:1.0in 1.0in 1.0in 1.0in;}#yiv8877469080 div.yiv8877469080WordSect=
ion1 {}#yiv8877469080=20

----- On Nov 17, 2016, at 12:21 PM, Mark E. Dawson, Jr. <medawsonjr@yahoo.c=
om> wrote:

Mathieu,
My query appears to be getting dropped by the mailing list, forcing me to a=
sk you directly which I understand is both inefficient and a nuisance. We m=
et when I spoke (along with Christoph Lameter) at the Tracing Summit a coup=
le years back.

Hi Mark,

Not sure why the mailing list would have dropped your email. Everything loo=
ks fine in theadmin interface. Adding it in CC. (Michael, can you check if =
lttng-dev has issues with emailsfrom yahoo domains ?)
Anyway, my question is as follows:
If I want to remove a ton of compiled-in calls to an "rdtsc-based" C timing=
 function and make them all conditionally-enabled based on whether or not I=
 enable a tracing session, I can do so by adding the aforementioned "rdtsc"=
 call as one of the arguments to tracepoint() along with our defined provid=
er and event name, correct?

You can take a few approaches there:

1) Use if (tracepoint_enabled()) { ..read tsc... do_tracepoint(...); }

2) do this function call or static inline invocation as an argument of trac=
epoint().

3) do the function call/static inline invocation within the tracepoint prob=
e provider
=C2=A0=C2=A0=C2=A0=C2=A0 (TRACEPOINT_EVENT() code).

Let me know if I somehow misunderstood the intent of your question.

Thanks,

Mathieu
--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

  =20
------=_Part_2377856_717577019.1479419234488
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"color:#000; background-color:#fff; f=
ont-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, =
sans-serif;font-size:16px"><div id=3D"yui_3_16_0_ym19_1_1479419026922_32398=
"><span>Ah, so there's more than just the one way I suggested in my origina=
l query. Perfect! Thanks, Mathieu!</span></div><div class=3D"qtdSeparateBR"=
 id=3D"yui_3_16_0_ym19_1_1479419026922_32399"><br><br></div><div class=3D"y=
ahoo_quoted" id=3D"yui_3_16_0_ym19_1_1479419026922_32438" style=3D"display:=
 block;">  <div style=3D"font-family: HelveticaNeue, Helvetica Neue, Helvet=
ica, Arial, Lucida Grande, sans-serif; font-size: 16px;" id=3D"yui_3_16_0_y=
m19_1_1479419026922_32437"> <div style=3D"font-family: HelveticaNeue, Helve=
tica Neue, Helvetica, Arial, Lucida Grande, sans-serif; font-size: 16px;" i=
d=3D"yui_3_16_0_ym19_1_1479419026922_32436"> <div dir=3D"ltr" id=3D"yui_3_1=
6_0_ym19_1_1479419026922_32435"> <font size=3D"2" face=3D"Arial" id=3D"yui_=
3_16_0_ym19_1_1479419026922_32434"> <hr size=3D"1" id=3D"yui_3_16_0_ym19_1_=
1479419026922_32433"> <b><span style=3D"font-weight:bold;">From:</span></b>=
 Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;<br> <b><span styl=
e=3D"font-weight: bold;">To:</span></b> "Mark E. Dawson, Jr." &lt;medawsonj=
r@yahoo.com&gt; <br><b><span style=3D"font-weight: bold;">Cc:</span></b> lt=
tng-dev &lt;lttng-dev@lists.lttng.org&gt;; Michael Jeanson &lt;mjeanson@eff=
icios.com&gt;<br> <b><span style=3D"font-weight: bold;">Sent:</span></b> Th=
ursday, November 17, 2016 2:47 PM<br> <b><span style=3D"font-weight: bold;"=
>Subject:</span></b> Re: Removing timing overhead with tracepoint() &lt;-- =
query dropped by mailing list<br> </font> </div> <div class=3D"y_msg_contai=
ner" id=3D"yui_3_16_0_ym19_1_1479419026922_32439"><br><div id=3D"yiv8877469=
080"><div id=3D"yui_3_16_0_ym19_1_1479419026922_32442"><div style=3D"font-f=
amily:arial, helvetica, sans-serif;font-size:12pt;color:#000000;" id=3D"yui=
_3_16_0_ym19_1_1479419026922_32441"><div><style>#yiv8877469080    filtered =
 {font-family:Calibri;panose-1:2 15 5 2 2 2 4 3 2 4;}
#yiv8877469080 filtered  {font-family:Tahoma;panose-1:2 11 6 4 3 5 4 4 2 4;=
}
#yiv8877469080 filtered  {font-family:Verdana;panose-1:2 11 6 4 3 5 4 4 2 4=
;}

#yiv8877469080  p.yiv8877469080MsoNormal, #yiv8877469080  li.yiv8877469080M=
soNormal, #yiv8877469080  div.yiv8877469080MsoNormal
=09{margin:0in;margin-bottom:.0001pt;font-size:11.0pt;}
#yiv8877469080  a:link, #yiv8877469080  span.yiv8877469080MsoHyperlink
=09{color:blue;text-decoration:underline;}
#yiv8877469080  a:visited, #yiv8877469080  span.yiv8877469080MsoHyperlinkFo=
llowed
=09{color:purple;text-decoration:underline;}
#yiv8877469080  p.yiv8877469080MsoAcetate, #yiv8877469080  li.yiv8877469080=
MsoAcetate, #yiv8877469080  div.yiv8877469080MsoAcetate
=09{margin:0in;margin-bottom:.0001pt;font-size:8.0pt;}
#yiv8877469080  span.yiv8877469080BalloonTextChar
=09{}
#yiv8877469080  span.yiv8877469080EmailStyle19
=09{color:windowtext;font-weight:normal;font-style:normal;text-decoration:n=
one none;}
#yiv8877469080  span.yiv8877469080EmailStyle20
=09{color:#1F497D;font-weight:normal;font-style:normal;text-decoration:none=
 none;}
#yiv8877469080  .yiv8877469080MsoChpDefault
=09{font-size:10.0pt;}
#yiv8877469080 filtered  {margin:1.0in 1.0in 1.0in 1.0in;}
#yiv8877469080  div.yiv8877469080WordSection1
=09{}
#yiv8877469080 </style></div><div id=3D"yui_3_16_0_ym19_1_1479419026922_324=
40"><br clear=3D"none"></div><div id=3D"yui_3_16_0_ym19_1_1479419026922_324=
43"><br clear=3D"none"></div><div id=3D"yui_3_16_0_ym19_1_1479419026922_324=
44"><span id=3D"yiv8877469080zwchr">----- On Nov 17, 2016, at 12:21 PM, Mar=
k E. Dawson, Jr. &lt;medawsonjr@yahoo.com&gt; wrote:<br clear=3D"none"></sp=
an></div><div id=3D"yui_3_16_0_ym19_1_1479419026922_32447"><blockquote styl=
e=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#=
000;font-weight:normal;font-style:normal;text-decoration:none;font-family:H=
elvetica, Arial, sans-serif;font-size:12pt;" id=3D"yui_3_16_0_ym19_1_147941=
9026922_32446"><div style=3D"color:#000;background-color:#fff;font-family:H=
elveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif;f=
ont-size:16px;" id=3D"yui_3_16_0_ym19_1_1479419026922_32445"><div id=3D"yiv=
8877469080yui_3_16_0_ym19_1_1479402851121_60364"><span>Mathieu,</span></div=
><div id=3D"yiv8877469080yui_3_16_0_ym19_1_1479402851121_60364"><span><br c=
lear=3D"none"></span></div><div id=3D"yiv8877469080yui_3_16_0_ym19_1_147940=
2851121_60364"><span id=3D"yiv8877469080yui_3_16_0_ym19_1_1479402851121_604=
85">My query appears to be getting dropped by the mailing list, forcing me =
to ask you directly which I understand is both inefficient and a nuisance. =
We met when I spoke (along with Christoph Lameter) at the Tracing Summit a =
couple years back.</span></div></div></blockquote><div id=3D"yui_3_16_0_ym1=
9_1_1479419026922_32448"><br clear=3D"none"></div><div id=3D"yui_3_16_0_ym1=
9_1_1479419026922_32450"><div id=3D"yui_3_16_0_ym19_1_1479419026922_32449">=
Hi Mark,<br clear=3D"none"></div><div><br clear=3D"none"></div><div>Not sur=
e why the mailing list would have dropped your email. Everything looks fine=
 in the</div><div>admin interface. Adding it in CC. (Michael, can you check=
 if lttng-dev has issues with emails</div><div>from yahoo domains ?)</div><=
/div><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;pad=
ding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decorati=
on:none;font-family:Helvetica, Arial, sans-serif;font-size:12pt;"><div styl=
e=3D"color:#000;background-color:#fff;font-family:HelveticaNeue, Helvetica =
Neue, Helvetica, Arial, Lucida Grande, sans-serif;font-size:16px;"><div id=
=3D"yiv8877469080yui_3_16_0_ym19_1_1479402851121_60364"><span>Anyway, my qu=
estion is as follows:</span></div><div id=3D"yiv8877469080yui_3_16_0_ym19_1=
_1479402851121_60364"><span><br clear=3D"none"></span></div><div dir=3D"ltr=
" id=3D"yiv8877469080yui_3_16_0_ym19_1_1479402851121_60364">If I want to re=
move a ton of compiled-in calls to an "rdtsc-based" C timing function and m=
ake them all conditionally-enabled based on whether or not I enable a traci=
ng session, I can do so by adding the aforementioned "rdtsc" call as one of=
 the arguments to tracepoint() along with our defined provider and event na=
me, correct?</div></div></blockquote><br clear=3D"none">You can take a few =
approaches there:<br clear=3D"none"><div><br clear=3D"none"></div><div>1) U=
se if (tracepoint_enabled()) { ..read tsc... do_tracepoint(...); }<br clear=
=3D"none"></div><div><br clear=3D"none"></div><div>2) do this function call=
 or static inline invocation as an argument of tracepoint().<br clear=3D"no=
ne"></div><div><br clear=3D"none"></div><div>3) do the function call/static=
 inline invocation within the tracepoint probe provider<br clear=3D"none"><=
/div><div>&nbsp;&nbsp;&nbsp;&nbsp; (TRACEPOINT_EVENT() code).<br clear=3D"n=
one"></div><div><br clear=3D"none"></div><div>Let me know if I somehow misu=
nderstood the intent of your question.<br clear=3D"none"></div><div><br cle=
ar=3D"none"></div><div>Thanks,<div class=3D"yiv8877469080yqt5390401818" id=
=3D"yiv8877469080yqtfd52333"><br clear=3D"none"></div></div><div class=3D"y=
iv8877469080yqt5390401818" id=3D"yiv8877469080yqtfd60045"><div><br clear=3D=
"none"></div><div>Mathieu</div></div></div><div><br clear=3D"none"></div><d=
iv>-- <br clear=3D"none"></div><div>Mathieu Desnoyers<br clear=3D"none">Eff=
iciOS Inc.<br clear=3D"none">http://www.efficios.com</div></div></div></div=
><br><br></div> </div> </div>  </div></div></body></html>
------=_Part_2377856_717577019.1479419234488--

--===============7466939609844669696==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7466939609844669696==--
