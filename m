Return-Path: <SRS0=q6Pr=GQ=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A746C433E0
	for <lttng-dev@archiver.kernel.org>; Wed, 13 Jan 2021 02:10:10 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48A6122EBE
	for <lttng-dev@archiver.kernel.org>; Wed, 13 Jan 2021 02:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A6122EBE
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DFrW26zF9zQMQ;
	Tue, 12 Jan 2021 21:10:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1610503807;
	bh=fFV9KVXhvdT0DdHhM5Qj0eVERcvXKqCIB3M6tdrAZP4=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=T1jBtaukQXt0dlUiEjV0KxPdjh6OyDWH3QtL5Mv0mrccBrTzKNHT+0VqVXWbw6UiP
	 H0n3vGO+E2SYNK14/REEcrv2Pg/F7/4nRyGcRlhlGjCugUikjUs84A2Hjy0fn9zivG
	 Qjr85kj1rbL7F6Rt0LTzhvoXMhHHrRf2PKKxJcHeRVUdMwvwnw5RkgfQ2g+IUYEp+t
	 KhaQaVUctBrbxCbqTV9KUSFyqpFakHQuC+jeChAGcD0+ez6DxW8RCvsdaal8QH03lf
	 ps5C5P9gKHU6svNvaIlqpfJq47gXuihLsLhT3sEXacca5blzXyYCBmBfJ/389paacY
	 +L81+uKBILV0g==
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770084.outbound.protection.outlook.com [40.107.77.84])
 by lists.lttng.org (Postfix) with ESMTPS id 4DFrW05LwpzQcx
 for <lttng-dev@lists.lttng.org>; Tue, 12 Jan 2021 21:10:04 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lI3V7hYcQM8kjnI8VcO+MhwItPaQhGSHt2FCydsbW8vOYcUxCI1UEk9Cd61byx0ikLTmKEL/wxbtezD6BIyncfvjf8DfxW4ESyZtgfKeU6jt3MxJMB5/W3FGOQgecf4hYzEtw6geRoGTYP2wF78Rxkju7FLWgfVZKUKX2u40aiiiAgE93NELVivUjmYOw/4gLocz2uv3X7Q4hEB5Zi87WM+Zxgeki9FdjH+w8K9Yv10HGRg7aiKllCf2xl/7m+j+wziXcjcWQVW13lGi7u7TZI3XdgFzefvfHJ1k2wHU8yk0OB5EBqWq4slycbIaMmrxbJWqDDpXlbkpTdC74/FiSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmXbjCElLAxQSP8cmTzBFA+l3C1LYpTfDWz9uyuuIX4=;
 b=OvzHvfFrOl8z0oCTdfKmprEW6MsN6EqkNtkZPY5qSsyz0SpMRGicBlwmhvUs+7BY6RJpvjuR7nmjvvoBUF9RxXouXy6+0802A0nV7uY3KV3TCn4H1ufyRtqq40CMcucQGjJbrnYRavnnfz490uWi81EeE5WVJxTKe1tLS3JFPebwZYamO4ueB36dUO1DgVFvxoupiVy3W/S3JDRVl6qpMO1Km1mcZJ9z5NDGC0OW341egySqc35QZBYz02m/7ZEa2aGLd4ahlbRoC0QCvKW1vBzCsSKKxRkuglaMwLxalu7KLL0Xaae30qhfrJPFTTJZ2tliOVHqRA7WbyOJK33BdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
