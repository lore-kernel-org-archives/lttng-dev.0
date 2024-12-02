Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16189E69E90
	for <lttng-dev@archiver.kernel.org>; Mon,  2 Dec 2024 20:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1733170566;
	bh=qwQZqTgA3jsKg/x7hqbmnK6KuM5z94HnDcl5NBVZwT0=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=Uzyee0LfUmnBQxbbKmZ31FGTO1cTfT9xdT3a7j8C6veZo3DELW5SmyUrmNlopCFmb
	 s6aiPF6B9ioDQQtWE1CqlcUabYS8PnjK1Dm2QHToEXz0rZwQmfAy4DNDd/qMXRLwnD
	 NZppyRkftUPq6qvR1FiqE9+UlwOFkd7CBhhb9OElapqK+O4daEfsOX96e3x6ebY85e
	 t7c/wAEEnEKFdA4jZsyvA2Gst+ymCP1k952tDJTsGPW4y1gzFZ7FShE+J5zEcSJc8B
	 4zoNvXVWjxSkFsa8iSC1wiYTpOoq+kj7TN+zk0NTXzkF6OiKIaMTmwtmjgYMaOktUH
	 ovhYz5IPmqv7g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Y2FR9231Gz1cJ8;
	Mon,  2 Dec 2024 15:16:05 -0500 (EST)
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c104::1])
 by lists.lttng.org (Postfix) with ESMTPS id 4Y2FR71jtJz1bhc
 for <lttng-dev@lists.lttng.org>; Mon,  2 Dec 2024 15:16:02 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIm8L8XgLboahxUvm4QG6RLu2LauRBRb4hDtnF6ofeLfoyEvl9fkGH9KUSodbkQzyvswCHbIjbAUtr3lQyAZVj+vtHfA+iHrutZAaCD0+9sjvtnM4HysTNMPLHHkaHcK0pVFZ2HGDORXi2qXmop3q6b2WX5dAhR2t8pzppunuffSynG/yW+n9WR2ZF2+ZHXdcKdWq98Oex70IoTM1I/zOSjeJhJbWnrj2weXiYzNjvuhJJR3RWN0IQJkaZV+uGYnFRYNzy6Xnd6ZYqOERRz9fS0ljBGsTFMDROktr7tvvePp8INDwvOo8p6uTrOgAXJTG3BoNMo7ntEUTHpN6P0wDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6d1h5qFPMmXblHQ31joRE+fhFBU0K44taRZ7UeQx7I=;
 b=IGO6NjVGOuBLXLhTIK4yX41t0CAsFuKQrC6rrbRs9QKuQA6KrXimR3yhebpddCjWJP9fVmvzgQKOOVOmt4GhjC4Mbm3Mj9esY9mDMP3dQuN6u81cnhFf29RAQ/oucGq9OSgdPnEimpjAlGq19JGmm1ZIGW2yWZzx7R9lGEwzojGY35wPNUd40x6uaxO1yi8C73lBpkOVbUYH7MF6Of8hqnedXS6SKxGbemFw+yotB+HX0+aLq6mV6gBhOyW+yZJTA2L5j4kj9lr/i1tWr6Bhcfezf2WRjHh58W26lD8dV5YWmnyr31NCQcmvLnGNwNwU2iXNZG0rL/R/KkMHHKIAFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YQBPR01MB11263.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:9a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Mon, 2 Dec
 2024 20:01:30 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%5]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 20:01:30 +0000
