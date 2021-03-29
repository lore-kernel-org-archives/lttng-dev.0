Return-Path: <SRS0=Aspu=I3=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2695AC433C1
	for <lttng-dev@archiver.kernel.org>; Mon, 29 Mar 2021 13:25:00 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E91A861932
	for <lttng-dev@archiver.kernel.org>; Mon, 29 Mar 2021 13:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91A861932
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F8Cx50V9mzQT9;
	Mon, 29 Mar 2021 09:24:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617024297;
	bh=VDcPIVHr/ZK0fE2JwPJrM95+W5xh0tZjH4Ewifavn7I=;
	h=CC:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=rBzSf17bYswoet6tlH3m4w4h1ayQB8Kk9Vvxi2uJtWgQ6a/iJMf9l3yobEEeRmc9V
	 Jje3Ctoxo1jD0Q/XgLG2kkthXYk4hnoniJx65WJDLSpJxwbxVjY+tv2X1czSehSbpQ
	 cWqUYdcDxufxF4t9y+CJYj59MbxQWFhHwZFY55uP9wChbBPX855/Ux/UWyxSTGjmAs
	 nyNfbX0l3RnKHUfAa6Oeoy1SgqyNk6IG9fhJrTYLnfE4j8vG4poWTg2e4LviGYCAcM
	 LdqIKJ9kZ/8E1dQhvubhaRhsfRzp6mcK/cGbFI2YTiO4zP3K42lbCfMY6jNRi5LZ1H
	 A3knbKezshEvg==
Received: from FRA01-PR2-obe.outbound.protection.outlook.com
 (mail-eopbgr120052.outbound.protection.outlook.com [40.107.12.52])
 by lists.lttng.org (Postfix) with ESMTPS id 4F8Cx22TcLzQL3
 for <lttng-dev@lists.lttng.org>; Mon, 29 Mar 2021 09:24:54 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TO2EurwyvRYK0ioKPDtdyytflH4LQtM1dqoYiSXfWBoZV25e9nMXCtgHcvOnXBOKAGC0goL1barTz2L1lTqLv8S8zUzQKnXOXwm5MzySDf0xtsMpEqvwh0T4GP7CjKH90puo2l4dmhWvi5fPVPjgrjXaBYxVuh71CP5d4iI9o6qsBzrgAqoRkKptIeXbsKbBDyAmc4dvfXX6ex2X/SeVbUix6RToBqCQS/UimbHlwcghLtnrl8fwxJtSxOArDu1GDMvKJdpUluDU39OtUGybJSRHAFrWsj5SPG/Lwd/4p78ZzTlasJ+paSZVHfTx0bGEnckCIETnMAjTobBbwhW1sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1uhKfcMPn/yteM266V1uH/vTqA5O93jEQp4k/nKHxc=;
 b=ksG+MxsIzqmcTwyzmiGuF4qWYtqGAu8A+mzc14nR4nr1hlFydNQEZ4Yd1zRHuaRA88x+ZgJmMkJ1KLuxTO6lP8+QJjpUsMKU+tztYHLWqKDSFcg+AKsiWcGp5MIe4px87ga5TTy0XEd+4JMGoH4oDCdiYfdyDtYrwaVAQuk1qkjpwQ4f/QyHDTB6V5yTNDs0l+L93q8mD9yGFB8SoZgUA2OyFOqZKiHu8jna9PpWhrsZme58Rz/BmDIWbN6QFdCllUvTv60Qm1/et3YON5oNKhvqSgX8AAq5Saw5T7dbtxYAu5FtC+EtR6eXTcjQSp3XtA3xXwKk+T7SF9g3PEdW7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=reseau.eseo.fr; dmarc=pass action=none
 header.from=reseau.eseo.fr; dkim=pass header.d=reseau.eseo.fr; arc=none
