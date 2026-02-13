Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4469EF99DB
	for <lttng-dev@archiver.kernel.org>; Fri, 13 Feb 2026 20:11:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4fCNbc44Q1z1CLg
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1771013485;
	b=kScvWF5DHN7uwdFKvhRyAHndXPQRkr6IQAsqgfsndOcxb9Cl568VDw23miEb0DynhJSM
	 jQvFER4wKbaWJg9ll7J0Z5Y+tjeP+uXGMCZqzZxiaJwdpmsCKwZrGwoZSFx82rx6JxK+M
	 Y5bl6u1kTE5pQgn2uIqADLURPvJK3m1NSzWOQ6MLYmcjILhX6Fk4c0GuKIJpwYejO8qgg
	 awFkIK6G6Q5s+RYDx5EgGXTs/GPSWbr1InQoGS+kfKTcJIGNT4qaXNCudXDP7tAjPsaaE
	 W2f2ndLIus65S8YxM5RA0xRNtd5ZSnduR+TuWiSwDa7nMAqT0jG9wqHntSZp6llDXUw==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1771013485;
	h=DKIM-Signature:Message-ID:Date:To:Subject:MIME-Version:From:From;
	bh=Sg9MD2YhPlcg+K5ZQy64cKdak35LA57+Y7gf870KGaQ=;
	b=amB/7CCXUdVkyejNYIN/c6/DDkHc0hoNjaM20XT7tAYNFitWw/m4/zgqXNEv6tr8IkPB
	 k43M4s2lnKXoUR/VuDJ9AG5ZmTsjpuj6gt+dNW1ajwiMRr3Bwgl1MJ40t5NKlC+mMzbbl
	 Z6BziDUgV+fcX8mtwozNaKROfRPnOsVW/g8wjxQBomkOgJ0VhoUhHPepifH9KN6W6780c
	 +PAfCE8gsfXXqH7JhXQj67kWhLE5crryVViGIaKh9eGATF9ZJ/XLu4l0LFkemMaNFdghH
	 ciT8iviMlIrFBPmk7sTvnPWFcR/MB/5MB4hivv1YjRu4oa+wmgNV3UYJKFF9WbrcQ8w==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4fCNbc44Q1z1CLg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1771013485;
	bh=XLZQtUj7zJPJqjJAv50hgtbXrLAFNdp4hq+WIlJrFts=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=jurYSEooNDqUlkFXI1Hbj1LAGUsZH+9MXOq+/fSyNu+yPc+hIgZQOBxorBPd8H4sd
	 T96g3LCfXTRuZ1rgbQy2Ms4hd8l5lCDT4H6KzliQ0aQ77pF2fruKhrxnvak0uL7XYm
	 mBXCQpV/xUEw8Wurw3tS6OrUrEfqfAgvWFGQuHSraVzebU3NOq2ZXTtsf+qlDVeJOW
	 gIj0mxn5AbJ+rof9/W4EezrmpCmWVHyicTDmFlGFjB3QsWZbgdnsQV7CrQIcNl+iJW
	 5npkrGqxbV/wwi4k9KNICCtATLS3IC1BN65xSNBAWpv3CYkRNIopxlKxmUNcj1LU8t
	 XZYUoO8qhQHiA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4fCNbc44Q1z1CLg;
	Fri, 13 Feb 2026 15:11:24 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4fCNbZ2Krzz1CHq
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4fCNbZ2Krzz1CHq
Received: from YT3PR01CU008.outbound.protection.outlook.com
 (mail-canadacentralazon11020081.outbound.protection.outlook.com
 [52.101.189.81])
 by lists.lttng.org (Postfix) with ESMTPS id 4fCNbZ2Krzz1CHq
 for <lttng-dev@lists.lttng.org>; Fri, 13 Feb 2026 15:11:21 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZ4VdpoSHjGjBXG7R3oEW1yL1qAUD3K5F5DfYsc48aDu1R45HmAQ0OprCNYq18Zswfzh9gC4To4+bPeSCcKejkJ/n7NtyjxIh8qokOM2Ti8EWhR2sSuDQvJ2s9Z3ZGqZyB8DpSPuQlabalqv7AKTVrsDvOcpdk2oK+uOiiUfCVWUu/8sGTm43N2YUQJbBNbNXYt2TLRovcERzWZuSqcDp4Ba/3ycPAd93c0T9id4poQ/AlilU06/7y1q0lH0MlN1Z4fhYVVy8aQz8hHEsqKj+BJTa10vYu5e4nDIsYeA8ppPCdehTM9rbsFmXGy4jFTOWFVNnzY9l2TBb6b6L6qbSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLZQtUj7zJPJqjJAv50hgtbXrLAFNdp4hq+WIlJrFts=;
 b=nfsHA9deiSGvc/tbyjr+I2ZmUBMbwA6kXsG3dDqTBVZmGd9gvKYY8lBAseBJ1NmGfkYIuKqaqEtK6SSnxrEf5rUbk8+pn1aKa6ikAnpgQdJxQWNRFYZ4YWmUnWYE5QC8FHMhQZ9fYSZ0WBfP9yI6oIIiVifi3ADsmA+HGlgjCejKdtIae7PY6UWAtVSrYdEQPLtAQf08MJJWFBaDA4DWO0zln37VZwUpwhtNAXrve9KaFvfH9nNcwkW+JMq5W1gVrSEq4pzbaLTWdJZJIP/dujOiJM3A85pFghMd3VVJ9h1h/7pselEU8pgizZ6pXU+Nc4uNj+o/UTUP2t/TEXqOiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB10779.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 20:11:17 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9611.013; Fri, 13 Feb 2026
 20:11:17 +0000
