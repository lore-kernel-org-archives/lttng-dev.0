Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571C3C282D1
	for <lttng-dev@archiver.kernel.org>; Thu,  6 Mar 2025 16:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1741277859;
	bh=OsEb6HWZX4atoAkOjTqI82UhLmd8qCxp23QGEfP140s=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=z9pG/L3l/0HiiW3BENqhiCpWtu0J3bETprNFF0FGyf2C4tXUwlsVHspSmhCD2IVfa
	 SyUFTfaW+yPBD3nuQkgDbJYTIjW4TrTiPkwm5xcaoq3pIlTSIpwnjw7+9lh2Zmye3B
	 XWpQQOCaXRxf/rMOVG+0qSXHkCZfGRFouWf24f1qAu33p42En+PdOKzE79jeAVR+i8
	 P2LVur80AN5bMiPT9UbUPEOf0YgqDkk8Ct+0lrT+Jb7/63R9S+ORwPLrMvIU1JRc8U
	 AmVy7hlRl1s5tLmhxgNnUEet3whuB1qKdziXgq37QcJQpTDqgTIGVfHa2RXtSWBogr
	 KtDwBTR4xht1g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Z7vhf4WQYz1r7g;
	Thu,  6 Mar 2025 11:17:38 -0500 (EST)
Received: from YT3PR01CU008.outbound.protection.outlook.com
 (mail-canadacentralazon11020115.outbound.protection.outlook.com
 [52.101.189.115])
 by lists.lttng.org (Postfix) with ESMTPS id 4Z7vhd2cczz1rQZ
 for <lttng-dev@lists.lttng.org>; Thu,  6 Mar 2025 11:17:37 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0wllGvrfxZXe3+q9pfDMTTdc+6q4p51d70au5KQ2RIQsmBH1LIpvl3S7VVrQnwHiwFWL9ZG+sRC0EccaPgsUWT6uQobGyCOTu7lbk9NKZ02RsXC2ajqUlCsY2GURtQ6417LM3h3J/mxln+9GlazSwFi+zUZq923r4l6cnTFgsMR5BW3AWRo1E8zv3ISZszRAJRejUohkSq1dezJEYUwHjzL08KkkxSGdmKS/IpsTGK3Xun1kxrYMEhMpdWjOz31UuZzL3XLnT3jj4bDCSBPSGxMNf+TwmEGNkfFpgw6iORD10SoTs/IxikdWziA//vN/Bs+TUUoco/cxHWO/sG0xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sS4zRImBHQeweJV93arIzkCfvCJLJmmGEnZwWYB26WU=;
 b=IZroTGqLiu0FqufB2MCz+pIkP58Cqjk69H79FNpEoq0hXHneLtsVKXmAAsMQVhz6EWoHr92v/FoB4AgIGCXYeNL62hzj+uAJ9zAI65Z6PF4+jYUhZSHFt7ViNWXFZWmQjQKzX5QqWGaMFxNBzmZYCRRZ573pxOhEfS96IkYQ35qqnkKRwvC2DQs9UWtvezCefUuMLsdZmXEkPye/MO+bejuAKHNfycq24xZunNAX2Mjt2e9AyPcvjWMwxG1EquDJgG1h+4fNxZ74BIl64e5byAjFGXsIoaUnOKdrEKY5taP1jea+WaZDo2LU4Z1UteTVooy1lLqHiT67JWUaRMN0Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT3PR01MB6469.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:70::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 16:17:35 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 16:17:35 +0000
Message-ID: <ab5ea7b4-abd6-430e-bc2c-52762654301a@efficios.com>
Date: Thu, 6 Mar 2025 11:17:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: need help for avoiding system calls while using URCU (Userspace
 RCU)
