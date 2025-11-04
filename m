Return-Path: <bounce+b7b410.602323-lttng-dev=archiver.kernel.org@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from m43-10.mailgun.net (m43-10.mailgun.net [69.72.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686C1CCFA04
	for <lttng-dev@archiver.kernel.org>; Tue,  4 Nov 2025 20:17:33 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=lists.lttng.org; q=dns/txt; s=mx; t=1762287451; x=1762294651;
 h=Sender: Sender: Reply-To: From: From: List-Subscribe: List-Help: List-Post: List-Archive: List-Unsubscribe: List-Id: MIME-Version: Content-Transfer-Encoding: Content-Type: Subject: Subject: Cc: To: To: Date: Message-ID;
 bh=9HNOfikLJOGTo7hkLPmB9+B4GFyLkxXP85HqJ8oeaoY=;
 b=qpgtDSKuRg4WMbRsobtl2PHn5QyiWFLLBPBUYrwCCj/puhgVjBJETJtT2zQuTd+yzBBaOQx1ZTMdZRkxi7PMybX8ipAw2/Kjnlutb8LVNll8+Tx0N8nE+X7WuzMGe8Q7ymC34QBRz1nqqz2RXOW6nt9lc/YjUDIYGeaMviTSv9dco3MfxDr8pT3XfbSaBVeVizsK/nsb2ofrZ5lETG/VrosqljHehZ9zo79TMez8mwv2jRQt8jF6nGYCsn+Vxi2qpvA3IkLjNKylCzATp7klRsSem8lihNNicCofkUeddWkiROwJ9YEwr+xnDI6fzg/4LltRq6CdcYMMSBlYlxUdcQ==
X-Mailgun-Sid: WyJlYzgxZCIsImx0dG5nLWRldkBhcmNoaXZlci5rZXJuZWwub3JnIiwiNjAyMzIzIl0=
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29]) by
 752a9ed0a19c5b3a6b92ba7e3594b812f6091cb00ad8eb23236ba801d3ee5852 with SMTP id
 690a5f5b2070a5dafe4062a5 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Tue, 04 Nov 2025 20:17:31 GMT
