Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9035EC3DA45
	for <lttng-dev@archiver.kernel.org>; Fri, 12 Jul 2024 14:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1720794782;
	bh=6p1QvIg4MpdtF/P6kbh2HNTLrEGb6/zUMY4npmDjMzU=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=EKIVOies7cGx5Di4639BiuQICc+yJWZTfW6T7QGf3hpc/aKqtCt33JBfr2Les/ceR
	 kkoVyF2Cty8UrvLt9O014zNdJfUsUN7/KfvtF6crhaYikF1toyQKVfgokszBzbzQLK
	 qHhrMZW4PjHLIahj2irgw+cUBDm+eaAPZhkIrV2hpdMwPUIs4gpAy86lKQ+ERyAL6c
	 F8UJmVwRjWAG3CC6ipxOpQOk9Vacfhi2yq2klP6Ef/4k4vDnTyNCCkDnqiiF6aL/JP
	 khjgL9vWHG//BOcTz1vABrNKdLH11kkzlZa7egFNddjiSu5uUfM6Rq3357GqZ3X6kz
	 zogy7YU4fmvPQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4WLDbL3cJhzBSG;
	Fri, 12 Jul 2024 10:33:02 -0400 (EDT)
Received: from YT5PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazon11021133.outbound.protection.outlook.com
 [40.107.192.133])
 by lists.lttng.org (Postfix) with ESMTPS id 4WLDbK1Hp2zBTF
 for <lttng-dev@lists.lttng.org>; Fri, 12 Jul 2024 10:33:00 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WID40SylTWEitbWiPMwbTc36qWmH0COtZsF5P6EzTySegKSLOYzs09wuYtYB2jCckUuU6GXcItWn+zySDm2SiGNukRdJMA5i6FlZl06KjYHDEGvhVLmoArkJaQ7NA/MaBlSErSdpq6Ys8VN6j3lkTpLg6HBsSlLCVOUNO5lzDBlNUo21r/Z2wlWiqFVk7Mf/XEp8CQZlOKjTG1jJ1RY5OXGlzxIVBtgYE7Pfiu/p8/JZQrJaDKEoUe27CC813gVhYbBDLnOZyfODXx574/LXy/doTkfUsO3FfPmn/VY9Wp+BM2mEowj+ESmsThsEcqZrPJjLSCAyaS12K5V8GNJ5Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifhpw4MyimtZWHaQ4CXQrjhXoJrq5QN9RRGl3+wLmrA=;
 b=SR3e/LnI1DmYO2L5k0+oR40U2hmrsLwF7QiNOAxCRmNZKklqmtGNtPZiY7IjKnhIlsRT2GwWtyniBuhHJX2cfqR0XMUbdKWfXoScCmQce2aPsXIjhHLcfQBwEiRl4QgL6G8Q/e7UuTLTI18CakwZfIGWvWFz2pcXJ1r28xEMBFXqGlH0QtIUGIZ1Mx783maExJf9J775RPkssNgI9A2le1TPqdGCfIeJgNH14kvdnp06qgP1Kl9oKbTX2QxOYTBtfrnhBUFxP9qFxD5TVSeWCve7toKeTzDc98gyPwQ4V/SJbIjQe5mNxY8wWmt9FTZVKtu3FiWZIoRv9m1P+pNhng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT3PR01MB5251.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:60::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 14:32:57 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 14:32:57 +0000
Message-ID: <b049c5c5-e77f-4ac8-9937-2eaa7268d4df@efficios.com>
Date: Fri, 12 Jul 2024 10:32:55 -0400
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Fran=C3=A7ois_Belias?= <beliasossim@gmail.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <CAHD10UjRBLgAWAAfgOLVgxv3zMYkedtWjquOdC60XTPDifEeJA@mail.gmail.com>
 <003921f8-df16-4573-ba6a-7ef8821f4863@efficios.com>
 <CAHD10Ui0JtFCWY9ND_VxdfYBiF=iOK-SJTfjwZQ6QyQgzLBZBg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHD10Ui0JtFCWY9ND_VxdfYBiF=iOK-SJTfjwZQ6QyQgzLBZBg@mail.gmail.com>
