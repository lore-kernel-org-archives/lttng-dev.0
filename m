Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84B0C61CE8
	for <lttng-dev@archiver.kernel.org>; Mon,  9 Jun 2025 15:41:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bGGPN2GHKz29xr
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1749483705;
	b=Rl+f96P72TA4u71XWuCF+YgkeCPV3bvwmoIapzs3AwV4zjjSyZ2/9UswaDBZX0z4nmS+
	 Gp4FueY8SHquF/VWOPhn8ujxn7PKaQuTbMCion6bhN3odm/aCGtphHCAnDGFV/eUcQzXJ
	 Nd70iRsYtHTXaXEvvj9ITCsTY6+oDqm6x82WQu9LkKWb6+gXdsq0s0Blyyzvxjjld5qGr
	 aCqZNU4NXRNb6+NMZHkxgdnYtonV7Ws4Tvb9wYjobburfNJg4eQp1dITCqcDeKCzpsA8k
	 K+mZWjWQV36AfMQzy5fKf/tc5L3qmVNgTFGQqc3Lcqaub/jBl1YFmeVe5CPbObpNnPg==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1749483705;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=8DsCd/pUpDp8itQn3SQMhBMeE73CLE8ufvJqVZGmUm0=;
	b=o2pidyjWjmyuRPpSfPbB5FzB+NO5bAOn0wE5dsQohuNLls1hmt2N2wPS8bbrMALv7hLj
	 7AaZ8iq/sMxcveLU3ct8hW3fyV1yo4VtC/nzXNtnrDcqYJHQkJwCzSHx9cjv5z7Nw4rSB
	 Es3hMcNtsoCbp59jUUPhxhfTdgrs/zSo3qea3DejpI9Onjz41RA/pj8jYWkz0LCEGk1NS
	 pAUEpnwB1qpQMPpkGFyFn9cOVlNTU+Yk2+S2/qPz5H8H+/r2cCnDa/2k6HV+8YYQw6m0G
	 DBb6yjVJlNQ+yC/tmhHxLrTMpDZpxe+QWPoI4EZvu5DU2KmrU0sqqXjqMgRzUtuvDTA==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bGGPN2GHKz29xr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1749483705;
	bh=8DsCd/pUpDp8itQn3SQMhBMeE73CLE8ufvJqVZGmUm0=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=wTURrQ9MCXGQZSQ4WopsVPFszEGEDp9/qNX08sYUkKa9ojQK5INYjkB2tAvxxOP4P
	 xTc4wfUTjhyGol7c0klsciOuvvzV9t1bMhVFJLPxPaNJnd7XaZje3EizMBGlzbNIJ9
	 iCWHqwC6zuLCSr7Yta7CTNt0WIsS3GdVxUj0fJOjfYdW6zO5n1MqLzopB1QN43U8a9
	 bojg5RCaxQawaVztnoJ2NMmOxM2upTg06yBiatum2G97yE18EV1MQv8njY0atC+evR
	 x04pANGVEDy9NXaokhCRHWOUTGAGlknHVizPHKwRgQ63pQKBQ//DNq/XDPVxDxk3t0
	 p3ANvcAD6ejrw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bGGPN2GHKz29xr;
	Mon,  9 Jun 2025 11:41:44 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bGGPM119hz2B6D
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bGGPM119hz2B6D
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on20723.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:241c::723])
 by lists.lttng.org (Postfix) with ESMTPS id 4bGGPM119hz2B6D
 for <lttng-dev@lists.lttng.org>; Mon,  9 Jun 2025 11:41:42 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkpsndO2XVwsH4+UXOrSyIvQD+zaPq5PYoNxL1OZq09KaFHnsyLyb18SNspOUXm9zKCUUXAZH1MZGCtFfok4EkITYX937kgjfRD58R/qfP3GcVtTiRcU+YWE8GlxqNzZnaj8Azx+QCpAvEZFBRCTbfYaFmUf1r30t5S7cBDaDoiuWP/t5NKAPWU0ewz9HovXxJFtmDZrHwT+sYE/myTDTU2fY27lnhbE12/Cz5JY+9cSgPYNZ73OI4E/LM5dDAreRY5NjZMRy55SvfIizLokFmDoVjIBV21uEZDplacWI4A5xdGWBB169zCCPiLIU75Lf2q0bhG5tnnktvfYx3i9UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOrcv4fsPUKKflHdCUJUdQafMlitSxgTn8XokIjb6js=;
 b=EXQvCSk+W1pkW6gsqqq7Q78K21ZQFtdxJpKFm5mP+LauiAgyGSp6O0By77l7CET+qrnKGue+eGjlTVL4X9q/rUxMs0slKH+MUvlMylHcmOqNeJS6nJcVt/ze5HHFK8msloy2hHbDqHBtMx2pGxuUMcLqTuYlXb2LdAcCiDUdlYeNfcfKYPXNk2Wh3WTbn4O+baUuDSoDW9QLn3zF/mLlyGuwc6LXL6RNElVS1F8nO+HcxMQk9E9XJM1zzOHFJtDLTp/i1BM6t/xR1HW3GCRQpxoLjzTja4/Fe+d6ByOJ/oXlL2UcJPYxw/kha7BJpmspiZPiLevdUyyEQYo+Xb4n2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PPFCF31985F6.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::48a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.41; Mon, 9 Jun
 2025 15:41:39 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8792.040; Mon, 9 Jun 2025
 15:41:38 +0000
