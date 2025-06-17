Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A08C71136
	for <lttng-dev@archiver.kernel.org>; Tue, 17 Jun 2025 17:29:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bMDPl033Gz23Yn
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1750181356;
	b=D5NE5YufwZg5/jE7wQtTibIElmZov1bnwUD1asDvE13KlY414rMdkUdqI7ibTtoze6Gi
	 67On2yMaCmgIkyMVvMupn8quAALAKUT9qi/eWEkgan9aL4MR0xpwgklF0hb1bGDBvmRAA
	 JYkosTLdHR5pdLpI830vW8EGO3t6W+fVdSG/+HGfNHifhER0Atmb8FHcvQTnH+DgQBwnX
	 ToVO3IE28/a6ie1Hd5dsetHp+ibk61THpwqRD4yhBhhfObKPsXTlb5fPJ5TMO9H05meAj
	 y6o7r4xS9MTBHZ1iXvzIFELAGLSKhn7wiYF6AMba94W2xyZRqesExF5r7C/izxXQDug==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1750181356;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=YXDET/8BJCDfRnHrIrLc8NbkMvqJP1c4WcwR2Ao+pe0=;
	b=n/Ur6jdQxA86tZUk8K/1jT7VoQwXFACO984UtTLeBu/jsBtdo1VibjtlPQ4WUoL4/Ux5
	 aEm0noNRaf8eHHi7Fled9Ku4TpCbiyMBdlr9RSoYeriHpEz68Pw3Do+ts4SYgnLzqm7PZ
	 bJD2CWQrIvkGR8SDqaE5Rp8jNbBzyUrLkmfaHeCE2doKGIlKR306qauwkWG3ylclvT9ti
	 S8+83gSi9muC8t3kphTQRRV5/MEqfYqQm4yn+9EeW/1KYWXexFWiMjz/sF+w5Yh7+0RFw
	 B6koYep4HVj+8ZdtkUMmPUB2ImmN3D3XD4U4A3dtgqp0ck/moN81uLx6KT1WCaj/+7A==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bMDPl033Gz23Yn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1750181356;
	bh=YXDET/8BJCDfRnHrIrLc8NbkMvqJP1c4WcwR2Ao+pe0=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=xSaVXbSsYwg9VVn+AVNIdnulRkQ2AY8kFxq8htAiwwo8qurm52CEAHE+5Qb06hxEw
	 dsn1ysypWOKSD8Mx03suRLF9/J0ytZNoytelpgvotCSD2WSoIUlawCGKhQOWuiPTza
	 dpu3MZ+U1ASib2naNcxfNdvpSU+/YOKfLdAY33jBl93o07O12WQ0FW7d3mOMrAQTUx
	 S4sWVUvUaARUqc+8Xor6TEVGVFkrBMti0jPkwKZYiueyzeW1WeDrOC1NZywY55fZc1
	 ma4youPJu8hp2DU5su3LGGdXVSq1ViqsZ9jIdga5QfDV5UTxTsog/dl9spdjXa5oeq
	 nqkfmXGDGuekA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bMDPl033Gz23Yn;
	Tue, 17 Jun 2025 13:29:14 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bMDPj3RXpz23Yl
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bMDPj3RXpz23Yl
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2070c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:241c::70c])
 by lists.lttng.org (Postfix) with ESMTPS id 4bMDPj3RXpz23Yl
 for <lttng-dev@lists.lttng.org>; Tue, 17 Jun 2025 13:29:12 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FpgramilPuz902cE/cIERFtlAte+18q5OXpP++DQ6Ysnd73DY3t4wC+Ro0gKb3X0Npsh6IITepLPcOXBfnOiWj//CIB6QWNN/NjmJDvCqPVzeE5RgKNDxf0in8jsmfpLk6PzQkkAyuXu8yaR47JyWhOUit++ocS9ZZqmhKNt/wjSvoAJlUGpVgTzwoLLBqYUPflOxyKrJi6Dcu3QGwI7jKA788KOiVPJf3nILa8VeYor265JxkB3Zaz1hUiKFCvjVZOyZ98bLGZaHlL0WSEr/0dyXJ7bUVDzbbDAFzCBJjKI/OsJo4ngoxllPX+87rtBArLWSmikBJHkoey5mo3Kgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIoL8iJhtVXa5mkSwU6JG+86B3AwpOoKkBs4P9YKJFA=;
 b=bdyxmp77d+Uaq2M0taB7glsFKnWl5iKch3rN6Cczz/5SanlfJuJk4o5cXZLS554fmIn9/1/BkRIiqgZCc0rjMMDel3SX+RziebrA5IvRPcfyF26Z+dJ1jftRW8DUkuDuihAfCnmjYXX09Bunqw1NvgKSm87+8pj5GGI4yKNFsgsL+qDXWTv4qP8VNoQhqTscp2mwC9rl0qehQtmFdBnjgJgFJmpodZ36nGFGjTsIzxqla9r4Fl6oHHdrI/poojyBAXTRG89rRW6AcOSdMUWNyHxWa7Hia/kDMzTfqg9Lu6bCwFay+KiXU1j8ndEivUgnAiAtnzMAOmuuOmkY0X8spA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:5d::22)
 by YT2PR01MB8615.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Tue, 17 Jun
 2025 17:29:09 +0000