Message-ID: <9592e7ac-2ff5-4fc4-94cc-ee3de89fa541@efficios.com>
Date: Fri, 13 Feb 2026 15:11:16 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev <lttng-dev@lists.lttng.org>
Cc: Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>, lwn@lwn.net,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1JFTEVBU0VdIExUVG5nIDIuMTUuMCAtIFDDqWNow6kgTW9ydGVsIC0g?=
 =?UTF-8?Q?Linux_kernel_and_userspace_tracer?=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::12) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB10779:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f3268c-ce72-4afa-b1da-08de6b3c0bf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXpnNGtpcjhPb0xscm5lK1hvS3c2VThpZlo1bmVaRUkwU0Q5Wm5hYitxdXJT?=
 =?utf-8?B?bkhabTZTbG1KTDZZS1BuNVNKVFJObDhBRkJpcmhPditmS3hwdE4zYkRDQmNa?=
 =?utf-8?B?cEE1SWhRZjBvRERBQ1JhWTNQU1NFUldkaTQrYU1zUHduWmpIbGFmSHV3eVEw?=
 =?utf-8?B?RlUzT1pidjArN1NQOGVYalFrYjIvbDFQdU9qTUV3ejNlNXBaS3hVNzBOY04r?=
 =?utf-8?B?MnM0bkR1dzlKcVVvQmdMMmU4ZHA4K3Z0ZjhYbmFBek9udFVvYzlJU1R5cXJR?=
 =?utf-8?B?RmlpVTVTUHBaMllDK2VSdk5Ibkd0SDVtdCs4cCtIbnI4Z1M0UUdVeUFWUWY2?=
 =?utf-8?B?K3lmZzQxTndhRXhJQWVldnZxellEbkRGUCttYm5vN2lDeUs3ZkN2NDNQU0pQ?=
 =?utf-8?B?OU5xbHNNbXZ0WDFzZkhzY3k0WVo5V3VvamF2U08zYW5QYnJvTVlyOE9VdWlV?=
 =?utf-8?B?VTczZStDVW1OYjFxam9yREZISWZkY0xVN2k2Ylk1K3FjeWRmZVo3K0xhMm5K?=
 =?utf-8?B?L2FheHljSDJaSVR4alRJaDV3UDJTeUxFcy92a2lhQmFQY3hEeGJLNHZXdHp3?=
 =?utf-8?B?OElvbW11ZHlKM3dYSVlVamV5bHNSaWcyYkgvejZCaUZzS3Q2ZkxTdTlteGtv?=
 =?utf-8?B?T3poWmNzb1pNZVRzemY1amsvOHJRdEZqT2R6NFVHNVF3UnBPWVB0UFZtOWRT?=
 =?utf-8?B?dmZ5d3ozTGFDVmRqR2RIN2ZEdURFWk8yTDJydGFiRWVpT1VXVncyOXJvNzJF?=
 =?utf-8?B?QnhqeGRJYlFVVlhJRU11Wm1PNGorSXpLcXE3YnExZDVUV1JkK0REeEw1dGdH?=
 =?utf-8?B?bUNxSm0zdWt6SWt6c2ZsTnNXMDU1d2FGeXBndnVXVXNYOHMza0dLVEdWTUsx?=
 =?utf-8?B?VW9hZEFCZE9iOWVYcmYvWmQ5YmV4Q0NjSW43N0pQNXNkZWkyZzVkbFQ5allV?=
 =?utf-8?B?OHpBSFRxSHVYeGtocjNWUzVpZmN4RTQyVmRsMWNnNXEzVi95eVhpbWN2eE9S?=
 =?utf-8?B?SkNOY01kQTQyL2VrdHE3RndueGdIZldrUGNVdlUrTFQ2WkZRbFU2ZG5lN1ND?=
 =?utf-8?B?d2JIYWZnL2JkeE5lbVc0UWkrYVNLR3J4VTl6alNBQy9lc1E1WmVQM29qVjgy?=
 =?utf-8?B?RUVESTJ0TCs1RWFPSGorTmwrc3ZiMlNiUHJHM1N4b1RqcFI3WjY4bVlocFdr?=
 =?utf-8?B?Y3dIV3FKQXh5d1NxaTNHSm5nOEw3Qkx5YUhlZ2JqN3A5VktzbVBuNHJFcDc4?=
 =?utf-8?B?UWhNdzJneUVEV2taK084RHZ5d3RCU2dTVVBsZ2dUTkNGZTRwOEFxRko4dnp6?=
 =?utf-8?B?QkRteU5pN1JuS3JsRlkxcjgwWjlwS1RoWUg4Tnh5eE1aY3FZa2tSZ2E0UnF4?=
 =?utf-8?B?Wkt0WjZVSk42Q3FmUHpJMXBnbWlGcmp4UDdyQ2g5K1VyT0tSYWJKc0VabFBN?=
 =?utf-8?B?cDQ5RVhwb3N4Ni9SclpFbXM0TXBGOUhiRDM3RURSMXJQdFFORFpoMmdDR1Y0?=
 =?utf-8?B?VnkzZW5MMTRjSEtSVE8xWXhJYUtRNVlLZDZQV0hDU0Q4RWZPdWpaUzhGdngy?=
 =?utf-8?B?WTdLZzIrT2MzdU9IRFgzVUJ6a290VWpDS05nSUhib0pQL0k2VDFMN0FCNEtw?=
 =?utf-8?B?QmFDVzR6Yi9JNjRPVG5abXVNaEtGcWo1OXNvUGpsV0RzTjBTVVp0ZTJqbzdT?=
 =?utf-8?B?a3BHNzNtWnVYak11dno2cXp2WFBZUzJHZnVYWXdKUjRtVUJWK3NIRGFSMWlu?=
 =?utf-8?B?bUFRVTZBcm52QkhLMWtqd0p5SHI0THRkM0NIKzRFOTQ2SHk5elhINURtaTZm?=
 =?utf-8?B?bmVmR1VkMU1FVHEyc3NoeE5vYTdmbkRiV056djFGWGcvNS9mUUl0RnBDSHo4?=
 =?utf-8?B?dHRQM1V4N2kxN3FzYXFVNytuUkMwUFZ3R210WnR6RjBXVG1OS2hLVDVwY2Q0?=
 =?utf-8?B?c25RL1hXc2c5eFpJTGJvTGhJRkRtUXZBQS8yK3RnTTM1RTdPbTM1UHdhL1JP?=
 =?utf-8?B?a2h2WSszYnBINjBEa0JsZ21Sd0FJd0Qwa1h4cktKTHpTT0FzM05zdHpBNzN3?=
 =?utf-8?Q?1xlhKm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0loNXlidXlZdVJ4WEpjY0V4ZzROeEtNNmkrVU82R0FITk44aFN6QnVVZGtz?=
 =?utf-8?B?ZXR0cDRrR1lYYVhLbUdRYmhUNEp4VE1PWmlvRUtTYmplVzZzYkZvQk5WVGh3?=
 =?utf-8?B?QklXY041U09rZUtTa1hnOXBFWmZTOGh0VDVKT2FFd0VjbEsrUHl4c3ZTeTh6?=
 =?utf-8?B?TC82d0hKcVlpUER0ZTFGbnVCSk96cVo3ZHI3TTRpYnAzbkRyZ2p1S0QrSjYv?=
 =?utf-8?B?MzhVdUxUMXNSZVl6OGkyR3BLV0NqeWcwMTJhdjJZLzBnNXR3UUNyN2FKaktk?=
 =?utf-8?B?ZE9ReE43d2JhcG9oNUQrY3RBeDR1OEdFWGhUN1E1Z1oweWpraFl1QzVLbnox?=
 =?utf-8?B?R3JsUTVycUIwYjZ5TjNuT2xhWGR5LzUrdVovUHJCOE1vWmwxMXJMbUtIeGNG?=
 =?utf-8?B?VTBydGJ1WDcrYjd4UFR4MHluZTl6TFdOUFdZeHdWWXhnMmE3NXVMVEtxWXFn?=
 =?utf-8?B?YXhLelRDYkQrY1JyTGFqTzNvU3B3ZGg2aWU2QUR2M0QrQWpEOXI4UUxISUV0?=
 =?utf-8?B?cEdkNGo0UzhnZVFLUXRudlZobU1YbHFDL01UNmRMYUxteG9HT0ZoN1c1R0x3?=
 =?utf-8?B?NVVwd25xNWNteS83aXhvbG8rbFNhdHV2NzNFa1lUaUZDWVRCZmlrcUFJZHJk?=
 =?utf-8?B?cU8rb1VlekhmSEhNNmJ2a2kwOTdYanFEWTNFQWNiT2t2S0lqcStOUzNQRzhr?=
 =?utf-8?B?T2dacDVEUlc2alZCYVk4U3E4MlZRL0JjaityaUovMVR2d1lBQ0Jac21RK0pW?=
 =?utf-8?B?TXNaQWNiQWN0aFRoa3hyZHE1THNFeEhvTnk4bWcvNCtXL0JrWjh5ZEN5UWw3?=
 =?utf-8?B?V2p3aHZEWG1PTEhPREowamdmMEtMZ3pVMEtmUzkwOTlGbThRbjdRTld4dmp2?=
 =?utf-8?B?YS9hUXNacmQzM1FOSnhNS0pxa3kvL0NWTkhzaVRicFNCayttek02YWFoTjBN?=
 =?utf-8?B?ZU1rZjZOT2pMZ3c1WXlINk1TeWdtdTRMSzJtT1hUYzBBMWNmYTVLUUFRTHE1?=
 =?utf-8?B?ZkVENk1IS01XSm1UbEltbzNXNFNCMVkvcFZNVGpjc0JPLzREZjJmdTdIQ3lk?=
 =?utf-8?B?em1tVGlKVzBpTEJkUkMxL2xMSENkdkhQRThIaVU0ME5CMWU2MUQyT25YdWZn?=
 =?utf-8?B?bkhoaFJtMDVKbFJ1YmNWZXhWaEo5VlY5b09xZzlSUkx0bVhJV1ZXZUVSRWty?=
 =?utf-8?B?T1ZSbWNicy9mMXBpZmhMaVpzTmgrWEhLU2R4cU1qM1BMRVVoQWVadjQzUitE?=
 =?utf-8?B?UE5ZbWFqMkpLS1pTK0xSU2J5dlM0RHRrT1RiZXFGT21nWXJ2MEZYNnd1RGhX?=
 =?utf-8?B?SENmdkpZbUtsNXdvZWRQMVN5QVFWWm16anYrNm42NUpjMm5Ib3FiRkp5cmd2?=
 =?utf-8?B?Ni9DRURidytvZVVFUWUrTU9iR1hoemNLbnk5U3B1a2FWWjFBSnMyMXNQRGdy?=
 =?utf-8?B?QVRkd2kydTVhR0lxN0hyQXd4TnhBSzYzV2FkZXhqMmpBMlRUTE1iTDBYZnNi?=
 =?utf-8?B?Y1N0RHdBMnFOVlBBbmlzSmlmdmZmWmFrMVJ1QnJhZXJmSlErR0RHSFhyRkdQ?=
 =?utf-8?B?enlPVFFMYm5iMXIybzRkeVFHemF3L25oSGxXLytDZmgwRXBHdjR4bjRhUmU2?=
 =?utf-8?B?ajd6d3RmYVVycDlDVk9WR1dpcWFQUDRBalRNaXJ1V09EejBSSWFjU0xXZWV0?=
 =?utf-8?B?bUhrL0RRemcrTlMvam1uaWhDeVhCaVFaZmlGSUtKVnliWU1UNGZJTkNvZE01?=
 =?utf-8?B?WHo2YkZnanoyc05ESmdGL2FGaFRZMFhqcW9TLzlNbk1JVTh1MGNObkNTRmpl?=
 =?utf-8?B?VGYvUzJRazBzRGJYdVRtc2x2UzFIUTJpVHNkLy9qVStQNjFkREN5UEdPcHM0?=
 =?utf-8?B?QmUrcHd0NlJacWk4VUdQQmR0b1hrYUx5blFPMUQ4UXh5RG1FSGljV09IVWFR?=
 =?utf-8?B?OS9pMjBEQ2VkWmVrQ2RKNXZJaEYrSTgrMkJhNS9hcHp4ZTcxcy9OeFMzdVlP?=
 =?utf-8?B?RWZVOXZsdnZIQWphc3plZ3BNR0hVVnh0MDFiRkFRVVg3aW5laXlOQkxTdGI1?=
 =?utf-8?B?UWUxZlBmRlY5REh0VkR4dW9Bd2lHZDVMZVV0OUR6ZlQ3T29hVlFEM1U1RGVa?=
 =?utf-8?B?dXdIQUZ3aVJHZ0Fscjd2OEs5TFp2MlNoUVg0NmxaWXRTaEhabGFvZzRaV3Nz?=
 =?utf-8?B?b05ENitmbnNhdE5KdUhvWnU2N3BzSTllcFVidVgrOWM2MWpXZXZLUDh2WXNy?=
 =?utf-8?B?NXZ1WU5YQUpDU1ZhaVBBRVdJa3VWbTB0VDFuRWpHTHYwS2dCOFA3OTB3aEcx?=
 =?utf-8?B?OXQxZm1sRDFzM2hLOWV5OWRUZitCTkJVK2Z0OFBTTVRBTGV4UFhqbGtNejJG?=
 =?utf-8?Q?B2/3gnf7OoSKqGaLIfOU86Rd8a5Hg4iRK+U5X?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f3268c-ce72-4afa-b1da-08de6b3c0bf7
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 20:11:17.8125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ZFtLQ+bt3GAcRVR/HXE2rk+M++3s7lK6ESruRPltCahmwOfAkRxSxUIN8BHqHcDsN5uzCv+YkDJ8gJnBKCAJIb7H4PiFYCIpvblfPLd/1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10779
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

