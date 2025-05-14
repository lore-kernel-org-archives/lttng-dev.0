Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520B0C3ABDA
	for <lttng-dev@archiver.kernel.org>; Wed, 14 May 2025 19:16:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZyNPC1pY1z10rX
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1747250193;
	b=qNz9UmZaxNFiLPWQjswC4yjYa93i9lr06PqdalZ0Zw9iTdZJ5liN9FkGEP6o8vRxqZGb
	 U0OXC43ZTKTZNAEjWQBEPWF3Ec7DDTNw4piazTxE5CEvIHmEnKfaRXngpg/tTtpWb+aTp
	 YYj6uvnqIJQLGBat1+z6XQJIi2rlJKE9cWUZM+9fcjcJFRZggPoAbTtO2olCdUpZ/AIBq
	 rn3Hf37ZSBVgPHm82/lUchXoBTe3cNYviT6w86f/sD81kniDsa3ImcH3WnE/9olmv6H4r
	 Zkjp0NmPooTYIKwsHxn6BzGtbJ7sqw4U/0FQpzBdnTNiHZiqGDtS/+v4+lbC5AJwKEQ==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1747250193;
	h=DKIM-Signature:To:Subject:Date:Message-ID:MIME-Version:From:From;
	bh=jiH8UQyYBmoa0YkWteFua/N01US4colL8NaU9GMuuB0=;
	b=P1dLaqRY98fk8EVZPpiDmxznF1MICnrh2z4TcVA0MBURgweIZagXpfWZpQ189zGgg+e2
	 Nq6ZsGCsrf80Z1rQBu+OdnTaDt/LclhjBdyjRtdgtT/sHEOC9HV1/M/qIPdH4Q2OovD98
	 /Vq3s4SihYtf/tkfjwVgpY9a0EbEV7CrcHwY2ar7xEEc2eJzOaFLF6ap+lk1ahdYlHTWM
	 gAcAqU8j7thQX1ROrMFxCVgxwKqfS8RsmsVO1UIL7gDefZ3POVwFGYvwsJCtSl0+Kcta8
	 zotLHmNo0q+omw1NUFcJ7wElXUkgS3zipoo77vkaqfSV+3cgUq/nR6cOxyr7FUlcSNg==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZyNPC1pY1z10rX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1747250193;
	bh=jiH8UQyYBmoa0YkWteFua/N01US4colL8NaU9GMuuB0=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=07IUMLFyZdx41uz2//edQFs7dLkr1dAnJatWwvg3j9OjS2GnuaXnqummVInzgPFlw
	 rEURBmnsQ5s/loSRgpkAFFAcm/ANfdGZr9pPege9GY9N89gDjlaLfI8fyqq32kx5kS
	 /4P/w2n6gTilmeqfhsCh2pKTWRqu19SGCv9avAI6XTAN0AWT6oD5mB72x+kM5E2495
	 Ke9d3evXMzvK4aFIAB1ree7kMvnAjjq4u/Wd8c+gfBKv1BHhWq7cquZajOM2t0Vu+U
	 mqjxuSoITHwS7p2G4q11iZIxFz7yvX3APtuGODRCeaDutlUNm3v4jdYYpoigk2UIVI
	 8ABkM3lYCwDww==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ZyNPC1pY1z10rX;
	Wed, 14 May 2025 15:16:31 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZyNP914DFz10rV
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZyNP914DFz10rV
Received: from YT3PR01CU008.outbound.protection.outlook.com
 (mail-canadacentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::])
 by lists.lttng.org (Postfix) with ESMTPS id 4ZyNP914DFz10rV
 for <lttng-dev@lists.lttng.org>; Wed, 14 May 2025 15:16:28 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCJjhvQ7mc+oorxb8zXKVZ5FT3Y2A8YAXlwCaa526vyWavzBED9WKzx+MDMu0NWs3gJBMu1cmXe8g+ha8ld8l3q6Y/ZynE1S4o1nJp8pZMHIEweq1w124krlcA8NUJNQi3LyPUhRy+uhqK7w1jHchVNCzF8T+yN1Bvt5P3Qzi1pTy5ufdYaURnCeELQcrrCLah7aSEkkONs5Me77cpoNjcXlxZ5upQ7XpeJlUGEeUXpPKB4iEdB4irBWFbnzNvYwod/7RSB5RxaomHVr4tqJSNTB0pmsQSY+atfa3kaLmzJjolJyuJa12UA1eUNP1Sc0LGFKkgPNkoVfmJpK/+MsXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FShucgMpGNuxcln9hXKZb40wgsnGU9EGZKNVgm0+sSc=;
 b=mer51aLMHpeqNtce8TeaJYWM3UMPuVY+q6BrMUlqYNm59aO6mAvJpEuehwjkss+BLNTD07TnMtm5Z75gV6W+5mdinVpguVddu/Rn1srRu5hF17BkllGUyg14TLkl+JUYBDxp0SykI+boBxjJjY4ZK55jxKBhFxlZQKM8C/i6EIN2ZoImUKeah9mFEqZdc1Qq1jHdx9bzWVpJCWK8dbhHw/3/z7FOsL4Z0dWRi7fa9CFt3GonxUk0QuGzmTbBMONEOIc85vz11M0pYNtcjZ5AMonFLh+iGP8MDfNdpScbERRerXyfiksejJMssHGpJ7y38uqjKSs8skVWcKXzBmbbvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polymtl.ca; dmarc=pass action=none header.from=polymtl.ca;
 dkim=pass header.d=polymtl.ca; arc=none
