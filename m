Return-Path: <SRS0=sJ7O=7L=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBD0C433DF
	for <lttng-dev@archiver.kernel.org>; Fri, 29 May 2020 04:20:54 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD3C82074D
	for <lttng-dev@archiver.kernel.org>; Fri, 29 May 2020 04:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="JmSFsLhx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3C82074D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49YBFb6X5Qz1JZ8;
	Fri, 29 May 2020 00:20:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1590726052;
	bh=v1oYsbPkIftXWFuPSGmmKfcWBmwCOm7Wn6gSVYFpNGQ=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=JmSFsLhx+m4HGz2soUCf843kYYrnHgi2tigAu2XltyMQA0AvsJKH8JEtBxAjGdoxG
	 gt9w7bmemxChZjmpu0wrFovvmry5edVU6UnIElSmwXYGM6ujxrutgIssUJwYfs+WDc
	 3cFwBJfGcCNyktJbEylYu08ieAZukaQhOHppuAyySL12EkjQx2rh2b+XlB+RA/Lnyq
	 xtfbL2Zp6zMQfxwWt199wNOUe4HXuvs/fPB5DT9Uycye70O7a7dwUKfkVgTeYuu9SU
	 VuSUIFyiLFa/RofAFFHDfX9SgPJq9hq4/uMS0UjCG+NToJ7S3pcOq99uk7YMsMf4zI
	 IsNbQSe+uDH+A==
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770092.outbound.protection.outlook.com [40.107.77.92])
 by lists.lttng.org (Postfix) with ESMTPS id 49YBFY5jwRz1JrT
 for <lttng-dev@lists.lttng.org>; Fri, 29 May 2020 00:20:49 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJvsrTmiTsEfemBD7Y1XT1qaY+ZM7uXBN1GBsOMYii5p1YzNu9lGpJQ0bAttggSQvNQdxqm/kuksNqkrHivFqftp9NsIQR6nvAqhyYgf0Ga0pEa+CJjIKGJKcpMn4L1aPbWigGlYNgRLNSfw53y9sS05CH9O9pSMz4n0TzDqiP36YlpO0LxKkxTsgIm6woRqVZJIfTbSxH1Ly3zWdpWXavGwHjWfu/aeBIQJWd2C9FhHFcZNAmdpbzocUF9w2cM1fWXPCwRMCovfpfm1M29xhsMl8mX0/hfrrJfXjF+XdtdsV1+VrOjCBAqJ/bx5Rv35eGn0SNEKypS8zFC6LlCVJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSLLp/jxe50+jzJ26gZR13qzLBOb2JpGTIY61yRsW7E=;
 b=UHoXvGlmULvDLiGLMpe09ZehFU2FZNyIcMR6HORp9th+cOVe5lgfssPJWeSq11Xt4l8ezGMP4Q4QprgPEOQoVoiJg2mPqBeuGMCho3432Aylq2clvNxp4tnBhj94F10w5Gek0V7hIHc6zakRipEWKBRJN91G/I+xBGPyQAbWSaMqpeLbrF1aaEpzgC4FkFfVrED9s6tec0+7qPvHqpsEpe9NhX3ys2TZSld0YqsLzpOW27AiyL9dBFDcX7GY9e6h26X3cVXpQk7edJhpovD/fJR9zY94TKtEPr7lOqfgT68jiB7kgvKNulhzPd9eBYbCKEBDIG5q6Gwrg94bkDNGgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