Received: from YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b5fa:c0e6:e5b7:54a4]) by YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b5fa:c0e6:e5b7:54a4%3]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 17:29:09 +0000
Message-ID: <c4c26d50-13af-42ca-abcd-78f3a8fd7b14@efficios.com>
Date: Tue, 17 Jun 2025 13:29:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: lttng-tools-2.14.0-rc1: fails to compile with libxml2-2.14.4
To: Norbert Lange <nolange79@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
References: <CADYdroM27zgM1RWHoCocru7VY6kHi1=g3PK4QJ0D67Wra1tc8A@mail.gmail.com>
 <30d81f2c-a2ce-47b6-b999-fb6f09f1c026@efficios.com>
 <CADYdroNushrX7E3ZR8LoKLpj0rrcebPo6iJTcKBTowUWAniQYQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CADYdroNushrX7E3ZR8LoKLpj0rrcebPo6iJTcKBTowUWAniQYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0217.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::28) To YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:5d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB6319:EE_|YT2PR01MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a8a0d4a-efa4-49c9-bc3a-08ddadc47778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3ZQTlo5OHliRXNVTytUZERsc1RDQUtKQTNvRzBsbHkrdEpySXBVYkpJYm5k?=
 =?utf-8?B?L1ZqU0RKTUFYTnVDbkY5cXY2VWx3WU9tN3dSRlJqRkdVQVdvaU1BNjRzQmJm?=
 =?utf-8?B?d0ZMNG5xbTZCVk13ZU8xdDBhUm52d3UyeitTTGlaUzRkUXZUVmUwek85V2FI?=
 =?utf-8?B?MkliV0xHSUdjQU91OGlBOGVTOE0zRXR4blJnQnBYUThQajV4N0ZtL3lZb2lH?=
 =?utf-8?B?MXVzeTlMc3lCNnZ5WGdSVDIxRVRZZUlWbWFML1BpNEdmaTU4MnkrSHFPRXNq?=
 =?utf-8?B?NWJwaXNJYWYxU3I5VTFBR1ZhN2JlcGRZSVZqeE5GT20rL2U2MTJ1VHhLZGxH?=
 =?utf-8?B?Vm1JYzRHMFIxYXQzR2h1NEwxaWFvdDhiM2Y4NTFUMmdiTjV5L0xNb3U5bFAy?=
 =?utf-8?B?ZGhrdHE0TzZJM05ZblUvUHhXSVRvMlR6QmZXTjNOMGQrL2VtREVueEt3a0Jx?=
 =?utf-8?B?KzJla1dmM0MzVVNEVDFnc21YeGt0QmFNVUlic3QyMDVLWEZZcXJmRWk0R1hi?=
 =?utf-8?B?L3NDN3BZclArMDd2b3NNSGx4eFlqdWN5U2piaHNYaWhCNmcyb2NzNFBLTS9j?=
 =?utf-8?B?UCt3bFB3cm1LdEFoQ1FhSmZFV0NqVFFmNEROVjUrdTJEM0pOMVhzWVowR2JK?=
 =?utf-8?B?T2JHeHBRYlBtbHZKN0tLU25HVWtRK1ZHdjlBYlU1WVJtZmEvU0FGR0EyMFd2?=
 =?utf-8?B?a3JZNzg5Nkd3UWo3VTU3K1VHbUt1OUZXUXE2WGMzWHJBa1BvVGRmbkFNK0J6?=
 =?utf-8?B?M2NXM1JIVnEwaHdCQVpLQUJmNHN4TVBJdTRNNWVqMXlDUjJ2dElHT29CT00z?=
 =?utf-8?B?Wm1kMTQrZjVZMlg4VEo2SjBvOGlnUGpBSFlyYUVHa3BweDFKWTduTWlYWDlG?=
 =?utf-8?B?WmdYdld4MHVibC8yOW5XK1lneHlzbEprc1NDczdDSC9PK3d5R0lWM2VkT2JX?=
 =?utf-8?B?U2txVGFpczhKR1pOL1IxU25ncEhFOXI5ZE02OE93b3RXRGRaVWhmQjVXZm9B?=
 =?utf-8?B?ZnhlcVRoWUFOSEcxYjFsZEZaMVZUK29BcnJTUlZpS2FpSU9UUXlzeHBPSTll?=
 =?utf-8?B?SmR4bzRTbnZrYmUyVjdDRnVhVVZUYnYrRlllQzF4MnRmYUFTbnBpZFAxZDU4?=
 =?utf-8?B?TmxHTlQ4aEdMT2lBSlVJczZGdkpuNjYwNituU3hTTm1ZSVkvR050VFhpbnhE?=
 =?utf-8?B?WC9vQmxLdFlNdTdzUWlQbVFXdlF6Z3k4TzdKaDdBRzF5UUtiYjJRN25mbUww?=
 =?utf-8?B?S0N6RUY5dzJZcmZ4N2JDcmxWUHd3ZktEM1ZQRUhXVzIxYTZsOGpBb0RkK29N?=
 =?utf-8?B?WE5LK0hFOFdHTXZJdmM1dDljcFU4WG8rRlIzNGVmRkJOMmlPYkFIOVQ1NjhX?=
 =?utf-8?B?U1BjSmxiTHVneXFoUENMNURPc3c3OWlGY1pGTjR1cklmbjRuRFJrNjBGekRZ?=
 =?utf-8?B?Vjl2L3ZFdU1TUmVSS045TGdPYWxoblBVOEcwMEs5S1BRQS9oS0EwOS9weDQ5?=
 =?utf-8?B?NEdBaWtQL2JYYkRqUnR2RGdQQnpHZEEwTGhkekVUOENIQ2laQWc4K1dYTU5S?=
 =?utf-8?B?VTlYaEZwaGJVL2tyK1owQ09jYVc0MWxXbXdiWndIRE1ubjREV1RrVjZRYXFv?=
 =?utf-8?B?UTJXc09ZNlJKbHp3dHpjUEQzS2tZN2dMaklrc0trOFJqdytlV3NnYTFyaTZp?=
 =?utf-8?B?bVlpeGY0aTZJdzR6emYxQml6ZzlyZzcyR3NyUlZaZ0YwTXZXZWZuUldja1hT?=
 =?utf-8?B?ajgxLzhsM3FWWHorVmxnSVM0ODVxZlRVV2R3UG1mSER6d2ZIZnV2RTAwdVo3?=
 =?utf-8?B?a1JDVVlTUy9ZQkdkd3Vrd3VvUmVZM2RSdFRrT2pNREVrb3FJemlqVzRiSDB2?=
 =?utf-8?B?MC9PLzlQMVY3WVFaSjFyU3JkYW5pNXp0RUJQYllmUUQwbTJ0WnMzaUdJbkpz?=
 =?utf-8?Q?O0dVlyHlvC8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXNLNzlPN0g1MHlJcis5WFVtcWNiemdaTVFDdFFnQ0pQQjVTdkJIUTlDTjkx?=
 =?utf-8?B?SVVqalFwejloSS9vd2poOW91TDB4dVE0TklJSkowLzRaeVlmdHlWckJNN25i?=
 =?utf-8?B?aU9PVEVVZmtUV2REckZneTdsMU9oWnhRTXNWSmZFTlJwcmJjK2Ira1h2Z2ph?=
 =?utf-8?B?VE9sRDBMYjF1eWRyYWw4UGtjdXMvMnU2ZGJOdXphNXdtaVk2SzhrMytBaTFF?=
 =?utf-8?B?S0l4aGRFYmwrQ0FzZXMzSndXUlVFQ1JGN3NLbUVObmNDU29jczNEdURMSGNR?=
 =?utf-8?B?VHFya0NlRFBSNHhNNlNJL2kyVFBkUVI4UmZNQzlvWVBoeHk3WWhSeUFUL2dO?=
 =?utf-8?B?c2hCdnFKTWcwZStES1AxVkJyTG5hY29meDljNDBOTDROc2s2UlVhRFRrNm5s?=
 =?utf-8?B?cytvWXhmQno4cXdhNmVPVi8wT0srU1c1cncwNXhpMnpHTWhNa3Z2MURFV3k1?=
 =?utf-8?B?TURlaUYyRlZjM2U3MDBSOWowK3BqRzhhVDNGWUVNdklQait2VFBpbWtaQU5Z?=
 =?utf-8?B?Q09PV21Hc2dnN0QvamczV0dnc3FnMWFQOVQwM1JQTHZESDVkWkpCbXhLZnl1?=
 =?utf-8?B?Vy9YN2dDbGx5OW1EUDRRd2J6dGlESVB4OXhIUU5pb05ZVGxDVUdVbFR0dWJi?=
 =?utf-8?B?cVVkQVJzVnB2UEltQmppVEJoMGV3YW5OWkZrOHNDbnlXdDlpNlJQejhzSVgy?=
 =?utf-8?B?M0JlT0lTbzlRVXk5bzhTNnFycys4bzg0ZmdTektVUjhGcVh0T21IVldwdlRS?=
 =?utf-8?B?cnltNUkzdkRrZXNXdklZdVZKVVZTdlhnKy9mckE3dW5oTlZSYUFxWW1nN0Jk?=
 =?utf-8?B?T3JGc3dJdzRZM3A2MGpyWGhxT21aNE5nOEYvblZsZ0FOMDZVTWViM25nTmlB?=
 =?utf-8?B?WGFRcERWSVRqZHE3andjVVhBeWNvV1dTUUhkNGY1MDRxK1Z6ajQyYWduRThC?=
 =?utf-8?B?UHJyRmNnTmNENnZwZWdncjdNNENqOVhQZi9aQXQzMXpEOFF2N1FmNXVwckNO?=
 =?utf-8?B?dnJudzNpNjAwL2xqajl5bCtRNk5BRm4vejUwTXE5b0ZwMXV3bmRaVi9ka2pm?=
 =?utf-8?B?YXdMcCtsdm12T0pSQnEyV3NCQnZQSHZWbjR3QWJEZ0pmV3JJUW5XeExvWUxn?=
 =?utf-8?B?NTc0S1dUanE1Y1NSZDkzSzBYOGEraE1ZM2FrQ0tGSE9CdGY4ZG9kUVI0V0g2?=
 =?utf-8?B?ZFNJbFc5QytqYk9uTDN4QjRBRkY0NzhWazdVc0p5Q3lTb2lFOWpadWxSeXFw?=
 =?utf-8?B?V2lCRXJBMjJGNnUxQWh2bllQcFR1dmhnbFpOVGY3YzVrSHZSQTBUUVM1V1pD?=
 =?utf-8?B?RUFtMlYzY1JhQlBJVWUreHVEQWZjVVh2aEY1Q28xcjI0TDhyNG5xZmo2cGJY?=
 =?utf-8?B?ZkVydVc5VXpPcjdaeEJXMXVRa1liSXFrQ0RjM29vaUFKOEJEb3VPRndwUzMx?=
 =?utf-8?B?QzhQTWRjbHBlOHdJLzAzNHpxM3NSTnRpMHMxaWZ5SEcxM1EwZDY4WktpaUlE?=
 =?utf-8?B?Q2FLSEVrWld0YUxadVRtZFFPOWFEZkw1YTVaeHBmK3RvU0lWTGg5QzJSMCtJ?=
 =?utf-8?B?WXlMOXJETGh0ZmJpeWtJTVhBVXNGVFBzRnlLSWhYVlNheWZrQVFyWTVFQWZo?=
 =?utf-8?B?ZmNQbHozWFAwMGtyZ0s4c0svZmJReVdmZVRWazBWMmNLcnM2VjhORlZSWEpa?=
 =?utf-8?B?OVF1bE01aTFiMW1aNExyaGs5WGFlL29LUlFHM3g2R1RXbHRLYzExN1NMMFVs?=
 =?utf-8?B?eWZ1OHFFdnQrTHEzc1Bqb0FpclFBRHRDUUZSbklPWFRzTkZvVkp3Q29jRy9x?=
 =?utf-8?B?M0R2MG5rbmp6aDZJTG13MWROZTZVRHlRbkYxN2gxa21xTFdxSEcrZnZjYU1I?=
 =?utf-8?B?bm9FZVJCSTU5dXhDWlBRRE1BUmhGcFBZNk81TjJtalA2Z0FyaHByR3V6ekVh?=
 =?utf-8?B?SHNYZVA1QWZqeXMwVFdsTWVGazc4ZC91QTdQYTlZVG1TQVpaVWJCUTVLMGYv?=
 =?utf-8?B?VUk0MkhxVDFqbTNzYm53Rm9ISTM3VUVKR3E2a3FiQnhBOFc5QUVGKzBuVEhJ?=
 =?utf-8?B?Z1JhejJUYXdVeUo4aTB0eDlZekUrR2M5QkFORk5oMHdIcEkvWWQrUURJYUw2?=
 =?utf-8?Q?QVMAmYekf8qbeRwNVChIo/DgG?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8a0d4a-efa4-49c9-bc3a-08ddadc47778
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 17:29:08.8450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /M0RXqettnvlllWrF9qckixEgGjbZfgUs6G4m4+bFkmNaixXEdWUjfH6WdR02Bv4PUbEgfuwLu7ThWlD4sJZvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8615
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

