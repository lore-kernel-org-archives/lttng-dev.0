Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E2DC282EC
	for <lttng-dev@archiver.kernel.org>; Tue, 11 Mar 2025 18:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1741719326;
	bh=BHnnBoPBUpcWfTA/PReN8A3335LKAd2WS7K0Q8ZvWKs=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=VuF0TuqE4L5cUYQF7XEdiOnRNQy6KKrW38zuROfBziddHgKLgVQm8yQ9UP9as1ohM
	 siwUgRSsdNtGsQLFT+O9Tx1WqlH3o8r9EWPd/8SQOgDYilFa08hJY5YUadd+gRZMM9
	 IUY5oC1iCDOe8p6SMLlw1PZVkTTgIf6Y4I3ZVb1IrmIlJ2OT3CzBILtBJQrJfiiAyX
	 Lu68nfp7s82yKKi96f+BceGpC6gfxNVyseDPPcgqfU2k/pFuSlClcU1dURJ9WD/6F8
	 llTb6RfEmD3Y9diUU2hYChoUPvkwo11c9roG09IfJaKmSe0b32jL1wvWEEx8aQqDu/
	 ZX9T+dGPWSHnA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ZC2yP3VQqz23kL;
	Tue, 11 Mar 2025 14:55:25 -0400 (EDT)
Received: from YT3PR01CU008.outbound.protection.outlook.com
 (mail-canadacentralazon11020111.outbound.protection.outlook.com
 [52.101.189.111])
 by lists.lttng.org (Postfix) with ESMTPS id 4ZC2yN2t7nz240v
 for <lttng-dev@lists.lttng.org>; Tue, 11 Mar 2025 14:55:24 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=siBcUdJxBklZPb9EpWBW6n0CERmrgI3Nge2PLpf10Dtw+3M32jFoIvcSWD7LIQQrglsFgK1mWa9H+T9I3qyd2XDaCEuyBQ4jjV5J8CPoRaWSuFhidPv2lQQ3xz5/J2gEG7hD7wOjUAkXGjqfSEk1iqtUfAnCc6pSmLoCZNwPD40djP4SIXvQNvqNcegS4hQ7iJtflOVjzva6qTtI0siVdT+7HaLc+5dI8BeG6VFHVDGq4Kf8SnvlgbkNWbxzmW4LGDs9nqA7wCEbK16VuXS2mrti0Vj5xtWmt894ewI+ZQ8bXIKeiovTrpSP3YCresvAYMblowaJpDkVirIf6ZfPmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ws6LKon3BUk1xxseXetPiUA/cbDm2QQPCj19fdl8vXA=;
 b=B8KM9CXrGDgOA7s5Z04xj34N5gYQZ4W6tfsmECK60nR9duhja/AXLu7yNLsFg6SSg5SFB+C1hzKJyH/xjF4w3DboDV1SPQy/UEEraWV5Vy1jqNfX5IzUsyV+6G8wpDxi/udGV5eziD/lSRjKzyG3ljYYK2Fv7aj+e9JzX5hh8/IYSJWXD8A1zM0d1YMVhr8v8PM4Ta16Zv7hsagNkkgkAnnRgHofDCGmTM10ZvhIyh0/GOS6VZ6SQyn5UGSVldmzfdpgBW5gZq+sK0A+gMzzOx7WcquggQJYHBHuwQXU9OWwWqPcyi+Ziibgy7CnbtSFcL6ewpgKVpGuEiv25cL8kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT2PR01MB10273.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:da::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 18:55:22 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 18:55:22 +0000
Message-ID: <38dab5ef-f106-4e57-9e36-b4b30015c019@efficios.com>
Date: Tue, 11 Mar 2025 14:55:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Memory Consumption High After Upgrading to 2.13 from 2.10
To: Gour DEV <lakshyagour10@gmail.com>, lttng-dev@lists.lttng.org
References: <CAE9JrziSBzHDOLjLzY=8FHPRWxm9+xq40Kzq8GUivb=u9V74wg@mail.gmail.com>
 <8a3a094c-3afc-49da-8764-8fec1179f7c0@efficios.com>
