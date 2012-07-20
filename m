From: <Bingfeng.Zhao@emc.com>
Subject: Re: some questions on lttng
Date: Thu, 19 Jul 2012 22:10:26 -0400
Message-ID: <4B3E7C3D6AE874479212F4D6AE0AFD1F02C7FF0805__20598.4914945022$1342750291$gmane$org@MX28A.corp.emc.com>
References: <4B3E7C3D6AE874479212F4D6AE0AFD1F02C7FF0741@MX28A.corp.emc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1644715584=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from hop-nat-141.emc.com ([168.159.213.141]
	helo=mexforward.lss.emc.com) by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Bingfeng.Zhao@emc.com>) id 1Ss2g5-00011V-2U
	for lttng-dev@lists.lttng.org; Thu, 19 Jul 2012 22:10:49 -0400
Received: from hop04-l1d11-si02.isus.emc.com (HOP04-L1D11-SI02.isus.emc.com
	[10.254.111.55])
	by mexforward.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id
	q6K2AgVT029404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <lttng-dev@lists.lttng.org>; Thu, 19 Jul 2012 22:10:43 -0400
Received: from mailhub.lss.emc.com (mailhubhoprd01.lss.emc.com
	[10.254.221.251]) by hop04-l1d11-si02.isus.emc.com (RSA
	Interceptor) for <lttng-dev@lists.lttng.org>;
	Thu, 19 Jul 2012 22:10:30 -0400
Received: from mxhub30.corp.emc.com (mxhub30.corp.emc.com [128.222.70.170])
	by mailhub.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id
	q6K2AS66011603
	for <lttng-dev@lists.lttng.org>; Thu, 19 Jul 2012 22:10:28 -0400
In-Reply-To: <4B3E7C3D6AE874479212F4D6AE0AFD1F02C7FF0741@MX28A.corp.emc.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1644715584==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_4B3E7C3D6AE874479212F4D6AE0AFD1F02C7FF0805MX28Acorpemcc_"

--_000_4B3E7C3D6AE874479212F4D6AE0AFD1F02C7FF0805MX28Acorpemcc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Anyone can answer our questions? Mathieu?

From: Bingfeng.Zhao@emc.com [mailto:Bingfeng.Zhao@emc.com]
Sent: Wednesday, July 18, 2012 5:54 PM
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] some questions on lttng

Hello the dev list,
We encounter some basic questions when try to adapt the LTTNG in our poject=
.

1.   When the trace is enabled and all are well configurated, we get trace =
messages collected under the session folder. The question is whether it is =
possible that some traces will lost when the trace messages are huge. How w=
ill LTTNG do if the consumer deamon cannot fast enough to copy the trace me=
ssage from trace buffer?

2.   For user space trace, currectly seems we cannot set the flush interval=
. How can we control the flush internal for UST? If no, is there hardcoded =
or random flash interval? Or there is no time based flush mechanism at all =
for UST?

3.   For a severe kernel panic can we extrace buffered trace messages from =
LTTNG internal buffer in full memory core dump file? Is there tools on this=
 we can leverage?

Thank you,
- Bingfeng


--_000_4B3E7C3D6AE874479212F4D6AE0AFD1F02C7FF0805MX28Acorpemcc_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><META HTTP-EQUIV=3D"Content-Type" CONTENT=
=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Micros=
oft Word 14 (filtered medium)"><style><!--
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
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:Verdana;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
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
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Verdana","sans-serif";
	color:windowtext;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Verdana","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1136877096;
	mso-list-type:hybrid;
	mso-list-template-ids:1808583752 67698703 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue vli=
nk=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal><span style=3D'f=
ont-family:"Verdana","sans-serif";color:#1F497D'>Anyone can answer our ques=
tions? Mathieu?<o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'fo=
nt-family:"Verdana","sans-serif";color:#1F497D'><o:p>&nbsp;</o:p></span></p=
><div><div style=3D'border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0p=
t 0in 0in 0in'><p class=3DMsoNormal><b><span style=3D'font-size:10.0pt;font=
-family:"Tahoma","sans-serif"'>From:</span></b><span style=3D'font-size:10.=
0pt;font-family:"Tahoma","sans-serif"'> Bingfeng.Zhao@emc.com [mailto:Bingf=
eng.Zhao@emc.com] <br><b>Sent:</b> Wednesday, July 18, 2012 5:54 PM<br><b>T=
o:</b> lttng-dev@lists.lttng.org<br><b>Subject:</b> [lttng-dev] some questi=
ons on lttng<o:p></o:p></span></p></div></div><p class=3DMsoNormal><o:p>&nb=
sp;</o:p></p><p class=3DMsoNormal><span style=3D'font-family:"Verdana","san=
s-serif"'>Hello the dev list,<o:p></o:p></span></p><p class=3DMsoNormal><sp=
an style=3D'font-family:"Verdana","sans-serif"'>We encounter some basic que=
stions when try to adapt the LTTNG in our poject. <o:p></o:p></span></p><p =
class=3DMsoListParagraph style=3D'text-indent:-.25in;mso-list:l0 level1 lfo=
2'><![if !supportLists]><span style=3D'font-family:"Verdana","sans-serif"'>=
<span style=3D'mso-list:Ignore'>1.<span style=3D'font:7.0pt "Times New Roma=
n"'>&nbsp;&nbsp; </span></span></span><![endif]><span style=3D'font-family:=
"Verdana","sans-serif"'>When the trace is enabled and all are well configur=
ated, we get trace messages collected under the session folder. The questio=
n is whether it is possible that some traces will lost when the trace messa=
ges are huge. How will LTTNG do if the consumer deamon cannot fast enough t=
o copy the trace message from trace buffer?<o:p></o:p></span></p><p class=
=3DMsoListParagraph style=3D'text-indent:-.25in;mso-list:l0 level1 lfo2'><!=
[if !supportLists]><span style=3D'font-family:"Verdana","sans-serif"'><span=
 style=3D'mso-list:Ignore'>2.<span style=3D'font:7.0pt "Times New Roman"'>&=
nbsp;&nbsp; </span></span></span><![endif]><span style=3D'font-family:"Verd=
ana","sans-serif"'>For user space trace, currectly seems we cannot set the =
flush interval. How can we control the flush internal for UST? If no, is th=
ere hardcoded or random flash interval? Or there is no time based flush mec=
hanism at all for UST?<o:p></o:p></span></p><p class=3DMsoListParagraph sty=
le=3D'text-indent:-.25in;mso-list:l0 level1 lfo2'><![if !supportLists]><spa=
n style=3D'font-family:"Verdana","sans-serif"'><span style=3D'mso-list:Igno=
re'>3.<span style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp; </span></sp=
an></span><![endif]><span style=3D'font-family:"Verdana","sans-serif"'>For =
a severe kernel panic can we extrace buffered trace messages from LTTNG int=
ernal buffer in full memory core dump file? Is there tools on this we can l=
everage?<o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'font-fami=
ly:"Verdana","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal=
><span style=3D'font-family:"Verdana","sans-serif"'>Thank you,<o:p></o:p></=
span></p><p class=3DMsoNormal><span style=3D'font-family:"Verdana","sans-se=
rif"'>- Bingfeng<o:p></o:p></span></p><p class=3DMsoNormal><o:p>&nbsp;</o:p=
></p></div></body></html>=

--_000_4B3E7C3D6AE874479212F4D6AE0AFD1F02C7FF0805MX28Acorpemcc_--


--===============1644715584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1644715584==--
