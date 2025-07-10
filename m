Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB78C83F1B
	for <lttng-dev@archiver.kernel.org>; Thu, 10 Jul 2025 14:05:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bdGny6hnHz19vm
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1752156328;
	b=PibPaSyAuA0BS0GpmvbkCW3lQO7vAL7oNRDT914GZ7NwqZI86zc8wLx8moW1rmN14bCP
	 P20RgIVfE3w9wwnFMSoMJbPJWZUsJNlI2U1i5sM+zIUOgnPath4SMicvOV2bmHTOJO0vM
	 W3ZfpchGRf9Tqxg64QpbU+rgMKI2zknC0lmaCoCapeLHYDVxTalEUKUOv5Moi2c/moUS6
	 eATWDN2GR2EFAdyOk2HeESpUumrjOjyMa98/QpIoRiL9qVkJAmAsneSc0iQ1dzHKjqnJp
	 bXnCCjszqZZZfQpWF3329j96GE/sk16g9KCK13xucGuP9117MNVv+viCDoFdbByEqKw==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1752156328;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=bO2HCxdwplEsZDVS57zBM8lwvEidMELsk6tixoV+mXw=;
	b=B/O37Ylsm8+Fk545Z30lbF/nBs+mfFWg1Bd/8+WqEtzmFAZ6F0lLplX7+k1ODWMQ0IjN
	 /5/ySjgZhnoML1hUJLuMCrwU4fAYQqzOIboCktKSmZqRMJUd2PtiH4qsmVYolheCo/lqE
	 7Epw3XhGYcP3y8qcUcQ6lCI5nRBoGRjUB31kPGatO2Z62IoESNPqnIQnuEUP0V8SEr2M4
	 69agyXpj7gpIMMDyfie3tb8VvsShoo5+BTzKfgxSfz/8Zn8xuUN7IUsonnEJjj92EXL6n
	 bPtM6rtBh8u+ZlmRMICdfHjmdFhHP/I1wWocWPqO+gyDiNeLgTgYK4gz1m4zU28kFzQ==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bdGny6hnHz19vm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1752156328;
	bh=bO2HCxdwplEsZDVS57zBM8lwvEidMELsk6tixoV+mXw=;
	h=Date:Subject:To:References:Cc:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=j3OrxxWwiDACbDoQmh8GYlvytemMvRmkZzMQ3MME8/2xRYnVJQE224rNUl4uXc7Q6
	 RWWAy96lcMXPBABrwEsB5dWeWoa6EJhqLIgTHvJYzRRqiQ+3yD1x93sxRQbSMrXS8c
	 sZ/WpiQH/Do0bo2T/MZkfExX454crXHCRmySfUhY87sKP8OxXdlRZLuqhcCzwuV1VM
	 OJ7Ki4VmlSJhx7La2QGXB2xtlPHvgrYrUQ7uv34aeJb1vK5v6/mGrrX+fwojAasOcD
	 q0xkvE2OB6CK9W9iq8ELafWEN/+QBUeF6MOjHhJk2kn1u2wgOb2hDJSJm1cKoII9Pw
	 U9xMqFhh62m2w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bdGny6hnHz19vm;
	Thu, 10 Jul 2025 10:05:26 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bdGnw60g0z19vj
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bdGnw60g0z19vj
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on20703.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:241d::703])
 by lists.lttng.org (Postfix) with ESMTPS id 4bdGnw60g0z19vj
 for <lttng-dev@lists.lttng.org>; Thu, 10 Jul 2025 10:05:24 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGUAjYywIM0fS+ZzE17WsOdtRacUmKPaFk9CIAuetD3ttyR4wpv64kxGD3Dxu7YrZ1GlRcMPBRnk+QJ3n9UABIu/8EMhWTPrADVEM1OLFMbqCgh6NbOtr33WQo9ca9a7Itp1PWqFGT5WzZQVblkhAp4Uk8fe107A8g2v+TB4DGRj6uDuWxDDwBIBiq4InFdB7b/DRXpYwIKoJM46JaiFK9U5r25oz9dDVrwWF+0DQEPbRcwUa5eQWFKBoN4H75FRh50vHrxGu5nQqBtDYSqi6CEMHRL9CABhCyebuou0vtPqws//VTvoXrUiMX4l0Hw0b8AnZq+7kVKmX5mlOYxLMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfT8mc8648Q24GK7KmuQhZgLGv8Yyu1UFeez2gBMAb4=;
 b=vQXZJRjFiKYpqlI16KtGrtc10VXGDuvD83nH/f+UYmUBJgJNxWBAua520Aq92F5Ke0sWHfJfvih9HjYaD//P1TUv2F94StRgWkHTjV3XuInoO9sch79jIqQ3at8oWrbMizDk4VvSsVPVI10JSzRc30eMehTUPX6DyBA7R15U8WCgvegngbRR9EHghrOboJpjcrQHFE5IgqR6y3fLinJTxRVX1bFN9qcn9xxFXXmfy6jL011Qe4JShwouNqKMZ3E/gUaH15QfJtyRi+7FHcMucAamQCJL/sp3Eh7M9M6LNmdo35oJj2c9KHAIezM+QuLkAPnvoh1QPZceSq7w0mJcAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by QB1PPFBE4A41CAE.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c08::287) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.31; Thu, 10 Jul
 2025 14:05:15 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 14:05:15 +0000
