From: Ritchie Vickery <Ritchie.Vickery@imgtec.com>
Subject: undefined reference to `lttng_probe_register
Date: Wed, 12 Mar 2014 11:09:08 +0000
Message-ID: <77C8847D080A484EA4C78F8323DAB1FB24805A00__5479.3138908737$1394622602$gmane$org@KLMAIL01.kl.imgtec.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0587068477=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailapp01.imgtec.com ([195.89.28.114])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Ritchie.Vickery@imgtec.com>) id 1WNh2C-0006aW-Ay
	for lttng-dev@lists.lttng.org; Wed, 12 Mar 2014 07:09:18 -0400
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
	by Websense Email Security Gateway with ESMTPS id B69FB2BD7A0EC
	for <lttng-dev@lists.lttng.org>; Wed, 12 Mar 2014 11:09:08 +0000 (GMT)
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0587068477==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_77C8847D080A484EA4C78F8323DAB1FB24805A00KLMAIL01klimgte_"

--_000_77C8847D080A484EA4C78F8323DAB1FB24805A00KLMAIL01klimgte_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm trying to setup lttng for the first time.

I've made librcu, lttng-ust, lttng-tools and lttng-modules and have instrum=
ented some User code.

I have run the tool to generate the tracepoint code:
$ lttng-gen-tp ustrcv.tp -o ustrcv.h -o ustrcv.c

However, at the point where the user-mode library containing ustrcv.o gets =
linked, I see the following error:
/usr/local/include/lttng/ust-tracepoint-event.h:779: undefined reference to=
 `lttng_probe_register'

Does anyone have any ideas what I may have missed?


Many thanks,

Ritchie


--_000_77C8847D080A484EA4C78F8323DAB1FB24805A00KLMAIL01klimgte_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-GB" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;m trying to setup lttng for the first time.<=
o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;ve made librcu, lttng-ust, lttng-tools and l=
ttng-modules and have instrumented some User code.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have run the tool to generate the tracepoint code:=
<o:p></o:p></p>
<p class=3D"MsoNormal">$ lttng-gen-tp ustrcv.tp &#8211;o ustrcv.h &#8211;o =
ustrcv.c<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">However, at the point where the user-mode library co=
ntaining ustrcv.o gets linked, I see the following error:<o:p></o:p></p>
<p class=3D"MsoNormal">/usr/local/include/lttng/ust-tracepoint-event.h:779:=
 undefined reference to `lttng_probe_register'<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Does anyone have any ideas what I may have missed?<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Many thanks,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Ritchie<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_77C8847D080A484EA4C78F8323DAB1FB24805A00KLMAIL01klimgte_--


--===============0587068477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0587068477==--
