Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3A0EB64D9
	for <lttng-dev@archiver.kernel.org>; Tue,  4 Jul 2023 15:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1688484954;
	bh=BzWVki+gFPMAcKx9JkNmdfFpWe//3GfWFP5uKlEgRuw=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=SeB1AFsbsCwJkYNzoadYD0TdYM2hKRMj5v0E0yuwqC19lilOyz8XxnbXPynXyAm3i
	 WPXBMd0tqjLaLy2WsZuxlcAok81qBaQTdyoJkdifb1iGBsuZhP5/Y66HxYR3GIl6in
	 +GBJPgtTwCF4Y2tXGLOFfiazjydRe30jzkXSHDr4jKPqjf9GzSq1robK1rTbrrKaqi
	 W8De6KzPYn/d8SuceyTmsCKT1xxxumoJ7XJTVwd67QHFKGhN8IpxA4L8JlZHnUhjZS
	 PnxXZVoWeMs5zPhFkDzAVIbSXi9T3Buk5DSG9VdhaJABOV7eXMScIKRpCRGPhJWd5w
	 Va5+B/lRau6Fw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QwRhT6Nx3z23Yh;
	Tue,  4 Jul 2023 11:35:53 -0400 (EDT)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2070.outbound.protection.outlook.com [40.107.116.70])
 by lists.lttng.org (Postfix) with ESMTPS id 4QwRhS2vXSz23Yf
 for <lttng-dev@lists.lttng.org>; Tue,  4 Jul 2023 11:35:52 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwWrqCoQHrIpsb4uIKGS09MrBo9Hl8aLjRV//2pVooGEl5XfsQwQHcvvAG6r1QwGUp/wgDSrdoK7xxW32ZHjeorJzTSU+81ozy3+0kBFyzefYduUUl7wjQtjwOpPg0vJLLhIXvYmYEfjPADm5ue1rrO2JSAGVFRw6XrBhlrjO0hlOhNMh6Omhf846NFiw0sq4fzLZH4zQYHD//JOIXrw+Bl37Ba5kj6gGjnLwEtmxErmRUEIt+8HmzAGkfDoGnFWTecSk+noKm0+l/0AxBq8MJrxz0V3hdTVPL6dWlEqhpUoIzSDueGE9WC411VU3BRdftxDhpgTZGbsftbfdq1nQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gs9D3CdTEW9YhvxGUko6g4WguMFgiGqQixZozeJdbew=;
 b=gXV24Lg0LhRYhSwKfpBMCaeUDx4F5+/gOAfMrrir6PoiGQ1cmy68FBxKiK/B5MMmvUmb2uK8ZcVoSHKXO2hpsaaeFpexdSMGOr8lRqSf6rfVaJol1+HwbUSCeTjH3URVjG7ztpGbbfxP2/DVQFG/7cV6KP16nDMV901+h6/5nB+0fEh0AqMCWSNXiDrvIYKAUnTt+v0zQW/pQ/nsLAxjaM9NCG4KuFF8LlcHnqKOexyHEx4lkuSQIXQSxXXe4i9ugMFpOWcr7SkwWJsTI+SFbzq7JYQACuDWk9zHr5H7tFuIQvbp1efId2eSSOLRfruSVxX0goQjS4sDEWAVgixcyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:24::5)
 by YT1PR01MB9020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:cf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Tue, 4 Jul
 2023 15:35:50 +0000
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9da2:5a9:2be6:8616]) by YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9da2:5a9:2be6:8616%7]) with mapi id 15.20.6565.016; Tue, 4 Jul 2023
 15:35:50 +0000
Message-ID: <01b221fc-05f8-ac1f-0c88-9875fd945e9c@efficios.com>
Date: Tue, 4 Jul 2023 11:35:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Roxana Nicolescu <roxana.nicolescu@canonical.com>,
 lttng-dev@lists.lttng.org
