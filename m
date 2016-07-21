From: "Mark E. Dawson, Jr." <medawsonjr@yahoo.com>
Subject: Re: Practical recommendation for max update rate with
 QSBR
Date: Thu, 21 Jul 2016 23:14:18 +0000 (UTC)
Message-ID: <1898677757.3413957.1469142858857.JavaMail.yahoo__29421.487337868$1469143290$gmane$org@mail.yahoo.com>
References: <1733955808.5920250.1465238884157.JavaMail.yahoo.ref@mail.yahoo.com>
 <1733955808.5920250.1465238884157.JavaMail.yahoo@mail.yahoo.com>
 <188943617.29620.1465243726034.JavaMail.zimbra@efficios.com>
 <897997834.5701164.1465244342476.JavaMail.yahoo@mail.yahoo.com>
 <208245300.3358603.1469134061370.JavaMail.yahoo@mail.yahoo.com>
 <1787099143.77815.1469138309989.JavaMail.zimbra@efficios.com>
Reply-To: "Mark E. Dawson, Jr." <medawsonjr@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7384814561769924923=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from nm4.bullet.mail.bf1.yahoo.com (nm4.bullet.mail.bf1.yahoo.com
 [98.139.212.163])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 4E042A2BA9
 for <lttng-dev@lists.lttng.org>; Thu, 21 Jul 2016 23:21:03 +0000 (UTC)
In-Reply-To: <1787099143.77815.1469138309989.JavaMail.zimbra@efficios.com>
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

--===============7384814561769924923==
Content-Type: multipart/alternative;
	boundary="----=_Part_3413956_1491553712.1469142858852"

------=_Part_3413956_1491553712.1469142858852
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thanks!

      From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 To: Mark E. Dawson <medawsonjr@yahoo.com>=20
Cc: lttng-dev <lttng-dev@lists.lttng.org>
 Sent: Thursday, July 21, 2016 4:58 PM
 Subject: Re: [lttng-dev] Practical recommendation for max update rate with=
 QSBR
  =20
----- On Jul 21, 2016, at 4:47 PM, Mark E. Dawson <medawsonjr@yahoo.com> wr=
ote:

All,
I've read the documentation regarding reader throughput drop-offs with high=
 update rates due to the pointer exchanging between readers-writers, and th=
e general admonition of using URCU only for mostly-read workloads with rela=
tively infrequent updates.
However, is there a general rule-of-thumb suggestion for highest recommende=
d update rate sustainable for optimal performance with URCU (in particular,=
 the QSBR flavor) for highly threaded applications deployed on high core co=
unt machines (Intel)? The example case would be a single updater and 20 - 3=
0 reader threads.

Hi Mark,

We have some relevant measurements in the supplementary material of:

Desnoyers, Mathieu, McKenney, Paul. E., Stern, Alan S., Dagenais, Michel R.=
 and Walpole, Jonathan, User-Level Implementations of Read-Copy Update. IEE=
E Transaction on Parallel and Distributed Systems, 23 (2): 375-382 (2012).
A copy can be found at http://www.efficios.com/publications

See p. 10 of supplementary material,=C2=A0 Fig. 14:

"Comparison of Pointer Exchange and Ideal RCU Update Overhead, 8-core Intel=
 Xeon, Logarithmic Scale"

Since you are doing pointer exchange, you will want to look at the "QSBR"li=
ne, which stays at 1000M reads/s up to 100000 updates/s, and then startsdro=
pping.
On the 64-core POWER5+ (Fig. 15), read speed starts dropping near 100000upd=
ates/s too.

Thanks,
Mathieu

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

  
------=_Part_3413956_1491553712.1469142858852
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"color:#000; background-color:#fff; f=
ont-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, =
sans-serif;font-size:16px"><div id=3D"yui_3_16_0_ym19_1_1469142636343_9327"=
><span>Thanks!</span></div><div class=3D"qtdSeparateBR" id=3D"yui_3_16_0_ym=
19_1_1469142636343_9342"><br><br></div><div class=3D"yahoo_quoted" id=3D"yu=
i_3_16_0_ym19_1_1469142636343_9347" style=3D"display: block;">  <div style=
=3D"font-family: HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Gr=
ande, sans-serif; font-size: 16px;" id=3D"yui_3_16_0_ym19_1_1469142636343_9=
346"> <div style=3D"font-family: HelveticaNeue, Helvetica Neue, Helvetica, =
Arial, Lucida Grande, sans-serif; font-size: 16px;" id=3D"yui_3_16_0_ym19_1=
_1469142636343_9345"> <div dir=3D"ltr" id=3D"yui_3_16_0_ym19_1_146914263634=
3_9344"> <font size=3D"2" face=3D"Arial" id=3D"yui_3_16_0_ym19_1_1469142636=
343_9343"> <hr size=3D"1"> <b><span style=3D"font-weight:bold;">From:</span=
></b> Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;<br> <b><span=
 style=3D"font-weight: bold;">To:</span></b> Mark E. Dawson &lt;medawsonjr@=