Received: from YT3PR01MB6421.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:74::9)
 by YT3PR01MB5232.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:64::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Wed, 14 May
 2025 19:16:24 +0000
Received: from YT3PR01MB6421.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e832:2b7c:ee0e:fac6]) by YT3PR01MB6421.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e832:2b7c:ee0e:fac6%5]) with mapi id 15.20.8722.031; Wed, 14 May 2025
 19:16:24 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Subject: lttng-modules-2.13.18 Condition for Kernel 5.14.0-582.el9.x86_64 of
 Centos Stream 9.
Thread-Topic: lttng-modules-2.13.18 Condition for Kernel 5.14.0-582.el9.x86_64
 of Centos Stream 9.
Thread-Index: AQHbxQPBLYDL1W3OnUSDBRJT7PWG9A==
Date: Wed, 14 May 2025 19:16:23 +0000
Message-ID: <YT3PR01MB6421C77EF52F3D7A62651E93DC91A@YT3PR01MB6421.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: fr-CA, en-US
Content-Language: fr-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT3PR01MB6421:EE_|YT3PR01MB5232:EE_
x-ms-office365-filtering-correlation-id: d3b2930e-a1ae-498e-521b-08dd931bd135
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?HeYifl7uch4Qif2Q7EsJwZ2fjCJJsSYWM5QH6LI4/KroBBjPyNrVZ+DszV?=
 =?iso-8859-1?Q?N2Qql6EfOwNgDWzYZ7lM3Oiidesq3nqOClE0xHWaS1xFskCILVaUJJvB+N?=
 =?iso-8859-1?Q?j00Ae6xRacDl32gtWUw7TmNT1fy6b7O00On4NST8C8U3irx5d8X5UlOLJj?=
 =?iso-8859-1?Q?7ZfkSYZ/oXssyJ7uWB8JMPreBz9kz77uCRq2KIsHoxud5+0hz4G1ghxCe3?=
 =?iso-8859-1?Q?7u30p/NY3Tk3NToGpGGZ0iE61lNXoSzVkQyCLr0fYtroqbjRLUUQuiNTGd?=
 =?iso-8859-1?Q?32rpXZWlDnXfw8HEnDldhHu8LiTFviAHgQOa20h/bfWapMOGHEhe4IlTxG?=
 =?iso-8859-1?Q?rZgATipKRoae9z9msgHrU3YNGbtMQRNX94VKlOL9h5X9v04setl7e5y2Q9?=
 =?iso-8859-1?Q?yAXFy+KlrR6XxhlN5xF7vycUGKYe8AQpc7RiLnwob+FEzvw2N5Nhxq16Fb?=
 =?iso-8859-1?Q?DD00jkFtCOJ7rA97AC6y85C8hERUDPoufEWHeKlFWc+XpEO/tw3qqUG2Rf?=
 =?iso-8859-1?Q?e4+k+NTpxeCWmeI+5y4Z0CHxAWRGWk/LApPhb+Qr6j/o5pQotA4b6ecdYg?=
 =?iso-8859-1?Q?8ftgjEMCUn6+ZQkYlT7G1s1X6+lHOmYgZwnvB9O8NXIV/rPtJZze1G/9mR?=
 =?iso-8859-1?Q?kpyl183N6bubgT716J5mmBhdmAi95+eKBCBOqUOpGK0lYPXNN/B+FF7bpv?=
 =?iso-8859-1?Q?Aw8B6rxOWBPAWRF7yKW1rSfvo/swyzrlTdBxtQLkybnOjUjykv2e7uVc/q?=
 =?iso-8859-1?Q?atNBMG88+QSfOKtQGhzaPfFrKez5rtttSdj2pi3AeA3w3Pli+tnhadTW+M?=
 =?iso-8859-1?Q?Uo4Tq75mdkD3+0kXLszOFjZtHEg2ZER1lCIr2abPI+cpsojMrdOVVjHdS3?=
 =?iso-8859-1?Q?Aj29k31qoOjrCAWmKV/yib7nAdkvPbALko+YZIeCxDrGb0l/tMhGMTm0zK?=
 =?iso-8859-1?Q?i0KKoWCVx7BwBZRHfFnIGCKx06XrbDneJbqswlq6rkSb7Kl713kVwj7BwX?=
 =?iso-8859-1?Q?PrIy6P8tb23Fo1eGj//2DYgT6gaDfezmzXK/DAlnP2WvnPBZN0E7VclCKe?=
 =?iso-8859-1?Q?s2X7ZfQ9rz5gYJ5/1SlCwtvkaOE+Ghgb3Hd5pFF8KqTTR0Y/9PyGtr1VGj?=
 =?iso-8859-1?Q?4pKFiW1N6i4XqOUMrybo9SwWTC6pgfgnAvgrhqiXZRooUxlGJDwhic6/ww?=
 =?iso-8859-1?Q?GOuMYmtiefxcCE8nuVuY38S6q8MXkATDFkbDQ3ckI53q9MKO8Zo7VAvQvr?=
 =?iso-8859-1?Q?aPFeNJYKOK+oYHnaRIvaFJrAUbVVs4uprQDf71qksOHzB1PSrYEbOujowp?=
 =?iso-8859-1?Q?eUjIX1lXHYUn2OjLJY6cVdSnqpcA8JTj9pfnXksFk3KUTOEYrZkxVKd9al?=
 =?iso-8859-1?Q?s9JKrIbtZ4XxS+Ndb3QSbebNCmWtMEOX1SrHFjPD7x128dbnxg0IEcCwgF?=
 =?iso-8859-1?Q?5GtlGzc78HX8EtNcEtGmmuNWsqNYBsmmte8ElofgEqJL8jhS7cbbU05iZb?=
 =?iso-8859-1?Q?p5Yy/B4JIGNqg4+EG4Pneh4sL6C4t0Vaomd0GjMrn+Jg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT3PR01MB6421.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WMTIPfX1aY1qcq4XYjTxUt/tYy3iq59/eQ35+y1EhgXYs+zdNhE3GDAvbj?=
 =?iso-8859-1?Q?ROkKJGe3CCu4V7erL1hwuuCfGkWRJiZknl7eAUjQ83gcZkQjwy6Bs8CgEx?=
 =?iso-8859-1?Q?qsO/BNj43608qUfdRdhD1dqp3Ds4PAaPWTCgj+lUUsQwnqFA6/RsxScLZ/?=
 =?iso-8859-1?Q?x1vP88/qU/Qc5KZCGiIv5EswtqINgk30qFQ4K6cEyrVqVWeopyjoXCIG0q?=
 =?iso-8859-1?Q?FAE6Anbpdi4HJG9kGwH3aUjxdSkmVQ4+VA+9j1IxEIiFovbBIHEH+hO/8T?=
 =?iso-8859-1?Q?8IP0lEAGxu+csKy9pEalTBBQqpx1IYv/i2b0yuwpGtIweLOp4rb0MdaRAZ?=
 =?iso-8859-1?Q?Zq0aCJFQn+wNXWuv1/TtgP1OhGj1porSvAcbLehX86o9yFFOv1CuCmszno?=
 =?iso-8859-1?Q?a9ImS5oMDSPNYED9Yr4nVOk8FOaQBH6QevBkGeYVIHhAz9ECWb1myO6BCl?=
 =?iso-8859-1?Q?YkQYtx/omrzdi942/yJwgNQJPW/cUg2IFnJEAobD5vIqFQ2r4YUYZkf0NA?=
 =?iso-8859-1?Q?3w4ifiX9zwePq8nSukXDNKY+n4UmU1rv+c5k9KRxQxRTnfDqVXHsIQu6FJ?=
 =?iso-8859-1?Q?Xh2L61S/mLewYVRAE1EYm2omaBcuwTdE/GcFx+tVAxwgNhYEW4spBOCapI?=
 =?iso-8859-1?Q?MRfPg/ssP33aIB2eVdiU9PqIGWIoxgZC9/cz2o76Tf2sMFPPV3X34Upcq4?=
 =?iso-8859-1?Q?MMzL7Oxqk8py1cVRjW2Tr3LNREB0DxmS89d+n9OaDJ4t7ygWPwnVfR93mH?=
 =?iso-8859-1?Q?gjcfs9jCR8s/iQyt1qYc1N1wi0LC1n05149dGzKCfBsEDVt1rYurP4Pf+L?=
 =?iso-8859-1?Q?LU4k2NzryELogsyovcqOKr4MT6QY1shVQxc1FoYOFrRe/YyYYavdrU9EWE?=
 =?iso-8859-1?Q?HYAc4+rVQgxTbQnIahoBn8cT2Lqxqo9i7xjRxZ5MfVTlEFRDURBPRfivI6?=
 =?iso-8859-1?Q?tQot0Klkb9r7QYrXp3X0LRHGNyLMhqFwidF7HyMzQ0i4ZpnMKv+SXw4fFf?=
 =?iso-8859-1?Q?IZm07HIeioF1MtKslwhnrOg5SfLCZIOte+dZuxBf0mmfU5soD0W5Q4AHFe?=
 =?iso-8859-1?Q?yOP/46ZI4yehKI7If5JdlKORlkQLcyaY8YcElZkh8PTbuReWSzAq4mlTxt?=
 =?iso-8859-1?Q?f05WljgVUVRSixpuM3ybh2/JM7skOYXd71jMF50wiuB2FvfiT8f2Hv0yRh?=
 =?iso-8859-1?Q?DOueNS8VcuTpq79m5zQZ2WBDV/LkwFt57HAIehoBH7Avv2RVbfGN3i49MQ?=
 =?iso-8859-1?Q?gUgaT76dYZygJN7EqmbgwwHMW2adWfYyAtH1FqEli8VXdW2nR5pqd1dPgb?=
 =?iso-8859-1?Q?WOhoq5zqSzMO7O+A/Eb3e1zj+gfTVnjcMQD3Gw7wN+RFhfpSrijCXZClK3?=
 =?iso-8859-1?Q?78WvQGOILS3SDHo4WvC2Mi5ZTEd3nhQUVVZoTAkvq6gWEY2DUPe/v94p0c?=
 =?iso-8859-1?Q?FMARZer/fyVFam551jsZn9sSlRyLS5BQFd8LmUwAfb1RFXLIKpExgFTHp0?=
 =?iso-8859-1?Q?E/EhZI2cuJl6oiehtGv0FANp+vw45BpEsmCZgyVlCCZnFpvmODaiL1ejql?=
 =?iso-8859-1?Q?pgRGeBdBOPlRk908yMH+EvNUMa9goIJOePe3Wu7LKHCP0Hoo6wp07SxeBw?=
 =?iso-8859-1?Q?DgcRASA+oRn+kty8ezH33neKRSfAxmUI2z6PjudQY4QlaX5U+Ln8Uckg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_YT3PR01MB6421C77EF52F3D7A62651E93DC91AYT3PR01MB6421CANP_"
