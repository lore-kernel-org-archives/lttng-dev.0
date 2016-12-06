From: "Mark E. Dawson, Jr. via lttng-dev" <lttng-dev@lists.lttng.org>
Subject: Tracing a sequence of events through an application
Date: Tue, 6 Dec 2016 20:12:01 +0000 (UTC)
Message-ID: <817756865.877118.1481055121329__2250.9916023866$1481055261$gmane$org@mail.yahoo.com>
References: <817756865.877118.1481055121329.ref@mail.yahoo.com>
Reply-To: "Mark E. Dawson, Jr." <medawsonjr@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2354963344458042033=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from nm34-vm8.bullet.mail.bf1.yahoo.com
 (nm34-vm8.bullet.mail.bf1.yahoo.com [72.30.239.6])
 by lists.lttng.org (Postfix) with ESMTPS id 3tYCYq6RKLzdSR
 for <lttng-dev@lists.lttng.org>; Tue,  6 Dec 2016 20:15:59 +0000 (UTC)
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

--===============2354963344458042033==
Content-Type: multipart/alternative;
	boundary="----=_Part_877117_417079126.1481055121328"

------=_Part_877117_417079126.1481055121328
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

All,
I'm wondering if this is something anyone has ever done before:
We have a financial trading application for which we'd like to trace the ti=
ming of a sequence of related events with low impact. =C2=A0For example, tr=
acing a market data feed packet from its reception on the NIC, to its proce=
ssing in the Market Data portion of the code, and on & on via other layers =
of the application until it finally reaches the Order Execution portion of =
the code where it sends out an Order on the stock exchange. =C2=A0We're won=
dering if there's a proven reference for using LTTng-UST to enable session =
tracing which would link related activities in this way, as opposed to just=
 providing aggregate timestamps at various tracepoints within our code.
Has something like this ever been done before using LTTng-UST? If so, is th=
ere a reference available?
------=_Part_877117_417079126.1481055121328
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"color:#000; background-color:#fff; f=
ont-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, =
sans-serif;font-size:16px"><div id=3D"yui_3_16_0_ym19_1_1481054609869_29034=
">All,</div><div id=3D"yui_3_16_0_ym19_1_1481054609869_29034"><br></div><di=
v id=3D"yui_3_16_0_ym19_1_1481054609869_29034">I'm wondering if this is som=
ething anyone has ever done before:</div><div id=3D"yui_3_16_0_ym19_1_14810=
54609869_29034"><br></div><div id=3D"yui_3_16_0_ym19_1_1481054609869_29034"=
 dir=3D"ltr">We have a financial trading application for which we'd like to=
 trace the timing of a sequence of related events with low impact. &nbsp;Fo=
r example, tracing a market data feed packet from its reception on the NIC,=
 to its processing in the Market Data portion of the code, and on &amp; on =
via other layers of the application until it finally reaches the Order Exec=
ution portion of the code where it sends out an Order on the stock exchange=
. &nbsp;We're wondering if there's a proven reference for using LTTng-UST t=
o enable session tracing which would link related activities in this way, a=
s opposed to just providing aggregate timestamps at various tracepoints wit=
hin our code.</div><div id=3D"yui_3_16_0_ym19_1_1481054609869_29034" dir=3D=
"ltr"><br></div><div id=3D"yui_3_16_0_ym19_1_1481054609869_29034" dir=3D"lt=
r">Has something like this ever been done before using LTTng-UST? If so, is=
 there a reference available?</div></div></body></html>
------=_Part_877117_417079126.1481055121328--

--===============2354963344458042033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2354963344458042033==--
