Return-Path: <SRS0=Od8Q=GK=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A66CC433E0
	for <lttng-dev@archiver.kernel.org>; Thu,  7 Jan 2021 20:54:34 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE4E2311E
	for <lttng-dev@archiver.kernel.org>; Thu,  7 Jan 2021 20:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE4E2311E
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DBdlD0cQ5zNxr;
	Thu,  7 Jan 2021 15:54:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1610052872;
	bh=8NSFw5VmR/zdsDt3qxabQp/vO4X+gsRrWseVvI5trC4=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=c24Sd0wp/i6N7DYnahl9yOKf1SH6KNAGrThcWT8cLxF0pU0+E2GU5MShkugWT/Y4J
	 zggUD8apmpxCpfPjGbXId176KjM8gxWUVigLcpLY5zfuBWMeoJjHBxbGUtTEXUA6z/
	 6f/tUVc0HwMzlpkl7i6LVwJj2JPxL9y8g1FdC9UHyQf63OfZoVdjKTpLw29Era3Grl
	 s25KatZ12oow0qbNGt4CQ247GoKDhLalf31TaljUmkDEGIeTRqMN0+goXLCZiEeP1l
	 sdNe1L7xIeixTvNMsOLfZSh4syyKN0VZGAZ1wnSjD9Gb72CybFek+Uzdc3J6WF3n//
	 2dcobAukuT1DQ==
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680056.outbound.protection.outlook.com [40.107.68.56])
 by lists.lttng.org (Postfix) with ESMTPS id 4DBdlB6HCBzNpl
 for <lttng-dev@lists.lttng.org>; Thu,  7 Jan 2021 15:54:30 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksIUVitXLzlnEgU8t1mSlsN1AnjpHpKiw75QeI07hvZEHrnIzCn7SVOwwuY1dIm1IQPQM4dfdCx0tH5UIYQxMdNdZVMbQUzUMDWD3RwIq5pwrU0qEBwN0bTtDhL5jQ3+LGWnjT/ToAHC7bkJlaQ+n8IJOO0FmWSl1BAwPdWGHLFFo8dMm96uiDfOB0CZrQxoI7e1MUjffPtVL3yumtStoX58q+Q9aPYOmPWfqjlg4txBidXhnzEXA7SOyctwcTwOkjrrQzmGB+A/5uw7CbKBdweN+7l0IwNelsX7olbm3qx0mggpn7NwkgePV2Qo3R4BrG63M+58xV1ifkzwq1TcpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ol8ghYcTJLuLKI3CSn9PnPZXluSl24z8+2AvoPXt7r0=;
 b=hVs+mC/w1LY/vKbXalgvcyYJnJw2k4IC2hL0ruTPhQuVxaes/dJttn+G8C7zqlw0UUdJQ9e8eGjX2ki58VQuSzQF0ogcmZZXJw4qtQjLT0XpmjQzw8N0TxSlVx6xEc45QIG8fD3cd/fDoCdwa7wtvyMm28GdQgI4qSgVNGP65iGXjFs7Jz9hFlo4nnLoVIai4ccY7+JbBMh035WPoIF2ixRNhT2N4dTMFxRaL/vAZQqcqQT9QzwxWveQinxzTLxlvVfReUxNgl2ylWUYq2BP5AkrJO+fLnPRWjOy53Vp4rgAj4rUaZBrtXviaOPUR9oI2HBa/C/ZhtsQtG0FYnGa6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
