Return-Path: <bounce+b7b410.602323-lttng-dev=archiver.kernel.org@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from m43-8.mailgun.net (m43-8.mailgun.net [69.72.43.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893DED41D4D
	for <lttng-dev@archiver.kernel.org>; Thu, 11 Dec 2025 14:57:51 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=lists.lttng.org; q=dns/txt; s=mx; t=1765465070; x=1765472270;
 h=Sender: Sender: Reply-To: From: From: List-Subscribe: List-Help: List-Post: List-Archive: List-Unsubscribe: List-Id: MIME-Version: Content-Transfer-Encoding: Content-Type: In-Reply-To: References: To: To: Subject: Subject: Date: Message-ID;
 bh=JgIGt86VkgdXaRciGxhEisraQ82/IFLjA7icxwoEHts=;
 b=Ckt1TCBXIbNIa06GDyF5eDzabzEv9do8/9/0HxhMB5iKftCh//F6ElPGCHmPU/Zf9BlFfDu/1hdBOp5uHYo+xZrLSHnPFuSze7gp1hpJfoGZsjvWicoBqI7i9PPPbQ8H03r/zL2IDxT5nsGaeQUtKdUffp2D8U6kDU9/JeS9cz3AWJYO/xzWjEOO8O4GdNAayW3L1DtQV4YmhfcMrifV0Iu/g3nalDPnmqyDj2v8CFwM0lE/fIl+IvP6IyicoPNIvkyKRnFfTEtv2K4MkuHQinSaisleLTxeIa8wGRF3RCdVEum5iClwXqN9kZFx+3GNOY1zIOJvoMDOhKq3heg3dA==
X-Mailgun-Sid: WyJlYzgxZCIsImx0dG5nLWRldkBhcmNoaXZlci5rZXJuZWwub3JnIiwiNjAyMzIzIl0=
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29]) by
 79177c26db0470137173519530f3b79781b0afd3422bf4b3d81175f63d54ddc8 with SMTP id
 693adbee527c7e00651a3061 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Thu, 11 Dec 2025 14:57:50 GMT
