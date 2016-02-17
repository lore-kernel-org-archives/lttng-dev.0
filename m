From: Jeffrey Chen <cpthk@hotmail.com>
Subject: LTTng buffer mode
Date: Wed, 17 Feb 2016 00:55:50 +0000
Message-ID: <BY2PR15MB0759C952513EFB6E18812650ABAE0__41862.5796250582$1455670623$gmane$org@BY2PR15MB0759.namprd15.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1985613594=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from col004-omc3s18.hotmail.com ([65.55.34.157])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <cpthk@hotmail.com>) id 1aVqPP-00088V-Ea
 for lttng-dev@lists.lttng.org; Tue, 16 Feb 2016 19:56:03 -0500
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

--===============1985613594==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY2PR15MB0759C952513EFB6E18812650ABAE0BY2PR15MB0759namp_"

--_000_BY2PR15MB0759C952513EFB6E18812650ABAE0BY2PR15MB0759namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi LTTng community:


I have a question about LTTng buffer mode. According to documentation, LTTn=
g supports 2 buffer modes, per-pid, and per-uid. Is there any mode to have =
a global buffer that does not have separate buffers? The reason I asked is =
because, LTTng writes different buffer traces to different directory/file. =
It is much more difficult for us to post-process separate directories. We w=
ould like to have all traces write into one single buffer and directory/fil=
e, so it is easier to do post-processing. Thanks.


--_000_BY2PR15MB0759C952513EFB6E18812650ABAE0BY2PR15MB0759namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt; color:#000000; ba=
ckground-color:#FFFFFF; font-family:Calibri,Arial,Helvetica,sans-serif">
<p>Hi LTTng community:</p>
<p><br>
</p>
<p>I have a question about LTTng buffer mode. According to documentation, L=
TTng supports 2 buffer modes, per-pid, and per-uid. Is there any mode to ha=
ve a global buffer that does not have separate buffers? The reason I asked =
is because, LTTng writes different
 buffer traces to different directory/file. It is much more difficult for u=
s to post-process separate directories. We would like to have all traces wr=
ite into one single buffer and directory/file, so it is easier to do post-p=
rocessing. Thanks.</p>
<p><br>
</p>
</div>
</body>
</html>

--_000_BY2PR15MB0759C952513EFB6E18812650ABAE0BY2PR15MB0759namp_--


--===============1985613594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1985613594==--
