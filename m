From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: instrumenting shared library
Date: Mon, 7 Apr 2014 13:23:41 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD35993659__28024.8682167896$1396877111$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD35992F74@VAL-E-02.valcartier.drdc-rddc.gc.ca><CAM5kDqy62zjzLddVkRvg94jAxSCSN0uFqxmJL7RwN6XN31x0Jw@mail.gmail.com><48CF5AC71E61DB46B70D0F388054EFFD3599315B@VAL-E-02.valcartier.drdc-rddc.gc.ca><CAM5kDqyCTjKLWhR5XXT9DvXHaniOnJy0SPSDOMPw3eCSD7Z6Uw@mail.gmail.com><CACFGcbbmW0mc3GHa9VYBQLiS6zrm1gQB8bkYMBFadnvM7QKeeQ@mail.gmail.com>
 <CAM5kDqySXuNqYcdjy+kgs-h5cDdiQSioumUX449Gfrcgg+HUbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1787528432=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WX9Wd-0007pe-Tk
 for lttng-dev@lists.lttng.org; Mon, 07 Apr 2014 09:23:54 -0400
In-Reply-To: <CAM5kDqySXuNqYcdjy+kgs-h5cDdiQSioumUX449Gfrcgg+HUbw@mail.gmail.com>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Anand Neeli <anand.neeli@gmail.com>, Lingyu Zhu <lynuszhu@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1787528432==
Content-Language: fr-FR
Content-Type: multipart/alternative;
	boundary="_000_48CF5AC71E61DB46B70D0F388054EFFD35993659VALE02valcartie_"

--_000_48CF5AC71E61DB46B70D0F388054EFFD35993659VALE02valcartie_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

   You need to define your concept of operations carefully.

   An instrumented application can include its tracepoint provider in sever=
al ways.

   One is static inclusion: the application will always be traceable, but a=
