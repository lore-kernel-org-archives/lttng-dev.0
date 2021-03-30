Return-Path: <SRS0=+kpx=I4=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738CEC433DB
	for <lttng-dev@archiver.kernel.org>; Tue, 30 Mar 2021 22:29:36 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59255619C1
	for <lttng-dev@archiver.kernel.org>; Tue, 30 Mar 2021 22:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59255619C1
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F93z14dp8zRLr;
	Tue, 30 Mar 2021 18:29:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617143374;
	bh=PwsXXqz8/0XUJSIsDOX9ELBzlY0pP0C0bPzo8K8G0aA=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=FbJVNSMkzzgqeKFcexNtCnUsAZaHnD4fVKY/iXkqpKMe1kPTA+P50q7FhJ4f7VWKz
	 NZMUJnfH1RtNZ/mIODlX404GpPi15L5nnjLS4qGxQ9MDPKDvNizgprKwS5LXlaW6xm
	 aQIcqhk8zJMhUzAVEjrTtvENIGIX+IqFi4pRMHOkcXUP9XbQZrp7gvpkljKgdzJGIf
	 AlHvJzSOkVGsuvjCQTUO5kkZBazhUZmZesPGMDWWb9rIUDpXuw1MLI/BIolX10qtFM
	 ySkMCj5V5eHwMCQq9VhSMSGyR9psBE76nD3SNszLKzBU+RCsIbiMrmuFtAPnG+DlDR
	 weBkGu70jFWKQ==
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30053.outbound.protection.outlook.com [40.107.3.53])
 by lists.lttng.org (Postfix) with ESMTPS id 4F93yz5StRzR0T
 for <lttng-dev@lists.lttng.org>; Tue, 30 Mar 2021 18:29:31 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enqBJD7rEgJ3mMaKU3JObdofqHMdJB5ankxBPWc62QW4BUW584hNSssgSjSW7rIfQjdEGan6JG0tgFiwApbup4i2RDbOlAabVhuSbIB4fYsVGj3qLib5AHTT3IMvZifoVKN4aeJ78js2ueI3znb4Riz3Y0ZvBcsxrn5nw4EFn6/IcslD5E+K6t7k0K2RfMwX08m00Nd87+eAbBLsNQtI5jtGDtYyeGw0OWV8/1Z1WZNF5nsejJdjEfLVvc1svXuEL56pM7Uug9BGoSqYKePDDnov5wGbW6xxOHk04dCuEAV9xl+1D3jj+htfuYqinlkj5PVAWmH9izJeHD8v2hJahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCacG+v+G1BEOoUTGeV2qIc3SKviyRsVKZfyD+hKXRM=;
 b=lB0yYholsHJp9BVFdAqgva8Ufbtv30FEJBd6G1e+Rz/Upur7NJo31vb2hb6iORjYBUFSVqoO02KVOeI5QDdY8pPlMHwaYrwDrHPuUD3FE03nRD9AlgmXPf3y+3/imMxlKq6MAf4YK6w0gQheSMUczzg6hlOSXGCHk24I5aTSA64JhHfyl0652M1oIy1oq5UwNHwPxQHUNCFW2BRLehqmn+PRTN4vejZqATWLah+vGicAl2lH0mA7Bs1YZPh5NvFA4HwIn4tsi+21wkqPP6pZKTMTQa22MtzXYhqbhjJr8Hya0xgdEdUk/zrWbUcO1rkSNBWy6WbKFMpC2ZR6QNt35Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=reseau.eseo.fr; dmarc=pass action=none
 header.from=reseau.eseo.fr; dkim=pass header.d=reseau.eseo.fr; arc=none
