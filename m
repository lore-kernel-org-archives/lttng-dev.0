Return-Path: <SRS0=d4Wd=ET=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9826CC388F7
	for <lttng-dev@archiver.kernel.org>; Fri, 13 Nov 2020 09:28:37 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B5D2145D
	for <lttng-dev@archiver.kernel.org>; Fri, 13 Nov 2020 09:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="Zru3zK97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B5D2145D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CXY763Db9z1HWV;
	Fri, 13 Nov 2020 04:28:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1605259715;
	bh=9nRNZqpkTYAOzqIxZYaPY4STlCfpDou5s03eg+W1Ybs=;
	h=To:CC:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=Zru3zK97HivBMH5Wf0UnDu901bebvrorjGiMoHNr4Ak7kChxgUZH89MlrlN1H2Bca
	 ddwrmBjRbAupgSkdiOOEjhh1otb+CPuSi+2WG1RXmMVq+0XnMJyTBJFPn0F8uLCjb2
	 H+hH0+V1Mex1PyC+zWwCZr0g22X3taWREiLHBln4wGH8JwhzUE9WstfKxprAb1AVTH
	 czBlGtY2KnS+Wjxtc65JjdYwhtv5OJeTALniXfj3iO0qdj1aZcsS0zdmRQgB+IaIEr
	 pkHdIga7soQNoexAcxZqCiYd/bgoXPgXI7EYL0FXDhz24Lz5fnVkUQW4gv1LVb4V1W
	 xsCdGSf34ZM9w==
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by lists.lttng.org (Postfix) with ESMTPS id 4CXY726bfgz1HQv
 for <lttng-dev@lists.lttng.org>; Fri, 13 Nov 2020 04:28:30 -0500 (EST)
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CXY6l3FDzzXm6k;
 Fri, 13 Nov 2020 17:28:15 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 13 Nov 2020 17:28:23 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Fri, 13 Nov 2020 17:28:23 +0800
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>,
 "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>
CC: Hushiyuan <hushiyuan@huawei.com>
Thread-Topic: [lttng-dev] [PATCH] README: fix typo in README.md
Thread-Index: Ada5nzno1TkUN+DwSVu16JhN3Od9eA==
Date: Fri, 13 Nov 2020 09:28:23 +0000
Message-ID: <3f94d86a19ef4d3d84487768fde3d7b1@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.176.87]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Subject: [lttng-dev] [PATCH] README: fix typo in README.md
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: "wangshuo \(AF\) via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "wangshuo \(AF\)" <wangshuo47@huawei.com>
Content-Type: multipart/mixed; boundary="===============3866541178003104115=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3866541178003104115==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_3f94d86a19ef4d3d84487768fde3d7b1huaweicom_"

--_000_3f94d86a19ef4d3d84487768fde3d7b1huaweicom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

README: fix typo in README.md

Signed-off-by: Shuo Wang <wangshuo47@huawei.com<mailto:wangshuo47@huawei.co=
m>>
---
README.md | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 2d6dcaa..dd7ebd1 100644
--- a/README.md
+++ b/README.md
@@ -388,7 +388,7 @@ For always-on debugging self-checks:
       ./configure --enable-rcu-debug

 For fine grained enabling of debugging self-checks, build
-urserspace-rcu with DEBUG_RCU defined and compile dependent
+userspace-rcu with DEBUG_RCU defined and compile dependent
applications with DEBUG_RCU defined when necessary.

 Warning: Enabling this feature result in a performance penalty.
--
2.23.0


--_000_3f94d86a19ef4d3d84487768fde3d7b1huaweicom_
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
	{font-family:\5B8B\4F53;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@\5B8B\4F53";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Calibri",sans-serif;}
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
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"text-justi=
fy-trim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">README: fix typo in README.md<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Signed-off-by: Shuo Wang &lt;<a=
 href=3D"mailto:wangshuo47@huawei.com">wangshuo47@huawei.com</a>&gt;<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">---<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">README.md | 2 &#43;-<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">1 file changed, 1 insertion(&#4=
3;), 1 deletion(-)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/README.md b/README=
.md<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 2d6dcaa..dd7ebd1 100644<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/README.md<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/README.md<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -388,7 &#43;388,7 @@ For alw=
ays-on debugging self-checks:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; ./configure --enable-rcu-debug<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;For fine grained enabling=
 of debugging self-checks, build<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-urserspace-rcu with DEBUG_RCU =
defined and compile dependent<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;userspace-rcu with DEBUG_R=
CU defined and compile dependent<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">applications with DEBUG_RCU def=
ined when necessary.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;Warning: Enabling this fe=
ature result in a performance penalty.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-- <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2.23.0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_3f94d86a19ef4d3d84487768fde3d7b1huaweicom_--

--===============3866541178003104115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3866541178003104115==--
