From: =?gb2312?B?1r6y/SDT4A==?= <yuzhichang_scl@hotmail.com>
Subject: Can liburcu protect multiple independent shared
	resource?
Date: Mon, 9 Apr 2018 06:32:35 +0000
Message-ID: <HKNPR03MB2244D9D748447AAC392210ECF8BF0__25427.2728263915$1523369628$gmane$org@HKNPR03MB2244.apcprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5572500784841084600=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-oln040092253066.outbound.protection.outlook.com [40.92.253.66])
 by lists.lttng.org (Postfix) with ESMTPS id 40Kpx03bcYz15X9
 for <lttng-dev@lists.lttng.org>; Mon,  9 Apr 2018 21:09:40 -0400 (EDT)
Content-Language: zh-CN
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

--===============5572500784841084600==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_HKNPR03MB2244D9D748447AAC392210ECF8BF0HKNPR03MB2244apcp_"

--_000_HKNPR03MB2244D9D748447AAC392210ECF8BF0HKNPR03MB2244apcp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

QWNjb3JkaW5nIHRvIGh0dHBzOi8vZ2l0aHViLmNvbS91cmN1L3VzZXJzcGFjZS1yY3UvYmxvYi9t
YXN0ZXIvZG9jL3JjdS1hcGkubWQsIG5vbmUgbGlicmN1IEFQSSB0YWtlIHRoZSByZXNvdXJjZSBh
ZGRyZXNzLg0KSWYgdGhlcmUncmUgbXVsdGlwbGUgaW5kZXBlbmRlbnQgc2hhcmVkIHJlc291cmNl
LCBzZWVtcyB0aGVyZSdzIGludGVyZmVyZW5jZSBiZXR3ZWVuIHJlYWRfbG9jayBvZiByZXNvdXJj
ZSBBIGFuZCB3cml0ZV9sb2NrIG9mIHJlc291cmNlIEIuDQoNCg0KDQo=

--_000_HKNPR03MB2244D9D748447AAC392210ECF8BF0HKNPR03MB2244apcp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
According to&nbsp;<a href=3D"https://github.com/urcu/userspace-rcu/blob/mas=
ter/doc/rcu-api.md" id=3D"LPNoLP727713">https://github.com/urcu/userspace-r=
cu/blob/master/doc/rcu-api.md</a>, none&nbsp;librcu API take the resource a=
ddress.&nbsp;</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
If there're&nbsp;<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, =
Helvetica, sans-serif; font-size: 12pt;">multiple independent shared resour=
ce, seems there's i</span><span style=3D"color: rgb(0, 0, 0); font-family: =
Calibri, Helvetica, sans-serif; font-size: 12pt;">nterference
 between&nbsp;read_lock of&nbsp;</span><span style=3D"color: rgb(0, 0, 0); =
font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;">resource A a=
nd write_lock of resource B.</span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-s=
erif; font-size: 12pt;"><br>
</span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<br>
</body>
</html>

--_000_HKNPR03MB2244D9D748447AAC392210ECF8BF0HKNPR03MB2244apcp_--

--===============5572500784841084600==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5572500784841084600==--
