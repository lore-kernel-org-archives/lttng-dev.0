Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C327CC6FD1F
	for <lttng-dev@archiver.kernel.org>; Thu, 16 Mar 2023 16:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1678983861;
	bh=oLAaYZQ+9O6CBkCLjHbBL/ubST3OhAB2VsL9terpHP8=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=oepvfcZG4IRqGN0YfA9vRys77rJ7XMQV4RX/1MCeZa9iCHTZk1joEtm7hUDzHdvTH
	 qD9XQNINF5oRDB/iDWyeoVNIoiBhELLdv2jZjNBVENHjQKlVCyy8iI1JnwEi3SXNsP
	 pieOy2wgJdIAPGph39+kg4zvx9BzRj4RTeGeCxso13ouZcEY//zx9Ul8xP104lZy1H
	 uhgFkjra/NgbIjzt7VlsQADVRSf+ywuAIdQugdgxWYdo/Ts3p1JngowpYsH9zf1+8i
	 uP0Wq8UdgckJC7AACYDBKJwImU3KDISvRLIed3Yrc8uobAfwG8sU1zrOUnSDnTeKFt
	 Zu1X7evSEMrpA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Pcsz85SS3z2CSy;
	Thu, 16 Mar 2023 12:24:20 -0400 (EDT)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2050.outbound.protection.outlook.com [40.107.115.50])
 by lists.lttng.org (Postfix) with ESMTPS id 4Pcsz42f52z2CSx
 for <lttng-dev@lists.lttng.org>; Thu, 16 Mar 2023 12:24:16 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4P1vhpu5kVQa1cqYRVBur088Asb1gqorpX2vDY7QWMc8eVgd6V5fB4t5QvKZvUdIPsSER3ZgmvwE/rDpMzl5nrawQhLOiIGDjUYtma/dwh4PbaUUgXFox2eSIzSg1Yw1nsMmAurmjkoQixpJ0t5dobvAW5ct0HEF9LpoDtzX8g5qMtHOiHZFHpY96IR6Z6Dx5djiWFhvniUkD2UIID1uk6w2vh814AzmiG3QN8VtjVOVjWxpqBxc2E32ssQhEOFCEwN6CUdT8RTlh6/ybvynYv+Qg7RLSzvPgXJuxtz9dl8BJEp7SLeOzhifKTLB/j9iywMgFjkxo1J98vE/vhdmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRl/+S68oDCMmhzxqwOxHdPpibLOLHRN6fvC8F6Qn3Y=;
 b=ILw73FT4bxxcw0iHnchJp77dBSOO3M0f+59x7Ld6LBPdr5+A9tZvormMB+IwFjO+sExwmoy4Ao7tlPFIJYTemwJKZ9QXrrDRrZdyoLKHSwvy0d2fHBKKDHkKwMY4pV37kd7SL4YdjIV+3IGkQFi4z1ocvzi9db7PMRgAVpxVOR3lvgw1QdKeiCokTbi8Sit1UQFW8fBHif2qgVXLF9iFsmJxB2uXqZgao3u/d+dyBd1CPX7WxLVUJGfDElwhfXkburhBIbtqwanGuzhXJI/uMpFDDcHhWCgAEJf7kKeUtLMIqjnj40tvL16PFyOJiitl6ugovZc46+Be4I7Ar+S7YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4e::11)
 by YT2PR01MB6578.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 16:22:34 +0000
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a5d:d20d:1c9d:58b7]) by YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a5d:d20d:1c9d:58b7%2]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 16:22:34 +0000
To: lttng-dev <lttng-dev@lists.lttng.org>
CC: "thomas.gatterweh@siemens.com" <thomas.gatterweh@siemens.com>
Thread-Topic: UST context field "ip" is now in decimal since 2.13 instead of
 hexadecimal as before
