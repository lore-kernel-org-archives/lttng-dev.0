Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C96C001DB
	for <lttng-dev@archiver.kernel.org>; Thu,  3 Aug 2023 18:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1691086118;
	bh=cgGuQitwiB3Imv/oaze1YTjymtlxakomxENZOQ8gi4c=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=05ADPoB8JUnKPDwdAMMLRRoInvi8u/oxapJ0msC5eWO4bOgvDUS5t9uewKJQ6ALEA
	 Vz+Tv+YNbwSFsu7fzrFts2nba0+oI69sc5kvsR15Nbhof+YERabpTiIdATfQ61MkmH
	 w4bz/drfvhAOeiDSjN8MSP1sWtsHUsLLAOQ2387HnWXZZu0xykU8DPUuTNRcv9dZpN
	 oMFxzM6H4fkIOeO10SgAemdl1Nk28rcPYiuAViZab/Zf2pSupA6lejFJK/l4BmzHt3
	 EklmfWBz0aSTthBlFlLg6X6qKTjx281tk4U6hdJqzOExOQPesj4WgenNXlZrAEDJcc
	 +hPy7RoVhbydg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RGxfs5T6Rz2Hdq;
	Thu,  3 Aug 2023 14:08:37 -0400 (EDT)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (mail-os0jpn01on2069.outbound.protection.outlook.com [40.107.113.69])
 by lists.lttng.org (Postfix) with ESMTPS id 4RGvnR5vpGz2HnX
 for <lttng-dev@lists.lttng.org>; Thu,  3 Aug 2023 12:44:11 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUtC7nXCBw9wl9FzYzpZzBptqvlojuX/EyLL3xmN1IMMbaPCznTbmYTtgg+ZAVsnEXChjAAs3J/y/p4Z0kwg5A4PUdEFMQvOe+sbvT1/4nR0RwnXFKXRDtOUYqQRek/JL1zVkulfhDtSSnfWA09Ff0Ut2VnzJ0RYKTRh1Jj2aCHimbn7TIVIrFB3xk8WYNAzA9m9nCb3M8+o2azRNt4sGlEGw1FVoKwZyoBvYI2yQbO43YCbxWjNLd4MZjsOlOOF02fnmMMKbqiTWdR3hfgcxcxRCG2s5Qms0AuDEUn3XYVSjOjb0g7ORmrYseKvN3LKd4jhfkatJyoKYVUYTPFJxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSFl+oyP74D/swNFz00ZQAYwbkVCw8bb/tPNwHI0ZQs=;
 b=A0oNEa2EDZ1ojyDXYcan2MoUX1PrCWzXYkYc73WA5t26sm1Z1iOdGGldimJqhL3vfosijWZ9USeYMBsd1a7lapFxLDS4IzZ6UcW9/e2kspW2yNGJuzkkohR9o9DS+AMc6UkGjql/EGaMq/2MIBYMzsVz3UGPCYNxkIph5KpIkUydODeeNFrEGxzPuAaP3AbOhwR6genIVOhgbUAA+V5m+faOxlpDdlOmmOOcqQXsP9cZccpgQkazEI5JMmusYQCVB0sxnTMAEmbrFeioHQbXo5UBemOkbw6FsGT+Nx9U6ui4ZUkhF+2gco6kfV8tLyG6ghJVZLbwgT/Te/1xJJlDcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=my.cityu.edu.hk; dmarc=pass action=none
 header.from=my.cityu.edu.hk; dkim=pass header.d=my.cityu.edu.hk; arc=none
Received: from OS3P286MB0549.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:d1::9) by
 TYCP286MB3586.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3a5::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.20; Thu, 3 Aug 2023 16:44:08 +0000
