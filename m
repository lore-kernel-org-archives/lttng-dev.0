From: "Mark E. Dawson, Jr." <medawsonjr@yahoo.com>
Subject: Re: Removing timing overhead via tracepoint()
Date: Wed, 28 Sep 2016 20:12:59 +0000 (UTC)
Message-ID: <266465597.1115207.1475093579363__24001.6180011027$1475093603$gmane$org@mail.yahoo.com>
References: <44700566.4933962.1474914770059.ref@mail.yahoo.com>
 <44700566.4933962.1474914770059@mail.yahoo.com>
Reply-To: "Mark E. Dawson, Jr." <medawsonjr@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5640518778402020995=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from nm15.bullet.mail.bf1.yahoo.com (nm15.bullet.mail.bf1.yahoo.com
 [98.139.212.174])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 4155FA2E87
 for <lttng-dev@lists.lttng.org>; Wed, 28 Sep 2016 20:14:22 +0000 (UTC)
In-Reply-To: <44700566.4933962.1474914770059@mail.yahoo.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============5640518778402020995==
Content-Type: multipart/alternative;
	boundary="----=_Part_1115206_369954236.1475093579359"

------=_Part_1115206_369954236.1475093579359
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

ping

      From: "Mark E. Dawson, Jr." <medawsonjr@yahoo.com>
 To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org> 
 Sent: Monday, September 26, 2016 1:32 PM
 Subject: Removing timing overhead via tracepoint()
   
All,
Simple question alert!
If I want to remove a ton of compiled-in calls to an "rdtscp-based" C timing function and replace them with conditionally-enabled timing based on whether or not I enable a tracing session, I can do so by adding the aforementioned call as one of the arguments to tracepoint() with our defined provider and event name, correct?

   
------=_Part_1115206_369954236.1475093579359
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"color:#000; background-color:#fff; f=
ont-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, =
sans-serif;font-size:16px"><div><span>ping</span></div><div class=3D"qtdSep=
arateBR" id=3D"yui_3_16_0_ym19_1_1475093483021_6918"><br><br></div><div cla=
ss=3D"yahoo_quoted" id=3D"yui_3_16_0_ym19_1_1475093483021_6940" style=3D"di=
splay: block;">  <div style=3D"font-family: HelveticaNeue, Helvetica Neue, =
Helvetica, Arial, Lucida Grande, sans-serif; font-size: 16px;" id=3D"yui_3_=
16_0_ym19_1_1475093483021_6939"> <div style=3D"font-family: HelveticaNeue, =
Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif; font-size: 16p=
x;" id=3D"yui_3_16_0_ym19_1_1475093483021_6938"> <div dir=3D"ltr" id=3D"yui=
_3_16_0_ym19_1_1475093483021_6937"> <font size=3D"2" face=3D"Arial" id=3D"y=
ui_3_16_0_ym19_1_1475093483021_6942"> <hr size=3D"1"> <b><span style=3D"fon=
t-weight:bold;">From:</span></b> "Mark E. Dawson, Jr." &lt;medawsonjr@yahoo=
.com&gt;<br> <b><span style=3D"font-weight: bold;">To:</span></b> "lttng-de=
v@lists.lttng.org" &lt;lttng-dev@lists.lttng.org&gt; <br> <b><span style=3D=
"font-weight: bold;">Sent:</span></b> Monday, September 26, 2016 1:32 PM<br=
> <b><span style=3D"font-weight: bold;">Subject:</span></b> Removing timing=
 overhead via tracepoint()<br> </font> </div> <div class=3D"y_msg_container=
" id=3D"yui_3_16_0_ym19_1_1475093483021_6944"><br><div id=3D"yiv6857502660"=
><div id=3D"yui_3_16_0_ym19_1_1475093483021_6947"><div style=3D"color:#000;=
background-color:#fff;font-family:HelveticaNeue, Helvetica Neue, Helvetica,=
 Arial, Lucida Grande, sans-serif;font-size:16px;" id=3D"yui_3_16_0_ym19_1_=
1475093483021_6946"><div id=3D"yiv6857502660yui_3_16_0_ym19_1_1474914422310=
_4680">All,</div><div id=3D"yiv6857502660yui_3_16_0_ym19_1_1474914422310_46=
80"><br></div><div id=3D"yiv6857502660yui_3_16_0_ym19_1_1474914422310_4680"=
 dir=3D"ltr">Simple question alert!</div><div id=3D"yiv6857502660yui_3_16_0=
_ym19_1_1474914422310_4680" dir=3D"ltr"><br></div><div id=3D"yiv6857502660y=
ui_3_16_0_ym19_1_1474914422310_4680" dir=3D"ltr">If I want to remove a ton =
of compiled-in calls to an "rdtscp-based" C timing function and replace the=
m with conditionally-enabled timing based on whether or not I enable a trac=
ing session, I can do so by adding the aforementioned call as one of the ar=
guments to tracepoint() with our defined provider and event name, correct?<=
/div></div></div></div><br><br></div> </div> </div>  </div></div></body></h=
tml>
------=_Part_1115206_369954236.1475093579359--

--===============5640518778402020995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5640518778402020995==--
