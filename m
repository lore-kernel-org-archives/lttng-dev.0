Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F362C3ABD8
	for <lttng-dev@archiver.kernel.org>; Wed, 14 May 2025 19:57:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZyPJn4TsFz10kZ
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1747252665;
	b=Td+u4WBYzhYsAVHDLHd3NYDsEhD4XkLPJKU+uxPPW05bfzulEJO2THbdRTL7X3eizC70
	 oVIgthY+3BlOROZ7Em8HLrr/MvnEvtqDCfSDE/JQsoWBLF5JY9vpaT2/YlCY3x04oDuhQ
	 JZgKY1+57CtsTQRmLfbWkR0V73sHu6QphlMfPVeb1cZtY9rv/ihhcEJ4cyG0K5u8apu4i
	 HDi+mTXx+ID5Lw6ppYlxNF/OpqpSeXK14bj3fQU77minrGFJpb1Tz5xHVeBOkp0h4OYpn
	 aKPdhT4fh5A5jeyy+tEnaSIC77xd08hJ2kZmUqgaQptPbFDH1OUmVa5RSccNgfrkBpA==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1747252665;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=aaJ5WxBsT4ZdW98fqiDI7MiuNRzA2dEVmLu7ri05B+M=;
	b=kH3WgX+JT2VdqfGCv2MkIHGDBMoBHCB5FxsB6QIQVg4huhKh/yNXDKFvHJzSr15s3B55
	 tEls639wAzmkKIPlQuALdeCWdcgInrRft4hMC4e6R4SzibtN64uQEYYJlqr1Xvj8GUBWA
	 W7tkrEsFQPnDLhUJXG52o/Zd1bXXLrjRm0ZVRTOod0nzQ402dek8VI+idSJBsbtQnGpj+
	 NCf1Y4EkiPU+b41PdqdWoMQpROkFH2MKnEBzxD0nR1i+X79vg+T1XMinDAkG8c5T++NK/
	 SeaCBTwS9P97J4W4KrSAin4yitN4bQ8L6i6PiT7wj5sFxO6XJWloTqKrAC+krV470Rw==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZyPJn4TsFz10kZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1747252665;
	bh=aaJ5WxBsT4ZdW98fqiDI7MiuNRzA2dEVmLu7ri05B+M=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=DPTiEkEJs7nYPFV1hP8EFiq3ZNxb+AsrfdNd1s7eDw7saIrs6qiN9bQQBYlSwiarl
	 Z5/zoKg3VthZVG1q/GQEiTNKlOv3/S2loyHPPVcjTeYTWBykNrek7zP2Oz/V7jW3r8
	 DbPFxQBKacjooIm1Bvp8ASXmCpFKIQ4HPj6Gi6Zt3V/XePWYCE1/X7mGEs/9QFdqqc
	 VwuvagrsoHoSk8mDGXX/tMjGOJP7Y7GIYjJyxI7cftfJXHj2L/RuR8I2Gu3wGR+leS
	 gOaEmiPktCLdUw6YQNPoDeEdstxSy8p9lgcRvWp2hAh90Oylez4CxvYLK8/2IpqlbP
	 kvhlnhScfKAWQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ZyPJn4TsFz10kZ;
	Wed, 14 May 2025 15:57:45 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZyPJm4kF1z10bk
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZyPJm4kF1z10bk
Received: from YT6PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::3])
 by lists.lttng.org (Postfix) with ESMTPS id 4ZyPJm4kF1z10bk
 for <lttng-dev@lists.lttng.org>; Wed, 14 May 2025 15:57:44 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=StzVMiBiBKMP6RBXuzairFEjS2dYmHAjIB1WNYuN5Wwuf0KnT+sXEvfu0pFvGyd5EBcIQ5vvJZgix21ZZ9tSlyjdB5/Fr7/fkWXwsRdmh5xg1p+9LwyKk6O6q/LdyXdPpwek20iaht/DSzmTb34hw/iTiYuRgEQUGVc0kHGDq4FchP8RJXS/pnaAMu6mRAshUnhyAnOss3NrLPbi5LlByJWo+tipgrTffCQhNIqQXk4rm5HpRylxikbcuLERpzhkYnZbbADihsW+TIclFc1FixiOXdzx8pjQDkyqh8Hyx0/wniQXLSsZ/+UKPqx4ID6uFPDhgWO+uTdXQqFjpd4Vsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ha5xoudPHrKQ0a1faDBiYck8Ovi/BouLpQq0LvQltsw=;
 b=kuelbT4ez+4QGTSJcu3LNz9YIv7oSYCwY4167CRas4XDe0poSwr9otUtUpE++veIT38cvF0pK07ymEqeVIGnIBpYVHI1i6e00wIMbvx1RKIs05wTy8FoNk1sRvNfojv3WkHTG71mxEKG9+yqW4safMHZDhyA0CLEIY7QcUlEcN7HUvxU9T0RPyHnulDpnMXGOpLotJJrCqOcYQ7gBbkZcfruBkbreyChoZHyzxL2JE4qMVGOT0hRu2C2CIGMLF1Hfo2pCE4Frtqj+MC9jvePcDiX8HVlGUj7JZOKSBPSJNhc3rGCFQcB7i0rS8UY9edFE+jgHsFUfPcZyMx2pam33g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT3PR01MB10347.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:91::8)
 by YT5PR01MB11130.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:137::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Wed, 14 May
 2025 19:57:40 +0000
