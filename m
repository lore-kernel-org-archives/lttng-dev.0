From: Salman Rafiq <salman.rafiq@esk.fraunhofer.de>
Subject: Reading CTF trace from time T
Date: Wed, 18 Jul 2012 15:27:58 +0200
Message-ID: <E537659DE2B2C54EBD9FC9180F059880390314A7BF__3279.14599697596$1342618130$gmane$org@zulu.esk.fraunhofer.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1430072114=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx-relay03-haj2.antispameurope.com ([83.246.65.203])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <salman.rafiq@esk.fraunhofer.de>) id 1SrUIX-0001SM-2k
	for lttng-dev@lists.lttng.org; Wed, 18 Jul 2012 09:28:13 -0400
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
List-Id: lttng-dev@lists.lttng.org

--===============1430072114==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_E537659DE2B2C54EBD9FC9180F059880390314A7BFzulueskfraunh_"

--_000_E537659DE2B2C54EBD9FC9180F059880390314A7BFzulueskfraunh_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

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


--_000_E537659DE2B2C54EBD9FC9180F059880390314A7BFzulueskfraunh_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
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
span.E-MailFormatvorlage17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";
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
</o:shapelayout></xml><![endif]--></head><body lang=3DDE link=3Dblue vlink=
=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal>Hello All,<o:p></o=
:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal><span=
 lang=3DEN-US>I am tracing a user application using lttng kernel tracer, i.=
e.,<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp=
;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>Start lttng kerne=
l trace<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>./appl=
ication<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>Stop l=
ttng kernel trace <o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DE=
N-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>Be=
fore I was reading kernel CTF trace using babeltrace API&#8217;s from begin=
ning of trace, e.g., =A0<o:p></o:p></span></p><p class=3DMsoNormal><span la=
ng=3DEN-US>struct =A0bt_iter_pos=A0 begin_pos<o:p></o:p></span></p><p class=
=3DMsoNormal><span lang=3DEN-US>struct bt_ctf_iter *iterator<o:p></o:p></sp=
an></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>=
<p class=3DMsoNormal><span lang=3DEN-US>begin_pos.type =3D BT_SEEK_BEGIN<o:=
p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>iterator =3D cre=
ate_iterator(context, =A0&amp;begin_pos, NULL)<o:p></o:p></span></p><p clas=
s=3DMsoNormal><span lang=3DEN-US>.. and then read events start from that it=
erator postion.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-U=
S><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>Recen=
tly, I have been trying to seek trace using timestamp from when the applica=
tion started to application end.<o:p></o:p></span></p><p class=3DMsoNormal>=
<span lang=3DEN-US>I would like to know if I am doing it right. Would the m=
ethod below enough to achieve this? Or I am missing something here :-S<o:p>=
</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p><=
/span></p><p class=3DMsoNormal><span lang=3DEN-US>begin_pos.type =3D BT_SEE=
K_TIME<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>end_pos=
.type =3D BT_SEEK_TIME<o:p></o:p></span></p><p class=3DMsoNormal><span lang=
=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-U=
S>begin_pos.u.seek_time =3D timestamp1 (for now manually taken from CTF ker=
nel trace when application started) <o:p></o:p></span></p><p class=3DMsoNor=
mal><span lang=3DEN-US>end_pos.u.seek_time =3D timestamp2 (for now manually=
 taken from CTF kernel trace when application ended)<o:p></o:p></span></p><=
p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=
=3DMsoNormal><span lang=3DEN-US>iterator =3D create_iterator(context, =A0&a=
mp;begin_pos, &amp;end_pos); =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 <o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>and then =
with reading events at iterator position until end_pos.<o:p></o:p></span></=
p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p cl=
ass=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DM=
soNormal><span lang=3DEN-US>I am using babeltrace package version &#8220;1.=
0.0-pre4&#8221;.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-=
US>Any help related to achieving this functionality will be highly apprecia=
ted.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbs=
p;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>Best Regards,<o:=
p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>Salman<o:p></o:p=
></span></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span=
></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p=
 class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"Frutiger LT Com=
 45 Light","sans-serif";color:#1F497D;mso-fareast-language:DE'>--<o:p></o:p=
