Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539D2FCA179
	for <lttng-dev@archiver.kernel.org>; Mon,  9 Mar 2026 19:02:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4fV5x46dQLz1b8Y
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1773082954;
	b=abXxPdMc4l/vN/eo0hy3qzFY69xw0MEJ2vo3AqY1gDw+FBwgHQZg6gWMS13aEg0skmL6
	 t6+GtbroY+lWr0bfgXmRgo9hxSsOayy4hieRLGLc2g/L8Da++FBROpmOtPnCQr/wCgPmv
	 9mbQLw/RjvSJv32VzQO1mtjxQT6K9cQN9+NdVRh49hG07m9W/SvjMvEigh8YAKIj8p6aO
	 xogOafL6up3iZLsg1/rzK9urSSSiQUQ30GnQ7A3lcYFKlwZVG1x43bYf5YU2wmGL6qZCo
	 ySNafcwSojfMsMEK01MsshI2hYrCZCvbEWjNvW38FIxH+guc7zL5Z+7g+zDQf2p0m1Q==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1773082954;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=fIOVZLngIE9zMVCWUICQq/BcX64cbAZDPQEo/ip/Evk=;
	b=Og3SoAPaMJbJnSMuZBNf7zT9L4ELeSoVL3NAbAZXeBx1YMQLRlL65B9AwOnRZssj1Lcs
	 sFIyF08Z7LX7ApdvWFCWIDiUA5+UZEiureIwDIGulH34MMBvY/KcQehBCeZ0Ixcp3fDfS
	 syEDIq9CuD3S0Tw8jwbBTu3/W9mTCcR1WMHA2PGDvHPs2+KBQOag4QO8YtmHBrRAPGqnB
	 dQW/zZ0etpCpLVHyijp+mkkz9AomICtY3QL7/mHKUFcCJq2HwDSnAGHphbihzUXT+Zkcu
	 4ScITK6Z86fomEwsjmVEoHGc/RWS7XGERQ0HUdo2yETDl/K/Dr7xOa0grMz+4fP5eyA==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4fV5x46dQLz1b8Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1773082954;
	bh=EdC+vCUrlW/pI5H7DyzoPsJlIscIte491E3VJRhQVic=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=i14a/qkSLZu5E0jQPcyfuLxGfVuH926SOtm3xyKeF9uhUCr4Br1KuYhkSGmpAxPgU
	 aTIh+FH+Y35K6Fdj5qePcBNn+bq9zm+izdBUBOpuGTCDcErnaiMsczAeVqlGs61wT3
	 9uJGqs6WWlhxrGL1+EOqLs6c03TZ+iMufQ5XRMifxsOWyUTlwzMKcVw2r47bMCM6q4
	 PM47BanUpUgb+S0aRKZKmDZUlqDkeNu5TMNXfWS5xI10eXFndXG5JXQUUI+MQQr3ES
	 vVJAzo4aLAfNe9gXERKyyKnsnKgj2UoTwG1vYlqchODABbYEFc4/a0kq3wux6qxuGg
	 FSn7CGaUgneFw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4fV5x46dQLz1b8Y;
	Mon,  9 Mar 2026 15:02:32 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4fV5x30WN9z1bGy
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4fV5x30WN9z1bGy
Received: from YT6PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazon11022093.outbound.protection.outlook.com
 [40.107.193.93])
 by lists.lttng.org (Postfix) with ESMTPS id 4fV5x30WN9z1bGy
 for <lttng-dev@lists.lttng.org>; Mon,  9 Mar 2026 15:02:30 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAnrogZOiAghrzozSKtHh8kpUtu5WaATbAMmTIjewOIHXU3TZUIy7fPknPM/VXi6/vaHBGoyaOvjTrtlaLhBrTzDfuyYgjMArSUv8DRkBqyVh6IrUWF2QpgXTn+C4/n7cP2N0pntMbe4sY6QLActVDrPFNd4LmyCRuWS/Skr89+HPubBPTNZnrzTpIkz9O/Nfjyjkd1xpIz3QG1I74As54olRcL5dw4kxMPPVcM9vAS5jkpFMrrz2r4V7Hr9U3Uig0+R4y5RXEFYPTBmTDjFNP8TOnoCc+zZZmPr8FyyrNAwYXIGT7nVT0F/c+dN5z/1yJXzqbDfzp4mg2o7T7yWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdC+vCUrlW/pI5H7DyzoPsJlIscIte491E3VJRhQVic=;
 b=O03lNCzt4iI/54UD/YAujhIdqFEzHasJMpOqvJyU890DQOsWVylnyDdnUmfDOdr2ebpVnnhglZM+R7EmR+E1NuQCIFyZTEDKTIJya3blfBqAS86vP6RCSmN4EDKlglrtv32a96pj70sT9RDDKB3j1q+Wx9ztOsFhLouhltAARzLmB1hTqXoIOJY2eL1LOGypK9tFLYjvOyK0PmE1A4xvjAS9/P2daVynkDBLGztOqVrcuRvKv6QWe5NhYJNe6W5W7cV8BC+14+70F2YFbPVFj5SK4EVlZQ4IQSFV3FAoZqhBrlDYfzxh0UEDcEX6K1KkNb7R723YdvQuLV5eqRdSUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:42::24)
 by QB1PPFC21F75C41.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c08::28d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 19:02:20 +0000
