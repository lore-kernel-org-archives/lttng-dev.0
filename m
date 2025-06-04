Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6CEC5B543
	for <lttng-dev@archiver.kernel.org>; Wed,  4 Jun 2025 16:07:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bCCCL0V4Zz22KW
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1749053247;
	b=d3Snkag/pZzrx3eDZYGoizPNnf/TLNtj408o7KqaZI2fEGiGlnv5kGSRW0RMMeIoZXII
	 u+2jCEt6CIg9doi0+v+I670HhLkOPyP21KYfVWbU2nJzK7WZu4jVxeGhYiDOcakYJBH+O
	 fLpTncvNwMHSMP5KdlBI5wX+nsY1BOXbFobBppZUiPuWFBronth1f4rUXlw8X5SB7luiR
	 MrFHtU8O8sZzc91Sc5RK5bi3pX1Zsf4fVUBXZAlOZUkL49P3jHTo8VyzR9NJllCbqad3B
	 0+SuYGNkTC4q6oTgT8mN6HrzglTTB7JnVqgVZICuVyM7lssWmbsIeAS0F9qFzdZFC/w==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1749053247;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=seMuNEWj2ii+/VzAqswmTytHeXCQ5iOP29gKsaGeJo8=;
	b=SaVLxSplGgVX8p5/OXdev5tpztG9zcYvr2uE6dU+So71Cz4xZ2xiOkTkJFyq+qmVgqGM
	 qYM0CJ+aCNvZ80cCWJvWTesuGarjcMZfeYilzOwe/C49kFU04eOBBqg/xZAtzT+w3bT0P
	 GaMDFziozuXyLb9dcGD8X0Y5lWgEyQG9se7SPgHTiSl0psmdq0ceSJslJuVX+Hl3iPvEz
	 d5mogcE5pWfuNyXSceQXPbCnoHFIOoOSOz5q7h23UEsZsWrmCq4McQybPCZ1iUCfBqzEz
	 Api2jZENB/VztX1UfgyVHEZ4taEtgu3vk34sx4bpMGmEY334J53LXnRv3s1CIQMGXJw==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bCCCL0V4Zz22KW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1749053247;
	bh=seMuNEWj2ii+/VzAqswmTytHeXCQ5iOP29gKsaGeJo8=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=riZhOaCoO8rR6OOV+lnsbvuEi4vAKS/+fx3Q+wfREvUrie6Du+gKgM2/kbufAgURV
	 6ylcHZyI/baCJRHnAZtZBW19GPYQulrGAkFV894/7vJHI1spPARL+qSXvVUec5E+jH
	 geuoYju+gfIWNePCHPNSCUfA3Vz62SYiyxjEfzeQ+ZSOssqgcEqL6Uqh48qj/XcwiE
	 aEI+vLHLnWjqDBgtTh4PkNo7vijlHPRANTEhFJrlWca6/JdWfe6TFhmBBzI4DJNNtY
	 fSTcMjL89QYI7cU2q7Lg0e994KBV3PApfvYc9G5T6mxtAkYi+zniSR07pQ2xifPcdh
	 kJy1zO9bQBr1A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bCCCL0V4Zz22KW;
	Wed,  4 Jun 2025 12:07:25 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bCCCJ3lJ0z22KV
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bCCCJ3lJ0z22KV
Received: from YT5PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazon11021103.outbound.protection.outlook.com
 [40.107.192.103])
 by lists.lttng.org (Postfix) with ESMTPS id 4bCCCJ3lJ0z22KV
 for <lttng-dev@lists.lttng.org>; Wed,  4 Jun 2025 12:07:24 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHwc8zBI8k0DBcemY2I6TPKWqsSLk86NenQCF7ulsrfj/20qOsyCNB6lGmqlnJB0srK7E8b3rL7hfVgB7Wp28QFs8MgaIKU9kV2UnyPyx7ubzF22BbaI1JXbInT3k1LGMXW+13KozHWwIiCNAnuQcWeBJUQF3Ma1+609rI5tJshwsuDQ7m3TW2ZMbdnqE1n0kSTlohHJRl6HWyfCjHXPI5ZImSTH31ENPQN+MJx5ddEC3YIkwDCPup/yvbzMbwiJgE6YWHUMKyunX+xz7EQO0sJ3p1Xef5vaEpDxEzjARN8zZXdfvxUmDT54Y+64y5klN6t28RWI6lOmVVmvaG5X4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVhYjnRxHPtZmxEzmRGFBfAAWaNO5YTAX9AH7ciESLw=;
 b=bj7x0DBX3UblvXQFPpK+Od1zXZ0PDfPOEJ9N/sGMgkL9O6ShWJB5YvBhKBhMgpIwk1MBv7F4nxw2vkc6U3YHDcPYdwQ6I3YoYFiAu67sPen7Ep/rcYDfCx2uQzxOYtGndsOByNBP4+toZWSFIGOHrzD3U9Z6IScaUXePmiRBbY192CVt5KugVHqP4qc0fV+nqnFTWHMagP3F/SQvdNnFZePswhiq0OOABO55Ik9Wha2Jv2aiRzsmRimshVany5UHJpeBdhDlzvpPI4VUr1tVgx5Tdgo4W61QBDX7XoOM17RPcjB8HKRpstbvnggLXwp/GIOmYz98op9Sw1Sj4O4rzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:5d::22)
 by YT2PR01MB11255.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:145::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 16:07:19 +0000
