Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297DAC61D85
	for <lttng-dev@archiver.kernel.org>; Thu, 23 Nov 2023 20:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1700771099;
	bh=AY9yeeHpBy+OMC5aLdUGP3YyBidCLHwsffctgK1mWA0=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=LW5/fjDhHOsjhY4YEfTWD1a1HtS45EjV2/LsmGYz90O0gNBNSnyyWpIMwmj3e24st
	 ZVkIOm6fV9Q6OCDACxZ6lS4+PVIH9GKXPmos/dOVIzf+o3XpOMPdvDQCM7ojrDcx3Z
	 SyYqTSG3zWITFgS7bQ5CWlWeBlYLmP7gDjSN8KlJu4+TQVJl9jk53GKVnIxbiNOwzj
	 Zv9flfaA9x+Xe4ms4zX0diGnhJ17qSWs09GhemT4KvtiMYT8bYOAesJhAuqqyM6Huy
	 NSzm5xVvBw0HrOtGDu6hZjfcUq/H5sdRNS46rZxDfGheigG9LlnqGeLW2OPZV1Deqn
	 tZCYG3tEWoLmQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4SbqNV6pcPzLCH;
	Thu, 23 Nov 2023 15:24:58 -0500 (EST)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2056.outbound.protection.outlook.com [40.107.116.56])
 by lists.lttng.org (Postfix) with ESMTPS id 4SbqNT6Wb2zKhN
 for <lttng-dev@lists.lttng.org>; Thu, 23 Nov 2023 15:24:57 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCnopyj94gjUksEbkU+1h6FY6EJtKos8ezawBLK+aK8hZw/0EsU0TzoU5GsGYYHWLEFUOPQ6YAi62AgQLb5ZbnkKqp9r7ymmkvnfoakyzgK3VQxK84+9PHActldX3bBGW36JKGnLor/aJnArq6Iye4jf1k+krUJ7pQlsMX8ygD4HdgY2Uw9RifXdLDhMyrghflsbGly107CASrvJPCF1UQaP8z7yv23Sf705+vMsc2Af+aviS/ruaGRfwPnHnbag+RkPdjuOOvUARfvBmxkHE6NGTrvWeGfVpv+p0UlRWrnLwYMNczvagcSsMVSBTpkn/2X7QoV4wPeEUxV2jvs+nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEXhTytw8JOXreLhj9ENti8n6o9DDgPbgxNKj8uojrI=;
 b=bA6Dlcz33lKPRqSrNQGb7SsvBisUHfccGOCYuTYZfldwWQBns+iFlTsVQT+DOd5y3hzfdDyMuY/AQLKmW7rnA9uzQk1OcYrAuQvwbglAMc6unTX9puYYFjvWRFuGGUF5nkK09JkK8DxW2CoFdzVV7Y4D31vwo60P+JuOWfKnHewObZ1U55NZa9STxSBYtqZwwr6sst74yqytw0xYErlxBZ7RmEM3MJ+cRtsq1AezKMjpTmzZCY3OWi3sGgOdD6P50z/JKFCqbdLYNjfm92kjbi8aE3pTAoPD7XGI15BpE8W7HdfQiFtkhX8tTniw7/GKH/2729aY6xaX2v9OsZ8Wsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:de::19)
 by YT3PR01MB5250.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:62::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Thu, 23 Nov
 2023 20:24:55 +0000
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5cd5:f7d:297b:a1e8]) by YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5cd5:f7d:297b:a1e8%5]) with mapi id 15.20.7025.021; Thu, 23 Nov 2023
 20:24:55 +0000
Message-ID: <a3f45b7b-fbb3-43e6-a823-4e1433354903@efficios.com>
Date: Thu, 23 Nov 2023 15:24:53 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US, fr-CA, en-CA
To: Bruce Ashfield <bruce.ashfield@gmail.com>
Cc: lttng-dev@lists.lttng.org
References: <20231123193249.3190764-1-bruce.ashfield@gmail.com>
 <20231123193249.3190764-3-bruce.ashfield@gmail.com>
 <2c0e2bb6-470d-45b7-af19-cbe0bd7eb280@efficios.com>
 <CADkTA4MJwtamzZxaV9tY56aCM5NdKvWj9tAiNW9nhuez6VLJDw@mail.gmail.com>