></span></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"F=
rutiger LT Com 45 Light","sans-serif";color:#1F497D;mso-fareast-language:DE=
'>Salman Rafiq<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US=
 style=3D'font-family:"Frutiger LT Com 45 Light","sans-serif";color:#1F497D=
;mso-fareast-language:DE'>Industrial Communication<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"Frutiger LT Com =
45 Light","sans-serif";color:#1F497D;mso-fareast-language:DE'>Fraunhofer-Ei=
nrichtung f=FC</span><span style=3D'font-family:"Frutiger LT Com 45 Light",=
"sans-serif";color:#1F497D;mso-fareast-language:DE'>r Systeme der Kommunika=
tionstechnik ESK<o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'f=
ont-family:"Frutiger LT Com 45 Light","sans-serif";color:#1F497D;mso-fareas=
t-language:DE'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span style=
=3D'font-size:9.0pt;font-family:"Frutiger LT Com 45 Light","sans-serif";col=
or:#1F497D;mso-fareast-language:DE'>Hansastra=DFe 32 | 80686 M=FCnchen<o:p>=
</o:p></span></p><p class=3DMsoNormal><span style=3D'font-size:9.0pt;font-f=
amily:"Frutiger LT Com 45 Light","sans-serif";color:#1F497D;mso-fareast-lan=
guage:DE'>Telefon, Fax:&nbsp; +49 89 547088-356 | +49 89 547088-66-356<o:p>=
</o:p></span></p><p class=3DMsoNormal><span style=3D'font-size:9.0pt;font-f=
amily:"Frutiger LT Com 45 Light","sans-serif";color:#1F497D;mso-fareast-lan=
guage:DE'>E-Mail:&nbsp;&nbsp; </span><span style=3D'font-size:9.0pt;font-fa=
mily:"Frutiger LT Com 45 Light","sans-serif";color:black;mso-fareast-langua=
ge:DE'><a href=3D"http://www.esk.fraunhofer.de/"><span style=3D'color:blue'=
>salman.rafiq@esk.fraunhofer.de</span></a></span><span style=3D'font-size:9=
.0pt;font-family:"Frutiger LT Com 45 Light","sans-serif";color:#1F497D;mso-=
fareast-language:DE'><o:p></o:p></span></p><p class=3DMsoNormal><span style=
=3D'font-size:9.0pt;font-family:"Frutiger LT Com 45 Light","sans-serif";col=
or:#1F497D;mso-fareast-language:DE'>&nbsp; <o:p></o:p></span></p><p class=
=3DMsoNormal><span style=3D'font-size:9.0pt;font-family:"Frutiger LT Com 45=
 Light","sans-serif";color:#1F497D;mso-fareast-language:DE'>Internet: <o:p>=
</o:p></span></p><p class=3DMsoNormal><span style=3D'font-size:9.0pt;font-f=
amily:"Frutiger LT Com 45 Light","sans-serif";color:black;mso-fareast-langu=
age:DE'><a href=3D"http://www.esk.fraunhofer.de/"><span style=3D'color:blue=
'>http://www.esk.fraunhofer.de</span></a></span><span style=3D'font-size:9.=
0pt;font-family:"Frutiger LT Com 45 Light","sans-serif";color:#1F497D;mso-f=
areast-language:DE'><o:p></o:p></span></p><p class=3DMsoNormal><span style=
=3D'font-size:9.0pt;font-family:"Frutiger LT Com 45 Light","sans-serif";col=
or:black;mso-fareast-language:DE'><a href=3D"http://www.facebook.com/Fraunh=
oferESK"><span style=3D'color:blue'>http://www.facebook.com/FraunhoferESK</=
span></a><br><a href=3D"http://www.twitter.com/FraunhoferESK"><span style=
=3D'color:blue'>http://www.twitter.com/FraunhoferESK</span></a></span><span=
 style=3D'font-size:9.0pt;color:#1F497D;mso-fareast-language:DE'><o:p></o:p=
></span></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>=

--_000_E537659DE2B2C54EBD9FC9180F059880390314A7BFzulueskfraunh_--


--===============1430072114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1430072114==--