Received: from YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b5fa:c0e6:e5b7:54a4]) by YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b5fa:c0e6:e5b7:54a4%3]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 16:07:19 +0000
Message-ID: <5432d480-263b-4091-bb6e-87b6ed715262@efficios.com>
Date: Wed, 4 Jun 2025 12:07:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: LTTng kernel tracer writes packetized (binary) metadata instead
 of plain text on Ubuntu 22.04 5.15.0-140/141-generic with LTTng 2.13.18
To: Shreya Tripathi <shrtripathi@nvidia.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <CH3PR12MB9731EE42C8448E1C3AC88F12CA6CA@CH3PR12MB9731.namprd12.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <CH3PR12MB9731EE42C8448E1C3AC88F12CA6CA@CH3PR12MB9731.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQ1P288CA0004.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::22) To YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:5d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB6319:EE_|YT2PR01MB11255:EE_
X-MS-Office365-Filtering-Correlation-Id: a515401d-c601-40dc-040d-08dda381e1f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2E1ZFNxVnhuRmIzSzBRbVdGZGlyMmFGN1Y1YlFmZ1ZVTFZJdzh1R3NzQ2Ux?=
 =?utf-8?B?bFVCMTFCa1BuQ2lpK3VSRDhrcjZIWWRDUzFwQ3dQQUptSGJaT0kwQWxCVW9W?=
 =?utf-8?B?c1lVaXczb1lKZDRUQWJlZzAwN016dlRhamc4SUdVQmt5bkxaUmFQK3F5TERF?=
 =?utf-8?B?U1JYNDBHeDFHYmtUL2Z2Zm5JMnVkTnd2bDdKTitjeDJ4UUlWd0k5bDdJUERQ?=
 =?utf-8?B?Q2lVY3RjTEE0OXQ5cjF6Y29vcC96WVZpUWQ3ajY1djJIYUpFa2taWFlvbVZN?=
 =?utf-8?B?QXpqakFXOWdOcUJnRmNpMHlsdXA0T3BFREw4OW9NU2grOFNVMWRxS2tla2tH?=
 =?utf-8?B?SXFyQTl1bWkxUEI2UUljNGVZK1lXaHpRQm9CejVwcGFxeEdMRWNrRnJzd2RT?=
 =?utf-8?B?SjFOajVVZ0dsbVBZWHAyTHR0aXl3c0pYakNPRFBOTjdoOU9URGdJYXI3b2Yx?=
 =?utf-8?B?KzF3ZExDaVJTaitEa0dsMXpPNTljNXYvaGk3NytUOE5qM3cvd0pNTktDbEVH?=
 =?utf-8?B?bmtBUWNtcXY2NnpKcjFLT0ZTbkNUN2I4MWpDUXZFWm5RTEpMblNWdjQvWDhJ?=
 =?utf-8?B?Tk90c1BodUN5RFRwZDlsem9CYk5JYkt3K0F0SEczY2FtZWNOQktzTW94anBK?=
 =?utf-8?B?U3FjYVVWZ1M4MVNvdjlrSjhmV3VleGNTakd5bWtqdktjakxhM3Q4OHlmRmk3?=
 =?utf-8?B?UklUWG5CZ0g1ejhrSDB1aC9QUVM5M0thRUYvN0ZmVEpCNlIrZkhPYUlXS3Rv?=
 =?utf-8?B?bk9kblUrdnFJVTByWHJmQWdrS2VKZFBwSXBZcXBPK1VFcUNPYTJKVGpDUnVY?=
 =?utf-8?B?VGpZa0ppc0oybjFOK1JzdUtqMGtxS0k2eHliRVRNcHlRYlBUYW5COGtoQ2Va?=
 =?utf-8?B?NVpVMW0xY3dyUG83NzBVdlVhU3RZY3EyQk9aZ0VEYldYVG9Kd1NaZnNUVDBT?=
 =?utf-8?B?ZEZFay96czVVUG9CMEJJL09Lbll4K0llZEZtNkVCb1ByL3ZVR3dMaUVVZ1Jw?=
 =?utf-8?B?WDVFWWhhZCtBZmNQZThlV2owdFhMbUFjaEhLTFlEUExPcTdVY0RYRktCN01S?=
 =?utf-8?B?bWIramxhVHNZN3VoRFdoYW5YZlRVMWhZOFB2Zyt1dFY5TFBFOERkRDByT05I?=
 =?utf-8?B?UGZ6UFNaNFJ0cnh4L1lZU0ZLZittS2R5UDNOV3o0T3FIR0lZT3VXaDFPM0lY?=
 =?utf-8?B?TjNUUjBqa0t1S3BqYkZvLzVLSTc0OUFWeGgwM1FTaEE5Yk5scHdaRUtZL3VB?=
 =?utf-8?B?L0RnVDJjUUVhYjF3bC9SbTNTWkNYQXdJS2V6eExTRHZvZU1XVzdZc0U3WEht?=
 =?utf-8?B?V2R0S1ZTdHI2YW9CNWd1STBZMEpkNlFrQ214UzlzSXVyT3BCY3VDZDFZKzE2?=
 =?utf-8?B?TGdlck1TQVhQWmdsc2pyV1Y0WS9rNjF2a2pwemxaT05heVpiTVBieE92ek4r?=
 =?utf-8?B?SDY3VzhBRjNyQzhLUHFSKzQzNGo5bWtXK3A2a3kweE9yWHR0dEJwWFFBT2hi?=
 =?utf-8?B?c0pSMHhVUTY3VEp6R0N3T3N4OUpvSEpZWUROUE9kdlhERGNMakdoUkV2VzRZ?=
 =?utf-8?B?VGZudGNFUjBQV3dwckoxNHRPWW82eGFhTDIwRHlZaS9Nbncxa3RJTkszSEt0?=
 =?utf-8?B?NnEwRmNEZkdCbTV5c0czczRqT2pnN2QxY21Nb0w5Y1owRGg2aGY4ak43MVE4?=
 =?utf-8?B?MjROampqSjRZUHpOTm5icGVjbXBNRmRrWnVCU0lnTGJjczlaMUdqSDJoUXF0?=
 =?utf-8?B?MGdzc280VHB3cVQ3WXc0c00weitnWUNCTmVyaVQwMklnU0p4UW5iek9NdFox?=
 =?utf-8?Q?4LQB4NVX8QSRar9ToOodQV74D5WMbkYgFpaME=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S29HdFJCR1hVcktKc24wa09ZZ09WT0JsNFVCNXB0WThiVkQwMHJneGhSYXJq?=
 =?utf-8?B?T3VnSE9aRmwwbmkvVzNERjRNMWJ5Q0tBUFNjcVpkdEZ3THVxZXNneVJ1WmpR?=
 =?utf-8?B?NHFXTVRWNkw4bHMwV0VRVmVraFZkT2RBSmJ0SG5zYVZJei9RZTdZa3FvU0Nv?=
 =?utf-8?B?VGNqZEpBbExMaUY0aGs4T05paE5TV2MxV3B2aGpQVXJ1QWhnVjJ6YlZuWjV3?=
 =?utf-8?B?NUY2TEhmN01FMlNFY3BJU1piaEN4WDUxY3RXUWNiNjFtWSt5VVY5bmZtK3Zn?=
 =?utf-8?B?bVR6YzZCRUhPMGZmNkpKRkZYc1FCM0Q0ZnJ3OTJtQjJYcUt0cUQ0UXNTUlZi?=
 =?utf-8?B?MG1XNjFOTVVucVBEdzRPQXU2WWFGMEJPRzRPOXI3a1UxSHdDc2VzbEFPaXdK?=
 =?utf-8?B?QkZMcmY2RjJvZm9UUWZTQ3ZYbkhZVlVtMzlYZmlaRUhBM1NwR1VkOFh1VTdJ?=
 =?utf-8?B?a3R3YXo3S3FMVm1iL0cxS0JhcXVEbWtyQlBwbFV1cHRBL3UwM3hYODhsdEJz?=
 =?utf-8?B?MnJsUUd5MUxiQm5HUkZ0aU1xd2lkb0x6V09lMXUwVmV6NU9nMlI0ano2ZHJv?=
 =?utf-8?B?bG8yeFpkQWlnVi9ocHRjb2c1aDZFNzFwNWMyU0RhUHg5N2dvc08zMk9iV0hr?=
 =?utf-8?B?N3ZNVko5T3gxS3pCdW1FcWlHdXZ3Q0hkcUk0NTdkVEJwYzBHbHBiVXNVT3dv?=
 =?utf-8?B?MGRXNWc5NjFjNlRQY1FyOXpIVVhTMHhRQ2thWkw1R2RZVkxhTGt4V1doZUlx?=
 =?utf-8?B?MXErRTc0WXl2UjlpS016TVE5ZEo2czZyMmlvME5hNUd6YnRuUHNqRlAxUytS?=
 =?utf-8?B?YTdlTHlKV0Y0bi9ieW5XUTJBYnMxV0F6TWp5Vzc4OUU2dk1VSXFRdi9XaDhO?=
 =?utf-8?B?KzJXaTlkMUdWLzl3ZTIrUUQwVjhPaEV2WlZXb1FrVkFZTUVyYVRPSElNZU5V?=
 =?utf-8?B?bVptTnNGWHFrS0FBTU5sWW1KUUFNRDBlR1B5M2xxMGJFWU00YXNlbDBxWStH?=
 =?utf-8?B?RG1BNGdlcDhHYUlpVDJpWTlXajlUOVFoYXk2dnR2dTFhMHdHNU5SOTZuU3lm?=
 =?utf-8?B?NWJxdmR2UGM5cHZCeWVpS3hUWHBwVU5ZeFZac3VpMXk2QzNQMVJ5YTRvY0dG?=
 =?utf-8?B?VGYvUHU0UTh0bWdxVjFjem1XdWwrWTd0cHloZjVyWnhFMVRRTTBiamswdHoz?=
 =?utf-8?B?MlJEd0pSMDdXYUQyR2ZlbW1zdG9BeTBtUjN5M0x2Z1BMN1Z1cnRzVUlLU2Fz?=
 =?utf-8?B?bjF0TTdVZkNjUmY2dlN1ejV2T2Q4RjNjak5EcHlxOGlqMkZNclcwOXVTMTVU?=
 =?utf-8?B?RkZTdUczUDdYU3ozR0tPcVZ3cTRZUzdGU2lMcHJFcnhYTjdvZitpUFk4ZGZS?=
 =?utf-8?B?Z05QeDlCL2lZdEtHNWdPU0VtZjVjRkhiMGpBcFB5YzdJd1UrVUU4clRSUVJ0?=
 =?utf-8?B?TWIzZnhpZnZrbW9iVXNaeFJlbGJ4YnBRTFdhT2FKODBOTFY0NVVrUTNyV3pu?=
 =?utf-8?B?YWFxY0F0WXFnWHFKYXI0eTNpdnZwY0JKY3pVeHlTNVJoK2ZaMnJjQ1hwcUtH?=
 =?utf-8?B?bmIycXg0R0NLMkpiV3E2YXBWM01pTDJWVnBmdHFIdWJWM3lmMkZjV1MweGFK?=
 =?utf-8?B?a0VFb1UzdEsvQjhSWHI3M0phVllKTW1FNWFQWGo2L3dMbXdIUHQ5TmkxT1dO?=
 =?utf-8?B?UHVNaGw0QlBRaGhEWkpKTFN2RU1kUTUxOTR5TDBuL290UmFnZnJPV2ZXclZF?=
 =?utf-8?B?OTJhQ0ZvSXFoLytLbkl4YjQrMGJQMS9tM3g2ZS8yTXlWMEZ4YlJ2NjNXa2xl?=
 =?utf-8?B?SzJuTDFOTHJEdVVqOGQzYW4vSUNyQTdWc3VKV29PTk9kVXVQbDFscjhqTHdE?=
 =?utf-8?B?bXc0NU1CWmVnWjlWNGNXRWxTN1lqYW1idkNJRDR4RHlQQUh3OWo4dUNLbU95?=
 =?utf-8?B?REVwZUVTMkRVRjNzVjdjREtOdEJMWDVVM2hXbjU3OUVxb2ltOUVJampWQnFD?=
 =?utf-8?B?Kzcwam4wTmwvOGJ1ZmcwaitUMEJ5MTdiWGNaL3NscE5tQ3NMV1BnREREanZp?=
 =?utf-8?B?UzJFa2VzeDJaZkNzMTZaRTVXMDRkVmNWOW1rRTN5alV3T2orZlgxaUZ3Ullr?=
 =?utf-8?Q?Tx+r2RSLDa1XyeTcaorrSx6jE?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a515401d-c601-40dc-040d-08dda381e1f3
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 16:07:19.5095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCl+w+lcaYgre1DQa1YU5ozv6wVBxrddpGsKJB/JFCyxBPpnNfH6dn662AO2P6UxYYHBP7NUmn4S8pBlkZXP/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB11255
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

