Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDF5E7718C
	for <lttng-dev@archiver.kernel.org>; Fri, 20 Dec 2024 18:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1734720321;
	bh=MhiaIIGY4PXNg7h+1oJgxLBlSYoO0keGkeZXEZ+ue8s=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=J+YN/wrsdertgJzGVuFk8eVeJxYqsKjKXi5r0a4rkVDvJahuVfIUmVQsBVudhS7b6
	 sqKiyhBd0PZexIPqC0bhE/cECJyxZeXkses7NTB7R6Idpm0J0PyUHgum6TK9FuP32h
	 ssNoOInOEJAQOlPH6Qs420LH5pK2BIehYMSQrjs7xPpqhNXLzp/KI0VVuOsFE+ORtG
	 aea070+m91W65nKFfho0h2uiyBtTwsOuo98WhMVbcZHExr+NDlynEEbhb8BiS/A9Lm
	 +ma5w2WOFSOzJ8Ebju/LoiMwRXY+rhcRdVqdedodhEoJLik7jD0L/sGqzYxOGNsAsg
	 8cdiqERcukovA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4YFGZ947FXz1m16;
	Fri, 20 Dec 2024 13:45:21 -0500 (EST)
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazon11020119.outbound.protection.outlook.com
 [52.101.191.119])
 by lists.lttng.org (Postfix) with ESMTPS id 4YFGZ83rNGz1mYm
 for <lttng-dev@lists.lttng.org>; Fri, 20 Dec 2024 13:45:20 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqhKR247jdCHNMtfmrqsob7e9I/1BWa52is0bJbm7SWCcaytX4jbTnVCM0UtE2Nkn68MnQiZMh5PkoRytrxlBHGtCU2q6rMtcGijlnV/BoGISGPhgPT/bp2Mc1vTvh24j2IcyP7M/j8pjUy7IFzsmgeZoP4zG10UWdOBDZtsZDmYfh4Z2WSk8TkRK5kPWTRdL8Tc8W2SiXvv4WlKasDTJBwF6LWYTu8/bA0vpSrqhZejmur6YkahW5XpiVzW1WyKeP6YNrwEzaaHKG7L6qjmHwSPrJ7kU+5zEXlMwGfueBkoysh9L4mDB9ty0WJLplGWZMAl64wwLCEdiIhjy5dPiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7m8hYBiLJYC/btrx/NFIyj/iksKeqYgv/Uj5hOiA9pE=;
 b=Pqv4B5F7AeXCz7KrrhIIs+utftp/zIuF4ZceAdILJtQLfYETnJPB9POQlPN/5wyyAvJ9hk/2NHBWwTOZmNZZO9vWePagxoagd1yjXSykoUiviSj35uXFGKEeZNsmVbtgT0CbGhVGLMY7MvFbz3cmquwZ998rAHYcStjuMRyetn8EXolXTt47Mp6yug4jBrcM4t5TnvcI9ncZT2dJIDMOZCyFVrU1SbCYTpqu2CyZCjShIVwIQv2G5guz+mxsLLZqugYHqZEDOxNZrF1NgHbkizMgtDlHaRvxcWPfxdqh/hQMFh65xniCA/ME8i7K4m/QrQGBFK9k0LUlO4IMq9KAJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB9737.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:89::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Fri, 20 Dec
 2024 18:45:18 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 18:45:18 +0000
Message-ID: <4be131ff-8fb3-40e2-8059-e2a7519e78b6@efficios.com>
Date: Fri, 20 Dec 2024 13:45:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RELEASE] Userspace RCU 0.15.0
To: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org
Cc: =?UTF-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@isc.org>,
 paulmck <paulmck@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Olivier Dion <odion@efficios.com>,
 Brad Smith <brad@comstyle.com>, lwn@lwn.net
