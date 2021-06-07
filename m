Return-Path: <SRS0=w+6D=LB=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E2CC47094
	for <lttng-dev@archiver.kernel.org>; Mon,  7 Jun 2021 21:19:19 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0BE26120F
	for <lttng-dev@archiver.kernel.org>; Mon,  7 Jun 2021 21:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0BE26120F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=tempfail smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FzR810PNLz8Vf;
	Mon,  7 Jun 2021 17:19:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1623100753;
	bh=mp5tCh2pS+nxZzXewlrB0Gkh3v9nofC208absxFJbcU=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=M0B9VHxOuiFk7ktL65z7imUULlK6l42oEvQk5pWk7K6Zt88Uth8sErmYpCjXsde/z
	 IJ4mhrUXA2cxEjY/w260hwMWbO7VzpYKBqD5glBuYa2PhjJTgVeELlT9giwsOageGn
	 huId7P2xCNomD5okXq5r9rNDFYj85rsy1SDH/6TLXMjZelZpDbeULfrsu+3h+muPQd
	 0mUx1ha7z1XNu1ea0NxMnDEFqMl0kye4ziqagSZiz0IhDrxaLmwODJKuBc3w2hLqRD
	 si5bk+q4wLQNUihO33MN+Dgcnx7L5CYOVDr9ZgRq+Av4Mr/KxyK7F5oF7RwKum4IqH
	 7zsqfG9/zHK3g==
Received: from FRA01-MR2-obe.outbound.protection.outlook.com
 (mail-eopbgr90053.outbound.protection.outlook.com [40.107.9.53])
 by lists.lttng.org (Postfix) with ESMTPS id 4FzR7z08cmz85Y
 for <lttng-dev@lists.lttng.org>; Mon,  7 Jun 2021 17:19:10 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiG2TZfVPYpY+oosUJyKZpOMSlBS0dqeqnkyu9n66z35lTusOCMPUZgSB4GOhr0w7ujez3Wnx77Srd/Sg1zhiNR8iq+LIA1pfRcShLC5vZCykfALRwWyttVzJxIVVztQhgHe37pFyIcmdZKpXV+Vv0BeJD68bRQunLSZpfIigfX/5cY4wb30qCLvTR3cNy0U+mRBBSSDdGRL0HgcbBs2folamtGcc7bl3hRB/SiuXuK662eZEZ2U4pBw9ayqhdzavve49twC5e7Gz/l1b8D+6Ci+NAXCy0saSsAbiFMs1k0VGjn9T+jHdEPtfZUx8Qy9iguIgJd5wkbjiOXFHXRz4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgkKk8Dtmu2GZfXalxx9OMaml/e18/2/V/28PZkYMtc=;
 b=kRKjcntP2OKQpBm8zDXdl5rPHkEZ0SRAPTle6ytd5u4w7S9oKk3ZcctXAURud9jGrloCpb1pVVXYfXKZLbwSruS6hUsk2LmdSOXvZBUWAIJQLQ8ppH7lvZqhOoGUgba3bAGs04OdKZEbTzpa5jhnffE/HcbtwxfaX2j4Z6w0L/iV7vKE9hhdZmlHC9FIDPa8IWT+adSMuMoJBzD1CcLg4OwquW51M7l58hiLf3lf7cApt8Jq66hQXJYtsoA4IqcFru/b83Jugmus/O5+c9gGQeIlsJS7Td3mgsjgdnWLdKZHpXymeLo5Hlr6Tz8GKdmmE9QyqS8L1m/XB+SP9iSnxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=reseau.eseo.fr; dmarc=pass action=none
 header.from=reseau.eseo.fr; dkim=pass header.d=reseau.eseo.fr; arc=none
