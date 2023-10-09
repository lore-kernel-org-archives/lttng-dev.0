Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AF6E95A91
	for <lttng-dev@archiver.kernel.org>; Mon,  9 Oct 2023 11:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1696849276;
	bh=AZ80DGIOUjMv987CbYEmn+681NIjhH/zkW9BOe7w+U8=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=rs8iz1+ol5GjyQMSzVAav9yHcxeAEGgExUW4mpC10SgTmzDa0/rSM8LXPh8CRuenu
	 CLset+RDPAhamqkaVlQMQEePsM0Gc0xW4KWIIbzoZrKcv4rzRNmijqLh5HwtxrPqUv
	 4X1qwNCVsxCxu3Y1IkM+fiKtIomOML57z/1aGe6/me2LsMXvgeunlytHFwNor5bEKi
	 RJMIouH2cQBS42BDJOASQ99V7Z0L3kkb9gnJj7eqf7W1JZmRf9rgVLr33a5FGyL8gl
	 cx3+aGU0W+G71h+UeU2R5/utUI2drOGT7SJvmWA3cNxrJav1WV6XZcwCv0WGcLSpFU
	 4exp+Gk84OKiA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4S3x0q3ZVgz2vnd;
	Mon,  9 Oct 2023 07:01:15 -0400 (EDT)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2122.outbound.protection.outlook.com [40.107.94.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4S3x0p0hMMz2vnb
 for <lttng-dev@lists.lttng.org>; Mon,  9 Oct 2023 07:01:13 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjXoXRtqyo0U9BaYeNsZPNrTe0lKssnadYW+FmTL6vTI+1gPa+EBPg3Qw4kphwIiLf50Smd0secSE/hoaWpkiU/PomW2QuU4L4AZB2BPKt1vb8wg304sTKBofXtJyXAgejeaELbTeYERg9cqb/tOZpEr4cTQoFwgI/K6gA8+yvcD4O6f9e+5ImIfuNZJwMmQ0KkErDCBcpvQIcDm+8hoV60ambQKJ1dFDPHyOufbhTqcyE/vH+l9n08OvL1Hx94QkGiL/rKdE4i0kvobRH3yz1SH43Cbe70zj3bcXenYvF2QVrOoRP9HTerX489zA+dFMN0c3lih4Pbh7nkXVef3Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJDabKzNGStOYujH2qIR05aETcmBVpTNgBjflntgUUw=;
 b=nPwDeYQiAhXfZfBTSElCH010Fo0jAwHA/ZN5fognvHV7Nr6YX54m6FXHPOCPaVJxrY6KuuIHKXBgSBdRwzRDe36tWQlvRVPyBaFDG5BG8rN14N6vYEICAYFqVILAaUBS+3mjvG7na/RTIct079DsijYp6gOvemj56dqfXuP75YfBJuGmjCUiPkAsrdIcKIEmYzmoMnlYoYNdb6GI4L4WLp3xJNomro3OgUVghZXj/zL0EaG2A8ruEPCvVHJq7m1rLA1MF3pByYm6mBFRKxQ07aKSXyAdN89+GpQliyxB5pngPpEEPUWME5SHL97Xwvpf6VelqRLWyOGZCFn1/+j8xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cognex.com; dmarc=pass action=none header.from=cognex.com;
 dkim=pass header.d=cognex.com; arc=none
Received: from SN6PR06MB4269.namprd06.prod.outlook.com (2603:10b6:805:ab::11)
 by SA0PR06MB7004.namprd06.prod.outlook.com (2603:10b6:806:bd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Mon, 9 Oct
 2023 10:29:39 +0000
Received: from SN6PR06MB4269.namprd06.prod.outlook.com
 ([fe80::1f01:53bc:91e0:139d]) by SN6PR06MB4269.namprd06.prod.outlook.com
 ([fe80::1f01:53bc:91e0:139d%6]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 10:29:38 +0000
To: Kienan Stewart <kstewart@efficios.com>, "lttng-dev@lists.lttng.org"
 <lttng-dev@lists.lttng.org>
Thread-Topic: [EXTERNAL] Re: [lttng-dev] LTTng enable-event performance issue
 during active session
Thread-Index: AdnwcCSxJSe1P8jUTaaU3erE67EsEwHZ7XMAACYGfIAAim7KwA==
Date: Mon, 9 Oct 2023 10:29:38 +0000
Message-ID: <SN6PR06MB42691D97E72B2F5835A5D76991CEA@SN6PR06MB4269.namprd06.prod.outlook.com>
References: <SN6PR06MB426922F9DBACE81D0C6B66A591C3A@SN6PR06MB4269.namprd06.prod.outlook.com>
 <f0437833-964c-4aee-a52b-e79fd89540fc@efficios.com>
 <c24c1489-c3a4-46e8-b91f-9da212081065@efficios.com>
In-Reply-To: <c24c1489-c3a4-46e8-b91f-9da212081065@efficios.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8yMjBiMDVjOC0yNTM3LTQxZTgtYWZmNC1mYjZjNTIyZjk2?=
 =?utf-8?B?MjRfQWN0aW9uSWQ9NTNkMzQ0ZmEtZDM1Yi00YTgzLWI4YzItNmQ3MjQ0ODNj?=
 =?utf-8?B?ZWNhO01TSVBfTGFiZWxfMjIwYjA1YzgtMjUzNy00MWU4LWFmZjQtZmI2YzUy?=
 =?utf-8?B?MmY5NjI0X0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8yMjBiMDVjOC0yNTM3?=
 =?utf-8?B?LTQxZTgtYWZmNC1mYjZjNTIyZjk2MjRfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMjIwYjA1YzgtMjUzNy00MWU4LWFmZjQtZmI2YzUyMmY5NjI0X01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsXzIyMGIwNWM4LTI1MzctNDFlOC1hZmY0?=
 =?utf-8?B?LWZiNmM1MjJmOTYyNF9OYW1lPUNvZ25leCDigJMgR2VuZXJhbDtNU0lQX0xh?=
 =?utf-8?B?YmVsXzIyMGIwNWM4LTI1MzctNDFlOC1hZmY0LWZiNmM1MjJmOTYyNF9TZXRE?=
 =?utf-8?B?YXRlPTIwMjMtMTAtMDlUMTA6MTY6MzZaO01TSVBfTGFiZWxfMjIwYjA1Yzgt?=
 =?utf-8?B?MjUzNy00MWU4LWFmZjQtZmI2YzUyMmY5NjI0X1NpdGVJZD1jMTIwMDdhNC04?=
 =?utf-8?Q?82b-4381-b05a-b783431570c7;?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR06MB4269:EE_|SA0PR06MB7004:EE_
x-ms-office365-filtering-correlation-id: 2832032f-64d5-4f4e-9f78-08dbc8b2a442
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jZVimIU3arcaeVx0ufhYPKJfmXpalOtiyz77R+Yj3KpguYh7jyk/pLfWfN2vu14AE60oJAY5ELBNWF89xFQVSma2GVbOgbHkfOZWf483oRbfmzBAaeOGIrhKyTJvi7eMpZLQvJL76z6HSUzHzCVf/IBq4GN1PdzqfbML0oMczsx+A5yRj/pm0j4eJGQyVXPjKKiUbupC8M+yp5XXIKJVVZBi8VgVYcUI83KMA17keCUy/bFEtADxDeuC0VDRzFQF0P275+JySqS0CH7aNT+LmFY7uWEo//GE34BVGYOsAtVuykyBs4dtH8WrH686KkveD67AP2khxpERL/3jjSRspeOfy0r+7tTZjTEcNyy9Ssj74rWWsu5bFBSFSH2ukz54iWjqyTLUhN2iVdlekQN643Ms2JmVUyXevdBPlplvG98drEGIYkAh4M6cClz88QaFfhUkm9IvuZI/P+FDN/bcp8krf7lCGlx058XDmkUbD5HC7gTgjhdv4ueMLDdT66nPL5i0A2JJaUBHyzXjz1Btpoqpp9q2XzFX4g8hXoaDqTno+idj3D21Q+fiU6KRbUWG7DWekc1X8P7j/Udx+zpDTpxfrytzhvvI3A7NZHhRFtE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR06MB4269.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(366004)(39850400004)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(9686003)(53546011)(6506007)(478600001)(7696005)(966005)(26005)(83380400001)(2906002)(5660300002)(66946007)(110136005)(76116006)(64756008)(66446008)(66556008)(66476007)(8676002)(8936002)(52536014)(316002)(41300700001)(38100700002)(38070700005)(122000001)(33656002)(55016003)(86362001)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0Z4bzBsSHV3d2ZJWUZPZkZPWVk4SjBkc1VPVmpDNzUvNjVZamkvM1dBSnl6?=
 =?utf-8?B?dHozNU05R2lpWkluOTljeS9Qb3RZaEtVbXJDajl3NWJBUDB3Y3dSQ0ZNUHRv?=
 =?utf-8?B?aEZjSDB1V1gzSlVYRkRTbk5rcXA0cHE1L0JtejBPNEY0Y1dzTXhBQ3g4dVl4?=
 =?utf-8?B?eGhIWE1XZ2pkZ0VKcmV2T09ScGlVUXBIckIvQTl3K1F2NXc0dDhJbWJBT29h?=
 =?utf-8?B?NC9sL0VicE5JTTRtYmducGZPaG1nRnZwZjliVmFZa2tNZ3VMWlhUbFY1Z0Nv?=
 =?utf-8?B?QWhWQW1OUVArZHVEMUtjQmlRS1FTQWh5SmVtVGhzelF1dFp5eU9kS3FVa0Vm?=
 =?utf-8?B?bS9UYjMrenh5US9ucjN4NWx6Vjc2N2lMdlpObmMwK2hjU2NSZlpnMnFUUDN5?=
 =?utf-8?B?WHovY3hLSW0wVC9tVGYzdTF6UzJkb29ObTMxb0VNdnpMWDlxZEZNTi9kdnI0?=
 =?utf-8?B?azR0RytBRXJqNUY2ZG1CQ3VTZUFZR2g5eFYrNy9sY1ZBU2dsaCt6SitrbmVx?=
 =?utf-8?B?WWFXczdZdDhXdy83UVBSV2g2RFJLbFNmY3orNFNpMXNTQWJMYUFVU3o2enB5?=
 =?utf-8?B?ejlJUHdPT2s1K0RkTG1uODlDajFKaHZTNVQvTkJRdUFXMHRFc2lEREI1SFJZ?=
 =?utf-8?B?b3U4QzN6UnhsMUgrR3JtNEtpNnJvbUFpWFpiODFJMmhaWE9LUDdJRzhGN2Fz?=
 =?utf-8?B?dFZtd0NDbHdhbG5KeUFONk8rQzhZOUI1SkJXRVZRbnNIQU01aEE1SlZlMkNK?=
 =?utf-8?B?bHUvNGNUb2pDT3JlMGZJWGxPT0pmNGFHMVZmT2NDOWZOZWZ1L2FaYlJkbXBr?=
 =?utf-8?B?U2tISFFuWHI1Q2toZTlnZENhR2VQOGpjam1SMDdDbkRCckEzMklRQWdvdkYw?=
 =?utf-8?B?cThveDN4S3dzY3M1ZjhDaXVIWHVHdnR0WFlabll3YzIvZjAra2dXdWg1V0lz?=
 =?utf-8?B?cGhmUjlUcmJ5eG1wQ2oyMVVZTVdBTC9jY1VwTFdyTVFPRVRILy9KeWpXTnli?=
 =?utf-8?B?NjZEZHZZYXprV1FGalBNSWtTSUdJWmI2U0xjK2g2QUcvajVZVlZCL2pEeVM2?=
 =?utf-8?B?Mkk0dW95Z2Ftck55WE41NmI2c21KY3F2OEFEY3F0aXQzUjJsVXVmTitlVkVz?=
 =?utf-8?B?eVFkVUNIWjQ1OGhKd1JNMEdXS3pTQ3NxME9tOW5hdmhIbDdmRjVvWHJSb282?=
 =?utf-8?B?NUo0Q3dBR0NEcGhsdDZxeGsraUl3eWZHcWw0VFB5OTVOaXg1WlV3SjdXbkZm?=
 =?utf-8?B?R3VOQ01SNUhwNytrNm9nZnl3V2hBaGpMSXNyZHhzSk92OW4zbmNrSlpnUUNH?=
 =?utf-8?B?bkJYZ3FXbkxMSU9CdVN4M2RXQnlnSU9lR3lia0NEWWZmTFNVa0pIYityNGZH?=
 =?utf-8?B?Z3NyU3JLSWdtaWpOQmNEa3NrRE8yZWlScmdlR2hYRlFXOG4wVVR0TUxVUjQv?=
 =?utf-8?B?RzZSL3ZjcUpqUHRYSjdyR3VoTTdORkZUVVVheHZFMUk2OHAxNTV1OW9KTzAy?=
 =?utf-8?B?d1RCNkV2Z3BWZHNMNUMvY1dqdlIzVStVeHdaVXErckNLTk1tc1IwZDdOQWNW?=
 =?utf-8?B?ZWtYaGtPS1VEdXhmQnpwQ0RHK0JEYXBKWlFPdStmb2NtU2FCT1ErUFlwazJS?=
 =?utf-8?B?c09nRlVqaFBRdFllUU1nSTg4dVpFNkIrSFBxU0c2UVVuT1hvZE8raUE5ZW50?=
 =?utf-8?B?NlB6bXZ2a3psekVCT3BuUm5OM0tyVnV1bHc5K2p1eGhPLytPZ1J2L3h5MEVs?=
 =?utf-8?B?cyt2U29UbXNFQmlWZEd3TnE4WXNsUDJwdTArRCtzd2pKVzB0Ny9GczRhVlRa?=
 =?utf-8?B?SWtEcnNWQlIrSTg5QisxRU5oelVBR3A2cUlCaU5FcFZJU2RqTUpYZElaUHpP?=
 =?utf-8?B?VGI4WWJZb3UyWURvdGhNMjhQTVk0bi9qdkRaQ1ordDdaMzA1R2NDTkVHZFNG?=
 =?utf-8?B?WEZmcUpEVlhVNDN3cWdDdzZlbTkxMFZ4QkhoMkpWN0dhamVmU21rd043SVcv?=
 =?utf-8?B?T3lJTHQ0TDBONzNxdkorQm9yYWw5TWlTWktOZGllUWNtMVRwMDhsbFBIUk5s?=
 =?utf-8?B?c0hyZm9iUUg4ZTIxcmg3MFN1dzRZZVZYRy9ESkhVUDZNVFRPUEVUdFFHQzJK?=
 =?utf-8?Q?UwIsdAnR7n8q0aJrhTXPKW+6/?=
MIME-Version: 1.0
X-OriginatorOrg: cognex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR06MB4269.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2832032f-64d5-4f4e-9f78-08dbc8b2a442
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 10:29:38.8529 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c12007a4-882b-4381-b05a-b783431570c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m80UFLrCTSrHnZk0bhFyMlcYgTY6e0ObwzyY77H3cibhv1kVoPJk9nfIXtQ+JCYqR8HuewNYzqvj+j6+vKNKwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR06MB7004
Subject: Re: [lttng-dev] [EXTERNAL] Re: LTTng enable-event performance issue
 during active session
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
From: "Kramer, Zach via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Kramer, Zach" <Zach.Kramer@cognex.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGkgS2llbmFuLA0KDQpUaGFuayB5b3UgZm9yIHRoZSB0aG9yb3VnaCBleHBsYW5hdGlvbiBhbmQg
cHJvcG9zZWQgY2hhbmdlc2V0Lg0KDQpNeSB1c2UgY2FzZSB3YXMgdG8gc3luY2hyb25pemUgd2l0
aCBhIHVzZXItY29uZmlndXJhYmxlIHNldCBvZiBldmVudHMgYXQgcnVudGltZSwgd2hpY2ggd2Fz
IGVhc2llc3QgZG9uZSBpbmRpdmlkdWFsbHkuDQpJbiB0aGUgbWVhbnRpbWUgSSB3b3JrZWQgYXJv
dW5kIHRoZSBwZXJmb3JtYW5jZSBoaXQgYnkgZW5zdXJpbmcgYWxsIGF2YWlsYWJsZSBldmVudHMg
aGF2ZSBhbHJlYWR5IGJlZW4gY3JlYXRlZCBvbiB0aGUgc2Vzc2lvbiBiZWZvcmUgc3RhcnRpbmcg
aXQuDQoNCkxvb2tpbmcgZm9yd2FyZCB0byB0aGUgY2hhbmdlc2V0Lg0KDQpUaGFua3MsDQpaYWNo
DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLaWVuYW4gU3Rld2FydCA8a3N0
ZXdhcnRAZWZmaWNpb3MuY29tPiANClNlbnQ6IEZyaWRheSwgNiBPY3RvYmVyIDIwMjMgMTg6MTMN
ClRvOiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnOyBLcmFtZXIsIFphY2ggPFphY2guS3JhbWVy
QGNvZ25leC5jb20+DQpTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbbHR0bmctZGV2XSBMVFRuZyBl
bmFibGUtZXZlbnQgcGVyZm9ybWFuY2UgaXNzdWUgZHVyaW5nIGFjdGl2ZSBzZXNzaW9uDQoNCkhp
IFphY2gsDQoNCnRoZXJlJ3MgYSBwcm9wb3NlZCBjaGFuZ2UgdG8gbHR0bmctdXN0IHdoaWNoIGFk
ZHJlc3NlcyB0aGUgaXNzdWUgeW91IGFyZSBzZWVpbmcsIGJ1dCBpdCBoYXNuJ3QgZmluaXNoZWQg
Y2xlYXJpbmcgcmV2aWV3ICYgdGVzdGluZyB5ZXQuDQpodHRwczovL3Jldmlldy5sdHRuZy5vcmcv
Yy9sdHRuZy11c3QvKy8xMTAwNg0KDQp0aGFua3MsDQpraWVuYW4NCg0KT24gMjAyMy0xMC0wNSAx
ODowNCwgS2llbmFuIFN0ZXdhcnQgdmlhIGx0dG5nLWRldiB3cm90ZToNCj4gSGkgWmFjaA0KPg0K
PiBhcG9sb2dpZXMgZm9yIHRoZSBkZWxheSBpbiByZXBseWluZyB0byB5b3VyIHF1ZXN0aW9uLg0K
Pg0KPiBPbiAyMDIzLTA5LTI2IDA4OjI3LCBLcmFtZXIsIFphY2ggdmlhIGx0dG5nLWRldiB3cm90
ZToNCj4+IEhpLA0KPj4NCj4+IEkgYW0gb2JzZXJ2aW5nIGEgcGVyZm9ybWFuY2UgaXNzdWUgd2l0
aCByZWdhcmRzIHRvIGVuYWJsaW5nIGV2ZW50cyANCj4+IHdoaWxlIGEgc2Vzc2lvbiBpcyBhY3Rp
dmUgYW5kIHdhcyB3b25kZXJpbmcgaWYgdGhpcyBpcyBleHBlY3RlZC4NCj4+DQo+PiBMVFRuZyB2
ZXJzaW9uczoNCj4+DQo+PiAgICogbHR0bmctdG9vbHM6IDIuMTMuOQ0KPj4gICAqIGx0dG5nLXVz
dDogMi4xMy42DQo+PiBTdGVwcyB0byByZXByb2R1Y2U6DQo+Pg0KPj4gIDEuIEVuc3VyZSBtYW55
IHVzZXJzcGFjZSB0cmFjZXBvaW50cyBhcmUgYXZhaWxhYmxlIGluIGBsdHRuZyBsaXN0IC11YA0K
Pj4gICAgIGUuZy4gMTAwDQo+PiAgMi4gQ3JlYXRlIGEgbmV3IHNlc3Npb24NCj4+ICAzLiBTdGFy
dCBzZXNzaW9uDQo+PiAgNC4gRW5hYmxlIG5ldyBldmVudHMgb24gc2Vzc2lvbg0KPj4NCj4+IFRo
ZSB0aW1lIGl0IHRha2VzIHRvIGVuYWJsZSBlYWNoIG5ldyBldmVudCBoYXMgaW5jcmVhc2luZyBj
b3N0IGUuZy4NCj4+DQo+PiAgMS4gRXZlbnQgMTogMW1zDQo+PiAgMi4gRXZlbnQgMTAwOiAxNW1z
DQo+PiAgMy4gRXZlbnQgMTAwMDogMTUwbXMNCj4+ICA0LiDDoGluIHRvdGFsIGFib3V0IDEuNSBt
aW51dGVzIHRvIGVuYWJsZSAxMDAwIGV2ZW50cw0KPj4NCj4+IElmIGVpdGhlcjoNCj4+DQo+PiAg
MS4gTm8gdXNlcnNwYWNlIHRyYWNlcG9pbnRzIGFyZSBhdmFpbGFibGUgIDIuIE9yIHNlc3Npb24g
aXMgbm90IA0KPj4gc3RhcnRlZCB1bnRpbCAvYWZ0ZXIgL3RoZSBldmVudHMgYXJlIGVuYWJsZWQN
Cj4+DQo+PiBUaGVuIHRoZSB0aW1lIGl0IHRha2VzIHRvIGVuYWJsZSBuZXcgZXZlbnRzIGlzIGNv
bnN0YW50IChlLmcuIDFtcykuDQo+Pg0KPj4gQmVsb3cgaXMgYSBiYXNoIHNjcmlwdCBkZW1vbnN0
cmF0aW5nIHRoaXMgYmVoYXZpb3I6DQo+Pg0KPj4gIyBQcmUtcmVxdWlzaXRlOiBoYXZlIG1hbnkg
dXNlcnNwYWNlIHRyYWNlcG9pbnRzIGF2YWlsYWJsZQ0KPj4NCj4+IGx0dG5nIGNyZWF0ZSBmb28N
Cj4+DQo+PiBsdHRuZyBlbmFibGUtY2hhbm5lbCAtdSAtcyBmb28gYmFyDQo+Pg0KPj4gbHR0bmcg
c3RhcnQgZm9vDQo+Pg0KPj4gdG90YWxfdDE9JChkYXRlICslcyUzTik7DQo+Pg0KPj4gZm9yIGkg
aW4gezEuLjEwMH0NCj4+DQo+PiBkbw0KPj4NCj4+ICAgICAgICAgIHQxPSQoZGF0ZSArJXMlM04p
Ow0KPj4NCj4+ICAgICAgICAgIGx0dG5nIGVuYWJsZS1ldmVudCAtdSBsdHRuZ19pdGVyXyRpIC1z
IGZvbyAtYyBiYXIgPiANCj4+IC9kZXYvbnVsbA0KPj4NCj4+ICAgICAgICAgIHQyPSQoZGF0ZSAr
JXMlM04pOw0KPj4NCj4+ICAgICAgICAgIGVjaG8gIkV2ZW50ICMkaSB0b29rICQoKHQyLXQxKSkg
bXMiDQo+Pg0KPj4gZG9uZQ0KPj4NCj4+IHRvdGFsX3QyPSQoZGF0ZSArJXMlM04pOw0KPj4NCj4+
IGVjaG8gIi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0iDQo+Pg0KPj4gZWNobyAiRW5hYmxpbmcgZXZlbnRzIG9uIGFjdGl2ZSBzZXNzaW9uIHRvb2sg
JCgodG90YWxfdDItdG90YWxfdDEpKSBtcyINCj4+DQo+PiBlY2hvICItLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIg0KPj4NCj4+IGx0dG5nIGRlc3Ry
b3kgZm9vDQo+Pg0KPj4gbHR0bmcgY3JlYXRlIGZvbw0KPj4NCj4+IGx0dG5nIGVuYWJsZS1jaGFu
bmVsIC11IC1zIGZvbyBiYXINCj4+DQo+PiB0b3RhbF90MT0kKGRhdGUgKyVzJTNOKTsNCj4+DQo+
PiBmb3IgaSBpbiB7MS4uMTAwfQ0KPj4NCj4+IGRvDQo+Pg0KPj4gICAgICAgICAgdDE9JChkYXRl
ICslcyUzTik7DQo+Pg0KPj4gICAgICAgICAgbHR0bmcgZW5hYmxlLWV2ZW50IC11IGx0dG5nX2l0
ZXJfJGkgLXMgZm9vIC1jIGJhciA+IA0KPj4gL2Rldi9udWxsDQo+Pg0KPj4gICAgICAgICAgdDI9
JChkYXRlICslcyUzTik7DQo+Pg0KPj4gICAgICAgICAgZWNobyAiRXZlbnQgIyRpIHRvb2sgJCgo
dDItdDEpKSBtcyINCj4+DQo+PiBkb25lDQo+Pg0KPj4gdG90YWxfdDI9JChkYXRlICslcyUzTik7
DQo+Pg0KPj4gZWNobyAiLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLSINCj4+DQo+PiBlY2hvICJFbmFibGluZyBldmVudHMgb24gaW5hY3RpdmUgc2Vz
c2lvbiB0b29rICQoKHRvdGFsX3QyLXRvdGFsX3QxKSkgbXMiDQo+Pg0KPj4gZWNobyAiLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSINCj4+DQo+PiBs
dHRuZyBkZXN0cm95IGZvbw0KPj4NCj4+IElzIHRoaXMgcmVwcm9kdWNpYmxlIGZvciB5b3U/IEFu
eSBpbnNpZ2h0IGlzIGFwcHJlY2lhdGVkLg0KPj4NCj4NCj4gSSdtIGFibGUgdG8gcmVwcm9kdWNl
IHdoYXQgeW91J3JlIHNlZWluZywgYW5kIGl0J3Mgbm90IGNvbXBsZXRlbHkgDQo+IHVuZXhwZWN0
ZWQgYmFzZWQgb24gbXkgdW5kZXJzdGFuZGluZyBvZiB0aGUgYXJjaGl0ZWN0dXJlIG9mIGx0dG5n
Lg0KPg0KPiBXaGVuIGEgc2Vzc2lvbiBpcyBhY3RpdmUgYW5kIGFuIGV2ZW50IHJ1bGUgaXMgZW5h
YmxlZC9kaXNhYmxlZCwgdGhlIA0KPiBzZXNzaW9uZCB3aWxsIG5vdGlmeSBlYWNoIG9mIHRoZSBy
ZWdpc3RlcmVkIGFwcGxpY2F0aW9ucyBvZiB0aGUgZXZlbnQgDQo+IHJ1bGUgc3RhdGUgY2hhbmdl
cy4gVGhpcyBjb21tdW5pY2F0aW9uIGlzIGdvaW5nIHRocm91Z2ggZWl0aGVyIHVuaXggb3IgDQo+
IHRjcCBzb2NrZXRzLCBhbmQgdGhhdCBwb3J0aW9uIG9mIHRoZSBwcm90b2NvbCBzZWVtcyB0byBz
dHJ1Z2dsZSB3aXRoIA0KPiBtYW55IHNtYWxsIGNoYW5nZXMgYXMgdGhlIHByb3RvY29sIHRvIGNv
bW11bmljYXRlIHRoZSBjaGFuZ2VzIGRvZXNuJ3QgDQo+IHN1cHBvcnQgYmF0Y2hpbmcuDQo+DQo+
IEVuYWJsaW5nIG11bHRpcGxlIGV2ZW50cyBpbiBhIHNpbmdsZSBjYWxsIHJlZHVjZXMgc29tZSBv
ZiB0aGUgDQo+IG92ZXJoZWFkLCBidXQgdGhlIGNoYW5nZXMgd2lsbCBzdGlsbCBiZSBjb21tdW5p
Y2F0ZWQgc2VyaWFsbHkuIFRoaXMgDQo+IG1lYW5zIGEgc2luZ2xlIGNhbGwgYWN0aXZhdGluZyB0
aG91c2FuZHMgZXZlbnRzIGNhbiBzdGlsbCB0YWtlIGEgbG9uZyANCj4gdGltZSB0byBwcm9jZXNz
IChlZy4gYGx0dG5nIGVuYWJsZS1ldmVudCAtcyBmb28gLWMgYmFyIC11IA0KPiB0cDAsdHAxLC4u
Lix0cE5gKQ0KPg0KPiBVc2luZyBnbG9iIHBhdHRlcm5zIG9yIGAtLWFsbGAgd2lsbCBiZSBzaWdu
aWZpY2FudGx5IGZhc3RlciBhcyB0aGUgVVNUIA0KPiBhcHBsaWNhdGlvbnMgY2FuIGRpZ2VzdCB0
aG9zZSB0eXBlcyBvZiBldmVudCBydWxlIGNoYW5nZXMgd2l0aCBhIA0KPiBzaW5nbGUgc2V0IG9m
IG1lc3NhZ2VzLiBJbiBjYXNlcyB3aGVyZSB5b3Ugd2FudCBtb3N0IGJ1dCBub3QgYWxsIA0KPiBl
dmVudHMsIGZsaXBwaW5nIHRoZSBsb2dpYyB0byBlbmFibGUgIioiIGJ1dCBhZGQgZXZlbnRzIG9y
IHBhdHRlcm5zIHRvIA0KPiBvbWl0IHdpdGggIi0tZXhjbHVkZSIgaXMgZ29pbmcgdG8gYmUgYSBi
ZXR0ZXIgc3RyYXRlZ3kuDQo+DQo+IERvIHlvdSBoYXZlIGNhc2VzIHdoZXJlIHlvdSBuZWVkIHRv
IGFjdGl2YXRlIG1hbnkgb2YgZXZlbnRzIGJ1dCB3aGljaCANCj4gY291bGRuJ3QgYmUgY292ZXJl
ZCBieSB1c2luZyBnbG9iIHBhdHRlcm5zIGFuZC9vciBleGNsdXNpb25zPw0KPg0KPiB0aGFua3Ms
DQo+IGtpZW5hbg0KPg0KPj4gTWFueSB0aGFua3MsDQo+Pg0KPj4gWmFjaA0KPj4NCj4+DQo+PiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPj4gbHR0bmct
ZGV2IG1haWxpbmcgbGlzdA0KPj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZw0KIF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGx0dG5nLWRldiBtYWls
aW5nIGxpc3QNCj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZw0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRu
Zy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFp
bG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
