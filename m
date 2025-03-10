Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72118C282DE
	for <lttng-dev@archiver.kernel.org>; Mon, 10 Mar 2025 15:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1741621244;
	bh=UIb+9M1FoYtsWX9yPnowsTgDyMEA6LqBPX8s0leayAY=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=wzxtIPAo0hO9MAF9fLeKths5K1r0c6oI4flL92Uf+rwWrXGfke9bvUxZQ9y4v9cTN
	 /rqE1xV3FalWRKh6lyEmgLunrSdYymDjl6Te1y0bvBkCpE6ukzqcVD+GuO9YD+J4Hq
	 bY5u5wU+4/CKhR3PDlBfodckWpoqbl632l3xo7WL19zXlxiGOtcBjE0IDzt5NKTt+L
	 fwnzl1zlw303r+/V3BKKEuIT2XL8HdhZ4AJtAznLkiSw3AOx12ikoIAdhMuQh2vWbt
	 XKZuN5EoEXhoAfGOmRzV5ZsMv8PMIOsBUgmTGAfGbsRxDLaEFa5rSXJf7a0WO9JGMf
	 dmSYF26MOB0aQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ZBLhC6SvDz1khD;
	Mon, 10 Mar 2025 11:40:43 -0400 (EDT)
Received: from YT3PR01CU008.outbound.protection.outlook.com
 (mail-canadacentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::])
 by lists.lttng.org (Postfix) with ESMTPS id 4ZBLhB69HLz1khB
 for <lttng-dev@lists.lttng.org>; Mon, 10 Mar 2025 11:40:42 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pqar3OO5KYCm+wblgPW/Y0aLv5kIebtqwh8NeHePwbe0xg9rTxkMbK+HN/7FAc0C+Wj3TRJWbE4ASMEAa8GRCRhKmjTSJm9z7TePbSZC/XpcPEShfcR2cIKs9UgSFWPPWuHK+5HRD7EYz88fdfkAt0O5PyhjmfaSrZK5MWQINxdptCFdD4/N3YKf/XVwLPuoM1ELt+5im9+zVA5sWV1SEMWn+pmd6L/YUKbwz+fbZ32hE4mC71PcI17+6DpTfLQYn8C6VsZws5xVSg4mfrho71vcB49bs3320oG38Ddjq5gI8apqrc6n8M1+9elRkYJu5JhQCXSDOT4ZZlJMQBqRpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6WWmLPBBpsE5k2TwDYSlf71y0OhpNkVCgA6SyPy91k=;
 b=mkLi3Db0SHsQXX0LGUhE2Q07nh+3cGi2dNAnQGnt/6PdS9VJt5I0aVwXTBpXb7CxbggNF15nSVXhMENX8STVWZzZV+gB5DtlqqPnJ23m3qSMCp+gQaMKx6idQBWQToq1GR/YOPK2kxi75O11b5rkHzrNhYjv5lV1sjO4KUMcrSPWYmLj4e4IjjzFKNs25MLgIFeBzTL8hp7w8aWtIdkxJGYCxdyU9L8Vu8s6Mh8xaRZB6Vcl1VL8Jw3sr3g+Ir/GHKrVNag5i08+sIDen6rPxRROXfVZbhNnFBs3UwUZ7zhD/sgXLE6VS6mhQZopfY9u5hI25eXu0JA0H5oep0YPfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT3PR01MB10347.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:91::8)
 by YT3PR01MB9930.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:8e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 15:40:41 +0000
