From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Google Summer of Code
Date: Thu, 11 Apr 2013 13:20:55 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD12D0DF1C__17603.7209610969$1365686548$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD12D0DC32@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<CA+jJMxtP+n274AhsXQ23TXYPo8UsXtShjYxwJwwO69e=N1nbnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0717468396=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UQHRy-0007iY-9k
	for lttng-dev@lists.lttng.org; Thu, 11 Apr 2013 09:22:02 -0400
In-Reply-To: <CA+jJMxtP+n274AhsXQ23TXYPo8UsXtShjYxwJwwO69e=N1nbnQ@mail.gmail.com>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>, "Painchaud,
	Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

--===============0717468396==
Content-Language: fr-FR
Content-Type: multipart/alternative;
	boundary="_000_48CF5AC71E61DB46B70D0F388054EFFD12D0DF1CVALE02valcartie_"

--_000_48CF5AC71E61DB46B70D0F388054EFFD12D0DF1CVALE02valcartie_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

De : jeremie.galarneau@gmail.com [mailto:jeremie.galarneau@gmail.com] De la=
 part de J=E9r=E9mie Galarneau
Envoy=E9 : 10 avril 2013 17:53

Certainly seems worthwhile to me although I never heard about debugfs being=
 phased out. Could you clarify that point?

J=E9r=E9mie

> On Tue, Apr 9, 2013 at 11:21 AM, Thibault, Daniel <Daniel.Thibault@drdc-r=
ddc.gc.ca<mailto:Daniel.Thibault@drdc-rddc.gc.ca>> wrote:
>   Even if the debugfs tracing facility is destined for eventual withdrawa=
l from the Linux kernel, it may be of interest to some to recover older tra=
ces generated in this way -if only in order to be able to process them in t=
he same way as CTF text dumps.  Conversion to the babeltrace text format sh=
ould be fairly straightforward; conversion to CTF would be trickier.

   Pure speculation on my part, based on the observation that the debugfs s=
ervice seems less efficient than lttng.  The sentence is meant to be read "=
this may be of interest even if debugfs turns out to be destined to be phas=
ed out".  (I'd like to know whether the debugfs facility is as signal-, thr=
ead-, and interrupt-safe as lttng)

   This said, do you know more about how this facility came about?  LTTng 1=
 used debugfs for its trace control as well, so which came first?  Debugfs =
or lttng 1?  How come the tracepoint and syscall tracing achievable with de=
bugfs is not a perfect match with lttng's (re lttng 2)?  (lttng traces the =
kvm, lttng_statedump, and snd_soc subsystems but debugfs does not; converse=
ly, lttng misses the drm, fs, mce, raw_syscalls, vfs, vsyscall, and xen sub=
systems; on the syscall side, lttng captures sys_clone, sys_execve and sys_=
unknown (which debugfs misses), while I haven't found debugfs syscalls that=
 lttng misses (but I can't rule out that possibility))

Daniel U. Thibault
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)
Protection des syst=E8mes et contremesures (PSC) / Systems Protection & Cou=
ntermeasures (SPC)
2459 route de la Bravoure
Qu=E9bec, QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245<tel:%28418%29%20844-4000%20x4245>
Fax : (418) 844-4538<tel:%28418%29%20844-4538>
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada / Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>

--_000_48CF5AC71E61DB46B70D0F388054EFFD12D0DF1CVALE02valcartie_
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
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
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
	mso-style-link:"Texte de bulles Car";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
span.EmailStyle17
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
span.TextedebullesCar
	{mso-style-name:"Texte de bulles Car";
	mso-style-priority:99;
	mso-style-link:"Texte de bulles";
	font-family:"Tahoma","sans-serif";
	mso-fareast-language:FR-CA;}
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
<p class=3D"MsoNormal"><b><span lang=3D"FR" style=3D"font-size:10.0pt;font-=
family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">De&nbsp;:</span></b><span=
 lang=3D"FR" style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot=