Message-ID: <9c4df4c9-aa27-4185-ad9a-4cff78bef2d2@efficios.com>
Date: Mon, 2 Dec 2024 15:01:29 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Subject: =?UTF-8?Q?absent_du_r=C3=A9union_hebdo_mercredi?=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0150.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::9) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YQBPR01MB11263:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ad0eda-2001-4719-70cf-08dd130c1d04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEFadm4xMmRoUzZKRlVVUGVHYno0U09aclhMTmFPeFBsTE9xL1hxbk9HU1FC?=
 =?utf-8?B?MER5WW9Bc1pXTjVmUHZsbzFJRHA0RDYzdlVNODh4TW5QR244UGtvLytaZ0gw?=
 =?utf-8?B?TW04Tkx0WHpoK3JuelExaFRzKzN4V0V5ZjRIcUZTcDM2eXFlcVk4TnoxbjVk?=
 =?utf-8?B?MUdDc1M1NCtlWUFzTTlaMElmT29kclFlYUluVytRSENreTdPU0tlZlI3UVd6?=
 =?utf-8?B?eTB4a0FRbmRWQXk4TlUvM3dOVVgvUGxJVVViT0NVcXY3VjVWS1JQOTFVU0tG?=
 =?utf-8?B?bGE5Wk9naDFSb0NBRS90NUt6L2RObldoSjZaMzFGQkxmc1JLbGNkb1hKb2pi?=
 =?utf-8?B?a2dXakVnMURtWlN2cHpNY3hHSXRWdUx6dG5nNktvNUljNVhtbXZuZ0JGQm02?=
 =?utf-8?B?Y2l2M3NVNXorM1MzOCsza0tneWhuTFpQUXR3ellacUlKMitIRkZHZ2ZKT2t3?=
 =?utf-8?B?T3M4cXREeDFVbUJ0UDlDSXhyRnliZjdnSjA5OVVUeFlHYlZLVFJINEtMNktV?=
 =?utf-8?B?OFVoQnJxV1ZUdUZSZ3FEQ1M2KzFMc3ZwR1U2NUMwYnRMZXFDYlB6RnM4OTlR?=
 =?utf-8?B?OFJva1VLczQ5SThqenZLNkFNVlhjS0owdGVPckFJQk0wWmlCcHQwZGE0THZo?=
 =?utf-8?B?Z051cUJhUllTN1NyOFYzYVg5WkJ6b0tIYVVwKzZIem51Z3VYQ3VObEVXYU5M?=
 =?utf-8?B?cU1XcXYwZnowM2xmUnk5UjgrNUdOVFIwRTZxbWVuOXNMYVdXcGpaMUNRQVV6?=
 =?utf-8?B?cm9HS2o3QlRmNjl2dnJ4eXJCanRZNVZDVG9Cakkwd2JITXdRamhFcm9nb0U5?=
 =?utf-8?B?VXZRRCtxc0ZqWHFrdmM2SmxZS0NYWlVHbkp1N0RKTTBSUkQyNGZRNzlKU3Az?=
 =?utf-8?B?ajNoU2tleERJSEJHbkdaZFdlaWhJNkgySURSOEVYd3pIdEJlZFF2V0FLeWFQ?=
 =?utf-8?B?VDlkMFdIcFVCNlpkakt3UWtTTEg4dVNQOXdFenJTQXE1TzdPNmtVZVdxaU5M?=
 =?utf-8?B?NEorQmlJVTgxVWJrS1dMd1h4bzJ1RzBBbFdCZlNZVU9BWWxvSE54VjhnWnpv?=
 =?utf-8?B?UVI4MFplTnFJTHp2Nklza1VuU1ZhNkt1c2RvQThoV3dKOE9VRmRmZnVLdDBv?=
 =?utf-8?B?R3JqVDM3THd5a1JONGdJWklueFhBMzZtczF0OWU2cjRSMGwzaXNKQWVuRk1Y?=
 =?utf-8?B?Qlg4UFRJM1ZUR1pRUnFrd1VEMXFaWmN4d3NBcU1nUElmdkdjNEdKaGpUUWFD?=
 =?utf-8?B?ZUhJaEIvNVZlRnowTU5uZnZUNkRxbWFvQmxNSndVamkvV1FYS0swTVBCVTNh?=
 =?utf-8?B?bldoNHdmbDF1dWRXOHZocGd6dXVuS0ZyL2ltdnpzMnRJWWlpenlzb0JORUVi?=
 =?utf-8?B?QnhiV1ZteDlneVJwRElLejV0TklCcUtFcVBHdUZ5OHVnSHJhdzN4MVBzQ3gw?=
 =?utf-8?B?SzZvWE50QkNjYVpsbCsyejVzaUUzdUZGV2FLWEx3VVNKZytSYXJJWkZLYTZa?=
 =?utf-8?B?TXNoL0d2WXl1dHJiaGhTOEJRY3ROZDU1SkRPb3hraGhURnVRS0s3bDc2UURX?=
 =?utf-8?B?Y2t1THp0SHRDMnZGaEFaTHZkYzA1Ynp5SUtRZGdXTjJ5eE9JL3RtQURydzJx?=
 =?utf-8?B?RVRMdnhIeWFmTFZZeHRGajhNS2RjNTZzVk1GTWdEc0VuUUhCcUJ6cFRIc2FT?=
 =?utf-8?B?WmpmWExERTdoLzZwZTFWQ0J4TGFldHNpNjlqMlR4OTFQQjhEQVBGN0xJdXgy?=
 =?utf-8?B?dHd5dnRNQTVucml6aHVjcm9LeldNeGxNd3lNeUJpSlgyN29LbTYvREJkVXI0?=
 =?utf-8?B?Y1M4ZzVYUjVjczZkNDJVUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:fr; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0dmeE13RGt3NGQzTDkxWFB6K3ZKY1dBeVo5OG1EeTZCalZ3aUZwMVIrM1lr?=
 =?utf-8?B?cENjNmFQL0hFdWdsV1l0MDZVUEd4NXg5dWVYM3N4c1oxZnE0TTRJNkx1dVBZ?=
 =?utf-8?B?SVRYcmFuZE1pZ0pEV3FGUG1CVy9DQUppRHVUOFhpTmNkUlBFbytwaTlJVkNp?=
 =?utf-8?B?WU9uSHdBNjdvT21ZZFZibkVmOUpmbkR1dXRvWVg2ZURDMVBaYU9VYVBMcWZz?=
 =?utf-8?B?ckdRajZnQTd1YmJoSXN1MHNiQkg0QThXUUN4OE4wcmYvT3Q5SzFKdkdNUDRo?=
 =?utf-8?B?SE4zUFFZdFVxL0w4Yk1kUWFQUFM1Y3BvWVZtNUduSldzU1N1L3BhazB6K2JL?=
 =?utf-8?B?OFJDaWdDUTBYa1h2YXpYUjRUV1BKSjZzbkFndVc1TXR6M1A4RlBLVXJqS3Jn?=
 =?utf-8?B?SVQvNVdCTHRRbVFhTmtXM2wzMkZJK1k4NStGMzdiVXZqSUdYWkRBS0hCcWV0?=
 =?utf-8?B?cEtuT2krSEd6L2FGTFgvSmlvRDRwSmNZSDh0RVFvMG1jdHZoejNRQzIxS0N2?=
 =?utf-8?B?UzcwU2trbWN5RVBGSWl3Y3ZCdTFsVWUrWXJGNDI5cVd1WWNmcGROUHlzeW42?=
 =?utf-8?B?cFF2aGtBVURtcG85MmtYdzBaTUpuUmYrYUVHNzJqSVVZNEt5R1lrZzZWNk1q?=
 =?utf-8?B?ZUZua1BLajVEM1BYbDg3R0lhaUNyc2IxRHJXNWRnRjBMNlQzMlJubjZoQjQ3?=
 =?utf-8?B?WjlHRFRid0orQzhrbk53RG9yOU1BZTd0QWZWZGxpZTY5S3hXakxVeWNMci9L?=
 =?utf-8?B?TjRwMkRHVGN3U3JzbmNIN01EUUdobWdpbHN2RWlwYTlpcjFjQm1JSFpKcHJI?=
 =?utf-8?B?bFNoa09EYTVNRE9Pc25WL0VRTE1USlRCVFQ0TWF4K09xRSthTURvUDZ2SnFr?=
 =?utf-8?B?cTFhbjBwTklzbkRFR3F4c2FuNGgyb04wZ3llaUMwSGxaMjQ0MnBOL0JWMHZi?=
 =?utf-8?B?cW04U3dCdGlIcXE0OC9MaWtqdFRZVjU4LzliRG02cnNnRXFFd3VNbUNLYjdE?=
 =?utf-8?B?dEU2UDFrSWdHSk9XY0dFSkNpWWloSWplajZIajJ4elRCNTE2Q0NhUEE3blRv?=
 =?utf-8?B?eGxrWkpvVmlvbmhBVXU3UFJuWTU5WVpia0NOS2E3eVBva3JkMHJZeWdIbkxV?=
 =?utf-8?B?ZXJETHRUbklKbjdJZmhsblJOQ2VXU0UzZGJ4enVvL3l5cGlnQUI5VzdHaFFB?=
 =?utf-8?B?V25CRlQ3V3FiTXZRWkNnYjErbDEzUTM5RVBBQWRQUmdMVkFjbzhSYVpFQ1Fs?=
 =?utf-8?B?WWNRaVB2amZuY0pxSWpFejZna2h0ZWNaaDR6NUFTTlp4cTAvV1c2dldENDhN?=
 =?utf-8?B?ZjB3TE0rV0FlVmpwLy9IajhLR2EyVW9zUmVzUnpVU1kyMk5vZHdHcngrR3cr?=
 =?utf-8?B?RjB2MHlxNGVJWUNxNXdyU2R4TWdXekZ1Y2x3WVZsd3lxNTYyek9ETlN6elZz?=
 =?utf-8?B?VEFPcHBVc2xYK1lraEMvZHprc2xqcXpmTDNHUHpqS3Njamo1cm03NkxiZlpC?=
 =?utf-8?B?bmEyUkFkemgzb1h5MlExSXpPYzBmUWM4ZmwxWFhiSTZCZ3VFcFVXakp1TnVZ?=
 =?utf-8?B?Q2hXb1gwQXI4V2RRbTVDSGJkRmJ0QkF4QmduV0FqbnN4WTdLZDg4ekEzMHBw?=
 =?utf-8?B?WGJSWnhuQ0sxSmdMbzJpajJLc0J1MEZyOVdOdVNtTUhVV3JJWEZMTWlwQWF1?=
 =?utf-8?B?bGpMalcrRGZrU3JiQVIxalk5Q1h6QVlSeHp6bmF1UEJIVVd5S1RWMHZ4dFZj?=
 =?utf-8?B?Wm14a0RtazlHYWpGT2NEejlOUkFGOWNjWUVkR1NoQmpuTFFUL3JoRjYzc2d1?=
 =?utf-8?B?UnozRkhmYlJGRnpDbytvYWxHQ3JJZCtLYTFrdzVkaWs5UmVIRVFJRVJ6Tjdm?=
 =?utf-8?B?d2lqeVlXVURoRmdYekZvMjFoRVhTSHpPVVdic2JyYXRIcW83dVlzT0ZZSkhv?=
 =?utf-8?B?ZU9NMlhHVzZYRVFvQ3lRakFpYm4xMzVZbGZUOGx5THdQV0FaWlZRdEp4QlUv?=
 =?utf-8?B?bFNMNkFBMTF5aG5UMkJrSDNQQkpzdGtURFN2RUlGazJ0NUlxb3l5ekYvVHBa?=
 =?utf-8?B?NjZ2OWZuakpYS0tUWVZhNUp5eElibExkTXVMbjlWWXR5SUFSQWhSUEZFTVFq?=
 =?utf-8?Q?ID5+SShGQC8ug3xVa5/myy66l?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ad0eda-2001-4719-70cf-08dd130c1d04
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 20:01:30.5654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6T5V6Yb216qOQ25mWu5wWLV2xgILjbMqleMRvgohN1P7ixLvfD+uf3+wMo2txGsJtG51q5GxIZzD/HIGYKS1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB11263
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
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

salut,

J'ai exceptionellement un rdvz ce mercredi qui fera un sort que je ne 
sera pas présent à la réunion hebdo.

J'enverra le topo de ma dernière semain mercredi matin

Si jamais ça pose problème, fais-moi signe et je vais tanter de 
re-arranger mes affaires


merci,
kienan
