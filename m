From: Manikandan Govindaswamy <magov@vestas.com>
Subject: Userspace privilage
Date: Sat, 13 Sep 2014 05:33:29 +0800
Message-ID: <6CFA219DE9CAD940989B83CA579159F92DC0A8C98F__2633.66017393327$1410557683$gmane$org@SGSINEXC014.vestas.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1537674064=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.139])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <magov@vestas.com>) id 1XSYTK-0008HM-3v
 for lttng-dev@lists.lttng.org; Fri, 12 Sep 2014 17:33:40 -0400
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

--===============1537674064==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_6CFA219DE9CAD940989B83CA579159F92DC0A8C98FSGSINEXC014ve_"

--_000_6CFA219DE9CAD940989B83CA579159F92DC0A8C98FSGSINEXC014ve_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi !

We have a busybox version target and starting the lttng on root privilege.

The kernel traces  works fine and we could get all the traces, we have appl=
ication which needs root privilege to start some part of services and also =
has tracepoints in it, so have to run my application from root ( part of tr=
acing group).

When I start the another tracing from an user account who is part of tracin=
g group, if I run the lttng list, it opens a new session for the user?

So could not possible to see the user space tracepoints which I've started =
from root( though it's part of tracing group).

If the user also part of tracing group then the session started by root sho=
uld have been used by the user trace list, and possible to see the tracepoi=
nts or not?


Regards,
GMK.





--_000_6CFA219DE9CAD940989B83CA579159F92DC0A8C98FSGSINEXC014ve_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Micros=
oft Word 14 (filtered medium)"><style><!--
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Arial","sans-serif";}
h1
	{mso-style-link:"Heading 1 Char";
	margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	page-break-after:avoid;
	font-size:16.0pt;
	font-family:"Arial","sans-serif";
	font-weight:normal;}
h2
	{mso-style-link:"Heading 2 Char";
	margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	page-break-after:avoid;
	font-size:12.0pt;
	font-family:"Arial","sans-serif";
	font-weight:normal;}
h3
	{mso-style-link:"Heading 3 Char";
	margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	page-break-after:avoid;
	font-size:11.0pt;
	font-family:"Arial","sans-serif";}
h4
	{mso-style-link:"Heading 4 Char";
	margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	page-break-after:avoid;
	font-size:10.0pt;
	font-family:"Arial","sans-serif";}
h5
	{mso-style-link:"Heading 5 Char";
	margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	font-size:10.0pt;
	font-family:"Arial","sans-serif";
	font-weight:normal;}
h6
	{mso-style-link:"Heading 6 Char";
	margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	font-size:10.0pt;
	font-family:"Arial","sans-serif";
	font-weight:normal;}
p.MsoHeading7, li.MsoHeading7, div.MsoHeading7
	{mso-style-link:"Heading 7 Char";
	margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	font-size:10.0pt;
	font-family:"Arial","sans-serif";}
p.MsoHeading8, li.MsoHeading8, div.MsoHeading8
	{mso-style-link:"Heading 8 Char";
	margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	font-size:10.0pt;
	font-family:"Arial","sans-serif";}
p.MsoHeading9, li.MsoHeading9, div.MsoHeading9
	{mso-style-link:"Heading 9 Char";
	margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	font-size:10.0pt;
	font-family:"Arial","sans-serif";}
p.MsoCaption, li.MsoCaption, div.MsoCaption
	{mso-style-priority:35;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:10.0pt;
	margin-left:0in;
	font-size:9.0pt;
	font-family:"Arial","sans-serif";
	color:#0091D7;
	font-weight:bold;}
p.MsoTitle, li.MsoTitle, div.MsoTitle
	{mso-style-priority:10;
	mso-style-link:"Title Char";
	margin-top:0in;
	margin-right:0in;
	margin-bottom:15.0pt;
	margin-left:0in;
	mso-add-space:auto;
	border:none;
	padding:0in;
	font-size:26.0pt;
	font-family:"Arial","sans-serif";
	color:#293137;
	letter-spacing:.25pt;}
p.MsoTitleCxSpFirst, li.MsoTitleCxSpFirst, div.MsoTitleCxSpFirst
	{mso-style-priority:10;
	mso-style-link:"Title Char";
	mso-style-type:export-only;
	margin:0in;
	margin-bottom:.0001pt;
	mso-add-space:auto;
	border:none;
	padding:0in;
	font-size:26.0pt;
	font-family:"Arial","sans-serif";
	color:#293137;
	letter-spacing:.25pt;}
p.MsoTitleCxSpMiddle, li.MsoTitleCxSpMiddle, div.MsoTitleCxSpMiddle
	{mso-style-priority:10;
	mso-style-link:"Title Char";
	mso-style-type:export-only;
	margin:0in;
	margin-bottom:.0001pt;
	mso-add-space:auto;
	border:none;
	padding:0in;
	font-size:26.0pt;
	font-family:"Arial","sans-serif";
	color:#293137;
	letter-spacing:.25pt;}
p.MsoTitleCxSpLast, li.MsoTitleCxSpLast, div.MsoTitleCxSpLast
	{mso-style-priority:10;
	mso-style-link:"Title Char";
	mso-style-type:export-only;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:15.0pt;
	margin-left:0in;
	mso-add-space:auto;
	border:none;
	padding:0in;
	font-size:26.0pt;
	font-family:"Arial","sans-serif";
	color:#293137;
	letter-spacing:.25pt;}
p.MsoSubtitle, li.MsoSubtitle, div.MsoSubtitle
	{mso-style-priority:11;
	mso-style-link:"Subtitle Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Arial","sans-serif";
	color:#0091D7;
	letter-spacing:.75pt;
	font-style:italic;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0091D7;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#5E6365;
	text-decoration:underline;}
p.MsoNoSpacing, li.MsoNoSpacing, div.MsoNoSpacing
	{mso-style-priority:1;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Arial","sans-serif";}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	mso-add-space:auto;
	font-size:10.0pt;
	font-family:"Arial","sans-serif";}
p.MsoListParagraphCxSpFirst, li.MsoListParagraphCxSpFirst, div.MsoListParag=
raphCxSpFirst
	{mso-style-priority:34;
	mso-style-type:export-only;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	mso-add-space:auto;
	font-size:10.0pt;
	font-family:"Arial","sans-serif";}
p.MsoListParagraphCxSpMiddle, li.MsoListParagraphCxSpMiddle, div.MsoListPar=
agraphCxSpMiddle
	{mso-style-priority:34;
	mso-style-type:export-only;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	mso-add-space:auto;
	font-size:10.0pt;
	font-family:"Arial","sans-serif";}
p.MsoListParagraphCxSpLast, li.MsoListParagraphCxSpLast, div.MsoListParagra=
phCxSpLast
	{mso-style-priority:34;
	mso-style-type:export-only;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	mso-add-space:auto;
	font-size:10.0pt;
	font-family:"Arial","sans-serif";}
p.MsoQuote, li.MsoQuote, div.MsoQuote
	{mso-style-priority:29;
	mso-style-link:"Quote Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Arial","sans-serif";
	color:black;
	font-style:italic;}
p.MsoIntenseQuote, li.MsoIntenseQuote, div.MsoIntenseQuote
	{mso-style-priority:30;
	mso-style-link:"Intense Quote Char";
	margin-top:10.0pt;
	margin-right:.65in;
	margin-bottom:14.0pt;
	margin-left:.65in;
	border:none;
	padding:0in;
	font-size:11.0pt;
	font-family:"Arial","sans-serif";
	color:#0091D7;
	font-weight:bold;
	font-style:italic;}
span.MsoSubtleEmphasis
	{mso-style-priority:19;
	color:gray;
	font-style:italic;}
span.MsoIntenseEmphasis
	{mso-style-priority:21;
	color:#0091D7;
	font-weight:bold;
	font-style:italic;}
span.MsoSubtleReference
	{mso-style-priority:31;
	font-variant:small-caps;
	color:#37B6EA;
	text-decoration:underline;}
span.MsoIntenseReference
	{mso-style-priority:32;
	font-variant:small-caps;
	color:#37B6EA;
	letter-spacing:.25pt;
	font-weight:bold;
	text-decoration:underline;}
span.MsoBookTitle
	{mso-style-priority:33;
	font-variant:small-caps;
	letter-spacing:.25pt;
	font-weight:bold;}
p.MsoTocHeading, li.MsoTocHeading, div.MsoTocHeading
	{mso-style-priority:39;
	margin-top:24.0pt;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:0in;
	margin-bottom:.0001pt;
	page-break-after:avoid;
	font-size:14.0pt;
	font-family:"Arial","sans-serif";
	color:#006BA1;
	font-weight:bold;}
p.DocumentTitle, li.DocumentTitle, div.DocumentTitle
	{mso-style-name:"Document Title";
	margin-top:0in;
	margin-right:0in;
	margin-bottom:6.0pt;
	margin-left:0in;
	font-size:20.0pt;
	font-family:"Arial","sans-serif";
	font-weight:bold;}
p.SmallFields, li.SmallFields, div.SmallFields
	{mso-style-name:"Small Fields";
	margin-top:0in;
	margin-right:0in;
	margin-bottom:6.0pt;
	margin-left:0in;
	font-size:10.0pt;
	font-family:"Arial","sans-serif";}
p.SmallText, li.SmallText, div.SmallText
	{mso-style-name:"Small Text";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:7.0pt;
	font-family:"Arial","sans-serif";}
p.NormalStrong, li.NormalStrong, div.NormalStrong
	{mso-style-name:"Normal Strong";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Arial","sans-serif";
	font-weight:bold;}
p.InfoFields, li.InfoFields, div.InfoFields
	{mso-style-name:"Info Fields";
	margin-top:0in;
	margin-right:0in;
	margin-bottom:6.0pt;
	margin-left:0in;
	font-size:10.0pt;
	font-family:"Arial","sans-serif";
	font-weight:bold;}
span.Heading1Char
	{mso-style-name:"Heading 1 Char";
	mso-style-link:"Heading 1";
	font-family:"Arial","sans-serif";}
span.Heading2Char
	{mso-style-name:"Heading 2 Char";
	mso-style-link:"Heading 2";
	font-family:"Arial","sans-serif";}
span.Heading3Char
	{mso-style-name:"Heading 3 Char";
	mso-style-link:"Heading 3";
	font-family:"Arial","sans-serif";
	font-weight:bold;}
span.Heading4Char
	{mso-style-name:"Heading 4 Char";
	mso-style-link:"Heading 4";
	font-family:"Arial","sans-serif";
	font-weight:bold;}
span.Heading5Char
	{mso-style-name:"Heading 5 Char";
	mso-style-link:"Heading 5";
	font-family:"Arial","sans-serif";}
span.Heading6Char
	{mso-style-name:"Heading 6 Char";
	mso-style-link:"Heading 6";
	font-family:"Arial","sans-serif";}
span.Heading7Char
	{mso-style-name:"Heading 7 Char";
	mso-style-link:"Heading 7";
	font-family:"Arial","sans-serif";}
span.Heading8Char
	{mso-style-name:"Heading 8 Char";
	mso-style-link:"Heading 8";
	font-family:"Arial","sans-serif";}
span.Heading9Char
	{mso-style-name:"Heading 9 Char";
	mso-style-link:"Heading 9";
	font-family:"Arial","sans-serif";}
span.TitleChar
	{mso-style-name:"Title Char";
	mso-style-priority:10;
	mso-style-link:Title;
	font-family:"Arial","sans-serif";
	color:#293137;
	letter-spacing:.25pt;}
span.SubtitleChar
	{mso-style-name:"Subtitle Char";
	mso-style-priority:11;
	mso-style-link:Subtitle;
	font-family:"Arial","sans-serif";
	color:#0091D7;
	letter-spacing:.75pt;
	font-style:italic;}
span.QuoteChar
	{mso-style-name:"Quote Char";
	mso-style-priority:29;
	mso-style-link:Quote;
	color:black;
	font-style:italic;}
span.IntenseQuoteChar
	{mso-style-name:"Intense Quote Char";
	mso-style-priority:30;
	mso-style-link:"Intense Quote";
	color:#0091D7;
	font-weight:bold;
	font-style:italic;}
span.EmailStyle50
	{mso-style-type:personal-compose;
	font-family:"Arial","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Arial","sans-serif";}
.MsoPapDefault
	{mso-style-type:export-only;
	margin-bottom:10.0pt;
	line-height:115%;}
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
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3D"#0091D7=
" vlink=3D"#5E6365"><div class=3DWordSection1><p class=3DMsoNormal><span la=
ng=3DEN-GB style=3D'font-size:11.0pt'>Hi !<o:p></o:p></span></p><p class=3D=
MsoNormal><span lang=3DEN-GB style=3D'font-size:11.0pt'><o:p>&nbsp;</o:p></=
span></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:11.0pt'=
>We have a busybox version target and starting the lttng on root privilege.=
<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'font=
-size:11.0pt'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=
=3DEN-GB style=3D'font-size:11.0pt'>The kernel traces &nbsp;works fine and =
we could get all the traces, we have application which needs root privilege=
 to start some part of services and also has tracepoints in it, so have to =
run my application from root ( part of tracing group).<o:p></o:p></span></p=
><p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:11.0pt'><o:p>&n=
bsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-=
size:11.0pt'>When I start the another tracing from an user account who is p=
art of tracing group, if I run the lttng list, it opens a new session for t=
he user?<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB style=
=3D'font-size:11.0pt'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><spa=
n lang=3DEN-GB style=3D'font-size:11.0pt'>So could not possible to see the =
user space tracepoints which I&#8217;ve started from root( though it&#8217;=
s part of tracing group).<o:p></o:p></span></p><p class=3DMsoNormal><span l=
ang=3DEN-GB style=3D'font-size:11.0pt'><o:p>&nbsp;</o:p></span></p><p class=
=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:11.0pt'>If the user also=
 part of tracing group then the session started by root should have been us=
ed by the user trace list, and possible to see the tracepoints or not?<o:p>=
</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-size=
:11.0pt'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-G=
B style=3D'font-size:11.0pt'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNorm=
al><span lang=3DEN-GB style=3D'font-size:11.0pt'>Regards,<o:p></o:p></span>=
</p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:11.0pt'>GMK.=
<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'font=
-size:11.0pt'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=
=3DEN-GB style=3D'font-size:11.0pt'><o:p>&nbsp;</o:p></span></p><p class=3D=
MsoNormal><span lang=3DEN-GB style=3D'font-size:11.0pt'><o:p>&nbsp;</o:p></=
span></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:11.0pt'=
><o:p>&nbsp;</o:p></span></p></div></body></html>=

--_000_6CFA219DE9CAD940989B83CA579159F92DC0A8C98FSGSINEXC014ve_--


--===============1537674064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1537674064==--