Thread-Index: AdlWU1thKimbRcIJT/u/xe6ifEEvzgBz93AL
Date: Thu, 16 Mar 2023 16:22:34 +0000
Message-ID: <YT2PR01MB5984E8854B2BD53408235823BCBC9@YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM>
References: <AM7PR10MB3175ABFF6003EA76635C94BB96BE9@AM7PR10MB3175.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM7PR10MB3175ABFF6003EA76635C94BB96BE9@AM7PR10MB3175.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-CA, en-GB, fr-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=663be660-a594-448f-ac9a-31edf51f09c1;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-03-14T08:52:22Z; 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT2PR01MB5984:EE_|YT2PR01MB6578:EE_
x-ms-office365-filtering-correlation-id: f2f329b0-ca17-432f-fd9b-08db263aa69b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GRvRP8P9k1SNHbPYdaAAQvSfmiDeFZ+nIMcclauSsCCkvSwmr18bxmDoI9KtyYX2gEAQCL/BYVUszmJ5IX/5FzJshYNExaxgbRo3tO0910jqun33Id7D4f5rstVSsSDoZGwzZLZ0nRPdCfpHhZ55blRv7BAhlvOmvLaIiIW8th4x9Ea/F6kpliTQ+0+qe9e4dPVb3nwB9k4NR5autd/3axQ3LeaTTT9decUjmRbeQvORPebHFFQQGM4Jx/43y99dlf2DD9wFrDBJCS4gqbj7dR/Bd+Htyz/SndVcjSlrt2fNUdi17IecT+j8R8pdzrPAur8Ff+r8I5AuRJcHwmR3iW5JND/o7TpRC8mUsGYX3c4eVwm8jgwS86M2b9/ZMR37A2/vBEUTmXsCCnHEkAYGgCo4HELNorzUBMihDbU+EHhd173R6G0/XS1xEstSPDEnZzyF72cZ50ym27bLAc/DZ5zz3Gauy0dt3CXvSuIm8Oj0/FuolefbjGa/jeDJtRfptohLFVrYeNT/BMur2YpkwC3iAjeu+bl9IiC47CrXzzID5yVmbjw8+1MjEeU2y8vculzEvYAf+OqRSj0BNfvJHfELN0WgII34a4FPUv9/61EWazSD9lHFKTBcV8+M6IddZhbBe3BeFQIqUvkFSLJRtCLWtSRobtj3jnE/S0AQ95rZReKlhY2Hn/29afeMVOl7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230025)(366004)(346002)(396003)(136003)(39830400003)(376002)(451199018)(19627405001)(186003)(66946007)(4744005)(91956017)(76116006)(5660300002)(71200400001)(64756008)(66476007)(7696005)(8676002)(66556008)(66446008)(41300700001)(122000001)(52536014)(2906002)(9686003)(53546011)(38100700002)(6506007)(26005)(478600001)(6916009)(166002)(19627235002)(86362001)(33656002)(4326008)(966005)(38070700005)(8936002)(55016003)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?r2WWWEruFNIf1apN2XCn3n8rY+i4BMJPBLxKHIdG0VkEsK8eoHKpX7OL?=
 =?Windows-1252?Q?NAOv16H+/SVv9zAsEAbVqdiR7L5qJzjD0zlTXHZNf6wbzXj9jNTwyg1z?=
 =?Windows-1252?Q?A+yFbUX+QMIxDelpTYmDbGwvmiMZ0r3MrsVuV+aLG4l9SDJGNVLSb3d8?=
 =?Windows-1252?Q?jSa8dQyKILDi0MNiZ/W7lcm0bJWbRO4BU1g1rDCqCealGrmepD4/rvlw?=
 =?Windows-1252?Q?PA06j+wBD7Xk5amWLGjMHy6etewoSaGVMiCcJsjpdV54KDN6OmWBdjzr?=
 =?Windows-1252?Q?8UqutKxfTzoRVBPXYtEMqMFIa3Pa3tFF7L5G+ZDNNVGYfo8ZEpRGWw2s?=
 =?Windows-1252?Q?KVjo3Q7fSRB7jfz3pbBzyQbh9I1EB+V35ws5WPu4ZnzSQOmL8jx+vGaH?=
 =?Windows-1252?Q?Vb3KqDTh8oSHEyXY8fuKVCEfVLIx6bfcvUcp3gkLv1DpX0K71OaP9z8D?=
 =?Windows-1252?Q?HgZPAxOcEqJttoSQ7hHrxQOVvyYbmdUYXulrUDr1HcBnqzBJe1QOJ62I?=
 =?Windows-1252?Q?gZYkmhSm7TB8Em7PedHzODoVPi5TWDgbA2ZpBaeWJg2liaOXfpyxq5Kn?=
 =?Windows-1252?Q?2gLgt7txGRfUsnxsqzqHoJUYtFTdTI2GmI+8XIPB7oFEhDAPblaMAGBk?=
 =?Windows-1252?Q?lEBr0hOcjuv6YHLaCObGgAJqUC3ZFJHB+B5WFXkx2otMArH3ITyfcI5r?=
 =?Windows-1252?Q?hGqpex5gloxlVwjDiz7Vd+IZ+s6JDlE8ws/QPVn81Unjjqg9/yS0Ig18?=
 =?Windows-1252?Q?TE91QSV+v2UrT9MSrBdgNZ6zpOVSAhaBmXh+f9N3m79BMXYtEJBmlTh2?=
 =?Windows-1252?Q?+LCifqNan46DPr5R6EXm9I+9vqxtT3W3FpxYn4hLtN1LWxMple31l3aa?=
 =?Windows-1252?Q?oSttu0cjlapJ+68DXAJ2O38WL3TF8obzCe8rX5K5oB4BXHe8VmJwJw3k?=
 =?Windows-1252?Q?6S1XpCkm1wyQshilA9jhIWvvGPvx4LcohKOXky4nv6/+cezuSl3H/i3V?=
 =?Windows-1252?Q?6xaSSvRo3U0bxsunVjOYukRAYsdRPH1FFB7w5rVWRy2qYP5hIzdXuXNF?=
 =?Windows-1252?Q?ZtJwboJklRoxF1cTPbExMRfD0yaw54vhaxI/k6GkyN4Trcv7do0doGxK?=
 =?Windows-1252?Q?1/I0TapzYiCwwWdOX0pKm/3NQRJD2c9Cv+W3JpodkAhCcH54Vc6WB4CJ?=
 =?Windows-1252?Q?unl3wxAyAk3ZuizColCu2zrAQ4aYRR1U1fuGBsMH3mQV157nk0oSC5Xk?=
 =?Windows-1252?Q?QZbyry/z2fI2o7BjhkjOnF+8BZA8Cb2rRc/9Hn2PInTvcTSAsLlVcRHN?=
 =?Windows-1252?Q?hdG70Y4Kmqh2jnxPedMqUSVlaNjhMKtKj/AcOHaJU/iEOvUU9gh8ylfo?=
 =?Windows-1252?Q?VqumOvUXN1nOgbTWI8SGII/9eCepksqk9+IZo793RkrDcJQx07N1dNK3?=
 =?Windows-1252?Q?pRvC+NGwiZ6Doij6lXAiOcAueOYYmI02N3sGgZQmb1OApqgZvUbH/mTJ?=
 =?Windows-1252?Q?FTVgYzIGJjQ6RTTBTiw0J6UDaoI5fyx9LNVVO9tbRqbMxy6sAuhUdWjD?=
 =?Windows-1252?Q?h8/RUb4HaymwSYOe+oklfHtwARPQeG+PN5Wr9fFYLmVd5NglWXrkEDpY?=
 =?Windows-1252?Q?mY7g35Smhf/mVLfFrpU3cG2XXEoDvFQRwKa3yPuFLdYfT0XaC8e5Emwi?=
 =?Windows-1252?Q?V49MzrNEWP4+UgFCPKFE6bBORuiRFp1T?=