Received: from PR3PR02MB6202.eurprd02.prod.outlook.com (2603:10a6:102:63::15)
 by PR1PR02MB4697.eurprd02.prod.outlook.com (2603:10a6:102:a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Mon, 7 Jun
 2021 21:19:08 +0000
Received: from PR3PR02MB6202.eurprd02.prod.outlook.com
 ([fe80::c029:efdd:c220:3b82]) by PR3PR02MB6202.eurprd02.prod.outlook.com
 ([fe80::c029:efdd:c220:3b82%7]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 21:19:06 +0000
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
CC: lttng-dev <lttng-dev@lists.lttng.org>
Thread-Topic: [lttng-dev] LTTng 32 bits on 64 bits systems - kernel events...
 but no user-event
Thread-Index: AQHXWTyXrFTi8gSpG0+XSeNSyXv/wIZFEyc2pMOhZpo=
Date: Mon, 7 Jun 2021 21:19:06 +0000
Message-ID: <PR3PR02MB6202A92FD29EA41CDB8CAE56D1389@PR3PR02MB6202.eurprd02.prod.outlook.com>
References: <PR3PR02MB6202F326FC88DD8F3EF90596D13B9@PR3PR02MB6202.eurprd02.prod.outlook.com>,
 <947236961.14801.1623079468191.JavaMail.zimbra@efficios.com>
In-Reply-To: <947236961.14801.1623079468191.JavaMail.zimbra@efficios.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.225.20.117]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d5d592d-a162-4496-60e2-08d929f9e1ed
x-ms-traffictypediagnostic: PR1PR02MB4697:
x-microsoft-antispam-prvs: <PR1PR02MB4697681751684AAC60B93FDBD1389@PR1PR02MB4697.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vSL2X6JdrKEwWZ+O2/q2r1h1Uhjq/1Zbhz4TY1tmat3nyopvz2qypiAAJRpw6zceCaO6uX2qhCJZSOpP+MCNq2OBjZXmyQ6HhDn9yS+t3DQXcC3CBZ5iLiVJDOEPAwiREuqa+7CrAue+rGoal/kPzW/Yje2FjVVJrCzc6Qb2PHsqD2EwkOaXrVPZACwEVxoyEySfa+PXn2bY0xyi6ixem1uKwVo5Qx4B23etCyaB/I4q0mIM8FixDY2ulxGEAgySDU4bhnbS9SdYDaHDFyxk/CZvuarX4xq7MbqvW5syfx2NbZTkqCaBJy6ieCA4jzQ7K53fkvCQgDYp8T3glOs2xndztVWdTh7+OtySY4wnnX/LKP6PqKcbTWWPdZDIeAKH1g0j8ZOA9YnYB3AnOSUEJctd6b0vciJmEyKMqto4jVm27P/eTuuN5cO5UPBA7lBpXfmD1Lxi6AX+K7CJU9JpRYAK37JVEMQ67UvcFP06eBDsnHL3tFGLL0CrSlhVccMZ8vb6VWk9WKPZej7Ug9L1ACJLwCCmeit1EdbYOCjfUe+pOLBdo9jQcCa5bV4SZjCktqoLfeDnT5NEidw+tRfuiNBZxm/62QZ2dcn3n3jCy4G0ps0UEeXOS2W2HN7VHiF/FNSySGxomHeLFA6hZUNgiYzi22fNcwVMCddgpnyRGzfs1Yl+eseIJ1xVL0VoEAAk0zniFXlPBcn+o3BkwAvlbA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR3PR02MB6202.eurprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39830400003)(376002)(366004)(136003)(346002)(45080400002)(6506007)(86362001)(66476007)(66946007)(966005)(55236004)(8676002)(66574015)(71200400001)(8936002)(26005)(166002)(4326008)(64756008)(38100700002)(66556008)(2906002)(7696005)(33656002)(316002)(186003)(786003)(52536014)(478600001)(76116006)(19627405001)(122000001)(55016002)(5660300002)(6916009)(9686003)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WBAugtKRmsiIpVmu5ZNkhO1ZS07Ceh1ceIjgfHGz1Xt9/VmJqmQlvT13Gz?=
 =?iso-8859-1?Q?zr3yG/ZpNC27X+qnnxx8HIVic6Hdj+gW3sTXKJCm3OIxBSPq0Kr2rMDz/O?=
 =?iso-8859-1?Q?o9bx8OXciQnzTFsduzGriz9J6N1vtdfyfAO5voBW2x4Gs5Y/v+JjBbhPY3?=
 =?iso-8859-1?Q?FnBniKWK5K1LcG+Qai+ToCO4J76zQUfehlg2tlqf8vBURrTFIE962srLCy?=
 =?iso-8859-1?Q?Ych4y1M52oY/74Apq/h7s80SJ+3q47ejvtAS6+9nQuW3K4TvNpNALO+5vp?=
 =?iso-8859-1?Q?Fkse8k/88N/J7XDamQs7mHhALmlOhsqjzCOSYaooQo1470Q5trqFGYakiB?=
 =?iso-8859-1?Q?POZxHqSYMKRZco64vAaQyIbsuVAltC/c6Vw7ilx8Rs/jxziLB8CP94iFWR?=
 =?iso-8859-1?Q?8I3+5MLJ5XAWZZfH+PZFSVUMuA02Rsva30PiEAm3tS9J+EkBrM/USe6lGs?=
 =?iso-8859-1?Q?MhDJNaUWpXxlGbusC2gKur8JFWk1qAQfSJ0+bSnSFvJI+tGwgk5P9JPee8?=
 =?iso-8859-1?Q?+z5aSeGNimFSJvrP3igOofHDE9Acrhxrsr/czDEXs2tiEluJVL/3L7rLrI?=
 =?iso-8859-1?Q?FWq8KpY1xPXPyUyln8CbYwyvAIjAPqCd8V3dczANbFH2Yo2tWRe1DxCa2H?=
 =?iso-8859-1?Q?krMuoRkyGgoOxVM8mGWWU6UTwSF9NjLrOiMMrKoWqScNcaCeElGni5lOQ/?=
 =?iso-8859-1?Q?BsrS7SvHlyeVdapH1JuvyVEI2yOtrpnJxDuZf35zoWgYUARvZsLTa9ZW92?=
 =?iso-8859-1?Q?/n/Y0kcPJVxg/CvkHAY9lGM3Uvm4LcSaFT3G6QFXOXBzWfi5wunetoDm5p?=
 =?iso-8859-1?Q?ih3zoHybThK3ebAeAgHkJxvQMw9WSaXlu6nnoj9oC2GL/DUzB3hJkJeKYK?=
 =?iso-8859-1?Q?yxAvwtE3o5T4XqbEdLvsZHUgy6Zj2mMZ35uQRmW55D7yLkxKqeYcEJECVX?=
 =?iso-8859-1?Q?fpttC6KIzGxoRMjn2dLtrNcgJCNRueOAR324eXoH710A/V9Qd3UWqYvURl?=
 =?iso-8859-1?Q?rmF0My9ftYJ/QOQ42kfe83M8mtlhbERiywFh+0QK1Fi1A18Izm1ucqsP+J?=
 =?iso-8859-1?Q?zyWHyD1rE+yWH0R94Dr49cKCvnGkX6k7cBiYS1EacuRLNEE4NYUB1QPMlz?=
 =?iso-8859-1?Q?CKxPep6gsqNfZVyTuH4NztjaxMKnpX6FvYG8osZ5KJslHhAr5+WAd4YqDL?=
 =?iso-8859-1?Q?/XUr01xgghhHPNl8mRfJFZEJST90DZxrXqxQQgQ5DZmZv2uP87NarfQ0qd?=
 =?iso-8859-1?Q?RRqOAiImUgg1bBtvBw+MKYu1B72inLPuYDphQMjGMO7mkUUFzWui7QgWfJ?=
 =?iso-8859-1?Q?0/cir93vYUMVaoGFVoZ9fq1viOTi2g3z/nqNh7ns+DVDMMw=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: reseau.eseo.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR02MB6202.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5d592d-a162-4496-60e2-08d929f9e1ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 21:19:06.2915 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d7ad159-1265-437a-b9f6-2946247d5bf9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4VVr8AAvmiqmN9Lgt9IgevrQKQSIXBzDZ46uGjrN8Kk2C8wMPiWAsjwwQjFYNo2s9O1Yo+WTQVC+8DyeNWAWfF7Y1vBPFP5r9rDnKS53+Bc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR02MB4697