Received: from DM6PR15MB4072.namprd15.prod.outlook.com (2603:10b6:5:2bf::16)
 by DM5PR15MB1482.namprd15.prod.outlook.com (2603:10b6:3:ce::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Tue, 12 Jan
 2021 23:35:48 +0000
Received: from DM6PR15MB4072.namprd15.prod.outlook.com
 ([fe80::5d02:23ff:b955:bbde]) by DM6PR15MB4072.namprd15.prod.outlook.com
 ([fe80::5d02:23ff:b955:bbde%6]) with mapi id 15.20.3763.009; Tue, 12 Jan 2021
 23:35:48 +0000
To: Michael Jeanson <mjeanson@efficios.com>, "lttng-dev@lists.lttng.org"
 <lttng-dev@lists.lttng.org>
Thread-Topic: [lttng-dev] LTTng 2.12 modules from PPA fail to install
Thread-Index: AQHW5TWOYGq5I4uA3kK/nEkWoaMuRqoeGi0AgAYeEICAAHRveg==
Date: Tue, 12 Jan 2021 23:35:48 +0000
Message-ID: <DM6PR15MB40720F8BD7F349F654041E388FAA0@DM6PR15MB4072.namprd15.prod.outlook.com>
References: <DM6PR15MB407280AC90424B9F52FE57D38FAF0@DM6PR15MB4072.namprd15.prod.outlook.com>
 <c6e9bdf7-3f1b-9ed8-bc3a-239675f69953@efficios.com>,
 <e32dbf93-c8eb-1621-c7d9-076c4bb10171@efficios.com>
In-Reply-To: <e32dbf93-c8eb-1621-c7d9-076c4bb10171@efficios.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.24.6.220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec3816f0-5a92-4733-6afc-08d8b752ca97
x-ms-traffictypediagnostic: DM5PR15MB1482:
x-microsoft-antispam-prvs: <DM5PR15MB1482F57ACB0E346EB1A211238FAA0@DM5PR15MB1482.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E7zJWh/NTpwMnc08B1jVWIGsX+py/HdloLeyuhoFpaUQeRF2MJ/w8RpBzZIsVMZEJFOBGJjqsONW/Eawmf28j/dSarKkomubxlbPGsl+E9adCyWOyOK+3QZ4P6YWCKdtuK6p6cOkO0XzG52jd8n/1HyA55bC1AE5nIESx/I0eRKjldnGSdj2aUrXsFVi85iS+Ds8j9iKdQFBgZa2+T7L0WNv5WBJhTWj+sJwr978zDEtM1BqwXwe7k0iQYKnLdIc4BokkKpaiyWExlEI3PY+oE7s8HKrA6Pc+6Qh6P2nfxM9kfBMtAyFMZyPimUvMMAxKiLgKhJfJGsg8PbMzkgjAjDOgg6XilBXnM2DPcZWpKX8cfeY6WEzMM7bGd+rruEwayb961zjgxv0gDG9Tvp2FMpaGY4FaAn90wQvCcOypseoe1PNtWpwoybp8Klhb9jb/QOIph29nC5LFAydfG9msw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR15MB4072.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(52536014)(19627405001)(8676002)(83380400001)(8936002)(33656002)(53546011)(64756008)(478600001)(166002)(26005)(6506007)(66556008)(66476007)(9686003)(7696005)(91956017)(86362001)(44832011)(71200400001)(316002)(5660300002)(966005)(76116006)(2906002)(186003)(55016002)(110136005)(66446008)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+B2FikFqoHW15+EIDWQjhuNHcKtDAYBAIqCB2w47gly5/0bEI5gv6CfRyJqV?=
 =?us-ascii?Q?qUiITo+k0P+NGT1mOm0ql4gjZ+KQJfsvWXkPm7h6hKw5cm2WKHiQAP4Pvhtw?=
 =?us-ascii?Q?tNGIK4LEY/DR6/mFiLEUBdFGRgtmqvOmreD36InbqFiUFDElGjhz9M8WJRKh?=
 =?us-ascii?Q?gzWBZO7NRX9mDpDpqGFORACgNBgHMMfKSifVuBTDvy57zip9wl8XY06YF3xL?=
 =?us-ascii?Q?1n9CE03s/DDPqOJ6xNnmgW/3dnY7t5C1UCV2imFhRUqlMcLMNbNGsD24XUax?=
 =?us-ascii?Q?l6UIM+s0nWaOT4DJ6Pp3MJUS8zIVeoxrheDGGVuEx4gJ1RoCEuerFl8PAgmv?=
 =?us-ascii?Q?jmEcpCCv5hz4dCQM0v122miKDkc7qbeTZ36IPmRwawdfJLk6SGJatBGjN0bJ?=
 =?us-ascii?Q?WVzpK+0IvibXMrTM1NyeDZZneQU4MiIGK0NymvrqSGxkoG0T/yeZ7cge7Ezc?=
 =?us-ascii?Q?g+UGv+QCGfl8lqt1udLG1e4NouDM0cqCzYBTkWiqsxTNndYbLM7uWXVghlUe?=
 =?us-ascii?Q?lbnw7l5nIu03Ov28ZXcoMbChMtRyqSu2AOB2d59T5IKBnj0cM/81KkjAhdic?=
 =?us-ascii?Q?5ktc68kVoIHU+ggJ04c234u5JvJYiipa+ZDer4Py3dL8ioAMzb513aZy6XIe?=
 =?us-ascii?Q?dcCXk9fCA5C3t9MRqNuJs3pOka24DrXkdWKChgAhi68KHS5+5WPhlg0p8S8J?=
 =?us-ascii?Q?StGbAsIYXvHGX/+P0YUttQYdd3DJZMH6E3ES5EAKNf9LP4NCIjJK82Rstgrp?=
 =?us-ascii?Q?8qlpsg4m21AiLAsOpuO6vFEwnS+CT1TnU8OE9mE+vXO324E93C0Mt4iRgigj?=
 =?us-ascii?Q?XtI/3ougYjyej8NawvoV80C7ENusJV3o+6HHlaIs5RRdDJfxLd3Fz/Bea7ft?=
 =?us-ascii?Q?17nrqi1ji3jO4jjzqo+7KSVb4tkjX+k8acKL9IrYcgh3cLqXHQVnDFPMNeko?=
 =?us-ascii?Q?NVXx9/TDA2iEx5FmVu0IyGS/0EIlXdZYuLug4zvj410=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4072.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3816f0-5a92-4733-6afc-08d8b752ca97
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 23:35:48.6121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UQFhFTdL8S+0seU3o7rQDtgGH3WVQCYe1HLTpm7gVlGM56AGDw41smiPFvDMZSib/LEppVtnDVlN+jhC/YIxq0ZS2pKPORDMuaThRKEDh6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1482
Subject: Re: [lttng-dev] LTTng 2.12 modules from PPA fail to install
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
From: Bernd Hufmann via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Bernd Hufmann <bernd.hufmann@ericsson.com>
Content-Type: multipart/mixed; boundary="===============3241076180725639664=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3241076180725639664==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_DM6PR15MB40720F8BD7F349F654041E388FAA0DM6PR15MB4072namp_"

--_000_DM6PR15MB40720F8BD7F349F654041E388FAA0DM6PR15MB4072namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks Michael, for the information. I was able to make it work with the la=
test stable PPA.

BR
Bernd
________________________________
From: Michael Jeanson <mjeanson@efficios.com>
Sent: January 12, 2021 11:38 AM
To: lttng-dev@lists.lttng.org <lttng-dev@lists.lttng.org>
Cc: Bernd Hufmann <bernd.hufmann@ericsson.com>
Subject: Re: [lttng-dev] LTTng 2.12 modules from PPA fail to install


On 2021-01-08 14 h 13, Michael Jeanson via lttng-dev wrote:
> On 2021-01-07 15 h 54, Bernd Hufmann via lttng-dev wrote:
>> Hi LTTng experts,
>>
>> On my Linux Ubuntu 18.04 machine (4.15.0-129-generic kernel) the
>> installation of the LTTng kernel modules fail using the official PPA.
>> I found a log file lttng-modules-dkms.0.crash with some details on the
>> installation failure. See pastebin [1] for the detailed error message.
>>
>> Any ideas what is going on? Please let me know what I can do to
>> resolve it.
>>
>> In advance thank you very much.
>>
>> BR
>> Bernd
>>
>> [1] https://paste.ubuntu.com/p/747H2V5q7K/
>> <https://paste.ubuntu.com/p/747H2V5q7K/>
>
> Hi,
>
> There is a fix for this build failure in the stable-2.12 branch but it
> is not part of a point release yet. In the meantime, you can build
> modules from the git branch or use the package from the "Latest Stable"
> ppa [1].
>
> Once the next point release (2.12.3) happens, it will be uploaded
> straight away to the 2.12 ppa.
>
> Regards,
>
> Michael
>
>
> [1] https://launchpad.net/~lttng/+archive/ubuntu/ppa

The new 2.12.4 release has landed in the stable-2.12 ppa, you should now
be able to simply update the package to fix the build failure.

Cheers,

Michael

--_000_DM6PR15MB40720F8BD7F349F654041E388FAA0DM6PR15MB4072namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks Michael, for the information. I was able to make it work with the la=
test stable PPA.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
BR</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Bernd<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Michael Jeanson &lt;m=
jeanson@efficios.com&gt;<br>
<b>Sent:</b> January 12, 2021 11:38 AM<br>
<b>To:</b> lttng-dev@lists.lttng.org &lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Cc:</b> Bernd Hufmann &lt;bernd.hufmann@ericsson.com&gt;<br>
<b>Subject:</b> Re: [lttng-dev] LTTng 2.12 modules from PPA fail to install=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
On 2021-01-08 14 h 13, Michael Jeanson via lttng-dev wrote:<br>
&gt; On 2021-01-07 15 h 54, Bernd Hufmann via lttng-dev wrote:<br>
&gt;&gt; Hi LTTng experts,<br>
&gt;&gt;<br>
&gt;&gt; On my Linux Ubuntu 18.04 machine (4.15.0-129-generic kernel) the <=
br>
&gt;&gt; installation of the LTTng kernel modules fail using the official P=
PA. <br>
&gt;&gt; I found a log file lttng-modules-dkms.0.crash with some details on=
 the <br>
&gt;&gt; installation failure. See pastebin [1] for the detailed error mess=
age.<br>
&gt;&gt;<br>
&gt;&gt; Any ideas what is going on? Please let me know what I can do to <b=
r>
&gt;&gt; resolve it.<br>
&gt;&gt;<br>
&gt;&gt; In advance thank you very much.<br>
&gt;&gt;<br>
&gt;&gt; BR<br>
&gt;&gt; Bernd<br>
&gt;&gt;<br>
&gt;&gt; [1] <a href=3D"https://paste.ubuntu.com/p/747H2V5q7K/">https://pas=
te.ubuntu.com/p/747H2V5q7K/</a>
<br>
&gt;&gt; &lt;<a href=3D"https://paste.ubuntu.com/p/747H2V5q7K/">https://pas=
te.ubuntu.com/p/747H2V5q7K/</a>&gt;<br>
&gt; <br>
&gt; Hi,<br>
&gt; <br>
&gt; There is a fix for this build failure in the stable-2.12 branch but it=
 <br>
&gt; is not part of a point release yet. In the meantime, you can build <br=
>
&gt; modules from the git branch or use the package from the &quot;Latest S=
table&quot; <br>
&gt; ppa [1].<br>
&gt; <br>
&gt; Once the next point release (2.12.3) happens, it will be uploaded <br>
&gt; straight away to the 2.12 ppa.<br>
&gt; <br>
&gt; Regards,<br>
&gt; <br>
&gt; Michael<br>
&gt; <br>
&gt; <br>
&gt; [1] <a href=3D"https://launchpad.net/~lttng/+archive/ubuntu/ppa">https=
://launchpad.net/~lttng/+archive/ubuntu/ppa</a><br>
<br>
The new 2.12.4 release has landed in the stable-2.12 ppa, you should now <b=
r>
be able to simply update the package to fix the build failure.<br>
<br>
Cheers,<br>
<br>
Michael<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR15MB40720F8BD7F349F654041E388FAA0DM6PR15MB4072namp_--

--===============3241076180725639664==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3241076180725639664==--
