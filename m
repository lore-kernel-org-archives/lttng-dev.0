Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6EFC5AD49
	for <lttng-dev@archiver.kernel.org>; Fri, 30 May 2025 14:49:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4b85jh4xZzz26lR
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1748616568;
	b=FvZWrusiMUFwTDvqGtkL5zC1jAjK+IKLO37F/u2+3WmVxBWHnvzCliEHDLAYPO8V0vCe
	 cMe7BiyUvycRDRAQu8uYNMGN0XAdhOtjSJZNeq91yZEXBPrCr4jEKsOfYmM9jTEF1YLSF
	 wf/CzO6vmilRTwephnDr/PNEo/uX6wni7Xtb1ESECQQyrRFnOQYDsNSCB3SwuisStdKtU
	 ALRkwlJykKNRgzg38DR1wjPNGOJV3q1tZjoadK4u08JgO0qseGBJ+YQ/QuaAD/XHj5pMH
	 5V/VDvrfIKj6cSV1Nq1juKwB4aCIDAoLnuNiMYvWcQvT+Om0lvkt2Ihh5mhPG+NN4BA==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1748616568;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=M8Zzoxc2/8AdYQWCixsaN8xiQTZljPYNq6IGWV6KpWE=;
	b=EIAjg48OiSHlf9fLMbnSxqHxx3MCxll5q0UBtTk7yZwPzrBgwe0G8JVnUrUyvLjExBRk
	 cCuJ/v6lQ+S1tk8d7VQSU0fuee3GQauDO/uYXVgbiKNq76SnQsRVWyta2g7j5psps/Hym
	 nPAz7IuLCS3vUzBVtSXRtwgXKvfJK+IJDMfjkZJFj+8Cxn0TgEfC+gy6pc0FSWX2CAvzM
	 H4yIURTwBQHBXaLchxmbpqxlUHs0I92a5ZePwgglbvbQxitPRe+1UunZmM9zUMsy1fqD1
	 hmtc7eYemwvokJirn50pDS/FNYeYvz9+6b+9kEIvISqvQ9OfSE+n+gEojkqddSITDGg==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4b85jh4xZzz26lR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1748616568;
	bh=M8Zzoxc2/8AdYQWCixsaN8xiQTZljPYNq6IGWV6KpWE=;
	h=Date:Subject:To:References:Cc:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Fti2VU+gKyB9IdBDvCrNqo4BB0oEZePnnK7rFSinHoKIBIeZKgK8QZIOYwypAxXS1
	 1EfV7OakQ4Z2oNozspd5/M6/8DGXpQ6o5TWjp2vIRt8wxJwOQwGCFQLHgCWn+dP+oz
	 HgFJwj3B1Okd1B3TEhWau04hZPXg7G4X8dzzMAL67OiwIZ2EcBuhSgjjQ88fV6bQXW
	 2syBCyqQh7dwF9AZlRYekS4ENqdR+h4cisgHuRfvMzshnmOounqkXu/w/ic2RmjA8z
	 luRz2re9Qx34K9qq/atka7dFQKoEkjL5AB7HvdrsZBDDx/7jWtXpuByM0Rc8S3os39
	 TTHzoJcKApB9w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4b85jh4xZzz26lR;
	Fri, 30 May 2025 10:49:28 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4b85jf6PC5z26lP
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4b85jf6PC5z26lP
Received: from YT6PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazon11022086.outbound.protection.outlook.com
 [40.107.193.86])
 by lists.lttng.org (Postfix) with ESMTPS id 4b85jf6PC5z26lP
 for <lttng-dev@lists.lttng.org>; Fri, 30 May 2025 10:49:26 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SF3RDFbx1rQngKTJPoVtIKKAn/Z35NW4QVbFi4yNDAvt+947pGVJCtUfmpYJp1CFGiiQIgaKyYSpuwkT8wF7i9Ul5z44vJ5TBTt8VACQfGRH7LvOo6tFpgyC8f7dALjGE6GrGi+ktCX/M6qITH2NcGrCEKrrsfuxUQkFb2FiuFXMLdWnswhqLbt1T2Ra5B7YlXpTn+YsngfEJ3G3emxtvBhSsvDiLvCtbwo2kIrAOfHeTUK0l2UXlpbJuEX+mnOYaarmMQHl+vXkgZuiDmJXTpeuWsdVgL0FSboCfBXeoPiMbqkA8KtPmnIUENPocsKWn5cpmmlPO2nWHHXVxtMmvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFWRiq0HxeqL8HgXoQseuuUaFrEZKTT3adHvlF0MieQ=;
 b=RjDUCzLJl/kCf5y5hKPv5VOcjEmx17NbbG0BeDxwnpizHAvtUtE23F4a8R+Z5kO3Dv9ZISbQ79TyB/uNjC5rgIxVzZuThuUAZSuUMWn4NcgiLtPIHGDqf3SeFZNAhQRO+3tlhVQOtuUGNsbjHL1cvPFCyUpAw8ip1/g4iptvhQfw0jBE1gOHXzt6oRnRROo9m81rV/2eSch6OggH08S7EldCs4FNoj+ytDDLENB4GuYTS8ptbE+8ke8dk2wB7pxgGAxua5jBmavcpsNa6HcT2kLlgx+12V14VHm0ioAf7juBlo1F4aggLcErd3N+0XEUwYWVVCoYIjOwXFrIQxMHRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PR01MB9291.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Fri, 30 May
 2025 14:49:21 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 14:49:21 +0000
