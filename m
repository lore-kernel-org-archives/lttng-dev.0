From: "Stanciu, Alin" <Alin.Stanciu@spirent.com>
Subject: Kernel trace on Linux distro called YOCTO
Date: Thu, 6 Jun 2019 22:21:10 +0000
Message-ID: <MN2PR10MB3327979A543665A00CE7474E81170__41292.5243190088$1559941324$gmane$org@MN2PR10MB3327.namprd10.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8119069763694937232=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770099.outbound.protection.outlook.com [40.107.77.99])
 by lists.lttng.org (Postfix) with ESMTPS id 45LFGJ74jVzyrW
 for <lttng-dev@lists.lttng.org>; Fri,  7 Jun 2019 16:57:28 -0400 (EDT)
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
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============8119069763694937232==
Content-Language: en-US
Content-Type: multipart/related;
	boundary="_008_MN2PR10MB3327979A543665A00CE7474E81170MN2PR10MB3327namp_";
	type="multipart/alternative"

--_008_MN2PR10MB3327979A543665A00CE7474E81170MN2PR10MB3327namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR10MB3327979A543665A00CE7474E81170MN2PR10MB3327namp_"

--_000_MN2PR10MB3327979A543665A00CE7474E81170MN2PR10MB3327namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm trying to use LTTng to trace Linux events on a Linux distro called YOCT=
O.
Using the following commands, I do not get any kernel events in the LTTng t=
race

"
lttng create my-kernel-session --output=3D/tmp/my-kernel-trace
lttng enable-channel test --kernel --subbuf-size=3D10000000
lttng enable-event --kernel --all -c test
lttng add-context -k -t vpid -t vtid -t procname
lttng start
"

The resulting trace is empty.

No matter what I try, I can't seem to get any kernel events thorough to LTT=
ng.

Using v2.8.8.

Any ideas?

Thanks in advance.

Best Regards,
alin stanciu
Assistant Software Team Manager

T: +44(0)1803.546.306  | M: 07518.071.507
Alin.Stanciu@spirent.com<mailto:Alin.Stanciu@spirent.com> | www.spirent.com=
<http://www.spirent.com/>
Aspen Way, Yalberton Industrial Estate, Paignton, U.K. TQ47QR
[Spirent]<https://www.linkedin.com/company/spirent-communications/> [Spiren=
t] <https://twitter.com/intent/user?screen_name=3DSpirent>  [Spirent] <http=
s://www.youtube.com/user/spirentvideos>  [Spirent] <https://www.facebook.co=
m/spirent>
[Spirent]<http://www.spirent.com/>
Spirent Communications e-mail confidentiality.
This email and the information contained therein may contain private, confi=
dential or privileged material solely meant for the intended recipient. If =
you are not the intended recipient review, copying or distribution is forbi=
dden. Further, if you are not the intended recipient, please contact the se=
nder immediately and permanently delete this email and any copies or attach=
ments.


--_000_MN2PR10MB3327979A543665A00CE7474E81170MN2PR10MB3327namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
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
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.timestamp
	{mso-style-name:timestamp;}
