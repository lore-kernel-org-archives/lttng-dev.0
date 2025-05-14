Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97747C3ABDA
	for <lttng-dev@archiver.kernel.org>; Wed, 14 May 2025 19:30:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZyNjq5RDWz10LT
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1747251055;
	b=fED3dwsZyDmVqGnkBU0JonuMDbjZedIEYgrSnKNfvAYkcswMP5KksbrkUFw1kj1byahp
	 EKtFDEwby5i1XFUEfC4aPHW81JQSlK7Brds6XI3cXpf4dRfvVXVitqA+xPM7LJ9mhNnsu
	 hpIj42z9uL2D+fZaInFPQYfs0ps5IC2iJ8ozJCMs9Ix2wQAxMWveaoWpvQzPqsj7KgL8Y
	 TdHu5q2Q1GAQJUpK7VPTEycM1mOOypDIai+8zxEZrpNzidi9fSWytnsPsDAHs+fs+gaw8
	 Ux3948XNloXZlapoWNVdkW1pMhV3aViU6jHPWrKaiR/Irs+XeYxuIMmabYY7orZpjTQ==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1747251055;
	h=DKIM-Signature:Message-ID:Date:To:Subject:MIME-Version:From:From;
	bh=bt8AjrS5pEVhxFtf4/Cg/tfZzV6kfF0Cm8q5qlZP104=;
	b=McliU9y4T71ctq92304Th8tU3BTzgQ/jEnG3LP1v7guXEMPSuRF4kJXLI5xuMpp0EPGV
	 GaQ0EnAdZK6t/HJg/YDNkE4xrvGIYeXH3MtBj1nQPU8MZRhpHyV/JoQHJmeWHhp1fkHwA
	 cEBixON+oiFb75ZtpqB5XpGQIscgdIthmkb4xlsNeUeFzXJSdMFncXvcOEjk1RooyxXBz
	 ch7ckr6vwbN6aZIRt6s8Stj969G+cOuRHxDrMJAp4qfjV+ln4ttjAUQAyGJHri5iPb9PM
	 UasN3OUM2n0DQeqRAUVRkLyCjt01qgKH91OVbJlycuLVlHlodaGDQOt7ZEelV46wlaw==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZyNjq5RDWz10LT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1747251055;
	bh=bt8AjrS5pEVhxFtf4/Cg/tfZzV6kfF0Cm8q5qlZP104=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=wQ9XjA0vHgZaFQ66dnZhZcevbm7PkaPNOBKtzp34ZKkfisQR074tIjGmCRSidKCdD
	 1tQrFUiCI9lq8atAa+dBY5wzSXEtl10sMbTJMZFqwSKhmQqCLIFSF+ewqJRUl929gt
	 +cwX1RSP0nXfuQq9Ezgxu9oViWjPJyHswFTM/Gp+AvvC3PJ3bneoy6NzKKw07fY1yD
	 oz/rMC+xllDV4JC00nfinfeXc4UzXD0Hahaw6ikIul6aj4ccERx6OxNCD7yJpEwQTr
	 w7PXHM504gCqPnh0mD9kvwEl3rG1Y54YE1WJ8D7JEOOB/P6guIJezYSiVxpMBxDuoI
	 xRDLoG5f/ytTQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ZyNjq5RDWz10LT;
	Wed, 14 May 2025 15:30:55 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZyNjm4B4bz10LR
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZyNjm4B4bz10LR
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c104::1])
 by lists.lttng.org (Postfix) with ESMTPS id 4ZyNjm4B4bz10LR
 for <lttng-dev@lists.lttng.org>; Wed, 14 May 2025 15:30:51 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6B0nu7GI904nMWNOEn/lKPYaRshR6q+IuliI4yTtzwUPy85DeVSpTfZ4ZWCkMt6qZ5ok8yszFauztS9GXSHbVe6g848iyXjhGkfTL3miGTy6y0Y4A9W2C2jy7jChlP3iqqiDEw8EMlPeMFuE1jTH/Zi3V6+OVZyG3Q9c7kp9bWh4Y2Ca+lAUSuCDiK0xU72b6XCE4/kTZTJV27Sz95jHv6ouRzSfsQ8IqeJZUDBpdDqdoT+TdtY04Q3GgaI1clAsgSDaJ6d4i0DGZyTpHsetnkJHBMJX8ouL8bwVok+eEVWbVJMmL+NacP08hYXsuG4W/EHVfUX4HyMY0POThi9vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Bv4H3tZGyvHEJ0V4ggzolkh052k2p1+NiJ6L6cuFy4=;
 b=hKAx3zoK99prhLYzxw1tLO+fNWc8i2Y4w1GOWJixcIYFGfIDX/JZ3SEsgBeDy8pn/5vMvREFdd7dXMtbxZFPMGsOo7pA3+R0hYb1QTZzficMe2fm1T/B2NU6yN9hAut6jd9f2dm4zY67kiYEK9eUWGotwcx1xNhR4EJyZyMnl1+OCIkQ3s43z2CJebWdSW3b8ZACuuqbm8l9ZCZE0lWprbuyDcWP0dCiJJ2/a4XRrUT5WH53DXa0K4QrFVg/gonavUwF5vW6w3CUHQPi1/gsuRc72bUWd2I61wCtorUuF5FnKMAlOJo5lyioUZgaHq0iNsRDIk5nJS2/PMWEBugj1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB6535.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:72::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Wed, 14 May
 2025 19:30:48 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8722.031; Wed, 14 May 2025
 19:30:48 +0000