Received: from YT3PR01MB10347.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6d35:443f:e789:df9f]) by YT3PR01MB10347.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6d35:443f:e789:df9f%7]) with mapi id 15.20.8722.031; Wed, 14 May 2025
 19:57:40 +0000
Message-ID: <7b925d07-87b9-4d64-87c4-6f787b8e2856@efficios.com>
Date: Wed, 14 May 2025 15:57:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: lttng-modules-2.13.18 Condition for Kernel 5.14.0-582.el9.x86_64
 of Centos Stream 9.
To: Jean-Marc Chevalier <jean-marc.chevalier@polymtl.ca>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <YT3PR01MB6421C77EF52F3D7A62651E93DC91A@YT3PR01MB6421.CANPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <YT3PR01MB6421C77EF52F3D7A62651E93DC91A@YT3PR01MB6421.CANPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::23) To YT3PR01MB10347.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:91::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB10347:EE_|YT5PR01MB11130:EE_
X-MS-Office365-Filtering-Correlation-Id: fda6d3b6-ad2b-40d6-3437-08dd93219511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVY5cWN5N1Uwbm85TVBHR3FUS3ZTN2gzQ3loakVJY1EvSmZlbSs5ZWF1VzQ0?=
 =?utf-8?B?WUoyN1hkaUNUcWlZVzg3dm5ZVkN1SDhNY1hDSDlrZS9FRUZ6bm5wQjdpVU9D?=
 =?utf-8?B?Q0VLQ0NlNFBUWW8wNG01WlRNNXoyczlZZXhrbFNoWE5XckdhQmdYaEFsZXV4?=
 =?utf-8?B?WUh6bjlDY3hKNjVBaXNRSS9DUVlQUHg1aEhwMC8vL215MUdwYUp1bk5acE9j?=
 =?utf-8?B?Wm5NRFhMTnVZZ3lYenZIbXU2K2xVcFhMVnI4b1A5UVArekFCMnR3L1MvUHRK?=
 =?utf-8?B?bnBERmdsL0prM1hOVlFHaXdqdUNHcmYvSmg1QUhLR3Jlelh0NXRLV3Jya2Ev?=
 =?utf-8?B?QTJ2bklqTjJUa3BHa0JCOVRsYUJSU3ZFZjJYckJsWWp2Mkw3clVmZ3NJRmVN?=
 =?utf-8?B?anRSdHdTdXNmV2I5RnBXMEtSaUlLNVUxUlN3WVp3T3pranBCTWFKblowK3gx?=
 =?utf-8?B?SytpWHF6SUpFamVpWHdOTEhSYlFVYzY2V3lXWDFkdEc3NkJxOWhVZ3VRdHBX?=
 =?utf-8?B?L2dSUlpYd1lTNnZNN01PdTZNdHhKVHpYQzlET1pUNHhyTXN2OVZVdms2aU8z?=
 =?utf-8?B?KzVMelI3VFdIME9jbTRPUmxyZ3h4ZHp5NCtCeStRMGVuSk9NTmFsY1hTL0pK?=
 =?utf-8?B?Q2hoV3FFckdxdXZnNEIrTVhPQXlwbysxOTJ3ZGI2Z2dUSnVkNG5EaWt3TWJa?=
 =?utf-8?B?MHpEYldacDd4Mk84THdPOERXMmdvN3h0MmdhbWQvRERQM2JDMTlDYW1ZcUU0?=
 =?utf-8?B?UGFMdEhHVFJFNkJZeGhtOTg4eUJMV2o2WGlEOEZZWC9FRXE3ZkpDREVYVWxm?=
 =?utf-8?B?Zkt1TmV2Sm9rZUpNNjhpQ3NpRWRsNUJ0eGd1UGhQTmdQQ1JTRlcyQnhpNDVy?=
 =?utf-8?B?KytSdjJ2UWFmbjVCZ0pYVGxHdGdhcGtVSVp5QnU2NHZoQjEwaFlYeGZ1MzZV?=
 =?utf-8?B?Yk9nUjU3eG83eCtKMkI2dWo4OVR4ckxjZjV0dWZ2cGozZXJ4M21rbkRrZmI5?=
 =?utf-8?B?bDhRTDZRbndzNlN3NWJ2b0ZYVHVFY0N5ZmhCWEpPd1NBZzM3U243cXp5Z2tm?=
 =?utf-8?B?aTI0THpqWUhWRGNuR05hVC9qV1pXNmlrY29ER1oyc2p0N2tWT0t3dGMrR1hK?=
 =?utf-8?B?c29QZlNqU1Q1VWxHMC8vR3JJYzFERTAyV3ZOVjFKc2RTU0ZtWjBkNStiV2Rx?=
 =?utf-8?B?ZTR6Y2ZTY1hoMHdOcEd4Ri9OVU9PRHNXTHhackN6NHNSaXFoaHZ6ZTFwb0N0?=
 =?utf-8?B?Q2JSbUc4SjYyNmg1TVA2VlVITUFHYTlJazlqckFMa2VVWm1mdytrUmVNQUtN?=
 =?utf-8?B?NTBVZEJEOHBFZlFVRHVYcEdZV2EwbUVZdHJTZkYxRjg2MGhmWnFlSWNacDlt?=
 =?utf-8?B?ZU16Q3NWMHBPb0JmTDQzN0FYR2oyWnNBYjFhRWVhMFpEOWdDMFk0TXpjR01E?=
 =?utf-8?B?SHVEbVVDOEd1QndzeXVpQTgzOGJCWURKblhGeGluRjZ3RjhwUXJNNzFQRkpj?=
 =?utf-8?B?S3pKbDludXF4bWJMZ3o2MWJNQTkxRXhkdVB6Ui9TeFhMRFVzckg2VnRaUjN2?=
 =?utf-8?B?bTZodTljM1JzSTQ3ODVlams2YmVybGlKWVNJMmpCSyt0SG42UFBKbitVQm5B?=
 =?utf-8?B?YmtuU0NtNUQvRERrWHZ4NDU5dHMyYVI2TE5GNG8vVVJmSThKVExCTjF0ZVps?=
 =?utf-8?B?d3ZQeWxnQWRUY084YUxsWFBHaFRIMjNFNWhjQWFDenFObVE1SWhPUmNpMS80?=
 =?utf-8?B?b01pcXdkMkk3TFZxZ2l6N21ibHhwNHdzeHZoTFVSbTcvb0p6S2pvSTR6dlFW?=
 =?utf-8?B?aXd4eENoejF0eDgyRk5PdGM5Ry9OenpDaFhuY2ZsNjZRMnJPNXU3ZnVkS2xw?=
 =?utf-8?B?amo5ZnVWcUw0R1B3cHRRZUljYmk3K1NnYWI5RE5NSFovNFNjTU9kOWU5UTB3?=
 =?utf-8?Q?uBK9FNFGNKA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT3PR01MB10347.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFV6Y3lEMFdCT0dlSVJJajF1V2xKN09iNjdkcldOUnFZNndmcFN3cHNuM0JI?=
 =?utf-8?B?eUMzSE54azk1c1cyL0hzbEp4Qm4xU2s5cERuNVAzSzJ0dmZoNGwwTU9nUVMy?=
 =?utf-8?B?OXJYanQrQ0RCNG1TcDNZRWt0UVF2SEs3V2NZanRuTDNTS2RYaVBFUFdFSjlO?=
 =?utf-8?B?RmtBNlllOEhySHNqV3RTRkRlVXNVbmo5UnhYay9JQThraDBlZ2JjdUlZNFZB?=
 =?utf-8?B?eHM4aS9Oc01waE56N1NrUG5KU2k1czBSRllpODRmNU1rVEQ3MGMzdDgrc0FG?=
 =?utf-8?B?NkEvekdyRkxITHEvUkJnWEllclFub1kvNWt4RlFuaTZnRGNhVnNwQm1WTkNz?=
 =?utf-8?B?eTNiNzlHZW0rSXlxemh6aTVSNmt6dW9IVkpTdzBlR20xZGpuQ21tR3VhTzNY?=
 =?utf-8?B?ZXl2UFRrTzZoemJIcGR6ZWs1VzlJWFZUU3IrY0VGdEk3ZDZtUDBML2tsUkMx?=
 =?utf-8?B?UytDOXNuUGxDUnVOYkJISzY2b1FPZHd5ekFTT1YzRlFSMG9zeFYwdFJTR0xL?=
 =?utf-8?B?WGM2NEhrWmY5YlIxeDRST2srcWE0RHRUZDNablhSb3QxNGpYTFQ5ZDRHLzFL?=
 =?utf-8?B?OUJHeXYycVBQOXdRZ2c4cXljUU1DQXlITkNyd2xNSTRkUjVuUG9manBVU1VG?=
 =?utf-8?B?T3NvQWRueU9pdkxaQ1dIaTFXNFp5OHBiWHF6UWJrOUl5RmZiNjBMMXdxSDd6?=
 =?utf-8?B?MVBKNFRjbTdnYlpIWmNXamZhWlJmTVJlaWtjcnp3NFFQVmpTTXJnQ0dqejJ3?=
 =?utf-8?B?Z1hWQk4xNTFWaXZxODd4MnY2NGJDd0hCVkJLc2J5NlNScjdGQ2ZDUU9qZnVa?=
 =?utf-8?B?Z3ZUNmNpM0JqT2l2QmtLempYU2pNR3RGWHBla2ZQeG9IMjQzQit0ZGMrdFAy?=
 =?utf-8?B?Y1ZWZEwyeE1ESCtmeHRPWHZ0MVp6YjRhUE5NdEFXeDRJMUQrNWdFalh2ckRQ?=
 =?utf-8?B?bnludGFLY1FvVlJVS1B4eWhLUU1ZTVNmRExReVNzZDVaMUsvMkJudGVjRW13?=
 =?utf-8?B?R2ZZaG5YaEFxalljZVdoempIY2JUWThOaW9oM2lRSW1CL0FXQ2wralRaRlZY?=
 =?utf-8?B?NmhEMy9qTzNtMWFtSldUbzJ5bmxTYmpOZkxDbGdsZVlKblN6TUdtNG1tcDd5?=
 =?utf-8?B?RmFMT3RKWk0rTXY5V0ZHSXBmZDdMbEFuaWZHbWVxRVE5VUQ0QzI4SzJoUVlk?=
 =?utf-8?B?M21vVDdyaG5oaFgrKzh5REhlR1hLdUs5RXhnaXZra1Z2Z0x1ajBUZzQ4U3hx?=
 =?utf-8?B?UHowVVluMnBhcHllYUJEZzVqOExMNU1SSlNrQXdmVlZ0eE8zKzk5eVNDNDVa?=
 =?utf-8?B?aCtkMCt0QkRxYnVsRWpPcForU0xmZGpJcVFROHNUZDByMWt3a1NCUTBOVnRZ?=
 =?utf-8?B?VTNOa2VLSVZ3L0gxZ0hWQ3VKYTZ0U3JqOTNVazRPU2ZDbHpweXo0RWxCSDJH?=
 =?utf-8?B?Q0ttamQrT3B2RG8yWnI3R3l0dDNVdjZkdlpJdlRSOVFNeXFIMWxwWjR1bjB5?=
 =?utf-8?B?SmxoazVYQWhjTzB4UnJpTUswVlBYVUVYeFEyRUlJYk0xODI4VzJ4TUlUQTl3?=
 =?utf-8?B?UmdTMHZSTjQ3OG5DdDliL2dMbGpRMFZmaGE4d0djbEczUVVaY1E1T2tBa0xy?=
 =?utf-8?B?eGszSTVIVWEvcFdRL1llTVRlUUx1ZGNYcmN5UXBMOERCS1hUNjJGOXIvdDJE?=
 =?utf-8?B?a1VNQ1RJeFdQalVTc285TkZSb2dNb0I0WHpjZ0loanJ3OFc1WnRKeVpIMVRM?=
 =?utf-8?B?VDQvUXNCMXdQejlRWmtUM2RYK05rWFdJYzl5L2o1ZDBsRWVCalJ5eXZrZkVW?=
 =?utf-8?B?dUozb3lPZHUra29oMlpOSVNFcmZCSzVnNzdsNnhxbkRaaHBVMlZZYThXcCtB?=
 =?utf-8?B?cUxBb1dqOUgvaG8wcXlJTmVlR051cmlxbVVxM3ZDMFcreE5sQUNoY1JxYmQ5?=
 =?utf-8?B?Q3hNckM2Q2ozMVg3KzNuTmdrT0w0MnRCTTh5UW42Q2dpa0NLTkpWeVFHMERj?=
 =?utf-8?B?LzFZVG10SlNDTVdORHY5ckw1VVVmYXpBbWFqcGpnMmE1TFU1QUJSZDg1Y3lv?=
 =?utf-8?B?Y2JFMkc2WnNNSDFjU0txVjFpRkhvTkloVUNodkNEUWxKM2lDOW1vNktXUmV2?=
 =?utf-8?Q?PISy/j3crCHWdq/DrRFkNw4vQ?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda6d3b6-ad2b-40d6-3437-08dd93219511
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB10347.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 19:57:40.2300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpDeHBNeqUlUbEu4avbUX/XUUISWaJ8nIi+mBdXLuyD3B0v4dV6E21VS14kUm2MgxGKvUUvOp8f7sW9eo+DLMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT5PR01MB11130
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

Hi Jean-Marc,

On 5/14/25 3:16 PM, Jean-Marc Chevalier via lttng-dev wrote:
> For lttng-modules-2.13.18
> 
> I have this error with kernel version 5.14.0-582.el9.x86_64:
> 
> lttng-modules-2.13.18/src/lttng-statedump-impl.c:415:20: error: 'dev_base_lock' undeclared (first use in this function); did you mean 'device_lock'?
> 
> I got it to create modules by changing the condition on line 396
> 
> Original:
> #if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,9,0))
> 
> Modification:
> #if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,9,0)) || (LTTNG_LINUX_VERSION_CODE == LTTNG_KERNEL_VERSION(5,14,0))
> 
> I don't know how you distinguish the version after the dash character for RHEL kernels.
> 

For RHEL kernels you can use the LTTNG_RHEL_KERNEL_RANGE macro. E.g.

```
LTTNG_RHEL_KERNEL_RANGE(5,14,0,503,21,1,  5,15,0,0,0,0))
```

thanks,
kienan

> - JM
> 
> --
> - Jean-Marc Chevalier
>    Technicien
>    Génie informatique Génie logiciel
>    Local:     M-4002
>    Téléphone: 514-340-4711 x4266
> 