Message-ID: <23ad5696-f88b-41e3-ae37-e1c9fd411822@efficios.com>
Date: Thu, 10 Jul 2025 10:05:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: cds_lfht_new() clarification - init vs min
To: =?UTF-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>,
 lttng-dev <lttng-dev@lists.lttng.org>
References: <0178CA60-19CE-4E0A-AEEB-5E9DEAAB460E@sury.org>
Content-Language: en-US
Cc: paulmck <paulmck@kernel.org>, Olivier Dion <odion@efficios.com>
In-Reply-To: <0178CA60-19CE-4E0A-AEEB-5E9DEAAB460E@sury.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::30) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|QB1PPFBE4A41CAE:EE_
X-MS-Office365-Filtering-Correlation-Id: f7848851-df5b-440b-6e5b-08ddbfbacb2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzVsM3lSWjNVVGxCTU9PSkhIZ2ZRYkgvODEyM2dkWWdGR25UUjdHSHVMUGcv?=
 =?utf-8?B?UDA2dVpJaGNZdTAwKzVQczM2L2xyVXFJWjE0aXNGcnRaWDBXQVhGeU9aSjl1?=
 =?utf-8?B?SFRyL2g1eXJCOVAvV0VvQkhJRE84MUN1eXU3R0FFYnFxOEgwMzBHbXAwR3VS?=
 =?utf-8?B?ZU5MUjg0YVFJTFIxNkRtNGZWL3JaU3Q1cWZPeVozM2xkSDM0TnJzck1qSTMx?=
 =?utf-8?B?REd5czEwRkk3WFE5NS9SdUhtV3N0TlpkNTJrY0hsNzd2V2wwL2F6ZGRrY3h3?=
 =?utf-8?B?dDFYaG41dHJnS0pvZEljMDFxRDZvMFJNakhpS1BxKzh3NlB4ZWZickN6OEk5?=
 =?utf-8?B?SXlVWmdRTmJ1eWJ3MkxGTnpHZ2JnYmV1RjFvR25VLzJOYTBlNk5admlUYWFl?=
 =?utf-8?B?cDNkUEFZVXVCWVBSd3lmZUhPNDM5ODk2c21lYlErVXN5Q3ZpOTBDK1UzL2hJ?=
 =?utf-8?B?VnRqSklqT3FCRnVaZHZ2TndnckY1amlWUTkvd0ZkNkdmK1hUd053Y3MvZEFt?=
 =?utf-8?B?NHhXRFMxUEtxU0x2YjJPZ2VEMXZ2QjkwRUtXdGFMaUZVU2VDbE42V1RNTlk2?=
 =?utf-8?B?VFlMSnREeW1pR2UxTTM4VnRSbCs5S0NwR1UrbGNvYnViZG0zN2ExYlA3aVp4?=
 =?utf-8?B?ZGFFSlJEc3c2K1NNMGIzU0w2SjhsNFRKaUQrN21LbnRsZUNTZkdUVm0rYWRM?=
 =?utf-8?B?SXBPTmt1L3BscDFoMk9ZNi9URTFTQWRGZ0o5bWEwaUVaTm4rcWI2UFhzdHRB?=
 =?utf-8?B?MXNHbThjRU93WExoT05wMW54T0o3OXg2N1YvaExSais0Z01BL0NCcGNBRVJC?=
 =?utf-8?B?dGpLK1laTWZXKzhxUEgyT2xSZWhKbUpmbi8xRTZOMEtHbXNrOWJqdDJYZkRw?=
 =?utf-8?B?QWdtVGNsTWtjT1BoUWFxdnVGcHNad093eFh3MW16bUFGRnhrOVdyNXp1Vytr?=
 =?utf-8?B?bmZYcmYwcHVPeFZZS1c4RVBkdFBVM3d4Z3huMERFdTFTaTJDZ0hwOG9GanM0?=
 =?utf-8?B?Q1VCWXZoaHVuWk51OXNLc2F2cmh2UlA5Z2wwWnozMUlpQ3k3MjQ5UE0vdHVk?=
 =?utf-8?B?eGFIZHhxdHplbzlOVmtTZWJKMHVhK0NLaGZLaFJ6aU8ydXJoMlJXVm41Nmtn?=
 =?utf-8?B?dXVPOTYrK0tVdFg4VjhLemxnN1Q2SjRFSmF6TGg5RTZUTGtqTXRRemJyWGgw?=
 =?utf-8?B?VjR4L0tETFZXeWgwYi9DZXYwYnJjRTAxcVk1aTd1WEhEdEJiMWpsRnJOQUtr?=
 =?utf-8?B?MkVNbEQ1cW1ZUTlpWTBmVVhmSmlsakRqV2lxeEdNUERHR21ZeUZlbnlZYzht?=
 =?utf-8?B?a3VtUkVKRFVyMGIxU3F5MkFlOFJvVEtkTjZsbVBZbjl6MVlrcFFza0c1a1M1?=
 =?utf-8?B?RHNDNi9hay9qbnFZY0lmdVZhY25vS1o4ZG9wZklqK3RycUpZOGYzbUlrTWFT?=
 =?utf-8?B?c3lpaWorT0FNSjZncDVCRUxhbS9XS05NWWg0YmFuS0xDVHIrOTFVZHdFWEUx?=
 =?utf-8?B?YWRSU0R3S3FiZWozM3VVNG9pK0FHcWJHOCtRcEVJWEsxc045dGRMZUc2N2lN?=
 =?utf-8?B?eEQ0Z1pJbW1NZWNVY2dUQzI3VytVTC9xUk5ZK1drc2wyd0VCU2RXZlVicnhs?=
 =?utf-8?B?NW9oemVVVm5OK1AwZ2ZkQm9lb0VJbG9mKzRDVDNnTFcvTkYvTHU4WThwc2JL?=
 =?utf-8?B?ODdRY1dFWkhESEczcjBhM0FmZmxsa1BudEdkT0hFdEYveFFONUE3QXV3eHNo?=
 =?utf-8?B?YS9oODRtRTJySEE4TnNEa1pma3c5ZVNnNlFnTG5Ha1lRWkl2dWlTNG5zb0Ru?=
 =?utf-8?Q?9yCd6K91taR00KI08BfrqaPNdWPC87nuGNQjI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1lWc0pOYnMwRDk5UmRGRktPeDdBZG9uZHBBWCt6eWpjQXpkand1MkFpQmhW?=
 =?utf-8?B?eGpHRUZTMG9VMXEzdWJvUHY1OGlqc2EvQ0ZQWjUwMTlveE9JU3lxaUIwL09Q?=
 =?utf-8?B?SlhmekxSdWlWQTdtUEhNdDI4N3RtY0ZDWTVIZW00cGdaSmZYeDEraHZCV3p6?=
 =?utf-8?B?WTBRYWdaUy85WTVBQzFXV2JTRzFacE8xeUNBTXZBUkhveE9SN0RjeWJpWFhY?=
 =?utf-8?B?MG5ZYkF2L1VLSWp3YmtjUnQvM2xPT1lxUWlpYzREZ0l3QUFnQWl3RjB0cG1i?=
 =?utf-8?B?OE1SUHR3QW82SGp1NU1EWjJEZjRqcGJ0a0tab1krd1daVmZBeldJS1JZQi9G?=
 =?utf-8?B?VFpJcjc4NEZITVlsdTJ3SFZ2WlJZWWh6UTZaYSszdEVJNWkrU0dMaVYrTlZO?=
 =?utf-8?B?Qmx5a01pd2pDa3Aybk9IclRKR0NpNmkwMGlNMzZlb20rREJXOGVjSVIwa01V?=
 =?utf-8?B?V3c2WXZRd3hSMnRNTVNTR09aWmlraDFwVjQ5ZXlCYzFmNlZYcThCcGZjRXcx?=
 =?utf-8?B?aFZ0eW5rTTRhZXJIYTVjZWJQRVVlYkEzWXJoc29lVi9LZVpHNGQ3aUNXd2VU?=
 =?utf-8?B?M3QrNXA1eFhuSUsvWDVVZHhmRUJKeXNiMjM0WUcxM2h3d0hIZVpqWXZHNkNE?=
 =?utf-8?B?cWdEOTVtbDFGU0tkUW1mTmNLVHJuUmpFOGNVd1Vya0V1SGM3SUpuZkpIZEtV?=
 =?utf-8?B?YmFKRTl5OWdzYnFKaTVqVEtrMkFDZ2RpMjM3aHpsbnpPQjJycEw1VTFCMFRt?=
 =?utf-8?B?RjV6RVNvOEE0OWxrTHg3Q1VHUlhCL28rb1pPWDM1RnV3eFgwUk9VTG9jdlR4?=
 =?utf-8?B?RjNzV2J5U3hLdUh0bFp2MHdvM0RkUGZLWTRrRlM4SkVrZzl3MVpPN2dmbGYr?=
 =?utf-8?B?T3Noenk3MmlXdHE4TnJWQmlFNkVXTUJabU5ON2dEYmpvM1lJc3FpUEZrWGdx?=
 =?utf-8?B?aSsrYk9SSUxBV3lxUUZ1WU1NWG9wNk5rNUp2UnBkTkZDY2dEdDRuTVRBSDBG?=
 =?utf-8?B?cFlHYnJtakgxdFpOc3Q5SmxYOTBCSjhCb3pWU1dkWEppSU5QNGhOSDF2bzV5?=
 =?utf-8?B?WFVOdjZ6bGtncTVQemZKUDNRMHNYTzZIbWRwZU1WK3libHB3WGtzdlhJSjVl?=
 =?utf-8?B?R1Z6bjQ1OXJtZzl0Qml4Wm5DTHowd0ZrQnhVQlJQUlQvNFQ3UXd5amlseksz?=
 =?utf-8?B?dEVNa3F4Q3JaUzZFay84RWVSUCtXb1o2MGlXWFFubzRkQ2lySmdLVCt4ODVr?=
 =?utf-8?B?U0dSM3BUbzExQkYxc2NCbWtxV293R0U5LzZMUEZiWEVTMWJGcHk4NVU3b2cv?=
 =?utf-8?B?bTArQU50a0I3bWdxRWhkVVNOenpvUjlhUUdkdjRFZGxodDZFT1Z3RlVNV1lZ?=
 =?utf-8?B?Q0tlUWdwZFlNK2I0RHZNNWIwYlQwTmk1dWVnVVMvQlRPSlptM09XSEpCMHEr?=
 =?utf-8?B?Q0V4SW9zTHJ0ZGxaQkdsa25sbksvY3RHcjRoN2hOVFpVcC9oQnJPMTkzS1V3?=
 =?utf-8?B?eFJweldKRjNKSmVpNVpCQWNRbTNUbTJ0aVozM04zMGRUUmdXQXA3aDAraVpm?=
 =?utf-8?B?NGNsL0J4YlBpd3k2eVRiNG8yanBKT2o1aGNWdzQ4SEhSK0p0aXdteDU2RzIv?=
 =?utf-8?B?VWZTeUxrdk9GQ3M5UGFzQlAxZzVicEx3Mmx3bFNTN1Y5WnRPVnBkeE0zbmxD?=
 =?utf-8?B?VWoyNHEybklnUUdvL3hPQXVJbklGRUo2d1p4T3k2V1U3TTR1RTh2QSt6VlR2?=
 =?utf-8?B?MHR5SGFjWTZ6TXNtcXRsUTdIQnFiUVpUOWEyN1ZqbTMvR0tpMTM0V0dsaTcx?=
 =?utf-8?B?QmU4NWRndEJFTTJIQ2pPZGgwVXpaM2VVRkhML0wxNnlxRXBCbTI1blZwNE5R?=
 =?utf-8?B?N0thQUlnWkhDeU50aktmb1RiKzc1d1c4SUZSTWlxRFYvMzdJQ2NkWWc5K2VP?=
 =?utf-8?B?U3o2U3loOEVtMlIycGNkTnlubXVwVkRZZXBDMC9kb1ZzRU9KcWdZMVQzRklO?=
 =?utf-8?B?bE1IOWcxUEw0b3pMMHYzV1dGMWtoVDFxU1g1eFFWbmFOQ1M0NWZFZTlwT0hk?=
 =?utf-8?B?UWVEdmtrQTRua05aMHFLdGJlS3UrUmVzdWYrS096Qjk5RGE2RmNia1c5SFZn?=
 =?utf-8?B?a2ZBbExLc1RvUnd1aW9SNktJOG1LcWJ0T0RNMXIxdzFOMWtkL0d0clYvSnlx?=
 =?utf-8?Q?bQdxjoPtHorT2+dBxoaQ4VM=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7848851-df5b-440b-6e5b-08ddbfbacb2b
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 14:05:15.1855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: narJK71sXRFNyFuZ5bQ+bA+ne5ioOjVLxeOdRYr/F8c90+6bCFWRPPo9e2EbNTvFzu4dCvJbSqBDVThkZRjxBVvPjiXu3rjGGpyUk5RcAtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PPFBE4A41CAE
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
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2025-07-09 14:57, Ondřej Surý via lttng-dev wrote:
> Hi,
> 
> as the answer to this might be useful to more people, I am asking here:
> 
> The cds_lfht_new documentation specifies 3 sizes.
> 
>   * cds_lfht_new - allocate a hash table.
>   * @init_size: number of buckets to allocate initially. Must be power of two.
>   * @min_nr_alloc_buckets: the minimum number of allocated buckets.
>   *                        (must be power of two)
>   * @max_nr_buckets: the maximum number of hash table buckets allowed.
>   *                  (must be power of two, 0 is accepted, means
>   *                  "infinite")
> 
> The max number of buckets is obvious, but the interaction between init
> and min is confusing.
> 
> If I am reading the code right, then init_size < min_nr_alloc_buckets have no
> effect, the buckets table will be at least 1 << min_nr_alloc_buckets.