Hi everyone,

We're excited to announce the availability of LTTng 2.15, codenamed
“Péché Mortel”!

Only a few months after LTTng 2.14, this release delivers an impressive
number of features considering the short time frame, in particular:

• CTF 2 (Common Trace Format) as the default trace format.
• Reduced memory footprint for user space tracing.
• Improved resiliency of shared LTTng-UST buffers.
• Redesigned lttng-list(1) command with memory usage reporting.
• Extended automation capabilities for the lttng-add-trigger(1) command.

Read on for the details.

WHAT'S NEW IN LTTng 2.15?
━━━━━━━━━━━━━━━━━━━━━━━━━
New features and changes in LTTng 2.15:

• Choose the trace format for each recording session with the new
   `--trace-format` option of the lttng-create(1) command:

       $ lttng create my-session --trace-format=ctf-1.8

   Select between CTF 1.8 [1] and CTF 2 [2].

   CTF 2 now is the default trace format for all newly created recording
   sessions. Babeltrace 2 [3] supports CTF 2 since version 2.1 (January
   2025). To keep the default set to CTF 1.8 for your application, use
   the new `--default-trace-format` option of lttng-sessiond(8).

   The LTTng project adopts CTF 2 because it has many benefits over
   CTF 1.8:

   Easier decoding:
       CTF 1.8 requires parsing TSDL metadata, a CTF-specific language,
       which increases implementation time and limits tool integration.

       CTF 2 replaces this with JSON Text Sequences, readable by standard
       JSON parsers, significantly reducing new decoding code.

   Cleaner trace streaming:
       CTF 1.8 allows partial metadata items, forcing parsers to detect
       item boundaries manually, increasing complexity and bugs.

       CTF 2 separates metadata fragments with an RS byte, enabling
       simple chunk identification without decoding.

   Better trace readability (not in LTTng yet):
       CTF 1.8 lacks semantic annotations, so readers rely on external
       domain knowledge to interpret event record data.

       CTF 2 introduces user-defined attributes to describe semantics,
       enabling automated analysis (recognizing IP addresses,
       for example).

   Broader type support (not in LTTng yet):
       CTF 2 adds native field classes that can improve readability,
       performance, and trace size, unlike CTF 1.8's more limited types.

       Examples include a BLOB type for binary data, richer string
       encodings, bit maps, optionals, and LEB128 integers.

   This per-recording session configuration replaces the mechanism
   introduced in LTTng 2.14 where setting the
   `LTTNG_EXPERIMENTAL_FORCE_CTF_2` environment variable to `1` at
   `lttng-sessiond` startup forced _all_ recording sessions to produce
   CTF 2 traces.