Received: from DM6PR15MB4072.namprd15.prod.outlook.com (2603:10b6:5:2bf::16)
 by DM5PR15MB1147.namprd15.prod.outlook.com (2603:10b6:3:bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 7 Jan
 2021 20:54:29 +0000
Received: from DM6PR15MB4072.namprd15.prod.outlook.com
 ([fe80::5d02:23ff:b955:bbde]) by DM6PR15MB4072.namprd15.prod.outlook.com
 ([fe80::5d02:23ff:b955:bbde%7]) with mapi id 15.20.3721.025; Thu, 7 Jan 2021
 20:54:28 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: LTTng 2.12 modules from PPA fail to install
Thread-Index: AQHW5TWOYGq5I4uA3kK/nEkWoaMuRg==
Date: Thu, 7 Jan 2021 20:54:28 +0000
Message-ID: <DM6PR15MB407280AC90424B9F52FE57D38FAF0@DM6PR15MB4072.namprd15.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.24.6.220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 038ca251-5020-4313-3a34-08d8b34e6ce7
x-ms-traffictypediagnostic: DM5PR15MB1147:
x-microsoft-antispam-prvs: <DM5PR15MB11471C0A596C42FCA39AC6DE8FAF0@DM5PR15MB1147.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NcrCtmVSiUBYMXx6YCvAQc+2I76JBvklNhpYu+1vpwVG9Q9OfLdtggQYM0YyAZJN/PrG2DgO2aulGDAefuDQnqdFjUKrcykgoiEAKE2yypV+Dq34rER/UFcBwdUmOZO6B4pI568zI5Zp1PN557cvIMuhbhk3Flp92blDpiTdzchdeU04g7axinDdtJo90vJ2cPcf5SRFfCqvzePLTT0SjYaJZC1JQrZbuT0Rov6n9tDavmbaHrmuljMxIdTH1LwwPWsr8HPkosLngb24F7gJSWi+u2QhICKJgBVSTMYtq8fEGZMYKVDlRVpPMdW+9+8OxU3dL02vUGq1QEVHaR+7VR3Cx2C6/xiQ0+r8z8u0nNHe1Q4Eg0rFdvoZPQvCMdNh0w0EF1tGlOEvKcK27k4wNvAelDpfhJcf5gJNQZn0LCxB3do6KgAQBydOkuuesiKZjVq5cb8epuAVLSItV+S1pA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR15MB4072.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(19627405001)(6506007)(55016002)(52536014)(4744005)(478600001)(966005)(7696005)(5660300002)(83380400001)(316002)(6916009)(8676002)(33656002)(86362001)(186003)(66476007)(9686003)(66946007)(71200400001)(66556008)(8936002)(2906002)(66446008)(64756008)(76116006)(91956017)(44832011)(166002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?otB8o/kq8U5ZgET4KmaINDvKhXNCUV7ZuUA60wgDAq6FXl0JWQU7uDXv/k?=
 =?iso-8859-1?Q?QUAkaelrOOg5boXJkV4VwPc75p+lyfRzBoYVRM8tw+DpztnCxCdtTV2Sv3?=
 =?iso-8859-1?Q?UBfrBkVT9pyoexaPbpK20Nn1ZPAQZeQ7Xpsl+hR3rdvLkYAnjos8F4prNl?=
 =?iso-8859-1?Q?xMGoO017STuiKkcYuaFtR51MERaxtzTkaopBuSePq+Llsw7bCESZ97789o?=
 =?iso-8859-1?Q?37Iv7/CIEkI0u+0LLVhaOS1OV3QiQT/nx4apCmdbKc+dVl7z+ADu1CL6UA?=
 =?iso-8859-1?Q?Xb1Ab1Xuh7V2HUcQNDfYBJXVAzC0+rmHi+8n2EszAW2KgPqAi8Ck2KobiS?=
 =?iso-8859-1?Q?jCLB4YymHGd736GH4x2GDDR1hmoEXXJsBUaWVGcBM0vigBsEUpPx/+OXic?=
 =?iso-8859-1?Q?/Gm4lxM4CGeBsEpkri07C+zoKVlQwI//VAXmOKtbv/SFGACKMoyQH28dCY?=
 =?iso-8859-1?Q?H8y7eoOT+Bt/BXS2aZhD4ZDRqE2iE4glGed83GBsSpQqOXOylwpCKdzgvZ?=
 =?iso-8859-1?Q?LRhUjXeufEuHMkYiLjvASKGb/95D+g85vhfyAAQ6ScMM66YrIJ81q8FzoZ?=
 =?iso-8859-1?Q?LQgEIxNARwy84YsfNUjEyP14G4rLYU3yuPakyy7tJczEulP+QmIb4EwetW?=
 =?iso-8859-1?Q?AYm2RYcY6YyW6WYjMCXxjyWEK423Yyem0+wCApg8S7HkE95gd4oiPivNZZ?=
 =?iso-8859-1?Q?waW1uJP/cyquDoiZvfH9J85q6qB+XilST/YjM4TzwR71Yrcpuc0262kJWe?=
 =?iso-8859-1?Q?xXUWVF3qE20pI3iHegXNyIcvAfBi3Y6L9QZnEK0t8Q+rzo8+0t4y5UDt7U?=
 =?iso-8859-1?Q?jbCI98fQKav+pmVxGX13k2JRQMLDI3JXw57Pnb83m7e7vnHFleg/sj/pM1?=
 =?iso-8859-1?Q?ZMOZjRBMcA+oxkZzfawPM/qer0fRd9e1M6nlSObTaFYBsAnqebx0eWAABV?=
 =?iso-8859-1?Q?PB2d3eEcAR9POidzKwQ/VrxPsk9qg/1dK+Eh3HK05y1XSW1pyx4gVsu8zG?=
 =?iso-8859-1?Q?o+ZUDZ1WCnvjF4vV4=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4072.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 038ca251-5020-4313-3a34-08d8b34e6ce7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2021 20:54:28.7773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GvLE0cP75HZ8jT4r0Va9vamH04fIs6AZ3F5rH0EBgOCiEYXEYe2m184IfWRKZGRtJ6pQ/bhh36A4MZDOxaPAWgjuKhSm8nByDUuVnHwAlrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1147
Subject: [lttng-dev] LTTng 2.12 modules from PPA fail to install
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
Content-Type: multipart/mixed; boundary="===============7229649037544776394=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============7229649037544776394==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_DM6PR15MB407280AC90424B9F52FE57D38FAF0DM6PR15MB4072namp_"

--_000_DM6PR15MB407280AC90424B9F52FE57D38FAF0DM6PR15MB4072namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi LTTng experts,

On my Linux Ubuntu 18.04 machine (4.15.0-129-generic kernel) the installati=
on of the LTTng kernel modules fail using the official PPA. I found a log f=
ile lttng-modules-dkms.0.crash with some details on the installation failur=
e. See pastebin [1] for the detailed error message.

Any ideas what is going on? Please let me know what I can do to resolve it.

In advance thank you very much.

BR
Bernd

[1] https://paste.ubuntu.com/p/747H2V5q7K/






--_000_DM6PR15MB407280AC90424B9F52FE57D38FAF0DM6PR15MB4072namp_
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
Hi LTTng experts,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
On my Linux Ubuntu 18.04 machine (4.15.0-129-generic kernel) the installati=
on of the LTTng kernel modules fail using the official PPA. I found a log f=
ile lttng-modules-dkms.0.crash with some details on the installation failur=
e. See pastebin [1] for the detailed
 error message.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Any ideas what is going on? Please let me know what I can do to resolve it.=
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
In advance thank you very much.</div>
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
[1] <a href=3D"https://paste.ubuntu.com/p/747H2V5q7K/" id=3D"LPlnk862359">h=
ttps://paste.ubuntu.com/p/747H2V5q7K/</a><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_DM6PR15MB407280AC90424B9F52FE57D38FAF0DM6PR15MB4072namp_--

--===============7229649037544776394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7229649037544776394==--
