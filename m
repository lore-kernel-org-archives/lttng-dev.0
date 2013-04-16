From: Hari Prasad Kalavakunta <Hari.Prasad@radisys.com>
Subject: Re: linux 3.4.3 and LTTNG patch files
Date: Tue, 16 Apr 2013 20:26:25 +0000
Message-ID: <05E83BDD0E1F054FA73F00F6970F05C6060DCB__8737.32037512145$1366144022$gmane$org@CH1PRD0810MB394.namprd08.prod.outlook.com>
References: <05E83BDD0E1F054FA73F00F6970F05C6060B7D@CH1PRD0810MB394.namprd08.prod.outlook.com>
	<CAE_Gge2moUyd6vJxWM_7G+AGh4_yV2iyxVQX9naDjoOyX-aTxg@mail.gmail.com>
	<05E83BDD0E1F054FA73F00F6970F05C6060DA6@CH1PRD0810MB394.namprd08.prod.outlook.com>
	<CAE_Gge1h+pDe8_fstqdaGs2zZ99kSVriQgMt6k5F263_d5qRHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1809878094=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]
	helo=ch1outboundpool.messaging.microsoft.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Hari.Prasad@radisys.com>) id 1USCSY-0000Ay-Nz
	for lttng-dev@lists.lttng.org; Tue, 16 Apr 2013 16:26:34 -0400
In-Reply-To: <CAE_Gge1h+pDe8_fstqdaGs2zZ99kSVriQgMt6k5F263_d5qRHw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?Rapha=EBl_Beamonte?= <raphael.beamonte@polymtl.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1809878094==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_05E83BDD0E1F054FA73F00F6970F05C6060DCBCH1PRD0810MB394na_"

--_000_05E83BDD0E1F054FA73F00F6970F05C6060DCBCH1PRD0810MB394na_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks, Rapha=EBl

"With LTTng 2.x, you just have to build and install the kernel modules (ltt=
ng-modules) for kernel tracing,"

I hope you meat for both User Space Tracing and Kernel Tracing !!!

Regards,
Hari

From: nashii@gmail.com [mailto:nashii@gmail.com] On Behalf Of Rapha=EBl Bea=
monte
Sent: Wednesday, April 17, 2013 1:52 AM
To: Hari Prasad Kalavakunta
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] linux 3.4.3 and LTTNG patch files

Hello Hari,
2013/4/16 Hari Prasad Kalavakunta <Hari.Prasad@radisys.com<mailto:Hari.Pras=
ad@radisys.com>>
Could you please let me know if these installation can be done without patc=
hing the kernel  (unlike lttng 0.x)

With LTTng 2.x, you just have to build and install the kernel modules (lttn=
g-modules) for kernel tracing, you don't need to patch the kernel like it w=
as necessary for LTTng 0.x.
Sorry again for taking your time. I am just getting started :(

No problem, just don't forget to add the lttng-dev list in copy when you an=
swer !

Rapha=EBl

2013/4/16 Hari Prasad Kalavakunta <Hari.Prasad@radisys.com<mailto:Hari.Pras=
ad@radisys.com>>
Hi Rapha=EBl

I have referred incorrectly to 0.x while looking at LTTNG Quick Start Guide=
.

I have now looked at download page http://lttng.org/download

Below section and links appears to be relevant for me.
LTTng 2.1 "Basse Messe"<http://lttng.org/version-naming> - Tracer toolchain
LTTng-tools 2.1.1<http://lttng.org/files/lttng-tools/lttng-tools-2.1.1.tar.=
bz2> (Changelog)<http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob_plain;f=
=3DChangeLog;hb=3Drefs/heads/stable-2.1>
the trace control client
LTTng-modules 2.1.1<http://lttng.org/files/lttng-modules/lttng-modules-2.1.=
1.tar.bz2> (Changelog)<http://git.lttng.org/?p=3Dlttng-modules.git;a=3Dblob=
_plain;f=3DChangeLog;hb=3Drefs/heads/stable-2.1>
the kernel modules (requires at least Linux 2.6.38)
LTTng-UST 2.1.2<http://lttng.org/files/lttng-ust/lttng-ust-2.1.2.tar.bz2> (=
Changelog)<http://git.lttng.org/?p=3Dlttng-ust.git;a=3Dblob_plain;f=3DChang=
eLog;hb=3Drefs/heads/stable-2.1>
the userspace tracing library

