Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0552C3DA41
	for <lttng-dev@archiver.kernel.org>; Thu, 11 Jul 2024 12:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1720701509;
	bh=FKKk/LQz4HSuU0/SjGyfh4/1Qz1kaj9N6IihpU65Hro=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=r8yWsixWfdFTeBVVbEQ4RAjbMNfH9ucDm8HwkH9crknfGLrsRPS1i71OYOlIaJVTn
	 kh5efvLz/0lOly60hZErlq5cDAZJZij8hLPRTxqBcp2rrNblprFOesLfpYSudwnnDt
	 nXOQV7iBeaaYm0SPsqLqDahlPzHBEHTIDOhGVMouMSmcHtJ14ffaNzvBp8BesT5PuW
	 6HfFZNT8pvmi3t872EweOayZOGaMZC4VgSsriC/a1Y69QlG9lFz0hiN+SEUEArhpnw
	 /YYNq7LUul9s4gnGpqd4aIQnSgh1XFYUJGt+N69Lm8RvtWvXt/iF3KynWpbrNJ+qRh
	 8Q14izlp+585A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4WKZ5d1DkjzB49;
	Thu, 11 Jul 2024 08:38:29 -0400 (EDT)
Received: from YT6PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazon11022077.outbound.protection.outlook.com
 [40.107.193.77])
 by lists.lttng.org (Postfix) with ESMTPS id 4WKZ5b4q8FzBR1
 for <lttng-dev@lists.lttng.org>; Thu, 11 Jul 2024 08:38:27 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rg4JqFkQK8F6jesW7ffCmBgQkc9UQfcXW6FimWuiKYAssUGL871uywCvPed4Ap1bh2H8d3HpqOINYHVKtLw/8pJKwj5Y5S8Mq5VNBwb72HCaSSAVcV7J5JhM4f8HEJFlbQaLYLG2jZHtJZ6ZnyFp+G1nVJUHA6st2nXdAOoNds0ekSvtGsRO7uCX4ku/L4lRAwaeUioHxhlr+9cVFunnLkk0pVZZBDcdgd+/He8qdUewKWTRn96ap48MsJDmwlL/BtDfZ//1QK8O9DyXup3/4UIcvZy3RYiGPTJhiMIZCwjuCXuhtIku4EiZ/DAMd0k4POO36YdIbGcCY/sptQFhxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRuOCSufZy65sabd4Y3geiGuLC2ZZ4AFkSNObltVJOo=;
 b=jgkjsTnXdICdg1jeTBhVj4wDZ4H+N3o8U4Coy8ALS/bfBufe986ZvH4EVCc3CsjO25CXLI53F/Rz5K0doKsfRi+gSZvESDhAzApjhFA4T0DK9hMWSMin8gMW1ztaWZ9CDMpBROwE8q2Ueyw8D0VZkQIFHylwwpZ9M91Um/gA3GlWR2d7aV5IHBW1mPQla8bZeTLHigip0ZLBNzRFWPUDwNZibYs5vkU7lxTuJpj6zUQGJOszaVjQaggqd82vdp78lH8fTaw0JiVrQROHc8EElmmIqZ+0631PKStW7KrO05cuKhB6mXSEw0/UElRVzOs+5HEeAiSoBI0AEIKaxWswyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YQBPR0101MB9584.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:78::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21; Thu, 11 Jul
 2024 12:38:24 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%4]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 12:38:24 +0000
Message-ID: <d30f1655-0efa-440a-ac17-fe82342f4556@efficios.com>
Date: Thu, 11 Jul 2024 08:38:22 -0400
User-Agent: Mozilla Thunderbird
To: Brian Hutchinson <b.hutchman@gmail.com>, lttng-dev@lists.lttng.org,
 yocto@lists.yoctoproject.org
References: <CAFZh4h_wh01sjAar-QqHsQ=KY4zLjmpmXuJc83OeYue7YyYW3A@mail.gmail.com>
 <CAFZh4h9iaCGdnDhxik9Qtq82f0MGU2eL+8nBa8qoCCJrH-xsGQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAFZh4h9iaCGdnDhxik9Qtq82f0MGU2eL+8nBa8qoCCJrH-xsGQ@mail.gmail.com>
