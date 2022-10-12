Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDF0C4332F
	for <lttng-dev@archiver.kernel.org>; Wed, 12 Oct 2022 13:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1665580764;
	bh=Xzp4qLPSOQac9g6nGWGfG+NQ1g+/dDEBZSP4l5cgWz0=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=NXEHt/VTzbujTKjSULlLQOgqNjYhbjPhMsIfpiBJkrGrjTeETmZ/wZJqXuAtq+ExW
	 ELmdhbLM+wZOx9E1+89hJgQRZ14wixEi+FnmlZ3UuN4FNEFXY80sQfhODiyyiq6Rqj
	 YnyNgcmofjvEmgzusXvA7p3wy7qIQQ9qW8hJ+p7+xUqj3A7KJ04pj0VJ+w41NrQ24o
	 Sx/Pwg/0v33nMTysbKWKYj7ilyg5XHghAsT4FJY+QX3/F4gOWkAiftVhoe4mmR4FQ+
	 kGxNxj2i6DFs+od/OvlFTA9iPJjTmiHLKn6p0oiK2ZrXpCTckvu7d89syOXT6U6A4N
	 ruLmbsXHBUYTQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MnYCH4xlpz6Gs;
	Wed, 12 Oct 2022 09:19:23 -0400 (EDT)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2057.outbound.protection.outlook.com [40.107.116.57])
 by lists.lttng.org (Postfix) with ESMTPS id 4MnYCG3RjBz75T
 for <lttng-dev@lists.lttng.org>; Wed, 12 Oct 2022 09:19:22 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwGbZUGq+SwWrrVHObsnzQ5GrlVlIr8V8Jw3C6ZI91Fxroi0dhVZGPUAjbp+lCetFCqWdsU5Kx5I0tWdd49M25yc9E5WdxsGlZWtQomq04TXlQvIA5w2HeN2nhHyNuh22AmATSsFBA65Q3I4AG5Who5aYJE3aU98UHHJtrDdcryLZs2sIoptHkW2JQxOPyWtoclk+IEkGVKlequvtqCPYw6PBCR8EmNV0ZTrwbXs/vrf0Po/R0M7O3wRiRxj00FqyCYsb6E84ZiyEkMuNOgW/nEysUT6UU9+O7sJjF++DmJBDtrSVQSV7wOKvlrR4k14x5B7z2XkjKJKvZIsXyB4Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmdz4GeXqtsjV9RyRcBb1XxINYNQphrbuLPEYf2SwMw=;
 b=TpMU6zvmaoMU0C0XqaYddP87VjKsifESXj3yLoc73nfA8QRHudOXF0ptCyalsmGB8RF9JW2l6RZYPSEkxwGETsEsKVO5XZpejODAU22+L+oTj4XlNb3GMbKAO9SbFqrx0fZmIu4dUhLT6Xpz28SHtqkJtt33MM5+oDHwAqLaeGai6wqEDCjkW3WuQt/+VzPiouVEqE5WE+wb5Xc7+SeaAA6w8SfOAKGM6TqoHXRyeF+gqCuSw4hliqxJM1W/yn7X3K7Jrtyr9V9DZ3QgWYuvXXL0gVmbJrPjqcvJoglw8FPYDY98/UN3MpKl2WSOrOMpEvmQdJ/9MtyqONI+DfB+yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4e::11)
 by YQXPR01MB5786.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 13:19:21 +0000
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a05b:5150:ef:dede]) by YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a05b:5150:ef:dede%6]) with mapi id 15.20.5723.022; Wed, 12 Oct 2022
 13:19:20 +0000
Date: Wed, 12 Oct 2022 14:19:04 +0100
To: Alistair Francis <alistair.francis@opensource.wdc.com>
Cc: lttng-dev@lists.lttng.org, alistair23@gmail.com
Message-ID: <Y0a+yByE6vUtFc2P@efficios.com>
References: <20221007003918.344922-1-alistair.francis@opensource.wdc.com>
 <20221007003918.344922-2-alistair.francis@opensource.wdc.com>
