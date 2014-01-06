From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: lttng-ust works
Date: Mon, 6 Jan 2014 21:32:46 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267B554A__22433.7127911442$1389044040$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD267B3B62@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<6CFA219DE9CAD940989B83CA579159F91B445FD266@SGSINEXC014.vestas.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0962677225=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1W0Hmy-0003ow-5y
	for lttng-dev@lists.lttng.org; Mon, 06 Jan 2014 16:32:56 -0500
In-Reply-To: <6CFA219DE9CAD940989B83CA579159F91B445FD266@SGSINEXC014.vestas.net>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Manikandan Govindaswamy <magov@vestas.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0962677225==
Content-Language: fr-FR
Content-Type: multipart/alternative;
	boundary="_000_48CF5AC71E61DB46B70D0F388054EFFD267B554AVALE02valcartie_"

--_000_48CF5AC71E61DB46B70D0F388054EFFD267B554AVALE02valcartie_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> I tried different possibility to generate the userspace trace and kernel =
trace and observed that I'm not able to generate the user space tracing If =
the lttng-sessiond is started

> using root user.

>

> I'm using busybox in my custom Linux platform and no sudo support. It's a=
 64 bit machine.

> Trail 2:

> =3D=3D=3D=3D=3D=3D=3D=3D

>

> 1. Start the lttng-session from root user

> 2. Run the following command from "tracing" group user

>

> lttng@/ # lttng -g lttng create ks

> Session ks created.

> Traces will be written in /home/lttng/lttng-traces/ks-20131224-123537

> lttng@/ # lttng -g lttng enable-event -k -a

> All kernel events are enabled in channel channel0

> lttng@/ # lttng -g lttng start

> Tracing started for session ks

> lttng@/ # lttng -g lttng stop

> Waiting for data availability.

> Tracing stopped for session ks

> [...]

> The kernel traces are generated fine



   I can't follow you on this one since my Ubuntu system doesn't allow su (=
not easily, anyway).  However, I'll just point out that the lttng group opt=
ion should not be used since it does not seem to work at all (a problem I r=
eported on the lttng-dev mailing list back on 9 July 2013, and which has re=
mained unanswered so far).



   According to the code, the lttng client checks if it belongs to the 'gro=
up_name' (default 'tracing') to decide which socket to ask for; in practice=
, whether a root lttng-sessiond is running or not, if I'm not a member of '=
tracing' it spawns a local lttng-sessiond whatever the specified group_name=
; conversely, if the root lttng-sessiond is running alone, I get to interro=
gate it regardless of the specified group_name if I'm a member of its 'trac=
ing' group.  What matters here is which group option value was used to laun=
ch lttng-sessiond.  *That* works, forcing the root lttng-sessiond to accept=
 unprivileged lttng client commands as privileged if the client is running =
in that group.



   Note that if you run a kernel and user-space trace as su, you will get t=
wo lttng-consumerd daemons, both running as root: one daemon handles the ke=
rnel events, the other the user-space events.  It's easier to tell what is =
going on with the system monitor if you do not issue your commands from su.=
  Stay in a normal user shell, and use sudo as required.  (But you have no =
sudo support, you say...This'll be tricky because I don't have any su suppo=
rt!)



   In the trails you explored, it would have been useful to know which grou=
ps your shell is a member of, and how the lttng-sessiond daemon was launche=
d (i.e., which group it treats as the 'tracing' group).



> Trail 2:

> [...]

> lttng@/ # lttng -g lttng create as

> Session as created.

> Traces will be written in /home/lttng/lttng-traces/as-20131224-123811

> lttng@/ # lttng -g lttng enable-event -k -u -a

> All kernel events are enabled in channel channel0

> lttng@/ # lttng -g lttng start

> Tracing started for session as

> lttng@/ # cd /tmp/

> lttng@/tmp # ./sample

> lttng@/tmp # lttng -g lttng stop

> Waiting for data availability.

> Tracing stopped for session as

> lttng@/tmp # lttng -g lttng destroy

> Session as destroyed

> remove config file: Permission denied

> lttng@/tmp # cd /home/lttng/lttng-traces/

> No userspace traces are generated



   The "remove config file: Permission denied" you get is intriguing but a =
separate problem.  What you did wrong here is to write:



lttng@/ # lttng -g lttng enable-event -k -u -a



   thinking that this would enable both kernel and user-space events.  It d=
oes not.  The lttng client handles only one domain at a time.  In this case=
, the -k option shadowed the -u option, which was ignored.  If you try it a=
gain with this:



lttng@/ # lttng -g lttng enable-event -k -a

lttng@/ # lttng -g lttng enable-event -u -a



   This time you should get both kernel and user-space events in the trace.



   As for trail 3, it does not capture any kernel events because it did not=
 ask to capture any.  You only enabled user-space events.



   Hope this helps.



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
ECEV-TY3011-------------------------------->>

Gouvernement du Canada | Government of Canada

<http://www.valcartier.drdc-rddc.gc.ca/<--ESFSECEV-TY3011------------------=
--->>

--_000_48CF5AC71E61DB46B70D0F388054EFFD267B554AVALE02valcartie_
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
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Texte brut Car";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Texte de bulles Car";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.TextebrutCar
	{mso-style-name:"Texte brut Car";
	mso-style-priority:99;
	mso-style-link:"Texte brut";
	font-family:Consolas;}
p.PlainText, li.PlainText, div.PlainText
	{mso-style-name:"Plain Text";
	mso-style-link:"Plain Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri","sans-serif";}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
span.TextedebullesCar
	{mso-style-name:"Texte de bulles Car";
	mso-style-priority:99;
	mso-style-link:"Texte de bulles";
	font-family:"Tahoma","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
<body lang=3D"FR-CA" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 </span><span lang=3D"EN-US">I tried different possibility to generate the =
userspace trace and kernel trace and observed that I&#8217;m not able to ge=
nerate the user space tracing If the lttng-sessiond
 is started<span style=3D"color:#1F497D"><o:p></o:p></span></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
</span><span lang=3D"EN-US"> using root user.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
</span><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 </span><span lang=3D"EN-US">I&#8217;m using busybox in my custom Linux pla=
tform and no sudo support. It&#8217;s a 64 bit machine.<o:p></o:p></span></=
p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 </span><b><span lang=3D"EN-US">Trail 2:</span></b><span lang=3D"EN-US" sty=
le=3D"color:#1F497D"><o:p></o:p></span></p>
<p class=3D"MsoPlainText"><b><span lang=3D"EN-US" style=3D"color:#1F497D">&=
gt; </span></b><b><span lang=3D"EN-US">=3D=3D=3D=3D=3D=3D=3D=3D<o:p></o:p><=
/span></b></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
</span><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 </span><span lang=3D"EN-US">1. Start the lttng-session from root user<o:p>=
</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 </span><span lang=3D"EN-US">2. Run the following command from &quot;tracin=
g&quot; group user<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
</span><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 </span><span lang=3D"EN-US">lttng@/ # lttng -g lttng create
<b>ks</b><o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 </span><span lang=3D"EN-US">Session ks created.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 </span><span lang=3D"EN-US">Traces will be written in /home/lttng/lttng-tr=
aces/ks-20131224-123537<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 </span><span lang=3D"EN-US">lttng@/ # lttng -g lttng enable-event -k -a<o:=
p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 </span><span lang=3D"EN-US">All kernel events are enabled in channel chann=
el0<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 </span><span lang=3D"EN-US">lttng@/ # lttng -g lttng start<o:p></o:p></spa=
n></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 </span><span lang=3D"EN-US">Tracing started for session ks<o:p></o:p></spa=
n></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 </span><span lang=3D"EN-US">lttng@/ # lttng -g lttng stop<o:p></o:p></span=
></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 </span><span lang=3D"EN-US">Waiting for data availability.<o:p></o:p></spa=
n></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 </span><span lang=3D"EN-US">Tracing stopped for session ks<o:p></o:p></spa=
n></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 [&#8230;]</span><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 </span><b><span lang=3D"EN-US">The kernel traces are generated fine<o:p></=
o:p></span></b></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&nbs=
p;&nbsp; I can&#8217;t follow you on this one since my Ubuntu system doesn&=
#8217;t allow su (not easily, anyway).&nbsp; However, I&#8217;ll just point=
 out that the lttng group option should not be used since it does not seem
 to work at all (a problem I reported on the lttng-dev mailing list back on=
 9 July 2013, and which has remained unanswered so far).<o:p></o:p></span><=
/p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&nbs=
p;&nbsp; According to the code, the lttng client checks if it belongs to th=
e &#8216;group_name&#8217; (default &#8216;tracing&#8217;) to decide which =
socket to ask for; in practice, whether a root lttng-sessiond is running
 or not, if I&#8217;m not a member of &#8216;tracing&#8217; it spawns a loc=
al lttng-sessiond whatever the specified group_name; conversely, if the roo=
t lttng-sessiond is running alone, I get to interrogate it regardless of th=
e specified group_name if I&#8217;m a member of its &#8216;tracing&#8217;
 group.&nbsp; What matters here is which group option value was used to lau=
nch lttng-sessiond.&nbsp; *That* works, forcing the root lttng-sessiond to =
accept unprivileged lttng client commands as privileged if the client is ru=
nning in that group.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&nbs=
p;&nbsp; Note that if you run a kernel and user-space trace as su, you will=
 get two lttng-consumerd daemons, both running as root: one daemon handles =
the kernel events, the other the user-space events.
 &nbsp;It&#8217;s easier to tell what is going on with the system monitor i=
f you do not issue your commands from su.&nbsp; Stay in a normal user shell=
, and use sudo as required.&nbsp; (But you have no sudo support, you say&#8=
230;This&#8217;ll be tricky because I don&#8217;t have any su support!)<o:p=
></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&nbs=
p;&nbsp; In the trails you explored, it would have been useful to know whic=
h groups your shell is a member of, and how the lttng-sessiond daemon was l=
aunched (i.e., which group it treats as the &#8216;tracing&#8217;
 group).<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 Trail 2:<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 [...]<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 lttng@/ # lttng -g lttng create as<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 Session as created.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 Traces will be written in /home/lttng/lttng-traces/as-20131224-123811<o:p>=
</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 lttng@/ # lttng -g lttng enable-event -k -u -a<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 All kernel events are enabled in channel channel0<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 lttng@/ # lttng -g lttng start<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 Tracing started for session as<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 lttng@/ # cd /tmp/<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 lttng@/tmp # ./sample<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 lttng@/tmp # lttng -g lttng stop<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 Waiting for data availability.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 Tracing stopped for session as<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 lttng@/tmp # lttng -g lttng destroy<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 Session as destroyed<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 remove config file: Permission denied<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 lttng@/tmp # cd /home/lttng/lttng-traces/<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&gt;=
 No userspace traces are generated<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&nbs=
p;&nbsp; The &#8220;remove config file: Permission denied&#8221; you get is=
 intriguing but a separate problem.&nbsp; What you did wrong here is to wri=
te:<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">lttn=
g@/ # lttng -g lttng enable-event -k -u -a<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&nbs=
p;&nbsp; thinking that this would enable both kernel and user-space events.=
&nbsp; It does not.&nbsp; The lttng client handles only one domain at a tim=
e.&nbsp; In this case, the -k option shadowed the -u option, which
 was ignored.&nbsp; If you try it again with this:<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">lttn=
g@/ # lttng -g lttng enable-event -k -a<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">lttn=
g@/ # lttng -g lttng enable-event -u -a<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&nbs=
p;&nbsp; This time you should get both kernel and user-space events in the =
trace.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&nbs=
p;&nbsp; As for trail 3, it does not capture any kernel events because it d=
id not ask to capture any.&nbsp; You only enabled user-space events.<o:p></=
o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D">&nbs=
p;&nbsp; Hope this helps.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Daniel U. Thibault<o:p></o:p=
></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Protection des syst=E8mes et=
 contremesures (PSC) | Systems Protection &amp; Countermeasures (SPC)<o:p><=
/o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Cyber s=E9curit=E9 pour les =
missions essentielles (CME) | Mission Critical Cyber Security (MCCS)<o:p></=
o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">R &amp; D pour la d=E9fense =
Canada - Valcartier (RDDC Valcartier) | Defence R&amp;D Canada - Valcartier=
 (DRDC Valcartier)<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">2459 route de la Bravoure<o:=
p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Qu=E9bec QC&nbsp; G3J 1X5<o:=
p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">CANADA<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Vox : (418) 844-4000 x4245<o=
:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Fax : (418) 844-4538<o:p></o=
:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">NAC : 918V QSDJ &lt;<a href=
=3D"--ESFSECEV-TY3011--------------------------------"><span style=3D"color=
:windowtext;text-decoration:none">http://www.travelgis.com/map.asp?addr=3D9=
18V%20QSDJ</span></a>&gt;<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Gouvernement du Canada | Gov=
ernment of Canada<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&lt;<a href=3D"--ESFSECEV-TY=
3011---------------------"><span style=3D"color:windowtext;text-decoration:=
none">http://www.valcartier.drdc-rddc.gc.ca/</span></a>&gt;<o:p></o:p></spa=
n></p>
</div>
</body>
</html>

--_000_48CF5AC71E61DB46B70D0F388054EFFD267B554AVALE02valcartie_--


--===============0962677225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0962677225==--
