Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A54AC369B2
	for <lttng-dev@archiver.kernel.org>; Mon, 14 Apr 2025 21:36:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4Zc0wK1Fvdz1dmB
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1744666577;
	b=f2S018nqZojCJeOw0ZMYD8kSSSAYICpelTqGZ9Mx4ppd/exA3Y5Uk4kyGG12XfMzpirM
	 BYeXrlcN0nuYiTNvh4gau/yM1X56q1CZnbnuW93XWIyB9vag4L6IkO6jFe9QZapEhpoCt
	 IZ6rPvBYfKStaNbBFf7npRi81sRDE5AAHMFiypd4gdEq03Pc9wcck1bWMLlnAuQV/U6sB
	 lK6KGzjjJDTbscD1x9YFdcEb8p08P5KzwgHh7y7CEo+40x89uWcuOl1svMu6b+VuvdPD9
	 S8zHs56rYEEd9whuBoaK/Xk5jXOWy4pN97aY7sLJ4bif4gwZeR089CetjPaLJk4BEig==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1744666577;
	h=DKIM-Signature:Message-ID:Date:To:Subject:MIME-Version:From:From;
	bh=88MA+3dpCzG0KlCTI2Ktn4nbQNVAXsSC0seN+hhBW3c=;
	b=aJTSDorKVARs3fIbZvhke99RXzjrA+0f05V79A6lMaetZA1rwhldegI652azTn4dIcck
	 KWQXP2HZxB/JfqYU+4BTTMcOuFWksTIBhc/XfTyFh/d1LWz7WIVOc7PyWvIe8MSHrTfrL
	 qY1Heyr2sjHU0sUb8iIHfPlKQNb7JuPb001LPafR9BClwaKm6U58LmBg9tEA1vso+GU0t
	 ZI3CTMJbwpZT0e0v4MJHs0ruTwPUblCssCJ6scZphZ83/a1C5ktVM8Mb1je9vTC5+H61Q
	 BoTS45f4K+LikU/KQG1HmvtsEC4hxmHoHfccQOnx65VrjIaFpnFJhBnpFAkkuBk20Xw==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4Zc0wK1Fvdz1dmB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1744666577;
	bh=88MA+3dpCzG0KlCTI2Ktn4nbQNVAXsSC0seN+hhBW3c=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=daWqE4DTuaAvLbwQnnKmJqYEFB9U4ic2BxGuuh82fnE6QA7KoNPvSnOgjvbB4Tcpp
	 2N6J9MGJGC/Ttm5/rDFQSSNHrKpbG6rN+DyaWCqhv/12ame1Qzee3YkllMef4dRA3V
	 MOStsQMefwnMwsAtT40B4/iK+AGeLa55c0bnC9ujIsWEBn9a05YAEYKmWxQn/e5p/g
	 Ee7rgjeMrvEc3PlVJt6J95Klt2IGOXPuhI3RhgDEnRknooDEU1gCKMO3qMB45C0n72
	 wKcZkdLjjJB+9E7t5Ynno1wlqMulkEzKdH+7V4Ci5Mf+cLu5xV/bjCwa47B8eSyLPc
	 VjwUGo8WSopEQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Zc0wK1Fvdz1dmB;
	Mon, 14 Apr 2025 17:36:17 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4Zc0wH4jp9z1dvl
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4Zc0wH4jp9z1dvl
Received: from YT6PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazon11022106.outbound.protection.outlook.com
 [40.107.193.106])
 by lists.lttng.org (Postfix) with ESMTPS id 4Zc0wH4jp9z1dvl
 for <lttng-dev@lists.lttng.org>; Mon, 14 Apr 2025 17:36:15 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7VuAC0JrtCPSINGm50P1JcM3MXfBiAzKpk31TXL5N6gWh5+GjZrLqvtaU4iO2HLU7oIC6Y2c9hTh3jpoWqm3zRC0qQTocQ8gyWEIdVKnoW5BloyxLBi1tYZMYgyOFm7qc1dEuijG9IqiC5JHTwbt7EkSctxLwL+FSBPjpZRbZOFaqFF/rFJSLgtQcJL66UfOZY65yK1WU+eEf+0jmzGNTjDAFHSesNoIxHK2YSZ6kZa+OsZaS5gx6+jvQp6X/ENnM81kIuG+x3mLUApPm6nyE0edUdxSK2QTqGkCjc3gRIvv13pMwRKC7VdwwqTXVhH+Z/fozc1Mi9d8vwsPbEO0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0T+yMp21quPQFP+nNN6HY2gj+CxsFtaDcCyR7NLqPew=;
 b=mhA3k8kH92oQbFYTx2OuDOiTGpgYKGfdyfT6xDDAYzKBb3l245pDvHOepBsA6U6P7LC+AH0hOn3FcEdobzgnEIDYt5+1J2mz2RfMewAvrRpeO171gISwK7CrCChBe+5dhIVyKRbnOrQMRAy1yZmANkXrzh578VfijlDNSwBO6llZ9DDrKSH49RIGEuOqLOYfljqVDwAcwr783E5z4CfpzzrwzpriluZEDZI6vciybdj4df8lz5caQfWRhu0pIUNdSfF0nnWrDgn+laKxmuIw6IJmQRX0+X0g11TKT8yZ5EtNxi3ssbQ7Ff6nP8Z2kBNE+eaMQNO+EVZpn2Z0O/1xOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PPF40FB456DC.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::433) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 21:36:11 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%7]) with mapi id 15.20.8632.035; Mon, 14 Apr 2025
 21:36:11 +0000
