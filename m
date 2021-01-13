Return-Path: <SRS0=q6Pr=GQ=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D195CC433E0
	for <lttng-dev@archiver.kernel.org>; Wed, 13 Jan 2021 06:03:45 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07F1723102
	for <lttng-dev@archiver.kernel.org>; Wed, 13 Jan 2021 06:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F1723102
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DFxhY4njwzQPt;
	Wed, 13 Jan 2021 01:03:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1610517823;
	bh=m8LyZdtOxZ62ESo62I7AOqrq4kjDtg0wsINrzaCs6+M=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=DZ9eA74c2SzoqChUAPZCtt3nznuppNVF1qFXK5cJj01EAS/t3FMuwvg4jr8wCTXuY
	 +GYiTIp+YN9ITh4l8ZfMWm8JHwYL/dTrDAuHHqYEsRO3w5gZ2LPxA+ZYGUafL91qYN
	 Z4NmxbvKtOS8hhfyrtykaCG8ENNticAK0Au7cQRRFhv4TfdltV77soZRJshVKojqhn
	 61bZt2tvJAoA0izYr61Xb0JjVlnDNRY6ngT0jtnv/FRFRTZ5vjrCf9WTw4GgyaBKBG
	 fK+Nfw6tWPGSmehPlvjhduO3YYg3RZ/CpDNoPnXzjYCjHrkaiMXQ4v1dTuVBgFh9U1
	 spD0ALEE5yWtw==
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by lists.lttng.org (Postfix) with ESMTPS id 4DFxhV1vJtzQm8
 for <lttng-dev@lists.lttng.org>; Wed, 13 Jan 2021 01:03:37 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRPzNo6nuVVCnLHpyHs5DyltmfuGsX568p3wHnWZTmCcpjnt3McnkdN8XkRqxlS2w2EH7AZNG4KgNLfLWHd3KLuJW83Da3dCxXI2IK6q0ecPdIwxOIIutUYbIH4qn2qytUMq4dVZkW+65xIC6t6QEb4TxcXma/67Np71UJOAdebOLA1TxR9xHqnat4neYppN7ga10WLjYLag38znAWi6gD12h57lhjj9cy7OG42DQ/w7NkTDA6w7TO8G6t+TqY6gIHBMQZ7kGPobrMZ4Awqa3ul9rwq/+0Eg2Ycp6o+gATqRM7wIvSYg5lYhwSSBHmkJDjyu9sMJSiJkrUpm671BEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGuaK7eC4C0i9O9yCikpUF+IXVZbcrQzwDqLVc6aN2c=;
 b=nYZlwiW5ZWBxuoVKbJpnjBg7FjGtR/N4e2ipRK4ZywB+5hO2RapnQvGLHEt/4fRq78E8wJpCI+1CI0Cwey7k1V9sy6QqXa+o6koQR0vSDBLNn+uvxZ+wzlFIvIy+WSsreAvlUBbFWimSJe3fGPwjVwjkz7l++PMCwpUcwnk3G3EqWAC+IpZLZiP9uI0RusWIe0/3PwiMbmn7osMH4xvkMBA9V4hCjqWYG++yxtAJbUGR76r+cxr685RokVJpZCDyEbQpCZbSqJu0asoyym1jYA52U1Sq4qxMaBTXld0ahxx4NgBF6tkKC+BYo5hObppkxtde3Zcv7zbGAyUTIUFfjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB3397.namprd11.prod.outlook.com (2603:10b6:a03:1b::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Wed, 13 Jan
 2021 06:03:34 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::94a4:4e15:ab64:5006]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::94a4:4e15:ab64:5006%5]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 06:03:34 +0000
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
CC: lttng-dev <lttng-dev@lists.lttng.org>
Thread-Topic: =?gb2312?B?u9i4tDogaGVscCBtb2Rwb3N0OiAiX19iYWRfY21weGNoZyI=?=
Thread-Index: AQHW4D7de02FTHE4o0SVdoHpF3AAf6oaFo1DgACjDICAAKuTD4ABBcQAgAE4wQaAB36+nA==
Date: Wed, 13 Jan 2021 06:03:34 +0000
Message-ID: <BYAPR11MB26323F4800A6578AFC536DF0FFA90@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <BYAPR11MB263254ABB57F458031AB33DBFFD50@BYAPR11MB2632.namprd11.prod.outlook.com>
 <BYAPR11MB2632B3DA9B535943CEE08A73FFD00@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20210106150309.GA227614@joraj-alpa>
 <BYAPR11MB2632B5DE22E2561F0B018909FFAF0@BYAPR11MB2632.namprd11.prod.outlook.com>,
 <20210107165408.GC227614@joraj-alpa>,
 <BYAPR11MB2632B7E0BD848485746A80AFFFAE0@BYAPR11MB2632.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB2632B7E0BD848485746A80AFFFAE0@BYAPR11MB2632.namprd11.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4253be44-e2bc-47fe-c02b-08d8b788f5e8
