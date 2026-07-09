Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DA3C44506
	for <lttng-dev@archiver.kernel.org>; Thu,  9 Jul 2026 18:48:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gx3rG3Qn2z27GZ
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1783622896;
	b=GZgxvhEteUUEh+mVM1Ym/5/FOoxaHw0Hnh4smFMIKjjehaCOKmlsLn2+Xhskr0CjlPz5
	 sitseM8GdWtKjzBwAaUf80hPPpdWv8ZMEynJMKDU/ZFxMeilBLE2z5rQ54wnkH4QRgeoW
	 uglm3OAWXm2z8h7xR+wBYKUQmeLCl3ZVG2l9+NxAOgxA7V/qhDaQamr7MVSaLclNs9Drb
	 Pbkx0CI8AO38jaYa3aAjeCpbJpLRkb8zink2aPn+EkaKmV49ORZ0/olcFT8j0JZaGE8P6
	 V5PD96+WZPc1U0IVqLpcrv9pGJEF+cGoeef/uV6PAyRJhrmy0HBJD1wQOoqeHw3oWBw==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1783622896;
	h=DKIM-Signature:Message-ID:Date:To:Subject:MIME-Version:From:From;
	bh=vHu/cyIYrMQBj864zWPR0hAevv8s9sQbcRncYej2uss=;
	b=AoEY96WVYZ42EA/Ba4rV8lvhBcnomP43irq45K1StGVR49RT63JSjaDCaLv6uB3rXmjI
	 ly4d3IDftbU4XA7fc9ot6drc8v2vEPRkexol0sEBT67nnbl8xQ9hzY4sLSYO/PIp7ySQ4
	 ivHdvOBs2gtr0Hb8MtzsfAozXoyugYq6ZRrwgwn3t3t/Fi+gx3m5nSsIXGaXhldl0riwZ
	 WpxKAJp0ft6gmOn0C8x4UMQGs0SZ/3BY9xwvCo8oNy6trKgiALS0UtXl1yqm5RNIoZtso
	 AwXxZCNBgegUSBswO1HSSZ7ZD/MX0NYGvVaa+j3ktMNiJzk4LaCaBge4ihyPHqhVi6g==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gx3rG3Qn2z27GZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1783622896;
	bh=GSWqqbZQVxssFKm1G85EI4Mzhsqalntc/s6NSSIk+PM=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=yzdgY/F8ZRRzi3eVT6Bf2AnFvrGC5+oA12v9K536diHyyvdXvyW2FqhZE4zjxSuNv
	 6e6tSFTKLoDZxyWzYedE1tULXl7C48yqWS5rzShiUdcRy8RttZWCQe7jFuYcgFZalr
	 Eb08bkxbiQUzSm3mmHVVByP7FuQz+uz4NrZiLDyXPszFmIgec2NH3ZknJUnHS9Hu6L
	 ANdIttY8maFrHECL/LsSwo+4OoFGhIEleT4Y9wq3hQ5U3CevOIDDkWsFCJR63wv9uj
	 5tTZCvo7sZhhJT9xhFURJvBo2x2bkA1ZgJJXxBov0aQel5vXgz59CezzixspScsa2Z
	 lzTsqUNMbNRbA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4gx3rG3Qn2z27GZ;
	Thu,  9 Jul 2026 14:48:14 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gx3rD5G3wz27Kd
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gx3rD5G3wz27Kd
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazon11020084.outbound.protection.outlook.com [52.101.191.84])
 by lists.lttng.org (Postfix) with ESMTPS id 4gx3rD5G3wz27Kd
 for <lttng-dev@lists.lttng.org>; Thu,  9 Jul 2026 14:48:12 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgAZrdXhxHWbJrSChPAAHiOck36WmHmT7ACRytajWpUNT9Wn5fBiStwO59AJMkluJof0yl5l5CZm9v24Dkc3uQgxKIKgmaIJH3gxblaXCpCFFfIIaXMBGvTynViOvsOmE6Q3prWN4irbeO2ZWsoyA1G4xv3V0a+v0HLVX94QdvYGO+rbKtActMIEIolSQYQQfj+AQfWb+Dda1fWwqgRCKAlXjheiO0gZxEFbl+bm6e+oMIU63MKMVr/XIHkHMxLr3uVEuUoQx5+iEP7UeNMelqhPTG6XST8K9TnKeFh5hkuWxugRJMq/ClOpU+I8gUMlFCCukTiNjygv2W1U1DXeQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSWqqbZQVxssFKm1G85EI4Mzhsqalntc/s6NSSIk+PM=;
 b=UEy/GaFhIDqOC1ei4ME1ORIoO1n/COiNZSmHYoS1uI4al9zRv8iilTrUwaNbJYXGSvI4NaMJ/wvIS6zIGEsulOFCJdxgTSqyCrgDxMK1FENMwrfp8Xe3uAKMyVFE/B0sOA88wJ8uJg9g8bXG4ixNk4Mhz3c3+qzd3OBQlinnyTRQgb8kUkfDfL3yZD86qlINqygGH4kFZYZ+0jK0fsTZGAqeoQt0YTio4lJxBvFniOnB63Yg57/GB9sxlHoWNtQ3IVgqAiLgup3FSweA/JIdFvnSalnKQoT2s5mow49k9d3Z27/xVHheo39l74OB5vf5WbJI5Mx++Bq/9BvSjDb6sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB8897.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:7a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 18:48:08 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 18:48:08 +0000