X-ClientProxiedBy: YQBPR0101CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::28) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT3PR01MB5251:EE_
X-MS-Office365-Filtering-Correlation-Id: ab565f92-71b7-4d94-0228-08dca27f85ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3NkK1RCbzVIWGJKSTcwRnlkZVFqcWRBMklSVm9obEt1dmUwREpyOVBsRm5U?=
 =?utf-8?B?b2ZKdTN1WDd6MzJqVEJFNU9XUnhNZ3BrS3drc0FaQ3VOZG4zQUx6eWtoN0Fp?=
 =?utf-8?B?SlpUc3E1NHNUcVFtT1QrNWNZb0tSQzU0RTZldnRteEVqYjIveXBQS1kyOXdF?=
 =?utf-8?B?dStaZS82WUFxdWVmbmEwMUFXcnplaHp2UE5KMEFLUmxHUXpOWkpTTmdLUmZU?=
 =?utf-8?B?eHJlQUgxcFRKbkpqaU1na3VLY295U3ZjeVRvZVRNNzZxYXI3elZzRWwzSTJs?=
 =?utf-8?B?NzI3YzRJUExqai91TFl1N3JrT254b3N4OGpIY2lhSnVBRmtTaWcyNGhoUTl2?=
 =?utf-8?B?U3YwUGVBWW5ud2Ixbm03aFpCeEFNMG5kR2t0cHRTbkJLR2hSZDN5bDVkQTZY?=
 =?utf-8?B?NUthd0NPSWpINyt2MXhSQkxQam5OOVB0Z3VBK3pveWhmSlc5aERGL2VmQ3ZG?=
 =?utf-8?B?OEJ1UDZpZzZVSGhianlESXc4Mm10UDE2QWFidDZYalNJZXA0akorSWMrRWxu?=
 =?utf-8?B?UDFRV3pzaVJpazhjazVNS21BNG9sK3pWOENYc3lJYitkcWFXVWpZNS85OFdO?=
 =?utf-8?B?ck5uVzNIOGp0SW91ODU0TWpkSkgwb1FhTzhsSjl5K3pJN3g1NFozOWtobFk3?=
 =?utf-8?B?M1ZUa2V6dGJrbDRKczJWVnZCRE1iSjY3RlVVRCtuU3AvUGVNbzNkQmJiMnY2?=
 =?utf-8?B?M28wNXpPb1hLOVROaWZMVmN1WU82eGxRRzZZVDk4VWZrL2J2aUdzZkVoSno4?=
 =?utf-8?B?Rlo2RGRJMVNRdmtUaUNvOWtBYm8xc0h0enRHaXRlc2x0WWpvZVNhU1NHVjd4?=
 =?utf-8?B?MW52ekNjNVlZY2orcjN2eFdNdzMwdW14UUFqVGZhQVRpMnRjTHQ3L25UUlFX?=
 =?utf-8?B?YVp5M0J3cWN3MlhXK2FrRTlNSlN3anV3WERNeEgwSEVVd2syZmx3ZXJQZ0ZF?=
 =?utf-8?B?dU5BRkN5UW44WWhESTlRdS8rZEdHd1M2UW1Td3ZsV3Q5ayttOU5Fb1lXUjl1?=
 =?utf-8?B?QmFtejdMTkdzbm1SbVpOQTZNSE1DcWhHdUMyNW5QZkY2Ti8xSmdWa3pBNTB6?=
 =?utf-8?B?bjdqSVJQRVN3cVJCS0h1YUpSenV0UjFIRjZjcUczVy9kM3hQbUJhLzRuMkt4?=
 =?utf-8?B?MWNUM1NrMDM4OTM1WCtJVnArdi9EcW5CRDA1ZnExNVdsWGxRRnpGazZ2aHJa?=
 =?utf-8?B?cUEyNnFLWnZ2b2ovakVHeWNReCt2eHdkVnVNMTdtaVgxSGdsSDArMWJ0SmlV?=
 =?utf-8?B?UWhFSnNjWVBIMVZUSDFyMStqc3RPZEtrRWNBQlFhSkRySXJTMDV6Z3FzWkNl?=
 =?utf-8?B?bFhuTEFpMlpVZ1FLMHJLbSt4L2UyeDBsZGVsLzUyVnJNMU9xR3JQRHVsQ3Fz?=
 =?utf-8?B?dUJ3dlVmTXl3VlZIM283bTdGbi9YZFBsQ3pCbDZnT1N2cE95R1VKSmdSZ0dO?=
 =?utf-8?B?QTQ4Zmxoa010dlNIVzZWUHB5ajZsTVBUZXUzc0gyMjBTQVZDWEN0VjhWVjNV?=
 =?utf-8?B?b1Zwa2xYTlFiUTFvRlowVlYxNkR2dGNlRUR1ZDhibWdjZVd6UDZ4YkR5dzNX?=
 =?utf-8?B?QlNYRjJFeHdmQUhXQnRmcDhnano4Zm9WU0xuVkxUY1BmZ0p4dWFEcDg4bkxr?=
 =?utf-8?B?anlGNTZNTDdHR1pGbTN1dVRlVnQ5ZW9wZWl4QWdnK0hwNjFNbGNJRnNqQ09T?=
 =?utf-8?B?MllMSUtUUEpQVllyWGpES0t1ZHhmVGkxMGdleVlLakZGTi9XYjhWeFVnZmlO?=
 =?utf-8?Q?SbXGdF3n+q3p4jhmus=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDlJdnh5NFhYc1NBcmJGU0VBWm51Vjh0YktSVThFVXkwUVdFa09kY2Nyd0d4?=
 =?utf-8?B?ZWJmR1hES1h0cUdxS29nNmIwTm00amZYV3FsMDNnbnQzaml1TG9SSi9FdGkw?=
 =?utf-8?B?VVBNYXdHTTlsMEJNcCtBSTBTdEJYYmx2cU92WmhoWURwK0x1UDJiVW1kWEMv?=
 =?utf-8?B?dTRreTc4RkdxNDgxTk9CSWR0RU1ISjNQZXNqVzVkcTdpY3c4aEFKb3NHN0V1?=
 =?utf-8?B?RkJYZ0JYZnRNME1PNXFWMHBtbnBvYURhS1o2MklnaEtQTnRqU3BKOHArbkRp?=
 =?utf-8?B?UHc1QzZIUkg4aXlSRmo5NDNaYkxGamVVcVd6MzN6TzJNczBocmtXZHdpWStx?=
 =?utf-8?B?ODEzMnYxQzA4L2YvQ1ZHdzRENEc3c2RIOFhzOXR0YzJlMGJOZ3JxODJYS0ZX?=
 =?utf-8?B?a1BDQUwyOVVLZTRjZG5zdGw4MHZDTmVxdTluVDZLYm1hRk9vNTRXTVFvM2dw?=
 =?utf-8?B?QVlXQ3hHN1gvT2NRNEZXeEMvUHo1R1hWeUMycm1MaTlVTE9udnoxVHpWOCtW?=
 =?utf-8?B?d2NwT1hweC82dW1mZmdIUzFDRXUzbEViemVpTzFTWjVQMERqeWtxMGxET2pv?=
 =?utf-8?B?Qmp3MER0LzNhaXYwdjFHZTBrdnBaQ2N2c1lka1NLSE1kSGswdFQ3VWZxK3Vu?=
 =?utf-8?B?QnVRd0xDMDlDNytXdDVxTDVpVzBJUzdnSGg0emRSR1A5UnpiSFkwNjZjTzd0?=
 =?utf-8?B?eHVTYzY1TFVnVjBoQTltbzFsbVZhNlRrblBwb2NkN1ZpcHphenExcnZJUUFP?=
 =?utf-8?B?eENOamdSM2V6cHVpbzBnVHoyZmU1QmtheXhxRHFPckwrazlJSXoxS2dmYzQz?=
 =?utf-8?B?dFpmb0hHNnpOOTBQOXhFQ2JGZ0pVd3Q0WFNzM0RqdzJMaDFPT1pva1NKdVMz?=
 =?utf-8?B?QXRLek41LzVuWjlLVGdsSzJ2NXlPY3NxdDJRZWtScWRoN04zdi9JNHlUV1NZ?=
 =?utf-8?B?TkV3eGpxcjZwMmIyU0llc3ltaXdCUzhVaVp3emRhRitLYjFxeDhxTXNxZmhp?=
 =?utf-8?B?d3U1WDduZFlWWXRkanV5azBZdE5aU0haSG5CYTBBOEV6MGZqaEMycXBjcW1w?=
 =?utf-8?B?NW9wbDBrZU93ZUQ5ZVoybHRMY0ZFVmZJbUUrRnlvb000NHNNWmFBdE1FQXBM?=
 =?utf-8?B?QmF0aldWellqQkpPZlN0QWhBY3ZjWDYxek9vSmFGcWwwcjRkVitRTXM3N1RG?=
 =?utf-8?B?c085OW9mVnhNYlg2OW43R1Nkd0k4RklvdHFlSkErNkZ0SVQ4cjdnTU9NQjhy?=
 =?utf-8?B?REloQnZ4dGNrTkhSMkJBdlUrd0pIb3N4eWkveG5zd0ViK1RzemNaaVg5WExs?=
 =?utf-8?B?MmkyQW5aOTlQT2V5KzEyN1NDV2xwNXltbHM3eno3UVZRWmhJbDJkZXRBbWpK?=
 =?utf-8?B?aU1BNk13MUVyZm8yVVFvdFNKQVBKUFJqdTBLaEhhT3ViQWNVbW4zS0lub2pH?=
 =?utf-8?B?cGhRZzExLzVQRWJLd0k4YW5JWUlCZk01STgvVVRjQVVDeWlFdVpUMmRCT3d6?=
 =?utf-8?B?NTVYa2syeUJJdmpkNURyYVBWNDd4V09jUk84bjFIa2dDVkhOM0FmZHpzTEF1?=
 =?utf-8?B?TmZBTEMxcEFvMFpxUGo5QUpJRDJVMm5tMmRiUldzRCszTDlCeW1MRHBZb2xo?=
 =?utf-8?B?QTg1VGtqaTROUGhXL2VhZGdaRFdDSSsrTDRxaitKWktzRmEydVJiUFJ1OGQy?=
 =?utf-8?B?K3o5WmVkOHdZcGtreTU2NVQ4TlFIZ0kzdDl5N3RJbXc0QW9sNUZ1c1dNckcz?=
 =?utf-8?B?eG9zbXg0MlJXZTB6czdsdXFVQ0pVSlNzdFpUaC9kL3pCb3lvbEFXSy9wMEI0?=
 =?utf-8?B?YzVFNmdmZG9ZbGVEdmdjczZCY0R3Mi95S0pDRVpSMUk0UzNWdjZmb0wwZTI5?=
 =?utf-8?B?L0VYZXpnQVFMZ3pmL0FpZEt3a2hqVEEraHZscG5DUHBTZjJkeHRFRE9wZzJj?=
 =?utf-8?B?SUJDR0w2dCtBUHVUUzRJbU5RVDJFQzVkTXA1YmE5Ulo3cmg3bGpRMCtQNmZV?=
 =?utf-8?B?K3Y2bktRZGdUR3Y0T3FrYnA5eUl3Q0duUFg5RVFvUDhpZmZsSU5nVDBiU3Bn?=
 =?utf-8?B?b2RjL2MxTW9LaVYzYUc3WlNFVFVvSmJJbVpSZmdzQU5wSUhaZXdURXQvRW1K?=
 =?utf-8?B?eHFRMnJFTTBUTTczUmtmcjFNSTBxdHNhY0JNK3hHU0x1TG1LUDBVczVQa09z?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab565f92-71b7-4d94-0228-08dca27f85ca
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 14:32:57.0138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUDU+jaaUoY99E9CeUVgjeDubhDl8fdvhHU0ha6lBYlTFQFrTqjJueQtDWpYvCq06mg8aOyJ9B3tnZwwqUKz4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5251
Subject: Re: [lttng-dev] Undefined symbol error fix
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

