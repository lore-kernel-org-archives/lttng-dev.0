From: Jeffrey Chen <cpthk@hotmail.com>
Subject: Duplicate traces in multiple sessions
Date: Mon, 20 Jun 2016 20:35:41 +0000
Message-ID: <BY2PR15MB075908518B3A94F8995A7387AB2A0__19746.7452068397$1466454974$gmane$org@BY2PR15MB0759.namprd15.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5285197601153699731=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from BLU004-OMC4S34.hotmail.com (blu004-omc4s34.hotmail.com
 [65.55.111.173])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id A6C07A36B7
 for <lttng-dev@lists.lttng.org>; Mon, 20 Jun 2016 20:35:44 +0000 (UTC)
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

--===============5285197601153699731==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY2PR15MB075908518B3A94F8995A7387AB2A0BY2PR15MB0759namp_"

--_000_BY2PR15MB075908518B3A94F8995A7387AB2A0BY2PR15MB0759namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi LTTng community:


We are using LTTng to collect traces from our non-stopping service (our ser=
vice is running 24/7, highly available). We collect traces by rotate the tr=
ace in an interval. We do this by creating new session, stop the old sessio=
n, and process the old traces, every 10 minutes.
There are overlaps on the session since we create new session before stoppi=
ng the old session. We are seeing some traces exist in both the old session=
, and new session. This is expected. We also noticed that these duplicated =
traces could have slightly different timestamp in the two sessions, so it i=
s very difficult to do post-processing to remove the duplicates.
Assuming we could read the raw binary trace files, we would like to know wh=
ether this is any way to identify the duplicating traces. Is there any kind=
 of unique id or hash that could be used to identity the duplicate traces i=
n two sessions?


Thanks.

--_000_BY2PR15MB075908518B3A94F8995A7387AB2A0BY2PR15MB0759namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Hi LTTng community:</p>
<p><br>
</p>
<p></p>
<div>We are using LTTng to collect traces from our non-stopping service (ou=
r service is running 24/7, highly available). We collect traces by rotate t=
he trace in an interval. We do this by creating new session, stop the old s=
ession, and process the old traces,
 every 10 minutes.<br>
There are overlaps on the session since we create new session before stoppi=
ng the old session. We are seeing some traces exist in both the old session=
, and new session. This is expected. We also noticed that these duplicated =
traces could have slightly different
 timestamp in the two sessions, so it is very difficult to do post-processi=
ng to remove the duplicates.<br>
Assuming we could read the raw binary trace files, we would like to know wh=
ether this is any way to identify the duplicating traces. Is there any kind=
 of unique id or hash that could be used to identity the duplicate traces i=
n two sessions?<br>
<br>
</div>
<p></p>
<p>Thanks.<br>
</p>
</div>
</body>
</html>

--_000_BY2PR15MB075908518B3A94F8995A7387AB2A0BY2PR15MB0759namp_--

--===============5285197601153699731==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5285197601153699731==--
