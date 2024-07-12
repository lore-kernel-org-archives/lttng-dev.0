Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E785C3DA45
	for <lttng-dev@archiver.kernel.org>; Fri, 12 Jul 2024 19:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1720812274;
	bh=PCDQxwkAusOVAEwTH9AR/mpGZvgIo16nMqdvRDO/KFo=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=mww2lsqc094bTRWBgz7H3NCJY1wjGHO+3dcgLJVC8J9wqTvUcd4e6poIM09Rwaw+r
	 cRbheSe5lmAHXJApEralpmAAhN+heOUINRs/HpY1+27ozajwSyujHP24rSsQ5uxS3x
	 YRdhpDp1+BDAzPjpFMfMyyWSNNp/P5OSZAEX/v99DYCtEy0j+y/aitksXPY7fLZoHH
	 RkRuPkV5FLdNxNW+ce16je7A/PQhr1QJ0MG8Q+sEPSqxxf54f4t6g/xS1+JQqPXA0a
	 48fyhuwD0KPfBBzAh37dpRAs2E0GLdbrTsjBPXPCWRgaOcEG6mONDtEk3bRlvgPA1I
	 KGx0R3cqFhkTA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4WLM3k0Pb9zBdd;
	Fri, 12 Jul 2024 15:24:34 -0400 (EDT)
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazon11020110.outbound.protection.outlook.com
 [52.101.191.110])
 by lists.lttng.org (Postfix) with ESMTPS id 4WLM3h5Gy4z11L2
 for <lttng-dev@lists.lttng.org>; Fri, 12 Jul 2024 15:24:32 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XwzipYjH/CwRN5F8yufhHg95BcOGeT7RoQcSeTzXNblTzjd9qAyZl3F/v6zsdc/LQ0neSItG3upJgzsixYCwAwOpkDmkPabSAuoVgnMKoYrxEFzLp+i5N8NVeL7Sl5cqYogwQ/lMzDqp/IAt6ZsqwL320Ujt0QuaUyzxFEfjFeW91YORoD+ddvkSM1sRphHpMq/hrLxj0sr8hOjm/ZTchNZL7sj2UchQP+Ao9QGJEC8iHxNeTtTPqhxlud+MD9Bz6gvoRxDL0UywtthlVoPh5Yni+59mLXvH1CcB/CSY0/5UAhG0LLy0eoJd/XqsuR577Ix/+DVQaWIeULrxe+tlSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4634ijNUyyVkuH+eVny0AdVX7F3/snZ53nIHopeYKg=;
 b=yrLfer6o15cFx9VYwfDJKVMBMK3SNkMI3NjJQcRVfuVkSwmNVY4bD9TbswQhf9zaYcHPGf2zJ8FHvPr47MHXf3JbFyhQLrbMZsqwb/Ido1qBKpmiOIBsPL0QYEtEs3/p71X/XfTTZCZxMhrlggViN0WwFPDd46wFKG2qqwGcNFs7gou3heBzbWs00c4RF9tKzqC73D/mGxSBRTD/gC5r63LCOUeDYm6bMM6VIZMIJiyShyR3bQJP4q9w1sEpBhKi/W7eqka6FlAxNhGrhNYm/46IBkzTFBQYRYgtSLlqt9rKEO8P/DRGq2jpWA374oUS6SXzLGuhQrdNAwNN78e8nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT1PR01MB9052.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 19:24:30 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 19:24:30 +0000
Message-ID: <626d718e-84b4-4561-9016-467db3594c3f@efficios.com>
Date: Fri, 12 Jul 2024 15:24:28 -0400
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Fran=C3=A7ois_Belias?= <beliasossim@gmail.com>,
 lttng-dev@lists.lttng.org