x-ms-traffictypediagnostic: BYAPR11MB3397:
x-microsoft-antispam-prvs: <BYAPR11MB33979195A790EDDBAE7E627AFFA90@BYAPR11MB3397.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NfZYtVSyrwlIgxUmiQM8yEzXlw09eBXdjSmQe+ktxk0JaYFkejwphKE+amhn+SPvS+X1ep+j9AV1TPK+/G45OQwMryEbZZVwpyabf3iKfduDq5uwTUF8zCPYBQeNdMsxRaRV9sCNJblE/qFdE2EJ8WTYsD4GfMUwb6w8eBwi7G5NJowvVNfmqxz1twcrwTAM7IN+0nD7E7FjA2vtdQc56kDBu60gjr4SuCwtMlD7YOlLoZUO1/PFQE6mG1S7GfrS+4R/XTQU5GeJen10gW3pz758SBB5uyg2j5l9mG/uzZGrodKvYo0d+B5shIunPdr80zTs+j8JmE2BbWC3c3GiR/xF1PHhHXpi6NJi4CD6Mxc96ofRJB62PdIQRlzHUq1yTtOvNlaQ2ie6d8dexekR4Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB2632.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(39850400004)(396003)(52536014)(86362001)(6506007)(26005)(71200400001)(33656002)(66446008)(5660300002)(66476007)(64756008)(66556008)(316002)(9686003)(83380400001)(66946007)(55016002)(76116006)(6916009)(478600001)(186003)(8936002)(224303003)(7696005)(91956017)(4326008)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?gb2312?B?YUJ1cVpkaVFyczRzYlc4MFBMZFZDeU5PMzJraG5FMXVNOTVwSExFc3FTTUx5?=
 =?gb2312?B?Tkcya21hRXZhejJySmtic3M4b25SMDM3cS9KZjhXZmRaSm1tKytJYjFSbVkv?=
 =?gb2312?B?RlZtaDU1VU5icEkvQWRINk5pcTJxcVlrMkpkMjBTaTljY1BPSEE5dTRqcVE2?=
 =?gb2312?B?NWd5RndudHRGV05ocVZJUWl5UUFRTkV5dERLbFRIZU5hbWdmU0Vma3UvZHVx?=
 =?gb2312?B?Rk5OZ2Q5WWxKQkQ4UTBHcmlNdkg1WEtjNGI4SDkrTVRHWDd1RVMzVDZKYUs5?=
 =?gb2312?B?QUN5NTdQZU1IcG5HS2pjcDRIdWdPeXdMY0poQUFDejdiY0swbEsvT0N1bkow?=
 =?gb2312?B?dVhCMmV3cDFXVWQzRHlqb1JlQk5HMEZ6OHR6Um5McHNlSkF4RTFMaHB4Y3Yz?=
 =?gb2312?B?aFRGVWRaS0ZhZEJHWEQ2YnBDNnNSbnoyRENZSmt4eTFjZkxXZ1ZFdExoVUJU?=
 =?gb2312?B?b3ZxQzR0SzF1MkdCQWZBU05OUVN4ZUdGUE5lZU01cy9PVlVvdnFabnlrWFBC?=
 =?gb2312?B?MHlDYklndFkwT3ZoR2dtaWhmbHVzaytsODRWdjBoODNnYmxVdjh4aE5HcTBo?=
 =?gb2312?B?RlN5MUJnaTV3eVhLWnRyR3BudGM2bEY5cU4wTUJSMEMxM2ZSZW1FQ0lBRk5n?=
 =?gb2312?B?MVQzN01KTHJDRkQ1K0M1M3RzbFcwcWdzVzgwV3NLSVZVRkhwV3VEVExuS01u?=
 =?gb2312?B?V0tLQWJsT2VnaG5CYWV4dEcwNVlvMkZUQkNtQzhDRmE1MTNEaldFZnRPRHk2?=
 =?gb2312?B?a0lzSHlva2lPOUVBYUZEZlB5ZUpDUXpQRCtQZlJVb252OS9rZGFNVEFpNCtl?=
 =?gb2312?B?NlBYUmV3eHVrcEcwcldjSkFsRU9kT1JuTHRTMTNyajlOSHBwWU1vWTVoM0dp?=
 =?gb2312?B?c1lXUTd0NlIrL3Y5dmpycWJ3dFZqcUZRZ2dVWWlTSzU3bUcwOU91QzlPTkxq?=
 =?gb2312?B?ejBxN0x6ZVA0SDh2OVBVNVZIanRJZXdwRGpDU0hTcXp2b2FiangxeitRMU9q?=
 =?gb2312?B?OGpLMTl6Rkp2em5LaW5hSEJWcXUyNEo5WVRrQUF1ZTcxV2VVdjFZWFhCR004?=
 =?gb2312?B?V29PeFRtRzVseDhseTlFOVNkbXdzQ0F2SmR1Smo2SjVmcjBJMmlELy85N2xC?=
 =?gb2312?B?YTlkdGg0WXh2VTdwOGdtcm9VekZFVFR6enZZQTN6LzJrZXREd3hYSHRrYjdn?=
 =?gb2312?B?UDVlM1pneXZtMXJyU3IvdmpYVHEvV2pUc0RNaUFORjJjd2xrbm9sWW90VVlq?=
 =?gb2312?B?QTcrU1BxZHl5Z3BDTHhycUVkdEI1SkJ1WE1tRGJ6dkJXVThGY0lmMHpqcVVr?=
 =?gb2312?Q?Q9VSneU1zVHZE=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4253be44-e2bc-47fe-c02b-08d8b788f5e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 06:03:34.0732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZfoUdNQ2qr+HlrSB2RsbeUQn2244fqngsMwnQNDq378nkItFOcgp0KPsH5Je+tSosk7uXEi40N6lTm2XW+a338/TwolUNnEbQSJ2yhcheJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3397
