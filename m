Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039D5C48BF6
	for <lttng-dev@archiver.kernel.org>; Mon,  4 Mar 2024 15:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1709565123;
	bh=bvEyR7vgz/617/wtIoyakfRXg7bYmND3ltM5QOpGJzI=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=MvHs1HTCVdID9HazECDmzoyuagvdrXw125UVYhYJ/kPBSTaKlsCiVJwhO+lBaMPoE
	 +ndNw9jw8owMQLRd8uTwa89q60L4KrEI/vIB1WsuVVBex+dWql97AsT7iZ3Juq6lLI
	 rNyJaOAown0mnVkKjCz3X1AAOiUOCuzPashOL0MJ4tdSOeYnzqzgzxSD6LTnvy7cVC
	 pqsoKfi+HgFeYM9EpnQv1iVcppoQ/r2sJHtmGoenazVPyn8q/O/OfyY4YApbsPDPUf
	 EF3NtQ3F/XwoljzVnT0Jsb1BBptE/KxXyzaokMaQniCVPI1iweiTCd1/NMc79vYsQq
	 TvygdU072jEmw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TpMcM01wlz2FdZ;
	Mon,  4 Mar 2024 10:12:02 -0500 (EST)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:241d::700])
 by lists.lttng.org (Postfix) with ESMTPS id 4TpMcH52WZz2FXP
 for <lttng-dev@lists.lttng.org>; Mon,  4 Mar 2024 10:11:59 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWSEqDk7Sf0uIahAWLbUZj/zSRWZOCn1KNKe2rD2f+DUoWHozN8CqbsoqqZtpu2BM3kS0SXMai8P2KLYWEk2nyExf0ISQQD+uTyVhnerJb3RLAZwMJVMukAJZYnAQ3RmwHKnh+Me0ZwGtY5NlGdZuaix1K0pCX4dtyb3VmUl2miOhXzMduO3vdWUPhnxxPvX4DP9JMs40Xsulx7+4AHxPWIjwHEUVPNlcr/wq4I6EWhh57kUuyE5Xw1UQemUpbiNxjjmD8rHusofJYTb1jMHtDtA0UUxheT5Gyxw8ib26hszXjNd57uygKI6YHvaid98KUtkJ2vnvHel1fU3bikIvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhxLW+mNeyOKFwSRPw/+SOPjzL73honGWvwzLBWSSRY=;
 b=l4PnYJSSus/3lrPCelpd901GCZv+kKmYRVnG7gtQUmndT0BbK1+vgDOalSWbO0o5NhhmARUm/8jjnFi0DcyAyYSReEciRg9ASIMQjmdnGUjVSNT9S4xZ9GcgBS7VQNAgldsaMacOe+tGiDg+TxxgyRdx309lI99C0v/hgC86kciRR0oHOl1vp/ApmZj47pZNHafpxXu3h8wKtffJ2rb4dbmGqTiWEhuDLzm9vtwhPswAEZUVnK5bI993gFXiF5qBgSZMycXhx7yCJCxabElhhkm0lHRLxJiXIWP1AThm1ES5gJGtTdakLEp7faa9Z8+8YTBno4rL8N8BBpdoa6G7Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT1PR01MB8363.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Mon, 4 Mar
 2024 15:11:58 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::17ea:ed8e:e437:46ed]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::17ea:ed8e:e437:46ed%4]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 15:11:58 +0000