Received: from MW2PR2101MB1098.namprd21.prod.outlook.com (2603:10b6:302:a::27)
 by MWHPR21MB0864.namprd21.prod.outlook.com (2603:10b6:300:77::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.3; Fri, 29 May
 2020 04:20:47 +0000
Received: from MW2PR2101MB1098.namprd21.prod.outlook.com
 ([fe80::4117:6030:b7c9:3ccb]) by MW2PR2101MB1098.namprd21.prod.outlook.com
 ([fe80::4117:6030:b7c9:3ccb%4]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 04:20:47 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: Using LTTng for an application with a single thread per core
Thread-Index: AdY1M3Uj1EXccs72RTSAHHqxkjE0yA==
Date: Fri, 29 May 2020 04:20:47 +0000
Message-ID: <MW2PR2101MB1098270C4CF4CBFA31AC2E0C818F0@MW2PR2101MB1098.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [50.35.65.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5188121-6cd7-4f6c-f3be-08d80387a9f1
x-ms-traffictypediagnostic: MWHPR21MB0864:
x-microsoft-antispam-prvs: <MWHPR21MB0864CDE01EEC3FEDC6845167818F0@MWHPR21MB0864.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04180B6720
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i4ifpGiuMLBAo1ssymCE1ij7UmgMriET/yAKcoIMOTFA9hLKKQGl5IdGqeMzIaScab2oI6DiSDuz77/hTGfkGn7sLR0tTBRTKiROsIIJbTLZP6D8vUt1pLSbD/rTib/Zkx1LcKhjRmYMIK9OyV4YzA37HvEsLkuzJB61WCQDxBMNDWy5LFLVzli1XUsU6QV1PxtV3BywLEImeJuyZUrdNxBCENWqMww3ifPijL7wVrhWWZd8lhixX5hRh+K0Ni1HOjR1HH/h6OqsF2wDG/OLQNrKrTrzL8MEM3Cs5SY2bOU5p0tEbkjI/3A9e3EnjsvclSHOr1oFFna0z2RmUrf8FqTsF6dvX5IrG1meXz+grFxxJgEF2OuB4D1/5FwUHaMgswvK0njHjvkWp3jGsaQzww==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR2101MB1098.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(55016002)(6506007)(6916009)(9326002)(186003)(10290500003)(66446008)(64756008)(52536014)(316002)(8936002)(8676002)(26005)(76116006)(66556008)(71200400001)(166002)(82960400001)(5660300002)(7696005)(86362001)(8990500004)(478600001)(82950400001)(4744005)(66476007)(966005)(33656002)(66946007)(9686003)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: vWXxIMLAZ2c63eQ5J345q9955KcJl2d4ezC0fag1FHn1Ex7yWRpD7P3rs6H94AAq2cVkWHmF+HJJsZ1yqnJC/ZQA5xSdxznjU5nij7VK9ASB8Oxn7VVKRc5SkXzjP7kYLPQd+6dv/x6rjsK9zn9JVwcqcHE+2zLtOsORw25bq3m0caDe9N0RdDJMBfFDXrln8+wsX2K0r47r6UVmzBJf/HFsgm7ST/nQJSMx8bNIRPk3pOW3R0WriiTHNfbCq+A/9INU1eWjwn9WFr3zUbVMnlvc6W1MoqMmAjF5oKMMkmzIomkNeHL+VJsQa5kMpWybIy9QfKhnK9X+QW0Rg9Uu39WvzXU/LcPOIN0L6aEtGm5l80HeBhr04dmobjX7EL+cnDVO8rl2fKCKcvETE9wAtS6ujRxR56I1c/HLLj69PJ/lBbBjOs6B41QwmfpMdQ6hLdjrDrQ/5MS7ftjaXuNGrW8Gbf+ciTGimI3Bo01tW28=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5188121-6cd7-4f6c-f3be-08d80387a9f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2020 04:20:47.8600 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lj0gDoDsQ60iql4tGIb6uH1XeSGMkj1Ke2/IoqlawIScOI/LJDsMf+VnkiEh6pJaOhk8Mldha0CrfPH9DMP0Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0864
Subject: [lttng-dev] Using LTTng for an application with a single thread per
 core
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
From: Aprameya Rao via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Aprameya Rao <Aprameya.Rao@microsoft.com>
Content-Type: multipart/mixed; boundary="===============0538259138782452663=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200529042047.eDvEV_VXT6fvhxp8l20t72QjuPdpaoMQI7531ggplXE@z>

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