X-Mailgun-Sending-Ip: 69.72.43.10
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4d1KWF1LqXz1qyR
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1762287451;
	b=ecNZPfaaGD8jh3OAE9hZnJu0NdJAVR8eKp5Kb3yVKTdgRWxXiXmAAVgOl6v8A2CUdP4r
	 4dZtqNzTUkKA/HeDz/1GODJshKJG5jh1Zi0PH1dE6mg54+IyleekYM5qLt7dWRwYMg9rY
	 mtOqB1dWVdbpaPfUUvJ017+MMYNAueSQjcH1kOMeUB0bBS2GEUBKNo8QfIq5dZnlh13tf
	 QJ5EJEOIL6Zs2G1j+ucNBUAujvl7rMaFGKp+iO30qxrfNmgU3QgNYfLOWVdMWNrtXpuzL
	 kvnZQjPSg5R6Ufv+4X+0DOa1lA7YOfrv/L7H/JHcd6zRnZ9BneR3JItIsQGwZMuP/uw==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1762287451;
	h=DKIM-Signature:Message-ID:Date:To:Subject:MIME-Version:From:From;
	bh=mjtTw2N5XTMSS/AuB2ACB0dEtH7PBjV/Ozy7SOBLYss=;
	b=nx1komOsZK1/1BrCFxsyFwHFv3MZew88eUmewFNzS9H0kIl4XQ6U9nVeM+2XFp2hTbiQ
	 Q3AnPolTZKP+QdwTJiuvQwNfETFCgPTCrdCIcNFNNjW/YcGkXTOZmH4Pf/8PZPSvhGo+C
	 jadR8NeThO755ExHWNrIbxifrt6wWX4qGAEImeM6TP8eyGmdZJg40cpKGCtrUbJLw2URk
	 I81UsjIlqOWNIiLpRLms8Hkl930reXJNLLfIvlFiZLUfpXGniuRlas16BOtn1kPsCpEXi
	 wMScZWXZzu9BcGHTkO15s5ce5oXYJslH+sm5yocN0MyO6k4ZIOYqLXAOF921OBFcGTA==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4d1KWF1LqXz1qyR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1762287451;
	bh=mjtTw2N5XTMSS/AuB2ACB0dEtH7PBjV/Ozy7SOBLYss=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=ltijNdHbCDMb79vt9n9xK84jP08fwCEnbXs0a3P/swTRG4bbmk4WemVKZUhJLurNW
	 XnSObzFVcYSVz881jmHAM+tC3nHa0G7RQVdiOHoNnlEmrU0hyeE8JUld1sKAbFmQjD
	 XhteJXt6r1Uc7/z9S0Z+G2jzF3ZBdo+J6q11eWAMfRzy2++QFtPjtU69pMnZsicHhv
	 /I1yCqHbAyycuFJPPykP+BbDUCwKhrMxYBMK4FIU0amY4YwJ3ulOMFDXCmN4IEbsFZ
	 BMzRu1HIlIVNdQ8W/701Cwv4ZlkIUaF4DaT10YKq20HDJ3hDGmdVlRdmHk3EY+faQM
	 FABda6b+iUmDA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4d1KWF1LqXz1qyR;
	Tue,  4 Nov 2025 15:17:28 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4d1KWB35zKz1qSM
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4d1KWB35zKz1qSM
Received: from YT6PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazon11022110.outbound.protection.outlook.com
 [40.107.193.110])
 by lists.lttng.org (Postfix) with ESMTPS id 4d1KWB35zKz1qSM
 for <lttng-dev@lists.lttng.org>; Tue,  4 Nov 2025 15:17:25 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhO/wZi2uR3qpMRpBhy88gGOzCTpw+Tg6+tzYDTG8wKlK+8xFgBjGGD5wK7nh/hE9y9Bf3WWDcvmKCnUQp2mGYPai+2Q8dgl9Q0In3uZ7HRYb5Q5tbke6BM12m4/NWlrsEwTnlBIBCviopr6t90EGP/pu4UhWyhtVtuP+rVpSFROgfYDvKzd+6cd+U3Q6bFGrKDuhvVfPZ2EJi2VcnQZmAjAE6aPBjLUjmEP/Gn8k1VtmpKpJUwEDSeVWhaUPHqyuEU0z2UI4ja7KYq/IZ2ERZauYmn6QbxOjlSNkrVPKt3bdz9bcdHa0RaXXVQotRjDaUt5wMxAZ+XTAd44R1TD0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HNOfikLJOGTo7hkLPmB9+B4GFyLkxXP85HqJ8oeaoY=;
 b=ZVCWiQnCuynKV2PI2pFZYzdmZUiFJRVA3x/NQvyIB3SwkxJWljwJBJNBCrfwamK3EBmV+qUDfaGlkuLWjFD3AvyXZJ42QvuWr//1/f9z/dIq2ClcOGaECLGJiK1LXGzsDNk3/Jh6ULpkypUdKTQj6XEHj0quj6B18I7PtH+oklrOv/WjoZA7YqWw16gBY3D4+/zu8HzXYoKTk7kMhjEWgUIndkd4foPUijHU0xyX+CU33CU5wfRbPmW7IphM6cYAiBSfAZsTcN/5YDhCNLYyKRjK9exXfxhu8rdha8poXdK93NuQxBPQ6XY7/JQekovNl1ObRcGHuoAfuCWaQjJaKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PPFEC9C76D91.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::49f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 20:17:19 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 20:17:19 +0000