References: <51160e24-389a-41b6-871b-ba522d427220@efficios.com>
Content-Language: en-US
In-Reply-To: <51160e24-389a-41b6-871b-ba522d427220@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::14) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB9737:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a6ca005-50d7-4c02-05f8-08dd21267319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVR3SVUvQUFUQ0hHeGdycGpOOEpvL1FqYTA1T0lTVXgyd0hYSW9sUmNRVFl3?=
 =?utf-8?B?c1kyNmdRdE9xWCtBdkhoMm5oZkdhQjAvYlNzV2NydGVKR3JkSng5cEw4MHNW?=
 =?utf-8?B?KzhUMlk5cjR4YjdWZTZYQitPNFpNdHdoOE1aVGJDdDVxTXFsWExDYzZrbWRk?=
 =?utf-8?B?QmZGT01weFNlTzEyTFlxaXJ0UmhKamN0aUtPZTNRQTFaUlNtRkN4ODdjRjlB?=
 =?utf-8?B?QS8vTmMrQXBXWmFpcU15UU95NTh2d055ZTR5c1MwMGdXRk1ZWVIyWGdDSGcx?=
 =?utf-8?B?TzU2bG8vMjYwRCswd0FBL3c1T3ViZmZENHh1RkNDTzA4QVgrejNwdS9xeG1E?=
 =?utf-8?B?U20vVjhCMGZtSjBSVk5pbmpOZ3pPTzEzVG5haEVGZlB6cDQ4Uldyd0cvSU9I?=
 =?utf-8?B?S0lhZ3pyaWhpaVZqT25kd2NrU2YxQldLcTd4Z0ZUSlEwNmt4VFlPSE16ZDVJ?=
 =?utf-8?B?TEx2eXRWZUViNGMxcTFDaVUzbE9Vcm80MnpHWEg4UUxMOGw5elJCYTR2bEF3?=
 =?utf-8?B?UWgrYVlrZjRGaEtLL1UyY2lEOUM1eGRDQ0UvU2x6OFRFZHVlZG40RzRjc1Yy?=
 =?utf-8?B?bTNWN2d1V09mM3l5RjgxZW1WTGloaThZSWtvMEVuQ0liazV2cTY3ZTZFUFRn?=
 =?utf-8?B?YytCMEdSanNEWWhCTzhvNjBQeDZxVTdIRFBRL3RHbzJ6aWh1QytwQkYxcTFT?=
 =?utf-8?B?REloc2ltU2czbzN4Rkg0Wm04eWJrUmtTaC8wM1NsOTh6NkMyS2dhQ1BQTWho?=
 =?utf-8?B?MXBVK2hOTFV3RkUrRS9jTXdONTdaZUpYUVVrYk1GbmE4T3ZzUElKSkltbkR3?=
 =?utf-8?B?VWRIMlgrWWlOVnNXRnc1Nm5QeVNteDY1ZDVYbXFmWDMvdG1VbXA5RnMweVc4?=
 =?utf-8?B?a05ibUxtM0dYaEtQM2s5NFVkUGdwbHZiZkUyc0M1KytRUlVPUmdoQ2FaQUJ3?=
 =?utf-8?B?akhZZXF1bXVwamdydDVKZ1F2c05VcVplYXFOWDVOa2J1RGliZ1ZXZG45NXBa?=
 =?utf-8?B?ZEI2ZFJLRlU5c21tbFNOT2hhQWpyRWUzSXpYQmdrMmR5Uk9GVHdhRUtUclBJ?=
 =?utf-8?B?S0ZMelh0OE1wblQwbUZ2L2RQRGdxdGhDUDhLU0l2L2FUbkhCeDZQQWR3RXdG?=
 =?utf-8?B?aXJzV2N5cm5MZ1IwcUthQVhrZ1lOM05MejIybmNaMmVEYVZPRENwRm5aM0dU?=
 =?utf-8?B?dGhVM285MGMya3l4QkM3QWV3dG81OTd6M0ovSUgrK3prc1l4ZEJOeThSUXpo?=
 =?utf-8?B?VlVqY1BWcWt4TVEzazFvYWN6NTNicW5wbUt6d2h5T2JQSjRDZFpaQXppZjlu?=
 =?utf-8?B?MzZvcXVoOS81MnRTT1FZMEozU3hZZVlSNCs4cGFDUkJhYms3dHQ5S3NtKzNt?=
 =?utf-8?B?Y25scllFQXFQb3kvWk83RkhKUjF1MFZoQ3djZXNQYjNDc2kwSysrWGRUWnlt?=
 =?utf-8?B?cEFuVFg5NlI3SjI1OWk3OTQ2QkpLU2Q3RUJlOXZoaENUVnFDMSsrRUJBb1A1?=
 =?utf-8?B?STh0b0RLK3NCV0Qrd1Z6YnVHVXZZcFZoVTdDOWRkeVBkdDBUV1VxQ0V1ZG40?=
 =?utf-8?B?Q3BSL0Nzalgyek5uWXhFWUgvb28xeEVWc29UQTNpY0RId1g0RVF0TjVROHBP?=
 =?utf-8?B?NFhzRFlVcmduQjBIOTJ1V3BPQ2ZwUUkyMnNKK0ZTZE53bjh6V3hUTHhlQW43?=
 =?utf-8?B?aUFtSVpIOXdybmZuZ2phTkpIbHh2dkFrSjU2VGM1WHpOeWVTbWpqN1VVZS8z?=
 =?utf-8?B?YmhZSmttNXVma0UxR29od3ptTUtIcGIvQVAyOXRUTnBoRWhXaWZCbVppc043?=
 =?utf-8?B?dkRyM05XWk4zbzZRWU5nQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjZpbEhLYWMxei9jM0w1RFZoWld3amVYem9mUHB6czcrK0RCMk1wUzJNZXJ5?=
 =?utf-8?B?ZW1KNjJPY3pTdEVnTXlPeFRLMmZuelNzSkJlMnk4QjNvOFR5TDVaRGUxdWc4?=
 =?utf-8?B?WUw5a0lpcGpxQ0p2R3R4R21jS1BOZFVlbkQ4eGVLeVdBMTR6RzZ5R3lnT1hl?=
 =?utf-8?B?RFJCRUUwV2xicWhqM1h0VTVQNnp1ekNrdllIZDkza2V3NURaSkg2WnM2dVFY?=
 =?utf-8?B?OHdHaUNVdE5ZSzlzcUFrUWNtSUk2a0pvdHFzWnFYNHdnTGE1SUhLUnNnRDlk?=
 =?utf-8?B?SnVxSFpaUVFKSWVwVHVpdldWVzV0ZmwrR3hHQ2dBbU1NUnpFU0xhMk95VnhS?=
 =?utf-8?B?d2U1R2U4M2hGWFU3TEdKbFB2Z3BrYkl4QUV6QVNHYXgzRVZSR09iLzlCUzln?=
 =?utf-8?B?MXZ6Z01mM0hZckwwTEppNWdGUGRIS1REWWEwNjIvalBkcVo4MTlKS0J6RkxX?=
 =?utf-8?B?RExDQWUvQm4xTjFlTC94NFJRT2J2NjRiTk1oNkRpWFNCNFE1ZFNaNldja3N3?=
 =?utf-8?B?N0ZBbzhtMHFsNnJFY2Vxc1NiVGlOMlBnb29tdTJDV1lLRHljYk5MclpaRURp?=
 =?utf-8?B?VU41U3ZYMDZxRy8xd0crZTkzWkVkV1ROTjc3RG0wY0E1ckZ6WmtzYWZxU1hq?=
 =?utf-8?B?eXYzWWNoNGcxQWVwa2E4US93cUYreTVtZE5YVmJkRGZvazBxOENPMG8wQ3VT?=
 =?utf-8?B?SHprb0RMODhBd3Q0OFY2NGZwdk52bE1LYW0wVmR1WWhrTlBMdWtyVEhoOVNh?=
 =?utf-8?B?bUUwM2ZkTFJ0b0VQVExrS1N3blBqOWF6WGxweWlMQVp5ODJZVXlRaWk2RVFX?=
 =?utf-8?B?MlRaT3dWc3FsWXNsZHBXMFczZE5NWjVkQUxOL21la0d4VXF3MzduTDhCY1k2?=
 =?utf-8?B?MXM2TisyQy9kVUg5VXFSTFNFNmdkUldKd1U3SldFVkkydGZZeXBUQkVOK3ho?=
 =?utf-8?B?K01td25PRUxLcFNyOFFoZGFjbWh3cDk5THY2bEhMT3RiMFBTQkIvQnNlQ21C?=
 =?utf-8?B?ZVdUUTNHZHJYU2dvTW5UdUkzVS9rZXMvZWJjUnJFdktDZDJXUDRFcG1HUmFR?=
 =?utf-8?B?QlQ3dlh6c1I2WllGN0g5bUZwYkEwMTN2MlpXeGhrUWZhWmtvMWRlTU1lVHNq?=
 =?utf-8?B?VXc3Tlk2WHZFZDlxUkRqNUl1V3pVUFU1bmYrU082cXU0cHFscTZUL1gvcTVN?=
 =?utf-8?B?ZUVCWVRuekRucGhodVlnbUE2SFVvL0VobWo4ODJibTdXRVRSbXBlRVBIRE5r?=
 =?utf-8?B?VmFZdFNTTkdIWlBUNEQ5T0hOUk1KYis2RVdiZTJYd3lzQWdtYVlPY3ZIM3Uz?=
 =?utf-8?B?UktDb24vZUZEU2FXdzN1YWcwVXZzOTFkYjF1QXJaMWUzTS9JMTlxbW5USjY2?=
 =?utf-8?B?bXJXTTR5NjdWNytFWjVOU3l6Q1JPTUhEdmJtOWd1Y043UEpQaUNGYUZzNmxG?=
 =?utf-8?B?bHRvLzRMV2t1NHJxZGhDRTV5cys2blExeXRmZVh3eWNhS1RlMUtOS0REWkY3?=
 =?utf-8?B?eVBxaVJmNUpWalowOWRiL0I3bEVjM2pYd2tqS3kwY0JVMU5tTFAzajFwOGZ5?=
 =?utf-8?B?bEptQnRySlZpbmhHeFRvekdzb1VlNGt4MGVNcDNoUForTGdhOE4va21zdDZs?=
 =?utf-8?B?aEtYeFZ6bVhpeE9DYU5lZmZTS25JRkhHMEd4dTg2N0VPSnFjRjhjMEJOQXBi?=
 =?utf-8?B?UXJHMkpLU2x1YzVueTM1amhtVW5pVHRFNTUvSnFYK1dudld3aHdlK1NyQTU5?=
 =?utf-8?B?N1FIeFFJWWJhdVZuMDhpNjVhQVR0cnA3UGJNNVhkWmRPTWw3WHluQ0l0ZnNU?=
 =?utf-8?B?UnVKNEtEVXlkeUZ4Z2JNVUQyakU2SDR1cnIrQ1A0dUdlUmJwQVYyWUE0K3BH?=
 =?utf-8?B?WnBvZjlTT2dHa0NVaFdaSUZXaXpONmY2WHJrT2NCeUhidms5WjcrQVY0VGkr?=
 =?utf-8?B?Wm9XVDVkeVZCUHQ4L2J1VUgrTWliWk5WaUJEWFFvNkZJU1ZmS0pidzdadVVq?=
 =?utf-8?B?OUtGYWhqMGEwenk0cEZCdDJ5UFNvRWFKOGNVWmFsT212S3FGMXVtQ0lsWnE3?=
 =?utf-8?B?TWNhNk5aaXdhdW5FNTVPMlZDczFRVkptMWdiRGpIUFgwWGtvRTJsTm5BT0hi?=
 =?utf-8?B?VjNZdGxjRzRHU0l1WHkvNDBLZEprd2pHT1NGY0tUSFNxRmt3TmVtTnBJR1Vm?=
 =?utf-8?Q?vrk62/D9CbTYp/RRJcr6yew=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6ca005-50d7-4c02-05f8-08dd21267319
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 18:45:18.0805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: toU1wT3LC629K2BkbVa3kniaY3MeFR/y9BUsDIUr+0Qr2V681ji4SHxdYruUvDviudDBiCq1JPFiS2ipJaby9P3XxaKwgPbh6SEAHp6AHPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9737
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