Received: from PR3PR02MB6202.eurprd02.prod.outlook.com (2603:10a6:102:63::15)
 by PR1PR02MB4681.eurprd02.prod.outlook.com (2603:10a6:102:c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Mon, 29 Mar
 2021 13:24:49 +0000
Received: from PR3PR02MB6202.eurprd02.prod.outlook.com
 ([fe80::9183:a57e:a921:f482]) by PR3PR02MB6202.eurprd02.prod.outlook.com
 ([fe80::9183:a57e:a921:f482%7]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 13:24:48 +0000
CC: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: LTTng 32 bits : Cannot find liburcu-bp 0.11 or newer
Thread-Index: AQHXJHzLqHvA9992nUqnoJi/yO/byKqa9Fj6
Date: Mon, 29 Mar 2021 13:24:48 +0000
Message-ID: <PR3PR02MB62020781F58EA33A0430FF02D17E9@PR3PR02MB6202.eurprd02.prod.outlook.com>
References: <PR3PR02MB62022F27BFAE30836B7E094ED17E9@PR3PR02MB6202.eurprd02.prod.outlook.com>
In-Reply-To: <PR3PR02MB62022F27BFAE30836B7E094ED17E9@PR3PR02MB6202.eurprd02.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.225.76.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ade9431-0264-46d8-5b27-08d8f2b60717
x-ms-traffictypediagnostic: PR1PR02MB4681:
x-microsoft-antispam-prvs: <PR1PR02MB468191371910768A81E44FDBD17E9@PR1PR02MB4681.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SMZI5H0fDBwZovg6N2rER6hvuvgpMiiF8ATs7pgb5niHCZuvcaGj0P3C5z8ij40VvbIi2afwQNrDfkiY2C24n1QVskz2ZCSwfBeRMipblsMT6EJakhdJUhIopfKqjQ3zP8BedhPsaUfb+71kUSMQ+yWHwpsazc9D4pzHMzoUv8sgPE1YlEhuIMzzwTcNn5NyvRhI+mF10TdF/Zjd7xdfgcFywWVQE/XTuNYzcUc09b6bTt1TLPospiLwWu9aRjqkBGqaQ+HZhyik6zCAA0DxXJKSs5usIkvpiu4MIuzf0K2o322ed5iUNUJNRbOoa7k/miqg0yFPFxQeQUgIsWBaGCSTBfCoHyREZ05jM9cEKYEUpYX6IKdD3NqwRD+6c5r2o/IZRAVP4ew5CHwQkiVBRg3oL2ry7MzugyLXlI4zFsAR8l+XFyhSrfvKh9MErQDgzs/P3kNHyN5eDNVm1W51OJfRvGrvfUUQ5u9NTBfbKAabGFAtxapIrXaMGgStfepDiY5M2+o76tA+VakKXcSXE3CZBOSGgUGKilOyLP+5aJ1BMGdERxNGRooGbeBoXZe4pwrJ4lWjiLeh7033Nx4QIfB6op8rwvTR9JwK7s0BprQW+3LGDv/xxpTRBvkvug1p7Pu69cN/wdX8Ieti1P7sCd4O/V0NfpGM4jtPwXHzNKxbRVrA+Y091pBOHo84z2VPUJ2cKRhw9wfm4pbVy0yoljp0luaCAsTwz+CsOxzYCpY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR3PR02MB6202.eurprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(39830400003)(346002)(396003)(376002)(366004)(2906002)(8936002)(86362001)(19627405001)(71200400001)(52536014)(186003)(55016002)(5660300002)(109986005)(8676002)(26005)(966005)(478600001)(66476007)(66556008)(66946007)(76116006)(21615005)(64756008)(4326008)(6506007)(166002)(33656002)(55236004)(2940100002)(38100700001)(316002)(786003)(7696005)(9686003)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?U81MY99aFYelthip+xPshgATnE0JtDGugQ5UzUqdVW2wYVOzTZJIkAn7rd?=
 =?iso-8859-1?Q?6cTrdvFqXOrYFMkRFVOFCMrREV8InFHKWnv83EbNQY1K1OXjUJMQdook/l?=
 =?iso-8859-1?Q?cc1EU5RQIbxcHZpzvmARbKdklHT07CCyKOWCCW3wHvwm5+tPZ003KUhj7h?=
 =?iso-8859-1?Q?TEG9Caqqapztzq0JkiXQ5G32E3iLcQ7ih/dDrtiT0S8IePhV0EoBD+r3x+?=
 =?iso-8859-1?Q?RegmqJ/ernFH3xrF90Oo28vZcvyEqcD32XBKhWFrtx05z+sVf2Pq4FLShj?=
 =?iso-8859-1?Q?1P2ycjeaxVDZPKtMnbfYT+tiUWYep74HudlZi4XTLZ+EjcKEOptulivkbB?=
 =?iso-8859-1?Q?lcnG5CRBdcANF41fcG+XJTsWHopR+1Qplzdd7w0nSBHX0Sydfcbogvd9x8?=
 =?iso-8859-1?Q?iyk4AAS3U4xAXbjUmE0itJAAVgk0I04G426BafyTY+58g+G2pt5iiiBGP+?=
 =?iso-8859-1?Q?DBiTOcMRyrPFA4ODdxU/kPRq7gWR5a/wf/MKK1L0O9DzMKC+O5Hod6tqjg?=
 =?iso-8859-1?Q?qBa6VpQvv9UvfimmTQiLF93y8levDN1oMrZ/AvXDswbE741Aliyh5r2XLi?=
 =?iso-8859-1?Q?DbVjoA+8XYE3dQy6tgTwaqaFCDYXfHRG9g2yzYO3EZmxl9UDdcPyf9Hkqz?=
 =?iso-8859-1?Q?LJl82pjI74xq6ODrmpYv2gcRgCe3Eh7tuIAIJLcCQHIngvxl6tAgZkE5vm?=
 =?iso-8859-1?Q?6HT4U7XqWZsFzjjLpy5F7db9QSf24QVCJcT/X6GFlwBvz+PdBMv3Kt24Z4?=
 =?iso-8859-1?Q?a9Cqgr8C5Jt2uBcPL5a9j29Bpuh8dkE98R8xyKGRfQ226fbdMVsf7YQSBg?=
 =?iso-8859-1?Q?hV6gyfJvQXxpZfmpy6kEv5WoP6Jokx7Qvyf1AFUo33wQz3+30ZWPJyne2f?=
 =?iso-8859-1?Q?IRWR1XtUtjSwOOfzWrXEmRZqCOrxXe08bojWW7ISd8yeU3WVS8+/lIS8Fq?=
 =?iso-8859-1?Q?5hsoJVG82SFBSetFS4+hgBVQFcbmTI1mvy3aDX+EwdTGbG7AeVIj9FJB9y?=
 =?iso-8859-1?Q?5+5sK5IyyUMZyijyGU92LBRHgjGDCv3je5FRlc/vhjR1Q24AlQgrToszbx?=
 =?iso-8859-1?Q?LN6t3yoIlha4mZ66APWuq89rxh9SuVpmI1ih0DaoC2ggoTDAYymWc7omTa?=
 =?iso-8859-1?Q?NlKn38IAU0RQIsuhBj3mgWVDad4bnuGwWJX/w/yvQLBCjYagMER2sBlLNA?=
 =?iso-8859-1?Q?ey1D42wrY26zhEH433vAatnCcHmU7IR7OvXQuCbB7xHgg+oheYXhD6sZxa?=
 =?iso-8859-1?Q?S/PLhLbNHE8pqT/I3Ksm5EW0spNtDP3xwWdvQTYxg4WsUsaEuoBHyu54NP?=
 =?iso-8859-1?Q?svIZegACuyJopNdpCqgUGhX7GTPThCQOG18+AsB10nqi9r8=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: reseau.eseo.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR02MB6202.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ade9431-0264-46d8-5b27-08d8f2b60717
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 13:24:48.8531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d7ad159-1265-437a-b9f6-2946247d5bf9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eSS3ONgCOxP944a1NWTpXuOmm6EvPdImeRRtKT7ko6Hxu5VXCApaCvwU9i/BnXcOflBXXmabMQIIhzafpkttUW0JRQ4K6KhKmIGkCS+Dwfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR02MB4681
Subject: Re: [lttng-dev] LTTng 32 bits : Cannot find liburcu-bp 0.11 or newer
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
Content-Type: multipart/mixed; boundary="===============6271039415378452517=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============6271039415378452517==
Content-Language: fr-FR
Content-Type: multipart/alternative;
	boundary="_000_PR3PR02MB62020781F58EA33A0430FF02D17E9PR3PR02MB6202eurp_"

--_000_PR3PR02MB62020781F58EA33A0430FF02D17E9PR3PR02MB6202eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Oh my bad !
You just have to choose modify the lines of the tutorial (rcu).
I chose userspace-rcu-0.12.2.tar.bz2<https://lttng.org/files/urcu/userspace=
-rcu-0.12.2.tar.bz2> and it installed well.
________________________________
De : MONTET Julien
Envoy=E9 : lundi 29 mars 2021 11:43
=C0 : lttng-dev@lists.lttng.org <lttng-dev@lists.lttng.org>
Objet : LTTng 32 bits : Cannot find liburcu-bp 0.11 or newer

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

--_000_PR3PR02MB62020781F58EA33A0430FF02D17E9PR3PR02MB6202eurp_
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
Oh my bad !</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
You just have to choose modify the lines of the tutorial (rcu).<br>
I chose&nbsp;<a href=3D"https://lttng.org/files/urcu/userspace-rcu-0.12.2.t=
ar.bz2" style=3D"font-family:&quot;Times New Roman&quot;;font-size:medium">=
userspace-rcu-0.12.2.tar.bz2</a>&nbsp;and it installed well.</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>De :</b> MONTET Julien<br>
<b>Envoy=E9 :</b> lundi 29 mars 2021 11:43<br>
<b>=C0 :</b> lttng-dev@lists.lttng.org &lt;lttng-dev@lists.lttng.org&gt;<br=
>
<b>Objet :</b> LTTng 32 bits : Cannot find liburcu-bp 0.11 or newer</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Hi everyone,</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
I successfully installed and used LTTng on x86 and x64 (kernel event, users=
pace, and other tools like TraceCompass).</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Now, I am looking for a way to use LTTng on other processors (arm32, ...).<=
/div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
I tried to follow the tutorial and, to be honest, I am quite not lost on st=
ep<span style=3D"color:rgb(0,0,0); font-family:Calibri,Arial,Helvetica,sans=
-serif; font-size:12pt">&nbsp;2. (libuuid, popt, libxml2)</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"margin:0px; font-size:12pt"><a href=3D"https://lttng.org/doc=
s/v2.12/#doc-instrumenting-32-bit-app-on-64-bit-system" style=3D"margin:0px=
">https://lttng.org/docs/v2.12/#doc-instrumenting-32-bit-app-on-64-bit-syst=
em</a></span><br>
<span style=3D"margin:0px; font-size:12pt"></span><br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
My current issue is on the step 3.&nbsp;</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
During the installation (./configure), I have the following error :&nbsp;</=
div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<b>error: Cannot find liburcu-bp 0.11 or newer. Use LDFLAGS=3D-Ldir to spec=
ify its location.</b></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
This file - liburcu - is in&nbsp;<span style=3D"color:rgba(0,0,0,0.75); fon=
t-family:&quot;Andale Mono WT&quot;,&quot;Andale Mono&quot;,&quot;Bitstream=
 Vera Sans Mono&quot;,&quot;Liberation Mono&quot;,&quot;Nimbus Mono L&quot;=
,&quot;Ubuntu Mono&quot;,Monaco,Consolas,&quot;Lucida Console&quot;,&quot;L=
ucida Sans Typewriter&quot;,&quot;Courier New&quot;,Courier,monospace; font=
-size:12px">/usr/local/lib32
 :&nbsp;<a href=3D"https://paste.ubuntu.com/p/b67Bxf6cfB/" id=3D"LPlnk27073=
1">Ubuntu Pastebin</a></span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
This topic was started a long time ago here :</div>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<a href=3D"https://lists.lttng.org/pipermail/lttng-dev/2013-February/019641=
.html" id=3D"LPlnk239338">https://lists.lttng.org/pipermail/lttng-dev/2013-=
February/019641.html</a><br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Would you mind helping me ?</div>
<div id=3D"x_Signature">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"color:rgb(0,0,0); f=
ont-family:Calibri,Helvetica,sans-serif,&quot;EmojiFont&quot;,&quot;Apple C=
olor Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI S=
ymbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:12pt">
<p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_PR3PR02MB62020781F58EA33A0430FF02D17E9PR3PR02MB6202eurp_--

--===============6271039415378452517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6271039415378452517==--