• A new channel memory reclaim operation, exclusively available for user
   space channels, can free memory used by eligible sub-buffers by
   deallocating their backing memory when no longer needed.

   The two ways to reclaim memory are:

   Automatic reclaim:
       Configure a per-channel, automatic reclaim policy which
       periodically tries to reclaim memory for sub-buffers older than a
       given age, or as soon as they're consumed, with the new
       `--auto-reclaim-memory` option of the
       lttng-enable-channel(1) command.

       This new option is only available in discard mode (without the
       `--overwrite` option).

   Immediate reclaim:
       The new lttng-reclaim-memory(1) command reclaims memory
       immediately for eligible sub-buffers of one or more channels.

       Only reclaim the sub-buffers older than a given age with the
       `--older-than` option:

           $ lttng reclaim-memory --older-than=2m

   Both memory reclaim modes are possible because channel ring buffers
   are now backed by sparse files [4] when the file system supports them.

• Choose the buffer _preallocation_ policy of a user space channel with
   the new `--buffer-preallocation` option of the
   lttng-enable-channel(1) command:

       $ lttng enable-channel my-channel --userspace \
                                         --buffer-preallocation=on-demand

   LTTng can either preallocate all ring buffer memory up front (pre-2.15
   behaviour; still the default) or allocate as needed. Choose
   preallocation to ensure predictable memory usage and avoid run-time
   allocation latency; choose on demand to minimize the initial footprint
   for low traffic, for short-lived recording sessions, or in conjunction
   with memory reclaims.

   This feature is also enabled by sparse file-backed ring buffers.

