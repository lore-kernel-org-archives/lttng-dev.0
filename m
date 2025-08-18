Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D220ACA0EE4
	for <lttng-dev@archiver.kernel.org>; Mon, 18 Aug 2025 19:16:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4c5Ms86xbPz1xk9
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1755544606;
	b=YDB8CTYsZkSE4p9tHcEc6wXLZ8HjLhJAQ5PyUIPhWRUfp2RWoE0qDA/9vam9NAv3YPcS
	 jzhzTXA8r4dCV4qH8caDTKE9Y6/GNLv89ttPt1a+gG5VNhuHBBK9n3h0Y2B9TMFi8AGs/
	 meN8CoCPLTXZF1Z/CTq+rmZttP8M5K/0gHaLO7B2izjuzPDB4sFXARZvzw3/WDwnFDlz+
	 f9Rz+4IxrLIopQelxkxAbvZJwicUa0HJ9KeZTQIqV91pyOR9E9jZcs3psgi/A1fYkAtMd
	 vJG3HNXL3V2IpveCj+hhB2WlqrlO+ZEexpVvUWPDD7BkpHkhc9t7zlfvyQ0Eq7H7Jwg==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1755544606;
	h=DKIM-Signature:Date:To:Subject:Message-ID:MIME-Version:From:From;
	bh=2WpSFbchq+mKG9+tNk4JL4SNQ31KMyOtm3YxtJUZTZs=;
	b=Y7s9tJUy2aCvxHRl67cV9BEdFjl5kgkzWJUYjzvrFCVwa7N5uAabCPpz59Z/uevfVBbw
	 kBlX7ChpjdS8XcyXWdhFgb3Y2hMuIVijYo+6sEkFzLxeciyB67nEqGZ/+b6w0TFPHsG/i
	 PdvDL2/Budp8LRiRgca08izgxRi9lUeq4qckc6Pj5/ZZk4aihP+qOeJ82/eFXdrTOhNla
	 TZAj9mf48U/pDOrAWnRF9LeKpbs7SA4cLMNgOYvdwrRKBqNrWAbCSfQDTv3WRaGdSFBEk
	 JcH04/jJnnkBBV/GeLbDQQoObCjtU7MUksMG5Ld6gx5l1euO2kZGVEJK9DtSaPa3TGQ==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4c5Ms86xbPz1xk9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1755544606;
	bh=2WpSFbchq+mKG9+tNk4JL4SNQ31KMyOtm3YxtJUZTZs=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=rK0lsxNF8NqKps4HSrtQT449LkiuMw5zFSQJFoGKLOnyBlC4A/MXRsHc6BvXU4kWz
	 aODCdO5J4DJkH6nDkZhQqTQrCzSBzvw3ddEpcPQRwMTyCLOojwnxpeywHX0Qs90BzX
	 GyAuuvCSsgcVFxbhCtq6p88ojc+KXvCC2E/PIgR/UHG5zPmdSOHg7oiDdU/IudjIIg
	 E2UmHwr5el+ZoUL0xCGTqpVxdsZ3bRZX4BZJfn+fLXprY8PSjcblfK85ERagHY8pHj
	 6Nos6xTnBlH5yRFk6ymdpMLGdHTAKUbhFa/IU8rsboxHRANopk8N6H2g4lBgsuygqC
	 NDUFKg6HRj86Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4c5Ms86xbPz1xk9;
	Mon, 18 Aug 2025 15:16:44 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4c5Ms65kK9z1xk8
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4c5Ms65kK9z1xk8
Received: from YT6PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::3])
 by lists.lttng.org (Postfix) with ESMTPS id 4c5Ms65kK9z1xk8
 for <lttng-dev@lists.lttng.org>; Mon, 18 Aug 2025 15:16:42 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+/3eXFZ20jzmOduZGEW/Sat4fZkGZrRXvyyfUGTwzvXuPdmE3ODP3UXjvVuiOr5lAoTuKicT0MVjDGJ/VlA6Gwa65QirPdj5jGPowDAllxHA6zAwydpeB6GicMp5xKgFx2sSdLoNfWMFY/CK7hLKx5QkO0Hex/VXPSIgTBYq7JGTelYHB4FEXNpYqDDl8ZgXB2+YPYYIiBvNJ/MvFHsx8NEasJrIOBAwM8mL4cHU/MZscl42l1QsPqMHCzN3RxQhkP7S7geCnPVrfZA4eWSsShiMDWrX8XMOZOfahowcxsAl6iUM2whKB1Z4NgEpQ45XiCEb4lSDLGhfm9sUAxSLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WS0FpkRQRzAj6SuMdE1ef6J05/a2gXDJU6XvjBknzE=;
 b=KoGNsFGK4GTf7eQQE+CwfGbMRmUwFSVDl8edJplUOzvRclbw6WN03ex9pj9vLAcP8LTKFpPFZq5X25mJXlKXsII97tZ4aeyD6Rdx0ME6faE+cmlFohKNXuIdGWogU9xj6WNjyU3uqmPtYu/DflM7krZvhZ2wWS3zM2p5zfra7B35LMwoE84ugKHCtbKJSejV6XivuVL37b6JBBj347ahBEwgdOQZwwf4Q/8e6wzARW8PkD7BnWW7HEFcu+VPtb/MdJ0fzIcs4nbb35wdQWHe41in0kH9tP6EBejblvMxK2SXKUZr7dsM46Y3rwKmdtBJKXdJnKR6uoFu8yfCQqd9yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:104::10) by YT2PPF5273AC386.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b08::441) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 19:16:32 +0000
