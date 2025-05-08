Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0760C3ABBE
	for <lttng-dev@archiver.kernel.org>; Thu,  8 May 2025 13:51:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZtYT21zmcz1kdZ
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1746712296;
	b=mdsvzKYTgVPioVD+AYFgvnydRGrSjjgrDrPNIKO9/NEnKnXftRjSfYXNmIYMoRiOymgX
	 XwA7KuwdW3xxG+S0U6Ot2B9g1qXnlm7OPcQM5/2qumGn8jmKMBOuAOeJvR5IBct/9zogE
	 xLH+khVj3px5GDasZYPUl4AmGhXGE1pkSAJliEcHQAXWqF5PRFAccm7wQLdE4gw4B0TMm
	 52hK5bLOHpz6ExTPZ17OHeaL0PTZWfBN09N34RQe40RfTSMHMpq0FCwasYN79dksM8eJ/
	 6SrdMutCIu1oT8TZPAAT4S4n1Mf9SDEOTZIDZC9mBwFnO0ta/cIdzjVp3J3LZFye5bw==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1746712296;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=moO8mKuEecRfEvccdBRKoFiPVWyk8NJlQSAUNHhsfN4=;
	b=lY56LMsFblDBAbLWz80sA2ivK2mOCxazxyHnWwz4vMwfBV2v83auYMkE0acwH/Bu8d81
	 XkE6Ksf0C2IThZzDEC4FGXRUmoCfRwBtOgk1HNHaRSksrhcnuVzucocj+oS1W+F0/P/6L
	 WQlW1VloHcFW32ypgTeh7QAyjTjkD2aWIvkeWVmGAGeQgIQXpy6GuUyILn7gV/SawBJDN
	 p9AzADYf0d8T4L61YX3c8zZsiceXNe8haeZmsQJCMlN8doQRQx/bPHCAOg01hwQbHp9mW
	 3vz+G+n+v2FJLydJOFojgF5EjqxolnIrXlgyARv2Bd/QPmRcdeNnUpCjmaAevFVlS4w==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZtYT21zmcz1kdZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1746712296;
	bh=moO8mKuEecRfEvccdBRKoFiPVWyk8NJlQSAUNHhsfN4=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=tkC1tNq3xWsoY9LOJSt+pyHWBW95QPqV69GhAoVMtKM3n6H6N2VedhsHr3BbyW9Ba
	 whYnO+YjKF52d/MifNWDU80vzlGsOTiGJMVQWwVu7ZLsTbVDqByyb+5QiXS+P5dE9x
	 532LSmBw7UmTVRqaUttRLULYMHU4h5doQ9J68hgEaI/0Vsj7xOi3wy+gkcAsYMgpvc
	 TqEOpE5znzK/kp89Z1W2WNLyN9RLg2ZPIl1v7ySy5sflDu1f5Neov0/XGL23e/VqNL
	 AWhHnbUKi8So9Or+BrTVyaCSCusmYsldLdibT/sQmpIqtPwUfkyJT5uJgHrfmAypEu
	 y6T2TLRRqnvDg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ZtYT21zmcz1kdZ;
	Thu,  8 May 2025 09:51:34 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZtYT04Sqkz1kdX
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZtYT04Sqkz1kdX
Received: from YT5PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazon11021107.outbound.protection.outlook.com
 [40.107.192.107])
 by lists.lttng.org (Postfix) with ESMTPS id 4ZtYT04Sqkz1kdX
 for <lttng-dev@lists.lttng.org>; Thu,  8 May 2025 09:51:32 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZJcHEfbexBEKUn7t/rtgGz/rGE5iCCpmtLOxQ9wbwJiyljpqQ1Z6uGr1yqBUTryqOaYcA1HLmU4u0LDcRd0y3GK3rRV5sRE7e+Rd/9p6VC7vatToaMJQ6QQ4IZ6cj/hJz+dpCnkZJqmGyY1xvBJ2DcAdDPACHbtqxNTZ/PZKDs5vdpbGYIvJIoG6QzOkcD+RoWWzRDDobcux2+IeuU0qJWD8lSJUvroRAFk5fq9NwRMMCWfqpSWHBeXurWmY3h1F99JttlvPVS6lF7YYFJuUXNYPGgFFRLJ1zZgxHdxeDrQeJsZcKTCUKhFNC44dFsXIgDBKuC+L2wbsXFXWPBckg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j03ZuuLXV3egl5EpNdomKZu+WQ+uCVTfluY9rsXhoLA=;
 b=JK3OVyqR/l5V8T0yds78oL/MA70dYj1wd4aP7wFa50TxhB+0Ydz9dPyNGaQ1sUGCnFezoyQiwfb0vmPtyasmy/nfD2beigzln8tzKhO90bc7D3dtqdJdKv0+IwnJqWcO0KQPQQG95JI7yO2B0yIM6DGLkoVGzexO6JEozBEgTgOvYkq/DVVPn2Scw+jpU6sgoKscBMWweQunmEjGzFMNc/Z9AhhzOyki0D5gE89THj+FIc+iIs0tI3yVbPibs0RyiHzFj3cZ04sjEgOfSjVI+8rmVxFawtD49fWgOd93WYW+64PyEZcJn3sfEQ5eKt0FK5J7VHor38GSxPa2/gKgiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT2PR01MB8758.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Thu, 8 May
 2025 13:51:25 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%3]) with mapi id 15.20.8722.018; Thu, 8 May 2025
 13:51:25 +0000
