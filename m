Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B477C001DF
	for <lttng-dev@archiver.kernel.org>; Mon, 31 Jul 2023 14:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1690814658;
	bh=D6xUKNnbBY450bhnT+OxIOoYFdLjpV+yp1ZFwQ3cGp4=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=qzU7r7as/soIejqgHdxAsQ0Bg3pLVaue7RX+lt+8vgcmbe4sGcIWphrALDoDDEN3O
	 OgX9akMyZLfj2gLUEQowSiywNLJanvGeJAbfAR8+A6CQiED9qla/ISqcFw4ex51B0o
	 b4fNgEPNYwychv291bvR2bmRa6FCu37RVhS910rBm80AJ7nPY2kjuF1GVlwcXEtltS
	 yUhBV57ybQxhPIYROqI7WinPbzpto19WuIil+OYafl+zNHUnvNMHZdyMfhV7rYQCxB
	 7BCX0ldmB43nZaAN+GXF/Afkx9HYek5ysFY767cAYnRwcyxGYyxHsJ5QrlNjJS2CZH
	 afgn8WMfU/6Kg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RF1GT6zLSz2GPB;
	Mon, 31 Jul 2023 10:44:17 -0400 (EDT)
Received: from IND01-MAX-obe.outbound.protection.outlook.com
 (mail-maxind01on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:700f::600])
 by lists.lttng.org (Postfix) with ESMTPS id 4RDwKX4h0vz2GcH
 for <lttng-dev@lists.lttng.org>; Mon, 31 Jul 2023 07:01:36 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkdwmmlOuujrsbHo0siGZV5fSEsExV7W9/S8OUgp5bosdeXWx7lMLgw6VOlTFv7+InvQb7N5Bu+jB4aUJMG61tezdeaq0CYs6+T6+HSgV4GmG/SAIl3kdTwCG6Kkn0ENPREKjgq+PM1UVYEcd8XnEIBbi7UvSfr1WfiYauR20QGT60R2Mal7C+wujGBlIrRC5D6Fe1ztwcJehqtfuW6K2QK4YJOeD1Cxa+JxFVO+DeUmrmOwp06OZrNZ+bW1A0CBqf6UeRKUbWWZG9t1diH0Q5/h2Jhw0LBt9drjwtQiNqbgqhOaBb9u8X8mW1dSB1L2djD9rsc7R9SrUvTdZBgsVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jvc6q3jQ/4nskQIBNV8XORMeWUcLyxsoEfGRQAdaxbc=;
 b=V6LAj36iBq0iIKBTleslTXZ2yXeuBI2xH64GguuNMRnVFeOhE18bxVHATLS2tLoEIDm++Y0JwJq9sWhEat+Jgi1dqtAAGov2uF6kI3+afa2CiWJIp6JbCsMocK10F9VSvVtQDjo+P1dV5PiwxLg2oEEWQYOY5RAPaOInVBrNEpb3KTAfW8K5z9iyuyiIgwiryVvtWSBC9kG36yYPjS2Q3R05LVkD1bnmi+nDJNiDJXTnPZUi3zpX6Aw/5FdR79y2RJOD1JCeJWuw8H59phQy6XKF6UiK86rEZufN0Zih6HB1LU66C5XopqAoWMIiF2QScjB8kOo1IZOn4mDUPvobuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kpit.com; dmarc=pass action=none header.from=kpit.com;
 dkim=pass header.d=kpit.com; arc=none
Received: from MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:1f::9)
 by MA0PR01MB5895.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:48::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 11:01:27 +0000
