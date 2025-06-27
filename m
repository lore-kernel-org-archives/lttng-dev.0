Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB11C77B7F
	for <lttng-dev@archiver.kernel.org>; Fri, 27 Jun 2025 19:50:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bTR3y3g8qz13Zh
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1751053824;
	b=nqOpUHiE9Wnt2q5lwprnFsXyRp1QDnkSIdrXuyG7ZTR1ujrDxyEbzJ6UZAPkg/3SyQ1X
	 1gA/BoAmkblXjha9CxVJ8dR6DtQYAD0GBGJxh6es6oslXHATJR2adDALqLvs5WvWMJdja
	 sOLcEQFiDdoTeXefj/DzteGwmzZ980uzL6EBTkNOLVj348UZY8n6TH740EmiWUTme1izu
	 ToDZVSIc9CLU4eHKx0S74dl/9cNWT7E/i6hTIq9z8CA6qJ6zUMJgCvaVPoYoub6/sy5sH
	 54XhTRN6D/qt9ILCZysWWyo+vOJRmsjkLFWXLEDTAoRH924g80WiRlkrRWqbQRsw6oA==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1751053824;
	h=DKIM-Signature:Message-ID:Date:To:Subject:MIME-Version:From:From;
	bh=nqeDemHK4PovA9NLIzr4ouWfXBJpIWOBrc5cdxJMlfM=;
	b=Y1iz2/vwg3Kwwnmzz2wRikAyThvCQm8ydKyQWpv5uhY5NWrXjqB2oXxzoe3myV4gBq0m
	 5TpXpOFelMC6WweIvi4uavfpIXlMCqxo5pjj/v2PfIvgUVP69cofzjbFGpxB00Lhar0KQ
	 UmFIUYEd3Xrscn1kVPmzx1H6u0Ojnm2sz2gAajywqA+FmJew20CpBEjtUjWgu44s5jOmm
	 7BUFrn2akXNLqyWchsxkGsPnOfXKIfjvf+V/ASJEd8bcm4jEMB/Nfewb8ILuE7sgYSUCt
	 oE2TSZC97NF7Rd+j6RjF9pRaTUMnpk1/BeZ3w/qeFmbYSWxfPoFh6MYd9j9dRws5B4Q==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bTR3y3g8qz13Zh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1751053824;
	bh=nqeDemHK4PovA9NLIzr4ouWfXBJpIWOBrc5cdxJMlfM=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=LiQiQ97TqvBrEvJGX/aFota4GMeY6ZwQUM1adVLHGzqYziC0sl8kbZeXQJYZWH9sP
	 kuf163nDQBdV7ybYo2t/SNQvYbQ55qJc3VsOR8+LIE0YeIY6jJxQJzL9cFpDJS47bc
	 tX1bD8Rexv7q/ywx2f1QoDVk3DpGj8CJhIEYCWOMe0+/9o8RyrB6xuN+PJcFi5AX7X
	 f4WUgiqDsS1/wTSODaYWbvIUbFyZ+d+a4NqVKof3B2rcec2NZtOjJiNGLDYpagP3GW
	 IN3PPWEqzQP+B3mII3QjTsKtpRPKcwlhNT6jX/KwUI2bqfFO7DMVd7Fj3wqPryL+o8
	 s5Lp7InYZsfPA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bTR3y3g8qz13Zh;
	Fri, 27 Jun 2025 15:50:22 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bTR3w1YWWz13Wv
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bTR3w1YWWz13Wv
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on20710.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:241c::710])
 by lists.lttng.org (Postfix) with ESMTPS id 4bTR3w1YWWz13Wv
 for <lttng-dev@lists.lttng.org>; Fri, 27 Jun 2025 15:50:19 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMWqT4IqCBE1uK2ya6f/ULJg/+bcOWVkhNioQO/kKeAEmqtlYVPKCvjlu2l9Yr8WNu5kDQh5U4GpZnM76ojT0CTgUs63yV7K2ZJ16YtmK3AIjFtFy2lJvCB2AMFMeDl+lJBAvuWyi5ylKZBdACemdPBA2g3Amswi3IKRnLRZ5V/MspRganOY8g5klxfqwQu67I9oi1iYSgzITV/qNg3ihv/QyPpMTA+LegNi+jjRGRomf9vfQsUY7YpcgBW2gnqzMzx1ma2CKjNYdBrWTYFzhf0aWqL+zs5WNCESqdpqB4575c3KOb6fQdYPJ3++80BM4VxHsNVKqyMCYfE4WxJlTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIQ3Hcb+sskZIBVt9z6e4lNfMUKh3+WaNjxXEHTIXYk=;
 b=M6sM7eoH1F25raWcNk4pRNU/8hNFJTsK2OjMXYKHVQqUWjk4Bs6/841UfQ4lIMnTNgioINcUsmupWpOo1wOn2feKQRuzdC1tkZAIyASaXwWVZkP48T2pMbegiXNOzGoN59ORe4qIyZTtH7ovuZ2EnMAwodLlIZOYM0Vwy+ylRF5tIlS7P96Wp8WnRuJESxezH7DdE/i6E7doCaJUMwYLn6TmImccLoIPfb0Ko8G/MRLI9IaVuRbgGxUKQxwt+Kax30kJtJyhYDEvnLKw4Y8vEFnUoOFdhoWe2n7WHRKbGXlsyuvhaySbFmJJlDYibOLPA4PTAh8rXM7EEqGXnbV2hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB5323.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:41::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.24; Fri, 27 Jun
 2025 19:50:12 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8880.023; Fri, 27 Jun 2025
 19:50:12 +0000
