Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2153E7718C
	for <lttng-dev@archiver.kernel.org>; Fri, 20 Dec 2024 17:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1734715525;
	bh=XVPUnnSEHqea+huMcLm48zdqxomhKil+7K0YwvjnrE0=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=HsCr8RSd3+10e5GOfPeqqI9X5Z8Z6VJfbFbUMeopoDZdKFjXNgaks5n4IZzGny2jw
	 I0twPqNWJZxMAIbmEbPKA40MImBZyz2KSwHqrHB5IzemfsG92+kYm4DKI1+IbdCoip
	 u/+xU1YYLYPU2Gwq6TsS9fXIeneYWJO+SshFNGCoK84JRwIF3SpfgIQNXrF2cTETj3
	 Qh4XJPP3EZaKqUxcOnHfX/6VWIYRJq5ml8x8jmBSFtMz9qq4xgwNDzFPVgCiX1xLdG
	 op4WQjqfrE2QrPcIO0/XeCrxhKE9xi+3L+rnIo0pOcG8RykopaBBNSSbVCKX/jt/wv
	 UBw7TKSnG498Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4YFDnw2Ywbz1lqK;
	Fri, 20 Dec 2024 12:25:24 -0500 (EST)
Received: from YT3PR01CU008.outbound.protection.outlook.com
 (mail-canadacentralazon11020073.outbound.protection.outlook.com
 [52.101.189.73])
 by lists.lttng.org (Postfix) with ESMTPS id 4YFDnt5s42z1lKt
 for <lttng-dev@lists.lttng.org>; Fri, 20 Dec 2024 12:25:22 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifa8TZFlsLmZSCR8CRwHlhdw7/MwPHllg90t8Jz+AT0sSX1r3sSoidVAr+NoxtPLuBQcDvR5fnmObvcg670LvGt6/vq3Ws6wuefEiFPSJjYbv8/o4YaB3D4Qcgur1PQHZOGnBSSekbCHoOymflBMvM8Pfn5P/AY+HtYRiVXdns1nx8HoUUv5h2jJ3L/B9OmhKf+9OTFbkcHIE1SQCfbpHa79woXNDRsMvhXHv/Xj4vpNgWnPmr4RtuYgv0vDkerOm2MUZDcPgsy+2OuQWjdc+HL9EBO7/EnBheS5Ucc1ysPRdKQ5F7s0/cwrbBzcSA8I7sSW2DeWX+CUoCt6g8taQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyC0yGXyS/h0f+Efn4QtyZUZaHTzvAcOlJitrVm4Cdk=;
 b=Mj60WmnZ6jXt/erJqUGSMjx2VURRBcTRF0Ft5+LPbhLLhgkRluwy4DMvqz/z77Oz6CA/plt6X0KkP3Z4dF5tYxeyTjN/xhOYz1H++rJfoH4WjZ/jYG6hnTkfijKWBkbDcBTAwoW8+39Br5aSAzYdrLmM7nRAnRwbjCSw7lIhqrQaRxHJOBzBcu2ahQiI7brLA4xbWBwXYa3AlLP9WZmN8WF8UIUP7v8WTWJ/i8wBf7LwIVkqSaKYstmgEg1RuY+BBHd3cmvTP8Cy83JmRGo2NdZ8YsKYydo9Oq+UUcnCoBo6mtyOtD0Vl4G1MZYPGBJzIi1VTKf6M5Itie5Os5fscw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PR01MB8379.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.17; Fri, 20 Dec
 2024 17:25:21 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 17:25:21 +0000
Message-ID: <51160e24-389a-41b6-871b-ba522d427220@efficios.com>
Date: Fri, 20 Dec 2024 12:25:17 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org
Cc: =?UTF-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@isc.org>,
 paulmck <paulmck@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Olivier Dion <odion@efficios.com>,
 Brad Smith <brad@comstyle.com>, lwn@lwn.net