Received: from OS3P286MB0549.JPNP286.PROD.OUTLOOK.COM
 ([fe80::3e5f:e3d5:662a:c5b4]) by OS3P286MB0549.JPNP286.PROD.OUTLOOK.COM
 ([fe80::3e5f:e3d5:662a:c5b4%4]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 16:44:08 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: How to use lttng-live plugin with babeltrace2 python api for
 live LTTng trace reading?
Thread-Index: AQHZxihks31yRN3+P0qzrTvxkCWqaw==
Date: Thu, 3 Aug 2023 16:44:08 +0000
Message-ID: <OS3P286MB05492E608E11B8EF50A47421FF08A@OS3P286MB0549.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3P286MB0549:EE_|TYCP286MB3586:EE_
x-ms-office365-filtering-correlation-id: 0376d3e1-ae6e-4d70-8ba6-08db9440db7c
clutterbypassedbytransportruleoverride: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IfdICITKkIqMnnotvkFRHjmQ1qS2pX6Byp7Tuars2og+cAZ+1k3dzJOGic0h1jGq6xDJq8WF7MSSlRCpWS+h0erB/n2IAgOs3VoBzP1DFqQ0hoFupmnXPpU3gabpihiWfxrR2x0XyinCSF8hssnm8jwKO8h6UoBZTHK55Fc/gdKv0vH42u32JSwt8iwFD0/6j5/AtUSKzy/9YYwZHR4OQTu8ZxMhiVCuVyCCY39vosVpy03wKmlBNoaNJdiU6ABh6KksmJw3zf7t7z/LPzH8RYiWFmjBTPozHTMICHSrorZia1r2VXap/AOYLIxvdRzcPYu7sfahRBM7L1szpiLuhhP+HFI9CHV8raSpxYu03pVIJcGo8Th+1wpKsFzohik6ubyDs7XJdB1ssO8sPmJKKctfy4l6+hNKpevEeCY0/BDdrBwReFzmGRajQ54baxnTn1eQGW/646cTk+Crybyi/+ftfRrMxP87+igcd9FabInyKjhd3FFG0EJLDukj6a4d4UDQe1zQxp71c8yYUERvbWp4ZEb+J7pozGcJyFaH1V24qfaKjyb9m6gBc6jzhGaE4xVPOpxDyRLgnP3xDGsy/aDYX9gpke7zbUVaUpUZioftRLP/8FKuZqKlJu4BH+gV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3P286MB0549.JPNP286.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(6506007)(186003)(83380400001)(26005)(8676002)(4744005)(66476007)(316002)(786003)(66556008)(2906002)(91956017)(66946007)(5660300002)(64756008)(6916009)(76116006)(66446008)(8936002)(41300700001)(7696005)(71200400001)(52536014)(9686003)(478600001)(55016003)(38100700002)(122000001)(99936003)(41320700001)(33656002)(86362001)(38070700005)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?OWFra0hJYk4vWTV0NmZvTEV2Y1BZOTYreXYxcklmNm5wTkxaWmRCeWxJUW9P?=
 =?gb2312?B?Wm1FK1FDL0RwazgvVStBdTBISFhlVm9rRGEwL2kxdndtWGlUMUU3WU9YZmVF?=
 =?gb2312?B?eXVwWlVTVkp4MkVRaTJrTkpVbmNMWS9yTW5Cd0JoV0V4NEVwdk1ZS0hCa3Na?=
 =?gb2312?B?alQ2dUtrdUVQWHFpcHQ1OXRnYkQ5clI5QnZUeFBQdSszY0RkSlN4Y1dOdHlV?=
 =?gb2312?B?SytVMHg3SDB1V2h1ZU1pQVlHK3BaelBJZ3BGbzNEbnZsYkVhNEN6UzZCcit0?=
 =?gb2312?B?dWo0ZnF3Kzl6RGxNVnF0OUdSaElNWnpWL3FUcFhKYTNsVHRBdkdEVzZFajJU?=
 =?gb2312?B?UlNITHZSUU5lZWVXMW0xODQ0Mlh1TkRvTVdReTIxcGd3SE5FMmllTXlhNitF?=
 =?gb2312?B?aGFHQnFvWEY0N1QxNW56dnFySWFEeTRFeHVFY3ExNUdiZndnVlNRTXIvYW1t?=
 =?gb2312?B?WnJLV0cyTC9kTjFEMFAydnpyTk16TFBFOFpsQ3F0eGwyYkNYdnducDJuWXJY?=
 =?gb2312?B?dDlaQUpudE1DbUJTejBZMFN5T1lOMXJlV3dLcmNnUTdwVElNZmFhdlRNcllI?=
 =?gb2312?B?bEUzZU5kUGtqeExaT25aODlmR2ZId09xY1dIUVZ0VlpsZnE5Z1N2ZjYvdGtl?=
 =?gb2312?B?TEgxMloyY1gwdm1tTXkzVzU4SVRuakNnUmVlcWhWbkxyOHIxZEhmVmt4aFhR?=
 =?gb2312?B?cldzVDdpdVVtVUtFRGpyb1JxNXZIQ2kzeXJGWU5vNmxGYmM5NXVaaldrYWJz?=
 =?gb2312?B?NVAwb29PbGtZZ2RmSHFwanZoSmRyQVhTakoveGJOdWgya2pzNlI3cTdtbk15?=
 =?gb2312?B?ajVSWi9FaXF5bmJxbW9HM1FidkZCNVRxYkI5aWFRMDZIRWlSUE92SktCZnFP?=
 =?gb2312?B?TnNSTVFMKzJrQ0hURFNVYnJtallUZkRlZHZTQldKZ2VBbkovZzRZUEhXREpM?=
 =?gb2312?B?RTU5aTkvWit3SE5xNkpXVnNubmc1UDh5UXpqdDR3a2NqYTZpa2dwZ2cxaTRR?=
 =?gb2312?B?Kzd2aUFpM1lKcTJiWTAvQXF3cHlabFNRdENML2d6MXBHa0NDTHdLeENZMURa?=
 =?gb2312?B?RFVUdm5OVnZCQjdUMUVLaWkrM0JBV3JWeGpidFNHOW00K2ZhQWh4UnRXRzdx?=
 =?gb2312?B?Y01HYk40Vy9ZbDFIMDNhN04wa3drS01wTFB5UkZCb0VnTWpuWDhpeXFDbzdn?=
 =?gb2312?B?dTkzRnNXUnZzOElwRExNaE00OG1OTXRPMThDb3BiL3BYM1BiTUxaR2pXOWJx?=
 =?gb2312?B?bG1yRktMZzMyR3lQQlNOc1FiQld2cHp2QkMrckRQMTZ6V1N0NzFKUlZGeE9P?=
 =?gb2312?B?YllGM1dEQjVVOVUxSk9NVnhFanlxcEpVN1ZGWExwNTJmTE9pODVuR2loZXV4?=
 =?gb2312?B?NHRKYkJFWDVSUmRnTWUyVzhMa29HU0h3N0d4UnUyYlU3TzhUYTN6N2E2UVRH?=
 =?gb2312?B?b1k2cEhQQmRyUkxBUTBTaHpxUTFHRm9FK2tXTWl0UnNMdnh1My9CcXpIOTJh?=
 =?gb2312?B?N1QzRmdKcndQSFFHUHhnTXpreEt0RkYzVUM0MWZCUWliZ3hnUkZxbmRpdkgr?=
 =?gb2312?B?Z3FwVHFROUdOQko5RTNqQ2dwc2hRU2xCMS81YUtSQWJPNzdqODQ0MjJxbUNy?=
 =?gb2312?B?RldHcXdKNm9PTy9BcGRrQzBiSzhnT1B2TE9YbW1adjRFRndGUmw3OG1DQjRP?=
 =?gb2312?B?NXNCTmRWQms4WmJ0ODVHbWRDWEpwMll1ZE52cXd1aFpqOHRqMDhTbi9CeUtC?=
 =?gb2312?B?QmpZTzFtVU5nb1d4Y05XWDZ5eEFJNzlzSXBlaGRaZER5SkczUWFFUHlwOTcv?=
 =?gb2312?B?dXpDdzB4NzRsTzVuQ2s3VE5QQzYzK2wyVzU0Vm96cjE4T3ZyVEFNOTFuTWc4?=
 =?gb2312?B?Q1VIV3dsOVVLdGxPU0dWdk5qcXlvcUltSzEycExaWS9YT1VHaCtJVU9lUlMv?=
 =?gb2312?B?c2xobk5NTEdQNmVzemhHYkE1Umx1NVRCdWIzeVhTUUtObnZZSmVleFZGYW1E?=
 =?gb2312?B?Y1NyTm1BU2p3TDBodWVJU2toNWFTajJyS1FBSjdKdHlLVG1FV2FyVlhOWWNX?=
 =?gb2312?B?MzVnb1B5dHM3OE1Ld3FMeDF1UFFTb2dwaVpmVjNXUFA0SWlUb0NqaDJ0dnMw?=
 =?gb2312?Q?KH3np6JfIlxwQ2I9Z0OJ+1XLO?=
MIME-Version: 1.0
X-OriginatorOrg: my.cityu.edu.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0549.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0376d3e1-ae6e-4d70-8ba6-08db9440db7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 16:44:08.4069 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2109ce83-7de4-4471-91ff-2053f90a1fd9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e+seaa3vydKwpCdy7GWvFHBp0nt9rcGhRdZhKCxsiXRLoeQ4shaVexDUWKpptrYebmN869cPdOunVe7QDGBbrJYpSjMgOw/EXOLVmSfrLno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3586
X-Mailman-Approved-At: Thu, 03 Aug 2023 14:08:36 -0400
Subject: [lttng-dev] How to use lttng-live plugin with babeltrace2 python
 api for live LTTng trace reading?
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
From: LI Ruoxiang via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: LI Ruoxiang <ruoxiang.li@my.cityu.edu.hk>
Content-Type: multipart/mixed; boundary="===============7807746668537757744=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============7807746668537757744==
Content-Language: zh-CN
Content-Type: multipart/related;
	boundary="_004_OS3P286MB05492E608E11B8EF50A47421FF08AOS3P286MB0549JPNP_";
	type="multipart/alternative"

--_004_OS3P286MB05492E608E11B8EF50A47421FF08AOS3P286MB0549JPNP_
Content-Type: multipart/alternative;
	boundary="_000_OS3P286MB05492E608E11B8EF50A47421FF08AOS3P286MB0549JPNP_"

--_000_OS3P286MB05492E608E11B8EF50A47421FF08AOS3P286MB0549JPNP_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGkgdGhlcmUsDQoNCkkgYW0gY3VycmVudGx5IGludm9sdmVkIGluIGEgcHJvamVjdCBvbiBkZXNp
Z25pbmcgYSBQeXRob24gcHJvZ3JhbSBmb3IgTFRUbmcgdHJhY2UgZGF0YSBhbmFseXNpcyBvbmxp
bmUuIFRoZSBmb2xsb3dpbmcgZmlndXJlIGlsbHVzdHJhdGVzIHRoZSBwcm9ncmFtIHdpdGggYSBs
aXZlIHRyYWNlIGRhdGEgcmVhZGVyIHVzaW5nIGJhYmVsdHJhY2UyIFB5dGhvbiBiaW5kaW5ncyAo
dGhlIHllbGxvdyBib3gpIGNvbm5lY3RlZCB0byB0aGUgTFRUbmcgcmVsYXkgZGFlbW9uLiBUaGUg
cHJvZ3JhbSB3aWxsIHJlYWQgKHN1Y2ggYXMgcGVyaW9kaWNhbGx5KSB0aGUgdHJhY2UgZGF0YSBm
cm9tIHRoZSByZWxheSBkYWVtb24gYW5kIHRoZW4gcHJvY2VzcyB0aGVtIHdoaWxlIHRoZSBMTFRu
ZyBrZWVwcyB0cmFjaW5nLiBUaGUgYWJvdmUgobByZWFkobEgYW5kIKGwcHJvY2Vzc6GxIHBoYXNl
cyByZXBlYXQgaW4gYSBsb29wLg0KDQpbY2lkOjQ0MzVkNGM5LThhNzEtNDY2Ny1iZDI1LTIxZWY2
NDQwMWRmOV0NCg0KQWZ0ZXIgcmVhZGluZyB0aGUgYmFiZWx0cmFjZTIgZG9jdW1lbnRzLCBleGFt
cGxlcywgYW5kIHNvbWUgc291cmNlIGNvZGUsIEkgZm91bmQgdGhlIGx0dG5nLWxpdmUgcGx1Z2lu
IG1heSBiZSBhbiBvcHRpb24gZm9yIHJlYWRpbmcgdHJhY2UgZGF0YSBmcm9tIExUVG5nIHJlbGF5
IGRhZW1vbi4gSG93ZXZlciwgSSBkaWRuJ3QgZmluZCBhbnkgZXhhbXBsZXMgZm9yIHVzaW5nIGx0
dG5nLWxpdmUgcGx1Z2luIHdpdGggYmFiZWx0cmFjZTIgUHl0aG9uIGJpbmRpbmdzLiBBbmQgSSB3
b25kZXIgaWYgdGhlIFB5dGhvbiBiaW5kaW5ncyBzdXBwb3J0IHRoZSBtZW50aW9uZWQgbGl2ZSBM
VFRuZyB0cmFjZSByZWFkaW5nIGZvciBteSBjYXNlLiBJcyBpdCBwb3NzaWJsZSB0byByZWNlaXZl
IGFueSBleGFtcGxlcyBhYm91dCB0aGUgdXNhZ2Ugb2YgYmFiZWx0cmFjZTKhr3MgbGl2ZSByZWFk
aW5nLCBpZiBhbnk/DQoNClRoYW5rIHlvdS4NCg0KQmVzdCwNClJ1b3hpYW5nIExpDQoNCg==

--_000_OS3P286MB05492E608E11B8EF50A47421FF08AOS3P286MB0549JPNP_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Calibri, sans-serif; font-size: 14.6667px; text=
-decoration: none; display: inline !important; color: rgb(33, 33, 33);" cla=
ss=3D"ContentPasted0">Hi there,</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Calibri, sans-serif; font-size: 14.6667px; text=
-decoration: none; display: inline !important; color: rgb(33, 33, 33);" cla=
ss=3D"ContentPasted0"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Calibri, sans-serif; font-size: 14.6667px; text=
-decoration: none; display: inline !important; color: rgb(33, 33, 33);" cla=
ss=3D"ContentPasted0">I am currently involved in a project on designing a P=
ython program for LTTng trace data analysis
 online. The following figure illustrates the program with a live trace dat=
a reader using babeltrace2 Python bindings (the yellow box) connected to th=
e LTTng relay daemon. The program will read&nbsp;<span style=3D"display: in=
line !important; background-color: rgb(255, 255, 255);" class=3D"ContentPas=
ted3">(such
 as periodically)</span> the trace data from the relay daemon and then proc=
