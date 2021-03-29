Return-Path: <SRS0=Aspu=I3=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A528C433C1
	for <lttng-dev@archiver.kernel.org>; Mon, 29 Mar 2021 09:43:53 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4022A61883
	for <lttng-dev@archiver.kernel.org>; Mon, 29 Mar 2021 09:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4022A61883
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F871y2fbmzPsQ;
	Mon, 29 Mar 2021 05:43:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617011031;
	bh=GyMK4izq26Wn9VsYnW5FL29bOt9ezCMErjyxodRY3nc=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=NPNQzGArQkG2dLbIcKul8mLIxe0eMnkFarTCjEd9jhlUfAIzsT6cRzitTKA2X77PW
	 lCw/YEli/IOOGXeq66M5PmfsGw7n3TQaVuudmRTc58LJeLwhksP+Y3yd2ut2nELuM/
	 HVOu2RYNqx7LWyNt+Xz0aWbigA/JkctM8hlVpHeg7vNNbVB+2UY4u0jeiQaQlUzZwF
	 dlymnUWjF+X84GrLR9xe35FiAqeqDRMj2zIZcSa4tdphRwFT83Z+iFathioMdf6osU
	 YwCb8fb6P2AAGxbwnTaNAtPpQ//31wFGmgkj2ZcBd3+ZhY0b24Ju8hdu9vIFOxhGP3
	 NvOtX+0HM32hQ==
Received: from FRA01-MR2-obe.outbound.protection.outlook.com
 (mail-eopbgr90042.outbound.protection.outlook.com [40.107.9.42])
 by lists.lttng.org (Postfix) with ESMTPS id 4F871w0yT9zPjr
 for <lttng-dev@lists.lttng.org>; Mon, 29 Mar 2021 05:43:47 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIJ8Y0WTLK0vlwMaOa6njGjm/3eG+g+t/lp3yvi6x8oIiMi9tYaBkIy6C3C/OIKCB1wH9BqKEYatrqpgkkIsMd4a+XgsAZGtopbG3WtVq+ED8x8h3tOilgnhBRvgJ90bdSMsGkldBk57RZ+NqLWLN6V1qMLN3f7JehMx4XJ0sjSoVb9pEfmEZ5HTFgCLjt/IJV6zimf/v/24I+V9z1NWcNXhdPRnuq0f9JOxo0e1oRNbu1w/RcbgML4zoEsjLifZTcLRGbEfML3D0iPwnQKDT4UQwWeStp1VYHXgEhqW6uzVaw0bJRh4JZb4zyo0ViC2av1rEogfIIxGBZqJ2k/HBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxKwdO9zmWDE3tVmM0hvaovjw+fT/cydzgVTcrBai14=;
 b=Yvqf+bWYKcpjzxETyrGqCiM8vL7ZKmqEZMhoEYg6fjA0Ou8chum4UPThBILxZW8CT06xcADFFOMqUUzp+KsWIDXaSyMvvyPw47BVvPUFpVHmN3HnIT0YeDXqE9eUc2M5VRGH4iujVpMSuDk4N75XZ6I07PqOwyxm9Dk+H7IqWCm82i6OcHzZW/jf9qDVbi/iCSyNuZokVoUfSYihErUeCgGaQAHcSaIUBCCgXnJwQ/UsyGwQ/ZXlr0U0tu9LKGOyJkp0XcvUMDPXslAM9Og8bZmLQ8Qqz9z4ilBqTp789y5RtbZ2na4sr8p8IYuTEJ7e7nlWcriaxGiQs2stziq4bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=reseau.eseo.fr; dmarc=pass action=none
 header.from=reseau.eseo.fr; dkim=pass header.d=reseau.eseo.fr; arc=none