Message-ID: <e8fa9744-74d2-4fae-8684-f1df59aec1c0@efficios.com>
Date: Thu, 9 Jul 2026 14:48:07 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: paulmck <paulmck@kernel.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Olivier Dion <odion@efficios.com>
Subject: CPU affinity behavior of liburcu call-rcu per-cpu worker threads
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0103.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::28) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: b74b48c2-560d-43a0-8652-08deddea9e2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|18002099003; 
X-Microsoft-Antispam-Message-Info: JEYWBOP927MDBdWTyVrAuAMcXqo4m14yIc4APZX17/KnwATsTso2g5Nf1LnoL7oW9/EAcxRDh2fsDm/rJEZ0i6EY4UeDskFaPiM6dxhY/Ec7tjpH+cIAqraW4Pzi8A0+zcNMOu4emt/Y1mayX3VyXL27M8EOeS0mqbppUnpHwdj7vUUjxXQCcGFKwRX5ibK33Dc75nXAuR5ONaGKPuVFIO/EpYJaU9DXZicbBUkkAxbaWt3JcUTF6d4cSsGbGiXTM7d+2db+deE/nzJQDYGv5CW+5UaGkExMgjJm1ERPLLF3YpxTx34DM1hJ/GiDDlU3QecNzK/Ft18BKrCaLKp+Qplmoj9zndCoxZiy4nPwMhHa2Sc/yZwEcL2MiC2vH15F83YG6nGDyyoOXCxMH/oyHQU4VEATHaOqM86Nz7Xkkznb6AaAJDjksgyJ+Q1HAGUreNaU2rVIv0o89yYZMeFfCkXTvmRMn4XEFYS+WXGFv01TT1tUN/CxzmwanWy5bTcCMYKJzc5Z18rPouIJpdzmdRdzoMlYtKwIGWxdFIZVCKWujN/Nw5UP7bgoNMQ6QkGGOuFk4DFRLEk1vZGRe/w+84Fg/lCFimg1j4QKYv6ld3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFBlZ0h3TTF3TWNMQUdrMkJTYmNXdCt1UkxoSTJSMFV1MXd2UEk2OHkzSExX?=
 =?utf-8?B?aEIwazJLakQrekdNSWFHWW9nMjdGNnVkN1Yrb3cySXNmcUcrU1F4NURTU2xr?=
 =?utf-8?B?akI5NmtDOE8vcUphd0lTcys3enJlcU5PVW9YdWJhWVk1eSt0NW5Gck5IZ0w1?=
 =?utf-8?B?VDJjVzVWN3RpY3NZc1YzSHFnd0VwcjNqaEtQS3FweW95Z0cwbXE1UUx3UHFB?=
 =?utf-8?B?ei84RjB5cTZHMzFSbno2QmVrYXZZU1ZGNjllZzM2djlRTTFUS0pYbVlhWFRi?=
 =?utf-8?B?bWZlb2hrT0hzRE9BU1Y2OTJtRTVHZUFuRWMvKzl2SVpQMzF5NU9xQlk0cDFB?=
 =?utf-8?B?ZWRnSzFtWGpIdExIN1hSMzNBd0Jtb0NtcEt2aGFaR1ZnZUJMT2pMWm01eHl5?=
 =?utf-8?B?V0VlZE9EZ2NGUFZyanpRTmFiM3pITXVLVnVDaEtRY1pVVEMrR2N1MGJzeUdB?=
 =?utf-8?B?cXM3Q2hjdTZzcXdxWTR5NXpKWmZULy9KTi9ZajdBVEM5ZFVlWkFDSmM4Zm1i?=
 =?utf-8?B?NVBCS1JwNGZFd3gwQUVtQUtQMnhUckJJUHh4VlVXMEFyazZMeFhaK3duQThu?=
 =?utf-8?B?bE1ZR0xYeHhVRVA5MU9hdTNsY3RJTUNHalRYU29DU2JrUVlEc2Yxek5pN085?=
 =?utf-8?B?ZWlvelR1UG9GMTRVdGhHc3VTRHpyUFZ1UzZ6OVZhZGRpcE1qb0ZtVlFwTWs4?=
 =?utf-8?B?WGVKSlo1Qlh4NEdJUmpmSXRLdEZEUXpZYmIwN1pidHdXb0s5UTNadHpXMGZM?=
 =?utf-8?B?ZGpoTGR6VWtsVThBVk5tM0RkYi85emdsZUNRaytsclFLSm1WUFp2SUd3bXlP?=
 =?utf-8?B?clRiQ0VLdFRLaUhmY2g4R1VmN2YwMGl5R0VOaDhTT0tBaDRBOHE0VU80a1ZG?=
 =?utf-8?B?TWJqVFFJMS9kcHhZODR3a2NsbnoyUkhpYmQ2Z2NHcXpnc2RIYnhaSHRtNWRK?=
 =?utf-8?B?c0hHY1N6bFE3cC9pT05HaldaMElBb1BJc3hJd0RQMlF0ak5tdkpubXY0K2VE?=
 =?utf-8?B?eWVDeEFUZDAvM294WGxsM1c4ZDV5WDRBMEg2emI5STkxdjVQc3ZIcmNNOGpt?=
 =?utf-8?B?ZHFjRktDYk9xN1d6OFBGNWNySzVLVGhHOWlURnJzbWphTzdJbW14NWVoQjFN?=
 =?utf-8?B?ODRnbENkY1lsMnFNWkRFQlBrL3g2WDJ0T0h3c0MvS3BweGJGanBzQ2N4TDMy?=
 =?utf-8?B?TkVQSlhkSlc0cERFRU8wcXNNbE85OXkvaHZPc1cvTE1TdmVUdlFTZVdabit0?=
 =?utf-8?B?ejA3UnN1RDVwREFYV1RtMHBjSkZSWTlsalNJZUVxYlV5aWZ0T0dJOThxYWdU?=
 =?utf-8?B?V1dic2wzYTUvSWhFMUJCNGh6Y1JZZHREM1RYS1NoUVYwbHBUZjJsL0FLS2s4?=
 =?utf-8?B?VzI3Z0toenRrQ2IwREFtTVlBN2lOVDl6cmtHOUNnRitIcG5GN0pETjhtajJo?=
 =?utf-8?B?U2sycXZLNTRkYU80L25jSkRGU2xqTTdLNTNoMElQZXJPeTNGTWN2MnNkQ0x6?=
 =?utf-8?B?akFXUk1OTmlzK3NtanJJNzBKZ1dyRXcvV3lyZWg1a2VwbmY2dVdGTWdIeEg4?=
 =?utf-8?B?Tk1YWHA5cmZUNWUrcVhDWTRMaW1YUjcyT2N1eFhrTkZ3dTA2bHB1d2JiNUVo?=
 =?utf-8?B?MytFZ2JjT1luY2NzVFF1L2FMWnFvdEdlZjZHWlF0RllIWG9ENjhGcFBxVkNs?=
 =?utf-8?B?bndmclVZT3gwRHI0VjZpZlVZU29RRlBnMEtUMWVEMUNWVVNycmowVi9DM3kr?=
 =?utf-8?B?ZXNzVU42TmZUaUdKeFdEV3lwakFjSUpkNXZ6aUlDU0drU2tod3NlZGxkaU9I?=
 =?utf-8?B?R0NFWUhkdWVXSjB0UnExdk8xcGZtQWFxbHRxTW1DWGh5ME1OemZqQWU2Uk9p?=
 =?utf-8?B?RVFRdU5zcyt1NTdscE43a3hLTmZEdE5FaklCWS81dHM2Y1IwWWxJN2xwbS9l?=
 =?utf-8?B?SGFNcHN0b0NwMGNMNzJ6L2s2WWhXb1dhc2NJanhqUUhMV0hvTTVsUEU4cWpB?=
 =?utf-8?B?TDZMQm9MK00ybGF2alBVT1Q3QnBLeGkwVUIvZTFERVo2ditNcmxkZkppWktD?=
 =?utf-8?B?ZGs3NVZRVmJtNDZpN0FmWkYzT1VRK1BsZHJ4RHprcVgvdEtSamV2bExjeHli?=
 =?utf-8?B?TmduZW1YejlpUm1yT1BqQzNaU0FYVVpGY1d0Z3dWeXBEbkZJaEZ3b3QvWVFK?=
 =?utf-8?B?QWh6bHgwOC9uMVg0WkUrMlRKbzd4d2pNSk1oMmp1aEIxQXp1ZUs1aEFQeWhJ?=
 =?utf-8?B?S290ektqakV0Z0xOczMrR1ovaWtoa0g2SHRJWVhnbnZ1bzRidFNyNFdmVkZ1?=
 =?utf-8?B?NERwNnRiUHRvY1NGMHFINnF2VTNJOGFWbWphTzhPYjhwd3d5bnRyOXg3bkd3?=
 =?utf-8?Q?xd4tyEWym2W34iM0=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b74b48c2-560d-43a0-8652-08deddea9e2f
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 18:48:08.0858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wW7JwVtt2xQL/m2PSe9YLHA8nYBj9Vh+XEcR1Cr4JJIt8wsJIhLWT9S+q42a2wUKioDoIiY5Yw1rEaQcecB9QNLLUN7cBeFIsmHuyUhxnvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8897
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Paul,