ess them while the LLTng keeps tracing. The above =A1=B0read=A1=B1 and =A1=
=B0process=A1=B1 phases repeat in a loop.</span><br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Calibri, sans-serif; font-size: 14.6667px; text=
-decoration: none; display: inline !important; color: rgb(33, 33, 33);" cla=
ss=3D"ContentPasted0"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Calibri, sans-serif; font-size: 14.6667px; text=
-decoration: none; display: inline !important; color: rgb(33, 33, 33);" cla=
ss=3D"ContentPasted0"><img style=3D"max-width:100%" class=3D"ContentPasted1=
 w-1554 h-294" id=3D"imageSelected0" width=3D"475" height=3D"90" size=3D"51=
776" contenttype=3D"image/png" data-outlook-trace=3D"F:1|T:1" src=3D"cid:44=
35d4c9-8a71-4667-bd25-21ef64401df9"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Calibri, sans-serif; font-size: 14.6667px; text=
-decoration: none; display: inline !important; color: rgb(33, 33, 33);" cla=
ss=3D"ContentPasted0"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Calibri, sans-serif; font-size: 14.6667px; text=
-decoration: none; display: inline !important; color: rgb(33, 33, 33);" cla=
ss=3D"ContentPasted0">
<p class=3D"MsoNormal" style=3D"margin:0cm;font-size:11pt;orphans:auto;wido=
ws:auto;text-decoration:none">
<span lang=3D"EN-US" class=3D"ContentPasted2">After reading the babeltrace2=
 documents, examples, and some source code, I found the lttng-live plugin m=