Subject: [RELEASE] Userspace RCU 0.15.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: QB1P288CA0013.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::26) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PR01MB8379:EE_
X-MS-Office365-Filtering-Correlation-Id: 9963174c-f399-49e3-c61e-08dd211b47c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTNzVTh5bUJoQkU1ZXl4VzM1QXRIZXJsVURsVjB1S1dBRExqeUtoUER0Slcz?=
 =?utf-8?B?WkdOV0RCSTZ0a3ZpSy9WNHhrS0dIaVBkbUE5d3pNTStoanZjMlJYRnJZM1Rj?=
 =?utf-8?B?QXVjTGxOMVZWYmdmYS9qMHYycXQxM2VQZHJsdU83YTNsOFl4VVNNajVoVGNN?=
 =?utf-8?B?bFAxVWRIbzBvdEVsZEZmdmF2Q25TckdjeS9ESUtLdzVzZ2hsYlFiS3dhNDJT?=
 =?utf-8?B?bllhNDFyV2JxYWF3bE1SQk1sOHc3cUxNMG5MdjAyQnpJMTN6UHFFWUV5aFBB?=
 =?utf-8?B?N3RuQ0U4UGFyT0M2VWluNVlxcllDWEZwOWlVaEt1cXZLTlFJQ2l3eHRLRU41?=
 =?utf-8?B?ei85U0NnZjR1NGlpNjRkcmtmU3UvVXhsRjl5cW0rSkNZb2pwSG9RZG5YSjZ4?=
 =?utf-8?B?c0QyVW9MbjdmdXdsSW9ZRU5yRG50SWNvcFkrcWZ4dzcyOVdSamhFcHBvenQv?=
 =?utf-8?B?bE0wRmIwWUVWQ0V1K2hGa1pHQkU4OXF0cnd5bmxwc3Z2RE1TNVIxREpOb3BN?=
 =?utf-8?B?Wk5KaXkyNk1CbFJQU0lHeDF6d3QxTmg4TnZOSkJTajJSZ2RRZ2xLMzRJa2Rp?=
 =?utf-8?B?MDM0RERZRFRZY2VQcHZjekdjZHlxU09IczZJWWhrSWF1bUc3eDRFbEQxS1gz?=
 =?utf-8?B?UW85WkhvMFZpSnBGYW1rZVg0RmxnU29CQ29XQXdsb0ZLK0tDV1AyazhxbVFX?=
 =?utf-8?B?Q3VxWlhmQTljMjdWeDlzeCt0eFJjdFEvdGwyOXBRbzU3ak8xZ3VBbU9wenhS?=
 =?utf-8?B?RzBvbncyYWtyaFd6a0E5RFFIOGtyZ250c1B6VDRmdS9JdlJBSVNyQ1YyRjFP?=
 =?utf-8?B?TzRLNk9SYlBhQ1JObXJ5QllTa0h6aWdZNjRsaUhRdnV5VEZZUld4bzM0ckdm?=
 =?utf-8?B?ZmlVd29VMEw0NnM0K1JpY1BLQ0doMDNlLzZNUy9lUWVLdVR5VS9KNkZqeFdH?=
 =?utf-8?B?clhZdllQdDIrSnUrWnFIWFhkYzQxNkdESjR3VE5LOU1xM3lzN21XMVQyL3Rj?=
 =?utf-8?B?S3ZJdDBqWmprYko1QUcrdm9FbkQ4T3B4UEZtVmhTcXNZMERoVlEzZlVYbW0r?=
 =?utf-8?B?bVFjUWU4elBuQmNWSjJkNVI1OXl3b2FGVWJJSVhwTUhnWmhoYW92dkFoY0t2?=
 =?utf-8?B?c1lDdThLc1V3TTJVMHorODNpZEtuR25aRFg2aE1JaHZsZ3QwSHptTkxHelZB?=
 =?utf-8?B?bUdobVk5cG5oWFE4WHFqVzUyQitwUXY2MWp1a2JieHlsTG8waXcyODQwYjhE?=
 =?utf-8?B?a3FLbnZUWTVHMGcrU3c5eXVwdjJwekxYR1Z6ZG5EWit5Vlg4b2ozSzFReTJX?=
 =?utf-8?B?T012RW85WWpmc1pWVVNsbExaSGZNR292OHF5aXNZdktVZlAwY3NZdUNUYThj?=
 =?utf-8?B?NS9DWkJQamtlTW9QSUxFcXJ6KzRJcDJvSS9pSXdFc2VlNUtPcWhwd0tSRmdB?=
 =?utf-8?B?YzhabjNrdUpPS3IrMFh4Um1tS2dHcFVVb2VMd1JKbFJpRldmdklML0hBQVlq?=
 =?utf-8?B?K3ptRG5qVldTcFBBMkE2VGltTG0rTzl2RmEwbUFXSUUzU0Zva2JPM0hSYUU3?=
 =?utf-8?B?OTZLZEl0aFpxdlNMaDNBa3VBY3FKb2NpMlJYckQwL0MwZFl1N2N3eWlCc0RG?=
 =?utf-8?B?RE5ueWJkVDVPanh0N1lMbWhEUmhOc0t6bEtkUFRqTHQvR1JNWUJ5VDI1YkFN?=
 =?utf-8?B?OEdIZ3RVQnZjeXNrMzIxcTVSdnlnVjUwSjd4WGZ4WExhNmIvMC9sVUtkdEg1?=
 =?utf-8?B?VlFHMFlBM2tXYWpnVEFFcjRwTVZjWDA0S3pzaEp0Tm9JS0FZWUNPLzVuQlFJ?=
 =?utf-8?B?S2JXRFlaR3pTQmZPNnhYZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGtPSys5bUxydjZhdU5EaWxFaUJoWnM5TnY0dUd5TTJkWjA5SWlrWVVEaGlq?=
 =?utf-8?B?YXdUS1NGZ3dDWjJRTVowd0l5Z0FGQno1RVA0ZTI1d2M5bzltNkVySXdMVDdL?=
 =?utf-8?B?bVVzUHpyL1pSMXpFb3MzQ2M0anNmTndZcVFHcklOV043NExrM3l6NDIxYTAy?=
 =?utf-8?B?M1ZzWUsxeVY4UWtRVkZLUi92U3ZqcW14RXQyUVhwMzNCeFV4b3VwZkVtQXdt?=
 =?utf-8?B?b1BNNSs1OGdJVytaMUd2cFF6UnFRK050QVBVaWhkQnhwMm1wR3lpRnBVVHlH?=
 =?utf-8?B?c09xVXZGQ2RFbjNTSEVxT0M2OEt3SkNTYTltb1ZqSmdDMDhUWEk3SU9VT1l6?=
 =?utf-8?B?OElvUXZUTjc3YWVnNUZ5bkpESDJvZ1IxcGpuOUVaeC9wVW5BZzhrM0NmUGhj?=
 =?utf-8?B?THVFcThBUFViUVFvQ2tPVWphTitvRG1jUXpIYmZtdGxaMXdSRVdNVC9tY3FC?=
 =?utf-8?B?UEVDVFpuQnpTc2w2WVd1R2EydFU0RGx0NGdtWVBuWFpZYWxSNFZBQzVoWmRx?=
 =?utf-8?B?ZGVSSzdFeGtqeUlveTFLK0piM2I3YTFqNnpLeFNPSi9qbDM0aW4xU2tKbUQw?=
 =?utf-8?B?aGQ4UktXR0lhZGZTRkUyT0E5YUgvSlBlQzJ2MWRHVnByd2ExUXhOaU9QZDJa?=
 =?utf-8?B?bzNGODNCMjh1NWhMSDZTWldLMEZCT1pndWxLeHV2aHZwQnRsaFJIQ2hYMTcx?=
 =?utf-8?B?Z2xNRTJIOTVqNUYrNU1yc0N4RjZ0bXVheUh5L3FCN3JLYWRwcUVVWnd0Vzhz?=
 =?utf-8?B?TmpOL2tVcW8xdmFaNk9Nb3JpMit2NVZnOVlxYjl0b1I4djRNTnVMTlNDZktF?=
 =?utf-8?B?WGRMUEI1cjlzQnBOR2F6SnhVNEJvY0FPeHNydDJ2bTg0ZjZiU3dBZGc1L3N2?=
 =?utf-8?B?OGNlK2gwL21ybFV6Vi9Qalpkb0ZyZ1FpUnVxS0RrQ050U1FNblg0M0ZvbTFW?=
 =?utf-8?B?eUg2Tnloc1JRRGhMcFgzbW9VV2dGMzg1VUZSU1Z5VVRtRXdlVlBZYU1PL2Ny?=
 =?utf-8?B?aXEzWDBCZFZtTXZjTFdWclY2cUhIRzNTRzZudGczblpkc3FHR1lKNy9MSEJ0?=
 =?utf-8?B?VGVpSVIzeGpLU2dFd1J2N0ZCcnJBRGJ1MWFOaTJHTkNQNjU1L2FjZDZwUFY5?=
 =?utf-8?B?cmxlVnE2NlJ4K1VPMkUwcTBBOEVEWkdsQmg0WERpRjNVWXF2RkFsUFZ5ZTJh?=
 =?utf-8?B?eVZ0Y001ekZsRVFRaHo4TmNiSUxLQzU4bnZGT2xQdDloNUI1ZUVXQU5JVERk?=
 =?utf-8?B?ZnpFSEUyVElDOXIyNEZEeDMzUm0zaHhtOG1PWmRKeXh2QmJENEVmMTZReWFy?=
 =?utf-8?B?a2t3bTR6b1pQNDM5NkpUUWxGalhYNi9jdFMwSUFtaGZwZmFYKzVSa29iMFNa?=
 =?utf-8?B?QWtncnIvbHZDeEVQWGN3M05DeTQ0WFMrcTNIRlZ0bVI3TmJ2d0hQQWdOblU1?=
 =?utf-8?B?bFZXTTVQTXpPTm9JZkJtUk53bDZsbSsrdHFIRWpQM3dLV1lGT2VXUk5aQjBU?=
 =?utf-8?B?aHBpVE5pdnFyZ1RjS0t5SDJzSThIUGgranU3dDVhVzlxQVE3Y1VGQUZ3aDNp?=
 =?utf-8?B?bXEzRitHaDJ4Vk0xVUpVK1M1OUdQQWk5QU9QT3NWZ0x4cWdlTVRJTVF3dnhX?=
 =?utf-8?B?ZTJLMUtMc3ZaQnJmTkJhN0pHN3cycm5uNDBkM0tJNzNqdzlCUG9vcmxVR3JX?=
 =?utf-8?B?c1FtQWRxL3lNbVUzMUszSGdLeVg0enJ3UUNlQ21CUDR4Y1NSbE91cFZkN2VV?=
 =?utf-8?B?N3M2UUgxZW44bTVBb3cvd3drNVYrbncxMWcyTGtjYUtMTk85dktHVzRiUGFn?=
 =?utf-8?B?OU5Zd0g5ZGN0Mml4MzVBVXJrR2FLSTNzNFdEc1p1alBaQmZnZFEwSWN3THpz?=
 =?utf-8?B?VW5vVVZrUm9LWGpTSEt1SE9qMHlhb2RMSWljYXdsMWZINjR6ODJWUHBsQmJJ?=
 =?utf-8?B?U2xCdlNJWDl6UkZWY0s4eE4zQThiSkMvdFN6SHZadk1IdGJPbzRJTEpmU1Fr?=
 =?utf-8?B?cVRPYktwaGd6WDllcmFWVHNZVTM0V3llVTJzY1JDTFdQWDhodnArSXBtNjcv?=
 =?utf-8?B?MGFVN3BCYnJCaFIrUnZ1RkUwOXdhMkxpWGcxWHliUVluSmtWc25MTkc0cHND?=
 =?utf-8?B?Q3E5Yms3eFB0VUtwOTQ5M1NUanN1Z1pwRVMxY0JoSmVpcCtkTlhFNzJnSFFH?=
 =?utf-8?Q?VuWRPMqOyD/GX3LyxraC9/0=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9963174c-f399-49e3-c61e-08dd211b47c2
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 17:25:20.9468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: csd/mzySLYh0N0WxsjNC8MixVQDcSY/0u0EDy5XKL6kaMBRbiJPen8ibT8EWZ9j1pL8+Uc9j9Boq3LvHm+ki3oLgvpBkovoYIzHjajPfaN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8379
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

