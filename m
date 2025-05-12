Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0F3C3ABD7
	for <lttng-dev@archiver.kernel.org>; Mon, 12 May 2025 15:18:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4Zx3Cy1BBQz1jGF
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1747063136;
	b=eoBBQ9ytEYao73Nozhw7F1nh7JvT0xgrTeRcB1htFhYOx5R9F9to76FqaoYcxgFxgyOW
	 SlcMwuZFZg936js3VCMscIZRLWJ4k1fQyMLcwb4IOtQGZi0Xait0R049XOXRQHo6oNy4v
	 6F4A2DX9dV8mSSS63/2ku87rffxi+IgfLCZqUi7m5rO52qbVdQJfLrtNPVBaXS0RmYSGv
	 ngxxiZ4FLAPCKV4PENNe2dO1YtHT2lnvOPlmRLIJOcSEMA3U5K5eI4xqlt7eeui9MUgca
	 Br15IR9rtPlFyoZFQS2hCHfjUO+6Jcp2mSk48AUS3KcwZau0O1ZA7rUnm3htz+N0eow==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1747063136;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=bEFKwP6GNtpPh5oqrsW1olcafL0T/8dsxW3xz9zJnz8=;
	b=ZBEPGMVgqcXwzjGjxcbutIMihG3zrhbdZ9mp9y7S4UGwD/Zbz8FkRT7jY0IqtTqSfFg2
	 PeeuKIZn2E+LhdsME84MpXxlv2ds1ahww7ylh1pIbrEbgvNrutDjqe+/9uYLpS7kOwNRD
	 JPSdgk7dVZoa1VPgvCrOK3h8CTf/I+s2ujSkKdj2DQfniskERLANsVMV6miF71SSuK3zI
	 Tli7a3y9VtZD2QCpMqln6DaCHaD0TqoxQ1wV6/+YKjo7tqjRByxhiG2eHhTqPpbYXq/hs
	 no3cAFSVgOBW0ZtdL0TCtz/J8Pk3oetH4x0RySyK5Gy94A3d2mY/ZggcoMXn2nLy08g==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4Zx3Cy1BBQz1jGF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1747063136;
	bh=bEFKwP6GNtpPh5oqrsW1olcafL0T/8dsxW3xz9zJnz8=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=i9M5+CiaTYzmn6rsAuyRW32a3MRD76BxtOOrXSE1wF0SuczesDnYfZyTBf9IufL3v
	 /tSKePvT+nKCp/xR1Wd5GI+p9+yT9Q7+38fdLcL0mYe9fHqIY3rnZyUevGpnC57rp6
	 q225qYolyuslCfVTNuC1G2g4vSs4gbTZjpoJahLNjG+4Z7gu3oVDabL6UoyLf9oY0J
	 Zd/soDNKUEkOaP0Ex6BdxMkdnt0gJiOWff7HToYz2kUAQhgvOj5Wow2bWfc94H1nj9
	 Rcz9uuEBF5MG/U7Y/b9RLxMrq9YGDMOrRHMaVpZNw1kFde5XbdEdB3mQ20kmVpR1Uu
	 YZCJgNYMVB38A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Zx3Cy1BBQz1jGF;
	Mon, 12 May 2025 11:18:54 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4Zx3Cw2vHHz1jFY
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4Zx3Cw2vHHz1jFY
Received: from YT3PR01CU008.outbound.protection.outlook.com
 (mail-canadacentralazon11020140.outbound.protection.outlook.com
 [52.101.189.140])
 by lists.lttng.org (Postfix) with ESMTPS id 4Zx3Cw2vHHz1jFY
 for <lttng-dev@lists.lttng.org>; Mon, 12 May 2025 11:18:51 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZxIP4TzGx0vPWiLKr59EIoJY6aCNyS2FjQR6sbD4cexR5qsOv3J4A9lQYVdHJmAOET/BWJCJbyEQnJkWdNViRsHLoK0iAcqUi8sIGXNdTOIKBZZCMjuUGQ7cMXdsUCYxnW9JjKLiKRrwk5wxaNz7FqCw/u0Qyrw4n30cyGFjaMhIGxGfvQyS9yZfAhugrrf3CngM7MjZfk8D5Kr/AWWEl75amcf8U18PhB+BVzLMyjRMbUsUblfiVUFFeVU4pFWhjk7zNuHj5wRaAF4VMBOegYLIsYcg+lGfLAdkI9UiIjS617i1X6/5YPOPuSYwTCy9e5iLJz4sHClPqC/tItt6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/jU7RL1OHS+LSU5kVM8HiiwFrt2NbP64FV+/qyidfI=;
 b=NVxrjIILyCXjb3VUGC8la+HWMmsDnMVkkVwcckKnddc6b2z03gXk21pSyxZjToUl9YUOLjF9akPJCxJ3G8UFLmJB0gs/plcrqkuysSc8dnD3lV3F2J62eFId3yMlismRxdpQkQrhQMhFwv/Jy/EPZvS+QUCAOaY8kx2DKBCmIReI6IW1mHmvTKgWcxEp6XpZ+H0NOu07EPIsdyXwtEL0JK9o27r/idxVX4/CeUob7QJ5o1pRFTfJACzgp5RmF0ovVVET5J38d4L4gHccYfK05TuE34loUM4gVOujIo3qRfD4tPLuyFS3w53r3zCYmTMzhBc2qwX6qJyzsl8yXszcXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::18)
 by YQXPR01MB6669.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 12 May
 2025 15:18:46 +0000
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf]) by YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 15:18:46 +0000
Message-ID: <c42f4ccd-5e16-4a7a-a9a8-19e61ee06b1b@efficios.com>
Date: Mon, 12 May 2025 11:18:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Understanding SOFT IRQ 1
To: David Aldrich <david.aldrich.ntml@gmail.com>, lttng-dev@lists.lttng.org
References: <CAJK_iegCiWpZcD8fyLCpkRtzOzv_nxyn8WBUs9gr5WDYQ1sK_w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJK_iegCiWpZcD8fyLCpkRtzOzv_nxyn8WBUs9gr5WDYQ1sK_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0165.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::8) To YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9171:EE_|YQXPR01MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: 356226fd-4ede-4f4b-33a9-08dd916849a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmU3UkZ2QUFjdElzVHowSzg4NkhIVTdZenlMcURFc29oQnJQTjhVZG5jbXg1?=
 =?utf-8?B?RXphUFhUVFlSbmRiV0tNNGNENjBDSFNlTnl5M1F3ZkZtNnI4OGxzUUUybTJC?=
 =?utf-8?B?U3ZHd2ZTU2dlU2RnQ3BMME0wenpmZVNnUlE2aSt3K3dQQkFxYTEyNEdDVy9I?=
 =?utf-8?B?OXE1NVZ4YmZmdDlRNzBURmd6Q2JrTGdiTVRYZHc0ZnYzTkI5dXl1Q0lmNHVX?=
 =?utf-8?B?TXFRbnN1ZXF1a09aWTR4SEJuMnAzWHE2SGVMbDhzSjJGRmpKT01lWDNuU3dz?=
 =?utf-8?B?QzVQTXNBSjJFTmwxT2o2WW1KTkgvYThCVERHVGJ2SVAvVFduK2dYUXFTTnI0?=
 =?utf-8?B?QmFURzVqQ1hIdHdTMCszV1duYVVYTkJlZjV6WFZqbitrRUd2TUptODgxbVhN?=
 =?utf-8?B?VW51VzdxVDhudmJPK09lbThUZlNWVHlYS3BSeWtQU3J0Z0pubUIreG1OL1hS?=
 =?utf-8?B?MDFhdzlMQ0dZTDkyN0E1Mk5nNlZrVVJkRXJ0eFdsWmxVcXo0TlZiL0xSVmEv?=
 =?utf-8?B?SmozSWdqa1N5T2xCR2c1UDhhYVJzMmtRUjRJZzg1eTFFRlhQK1ZGR0E5d2tD?=
 =?utf-8?B?dDAvbm9yTkJCTVZJOTIyc2paRXJMY3g1dVlhV2ovRlNXMUVFd0J3UmkrbTJy?=
 =?utf-8?B?NEVOTHBIejJXMEdwUFVsbkYyOTA0NlpqSkRiYkVNQ1pLRWFOV1ZSUDB4anVG?=
 =?utf-8?B?emk3bzZWaStxdXFvRnRCc2E3Q1d2T0pnYjc5bm5PdGN2K2xYZWZmYVRQd0t5?=
 =?utf-8?B?ZmV3YlRQb1V2NVpYNWpDbGNJK2kxazI1ZDdOQ0xSTkVGQmZFWWwzMldRN2lq?=
 =?utf-8?B?SGFldERuc0hLeUxXSUo1Tm1XM2FkdkZJWERhQllyZFhhN2pwOWRhbGRWRjRy?=
 =?utf-8?B?dkpKR3YwOVk4ZDZRck4rM2lYZXBEdXBpOGRYZjBDZy9xaUJpR1Nmc3h6TjFl?=
 =?utf-8?B?WjlZUThYTXVYSVhCOEJ0YnhOditCalRkYzc5ZGw1eFVRSXhZNURCNXhoMXAv?=
 =?utf-8?B?L3JiUms0QzdrRXBYd2lNaGZKQ2dSUU5UQXpQYk9EZXBxcW9jSGZXR2I0Y1lv?=
 =?utf-8?B?cm45WGRjV05jcW42WllWZ1J6M2F1cTFsNk5ZV2dEQnM1RjVldGpSbjJYUnFv?=
 =?utf-8?B?T3lDK0NQWHRWWU1xRVlGUW8rZ1NSdnJxY0owMnJyU0xNcVRHeVl1VzlhVjN0?=
 =?utf-8?B?bEtJOHJsdHBUTFZiTjVUcGFwNnFqNlF0dVhJZEtOVzh0WDZBb2kxZk9lSHhl?=
 =?utf-8?B?eE45Y2R1Q3VaaUFKL08rTVRadzJoWHQ5Si9QbzZxM0xYR1NzaDZpR3pVckE4?=
 =?utf-8?B?SitMZ200V1plTThWT0xWR0lKbFo0Z1p1aytXVHNaNTlEUS9vNnhMK0NGSm9C?=
 =?utf-8?B?M0N4QXdDVkVJYkt6TUpESVF1QnZndGpRZ1NPTEVwc2tHSDZPUVJmTmU5ZDZC?=
 =?utf-8?B?TmlXSGpmMFEvVUkvaXg0QnpVZDZ4NkJ4bnR1bHEzZWJEei9vaFZzN1Y0ODls?=
 =?utf-8?B?SUJ4dnZ4NEw0VHpvWDJTYlBPWmJUdHZvZmJzeDlkUXlkNU1ZVGNTWTNlNDV4?=
 =?utf-8?B?aFhJNDBFQnQ5RDFmd2FaWVdUWENYR1o4QlRibnpncHo0ZytaL0dTMzUxOFpn?=
 =?utf-8?B?VDZCcDg1MVhwUWZSMGJkVld0dUxSVmh5eTlGMndnZkRVVmovSjUrclB4cEdP?=
 =?utf-8?B?b2VlVXg2V1RHNWFJMzY4MlRZM0xwUVhFMzlSUEFaYlhwVzVoNVRFN3N3TEdG?=
 =?utf-8?B?SGZjTWNhcXJJK0taV2todkllUExQZ3ZFVXYwNEZ5NGpOMGphT1BLSGErUEZV?=
 =?utf-8?Q?AQ5jHw8OAT+eX07ZhAmGmXqIE8ySkVl2L/s4o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzVlNzhUaXVLZzR0Yy9qeGZtRjRkVjNtbk1QR053c0ZhZUJ4c1FrZGZEa0Nz?=
 =?utf-8?B?ZEVjUC8wOVZMdG1BUWtUczJ3bjVLRzFLQjg4cEpYRVJkRHB4VjhEckI4Njdn?=
 =?utf-8?B?bDdtQlJoN3JFdmtRai92VkV4TS9HVmg2d0ZkK3NwMjNVdGxBWkFZczZxMzR4?=
 =?utf-8?B?dXZZWEorRkJLM3F6Z28raWM0Q2tWRkRaV2I3N3p4Ly8zNHFlYlZHL1c5RGJi?=
 =?utf-8?B?L0FsU2lqTDJKV3kvWlNjbUdDbGJ4TFRBZ0tpRlBPWVkreEZPa2RGZ1JsbEp2?=
 =?utf-8?B?alM5RDB3aHo4WkkxbGRWSEF5UnB5YUswdUMrZ0RjeUxWbGJ3eGZFbmVsZXNM?=
 =?utf-8?B?WWxWay9TeWxtWlJyOC81N3FMSnZJeEpKWmpYQStoOWwrQXZmbWFJdDBJQmxB?=
 =?utf-8?B?K0R1Z0tXamo5dVRnOEhkaHEzamtudVdLL1lLQ3NYR2JiVWRnaDRVK1dRUm01?=
 =?utf-8?B?MkYyM2t4Tk9IdERhRGlZNi81ZWUyMDg4amFRZG1BY1YxQUpIV25yb0FoajBV?=
 =?utf-8?B?T29NcENabzNaeUx3VEc5SDRJekhTVVAzcWJ5Q2J5YXBDRnlUZ0RRZlJ6U0xO?=
 =?utf-8?B?S0lvK0tIWG50Mm4rLzJHY0d6eElsRVZ1dHdaRTZQcXgyVjZMbzBWVC9WZjB0?=
 =?utf-8?B?d29LUEZxUzA2VjhWck5tekNPcmxKNVdXZVVZRXJNc3hpOWIwMFFvQWRKcmVX?=
 =?utf-8?B?dWc1YmJoblpra1EzL3ZJQnQ2UEJpNE5DcTQ0SjNvVHVkS1FhWUZhdkQ5TXVi?=
 =?utf-8?B?dVBNclNzWGhPSkZLYnMvQkMxTmM0dDBYemxHeVVqWUt0RkxyNXdvTTB2UjZU?=
 =?utf-8?B?dTBEL2wyNVNaNTFES2hJbkcvU2xWdzAvUW5VcXJZSHNEMDZ5eklVRXhGSUtw?=
 =?utf-8?B?R2FObkhCYzM3T3hNL2w3b3MyY0Q0cmFJRHB2eVJuTk1tZTVGU3EyTENlVXgz?=
 =?utf-8?B?MG9SZUVwTG1IOHlZdCtBY25qdGdaUTQ1a210WjdROUxLUy9Va0FCVVV4TDhT?=
 =?utf-8?B?VHlrdUM1SzhPeUNGZXI0S3Jjb3JydUN6QW5LczM1bGZ6Qzd2UDN5QWJjQitv?=
 =?utf-8?B?WnhxOUs5Q0krSUgraUlDc2Uvek5kaXZNc3U2djM3N1pCOFd1MVhLbnFBckJl?=
 =?utf-8?B?RzY3UVVMcldvZXZnYWV3ODJ2UzlGM2FIYlJPdzhuYjdTR0haQktWbHVIcmt5?=
 =?utf-8?B?d2IvZk95SzB0T2ZCSkdVVlpkLzFXeGlGVmIrYW9YTTJlNVBESE1LUnBCeHl0?=
 =?utf-8?B?K1NYUko2V1dOYnpPOFEwTjNQNExJWVM2S1JSMUUyY1BwVW1PYnQrR0Y2d081?=
 =?utf-8?B?VGNTdWJ1cHh5cFBZdkdqdjRqRUljUEtTbkE5cFhYUURRYUhzMVd0dVZWZ1Vj?=
 =?utf-8?B?cC9PbzV0WjdiZDVZbzBJRnQvdy9pUlp2cGdOYUJJaTA2RC8yb2tiWEc0Unlq?=
 =?utf-8?B?ZzVhR0l6TTRjQ3dNWUw3aUl0TWZyTURleFFWMHVLTmFxakNOKytwMnJ4Q2sr?=
 =?utf-8?B?eXVEMXpBeFcvZ0FKVm5zVUorMDFSME5DWnhRanJJdWg5Ymd2bEZIVU1CaFZK?=
 =?utf-8?B?cWZ6SVg2aUpPRUFjSXVmNGJPekxFVEdjMWxQM0VvSlN2Uk5EbTdSVWFpMEl3?=
 =?utf-8?B?Y1VYT2RjZm5VeCtXYjNlUlRFay90VitkUXV0YnZVeCtjZDNtQ1ppbTNqeFE1?=
 =?utf-8?B?Y2paOWdtV08yRkdMTGh0M3NYUTZiUEk3anVZdVRKZmhFN3M2MmRTN21sbmdm?=
 =?utf-8?B?KzRFeHRPOGplYTZxdlVsa0xiYVZiUXB6elBkNWR3TFpPcC85RjkvaVlJZk53?=
 =?utf-8?B?WHFXSWJJMDNTVEJZaUpTQWZPaHdFaGU5MndRQ1BnNTRRTFF1NjF0RW02Y0d2?=
 =?utf-8?B?b21JSmdiRFh0SlRNclJBWmdzRzlMWEV4SlpJdWtPbXdDcmFSQUhqa2NmVUlk?=
 =?utf-8?B?VmIvamxHb0RqcVYvaXRIMUNwa3U4T1lHUlV4QnU0c3JPZWs5RVMxUDhXVnVw?=
 =?utf-8?B?ODlIUy92QVV0SHhORFlTeVplUFNBSGNxL0c1cFM5YVFUU0Y4cDNoTVhDNE9E?=
 =?utf-8?B?VWd3MmtIWndrTTdvZFpzWld0LzMyenpkbnV5VEgxV09jQ3BBUjVBcFpLQkJQ?=
 =?utf-8?B?ZnhlcXdkckU1c1hUbUE5OVAvWkREc2VKYU5uWEI0bWZvRXluRDVRYW1CSDQw?=
 =?utf-8?B?c01uRi9MNXoxcXEwWWMrdGI1S3dRU2dVV0pXVHpnZEN6MUdzQm4wcFpMZ3lJ?=
 =?utf-8?Q?9XVujjd/t1TNlRpn4egkuwIOTSrI+JLhJQQNe+iwtA=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 356226fd-4ede-4f4b-33a9-08dd916849a1
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 15:18:45.7855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9706Ty0Rv5psCLen/9td0mTYNBl6cVBXWHCH/VMiQYA+aFK6C3To9w+GQHc84XJMIuYpZXEPCAW86o3V6i3ipya7NgLkTvZMb5IsDHaC+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6669
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

