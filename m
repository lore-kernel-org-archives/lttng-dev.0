From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace RFC PATCH 00/28] Add support for MinGW32
Date: Thu, 2 May 2013 11:46:08 +0000
Message-ID: <009B25148989C6458484484699278506E537E826__14991.0934306265$1367495222$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1272718775=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UXrxq-0001mW-Lx
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 07:46:18 -0400
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Mathieu Desnoyers (mathieu.desnoyers@efficios.com)" <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1272718775==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_009B25148989C6458484484699278506E537E826EUMBX01mgcmento_"

--_000_009B25148989C6458484484699278506E537E826EUMBX01mgcmento_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The following set of patches make it possible to compile babeltrace with Mi=
nGW32.
The babeltrace source has been reorganized. There is now a new compat sourc=
e directory,
along with a include/babeltrace/compat header directory. These now isolate =
the system-specific
pieces of code.

The first three patches (01 - 03) deal with the new compat directories, mov=
ing current code
around. No new functionality is added in these patches.

Patches 06 - 12, 14 - 22, and 25-27 add MinGW implementations of library fu=
nctions that
are missing in MinGW.

Patches 04 and 24 make sure correct libraries and header files are used.

Patch 05 updates .gitignore with Windows *.exe files.

Patch 23 overcomes several problems in MinGW. With MinGW, openat() does not=
 work at
all, and there is no easy implementation available. So instead of openat(),=
 in MinGW, we
open the file using the full qualified path name. This patch also deals wit=
h problems with
directory handles.

Patch 28 adds a binary flag for the fdopen() command as is required for Win=
dows.

Thank you,


JP Ikaheimonen | SW Development Engineer http://go.mentor.com/sourceryanaly=
zer



Mentor Embedded(tm) | Nucleus(r) | Linux(r) | Android(tm) | Services | UI |=
 Multi-OS



Android is a trademark of Google Inc. Use of this trademark is subject to G=
oogle Permissions.

Linux is the registered trademark of Linus Torvalds in the U.S. and other c=
ountries.


--_000_009B25148989C6458484484699278506E537E826EUMBX01mgcmento_
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
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
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
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 2.0cm 70.85pt 2.0cm;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"FI" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">The following set of patches ma=
ke it possible to compile babeltrace with MinGW32.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">The babeltrace source has been =
reorganized. There is now a new compat source directory,<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">along with a include/babeltrace=
/compat header directory. These now isolate the system-specific<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">pieces of code.<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">The first three patches (01 &#8=
211; 03) deal with the new compat directories, moving current code<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">around. No new functionality is=
 added in these patches.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Patches 06 &#8211; 12, 14 &#821=
1; 22, and 25-27 add MinGW implementations of library functions that<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">are missing in MinGW.<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Patches 04 and 24 make sure cor=
rect libraries and header files are used.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Patch 05 updates .gitignore wit=
h Windows *.exe files.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Patch 23 overcomes several prob=
lems in MinGW. With MinGW, openat() does not work at<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">all, and there is no easy imple=
mentation available. So instead of openat(), in MinGW, we<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">open the file using the full qu=
alified path name. This patch also deals with problems with<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">directory handles.<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Patch 28 adds a binary flag for=
 the fdopen() command as is required for Windows.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thank you,<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">JP Ikaheimonen | SW Developm=
ent Engineer
</span><a href=3D"http://go.mentor.com/sourceryanalyzer"><span lang=3D"EN-U=
S">http://go.mentor.com/sourceryanalyzer</span></a><span lang=3D"EN-US"><o:=
p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Mentor Embedded(tm) | Nucleu=
s&reg; | Linux&reg; | Android(tm) | Services | UI | Multi-OS<o:p></o:p></sp=
an></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Android is a trademark of Go=
ogle Inc. Use of this trademark is subject to Google Permissions.<o:p></o:p=
></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Linux is the registered trad=
emark of Linus Torvalds in the U.S. and other countries.<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_009B25148989C6458484484699278506E537E826EUMBX01mgcmento_--


--===============1272718775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1272718775==--