Content-Disposition: inline
In-Reply-To: <20221007003918.344922-2-alistair.francis@opensource.wdc.com>
X-ClientProxiedBy: LO4P123CA0588.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::18) To YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:4e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB5984:EE_|YQXPR01MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: 427a1ff9-3120-418a-849d-08daac545f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HlQV1fmchjz+Fv63jYimt1wt05i8AgeXgU5nwwu5hvjRL5+vowYaac3Ejs4H6LGRDDK8i9aynfS9W3AYM1VE4Cie5+gjo1lgkFL14w+It+9KVT/RN4EIxz8w0S2PR2Y3AHx6itFECc29hg4MDbIKPstKNwm2PM4Vy3i0vZy9XDUMoL0kOr4FxgOqLpbS9Y6Bb0wDQEZM00AwTMrmKyz0chR2HlfcLmNsYYo5TlVN+3qDHIa+OOiOHGcPklz2FDl94yhrQfP0VdHzG1UdSuUXcCQaD9Z5+WypP25CH7p0okupHFqwQ7eAt5gk0LZJI/4OOX7bUurBKfP7s0l7x4ytcJ8YfVvuxLYxaD/cYjaFkloQK27tLxZPNnhZGDdzWOEhvKuEYJZavnZLlL/YK1U2XQayefnke/LFPQoyt4AEeVUa+remnUv3C5FGwfpAgMzybHACbo0NPtnxvqNqQxAg2oKPKZq6EPHvetBMeZvyH/j3c3qPVba6GyUkbWL4jBz7vgW6dWkHa0seFwghABYegvHIhmk981iMIZynKI3rpNMHBSvDJG59ZMe1PiUG5wJCYNjrsxBejp8BLUEjIwYCUXZEdSFGyq+qpQJh229sEwcJuDLe2v3CTjpsB/FcA2naAlxGnAssoaCveIAel7UdaGl7LF+2x0RdGQDFiswVyqCfDbqRw02fzMezUOgiyacr54l5+J5qOSz/KYB+D3/i1eKmrVO4viaS2ouF5hw6ifgoJrEwHoePqe58ORpPmdQwE07bbOJjOddGinUd0WBKPpXrmdkEGVlCJiRh9AVoqYM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230022)(396003)(34096005)(42606007)(366004)(136003)(346002)(376002)(39830400003)(451199015)(2906002)(8676002)(8936002)(66556008)(41300700001)(38100700002)(66476007)(36756003)(4326008)(66946007)(6512007)(5660300002)(6506007)(66574015)(478600001)(6666004)(186003)(966005)(6486002)(2616005)(316002)(6916009)(83380400001)(67856001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3Z1M2MybkJUSG54OUdQcW56d21zY2hxZHBSeEtNbkJNTU4vTW9FM2xTR1dj?=
 =?utf-8?B?dDN6dWdEMXI5bGQzeWFvTW91ckY2bEMxWkJHL0FsdEx2L0Z5ZlF5dW05OWtM?=
 =?utf-8?B?aUZEc2hTOVRxNzVtZ0Joc3c5RkRrUDZOMWtYQXVZNU1kNXN1OUlsUGp1dWRw?=
 =?utf-8?B?SVdUUW1HVDkyTDVCdG9BNkpPT25mUDFyWjQ3dGpOQjZHd0xqYzlNNU5jWFNE?=
 =?utf-8?B?U2JsMFBXcW9NVk1yOVB4Q0tzNE5KLzdrNjdxZGQ3WXhVUTZUOU52eEFkaWVy?=
 =?utf-8?B?bHc5RVB5MmN0cERXQytqVEVRL3dVL1l1RmE0OGREUE1YdnVaN0lDQm5SZmxo?=
 =?utf-8?B?UWlIQ0hyVlVlWVA1NVZ0NjlQNUNXNzVsKzRyZHdKTFVUZ2tUYW1LWC82R1pi?=
 =?utf-8?B?WEFaS242MGNMdkk5T3ZONEs0aUVjN281Q0ZlY2pGRHNETDdQZURjU0M3M2FZ?=
 =?utf-8?B?SlpkNzRXdUl5NFNWSUFrQjVFWDY0aHFSMDFCNVpHT2tzTUhTMEZ0OUpyaGFV?=
 =?utf-8?B?U1VnM3ZQTjlNQWFXcnhJSnV0aWVpWlB2a3J4RFVmNVVZaWRuWmVRam1sT1dK?=
 =?utf-8?B?RXdXQ0djdVRXV0RSYldGUWZOSStQY1hNZzhhQ1p5YUgrVXdVL3BJd0NUUGZ1?=
 =?utf-8?B?TmtPZGx6VmlROENXSGYzMXRDTUdSVGV5T2cwUUUzZTh5KzBiK3pQWWpnbjFU?=
 =?utf-8?B?ZUVqalV0bmRXdnU2WUd6Zmd5QUdxRlQrQ3VjVFBMeW5pTldOMUd0eml0U1B0?=
 =?utf-8?B?Q1ZLR0tQc25jakxJMnpRa245SGU2UkRNbWgvY2xNa1plaWZIYVlHZlQ0Y2Fn?=
 =?utf-8?B?MkptYkRXcCtHc2hpWFFSb3cwVDMxcUlOVnBaZ051ZUlVSmV2RUR2a0dJUlh5?=
 =?utf-8?B?SDVPM1lXTWpFU1QwejBQeU11cjB0dmQvUXJWQ2Joc28xYmtQSVZSWHlUY3JY?=
 =?utf-8?B?RytTZm16dTVpKzhPNkZ2d2I4MEdPbitPWVo4RjJPaGw0V3VCdzUxMnYvZStY?=
 =?utf-8?B?MmJKSEtRUkMvU1BhMmg3aEpIZmlNYjc3RnFpNTMwbDVsQW9naXJ0S3pNYlJ2?=
 =?utf-8?B?Z1B1K3hNMXY2ODdIbzN1NHh5MXhqL1kxQlJydHErV3FFK0Z1ZFhtMkwwT01z?=
 =?utf-8?B?N2xidmtwd2ZDNll5SHpQN1lmS1BQMzZZamNCV2hRYVBDTkNtZ0NDNThzRUVB?=
 =?utf-8?B?bVJpaFc1bXpvbk1nYnJPaFJXS0w5MklBdHdVdFVYQUFOa29oSnY4eXdEWEdp?=
 =?utf-8?B?UlNacnNBNDRuODV6REptWThxSlh3RXY4czJheTNSZlZlWHoyNXNGcWd2NTIr?=
 =?utf-8?B?bC90SzI5UnpadnVVbVc3biszb2NFb2ZJU3hzYXNZOExEQWJaNlZUR3dGZ2RU?=
 =?utf-8?B?bTRza2hKTFUya1B2N2ZLTjU3eVd0YW9zczloZHkxbmtjb0JURlZ6cVdFa3dF?=
 =?utf-8?B?WjFieTJwY2t4d0srRVRoS1JIbDNIWGZ5T3BsdTVUdDVHazZ4bDZGMU5uRWty?=
 =?utf-8?B?Nk9DWkRSTmU3UkVuRzkwTmU3SFAzSUxCa1hTNHVsODBkMkJLMUNFYjhzdmlM?=
 =?utf-8?B?cERnRnN3dnl0dmtQRzI4WE13Tjh3dm9GYUYzSmJlaU5HTjdLMkdubEIwVHNq?=
 =?utf-8?B?OGp4aGNjaHd1VUVGZWZLT0locjdoUll3RGFWSzhYcFc4QU1MUGg4Zm9XSmpZ?=
 =?utf-8?B?TmJ3OFdzaHJWNVhWMXVhQVZRUmtZWnlGbEdXeHZqdVFmOGJDdFJjbk5waWV1?=
 =?utf-8?B?ZG5VdDdVdUgzSk1hb3V5OUpIR25QejhYS3NwU0NyMXkraGJldERWQUxZa1Np?=
 =?utf-8?B?ZjlNbGpkL0VSTTVjRTlZQXEzczBlUytrbkhjOUVTNlF6WDN4RlpoQW9vQ2FI?=
 =?utf-8?B?UE85dVl1bUZheGZIMWhMcGNrNHZMcFZSRWNQdkVOSVQxNjhMaURsQXkxUy9L?=
 =?utf-8?B?Z1Z5Z2QydWx0VFZ1U3lqZ0tYNDhCaE8wL09POFozSmpONFFnZXhVaDlKdDkz?=
 =?utf-8?B?TVR5RnZlbEJ1YmxxODRsWi9GTk8vSTJzV3pmOGFIb3BLZlJLTkRnVzNIMThi?=
 =?utf-8?B?ZkJjS0hkZFloMGVsSTlFaDFNdjFvNXFzN1dZM3NzVFMrRENUQ1RrVDNxRUl2?=
 =?utf-8?B?ZXR0T2ZZN0dnVkw0WTVJMm9vZm5Pa3N0azN0aEYvdW1NZ1IxQStJQWRqbHFE?=
 =?utf-8?Q?PyiBoJlSKiIEgvXcbxnEfAl9PsZcJmgLFtJymEwg0Bgq?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427a1ff9-3120-418a-849d-08daac545f80
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 13:19:20.7865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: As7Qe9baVhFiypIxx0Fixg4PZBnfTPXtWVcmCOE87PNPZmWBwyxiKvzK331mvtowchmqjf46/Dd7yYIW2rmBgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5786
Subject: Re: [lttng-dev] [PATCH lttng-tools 2/2] Tests: select_poll_epoll:
 Add support for _time64
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gRnJpLCBPY3QgMDcsIDIwMjIgYXQgMTA6Mzk6MThBTSArMTAwMCwgQWxpc3RhaXIgRnJhbmNp
cyB2aWEgbHR0bmctZGV2IHdyb3RlOgoKSGkgQWxpc3RhaXIsCgpUaGUgZmlyc3QgcGF0Y2ggaXMg
Z29vZCwgSSdsbCBtZXJnZSBpdCBpbiBtYXN0ZXIuClNvbWUgY29tbWVudHMgb24gdGhpcyBwYXRj
aCBmb2xsb3cuCgo+IEZyb206IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2Rj
LmNvbT4KPiAKPiBBZGQgc3VwcG9ydCBmb3IgdGhlICA2NC1iaXQgdGltZV90IHN5c2NhbGxzIFNZ
U19wcG9sbF90aW1lNjQKPiBhbmQgU1lTX3BzZWxlY3Q2X3RpbWU2NC4KPiAKPiBUaGVzZSBhcmUg
dGhlIHN5c2NhbGxzIHRoYXQgZXhpc3QgMzItYml0IHBsYXRmb3JtcyBzaW5jZSB0aGUgNS4xIGtl
cm5lbC4KPiAzMi1iaXQgcGxhdGZvcm1zIHdpdGggYSA2NC1iaXQgdGltZV90IG9ubHkgaGF2ZSB0
aGVzZSBhbmQgZG9uJ3QgaGF2ZSB0aGUKPiBvcmlnaW5hbCBzeXNjYWxscyAoc3VjaCBhcyAzMi1i
aXQgUklTQy1WKS4KPiAKPiBGaXhlczogaHR0cHM6Ly9naXRodWIuY29tL2x0dG5nL2x0dG5nLXRv
b2xzL3B1bGwvMTYyCj4gU2lnbmVkLW9mZi1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIu
ZnJhbmNpc0B3ZGMuY29tPgo+IC0tLQo+ICB0ZXN0cy9yZWdyZXNzaW9uL2tlcm5lbC9zZWxlY3Rf
cG9sbF9lcG9sbC5jcHAgfCA1MyArKysrKysrKysrKysrKysrKysrCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA1MyBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3JlZ3Jlc3Npb24va2Vy
bmVsL3NlbGVjdF9wb2xsX2Vwb2xsLmNwcCBiL3Rlc3RzL3JlZ3Jlc3Npb24va2VybmVsL3NlbGVj
dF9wb2xsX2Vwb2xsLmNwcAo+IGluZGV4IGMwYjY4ODIxNy4uNGE2ZDM5NGY0IDEwMDY0NAo+IC0t
LSBhL3Rlc3RzL3JlZ3Jlc3Npb24va2VybmVsL3NlbGVjdF9wb2xsX2Vwb2xsLmNwcAo+ICsrKyBi
L3Rlc3RzL3JlZ3Jlc3Npb24va2VybmVsL3NlbGVjdF9wb2xsX2Vwb2xsLmNwcAo+IEBAIC01LDYg
KzUsNyBAQAo+ICAgKgo+ICAgKi8KPiAgCj4gKyNpbmNsdWRlIDxlcnJuby5oPgo+ICAjaW5jbHVk
ZSA8ZmNudGwuaD4KPiAgI2luY2x1ZGUgPGxpbWl0cy5oPgo+ICAjaW5jbHVkZSA8cG9sbC5oPgo+
IEBAIC00NTYsOCArNDU3LDIyIEBAIHZvaWQgcHBvbGxfZmRzX2J1ZmZlcl9vdmVyZmxvdygKPiAg
CXVmZHNbMF0uZmQgPSB3YWl0X2ZkOwo+ICAJdWZkc1swXS5ldmVudHMgPSBQT0xMSU58UE9MTFBS
STsKPiAgCj4gKyNpZmRlZiBTWVNfcHBvbGxfdGltZTY0Cj4gKwkvKgo+ICsJICogQXMgdGhlcmUg
aXMgbm8gdGltZW91dCB2YWx1ZSwgd2UgZG9uJ3QgY29udmVydCB0by9mcm9tCj4gKwkgKiA2NC8z
Mi1iaXQgdGltZV90Lgo+ICsJICovCj4gKwlyZXQgPSBzeXNjYWxsKFNZU19wcG9sbF90aW1lNjQs
IHVmZHMsIDEwMCwgTlVMTCwgTlVMTCk7Cj4gKwlpZiAocmV0ID09IDAgfHwgZXJybm8gIT0gRU5P
U1lTKSB7Cj4gKwkJZ290byBwcG9sbF9mZHNfYnVmZmVyX292ZXJmbG93X2RvbmU7Cj4gKwl9Cj4g
KyNlbmRpZgo+ICsKClRoaXMgcmVzdWx0cyBpbiB0aGUgZm9sbG93aW5nIHdhcm5pbmcgd2hlbiBi
dWlsZGluZyBmb3IgYW4gYXJjaGl0ZWN0dXJlCnRoYXQgZG9lc24ndCBoYXZlIFNZU19wcG9sbF90
aW1lNjQgZGVmaW5lZDoKCmxhYmVsIOKAmHBwb2xsX2Zkc19idWZmZXJfb3ZlcmZsb3dfZG9uZeKA
mSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtbGFiZWxdCnBwb2xsX2Zkc19idWZmZXJf
b3ZlcmZsb3dfZG9uZToKXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CnNlbGVjdF9wb2xs
X2Vwb2xsLmNwcDogSW4gZnVuY3Rpb24g4oCYdm9pZCBwcG9sbF9mZHNfdWxvbmdfbWF4KEZJTEUq
KeKAmToKCgpBbHNvLCBpdCBpcyBteSB1bmRlcnN0YW5kaW5nIHRoYXQgYm90aCBzeXNjYWxscyBj
YW4gYmUgYXZhaWxhYmxlIG9uIHNvbWUKcGxhdGZvcm1zLiBJbiB0aGF0IGNhc2UsIGl0IHdvdWxk
IG1ha2Ugc2Vuc2UgdG8gYWRkIHRoZW0gYXMgc2VwYXJhdGUKdGVzdHMgYW5kIHNraXAgdGVzdHMg
dGhhdCB0YXJnZXQgbm9uLWV4aXN0YW50IHN5c2NhbGxzLgoKVGhhbmtzIQpKw6lyw6ltaWUKCgo+
ICsjaWZkZWYgU1lTX3Bwb2xsCj4gIAlyZXQgPSBzeXNjYWxsKFNZU19wcG9sbCwgdWZkcywgMTAw
LCBOVUxMLCBOVUxMKTsKPiArI2VuZGlmCj4gIAo+ICtwcG9sbF9mZHNfYnVmZmVyX292ZXJmbG93
X2RvbmU6Cj4gIAlpZiAocmV0IDwgMCkgewo+ICAJCVBFUlJPUigicHBvbGwiKTsKPiAgCX0gZWxz
ZSBpZiAocmV0ID4gMCkgewo+IEBAIC00ODMsNyArNDk4LDIyIEBAIHZvaWQgcHBvbGxfZmRzX3Vs
b25nX21heChGSUxFICp2YWxpZGF0aW9uX291dHB1dF9maWxlIF9fYXR0cmlidXRlX18oKHVudXNl
ZCkpKQo+ICAJdWZkc1swXS5mZCA9IHdhaXRfZmQ7Cj4gIAl1ZmRzWzBdLmV2ZW50cyA9IFBPTExJ
TnxQT0xMUFJJOwo+ICAKPiArI2lmZGVmIFNZU19wcG9sbF90aW1lNjQKPiArCS8qCj4gKwkgKiBB
cyB0aGVyZSBpcyBubyB0aW1lb3V0IHZhbHVlLCB3ZSBkb24ndCBjb252ZXJ0IHRvL2Zyb20KPiAr
CSAqIDY0LzMyLWJpdCB0aW1lX3QuCj4gKwkgKi8KPiArCXJldCA9IHN5c2NhbGwoU1lTX3Bwb2xs
X3RpbWU2NCwgdWZkcywgVUxPTkdfTUFYLCBOVUxMLCBOVUxMKTsKPiArCWlmIChyZXQgPT0gMCB8
fCBlcnJubyAhPSBFTk9TWVMpIHsKPiArCQlnb3RvIHBwb2xsX2Zkc191bG9uZ19tYXhfZG9uZTsK
PiArCX0KPiArI2VuZGlmCj4gKwo+ICsjaWZkZWYgU1lTX3Bwb2xsCj4gIAlyZXQgPSBzeXNjYWxs
KFNZU19wcG9sbCwgdWZkcywgVUxPTkdfTUFYLCBOVUxMLCBOVUxMKTsKPiArI2VuZGlmCj4gKwo+
ICtwcG9sbF9mZHNfdWxvbmdfbWF4X2RvbmU6Cj4gIAlpZiAocmV0IDwgMCkgewo+ICAJCS8qIEV4
cGVjdGVkIGVycm9yLiAqLwo+ICAJfSBlbHNlIGlmIChyZXQgPiAwKSB7Cj4gQEAgLTUyNCw3ICs1
NTQsMTggQEAgdm9pZCBwc2VsZWN0X2ludmFsaWRfZmQoRklMRSAqdmFsaWRhdGlvbl9vdXRwdXRf
ZmlsZSBfX2F0dHJpYnV0ZV9fKCh1bnVzZWQpKSkKPiAgCUZEX1pFUk8oJnJmZHMpOwo+ICAJRkRf
U0VUKGZkLCAmcmZkcyk7Cj4gIAo+ICsjaWZkZWYgU1lTX3BzZWxlY3Q2X3RpbWU2NAo+ICsJcmV0
ID0gc3lzY2FsbChTWVNfcHNlbGVjdDZfdGltZTY0LCBmZCArIDEsICZyZmRzLCBOVUxMLCBOVUxM
LCBOVUxMLCBOVUxMKTsKPiArCWlmIChyZXQgPT0gMCB8fCBlcnJubyAhPSBFTk9TWVMpIHsKPiAr
CQlnb3RvIHBzZWxlY3RfaW52YWxpZF9mZF9kb25lOwo+ICsJfQo+ICsjZW5kaWYKPiArCj4gKyNp
ZmRlZiBTWVNfcHNlbGVjdDYKPiAgCXJldCA9IHN5c2NhbGwoU1lTX3BzZWxlY3Q2LCBmZCArIDEs
ICZyZmRzLCBOVUxMLCBOVUxMLCBOVUxMLCBOVUxMKTsKPiArI2VuZGlmCj4gKwo+ICtwc2VsZWN0
X2ludmFsaWRfZmRfZG9uZToKPiAgCWlmIChyZXQgPT0gLTEpIHsKPiAgCQkvKiBFeHBlY3RlZCBl
cnJvci4gKi8KPiAgCX0gZWxzZSBpZiAocmV0KSB7Cj4gQEAgLTU1Myw4ICs1OTQsMjAgQEAgdm9p
ZCBwc2VsZWN0X2ludmFsaWRfcG9pbnRlcigKPiAgCUZEX1pFUk8oJnJmZHMpOwo+ICAJRkRfU0VU
KHdhaXRfZmQsICZyZmRzKTsKPiAgCj4gKyNpZmRlZiBTWVNfcHNlbGVjdDZfdGltZTY0Cj4gKwly
ZXQgPSBzeXNjYWxsKFNZU19wc2VsZWN0Nl90aW1lNjQsIDEsICZyZmRzLCAoZmRfc2V0ICopIGlu
dmFsaWQsIE5VTEwsIE5VTEwsCj4gKwkJCU5VTEwpOwo+ICsJaWYgKHJldCA9PSAwIHx8IGVycm5v
ICE9IEVOT1NZUykgewo+ICsJCWdvdG8gcHNlbGVjdF9pbnZhbGlkX3BvaW50ZXJfZG9uZTsKPiAr
CX0KPiArI2VuZGlmCj4gKwo+ICsjaWZkZWYgU1lTX3BzZWxlY3Q2Cj4gIAlyZXQgPSBzeXNjYWxs
KFNZU19wc2VsZWN0NiwgMSwgJnJmZHMsIChmZF9zZXQgKikgaW52YWxpZCwgTlVMTCwgTlVMTCwK
PiAgCQkJTlVMTCk7Cj4gKyNlbmRpZgo+ICsKPiArcHNlbGVjdF9pbnZhbGlkX3BvaW50ZXJfZG9u
ZToKPiAgCWlmIChyZXQgPT0gLTEpIHsKPiAgCQkvKiBFeHBlY3RlZCBlcnJvci4gKi8KPiAgCX0g
ZWxzZSBpZiAocmV0KSB7Cj4gLS0gCj4gMi4zNy4zCj4gCj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gbHR0
bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4v
bWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMu
bHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5m
by9sdHRuZy1kZXYK