References: <CAHD10Uhn1kCe7TE7taFQ8ACFJ2CLAKRXp2damYN8xi1SUFdmPA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHD10Uhn1kCe7TE7taFQ8ACFJ2CLAKRXp2damYN8xi1SUFdmPA@mail.gmail.com>
X-ClientProxiedBy: YQZPR01CA0145.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::11) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT1PR01MB9052:EE_
X-MS-Office365-Filtering-Correlation-Id: c384f884-27e2-4053-70b2-08dca2a8408f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWJNcVdyTkVnNTNJSERXajBkdmZqeU9kekFlMkVXQlg3VFRGNkNmM3h0ZVBw?=
 =?utf-8?B?YzNLYWxma1IxMGVCM2V1RzROSkliU0IwTk1rU094dU0xTzQ0VWhCRnhNdTZz?=
 =?utf-8?B?N1VWbU1EdzdQNnVQSHMxVjRlcG92K2p4c01kRXRvanhHK3RXL1YxWU5vOHpj?=
 =?utf-8?B?SGF3eHZud2lYZmlnYUxOQXdnNmgzbmdRd004MG1QcjB0ejVLUHJDN3UycmVN?=
 =?utf-8?B?YlNXb1BmZHowODRCN0hBeFhmejdkMTZOSUE2YlcvODRZQU8yLzBoYzlJdWM0?=
 =?utf-8?B?T0xDaEhFYURsMktjR1hqQzlqOXlnNjVNaVZTTU8zTHdXdVE0ampwQzZWRkxk?=
 =?utf-8?B?dXNhZkdrbWRtSFphVlNPL0l6VEhnOFR0Y2hyWGhnNFZBVkpPWVB5SWZuc3Bp?=
 =?utf-8?B?a2RMRFBHK1Y0SGJqRG9iZURKQmNNMUNMcmhlY0IrbG5xdWc3eU9FZk1WSkZq?=
 =?utf-8?B?Ykozd2hSeWxMb1dlT1d1Nlh1dStFUkN1eENHZ1VyYldyMHY2MTFVeHQ3VzNo?=
 =?utf-8?B?Sjlhb0Zhb0E2N0o1UTNmOGxkczRJUFVwS2x4QzNialI1TGh4T3lZU3crZW1p?=
 =?utf-8?B?Z1U3b1cwVC9KdlZOMzV5b0VxNXhveTBvY3FMODc3MFVQdFJzdVFMQTlkNHFS?=
 =?utf-8?B?ZnZqakJnQlh3VkhGcnRlWHhQQndxTk8zaTlSTTJ2RXNFb1dXRVkyanZMNmdo?=
 =?utf-8?B?RDZHWXpQek5zSkJYUDZ1SFdDNno1RjB0Y2J4K2xRdzIrdWU3QVBLMmRvWDAx?=
 =?utf-8?B?TDlOdjhITlFQTHZiL3dqVUJXQ1prOEdBWFRRRzVYWW92VnlBOHdyZTdzRGRm?=
 =?utf-8?B?VmZEZlBKYk5MM2hWUnc2U284YUhmb1pSQ3FsSlA5Q2VycTlBbnZjUnR5RllW?=
 =?utf-8?B?aUNhNStXZENPS1UwaUc4NWdJaUdlTytadWhkYTZySms3RHUzaGdXbWJCaVc4?=
 =?utf-8?B?aU1pTE9nQ1RGc2JaUkpHd1pYWjEzN2NXblpFWDdJSlhUWXQ1UkRPaXgvRjl3?=
 =?utf-8?B?RDFhdDlGN1g4dWk2QTlXb3VtSlJCZGIrSlZ1QXBXb2pwTHlXa1h0TjF4QzBh?=
 =?utf-8?B?N0N0U1JTVFNrVktNbFVueEpIT29JMXEvcFMxc3J6TWlKUEgyMVRDc1ViTlcr?=
 =?utf-8?B?ckV4Q1V4RVc0MXNoN250UXVpL0x1VG11MkdIcFZRS0lQZGpEQU1za2NLZkR4?=
 =?utf-8?B?S3p6N3dneTFmaWlRQmh2MXZMMlE4SDU4U0kxTDVrbHQ1UmZDWU1idGpvSkxF?=
 =?utf-8?B?djJJaE9Edy81a0FQUlRZN0hEd2w3ZjdVcndIWWErYkFxdnRpTkhkTUQ1WWN2?=
 =?utf-8?B?NFVUU1F3dDJHUEFaTEE2VGlyOWp4R2NOM2VpaTFsTXBianFlc2IyMEZJT2d5?=
 =?utf-8?B?a3VWMnlnbkR2UXltb2lCcS9ldnVIL0VSUkhQbDUzMTU1ays3S1pZdUFSZlZ2?=
 =?utf-8?B?NDhqMHI5MEdFNlpqUzFLRGE1ZUZ3aUh0Q25hVmhrbGlqWkFTVmhxTFRMUHU1?=
 =?utf-8?B?WUpJNk5Hd2hUTG1WTFYrRW9ZdURzQTdKQjZubHNuVU5EM2RpVmhkYTUwbFAv?=
 =?utf-8?B?MVdwUmEyd3pDa1VsQTh0dmpEVHVZZUtBK0F2N2tMdG5MUVhyaW9JOUUrZkJo?=
 =?utf-8?B?T3RXMzdGaFBnNGJqalNSV0VNSEwvZzQ1UWJydGxWblpxVGxiOG95UWc5SDZm?=
 =?utf-8?B?MEFUaUdzWnlxTTIwVVpTYXh5cTc0SFJaMmJKTDJUSWM0WDVtaWhWanZFclJq?=
 =?utf-8?Q?pqprDfbZ6QPb0SUjoQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1ErQ2VUQ1JyTVoyWmp6TVhrOEs5TG1CUmZtN2Y1QkFwS3kwRHlhajkwWTBT?=
 =?utf-8?B?bEFJMTU2RmkvZ29SaGttTjNPOU83bzNaT2s0c3U1RzZVM2xzd2w2TklyS2J0?=
 =?utf-8?B?bkYzL08rZGNQWmpkRTBGamROeGlhWlppTTRNVE5LbUd0Z0RFVUJaVzBGS3gr?=
 =?utf-8?B?UFFPaGpqRDV3VGpaUHFNdzB2bVN0bTVTeHpRUFFScHpsdG9YWGN2aTVZeTVT?=
 =?utf-8?B?VGFzdHFGeXlsZHR6d0VVcms2WXZTQWNTV3FydDJtTGFjeXc1RlRxSmY3OTBC?=
 =?utf-8?B?MGltVFFyOEdiNGRCZFlpZFMzMTlQMnZ4VnpvelhsdjJ1UDhvS0c3R1hZYi8w?=
 =?utf-8?B?KzI1eTFTL3hhQWVFamZpejZITUMrckFDdTQ4elUzODhsUWJiSitsMGk3czBK?=
 =?utf-8?B?WHkvbytzT0ZVeDFSWStQYm5NQ1BNM29mNWoyL1R1N3dVc1E0UnpBdjZCWjll?=
 =?utf-8?B?eVZMRVZudEF1ZEF5RzQxdVM4eDNJMDZKc0JxZUlJU1krb0pqQU5VSzVpNVFQ?=
 =?utf-8?B?UVBQdlFtSDlVZ0JYaHlxWGxsYk1pUnY2eDJqN0ZUdDlubmE0clRoL1IrRDhh?=
 =?utf-8?B?OG1pcm5RNzlLWDhadzVrUEtNM3FVRHJ3cnNQYVhuYjlrOXc4dWtNK0dlYVpW?=
 =?utf-8?B?RnlRQkNSNFpJVjVYbFB6ajcwQW1IRjFmeHBWKy9Fa1h0YzE5VE9xczJzb3NW?=
 =?utf-8?B?aDA2Vkw1bnhhN3VBV3BJWDlYZURydSt4QTlKWE1GdytWN3pKVWJneXpaeFlF?=
 =?utf-8?B?VkhwZTVKREhvZFBjcTArNFlHRnk2dHljSmhKVUN6YW1kN0ZlbHI2b2R4VmpQ?=
 =?utf-8?B?ek84SGdVNUJkY2JFUmx3NVAxMERnbGNlNU1lVDF5T21PMHNEaVF2WkZCMGJM?=
 =?utf-8?B?d2QyRjFHVGhFKzFKTXZJNyszLzdkcmN3bHkrTmhBUjczWVBzZEhhM0Evei9B?=
 =?utf-8?B?MElhUjA4c0pGek9HODFkZjJHaVBreUI2SXg4TkxpMSt6SmRxL2s2UVZ2bmNT?=
 =?utf-8?B?U090UDkySTMrWStYTWgycXQ2QjFSMU43a2Ivd2RpQnVwc09UdFJ1aXdXc1R4?=
 =?utf-8?B?ZlRkSGdncmU0M3loOHZGaUNBNTdKd0xTMm4vcDkySFh0bkZ6c3kyVEZFK1lC?=
 =?utf-8?B?M1RTWVNLRzRhamdoeWZ1SG1hRDJ5bXN5REg0bjZWclQrMnJuK292aXhYNUpu?=
 =?utf-8?B?aitsQ090SEJrUGoxN0RYM2xaeUU3Y2xoa1JsZW5ISzJzMkloYzdSc3lsZWlj?=
 =?utf-8?B?Tlhta0xEdUxqMThSeHJXUUNyR2NhNmpvS3JVbVphY0o3Vk83TkpRSEZKaUVZ?=
 =?utf-8?B?eGlYK2NobW9QcFZ4QlppK2JsUXNWV2N6UHN1T0VaMCtRL1l0U29uREoxM01s?=
 =?utf-8?B?RmF4V1JZSTFsZ0VsTWE0cTVlYUxLcWlKU2d4ajE5SWtvdm9vcmQ5cHlLVTdn?=
 =?utf-8?B?SlpkejJMTGI0WHE4SDZVcTZhckRYK2hITGhCL29EcHpPY0RiMitML1NXOWVU?=
 =?utf-8?B?ZHRha3RNZW8rT0RyQ0hBU0tKNk00Y285Q0VBVitpTWxwcWJRQzgrMXQvTnpk?=
 =?utf-8?B?RURHY2RIMjVEZm91WGRwZ3lMZEFlTjhZNjRVZVUxVjArbnJRZUNEdm53amdt?=
 =?utf-8?B?Vk5SUEN4a3dtZGp3d0J3SXRrazVqWjNYRWRwN1E1T2FQaEFvWkpZUGNHVjBy?=
 =?utf-8?B?aFVZSFNyMk0vcTRrNitsQ0pMOG1GWUFlZ1hGVldKekpsUEh5a2JjZUloanhE?=
 =?utf-8?B?aHpQdHBXTUJHWnBUcWZPRGVYSnBzT1ZsQndTa2F0eXFPN3NQckFFSWdqNFdm?=
 =?utf-8?B?azl1RHNMWm50ZHpKY2dPMS9tZzVLTU5MamgyL2hXVExydTF5L3A0eUZFcGtn?=
 =?utf-8?B?aDU4N1RvVkJzekcrMGhpTHhrNVdmc0d0MnpKKzRacnEwOFNEZit2cFJ5ZlRJ?=
 =?utf-8?B?elVISXBud05teTloM09BT2laQ09BbDIvc1ZSRkl2OXArY2hHRmR2NExRSE05?=
 =?utf-8?B?Zmg1NEtLTTUwVEZ2c1VJLzhLRWhQYjZ4OTVnM0ZrclhFWmUyOTZtRkltM2ps?=
 =?utf-8?B?c3RXY1VoMDRLVkpENUJ4WjNxaGNZRzltOHpDa2xZQUxyL1JOVXhpcHRSTUxz?=
 =?utf-8?B?RWlSTENHcGtLcE85SUwwSm5SRC9GVUJKSVhzSis1emJQNVRQUnlKdUt5SXpu?=
 =?utf-8?B?Qnc9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c384f884-27e2-4053-70b2-08dca2a8408f
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 19:24:30.5414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EAdlx5WZ7xZysLCbe3SXOb9rVBTSDP/AHgwjayFrjRuE16jH9qMBqhAdsJbxSVIIRfhcbTXTWn9RaXUilg3EuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB9052
Subject: Re: [lttng-dev] Error: Unable to list kernel events: Kernel tracer
 not available
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGkgRnJhbsOnb2lzLAoKT24gNy8xMi8yNCAyOjUzIFBNLCBGcmFuw6dvaXMgQmVsaWFzIHZpYSBs
dHRuZy1kZXYgd3JvdGU6Cj4gSGVsbG8sCj4gCj4gV2hlbiBJIHJ1biB0aGUgY29tbWFuZCBgc3Vk
byBsdHRuZyBsaXN0IC1rYCwgSSBnZXQgdGhlIGZvbGxvd2luZyBlcnJvcjoKClRvIGNoZWNrIGEg
ZmV3IHRoaW5nczoKCiAgICogSXMgbHR0bmctc2Vzc2lvbmQgYmVpbmcgcnVuIGJ5IHRoZSByb290
IHVzZXI/CiAgICogSWYgeW91IHJ1biBsdHRuZy1zZXNzaW9uIHdpdGggdGhlICItdnZ2IiBvcHRp
b24sIGFyZSB0aGVyZSBtZXNzYWdlcyAKcmVsYXRlZCB0byBsb2FkaW5nIHRoZSBrZXJuZWwgbW9k
dWxlcz8KICAgKiBPbmNlIHRoZSBsdHRuZy1zZXNzaW9uZCBpcyBzdGFydGVkLCB5b3UgY2FuIGNo
ZWNrIHRvIHNlZSBpZiB0aGUgCmtlcm5lbCBtb2R1bGVzIGhhdmUgYmVlbiBsb2FkZWQgYnkgcnVu
bmluZyB0aGUgZm9sbG93aW5nIGNvbW1hbmQ6CgpgYGAKbHNtb2QgfCBncmVwIGx0dG5nCmBgYAoK
dGhhbmtzLApraWVuYW4KCj4gCj4gYGBgCj4gRXJyb3I6IFVuYWJsZSB0byBsaXN0IGtlcm5lbCBl
dmVudHM6IEtlcm5lbCB0cmFjZXIgbm90IGF2YWlsYWJsZS4KPiBgYGAKPiAKPiBJIGFtIHRyeWlu
ZyB0byBidWlsZCBMVFRuZy1tb2R1bGVzIGZyb20gdGhlIHNvdXJjZS4gSSBmb2xsb3dlZCB0aGUg
c3RlcHMgCj4gZnJvbSB0aGlzIHdlYnNpdGU6IFtMVFRuZyAKPiBEb2N1bWVudGF0aW9uXShodHRw
czovL2x0dG5nLm9yZy9kb2NzL3YyLjEzLyNkb2MtYnVpbGRpbmctZnJvbS1zb3VyY2UgCj4gPGh0
dHBzOi8vbHR0bmcub3JnL2RvY3MvdjIuMTMvI2RvYy1idWlsZGluZy1mcm9tLXNvdXJjZT4pLCBi
dXQgSSBzdGlsbCAKPiBlbmNvdW50ZXIgdGhpcyBlcnJvci4gQ2FuIHNvbWVvbmUgaGVscCBtZSBy
ZXNvbHZlIHRoaXMgaXNzdWU/Cj4gCj4gVGhhbmtzLgo+IAo+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+IGx0
dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmlu
L21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3Rz
Lmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGlu
Zm8vbHR0bmctZGV2Cg==