ay be an option for reading trace data from LTTng relay daemon. However, I =
didn't find any examples for using lttng-live
 plugin with babeltrace2 Python bindings. And I wonder if the Python bindin=
gs support the mentioned live LTTng trace reading for my case. Is it possib=
le to receive any examples about the usage of babeltrace2=A1=AFs live readi=
ng, if any?<o:p class=3D"ContentPasted2"></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin:0cm;font-size:11pt;orphans:auto;wido=
ws:auto;text-decoration:none">
<span lang=3D"EN-US"><o:p class=3D"ContentPasted2">&nbsp;</o:p></span><span=
 style=3D"">&nbsp;</span></p>
<p class=3D"MsoNormal" style=3D"margin:0cm;font-size:11pt;orphans:auto;wido=
ws:auto;text-decoration:none">
<span lang=3D"EN-US" class=3D"ContentPasted2">Thank you.<o:p class=3D"Conte=
ntPasted2"></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin:0cm;font-size:11pt;orphans:auto;wido=
ws:auto;text-decoration:none">
<span lang=3D"EN-US"><o:p class=3D"ContentPasted2">&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin:0cm;font-size:11pt;orphans:auto;wido=
ws:auto;text-decoration:none">
<span lang=3D"EN-US" class=3D"ContentPasted2">Best,<o:p class=3D"ContentPas=
ted2"></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin:0cm;font-size:11pt;orphans:auto;wido=
ws:auto;text-decoration:none">
<span lang=3D"EN-US" class=3D"ContentPasted2">Ruoxiang Li</span></p>
<br>
</span></div>
</body>
</html>

