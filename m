Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B7AC71157
	for <lttng-dev@archiver.kernel.org>; Tue, 17 Jun 2025 14:50:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bM8tM3d8vz22X0
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1750171819;
	b=cFe14vS60c6gGp1LVNmEPRu5yFhltmLcb1LIa/mcoVBQ+M4hm367Ab2HkNv9OfCVMOpD
	 n76KiMh8e6NW3F23ulP0/8pTS5USZ28QZ6MWEmqveBLb2Kbbh0rJ6eqg8hqbO49hipckV
	 V1fffJR1wqpzh+beRxmDUlfBKeXjeL1Y9nrCN+0wKkop8xg3GIJHyrY+WQiFfstYtaG7F
	 CexRW4O6PDR8loUs3wQ4I04xed+ifQDH0Rv0aqCUMN4gc8BcEMP2HAWNov07IyUKwkWG9
	 5v8ifOMjvB5REHPM4FlHY64IiKAZuRxEuvfJU6TSvqe80jmroDve1ePaa2IHnSx/jXQ==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1750171819;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=1n/F7V8s5H3dT3dbkJ1mWMNEz+PPYO3y+gOfDvwrG14=;
	b=TCqmo3vBz8t/tNz7oUV7mqRx/0i4q+K7eamIkMJDjQPSqX+EC3GTTu1wYKxhfzeqdtJ3
	 VBkeP4cOuYAqwFbjcNN/0Vwec9JZBMwp62LUqBi0928+LxbtvWO6Xf0e+tP3DwhFdZmJU
	 x1PpqlgJSfEHES176FmQGBKOJNu8aXhaWUDGmr0FkGWCsFCsRuCWJF8h/gXfGh3XjdO43
	 pGTrmVJm7tdlnJW7LjxcmPulnnT6ZAqasptkxl4xSGXP21sbLbHaFqlnif0CKgzdf68f6
	 q/peHHNQfeRFtWClSWNKDNJEY56Tlumqww1mfE35qvHdeztFzsYPH+5K4wQjYfqaLbQ==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bM8tM3d8vz22X0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1750171819;
	bh=1n/F7V8s5H3dT3dbkJ1mWMNEz+PPYO3y+gOfDvwrG14=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=PNm8cE1Q4osTzkr0Ifrv0gLWSrLOOO2p3+zQZKTR5vIaVOLgNWE2YAEv+tfWjSES6
	 WqOnp4axDRXaLAJ10ccCLwFx07O2ThznBARgvu/T8zawptxBeJZ5EjOKyCUkLwbJ7w
	 8OIkvbE+t8VOxpjxso6eSlCpXhuonNN5pXYgaW6W+MYq2tcDj/V1t7geHVg9m5wKF/
	 uqDCr/a6IMtbnsJg8L267mjg8g0RKC8t/xGCO1H9+kYVHsQ9+JGq2U6i/yaKKbTdkx
	 y1rOOZZQ9dE9NMvxhf7QjUI7iScMNQDAjz167tlAe7uVDFIXeTPAGQmpIjqEfTIi1x
	 cL071myCkzMWw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bM8tM3d8vz22X0;
	Tue, 17 Jun 2025 10:50:19 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bM8tL5wCDz221Y
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bM8tL5wCDz221Y
Received: from YT5PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazon11021085.outbound.protection.outlook.com
 [40.107.192.85])
 by lists.lttng.org (Postfix) with ESMTPS id 4bM8tL5wCDz221Y
 for <lttng-dev@lists.lttng.org>; Tue, 17 Jun 2025 10:50:18 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pf85JjaN6YkfwmnwLyWdiKoPar2Yv+Dob86exagbChRYC3pVWPsjGxBx0lVNwPNgvZ+xm+wy0jx28id0KzjbNgUtL+DDI/AKpHV9FhBMnKptXlStIeznE0X2Siwg+OJQVcWkSFJ1BEZXP4AHZAr1MYoixLCLIhkjOWG+sD8OHrmOa1aAGD+Rs8cpXXPur1eM+AIRoCMLNLrPa1LK+Wo/BHv88G73KANH7vLHQ851kq8CP2KkC6IC678eXJQthrx1WQSGvujCC55XHY1XpnEfPHUaUp2PAs0hleVLfZT435Ls2xQKifJyqsM1bqu9+i4lpyhjH+3DynJZAmDbwJ/tHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+t4tJGU50tPCZpieHpfKPFoq2Q2UX7w3azUUWNlMF1s=;
 b=pIJWNvHiKLDIZsHPvfltqCvUEEiISUaYOkZO2z7l8pzL/mBuEi1WcJAuVN/Yp+fxpDMwxrvRRhcea70Ucp4NM00qeGANlvgIcB0rcDp5kk8oWhP7xQi6+Ca/eGhwZts25LilHwfpha87/R5bgStTf8GoIpEZljuLML6yQ9907WVYDwsav6lubwu4Or21eRcQrpKtUwN3n3uE/reu66cESZ29ozlWG1qKrCblkut0zNtHQHGvrUpcAXZNAkaFmpLgWZJ8qwePmN3SN9V+IiHXIAn3anzh55wLPufVrYG6jrMrsCU76o8qpAu612xlGZhnY40Tg/Do+DDf2O1bfMAUVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:5d::22)
 by YQXPR01MB6124.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:29::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 17 Jun
 2025 14:50:14 +0000
