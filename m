Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94726C28B30
	for <lttng-dev@archiver.kernel.org>; Thu, 20 Mar 2025 21:06:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZJdRz1l0Mz2948
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1742504817;
	b=LylJZRB904NU9qmAMD8vPerwoFidueI+qGV0vSqvYc6YgsDHPqfG7/1uuU3bza3Wxhx9
	 9V7vNNBli77HDsTT9wL6i6nMRONraWZtmPHjzpcTFTVUzt1GU2bqaRyKX3I4mUrKZrV1f
	 f94Wtywy50s8/ONORwAp2fPeHZrpaxuu1Yqf3zyGYddeL1rSdU+09/1l5lLVdmDsquIaQ
	 GaM352PE5RGAoopbF0H+6T6kWRh8u1KApcPNawHKgf4vSfppdTT48EqVyrsM7pgN8eEKo
	 ZNTYrzkjnHa+5/kZgPrb6PON9zpvWpovU3754WiW6rtAlNEYk8yI7bprq1knlSLMrkQ==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1742504817;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=vDFAMbgNO2/R4092MysYiynNdP5xLLzi93lQ2YFzp3w=;
	b=NpT7zO6+C/Y1c3Dzlb3o7OpY7+WKeluHa1ayYgnuvUGkxH+ULL6DN3nXEBXLthd4X+pr
	 s4881G0hXpXQ88XZe+cbztp5l8aTa2+RLJqUYDdffgbxiVrJ5Yqkjxtzth/GbHhLsFWKi
	 yCTY20Y9uFAT7FCRSVA4tIdq3xoea+4mgOP8krZFEo4FyG3LJgbxb7yjs8hMZcnoqitRH
	 JENsIWJS7N1z+s8H8kLl98uLuRCpAAPgNJ+2BITcLcEY/cxmkXib24yIGpNnhpz4xBlP6
	 C98kx7bf5arUGs/tBj9an2oLhUX8QIILkGqXRKWjBVd1N/T3V9EvcAYdTv4GHmm1UsQ==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZJdRz1l0Mz2948
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1742504817;
	bh=vDFAMbgNO2/R4092MysYiynNdP5xLLzi93lQ2YFzp3w=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=AYVcjzt2oygbVMXZ2a4otfhKsktGcCRW5uelTxCy7zoKgfTY0VEUXhSddCHLTfh6Y
	 UDQgVi8mXuqUb0KGiFnXdACbNa9gx459Q43A05iOhVlczjyB1KkbGb8C8XZcckgXP6
	 NKzERe2QAFkXNgjg3Wt9jeGEzCpbz58o+oXKEhKATFMgejH7dRMWALmvNM7g/TVYzu
	 54CSf4/tQXWMjpn9dUSEqglKrTH4D1SORM5PGJPTmsQYLOhyKsZjVEpL/QHnUcrDDP
	 uV0C1gcl877m6/PYJ7qsuKexqe6oPbmWOosQoOoZ13FELu7rhZayH5liSwwM9vB3Pv
	 UwE8UAbCgyMBw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ZJdRz1l0Mz2948;
	Thu, 20 Mar 2025 17:06:55 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZJdRx3NCCz28qV
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZJdRx3NCCz28qV
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazon11020131.outbound.protection.outlook.com
 [52.101.191.131])
 by lists.lttng.org (Postfix) with ESMTPS id 4ZJdRx3NCCz28qV
 for <lttng-dev@lists.lttng.org>; Thu, 20 Mar 2025 17:06:53 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHGwS5ptyRMs4TspCB6sPVMSzvFy1POcaBr47UdC49v4KZreCIDVq5cLMEkiHPLGMt/v+RE6PBRBHKvexOehtBmmXwqUA+ORgdqNXwHuPZY5Rz5Ef35yf3mb4aDuXnAhnDU4JX2u4SKOCN7zChbcGNPkZkqUaZX7jblXLlGqmGaE33ZrhmGpXjYvsb1mi/w06TOAQiX3T7r3/xWUAIJJbZkzObGlmZ4lgTkyZaqTf9AWMSKVKrx8FYfKComANnc57f7ernqxZl8j5eyD4iTRLBWI5AyMWRkTSt+MClLtFqbEh+TZWBiBNasZqHbT+lZOTpHk7ZEzKLqY5pfshNUKWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6K7hevCXjE+u87KjC/HqfNOYC4HpHNz9ipMaQb2Izk=;
 b=i/2UKkQ3YFA8iJHGqO4OQG2qaDLLxHPuegPRQK5FUe0dvgpp85LY3QAj9shsb73sHioBKNkRdzcW2lB/cU4+7KgAjNhYdGIWm9BKKZDuAJug53PeEET/7s/RyTia9dIBLat5tEeYCK12xF0Nd2mppRNd65SCOxFmii6+VpYK1hcTH2W7TcP/trnsVdbBDxNvCpWJ4l3WbsxpyJ7cSjRqokba3Km7adqByy0Q8mygGEkOqsYy9K/SDRpan6bzIrSna8zrZd9NnuATNhXVgyFPJgwziDBoHcd2PVVsCaTzhPyrPNZ3pmmt0Bb7z2DAbqrVABc0i8ZdOQyvdVRSYVKfBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT4PR01MB9640.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 20:51:44 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%4]) with mapi id 15.20.8534.036; Thu, 20 Mar 2025
 20:51:44 +0000