yahoo.com&gt; <br><b><span style=3D"font-weight: bold;">Cc:</span></b> lttn=
g-dev &lt;lttng-dev@lists.lttng.org&gt;<br> <b><span style=3D"font-weight: =
bold;">Sent:</span></b> Thursday, July 21, 2016 4:58 PM<br> <b><span style=
=3D"font-weight: bold;">Subject:</span></b> Re: [lttng-dev] Practical recom=
mendation for max update rate with QSBR<br> </font> </div> <div class=3D"y_=
msg_container" id=3D"yui_3_16_0_ym19_1_1469142636343_9348"><br><div id=3D"y=
iv7547042382"><div id=3D"yui_3_16_0_ym19_1_1469142636343_9351"><div style=
=3D"font-family:arial, helvetica, sans-serif;font-size:12pt;color:#000000;"=
 id=3D"yui_3_16_0_ym19_1_1469142636343_9350"><div class=3D"yiv7547042382yqt=
6981311603" id=3D"yiv7547042382yqt34565"><div id=3D"yui_3_16_0_ym19_1_14691=
42636343_9349"><span id=3D"yiv7547042382zwchr">----- On Jul 21, 2016, at 4:=
47 PM, Mark E. Dawson &lt;medawsonjr@yahoo.com&gt; wrote:<br clear=3D"none"=
></span></div><div id=3D"yui_3_16_0_ym19_1_1469142636343_9354"><blockquote =
style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;col=
or:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fami=
ly:Helvetica, Arial, sans-serif;font-size:12pt;" id=3D"yui_3_16_0_ym19_1_14=
69142636343_9353"><div style=3D"color:#000;background-color:#fff;font-famil=
y:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-seri=
f;font-size:16px;" id=3D"yui_3_16_0_ym19_1_1469142636343_9352"><div id=3D"y=
iv7547042382yui_3_16_0_ym19_1_1469131414329_10925">All,</div><div id=3D"yiv=
7547042382yui_3_16_0_ym19_1_1469131414329_10925"><br clear=3D"none"></div><=
div id=3D"yiv7547042382yui_3_16_0_ym19_1_1469131414329_10925">I've read the=
 documentation regarding reader throughput drop-offs with high update rates=
 due to the pointer exchanging between readers-writers, and the general adm=
onition of using URCU only for mostly-read workloads with relatively infreq=
uent updates.</div><div id=3D"yiv7547042382yui_3_16_0_ym19_1_1469131414329_=
10925"><br clear=3D"none"></div><div id=3D"yiv7547042382yui_3_16_0_ym19_1_1=
469131414329_10925">However, is there a general rule-of-thumb suggestion fo=
r highest recommended update rate sustainable for optimal performance with =
URCU (in particular, the QSBR flavor) for highly threaded applications depl=
oyed on high core count machines (Intel)? The example case would be a singl=
e updater and 20 - 30 reader threads.</div></div></blockquote><div><br clea=
r=3D"none"></div><div>Hi Mark,<br clear=3D"none"></div><div><br clear=3D"no=
ne"></div><div>We have some relevant measurements in the supplementary mate=
rial of:<br clear=3D"none"></div><div><br clear=3D"none"></div><div>Desnoye=
rs, Mathieu, McKenney, Paul. E., Stern, Alan S., Dagenais, Michel R. and Wa=
lpole, Jonathan, <em>User-Level Implementations of Read-Copy Update</em>. <=
a rel=3D"nofollow" shape=3D"rect" target=3D"_blank" href=3D"http://www.comp=
uter.org/portal/web/tpds/">IEEE Transaction on Parallel and Distributed Sys=
tems</a>, 23 (2): 375-382 (2012).</div><div><br clear=3D"none"></div><div>A=
 copy can be found at http://www.efficios.com/publications<br clear=3D"none=
"></div><div><br clear=3D"none"></div><div>See p. 10 of supplementary mater=
ial,&nbsp; Fig. 14:<br clear=3D"none"></div><div><br clear=3D"none"></div><=
div>"Comparison of Pointer Exchange and Ideal RCU Update Overhead, 8-core I=
ntel Xeon, Logarithmic Scale"<br clear=3D"none"></div><div><br clear=3D"non=
e"></div>Since you are doing pointer exchange, you will want to look at the=
 "QSBR"</div></div><div>line, which stays at 1000M reads/s up to 100000 upd=
ates/s, and then starts</div><div>dropping.</div><div><br clear=3D"none"></=
div><div>On the 64-core POWER5+ (Fig. 15), read speed starts dropping near =
100000</div><div>updates/s too.<br clear=3D"none"></div><div><br clear=3D"n=
one"></div><div>Thanks,</div><div><br clear=3D"none"></div><div>Mathieu<br =
clear=3D"none"><blockquote style=3D"border-left:2px solid #1010FF;margin-le=
ft:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;tex=
t-decoration:none;font-family:Helvetica, Arial, sans-serif;font-size:12pt;"=
>_______________________________________________<br clear=3D"none">lttng-de=
v mailing list<br clear=3D"none">lttng-dev@lists.lttng.org<br clear=3D"none=
">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br clear=3D"no=
ne"></blockquote></div><div><br clear=3D"none"></div><div>-- <br clear=3D"n=
one"></div><div>Mathieu Desnoyers<br clear=3D"none">EfficiOS Inc.<br clear=
=3D"none">http://www.efficios.com</div></div></div></div><br><br></div> </d=
iv> </div>  </div></div></body></html>
------=_Part_3413956_1491553712.1469142858852--

--===============7384814561769924923==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7384814561769924923==--
