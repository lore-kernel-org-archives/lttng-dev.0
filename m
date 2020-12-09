Return-Path: <SRS0=Hq7A=FN=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691F3C4361B
	for <lttng-dev@archiver.kernel.org>; Wed,  9 Dec 2020 15:01:18 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F62D23A5A
	for <lttng-dev@archiver.kernel.org>; Wed,  9 Dec 2020 15:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F62D23A5A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CrgGz4h0xz1WBP;
	Wed,  9 Dec 2020 10:01:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1607526076;
	bh=r/K2qILd/T4yLBFVW4xeQ6CvTUVNYIFaNhM1nWe8Tfg=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=OzbxZ8VZrXdglwP1iNNbiZCEzBUFnRpnFnvlzHx6IkyXdeDIP2wMne6pTAOFkKywF
	 uwb8mvk01MFCKpY24yNS0kjZQImHiZ8c8oHkznAQnwKzR0FLoRCBXtnyM/vX5ugbpw
	 0i34QiJoPBYjSyJuRc5gGhy+Mh0KdrzDLjiAY9xWTVZuzHuvW6JSH1kOcfXgD/It7A
	 vxGd8t+2xbemcJxG7sUtWgYZxsW6M0G0nvJkEXFTOStBDfWMQEuLjMy1PQeRRxYtXR
	 Z5NXV6eppfLPOD6alXXXXNoxkIJPzrjhxN0lAzUnRO4NEkisuo80kzXCv6l2utRTh3
	 Hdr+PGWfmlb3w==
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2115.outbound.protection.outlook.com [40.107.22.115])
 by lists.lttng.org (Postfix) with ESMTPS id 4CrYN84264z1W3L
 for <lttng-dev@lists.lttng.org>; Wed,  9 Dec 2020 05:35:20 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xx9aeA6x90NoxTnBQ1iGPJYxzvNX1q6h4iia3wpk9nehpOqt3RcZdaW0lzW9buBmhblMhcBu/WmKYW0quLt0SMeeoBfdLJVmHlHqhYyVJTMvW4x2FReR3FtXcMB2dtcig0R27EMv/JgLPYc576bFrC6z2oFvpSmkACvN5xM47HzR7oxdM6tYBgHjGO44bmH5lbdTil74nBQn7y1lpO1k3cGd7QSlJm7Q2Fir74qHc4qddhPoYBIcfkf3IftpqsbV680gvjINTG+Gg5fHUBZqGRqVPftdUprXZfunQEUj8TicsVRdCyX3PeQ41isp4le5N5tmk36K5J0il/EyPIjYZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//rAt2SBwJ8baQ3K8JNmywxK0UDjgywaLSjdBVDiX7Y=;
 b=HKIjfbJdZpdW3yYl2ydpVehCyhmzXp+uElrXCFT+2ui8JGAGaUK5HjPwWYn9z9/jEVJ3Yhh/Rvk/nX1lMuWQEhl4VfKtUm3P9vf6udwNSY2MnZBGKMEGl4dYDEu4HXUG2u1hf0lV5Ztzbtov/CqAlKQxlb6QyTrnjXtlI1VP0Akx3Sq/+U9rA8yo6+lBVp6d/UgpZ8UN1017/kt6DInP8hNH1MqAWJRlM3EHK4RNHY9L2jO0ojkb3xGHXvZuyx6y3m/7Gskw83abs/lQyc7MmsWevCTTYcS3+HKwWmhsuKqyhQullgqtD+HiFr7NNNpBa7xrTk64HsQJJO3G4zHKKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