Content-Language: en-US
In-Reply-To: <8a3a094c-3afc-49da-8764-8fec1179f7c0@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXP288CA0018.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::48) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT2PR01MB10273:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f6fabbb-32af-4dff-07bb-08dd60ce46c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHRnY3R2UkFOa3ZKd20rQXNVdmxRTnNTM2VlQWxDZ2NLZUpiL1Flakdtdmww?=
 =?utf-8?B?RkdpbDVoM3hEOTFxNjZoRnFMSkNyTytUTjZVS1pUQ0Vyd2FQVDJhZS84clFr?=
 =?utf-8?B?NkJpZVk4UkgxMmpCUloydXZjYmQzemtQS0IwNXBkWEhaUXhLd1NqaDlzU0JF?=
 =?utf-8?B?T2t2L2F6Wnkxbk5wcVBzd0VYSXFVZVBWbFJmV3ByU2hCMW03alN0MU5YVlk4?=
 =?utf-8?B?Ykc4ZElWQ2FLbkgzTmxJL0dycXFGc1hxRk1GL3NEVjF5RFN0ZmlQNktVZ3dz?=
 =?utf-8?B?S2MrekNGSldlNzJPYkw1UkZqcEg1KzJDL2RkcmE4NncxSWlma09UU1EwdDl5?=
 =?utf-8?B?d2xJY2ZnYUtXS2xNek9DMHFJWFd5QnZLNXFWNkRieFRUWm95T3ZSQ1pMWDZ0?=
 =?utf-8?B?bUlrODBuL3FIWUh4eEkydm1aOURLb0dEKzc2NFJ1NWFDSFZHZmJoVHVaWDNL?=
 =?utf-8?B?MUpWSEYrejBBVzdJK1dxQlpBVzczL3pGZ3VtckRrRUJFOVZUeXdMZXNXOVhP?=
 =?utf-8?B?TWI3QzNNdEc4UUJvSUtJaWdmL2RzNGFpMHZ2TG55NnNNbWNyZ290YXJMY2FI?=
 =?utf-8?B?NC85V3o3OUg4cDI0RkQ0UTFPcXlTbys5MlZaMzlwZFRtYW9NanVndkFZalRt?=
 =?utf-8?B?VEhBUytXZTV1dnFyWi96SU16ZEtsQmlhVHAyZ2xJYnlmY0tnOEZiK20rbHRQ?=
 =?utf-8?B?K1hxcmhYdmNnZzVxQTRCU05mcU5abFhpY3JHMG5yWmJjbHdRLzQrMDBmY3k5?=
 =?utf-8?B?TWp2akkxZXgzYzBKbllwWTdlZzkvVjJCOW5BczhnTjBzTnhUVTVPZU9SbnhG?=
 =?utf-8?B?WXBHeE1TcHUwKzZrbHc2eU4vUksydTh3WmZwMng1Tlp3VnhCRlVKOXhuUHR2?=
 =?utf-8?B?UXFENTlxd3NjMFAwejhnWnRCRHpCdXBSUTFoTHpaMk9YUzJ3VzRCZVZJeStY?=
 =?utf-8?B?Vk4yTkk0SHM1ZHZCeGovTG82T3d3SFRLajJNbnpnTDllWWpCU2o1eldCU2tS?=
 =?utf-8?B?UUd4bWwvOElCUVZMMk9ET2wyNkdTdHZualYvaXErM2xFL0RvdnkvNElzOU5s?=
 =?utf-8?B?VVdHZFNJYU85dDc0Vko1ZURDQmNyUjNITXY2MFZHeCtzS0NFeDNiVDdpN0x0?=
 =?utf-8?B?YUJ4R0F2VkUxelhtNXFXeXFnUWc5ekZubU9uUUd5VlhmMlA1UDBETkt2aEVR?=
 =?utf-8?B?Zmgvd2w4a2c4SHZEUCtqM295cW1YUVd2WmJPSWgyYnRjTjJvSUJ1RGk4bmJG?=
 =?utf-8?B?MTBWcGtzcVNGM0o4MnVsNU80VlJ2a2VnS3JBK1ZjenFZcnNLSFNCTm02NnVH?=
 =?utf-8?B?RnFObmhxZmI4QWZqQ2VsWWlrUDc0cFlwZS9OTHVZMnFHU2FrbDZUL2FIMm0r?=
 =?utf-8?B?VCtnRGhweTFLSEE2dTM4eUZWMHRTa2hrbS91L2ppcmdQMHZPbHV1QXdmRzJZ?=
 =?utf-8?B?ejVwbkFrWVdOR2Z0NGpsQ091YmgrSlJhSGh3NVd0YXJZL1NiTjBBTUxxTDBt?=
 =?utf-8?B?TGRqdEhsd0xHcTVjTkh4WmtESUlPSDRibGM4WERJUUVrWkZSeGVwSTNJM0h6?=
 =?utf-8?B?bHN2U1ZGd0FsZjlPTWVzTFpMRk81TW42RjlIV00vbUtkYVRmMWZJYkwxMGQy?=
 =?utf-8?B?MHBFRU9HNXk2dnVMbVF4cjYrc21XMTRaTi84ZG10TnhlY0J6SExXTkxNN0JQ?=
 =?utf-8?B?ZndFcndha1JKaXZvTE1pdnZkMGlqRng1UWxTNk1iM0tQb05oRVh2dDJZdWtM?=
 =?utf-8?B?TDJRVlhVcHpVWms0V1RrUkNQL2Z1V1BaVlp5WHZJcVBDeVpzaE0xOW9wako2?=
 =?utf-8?B?Vk9UQXljc2l3aWIvSzZQUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGY5VDBUaHk1dU0xazdqbE9CUWFuRGQyS1d6QWgvUWhoN1loZkZKbHRFc3M2?=
 =?utf-8?B?dDZkb290VlJEeE9SZ2VGbW1qUlJNQzdJemFWbnlaWUw2K2Rzd1RYUUp5M1JM?=
 =?utf-8?B?ekswcHhxd2lmVXFFcnFBcWM5L05VRUdWT3JDSkNlMEtHUExHL1gzQjBaYlo5?=
 =?utf-8?B?UEE0UzNNYmwwblVnUWNjSFU0VWZjekxjcXF4bUJwbVhydElXT2Z6dUdYc0d0?=
 =?utf-8?B?akljQjZEUVp4L1JlcHRYNWdLaFhERGIyM1F6WU5IbndrT1pWbXpHampyRFZE?=
 =?utf-8?B?ckNVV2ZmdlpoZlBLb09vc292dGJvUFRyTVVCQUlZTXN4c3ByRnVXVGQwR2tI?=
 =?utf-8?B?L3hXQmQ4V2t3YTdYZThRNkZFNmxPaE94QkRnTDRoaXM1WlcxRnJMUEF1NFY2?=
 =?utf-8?B?N2JjVk5JQlBaV3ZkRHFNK3RONzV4SmtWVVRkbHJ3NzFKKzNrZUVKSm5hYVMy?=
 =?utf-8?B?bE5xa0dLR0F4SUFJNVFDV3BxbitsU3Z3dUtrZ2hlc1JSOEhBakJXV09seGlv?=
 =?utf-8?B?Nm5WTFc1aERqd2hzaCtYb29aU25oNW4xUkwyUWRnRFBkTlRwU1U1Wi9leGtl?=
 =?utf-8?B?dGJORzlWWUFpLzRrcUFSQ0xsUVgxeTc4dHZzT0VzNm1RL0RtTDBVZ2NXbjFI?=
 =?utf-8?B?T2FBMGxndVcwaTl0WGR5ek5LN3ZHRUE2Q3l3QTlPM2ZUUWt0WElKK1Y4Sm5m?=
 =?utf-8?B?M0JRdXdnRlJqaTlQK1owWFIvdHVINUQvMENDeHk1aGtCS3NuVUpyKzZ0djdZ?=
 =?utf-8?B?SzlKUlJjZUNvQkJLdkI4NEIvc2pUZGZRNjJ1MHRjemdJcy9rRkF2Skhaa1Uv?=
 =?utf-8?B?cmRmZit6N3Q1YWFRVWl3Nm1QWERCM3dqYzRMZUQyNkpDd2xhWk50bjB4aExD?=
 =?utf-8?B?WFdCbkRUYWl4dmtpZS9sZXJYOXNIWHVmdVJKMVduVnZEQmJOdlJVVTVESTlq?=
 =?utf-8?B?d3pHUmhGM0VhT0lCeEJPa010bkFKbXRpbmVpQS9DR2ZpR3B4ZE5Ieit1NE9s?=
 =?utf-8?B?ZFNVTERaTUl5VmVwVGY3QjMvMEhKK0tPMGNqdVBjUzEyWStMNHNpN1YxRWFq?=
 =?utf-8?B?TE5pcXhkd2JHa0VLWGQ1ZWJXaERYSVBSVEhjQVhGUzJYZWc5Y1ROUjlFOGV0?=
 =?utf-8?B?OUdtMmNnZjBCTVMzVUp4QWRpNzFVREpsc0U0TmpYMW9qRXEyOGhGV2daUTlQ?=
 =?utf-8?B?aHFyNHExN2o0UlpGT3JSUUE1N0VyK3J3MDlyV2F0TnhXRWJmdWw5V0Zua0xu?=
 =?utf-8?B?OHpuT01jeVRRQ3g2MGU4V0Uxd1NIcWVLRU5vclJhZEd0QUEzQmhpQnhqNno3?=
 =?utf-8?B?dktDNDIzZUtRR1FNSkxxUE5pZ2tTUjNUdTBNMTFwQVp4elhCbEF2Mm5EdGRx?=
 =?utf-8?B?QVNaMzZGTVBuSm9Kam1lb1JyVnhuajArbmJDdWgvYnExOEhhekxSRmhKdHQx?=
 =?utf-8?B?d1pWcm90YWpQeHBoUXNnTnAxenJtYnptcnZwTi9uaEpPMC9TajBnZ3VVeFdm?=
 =?utf-8?B?OXBLREdDZzdVZ2t5WWNtblNjVXdQaWpsQnJnNm44WWVXQStuNElJK0twRHVQ?=
 =?utf-8?B?M3NFUklTK0hHRytGUTZMSkRVQnM5TWhZMXVlTDZKaXFPa1J5UzIvYkpZeFNP?=
 =?utf-8?B?WEVDdysySElMZXQrWmN3UEhjNXpiSWVUSXBVU1RqNUNuTEdsNmFSd0RIVzZr?=
 =?utf-8?B?cXlmNWh4MW1XeUd6TDlRWG9pN2JLTEg4Sm1JbmVGb2c0WGp4aERtOVovSFJB?=
 =?utf-8?B?dWZXQk1Wek9FUmdCRHdzT1F3VVVLanlQTkg2MHpISk4yb2JLUFFwV0l6eU5Z?=
 =?utf-8?B?SitRVHUwK1pqamp1WHRXQWphMDQwSkxyS2JEWVlpTDB3UUEvL1JoZFdMUzBl?=
 =?utf-8?B?dWpTbkFSbWNWdUZvcGxPU2diWlBTUnhhSDFCSW0zLzhheXpVSTdRZUIzbDJx?=
 =?utf-8?B?NWhsbnluQ05FaDhYdzRrTHNmRUtid1BuYjJjNEJhZFhRbk5CaElIOTJMTkJS?=
 =?utf-8?B?UVZxL2NIRCt4Wm53RFNERU81dkpNSGttSXZrMzFGOGxGZGxVck9uMlp3U2p0?=
 =?utf-8?B?d29tbWhJaXkyMmwwYisvc2xJWmd2VEJsRXFuTU1yTVViWWluOUVDaUpHTkNm?=
 =?utf-8?Q?oC7RDGJUqvhWdFf/NLckE4/aP?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f6fabbb-32af-4dff-07bb-08dd60ce46c9
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 18:55:22.4706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DihShExpJ1viqpfoAXzkzXkGSabkZtV5ANZqxy7tmcTB74adLwN5P2d+cEU5ZMAZASFTPAXcmlIUWxjda2Jafw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10273
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

