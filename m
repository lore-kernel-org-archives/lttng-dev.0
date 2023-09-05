Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6BFC83F3E
	for <lttng-dev@archiver.kernel.org>; Tue,  5 Sep 2023 15:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1693927636;
	bh=zXbpjcgfMfrMuwe5SA/5PeX9WgPqiuU25FMdX2zzq5w=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=fqjpd5fOOT38VQ1CG9qiWtoCrleVpZcvLvWpUbFgpM7+cUMG/4Nvnd+ElJzwLmGCk
	 PHAj3Y9SkABncpIXGopZq8/r3BuLhgLgLYucVOH9WBrnHBoqjftA8Xs9XEenE5aPQM
	 w8v+DEDBn4j+qKmWirHerRVHo2SNnKnQL+2eyrry7wEzoPK+BNPxutYpT7ZJS5rbXR
	 NtHRhwxIWnSKhopnZpJ0Ndt1q4vXtBCpOlWPp73+pU+QTJ0BvXSGFPUCQ+iHjRe6wC
	 4bY+CUaxxZf3Cre9oAAbe+pZv03kix/sqPp8c8keVVbmcy2UdjurotLN2J8bWfha1s
	 +I/rAcalyes9g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Rg8WR2X12z2Vfk;
	Tue,  5 Sep 2023 11:27:15 -0400 (EDT)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2077.outbound.protection.outlook.com [40.107.115.77])
 by lists.lttng.org (Postfix) with ESMTPS id 4Rg8WP26Bsz2Vx5
 for <lttng-dev@lists.lttng.org>; Tue,  5 Sep 2023 11:27:13 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhL4ieMFhLJyJOzIC9o1o63Bc6QfErZwkTo0ChYWjAoPItoxHaiOGOZXhsrvzXTeMa432RsY9+6J9kUg08N/e1zVZWEMIemJvTiyaNIMzh/btvzsEnIkScI6fhHTEqg59hS2X65U2vW/+TYHBfk6tUO0HgyhHg7Xdr0WduBKI/xd9wvARVAQXOQUjAaIOYIISor8z5hJO9JZWPk/G8plQyk0MCTqN0hPFNJjH20CixcUy0hHbgA/6FNknFp8KS9cRAZPVZlpYU8kxOFf8bgNCwgk8/EhASov0TrWddADINhk2VlynhZuWmdsed4hRcaOUjTlh6m2BYcpkSU/8ZSwNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GAyHvoKHTJzyn8VfmgQR9SnpxExjSVV7+kHlFF8IPw=;
 b=cVRCir5oUnoSDYPQ+4XBQ6ZiCMrWqoPQn/JQfnIXq9KHIjUF9MjnnQ1asvXw7tKC2bZEHrWInrHK5VT/LgqW/KS+ScmXWrhFi7/+N7IPYvfiFdJFc9nYHh9BIoVowGjZlZn0b0/w0LrjoJlpw25Eq1JEy+M+zjfPfF66CQqzpGJgaNkpPTj1fTV7Y03J2F1WYZ+TrK3NXfGvQZbm31B6d1+pobC9KKNEz5e09JEnuuRXrTRagz1cTIol3JeFsMt7cf1CT+p2P9wxeSmrbJ3+dDxhelefVhQYkPG8CQCyjIqtnc+Buc/HVWDPjHkOf8a9UctGlF+Q7UndaBrxm0/jJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:de::19)
 by YT2PR01MB6372.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 15:27:11 +0000
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e345:b283:97c2:82ef]) by YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e345:b283:97c2:82ef%7]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 15:27:10 +0000
Message-ID: <fb1c3dd1-1afd-ee89-797f-2e8e1c2b7cf8@efficios.com>
Date: Tue, 5 Sep 2023 11:27:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: lttng-dev@lists.lttng.org
References: <MW3PR12MB4555EFAAF7F86C5EFA8DB849D9E8A@MW3PR12MB4555.namprd12.prod.outlook.com>
Content-Language: en-US, fr-CA, en-CA
In-Reply-To: <MW3PR12MB4555EFAAF7F86C5EFA8DB849D9E8A@MW3PR12MB4555.namprd12.prod.outlook.com>
X-ClientProxiedBy: YQXPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::39) To YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:de::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9793:EE_|YT2PR01MB6372:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a9c0321-ffb8-43cd-d619-08dbae2492cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: keZoq2ZLYMNa0AXlHeetPRlSQOFAuMghYJTFpX5JbOkZh58OqUQQhWelUQnSCfYsQimcjDAN+nnVJ+HnkiFg3D8gotR+sSy7MRRGMJ6rPmW4s8dhTsA5tc5WgURntrys3TbwUlWZK0yKOJeNyztdUzZccgCIpq5h+BCpIyGJeA9zTHrodA79D1SvDjljJr9BzaNoxLjPiUaLY4YMyTduEM8jwGRMimdh/qPa5NemPqis0Uul/ozhjjVRU0fP5Q6s2jUFP1LaKw6krr3++bH3LTmnGdiSKsGih48yOLlJuACQpwtoRfMFevndnBfeo9mhHUBxI7cREqxj18SwM9mRdoZfsuw9doHrwHNWyzSI3CJatZAJpBelkZ2RGVmY7jVnRqVNXsU2NnB19bvqMlf4I9zNxH4dm7a9V+2ketqIYnPbx5Un4m4LZGPY8pikm6VCTONSYuDEBIcBKkwVUc8be3AB2Um4B61K7U4YOmzU89tAri1YwkRk50lAsuJfaGZuyaVfc8Fxhyd7iLjeiXmgDUsR+EeM4rrPdU7bo+FWE5mlgQiFWcpJ+uEPBTVUQQ7mDljNcJTl9IKbuP+r5MhHpdclS22gHlP58Fx6wawP2pGAlHp0zfZ6Nvzs61nk45WJf+ge+pbetj3gcT1cXobClUNHCqLc6rLwR5YOlqNOvAE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39830400003)(346002)(366004)(376002)(396003)(451199024)(186009)(1800799009)(31686004)(66556008)(66946007)(2906002)(36756003)(6916009)(316002)(31696002)(86362001)(66476007)(8936002)(5660300002)(8676002)(41300700001)(6512007)(2616005)(83380400001)(26005)(38100700002)(66899024)(966005)(478600001)(53546011)(6506007)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnJDbmJrSHVMdXVBK082ek5rc3NoTDVueWhhNDRiZFgxYm5hK0c2UXhBWWJB?=
 =?utf-8?B?WHlqcWJpQ3owSzZucUx5OUpyNlZPWmxGVnZmM3docitNdklBQWprQ0ZTREhS?=
 =?utf-8?B?NzY0YlViWERvVmw3RGNWT3RJc3lGbzAydmV5ZGlwUHRuNTM3Y3ZqbERCRXpS?=
 =?utf-8?B?SEhmRndVNmg0Y2xCWkdPMWNuTXFWRVJSZUFxcjlzZU05ZzMvR2xSU0E4dDF1?=
 =?utf-8?B?RWcrQmcwR1V3SmdzOWJkVm9WS2lNYVUwUzBnTC9OSm44SjJYVjJ1L2xuKzhs?=
 =?utf-8?B?UGRlR2lpTUs1VkVzbDVISUI5S2cyRUtSaGtmR0JXbWVHSlg1SEZ5NTJMNE5a?=
 =?utf-8?B?T3ZkZnpQbUpEcytzSlQxTHFhTk9aTUxDdGlUUm9UWWZxcHNMcEE4bWQxVjBx?=
 =?utf-8?B?eWh1RVRWdHNtMEc0TTVOdFZoekdXWjVjUkdHNHpVQlZpUGFJN3oyNW1VclFq?=
 =?utf-8?B?Wld1SW5ZNW9LUEFFYUk5di9YYTNLbHhjQU1GbzA5MlVLVVdhejY2WnhrcEl2?=
 =?utf-8?B?VXY0b1E2akxvQWp3QUZMZXR2MzZVNVBHYlNPbStRZTYyQ2xrbU5iOC82ZU43?=
 =?utf-8?B?RGtjUmlQaHpadVJmcUZWWkJRN3Q1cmRiMkFsVFZpV2lqVVVwV0FZUDQ1RlhZ?=
 =?utf-8?B?UlZ4R0FPNWl5Y1BGMjd6YkdkUHhVTGNNelQ1bktLbVRoMCs3QjZad0tYMjBi?=
 =?utf-8?B?RjJOQm5hTzlESnVRTVBrdjArRUp3NFNnTjJQL0M5MjRjY0J1WWNkRUxwK0d2?=
 =?utf-8?B?OFdObE5ZZjJWK2ozYXRxR0J2QlpQOFlwNitPVTFuTWxkbjNScUNVek9MQ1pU?=
 =?utf-8?B?K3RVTkJndCtQd1pzZmJKbkh0TTJaalc0NkNwY291bHRUTTFGU3hBd2VWWlVr?=
 =?utf-8?B?d3EzdnQ3a08yalN1c1NFQWgwL0ZJL1BWZDI4SVFWdncyWExpL3p0bXIxRlYz?=
 =?utf-8?B?Rmp6dGtvcGdwNnJvSEVUbmtMamc5WlNrVkxrRDAvd1hOVVNkZ1Z3ZVl5ZEFz?=
 =?utf-8?B?SVAwN2daYjdwVmUyVWFFam40UDA1SlNyT28wL2NpMUg0Q1k1eTQ1SkFOQk01?=
 =?utf-8?B?T1hvOWJLZHVIUjZVMEllMi83emtQMXVhT1BRdHFraTRqa3F6cG81Vk9NZHVO?=
 =?utf-8?B?cjQ0WGJKNFp2QWxKeGVRNEx0ekFjejRnV2pFc1VWS1ZlR3Q1RC9nWWptQ2wy?=
 =?utf-8?B?dmhxTW1rZW5qYzQ4RmFyMWNkUm5lL2NuS3dtYjZzN2orOFJ3cEp2MjR0NjZ3?=
 =?utf-8?B?eWhmVHFTOGtLT2Nxbkd5SEpvRmxRTHBjWkd6ZkVyREZ1L2EvaGVDN1o0R3pQ?=
 =?utf-8?B?V0c4dFZPbzVNTGJwb09ZSGVscENkY2UyV2poUHdvV0VwSmpVTzYxdmd1Z3Zy?=
 =?utf-8?B?MTgvWUVsRUFhMDM3Ym8zUFZSSWZ5NzhzM0ZxSTAvMk5FQWVmVndnK0doNjNF?=
 =?utf-8?B?Q2hBMnp0V01GSldZaVExbkZjQ0VGd0pENURVUWFIVkQwSi8xcHE3NnN4bWg4?=
 =?utf-8?B?K1pZc1E4MkNHRTMvK0dxRS9JMXQzaVNwb2pIM21MRWlOaDN5ZXhJOUFQWUto?=
 =?utf-8?B?QWRxZnFyYVM0cDFiSGRhbUp6WGk2R04zUjlUMHBvM2NjUk41elF3R2x6eU9Y?=
 =?utf-8?B?clB0cXdIa1lRUkg2dTQ4d0V3bnRiVjBnZFM2TWNZK2lXVG1QTVB2RlZLWlpT?=
 =?utf-8?B?OTRwakpBSkNOK3JyeTkyZXhQQVlhMDhYTFU5WjVOT3ZJc3FDVE5ybUl0K2da?=
 =?utf-8?B?ZE5MZUU4RWJsZG5GdkwxMG5PVzU1NEQ5dWFCUnQyNklEUFZRZ3VCZkx3bi81?=
 =?utf-8?B?b2lzNElCdVYwL0wyZ04zc1dxclZ5UGVYZTZCdk5sTFpNK3pSQlIvZ2gzRTB0?=
 =?utf-8?B?UWRMRXREV0pDdDRkN3hYMkYyRFZEelRrOVhEM0w0TWFSR0MvQlJ1Q2YrUjBL?=
 =?utf-8?B?QmJFakNkeGJiZ2FJQUsrSWJSblZBQlVpb0xaZzlsTjI2S3A0MkUxQStkSzNl?=
 =?utf-8?B?TWJKeklvR2JFK2lnTnVuQkFUQUpLajdDWCt3WFMxSGFmMWFYY0JMZHVrU3U4?=
 =?utf-8?B?d1daNVBScDJSclVTLzJjR0hIYnRZZng4a3FjblNxVHFZS3NWU2FUV0ptTWJZ?=
 =?utf-8?B?L0hzVFRDOGo4WW9XRGQ5dzlVcmczQkZFenBmV253Z1lQdVZrNDduRlN3a2x3?=
 =?utf-8?B?UFE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9c0321-ffb8-43cd-d619-08dbae2492cf
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 15:27:10.9301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQzZqHsGfG/a9TDFmiG30WXg4Gth4vpAVbIdSvef1WBrDMsC1/b3KdRFgy1u8NsoREJDwQu55tNV1t+nUDZCGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB6372
Subject: Re: [lttng-dev] LTTNG LIB UST Crash
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

