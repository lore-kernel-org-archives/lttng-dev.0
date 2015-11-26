From: "Luetkebohle Ingo (CR/AEA2)" <Ingo.Luetkebohle@de.bosch.com>
Subject: faulty context for sched_stat_ tracepoints?
Date: Thu, 26 Nov 2015 12:34:56 +0000
Message-ID: <73b02dedea024337886a82474372bcde__44554.2515525178$1448541355$gmane$org@FE-MBX1025.de.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0072539637=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Ingo.Luetkebohle@de.bosch.com>) id 1a1vlL-0002Jp-Na
 for lttng-dev@lists.lttng.org; Thu, 26 Nov 2015 07:35:01 -0500
Received: from vsmta12.fe.internet.bosch.com (unknown [10.4.98.52])
 by imta24.fe.bosch.de (Postfix) with ESMTP id C018FD801D7
 for <lttng-dev@lists.lttng.org>; Thu, 26 Nov 2015 13:34:57 +0100 (CET)
Received: from FE-MBX1025.de.bosch.com (vsgw23.fe.internet.bosch.com
 [10.4.98.23])
 by vsmta12.fe.internet.bosch.com (Postfix) with ESMTP id B99041B802D7
 for <lttng-dev@lists.lttng.org>; Thu, 26 Nov 2015 13:34:57 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0072539637==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_73b02dedea024337886a82474372bcdeFEMBX1025deboschcom_"

--_000_73b02dedea024337886a82474372bcdeFEMBX1025deboschcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I noticed that the "procname" and "tid" *context* variables can differ from=
 the "comm" and "tid" variables of the sched_stat_-tracepoints (e.g., for s=
ched_stat_runtime).

For example, see the following two outputs:
[15:49:33.674072890] (+0.000029771) rng2070 sched_stat_sleep: { cpu_id =3D =
4 }, { pid =3D 26974, procname =3D "amcl", tid =3D 26975 }, { comm =3D "ltt=
ng-sessiond", tid =3D 798, delay =3D 194122524 }
[15:49:33.722894563] (+0.000004851) rng2070 sched_stat_sleep: { cpu_id =3D =
0 }, { pid =3D 0, procname =3D "swapper/0", tid =3D 0 }, { comm =3D "amcl",=
 tid =3D 27078, delay =3D 10043658 }

In both cases, procname differs from comm.  I've looked at the kernel sourc=
e code, and the "comm" variable is taken from task_struct.filename. Barring=
 renames, this would be the correct one, so I'm assuming that the context i=
s sometimes incorrect.

Now, for this particular case, I can take the correct variables from the tr=
acepoint, but of course, this makes me worried that the context might also =
be wrong in other cases... Do you have any idea what could be going on here=
?

LTTng is Version 2.7.x+stable+bzr2948+pack17+201511192116~ubuntu14.04.1 and=
 this is on a 3.19.0-33-generic kernel (btw, that's not the default kernel =
for Ubuntu 14.04, but the LTS vivid backport kernel).

Mit freundlichen Gr=FC=DFen / Best regards

Ingo Luetkebohle

Application Software (CR/AEA2)
Tel. +49(711)811-12248 | Fax +49(711)811-0 | Ingo.Luetkebohle@de.bosch.com<=
mailto:Ingo.Luetkebohle@de.bosch.com>



--_000_73b02dedea024337886a82474372bcdeFEMBX1025deboschcom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
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
	font-family:"Arial",sans-serif;
	color:windowtext;
	font-weight:normal;
	font-style:normal;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
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
<body lang=3D"DE" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">Hi,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">I noticed that the &#8220;procname&#82=
21; and &#8220;tid&#8221; *<b>context</b>* variables can differ from the &#=
8220;comm&#8221; and &#8220;tid&#8221; variables of the sched_stat_-tracepo=
ints (e.g., for sched_stat_runtime).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">For example, see the following two out=
puts:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">[15:49:33.674072890] (&#43;0.000029771=
) rng2070 sched_stat_sleep: { cpu_id =3D 4 }, { pid =3D 26974, procname =3D=
 &quot;amcl&quot;, tid =3D 26975 }, { comm =3D &quot;lttng-sessiond&quot;, =
tid =3D 798,
 delay =3D 194122524 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">[15:49:33.722894563] (&#43;0.000004851=
) rng2070 sched_stat_sleep: { cpu_id =3D 0 }, { pid =3D 0, procname =3D &qu=
ot;swapper/0&quot;, tid =3D 0 }, { comm =3D &quot;amcl&quot;, tid =3D 27078=
, delay =3D
 10043658 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">In both cases, procname differs from c=
omm. &nbsp;I&#8217;ve looked at the kernel source code, and the &#8220;comm=
&#8221; variable is taken from task_struct.filename. Barring renames, this
 would be the correct one, so I&#8217;m assuming that the context is someti=
mes incorrect.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">Now, for this particular case, I can t=
ake the correct variables from the tracepoint, but of course, this makes me=
 worried that the context might also be wrong in
 other cases&#8230; Do you have any idea what could be going on here?<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">LTTng is Version 2.7.x&#43;stable&#43;=
bzr2948&#43;pack17&#43;201511192116~ubuntu14.04.1 and this is on a 3.19.0-3=
3-generic kernel (btw, that&#8217;s not the default kernel for Ubuntu
 14.04, but the LTS vivid backport kernel).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif;color:black;mso-fareast-language:DE">Mi=
t freundlichen Gr=FC=DFen / Best regards
<br>
<br>
<b>Ingo Luetkebohle<br>
</b><br>
Application Software (CR/AEA2) <br>
Tel. &#43;49(711)811-12248 | Fax &#43;49(711)811-0 | </span><span style=3D"=
font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black;mso-f=
areast-language:DE"><a href=3D"mailto:Ingo.Luetkebohle@de.bosch.com"><span =
lang=3D"EN-US" style=3D"color:blue">Ingo.Luetkebohle@de.bosch.com</span></a=
></span><span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-=
serif;color:black;mso-fareast-language:DE">
</span><span lang=3D"EN-US" style=3D"font-size:8.0pt;font-family:&quot;Aria=
l&quot;,sans-serif;color:black;mso-fareast-language:DE"><br>
</span><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Ari=
al&quot;,sans-serif;color:black;mso-fareast-language:DE"><br>
<br>
</span><span lang=3D"EN-US"><o:p></o:p></span></p>
</div>
</body>
</html>

--_000_73b02dedea024337886a82474372bcdeFEMBX1025deboschcom_--



--===============0072539637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0072539637==--
