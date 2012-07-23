From: Salman Rafiq <salman.rafiq@esk.fraunhofer.de>
Subject: WG: Reading CTF trace using Babeltrace API
Date: Mon, 23 Jul 2012 13:35:04 +0200
Message-ID: <E537659DE2B2C54EBD9FC9180F059880390314AC9D__612.243408295576$1343043356$gmane$org@zulu.esk.fraunhofer.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_004_E537659DE2B2C54EBD9FC9180F059880390314AC9Dzulueskfraunh_"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx-relay04-haj2.antispameurope.com ([83.246.65.204])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <salman.rafiq@esk.fraunhofer.de>) id 1StGv1-0003jt-4s
	for lttng-dev@lists.lttng.org; Mon, 23 Jul 2012 07:35:19 -0400
Content-Language: de-DE
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>, "jdesfossez@efficios.com" <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--_004_E537659DE2B2C54EBD9FC9180F059880390314AC9Dzulueskfraunh_
Content-Type: multipart/alternative;
	boundary="_000_E537659DE2B2C54EBD9FC9180F059880390314AC9Dzulueskfraunh_"

--_000_E537659DE2B2C54EBD9FC9180F059880390314AC9Dzulueskfraunh_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello All,

In continuation to my previous questions related to reading CTF traces from=
 particular timestamp, I can now further summarize few problems/questions I=
 have:


1.       Is it possible to seek CTF file_stream using 'begin' and 'end' ite=
rator position i.e. BT_SEEK_TIME?



a.       We cannot use babel trace API for CTF iterator creation using defi=
ned start and end position based on time. Seems this is in progress?

b.      The other possible solution I am using, is to create the iterator u=
sing defaults, and then later use API to 'create iterator time position bas=
ed on Raw Timestamp (only takes raw time)' and then 'set iterator position =
to that timed position'.



2.       But, since the area of interest for me was only the time when user=
 application which I am tracing using Lttng-kernel tracer, started recordin=
g events (application use external trace recording format).

User application contains a definition file which tells me the epoch time (=
us resolution) when it started and stopped tracing. I wanted to use this in=
formation to set iterator positions.



a.       Question is Can I convert this time to raw time which babeltrace A=
PI takes as an argument?

b.      Or Is there any way to read Clock struct from CTF metadata file (is=
 there any scope defined for this), so that I can extract offset variable v=
alue to convert epoch time from other trace to raw time?


It will be really great if I can get few suggestions/help related to these =
issues.
Thanking in anticipation!


Best Regards,

Salman Rafiq
Research Engineer
Industrial Communication
Fraunhofer-Einrichtung f=FCr Systeme der Kommunikationstechnik ESK

Hansastra=DFe 32 | 80686 M=FCnchen
Telefon, Fax:  +49 89 547088-356 | +49 89 547088-66-356
E-Mail:   salman.rafiq@esk.fraunhofer.de<http://www.esk.fraunhofer.de/>

Internet:
http://www.esk.fraunhofer.de<http://www.esk.fraunhofer.de/>
http://www.facebook.com/FraunhoferESK
http://www.twitter.com/FraunhoferESK

Von: Salman Rafiq [mailto:salman.rafiq@esk.fraunhofer.de]
Gesendet: Mittwoch, 18. Juli 2012 15:28
An: lttng-dev@lists.lttng.org
Betreff: [lttng-dev] Reading CTF trace from time T

Hello All,

I am tracing a user application using lttng kernel tracer, i.e.,

Start lttng kernel trace
./application
Stop lttng kernel trace

Before I was reading kernel CTF trace using babeltrace API's from beginning=
 of trace, e.g.,
struct  bt_iter_pos  begin_pos
struct bt_ctf_iter *iterator

begin_pos.type =3D BT_SEEK_BEGIN
iterator =3D create_iterator(context,  &begin_pos, NULL)
.. and then read events start from that iterator postion.

Recently, I have been trying to seek trace using timestamp from when the ap=
plication started to application end.
I would like to know if I am doing it right. Would the method below enough =
to achieve this? Or I am missing something here :-S

begin_pos.type =3D BT_SEEK_TIME
end_pos.type =3D BT_SEEK_TIME

begin_pos.u.seek_time =3D timestamp1 (for now manually taken from CTF kerne=
l trace when application started)
end_pos.u.seek_time =3D timestamp2 (for now manually taken from CTF kernel =
trace when application ended)