References: <20230703182859.49731-1-roxana.nicolescu@canonical.com>
In-Reply-To: <20230703182859.49731-1-roxana.nicolescu@canonical.com>
X-ClientProxiedBy: YQBPR0101CA0317.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::11) To YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:24::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB5080:EE_|YT1PR01MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a26c87a-4c62-4c3d-e751-08db7ca4585c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7nJhYkeSZzDli2348Y2xO+tl1gvMQnMDSPe8CTJXlynX86U8ggvob2ByqU+W1IOnAmDdoBUhR61pUrhBjqb8yvieTZMUTB+MVKcEyXTqH2R80le/n6yeUshg6JwGY8GanJ6SYIpQpw4H1jxUphSeDWWGtFW6EVlEv+e2fIWrTsN6aBqsorzDki4bOYK8FIJ7kdr66YRyVnkVnCEvmVPN+MjObR7gaw7FIwYYCGb2vJzSqkZjBZBDSMCCwMhllCxtgtoCbA/arRaO3hA4f6VqTXKhHFtyyYKdo1IfoEYnlAXyauXo/6r4F5Ns+F5dUSir/qYo5TviabQjPOKd4eiGlB2PcG0O24v5p3bWnYTOii71aqRpidJlA8YU7nSn9qwa2zndfWWX4kQ+cdyuOnrY9EHktsWE5HexwxVcts/+7/xlLAAaKVZVI27kBOh1r8jFCXU2h5j9+fEToRNqTtRhPSp/a9yvS3XvBnbLcMIT5yTiYsgptSJLn0r278XRqdy/PFoqWRAy1keWDlsEBJdEGKJrrGDxyBugy1pv8gEc/RdK+yMR3mxVx9woJmzE5UjhbuJkSVRH3pOK/C7wZa1W0VXWmFwTEUWyUlak/wdBM/7C0H8iRSJqTAZOUT7ESE0J/5kyKsRtW0FcGbsVlDOTaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(366004)(376002)(39830400003)(136003)(396003)(451199021)(66476007)(66556008)(66946007)(2616005)(38100700002)(86362001)(31696002)(186003)(26005)(6506007)(53546011)(83380400001)(478600001)(6512007)(6486002)(36756003)(41300700001)(8936002)(8676002)(31686004)(5660300002)(2906002)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDhSRUNCTzdnQmlzeW5DTStucEpPR2FxMmZTMDdXRVBWK0hEUzcxc05KY1gx?=
 =?utf-8?B?azY0MzFGTG1HWFhQQVJpenJRLzFhbGM2NWFIMnhqNjZSMzhmOEZueGY3bm1I?=
 =?utf-8?B?SWdXUWk1SFg0RTU0ajErVU0xR25qUUxmTE4vR1NNVlJtdnZrT254NjRncHVP?=
 =?utf-8?B?UFZ2aG1Sd2hkcW93dFRaL0ZNS25Za0xiN1pHYi9Dc3N3cmc2ZTJGei9WQ1dT?=
 =?utf-8?B?eENKN2ZrV2dRVEJ1N0RwMWgwRlUwNUR3bVRYd04ySlJUbU5JUWx6c2llK1Z0?=
 =?utf-8?B?aUFvcDVkVnMyejlxTStnK0JBbXFONnlERFFHVWFRRCtqc1lJVGthTHJqTk50?=
 =?utf-8?B?cXVNYkhZY3ZHWTF0MTZ1UGhUdkZ0TlR6K21YOVZHSDFWMFRBZk10MVlkSGpB?=
 =?utf-8?B?UXpyNEUrQjJRQ3RpRVlKak9aTHV5bStJK2tnNnlaWXdxMTNFeWo4ZzJuNHZQ?=
 =?utf-8?B?bXIvQ3I2dWVWVjI1Y3VwTGtVV2FPUVo3L3Fjb21iaDlyUUxhWDk3bm1OSzAv?=
 =?utf-8?B?TkI1Uk5TTE1hcDN1NGFUMDRUN1FVUkFjb2FqSnNKQjg5ZVBUNHgxVHpwNlJX?=
 =?utf-8?B?UVQwSEJEZzNpOEVSOVluZE9UUTlkV1RNaUJFWURtcE11RjgwaWxscjkxbGth?=
 =?utf-8?B?NkxpY2FCV2MrVU8rU2JCZ3h3enIvalQ4SnRVZFl4NE90VS9NQnJweHpzZFhk?=
 =?utf-8?B?QVdFZFM1b0FUQXp2SWRiTGM5NCtqaWFTTEtSZjI5ZmorYXA5bEt2L1ArVHJp?=
 =?utf-8?B?K2NwWXNLSHc4d0hNWWFpUzZ6MUdoU2ZRSzlxVHVuUHl3TDV6V29EYXl0VmlP?=
 =?utf-8?B?dUhES2VWQVpWWVZ5OWdyMWZkMjBuZ3NrS2pmcUh3M1I3RTdTQ28wM2xOMzZV?=
 =?utf-8?B?cWNBTE9INmVPSUVLZGRiM0R4N2M4eDZWUUhPMXdGbWZ4MUNNendvUDdoVEVw?=
 =?utf-8?B?M1Y3cDFYV2tQcUhET2l2WUgyTERWazh4TTNlbVYvYWZoc2xqSFpDeUlYZFFR?=
 =?utf-8?B?TEFzcVl3b1oybjZNQUlFQnZuV3Blb0xQUnRZdFRuMU1TcEwwSmlOby9XNFpz?=
 =?utf-8?B?UFh4a1BmMkgydk16Vk1HYnRFeW51WVp0NlBjRDBTS3RVRVE0d0I5SnlDT1kw?=
 =?utf-8?B?Wlk0S1F3VGk5elY2Y05VU2tIWDVmaTBNdkhwUVFxRlFxTXNDL2JUdG9YOHNX?=
 =?utf-8?B?bHhTYjhTMUN2SFluZStiNURMdHdpUDRicDg1SmJJWW1QdUdhVUo2alZHMnEv?=
 =?utf-8?B?R01xVVcvQnliY2NzV20zcC9BTi92NW94ZWVSZ0dlbXg5SjJENENxbWxCcVoy?=
 =?utf-8?B?VnJEMldEU1d2S2FaZkZOYUZ5MmZDNGo3SndJb1YzVFVabFk2UXpxVVdlS1Bx?=
 =?utf-8?B?b1RLUHVLQ1h1OGhkeDVpdlpHWSt0dkxLUFNQdWc2eWhSL1IrZFVxdWtNT2Q1?=
 =?utf-8?B?T0VCdFNCL3Q1WDVmQ1I1UHFVVVNLQ0Irdmd5L2FUVUUrZW9uZHE4UWVDM2lR?=
 =?utf-8?B?NjB0Q1N4aVVsQXhDaVJGNEQwK3BnVHN6bklnZzFTMDhsZzd1TzBkVkRmMDV4?=
 =?utf-8?B?Q3hGZmc1SVd2bG1PKzNBdXl3Q2FDTEhTQVNpM3dETmh1cmc0UjFoZXBEY0pu?=
 =?utf-8?B?enRDdXJrbXNrN3pmWFBWeEV3M0M0OFd5M0FYazBCU0Q2ZURmamwycGJ4L1c0?=
 =?utf-8?B?SDBLU0dIL3FuOHVNVnhiQ2EzR005VW1yYytQY2s5b0RYb0Y4czNobmlJbzRo?=
 =?utf-8?B?TzNlTVBVSXc5WEJYc1I5aWU5anJKR1RxR0xJQmJmNEZUcm55SkkwK200V1Q1?=
 =?utf-8?B?bFc2cWJhTWg1bWRLa3lXTmFqVXJ0QU8xMzFtV1Bqbkt3V3huWVVpd1hEWkRP?=
 =?utf-8?B?ZG5WQzdFYnI4Sk5KTExYOUNhZjhiN1FwZ3o1ZFlVVktVZjIvamY1L29hWmlp?=
 =?utf-8?B?Vmx6WHRRMzJYSWNlOE1RZS84ZzFTeXNTYURmQWdweUc4NEdMeUJkZXppamRM?=
 =?utf-8?B?RDVYUzBrZ1ZPNTBjQi9FM2s0SHZTeFJ3aDQzOXp1VFNYVFVhUko2MmxYcjFW?=
 =?utf-8?B?c05KTy9MZ3liYS9GQVhGWHVxOTlTWmExQVlpVko1eXVlOTRneEQ2Q3JKUU94?=
 =?utf-8?B?d0I5Y01sM1pvYVUvNEp3Y1BTQ3I0Z29qWFhuMW5BRUFyOUlJN001bzl2QjA1?=
 =?utf-8?B?c0E9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a26c87a-4c62-4c3d-e751-08db7ca4585c
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 15:35:50.3102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rANq/6QFS8G1cBwLIH5h5fn0jkuJXXgVZGA6tOWqQUDqEYWSZPfjPOQ4K8cj3ooSASFdW7CPd8FRGErs6Hjvkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB9020
Subject: Re: [lttng-dev] [PATCH lttng-modules 0/1] Introduce configure
 script to describe changes in linux kernel interface
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2023-07-03 14:28, Roxana Nicolescu via lttng-dev wrote:
> This script described the changes in the linux kernel interface that
> affect compatibility with lttng-modules.
> 
> It is introduced for a specific usecase where commit
> d87a7b4c77a9: "jbd2: use the correct print format"
> broke the interface between the kernel and lttng-module. 3 variables
> changed their type to tid_t (transaction, head and tid) in multiple
> function declarations. The lttng module was updated properly to ensure
> backwards compatibility by using the version of the kernel.
> But this change took into account only long term supported versions.
> As an example, ubuntu 5.19 kernels picked the linux kernel change from
> 5.15 without actually changing the linux kernel upstream version. This
> means the current tooling does not allow to fix the module for newer
> ubuntu 5.19 kernels.
> 
> This script is supposed to solve the problem mentioned above, but to
> also make this change easier to integrate.
> We check the linux kernel header (include/trace/events/jbd2.h) if the
> types of tid, transaction and head variable have changed to tid_t and
> define these 3 variables in 'include/generated/config.h':
> TID_IS_TID_T 1
> TRANSACTION_IS_TID_T 1
> HEAD_IS_TID_T 1
> 
> In 'include/instrumentation/events/jbd2.h' we then check these to define
> the proper type of transaction, head and tid variables that will be
> later used in the function declarations that need them.
> 
> This change is meant to remove the dependency on linux kernel version
> and the outcome is a bit cleaner that before.
> As with the previous implementation, this may need changes in the future
> if the kernel interface changes again.
> 
> Note:
> This is a proposal for a simpler way of integrating linux kernel changes
> in lttng-modules. The implementation is very simple due to the fact that
> tid_t was introduced everywhere in one commit in
> include/trace/events/jbd2.h.
> I would like to get your opinion on this approach. If needed, it can be
> improved.
> 
> Roxana Nicolescu (1):
>    Introduce configure script to describe changes in linux kernel
>      interface
> 
>   README.md                             |   3 +-
>   configure                             |  36 +++++++++
>   include/instrumentation/events/jbd2.h | 110 ++++++--------------------
>   3 files changed, 61 insertions(+), 88 deletions(-)
>   create mode 100755 configure
> 

Hi Roxana,

While I can see advantages to a configure script approach to detect kernel 
source changes I don't think it's worth the added complexity on top of our 
current kernel version range system.

We already have an Ubuntu specific kernel range macro that supplements the 
upstream version with Ubuntu's kernel ABI number:

LTTNG_UBUNTU_KERNEL_RANGE(5,19,17,X, 6,0,0,0)

I'll let Mathieu make the final call but I think that would be the preferred 
approach.

Regards,

Michael
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
