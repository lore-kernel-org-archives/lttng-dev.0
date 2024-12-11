Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AEFE77180
	for <lttng-dev@archiver.kernel.org>; Wed, 11 Dec 2024 10:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1733913151;
	bh=ruqt8Kl8kj8bqiaknxZyMgwCcV/T+7OQ8at3/G3dg7k=;
	h=To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=0BubuCkY4fktbbfQ6ZgNfFxa1jMZ3m7OuJ2cQFMgF9hSHW2nysR7SVGHLiqfjEqKI
	 xe+69hAAyJhtOD6x4UQ5S+p+UH2QzT39AnRXYY9T5CcU018j4Z0FS9TdRbyZVSqhou
	 I6Y+JS+8pkN0jOv9HwpmJthNEMo3MftuAf7u5y5WF8IuhjxZMsl8XOl4j4hC5Q7Kf5
	 9Ji5bicjCy3u2ZB40bbxBNZASVthUtDnxN8f0D0SZoIJ//v/kJA7YvjVwmlHru3Y9F
	 FokqHhmNJBnt0IbnGKByRSdFY+h3SY9hfBM7TEvUajLZIDJ5H1Ie4tAwVBkU6Sbrrk
	 VYa+C9xWOPDgg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Y7X3f3djpz1HNQ;
	Wed, 11 Dec 2024 05:32:30 -0500 (EST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20708.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::708])
 by lists.lttng.org (Postfix) with ESMTPS id 4Y7X3c5MPDz1HHt
 for <lttng-dev@lists.lttng.org>; Wed, 11 Dec 2024 05:32:28 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZTd3qzi5LXGJZf+dvWjUtfEi+nBpno1mVQ/7DPhnIAmswtjsE/MBnfR4FVGknX3aYJXCsM0Z0gCswxuNtMMH82lY/uE/LhDSdfTK6gR9l/q+LnBCJfnRaFSbvamqhF9ERw4ne5yvWxbLJrINpPL8HQUKeIfPZAnw97aY18p8K50Tm/9SwrrSsUurTeMlYYq75ot2oxU8HyFGvWrlmkCglvFDYtki/Ya+DNNcOD8XebArMusjB7mgC7P+YANGdraNnK7Sh7lcb3qat1YTeVMsTszT5lk7c1/GLIqz8qxcNBzAh+lAtb5MKL0SUKlbX6MFwWyL+WsGbFUhc6kIAf8pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruqt8Kl8kj8bqiaknxZyMgwCcV/T+7OQ8at3/G3dg7k=;
 b=IC8YzZzjBGrhgVGC1uRmZTkT3CwobjHfj9UfthHjueDUPqNzRr4aUulndC7e6jDC6pqYss41RN9cs1PwjRgE0dikxVF17aISqp/r1lLZ7x3k5ebitJKEAieG0Gdtt36O0aH7K5rVhaEmyogbfHTeH9gql/ZbjRQAm1qxcACbqV/vCQ749u5/TY7bIBGMOydmKUSxLPDOznUmOHpzHPGPwB8xdK09F/xcLbzvjv7Rk91Rc1IIXxb/eVJglOpHfEyIszkPkYryDl4NXy0Ha7EpkRDpNXFdYDjxLv3Gvl4eIWSaruM9GzxF9vibqPzZk1GTpLkwNuBjSuQHOLMWQ90xZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuka.com; dmarc=pass action=none header.from=kuka.com;
 dkim=pass header.d=kuka.com; arc=none
Received: from VI1PR01MB6845.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:19e::9) by AS1PR01MB9393.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:4d3::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Wed, 11 Dec
 2024 10:32:24 +0000
