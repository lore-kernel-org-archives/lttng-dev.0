From: BADEUIL Thierry <thierry.badeuil@thalesgroup.com>
Subject: Trace Compass in live session
Date: Tue, 12 Jun 2018 18:29:22 +0200
Message-ID: <2588C50AE11CCC4B945875227E501190021891E993A3__25295.9077166908$1528820851$gmane$org@THSONEA01CMS04P.one.grp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1284112775011633588=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from thsbbfxrt01p.thalesgroup.com (thsbbfxrt01p.thalesgroup.com
 [192.54.144.131])
 by lists.lttng.org (Postfix) with ESMTPS id 414wMB6LCTz18NY
 for <lttng-dev@lists.lttng.org>; Tue, 12 Jun 2018 12:29:26 -0400 (EDT)
Received: from thsbbfxrt01p.thalesgroup.com (localhost [127.0.0.1])
 by localhost (Postfix) with SMTP id 414wM93k7Qz5Db
 for <lttng-dev@lists.lttng.org>; Tue, 12 Jun 2018 18:29:25 +0200 (CEST)
Content-Language: fr-FR
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1284112775011633588==
Content-Language: fr-FR
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_00A1_01D4027B.46ED5960"

------=_NextPart_000_00A1_01D4027B.46ED5960
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_00A2_01D4027B.46ED5960"


------=_NextPart_001_00A2_01D4027B.46ED5960
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear all,

=20

I have difficulties to use Babeltrace in live session and I would like =
to
use Trace Compass.

=20

My target activated LTTng with :

-          Lttng create test =96live =
=96set-url:=92net://192.168.0.1:5342:5343=92

-          Lttng enable-event sched_switch

-          Lttng start

=20

My host (@192.168.0.1) activated LTTng with :

-          Lttng-relayd =96vv

=20

Everything seems to be OK because my host received bytes from my target
during 1 minute.

=20

I would like to see the traces in ~/lttng-traces with TraceCompass and I =
can
only watch the first second of my recording. It is impossible to see =
after
(I did a lot of refresh=85).

=20

Why ?

=20

Regards

=20

=20

Thierry BADEUIL

THALES COMMUNICATIONS

