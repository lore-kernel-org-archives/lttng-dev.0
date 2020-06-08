Return-Path: <SRS0=CrXu=7V=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	HTTPS_HTTP_MISMATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2B0C433E0
	for <lttng-dev@archiver.kernel.org>; Mon,  8 Jun 2020 18:29:50 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54F9F206D5
	for <lttng-dev@archiver.kernel.org>; Mon,  8 Jun 2020 18:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="kx13t3Je"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F9F206D5
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49ghcX30D5z1NZk;
	Mon,  8 Jun 2020 14:29:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1591640989;
	bh=dUMIJWvlIyRJD9tGB7CJageSA08VjDj3abU5pw3DbfI=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=kx13t3Je6VbJWc+DouV5z6kwOEMGZOULaEM4fU8qABI10xvj6fsTHcOXGgQyj3W20
	 IXswD5URp58Z2/1QHPaGZqHHN0bAbyb/4mkbG5YHLhF+HlaCqFyWYsI7+zO/nRh3kx
	 nyE0CF6WapbVOGfBbN8lIyMC88NER8/k/TorXWkUW8/C1MOseqtkvmacVxQ8uIItmg
	 0BNngTqYD7OyNht0jjBsnqJNFWHRMXwvbhXCYPupLZQ3XehTSCMfG+/us9nYX3vMUN
	 7xnHqARm3ks6QJdYCqfiMEDPtvOw1hPLdDpFqHDVofVk/rJAqkF3ig71BngzuAKEb/
	 vmTO8bWo3IJ8A==
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760132.outbound.protection.outlook.com [40.107.76.132])
 by lists.lttng.org (Postfix) with ESMTPS id 49ghcV6R59z1NZb
 for <lttng-dev@lists.lttng.org>; Mon,  8 Jun 2020 14:29:46 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDtzKWBFpXL8aTkDmPi/3MqS479xVp/wo09IwlfmA/EdSDadJ2GY8vz/XeyQ4uuiR6Y5THASX16V1UxvQhi138+ye3fgcwZECNADgLFmc+L+PR18KE1NPemXm9uJg0c0v+exdYyVgkVb0hWTbhEJtB3kbsLO21+KPdz0vB9OvOtIw1SF5h/pKggKasqFnRiHryts3MTfwTpWz7b/WrYpe1T+dns+i9pBspVXUXdqRADbD/lwtBMlug0+1Cdk30pF5UotTRqhEG6l7myMDPSStdiI7SsvPf2mLzB7TI04sbzWTIQUq+EIwZEHAC76GnYGUrUAUvcGQtFDIycw5A5uRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALjLNJDzd3ykl97o0en5R4RtIdg6tmWs7wf1Nm6Tl3Q=;
 b=kuGpDyp8DP33guxma1JcWCQoI/ldL6k0l7RSnC15ghLyREcxAMtPk4yHL3Ls5djbMJXmjFRirmKyG8Qctg/iu4Bp7/Qz7v8VkZzXV14pvdzFudaql0b8AkGr2Nodg/kMkjr7vKepJooQ1aJVZdQavu5OxZ+P9kUcevpG5+3s44IRCe4cRiDFXaQyu9NvI69czAFfguSr+gdi5ACA0nF/k4D7Qj9FNK5k4s7Wiusx+d0vEpVAVeKI6HPOr0sq5vXwNAYKGRRJneAPbJcer9rFVGVvqGizdVfL9maURjQP5KfPoz1HF0qURNhOFDIcK3iABGCfeK5xzG7354bBxli1Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