Hi Shreya,

It's more suspicious that the UST metadata file doesn't have a binary 
header.

It's normal and expected that metadata starts with some binary 
information. In the case of the UST, I believe it's the 
metdata_packet_header as described here[1].

Similarly for the kernel metadata file[2].

Using the same versions you described on Ubuntu jammy I was not able to 
reproduce the issue you had. Both the UST and kernel traces metadata 
files had their binary packet headers intact.

You stated the following:

 >
 >  *   All LTTng kernel modules and user-space tools are version 2.13.18.
 >

There is no release of LTTng-UST 2.13.18. Could you clarify which 
version of LTTng-UST you are using?

Furthermore, commands to replicate the issue would be greatly appreciated.

Finally, can you confirm which part of the trace babeltrace2 is having 
an error with by choosing a different sub-folder. E.g., in my case:

```
$ babeltrace2 auto-20250604-160417/kernel >/dev/null || echo 'Error'
$ babeltrace2 auto-20250604-160417/ust >/dev/null || echo 'Error'
```

Are you certain that it's the kernel trace which is causing babeltrace2 
to throw an error?

thanks,
kienan

[1]: 
https://github.com/lttng/lttng-ust/blob/611ccd9f2f6581faa48b47881520069c30c31daa/src/common/ringbuffer-clients/metadata-template.h#L21
[2]: 
https://github.com/lttng/lttng-modules/blob/d47de02f489686d335ee570cc5060d653757d3cc/src/lttng-ring-buffer-metadata-client.h#L19

