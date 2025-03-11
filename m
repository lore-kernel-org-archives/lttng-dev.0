Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB1DC28B2E
	for <lttng-dev@archiver.kernel.org>; Tue, 11 Mar 2025 13:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1741701318;
	bh=tSkOkQ/mqMVBfj124UOhck2zukg/AnfNCSgC9zECBJ8=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=hcrNXkvWv/NV05G07V6dClEoyDuqta9JQ80rPo8r84Y2L7JESlPHkPozo7SfEDlr1
	 nlDuDLTEiek/R3/SGiem3w9WvxUSgul5VgoaTyOo+iEiKFwzutbYNJ0lp3enb3iqJn
	 jTJxORifpQ7BOwTKQdNDPLq36PL8Y3fJPLPIc4hj8hBpRMoZJucfIrdWBZw/4++0PX
	 s81IGVjdvZGEYAVJlMZiyZZ1/p32U1zwXbkQySg0XII/+p27nnQAYlAkjDi7AK6UnF
	 zmEsRpLTv8ixqKhZqRM+jDUbjNOSsJ/PwUGxNoa4xx6RnT2Ji0uXWv+T+dLZYKamx4
	 E3DXlUoQM1Iwg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ZBwJ54h7Xz21nH;
	Tue, 11 Mar 2025 09:55:17 -0400 (EDT)
Received: from YT5PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazlp170110005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::5])
 by lists.lttng.org (Postfix) with ESMTPS id 4ZBwJ443lMz21Cg
 for <lttng-dev@lists.lttng.org>; Tue, 11 Mar 2025 09:55:16 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbqH6iFKF8basQTeQ70w8mBDAnl15ETeIqVpqTExZAPRR/ZyMVAwoDl0kUctpPMf1ZHfnDREiz/PBT/cXIfiWCz1sz4NA3l3bR3Z02Z6TaYzcCTYwLpb4zxgo5CYpsLKkMFMB4wELMugQxtu5C93yuTUu8KxWHqkfBB4jY9Ob+vHZobR0KRbP3Mzb3le238ybfIBfKzmZb9FLj5EtWj1qjBm8EwQAVleHyIWMYR5gRVIiD3dTHxWnOIx2cPp4bbPyOxnEHxInDGK3+Xdqbvagpk2yCGFqYhE3RzQABAZ9sN45/7Mnb/aj0k1khzcCIWq4Fy2yitM/EpqRZr9yXwiaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDFRFchFYUegeklwg2Ud7v+RhGUxL/0hI7Sa9UCeI7o=;
 b=k8lQkMlt90nutwlLEMLSnSs/skyVMv14ka9wK05lCxwQz2w0owCEUwQfiitH8g5XBN7PadrNr11pJWXGEgbGN8qrs7wbFFpvX5oVK7yAltlaJVU2Zym9xAwi/lMhQKPxe515RTz0JSVZG6nHcNMzpSfF62IDSn0qETZO3yxpYl1Q2gelMevdNSfBd8Un/OWfCRBVWy40i3RVaaom/428mTAis7MIDJHhGaSuvquNwpxSVAgMy5Z61XUApnS+Gx2MFzaNPEyC0FCf0tp8Mg74ibGojl+L3ZtQyNjMu4dBNHcWVUJ88uf202933d799QHiNTncYbvs2SGA8mozWrA0DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YQBPR01MB11149.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:97::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 13:55:15 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 13:55:15 +0000
Message-ID: <8a3a094c-3afc-49da-8764-8fec1179f7c0@efficios.com>
Date: Tue, 11 Mar 2025 09:55:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Memory Consumption High After Upgrading to 2.13 from 2.10
To: Gour DEV <lakshyagour10@gmail.com>, lttng-dev@lists.lttng.org
References: <CAE9JrziSBzHDOLjLzY=8FHPRWxm9+xq40Kzq8GUivb=u9V74wg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAE9JrziSBzHDOLjLzY=8FHPRWxm9+xq40Kzq8GUivb=u9V74wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::36)
 To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YQBPR01MB11149:EE_
