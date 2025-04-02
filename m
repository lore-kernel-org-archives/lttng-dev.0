Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760F1C28B20
	for <lttng-dev@archiver.kernel.org>; Wed,  2 Apr 2025 14:37:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZSSB73KGKz1kTW
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1743604623;
	b=QqlCY3pJlGZ0wzut0+ZMghCE/q/1yTqnlZHy2XGjsktB65HUV2qBnEAu4pR59WJ6V9m8
	 5X7nIebGcUEduVljKAuwNa7WGigTYBw2nPDqktk2MY3FrT5BN2qB1mkjmmi94sncbf1lb
	 xO6Xq5HJJND9B3qXWBHyevBOwRRJI03RNp1qy5HGNN2uDpxb0LMSKyYrtFEE/YqNIbQWz
	 nK2p7R1b7vCTLTR7zILRm7cFe/jFiys3fgkdWR0/3ZUE+oLu/pKt1FOebadb2Tp/0cMdN
	 0ztWRcGrWVdegb+lrIfd9tbayS1HUnt2Un5jfZANqBq4dmRxslcZoiaK9NvpjMaWauA==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1743604623;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=pVFnHLWtDzhHNI/aNjvfi7GNJENAQoA7hYHylJiK3qc=;
	b=CdsYWN3c9EOqdvrS2gWZ/33yT/wFDYbxvO77mfwl9gxeyvHMoZ7Xv6Ja6EdsjBlQQd9M
	 0NYtYtQ3E4lqx0dMI4Sp6N+YUtQxtRB+0Vf+Rw1MZE5NAzvwkQ+5uUGyKIp3Gk5jGJ5vf
	 Qlz8q4c+NswGtBJLzc3B8OKRfR75p623KBVJVKHjfkLq+idPtQoNkc39U6gIE1SEwctJD
	 2r3sLTPFh7jcRtJQ0ixLXjxapu9qs2tsVP4H4QXde2KshKFegiUqt4GwI3UWxcHDRMaIM
	 HlpinZNUOOzUOZ81ZzKF3IP+HnfMMFmTIapKvBkuIb1ld8WPJQB9KxWcyRPA2dJHcJA==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZSSB73KGKz1kTW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1743604623;
	bh=pVFnHLWtDzhHNI/aNjvfi7GNJENAQoA7hYHylJiK3qc=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=KJlY3FnF4I7iEn3qg0kDH7Y3mLCnXU3D8y8knmvjJs5Mcw7JEWVz3giVXkeIPLMiw
	 q8TJpubtWX5pXbWP65K/15/0oe/ZikAcv7DGfpDh4hyru6G2YKFokCf//X/DNRMRSo
	 GzI4Xtvf3cOVwpn6Vlrq6eDExBnGOfXjEDPUO5iUu/ClnXmVAOH8ZUQ/IyO0QrXg2V
	 7+b00eKvy12E/QpOz1ucx4VwjS2mrgOOIs/VnxOlr5b4LcfEbPeB3Ai0y+3xTaTso4
	 Q1VRMzG/5Z/HXzd72Zz9Dnla6QitqGa9lWm0h1yh5/T9WwAfSgHL6pwCPKNO1yWoKZ
	 +ylzh1//s0Mhw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ZSSB73KGKz1kTW;
	Wed,  2 Apr 2025 10:37:03 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZSSB53KZWz1kfN
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZSSB53KZWz1kfN
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c104::1])
 by lists.lttng.org (Postfix) with ESMTPS id 4ZSSB53KZWz1kfN
 for <lttng-dev@lists.lttng.org>; Wed,  2 Apr 2025 10:37:01 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kECDS8mLT8h5AU+M7JAwaTWj324s96c18pWUWMBmB+5g+163tV9e7mWQ4R6efU1NjnfsUDBPHObnIsh9xgWwrHOMHnKImdgX5kyC/vvER8FfWB34zk7oh60QTIo0C1mdJfCH4k0JPeNtN+aWEFzZfVq76iWua3MSfAooP2HANUebTGiHrYc2WuAo9F5v4pc9q2SCl2YsK1hkCoR5BBfN5IMzFXuA5JtxYE32hgYFcoQSXkHrLEidDgo94Mz4tKDAfTYDODa6yBfQwbXFLyWgAMSLE0gOV8xJsmWCjqg89O3mBBKPh7uqq7eR31fHvQfadI6cztMpTEfDph5DvsrZEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fym7sEn+TyDuRR8P0ihq9/Bp96zEa/BRRR0jFr0QF64=;
 b=E89VeCRSF9wtcsbs+D5lT+eySIAOLjEsmDK0kslH7xlVtQqehFxNlzwqYfFAM6i9uqvp3ubTJ5fQoEJ/rLzIOJf9sMlbzojOTszGGX2fy9vCv+jys5Zu/JPJLfVPXrgauMft4/Pqd7+AtTnrOa3rN/SL47wEVZ0k7lwry3nJvb6YG8WZnNG7p4qZLhWi2aOfUg326Lsf7hLPpPu53lbEEY4cg8r3R0hc3ejWlZ9DRgRMu4VqFNiEYMgGbjG1bUSBjIQxDNIJgjBzQkE3aGYOZ7JDNKJl0LchycU1S10qEZ25GNaKr0yA0Xje8PR+jLrVWu92INfh9D89W43hwaYuOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT3PR01MB5432.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:64::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Wed, 2 Apr
 2025 14:36:35 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%3]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 14:36:35 +0000
