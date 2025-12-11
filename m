Return-Path: <bounce+b7b410.602323-lttng-dev=archiver.kernel.org@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from m43-8.mailgun.net (m43-8.mailgun.net [69.72.43.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17593D41D49
	for <lttng-dev@archiver.kernel.org>; Thu, 11 Dec 2025 14:30:34 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=lists.lttng.org; q=dns/txt; s=mx; t=1765463434; x=1765470634;
 h=Sender: Sender: Reply-To: From: From: List-Subscribe: List-Help: List-Post: List-Archive: List-Unsubscribe: List-Id: MIME-Version: Content-Transfer-Encoding: Content-Type: In-Reply-To: References: To: To: Subject: Subject: Date: Message-ID;
 bh=fA4d0GoUARDoIhaw2dWCZCJ7N8KhzwQgYNMOz9JcgN4=;
 b=G6KBxO8Af6Y0Cdy6mUXFqIvS6/OKPU+DYNl9Xig9HTOdSmZTXFt4PvNlLmGFrUfr9Fyil20RdR9wlrtELSZzC92yAdLdK5tM0+UReqh8zesBN1hrxxwBFDQp+IPFVS67HZCOKHxWDCmgMC7MBdp/DEcDTsUNzmdnl/W5If4ECSw5ewXuKAMkehWJf7QW1+1P5EQyku414bDwP7Cvy/uTekSekpG4Iq+BRxsz87w/r+jAqQfOqglot/mdQomVtGqm5cdvFr9e+oKJzhQ6XTZaBoU0+HBmf3DELtvr/obeFMbcJ6Epig4jvEBLSArALRYG+IqxP2ppikU5LQU+sGSCzg==
X-Mailgun-Sid: WyJlYzgxZCIsImx0dG5nLWRldkBhcmNoaXZlci5rZXJuZWwub3JnIiwiNjAyMzIzIl0=
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29]) by
 f0b2e822ee01bc90f1dbec0faa2747091ed57614876083893ff137cf54a14477 with SMTP id
 693ad58aa1a4b5cf576c92ad (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Thu, 11 Dec 2025 14:30:34 GMT
X-Mailgun-Sending-Ip: 69.72.43.8
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dRw3r6k3pz1w5M
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1765463433;
	b=qJBBa+P9YklBUTKDdpQNC4F+BRrkE/sML2cUsvcg1v+tRobyqEaI7Yef1+JXa9SL23N6
	 MT02rx69BZWa4Q2H6/0IfBe54k4JVAETyHIf9hL1GjTbDImTdSntb9Aj5eP11IxVKS5xj
	 JIEyPvqZ9Qeifkukw20HkTqQ4+C/juUmMxy1zJpgbataZ6tpu8dLf/Bu/fT2EchfWH12j
	 2mufy+eYwYwpAWGMC8LE/Mi5WXPrDtn7+b1zMKn01QLF/dnoYdLXBShH9+f7UkLIV3j+W
	 tsmC8afzRqfilDKboKdRO01l4aUkuow5WNV+f9ktFe3Ujipruc5i7yEf7eGJBleFWvA==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1765463433;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=henvVriJCIXi/OqH1itQGtV0Yhzt3XIcdiv557xewIE=;
	b=qRxFU3gGG18mrx2yvDDIDnvtHCjuNZlidUVwBFVvCL3PI/+aZk9Sr45X+XYnIJjjDiIi
	 0Gnc+UbHKgH7FKMtpS29vfuRXECt39cWB8+DQoARm9HP3gAELB1SnQenDoQ+U4VbBcbte
	 z8EhQgEfyXSGN2CO0q3D0RDR82ObCoMdCa5cwn/uCzSrdR1YF9JMX9z4GTi40b/e4Od+A
	 Pgl922w1Ctxr2as8BxcxD54y5NXmV87up7gL0LApR3DHPIB82QrgPDCQ9CnKn7U7NU9J/
	 tKAj9jfPXtrh+AWQf9XEkBMsN+Xp/9TUQnOLxX50DhAtz6YDWoIYnvZg+uI4er0sCFA==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dRw3r6k3pz1w5M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1765463433;
	bh=henvVriJCIXi/OqH1itQGtV0Yhzt3XIcdiv557xewIE=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=AHLGvW4LzKCFM0w23sHKtwJXsRrVt6EPt4whWL4zAy3hLkhlHo2jrQsd/veThenqk
	 A1sOCGWj7lvTysvr+cKrcmKDrsoxwHaG7Oayrj3lNL+gTfUjyzCIZk5r8aV2xBaSQk
	 sBDqp6S08xq/tWCXEb26RV2OwY7q6J7bjFaM8YE/RcXA3wQUdhXCl61jpHOFhoR6Mq
	 lr7qUZdMhK7DPiXUiDZkQNdtrBVJGtkPVl4tGN0R4XYd4JqHeIA5ik+sRtJlqJWzv3
	 fvIp0eEpxxKCHsmUyr8iCC9zp9CJ01z7JXwwwnJ9Ep1gF9FO11wUAiaPIUpdlWjCjz
	 IvVVGbuDq9z+g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4dRw3r6k3pz1w5M;
	Thu, 11 Dec 2025 09:30:32 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dRw3q1C4pz1w1l
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dRw3q1C4pz1w1l
Received: from YT5PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazon11021075.outbound.protection.outlook.com
 [40.107.192.75])
 by lists.lttng.org (Postfix) with ESMTPS id 4dRw3q1C4pz1w1l
 for <lttng-dev@lists.lttng.org>; Thu, 11 Dec 2025 09:30:30 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+HXaO8WiwhW7xKhak19paHZPaQ23Hzyw5BHmyXlWSLN8NtX1wVB91iVPnyGoiweKFS+4wjS+6Z3pV5MAUZBCiipao60/pF39z6qTpn7UYkIxhA+E4WJlgAziJfLA5WMfpZKneAio/f5W5XKTPdKWlnaSUZaphV3CjaB8Bu4rPkYmUvuRI7bDrWwmPMrwhKCjfoe8e80I97VvtQ0nRso6vifaUWmSEd0lXZf+0OsVfjwZ+hSSVMG5fwLfWAYpCKs0/UJRHe/8+JRhpxOkdmBlJE2cKGcdKSh7WbxmihGcxIfID+IyFOyKsLZdYhhJTeb1SBAtGmMGwfR3vHv+6i0Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fA4d0GoUARDoIhaw2dWCZCJ7N8KhzwQgYNMOz9JcgN4=;
 b=eRFhUX5PdlfK5oKRpeh6y9YijhJyOkLlk0VcWU+BB3HSerz7wbv/0a9IwTiR/0whaj7cAn56XTY+qv8ubgSV7zMl+9hZKVSloRgIDjvY9dwvEM5S99pccflJOJw0UT8WsWM51Bm0h9XqgbHA6+zA/tjs9JfPWnRpTlEo7oWDsb9HRlHo5hifd/n4E5mzZoICnBEn2E+M0p9/yAruY95msGfo06f/hpKi1LEZOhQw8WYLuoTAF9KMuvjDAxG/Qq/zHpaDK78TMKdcequfzp+ECVwqXJauhLI+nexzTOgWn0OPtoYaYrqAp97VmGa4TEk/zGsSkcyaYaxB1v/46Q/oEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:42::24)
 by YT2PR01MB6435.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Thu, 11 Dec
 2025 14:30:25 +0000