I have a question related to liburcu per-cpu call-rcu worker threads.

So far in the current liburcu releases no affinity is set when the
worker threads are started. We have to wait for 
SET_AFFINITY_CHECK_PERIOD_MASK grace periods before the affinity is set
(it takes about 2.5s in my benchmarks).

This means that short-lived test programs will get poor CPU affinity
for call-rcu worker threads at the beginning of their lifetime. So for
short lived programs, this means poor performance.

OTOH, if we have short-lived applications on a large machine, setting
the affinity immediately when the worker thread is starting means
we use CPU time on CPUs which may never be actually used by the
application (no call-rcu activity), which can be detrimental to other
use-cases as well.

So I was wondering: is the choice of skipping setting the affinity
on call-rcu worker thread startup done on purpose ? And if so,
should we perhaps consider setting the affinity as soon as the
worker thread is woken up for the first time rather than after
SET_AFFINITY_CHECK_PERIOD_MASK grace periods ?

Note that there is a commit in liburcu changing this behavior right
now, but it's not part of any release yet. I want to figure out the
wanted behavior before releasing this change:

commit 28f282af1905a1cf50ff9b5835b4cd9de4416ddf
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Wed Jul 1 12:49:43 2026 -0400

     call_rcu: pin per-CPU worker at thread startup

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

