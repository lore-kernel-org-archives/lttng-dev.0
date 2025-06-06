Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED0DC5AD49
	for <lttng-dev@archiver.kernel.org>; Fri,  6 Jun 2025 18:14:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bDTx65pzJz1G64
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1749233676;
	b=MHbdIJOxbJRruKcyrBhUd/klFxhugh9aJBp8g/v1xAGEYBL0HhZMZkcQ0afMiAhG9RP0
	 DlDKkp6BWm42w7SPQDAd5ORgkAW8uurYuTwUW8+eP4eKQVq8KdEQzinWoLwGKO5eQojCG
	 A0Ij16PENXEEFJ6N/CqYOi3tTooaUEJO2mBqMe0FW+zHRhcopkAiQMo63Wsv5jbmztZTh
	 T5mgvwgaAoiOXMy6/9M6DmAeQChh9jtGzglHRJLUd6dkKiqjHxfE4edQVJO874KmQ41KL
	 dvs9fw2Y4eTmulJoBQVPGb0RVwQ02XG1oxKbTZOaQVovBncMn824MT0QQVxa7PJrWVQ==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1749233676;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=9W8jv/gY2LskCvoY6T6w+M0dznHdib8ZMs1C11Nm+qM=;
	b=MmBsrb/IuG9UuAb+FhIVsxKqnzakQgZ8zEPEclv5wOJUt/rwI5PKuxXtclZFF+vSg1bX
	 ZYn7jNbqb78jdQ3wc2RDyts/lyZFXb4GJUgAqZo4W/1k0hgOMh7OKcU/sbUltg9ljChWR
	 Z/Kkqfz1uDDWPQXDBqEGEUz1ORN1N00ZZRxYlkWIc96+qNLj+x9R6PqO1cucarR9/aN24
	 Uj8cpGc/+7lmLGr1pYlyAinZ5TQxeUSMJoEQBRspYsREZRrr4bwm993Snk9wKvbUAmUQh
	 o3rOtZbFSIyr340NhyIpFSEYUDaLMD2PL72EkQMEogcdnLbB9v9jtPMRIRkbZ1h6zeA==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bDTx65pzJz1G64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1749233676;
	bh=9W8jv/gY2LskCvoY6T6w+M0dznHdib8ZMs1C11Nm+qM=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=CFhShiou6j5pJa+aMkWpFoOCBK2hPCka6ztxpnjij6Gcqydp9s06c6DqC7v0LeD0a
	 i7Yy3X167oGATv8rhY0jCPDfBlNj5XbBg1CyopIPvCsq1Fc0zRFq4vL3ibOJpfPn1N
	 Yhsdg9h5Ogt3Z387uv5IMeazG442rk6AbAmIxcrEcXF/t9YVB7flF37cHXokLPOHMK
	 UVJUGL0UbMdWpWlAszCHB0kdRLBlNdv9ItLJnDpd8A3Az1sDn+xDu8lrbeBSkeMjWV
	 Fc2sIorHT384WV1G1VH8BjCRK1V4hX9mb978Cxz4F46XjPHiHBCUAh73ukdvs5U/1z
	 MhWRjwKkd+uGg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bDTx65pzJz1G64;
	Fri,  6 Jun 2025 14:14:34 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bDTx432bYz1G62
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bDTx432bYz1G62
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2071a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:241c::71a])
 by lists.lttng.org (Postfix) with ESMTPS id 4bDTx432bYz1G62
 for <lttng-dev@lists.lttng.org>; Fri,  6 Jun 2025 14:14:31 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPfIIpQUlmbdt7donTpyH+7+hRJljfh19fSljTAQ6J1MKDnfxRjS9jH0/V8twGX1I4qibDQxjGoDFnfSdI27VyroYkdqJ862tO0zs3HFnpVFDRv5veCKScz0RttObms9k0MjVTMlWwYz7FVlXVBvlbkdVp5jg28M0Vs4SFdZrOWBUp3v12/tddxWh3VWLO4JOEF0udYLLPi3WH7e79LPTDFWqMidycD9BfUu+sgOiaR629kb3ZAVWjoOVBeOQjrXYc5YeFvKrK3DXeCX6F/eTIVKsUESPyWd0LAUAGqcBSSQ56Dq//K6EAekKqzD5xZx9uaXcz3Qe0hUySntkUwUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIpja36sK16UF7FXXIt4lDwncCvNZZm0C5i02TLGWOA=;
 b=Y9KoFTZjoCRbwHNx+cZRPXn3obYWy37ZL25w63LH/t9f45tTH32F+3rYurDSFLEvurZn42T+RPCMlEXtBQBUY5rTaReWn1WUusCNQzWOxaH31laDI2kZG9Eqz890EqhF52RuaGNjrz2XEq3AkagBh3Mq/M8hieVVJ5OvyH9vdCg/1aMwNJIuVBGPu4n8uhdoGNBOHPvynm/J8QuNnacC7n4ybha7m+hQF+IAMgj/LQoAKd5DYn8fYkYkn/uvjP3gfDuS/nn02Tsjb2lg7KWQJ5u7hSA88vRw6DOLurKUBlfTB7NcbL/uB/x9YLzXQnozZ9XuwO9fvJraGsDLKV2Z5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB11253.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:146::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 18:14:26 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 18:14:26 +0000