Received: from YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b5fa:c0e6:e5b7:54a4]) by YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b5fa:c0e6:e5b7:54a4%3]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 14:50:13 +0000
Message-ID: <30d81f2c-a2ce-47b6-b999-fb6f09f1c026@efficios.com>
Date: Tue, 17 Jun 2025 10:50:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: lttng-tools-2.14.0-rc1: fails to compile with libxml2-2.14.4
To: Norbert Lange <nolange79@gmail.com>, lttng-dev <lttng-dev@lists.lttng.org>
References: <CADYdroM27zgM1RWHoCocru7VY6kHi1=g3PK4QJ0D67Wra1tc8A@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CADYdroM27zgM1RWHoCocru7VY6kHi1=g3PK4QJ0D67Wra1tc8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0025.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::38) To YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:5d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB6319:EE_|YQXPR01MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: 66270089-da81-43f5-b27e-08ddadae4419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWxOWkxWdDdCWlo0aTVadHhsdHk1Wm8rL0dGNExFQmFrQUhXekdHcEZkOWVx?=
 =?utf-8?B?VEhjaUZKU29ZSjZiUTUwNTJkSDBrVWphYjlxVHFKWWNFMHdMc0l1SmFnRzJL?=
 =?utf-8?B?U01uekhnekdxWkpCVEsyUUlVQkZSMzBsV1JHc0pyYkEwSHdRWVJ2aHUyUUFr?=
 =?utf-8?B?V1ZMWU4vcUlQRldBTmpxNjZaaVRNbjZ1K1lHZmFFMklzbzU0a05QRzJ5V1JE?=
 =?utf-8?B?Y09FOERnQlFjVGxyNWc2VFZKZHpOSG9TRG9KaWY4R2FsLzREYkx5eTVtWEFs?=
 =?utf-8?B?bUZCVkRuQ09zTDlKWWdiVlcyQnRERlBnaWhCbmxvanQ0MUpSNTFlRkh2RmRi?=
 =?utf-8?B?ZDAyRUtnMzV6aXp0WThLdkFPZEhFc283SFZYQW9UYWhrZTVOTmRmSzdrYlN2?=
 =?utf-8?B?b21xK2pESXVtcUMyTU90NjVnb0hxRFJvR1E5bzN6Q3NJZjhIR0ExVVJ6bWxE?=
 =?utf-8?B?NlBxTkJNb0tKREFSOFZDQzI4b0xRZUI3L2Y2Yk9Zbk9jK3l5S2VUMFBuaHlT?=
 =?utf-8?B?eDZwbTBHTFFCTjQ1ZFZzeEh1WlJGc0pBZXZxVlNvNW1Zam9KSk80aE1PZ0hJ?=
 =?utf-8?B?RHJ3WUhJZmVCcXZvL3ZZZU1tNTF2YU95a3AzcUx1SGlzRUZqVVJCMWdVUDhr?=
 =?utf-8?B?cEQ5TnVReXZkbC9WTVVLcFZ2TU9VbmpFTS8rTW9vQ05Ia2kxVEdlM0crVUo0?=
 =?utf-8?B?SjdNaTJTTUZham1ud044ZGhoMWRTb2hjVTJGbnJBRDNSbEk5NC9kS3FZUUp6?=
 =?utf-8?B?RVRKcTRweTVGcWd1MVdMdUJPaW9qcWx6eVgyVFlKdzJLTkUybVJVN204MXFt?=
 =?utf-8?B?aUFWcWpULzhBRlNpV0tpWGo3YjMwK2hZTDluTGUyQTZROEt2TnRCbGJ3UEN5?=
 =?utf-8?B?ZExRTGtGc21ZNm5KVkZpMEhLYktvZis1N3R6ejlLMjJnVzNQVWlwUzkrSzBK?=
 =?utf-8?B?SjVBMDNJdGl0eWlwdDNYbnBwN0FJa0pIRXBLVlRaY3VJOWJOSTNyL1l6bTNk?=
 =?utf-8?B?YlZuLzFPa0RxcFp0VzZJUjFldGFnY25NeWFkUnB1elRXcTc1bkN2WGNVVlh5?=
 =?utf-8?B?ZXp1eEJpa2pGTkI4eExTczJOZlNSUXgva2NNRnZnSStGQnorZ0xWTThUbkJu?=
 =?utf-8?B?aC9EUlEwT1RsUkc3T3FWYmpUZHhRLzJDU1VsUHVQczBkakthQ1djMUZQZjNS?=
 =?utf-8?B?SE9yZlZlQmVSdU0wUC9xK1hZcktTci9kZjduRTBVTmFNdzRNWVoxRkxzOXcz?=
 =?utf-8?B?K3VwRFZTUDNNaGV2WXd1QUNpSmd5cEVPbXVXcmFzV3VXa3cydE10VkQyYzR4?=
 =?utf-8?B?WmRZZWRsczdtOFlEaVRrdHhTa0Q3dDh5WEwrQkVSMVBzZE9pSzFBM3psRk90?=
 =?utf-8?B?VDMrS0RrdmJwVnBZUVZJSjRDOVNzaUJJb2xWNm1YNUtSOEVsUWxUV3E3d2Nt?=
 =?utf-8?B?NWhlMkJlVmJCYjJtSUl4a2xFTmxxZ0k2UTlkaDBva3ozb0ppc0dnWGFmZ2N3?=
 =?utf-8?B?S1ArNDZqS25wcGd0MWdYTDJTVG9wbHdHUnllUGZyeDkyU3huKzdVdkRQZDRF?=
 =?utf-8?B?RDN0ZWZzSHQ3YnhCQ1BJNE1qQ0J4NUtQNlkrYXJiQ0pBYllmeW40bEtiUWM4?=
 =?utf-8?B?dVEvME10bi9EekpvZW45clo1V1VUNi9XcW1mSzBqTVBCUnU5aDRPTnB1Zkl6?=
 =?utf-8?B?Zi84L1U1MkRVM1ZSRUlubTdCUUpvRWkrdy9FVWZ4eDdjQ3h0UWFnWU1ma2hR?=
 =?utf-8?B?L0VJOXhWMGZEZ1lSOGRYTDVFU2lRd3krVXFVNmhwVmUvM1JHVEpCOE4zRmdR?=
 =?utf-8?B?ZE5yYWV3NHk4bzlKdURXdVJNS0p2OGgwNm85NW51WGlmTHdIWXpNYzhVYmNr?=
 =?utf-8?B?RElaMzVUdlg3U2R1WEc2OWh0d0tGQ1VVRTVTVHRaU2dhUHJ6ODJ0K0xtNHls?=
 =?utf-8?Q?UhSTUn3CWtk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnNWT3Z6eGJZNUc5T09tWjVHVDJ1SngxM2dralkvZDVtRnRkSVl6MnhDRTMx?=
 =?utf-8?B?UHEzMWtRUnI2bTE0OGZWV1VMcUVLQUQ4YlUxNTdvWlBTdlFmVlRyZDRLWCtU?=
 =?utf-8?B?OU9IbFpoN3JpcElCZVEyQVJIY0ZtalNHSG9LNy9JOTNUVFRWVTliZEhjeFAy?=
 =?utf-8?B?N1djK004Q3dnbjJySG11WkdwMzRKdW9QVmxxVmxMMklJN3ZuT3phYmovRDhJ?=
 =?utf-8?B?eDFxWWd5YW1DaDB4QW5ZVmRsMkF3ZnVzd0V0VnNnNzBTcU16cWxOYitkaEpV?=
 =?utf-8?B?ZTdrWmh6WERmMzhtYTZyVU5BWmpoV2tNa3NzcXZVa2VxV3FQZGxITm1tbE9E?=
 =?utf-8?B?NmxyS1JOcCtmOGU4OGpwU3RKYUV0RnlrcEdhcHNwQ0xyb1ZnVnJiUE1BckVF?=
 =?utf-8?B?NXRQS0JYYU8yRkJZTVE1V0lTOS9YUlBCalp5K0pvSGZBOVdrQWc3MWFyeUM1?=
 =?utf-8?B?QktUUTRqeEJaSFAxY2htYks5bWk0VUlKei9XbGxvRlU2MHVzT1JMajZWU2tO?=
 =?utf-8?B?TER4eDdsY2xJWk9ENlVVRkk4ZXpQcXF2TlJnLzhaelREajUyRWxGM0x1TUpO?=
 =?utf-8?B?QmYwN0trelRONkkyNE1VTXA4b3pWMkFpZkl5MjgvY2dCL05TUll1WTlKYVFn?=
 =?utf-8?B?NTJIZzJUMUFvbjFTNVZjMUg5amR2WFZXVTlmYnNvK2RkNzlKd3ZlbEZGOCtr?=
 =?utf-8?B?UWFLUzNIOHo2WEpIZUtSWnFhTlluUFRKbHlLYnVaNmc4QVBsRXhLd2V5L2Zr?=
 =?utf-8?B?V0o0QlNSRlpEczZBc3VHT1hkVytpbEp4U3ZKWktrRTIxQmVpdVlRSkRmV3Q1?=
 =?utf-8?B?QmtRZjlURGJJZXhPZ2JBUW5mV2dMYXc3MGhMU09mVURyN1FjUmFjNFRkc3cr?=
 =?utf-8?B?N1JYOVJ0TW1WZFF3ejkyTGxENFNnUi9vakhLaTlQV1U3ZXhKRkNDbjRQbFN0?=
 =?utf-8?B?OTJaVTdaak1xWlhRTjR1b3h1bHNsNUVGV2RvaHZTUmgzV0pTdHJVQVlGY0FU?=
 =?utf-8?B?Ym84UVM2SHJ6LzZqUW8yUHZGcGJOV2hDMkh0TTFrdms0L09oYkFmMDU0MUhJ?=
 =?utf-8?B?dFQ1Q2FBQmppQnJMMUhSNVhmMEtSKzA2VWtNekd4SjdCZ0R6bEpBOW9EOFl1?=
 =?utf-8?B?UCs3UEJFTzBEemEvL05tWHlqLzZmWGc3c3U2WHR4U2VPd1FjeFU5ZXJkNEY1?=
 =?utf-8?B?Yjg5SmF5bHZSZmkrT2F5Q1hkUWdHZXh6U3hOYjFZTWUyRHdWcGl2OU5VSlJ0?=
 =?utf-8?B?Y0gxY0pDMUhpa2JrR1JsRzBNb1lqVVp1ejlodjZnSlRpYUhhT1ZpQTJ4S09Q?=
 =?utf-8?B?QUpEK2JqSHRYalh6K1c0N2I5RG56MXVkenh1TW1DU09QMDhiNjZCNkozSldP?=
 =?utf-8?B?VGt0cVc4WFY5VlQvR2J5S3JMUWVTNUlGK3VMaXJKZzl1bUhzamcrWHJEdmFq?=
 =?utf-8?B?M3F4Lzh4K2UzcHBOdzlYOFlwNGtJalNFREVZRHl3OVM3L2FzcTd0UWc5UVEv?=
 =?utf-8?B?UmxRZWpiR2YwbXNDS0Y4ZjdiaWRlV2dwN1I3ZTRBeUpxUzhxZ2FUdXBVeVpG?=
 =?utf-8?B?enJIa0k2WlFOdWJKQzB2QnFrblhrUlFsRVdCUm8wdnVYc3pZUFlpWjRkWkVz?=
 =?utf-8?B?c1c1TmRzNVFLcmhKZ3EzNDRBaWRqR2s1U2pVWG9PSy91VUNuTEw5MHVSRkZj?=
 =?utf-8?B?VjZSMWRzUDNmWFpCYk1tUXQ3R3JHVUtXcHZEOFlOVWM1cG9ZYktadDJjNFRJ?=
 =?utf-8?B?aGZtcnpUb3llVE1JZGpXL3pLeFVRamd4aXQwM0drZXpZTkxlSVllbjlnZDZP?=
 =?utf-8?B?TEVjZmV6c084UnM3N3MxbHFFUG9aWCtwVnNXUWh1bUdsVTJWN3dlSUZtdkVW?=
 =?utf-8?B?MUJ0U09Lam02bklnazBrSGFZNUFzMVQ1bkRndlZOaVY2RENyV21CallmbitW?=
 =?utf-8?B?N0dvZmVGY01uSFl2Ni9BTm4ybUFRd1E1clZIZm1Nc0gvWk4xM0oxNHBmS1lU?=
 =?utf-8?B?WndLTWlxWkpvakRXVG91K01Ed2EzK3FweGNSQmFlVDJvTGxrVDJGVDdqNUtH?=
 =?utf-8?B?dTQxYnBOd2tFdHhKZUZDT1VpMUNSMTl2K085SGhvMWlEd3pseEpPZ0l6N1pU?=
 =?utf-8?Q?7JoMvvJQAozPgOkZ9SIRIqixg?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66270089-da81-43f5-b27e-08ddadae4419
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 14:50:13.7319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5RNtScxig2A8t0aOgJ8LYefFH8PaEFnFygINq7lIL2GP53GYb2gnjoFNv3YOidGDt+AuZlPyDtXx2JA1b3SqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6124
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

On 6/17/25 10:15 AM, Norbert Lange via lttng-dev wrote:
> /tmp/dev_develop_libxml2/usr/include/libxml2/libxml/encoding.h:173:7:
> note: declared here
>    173 |     } input XML_DEPRECATED_MEMBER;
>        |       ^~~~~
> ../../../src/common/config/session-config.cpp:297:75: error: no match
> for call to '(_xmlCharEncodingHandler::<unnamed union>) (xmlChar*&,
> int*, const xmlChar*, int*)'
>    297 |  ret = handler->input(out_str, &out_len, (const xmlChar *)
> in_str, &in_len);
>        |
>             ^
> 
> Changing the call to handler->input.legacyFunc seems to fix it.
> 
> Also lttng seems to need libxml2, but doesnt add the necessary flags.
> 

Regarding the "necessary flags" for libxml2 when building the lttng 
binary, could you indicate clearly the error you have?

All uses of libxml2 are via libconfig, and the libxml2 LD flags are 
added to lttng via libconfig.la.

When performing the final link of lttng, I see `-lxml2` in the command line.

thanks,
kienan
> Regards, Norbert