X-ClientProxiedBy: YQXP288CA0020.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::49) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YQBPR0101MB9584:EE_
X-MS-Office365-Filtering-Correlation-Id: 3830cf4e-21be-4b8e-8c67-08dca1a65ad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGQ5MXpHbTVYeUsyaVZSWVZOUWtOOG9mRDBoSVRnWWc5V2tocSs0N1FNbVJJ?=
 =?utf-8?B?Um45YXZRWDlCaDhralI3OVhKR0NaZ2ptcWx1aFp5cGM0WFU1QWtWTXZqSEpV?=
 =?utf-8?B?RXRuM2crRGQ5RE5QVmRHaVFsSC9uYXI5QXB1MU9VS2dJNGlvbDhHdzFoa1Zu?=
 =?utf-8?B?aW5wOWhkNkNrRElOY0crTXpmb0haQnBCU2diS2tFM0Zya0tsaTgwVHM5VmNu?=
 =?utf-8?B?Zlh4MTk3dm1lMmRwQkNVam9md3EwRnFzWEJsNnMrVnE2L2tCeCtxbkZrQkJn?=
 =?utf-8?B?Y1QxNzNtWmdza2x4dzQ1blQxUjh6QkY3WnlHcTJTZnk1ekFqWGloUVkvOVZS?=
 =?utf-8?B?V2hKMUx1UnduVVBac0hhRTZ3L3RKd1BUejJYRjhDMGpHUGFzYkNMRitudXpE?=
 =?utf-8?B?SGdvRnJRS3F4VFdkN2QvQm55WWUrTUZYYmJGcXVSUlFxdkphV1JDaWhheW1o?=
 =?utf-8?B?TlZ3UmE1QkE1bS9lN3czY2NPZ3RsNEY4Vldtc1NqNmxEZithQVNTWEZmcHgv?=
 =?utf-8?B?ZjhwMTFzRmZBL3B6eGNjeDJFRXZxZk83eDd1YTdMbFJoTXpDS3hydHhLRUJM?=
 =?utf-8?B?bUtsZUdIZXkzbEJlbGhBdDJyNW96QjBXK0dqQWdBZGRtaHlJTWI2ZUwvbEFS?=
 =?utf-8?B?dEJSbUJOQWorRk5sTVdxYWpVbTZlOVVOTXFLZ211M0tpVXZZRHJNSGRONy9k?=
 =?utf-8?B?clJMRGxnb2dKeDBNTGVVNmVveUhMY0VyYU0zL0h4R3lNWHpYMEV0SmhUajJG?=
 =?utf-8?B?UDlTT2N0dlpUakJpc2ZEeE9uN0dOeWo1RTNhTnBvdlpDckN0cjNXVCtDVFJI?=
 =?utf-8?B?aXhERmpjS0xaR3cramd1akdjV2RrTzlUYnh3QUtkMGRiaWdFcUxFOVd5bnE5?=
 =?utf-8?B?UVVPN0Q3NXBKeHQ0Z1JPLzErWkRhdGhnYXRyYURQMGUzbG1VVW0wRHBLM3h5?=
 =?utf-8?B?Z1FwcUxCOXBEU0laTEtzMDN0c1M3aHR5UjJ1dDd0YWZ4UmdlSHlJUWJvRys0?=
 =?utf-8?B?blZPOEVnbEtkS0FxanVMeVBDZUV3MytscjBOWjZtbTNCRWZtTGhrSnVxdVJP?=
 =?utf-8?B?Y0ZEMnRrR3ppcks4KzF2WE9EUEJVOTcxdGhTNUhWWVoxQ2ROVC9sYTZVVTEx?=
 =?utf-8?B?NUU5bCtoNkEyaUZMR3ZRbmxoS1ZmZ1F5ei9QNkFSQkhOMENreGNJTXVGV1JD?=
 =?utf-8?B?a1dMNGhEdlFoM2RyOTl0Wkxzaml1UUFoNzNIVjJ2TXBjQVlYTzc3Q1dWOTRD?=
 =?utf-8?B?Q003L2FVd3pXMUVvTmxSZUl3cjN0aFY2MEs1bm5xUWd0YjVNdWlaTjVIVFFB?=
 =?utf-8?B?T1d3RHluekdvZWJ1NHV6Rkl4TGx4UGlKbUYxOHJPWkMvaVhyVmZkeHFkWXF6?=
 =?utf-8?B?TE0xdmFNTlhvM1pWNldFU1lCak9sMytXcC8wK2dlbkI4OHRuc3FOY2ZYYUpl?=
 =?utf-8?B?YnA3Q0d5TjhOSXh1RzllQk80QjBWWG9MZ0xLc3hTM1FoSFhWa2JzT0g4V3FZ?=
 =?utf-8?B?ZDNWeUJhbEVRVUF1SUR5TTRvUlB6cjZqczNteXpUTU1GRnZaSmVXbUQreFdx?=
 =?utf-8?B?TnVFQVFpTXNZYm10WXptMDhBdHJteE1PME5PT0VnY1NBMEV2L1g3SkQ4c05n?=
 =?utf-8?B?am5FcEkvRDl2Z2Z5NEdVbmhQTUdCSGlsRHFoMERZc1VlaThpSFV5K0d2K29E?=
 =?utf-8?B?dFFiMjNUeitCSDlJZnBJNk5OUEZ1VjlUd1d0WW1tVEtpK2Q0Mjd4YTBpTWVj?=
 =?utf-8?Q?RxEXKv2DVrf0sGGc5Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHVwYmxtNkNueE1TYTVVb25jY2EyNzdrSnVQYnFFVE9UTmJMUDhHWVhOUFkr?=
 =?utf-8?B?aDI1TnFOeWhKWExWdEdzUkV4NVI5T0R1ZlU3alR4ZTV4Z2huY0NCalMyd1Ay?=
 =?utf-8?B?emtacnppeE1zUXMxZ1pYMFBEV1h6SGZzR2hGbEEzR3BHWGdWcE5MYmVTTHIv?=
 =?utf-8?B?V0ZBR3UyMkVlTFpXZkpabm1TQXpCellsZTdNR21EQSt5d21EVEV1T3hpR3JU?=
 =?utf-8?B?cTNRZEZoUzQrN2lYY2ovanpWU2d6SG1udjJCcTI5aHJ2WEVNNE50M1BRWkpJ?=
 =?utf-8?B?WE9rd3RWTHBmSG45TFJaQ1VBemlSaE1PVFFYYmlwVXk3ZDN0Y0wxc1dBZ003?=
 =?utf-8?B?a3VXcWdIZ0ZaTXlLaStLVGMyOGpqL083MTFNVGZQUHJMRVptaytka2tGeEN5?=
 =?utf-8?B?dFJHSUFQTUM1Snh1UkprbnpiM1FnQ3JKTGYyZjBCK1pHM1RWcFUva3BlSnNO?=
 =?utf-8?B?UVE2Tk92TVhieHJBc21ObDNRcFJySTdaRjZlOVFUbTNzbW5PM0k5K2dwajJ1?=
 =?utf-8?B?clFaNlFGUk1YdDZKbENJc1FaYlNVZXZhNk9aYjcwdUVpM2gvVWI3MWwwR3B0?=
 =?utf-8?B?ZUt6Y1FoR2Zmb2ZPbUtDb1plOGNJYysyeGtrbG45Z1ZtWHp2ZFVSYXczTHU0?=
 =?utf-8?B?UFJQNFdQRHJ1eE93Z2pjK0hzbmo5TTliZGQzM3FUUlplVk1uYURHQnRIS3pk?=
 =?utf-8?B?cWxvSFpIVEFVOFFoNjI4RVZMdDBkWmdzYnp1R2NITkpWcGI3K2RrOHl3Yktr?=
 =?utf-8?B?dmY2ZE1qWkx1eXZxbDB4M3pwdzVYT3BHZG45U3lEWXhka0F5Vit5TlI4WVcx?=
 =?utf-8?B?Tm5ZcnNNem0wd2tWYWJCS3l1K2ZSejRRMG5kZjdZSFIxV3VvUkpqSEhYa0tO?=
 =?utf-8?B?YUR0OWhsaVpuamhPdHI5bnJ4cjFLSVZBdFNGMy9RNnM0L3NJazlnL3RFcEJU?=
 =?utf-8?B?TERtMThaKy9qcGZ1eVFvVFNwN2wweklRWWJQaTFMNEtvdXIxMy9aY082TStS?=
 =?utf-8?B?aGVqYkNSSnFKTkR6eS9KM29TVW1lMmhmQmVFaHVzZGRSK3hKM044dCtUWk15?=
 =?utf-8?B?NU5WZVpJL2RNMGNrSStaNTVvdk5LcnNhNk5wc1JXRFdkQStuQnZrN1k2OTJY?=
 =?utf-8?B?THhoZStCWE40TTR2bUxPVGNUSkhnWm5FcmFQNHFVRHFZTVRBb004ZmdYeWlC?=
 =?utf-8?B?SmhtdWVhRCttek4wVUtCbUxFYnRUa3ZSWDIxVDA3MHcvTWZxdzZiNUJTbVNH?=
 =?utf-8?B?dTh6YVBrVE1vcjBGZWg5SWlnaHhTR3JUeVdKUmZ2ZEc1Zmp0MFZTVm41YWZR?=
 =?utf-8?B?M1VlMjU0VDVEL09lRFVJVUJObHFTUGplZlpMbWFoc0hrVjlhaVRvNzJLbjVl?=
 =?utf-8?B?K3ovUHZCcXZFdFkvU3hmUTdXSjBiWFNqbDFYSEUwaWZwTWdHbDBpWjhTck1C?=
 =?utf-8?B?QlRHSVhYMTZ5TTE5SXJlc2VVVUo3SE9xMmNsdVdkb2h4Y2hncmdlSHNkajZX?=
 =?utf-8?B?S3BlQkNhMm9WYXhtenhWdGVpM3RKN1dJZlZ2Qjd3dFJSV2pUemtnbVNvQW1n?=
 =?utf-8?B?K2E4NXpwYnV0U2NQNmZjcndlbjRVa1RGS1h0aWhaUGVReW05M1MyS2g1Z0JP?=
 =?utf-8?B?STFzTlJXeGRCRjEzMHVHcStybkhuZll2NWQvRU10R1ZPSFNJcVJudE9iZzZZ?=
 =?utf-8?B?Mitzc2JTamlZYnRzNUVDVk5mLzZROCtvM2FlRHZYRGNKK0RkKy9PM3pGaDJo?=
 =?utf-8?B?ekNoUW9hTys0OFhDTGZYSDhtOG95VUNwSFhCZTVJYUJ0cHltTys0eDlmVmpD?=
 =?utf-8?B?akdkUDcyOTJubFZxYlBRQWhPSnYrL3QxWTU2aDUvVW5Oc253eElOL2hqSDhM?=
 =?utf-8?B?Zm1wYnJ5Zktrb21pTTFhWEpXd3kvSDVkNDdKNEw0dVd6OW1BYUNMcjZzK2lR?=
 =?utf-8?B?UFRaSU5Id3Z0eDByc0pOV1pMU21ndTVxQ3hxcFphVWhhUkIxTkM2bkpKTmZY?=
 =?utf-8?B?c0R4MmwySFVyVjVsWTQrVmNVb1R2Zk1VY1d4bmNwKzF4TEVWbWtTS2lBbi9w?=
 =?utf-8?B?ODRzWm1Rb0FoZVFhb29GcGlwUUd2aGlNOGRmdFpBdFZtMWd0YTA3dFZyMUVU?=
 =?utf-8?B?TEFST0l1RE55YVVLaFJEb3pxaHZXcDhYekJGc2N5czRoMUlxWFU4ajQ5V0Iv?=
 =?utf-8?B?clE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3830cf4e-21be-4b8e-8c67-08dca1a65ad9
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 12:38:24.1536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2AQEZ8AmIqZTRIELGtY3NXNjykZaPkLNyuOwA+TdCsimT3vE2lauKtE2cMP+1II9s8VdW5JO9WluZSVfS4LXvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9584
Subject: Re: [lttng-dev] Using lttng-ust 2.13.6 from Yocto Kirkstone and
 getting weird segfault saying strlen_asimd.S can't be found.
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Brian,

On 7/11/24 8:33 AM, Brian Hutchinson via lttng-dev wrote:
 > ...
 >
 > I'm not sure about this, still trying to comprehend everything, but I
 > think my issue could be related to all this gcc TLS, heap, trampoline
 > talk here:
 >
 > https://www.mail-archive.com/lttng-dev@lists.lttng.org/msg13584.html
 > <https://www.mail-archive.com/lttng-dev@lists.lttng.org/msg13584.html>
 >
 > Regards,
 >
 > Brian
 >

You could try using lttng-ust 2.13.8, which includes a fix for the 
discussion you referenced.

https://github.com/lttng/lttng-ust/commit/5db715e800d9b721f48495a987cd26c25965e836

Please let us know if it doesn't solve it.

thanks,
kienan
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