Received: from YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5de4:ebdb:2bf6:ee1]) by YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5de4:ebdb:2bf6:ee1%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 19:16:32 +0000
Date: Mon, 18 Aug 2025 15:16:30 -0400
To: lttng-dev@lists.lttng.org
Subject: Re: [PATCH] eventfd.cpp: Remove the scope resolution operator
Message-ID: <aKN8DoK1p33HxveE@efficios.com>
References: <20250724063551.2843528-1-mingli.yu@eng.windriver.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250724063551.2843528-1-mingli.yu@eng.windriver.com>
X-ClientProxiedBy: YQBPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::35) To YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:104::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10709:EE_|YT2PPF5273AC386:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e781c64-c8cd-4c40-32cd-08ddde8bbd98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?32DOLkT71AT/jRrUJaTogL/S2vvNP8UFeKMedKDhc2mGxuT3Ptmj7EKxPd?=
 =?iso-8859-1?Q?y87YYkKgC136lCkgpRdNmKfdwZJ4s4ZlU4dmWAT2KLC1nSdyuI55PpqRAh?=
 =?iso-8859-1?Q?PKY+r06j6AfJD8mfZz/z1PWsZlrZbB4uh6eExW7JBVc3Og7B6dKXLnWm4I?=
 =?iso-8859-1?Q?l0aNNmvggWR2b7Ony27z+hgcCNG1WjziHVlo8y2iVTtiCK3LnWGpWaghW9?=
 =?iso-8859-1?Q?6uuiZhp7vmpYJL/tTKy74k0qnUgA6FMRfgZTv76IHHLWPJ/NUDt8V9/lur?=
 =?iso-8859-1?Q?csb9heO4DCdft+23FfFtt3M6hOtL/8kN+7g1zMKgg7uZ15yjWAYAHA8um0?=
 =?iso-8859-1?Q?e3HfoPUkoeWHbKXPb8XV4UOd2r7/iU+2dpeNd69cbn5enDYhHWEUN9gSWJ?=
 =?iso-8859-1?Q?1RF3lJRGKO3OYCZ1j8Q9EtgEHGUJEiNbXae67TayttwLHSu7VGRkuxolAe?=
 =?iso-8859-1?Q?TNCg5hEtYyqCcUWWouWMADEX1uY9HlheXLRT38RqD/g4WuN42u6M9mHORa?=
 =?iso-8859-1?Q?kUUxHoQy4ca3OgkHFm0lGuraoW45sk4gRuIs47D4BFjUGImOm2AZdTj0cd?=
 =?iso-8859-1?Q?2KLJepPaKdWrSpTB3ybI++NFdxTID5iiUwohWQ0Q+5vhtaAE98Jlwwbt0N?=
 =?iso-8859-1?Q?qbMyFZlYU9Hz1ceg5oR/5EIgKpJWiiuFDs0WFEnw27827FU/8B5LnRFQW/?=
 =?iso-8859-1?Q?cVq7BiBz/VQvE6IP+Z3x4mcjzh+e5zYhg9g4TbHz3cfiGRkd4mtkFtEJGp?=
 =?iso-8859-1?Q?1nr9FyqXT9712dt/7lLLnyuaWHuWhNt+6NcIxhvwZUUodGi6vbugjb6sze?=
 =?iso-8859-1?Q?f1yuAHToLIvAymqkBZxt9n8+cYi6GR3RTFBCyvyZ3Cu+163K9YFs+gHWrH?=
 =?iso-8859-1?Q?JLX0TSGvldZKMGQX2GNRxuUkDiJAGML+KidbdAuo6ApdSuH6/VpsFvnpoi?=
 =?iso-8859-1?Q?n8BUOiudfIPeq8jOiEJhNks56cnQdvX23TS+bmgw8oPYRboJHUyE5gnFEp?=
 =?iso-8859-1?Q?fg4ICfuRFjPRe9UU9V+DBELJmnf92HxDMYNRz1M54MnI8Ubh7unOOCYSVW?=
 =?iso-8859-1?Q?QtZYBylKrfq3O9GpsAZ5JVyUTjMU8z5dtwugky8703qDQl+FQZZwc92wsb?=
 =?iso-8859-1?Q?06EmWHAVHxgKtlw2N5cYNUJuEhIXExKN6EoSHRzLJ1gsHRK9/cg4C58x3I?=
 =?iso-8859-1?Q?Tvl9WLhvseAQaBOrniEhTbihu9ZVsvvWKO25nmh5OXTZt5pgN4Ko/29xmt?=
 =?iso-8859-1?Q?O15nvpMB6T6EAQ1385O0ZtsaGSuNKPSCQSo2Vqau/ZeG1BoulZkpZ0fKs4?=
 =?iso-8859-1?Q?Mn8X0MwERNqSQ81lr7O4J+La71nMfGMICX5fNC1edoyzsy/2v4ajgfXptO?=
 =?iso-8859-1?Q?j96rb/btCBP1doG+bDqiNjTZNlEbt8oJyGg53nsXU8JyPdMn0wwSK9Z7Dv?=
 =?iso-8859-1?Q?aj5EKdEVAgB7afT0SvvJnSHdOTJE3bQNjqBRLQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?L0tVgP6f2gQcShrIEyXC2Xzeb8yeysNAiOPedhA49qN1HNf2nnra8Wll/1?=
 =?iso-8859-1?Q?pW9nTJd5qU38ainNVA8h1VRPT9KVcFtYqlYx2dpIqyfTkmOC9MjYZ+LVAp?=
 =?iso-8859-1?Q?SRx27stih1c4XYeKQqX07T63m5ptIp2JmZeuqSwS3rTzwXe+pZuK4RFOvJ?=
 =?iso-8859-1?Q?pENohMr090iIcsTFn5nzO/dNDQ2TNp4QNHNLKnmAmyFDEuH6CEyYTepuLf?=
 =?iso-8859-1?Q?exhq6FWVHr+wCkIGv3eArLMvvpsO8aH+OAroIDwj4WIE7iOIfFVpkfE8eV?=
 =?iso-8859-1?Q?5SjLPYVTIehGkbaQD6AQ2RDHQ9jiKDBGDWLmXuJqqWUg8diASe0lmo6BYn?=
 =?iso-8859-1?Q?Si7SQB56scouze0G0LshIStfiU5mi0qEMSw0Ui02Af8dSdQ7oXgMSqyMdL?=
 =?iso-8859-1?Q?JapMQncc3tzAuCPBp23PIUwQ4u9R7XH/YiV1xOTLyCZoHi14NYVGDHjN4o?=
 =?iso-8859-1?Q?zZIrYtGtVeJAZEcdDL/sOYAXvOjDwg3pcodWGtS9H3CDP1ITeOgtc8yMBU?=
 =?iso-8859-1?Q?FnEwYIQ+EUNq7BalFl59Quy75UhBzY5LO+T7qnNtNeOGa4mQ6R65jAMMB+?=
 =?iso-8859-1?Q?TDHK2c02zhVcyhgkfVPxOuFM+bUiAts1rLT07dqIyjYMzH5Jgb9rqCDBft?=
 =?iso-8859-1?Q?uJeJGgADuRak53pDuixSrgaNwBTLydb44U/wX3ZjvfxVhb4/Qrjrb3zdND?=
 =?iso-8859-1?Q?XJ/STKU0XWKtVFj6sZ3eyyA+f5Mf43+csY/9ea5hp6Pdk0bFofLXN14JzA?=
 =?iso-8859-1?Q?rrbZojwyMY+mMuYBFvjjiaQbYOmNfTu50BJloRiM3WtAW7iMkR5lmpeppf?=
 =?iso-8859-1?Q?PquVhdocQxF9gQmCuByixTRJLNlIpQRYml/Yf79RXshDMvwr4b/PDaOjbY?=
 =?iso-8859-1?Q?xP85HRk7l4WWTr9mhcX8DUE0qQ5z7BjTsHVg+C6+9wTnKLLbf1mXKp20jA?=
 =?iso-8859-1?Q?O/Zsxzvxr6L+3zp4RYe7Nc+/wMEXeIIBhK1b51EgvfbdE7pDKL+fdy2qYV?=
 =?iso-8859-1?Q?/orwSZJ4BtiVcVPqEBwKzto0/x05Y/X38BcyiIL9IKAUnp30zJw/jj+vBj?=
 =?iso-8859-1?Q?6hNuzBVSN2fbaLqGp/mYbfBqk7gkUy07slyZRZMVt8WFI2kc2LSNc//Xqn?=
 =?iso-8859-1?Q?8L6bQbHhSfKOHQYHqiCvLxLp5x52xyCHrPKPg5cccBkpPrdn0wzrXEN4yB?=
 =?iso-8859-1?Q?ETTePnd65JtjkYn4fIKY03tyVQatu3u3A3peyPXBcrxFxVlYlPTe4x8JAe?=
 =?iso-8859-1?Q?vS5gzm8qr1GbijXIoGPQHl7TMiOF+GJRk63j8MbId3TYMQaxizbDJrpvcC?=
 =?iso-8859-1?Q?f/ZsJrbdImwBdV6dt45oMnjaaGuAaAy990q7Z5OlHqhDcj7DbaHReMaOAY?=
 =?iso-8859-1?Q?WBghtM3HSqX64byxLm4TRHRW6gQe2k9TKNFMsaGrzT9Xk34F3FIwjfFvm4?=
 =?iso-8859-1?Q?HBzsIq8gdQt2ov8wn1WVcwXE8KTqLV0QuqCjqKxIhzHxWFLz7KjAC8rNb6?=
 =?iso-8859-1?Q?LrYywkMjtBToODP4MDJEWL/Fjq2YrywPfqxKiZgAeIPdsC67j/NN9ZHnb7?=
 =?iso-8859-1?Q?2b4HndQR3iqSoO5D2YC8/PRYFjsXec9DKaaPIDtmtK04Bdz2bwb+qVEaPD?=
 =?iso-8859-1?Q?ELGrP997h4Eo4+QvlFx2G4Am9MxylVjtzF?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e781c64-c8cd-4c40-32cd-08ddde8bbd98
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 19:16:32.1289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HccYX2marGUeAll7t+/Nyp2KgCtC+b+4i+PB1A9MBoAylMw9vLOi7RfLpnImH515K6m7DOsSPzwsGqxSXlPBxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PPF5273AC386
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