On 6/4/25 1:00 AM, Shreya Tripathi via lttng-dev wrote:
> Component(s) involved:
> 
>    *   LTTng-modules (kernel tracing)
> 
>    *   LTTng-tools
> 
> ________________________________
> Component version:
> 
>    *   lttng-tools: 2.13.15 (lttng --version)
> 
>    *   lttng-modules-dkms: 2.13.18 (modinfo lttng_tracer | grep version)
> 
>    *   Babeltrace2: 2.0.4 (babeltrace2 --version)
> 
> ________________________________
> System information:
> 
>    *   Architecture: x86_64, 4 CPUs
> 
>    *   OS: Ubuntu 22.04.4 LTS
> 
>    *   Kernel:
> 
>    *   Linux shrtripathi-vm 5.15.0-140-generic #150-Ubuntu SMP Sat Apr 12 06:00:09 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
> 
>    *   Also tested: 5.15.0-141-generic
> 
>    *   Distribution: Ubuntu 22.04.4 LTS
> 
> Expected results: After running a kernel trace session, the file /tmp/my-kernel-trace/kernel/metadata should be plain text, starting with /* CTF 1.8 */, and be readable by Babeltrace2 and the Python bt2 bindings.
> ________________________________
> Actual results:
> 
>    *   The metadata file is written in "packetized" (binary) format, as detected by the file command:
> text
> Apply
>    /tmp/my-kernel-trace/kernel/metadata: Common Trace Format (CTF) packetized metadata (LE), v1.8
> 
>    *   The first line is binary garbage, not /* CTF 1.8 */.
> 
>    *   Babeltrace2 and the Python bt2 bindings cannot parse the trace, reporting errors about invalid metadata.
> 
>    *   Example of the first lines of the metadata file:
>   W�u�kzM�W{L����^l�typealias integer { size = 8; align = 8; signed = false; } := uint8_t;
>    typealias integer { size = 16; align = 8; signed = false; } := uint16_t;
>    ...
> 
> Logs and context:
> 
>    *   Babeltrace2 error:
> 
>    At line 146 in metadata stream: Invalid character: char="", val=0x1d
>    At line 146 in metadata stream: syntax error, unexpected CTF_ERROR, expecting CTF_TYPEASSIGN or CTF_EQUAL: token=""
> 
> 
>    *   All LTTng kernel modules and user-space tools are version 2.13.18.
> 
>    *   All modules are loaded from /lib/modules/5.15.0-140-generic/updates/dkms/ and match the running kernel.
> 
>    *   No old or mismatched modules are present.
> 
> Loaded kernel modules:
> 
> lsmod | grep lttng
> lttng_clock            16384  0
> lttng_kretprobes       16384  0
> lttng_kprobes          16384  0
> lttng_uprobes          16384  0
> lttng_statedump       749568  0
> lttng_wrapper          16384  1 lttng_statedump
> ...
> 
> Additional context:
> 
>    *   The issue persists across multiple kernel versions (5.15.0-140-generic, 5.15.0-141-generic).
> 
>    *   User-space tracing works as expected (metadata is plain text).
> 
>    *   The issue is not fixable by editing the file, as the format is fundamentally binary.
> 
> ________________________________
> What should happen:
> The kernel tracer should write plain text CTF metadata, starting with /* CTF 1.8 */, so that Babeltrace2 and the Python bt2 bindings can parse the trace.What happens:The kernel tracer writes packetized (binary) metadata, which is not usable for analysis.
> ________________________________
> Thank you for your help! Please let me know if you need any more logs or information.
> 
> Regards
> Shreya Tripathi