Received: from YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4c7b:7dec:7e59:918e]) by YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4c7b:7dec:7e59:918e%3]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 14:30:24 +0000
Message-ID: <87a7e3d3-3ce2-4ded-acdf-bc7f152cdcec@efficios.com>
Date: Thu, 11 Dec 2025 09:30:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Question about LTTng Context
To: Amir Najafi Zadeh <anajafizadeh@cs.stonybrook.edu>,
 lttng-dev@lists.lttng.org
References: <CAOQX81f1zGCsnr3Ksjv0WoO-J4-OULanefNxzWdrxP8b4+aqJg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAOQX81f1zGCsnr3Ksjv0WoO-J4-OULanefNxzWdrxP8b4+aqJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0326.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::25) To YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:42::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQXPR01MB2357:EE_|YT2PR01MB6435:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b96db3-9aab-43f2-fad0-08de38c1d252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVErVWlFL3hwQitwWjFLRjNPOVZXNGVSSWNUNWJXekV5L0Z6RHhTaUNWS0tv?=
 =?utf-8?B?aTBFaWIxUEI0TWxzVTVBYkVPY3V5YldSdnhLUVM5RzBkd3FlNVFDaEFYUEhq?=
 =?utf-8?B?UVJ4cWkybEs4ZlRzeTFmY0g2K1o4QWd2S3E0bEI5T01BTm8vY085NjBNbEpk?=
 =?utf-8?B?dnJ0bEJwSWFEYmNjUWR0clNPTlJnTkJyTDJjZUhrZVFlRVQwaHdWckwwekFa?=
 =?utf-8?B?UFN3NXZlVEVoejd4VGkxSnh6ODRVVHNER0FnRFlFS0JHcmpNK0x3UW80TVVk?=
 =?utf-8?B?a0dUbTVQMXZWODF1K1FtWW80MndnY3BtWHcrbTJ1SXpFTFZZTms4anByeWs5?=
 =?utf-8?B?Q083OGtib0ptY3lHdDEwSlNxbDJOb284ZEtJV3ErTzZFdG1obGNuekVRUE5y?=
 =?utf-8?B?QWlDRVkvbEcwYk5mTlRTTDQzb3Z3T3BsWnRwbks3TGtsT3BsRGRIdWNBc1dP?=
 =?utf-8?B?WFJ2VW4vUzFzWFlXZmM5V2dtV1poRm9QUWttR0F0ZmwydS9kUmpodWtmTjNl?=
 =?utf-8?B?T3k1NWFmZkk2T3FkbzFNaEdKMWhJcUNXci80QnFRR0wxWGQrbUhVYTVkb2hm?=
 =?utf-8?B?ZSsxekFSZ0FNU25sTGFjY2RweS9odElOQjVaTlk4S2tudjNtS0ZYREE5dUJI?=
 =?utf-8?B?N2d6QUtqdndHVU5pdmlwYTdGYllUcVpINmdQQWsyeUY0c3g1c2wrQndtN3A4?=
 =?utf-8?B?d0F1YWJOeFVsSFJPUnQ0cE9JbGVzc2JXbWtjV1pEOWZ0aU5PRUxRNFNqMVhG?=
 =?utf-8?B?VE5qSy9EbkUzVTBqb01QR1NKZnZSOEhDZHY3L3R6aUpDcndPMjN0bHV4SjNN?=
 =?utf-8?B?U1dtWkpLSlVRTkI1ZVl6T21sM085MlFDbzJVc0xFV3BvOVB6VC9xekE0SzRP?=
 =?utf-8?B?TjVJUCtiNlA2dEw5N2Ivbmw1UWRTWnlXRS9OUkVmOGJNWGRDcG14OUQ5endK?=
 =?utf-8?B?SjVaS25ZMjFtcHpwWWxlTjdHSEVJWkMyVEpvK2tyYWIyaDliQm0xZTk4cEZ0?=
 =?utf-8?B?R2psUXNUZWNqcjU4L3ZZZUw1UUo1VFBYRWhpMXIwN3prYUw5NTY1N0tma2Zv?=
 =?utf-8?B?WURJai83bVAyRjIxWnBvd3JsVWRoazhwa0IvWkk0ay8rL0pBU2VmNytFTTZL?=
 =?utf-8?B?U0d6SXZtUmlXbnpVaGJPSzdiZGtzd1RuVG40cEk1bVgveFFwVHArZVQwV2tW?=
 =?utf-8?B?STBZZ2FxbmRRNFVXOGRUdU94NGpISUFRVVNVeDNIVThBOTg1M1RleE1sdVhM?=
 =?utf-8?B?QXlMaDBTV1hqUTMwTHZkNGlCem93V3g3TnpySGRYd2IxU0ZaelFFMUo3ZkV2?=
 =?utf-8?B?aVpocktydlQvU3F2ZC9vSmhTcVNVTWp6YkxHSm1YYmhLcW9lSXpSdnBFR2Iv?=
 =?utf-8?B?dmhJeHFFN1l3dkJEOXJFUit5M0VVS09FeDFPSUF3b2F3UWZDdUlBcHJybk5t?=
 =?utf-8?B?d1NYNDJFdjNvMTdsK09MU0lpK1JhTWNVaGxSUk1YalNjR3phUkljd2ZPYUtt?=
 =?utf-8?B?NEhodWZMUWY3K3E2SGVVbjluVEkzMGhTK1N6WXRLdGtBTWRBMzJBV1o3U1Fu?=
 =?utf-8?B?dlBKR2prVGNJOFhhN2lLaTRCMExRVzk4S3lqOXQ4Q2dlcFNZa011Vjk3L244?=
 =?utf-8?B?Um5HZHc5SElieFZ5eDFzRTZ0ZTJlN0FjMncrRGJ5VHMvRmEwS3dpWFordW5B?=
 =?utf-8?B?YVg2eHdQS2M4c2c5VlJBZkgvcjY4UERoTTlBYVFBK2xmZm5LVUpDWlpaOCtP?=
 =?utf-8?B?REJWZUdwYzVzdldxeHR6TmdCMGNjV1hoSWZIVWJkQ0ExMmRHLyt1WU1pbVNm?=
 =?utf-8?B?M1BvZGNiRUUvYkdiUUZDeHNSMkdGWjNmb2dJSklTZDVFMnYrSUE2cDBWdERk?=
 =?utf-8?B?TExHTnYrWjJScjFXTGdjVllUejN2OVl4Q3dtMUhSLzZBaXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGdKdGFMa1JralB3bExkVGxucWZJK3B0dzNvbnFtZUczekdFZmk4b0N3RnFC?=
 =?utf-8?B?N1Q0Nm5BNjlPMGU1TnV3UURRYThIUGs4eUlQbDNFUW1wem1kZE5EdFd1UGY3?=
 =?utf-8?B?VExOWTBHeDJ0amxiK0dwcWFHT2ZGd1d1OU5UNHl1K3hrWWZpWEFOaEd5M1Vv?=
 =?utf-8?B?MExlRDNUY0hSVjVOQ3ZnMS9aeEJDODh3OWtVRWppNEpNTXczV1BXeWRYN0Nm?=
 =?utf-8?B?Y2FjOERQTGl3OXFtL3VDdk1sdms3OCthNnd1dzRHK2VDQjFXa3JrcDh5bHh0?=
 =?utf-8?B?dTJVUnIxUnBWcVJJVmZJdHM4UXJ3VW56K2Yza1Z5VzBZNkU5V0t1ZzFDSXhW?=
 =?utf-8?B?UzYvaWIrb3h5MWVFcVhQY0ZVcTBpT1h6VWdMNjVEQzBXQjBWbHFVVHF5akZs?=
 =?utf-8?B?N2laMy9SSEd4T1pLQkZITStBUlZ4Znlhb3hWRTU5dE9UaUphZDkyUWdaR3cw?=
 =?utf-8?B?a3NNYUtrT2JDNUVoVmFHWUVEN0lHZGwyZXJEUVFiZHZFcFA0ZXdyOXU3cklm?=
 =?utf-8?B?ckdNNmNjTHVueWl6WW9ZcUNGZmUzWWZBL1Nod2k0TG1OWDF0QXY0U2tTMXNF?=
 =?utf-8?B?aWpUSWQ3UHdST3hJS0l5bGhoZ1BLVm1HRTE3QjBaQXJHd1FRb3Jvd2MzR3dZ?=
 =?utf-8?B?N0cxYVV4RGRSN1RycXdVTktXYUxGUWFnV0dVL3VtMStMalJhRlVMWjlnYVRB?=
 =?utf-8?B?ODlzaVVNdmhrMTZ4dmloQVpvdjJSUzZ3ZEszTFJJbWNpeGJvbVdYdDFWdHFG?=
 =?utf-8?B?S3FrL2ZnaHNpMHcxc2tNdXJxUFg1TjJDTHQvZUdjVE95TldldUhpdStwUVUv?=
 =?utf-8?B?V3hNa1FaaG9LNFpnOFF4M0JsTyswMnRhcUlMWXMvR2o0TjliSlltSUp4TWFS?=
 =?utf-8?B?KzRqUjlhbHh4T0FxdW1TMlFEcE0yekJiVTlUb3doRkd4cVdKTVBBcmVMQmtu?=
 =?utf-8?B?WFZYcHNSTVdkTXN4Mkg3aWRLTnZXTnBzNWh3OGl2em16WDM2cGtHZnlBbEt5?=
 =?utf-8?B?Y0Q2UWJ4LzYvKzlWejlkQXRFMjhKb2U2MTRRVEs5NnVXdDFsU1I2ODR6dW81?=
 =?utf-8?B?NVB5VGZxTHEzSmczUExpWk9CZWNobTNBYVFjYmt2dEZtZmRpc211MC9xdVZl?=
 =?utf-8?B?R0dPSG94dWluUDVxbHVrLzJSVi9XV2oxNHlhVnI5TDdWSDYzNDh1ekI5cGlT?=
 =?utf-8?B?VnNLdmQvcG1CQUFOZnBuWitXUTREaDcvNDh5VG40VUlROU1TREs3NXFTRXNS?=
 =?utf-8?B?SEpRVk03cys5cldyYWdUejN5eFNFbEZrSXJEMXk2Sm9zK2RRMFJ3K2Ewa2RT?=
 =?utf-8?B?MVVlQjEwNm1TMkFDQmRGWlc4OGhzNkRtS0k4MHg0VFVkZnN5emFveU1JZEZU?=
 =?utf-8?B?VXZ3dWpIeXA4d2tBWXpHalFqR2Y1ckJOTytZSW9FK0ZuVmpZajJHQlBaRHR6?=
 =?utf-8?B?M0pmZGZ1M3piYVY4elMwa3pDV2k2ZmQ4WURDbml6UU5EZWpVaDJtcVo1MWNX?=
 =?utf-8?B?cDkzQmxiL1Y5aUFwUmRXY0R1VTRlUVdZREZGbzFBMHBZYkEvejA0WEJMcTgx?=
 =?utf-8?B?aFU2UFFoQjdUeXBBV2NPM1RWQS9FSDJwODZDZGdyNmlFSm9Yc0c5dzlHM3JZ?=
 =?utf-8?B?T0RUM2Nid3g4QU1OVlR5dHg4ZGs3L3hmWjhwaThueXhyMUJaVGhmajRDK2RK?=
 =?utf-8?B?Q05wZVVGcDdqM1F2WS8reEtESzUxcG5qb3FuSm12d3FJZnZzaCtKRlU5MG83?=
 =?utf-8?B?c200UWZ2OHhGMHFJTitsUTJuZE85T1JIVkVSdDRPS0Rmc1p5K2NOSlFWRWM5?=
 =?utf-8?B?TE5qcDkzTWpkdlZiTkJNREt6NVlSNlJCM1BJL0hkTGk2bFFON2VsNmZMdVBT?=
 =?utf-8?B?RVBycC9kVFprd0VPbGgxZW9XdWRRbnVuSDJkbERzblRlOFR5WUNWeGhyMCtD?=
 =?utf-8?B?cThSSkNlS3pNRVloL2ErQlZxYXEyWWoxZ1JISkptWE9lZlJmLzlram1CNjZ3?=
 =?utf-8?B?bzZMYXNDQzlCb0gzTHpidU82eDlhcnpkazBDVElsdjUrQTZvNktjN2loYXI1?=
 =?utf-8?B?dkNEdWl6Zk1tcnI3bGEweWFadmxyWWNrRDdIRExQa0xPckxXN0FJb3Erb1JI?=
 =?utf-8?B?ekpHeXhLU2dWRUw0WTJ5dnRHYTQ2QjV4cTFQQllnZVJBVHVHTXI4NFJIb3RY?=
 =?utf-8?B?SHc9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b96db3-9aab-43f2-fad0-08de38c1d252
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 14:30:24.6497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7YJ/5bmQODiJ8STS9ira/ITXxv7RFvcwwsHCzWj288EG/kBqBas8PG36ADecU/2ZeKf2pdEem0x1XDOYATbM1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB6435
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
From: Kienan Stewart via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Kienan Stewart <kstewart@efficios.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Amir,

On 12/10/25 9:40 PM, Amir Najafi Zadeh via lttng-dev wrote:
> Hello everyone,
> 
> I hope you’re doing well. My name is Amir, and I’m a PhD student in the 
> Computer Science department at Stony Brook University, New York.
> 
> I have a question about the LTTng context that I haven’t been able to 
> find an answer for in the docs or man pages. Does LTTng support adding 
> the cgroup ID or cgroup path as a context field? I want to filter my 
> trace results based on cgroups.
> 

I think you're looking for the `cgroup_ns` context which adds the inum 
of the cgroup namespace as a context field.

thanks,
kienan

> If this isn’t supported, are there any plans to add it in future 
> versions, such as 2.14?
> 
> For reference, I’m currently using LTTng 2.13 on Ubuntu 24.04 with 
> kernel 6.8.0-87-generic.
> 
> Cheers,
> Amir
> -- 
> *Amirhossein Najafizadeh*
> *PhD Student, Computer Science Department, Stony Brook University, N.Y.
> File systems and Storage Lab (FSL)
> 
> *
> najafizadeh21@gmail.com <mailto:najafizadeh21@gmail.com>
> https://amirhnajafiz.github.io/ <https://amirhnajafiz.github.io/>