• Before this release, an application terminated while writing to a user
   space ring-buffer could leave a sub-buffer stuck in a
   partially-written state, making it unusable.

   A new health check mechanism, the _watchdog timer_, now periodically
   monitors user space ring-buffers and makes stalled sub-buffers
   consumable again to keep trace recording running smoothly.

   This mechanism is enabled by default and can be controlled with the
   new `--watchdog-timer` option of the lttng-enable-channel(1) command.
   As of LTTng 2.15, it only applies to user space channels with a
   per-user buffer ownership model.

• We completely revamped the human-readable output of the
   lttng-list(1) command.

   The command now has a clean tree structure. Colors help improve the
   readability of objects and properties when the connected terminal
   supports it: the `LTTNG_TERM_COLOR` and `NO_COLOR` [5] environment
   variables provide further terminal color control.

       ✔ Channel `channel0` ❬42 event rules❭
         🞂 Auto. memory reclaim policy: None
         🞂 Loss mode:                   Discard newest event record
         🞂 Preallocation policy:        On demand
         🞂 Ring buffer configuration:   4 sub-buffers of 512.00 KiB per CPU,
                                        per Unix user

         🞂 Timer periods:
           🞂 Monitor timer:  1.00 s
           🞂 Read timer:     Inactive
           🞂 Switch timer:   Inactive
           🞂 Watchdog timer: 2.00 s

         🞂 Statistics:
           🞂 Discarded event records: 23,182

   By default, the command:

   ‣ Adds empty lines between blocks of related information. Remove those
     empty lines with the new `compact` setting of the new
     `--style` option.

   ‣ Truncates lines, adding an ellipsis, to fit the current terminal
     width. Avoid truncation with the new `--no-truncate` option.

   If you still prefer or need the previous (“legacy”) version, set the
   `LTTNG_LIST_LEGACY` environment variable to `1` before you run
   lttng-list(1). Please note, however, that the legacy output will never
   show anything related to features introduced after LTTng 2.14.