Could you please let me know if these installation can be done without patc=
hing the kernel  (unlike lttng 0.x)

Sorry again for taking your time. I am just getting started :(

Regards,
Hari

From: nashii@gmail.com<mailto:nashii@gmail.com> [mailto:nashii@gmail.com<ma=
ilto:nashii@gmail.com>] On Behalf Of Rapha=EBl Beamonte
Sent: Wednesday, April 17, 2013 1:15 AM
To: Hari Prasad Kalavakunta
Cc: lttng-dev@lists.lttng.org<mailto:lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] linux 3.4.3 and LTTNG patch files

Hello Hari,

You should look at lttng 2.x instead of lttng 0.x : http://lttng.org/downlo=
ad

Rapha=EBl
2013/4/16 Hari Prasad Kalavakunta <Hari.Prasad@radisys.com<mailto:Hari.Pras=
ad@radisys.com>>
Hello and greetings,

Good morning and very quick query.

Can I use LTTNG for linux kernel 3.4.3? Could you please let me know if LTT=
NG patch files are available for linux 3.4.3.

URL: http://lttng.org/files/lttng/ appears to have patch files for linux  2=
.6.xx. Are there patch files available for linux 3.4.3?

Sorry for this trouble :(

Regards,
Hari

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org<mailto:lttng-dev@lists.lttng.org>
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



--_000_05E83BDD0E1F054FA73F00F6970F05C6060DCBCH1PRD0810MB394na_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
h3
	{mso-style-priority:9;
	mso-style-link:"Heading 3 Char";
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:13.5pt;
	font-family:"Times New Roman","serif";}
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
	margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.Heading3Char
	{mso-style-name:"Heading 3 Char";
	mso-style-priority:9;
	mso-style-link:"Heading 3";
	font-family:"Cambria","serif";
	color:#4F81BD;
	font-weight:bold;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
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
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Thanks,
</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;;color:#1F497D">Rapha=EBl<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">&#8220;</span>With LTTng =
2.x, you just have to build and install the kernel modules (lttng-modules) =
for kernel tracing,&#8221;<span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">I hope you meat for both =
User Space Tracing and Kernel Tracing !!!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Regards,<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Hari<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> nashii@g=
mail.com [mailto:nashii@gmail.com]
<b>On Behalf Of </b>Rapha=EBl Beamonte<br>
<b>Sent:</b> Wednesday, April 17, 2013 1:52 AM<br>
<b>To:</b> Hari Prasad Kalavakunta<br>
<b>Cc:</b> lttng-dev@lists.lttng.org<br>
<b>Subject:</b> Re: [lttng-dev] linux 3.4.3 and LTTNG patch files<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Hello Hari,<o:p></o:p=
></p>
<div>
<p class=3D"MsoNormal">2013/4/16 Hari Prasad Kalavakunta &lt;<a href=3D"mai=
lto:Hari.Prasad@radisys.com" target=3D"_blank">Hari.Prasad@radisys.com</a>&=
gt;<o:p></o:p></p>
<div>
<div>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&q=
uot;sans-serif&quot;;color:#1F497D">Could you please let me know if these i=
nstallation can be done without patching the kernel &nbsp;(unlike
 lttng 0.x)</span><o:p></o:p></p>
</div>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><br>
With LTTng 2.x, you just have to build and install the kernel modules (lttn=
g-modules) for kernel tracing, you don't need to patch the kernel like it w=
as necessary for LTTng 0.x.<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&q=
uot;sans-serif&quot;;color:#1F497D">Sorry again for taking your time. I am =
just getting started :(</span><o:p></o:p></p>
<p class=3D"MsoNormal"><br>
No problem, just don't forget to add the lttng-dev list in copy when you an=
swer !<br>
<br>
Rapha=EBl<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">2013/4/16 Hari Prasad Kalavakunta &lt;<a href=3D"mai=
lto:Hari.Prasad@radisys.com" target=3D"_blank">Hari.Prasad@radisys.com</a>&=
gt;<o:p></o:p></p>
<div>
<div>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&q=
uot;sans-serif&quot;;color:#1F497D">Hi Rapha=EBl</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&q=
uot;sans-serif&quot;;color:#1F497D">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&q=
uot;sans-serif&quot;;color:#1F497D">I have referred incorrectly to 0.x whil=
e looking at LTTNG Quick Start Guide.
</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&q=
uot;sans-serif&quot;;color:#1F497D">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&q=
uot;sans-serif&quot;;color:#1F497D">I have now looked at download page
</span><a href=3D"http://lttng.org/download" target=3D"_blank">http://lttng=
.org/download</a><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&q=
uot;sans-serif&quot;;color:#1F497D">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&q=
uot;sans-serif&quot;;color:#1F497D">Below section and links appears to be r=
elevant for me.
</span><o:p></o:p></p>
<h3 style=3D"margin-bottom:0in;margin-bottom:.0001pt;background:#F4F7E7"><s=
pan lang=3D"EN" style=3D"font-size:11.0pt;font-family:&quot;Tahoma&quot;,&q=
uot;sans-serif&quot;;color:#666666">LTTng 2.1
<a href=3D"http://lttng.org/version-naming" target=3D"_blank">&quot;Basse M=
esse&quot;</a> - Tracer toolchain</span><o:p></o:p></h3>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto;line-height:160%;background:#F4F7E7">
<b><span lang=3D"EN" style=3D"font-size:9.0pt;line-height:160%;font-family:=
&quot;Tahoma&quot;,&quot;sans-serif&quot;;color:#666666">LTTng-tools
<a href=3D"http://lttng.org/files/lttng-tools/lttng-tools-2.1.1.tar.bz2" ta=
rget=3D"_blank">
2.1.1</a> </span></b><span lang=3D"EN" style=3D"font-size:9.0pt;line-height=
:160%;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;;color:#666666">=
<a href=3D"http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob_plain;f=3DCha=
ngeLog;hb=3Drefs/heads/stable-2.1" target=3D"_blank">(Changelog)</a></span>=
<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto;margin-left:.5in;line-height:160%;background:#F4F7E7">
<span lang=3D"EN" style=3D"font-size:9.0pt;line-height:160%;font-family:&qu=
ot;Tahoma&quot;,&quot;sans-serif&quot;;color:#666666">the trace control cli=
ent</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto;line-height:160%;background:#F4F7E7">
<b><span lang=3D"EN" style=3D"font-size:9.0pt;line-height:160%;font-family:=
&quot;Tahoma&quot;,&quot;sans-serif&quot;;color:#666666">LTTng-modules
<a href=3D"http://lttng.org/files/lttng-modules/lttng-modules-2.1.1.tar.bz2=
" target=3D"_blank">
2.1.1</a> </span></b><span lang=3D"EN" style=3D"font-size:9.0pt;line-height=
:160%;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;;color:#666666">=
<a href=3D"http://git.lttng.org/?p=3Dlttng-modules.git;a=3Dblob_plain;f=3DC=
hangeLog;hb=3Drefs/heads/stable-2.1" target=3D"_blank">(Changelog)</a></spa=
n><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto;margin-left:.5in;line-height:160%;background:#F4F7E7">
<span lang=3D"EN" style=3D"font-size:9.0pt;line-height:160%;font-family:&qu=
ot;Tahoma&quot;,&quot;sans-serif&quot;;color:#666666">the kernel modules (r=
equires at least Linux 2.6.38)</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto;line-height:160%;background:#F4F7E7">
<b><span lang=3D"EN" style=3D"font-size:9.0pt;line-height:160%;font-family:=
&quot;Tahoma&quot;,&quot;sans-serif&quot;;color:#666666">LTTng-UST
<a href=3D"http://lttng.org/files/lttng-ust/lttng-ust-2.1.2.tar.bz2" target=
=3D"_blank">
2.1.2</a> </span></b><span lang=3D"EN" style=3D"font-size:9.0pt;line-height=
:160%;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;;color:#666666">=
<a href=3D"http://git.lttng.org/?p=3Dlttng-ust.git;a=3Dblob_plain;f=3DChang=
eLog;hb=3Drefs/heads/stable-2.1" target=3D"_blank">(Changelog)</a></span><o=
:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto;margin-left:.5in;line-height:160%;background:#F4F7E7">
<span lang=3D"EN" style=3D"font-size:9.0pt;line-height:160%;font-family:&qu=
ot;Tahoma&quot;,&quot;sans-serif&quot;;color:#666666">the userspace tracing=
 library</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&q=
uot;sans-serif&quot;;color:#1F497D">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&q=
uot;sans-serif&quot;;color:#1F497D">Could you please let me know if these i=
nstallation can be done without patching the kernel &nbsp;(unlike
 lttng 0.x)</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&q=
uot;sans-serif&quot;;color:#1F497D">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&q=
uot;sans-serif&quot;;color:#1F497D">Sorry again for taking your time. I am =
just getting started :(</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&q=
uot;sans-serif&quot;;color:#1F497D">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&q=
uot;sans-serif&quot;;color:#1F497D">Regards,</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&q=
uot;sans-serif&quot;;color:#1F497D">Hari</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&q=
uot;sans-serif&quot;;color:#1F497D">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><b><span style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,=
&quot;sans-serif&quot;">From:</span></b><span style=3D"font-size:10.0pt;fon=
t-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">
<a href=3D"mailto:nashii@gmail.com" target=3D"_blank">nashii@gmail.com</a> =
[mailto:<a href=3D"mailto:nashii@gmail.com" target=3D"_blank">nashii@gmail.=
com</a>]
<b>On Behalf Of </b>Rapha=EBl Beamonte<br>
<b>Sent:</b> Wednesday, April 17, 2013 1:15 AM<br>
<b>To:</b> Hari Prasad Kalavakunta<br>
<b>Cc:</b> <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">l=
ttng-dev@lists.lttng.org</a><br>
<b>Subject:</b> Re: [lttng-dev] linux 3.4.3 and LTTNG patch files</span><o:=
p></o:p></p>
<div>
<div>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;margin-bottom:12.0p=
t">Hello Hari,<br>
<br>
You should look at lttng 2.x instead of lttng 0.x : <a href=3D"http://lttng=
.org/download" target=3D"_blank">
http://lttng.org/download</a><br>
<br>
Rapha=EBl<o:p></o:p></p>
<div>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto">2013/4/16 Hari Prasad Kalavakunta &lt;<a href=3D"mailto:Hari.Prasa=
d@radisys.com" target=3D"_blank">Hari.Prasad@radisys.com</a>&gt;<o:p></o:p>=
</p>
<div>
<div>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto">Hello and greetings,<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto">Good morning and very quick query.<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto">Can I use LTTNG for linux kernel 3.4.3? Could you please let me kn=
ow if LTTNG patch files are available for linux 3.4.3.<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto">URL:
<a href=3D"http://lttng.org/files/lttng/" target=3D"_blank">http://lttng.or=
g/files/lttng/</a> appears to have patch files for linux &nbsp;2.6.xx. Are =
there patch files available for linux 3.4.3?<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto">Sorry for this trouble :(<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto">Hari<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;margin-bottom:12.0p=
t"><br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
o:p></o:p></p>
</div>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto">&nbsp;<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_05E83BDD0E1F054FA73F00F6970F05C6060DCBCH1PRD0810MB394na_--


--===============1809878094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1809878094==--
