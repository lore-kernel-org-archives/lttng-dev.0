From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: instrumenting shared library
Date: Fri, 4 Apr 2014 20:33:21 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD35993200__1113.24601243741$1396643675$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD35992F74@VAL-E-02.valcartier.drdc-rddc.gc.ca><CAM5kDqy62zjzLddVkRvg94jAxSCSN0uFqxmJL7RwN6XN31x0Jw@mail.gmail.com><48CF5AC71E61DB46B70D0F388054EFFD3599315B@VAL-E-02.valcartier.drdc-rddc.gc.ca>
 <CAM5kDqyCTjKLWhR5XXT9DvXHaniOnJy0SPSDOMPw3eCSD7Z6Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1525890688=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WWAnm-0003LT-R8
 for lttng-dev@lists.lttng.org; Fri, 04 Apr 2014 16:33:33 -0400
In-Reply-To: <CAM5kDqyCTjKLWhR5XXT9DvXHaniOnJy0SPSDOMPw3eCSD7Z6Uw@mail.gmail.com>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Anand Neeli <anand.neeli@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1525890688==
Content-Language: fr-FR
Content-Type: multipart/alternative;
	boundary="_000_48CF5AC71E61DB46B70D0F388054EFFD35993200VALE02valcartie_"

--_000_48CF5AC71E61DB46B70D0F388054EFFD35993200VALE02valcartie_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


De : Anand Neeli [mailto:anand.neeli@gmail.com]
Envoy=E9 : 4 avril 2014 16:17

What i'm looking at it is: adding lttng infra in our code base. I'm looking=
 for a solution where most of the lttng build and launch parts are abstract=
ed to the end app/library developer.
That is the reason why i'm not in favor of having LD_PRELOAD while launchin=
g an app. This would need the app developer to check if included libraries =
has tracing support and add .so appropriately to LD_PRELOAD (which needs mo=
re education to developer on lttng and included libraries)
If we can launch app(with or without instrumented library) normally and lim=
it the complexity of linking to makefile it will be great.

Please keep me posted if you have any more thoughts on this.
Also, can you please send me the users guide.

Anand Neeli
________________________________
   The idea behind using LD_PRELOAD is to have tracing switchable on and of=
f without needing to recompile or relink the application.  If you make the =
app statically aware of the tracepoint providers, it won't run (won't load)=
 without them.  Of course, if you're comfortable with that, it's okay.
   Another approach is to have tracing controlled by an app option.  This r=
equires the app to explicitly load and unload the tracepoint provider using=
 dlopen() and dlclose().
   Things are also a little different if all you're instrumenting are the l=
ibraries the apps are using.  You might be able to get away with using the =
rpath tag and then just moving the tracepoint provider in and out of scope =
(by copying or renaming the tracepoint provider shared object).  This would=
 be a rather kludgy global setting (unless the directory where the librarie=
s lie is user-specific) and would also not work to turn off tracing while t=
he libraries are in use (because the tracepoint provider would refuse to be=
 unloaded).
   I'll send the PDFs separately.
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
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ<--ESFS=
ECEV-TY3011--------------------------------------->>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/<--ESFSECEV-TY3011------------------=
---------->>


--_000_48CF5AC71E61DB46B70D0F388054EFFD35993200VALE02valcartie_
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
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><b><span lang=3D"FR" style=3D"font-size:10.0pt;font-=
family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">De&nbsp;:</span></b><span=
 lang=3D"FR" style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot=
;sans-serif&quot;"> Anand Neeli [mailto:anand.neeli@gmail.com]
<br>
<b>Envoy=E9&nbsp;:</b> 4 avril 2014 16:17<br>
<br>
<o:p></o:p></span></p>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">What i'm looking at it is: addi=
ng lttng infra in our code base.
</span>I'm looking for a solution where most of the lttng build and launch =
parts are abstracted to the end app/library developer.&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">That is the reason why i'm not in favor of having LD=
_PRELOAD while launching an app. This would need the app developer to check=
 if included libraries has tracing support and add .so appropriately to LD_=
PRELOAD (which needs more education
 to developer on lttng and included libraries)&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">If we can launch app(with or without instrumented li=
brary) normally and limit the complexity of linking to makefile it will be =
great.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Please keep me posted if you have any more thoughts =
on this.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Also, can you please send me the users guide.<o:p></=
o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Anand Neeli<span style=3D"color:#1F497D"><o:p></o:p>=
</span></p>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif=
&quot;;color:#1F497D">
<hr size=3D"2" width=3D"100%" align=3D"center">
</span></div>
</div>
</div>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&nbsp; The idea=
 behind using LD_PRELOAD is to have tracing switchable on and off without n=
eeding to recompile or relink the application. &nbsp;If
 you make the app statically aware of the tracepoint providers, it won&#821=
7;t run (won&#8217;t load) without them.&nbsp; Of course, if you&#8217;re c=
omfortable with that, it&#8217;s okay.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&nbsp; Another =
approach is to have tracing controlled by an app option.&nbsp; This require=
s the app to explicitly load and unload the tracepoint
 provider using dlopen() and dlclose().<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&nbsp; Things a=
re also a little different if all you&#8217;re instrumenting are the librar=
ies the apps are using.&nbsp; You might be able to get away with
 using the rpath tag and then just moving the tracepoint provider in and ou=
t of scope (by copying or renaming the tracepoint provider shared object). =
&nbsp;This would be a rather kludgy global setting (unless the directory wh=
ere the libraries lie is user-specific)
 and would also not work to turn off tracing while the libraries are in use=
 (because the tracepoint provider would refuse to be unloaded).<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&nbsp; I&#8217;=
ll send the PDFs separately.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto">Daniel U. Thibault<br>
Protection des syst=E8mes et contremesures (PSC) | Systems Protection &amp;=
 Countermeasures (SPC)<br>
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)<br>
R &amp; D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence=
 R&amp;D Canada - Valcartier (DRDC Valcartier)<br>
2459 route de la Bravoure<br>
Qu=E9bec QC &nbsp;G3J 1X5<br>
CANADA<br>
Vox : (418) 844-4000 x4245<br>
Fax : (418) 844-4538<br>
NAC : 918V QSDJ &lt;<a href=3D"--ESFSECEV-TY3011---------------------------=
------------" target=3D"_blank">http://www.travelgis.com/map.asp?addr=3D918=
V%20QSDJ</a>&gt;<br>
Gouvernement du Canada | Government of Canada<br>
&lt;<a href=3D"--ESFSECEV-TY3011----------------------------" target=3D"_bl=
ank">http://www.valcartier.drdc-rddc.gc.ca/</a>&gt;<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_48CF5AC71E61DB46B70D0F388054EFFD35993200VALE02valcartie_--


--===============1525890688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1525890688==--
