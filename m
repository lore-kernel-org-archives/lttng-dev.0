Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF902EB64DD
	for <lttng-dev@archiver.kernel.org>; Mon, 14 Aug 2023 18:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1692037559;
	bh=JBUeIj7u1HVWPpRyksYZbeMcR20g9Xd8ac1l1ZJ3Sf0=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=Nn8BtxbwIm6PZPKOAkg7VjuXc9eIuIYXg5wcBE0RbTtDv77hGvU6AKB5vsEqN9kt1
	 M+nZGNR7Fbk0B7SHPeH9uzLfjU6USaLhKbbky3S83bAgaTXK1s96XkgD/A8Fn9VoYa
	 Tcvbh5HtWNE9rM+uCACMkZHwsw+xXWi53sI2DURUzxrjbRp8A+WAU+jF5C9Dm8iDtC
	 yA4uxzPJagRZRczUiBmP5531rCikbrXGm7eQlO5JtrRPdv4fhTxea5aWK+pmRXMw5F
	 1qkUNAiY6NB5oB0Z09yCrQ/vOtnjm15DCCRBLO7Tm8z0IzUfHnjyOjrXvhQC6n/aal
	 3m6hoF8uLESRA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RPjWp4v9qz2M4L;
	Mon, 14 Aug 2023 14:25:58 -0400 (EDT)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2060.outbound.protection.outlook.com [40.107.116.60])
 by lists.lttng.org (Postfix) with ESMTPS id 4RPjWm6glnz2M4J
 for <lttng-dev@lists.lttng.org>; Mon, 14 Aug 2023 14:25:56 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6iMNuO4Let29Bi3s+eb2q1protuDPzWN/bkgWW93es868wIFN3FdTKIhmqopn2rytAbAF0USoOuCDvg3bbJG/Zo+4khVuQYFa86YbQpuJc2/Am+SttmdhYhKIEAYIxvGP6BqMXDZc6vDosB/Ro5DdfZ3SBVJMBwHxIH1+Y9on5fJs2VgqImdGzbqNiI7klwNNjUjPRizBmEpslQmGxCwKeAWtIbwh84lmxh+aGTR0jtiZdnJ4Up+B6eiOndMq66b27W5AvoxlSdDtrnQAKsHng3z9jumcDGxbi+EHoOlhBhp8Nflgde+sKUS3Uh/I6xXFQqr41ty0WstfraBh/DUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75aJZSoEw7n6I99nHn66FGIkc61efm8absRaxyiYnKU=;
 b=ORUjmNc8xzya6DEJBByn+qExLbI8+tQNUAuX8jpu2QPouAdZXfMaUdz9Nzv4eOxe4UqYP30fOJiWqoNKcUYxDE93xtIF2BoNuwlZS/cp4gwbQVX175npQDb4H5fBxJI79ZoZLQzuFxo71TX/wi+hQ40DOGzAjaqccNKCfAL+DD4pXyqQPxc3kWNZ4Ig2GdPGdPPx2rGasHtR2ZGQas32YD6mMGoriNTdLQkhT5yO5OenlZwy6CJNtbgHIbcdfVU94zOF88XlyMka+IGBJ/0Fq/TRHBqklFgguG8C+Lzelvyvk2qGmrwJXGqGsMVZfv7BYiLVKqJTiwlYu3TB6qMsIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB9879.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e3::15)
 by YT3PR01MB8611.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:78::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 18:25:50 +0000