X-Mailgun-Sending-Ip: 69.72.43.8
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dRwgK543Vz1wJt
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1765465070;
	b=hzMVaiYVagbXXo3TA5ioE/PQOOCnI2aiLs9sqnwAAx+/8OxbI7fda+H12Mb8He3SDgwj
	 OLsPrcGs7MEY3kW7IX48DOEmM3wKGzl3pk236pCVrTdIMZltYKJEt2GFCwZWJp9CK4+s6
	 tm6O4d1bX5oCJD56u550lQ5LgKBxLZSsx0Ee8/zXgXNJbsDLCC9TSyybsJc5Mg2dfqnNI
	 mqXjZRlXQk2RUKiElIG/h6p/AtbY1N95LHG0pLBnfz9X4glQ5MhUvT+HuSN+ps4FjNFOt
	 foQ/F4fCKXHDHIswlsLIo8luOxyBMKjApDvKhTvVEABG56wXEfcSKE09hLZQKWIAexA==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1765465070;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=/dmNNcaaW3BuZZsafD2UyunGN+3iWMvD0YgFZqD5iMk=;
	b=dOgNWNY+FUMBPDN0eVFMtAzSPcQIoHinu+guuhAA6EHXCrYJTf9P+hwJousXwKEGDZ/0
	 92Df/Jp7aZkd8xM/3riEqCIOS12CfXESDGlqqoJCeMDFz7O/HVnuRwozOhwwRrJwmNUUF
	 /pPH9IbB+echoYz6fw31sV7q1qW6kv2LmkgconekDsJrdaUhlk9tzTWqH/uN0038sBk67
	 qWttthHF6P17r4IFWPYyuhT9UqXZR2hhCV6Y4ByPCRmLzU2+tpgBN5+oMN7zdMK8ZKJ6O
	 h5DDoLjcaTqZFFjzK7mryN4/0/lbLrAk3IG5Gm6WgurvduX1rdAnZ1sjKSZjkaSl6MA==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dRwgK543Vz1wJt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1765465070;
	bh=/dmNNcaaW3BuZZsafD2UyunGN+3iWMvD0YgFZqD5iMk=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=XskfUHcU7C4oDaPDC8ls43RalS8NkLdnZ+tV1mVPO3cUDM4MrIQe0BesR/VPDUaxl
	 ktcq8a4NjnY13kPoL/XiHX4smscYgud2Qea+6AyfH8Zs5JNzgQvVdMmgaRVZIa/gKL
	 XAJ/6JvJiJdSxhsWDPaIt9Td5jZDk3kwg/Ok/xEpj2kWglR8UWWX+L1SowiG1krGzK
	 CsL/rE1C10Jc3fLa+yDh+YzeUPI+u6fDAX+kNPY5vcYUo57Ywxed5NqIrAu47Ybn1p
	 mWX8fSUBXltVJTYWxuJNN+HKK7Wz2LmdKoy8Xoo/1iwEmPR7f3tcRbsCc+Btg7CD60
	 gQfFmDN0Qjs8Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4dRwgK543Vz1wJt;
	Thu, 11 Dec 2025 09:57:49 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dRwgJ32zlz1wMX
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dRwgJ32zlz1wMX
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazon11020132.outbound.protection.outlook.com
 [52.101.191.132])
 by lists.lttng.org (Postfix) with ESMTPS id 4dRwgJ32zlz1wMX
 for <lttng-dev@lists.lttng.org>; Thu, 11 Dec 2025 09:57:48 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfOEgCICVPE85kP+8rKGrxgBeFXyCcJoXAXRXLLnETSYqJCHIdXHX1/f/gnn9nsqrpoyvxLuMlGwydZRktEOH7l+6ET15DNmR8YEGtDZy/Nc40eYBU14Q5BW8xuR/Zdz9NNOUGXoxldm/TufbsoArPxnH2CiyysrdUrRUy1woDRlS/Riv1VxntAG06+0XM3eKAkmaR32LtnYdx7pBBpB3OObdLOyHc9IQ25Q7iazPnr/WuUkAiwZNkWvxY+o+uVUkcrywgvHCloe1aX8vSfF6xlUDQHUyEqBDtTaepYRNnPRq+rcTTTBD1TzxzDi8mkOAvjHsn/NqzHfKYm9iTEZ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgIGt86VkgdXaRciGxhEisraQ82/IFLjA7icxwoEHts=;
 b=aNY83YLVgTiTDboItXsTqbamg4hTnRyeot3/KLLJqItBP++CwHBOqdydlNURquXoYSbOOQuvo4KyAKQPo7U6HLm5bocCaFOksX0IjIxop74/rRXV7e7USuKxH3KhZjtcxe0MdZ39m8diq0k1Wrzek7hP6tzFnEDQGJNd5TnG3IGpsb5nNbGGWIF+BT4MdZNPhk6x/z9PG5zs3F0z69ZH/py5JC0pOMn74dJvylfSCsjNZSGie/UFykQC6uFn+JZnHioInoCSpa+u7nAKN86EYAzcskGYkCbArl404JiZtblj0L3O6rn8IANFBLbYkYhB8/wtjXOoLXbb2sZnYIdKNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:24::5)
 by TO1PPFE84DC0FBF.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::6a0)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Thu, 11 Dec
 2025 14:57:44 +0000
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::be09:e1b:b343:7f9]) by YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::be09:e1b:b343:7f9%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 14:57:44 +0000
Message-ID: <073db198-6792-4caa-81f5-ac65f5d76f1e@efficios.com>
Date: Thu, 11 Dec 2025 09:57:43 -0500
User-Agent: Betterbird (Linux)
Subject: Re: Question about LTTng Context
To: Kienan Stewart <kstewart@efficios.com>,
 Amir Najafi Zadeh <anajafizadeh@cs.stonybrook.edu>, lttng-dev@lists.lttng.org
References: <CAOQX81f1zGCsnr3Ksjv0WoO-J4-OULanefNxzWdrxP8b4+aqJg@mail.gmail.com>
 <87a7e3d3-3ce2-4ded-acdf-bc7f152cdcec@efficios.com>
