Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759B0D73E80
	for <lttng-dev@archiver.kernel.org>; Thu, 29 Jan 2026 19:15:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4f283t6Q0tz2KLK
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1769714124;
	b=P5RCEa4+Hxh7s7DuxvUN8pE8JvUScTFfijVMBgMgVpdJOCxrVwd4RR5Wyd9Rk3mcHWQf
	 NuZquUYpXhVFh1mtPu3Cx+lwOpmemGUqixCVCxOqb940EN48yhEedofFUx3ZpMjPj4r2v
	 RF8iq4/vWMO8nHbdvW0J7RmPXr4pW1i5cq2/YmLN0voLjfcQSmq9f9mu2btxb5Xr2/3dm
	 NQ15Yj6N2WxJ6xNU5bilvdjcI4t23NJJ68/log2yZz7VlSdRvbExzwNDSGHfe4PEqw3Lq
	 6nhZOMp/qAHKh0PvUvR56jz8J6hJpqJUX/G4fo+i4DdcPnQDO4Og1ypYmS+sEkglkAQ==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1769714124;
	h=DKIM-Signature:Date:To:Subject:Message-ID:MIME-Version:From:From;
	bh=cJPnJHREcA7AY134ABLezhGkm3oWVGJylXhQhv/qaQ4=;
	b=Buyfw/98Cq9iba7xPiMqfCmPg56gTS5LPGC/WnzAwsw/HjCx1jAFdOfSbQPtIbj4UhJM
	 QBc3HodPy2pYQlejiUB130t6VUyd3Dfg6CDz0YVekG373PX84pEj9zBJiyzrg9iv+gTvB
	 u9oyITYuhrl2G0OwkxRhCyVd5rKVbRggvwCdh+RUzm6FFxeQt2zEw2MXeb2iytEBQgukh
	 Lqf0FupBfuaMoTvkog1EL4sWmNNsm/tgguf56xB5bpPNW1qLOIYk638dRWDYSwx9Wcew1
	 ZvUmIZD6AZ/NNqD7VulGLjUBXx2X/arWSLg2XuRKMqkMZmQc+Vu6FeOqgCwOou7xJnw==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4f283t6Q0tz2KLK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1769714124;
	bh=6Toj5I/YryJYnDjhk+Hgh47MzKK23OgpmcbUM6liBbM=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=YDsC/LGfD5FW1F8hv/+QbL/yMQaV4SjaWGj3lKdlPf5lJXWHk1/TR6cGPHAm+AeBv
	 3JXObkXOYGfyYHtHgwztpmK4eQ4cH5hUXQncCRtRLx+usLS6Lv0dhILonzKgR/B4qj
	 1EjUGO0rDORjhyx8NOtYlUCnOg5BcPkg/t562iAbKrCl4hPzLO3yxSJ9CtkaiCt5Z5
	 FxLwPWQqXWgI3GhAGkOgURYa3/FAGE3D1A1e5yi1sR1kW/rwNUlNxP80nqjLCFM0QY
	 J4eBYhf7Q01tfCNynYGu1Mr6K7JiDKCh3AVtRVFr2r1Uvp9xtHYjy5mF9jJo7/BCMG
	 Ut6o8w/7BwAuA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4f283t6Q0tz2KLK;
	Thu, 29 Jan 2026 14:15:22 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4f283r3Fyqz2KBf
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4f283r3Fyqz2KBf
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazon11020118.outbound.protection.outlook.com
 [52.101.191.118])
 by lists.lttng.org (Postfix) with ESMTPS id 4f283r3Fyqz2KBf
 for <lttng-dev@lists.lttng.org>; Thu, 29 Jan 2026 14:15:20 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HqP0iDcF1ymVMB2DWqibwPdmCMdE088j4ybMPs/faxr8+ypquNv6h+ZNhmmIzmDSyweE9xXqJ7VCmjLdx8fxzfKKERKbyZTZTs6HhIF9W1ZmXttny0/cthnQxo2pltltegtsY4pxcpOCVXKbQh4Ay4g/Tct6L9lYcwt1nhq612Q8d51NOG2Ad09aGX2MinrzkXLFALjKudbE2Exnr5asEs4Hm4gFka1HXBklDTfk7ki4iPrxe1CEOgggtCiRPCMUgRPbJ7JeLziml5XZHEghybRJBcTcZerfZ0xWxthSGi3AmxzRrm3X3VO1jTFPmCVmn3PeQzoSAJ4XA/8EpVhU2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Toj5I/YryJYnDjhk+Hgh47MzKK23OgpmcbUM6liBbM=;
 b=X3Z26EgHE7Qr6Gucn/wWmgAPh57bSBy2rmO9AhzfXc31zFx1UGwm37qwyChiB304Nuk6MSGQfj3rZnF560Saw8HY8KTvLAKoK8s/2v2e2Sv5M11Py11bsVq9q4Os3M5+arxiTCN0CVjJl1wLp3AYH8wQ0rEhKoRd6BUOk4HBctQA9NNt7ydWdocZb7fuuWEitSrhyrw9szQufdX140gy9KuqySQWTrTNMfVFsw7Ni5MykOOmTjJG+1oW4v3vFsTFzGlkJ28g9H+3pokhb29HiVBE5uF1osAbeI/WoN1DlqvW+Cz1DlxMLhwzaRnnjv2wA50NwPnHJWLr9nsKfhXFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:104::10) by YT3PR01MB11260.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:13e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 19:15:16 +0000