Received: from (2603:10a6:802:7e::23) by
 VI1PR83MB0238.EURPRD83.prod.outlook.com (2603:10a6:802:78::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.2; Wed, 9 Dec 2020 10:35:12 +0000
Received: from VI1PR83MB0304.EURPRD83.prod.outlook.com
 ([fe80::7160:d26b:3cf8:de01]) by VI1PR83MB0304.EURPRD83.prod.outlook.com
 ([fe80::7160:d26b:3cf8:de01%11]) with mapi id 15.20.3654.012; Wed, 9 Dec 2020
 10:35:12 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: lttng-ust callback on trace start
Thread-Index: AdbOFnXJnK7W6P6xS0eXkM9vwDxk7A==
Date: Wed, 9 Dec 2020 10:35:11 +0000
Message-ID: <VI1PR83MB03043DB4661F69C45DE0C6119BCC1@VI1PR83MB0304.EURPRD83.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=282a735a-4a91-4652-8d0e-7b3b936b9e00;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-09T10:31:17Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-originating-ip: [84.136.107.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2c0fb85b-eb3f-4c4a-aba8-08d89c2e1bbf
x-ms-traffictypediagnostic: VI1PR83MB0238:
x-microsoft-antispam-prvs: <VI1PR83MB0238C897534AD6A540F1F2BE9BCC1@VI1PR83MB0238.EURPRD83.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JhGT4ljmRL0ZjotAOzmDTrY9YIYSj+eaMiUlvuCPubWo76hWwEdcqpgcR+dRcQdkETT7x0f2FhLhMmZ6Sr1e/RPLT1byPF+8ekYxhnFWWH4k1eKrNkRyajGrf+1MrjoZidcW8ZjmNi57+peuzNsxXr9jdEcc1NckW8waaqdwT0UCE771SFIHK0J2a7MfqacpKZlX2ytJ8yMJflTvlQ6iMm+4hll3yG+M5JTVvdGYx0zPNqJx6VxCoFSNw6mznztKv93JS2au2icY9SsnGyttQDwhnnLDVJ/jSgZdJH2BPbqPYMdPqTvZk26evqQrmsrO2Eoxq/nmEbBrHBp+tQf7Jw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR83MB0304.EURPRD83.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(366004)(26005)(76116006)(66476007)(2906002)(66946007)(66556008)(66446008)(64756008)(86362001)(8990500004)(10290500003)(83380400001)(71200400001)(82950400001)(82960400001)(508600001)(5660300002)(7696005)(9686003)(6916009)(8936002)(52536014)(55016002)(6506007)(186003)(33656002)(4744005)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ULlYr0ic7nJxpPwmGbmzIu0nDJCuy2lal/gT7SsYqkE1i3q4oMpem6y4cyQQ?=
 =?us-ascii?Q?LcJbX/g5IdU+AhxdePRazUvuNjvSZft/eb4uNtFo0e3vLDMDJEapkZvl9GUj?=
 =?us-ascii?Q?bg9gtxQAWsXyCon1X1e3x0OpDMNc1652tgVE6w8fs/Xzbl9QNdpOSv9kRD2m?=
 =?us-ascii?Q?oUJOt6G/hjOcROIRbOoxQimJxS5+BQ9/x9o2l+4F0M11qdrrUxPXDJ5pU/HT?=
 =?us-ascii?Q?KJ5j9byVMuzA1SBbrLBteom/6cTBP9aBQYb+mZwracO5/4fmkdagVVHHImUM?=
 =?us-ascii?Q?fNNEzKD+M6BwEwyguAu0HzGNZg8C+quQSb3OOjTDe1biI6DvTqIdnJ+Zshid?=
 =?us-ascii?Q?yEJP9EzSwBL7zPa66fdgeSsDgAebxQfKA0bjfyVdp6dZGxpFujhTnjyuFn6N?=
 =?us-ascii?Q?g83xDX+/0+BOkds1s5nFmOCRdr21n1/S1Y+y1IAoC0sU24B1yR3cVVyyZGpJ?=
 =?us-ascii?Q?ZvHQOy1rSbA+iBJRjrFik1ORixzhsb+6XDX50LfjhebcpMwqLL/4ML4eDbZN?=
 =?us-ascii?Q?Xn2JXEO1aqZWxXaaDOyzxs4JxN1Jj1SEnJ1ok+xoe/B4Z0Gx60eg5A7lp44g?=
 =?us-ascii?Q?+MBjQw/6HDN6Lk60p3lwZ30jkgHgqfviElV9wAQRMkdyuf0QrY6GlwzOU0nn?=
 =?us-ascii?Q?6HNzQ1naCL3rRaeFpDOwByw+hXi93OSaN5DAOfgXsdlDiOaS3C1DFd5dg2Nc?=
 =?us-ascii?Q?T6ySUt6rpQv3GM9NYC6kWjJP8li0OU4CcEYDpedmhRaI+dln9OOQtoWjew9O?=
 =?us-ascii?Q?AwWCyefjNeX6V/ZenUPWSgg20UeY0DTOvive80JXgLYf5+vvIkx72AGhIA+o?=
 =?us-ascii?Q?WWycIGbwLbkVBf3deprY+/B3xwW0goxSv0t4EQBgvbz6QsaPvruGnGOc7jSr?=
 =?us-ascii?Q?HRtvAJL/PF7k4jZtE3GHEi2VXPS2DZBlpCjw4NuyMRrHpSCULlARHPf0Bbmv?=
 =?us-ascii?Q?y8VhA94VYW1QUHkY2OdZaR80RzebON+iOW9VSY0KXLs=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR83MB0304.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0fb85b-eb3f-4c4a-aba8-08d89c2e1bbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 10:35:11.9310 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TDdN2BAlcDeiercgbw9MG1z77Z6fEAXTsReLsCLqS9Wxq9r4SaeajGcTefV4GAnrMGuWTanegq/lrXD4jC7SfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR83MB0238
X-Mailman-Approved-At: Wed, 09 Dec 2020 10:01:13 -0500
Subject: [lttng-dev] lttng-ust callback on trace start
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
From: Benjamin Thaut via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Benjamin Thaut <Benjamin.Thaut@microsoft.com>
Content-Type: multipart/mixed; boundary="===============1137312241743210371=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============1137312241743210371==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_VI1PR83MB03043DB4661F69C45DE0C6119BCC1VI1PR83MB0304EURP_"

--_000_VI1PR83MB03043DB4661F69C45DE0C6119BCC1VI1PR83MB0304EURP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I searched the documentation and the source code for a while but didn't fin=
d anything,
is there any way to get a callback using the lttng-ust library when tracing=
 starts? E.g. I don't want to poll if a certain tracepoint is enabled. I wa=
nt to get notified when any tracing starts. A notification when a specific =
tracepoint is enabled would also be sufficient.

-Ben

--_000_VI1PR83MB03043DB4661F69C45DE0C6119BCC1VI1PR83MB0304EURP_
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
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:70.85pt 70.85pt 56.7pt 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"DE" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:bre=
ak-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I searched the documentation an=
d the source code for a while but didn&#8217;t find anything,<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">is there any way to get a callb=
ack using the lttng-ust library when tracing starts? E.g. I don&#8217;t wan=
t to poll if a certain tracepoint is enabled. I want to get notified when a=
ny tracing starts. A notification when a specific
 tracepoint is enabled would also be sufficient.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-Ben<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_VI1PR83MB03043DB4661F69C45DE0C6119BCC1VI1PR83MB0304EURP_--

--===============1137312241743210371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1137312241743210371==--