ny change to the tracepoints requires a recompilation of the app, plus the =
tracepoint events it produces should not be shared with any other applicati=
on (I say 'should' because they can, but it's a bad idea to do so).

   Another is dynamic inclusion with static awareness: the application will=
 always be traceable, but will refuse to run if does not find the tracepoin=
t provider library (typically provided by LD_PRELOAD). The tracepoint event=
s can be shared with other applications.

   The third is dynamic inclusion without static awareness: this operates a=
s the previous, except that when the app does not find the tracepoint provi=
der it runs normally but is not traceable. Turning off traceability in this=
 way does give you a very small gain in performance.

   The last is fully dynamic inclusion: the app is responsible for its own =
traceability because it loads and unloads its tracepoint provider itself (u=
sing dlopen and dlclose). This is more intrusive as the app's code needs to=
 include this aspect, possibly reflected in its user interface (by a menu i=
tem, for instance). On the good side it does mean you get the slight perfor=
mance gain on demand.

   If the very slight loss of performance due to tracing doesn't bother you=
, your best bet is probably dynamic inclusion without static awareness (thi=
rd option). LTTng can then be configured to capture your app's traces using=
 an on-disc circular buffer (see the tracefile-size and tracefile-count opt=
ions of the enable-channel command). When your app misbehaves, you suspend =
it, suspend tracing (lttng stop), and copy the trace to a working directory=
. You can then babeltrace it or use the Eclipse LTTng views to analyse the =
trace. This works even better if your app is run multiple times, because th=
en LTTng will capture each running separately (see the buffers-pid and buff=
ers-uid options of the enable-channel command). You only need to remember t=
o flush the older traces once you've decided you don't need them anymore.

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

--_000_48CF5AC71E61DB46B70D0F388054EFFD35993659VALE02valcartie_
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
p
	{mso-style-priority:99;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
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
span.EmailStyle18
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
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:10.5pt;font-=
family:Consolas;color:#1F497D">&nbsp;&nbsp; You need to define your concept=
 of operations carefully.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:10.5pt;font-=
family:Consolas;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:10.5pt;font-=
family:Consolas;color:#1F497D">&nbsp;&nbsp; An instrumented application can=
 include its tracepoint provider in several ways.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:10.5pt;font-=
family:Consolas;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:10.5pt;font-=
family:Consolas;color:#1F497D">&nbsp;&nbsp; One is static inclusion: the ap=
plication will always be traceable, but any change to the tracepoints requi=
res a recompilation of the app, plus the tracepoint
 events it produces should not be shared with any other application (I say =
&#8216;should&#8217; because they can, but it&#8217;s a bad idea to do so).=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:10.5pt;font-=
family:Consolas;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:10.5pt;font-=
family:Consolas;color:#1F497D">&nbsp;&nbsp; Another is dynamic inclusion wi=
th static awareness: the application will always be traceable, but will ref=
use to run if does not find the tracepoint provider
 library (typically provided by LD_PRELOAD). The tracepoint events can be s=
hared with other applications.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:10.5pt;font-=
family:Consolas;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:10.5pt;font-=
family:Consolas;color:#1F497D">&nbsp;&nbsp; The third is dynamic inclusion =
without static awareness: this operates as the previous, except that when t=
he app does not find the tracepoint provider it
 runs normally but is not traceable. Turning off traceability in this way d=
oes give you a very small gain in performance.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:10.5pt;font-=
family:Consolas;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:10.5pt;font-=
family:Consolas;color:#1F497D">&nbsp;&nbsp; The last is fully dynamic inclu=
sion: the app is responsible for its own traceability because it loads and =
unloads its tracepoint provider itself (using dlopen
 and dlclose). This is more intrusive as the app&#8217;s code needs to incl=
ude this aspect, possibly reflected in its user interface (by a menu item, =
for instance). On the good side it does mean you get the slight performance=
 gain on demand.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:10.5pt;font-=
family:Consolas;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:10.5pt;font-=
family:Consolas;color:#1F497D">&nbsp;&nbsp; If the very slight loss of perf=
ormance due to tracing doesn&#8217;t bother you, your best bet is probably =
dynamic inclusion without static awareness (third option).
 LTTng can then be configured to capture your app&#8217;s traces using an o=
n-disc circular buffer (see the tracefile-size and tracefile-count options =
of the enable-channel command). When your app misbehaves, you suspend it, s=
uspend tracing (lttng stop), and copy
 the trace to a working directory. You can then babeltrace it or use the Ec=
lipse LTTng views to analyse the trace. This works even better if your app =
is run multiple times, because then LTTng will capture each running separat=
ely (see the buffers-pid and buffers-uid
 options of the enable-channel command). You only need to remember to flush=
 the older traces once you&#8217;ve decided you don&#8217;t need them anymo=
re.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:10.5pt;font-=
family:Consolas;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:Consolas=
;color:#1F497D">Daniel U. Thibault<br>
Protection des syst=E8mes et contremesures (PSC) | Systems Protection &amp;=
 Countermeasures (SPC)<br>
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)<br>
R &amp; D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence=
 R&amp;D Canada - Valcartier (DRDC Valcartier)<br>
2459 route de la Bravoure<br>
Qu=E9bec QC&nbsp; G3J 1X5<br>
CANADA<br>
Vox</span><span style=3D"font-size:10.5pt;font-family:Consolas;color:#1F497=
D;mso-fareast-language:EN-US">&nbsp;</span><span style=3D"font-size:11.0pt;=
font-family:Consolas;color:#1F497D">: (418) 844-4000 x4245<br>
Fax</span><span style=3D"font-size:10.5pt;font-family:Consolas;color:#1F497=
D;mso-fareast-language:EN-US">&nbsp;</span><span style=3D"font-size:11.0pt;=
font-family:Consolas;color:#1F497D">: (418) 844-4538<br>
</span><span style=3D"font-size:11.0pt;font-family:Consolas;color:#1F497D">=
NAC&nbsp;: </span>
<span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-family:&quot;Calibri&qu=
ot;,&quot;sans-serif&quot;;color:#1F497D"><a href=3D"http://www.travelgis.c=
om/map.asp?addr=3D918V%20QSDJ"><span lang=3D"FR-CA" style=3D"font-size:10.0=
pt;font-family:&quot;Courier New&quot;">918V QSDJ</span></a></span><span la=
ng=3D"EN-CA" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;;color:#1F497D">
</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;;color:#1F497D">&lt;</span><u><span style=3D"font-size:10=
.0pt;font-family:&quot;Courier New&quot;;color:blue">http://www.travelgis.c=
om/map.asp?addr=3D918V%20QSDJ</span></u><span style=3D"font-size:11.0pt;fon=
t-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;</sp=
an><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sa=
ns-serif&quot;;color:#1F497D"><br>
</span><span style=3D"font-size:11.0pt;font-family:Consolas;color:#1F497D">=
Gouvernement du Canada&nbsp;| Government of Canada<br>
</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;;color:#1F497D">&lt;</span><span lang=3D"EN-CA" style=3D"=
font-size:10.0pt;font-family:&quot;Courier New&quot;;color:blue"><a href=3D=
"http://www.valcartier.drdc-rddc.gc.ca/"><span lang=3D"FR-CA">http://www.va=
lcartier.drdc-rddc.gc.ca/</span></a></span><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;<=
/span><span style=3D"font-size:10.5pt;font-family:Consolas;color:#1F497D"><=
o:p></o:p></span></p>
</div>
</body>
</html>

--_000_48CF5AC71E61DB46B70D0F388054EFFD35993659VALE02valcartie_--


--===============1787528432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1787528432==--