Received: from MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5d7:959e:5cdc:e85e]) by MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5d7:959e:5cdc:e85e%7]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 11:01:27 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: profiling areas of LTTng
Thread-Index: AQHZw5zfMJA0fQ1cR0C7DhJaoZwzMQ==
Date: Mon, 31 Jul 2023 11:01:26 +0000
Message-ID: <MA0PR01MB6987337231830A85B736F2538505A@MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB6987:EE_|MA0PR01MB5895:EE_
x-ms-office365-filtering-correlation-id: af56cfa1-2af1-40e0-831f-08db91b57ca0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PkPwPDbAC6x1zTmNL21E+w6Shhq7r/w73/010slVTpbTEp2d8D2c6DsrfJ68zK+aupjpl3aOq7QuduH7wFObPtfUWcfxOAsF72l6NDKs0E8U3untHjDPbCzISakw/TM7JP0g4/UWRsX0q3ndr1AOixsOpF7IKhKLUc3icA8BqsMq+afLYiXJxYfBwv5aEXb9wnywexQTfRe/I+tqv/jcs3BHMoqTPBGn7h/aVNIBNXQGFVMoYJo2Wait/9x7A0FySlQDHwDai9+0pIuCgFfw1Iu7+D049aA3DsHBucBzBZ9DwuMjyruyhxa8mmx+iAE57UHETuqwIM1C8hSktME2dpTHG5+Dr1grpaakBpELX2SjeUP1CgDQ2xWD8UsMAikal6Z9NQF0tpARll7BWBAV3KDMpl4/4RrBeGA1NMOmYFRyLDbFT5B8eOmitpoWdWMX1l/KonsE+Di1jbF6OzzJ9PPUnUa7liW/SHL7a5bMYBwgl2Zw50fmW3OEZIP6v1RfuZmzUzylbFp7sH0I8yaGhwS0ib7mohwBImO+9Umjluo+mKCKu6CkLZlRI9ZYjk03vnveaQbckWfXDHR5Zu50B9gnSWANwEukQUd0obWLwN0WkPNbAAc4Sfk06ZKnXb/p
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(41300700001)(5660300002)(6916009)(66946007)(76116006)(8936002)(8676002)(55016003)(52536014)(478600001)(64756008)(316002)(19627405001)(66556008)(66476007)(2906002)(66446008)(7696005)(9686003)(71200400001)(38100700002)(6506007)(26005)(186003)(83380400001)(3480700007)(33656002)(38070700005)(122000001)(66574015)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lsyNOu+PSe2L01M4rnKZ7rqDOygaroweDTca9p23+1H46dYGvtOlumx5i8?=
 =?iso-8859-1?Q?VpHl6oMgEnhQ52s4eHJ7/S79AzhMM3o2Geh7i31liygXK/BZsGjfaugfyd?=
 =?iso-8859-1?Q?soIhPL61hsJR1+KNvvBO/CIdu9EpYT/yTb2WBWFYspsfSK0YE3cdx5LWOT?=
 =?iso-8859-1?Q?KuH2Cph6MyZ55a6g9okeoAt+4jCXUxtqHbVVjhazfPF47KiSQcRT0HKcYp?=
 =?iso-8859-1?Q?L6Is1mcLec3b7mdhhbEke89IImL7rKJoWj9GYSKznsqLDfUzbHxbCSZ6Dc?=
 =?iso-8859-1?Q?gtK5IyFsc1rYVoVbhI5um9z4tmYShjvnG/BVMXogP4TdPybaDwXAlf54fE?=
 =?iso-8859-1?Q?X7SID/wRl7DtIy3Wh6aTMRJyJRnGGknx45C5x0vvKqJOZfAVsEe7OBB7tX?=
 =?iso-8859-1?Q?XAbMVj5rK7OZPI3sucsl32F11zHOUrZy5xmyctmVAA1a6umU310hrjIzlv?=
 =?iso-8859-1?Q?PBpZjyMsk7yIVQ5togQQLHQHoCDBBrdGrK9TDDkN5crddjBt8MqbAc3eO+?=
 =?iso-8859-1?Q?uex4f0bY6fkXM+Awzd0KO4SjnXv4QV39RBtqUPxUKFACU/BRy766endYLW?=
 =?iso-8859-1?Q?NbFQxQrBmMZe8V9pTPv39PAPZjK8geCqMJU/Y2QIgN1QPToPy74MCO/mG7?=
 =?iso-8859-1?Q?/A6TwX3KOf/Px1T5P8eoJ53NQDD33MGEJJHKYxWPPZAVkmyuF9PaadCdlp?=
 =?iso-8859-1?Q?0qP4Z4kk20HiOAv+7aKQFrn89ZCul6MSk9CsHp1KLZVqY5Kbgib/6VEl8I?=
 =?iso-8859-1?Q?OIhg6z8HZMmZaDkF9IjUWwyJ2keoFKxD0iXPbi55JYoGMZDyJXV0IX0exG?=
 =?iso-8859-1?Q?GIraPkdDfic0mPg9Z2VFt+JzmVmPndOd/iAtXaS65zNnrZgd1zy1tY7gkJ?=
 =?iso-8859-1?Q?XpYK11Qij4IYWMHxJCqf/34DnyuMG+vPEtot2tY9uDQEGxseDBsDGQQiKf?=
 =?iso-8859-1?Q?VU+Yn3pck5Q1JxaQP349xb4z+vpNovV0QsxrJgxv7bgRhp1eMVdGjGiheJ?=
 =?iso-8859-1?Q?oYUIixmKE0Sf8RNYbKlfE4BhQVQCpAsp0q9ZVgMp/0ICEKjRVj9lRiCT/r?=
 =?iso-8859-1?Q?tIT4J7Bn8hW+IBN406BTwFjqApVqqss+S9prgvDehUqlakCVhEpH3Oc7CQ?=
 =?iso-8859-1?Q?2TPS/GFdnL9odbfdowMeblBbVsIZ96+pAnY8Vulq3l4S5SRnLnI/FUXFJN?=
 =?iso-8859-1?Q?F/Fs7zpdaN+G624iPm+bHnl9vl4npZZotrGQK8+lo4LNpEXRlpsxSizDDk?=
 =?iso-8859-1?Q?OYOyInoTu805fKd8xDxQEybecDQQAe9qnrrkxTropcOE2jTY9F5dZaIfZb?=
 =?iso-8859-1?Q?c33st9jo1CP0zo4/gWLST2ZNmrQMo0rRgCqDp/HUn5Nk7/Hr4mKUYv7Hfs?=
 =?iso-8859-1?Q?Cp/1yuWuWz33ovZOXRqudKC+2FDiELhbBdxm1SYH+NxBOLYGutWcHA1S2u?=
 =?iso-8859-1?Q?j1Lc6hV64h9wwp7pc7ztEzLkceZlaeNFBM8CnIJPRDC/xQ9MOEWI7Ek5Wd?=
 =?iso-8859-1?Q?vhM0Z4Jht7sxj6k21I/aVbxQp/ppVvKcsuNkZjOPWItdwG4fcn3F5xaoYS?=
 =?iso-8859-1?Q?jK1oV9xRZFlfT/KsOZr3kEMDWmI6r72VUXvLk+e7bc++B0hg9bt0ITrWOu?=
 =?iso-8859-1?Q?xo0nv2LePXc3U=3D?=
