Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED498C0015E
	for <lttng-dev@archiver.kernel.org>; Tue,  1 Aug 2023 20:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1690921745;
	bh=Q7FiEKlIR1bd5TaLKF7h+A0AGIPYoC5HDBqJ10LkkQ8=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=RrtMxDMob92FmpXCCZ6VPbO44eajqoZEBWonZODrpiJfOs5mYcOm/m+zQo42Qef3j
	 5WbmCebskNzH/3jnwKU57361N/h7EORWE98V7fmMQPeDIVVHmCzXhYpOInzJ1YUZYz
	 WzHTMymrPn6NDZm7wuPT78kZ0PaDNlS2IFaLV39VB/AzM1OpWHHZMJ3xcUbMYbH2AP
	 a0M5TXnFGHEyWT6kMZ51/M5qW7Wv3hJpTTNsqZEeYO3xQrUsOH1AnOsib+vmcwsszh
	 oewZRrio1nslcnbiZ8cITWtT0v97s5LWecvP4C+ImnrcdVB00IIuUp8ACJYuNV1fae
	 2+muFmMvG94nA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RFmss6GH3z2GbS;
	Tue,  1 Aug 2023 16:29:05 -0400 (EDT)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:7052::610])
 by lists.lttng.org (Postfix) with ESMTPS id 4RFmsp1xtQz2GbQ
 for <lttng-dev@lists.lttng.org>; Tue,  1 Aug 2023 16:29:02 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQCzg0OH+dJPAPuvCNMei4C3lsOu3jjmDgcQQdZSBqJWWQ78x1f8ZN8enZ+vphKAO//JjUVF0EszUagHQXFXkRiCrG+TX2LJlMRW8G7CpYq08rAh3UoXiaK66MagTCDcH7ueBgghhAeyOL8BW5BcXXBoXp0VFY9n2T7jTko7r9J+dUevt+hBOo062SXnDrR5I+s6ZX0IPId/uHgyEYRz4kvzlCAODhWt4i95tCe0R3DG0DSa1DfUSvjDN99TBkX+FaD/Dm+i/+KZ8drwUKUiICz/MumA/IV7Gm2d04/7yf2arsk8TOKFWv21nEbm3r2Y2aRRq2fIlESQc210igXYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UI21jJD0XADFzicbbKXAoeuuFt5vyOq4BtnIqHV64GU=;
 b=Cqei7ewFVKkrOiq9Uxjqs1kUxyf0pLTA68c7feaD/LgQ0BS2C62hsPyYNXAxGDNulC97ajD3RQAuE/SLdxaqXfHqoYDGgCMb76YZSqpdYlMkz4E14itMvjhGCAIlPbmsJbnIPe9CiWxu2KS5BohQVA7pqrkkT3k32dR93y/ehTT/Q3ozP22yZbZMrcCcYwdkPAa7uK+oQ3VOGPj9NgZt4DzQRx0v1eD+YpNtcZZYCKxhEYj0NjENiPtxLtkbaoVWJjxfzW5LpVhW97CFxbDeTcNX37Bl3tudz2UwKZC5egzGajhbJIg6SADqFGvzmVV8oyZVsvElEzWzMJ8IHIgelQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQXPR01MB5082.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:1b::15)
 by YQXPR01MB5497.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:40::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 20:28:59 +0000
Received: from YQXPR01MB5082.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::db5a:38f5:2818:b2d9]) by YQXPR01MB5082.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::db5a:38f5:2818:b2d9%3]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 20:28:59 +0000
Message-ID: <41373769-12d4-56e1-0ae3-a464481770b1@efficios.com>
Date: Tue, 1 Aug 2023 16:28:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: "Cook, Layne" <Layne.Cook@ballaerospace.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <BN0P110MB0967334AFD6A7CF8DDD3BFBC9238A@BN0P110MB0967.NAMP110.PROD.OUTLOOK.COM>
 <a750cc37-76de-d717-3cce-d26974ca52ea@efficios.com>
 <BN0P110MB0967A44E8E48B2C03878D429920AA@BN0P110MB0967.NAMP110.PROD.OUTLOOK.COM>
