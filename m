From: Farhan Shariff <farhan.shariff@asml.com>
Subject: Lttng tracepoint(provider,tpname, arg)
Date: Mon, 14 Sep 2015 08:51:30 +0000
Message-ID: <D199CBB1905D6A4E83FFCD29C335DF4C3B69BA49__12122.4925308072$1442254134$gmane$org@NLEIDX740.sn-eu.asml.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1239473379=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-am1on0064.outbound.protection.outlook.com ([157.56.112.64]
 helo=emea01-am1-obe.outbound.protection.outlook.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <farhan.shariff@asml.com>) id 1ZbPUE-0006tj-QY
 for lttng-dev@lists.lttng.org; Mon, 14 Sep 2015 04:51:45 -0400
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

--===============1239473379==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_D199CBB1905D6A4E83FFCD29C335DF4C3B69BA49NLEIDX740sneuas_"

--_000_D199CBB1905D6A4E83FFCD29C335DF4C3B69BA49NLEIDX740sneuas_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

 I want to insert tracepoint statements with same traceprovider_name and
  tracepoint_name but with different arguments:


 for example:

  hello-tp.tp

  TRACEPOINT_EVENT(
  provider_name_test,
  tp_name_tp,
  TP_ARGS(
  int, my_integer_arg,
  char*, my_string_arg
  ),
  TP_FIELDS(
  ctf_string(my_string_field, my_string_arg)
  ctf_integer(int, my_integer_field, my_integer_arg)
  )
  )

  How to use these in the code:

  tracepoint(provider_name_test, tp_name_tp,23 )

  tracepoint(provider_name_test, tp_name_tp,"hi there" )

  tracepoint(provider_name_test, tp_name_tp,23, "hi there" )







Best regards / Met vriendelijke groet / Cordialement,

Farhan Shariff
EUV Source Software Facilites
Development & Engineering
ASML Netherlands B.V. | De Run 6501 | 5504 DR Veldhoven | The Netherlands
Location: 7G2 | Tel: +31 619084549
farhan.shariff@asml.com<farhan.shariff@asml.com%20> | www.asml.com<http://w=
ww.asml.com/>

-- The information contained in this communication and any attachments is c=
onfidential and may be privileged, and is for the sole use of the intended =
recipient(s). Any unauthorized review, use, disclosure or distribution is p=
rohibited. Unless explicitly stated otherwise in the body of this communica=
tion or the attachment thereto (if any), the information is provided on an =
AS-IS basis without any express or implied warranties or liabilities. To th=
e extent you are relying on this information, you are doing so at your own =
risk. If you are not the intended recipient, please notify the sender immed=
iately by replying to this message and destroy all copies of this message a=
nd any attachments. The sender nor the company/group of companies he or she=
 represents shall be liable for the proper and complete transmission of the=
 information contained in this communication, or for any delay in its recei=
pt.

