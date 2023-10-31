Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76571C4167B
	for <lttng-dev@archiver.kernel.org>; Tue, 31 Oct 2023 19:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1698780983;
	bh=hFnlU623LP/DPu2gLDHsXDPL6TvCMnx08jO1PyAuLdY=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=P3apui7vM2kkmJFRhccEJi9Ks2I7JCoifIMK7cMZwMc+bYSetyAqHOnnIoHLbch8G
	 PHXxAKj+AMA9CeylS6NQ8LgAISnSnXvQv0dULMaMkRv72ilyq7XoAOG5d0/VPi5C5d
	 mRE2W0otsOOtl8plTnVii96uFf99L2r8au9Z+YUEjCVVOr/cbMpv2oavwfvg3Q4MGL
	 tbAgBDFyldSb4+a/QKM0X3eXhHW4irME+FcargvsDKoubdm6CvsKe41vC9eL9hXy1K
	 e3rgoaioIqVDAQjq8d0HLKN7XtBRMwtv9Ctk7wC95XCQoZkaShor0+crcFrp7XU2VH
	 2aEIvFMbSWHpw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4SKgP31Tx8zBjs;
	Tue, 31 Oct 2023 15:36:23 -0400 (EDT)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2076.outbound.protection.outlook.com [40.107.115.76])
 by lists.lttng.org (Postfix) with ESMTPS id 4SKgNz6qGRzBZs
 for <lttng-dev@lists.lttng.org>; Tue, 31 Oct 2023 15:36:19 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zxn75eaa5jHUSAx7hLhO2mWtltqtJnIbFFKLziofK/aLwkbZOkTrlzNySXdweMxdBiT4FdRJupQkPc6Djjly6w+YgDIfPo5M0nisPXxbxrP/qp6Mut5UyjLdQD0V7IBOAGzHSAkZNoLJP85IpSAPoaYdQpIqDqhxH8dMOYAglLK4/Gox0T5HjFuGWpr4LXR4ezfOWAEax9hmbg+0w89Uu7fAzQYcHEzHw5QEiwlWQToHBcr7lzEmj6n7G+umMu7aV1xN66tcFV2aqhipsJ2LCB53dpTwBiNIaW10YsCwQsSoM5Zp1vmy8R2RZ/us+UHxZ8StsJLU6u7RS/Z/z1yV6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEbALLisHJ8PZCPnoG0SDoTp/lieAXxmyXWNinT5I10=;
 b=ekcO2n2I385cyLKPWGYYZeHMisnBXPVIwGVGqeFA8jBuR2pNNsffFjTBcGX9/Bs9GJLLbFCvxMc+ERWo9N22As7rAw8Jjq/S36GVtZwoMCV1mTuhKPJaGVqX8+HE95jAMx2WWqBq/AQJ5NpF13bE38zCteaUHz8gf97/YGeYZJEVcFsqDrEZ9Y9+o0WNv8RMwgp+sJB8yFAOd6XJbOA9xjjUyiU1SlRgw5HCt1nIAFNUe934aeKXDs1L5luyDXPz4ZGPOPwePTT72to0y/+B1QDbgOKr5xRF4ZjU3whZm4eNcjHOxxWv3yIdf2hkMDTgRl3VfZ7LCnq6jbIbVSjb9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:de::19)
 by YT3PR01MB8675.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:7a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Tue, 31 Oct
 2023 19:36:17 +0000
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::da47:621a:32df:13c2]) by YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::da47:621a:32df:13c2%4]) with mapi id 15.20.6954.019; Tue, 31 Oct 2023
 19:36:17 +0000