Message-ID: <965dab1c-7dfc-4502-bc63-933bd0859abb@efficios.com>
Date: Fri, 27 Jun 2025 15:50:10 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev@lists.lttng.org,
 Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>
Subject: [RELEASE] LTTng 2.14.0 - Orbitales - Linux kernel and user space
 tracer
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0101.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::20) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB5323:EE_
X-MS-Office365-Filtering-Correlation-Id: 62d50a10-5593-4cd8-104f-08ddb5b3d406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dW5YUUluS014MGMrelZKTitadHUvWDV5MFBIdjBISyt3SjJpMDRyOG1WekxH?=
 =?utf-8?B?bk1qajhKamgyTDVWRWg3L0d5KzVEanJvK2JPelFMY2tYWityQW9ueHRUOW5m?=
 =?utf-8?B?cFYxbGtVRVpvenFsblpTUm0xelVFdGQwRUNIeXp4U1poZno4MTVwY2U1NVVs?=
 =?utf-8?B?WVhYTzRLZUtVSTJFYzlEa2I1QXB0d2pRV2RXditVL3dFY3poenRLamZPdUlz?=
 =?utf-8?B?NHJvZHJhM0lzLzNpVTVoWWpKYkc0NGs5cE8xeDFUSDZZSGdaaGxpQVkyMGVK?=
 =?utf-8?B?bjhWUUY1VlBqUWJlUG5rTjZNL3FhelozRU92elBjcmZsMGd3MHVEcGpVY2JO?=
 =?utf-8?B?Q2U5TlpwUTN1N3p0SzFaWHkzTDdveFlLd2hlYWNob0QrYmRJd3FqdTFGb2d6?=
 =?utf-8?B?Zm9YdE1CRWl1U0ZVZE5EMVo1WDg0cHhZbUVRejBQd2laOHViUEt3TVdYQ0hq?=
 =?utf-8?B?TUY0cnBLNkdabHJyWW50LzNHekdBeGNod1A2RmcvcFBkZEFTKytjWGVIb29h?=
 =?utf-8?B?WnNuKzBONWJYdkc2Nk11R25WSVZtdVprM3ZvZUlRRS9YUnI4c1RSRi8vdndp?=
 =?utf-8?B?cEY0dDRjR2x6RmlIQ2pKbVpTalhsL3JLTWhSVGFkU0luaHFUU1dCUHVWNmlp?=
 =?utf-8?B?WFMyelJiWHVKWllFbVpPbkljUlBEb0hYZ3puYm9oc0l5czloTWU1RElrNDBs?=
 =?utf-8?B?VmJyekFCR3A1dHFFdll1MENRNXRrYno1bTJWR2s1azUzMWlWZ3NJMWxsa1hp?=
 =?utf-8?B?TVh5TWZUcWpRemtoUFJIbEgwMnpBOSsrWTlaU2N0TExBWDJqczJ0aG5Ed29y?=
 =?utf-8?B?NzhyeHBId3Q5WVZRMzVtbnVtM2JlaVBDL1N5WDZ0MHZJZ1lpTnZQazdhdy9X?=
 =?utf-8?B?b0VPeEs4dnBKY2o2TjE5aVZlM2p2eWlkM1V6TGJaYSsxOWptY05oekF4NnRv?=
 =?utf-8?B?UWJwVE9oUkJROXZMYklWN1c0OVlCUUZIYWpKRlJ4OVdzaXdtT3BxVFoxWGhr?=
 =?utf-8?B?VXdpcWVWcWhKNkd0RTd4MmM3cXgyN3dmWnFCYndlU2ZPRW5zK2ZGR3RpQTJx?=
 =?utf-8?B?c2hkd01LUm4xSTltUkhabUtVcU1OWDArem9xeHBHSEFhSE41dDVOMGRQenJB?=
 =?utf-8?B?SWF5dGUxSnAwVEZnZ2xJQ2lqVXRWTGhqcFMwdElqeEhMY3lIbkx6bk12WlF2?=
 =?utf-8?B?N20ySzVBeXRYbDlYVndKM2dHMkl4cG5MaE43cElDVERwand2ZFdId2tGRi9U?=
 =?utf-8?B?UXZTRlZXYlJZTVRiU3RiQUs4U0ZVai9kNmwrWlk2aEtWc0VKV2ZHWTBZaUlw?=
 =?utf-8?B?OW1vRWE1eHlKYmliQlp6OE8ydG5jQ3cyQXBPdW9aVjVjVWI3WEozSDBGbDRo?=
 =?utf-8?B?MUtDMW9KY01KbXdHY1dOeEVUVUl4ZlpGUmNuSnFlOG1vek9LZHJubkU2Qjc3?=
 =?utf-8?B?ZTVpY1Q4MjN5L0Y4ZjNHc05VVmt1cU53b0R2UGVMV1l1MjBsZ0lXelBOR3k0?=
 =?utf-8?B?TlNRYk1zM3YzVmZQZXYzRmFsazdQaUNOaEYrUk9NaUYxb2cyS2NCd2pkWi8r?=
 =?utf-8?B?MFVxVXBLUHZaK1NGTXVpeWI3bEkwMG5Nd25jeEJXQUhWaVpDQk1IQU5VZy9t?=
 =?utf-8?B?emVURGovNStnVVMvRVFVa3N4b1ZpNU1Ed3dzSWF0YVpEZXZYdjJaNklncTkw?=
 =?utf-8?B?SEhpa1E3clo2Rkc4V3phdjJzRFhlY1ROTUFsYk1LVTZraXpvT0I0blBRL0oz?=
 =?utf-8?B?V3BRYm9PZFJjZ3YrWlhVa3dyMUVYTjJ5T00vcVhZVTJ0aUFQL2J2TVh0cjVz?=
 =?utf-8?Q?L+SScBeh5Gdql19GNX6D3VNL509icLYG7RYIY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk0wanNzUG9sa0E3VXdvVHFhU0Q3TlQ3UEp1Ri9rWnNUSEg4STJEQmJ3WEhW?=
 =?utf-8?B?Ulphb1FNWncyU1EwSkxzT3lmL1cvREdzZGY0Ymd4R2ZGZytjSDBONDlqOFlp?=
 =?utf-8?B?MU9VeGVLVTNwaDIreEMxK3AwU2pybnZmQWxMVXgyTWFBeUZlNzdxRkQrd2Y0?=
 =?utf-8?B?ZEtpRXNsZ1BVZ2lNSTFvU21id2YwckJZZk5kTGpRYTN6MjNJU0g0ZUw5WVha?=
 =?utf-8?B?OXhIemp5WEIrZHpGRnh3QU92S3Z5MXNLYTNFbHdFeWpoQUdBcWtiWDN6US9w?=
 =?utf-8?B?d0l5TXp3WFRXVDVrdFA2VFQ0d2VhMERRN1pQV2tMZTliTFVyN3RLUUtUUkNl?=
 =?utf-8?B?cXA3d2xmWXZGcTVrNERBclBZai9xbzFZcjFWdVc0SUdIM0YxajZTUFpjN3RB?=
 =?utf-8?B?ZXZ2UmJBOUd2NU8xMFR2YUVtOU5RcmU0d3dwM0xBZmptaDVQVXY0THNkaFcy?=
 =?utf-8?B?aTJaSWlEZ1VwWHBBWFNKTkk3c3EyNC9mUklVam4wYW16U09wQ0YwemN6UG9m?=
 =?utf-8?B?SmZGM0VTaXJYREI5L2tpSGQ5Y0RCTUcyNFNhMjRvU0lnVTFEVEY4UEEwd1I3?=
 =?utf-8?B?dmFJSUZDNVNIK3RRenlHOTNLbVNHcXR3T0Zxa2prU0djVGpyYlE0WHJqR1BI?=
 =?utf-8?B?WHR6L1ZZeW1IbGRFUUFlbkZ1UEZOc0lGMU95RDE2MmF2OHQvYWp2OFhacXFT?=
 =?utf-8?B?N0dyQ1kwUHc1Rlh3SDhDcDk4dENFZTNxMUVXZ3N6WGZMbnAzelR0MlgrNGx3?=
 =?utf-8?B?UHgvSHZPa0RWUS9ZY24wMnM2RWRaQ20xQ3FiRlRPZUZpUlpEdjBocjlhWE5p?=
 =?utf-8?B?QmlWYjFWRVcyUnZCMFh5TGZEaG9BYThRY1R4TUI5NnBMdzlYcU5GOGRNQXpV?=
 =?utf-8?B?bC8vaWwwQ1JPcXpDdkNVOGRPSUxraVQ3djRwYVM5Tmh0dDVCNVpPaXhpSFVt?=
 =?utf-8?B?RVNZUzNSQ3U4eGNVdkx5Rkc2ZWF2MmlUUk02cHlaK2ZqcTY5THdxUDRudXZB?=
 =?utf-8?B?Z3Y2d1YrWElJRlM2czRLUTQ2eUhZc08zMHBqT1RPMm5kZVcyUlczRS9kQUsx?=
 =?utf-8?B?MENqUEM3VUZDYmM2ZHUzdk5zQUxWMG1aLzI3a2Z3RmQ4Tjl0V3gwNytpWDlm?=
 =?utf-8?B?MzBGWjM3U0tzaWVRMkdZbm14WW9YRUhoZHZZKzd6YTNDNnE1RFBQT0NqMnlI?=
 =?utf-8?B?WklndkhlbU5aeHdqbmxMbVhOanpBRkRXNHgyN0gzVG0vMDhyVnVxNmJDeGJD?=
 =?utf-8?B?Yy9TcTkzZnpldU5mYkpBY3RCaHd3azBaSk1FV01WL3dvL01UYmFvY2hITDBE?=
 =?utf-8?B?RnRiNTFtZ2V0N08wS09zZ3NwdWFnWG5yRVVQOE5xT1YvNUY5SFhabE9WQ3F6?=
 =?utf-8?B?WFdGbk5NOWVORHg1WUltMGFzNGg3bDMwRWdORzRFQzY5dUQ2OXFKc25lSGJF?=
 =?utf-8?B?RDVpZXNQbmJ3ejBNeEQ1SnhONCtkbU9keW5uSG1oM2dEZXpFa3J4b1g3MHNW?=
 =?utf-8?B?bmJsemlnUXd4OU9tVHZueWhNWlNpalVvbmpJMTFoQks5S0JQbUV6bHNYNWZt?=
 =?utf-8?B?NEl4MVNNM2hJYnlQMi93am00UUk0U3UvK0NJVjJkL3ZKeVRoOUVJNWtqYXBO?=
 =?utf-8?B?ZjhMMmRsd1pJc2x6RFNHV3dKaU5wVHhna2ZmUUVHTHZtbUE5OUkrQndGVXl0?=
 =?utf-8?B?cTFjbzBOSDhBUzNYSFdjRWNCRzZjdWYyc2lBZmdJUHJMc3B5UzBURE5YWjFn?=
 =?utf-8?B?YlN4RUVOUFI4MWFtYU5WTVc4OE5hSEtRbFZ2a2hTR3RGZ3FTdEVNN2Z4VS9s?=
 =?utf-8?B?WldGalErVlkyWHcvM1Q3WVJ2ZUpEdmMvclA5dGVoK0ZCblB2bW1UQUNJWjFK?=
 =?utf-8?B?SkFLcElGMWlMdmFlMzNsMW5iOGd0UHlBbjZUSmJvMzk5K3RrZVhEckN2YWxQ?=
 =?utf-8?B?VU55dTB0OHd2WUZzcEFnOExYTGNGNmloNlc2RllyeE1BYVZUWGJ0R1o2aE1v?=
 =?utf-8?B?UzQ2enlpU2JmUFNNQlFhMmIxdGtpQTUvS3hxSzhrVlc3eGQxSmdrSjVrcjhN?=
 =?utf-8?B?enovUjBYeXJKVWJVYUFkQkxKUkxENDNPWG5FazJIY0FzZUlwUzFjSjc5Wnh0?=
 =?utf-8?B?OG9WaWoycjF0Yk50eXo1KzVsV01qVHoxank0SjlBV3RxejFSeTE0TkZFV2xW?=
 =?utf-8?Q?w7Gr739U6RNM4mPAeLtgYSc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d50a10-5593-4cd8-104f-08ddb5b3d406
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 19:50:11.9453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onUJNRcu19zSNkFelNc9tnhOSVowFrtrX8R7+vWJnpg1U9jdiPa3fvR0drw3MnEpLFPzYkDF3wVbRmBrh3J/WmFalrms5BmwB+sTqn1htmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5323
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lwn@lwn.net, linux-kernel <linux-kernel@vger.kernel.org>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi everyone,

