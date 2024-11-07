Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200ADD43374
	for <lttng-dev@archiver.kernel.org>; Thu,  7 Nov 2024 16:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1730996180;
	bh=muZYQjZD3xzndDOVq5hK2DCNNaPg6e65uHpgvyj5RY4=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=uQlQt7QrHboxwDL7j9wLLoqGLyVt6dHDFE4HZLztuOb3zrodJYxVXBeKCGEkI+rR+
	 Otj4xTpFkOo+2odcJbjsM/4wJGf6gETHo8zAPjVmE0s6VXaVxQaoPv/nyiI8WTdnVE
	 rAnMmuPaMQSB6AdruF9GzqHOyFeZJocTRtEADp5GwmENKpVIGLsSZpy1niivqkepRW
	 XV4cg0u/v5/nnsQHSOxHaiU1EbEghCA0D0IaoqjPs44I644hki5HVCfztVHCzn7K3A
	 FZOUUH90VloffuBu91LZ04Twnnsx6fk69y4nUXIi8fXa9RhwTSKG+uw5y63j/x/lHa
	 V9b70KlBktsnA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4XknJ373yvz1y0j;
	Thu,  7 Nov 2024 11:16:19 -0500 (EST)
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c104::1])
 by lists.lttng.org (Postfix) with ESMTPS id 4XknJ24myHz1y0g
 for <lttng-dev@lists.lttng.org>; Thu,  7 Nov 2024 11:16:18 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBoPNIg+rM1SNbnSwDglKWvRDWV9NUwoIVpAMJ3dWY9ckbmEysK6zvMu+aLwLaxkY4yooUmMT7L7JPVUeZF7B024N1+TNTfgmOy5ztkxUI0rrRGP5FbhAvEWoijV6i/EAhRlA79tAKvnTX73FAT6mmdng2EZdGU7hMaI0qSkUs5EWlwjZPDHS+ExaYGshd1N6AePH+m4cBSrN3blfBedNyAmEmURtEXQJQnwzys8WhXKPGBa0ofz4WllaDR7r7cdwV+qJYpKt1MwxASzeJRyvIsAg32r2aNEnpRlMQcMRxQxAqic6gQS5v2HIV1oiffsTBAuZ+0+ZDAbwngMrU+5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZj78uevvU5aOEKOCfZ9OWscP6X5ESdNasHtYDYL8pY=;
 b=omzvpJ/IoRgAiEzW4IBNsvDO5lJynbtt0lSANL2xDAXTDv3HvmyPMRLpZwW38s3wVXxaVIh0STu3uBDyxD9Rz0yt3cMbpiDq399s73l90bCkR9vT99ivP4vUo1tf4jXUPuoi4kTijpdAM6p2mTRhktBElNKc3BXkwpkNb6sVhqhewr5ectkDl1lHZyE6+rW8aO52Ri4+n2cSK09D6ljzx4D+D+jxIdihxoUWv8RlDtUf2xxsaAgdGwaH9zXnl4TUOaBOPG9WOvrpbHp9zDDOwwDJbD87SHG/YXrKWNy4eBapbGU2+wX1ggIOSLlkQSPxBne8UYPjCvqsApbEpIYsvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:24::5)
 by YT2PR01MB8615.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 16:16:15 +0000
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::be09:e1b:b343:7f9]) by YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::be09:e1b:b343:7f9%6]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 16:16:15 +0000
Message-ID: <fe043fc4-b5fc-41ef-83b4-da6c6cfdd0c0@efficios.com>
Date: Thu, 7 Nov 2024 11:16:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel tracing from inside a Docker container
To: Dirk Eibach <dirk.eibach@googlemail.com>
Cc: lttng-dev@lists.lttng.org
References: <CANVMifJSWE9GNhcdMkVqrAxKsNwrbEVuL1Wd+4YzO9FrbeabFg@mail.gmail.com>
 <7f55ec8e-7af3-4af0-9ac9-f7ab4e00345f@efficios.com>
 <CANVMif+RVoKyWu9FY1_9Z3hd_JpcrRuGLue6V3_5X0P2wmUEaA@mail.gmail.com>
 <CANVMifJ1YQtTkJVop-CmtaDd2+ggU-2n5D6u8Wu3DhKcFER=7Q@mail.gmail.com>