On 3/11/25 12:25 PM, Gour DEV wrote:
 > Hi, Kienan
 >
 > here is the requested output
 >
 > root@localhost:~# top -b -n 1 | grep  lttng
 >     4841 root      20   0   11.5g  11.0g  11.0g S   5.9  35.4   8:39.93
 > lttng-c+
 >     4824 root      20   0 1098824  26456   5380 S   0.0   0.1   0:07.25
 > lttng-s+
 >     4825 root      20   0   48872   2188   1012 S   0.0   0.0   0:00.00
 > lttng-r+
 >     4843 root      20   0    3680   1160    816 S   0.0   0.0   0:00.23

This top output for `localhost` seems very different than the output for 
`localhost` in your previous message.


 > lttng-r+
 > root@localhost:~# nrpco
 > bash: nrpco: command not found
 > root@localhost:~# nproc
 > 16
 > root@localhost:~# cat /sys/devices/system/cpu/possible
 > 0-15
 >

You indicated the bookworm machine has 32 cores, this is showing 16. If 
you're comparing a 16 core machine to a 32 core machine, it is very 
normal that the memory usage is higher on the 32 core machine.

 >
 > Most of the process are running as asorcs user but some are running 
as root.

So you have two users with instrumented applications.


Given the discrepancies in the information provided I'm finding it a bit 
hard to understand what you're looking at.


In general, a channel's shared memory footprint can be estimated with[1]:

   (nSubbuf * subbufSize) * (nCPUs + 1 iff snapshot mode is enabled) * 
(nUIDs or nPIDs)

Note that the sub-buffer sizes you are using get rounded to the nearest 
larger power of 2. See [2].

thanks,
kienan

[1]: https://lttng.org/docs/v2.13/#doc-channel-buffering-schemes
[2]: 
https://lttng.org/man/1/lttng-enable-channel/v2.13/#doc-opt--subbuf-size
