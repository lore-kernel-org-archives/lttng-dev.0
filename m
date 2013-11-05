From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: [PATCH lttng-tools] Fix: Some corrections to the
 lttng man page
Date: Tue, 5 Nov 2013 21:34:45 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267A10D1__16015.1078868241$1383687349$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD2679FA2C@VAL-E-01.valcartier.drdc-rddc.gc.ca>
	<CA+jJMxu4WNTRny2x6C3H96_wLQaYeBEPk+HX1pXVvhHjT3X8Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0068216871=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VdoGt-0004py-5I
	for lttng-dev@lists.lttng.org; Tue, 05 Nov 2013 16:34:53 -0500
In-Reply-To: <CA+jJMxu4WNTRny2x6C3H96_wLQaYeBEPk+HX1pXVvhHjT3X8Uw@mail.gmail.com>
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
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0068216871==
Content-Language: fr-FR
Content-Type: multipart/alternative;
	boundary="_000_48CF5AC71E61DB46B70D0F388054EFFD267A10D1VALE01valcartie_"

--_000_48CF5AC71E61DB46B70D0F388054EFFD267A10D1VALE01valcartie_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

De : jeremie.galarneau@gmail.com
Envoy=E9 : 5 novembre 2013 15:51

On Thu, Oct 24, 2013 at 12:09 PM, Thibault, Daniel <Daniel.Thibault@drdc-rd=
dc.gc.ca<mailto:Daniel.Thibault@drdc-rddc.gc.ca>> wrote:
-----Message d'origine-----
Date: Wed, 23 Oct 2013 12:08:47 -0400
From: J?r?mie Galarneau <jeremie.galarneau@efficios.com<mailto:jeremie.gala=
rneau@efficios.com>>

> diff --git a/doc/man/lttng.1 b/doc/man/lttng.1
> [...]
> +All user-space applications instrumented with lttng-ust(3) will
> automatically register to the session daemon. This feature gives you the
> ability to list available traceable applications and tracepoints on a per=
 user
> basis. (See \fBlist\fP command).
   Is this a statement of intent?  LTTng 2.3.0's list command identifies us=
er-space events by trace provider name, event name, and process ID, but not=
 by user ID (in fact it doesn't even yet filter the kernel events out when =
one asks for 'list -u session'; see bug #654).  And there is as yet no way =
to filter the 'lttng list' output by user ID (an optional argument for the =
-u option could do the trick).
   Of course, listing available tracepoints is automatically per-user when =
using a local session daemon.  But if you're a member of the 'tracing' grou=
p, you'll deal exclusively with the root daemon and won't have that choice.
> I didn't change the meaning of the original sentence. It just means that =
"lttng list" will output the events registered to the user's corresponding =
session daemon.
> Perhaps you can suggest a better phrasing?
>
> J=E9r=E9mie

   How about this?

Each user-space application instrumented with lttng-ust(3) will automatical=
ly
register with the root session daemon and its user session daemon. This all=
ows
each daemon to list the available traceable applications and tracepoints at
any given moment (See the \fBlist\fP command).

(There is no need to explain further the diff between the two daemons since=
 the preceding paragraph in the man page already talks about co-existing se=
ssion daemons)

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

--_000_48CF5AC71E61DB46B70D0F388054EFFD267A10D1VALE01valcartie_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
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
<p class=3D"MsoNormal"><b><span lang=3D"EN-CA" style=3D"font-size:10.0pt;fo=
nt-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">De&nbsp;:</span></b><s=
pan lang=3D"EN-CA" style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;=
,&quot;sans-serif&quot;"> jeremie.galarneau@gmail.com<br>
<b>Envoy=E9&nbsp;:</b> 5 novembre 2013 15:51<br>
<br>
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">On Thu, Oct 24, 2013 at 12:09 P=
M, Thibault, Daniel &lt;</span><a href=3D"mailto:Daniel.Thibault@drdc-rddc.=
gc.ca" target=3D"_blank"><span lang=3D"EN-CA">Daniel.Thibault@drdc-rddc.gc.=
ca</span></a><span lang=3D"EN-CA">&gt; wrote:<o:p></o:p></span></p>
<div>
<div>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0c=
m 0cm 0cm 6.0pt;margin-left:4.8pt;margin-right:0cm">
<p class=3D"MsoNormal">-----Message d'origine-----<br>
Date: Wed, 23 Oct 2013 12:08:47 -0400<br>
From: J?r?mie Galarneau &lt;<a href=3D"mailto:jeremie.galarneau@efficios.co=
m">jeremie.galarneau@efficios.com</a>&gt;<br>
<br>
&gt; diff --git a/doc/man/lttng.1 b/doc/man/lttng.1<br>
&gt; [...]<o:p></o:p></p>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">&gt; &#43;All user-sp=
ace applications instrumented with lttng-ust(3) will<br>
&gt; automatically register to the session daemon. This feature gives you t=
he<br>
&gt; ability to list available traceable applications and tracepoints on a =
per user<br>
&gt; basis. (See \fBlist\fP command).<o:p></o:p></p>
</div>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:0cm;margin-right:0cm;mar=
gin-bottom:12.0pt;margin-left:11.55pt">
&nbsp; &nbsp;Is this a statement of intent? &nbsp;LTTng 2.3.0's list comman=
d identifies user-space events by trace provider name, event name, and proc=
ess ID, but not by user ID (in fact it doesn't even yet filter the kernel e=
vents out when one asks for 'list -u session';
 see bug #654). &nbsp;And there is as yet no way to filter the 'lttng list'=
 output by user ID (an optional argument for the -u option could do the tri=
ck).<span style=3D"color:#1F497D"><o:p></o:p></span></p>
</blockquote>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0c=
m 0cm 0cm 6.0pt;margin-left:4.8pt;margin-right:0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-CA">=
&nbsp; &nbsp;Of course, listing available tracepoints is automatically per-=
user when using a local session daemon. &nbsp;</span>But if you're a member=
 of the 'tracing' group, you'll deal exclusively with
 the root daemon and won't have that choice.<o:p></o:p></p>
</blockquote>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&gt; </=
span><span lang=3D"EN-CA">I didn't change the meaning of the original sente=
nce. It just means that &quot;lttng list&quot; will output the events regis=
tered to the user's corresponding session daemon.<span style=3D"color:#1F49=
7D"><o:p></o:p></span></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&gt;</s=
pan><span lang=3D"EN-CA"> Perhaps you can suggest a better phrasing?<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&gt;</span><o:p>&nbsp;=
</o:p></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&gt; </span>J=E9r=E9mi=
e<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp; How about this?<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">Each user-space application ins=
trumented with lttng-ust(3) will automatically
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">register with the root session =
daemon and its user session daemon. This allows
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">each daemon to list the availab=
le traceable applications and tracepoints at
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">any given moment (See the \fBli=
st\fP command).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">(There is no need to explain fu=
rther the diff between the two daemons since the preceding paragraph in the=
 man page already talks about co-existing session daemons)<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><o:p>&nbsp;</o:p></span></p>
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
</div>
</div>
</body>
</html>

--_000_48CF5AC71E61DB46B70D0F388054EFFD267A10D1VALE01valcartie_--


--===============0068216871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0068216871==--