On 2025-05-09 12:00, David Aldrich via lttng-dev wrote:
> Hi
> 
> I am just getting started with LTTng and Trace Compass. I can capture
> Kernel and UST events.
> 
> My purpose is to investigate why a periodic task, running on an
> isolated core, has occasional blips i.e. it's period (duration)
> extends.
> 
> I have inserted tracepoints to mark normal and extended durations. In
> Trace Compass the blip tracepoint is preceded by a brown state that is
> 'SOFT IRQ 1'. This extends down all cores. It lasts 105us and is
> likely to be the reason for the blip.
> 
> Please could someone explain to me what may be happening here and how
> can I find out the reason for this SOFT IRQ?

See include/linux/interrupt.h from the Linux kernel:

enum
{
         HI_SOFTIRQ=0,
         TIMER_SOFTIRQ,
         NET_TX_SOFTIRQ,
         NET_RX_SOFTIRQ,
         BLOCK_SOFTIRQ,
         IRQ_POLL_SOFTIRQ,
         TASKLET_SOFTIRQ,
         SCHED_SOFTIRQ,
         HRTIMER_SOFTIRQ,
         RCU_SOFTIRQ,    /* Preferable RCU should always be the last softirq */

         NR_SOFTIRQS
};

So SOFT IRQ 1 would be TIMER_SOFTIRQ.

Note that we have a TODO in lttng-modules:

lttng_dump_softirq_vec()

Implementing this by dumping this softirq table mapping numbers to names
would be a welcome contribution.

Thanks,

Mathieu

> 
> Best regards
> David


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