To: =?UTF-8?B?5pa56ZS0?= <fangkaihit@163.com>, lttng-dev@lists.lttng.org
References: <5bfbaea6.79f9.19560340335.Coremail.fangkaihit@163.com>
Content-Language: en-US
In-Reply-To: <5bfbaea6.79f9.19560340335.Coremail.fangkaihit@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::11) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT3PR01MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: ef313228-8ca3-4a18-add5-08dd5cca681b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXFTeVZhTER1MUI4eTk4TXhIVWNTSDRwUTFlRDc1alY5WEZqUW0wT2hTNVZt?=
 =?utf-8?B?N3pnOHRldEVUa2YvMWlLdjB6cXJMbUltWFBtbW5CUmxkT2sxLzZuaDh0R012?=
 =?utf-8?B?WG5IL3BNMFp3cUNJRzh5MHVxaTI5TmRPWnVoMDBFbXZZRXVIQXpZMW1WUTNB?=
 =?utf-8?B?Qy9WblgvSkg1TVJLRWFkdHp1MkZ2am92clc3NnpOZW1Weld6QUNxVkI2Nnh2?=
 =?utf-8?B?cDk4cE50SEEzV3RYYUdVL0l5ekdQYUlFOThmbWNHeXhBVEpLMDRLVXluUnJl?=
 =?utf-8?B?Y0h0NjRacDBBakQ2ZjhhR2ZPaEhob0Vyd21HNS9Fb243TU5oZVBIQldSQW40?=
 =?utf-8?B?V3dtdE9mZFYvVkUraktHMklFTzRPQ3hGRlM0VHVHZWhxV0lNb0xnUmdDZVRv?=
 =?utf-8?B?Q3VJcjJ0NFMwUVllZ3V5ODZTNFp0cXdITnV2R3ExSFhTT1E3d3BRM0xhNlBs?=
 =?utf-8?B?QXdxN0x2U25Ib0k0RFBnd3dzZlg2RVZ1WkJwSWsxTFdSbnJGYXdtSzluamVG?=
 =?utf-8?B?VjFmSlhDUjM2ejd4SUVRdklUVjVRTGFrNVMrSkFpUVJsYnFzYitvaXp4SmdB?=
 =?utf-8?B?WXdLOWx6eUFqUUhuMk1neXJtRzFXSWtmM0dmaEo2WVZjRDcySWdPeDNJajhz?=
 =?utf-8?B?eVAzMHFjcEROdGNXRlNQc1F6eWVLbEt0NXNoWVdXbTJiMy9sSDdFM3g4cFFq?=
 =?utf-8?B?SWMyS2UzNmVSZFRHRkhBM0RKNkhXMkpXYStBNE56SWxyazBkSnJNZjdBMXZM?=
 =?utf-8?B?UWlnVGc3UjNUMlZWZGI3cHNPUnJrMGJuM09VT1JsNjNkSjgwU0gzdXYwZnNi?=
 =?utf-8?B?bldRTFg4UlVMV0paQlMyckFiUS83Qy9CaXRkSU90MUl2ZUVlOFV6Zy91NVdj?=
 =?utf-8?B?QzVmdkkxV1RVZjFURDBjVHIwdVZYQkx6Ykh2TFZNbi96VHpoTHZIQUoxakhq?=
 =?utf-8?B?RmsrN083Nklid0xqNXRWM20vVTBQc3FITGtsaURrYTdlb2lnSjdYb1NKNlZk?=
 =?utf-8?B?bDU4R2hJYWwwRy84Mm5hNVZhK0xOQk9lSUpDZEJ0dUZrZXFWanZJcmNGQWlU?=
 =?utf-8?B?ZkxPeVlkaTRCQlJpWHE0b2VYMWFyMnE1bVpBRGRpZEwrbUJjRTA4bEl5SGdk?=
 =?utf-8?B?YTBmOUFDaWhYUkdqbjNFclV2aFhLMHR3UFZWVWhzK2c2ZC9QV1pEekJhYjdI?=
 =?utf-8?B?K0xaRGNERzhnUDRjRHZ1Q1pvZk02V1NsMG41TCs4b1Y4bUkyVjU0QjBsd2x0?=
 =?utf-8?B?RWNqZkplMlBWUFRoVG5lRWs1UUtkeWNPbWtWM3lMVjdEdnZjYW8zWE5sRmtn?=
 =?utf-8?B?SGh4anhJSi9mMkM4YU5WcHpDbFNERXhuOTRMSWtDTWxvZS9URGV6RVBwTnM4?=
 =?utf-8?B?Z3NEd2J3Z1RoeWhwSmtaMHBYbmh6Ujk2TzJ1NlFBV3pPcm5UbnJxaVVNMGtZ?=
 =?utf-8?B?cGdnWVZrODIwVXNOQTNwb0RCcjBJOWRoWlZEMFZPVk9ZN0lyYTNpd1RtemJ6?=
 =?utf-8?B?UE5DcEl0V0ZCRUVaNXBVZmw3NGM5YksybWJPWXBKcFRnMGNTUnkra29nR0Er?=
 =?utf-8?B?M1F2WlM0Wk5uMCtJalNiM1pPZW5CQ2pGWnpkcGQ5ZlRRT3MwQmlhRGFvc3Q4?=
 =?utf-8?B?eXJqNnNRYWxrcXZJYnFQTklKN0o2N3BSYWhlTTROVmJDQmVTMHU2bGwxVElL?=
 =?utf-8?B?U3Bld3JaQ3FaOFVVakRVT1oyTkZoNnp0NGJFRGlmdjM5Sm5pUWV5Qy93aFls?=
 =?utf-8?B?RVRabTA5c0ZOdmdXTmJ4VmVoZXRnNkdTTjF5WmdjU1MweXZTSzluNmZ4V3VZ?=
 =?utf-8?B?VTViSFRLbTlZa0h3dC9Ib0dtTGxaeTRFNEJLOWV3dVJFbFBRWExUaEwyYmhX?=
 =?utf-8?Q?HJJbvY1IICkNN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3ZZS1JyOW1wNkdseDlHcisrSHRkZU5rOWZNbDkrbVJrU3lIUTJmTVN6OFNm?=
 =?utf-8?B?V2tLWXBCczlqanhDZm56c0p3bFNaV3FrRWV0VS9RR0d0aVBZdmlpU203QTd3?=
 =?utf-8?B?dkErRGNYWG9VNGZFak9aYlczaC9ORjllVm5qWTNNTy81K3pqSDg3MExsSEFt?=
 =?utf-8?B?eXVNcGdGSDlUVmJxTXlxYmxUTTYzVUZhR21pa0FZRlVlZVNyNGxZSG53OFFx?=
 =?utf-8?B?dElEbVNSeklyWXhVYVoyVzYwWlR0c0QxTDhXZ1UxZEF2bVE5OVozYVU3a0Zo?=
 =?utf-8?B?RjFWZlBtSU1RK01jSVZtMWJ2bXBlUGM5WTJkQnlxTDNQMHNJNlVURmU5Qyti?=
 =?utf-8?B?SzRUeHYzWllJTkZNZnFla0RpWWVUcWpraElvNC9SOVFsL0Jnd1pWQlNHcVpP?=
 =?utf-8?B?b0xlRXYrc3prbmVHMHZGN2FWZDh6NWlSMFRPdFY3aHUyMTNUbkdXeWl5dnRL?=
 =?utf-8?B?UVI2a1psbS95WXYvTnZXRk1MYWRDZ1lsVnRkKzRzZThIekptVzlpMUVKR0dq?=
 =?utf-8?B?RlNWLzM5N0xLeURlcEo3bWZOUllsWUhiU1VSNlhCNnZwTTJucXA5SWthYXBE?=
 =?utf-8?B?ayszc0E5NzRTdWtoalFnVFdCOTZveTZ5cUtld1kwbHI3Z0gyc3VXTXRJamM0?=
 =?utf-8?B?RndZRm1wQ2wzMFNiUGVCTnRNeC9jL2NiamVlai9hREVBMmpKN1NFYmxJaFdy?=
 =?utf-8?B?YzhYTytNNC9XZnFGTXlIRWl5dUQ2bzVzbTRPTXdGK29ORW9ONFJkUG8wNEJT?=
 =?utf-8?B?VDNZY3J0ZUdVS0xqemt2UEJPVzZsQVRtK1lEOGUreTBzQW5tQ2t0cnY4dnkx?=
 =?utf-8?B?MTlodmdvRDc3N3pSY3BDZHd0em5PYUVrL2VtSVptckhwdjRYSUpndm9raXpp?=
 =?utf-8?B?SWxNNmtsM3pUN0N3VFJtM0paSG1tVE9oYnBRR0NsY283VWhMYzhLWnpoTmdF?=
 =?utf-8?B?YVdZUmhGSnpFb2xhb2k5aTFqQXJkZWZ5bGVydmlkVHFGemhtUlduUmJLUUdB?=
 =?utf-8?B?VE56OWJldU9mSmdPazM1bzk0eFVzN0d0VW42WE04WjdMalltb2xJa3hiTFJH?=
 =?utf-8?B?SnlpTDR1Y0JEZUNBMEpoeG4rZitkcWpKSXhyS2lNL3h1b3ZzelBRRkNUT29W?=
 =?utf-8?B?ZWFqZ050bERvM1c5RWFmT0xtU01vcUZGUDJ4MUwyRHhhVHZHaHpHMVp0MTQ0?=
 =?utf-8?B?MjlMdDQrWU1ON2dWUW1YNW9vazVINi8wb3k4L3RSS1ovRzZlNVNUZDBjM1NU?=
 =?utf-8?B?bDVHNWlnQU1MMFlTdjVhS3hrTldYSHFwTEJuNlRDaGRnVDJjNXNUQTl1a1lF?=
 =?utf-8?B?STFHMW5jMUE4dEVTSElJelVOQjd0R1pzYlBFRWxkL2RjZHl3U29UZDBseFA0?=
 =?utf-8?B?RmFjb3RLOFNNNllyZi9mVUxaY1d0OE9RY0pZK1VYeGlXRkJRbXlCa3NvR3gr?=
 =?utf-8?B?VnJINnpSUWZxNUdTSkZ4MGJNMm9tRGNxN3kxVDdEMHEveGtGbXRaWnAyd0l4?=
 =?utf-8?B?bnZ1NzFKV256YWNPNXN2MDNrZ1NQZ29DRHBLVzk5YUtEQmlWOVNOMEVDUm4v?=
 =?utf-8?B?ek9BRGNMdmFWdG9jWXdEemhRWmM1Q2hERnV6cWlwOGJzZ0dmMnZ4aGR6M2hN?=
 =?utf-8?B?OFpvekNpcGZKdXcwekllc1d5U3BDYWxFQUw1a0lkSmw0dzRPYUJVRFRzWTE0?=
 =?utf-8?B?YnN6d0lib1dYQm9Xc2NYb0I5b1JrRTFVeDRwL0VNL21QTEkxU29sV3gvSHZS?=
 =?utf-8?B?WjQ3bXUrUUxQS1V2U1VVY2J6YVA1TGxIcnNZMnBKRWJWZnlPb3ZlQmFBT0M1?=
 =?utf-8?B?Z3plWVBjdzR5cnpNK05ZeDU4cFdrTDNhS1BnTUsyWEgvelEveUpXOGM1MkdO?=
 =?utf-8?B?NFNtYTdkT2pDQUJOSGtudUF2TWJqMUxMUWllQ1dCNG53alFEbUNQczY3czNN?=
 =?utf-8?B?T2hvYTUvV01OOEJ3TUhUT3grYUVuaDlhSWEwSU1rb0ZZU2xHQU5HVU41cmg4?=
 =?utf-8?B?dTRwYmJ3MFZtQnVxQ1ZJaUJub2cvVGMvakF2aEVsYngrdlNQSDBIc3BkTnNo?=
 =?utf-8?B?VmdWdENKSUVVWVQ1NWN2SUZNdXYreVNjclN3d1h1TEdtZ05VamtkbDc4Rm5B?=
 =?utf-8?B?aUh3K0ROTkQrZUg2Smo3SXFSTUErMUlnUEdabzhlcUZZSTdhSmxVTkI5RWRH?=
 =?utf-8?B?UkE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef313228-8ca3-4a18-add5-08dd5cca681b
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 16:17:35.7647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6SIU3Gzzn4h8yY7uaYEfPEDOBA3e+1iOuwTh5sqbMtLxQOvA2ApVpAS2A9ZLhM1UfIJlY+Z7GAEHiWMhcpvUEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6469
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

Hi 方锴,

On 3/4/25 3:09 AM, 方锴 via lttng-dev wrote:

> I have referenced your project, URCU (Userspace RCU), on GitHub, which is based on the QSBR model. However, I 
noticed that when using it in user mode, it makes system calls to enter 
the kernel. Could you please provide guidance on how to address this issue?

Are there specific parts of the API that you need to be user-space only?

 > I aim to achieve a pure user-mode implementation. Specifically, I 
would appreciate any insights or suggestions on avoiding system calls 
while still maintaining the functionality of the QSBR model in user 
space. Thank you very much for your time and assistance.

Currently the locking is done using futexs, which are system calls. 
Those could potentially be replaced with a poll/retry system either in a 
different flavour of URCU or at build-time.

thanks,
kienan