In-Reply-To: <CADkTA4MJwtamzZxaV9tY56aCM5NdKvWj9tAiNW9nhuez6VLJDw@mail.gmail.com>
X-ClientProxiedBy: YQBPR0101CA0194.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::23) To YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:de::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9793:EE_|YT3PR01MB5250:EE_
X-MS-Office365-Filtering-Correlation-Id: cbed0c8b-59b1-4b3e-0034-08dbec624180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wuo3TruktOEHwdxI/WPar3RsllutsUqC2U2JujcyxFTQE5JlGRXHeXXKLq/DqMmHeXwY81EaTY6uef4qIAF1JFCmKW540SxPp6XeHoJQ3SlS1wD0CezXA9eHB6u5/ValUkvsBI1D1LNFTLlM+1irEajWX9z1JpqFcvSmqJc7349QJyK+ZFuSa5VIRaBfp8ESrsCqQaOEriOEJ/q8qqq5DnPZNK7Prj7mrDiisSo/eODX2hUUll8rHewYvVZPFqLr6B+JiRcyxKoLkTpjJVUIhLQL+JT5AUyGEqck8c3sbZyz7vHRCaAoIPt7crjqFgl8MopTFereU/OqM2GT3sVP77H+/irZuaVExSdtWjoXnCSfBsCKWJb2HlMSkuCjGYqRW6eX1vDS+Hf762UfG+KCNggPcSCGpKLB1NKJZD3fgZAa9d9B8TcwH22dB6vYnc7dmnPP9Pe8mJCiPd/PeEzLRzy+DKDrHm4D+ABok67qAQZ9k/Rpz2FXSZFGidLbOaeiawBg22eUtHtRSW8YRat46wWCd5odCRr2P1r3fV/CBzUq4v75bPtfeuwUr/ASF7gGDE5F63D/F1UJKA5go/qPotlSn/fkxq5OyqbARVXDsn38rOe5VHLdsE6OYxaEABeclUOqkUKIokhpm/epIDDFqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39830400003)(396003)(136003)(376002)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4001150100001)(5660300002)(2906002)(8676002)(66946007)(8936002)(6916009)(66476007)(66556008)(316002)(4326008)(41300700001)(966005)(6506007)(6486002)(478600001)(53546011)(31686004)(26005)(2616005)(6512007)(38100700002)(83380400001)(36756003)(86362001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmdlQk1yc1RvUUw1MDU3aTJDUzFHUFJjUHZHeU1kSUxiTGIwUENWK3ZweDVF?=
 =?utf-8?B?SlU4V2RkT2MwRkcyQVMweUFnSUxyZjRKN0tWN296Q0tvbWR0Q2NTNlgvay8y?=
 =?utf-8?B?b1RUKzgvSzR2NitwYlZsTVk5ZHVKM0lQZmN5T3ZpU2R3M1h4NXFVeHplM1hn?=
 =?utf-8?B?WkxOelhEaFdGVUtnQ0dSejR5K0dGMExzaHZiWXlsR1QyZWZSanhiN2dCY1RP?=
 =?utf-8?B?SW5iVFBCU2JNdllpYlRHbm8xOVZpOGdYVEE5eURKdUtkZ0F4M1JkWmtXcWpm?=
 =?utf-8?B?clpiM1dQZ1dVMFAwdldIazNLSEQwNlpidU9TN2FsTFhwV3ZORWF6STYyWUhO?=
 =?utf-8?B?cHF5eEJJSGhLb3NIaDlXbGhVMS9VWHVqR1QzelJDbEtkOG11enA1YkdXRmlT?=
 =?utf-8?B?aWNpYXF6WUxCdG1oRzdpckk1dDhWcGh2QTFsVEFoa2pDTkJ1YWNYOE92VHNX?=
 =?utf-8?B?NFFsNGNIbEhxVTUxa0FiOEFYVklYNlJxdGpQNnpxTk9ZdmdPSWJuNHY5eEhB?=
 =?utf-8?B?MllWMSt0L1FWTXEwZWVtVHd6N1F1YkErS3FGaFdWazliVlhuMjdxZ0tYQ3Zu?=
 =?utf-8?B?LzFrWXJ3aytxanQxNDFWRnVIbDlaVlg1OG5qSWJQN1NKTno2Zjl5SFIvWmNz?=
 =?utf-8?B?WWdpTVEzU3E3UlU1dnRZRlArc1BheXQ2cm1FcFlENm5VdllmMUZ0c0FTb3c0?=
 =?utf-8?B?bjNhckcwMDJPMkVYOTBVSnlmNmtGZU5Ta21vdmJGd09oK1RxbHJrQktBa0px?=
 =?utf-8?B?ZFpMYXBsc2Q3MDJtSmFHSXdPQktOeWl3R0N6V0o1TTB5bHVXMTZZNmh1Q3Vw?=
 =?utf-8?B?amlVSHhIVFF1N2xMZ2hIOHdUMU02UUV1WURvWmsvQWh6enFKV01ncTJJWXMy?=
 =?utf-8?B?YkkvNEdQYXJMdlFLK0VCemxoT3haZENGSDJuSzZMOFFPc1NqY3BSNDJQb1FE?=
 =?utf-8?B?N2RBZzN0aExYdDVtUWQ4bEVYcUFsc0FiTVVmdHJUR0ljdnZISlFWZ0RldlE4?=
 =?utf-8?B?ZFlydkZ5eUx3QjB4V1MrZ2ozUGJ3dFNwVXUzTC83MnNBemdlRHpHQWJ2bXFP?=
 =?utf-8?B?LzZBWXp5Y1lrWmdJWHdNcWlHa0VsQXEwUWc2d0FWUERia2dMV2VlRjNKQVhi?=
 =?utf-8?B?Mm9ESDZ2ZnNJcy9qeGE5UUEzMVZmTktnNzlPMDFwbk9XSXNDUXFkOFV3YThO?=
 =?utf-8?B?T1FmeStXNEhSb2pEbkdSZW9iRzNwb0lCTkc2a1hnNVcrWkxhUVozUHpVYWZx?=
 =?utf-8?B?MmxyTEd2SVN2Z0h3SUdPUG5UWjV2U3dJMWlwN21DQUMwZDdMMWxYSlhYeWZM?=
 =?utf-8?B?VXFGNnV1cGdnL1JxWjZjRk90VytoUko1cDZ3UUJ0RUN5d3lJOXRCWHE3bHB0?=
 =?utf-8?B?eEJ5WGovSFBiUkVtRDhsd2N4cWk5ZVZYYXFCMHBDMUlEZkRTQm1YWFZTSzFq?=
 =?utf-8?B?cUFEalRZbHZKVkoybVpLNy9ESFdhOUY1WWdXNzN5bkM4cmFTUURtWHJwL2Zw?=
 =?utf-8?B?RUk2V2oxMTh5dDFUcjJEcTB5djhiaHBHaUtweW56SG8wTjUrWGlXb2JWbFVU?=
 =?utf-8?B?RUw1cjdxN3AzdzNkMTAyQWdMZVAwTlhLNFd3bHdxTUVVMnlYWXBvTzIza1Zy?=
 =?utf-8?B?UTQyWUpSWGwxSlcyaGZWTjZUODdaeWxCNTd1dmJRdmpKRDFpNmVkZ094Vlpy?=
 =?utf-8?B?SVRoRGgxMUV1cTJCL1R0TTcwK1JUbGRIb3JzM0pUQ2lpalVPOXNRRDBzUXNZ?=
 =?utf-8?B?Zk5SWGJ5NHVGTnhnRTN4U1I3dWZuUmVEU1pVQmtEcytuZHdjeXhOdG51V0M1?=
 =?utf-8?B?QlBpanhxWVgzT0xGbllBMGdGQnVKNWp4a1ZIVThCRmw0UGE0dG0rSGtGWUQ2?=
 =?utf-8?B?dWpuL0NZY3FCZk01M1BWek5aSXJaUHV2Z3NFaElseVUrQm5RNDlIVkVwdFZE?=
 =?utf-8?B?bDFrVVI3YWNZbEtJcWZnNkpHYUl2Z1pXazlOVVVwblhqUmd5WkNXbTJtL0Rv?=
 =?utf-8?B?Mmdid1pyQUhlS3F3ajlPcy9RWFpMS3U0NlJtTkRUQlQ2eUYvWHF5MHRHSG01?=
 =?utf-8?B?TDUyc3B6WXhURGkwMm5IcWhldXkvVHY5Um4vSHV3VWhXVTZWcVJIL2VUbkRa?=
 =?utf-8?B?bHkxSFRRWHhSZzNMd2ttam5pcUJQMCtYRU5JVGxRL2xKY1ZUaE42VGMrb2h2?=
 =?utf-8?B?NkE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbed0c8b-59b1-4b3e-0034-08dbec624180
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 20:24:55.3855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SnoizKkYmHkbr3Ar/Wy1JONpQO3bxzSzXBWo+O4CaDc8VJGeL2iOsTXMVYCgOjd+xwI5hU2d9vTSD+7eV/ohHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5250
Subject: Re: [lttng-dev] [PATCH 3/3] vmscan: drop isolate_mode (v6.7+)
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

SGkgQnJ1Y2UsCgpPdGhlcnMgbWF5IGNoaW1lIGluIGhlcmUgYXMgSSdtIG5vdCBzdXJlIEkgaGF2
ZSB0aGUgZnVsbCBjb250ZXh0IG9mZi1oYW5kLgoKT24gMjAyMy0xMS0yMyAxNDo1NiwgQnJ1Y2Ug
QXNoZmllbGQgd3JvdGU6Cj4gQWhhLAo+IAo+IFNvIHRoZSBtYWlsaW5nIGxpc3QgaXNuJ3QgdXNl
ZCBmb3IgcGF0Y2ggc3VibWlzc2lvbiBhbnltb3JlID8KClBhdGNoZXMgc3VibWl0dGVkIHRvIHRo
ZSBtYWlsaW5nIGxpc3QgYXJlIHJldmlld2VkLiBUaGF0IGJlaW5nIHNhaWQsIEkgCnRoaW5rIGl0
J3MgZmFpciB0byBzYXkgdGhhdCB0aGUgcHJpbmNpcGFsIHdvcmtmbG93IGhhcyBzaGlmdGVkIGF3
YXkgZnJvbSAKdGhlIG1haWxpbmcgbGlzdCB0byBodHRwczovL3Jldmlldy5sdHRuZy5vcmcgLSBt
YW55IHBhdGNoZXMgYXJlIHJldmlld2VkIAp0aGVyZSBhbmQgbm90IHBvc3RlZCBvbiB0aGUgbWFp
bGluZyBsaXN0LgoKSSB0aGluayBzb21lIHBhdGNoIHNlcmllcyBhbHNvIGdldCBzdWJtaXR0ZWQg
dG8gdGhlIG1haWxpbmcgbGlzdCBpbiAKYWRkaXRpb24gdG8gaHR0cHM6Ly9yZXZpZXcubHR0bmcu
b3JnIGluIG9yZGVyIHRvIHNvbGljaXQgYSB3aWRlciAKZmVlZGJhY2sgZnJvbSB0aGUgY29tbXVu
aXR5LgoKPiBJIGRpZG4ndAo+IG5vdGljZSBhbnkgdXBkYXRlcyBpbiB0aGUgUkVBRE1FcywgZXRj
LCBzbyBJIGp1c3QgZmVsbCBiYWNrIHRvIG15Cj4gZXhpc3Rpbmcgd29ya2Zsb3cuCgpZb3UgYXJl
IGNvcnJlY3QgdGhhdCB0aGUgUkVBRE1FIGZvciBsdHRuZy1tb2R1bGVzIGRvZXNuJ3QgbWFrZSBh
bnkgCm1lbnRpb24gb2YgdGhpcy4gVGhhbmtzIGZvciBicmluZ2luZyB0aGlzIHVwLCBpdCBzaG91
bGQgZGVmaW5pdGVseSBiZSAKYWRkcmVzc2VkIQoKSSdsbCBnbyB0aHJvdWdoIHRoZSBSRUFETUVz
IGFuZCBDT05UUklCVVRJTkcubWQgZmlsZXMgdG8gbWFrZSBzdXJlIHRoZXkgCmluZGljYXRlIHRo
ZSBjdXJyZW50IHdvcmtmbG93cy4KCnRoYW5rcywKa2llbmFuCgo+IAo+IEkganVzdCB3YW50IHRv
IGtub3csIHNvIEkgd29uJ3Qgd2FzdGUgdGltZSBpbiB0aGUgZnV0dXJlLgo+IAo+IEJydWNlCj4g
Cj4gT24gVGh1LCBOb3YgMjMsIDIwMjMgYXQgMjo0OeKAr1BNIEtpZW5hbiBTdGV3YXJ0IDxrc3Rl
d2FydEBlZmZpY2lvcy5jb20+IHdyb3RlOgo+Pgo+PiBIaSBCcnVjZSwKPj4KPj4gdGhhbmtzIGZv
ciB0aGUgcGF0Y2hlcyEgVGhlcmUncyBhIHNpbWlsYXIgc2VyaWVzIHdhaXRpbmcgZm9yIHJldmll
dzoKPj4gaHR0cHM6Ly9yZXZpZXcubHR0bmcub3JnL3EvdG9waWM6JTIyZml4LWxpbnV4LTYuNy4w
LXJjMSUyMgo+Pgo+PiB0aGFua3MsCj4+IGtpZW5hbgo+Pgo+PiBPbiAyMDIzLTExLTIzIDE0OjMy
LCBCcnVjZSBBc2hmaWVsZCB2aWEgbHR0bmctZGV2IHdyb3RlOgo+Pj4gRnJvbTogQnJ1Y2UgQXNo
ZmllbGQgPGJydWNlLmFzaGZpZWxkQGdtYWlsLmNvbT4KPj4+Cj4+PiBjb21taXQgM2RmYmI1NTVj
OThhYzU1YjkgW21tLCB2bXNjYW46IHJlbW92ZSBJU09MQVRFX1VOTUFQUEVEXQo+Pj4gbWFrZXMg
dGhlIGlzb2xhdGVfbW9kZSBwYXJhbWV0ZXIgdW51c2VkLCBzbyBpdCBpcyByZW1vdmVkLgo+Pj4K
Pj4+IFRoaXMgdXBkYXRlcyB0aGUgZXZlbnQgdG8gbWF0Y2guCj4+Pgo+Pj4gU2lnbmVkLW9mZi1i
eTogQnJ1Y2UgQXNoZmllbGQgPGJydWNlLmFzaGZpZWxkQGdtYWlsLmNvbT4KPj4+IC0tLQo+Pj4K
Pj4+IFJlcGVhdGluZyB0aGUgY29tbWVudCBmcm9tIHBhdGNoIDEgJiAyIG9mIHRoaXMgc2VyaWVz
Ogo+Pj4KPj4+IFNvbWVvbmUgZWxzZSBtYXkgb3IgbWF5IG5vdCBhbHJlYWR5IGhhdmUgdGhpcyBp
biBmbGlnaHQsCj4+PiBidXQgSSBkaWRuJ3Qgc2VlIGFueXRoaW5nIG9uIHRoZSBsaXN0IG9yIGlu
IHRoZSBnaXQKPj4+IHJlcG8uCj4+Pgo+Pj4gSSByYW4gaW50byB0aGlzIGZhaWx1cmUgd2hlbiB3
b3JraW5nIG9uIHRoZSB2Ni43LXJjCj4+PiBrZXJuZWwgYXMgcGFydCBvZiB5b2N0byBwcm9qZWN0
IGtlcm5lbCB1cGRhdGVzLgo+Pj4KPj4+IFR3ZWFrIGFzIG5lY2Vzc2FyeSwgYXMgSSdtIG5vIGV4
cGVydCBpbiB0aGUgcmlnaHQgd2F5Cj4+PiB0byB2ZXJzaW9uIHRoZXNlIHNvcnQgb2YgY2hhbmdl
cy4KPj4+Cj4+PiBCcnVjZQo+Pj4KPj4+ICAgIGluY2x1ZGUvaW5zdHJ1bWVudGF0aW9uL2V2ZW50
cy9tbV92bXNjYW4uaCB8IDEwICsrKysrKysrKy0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA5IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9p
bnN0cnVtZW50YXRpb24vZXZlbnRzL21tX3Ztc2Nhbi5oIGIvaW5jbHVkZS9pbnN0cnVtZW50YXRp
b24vZXZlbnRzL21tX3Ztc2Nhbi5oCj4+PiBpbmRleCBlN2U5YjYxMy4uYTNlOWRkZjIgMTAwNjQ0
Cj4+PiAtLS0gYS9pbmNsdWRlL2luc3RydW1lbnRhdGlvbi9ldmVudHMvbW1fdm1zY2FuLmgKPj4+
ICsrKyBiL2luY2x1ZGUvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9tbV92bXNjYW4uaAo+Pj4gQEAg
LTM0MywxMiArMzQzLDE4IEBAIExUVE5HX1RSQUNFUE9JTlRfRVZFTlQobW1fdm1zY2FuX2xydV9p
c29sYXRlLAo+Pj4gICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBucl9zY2FubmVkLAo+Pj4g
ICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBucl9za2lwcGVkLAo+Pj4gICAgICAgICAgICAg
ICAgdW5zaWduZWQgbG9uZyBucl90YWtlbiwKPj4+ICsjaWYgKExUVE5HX0xJTlVYX1ZFUlNJT05f
Q09ERSA8IExUVE5HX0tFUk5FTF9WRVJTSU9OKDYsNywwKSkKPj4+ICAgICAgICAgICAgICAgIGlz
b2xhdGVfbW9kZV90IGlzb2xhdGVfbW9kZSwKPj4+ICsjZW5kaWYKPj4+ICAgICAgICAgICAgICAg
IGludCBscnUKPj4+ICAgICAgICApLAo+Pj4KPj4+ICAgICAgICBUUF9BUkdTKGNsYXNzem9uZV9p
ZHgsIG9yZGVyLCBucl9yZXF1ZXN0ZWQsIG5yX3NjYW5uZWQsIG5yX3NraXBwZWQsCj4+PiAtICAg
ICAgICAgICAgIG5yX3Rha2VuLCBpc29sYXRlX21vZGUsIGxydQo+Pj4gKyAgICAgICAgICAgICBu
cl90YWtlbiwKPj4+ICsjaWYgKExUVE5HX0xJTlVYX1ZFUlNJT05fQ09ERSA8IExUVE5HX0tFUk5F
TF9WRVJTSU9OKDYsNywwKSkKPj4+ICsgICAgICAgICAgICAgaXNvbGF0ZV9tb2RlLAo+Pj4gKyNl
bmRpZgo+Pj4gKyAgICAgICAgICAgICBscnUKPj4+ICAgICAgICApLAo+Pj4KPj4+ICAgICAgICBU
UF9GSUVMRFMoCj4+PiBAQCAtMzU4LDcgKzM2NCw5IEBAIExUVE5HX1RSQUNFUE9JTlRfRVZFTlQo
bW1fdm1zY2FuX2xydV9pc29sYXRlLAo+Pj4gICAgICAgICAgICAgICAgY3RmX2ludGVnZXIodW5z
aWduZWQgbG9uZywgbnJfc2Nhbm5lZCwgbnJfc2Nhbm5lZCkKPj4+ICAgICAgICAgICAgICAgIGN0
Zl9pbnRlZ2VyKHVuc2lnbmVkIGxvbmcsIG5yX3NraXBwZWQsIG5yX3NraXBwZWQpCj4+PiAgICAg
ICAgICAgICAgICBjdGZfaW50ZWdlcih1bnNpZ25lZCBsb25nLCBucl90YWtlbiwgbnJfdGFrZW4p
Cj4+PiArI2lmIChMVFROR19MSU5VWF9WRVJTSU9OX0NPREUgPCBMVFROR19LRVJORUxfVkVSU0lP
Tig2LDcsMCkpCj4+PiAgICAgICAgICAgICAgICBjdGZfaW50ZWdlcihpc29sYXRlX21vZGVfdCwg
aXNvbGF0ZV9tb2RlLCBpc29sYXRlX21vZGUpCj4+PiArI2VuZGlmCj4+PiAgICAgICAgICAgICAg
ICBjdGZfaW50ZWdlcihpbnQsIGxydSwgbHJ1KQo+Pj4gICAgICAgICkKPj4+ICAgICkKPiAKPiAK
PiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmct
ZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMu
bHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