Hi,

This is a release announcement for the Userspace RCU library version
0.15.0. It has been nearly two years since the 0.14.0 release, so
it is now time to get this out of the door.

The Userspace RCU library implements RCU, atomics, and lock-free
data structures in userspace.

* New in this release:

   * Support for compiler builtins and ThreadSanitizer

The main change that was introduced in this release is the
introduction of the support for the C11 memory model based on the
compiler atomic builtins, and adaptation of all algorithms within
liburcu and liburcu-cds to express them in terms of atomics with
release-acquire semantics, thus allowing ThreadSanitizer to understand
the ordering guarantees provided by liburcu.

Using ThreadSanitizer requires using the the compiler atomic builtins, which needs to be enabled explicitly when building liburcu with the
following configure feature:

    --enable-compiler-atomic-builtins

This is disabled by default. The default is to keep using the inline
assembler implementation for the uatomic API.

This work was sponsored by ISC. It came up as a requirement because
BIND9 [1] now depends on liburcu, and use ThreadSanitizer in their
testing.

   * Introduction of the CMM memory model with the following new primitives:
     
       - uatomic_load(addr, memory_order)
     
       - uatomic_store(addr, value, memory_order)
       - uatomic_and_mo(addr, mask, memory_order)
       - uatomic_or_mo(addr, mask, memory_order)
       - uatomic_add_mo(addr, value, memory_order)
       - uatomic_sub_mo(addr, value, memory_order)
       - uatomic_inc_mo(addr, memory_order)
       - uatomic_dec_mo(addr, memory_order)
     
       - uatomic_add_return_mo(addr, value, memory_order)
       - uatomic_sub_return_mo(addr, value, memory_order)
     
       - uatomic_xchg_mo(addr, value, memory_order)
     
       - uatomic_cmpxchg_mo(addr, old, new,
                            memory_order_success,
                            memory_order_failure)

