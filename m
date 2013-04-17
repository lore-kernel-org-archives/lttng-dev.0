From: Hari Prasad Kalavakunta <Hari.Prasad@radisys.com>
Subject: LTTNG UST configure error (lttng-ust-2.1.2)
Date: Wed, 17 Apr 2013 17:28:22 +0000
Message-ID: <05E83BDD0E1F054FA73F00F6970F05C60618B3__21319.1924304285$1366219748$gmane$org@CH1PRD0810MB394.namprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1154841156=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]
	helo=va3outboundpool.messaging.microsoft.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Hari.Prasad@radisys.com>) id 1USW9t-00029D-Dg
	for lttng-dev@lists.lttng.org; Wed, 17 Apr 2013 13:28:37 -0400
Received: from mail200-va3 (localhost [127.0.0.1])	by
	mail200-va3-R.bigfish.com (Postfix) with ESMTP id 81368D803A2	for
	<lttng-dev@lists.lttng.org>; Wed, 17 Apr 2013 17:28:29 +0000 (UTC)
Received: from VA3EHSMHS017.bigfish.com (unknown [10.7.14.230])	by
	mail200-va3.bigfish.com (Postfix) with ESMTP id E96F3C00047	for
	<lttng-dev@lists.lttng.org>; Wed, 17 Apr 2013 17:28:26 +0000 (UTC)
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

--===============1154841156==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_05E83BDD0E1F054FA73F00F6970F05C60618B3CH1PRD0810MB394na_"

--_000_05E83BDD0E1F054FA73F00F6970F05C60618B3CH1PRD0810MB394na_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi lttng-dev,

I am struck with the following road block. Could you please help me.

While cross-compiling  LTTNG UST for ppc32 I choose --disable-libtool-linkd=
ep-fixup (https://bugs.lttng.org/issues/321) for configure to avoid depende=
ncy on libuuid as shown below.

CFLAGS=3D"-m32 -g -O2" ./configure --disable-libtool-linkdep-fixup  --prefi=
x=3D/home/xxx/linux-3.4.3/ --host=3Dpowerpc-linux --with-sysroot=3D/home/xx=
x/linux-3.4.3/

Yet, the dependencies are not completely removed. I am cross compiling LTTN=
G UST for PPC32. It did not look like I need libuuid. Could you please let =
me know how to overcome it. Or do I need libuuid for PPC32?

I have successfully cross compiled and installed userspace-rcu for ppc32.

Please let me know if I need to provide any additional details.

Regards,
Hari


--_000_05E83BDD0E1F054FA73F00F6970F05C60618B3CH1PRD0810MB394na_
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
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Verdana;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi lttng-dev,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am struck with the following road block. Could you=
 please help me.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">While cross-compiling &nbsp;LTTNG UST for ppc32 I ch=
oose <span style=3D"font-size:8.0pt;font-family:&quot;Verdana&quot;,&quot;s=
ans-serif&quot;;color:#484848">
--disable-libtool-linkdep-fixup (</span><a href=3D"https://bugs.lttng.org/i=
ssues/321">https://bugs.lttng.org/issues/321</a>) for configure to avoid de=
pendency on libuuid as shown below.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">CFLAGS=3D&quot;-m32 -g -O2&quot; ./configure --disab=
le-libtool-linkdep-fixup&nbsp; --prefix=3D/home/xxx/linux-3.4.3/ --host=3Dp=
owerpc-linux --with-sysroot=3D/home/xxx/linux-3.4.3/<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Yet, the dependencies are not completely removed. I =
am cross compiling LTTNG UST for PPC32. It did not look like I need libuuid=
. Could you please let me know how to overcome it. Or do I need libuuid for=
 PPC32?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have successfully cross compiled and installed use=
rspace-rcu for ppc32.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please let me know if I need to provide any addition=
al details.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Hari<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_05E83BDD0E1F054FA73F00F6970F05C60618B3CH1PRD0810MB394na_--


--===============1154841156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1154841156==--