Message-ID: <784e1466-92b5-4164-bca5-89e6ee1c1ec7@efficios.com>
Date: Mon, 14 Apr 2025 17:36:09 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org,
 linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RELEASE] LTTng-modules 2.13.18 (Linux kernel tracer)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXP288CA0031.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::29) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PPF40FB456DC:EE_
X-MS-Office365-Filtering-Correlation-Id: d89b0046-42be-4d1a-4892-08dd7b9c5fbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHpybUd0YTBkK0ZxQVdpNVpqT090MGRuWDdqSUZMajVNR2dLUUFEMy9hN3hJ?=
 =?utf-8?B?dVBqVS81RmdtNE9lYXVMcExsVGpCb1BHcWpmLzFVUjlzR1Byclo0eE1ZSzlY?=
 =?utf-8?B?STRPYUtUTWdXNzV0WG90Zm9yWUVpZ1E3VWtNM1RRWnZuUEpQVWo5Qm9BcERs?=
 =?utf-8?B?NTVYckxJOW1xeE9EZWI2TVJMK3k1MG5hblNTZjZPK3JTNlhjS3BibVdaenI4?=
 =?utf-8?B?MmhERWxSOURQTzZzY3VFbE9LVGpjZjN5dzlGU1R5aVJLcnhrVkVncWJmMExi?=
 =?utf-8?B?ZHZIRXF5a1lTMVREbkp5eWFDZCtodzAycXRDN1VPNDB1TFZsYUEyakloNzRH?=
 =?utf-8?B?OEY2YjhQVTFNU3JkZHRXTEV4Y0NIRFgydlk2V0l4R2RvNFpxN2NqdHlxVGhX?=
 =?utf-8?B?MjU4TFFzYW0vdXh0QmVMUWQxWkV6Zkx0bGh3NVNoNzF3cjBEaUw4UC9NaStp?=
 =?utf-8?B?aXN3OFp5eWNxbkc4Y1h5MlR5T0R5bjlsc0I5Mlk1VW9IMU5FMmpXYUw4dEJG?=
 =?utf-8?B?Rjc4Y205dy9KSEVwcHE2QUo2ZVc5WmI3TVdmamt4NHpWdXdLWFg0ajFCemtu?=
 =?utf-8?B?OFZWbXBPQzB6OCtueWgyZjhEdzNickMvWFNPRy81N0QvVExLKzUwVmIwcUpw?=
 =?utf-8?B?RlpVVWpPRm9tUytYNUtSYTBBUFhGRTY0ejAvbE8rSDBkL0J6anVGSGpaYWVI?=
 =?utf-8?B?OUxMTHJLSS8zRVFOb21hOWpJeUdMaEs4NXRtRWZyM0JzZGN0SjZ5NHhxRyth?=
 =?utf-8?B?akF4QkZsc05wcnlJRURrZ2VBVHYySEsrdVpqaitBTUplNk5ETVZxeG1UaTQw?=
 =?utf-8?B?V2RlQUtGVnlwNEg1UmV1OWhpc2Fuc05xSlR6VlFVVDcyVW5NZHhxaVpVYi81?=
 =?utf-8?B?bm9LUFFhZFNBdmxVSWxGQXFPNmhidXZmb0FEZGROeHJwc21kOHhxVGpIbG1N?=
 =?utf-8?B?a24rdlhySm9GbThYKzdXSERIa3hzTVc5am5rYlU0WTNENFgvbUNGbXVvbjJs?=
 =?utf-8?B?SzUyNmNINCtiNWs4bml3ejJtYStpYUgvaFpzRnh4RmZXWW9sVkhuV01JSVZC?=
 =?utf-8?B?OUdON3hQeEJXODdCS1Y5ZktOdWFmTEVBdmlyN2RlQjZuMWtXRURzWHkvb29S?=
 =?utf-8?B?YVpLbmdiVTQ5blloZEc0VzJPM0hWZGR0d0ZiK1lJQVl5ZjNSdjhOZGtDb01y?=
 =?utf-8?B?SnYwL05GRHEzaXlYa2FnV2lCdGlXUW5LbnE1M1hmdFJqWVlsNGh2RHRHZGhK?=
 =?utf-8?B?TmtXV2pKeTNpK1M1UERoSWFiakN3SU1zS0h5R3l2Wm5xV0pqRmlyc3pydHZR?=
 =?utf-8?B?eTV5a3dzRVdMN0VvYnNmMGNyYW85d2QySzFHbTFwUVI1bk1yZGZzNVpUelV1?=
 =?utf-8?B?NVR2NnBhTy9odFdlbTNvb05YV0hhczdmSkNTLzN1bXMxYnIxS00yMXRIclVx?=
 =?utf-8?B?MUp1bDNWemwrdU10MGlySjJCbE1yWTFNTmdCUW9UeUowanJINGtBczZ5VW9C?=
 =?utf-8?B?ODBjWkJxMEt2NnVIdkNSMlV4cUhrcmFaSkF5eXJBMXJPVmllNkYrWEN4Rldy?=
 =?utf-8?B?cjVGMmVvWFR1d1cyTUZOcnRpQTdiamNDSDllNE10L0Rla0NIQXBOanhLUmNR?=
 =?utf-8?B?Z3podFB5eWszeENuWDd5c2E0azQvTy9jT1hqTDd5a0wyYWJWNnNVbDZKckZl?=
 =?utf-8?B?enVPZFhiUTByU09qdTZYYVZ5cFpRNnJGY3V4aXRDMDh3d0J1SGFOUWIrWXpx?=
 =?utf-8?B?Qy81R1U0YlVUTW9TYnBFRFVvWWRVUkJ5eER6dmRLMjBkUnJVSEpzdmVGaVp5?=
 =?utf-8?Q?5wbbDxVH2pDdD9WzzYL/D9gwj1pM6AK6WRxUg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk4zckJjWlFLRUxRTVBSa0dCYjMrUC9TbStrRVg5ZEdrNExFRXFPQkd5SXNk?=
 =?utf-8?B?YU4rQld6TVNvYnNuY2NFN05xRllnYm5qdXpoMUZMWTZRNlZJZCs5alZaQXc3?=
 =?utf-8?B?QWw4TW92SnNPbTZmQXFRanpJaGJ6ZS8rUXpROWhxZmZ1TmhIbmRTSkNUMzRn?=
 =?utf-8?B?ZnVtS21maWRyV3JRcnFIMkFIWjRxRlJ0R2E4YU1FZFhkWE9rQVBGUzdsdlVn?=
 =?utf-8?B?VDFrNXo1TDFTMCtDb0R5b3hKdUZLNmZRWjYxV1lndndTZjNJNjhjYlVTUjcz?=
 =?utf-8?B?bHpZaTBkK1YvcTl2eE9JY3lmTzQybHJQTmxVcUE1d2EvUUV2YnZYeDVHcFNG?=
 =?utf-8?B?eHgrQWNhS0hRNXl1TkNrZjcrS2NuWFdYemhCR2JreFBvcU9PanhZOE9QTlBX?=
 =?utf-8?B?a2k0blZ6TXpkemo0SStNajZUZWtZSWhNY1hXVzNhTnp6UVZXYmsrc2owc0tr?=
 =?utf-8?B?dEFIcCtnWXZKRzlQM3NOb050UGdyVCswWDJTRjFJQXVSYVcydkxxL3R4M01R?=
 =?utf-8?B?Q2lMZ3lPOXRtM1NENjliQllEb3BzQzBZZ212L2RobXNsNkJYN3VyTXBJU1Nx?=
 =?utf-8?B?WStCSW9ubzZDVDNPUldoMGl1QStYUUpNYjk4UG1YZ0JhbGFDZWo2RUZuWFp0?=
 =?utf-8?B?TEpKUTgxNFQ5Wkpma2F4cWdyNUR5YVNhTlVoOEllNFA3bUZuVXhWWU44TmFW?=
 =?utf-8?B?VlpiZGxDTUFNMVVFSUFGL2pVdjJxSC8xcGNGNG5TYk5OYkp5MWhZSGREWktP?=
 =?utf-8?B?SmFNM0xnYm0rSkpGbzNIU1pST0JwUkFEWVVQdDUrZHdpUjhzUjZBcXBGYjBZ?=
 =?utf-8?B?TlFGdElJT3RNUUhPOXRjN1ZLd3dyeFQzcVZDakFnN3dQa1p4dVBOR3BUUFVI?=
 =?utf-8?B?VGdQSEJCYWY1NXBLbHNyOGdoUjhXVVJBQmJGamtBOTlBcnhjQUt3YjRLQXJM?=
 =?utf-8?B?Tlk4YXpacGJvZkxUb1BwVDdEWGVVaXg5bGsvS3ZuU2oyWTNERFo0di9UQkMz?=
 =?utf-8?B?RjhvcHhhUWFVTnh5bWpGVXFPY2s4MFhwZnFrZkE4NmpycWUxUmx0R0VtQktY?=
 =?utf-8?B?c3lLdHNhSlRkSlpIY2tUTkl0VktnSUZDWFdRalNyZHE0Z0hGSjhLZEVRMHZr?=
 =?utf-8?B?UjRNUGZ1M3VvbDl3TVlnK3BEOUp0eTZQRkV1Wm96RDVIZkd4cXd6Q2FKd2lw?=
 =?utf-8?B?T3pEMnE3czVHZStGYUd1M0FURlZsbUYrYTllaWo0K0x6NXJXalVLdjNjRlJC?=
 =?utf-8?B?MS9nTC9hYkF6ckpwZWd0bkpwNDZSeVNTeUg1OG1rdUtHU2R6K1N6LzZUaWlZ?=
 =?utf-8?B?bk5zZnI5eFNrejQ1cVQ4ZEo3YVdTQUpWWE5qcVdmakNDejZnWEt4U2ppc0Q5?=
 =?utf-8?B?cnVkSVAwRkZHWk41YklUWTQwblNzK2R4NnBqK3UzWVl1YmhjeXJITFhna0kz?=
 =?utf-8?B?UXB2UlJaNmM4RzlYcWtac1JsbTl3eStsS3A1NUFjNmQrWWxKb0p0WlhnUkQw?=
 =?utf-8?B?bzFNVjNaRU02cmFzTCtVSUl4OXlVMWd3SVYrYTluWGlBdTlMSWhnVEpuUGRX?=
 =?utf-8?B?WkpVUm1oWXF2QXh0QzdwTlVBcDNSMjRLZG13b1hnaGpKeEZFamxLM1ZzVThL?=
 =?utf-8?B?QVdZUllITytoL0hjS1dESU1ObmFnVWtQbXFIWjZ4d0dsdVF0YzhhMmViZjE3?=
 =?utf-8?B?citvUDM5T25KTEo4Y2lVKzZObnVVdVhNVlJwYkVEd3ZIUGlrK1V5RG5IekNL?=
 =?utf-8?B?UEd5WWtLaXd1aDJGK3haRThhUlVBNmlsUStYOGFYUk1jV1VFSitEN0laS2Iy?=
 =?utf-8?B?ZHFpYzdhUzRpeXhpYUdXekRkQytCZzRHRnFqQXVrcXRxRzJZL2VMd3U0bXhZ?=
 =?utf-8?B?U2NBbitxY3I5TVFIekhqd1RZdjFyOHQ5VmNJMzFjM0RvRWM2alZrZUx1RjZG?=
 =?utf-8?B?Z24rbjVaVjBacVU5RU55VlBab0VaL29SekdGSEJJNEIxYkU4emVKaGxOYkN1?=
 =?utf-8?B?R1pJaWI0T3JXRDI4dDlHRHNTeWZlNFhHbXJEb2o5OEQwM291VFIwVlZDSXJL?=
 =?utf-8?B?NjdaMCt3OTBFRjNPT3Yrb1Y4a2l3ZlAwN1IxaHI4NmFMblFYQTM0N1BBa1RD?=
 =?utf-8?B?VnM3TEZvM2VGNWxUWlZydnpYY25hOHIzZXBDUGhVV2hVbmc2RDR6RGFpU3hP?=
 =?utf-8?Q?dU/oU3OkoragXzozUuNibM8=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d89b0046-42be-4d1a-4892-08dd7b9c5fbf
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 21:36:10.9412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3TsywwSECPXR0Uh6hiD69YMPd8WVYREAAHwqcIFJzy/T91oPMuDb9okX6FL1aeeRNW4xunKM9PD2yT9VdbAIETmicpmRBikFieDm7CyFOJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PPF40FB456DC
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