MIME-Version: 1.0
X-OriginatorOrg: polymtl.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6421.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b2930e-a1ae-498e-521b-08dd931bd135
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 19:16:23.9431 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 253209e9-7731-40eb-96e1-6444a6823237
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dndpZQiGR1eTV4Ze2JJs+gG5vtuVd6hSq/hFYPPZ7JozSPOZe6WZYQXGNEgfSHW4c2ApNfcqrH3k/mPNEkuMZuVAVMBozWkQsTuWlK3AOiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5232
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
From: Jean-Marc Chevalier via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jean-Marc Chevalier <jean-marc.chevalier@polymtl.ca>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--_000_YT3PR01MB6421C77EF52F3D7A62651E93DC91AYT3PR01MB6421CANP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

For lttng-modules-2.13.18

I have this error with kernel version 5.14.0-582.el9.x86_64:

lttng-modules-2.13.18/src/lttng-statedump-impl.c:415:20: error: 'dev_base_l=
ock' undeclared (first use in this function); did you mean 'device_lock'?

I got it to create modules by changing the condition on line 396

Original:
#if (LTTNG_LINUX_VERSION_CODE >=3D LTTNG_KERNEL_VERSION(6,9,0))

Modification:
#if (LTTNG_LINUX_VERSION_CODE >=3D LTTNG_KERNEL_VERSION(6,9,0)) || (LTTNG_L=
INUX_VERSION_CODE =3D=3D LTTNG_KERNEL_VERSION(5,14,0))

