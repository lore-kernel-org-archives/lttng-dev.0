From: Jeffrey Chen <cpthk@live.com>
Subject: LTTng on Docker
Date: Fri, 7 Apr 2017 22:35:33 +0000
Message-ID: <CY4PR13MB152689FB577CFBEF185495EAC70C0__26387.9687911414$1491660587$gmane$org@CY4PR13MB1526.namprd13.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8642086493103705805=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-oln040092004090.outbound.protection.outlook.com [40.92.4.90])
 by lists.lttng.org (Postfix) with ESMTPS id 3w0dcd6XjVzk2l
 for <lttng-dev@lists.lttng.org>; Sat,  8 Apr 2017 14:09:53 +0000 (UTC)
Content-Language: en-US
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

--===============8642086493103705805==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR13MB152689FB577CFBEF185495EAC70C0CY4PR13MB1526namp_"

--_000_CY4PR13MB152689FB577CFBEF185495EAC70C0CY4PR13MB1526namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi:


I am trying to have LTTng UST tracing inside a docker container. I wasn't a=
ble to get the UST tracing working. LTTng would not write any UST trace fil=
es in the directory, even though it printed it would. Has it been tested be=
fore? Is there any known problem?


$ lttng enable-channel --session test --userspace channel0

Error: Channel channel0: UST create channel failed (session ServiceFabric_0=
)
Error: Command error



Thanks.


--_000_CY4PR13MB152689FB577CFBEF185495EAC70C0CY4PR13MB1526namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p>Hi:</p>
<p><br>
</p>
<p>I am trying to have LTTng UST tracing inside a docker container. I wasn'=
t able to get the UST tracing working. LTTng would not write any UST trace =
files in the directory, even though it printed it would. Has it been tested=
 before? Is there any known problem?</p>
<p><br>
</p>
<p>$ lttng enable-channel <span>--session test --userspace channel0</span><=
br>
</p>
<p></p>
<div>Error: Channel channel0: UST create channel failed (session ServiceFab=
ric_0)<br>
Error: Command error<br>
</div>
<br>
<p></p>
<p><br>
</p>
<p>Thanks.<br>
</p>
<p><br>
</p>
</div>
</body>
</html>

--_000_CY4PR13MB152689FB577CFBEF185495EAC70C0CY4PR13MB1526namp_--

--===============8642086493103705805==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============8642086493103705805==--
