From: David OShea <David.OShea@quantum.com>
Subject: LTTng-UST and "ip" context
Date: Mon, 3 Mar 2014 22:24:55 +0000
Message-ID: <20998D40D9A2B7499CA5A3A2666CB1EB2A67A5D3__33675.9794773117$1393885571$gmane$org@ZURMSG1.QUANTUM.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1635395948=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0a-000ceb01.pphosted.com ([67.231.144.126])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=3139b4a6c6=david.oshea@quantum.com>)
	id 1WKbIB-0000ag-Hy
	for lttng-dev@lists.lttng.org; Mon, 03 Mar 2014 17:25:05 -0500
Received: from pps.filterd (m0030277 [127.0.0.1])
	by mx0a-000ceb01.pphosted.com (8.14.5/8.14.5) with SMTP id
	s23MMsKQ027822
	for <lttng-dev@lists.lttng.org>; Mon, 3 Mar 2014 14:24:58 -0800
Received: from ppoxedge1.quantum.com ([146.174.252.27])
	by mx0a-000ceb01.pphosted.com with ESMTP id 1jd0uqra12-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <lttng-dev@lists.lttng.org>; Mon, 03 Mar 2014 14:24:58 -0800
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1635395948==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_20998D40D9A2B7499CA5A3A2666CB1EB2A67A5D3ZURMSG1QUANTUMc_"

--_000_20998D40D9A2B7499CA5A3A2666CB1EB2A67A5D3ZURMSG1QUANTUMc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

Apologies if this is a stupid question, but is the "ip" context meant to be=
 used with LTTng-UST?  I tried it out, and the address in the field pointed=
 to the TRACEPOINT_EVENT definition in my header file, i.e. not to the trac=
epoint() call site.  Could this be due to the fact that I use dynamic trace=
 providers, could it be due to my compile options, or is this only meant fo=
r kernel tracing?

This is with the following (with some minor patches, so admittedly it could=
 be my fault) on CentOS 6:
babeltrace-1.1.2
lttng-tools-2.3.2
lttng-ust-2.3.2
userspace-rcu-0.8.3

Thanks in advance,
David

----------------------------------------------------------------------
The information contained in this transmission may be confidential. Any dis=
closure, copying, or further distribution of confidential information is no=
t permitted unless such privilege is explicitly granted in writing by Quant=
um. Quantum reserves the right to have electronic communications, including=
 email and attachments, sent across its networks filtered through anti viru=
s and spam software programs and retain such messages in order to comply wi=
th applicable data security and retention requirements. Quantum is not resp=
onsible for the proper and complete transmission of the substance of this c=
ommunication or for any delay in its receipt.

--_000_20998D40D9A2B7499CA5A3A2666CB1EB2A67A5D3ZURMSG1QUANTUMc_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii">
<meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
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
<body lang=3D"EN-AU" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi all,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Apologies if this is a stupid question, but is the &=
#8220;ip&#8221; context meant to be used with LTTng-UST?&nbsp; I tried it o=
ut, and the address in the field pointed to the TRACEPOINT_EVENT definition=
 in my header file, i.e. not to the tracepoint() call
 site.&nbsp; Could this be due to the fact that I use dynamic trace provide=
rs, could it be due to my compile options, or is this only meant for kernel=
 tracing?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This is with the following (with some minor patches,=
 so admittedly it could be my fault) on CentOS 6:<o:p></o:p></p>
<p class=3D"MsoNormal">babeltrace-1.1.2<o:p></o:p></p>
<p class=3D"MsoNormal">lttng-tools-2.3.2<o:p></o:p></p>
<p class=3D"MsoNormal">lttng-ust-2.3.2<o:p></o:p></p>
<p class=3D"MsoNormal">userspace-rcu-0.8.3<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks in advance,<br>
David<o:p></o:p></p>
</div>

<HR>The information contained in this transmission may be confidential. Any=
 disclosure, copying, or further distribution of confidential information i=
s not permitted unless such privilege is explicitly granted in writing by Q=
uantum. Quantum reserves the right to have electronic communications, inclu=
ding email and attachments, sent across its networks filtered through anti =
virus and spam software programs and retain such messages in order to compl=
y with applicable data security and retention requirements. Quantum is not =
responsible for the proper and complete transmission of the substance of th=
is communication or for any delay in its receipt.<BR>
</body>
</html>

--_000_20998D40D9A2B7499CA5A3A2666CB1EB2A67A5D3ZURMSG1QUANTUMc_--


--===============1635395948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1635395948==--