I don't know how you distinguish the version after the dash character for R=
HEL kernels.

- JM

--
- Jean-Marc Chevalier
  Technicien
  G=E9nie informatique G=E9nie logiciel
  Local:     M-4002
  T=E9l=E9phone: 514-340-4711 x4266

--_000_YT3PR01MB6421C77EF52F3D7A62651E93DC91AYT3PR01MB6421CANP_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
For lttng-modules-2.13.18</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I have this error with kernel version 5.14.0-582.el9.x86_64:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
lttng-modules-2.13.18/src/lttng-statedump-impl.c:415:20: error: 'dev_base_l=
ock' undeclared (first use in this function); did you mean 'device_lock'?</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I got it to create modules by changing the condition on line 396</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Original:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
#if (LTTNG_LINUX_VERSION_CODE &gt;=3D LTTNG_KERNEL_VERSION(6,9,0))</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Modification:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
#if (LTTNG_LINUX_VERSION_CODE &gt;=3D LTTNG_KERNEL_VERSION(6,9,0)) || (LTTN=
G_LINUX_VERSION_CODE =3D=3D LTTNG_KERNEL_VERSION(5,14,0))</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I don't know how you distinguish the version after the dash character for R=
HEL kernels.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
- JM</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div style=3D"font-family: arial, helvetica, sans-serif; font-size: 16px; c=
olor: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);">--</span></div>
<div style=3D"color: rgb(0, 0, 0);"><span style=3D"font-family: arial, helv=
etica, sans-serif; font-size: 16px; background-color: rgb(255, 255, 255);">=
- Jean-Marc Chevalier</span><span style=3D"font-family: Aptos, Aptos_Embedd=
edFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12p=
t;"><br>
</span><span style=3D"font-family: arial, helvetica, sans-serif; font-size:=
 16px; background-color: rgb(255, 255, 255);">&nbsp;&nbsp;Technicien</span>=
<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; font-size: 12pt;"><br>
</span><span style=3D"font-family: arial, helvetica, sans-serif; font-size:=
 16px; background-color: rgb(255, 255, 255);">&nbsp;&nbsp;G=E9nie informati=
que G=E9nie logiciel</span><span style=3D"font-family: Aptos, Aptos_Embedde=
dFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt=
;"><br>
</span><span style=3D"font-family: arial, helvetica, sans-serif; font-size:=
 16px; background-color: rgb(255, 255, 255);">&nbsp;&nbsp;Local: &nbsp; &nb=
sp; M-4002&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span styl=
e=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, =
Helvetica, sans-serif; font-size: 12pt;"><br>
</span><span style=3D"font-family: arial, helvetica, sans-serif; font-size:=
 16px; background-color: rgb(255, 255, 255);">&nbsp;&nbsp;T=E9l=E9phone: 51=
4-340-4711 x4266</span></div>
</div>
</body>
</html>

--_000_YT3PR01MB6421C77EF52F3D7A62651E93DC91AYT3PR01MB6421CANP_--