Hi Norbert,

thanks for the context. Using pkg-config is the expected method to find 
the link flags. It sounds like you are building in an unsupported 
environment, but here are some options you can try:

  * When configuring, use: `libxml2_LIBS=-lxml2 ./configure`
  * Use pkg-config and have an entry `PKG_CONFIG_PATH` for the directory 
containing the .pc for your libxml build
  * Use `LDFLAGS` as you are doing


thanks,
kienan

On 6/17/25 11:08 AM, Norbert Lange wrote:
> Am Di., 17. Juni 2025 um 16:50 Uhr schrieb Kienan Stewart
> <kstewart@efficios.com>:
>>
>> Hi Norbert,
>>
>> On 6/17/25 10:15 AM, Norbert Lange via lttng-dev wrote:
>>> /tmp/dev_develop_libxml2/usr/include/libxml2/libxml/encoding.h:173:7:
>>> note: declared here
>>>     173 |     } input XML_DEPRECATED_MEMBER;
>>>         |       ^~~~~
>>> ../../../src/common/config/session-config.cpp:297:75: error: no match
>>> for call to '(_xmlCharEncodingHandler::<unnamed union>) (xmlChar*&,
>>> int*, const xmlChar*, int*)'
>>>     297 |  ret = handler->input(out_str, &out_len, (const xmlChar *)
>>> in_str, &in_len);
>>>         |
>>>              ^
>>>
>>> Changing the call to handler->input.legacyFunc seems to fix it.
>>>
>>> Also lttng seems to need libxml2, but doesnt add the necessary flags.
>>>
>>
>> Regarding the "necessary flags" for libxml2 when building the lttng
>> binary, could you indicate clearly the error you have?
>>
>> All uses of libxml2 are via libconfig, and the libxml2 LD flags are
>> added to lttng via libconfig.la.
>>
>> When performing the final link of lttng, I see `-lxml2` in the command line.
>>
>> thanks,
>> kienan
>>> Regards, Norbert
>>
> 
> The error is, that I don't see -lxml2 in the commandline (unless I use
> the global LDFLAGS), libconfig.la does not contain the flags either.
> However, the Makefiles all contain them:
> 
> src/common/Makefile:libxml2_CFLAGS =
> -I/tmp/dev_develop_libxml2/usr/include/libxml2
> src/common/Makefile:libxml2_LIBS =
> /tmp/dev_develop_libxml2/usr/local/lib/libxml2.so
> 
> I dont use pkgconf, I set the variables directly (libxml2 is not a
> part of our production filesystem + compiler and right now I just
> barely managed to compile lttng somehow).
> 
> Regards, Norbert

