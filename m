Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A898CEB64DA
	for <lttng-dev@archiver.kernel.org>; Mon, 10 Jul 2023 20:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1689020578;
	bh=cbCKPmN4atL99rE+kpDSUUC8N5zTuaxMTKNrGNt+UoU=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=pLaBYtWvXlcA7+Ou98nhiszbDLU119Lc45aPmqDmJ8KAJqhVK2M59rmRQDWf4HtnE
	 Zm8QKCrHKAUPFiZSxGF60xjyTSN+vR6E9/EQb55uiMl8928IhyKrUA6GkLaqQqsaxx
	 JcYq/chI2ADIJK/x9LG4smAMDAibhaqoEp5l5IdMSy8mINJpnqtfcn+CXanItOCv5p
	 ahMpUBYkz5HZCTMxx1YFhYrZ+1DMVALLIXQMqw0RWxG2h7DqqxezzaWXbyh6wiCF4j
	 b9WEwRDiOsDgw/+CDbmRd6vzPrqyyjag11fxcea9YMUAxNQ0wmKJ1zdJQznCIME0Xc
	 MUYJQNKhItaKw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4R0Fmx4Jqmz28gS;
	Mon, 10 Jul 2023 16:22:57 -0400 (EDT)
Received: from IND01-MAX-obe.outbound.protection.outlook.com
 (mail-maxind01on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:700f::603])
 by lists.lttng.org (Postfix) with ESMTPS id 4R0FLs5z8Rz28jT
 for <lttng-dev@lists.lttng.org>; Mon, 10 Jul 2023 16:03:49 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epcJuxGEhiV/WH596xP0r6gOluukQSSW1O9x5mMq5kbQK1MCsqYzfiNFydndtKA0oPkZVjpJe3eawKFAlgRWGMN+MnCXOXVUaqVO+YL2UouLZ9knmQ/zOwzFt9rev62Sscm9IXCRtP/3sodJZU8osDO7DFN9GkDjXvVFPaRXZgyXC8BTqJ3NWYwaeXKFJMXZs5sEkA741+BhkLLKI3M/g307PsQCvdy/UzLyWmwLI9NottCXHIqRuv9zCnOyyLt5sidJTkVxquBdCpwGhqSaninFD+viINRixo1yKECvkVhnv2CPx/BnmsAZVctPoEcpqZy48LjyQDhLdxeQvL+x1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aayx++PjlDSRl9iadR3RIFsciW9Bx48fbEXI5V3jnsg=;
 b=lnMczujma+Uk6SO75Crnf/hyqX8kRE5YuCxKbLFzm034EYDKLbkgR4nHex6X78HiqMuuwJcKmTEKL42JelTl/Wvp+jiA62RAzAyXx60ksOdpNlK5MV8/qLJ2dbLdX2vzS9GoPWZ90dFPbmo8O2RnlDjLZe5gBEPKXx3KmrDqTHDl9HOiCZBgZBAzD7sPz5wwoU5uSDSbPO21dCrUn70BIRCn3mL+KySX+B3kAnj/v5jpELA0UPOUX65VtK9aB7Qs9zZbr63TaX+N7sKxCSJmYeVi+yPtGPECoAN3nvR0/QPuCSKRygb1ZLqpalAInvJHPnKTJ+5r1BqursLbmIwdvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kpit.com; dmarc=pass action=none header.from=kpit.com;
 dkim=pass header.d=kpit.com; arc=none
Received: from MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:1f::9)
 by PN3PR01MB9518.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 17:28:17 +0000