• The lttng-list(1) command now shows the total memory usage of
   each channel:

       🞂 Memory usage: ❲●●●●●●●●●●●●┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄❳   19.07 MiB /   40.12 MiB

   The new `--mem-usage` option controls the display mode of memory
   usage: `compact` shows the memory usage for each Unix user or process
   while `full` shows the memory usage for each CPU (if available):

       🞂 Memory usage: ❲●●●●●●●●┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄❳   13.30 MiB /   40.12 MiB
         ┆ For UID 1000 (64-bit): ❲●●●●●┄┄┄┄┄┄┄┄┄┄┄❳   13.30 MiB /   40.12 MiB
         ┆   CPU   0: ❲●●●●●┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄❳  540.00 KiB /    2.51 MiB
         ┆   CPU   1: ❲●●●┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄❳  360.00 KiB /    2.51 MiB
         ┆   CPU   2: ❲●●●●●●●●●●●●●●┄┄┄┄┄┄┄┄┄┄┄┄┄┄❳    1.30 MiB /    2.51 MiB
         ┆   CPU   3: ❲●●┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄❳  256.00 KiB /    2.51 MiB
         ┆   CPU   4: ❲●●●●●●●●●●●●●┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄❳    1.20 MiB /    2.51 MiB
         ┆   CPU   5: ❲●●●●●●●●●●●┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄❳    1.07 MiB /    2.51 MiB
         ┆   CPU   6: ❲●●●●●●●●┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄❳  768.00 KiB /    2.51 MiB
         ┆   CPU   7: ❲●●●●●┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄❳  524.00 KiB /    2.51 MiB
         ┆   CPU   8: ❲●●●●●●●●┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄❳  792.00 KiB /    2.51 MiB