Subject: Re: [lttng-dev] LTTng 32 bits on 64 bits systems - kernel events...
 but no user-event
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
Content-Type: multipart/mixed; boundary="===============6390475812864251316=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============6390475812864251316==
Content-Language: fr-FR
Content-Type: multipart/alternative;
	boundary="_000_PR3PR02MB6202A92FD29EA41CDB8CAE56D1389PR3PR02MB6202eurp_"

--_000_PR3PR02MB6202A92FD29EA41CDB8CAE56D1389PR3PR02MB6202eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I installed KeKriek version because it is the one recommanded by the apt-ge=
t of Debian Buster 10.9 (LTTng 2.10).
Debian -- D=E9tails du paquet lttng-tools dans buster<https://packages.debi=
an.org/buster/lttng-tools>
I tried multiple times to install LTTng 2.12 without success, so I stayed i=
n LTTng 2.10.

Find below the output of :  lttng-sessiond -vvv --verbose-consumer
https://paste.ubuntu.com/p/NrtyCqhHZc/

(I have got the same with LTTNG_CONSUMERD32_BIN=3D/usr/local/lib32/lttng/li=
bexec/lttng-consumerd LTTNG_CONSUMERD32_LIBDIR=3D/usr/local/lib32 lttng-ses=
siond -vvv --verbose-consumer)

Yes, I had the issue below few days ago with LTTng 2.12
"For 2.12 there is some problems when compiling only lttng-consumerd (fd-tr=
acker lib and libcommon problem)."

Thank you ! The following modification is working :
lttng-sessiond --consumerd32-libdir=3D/usr/local/lib32 --consumerd32-path=
=3D/usr/local/lib32/lttng/libexec/lttng-consumerd --daemonize

Regards,

Julien

________________________________
De : Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Envoy=E9 : lundi 7 juin 2021 17:24
=C0 : MONTET Julien <julien.montet@reseau.eseo.fr>
Cc : lttng-dev <lttng-dev@lists.lttng.org>
Objet : Re: [lttng-dev] LTTng 32 bits on 64 bits systems - kernel events...=
 but no user-event

Hi,

> I am currently trying to add lttng 32bits on a 64bits system with a custo=
m
> kernel 4.19.177+ x86_64 (Debian 10.9)
> My former attempt only with only a 100% arm32 bits was successful (raspbe=
rry).
> I am facing now a strange issue : I can record kernel event but not users=
pace
> event... but I can see these user-event (see below)!

Ok.

> (tuto : [ https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%=
2F%2Flttng.org%2Fdocs%2F%23doc-instrumenting-32-bit-app-on-64-bit-system&am=
p;data=3D04%7C01%7Cjulien.montet%40reseau.eseo.fr%7C9b85f601067749845a2408d=
929c85983%7C4d7ad1591265437ab9f62946247d5bf9%7C0%7C0%7C637586762735252731%7=
CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi=
LCJXVCI6Mn0%3D%7C1000&amp;sdata=3D5NB2nNrI17uwSE1Xpn1Uf6sbrRXbEePidPNXUh4ps=
7k%3D&amp;reserved=3D0
> | https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fltt=
ng.org%2Fdocs%2F%23doc-instrumenting-32-bit-app-on-64-bit-system&amp;data=
=3D04%7C01%7Cjulien.montet%40reseau.eseo.fr%7C9b85f601067749845a2408d929c85=
983%7C4d7ad1591265437ab9f62946247d5bf9%7C0%7C0%7C637586762735252731%7CUnkno=
wn%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC=
I6Mn0%3D%7C1000&amp;sdata=3D5NB2nNrI17uwSE1Xpn1Uf6sbrRXbEePidPNXUh4ps7k%3D&=
amp;reserved=3D0 ] )

> I followed two times the tutorial : on lttng 2.12 and lttng 2.10.
> I am on lttng (LTTng Trace Control) 2.10.11 - KeKriek now

Any particular reasons?