X-MS-Office365-Filtering-Correlation-Id: f06d48e4-bca1-4126-1849-08dd60a45984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emlybzVZaHAyL0YrV2RYcGNlejN5dGh0cUpXbENYR1JKV3NLaE1MeTRSVjYr?=
 =?utf-8?B?UktzcG1FYkpoUEpVR0tQTUxvc3B1OGJxVDRTQmtpMlJmMXRGR2cxNEROR1M1?=
 =?utf-8?B?TGg4WTErSUVnUXdtdUlsdXlTY3lLcUkyaE5wcC9DM0pUYlZGUXVXLzB1WXhM?=
 =?utf-8?B?RkNEQnlGRS91ZlRQWG9HNCtrOVpqbDlVcHFVcWpldzNaSlB3YlB5VUovYjFR?=
 =?utf-8?B?UlVkNjNhT0FNczFkY3Jwa2hHdUdUZk1kUSs4bTFqWnY3OEJFaVBkOExCaEpw?=
 =?utf-8?B?cVJQQzFaNlpSTThoaEhIV0pSWFFmSXhSWDRGV1pHRS9Va0lacVZ6WkZ5NzVs?=
 =?utf-8?B?Mk5SRm9RTEM1Ni90UTArd1NQK09OK0RNdUR5Zk9ad1RuNUM4L0lZWjVaaEFp?=
 =?utf-8?B?a3FkdlhTbUNoNXBNektqcENBTFBtNGt0alc5NncxRjdXSEkzVUduU2NBNlRw?=
 =?utf-8?B?NU5SamZLcG5iajBCREtHSHMxbFJLNlRJendzTlljL0xiN1VjbWd1cjk1elpk?=
 =?utf-8?B?OXFwYnBEMDRibDU5eE9MUW5uRkhXazVITENJRmx2alNqTkhlQTJrUUxBRVFL?=
 =?utf-8?B?UTdyeUZ4Q1ZVN0lxQ2llT3o5SmpyVzQzZy9SNC9tVEVlZkVhak81ZFVzVDVQ?=
 =?utf-8?B?dlAzZ1J0N2puTnM4YlN3VTdIWkVBUmhTeTBTeENQRnFScFlKaERkS3I4eHNG?=
 =?utf-8?B?dGJkTkJURmVyWXF4TERsMUZ3VEFUbmRpNmhRNkNYaUZjMWJlK2ZZQk1ydEJP?=
 =?utf-8?B?YzVFd1gzNW0vYTlkN05HYi9naWh5VVdIWk83MGxGb3ZBWXZVWFZDZ3hyVTJw?=
 =?utf-8?B?dWpFUVY5T3ZkWlRETXJYR3l5bFBQOTRFMjJ1ZldjZWFyb1BXOTJpek1rMVNB?=
 =?utf-8?B?a2I3MitwRzJ6T0NrU3NISlROWHBuUEMvRlN0SEVRSW8wZTN4d0JaQi9nYnBF?=
 =?utf-8?B?ZnBvZXBoQ0tFNHJMQzdFTjUwVzN6NlVuS2RYTVRqdlRvdkdGb2FwajN0U0tO?=
 =?utf-8?B?MCtYYlUrL0FmNGw2THhYTWRDcVpMTFEwalBQTGNuQnlGU0hNWkY3YlFCQzRR?=
 =?utf-8?B?WlhGaUJsZUNzYy9xRi9XM2crUVpodWk2MndnNjhDMTJScW5WUW9RWnI4eFhx?=
 =?utf-8?B?QXRoNU03RTE0ZWQyQXJCcGcxMElBandaZ0dxT21tRXJYRTlaRkNCRjI4V0RC?=
 =?utf-8?B?bDVKQ0d0OHhmZEJsQ2p1bXNKb0V6SEZKamRna080UE54Y0NtOTBURWp4NzFa?=
 =?utf-8?B?aUoxbmoyNHNIZEJGRDRzb0ZRMXRpQ1VnblJEMWkwbFQvQVlpZG5zWlRqc1BL?=
 =?utf-8?B?WGtWeHFWNFpmNnN3RkxWV0daSUlNdlczQTN2a2JRL25EbjBuY1gxOFhsRmor?=
 =?utf-8?B?eEk3MThHSlpNcjl0T2N2Ti9oZkd0dUEwZ2J2elhaNVNYbkVXWUF2L3RIcmNF?=
 =?utf-8?B?K1lrZGtSbUI5WHI4WlNtY0xMZWNJNEdjSUY0clVFbzkwdTVRdGpEbERKZ3RS?=
 =?utf-8?B?YllzZU0rcFRWSWhDYUJBQ3dJZTQxRzl6RlU3U2ZKOFl5MkVLdjZ2WVZEcThG?=
 =?utf-8?B?eWNHbGdCYzlUZWppTndnY3pEczBIdUxkNEQ3QlhWSmUzaHlNdUtVemFkcFU0?=
 =?utf-8?B?ZngxZENNazJxVWhQUStBbUdUTW1VcUY1RTQvaVlFbklXN2pzRGVpRXBheGI1?=
 =?utf-8?B?WkRSbjltNFB1L1V4Yk9mUkpJTzZDaWhzVU1VSkI4UkovWFNWd2RkM3BFY0Z2?=
 =?utf-8?B?QUlFTjNnaFV1T2kwOGhNeS96cWU2Z1FDNWxMdG9MWmk1VVEyeHNBa2RVODhE?=
 =?utf-8?B?T1JjOHFGNzJsNXE0cHFwaDdpakdSTmlQekcveFVFOVVsLy9nb0sxMlBMalY4?=
 =?utf-8?Q?7tyYatupvozBM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXpjVjdtVXVNVnU4VEo5YjZpa2VZVDJWcnFTdDI3aXA2QitHWEVBNzRyTllT?=
 =?utf-8?B?WDhkN25IQlZ6ZUkyZnJlbFBxUG84bjdVYUpiVWplMDZzc25NbVVUUVZUK2cy?=
 =?utf-8?B?V2xlTkZxcnQrbzk4dFU5dFBKRlAwQTMxRThoSGVmQ2JWcHUvaWswdmRsWGp2?=
 =?utf-8?B?SjZobGlRNmYxZ2FjdnJJNDkwSVpxVVhjYzZIckZjd0dnQ01TcFJpTEI3WlAz?=
 =?utf-8?B?Q3BDUTNpUnpBaDdmZVA3TlduanN5N2VEK0FvT1JRcW5pb0F1ZmJneUdoaTJv?=
 =?utf-8?B?VXhZaDZTVVk0UjhqZ3NldzQ1eGIrNk84RHNucHhlS1EvWDVOanA5RlF5SXNE?=
 =?utf-8?B?WnpoQ29rWE1ubWZOSXVVQXY5OTd0cnVjeUcyMmRLbGdzeDVVTXc4MHNlUFVB?=
 =?utf-8?B?bWg5aUNzRUlCTlhnQmJjQlk2eW9XZ2ZTKzhkQmFzbmFDcms5T2w1bXNQd0J2?=
 =?utf-8?B?aVg3TGNFYWpwR1lNYWlsdGUyZU1Ma1ZrS2VwMkZOZHBwNkVZbVZtbHpHMlpj?=
 =?utf-8?B?azJNRzFnT0RtM2wvS1hvbkZPRG1xZStGYXJyS0FrRk5xY2ptZ29VSm11OCtq?=
 =?utf-8?B?Uy9VSkZIZFlldzNGbzJhVjdOenFSVkZPQ0ZDbjRjN21kcHVOZ2xPWXp3dzBN?=
 =?utf-8?B?WGlzaUtjdGRYdXY5UDluSFlNSEIvSzJFY3A5blY3bUE5aUNFeWFFdHc4QXhp?=
 =?utf-8?B?cHZiUGIrUmdKNENudzg1c2E1WUt4TWVSOHlXdExiTmh3Lzd2VDdGazdhdi9a?=
 =?utf-8?B?VDNaTy9Lb0s4TURoUEozNytEOGhpRFRCc1IwWnV2aHZyaVV4bzUrZndYUE5G?=
 =?utf-8?B?VTRFb3ZxZ2d6VkhFamJ6UTBEcmR6OXdITW9aUmJPWWRxVjNNVjNwcmowYzBG?=
 =?utf-8?B?cUJ1bE1JOXlERFFqU3pPMTFNUERON1NyZnhDLzgyc01TY0htakkxeWZmbTEw?=
 =?utf-8?B?anNGaWtSV0RrM0N6anVTaFpaeDJsTmJ4NkxFeDBRYUJkV3JKcUpoZWVYN045?=
 =?utf-8?B?dmUyOGN3MDlpd3FuV3ZVdm9aSThmbkxocU9tZUlULzlZc0hjK3c3NkdUOHpo?=
 =?utf-8?B?b2tQMkd4eXRQYnNSbW9oblYwRHZNZU9Tc2QrRmNhaFRxaTJoSDRaWWl0aGo4?=
 =?utf-8?B?djhVdk8vS2Q5YWQ4d2Z0WHJmT3ZzeXg1WEZoYkRpNFJ5SnlKOTRFTlZVZmVE?=
 =?utf-8?B?NE84WHlRaldZVWh5R1dnY0pLNHZKdWQ0ZHEyWUZoNHVnNS9qMFEzZ1RMY3Q1?=
 =?utf-8?B?ZXErRjcvK2ZwL2NIVjByLzk0ZzlEeUlqRmdPTFJVeGtFRVJWOUFQT3Eya0FQ?=
 =?utf-8?B?ZlZvdUthVWJ0eXFNN25EdkoxdVd4dUsxODdzSzFwcHBYODlVQzZiUDZhSHlQ?=
 =?utf-8?B?WC9PVTFZMWVSNUN0T0JwS01KR0xybjkwVzRXR1VqTkROUEtVUHRvM1QxZlBj?=
 =?utf-8?B?YWFpWS9WREFkUzdRY2RQcUpzWSthWTZLbWRiZUlZQjFoVGhjdzdiSk9YTDl3?=
 =?utf-8?B?RzJzd01SK2xFMDdySDEwWGUwK3RSWk1pZXNUTFRxeG9uYkVPUjgvK2ZjcjZ3?=
 =?utf-8?B?YnJ4QjVEanNyTS83OXNXMmZXZlFHWGxHREdTSEZRZ3piOGhjbVg5V01OdkMz?=
 =?utf-8?B?NW50OWZZOWp6SW9tU1BlQ09UVjBTS21oSC9IaDR3N3M2M1VHL3ptQXpmNUI3?=
 =?utf-8?B?YmJIQVdDcWlzcEVaZ2FHN1lUaHdSZGF0WElqVkJsak1POEZNREY0NnV4RFg0?=
 =?utf-8?B?SktIUU1VOU9aVFYyZWd6MVpibGxNNHFLTVRwOHFBeTVwOTEvMkk4Wlc0VEwy?=
 =?utf-8?B?cy9DVXZJczNSZlZobVhtY1hNRHUvNkgvVmsvQVlGUHNqd0dpbmdRT2dEOEtN?=
 =?utf-8?B?a1ZmYlE3NlROenE5dnNDQ0IyRFJFdDlpWURGcFBDaThEY2xsQjRhK0RyL0Vi?=
 =?utf-8?B?N2tZbW12WlhzUVgrN0lDak1HYnJQQTRwZGtYUXVscGxQamZJOUN4OUJjMEd5?=
 =?utf-8?B?bXRyNCtNY3VpL21uaWhIaXpMODFFa2RXTmVXdGxyWWd1ejVKQUlQLy9SRUpK?=
 =?utf-8?B?ci9ELzBNdldvY243THpCSXJTK0E5NUxwNndFcGdjQWF4SlVSSVFlMDZaRnB0?=
 =?utf-8?Q?iSLD1uEUL+o5dSDVY+NGcMs8o?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f06d48e4-bca1-4126-1849-08dd60a45984
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 13:55:15.0173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1aKOc1vgrxIrqGKTbYzB5IYKURg38oFo4AN/mIyhUFEm1ZruZaBccVHqOMmlQ8qjAlccbwlftrQnMzbgGSTEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB11149
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

also, when you are running instrumented applications which user(s) are 
you running applications as?

thanks,
kienan

On 3/11/25 6:35 AM, Gour DEV via lttng-dev wrote:
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