Received: from PR3PR02MB6202.eurprd02.prod.outlook.com (2603:10a6:102:63::15)
 by PAXPR02MB7277.eurprd02.prod.outlook.com (2603:10a6:102:1cc::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 22:29:23 +0000
Received: from PR3PR02MB6202.eurprd02.prod.outlook.com
 ([fe80::9183:a57e:a921:f482]) by PR3PR02MB6202.eurprd02.prod.outlook.com
 ([fe80::9183:a57e:a921:f482%6]) with mapi id 15.20.3999.027; Tue, 30 Mar 2021
 22:29:22 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: Question/Issue compilation ARMv7 of LTTng
Thread-Index: AQHXJXWueG7dtromgUKtC8j2TzaTtQ==
Date: Tue, 30 Mar 2021 22:29:22 +0000
Message-ID: <PR3PR02MB62022E6EDD042CC2AD58D173D17D9@PR3PR02MB6202.eurprd02.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.225.20.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b23cdd49-3207-44cf-13a7-08d8f3cb4492
x-ms-traffictypediagnostic: PAXPR02MB7277:
x-microsoft-antispam-prvs: <PAXPR02MB7277FB1F49B93FC962944F96D17D9@PAXPR02MB7277.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E3WwrXGYKMZrcH69rOouCGU3kI+BRP5TqvudnvvQ2X6OqH2pjQVlcOglkhNMgoKglyd1HE9UQw/BJmGHv8LVG9RIo5i0aJ0ufFt/uOFdUIYcCGg1NI8mjsSMIkrsAtaWIYzHSRVXJd+2/yS4FZnO7syTezp2kOQsJuBRpfmYR4Ef9hFI5yqPnRUU6HjBNPPjuyS4AyA2KJfiI5qHI2lukUGNrq+tmbIV7OsAdYYzWcGC7t7Tji5m+B0ZWARcRbRF+jkUa/sTrkGP9EA6BuhUXjGNOVzjhOvvxTYNPLUdu7b9Ljp/jmO27Kmeqr3lRLuB3UvEytgkP9+OhXMP1/rmObvDNwYN5WVzj3k3Yv1LazW35v2qKMM1VQfwUtDPpFrifm5DE25ajr5bZBcNOpi2JeBVGYq6JUvAXw6N5QHBmEz0TAg8CgkzGHMqBGB18OJSJXVf1PjpDrRLPrxzgSvvS389+BZHc/zPuiXzZWJGKOL4lxnVKHsdF0cyd0DceRA3GJzcmUa9RnT1FKLsKciUZhZS8uXdp9RIhCgrYe4Nw3GmApo0tpmYnhptivGDFvWOh1yoRyKuGD9NXgy+tRSGbMnAgkNfoXtqNkNEYRWBFVBUy5pc8c2E28UNrxaPJS+9N3YmXCEXEmPLoAT4AddCxyuQfKo4tJ1pSbghmb4lXLoiH2O3yXHIN3gjY5gLjtkAWJ1aFmGIA7Q3QB8ClnNmEqJnFeZirBtzuKdCfFC5/oU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR3PR02MB6202.eurprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(346002)(39830400003)(376002)(366004)(396003)(5660300002)(86362001)(71200400001)(478600001)(52536014)(55016002)(9686003)(786003)(966005)(7696005)(8936002)(8676002)(6506007)(38100700001)(55236004)(2906002)(64756008)(76116006)(6916009)(66946007)(186003)(166002)(66476007)(66556008)(19627405001)(33656002)(66446008)(316002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?5b00vr40814Nk8h9vOZYC851gDjgEYJZTxAVMSxPK3Wrw/Xsfos/x+9xZs?=
 =?iso-8859-1?Q?SBdFsIuElEnb0U9n4b6saANfybDJ1AADLw/0n8XHhHLAnpirByrkYe7es/?=
 =?iso-8859-1?Q?kqkvQrikUcCt6rPRr/DfNsKWbVOp2TEJLV4w88SXv8sN9FBDYU1npF6eNi?=
 =?iso-8859-1?Q?kbDUa5z0w0M692MTo5yxsif1uN3XQhgJk2j+KwSLJNSYImFieUFXuIPgbe?=
 =?iso-8859-1?Q?6him2TYrgZxjEAyPEUApZz94Z83JqCWrAiR4YQqXhcY5IHxYOgt5KcB/ey?=
 =?iso-8859-1?Q?PKRqOQKAkEkcsRq+COE05FfwKmPS+oESmaQlxmnKvXi2zgd5SOLE9jfjOo?=
 =?iso-8859-1?Q?4QeOn0a8y+GRi2YFZa2hzNvSh3nGylx/cLSG3KEMfDYNXN9SUowVM+MQq4?=
 =?iso-8859-1?Q?oPTT7Xfn+uAo92Yll/9C1AnUYrjhoGjedLcNjSJp7OdJLWZnIXm/5gX0EX?=
 =?iso-8859-1?Q?Vd7Bg3QNQffcQZ2lyhxvdPj8yLhqVYZUgpIlOOO30Jcy6OEdzvu7POuqH9?=
 =?iso-8859-1?Q?ZIiinRI3rgWyvd7pJSBsc4UK6ThJWArQC8u1N5OO8tAkRT868eN+Vqc7dO?=
 =?iso-8859-1?Q?PcCp7yVVu4iVEBRq8QQWan+rNMgF/PAzK8JC4eJoPHyQeRc3FbbJkSh1Hu?=
 =?iso-8859-1?Q?vkgaTGM5NS3GglkbVvUAW2OnD6slOXXQCvbtQm7eTmLzBrvAhgXDmwrpyi?=
 =?iso-8859-1?Q?ZkcEXsJLtT7YoeqBpNbEtKOtonFOy98wR/gSu5Rie1hFGSJR90a1PhCa4C?=
 =?iso-8859-1?Q?caUpAMd1LEgKRQ9rO2gQSyCRXFBIZTL8aCyKo0vYxwPLuu6sn92/hcQD8y?=
 =?iso-8859-1?Q?qxu/7MuJ/ghTLlO70tjMomZ2W5nay3TPE1FOg1UJbJUnNYzDNfRKlE9Z9d?=
 =?iso-8859-1?Q?l8sXI8JG3Hl4QXGiponsn5yNSpqBqm1JXH0gC880Oj0B8SXqtKq+nNqTnS?=
 =?iso-8859-1?Q?rbuUHriBY1ekzmNNQiOj+iAIhZ8rx4iOs1YE4UH6RlVxwZXtBd0nUKSgPn?=
 =?iso-8859-1?Q?edPMHtZ5l5VyAVcOatqpSicS9ATzpu7zc9GdBZdgh3oLyAS2VKjpgGeypK?=
 =?iso-8859-1?Q?zHYTj2RP0e3kDGqG0O4wapAC2k8Ocr4JZKkriAA2IiT/c7hGJj31Xe9WVG?=
 =?iso-8859-1?Q?MWV4svWQEfBgtKhIXfxbaIW2DDkpZtnkmEMLFWtwUb/pyCQj5oPcClVaot?=
 =?iso-8859-1?Q?lzF/Jc/Xr0v+4/wNN3ii/GSVuhNj3flq7wEW42t27EbU7GKZ//OoakaGi+?=
 =?iso-8859-1?Q?wcLddV2eFt3W66Avre6/hpsIN2QTzvn7DYknRHTuo78MSCqtj3zbJv4n45?=
 =?iso-8859-1?Q?roS6rL0aI1xEnBUv6m77sRhVirBZVjIk+CMFd7PtlgNAWeg=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: reseau.eseo.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR02MB6202.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23cdd49-3207-44cf-13a7-08d8f3cb4492
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 22:29:22.6065 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d7ad159-1265-437a-b9f6-2946247d5bf9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w97SyXzuXXs8tv/MauZw9ZJjcxE8XQILpxYmzo+rz4lzZy8GI2UMGZy7lDa2JvkTaAqaJ1zzuI03BAitgJoz8v6zGsysvKzecSglQsjuOic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7277
Subject: [lttng-dev] Question/Issue compilation ARMv7 of LTTng
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
Content-Type: multipart/mixed; boundary="===============1266968474009915462=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============1266968474009915462==
Content-Language: fr-FR
Content-Type: multipart/alternative;
	boundary="_000_PR3PR02MB62022E6EDD042CC2AD58D173D17D9PR3PR02MB6202eurp_"

--_000_PR3PR02MB62022E6EDD042CC2AD58D173D17D9PR3PR02MB6202eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello the developpers !

On my side, userspace and kernel event are working for both x86_64 and 32bi=
ts on Ubuntu 20.04.
One of my main goals is to use LTTng on an armv7 target (Raspbian 32 bits).

I am using Docker to create the environment and to compile the image (Debia=
n 9.3).
During the compilation of RCU, I get :
#10 5.868 checking whether the C compiler works... no
#10 5.982 configure: error: in `/tmp/tmp.T2I20x25bo/userspace-rcu-0.12.2':
#10 5.983 configure: error: C compiler cannot create executables

My question is the following : Can LTTng be used directly on arm ?
https://lttng.org/docs/v2.10/#doc-instrumenting-32-bit-app-on-64-bit-system
I read again the tutorial and it seems we always need a 64-bits platform.

Find below a part of my Dockerfile (that looks like the tuto):
# LTTng RCU - 32 bits
RUN bin/sh -c 'cd $(mktemp -d)' && \
    wget https://lttng.org/files/urcu/userspace-rcu-0.12.2.tar.bz2 && \
    tar -xvf userspace-rcu-0.12.2.tar.bz2 && \
    cd userspace-rcu-0.12.2 && \
    ./configure --libdir=3D/usr/local/lib32 CFLAGS=3D-m32 && \
    make && \
    make install && \
    ldconfig

I tried to run the installation on the docker file of gcc-multilib, build-e=
ssential, wget... but it doesn't work.

Cheers,



--_000_PR3PR02MB62022E6EDD042CC2AD58D173D17D9PR3PR02MB6202eurp_
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
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"font-size: 12pt; color: rgb(0, 0, 0); font-family: Calibri, =
Helvetica, sans-serif;">Hello the developpers !</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"font-size: 12pt; color: rgb(0, 0, 0); font-family: Calibri, =
Helvetica, sans-serif;">On my side, userspace and kernel event are working =
for both x86_64 and 32bits on Ubuntu 20.04.</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"font-size: 12pt; color: rgb(0, 0, 0); font-family: Calibri, =
Helvetica, sans-serif;">One of my main goals is to use LTTng on an armv7 ta=
rget (Raspbian 32 bits).</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"font-size: 12pt; color: rgb(0, 0, 0); font-family: Calibri, =
Helvetica, sans-serif;">I am using Docker to create the environment and to =
compile the image (Debian 9.3).</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"font-size: 12pt; color: rgb(0, 0, 0); font-family: Calibri, =
Helvetica, sans-serif;">During the compilation of RCU, I get :&nbsp;</span>=
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"font-size: 12pt; color: rgb(0, 0, 0); font-family: Calibri, =
Helvetica, sans-serif;">#10 5.868 checking whether the C compiler works... =
no
<div>#10 5.982 configure: error: in `/tmp/tmp.T2I20x25bo/userspace-rcu-0.12=
.2':</div>
<div>#10 5.983 configure: error: C compiler cannot create executables</div>
</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"font-size: 12pt; color: rgb(0, 0, 0); font-family: Calibri, =
Helvetica, sans-serif;">My question is the following : Can LTTng be used di=
rectly on arm ?</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<a href=3D"https://lttng.org/docs/v2.10/#doc-instrumenting-32-bit-app-on-64=
-bit-system" id=3D"LPlnk"><span style=3D"font-size: 12pt; color: rgb(0, 0, =
0); font-family: Calibri, Helvetica, sans-serif;">https://lttng.org/docs/v2=
.10/#doc-instrumenting-32-bit-app-on-64-bit-system</span></a></div>
<div><span style=3D"font-size: 12pt; color: rgb(0, 0, 0); font-family: Cali=
bri, Helvetica, sans-serif;">I read again the tutorial and it seems we alwa=
ys need a 64-bits platform.</span></div>
<div><br>
</div>
<div><span style=3D"color: rgb(0, 0, 0); font-size: 12pt; font-family: Cali=
bri, Helvetica, sans-serif;">Find below a part of my Dockerfile (that looks=
 like the tuto):</span></div>
<div><span style=3D"color: rgb(0, 0, 0); font-size: 12pt; font-family: Cali=
bri, Helvetica, sans-serif;"># LTTng RCU - 32 bits</span>
<div><span style=3D"color: rgb(0, 0, 0); font-size: 12pt; font-family: Cali=
bri, Helvetica, sans-serif;">RUN bin/sh -c 'cd $(mktemp -d)' &amp;&amp; \</=
span></div>
<div><span style=3D"color: rgb(0, 0, 0); font-size: 12pt; font-family: Cali=
bri, Helvetica, sans-serif;">&nbsp; &nbsp; wget https://lttng.org/files/urc=
u/userspace-rcu-0.12.2.tar.bz2 &amp;&amp; \</span></div>
<div><span style=3D"color: rgb(0, 0, 0); font-size: 12pt; font-family: Cali=
bri, Helvetica, sans-serif;">&nbsp; &nbsp; tar -xvf userspace-rcu-0.12.2.ta=
r.bz2 &amp;&amp; \</span></div>
<div><span style=3D"color: rgb(0, 0, 0); font-size: 12pt; font-family: Cali=
bri, Helvetica, sans-serif;">&nbsp; &nbsp; cd userspace-rcu-0.12.2 &amp;&am=
p; \</span></div>
<div><span style=3D"color: rgb(0, 0, 0); font-size: 12pt; font-family: Cali=
bri, Helvetica, sans-serif;">&nbsp; &nbsp; ./configure --libdir=3D/usr/loca=
l/lib32 CFLAGS=3D-m32 &amp;&amp; \</span></div>
<div><span style=3D"color: rgb(0, 0, 0); font-size: 12pt; font-family: Cali=
bri, Helvetica, sans-serif;">&nbsp; &nbsp; make &amp;&amp; \</span></div>
<div><span style=3D"color: rgb(0, 0, 0); font-size: 12pt; font-family: Cali=
bri, Helvetica, sans-serif;">&nbsp; &nbsp; make install &amp;&amp; \</span>=
</div>
<div><span style=3D"color: rgb(0, 0, 0); font-size: 12pt; font-family: Cali=
bri, Helvetica, sans-serif;">&nbsp; &nbsp; ldconfig</span></div>
<span style=3D"color: rgb(0, 0, 0); font-size: 12pt; font-family: Calibri, =
Helvetica, sans-serif;">&nbsp;</span></div>
<div><span style=3D"color: rgb(0, 0, 0); font-size: 12pt; font-family: Cali=
bri, Helvetica, sans-serif;">I tried to run the installation on the docker =
file of gcc-multilib, build-essential, wget... but it doesn't work.</span><=
/div>
<div><span style=3D"color: rgb(0, 0, 0); font-size: 12pt; font-family: Cali=
bri, Helvetica, sans-serif;"><br>
</span></div>
<div><span style=3D"font-size: 12pt; font-family: Calibri, Helvetica, sans-=
serif;">Cheers,</span></div>
<div class=3D"_Entity _EType_OWALinkPreview _EId_OWALinkPreview _EReadonly_=
1"></div>
<br>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
</body>
</html>

--_000_PR3PR02MB62022E6EDD042CC2AD58D173D17D9PR3PR02MB6202eurp_--

--===============1266968474009915462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1266968474009915462==--
