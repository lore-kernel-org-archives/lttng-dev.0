From: XIANG Hao <Hao.Xiang@alcatel-sbell.com.cn>
Subject: About Lttng trace mode
Date: Thu, 14 Nov 2013 13:24:16 +0000
Message-ID: <04EE1C9C9D9EBF479DA6C9E23723D8E901373BE5__44740.6042869717$1384439804$gmane$org@cnshjmbx01>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2075703602=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from cnshjsmin03.alcatel-sbell.com.cn ([211.144.215.47])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Hao.Xiang@alcatel-sbell.com.cn>) id 1VgwuG-0002L1-Fh
	for lttng-dev@lists.lttng.org; Thu, 14 Nov 2013 08:24:31 -0500
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

--===============2075703602==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_04EE1C9C9D9EBF479DA6C9E23723D8E901373BE5cnshjmbx01_"

--_000_04EE1C9C9D9EBF479DA6C9E23723D8E901373BE5cnshjmbx01_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi, Dear Lttng Expert

         I am a beginner of the great tool: Lttng. We haven't so much targe=
t board memory for it. So I have some questions as below, could you please =
help me, thanks!

         Could Lttng support transmit trace to host PC in a "live mode" or =
"fly mode" now? So as to reduce the buffer size requirement on the target b=
oard.

         BTW, I read some material mentioned:
The discard mode is used by default. In this mode, new trace data arriving =
to a full buffer are discarded. In overwrite mode, the oldest trace data in=
 the buffer are discarded. This mode is also known as flight-recorder mode.=
 Note however, that this refers to the internal buffers, not to the trace l=
og storage. The discarding of events is marked in the trace log and can be =
noticed when the trace is analyzed. In this way the user can interactively =
adjust his trace settings.
         What is the difference between "internal buffers" and "trace log s=
torage"? Could the trace log storage be located in the host PC? For example=
: the target board transmit the trace to Host PC via TCP/UDP, and only a ve=
ry little internal flight-recorder buffer is required in the target device.=
 Is it feasible?

BR&Thanks
XiangHao

---------------------------------------------------------------------------=
----------------
ALCATEL-LUCENT SHANGHAI BELL
No.255 Guiqiao Road, Pudong, Shanghai, China
ZIP: 201206

OnNET: 2783.7051
Phone: +86.21.38563888.7051
Fax  : +86.21.38563400

Hao.Xiang@alcatel-sbell.com.cn<mailto:Hao.Xiang@alcatel-sbell.com.cn>
---------------------------------------------------------------------------=
----------------


--_000_04EE1C9C9D9EBF479DA6C9E23723D8E901373BE5cnshjmbx01_
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
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:MyriadPro-Regular;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:TimesNewRomanPSMT;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"\@MyriadPro-Regular";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"\@TimesNewRomanPSMT";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
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
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple" style=3D"text-justify-t=
rim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi, Dear Lttng Expert<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; I am a beginner of the great tool: Lttng. We haven&#8217;=
t so much target board memory for it. So I have some questions as below, co=
uld you please help me, thanks!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; Could Lttng support transmit trace to host PC in a &#8220=
;live mode&#8221; or &#8220;fly mode&#8221; now? So as to reduce the buffer=
 size requirement on the target board.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; BTW, I read some material mentioned:<o:p></o:p></span></p=
>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span lang=3D"EN-US" s=
tyle=3D"font-size:9.5pt;font-family:&quot;MyriadPro-Regular&quot;,&quot;san=
s-serif&quot;">The discard mode is used by default. In this mode, new trace=
 data arriving to a full buffer are discarded.
<b><span style=3D"color:red">In overwrite mode, the oldest trace data in th=
e buffer are discarded. This mode is also known as flight-recorder mode.
</span></b>Note however, that this refers to the <b><span style=3D"color:#5=
58ED5">internal buffers</span></b>, not to the<b><span style=3D"color:#558E=
D5"> trace log storage</span></b>. The discarding of events is marked in th=
e trace log and can be noticed when
 the trace is analyzed. In this way the user can interactively adjust his t=
race settings.</span><span lang=3D"EN-US" style=3D"font-size:9.5pt;font-fam=
ily:TimesNewRomanPSMT"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; What is the difference between &#8220;</span><b><span lan=
g=3D"EN-US" style=3D"font-size:9.5pt;font-family:&quot;MyriadPro-Regular&qu=
ot;,&quot;sans-serif&quot;;color:#558ED5">internal buffers</span></b><span =
lang=3D"EN-US">&#8221; and &#8220;</span><b><span lang=3D"EN-US" style=3D"f=
ont-size:9.5pt;font-family:&quot;MyriadPro-Regular&quot;,&quot;sans-serif&q=
uot;;color:#558ED5">trace
 log storage</span></b><span lang=3D"EN-US">&#8221;? Could the trace log st=
orage be located in the host PC? For example: the target board transmit the=
 trace to Host PC via TCP/UDP, and only a very little internal flight-recor=
der buffer is required in the target device.
 Is it feasible?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">BR&amp;Thanks<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">XiangHao<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-------------------------------=
------------------------------------------------------------<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">ALCATEL-LUCENT SHANGHAI BELL<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">No.255 Guiqiao Road, Pudong, Sh=
anghai, China<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">ZIP: 201206 <o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">OnNET: 2783.7051 <o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Phone: &#43;86.21.38563888.7051=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Fax&nbsp; : &#43;86.21.38563400=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><a href=3D"mailto:Hao.Xiang@alc=
atel-sbell.com.cn">Hao.Xiang@alcatel-sbell.com.cn</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-------------------------------=
------------------------------------------------------------<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_04EE1C9C9D9EBF479DA6C9E23723D8E901373BE5cnshjmbx01_--


--===============2075703602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2075703602==--