Received: from YT4PR01MB9879.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::3d63:1c62:5a0:6e31]) by YT4PR01MB9879.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::3d63:1c62:5a0:6e31%7]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 18:25:50 +0000
Message-ID: <a3e409ae-10da-fec1-9fce-fa7629e243a8@efficios.com>
Date: Mon, 14 Aug 2023 14:25:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To: Bala Gundeboina <Bala.Gundeboina@kpit.com>, lttng-dev@lists.lttng.org
References: <MA0PR01MB6987563FB945A5A4C90312EE8516A@MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <MA0PR01MB6987563FB945A5A4C90312EE8516A@MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM>
X-ClientProxiedBy: YQZPR01CA0176.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::25) To YT4PR01MB9879.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB9879:EE_|YT3PR01MB8611:EE_
X-MS-Office365-Filtering-Correlation-Id: e0fd5529-8464-4fec-7c72-08db9cf3e30e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3SD9AMbLxCIcfLwdcrGIa96lCdGB1lFqGhjVZWzi0azCiFwBaa1QL6QvM12PBUKWtLxhpgGN7/YBtHxWSl5epjTtRICFAp79+UbSpNuto+SWps4hvcmCX/Kzx+Xazz+pHU8HCbm0HWiDCrKvNXNOEq+/KKBXCx9uJtDCRsTf7VwG7yOakNJdNJa5V09VkPhcZin57Q46qNnyQ5HUT5Qw65qyOGody33aXW6ILLW0dOGySarzzQ6wJo3Yo9GZDqMMKQjXat1vyAQCbNwvvfYy9OKWM0ex3Jz8mHoqgWN8IcyZgpAQgyhe2prwa3O/Y8ws2BMcFNGwb+hK/qu1JdoxZcIj0+HTsiqVDZqg7/QZU2YY+8gLaqAlQ/fHnX21N2MuqpjkFwigSxabCVr4ohFDg4mK+xsOHVA5AzlggC+kyMZSugjXzG62DdQyHHJ+IoGPGrOKBHqOmdHxe8Zcp5/m4gdPRHx2W1jzEMg1m27RHctvUqnQ8UWIS8X9akhyNn5xVMxsCanNodG3Ndu2mKJryw4Cb9+zSxmZVKNKg8NiJcXjFwkWof9iBFCtDcp/1zPskBuSwf4QH/K5RuXj/huRtrRjSFggQvumPpVFxUyeLyNhZoZ59qqQG+G8vQwJlei01SxWksMfET7eNRbT0aTIYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB9879.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(376002)(346002)(396003)(39830400003)(136003)(451199021)(186006)(1800799006)(6486002)(6512007)(966005)(2616005)(66574015)(478600001)(6506007)(53546011)(26005)(2906002)(316002)(5660300002)(66556008)(8936002)(66946007)(41300700001)(8676002)(66476007)(38100700002)(31696002)(86362001)(36756003)(83380400001)(31686004)(66899021)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUYzcmxmMzJPczF3dXRPdTdwUm4vK0tuSmpyTERLcjhnTWJUNXpSblVjTUYr?=
 =?utf-8?B?Tzk1eU1nUTZqYlB6M0x5akJUamF0dWhoQTVUMVdUd1BJaVB0NThPZU9SZ1hQ?=
 =?utf-8?B?NVVqa0kzZlA4UDhtU3ZPSDVZRldLbWo3eW5iWHo1VUZtSldtNWVvTGxuN25L?=
 =?utf-8?B?UTE3NitFUGczUXFERmpMcUVuZzhHVE8zTUVyU1N1Yi9ZTjV5YjhoN0JnZnZp?=
 =?utf-8?B?MWcraEVVUXBxN2pYNENxN2RnZUtQeFhHRjRxS2lFZnZCZGhuM1VyY0VzQXZi?=
 =?utf-8?B?RklEbXQ4NWF3NWdkL1g4NXZlc1hsMjNQQW5VUVlPMDBYa2pXaENwM0JiN1lC?=
 =?utf-8?B?U2RoQTlidjE3djNnakJkejRuRWRiWllCcm5tNllleGE0S1ZkNkl6d0dlQUFZ?=
 =?utf-8?B?d1Z3ajZGZE9sVitvcCtkQ0xiQy81SzJNVmFXSzRtcU1POVB4MElybWI1NE5y?=
 =?utf-8?B?ZnVTTlF5Z21XQVNmVXFpUDlyRWZoUnhKQU4ra2tVZ0plVGNkSFIwRi8wQTFB?=
 =?utf-8?B?amtzREFLSk8wQ3lrbTVFcnNONWdRaFV6SG5aMFZ6azZhVnlTWXVPZTRVblJU?=
 =?utf-8?B?eXNzZ1N1UnY4T2FOSW1xejloejV0UTBEaE85UTRiMkFBa3JYeFl2MEJxVU40?=
 =?utf-8?B?UURVS0FVRVBhK2RTN0lMNnpMZUozNXVnTlAxMlpmdUxpUWVDNDZha0s4VTk5?=
 =?utf-8?B?NDZJcXZzeHZQdkJoNDM2TittMTRTVWRKalJFMHdrSUozNlZ5R3RJbzhaNldu?=
 =?utf-8?B?OUhBd3YwUWNnZ2FIV0kxeUpocCtvcmVjQTZJOExtL3QzT2UwR3pFTnV3Zlpi?=
 =?utf-8?B?Unc5TDI3SWVhQkcxNmtNcGV5Q2pXUEl5RVVVOUYvWUVQVEhaVjNGVmdDZnV5?=
 =?utf-8?B?anVUZENsYkpPTzJyWEdnQW5zK1ZzMzJXRlBNSk9nMlhiUVFsSjY4NFhyT3Ay?=
 =?utf-8?B?TmQxd3g5c0FpUmZ0eU4xU0FlWWREOUF3TlJnbE5iVkk3bzFlUXJwT1FkSUM4?=
 =?utf-8?B?OUcyOG1KdHJNRTBHQVZWUVZwRXl0VzhOc2pENlBBaTJPb1RPZG1HaTd6TWlE?=
 =?utf-8?B?RFZPanV6ZE1lN0lqSjNsOXd2NmZyMURSTTkyamVGNS9udUUwc2EwTUJ6QnUz?=
 =?utf-8?B?N2E4VFBwU0JYYysvRDh4bFkyMFVLMlV1ajhJaVl0MkpqQjQvbUdmM1hBTXRQ?=
 =?utf-8?B?WC9NSmExRS9pUUxTaU55VTlDYXFyY1ovRFJjZnpLdDRtMThCS0JFcngxWW41?=
 =?utf-8?B?RDAxbXhnVFBBUURLWmlOQkpTK0lFMmVsbC9la1o1Yld4aFZGUG9vWFN3NFhq?=
 =?utf-8?B?MzN5OWk3VmV5L1dYelhLNGRTT2Vmd1c2UzY1bDdsUFlaRUREK0M5VkU5blQ4?=
 =?utf-8?B?Q2FYVzBXVFpYajFXd3M0VnhJdGpDRVppUlZxU09YUTlkK1hqckUzQ1QvRmYz?=
 =?utf-8?B?UXlPdUFDT09oeFNQaFlUTEpyWWtnay84UTNWMjRHSWkyLzFTSitVVkFYaVlz?=
 =?utf-8?B?ZzNoVE1KSFU0ek95Um1FMjZFQmorWmRaZnp0bW1xMVg0UUdvekUvSDJ3QWxV?=
 =?utf-8?B?d0QxQ1h3VWU0YTZob0ZSU3A5OVZVTHJESHJFcTBnNDVqbDBQRmU4Umt0TGZl?=
 =?utf-8?B?dXdPMkNacGZaTUNuTmV3djJkK3gvWG9BOS85anVzWDBudWJpQ2lrQ2ZCRzJq?=
 =?utf-8?B?dmpkWGd3SlNuRGFzd0ZLRDh1QVpWMEZxbEZNT2kyYzhGYWprVTFKeFgvUEV6?=
 =?utf-8?B?STZnNzZmQUFOSSt0T3RXTFlKcWlZeDZTdnFsOG12NjQwaXNZM0VYUktGVUdp?=
 =?utf-8?B?eWlaZFVjUlhFaUhCRmJsV1QxZHZ6cWhiZGJ1ajZzeEQ5NTRLMFJPMW01VUMw?=
 =?utf-8?B?QWtqRUZic1U5a212TVRsZkFTaVBrY2tGWXk4bjBjbE85L3V1ZFl6NUNTVzVX?=
 =?utf-8?B?aWlBWDAvdjN1RUZ2KzNBV29hd0dxZmIxMVM1ZTM4UDVPV1NycGVac21EcldZ?=
 =?utf-8?B?MjhMT1c3NklEenJ1bHcxR2x6UWVQcUlCSGFMckNxU05UaHRUR1I3QlJrVUN6?=
 =?utf-8?B?VjFIbFo2QlRoVXBjeTI4V0J5MTFYRzlDZHl1aDExSi9jNHIxbnhUdUIwa3N4?=
 =?utf-8?Q?4ycM2tBZ4Gpsrd6PMaoix0t0q?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fd5529-8464-4fec-7c72-08db9cf3e30e
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB9879.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 18:25:50.4797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUU79rwl3bJ3VuG9G7hJslpZLI/i2PjzyCV0hEnMM9bjEWMQI48PJG3MvqdcdNjsb4m1odEX8jZHVAo9rtq8jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8611
Subject: Re: [lttng-dev] Discarded events
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
From: Erica Bugden via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Erica Bugden <ebugden@efficios.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gMjAyMy0wOC0xMyAxMDo1OCwgQmFsYSBHdW5kZWJvaW5hIHZpYSBsdHRuZy1kZXYgd3JvdGU6
Cj4gSGksCj4gCj4gSSBhbSBVc2luZyBMVFRuZyBpbiBteSBwcm9qZWN0ICwgSSBhbSByZWNvcmRp
bmcgYSBrZXJuZWwgc2Vzc2lvbiBmb3IgCj4gbG9uZyBkdXJhdGlvbiAoZWcgbW9yZSB0aGFuIDE1
bWludXRlcykgSSBhbSBlbmFibGluZyBhbGwgdGhlIGV2ZW50cyBmb3IgCj4gcmVjb3JkaW5nIGJ1
dCBzb21lIGV2ZW50cyBkaXNjYXJkaW5nIGFmdGVyIHN0b3BwaW5nIHRoZSBzZXNzaW9uLCBpZiBp
IAo+IHJ1biBtb3JlIHRoYW4gNSBtaW51dGVzIG9ubHkgc29tZSBldmVudHMgYXJlIGRpc2NhcmRp
bmcuIEkgaGF2ZSB0cmllZCB0byAKPiBjaGFuZ2UgaW4gdGhlIC5sdHR0bmdyYyBmaWxlIGFsc28g
dG8gaW5jcmVhc2UgYnVmZmVyLXNpemUuCj4gCj4gbHR0bmcgZGVzdHJveQo+IERlc3Ryb3lpbmcg
c2Vzc2lvbiBgbXkta2VybmVsLXNlc3Npb25gLi4uCj4gU2Vzc2lvbiBgbXkta2VybmVsLXNlc3Np
b25gIGRlc3Ryb3llZAo+IFdhcm5pbmc6IDk0NDI0NjY3IGV2ZW50cyB3ZXJlIGRpc2NhcmRlZCwg
cGxlYXNlIHJlZmVyIHRvIHRoZSAKPiBkb2N1bWVudGF0aW9uIG9uIGNoYW5uZWwgY29uZmlndXJh
dGlvbgo+IAoKSGVsbG8gQmFsYSwKCkJhc2VkIG9uIG15IHVuZGVyc3RhbmRpbmcgb2YgdGhlIHNj
ZW5hcmlvLCBkaXNjYXJkZWQgZXZlbnRzIGFyZSB0byBiZSAKZXhwZWN0ZWQuIFJhdGhlciB0aGFu
IHRyeWluZyB0byBhdm9pZCBkaXNjYXJkZWQgZXZlbnRzLCBJIHdvdWxkIApyZWNvbW1lbmQgYWRq
dXN0aW5nIGhvdyBtdWNoIGRhdGEgaXMgYmVpbmcgY29sbGVjdGVkLiBJbiBtb3N0IHRyYWNpbmcg
CnVzZSBjYXNlcywgaXQgaXMgbm90IHJlbGV2YW50IHRvIGVuYWJsZSBhbGwga2VybmVsIHRyYWNl
cG9pbnRzIGZvciBhIApsb25nIHBlcmlvZCBvZiB0aW1lIChlLmcuIHNldmVyYWwgbWludXRlcykg
YXMgaXQgY2FuIHF1aWNrbHkgZ2VuZXJhdGUgYW4gCmVub3Jtb3VzIGFtb3VudCBvZiBub2lzeSBk
YXRhIHRoYXQgaXMgbmVhcmx5IGltcG9zc2libGUgdG8gc29ydCB0aHJvdWdoLiAKQXMgYSByZWZl
cmVuY2UsIGEgYnVzeSA4IGNvcmUgbWFjaGluZSBjb3VsZCBnZW5lcmF0ZSAxMDAgTUIvcyBvZiBk
YXRhLgoKVHlwaWNhbGx5IHdoZW4gdHJ5aW5nIHRvIHVuZGVyc3RhbmQgYSBwcm9ibGVtIGluIGRl
dGFpbCB3aXRoIHRyYWNpbmcsIAp5b3Ugd291bGQgc3RhcnQgd2l0aCBhIHZlcnkgc21hbGwgbnVt
YmVyIG9mIHRyYWNlcG9pbnRzIGVuYWJsZWQgZm9yIGEgCmxvbmdlciBwZXJpb2Qgb2YgdGltZSAo
d2l0aCB0aGUgZ29hbCBvZiBkZXZlbG9waW5nIGEgaGlnaC1sZXZlbCAKdW5kZXJzdGFuZGluZyBv
ZiB3aGVuL3doZXJlIHRoZSBwcm9ibGVtIGlzIGhhcHBlbmluZykuIFRoZW4gYXMgeW91IAppdGVy
YXRpdmVseSBuYXJyb3cgZG93biB3aGVuL3doZXJlIHRoZSBwcm9ibGVtIGhhcHBlbnMgeW91IGNh
biBncmFkdWFsbHkgCmluY3JlYXNlIHRoZSBudW1iZXIgb2YgcmVsZXZhbnQgdHJhY2Vwb2ludHMg
d2l0aG91dCBiZWluZyBvdmVyd2hlbG1lZCAKd2l0aCBkYXRhLgoKQSBnZW5lcmFsIHJ1bGUgb2Yg
dGh1bWIgaXMgdGhhdCBpZiB5b3UncmUgc3RvcmluZyB0cmFjZSBkYXRhIGZvciBhIGxvbmcgCnBl
cmlvZCBvZiB0aW1lIChlLmcuIG1vcmUgdGhhbiBhIG1pbnV0ZSkgdGhlbiB2ZXJ5IGZldyB0cmFj
ZXBvaW50cyAKc2hvdWxkIGJlIGVuYWJsZWQgKGUuZy4gMi01KS4gTWF4aW11bSB0cmFjaW5nIGRl
dGFpbCB3b3VsZCB0eXBpY2FsbHkgCm9ubHkgYmUgdXNlZCB0byB0cmFjZSBmb3IgYSBjb3VwbGUg
c2Vjb25kcyAob3IgaWRlYWxseSBsZXNzIGlmIHlvdSBjYW4gCmF1dG9tYXRlIHN0YXJ0aW5nIGFu
ZCBzdG9wcGluZyB0cmFjaW5nKS4KCkhlcmUgYXJlIHNvbWUgZ2VuZXJhbCByZWZlcmVuY2VzIGFi
b3V0IHRyYWNpbmcgc3RyYXRlZ3k6CiAgLSBXaGV0aGVyIHRyYWNpbmcgaXMgdGhlIGFwcHJvcHJp
YXRlIGFwcHJvYWNoOiAKaHR0cHM6Ly9naXRodWIuY29tL3R1eG9sb2d5L3RyYWNldml6bGFiL3Ry
ZWUvbWFzdGVyL2xhYnMvMDAxLXdoYXQtaXMtdHJhY2luZyN3aGVuLXRvLXRyYWNlCiAgLSBJdGVy
YXRpdmUgaW52ZXN0aWdhdGlvbiwgc2VsZWN0aW5nIHRyYWNlcG9pbnRzOiAKaHR0cHM6Ly93aWtp
LmxpbnV4Zm91bmRhdGlvbi5vcmcvcmVhbHRpbWUvZG9jdW1lbnRhdGlvbi9ob3d0by9kZWJ1Z2dp
bmcvZGVidWctc3RlcHMgCihSZWNvbW1lbmRlZCBzZWN0aW9uczogSXNvbGF0ZSB0aGUgc291cmNl
LCBUcmFjZSBkZXRhaWwpCgpIb3BlIHRoaXMgaGVscHMhCgpCZXN0LApFcmljYQoKPiBhY3R1YWxs
eSB3aGVuIGkgYW0gcnVubmluZyBiZWxvdyBjb21tYW5kIGkgYW0gZ2V0dGluZyBiZWxvdyB3YXJu
aW5nIGkgYW0gCj4gdGhpbmtpbmcgdGhpcyBpcyB0aGUgaXNzdWUgYmVjYXVzZSBzb21ldGltZXMg
dGhpcyB3YXJuaW5nIGlzIG5vdCBjb21pbmcgCj4gdGhhdCBpIGRpZG4ndCBzZWVuIGRpc2NhcmRl
ZCBldmVudHMuwqAgaG93IHRvIG92ZXJjb21lIHRoaXMgcHJvYmxlbSBjYW4gCj4geW91IHByb3Zp
ZGUgc29tZSBkZXRhaWxlZAo+IGx0dG5nLXNlc3Npb25kIC0tZGFlbW9uaXplCj4gV2FybmluZzog
RmFpbGVkIHRvIHByb2R1Y2UgYSByYW5kb20gc2VlZCB1c2luZyBnZXRyYW5kb20oKSwgZmFsbGlu
ZyBiYWNrIAo+IHRvIHBzZXVkby1yYW5kb20gZGV2aWNlIHNlZWQgZ2VuZXJhdGlvbiB3aGljaCB3
aWxsIGJsb2NrIHVudGlsIGl0cyBwb29sIAo+IGlzIGluaXRpYWxpemVkOiBGYWlsZWQgdG8gZ2V0
IHRydWUgcmFuZG9tIGRhdGEgdXNpbmcgZ2V0cmUKPiAKCkF0IGZpcnN0IGdsYW5jZSwgdGhpcyBl
cnJvciBzZWVtcyB1bnJlbGF0ZWQgdG8gd2hldGhlciBvciBub3QgZXZlbnRzIGFyZSAKZGlzY2Fy
ZGVkLgoKPiBUaGFua3MgJiBSZWdhcmRzCj4gQmFsYSBHdW5kZWJvaW5hCj4gVGhpcyBtZXNzYWdl
IGNvbnRhaW5zIGluZm9ybWF0aW9uIHRoYXQgbWF5IGJlIHByaXZpbGVnZWQgb3IgY29uZmlkZW50
aWFsIAo+IGFuZCBpcyB0aGUgcHJvcGVydHkgb2YgdGhlIEtQSVQgVGVjaG5vbG9naWVzIEx0ZC4g
SXQgaXMgaW50ZW5kZWQgb25seSAKPiBmb3IgdGhlIHBlcnNvbiB0byB3aG9tIGl0IGlzIGFkZHJl
c3NlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIAo+IHJlY2lwaWVudCwgeW91IGFyZSBu
b3QgYXV0aG9yaXplZCB0byByZWFkLCBwcmludCwgcmV0YWluIGNvcHksIAo+IGRpc3NlbWluYXRl
LCBkaXN0cmlidXRlLCBvciB1c2UgdGhpcyBtZXNzYWdlIG9yIGFueSBwYXJ0IHRoZXJlb2YuIElm
IHlvdSAKPiByZWNlaXZlIHRoaXMgbWVzc2FnZSBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUg
c2VuZGVyIGltbWVkaWF0ZWx5IGFuZCAKPiBkZWxldGUgYWxsIGNvcGllcyBvZiB0aGlzIG1lc3Nh
Z2UuIEtQSVQgVGVjaG5vbG9naWVzIEx0ZC4gZG9lcyBub3QgCj4gYWNjZXB0IGFueSBsaWFiaWxp
dHkgZm9yIHZpcnVzIGluZmVjdGVkIG1haWxzLgo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+IGx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmcKPiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21h
aWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0
dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8v
bHR0bmctZGV2Cg==