Message-ID: <43ad1f76-3682-47f4-b3c9-62a94053db3c@efficios.com>
Date: Tue, 4 Nov 2025 15:17:17 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [RELEASE] Userspace RCU 0.15.4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0402.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::14) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PPFEC9C76D91:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d281a9-3adf-4f8a-08f2-08de1bdf277d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ty8yYXg0OGpkbmNxWEpNK2RFUVZ5Mmdia1FlYjlxVTRmUWNKZ2l1bUJCVlNM?=
 =?utf-8?B?RnMxV2t3ZEQwemkzckhHMTAyY0gvVzhlM2Fpay9EQkE1UTh5anpOQ0dUVHI4?=
 =?utf-8?B?dHhPcXJnR3NadHNkWEdZRHhTbWJycjA2REszSGsxQnJ2bS81KzRKbXpKdHZZ?=
 =?utf-8?B?UkZUY05JMUxOZERoSXJFeWpJRHYwejh6RUp2VWVVaHV5Q2tBc01TelNtTHZO?=
 =?utf-8?B?VUZJNGFnWkFzSDY2OUl0N013MlJiYThLMDc5dHA4SFNvVWtuSW8ybVR3R0tr?=
 =?utf-8?B?aXh2UnFNbENSQlVQU3NjRlJ2bDIvTUdUWVNvOVpwdk84MlVxVlFwck1PcG5i?=
 =?utf-8?B?S1FTSDRZdWROaXlYblZXU0ZGNmpIY3lzcERDOTUvcXJwcG1ZV1k0V0JWU0x3?=
 =?utf-8?B?NC9EeEJNeEFDT1Q5SmNudHdhY3FseGNTNUVQbUplV2VXRlg3WWNaWndWTVA5?=
 =?utf-8?B?TUxNQ0lvMnhNVUlLRkR3b2lwZ0NITENhbVI4VTFoQzd2eEM1dmhXeTQ2aC9Z?=
 =?utf-8?B?ZVIzeDlBbVdIQUFoMmlacmlpVVBwbTdObTJzTmJaSEdGYzFSVG1SMnFySjR3?=
 =?utf-8?B?ZHh0a1JzNXVZNFVyUUVkcW8zci9VaFI5dEVIKzdjcHF4eklManNndTYzQ2ti?=
 =?utf-8?B?RUEwV0hvbGF5aFpDV0l6NzZsVEFOMG5rSXhjNXEyejFDd2QrYVFtdEJCWmJv?=
 =?utf-8?B?VFZtUFh2aGZBeWxTbzNrR010dzdHbDAxNHJJR1RUMFhaWkR2cUszcHcxUjUr?=
 =?utf-8?B?SnJVU1FLUUVYVStGRTN2Wmt1OFY0Mm9yME1yODFmcU5tL2p6bTA3YitqK1ZG?=
 =?utf-8?B?eWZTQ2UvRVhMcmRqZ1hoOWdZT3pkWXdpQTg0ZFBJMU5wdm1pR25IRzlvOGdG?=
 =?utf-8?B?NGxmK21veEl4UlV6NHpzM2VycGo1MG1BV05VdDkyeUlRc2diV3krQ0p3ci9Z?=
 =?utf-8?B?YWVSZ0h1Q1FLbFNWYlRpWUY2dFVSMU1hV2lMd2JsMUF0Y0c3WlFURzIvNGw1?=
 =?utf-8?B?VFJtZnk5UDhYNjBHczVvYUJ4WnhZd0p6cmJ2SlcyVW4xdG5hbDRIVDY5TlZO?=
 =?utf-8?B?dERBTS82QVYyL3ZLdmc0NHNuU3oxaWJyOHdaNkJsRnJ1dDY4VmVCaGtydSto?=
 =?utf-8?B?enhlOGRhcXhGTWlnTllycVFJUG1MYnA5UmZDZmNRWjdGdHhBYzRmTFNhWE1x?=
 =?utf-8?B?RVJwNDRlNWJFVy9UNXV0NU5oZjBwOHZKY1QraTRNNHJOZ0NUS2dzZ3gyNkkx?=
 =?utf-8?B?NXpMV2I3aWxwS1Q5YytoMGxLVGJqQjMwUUNicGZSWGdBUUMwOGliV1RrOFVu?=
 =?utf-8?B?cmp1WFJ0Z2lSL3dqQnpETUdzTFpyZE56b2NmVWF5Nkdtd1dWZXZEWVYyc3VG?=
 =?utf-8?B?SlhYR05uK3ZETmxXSTNzTzR1VUY0V21YM29qWWxVZnk1ZkpKODNEOVNZVGsz?=
 =?utf-8?B?aEI2REE0UTduRE05VlgwcUVCY3BLbjNSVWJydXluemdFMVFyRDR0Q1YzZWRO?=
 =?utf-8?B?VENtTG9xejdBK2dFb3FZdVh3eTZDZE16anNMbklKOVZKRjJtTUVyMjNtajlK?=
 =?utf-8?B?TzhoTkJqbEdZOExLU2d4aWE3cGlCbEoza2J1bXBVZXBkcGpBV3RZZDdhYjFa?=
 =?utf-8?B?cE5adTN3UVhna1BhZ05obFBTcktrS1o2UWYvUXFocHNxU21PSGpzYkdXZ0tR?=
 =?utf-8?B?bS9wSjFiUm5jRDF1alZpdXNkOXNtNU9EMmc4NjFzRU1WYXp5N0VMcEp2R3FC?=
 =?utf-8?B?SktiMWI0Zkt6ZkZmMjhpZ0NBVmp6cDdhV2IxZmRCL3FEbkpqaS81RUt6VHRT?=
 =?utf-8?B?aE9sc0dTTXROekQzWE54a2wwUEFmN3REQWV4c2FySFJFZTQ1UnY2YUZSMm9u?=
 =?utf-8?B?SkNXSmJKdk05L1Z5YWVVT2pkM3VjR2FiMVBscUNld2JHTmc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NERtU3V3WSsvSXhhZlMwQWRXZnZtZzJ6YXZwdXl0YkwrV3ptRHdYRjY0Y0xk?=
 =?utf-8?B?djlKQk9TNVkvYnNja0xDU2Y2cmlXby9IY2xFWk5MeEZ2anFsUE16eWt2MTM1?=
 =?utf-8?B?YmVrVUtlbFRkaGpheHJFOGpuSlZmVmMrelpQZDBZYnl3R0F6Y202VWtGYW44?=
 =?utf-8?B?TVNFbEJDZGwxNzJDRURiTlhnRFM5UGl6OGtybHJnenAyanpHT1FLUUJweFV2?=
 =?utf-8?B?b29ZTDc2dmJxdWxoMm9MYThoNk05T01qRVhDWXpYOGtPTUdsb1R0b0dmZnBs?=
 =?utf-8?B?Szh1TXkvMmU4RWUvYkJzWDlaRjI0QmNIRThWMHVQbUY0Yit5RDh2bGVhOVYw?=
 =?utf-8?B?cjhIWkx6MjF4enRQeTJqVTJUMjdmY2hvWEREQXYzQVJDN0h1RzBtbjl0ZUtQ?=
 =?utf-8?B?TzdEV2Zrd3FNZTJVZEVmZFRSTml1NG5yQjJpTHdSMWtDT1pSemJGZ0hsUEtY?=
 =?utf-8?B?M1hHRGRQRUVwaUN1Y2Z4M3dWdktvNTZ5SVAwTzdDd2R6aTBnWW5ZSVlVaVBF?=
 =?utf-8?B?ZkNPRmU0MWdPNnhmYm1uNytCOWU5bUtQNFphbGluOWhwQmJZMG5VdTA4dlFq?=
 =?utf-8?B?UEZoNnBjMVFGUUZmZ2hmSzFMNkVvSGdncnQ0eEVXVGIwQ2QrMFF5WEJRR1ZN?=
 =?utf-8?B?QkNHMDcyR2NwZVBhTTJWZVlXd3dKck93akxLRjBiUG9waUxLcHlONG1GQVgy?=
 =?utf-8?B?T2M2YnZuMkdVc1pEQ1RsZHpkd2RTYjNWMWJlN2NGR3ZDK2xrSWZsV0E3T3FP?=
 =?utf-8?B?cDYzQWNpMTc4bkFHUnJzYWx1b2pmbE1wMnBFZ1BwdjJQRkZyQ0E3S21wRWMy?=
 =?utf-8?B?blZ3WjM2eGZENC80Yk9EM1IwaSs2TFZtYngrbDFSNXJLbERuUmg5cm4walVr?=
 =?utf-8?B?TGVhRHZBYVpFZnU2eUN3b2duUHBucjJPSXFydlBGdThNaytIeFAzZ2h0cFN0?=
 =?utf-8?B?NHBpNWlyVWNrSDczeEhmSmIyZkpYa1M2Tzl6ZDdhcEVoWjh4dW9nbjEyTXk0?=
 =?utf-8?B?OUY5TkpEcllocHJpMDI1QVQ5RGMwWGJneTg0QTJDVkpNSU0zTkgyKzIwVVZW?=
 =?utf-8?B?WnhqZjRPTW5mS3ZDMk9aQUp4ZVk4Z0NRQVZnZWhJaUwrOERzSG9QTDdBQzRi?=
 =?utf-8?B?RkZMQ0VubkJVRGpWdUt4RXFrL1pjelFwRmtnRHViT213bmg3UUFmS21jeXFW?=
 =?utf-8?B?cDFjQ0ZjNC9uNkNjcHYzNjIwYStvOTNFOGplTHM2aGZCZWtQemdPc1g0Zis3?=
 =?utf-8?B?QmJrOEJWNUttNTBuejlOSHdkbVM5NEp4ekhkRWlYLzJHRnBZTWdQdnlWZUt2?=
 =?utf-8?B?dFFUNVZhYTI3RTh2Qjh3SElpMnMzLzZ5L0NMTEhIajVwT2JCRlY4cm0zYlJH?=
 =?utf-8?B?OGhvV2dUdmlZNjdQQUVrRDhURERvWmxYdmVyQjRDcllWM1dZQ0VUZ0tyQkts?=
 =?utf-8?B?WUdMTGgzaFA4aktWNE1TOGl6K2hpNm0wZmQrbVpvT3RCS0t1VDdsMzBQUVNn?=
 =?utf-8?B?ZFFnMDVCRXZqekNKSVdFUkExbDBGWER4Nm5mUDFPWWF5bWhEc2FjU0ZKa0VF?=
 =?utf-8?B?dk5oVHo5NEVhN1BkcDJDbUw3MWZZSXdEZDlqNkxBS1BQenhCejlINCtDU05h?=
 =?utf-8?B?M3NZUkVRVWdscVowSVgybWQrb2t3dlZUSVBUZWM0MStDcXVteGJsUXpLanlo?=
 =?utf-8?B?MDZZdGszZlFxMmVIY0JjMkFtTzZkTzFqVE5zYlRpaVhtd2tMY081aXBZRkdk?=
 =?utf-8?B?dWpRT25JODVFNVF4VW1UV1ZBUXBQaUpSVWh2MXpsZFRJalJHcXZTaExoUGlk?=
 =?utf-8?B?aWZPcGExMWJDM3F5SGhVQTR3QVJheFlmVHlwNVhjTzFURHk1Vm90aHZWS2lS?=
 =?utf-8?B?T3d4ZmdTMmYwR2paYjVnZko4cWl5UTcwSGRndHJ3c2l1M1dxT0RHTExOVDJI?=
 =?utf-8?B?bUJWS1k0Rkt3Zkg4RnRPVVVjU1prWkhVb2U2SkNsVHVXazZyL0hiWTRCSUV6?=
 =?utf-8?B?OE1iVHFveWVUVmlzQ3J0bW1sZE5IQUdUTGIzbUJLaW81clBLZGVQckJJOXZ0?=
 =?utf-8?B?eG9SRGZUZXpuU0cxVXZ6VDdMcnAzR3NCS3pOOVYvTG9BVXJNRytIOTRLZlln?=
 =?utf-8?B?WUFZUW41cEx0aXhaNnBVRUpYWVlRcTFVbS8vZE5Takp0YjJkdnQ4V0tJVGxr?=
 =?utf-8?Q?adF62zWW1J0RQuLvbPkxaAY=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d281a9-3adf-4f8a-08f2-08de1bdf277d
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 20:17:18.8877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RqTP4W2aE0HjjbSkMjz2PZ16HFaLf0numu+e4d9OI1z04GwyUS0IAiqxsSty3cox2TYiKubfH6yWQKysroXl9UQb4nAxt24qYDp6aI+/tvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PPFEC9C76D91
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