Message-ID: <605bbc18-bb08-4a72-b470-fc0c34e67acd@efficios.com>
Date: Thu, 20 Mar 2025 16:51:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: lttng-dev Digest, Vol 203, Issue 7
To: Gour DEV <lakshyagour10@gmail.com>, lttng-dev@lists.lttng.org
References: <mailman.58.1741790192.282.lttng-dev@lists.lttng.org>
 <CAE9Jrzj_A8AwR80s-2_Wnv+vSpgqp4m6jKmJAAVg5VP4SKASEA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAE9Jrzj_A8AwR80s-2_Wnv+vSpgqp4m6jKmJAAVg5VP4SKASEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::9) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT4PR01MB9640:EE_
X-MS-Office365-Filtering-Correlation-Id: fd174c5b-b361-4f01-1e54-08dd67f105ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|4022899009|366016|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmJpQVFSL0F6MDRkZWVKaGpKaFE0NFFqaDhUQTFObDhUajd1R1Bwbit1ajUw?=
 =?utf-8?B?WVhaTHlFb0psSmQyL01IVDB2M3dveFlPU2crMTRnOC9oaS9uNmUvWTVhdWo1?=
 =?utf-8?B?WXQ3T2wvdUQ4ajdnTmkwOE5QWEczdkQ0eTNZWHFTbkkxdkFTV0loMThFeGtF?=
 =?utf-8?B?YWxHVUdOeTYrcGYvWUVuMWhydC96emRSZlhzRzUrRmxUd2hmeDdTL3lZaDZI?=
 =?utf-8?B?d2RlMHhPWE9hNFhlZWZCTGxYU2tjYzlUWnlmSkJhZEJLWDNZdkFETTcvNkVD?=
 =?utf-8?B?WU91Rmk0b0JuaTk1NzBGaUFtSHRETXBBeFFHbGwyalUzTURoVHdoclJjamV4?=
 =?utf-8?B?VFU3QVRIQ2RzaklIM0VpSnlHVSttT1UwY3FwVjVFQ0hwR08rWCs0SXVQMXhr?=
 =?utf-8?B?ODRCM25mZ3FyR3NGNnpOcU1yRmY2NVplYUozRGY1RHNpY0pDclNnR2puVU9V?=
 =?utf-8?B?UStVUjFIRGZDNzNzY3VlMDlrT3lVNmFHYkFyTnMzWGgrMDJYL2FieFZuamNk?=
 =?utf-8?B?anFaOG44ZG1jQkhQSDZrWlYvNDUrUXpWWHdaSk14aS9VVVUvOTVnMlZ2LzY1?=
 =?utf-8?B?ZE1CUGRZenROdEExWnFVSk5CVXNzQnVRMHdwMzdnL0IwbHNXRys2YS9jVmha?=
 =?utf-8?B?TW9JZmFRbmZhT0lTNnliNlFDR2Y5QjRPTXJTd2hmdGgyNHptRytoenZ4bUhZ?=
 =?utf-8?B?SHMwalVneW10MDRXTzZ3RTZVdEF1UVZZM2ZjQXhaY2hqRitsdFZwcHJsK0lM?=
 =?utf-8?B?WEwwbWlIRU1TK3JDRFZudkRBKzllQlFiK3VJZGVnQ045Rm9nK1N6MCtFZ3Ry?=
 =?utf-8?B?MW0wcHhuSUMweU9qUUVLTzByWVF1Zkd5WXMvMi84bzQ1MFRFK1F2ZExuQTk3?=
 =?utf-8?B?dWpjZmtFdFBRS1RkNk1JSWZlcDhUelVSd1FjcEI5OVpNeEJlSDhyK2lmTm5P?=
 =?utf-8?B?aUdKTTN0SWp1RTNoK0hTejQveksrbkVxTm9KclcwUGM0MlorS2ErNmJxT0pB?=
 =?utf-8?B?bkxkWFFQVi8wSWZ5dTRUN2pQNUZjK1BtVWlxZ0ZrVTE1MytoNkRsVWtnWGZs?=
 =?utf-8?B?QVZYZ3h5TzVEL0J4c1JlR3N3NW15TnlYTmFqSnRPbmtPeEN4aDdiUkMxTmNB?=
 =?utf-8?B?QnJBcTMyb0pIL3NiNkxnbGQxa3hBUHc2VmhRcUExbFVGa0thc1Vqb0NJZnpt?=
 =?utf-8?B?aVc4UWEzNXJFN0k3Z1dVR1dXd0xlVmNmc2ZIblBNZGxVUWRvZDcrZkM3dlEz?=
 =?utf-8?B?cFI1YTZTMEZHTkt4UWRndHJCZVNCeHdBem1XNCttOTYwYk1BdVFwNldxZ2Jh?=
 =?utf-8?B?RUJMWUx0MFFDZ3A4MTlVYm9QaE1rMGpObG1DVXRDUk5DNGxvcVNxVW9HbjRO?=
 =?utf-8?B?SVhEUTJtdHdDZCtQTEF5RmEyM3BJMFhYdmhiYUVhcGloYllFOVl1bkZKZjRi?=
 =?utf-8?B?L0U3UmJhaTFMYUNBUVhBU2syOStjNGRVY05CREVPdndOL0R0eWNKS0dITENR?=
 =?utf-8?B?R1VvVTVZUldDOTlIQWZVdU4rS0R0eHJMcTVlcUh1UVdBZXJmOU5aejBDSmJE?=
 =?utf-8?B?aWdOMTRNNmNmc3BTQ24vSjlidkNsY1N4MmhrNmNkR0JTNUlVS01LKzVCa2Yx?=
 =?utf-8?B?VVJiUVhMTDU3WDQwOUZGL0NoYmJOdWpLcHVwNm9qeGVzcDhLaGFlRnFMV3lv?=
 =?utf-8?B?U1Q5RmxaVUx6WWx2cStSVUo3WFpVUi9oY3VLM28rbEwyM3ltMGpMSE16VlBW?=
 =?utf-8?B?RGxVTDRkVTRaSmk1elBSbGNuMVg2RHlGTDhTaUhwQ3d2VWhCZVJiZjg2Z0M4?=
 =?utf-8?B?MjY5Zlo0RkJqeWVFVmkzUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(4022899009)(366016)(13003099007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUd6OStuWW9zbXJpU1c0NmFpVWd2VmQzMTdkSEZHeEhCU3ZMd1pudXZUNXA1?=
 =?utf-8?B?eUQ1ckhPRzFjeGtSclloLzVjTHJvS0RaSW4wRE42SFdlWk1sd1lreGdTa3dx?=
 =?utf-8?B?TkxXajFKdG5NNXJHQ3l1cCtjd1hBVGxMM3A4SzgxcFBqa0NGMzFKMFdNaldy?=
 =?utf-8?B?YWVnOXJqdzdydk52bWtaM00yYndBdS9iTkkvMmtGM0ZrV1FveURjN1NkbWlt?=
 =?utf-8?B?cDlwUHlBdlFvZCtJUmVZcFJkREVqT3lkYUdidEpEeVFSZ1RjS3ZyamJlb3Rt?=
 =?utf-8?B?RTM1RWpIQ3JzTG5obEVjVGJGVnVxQWt5d3JSVmhJK0hJTHovMFBtSnFzZ1lp?=
 =?utf-8?B?M2JmSWpiUzdjN3JlQmUvcDZSaWNzQmpURWFzTlk4V1dEZW9YOS9ZVU9FdEls?=
 =?utf-8?B?TWdOWjVDbmplQlJNTjZXTlZoazc0V2xVY0grRkF5aDk5M0tRM2ZVMkgyS0pq?=
 =?utf-8?B?ajRoTGRYTTdhZEJnbmdlM1hYRVN4R2lNVS9IZE95dUVIVENkeUtZSkV2c2VC?=
 =?utf-8?B?ZDd1Q09PYUQ5ZHdmTjlhSUNRb3pRMUFjTWl6NW1aRVFXWlBGNlRueGFERnQr?=
 =?utf-8?B?Qm5lWFk3ZWlHYVVpSGN3NExPRTlVblcxRHRtQlZHNnBDdlFrN2Nlang1L2p1?=
 =?utf-8?B?MThVMGgzYzY4SjNUNU5JdFRSM3BhSFhQRzdLK1pOdGQ1d2p2TE9TWnk2SVhT?=
 =?utf-8?B?WWFQa3VXM090RmVJajg4M2FmaGlWY3o5UTJjMy9maUM5RXBSVWw4YnFzczM0?=
 =?utf-8?B?MjJMU0VWQjBlOUliVjFuaWlxYVlBTHlPUXozWUFkV2N1ODNrMzlON1RIMmpV?=
 =?utf-8?B?a0cxc21TcTV5YnUvOUhVZW9JMS9nT2NFNGlrT0lRZFMwY1IyRXJKWitYZlYr?=
 =?utf-8?B?b2xNa2ZPSmYwN3dVMGc5eU1LN1VzVnRjRkNzQmQwV3puTU1rTlUyZmhKdE1S?=
 =?utf-8?B?aUIzb0d0d3VJUlR1WHNzUXFsSWpJMXo3QU1tYWlHbDZ0dE0vL0R4UENTRnhj?=
 =?utf-8?B?UFhXeVJWeDRRZmFHbGo1Mkxod0VRblQ0emNHS3RuaUJYNzFMaFM4Um1hMWph?=
 =?utf-8?B?QVZNaE05OTJrcG9HNE1BdzdDYWxOZExTbUVhUHFWZkJqNXRldC95dTlzaXB3?=
 =?utf-8?B?S3FTK2ZxTUZKdCt4NU4xQXZZMmZQR1VYdDMxczhUb1l0WTlZcXM4MmtkRGZR?=
 =?utf-8?B?enZxRC8vWFJuSEwxT3pMNVFrcmFWYVFnNmVFM1FxL0lFTkVvNFRwQVkzckVj?=
 =?utf-8?B?OVJOYkVpTTNVVWxmUzRDYkxRcG16R2FhaDY4ZTF5Ny9vOWh0MFZVYmxiN1pK?=
 =?utf-8?B?VkhVK21EZGlXNE1IODF1cDVVK3hVSi9vV1hwT3ZRMUhTbE90K294VSs4cnNq?=
 =?utf-8?B?VTN2M1lIZmNzTWxoa1dGb0JhdUU4ajY4MTRFQ1JnT0xlSTZYbEs4WXp6RlBM?=
 =?utf-8?B?OTUxaVZKMTRTV2ZpQlpnN1lqUXcwWkdMcG5wazNwaFNSUThISEpGVTJFQWl2?=
 =?utf-8?B?R1VmbGlXandvR2JMeHF3T0FsT3czNVE4TFl6KzQrUzNJck85YWVJOUJQY0RY?=
 =?utf-8?B?QUVTbnZ0VFh1RnFHUjJuMWVzN3dZMlpxaWJTQWNEenp4Tm9VaFpwOVlYWXhZ?=
 =?utf-8?B?aWhsWW5mN2MveEg4TEZscUtWRmZDTVlKcXRRNDN1enp3WUNIK0JabGZaakd3?=
 =?utf-8?B?c1BsSWVmUVNuVjBTZ2lNWWd0VFg4N2VJdVMrWitpUTN3blFuZm5RYURLQm1w?=
 =?utf-8?B?Z3dFVklJLytQT1ZjZUIydjlOYmxOY3JzNGk0V2I0TXBpRzFnSnVMWmdJTVM5?=
 =?utf-8?B?ME5BWU5Pai9iaG0zcFhZeXRPM0FrV1prS0tjQ1ZZTjFQL0c0V2JERE9raERz?=
 =?utf-8?B?eVh6UmlyMDNxeTloZDZnT2ticHN2czZXK200NmIwZ3pyL3JUSXdnVFNOYTdj?=
 =?utf-8?B?QTMyb2FTZ0ROZUhFWWpBNk94TkdtZkZTenlOUlV1NW1xOCtzWWxScW1VYUpB?=
 =?utf-8?B?R3loK1ZoS011WHQ2bVJmOEhpbzdraDhacE43RGtzV0hpdWJXbTlTaXREZnZy?=
 =?utf-8?B?bStiZWJRdk5CVDluMTZrbEdjdEVKTnhCU2FBakd6Mkt6eVMvcm9YaW5kVUFQ?=
 =?utf-8?Q?3ZMHOYvvPJ0EQLLdtOSXF3pj3?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd174c5b-b361-4f01-1e54-08dd67f105ca
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 20:51:43.9943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OH/A1T9kCBIZ6+2RRVd23Hx5qAT7RWo1acVPCPVdfAEdyw0wZsoEN5vsK4hQmZ1jMXA5VniU611PUWpEibCyjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB9640
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

I did some digging around. What you are seeing is the result of the 
switching to MAP_POPULATE by default in LTTng-UST 2.12[1] in commit 
4d4838b ("Use MAP_POPULATE to reduce pagefault when available").

The purpose of this change is to avoid taking page faults which tracing, 
reducing first-event in a page latency.

In the master branch, this feature has been made configurable for users 
who don't want to pre-populate the pages and would rather take page 
faults while tracing[2].

Here is an example from LTTng master with map populate per possible CPU:

```
export LTTNG_UST_MAP_POPULATE_POLICY=cpu_possible

# Create session, channels, start tracing, and run test app
# top -n1 -b | grep -E '(MiB|COMMAND|lttng)'
MiB Mem :  32768.0 total,  21883.7 free,   1456.0 used,   9428.3 
buff/cache 

MiB Swap:      0.0 total,      0.0 free,      0.0 used.  31312.0 avail 
Mem 

     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ 
COMMAND 

  301117 debian    20   0  880176   2760   2760 S   0.0   0.0   0:00.04 
lttng-sessiond 

  301118 debian    20   0   43856   1376   1376 S   0.0   0.0   0:00.01 
lttng-runas 

  301133 debian    20   0  718616 263456 263456 S   0.0   0.8   0:00.17 
lttng-consumerd 

  301135 debian    20   0    6996      0      0 S   0.0   0.0   0:00.05 
lttng-runas

# cat /proc/$(pgrep lttng-sessiond)/statm
lttng-sessiond: 220044 690 690 345 0 29900 0 
  


# pmap $(pgrep lttng-sessiond) | grep total 

  total           880176K

# smem -P lttng-sessiond 
  

   PID User     Command                         Swap      USS      PSS 
    RSS 

301118 debian   lttng-sessiond --daemonize         0      344      881 
   2236 

301117 debian   lttng-sessiond --daemonize         0     5676     6683 
   9276 

301201 debian   /usr/bin/python3 /usr/bin/s        0     8636    10086 
  12936 


# /proc/PID/statm for lttng-consumerd 
  
  

lttng-consumerd: 1749 0 0 129 0 130 0

# pmap lttng-consumerd-pid | grep total
total kB            6996    1700     472 
  


# smem -P lttng-consumerd
   PID User     Command                         Swap      USS      PSS 
    RSS 

301135 debian   lttng-consumerd  -u --consu        0      280      563 
   1700 

301211 debian   /usr/bin/python3 /usr/bin/s        0    10048    11501 
  14404 

301133 debian   lttng-consumerd  -u --consu        0   262376   263177 
265480

# smem -m | grep -i ust 

/dev/shm/lttng-ust-wait-8-1000               1        4        4
/dev/shm/shm-ust-consumer-301133             1   260756   260756
```

When using the none policy:

```
# export LTTNG_UST_MAP_POPULATE_POLICY=none
# as above

Running test app UID 0 
  

procs -----------memory---------- ---swap-- -----io---- -system-- 
------cpu----- 

  r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy 
id wa st 

  1  0      0  21875      0   9434    0    0    39   636 1105 2496  0  1 
99  0  0 

MiB Mem :  32768.0 total,  21875.0 free,   1458.2 used,   9434.7 
buff/cache 

MiB Swap:      0.0 total,      0.0 free,      0.0 used.  31309.8 avail 
Mem 

     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ 
COMMAND 

  301616 debian    20   0  880176   2756   2756 S   0.0   0.0   0:00.04 
lttng-sessiond 

  301617 debian    20   0   43856   1392   1392 S   0.0   0.0   0:00.01 
lttng-runas 

  301632 debian    20   0  718612   5416   5416 S   0.0   0.0   0:00.17 
lttng-consumerd 

  301634 debian    20   0    6992      0      0 S   0.0   0.0   0:00.05 
lttng-runas 

lttng-sessiond: 220044 689 689 345 0 29900 0 
  

  total           880176K 
  

   PID User     Command                         Swap      USS      PSS 
    RSS
301617 debian   lttng-sessiond --daemonize         0      344      862 
   2188
301616 debian   lttng-sessiond --daemonize         0     5784     6759 
   9328
301700 debian   /usr/bin/python3 /usr/bin/s        0     8632    10079 
  12928

lttng-consumerd: 1748 0 0 129 0 129 0
total kB            6992    1580     468
   PID User     Command                         Swap      USS      PSS 
    RSS
301634 debian   lttng-consumerd  -u --consu        0      276      536 
   1580
301632 debian   lttng-consumerd  -u --consu        0     5672     6433 
   8652
301710 debian   /usr/bin/python3 /usr/bin/s        0     9996    11449 
  14328

/dev/shm/lttng-ust-wait-8-1000               1        4        4
/dev/shm/shm-ust-consumer-301632             1     4048     4048
```

thanks,
kienan

[1]: 
https://github.com/lttng/lttng-ust/commit/4d4838bad480d48424bddc686f5ad0089e28ac94
[2]: 
https://github.com/lttng/lttng-ust/commit/97572c0438845cee953ebd3e39615f78bfa405a7

On 3/17/25 2:29 AM, Gour DEV wrote:
> Hi, Kienan
> 
> Sorry for the late reply.
> 
> Looks like in buster the memory is allocated by lttng-consumerd reserved
> 
> I buster, the rss is less than the VIRT
> root@localhost:~#  COLUMNS=500 top  -b -n 1 | grep lttng
>   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>   4095 root      20   0 1003188  31256   4660 S   0.0   0.1   0:03.81
> lttng-sessiond
>   4096 root      20   0   44260    796      0 S   0.0   0.0   0:00.01
> lttng-runas
>   4440 root      20   0 5236020  10224   8756 S   0.0   0.0   2:56.25
> lttng-consumerd -- here the VIRT is much more higher than RSS
>   4443 root      20   0   48048    540      0 S   0.0   0.0   0:00.12
> lttng-runas
> 
> 
> 
> In bookworm the VIRT and RES are nearly the same only.
> root@edgecore-40XKE-j2-101-32:~# COLUMNS=500 top  -b -n 1 | grep lttng
>   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>     4382 root      20   0 1098824  42600   8436 S   0.0   0.1   0:08.87
> lttng-sessiond
>     4403 root      20   0   48928   2116    996 S   0.0   0.0   0:00.00
> lttng-runas
>     5171 root      20   0 9879764   8.9g   8.9g S   0.0  28.7 108:23.53
> lttng-consumerd -- here the VRIT is nearly equal to RSS
>     5173 root      20   0    3680   1028    680 S   0.0   0.0   0:00.88
> lttng-runas
> 
> 
> Looks like lttng consumerd is allocating and reserving those pages, when
> any instrumented application starts.
> 
> I am attaching the lttng status output in the mail, please do tell me if
> you need any more information regarding this.
> 
> 
> These is how we used to create the lttng channels and enable event which is
> same in both buster and bookworm, (number of channels might differ)
> 
> def enable_channel(channels, session, subbuf_size, subbuf_num):
> for c in channels:
> call(['lttng', 'enable-channel', '-u', c, '-s', session, '--subbuf-size',
> str(subbuf_size), '--num-subbuf', str(subbuf_num),],
> stdout=devnull, stderr=subprocess.STDOUT)
> 
> 
> def enable_events(traces, session):
> for t in traces:
> if 'log-level-only' in t:
> log_opt = '--loglevel-only=' + t['log-level-only']
> elif 'log-level' in t:
> log_opt = '--loglevel=' + t['log-level']
> else:
> log_opt = ''
> 
> else:
> call(['lttng', 'enable-event', '-u', t['name'], '-c', t['channel'],
> '-s', session], stdout=devnull, stderr=subprocess.STDOUT)
> 
> 
> Thank You.
> Lakshya
> 
> 
> 
> 
> On Wed, Mar 12, 2025 at 8:06 PM <lttng-dev-request@lists.lttng.org> wrote:
> 
>> Send lttng-dev mailing list submissions to
>>          lttng-dev@lists.lttng.org
>>
>> To subscribe or unsubscribe via the World Wide Web, visit
>>          https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>> or, via email, send a message with subject or body 'help' to
>>          lttng-dev-request@lists.lttng.org
>>
>> You can reach the person managing the list at
>>          lttng-dev-owner@lists.lttng.org
>>
>> When replying, please edit your Subject line so it is more specific
>> than "Re: Contents of lttng-dev digest..."
>>
>>
>> Today's Topics:
>>
>>     1. Re: Memory Consumption High After Upgrading to 2.13 from 2.10
>>        (Kienan Stewart)
>>     2. Re: Memory Consumption High After Upgrading to 2.13 from 2.10
>>        (Gour DEV)
>>     3. Re: Memory Consumption High After Upgrading to 2.13 from 2.10
>>        (Kienan Stewart)
>>
>>
>> ----------------------------------------------------------------------
>>
>> Message: 1
>> Date: Tue, 11 Mar 2025 14:55:21 -0400
>> From: Kienan Stewart <kstewart@efficios.com>
>> To: Gour DEV <lakshyagour10@gmail.com>, lttng-dev@lists.lttng.org
>> Subject: Re: Memory Consumption High After Upgrading to 2.13 from 2.10
>> Message-ID: <38dab5ef-f106-4e57-9e36-b4b30015c019@efficios.com>
>> Content-Type: text/plain; charset=UTF-8; format=flowed
>>
>> Hi Lakshya,
>>
>> On 3/11/25 12:25 PM, Gour DEV wrote:
>>   > Hi, Kienan
>>   >
>>   > here is the requested output
>>   >
>>   > root@localhost:~# top -b -n 1 | grep  lttng
>>   >     4841 root      20   0   11.5g  11.0g  11.0g S   5.9  35.4   8:39.93
>>   > lttng-c+
>>   >     4824 root      20   0 1098824  26456   5380 S   0.0   0.1   0:07.25
>>   > lttng-s+
>>   >     4825 root      20   0   48872   2188   1012 S   0.0   0.0   0:00.00
>>   > lttng-r+
>>   >     4843 root      20   0    3680   1160    816 S   0.0   0.0   0:00.23
>>
>> This top output for `localhost` seems very different than the output for
>> `localhost` in your previous message.
>>
>>
>>   > lttng-r+
>>   > root@localhost:~# nrpco
>>   > bash: nrpco: command not found
>>   > root@localhost:~# nproc
>>   > 16
>>   > root@localhost:~# cat /sys/devices/system/cpu/possible
>>   > 0-15
>>   >
>>
>> You indicated the bookworm machine has 32 cores, this is showing 16. If
>> you're comparing a 16 core machine to a 32 core machine, it is very
>> normal that the memory usage is higher on the 32 core machine.
>>
>>   >
>>   > Most of the process are running as asorcs user but some are running
>> as root.
>>
>> So you have two users with instrumented applications.
>>
>>
>> Given the discrepancies in the information provided I'm finding it a bit
>> hard to understand what you're looking at.
>>
>>
>> In general, a channel's shared memory footprint can be estimated with[1]:
>>
>>     (nSubbuf * subbufSize) * (nCPUs + 1 iff snapshot mode is enabled) *
>> (nUIDs or nPIDs)
>>
>> Note that the sub-buffer sizes you are using get rounded to the nearest
>> larger power of 2. See [2].
>>
>> thanks,
>> kienan
>>
>> [1]: https://lttng.org/docs/v2.13/#doc-channel-buffering-schemes
>> [2]:
>> https://lttng.org/man/1/lttng-enable-channel/v2.13/#doc-opt--subbuf-size
>>
>>
>> ------------------------------
>>
>> Message: 2
>> Date: Wed, 12 Mar 2025 14:49:07 +0530
>> From: Gour DEV <lakshyagour10@gmail.com>
>> To: Kienan Stewart <kstewart@efficios.com>
>> Cc: lttng-dev@lists.lttng.org
>> Subject: Re: Memory Consumption High After Upgrading to 2.13 from 2.10
>> Message-ID:
>>          <CAE9Jrzg7qsabhPiO-0=B1DY3bVo-3FYu2tiJR2Bmb=
>> nqOHNZMw@mail.gmail.com>
>> Content-Type: text/plain; charset="utf-8"
>>
>> Hi, Kienan
>>
>> I am attaching an screen recording of the behaviour I am seeing in this
>> mail. The behaviour is same irrespective of the device i use, sorry for
>> miscommunication in the npocs output (I assumed it was 32), but other than
>> that all outputs are same (except the hostname as there are multiple
>> devices with same lttng config but this memory cosumption is seen on all
>> the devices).
>>
>> I had few question
>>
>> 1. Does lltng allocated all the memory it needs and mark it as dirty in ram
>> when any process which links/uses lttng-ust runs? (here i tried with one
>> process but it is same for any of my process)
>> 2. (nSubbuf * subbufSize) * (nCPUs + 1 iff snapshot mode is enabled) *
>> (nUIDs or nPIDs)
>>
>> How do we calculate uid in the system is it all uids in the system? is it
>> equal to `cat /etc/passwd | wc -l` ?
>>
>> I will put my calculations according to the above estimate based on all the
>> channel i am creating
>>
>> (4194304*4 + 262144*4 + 16384*4) * (16) * (30 if number user are equal to
>> `cat /etc/passwd | wc -l`)B = 7.998046875 GB approx [this is based on the
>> start_lttng.py please do correct me if am wrong here.]
>>
>> But since there are only two users which uses lttng i think the correct
>> estimate would be
>> (4194304*4 + 262144*4 + 16384*4) * (16) * (2)B = 546MB
>>
>> Please do correct me If I am wrong calculations here.
>>
>> Now, there are a few things here, according to my output lttng is using 11G
>> which is much more higher than the what is configured.
>>
>> I am attaching the lttng status and the file which is uses to create the
>> lttng sessions.
>>
>>
>>
>> Thank You.
>>
>>
>>
>> https://drive.google.com/file/d/1tS_ZWEsXDpHZXfWzZHXmWcT0igiIOIaa/view?usp=sharing
>> -- recording of the behaviour which is seen
>>
>> https://drive.google.com/file/d/1PrU31oyEw1n9tKETlUtmNGO50s6ywx7p/view?usp=sharing
>> -- the file which is used to create lttng sessions
>>
>>
>> On Wed, Mar 12, 2025 at 12:25?AM Kienan Stewart <kstewart@efficios.com>
>> wrote:
>>
>>> Hi Lakshya,
>>>
>>> On 3/11/25 12:25 PM, Gour DEV wrote:
>>>   > Hi, Kienan
>>>   >
>>>   > here is the requested output
>>>   >
>>>   > root@localhost:~# top -b -n 1 | grep  lttng
>>>   >     4841 root      20   0   11.5g  11.0g  11.0g S   5.9  35.4
>>   8:39.93
>>>   > lttng-c+
>>>   >     4824 root      20   0 1098824  26456   5380 S   0.0   0.1
>>   0:07.25
>>>   > lttng-s+
>>>   >     4825 root      20   0   48872   2188   1012 S   0.0   0.0
>>   0:00.00
>>>   > lttng-r+
>>>   >     4843 root      20   0    3680   1160    816 S   0.0   0.0
>>   0:00.23
>>>
>>> This top output for `localhost` seems very different than the output for
>>> `localhost` in your previous message.
>>>
>>>
>>>   > lttng-r+
>>>   > root@localhost:~# nrpco
>>>   > bash: nrpco: command not found
>>>   > root@localhost:~# nproc
>>>   > 16
>>>   > root@localhost:~# cat /sys/devices/system/cpu/possible
>>>   > 0-15
>>>   >
>>>
>>> You indicated the bookworm machine has 32 cores, this is showing 16. If
>>> you're comparing a 16 core machine to a 32 core machine, it is very
>>> normal that the memory usage is higher on the 32 core machine.
>>>
>>>   >
>>>   > Most of the process are running as asorcs user but some are running
>>> as root.
>>>
>>> So you have two users with instrumented applications.
>>>
>>>
>>> Given the discrepancies in the information provided I'm finding it a bit
>>> hard to understand what you're looking at.
>>>
>>>
>>> In general, a channel's shared memory footprint can be estimated with[1]:
>>>
>>>     (nSubbuf * subbufSize) * (nCPUs + 1 iff snapshot mode is enabled) *
>>> (nUIDs or nPIDs)
>>>
>>> Note that the sub-buffer sizes you are using get rounded to the nearest
>>> larger power of 2. See [2].
>>>
>>> thanks,
>>> kienan
>>>
>>> [1]: https://lttng.org/docs/v2.13/#doc-channel-buffering-schemes
>>> [2]:
>>> https://lttng.org/man/1/lttng-enable-channel/v2.13/#doc-opt--subbuf-size
>>>
>> -------------- next part --------------
>> An HTML attachment was scrubbed...
>> URL: <
>> https://lists.lttng.org/pipermail/lttng-dev/attachments/20250312/57f240d8/attachment-0001.htm
>>>
>>
>> ------------------------------
>>
>> Message: 3
>> Date: Wed, 12 Mar 2025 10:36:28 -0400
>> From: Kienan Stewart <kstewart@efficios.com>
>> To: Gour DEV <lakshyagour10@gmail.com>, lttng-dev@lists.lttng.org
>> Subject: Re: Memory Consumption High After Upgrading to 2.13 from 2.10
>> Message-ID: <0f819583-ea8e-468e-9102-e1410d886a6f@efficios.com>
>> Content-Type: text/plain; charset=UTF-8; format=flowed
>>
>> Hi Lakshya,
>>
>> On 3/12/25 5:03 AM, Gour DEV wrote:
>>> Hi, Kienan
>>>
>>> I am attaching an screen recording of the behaviour I am seeing in this
>>> mail. The behaviour is same irrespective of the device i use, sorry for
>>> miscommunication in the npocs output (I assumed it was 32), but other
>> than
>>> that all outputs are same (except the hostname as there are multiple
>>> devices with same lttng config but this memory cosumption is seen on all
>>> the devices).
>>>
>>> I had few question
>>>
>>> 1. Does lltng allocated all the memory it needs and mark it as dirty in
>> ram
>>> when any process which links/uses lttng-ust runs? (here i tried with one
>>> process but it is same for any of my process)
>>
>> I believe the shared memory for per-CPU data structures is allocated
>> when an instrumented application connects. There is no pre-allocation
>> for each possible UID on the system.
>>
>> You can run your instrumented applications with `LTTNG_UST_DEBUG=1` to
>> see when the connection happens[1].
>>
>>> 2. (nSubbuf * subbufSize) * (nCPUs + 1 iff snapshot mode is enabled) *
>>> (nUIDs or nPIDs)
>>>
>>> How do we calculate uid in the system is it all uids in the system? is it
>>> equal to `cat /etc/passwd | wc -l` ?
>>
>> nUIDs is the number of distinct UIDs running instrumented applications.
>>
>>>
>>> I will put my calculations according to the above estimate based on all
>> the
>>> channel i am creating
>>>
>>> (4194304*4 + 262144*4 + 16384*4) * (16) * (30 if number user are equal to
>>> `cat /etc/passwd | wc -l`)B = 7.998046875 GB approx [this is based on the
>>> start_lttng.py please do correct me if am wrong here.]
>>>
>>> But since there are only two users which uses lttng i think the correct
>>> estimate would be
>>> (4194304*4 + 262144*4 + 16384*4) * (16) * (2)B = 546MB
>>
>> The estimate I gave is per-channel.
>>
>> small channel: (0.015625 MiB * 4) * (16 + 1) = 1.0625 MiB per-channel
>> per-UID
>> medium channel: (0.250 MiB * 4) * (16 + 1) = 17.0 MiB per-channel per-UID
>> large channel: (4 MiB * 4) * (16 + 1) = 27 2MiB per-channel per-UID
>>
>> Now, you said you have 0 small channels, 6 medium channels, and 16 large
>> channels in your session. (Note: I see your script differs from these
>> stated channel counts).
>>
>> small: 0 * 1.0625 MiB = 0 MiB per-UID
>> medium: 6 * 17 MiB = 102 MiB per-UID
>> large: 16 * 272 MiB = 4352 MiB per-UID
>>
>> And if you're running instrumented applications with 2 users:
>>
>> small: 0 MiB * 2 = 0 MiB with 2 UIDs
>> medium: 102 MiB * 2 = 204 MiB with 2 UIDs
>> large: 4352 MiB * 2 = 8704 MiB with 2 UIDs
>>
>> Now this is just an estimation for the per-CPU ring buffers only, and
>> you numbers aren't hugely off so without analyzing your specific system
>> it doesn't seem to be that strange to me.
>>
>> If I take the number of channels I see in your script, it becomes:
>>
>> small: 0 MiB with 2 UIDs
>> medium: 136 MiB with 2 UIDs
>> large: 7616 MiB with 2 UIDs
>>
>> total: 7.57 GiB with 2 UIDs
>>
>>>
>>> Please do correct me If I am wrong calculations here.
>>>
>>> Now, there are a few things here, according to my output lttng is using
>> 11G
>>> which is much more higher than the what is configured.
>>>
>>
>> I have no idea what 'service start spyder' is doing. Maybe it's running
>> instrumented applications with an extra user that you didn't expect? I
>> can't help you with that aspect of your system.
>>
>> The above estimated 7.57 GiB with 2 UIDs would be 11.35 GiB with 3 UIDs
>> so maybe?
>>
>> I'd recommend you read your verbose sessiond log so see which
>> applications are connecting and with which UIDs.
>>
>>> I am attaching the lttng status and the file which is uses to create the
>>> lttng sessions.
>>>
>>>
>>>
>>> Thank You.
>>>
>>
>> In any case, the information you have given to date hasn't demonstrated
>> to me in a tangible manner that you are seeing a difference related to
>> the version of LTTng being used.
>>
>> thanks,
>> kienan
>>
>> [1]: https://lttng.org/man/3/lttng-ust/v2.13/#doc-_environment_variables
>>
>>
>> ------------------------------
>>
>> Subject: Digest Footer
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>> ------------------------------
>>
>> End of lttng-dev Digest, Vol 203, Issue 7
>> *****************************************
>>
> 