Received: from YT3PR01MB10347.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6d35:443f:e789:df9f]) by YT3PR01MB10347.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6d35:443f:e789:df9f%7]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 15:40:40 +0000
Message-ID: <18255819-12dd-4e44-9290-e47bb0f14fca@efficios.com>
Date: Mon, 10 Mar 2025 11:40:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Memory Consumption High After Upgrading to 2.13 from 2.10
To: lttng-dev@lists.lttng.org
References: <CAE9JrziKKkMx4u2+whHKXF0zUK3R+y_v+qOS1cBi=GW6J9uj_w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAE9JrziKKkMx4u2+whHKXF0zUK3R+y_v+qOS1cBi=GW6J9uj_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::43) To YT3PR01MB10347.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:91::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB10347:EE_|YT3PR01MB9930:EE_
X-MS-Office365-Filtering-Correlation-Id: 09d851bd-efe2-49db-1257-08dd5fe9e988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2N3T1JSTkVHa0JDMnVWdmRaRTQ2VEU5VnI3SGxpQWZNMnUvMktlL0t4UG5N?=
 =?utf-8?B?RGN1R0NmQVlyMUJkTEZ0UW5SUTRpLzlkZmpISm04Q2JDQjAzVkNHL3NEOVlQ?=
 =?utf-8?B?R21DdHdFQlpzbzNxZEdWUkNTaUFpUlBsT0xCWFo5ZEpFdCtOd2tUZ2l2SDlK?=
 =?utf-8?B?TEJxWiswUU9PVzhpWjNVeWdNQ2dySFJKS3VFV2pWMlBzTGdKeDRjU3FvL1hC?=
 =?utf-8?B?bFYyZWxtOUY2bEVYZ2hRUHdvOVBCQjRvaCt0NFZEYjlDQkNnNitYK0VMWXFZ?=
 =?utf-8?B?b0tOaFFoeEd0UlJzeGc4MjRwRS8vQVd0YlhFVHkxeTNKUXpGL2hyR0t3OU82?=
 =?utf-8?B?YXlNZXUyNmIyVjVCaEYzY2NkN1lnWCt1VlFYYk9LSHU3T2U1dTNWOU92WHBY?=
 =?utf-8?B?USs4ZEhOeWRDb3pablR5RkF1WU16UmNWYnJlbmF6dUJ5V2poZXJMZVE1MnpS?=
 =?utf-8?B?TVRDN2F3WlZIZkdoV08rVng4cmdXQW5veTMrcmVnVlJFbENXcEZMbUNpdVpw?=
 =?utf-8?B?R1lScEltbnNyZW1nQTlFaWxUenFydmNONmVUaVNyeXFteW82Z3BONnFuUmFF?=
 =?utf-8?B?b2NlbEJCSURXVndpS29WU1VrNnFnV3BsWkdsaEVYaGYra3Y3aTMwVkREMGFF?=
 =?utf-8?B?QTVPbmZpYjdYenVEUThFTnNZYUtPeUNza2x4T2UyNzB3WFdMSHgxZDJOSkN2?=
 =?utf-8?B?TVFmTlRNMW9COTVoL2dqbFgyb3htRmJkbklmWVZTMi82Z25DWGxIYVNKU3pI?=
 =?utf-8?B?cWl4VEcwOVNyMUdBS0pka25WRXM5a2Z4bTA3V1BKTFpxMU1FK053dEFwQUMv?=
 =?utf-8?B?UTFWRzM0YnBSV1pKeVFzcU9oNzIyWGUyUHJRTlh3RGVyWkN3YmhjWStvTHRx?=
 =?utf-8?B?M2NSQzlhK2p6MUpNblhSWjJSbU1KbWNPR0ZKdVQybUwzMzF6S1hGSzlhZVdh?=
 =?utf-8?B?ZG50K3dRcHExZDZRaTl6ZzZ0bnp1MTBQZUlrRTlMWUtBSmlhUnBDblFTN0Uw?=
 =?utf-8?B?bHRxblkyeXMvcTdNOGtvbS82T3Fua092cXZJa0hmQjRmTW8xSWcxL21keHZX?=
 =?utf-8?B?Mmc2VTBSUVpDVkJIbE9HVmNQbDE1TEhsNndjS1NLSjB6dDNReFRxOWdMVHNY?=
 =?utf-8?B?VlBVRjRTZS9HY2IzenRwOElySld4TE00T082dUxnL0kybFYwOHAwaEdBZm9U?=
 =?utf-8?B?NnRBVjIrbklBdFpuVjdCYm1sRDVWWTZuc0sxdGNXOFdQNHA4c0xTbXJCVXJV?=
 =?utf-8?B?QlRJVVg1ejdKMDVsT2pPVmFXRmxHSms1dXRoaTFjK0FDTVdkZVZwSW5QU05T?=
 =?utf-8?B?dTZZR2hxRVlvL21jVWhBa3pSOCtTNloxYkdNdjZRSVREdTFFa3N3c2JkNU1k?=
 =?utf-8?B?MHUzYjJBTkpQaVFjcTZ1ZjdtVnlBanlyRUgvOTVMUVBMK0JNdXlJSDg3dDZF?=
 =?utf-8?B?Q0R6OEQwaWJZMmVsY2RiNFo3M2ZHVEVndFdnK1pmU2QvRzFETDlhK2x3ejY0?=
 =?utf-8?B?am10TVp0c1NFS0pXWU12TThQeWpLLzlqKzNuRlJWMlRTTk1abG1aZFVYU1hv?=
 =?utf-8?B?V2UwT28wWWdUWHJFbGxueGdzZGhxUUIzQ2lWc0FVWlJHR001ZmlZOFg3Q0tE?=
 =?utf-8?B?SHR4MXhqOU9kZllXME5PS09OTFVNcEhhWTl0Y2lremhmYkRwTWxiRzBRM3RC?=
 =?utf-8?B?d2cvQVJYcUtyamNyMVpGZmRZSkViYWw0SzRaZ09WWmVYRkRHR25STnhnL1hk?=
 =?utf-8?B?YlRwTEZPTHhkQW1hTlNZMTh1VDYyL2lLYWIrdnZSdndzd1psY2htb3NNek1O?=
 =?utf-8?B?NnZvSmg4SDVML0dtZTdlbVQ2N042SzlTVjJzem9CSlpoZkxWZ3hzSU9SUDBv?=
 =?utf-8?Q?GtxTOGiorTtI8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT3PR01MB10347.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0dWREoxZHNqTnBFTDk4Mm45enB5cXhmMFc5a1NNckVxZ2xYOU4xVXorZGN3?=
 =?utf-8?B?NjQ4V3IzTm04OE1oeWV1aXN0WkhHcFJBS0JaS094c00xaFNSV0VKcmd0dVJn?=
 =?utf-8?B?Q0s0NExzWGswZ0NNNFBtSjd1WVFPbWdHL0Z4NjVackI4WjJtOUxmWFhpdU5Q?=
 =?utf-8?B?WkQrZkpTelBPNi8rVWp2aGdWYTBMeXdya0V0bXJJUm5JWGRuZEY2ZGdPeUJV?=
 =?utf-8?B?Qmw3SXJpbnBNb0R2Q2hZT2E3VTZSYjJxZU9lU21SRDQrdUV0ak9rRVpXcklI?=
 =?utf-8?B?U2ZTek9SMlVNL0lwM1g2RVdGLzlJM242dWhNL25WYzNFcVhrODNURmJzeksx?=
 =?utf-8?B?Q3lObWIrZXFNSkxWSjB0UWZNUUFnMVkrQStsZGNmVEJzdTIxK3lSNUdJVFJU?=
 =?utf-8?B?a2thZzZCeDNoOUo5K1dSSTVLTE5RSlFBL1RQLzBkYjA1dEFRdnMwZjBrNnF4?=
 =?utf-8?B?aGQ4R2dUYW9TdlRySlM2QTlkTWdqSDMzRk9vT1NJaVZUdzkwUnNqQzZRVWky?=
 =?utf-8?B?ejdXRVlNcDF5eWltajViUWE2bUptYmtGcnU5NnBzSnhXQ3JibUxveGN6a2E4?=
 =?utf-8?B?VS9xNFUxbExIRURWZ09SaGtxSDcvamJWSkR4UXllNkJ4QzFxL3lSZDhKTzVh?=
 =?utf-8?B?WGVhK2hWYnAvZlNFQU5hdWQ4V0dxSm5PemJrMFV6VlBldE1IVXFFYmlKaGRB?=
 =?utf-8?B?RlRrRno1anh0WlJ4N1ZKREZCTThrMnUvRG1aaVhRVmNpTkJRODY2NW1zNGVl?=
 =?utf-8?B?RzBNbWJjVGNaSFZzMFZteEovaWhjWHhINW51Nk10NCtpTlRUREZyTkhqNmRJ?=
 =?utf-8?B?YzlkRm5VTjlZUjBEUnBCeWxLREFaUjFMRkZoK09GZ1E4RVQwbWhxUlhhWTVq?=
 =?utf-8?B?TlhwbXY5czJ5b1JSeTFtVEFlbnhvc0xUQjJpcWdvN2l6L2NKbGZHb1Z6R2lr?=
 =?utf-8?B?WHpHYjZsQVlMMlhIbVI1cy9aVFc2SHVjS0RHRTQ1Rk55WTg4TllBUWNJQlQr?=
 =?utf-8?B?VUtNNVQyK2t3V0d6MGJVLzdsZG1leE9pZGcwOHFzNktUU0srcCtWZDlubWRn?=
 =?utf-8?B?M3lLTVphUWNHN3FoMmE0aDNIODRNOVp5SE50S2VucGl5QjlVM0F5c1ZlOGY3?=
 =?utf-8?B?ZFNkMzZDS1lIN3hiZXZtNERYYTltVERwMGk0V2IramxyQmZCdEJOMzl1ZzNU?=
 =?utf-8?B?ZURVRDU2eE5scGJkY1hRdDAydnkzWFo1RmF6SEcrelFrc1hnelhiV2FMbVJY?=
 =?utf-8?B?aWNGdVBVRWlpSHgvWlhMd0lmUGxDWUhwTVJRbEtad2tzNHJRblA3TlRvZ1dy?=
 =?utf-8?B?MGdCamNzWjAzTVFzalRJMzE4UThiVitkV3hUOW1nMUFpeFpUTk9INkEwR3lZ?=
 =?utf-8?B?UE1ZNzdWSVRLbGlkYmJvMXNwQytzdmRGN1FWZ3pIdXpsYU5ta3ZLc2sxMWZv?=
 =?utf-8?B?bVptL2VNa0x5OWs4ajlsYllESWVwRkRISlp3S2wzZ3JuZ2hSaEZwSjBhcmwz?=
 =?utf-8?B?Q0NjS1lreExpK1RCMWdQZlNpdENSZTQ2OUNPM0FnR0tBRXdzTHh0c3FObTlK?=
 =?utf-8?B?NFViZURyTHFBaDNKK1ZyckJpNWtQaTJTaFhISGhueDhZeFMxTmdDT05jZW5R?=
 =?utf-8?B?ZTZtTVZpR3lwK2tvK0FqMm1kOXk1OXhvNHMxOXdmeHhwVDUrZW8xZDU2b1Q4?=
 =?utf-8?B?LzFTZm95Nkt3OE5JMnFXTzRjS2ZCZU5ETDQ3UzZJa1lFWFZ5SDNVSVcyUEhK?=
 =?utf-8?B?R1p0MEtTaFUxRlZzcnlJNWV1ZmZrdnNLMFZZN2NuN2d3WDA0RDgvV2wySEt0?=
 =?utf-8?B?Tkt1dXduZ0JuaFpyZzJieUxrU25PNm02NXRXSEt1bSsrY2dnVTJiVmhac01n?=
 =?utf-8?B?eWxzN0E3RzE4OEpjbnFSUHpHTkEyeFZjVS9jcVVldnZWbXgrVDExRmEzWkxY?=
 =?utf-8?B?cmRJSVJvQ1NnWUVFZmN1RzJoeE5XanlkdC9NMVJwNEg4TlFjTTBMNVgyRmtv?=
 =?utf-8?B?ZCszb2M5NkYrM2h4cEhxUGRIbDQvZHpHTFNuTWIyWkRhNFQrSW9ZSDQxQ1hB?=
 =?utf-8?B?NEtCZWpsazBxWEtPR2szbHlhS3N0NDNBcEo1T1dYMVhCanUzUGw1UURIcC9y?=
 =?utf-8?Q?YK6kfFDvPwGjPmUhOLevK82de?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d851bd-efe2-49db-1257-08dd5fe9e988
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB10347.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 15:40:40.7937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u/YKRYpKlX7cCNQhv90R5OqZmu1hmXjv69LgBtIHClK34Y4xltbVELqTx4OmVNbh4eU+cK0zmJM+po6jAhht+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9930
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