--_000_OS3P286MB05492E608E11B8EF50A47421FF08AOS3P286MB0549JPNP_--

--_004_OS3P286MB05492E608E11B8EF50A47421FF08AOS3P286MB0549JPNP_
Content-Type: image/png; name="image.png"
Content-Description: image.png
Content-Disposition: inline; filename="image.png"; size=51776;
	creation-date="Thu, 03 Aug 2023 16:34:39 GMT";
	modification-date="Thu, 03 Aug 2023 16:34:39 GMT"
Content-ID: <4435d4c9-8a71-4667-bd25-21ef64401df9>
Content-Transfer-Encoding: base64

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
oErPcYwJsJRDaExwMPAPCZAACZAACZAACZAACZAACZAACZAACcRFALqVa+bO9cZDODuuRqJUhhKH
QgIkQAIkQAI9RWCudhwwlV94wQWCRCEBEiABEiABEiABEiABEiABEiABEiABEohOAKsQkCy5VvNz
rf2kZGlISApGNkICJEACJJAggbl6Pg0KCULk6SRAAiRAAiRAAiRAAiRAAiRAAiRAAv2DQIiAylV6
5Yd319XTkNBdZNkuCZAACZBAvATm6gkBYwJO5goFUKCQAAmQAAmQAAmQAAmQAAmQAAmQAAmQgI9A
GAMCViFUdScjGhK6ky7bJgESIAES6AqBuXoSDQpdIcdzSIAESIAESIAESIAESIAESIAESIAE+hwB
GA/mz58vZuu/wCrddrsBwcCkIcGQ4JYESIAESCDdCMzVAQUZFBCQeeaMGYyjkG53iuMhARIgARIg
ARIgARIgARIgARIgARJIOoEQqw/QR5WmlBkQ0CGEhgQfB/4lARIgARJIXwJz/UMLaVTAMQZo9hPi
hgRIgARIgARIgARIgARIgARIgARIoNcSMIYDXABWIHikSvdTbkAwY6AhwZDglgRIgARIoDcQmOsf
ZJBRAWVYreBsdcWCs/Xv22XOAf4hARIgARIgARIgARIgARIgARIgARIggR4gAEOBLcZdEcpCGA5Q
XKWpx4wHGIARGhIMCW5JgARIgAR6G4HZOmCkw/xb3VBIgARIgARIgARIgARIgARIgARIgARIoNcS
qNKRv6QJW6S0ERoS0uZWcCAkQAIkQAIJEpit5yMZgYHByGyT4ZYESIAESIAESIAESIAESIAESIAE
SIAEeohAladfYzRAsfeYpyp3SYAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESCBNCfw/
PjPvHONCMO4AAAAASUVORK5CYII=

--_004_OS3P286MB05492E608E11B8EF50A47421FF08AOS3P286MB0549JPNP_--

--===============7807746668537757744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7807746668537757744==--