SGkgRnJhbsOnb2lzLA0KDQpPbiA3LzExLzI0IDY6MDYgUE0sIEZyYW7Dp29pcyBCZWxpYXMgd3Jv
dGU6DQo+IEhlbGxvwqBLaWVuYW4sIHRoYW5rcyBmb3IgdGhlwqByZXBseS4gRm9yIG15IGFuYWx5
c2lzLCBJIGFtIGFsc28gbG9va2luZyANCj4gZm9yIHRoZXNlIHRyYWNlcG9pbnRzOg0KPiAgwqAg
wqAgLSB2bXN5bmNfZ2hfZ3Vlc3QNCj4gIMKgIMKgIC0gdm1zeW5jX2hnX2d1ZXN0DQo+ICDCoCDC
oCAtIHZtc3luY19naF9ob3N0DQo+ICDCoCDCoCAtIHZtc3luY19oZ19ob3N0DQo+ICDCoGRvZXMg
dGhlIGNhbm9uaWNhbCB1cHN0cmVhbSB2ZXJzaW9uIGhhdmUgdGhlbSA/IHRoYW5rcy4NCj4gDQoN
Ck5vLCBpdCBkb2Vzbid0LiBUaG9zZSB0cmFjZXBvaW50cyBhcmUgY3VzdG9tIGJ5IHRoZSBsb29r
cyBvZiBpdCwgYW5kIG5vdCANCnRyYWNlcG9pbnRzIHRoYXQgZXhpc3QgaW4gdGhlIG1haW5saW5l
IGxpbnV4IGtlcm5lbC4NCg0KdGhhbmtzLA0Ka2llbmFuDQoNCj4gRnJhbsOnb2lzDQo+IA0KPiBM
ZSBqZXUuIDExIGp1aWxsLiAyMDI0LCDDoCAxNiBoIDU1LCBLaWVuYW4gU3Rld2FydCA8a3N0ZXdh
cnRAZWZmaWNpb3MuY29tIA0KPiA8bWFpbHRvOmtzdGV3YXJ0QGVmZmljaW9zLmNvbT4+IGEgw6lj
cml0wqA6DQo+IA0KPiAgICAgSGkgRnJhbsOnb2lzLA0KPiANCj4gICAgIFdlIGRvbid0IHN1cHBv
cnQgdGhlIGZvcmtlZCB2ZXJzaW9uIG9mIExUVG5nIG1vZHVsZXMgdGhhdCB5b3UgYXJlIHVzaW5n
DQo+ICAgICAoaHR0cHM6Ly9naXRodWIuY29tL3RhaGluaS9sdHRuZy1tb2R1bGVzDQo+ICAgICA8
aHR0cHM6Ly9naXRodWIuY29tL3RhaGluaS9sdHRuZy1tb2R1bGVzPikNCj4gDQo+ICAgICBUaGUg
Y2Fub25pY2FsIHVwc3RyZWFtIHZlcnNpb24gYXZhaWxhYmxlIGF0DQo+ICAgICBodHRwczovL2dp
dGh1Yi5jb20vbHR0bmcvbHR0bmctbW9kdWxlcw0KPiAgICAgPGh0dHBzOi8vZ2l0aHViLmNvbS9s
dHRuZy9sdHRuZy1tb2R1bGVzPiBoYXMgdHJhY2Vwb2ludHMgc3VjaCBhcw0KPiAgICAga3ZtX2Vu
dHJ5DQo+ICAgICBhbmQga3ZtX2V4aXQuDQo+IA0KPiAgICAgRS5nLg0KPiAgICAgaHR0cHM6Ly9n
aXRodWIuY29tL2x0dG5nL2x0dG5nLW1vZHVsZXMvYmxvYi8wNmExZmM2MzliMTBiNDBjMGZmYzQx
MmYzZmI2NjM2MzJlNDJkYWU2L2luY2x1ZGUvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9hcmNoL3g4
Ni9rdm0vdHJhY2UuaCNMMjAgPGh0dHBzOi8vZ2l0aHViLmNvbS9sdHRuZy9sdHRuZy1tb2R1bGVz
L2Jsb2IvMDZhMWZjNjM5YjEwYjQwYzBmZmM0MTJmM2ZiNjYzNjMyZTQyZGFlNi9pbmNsdWRlL2lu
c3RydW1lbnRhdGlvbi9ldmVudHMvYXJjaC94ODYva3ZtL3RyYWNlLmgjTDIwPg0KPiANCj4gICAg
IHRoYW5rcywNCj4gICAgIGtpZW5hbg0KPiANCj4gICAgIE9uIDcvMTEvMjQgNDowNiBQTSwgRnJh
bsOnb2lzIEJlbGlhcyB2aWEgbHR0bmctZGV2IHdyb3RlOg0KPiAgICAgID4gSGVsbG8sDQo+ICAg
ICAgPg0KPiAgICAgID7CoCDCoCDCoCBJIGFtIHRyeWluZyB0byBhY2Nlc3MgdHJhY2Vwb2ludHMg
ZnJvbSB0aGlzIHdlYnNpdGUNCj4gICAgICA+DQo+ICAgICBodHRwczovL2FyY2hpdmUuZWNsaXBz
ZS5vcmcvdHJhY2Vjb21wYXNzLmluY3ViYXRvci9kb2Mvb3JnLmVjbGlwc2UudHJhY2Vjb21wYXNz
LmluY3ViYXRvci52aXJ0dWFsLm1hY2hpbmUuYW5hbHlzaXMuZG9jLnVzZXIvVmlydHVhbC1NYWNo
aW5lLUFuYWx5c2lzLVVzZXItRG9jdW1lbnRhdGlvbi5odG1sIDxodHRwczovL2FyY2hpdmUuZWNs
aXBzZS5vcmcvdHJhY2Vjb21wYXNzLmluY3ViYXRvci9kb2Mvb3JnLmVjbGlwc2UudHJhY2Vjb21w
YXNzLmluY3ViYXRvci52aXJ0dWFsLm1hY2hpbmUuYW5hbHlzaXMuZG9jLnVzZXIvVmlydHVhbC1N
YWNoaW5lLUFuYWx5c2lzLVVzZXItRG9jdW1lbnRhdGlvbi5odG1sPiA8aHR0cHM6Ly9hcmNoaXZl
LmVjbGlwc2Uub3JnL3RyYWNlY29tcGFzcy5pbmN1YmF0b3IvZG9jL29yZy5lY2xpcHNlLnRyYWNl
Y29tcGFzcy5pbmN1YmF0b3IudmlydHVhbC5tYWNoaW5lLmFuYWx5c2lzLmRvYy51c2VyL1ZpcnR1
YWwtTWFjaGluZS1BbmFseXNpcy1Vc2VyLURvY3VtZW50YXRpb24uaHRtbCA8aHR0cHM6Ly9hcmNo
aXZlLmVjbGlwc2Uub3JnL3RyYWNlY29tcGFzcy5pbmN1YmF0b3IvZG9jL29yZy5lY2xpcHNlLnRy
YWNlY29tcGFzcy5pbmN1YmF0b3IudmlydHVhbC5tYWNoaW5lLmFuYWx5c2lzLmRvYy51c2VyL1Zp
cnR1YWwtTWFjaGluZS1BbmFseXNpcy1Vc2VyLURvY3VtZW50YXRpb24uaHRtbD4+IChrbXZfZW50
cnksIGttdl9leGl0KSBmb3IgbXkgYW5hbHlzaXMuIEkgYWRkZWQgdGhlICJhZGRvbnMiIGZvbGRl
ciBmcm9tIHRoZSAiYWRkb25zX3ZtIiBicmFuY2ggb2YgdGhpcyByZXBvc2l0b3J5OiBodHRwczov
L2dpdGh1Yi5jb20vdGFoaW5pL2x0dG5nLW1vZHVsZXMgPGh0dHBzOi8vZ2l0aHViLmNvbS90YWhp
bmkvbHR0bmctbW9kdWxlcz4gPGh0dHBzOi8vZ2l0aHViLmNvbS90YWhpbmkvbHR0bmctbW9kdWxl
cyA8aHR0cHM6Ly9naXRodWIuY29tL3RhaGluaS9sdHRuZy1tb2R1bGVzPj4gdG8gdGhlIGN1cnJl
bnQgdmVyc2lvbiBvZiBsdHRuZy1tb2R1bGUgZ2l0aHViIHJlcG9zaXRvcnkuIEhvd2V2ZXIsIEkg
YW0gZW5jb3VudGVyaW5nIHRoZXNlIGVycm9ycyB3aGVuIGNvbXBpbGluZw0KPiAgICAgID4gRVJS
T1I6IG1vZHBvc3Q6ICJsdHRuZ190cmFjZXBvaW50X3Byb2JlX3JlZ2lzdGVyIg0KPiAgICAgID4g
W2x0dG5nLW1vZHVsZXMvc3JjL2FkZG9ucy9sdHRuZy12bXN5bmMtZ3Vlc3Qua29dIHVuZGVmaW5l
ZCENCj4gICAgICA+IEVSUk9SOiBtb2Rwb3N0OiAibHR0bmdfdHJhY2Vwb2ludF9wcm9iZV91bnJl
Z2lzdGVyIg0KPiAgICAgID4gW0Rlc2t0b3AvbHR0bmctbW9kdWxlcy9zcmMvYWRkb25zL2x0dG5n
LXZtc3luYy1ndWVzdC5rb10gdW5kZWZpbmVkIQ0KPiAgICAgID4gRVJST1I6IG1vZHBvc3Q6ICJs
dHRuZ190cmFjZXBvaW50X3Byb2JlX3JlZ2lzdGVyIg0KPiAgICAgID4gW0Rlc2t0b3AvbHR0bmct
bW9kdWxlcy9zcmMvYWRkb25zL2x0dG5nLXZtc3luYy1ob3N0LmtvXSB1bmRlZmluZWQhDQo+ICAg
ICAgPiBFUlJPUjogbW9kcG9zdDogImx0dG5nX3RyYWNlcG9pbnRfcHJvYmVfdW5yZWdpc3RlciIN
Cj4gICAgICA+IFtEZXNrdG9wL2x0dG5nLW1vZHVsZXMvc3JjL2FkZG9ucy9sdHRuZy12bXN5bmMt
aG9zdC5rb10gdW5kZWZpbmVkIQ0KPiAgICAgID4NCj4gICAgICA+IEkgYW0gbm90IHN1cmUgaG93
IHRvIHJlc29sdmUgdGhpcyBpc3N1ZS4gQ2FuIHNvbWVvbmUgcGxlYXNlIGhlbHAgbWU/DQo+ICAg
ICAgPg0KPiAgICAgID4gVGhhbmtzLg0KPiAgICAgID4NCj4gICAgICA+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+ICAgICAgPiBsdHRuZy1kZXYgbWFp
bGluZyBsaXN0DQo+ICAgICAgPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnIDxtYWlsdG86bHR0
bmctZGV2QGxpc3RzLmx0dG5nLm9yZz4NCj4gICAgICA+IGh0dHBzOi8vbGlzdHMubHR0bmcub3Jn
L2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYNCj4gICAgIDxodHRwczovL2xpc3Rz
Lmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Pg0KPiANCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWls
aW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9y
Zy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