SGkgTGFrc2htaSwKCmNvdWxkIHlvdSBwbGVhc2UgcHJvdmlkZSB1cyB3aXRoIHRoZSBzeXN0ZW0g
ZGV0YWlscyBhbmQgdmVyc2lvbiAKaW5mb3JtYXRpb24gZm9yIExUVG5nIHRvb2xzIGFuZCBVU1Q/
CgpUaGUgYnVnIHJlcG9ydGluZyBndWlkZWxpbmVzIHdoaWNoIGNvdmVyIHRoZSB0eXBlIG9mIGlu
Zm9ybWF0aW9uIApyZXF1aXJlZCB0byByZXNwb25kIGFkZXF1YXRlbHkgcXVlc3Rpb25zIGNhbiBi
ZSBmb3VuZCBoZXJlOiAKaHR0cHM6Ly9sdHRuZy5vcmcvY29tbXVuaXR5LyNidWctcmVwb3J0aW5n
LWd1aWRlbGluZXMKCkdpdmVuIHRoYXQgeW91IGFyZSBpbnN0cnVtZW50aW5nIGEgdXNlciBzcGFj
ZSBhcHBsaWNhdGlvbiwgZG8geW91IGhhdmUgYSAKbWluaW1hbCByZXByb2R1Y2VyIG9mIHRoZSBj
cmFzaCBpbmNsdWRpbmcgdGhlIGRldGFpbHMgb2YgaG93IHRoZSAKYXBwbGljYXRpb24gaXMgaW52
b2tlZCB0aGF0IHlvdSB3b3VsZCBiZSBhYmxlIHRvIHNoYXJlPwoKU29tZSB0eXBlcyBvZiB1c2Vy
IHNwYWNlIGFwcGxpY2F0aW9ucyByZXF1aXJlZCB0cmFjaW5nIGhlbHBlcnMgbG9hZGVkIAp2aWEg
TERfUFJFTE9BRC4gTW9yZSBpbmZvcm1hdGlvbiBjYW4gYmUgZm91bmQgaGVyZSAKaHR0cHM6Ly9s
dHRuZy5vcmcvZG9jcy92Mi4xMy8jZG9jLXByZWJ1aWx0LXVzdC1oZWxwZXJzCgpJZiB5b3UncmUg
dW5hYmxlIHRvIHNoYXJlIGNvZGUgb3Igb3RoZXIgbG9nIGZpbGVzIGR1ZSB0byBjb21wYW55IHBv
bGljeSwgCm9yIHJlcXVpcmUgcmVzcG9uc2VzIHdpdGhpbiBhIGd1YXJhbnRlZWQgdGltZSBmcmFt
ZSwgRWZmaWNpT1Mgb2ZmZXJzIApjb21tZXJjaWFsIHN1cHBvcnQgc2VydmljZXM6IGh0dHBzOi8v
d3d3LmVmZmljaW9zLmNvbS9zZXJ2aWNlcy8KCnRoYW5rcywKa2llbmFuCgpPbiAyMDIzLTA5LTA1
IDAyOjMwLCBMYWtzaG1pIERldmVya29uZGEgdmlhIGx0dG5nLWRldiB3cm90ZToKPiBIaSBBbGws
Cj4gCj4gSSBhbSBvYnNlcnZpbmcgbHR0bmcgY3Jhc2ggd2hpbGUgdHJ5aW5nIHRvIGludGVyZmFj
ZSBMVFRORyBmb3Igb25lIG9mIG15IAo+IHB5dGhvbjMgYXBwbGljYXRpb24uCj4gSSBqdXN0IHRy
aWVkIHRoZSBmb2xsb3dpbmcgdGhpbmdzLAo+IAo+IEFkZGVkICJpbXBvcnQgbHR0bmd1c3QgIiBp
biB0aGUgY29kZS4KPiAKPiAjIGx0dG5nIGNyZWF0ZSBjbGFnZAo+IFNlc3Npb24gY2xhZ2QgY3Jl
YXRlZC4KPiBUcmFjZXMgd2lsbCBiZSB3cml0dGVuIGluIC9yb290L2x0dG5nLXRyYWNlcy9jbGFn
ZC0yMDIzMDkwNS0wNjIyMTAKPiAKPiAjIGx0dG5nIGVuYWJsZS1ldmVudCAtLXB5dGhvbiBjbGFn
ZAo+ICNsdHRuZyBzdGFydAo+IAo+ICNzZXJ2aWNlIGNsYWdkIHN0YXJ0Cj4gKgo+ICoKPiAqY3Vt
dWx1cy1jb3JlOiBSdW5uaW5nIGNsLXN1cHBvcnQgZm9yIGNvcmUgZmlsZXMgCj4gImNsYWdkLXVz
dC45NTQxMC4xNjkzODk1MDYyLmNvcmUiKgo+IAo+ICMwIMKgMHgwMDAwN2YxMzRmYjkzOGViIGlu
IHJhaXNlICgpIGZyb20gL2xpYi94ODZfNjQtbGludXgtZ251L2xpYmMuc28uNgo+ICMxIMKgMHgw
MDAwN2YxMzRmYjdlNTM1IGluIGFib3J0ICgpIGZyb20gL2xpYi94ODZfNjQtbGludXgtZ251L2xp
YmMuc28uNgo+ICMyIMKgMHgwMDAwN2YxMzRmYjdlNDBmIGluID8/ICgpIGZyb20gL2xpYi94ODZf
NjQtbGludXgtZ251L2xpYmMuc28uNgo+ICMzIMKgMHgwMDAwN2YxMzRmYjhjMWEyIGluIF9fYXNz
ZXJ0X2ZhaWwgKCkgZnJvbSAKPiAvbGliL3g4Nl82NC1saW51eC1nbnUvbGliYy5zby42Cj4gIzQg
wqAweDAwMDA3ZjEzNGYxYTk2NzcgaW4gbHR0bmdfdXN0X2FkZF9mZF90b190cmFja2VyICgpIGZy
b20gCj4gL2xpYi94ODZfNjQtbGludXgtZ251L2xpYmx0dG5nLXVzdC5zby4wCj4gIzUgwqAweDAw
MDA3ZjEzNGYxYmRjZjQgaW4gbHR0bmdfdXN0X2VsZl9jcmVhdGUgKCkgZnJvbSAKPiAvbGliL3g4
Nl82NC1saW51eC1nbnUvbGlibHR0bmctdXN0LnNvLjAKPiAjNiDCoDB4MDAwMDdmMTM0ZjFiZjhk
ZSBpbiA/PyAoKSBmcm9tIC9saWIveDg2XzY0LWxpbnV4LWdudS9saWJsdHRuZy11c3Quc28uMAo+
ICM3IMKgMHgwMDAwN2YxMzRmYzhmOTU3IGluIGRsX2l0ZXJhdGVfcGhkciAoKSBmcm9tIAo+IC9s
aWIveDg2XzY0LWxpbnV4LWdudS9saWJjLnNvLjYKPiAjOCDCoDB4MDAwMDdmMTM0ZjFiZmY2YiBp
biBsdHRuZ191c3RfZGxfdXBkYXRlICgpIGZyb20gCj4gL2xpYi94ODZfNjQtbGludXgtZ251L2xp
Ymx0dG5nLXVzdC5zby4wCj4gIzkgwqAweDAwMDA3ZjEzNGYxYzA2MWEgaW4gZG9fbHR0bmdfdXN0
X3N0YXRlZHVtcCAoKSBmcm9tIAo+IC9saWIveDg2XzY0LWxpbnV4LWdudS9saWJsdHRuZy11c3Qu
c28uMAo+ICMxMCAweDAwMDA3ZjEzNGYxYjVjYTkgaW4gbHR0bmdfaGFuZGxlX3BlbmRpbmdfc3Rh
dGVkdW1wICgpIGZyb20gCj4gL2xpYi94ODZfNjQtbGludXgtZ251L2xpYmx0dG5nLXVzdC5zby4w
Cj4gIzExIDB4MDAwMDdmMTM0ZjFhYjZkMSBpbiA/PyAoKSBmcm9tIC9saWIveDg2XzY0LWxpbnV4
LWdudS9saWJsdHRuZy11c3Quc28uMAo+ICMxMiAweDAwMDA3ZjEzNGYxYWQ3ZWIgaW4gPz8gKCkg
ZnJvbSAvbGliL3g4Nl82NC1saW51eC1nbnUvbGlibHR0bmctdXN0LnNvLjAKPiAjMTMgMHgwMDAw
N2YxMzRmZjBkZmEzIGluIHN0YXJ0X3RocmVhZCAoKSBmcm9tIAo+IC9saWIveDg2XzY0LWxpbnV4
LWdudS9saWJwdGhyZWFkLnNvLjAKPiAjMTQgMHgwMDAwN2YxMzRmYzU1MDZmIGluIGNsb25lICgp
IGZyb20gL2xpYi94ODZfNjQtbGludXgtZ251L2xpYmMuc28uNgo+IAo+IAo+IFdoZW4gSSBzdG9w
IHRoZSBsdHRuZyBzZXNzaW9uLCBJIHNlZSBhbm90aGVyIGNvcmUKPiAKPiAjMCDCoDB4MDAwMDdm
YWQ5NTE5ODhlYiBpbiByYWlzZSAoKSBmcm9tIC9saWIveDg2XzY0LWxpbnV4LWdudS9saWJjLnNv
LjYKPiBbQ3VycmVudCB0aHJlYWQgaXMgMSAoVGhyZWFkIDB4N2ZhZDkzMzFmNzAwIChMV1AgMjIy
MTEwMykpXQo+IChnZGIpIGJ0Cj4gIzAgwqAweDAwMDA3ZmFkOTUxOTg4ZWIgaW4gcmFpc2UgKCkg
ZnJvbSAvbGliL3g4Nl82NC1saW51eC1nbnUvbGliYy5zby42Cj4gIzEgwqAweDAwMDA3ZmFkOTUx
ODM1MzUgaW4gYWJvcnQgKCkgZnJvbSAvbGliL3g4Nl82NC1saW51eC1nbnUvbGliYy5zby42Cj4g
IzIgwqAweDAwMDA3ZmFkOTUxODM0MGYgaW4gPz8gKCkgZnJvbSAvbGliL3g4Nl82NC1saW51eC1n
bnUvbGliYy5zby42Cj4gIzMgwqAweDAwMDA3ZmFkOTUxOTExYTIgaW4gX19hc3NlcnRfZmFpbCAo
KSBmcm9tIAo+IC9saWIveDg2XzY0LWxpbnV4LWdudS9saWJjLnNvLjYKPiAjNCDCoDB4MDAwMDdm
YWQ5NDdlOGQ5ZiBpbiA/PyAoKSBmcm9tIC9saWIveDg2XzY0LWxpbnV4LWdudS9saWJsdHRuZy11
c3Quc28uMAo+ICM1IMKgMHgwMDAwN2ZhZDk0N2U5OGUzIGluIHNobV9vYmplY3RfdGFibGVfZGVz
dHJveSAoKSBmcm9tIAo+IC9saWIveDg2XzY0LWxpbnV4LWdudS9saWJsdHRuZy11c3Quc28uMAo+
ICM2IMKgMHgwMDAwN2ZhZDk0N2U0ZDlhIGluIGNoYW5uZWxfZGVzdHJveSAoKSBmcm9tIAo+IC9s
aWIveDg2XzY0LWxpbnV4LWdudS9saWJsdHRuZy11c3Quc28uMAo+ICM3IMKgMHgwMDAwN2ZhZDk0
N2JhNmI1IGluIGx0dG5nX3Nlc3Npb25fZGVzdHJveSAoKSBmcm9tIAo+IC9saWIveDg2XzY0LWxp
bnV4LWdudS9saWJsdHRuZy11c3Quc28uMAo+ICM4IMKgMHgwMDAwN2ZhZDk0N2I0N2M2IGluID8/
ICgpIGZyb20gL2xpYi94ODZfNjQtbGludXgtZ251L2xpYmx0dG5nLXVzdC5zby4wCj4gIzkgwqAw
eDAwMDA3ZmFkOTQ3YjRiYWMgaW4gbHR0bmdfdXN0X29iamRfdW5yZWYgKCkgZnJvbSAKPiAvbGli
L3g4Nl82NC1saW51eC1nbnUvbGlibHR0bmctdXN0LnNvLjAKPiAjMTAgMHgwMDAwN2ZhZDk0N2I0
YmFjIGluIGx0dG5nX3VzdF9vYmpkX3VucmVmICgpIGZyb20gCj4gL2xpYi94ODZfNjQtbGludXgt
Z251L2xpYmx0dG5nLXVzdC5zby4wCj4gIzExIDB4MDAwMDdmYWQ5NDdiNGJhYyBpbiBsdHRuZ191
c3Rfb2JqZF91bnJlZiAoKSBmcm9tIAo+IC9saWIveDg2XzY0LWxpbnV4LWdudS9saWJsdHRuZy11
c3Quc28uMAo+ICMxMiAweDAwMDA3ZmFkOTQ3YjUzMDQgaW4gbHR0bmdfdXN0X29iamRfdGFibGVf
b3duZXJfY2xlYW51cCAoKSBmcm9tIAo+IC9saWIveDg2XzY0LWxpbnV4LWdudS9saWJsdHRuZy11
c3Quc28uMAo+ICMxMyAweDAwMDA3ZmFkOTQ3YjJiNzUgaW4gPz8gKCkgZnJvbSAvbGliL3g4Nl82
NC1saW51eC1nbnUvbGlibHR0bmctdXN0LnNvLjAKPiAjMTQgMHgwMDAwN2ZhZDk1NTEyZmEzIGlu
IHN0YXJ0X3RocmVhZCAoKSBmcm9tIAo+IC9saWIveDg2XzY0LWxpbnV4LWdudS9saWJwdGhyZWFk
LnNvLjAKPiAjMTUgMHgwMDAwN2ZhZDk1MjVhMDZmIGluIGNsb25lICgpIGZyb20gL2xpYi94ODZf
NjQtbGludXgtZ251L2xpYmMuc28uNgo+IAo+IAo+IENhbiB5b3UgcGxlYXNlIGhlbHAgaGVyZSBp
ZiBJJ20gbWlzc2luZyBzb21ldGhpbmcuIFRoaXMgaXMgYSBjcml0aWNhbCAKPiB0YXNrIGl0ZW0g
Zm9yIHVzIGJ1dCBhcmUgY3VycmVudGx5IHN0dWNrIHdpdGggbXVsdGlwbGUgbHR0bmcgY3Jhc2hl
cy4KPiAKPiBSZWdhcmRzLAo+IExha3NobWkKPiAKPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwo+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiBsdHRuZy1k
ZXZAbGlzdHMubHR0bmcub3JnCj4gaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWls
bWFuL2xpc3RpbmZvL2x0dG5nLWRldgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRu
Zy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0
dG5nLWRldgo=