On 2024-12-20 12:25, Mathieu Desnoyers via lttng-dev wrote:
> Hi,
> 
> This is a release announcement for the Userspace RCU library version
> 0.15.0. It has been nearly two years since the 0.14.0 release, so
> it is now time to get this out of the door.

As per our stable branch release cycle, the 0.13.4 release was the
last of the 0.13 branch, which reaches end of life with the release
of Userspace RCU 0.15.0.

Thanks,

Mathieu

> 
> The Userspace RCU library implements RCU, atomics, and lock-free
> data structures in userspace.
> 
> * New in this release:
> 
>    * Support for compiler builtins and ThreadSanitizer
> 
> The main change that was introduced in this release is the
> introduction of the support for the C11 memory model based on the
> compiler atomic builtins, and adaptation of all algorithms within
> liburcu and liburcu-cds to express them in terms of atomics with
> release-acquire semantics, thus allowing ThreadSanitizer to understand
> the ordering guarantees provided by liburcu.
> 
> Using ThreadSanitizer requires using the the compiler atomic builtins, 
> which needs to be enabled explicitly when building liburcu with the
> following configure feature:
> 
>     --enable-compiler-atomic-builtins
> 
> This is disabled by default. The default is to keep using the inline
> assembler implementation for the uatomic API.
> 
> This work was sponsored by ISC. It came up as a requirement because
> BIND9 [1] now depends on liburcu, and use ThreadSanitizer in their
> testing.
> 
>    * Introduction of the CMM memory model with the following new 
> primitives:
>        - uatomic_load(addr, memory_order)
>        - uatomic_store(addr, value, memory_order)
>        - uatomic_and_mo(addr, mask, memory_order)
>        - uatomic_or_mo(addr, mask, memory_order)
>        - uatomic_add_mo(addr, value, memory_order)
>        - uatomic_sub_mo(addr, value, memory_order)
>        - uatomic_inc_mo(addr, memory_order)
>        - uatomic_dec_mo(addr, memory_order)
>        - uatomic_add_return_mo(addr, value, memory_order)
>        - uatomic_sub_return_mo(addr, value, memory_order)
>        - uatomic_xchg_mo(addr, value, memory_order)
>        - uatomic_cmpxchg_mo(addr, old, new,
>                             memory_order_success,
>                             memory_order_failure)
> 
> The uatomic API was extended to support explicit memory ordering.
> For instance, the previous uatomic_cmpxchg() now has a
> uatomic_cmpxchg_mo() counterpart, which takes a memory ordering
> argument.
> 
>    * Introduction of --disable-legacy-mb configure feature
> 
> Some public APIs stipulate implicit memory barriers on operations. These
> were coherent with the memory model used at that time. However, with the
> migration to a memory model closer to the C11 memory model, these memory
> barriers are not strictly emitted by the atomic operations in the new
> memory model.
> 
> Therefore, introduce the `--disable-legacy-mb' configuration
> option. By default, liburcu is configured to emit these legacy memory
> barriers, thus keeping backward compatibility at the expense of slower
> performances. However, users can opt-out by disabling the legacy memory
> barriers.
> 
>    * Introduction of CCM annotation experimental API
> 
> The CMM annotation is highly experimental and not meant to be used by
> user for now, even though it is exposed in the public API since some
> parts of the liburcu public API require those annotations for
> ThreadSanitizer support.
> 
> The main primitive is the cmm_annotate_t which denotes a group of memory
> operations associated with a memory barrier. A group follows a state
> machine, starting from the `CMM_ANNOTATE_VOID' state. The following are
> the only valid transitions:
> 
>    CMM_ANNOTATE_VOID -> CMM_ANNOTATE_MB (acquire & release MB)
>    CMM_ANNOTATE_VOID -> CMM_ANNOTATE_LOAD (acquire memory)
>    CMM_ANNOTATE_LOAD -> CMM_ANNOTATE_MB (acquire MB)
> 
> The macro `cmm_annotate_define(name)' can be used to create an
> annotation object on the stack. The rest of the `cmm_annotate_*' macros
> can be used to change the state of the group after validating that the
> transition is allowed. Some of these macros also inject TSAN annotations
> to help it understand the flow of events in the program since it does
> not currently support thread fence.
> 
>    * Introduction of cmm_ptr_eq()
> 
> When users define `URCU_DEREFERENCE_USE_VOLATILE', `rcu_dereference()'
> is implemented using `CMM_ACCESS_ONCE()', even when compiled with atomic
> builtins or if the compiler support the C11 memory model.
> 
> This allows optimization on weakly-ordered architectures where the
> `CMM_CONSUME' memory order is implemented as `CMM_ACQUIRE'.
> 
> To prevent the compiler from doing certain optimizations on pointers
> equivalence, introduce the `cmm_ptr_eq()' API for pointer comparisons.
> 
>    * Deprecation of liburcu-signal
> 
> Users can migrate to liburcu-memb with a kernel implementing the
> membarrier(2) system call to have similar read-side performance without
> requiring use of a reserved signal, and with improved grace period
> performance.
> 
>    * OpenBSD Support
> 
> OpenBSD support was contributed by Brad Smith from Comstyle.
> 
>    * Loongarch Support
> 
> Loongarch support was contributed by Wang Jing from Loongson.
> 
>    * RISCV Compiler Support
> 
> Build on RISCV is allowed on clang and gcc >= 13.3, which unlike
> older gcc are should have a working atomics implementation.
> 
>    * The GCC baseline is moved to 4.8.
> 
> Because anyone using a gcc older than 4.8 should really think
> about upgrading now.
> 
>    * Move to the SPDX identifiers
> 
> We introduce the SPDX identifiers in the project to simplify
> tracing licenses.
> 
> Thanks,
> 
> Mathieu
> 
> Project website: https://liburcu.org
> Git repository: git://git.liburcu.org/urcu.git
> 
> [1] https://www.isc.org/bind/
> 
> * Detailed Changelog:
> 
> 2024-12-20 Userspace RCU 0.15.0
>          * Fix compilation errors
>          * Document cmm_cast_volatile
>          * Honor URCU_DEREFERENCE_USE_VOLATILE
>          * arm: Use atomic builtins for xchg if supported
>          * Introduce _CMM_TOOLCHAIN_SUPPORT_C11_MM
>          * Seperate uatomic and uatomic_mo
>          * uatomic: Fix header guard comment
>          * Fix: missing typename in URCU_FORCE_CAST
>          * Allow building with GCC >= 13.3 on RISC-V
>          * pointer.h: Fix the rcu_cmpxchg_pointer documentation
>          * rculfhash: make cds_lfht_iter_get_node argument const
>          * lfstack: make cds_lfs_empty argument const
>          * wfcqueue: make cds_wfcq_empty arguments const
>          * wfstack: make cds_wfs_empty argument const
>          * cds_list: make cds_list_replace @old argument const
>          * cds_list: make cds_list_empty const
>          * Adjust shell script to allow Bash in other locations
>          * futex.h: Indent preprocessor directives
>          * futex.h: Use urcu_posix_assert to validate unused values
>          * Use futex on OpenBSD
>          * fix: handle EINTR correctly in get_cpu_mask_from_sysfs
>          * Relicense src/compat-smp.h to MIT
>          * uatomic/x86: Remove redundant memory barriers
>          * cleanup: move rand_r compat code to tests
>          * ppc: Document cache line size choice
>          * Fix: change order of _cds_lfht_new_with_alloc parameters
>          * Add support for custom memory allocators for rculfhash
>          * ppc.h: use mftb on ppc
>          * rcutorture: Check histogram of ages
>          * docs: Add links to project resources
>          * Fix: allow clang to build liburcu on RISC-V
>          * Fix -Walloc-size
>          * cleanup: use an enum for the error states of nr_cpus_mask
>          * fix: add missing SPDX licensing tags
>          * urcu/uatomic/riscv: Mark RISC-V as broken
>          * Fix: urcu-bp: misaligned reader accesses
>          * rculfhash: Only pass integral types to atomic builtins
>          * LoongArch: Document that byte and short atomics are 
> implemented with LL/SC
>          * Add LoongArch support
>          * Tests: Add test for byte/short atomics on addresses which are 
> not word-aligned
>          * Complete removal of urcu-signal flavor
>          * doc/examples: Remove urcu-signal example
>          * tests/common: Remove urcu-signal common test files
>          * tests/benchmark: Remove urcu-signal benchmark tests
>          * tests/regression: Remove urcu-signal regression tests
>          * tests/unit: Remove urcu-signal unit tests
>          * Fix: Add missing cmm_smp_mb() in deprecated urcu-signal
>          * urcu/uatomic.h: Improve verbosity of static assert error 
> messages
>          * urcu/compiler: Add urcu_static_assert
>          * Phase 1 of deprecating liburcu-signal
>          * uatomic/generic: Fix redundant declaration warning
>          * tests: Add tests for checking race conditions
>          * Add cmm_emit_legacy_smp_mb()
>          * urcu/annotate: Add CMM annotation
>          * tests/unit/test_build: Quiet unused return value
>          * benchmark: Use uatomic for accessing global states
>          * tests: Use uatomic for accessing global states
>          * urcu-wait: Fix wait state load/store
>          * Add CMM memory model
>          * urcu/arch/generic: Use atomic builtins if configured
>          * urcu/compiler: Use atomic builtins if configured
>          * configure: Add --enable-compiler-atomic-builtins option
>          * Fix: tests/rcutorture: Put thread offline on busy-wait
>          * tests/regression/rcutorture: Use urcu-wait
>          * tests/rcutorture: Factor out thread registration
>          * tests/regression/rcutorture: Add wait state
>          * urcu-wait: Initialize node in URCU_WAIT_NODE_INIT
>          * Complete REUSE support
>          * extras/abi: license data files under CC-1.0
>          * examples: use SPDX identifiers
>          * tests: use SPDX identifiers
>          * src: use SPDX identifiers
>          * Public headers: use SPDX identifiers
>          * Build system: use SPDX identifiers
>          * Fix: urcu-wait: add missing futex.h include
>          * doc: update GCC baseline to 4.8
>          * doc: update FreeBSD tested version
>          * doc: Remove Solaris from tested platforms
>          * Revert "compiler.h: Introduce caa_unqual_scalar_typeof"
>          * rculfhash: Use caa_container_of_check_null in cds_lfht_entry
>          * compiler.h: Introduce caa_container_of_check_null
>          * compiler.h: Introduce caa_unqual_scalar_typeof
>          * Avoid calling caa_container_of on NULL pointer in cds_lfht 
> macros
>          * Fix: revise urcu_read_lock_update() comment
>          * Fix: uatomic powerpc comment about lwsync
>          * fix: aarch64: allow RHEL7 gcc 4.8.5-11
>          * aarch64: Implement caa_cpu_relax as yield instruction
>          * fix: warning 'noreturn' function does return on ppc
>          * Fix: use __noreturn__ for C11-compatibility
>          * Adjust shell scripts to allow Bash in other locations
>          * Add support for OpenBSD
>          * Bump version to 0.15.0-pre
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