We're excited to announce the release of LTTng 2.14.0, codenamed
“Orbitales”!

Four years in the making, this release brings a host of new features,
improvements, and experimental capabilities for you to explore.

WHAT'S NEW SINCE LTTNG 2.13?
━━━━━━━━━━━━━━━━━━━━━━━━━━━━
New features and changes in LTTng 2.14:

General:
     • User space channels now have a _buffer allocation policy_ which
       specifies whether LTTng tracers allocate ring buffers per CPU
       (what you've always known) or per channel.

       The buffering scheme term now refers to the ownership model
       (system, user, or process) and the allocation policy together.

       The new per-channel allocation policy means each user/process
       (depending on the buffer ownership model), instead of each CPU of
       each user/process, gets its own ring buffer.

     • User space tracing now supports the Apache Log4j 2 tracing domain
       in addition to the existing support for Apache log4j 1.2.

     • LTTng 2.14 brings _experimental_ support of CTF 2 [1] for both the
       user space and kernel tracers.

       CTF 2 output isn't enabled by default and is intended solely for
       preview and feedback purposes: having an experimental support will
       allow users to test and evaluate CTF 2 until we make it the
       default output format.

Tracing control:
     • The new `--buffer-allocation` option of the
       lttng-enable-channel(1) command can set the buffer allocation
       policy of the channel to create.

       The default `per-cpu` value is what you've always known while the
       new `per-channel` value is available for user space channels.

     • The new `--buffer-ownership` option of the `enable-channel`
       command of the `lttng` CLI tool replaces the `--buffers-global`,
       `--buffers-uid`, and `--buffers-pid` options (now deprecated).

     • The `enable-channel` command of the `lttng` CLI tool, when
       creating a user space channel with the usual per-CPU buffer
       allocation policy, automatically adds a `cpu_id` context field
       which, as of LTTng 2.14, you cannot remove. This has always been
       the case and remains true, but `cpu_id` is now an offically
       supported context field.

       Knowing this, with the new per-channel buffer allocation policy,
       the `enable-channel` command doesn't add the `cpu_id` context
       field: add it afterwards with the lttng-add-context(1) command if
       needed, for example:

           $ lttng add-context -u --channel=my-channel --type=cpu_id

     • Everywhere the Apache log4j 1.2 `--log4j` option or
       `log4j:logging` option value is available with the `lttng` CLI
       tool, you may now use resp. `--log4j2` and `log4j2:logging` to
       target the new Apache Log4j 2 [2] tracing domain.

     • The `liblttng-ctl` C API is updated to support the new features:

       ‣ Set and get the buffer allocation policy of a channel with
         `lttng_channel_set_allocation_policy()`
         and `lttng_channel_get_allocation_policy()`.

       ‣ Add the `cpu_id` context field to a channel with the
         `LTTNG_EVENT_CONTEXT_CPU_ID` enumerator when
         calling `lttng_add_context()`.

       ‣ Apache Log4j 2 functions and enumerators are available
         everywhere there are Apache Log4j 2 equivalents:

         ⁃ `LTTNG_DOMAIN_LOG4J2`
         ⁃ `LTTNG_EVENT_RULE_TYPE_LOG4J2_LOGGING`
         ⁃ `enum lttng_loglevel_log4j2`
         ⁃ `lttng_event_rule_log4j2_logging_create()`
         ⁃ `lttng_event_rule_log4j2_logging_get_filter()`
         ⁃ `lttng_event_rule_log4j2_logging_get_log_level_rule()`
         ⁃ `lttng_event_rule_log4j2_logging_get_name_pattern()`
         ⁃ `lttng_event_rule_log4j2_logging_set_filter()`
         ⁃ `lttng_event_rule_log4j2_logging_set_log_level_rule()`
         ⁃ `lttng_event_rule_log4j2_logging_set_name_pattern()`

       ‣ Get the status of the Linux kernel tracer
         with `lttng_get_kernel_tracer_status()`.

       ‣ Get the shared memory directory path of a recording session
         with `lttng_get_session_shm_path_override()`.

     • Set the `LTTNG_EXPERIMENTAL_FORCE_CTF_2` environment variable to
       `1` when starting `lttng-sessiond` to enable the experimental
       CTF 2 [1] output format.

       With this setting, all the recording sessions which the session
       daemon manages produce CTF 2 traces. As of LTTng 2.14, this is not
       a per-session configuration.

       The produced CTF 2 traces are expected to be semantically
       equivalent to what the tracers would have procuced without
       `LTTNG_EXPERIMENTAL_FORCE_CTF_2` set to `1` (CTF 1.8).

       ┌──────────────────────────────────────────────────────────────┐
       │ NOTE: A client of a session daemon started with the          │
       │ `LTTNG_EXPERIMENTAL_FORCE_CTF_2` environment variable set to │
       │ `1` cannot create:                                           │
       │                                                              │
       │ ‣ A network streaming mode recording session.                │
       │                                                              │
       │ ‣ A snapshot mode recording session where you send the trace │
       │   data over the network.                                     │
       │                                                              │
       │ ‣ A live mode recording session.                             │
       └──────────────────────────────────────────────────────────────┘

     • The `--all` option of the lttng-start(1) and lttng-stop(1)
       commands is now available to start/stop _all_ the
       recording sessions.

     • The `--glob` option of the `start`, and `stop`, and
       lttng-destroy(1) commands is now available to start/stop/destroy
       recording sessions of which some globbing pattern matches
       the name.

     • New lttng-relayd(8) options are available to help control
       its process:

       `--dynamic-port-allocation`::
           Let the operating system assign the control, data, and live
           ports if their respective option is missing (`--control-port`,
           `--data-port`, and `--live-port`) or if their port number part
           is `0`.

           With this option, `lttng-relayd` writes the `control.port`,
           `data.port`, and `live.port` files, as needed, to its runtime
           and configuration directory (`$LTTNG_HOME/.lttng`).

       `--pid-file`:
           Write the process ID (PID) of the `lttng-relayd` process to
           some file (like the `--pidfile` option of lttng-sessiond(8)).

       `--sig-parent`:
           Send the `USR1` signal to the parent process to notify
           readiness (like the `--sig-parent` option
           of `lttng-sessiond`).

     • You can now override the path of the directory where
       `lttng-sessiond` places special files for user space tracing
       applications with the `LTTNG_UST_CTL_PATH` environment variable.

       See lttng-sessiond(8).

     • You can now override the path of the directory where
       `lttng-sessiond` places its control files with the `LTTNG_RUNDIR`
       environment variable.

       See lttng-sessiond(8).

User space tracing specifics:
     • You can now override the path of the directory where a user
       application instrumented with liblttng-ust looks for special
       registration and control files of `lttng-sessiond` with the
       `LTTNG_UST_APP_PATH` environment variable.

       See lttng-ust(3).

     • You can now override the policy used to populate shared memory
       pages within the instrumented application with the
       `LTTNG_UST_MAP_POPULATE_POLICY` environment variable.

       See lttng-ust(3).

     • We improved the memory usage of lttng_ust_tracef()
       and lttng_ust_tracelog().

Kernel tracing specifics:
     The minimum supported Linux kernel version is now 4.4 instead
     of 3.0.

WHAT'S NEW SINCE LTTNG 2.14-rc1?
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Session daemon:
     • Fix an erroneous consumer daemon exit code report and an incorrect
       “end of list” check.

     • Prevent a crash when shutting down early with the kernel tracer.

     • At run time, now verify the `liblttng-ust-ctl.so` version.

     • Restore build compatibility with libxml2 2.14+.

Kernel consumer:
     • Silence a spurious warning on 32-bit builds.

Test suite:
     • Many fixes and cleanups (`HOSTNAME` variable validation, duplicate
       system call handler, typos, and the rest).

     • Skip or adapt tests on ARMhf/ARM64/riscv64 and 32-bit kernels.

     • Eliminate hangs (ppoll(2) overflow, health tests, and Python
       logging failures).

     • Timing TAP tests now work in out-of-tree builds.

     • Add Python 3.4 support to `trace_format_helpers.py`.

Documentation:
     • Fully document most of the liblttng-ctl API with Doxygen.

       Error query and recording session rotation/snapshot APIs are
       partially documented (usage, not the headers).

       To be documented: process filter and recording session
       save/load APIs.

LTTng-UST (Userspace Tracer)
     • Fix discarded packet and discarded event accounting in
       high throughput scenarios.

     • Hide experimental trace hit counters code and symbols
       under CONFIG_LTTNG_UST_EXPERIMENTAL_COUNTER define.

LTTng Modules (Linux Kernel Tracer)
     • Fix discarded packet accounting in high throughput scenarios.

     • Serialize CTF2 enumeration mappings.

     • Fix: NULL pointer dereference by using nonseekable_open for
       the '/proc/lttng' file.

     • Fix a type confusion in the recently introduced
       ring_buffer_flush_or_populate_packet.

     • Update to tracepoints, and to sched, ext4, btrfs, mm/writeback
       instrumentation to support v6.16 rc kernels and re-enable
       specific tracepoints that changed name in kernels 5.2+, 5.16+,
       5.18+, 6.5+.

VERSION NAME
━━━━━━━━━━━━
This release is named after “Orbitales”, a bold creation from Noctem
Artisans Brasseurs in Québec City.

Pitch black and dense—one team member compared the color to used motor
oil—this beer offers an intriguing sensory experience. Aged in wood
casks, it delivers rich aromas and flavors of blackberry as well as a
hint of acidity. There’s no head to speak of, but a whisper of blue
cheese funk lingers just enough to keep you curious.

IMPORTANT LINKS
━━━━━━━━━━━━━━━
LTTng tarball:
     <https://lttng.org/files/lttng-tools/lttng-tools-2.14.0.tar.bz2>
     <https://lttng.org/files/lttng-ust/lttng-ust-2.14.0.tar.bz2>
     <https://lttng.org/files/lttng-modules/lttng-modules-2.14.0.tar.bz2>

LTTng website:
     <https://lttng.org/>

Mailing list for support and development:
     <https://lists.lttng.org/>

IRC channel:
     `#lttng` on `irc.oftc.net`

Bug tracker:
     <https://bugs.lttng.org/projects/lttng/>

GitHub organization:
     <https://github.com/lttng>

Continuous integration:
     <https://ci.lttng.org/view/LTTng-tools/>
     <https://ci.lttng.org/view/LTTng-ust/>
     <https://ci.lttng.org/view/LTTng-modules/>

Code review:
     <https://review.lttng.org/q/project:lttng-tools>
     <https://review.lttng.org/q/project:lttng-ust>
     <https://review.lttng.org/q/project:lttng-modules>

REFERENCES
━━━━━━━━━━
[1]: https://diamon.org/ctf/
[2]: https://logging.apache.org/log4j/2.x/index.html

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