Message-ID: <f6580438-0b5e-4174-a667-095d20ad24de@efficios.com>
Date: Mon, 9 Jun 2025 11:41:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH urcu] src/urcu-bp.c: assert => urcu_posix_assert
To: Zhixu Liu <zhixu.liu@gmail.com>, lttng-dev@lists.lttng.org
References: <CALMA0xZF8=aZfdqjwhXhgWqUtnUs9onDSqz0oKxfqCWFOnOigA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALMA0xZF8=aZfdqjwhXhgWqUtnUs9onDSqz0oKxfqCWFOnOigA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::22) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PPFCF31985F6:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7286b3-0101-4976-5838-08dda76c1f50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHVOVHc2QlgzeTZYc3M2ZW82T3hjKzhYRTlHYmZiTkdDK3cyS2dvS2NrcFBz?=
 =?utf-8?B?YmdXZE5vUG5NS2tjb0llck9iTG9NT25hVWZmamRTd0w5NEpwcFUzWGZ4QklH?=
 =?utf-8?B?bFlqb2NiNmVoQmRCQW9vYlB0dUM4WVNRbE1lV2JwVlN3MG5CQkVxVE1Va1ox?=
 =?utf-8?B?MXYzVXlscGJjY1JoS1doa0s4ckQvdkw4ZE1yQjJFMkJXY1A3UVRiMkcwOTgv?=
 =?utf-8?B?dC9rOWxMUXF3Zkw5TFk5c3JmcmRoMlV6NmpUSjIwdWVkclZVbzRVZy9DVU1q?=
 =?utf-8?B?T1JXU3NTN1hQNFZuS2FoNzlJQnh1WFR4Z3lBUFMxbC9EZ1JnK0dWN3BGc01M?=
 =?utf-8?B?WTJGRmR1aEVlRjMwdUhJeHNtWkRzTkhnY1NPWnlqbUwvc3dZM1Flak10R1hC?=
 =?utf-8?B?c1VHemVBcGp4S2gxblAwNVRtTXVuMysyaHNnemUyZlB1REVJN3lsZUlhRDJx?=
 =?utf-8?B?RFd6VFN0SXhpV2dVRGFCdEVtVStwcHErODhkWG1QK2ZaSHNoV0xBZFpHWUtC?=
 =?utf-8?B?c1Vqa015SFBDV3ZUWEppTm40di9jZGsyVWovVUJpY2JIb1NTc3g0TlV2cXBt?=
 =?utf-8?B?ZUlSSmQ0RStGOGVna0xWOWFuZVl4M0FvNmVDRFozWC9zdVhUSFlRMVl6bDdF?=
 =?utf-8?B?YVE1Q050ckZVVUVvRzU5Wm95aUZmUTdaeHFtTUxaNU0xVUx6c1BMYXdoNU9o?=
 =?utf-8?B?Q0VjWkpMbWI0eEdIdVQ0bDRqNGZpUVZibG9IekVNRUVEMzJlOGxYUkVRaS9I?=
 =?utf-8?B?cEM4SDg4ZHZETGkzYWw3VHlPbFM3R0RDSWFpOGpjWFVCMG1PcWpVSzBxL3RD?=
 =?utf-8?B?dTE2ZWlkdVQ2eE02WmNvTFJwRi9mcjFwZ3NhMXpEelhHckxwai8xa2tqUTFS?=
 =?utf-8?B?aGFUUEhtUHU0Tjd5dWpUUk9tRk1wdS8rTVZMKzZyOUtaemNHcGl2eFloTDBE?=
 =?utf-8?B?SEpDeUJ4T2hrTlJJM1VDZkFZUDM5eDFLNE9rWHEzYzJVaFFIeXVrZjdDRXhC?=
 =?utf-8?B?QUlDOTdXTmhKd1hRM2VwU3RIOGZNL0sxbkQwZ0FsdWs3L00wOW9ZQTNHZWE5?=
 =?utf-8?B?dXBIdUZDYWhJTy94alNQR0wzNkNxbTZydUdEdGMrcTBuWmlYVG12cDJlR2lz?=
 =?utf-8?B?eU5PSFBzTmg0R3JtazVWQTV3SzRhQUIvUW05a05keHJsZ2k4L3BFWVZmd2FR?=
 =?utf-8?B?WFdsaG41N2g3Sk82VU8wNERqc0kvRmtyNG5PekZZMW4rSllRNUQrR0VwQ203?=
 =?utf-8?B?TGRCOG5kZ3BzZXhqNU5pZVB4T2Rsa3RHL2V0dWtseWdEZUIrZVVPRmtIdXFJ?=
 =?utf-8?B?SXB5VThybjhCcS91UVRQeHRGc1NNcFRYVzdsbDBXRHNFMGVNRk1nQjI2bm9r?=
 =?utf-8?B?RW9McmJrWnYyL0ZQSFR6RGw2eUI0YkthU2dkN3dDanl1VUlFRUVHNFI5ck9s?=
 =?utf-8?B?WlUvUVlUb0dMc0NGZ3JhNmF5dE1ZbGgvZDlRbmM1MElOdDQ3NzRtZXV3UW1p?=
 =?utf-8?B?WkdZOFBEbVNnOVRvQkJlUjloVXpqNW9YS2hGN2RDYUZCTGFUYkNnZHQ4RzJi?=
 =?utf-8?B?RHM0bHhxKzRySGhzWm5wcjlZS0VVeEtMbE1UTGRLZjVNdUVJOUpHamdHUlVQ?=
 =?utf-8?B?YTlqckQrYTc4WDF4MjNNZWxQYVh5Vlh1MFdLM294UEUxbnFuZFphWXduNTUw?=
 =?utf-8?B?L0xZOXR2WUcwVXA0VXRvZFFkYmhYd3RhU2VrdjVrMEpGbVdzNC80MTNKaTVh?=
 =?utf-8?B?TG5IejhPWWJuVzBjRzZXeDFCVVd0b0NLT3RZY0ZvS2U1U0pnekJHUUdUWE1m?=
 =?utf-8?Q?7TO77EltiEdDfdc+5IqNw+EFkIS9LRXFB0bPo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emV6TmhDRmN0VE1IeGtOTG9hZUhkM0dYdFRhLzVBYW1MQlZycUVRUW53am1l?=
 =?utf-8?B?SmdKRnQzRWRnZW9ZMThtWDI5TFJ2SGEzb3BuWGh3M1l4aU5BdjlhZWRXZ1VH?=
 =?utf-8?B?OEY2RjRoRUNuTzVxMlczQlB2bU9vYlBNVWh0TEFqUXFDd3FobGcyQzMyS0Vt?=
 =?utf-8?B?Vm5TQjZBNGlld1k5dlZ3bkIwVjZ1bXhpd2NWNmEydFlYYTh1dUZTb3FDUnZn?=
 =?utf-8?B?YTEvaERqZ3JJTVZ2VW11QTVLeGNTYVhjUXhjZ3k1L3l1Q24yU2pERlBGNXEr?=
 =?utf-8?B?cDl1U2RRbk51djlyVUNqdzJXSUZJQWR0a1RFWTVwK0JnVDJXNmhLU21GOEky?=
 =?utf-8?B?U1BpbG9lZUlkN0VVM3RXbmNnSkRXVU9CamdYWmdEQjUzNE5zRnkrZDRneGQ3?=
 =?utf-8?B?cmE5bWxTZDJzaFdDLzRiN0QzUUo0SmNqVnpodnBmcEFmMks2T0ViSWVmempG?=
 =?utf-8?B?MUlrWjVsN2hQMzRiYmIwbnBwTHZoNFNTeFQwRWVaMkllUkhhYTdQczhvaml0?=
 =?utf-8?B?UWZLYTRQRjg4b3NMOXRxR3RpTnc1MHI5cm0vN2Jwa3NCUjdjL3p3TlhsRDVQ?=
 =?utf-8?B?SVBpT0lXcFVOejJLeFp2SkJDbU1PRHJjNlBPNFA1SFk3dG1DbDNhODhrNlli?=
 =?utf-8?B?UDVHeCs4MEtHeS83ZUR2MWdPbkRBQ2lmM2ptS0doTHBvb3dXeTVSN3ZudDJp?=
 =?utf-8?B?Y2lPaU5Mb01qS2QxaTRONUJWMlpWczlFYTk2MFE1cmJFb0dFMnF6bWhmV0ZY?=
 =?utf-8?B?TXpXRXRZcEwvVzZOekN6Uk9MZ3VFK1ZmdGhRb0xrRWhVZjY3L0ZlMVNnZG95?=
 =?utf-8?B?L2pJajBPZzlCd3Zwby9KZ0w3VStBQnVPSHZvRWNCZ0JPemZDNVBRV0FFbjk1?=
 =?utf-8?B?WG8rYjlkalJKNXA1Ny9ZaFhHbGplcGNhZ0FLaCtGT3k3Qm1sLzJOdFU5K2U2?=
 =?utf-8?B?Y0FFTGlwd3RxTDl3ZXdSSkJZR04vdjVLNFRVOGtMbkNpdFZwbWhWUmdIN2FB?=
 =?utf-8?B?S3VWdWdISktxdzlPQlp0NExhaWlGUWd4YjEva3M0alFFR3ZDN2N4OXBIaFVm?=
 =?utf-8?B?Yml2dnRVVXhTYUc4RnpXZlVCVm5LN1E4NXhPZUlTTVlhaFBMQ09raWJPenVW?=
 =?utf-8?B?eVNwdW4xcHdrMWNwV1FYQ2o0cFB1RG1GUVlwcGNLQkpXN3ZyS3RYRGRUZzl5?=
 =?utf-8?B?SU0wS01LSk1DUm5TR2ltbVRhLzd4SUJhM3RMY3pQWnZmZ0ttRXZHbkFqd3dy?=
 =?utf-8?B?SUErRGlRR1ZkZHpFTHF3WWwxNHZSSnFZcm1LR1IrQ0ZWSTI0aVhkekJpVTBY?=
 =?utf-8?B?bE1OUGZkOTJFSzU1YTRZZEtUV3RQSjNBa0Uvb3Z5Umgvam14VW5PQWhPUitw?=
 =?utf-8?B?UlJuVXhzWmppODVZOUw4N0E5Q0YySmNCRGhtcWRPVkd5R20vdDZzOG5PaHFn?=
 =?utf-8?B?bnhXSjZhamtVL2xxQytaeElSc0ZMRlo3YklSV1BJZ09vcmF4NHc1ajVnUHpB?=
 =?utf-8?B?cUpBOU9ZRzdoejJmdFFiWnhoQmpnVnIrWi9WaEVtTWxIV3hrSVFXd2VWa0wv?=
 =?utf-8?B?c0M3ZzBQVlpMYjNYVVg5cUNJQ0dGQUZ0OXpJSnBndDBkTjMvbXBOMEtSNHBS?=
 =?utf-8?B?L2kwejdZSklkRXJvajlnbFhYUmlwQzEyd3lkR1AxME1Cek1IUUlycDRSVTJw?=
 =?utf-8?B?NVZ0cytWL0drNTFwMzlhc3lRdHNZdzc3TytsdjdydW1YQmhnc1YveXp1Zncw?=
 =?utf-8?B?SHVBaGdyNExwc2g4WllhTHhYYVVLWGtobUVCVjJ1QktxenVNdWZBN2IvbWJs?=
 =?utf-8?B?REFHVUpxM0lSNHlVTnhUVDZxU1lybExneFpkNkRIS2FLYU1uMjFEekYvdkh0?=
 =?utf-8?B?N05yc29IUXpwRUlqZVpCb2lrVzFRY3Z3UzV1M2ZuRU1UWkNIWUlQcm1OeWMy?=
 =?utf-8?B?VThDQUVjY1MyUHNMYXM2dCtoeTZkOStGclFNcGdqMzhCTDZBN0RoYVZwd2Z0?=
 =?utf-8?B?WHQzbnJVSHNqODR1REp3MVNiTDFlNG1JR3ZjK3N4cmxWR1hWZ1gvSDkrVlJu?=
 =?utf-8?B?bzNURmh5YXUzNmJCZVNSeVdSNUlGZzdMN2pjOG1vQ010Ymp3OU1kUmgwbDRM?=
 =?utf-8?B?ZUswdkltZVFxQmFNc0lzdnVmRk5TdjhEaTZaYmJYRHRKTHJCdk9zRWVIQ0dy?=
 =?utf-8?Q?NQSJ8Wx4Wo4JzX7U+nypn5Q=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7286b3-0101-4976-5838-08dda76c1f50
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 15:41:38.2648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3W7PLOa8Gb5qx/Ec7ffUhSXe1P17UW9UJQoeml8p2bWHWPBqftlCwVDFyzSn+O+eJ8WxvWgjSpm0+laYT8j7kcxIrKJyOSlGcRZ/uYGzhxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PPFCF31985F6
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

On 2025-06-08 22:49, Zhixu Liu via lttng-dev wrote:
> otherwise build failed if has -DNDEBUG

Merged into liburcu master, 0.15, 0.14, thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
