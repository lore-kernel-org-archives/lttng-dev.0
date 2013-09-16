From: "Steffen, Kai-Uwe (Kai-Uwe)" <kai-uwe.steffen@alcatel-lucent.com>
Subject: Tracing page waits with LTTng 2.3.0
Date: Mon, 16 Sep 2013 13:23:09 +0000
Message-ID: <211FA304CEAAEE4AA25085F0CEB43BD70812D210__43537.8617993139$1380114229$gmane$org@FR711WXCHMBA02.zeu.alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0093412517=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ihemail1.lucent.com ([135.245.0.33])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <kai-uwe.steffen@alcatel-lucent.com>)
	id 1VLYlq-0000Et-Kj
	for lttng-dev@lists.lttng.org; Mon, 16 Sep 2013 09:23:25 -0400
Received: from fr712usmtp2.zeu.alcatel-lucent.com (h135-239-2-42.lucent.com
	[135.239.2.42])
	by ihemail1.lucent.com (8.13.8/IER-o) with ESMTP id r8GDNCMq019672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <lttng-dev@lists.lttng.org>; Mon, 16 Sep 2013 08:23:14 -0500 (CDT)
Received: from FR711WXCHHUB02.zeu.alcatel-lucent.com
	(fr711wxchhub02.zeu.alcatel-lucent.com [135.239.2.112])
	by fr712usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id
	r8GDNAtX014857
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <lttng-dev@lists.lttng.org>; Mon, 16 Sep 2013 15:23:10 +0200
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

--===============0093412517==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_211FA304CEAAEE4AA25085F0CEB43BD70812D210FR711WXCHMBA02z_"

--_000_211FA304CEAAEE4AA25085F0CEB43BD70812D210FR711WXCHMBA02z_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi.

Currently I'm working with LTTng 2.3.0 for Ubuntu 12.4, to see if this vers=
ion would meet our requirements.
With old LTT and LTTng 0.x it was possible to trace page waits.
Tracepoints were called "Page Wait" for LTT and "buffer_wait_start" "buffer=
_wait_end" for LTTng 0.x.

Now I looked for the tracepoints available with 2.3.0 and didn't find trace=
point for the page waits.

Lttng list -k

Can you tell me if there is a tracepoint available in LTTng 2.3 or is it no=
t supported yet?

Thanks Kai

--_000_211FA304CEAAEE4AA25085F0CEB43BD70812D210FR711WXCHMBA02z_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 2.0cm 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"DE" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Currently I&#8217;m working wit=
h LTTng 2.3.0 for Ubuntu 12.4, to see if this version would meet our requir=
ements.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">With old LTT and LTTng 0.x it w=
as possible to trace page waits.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Tracepoints were called &#8220;=
Page Wait&#8221; for LTT and &#8220;buffer_wait_start&#8221; &#8220;buffer_=
wait_end&#8221; for LTTng 0.x.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Now I looked for the tracepoint=
s available with 2.3.0 and didn&#8217;t find tracepoint for the page waits.=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Lttng list &#8211;k<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Can you tell me if there is a t=
racepoint available in LTTng 2.3 or is it not supported yet?<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks Kai<o:p></o:p></span></p=
>
</div>
</body>
</html>

--_000_211FA304CEAAEE4AA25085F0CEB43BD70812D210FR711WXCHMBA02z_--


--===============0093412517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0093412517==--