> All installation seemed to install without any error.
> The only thing I added is at the very end where I did a : ln -s
> /usr/local/bin/lttng /usr/bin/lttng (to directly call commands like "lttn=
g
> start")

> Here some interesting outputs, I am using this projet as an example : [
> https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flttng=
.org%2Fdocs%2F%23doc-tracing-your-own-user-application&amp;data=3D04%7C01%7=
Cjulien.montet%40reseau.eseo.fr%7C9b85f601067749845a2408d929c85983%7C4d7ad1=
591265437ab9f62946247d5bf9%7C0%7C0%7C637586762735262680%7CUnknown%7CTWFpbGZ=
sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1=
000&amp;sdata=3D6RTEjlZmpq2CZoIUD%2Fs5ySx60Zqd4JMByVejF8nQ7Vk%3D&amp;reserv=
ed=3D0 |
> https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flttng=
.org%2Fdocs%2F%23doc-tracing-your-own-user-application&amp;data=3D04%7C01%7=
Cjulien.montet%40reseau.eseo.fr%7C9b85f601067749845a2408d929c85983%7C4d7ad1=
591265437ab9f62946247d5bf9%7C0%7C0%7C637586762735262680%7CUnknown%7CTWFpbGZ=
sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1=
000&amp;sdata=3D6RTEjlZmpq2CZoIUD%2Fs5ySx60Zqd4JMByVejF8nQ7Vk%3D&amp;reserv=
ed=3D0 ]
> lttng list -u : OK [ https://eur02.safelinks.protection.outlook.com/?url=
=3Dhttps%3A%2F%2Fpaste.ubuntu.com%2Fp%2FhZptnNzySw%2F&amp;data=3D04%7C01%7C=
julien.montet%40reseau.eseo.fr%7C9b85f601067749845a2408d929c85983%7C4d7ad15=
91265437ab9f62946247d5bf9%7C0%7C0%7C637586762735262680%7CUnknown%7CTWFpbGZs=
b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C10=
00&amp;sdata=3Do71InJDxz1UgYSztgj5ENRr48MmLhsvQvPCO4GeOJ40%3D&amp;reserved=
=3D0 | Ubuntu Pastebin ]
> LTTNG_UST_DEBUG=3D1 ./hello : seems OK : [ https://eur02.safelinks.protec=
tion.outlook.com/?url=3Dhttps%3A%2F%2Fpaste.ubuntu.com%2Fp%2Fw6xHrJsWJ9%2F&=
amp;data=3D04%7C01%7Cjulien.montet%40reseau.eseo.fr%7C9b85f601067749845a240=
8d929c85983%7C4d7ad1591265437ab9f62946247d5bf9%7C0%7C0%7C637586762735262680=
%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW=
wiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D%2FWcFiJDvDaGP0BxZaHVsk7MH91zwvcgmw7vOn=
DkkHGg%3D&amp;reserved=3D0
> | Ubuntu Pastebin ]
> kernel-event output : [ https://eur02.safelinks.protection.outlook.com/?u=
rl=3Dhttps%3A%2F%2Fpaste.ubuntu.com%2Fp%2F5KfyS8wVdb%2F&amp;data=3D04%7C01%=
7Cjulien.montet%40reseau.eseo.fr%7C9b85f601067749845a2408d929c85983%7C4d7ad=
1591265437ab9f62946247d5bf9%7C0%7C0%7C637586762735262680%7CUnknown%7CTWFpbG=
Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C=
1000&amp;sdata=3DuHI4%2FeLn3gupvZO0DKksc7msLSacG%2Bkp2daShuKr7Wg%3D&amp;res=
erved=3D0 | Ubuntu Pastebin
> ]
> user-event ouput : none - the output folder stated with lttng create
> my-user-session --output=3D/tmp/my-user-session doesn't even appear
> apt-file search lttng : [ https://eur02.safelinks.protection.outlook.com/=
?url=3Dhttps%3A%2F%2Fpaste.ubuntu.com%2Fp%2FxMcCc7bqwk%2F&amp;data=3D04%7C0=
1%7Cjulien.montet%40reseau.eseo.fr%7C9b85f601067749845a2408d929c85983%7C4d7=
ad1591265437ab9f62946247d5bf9%7C0%7C0%7C637586762735262680%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;sdata=3D%2BXXEGKYhAexDJnfDDb%2Fc2QjscpT%2FH49pkT0yI%2FlLh8Q%3D&a=
mp;reserved=3D0 | Ubuntu
> Pastebin ]
> lsmod | grep lttng : [ https://eur02.safelinks.protection.outlook.com/?ur=
l=3Dhttps%3A%2F%2Fpaste.ubuntu.com%2Fp%2F7YNkNsh9Fr%2F&amp;data=3D04%7C01%7=
Cjulien.montet%40reseau.eseo.fr%7C9b85f601067749845a2408d929c85983%7C4d7ad1=
591265437ab9f62946247d5bf9%7C0%7C0%7C637586762735262680%7CUnknown%7CTWFpbGZ=
sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1=
000&amp;sdata=3DOYHATk5CBw3pIRB9Z3Cw56BiHJCknRzh09s1F%2B4wR%2FY%3D&amp;rese=
rved=3D0 | Ubuntu Pastebin
> ]

Can you provide the config.log from the configure steps

We are missing the most important logs: lttng-sessiond.

$ lttng-sessiond -vvv --verbose-consumer

> Note : file /usr/local/bin/lttng (the exe I am using) gives :
> /usr/local/bin/lttng: ELF 64-bit LSB pie executable, x86-64, version 1 (S=
YSV),
> dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linu=
x
> 3.2.0, BuildID[sha1]=3D542a108c40e386c17027c2c8f8fcb30e278b7748, with deb=
ug_info,
> not stripped

This is normal. Concretely to support tracing of 32 bit applications only a=
 32 bits
lttng-consumerd executable is needed which is launched by the lttng-session=
d executable.

> I am wondering if the installation didn't pick a 64bits RCU and analyses
> programms only on this.

Hmmm, what indicate this? I seriously doubt that this can happen.

> However, I have currently absolutely no idea how to debug this.

I decided to do the process on a clean ubuntu 20.04 machine.
For 2.12 there is some problems when compiling only lttng-consumerd (fd-tra=
cker lib and libcommon problem). I plan on providing a patch shortly.

But the major problem is that the path passed at configure time for the ltt=
ng-consumerd32 bit daemon are simply not used at runtime.
See this bug I just opened [1]. This is valid for 2.10 all the way to maste=
r AFAIK.

[1] https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbug=
s.lttng.org%2Fissues%2F1318&amp;data=3D04%7C01%7Cjulien.montet%40reseau.ese=
o.fr%7C9b85f601067749845a2408d929c85983%7C4d7ad1591265437ab9f62946247d5bf9%=
7C0%7C0%7C637586762735262680%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLC=
JQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DEV2j354mEqv=
EeW46AAnyn7pbutOdn0HtWOjI%2BMbUf3Y%3D&amp;reserved=3D0

In the meantime you will have to pass the lttng-consumerd 32 bit path as ar=
gument or env variables to lttng-sessiond as such:

$ lttng-sessiond -vvv --verbose-consumer --consumerd32-libdir=3D/usr/local/=
lib32 --consumerd32-path=3D/usr/local/lib32/lttng/libexec/lttng-consumerd

or

$ LTTNG_CONSUMERD32_BIN=3D/usr/local/lib32/lttng/libexec/lttng-consumerd LT=
TNG_CONSUMERD32_LIBDIR=3D/usr/local/lib32 lttng-sessiond -vvv --verbose-con=
sumer


From there the 32bits application is traced correctly and data is gathered =
without any problem (at least on 2.12).


```
[15:22:24.500655502] (+?.?????????) ubuntu2004.localdomain lttng_ust_stated=
ump:start: { cpu_id =3D 3 }, { }
[15:22:24.500661538] (+0.000006036) ubuntu2004.localdomain lttng_ust_stated=
ump:procname: { cpu_id =3D 3 }, { procname =3D "hello" }
[15:22:24.502611224] (+0.001949686) ubuntu2004.localdomain lttng_ust_stated=
ump:bin_info: { cpu_id =3D 3 }, { baddr =3D 0xF7EC9000, memsz =3D 20596, pa=
th =3D "/usr/lib32/libdl-2.31.so", is_pic =3D 1, has_build_id =3D 1, has_de=
bug_link =3D 1 }
[15:22:24.502614501] (+0.000003277) ubuntu2004.localdomain lttng_ust_stated=
ump:build_id: { cpu_id =3D 3 }, { baddr =3D 0xF7EC9000, _build_id_length =
=3D 20, build_id =3D [ [0] =3D 0x75, [1] =3D 0x1E, [2] =3D 0xDD, [3] =3D 0x=
47, [4] =3D 0x72, [5] =3D 0x3, [6]
```

Cheers

--_000_PR3PR02MB6202A92FD29EA41CDB8CAE56D1389PR3PR02MB6202eurp_
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
<span style=3D"font-family: Calibri, Helvetica, sans-serif;">Hi,</span></di=
v>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"font-size: 12pt; font-family: Calibri, Helvetica, sans-serif=
;">I installed KeKriek version because it is the one recommanded by the apt=
-get of Debian Buster 10.9 (LTTng 2.10).</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<a href=3D"https://packages.debian.org/buster/lttng-tools" id=3D"LPlnk50837=
1"><span style=3D"font-size: 12pt; font-family: Calibri, Helvetica, sans-se=
rif;">Debian -- D=E9tails du paquet lttng-tools dans buster</span></a><br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"font-size: 12pt; font-family: Calibri, Helvetica, sans-serif=
;">I tried multiple times to install LTTng 2.12 without success, so I staye=
d in LTTng 2.10.</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"font-size: 12pt; font-family: Calibri, Helvetica, sans-serif=
;">Find below the output of :&nbsp;&nbsp;</span><span style=3D"font-size: 1=
2pt; background-color: rgb(255, 255, 255); display: inline !important; font=
-family: Calibri, Helvetica, sans-serif;">lttng-sessiond
 -vvv --verbose-consumer</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<a href=3D"https://paste.ubuntu.com/p/NrtyCqhHZc/" id=3D"LPlnk842935"><span=
 style=3D"font-size: 12pt; font-family: Calibri, Helvetica, sans-serif;">ht=
tps://paste.ubuntu.com/p/NrtyCqhHZc/</span></a><br>
</div>
<div>
<div id=3D"Signature">
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"color:rgb(0,0,0); fon=
t-family:Calibri,Helvetica,sans-serif,&quot;EmojiFont&quot;,&quot;Apple Col=
or Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI Sym=
bol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:12pt">
<p style=3D"margin-top: 0px; margin-bottom: 0px;margin-top:0px; margin-bott=
om:0px">
</p>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"font-size: 12pt; font-family: Calibri, Helvetica, sans-serif=
;">(I have got the same with&nbsp;</span><span style=3D"font-size: 12pt; ba=
ckground-color: rgb(255, 255, 255); display: inline !important; font-family=
: Calibri, Helvetica, sans-serif;">LTTNG_CONSUMERD32_BIN=3D/usr/local/lib32=
/lttng/libexec/lttng-consumerd
 LTTNG_CONSUMERD32_LIBDIR=3D/usr/local/lib32 lttng-sessiond -vvv --verbose-=
consumer)</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"font-size:14.6667px; background-color:rgb(255,255,255); disp=
lay:inline!important"><br>
</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"font-size: 12pt; background-color: rgb(255, 255, 255); displ=
ay: inline !important; font-family: Calibri, Helvetica, sans-serif;">Yes, I=
 had the issue below few days ago with LTTng 2.12</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"font-size:14.6667px; background-color:rgb(255,255,255); disp=
