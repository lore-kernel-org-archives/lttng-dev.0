Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6D0C48297
	for <lttng-dev@archiver.kernel.org>; Tue,  6 Feb 2024 19:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1707246861;
	bh=o/Dv1EOdz+mBBJKhv96OzgT2zvT5iwbsHnSd2JhwQK4=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=xIg40PTAKaVVwElQMelCt/ZRyeUc8c3sSVndOLCaf+WgLIioc3w2gAYkxpkqxANXN
	 uzcjLVqGcK0PvGt9hZBPWP3wWaiNnUcS1d0t0nyUOriAD8xMwM4HaahdP00bw0FkcD
	 cWeGvoZSLR0iWMmk4MH4Dv3uHkoxhUH5kSxCvV69aGNOlMz3lzOS9FsmQnzlrmoiE/
	 PmMdlvfFKkz4n+4sEjsPlG0ZEBEEPRVSIbxBRu/aRqEqAuJtgBqGlinxbubDhSYsXs
	 5R3AJ7PsxnG2rC1T7m/0jEDzCnwsc6DJKLndpTcNUaY4eojmgddxsnCF8vgqO6IAiE
	 DfQhwDCNRceSw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TTtGN4RkHz1vNY;
	Tue,  6 Feb 2024 14:14:20 -0500 (EST)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2134.outbound.protection.outlook.com [40.107.115.134])
 by lists.lttng.org (Postfix) with ESMTPS id 4TTtGM18myz1vNX
 for <lttng-dev@lists.lttng.org>; Tue,  6 Feb 2024 14:14:18 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2yeChsp4sE8wHX2Be/YQRfIVhidlq+kXO0Qb5q1qh6VQNxtbTMGqyVCumyMsA9hhJ+JnMS+drLzWCJy5vHTSQ7fiaEnIHTMweWtcHixT3ZcXDddUtfmZ8nQ3wSpnLGp/F+LbIQ+/JDrIxylQngnha+XKBhfw4tidbtl1KwcqGFjlLtMoP9D0SFuIArSLwCidpdhVEu2abqRb8OEaVp0tJtiFOorFz4p6r3cp1uIpra8Hh+YryHnwD09DclTwomsz/VAib1F+CQDHB+gT1ndMLcCrjkSch6lsFezwhFasP1OsR/7N+R3R18X4nEI8fHGcaAFbq03qsFJ3wEsVP/BSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDDcOvKBHP4Id/nhFr4+ObPLeTf+QYRvC+scjlzYVKA=;
 b=MpTiwSsafugHeopP8BEtXs+CuZ/I9Libk/gkgvegh6u5vZ/SNGpchLlp3Vc4m58wNRhWRXmcdSU73abFgR+aq2gV6kFLzPT4WDo9jkWKUK8KWfDBs3NyAsY0ni5QDIVKHzyXPeK8q3zKx73J7SbVsheS5pdCBi7Na7UMKkHerPQw1cs0p0vkFQVhpZPhB4+wpAp0fwOBP4qN4WX776c/ir8kJrFSLxqZMZByHvn1JYfUsU612TSkxRX3Mt9Z+OA0M3Nr/3wUPANAFUlHlw4jWRBjWGGVdN6SnxNC2h3MVsG6e3d6PNViBHZb6vkD5oOGLRdLHwjhx6GT21n2BG17yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:24::5)
 by YT1PR01MB8603.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.31; Tue, 6 Feb
 2024 19:14:15 +0000
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c711:83ed:d711:ea0d]) by YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c711:83ed:d711:ea0d%4]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 19:14:15 +0000
Message-ID: <4a3fa41f-9a61-4c16-a387-c6b996211b8d@efficios.com>
Date: Tue, 6 Feb 2024 14:14:14 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Martin Hicks <martin@sr-research.com>, lttng-dev@lists.lttng.org
References: <20240126171833.cppkzs4pl2f4scf6@newton>
In-Reply-To: <20240126171833.cppkzs4pl2f4scf6@newton>
X-ClientProxiedBy: YQBPR0101CA0346.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::16) To YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:24::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB5080:EE_|YT1PR01MB8603:EE_
X-MS-Office365-Filtering-Correlation-Id: 475ab7c8-4e8e-49f3-f98b-08dc2747cf73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SKjrDsuedDyv+xZDmaKPgqcK1URaMhp6g+fL/29KeshpOChfG8EZYtNGG7JY0/BDKru6ogS03pLnHG/lbNaoDdRwEfZbJiv9D61/ERaH6JqEp8RRRfaaVs0tqke1TwsSgdHh0TUuqBxHuFbqkm1iXPddQwsHIq4kZm9x5HD4S94ctHbHFF++iidAUGLM2xX+062NxYvPaTk9S2wrFJPL8KDi83IWGsIYDPKXh4t8ZPcC5gXCHK8neBvyc1UW6VAP61CSvnN6qc0oyjkBcYKNRURIJQYQ7+j5p8soXsa/vmlDDkuSl5JNRIFQGw/uT7v5w6919w06oa7LnbzzcFKgghmJjk4pACcIPUwOtvaoVlKTWPGngq7BHzcTB+dNawcfQTcTYp+/k/ghuFqDq/bOXhB2eK2NSQcT2LeCclGjb5kWVEHJFvtChGBto+AbtcVwEKKOt/kJoarjF8Rk2TYLkt1uC5Ip61GqWC42v8c5rjGCSyrex3PgcrVIQUmRdkXwLEic/J8XiG4Z8Td6MmbqTqgmPp+wWpQWhCbnNK7JwR+MwTDUNW79RkwB37yUOefzclKKTqsUjZPrYFEWPgQ9ZkwNC3Y4MOcllW4EF9zGapeK98Xvcy1gVz7KTgWkYg0r
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(39830400003)(136003)(366004)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(38100700002)(966005)(107886003)(6512007)(2616005)(6486002)(26005)(8676002)(5660300002)(6506007)(2906002)(66946007)(66476007)(8936002)(66556008)(316002)(478600001)(53546011)(4326008)(41300700001)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHRKeVZsM2pIMXhkT293TVZvUGd3a1FLZFdIUGpsaEpybDB0ckdDN3cvK2RG?=
 =?utf-8?B?UXM0UmdWYUdMZ29oY2xoZWNKdllTQ0NLTU83d2NpQTMzV2Jnc1hzaVRyVFg0?=
 =?utf-8?B?Z3VSRFg2cXV3MzdvM1RWRTllS2IrdE9Pc1VBZ01pUDRzRzRDWUhlbU5KTWR6?=
 =?utf-8?B?UmVjZEVQVlh2ZXlKdnkyWHhMczVSaERHc09SSENHYnB0OW83V0RrcXlHNFBI?=
 =?utf-8?B?U1hLMWU4MVpmZXNjdlBUcnVqSU1LVkZTNmIvNWJPS0IyWWx4VUtLV2ZLeEhh?=
 =?utf-8?B?SVhTWTNMSmtNNEd4anV5SUt2eGUwb3dkNnFXYlpSK2NKeHJGNmxYL2NIUjVy?=
 =?utf-8?B?MHc4TVh0OThKR1RFaDJQVDBOblNzSXZ2TnNvdERydERrWW5hWWhzNFZuWkQw?=
 =?utf-8?B?QVNBVmZSL0orL3JXeHdFQ3gxK2dUT1o5VWd1cG5WWFZjMlhZMzBKMXVrWEI5?=
 =?utf-8?B?Qjd3RXRzUE90NVRWTVNhV09wZFducjVMZFBoWGVPWFc2UEhlRDBkeFE1UXdJ?=
 =?utf-8?B?bXZRNDVBelc2ZXJ1ZWxLbEVZRmlrOHNxZ25NNmtYaGxNTUZ1eWdZSWhJOGlx?=
 =?utf-8?B?enJCakZGaE5WdHoyUlFGaFlBSDEwcmdPSXI0cG1IS0oxUWpIWHhYbDErZHB1?=
 =?utf-8?B?NG04Y2JZZFpaNm9MNmlRNFhmTlRLVkdxVlpJSFc2aGxMYXRwYk15NFErRXZo?=
 =?utf-8?B?WDdpbVhiZFptMDNJdXFHR3pIbWlaSGJnbDlIVXlGelJINlJMQXRUQldhajBa?=
 =?utf-8?B?ZGdRdXJDM3NRSWN4NlczN1BTY2p3UW1VS0ZsN1hqYW9tYVlNcDBMcnpRWUo5?=
 =?utf-8?B?ZWs0OXo5L21HdktqUG82NE50NDltZ2trRjRMb0FYMmM0WnQ4K2JuZnBaZU5i?=
 =?utf-8?B?QmkxaUt4Q1ppbDhpR1poR0lRUDZDUExxYXA0enJuaEROelpjTWlNUEJabEI4?=
 =?utf-8?B?akVnT0h6YUJnN1QyaSsyOTdscE55VHRLam90S3hpTXQyR01lTm9MQlg5dlMz?=
 =?utf-8?B?SmNBNTE2STNMSTFwU3R6QStIRmlScDR5TTVUNEh1eGpGdWZGUDZtOWVMMEhH?=
 =?utf-8?B?NytoK3I5eGlFQzV0SmV6R3N0Yi9oOGovOEhQSnBzM3VyamR5UmE1UDZhRGxt?=
 =?utf-8?B?MUhHejk1d09iU1Ira3FvUEwxSnJyOHppdFRtYkFGbXp0amIxTS9BaDlzUVY2?=
 =?utf-8?B?di8wUUhENGQwSUFsZzlOdWg1bkRsWHRoeUNzbVdQWXltam1pd043UllEZUVX?=
 =?utf-8?B?bTJaOGk5YnM0bm96LzVmVGQ3SW5ueUZZSjYrclcydTV6OXErZjAyV2x1RmNZ?=
 =?utf-8?B?U2xsaW5VeHRjOVlRdzQ3WFdwSHE2N1NaSkhWbVpjZit4QzVXZmdnSE9LTEhw?=
 =?utf-8?B?Y0NhaEtxMWwxK3MyUU93Mkx2QWE1WXArMnlRMFZnZG5MZkJ5WklGRXY3cjZN?=
 =?utf-8?B?KzBGdkFhKzZ5UHVXL0NQR3VmSlp6SHhmcStOKytpeXFBSGIyYVp3Z05UWUh4?=
 =?utf-8?B?TzJKS25QbjJscUF0bFRySDg0dmxwMXRkMjBvZXFzL0pjWmhLdlBTelJZQUpJ?=
 =?utf-8?B?NDZYTStRWWE3bkFVcXp6NEF4dVVRZlVuVFJLOHAyeGs0OFdob2NsNnZFcmNX?=
 =?utf-8?B?cko3Zk1NTVFtSHZUNDl3UWozWHA1WVdtaklsRitWaDU2TnVRQ1N5dDJ1ZmVZ?=
 =?utf-8?B?alozRUU4NmgzOGVYUEJVNWdiMW0xNXNJTGx3Mk5EN0VncE5NOWNxZDltNTNa?=
 =?utf-8?B?NzVJQWc1cGNsRjRXWnBQUU5kNXR0N3lXRlpTeUxOelhEakNsVG5haXh6K1Ft?=
 =?utf-8?B?K0ljQnp1YlhpUzFJOG5oZ05wM3JJY1JTWXdKNUtPUlVDcVdXT2ZkWkM3Q0p0?=
 =?utf-8?B?bUV4UTQyblJzN2duL0tFVWF4SThHVXp1NVUrVE41dWRySFl4SlQrNVdrWEVa?=
 =?utf-8?B?UFlxTWx0YXo2VE5wK1h4NDNjSmp3dklQLzNUMVdhc0Evc3pHZEt5SVR5V1A3?=
 =?utf-8?B?MEZveVd4WW9VRjhXWVMyZ0hUa1JZUEJlNWgyTnF6UE03dzdkRjBOVUE1bGNZ?=
 =?utf-8?B?Y2htMzd4WldkYWtNVFNvUEdKK2N4TS94R2NUakllWVF2R0Y1Vi9jeFBEemZU?=
 =?utf-8?B?ZVlkWlBadzIrb3VuVXlya1RUdWxhdmFlWFhaMjI5ZTMyVk4rQ3A1NTYxL21C?=
 =?utf-8?B?MEE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475ab7c8-4e8e-49f3-f98b-08dc2747cf73
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 19:14:15.7576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hgc2r4AjUZFUWOLK0E3jNM4LMtRNV4r0d3xAEkokq9HI4xemVUI0tBpjFPeFWVpzIGBF495HGCnP+ON2dQoLjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8603
Subject: Re: [lttng-dev] [PATCH] Compile fixes for RHEL 9.3 kernels
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

On 2024-01-26 12:18, Martin Hicks via lttng-dev wrote:
> 
> I'm not sure when some of these changes were backported, but the
> unmodified lttng-modules compiles vs. 5.14.0-162.23.1
> 
> This disables the kmem and compaction modules.  I don't believe getting
> these to compile will be easy, as the required struct declarations are
> in vmlinux.h, and haven't been moved into mm/internal.h and mm/slab.h in
> the RHEL sources.
> 
> Signed-off-by: Martin Hicks <martin@sr-research.com>

Hi Martin,

I tested your patch and did some minor fixes, I added the base kernel version 
to the RHEL ABI version check in the Kbuild file because the ABI is tied to a 
specific kernel version and it would conflict with other RHEL versions. I also 
adjusted the range for 'kfree_skb' to build on RHEL9.2 kernels.

I uploaded the updated patch [1] to our gerrit instance for easier tracking on 
our side. Can you please test this version on your system?

You can get the patch using these commands:

   git fetch https://review.lttng.org/lttng-modules refs/changes/50/11750/3
   git cherry-pick FETCH_HEAD


Thanks,

Michael

[1] https://review.lttng.org/c/lttng-modules/+/11750
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