MIME-Version: 1.0
X-OriginatorOrg: kpit.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: af56cfa1-2af1-40e0-831f-08db91b57ca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 11:01:26.8470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3539451e-b46e-4a26-a242-ff61502855c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ntVrqlNqXoAQwDuXZ9w0kvD7aTP50FfhD8h3mAZzt/7Q1iChaxbU+5uiWeNOY1xT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB5895
X-Mailman-Approved-At: Mon, 31 Jul 2023 10:44:16 -0400
Subject: [lttng-dev] profiling areas of LTTng
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
Content-Type: multipart/mixed; boundary="===============5171477601876325452=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============5171477601876325452==
Content-Language: en-GB
Content-Type: multipart/alternative;
	boundary="_000_MA0PR01MB6987337231830A85B736F2538505AMA0PR01MB6987INDP_"

--_000_MA0PR01MB6987337231830A85B736F2538505AMA0PR01MB6987INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,
         I are working in a Ti project, I already installed LTTng and i am =
able to trace userspace.I have a doubt regarding profiling areas of LTTng. =
In the project we are using ISP and RGB gstreamer. can we profile exactly h=
ow much time taken by ISP and RGB gstreamer to process each frames by using=
 LTTng userspace tracing. i want to know is this possible to profile by LTT=
ng, what are the supported profiling areas and peripherals of LTTng, Sorry =
if any grammatical mistakes made.

Thanks & Regards

Bala Gundeboina
This message contains information that may be privileged or confidential an=
d is the property of the KPIT Technologies Ltd. It is intended only for the=
 person to whom it is addressed. If you are not the intended recipient, you=
 are not authorized to read, print, retain copy, disseminate, distribute, o=
r use this message or any part thereof. If you receive this message in erro=
r, please notify the sender immediately and delete all copies of this messa=
ge. KPIT Technologies Ltd. does not accept any liability for virus infected=
 mails.

--_000_MA0PR01MB6987337231830A85B736F2538505AMA0PR01MB6987INDP_
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
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Hi all,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;I are working in a Ti project, I already =
installed LTTng and i am able to trace userspace.I have a doubt regarding p=
rofiling areas of LTTng. In the project we are using ISP and RGB gstreamer.
<b>can we profile exactly how much time taken by ISP and RGB gstreamer to p=
rocess each frames</b>&nbsp;by using LTTng userspace tracing. i want to kno=
w is this possible to profile by LTTng, what are the supported profiling ar=
eas and peripherals of LTTng, Sorry if
 any grammatical mistakes made.&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Thanks &amp; Regards</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Bala Gundeboina</div>
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

--_000_MA0PR01MB6987337231830A85B736F2538505AMA0PR01MB6987INDP_--

--===============5171477601876325452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5171477601876325452==--