Content-Language: en-CA
In-Reply-To: <CANVMifJ1YQtTkJVop-CmtaDd2+ggU-2n5D6u8Wu3DhKcFER=7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0212.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::18) To YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:24::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB5080:EE_|YT2PR01MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: fafbe3c1-dae1-4949-bd97-08dcff4780fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGh1UmtTZWVCOHh0cmxBODhyemFRNXUwYmNKNmdZbFh4V0Rpb0ZTbkJRN29a?=
 =?utf-8?B?NWs1V21uR2dkQi9XZkFIMmhvVlNBYW5RNjY4VFRDTWRGam1ZVGNYY0ZmNUY1?=
 =?utf-8?B?aDNqb084aFlwbSt1WEFickg5UmR0eWlCMS9RZ0dxUGxLREFubWlHUmdaakRE?=
 =?utf-8?B?VW1MNHZ5Umw1bm1XTWRML1FYV29mQlFUMk5IcDNObngweG11Q1RHaTNHbmRX?=
 =?utf-8?B?V3lSK3Q4U2VzWTVjOGVicEc3Ty9Qa2llY29jY0JEVDlpRDJCZ0hjN2NHWFFL?=
 =?utf-8?B?Z1pZa1JnNWJHb25SUnlJS3RORlpYNldaNTNXZDRhMDVBcDZMRE1NWlAxNEpK?=
 =?utf-8?B?ZnZCTWN3VVpIemZ4TEdxYnQvRjJUaE9SRFk1VEV1QUlhSzhxQkdKOUw3bS83?=
 =?utf-8?B?dWRIOC9xZDBBbHpSbHdrRDduZHdWcWVVYkJFRTVndmQzSy9wODRqaUhrWjlj?=
 =?utf-8?B?WnJGWXpDdVhxR1VrUUxkRmxmTTUrUmNPR1ZEYzBmcGYvWTY1ZXNsQy9YM3Y3?=
 =?utf-8?B?ZlVhTFkvUzl4bHVvWE1lVUVVWmNyd1MyZWVkOHFrWFFBc1NMSUgwanp6eE9x?=
 =?utf-8?B?RHpnQzBsamxmdGk2WmxWcmI4VzY1MEtkekNxUlNxNUo1ZDNsV0ZXNjRQV2hR?=
 =?utf-8?B?NzdrTWRRYWdjbCs1bjVOdkd2N0dqOXF6U1dZNE1OMnFPSlhRMzRzSjdxNk9G?=
 =?utf-8?B?ekg2TTB3bXJKNkFVN0h4T29FdExvNjM5Y0l6dW1iNkNTeE1YY04wa2VQUGlu?=
 =?utf-8?B?djJnVE5udkdlODdaTWFMV3kzdTFYWVBkUlVEUEdlNTlnNndOTG1uTDZXalc2?=
 =?utf-8?B?dUl1V20zdUhNZEdrSnF5eFFiVmFXaGFPSWY1KzljeDU0Wmh3RjNxMG02Qk5Z?=
 =?utf-8?B?NmNZRm9kZWtXcUNzaVlkY0hPdEdCN2g4QmJ4WHVNNVVlTXpjVGFOL2o2YkpD?=
 =?utf-8?B?VGQyTS9jaUZaTWY4b0hoNEtnOTk1WjlhWjJWZlpIK0lSZmwramdUdncrQ3o3?=
 =?utf-8?B?RWZjU1NWNEtRRGdzc0hJbnBFRlh5RUtkZnQvZ3pFTHE5L1pSZ3B6S2FpNUlR?=
 =?utf-8?B?OGRVYVBGZUt0T0dsV3RudXpPSWJGVHlXOTNaMzdLQjJzUWE5OFQ1bHRSRytJ?=
 =?utf-8?B?WVV3VDdXZk12V2locjVwamEwL204Y3dubEdiWGg3ck5KZHZyLzNtdUFYSXJM?=
 =?utf-8?B?L0FHTmVJVndhSEJQaXowdE9xTUJUTjFTZXFlZWdqZGxTWFNZUkc1bWlnQnRQ?=
 =?utf-8?B?cVNSRmxUQlZUUFp2TnYvUnRtdVhFYVJrTTRwejMxSFhMa2hNWjdQWjRHSlNU?=
 =?utf-8?B?RjAybE9PWTJNQWtuNWl4dTBpNkRNaGZWVHJyRDlqU2xxM1ZGbUFGT2pLcTAw?=
 =?utf-8?B?Rm5USiswSjQ3NHA5OTRHdlVyeFJuMUluLzBtc2Q4TmFhaE4zV09NOEVqaGVy?=
 =?utf-8?B?YThrdTFYVFFVQzI0czlsbjVpLzBjdUsxamNhUkpRMzJZY2ZrblhCUG8wV2ly?=
 =?utf-8?B?RzlPTFRmL3YzTlBUQU9tUWZzMUVGKzNZRzJaNDB6ejgxWWlXekJCOVA1OVFH?=
 =?utf-8?B?N3Z1dTVKQTNBYXNoR3A4K0F3NlU4OGlTWFo4aStrTDlCTzg1MXMyL1plSUMz?=
 =?utf-8?B?dkFnckNRZnBRa1pObi9oWEl3R28xRVZRUUMzeDBSUzJabUN2eG4wbnN0cjZo?=
 =?utf-8?B?RnlRdkNSazYrWU9qL2FiSG5uamFzd01MbXdVZ3lFU2dZK1p3dUd1K1lSMWtD?=
 =?utf-8?Q?hvmBRe4aqGpyHVqH+o+fdasEeg44KwHT2sIHype?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkgzOUYvUjZFN2ptUmJ2alc0QWEyTW41S2IxMjlvOHFjYldaYjVXR3pDcUVv?=
 =?utf-8?B?QVh4SDlRK3FpOGFOU1BiNTc2cjN5VlYwRldiVHhGaUFpa0hDUUtqbFRlekJF?=
 =?utf-8?B?QUIvTktKQ282UkJvUzFCKy9PdzFyQVF0VmRVL2hOWllPZWlaT1ZNUnRHWnRF?=
 =?utf-8?B?U0xEbW5YS01GV2tDa3cwWXB1VXdYS3NFWkx6UkQwYVEwSmEySVVzTFNQM3A1?=
 =?utf-8?B?SGVwaXZ3c3JwRlRCZm5BbEZtQmx5VThGK3VSVG9QUC9hWFFZNlBiaWFSRnYv?=
 =?utf-8?B?M29ZeXFvZXQzUWQ0Z1hJMmRpc0lrL1N4eXNTSlJpNEZBYTlrQjlYYTVuMnBD?=
 =?utf-8?B?MmFxK0ZGQkgvVURicUVnSkJ2YTdzcW1oYXExZTdUMVZPcm02QmtEY1VEbzRz?=
 =?utf-8?B?RjBwdUwzWEZVdmFjOTMzVHBndlZ3dlJrSUlJeldGWW5nc0dDbmN1d3BJbXBJ?=
 =?utf-8?B?V1BiWDlOUmxYTzh1RDkwckR2V2tLcWdXd2ZJajBQWmw5QTNHSCttTEx6czhy?=
 =?utf-8?B?eXBtMFdKK01YTnpRR2Zqd1FuUFlNVFlsOFZEMzJUN3lPY1diSXdWYTBWZklT?=
 =?utf-8?B?SDlod0FaWi9zRUptTHZ0MjIxbk5aNVNjTThMQkR3VkpwTWQrTzNVYXZTY2w2?=
 =?utf-8?B?QmVHSm9DVUl2VWFVanBRbEhpRUxGa0VRT3h3U1R2YVYydzZSQmlBT01sUnNi?=
 =?utf-8?B?M1QrWUhiWXRsQkp6OFFqNWpYUS9ucVI0WU5oTmRrUWZqbUoveTFERWk1Rmtp?=
 =?utf-8?B?SzJITWNFazJNZGp5UjlkaFJCVSthbUtTRGh3ZytQbE1jdEVaK1llZWdLZDZi?=
 =?utf-8?B?MklUNzhsL29EZ2hicXYvNzZXSm5wK2NvanMya29abVF2UjE0WmVia3hWTlNK?=
 =?utf-8?B?SUhnVzRUVlVlTTdhNS96bDJyY0c1V0JKaVBTMWhobDFOMlk2eDZ6Q2hKem13?=
 =?utf-8?B?aFRoK2FLV0ZqVVVKaWFjTE50NGt1UkIxT3hQYTF2Z3JkWHVxOHJyMnFnaTYr?=
 =?utf-8?B?alRYR3BQbDVFMkkyamdDL2ZJRnhQQU1qZFVibElBekoyK0cyL3owSkxVdFhq?=
 =?utf-8?B?Z1E2bWJzbHVUN0Q5VGVkWnd6WWZZTVJYb29jYW5wTFB0YWZpcVlWbWZaQjlk?=
 =?utf-8?B?VWtSYVhvQkp1UjNWdVVGMjVReWRDWkUwNkZSaVZjdFlsZkhlNXJDNkRtNjhO?=
 =?utf-8?B?LzJwOGxMNW0xWFpvYnNaTU5mN1lvbUh1UlpUK2ZpK0l4SnQyUnFIYm9YYTZE?=
 =?utf-8?B?T2ZJTEEvcW9INjV6U2wwZUVIbXBPelpadHpwT3FvWEplcGdzcndrSW9VVlFN?=
 =?utf-8?B?ODFyTnpVc0x0Yk4zUTZhQjhMdU9jTlBaUlBZaUxQYndiTXNSNU9ueXhOS2lY?=
 =?utf-8?B?UVhTbFBBR3oyVDdjaGVVUkx1L0ZyeFlpU0R5RVJuQmpMS3lWOWsxSFJxNzJW?=
 =?utf-8?B?MmNJbS82cVVGZFJWM0FMdXlBNlQvQ0laeGEzZkRKR0pxKzk5VVRTQ0h4ZW1p?=
 =?utf-8?B?bUFqQkY5QlhnNXR1Q203UXRYMVpSamxXNEM2aGgrZnF0N0w4bWhLeVBWUFRl?=
 =?utf-8?B?enhlY2N1b1pzeTRzRllqaW44SjZFOEp0eUlGOUdIc09TNDI0M0syc3k5QjJE?=
 =?utf-8?B?STc1b2wxWXRKRmNNYm1tUFNlVFg4QXU1UjdLRldIR0piK2w0dFZRV2poRWVD?=
 =?utf-8?B?ekc0TjkrUU81R1FsQ0dScVArWlZKaG1MemhuU2N6N3JOWitTK1VkZlFPbnhs?=
 =?utf-8?B?bWhPSmVXQTUwMkxIU0tHL3o0Q29xd3NRaGRmc2hlNnJmc2hVaG5lZlhwQVdJ?=
 =?utf-8?B?cEtwOWg4RlAwMk43ZldOb0NIV0NlZGZuUWM4c0RuK3FwL3lqTG1hOWY2M0lU?=
 =?utf-8?B?UDZrQTdBN2pkT0lpMkpKbVNRUzJUV2tlU00zc3BXTjN4K01KN2tFSXFFY2wv?=
 =?utf-8?B?eWZZOFllaE5rWkcxT1hEUEN1NDlFMGpKQWVLWlNSMDBxOE5EN3RETS85cTdy?=
 =?utf-8?B?QUJMSlMzTXdsbjhsZysrL1pqR0wzNmdPcjNpZjdTNnBFdXFDVWlBSllPazIr?=
 =?utf-8?B?ZXNTZ0dYQjR0bTgvcWJpb1VzYWdJc0RjYXVEZU5yWG9rODZOQXVISytQbDR5?=
 =?utf-8?B?Z3RQL083NDZycnAvYStxdVhLSDR4VDZSU09qVkVRa0t6alRaTXc3bXdFQ0d0?=
 =?utf-8?B?YWc9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fafbe3c1-dae1-4949-bd97-08dcff4780fc
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 16:16:15.3308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXingbxldKS1ghNUCBtmqT5mUNGeSkGXrYXaLItka8xZJOpmBXStB7T5rg78dvzYjrVzl2XbP99biUeWs6T82g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8615
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
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2024-11-07 11:00, Dirk Eibach via lttng-dev wrote:
> Hi,
> 
> I guess I found it! The kernel module files have to be present under
> /lib/modules inside the container, even when they are already loaded
> on the host side.
> After putting them there, everything works fine and I finally can
> record kernel events.
> 
> Thank you so much for your support.

I just looked at the code that loads the modules and we do fail early
if libkmod fails to initialize. I think we could just print a warning
there instead and still try to open '/proc/lttng' and then fail if it's
not present.

