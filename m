Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC54C433FE
	for <lttng-dev@archiver.kernel.org>; Wed,  2 Nov 2022 15:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1667402604;
	bh=VvGnq95KH1ow7+qz/FvGqqWkPodj28MzL05w+YH7fws=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=yUMZfRxgILbSiZqZXZMTgJbXNvVbM0J+R/5mRehjtQdmh6TErqRmhDFSpbDiz5Q2/
	 dPqb3RELUm6d03J4AB1Eg/+dce2t884oKVFCbLY0Wtspn53d20SgW1AkUjlJMturfw
	 5EMMeBMdfH06SE5ImudfjxwAi6qAAy7d9/qOrUDzHZVeINdeMN9EKKZJ+08U/gnERC
	 z0SbQfZf5gs0gWeWqc7dOfGB8JeQjWbFhKzuyl3LMb++oo4g0ABrzSYfeU8OS++zSo
	 CNv2HJfvkG8uEDiZrQWzH03lT+/KXf+mKP9/PujflKIGe1JhGGOwRfsg2deanH6Mf7
	 WfLRt2f3Tt4VQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4N2Vyg5SXlzDcL;
	Wed,  2 Nov 2022 11:23:23 -0400 (EDT)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2057.outbound.protection.outlook.com [40.107.116.57])
 by lists.lttng.org (Postfix) with ESMTPS id 4N2Vyf1nRTzF1F
 for <lttng-dev@lists.lttng.org>; Wed,  2 Nov 2022 11:23:21 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjRHaMuobQ0h99Er9kdGcCgnGeTWQVtMsXs0LZ3QG7IQsMdTQWwBFgBpkc2hAK+XDSnjgxRbcUauE5VpmSz9yRb/mDgYczBcmA4Vq5kxVutQiyJGOhDQMtiJpORERgAmIifTHNTiPDXrFuHmA2GfvIB+Yk7kRvnT3MaMYMb7+Lpeecu9oKCECsdaP/e80cTLusw7sJPFCnLdoIYL8xpxXAE+J3W0sXhDpvT7Y/TTaz0dD86Kp5gQY/2w/ZlkPH+r8aU1WZTM5Nl96vtxBrqPZZEdvhBkQP38RdcmC9AQrCRwA/OD20Ke0+d39/cNWCCgq+5QpOYNbeBe03Gx6LAYHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QBfxBMdeKIyYp8MqlWmjGmrm8xcg3ATAko08pmIAhg=;
 b=VXL/KhKXbuZSOn5F0zqzOAb1kWg3diTUpmc6zFNOBiGMzOmG5ouOO5iBT44MKwp4f5HDHKGT4Z/Rn3NCGIjr/syJw8gas+4t7UkWBmCQO1k12EQYxcgxZbRGga2VJbzI3K+EAHni5gbDLkUi/XH/crCV+m2AF0tRF4SneiTLCSsM7c5A8wRlu8LgAddKYyvTVkddGtfGJoWGCzvyYWloK6L4ma79CkbIDVMMB/ajkcrVVxZ8PiR9ilyP8zyTq5mQ+2ezeyBztsif2UkoVNHQJI5UrJefBb2zgvcSCKMam5RhqZ+UCveR7V1t9Njgyk7nNoqdhvuC8s02+bWxPisJ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4e::11)
 by YT3PR01MB8787.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:7c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Wed, 2 Nov
 2022 15:23:20 +0000
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::421e:2bde:2609:a173]) by YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::421e:2bde:2609:a173%9]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 15:23:20 +0000
Date: Wed, 2 Nov 2022 11:23:18 -0400
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss@lists.linuxfoundation.org
Message-ID: <Y2KLZtoJHrpjd1mr@efficios.com>
Content-Disposition: inline
X-ClientProxiedBy: YQXPR0101CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::35) To YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:4e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB5984:EE_|YT3PR01MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: ca98681d-c549-49eb-da3f-08dabce62c76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZIuTILj6u/zwAFPIeaAjjPs/ZVs5gtiFTKjqK1ICHfe/43tt7GWADyAvuI9eaZvrNfwhNFZkh6s/sfGInSp3OJiWc+dr0P9+oYsnPbQH89o3QD+DTMFFoK1ltvU+6yyhPIhvLL9vzOIFvoAcEZVyHZxf15edTNJY/UJAFSUExQNbwZ7OfRmkPwUpuqUgbIbCXNxim3ynyohZ72DM67iOZnVhQh/MleTTI94bqUkWEkkuJklHw4CBJCfhK4sPaLagmTAV1d92kky3DK5tVti6bOybjctCfauCj2oFCoqjVJA4EeHDXvzlKsFD1Ncym5ntduq3t2BTF4iS4GfRbTgtl99DiBVTW6BsQOZqU1/JE6FtoIdIrWGcSx0taOXVc/sW93fjo2OSa2jf526jI3pe0f84uzel2/4iwpcQuNQ0vWKFi/OG+akGimBCd8Z8bCS0QdL41z+mbEFwPaBXWmGmedOoYPO/yyIRsIUDNjVpTr8hb0gFrARWbArEG75UW9KxLvgjEC85ykGGNmBCVMH3Np50s62f4N69EYFZjPCVcngaMLNK1CnvMqC5IqT7i2h9sXmoBknep/6YWpooEDGZQ1UobtOR1L16GVhPsIL/ryRx7sA/rMrNr5gq4Ya6Q5QMEqK2L2TAfJ4a/0RnkUhDDDFWVs9ShMm7ltqHdsY0aZfHHmcLCP4KDIJtcOGs1Jr65VByd4wtlvFCALueKIozXG3+9w6X6aJvmm8frjIRqyQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230022)(39830400003)(136003)(396003)(376002)(346002)(366004)(451199015)(6916009)(316002)(8936002)(36756003)(66476007)(5660300002)(4326008)(8676002)(66946007)(41300700001)(26005)(6512007)(6506007)(66556008)(83380400001)(2616005)(186003)(966005)(38100700002)(478600001)(6486002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PdScki0oDy8LJ3xwTlmyg+KUU8xzfUHUNX6vPh2gmdDnqYeS8OG0Lv56nUhG?=
 =?us-ascii?Q?jo0qizBnKVqnM6sihHiC/cELkHTdbLeuKEkRDg51Pb9c+i9PMAyFVRz1VL6Z?=
 =?us-ascii?Q?3MvrxFhk3kTx9HsHyWLzaGvyHGC3QS3nfLGq7VaHJAacdx6eGKSGshIMAkPE?=
 =?us-ascii?Q?NN2Dm08TACKNgS1YRPraRkRmc0rRLZIsSagi4V44Q+5MApSsDHD48DfqlVzM?=
 =?us-ascii?Q?3bJSTEVmJLCPjmWriuToE9ykMn9X3KSUqdso0Vb1nVuZfzSwLYkkYVr7oVHj?=
 =?us-ascii?Q?MzKioW8J4B0hysLQEkZe28gpLSb8i/S0Gz2hivw4o2BJ0M+CDzrBqKuF0Q0P?=
 =?us-ascii?Q?4STb+FMwjrtn4/WetpS3+QsxF5jOlr3mIUoQww0GP55V/xB7zw4nnpTcBmS/?=
 =?us-ascii?Q?CB9nLD5kbbVYHBWQzrdkrmzT43LoyDDvK5DnTXNhjvCCFAkPD1pHkcOsTe2u?=
 =?us-ascii?Q?q6Gf59Ebs/NolM/zwuCMc7Jz6P6g4uuTpHL8YFGO8IgypyhyW831XXbY+mAT?=
 =?us-ascii?Q?6FE67+p2HCDDtJrQkU3P/myOTbQHA4VCDeeFApUPefxapRWyNsRvU86S95sQ?=
 =?us-ascii?Q?XgzCJW8+Y1caKVIWb48DZUr47lCKXuL23YadredwN3ZjqbIcVdTh6+oiHL2e?=
 =?us-ascii?Q?ZyX1T0+fy+l1qsZo0aUJHigNS7QBHHOqhHRF6qyBR0LdJQwWJ6Fao+eFRl4C?=
 =?us-ascii?Q?7HQHvgmG/vnONsFhzQ2xzDlM+RFZfF4za+xRWzHDMhbpu9WCr7uTjIV6enNx?=
 =?us-ascii?Q?s10hff2/WcAF25OhPeZEXb5YvyBl4x1kb9DTojVQmzCmAj0xL9Y1FfEnwqft?=
 =?us-ascii?Q?fl8wd3nNyvj5vpFaEeyZbHV2b8jkZgxOS5CDclMrrgZ8TvXitZuR8jqpLqMi?=
 =?us-ascii?Q?mbEw1BdbICKWg8kExnBLyYlmntMnjJeQUBYScg7Otr4jwlaudJKhcxRWDZMa?=
 =?us-ascii?Q?CwmZIf/Bk0SLt0pBKK7Wl063BOZBdSBXnNcbrKAnXPi3bTDES3VjgpY4Z+ge?=
 =?us-ascii?Q?ETWu8PPuhqn/Nbav0dY7LH2njdu9mywWLN/khLiOiRaLE1Kc5a32UVnvh1GV?=
 =?us-ascii?Q?76YhLo29GE8EDbAgV29781I7shUSuByjZ8yAooKJaRYZLyZ8N2Xbpl0J+MbV?=
 =?us-ascii?Q?j89c52VRxTsUR7THl1tmMFLu/y7vuv6tk0C/XDlGRzhhQvwXqYsb0DMVZB2Z?=
 =?us-ascii?Q?E6rb1h9j0mv7GDNeeU9G45sDrfKfYkRycYfL9wTQKYGmSFVVh988webmTY/9?=
 =?us-ascii?Q?du//Ik/x78GOOXlOkN7kCyt07DTwgvCzxLWe6E0n+gFCMVarVHQATXuC3ZNP?=
 =?us-ascii?Q?gLohXRmZ3gU41q4UXugHOAURfFFS3gyWX+O6XKjbCM8looujiqHcaO0gXHVR?=
 =?us-ascii?Q?mNgK8tWa7A/Q715DaobXt7uUURKhGsDsapdFzeguvnwEt6lkStjuPel+3koK?=
 =?us-ascii?Q?MxIZvB+Dflba/p6dYLDHh5P/lxCJJVzs0O0XHLD2eHjCae+IJ8phVh9p6ZY0?=
 =?us-ascii?Q?A2jAP3Y0FLxZdTatKcNLrbbA6QALhAlxcVYi4PdR67z+JS5Q94Xe5fxuLhG9?=
 =?us-ascii?Q?u5iil8w306+WTK2E9QvyewHTKaxT98rP+dTVtr4g?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca98681d-c549-49eb-da3f-08dabce62c76
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 15:23:20.2239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOmzGNilHIXajYKzg1Hk1d+Sr9FgPvdegpZpeXvb78HhCfOTWnBCOqgWmazX8Z9qunj0mwTVXMzU8LLv0jU2QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8787
Subject: [lttng-dev] [RELEASE] Babeltrace 1.5.11
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau
 <jeremie.galarneau@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

Today we are releasing the eleventh bug-fix release of Babeltrace 1.5. While
this release series has reached EOL, this update was deemed necessary as the
latest release of popt (v1.19) introduced a breaking change (changing the
ownership of left-over command line arguments) that breaks prior babeltrace
v1.5.x releases.

Note that memory leak checking tools will report a leak when using popt < 1.19
when running this release. This leak is benign as it is limited to the command
line arguments and doesn't grow over time.

For more information, see:
https://src.fedoraproject.org/rpms/babeltrace/c/d48452beff87b145c038f070e7182358db04336c?branch=rawhide

Note that the latest announced release of this branch was v1.5.8. The following
change log includes the changes from all three follow-up releases.

2022-11-02 babeltrace 1.5.11 (Broadcast Traffic Professionals Day)
	* Fix: distutils removed in python 3.12
	* Fix: use-after-free with popt 1.19
	* configure.ac: Basic fixes for autoconf 2.70
	* Add gerrit config for stable-1.5
	* port: disable debug-info by default on FreeBSD
	* port: add missing includes for FreeBSD compat
	* bindings: try importing collections.abc first for forward compatibility
	* man: fix typo in babeltrace.1

Project website: https://babeltrace.org
Download link: https://www.efficios.com/files/babeltrace/babeltrace-1.5.11.tar.bz2
CTF specification: https://diamon.org/ctf/
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
