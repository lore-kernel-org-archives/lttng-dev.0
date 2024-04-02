Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFFACD1284
	for <lttng-dev@archiver.kernel.org>; Tue,  2 Apr 2024 13:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1712063831;
	bh=UsBbuSIFH4/aDFOVyvvZ/L9KIR3phgbQi9ZPJOm4mZ4=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=fkzEII7qo905Hjni/J0AU7vZUhzOw/b8YJqIdhXy06GXrsbd+81YE6tRJlvFRwT9T
	 rtY0InlqOk2E5Ab8DYGHLfJIQDLt167kk1Mnztk9Bi8Bw7ELr1Jcw0Ymgk3xEUmhp2
	 gqrEXXT5qfYsWzdL2Ffr0d1RZhV6dVeDMtgAhKTkfokq4RWLkeck6TyfoAFvQglKrK
	 13CDQexf9F5emuv/t2fyab5onVjsroPQmvfZBfNbdoo+5cYxhJFZ7722obNHLdZD9H
	 QWw2A1nz26ZKDvZNfuHfl58p7X9ziDM1Hrq327g8z+9liKtRYxeCx2EDxT47ShXh6N
	 0EeGx17k8jc5w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4V87hQ4731z2ZHx;
	Tue,  2 Apr 2024 09:17:10 -0400 (EDT)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:241c::700])
 by lists.lttng.org (Postfix) with ESMTPS id 4V87hL1FWpz2Z8y
 for <lttng-dev@lists.lttng.org>; Tue,  2 Apr 2024 09:17:05 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3LfbKQpQVkykH18COXx6bDVO7bSp/TVGvy+cf/wryw0dJQZG1oZGPzJgdgtovxjyJ1fkrsbFrU0pWRyJ6FboesYXFRBtj0hwtGK4JHLPTZLrg00Save0ayMKKA/S8oVXJbN/S/fouefEgxTQFZSejNGlMGPkIoMKUYi/u0APxaTcDHJPg34DCpv6qZDgxnkyaaZ6x9DvCvZQObKpn81vf98ExqkqdGTdXIscyJhOVSzZPuCJJbUM+F7oZk5SGNnmg1R/Iu0U7r4i3wgCRaouqq4ytN0EndgywnIUYZZBXEE5QcB1EBs+/MQVLamDMPnAHl+VissUF1gNusHN55vFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VczEvO4pzKbfy5Mhixf3JSrJPF6bizweSX3Bak8Yk3Y=;
 b=KfVB5Q7SlKQi3QhHTU4GNpOj9A77Dj6tTIsM7RDYOVK+0tLUaAF+W2m2sJG/eJbzrmk0kOGQMhYneldskOE2zEppOq8cm0zq7RHlcwKgLQforMZtN/MWdM+pjjMwSNI6FvB8U9H/yR5mr2YICtl9hvPtXVhRrNZ+xpyv4W4+/JM7JcolLOPjDAgXlGb+us26c0Yf5oYyDrXJQdvVKu8IO539SOLF6PKYn8FCBXnGb6OZ9Z1xoF4Pl72hFMy1hZCFPdjVduZWbKInoUrqxLfQs/rGCFuEIe1tsVTNUy0sYUr10RRjRWkvmoJNamZiDSZMMIU4CKePsHfP691eziRdig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YQXPR01MB5440.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 2 Apr
 2024 13:17:03 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::17ea:ed8e:e437:46ed]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::17ea:ed8e:e437:46ed%5]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 13:17:03 +0000