span.hyperlink-whois
	{mso-style-name:hyperlink-whois;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
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
<body lang=3D"EN-GB" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:-5.25pt"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;color:black;mso-fareast-language:EN-GB">I'm t=
rying to use LTTng to trace Linux events on a Linux distro called YOCTO.<o:=
p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:-5.25pt"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;color:black;mso-fareast-language:EN-GB">Using=
 the following commands, I do not get any kernel events in the LTTng trace<=
o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:-5.25pt"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;color:black;mso-fareast-language:EN-GB"><o:p>=
&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:-5.25pt"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;color:black;mso-fareast-language:EN-GB">&#822=
0;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:-5.25pt"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;color:black;mso-fareast-language:EN-GB">lttng=
 create my-kernel-session --output=3D/tmp/my-kernel-trace<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal" style=3D"text-indent:-5.25pt"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;color:black;mso-fareast-language:EN-GB">lttng=
 enable-channel test --kernel --subbuf-size=3D10000000<o:p></o:p></span></p=
>
<p class=3D"MsoNormal" style=3D"text-indent:-5.25pt"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;color:black;mso-fareast-language:EN-GB">lttng=
 enable-event --kernel --all -c test<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:-5.25pt"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;color:black;mso-fareast-language:EN-GB">lttng=
 add-context -k -t vpid -t vtid -t procname<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:-5.25pt"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;color:black;mso-fareast-language:EN-GB">lttng=
 start<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:-5.25pt"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;color:black;mso-fareast-language:EN-GB">&#822=
0;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:-5.25pt"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;color:black;mso-fareast-language:EN-GB"><o:p>=
&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:-5.25pt"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;color:black;mso-fareast-language:EN-GB">The r=
esulting trace is empty.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:-5.25pt"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;color:black;mso-fareast-language:EN-GB"><o:p>=
&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:-5.25pt"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;color:black;mso-fareast-language:EN-GB">No ma=
tter what I try, I can&#8217;t seem to get any kernel events thorough to LT=
Tng.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:-5.25pt"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;color:black;mso-fareast-language:EN-GB"><o:p>=
&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:-5.25pt"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;color:black;mso-fareast-language:EN-GB">Using=
 v2.8.8.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:-5.25pt"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;color:black;mso-fareast-language:EN-GB"><o:p>=
&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:-5.25pt"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;color:black;mso-fareast-language:EN-GB">Any i=
deas?<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:-5.25pt"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;color:black;mso-fareast-language:EN-GB"><o:p>=
&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:-5.25pt"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;color:black;mso-fareast-language:EN-GB">Thank=
s in advance.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:-5.25pt"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;color:black;mso-fareast-language:EN-GB"><o:p>=
&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:-5.25pt"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;color:black;mso-fareast-language:EN-GB">Best =
Regards,</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><b><span style=3D"font-size:14.5pt;font-family:&quot;Arial&quot;,s=
ans-serif;color:#58595B;text-transform:uppercase;mso-fareast-language:EN-GB=
">alin stanciu</span></b><span style=3D"font-size:10.5pt;font-family:&quot;=
Arial&quot;,sans-serif;color:#58595B;mso-fareast-language:EN-GB"><br>
</span><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-s=
erif;color:#58595B;mso-fareast-language:EN-GB">Assistant Software Team Mana=
ger</span><span style=3D"font-size:10.5pt;font-family:&quot;Arial&quot;,san=
s-serif;color:#58595B;mso-fareast-language:EN-GB"><br>
<br>
T: &#43;44(0)1803.546.306 &nbsp;| M: 07518.071.507<br>
<a href=3D"mailto:Alin.Stanciu@spirent.com"><span style=3D"color:blue">Alin=
.Stanciu@spirent.com</span></a>&nbsp;|&nbsp;<a href=3D"http://www.spirent.c=
om/"><span style=3D"color:blue">www.spirent.com</span></a><br>
Aspen Way, Yalberton Industrial Estate, Paignton, U.K. TQ47QR<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><a href=3D"https://www.linkedin.com/company/spirent-=
communications/" target=3D"_blank"><span style=3D"font-size:10.5pt;font-fam=
ily:&quot;Arial&quot;,sans-serif;color:blue;mso-fareast-language:EN-GB;text=
-decoration:none"><img border=3D"0" width=3D"29" height=3D"28" style=3D"wid=
th:.302in;height:.2916in" id=3D"Picture_x0020_1" src=3D"cid:image001.gif@01=
D51CBE.80CB78C0" alt=3D"Spirent"></span></a><span style=3D"font-size:10.5pt=
;font-family:&quot;Arial&quot;,sans-serif;color:#58595B;mso-fareast-languag=
e:EN-GB">&nbsp;</span><a href=3D"https://twitter.com/intent/user?screen_nam=
e=3DSpirent" target=3D"_blank"><span style=3D"font-size:10.5pt;font-family:=
&quot;Arial&quot;,sans-serif;color:blue;mso-fareast-language:EN-GB;text-dec=
oration:none"><img border=3D"0" width=3D"33" height=3D"28" style=3D"width:.=
3437in;height:.2916in" id=3D"Picture_x0020_2" src=3D"cid:image002.gif@01D51=
CBE.80CB78C0" alt=3D"Spirent"></span></a><span style=3D"font-size:10.5pt;fo=
nt-family:&quot;Arial&quot;,sans-serif;color:#58595B;mso-fareast-language:E=
N-GB">&nbsp;</span><a href=3D"https://www.youtube.com/user/spirentvideos" t=
arget=3D"_blank"><span style=3D"font-size:10.5pt;font-family:&quot;Arial&qu=
ot;,sans-serif;color:blue;mso-fareast-language:EN-GB;text-decoration:none">=
<img border=3D"0" width=3D"32" height=3D"28" style=3D"width:.3333in;height:=
.2916in" id=3D"Picture_x0020_3" src=3D"cid:image003.gif@01D51CBE.80CB78C0" =
alt=3D"Spirent"></span></a><span style=3D"font-size:10.5pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#58595B;mso-fareast-language:EN-GB">&nbsp;</=
span><a href=3D"https://www.facebook.com/spirent" target=3D"_blank"><span s=
tyle=3D"font-size:10.5pt;font-family:&quot;Arial&quot;,sans-serif;color:blu=
e;mso-fareast-language:EN-GB;text-decoration:none"><img border=3D"0" width=
=3D"29" height=3D"28" style=3D"width:.302in;height:.2916in" id=3D"Picture_x=
0020_4" src=3D"cid:image004.gif@01D51CBE.80CB78C0" alt=3D"Spirent"></span><=
/a><span style=3D"font-size:10.5pt;font-family:&quot;Arial&quot;,sans-serif=
;color:#58595B;mso-fareast-language:EN-GB"><br>
</span><a href=3D"http://www.spirent.com/" target=3D"_blank"><span style=3D=
"font-size:10.5pt;font-family:&quot;Arial&quot;,sans-serif;color:blue;mso-f=
areast-language:EN-GB;text-decoration:none"><img border=3D"0" width=3D"185"=
 height=3D"96" style=3D"width:1.927in;height:1.0in" id=3D"Picture_x0020_5" =
src=3D"cid:image005.gif@01D51CBE.80CB78C0" alt=3D"Spirent"></span></a><span=
 style=3D"font-size:10.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#=
58595B;mso-fareast-language:EN-GB"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:7.5pt;font-family:&quot;=
Arial&quot;,sans-serif;color:#58595B;mso-fareast-language:EN-GB">Spirent Co=
mmunications e-mail confidentiality.</span></b><span style=3D"font-size:10.=
5pt;font-family:&quot;Arial&quot;,sans-serif;color:#58595B;mso-fareast-lang=
uage:EN-GB"><br>
</span><span style=3D"font-size:7.5pt;font-family:&quot;Arial&quot;,sans-se=
rif;color:#58595B;mso-fareast-language:EN-GB">This email and the informatio=
n contained therein may contain private, confidential or privileged materia=
l solely meant for the intended recipient. If
 you are not the intended recipient review, copying or distribution is forb=
idden. Further, if you are not the intended recipient, please contact the s=
ender immediately and permanently delete this email and any copies or attac=
hments.&nbsp;</span><span style=3D"mso-fareast-language:EN-GB"><o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MN2PR10MB3327979A543665A00CE7474E81170MN2PR10MB3327namp_--

--_008_MN2PR10MB3327979A543665A00CE7474E81170MN2PR10MB3327namp_
Content-Type: image/gif; name="image001.gif"
Content-Description: image001.gif
Content-Disposition: inline; filename="image001.gif"; size=1901;
	creation-date="Thu, 06 Jun 2019 22:21:06 GMT";
	modification-date="Thu, 06 Jun 2019 22:21:06 GMT"
Content-ID: <image001.gif@01D51CBE.80CB78C0>
Content-Transfer-Encoding: base64

R0lGODlhHQAcAOYAAMrLzfr6+9nZ29HS1MLDxu/v8M3O0MjJy+bm5/r6+vT09eLj5OHh49PU1tvc
3c7P0drb3cnKzP7+/svMzuTk5cTFx/39/fn5+fn6+vj5+d3e376/wsjJzM7O0enp6sLCxeLi49jY
2tzc3uHi4/Pz9L2+wfLy8tHR1Pz8/dXW2Pb29/7+//z8/Ojo6ePk5cbHydna3Pj4+PHy8vv7+8PD
xvHx8e3t7uzt7dXV193d3/b29sDBxNLT1fv7/PT09O7u7/X19szNz9TV19na29jZ2/f3+MPEx8TF
yMPExuDg4ufn6b/Aw9vb3e7v79PT1d7f4MnKzdbW2OPj5NTV1t7e4Ly9wP///wAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH/
C1hNUCBEYXRhWE1QPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRj
emtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRv
YmUgWE1QIENvcmUgNS42LWMxNDAgNzkuMTYwNDUxLCAyMDE3LzA1LzA2LTAxOjA4OjIxICAgICAg
ICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRm
LXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXBNTT0i
aHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5h
ZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtbG5zOnhtcD0iaHR0cDovL25z
LmFkb2JlLmNvbS94YXAvMS4wLyIgeG1wTU06T3JpZ2luYWxEb2N1bWVudElEPSJ4bXAuZGlkOjgy
YTUxZDAzLTg2ZTMtNDc4MC1hMjZiLWM2NmZjMGJjOTI5YyIgeG1wTU06RG9jdW1lbnRJRD0ieG1w
LmRpZDo3MUVEQTE5OTcwN0IxMUU4Qjg0NDhGNjEyNDk2NDc2RCIgeG1wTU06SW5zdGFuY2VJRD0i
eG1wLmlpZDo3MUVEQTE5ODcwN0IxMUU4Qjg0NDhGNjEyNDk2NDc2RCIgeG1wOkNyZWF0b3JUb29s
PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSI+IDx4bXBNTTpEZXJpdmVkRnJv
bSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOjVhZDExMjg5LTc2YzItNDFjYi04MzU3LWY3NzM1
ODUwOWI3YiIgc3RSZWY6ZG9jdW1lbnRJRD0iYWRvYmU6ZG9jaWQ6cGhvdG9zaG9wOjMzNWNlZDI2
LWFkNzQtMjA0MS1hNDEwLWUzZjUzMjIwMzViZCIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6
UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PgH//v38+/r5+Pf29fTz8vHw7+7t
7Ovq6ejn5uXk4+Lh4N/e3dzb2tnY19bV1NPS0dDPzs3My8rJyMfGxcTDwsHAv769vLu6ubi3trW0
s7KxsK+urayrqqmop6alpKOioaCfnp2cm5qZmJeWlZSTkpGQj46NjIuKiYiHhoWEg4KBgH9+fXx7
enl4d3Z1dHNycXBvbm1sa2ppaGdmZWRjYmFgX15dXFtaWVhXVlVUU1JRUE9OTUxLSklIR0ZFRENC
QUA/Pj08Ozo5ODc2NTQzMjEwLy4tLCsqKSgnJiUkIyIhIB8eHRwbGhkYFxYVFBMSERAPDg0MCwoJ
CAcGBQQDAgEAACH5BAAAAAAALAAAAAAdABwAAAf/gFaCg4SFhoeIVgowL1WOVUYpBYmIBUdVBhQy
FwkkCANVGy2UhKBMlCBVBxaUKzQfGKSCAFUxiQQHsoRCVTOHJwS6hQYVhk1VAVY6jjfCVQyFBCKC
RI4Twh5VhAraggWOUsJWJQiDEA+EEj3iVg7XghwUgwwRAFFWFg4aT1YjDx05JBCq0c1KFRODQjiC
YiXBoyCPquwoVAWFoCoZBglwBMBKgIggXRCqouJiRkEbq3T86MgAiyJLHDUYWdIgQpQcPT4CImiI
ow4jLVqJpzEnyyoCrSTJKYigOXQ4Vep0NGgB03bvFBVMufJR1avkCEmL2pWqIKtSrWQr9AOZFYVV
SiI09CpohCO5BqEVAmZFiZMGGqywGDBlwCAbPBpQsUIMES52OHohcgVLFy1blEBBQKWKlawCFTC5
2NTpU6hR7HwwiohEErvXhwIBADs=

--_008_MN2PR10MB3327979A543665A00CE7474E81170MN2PR10MB3327namp_
Content-Type: image/gif; name="image002.gif"
Content-Description: image002.gif
Content-Disposition: inline; filename="image002.gif"; size=1876;
	creation-date="Thu, 06 Jun 2019 22:21:07 GMT";
	modification-date="Thu, 06 Jun 2019 22:21:07 GMT"
Content-ID: <image002.gif@01D51CBE.80CB78C0>
Content-Transfer-Encoding: base64

R0lGODlhIQAcAOYAAPb29u3t7uHh4r2+wc7P0cTFyObm59zd3vz8/Pf3+L/Aw9/f4ezs7dTV1+rr
68PEx9jY2u/v8O3u7uHh49zc3t3d376/wsrLzsDBxPP09Nvb3dna3O/w8Ovr7NjZ2/T09cnKzNTV
1uXl5uHi48zMz+nq6+7u79XW2NLS1ejo6dfY2snKzefn6MfIyvb29/7+/+Dg4tDR0/v7+8bHytrb
3P39/cfIy97f4Nvc3cXGyfT09PDx8cTFx/j4+NHS1Ovs7PHx8fPz9Ozt7dra3MLCxb6/wfj4+cjJ
y93e3+Tl5s/P0v7+/urq69LT1eTk5b2+wOfn6by9wP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH/
C1hNUCBEYXRhWE1QPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRj
emtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRv
YmUgWE1QIENvcmUgNS42LWMxNDAgNzkuMTYwNDUxLCAyMDE3LzA1LzA2LTAxOjA4OjIxICAgICAg
ICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRm
LXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXBNTT0i
aHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5h
ZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtbG5zOnhtcD0iaHR0cDovL25z
LmFkb2JlLmNvbS94YXAvMS4wLyIgeG1wTU06T3JpZ2luYWxEb2N1bWVudElEPSJ4bXAuZGlkOjgy
YTUxZDAzLTg2ZTMtNDc4MC1hMjZiLWM2NmZjMGJjOTI5YyIgeG1wTU06RG9jdW1lbnRJRD0ieG1w
LmRpZDpEMzlBOTUxODcwOUQxMUU4Qjg0NDhGNjEyNDk2NDc2RCIgeG1wTU06SW5zdGFuY2VJRD0i
eG1wLmlpZDo3MUVEQTE5QzcwN0IxMUU4Qjg0NDhGNjEyNDk2NDc2RCIgeG1wOkNyZWF0b3JUb29s
PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSI+IDx4bXBNTTpEZXJpdmVkRnJv
bSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOjVhZDExMjg5LTc2YzItNDFjYi04MzU3LWY3NzM1
ODUwOWI3YiIgc3RSZWY6ZG9jdW1lbnRJRD0iYWRvYmU6ZG9jaWQ6cGhvdG9zaG9wOjMzNWNlZDI2
LWFkNzQtMjA0MS1hNDEwLWUzZjUzMjIwMzViZCIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6
UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PgH//v38+/r5+Pf29fTz8vHw7+7t
7Ovq6ejn5uXk4+Lh4N/e3dzb2tnY19bV1NPS0dDPzs3My8rJyMfGxcTDwsHAv769vLu6ubi3trW0
s7KxsK+urayrqqmop6alpKOioaCfnp2cm5qZmJeWlZSTkpGQj46NjIuKiYiHhoWEg4KBgH9+fXx7
enl4d3Z1dHNycXBvbm1sa2ppaGdmZWRjYmFgX15dXFtaWVhXVlVUU1JRUE9OTUxLSklIR0ZFRENC
QUA/Pj08Ozo5ODc2NTQzMjEwLy4tLCsqKSgnJiUkIyIhIB8eHRwbGhkYFxYVFBMSERAPDg0MCwoJ
CAcGBQQDAgEAACH5BAAAAAAALAAAAAAhABwAAAf/gFKCg4SFhoeIiDUjJANRjxZKBomUgggoUQ8H
AQkyAD8bClEQlYcsURcAiRwFURGlgx5RJbACUSKwFFGqsFImUSmVElEZvYMOUS6UUQKVSRUSgkaC
IQWJCxiDUAGGRI9RBDNMg1EMiAOTgipRHYRD348YKoM0K4cfUYQVjz49gkfwotgglCCfoQktCCGA
lwPCg4BICkXhVqjBCUIUZgTc6KQQCBiGCBwg1GHjRh2FYmgIOZJQA5PfnhhSachiISA8YEZZYOjj
wYSEXogyWeTQREP4DgmwsDGIoYLn0g0ScmHjK0P1EGETtASHySYIEJVLxIzQjgkVbjh4kagapWHF
MYxJQaaMki5esH4FKyWLVilbuHqdSrWq1VVjlzJt6gSAQahRcgstavTNAgGpkTMfCgQAOw==

--_008_MN2PR10MB3327979A543665A00CE7474E81170MN2PR10MB3327namp_
Content-Type: image/gif; name="image003.gif"
Content-Description: image003.gif
Content-Disposition: inline; filename="image003.gif"; size=1958;
	creation-date="Thu, 06 Jun 2019 22:21:07 GMT";
	modification-date="Thu, 06 Jun 2019 22:21:07 GMT"
Content-ID: <image003.gif@01D51CBE.80CB78C0>
Content-Transfer-Encoding: base64

R0lGODlhIAAcAOYAAOvr7NTV1ufn6PDx8d7e4MLDxv7+/u/v8Obm58vMzs3O0Nna3OTk5ff3+MTF
yPv7+8fIy/Ly8vf399DR0+7v7/Hx8tnZ29jZ2vj4+Pb29/T09djZ2+Dg4trb3PLy88fHyu7u7+rq
6/z8/NfX2c7P0b/Aw+zs7dTU1t3e38/Q0ufn6fDw8b6/we3t7sXGyPn5+eHh4vX19szNz83N0Nzd
3unq6s/P0uTl5tXW2NbX2Ojo6dDQ08bHycfIytHS1PHx8cDBw8LCxd/f4ejo6tvb3crLzdHR1N3d
39ra3NfY2tTV1+rr68vLztXV18PExsHCxe3u7r6/wtbX2fP09N7f4MnKzNna2/j5+dzc3tvc3ebn
6OXm58DBxOTk5srLzsPDxr2+wefo6enp6tjY2vHy8ry9wP///wAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH/
C1hNUCBEYXRhWE1QPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRj
emtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRv
YmUgWE1QIENvcmUgNS42LWMxNDAgNzkuMTYwNDUxLCAyMDE3LzA1LzA2LTAxOjA4OjIxICAgICAg
ICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRm
LXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXBNTT0i
aHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5h
ZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtbG5zOnhtcD0iaHR0cDovL25z
LmFkb2JlLmNvbS94YXAvMS4wLyIgeG1wTU06T3JpZ2luYWxEb2N1bWVudElEPSJ4bXAuZGlkOjgy
YTUxZDAzLTg2ZTMtNDc4MC1hMjZiLWM2NmZjMGJjOTI5YyIgeG1wTU06RG9jdW1lbnRJRD0ieG1w
LmRpZDpEMzlBOTUyMDcwOUQxMUU4Qjg0NDhGNjEyNDk2NDc2RCIgeG1wTU06SW5zdGFuY2VJRD0i
eG1wLmlpZDpEMzlBOTUxRjcwOUQxMUU4Qjg0NDhGNjEyNDk2NDc2RCIgeG1wOkNyZWF0b3JUb29s
PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSI+IDx4bXBNTTpEZXJpdmVkRnJv
bSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOjVhZDExMjg5LTc2YzItNDFjYi04MzU3LWY3NzM1
ODUwOWI3YiIgc3RSZWY6ZG9jdW1lbnRJRD0iYWRvYmU6ZG9jaWQ6cGhvdG9zaG9wOjMzNWNlZDI2
LWFkNzQtMjA0MS1hNDEwLWUzZjUzMjIwMzViZCIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6
UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PgH//v38+/r5+Pf29fTz8vHw7+7t
7Ovq6ejn5uXk4+Lh4N/e3dzb2tnY19bV1NPS0dDPzs3My8rJyMfGxcTDwsHAv769vLu6ubi3trW0
s7KxsK+urayrqqmop6alpKOioaCfnp2cm5qZmJeWlZSTkpGQj46NjIuKiYiHhoWEg4KBgH9+fXx7
enl4d3Z1dHNycXBvbm1sa2ppaGdmZWRjYmFgX15dXFtaWVhXVlVUU1JRUE9OTUxLSklIR0ZFRENC
QUA/Pj08Ozo5ODc2NTQzMjEwLy4tLCsqKSgnJiUkIyIhIB8eHRwbGhkYFxYVFBMSERAPDg0MCwoJ
CAcGBQQDAgEAACH5BAAAAAAALAAAAAAgABwAAAf/gGaCg4SFhoeIhiIwTGWOZSUpAomUZg87ZQ4E
IA0PMQAbLGUdlYY3ZQoZiRQFZRGlgjllJrAEZZOVF2UYsIIAZQCUIWUSgx5HIieUCGUviWUMhWUq
Pma8BmbYhBMQiDQFhglcFVFBCE8tDoUGZRSHZTWGWmVmwFYuBz2GODOGFfSGBnypB2CBixX6CmkA
SAhFgkMHgNQjIcSBjA/vBhSaYOGQgRVmMkyaIsHDIR7RCCXgUEjHiBEXLCxYsGEBkgUdyBRSQKDQ
SkIBynCgQsJRgSKPHOESxHNjR0FXHI2I4MSRAixGHYEhhLKQw0EDHH1YAiwECSgashwg4ohQGY2E
g/4N+uEIwi8xYWwkiYDABDOGC9/FMxO2jN0yQ1TYGONBR4kqbQXxO/RNEAaxAogNkNHigJIGQQGy
O4AImiAjSVMn7SKIW6JhxcxsaXIigO3bAU5IASGImbNEuhr0MvMrWCVZtErZWlrpVKpVrV4Nv5Rp
U6dPoUYNL7TIS9JIzLeLPxQIADs=

--_008_MN2PR10MB3327979A543665A00CE7474E81170MN2PR10MB3327namp_
Content-Type: image/gif; name="image004.gif"
Content-Description: image004.gif
Content-Disposition: inline; filename="image004.gif"; size=1828;
	creation-date="Thu, 06 Jun 2019 22:21:08 GMT";
	modification-date="Thu, 06 Jun 2019 22:21:08 GMT"
Content-ID: <image004.gif@01D51CBE.80CB78C0>
Content-Transfer-Encoding: base64

R0lGODlhHQAcAOYAAMLDxvn5+dHS1Pb29ubm5/j4+M3O0OTk5cjJy+/v8PT09dTV1vv7+87P0dzc
3tna3MTFx/39/drb3eHh49XW2O7v7/Hy8srLzfn6+vr6+sjJzPLy8vr6+/Dx8cPDxv7+//Pz9NHR
1MvMzuLi48LDxb6/wtvc3ejo6fb299vb3enp6r2+wdLS1dPU1tDQ08fIyszNz8nKzMPExsXGydLS
1PX19vz8/fX19f7+/tjZ2tTU1s/Q0t3e38TFyMbHye7u7/T09MPEx7y9wP///wAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH/
C1hNUCBEYXRhWE1QPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRj
emtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRv
YmUgWE1QIENvcmUgNS42LWMxNDAgNzkuMTYwNDUxLCAyMDE3LzA1LzA2LTAxOjA4OjIxICAgICAg
ICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRm
LXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXBNTT0i
aHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5h
ZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtbG5zOnhtcD0iaHR0cDovL25z
LmFkb2JlLmNvbS94YXAvMS4wLyIgeG1wTU06T3JpZ2luYWxEb2N1bWVudElEPSJ4bXAuZGlkOjgy
YTUxZDAzLTg2ZTMtNDc4MC1hMjZiLWM2NmZjMGJjOTI5YyIgeG1wTU06RG9jdW1lbnRJRD0ieG1w
LmRpZDoyNkQwMTZBRjcwOUUxMUU4Qjg0NDhGNjEyNDk2NDc2RCIgeG1wTU06SW5zdGFuY2VJRD0i
eG1wLmlpZDoyNkQwMTZBRTcwOUUxMUU4Qjg0NDhGNjEyNDk2NDc2RCIgeG1wOkNyZWF0b3JUb29s
PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSI+IDx4bXBNTTpEZXJpdmVkRnJv
bSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOjVhZDExMjg5LTc2YzItNDFjYi04MzU3LWY3NzM1
ODUwOWI3YiIgc3RSZWY6ZG9jdW1lbnRJRD0iYWRvYmU6ZG9jaWQ6cGhvdG9zaG9wOjMzNWNlZDI2
LWFkNzQtMjA0MS1hNDEwLWUzZjUzMjIwMzViZCIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6
UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PgH//v38+/r5+Pf29fTz8vHw7+7t
7Ovq6ejn5uXk4+Lh4N/e3dzb2tnY19bV1NPS0dDPzs3My8rJyMfGxcTDwsHAv769vLu6ubi3trW0
s7KxsK+urayrqqmop6alpKOioaCfnp2cm5qZmJeWlZSTkpGQj46NjIuKiYiHhoWEg4KBgH9+fXx7
enl4d3Z1dHNycXBvbm1sa2ppaGdmZWRjYmFgX15dXFtaWVhXVlVUU1JRUE9OTUxLSklIR0ZFRENC
QUA/Pj08Ozo5ODc2NTQzMjEwLy4tLCsqKSgnJiUkIyIhIB8eHRwbGhkYFxYVFBMSERAPDg0MCwoJ
CAcGBQQDAgEAACH5BAAAAAAALAAAAAAdABwAAAf/gEOCg4SFhoeIhAkUQUKOQj4PComIJyVCAgQg
GQEWBwZCPQmUgxEIQiOUKZikBUIXpIIYJB4fiAxCC7GECACIEAaIPzk6LTyFACGGE0KIDo9CMYUc
QhWFQiqI0EIvhg6+gwQriK6ODIlCk4IiJuSPlA0Sg0Idhy4wjzvxhwcagjbNDm1zxOLQhoAoAhoa
KOTBoQAIFRq68QhHIoiCIkgsNOBdooPz6h3q6IhSv0HsEJHcWGifIHEqPWpTJwjbSJnewA1idqgG
TkLUrBUCZigAjQUCECU7hEvXLkG9ErmCFWtWLUqmUKlitcsSJk2cPIGCMOqpoEUyoM14AMSsW0OB
AQAAOw==

--_008_MN2PR10MB3327979A543665A00CE7474E81170MN2PR10MB3327namp_
Content-Type: image/gif; name="image005.gif"
Content-Description: image005.gif
Content-Disposition: inline; filename="image005.gif"; size=5352;
	creation-date="Thu, 06 Jun 2019 22:21:09 GMT";
	modification-date="Thu, 06 Jun 2019 22:21:09 GMT"
Content-ID: <image005.gif@01D51CBE.80CB78C0>
Content-Transfer-Encoding: base64

R0lGODlhuQBgAPcAAAbC5wDA517HxO3x9rjr94bc8sTq6Zqw0ACu32mKuiZWmXPX8ICbxOLo8QC7
5Exzq/L1+QCemQCr3kdwqQCoo1Z8sEzO7Jfh9bjI3v7+/5Coy0rBvi1bnQCcl+nt9ACy4crw+gC3
417S7TZioS5cnb7t+ACw4Ft/s2vV7/n6/B3E6CBQl/f7/PX4+ond8t3l73fZ8aS41Ziuz3qWwOf4
/NTe6/D7/TbJ6gC95dPz+5Tg9HLNy67o9ihYm1PQ7OD2/BbE6NLc6ljQ7M/x+oykyaG10wC549j0
+yRVmSy5tCW2s1+CtfX8/QCfmifG6UXM7MPv+BxNlQCalQCtqaTl9rDC2zNfn8jU5i9dnsPQ47Hp
9p/d3HCPvbTF28vX5092rfv8/ACZlHDW7yhXmtz1/Mjv+am718/Z6en4/OT3+011rI3e8y3H6YbV
04/f8yRUmNji7uv5/DnJ6+L2/FF4rqjn9QCknz1npKLl9tbz++Tq88Hu+bvJ333Rz3WUvneUv52y
0XzZ8XyZwgC14Tm8uWfU7/j9/jlkopSrzbLk4ixbnL3L4Jjb2Zzk9Obs9JPZ1wC245/l9q2/2fz+
/hK0rwCwrENsp2KEtuH19Kq92IDb8VV5r6Xm9MLP4vz9/gC/5rXF3HKQvJri9TTI66a51bTE24mj
yACp3SFSl4eix/r9/kDL6wCz4WyMuwC246e61iBRlsDO4oOfxf3+/fn9/PH7/ZWszs7Y6T9ppbfG
3Y/X1qK31DrL6wCVkBpMlC1ZnUJqpitanCdXmiJTl/Dz9yNTmCpZmwCx4QCt3yxanCpZnCNUmCJT
mB9RlitZnClYmyFTl+Hn8fz9/cbT5PX8+0RtqCVVme75+JKqzOf29XSSvSpanGSFtz3K6zS6t7LD
2sbv+I6mylN6r9/m8Kro9VDO7CdXmwC24vj5/Oj5/NXf7NPv7uf3+0C+uy9enzBen3fPzdfh7erv
9a/A2qC00qzn9ipam/v+/arh3+v6/CJUmMXS5VTEwbXE3Or49////yH/C1hNUCBEYXRhWE1QPD94
cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1w
bWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42
LWMxNDAgNzkuMTYwNDUxLCAyMDE3LzA1LzA2LTAxOjA4OjIxICAgICAgICAiPiA8cmRmOlJERiB4
bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8
cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5j
b20veGFwLzEuMC8iIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0v
IiB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNl
UmVmIyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3No
KSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDoyNkQwMTZCNjcwOUUxMUU4Qjg0NDhGNjEyNDk2
NDc2RCIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDoyNkQwMTZCNzcwOUUxMUU4Qjg0NDhGNjEy
NDk2NDc2RCI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOjI2
RDAxNkI0NzA5RTExRThCODQ0OEY2MTI0OTY0NzZEIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlk
OjI2RDAxNkI1NzA5RTExRThCODQ0OEY2MTI0OTY0NzZEIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8
L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+Af/+/fz7+vn49/b19PPy
8fDv7u3s6+rp6Ofm5eTj4uHg397d3Nva2djX1tXU09LR0M/OzczLysnIx8bFxMPCwcC/vr28u7q5
uLe2tbSzsrGwr66trKuqqainpqWko6KhoJ+enZybmpmYl5aVlJOSkZCPjo2Mi4qJiIeGhYSDgoGA
f359fHt6eXh3dnV0c3JxcG9ubWxramloZ2ZlZGNiYWBfXl1cW1pZWFdWVVRTUlFQT05NTEtKSUhH
RkVEQ0JBQD8+PTw7Ojk4NzY1NDMyMTAvLi0sKyopKCcmJSQjIiEgHx4dHBsaGRgXFhUUExIREA8O
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

--_008_MN2PR10MB3327979A543665A00CE7474E81170MN2PR10MB3327namp_--

--===============8119069763694937232==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8119069763694937232==--