Message-ID: <8a7e39ec-f8d8-4f75-b345-81154fffc1ee@efficios.com>
Date: Mon, 4 Mar 2024 10:11:56 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Zvi Vered <veredz72@gmail.com>, lttng-dev <lttng-dev@lists.lttng.org>
References: <CABRndgwfhU-e1a7f8dFSwV5Pny4cuEeqbhA_4GCkKK=574bVBA@mail.gmail.com>
In-Reply-To: <CABRndgwfhU-e1a7f8dFSwV5Pny4cuEeqbhA_4GCkKK=574bVBA@mail.gmail.com>
X-ClientProxiedBy: YQBPR01CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::27)
 To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT1PR01MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: c216bb48-bb37-4e8c-5037-08dc3c5d6f70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zHS5J9BV+48syEHAmltKxNuqylF66zB57Bv2FbAZewViGq4nMDzU+4pWQv4scHlmVa/mfZk940tbzKn27X5nQ3Av/Q/0LwctM2JyV5MTWZFyH/pokhp7mT8qs83YleApK8+jC0pbelzZAabCSrUj+rVP6wbfNMpurriXpebY7yvG+RDka14F8BcwTlhk9FnYK728CVlQV6yhtvQOpVELjDblE5+2LKxcctW7Vbb1WprZawVaQwjq3jkvXMxI6yyGX0q+ruY6iDdwesTpFD89wWTDXOvrM05I8gBIVSZlPJIY1GtcDnp1nDMIx+rDttRFRf7lvN3bse7RiwX6A/JNBC2YiNnQB4h8S8lmoYJYKhTxZ+deKfQhQXAvBtJqLk/MT8Z1G3bgOLvhMTP7xqERVkosChVB4a2dMrs8Q3GYe2diO5m9jT09miXeqh9dp8RaFBB+C2B6SOZF/vXUS9RcUVss9+Ju1KXiqe38Gid8MkgrQQFfu6oRS6c3thRN7eWuy2OgIaMGpLIZwIg+4vXr+Skn696ugLUHlzoklcRpAnDRuouFWDGetRbVcVKyddISHkY/Sk69E8cnJiu4DYZBwmHDqa/N/0962a1YLgycI7Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFBaaHlnZ212UEg5U294UjVMSjFMMHhMSDhLVklsTnBoNkZ0RmNucURLdGMr?=
 =?utf-8?B?RE4vd3BCdWxoMm1vMkU4UmI0eDZnUTJhR1J5UitTMFpidFVnK01Lb1ZKRjRv?=
 =?utf-8?B?Ynp6Z1NQM1R6dEN4VXoydkowNkNDOFJ4cW9lVzJLZHBUN1NMQ0tuZ1U1bGt1?=
 =?utf-8?B?VFNjV1hZRDBhSDZxVEJlWEE4NjZlUXd6dXlVaFZ1ejh2Y0RGWGFBU0NzSko1?=
 =?utf-8?B?WVozZHcvR1NkTmVGM3ExVW1OVmxwMGFDWk90bXU0LyswYWpHMnRGa0hCTVZX?=
 =?utf-8?B?aU9DbnRJVEg2UU5aZk9CNEtsVWFMQytwc2R0S2crcTFJVldqUGpzZnByTi92?=
 =?utf-8?B?RHFlOTROZU1VOFRYOU5qTlZ3bWdpL0FySHZxSm9PT2gyM2lmR3BrVHpIeDla?=
 =?utf-8?B?OEVEVkw0b1pqZlZWNWtSWmtGQnNDY0RjMXpwcVJ5M0IxaWZ3WjdWT0NVckpY?=
 =?utf-8?B?VW95bHNKbkpvYnhzbGRPcTBCK3owTDFYbFpuOCtsZ25CQ0xab1pWcjlWdk5I?=
 =?utf-8?B?SUJKOEFaV0kzZDFNYjZHQk5lMTRSeXRuemNBblV4RXByQ3Fkc1J1VGpSQ0hB?=
 =?utf-8?B?cmpGbFVER0M5K3BpN2dVdnRucHVIbUpscU5TQkxneFJTaEE3cGRrcmwrczhx?=
 =?utf-8?B?MnFsUWwybjY5bG5nS05hdUx2TmRhNDRkSEJuLzVDSU0rYXM2RlN2V2YvYm5T?=
 =?utf-8?B?MURUTHcrcThzVHZBT2xodWFEZExWeUtCK2VaeEczN0VLUnQzL2loWXBibEVK?=
 =?utf-8?B?M0xhRy9XeCtEaUNKRVg4VVo1b0JnZ1NkSzc2cjB3aW5wVmVIdFJScFVuM1VU?=
 =?utf-8?B?RjQrT2pRVTQvNUtCVSttZnZaSjlpc0s2UGphdXJ6K0FrWGJYNjdYaUN5QzNK?=
 =?utf-8?B?a0MwL08zWVIrQUprUVhPZDNlN055V0Jad1FuUEFxR2cxamdJY1IvTTgwZXEx?=
 =?utf-8?B?RjRhb2JtT1lKSXpGVlQvbmNVd3pCWmt4bnBsdDhCTWlFYWVXOHhadjBuSk5P?=
 =?utf-8?B?N1hLY2R3eng0T2hpdmtzdFZRZjhkN1d0Y3VrN0lpZGlWQWxwMUU1QWdZOXlh?=
 =?utf-8?B?ZEIvT2xJakV1STlUWmVtbTZvZXBsZ2tWNTJadEpxRUZLOG83UkcwMEp6cDAw?=
 =?utf-8?B?eWttVlIxdnd5U2RzQUI5Wk5ZZG12UjIwbUg5MDRWVmJ1Sitnb3YxWVloVVFC?=
 =?utf-8?B?SXVmcGI2ZGFadUhoT0QvSjJReXAxY1RyNFROekVGYjNrblNHRlczTU0xNHBC?=
 =?utf-8?B?RDRTUFdrNm5uL3FVa2xCc3pndVNoWGhOclFTOXRjOEtTcXRFZHFMaERCeG9r?=
 =?utf-8?B?ZHNWbzZKNlI3TzI0SmZyNnZEQkNsK3RYWWlibktWeWVUMzFlaENkQkZlUFpB?=
 =?utf-8?B?b21ESUF3M0VHbjNRNFZmRzIwT0VWMGhjVVhqNjU1Q1RkZEkyRGJGSGV2SVcv?=
 =?utf-8?B?VmI3d2R0RklzUm1rd1Z4TDNwODRDdHFFTWhkL1d1eklHRUo1WEVxTDFwUGgz?=
 =?utf-8?B?a0FRYlNyNjltRUtFWnNwa1YvVWpQR2w3S2F0bjZWYy9jb3hyWE5MK085V1Iz?=
 =?utf-8?B?VVJyb3JWTnUvbUxyc2JENGZWVDVOVFlFVEdBbERQSXRCQ1M3R0VKdmpraU9W?=
 =?utf-8?B?bXVxeloxZVIrUzZ6N2JnRTdVeFBtbHJCWXg2RElvSmtuODZUVGZwdGdCQTdP?=
 =?utf-8?B?dy8rQVo3SkFYZ2NZb2FsTXRyb0pWSkNtY2pBWUNNdmNaTmZaSldHdFBjdFBV?=
 =?utf-8?B?T3p1ck1UL2J2WGFmWHNmcUcwUWNEQU5mSHpZOU1oY0dDeXVhVmh1UU9ONmM3?=
 =?utf-8?B?Vkg2Y3REdFE3Q3pNNSs1TkZ4OHpmY2lwdWpnOXlHRVBrMUpydWtXQUhUSEN3?=
 =?utf-8?B?TXlIajVacEUrODhOc2I3K0ZubCtBQjZhdEhGRDZXNzBodk83U0xSQ1ZCbEp5?=
 =?utf-8?B?dHFJWll5L0w4NHZnSmV6VXFuQzVxeksrekpMNmY2TkZUNXNYdDVpSC9jcWQy?=
 =?utf-8?B?WlZRdjN3ejRUcDk1U2U1V3MraGhWcGRzd2o2R2FCTHQyYkoyK2h4UFk3ZWlQ?=
 =?utf-8?B?dHRxcU03WW1qUDRnT053eHRJUU9sYnFySDJYL21rUld1OVJtMXpTRU9jZVVH?=
 =?utf-8?B?K01QbzJoUUNxRURPVllncGVnaTRMYVNrU0ZsY1g2TkdvQ2VqMk5UNFZCSFdz?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c216bb48-bb37-4e8c-5037-08dc3c5d6f70
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 15:11:57.9928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PanmfdsiRWY3x8QbxN4o4QkZa3tjeDrQ8UGaKsDa+qVTFXSFbY+Ccf5lc/aDvkMhhtyIR+lecb2wtQcfIN6KhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8363
Subject: Re: [lttng-dev] tracing user event from multiple dockers
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

To share a sessiond the LTTng home and run directories, and the shared 
memory should be shared between the containers.

Eg. https://github.com/mjeanson/gcloud-lttng/blob/master/pods/demo1.yaml.in

In a scenario with multiple sessionds (eg. one per container), the 
traces could be combined in post using babeltrace.

thanks,
kienan


On 3/2/24 12:31 AM, Zvi Vered via lttng-dev wrote:
> Hello,
> 
> I have an application working with multiple dockers.
> Each docker is a fedora O.S running an application.
> The host is centos 8.5. This host will be upgraded to RHEL 9.2 in the 
> near future.
> Is it possible that all traces from multiple dockers will all be written 
> to one metadata ?
> 
> versions:
> lttng-tools-latest-2.13.tar.bz2
> lttng-ust-latest-2.13.tar.bz2
> userspace-rcu-latest-0.14.tar.bz2
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
