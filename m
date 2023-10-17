Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62EACDB474
	for <lttng-dev@archiver.kernel.org>; Tue, 17 Oct 2023 15:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1697557162;
	bh=YYL3JGERNjnCKjzgiv7+prxbXS2U9kANz3VnxN8fNWE=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=j5kx27lWI0fESGxNwSFXuKmZgy6XkSGMR+dPovdHLlPIMRO5PlkPJqgEEsmyHJl+9
	 zeW3F6P8/86rmn7fllLO2lAi54aznAH5ilfEkWtBaI6aYq6ls/TmmRqmilM8VgGoOt
	 P7NoaHOWocftxU6NAsYiyyWqqrgKS4K1r8cLKlud4YSfVOmP2kmc8jrY7apWdbJNCk
	 Y1XQ+aPLuRCWFX9fLAVEKhkpUpGoJlA2GUU/0jrPKdaHrEM009OqxpgaAIgjhhX8YD
	 08C4f1Pt5J0KGes0Ek5pZVMSD42pw/rJnicdmFZ+62+NPij8WGxqpb3EhpYPhEU5ls
	 Jw6yzHw+xPAqg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4S8yp1670mz2q8;
	Tue, 17 Oct 2023 11:39:21 -0400 (EDT)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2050.outbound.protection.outlook.com [40.107.115.50])
 by lists.lttng.org (Postfix) with ESMTPS id 4S8yny2MB8z2mT
 for <lttng-dev@lists.lttng.org>; Tue, 17 Oct 2023 11:39:18 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvm2oDAdXpavVb2hKQogDLTqwULu8EJw0/90UVnEzRfqwWK2aVzIGBCBvkY1sLBPCr+ntH9HrfY4cAVu6dA5oPH3ikB4k8bdHRM+zVTpPiClQ3JTrxO+uzwYCZrAnYEg1EXg1pI9dAKTUs59GDRo6dhNQf7t8zK5lFP0ZUNv2JtfitIYcGH8nv+Pe8xrY2P+OD+GHNWRBC0haaOoi0EoHwoKbcABLpkxDkL4/r70XPOwr/12sA/fvQhlIoJNQNjMzpTUXGki9ggZgeZg/16K3Q0IdAiz4I9L4B4m6dGCFWHd3GbPe5sHGU/0hSkq+ypOMHZ3Ib42tFhSRkgIBC6JgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lmE4OLApGVbQidY3DA4WOtswmZbBPNnb78jz9r2+H0=;
 b=cvTuTRlASRveDiG8/AaMYygLvrsL8pumpWbowFt8VDFHEHtiwNNd55083NTPZI0gwIPNVv7W1CKjmXcbjTlJ+6443KPxBVMyfciv3TW2MTocnLFB+wp/jNDeLoMz1ctoe3a65FTmpxYsFbbSfiQxkQoB85ENo2URNCo0Wx5cYE5qt7fpO6gA7yTWYJ+0eJVR8tsB9huCk91UaQfR5DQ7UwZGOZeSpvSTsfHBp/EQ5Fty2Gc4JWYTTAUyXzaChnqYuVX0Ds5qArBDLeV9PbH9sRcTTTNxjStU3wq+aMZ8ONuzcxP9lmD+roJoNxFW9OeGTAWEUdqnKckor7bRBcAbHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:de::19)
 by YT3PR01MB5250.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:62::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.37; Tue, 17 Oct
 2023 15:39:16 +0000
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ff6e:51dc:2551:82dd]) by YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ff6e:51dc:2551:82dd%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 15:39:16 +0000
Message-ID: <bb1999cc-2156-4d92-b15e-21866ffc1f54@efficios.com>
Date: Tue, 17 Oct 2023 11:39:14 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US, fr-CA, en-CA
To: "Kramer, Zach" <Zach.Kramer@cognex.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <SN6PR06MB426922F9DBACE81D0C6B66A591C3A@SN6PR06MB4269.namprd06.prod.outlook.com>
 <f0437833-964c-4aee-a52b-e79fd89540fc@efficios.com>
 <c24c1489-c3a4-46e8-b91f-9da212081065@efficios.com>
 <SN6PR06MB42691D97E72B2F5835A5D76991CEA@SN6PR06MB4269.namprd06.prod.outlook.com>