Received: from YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::779c:32de:cda1:4535]) by YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::779c:32de:cda1:4535%6]) with mapi id 15.20.9564.010; Thu, 29 Jan 2026
 19:15:15 +0000
Date: Thu, 29 Jan 2026 14:15:14 -0500
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org
Subject: [RELEASE] LTTng-tools 2.14.1 - Orbitales
Message-ID: <aXuxwtZng-WHCIY9@efficios.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: YQBPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::31) To YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:104::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10709:EE_|YT3PR01MB11260:EE_
X-MS-Office365-Filtering-Correlation-Id: 6424c001-e062-411c-988d-08de5f6abbcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7142099003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MR2OB2dctJu4VfAfDkIbLPpmmYrFFhjGXI2QTwDn081urylLK0OpyexO0d9r?=
 =?us-ascii?Q?9dTS/7AM9BI08Mto8mg26vYkZcqdWUBDv1jvZAIy2TTdd6bUzwoRjKoMn3R+?=
 =?us-ascii?Q?toudxzpLXtZ9/BK3KatPXhGgF2hTniqN6T+M94r4QJWQ7iKcujmfSSuriMbE?=
 =?us-ascii?Q?MDN3qcFaBNYPRkJ6h5drzURn91zeGo/h5z/g8891ZcKdIm662YvXY0Y5aUW4?=
 =?us-ascii?Q?19jD9PA3zZW/ilpq8ifrO4xoeVr7SCcJgi8Vyrasjbz45+bag87DPWzzqyts?=
 =?us-ascii?Q?pGYdPMBEAd6cgxPXCVURXmuWnIV00RJMVBRmiR4Wu8YMRck2YdEHArwTEQYo?=
 =?us-ascii?Q?tHwqvFakZ9C1UCr0GdzjncAqN8giQHmiIBpiwonpyQbutQ3dRwQBSCyRvUpY?=
 =?us-ascii?Q?RZkAeDatOJFGxNbxV5tksapiC4Rq1Eoo09L61t32eJ1/HNODTR8m6C2JCdF9?=
 =?us-ascii?Q?7xlSkS633ei0irB4HDGERW85LuiXSEYfR8W16O0LXYHxG5tVRfanQe5algVt?=
 =?us-ascii?Q?CssioNiupr73oNBVjB/1wY6galVdhX/9YKDWS0DTuPtJ6oE2ZSjA58huWSUR?=
 =?us-ascii?Q?Z9Od2N6j3/gQTt/D0lsDsQF5zoecucUkkdJpr6MXx8o8OtEucbDGknI4jaDX?=
 =?us-ascii?Q?HHBFZlz2WgmkrN4VskykpCfc7xQ6jOSe0a+rMux6KUDWmEsGA4uJiCr2LF5Z?=
 =?us-ascii?Q?tb3mUydzLb2bttff8rnlRGiPy0jZQs7QZPde78lZyhZO+B5Du9YbyP/XxFPo?=
 =?us-ascii?Q?sMqdZvhSIT6GwbiGJC4h2qQqWdWJ7i69va3NJvL1fJquHkJ6Zf0IRf+7y/my?=
 =?us-ascii?Q?riAbGSKTz3Z2FI5mYf/Mqxez3vDnnUXnsQ3xfV3jN6OyVDc2iSCd8FPpXeny?=
 =?us-ascii?Q?BcCsm728b7RvdtxxykgiwiPNUTBMp714zQGak4w94CCe5nCfnyap/u3Ee6P3?=
 =?us-ascii?Q?LGFJSUmF+xidhf4KglGi+HkN0dqa1mFiR6yY7e3q/++1Jn8QLbyQQXdjN+zp?=
 =?us-ascii?Q?TQ1wmerLkIRtcToVkjCslb7Leu+nMJFPPc5KU04qDbCUz5tFkzQ56l+2N5JI?=
 =?us-ascii?Q?/fi4xzvMhEK/IF0EG1C9RyNdTP5F8X2NQzps6KLhn39TDrqWy5VVRGfdhC0f?=
 =?us-ascii?Q?h3L98GuyGxe4lUAXNdCCBz2eGrV7FKXJXn6LKtqfdNLgRtKSD0HYNzLqoGXG?=
 =?us-ascii?Q?WeWoe+cdGSgo2YYKVY+9Yf9h/JimADpTQ6CpRczMeHzWDV+3p4vMC30JeLeV?=
 =?us-ascii?Q?pZzJz9RiYIVQdRSwZQbEuiHZMMyHXyVxJtw7ij3MHX4dSkZAuGqXpqeCCMBm?=
 =?us-ascii?Q?HZHQPavv9W6nMMW1kkuJnnly4fcezHCXmqEwfw5OsK0tBFYkyTDSrOVDIKem?=
 =?us-ascii?Q?aCYncXViVWJ3tfL7b1cQMt7pSezsY2bCUZpAefQpjeYcRyoP4gsxNY0oam25?=
 =?us-ascii?Q?giGUDK9pYVB07liWnPVrZqRm9PgRdYX/bnSi+5CycdOQFA7ARsUqGckBn0sM?=
 =?us-ascii?Q?gyaAlHbQv1YlHDmh2CirYHoMhsdnceJueRd2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7142099003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XlIx5ExLHJz1ZRaQ912nheqmFZ11sFuxw7bfU1rqcagWHd/XsApFPIkRcV2F?=
 =?us-ascii?Q?9lS8BbN9t0JXdo1hEkZP/h00m6fWlUzT6+AjrJxlDcJLxMxX2xgLLpMU8TGO?=
 =?us-ascii?Q?CUd1g8pf+rIqFl0aibi5gauMm3R22CiEq0Z7i77D9AlGtwHSrhYw1X0NBXi7?=
 =?us-ascii?Q?xAOHZdW4CGGPAr2Vw5ExtUpkdJbUaNaRX3+ROtvm9uo0RN07Sj1Cf/R4oz0t?=
 =?us-ascii?Q?HLiF5Qt/Ct6fTZyZAmWQNOa6+a0RUhOS0TUUc1VcKdNhm0kAjNjI9/zfQrkS?=
 =?us-ascii?Q?EPDE7h538ngx2gf++/VO3X0gFiREmWr3AJNLfWRtmYNSdxlmZTxiBYWHUcOG?=
 =?us-ascii?Q?5nqrYIBhiTnlVNb/WZFkJSuVENd90p2RE6K5F6yYSaF4s15Qgs3PsefnsJIj?=
 =?us-ascii?Q?OyY/SwcBvGb208NOoDqonChonrtpG5aKfUVfNGk6C8H8FVRAi9zzINeZbj0Y?=
 =?us-ascii?Q?S2JEkcb0gMx/G3Oos6KGdz9a36F1Ju4RM2THCuNpkWZmiYIX4/ai0ehxX7SZ?=
 =?us-ascii?Q?oZHupZujiW0k+yH4497gZl6uJYbT0M/+RB1jwMbgMGD/PiFZW+IBf4RIqM3l?=
 =?us-ascii?Q?/EqLAF1iG+q8ZlpYvX3Kr2DAMAbCT6c6Q6VXWJ0N5QCNvDp14doxV4iSeNO0?=
 =?us-ascii?Q?0UsQrsDMvNbB4mkNuu/x41jHEt1XwBgMkPuzQQo6sBdiZmrHguCF13nBmGMu?=
 =?us-ascii?Q?HRoSGu0R8p6l9yDUKw4pjxrHOZxQ/phQSes0yr6qSh0RQDksKyBAhJ50/ayH?=
 =?us-ascii?Q?SLNCaMhz8grk+jPhtsV0bC3mcGUjncqFGSIcF68KDlWd52Xga8VWiFZiAsHQ?=
 =?us-ascii?Q?cedUEuR8egX1+7/k5gS+xkbhzkJrAUJofjB8I+7Zx5GYWuDMB1cycw2UR2u6?=
 =?us-ascii?Q?JaK1UfRP3t6rkXLrOC6Ru3VlhfDdXWvdUG6ttWndXtzgR1CjtY+8l1rWZw6f?=
 =?us-ascii?Q?P7MpbtytkQHP5BcnJb7LaVO8Q792LQ9vPKIcnDQpzcv0bMmr9AblVT5pvJst?=
 =?us-ascii?Q?jdMYi75LpsyK5VNHlwq0jBbmM5c3bfsI8k33qN6h/Ljj0nRbX7N6/qRhGtQP?=
 =?us-ascii?Q?35ni2bJPfbmPpwQK7sM9r5V/3dAjKDfVOjpryDoflVDR2tk6YA08jGPAsMO9?=
 =?us-ascii?Q?ers9ETKdCJ3n2Q9de9MAGxLfmO8siRA+2NBktGq4IwSGy8jiFCvDrSVRGbu4?=
 =?us-ascii?Q?eciqM9ZpL6aI9EkKUib0sGph1RLLps9TT0/kzprsUGwZqwJGAfmPg81iyUg8?=
 =?us-ascii?Q?aTxmq0T5fytb1nJoAKI2LQqJHnUF/AYtgRqCNSTcoKZL/NkYeufqdNNaiumG?=
 =?us-ascii?Q?oTjjnX+41OC1gnbUNt/H6Kx6etRhtTECl5sWgvFNNExktmQZzQ3sr7iEXA9w?=
 =?us-ascii?Q?O2PVVd+Lcb0jirFvIds+xP4SWukiu2p2pfn6EPKLCJIczGXa/jKI2QcToyHZ?=
 =?us-ascii?Q?FDVgZPLRwL1BpmSxuZUwVAOsS869TEmnsEGaWNbeeuFybHm827dF2xFBwylm?=
 =?us-ascii?Q?SKCIeaLoDogZi+mVzgw8yyLPsLN6p6Qr02psmowySi+gZsQnjxq3mOYeDkm9?=
 =?us-ascii?Q?2xDgs6dbMSLNGdk9p4LIRapzuw4+qEY+OIAaPqDqU5oIJKFbNgxutRoNzKYx?=
 =?us-ascii?Q?gZ5Gk5H/eLmanZ8ZpHtOQSttfAV3xPRZZx02C2H9Lxb7AwgidXgDWcNlf+xp?=
 =?us-ascii?Q?3sszDjmSTaop3MWRDkFr+i8EejV16cjJciQ7HyXWcsojpWRTXlhUvbgwbUhX?=
 =?us-ascii?Q?y/Wt427syQ=3D=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6424c001-e062-411c-988d-08de5f6abbcf
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 19:15:15.8266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zs56CpC/O60ohAqNmp4eIcjY/p/STBzOXjhJDIT8Iu0fxVZ2OwDh6TDrJRupZTJBYgYA1gMiR3o0iIbo1/n2Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB11260
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
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi all,