lay:inline!important"><span style=3D"background-color: rgb(255, 255, 255); =
display: inline !important; font-size: 12pt; font-family: Calibri, Helvetic=
a, sans-serif;">&quot;For 2.12 there is some
 problems when compiling only lttng-consumerd (fd-tracker lib and libcommon=
 problem).&quot;</span><br>
</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"font-size:14.6667px; background-color:rgb(255,255,255); disp=
lay:inline!important"><span style=3D"background-color:rgb(255,255,255); dis=
play:inline!important"><br>
</span></span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"font-size:14.6667px; background-color:rgb(255,255,255); disp=
lay:inline!important"><span style=3D"background-color: rgb(255, 255, 255); =
display: inline !important; font-size: 12pt; font-family: Calibri, Helvetic=
a, sans-serif;">Thank you ! The following
 modification is working :</span></span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"font-size:14.6667px; background-color:rgb(255,255,255); disp=
lay:inline!important"><span style=3D"background-color:rgb(255,255,255); dis=
play:inline!important"><span style=3D"font-family: Calibri, Helvetica, sans=
-serif; background-color: rgb(255, 255, 255); display: inline !important; f=
ont-size: 12pt;">lttng-sessiond
 --consumerd32-libdir=3D/usr/local/lib32 --consumerd32-path=3D/usr/local/li=
b32/lttng/libexec/lttng-consumerd --daemonize</span></span></span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"font-size:14.6667px; background-color:rgb(255,255,255); disp=
lay:inline!important"><span style=3D"background-color:rgb(255,255,255); dis=
play:inline!important"><span style=3D"font-family:&quot;Segoe UI&quot;, &qu=
ot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system,=
 BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;backgro=
und-color:rgb(255, 255, 255);display:inline !important"><br>
</span></span></span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"font-size:14.6667px; background-color:rgb(255,255,255); disp=
lay:inline!important"><span style=3D"background-color:rgb(255,255,255); dis=
play:inline!important"><span style=3D"font-family:&quot;Segoe UI&quot;, &qu=
ot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system,=
 BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;backgro=
und-color:rgb(255, 255, 255);display:inline !important">Regards,</span></sp=
an></span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"font-size:14.6667px; background-color:rgb(255,255,255); disp=
lay:inline!important"><span style=3D"background-color:rgb(255,255,255); dis=
play:inline!important"><span style=3D"font-family:&quot;Segoe UI&quot;, &qu=
ot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system,=
 BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;backgro=
und-color:rgb(255, 255, 255);display:inline !important"><br>
</span></span></span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"font-size:14.6667px; background-color:rgb(255,255,255); disp=
lay:inline!important"><span style=3D"background-color:rgb(255,255,255); dis=
play:inline!important"><span style=3D"font-family:&quot;Segoe UI&quot;, &qu=
ot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system,=
 BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;backgro=