In-Reply-To: <SN6PR06MB42691D97E72B2F5835A5D76991CEA@SN6PR06MB4269.namprd06.prod.outlook.com>
X-ClientProxiedBy: YQBPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::21) To YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:de::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9793:EE_|YT3PR01MB5250:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ba561a-e590-4297-bb1e-08dbcf273857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M7BWVkA1Ixc9um2hz3ryoaaYivOxPYuslKkaTbjFsy8R7UKuA5DxATH/avn8k3N1ee/4JltR2Lvx8mZEP1lmcsLa/U7GP2t7o4uT8zlVN/0Brq25sbGGALyb2ovQTjLIasZ83o7k20lNuoHJNhoIlO1E9QNEyC/Fj5n9zq7YYQo+E5eei4ZM6B+C5H+d9vchfnDOwHQlUk0dXnNyAH6B2cc3jQry22Bw31/HFkzcj1UkYHNSEl+nxogjHRKzJiNVC6YFDQZpA8aHeqq9q/8FN2cde3WxwpGDXb0jVEvlraPYYqa2ty6ViwfgpErlmG+8+t9ePd5hoZlYa7DwB20+LP0z7hzu/4mwhccOPde1ruKdF42hrfRKWBeh2OjizsQrOCCAgb0QHKfTFryOQI2FPER8tEgx9BTXjW/CY/UsA5OIPDZdznTH68c7T3rSoBY02t/4rR13cAzGUMS6KExYmCl14LaAi2mni84aFUIwIon5gzAzTmIt+SDKCVrqunEkq/WSJ6u4O1XDJQgOv28XJNHQofRs60JoNgApgjzErSrShWmGGMnSFu3rabGcgPxXwMFGfzJiqMzwVp0fX4jWCJTttFE/bafzszYIIxE3O/YLql1/GPfe/F8fDaUMuSQDhjLRXjPfQYqL7WxJAhQlkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(39830400003)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(26005)(2616005)(6506007)(966005)(8936002)(53546011)(83380400001)(41300700001)(5660300002)(8676002)(2906002)(6486002)(478600001)(66556008)(296002)(110136005)(66946007)(316002)(66476007)(31696002)(38100700002)(86362001)(36756003)(31686004)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHRzR2RmVm9XNUZpWlA2TG82VzJ3cWFHUXpJYmhvUW1YY0lrWm5lWUlrT1Jo?=
 =?utf-8?B?c3BBTEI1WFJ4TXh3dTVQTlNaeTh3eTdHaHpmYXhBSUFvZFN2TVExa29EaTZh?=
 =?utf-8?B?RmViK2RCOHVZVEdRUFoySWVjcCtNOGxINmZBZlBZbkROMTQzR1RNeXMrWlVi?=
 =?utf-8?B?N05JRHJYSjUwSUlwdW54SUlyZFFYdzM5V0hZMkdVQjRlbW9RcXRxaEE3elRU?=
 =?utf-8?B?ZS8vVDhNUTlhamRPY3lORmJqTDVrRG10ZVdRTWx0ZHJxOUxnRzJzY1lFeXVl?=
 =?utf-8?B?UXhsd3dDdTNJMmhjMmV5NkdiTUJxeGNtbzZsSURqV3l1a3dGdVJodFNhZm52?=
 =?utf-8?B?SmNOMnduYTNoYmJsSlppRDJMTERvaHlrNkY5OWQ3YWh4U0lSNmhmcy91d3p5?=
 =?utf-8?B?Vjc4MzNOTDJmQ1NWUk9NbGpQbzg4Y3k0K1FxWDQ1VXBmaTJwTTNRY2kvOEF0?=
 =?utf-8?B?dkx0ZTFLZjU4Z0V1QnVkYVFVS1kzNmZPVXJaVktnOTg4aTFyOHhRQkp2VURh?=
 =?utf-8?B?VngwWGJxU0M2ZEtxM3E0TVkyNmk2dnNGQ3p1WnY5a3NNd0RmUVYxVy9PRU9v?=
 =?utf-8?B?TytTY05jT1FQT2JwalJFeEZVZU1rMmJyejF3SVBTaHgxcG5MNEpDUW1VL0hC?=
 =?utf-8?B?M0kzVituMzlYMnV3NTk4dE1hbWF1WGkzUE9tYjMzV1pqNmxsS2gxazBaWDE1?=
 =?utf-8?B?TVBDQ3VUNUZMWjgvM1ZGbjA4cU5RYkdEampzOU9xcUs0QU1ndytmQnFhUGY1?=
 =?utf-8?B?MktxbFphRHp4UjB1bzVKVjRIS1ByamRiSzdpNXRhL2dhQ3lsd2tZNlFsdzNP?=
 =?utf-8?B?b0dpRWVrekVmdTJRVnpIMG9DVkd3SGhGVDc0MWdYbkg2TFVUTlhsWEVNVDho?=
 =?utf-8?B?Y1l3QVR6ckpDakd1ODQyNEk1VjlWdnViOWdUL0kyT2h0aGlJeGxTTHZZUk9O?=
 =?utf-8?B?bkxrVTVoTFBQVExYRFFrMUtTZndUdkJiS2VvVlhJUzZaS09GS25DbmFwdUFw?=
 =?utf-8?B?Z1Jsb2luMUtkV2w1SlZ6UDZSbThTaTlvSEUrN0gvS1d6NHN2R3ZEZll4SWJU?=
 =?utf-8?B?R3BWZ1pkSGdldmJoNDkwUlRFclE1dGhoYkU5cEQ3eXoreUpnWkRYek5rVXNL?=
 =?utf-8?B?dHZwTGJPWnM5amZYb0FhSEYvUUdmQzNORmFqU1o0aFRUS08rUUxuajcyR3Jx?=
 =?utf-8?B?aHFSdEtmc3JJeWhVTjlVdkpSeFZWL0FSV2t0U2loelMxQ3VGbTBiSk1hbkpq?=
 =?utf-8?B?VE9HYWZULzN1VDVmcEFKQk5nM3dFMlJteVNUdjJGc0J0WUFLSnJvZGZCamlw?=
 =?utf-8?B?NkFGZ2pXczdUUmUvUEZTZHJHeU5kOVJ5RW9UZlVqSU9mR0Zaay9hTnJwRzlq?=
 =?utf-8?B?NDNUNmNUbUZzMWJFNDNDblRNL3FMaGsvell5QnNJUDN4NGJ2RHRDTXAyeGF2?=
 =?utf-8?B?YXpPZ0FaeDY3SGR1d0tPT2I4TFBPMjR1K1YrY3FtVCtiZk5vWmxnNjJySnBK?=
 =?utf-8?B?RklMRVVJZGdtdmdreHJiaWE1ZUp5blh6ZG1BaFpDc3VybWxuWCtzVGdxSGVR?=
 =?utf-8?B?YWpmSEdKNmNTZ0NvS0RPM1VFYksxaDBlVHc5UldJS3d6UzdkMHdnbFFMMUVV?=
 =?utf-8?B?cXIzeGI2VFkzY1F4WCthM05maUY4VU5hZzNkeVhrWnlRaVIwK2xZQ0NGSDRZ?=
 =?utf-8?B?OVBwSjhLUnhNbmxXN0dHSGtQSGJZQVp5UWpKcFFYdVlaVmpjOVIwZ0RGVnJk?=
 =?utf-8?B?ZUJGUlF5UC9jbU1sUTRMUUJXWnJObEwxNVp0ZHFkeEpyVnFubFpjekQyUk4y?=
 =?utf-8?B?dXViN0NyRHZyUVRNUVdwKy8yVkR4RGhnYUNrWmJoSUprSHcyOFJHdFJDZ3hv?=
 =?utf-8?B?ZGJ1Yy93cEowYS9FR2o0bkVYQTFES2RYTXJ3bTZEa0xFd05kY3ZuY3VHL0t1?=
 =?utf-8?B?dzI5bWdNR2x6Vkc2Zmw3WVVoVE95dTBFOXB3dmF2YU9sU01DTkk1WlU5aWxI?=
 =?utf-8?B?d2NCOTg5Y3lnTThLd21sOVJtUm14VG1HOCtPK2htSDRkOWsvS1RjTGhMMVk0?=
 =?utf-8?B?NVVzUGF0Y0Z2SDIyNnRGdUxtL1RtWVFoVXQxOUpWcTcwZlFVblFFb29lc0ho?=
 =?utf-8?B?OWtmYTNEOWtrQVRZaWZ1ZnNRMmYwL2dsR1F3bmRvTG9EYm51VVA4ZlVEUTNR?=
 =?utf-8?B?eHc9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ba561a-e590-4297-bb1e-08dbcf273857
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 15:39:16.0780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vji5GcotIiRaVM/tHcZhxRXXwpkiSZ46/ulei0NaPGzq4Z0E8tBbCEcWfZWzOiNmeMO2Tn7vslz8lsCSCCYNSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5250
Subject: Re: [lttng-dev] [EXTERNAL] Re: LTTng enable-event performance issue
 during active session
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