Message-ID: <abf9f8b8-059c-437f-a8d3-aa796d9564d2@efficios.com>
Date: Tue, 31 Oct 2023 15:36:15 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US, fr-CA, en-CA
To: =?UTF-8?B?5aec5rabIFRhbyhBRCk=?= <tao.jiang@jiduauto.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <ZQ0PR01MB1062ED24B7D2F6A14F06A92197A0A@ZQ0PR01MB1062.CHNPR01.prod.partner.outlook.cn>
In-Reply-To: <ZQ0PR01MB1062ED24B7D2F6A14F06A92197A0A@ZQ0PR01MB1062.CHNPR01.prod.partner.outlook.cn>
X-ClientProxiedBy: YQBPR0101CA0138.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::11) To YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:de::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9793:EE_|YT3PR01MB8675:EE_
X-MS-Office365-Filtering-Correlation-Id: d99ce4a8-3083-44b0-0ed9-08dbda48a6a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ECYIWnv+stIjQmDgp2BGRS2mkDBToq033XltVUbr4ikqBpqXlyLu/9dMYEG9TRImML49uCVnIS2IDW8vFk7TyyTw92vUb5LrwR87fEuOtPfILBLfKdULx/ubU5pcJ1Z19pWQnSWVW5DgdPs7x9RZdo9DDlPzzFGuP31/mzmWMjPY8Drts1tLCvWQusVAzIYeysShH5zIRdwTEGZ5w7ZNSitbNyO6kmyCjjMHDOzLmu05Bvk5K1cQ4kDiyplNvw6WnayBi01GwuWuidsiD/jmhVu9koeKFg4U39e+KWESEOznWRHzg5R8bJZNNp60oKv4JIHSiGfXsaXQISG9LP2t84W2aYy/1M2Tn8ygNR1tpyFxEQ7QmSYf1akxPqdAQkliKFYaHfMCyYIDih5uxbJi52+nI7rglTMwY2bmZke7Ebm8I2GOrNtV4MwNGH/yoWIUi50ckLuF3AunAAaBFIu+Gaaw6TmpK26V1JWgCL2wVKjbxMF2Ji1SE/r6knmpyQZYS4UcyVr+GChdeb02KeWcZvSQe3QaMJ2EGbJxJMSeoao5DNZehzTxL6mTgmmhuPRxLQ2vJQLHwXgUc5GBVNstX/awqvHAFBfoRzfQuV3s171sFl904A3dn4YZIr2KYpd8rSN8WK0Z0uDgwohGYm5ctA9e2uCSsvxxYcXmDeCmjY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(346002)(39830400003)(136003)(396003)(230473577357003)(230373577357003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(83380400001)(38100700002)(86362001)(53546011)(6506007)(36756003)(26005)(31696002)(2616005)(6512007)(4001150100001)(478600001)(6486002)(966005)(2906002)(31686004)(66476007)(66556008)(316002)(41300700001)(110136005)(66946007)(5660300002)(8936002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFNaa3MrZ3RKL3dLa3RYeDUvbjRrRmZBZXJPZXdFMWNhVk5RdkpaSUVhN3ZL?=
 =?utf-8?B?WEtXc1dHZVRuY3dqLzU4NmdyZHBnTVNjcXZnUkN6WlpCT2NYbFp2K2ZvWmc1?=
 =?utf-8?B?NTk3VERSUG5jWVJBVEpNV0lGU1R3eC9SRW11SmpISVl5azVUMDlkNGE0cHBK?=
 =?utf-8?B?N1dwY3Y5TlV2NFo3Q01MdU8vZzdEeEVYaFNYbS9EbmsyNjdJT05zZllpYTlW?=
 =?utf-8?B?dGw2eE55N3l6ckwrTVhWMFVQRDhaS1hORXhjMFlTRnZkNzNKRlFsY00zZmJU?=
 =?utf-8?B?UmZkOVZUZXBibDBJMDBZN055R29uckJqSytaZWNUNzdSQzZKL2xqSlFJRkdv?=
 =?utf-8?B?M00rRmJ3Y0lVVXFwV29lMXdWWGkrRVdpZnZjRFJTTHMzcDVoUjROZVB3UEJk?=
 =?utf-8?B?L3VQb2R1MGhyQlE2UFl2U1JvcEpLOFRRS1RLdm1ubnNKNG96cmVicm5iU0F5?=
 =?utf-8?B?eXZ5Z3ZaZ25QeUVjbWlaMlVoVzRWUktlZ0JlNFBHeTdCRlpDMzUyVUMxcTk1?=
 =?utf-8?B?eXdoOHVwUDJSNjZZTEVsY2x6dzJDNXZuZW91MklxZGMyTWJHNzBpNFUwNkxQ?=
 =?utf-8?B?N1hJSms1NWVleUNEc0JsaTlMN1pQZS9RdW1nUzkzUU5uUVl6MUdPbFo3V0to?=
 =?utf-8?B?N2pIeVhDK3ZhQ2tZVXZKMWtXMjEyRUgzL2xVMXNJSGdERHJNWU5acWdoaUFq?=
 =?utf-8?B?N2RSNFRsdDQ5c3VkYjU4ekRUSEJjKzNvbDRROEp1NGg0QTArTnJhLzJqcXl4?=
 =?utf-8?B?Y0RMTE4xNDR6bEpxdTg3MmdjRmszcS9uM2ZoNHZDYWxHT0p4UlBvNUlhWGxi?=
 =?utf-8?B?K2R1WDJYZzBVZkQ4V0dwc1FieHdHOWkwQ2VwQU1VS1VmY1FHTkFIWm5XTWNG?=
 =?utf-8?B?ckE4d3g3bHkvVWl0UHl2ZGN1VjE4UkVqMVB4eEJWNlBScmdhaUpyNzBNTGxt?=
 =?utf-8?B?RTluYkVJdXRGQWN4WkVteG1pd21VSkRLeW9PWDJ1dmppYzJsYjFWRmRYMTJ5?=
 =?utf-8?B?OGw1a2tHUHlSaFVlRmxHam9DMis5K0lYc2NIWWphL29HTlpoTzdwbWhEZXhi?=
 =?utf-8?B?ZnM1V1RXUGlXM21jSnB0ZVdLa0d4M2FOcVd4cnUwUC91TWZjcFBYejNTT1BL?=
 =?utf-8?B?OTZCTWlVdE5CQnB5VFd2QkovNXR2Mk1XZ3Blc2E4U1BzZUY1SXFwU2s4LytF?=
 =?utf-8?B?aHJ1aXlFb0tZdG9TajhDZXFaOFlOSCt6ajFJdkxsTWdkU0RvaUw5dTYraDBh?=
 =?utf-8?B?RHVOVk80SWkxalZDeWlsZGhLMk1ndEQ0RnRWQmkwZzdKRm8vWnFiTm4vMlQy?=
 =?utf-8?B?K1p3djdMa1BKOHZVNW16dWdpdWxEblBRaW1RNng4ZXRrNEN2cjZzRGdVUGZz?=
 =?utf-8?B?N1B2TlhFZWpPWHV5TGhWekFFU0dBTlU5THU2TldReHpINkdZNWJ3Y3BzMzk0?=
 =?utf-8?B?WURIRnduNm15WXhqQTBaY2U4dUpHRGFDdE9peCtOU0d0ZlZadnoxVnJYNnZV?=
 =?utf-8?B?d2p2MldWNjk3Wjl4YmJUd0p2S2xzMkVXZDRwQUpTWmRyTzJDYm1XbTA4bnoy?=
 =?utf-8?B?NjVyV3dNTG1xSEwvY2xWWVpPam9rSThHQW9hNk9IZFNVY3loVlN1cmZBSVRX?=
 =?utf-8?B?VUhLYm9qTGV5aWJxNUp3WVFjZ1hHZVpxRE5WL1NDdHdJVldtNjBadHpNbzhl?=
 =?utf-8?B?SWlIb21lL28xR0tWeGVQUXcyZnFyY1JjekZQb2N0Nm5ZbTZva3VBTlcySDNX?=
 =?utf-8?B?SFI2MUpBNEVBL2hXaDVEOE0xblBBNXRYUEcrYnpKeDNkQ2xRK1BjZGhiTkZw?=
 =?utf-8?B?SWFlV1h3RmZFdzdKNmhILzNnV1lLeGJiT1UrRHpybWJJa1hUcUJKbXFmcFBD?=
 =?utf-8?B?YzBiK0FJRlpIK1dlTyt1T1FWcGJ5OWphQThGMzMxZzdtZ21JYTQvOUtleFVI?=
 =?utf-8?B?S0pZZFRjVXhON3FQdWgwanRzSEt4L3RZdXNlVkhRWm1aTGFMRmxEZnJaN0w2?=
 =?utf-8?B?VVliRzV1elJMamtDcm5wRHJQVHBGVGNYZlJaYTBJbk9XbThDWGYwWExOQTNl?=
 =?utf-8?B?SWU1M3hEcitmVlFJRTFSbElmQ0IxbEVlT2JlSXRJMVBEYmpJRHU5UGYxa3d1?=
 =?utf-8?B?bURGUWVWYmxxWHM1WFkydTlkb1h2V0pjN0kwYUJFQ1FSZXkva2ZSS3pLZkZt?=
 =?utf-8?B?Ync9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d99ce4a8-3083-44b0-0ed9-08dbda48a6a2
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 19:36:17.2438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wAj3YvBIzFZgBNKBFliAkknXn9X3m8cWfN+WFJevdnp0/GA81fEenn5r/CWrhInuY7qM7JxY3+yydT6Zfjf/5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8675
Subject: Re: [lttng-dev] lttng-analysis error
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

SGkgVGFvLAoKYmFzZWQgb24gYSBxdWljayB0ZXN0IEkgcGVyZm9ybWVkLCB0aGVyZSBtYXkgYmUg
YSB3b3JrLWFyb3VuZCB0aGF0IHdpbGwgCndvcmsgZm9yIHlvdS4KClRoZSBpc3N1ZSB0aGF0IEkg
c2VlIGlzIHRoYXQgYXQgbGVhc3QgdGhlIApgbHR0bmdfc3RhdGVkdW1wX2ZpbGVfZGVzY3JpcHRv
cmAgZXZlbnRzIG5vIGxvbmdlciBoYXZlIGEgcGlkIGZpZWxkIAp3aGljaCB0aGUgb2xkZXIgbHR0
bmctYW5hbHlzZXMgY29kZSBhc3N1bWVzIGlzIHByZXNlbnQuCgpUbyBmaW5kIHRoaXMgb3V0Cldo
ZW4gcnVubmluZyB0aGUgbWFudWFsIHJlY29yZGluZyBzdGVwcywgY291bGQgeW91IGFkZCB0aGUg
Zm9sbG93aW5nIApjb21tYW5kIGJlZm9yZSBydW5uaW5nIGBsdHRuZyBzdGFydGA6CgpgYGAKbHR0
bmcgYWRkLWNvbnRleHQgLS1rZXJuZWwgLS10eXBlPXBpZApgYGAKClRvIHBpbnBvaW50IHRoZSBz
b3VyY2Ugb2YgdGhlIGVycm9yLCBJIHVzZWQgdGhlIGAtLWRlYnVnYCBwYXJhbWV0ZXIgZm9yIApg
bHR0bmctYW5hbHlzZXNgIGFzIGZvbGxvd3M6CgpgYGAKIyBsdHRuZy1zY2hlZHRvcCAtLWRlYnVn
IApsdHRuZy10cmFjZXMvbHR0bmctYW5hbHlzaXMtMjcwMTAtMjAyMzEwMzEtMTgyNzM1LwpDaGVj
a2luZyB0aGUgdHJhY2UgZm9yIGxvc3QgZXZlbnRzLi4uIAoKVHJhY2ViYWNrIChtb3N0IHJlY2Vu
dCBjYWxsIGxhc3QpOiAKICAgICAgICAgICAgICAgICAgICAgICAgICAgIF0gRVRBOiAgLS06LS06
LS0KICAgRmlsZSAKIi91c3IvbG9jYWwvbGliL3B5dGhvbjMuNy9kaXN0LXBhY2thZ2VzL2x0dG5n
YW5hbHlzZXMvY2xpL2NvbW1hbmQucHkiLCAKbGluZSA3MywgaW4gX3J1bl9zdGVwCiAgICAgZm4o
KSAKCiAgIEZpbGUgCiIvdXNyL2xvY2FsL2xpYi9weXRob24zLjcvZGlzdC1wYWNrYWdlcy9sdHRu
Z2FuYWx5c2VzL2NsaS9jb21tYW5kLnB5IiwgCmxpbmUgMzY1LCBpbiBfcnVuX2FuYWx5c2lzCiAg
ICAgc2VsZi5fYXV0b21hdG9uLnByb2Nlc3NfZXZlbnQoZXZlbnQpIAoKICAgRmlsZSAKIi91c3Iv
bG9jYWwvbGliL3B5dGhvbjMuNy9kaXN0LXBhY2thZ2VzL2x0dG5nYW5hbHlzZXMvbGludXhhdXRv
bWF0b24vYXV0b21hdG9uLnB5IiwgCmxpbmUgODEsIGluIHByb2Nlc3NfZXZlbnQKICAgICBzcC5w
cm9jZXNzX2V2ZW50KGV2KQogICBGaWxlIAoiL3Vzci9sb2NhbC9saWIvcHl0aG9uMy43L2Rpc3Qt
cGFja2FnZXMvbHR0bmdhbmFseXNlcy9saW51eGF1dG9tYXRvbi9zcC5weSIsIApsaW5lIDMzLCBp
biBwcm9jZXNzX2V2ZW50CiAgICAgc2VsZi5fY2JzW25hbWVdKGV2KSAKCiAgIEZpbGUgCiIvdXNy
L2xvY2FsL2xpYi9weXRob24zLjcvZGlzdC1wYWNrYWdlcy9sdHRuZ2FuYWx5c2VzL2xpbnV4YXV0
b21hdG9uL3N0YXRlZHVtcC5weSIsIApsaW5lIDkxLCBpbiBfcHJvY2Vzc19sdHRuZ19zdGF0ZWR1
bXBfZmlsZV9kZXNjcmlwdG9yCiAgICAgcGlkID0gZXZlbnRbJ3BpZCddCiAgIEZpbGUgCiIvdXNy
L2xvY2FsL2xpYi9weXRob24zLjcvZGlzdC1wYWNrYWdlcy9iYWJlbHRyYWNlL2JhYmVsdHJhY2Uu
cHkiLCBsaW5lIAo5MTIsIGluIF9fZ2V0aXRlbV9fCiAgICAgcmFpc2UgS2V5RXJyb3IoZmllbGRf
bmFtZSkgCgpLZXlFcnJvcjogJ3BpZCcgCgpFcnJvcjogQ2Fubm90IHJ1biBhbmFseXNpczogJ3Bp
ZCcKYGBgCgp0aGFua3MsCmtpZW5hbgoKT24gMjAyMy0xMC0zMSAwNzo0NCwg5aec5rabIFRhbyhB
RCkgdmlhIGx0dG5nLWRldiB3cm90ZToKPiBIaSBldmVyeW9uZSwgSSB1c2UgbHR0bmctYW5hbHlz
aXMgdG9vbHMgdG8gcGFyc2UgdGhlIHRyYWNlIGZpbGVzIGJ1dCBnZXQgCj4gZXJyb3IgYXMgYmVs
b3c6Cj4gCj4gSSB0cnkgdHdvIG1ldGhvZHMgdG8gY2F0Y2ggdGhlIHRyYWNlIGRhdGE6IOKAnGF1
dG9tYXRpY+KAnSB1c2luZyAKPiBsdHRuZy1hbmFseXNpcy1yZWNvcmQgYW5kIOKAnG1hbnVhbOKA
nSB1c2luZyBsdHRuZyAKPiBjcmVhdGUvZW5hYmxlLWV2ZW50L3N0YXJ0L3N0b3AvZGVzdHJveSwg
YnV0IGFsd2F5cyBnZXQgdGhlIGVycm9ycyB3aGVuIAo+IHVzaW5nIGx0dG5nLWFuYWx5c2lzIHRv
b2xzKDAuNi4wIGFuZCAwLjYuMSB2ZXJzaW9uKS4KPiAKPiBJIGxvYWQgdGhlIGx0dG5nIG1vZHVs
ZXMoMi4xMi4xNCB2ZXJzaW9uKSBzdWNjZXNzZnVsbHk6Cj4gCj4g5paH5pysIOaPj+i/sOW3suiH
quWKqOeUn+aIkAo+IAo+IFRoZSBlbnZpcm9ubWVudCBpcyBhcyBiZWxvdzogVWJ1bnR1MjAuMDQg
YWFyY2g2NCwga2VybmVsIHZlcnNpb246IAo+IDUuMTAuMTIwIHJ0IHBhdGNoLgo+IAo+IEFueSBo
ZWxwIHdpbGwgYmUgYXBwcmVjaWF0ZWQhIFRoYW5rcyEKPiAKPiDlhY3otKPlo7DmmI7vvJrmnKzp
gq7ku7bmiYDljIXlkKvkv6Hmga/lj5Hnu5nmjIflrprkuKrkurrmiJbmnLrmnoTvvIzpgq7ku7bl
j6/og73ljIXlkKvkv53lr4bmiJbkuJPlsZ7kv6EgCj4g5oGv44CC5pyq57uP5o6l5pS26ICF6K64
5Y+v77yM5LiN5b6X6ZiF6K+744CB6L2s5Y+R5oiW5Lyg5pKt6YKu5Lu25YaF5a6577yM5oiW5qC5
5o2u6YKu5Lu25YaF5a656YeH5Y+W5Lu75L2VIAo+IOebuOWFs+ihjOWKqOOAguWmguaenOmUmeiv
r+WcsOaUtuWIsOS6huatpOmCruS7tu+8jOivt+S4juaUtuS7tuS6uuiBlOezu+W5tuiHquihjOWI
oOmZpOmCruS7tuWGheWuueOAgiAKPiBEaXNjbGFpbWVy77yaVGhlIGluZm9ybWF0aW9uIHRyYW5z
bWl0dGVkIGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJzb24gCj4gb3IgZW50aXR5IHRvIHdo
aWNoIGl0IGlzIGFkZHJlc3NlZCBhbmQgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIGFuZC9vciAK
PiBwcml2aWxlZ2VkIG1hdGVyaWFsLiBBbnkgcmV2aWV3LCByZXRyYW5zbWlzc2lvbiwgZGlzc2Vt
aW5hdGlvbiBvciBvdGhlciAKPiB1c2Ugb2YsIG9yIHRha2luZyBvZiBhbnkgYWN0aW9uIGluIHJl
bGlhbmNlIHVwb24sIHRoaXMgaW5mb3JtYXRpb24gYnkgCj4gcGVyc29ucyBvciBlbnRpdGllcyBv
dGhlciB0aGFuIHRoZSBpbnRlbmRlZCByZWNpcGllbnQgaXMgcHJvaGliaXRlZC4gSWYgCj4geW91
IHJlY2VpdmVkIHRoaXMgaW4gZXJyb3IgLCBwbGVhc2UgY29udGFjdCB0aGUgc2VuZGVyIGFuZCBk
ZWxldGUgdGhlIAo+IG1hdGVyaWFsIGZyb20gYW55IGNvbXB1dGVyLgo+IAo+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcg
bGlzdAo+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBodHRwczovL2xpc3RzLmx0dG5nLm9y
Zy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmct
ZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxt
YW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
