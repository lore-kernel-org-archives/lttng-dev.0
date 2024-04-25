Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29B5C4345F
	for <lttng-dev@archiver.kernel.org>; Thu, 25 Apr 2024 18:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1714068798;
	bh=JRryZf1whNOxbemtYCHJKhZbAUDrrKevMVVlfri2hRk=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=rCyOvLjrc3BxkzIcorBUQ1P/2E5pIl89t3EkoARrFS7fAVFCepuxoFqRcc3t7Asvj
	 fQ+5/Ug70CdQC38s3Nj41ft/+qXHBdio9BhYdATB/h9wh8tJVG6mhA2/5FFAr8v2Dm
	 7trr830m2nyQzvlGkpnNCg9mnaaeS08Z3M4nlGXyR8lagI4WmBQZsxRjCHR7IuNpTF
	 mQnA8JsPp4c8mQ4xgt/ooqo2azAcxWVHdhtdlN4dwZrH81VMtMcg74dK1Rs+kJ7msY
	 EDd66atdX0WlkWbBx+Kq6tg9Kzww4rIAqt4FE7n4a9vsRBV3qbEjeQNib8CwcsaEck
	 /WFHnt22G0WwA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VQP9V21SDz2jFj;
	Thu, 25 Apr 2024 14:13:18 -0400 (EDT)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2101.outbound.protection.outlook.com [40.107.115.101])
 by lists.lttng.org (Postfix) with ESMTPS id 4VQP9T171rz2jly
 for <lttng-dev@lists.lttng.org>; Thu, 25 Apr 2024 14:13:15 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qt4sGzYE45lgUGv9rP2PUwNRMJvvFRS/ARChDWYxz2K4+3v2QEYYAUtYKxMZotsrULZjmSOCEphuUy7Q8e4LrfxxG1N0192ZXxQ9ODxeIRLvd0T2guZMXlIoZC6VvW6NoWkmDuxJB/dyw4qR+e3oOKrWeKa0wC0g+rNkOQUawKu0V2vegrivsHAGHfcw3CZKWispTjNbtnb2Rni/GywxSkg19C2LuhdZtds1g9CjmPv4pEsxkjfEDXE0frxKhM4CWtpGOgJXTTJ3k0OMurzJTV6okhBYMec+0tJk2gJJb8hxNAwTaJITQZiPtVW9FLreHC07wr1RGpMmFuaF2ns4hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAX7Kff5+SGwH79pauCqeLMiChhjR6Cpc2apaSnAUi0=;
 b=ESq6utLvyZKk8yFKiy/nArms/jo88ybbl6yfenWPetbA2CHoQNlfl1OmA9Mi21y3n2pbI0/N8G/Qh6k3JoXebk+I2yuYp9d/pgBhBfSZ/NUoZoLUdFlHfebfZC1Og/ttM9SDDEbnaDH8hFNMrxej4kbCJ5pq8g2qXO3tXenazLxpWmhkA0rZma5nx53cyo5ipYkPOoagq2cwjSGgS7Jzm8gTzATbsITPWsGGiUW1ihdaPwhIoR7W6GDJ1MbH05AoPIi4c1SOj3p3nESUeuM1JhgBIenrFYvFCWkHDE2XngJFsr28o9MXir6lyGv4lAyp28EranmfENQHY8QV1ydISg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT2PR01MB8232.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 18:13:14 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::17ea:ed8e:e437:46ed]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::17ea:ed8e:e437:46ed%5]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 18:13:13 +0000
Message-ID: <9dd22dac-b0ba-4cdd-8c91-9259ecb6fc22@efficios.com>
Date: Thu, 25 Apr 2024 14:13:12 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Aditya Kurdunkar <adityakurdunkar2@gmail.com>, lttng-dev@lists.lttng.org
References: <CAFV=bvmbx3_k=f13R=NTEADbiVdaT0q8Z9cMwixcs76vuBg_Jw@mail.gmail.com>
 <815cab3a-b61b-4f6d-ba85-137fdd7bc313@efficios.com>