Hi Lakshya,

what is the output of the following commands on both systems:

* nproc (32, I assume)
* cat /sys/devices/system/cpu/possible

On 3/10/25 10:02 AM, Gour DEV via lttng-dev wrote:
> Hello,
> 
> I have recently upgraded from lttng 2.10 to 2.13 as part of servers
> migration from buster to bookworm.
> 
> lttng 2.10.6 - KeKriek to lttng 2.13.9 - Nordicité
> 
> I see an increase in memory consumption upto 11Gig after my recent upgrade.
> 
> 
> In buster
> 
> root@localhost:~# top -b -n 1 | grep lttng
> PID USER PR NI VIRT RES SHR S %CPU %MEM TIME+ COMMAND
> 4296 root 20 0 1003676 19616 4608 S 0.0 0.1 0:00.67 lttng-sessiond
> 4297 root 20 0 44260 800 0 S 0.0 0.0 0:00.00 lttng-runas
> 4643 root 20 0 5838512 10396 9204 S 0.0 0.0 0:09.24 lttng-consumerd
> 4646 root 20 0 48048 544 0 S 0.0 0.0 0:00.00 lttng-runas
> 
> 
> In bookworm
> In bookworm.
> root@edgecore-40XKE-j2-101-32:~# top -b -n 1 | grep lttng
> PID USER PR NI VIRT RES SHR S %CPU %MEM TIME+ COMMAND
> 4824 root 20 0 1098824 13336 5980 S 11.8 0.0 0:03.46 lttng-s+
> 4825 root 20 0 48872 2188 1012 S 0.0 0.0 0:00.00 lttng-r+
> 4841 root 20 0 11.5g 11.0g 11.0g S 0.0 35.4 2:33.33 lttng-c+
> 4843 root 20 0 3680 1160 816 S 0.0 0.0 0:00.23 lttng-r+
> 
> 
> I have a python script which was used to enable channels, these were the
> parameters I was using
> large_channels_sz = 4000000
> medium_channels_sz = 200000
> small_channels_sz = 10000
> 
> num_large = 4
> num_medium = 4
> num_small = 4
> 
> def enable_channel(channels, session, subbuf_size, subbuf_num):
> for c in channels:
> call(['lttng', 'enable-channel', '-u', c, '-s', session, '--subbuf-size',
> str(subbuf_size), '--num-subbuf', str(subbuf_num),],
> stdout=devnull, stderr=subprocess.STDOUT)
> 
> enable_channel(large_channels, def_session, large_channels_sz, num_large)
> enable_channel(medium_channels, def_session, medium_channels_sz, num_medium)
> enable_channel(small_channels, def_session, small_channels_sz, num_small)
> 
> 
> 
> there are total 16 large channels and 6 medium channels and no small
> channels.
> 
> 
> The total size for all these session cominded turn out to be machine
> roughly 7GB on my 32 core machine, which is still less that the amount of
> memory used by the lttng-consumerd.
> 
> I only have default session configured and nothing else
> 
> root@edgecore-40XKE-j2-101-32:~# lttng list
> Available recording sessions:
> 1) default [active snapshot]
> 
> 
> 
> 
> I have seen that when only the channel are enable and no process which is
> using lttng is running then, I see normal memory consumption.
> 
> 
> root@edgecore-40XKE-j2-101-32:~# top -b -n 1 | grep lttng
> 
> PID USER PR NI VIRT RES SHR S %CPU %MEM TIME+ COMMAND
> 4824 root 20 0 1098184 12732 5376 S 0.0 0.0 0:03.15 lttng-s+
> 4825 root 20 0 48872 2188 1012 S 0.0 0.0 0:00.00 lttng-r+
> 4841 root 20 0 536240 4284 2400 S 0.0 0.0 2:09.32 lttng-c+
> 4843 root 20 0 3680 1160 816 S 0.0 0.0 0:00.23 lttng-r+
> 
> 
> But, as soon as I run even an single process which is linked to lttng, and
> which is *not* using any lttng channel

With which user(s) are you running the instrumented applications?

> 
> liblttng-ust.so.1 => /lib/x86_64-linux-gnu/liblttng-ust.so.1 (0x
> 00007fa867ea3000)
> liblttng-ust-common.so.1 => /lib/x86_64-linux-gnu/liblttng-ust-common.so.1 (
> 0x00007fa86752d000)
> liblttng-ust-tracepoint.so.1 =>
> /lib/x86_64-linux-gnu/liblttng-ust-tracepoint.so.1
> (0x00007fa86750b000)
> 
> I see an very high memory consumption of 5.5g and when i run all the
> process then i see the total memory consumption reaching uptop 11G.
> 
> 
> Do you have any hints on why this could be happening,
> 
> Thank You.
> 

thanks,
kienan