Received: from MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::b593:a5b5:c3cc:bff5]) by MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::b593:a5b5:c3cc:bff5%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 17:28:16 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: lttng issue
Thread-Index: AQHZs0p1MoOhlRbiH0mR3LrHP5rFvK+zQQ5j
Date: Mon, 10 Jul 2023 17:28:16 +0000
Message-ID: <MA0PR01MB698754DEBE0F65CF5BDA226D8530A@MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM>
References: <MA0PR01MB6987D8650F8391BFB0CC82BD8530A@MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <MA0PR01MB6987D8650F8391BFB0CC82BD8530A@MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB6987:EE_|PN3PR01MB9518:EE_
x-ms-office365-filtering-correlation-id: 095624fc-3701-41c9-d090-08db816b0bf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nF5tekv8BZtk5hG6FejRvXXKy7eeQXiuNHYnHQw/lsd2vNKldo89poBFh5eM4qijHKzZLuzeO+zgFxqqYaTT+d3p3S87DEOMCPBAAi3DLr5+L1ztSO2SUteGwcaCMXRTdBa6BIwumW7rSsGXiWFsG/9MIDPKoOr3tkkJjd+rv245hWrUvQCBbo5SHxyDumNmk3gPNJVAOykYjVZGBr7z6dpj3KSWHs9c+l1tbkMQX6CUZiXHlP4b7wAuSOww99Cshd+OeUJH1bN/pjcO34ibKvJxjG7h0NU2xfTHfrdvIAKUuao2xx4viVzz8jK0JuMC85H93nL5XPokShl6gVDyw/Zai5fsFxbmbW76yzDeDgSNCdA3R4xvAxhrSdV0wnRLjf0BOgCfe1aroAfMSYpPCcPuVD0GKE4WWYZK20gucXqDWQrQU/5wb+9cVUPRnQNyslxnQ0YHSfuYD/jMgDk3zFLGpSR6D/ehgIt3tdZbrMUdQweFrjjdcuvj15zBikN0yxqeuewAAHC7iUg5ih1INlVst6EXmyA/lttYgMHIOCJuVQDiQH7wX2tHlJ8EZWD3dx27R7rkRkylHC/mDcQ3KZQBd1J8ISHhVOnz32WhDgk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199021)(186003)(26005)(6506007)(2940100002)(41300700001)(9686003)(66574015)(83380400001)(7696005)(478600001)(122000001)(71200400001)(6916009)(66446008)(66476007)(66556008)(66946007)(76116006)(64756008)(55016003)(38100700002)(316002)(7116003)(86362001)(33656002)(38070700005)(5660300002)(52536014)(8676002)(8936002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CwrVKowNZ53fnzF7XzJ6Uh6dQt6SCpyMi5gA2tTApRxZ/1WAB5U+3wDCs6Hs?=
 =?us-ascii?Q?OavUTBtOh7zby9hN6Q06k8qwcmwj2EAL3y6iVqkKhkisUdevNc/m2cBhVWH2?=
 =?us-ascii?Q?SAatX3mlsCZ83OQacAB/7Mi/6rVGmI31KDgbpOT/bkFOP+WQgM3TlMi6PFik?=
 =?us-ascii?Q?s1bEzSnV74pyXwMcXI70V7U+/JLSuQlH5GXfzpUeKc0uNK+olMCKteSy8yzs?=
 =?us-ascii?Q?u1+wGrcuyHB/MA/vqjSOC3pNHS8Y7d8kga9py9g9U8acHVMhOrJLGVSBnLdP?=
 =?us-ascii?Q?bXnrmXGenSNtTxwj2voo23HFZqI+QkD7PbNiX3BEFThT8agxA+xsxhJGliYn?=
 =?us-ascii?Q?tz0dfsEAqYg9lXhOXxKMBJmVBrUEE6qP3JR5zUeGFbaqTpNpLPiopet338EU?=
 =?us-ascii?Q?4KsupX6BSlfcVVa5ksemg68ChkxtRPSH3UofzdHq0jgC5Mck1gQAMS6420Ru?=
 =?us-ascii?Q?9JoHHnqnDd2rGuul3n8E/ghCSvjsbi0d/fMDIiQEbekdL9e/+KfVfi+FStWA?=
 =?us-ascii?Q?zEobFix2RRw0Ra+1r+wWLtxzeeHV0C8B2nWlYWbDytPnT51UbfxF723dVoU1?=
 =?us-ascii?Q?1YkpGa6e9f/AII8jXmOaJ4ZRXw9VVBEnIRWYZSJA0u5SHBHLN0Fjkit4VKKd?=
 =?us-ascii?Q?Uwufop94s58UMeGUhBxDaf/Dzp51LfySAqooeK+XqgA3nU3fyfOwQStVub+J?=
 =?us-ascii?Q?+FNOOM+MTZiF2kK4dQMZpnLiCrlUspEh79/JccvZzMHHxUT5+RJnr8J9EdyL?=
 =?us-ascii?Q?Jhuf1NVcdtM7MpTM6wYhk4YN0FFtrPy+QbjthswCIvQYH7WXhD2lXgB2ndOq?=
 =?us-ascii?Q?Rpxgp0yiEg/b9F2cA4E6MjnwtNYweGgnNsMKIyFAh2QNolCNLQN3A6ng9FSj?=
 =?us-ascii?Q?VWvwnhvySNbQ6UCeQbSGGECYgYu8b4N2EnCVuhzF3UEO3YVAv0UvYWlH5zwm?=
 =?us-ascii?Q?/dSiN9A7zWfQ4bnNbfpBsvpO5oz7HzeO7Mr1zcpd/KXq/hQjQg8idpqu4QS0?=
 =?us-ascii?Q?Nl3vKTnPB9YamNNj/qcqWIyCsUfbG/inhBVlLRbrTn61bVg71W81QtMbfhgz?=
 =?us-ascii?Q?0vfthQcdgvGPy3Rfzz30fHPPvXMo53U51I8i8MWK3aswwne2SJw3Yj6j4m50?=
 =?us-ascii?Q?NIoFBQHAXB5zWTYEwu/lHWl5RJV57ck1EOjyNxwD2Ez1BiCcn/hFWrLVGJf2?=
 =?us-ascii?Q?RwQTZjw0m+lFlq8EuvdkQUya/XtYSX2eRi2IZxk5rNW4InSmLJveWv3rmgNR?=
 =?us-ascii?Q?kOLWBH/+r5nugEjwq3DO5Enzb3HVDjJK2rm4WOvlPHegopungwE/zYJsVCAD?=
 =?us-ascii?Q?62QgpcdvHz45YIObKLMTsAd4NaSQFuMdGdyI9/mYW4pEHsZIdwBaXYmx3mPX?=
 =?us-ascii?Q?QsJsK1yUFXu0vIRQBgmAYRYo048OGl7fmYXzUkdqdDab7VTzXTksgdhO9ZAH?=
 =?us-ascii?Q?tM2qbk63jLddase5Ws6lPgg6tz2h31hVUzgzS8sVZBvX/7sWa7BPRQcouOA3?=
 =?us-ascii?Q?cGtmnhKoGX50s2cop67r/QQdF5uiFErJX65xCHRHdGrKZtIgfswrzeHzB1bK?=
 =?us-ascii?Q?pWTQuj9C+a+wX4q8oHV8sI71VB77RZr4UKU4Luy7?=
MIME-Version: 1.0
X-OriginatorOrg: kpit.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 095624fc-3701-41c9-d090-08db816b0bf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 17:28:16.4998 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3539451e-b46e-4a26-a242-ff61502855c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ccQdXFBHzwW4/yxAmoY7p3Z5+4Sqr4aKev32OOyxJBnBUsbc6lFQMTxdOkmVsCEN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB9518
X-Mailman-Approved-At: Mon, 10 Jul 2023 16:22:56 -0400
Subject: [lttng-dev] Fwd: lttng issue
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
From: Bala Gundeboina via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Bala Gundeboina <Bala.Gundeboina@kpit.com>
Content-Type: multipart/mixed; boundary="===============1721709096126125556=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============1721709096126125556==
Content-Language: en-GB
Content-Type: multipart/alternative;
	boundary="_000_MA0PR01MB698754DEBE0F65CF5BDA226D8530AMA0PR01MB6987INDP_"

--_000_MA0PR01MB698754DEBE0F65CF5BDA226D8530AMA0PR01MB6987INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



Hi ,
     i have copied the dependencies that i have installed on TDA4 evm board=
 and i have copied  the dependency to the TI board and i getting below erro=
r , i found the were this lock will create but in that folder(/var/run/lttn=
g) no lock file is present.
lttng create my-kernel-session --output=3D/home/root/
Spawning a session daemon
Warning: Failed to produce a random seed using getrandom(), falling back to=
 pseudo-random device seed generation which will block until its pool is in=
itialized: Failed to get true random data using getre
PERROR - 15:35:47.868588025 [Main]: remove lock file: No such file or direc=
tory (in sessiond_cleanup_lock_file() at main.cpp:955)
Error: Session daemon terminated with an error (exit status: 1)
Error: Problem occurred while launching session daemon (//bin/lttng-session=
d)

Can you please sort it out and is there any dependency i am missing:
sudo cp -Par bin/lttng /media/bala/root/bin/
sudo cp -Par bin/lttng-sessiond /media/bala/root/bin/
sudo cp -Par lib/liblttng-ctl.so /media/bala/root/lib/
sudo cp -Par lib/liblttng-ctl.so.0 /media/bala/root/lib/
sudo cp -Par lib/liblttng-ctl.so.0.0.0 /media/bala/root/lib/
sudo cp -Par lib/liblttng-ust-ctl.so.5 /media/bala/root/lib/
sudo cp -Par lib/librt.so.1 /media/bala/root/lib/
sudo cp -Par lib/librt-2.30.so /media/bala/root/lib/
sudo cp -Par lib/libm-2.30.so /media/bala/root/lib/
sudo cp -Par lib/libm.so.6 /media/bala/root/lib/
sudo cp -aPr liburcu-common.so.8 /media/bala/root1/usr/lib/
sudocp -aPr liburcu-common.so /media/bala/root1/usr/lib/
sudo cp -aPr liburcu-common.so.8.1.0 /media/bala/root1/usr/lib/

sudo cp -Par lib/libgcc_s.so /media/bala/root/lib/
sudo cp -Par lib/libgcc_s.so.1 /media/bala/root/lib/
sudo cp -Par lib/libpthread-2.30.so /media/bala/root/lib/
sudo cp -Par lib/libpthread.so.0 /media/bala/root/lib/
sudo cp -Par lib/libc.so.6 /media/bala/root/lib/
sudo cp -Par lib/libdl.so.2 /media/bala/root/lib/
sudo cp -Par lib/libdl-2.30.so /media/bala/root/lib/
sudo cp -Par lib/libz.so.1 /media/bala/root/lib/
sudo cp -Par lib/libz.so.1.2.11 /media/bala/root/lib/
sudo cp -Par lib/ld-linux-aarch64.so.1 /media/bala/root/lib/
sudo cp -Par lib/ld-2.30.so /media/bala/root/lib
sudo cp -aPr liburcu-cds.so /media/bala/root1/usr/lib/
sudo cp -aPr liburcu-cds.so.8 /media/bala/root1/usr/
sudo cp -aPr liburcu-cds.so.8.1.0 /media/bala/root1/usr/lib/


sudo cp -Par lib/liblttng-ust-common.so /media/bala/root/lib/
sudo cp -Par lib/liblttng-ust-ctl.so.5.0.0 /media/bala/root/lib/
sudo cp -Par lib/liblttng-ust-common.so.1.0.0 /media/bala/root/lib/
sudo cp -Par usr/lib/libstdc++.so /media/bala/root/usr/lib/
sudo cp -Par usr/lib/libstdc++.so.6 /media/bala/root/usr/lib/
sudo cp -Par usr/lib/libstdc++.so.6.0.28 /media/bala/root/usr/lib/
sudo cp -Par usr/lib/libxml2.so /media/bala/root/usr/lib/
sudo cp -Par usr/lib/libxml2.so.2 /media/bala/root/usr/lib/
sudo cp -Par usr/lib/libxml2.so.2.9.10 /media/bala/root/usr/lib/
sudo cp -Par usr/lib/libpopt.so /media/bala/root/usr/lib/
sudo cp -Par usr/lib/libpopt.so.0 /media/bala/root/usr/lib/
sudo cp -Par usr/lib/libpopt.so.0.0.0 /media/bala/root/usr/lib/
sudo cp -Par usr/lib/libpopt.so.0.0.2 /media/bala/root/usr/lib/
sudo cp -Par usr/lib/liburcu.so /media/bala/root/usr/lib/
sudo cp -Par usr/lib/liburcu.so.8 /media/bala/root/usr/lib/
sudo cp -Par usr/lib/liburcu.so.8.1.0 /media/bala/root/usr/lib/
sudo cp -Par usr/lib/liburcu-cds.so.8 /media/bala/root/usr/lib/
sudo cp -Par usr/lib/liburcu-common.so.8 /media/bala/root/usr/lib/
sudo cp -Par usr/lib/liburcu-cds.so.8.1.0 /media/bala/root/usr/lib/
sudo cp -Par usr/lib/liburcu-common.so.8.1.0 /media/bala/root/usr/lib/
sudo cp -Par usr/local/local/lib/libnuma.so.1 /media/bala/root/usr/lib/
sudo cp -Par usr/local/local/lib/libnuma.so.1.0.0 /media/bala/root/usr/lib/
sudo cp -Par usr/lib/libkmod.so.2.3.4 /media/bala/root/usr/lib/
sudo cp -Par usr/lib/libkmod.so.2 /media/bala/root/usr/lib/


Thanks & Regards
Bala G


This message contains information that may be privileged or confidential an=
d is the property of the KPIT Technologies Ltd. It is intended only for the=
 person to whom it is addressed. If you are not the intended recipient, you=
 are not authorized to read, print, retain copy, disseminate, distribute, o=
r use this message or any part thereof. If you receive this message in erro=
r, please notify the sender immediately and delete all copies of this messa=
ge. KPIT Technologies Ltd. does not accept any liability for virus infected=
 mails.

--_000_MA0PR01MB698754DEBE0F65CF5BDA226D8530AMA0PR01MB6987INDP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div style=3D"" dir=3D"auto"><br>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div id=3D"mail-editor-reference-message-container" dir=3D"auto"><br>
<span class=3D"x_elementToProof" style=3D"font-size: 12pt; font-family: Cal=
ibri, Arial, Helvetica, sans-serif; margin: 0px; color: rgb(0, 0, 0); backg=
round-color: rgb(255, 255, 255);">Hi ,</span>
<div class=3D"x_elementToProof elementToProof" style=3D"font-size: 12pt; fo=
nt-family: Calibri, Arial, Helvetica, sans-serif; margin: 0px; color: rgb(0=
, 0, 0); background-color: rgb(255, 255, 255);">
&nbsp; &nbsp; &nbsp;i have copied the dependencies that i have installed on=
 TDA4 evm board and i have copied&nbsp; the dependency to the TI board and =
i getting below error , i found the were this lock will create but in that =
folder(/var/run/lttng) no lock file is present.&nbsp;</div>
<div class=3D"x_elementToProof x_ContentPasted0" style=3D"font-size: 12pt; =
font-family: Calibri, Arial, Helvetica, sans-serif; margin: 0px; color: rgb=
(0, 0, 0); background-color: rgb(255, 255, 255);">
lttng create my-kernel-session --output=3D/home/root/
<div class=3D"x_ContentPasted0" style=3D"margin:0px">Spawning a session dae=
mon</div>
<div class=3D"x_ContentPasted0" style=3D"margin:0px">Warning: Failed to pro=
duce a random seed using getrandom(), falling back to pseudo-random device =
seed generation which will block until its pool is initialized: Failed to g=
et true random data using getre</div>
<div class=3D"x_ContentPasted0" style=3D"margin:0px">PERROR - 15:35:47.8685=
88025 [Main]: remove lock file: No such file or directory (in sessiond_clea=
nup_lock_file() at main.cpp:955)</div>
<div class=3D"x_ContentPasted0" style=3D"margin:0px">Error: Session daemon =
terminated with an error (exit status: 1)</div>
Error: Problem occurred while launching session daemon (//bin/lttng-session=
d)<br>
</div>
<div class=3D"x_elementToProof x_ContentPasted0" style=3D"font-size: 12pt; =
font-family: Calibri, Arial, Helvetica, sans-serif; margin: 0px; color: rgb=
(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div class=3D"x_elementToProof x_ContentPasted0" style=3D"font-size: 12pt; =
font-family: Calibri, Arial, Helvetica, sans-serif; margin: 0px; color: rgb=
(0, 0, 0); background-color: rgb(255, 255, 255);">
Can you please sort it out and is there any dependency i am missing:</div>
<div class=3D"x_elementToProof x_ContentPasted0 x_ContentPasted1" style=3D"=
font-size: 12pt; font-family: Calibri, Arial, Helvetica, sans-serif; margin=
: 0px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
sudo cp -Par bin/lttng /media/bala/root/bin/
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par bin/lttng=
-sessiond /media/bala/root/bin/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par lib/liblt=
tng-ctl.so /media/bala/root/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par lib/liblt=
tng-ctl.so.0 /media/bala/root/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par lib/liblt=
tng-ctl.so.0.0.0 /media/bala/root/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par lib/liblt=
tng-ust-ctl.so.5 /media/bala/root/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par lib/librt=
.so.1 /media/bala/root/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par lib/librt=
-2.30.so /media/bala/root/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par lib/libm-=
2.30.so /media/bala/root/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par lib/libm.=
so.6 /media/bala/root/lib/</div>
<div class=3D"x_ContentPasted1 x_ContentPasted3" style=3D"margin:0px">sudo&=
nbsp;cp -aPr liburcu-common.so.8 /media/bala/root1/usr/lib/</div>
<div class=3D"x_ContentPasted1 x_ContentPasted3 x_ContentPasted4" style=3D"=
margin:0px">
sudocp -aPr liburcu-common.so /media/bala/root1/usr/lib/<br>
</div>
<div class=3D"x_ContentPasted1 x_ContentPasted3 x_ContentPasted4 x_ContentP=
asted5" style=3D"margin:0px">
sudo cp -aPr liburcu-common.so.8.1.0 /media/bala/root1/usr/lib/<br>
</div>
<div style=3D"margin:0px"><br class=3D"x_ContentPasted1">
</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par lib/libgc=
c_s.so /media/bala/root/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par lib/libgc=
c_s.so.1 /media/bala/root/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par lib/libpt=
hread-2.30.so /media/bala/root/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par lib/libpt=
hread.so.0 /media/bala/root/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par lib/libc.=
so.6 /media/bala/root/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par lib/libdl=
.so.2 /media/bala/root/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par lib/libdl=
-2.30.so /media/bala/root/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par lib/libz.=
so.1 /media/bala/root/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par lib/libz.=
so.1.2.11 /media/bala/root/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par lib/ld-li=
nux-aarch64.so.1 /media/bala/root/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par lib/ld-2.=
30.so /media/bala/root/lib</div>
<div class=3D"x_ContentPasted1 x_ContentPasted2" style=3D"margin:0px">sudo =
cp -aPr liburcu-cds.so /media/bala/root1/usr/lib/
<div class=3D"x_ContentPasted2" style=3D"margin:0px">sudo cp -aPr liburcu-c=
ds.so.8 /media/bala/root1/usr/</div>
sudo cp -aPr liburcu-cds.so.8.1.0 /media/bala/root1/usr/lib/<br>
</div>
<div style=3D"margin:0px"><br class=3D"x_ContentPasted1">
</div>
<div style=3D"margin:0px"><br class=3D"x_ContentPasted1">
</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par lib/liblt=
tng-ust-common.so /media/bala/root/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par lib/liblt=
tng-ust-ctl.so.5.0.0 /media/bala/root/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par lib/liblt=
tng-ust-common.so.1.0.0 /media/bala/root/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par usr/lib/l=
ibstdc++.so /media/bala/root/usr/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par usr/lib/l=
ibstdc++.so.6 /media/bala/root/usr/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par usr/lib/l=
ibstdc++.so.6.0.28 /media/bala/root/usr/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par usr/lib/l=
ibxml2.so /media/bala/root/usr/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par usr/lib/l=
ibxml2.so.2 /media/bala/root/usr/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par usr/lib/l=
ibxml2.so.2.9.10 /media/bala/root/usr/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par usr/lib/l=
ibpopt.so /media/bala/root/usr/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par usr/lib/l=
ibpopt.so.0 /media/bala/root/usr/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par usr/lib/l=
ibpopt.so.0.0.0 /media/bala/root/usr/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par usr/lib/l=
ibpopt.so.0.0.2 /media/bala/root/usr/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par usr/lib/l=
iburcu.so /media/bala/root/usr/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par usr/lib/l=
iburcu.so.8 /media/bala/root/usr/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par usr/lib/l=
iburcu.so.8.1.0 /media/bala/root/usr/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par usr/lib/l=
iburcu-cds.so.8 /media/bala/root/usr/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par usr/lib/l=
iburcu-common.so.8 /media/bala/root/usr/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par usr/lib/l=
iburcu-cds.so.8.1.0 /media/bala/root/usr/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par usr/lib/l=
iburcu-common.so.8.1.0 /media/bala/root/usr/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par usr/local=
/local/lib/libnuma.so.1 /media/bala/root/usr/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par usr/local=
/local/lib/libnuma.so.1.0.0 /media/bala/root/usr/lib/</div>
<div class=3D"x_ContentPasted1" style=3D"margin:0px">sudo cp -Par usr/lib/l=
ibkmod.so.2.3.4 /media/bala/root/usr/lib/</div>
sudo cp -Par usr/lib/libkmod.so.2 /media/bala/root/usr/lib/<br>
</div>
<div class=3D"x_elementToProof x_ContentPasted0" style=3D"font-size: 12pt; =
font-family: Calibri, Arial, Helvetica, sans-serif; margin: 0px; color: rgb=
(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div class=3D"x_elementToProof x_ContentPasted0" style=3D"font-size: 12pt; =
font-family: Calibri, Arial, Helvetica, sans-serif; margin: 0px; color: rgb=
(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div class=3D"x_elementToProof x_ContentPasted0" style=3D"font-size: 12pt; =
font-family: Calibri, Arial, Helvetica, sans-serif; margin: 0px; color: rgb=
(0, 0, 0); background-color: rgb(255, 255, 255);">
Thanks &amp; Regards&nbsp;</div>
<span class=3D"x_elementToProof x_ContentPasted0" style=3D"font-size: 12pt;=
 font-family: Calibri, Arial, Helvetica, sans-serif; margin: 0px; color: rg=
b(0, 0, 0); background-color: rgb(255, 255, 255);">Bala G</span>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<br>
</div>
</div>
This message contains information that may be privileged or confidential an=
d is the property of the KPIT Technologies Ltd. It is intended only for the=
 person to whom it is addressed. If you are not the intended recipient, you=
 are not authorized to read, print,
 retain copy, disseminate, distribute, or use this message or any part ther=
eof. If you receive this message in error, please notify the sender immedia=
tely and delete all copies of this message. KPIT Technologies Ltd. does not=
 accept any liability for virus
 infected mails.
</body>
</html>

--_000_MA0PR01MB698754DEBE0F65CF5BDA226D8530AMA0PR01MB6987INDP_--

--===============1721709096126125556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1721709096126125556==--