iterator =3D create_iterator(context,  &begin_pos, &end_pos);
and then with reading events at iterator position until end_pos.


I am using babeltrace package version "1.0.0-pre4".
Any help related to achieving this functionality will be highly appreciated=
.

Best Regards,
Salman


--
Salman Rafiq
Industrial Communication
Fraunhofer-Einrichtung f=FCr Systeme der Kommunikationstechnik ESK

Hansastra=DFe 32 | 80686 M=FCnchen
Telefon, Fax:  +49 89 547088-356 | +49 89 547088-66-356
E-Mail:   salman.rafiq@esk.fraunhofer.de<http://www.esk.fraunhofer.de/>

Internet:
http://www.esk.fraunhofer.de<http://www.esk.fraunhofer.de/>
http://www.facebook.com/FraunhoferESK
http://www.twitter.com/FraunhoferESK


--_000_E537659DE2B2C54EBD9FC9180F059880390314AC9Dzulueskfraunh_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Diso-8859-1"><meta name=3DGenerator content=3D"Micr=
osoft Word 14 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"Frutiger LT Com 45 Light";
	panose-1:2 11 3 3 3 5 4 2 2 4;}
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
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
span.E-MailFormatvorlage17
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.E-MailFormatvorlage18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 2.0cm 70.85pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:77752108;
	mso-list-type:hybrid;
	mso-list-template-ids:913207960 165296524 67567619 67567621 67567617 67567=
