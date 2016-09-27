From: Jeffrey Chen <cpthk@live.com>
Subject: LTTng memory map
Date: Tue, 27 Sep 2016 18:20:03 +0000
Message-ID: <CY4PR13MB14149C4EF327ABE7F53ED61AC7CC0__37435.9029032805$1475000739$gmane$org@CY4PR13MB1414.namprd13.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4754804397136467548=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from COL004-OMC4S4.hotmail.com (col004-omc4s4.hotmail.com
 [65.55.34.206])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 068C9A3C51
 for <lttng-dev@lists.lttng.org>; Tue, 27 Sep 2016 18:26:28 +0000 (UTC)
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
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============4754804397136467548==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR13MB14149C4EF327ABE7F53ED61AC7CC0CY4PR13MB1414namp_"

--_000_CY4PR13MB14149C4EF327ABE7F53ED61AC7CC0CY4PR13MB1414namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi LTTng:


Our service has been running overnight with LTTng enabled to do some memory=
 consumption testing. We noticed the linux pmap output would have several m=
emory map used by LTTng, and are marked as deleted. Do you know what are th=
em? Why are they left in the system and marked as deleted? Thanks.


00007fc3017ee000   40968     592     592 rw-s- ust-shm-consumer-58905 (dele=
ted)
00007fc3017ee000       0       0       0 rw-s- ust-shm-consumer-58905 (dele=
ted)
00007fc303ff0000   40968       0       0 rw-s- ust-shm-consumer-58905 (dele=
ted)
00007fc303ff0000       0       0       0 rw-s- ust-shm-consumer-58905 (dele=
ted)
00007fc3067f2000   40968       0       0 rw-s- ust-shm-consumer-58905 (dele=
ted)
00007fc3067f2000       0       0       0 rw-s- ust-shm-consumer-58905 (dele=
ted)
00007fc308ff4000   40968       0       0 rw-s- ust-shm-consumer-58905 (dele=
ted)
00007fc308ff4000       0       0       0 rw-s- ust-shm-consumer-58905 (dele=
ted)
00007fc30b7f6000   40968       0       0 rw-s- ust-shm-consumer-58905 (dele=
ted)
00007fc30b7f6000       0       0       0 rw-s- ust-shm-consumer-58905 (dele=
ted)
00007fc30dff8000   40968     524     524 rw-s- ust-shm-consumer-58905 (dele=
ted)
00007fc30dff8000       0       0       0 rw-s- ust-shm-consumer-58905 (dele=
ted)
00007fc3107fa000   40968       0       0 rw-s- ust-shm-consumer-58905 (dele=
ted)
00007fc3107fa000       0       0       0 rw-s- ust-shm-consumer-58905 (dele=
ted)
00007fc312ffc000   40968     244     244 rw-s- ust-shm-consumer-58905 (dele=
ted)
00007fc312ffc000       0       0       0 rw-s- ust-shm-consumer-58905 (dele=
ted)
00007fc3157fe000   40968     396     396 rw-s- ust-shm-consumer-58905 (dele=
ted)
00007fc3157fe000       0       0       0 rw-s- ust-shm-consumer-58905 (dele=
ted)


--_000_CY4PR13MB14149C4EF327ABE7F53ED61AC7CC0CY4PR13MB1414namp_
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
-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Hi LTTng:</p>
<p><br>
</p>
<p>Our service has been running overnight with LTTng enabled to do some mem=
ory consumption testing. We noticed the linux pmap output would have severa=
l memory map used by LTTng, and are marked as deleted. Do you know what are=
 them? Why are they left in the
 system and marked as deleted? Thanks.<br>
</p>
<p><br>
</p>
<p><br>
</p>
<p></p>
<div>
<p class=3D"MsoNormal">00007fc3017ee000&nbsp;&nbsp; 40968&nbsp;&nbsp;&nbsp;=
&nbsp; 592&nbsp;&nbsp;&nbsp;&nbsp; 592 rw-s- ust-shm-consumer-58905 (delete=
d)</p>
<p class=3D"MsoNormal">00007fc3017ee000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0 rw-s- ust-shm-consumer-58905 (deleted)</p>
<p class=3D"MsoNormal">00007fc303ff0000&nbsp;&nbsp; 40968&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 rw-s- ust-shm-co=
nsumer-58905 (deleted)</p>
<p class=3D"MsoNormal">00007fc303ff0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0 rw-s- ust-shm-consumer-58905 (deleted)</p>
<p class=3D"MsoNormal">00007fc3067f2000&nbsp;&nbsp; 40968&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 rw-s- ust-shm-co=
nsumer-58905 (deleted)</p>
<p class=3D"MsoNormal">00007fc3067f2000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0 rw-s- ust-shm-consumer-58905 (deleted)</p>
<p class=3D"MsoNormal">00007fc308ff4000&nbsp;&nbsp; 40968&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 rw-s- ust-shm-co=
nsumer-58905 (deleted)</p>
<p class=3D"MsoNormal">00007fc308ff4000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0 rw-s- ust-shm-consumer-58905 (deleted)</p>
<p class=3D"MsoNormal">00007fc30b7f6000&nbsp;&nbsp; 40968&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 rw-s- ust-shm-co=
nsumer-58905 (deleted)</p>
<p class=3D"MsoNormal">00007fc30b7f6000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0 rw-s- ust-shm-consumer-58905 (deleted)</p>
<p class=3D"MsoNormal">00007fc30dff8000&nbsp;&nbsp; 40968&nbsp;&nbsp;&nbsp;=
&nbsp; 524&nbsp;&nbsp;&nbsp;&nbsp; 524 rw-s- ust-shm-consumer-58905 (delete=
d)</p>
<p class=3D"MsoNormal">00007fc30dff8000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0 rw-s- ust-shm-consumer-58905 (deleted)</p>
<p class=3D"MsoNormal">00007fc3107fa000&nbsp;&nbsp; 40968&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 rw-s- ust-shm-co=
nsumer-58905 (deleted)</p>
<p class=3D"MsoNormal">00007fc3107fa000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0 rw-s- ust-shm-consumer-58905 (deleted)</p>
<p class=3D"MsoNormal">00007fc312ffc000&nbsp;&nbsp; 40968&nbsp;&nbsp;&nbsp;=
&nbsp; 244&nbsp;&nbsp;&nbsp;&nbsp; 244 rw-s- ust-shm-consumer-58905 (delete=
d)</p>
<p class=3D"MsoNormal">00007fc312ffc000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0 rw-s- ust-shm-consumer-58905 (deleted)</p>
<p class=3D"MsoNormal">00007fc3157fe000&nbsp;&nbsp; 40968&nbsp;&nbsp;&nbsp;=
&nbsp; 396&nbsp;&nbsp;&nbsp;&nbsp; 396 rw-s- ust-shm-consumer-58905 (delete=
d)</p>
<p class=3D"MsoNormal">00007fc3157fe000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0 rw-s- ust-shm-consumer-58905 (deleted)</p>
</div>
<br>
<p></p>
</div>
</body>
</html>

--_000_CY4PR13MB14149C4EF327ABE7F53ED61AC7CC0CY4PR13MB1414namp_--

--===============4754804397136467548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4754804397136467548==--