und-color:rgb(255, 255, 255);display:inline !important">Julien</span></span=
></span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"font-size:14.6667px; background-color:rgb(255,255,255); disp=
lay:inline!important"><span style=3D"background-color:rgb(255,255,255); dis=
play:inline!important"><br>
</span></span></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>De :</b> Jonathan Rajotte-Julie=
n &lt;jonathan.rajotte-julien@efficios.com&gt;<br>
<b>Envoy=E9 :</b> lundi 7 juin 2021 17:24<br>
<b>=C0 :</b> MONTET Julien &lt;julien.montet@reseau.eseo.fr&gt;<br>
<b>Cc&nbsp;:</b> lttng-dev &lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Objet :</b> Re: [lttng-dev] LTTng 32 bits on 64 bits systems - kernel ev=
ents... but no user-event</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Hi, <br>
<br>
&gt; I am currently trying to add lttng 32bits on a 64bits system with a cu=
stom<br>
&gt; kernel 4.19.177+ x86_64 (Debian 10.9)<br>
&gt; My former attempt only with only a 100% arm32 bits was successful (ras=
pberry).<br>
&gt; I am facing now a strange issue : I can record kernel event but not us=
erspace<br>
&gt; event... but I can see these user-event (see below)!<br>
<br>
Ok. <br>
<br>
&gt; (tuto : [ <a href=3D"https://eur02.safelinks.protection.outlook.com/?u=
rl=3Dhttps%3A%2F%2Flttng.org%2Fdocs%2F%23doc-instrumenting-32-bit-app-on-64=
-bit-system&amp;amp;data=3D04%7C01%7Cjulien.montet%40reseau.eseo.fr%7C9b85f=
601067749845a2408d929c85983%7C4d7ad1591265437ab9f62946247d5bf9%7C0%7C0%7C63=
7586762735252731%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMz=
IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3D5NB2nNrI17uwSE1Xpn1=
Uf6sbrRXbEePidPNXUh4ps7k%3D&amp;amp;reserved=3D0">
https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flttng.o=
rg%2Fdocs%2F%23doc-instrumenting-32-bit-app-on-64-bit-system&amp;amp;data=
=3D04%7C01%7Cjulien.montet%40reseau.eseo.fr%7C9b85f601067749845a2408d929c85=
983%7C4d7ad1591265437ab9f62946247d5bf9%7C0%7C0%7C637586762735252731%7CUnkno=
wn%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC=
I6Mn0%3D%7C1000&amp;amp;sdata=3D5NB2nNrI17uwSE1Xpn1Uf6sbrRXbEePidPNXUh4ps7k=
%3D&amp;amp;reserved=3D0</a><br>
&gt; | <a href=3D"https://eur02.safelinks.protection.outlook.com/?url=3Dhtt=
ps%3A%2F%2Flttng.org%2Fdocs%2F%23doc-instrumenting-32-bit-app-on-64-bit-sys=
tem&amp;amp;data=3D04%7C01%7Cjulien.montet%40reseau.eseo.fr%7C9b85f60106774=
9845a2408d929c85983%7C4d7ad1591265437ab9f62946247d5bf9%7C0%7C0%7C6375867627=
35252731%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTi=
I6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3D5NB2nNrI17uwSE1Xpn1Uf6sbrRX=
bEePidPNXUh4ps7k%3D&amp;amp;reserved=3D0">
https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flttng.o=
rg%2Fdocs%2F%23doc-instrumenting-32-bit-app-on-64-bit-system&amp;amp;data=
=3D04%7C01%7Cjulien.montet%40reseau.eseo.fr%7C9b85f601067749845a2408d929c85=
983%7C4d7ad1591265437ab9f62946247d5bf9%7C0%7C0%7C637586762735252731%7CUnkno=
wn%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC=
I6Mn0%3D%7C1000&amp;amp;sdata=3D5NB2nNrI17uwSE1Xpn1Uf6sbrRXbEePidPNXUh4ps7k=
%3D&amp;amp;reserved=3D0</a>
 ] )<br>
<br>
&gt; I followed two times the tutorial : on lttng 2.12 and lttng 2.10.<br>
&gt; I am on lttng (LTTng Trace Control) 2.10.11 - KeKriek now<br>
<br>
Any particular reasons?<br>
<br>
&gt; All installation seemed to install without any error.<br>
&gt; The only thing I added is at the very end where I did a : ln -s<br>
&gt; /usr/local/bin/lttng /usr/bin/lttng (to directly call commands like &q=
uot;lttng<br>
&gt; start&quot;)<br>
<br>
&gt; Here some interesting outputs, I am using this projet as an example : =
[<br>
&gt; <a href=3D"https://eur02.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flttng.org%2Fdocs%2F%23doc-tracing-your-own-user-application&amp;am=
p;data=3D04%7C01%7Cjulien.montet%40reseau.eseo.fr%7C9b85f601067749845a2408d=
929c85983%7C4d7ad1591265437ab9f62946247d5bf9%7C0%7C0%7C637586762735262680%7=
CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi=
LCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3D6RTEjlZmpq2CZoIUD%2Fs5ySx60Zqd4JMByVe=
jF8nQ7Vk%3D&amp;amp;reserved=3D0">
https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flttng.o=
rg%2Fdocs%2F%23doc-tracing-your-own-user-application&amp;amp;data=3D04%7C01=
%7Cjulien.montet%40reseau.eseo.fr%7C9b85f601067749845a2408d929c85983%7C4d7a=
d1591265437ab9f62946247d5bf9%7C0%7C0%7C637586762735262680%7CUnknown%7CTWFpb=
GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7=
C1000&amp;amp;sdata=3D6RTEjlZmpq2CZoIUD%2Fs5ySx60Zqd4JMByVejF8nQ7Vk%3D&amp;=
amp;reserved=3D0</a>
 |<br>
&gt; <a href=3D"https://eur02.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flttng.org%2Fdocs%2F%23doc-tracing-your-own-user-application&amp;am=
p;data=3D04%7C01%7Cjulien.montet%40reseau.eseo.fr%7C9b85f601067749845a2408d=
929c85983%7C4d7ad1591265437ab9f62946247d5bf9%7C0%7C0%7C637586762735262680%7=
CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi=
LCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3D6RTEjlZmpq2CZoIUD%2Fs5ySx60Zqd4JMByVe=
jF8nQ7Vk%3D&amp;amp;reserved=3D0">
https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flttng.o=
rg%2Fdocs%2F%23doc-tracing-your-own-user-application&amp;amp;data=3D04%7C01=
%7Cjulien.montet%40reseau.eseo.fr%7C9b85f601067749845a2408d929c85983%7C4d7a=
d1591265437ab9f62946247d5bf9%7C0%7C0%7C637586762735262680%7CUnknown%7CTWFpb=
GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7=
C1000&amp;amp;sdata=3D6RTEjlZmpq2CZoIUD%2Fs5ySx60Zqd4JMByVejF8nQ7Vk%3D&amp;=
amp;reserved=3D0</a>
 ]<br>