619 67567621 67567617 67567619 67567621;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Frutiger LT Com 45 Light","sans-serif";
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l1
	{mso-list-id:288249318;
	mso-list-type:hybrid;
	mso-list-template-ids:1475648638 67567631 67567641 67567643 67567631 67567=
641 67567643 67567631 67567641 67567643;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2
	{mso-list-id:962031591;
	mso-list-type:hybrid;
	mso-list-template-ids:-2006024976 165296524 67567619 67567621 67567617 675=
67619 67567621 67567617 67567619 67567621;}
@list l2:level1
	{mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:177.6pt;
	text-indent:-18.0pt;
	font-family:"Frutiger LT Com 45 Light","sans-serif";
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";}
@list l2:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:213.6pt;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l2:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:249.6pt;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l2:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:285.6pt;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l2:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:321.6pt;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l2:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:357.6pt;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l2:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:393.6pt;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l2:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:429.6pt;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l2:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:465.6pt;
	text-indent:-18.0pt;
	font-family:Wingdings;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DDE link=3Dblue vlink=
=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal><span style=3D'col=
or:#1F497D'>Hello All,<o:p></o:p></span></p><p class=3DMsoNormal><span styl=
e=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US style=3D'color:#1F497D'>In continuation to my previous questio=
ns related to reading CTF traces from particular timestamp, I can now furth=
er summarize few problems/questions I have:<o:p></o:p></span></p><p class=
=3DMsoNormal><span lang=3DEN-US style=3D'color:#1F497D'><o:p>&nbsp;</o:p></=
span></p><p class=3DMsoListParagraph style=3D'text-indent:-18.0pt;mso-list:=
l1 level1 lfo1'><![if !supportLists]><span lang=3DEN-US style=3D'color:#1F4=
97D'><span style=3D'mso-list:Ignore'>1.<span style=3D'font:7.0pt "Times New=
 Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><![endif=
]><span lang=3DEN-US style=3D'color:#1F497D'>Is it possible to seek CTF fil=
e_stream using &#8216;begin&#8217; and &#8216;end&#8217; iterator position =
i.e. BT_SEEK_TIME?<o:p></o:p></span></p><p class=3DMsoListParagraph><span l=
ang=3DEN-US style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p><p class=3D=
MsoListParagraph style=3D'margin-left:72.0pt;text-indent:-18.0pt;mso-list:l=
1 level2 lfo1'><![if !supportLists]><span lang=3DEN-US style=3D'color:#1F49=
7D'><span style=3D'mso-list:Ignore'>a.<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><![endif]=
><span lang=3DEN-US style=3D'color:#1F497D'>We cannot use babel trace API f=
or CTF iterator creation using defined start and end position based on time=
. Seems this is in progress?<o:p></o:p></span></p><p class=3DMsoListParagra=
ph style=3D'margin-left:72.0pt;text-indent:-18.0pt;mso-list:l1 level2 lfo1'=
><![if !supportLists]><span lang=3DEN-US style=3D'color:#1F497D'><span styl=
e=3D'mso-list:Ignore'>b.<span style=3D'font:7.0pt "Times New Roman"'>&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><span lang=3DEN-US =
style=3D'color:#1F497D'>The other possible solution I am using, is to creat=
e the iterator using defaults, and then later use API to &#8216;create iter=
ator time position based on Raw Timestamp (only takes raw time)&#8217; and =
then &#8216;set iterator position to that timed position&#8217;.<o:p></o:p>=
</span></p><p class=3DMsoListParagraph><span lang=3DEN-US style=3D'color:#1=
F497D'><o:p>&nbsp;</o:p></span></p><p class=3DMsoListParagraph style=3D'tex=
t-indent:-18.0pt;mso-list:l1 level1 lfo1'><![if !supportLists]><span lang=
=3DEN-US style=3D'color:#1F497D'><span style=3D'mso-list:Ignore'>2.<span st=
yle=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <=
/span></span></span><![endif]><span lang=3DEN-US style=3D'color:#1F497D'>Bu=
t, since the area of interest for me was only the time when user applicatio=
n which I am tracing using Lttng-kernel tracer, started recording events (a=
pplication use external trace recording format). <o:p></o:p></span></p><p c=
lass=3DMsoListParagraph><span lang=3DEN-US style=3D'color:#1F497D'>User app=
lication contains a definition file which tells me the epoch time (us resol=
ution) when it started and stopped tracing. I wanted to use this informatio=
n to set iterator positions. <o:p></o:p></span></p><p class=3DMsoListParagr=
aph><span lang=3DEN-US style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p>=
<p class=3DMsoListParagraph style=3D'margin-left:72.0pt;text-indent:-18.0pt=
;mso-list:l1 level2 lfo1'><![if !supportLists]><span lang=3DEN-US style=3D'=
color:#1F497D'><span style=3D'mso-list:Ignore'>a.<span style=3D'font:7.0pt =
"Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></spa=
n><![endif]><span lang=3DEN-US style=3D'color:#1F497D'>Question is Can I co=
nvert this time to raw time which babeltrace API takes as an argument? <o:p=
></o:p></span></p><p class=3DMsoListParagraph style=3D'margin-left:72.0pt;t=
ext-indent:-18.0pt;mso-list:l1 level2 lfo1'><![if !supportLists]><span lang=
=3DEN-US style=3D'color:#1F497D'><span style=3D'mso-list:Ignore'>b.<span st=
yle=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>=
</span></span><![endif]><span lang=3DEN-US style=3D'color:#1F497D'>Or Is th=
ere any way to read Clock struct from CTF metadata file (is there any scope=
 defined for this), so that I can extract offset variable value to convert =
epoch time from other trace to raw time?<o:p></o:p></span></p><p class=3DMs=
oNormal><span lang=3DEN-US style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span>=
</p><div><p class=3DMsoNormal style=3D'margin-left:70.8pt'><span lang=3DEN-=
US style=3D'font-family:"Frutiger LT Com 45 Light","sans-serif";color:#1F49=
7D;mso-fareast-language:DE'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNorma=
l><span lang=3DEN-US style=3D'font-family:"Frutiger LT Com 45 Light","sans-=
serif";color:#1F497D;mso-fareast-language:DE'>It will be really great if I =
can get few suggestions/help related to these issues.<o:p></o:p></span></p>=
<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"Frutiger LT C=
om 45 Light","sans-serif";color:#1F497D;mso-fareast-language:DE'>Thanking i=
n anticipation!<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-U=
S style=3D'font-family:"Frutiger LT Com 45 Light","sans-serif";color:#1F497=
D;mso-fareast-language:DE'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal=
><span lang=3DEN-US style=3D'font-family:"Frutiger LT Com 45 Light","sans-s=
erif";color:#1F497D;mso-fareast-language:DE'><o:p>&nbsp;</o:p></span></p><p=
 class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"Frutiger LT Com=
 45 Light","sans-serif";color:#1F497D;mso-fareast-language:DE'>Best Regards=
,<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'fon=
t-family:"Frutiger LT Com 45 Light","sans-serif";color:#1F497D;mso-fareast-=
language:DE'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3D=
EN-US style=3D'font-family:"Frutiger LT Com 45 Light","sans-serif";color:#1=
F497D;mso-fareast-language:DE'>Salman Rafiq<o:p></o:p></span></p><p class=
=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"Frutiger LT Com 45 Li=
ght","sans-serif";color:#1F497D;mso-fareast-language:DE'>Research Engineer<=
o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'font-family:"Fruti=
ger LT Com 45 Light","sans-serif";color:#1F497D;mso-fareast-language:DE'>In=
dustrial Communication<o:p></o:p></span></p><p class=3DMsoNormal><span styl=
e=3D'font-family:"Frutiger LT Com 45 Light","sans-serif";color:#1F497D;mso-=
fareast-language:DE'>Fraunhofer-Einrichtung f=FCr Systeme der Kommunikation=
stechnik ESK<o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'font-=
family:"Frutiger LT Com 45 Light","sans-serif";color:#1F497D;mso-fareast-la=
nguage:DE'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span style=3D'=
font-size:9.0pt;font-family:"Frutiger LT Com 45 Light","sans-serif";color:#=
1F497D;mso-fareast-language:DE'>Hansastra=DFe 32 | 80686 M=FCnchen<o:p></o:=
p></span></p><p class=3DMsoNormal><span style=3D'font-size:9.0pt;font-famil=
y:"Frutiger LT Com 45 Light","sans-serif";color:#1F497D;mso-fareast-languag=
e:DE'>Telefon, Fax:&nbsp; +49 89 547088-356 | +49 89 547088-66-356<o:p></o:=
p></span></p><p class=3DMsoNormal><span style=3D'font-size:9.0pt;font-famil=
y:"Frutiger LT Com 45 Light","sans-serif";color:#1F497D;mso-fareast-languag=
e:DE'>E-Mail:&nbsp;&nbsp; </span><span style=3D'font-size:9.0pt;font-family=
:"Frutiger LT Com 45 Light","sans-serif";color:black;mso-fareast-language:D=
E'><a href=3D"http://www.esk.fraunhofer.de/">salman.rafiq@esk.fraunhofer.de=
</a></span><span style=3D'font-size:9.0pt;font-family:"Frutiger LT Com 45 L=
ight","sans-serif";color:#1F497D;mso-fareast-language:DE'><o:p></o:p></span=
></p><p class=3DMsoNormal><span style=3D'font-size:9.0pt;font-family:"Fruti=
ger LT Com 45 Light","sans-serif";color:#1F497D;mso-fareast-language:DE'>&n=
bsp; <o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'font-size:9.=
0pt;font-family:"Frutiger LT Com 45 Light","sans-serif";color:#1F497D;mso-f=
areast-language:DE'>Internet: <o:p></o:p></span></p><p class=3DMsoNormal><s=
pan style=3D'font-size:9.0pt;font-family:"Frutiger LT Com 45 Light","sans-s=
erif";color:black;mso-fareast-language:DE'><a href=3D"http://www.esk.fraunh=
ofer.de/">http://www.esk.fraunhofer.de</a></span><span style=3D'font-size:9=
.0pt;font-family:"Frutiger LT Com 45 Light","sans-serif";color:#1F497D;mso-=
fareast-language:DE'><o:p></o:p></span></p><p class=3DMsoNormal><span style=
=3D'font-size:9.0pt;font-family:"Frutiger LT Com 45 Light","sans-serif";col=
or:black;mso-fareast-language:DE'><a href=3D"http://www.facebook.com/Fraunh=
oferESK">http://www.facebook.com/FraunhoferESK</a><br><a href=3D"http://www=
.twitter.com/FraunhoferESK">http://www.twitter.com/FraunhoferESK</a></span>=
<span style=3D'font-size:9.0pt;color:#1F497D;mso-fareast-language:DE'><o:p>=
</o:p></span></p></div><p class=3DMsoNormal><span style=3D'color:#1F497D'><=
o:p>&nbsp;</o:p></span></p><div><div style=3D'border:none;border-top:solid =
#B5C4DF 1.0pt;padding:3.0pt 0cm 0cm 0cm'><p class=3DMsoNormal><b><span styl=
e=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif";mso-fareast-languag=
e:DE'>Von:</span></b><span style=3D'font-size:10.0pt;font-family:"Tahoma","=
sans-serif";mso-fareast-language:DE'> Salman Rafiq [mailto:salman.rafiq@esk=
.fraunhofer.de] <br><b>Gesendet:</b> Mittwoch, 18. Juli 2012 15:28<br><b>An=
:</b> lttng-dev@lists.lttng.org<br><b>Betreff:</b> [lttng-dev] Reading CTF =
trace from time T<o:p></o:p></span></p></div></div><p class=3DMsoNormal><o:=
p>&nbsp;</o:p></p><p class=3DMsoNormal>Hello All,<o:p></o:p></p><p class=3D=
MsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal><span lang=3DEN-US>I am=
 tracing a user application using lttng kernel tracer, i.e.,<o:p></o:p></sp=
an></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>=
<p class=3DMsoNormal><span lang=3DEN-US>Start lttng kernel trace<o:p></o:p>=
</span></p><p class=3DMsoNormal><span lang=3DEN-US>./application<o:p></o:p>=
</span></p><p class=3DMsoNormal><span lang=3DEN-US>Stop lttng kernel trace =
<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</=
o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>Before I was reading=
 kernel CTF trace using babeltrace API&#8217;s from beginning of trace, e.g=
., &nbsp;<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>stru=
ct &nbsp;bt_iter_pos&nbsp; begin_pos<o:p></o:p></span></p><p class=3DMsoNor=
mal><span lang=3DEN-US>struct bt_ctf_iter *iterator<o:p></o:p></span></p><p=
 class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=
=3DMsoNormal><span lang=3DEN-US>begin_pos.type =3D BT_SEEK_BEGIN<o:p></o:p>=
</span></p><p class=3DMsoNormal><span lang=3DEN-US>iterator =3D create_iter=
ator(context, &nbsp;&amp;begin_pos, NULL)<o:p></o:p></span></p><p class=3DM=
soNormal><span lang=3DEN-US>.. and then read events start from that iterato=
r postion.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US><o:=
p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>Recently, =
I have been trying to seek trace using timestamp from when the application =
started to application end.<o:p></o:p></span></p><p class=3DMsoNormal><span=
 lang=3DEN-US>I would like to know if I am doing it right. Would the method=
 below enough to achieve this? Or I am missing something here :-S<o:p></o:p=
></span></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span=
></p><p class=3DMsoNormal><span lang=3DEN-US>begin_pos.type =3D BT_SEEK_TIM=
E<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>end_pos.type=
 =3D BT_SEEK_TIME<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN=
-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>beg=
in_pos.u.seek_time =3D timestamp1 (for now manually taken from CTF kernel t=
race when application started) <o:p></o:p></span></p><p class=3DMsoNormal><=
span lang=3DEN-US>end_pos.u.seek_time =3D timestamp2 (for now manually take=
n from CTF kernel trace when application ended)<o:p></o:p></span></p><p cla=
ss=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMs=
oNormal><span lang=3DEN-US>iterator =3D create_iterator(context, &nbsp;&amp=
;begin_pos, &amp;end_pos); &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></span></p><p c=
lass=3DMsoNormal><span lang=3DEN-US>and then with reading events at iterato=
r position until end_pos.<o:p></o:p></span></p><p class=3DMsoNormal><span l=
ang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DE=
N-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>I =
am using babeltrace package version &#8220;1.0.0-pre4&#8221;.<o:p></o:p></s=
pan></p><p class=3DMsoNormal><span lang=3DEN-US>Any help related to achievi=
ng this functionality will be highly appreciated.<o:p></o:p></span></p><p c=
lass=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3D=
MsoNormal><span lang=3DEN-US>Best Regards,<o:p></o:p></span></p><p class=3D=
MsoNormal><span lang=3DEN-US>Salman<o:p></o:p></span></p><p class=3DMsoNorm=
al><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><spa=
n lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=
=3DEN-US style=3D'font-family:"Frutiger LT Com 45 Light","sans-serif";color=
:#1F497D;mso-fareast-language:DE'>--<o:p></o:p></span></p><p class=3DMsoNor=
mal><span lang=3DEN-US style=3D'font-family:"Frutiger LT Com 45 Light","san=
s-serif";color:#1F497D;mso-fareast-language:DE'>Salman Rafiq<o:p></o:p></sp=
an></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"Frutig=
er LT Com 45 Light","sans-serif";color:#1F497D;mso-fareast-language:DE'>Ind=
ustrial Communication<o:p></o:p></span></p><p class=3DMsoNormal><span lang=
=3DEN-US style=3D'font-family:"Frutiger LT Com 45 Light","sans-serif";color=
:#1F497D;mso-fareast-language:DE'>Fraunhofer-Einrichtung f=FC</span><span s=
tyle=3D'font-family:"Frutiger LT Com 45 Light","sans-serif";color:#1F497D;m=
so-fareast-language:DE'>r Systeme der Kommunikationstechnik ESK<o:p></o:p><=
/span></p><p class=3DMsoNormal><span style=3D'font-family:"Frutiger LT Com =
45 Light","sans-serif";color:#1F497D;mso-fareast-language:DE'><o:p>&nbsp;</=
o:p></span></p><p class=3DMsoNormal><span style=3D'font-size:9.0pt;font-fam=
ily:"Frutiger LT Com 45 Light","sans-serif";color:#1F497D;mso-fareast-langu=
age:DE'>Hansastra=DFe 32 | 80686 M=FCnchen<o:p></o:p></span></p><p class=3D=
MsoNormal><span style=3D'font-size:9.0pt;font-family:"Frutiger LT Com 45 Li=
ght","sans-serif";color:#1F497D;mso-fareast-language:DE'>Telefon, Fax:&nbsp=
; +49 89 547088-356 | +49 89 547088-66-356<o:p></o:p></span></p><p class=3D=
MsoNormal><span style=3D'font-size:9.0pt;font-family:"Frutiger LT Com 45 Li=
ght","sans-serif";color:#1F497D;mso-fareast-language:DE'>E-Mail:&nbsp;&nbsp=
; </span><span style=3D'font-size:9.0pt;font-family:"Frutiger LT Com 45 Lig=
ht","sans-serif";color:black;mso-fareast-language:DE'><a href=3D"http://www=
.esk.fraunhofer.de/">salman.rafiq@esk.fraunhofer.de</a></span><span style=
=3D'font-size:9.0pt;font-family:"Frutiger LT Com 45 Light","sans-serif";col=
or:#1F497D;mso-fareast-language:DE'><o:p></o:p></span></p><p class=3DMsoNor=
mal><span style=3D'font-size:9.0pt;font-family:"Frutiger LT Com 45 Light","=
sans-serif";color:#1F497D;mso-fareast-language:DE'>&nbsp; <o:p></o:p></span=
></p><p class=3DMsoNormal><span style=3D'font-size:9.0pt;font-family:"Fruti=
ger LT Com 45 Light","sans-serif";color:#1F497D;mso-fareast-language:DE'>In=
ternet: <o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'font-size=
:9.0pt;font-family:"Frutiger LT Com 45 Light","sans-serif";color:black;mso-=
fareast-language:DE'><a href=3D"http://www.esk.fraunhofer.de/">http://www.e=
sk.fraunhofer.de</a></span><span style=3D'font-size:9.0pt;font-family:"Frut=
iger LT Com 45 Light","sans-serif";color:#1F497D;mso-fareast-language:DE'><=
o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'font-size:9.0pt;fo=
nt-family:"Frutiger LT Com 45 Light","sans-serif";color:black;mso-fareast-l=
anguage:DE'><a href=3D"http://www.facebook.com/FraunhoferESK">http://www.fa=
cebook.com/FraunhoferESK</a><br><a href=3D"http://www.twitter.com/Fraunhofe=
rESK">http://www.twitter.com/FraunhoferESK</a></span><span style=3D'font-si=
ze:9.0pt;color:#1F497D;mso-fareast-language:DE'><o:p></o:p></span></p><p cl=
ass=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>=

--_000_E537659DE2B2C54EBD9FC9180F059880390314AC9Dzulueskfraunh_--

--_004_E537659DE2B2C54EBD9FC9180F059880390314AC9Dzulueskfraunh_
Content-Type: text/plain; name="ATT00001.txt"
Content-Description: ATT00001.txt
Content-Disposition: attachment; filename="ATT00001.txt"; size=159;
	creation-date="Wed, 18 Jul 2012 13:28:59 GMT";
	modification-date="Wed, 18 Jul 2012 13:28:59 GMT"
Content-Transfer-Encoding: base64

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCmx0dG5nLWRl
diBtYWlsaW5nIGxpc3QNCmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcNCmh0dHA6Ly9saXN0cy5s
dHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldg0K

--_004_E537659DE2B2C54EBD9FC9180F059880390314AC9Dzulueskfraunh_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--_004_E537659DE2B2C54EBD9FC9180F059880390314AC9Dzulueskfraunh_--
