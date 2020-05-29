From: Aprameya Rao via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Using LTTng for an application with a single thread per
 core
Date: Fri, 29 May 2020 04:20:47 +0000
Message-ID: <MW2PR2101MB1098270C4CF4CBFA31AC2E0C818F0@MW2PR2101MB1098.namprd21.prod.outlook.com>
Reply-To: Aprameya Rao <Aprameya.Rao@microsoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0538259138782452663=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770092.outbound.protection.outlook.com [40.107.77.92])
 by lists.lttng.org (Postfix) with ESMTPS id 49YBFY5jwRz1JrT
 for <lttng-dev@lists.lttng.org>; Fri, 29 May 2020 00:20:49 -0400 (EDT)
Content-Language: en-US
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

--===============0538259138782452663==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MW2PR2101MB1098270C4CF4CBFA31AC2E0C818F0MW2PR2101MB1098_"

--_000_MW2PR2101MB1098270C4CF4CBFA31AC2E0C818F0MW2PR2101MB1098_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi

I am working on an application where I have a single thread per core (the a=
pplication is based on top of SPDK - https://spdk.io/). Ideally, I would li=
ke to have a set of buffers allocated per core and since there is a single =
thread it can write the trace event to this buffer directly with no synchro=
nization. Once the buffer is filled up, the buffer can be given to LTTng to=
 take care of the persistence.

I'm looking at the LTTng code to figure out what kind of changes would need=
 to be made to support something like this. I imagine it would need to chan=
ge the ring buffer because the configuration for that while tunable does no=
t have any mode which does what I want. Am I looking in the right place? If=
 you can provide me to pointers on how I can prototype this with lttng that=
 would be most helpful. Once I have it prototyped, I would be happy to work=
 with you on making these changes back into LTTng if you feel that this wou=
ld be of value to other users as well.

Regards
Aprameya


--_000_MW2PR2101MB1098270C4CF4CBFA31AC2E0C818F0MW2PR2101MB1098_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
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
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am working on an application where I have a single=
 thread per core (the application is based on top of SPDK -
<a href=3D"https://spdk.io/">https://spdk.io/</a>). Ideally, I would like t=
o have a set of buffers allocated per core and since there is a single thre=
ad it can write the trace event to this buffer directly with no synchroniza=
tion. Once the buffer is filled up,
 the buffer can be given to LTTng to take care of the persistence.<o:p></o:=
p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;m looking at the LTTng code to figure out wh=
at kind of changes would need to be made to support something like this. I =
imagine it would need to change the ring buffer because the configuration f=
or that while tunable does not have any
 mode which does what I want. Am I looking in the right place? If you can p=
rovide me to pointers on how I can prototype this with lttng that would be =
most helpful. Once I have it prototyped, I would be happy to work with you =
on making these changes back into
 LTTng if you feel that this would be of value to other users as well.<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Aprameya<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MW2PR2101MB1098270C4CF4CBFA31AC2E0C818F0MW2PR2101MB1098_--

--===============0538259138782452663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0538259138782452663==--