The uatomic API was extended to support explicit memory ordering.
For instance, the previous uatomic_cmpxchg() now has a
uatomic_cmpxchg_mo() counterpart, which takes a memory ordering
argument.

   * Introduction of --disable-legacy-mb configure feature

Some public APIs stipulate implicit memory barriers on operations. These
were coherent with the memory model used at that time. However, with the
migration to a memory model closer to the C11 memory model, these memory
barriers are not strictly emitted by the atomic operations in the new
memory model.

Therefore, introduce the `--disable-legacy-mb' configuration
option. By default, liburcu is configured to emit these legacy memory
barriers, thus keeping backward compatibility at the expense of slower
performances. However, users can opt-out by disabling the legacy memory
barriers.

   * Introduction of CCM annotation experimental API

The CMM annotation is highly experimental and not meant to be used by
user for now, even though it is exposed in the public API since some
parts of the liburcu public API require those annotations for
ThreadSanitizer support.

The main primitive is the cmm_annotate_t which denotes a group of memory
operations associated with a memory barrier. A group follows a state
machine, starting from the `CMM_ANNOTATE_VOID' state. The following are
the only valid transitions:

   CMM_ANNOTATE_VOID -> CMM_ANNOTATE_MB (acquire & release MB)
   CMM_ANNOTATE_VOID -> CMM_ANNOTATE_LOAD (acquire memory)
   CMM_ANNOTATE_LOAD -> CMM_ANNOTATE_MB (acquire MB)

