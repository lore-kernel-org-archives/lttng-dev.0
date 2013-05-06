From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: lttng-tools and userspace-rcu
Date: Mon, 6 May 2013 15:31:46 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD12D11354__34182.367733638$1367854415$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1958072660=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UZNPU-00077c-8I
	for lttng-dev@lists.lttng.org; Mon, 06 May 2013 11:33:04 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, David Goulet <dgoulet@efficios.com>
Cc: David Goulet <david.goulet@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

--===============1958072660==
Content-Language: fr-FR
Content-Type: multipart/alternative;
	boundary="_000_48CF5AC71E61DB46B70D0F388054EFFD12D11354VALE02valcartie_"

--_000_48CF5AC71E61DB46B70D0F388054EFFD12D11354VALE02valcartie_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

   Let's assume I want to do a kernel-only LTTng installation.  After putti=
ng lttng-modules in place, I get lttng-tools and, at its configure step, I =
do:

./configure --disable-lttng-ust

   However, this fails with:

checking whether cds_list_add is declared... no
configure: error: liburcu >=3D 0.7.2 or newer is needed

   Is this normal?  If so, why is userspace-rcu (liburcu) needed for a kern=
el-only tracing solution?  (I'm using a fairly recent set of lttng 2.2.0-rc=
1 git tarballs)

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ<http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ> <http:=
//www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>

--_000_48CF5AC71E61DB46B70D0F388054EFFD12D11354VALE02valcartie_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
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
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Texte de bulles Car";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.TextedebullesCar
	{mso-style-name:"Texte de bulles Car";
	mso-style-priority:99;
	mso-style-link:"Texte de bulles";
	font-family:"Tahoma","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
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
<body lang=3D"FR-CA" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp; Let&#8217;s assume=
 I want to do a kernel-only LTTng installation. &nbsp;After putting lttng-m=
odules in place, I get lttng-tools and, at its configure step, I do:<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:10.0pt;font-=
family:&quot;Courier New&quot;">./configure --disable-lttng-ust</span><span=
 lang=3D"EN-CA"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp; However, this fail=
s with:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:Consolas;m=
so-fareast-language:FR-CA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:Consolas;m=
so-fareast-language:FR-CA">checking whether cds_list_add is declared... no<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:Consolas;m=
so-fareast-language:FR-CA">configure: error: liburcu &gt;=3D 0.7.2 or newer=
 is needed<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:Consolas;m=
so-fareast-language:FR-CA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp; Is this normal?&nb=
sp; If so, why is userspace-rcu (liburcu) needed for a kernel-only tracing =
solution?&nbsp; (I&#8217;m using a fairly recent set of lttng 2.2.0-rc1 git=
 tarballs)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas;mso-fareast-lang=
uage:FR-CA">Daniel U. Thibault<br>
Protection des syst=E8mes et contremesures (PSC) | Systems Protection &amp;=
 Countermeasures (SPC)<br>
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)<br>
R &amp; D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence=
 R&amp;D Canada - Valcartier (DRDC Valcartier)<br>
2459 route de la Bravoure<br>
Qu=E9bec QC&nbsp; G3J 1X5<br>
CANADA<br>
Vox</span><span style=3D"font-size:10.5pt;font-family:Consolas">&nbsp;</spa=
n><span style=3D"font-family:Consolas;mso-fareast-language:FR-CA">: (418) 8=
44-4000 x4245<br>
Fax</span><span style=3D"font-size:10.5pt;font-family:Consolas">&nbsp;</spa=
n><span style=3D"font-family:Consolas;mso-fareast-language:FR-CA">: (418) 8=
44-4538<br>
</span><span style=3D"font-family:Consolas;mso-fareast-language:FR-CA">NAC&=
nbsp;: </span>
<span lang=3D"EN-CA" style=3D"color:#1F497D;mso-fareast-language:FR-CA"><a =
href=3D"http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ"><span lang=3D"=
FR-CA" style=3D"font-size:10.0pt;font-family:&quot;Courier New&quot;;color:=
blue">918V QSDJ</span></a></span><span lang=3D"EN-CA" style=3D"color:#1F497=
D;mso-fareast-language:FR-CA">
</span><span style=3D"mso-fareast-language:FR-CA">&lt;</span><u><span style=
=3D"font-size:10.0pt;font-family:&quot;Courier New&quot;;color:blue;mso-far=
east-language:FR-CA">http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ</s=
pan></u><span style=3D"mso-fareast-language:FR-CA">&gt;<span style=3D"color=
:#1F497D"><br>
</span></span><span style=3D"font-family:Consolas;mso-fareast-language:FR-C=
A">Gouvernement du Canada&nbsp;| Government of Canada<br>
</span><span style=3D"mso-fareast-language:FR-CA">&lt;</span><span lang=3D"=
EN-CA" style=3D"font-size:10.0pt;font-family:&quot;Courier New&quot;;color:=
blue;mso-fareast-language:FR-CA"><a href=3D"http://www.valcartier.drdc-rddc=
.gc.ca/"><span lang=3D"FR-CA" style=3D"color:blue">http://www.valcartier.dr=
dc-rddc.gc.ca/</span></a></span><span style=3D"mso-fareast-language:FR-CA">=
&gt;</span><span style=3D"font-size:10.5pt;font-family:Consolas;mso-fareast=
-language:FR-CA"><o:p></o:p></span></p>
</div>
</body>
</html>

--_000_48CF5AC71E61DB46B70D0F388054EFFD12D11354VALE02valcartie_--


--===============1958072660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1958072660==--