MIME-Version: 1.0
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f329b0-ca17-432f-fd9b-08db263aa69b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 16:22:34.7944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RZBrMG4+k339lI0M9OBOGqLFz8mwvHbmrPADdIn2eqHjKOJN85ct3Wa9dfHJMjcWnR76iHiNqCJ8beDiCuZphQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB6578
Subject: Re: [lttng-dev] UST context field "ip" is now in decimal since 2.13
 instead of hexadecimal as before
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?Windows-1252?Q?J=E9r=E9mie_Galarneau?= <jgalar@efficios.com>
Content-Type: multipart/mixed; boundary="===============0624338487974233893=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============0624338487974233893==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_YT2PR01MB5984E8854B2BD53408235823BCBC9YT2PR01MB5984CANP_"

--_000_YT2PR01MB5984E8854B2BD53408235823BCBC9YT2PR01MB5984CANP_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

I have submitted a patch on our gerrit, see:
https://review.lttng.org/c/lttng-ust/+/9659

Thanks for the report!
J=E9r=E9mie

--
J=E9r=E9mie Galarneau
EfficiOS Inc.
https://www.efficios.com
________________________________
From: lttng-dev <lttng-dev-bounces@lists.lttng.org> on behalf of thomas.gat=
terweh--- via lttng-dev <lttng-dev@lists.lttng.org>
Sent: March 14, 2023 05:03
To: lttng-dev <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] UST context field "ip" is now in decimal since 2.13 in=
stead of hexadecimal as before