In-Reply-To: <BN0P110MB0967A44E8E48B2C03878D429920AA@BN0P110MB0967.NAMP110.PROD.OUTLOOK.COM>
X-ClientProxiedBy: YQBPR01CA0164.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::27) To YQXPR01MB5082.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQXPR01MB5082:EE_|YQXPR01MB5497:EE_
X-MS-Office365-Filtering-Correlation-Id: 6017cdbb-cf38-4fef-2888-08db92cdf005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kRIvgXFa/kxzVvW44UGDaERxdCpq6EUkvYBWp8XEFMAIqH1CopiGi4VQ5DIefLPJE4BEUduRZMIAN9aRwaCSW6Iucxbk5kHQkJEeQlbgvr4G1ZdI+SEN4U5bTxRQU9CtukquYth2aVUzlLiAZA25+H+U158p0vZ0LOSiO2TZTbAj1kQ2wPRslAvFZDf3xTNUomfq0s+WBWybURVjQ5ITXQDsKHi2im3UIC07o4mj9APFYPKfpHnDCAfqUbTYeC8ZRq6pbj6VoXqRR65H556UEs+7y768MA/e92xvrkiqAy3imbWRmULL7Xjau3ajrtYZMrLzfBPfJsnZOuCT60yp6u32eTDyutLxRYUj8M5bvkQWhTwfXl0wvfVlzheS9aVLA5Ak72yW30RcLJgbt8pFmZBl7e7oxrgSoLaKq8G3uwpet+qD8Pgtm42/47a0CkI+H+aC9P+EzRmlbffc12WyFtwc5z3Bczk/TR2OZrIelZpYhQRLe2ec4w13JgUKusZuaDUPhGZARRj8S4FMrrC0QWNAREH8pUOIjRXFT2mpvfFSWShcDrZDA/cmhKb09WeVdJbuza5h0EsOR3rMsk9gH0CJbYIf+bz3A+cQgiBeuAQx+qV/DJQtYMjX1KSVIhzD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQXPR01MB5082.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(39830400003)(396003)(346002)(366004)(376002)(451199021)(66556008)(41300700001)(8676002)(5660300002)(66946007)(8936002)(31686004)(110136005)(2906002)(478600001)(316002)(66476007)(31696002)(86362001)(6512007)(6486002)(966005)(6506007)(83380400001)(53546011)(26005)(38100700002)(36756003)(186003)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTZoYVF1WXFYZEpaVUlzY2dPTnhhdG1EV29aUCtMTXZkZHRUZFBYck5NMW4w?=
 =?utf-8?B?clVtR1dkUUhXOGxybFZjaXdRZ2xUQ3ZlbDZ2NzNOMi9FNFNQOVluMk14Ykl6?=
 =?utf-8?B?N3JXZzlseWxlaFlRSUgyNGpFbkhtdk1zMWJVTzQrVk1EWGFPbEJhdjVWTXlE?=
 =?utf-8?B?RnE3WC9salJsVWRRdkVBN2ZsM1k2S3MreGZjMFRHVXVyU1JNQTBsQUlVdEhu?=
 =?utf-8?B?U1JJdjNlY3QzWTU3ajZYcHgweEw1eFd5RDFOYjlKV2VQMUpTaW0rVnJtN0NS?=
 =?utf-8?B?a1g2MmlTNGFkVkFzcnBkelAzOG5WN05IaGN6SEF6NWwzdk83TExGZDkyZ252?=
 =?utf-8?B?NjhxNkNNc2M5OUM1eW53VG11eUNvdEQvQ0ZZUGZsQkdKbXFWZ1JCK3cwUFEw?=
 =?utf-8?B?ZTJsdFZaS08wTVUxVnRCb0t3bHhuM2VwaUNVV3NUTzNIQ0tsTTVQV1NOc1h2?=
 =?utf-8?B?bVVmZFBNZ1RBTDl1endjL0VNTXpsQmF5dTZyK2ZSaHRVa2pPVUNERW5VaDRV?=
 =?utf-8?B?UzlvenVFb2JtbGwwWTJJT1Vzb1k2R1VURnAvR05WbHozbEZqR2t6TjNnNUht?=
 =?utf-8?B?azliM0NOWXcxeS9hWk1jVUFIT3VZQWJQVlFrTmV4YXhRZ1F2bHI4QzZnZlBQ?=
 =?utf-8?B?R0lISGp0azlkUWptRVNYZDVDaVMyS1Z5aEJrK2xSU2tiVHVrQUpQV1pBWS9x?=
 =?utf-8?B?ZTBhRDZ6Yjd6YXZvMDN1azVUOUl4K21Od0F2RXVVZ1NtNHJkQmNIOVNiMFNX?=
 =?utf-8?B?Y3VBVG1SWk8yRTFya2srNENlWHg2WVlRY0g5MGo2TTdrSlNSZGVaWUJkTXFO?=
 =?utf-8?B?T3dtZ1hURTFDaU1CTVhCalhyb1F5TkkrZ1ZwRmhMVmE1L21mNllsRkx2OUZE?=
 =?utf-8?B?Q2dZck5Ra1dlTlJCcGtFN3czakZBKzRBUE9mWnNXb1B6NGNESENsclBPQUM5?=
 =?utf-8?B?TDE3aDVZNlJJR3Y1bGJaNlZNb0FGU254OFJjdmFMRlZuM0dPRm9ZcWRzQ0xl?=
 =?utf-8?B?WUt6bkZHa0kzV1pPRnlsOTBjR0VMYWZqbU0walNkblN5M211SjhnRWhmK01X?=
 =?utf-8?B?Nzcva1hHbC91QVRwRGtxM2pDc1V4NlVJQnI5MzlhK09BZFVMM2R0RU0yT1ll?=
 =?utf-8?B?aUhLeEJ5eExGWUZUa3NwMFBkTlkzM1FlU25XOXFkOFJuQTEySGxKQVdvWWlH?=
 =?utf-8?B?VlE0Ukt5bysxY00vOU1tMENlOWFSeGd4cThUeUlVRUVIMDUyUmhQTmtvbWY3?=
 =?utf-8?B?dWE0RDUxa0FRSkhOSW82djBhUW56NWFTWjU1RzB0MGVRZ1h1VEp4ZzZvSURF?=
 =?utf-8?B?bDJKelFlVTd2UGdvTTFPamJYK2s0NDF3dUIyQ0FKb1daeWt5ZzFOb0x3Z2FO?=
 =?utf-8?B?M3d6c3Q3d3MwY3RrUjNPSTFTdU96ekZYRHlNcUF1S1REdlR3L3djT3VWMmh3?=
 =?utf-8?B?SHpBTTBldkdGOXVPUFFlSkpMbXc3ZzFYM25Ld0lSVUxycEY0UGlZRFJtUzJn?=
 =?utf-8?B?RXlZeHhZNXhzbGlaU1N2cU1WaGprbXVQNy8zRld3YW9TTkxoYzkyRjRRQ1Ir?=
 =?utf-8?B?SjZ2TkcwVDZaMFRZREJxS0tjUHZYRnJ4aVNHYWt3N21EMmk2dEFuZlc0VzBE?=
 =?utf-8?B?UVBBc2RjaDNWeEszYlJQNjRGMnhZQ2dIaFN4VzhzRDNrRUZqRmRRTkkzZFFY?=
 =?utf-8?B?NmZ6K0NGWThDNW9BMEdoNWdFR250aEdUY0dpNlZ1SkRlZlhWekNwT2NoY0dT?=
 =?utf-8?B?VldmVzNPZmphdzltWjZ5WUZYYk9tL1phM1N3dkxPRG5YWk53d3VLY25jVXFl?=
 =?utf-8?B?cDVnMzIyaitza3JWbldzTGFCSzJFU3FEQVk1Z2dTWHQyWDRWWXJlRTBYVEds?=
 =?utf-8?B?UDJUZ2lYRFZVSXNqa05QK2hYZzZ2ZGhCZXNDV2tsZmgvcEszNnJaK21JbEJD?=
 =?utf-8?B?VkloK040K2lWRTA5c1lybVorbmllTDVyQXUyUkZTN1F4V0djSnpXY0M2VDhZ?=
 =?utf-8?B?OHZsUGlLUGhRai8zeFltbndIVW9qRzRPR0lHc2RyVUJnMGdvd09SUnpiamQw?=
 =?utf-8?B?bXRtYjNtdUdUamhWTDJYa2FHSjcvdmJ0ZTlPTjNqb0xKaXM2MlB0dDlLazVj?=
 =?utf-8?B?SUNtODMzSXVmK2s4eFdqdVVRUkRtc1BkdDlRWXp4RjRUMFc4TVQ4RjVwVVIx?=
 =?utf-8?B?Wnc9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6017cdbb-cf38-4fef-2888-08db92cdf005
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB5082.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 20:28:59.7261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FxNVDAVXrbk8rlzrHjORxQOULqVQawllAFLy6v/uYFYrBF7MNk/CVescZoiJ4OArf8KKm2muLzfhYKmEG95s5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5497
Subject: Re: [lttng-dev] [EXTERNAL] Re: Status of LTTng-scope and
 Lttng-analyses
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
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gMjAyMy0wOC0wMSAxNDozNywgQ29vaywgTGF5bmUgdmlhIGx0dG5nLWRldiB3cm90ZToKPiBU
aGFua3MgZm9yIHRoZSByZXBseSBNYXRoaWV1LiBXZSBhcmUgZ29pbmcgdG8gZ28gd2l0aCBUcmFj
ZSBDb21wYXNzLgo+IAo+IENvdWxkIEkgaGl0IHlvdSB3aXRoIG9uZSBtb3JlIHF1ZXN0aW9uPyBJ
J3ZlIGJlZW4gdW5hYmxlIHRvIGZpbmQgYW4gYW5zd2VyIG9uIAo+IHRoZSB3ZWIuCj4gCj4gV2hl
biBJIGJ1aWxkIGx0dG5nLW1vZHVsZXMgdXNpbmcgdGhlIHNvdXJjZXMgYW5kIGluc3RydWN0aW9u
cyBmcm9tIGhlcmUgCj4gPGh0dHBzOi8vZ2l0aHViLmNvbS9sdHRuZy9sdHRuZy1tb2R1bGVzL2Js
b2IvbWFzdGVyL1JFQURNRS5tZCNrZXJuZWwtYnVpbHQtaW4tc3VwcG9ydD4sIGl0IGZhaWxzIGJl
Y2F1c2UgaXQgY2Fubm90IHNpZ24gdGhlIGtlcm5lbCBtb2R1bGVzIHdpdGgga2V5cy4gRHVyaW5n
IHRoZcKgICJtYWtlIG1vZHVsZXNfaW5zdGFsbCIgcGhhc2UsIGl0IGdpdmVzIHRoZXNlIG1lc3Nh
Z2VzIGZvciBlYWNoIG1vZHVsZToKPiAKPiBBdCBtYWluLmM6MTYwOgo+IC0gU1NMIGVycm9yOjAy
MDAxMDAyOnN5c3RlbSBsaWJyYXJ5OmZvcGVuOk5vIHN1Y2ggZmlsZSBvciBkaXJlY3Rvcnk6IAo+
IGNyeXB0by9iaW8vYnNzX2ZpbGUuYzo2OQo+IC0gU1NMIGVycm9yOjIwMDZEMDgwOkJJTyByb3V0
aW5lczpCSU9fbmV3X2ZpbGU6bm8gc3VjaCBmaWxlOiAKPiBjcnlwdG8vYmlvL2Jzc19maWxlLmM6
NzYKPiBzaWduLWZpbGU6IGNlcnRzL3NpZ25pbmdfa2V5LnBlbTogTm8gc3VjaCBmaWxlIG9yIGRp
cmVjdG9yeQo+ICDCoCBJTlNUQUxMIC9yb290L2x0dG5nLW1vZHVsZXMtbWFzdGVyL3NyYy9saWIv
bHR0bmctbGliLXJpbmctYnVmZmVyLmtvCj4gCj4gU3Vic2VxdWVudGx5LCB0aGUgbW9kdWxlcyBm
YWlsIHRvIGxvYWQgd2l0aCBhbiBlcnJvcjoKPiBtb2Rwcm9iZTogRVJST1I6IGNvdWxkIG5vdCBp
bnNlcnQgJ2x0dG5nX3JpbmdfYnVmZmVyX2NsaWVudF9kaXNjYXJkJzogUmVxdWlyZWQgCj4ga2V5
IG5vdCBhdmFpbGFibGUKPiAKPiBJJ20gYW0gaW5zdGFsbGluZyBvbiBhIFJIRUw4IHN5c3RlbS4g
SXMgdGhpcyBiZWNhdXNlIFJIRUw4IGlzIG5vdCBzdXBwb3J0ZWQgYXMgCj4gYW4gb2ZmaWNpYWwg
RW50ZXJwcmlzZSByZWxlYXNlPyBIYXZlIHRoZSBrZXlzIGFuZC9vciB0aGVpciBsb2NhdGlvbnMg
Y2hhbmdlZCAKPiBmb3IgUkhFTDg/Cj4gCj4gVGhhbmtzLAo+IAo+IExDCj4gbGF5bmUuY29va0Bi
YWxsYWVyb3NwYWNlLmNvbQoKSGksCgpUaGlzIHByb2JhYmx5IG1lYW5zIHRoYXQgeW91ciBtYWNo
aW5lIGlzIHJ1bm5pbmcgd2l0aCBVRUZJIFNlY3VyZSBCb290IAphY3RpdmF0ZWQsIGlmIGl0J3Mg
dGhlIGNhc2UgdG8gbG9hZCBvdXQgb2YgdHJlZSBtb2R1bGVzIHlvdSBlaXRoZXIgbmVlZCB0byAK
ZGlzYWJsZSBpdCBvciBjcmVhdGUgYSBzaWduaW5nIGtleSwgcmVnaXN0ZXIgaXQgaW4gdGhlIGZp
cm13YXJlIGFuZCBzaWduIHlvdXIgCm1vZHVsZXMgd2l0aCBpdC4KCkhlcmUgaXMgdGhlIFJlZGhh
dCBkb2N1bWVudGF0aW9uIG9uIHRoZSBzdWJqZWN0IFsxXS4KClsxXSAKaHR0cHM6Ly9hY2Nlc3Mu
cmVkaGF0LmNvbS9kb2N1bWVudGF0aW9uL2VuLXVzL3JlZF9oYXRfZW50ZXJwcmlzZV9saW51eC84
L2h0bWwvbWFuYWdpbmdfbW9uaXRvcmluZ19hbmRfdXBkYXRpbmdfdGhlX2tlcm5lbC9zaWduaW5n
LWEta2VybmVsLWFuZC1tb2R1bGVzLWZvci1zZWN1cmUtYm9vdF9tYW5hZ2luZy1tb25pdG9yaW5n
LWFuZC11cGRhdGluZy10aGUta2VybmVsI3NpZ25pbmcta2VybmVsLW1vZHVsZXMtd2l0aC10aGUt
cHJpdmF0ZS1rZXlfc2lnbmluZy1hLWtlcm5lbC1hbmQtbW9kdWxlcy1mb3Itc2VjdXJlLWJvb3QK
Ck1pY2hhZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8v
bGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