&gt; lttng list -u : OK [ <a href=3D"https://eur02.safelinks.protection.out=
look.com/?url=3Dhttps%3A%2F%2Fpaste.ubuntu.com%2Fp%2FhZptnNzySw%2F&amp;amp;=
data=3D04%7C01%7Cjulien.montet%40reseau.eseo.fr%7C9b85f601067749845a2408d92=
9c85983%7C4d7ad1591265437ab9f62946247d5bf9%7C0%7C0%7C637586762735262680%7CU=
nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC=
JXVCI6Mn0%3D%7C1000&amp;amp;sdata=3Do71InJDxz1UgYSztgj5ENRr48MmLhsvQvPCO4Ge=
OJ40%3D&amp;amp;reserved=3D0">
https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpaste.u=
buntu.com%2Fp%2FhZptnNzySw%2F&amp;amp;data=3D04%7C01%7Cjulien.montet%40rese=
au.eseo.fr%7C9b85f601067749845a2408d929c85983%7C4d7ad1591265437ab9f62946247=
d5bf9%7C0%7C0%7C637586762735262680%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw=
MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3Do=
71InJDxz1UgYSztgj5ENRr48MmLhsvQvPCO4GeOJ40%3D&amp;amp;reserved=3D0</a>
 | Ubuntu Pastebin ]<br>
&gt; LTTNG_UST_DEBUG=3D1 ./hello : seems OK : [ <a href=3D"https://eur02.sa=
felinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpaste.ubuntu.com%2Fp%2F=
w6xHrJsWJ9%2F&amp;amp;data=3D04%7C01%7Cjulien.montet%40reseau.eseo.fr%7C9b8=
5f601067749845a2408d929c85983%7C4d7ad1591265437ab9f62946247d5bf9%7C0%7C0%7C=
637586762735262680%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu=
MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3D%2FWcFiJDvDaGP0Bx=
ZaHVsk7MH91zwvcgmw7vOnDkkHGg%3D&amp;amp;reserved=3D0">
https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpaste.u=
buntu.com%2Fp%2Fw6xHrJsWJ9%2F&amp;amp;data=3D04%7C01%7Cjulien.montet%40rese=
au.eseo.fr%7C9b85f601067749845a2408d929c85983%7C4d7ad1591265437ab9f62946247=
d5bf9%7C0%7C0%7C637586762735262680%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw=
MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3D%=
2FWcFiJDvDaGP0BxZaHVsk7MH91zwvcgmw7vOnDkkHGg%3D&amp;amp;reserved=3D0</a><br=
>
&gt; | Ubuntu Pastebin ]<br>
&gt; kernel-event output : [ <a href=3D"https://eur02.safelinks.protection.=
outlook.com/?url=3Dhttps%3A%2F%2Fpaste.ubuntu.com%2Fp%2F5KfyS8wVdb%2F&amp;a=
mp;data=3D04%7C01%7Cjulien.montet%40reseau.eseo.fr%7C9b85f601067749845a2408=
d929c85983%7C4d7ad1591265437ab9f62946247d5bf9%7C0%7C0%7C637586762735262680%=
7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWw=
iLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3DuHI4%2FeLn3gupvZO0DKksc7msLSacG%2Bkp=
2daShuKr7Wg%3D&amp;amp;reserved=3D0">
https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpaste.u=
buntu.com%2Fp%2F5KfyS8wVdb%2F&amp;amp;data=3D04%7C01%7Cjulien.montet%40rese=
au.eseo.fr%7C9b85f601067749845a2408d929c85983%7C4d7ad1591265437ab9f62946247=
d5bf9%7C0%7C0%7C637586762735262680%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw=
MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3Du=
HI4%2FeLn3gupvZO0DKksc7msLSacG%2Bkp2daShuKr7Wg%3D&amp;amp;reserved=3D0</a>
 | Ubuntu Pastebin<br>
&gt; ]<br>
&gt; user-event ouput : none - the output folder stated with lttng create<b=
r>
&gt; my-user-session --output=3D/tmp/my-user-session doesn't even appear<br=
>
&gt; apt-file search lttng : [ <a href=3D"https://eur02.safelinks.protectio=
n.outlook.com/?url=3Dhttps%3A%2F%2Fpaste.ubuntu.com%2Fp%2FxMcCc7bqwk%2F&amp=
;amp;data=3D04%7C01%7Cjulien.montet%40reseau.eseo.fr%7C9b85f601067749845a24=
08d929c85983%7C4d7ad1591265437ab9f62946247d5bf9%7C0%7C0%7C63758676273526268=
0%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha=
WwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3D%2BXXEGKYhAexDJnfDDb%2Fc2QjscpT%2F=
H49pkT0yI%2FlLh8Q%3D&amp;amp;reserved=3D0">
https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpaste.u=
buntu.com%2Fp%2FxMcCc7bqwk%2F&amp;amp;data=3D04%7C01%7Cjulien.montet%40rese=
au.eseo.fr%7C9b85f601067749845a2408d929c85983%7C4d7ad1591265437ab9f62946247=
d5bf9%7C0%7C0%7C637586762735262680%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw=
MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3D%=
2BXXEGKYhAexDJnfDDb%2Fc2QjscpT%2FH49pkT0yI%2FlLh8Q%3D&amp;amp;reserved=3D0<=
/a>
 | Ubuntu<br>
&gt; Pastebin ]<br>
&gt; lsmod | grep lttng : [ <a href=3D"https://eur02.safelinks.protection.o=
utlook.com/?url=3Dhttps%3A%2F%2Fpaste.ubuntu.com%2Fp%2F7YNkNsh9Fr%2F&amp;am=
p;data=3D04%7C01%7Cjulien.montet%40reseau.eseo.fr%7C9b85f601067749845a2408d=
929c85983%7C4d7ad1591265437ab9f62946247d5bf9%7C0%7C0%7C637586762735262680%7=
CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi=
LCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3DOYHATk5CBw3pIRB9Z3Cw56BiHJCknRzh09s1F=
%2B4wR%2FY%3D&amp;amp;reserved=3D0">
https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpaste.u=
buntu.com%2Fp%2F7YNkNsh9Fr%2F&amp;amp;data=3D04%7C01%7Cjulien.montet%40rese=
au.eseo.fr%7C9b85f601067749845a2408d929c85983%7C4d7ad1591265437ab9f62946247=
d5bf9%7C0%7C0%7C637586762735262680%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw=
MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3DO=
YHATk5CBw3pIRB9Z3Cw56BiHJCknRzh09s1F%2B4wR%2FY%3D&amp;amp;reserved=3D0</a>
 | Ubuntu Pastebin<br>
&gt; ]<br>
<br>
Can you provide the config.log from the configure steps <br>
<br>
We are missing the most important logs: lttng-sessiond. <br>
<br>
$ lttng-sessiond -vvv --verbose-consumer <br>
<br>
&gt; Note : file /usr/local/bin/lttng (the exe I am using) gives :<br>
&gt; /usr/local/bin/lttng: ELF 64-bit LSB pie executable, x86-64, version 1=
 (SYSV),<br>