Received: from PR3PR02MB6202.eurprd02.prod.outlook.com (2603:10a6:102:63::15)
 by PR1PR02MB4892.eurprd02.prod.outlook.com (2603:10a6:102:7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.31; Mon, 29 Mar
 2021 09:43:42 +0000
Received: from PR3PR02MB6202.eurprd02.prod.outlook.com
 ([fe80::9183:a57e:a921:f482]) by PR3PR02MB6202.eurprd02.prod.outlook.com
 ([fe80::9183:a57e:a921:f482%7]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 09:43:42 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: LTTng 32 bits : Cannot find liburcu-bp 0.11 or newer
Thread-Index: AQHXJHzLqHvA9992nUqnoJi/yO/byA==
Date: Mon, 29 Mar 2021 09:43:42 +0000
Message-ID: <PR3PR02MB62022F27BFAE30836B7E094ED17E9@PR3PR02MB6202.eurprd02.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.225.20.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bef3d963-c9d2-4e24-094a-08d8f29723ca
x-ms-traffictypediagnostic: PR1PR02MB4892:
x-microsoft-antispam-prvs: <PR1PR02MB48924B26AF720102D6158A42D17E9@PR1PR02MB4892.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cOLDOcGCZ9hYB6MJedMmpOzWBPJyVDnvOp+M1Va0MaVGYEg+mTY10kG+tdHi8XdPla2dfas1GWNNJHhnXIAFlYl9S7TUXk7OFtv89dLkl0uz902Ci/j452/sjccHVcM+J6oP1uXl5RC9IRc7fixJgWjZjmWX2jSkphyeNyLNKc57GXQrM0+xqogCdv5HIbU73HLgrOCtjsSfruuDTJ3az6/Ujc28fFmGXz7cN0gQj6JIHRRj3H5cy6zB/PIkQYHjx+XPhO6I4nFy9BKJLFZUdXRc6r99lxMgqWjM8G9ri8yluTKO3sII8Wklq2r+l2L38B1fGW4UHhPSCzR8CMIzuy2FefTGE3HMUgoRk5/3Pq1wooevwW0agCYCZHC4PRr+5dFUbDPPLg9CqgNGZkdjR9kpUQZiyJSb8XVRLXk5dt3pvLxrGDeY1y9gP5z6la/PLyhTpxmVDxSq/6iYaMUsPdkbq2rIgM7nGMOkJHX8U6yeU48pW+RWxcFJLgNH20uRfC4Ikisp1tFJ8vU7p0H2n/WvEGM+Ml3gav2n7FUp6HHIxvk6I57Sp/nsHJg/sf0NOseZL173S/4RbL+ZhF029WKn46wfGX5JNVvIIjVngvJ+SIJilgjwzkfV4zC2HIs9+2PGA17TpQj3MwEkmQKws4O4cZBy7D5v2Pqsjphi4ArqgRmNthl0XrlA6R4TI9NWyTZe3gdXkVNJQVyvE0+yl5aXpTib0pUZIOcuABbCPR0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR3PR02MB6202.eurprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(39850400004)(136003)(396003)(346002)(376002)(71200400001)(52536014)(21615005)(7696005)(19627405001)(478600001)(33656002)(55236004)(6506007)(186003)(966005)(5660300002)(786003)(64756008)(66556008)(66446008)(66946007)(166002)(6916009)(4744005)(66476007)(26005)(86362001)(316002)(76116006)(38100700001)(8676002)(8936002)(2906002)(9686003)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?gJh/qIUDZLZD9JKF0lOQWE66gUUT/6vJ/IUJ9bOS5vWZ104x4iwkgZ4MWd?=
 =?iso-8859-1?Q?uitQOulefg3mtWmQcgs4Us22qbPbcoRjpxynP0XTxmTkmNGmnhIRo/2rnI?=
 =?iso-8859-1?Q?DoK3aSAj9aCYbkXfyAFdyka1HOAvvtNKJh+fbOUhSa3juJ2pEGke0hhTgX?=
 =?iso-8859-1?Q?tcrS6YTJIvU3SOV5Y7dRD6LFTKoCk0hUAtYURkwo111FTRDDIfgUNo4Po0?=
 =?iso-8859-1?Q?q7rq13dNtHRLsn94R+VgjurMRz7gsK0Mknm2RcFkIMP1XN20R8sFzF9o3L?=
 =?iso-8859-1?Q?I/dC2/7rG06W7Oi0KjBgfVqlWjypU7CsYQx1KOVV8IEDWdXfqlsD5xDlPD?=
 =?iso-8859-1?Q?CYmikYbknip2f8fIxhVmVXSTBXE2BzK4OMCB7lkfxDMFSkjFYXTNNULxq5?=
 =?iso-8859-1?Q?uj6XtDBB8uP0zQVCyRLZedslSkxJ88oYpZyhfAp6mWf4nv2BKPUyFS4jE+?=
 =?iso-8859-1?Q?XFHlbhN3R++7IL5u9wwO8tUqlwAyvOIdAEbNA51jpHm0YtRZC2U27d7opl?=
 =?iso-8859-1?Q?bKknRiwnE60H76DvB7X6vBpflbo07HOexsfdFvZy2kD7PpErJRoJrhLUSi?=
 =?iso-8859-1?Q?jfvczxpZRbU78+UV5AuAgOmOxDNNi+Zgi5A6YwV1iycHks1vgiYA6kgMw9?=
 =?iso-8859-1?Q?Hu1+YeaA6CNPDYosx9HXW95fYAaCOlXUzERtPeoxIysSupwle5/xn8RYGu?=
 =?iso-8859-1?Q?JQS5+hEtMEoeB+rrknWo5OB4rP1GssyLwJAJP8E01Tt0D7rBuB/5PHDZi1?=
 =?iso-8859-1?Q?nx1h/4+CQL+zNuzgiOtRDXc68VWS3Vq31YZC2BiBlzoxubkZAtAVvG3CAx?=
 =?iso-8859-1?Q?K5vTKXmY8Xuy4RI1vDFtmPwEakhstnv72nz0YVky8B0RIkGcyfgTPrGCew?=
 =?iso-8859-1?Q?GpZBNH0iQ4A59Rc0GbN5AoOf4RPYBYiWwS+PpQMImOCz1d2EnbZghwjr3Y?=
 =?iso-8859-1?Q?Ude37D8pFBAXm1m+yawC8Thwrn4OGunCMDmDracI4facC/HTvO3qWORIe9?=
 =?iso-8859-1?Q?gfg8OF2xeJOrSXLapsSYQv5PhIWqhxfYpX0h5ILbbJGg34GwHtXAu8E7FZ?=
 =?iso-8859-1?Q?JvNESQ4FT08aeFjjCJBmFa9WultoIgPpihKGWGNQUnR3zPRJFmkkCAZAPU?=
 =?iso-8859-1?Q?uZZCCT//tQ0UfH1wnm2ZHUeqbBGyIJYQmWZKMRFgLubBr0i4tBqRGe/c6Q?=
 =?iso-8859-1?Q?ndqr/iBA+SKqCBA0cIecuCw8rLzkSci3IFE8vxeTkD3BABFcpRvGXA9MuU?=
 =?iso-8859-1?Q?GubYNbojZ40CWnUHdwM3long06cxRyn7wU0uU34c4axnWPFQJCvNhfprr7?=
 =?iso-8859-1?Q?cylErg/Z/ykWgBLByIsrDMgGls+pue4W/67tBM1cIPcsdbY=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: reseau.eseo.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR02MB6202.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef3d963-c9d2-4e24-094a-08d8f29723ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 09:43:42.5938 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d7ad159-1265-437a-b9f6-2946247d5bf9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SktbQJlSsD6kbaI7SCWLrhIFSQyxVtC+2Uy5347c4xfHBO6vUMWwOHIZgTcFnRbS5zdanBYCE+90mC+h4j1In0W0wm2VIPdkdzmnPA/7+40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR02MB4892
Subject: [lttng-dev] LTTng 32 bits : Cannot find liburcu-bp 0.11 or newer
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: MONTET Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: MONTET Julien <julien.montet@reseau.eseo.fr>
Content-Type: multipart/mixed; boundary="===============6840519023607675616=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============6840519023607675616==
Content-Language: fr-FR
Content-Type: multipart/alternative;
	boundary="_000_PR3PR02MB62022F27BFAE30836B7E094ED17E9PR3PR02MB6202eurp_"

--_000_PR3PR02MB62022F27BFAE30836B7E094ED17E9PR3PR02MB6202eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I successfully installed and used LTTng on x86 and x64 (kernel event, users=
pace, and other tools like TraceCompass).

Now, I am looking for a way to use LTTng on other processors (arm32, ...).

I tried to follow the tutorial and, to be honest, I am quite not lost on st=
ep 2. (libuuid, popt, libxml2)
https://lttng.org/docs/v2.12/#doc-instrumenting-32-bit-app-on-64-bit-system

My current issue is on the step 3.
During the installation (./configure), I have the following error :
error: Cannot find liburcu-bp 0.11 or newer. Use LDFLAGS=3D-Ldir to specify=
 its location.

This file - liburcu - is in /usr/local/lib32 : Ubuntu Pastebin<https://past=
e.ubuntu.com/p/b67Bxf6cfB/>

This topic was started a long time ago here :
https://lists.lttng.org/pipermail/lttng-dev/2013-February/019641.html

Would you mind helping me ?

--_000_PR3PR02MB62022F27BFAE30836B7E094ED17E9PR3PR02MB6202eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi everyone,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I successfully installed and used LTTng on x86 and x64 (kernel event, users=
pace, and other tools like TraceCompass).</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Now, I am looking for a way to use LTTng on other processors (arm32, ...).<=
/div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I tried to follow the tutorial and, to be honest, I am quite not lost on st=
ep<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetic=
a, sans-serif; font-size: 12pt;">&nbsp;2. (libuuid, popt, libxml2)</span></=
div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"margin:0px;font-size:12pt"><a href=3D"https://lttng.org/docs=
/v2.12/#doc-instrumenting-32-bit-app-on-64-bit-system" style=3D"margin:0px"=
>https://lttng.org/docs/v2.12/#doc-instrumenting-32-bit-app-on-64-bit-syste=
m</a></span><br>
<span style=3D"margin:0px;font-size:12pt"></span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
My current issue is on the step 3.&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
During the installation (./configure), I have the following error :&nbsp;</=
div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>error: Cannot find liburcu-bp 0.11 or newer. Use LDFLAGS=3D-Ldir to spec=
ify its location.</b></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
This file - liburcu - is in&nbsp;<span style=3D"color: rgba(0, 0, 0, 0.75);=
 font-family: &quot;Andale Mono WT&quot;, &quot;Andale Mono&quot;, &quot;Bi=
tstream Vera Sans Mono&quot;, &quot;Liberation Mono&quot;, &quot;Nimbus Mon=
o L&quot;, &quot;Ubuntu Mono&quot;, Monaco, Consolas, &quot;Lucida Console&=
quot;, &quot;Lucida Sans Typewriter&quot;, &quot;Courier New&quot;, Courier=
, monospace; font-size: 12px;">/usr/local/lib32
 :&nbsp;<a href=3D"https://paste.ubuntu.com/p/b67Bxf6cfB/" id=3D"LPlnk27073=
1">Ubuntu Pastebin</a></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
This topic was started a long time ago here :</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<a href=3D"https://lists.lttng.org/pipermail/lttng-dev/2013-February/019641=
.html" id=3D"LPlnk239338">https://lists.lttng.org/pipermail/lttng-dev/2013-=
February/019641.html</a><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Would you mind helping me ?</div>
<div id=3D"Signature">
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"color:rgb(0,0,0); fon=
t-family:Calibri,Helvetica,sans-serif,&quot;EmojiFont&quot;,&quot;Apple Col=
or Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI Sym=
bol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:12pt">
<p></p>
</div>
</div>
</div>
</body>
</html>

--_000_PR3PR02MB62022F27BFAE30836B7E094ED17E9PR3PR02MB6202eurp_--

--===============6840519023607675616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6840519023607675616==--