Hi,

This is a patchlevel release of the Userspace RCU library.

The most relevant change in this release is the removal of
a redundant memory barrier on x86 for store and RMW operations
with the CMM_SEQ_CST_FENCE memory ordering. This addresses
a performance regression for users of the pre-0.15 uatomic API
that build against a liburcu configured to use compiler builtins
for atomics (--enable-compiler-atomic-builtins).

As a reminder, the CMM_SEQ_CST_FENCE MO is a superset of SEQ_CST:
it provides sequential consistency _and_ acts as a full memory
barrier, similarly to the semantic associated with cmpxchg() and
atomic_add_return() within the LKMM.

Here is the rationale for this change:

/*
  * On x86, a atomic store with sequential consistency is always implemented with
  * an exchange operation, which has an implicit lock prefix when a memory operand
  * is used.
  *
  * Indeed, on x86, only loads can be re-ordered with prior stores. Therefore,
  * for keeping sequential consistency, either load operations or store
  * operations need to have a memory barrier. All major toolchains have selected
  * the store operations to have this barrier to avoid penalty on load
  * operations.
  *
  * Therefore, assuming that the used toolchain follows this convention, it is
  * safe to rely on this implicit memory barrier to implement the
  * `CMM_SEQ_CST_FENCE` memory order and thus no further barrier need to be
  * emitted.
  */
#define cmm_seq_cst_fence_after_atomic_store(...)       \
         do { } while (0)

/*
  * Let the default implementation (emit a memory barrier) after load operations
  * for the `CMM_SEQ_CST_FENCE`.  The rationale is explained above for
  * `cmm_seq_cst_fence_after_atomic_store()`.
  */
/* #define cmm_seq_cst_fence_after_atomic_load(...) */


/*
  * On x86, atomic read-modify-write operations always have a lock prefix either
  * implicitly or explicitly for sequential consistency.
  *
  * Therefore, no further memory barrier, for the `CMM_SEQ_CST_FENCE` memory
  * order, needs to be emitted for these operations.
  */
#define cmm_seq_cst_fence_after_atomic_rmw(...) \
         do { } while (0)

Changelog:

2025-11-04 Userspace RCU 0.15.4
         * uatomic: Fix redundant memory barriers for atomic builtin operations
         * Cleanup: Remove useless declarations from urcu-qsbr
         * src/urcu-bp.c: assert => urcu_posix_assert
         * ppc.h: improve ppc64 caa_get_cycles on Darwin

Thanks,

Mathieu

Project website: https://liburcu.org
Git repository: https://git.liburcu.org/userspace-rcu.git

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