Message-ID: <9fb7448a-9537-4014-bcd8-40e6dbff58a2@efficios.com>
Date: Fri, 6 Jun 2025 14:14:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Function tracing not working
To: David Aldrich <david.aldrich.ntml@gmail.com>
Cc: lttng-dev@lists.lttng.org
References: <CAJK_ieigCAaowdcwmLbkdL1J3eFgHE7t1W=ZKRvoKhgABM46yw@mail.gmail.com>
 <cc6438cc-1836-4983-8f09-c569ee2cf11d@efficios.com>
 <CAJK_ieiG5yDoyg8TetipUJZNMhrpteZuY5CBv5eeUNE18AJq9Q@mail.gmail.com>
 <CAJK_iej5GwQm6pjRuMxDJeYLu+YBjp0NTjh3xzvOCvOJ8aft3Q@mail.gmail.com>
 <9e5aba04-2485-4807-92e3-980b62a29c29@efficios.com>
 <CAJK_iehv1BWCp5FOfXkrDpPoDTG1nnhAZ4iCS1rRwjQbpQQkxQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJK_iehv1BWCp5FOfXkrDpPoDTG1nnhAZ4iCS1rRwjQbpQQkxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0224.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::23) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB11253:EE_
X-MS-Office365-Filtering-Correlation-Id: 22eada82-29b9-4390-627d-08dda525f8ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejhvR3ZDZ3RDRWVNZ0lFSGhGdXNmMEdFT3JhL1RPeXVseHBmcmlzTEw4ZFQ4?=
 =?utf-8?B?bkMvZTZ4YllydGtpaU40aEx6L25hREtlZGt2NnBmVGgwRWsvSUlGNzJ1Nm03?=
 =?utf-8?B?Z2dGREF0Vy9tODJSTFJscnNyd2thQW11VmZNbHgzSC93Z3BWV1A3Zjk3N3dP?=
 =?utf-8?B?d01vQm5jTGpXbjJGS2d6MERaWlgxSlNLNVBDS0pzTE94azVVczN3OERhT0ov?=
 =?utf-8?B?Y1ZURit6WjlvRzExQTJPVENFWmdITHNHaDl4SU8yVjdEOHQ2UDA1dllwR1pS?=
 =?utf-8?B?T3hTSU9UTFVlM1JLcHRmU2o4MkI3L1BXTjVwSDRBT3JxbWRETjJFangxeG1P?=
 =?utf-8?B?N1FWV0Z5b2VpbmVkMGErNkM0a2MzOGovaGZQbi9Sd2Q1ajFZc1ExUFdpbjJR?=
 =?utf-8?B?QnRBLzhSaUNES0hvaEtPWDFwL3A1bk5HajBYQi9KQVZkNEcyVUI0dEo0RHhN?=
 =?utf-8?B?QVVrVzVrSTJCYkpobGpyZFRaL3oyQkZkbmdHUjVFUzBDNDhUaWVEai9DeGda?=
 =?utf-8?B?ZDN6S015aUlVbmdnRGxBelIzUHVqcklDN2QxSEYrSmcvTFF0d0RCNWFYMlRj?=
 =?utf-8?B?QUpHWGJsMkxuT0EvaHcrTmgxNklFZ0tFNmVPY2IwczdicUZEdXlSditickRa?=
 =?utf-8?B?OWtyS1R5WnV3YXpDeFYzTkRMcVROUGxENmVObUwxTGtJNnFhVSt2S1krd1hI?=
 =?utf-8?B?NnNxRmpnUFVadklVWWxKVGlUM3RmL3MrVVA0STFHemg0L1NqVmRWbFJSWUk0?=
 =?utf-8?B?VSswNWdxMXh4cFNXN2pKRHBSdkk0NzIxcXI0SnZmclVaOFZIdWUzOW9qcVhn?=
 =?utf-8?B?eVZVNFVuUFZ2VEFqTFd6bmVxeStQZ3NYM2VyZ3o1c3M1bjZaVmpqL2xMZHR3?=
 =?utf-8?B?ZERpSkorRmtvU0dPY25Wa2hIVDc3ZWxZTXlqZjJ6bFk4TndWdlo3dS8zSng1?=
 =?utf-8?B?bEkwU2RRR0pjVzR1NHMzRDUrcXRMQnArcExtWXJBMFFCeVArU05INTRGaWRO?=
 =?utf-8?B?VXBDWlhZYXAwekhSZTk0WGVEaUxKOEkrQk85bk42N3NwNnM5YldCenE4UXVv?=
 =?utf-8?B?bU1QKzJia0diL3g2ZSs4MnZlU2EwcmNTeUltVno3RHY0Y1JjTUMzaUFFcmll?=
 =?utf-8?B?Y2pyeDJpQXptTlErWVh1M3NrRDg3S3d1azlJZ2YxNkFZSVlTYVBZeWUzRzht?=
 =?utf-8?B?NysrTGR4ZElNUHYwQjRRWUZocEw1KzlpcHVRVXNNeis5eVhTbVdNZ3FyWThr?=
 =?utf-8?B?YjZ2SExvRWQ0bzdoM3pyakh3T2VXeWd6QzZVSnF0OEhoa3dtZ3pGaWkydUk4?=
 =?utf-8?B?dkFXTWw5bDRnOVgzL2dGcHp3NjVWSTN6NWQwL3pXVk5la084UWFvNFFPbC85?=
 =?utf-8?B?dkRLd2pJM2MrSlVYS3E2NlV3dUlHZ2hiL0d2VHhLRFFHdExiYUlJREZNSUEx?=
 =?utf-8?B?WGt6KzE0czZwYWUvVnJjeWYyd2xlWHY0VmxOWmNCdzFxYTNSNjc5WlBQb3p1?=
 =?utf-8?B?eDZOR2ZCMUYzbHVGU1VDV3RkN1BnMWtmejNqcmgwK0Y5OUdLbWxJa2lOT2Rk?=
 =?utf-8?B?aVBmRzdaSnNOMmRBNXg3SHY2Sk1wZnJ2RndlN2g5S2FrUktFWnFhQnRPd2k1?=
 =?utf-8?B?Wld6dWI1RHBxUmo1YVBrSTUwUWptTzlNaC83YzBvSG83ZG02Q1hPZzd2cDJG?=
 =?utf-8?B?K0FVUVVtVTdTQVpTajY2SFR3Qm1iamVDVmlVbkdEWUR4SXZPK01zcFlqK09O?=
 =?utf-8?B?R1lGbTZITlpPclhUaXU4cnAyQ1NlRi9tR24vUXdIblVDb2J6Q3FvSU9PMEVO?=
 =?utf-8?Q?THz5e9onjXWjooViMvAU7sSKyMMG7D+Rz4VoM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEEvQnBHa2JHZW1FYThDUUViQy9OaGQyalBTM0tnQ00wOU95cnBRa3NUMlNi?=
 =?utf-8?B?VjI2cU5PUzkwV1Jnc2FXUlB6bVJkNTZWcFJ1R2U4Qi9oOXY5SmNpcVl4dmhk?=
 =?utf-8?B?cnhJTmY5dzltOGFSWWlRZzJuSlE4TmlHdzV5cnZwc1BtNHdxNFhScFdrMVNh?=
 =?utf-8?B?MUdDMjE4aXErSlo0dUxONU9xbE11QlMya3ArdDUvd3dlNFF0dGxoK09kUXkz?=
 =?utf-8?B?aUN6dTB1TTR6ZVI3bWdHeEZ2T0ljVHcwR3VURUZQWWVCWi9UVW9tMklrNnFM?=
 =?utf-8?B?c254bFpQREF2bXNOWVlhT0s4Q3JoNXZZUHlGUElJSno3WWo1aGtFOFFNdzc0?=
 =?utf-8?B?c0E1SGlBaTg1Z1hvU1pJd0RzaDI2dXlmd1dhUkRmREZHR2VUU0swUVNvQlN3?=
 =?utf-8?B?cThCdkp3Ym1rRnF5VVpYNEpEZmFzcnhVNTNtNHRTVHhNTjhUTWZBc2FIbGZm?=
 =?utf-8?B?aFd2cDY2SXhYL01JMmp5QzVTelBZa0l6MkxhaFZ4bW9henRUeE9tVkdHbXZM?=
 =?utf-8?B?S1o4OGNWbXJJUnN1T3lrdUhYQmxoK3IweEFIYVlGQk5qWmhHVG1iNkxBREg0?=
 =?utf-8?B?UlFQdXpHdy9mSm00emVXZVNrZ0RzdFkrUTBMcEUyUGNmanhTc1NDZzJRcFNB?=
 =?utf-8?B?Y1VwRitJV3lPWDdXa2JFR3U1L09MSVNqdGdqRmdrVldIc05YZUUrb0tRMHZO?=
 =?utf-8?B?M2NlWkFTUERUeHhTY2wxUnhPRUx0QWR4eXdMQjYvd2JmU2hWV2Y1WUNFbWtV?=
 =?utf-8?B?VThXQTR5UFFxcnp4c0NLaFZNUEdSV0VRdGVuazFTMEVrRlhiM3BTM2dLTzBq?=
 =?utf-8?B?OVlMcjlYSks1WTBMYTE3ekx4SmZBbVpZVU9VZFZNY1E2UENvZnRyb1UxWUN0?=
 =?utf-8?B?MnQya1pOQmlmV2lXOTJGTjgwbHVCR0Noa2Ric0FyeG1hOG54MlNQc0ZGK01U?=
 =?utf-8?B?Mzc2STVnTVBkbXNLL1JLaWF0aGJLZm9VeWg0NzUyN0hvMGJCV3J5RW5qalNR?=
 =?utf-8?B?bHVhcS9MamlEdzF2c0lxTDhFTEU3RnFqNHpVa081YmFvS0c2ckFVNnRJZGt5?=
 =?utf-8?B?Mjc4Rk1aM0ZBWnNFVVdWbnJYQUxJNUc5WDNEV1Z6dUpyc3ZvTGpJS3RENHJR?=
 =?utf-8?B?eFRiQjhFdXYyVVdBa0hYcTk1Z2lUU1FEZER5bmNlTzIvOTIxZkdNTFRScFVW?=
 =?utf-8?B?VGl5cDRPeksyL1JJcmtGekduY05RWENUbmlLdTZQT3V5R256SGtDcGxaSWd6?=
 =?utf-8?B?KzJzS1ZwMEM1ZHJtWHAvSmhXT2lRd2VNMEcvTmxWRE12MUE3UWR3MGhuWi8x?=
 =?utf-8?B?N2JwWWxacUt1cXR5TjFTOUJmTDYrMzU5YnJudm1mZnhwUVEwb0R0WUlqQzkr?=
 =?utf-8?B?cytZQ01OckI4anN0ZVppVk1Ec0h3TmI4c2NDdGhKVHFKdlhITjZvVnRwekV1?=
 =?utf-8?B?UnYrbFlDU3B4WW9pRk01T0QvQmRoN3Z0WkgyNHVQMlJ4VytCRmMzTlBZdWdM?=
 =?utf-8?B?bXhETUlZMjFPK29mc0ZGNFNzTHAvQUtZdkY1SCtld3UvbGlYdyt2OXgvdWEr?=
 =?utf-8?B?RHR3QlBBT1NndElrWmhnVzYvSkRYamhoYkFONmhQUmNmVnVBWU0zSkNhQWhI?=
 =?utf-8?B?NlhnL0tVcWhHQkdJdHB6TUlQZSsxc1lrL1VsRXNZZWlmalpXZjFhVHRMVFhv?=
 =?utf-8?B?MGlXR2xWTGhDR0hTeE10ellxTGw2d29WeWZ4bGpVNDhncEdJbnRUeUhpaWdC?=
 =?utf-8?B?dkhnc0NreTRjUHAvOVBzZHFZTzR6dlBYUk4raFdQcnBMTysxZXFOYnNuUThV?=
 =?utf-8?B?YmJOUXYvQ0NzbEU0cG4rTzArRnVpbWljd3Y4c3dtVjNaUDZXNW9HRnN4QWNr?=
 =?utf-8?B?NnZLVk4yNDFtd3hhclRFVGhKTGgxeUxhMHpxNmZVemQ1YytWRC93Ny9XZG5D?=
 =?utf-8?B?a3F0ZmVONGEva3BNU2NGd2hjL1VWM3N4bmdFV2t5SE9JZk5DTHpwSG1SMVNT?=
 =?utf-8?B?dVNwTVVLTmRTT1hNVFQ1OWlpQ0U1MXVHbm40ZHdScVZBVk5tdUNTVUVKWUYy?=
 =?utf-8?B?WlkyWXNJcDJvYndzV0xpUWhBSlBFQ2xLY3IxcDVDcnIyRmhBRmliSjFZc0pU?=
 =?utf-8?B?TTV2WlJaQlIvMVlMWkU3SWVadmRTY1h5d2MvMjBaUk5YNnVJeENwaG1QdG5Z?=
 =?utf-8?B?VzlHSndacUpnczh0Ui9HenJZNldRZ0hjUDZGNm51d1RaSkQwSzZkb0xBVGRv?=
 =?utf-8?Q?mdm7KKz8ccqDUy6Mswgap9/6QUFV9LiHroH7Z/SDXE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22eada82-29b9-4390-627d-08dda525f8ee
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 18:14:26.6832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyeBm/MIA3PKud5YgmUsoaYMhYB9BaxCz9y+uviw/wIrxLuE2tUoXlFdw3ZitiAgbT+ss893JtAm2UP2whZXQH32x6piW6niuj1nDRIx8R8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB11253
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

On 2025-06-06 10:37, David Aldrich wrote:
> Hi Mathieu
> 
>> Indeed, You will also need to enable something like this:
>>
>> lttng enable-event --userspace 'lttng_ust_cyg_profile:*'
>>
>> See "man 3 lttng-ust-cyg-profile" for details.
> 
> Thanks for this. I used your suggested command and can now see the
> Flame Chart (Incubator). However, I only see symbol addresses, not the
> actual symbolic names.
> 
> I compile with:
> 
> -O3 -pg -finstrument-functions
> 
> Do I need any other compiler/linker options to resolve the symbol names?

Yes. Resolving addresses to symbol names requires to know the
base addresses where the executable mappings are loaded.

See:

man 7 babeltrace2-filter.lttng-utils.debug-info

for a detailed explanation about what needs to be enabled.

Thanks,

Mathieu


> 
> Best regards
> David


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