Message-ID: <93e83ed5-bcf3-4a5e-b713-4f9612ff7a6d@efficios.com>
Date: Fri, 30 May 2025 10:49:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: A question regarding isolated cpus and software interrupts
To: David Aldrich <david.aldrich.ntml@gmail.com>, lttng-dev@lists.lttng.org
References: <CAJK_iej1UnwTBaJCY0WwP2g=zqEMtphgM2DUJhtKmHxNceD3yw@mail.gmail.com>
Content-Language: en-US
Cc: Frederic Weisbecker <frederic@kernel.org>
In-Reply-To: <CAJK_iej1UnwTBaJCY0WwP2g=zqEMtphgM2DUJhtKmHxNceD3yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0077.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::13) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PR01MB9291:EE_
X-MS-Office365-Filtering-Correlation-Id: 16180f4a-d158-4da2-bee7-08dd9f892984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFFHNWNHZnhQd3NYNFdSTTA0RThqL0pjaDk5VGRXMEwwRkErRG11Qm9RT3NU?=
 =?utf-8?B?VG11Z0Nwc0VGY1FFU3I3d3ZSSTBCY2ZmNHg2U3pRbW81OFAza2tTWTBGQitw?=
 =?utf-8?B?alF0TFdBT3FOTElUeTNOWnF5ZWkyUDd4QjJTRlpUdDR4WWYwV3RxUHVLUGo0?=
 =?utf-8?B?M2NrM1hueVArUE5NdWw0UjZwUW1XWS95OTRLQXlmcW5NekE0dWQxWnppVTRh?=
 =?utf-8?B?TldRSUdLWTZjSHg0K095WjRKRTB0ZjU1bTVxZk53VlY5ZnViV00wUmtLd25M?=
 =?utf-8?B?eEpTcU80U1JXOFUvMnVzNzNpZDJRSGs1Qkw1K1haVUJFWjh0RHJ4eWdxMWp3?=
 =?utf-8?B?eDdlTkMxYWptYTJvZ2lzcWRqeDJEamNja29SZDcyQmhyc013TEZ1S29FN3Ba?=
 =?utf-8?B?cG9ESnloTGZQc3FVQmY4Ykl4WXh6eXNRR2xDT29wR3ZlTXBRcHZqaUJYbXJH?=
 =?utf-8?B?UFJ4RkpDV1VlenhlaXVmU1JEbDc4c1lWbHgyWFMvMjZPd202dnhCbmJLUlJt?=
 =?utf-8?B?SDEyd2VabVBkbERlM0c3YjRseVk0cUo2cnNaUWlUOSt0SDhOT3B3bXNldzJG?=
 =?utf-8?B?YTVRZ1p4d0NwbVhyM1k1NTMvc3p6cDhCVnU1T1JsU21ZSW5yYlZkNGxxTE8x?=
 =?utf-8?B?NmZITlYxL3FwSllJemhQTjAyRitoZ3VrYWRqTUZzRDFUZEl5cnQ0d0dDNUhH?=
 =?utf-8?B?cmpBUXh4NXJxWlR2bGdBOUtXUEE0YVhLUHFPaDdjRDhQREpxaXdFYzFMdHdZ?=
 =?utf-8?B?U0VlMm5zNE1tUTZPQ0JtVGdIRkM5a2gxUnZlR2lGZmFqNGRQVWxtWEIwbmFI?=
 =?utf-8?B?Y2NSQU5pTFVZcDBLUDErMWxCUnZhb05RbllUK0xkMWsrbFU4TGovWjVZbTFC?=
 =?utf-8?B?WEV4Qy9HZ0lRR2dGK3V1U2hXTnVFWUFGdnpJYUw5OW9RckhVZFB1WXdrQS85?=
 =?utf-8?B?SlBtbm5DQ0pTVUs4citkUGZJcFVZcE8xWEJ0eUl2b29ZNWt2Z3ZZVFBDRzc2?=
 =?utf-8?B?TG1PRFlqWGFDVk80YUMzQVhnKzg1ZHZGTzQzRkdncGpJYmp3RDF2NnV6MENm?=
 =?utf-8?B?QjNVTDJ0NDB1TGZpOGQvTXJjWjVKajZ0b0lqcEdja1JkVWx6QkZTQ2E3ampQ?=
 =?utf-8?B?SnZWUzNwMVRJdE45RHVqZDFuQnVLOVgrR0N3SUtLMHl1VmlLekdLQlBNVjhr?=
 =?utf-8?B?d1g0dm56anUzUjJ3dnBIdTNneGlYTGMzdE9KaFFwWGsyd0Q0VTlqeFcxNU1r?=
 =?utf-8?B?ckxqemI3M2lMQ0Q1ZjJtVE1GY3Fya213L1ZtaVpORUs1M2RzclhMT3E2RHFj?=
 =?utf-8?B?dGtXVUhsQ1lERXRMVldlamx1eTJ6ZTBEZDZOcWNsZDVuYnVoeXUwckJiUG1Q?=
 =?utf-8?B?QWVjS1J3NUdQbVJLWXUwQ2NwOEVMSTlTaThEd2JhLzNRcHhoWlFkZE85bzZk?=
 =?utf-8?B?Y3RuZDF6Z2o1ei9DSjNmbHR1bnY0SkcvTkpHRi9mUmpFTFR3aXhTQ2tkWnNJ?=
 =?utf-8?B?elFSN2VKV05LblZadWZkRTdkU3JiaEV2MURHQlpWSWNKMG91YThFbmxnWVNr?=
 =?utf-8?B?WExFRnpHQUVTS0dKQnIyV3FCQkJFWEtBNklQZmU0TTFETTdndmtmZWgxS3Zt?=
 =?utf-8?B?U2xMQTFSWWJhSHRpRzRjemlJVUJEN28wWi9LZmcyV1FLSytRYUJ4eUk0T0dx?=
 =?utf-8?B?R0Y4NG1wVktXWnRWRVY1UzRGNHBOSWYwcnpFVzNHRWh3T1N2VG5xeSsrTjhL?=
 =?utf-8?B?cWpKOERVNDN5UHpla0dXMjZ6eGl6R096ZDVOZ3dCSW1nREwrZHRXUmxYTklK?=
 =?utf-8?Q?ghh9tz23Ailh28FQqe5kQX+suhwZCWPZedBys=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0ZpT3cwNG5jVHJGVFZ3Sm1YK1hoSGVuYzhMR1pST0sxTlFVT0FZZFMwenpS?=
 =?utf-8?B?N3Q0S2swMzJES1dPZUQwbEswNWRncnd1THQ3L1RaNlVDNUtRZEVTdlM0MnVJ?=
 =?utf-8?B?cm1tM2hCakVHakFEZ3BSL01UUUlJcWNzNlRHam4rV01pUW10dHo1ZDJ2SVNi?=
 =?utf-8?B?K3NYak81QUNPTnBJS1hFWE1WcXVobW5yOEEySkRKZVpyU1IxVnIwaC9Va3dq?=
 =?utf-8?B?Q3cwS2lRUE5zT2ZpZTdZVExHODhndEJCTi9ScnhMaGJEVTE4UmtTTHpZaWxo?=
 =?utf-8?B?Nzk4TE1sVURxS3VMQ1RnMytKUkR4Z0tnU0NKd1UwSXpLS2VyY0xTaUd6aEZT?=
 =?utf-8?B?VnR3ZkZaVDZvNVlwbThaczZvTGUrL2pSdVRXSkRjZW9QZHllV1IxdUg3TlQy?=
 =?utf-8?B?djB6K2t1USt5YldmQ2VJOVIzSjc3TklRNGM3c3FvMExMYTZZUHgwZm1rdmVJ?=
 =?utf-8?B?QUt5SmpiRGRKeEFiR1N4dmhabnRZVEZnWFE2WGVJK0VYNy9Lby9HaU80VUFo?=
 =?utf-8?B?M2ozK2pBcXFVaEdXOTJLZmRLY2lCaEFsVG9sQWZFVDJoaWhGakFjRS9vUVEr?=
 =?utf-8?B?cnQyVU9tT090MERiWEszTm5rRGdPRzBqcWJtVHRZaTY2eDJmUHJic1FHaXRY?=
 =?utf-8?B?WG9qSWh3cWFEN1lvQlFxVjV0SDdxU2xhVVVsUkgvRHNHakZJZXZ5dUV6VThV?=
 =?utf-8?B?NVBNdWJFYVJLM0sxd2JWdldUYUxOWDE5NUNjcm1qNWJTcUVGK1NxV2FsaHo5?=
 =?utf-8?B?T0ZYNHZZTk1NUUkrMWFqaXBEK0UrOGRZNGV0UU00WXNoeFhzUW5TcDAzbk1r?=
 =?utf-8?B?QzJJd3RkREdtYXBTaW9nZU40ZEdyeERQSFNQbnpvdUIyTGtuSmZMTm1DZ0d3?=
 =?utf-8?B?SVh4KzNrR0lyYnc4Q3JlQXg4alVFL2NtME53bWFxdEdqMVJvaGprc2VITjE1?=
 =?utf-8?B?cDNRNmtSckw3OEFBc21RcjcxZFA1dUR2TjVxOGRDaFh1d2t0NFRpU3ZwYmRt?=
 =?utf-8?B?UVZERmtzazVsMUppTWE5R0FXR1R5a01XZ1Z1bHE4Tk0xYndGT0h6OUQ3ZW1R?=
 =?utf-8?B?SS9LZlV0QWV5Z21jaUVDbHdEcTZHYVJoUjhDN3NWZ2VlTTZuMkVWQXNZamRG?=
 =?utf-8?B?dmxxZWxtVFduUURTMm1zYUcrSVp2SnQzaEdzQmNZSVZKdkw3eU5IbzZKZUha?=
 =?utf-8?B?eEdEMklFQVVEeWVzSVJ0emdjb3grNEtIZC9nazlkRmZUZzdDcXBzeGE2UVZk?=
 =?utf-8?B?QkhBdExUcVVQUXNoNVQycVhETFJmeHRxakZPMnl5UkhIT3NvSVZPcnlLUXdL?=
 =?utf-8?B?amdzOXpUbGZIOURhSjh1SE1QUGw5QXgycnV1VHlDQm9qMmhkaWhCQWJYdTZN?=
 =?utf-8?B?NTRjSVlUYkVqUXEvUjhHZ3V2VEZYR3gwQW94bmJyalZONThJZDlRTGxleDhl?=
 =?utf-8?B?YWRxY0R5Yk1vTnB3aDBNcGhvUXZySkF5RDZEZXRxaTcvdlhMb1BlbXkvRVQ2?=
 =?utf-8?B?S3VCWmt0bzdFVmN2QXZnNERHeEZPdjhURGw4ZjdHODdWZ0VRa2NnbklIazNV?=
 =?utf-8?B?dzdmK0JwTnFFK2hPcytGVEJxRkFTVEdFeWxKOGxqWWRLRjFmenhHZzNEMXBM?=
 =?utf-8?B?WFdTMm5DNmVwbENDWGlqSXA0SFlTdjJKaTBIUnF0VG5adGs0ZTNUQTI0Ty91?=
 =?utf-8?B?d2JEKy8wY201Ykg3NGZOOFptclpqTjdORExadTk2ei85RVNkL0JKQXlGdDV2?=
 =?utf-8?B?M1JLZzhwUlY0MjExRnhTaGVSYUEyNUtBMWR0cmRFdTdJaHdLUEx5N0xPcFlO?=
 =?utf-8?B?ZlBhOUhWcFk1dE5KWGQrQ2VaNHhpNjV6TCtFbkdUNFluK2RIUHg0Wm9rMllM?=
 =?utf-8?B?OEllZFg2VTFkTDRUbXdZODZ2VUNyakN0SWIvL2FxMmEvYXpxUVFPUEdTVTNY?=
 =?utf-8?B?aEFaYllETmdVbTJ5eHdkZm1UWDRlcFdhbG1VVkJJNHNZdndQZlJMdWpaL0ZH?=
 =?utf-8?B?MWNva3l4VEwyNDNCZWtMVEdXNmFLQUYrY3FCMFh0WDFkenkrZ0tWMDh2WE9o?=
 =?utf-8?B?TG9kWmhiQXdCbjhMeklCOEJ4MnZuN1Fnb2ltOGVZMXB0Sjlyb3ZSM2l5Wk9Y?=
 =?utf-8?B?dndJWGV3WUhvWGpsajE3MXNTbHp3c0FqengyZHJNYVd1aWt4ZXdid2h6c1RC?=
 =?utf-8?Q?Y6zGA8VBmA1rtOXRUIUiVL8=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16180f4a-d158-4da2-bee7-08dd9f892984
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 14:49:21.3744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ExAu6aBUfLE3yDrazkOJaRbgHapIXSeJXfOdx3MCBfU3cMrxWLdLT7K09gtoZG16l82r8Xy5nfGVkOvJw/bgVEz3KulfvAI8ib0UBNd3aWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB9291
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

On 2025-05-29 14:06, David Aldrich via lttng-dev wrote:
> Hi
> 
> My question isn't directly related to lttng but I would welcome some advice.
> 
> Our Linux application is showing 'blips' whereby there are occasional
> increases in processing times. This is for a user process that runs on
> an isolated core. Using lttng and TraceCompass I have found that the
> 'blip' sometimes coincides with a TIMER_SOFTIRQ event on the isolated
> core.
> 
> I was surprised that software interrupts may run on isolated cores. Is
> there a way of preventing this?

+CC Frederic Weisbecker.

How are the cores isolated on your system (exact kernel command line
options or commands issued) ? There are various degree of fine-tuning
to prevent disturbance from the tick (nohz full), scheduling, and
irqs that can be done explicitly. So depending on your specific
configuration, you may be missing isolation options that would
prevent the softirq from running on your isolated cpus.

Thanks,

Mathieu

> 
> Are there any techniques using lttng to gain more information related
> to the interrupt (e.g. what is causing it)?
> 
> Best regards
> David


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