Message-ID: <d45c0e0d-0470-4ff9-b85b-4d92a2879732@efficios.com>
Date: Wed, 14 May 2025 15:30:47 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [RELEASE] Userspace RCU 0.15.3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0169.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::12) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e9b8ce-9cc9-4663-dccc-08dd931dd41f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDFYNzBublRnK3hyNTVPRjQ0ekY4dnJncWRzTjlBVTFvZVNjWHc5OWplTXpl?=
 =?utf-8?B?cmcxV0tBak9TYTR1V2J6emozWElLTGxhbXM3VEZZZ3RBYUYreGEydXNoVjc3?=
 =?utf-8?B?VGVFM2NLS2dQSElreEN5d1VTTk9SRDRtdmFTNFpiTTBWdldTS0dzVmc3VERz?=
 =?utf-8?B?ekowVVpJZko4SW9OY1NRUCtpNlM3MXRZL2x4RTA2ZE84WG80cktqNjJSSTZp?=
 =?utf-8?B?dWxpS29MMm5IcXVMMUtLQVdlQmF6Rkg1VHR5NDN4RG5jODl4Vy9PekFpN1hL?=
 =?utf-8?B?L0hvNXRINnM2SDluZHNIK1lrOGtnZ2Uyd0ExTXVkTzdWNkEvZm5EcWFFcys4?=
 =?utf-8?B?YUJLVmxSTENrY0VtSjZJZFRUVlM5OGQzeEwwNzdjYUJ2bEltamZndS9GTUlC?=
 =?utf-8?B?WWNTam9mY24xU0k4Sjk3S0ZEN3BDdkc3N1ZEV0pFVHVrV2xvWHpiMWRkQ01t?=
 =?utf-8?B?K3h5aFZQYUJrb0lZWWh3S0YzdWN2a1FhSi84L0ExdXN1MnhRb1UzZUpCUWVV?=
 =?utf-8?B?SVFsY28xMUFlNy9URzFpN1dPVmR3VXA1ZVpkSkhKWkRyK1hSRlp0WnhPNW81?=
 =?utf-8?B?dHRVTlhaejBhM3lNbEVHMTlsNVd0KzdpTEk1TElLeW9INnk2Z2VMeU9DNlNv?=
 =?utf-8?B?dnhJR2U1RFFjMEQ1bi8zbldyYnRSd1BuSVN2S3BGV0ZlaTZvbTM3cEFtbDVU?=
 =?utf-8?B?L1lTbnhTTm8xbGpDemczK0NzUkRJcUx6cjR5V3ROaUw3UUdMVUdRUjJqR3g2?=
 =?utf-8?B?UmlneW84Vld0NjhES2FiZ3BXTGprSkdhM2NTZVNhRHdXVStIMURYQWZ3YW84?=
 =?utf-8?B?aGtpaUhMZUpKbUVhRlFUNHU2WEFtUDF5cHB2ZnB2MU9JL2w4aG5oY2dkcnFl?=
 =?utf-8?B?ZWFUM2d2YTVsS2RVM0hoVngxbzIyWm1aRVNnQ0wrNDFRRi9NS1NlYXJ6dms2?=
 =?utf-8?B?WHlhQzRzNUNpT0o5K1gra0k0d3BwU0lZMklIaVdFQWtMQ1U2SmhZTnpZUTFp?=
 =?utf-8?B?aUNUcWhTWVBUMzVIRkw1ZUdTL08yOFBMMHVCekdXTEVueE1iekRlcmp2dDNj?=
 =?utf-8?B?U0ZzOVptUWNDNkV0TEYwT0dWU3FOY3hXczEweUxZbGNDRFpoM2dvMHd6VHhH?=
 =?utf-8?B?YURiR1pOYzBBY2VOazdad1NzY0IyTXRNWEs1VXUwSldBOHViajdXaDYzR3VP?=
 =?utf-8?B?Ry9YenpQYlJFWFFZd1lZb0FWY3VyMEQxaGt2VUN2RmRKUkFqeDFxcFdFeGpK?=
 =?utf-8?B?OWl1clEvZm8wbmVMSzZSRXA0YURwcmc1RDB6TmdaeFlYVnhPRnNOZGhIUlpv?=
 =?utf-8?B?QXhGdyt0aStJVnlWRm9NS3F3Qkg5ZHMyWXlCc2NINjRTVDBYYlRJTE1scWpV?=
 =?utf-8?B?eFNlQkgyR28rYVljOG5HY016cVVKU29XSUdVNzF4OERtbHV4K2x5dGtZTDdL?=
 =?utf-8?B?YWQ5STVFaDVOSldWKzhRWjQ4bEp1NWpvYXNhQzhkazRzQTdiVFpEejI1MDJN?=
 =?utf-8?B?M0Vmd0dwMEZtREx0ZFl0WGhMT0lhV1ZyM3NVRjZhMVZhV0RhUW9rZXpyTHdE?=
 =?utf-8?B?Ry82bUdkRnhjS1NYNVdhdnk3ejZRQ3IzT0hpdWo4S1J3UDc0OGE3NkNMM25X?=
 =?utf-8?B?NmZZMHg4UDMzT2Q4TE9DVlhjalk5YXAxOEV2RUZsbFdlcTBkKzdlNE5Dbmt6?=
 =?utf-8?B?NHZObFM2eHAxZWZKUVNEekFjcUN6K3hVL0kvZVVpU3pBbkh4VzZ0bmtib2tv?=
 =?utf-8?B?T0E4SVRQR0JUWFJLc0R4TjhHN3lHZTRUdzN6c3hLVWZtUkJ1OUlhSkVmVGgy?=
 =?utf-8?Q?tnjf9zCpk9g53gb+eBwMSdH2qshKJOw4ws+N0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blliS05raWtjN2xvd1ZRVFBwSm05YlZrc2NpSjZiQzc2bFlES05LRGFDVmZO?=
 =?utf-8?B?T1E1c05vb2hhL0k5TjNjaU8vMXpRdndVNTNVZVBqSHBqb0h5Z1BBVG41bDVT?=
 =?utf-8?B?RU9NNXhUYXB1SFVXNVVWWTZSR1p3M0J2QUhXWGZuNTcxZTdhK1RuWS96aDVk?=
 =?utf-8?B?dUtwY0tTKzJ1MExhWUFxaER3ZS9LYnB0RFdlVFgrWlNKY0JwRVBycGppYm1y?=
 =?utf-8?B?NjFJME1BN3krWHZMMjBxQjlSZ0VzQnh2MXlsM3J1SXFMd3Izc2hNb1hsNUNs?=
 =?utf-8?B?WjNoeTRqNFl6cW94UzdqWnh5dHhRRklvU256TmpoSC8zQ3VBc1lJYkJiSTVw?=
 =?utf-8?B?cG1uUjJGVmxhWmpnSC9vamFIM2gxTkFKWGpQVHpXYllxenBYVWRkVDdjckQ1?=
 =?utf-8?B?NGVJSk9DSDFFanZNRWUrQXd0T1EzTzhZTXM4Z01VS3dBcXI4QzhnYm93a3I0?=
 =?utf-8?B?Vk8ya3BYNVc5SGdWSXVFNzk2b3RibExxTXE4dkJRc3VVeFk2dlpDaGNFVzRI?=
 =?utf-8?B?UWZBb09SK2RyaDFLL0pmb1lFdnIwKzkrSHBnZ3lOUlRlUVFSa0tEdmVGU3p5?=
 =?utf-8?B?NnRMM0ZTOGRzcTRFVnBiZnE3dzZOUTd0MWNqam5Fdzhqc3VweFdkTkR5cHFD?=
 =?utf-8?B?cXM4YWVmbGwzYU92eU1IQS83YXArVytsNXBNUHB2L0kvYVZJc0N3R2hjdnVp?=
 =?utf-8?B?aW9TOHgybXlVblZncytxWDk1ZzBGNkZhN1A1R2E4eWRSVUV4SU5DbUs4MW5C?=
 =?utf-8?B?c1hhWVd1ZlZ1MDNMUytDVjRUb3ZrVXZ1ZUFwTm0xS0tFa0x1clpUZnlwQ1RY?=
 =?utf-8?B?SWhPdGVST01GYTl0U3E1TWQvZEZEWnE3RmZIRzQydjNpZDArVy9acDJBc0xO?=
 =?utf-8?B?MFYzT0dyVVRCNmpNWjNFWXVLOEc0T1dXWnorSVEzemI2QlVOMXd3bWZVbjdm?=
 =?utf-8?B?Q2YyckxFeHdqL09VQVRBU1ZySnlyZm5rcUhxRG94Rm9BK1NnMDhWTE1hU2p1?=
 =?utf-8?B?SjhONjhXMktIcHNVUlVWR1A2RlpPOURZMUtTZnhHdlJUQzI0bEZGMzBTTUph?=
 =?utf-8?B?MUt0OEJvcnV6MU5lWGd0NzFKRjRsYmJHSGtJWHVXNFB2Qkl2NGU4WG1xUUVa?=
 =?utf-8?B?SWh3OC9MUVJrMnNIMlNIUVRYTmlYMGpMcUM5dmY3ZERBdUdZN3R5VDA5OXEr?=
 =?utf-8?B?UmdoTjgvQ2FLTUNXWTFTUVhoRTlhbi9yajVUNkFsMkpLZW1uTkRuekZSVTlq?=
 =?utf-8?B?NWJiaXhtT3JXaEYrWWdsRlNYWTFYN2wrRG83RTdLT0NidHprZEd6R1BsOThP?=
 =?utf-8?B?ZzJJbkJ3K21sZVVZU3hxdkJFQis2VDFwVHI3MnhyMFhaMW8rc21jMCt4dTVm?=
 =?utf-8?B?bytVQWVNNTVVa0Z6eVFGNjMzRzRaR0E2UTZJQ2NaaER1ZERVYjJ3N1pPNVpV?=
 =?utf-8?B?cEcwaDkzdE0vUDFlVHNrbFlISjBoQ3dMazJyNGdEaXlLR0NSYnFjMG5zbXRO?=
 =?utf-8?B?UDN1RXFOSXRUWm51MjEyMjErVHpUTS9GMVU4aGdPbk51YjVnTUxVKytjMzM0?=
 =?utf-8?B?OUUzV1ZEYjlmZnZ2ZHIydlhLZXNWY0FteXpOTTNIcUJocUVLQWw3WDJJUlB5?=
 =?utf-8?B?UURvdEhZV0U0c3lXQ0JtUW9mcU5hNTJ0RHJvSDB1a1JrYmJwVmxlZHRubnBh?=
 =?utf-8?B?SXByUFgybmU4aXprQ09sSGJmejl5Y0pkSmI1Z1FrOGZDZ3A4QUkvMzVRaGh2?=
 =?utf-8?B?SG1GN0pDWjYyRkUweFplU21CQkczKzJjelNTaWNaUXkweks4UWswd2VhdXJo?=
 =?utf-8?B?aDJnWlNOZUlSOFVFazJERzZXUzBUcThkZFBTVCtpem1mVW1XRWVobENnT2hN?=
 =?utf-8?B?NjBQdUtvbkxQSXhWVEwxRjhudGFGRzVlczd0aVJoOElOaW43Q0IxaS9RWTlk?=
 =?utf-8?B?SUMzSEVxVzRpQzFEQU5ybWJ2UlRHalhaSTk5SkZuelFTcDJZYTZoNC9VUDFO?=
 =?utf-8?B?K0dyOHV6WlF5MW0xelRvT29uUVpQbVozU2kvejVlMEF0V0wyMHV5WDVJNjlN?=
 =?utf-8?B?RktyU3BCV2xJWXUxcElGc09BWUloUXZ1dXpvS2RIb0lkYnBmaCtPd3BSZnEv?=
 =?utf-8?B?aUJXa2lkSkt3Ty9ua3RuN05YdHpxdjdiVG9kclAxb0JtUjUwWUlPNTFOZW93?=
 =?utf-8?Q?DT4Pe8Gb4RNxOpMGuKX+i3U=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e9b8ce-9cc9-4663-dccc-08dd931dd41f
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 19:30:48.1249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2EJGasLbJdflX1yy3RAXZvGQw9RkH7iR0gbYOQTlwYX+JO84swBgOLqXGlgV0nVN0q/fPvTXle7ZtKgXJ6jwOl2VGbPTvdX9fEuEi5qYCA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6535
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

Hi,

This is release announcement of liburcu 0.15.3. It is straightforward
a bug fix release for support of older compilers.

liburcu is a LGPLv2.1 userspace RCU (read-copy-update) library. This
data synchronization library provides read-side access which scales
linearly with the number of cores. It does so by allowing multiple
copies of a given data structure to live at the same time, and by
monitoring the data structure accesses to detect grace periods after
which memory reclamation is possible.

liburcu-cds provides efficient data structures based on RCU and
lock-free algorithms. Those structures include hash tables, queues,
stacks, and doubly-linked lists.

Changelog:
2025-05-14 Userspace RCU 0.15.3
         * Fix: Use bitfield static assert with GCC < 7.1.0
         * Fix: Allow compile-time checks for GCC 5.1

Thanks,

Mathieu

Project website: https://liburcu.org
Git repository: https://git.liburcu.org/userspace-rcu.git


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