Received: from YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4c7b:7dec:7e59:918e]) by YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4c7b:7dec:7e59:918e%3]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 19:02:19 +0000
Message-ID: <e08d7ebb-d3b9-4c7d-a7af-ccefc339d5f6@efficios.com>
Date: Mon, 9 Mar 2026 15:02:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Build-time tests fail if machine has a single CPU
To: Santiago Vila <sanvila@debian.org>, lttng-dev@lists.lttng.org
References: <aa7-8LHGez9Bi0UQ@nuc> <aa7_bv8CMRlfeIFH@nuc>
Content-Language: en-US
In-Reply-To: <aa7_bv8CMRlfeIFH@nuc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0292.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::16) To YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:42::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQXPR01MB2357:EE_|QB1PPFC21F75C41:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fc210e4-7ea7-4e06-ec85-08de7e0e6331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: gdnp9qAOXx9jttaa/OroDVtSfyBjVG/h/cQnm8DLnK0eHUz+B4JoSbylUZbBy0EZ4QWKn6wFyXshOfP1Q1FMSz9e7AgLWt3NWl8bZkBJlXs6X7wcbr5HtHZ0aho+xBzz142i3kxBV9vSt8J0tPaAwQO8k3NJWZbHQpaEunWej3csWH2wmHYIY1YXB2xb4Umeeq4jmKm+6QROrFZMglmAcB436gLg6sRMH0ZfeeVPwommPg9N3aMKsVs7pC3a97pKk8BQJc4RtQPLQYCpjJR9uhDoLTbDTGJ0lOd917wL9LIwqFUux0PQbAu3OUZL6jc1BCekY2QwThWnF+DRl5/xE+3Q1b1HK+8KiZFuAKpB0YN539WizlG2lROAN9LbU1PRGItO7qnzPhjqF/Gax9IwDMSbOD3CsC2EnEFDfeuzW1NGPOpOcQnel9bf64Qye82UxwHG+nTG4iBblIC8GnP3rJ0EEq6y89NvF5cKGKdjvHw3F34wiBdYNvEBKz5Wm1zXxaCV5O20be5qNTygM4oTmSp5pOBLW2kAv/eif1/BDbhBLgwMf7drJtFtYvykqvPkXPtD/npICvBdz3BVUE40bNTe8sFgMpbt0/xOKgSmpTLCBSmPpPJuIH+VfyOsh1YgcCneRmR9msbxPpIG5mamNzPg7jPTQOBOhZhv/XCcZ+UzC+1UhMJuYhXpB6kxv66nbkNXWenw5KpXfYYfLLAkwQpmHy3XNRer4kM+ZOzjpWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWd5ays1T3FodlZodHNLNnpRVEJTckd4RnV1MVh1bjcrVm5URVBpMFcvZWV4?=
 =?utf-8?B?dWk3d1JsRm9xWEFzMk5LQVdvSkFtTFpuaVREUXp2UVByUnpMZW56cThvOE5K?=
 =?utf-8?B?cVlvLzhCY2NPNUJZTlR5cDhHOWhzMm5RbWZlMkpsOTY4VGdNekNrcVgwSTBG?=
 =?utf-8?B?cExYY3FqemFYczJuREYwQm8xeUJEbE5GbWl3ZGFyNUVQeUJNSmxvaGY1YXVR?=
 =?utf-8?B?REZEdGorVDI3N3p2c2p3bEFaU2NialduOUxyVTdjMmZkRExhWkhQU3B1RXV6?=
 =?utf-8?B?bWZnNkR0TzEzWnJVeVhJVFNhZWxGOW80WlFtM21USnFaV3ZCOHYzcUR3bTdT?=
 =?utf-8?B?V2VGbDYzZTh6bjNTSm1VcVFyQVdxTkdad1RadEdOK25CV3lGS25EdDkzeE1V?=
 =?utf-8?B?NzV4dWErRXFqQ2dxdVR2ejdxbldzNzdtN0hsd2E4b2xTaEJIVnNBVjdaNzJT?=
 =?utf-8?B?SEJrNzBsRWFnU0R4a1lEaGUrNk5tVWpqTnUra3dUTzBaWnVvdlZnTjl1cWx2?=
 =?utf-8?B?WEdLZ3c3M1dJVG5YVld1Lzd6amg1dE4wbTRHSm4xTGhRejZ2NUx6OVhVNEE1?=
 =?utf-8?B?K3N2bDVrTkNHOWxSc21PNnFBMlRMQmVUZUlHSjdaWGhPaWFjcE1ENjFFQ1NG?=
 =?utf-8?B?VEQzbG1DU2NaeWdUQlZ0ZUZBZjBTSEZzT1cxVWtyVDFFVGhtM2k4VlE2dkc2?=
 =?utf-8?B?MEVwVFNFRktldFJ5Uk5YSmJCbXpqVjFueU9zKzZxNmFYQnczUzJMMHBvQWtK?=
 =?utf-8?B?cXFJNzE2SzVVM1RRNm5iTS9TVjgwNUF6clRjSzF5U2x5bzQ0WlpVYURDWTBt?=
 =?utf-8?B?citUZG5rSkNVU1dLcTRMQWhlNVdRL3NOQnozZlM0SktIVW5pL25sUzNXV1Vu?=
 =?utf-8?B?MHB1dzZNdmVJaXpWdVFudGF4TSs2WGY1ekNOSjVFbHg2R3FlaGVodGFMWVdZ?=
 =?utf-8?B?VW51V2MyVjdKOElCRk1iQ05OWnY1VEdyR0h2RTJxSXBienBJWHh3OGE0S2xY?=
 =?utf-8?B?RWNCMXR6d0U4MUhsVVFtUGUwcjZnNlJVRGhFMHg3eGQ0TU9YMzhvdDFMcVBF?=
 =?utf-8?B?clBtWHlweWZEVDVnNTFhdXZvN2U0Qi80cEVjYkZZQ3VlSEJxNVFrckY3OGJu?=
 =?utf-8?B?Q1IzTkZZWmN1ZzVQRnhiNnFUbU9DNDRaUnYwUlhxMWlkS0RvT05GQmZldCt1?=
 =?utf-8?B?cG1aRVVCQjdRb1NFWEt4MG1kZEpuSyswQnB2ZHgrUTV0Z24zaGNHa0ZqdkRO?=
 =?utf-8?B?MHhpL1JLeEdsNkd4Ujk4UTEzeHpab1pzZm52Y3drNSs4U3N3RHNwUHIwcnRI?=
 =?utf-8?B?OVVVbSszYTJTZ2F3QzJZV1Y3ZEJtankzOVJGSHo0TWwwZnFYREthRWNXM3VB?=
 =?utf-8?B?YXZjeFB6WExCejB6TTQ5dHpXTS84a1NCZWI5bXZna0J3QVdMSkN0V0k4RXMw?=
 =?utf-8?B?dk04UDlhL09INThZbTBjTjc2Q3h1OXJLcWpvNHZRRkQxaFFPaGsxbXVlQU8w?=
 =?utf-8?B?L0NJZDIrZExwbFI5WXBmWjViaDVkZ20vV0xiZExPVWJIQTdMU04xUlFZYkY2?=
 =?utf-8?B?em9odzQ1ZDdrdWhIdTY2T3dnUzh1ZTV1WllWOGV4OXNyRi9idEpQQTQrSUZH?=
 =?utf-8?B?TThwVjhGUEd2bDdOMDJTeWg0ODZyUjVRcW1qaEY2WFhqTXpDZ1paSGF1c0NC?=
 =?utf-8?B?ek9Ra2Q5Sk1qNHhEd3Y4UnpYRi9EUVJteDAwL3pTemhiWUJFVWE0SUdRT1Nn?=
 =?utf-8?B?N0VaYTNQK1Uvb05wVFBEVnJMTGYrZWxPYlV0OVpoY2FEMmY1YzUrWjNVUU1n?=
 =?utf-8?B?QmZ4QjVVdHNldDBpYXVzV1Z4a3dGa0VlWjRLMTRNTFR0V0FFdzJteTNBa3p3?=
 =?utf-8?B?bWswcVhFQ2lFaGdveVc2ODJpVlJwdXBxbWRpazUrL1B4U1JGdWY0UlYzUlZl?=
 =?utf-8?B?eDIyM0NnUXJ2WWRLRGtGSWI4YzZnclEranVKM2hNYmI1Wjc2UTdlZ1ZMYVdo?=
 =?utf-8?B?T1R1TThuaDlOTEJ0am0vTzZFMm9rT01YNTBROWhhbFRMNGNsTTV4bnpUdnlI?=
 =?utf-8?B?SlgySGMvWjZpdHkyVWNWcnhSTDR4TC9jdGpJUE9xTVJJU0I0Q09QZWw2SDRo?=
 =?utf-8?B?OG9saVUrREg1dVhQRTVaTjZ0SDdmSEh6WjV4SjdyK09kM0M4WDBKcGhjVXF6?=
 =?utf-8?B?MDFtZythMjVFNnNtbXRDOTRKUTVTbE9yQkZPN1BVWS9EYURKUjhSM3lhZmxz?=
 =?utf-8?B?RXB5QlhjQnk2LzAxSkpNaFlHeUdZRmcvdUxKMllWd3A5Y2VheExNSXR1Yi9v?=
 =?utf-8?B?Z1V2bW9sYmxGVkRaditlT0ZpMnVoc1lXR3Bab2F5aFE4ZVhxWGtPZz09?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc210e4-7ea7-4e06-ec85-08de7e0e6331
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:02:19.6716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQyDZ1ZzCj/H/F1a8VVDl2o8gCC4ec+G+pyEkaLUNTZdaGqp6bcmVwlanAve5jNlgrcSpMw2ayRCE/BeX1cFqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PPFC21F75C41
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

Hi Santiago,

thanks for the bug report. I'll take a look at it.

kienan

On 3/9/26 1:12 PM, Santiago Vila via lttng-dev wrote:
> I forgot one detail which might help to debug the issue:
> 
> This started to happen in version 2.14.0.
> Version 2.13.15 worked ok.
> 
> Thanks.