Message-ID: <90aac2a4-0a4f-4d2a-a90f-c96c9be820af@efficios.com>
Date: Thu, 8 May 2025 09:51:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Not capturing ust events
To: David Aldrich <david.aldrich.ntml@gmail.com>, lttng-dev@lists.lttng.org
References: <CAJK_iejrz-U0-XK1hmoH9=TCLcErZTVE16XdyKzXX0buJuuoCQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJK_iejrz-U0-XK1hmoH9=TCLcErZTVE16XdyKzXX0buJuuoCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0162.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::25) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT2PR01MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: ddade694-82cf-4e07-1e1f-08dd8e376cb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEplbGtPb1huU2dVVi81d0JLM08zd1FIWFZBSnZaSnhjd1M0SGhsUkhsZWJH?=
 =?utf-8?B?eFNZNUpKSVZYSElFejk2ZURreU5sNGMvSTBVdGY5WXJrUFp1Z3dQOTlYNUVs?=
 =?utf-8?B?Q2o5cm5kNHVJNmVrV1lQSTB3N3c1aVFpQXJ6eEcwNHFBSUtQY3pFRktUWkE0?=
 =?utf-8?B?ZmtXS1dwZkJxRldoWGZPTVVSR25DdUttS28yMmRFZSt2eU1CcEh3MnZ2MzFr?=
 =?utf-8?B?M2lVcUx6d1E4OWV5eGhlRm5sT2IvTmJHbEk3bTYvMkY1MmUyR0IvOXd2VTRn?=
 =?utf-8?B?VWV2SEJvWjRpZ0tyeEdOcTh0dWU0N2E0aDFmS21nbVhETDZqOGduTTJyYlUw?=
 =?utf-8?B?Z1N3a1gwZ215THp3T1NKc0VCZnp5NlFIcTBPYWtzbzBQeEJKUHEzalFOSkg2?=
 =?utf-8?B?ZWRNMzRtQjZXek0xSkZXL2o4SHZrdkYzMnlBcnl4SHowMjBwRzhuUndYdlkr?=
 =?utf-8?B?U0V3ZzhmTE13azRjbWxTT2FYMGtSRzJiTmxiM3RMSzVlRUFFRzAvZFJuOUR3?=
 =?utf-8?B?V0Z6ZDZYOFVtczZtWlZqMm1lMTFlNEtXaXJZNFMrT1hoZHBmT1JXK1J1aGhQ?=
 =?utf-8?B?MWFid1dxSUtNNS91R0R0Y0lDRkpIZWE2bGtRbjgxREN5cUpmTE01VXZHM2hY?=
 =?utf-8?B?bVZZQXBtMHM0RE0rbUgzeEl2ZGF2dVBjNFJ3TTZieXBQZUk4WUJIeVhJeW11?=
 =?utf-8?B?YmNsSDZMVjdyb1FmL2JZQWpXbTJaSnZMSWxkWkZFM0lJcFVRRWZMSXcvUjBV?=
 =?utf-8?B?WEliT0NSVWVRM2l3NjFiU2IwYkFzSlE0NWhrWVRoQnlGS25tbGJDMGlNeUVn?=
 =?utf-8?B?b1FvRTd5UGNHVjRhZWFLaVNFN1RXWXZKbXZ3Q2lwVHRzaEJpblJQNnB4amZX?=
 =?utf-8?B?YWpubGg4eGluVVRPMlFHVE1aZlU0ZEo1TzQ3NXQrWTBqNXMzYnI4QVBVcGVv?=
 =?utf-8?B?K2JvN2JEU2h2Vng5bHV0OEpnNm5XS3lDdnlmMVhJK1hNMXQyKzhnclFqa2pl?=
 =?utf-8?B?d1pmcHV0aTVzWVhWcDNlNmpUbnVKSytyRHM5bEpEMENDeUFDcmtlWUQ4TzRk?=
 =?utf-8?B?RWJzTE1EamhCSlVqSHpjNkJHcU81L3VadnV5LzBWWTFKZjM5d0U4TnNZR29S?=
 =?utf-8?B?VVFOSzJVbmMyc3pSWGNPOGZrTXl0ZEtKYytBTHdZRC9nK0FJM3RNZjcrN1Jv?=
 =?utf-8?B?bTV3bnJ3NWtnK3NudVFiR2pySnZHQU5OaDBQYzBwY3h4YzNWbVlWQURjS3gw?=
 =?utf-8?B?d2pTUEtLUmUxa3FEaEF0WmN0VDVJNmxZWVFkL0prM3I4dnBmaDlxRkQwNGht?=
 =?utf-8?B?Z2dIdUJUMDFpUG5XblJPRk5TQXUwMnNlMllwUGFXMFVwaWtTODVtRDRqTVI0?=
 =?utf-8?B?b1JSM3FWTUJ1c3pEQVhRWE1neXBnVkoxMkRDOWRCM3dXaHA1OVZQR0xwN1N3?=
 =?utf-8?B?aDRuZm9VNDFib1BRdkFBWnBXaGFIa0ZWOGJ5T1NqRVNBQ3hLT3dMSXpvWVNS?=
 =?utf-8?B?QVJiOEY0d3lNdm9jK1U5eTAyY1JVbFU3SExVakFSaXdZbnNMQ2dCb00zOTZK?=
 =?utf-8?B?Yy9KWXdnTGVvbkxYZEx5Qk93dVhCYU1PdEF3bVpISEtrK3JPdkwvRWhpekFO?=
 =?utf-8?B?Q3FsRHprV01ZM3pPQnUwSlRzZ1FqWUxkMTFKNVBJeW96blZQSW9lb21Nd2hS?=
 =?utf-8?B?bnZLUnV1ZEdYTlVPbjBpVXJTWFVyc3lOWGtBQjBBWjhVTmFUMW1jYmF3aVMv?=
 =?utf-8?B?ZzBSQlhJVnJzNzBpL0Mzc3VlR282OVRqc2hQNE5laUppdjV2VFN5U2plbS9G?=
 =?utf-8?B?dUZoQ3QzWFU1UmRQUTV1dG1YUHl1WWp4bjZiY0gxTkVzbnhsOUVETS9ZM3Rm?=
 =?utf-8?B?c29mVTY2RDNIMmxpeCs1dzNIcSs4VCtCNE9ENHRZc05QMTBySXFyWFpiZjF0?=
 =?utf-8?Q?Bg04KuaDLhk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3NFd0svSk5HRHEwZE5pWHNRTU1FaGcvOGRkQUxTVGkwaDhmeEZEZ2JsWXFJ?=
 =?utf-8?B?bHc2N1NLSHJBY1paOGNmSW01ZG8yUzQwS0R6MDd0cHcyYkFnb2xMVkVPYWNV?=
 =?utf-8?B?MGplVEM2eTZVZ3hlb0ovSzZkYVB2VFpydSsxNzNKWWVsbE80RndtRmRCSWxM?=
 =?utf-8?B?S2pxOVhCWStmSWt1NEFFOE0xTkJKcUV3alNaenB2TFRVWStiS3M4RWNROEN4?=
 =?utf-8?B?cXRVaEM1SjBsT092dWJ4dDhuaDgwMTRvaU9wWXI2ZnI5QzBDWjZFZlJnUWRU?=
 =?utf-8?B?QXcyVTQzQ28rb09Id0NDeWcvdTdoWll0eWY2NTRhaEdHL1VkdlY3Qi8xS0ZD?=
 =?utf-8?B?VDRSL0Q0NjBRVDR5Q1lRbHZmaUlWSkI2Z2Z2c09iRldaVGNYOEdPY1dqeWhO?=
 =?utf-8?B?UGlSRkxUYjJtN1dYNE8rZUNiTU5kd0lVQmtCN3piTnBpMFRZQ0I3a1lhdXN1?=
 =?utf-8?B?WE04cHZWcjE3Rm1FUktPK1dhR2tFekJTbjlqZE1kMzZnZWZlNmIwSFpOczRo?=
 =?utf-8?B?NFRPa21WakNESG5IY3ltSFNoRFFCL2ZHM3E1Z0sweWFid0NtdnlpQ0Jqelow?=
 =?utf-8?B?MlRKZ0gvcXE2VlFPR041ZkYyN2RYOGprU00rQzRSTDloam9tOGNKT1NGSEkr?=
 =?utf-8?B?Q3ZtN2NhRXJjdjdSbTJialZSVGpwOHJCbmFWcGVXT0hQc0R6MXZVQjFYMVRm?=
 =?utf-8?B?akxxZFQ3K1RPMlQ1Sk1DUUlqQ1dUamdsZGdWbEEwYVdoUTNBTTRPc3ZlODJW?=
 =?utf-8?B?U0FneU1nUlJyaERNV3ZXZ0pCV1FLQnBVVWg1aCs4MDR3YU0zZEV5L1ZzTkNO?=
 =?utf-8?B?QVN0NFhkRlh1aWVXN0xqa3NTS21GN3Zya0FZdkhuUExOcDBsSnJBc3UyMzBB?=
 =?utf-8?B?VDBtLzdmSTAxSXIxVlByRnZJQUhxcDNJdm9PUTRIMVQxU1hSU1V4bjdtdHdt?=
 =?utf-8?B?ZnIxSHppYzQ4Nm5iZysvZGZocHhMeTVaNk1Cc1ZmT2RRMVNxdjU1MCtKREFl?=
 =?utf-8?B?eStKYzdhdzZhcU9UMldzeGY4YjN3RXVDaS9zbXVvOTJpclFxWHFZci9aZWVy?=
 =?utf-8?B?c3pWdUtibCtEeUFjK0lmdzJJK0UwQzAzdGRWUWl0bG1SQ3kyNW5sZG9oL3dO?=
 =?utf-8?B?SW5hNUJwd2F5a1VmQnVQWDZTeEFuNk9MbjNlYlJmR0pONkNqQ25lbTdESG1n?=
 =?utf-8?B?N2NTRWN4WmkzU3kxZk1ZZTYwQjVtK0Y1OHhETUMzbkYzMGUzN3UwWTNCREk0?=
 =?utf-8?B?Um5wRkFzRnRaZDFpcEhndVJGbkVXTEhqMGR3VzFTSTFKT2FnSndFRkI2ZlYy?=
 =?utf-8?B?M0c0cW9CNjg1YnlsK1BYbVh6YjEwWEF1YU5uazJZeHNuL090ZEs2QlBIWHpE?=
 =?utf-8?B?VHpJay9jODMxM1FlQnNZS1FPRjBiSjJZR0hPRExTTWVGMEowNmFmaG5VM1VW?=
 =?utf-8?B?OTBjQkVVZ3Q3RUk5dDVSc3ZxdWJhSmJsY3hKTjg5dzFBS3hmam41ZDB0TFFM?=
 =?utf-8?B?NUxJQTJMV2dVTDVwQzM1M1YwbHBCVGRVTFJ6Zi9HdVU2UFVOVERTcTIySExq?=
 =?utf-8?B?dWFrbllyTkdnbGlrR2dPVTFraFJsem0vY1cwQVNMQUMzRVlIeTROMDczKzAx?=
 =?utf-8?B?T1FqVU0yem12ODdQaERqb0E0SXMxanhVa0lLVWRnOGFaeWFhNlhQakV3OVIw?=
 =?utf-8?B?N09XS3MvUFVnYjJHbGlsVG9RQ2xndlp6SDN6ZWdJSE1PWTJIUG8rU1ozVEVi?=
 =?utf-8?B?T1JyMHRWaXBnUmpwNkd4WWNRM3dybWM3d3hrcy9VeWNRS0R1NWJQSzRSbVhp?=
 =?utf-8?B?L1BwYVA5OUlFMmxsT2xBMzd1Y24xQ0xSdnFzTDFRUit1bXFlVXE2ekQ4T3Av?=
 =?utf-8?B?cHRSWUVHdVhxVGZSNnlsMWVISDh2THRJQlR4SkxQWEpQWVd0VXRubkUzUVMz?=
 =?utf-8?B?cEpFWlVoNUk1NmxwYk5BOWdMOGI5MUxlVlFSZGlkeUw4cjJSdDQ1VTZ6dy9n?=
 =?utf-8?B?Z1ZtMWExektTSTMweXpWM1hJT25CSUlWUjYrazl2a0ZKVEtXeEpBQkFEWHZ2?=
 =?utf-8?B?SHYyT2h1d3RXOEtPKzh5Mm1zb2RhWC9KZ0xUMUkyS1h3MHU1cmlwT3Jkc1FD?=
 =?utf-8?Q?XVGoYw+JkJ9OkcE09CXAPRg9t?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddade694-82cf-4e07-1e1f-08dd8e376cb1
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 13:51:25.6014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PP9QjjMaGfMlSDfAPuprvpgWXPlnlQzcjUZPHxLe84Wcs8tvx0eUYzURxx4uKlyK94FyCElcJ3KNz2q8FXUw5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8758
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