Subject: [lttng-dev] =?gb2312?b?u9i4tDogu9i4tDogaGVscCBtb2Rwb3N0OiAiX19i?=
 =?gb2312?b?YWRfY21weGNoZyI=?=
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
From: "Zhang, Qiang via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Kt6K8/sjLOiBKb25hdGhh
biBSYWpvdHRlLUp1bGllbiA8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tPgq3
osvNyrG85DogMjAyMcTqMdTCOMjVIDA6NTQKytW8/sjLOiBaaGFuZywgUWlhbmcKs63LzTogbHR0
bmctZGV2Ctb3zOI6IFJlOiC72Li0OiBoZWxwIG1vZHBvc3Q6ICJfX2JhZF9jbXB4Y2hnIgoKW1Bs
ZWFzZSBub3RlIHRoaXMgZS1tYWlsIGlzIGZyb20gYW4gRVhURVJOQUwgZS1tYWlsIGFkZHJlc3Nd
Cgo+SGksCj4KPk5vdGUKPiAgVGhlIGluaXRpYWwgZW1haWwgd2FzIHNlbnQgdG8gdGhlICJvd25l
ciIgb2YgdGhlIG1haWxpbmcgbGlzdC4gUGxlYXNlCj4gICphbHdheXMqIHNlbmQgZW1haWwgdG8g
dGhlIG1haWxpbmcgbGlzdCBkaXJlY3RseTogbHR0bmctPmRldkBsaXN0cy5sdHRuZy5vcmcgLgo+
IE90aGVyd2lzZSB3ZSB3aWxsIG5vdCBiZSBpbnRlcmVzdGVkIGluIGhlbHBpbmcgeW91IGluIHRo
ZSBmdXR1cmUuCj4KPlNvcnJ5IGZvcmdvdCB0byBhc2sgeW91IHRoZSBmb2xsb3dpbmcuCj4KPldo
YXQgaXMgdGhlIGFybSBDUFUgeW91IGFyZSBjb21waWxpbmcgYWdhaW5zdD8gVGhlIG1vcmUgZGV0
YWlscyB0aGUgPm1vcmUgd2UgY2FuCj5oZWxwIGhlcmUuCj4KPlBsZWFzZSBwcm92aWRlIHRoZSAu
Y29uZmlnIGZpbGUgZm9yIHRoZSBrZXJuZWwgKHZpYSBwYXN0ZWJpbiBwbGVhc2UpIGFuZCA+dGhl
Cgo+IEhlbGxvCj4KPiBBdHRhY2hlZCBpcyB0aGUga2VybmVsIGNvbmZpZ3VyYXRpb24gZmlsZQo+
IGFuZCBjb21waWxlciBjb25maWd1cmF0aW9uIGZpbGUuCj4KPiBic3AgaXMgeGlsaW54LXp5bnEg
KGFybTMyLCBhcm12NyksICB2NS4xMCBrZXJuZWwgaGF2ZSBkZWxldGUKPiAnQ09ORklHX09QVElN
SVpFX0lOTElOSU5HJyAgY29uZmlnIG9wdGlvbi4KPgo+IENoZWVycwoKSGkgCgpDYW4gcmVwZWF0
IHRoaXMgcHJvYmxlbT8KSXMgdGhlIHByb2JsZW0gcmVsYXRlZCB0byBjb21waWxhdGlvbiB0b29s
c6O/CgpDaGVlcnMKCj5jb21waWxlciB1c2VkLiBNYXRoaWV1IERlc25veWVycyAoQ29tcHVESikg
bWlnaHQgaGF2ZSBhIGxlYWQgPnJlZ2FyZGluZyBjbXB4Y2hnCj5hbmQgX19iYWRfY21weGNoZyBs
aW5rZXIgZXJyb3IgdHJpY2sgdXNlZCBieSB0aGUgaW1wbGVtZW50YXRpb24gYW5kID50aGUKPm9w
dGltaXplZCBpbmxpbmluZyBjb25maWcgb3B0aW9uIChDT05GSUdfT1BUSU1JWkVfSU5MSU5JTkcp
Lgo+Cj5UaGVzZSBzaG91bGQgaGVscCB1cyB2YWxpZGF0ZSB0aGlzIGxlYWQuCgo+Cj5DaGVlcnMK
Pgo+T24gVGh1LCBKYW4gMDcsIDIwMjEgYXQgMDE6MjA6NTRBTSArMDAwMCwgWmhhbmcsIFFpYW5n
IHdyb3RlOgo+Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4g
t6K8/sjLOiBKb25hdGhhbiBSYWpvdHRlLUp1bGllbiA8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5A
ZWZmaWNpb3MuY29tPgo+ILeiy83KsbzkOiAyMDIxxOox1MI2yNUgMjM6MDMKPiDK1bz+yMs6IFpo
YW5nLCBRaWFuZwo+ILOty806IGx0dG5nLWRldi1vd25lckBsaXN0cy5sdHRuZy5vcmcKPiDW98zi
OiBSZTogaGVscCBtb2Rwb3N0OiAiX19iYWRfY21weGNoZyIKPgo+IFtQbGVhc2Ugbm90ZSB0aGlz
IGUtbWFpbCBpcyBmcm9tIGFuIEVYVEVSTkFMIGUtbWFpbCBhZGRyZXNzXQo+Cj4gPkhpLAo+ID4K
PiA+V2hhdCB0aGUga2VybmVsIHZlcnNpb24gYXJlIHlvdSBjb21waWxpbmcgYWdhaW5zdD8KPgo+
Cj4gICAga2VybmVsIHZlcnNpb24gNS4xMC4yCj4gICAgbHR0bmctbW9kdWxlcyBtYXN0ZXIgYnJh
bmNoIGNvbW1pdCA6Cj4gICAgNjFlNjMxZTkzZTUxMmI2MzZlYTZkNTI3OTZiY2NlMWM0ODVhNTUx
Ygo+Cj4gICAgIENoZWVycwo+Cj4gPgo+ID5DaGVlcnMKPiA+Cj4gPk9uIFdlZCwgSmFuIDA2LCAy
MDIxIGF0IDA1OjIwOjA2QU0gKzAwMDAsIFpoYW5nLCBRaWFuZyB3cm90ZToKPiA+Cj4gPgo+ID4g
VGhlIGZvbGxvd2luZyBlcnJvciBvY2N1cnJlZCB3aGVuIEkgY29tcGlsZWQgbHR0bmcgbW9kdWxl
cyB1bmRlciBhcm12NyBhcmNoaXRlY3R1cmUKPiA+Cj4gPiBFUlJPUjogbW9kcG9zdDogIl9fYmFk
X2NtcHhjaGciIFsvYnVpbGRhcmVhMS9PbkRlbWFuZF9DSV9CdWlsZF9Xb3JsZC9idWlsZF9kaXIv
MTIyNTE3MjctYnVpbGRfd29ybGQveGlsaW54LXp5bnEtc3RhbmRhcmQtc3RkLU9FL2J1aWxkL3Rt
cC1nbGliYy93b3JrL3hpbGlueF96eW5xLXdycy1saW51eC1nbnVlYWJpL2x0dG5nLW1vZHVsZXMv
Mi4xMi4zK2dpdEFVVE9JTkMrNjFlNjMxZTkzZS1yMC9naXQvc3JjL2x0dG5nLWNvdW50ZXItY2xp
ZW50LXBlcmNwdS02NC1tb2R1bGFyLmtvXSB1bmRlZmluZWQhCj4gPgo+ID4gRVJST1I6IG1vZHBv
c3Q6ICJfX2JhZF9jbXB4Y2hnIiBbL2J1aWxkYXJlYTEvT25EZW1hbmRfQ0lfQnVpbGRfV29ybGQv
YnVpbGRfZGlyLzEyMjUxNzI3LWJ1aWxkX3dvcmxkL3hpbGlueC16eW5xLXN0YW5kYXJkLXN0ZC1P
RS9idWlsZC90bXAtZ2xpYmMvd29yay94aWxpbnhfenlucS13cnMtbGludXgtZ251ZWFiaS9sdHRu
Zy1tb2R1bGVzLzIuMTIuMytnaXRBVVRPSU5DKzYxZTYzMWU5M2UtcjAvZ2l0L3NyYy9sdHRuZy1j
b3VudGVyLWNsaWVudC1wZXJjcHUtMzItbW9kdWxhci5rb10gdW5kZWZpbmVkIQo+ID4KPiA+IEkg
ZmluZCAgdW5kZXIgdGhlIGNvbmRpdGlvbiBvZgo+ID4KPiA+IENPVU5URVJfU0laRV8zMl9CSVQs
ICBjbXB4Y2hnX2xvY2FsICBmdW5jdGlvbiB0cmlnZ2VyIGVycm9yIGluIGNvdW50ZXItYXBpLmgg
ZmlsZS4KPiA+Cj4gPiBpcyBjbXB4Y2hnX2xvY2FsIGlzIHN1cHBvcnQgaW4gYW12Nz8KPgo+IC0t
Cj4gSm9uYXRoYW4gUmFqb3R0ZS1KdWxpZW4KPiBFZmZpY2lPUwoKLS0KSm9uYXRoYW4gUmFqb3R0
ZS1KdWxpZW4KRWZmaWNpT1MKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3Jn
Cmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1k
ZXYK