Hi!



In this commit  https://github.com/lttng/lttng-ust/commit/4e48b5d2debaf6c0c=
598489c183cc6cb2125c8a3  the base for UST context field =93ip=94 was change=
d from 16 (hexadecimal) to 10 (decimal), most likely an unintentional copy&=
paste error. See change in lttng-context-ip.c, line 47.

Can it be changed back to 16 (hexadecimal), so that the ip address recorded=
 by this context field gets displayed in hex again, which makes much more s=
ense?



Best regards,

Thomas Gatterweh

--_000_YT2PR01MB5984E8854B2BD53408235823BCBC9YT2PR01MB5984CANP_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
Hi Thomas,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
I have submitted a patch on our gerrit, see:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0">
<a href=3D"https://review.lttng.org/c/lttng-ust/+/9659" id=3D"LPlnk647902">=
https://review.lttng.org/c/lttng-ust/+/9659</a><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0">
Thanks for the report!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0">
J=E9r=E9mie</div>
<div class=3D"elementToProof">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
J=E9r=E9mie Galarneau</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<div>EfficiOS Inc.</div>
<a href=3D"https://www.efficios.com">https://www.efficios.com</a><br>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> lttng-dev &lt;lttng-d=
ev-bounces@lists.lttng.org&gt; on behalf of thomas.gatterweh--- via lttng-d=
ev &lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Sent:</b> March 14, 2023 05:03<br>
<b>To:</b> lttng-dev &lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Subject:</b> [lttng-dev] UST context field &quot;ip&quot; is now in deci=
mal since 2.13 instead of hexadecimal as before</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:Calibri}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_MsoHyperlink
	{color:#0563C1;
	text-decoration:underline}
.x_MsoChpDefault
	{font-family:"Calibri",sans-serif}
@page WordSection1
	{margin:70.85pt 70.85pt 2.0cm 70.85pt}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"DE" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:brea=
k-word">
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal"><span lang=3D"EN-US">Hi!</span></p>
<p class=3D"x_MsoNormal"><span lang=3D"EN-US">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span lang=3D"EN-US">In this commit &nbsp;<a href=
=3D"https://github.com/lttng/lttng-ust/commit/4e48b5d2debaf6c0c598489c183cc=
6cb2125c8a3">https://github.com/lttng/lttng-ust/commit/4e48b5d2debaf6c0c598=
489c183cc6cb2125c8a3</a> &nbsp;the base for UST context
 field =93ip=94 was changed from 16 (hexadecimal) to 10 (decimal), most lik=
ely an unintentional copy&amp;paste error. See change in lttng-context-ip.c=
, line 47.
</span></p>
<p class=3D"x_MsoNormal"><span lang=3D"EN-US">Can it be changed back to 16 =
(hexadecimal), so that the ip address recorded by this context field gets d=
isplayed in hex again, which makes much more sense?</span></p>
<p class=3D"x_MsoNormal"><span lang=3D"EN-US">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span lang=3D"EN-US">Best regards,</span></p>
<p class=3D"x_MsoNormal"><span lang=3D"EN-US">Thomas Gatterweh</span></p>
</div>
</div>
</body>
</html>

--_000_YT2PR01MB5984E8854B2BD53408235823BCBC9YT2PR01MB5984CANP_--

--===============0624338487974233893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0624338487974233893==--