You are correct that the documentation of interaction between init_size
and min_nr_alloc_buckets should be improved. Especially the semantic
of "allocated" vs "initialized" buckets.

Re-reading the code, here is my understanding:

- The init_size parameter is responsible for initializing a certain
   number of buckets at hash table creation (during the call to
   cds_lfht_new()) and for setting an initial resize target to the
   init_size value. It allocates the buckets memory _and_ chains
   those buckets into the hash table.

- The min_nr_alloc_buckets only acts as a lower bound below which
   the hash table resize algorithm won't free the _memory_ used for
   buckets below that threshold and will keep the buckets allocated even
   when the hash table size shrinks. It does not affect the fact buckets
   are unlinked from the hash table when it shrinks below that threshold
   though, it only keeps their memory allocated.

   This parameter only applies when an explicit cds_lfht_resize,
   cds_lfht_resize_lazy_count are done, or when the hash table is
   created with the CDS_LFHT_AUTO_RESIZE flag.

So my understanding does not match yours. In case I missed something,
what is leading you conclude that the
"buckets table will be at least 1 << min_nr_alloc_buckets"
at hash table creation when init_size < min_nr_alloc_buckets ?

> 
> But what happens if init_size > min_nr_alloc_buckets? It feels like it will work
> as expected if you pre-populate the table, but if you use it "normally", e.g. there
> could be single add / del, the table will shrink immediately.

In that case, cds_lfht_new would allocate and initialize buckets based
on init_size, and set an initial resize_target value based on init_size.

For a hash table created with the CDS_LFHT_AUTO_RESIZE flag, indeed if
the init_size > min_nr_alloc_buckets, doing a add/del will indeed
trigger a hash table auto-resize, which will unlink and free buckets
between min_nr_alloc_buckets and init_size, and will just unlink buckets
(not free memory) below min_nr_alloc_buckets.

So it does not make much sense to have a large init_size value for an
auto-resize hash table, because it will very undo initialization
and allocation soon after creation when the first items are added
and removed.

For a hash table created without auto-resize, then the behavior depends
on the explicit resizes done with cds_lfht_resize,
cds_lfht_resize_lazy_grow, and cds_lfht_resize_lazy_count, so it makes
more sense to have a larger init_size value (even larger than
min_nr_alloc_buckets).

Does this explanation help ?

Thanks,

Mathieu

> 
> Do I understand the code correctly?
> 
> Ondrej
> --
> Ondřej Surý (He/Him)
> ondrej@sury.org
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
