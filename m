From: "Chang, Zheng" <Zheng.Chang@emc.com>
Subject: Uprobe and extractor for coredump
Date: Tue, 7 Aug 2012 22:31:04 -0400
Message-ID: <6539770C71C3814BB0BFC2DBEBD10508CC6967__38944.4488952451$1344393119$gmane$org@CORPUSMX30B.corp.emc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1741175491=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from hop-nat-141.emc.com ([168.159.213.141]
	helo=mexforward.lss.emc.com) by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Zheng.Chang@emc.com>) id 1Syw3V-0002zL-9b
	for lttng-dev@lists.lttng.org; Tue, 07 Aug 2012 22:31:29 -0400
Received: from hop04-l1d11-si04.isus.emc.com (HOP04-L1D11-SI04.isus.emc.com
	[10.254.111.24])
	by mexforward.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id
	q782VNGM014923
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <lttng-dev@lists.lttng.org>; Tue, 7 Aug 2012 22:31:23 -0400
Received: from mailhub.lss.emc.com (mailhubhoprd02.lss.emc.com
	[10.254.221.253]) by hop04-l1d11-si04.isus.emc.com (RSA
	Interceptor) for <lttng-dev@lists.lttng.org>;
	Tue, 7 Aug 2012 22:31:07 -0400
Received: from corpussmtp4.corp.emc.com (corpussmtp4.corp.emc.com
	[10.254.169.197])
	by mailhub.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id
	q782V72H018813
	for <lttng-dev@lists.lttng.org>; Tue, 7 Aug 2012 22:31:07 -0400
Content-class: urn:content-classes:message
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

This is a multi-part message in MIME format.

--===============1741175491==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CD750D.DCD91E12"

This is a multi-part message in MIME format.

------_=_NextPart_001_01CD750D.DCD91E12
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

Recently Linus merged uprobe into kernel mainline and perf has supported
user-space dynamic tracing now.

Is there any plan or motion on this with LTTng?

=20

I did some research on buffer management of LTTng. And I'm trying to
figure out a way to extract trace info from coredump.

Here is an immature idea about the extractor:

-          Resolve the addresses of necessary symbols from coredump with
binary format library/tool

-          Restructure the data structures

-          Following the data structures, dump the buffer data page by
page

=20

Any good ideas or suggestions or concerns?

=20

BR

Zheng


------_=_NextPart_001_01CD750D.DCD91E12
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 12 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@SimSun";
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1175073695;
	mso-list-type:hybrid;
	mso-list-template-ids:1170375834 1182562004 67698691 67698693 67698689 =
67698691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:39.0pt;
	text-indent:-.25in;
	font-family:"Calibri","sans-serif";
	mso-fareast-font-family:SimSun;}
@list l1
	{mso-list-id:1206255980;
	mso-list-type:hybrid;
	mso-list-template-ids:289173012 1206832364 67698691 67698693 67698689 =
67698691 67698693 67698689 67698691 67698693;}
@list l1:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Calibri","sans-serif";
	mso-fareast-font-family:SimSun;}
@list l2
	{mso-list-id:1751459580;
	mso-list-type:hybrid;
	mso-list-template-ids:-1426704450 -1002809590 67698691 67698693 =
67698689 67698691 67698693 67698689 67698691 67698693;}
@list l2:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Calibri","sans-serif";
	mso-fareast-font-family:SimSun;}
@list l3
	{mso-list-id:1966228905;
	mso-list-type:hybrid;
	mso-list-template-ids:1878585476 67698699 67698691 67698693 67698689 =
67698691 67698693 67698689 67698691 67698693;}
@list l3:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0D8;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:39.0pt;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l3:level2
	{mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level3
	{mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level4
	{mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level5
	{mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level6
	{mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level7
	{mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level8
	{mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level9
	{mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p =
class=3DMsoNormal>Hi,<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Recently =
Linus merged uprobe into kernel mainline and perf has supported =
user-space dynamic tracing now.<o:p></o:p></p><p class=3DMsoNormal>Is =
there any plan or motion on this with LTTng?<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I did some =
research on buffer management of LTTng. And I&#8217;m trying to figure =
out a way to extract trace info from coredump.<o:p></o:p></p><p =
class=3DMsoNormal>Here is <a name=3D"OLE_LINK4"></a><a =
name=3D"OLE_LINK3">an </a><a name=3D"OLE_LINK9"></a><a =
name=3D"OLE_LINK10">immature idea </a>about the =
extractor:<o:p></o:p></p><p class=3DMsoListParagraph =
style=3D'text-align:justify;text-justify:inter-ideograph;text-indent:-.25=
in;mso-list:l2 level1 lfo4'><![if !supportLists]><span =
style=3D'mso-list:Ignore'>-<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></span><![endif]><i>Resolve the addresses of necessary symbols =
from coredump with binary format library/tool<o:p></o:p></i></p><p =
class=3DMsoListParagraph =
style=3D'text-align:justify;text-justify:inter-ideograph;text-indent:-.25=
in;mso-list:l2 level1 lfo4'><![if !supportLists]><span =
style=3D'mso-list:Ignore'>-<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></span><![endif]><i>Restructure the data =
structures<o:p></o:p></i></p><p class=3DMsoListParagraph =
style=3D'text-align:justify;text-justify:inter-ideograph;text-indent:-.25=
in;mso-list:l2 level1 lfo4'><![if !supportLists]><span =
style=3D'mso-list:Ignore'>-<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></span><![endif]><i>Following the data structures, dump the =
buffer data page by page<o:p></o:p></i></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Any good =
ideas or suggestions or concerns?<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>BR<o:p></o:p></p><p =
class=3DMsoNormal>Zheng<o:p></o:p></p></div></body></html>
------_=_NextPart_001_01CD750D.DCD91E12--


--===============1741175491==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1741175491==--
