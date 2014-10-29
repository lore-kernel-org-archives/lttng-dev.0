From: =?iso-8859-1?Q?Marc-Andr=E9_Laperle?= <marc-andre.laperle@ericsson.com>
Subject: Listing live sessions after a session is destroyed
Date: Wed, 29 Oct 2014 21:39:26 +0000
Message-ID: <D381217948BF4C45AF756AFC995BEB9F1C2EBF68__11464.6911774345$1414618821$gmane$org@eusaamb103.ericsson.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1977946313=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <marc-andre.laperle@ericsson.com>) id 1Xjaxq-0006rA-3w
 for lttng-dev@lists.lttng.org; Wed, 29 Oct 2014 17:39:36 -0400
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1977946313==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_D381217948BF4C45AF756AFC995BEB9F1C2EBF68eusaamb103erics_"

--_000_D381217948BF4C45AF756AFC995BEB9F1C2EBF68eusaamb103erics_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I have a viewer connected to relayd and attached to a session named "live".=
 The session is started then destroyed. Then I list the sessions using the =
same viewer and it returns the destroyed session. If I try to attach to it,=
 it returns a status LTTNG_VIEWER_ATTACH_ALREADY. I think this session shou=
ld not be listed or there should be a status that indicates that the sessio=
n doesn't exist anymore. Or is it expected that I create a new viewer befor=
e listing the sessions again?

Thank you for the help!
Marc-Andre

--_000_D381217948BF4C45AF756AFC995BEB9F1C2EBF68eusaamb103erics_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style id=3D"owaParaStyle" type=3D"text/css">P {margin-top:0;margin-bottom:=
0;}</style>
</head>
<body ocsi=3D"0" fpstyle=3D"1">
<div style=3D"direction: ltr;font-family: Tahoma;color: #000000;font-size: =
10pt;">I have a viewer connected to relayd and attached to a session named =
&quot;live&quot;. The session is started then destroyed. Then I list the se=
ssions using the same viewer and it returns
 the destroyed session. If I try to attach to it, it returns a status LTTNG=
_VIEWER_ATTACH_ALREADY. I think this session should not be listed or there =
should be a status that indicates that the session doesn't exist anymore. O=
r is it expected that I create a
 new viewer before listing the sessions again?<br>
<br>
Thank you for the help!<br>
Marc-Andre<br>
</div>
</body>
</html>

--_000_D381217948BF4C45AF756AFC995BEB9F1C2EBF68eusaamb103erics_--


--===============1977946313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1977946313==--
