Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDFDC00140
	for <lttng-dev@archiver.kernel.org>; Wed, 10 Aug 2022 13:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1660139685;
	bh=ZrXTUWlnXFH6WttUHQ6kguUHW1d3YUgooMUAxL+LPtw=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=ABoTGVJGeH3uTlcTn+jbhcYo/38+VNP2KJa33wweCaOZadr+8w3WUrsoHQJZN8iED
	 Y4/ZRjI6X9R/iWP3NgI5N40n9ixm8lqHsXkeJXLfyWoYB69W4QDNDa+Cd43Ir23Pqi
	 /GWBHk+2XYuhnWvt5Ta0Lp5GqdqAV1cLteqVUP8QoYurmqX5q0GOwPMJMRqCyyZceU
	 JfFJu6hsOs6R98JkIb7Y7z/eD973zJSYB9WjRrLdYOGKd04jkSM6sonTB1AwBcpvLy
	 fc0vIvWx2WIaMNKVmP2mDtKDdsO/w+Zt9xEUXehjFpa7MGnxr4noyrYBVuCRyzdAzf
	 SowDqSIXKz5Rw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4M2rz86b8yz1CtV;
	Wed, 10 Aug 2022 09:54:44 -0400 (EDT)
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
 by lists.lttng.org (Postfix) with ESMTP id 4M2h8V2N3zz1Bym
 for <lttng-dev@lists.lttng.org>; Wed, 10 Aug 2022 03:17:14 -0400 (EDT)
Received: from [IPv6:::ffff:192.168.0.112] (unknown [27.18.122.44])
 by smtp7 (Coremail) with SMTP id C8CowADnYYneV_Ni56_vTQ--.53892S2;
 Wed, 10 Aug 2022 15:01:51 +0800 (CST)
MIME-Version: 1.0
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Date: Wed, 10 Aug 2022 15:01:51 +0800
Importance: normal
X-Priority: 3
X-CM-TRANSID: C8CowADnYYneV_Ni56_vTQ--.53892S2
Message-Id: <62F357DF.2973D3.13514@m12-11.163.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RqXd8UUUUU
X-Originating-IP: [27.18.122.44]
X-CM-SenderInfo: xgdq3vdixziiqr6rljoofrz/1tbiUR9ZhGDEO2k2cgAAsh
X-Mailman-Approved-At: Wed, 10 Aug 2022 09:54:42 -0400
Subject: [lttng-dev] babeltrace2 python api related question
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: zenan via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: zenan <dantefu9001@163.com>
Content-Type: multipart/mixed; boundary="===============7392528702799242094=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============7392528702799242094==
Content-Type: multipart/alternative;
	boundary="_4D0103B6-3135-4E6D-B50A-1BF1E17833F7_"

--_4D0103B6-3135-4E6D-B50A-1BF1E17833F7_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"


Hi there,=20
I=E2=80=99m trying to use babeltrace2 python bindings to track live lttng t=
race, as shown in some examples in the documents, I tried to use ctf.lttng-=
live( ctf.fs in the documents) plugin as source, and use text.pretty as sin=
k, but it didn=E2=80=99t work out as I expected.  So does the api support t=
racking live lttng trace and print them out yet?


Yours sincerely=20

--_4D0103B6-3135-4E6D-B50A-1BF1E17833F7_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="utf-8"

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta ht=
tp-equiv=3DContent-Type content=3D"text/html; charset=3Dutf-8"><meta name=
=3DGenerator content=3D"Microsoft Word 15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:DengXian;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
.MsoChpDefault
	{mso-style-type:export-only;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style></head><body lang=3DZH-CN link=3Dblue vlink=3D"#954F72" style=3D=
'word-wrap:break-word'><div class=3DWordSection1><p class=3DMsoNormal><span=
 lang=3DEN-US style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></p><p cla=
ss=3DMsoNormal><span lang=3DEN-US>Hi there, </span></p><p class=3DMsoNormal=
><span lang=3DEN-US>I=E2=80=99m trying to use babeltrace2 python bindings t=
o track live lttng trace, as shown in some examples in the <a href=3D"https=
://babeltrace.org/docs/v2.0/python/bt2/examples.html#build-and-run-a-trace-=
processing-graph">documents</a>, I tried to use ctf.lttng-live( ctf.fs in t=
he documents) plugin as source, and use text.pretty as sink, but it didn=E2=
=80=99t work out as I expected. =C2=A0So does the api support tracking live=
 lttng trace and print them out yet?</span></p><p class=3DMsoNormal><span l=
ang=3DEN-US style=3D'font-size:12.0pt;font-family:SimSun'><o:p>&nbsp;</o:p>=
</span></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0p=
t;font-family:SimSun'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><spa=
n lang=3DEN-US style=3D'font-size:12.0pt;font-family:SimSun'>Yours sincerel=
y </span></p></div></body></html>=

--_4D0103B6-3135-4E6D-B50A-1BF1E17833F7_--


--===============7392528702799242094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7392528702799242094==--