This is a stable release announcement for the LTTng kernel tracer,
an out-of-tree kernel tracer for the Linux kernel.

This 2.13.18 release mainly introduces support for newer vanilla and
distribution kernels. It also updates the generated system call
instrumentation for 32-bit ARM, 64-bit ARM, x86-32, and x86-64
so the more recent system calls (up to kernel 6.0) are instrumented
in with detailed semantics.

The LTTng project provides low-overhead, correlated userspace and
kernel tracing on Linux. Its use of the Common Trace Format and a
flexible control interface allows it to fulfill various workloads.

* Detailed change log:

2025-04-14 (National Gardening Day) 2.13.18
         * Fix: trace_balance_dirty_pages parameters changed in Linux v6.14.2
         * Fix: trace_balance_dirty_pages parameters changed in Linux v6.15-rc1
         * Fix: Generic `compat_sys_rt_sigaction` did not exist prior to Linux 3.9
         * fix: Add missing 'pselect6_time32' and 'ppoll_time32' syscall overrides
         * Build fix: arm64: incomplete landlock_rule_type type
         * Fix: define old_sigaction as compat_old_sigaction in arm32 compat
         * Fix: Use ifdef for CONFIG_COMPAT_OLD_SIGACTION
         * Fix: system call instrumentation build failure on v3.0-v3.10 RT kernel
         * Fix: add missing typedef and forward declarations for old kernels
         * Add generated arm-32 syscall instrumentation for kernel 6.0.7
         * Add generated x86-32 syscall instrumentation for kernel 6.0.7
         * Fix: define old_sigaction as compat_old_sigaction in x86-32 compat
         * Add generated arm-64 syscall instrumentation for kernel 6.0.7
         * Add generated x86-64 syscall instrumentation for kernel 6.0.7
         * syscall instrumentation: add missing forward declarations for old kernels
         * Revert "Fix: powerpc builds with linux v6.13"
         * Fix: jbd2 tid type changed in SLE15 SP5
         * Fix: migratepages removed from compaction_migratepages in SLE15 SP5
         * Fix: block request field `rq_disk` removed in SLE15 SP5
         * Fix: REQ_OP_WRITE_SAME removed in SLE15 SP5
         * Fix: genhd.h removed in SLE15 SP5
         * Fix: Missing scsi/scsi_request.h with SLE15 SP5
         * Fix: powerpc builds with linux v6.13

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

Enjoy!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