The macro `cmm_annotate_define(name)' can be used to create an
annotation object on the stack. The rest of the `cmm_annotate_*' macros
can be used to change the state of the group after validating that the
transition is allowed. Some of these macros also inject TSAN annotations
to help it understand the flow of events in the program since it does
not currently support thread fence.

   * Introduction of cmm_ptr_eq()

When users define `URCU_DEREFERENCE_USE_VOLATILE', `rcu_dereference()'
is implemented using `CMM_ACCESS_ONCE()', even when compiled with atomic
builtins or if the compiler support the C11 memory model.

This allows optimization on weakly-ordered architectures where the
`CMM_CONSUME' memory order is implemented as `CMM_ACQUIRE'.

To prevent the compiler from doing certain optimizations on pointers
equivalence, introduce the `cmm_ptr_eq()' API for pointer comparisons.

   * Deprecation of liburcu-signal

Users can migrate to liburcu-memb with a kernel implementing the
membarrier(2) system call to have similar read-side performance without
requiring use of a reserved signal, and with improved grace period
performance.

   * OpenBSD Support

OpenBSD support was contributed by Brad Smith from Comstyle.

   * Loongarch Support

Loongarch support was contributed by Wang Jing from Loongson.

   * RISCV Compiler Support

Build on RISCV is allowed on clang and gcc >= 13.3, which unlike
older gcc are should have a working atomics implementation.

   * The GCC baseline is moved to 4.8.

Because anyone using a gcc older than 4.8 should really think
about upgrading now.

   * Move to the SPDX identifiers

We introduce the SPDX identifiers in the project to simplify
tracing licenses.

Thanks,

Mathieu

Project website: https://liburcu.org
Git repository: git://git.liburcu.org/urcu.git

[1] https://www.isc.org/bind/

* Detailed Changelog:

2024-12-20 Userspace RCU 0.15.0
         * Fix compilation errors
         * Document cmm_cast_volatile
         * Honor URCU_DEREFERENCE_USE_VOLATILE
         * arm: Use atomic builtins for xchg if supported
         * Introduce _CMM_TOOLCHAIN_SUPPORT_C11_MM
         * Seperate uatomic and uatomic_mo
         * uatomic: Fix header guard comment
         * Fix: missing typename in URCU_FORCE_CAST
         * Allow building with GCC >= 13.3 on RISC-V
         * pointer.h: Fix the rcu_cmpxchg_pointer documentation
         * rculfhash: make cds_lfht_iter_get_node argument const
         * lfstack: make cds_lfs_empty argument const
         * wfcqueue: make cds_wfcq_empty arguments const
         * wfstack: make cds_wfs_empty argument const
         * cds_list: make cds_list_replace @old argument const
         * cds_list: make cds_list_empty const
         * Adjust shell script to allow Bash in other locations
         * futex.h: Indent preprocessor directives
         * futex.h: Use urcu_posix_assert to validate unused values
         * Use futex on OpenBSD
         * fix: handle EINTR correctly in get_cpu_mask_from_sysfs
         * Relicense src/compat-smp.h to MIT
         * uatomic/x86: Remove redundant memory barriers
         * cleanup: move rand_r compat code to tests
         * ppc: Document cache line size choice
         * Fix: change order of _cds_lfht_new_with_alloc parameters
         * Add support for custom memory allocators for rculfhash
         * ppc.h: use mftb on ppc
         * rcutorture: Check histogram of ages
         * docs: Add links to project resources
         * Fix: allow clang to build liburcu on RISC-V
         * Fix -Walloc-size
         * cleanup: use an enum for the error states of nr_cpus_mask
         * fix: add missing SPDX licensing tags
         * urcu/uatomic/riscv: Mark RISC-V as broken
         * Fix: urcu-bp: misaligned reader accesses
         * rculfhash: Only pass integral types to atomic builtins
         * LoongArch: Document that byte and short atomics are implemented with LL/SC
         * Add LoongArch support
         * Tests: Add test for byte/short atomics on addresses which are not word-aligned
         * Complete removal of urcu-signal flavor
         * doc/examples: Remove urcu-signal example
         * tests/common: Remove urcu-signal common test files
         * tests/benchmark: Remove urcu-signal benchmark tests
         * tests/regression: Remove urcu-signal regression tests
         * tests/unit: Remove urcu-signal unit tests
         * Fix: Add missing cmm_smp_mb() in deprecated urcu-signal
         * urcu/uatomic.h: Improve verbosity of static assert error messages
         * urcu/compiler: Add urcu_static_assert
         * Phase 1 of deprecating liburcu-signal
         * uatomic/generic: Fix redundant declaration warning
         * tests: Add tests for checking race conditions
         * Add cmm_emit_legacy_smp_mb()
         * urcu/annotate: Add CMM annotation
         * tests/unit/test_build: Quiet unused return value
         * benchmark: Use uatomic for accessing global states
         * tests: Use uatomic for accessing global states
         * urcu-wait: Fix wait state load/store
         * Add CMM memory model
         * urcu/arch/generic: Use atomic builtins if configured
         * urcu/compiler: Use atomic builtins if configured
         * configure: Add --enable-compiler-atomic-builtins option
         * Fix: tests/rcutorture: Put thread offline on busy-wait
         * tests/regression/rcutorture: Use urcu-wait
         * tests/rcutorture: Factor out thread registration
         * tests/regression/rcutorture: Add wait state
         * urcu-wait: Initialize node in URCU_WAIT_NODE_INIT
         * Complete REUSE support
         * extras/abi: license data files under CC-1.0
         * examples: use SPDX identifiers
         * tests: use SPDX identifiers
         * src: use SPDX identifiers
         * Public headers: use SPDX identifiers
         * Build system: use SPDX identifiers
         * Fix: urcu-wait: add missing futex.h include
         * doc: update GCC baseline to 4.8
         * doc: update FreeBSD tested version
         * doc: Remove Solaris from tested platforms
         * Revert "compiler.h: Introduce caa_unqual_scalar_typeof"
         * rculfhash: Use caa_container_of_check_null in cds_lfht_entry
         * compiler.h: Introduce caa_container_of_check_null
         * compiler.h: Introduce caa_unqual_scalar_typeof
         * Avoid calling caa_container_of on NULL pointer in cds_lfht macros
         * Fix: revise urcu_read_lock_update() comment
         * Fix: uatomic powerpc comment about lwsync
         * fix: aarch64: allow RHEL7 gcc 4.8.5-11
         * aarch64: Implement caa_cpu_relax as yield instruction
         * fix: warning 'noreturn' function does return on ppc
         * Fix: use __noreturn__ for C11-compatibility
         * Adjust shell scripts to allow Bash in other locations
         * Add support for OpenBSD
         * Bump version to 0.15.0-pre

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
