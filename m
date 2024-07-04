Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133AAC30653
	for <lttng-dev@archiver.kernel.org>; Thu,  4 Jul 2024 17:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1720113594;
	bh=Crn3O8/R32ySkFHpWq5383VrBLfRRsPZ7MU6DPqIElE=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=WnB4sP/DNQLiOJYwfpANjTSEXmn2Lp6gEG7JKDxkggGQzekREuVZT4EwBVD849tkl
	 iEiauVecnsUVBF3eXlGoDr26BCka5LDRkjya/FbzwIbGvg5IgO3dr45YRh8eLVQP5c
	 L+Ftbsfd4rOLiQP0laECGDPSapQNqc7B8q5BCgF7xKgW1xh7rKaQRDGAT4vahyKVg7
	 vnnRRC+YKotYNjpqt40fgWnFA4VGJLkHF+yl5FiBBck3HDi+qi0pFpTUfSPeQeLJTH
	 7ozhBA+bLHWXmJgau8kjuLLLzsriyYLHO7/qnPPPhnygSzsvsI+uzKWDLwrvIm3pNs
	 D8Yiw28oVUyZw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4WFNgZ2MSfz8pf;
	Thu,  4 Jul 2024 13:19:54 -0400 (EDT)
Received: from YT5PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazlp170110005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::5])
 by lists.lttng.org (Postfix) with ESMTPS id 4WFNgW3KXjz8md
 for <lttng-dev@lists.lttng.org>; Thu,  4 Jul 2024 13:19:51 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C60eQAqR8g/iH0vb6JVlYEozuJ+rBNyrZjfyR8niB8lZ1sTZ9pFIBCDnkY5HAe0b9C9OrQy80NNfGsMikCrFQhWXtmJCYHWgAzcalVnneBGumS9xGTyV2QfYOPQx57E7+cKOLwctWHLZTRJUuFddWrex1ZGbt1/OToUAV83Pt5XyumVTGN0Vz2IGQ6LEDAjYyvAz9NzUQceROmcI4FzJxkSgHlddQB9P9oVbcVkjN4mC15bRuir5x6RNwhFZzzFBF5JPA3KXXgvczmMZplFVsJgQD8W9k88X+0tW5mqyDBbaPBV1ePEKOd4tcxFUzGHi392qjJqxzOVRtG4UqFWq0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxet2JNlbAWCepRu+quc+hB37zmXIXgI/gpp7YuA8dk=;
 b=QGYeEjK4m8oqDi5wI2z3jYlSi9ArQFMq9iiKWhMtqCa+SXkvDxrShkZWosRzeJBzN9MO3NwZoQUuVnwPZrQs5cYdy5J3KdDFoatNL1g9veVAyVeE2IExlseYykotme4+xKfd6+fnj2r8kbwdFaHWJLuRvkQ3eQqH6a5z2SSU06HIAiH78SlfKlIrD6BzbVk2HcbI3GXJImRBTgKs1sO723Kf09z7g81FAcEFIbDEvDiAGPWi7BXjkXyGXA+c254mG1pt6+OCPdNParpf7jrI+zF68XMG9ollf+u9oO6erN0G8DgW/TSKvvwKUpPwST9gv7oLqCyKZz3li2rSsTa5sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:24::5)
 by YT1PR01MB8378.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Thu, 4 Jul
 2024 17:19:48 +0000
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::be09:e1b:b343:7f9]) by YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::be09:e1b:b343:7f9%3]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 17:19:47 +0000
Message-ID: <04a40534-adf6-4805-bce7-318de6584184@efficios.com>
Date: Thu, 4 Jul 2024 13:19:46 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev <lttng-dev@lists.lttng.org>
X-ClientProxiedBy: YQBPR0101CA0280.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::29) To YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:24::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB5080:EE_|YT1PR01MB8378:EE_
X-MS-Office365-Filtering-Correlation-Id: cacc98bc-b089-4ca3-222e-08dc9c4d810e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDVRYzg5dk5VMVcwaVRZcTlFZFZPODJXL2JPWmZxVGNQK1N3cDJHRzhsczhZ?=
 =?utf-8?B?VHVGSmh1eTN2RzlYRG91RVJ4NXRHRWJyVTdGaDZDdlowK1NzV1VjbGcwZXhW?=
 =?utf-8?B?dTA3c3lYTTN5RFlId3FubzkwNG5GOVJoUXl5STJFTVJKOXhPUndMR3NHUEdN?=
 =?utf-8?B?V2dpT0p4Q3prWTV5UnFSN0s4MGp1RC9QNUpqR0JBemdXa3JiUlpmQkVLeVJi?=
 =?utf-8?B?T3JMMHRCMHNpZWRGbFM2QytaMzgrVUp0cEJFaUFkcjZFNFBtdG5ZN0hZcnFp?=
 =?utf-8?B?TmhqUXBaRG1ONUFlQnhVTngwMjBFNlgxMmR1ZXZhZkJqMzV6eVNGV2hUa014?=
 =?utf-8?B?cUl3ZDZyd0JzK0RWaWJJQUEwY3FTdGFENlg1cnlnTVdYY3gxM2lSZmNlbVJa?=
 =?utf-8?B?T3Z2TEtjcHd6Vmg5MzhMMGJwKzhhY0w1Q2IvS2Mzd1FaQjBoVy9JY2FzSHdT?=
 =?utf-8?B?R1cySkk2ZWhpNFBtQmRMNyt6a2tEalpZUFFQL0hRR1ZsZ2czVHpzY2I1dlkr?=
 =?utf-8?B?Y21NczFQNDZhTVROSGNzZWF2bzlqL2QvaFNGQ01JYzUxQmF1Z2NrR0VVT0ps?=
 =?utf-8?B?bG9TcGpJampDUldRYUw3N2NocXZQbG9EZHdyNUVyM3l6S2ZEZjNjQmRtZjEv?=
 =?utf-8?B?T2FMT1pUZlA3STVrb0NXdlpLQk9qNk5BRlJISjNRaDh4RTEzdkJJN2c1QzJ2?=
 =?utf-8?B?ZldKWWYvYmc3OS8vS0FwT3hpYmZFR1VDc3NRSzFOS3h1WHN0YUNOcW5FK1U2?=
 =?utf-8?B?TUt4NjlwZnpuMUNwT0lHQ3BsQzFxRGl1NzJibUVxeXRoYjloL0hmMjQ5NHNF?=
 =?utf-8?B?Y1pVVVVtcEE1V2FGcE0xMytkNU1RQVpoQ3VDalNmdklVVVBaTmF0K0F6MElU?=
 =?utf-8?B?VjFaZW0waW8wTDFRSzMxczQxSlpMTE40RTFoMU96aEU5ZWE1Znh4Zm0xelox?=
 =?utf-8?B?VWVEY2Zzc05jWnkzZ2ErSWJzYkJMQ05KZVlCWWZ1aGwrM3dsNXEvak5NeWpk?=
 =?utf-8?B?Q050NWpsSEFTN3RadHhnMFA3TitndVp5WGxEMWdvcVRnRmd0UDM3ZFNOWCtx?=
 =?utf-8?B?TTBCTHIxeDJibHdRN0xtUFIwd08yaWFnM0VVN25xSmdXLy91VnN0Sjc5NEgy?=
 =?utf-8?B?R0NYM3FPYWFCZ1ZXa3NKY1MrVkpLYlJNVGhYQms3YXRvK1FzZkR0MjRhRkgw?=
 =?utf-8?B?V0FsVkd4K3VBNGdOOUIwRTNzT1VPK2t1aEN4S1luS1B4YkVXRlRmekc0dFJX?=
 =?utf-8?B?MkFwY1YvUlN1d3lKSmcwMS9ZU3VhRCthM1dObnE4cXd4TFBrc25EVDZDRXNO?=
 =?utf-8?B?bnBSbXJMQnpXbm1OWUFkVXp3bGZON3RBL3VsdDRXR3RoWWlVWUljK0xQSDNx?=
 =?utf-8?B?bUFEa1MzK1pwbWVQZjJkRE5EZUk1WHowV24vcWI1dFJrMEN5V0t5YWNTVXZU?=
 =?utf-8?B?OFBvZ21EZ0p3Qm96TTA2aVdPUVVEdnQzRVAwbkdWT1ZIZXFqeG1aZEZJQ1pv?=
 =?utf-8?B?ejhJZWt3UmZpcjNxQVdrUU9CVEx6S0w2bFJOcnJuZ1lWbTNSczV4RlUyaFl1?=
 =?utf-8?B?a2FHemR5c3J4VnpWOXljVGFaQzgxaGhYbDFEekpTL2R4WHg3V25Za0grQk91?=
 =?utf-8?B?WkM3dWFmMExFT0JNK0JMVTBaR25Jc1IzMkh2aGhlSmp4UUgyK1dSdnZpWnEx?=
 =?utf-8?B?T0JTY3NXejFBOE1OZ0t0TGVOVmtyVlZUSkt0Tm1EbDNrc1VwaWhwZTBIVkJ5?=
 =?utf-8?Q?Vie9mdIugDP+1bMKrE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3NtbHhjZEowRmEwTmpyY2tMKzZUZkFBSVdMa1FUamplQ29ZY1BUOUFxQ0My?=
 =?utf-8?B?alZyQmIyOTA0RGtmZDhuRERzYlo5N3R1MERqNnZOOVFEajByVXBmLzNuRm9i?=
 =?utf-8?B?VjVtcVZqS0tvWXNoOEp4aE1hVk1hbEpHWXljd0pHMkloU0NuTlJiOTdWRC96?=
 =?utf-8?B?clc5cmNEc25Qb3J0TW83U0E1RjZtTkwyUjBES20rMW5ZbU9XRHZ6Mm9wbWta?=
 =?utf-8?B?eUQ1eGNyazBLV0FDNEZiVEc3L2o0OHpYOVNMc1ZkWUpzMEpnZWhiSkQzZXpP?=
 =?utf-8?B?bEZiNlliWXVmbkl4clJCRmpiS3ZUQkdEdUwyYzVlRWR5MlNzNTB5Nmh2ODNj?=
 =?utf-8?B?alJSNWF1eGpwRWNmbHU1d1ByYW1NVHhuVlYrQ3dLUlc0TXdtRDdRSTc2c1Zl?=
 =?utf-8?B?czJpRkxhU1FSbnp5TktCcnN1QWdzRzl6T3MwQXRiTFhVSVZESHdrYUNvZ2kw?=
 =?utf-8?B?SU9HMnJyM2N6RTEweHhhTktVdHhSMWhlNk9rd3NpUTk0RVZ2dGZOZ2ZaTWpy?=
 =?utf-8?B?SVRKczNWaWorRkNJWVN3WDBmZUcwd242blo3dnYrS0tTcGZTR2hHWnNnaTdy?=
 =?utf-8?B?aGZmR2JYNnJGdWg3YkFGNU9TL2krQkk1cXpUUTI0VitBOHFEKzViUHRDemRN?=
 =?utf-8?B?aStWWi9pWGV3Mmd4eHZDSGdCTzlhQ0xkRFFrUHJpZFBaQzBERmd2MllHT29X?=
 =?utf-8?B?aU1VL1ZZcCtVSFZhdTlUdTMxTGRoQU5zeDlJdzQvZnl2bVJBOEM3UXZKUWl0?=
 =?utf-8?B?K2wvL1hlYjVWeDdwc2tqaDd2ZmxMN0syMXBja1FHNDJOeUc5bmdRSjl0ODlw?=
 =?utf-8?B?dHV0ZzdOam1yaHdtcWFOS0FCT2o5dnViajFscFJ2RFZZUXV2REZENTlLK3R5?=
 =?utf-8?B?ajZaWUl5SEZ4MW5YY3drVHQyYnV3OWEvTU9xQ1pDSG9GOU41L2RueXJUV29I?=
 =?utf-8?B?dDE3dGRwbFhXbm5mZXNsbVY1ZEt1N3pGNVhBVnNnVzRodmFpZC8rNjl2dnY5?=
 =?utf-8?B?MVZhUWgvVU4zTGd0ZWpWRW15Und3QXp1aTgvK1l3WGlMcEJtWkN1TDI2bjlj?=
 =?utf-8?B?S05NT2J3UlRYNHFMUXMyOVNuV2V3Z1BNbjBKRDRZaFNuakZSazZjZUIwVkRv?=
 =?utf-8?B?aUpKcUJ0T0xTcDNsc1NWcStJMXRURzZaNmtWcjFtV1VqMVVTdXhKYkNPRnFZ?=
 =?utf-8?B?VVV6NEVPbUlrODd3UzNZcFdqYVJ2Y1lRTzMzdjZENElXV0pmUktDTFR5RWhF?=
 =?utf-8?B?NmUxeEpISERaR2RJYnRVa3orNEYwYjdYOUIzcEJwd2FTUXNVbTZJMWxCYSts?=
 =?utf-8?B?WHMxY0dkVklWTjVBQXF2cmh0cnQ0dzdsYjNNamFvOHhNNWg4MUJTRU1OaXV5?=
 =?utf-8?B?T1lrMEVqT0g0ajMvVmxTVlhMd1FaRXRYaWhORDB1dTZuL3NlQlh6cDFVU01q?=
 =?utf-8?B?T1ZZa3BmVlZpbUFwMFJDcmM5ODNkaUw1YjlDa1R2aUJwTThhaVFqVmswLy9Z?=
 =?utf-8?B?MisydXMxTTM0bXR3S01jMVNaYlZ0M01PKzBWVWxJM0Nzdjl2QlNJOVIvN2R4?=
 =?utf-8?B?eEpUWW9zdUdCOTM3N1V0OU1HbHJXd3I3ZWZobkRXcVhkUHBzdWFQWWVPWFRC?=
 =?utf-8?B?Z0EyTktaQ0JYL3N3N2pBWWoxTXhnTytNNllOdE5MMVlTcFpGQit6REFRLzlB?=
 =?utf-8?B?SDBJMitoQndwRW5XNU1TUWhvUzFuQkJKejg0WDd4K1F0V0hSbTcyWml2VmFZ?=
 =?utf-8?B?K1RSSVRNYmM1NEg3UUZianAyZUZrNjZlV0NNbzZxOFVHM3U1QXZhYjFETmRN?=
 =?utf-8?B?RFN2amo4aDAyaVdUTjJiTTl5YXpKUEovUk0veVV3Z1dtUFAvVlNOSjExL2dT?=
 =?utf-8?B?Y01MeUtMa1IzcktMbTlkWUhLNWFzZnBvK2pxV0wxdjF2eThEblNKZmpPR1ht?=
 =?utf-8?B?a3hpb2VBSEswYzAvQkRHaHR4SmxWMVcwNnVtZjFWZi8yVXdPTTdlQWdUcWxp?=
 =?utf-8?B?UWYrWGJFOC9qRTliNmhmZFNZUnViRktqMkVxSVg0dWlOUUNkWHpZZjN4ZE82?=
 =?utf-8?B?SEhZbGRXTEY1cW15MTNKVFhmM0ZOVEtWdnh3Y3JleEFUbE84dldMNjlFMmVq?=
 =?utf-8?B?Q0hFdzl2cW8wRHpaY3JZOUxHeUpRN3Q5YnF3cFhUaFNRRTNiRVFuNm5HTHRs?=
 =?utf-8?B?Z3c9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cacc98bc-b089-4ca3-222e-08dc9c4d810e
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 17:19:47.2343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERfiAKmH6YipxC5QJab7AD6Xs0hqJ0KFRG1zu5J6rW5ZkYdUht9PJeX4astv3iGMgh9mmfjYN91hgyVm/0+S4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8378
Subject: [lttng-dev] LPC2024 Tracing / Perf Events Microconference CFP
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
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

As there is no Tracing Summit planned for this year, we are co-organizing the
Tracing / Perf Events Microconference at the Linux Plumbers Conference on 
September 18-20 in Vienna.

The CFP is open until July 12th, if you'd like to submit a topic, the details 
of the CFP are available at :

https://lpc.events/blog/current/index.php/2024/07/04/tracing-perf-events-microconference-cfp/

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