Message-ID: <7cc79ada-f8cb-49fc-aec8-4d0b5c9ba2bd@efficios.com>
Date: Tue, 2 Apr 2024 09:17:01 -0400
User-Agent: Mozilla Thunderbird
To: Zvi Vered <veredz72@gmail.com>, lttng-dev <lttng-dev@lists.lttng.org>
References: <CABRndgyb_=9VrrgV-Z21YDe1w879kTuE9t6m8Hoa3h-4MpfcEQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABRndgyb_=9VrrgV-Z21YDe1w879kTuE9t6m8Hoa3h-4MpfcEQ@mail.gmail.com>
X-ClientProxiedBy: YQZPR01CA0089.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::9) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YQXPR01MB5440:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gHqfDLoBQVFFZoRRy7yKz81Tz3n/MSrP+szf5yUnD6SOdrIakaCMcqu93fc42nxOWusEStez6B/w9xgog7wuBn+53lntiG81KYg1VamBWa2Z+dciaueuczlwjWMXZKi4uwpfvIGtSjiDdPGCNqUqr7WhhrEXfwpYwCDX3TtdwMqguFRBMJqQ2VxwzcVvOve47VsjG/g0xuBLDm5StpU90I6zZwvRYxkpEF8sb1zeHQgrEOqW/islL6xZhG1qyDDovyZVZQUTEoGTizhcgjDRIMABxKk041zoDfFWPa3/IvUCzvyub9mZ+i+586hCEqUTTkSuQe21vtV0HvfJdr2Wn6AXrtwN0sUKbiYXxCTDNbC9kCUR+GcgGByE02WCM1UiDf/fFKQH4ZL4jYFgfzGp8XXUZJ8PAslj5LpGL02sbVsbLWCylQEE81d3OD7AtA9Rlk0OTDTzDPUigjSZdOI/JLAgFVwdRnO7m3w8YVK+57xmVopS5b+KtzPWsqK5Q6PBgNbEvaDjkQajWW4MDzCX9byXLgmtj+Cz4x9DUnoD5vCV/yReAvYdagxMZELhIls7hM3m+U36lm6xQt5z5lmZG7JoftTfyY4RvzeQ7AX/2fY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTB1bUFzMTdNSldiWEIwUkhYRnRDZ3N3QVUrVDhHL210UVg2WnNDQUlxSW5r?=
 =?utf-8?B?UEZhYUdsWm5TZEN1RjlEQVk3a3dyYTZkZDE0NXhNZUN4bXhDU3lsUTQzbmdm?=
 =?utf-8?B?NGxTaDlUNE8wUGo4QVprU2dTU3Z5eUtiU3hVdU5EdzI1Z1FGYTdqYUlNWnNj?=
 =?utf-8?B?Ti9RUGViWWlGWU9TQVIzRTdRd0dlSkIrK3RjcnFRbXVLWUdHKzlRNHU4eUpS?=
 =?utf-8?B?dnl1dEcvc3NQK0RUc2JjOFVaTjZHNjZBMmN5V1UzeTU1WkJVSlhTSVFpa3VN?=
 =?utf-8?B?RERpbjcxVWUrN1dRenZkdS8yQjJPbHU0ZEVTQWthUnhXVlRGTVVWNHlFbGpX?=
 =?utf-8?B?UnZVaUxVMGVGQjJGdnpybXY3d3UrVG9RWCtlSDBEMS9mNWwrNVVIaGVzRHhE?=
 =?utf-8?B?MjVmb2xoN0ZMa3RSREdOZDdUcGZtVUQ3KzBGVXJwVVMxVnNRRjFCdE9pRlE2?=
 =?utf-8?B?ZnM1SkVuMStJRnlHM0tTMS80MnhhaTRiMmlqcGUyY05mSldVTFprRURuQmgv?=
 =?utf-8?B?bkd3bmpNMnlEaWJlcU5OVU1iTDY2WWZzYWM5cUZEbXFyNDh3SnZNVUczVFA4?=
 =?utf-8?B?cGRUNktkYUQ1MnVON1dWNUlIWnd6SEN0QkxIV3BDL25ZY0podUFxWEhlb1Bx?=
 =?utf-8?B?djg4Y0l2UE9oaDVaNjhiUXNoMWxCM29ZaWF5WDAvTU1ZYzA1eUxxZjl2ZFRv?=
 =?utf-8?B?SnYzamd5WERWTndBSEhVMW5sd0lMeTFIRERtV1RWcGUzaHYxOUtvcEwvaW56?=
 =?utf-8?B?WXJOZ3loMGlMRTZiM0hmbFprSlIwNUpIcnpWVHgxWkFlTG84NDRSemg0NENw?=
 =?utf-8?B?U1BhV1BTK2JFcG05dGpwWWwyR0RCajEzbm1FRTVFUld0cGt6TWwrdjVhSVEr?=
 =?utf-8?B?RVlZT0pMQlhlcXZJT2JzZndxcTg4ZENZYVVkWk5vZDNVakJuM2RFRk1FZlZY?=
 =?utf-8?B?b3RtdUhSSEwxVFhpZ241NnA3dERrb0FhQnFmUUNSUG9QR0M0TjNCY0hSSEdH?=
 =?utf-8?B?akFDUm1wSHhHcU9hcGk0emtDYjhqUUJIcEpmYmxuSCtnQk9VMGhEbmNMY2Jl?=
 =?utf-8?B?WndHbStVaVFjZkQ2UEh0QkNkOVB2dVpVbjdnT0dxVjIwSVhIVVJyZnV2T1Jz?=
 =?utf-8?B?TEVrVVRGRkhYNS91M2MvYzBXdk9lSVEwMmJFSDdwdlR2STl5Y1VERCtMRlJ3?=
 =?utf-8?B?b1pqSy9jV2lBVDlMdDVJWHhYWDlGUEhnQVJKL254cGZhSVU4a2xzMGRvdGN5?=
 =?utf-8?B?MEd5VXFGWWlTMkdlL0lmbU4yUWZLTEhoWHpZY29oMWtneWllcUJsQXA1elFW?=
 =?utf-8?B?eFlnL0NFYUV6MjVGWmlqZWpZaEFiNnpBM2RzaUF3OEJOeWU1NExDbDZhSDdX?=
 =?utf-8?B?cE9mNU14bDVyN3RqejZxY2l5dUs4YTVOZm9JU2RwbXQwRjNibXJLelpIaE5C?=
 =?utf-8?B?M29hK3RCWEtEWjJzdmVtcGpXbFdVMlhNTVgraUM1a1A0VVM5ajF2Sk5Ca0pp?=
 =?utf-8?B?b1ZLNzFrZ2t2OXFLY0hZYkRYdzhuUFRQYVBMNHd3S0JwZFVBdGFCMVNtV1Zi?=
 =?utf-8?B?SGZMa3lPTFZ3RVJDY0QxcXdxdTlvSEd5dHAyVTBwcTJGeXl3R1JDTlZUb3Ew?=
 =?utf-8?B?WGhZRUNlMHpZaVEwaGJPU3FZWUtvS1FqVW16d1EzYTlVTWlST29GOXJkRnBm?=
 =?utf-8?B?RUZZQlZrTEhaRGp3L2dzbyt1QkltSkdtblFoTHRHYlAzMG5oenhoQ2VpRkZy?=
 =?utf-8?B?dlN3T0Fza2h0dlhpN0R5bTNkVWRkRmJOS1FkY2k5Ymt6RUxwN043emNhR0Ri?=
 =?utf-8?B?OU1Xb01KVm94K2hZeWRyWDNKZ2R4NEczTFZIMnBEVWRiRjk5d09hNmhneVdk?=
 =?utf-8?B?UlcxZEFhV2dCZnBwZFE2b08vQlFDRDB4Tm5sK25jWFFVVGxNd2dRbGNadU1z?=
 =?utf-8?B?d2pNMGczOWtDaklxUmdXS3B3Z1F1dXFIMXVsb3FDWUNEb3UyV09uN2ZHWTcv?=
 =?utf-8?B?TmxpUG14UjQvNEl6SWVKTCtBUTNZNk5KQTlWWWgwZHRNYUh5ZEptbE5lT0dI?=
 =?utf-8?B?YlMwUWxHUHdaMkhndUM5MmFqdExSNDhrUFZzOTJXN0QxcWZoeGNMSXgvaE9k?=
 =?utf-8?B?bjIzMnorM21LZEN2d0V0SHhsOC9FT3RvNFVpd3JPWngyK0pGQnNncjVvNHhr?=
 =?utf-8?B?aEE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e68c2506-1216-4568-0d0d-08dc53172fd7
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:17:03.2786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpBPvXv3EnsYvChXFtvCX9he24JH1BIysElaf4fBNrnOXCLbISSkbBF63HSwKCbs6aV3P40CPPuuu9uYkVlMbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5440
Subject: Re: [lttng-dev] lttng-modules(13.9) : insmod order
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

Hi Zvika,

a sessiond launched as root will automatically try to load the 
appropriate kernel modules as mentioned here[1], using either modprobe 
or libkmod depending on how the build was configured.

thanks,
kienan

[1]: https://lttng.org/docs/v2.13/#doc-lttng-modules


On 3/30/24 10:52 PM, Zvi Vered via lttng-dev wrote:
> Hello,
> 
> For some reason, I failed to integrate v13.9 into buildroot 2023.02.2
> But I compiled all modules with the my kernel source: 5.4.249
> 
> Can you please tell what is the right order of *insmod *for the kernel 
> modules ?
> 
> All I need is to record IRQ events and user space events.
> 
> Thank you,
> Zvika
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