Message-ID: <50d2bf88-05a1-4895-b8d5-72181a48d590@efficios.com>
Date: Wed, 2 Apr 2025 10:36:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: LTTNG Session daemon is crashing when i launch lttng
To: Deemanth P J <dputtaja@qti.qualcomm.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <MW6PR02MB9671CDAF08B397819190B963F9AF2@MW6PR02MB9671.namprd02.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <MW6PR02MB9671CDAF08B397819190B963F9AF2@MW6PR02MB9671.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::10) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT3PR01MB5432:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e22757-0e15-4e56-4cb1-08dd71f3c4c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGJLQ3NXVHBkbXVxYkUxbC9PZ1R4K0NlQTRqSmk2NW9kai9SZGRIeVVhYUNU?=
 =?utf-8?B?aFpnK0dRZjZvQUlwOVF5QUVFRWhCaHNvNDh3b0xGeFdEMkdCQnRHdHBkU2dH?=
 =?utf-8?B?N0pmY0dRMCszVEgraWF1SzJZQVgybWRRTFFFZmhnRUJWamkxY3ZCSWxQejMz?=
 =?utf-8?B?b0ZVZlRNUXZmUDVEclNzVnZTaTJSSENnZkM5MTA1dnByQ0d1V2FlS0hhc2Ev?=
 =?utf-8?B?azJvbHhzSmEzS3lkQkdWaFphbmxKQ1kxUXdmbDJnMExOMnJ2Wmc3Q0FQL0pO?=
 =?utf-8?B?c3Y4c3BsY2NxakJPVU9jRTFCRm9ZeDRHcThBeEZlUkY0M2xaVEhqUUNFT0ta?=
 =?utf-8?B?YTFnbHZFeFlORHIwSGcrVk9pZjhBd1dReDlGOXJldStWV054RUREK29WeEZE?=
 =?utf-8?B?bFNDbmEvQ21ndlpBS0szc2RhU1BwTXZLMS9lWVRnb2Y4dXgyVks4dFRmWnVo?=
 =?utf-8?B?OVViVVAxSDFDc095SFllRFFvQjBhZDZXcTR5VllURE56VEprV3laREQ4UC8r?=
 =?utf-8?B?aFpSck5FWHMyZGZrNXByZXhBWnVYTHNCTHlqZ0J6N2FvRWZEdlhpSER6UE50?=
 =?utf-8?B?SmQ4cERvc281SWxoRmtxa1dJTThXLzBleGdtZTlJdEU0a3BTeGw3NTZObFlu?=
 =?utf-8?B?ZnBJc3k0VmI1OUg2UWs0dXZOay92RDkxVTc2bmEvU2h1UWZvZU80L2pXRS9u?=
 =?utf-8?B?RlFDa3lieFhYWXlqZEVtKy9Pb2ExVUJZdk1KV3ZvaFdmSDFXOGR3WnpmTkhZ?=
 =?utf-8?B?RlpnY09oSWZXenh4L1lxS2FEVnVwQzJjWTdWSUtyRE5nd2F4eEltbGZSLytJ?=
 =?utf-8?B?bFUvQithMStGZ2NIby82UTNLNEZFMzZBN1BpSU1ZZlc1bWZnUFo2NzYzTjls?=
 =?utf-8?B?a0tsb3krWnoxdkcrdU5XRDJsdHdLd0crMVFyb0hWUEFoY3FYL1ZJajlxMGdi?=
 =?utf-8?B?MXh3ZG1KWVNsb0l6cVp3LzNmRUdqNVBMWmRjc0xhMGw0Q3ZKRjhtTCt0bzFL?=
 =?utf-8?B?MWZSSENSNTAvZkdOOFExd1VSRjNGbytDTVJZNU11dUs2eE90UmtZQzBmYi80?=
 =?utf-8?B?UG5ZUllFUnF3dkxYYzZHOVJ2TERrd0I2bTk1K1lsTkpGYlNGTUQ0RGxKc24v?=
 =?utf-8?B?UEFKamtueS9pWWVPWFhrL1ppbzZxcXF0Vk01bUdCVVJuRlVrQk1GOEpLQkdI?=
 =?utf-8?B?bmJBdjBtZ2wyUGt2TmZaVnlMWUF4Q1pQUjVLOGJFa0ozOUk4aHlETG5IQ3VI?=
 =?utf-8?B?d1BvWk5mQmxXVm1JTjBGdGRXQmpDOU1saWx0OUR2S0pMY0tWMWlVRmN0U2hq?=
 =?utf-8?B?dTZlajdQMXQ2TWhDZkdGUThkSUdjMkxVbmdLMm8rbk9hcGhTalpwRGI5blF6?=
 =?utf-8?B?NXJxWVJ1TWFhN25uN1Z4LzNZZHovS01sVG05S1hLb3dSemVkc1VIVGZTL0NR?=
 =?utf-8?B?VEVxbTl6elp3b21KY1EzVjdNVXpmczRuSzdZWThQazEwUGU0YjA3d2NGSHg3?=
 =?utf-8?B?TzV1VGNNOUpyeUpIKy91U1B6VFl0Qlp4cHhramhvUnRIbENvQUZKNGhlV292?=
 =?utf-8?B?Wm5PWCtEVmhtZFlGc0p1Z0dJUXNzdWgwYmZYVTY3ODhVNmpTWDVVUm9TSWRi?=
 =?utf-8?B?S1ZTTGNpL2R2M2poTS9SSjRrQkxXN0prSVhvSVNKUUFaMUNjelp5bFNQWnNY?=
 =?utf-8?B?YTl4VGpOeTF3SG4rSFY4OER2UGdnSlNLN0pBTUswZlk3Q1JxVnVQV1VUODNF?=
 =?utf-8?B?YWlBczR4b21LdXRTRU9tTUpVRmJiUkRHdWR6YzQvZ0VDZUE3dXB2OFYzcVhC?=
 =?utf-8?B?d2V0bzNzQmZqRVNSaTI5Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXVxMHZkRVNqMzM2THdsckV0cldOOXMvcjNVWE1ZbWIxa3FYSzdQK2V3TXo1?=
 =?utf-8?B?RUhTdC9mNS83a3RTYVRjSlFmTkdLYUM1L1d0OCtZc29CbUM1VjZBOEk3QkVF?=
 =?utf-8?B?TWlodU9SZFVOazFZakFVMm9nR2drRGduSno0ZHVuK2IvNEdlSzhndmxpa2FL?=
 =?utf-8?B?UjU3b1ByRFFDMTdkVDZnY3JXdnBHT1VBRHUvS1Q2bFZuOTlLbHFrTmdXSU4v?=
 =?utf-8?B?akEzbXZWNWJ4SEFUcUNkV2dZbmVrVEFzTUVTb2NUc0F1L1BTR0JLWkpWaU9t?=
 =?utf-8?B?SWV5QVVyZGFqNmk3L3JiclBGSXhzWnUzVnkxNHBEb2ltS2tCeTI4ZWN2ZGlL?=
 =?utf-8?B?L0MrOXJHczVVNzRjckRIMzBqclBwZTE5TDZiU3Nrd1ZTNktVVHpBVkFLdzYx?=
 =?utf-8?B?ODdRZGtGeE5LRHV2dUFSbDRHbkNtQit6NnQrVk9xY0VNRFBWYkhSL0k0MlZS?=
 =?utf-8?B?SUNUZzd2YktZdllhZDVwbnU0L1JQSEJ2R3lVZGpQSDVNTWJhSmhFSVc3VDBo?=
 =?utf-8?B?UjB4bVlveTI1RkorVS8ycU1xY2ZwRmw0STR4eUdocG9EUnlEU2dwRTJ4UHhN?=
 =?utf-8?B?VGNYYU9SMFdIdVJsTUdCdXhiRkZBMks4UjNKRVc2ei93ckhsd1JDZFFMSlhO?=
 =?utf-8?B?dU5TeWZMTld1MjQvQ29HMUQwTTRZYjUreGh2cEtkMkMvM0t3VzlBUkd1dFZQ?=
 =?utf-8?B?TmpZT09TNUNOR0MyOXhMMXFpRkZOVVdaUTFwWmd2MUFsUzF0Vjh0djdQa3Zy?=
 =?utf-8?B?NVltZ0hvL2pQdmsxM3lQU28vUWpMMUlTc3BpNEt2Q3VmMG9CSXlWTm9nUU9n?=
 =?utf-8?B?STVYMGdLWDhhMFF0azNocUN5aHpXbW1PM0svTFU0VTEyNkN1ekdocjNobEpq?=
 =?utf-8?B?Y1pZV1huQVFLTlpEY2tGUHNWQlR6REpjamlsMWpWdjV2eE1VazRmSFdJOEhP?=
 =?utf-8?B?ZHdyVnZINURrOG1JTlQ3SFZDcXpOMnVoVFp5ZWNoODd5K1N6SldzeGxtUWxQ?=
 =?utf-8?B?anhXSUw3ZWJvRmdMbkhxUU1vbEdRVWJ0cCsrTWhObWNPWlZxTFpnaXE1Q2pu?=
 =?utf-8?B?QU5nUGZjZGFSYnR5OVRoSSs4VHdBL1JXNWNYYkdiTXE0YittYjM0Z0xTMzNM?=
 =?utf-8?B?K0pjeGkvTjBCNUpjOGhMRHdTcGpzMGZOSnNzUkh0U2ZxMWFJeElsaWdPdG1V?=
 =?utf-8?B?TmZrZ1NkTlJ2WlZ0OHZuTmNyU1RZMDc4a3c0Z2VLK3RCZ3ZrcWYxZVNKZFB6?=
 =?utf-8?B?SnRIMFl2c1Rxdk5KUlFXcVhjdS9zZnkyMWEycDlVWTBIQXliVmtKRVpIR3pq?=
 =?utf-8?B?Vy9pOW5jS0dUMnpKM29NMllmU29ORVFsczVTOTRWdk5hZ1pmalRnUHFCN1hU?=
 =?utf-8?B?Zk9tbWJXSU14dnZPWTFqdWVJVXRubGUvM2pCVTI1emFuWGxhRXF1S1BpU05T?=
 =?utf-8?B?YUViODlJcU1HV1dhRFNsVkF0U2FNbDNSby85eDRrcWhjQnA2MWVnWllOWEEx?=
 =?utf-8?B?MzVuQVZyVHhyM1dqVmRKa0tTcXpaazN2eHB0N1V3R3BMV1AwT3AvRDFUZTVr?=
 =?utf-8?B?SXl5WXFsUmlWdHdYdzJwanEycHlWcjRTemg1aE41cTJrY2g1aGU0eTV4aDNM?=
 =?utf-8?B?dndxLzFNUmxWa0h4SElRWFZQQm9wNmhUY0JZNkZidDhiRmNVRktKWHd1SmZV?=
 =?utf-8?B?ZkYxUWhVWWlSa25vZ2txbm5IWXYxdmVXaVdET2VPL2wyL2paT0Zad0FvOXZy?=
 =?utf-8?B?RHVhWFhTNlBsREx6RGlxL1JjWEtwWjd4USthQVRTbTlvcHFyS2xLbWNDU1Zt?=
 =?utf-8?B?Y2pLNVg1N1JYaGlTY3ZneWpFWlVvS3krZDlnZ0M0Zm1NdFIwcHUzSW9BQTd1?=
 =?utf-8?B?dXJqcENodlZrU2JYcHZBeG9uVW1JN1VFdDhCNHJkbUxuNk5BSGVxa1hNVzU2?=
 =?utf-8?B?YWJuNkYzSkhjeVZPb053OHpLUGFONzNlMkZ2TzNndytTUFZ0Vm9DNWFXeXN6?=
 =?utf-8?B?M0xFUUFYd2luS3N3SzBseFlVSEF2T3Rjc0FhOEFLdmVHQnZuTzZFc0RISDFT?=
 =?utf-8?B?U0t0eVdVWWtaazdxRi9WQXNRV3pWbUVuRE9PU2grZXBVV3JOQk1MazZJUVhp?=
 =?utf-8?Q?U8EgrF3IiJSpn3UcXY55UQbSz?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e22757-0e15-4e56-4cb1-08dd71f3c4c2
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 14:36:35.0958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rUN1vAzk4eqfqHk3n/7KD37drLn3xO1PQ4BA+vnpgLIIv8AssDSo+x5GiVcCzR6ecqybFUupHhBA/JkWm6WTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5432
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

