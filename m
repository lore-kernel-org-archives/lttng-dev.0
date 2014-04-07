From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: instrumenting shared library
Date: Mon, 7 Apr 2014 15:27:11 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD35993708__45897.1843625934$1396884504$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD35992F74@VAL-E-02.valcartier.drdc-rddc.gc.ca><CAM5kDqy62zjzLddVkRvg94jAxSCSN0uFqxmJL7RwN6XN31x0Jw@mail.gmail.com><48CF5AC71E61DB46B70D0F388054EFFD3599315B@VAL-E-02.valcartier.drdc-rddc.gc.ca><CAM5kDqyCTjKLWhR5XXT9DvXHaniOnJy0SPSDOMPw3eCSD7Z6Uw@mail.gmail.com><CACFGcbbmW0mc3GHa9VYBQLiS6zrm1gQB8bkYMBFadnvM7QKeeQ@mail.gmail.com><CAM5kDqySXuNqYcdjy+kgs-h5cDdiQSioumUX449Gfrcgg+HUbw@mail.gmail.com><48CF5AC71E61DB46B70D0F388054EFFD35993659@VAL-E-02.valcartier.drdc-rddc.gc.ca>
 <CAM5kDqykNCO_XVjg8bOzDLTZ06Cja2UwdS4ZkHLpJrs9GR_sqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0959910253=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WXBS9-0000Nw-4d
 for lttng-dev@lists.lttng.org; Mon, 07 Apr 2014 11:27:23 -0400
In-Reply-To: <CAM5kDqykNCO_XVjg8bOzDLTZ06Cja2UwdS4ZkHLpJrs9GR_sqw@mail.gmail.com>
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

--===============0959910253==
Content-Language: fr-FR
Content-Type: multipart/alternative;
	boundary="_000_48CF5AC71E61DB46B70D0F388054EFFD35993708VALE02valcartie_"

--_000_48CF5AC71E61DB46B70D0F388054EFFD35993708VALE02valcartie_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

De : Anand Neeli [mailto:anand.neeli@gmail.com]
Envoy=E9 : 7 avril 2014 10:37

> - It doesn't matter if the tracepoints are static or dynamically loaded w=
ith the app. Once there is a change in tracepoints the app should be reload=
ed (even though not compiled). Even though the tracepoints can be shared, b=
ut changing tracepoints we would need to restart all the app's which share =
the tracepoints.
(Just trying to make a statement on pros and cons here)

   Not quite true.  If the tracepoints are statically included in the app, =
then the app must be recompiled and relinked whenever the tracepoints chang=
e.  Example:

static: static.o tp.o
            @echo "~~~~~~Linking sample_$@:"
            $(CC) -o sample_$@ $^ $(LDFLAGS) $(LIBDL) $(LIBUST)
            @echo "   Use './sample_$@' to run sample_$@"