--_000_D199CBB1905D6A4E83FFCD29C335DF4C3B69BA49NLEIDX740sneuas_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Verdana;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:Vijaya;
	panose-1:2 11 6 4 2 2 2 2 2 4;}
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
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
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"color:#444444;background:white">&nbsp=
;I want to insert tracepoint statements with same traceprovider_name and</s=
pan><span style=3D"color:#444444"><br>
<span style=3D"background:white">&nbsp;&nbsp;tracepoint_name but with diffe=
rent arguments:</span><br>
<span style=3D"background:white">&nbsp;<o:p></o:p></span></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#444444;background:white"><o:p>=
&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#444444;background:white">&nbsp=
;for example:</span><span style=3D"color:#444444"><br>
<span style=3D"background:white">&nbsp;</span><br>
<span style=3D"background:white">&nbsp;&nbsp;hello-tp.tp</span><br>
<span style=3D"background:white">&nbsp;</span><br>
<span style=3D"background:white">&nbsp;&nbsp;TRACEPOINT_EVENT(</span><br>
<span style=3D"background:white">&nbsp;&nbsp;provider_name_test,</span><br>
<span style=3D"background:white">&nbsp;&nbsp;tp_name_tp,</span><br>
<span style=3D"background:white">&nbsp;&nbsp;TP_ARGS(</span><br>
<span style=3D"background:white">&nbsp;&nbsp;int, my_integer_arg,</span><br=
>
<span style=3D"background:white">&nbsp;&nbsp;char*, my_string_arg</span><br=
>
<span style=3D"background:white">&nbsp;&nbsp;),</span><br>
<span style=3D"background:white">&nbsp;&nbsp;TP_FIELDS(</span><br>
<span style=3D"background:white">&nbsp;&nbsp;ctf_string(my_string_field, my=
_string_arg)</span><br>
<span style=3D"background:white">&nbsp;&nbsp;ctf_integer(int, my_integer_fi=
eld, my_integer_arg)</span><br>
<span style=3D"background:white">&nbsp;&nbsp;)</span><br>
<span style=3D"background:white">&nbsp;&nbsp;)</span><br>
<span style=3D"background:white">&nbsp;</span><br>
<span style=3D"background:white">&nbsp;&nbsp;How to use these in the code:<=
/span><br>
<span style=3D"background:white">&nbsp;</span><br>
<span style=3D"background:white">&nbsp;&nbsp;tracepoint(provider_name_test,=
 tp_name_tp,23 )</span><br>
<span style=3D"background:white">&nbsp;</span><br>
<span style=3D"background:white">&nbsp;&nbsp;tracepoint(provider_name_test,=
 tp_name_tp,&quot;hi there&quot; )</span><br>
<span style=3D"background:white">&nbsp;</span><br>
<span style=3D"background:white">&nbsp;&nbsp;tracepoint(provider_name_test,=
 tp_name_tp,23, &quot;hi there&quot; )</span><br>
<span style=3D"background:white">&nbsp;</span><br>
<span style=3D"background:white">&nbsp;</span><br>
<span style=3D"background:white">&nbsp;</span></span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"NL" style=3D"font-family:&quot;Arial&q=
uot;,&quot;sans-serif&quot;">Best regards / Met vriendelijke groet / Cordia=
lement,</span><b><span style=3D"font-family:&quot;Arial&quot;,&quot;sans-se=
rif&quot;"><o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:9.0pt;font-family:&quot;=
Verdana&quot;,&quot;sans-serif&quot;"><o:p>&nbsp;</o:p></span></b></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,&quot;sans-serif&quot;">Farhan Shariff
<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;">EUV Source Software Facilites
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;">Development &amp; Engineering
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,&quot;sans-serif&quot;">ASML Netherlands B.V. | De Run 6501 | 5504=
 DR Veldhoven | The Netherlands<br>
Location: 7G2 | Tel: &#43;31 619084549</span><span style=3D"font-size:8.0pt=
"><br>
</span><span style=3D"font-size:8.0pt;font-family:&quot;Arial&quot;,&quot;s=
ans-serif&quot;"><a href=3D"farhan.shariff@asml.com%20"><span style=3D"colo=
r:blue">farhan.shariff@asml.com</span></a> |
<a href=3D"http://www.asml.com/"><span style=3D"color:blue">www.asml.com</s=
pan></a></span><span style=3D"font-size:8.0pt"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
-- The information contained in this communication and any attachments is c=
onfidential and may be privileged, and is for the sole use of the intended =
recipient(s). Any unauthorized review, use, disclosure or distribution is p=
rohibited. Unless explicitly stated
 otherwise in the body of this communication or the attachment thereto (if =
any), the information is provided on an AS-IS basis without any express or =
implied warranties or liabilities. To the extent you are relying on this in=
formation, you are doing so at your
 own risk. If you are not the intended recipient, please notify the sender =
immediately by replying to this message and destroy all copies of this mess=
age and any attachments. The sender nor the company/group of companies he o=
r she represents shall be liable
 for the proper and complete transmission of the information contained in t=
his communication, or for any delay in its receipt.
</body>
</html>

--_000_D199CBB1905D6A4E83FFCD29C335DF4C3B69BA49NLEIDX740sneuas_--


--===============1239473379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1239473379==--