Content-Language: en-US
In-Reply-To: <87a7e3d3-3ce2-4ded-acdf-bc7f152cdcec@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0349.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::14) To YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:24::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB5080:EE_|TO1PPFE84DC0FBF:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b404fc6-966e-43e6-8e6f-08de38c5a388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3Q3NXdYT3lUdFRib25ZekdlamY4VHBiOFF0OUNTUnAzeWhTL2RSMm84cTEy?=
 =?utf-8?B?d2lkTXQzekNkMW5rcXlmbXZteTRjM1JSS3U5UnVPQmJkNkFjR2VvSzYxNmhJ?=
 =?utf-8?B?VjJRRzNsQVYxc2UyTFFUMHlpNjVBU2orWldQWmM3Y213ajVrRDZCSCtaRVJw?=
 =?utf-8?B?ZGN3ZVJQYmtkOHhBdWUxbFMwRmpzMGZTMTU0Z0Y1MGdDSXN4R1N2VS9BWmlJ?=
 =?utf-8?B?ZWpCWmxJUVRVUHZpZE0zU3k1cDlxdXRKQXBmVmQ2cUJyNFpYdHJ2MWJmbWFI?=
 =?utf-8?B?OUJJYzhSN2xFNkllalFKbWRNY0JCQjVXNXA2UmJJOEpPK0JkbTdwQkRHUHJB?=
 =?utf-8?B?K2hZbmFyZkI5dklNUGVYM1BpemtQenl0UGRBblZiQTFZVENURHM4NzdhQVF5?=
 =?utf-8?B?TTVqdXN3Y1hjZ0hqTFJDSjZ1N1Z1Q3RYZkt3YXI3RkpCN3djNWs0WEVRRklD?=
 =?utf-8?B?YVA2dVdtNTA2dm1ITFdaMnVqbEdVYlZ2SzJjejZ4elBSRjVmWWd5ZTlxK1ZS?=
 =?utf-8?B?K2k4alVqTU9zVGZVVkF4eEs5YUVLb0ZMcy9JT1ZPL2xOSUZxS2krd0VjMStk?=
 =?utf-8?B?RStRWmF2ZEE0bFEveVBXQXFwVmxHOHN2MXlFb21yOVBibi9EdmRqTEIrTkJX?=
 =?utf-8?B?Y3V0RlMzNzZFb2hxUmt3LzNQQlY2bm9kdW9JTEI3bXNrbXVYbGI1aG5ib3kr?=
 =?utf-8?B?RFNhaXpISUJvZTNsdWJLbjU1MGp1blZnaERhQStzMTRmWHBreUNqTXdQREpl?=
 =?utf-8?B?QmpnUHluUG5sbnorMjJETURCaXVTaHBOSGNVVHZuU0FjUGlpOG9xSVovRnRL?=
 =?utf-8?B?TmVTMDM0UWcrSTZNTXJnT1hqSWlnSys3SVNYdWJ2d3JibHRpYWFVelptb3NY?=
 =?utf-8?B?d1RlaWxSazVtN3loQVd4cUNyaDV3UVVldnphZ3o1U2QrVWZUelZxSm1SUW5T?=
 =?utf-8?B?d0x2RzhyZzQvQk53akJ3bnd0a2RpbDFTVmcyUGh6N1ZWNUQ1ejF4d1hRS1Rk?=
 =?utf-8?B?TCtkNXYyQm4vVFZTZTNPMnZmS0dTd2UvZ3N2MlBPSG9yeWhtOFlBMUd3Z3ZL?=
 =?utf-8?B?ZnUwcTVtU0x5VGhEeHRpTE9ZbjdYK0U2RStBUmVwUjh1UitaR1ErSFhkSERD?=
 =?utf-8?B?VlcydGtnczNRZVRUVWhVUklpNmcwTHJLdTFqT200c1VTV2tPSDlraFVmOFlk?=
 =?utf-8?B?YVhuZXlWMGRlYURGS0piaFdsWVBlWENpNjVzYkdGRTQ4U3JKWXpySEZJVUFY?=
 =?utf-8?B?VjdSZW5vbnVxRndrS2cvNDNzTmZwdmswV2tGdEM1ZXZ3Qk83VmYxcHAzZWtT?=
 =?utf-8?B?TnM3UVBxMHFsdk5FVm9vRllnMHBPcVRVVlMvTGJLVmNGc2c4ZGt1K0pXYzJh?=
 =?utf-8?B?RUZTQVUrTU54cGxXUG84QzBmNm9yM2JrYjlhTUt6c1pndkdPRktnWTF1RUxz?=
 =?utf-8?B?VmxaN0RoeFBkRkxVbXRFdnVsZ1FqTXF6Q2FKbDNyY1VKNFpCOXBqOGtwU1Q0?=
 =?utf-8?B?OUF6dDdkRk1vNnRBY2JieXJnYjZFcW8wcTdWYjNrbGxRY2QySVIwcE5YZjBE?=
 =?utf-8?B?RW9HWWlTOTBTV0MyMkk4dUxIdVRRSUxPWWZPeFdrajM3QW9qYjM4N2w1VE1R?=
 =?utf-8?B?WFRnSjNpUE5za3JiajdwcjY4RitQbVdPV2t6T21HRW9Rb2hNOEZMejNEY2J0?=
 =?utf-8?B?UnVDYjdTRzFUbEVJRkhqKzRTOXF6QkFiYnAxTjNpU3Btc05MMyszbmZYZW1j?=
 =?utf-8?B?OHhCVThnY2daL2phTHlPTGpzYUtPbzI4UGc3V3o0M1FPcDRUKzRuZkpXZGxt?=
 =?utf-8?B?R1VhL1k1VGdxN0xRNFFDQVhVZDBjSm5ySkg4czRhUlg0bVdtdGFrNjRkaGVX?=
 =?utf-8?B?bkk2SzgxSDZRaWZUTkpNRkdQTUovRnZWdFgxb1U2MXp4ZnEyenFWaUpHZFpj?=
 =?utf-8?Q?0/1qQpdYTKjEX1DrCf4saebMkCjQlHJt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VklqSDlUTlVsN1RjSFV0VUliNjhYeXdPTkxTckR3dTl1V2VKOStjRnFHeXZP?=
 =?utf-8?B?NUd6dGpkM0xJNUx5QWRtSmJEVE5WL1p3dEFzOG53UmJPcExCTW1Ha3FlWklE?=
 =?utf-8?B?c05jVnhjeFd0UkJIWnZzdUR6b3pDdFNHcGU1ZHp6amk0L1k0MjE3RDcxRVgy?=
 =?utf-8?B?MFdNaHRHY2YzbzF4am92d1ovODBNS1M5ZkNmNDhpQlJnRURYSkliTTdsZDIy?=
 =?utf-8?B?dFFIdzBpUVhWY3VWdUNTdFkwQmlodnB5M2kvaU4vTk9XZnBwL1BsbUJuZDR4?=
 =?utf-8?B?UWRaR1hYT0k2VkF1ME13L3AzZnV1L01IVHFraVNDNjNENUJhSEVhU1R3aDJT?=
 =?utf-8?B?d3RKaEdIZDZVd2creiswMUNUS2ZLUUIyaUxnTzBvcVpLeUw3RExsU0RGR2xx?=
 =?utf-8?B?NjF3UXBaQ0ZZRTczck40b0x0UlpSY0Vpb3MwVm9FTk1NYXRvdVpJKy9WYjRY?=
 =?utf-8?B?QUE0Qzd6Y2JaanBKVUFLcko0U0pxODFyU0hqcUNzQ09GODZ4d1JnTGxXUUly?=
 =?utf-8?B?QktaVWRPR2JqRm5mS3VZY2JuajJFMTlDOFl6S015WDZ1cXgvRnFsRlNlWktK?=
 =?utf-8?B?ZFlSMk45cW9oKzZwN2lpVjVGQThSS01LcExmU3BJMnFFVnJZckxJdFMxQ1Fs?=
 =?utf-8?B?Wmd6WXhEK0FVR3kzNXpROE8wbW1sakNBTXgwR2ZnL2NQRFNRYW0xd2x1ZG00?=
 =?utf-8?B?RUFnK1JrODNwMUhqcEV6QWl5NlhnNGdDWFFDZks0Rk90Rmp1cklIaHE4Q3lZ?=
 =?utf-8?B?dzR4ZkhFbHB6M2NrV1hDRGZsbmc1VjJnVzJreEE1MHJmWVlzQUl5bmtTbnhJ?=
 =?utf-8?B?UEtEOE1KczBpejN4dVVzdXFIYmNrSlNaMkJjRjVIQUVLUmdteExQam9zbHA1?=
 =?utf-8?B?MkdwOTJDcGk0RXhnSXpacVdnUktTUC8wak05TTlINDF6SkpFUzh5NVNDb0My?=
 =?utf-8?B?Q3IxV0lrbE5lNVRHeVJHWGdoY3lBR21YUXgvZFZPTU9GM1FpSVh5eGRNUVFX?=
 =?utf-8?B?cm5PL3dhRFVQVkUrR00wZllOaWsrMXExS25DaXpzWFlmMHphanBVT1pBWVF6?=
 =?utf-8?B?YlU4MUkxRFFMdXIxVG5aQUNqRzBZQWpWL2ZKUnhrNzBkZGtQY1Q0MFlTR1pM?=
 =?utf-8?B?ZWhUMzUwditFWUN1NDdWTEF4MTBpZWpURVQzOWszcmRYbmRqZHR1T25lbG9W?=
 =?utf-8?B?RGZRZEtGRzBaZUU2ZnR3RzIrZXFMelF3MllXT1owWE90aWNHK2tlakpYL05r?=
 =?utf-8?B?V0tEV3FGZTBlazlwMGRQLzFVL2tlUmc2alhFSXNZYXM4UkNXOTF1Wnptb1J5?=
 =?utf-8?B?U1lMdEw0QWprTElZWGYvTXFPTVVXWVVVWFlJWERmaXFXN0NhVjFWanFvUkZk?=
 =?utf-8?B?ajNZQmw0Sys0dDBJbUFlZUZVcjhHc2RqUWFTenY4N05ueHNBSFVMVm81akM3?=
 =?utf-8?B?QnBvdnovS0hDR0p2QXF2RWJXdzdWQm15b3Y2Vi8yS3c0Znc2K2tidVBnQ1Rh?=
 =?utf-8?B?QitueEFLeVhtVWN2WFg1YTAyMC9wczJIQUFwQmhlRkZNMDd1elRMZTNqUnp4?=
 =?utf-8?B?cllEQ0pTMkpGWkxXMld0OHArdkc3Qktsd2RVZ0thZC83MW1Dajl2WEJ2MzFU?=
 =?utf-8?B?amc0WjIwWW1mVGdzS2YxQkh0R0VCY2U4WjloSTFpc0pYQlpaaGJ2V2Y3MjlS?=
 =?utf-8?B?ZExHZ0wwSXJhYlpadEdYOEFaMlB6R1h5ZC9FVitWaVFXTTFYNUlpK0lUekJG?=
 =?utf-8?B?cmdnd2FsQnBFbXdPckFrUStCSDhzTUNkUHRmbHhPQkpNQk82ck1tTTNRT1ho?=
 =?utf-8?B?WXA2aFRJZFJHQnM3YkJ5eWlHZXBNMXNPcHY4MmcvMTRJSmFSVCs2d1EzMEo1?=
 =?utf-8?B?YlpVSG8yelE0NnYwSlFIcDlkZngxeXp1bGdYSGViOFJhWWVJRFphejJlcUpr?=
 =?utf-8?B?TFY3dm5MQlpmaXJZdXN2dW1teXFKa2ZBaktmTzNBbG9oOXYvVFIrMEthTndv?=
 =?utf-8?B?Mk1QelBhWmFxMzBrQmRFWXc1UzVrL0tXbnZmaTFKSDNHVHlsYlZwQTEwbXFV?=
 =?utf-8?B?ZEUwNUFqSkNPcDdkOEwwdElyWHM3OE9GSHNBazdYOUNFcnNYejM3NkRZdzVa?=
 =?utf-8?Q?KnQ12INQQqurdxuYLENocPshz?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b404fc6-966e-43e6-8e6f-08de38c5a388
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 14:57:43.8969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i41gCvjndP4aEJeLWpkwytE3QtvSOeHBl80KDY+82Ay5Gd1OSAno02LnHoNnW6Bqre/BPjWlNcc7bOdnaPYHtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TO1PPFE84DC0FBF
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
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 12/11/25 09:30, Kienan Stewart via lttng-dev wrote:
> Hi Amir,
> 
> On 12/10/25 9:40 PM, Amir Najafi Zadeh via lttng-dev wrote:
>> Hello everyone,
>>
>> I hope you’re doing well. My name is Amir, and I’m a PhD student in 
>> the Computer Science department at Stony Brook University, New York.
>>
>> I have a question about the LTTng context that I haven’t been able to 
>> find an answer for in the docs or man pages. Does LTTng support adding 
>> the cgroup ID or cgroup path as a context field? I want to filter my 
>> trace results based on cgroups.
>>
> 
> I think you're looking for the `cgroup_ns` context which adds the inum 
> of the cgroup namespace as a context field.

This will give you the ID of the cgroup namespace but we don't have 
contexts for cgroups themselves. It's probably something we would like 
to have but there is no concrete plans on implementing this at the moment.

> 
>> If this isn’t supported, are there any plans to add it in future 
>> versions, such as 2.14?
>>
>> For reference, I’m currently using LTTng 2.13 on Ubuntu 24.04 with 
>> kernel 6.8.0-87-generic.
>>
>> Cheers,
>> Amir
>> -- 
>> *Amirhossein Najafizadeh*
>> *PhD Student, Computer Science Department, Stony Brook University, N.Y.
>> File systems and Storage Lab (FSL)