Hi David,

On 5/7/25 12:50 PM, David Aldrich via lttng-dev wrote:
> Hi
> 
> I am just getting started with LTTng. I am trying to use
> lttng_ust_tracef() initially.
> 
> I am running LTTng version 2.13 on Ubuntu 24.04 LTS, and viewing using
> TraceCompass 10.3.0 on Windows 11.
> 
> I use  lttng_ust_tracef() in just one source file:
> 
> #include <lttng/tracef.h>
> <snip>
> {
>      int my_integer = 0;
>      string my_string = "Normal";
>      lttng_ust_tracef("TaskManager: %d (%s)", my_integer, my_string.c_str());
> }
> 
> I build with CMake and link to the lttng-ust library:
> 
> target_link_libraries(${_lib_name} lttng-ust)
> 
> On the target I created a session and enabled the event:
> 

Was the lttng-sessiond already started (as the root user) when you can 
`lttng create my_proj`?

Is your user a member of the `tracing` group?

> $ lttng create my_proj
> $ lttng enable-event --userspace 'lttng_ust_tracef:*'
> 


> I have to run the application as root:
> 

Do you have a particular reason to use `lttng-record-trace`? It looks 
like `lttng-record-trace` will set up a new session rather than use the 
one you created earlier.

> sudo -E lttng-record-trace -a ./my_app

Should you application run as root normally?

Your commands could look like:

```
lttng create my_proj
lttng enable-event --userspace 'lttng_ust_tracef:*'
lttng start
./my_app
lttng stop
lttng view # [Optional]
```

> 
> When I import the trace directory into TraceCompass I tick both the
> kernel and ust event boxes, and create an experiment, but then only
> 'kernel' shows under the experiments and Traces in the tree view, no
> ust branch is shown.
> 
> I guess this isn't much to go on, but if anyone has any ideas why it's
> not capturing ust events, I would be grateful.
> 

You can also run the application with the environment variable 
`LTTNG_UST_DEBUG=1`, which will produce some output on stderr that you 
can use to diagnose issues.

The verbose log from lttng-sessiond may also help. (Run it with `-vvv 
--verbose-consumer`)

> Finally, which 'event_type' should I search for in the event viewer
> for lttng_ust_tracef events?
> 

The event type is `lttng_ust_tracef:event`.

> Best regards
> David

thanks,
kienan