static.o: sample.c tp.h
            @echo "~~~~~~Compiling $@:"
            $(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(TP_DEFINE) -c -o $@ $<

tp.o: tp.c tp.h
            @echo "~~~~~~Compiling $@:"
            $(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) -c -o $@ $<

   Every time you change tp.h, you must recompile tp.o and static.o and rel=
ink both into a new sample_static executable image.  If you keep the tracep=
oint() signatures unchanged, then you may get away with not recompiling sta=
tic.o-but you must still relink.

   At the other extreme, if the app explicitly loads the tracepoint provide=
r using dlopen, then one could conceivably send a message to all apps to dl=
close the tracepoint provider shared object and dlopen a replacement one (i=
f such an API has been programmed in).  The apps wouldn't need to stop runn=
ing at all.  Of course this supposes the tracepoint() signatures do not cha=
nge.  (To avoid confusing babeltrace, the traces must be collected using th=
e buffers-pid channel option and the changeover must not occur within the s=
ame one-second time window)

> - * Does static or dynamic inclusion make difference(in terms of performa=
nce) if someone always want to run in tracing mode??

   The difference will be slight: using a dynamic link, the linker must do =
a little extra work when loading the tracepoint provider shared object alon=
g with the application's binary image, just because it needs to find it els=
ewhere. So you can expect app startup to be a little longer the first time.=
 If the app is using a tracepoint provider shared object which happens to b=
e already used by other running apps, the startup time actually becomes sho=
rter because the tracepoint provider shared object is already in memory.

   Once the app is running, there should be no difference at all in perform=
ance.

> Now let me put some light on how someone would like to use lttngin huge c=
odebases. (this is my personal opinion)
> - Normally tracepoints are made per component/daemon. And not shared acro=
ss daemons/components.
> - Tracing should always be running. It should never be switched off. (unl=
ess the application is not mission critical)
> - I'm planning to always run memory(snapshot) tracing with some fixed siz=
e buffer, which can capture last n-events or n-bytes
> - Above memory tracing users can create another tracing session and dump =
traces to files if needed.(with their own filters and context in enable-eve=
nt)

   Sounds like a plan!

> Thanks again for spending your time on these queries.
> -Anand Neeli
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
NAC : 918V QSDJ<--ESFSECEV-TY3011--------------------------------> <http://=
www.travelgis.com/map.asp?addr=3D918V%20QSDJ<--ESFSECEV-TY3011-------------=
------------------->>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/<--ESFSECEV-TY3011------------------=
--->>

--_000_48CF5AC71E61DB46B70D0F388054EFFD35993708VALE02valcartie_
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
,&quot;sans-serif&quot;"> Anand Neeli [mailto:anand.neeli@gmail.com]
<br>
<b>Envoy=E9&nbsp;:</b> 7 avril 2014 10:37<br>
<br>
<o:p></o:p></span></p>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&gt; </=
span><span lang=3D"EN-CA">- It does<span style=3D"color:#1F497D">n&#8217;</=
span>t matter if the tracepoints are static or dynamically loaded with the =
app.
</span>Once there is a change in tracepoints the app should be reloaded (ev=
en though not compiled). Even though the tracepoints can be shared, but cha=
nging tracepoints we would need to restart all the app's which share the tr=
acepoints.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">(Just trying to make a statemen=
t on pros and cons here)<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&=
nbsp; Not quite true.&nbsp; If the tracepoints are statically included in t=
he app, then the app must be recompiled and relinked whenever the tracepoin=
ts change.&nbsp; Example:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">static:=
 static.o tp.o<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @echo &quot;~~~=
~~~Linking sample_$@:&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(CC) -o sample=
_$@ $^ $(LDFLAGS) $(LIBDL) $(LIBUST)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @echo &quot;&nb=
sp;&nbsp; Use './sample_$@' to run sample_$@&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">static.=
o: sample.c tp.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @echo &quot;~~~=
~~~Compiling $@:&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(CC) $(CPPFLAG=
S) $(LOCAL_CPPFLAGS) $(TP_DEFINE) -c -o $@ $&lt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">tp.o: t=
p.c tp.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @echo &quot;~~~=
~~~Compiling $@:&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(CC) $(CPPFLAG=
S) $(LOCAL_CPPFLAGS) -c -o $@ $&lt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&=
nbsp; Every time you change tp.h, you must recompile tp.o and static.o and =
relink both into a new sample_static executable image.&nbsp; If you keep th=
e tracepoint() signatures unchanged, then you may get
 away with not recompiling static.o&#8212;but you must still relink.<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&=
nbsp; At the other extreme, if the app explicitly loads the tracepoint prov=
ider using dlopen, then one could conceivably send a message to all apps to=
 dlclose the tracepoint provider shared object and
 dlopen a replacement one (if such an API has been programmed in).&nbsp; Th=
e apps wouldn&#8217;t need to stop running at all.&nbsp; Of course this sup=
poses the tracepoint() signatures do not change.&nbsp; (To avoid confusing =
babeltrace, the traces must be collected using the buffers-pid
 channel option and the changeover must not occur within the same one-secon=
d time window)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp=
;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&gt; </=
span><span lang=3D"EN-CA">- * Does static or dynamic inclusion make differe=
nce(in terms of performance) if someone always want to run in tracing mode?=
?<span style=3D"color:#1F497D"><o:p></o:p></span></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">&nbsp;&nbs=
p; The difference will be slight: using a dynamic link, the linker must do =
a little extra work when loading the tracepoint provider shared object
 along with the application&#8217;s binary image, just because it needs to =