Received: from MW2PR2101MB1098.namprd21.prod.outlook.com (2603:10b6:302:a::27)
 by MWHPR21MB0159.namprd21.prod.outlook.com (2603:10b6:300:78::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.4; Mon, 8 Jun
 2020 18:14:04 +0000
Received: from MW2PR2101MB1098.namprd21.prod.outlook.com
 ([fe80::c93:af28:c8b8:d095]) by MW2PR2101MB1098.namprd21.prod.outlook.com
 ([fe80::c93:af28:c8b8:d095%6]) with mapi id 15.20.3088.017; Mon, 8 Jun 2020
 18:14:04 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: Using LTTng for an application with a single thread per core
Thread-Index: AdY1M3Uj1EXccs72RTSAHHqxkjE0yAIjRZYA
Date: Mon, 8 Jun 2020 18:14:03 +0000
Message-ID: <MW2PR2101MB10984DF40F60AD90F47D7EF481850@MW2PR2101MB1098.namprd21.prod.outlook.com>
References: <MW2PR2101MB1098270C4CF4CBFA31AC2E0C818F0@MW2PR2101MB1098.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB1098270C4CF4CBFA31AC2E0C818F0@MW2PR2101MB1098.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [50.35.65.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dbdad723-3465-4ece-435c-08d80bd7ba15
x-ms-traffictypediagnostic: MWHPR21MB0159:
x-microsoft-antispam-prvs: <MWHPR21MB01599228B9E69CB24A66866881850@MWHPR21MB0159.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /wYfQptZNK8j7jYMNa4UmqqfvDs7wIPTPbq2iO186opo9FDorL4ubHxg2A/otOKMSA3TyyGZe+R7BQBqV64BC0Z3UHwXUSxjE6r88Tw9yHaSKWPmzzYRAJZfYkuszMPfggFKuwd0D79H3mHGwTMENEh+owBAYUIeLAv9jvPIWY+pfOPTw/MGlPfySuoy0rlVxofC1lwpyV08RfQELrCTaDOV9hdVl1xCTCqOeWYIuKv31cnIEUdOTzVlPgnzxuYU4k29C1Pw3uxWXF7E3+lHggCYWRHfBz566LWhvTx2+i4ygIY+vczqn2NcPMDyN1cRUhxMYBk7XYVzsOgTh2FXlQJc91fEWf4m4eiykbRlAtk+cNhyjtZVYDbfivIy5k7JsARecZ9DWcJnY6qdvWKsIA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR2101MB1098.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(33656002)(9326002)(55016002)(9686003)(53546011)(26005)(316002)(2906002)(186003)(71200400001)(86362001)(7696005)(6506007)(6916009)(52536014)(5660300002)(82960400001)(8936002)(76116006)(66446008)(8990500004)(66946007)(66476007)(66556008)(82950400001)(8676002)(166002)(966005)(10290500003)(478600001)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: e9nsKc2wbyeKEbu34qgMOLj1JjK+x7EUkKuRn/1wma7kb7+IwamKTU0v/h0Ja4azzM2SSinnrrl1lnUoGVIeXQXDaviT14v6piSSd/51fU/J10v/57P3VdQLKvqmJ0en99fzEk/Y7wRdPwpAp7vHgc9Ee1G+NoSm9AbZxvxKCYoAEWeXHSnkv6BOzhZGSR/cOxQxNFP7us1ZR+BOIVXKloGmb6n4Re+C1HhnGkP7vNW53qUTWZWIf0CW+zQWnEyUcbPHM99zgX98Z5ts/etCa01Sv+afI58lumAV4UPWlNMFTjiUBcxnfgcJX9ECXek1uMn84j+Mj8JfaEGK4M/GgobVzFcRW6KUVQdsipmv2V2SpiOOKoMpIBhwz5Qa6K2uD5XTAP2LOmwagOVhub7rJdnTU0hyhDFIPfQ+ZqvKAOH5D2xAEbqp4K8aQn+BJtqsV+UW0qedJ30tme0xcxkBQNP2sqrTR+r4PHPkBBc6c/g=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbdad723-3465-4ece-435c-08d80bd7ba15
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 18:14:03.9205 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JXqOsJXC5FkvyiPP2RCG1gn+v4nnxMOu0nYFlLqIhEwJPLIXDay40qFrv820mJoFYbikD9zUHq/als+9czY7aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0159
Subject: Re: [lttng-dev] Using LTTng for an application with a single thread
 per core
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
Content-Type: multipart/mixed; boundary="===============2946796340945471858=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200608181403.oBwum2kqpA02-ghzWXkArRxdG36KVJKhZCpLHGYGZqo@z>

--===============2946796340945471858==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MW2PR2101MB10984DF40F60AD90F47D7EF481850MW2PR2101MB1098_"

--_000_MW2PR2101MB10984DF40F60AD90F47D7EF481850MW2PR2101MB1098_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi

Any suggestions on this?

Thanks
Aprameya

From: lttng-dev <lttng-dev-bounces@lists.lttng.org> On Behalf Of Aprameya R=
ao via lttng-dev
Sent: Thursday, May 28, 2020 9:21 PM
To: lttng-dev@lists.lttng.org
Subject: [EXTERNAL] [lttng-dev] Using LTTng for an application with a singl=
e thread per core

Hi

I am working on an application where I have a single thread per core (the a=
pplication is based on top of SPDK - https://spdk.io/<https://nam06.safelin=
ks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fspdk.io%2F&data=3D02%7C01%7C=
aprameya.rao%40microsoft.com%7C99c722863c7f4b084b2808d80387ae95%7C72f988bf8=
6f141af91ab2d7cd011db47%7C1%7C0%7C637263228592195561&sdata=3DKwAOEkqx%2FIsW=
td7zEuntGKZVnqkfUNU4s6VeEXI3jG8%3D&reserved=3D0>). Ideally, I would like to=
 have a set of buffers allocated per core and since there is a single threa=
d it can write the trace event to this buffer directly with no synchronizat=
ion. Once the buffer is filled up, the buffer can be given to LTTng to take=
 care of the persistence.

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


--_000_MW2PR2101MB10984DF40F60AD90F47D7EF481850MW2PR2101MB1098_
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
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
<p class=3D"MsoNormal">Any suggestions on this?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks<o:p></o:p></p>
<p class=3D"MsoNormal">Aprameya<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> lttng-dev &lt;lttng-dev-bounces@lists.l=
ttng.org&gt; <b>
On Behalf Of </b>Aprameya Rao via lttng-dev<br>
<b>Sent:</b> Thursday, May 28, 2020 9:21 PM<br>
<b>To:</b> lttng-dev@lists.lttng.org<br>
<b>Subject:</b> [EXTERNAL] [lttng-dev] Using LTTng for an application with =
a single thread per core<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am working on an application where I have a single=
 thread per core (the application is based on top of SPDK -
<a href=3D"https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fspdk.io%2F&amp;data=3D02%7C01%7Caprameya.rao%40microsoft.com%7C99c72286=
3c7f4b084b2808d80387ae95%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C63726=
3228592195561&amp;sdata=3DKwAOEkqx%2FIsWtd7zEuntGKZVnqkfUNU4s6VeEXI3jG8%3D&=
amp;reserved=3D0">
https://spdk.io/</a>). Ideally, I would like to have a set of buffers alloc=
ated per core and since there is a single thread it can write the trace eve=
nt to this buffer directly with no synchronization. Once the buffer is fill=
ed up, the buffer can be given to
 LTTng to take care of the persistence.<o:p></o:p></p>
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

--_000_MW2PR2101MB10984DF40F60AD90F47D7EF481850MW2PR2101MB1098_--

--===============2946796340945471858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2946796340945471858==--