• The lttng-status(1) command now accepts the same options
   as lttng-list(1):

       $ lttng status --mem-usage=compact --channel=my-channel

   lttng-status(1) forwards its options as is to lttng-list(1) for the
   current recording session.

• The lttng(1) commands won't emit multi-byte UTF-8 sequences when the
   `LTTNG_NO_UTF_8` environment variable is set to `1`, making a best
   effort to find alternatives.

• New trigger conditions are now available for the
   lttng-add-trigger(1) command:

   `channel-buffer-usage-ge` and `channel-buffer-usage-le`:
       Satisfied when the buffer usage of a given channel becomes
       greater/less than or equal to some threshold (size in bytes or
       ratio of the total channel buffer size):

           $ lttng add-trigger --condition=channel-buffer-usage-ge \
                               --session=my-session --channel=my-channel \
                               --domain=kernel --threshold-ratio=0.75 \
                               --action=notify

   `session-consumed-size-ge`:
       Satisfied when the total consumed size of the tracing data of all
       the channels of a recording session becomes greater than or equal
       to a threshold:

           $ lttng add-trigger --condition=session-consumed-size-ge \
                               --session=my-session --threshold-size=100M \
                               --action=snapshot-session other-session

   `session-rotation-starts`:
   `session-rotation-finishes`:
       Satisfied when the rotation operation of a recording session
       starts or finishes:

           $ lttng add-trigger --condition=session-rotation-finishes \
                               --session=my-session --action=notify

• The `liblttng-ctl` C API is updated to support the new features above:

   ‣ Set the trace format of a recording session descriptor with
     lttng_session_descriptor_set_trace_format() before creating the
     recording session.

   ‣ Immediately reclaim user space channel memory for eligible
     sub-buffers with lttng_reclaim_channel_memory().

     Get the results with lttng_reclaim_handle_get_reclaimed_subbuffer_count()
     and lttng_reclaim_handle_get_pending_subbuffer_count().

     Optionally wait for pending sub-buffers to be reclaimed with
     lttng_reclaim_handle_wait_for_completion().

     When done, destroy the memory reclaim operation handle
     with lttng_reclaim_handle_destroy().

   ‣ Set and get the automatic memory reclamation policy of a user space
     channel with lttng_channel_set_automatic_memory_reclamation_policy()
     and lttng_channel_get_automatic_memory_reclamation_policy().

   ‣ Set and get the buffer preallocation policy of a user space channel
     with lttng_channel_set_preallocation_policy()
     and lttng_channel_get_preallocation_policy().

   ‣ Set and get the watchdog timer period of a channel with
     lttng_channel_set_watchdog_timer_interval()
     and lttng_channel_get_watchdog_timer_interval().

   ‣ Enumerate and query the CPU ID and memory usage of the data streams
     of a channel with the data stream info API:

     ⁃ lttng_channel_get_data_stream_info_sets()
     ⁃ lttng_data_stream_info_sets_get_count()
     ⁃ lttng_data_stream_info_sets_get_at_index()
     ⁃ lttng_data_stream_info_set_get_count()
     ⁃ lttng_data_stream_info_set_get_uid()
     ⁃ lttng_data_stream_info_set_get_pid()
     ⁃ lttng_data_stream_info_set_get_app_bitness()
     ⁃ lttng_data_stream_info_set_get_at_index()
     ⁃ lttng_data_stream_info_get_cpu_id()
     ⁃ lttng_data_stream_info_get_memory_usage()
     ⁃ lttng_data_stream_info_sets_destroy()