( : +33 1 46 133 591

=C8  : +33 6 85 51 28 16

* :  <mailto:thierry.badeuil@fr.thalesgroup.com>
thierry.badeuil@thalesgroup.com

=20


------=_NextPart_001_00A2_01D4027B.46ED5960
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" =
xmlns:p=3D"urn:schemas-microsoft-com:office:powerpoint" =
xmlns:a=3D"urn:schemas-microsoft-com:office:access" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" =
xmlns:s=3D"uuid:BDC6E3F0-6DA3-11d1-A2A3-00AA00C14882" =
xmlns:rs=3D"urn:schemas-microsoft-com:rowset" xmlns:z=3D"#RowsetSchema" =
xmlns:b=3D"urn:schemas-microsoft-com:office:publisher" =
xmlns:ss=3D"urn:schemas-microsoft-com:office:spreadsheet" =
xmlns:c=3D"urn:schemas-microsoft-com:office:component:spreadsheet" =
xmlns:odc=3D"urn:schemas-microsoft-com:office:odc" =
xmlns:oa=3D"urn:schemas-microsoft-com:office:activation" =
xmlns:html=3D"http://www.w3.org/TR/REC-html40" =
xmlns:q=3D"http://schemas.xmlsoap.org/soap/envelope/" =
xmlns:rtc=3D"http://microsoft.com/officenet/conferencing" =
xmlns:D=3D"DAV:" xmlns:Repl=3D"http://schemas.microsoft.com/repl/" =
xmlns:mt=3D"http://schemas.microsoft.com/sharepoint/soap/meetings/" =
xmlns:x2=3D"http://schemas.microsoft.com/office/excel/2003/xml" =
xmlns:ppda=3D"http://www.passport.com/NameSpace.xsd" =
xmlns:ois=3D"http://schemas.microsoft.com/sharepoint/soap/ois/" =
xmlns:dir=3D"http://schemas.microsoft.com/sharepoint/soap/directory/" =
xmlns:ds=3D"http://www.w3.org/2000/09/xmldsig#" =
xmlns:dsp=3D"http://schemas.microsoft.com/sharepoint/dsp" =
xmlns:udc=3D"http://schemas.microsoft.com/data/udc" =
xmlns:xsd=3D"http://www.w3.org/2001/XMLSchema" =
xmlns:sub=3D"http://schemas.microsoft.com/sharepoint/soap/2002/1/alerts/"=
 xmlns:ec=3D"http://www.w3.org/2001/04/xmlenc#" =
xmlns:sp=3D"http://schemas.microsoft.com/sharepoint/" =
xmlns:sps=3D"http://schemas.microsoft.com/sharepoint/soap/" =
xmlns:xsi=3D"http://www.w3.org/2001/XMLSchema-instance" =
xmlns:udcs=3D"http://schemas.microsoft.com/data/udc/soap" =
xmlns:udcxf=3D"http://schemas.microsoft.com/data/udc/xmlfile" =
xmlns:udcp2p=3D"http://schemas.microsoft.com/data/udc/parttopart" =
xmlns:wf=3D"http://schemas.microsoft.com/sharepoint/soap/workflow/" =
xmlns:dsss=3D"http://schemas.microsoft.com/office/2006/digsig-setup" =
xmlns:dssi=3D"http://schemas.microsoft.com/office/2006/digsig" =
xmlns:mdssi=3D"http://schemas.openxmlformats.org/package/2006/digital-sig=
nature" =
xmlns:mver=3D"http://schemas.openxmlformats.org/markup-compatibility/2006=
" xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns:mrels=3D"http://schemas.openxmlformats.org/package/2006/relationshi=
ps" xmlns:spwp=3D"http://microsoft.com/sharepoint/webpartpages" =
xmlns:ex12t=3D"http://schemas.microsoft.com/exchange/services/2006/types"=
 =
xmlns:ex12m=3D"http://schemas.microsoft.com/exchange/services/2006/messag=
es" =
xmlns:pptsl=3D"http://schemas.microsoft.com/sharepoint/soap/SlideLibrary/=
" =
xmlns:spsl=3D"http://microsoft.com/webservices/SharePointPortalServer/Pub=
lishedLinksService" xmlns:Z=3D"urn:schemas-microsoft-com:" =
xmlns:tax=3D"http://schemas.microsoft.com/sharepoint/taxonomy/soap/" =
xmlns:tns=3D"http://schemas.microsoft.com/sharepoint/soap/recordsreposito=
ry/" =
xmlns:spsup=3D"http://microsoft.com/webservices/SharePointPortalServer/Us=
erProfileService" xmlns:mml=3D"http://www.w3.org/1998/Math/MathML" =
xmlns:st=3D"&#1;" xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1"><meta name=3DGenerator content=3D"Microsoft Word =
14 (filtered medium)"><style><!--
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
	{font-family:Webdings;
	panose-1:5 3 1 2 1 5 9 6 7 3;}
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1914466063;
	mso-list-type:hybrid;
	mso-list-template-ids:1901095300 1307360720 67895299 67895301 67895297 =
67895299 67895301 67895297 67895299 67895301;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:20.25pt;
	text-indent:-18.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-font-family:Calibri;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:56.25pt;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:92.25pt;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:128.25pt;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:164.25pt;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:200.25pt;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:236.25pt;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:272.25pt;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:308.25pt;
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
</o:shapelayout></xml><![endif]--></head><body lang=3DFR link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal><span =
lang=3DEN-US>Dear all,<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>I have difficulties to use Babeltrace in live session and I =
would like to use Trace Compass.<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>My target activated LTTng with =
:<o:p></o:p></span></p><p class=3DMsoListParagraph =
style=3D'margin-left:20.25pt;text-indent:-18.0pt;mso-list:l0 level1 =
lfo1'><![if !supportLists]><span lang=3DEN-US><span =
style=3D'mso-list:Ignore'>-<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></span></span><![endif]><span dir=3DLTR></span><span =
lang=3DEN-US>Lttng create test &#8211;live =
&#8211;set-url:&#8217;net://192.168.0.1:5342:5343&#8217;<o:p></o:p></span=
></p><p class=3DMsoListParagraph =
style=3D'margin-left:20.25pt;text-indent:-18.0pt;mso-list:l0 level1 =
lfo1'><![if !supportLists]><span lang=3DEN-US><span =
style=3D'mso-list:Ignore'>-<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></span></span><![endif]><span dir=3DLTR></span><span =
lang=3DEN-US>Lttng enable-event sched_switch<o:p></o:p></span></p><p =
class=3DMsoListParagraph =
style=3D'margin-left:20.25pt;text-indent:-18.0pt;mso-list:l0 level1 =
lfo1'><![if !supportLists]><span lang=3DEN-US><span =
style=3D'mso-list:Ignore'>-<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></span></span><![endif]><span dir=3DLTR></span><span =
lang=3DEN-US>Lttng start<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>My host (@192.168.0.1) activated LTTng with =
:<o:p></o:p></span></p><p class=3DMsoListParagraph =
style=3D'margin-left:20.25pt;text-indent:-18.0pt;mso-list:l0 level1 =
lfo1'><![if !supportLists]><span lang=3DEN-US><span =
style=3D'mso-list:Ignore'>-<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></span></span><![endif]><span dir=3DLTR></span><span =
lang=3DEN-US>Lttng-relayd &#8211;vv<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>Everything seems to be OK because =
my host received bytes from my target during 1 =
minute.<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>I would like to see the traces in ~/lttng-traces with =
TraceCompass and I can only watch the first second of my recording. It =
is impossible to see after (I did a lot of =
refresh&#8230;).<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>Why ?<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>Regards<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US style=3D'color:#1F497D;mso-fareast-language:FR'>Thierry =
BADEUIL</span><span lang=3DEN-US =
style=3D'color:#1F497D;mso-fareast-language:FR'><o:p></o:p></span></p><p =
class=3DMsoNormal><b><span lang=3DEN-GB =
style=3D'font-size:10.0pt;color:blue;mso-fareast-language:FR'>THALES =
COMMUNICATIONS<o:p></o:p></span></b></p><p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:Wingdings;color:#1F497D;mso-fareast=
-language:FR'>(</span><span =
style=3D'font-size:10.0pt;color:#1F497D;mso-fareast-language:FR'> <span =
lang=3DEN-GB>: +33 1 46 133&nbsp;591<o:p></o:p></span></span></p><p =
class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:Webdings;color:#1F497D;mso-fareast-=
language:FR'>=C8</span><span lang=3DEN-GB =
style=3D'font-size:10.0pt;color:#1F497D;mso-fareast-language:FR'>=A0 : =
+33 6 85 51 28 16<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:Wingdings;color:#1F497D;mso-fareast=
-language:FR'>*</span><span lang=3DEN-GB =
style=3D'font-size:10.0pt;color:#1F497D;mso-fareast-language:FR'> : =
</span><u><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif";color:blue;mso=
-fareast-language:FR'><a =
href=3D"mailto:thierry.badeuil@fr.thalesgroup.com" =
title=3D"mailto:thierry.badeuil@fr.thalesgroup.com&#10;mailto:guillaume.b=
izon@fr.thalesgroup.com"><span lang=3DEN-GB =
style=3D'color:blue'>thierry.badeuil@thalesgroup.com</span></a></span></u=
><span lang=3DEN-GB =
style=3D'font-size:10.0pt;color:#1F497D;mso-fareast-language:FR'><o:p></o=
:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p></div></body></html>
------=_NextPart_001_00A2_01D4027B.46ED5960--

------=_NextPart_000_00A1_01D4027B.46ED5960
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
kiaJk/IsZAEBEwhUMDAwNjI1NTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALGcevtX
o4LWyOCysyfnr1OeF3kS7I+l+1wC24jD0lRwJKCKB7lBjGWzI8BuJTJebyAYrggY29bHU1sXmYzf
VLUQgD9pUXEH5jRBP2z2qxg2+d66KL9+sa+XvXlUquMgxT/00ZDBIbTo2tz+f/cJCX9DaUSNLPt6
pOU7o4If2AFle527O8z8xgpXvzfdEi0W8TfxXfdxMBfs6EAZaUJnM/c4gIGkabIqNIH6gxo7xfhq
cBR7OKw1oe6dGBf6AtR2qBdtxrli/i0/phHb4gf3Da2Rvw/1st2oHFn7H4aHx0GJxqFu9ydDOwfF
E2yVqq/ITm1vxVBp7tgoHpxnhfwvPgECAwEAAaOCAhEwggINMB0GA1UdDgQWBBQjatJpG1HNROhT
4KJE3mpK07fnQzAfBgNVHSMEGDAWgBRFkJX/mV3SB42zEvbt8ig0klvbgTCB2gYDVR0gBIHSMIHP
MIHMBgcqgXoBbAEDMIHAMDsGCCsGAQUFBwIBFi9odHRwOi8vd3d3LnRoYWxlc2dyb3VwLmNvbS9j
ZXJ0aWZpY2F0aW9uX3BvbGljeTCBgAYIKwYBBQUHAgIwdBpyTW9yZSBpbmZvcm1hdGlvbiBvbiB0
aGUgVGhhbGVzIENlcnRpZmljYXRlIFBvbGljeSBjYW4gYmUgZm91bmQgYXQgaHR0cDovL3d3dy50
aGFsZXNncm91cC5jb20vY2VydGlmaWNhdGlvbl9wb2xpY3kgMB8GA1UdJQQYMBYGCCsGAQUFBwME
BgorBgEEAYI3CgMBMA4GA1UdDwEB/wQEAwIGwDAqBgNVHREEIzAhgR90aGllcnJ5LmJhZGV1aWxA
dGhhbGVzZ3JvdXAuY29tMEIGA1UdHwQ7MDkwN6A1oDOGMWh0dHA6Ly9jcmwudGhhbGVzZ3JvdXAu
Y29tL1RoYWxlc0ludGVybmFsQ0FWMy5jcmwwTQYIKwYBBQUHAQEEQTA/MD0GCCsGAQUFBzAChjFo
dHRwOi8vY3JsLnRoYWxlc2dyb3VwLmNvbS9UaGFsZXNJbnRlcm5hbENBVjMucDdjMA0GCSqGSIb3
DQEBCwUAA4ICAQCL5rz1Rb46zacF499WZCl1tI9Qg3zhc3FbOuTR/fUNh5DfLBfbZo4U8Dbmw1HH
sldB3Aol4hjBcfAXu/hVlNBXCJ0LEVIEN5vNrKAlmg0qJOJF/z8FOCWQX0KxHIyJOWwLgFTy4sy0
pGtTuIB8hcZe9O/sNDPCeJB3NPZFTnKncRpneDFXgo0Hhjpc1e9HsYFTiXJvSK9+MyKPOwBlckwe
UJ+4K8t02eOGrhHbqh3iZv4XWPLfwjLlNkXTwJV6ERjKq84XflSsRxM7KKfu8+aPLJVsOvWI9kD/
gN9Vt+fou0BKJJ7lct21Wd1Nb5ELuqvyAUe/FiheSC/mUup8S8N9/1GS5iDOQgdLjiUQcM+B9oXC
+ZFkKPFhPAz+4LCoWoTiJ6KQ1SU6UWT+eyidA8N3gIEcPke+JtqMVW993IEiSOuRHDXeV8hEdIzu
RDvkZX1e6HUlUXeBYhTkq0jeHIOJbs8R9TuKzB+lpykpJuxFVOUu8W21fws4YXXJrzXCEBw6JEAN
ZYyqcyatAZjIRJVMTUQdSjiOlKo9HGADBDfVbuEhELTbLsK+JfZD7paVALae/ruuTf8O+DpnIJ5T
qlgFfAqYTQEuvwytUaNugzJ3Dgu+by0Vf4sHTCIvCPrWaaX5kFFN7kSaYcZ4f2DIgkENoOxRhGV2
j56AEMxRPhhZlTCCBnswggRjoAMCAQICEhEhe8yEwSRlRHEmlUOl5JEq4DANBgkqhkiG9w0BAQsF
ADBTMQswCQYDVQQGEwJGUjEPMA0GA1UECgwGVGhhbGVzMRcwFQYDVQQLDA4wMDAyIDU1MjA1OTAy
NDEaMBgGA1UEAwwRVGhhbGVzIFJvb3QgQ0EgVjMwHhcNMTMxMTI2MDAwMDAwWhcNMjMxMTI2MDAw
MDAwWjBXMQswCQYDVQQGEwJGUjEPMA0GA1UECgwGVGhhbGVzMRcwFQYDVQQLDA4wMDAyIDU1MjA1
OTAyNDEeMBwGA1UEAwwVVGhhbGVzIEludGVybmFsIENBIFYzMIICIjANBgkqhkiG9w0BAQEFAAOC
Ag8AMIICCgKCAgEA0rkMp5a0Ce4DJ+bUrZ3vpMKHymqvp96yPqWHzvKrqusI2ApwVZWW/Y2gCNdA
UyE/gUN7BG+LXf5yyYhKRJO15OjwUVvpTUlIsR15RzHMnpFlgBIKHRV2OFOvIsIu456cFIIRU9Vq
Lf8Rvbz/d8IM4dVJoOZ3zCj06m99s0Zad2VxxTlN81Ek0J3Lkbu5aqg1E2A7Q80XwKNkkovuiAz4
klpbqyk2rothrnsZrMnE2UuEgwRkMBQufUk2PUha1E0DjG/iy7HyGkUuGL4k5E/57h0ebeqeMYVe
X/owek4oUeKwK+Opvi6cooJuAWfHuy6kH8OAPfbu22Vy3WCYbIfJtlKlNuEjYCWcUSHgJPg9dDYZ
ExBgTtEaK53xqJYWQUl8k7mScjhvxj+nF9h6/FYfdNUwv9OXkBFuiERWVil64zMGmPWiiAisnVLW
uNnc5Jk8SLvU1ham82zXPvEL8f+Lp8vsyHQHhA6eleTTqIifj7nsrgJCHih9xEtY+PI1wOOJoIUl
y9OOAM1LPeNyKCUQQbyPwNyhg9FuN3YOyIleYYHuWTMl4cCXiwmzeASGkhQC5icEHpYKRwL+ZAmG
WNDsY4wrQnE5i2wEH0utOKdb+gnPiP8+QpbI56pJbrXZL0rj43MmApGuRXQmVafoP4OnvdwfKBIP
7HzhQS7O8CvSxpsCAwEAAaOCAUMwggE/MA4GA1UdDwEB/wQEAwIBBjBRBgNVHSAESjBIMEYGBFUd
IAAwPjA8BggrBgEFBQcCARYwaHR0cDovL2NybC50aGFsZXNncm91cC5jb20vY2VydGlmaWNhdGlv
bl9wb2xpY3kvMA8GA1UdEwEB/wQFMAMBAf8wPgYDVR0fBDcwNTAzoDGgL4YtaHR0cDovL2NybC50
aGFsZXNncm91cC5jb20vVGhhbGVzUm9vdENBVjMuY3JsMEkGCCsGAQUFBwEBBD0wOzA5BggrBgEF
BQcwAoYtaHR0cDovL2NybC50aGFsZXNncm91cC5jb20vVGhhbGVzUm9vdENBVjMucDdjMB0GA1Ud
DgQWBBRFkJX/mV3SB42zEvbt8ig0klvbgTAfBgNVHSMEGDAWgBQrJxeCGWDoBEdY85KumrfqjtZ5
lTANBgkqhkiG9w0BAQsFAAOCAgEAhYwNoWezNu5n/I64uircImuPDaGQUGqAtyLF6LtcMkYB98Kq
ZYGdGfCUOKDI/r4NRI1F2mzbE07mlF0i35YijDVaHD+l7c2qYgg+ZHUt2tjkVMnk9goaZuixdztM
4IzY/1Br9q2Jum4jTdi9PYdO6pKHVtcFwLrza7l0rpVU5twguhSdSWVayOtjUQD63aWVDRuUOY+d
DQ7jAGVcB2ZdkN+OxjbfpV/Xm+6hdEO5uE3ghZOzS/HQUdSc0zy9myJeOzZ9+DmpMKyPLVADgxbt
2tOSC5ky4feLE3cOagJ0MIk93xWkajGo5BXqbqVl/gCXgrui4SRvUIUPQc8XHW1+usMzmiotDKGn
pPnQMI0BwBsQFCZxMmF+rgTe2kB2/TykXWmc9JA6Gof7MKCbcN93liiOm5sAQaL5ZDZXEmH+7Xry
N79AGWIxMqB9dbx/h6Pbp1bUtUf2htEN0S1MsE/RJtuGeYAdGn3rjidDjczoHCA9oRCZeeCXcr/W
oYeMNCuR/n60x1JrIoDIB0p+LkvnCPtwdPv12t2QAsXk9wNYd9PuMF42Tccz0SCBZgyh16I4AHQ7
GT3UuXBinFpVXY0MCd7pBwzMJsUizCN82jNvPnh9EewYMlxhres/AJvzu/4d5t3fLCudbW9VIBS5
esq6HpZ1CzF27v39fHemAM5E6M4wggaGMIIEbqADAgECAgMA6PYwDQYJKoZIhvcNAQELBQAwVzEL
MAkGA1UEBhMCRlIxDzANBgNVBAoMBlRoYWxlczEXMBUGA1UECwwOMDAwMiA1NTIwNTkwMjQxHjAc
BgNVBAMMFVRoYWxlcyBJbnRlcm5hbCBDQSBWMzAeFw0xNDEyMDkwOTUxMDJaFw0xOTEyMDkwOTUx
MDJaMHUxDzANBgNVBAoTBlRoYWxlczEYMBYGA1UEAxMPQkFERVVJTCBUaGllcnJ5MS4wLAYJKoZI
hvcNAQkBFh90aGllcnJ5LmJhZGV1aWxAdGhhbGVzZ3JvdXAuY29tMRgwFgYKCZImiZPyLGQBARMI
VDAwMDYyNTUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDXEYJPQNZD0AhY31Ma96ce
6OuqSiHdS/34timZw7XazImdP9Dmm8KN6imyWShw9EW2ahPNKIxTIUlvddn4HW1yITI+kne58D4J
e6z/x7D/4ijF660yyzMtxUs06XeB3qSJj2Hq8d0MM9Q/0MGtWOBtuXCI6t/1DivdWmIbdi4vYSp0
phbehF1u0uZA3ll4peRSFX7m3I7ieJtgyTxdjiV90qR9MW7IwVea+/CDgG8G84DRl1MwoimKt2tP
eATNpYPJNQB5IT+XL4oZJValzJauSwcbujeCWV1iiYO4khKxxV5dsuVNfUxfuXE1G+54BQfrBy8I
pjFYYxIV+OgMjFwhAgMBAAGjggI7MIICNzAdBgNVHQ4EFgQU/5ddQuBN0xMrYVxN+gYXzl0ud2cw
HwYDVR0jBBgwFoAURZCV/5ld0geNsxL27fIoNJJb24EwgdoGA1UdIASB0jCBzzCBzAYHKoF6AWwB
AzCBwDA7BggrBgEFBQcCARYvaHR0cDovL3d3dy50aGFsZXNncm91cC5jb20vY2VydGlmaWNhdGlv
bl9wb2xpY3kwgYAGCCsGAQUFBwICMHQack1vcmUgaW5mb3JtYXRpb24gb24gdGhlIFRoYWxlcyBD
ZXJ0aWZpY2F0ZSBQb2xpY3kgY2FuIGJlIGZvdW5kIGF0IGh0dHA6Ly93d3cudGhhbGVzZ3JvdXAu
Y29tL2NlcnRpZmljYXRpb25fcG9saWN5IDBJBgNVHSUEQjBABggrBgEFBQcDBAYKKwYBBAGCNwoD
AQYKKwYBBAGCNwoDBAYIKwYBBQUHAwUGCCsGAQUFBwMGBggrBgEFBQcDBzAOBgNVHQ8BAf8EBAMC
BDAwKgYDVR0RBCMwIYEfdGhpZXJyeS5iYWRldWlsQHRoYWxlc2dyb3VwLmNvbTBCBgNVHR8EOzA5
MDegNaAzhjFodHRwOi8vY3JsLnRoYWxlc2dyb3VwLmNvbS9UaGFsZXNJbnRlcm5hbENBVjMuY3Js
ME0GCCsGAQUFBwEBBEEwPzA9BggrBgEFBQcwAoYxaHR0cDovL2NybC50aGFsZXNncm91cC5jb20v
VGhhbGVzSW50ZXJuYWxDQVYzLnA3YzANBgkqhkiG9w0BAQsFAAOCAgEAQwESrDlSkrBs2JOL+AZj
FJ1OCLUYRf7BmWMyKeAuMaJtCkxF59OSuLgRFFpKk3VktQEJ0Ek6K4h9HnHh0zRR0bHnerFfz+Tz
+XwGzaGxwj5OwHVal9vKJAO71F8pAo4iEAh3plkzvDRjoVliUMkwzp0szx6MUEEWlMo5XooW7U8B
P55nfT/UR2oa/V3jMO2f7A0OxgE6G4S4E8BRvUmqhdVFYMqyIOFQvIsZbWxgyT91kM4+8M9ipmth
eimPfe6DeYFWaqjk86v50UC0Ea2pVojaYkxh+AHlFN8a0rzRhdN3D4lBCTKv8/5AJRpQUCGT9Nn/
PCS/vQFeVfdgxkcdoC6xKDvj32iiQr/bCz9uywArPmtIiGbYbYNhZBQDy8mtvz9xLWDDFFbO0rm6
nQTWvY/w8O3xe/fbKINZwzD8Q4zhz9B/sttTUcaSJ/hOlKZxOD7Oye7VsHSZ1ejfOGhK28z5SHgc
uSXQ5bgdv5w3thC6GfbKpcq49VJev90KC5fcdqaSXa0l8I5f+e/zRPg19Ke6pptAyM/W9Gf1GOE5
wi31QNREhgnUOh5xhJeSvH1Yg/t+i4cfcj/lWn0orq3R0BT8y5tDGC9cyHFvPWIG7o5PhWoIcQxF
LGuxt89SsQjFZrhVqOPYLZ1rPjA+jvF9+FFq04TxH1LdvcYqhNhTA/UxggMaMIIDFgIBATBeMFcx
CzAJBgNVBAYTAkZSMQ8wDQYDVQQKDAZUaGFsZXMxFzAVBgNVBAsMDjAwMDIgNTUyMDU5MDI0MR4w
HAYDVQQDDBVUaGFsZXMgSW50ZXJuYWwgQ0EgVjMCAwDo9DAJBgUrDgMCGgUAoIIBkTAYBgkqhkiG
9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xODA2MTIxNjI5MTlaMCMGCSqGSIb3
DQEJBDEWBBRq9gjqQrkuupJkhKH6mb37qY7m0TBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMH
MA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDBt
BgkrBgEEAYI3EAQxYDBeMFcxCzAJBgNVBAYTAkZSMQ8wDQYDVQQKDAZUaGFsZXMxFzAVBgNVBAsM
DjAwMDIgNTUyMDU5MDI0MR4wHAYDVQQDDBVUaGFsZXMgSW50ZXJuYWwgQ0EgVjMCAwDo9jBvBgsq
hkiG9w0BCRACCzFgoF4wVzELMAkGA1UEBhMCRlIxDzANBgNVBAoMBlRoYWxlczEXMBUGA1UECwwO
MDAwMiA1NTIwNTkwMjQxHjAcBgNVBAMMFVRoYWxlcyBJbnRlcm5hbCBDQSBWMwIDAOj2MA0GCSqG
SIb3DQEBAQUABIIBAEu7EH0udeBlDtPIgFqWo5miwMLBtLRKRiZNaSn4Up0i+2aLZjZabJGRvMOe
rOPcujKqSflBgWAtlor4oD39s2eS7SSo0m6nxRsh3Un6W5Ik5H+KE/LpwHpT0GmWPxOE1gLHId7d
Lk74xjkdH8/TnkaLg1GE+8nRLEFrGa98+uVG4dxBKaGTO7kPLY0FrUh6L9w1Cu21VQxOVvRIG/Yh
XTSbhBXKwBl3xdpJSUPl62mkE4nXK+FntC/fNmKt9QNqrXz7vfcM0RN36mvPlBKzmKXoKMboYcVh
SkAMd044CUYS1wP02IAnva3qJVRJGuDj5ndW7vZN2wdVpk92zHDM6bMAAAAAAAA=

------=_NextPart_000_00A1_01D4027B.46ED5960--

--===============1284112775011633588==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1284112775011633588==--