&gt; dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/L=
inux<br>
&gt; 3.2.0, BuildID[sha1]=3D542a108c40e386c17027c2c8f8fcb30e278b7748, with =
debug_info,<br>
&gt; not stripped<br>
<br>
This is normal. Concretely to support tracing of 32 bit applications only a=
 32 bits<br>
lttng-consumerd executable is needed which is launched by the lttng-session=
d executable.
<br>
<br>
&gt; I am wondering if the installation didn't pick a 64bits RCU and analys=
es<br>
&gt; programms only on this.<br>
<br>
Hmmm, what indicate this? I seriously doubt that this can happen. <br>
<br>
&gt; However, I have currently absolutely no idea how to debug this.<br>
<br>
I decided to do the process on a clean ubuntu 20.04 machine.<br>
For 2.12 there is some problems when compiling only lttng-consumerd (fd-tra=
cker lib and libcommon problem). I plan on providing a patch shortly.<br>
<br>
But the major problem is that the path passed at configure time for the ltt=
ng-consumerd32 bit daemon are simply not used at runtime.<br>
See this bug I just opened [1]. This is valid for 2.10 all the way to maste=
r AFAIK.<br>
<br>
[1] <a href=3D"https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Fbugs.lttng.org%2Fissues%2F1318&amp;amp;data=3D04%7C01%7Cjulien.mont=
et%40reseau.eseo.fr%7C9b85f601067749845a2408d929c85983%7C4d7ad1591265437ab9=
f62946247d5bf9%7C0%7C0%7C637586762735262680%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;=
sdata=3DEV2j354mEqvEeW46AAnyn7pbutOdn0HtWOjI%2BMbUf3Y%3D&amp;amp;reserved=
=3D0">
https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugs.lt=
tng.org%2Fissues%2F1318&amp;amp;data=3D04%7C01%7Cjulien.montet%40reseau.ese=
o.fr%7C9b85f601067749845a2408d929c85983%7C4d7ad1591265437ab9f62946247d5bf9%=
7C0%7C0%7C637586762735262680%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLC=
JQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3DEV2j354=
mEqvEeW46AAnyn7pbutOdn0HtWOjI%2BMbUf3Y%3D&amp;amp;reserved=3D0</a>
<br>
<br>
In the meantime you will have to pass the lttng-consumerd 32 bit path as ar=
gument or env variables to lttng-sessiond as such:
<br>
<br>
$ lttng-sessiond -vvv --verbose-consumer --consumerd32-libdir=3D/usr/local/=
lib32 --consumerd32-path=3D/usr/local/lib32/lttng/libexec/lttng-consumerd<b=
r>
<br>
or <br>
<br>
$ LTTNG_CONSUMERD32_BIN=3D/usr/local/lib32/lttng/libexec/lttng-consumerd LT=
TNG_CONSUMERD32_LIBDIR=3D/usr/local/lib32 lttng-sessiond -vvv --verbose-con=
sumer<br>
<br>
<br>
From there the 32bits application is traced correctly and data is gathered =
without any problem (at least on 2.12).<br>
<br>
<br>
```<br>
[15:22:24.500655502] (+?.?????????) ubuntu2004.localdomain lttng_ust_stated=
ump:start: { cpu_id =3D 3 }, { }<br>
[15:22:24.500661538] (+0.000006036) ubuntu2004.localdomain lttng_ust_stated=
ump:procname: { cpu_id =3D 3 }, { procname =3D &quot;hello&quot; }<br>
[15:22:24.502611224] (+0.001949686) ubuntu2004.localdomain lttng_ust_stated=
ump:bin_info: { cpu_id =3D 3 }, { baddr =3D 0xF7EC9000, memsz =3D 20596, pa=
th =3D &quot;/usr/lib32/libdl-2.31.so&quot;, is_pic =3D 1, has_build_id =3D=
 1, has_debug_link =3D 1 }<br>
[15:22:24.502614501] (+0.000003277) ubuntu2004.localdomain lttng_ust_stated=
ump:build_id: { cpu_id =3D 3 }, { baddr =3D 0xF7EC9000, _build_id_length =
=3D 20, build_id =3D [ [0] =3D 0x75, [1] =3D 0x1E, [2] =3D 0xDD, [3] =3D 0x=
47, [4] =3D 0x72, [5] =3D 0x3, [6]
<br>
```<br>
<br>
Cheers<br>
</div>
</span></font></div>
</body>
</html>

--_000_PR3PR02MB6202A92FD29EA41CDB8CAE56D1389PR3PR02MB6202eurp_--

--===============6390475812864251316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6390475812864251316==--
