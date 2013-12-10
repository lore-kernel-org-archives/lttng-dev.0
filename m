From: Manikandan Govindaswamy <magov@vestas.com>
Subject: lttng-ust works
Date: Tue, 10 Dec 2013 13:42:51 +0800
Message-ID: <6CFA219DE9CAD940989B83CA579159F91B43C4D05A__47504.2633632713$1386654226$gmane$org@SGSINEXC014.vestas.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1354741623=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail1.bemta14.messagelabs.com ([193.109.254.117])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <magov@vestas.com>) id 1VqG5z-0001Ir-Oe
	for lttng-dev@lists.lttng.org; Tue, 10 Dec 2013 00:43:01 -0500
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "jeremie.galarneau@efficios.com" <jeremie.galarneau@efficios.com>, "Thibault, Daniel (Daniel.Thibault@drdc-rddc.gc.ca)" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1354741623==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_6CFA219DE9CAD940989B83CA579159F91B43C4D05ASGSINEXC014ve_"

--_000_6CFA219DE9CAD940989B83CA579159F91B43C4D05ASGSINEXC014ve_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi !,



I'm also able to run the easy-ust and generate the traces successfully if I=
 create and run from an user not as root user.



But  the kernel traces are generated fine for even root user but for ust it=
 runs fine only with non-root user in my case.



And the behavior is vice versa if I try the kernel tracer from user



# lttng list -k

Error: Unable to list kernel events: Tracing the kernel requires a root ltt=
ng-sessiond daemon, as well as "tracing" group membership or root user ID f=
or the lttng client.

Error: Command error



Will it be possible to run both kernel and ust to run and create the traces=
 from root user itself? And if you could explain why ust expects the user?



Regards,

GMK


--_000_6CFA219DE9CAD940989B83CA579159F91B43C4D05ASGSINEXC014ve_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Micros=
oft Word 14 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
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
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue vli=
nk=3Dpurple><div class=3DWordSection1><p class=3DMsoPlainText>Hi !,<o:p></o=
:p></p><p class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText=
>I&#8217;m also able to run the easy-ust and generate the traces successful=
ly if I create and run from an user not as root user.<o:p></o:p></p><p clas=
s=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText>But&nbsp; the=
 kernel traces are generated fine for even root user but for ust it runs fi=
ne only with non-root user in my case.<o:p></o:p></p><p class=3DMsoPlainTex=
t><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText>And the behavior is vice ver=
sa if I try the kernel tracer from user<o:p></o:p></p><p class=3DMsoPlainTe=
xt><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText># lttng list -k<o:p></o:p><=
/p><p class=3DMsoPlainText>Error: Unable to list kernel events: Tracing the=
 kernel requires a root lttng-sessiond daemon, as well as &quot;tracing&quo=
t; group membership or root user ID for the lttng client.<o:p></o:p></p><p =
class=3DMsoPlainText>Error: Command error<o:p></o:p></p><p class=3DMsoPlain=
Text><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText>Will it be possible to ru=
n both kernel and ust to run and create the traces from root user itself? A=
nd if you could explain why ust expects the user?<o:p></o:p></p><p class=3D=
MsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText>Regards,<o:p></o:=
p></p><p class=3DMsoPlainText>GMK<o:p></o:p></p><p class=3DMsoNormal><o:p>&=
nbsp;</o:p></p></div></body></html>=

--_000_6CFA219DE9CAD940989B83CA579159F91B43C4D05ASGSINEXC014ve_--


--===============1354741623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1354741623==--
