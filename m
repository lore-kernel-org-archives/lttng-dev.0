Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC44C4828D
	for <lttng-dev@archiver.kernel.org>; Wed,  7 Feb 2024 14:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1707317454;
	bh=AberttLCS0JklFe5H7MAvt0cutwnjUgzxqGAY6bVh1c=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=usI+qFUq1kMJ8ymEC93ULqCHPGTyVSicNBTEAM0aTSOwi0xjyOnDhp/sgQrf2J7r5
	 zd/7FsZKBSgjklfzHb1VCW3iRs7OqsTzItXp4EYg4C8rEBVMURW7mVXmPaNd2MEDN+
	 JuwCvMyKs039sBbSFZgW6A44CPx0tkH/ziLEmppflhRNaHzoBeYe8NXfcHjyBLomHS
	 0O7vLeFZPbs/J4fhY1sH8WP4msS3pBcdRupc59B6RcxsJbozhHlX4YMiUHSz53GS19
	 Ckg4tPfIiUVAN5Cckkoe6kNUM5OgYkCfb+XxcgjFc1uSZWduSv/7s6RF9XeYhY+KMM
	 xBmgMKqcIoQPg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TVNMx4yTmz1wZt;
	Wed,  7 Feb 2024 09:50:53 -0500 (EST)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:241c::700])
 by lists.lttng.org (Postfix) with ESMTPS id 4TVNMw1FDBz1wXM
 for <lttng-dev@lists.lttng.org>; Wed,  7 Feb 2024 09:50:51 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSsfN40MzHaH1fuv3rUhEk1POHm8f+KJS8kRc8sd3PP34Z2cLD0k0/VtUgw04YiyexsoML8JkNdvriKs2iDwYWKhODpV98qt+M4wZGe8ncBb3cE0/blAM5duT6uUVt8yvT8MaomToTlO6RAIpUx66F/XdP2yd8fw70YHY3d3o0jX2RFTN4BbUIg3dyhe8ygMaKaYUslXX9p8OjupxppntbsPppx2PZfWdqjCCfqgAV0I8BaxCJHlCvdWg74E/qHQCUyH8NZMkmNSHjXxAscqQz6d/Qig22/rBrOx7UWbBlmSX+haNTfxHTFPPQPp4YUfP6o5TkaYhxhCEtxxYOdhnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LP0zk9O6NkYJGYw5TLFX18n79oePC5viusihj/Sa1ZI=;
 b=d7pSjZaxR+ZAAJsjSY/Bf6xa0+54WAq56JaBIGi6NCsXLZeEpH9NSW0rCwPzeW67r+AeS6XmKnlDJNjjTEBKqHFF2JUAdr077lrwuwaJ6dTvXYepisgp4vxJLjXRCdNPW2xXMevtjOpNt0FRe65TPtmTOjVCrKpIdhDtyMazoLZ9Eyau24My1hW+1KmL7IXIV6m4wYN7UQjTr5fyEMt+Vi3FG0DX22YmTHD/Sa02ppNkTqu/Gvqj7FkEGwQSC6hSEjY151nVvFRM8rgO+bKceguK5S89PfJm/mKDKygj9Pk7PyAuPb9Ac8c3Sw0kC3Jxl+tDt7jveb4/W9SnbK2eng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT1PR01MB4153.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:28::14)
 by YT3PR01MB9203.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Wed, 7 Feb
 2024 14:50:49 +0000
Received: from YT1PR01MB4153.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::999e:b830:64f7:13eb]) by YT1PR01MB4153.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::999e:b830:64f7:13eb%7]) with mapi id 15.20.7249.038; Wed, 7 Feb 2024
 14:50:49 +0000