Merged in master and stable-2.14, thanks!

Jérémie

On Thu, Jul 24, 2025 at 02:35:51PM +0800, mingli.yu--- via lttng-dev wrote:
> From: Mingli Yu <mingli.yu@windriver.com>
> 
> Remove the scope resolution operator :: to fix the below build failure
> with musl.
>  | ../../../sources/lttng-tools-2.14.0/src/common/eventfd.cpp:18:31: error: expected id-expression before numeric constant
>  |    18 |                 int flags = ::EFD_CLOEXEC;
>  |       |                               ^~~~~~~~~~~
>  | ../../../sources/lttng-tools-2.14.0/src/common/eventfd.cpp:21:36: error: expected id-expression before numeric constant
>  |    21 |                         flags |= ::EFD_SEMAPHORE;
>  |       |                                    ^~~~~~~~~~~~~
> 
> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
> ---
>  src/common/eventfd.cpp | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/common/eventfd.cpp b/src/common/eventfd.cpp
> index d331bbe40..447520f25 100644
> --- a/src/common/eventfd.cpp
> +++ b/src/common/eventfd.cpp
> @@ -15,10 +15,10 @@
>  
>  lttng::eventfd::eventfd(bool use_semaphore_semantics, std::uint64_t initial_value) :
>  	file_descriptor([use_semaphore_semantics, initial_value]() {
> -		int flags = ::EFD_CLOEXEC;
> +		int flags = EFD_CLOEXEC;
>  
>  		if (use_semaphore_semantics) {
> -			flags |= ::EFD_SEMAPHORE;
> +			flags |= EFD_SEMAPHORE;
>  		}
>  
>  		const auto raw_fd = ::eventfd(initial_value, flags);
> -- 
> 2.34.1
> 