;sans-serif&quot;"> jeremie.galarneau@gmail.com [mailto:jeremie.galarneau@g=
mail.com]
<b>De la part de</b> J=E9r=E9mie Galarneau<br>
<b>Envoy=E9&nbsp;:</b> 10 avril 2013 17:53<br>
<br>
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">Certainly seems worthwhile to m=
e although I never heard about debugfs being phased out.
</span>Could you clarify that point?<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<div>
<p class=3D"MsoNormal">J=E9r=E9mie<o:p></o:p></p>
</div>
<div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&gt; </=
span><span lang=3D"EN-CA">On Tue, Apr 9, 2013 at 11:21 AM, Thibault, Daniel=
 &lt;</span><a href=3D"mailto:Daniel.Thibault@drdc-rddc.gc.ca" target=3D"_b=
lank"><span lang=3D"EN-CA">Daniel.Thibault@drdc-rddc.gc.ca</span></a><span =
lang=3D"EN-CA">&gt;
 wrote:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&gt;</s=
pan><span lang=3D"EN-CA"> &nbsp;<span style=3D"color:#1F497D">
</span>Even if the debugfs tracing facility is destined for eventual withdr=
awal from the Linux kernel, it may be of interest to some to recover older =
traces generated in this way -if only in order to be able to process them i=
n the same way as CTF text dumps.
 &nbsp;Conversion to the babeltrace text format should be fairly straightfo=
rward; conversion to CTF would be trickier.<br>
<br>
<span style=3D"color:#1F497D">&nbsp;&nbsp; Pure speculation on my part, bas=
ed on the observation that the debugfs service seems less efficient than lt=
tng.&nbsp; The sentence is meant to be read &#8220;this may be of interest =
even if debugfs turns out to be destined to be phased out&#8221;.&nbsp;
 (I&#8217;d like to know whether the debugfs facility is as signal-, thread=
-, and interrupt-safe as lttng)<o:p></o:p></span></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&=
nbsp; This said, do you know more about how this facility came about?&nbsp;=
 LTTng 1 used debugfs for its trace control as well, so which came first? &=
nbsp;Debugfs or lttng 1?&nbsp; How come the tracepoint and syscall
 tracing achievable with debugfs is not a perfect match with lttng&#8217;s =
(re lttng 2)?&nbsp; (lttng traces the kvm, lttng_statedump, and snd_soc sub=
systems but debugfs does not; conversely, lttng misses the drm, fs, mce, ra=
w_syscalls, vfs, vsyscall, and xen subsystems;
 on the syscall side, lttng captures sys_clone, sys_execve and sys_unknown =
(which debugfs misses), while I haven&#8217;t found debugfs syscalls that l=
ttng misses (but I can&#8217;t rule out that possibility))<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><br>
</span>Daniel U. Thibault<br>
R &amp; D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence=
 R&amp;D Canada - Valcartier (DRDC Valcartier)<br>
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)<br>
Protection des syst=E8mes et contremesures (PSC) / Systems Protection &amp;=
 Countermeasures (SPC)<br>
2459 route de la Bravoure<br>
Qu=E9bec, QC&nbsp; G3J 1X5<br>
CANADA<br>
Vox&nbsp;: <a href=3D"tel:%28418%29%20844-4000%20x4245">(418) 844-4000 x424=
5</a><br>
Fax&nbsp;: <a href=3D"tel:%28418%29%20844-4538">(418) 844-4538</a><br>
NAC&nbsp;: 918V QSDJ &lt;<a href=3D"http://www.travelgis.com/map.asp?addr=
=3D918V%20QSDJ" target=3D"_blank">http://www.travelgis.com/map.asp?addr=3D9=
18V%20QSDJ</a>&gt;<br>
Gouvernement du Canada&nbsp;/ Government of Canada<br>
&lt;<a href=3D"http://www.valcartier.drdc-rddc.gc.ca/" target=3D"_blank">ht=
tp://www.valcartier.drdc-rddc.gc.ca/</a><span style=3D"color:#1F497D">&gt;<=
/span><o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_48CF5AC71E61DB46B70D0F388054EFFD12D0DF1CVALE02valcartie_--


--===============0717468396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0717468396==--