Received: from VI1PR01MB6845.eurprd01.prod.exchangelabs.com
 ([fe80::f8aa:3597:6578:79e1]) by VI1PR01MB6845.eurprd01.prod.exchangelabs.com
 ([fe80::f8aa:3597:6578:79e1%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 10:32:24 +0000
To: Kienan Stewart <kstewart@efficios.com>,
 =?utf-7?B?Q2hyaXN0b3BoZSBCK0FPay1kYXJk?= <bedard.christophe@gmail.com>
CC: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Subject: AW: [lttng-dev] Record stacktraces at userspace tracing domain
Thread-Topic: [lttng-dev] Record stacktraces at userspace tracing domain
Thread-Index: AQHbRNEpeQNVkoGk6Um/5xrxP32z0bLTdX6AgAxFooCAAQeEVw==
Date: Wed, 11 Dec 2024 10:32:24 +0000
Message-ID: <VI1PR01MB684540CF33FFE72F69417E62823E2@VI1PR01MB6845.eurprd01.prod.exchangelabs.com>
References: <VI1PR01MB6845D1C81221547CEC94B3A782352@VI1PR01MB6845.eurprd01.prod.exchangelabs.com>
 <CAAS9dobC0wERGMQf9CLjhYY4ay_zSdAMAE9qxBezLtH-kL_1NQ@mail.gmail.com>
 <7f722802-752f-4cf5-ad2f-cb60264d8091@efficios.com>
In-Reply-To: <7f722802-752f-4cf5-ad2f-cb60264d8091@efficios.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1b46921f-d37c-4222-b9ef-5dad63b5080a_Enabled=True;
 MSIP_Label_1b46921f-d37c-4222-b9ef-5dad63b5080a_SiteId=5a5c4bcf-d285-44af-8f19-ca72d454f6f7;
 MSIP_Label_1b46921f-d37c-4222-b9ef-5dad63b5080a_SetDate=2024-12-11T10:32:23.283Z;
 MSIP_Label_1b46921f-d37c-4222-b9ef-5dad63b5080a_Name=Internal;
 MSIP_Label_1b46921f-d37c-4222-b9ef-5dad63b5080a_ContentBits=0;
 MSIP_Label_1b46921f-d37c-4222-b9ef-5dad63b5080a_Method=Standard; 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR01MB6845:EE_|AS1PR01MB9393:EE_
x-ms-office365-filtering-correlation-id: ab9a3ce6-3a6f-45ff-1832-08dd19cf1a1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-7?B?ZzQwdU5xRUIrLVpIR1F6TFBlbTRxZGp2STdGVWNZd3dNa1JDaDZTcDkwM2dq?=
 =?utf-7?B?TlJvVDlVaGY4NDA3T0RVUkxqRHJyQ3FYOTQwMnFMb0FZeUw2QWRPUzlHa0NX?=
 =?utf-7?B?dEMvVHZYRzFnVUZja211b0JxaEtBTXVKY0oyVWhTWlhpMUQ4YWlIY0s5WUxl?=
 =?utf-7?B?eFY1Vk1Va2R1OWxFdnp3UnRCZXo2djFuNDNiRHFEVFZzNnQvMzRETnlMS3hz?=
 =?utf-7?B?RlcydjllN1hZbmRHVjFxWVA3Ky1IZlM5YVd6VGx2aUlXWGFIN2ZQKy1PMFVW?=
 =?utf-7?B?b0Z2M0xMbnZPWU1Pb0FhMVBOekMyL3FNTVk5dWpENFR1UzFDL2tPNEkxaEZ1?=
 =?utf-7?B?QllQVUlmQlExQ3ozT2pabTFYVW9LZUtrcHV1bFhLNnI0cm1acmM5M0Mwekpv?=
 =?utf-7?B?R3NEZjByT04zLystd1dCeVRKMkVCcUh5RVJBa0lQaUdrcnJjY2U5eHJncHFO?=
 =?utf-7?B?VE42YzNaT1FlNUdRVllMUllRdDdaaXMvdVgvSWdjcDhMNjdxQXRQdWM0Rkh1?=
 =?utf-7?B?Mzd4T2hpbDl0bnd6ZWNCc0J6L3FobWpmcWNZWjVxQ05sejNGMnMzZVlIdjFt?=
 =?utf-7?B?TkI2ZURvaDg5ZFdodWwyN1FIcDBXbXN2VGw1OFdqWkkyZFR0SktNVVVpRUc3?=
 =?utf-7?B?ZlM2VFVxWEVZUFoxL0V2SzZXODR3ME1BZ2pGN3pvNE5xbkRyUVYzUVNZTkxo?=
 =?utf-7?B?WmVwSmM0b3cvUTNDU1l2ZXZ0Q05xWGdzQjFiaktkVUgwajJVSHFVb0pXMngv?=
 =?utf-7?B?MzhFQzVYRmlZc08xbFhFOFJoa05WRG8zSFpiZFdDYVZoeXIyVzVjYistcGVt?=
 =?utf-7?B?QXJ6WncxUVB5cmJaTXo1TENRVGs5VVRZRnZnSUlzelBPdHBTRGY5WWw3U2Yy?=
 =?utf-7?B?a2JmcFRMSzZ3ZW55MGhvQmtzRW1jZjMzSkQwdFBJN1U3WXI0NVFsSjlsR0Nx?=
 =?utf-7?B?TXdCbUxZSzFRTU1TSG1Ia293bzhGYTNSL3BER3dKSmxFaTBYd3NqMUZEZ0p3?=
 =?utf-7?B?UystOGJQeTZIMUZHck1SWUl6WnFOQkswbUJqT2FYMHBUOTdDL1IrLWlqY2s=?=
 =?utf-7?B?SWorLXhFZmhraDV4akFYRzVZandEWTV1TVF5OFAxN1NYdkV4b3hnNWhxUHpy?=
 =?utf-7?B?R09UOVA5aXpFbWxIY1VyMjIyRFpncWs3bERtWDd1d1FRRG1EM053VnZKQkdK?=
 =?utf-7?B?Y3RiVlNveWM2cnJqT2w5WistcmhGUzhsQlZyQ3pWNWVwQ1BMR1hmUUZQb3dj?=
 =?utf-7?B?NzkrLVVoNldmMVFNbjM2MDV6N1ZGUnBqWE42SUs2Z2ZUT2JkcFlJbCstRXdS?=
 =?utf-7?B?M1hQTDhoVkFOaistUklnKy1CUVFMY3Z5SXV0Y2J5V0tWQ3hEN3dtTWdxT29l?=
 =?utf-7?B?Y3NJYUtFdVdrdk5ERjNnR1hac3R5Ky1tdlRJeEJKaTZGN1VvNFlSaDdaYmsx?=
 =?utf-7?B?dTBXRVpaNWN4N21lZWN0MTM2cEZDWmdPYUJhYmM4RnZwVE1pRDNuUUFVU3kz?=
 =?utf-7?B?WkJ5M0kxci9LZVZ5cVp5Ky1ISlJ5TXUxTlF0SE85SzdIbkpmaXhzTFJydE1p?=
 =?utf-7?B?alZSbHdLbWhnM2ZGY3g0bzZSVmsvSG4rLTQySm5EZ1RBeFYxaEVZalAzNUJT?=
 =?utf-7?B?SjE3MnhMbS9XWFhEWDVnd0VBRnc3V2l2dG1yRXM5OFVSY2pZZmo3MExoOERW?=
 =?utf-7?B?My9VQzFCNDRGWSstMU9FZUhSZDZIc3N1VGtxVmpJZXBJdHAzY1RORDN2MmU3?=
 =?utf-7?B?RCstUjh4LzVIWWxleXpDVjRBKy1Oa2VheC85Q1VTKy1HdDR1Ky01V3F4RFRs?=
 =?utf-7?B?MlVTM0JPWUtvMjBOVVJPWElOc3RUSTJtVXVrMXhjTjdvN29RU1gyYXMzbml0?=
 =?utf-7?B?ZmdzMlBGa0E2dWVNQWo1MmxGWW9HRWcwbS9YM0lObnM2WFIvNFEzaDJBMVh3?=
 =?utf-7?B?OHVOcldpbTgwS1hBK0FEMEFQUS0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR01MB6845.eurprd01.prod.exchangelabs.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?d0ZEbFhpNlE0ZzFhWm1QU3cwU0RVSFN6aTJIUWo4WFJBWG1mdEtvNystSXVN?=
 =?utf-7?B?L20vd3FkdFN6d0QyRzMwKy13aXVPS1lMZ0FzSVhFNWVLemF6S25QQkpUZHpH?=
 =?utf-7?B?QXVDdTAxYmNVOTNXd3R2aFFVejRwMUZhOTd5SmthTjVybGJ6bnpiWkQ0Ykp5?=
 =?utf-7?B?Y2NYUkh0QWVXS1BlSnVXMGRINEFNUk9kZjJJM0NtMjhHR0Vva09PWWh4a1da?=
 =?utf-7?B?TEdXc1BQbmlXV25iOTB1T0hPcmp2akJHUVRQOHpMb0VNeCstSVFFRUdpQzNl?=
 =?utf-7?B?MExRNW5OeGM5MmVpMmlhbmw2Nm9nQ05POFJQR01SM1JXejdXN1djUW1veElC?=
 =?utf-7?B?SU9oYWwxZTV0YVkzc01Ydk1qUlVOajM1M3RuKy1Bb0o2VUVnMHJ5WEdHZzc=?=
 =?utf-7?B?NCstY2hadnFxNXdLVENnaVJnRDVHZDh4S1k0OSstR2NKUVlSdTh5ek0rLWlT?=
 =?utf-7?B?anZRQ2tMR3pUS0ZtbkFXVnp5bzdVL09MRHJreHBFZk9jN1BMQWtiMmlTdFF0?=
 =?utf-7?B?ek5jOVI0VE1wTnlwejRVNlhUOHkyVmFQRDZyMXNNQ0hCd0Z2OVI5ZkhXUE91?=
 =?utf-7?B?alc4NDV4M28yeHp2Ky13eXpYNHZybnFsVzZVNGdlM1h3SVRMQ3diNHVyZElv?=
 =?utf-7?B?WDRzNUQxdFB4YzlLV1JGVDJWeDFleGdoMnJzUDRjbFh3QmhKSjRNb0E1di9E?=
 =?utf-7?B?bmlFSHQrLW55cVNuRWhPSU5JVkJMemJzNEZ4RjFyaW1ZYThBN1U4NHdzMHcw?=
 =?utf-7?B?aEJtS0RlQWVqQ2h3SU41MW5ySzFiNG1oQ1p3ZGdmZzZjNTlUQ0JSamV6RmNK?=
 =?utf-7?B?Ky1telZIaDNtdDZUSGYybXc4YXBIZ2lHVTlVYjF5RmlmTXVYUlRIR3Z5OUp0?=
 =?utf-7?B?bnl4ZzYxQWt4TDgwUGcveGc5V3h2ODJuTVpEUmI5QXZlSnVZbzlmc1Vkdm1K?=
 =?utf-7?B?ejl5cjNRVm9zQ0dnamlJdzR0M3lhTGY4b0RoaFUxWHNJZzNYMzZVbkxuZjdR?=
 =?utf-7?B?QkNHcTM2N21aR3dzVFdDTVZ3bmRmTEt5aThhNUNBdS90NGZldFVITHNGVDdn?=
 =?utf-7?B?U2w5NU9HRWo3Nk4vS0IrLUMydHd0RWIvTk9nQlBlOTNsRDA3NnMzVnpxbjFM?=
 =?utf-7?B?bjgrLW13YmdXZEc3NnV1bzdtcnQrLUE4Q2Z4Qy9YVXpuYzkvUTl5RnlkNjhz?=
 =?utf-7?B?bFE1MGlLeExqTTR2QmgwOVY3anNzY3ZkUTBSMDUrLUVuM0Z2azNvdFBWbmt0?=
 =?utf-7?B?dERkZHZPV0xjbUJTazNveS9naXdKczhyQzZEeistZk9qTE16UC9uU0I4ZGRX?=
 =?utf-7?B?ZTRHYTJKUVgrLVN3QkN0aFkyM0dPeGdUMTh6VjR4Z2k0dTZTNkpxZzRFS3hy?=
 =?utf-7?B?YThucU52Vk9UbnRRZkRTYXNUaUw1ZmxFOWxoZlJpQnNReDJ4cHg4aXZFKy1w?=
 =?utf-7?B?OUZsS0dUN0dZRU0rLWZxRnVyTUJUMUZyajk0cTc2WVNJOXUyKy1pZlYza08v?=
 =?utf-7?B?TmJhZVAvUXgxUTZFZDNEdUNId1JRWmdBeDZXSWhTUHRHSjI0eklGME1SSnMz?=
 =?utf-7?B?NlZhWi9EQzNGQlJXZEtBTk9VTW5vOVRKT3JOOUpBYWQ5OEhFRCstUDFFMkM=?=
 =?utf-7?B?Ky1TS0Qwa2pidG1oazk3RnZ4SXl6Y3psTzQrLTYybzdCR2lRNElrN3RrZGlS?=
 =?utf-7?B?Umk2WVhjT0FtOEUwVVgzWDljRUxZalJ5VDRvYlY3NmZrZHBtckNXZE02V0dn?=
 =?utf-7?B?dmVHOWs0dUpTTmNQcWMxN1RhbWtMYWEwUXFYbXF0MjFnV1kzSXJnYistY1RV?=
 =?utf-7?B?bnBUeUFDZHVoY3JjeS9XY3pDTU81Ky1ZV1VGRTNxbTBZN0tzREo2cXN6ZENM?=
 =?utf-7?B?U3d2UzdkZm12d29Hc0JhaWhkRUZINHlzUzRXV0Vzd1dZSnRDbDhHMU0vbG4v?=
 =?utf-7?B?UDF4bWxWS2dNNWJuMjdwd1BWKy1uRjhNTlJCNkVodVlxUm1rYURhbmpBZ3ph?=
 =?utf-7?B?bThweDg3b2VGaW5rUkFxQzlod3IwSmdrWnE0WWhaUC9pNExYWUR4Z3pmUFBo?=
 =?utf-7?B?UmdRazYzOXk3MWs1Q0g1OHNtSUF6MkgrLXRzcUlmVTBuU1hlNkQrLW5xZUpm?=
 =?utf-7?B?c3daVTJqMUNLMEJ0RUdNZVJWUjAzMTV4SEIvUW42cElGTEhjNCstY0NnNFVL?=
 =?utf-7?B?cnYxRFRhZUpyWg==?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kuka.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR01MB6845.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9a3ce6-3a6f-45ff-1832-08dd19cf1a1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 10:32:24.3325 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a5c4bcf-d285-44af-8f19-ca72d454f6f7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T8k6aW2ixUu30QBOlLSzvgUtAEX/cfQJh7SQbDcdyz1/D6ALFLWJmw18138MVWV9H30ezOCubEPnR9NbOdd4vDtx0YuIhUY0jrzpJkaSDFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR01MB9393
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
From: Alexander Krabler via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Alexander Krabler <Alexander.Krabler@kuka.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Christophe and Kienan,


Internal
On 12/2/24 4:17 PM, Christophe B+AOk-dard via lttng-dev wrote:
+AD4- I did the same thing a while ago, i.e., trigger tracepoints on
+AD4- malloc/free/etc. using liblttng-ust-libc-wrapper and collect userspac=
e
+AD4- callstack information (so that the indirect calls to malloc/free can =
be
+AD4- removed from an application).
+AD4- ...
Thank you for the information and links+ACE-
I have looked into it, seems promising.


On 12/10/24 11:41 AM, Kienan Stewart via lttng-dev wrote:
+AD4- Depending on the type of information you require, it could be possibl=
e
+AD4- to use the instruction-pointer (ip) context+AFs-1+AF0-, the statedump=
+AFs-2+AF0- and/or
+AD4- lttng-ust-dl+AFs-3+AF0- for base addresses, and the symbol table in-o=
rder to
+AD4- resolve ip -+AD4- symbol name in the offline analysis phase with the =
help of
+AD4- babeltrace's debug-info plugin+AFs-4+AF0-. While a bit more work for =
the
+AD4- analysis, this process reduces the impact of the tracing on the progr=
am
+AD4- at run-time.
Thanks for the hints.
This would be possible, but that would give me only the instruction pointer=
 of the top-level stack frame.
If malloc and free calls are wrapped inside of functions (e.g. think about =
std::string, std::unique/shared+AF8-ptr for C+-+-),
I would only see that it's called from that specific type.
But, for me, it's important to see the context, too, where the string/smart=
 pointer is used.
Therefore I want to record the instruction pointer of every stackframe (or =
at least the top N ones in order to be able to locate the +ACI-problem+ACI-=
).

As stacktraces are only wanted/needed for specific events, I also consider =
adding new tracepoints
like lttng+AF8-ust+AF8-libc:malloc+AF8-stacktrace to lttng-ust-libc-wrapper=
 directly
recording the desired information into the trace buffer as an alternative s=
olution.

Best regards,
Alexander