Hi Deemanth,

On 4/1/25 11:41 PM, Deemanth P J via lttng-dev wrote:
> Hi all,
> We are new to Lttng,
> We have integrated lttng in my image ,
> whenever I launch lttng we observe hung behavior,
> So launched just lttng session daemon I observe crash,
> Please help us in moving further
> 

The log you have sent doesn't appear to show a crash or a hang. Could 
you describe in the detail the steps to reproduce the issue?

Please consult the bug reporting guideline[1] to make sure you are 
including as much useful information as possible.

thanks,
kienan

[1]: https://lttng.org/community/#bug-reporting-guidelines

> 
> root@sa8797:/usr/bin# lttng-sessiond --verbose
> DBG1 - 17:44:14.742294853 [Main]: [sessiond configuration]
> DBG1 - 17:44:14.742326260 [Main]:       version                        2.13.9
> DBG1 - 17:44:14.742350999 [Main]:       verbose:                       1
> DBG1 - 17:44:14.742374333 [Main]:       verbose consumer:              0
> DBG1 - 17:44:14.742516468 [Main]:       quiet mode:                    False
> DBG1 - 17:44:14.742524437 [Main]:       agent_tcp_port:                [5345, 5354]
> DBG1 - 17:44:14.742531572 [Main]:       application socket timeout:    5
> DBG1 - 17:44:14.742538083 [Main]:       no-kernel:                     False
> DBG1 - 17:44:14.742544645 [Main]:       background:                    False
> DBG1 - 17:44:14.742551260 [Main]:       daemonize:                     False
> DBG1 - 17:44:14.742558083 [Main]:       signal parent on start:        False
> DBG1 - 17:44:14.742564645 [Main]:       tracing group name:            tracing
> DBG1 - 17:44:14.742571885 [Main]:       kmod_probe_list:               None
> DBG1 - 17:44:14.742578708 [Main]:       kmod_extra_probe_list:         None
> DBG1 - 17:44:14.742585374 [Main]:       rundir:                        /var/run/lttng
> DBG1 - 17:44:14.742591937 [Main]:       application socket path:       /var/run/lttng/lttng-ust-sock-8
> DBG1 - 17:44:14.742599385 [Main]:       client socket path:            /var/run/lttng/client-lttng-sessiond
> DBG1 - 17:44:14.742605999 [Main]:       wait shm path:                 /lttng-ust-wait-8
> DBG1 - 17:44:14.742612978 [Main]:       health socket path:            /var/run/lttng/sessiond-health
> DBG1 - 17:44:14.742619593 [Main]:       LTTNG_UST_CLOCK_PLUGIN:        None
> DBG1 - 17:44:14.742626156 [Main]:       pid file path:                 /var/run/lttng/lttng-sessiond.pid
> DBG1 - 17:44:14.742633551 [Main]:       lock file path:                /var/run/lttng/lttng-sessiond.lck
> DBG1 - 17:44:14.742640166 [Main]:       session load path:             None
> DBG1 - 17:44:14.742646728 [Main]:       agent port file path:          /var/run/lttng/agent.port
> DBG1 - 17:44:14.742653551 [Main]:       consumerd32 path:              /var/run/lttng/ustconsumerd32
> DBG1 - 17:44:14.742660114 [Main]:       consumerd32 bin path:          Unknown
> DBG1 - 17:44:14.742666624 [Main]:       consumerd32 lib dir:           Unknown
> DBG1 - 17:44:14.742673812 [Main]:       consumerd32 err unix sock path:/var/run/lttng/ustconsumerd32/error
> DBG1 - 17:44:14.742680478 [Main]:       consumerd32 cmd unix sock path:/var/run/lttng/ustconsumerd32/command
> DBG1 - 17:44:14.742688864 [Main]:       consumerd64 path:              /var/run/lttng/ustconsumerd64
> DBG1 - 17:44:14.742698916 [Main]:       consumerd64 bin path:          /usr/lib/lttng/libexec/lttng-consumerd
> DBG1 - 17:44:14.742705478 [Main]:       consumerd64 lib dir:           /usr/lib
> DBG1 - 17:44:14.742712353 [Main]:       consumerd64 err unix sock path:/var/run/lttng/ustconsumerd64/error
> DBG1 - 17:44:14.742719020 [Main]:       consumerd64 cmd unix sock path:/var/run/lttng/ustconsumerd64/command
> DBG1 - 17:44:14.742725947 [Main]:       kconsumerd path:               /var/run/lttng/kconsumerd
> DBG1 - 17:44:14.742732666 [Main]:       kconsumerd err unix sock path: /var/run/lttng/kconsumerd/error
> DBG1 - 17:44:14.742739228 [Main]:       kconsumerd cmd unix sock path: /var/run/lttng/kconsumerd/command
> DBG1 - 17:44:14.742748656 [Main]: Starting lttng-sessiond {3cf95868-38f8-494d-963a-0c83c13262dd} (in sessiond_uuid_log() at ../../../../lttng-tools-2.13.9/src/bin/lttng-sessiond/main.c:1437)
> DBG1 - 17:44:14.743890166 [Main]: Resetting run_as worker signal handlers to default (in reset_sighandler() at ../../../lttng-tools-2.13.9/src/common/runas.c:1377)
> DBG1 - 17:44:14.743934593 [Main]: run_as signal handler set for SIGTERM and SIGINT (in set_worker_sighandlers() at ../../../lttng-tools-2.13.9/src/common/runas.c:1438)
> 
> 
> 
> Thanks,
> Deemanth PJ
> 

