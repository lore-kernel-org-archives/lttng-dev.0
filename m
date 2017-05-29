From: kirankumarp@uurmi.com
Subject: C APIs tracing control
Date: Mon, 29 May 2017 06:32:35 +0000
Message-ID: <4485def9e3e2e8b07f166e9fdbcdbe3a__46739.0065351084$1496071315$gmane$org@cloudmailn6.netcore.co.in>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6522534203387040974=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtpout3.netcore.co.in (mail75.cleanmail.in [202.162.241.75])
 by lists.lttng.org (Postfix) with ESMTPS id 3wbnFW5g2Xz11mR
 for <lttng-dev@lists.lttng.org>; Mon, 29 May 2017 06:41:19 +0000 (UTC)
Received: from cf1.netcore.co.in (secure1.netcore.co.in [202.162.242.11])
 by smtpout3.netcore.co.in (Postfix) with ESMTP id 7DD7D52038F
 for <lttng-dev@lists.lttng.org>; Mon, 29 May 2017 12:02:56 +0530 (IST)
Received: from cloudmailn6.netcore.co.in (unknown [202.162.242.59])
 by smtp16.netcore.in (Postfix) with ESMTP id C958F1CC4EA
 for <lttng-dev@lists.lttng.org>; Mon, 29 May 2017 12:02:35 +0530 (IST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============6522534203387040974==
Content-Type: multipart/alternative;
 boundary="----=_Part_942_875295838.1496039555"


------=_Part_942_875295838.1496039555
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: Quoted-Printable

Hi,=0Awe are developing an application and want to have LTTng control wit=
hin it. We would like to know the C APIs for it.=0Awe require following A=
PIs following command line commands-=0Alttng create =0Alttng list =0Alttn=
g enable-event =0Alttng start=0Alttng stop=0Alttng destroy=0AWe could fin=
d some documentation at but not sure if we are right. Also it will be gre=
at help, if you can provide an makefile for this (to link the libraries a=
nd Paths to be included).=0AWe tried "lttng_create_handle", "lttng_create=
_session" API (as mentioned in the documentation) but its not getting com=
piled.=0APlease help on this regard.=0AThanks in advance.=0ARegards=0AKir=
an Kumar

------=_Part_942_875295838.1496039555
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: Quoted-Printable

<!DOCTYPE html><html><head><meta http-equiv=3D"Content-Type" content=3D"t=
ext/html; charset=3Dutf-8" /></head><body><div data-crea=3D"font-wrapper"=
 style=3D"font-family: Tahoma; font-size: 16px"><div><br>Hi,</div><div><b=
r></div><div>we are developing an application and want to have LTTng cont=
rol within it. We would like to know the C APIs for it.</div><div><br></d=
iv><div>we require following APIs following command line commands-</div><=
div><br></div><div>lttng create </div><div>lttng list </div><div>lttng en=
able-event </div><div>lttng start</div><div>lttng stop<br>lttng destroy</=
div><div><br></div><div>We could find some documentation at but not sure =
if we are right. Also it will be great help, if you can provide an makefi=
le for this (to link the libraries and Paths to be included).</div><div><=
br></div><div>We tried "lttng_create_handle", "<span class=3D"nf"><font c=
olor=3D"#000000">lttng_create_session"</font></span> API (as mentioned in=
 the documentation) but its not getting compiled.</div><div><br></div><di=
v>Please help on this regard.</div><div><br></div><div><br></div><div>Tha=
nks in advance.</div><div><br></div><div><br></div><div>Regards</div><div=
>Kiran Kumar</div><div><b></b><i></i><u></u><sub></sub><sup></sup><strike=
></strike><b></b><i></i><u></u><sub></sub><sup></sup><strike></strike><b>=
</b><i></i><u></u><sub></sub><sup></sup><strike></strike><b></b><i></i><u=
></u><sub></sub><sup></sup><strike></strike><br></div><div></div></div></=
body></html>

------=_Part_942_875295838.1496039555--

--===============6522534203387040974==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6522534203387040974==--