find it elsewhere. So you can expect app startup to be a little longer
<i>the first time</i>. If the app is using a tracepoint provider shared obj=
ect which happens to be already used by other running apps, the startup tim=
e actually becomes
<i>shorter</i> because the tracepoint provider shared object is already in =
memory.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">&nbsp;&nbs=
p; Once the app is running, there should be no difference at all in perform=
ance.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><o:p>&nbsp;</o:p></span></p>
</div>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&gt; </=
span><span lang=3D"EN-CA">Now let me put some light on how someone would li=
ke to use lttngin huge codebases.
</span>(this is my personal opinion)<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&gt; </=
span><span lang=3D"EN-CA">- Normally tracepoints are made per component/dae=
mon.
</span>And not shared across daemons/components.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&gt; </=
span><span lang=3D"EN-CA">- Tracing should always be running.
</span>It should never be switched off. (unless the application is not miss=
ion critical)<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&gt; </=
span><span lang=3D"EN-CA">- I'm planning to always run memory(snapshot) tra=
cing with some fixed size buffer, which can capture last n-events or n-byte=
s<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&gt; </=
span><span lang=3D"EN-CA">- Above memory tracing users can create another t=
racing session and dump traces to files if needed.(with their own filters a=
nd context in enable-event)<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">&nbsp;&nbs=
p; Sounds like a plan!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp=
;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&gt; </=
span><span lang=3D"EN-CA">Thanks again for spending your time on these quer=
ies.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&gt; </span>-Anand Nee=
li<o:p></o:p></p>
</div>
</div>
<div>
<div>
<div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"font-size:11.0pt;font-family:Consolas;color:#1F497D=
">Daniel U. Thibault<br>
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
D">&nbsp;</span><span style=3D"font-size:11.0pt;font-family:Consolas;color:=
#1F497D">: (418) 844-4000 x4245<br>
Fax</span><span style=3D"font-size:10.5pt;font-family:Consolas;color:#1F497=
D">&nbsp;</span><span style=3D"font-size:11.0pt;font-family:Consolas;color:=
#1F497D">: (418) 844-4538<br>
NAC&nbsp;: </span><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-famil=
y:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><a href=3D"--ES=
FSECEV-TY3011--------------------------------" target=3D"_blank"><span lang=
=3D"FR-CA" style=3D"font-size:10.0pt;font-family:&quot;Courier New&quot;">9=
18V
 QSDJ</span></a></span><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">
</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;;color:#1F497D">&lt;</span><u><span style=3D"font-size:10=
.0pt;font-family:&quot;Courier New&quot;;color:blue"><a href=3D"--ESFSECEV-=
TY3011--------------------------------" target=3D"_blank">http://www.travel=
gis.com/map.asp?addr=3D918V%20QSDJ</a></span></u><span style=3D"font-size:1=
1.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"=
>&gt;<br>
</span><span style=3D"font-size:11.0pt;font-family:Consolas;color:#1F497D">=
Gouvernement du Canada&nbsp;| Government of Canada<br>
</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;;color:#1F497D">&lt;</span><span lang=3D"EN-CA" style=3D"=
font-size:10.0pt;font-family:&quot;Courier New&quot;;color:blue"><a href=3D=
"--ESFSECEV-TY3011---------------------" target=3D"_blank"><span lang=3D"FR=
-CA">http://www.valcartier.drdc-rddc.gc.ca/</span></a></span><span style=3D=
"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:#1F497D">&gt;</span><span style=3D"color:#1F497D"><o:p></o:p></span></p=
>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_48CF5AC71E61DB46B70D0F388054EFFD35993708VALE02valcartie_--


--===============0959910253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0959910253==--