Message-ID: <84a1b2e0-4a9f-4947-a98f-8c89247a8d6f@efficios.com>
Date: Wed, 7 Feb 2024 09:50:47 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev@lists.lttng.org
References: <CAMxxxdO7w__AjLhnuoxjv5TghuEoLNbBS_7N-UiUdv8YykwAPw@mail.gmail.com>
In-Reply-To: <CAMxxxdO7w__AjLhnuoxjv5TghuEoLNbBS_7N-UiUdv8YykwAPw@mail.gmail.com>
X-ClientProxiedBy: YQBPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::44) To YT1PR01MB4153.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:28::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT1PR01MB4153:EE_|YT3PR01MB9203:EE_
X-MS-Office365-Filtering-Correlation-Id: eba96584-52ae-4df0-b61a-08dc27ec2c78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VryR2TrHTBockgkUczP4IClkZPZvdrCmII4N8A918H3zBALZuiZMvJVeiUn9nsSBxrNyU2pkHvPPi1nauQOgg9kOfRv5RxYrIfPixutc8XwqUnQGBgfWSlJBdzsgr0BxChoij890sPIIC6B6FNFlqCIuC7YWUGCkiPs0FOzcpd89qbz+WXNXrXYbqqryVDCGD9/SRQ9wOdm5dMh7xVFYe276v8lb7f+9pgbukRo+rbCPe7i25hUYoXTRGVmkmMZdnh1txb4OYAJkejBbhicHE+qjOCscmanSR5bpE1Apmg0BYaTm+ui3fnP/inZ8BN5npKcfuzi7WH89a9Z0VkWJKYFVHuBHsm3PM9YNJE4iMB1EFi7dz4x5u9jnaIumpZvx1qvgjRgljTpU3vz4/Eu7K8WZa2I9J68Z8E4DK7goN3Yj2Ftwt3BGpOzwwJM4Wvv6wV5k7D7yvSpuv48jPVk5JPy9AzFtasuy6ehdwsHTYrNFlk78DDc8S2rXRrqla5i5ykepS03Og/7CZuJWUpYP/jiiX2xNy8Ym+k7KNnIn4zOBPE7Cn/EocbchCjQKKWHKETdaEwfLsQqnpzTT87kpx+9ctG8oV/8AIxIAS9zsDzVIzYbg/8jIf6O28ukhRM5cBm6Ozo9cHXrCnCbMXegsZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT1PR01MB4153.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39830400003)(376002)(346002)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(41300700001)(66946007)(36756003)(6486002)(966005)(478600001)(6916009)(66556008)(6506007)(6512007)(53546011)(66476007)(8936002)(8676002)(316002)(38100700002)(26005)(86362001)(2616005)(31696002)(83380400001)(5660300002)(2906002)(4744005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3BVK2hzbUd6VWJLQm1nbUE4VmdZWkV3K3hFN0g2d1NyckpSWGZuWFF4MkJ0?=
 =?utf-8?B?MU8vY0o0dlZGNDE0cVpLSUpSNk9YUVNuSE1rT1hRMkJmZmovaUdkOUxCOWpK?=
 =?utf-8?B?SWRNSWQvR21hUjlqT0xSSmFML3NmWk9zcDBsckZRTnZaQmhHVG5GaFRzQUkv?=
 =?utf-8?B?KzBjRkc5SG1hYmpVNExrSzhOZm0yZmRjMXIrOEFqL05GVTlyUXNIOUN5Z05t?=
 =?utf-8?B?blVaNStDT3lFZGUvKzF3cDM5U2U1V01hNExHbnR3bGNENUpqOE0zMHRmQXBB?=
 =?utf-8?B?VFVZcGpyTThvRytTclNWcEE1YlVTRjJaamdJVlVFQlZ4ZnhTMCtDSWZTcGU1?=
 =?utf-8?B?VDRXM3JLTmtEcjQ2aUgxWnlnbFlaTFgwa25JZXZXSWROaDdFZ3QrOEs1d0l4?=
 =?utf-8?B?ZGRKdzZ1M0VBTFR1TDhHSWNra3hnOVNUZk95OFEvWVFPaFNCeFk0d1gzQ2FK?=
 =?utf-8?B?cEFzTm50OGI5ekNIOXRYZURicWVrby9ESlh6bWlkczh6cVRJMnpWSkRTN0xm?=
 =?utf-8?B?NEhNZk9iUHBxbGUzMTRkVWFMalUwWXRlUURlSjZ4ZVJhL0dBR0lkSkJ5WmNm?=
 =?utf-8?B?TjFIQXJnejVUWDlFV1pNRS9EMUpVZ2pyT3FpbU9Hbit0S29ydW95aXRnR2pH?=
 =?utf-8?B?bnJ1Y0RNL2hwRU1kWitQV3lKN0lwY0QvMkJxZ3E2aVdNckJNdkNQRzZ6Sm1V?=
 =?utf-8?B?WG9PVjRpTnBTZzhZNFZQZlhQclR2ejVaamxYQjdJaGUvUjBYbGdhZTFrQ25s?=
 =?utf-8?B?Q2tTVXRyQ2JmeXFZbGw5TUJoWkV6eVF3aVZxSTBweGRZUXZCdk9CeFlyQUh6?=
 =?utf-8?B?UnQrQnpwSFhDakM4cnNUNXRtWFVRS3c3aENtRVhnd2wzNUMrMkVKa0tiVjNQ?=
 =?utf-8?B?RTBmR0k3eFJKVE1PWGFLcEZldzRBYXNNaUNwVnZtU04xSXc3M2ljMUdCb2RR?=
 =?utf-8?B?VHhVMmg4OFl5aGR6dVJzeEY1d3V1dkxUdS9UWGVrQzRJWitXYlpJdEZINVQ5?=
 =?utf-8?B?WUFCT1RkY2FQY0pjaVA5UVl3TzFlMGhNYlJLSVNSOWNFZVVqZmFLZGR5ajJx?=
 =?utf-8?B?UVhyU2Y4TW1NL0dQZlBNZ3V3T2U2b3hKekYxZExIS29xaFYrU1FwUVZnNVp3?=
 =?utf-8?B?UFB3ZGl5MW9xWlVFcjhVbXVjL2xhSWJoZFRJY0NNUkM4Ri9jck45QUVnMkFB?=
 =?utf-8?B?Rm1FRWF2OFZYUzV4emhWRExUOWQyTGpmMzArM3d0OHk0ZVFKSmlKakVwM3Bx?=
 =?utf-8?B?Rk1DcExhdWhHeUZvUWFhNHFtUTVuRHNGQzMrSFAxaTF6WXdmbGxVdmFlcDZ0?=
 =?utf-8?B?eHBnOFZiQUlqVUYxN2o5VGNhYlg3UjdGVlpnNGFYUisrMzNSeGFBL0orODF3?=
 =?utf-8?B?OGdwaHlpckowbkZpekpNTkVmNW9PYmt4T25HdFdkdGVnblo2UDNVZ1NjbExs?=
 =?utf-8?B?R1BvSmlXYU1yTCtJMDdncVJ6Zmk5bVNjbjlrM0dpbnE2WDVpOEk5Q2tqN2J4?=
 =?utf-8?B?ZnorTzA2V1JNdlBTcGhFTnBjSDMzSVN0a2lYNG5WTTNnR0d0a0FxckZoT1RQ?=
 =?utf-8?B?d3RaRlVic3BORHpCUUxxTDhBVnh5YWE0c2UwL0tRa21hbFBYM3J2bUdLL1dK?=
 =?utf-8?B?a2tzSUhWcWxIWC9JSHlGb0cxUHNWT0lOUXJUb3VUOHpOTGxuT3FFb050aFRy?=
 =?utf-8?B?R2NjVThWbWZQTmFTVWlpSjBML2oxMDBGeDRyYjNTWWJtNzh6d2hvMzBhVlpP?=
 =?utf-8?B?VE1jcjZGd2VlVzJaTktGNGZZdm04VHNUb0pjc1JuMDVGOXlVbnBOdU9nRWlh?=
 =?utf-8?B?OWIwU1JKWVRyT0JvWjd5Y3lsUXlGVXYvallWaHdMbHBEOW1LVk9palVEaEt5?=
 =?utf-8?B?NnlxQ25keUUzQXNFcnY3TWRzaHhCR0hYZURnYTdkVDhNY0Q2YkRhaitVYTA3?=
 =?utf-8?B?NE1xd3hmclhJSFhYcUhvTmRtR0w2T0FOclhXVVNMNUNhaEc2cUpwbjVnUnJq?=
 =?utf-8?B?YitjZDI3aDlOei9PZGlPZ0pnN29TQm1MVVBXZzEzV010TEZYbGJnOUR4Q3h4?=
 =?utf-8?B?YmFsWnlyR2FUTjhZWStyY0xMUkZXLzB5ZUs1RDMyc3dhUUNMam1UYkRMalRG?=
 =?utf-8?B?N1BSdkVPV1htYjJ1cW1CMW9QaklxSVAzSUhUOFpmM3J3RHBYVzNBcGcvN0p1?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba96584-52ae-4df0-b61a-08dc27ec2c78
X-MS-Exchange-CrossTenant-AuthSource: YT1PR01MB4153.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 14:50:49.2816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fePZdu83Gfp3vOm6JYWckUKxBdwJ9svtr9RrwptQaXpOZM7WOdOnfMT+RpMMWiGDlTmLKMoMzEVBUe1N45kiOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9203
Subject: Re: [lttng-dev] Hooking up callbacks to LTTng USDT Events
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

Hi Adel,

It sounds to me like the feature you might want to try and use is the 
combining triggers with the user space application notification action.

C.f. https://lttng.org/docs/v2.13/#doc-trigger
C.f. https://lttng.org/docs/v2.13/#doc-trigger-event-notif

thanks,
kienan

On 2/6/24 14:32, Adel Belkhiri via lttng-dev wrote:
> Hi everyone,
> 
> Hope you're all good. I'm working on something where I need to set up 
> routines or callbacks for specific LTTng USDT events (sticking to user 
> space, not kernel). The plan is to catch these events as they happen to 
> spot performance issues.
> 
> If anyone's done something like this or has pointers on how to pull it 
> off, I'd really appreciate your advice.
> 
> Thanks!
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