• The session daemon and relay daemon now support systemd's sd_notify()
   protocol, enabling proper synchronization with dependent systemd units
   by signaling when the daemons are ready to receive commands and when
   they're stopping.

• The internal v2.15 communication protocol between LTTng-tools and
   LTTng-UST is incompatible with the LTTng 2.14 one: you cannot use
   LTTng-tools 2.15 with LTTng-UST 2.14 and vice versa, for example.

• The lttng(1) Zsh completion function now fully completes the
   `add-trigger` command.

   From now on, the Debian/Ubuntu packages of LTTng-tools will contain
   the Zsh completion functions.

VERSION NAME
━━━━━━━━━━━━
This release is named after Péché Mortel, the iconic Imperial Stout from
Montréal's Dieu du Ciel! and a long-time team favorite.

Deep black and unapologetically intense, Péché Mortel pours with a
dense, mocha-tinted head and an aroma that immediately announces freshly
roasted coffee. Decadent and dangerously drinkable, it is the ideal
companion for long, cold winter evenings.

CHANGES SINCE 2.15.0-rc1
━━━━━━━━━━━━━━━━━━━━━━━━
Notable bug fixes since the release candidate:

• Fixed a hang of the user space consumer daemon's flush operation on
   stalled channels when the watchdog timer is disabled. When a channel
   was configured without a watchdog timer, a flush could hang
   indefinitely on stalled streams since no mechanism would recover
   stalled sub-buffers. The watchdog timer is now dynamically enabled
   when this situation is detected.

• Fixed metadata corruption when combining the metadata regeneration and
   trace rotation commands, especially visible when recording to slow
   block devices. A race condition between the metadata cache consumption
   mechanism and rotation could lead to truncated or mixed-version
   metadata in trace archives. The consumer daemon now tracks metadata
   coherency and defers rotation until a coherent state is reached.

• Fixed a race condition in the session daemon where a concurrent
   metadata transmission and a metadata regeneration command could corrupt
   the sent metadata count, resulting in a metadata file containing
   mostly zeroes.

• Fixed unreadable CTF 1.8 traces when tracepoint event fields have
   empty identifiers. This is a regression from LTTng 2.14 where a
   strict identifier length check was introduced.

IMPORTANT LINKS
━━━━━━━━━━━━━━━
LTTng tarball:
     • <https://lttng.org/files/lttng-tools/lttng-tools-2.15.0.tar.bz2>
     • <https://lttng.org/files/lttng-ust/lttng-ust-2.15.0.tar.bz2>
     • <https://lttng.org/files/lttng-modules/lttng-modules-2.15.0.tar.bz2>

LTTng website:
     <https://lttng.org/>

LTTng 2.15 documentation:
     <https://lttng.org/docs/v2.15>

Mailing list for support and development:
     <https://lists.lttng.org/>

IRC channel:
     `#lttng` on `irc.oftc.net`

Bug tracker:
     <https://bugs.lttng.org/projects/lttng/>

GitHub organization:
     <https://github.com/lttng>

Continuous integration:
     • <https://ci.lttng.org/view/LTTng-tools/>
     • <https://ci.lttng.org/view/LTTng-ust/>
     • <https://ci.lttng.org/view/LTTng-modules/>

Code review:
     • <https://review.lttng.org/q/project:lttng-tools>
     • <https://review.lttng.org/q/project:lttng-ust>
     • <https://review.lttng.org/q/project:lttng-modules>

REFERENCES
━━━━━━━━━━
[1]: https://diamon.org/ctf/v1.8.3/ (CTF v1.8.3 specification)
[2]: https://diamon.org/ctf/ (CTF 2 specification)
[3]: https://babeltrace.org/
[4]: https://en.wikipedia.org/wiki/Sparse_file
[5]: https://no-color.org/

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