In-Reply-To: <815cab3a-b61b-4f6d-ba85-137fdd7bc313@efficios.com>
X-ClientProxiedBy: YQBPR0101CA0247.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::29) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT2PR01MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: 90d098cf-134e-4c83-0143-08dc65535f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1BKai9EdTJRbHNKTWhkVXFxQW85QVMxMTNpVlE1bVVTbTRrRExiTXZZd25o?=
 =?utf-8?B?OUFBeDFUM05wNWJBQjJXMGVwazZqejJDQWFJM3c0S0J0UnNmbE4wZnFsdFRx?=
 =?utf-8?B?QVBHazdPbjJicWJGV3ZNeS9rZzdDVm5MRGVKaStqUVdjVEN5TncwYUZlT25V?=
 =?utf-8?B?S1gzVWdaTlJhMFFyV2xWNTZTejk5SUdQek1sbUYvQklIc1BNREc1d3BBTGov?=
 =?utf-8?B?UGtjYm1UemRLY2lYaEEyN0RTSjRwYm1ySjBYSDZLMzhsTWxYeGFBY29ETERo?=
 =?utf-8?B?bWc5bm0rK3ZKWVhTTGZoaTdvQmw5bExIb3JwUGFYZ0hZeEROdThvWXpxQnNC?=
 =?utf-8?B?bkdldzJISzRuKytGeGNvTGowRkQrbFUxR0hEeERub2xUWWV6SUJYTjdpZlZM?=
 =?utf-8?B?VTBwNEs0NllZSnZ2Z2o0S2hHUUkxZDFKOGR0SVJNZ3J0SlR1NUNwL2RiamNs?=
 =?utf-8?B?b2RkMndISzFGeXFwdW04ZjhmOEp4b1BZY1dtMFlDd0F1WW1tQ0pPbXJJL1oy?=
 =?utf-8?B?SkwzNnJTT1dPY0JQSngxS0hpanJKNGVGVG9OYi96SlZkQUs3S21CR1NQZm93?=
 =?utf-8?B?ZHJ3d2ZRQTZhTXhubGVFSGtjQWlEWnFTbUd1OVRIQ0RGb3VudDZUbVBKNDZk?=
 =?utf-8?B?Y0hvZUhvcWJpdEs1RHppOXlrWnVOTnE4dmt2QVBLRlM3cUVGY1AyTEZPNFRX?=
 =?utf-8?B?RWk4TEtLU3NuWWVibEhTRXhvS0FkaDYzd3kxU2paUW5xbUtOSWhYVW1JU0Y3?=
 =?utf-8?B?R2NyNjRJY0YxQXl6Y2RRNkR5dW1sZ2ZRNFRyZ0Q3YjA1Q0MzZjEzbThNZm5p?=
 =?utf-8?B?Wm95NlF6NCtycnp6cHAxSThuOE8yV0h1MXpoL1I4RTNoQWFzVTh0dERYVVBi?=
 =?utf-8?B?b0pLVjZINUxtdjNmUGNyZmRPaTdFZDJMcXRvVHV3UURqUlJDbnFUaW5xYTgr?=
 =?utf-8?B?SkhTNnBFM201RC9UMHgrb0owTThKMDJDSHFQelhaZUVOM0JyUDNwVXlsQU9h?=
 =?utf-8?B?dU5IMkM2emtFeXk1cDJtUXlaMzRZT1h5aGZPZ3p6bEpzSURCc3NIbzcwTHMr?=
 =?utf-8?B?T0pJbTMzbUh6N3JIampEdkZZSm54TUJWMStIbDNFODJ1WmQxTUIyNzVCeVcy?=
 =?utf-8?B?RGJITUNuOCtSdUlsMmQ1NHZQSVBKT2cvN2pLdzFqVUNJcjVBOFR1WjJFbEVU?=
 =?utf-8?B?blpDeUtZS0pZbjhrblphcHNaRUxwZkRLSHN1NWU5SU5ENnkyUjNmdkNrS3NE?=
 =?utf-8?B?UjhGRnZHeUsvOW8wNmZHTkxUVUlQQkorSkpHbzRSVTMzY2xORTNvdk1rMDZi?=
 =?utf-8?B?ZUxURFZ2ZHNWZGFNdVR3dWowZHd5TWl0anBjT3QwWElXQ2tEeDl1d3ZCcUdH?=
 =?utf-8?B?Z1F1WGFFNVVlU2FWNjQ4SlJyckJnL0ZHaEl0NVgvd2lMTVRyL3kvQTlDaUtu?=
 =?utf-8?B?aFdiZzFUenJDM0lmU0tvdDExSXg2cFJTSENOUGZGdW1md0Z0ZVdmK0RqUzFJ?=
 =?utf-8?B?bGhEbWdYNTdrUlhtdFRZVjJvVlRNV2Vsd1UvZjdPSk5DbHQrWmF3K0JaS09Q?=
 =?utf-8?B?YkxNMWtxYTZSV2c5TDhFYi9TS3JXUnVrWllkSExtaTFuUEhtY2VtcDJrdWc5?=
 =?utf-8?Q?w6N3k/qky5yPaRtuet/puQMjnB5IeDxxZktesr11jGVQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmYrdFd2cHVpNHh2T3BTTzI0ZWdVME1ma1FJUXpibWp5ak4yUVNlU2pTcHlV?=
 =?utf-8?B?RnhoOXVtK0tham1uVmR3c2g4Q0J1RnozT2VyQjVad0FxbzZIMXlLQmZ4YUF2?=
 =?utf-8?B?NHRWSkZMNGQxOGZxd0RLSEgzbHlmdUgrWGxSUEVLWmtKWnVLYXB4QUdENEZu?=
 =?utf-8?B?SXFmbC9JRUdzeks4NVNMbENFTzdpeDhKUGxvQWw5TG5IOG9zTmtZZFl2VU54?=
 =?utf-8?B?eGFMVTcwdWdDQlVFendKdkViYWhoRUM0QUUvb2VsdUZrK25lNUNOdXdXMkZO?=
 =?utf-8?B?Yng5QzkxTlgranBPQ3V1OVM4K2xuWTRWZFMweERvY3NpOTFzeTR2MUw4ZlhX?=
 =?utf-8?B?L1RRSVZuckErdC9PREFjNVF1SVNWTG1XOVNadjk5d0Fha0gyTXJJMk5BRitj?=
 =?utf-8?B?TkR3d1BSd2o2RjlZTFRZWXUrRlFqTEgyRktPK0lFZVFmMFRERnIwTjBtcHpJ?=
 =?utf-8?B?L2tGQ3hhSzVacUV2Nk5ONGdvN21XZ3BVaEkyaU5ER1Vub1E4d2pzMVN2YWg4?=
 =?utf-8?B?cmJObnQrRzcwaVR1WWJhV3NKU0lwY3ZmeWl5N1pBd09kc0hEZC80SnZ4Wm1O?=
 =?utf-8?B?d09vc0FYbC9CZWF1cGFZWFNqMHlFVGRlS2hobXNqZm5jaUlpMU1tUUlmOWlz?=
 =?utf-8?B?cHZZWEZQdllLV0NCSzNaQUd6NmplNmxSbUF5ZjN4bnQ5ell0WE1TYkFMcjhZ?=
 =?utf-8?B?TUtNdEdXNERRbXVpajNMQlJDYjdjN20yRG5lWlFZSUhlSWRpYjlMMHByTjMw?=
 =?utf-8?B?TnVxQjlhK2pMUVB6WVRVdTg5OEFWT3NLSVdtUFg3L2NaaGdtOXk2K20vdmdt?=
 =?utf-8?B?Wkp0MlYwclBuY2JMcXVmTGswY08wQ2htSWVpTzRLZGFWbXk1Y2Fyb2ZjREho?=
 =?utf-8?B?NHBUVEFJeXpSWFR5ZVVJejJnMWRxcTJYamVhQk8raWk1TVlYYU5yZG9LQ2VS?=
 =?utf-8?B?Y2RobEZUYTMvN2E4a1hoSzlXcjMrUWVaVWFvTlVac3puNHZUOXVhUEh0Mkhn?=
 =?utf-8?B?aWJCWWxxQmliL0xMdFNsR3psY2RYcEt0T0t4V211VG1vTU5ienN6Y3NLQkx6?=
 =?utf-8?B?UmQ4cHlWditYUGUvR0xqOXorY05rdGxsUEg1NlVLckZpQi84bTA3akRsUHZm?=
 =?utf-8?B?MllRSHUwWGxqSytnTUJGQmFSTXM5U056ZnJ3Mk9nRFNPd1hLNmNWNCtOeWxw?=
 =?utf-8?B?NGJkTDdQV2VoakgydHdrMFlvNzRVY2Y3aE9IcGFOUkI1emZFcURKUWFob1lq?=
 =?utf-8?B?RFgyTXdMRk01YjlXNDh6NytpRHNjdVlmZUZhaXBUTzk4eTBRcVBXZjdycUVI?=
 =?utf-8?B?OWxIbU50MlhYME16NEF1eGY0YTVJWXg0QjB2VW80bTJHL3NjZ1U2WER0R1ZI?=
 =?utf-8?B?UUswbFgxeEpYRVFWd0FDV2E2SGxHM29sNDZ2WlZwbDg1TWwzMkx2UkZRSTV5?=
 =?utf-8?B?ZjdDclBvU2M3c25DbzQ4NU11c1Zub3haK2VVT3VzMWlrbEUrcllKTmZsTE4r?=
 =?utf-8?B?RkF4Z0RGWFhJaGRobk9mK0R1SUdCM2hPL0hkb081ck9yTTdwM1JVcTNmblVV?=
 =?utf-8?B?VlpZWjl5WGZzak5UZHRzV3JiU2ZBNFRoYVE3M2JuNFNwYkxDTkpCTkRLWGhm?=
 =?utf-8?B?TzBXZHdwNXRaUW1wV3BhT3hUbmYvb2QyY0xVVTVPNTRDOVgrblg4WndxeHlM?=
 =?utf-8?B?WEFjZHBOV3lMM2loZ1FZenpSK1owVEY4clNDNWdocW9yOXh4dFZNcUtxdFZU?=
 =?utf-8?B?QTdsTlpvTklTMDRNM1kreTRTK3BrQU1ySEFPR1lZMVhlN0Q0eWRNSVp6dFFH?=
 =?utf-8?B?YnpBdGtlU2NISmsyUG5ZK3ZSVVdGdW9ldlBVdWNEMUUyRTB1NGNyQStxTGd3?=
 =?utf-8?B?b2ZVQlBaRWlVTVByUDZvOEVMZU9vd3lmUmRTTThCVmg2V05iN3N2Wm9GN3Ry?=
 =?utf-8?B?eUpIaGZlanFBOWpidWhDMXhrNjd2SXNNN0JIU0lyMkJJa2NVaFVwakJLNmU0?=
 =?utf-8?B?TmpHTFN5VlpMa0xuWGROVFJTcnhpVWxtQldUc1JuNlU5YU1uMTM2Q0UvVGh2?=
 =?utf-8?B?WnExVW4zZEVjWTg2amxLZzhWZExGOWZab0xieitpTDZxT2tXT2tZM0prRlVh?=
 =?utf-8?B?amtaVFpvVjVSQjI2ejJKd0E3VVhTdWduZURjcnFrY3A5ZDJpOFV1UGZUZm1w?=
 =?utf-8?B?TEE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d098cf-134e-4c83-0143-08dc65535f68
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 18:13:13.8651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htEmpS/WRIjAGO2nJlQOPhS/6TT9/fzIu9UHrVf9m3+PVsB6mi52s8Tqm80w4M4iKwJWCqSsi1JA74K5LZztzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8232
Subject: Re: [lttng-dev] LTTng UST Benchmarks
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGkgQWRpdHlhLAoKSXQgaGFzIGJlZW4gc3VnZ2VzdGVkIHRvIG1lIHRoYXQgdGhlIGZvbGxvd2lu
ZyBwdWJsaWNhdGlvblsxXSB3b3VsZCBhbHNvIApiZSBvZiBpbnRlcmVzdC4gSXQgZ2l2ZXMgYSBn
b29kIGNvbXBhcmlzb24gb2YgbWljcm8tYmVuY2htYXJraW5nIHRyYWNlcnMuCgpbMV06IGh0dHBz
Oi8vZGwuYWNtLm9yZy9kb2kvMTAuMTE0NS8zMTU4NjQ0Cgp0aGFua3MsCmtpZW5hbgoKT24gNC8y
NS8yNCAxOjUzIFBNLCBLaWVuYW4gU3Rld2FydCB2aWEgbHR0bmctZGV2IHdyb3RlOgo+IEhpIEFk
aXR5YSwKPiAKPiBPbiA0LzI0LzI0IDExOjI1IEFNLCBBZGl0eWEgS3VyZHVua2FyIHZpYSBsdHRu
Zy1kZXYgd3JvdGU6Cj4+IEhlbGxvIGV2ZXJ5b25lLCBJIHdhcyB3b3JraW5nIG9uIGEgdXNlIGNh
c2Ugd2hlcmUgSSBhbSB3b3JraW5nIG9uIAo+PiBlbmFibGluZyBMVFRuZyBvbiBhbiBlbWJlZGRl
ZCBBUk0gZGV2aWNlIHJ1bm5pbmcgdGhlIE9wZW5CTUMgbGludXggCj4+IGRpc3RyaWJ1dGlvbi4g
SSBoYXZlIGVuYWJsZWQgdGhlIGx0dG5nIHlvY3RvIHJlY2lwZSBhbmQgSSBhbSBhYmxlIHRvIAo+
PiB0cmFjZSBteSBjb2RlLiBUaGUgb25lIHRoaW5nIEkgYW0gY29uY2VybmVkIGFib3V0IGlzIHRo
ZcKgcGVyZm9ybWFuY2UgCj4+IG92ZXJoZWFkLiBBbHRob3VnaCB0aGUgZG9jdW1lbnRhdGlvbiBt
ZW50aW9ucyB0aGF0IExUVG5nIGhhcyB0aGUgCj4+IGxvd2VzdCBvdmVyaGVhZCBhbW9uZ3N0IGFs
bCB0aGUgYXZhaWxhYmxlIHNvbHV0aW9ucywgSSBhbSBjb25jZXJuZWQgCj4+IGFib3V0IHRoZSBv
dmVyaGVhZCBvZiB0aGUgTFRUbmcgVVNUIGluIGNvbXBhcmlzb24gdG8gCj4+IG90aGVywqBhdmFp
bGFibGXCoHRyYWNlcnMvcHJvZmlsZXJzLiBJIGhhdmUgdXNlZCB0aGUgYmVuY2htYXJraW5nIHNl
dHVwIAo+PiBmcm9tIGx0dG5nLXVzdC90ZXN0cy9iZW5jaG1hcmsgYXQgbWFzdGVyIMK3IGx0dG5n
L2x0dG5nLXVzdCAKPj4gKGdpdGh1Yi5jb20pIAo+PiA8aHR0cHM6Ly9naXRodWIuY29tL2x0dG5n
L2x0dG5nLXVzdC90cmVlL21hc3Rlci90ZXN0cy9iZW5jaG1hcms+wqB0byAKPj4gYmVuY2htYXJr
IHRoZSBvdmVyaGVhZCBvZiB0aGUgdHJhY2Vwb2ludHMgKG9uIHRoZSBkZXZpY2UpLiBUaGUgCj4+
IGJlbmNobWFyaywgcGxlYXNlIGNvcnJlY3QgbWUgaWYgSSBhbSB3cm9uZywgZ2l2ZXMgdGhlIG92
ZXJoZWFkIG9mIGEgCj4+IHNpbmdsZSB0cmFjZXBvaW50IGluIHlvdXIgY29kZS4KPiAKPiBUaGlz
IHNlZW1zIHRvIGJlIHdoYXQgaXQgZG9lcy4KPiAKPiBBbHRob3VnaCB0aGlzIG1pZ2h0IGJlIGZp
bmUgZm9yIG5vdywgSQo+PiB3YXMganVzdCB3b25kZXJpbmcgaWYgdGhlcmUgYXJlIGFueSBwdWJs
aXNoZWQgYmVuY2htYXJrcyBjb21wYXJpbmcgCj4+IExUVG5nIHdpdGggdGhlIGF2YWlsYWJsZSB0
cmFjaW5nL3Byb2ZpbGluZyBzb2x1dGlvbnMuIAo+IAo+IEkgZG9uJ3Qga25vdyBvZiBhbnkgcHVi
bGlzaGVkIG9uZXMgdGhhdCBkbyBhbiBleGhhdXN0aXZlIGNvbXBhcmlzb24uCj4gCj4gVGhlcmUg
aXMgdGhpcyBvbmVbMV0gd2hpY2ggcmVmZXJlbmNlcyBhIGNvbXBhcmlzb24gd2l0aCBzb21lIHBh
cnRzIG9mIAo+IGVCUEYuIFRoZSBzb3VyY2UgZm9yIHRoZSBiZW5jaG1hcmtpbmcgaXMgYWxzbyBh
dmFpbGFibGVbMl0uCj4gCj4gSWYgbm90LCBob3cgY2FuIEkgZ28KPj4gYWJvdXTCoGJlbmNobWFy
a2luZyB0aGUgb3ZlcmhlYWQgb2YgdGhlIGFwcGxpY2F0aW9ucz8KPj4KPiAKPiBJJ20gbm90IHJl
YWxseSBzdXJlIGhvdyB0byBhbnN3ZXIgeW91IGhlcmUuCj4gCj4gSSBndWVzcyB0aGUgbW9zdCBw
ZXJ0aW5lbnQgdG8geW91ciB1c2UgY2FzZSBpcyB0byB0ZXN0IHlvdXIgYXBwbGljYXRpb24gCj4g
d2l0aCBhbmQgd2l0aG91dCB0cmFjaW5nIHRvIHNlZSB0aGUgY29tcGxldGUgZWZmZWN0Pwo+IAo+
IEl0IHdvdWxkIGJlIGdvb2QgdG8gaGF2ZSBhIGRlZGljYXRlZCBzeXN0ZW0sIGRpc2FibGUgQ1BV
IGZyZXF1ZW5jeSAKPiBzY2FsaW5nLCBhbmQgdG8gcGVyZm9ybSB0aGUgdGVzdHMgcmVwZWF0ZWRs
eSBhbmQgbWVhc3VyZSB0aGUgbWVhbiwgCj4gbWVkaWFuLCBhbmQgc3RhbmRhcmQgZGV2aWF0aW9u
Lgo+IAo+IFlvdSBjb3VsZCBwdWxsIG1ldGhvZG9sb2dpY2FsIGluc3BpcmF0aW9uIGZyb20gcHJp
b3IgcHVibGljYXRpb25zWzNdLCAKPiB3aGljaCB3aGlsZSBvdXRkYXRlZCBpbiB0ZXJtcyBvZiBz
b2Z0d2FyZSB2ZXJzaW9uIGFuZCBoYXJkd2FyZSAKPiBkZW1vbnN0cmF0ZSB0aGUgcHJvY2VzcyBv
ZiBjcmVhdGluZyBhbmQgY29tcGFyaW5nIGJlbmNobWFya3MuCj4gCj4gSXQgd291bGQgYWxzbyBi
ZSB1c2VmdWwgdG8gaWRlbnRpZnkgaG93IHlvdXIgYXBwbGljYXRpb24gYW5kIHRyYWNpbmcgCj4g
c2V0dXAgd29ya3MsIGFuZCB0byB1bmRlcnN0YW5kIHdoaWNoIHBhcnRzIG9mIHRoZSBzeXN0ZW0g
eW91IGFyZSAKPiBpbnRlcmVzdGVkIGluIG1lYXN1cmluZy4KPiAKPiBGb3IgZXhhbXBsZSwgdGhl
IHN0YXJ0dXAgdGltZSBvZiB0cmFjaW5nIHJhcGlkbHkgc3Bhd25pbmcgcHJvY2Vzc2VzIHdpbGwg
Cj4gZGVwZW5kIG9uIHRoZSB0eXBlIG9mIGJ1ZmZlcmluZyBzY2hlbWUgaW4gdXNlLCBpZiB0aGUg
dHJhY2luZyAKPiBpbmZyYXN0cnVjdHVyZSBpcyBsb2FkZWQgYmVmb3JlIG9yIGFmdGVyIGZvcmtp
bmcsIGV0Yy4KPiAKPiBZb3VyIGNhc2UgbWlnaHQgYmUgYSBsb25nIHJ1bm5pbmcgYXBwbGljYXRp
b24gYW5kIHlvdSBhcmVuJ3QgaW50ZXJlc3RlZCAKPiBpbiBzdGFydHVwIHRpbWUgcGVyZm9ybWFu
Y2UgYnV0IG1vcmUgY29uY3JldGVseSB0aGUgaW1wYWN0IG9mIHRoZSBzdGF0aWMgCj4gaW5zdHJ1
bWVudGF0aW9uIG9uIG9uZSBvZiB5b3VyIGhvdCBwYXRocy4KPiAKPiBJZiB5b3UncmUgbm90IHN1
cmUgd2hhdCBraW5kIG9mIHRyYWNpbmcgc2V0dXBzIHdvcmsgYmVzdCBpbiB5b3VyIGNhc2UsIAo+
IG9yIHdvdWxkIGxpa2UgdXMgdG8gY2hhcmFjdGVyaXplIGF0IGNlcnRhaW4gYXNwZWN0IG9mIHRo
ZSB0b29sLXNldCdzIAo+IHBlcmZvcm1hbmNlLCBFZmZpY2lPU1s0XSBvZmZlcnMgY29uc3VsdGF0
aW9uIGFuZCBzdXBwb3J0IGZvciAKPiBpbnN0cnVtZW50YXRpb24gYW5kIHBlcmZvcm1hbmNlIGlu
IGFwcGxpY2F0aW9ucy4KPiAKPj4gSSBoYXZlIGNvbWUgYWNyb3NzwqB0aGUgbHR0bmcvbHR0bmct
dXN0LWJlbmNobWFya3MgKGdpdGh1Yi5jb20pIAo+PiA8aHR0cHM6Ly9naXRodWIuY29tL2x0dG5n
L2x0dG5nLXVzdC1iZW5jaG1hcmtzPsKgcmVwb3NpdG9yeSB3aGljaCBoYXMgCj4+IG5vIGRvY3Vt
ZW50YXRpb27CoG9uIGhvdyB0byBydW4gaXQsIGFwYXJ0IGZyb20gb25lIGNvbW1pdCBtZXNzYWdl
IG9uIAo+PiBob3cgdG8gcnVuIHRoZSBiZW5jaG1hcmsgc2NyaXB0Lgo+Pgo+IAo+IFRvIHJ1biB0
aG9zZSBiZW5jaG1hcmtzIHdoZW4geW91IGhhdmUgYmFiZWx0cmFjZTIsIGx0dG5nLXRvb2xzLCB1
cmN1LCAKPiBsdHRuZy11c3QsIGFuZCBvcHRpb25hbCBsdHRuZy1tb2R1bGVzIGluc3RhbGxlZDoK
PiAKPiBgYGAKPiAkIG1ha2UKPiAkIHB5dGhvbjMgLi9iZW5jaG1hcmsucHkKPiBgYGAKPiAKPiBU
aGlzIHNob3VsZCBwcm9kdWNlIGEgZmlsZSwgYGJlbmNobWFya3MuanNvbmAKPiAKPiBZb3UgY2Fu
IGFsc28gaW5zcGVjdCBob3cgdGhlIENJIGpvYiBydW5zIGl0OiAKPiBodHRwczovL2NpLmx0dG5n
Lm9yZy92aWV3L0xUVG5nLXVzdC9qb2IvbHR0bmctdXN0LWJlbmNobWFya3NfbWFzdGVyX2xpbnV4
YnVpbGQvCj4gCj4+IEFueSBoZWxwIGlzIHJlYWxseSBhcHByZWNpYXRlZC4gVGhhbmsgeW91Lgo+
Pgo+PiBSZWdhcmRzLAo+PiBBZGl0eWEKPj4KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KPj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+PiBsdHRuZy1k
ZXZAbGlzdHMubHR0bmcub3JnCj4+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFp
bG1hbi9saXN0aW5mby9sdHRuZy1kZXYKPiAKPiBbMV06IAo+IGh0dHBzOi8vdHJhY2luZ3N1bW1p
dC5vcmcvdHMvMjAyMi9maWxlcy9UcmFjaW5nX1N1bW1pdF8yMDIyLUxUVG5nX0JleW9uZF9SaW5n
LUJ1ZmZlcl9CYXNlZF9UcmFjaW5nX0plcmVtaWVfR2FsYXJuZWF1Xy5wZGYKPiBbMl06IGh0dHBz
Oi8vZ2l0aHViLmNvbS9qZ2FsYXIvTGludXhDb24yMDIyLUJlbmNobWFya3MKPiBbM106IGh0dHBz
Oi8vd3d3LmRvcnNhbC5wb2x5bXRsLmNhL2ZpbGVzL3B1YmxpY2F0aW9ucy9kZXNub3llcnMucGRm
Cj4gWzRdOiBodHRwczovL3d3dy5lZmZpY2lvcy5jb20vY29udGFjdC8KPiAKPiB0aGFua3MsCj4g
a2llbmFuCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
PiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+IGh0
dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