We have just released a bug-fix release of LTTng-tools 2.14 - Orbitales. This
release addresses a number of issues listed below.

2026-01-28 lttng-tools 2.14.1 (National Lego Day)
	* Fix: sessiond: racy metadata update during re-generation
	* Fix: consumerd: metadata regeneration and rotation race
	* Refactor: consumerd: inline metadata version change handling
	* Refactor: consumerd: track tracer metadata coherency indicator support
	* Refactor: consumerd: rename ust_metadata_pushed to ust_metadata_cache_consumed
	* Refactor: consumerd: add has_network_destination() helper method
	* Fix: sessiond: strncpy truncation warnings in consumer message init
	* Fix: ust-consumerd: format specifier warnings on 32-bit builds
	* Fix: lttng-destroy: use implicit session when none is provided
	* Fix: lttng-ctl: assertion fails when copying an empty (root) action path
	* lttngctl: Update ABI reference with version from v2.14.0
	* lttng-relayd: Fix assert with live viewer and consumerd < 2.11
	* Fix: ust-app: app look-up vs app unregistration synchronization
	* Fix: ust-app: app hash table iteration vs app unregistration synchronization
	* Fix: relayd live: uninitialized viewer_attach_status warning
	* Fix: relayd: live: format specifier warning on 32-bit platforms
	* Fix: relayd: honour live viewer attach "seek" type
	* Fix: test utils: clear sessiond pids array on stop_lttng_sessiond
	* Notification test: wait for delay when awaiting existing file
	* Fix test notification multi app racy ready check
	* Fix: Do not allow "data consumption paused" testpoint to skip blocking pipe reads
	* Fix: lttngctl: Incorrect sessiond path selection for non-root users
	* Fix: relayd: Initialize stream_id when live inactivity beacon is received
	* Fix: trace-ust: fix -Wstringop-truncation warning in channel creation
	* Fix: init_locale_utf8_support(): consider all "UTF-8" variants
	* Fix: relayd: signal parent when daemon is actually ready
	* Fix: relayd-grouping/test_ust: Remove nowait parameter for destroy after rotate
	* Fix: kernel-consumer: prepend kernel TSDL metadata stream with header
	* Fix: container-wrapper: add missing comparison operators for _GLIBCXX_DEBUG
	* Fix: trace-chunk: use WARN_FMT to fix 32-bit time_t format warnings
	* common: Fix closing open file descriptors after forking
	* liblttng-ctl: drop index allocator symbols from version script
	* Fix: Try to only close open fds when run-as forks
	* Fix: get_max_possible_cpu_id: misuse of strtoul endptr parameter
	* input_stream_descriptor: allow partial reads with `read_some`
	* common: move read/write operations to new stream_descriptor classes
	* Fix: sessiond-comm: missing packed attribute on consumerd msg
	* lttng: Fix help output when unknown action is given in add-trigger
	* Fix: sessiond: erroneous enum type used in comparison
	* Fix: lttng-enable-event: problematic union initialization
	* Fix: sessiond: crash while running clear test
	* lttng: Fix `--help` behaviour of `lttng list-triggers`
	* tests: Add regression test for multi-user lttng clear
	* tests: Handle undefined `msg.count` in `count_events_worker`
	* tests: Support passing multiple tracepaths to `parallel_count_events`
	* tests: Move `parallel_count_events` to to lttngtest
	* config: Propagate load error when loading from directory
	* Fix: `user_space_consumer_channel_keys` skips some per-uid channels
	* fix: link error in libpause_(consumer|sessiond).so
	* .gitreview: Set default branch to 'stable-2.14'
	* tests: Rework notification generator in python
	* relayd: Fix typo in debug message
	* Fix: eventfd.cpp: Remove the scope resolution operator
	* Fix: test_config: user home checks $HOME first
	* Tests: gen-ust-events-constructor: set rpath to $libdir
	* Typo fix: constructor tracing test: license header
	* Typo fix: test_high_throughput: GPL-2.1-only -> GPL-2.0-only
	* Typo fix: test_per_application_leaks: copyright header
	* doc/man: filter expressions don't support perf context field types

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.14.1.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.14.1.tar.bz2.asc