SGkgWmFjaCwKCnRoZSBjaGFuZ2UgdG8gYWRkcmVzcyB0aGUgZW5hYmxlLWV2ZW50IHBlcmZvcm1h
bmNlIGhhcyBiZWVuIG1lcmdlZCBpbnRvIApib3RoIGx0dG5nLXVzdCBtYXN0ZXIgYW5kIHN0YWJs
ZS0yLjEzIGlmIHlvdSB3b3VsZCBsaWtlIHRvIGJ1aWxkIGZyb20gCnNvdXJjZSBiZWZvcmUgdGhl
IG5leHQgcmVsZWFzZS4KCnRoYW5rcywKa2llbmFuCgoKT24gMjAyMy0xMC0wOSAwNjoyOSwgS3Jh
bWVyLCBaYWNoIHdyb3RlOgo+IEhpIEtpZW5hbiwKPiAKPiBUaGFuayB5b3UgZm9yIHRoZSB0aG9y
b3VnaCBleHBsYW5hdGlvbiBhbmQgcHJvcG9zZWQgY2hhbmdlc2V0Lgo+IAo+IE15IHVzZSBjYXNl
IHdhcyB0byBzeW5jaHJvbml6ZSB3aXRoIGEgdXNlci1jb25maWd1cmFibGUgc2V0IG9mIGV2ZW50
cyBhdCBydW50aW1lLCB3aGljaCB3YXMgZWFzaWVzdCBkb25lIGluZGl2aWR1YWxseS4KPiBJbiB0
aGUgbWVhbnRpbWUgSSB3b3JrZWQgYXJvdW5kIHRoZSBwZXJmb3JtYW5jZSBoaXQgYnkgZW5zdXJp
bmcgYWxsIGF2YWlsYWJsZSBldmVudHMgaGF2ZSBhbHJlYWR5IGJlZW4gY3JlYXRlZCBvbiB0aGUg
c2Vzc2lvbiBiZWZvcmUgc3RhcnRpbmcgaXQuCj4gCj4gTG9va2luZyBmb3J3YXJkIHRvIHRoZSBj
aGFuZ2VzZXQuCj4gCj4gVGhhbmtzLAo+IFphY2gKPiAKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQo+IEZyb206IEtpZW5hbiBTdGV3YXJ0IDxrc3Rld2FydEBlZmZpY2lvcy5jb20+Cj4gU2Vu
dDogRnJpZGF5LCA2IE9jdG9iZXIgMjAyMyAxODoxMwo+IFRvOiBsdHRuZy1kZXZAbGlzdHMubHR0
bmcub3JnOyBLcmFtZXIsIFphY2ggPFphY2guS3JhbWVyQGNvZ25leC5jb20+Cj4gU3ViamVjdDog
W0VYVEVSTkFMXSBSZTogW2x0dG5nLWRldl0gTFRUbmcgZW5hYmxlLWV2ZW50IHBlcmZvcm1hbmNl
IGlzc3VlIGR1cmluZyBhY3RpdmUgc2Vzc2lvbgo+IAo+IEhpIFphY2gsCj4gCj4gdGhlcmUncyBh
IHByb3Bvc2VkIGNoYW5nZSB0byBsdHRuZy11c3Qgd2hpY2ggYWRkcmVzc2VzIHRoZSBpc3N1ZSB5
b3UgYXJlIHNlZWluZywgYnV0IGl0IGhhc24ndCBmaW5pc2hlZCBjbGVhcmluZyByZXZpZXcgJiB0
ZXN0aW5nIHlldC4KPiBodHRwczovL3Jldmlldy5sdHRuZy5vcmcvYy9sdHRuZy11c3QvKy8xMTAw
Ngo+IAo+IHRoYW5rcywKPiBraWVuYW4KPiAKPiBPbiAyMDIzLTEwLTA1IDE4OjA0LCBLaWVuYW4g
U3Rld2FydCB2aWEgbHR0bmctZGV2IHdyb3RlOgo+PiBIaSBaYWNoCj4+Cj4+IGFwb2xvZ2llcyBm
b3IgdGhlIGRlbGF5IGluIHJlcGx5aW5nIHRvIHlvdXIgcXVlc3Rpb24uCj4+Cj4+IE9uIDIwMjMt
MDktMjYgMDg6MjcsIEtyYW1lciwgWmFjaCB2aWEgbHR0bmctZGV2IHdyb3RlOgo+Pj4gSGksCj4+
Pgo+Pj4gSSBhbSBvYnNlcnZpbmcgYSBwZXJmb3JtYW5jZSBpc3N1ZSB3aXRoIHJlZ2FyZHMgdG8g
ZW5hYmxpbmcgZXZlbnRzCj4+PiB3aGlsZSBhIHNlc3Npb24gaXMgYWN0aXZlIGFuZCB3YXMgd29u
ZGVyaW5nIGlmIHRoaXMgaXMgZXhwZWN0ZWQuCj4+Pgo+Pj4gTFRUbmcgdmVyc2lvbnM6Cj4+Pgo+
Pj4gICAgKiBsdHRuZy10b29sczogMi4xMy45Cj4+PiAgICAqIGx0dG5nLXVzdDogMi4xMy42Cj4+
PiBTdGVwcyB0byByZXByb2R1Y2U6Cj4+Pgo+Pj4gICAxLiBFbnN1cmUgbWFueSB1c2Vyc3BhY2Ug
dHJhY2Vwb2ludHMgYXJlIGF2YWlsYWJsZSBpbiBgbHR0bmcgbGlzdCAtdWAKPj4+ICAgICAgZS5n
LiAxMDAKPj4+ICAgMi4gQ3JlYXRlIGEgbmV3IHNlc3Npb24KPj4+ICAgMy4gU3RhcnQgc2Vzc2lv
bgo+Pj4gICA0LiBFbmFibGUgbmV3IGV2ZW50cyBvbiBzZXNzaW9uCj4+Pgo+Pj4gVGhlIHRpbWUg
aXQgdGFrZXMgdG8gZW5hYmxlIGVhY2ggbmV3IGV2ZW50IGhhcyBpbmNyZWFzaW5nIGNvc3QgZS5n
Lgo+Pj4KPj4+ICAgMS4gRXZlbnQgMTogMW1zCj4+PiAgIDIuIEV2ZW50IDEwMDogMTVtcwo+Pj4g
ICAzLiBFdmVudCAxMDAwOiAxNTBtcwo+Pj4gICA0LiDDoGluIHRvdGFsIGFib3V0IDEuNSBtaW51
dGVzIHRvIGVuYWJsZSAxMDAwIGV2ZW50cwo+Pj4KPj4+IElmIGVpdGhlcjoKPj4+Cj4+PiAgIDEu
IE5vIHVzZXJzcGFjZSB0cmFjZXBvaW50cyBhcmUgYXZhaWxhYmxlICAyLiBPciBzZXNzaW9uIGlz
IG5vdAo+Pj4gc3RhcnRlZCB1bnRpbCAvYWZ0ZXIgL3RoZSBldmVudHMgYXJlIGVuYWJsZWQKPj4+
Cj4+PiBUaGVuIHRoZSB0aW1lIGl0IHRha2VzIHRvIGVuYWJsZSBuZXcgZXZlbnRzIGlzIGNvbnN0
YW50IChlLmcuIDFtcykuCj4+Pgo+Pj4gQmVsb3cgaXMgYSBiYXNoIHNjcmlwdCBkZW1vbnN0cmF0
aW5nIHRoaXMgYmVoYXZpb3I6Cj4+Pgo+Pj4gIyBQcmUtcmVxdWlzaXRlOiBoYXZlIG1hbnkgdXNl
cnNwYWNlIHRyYWNlcG9pbnRzIGF2YWlsYWJsZQo+Pj4KPj4+IGx0dG5nIGNyZWF0ZSBmb28KPj4+
Cj4+PiBsdHRuZyBlbmFibGUtY2hhbm5lbCAtdSAtcyBmb28gYmFyCj4+Pgo+Pj4gbHR0bmcgc3Rh
cnQgZm9vCj4+Pgo+Pj4gdG90YWxfdDE9JChkYXRlICslcyUzTik7Cj4+Pgo+Pj4gZm9yIGkgaW4g
ezEuLjEwMH0KPj4+Cj4+PiBkbwo+Pj4KPj4+ICAgICAgICAgICB0MT0kKGRhdGUgKyVzJTNOKTsK
Pj4+Cj4+PiAgICAgICAgICAgbHR0bmcgZW5hYmxlLWV2ZW50IC11IGx0dG5nX2l0ZXJfJGkgLXMg
Zm9vIC1jIGJhciA+Cj4+PiAvZGV2L251bGwKPj4+Cj4+PiAgICAgICAgICAgdDI9JChkYXRlICsl
cyUzTik7Cj4+Pgo+Pj4gICAgICAgICAgIGVjaG8gIkV2ZW50ICMkaSB0b29rICQoKHQyLXQxKSkg
bXMiCj4+Pgo+Pj4gZG9uZQo+Pj4KPj4+IHRvdGFsX3QyPSQoZGF0ZSArJXMlM04pOwo+Pj4KPj4+
IGVjaG8gIi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0iCj4+Pgo+Pj4gZWNobyAiRW5hYmxpbmcgZXZlbnRzIG9uIGFjdGl2ZSBzZXNzaW9uIHRvb2sg
JCgodG90YWxfdDItdG90YWxfdDEpKSBtcyIKPj4+Cj4+PiBlY2hvICItLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIgo+Pj4KPj4+IGx0dG5nIGRlc3Ry
b3kgZm9vCj4+Pgo+Pj4gbHR0bmcgY3JlYXRlIGZvbwo+Pj4KPj4+IGx0dG5nIGVuYWJsZS1jaGFu
bmVsIC11IC1zIGZvbyBiYXIKPj4+Cj4+PiB0b3RhbF90MT0kKGRhdGUgKyVzJTNOKTsKPj4+Cj4+
PiBmb3IgaSBpbiB7MS4uMTAwfQo+Pj4KPj4+IGRvCj4+Pgo+Pj4gICAgICAgICAgIHQxPSQoZGF0
ZSArJXMlM04pOwo+Pj4KPj4+ICAgICAgICAgICBsdHRuZyBlbmFibGUtZXZlbnQgLXUgbHR0bmdf
aXRlcl8kaSAtcyBmb28gLWMgYmFyID4KPj4+IC9kZXYvbnVsbAo+Pj4KPj4+ICAgICAgICAgICB0
Mj0kKGRhdGUgKyVzJTNOKTsKPj4+Cj4+PiAgICAgICAgICAgZWNobyAiRXZlbnQgIyRpIHRvb2sg
JCgodDItdDEpKSBtcyIKPj4+Cj4+PiBkb25lCj4+Pgo+Pj4gdG90YWxfdDI9JChkYXRlICslcyUz
Tik7Cj4+Pgo+Pj4gZWNobyAiLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLSIKPj4+Cj4+PiBlY2hvICJFbmFibGluZyBldmVudHMgb24gaW5hY3RpdmUg
c2Vzc2lvbiB0b29rICQoKHRvdGFsX3QyLXRvdGFsX3QxKSkgbXMiCj4+Pgo+Pj4gZWNobyAiLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSIKPj4+Cj4+
PiBsdHRuZyBkZXN0cm95IGZvbwo+Pj4KPj4+IElzIHRoaXMgcmVwcm9kdWNpYmxlIGZvciB5b3U/
IEFueSBpbnNpZ2h0IGlzIGFwcHJlY2lhdGVkLgo+Pj4KPj4KPj4gSSdtIGFibGUgdG8gcmVwcm9k
dWNlIHdoYXQgeW91J3JlIHNlZWluZywgYW5kIGl0J3Mgbm90IGNvbXBsZXRlbHkKPj4gdW5leHBl
Y3RlZCBiYXNlZCBvbiBteSB1bmRlcnN0YW5kaW5nIG9mIHRoZSBhcmNoaXRlY3R1cmUgb2YgbHR0
bmcuCj4+Cj4+IFdoZW4gYSBzZXNzaW9uIGlzIGFjdGl2ZSBhbmQgYW4gZXZlbnQgcnVsZSBpcyBl
bmFibGVkL2Rpc2FibGVkLCB0aGUKPj4gc2Vzc2lvbmQgd2lsbCBub3RpZnkgZWFjaCBvZiB0aGUg
cmVnaXN0ZXJlZCBhcHBsaWNhdGlvbnMgb2YgdGhlIGV2ZW50Cj4+IHJ1bGUgc3RhdGUgY2hhbmdl
cy4gVGhpcyBjb21tdW5pY2F0aW9uIGlzIGdvaW5nIHRocm91Z2ggZWl0aGVyIHVuaXggb3IKPj4g
dGNwIHNvY2tldHMsIGFuZCB0aGF0IHBvcnRpb24gb2YgdGhlIHByb3RvY29sIHNlZW1zIHRvIHN0
cnVnZ2xlIHdpdGgKPj4gbWFueSBzbWFsbCBjaGFuZ2VzIGFzIHRoZSBwcm90b2NvbCB0byBjb21t
dW5pY2F0ZSB0aGUgY2hhbmdlcyBkb2Vzbid0Cj4+IHN1cHBvcnQgYmF0Y2hpbmcuCj4+Cj4+IEVu
YWJsaW5nIG11bHRpcGxlIGV2ZW50cyBpbiBhIHNpbmdsZSBjYWxsIHJlZHVjZXMgc29tZSBvZiB0
aGUKPj4gb3ZlcmhlYWQsIGJ1dCB0aGUgY2hhbmdlcyB3aWxsIHN0aWxsIGJlIGNvbW11bmljYXRl
ZCBzZXJpYWxseS4gVGhpcwo+PiBtZWFucyBhIHNpbmdsZSBjYWxsIGFjdGl2YXRpbmcgdGhvdXNh
bmRzIGV2ZW50cyBjYW4gc3RpbGwgdGFrZSBhIGxvbmcKPj4gdGltZSB0byBwcm9jZXNzIChlZy4g
YGx0dG5nIGVuYWJsZS1ldmVudCAtcyBmb28gLWMgYmFyIC11Cj4+IHRwMCx0cDEsLi4uLHRwTmAp
Cj4+Cj4+IFVzaW5nIGdsb2IgcGF0dGVybnMgb3IgYC0tYWxsYCB3aWxsIGJlIHNpZ25pZmljYW50
bHkgZmFzdGVyIGFzIHRoZSBVU1QKPj4gYXBwbGljYXRpb25zIGNhbiBkaWdlc3QgdGhvc2UgdHlw
ZXMgb2YgZXZlbnQgcnVsZSBjaGFuZ2VzIHdpdGggYQo+PiBzaW5nbGUgc2V0IG9mIG1lc3NhZ2Vz
LiBJbiBjYXNlcyB3aGVyZSB5b3Ugd2FudCBtb3N0IGJ1dCBub3QgYWxsCj4+IGV2ZW50cywgZmxp
cHBpbmcgdGhlIGxvZ2ljIHRvIGVuYWJsZSAiKiIgYnV0IGFkZCBldmVudHMgb3IgcGF0dGVybnMg
dG8KPj4gb21pdCB3aXRoICItLWV4Y2x1ZGUiIGlzIGdvaW5nIHRvIGJlIGEgYmV0dGVyIHN0cmF0
ZWd5Lgo+Pgo+PiBEbyB5b3UgaGF2ZSBjYXNlcyB3aGVyZSB5b3UgbmVlZCB0byBhY3RpdmF0ZSBt
YW55IG9mIGV2ZW50cyBidXQgd2hpY2gKPj4gY291bGRuJ3QgYmUgY292ZXJlZCBieSB1c2luZyBn
bG9iIHBhdHRlcm5zIGFuZC9vciBleGNsdXNpb25zPwo+Pgo+PiB0aGFua3MsCj4+IGtpZW5hbgo+
Pgo+Pj4gTWFueSB0aGFua3MsCj4+Pgo+Pj4gWmFjaAo+Pj4KPj4+Cj4+PiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+Pj4gbHR0bmctZGV2IG1haWxpbmcg
bGlzdAo+Pj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+ICAgX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+
PiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3Rz
Lmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGlu
Zm8vbHR0bmctZGV2Cg==
