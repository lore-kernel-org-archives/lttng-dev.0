From: "Schickentanz, Thomas" <thomas.schickentanz@harman.com>
Subject: Tracing directly into shared memory
Date: Mon, 4 Mar 2019 09:28:00 +0000
Message-ID: <54c5b5d42fb8448298afc17af0513b6b__22380.5238887266$1551710538$gmane$org@HIMDWSMB04.ad.harman.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1027215190734565267=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail1.bemta24.messagelabs.com (mail1.bemta24.messagelabs.com
 [67.219.250.211])
 by lists.lttng.org (Postfix) with ESMTP id 44CZT171kvz12GJ
 for <lttng-dev@lists.lttng.org>; Mon,  4 Mar 2019 04:28:21 -0500 (EST)
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

--===============1027215190734565267==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_54c5b5d42fb8448298afc17af0513b6bHIMDWSMB04adharmancom_"

--_000_54c5b5d42fb8448298afc17af0513b6bHIMDWSMB04adharmancom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

My idea is to pre-allocate memory on system startup which can later be used=
 by lttng for tracing. It should work like flight recorder mode without ext=
racting data from ringbuffers to trace file while recording data. Data extr=
action of shm ringbuffers should be done when recording has been finished.
As per documention with option `--shm-path' ringbuffer for tracing can be c=
reated in shared memory. With lttng-crash data can be extracted from ringbu=
ffer.
Can this option be used with shared memory in volatile memory (default ram)=
, too? And is it possible to record kernel space traces with this option?
I tried

lttng create testshm --shm-path=3D/dev/shm --snapshot
lttng enable-channel c0 -s testshm -k
lttng enable-event -s testshm -c c0 -k -a
lttng start
lttng stop
lttng-crash -extract=3D/home/test /dev/shm

With lttng and lttng-crash everything seems to work fine (no error messages=
).
However the extract folder keeps empty.
Has someone researched into this option and can help to clarify the points?

Thanks,
Thomas

--_000_54c5b5d42fb8448298afc17af0513b6bHIMDWSMB04adharmancom_
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
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
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
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"DE" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt">Hi all,<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt">My i=
dea is to pre-allocate memory on system startup which can later be used by =
lttng for tracing. It should work like flight recorder mode without extract=
ing data from ringbuffers to trace file
 while recording data. Data extraction of shm ringbuffers should be done wh=
en recording has been finished.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt"><o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt">As p=
er documention with option
</span><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-family:&quot;Cou=
rier New&quot;">`--shm-path&#8216;</span><span lang=3D"EN-US" style=3D"font=
-size:12.0pt"> ringbuffer for tracing can be created in shared memory. With
</span><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-family:&quot;Cou=
rier New&quot;">lttng-crash</span><span lang=3D"EN-US" style=3D"font-size:1=
2.0pt"> data can be extracted from ringbuffer.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt">Can =
this option be used with shared memory in volatile memory (default ram), to=
o? And is it possible to record kernel space traces with this option?<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt">I tr=
ied <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&quot;Courier New&quot;">lttng create testshm --shm-path=3D/dev/shm =
--snapshot<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&quot;Courier New&quot;">lttng enable-channel c0 -s testshm -k<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&quot;Courier New&quot;">lttng enable-event -s testshm -c c0 -k -a<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&quot;Courier New&quot;">lttng start<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&quot;Courier New&quot;">lttng stop<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&quot;Courier New&quot;">lttng-crash -extract=3D/home/test /dev/shm<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt">With=
 lttng and lttng-crash everything seems to work fine (no error messages).<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt">Howe=
ver the extract folder keeps empty.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt">Has =
someone researched into this option and can help to clarify the points?<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:DE"><o:p>&nbsp;<=
/o:p></span></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Thomas<o:p></o:p></p>
</div>
</body>
</html>

--_000_54c5b5d42fb8448298afc17af0513b6bHIMDWSMB04adharmancom_--

--===============1027215190734565267==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1027215190734565267==--
