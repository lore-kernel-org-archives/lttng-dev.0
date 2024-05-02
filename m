Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52BCC4345F
	for <lttng-dev@archiver.kernel.org>; Thu,  2 May 2024 14:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1714660375;
	bh=JLUcH/yOrP4GHWp/ODzgqlKG/9yjIfAQrgebS9g2fNA=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=GFAqvN0vT9tME9zByLwUyJTZR7umva/8ROAsbbd+/lTytbEXp5E/HI8FGJFTnvOlL
	 Ldtf5XKvIXaG75B5XrYNhow8Y2BvQ0YtiYFmYbtlKL/qsP8CUeGtCPKuToc6t0IuQz
	 RqESApDN60lpW4z0wvI5nsfFRobvS71oX2MYf+pKRhn1gUHO+eNk2lEFEir9FbRZEn
	 boqzhRyNkfKTPoVXtrwSp+uFKVnWh7CJBQcwSpxDKJp0rXn8FuSP+JYqfQO2gJ6Mmj
	 haTG5MddEdJqNCF7smGglalEg403widC0LIH/WI1m50kGB6kslKa8LjMYsRhMW3zdU
	 5E/gREqAu4efA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VVbxy5cdQz2l9r;
	Thu,  2 May 2024 10:32:54 -0400 (EDT)
Received: from YT6PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazon11022019.outbound.protection.outlook.com
 [52.101.189.19])
 by lists.lttng.org (Postfix) with ESMTPS id 4VVbxv1c6wz2l2Y
 for <lttng-dev@lists.lttng.org>; Thu,  2 May 2024 10:32:51 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4y8+w8S6QEMl/vsWuPe7c384wzY1zd4WoQXEhmvLEuAsGVE6/BnxLjnDdvF4+0jA/WXy+Au1mUyVA4rXb2xJoOwP/VPYwcz5Hwx0YE06++KFaVVj3y9+uUljXULxHuLdlsi7uGBmJT5FKBkhPtbhNSEkZnUwIjyl5L6cAW/gt7uMnK0XCLbXpeOjgS45Q8EG15byYAQ+BNHm/uDCXe6Jlc88l9tFfhglA09GAyi2cFcPEfFthm2tMeOLJeoCyvRlHQCzdccmwCwpZhsYoVEPimTljYb1vqUY7q4eRxTtliX75b74WWa1LvPylA0F5+pwOVpMb+Yt6X55BGc7JUV3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpZPRcu56FwQ8EcoBOhV5meFhcllKMKHH5QhWQLbP8k=;
 b=BcNazEOgCu66E4bfCO/cj/IUmVoGKpzqXz8OlSYE+jamxbDwIAGXJLUtyQ+sS/dUVBEqB8+fZDs+3QJW6I25LYoNYfBEzknhZ3ZtkhJoMhodlTZi7mUAGhW99K+u2X6vYM0ST2W08Q43nvG3MKSLOXAXg4pPatvLq9szTDr8BaWtEMzTjERv62P2tO51g7eycw4NqJygLbSPIDg2kPek9rsltKXmscW7xJ0N3anN25ir0++5uh/MBuhvzHh4gHtM8NXnJqbK9zSBCY54yTyCkMRhLr+8o8Bk6DRylH97fpoVggVpWLC4qsfGNKI6eoa9ZgH9boeGNYxFuoOp7FlH0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:24::5)
 by YQBPR0101MB6149.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:34::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Thu, 2 May
 2024 14:32:48 +0000
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9a41:c476:7b73:99ec]) by YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9a41:c476:7b73:99ec%5]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 14:32:48 +0000
Message-ID: <1e62350b-a6fc-4581-b386-2c4e6e182433@efficios.com>
Date: Thu, 2 May 2024 10:32:46 -0400
User-Agent: Mozilla Thunderbird
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, lttng-dev@lists.lttng.org
References: <20240501234242.2395659-1-bmarzins@redhat.com>
 <2a7f6659-4332-47ed-adbf-45e88915ac6b@efficios.com>
Content-Language: en-US
In-Reply-To: <2a7f6659-4332-47ed-adbf-45e88915ac6b@efficios.com>
X-ClientProxiedBy: YQBPR0101CA0341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::7) To YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:24::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB5080:EE_|YQBPR0101MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: e0870964-7fb3-49e5-d040-08dc6ab4bd02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHRyR2JjSTRMODUzbnJkalBBVzVJOXBreHlPL0IrYllSU3d0VGJlUy9pUDBR?=
 =?utf-8?B?MDVBYm1rYnh3TzYvMDFuaGRTekhLYmJBR2w4WEVrcFArMHNqOTVSWlRFbDRt?=
 =?utf-8?B?bmxKc2NVQTVMVUo5WU9GZlpJUVcvWVpuOVVUa3l6M29YSVVwb1N4bjlHTzBh?=
 =?utf-8?B?dktPbVpJbVhNZjFmdHRPY3NucUs2UUNWVFFXbEZzK1dmNGNoenBrQjdlM3dj?=
 =?utf-8?B?WUs3c0lmT2JkNVpBaU9LUUxGR2hCM1d4MDR3eWpoYi9OUmdkYk52cjI4cnFa?=
 =?utf-8?B?MXZrVWJXdXJUbkpCRU1xTHF6WlA3ZzNxZWdUWEFkL3NvbFpBS0lDd3VxNFpx?=
 =?utf-8?B?YURHRnFwNlhudGdDNFhFWklraGYzK2hndVREYVhwdlFEMUYvclh6R1ZqSTVT?=
 =?utf-8?B?OWFNVy92OEh5MHd3ck1XK1hzYkZxZG1kS2VjMU1WTnhGZnBGVkdRQVlJRmtv?=
 =?utf-8?B?UUVBRzdLeUJNNzQvd1p6M2p4WDlJL1NrKy9YMFlqYm9SMlJUanB4alNsZzBj?=
 =?utf-8?B?aGR1ZmdXNmR0UzV3UVY2bHNLZU9SWXZBVTRIbmJIVkJ0Wi8zbWFTVjFqL0dQ?=
 =?utf-8?B?TUFsUmFXKzUxY1N5aWFqL0dzUElwVlo1ZCt6aEZJTUtjTVFvNFdvdmFmZTBK?=
 =?utf-8?B?RWluMy9tYS9McjgyTm5CYzU2aitVUjRxcUtHQmlhZ2V2c3BBeS9QTzFlZE5X?=
 =?utf-8?B?TU9GV0NzclNyVXpESEFoSTBla21oZFFHVkd2bmpDcE5NZDJMenVZcDRDUnFl?=
 =?utf-8?B?SDFHSjQyNnA0RlNLU1pXTXM5M2tHclJPdzZHa3kzZmlKN2d2OGZFNU9rVElv?=
 =?utf-8?B?MkoramFDWUdOWi9vMkgxWFZ4aDRQMTlZeUJmeXNrQ0hlZW5LTmVLYVVIaFln?=
 =?utf-8?B?RmVpayswZEVnWmZMYTVIaHhmVUZnUTRpcnhZanVVZThMTWZ5MW5mNDVBRUpp?=
 =?utf-8?B?dTZabVJUYjhubjM3MWxvMzcwWHBmY0dlUzZGVXZjVzFmZjgxTWdHQXYvVXJ0?=
 =?utf-8?B?UVVJTGhYNFhMMWxNNVNXY3FkRGhkZzJGNzkvVXNKU2J2UWVHVmxYZ0d5WXJT?=
 =?utf-8?B?Z1JIZFYvcVRtSG05TDh5aXFKN1JHVE54b0VtdlZEdkdSdVZqWVI0d1V3MTlR?=
 =?utf-8?B?ZStFR1N0U2tXVlVIYmdGN1dPSUx5c0swRnhRWU4rMFRGS1g4WmYrSThEemxC?=
 =?utf-8?B?QWtLemloQmRQRlFjNjB6MXRrc1JyZjRTTGFDL3Nrck9Qcks2eXI2YVNBMGVP?=
 =?utf-8?B?VjB2UDNydkkrdEtyL0NhcFRUQUlvcTIxY3p1QVVHRWtBNTBYV093SWVneGdH?=
 =?utf-8?B?bU53eS9Cc0pFUW1hQWZTRDVHR3BWYnFOUDlxY281L1pnK0g5OVBGeUVHM1Fn?=
 =?utf-8?B?YkM3NnlzUGloRktFb3UrM1gyUVNTR1VlUjFUNHZ1RGNZMUhBSStVenl3YlBC?=
 =?utf-8?B?NjNrK0sxS00rSzd4aW9XRjZkZWkwc3hyeGdqTGg2a2dCTXYycjVsK0lBUUxR?=
 =?utf-8?B?cmNYZHZmdW5Tbld2R2VWcW9WY1pnblQvTGRYajBDak96a3dVRndRS21EQ3c0?=
 =?utf-8?B?cE9PMkpja0NFb2tGbXUwL0NGdURUaVBwRUhVMXFoREtHUWd0L3dsL0p0WlVy?=
 =?utf-8?B?TWNPS3hYOFZNQmFDTUdqWkN0WW9RenBtZHJZcDdxYkZrRW9vWnpDa3JNeWwy?=
 =?utf-8?B?bEUrYXRuTXdqREF2SEhBbmhxOTlZc0MvYUkwaVdnays1YXlzUHgvUUlBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFBlTk9jYUdibDlWMi9WWmEwaVdSMWV4VkF0RVlYRU5qbEF6dDM5ZzZ1N1Yv?=
 =?utf-8?B?WDhmTU9sdkg5QUlsWFJ5aWlTQlEzaHRtdDNMUzBEVjZzeEY4NmEraTRrQmk1?=
 =?utf-8?B?dG1aZW84c3MyVXQreDNDb1ROZlZHZmk4TFRScEdlNUdSSjQvRDRtSG5kaVNH?=
 =?utf-8?B?WndRV0lPa2RYS0hKdFpSUmFvWUpxMHJuY2FINTd6K2xDWUxJcjcycjMvMFVv?=
 =?utf-8?B?SWNhSzVKZnFhQkRtaUljVEpWVVNoMmllaU8rd3JWK0tkVWx0WnR1MTVlYVJx?=
 =?utf-8?B?aE91VWcvcm1FRnMyVjQwL1dLWk8zN2kzTFp5aDd6S3I3eGlZTzFhYzZtNlUz?=
 =?utf-8?B?ajMzU0tiVjVBU3ZhcXpSM2hKR1lmUTFTQ2VGblVzRFAvZmlscDRwa0tZeUlx?=
 =?utf-8?B?MEhRWjQvZm9EQ3daRmkrbTA3WE5KbnVRUHRnY2dGdEhyNzFDTXFZN1pLODF2?=
 =?utf-8?B?U0ZQRkRWRkhPSVVWY2hYNHdHZGNBdHVlanZxSDFmbFpmb3FuRmx0TXJpbzVB?=
 =?utf-8?B?dGpYL0xJM240ZXhqT3Z3T0tGT3RxN1h3SnFuQzg2VFhLdTE2ZEdJZy9VWVkz?=
 =?utf-8?B?d01qeDNtWVYxYWp4LzNVaU53TGFMcEI1MFNMM3dxN2FlaGVyZHB1bDBUYllp?=
 =?utf-8?B?OEJLajBaeEJSVGtrTzRNWWM1bHF0c3FZOGZ6MmpKMVZQbWRSZkMwRFhDRFVu?=
 =?utf-8?B?OC9obmpIZmNHa3U1VVVqQnpkUFlmaU5Fa0VSUXZ2Vk9oVmdndGErbE0wOHNC?=
 =?utf-8?B?cGpERFczZm9xbmwvY1JxT1hLME1nRGxmR1dxNVJZUGJldEZLNVZaZjhZcE9S?=
 =?utf-8?B?Y0tOWUpIbTgwQ2o4U0lwSnRMeG1aMGw3UExXRW9ZTEJjK1Y5cG5OWjJsbkFm?=
 =?utf-8?B?VENYUVA5aSttTHBPRHZmdUkzWEhrTStGNm0rRHdPWXNVYkVSUUdCcVdxeHNB?=
 =?utf-8?B?SCtza3k4bXFycUJYNUc5dnNiQ3UzZ2ZDM2htS0xXcTBLdlhuc0d0RXRXc2RP?=
 =?utf-8?B?engxK25qUUt4ODNKd1lFaG53MGRFOEVLbU9YU3JLRXlJZUVaeFNvckdIaXRX?=
 =?utf-8?B?MElGV1IrelN6S3ZFMWFYWXpwY3V4SFBjMWJrODlMaFdOcWRZRE5EU0NKbDd0?=
 =?utf-8?B?bUk2SExGRE1jUkMxWVNEN2tsV3hIdlJSRXpldFB1Umo0ekhDSkVicm51dXEr?=
 =?utf-8?B?ZmJIVFN2cW9ITlNzMzg2SS9vSnBWdlFaV2R1NWtnTTJTQmMzbys4YkRQcGRP?=
 =?utf-8?B?YWlxRUdmNlNNY3NNdUk0TGZwalhsbStHemN1bHJwcEZMVFlod0VNb0pOWjVV?=
 =?utf-8?B?RlhkRmwrVDNTUE9JSTZHaHY3MjdyZHQvNGZzcWpmVnVmeUVtdXFtRmhyN2VX?=
 =?utf-8?B?WmNXSFJNNnp3T1p1VnJyTXd5cTEzanRHNFR1QjhVRndsNkJ0aGtYVjRMTkxG?=
 =?utf-8?B?OE5KRTQwVjBDMlFldXNjZUFod0RSajJabXRsZTdRNXJPZmJRU29qRXNNVGJt?=
 =?utf-8?B?L0dIWUFWRkxLVExLdCtLSGt5ZnJ4enhwY3d0ZDFKYW4rSGxuUFpiKy9XSGcv?=
 =?utf-8?B?bksvZksyeWIyM3JqWEg0bVVtSEtRZFYxbndkRlhBN1JzWmdXSEVUV1dRblp1?=
 =?utf-8?B?d0V4RTlOK2xkVXFiTHB5WGlhSlVodnlIMkVFL3Q3cXNjbjdtWUUyWEtMc1ZT?=
 =?utf-8?B?cDZwTEVHa1lHTmZwazZGcnV2NTFhdk5FTjBkSlFtUlJsWFZDeEVhMDd3RFlk?=
 =?utf-8?B?WllJd0dkTzZhNVpVaVRrbGYxZkhMZG0vaWdaYk05VVF3eW9FTm81akxEakY2?=
 =?utf-8?B?Y2VjZzNvcHJVODR0dW93ajdLQkRBODJUQUhVblpKMkRoWmM4eEp0d2VXK3M4?=
 =?utf-8?B?c3BtcGZuamJqeG1Qb09rdGUwVUFDOWVlZG5zSlFZaXI1OXpHd1dmdThkcHJX?=
 =?utf-8?B?RTVENXlSN1N1eCtHb2ZpQWw1RVdtVjNCcWhUcmU0cGpzNHllVlllZTVMTGhG?=
 =?utf-8?B?eldSNTdvcVpYR09MUVNDSmFwNjZzRFJlYXBVTjNrN2g1NjQyeXU4L21ob0RP?=
 =?utf-8?B?OHlzUjhXUGZudHdJam0zSVhLNXl6UGV2OHpPY1lmL0NCbEtVY0phR2xrOEFJ?=
 =?utf-8?B?Q3gzVndTVXo0eVFJRHRhbXIwSlJCdWE1M3FYUlRYSGtwZFVkcTJxeVV1TmdI?=
 =?utf-8?B?bXc9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0870964-7fb3-49e5-d040-08dc6ab4bd02
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 14:32:47.8447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ySwmYXF6fA37hyxBcsEw755qYVbf1WyRd9DGekJYjbBniLKeXPKoDuJsC9QErE9TGqWhSom/nzXvVZun7bMWlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6149
Subject: Re: [lttng-dev] [PATCH urcu] fix: handle EINTR correctly in
 get_cpu_mask_from_sysfs
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

T24gMjAyNC0wNS0wMiAwOTo1NCwgTWF0aGlldSBEZXNub3llcnMgd3JvdGU6Cj4gT24gMjAyNC0w
NS0wMSAxOTo0MiwgQmVuamFtaW4gTWFyemluc2tpIHZpYSBsdHRuZy1kZXYgd3JvdGU6Cj4+IElm
IHRoZSByZWFkKCkgaW4gZ2V0X2NwdV9tYXNrX2Zyb21fc3lzZnMoKSBmYWlscyB3aXRoIEVJTlRS
LCB0aGUgY29kZSBpcwo+PiBzdXBwb3NlZCB0byByZXRyeSwgYnV0IHRoZSB3aGlsZSBsb29wIGNv
bmRpdGlvbiBoYXMgKGJ5dGVzX3JlYWQgPiAwKSwKPj4gd2hpY2ggaXMgZmFsc2Ugd2hlbiByZWFk
KCkgZmFpbHMgd2l0aCBFSU5UUi4gVGhlIHJlc3VsdCBpcyB0aGF0IHRoZSBjb2RlCj4+IGV4aXRz
IHRoZSBsb29wLCBoYXZpbmcgb25seSByZWFkIHBhcnQgb2YgdGhlIHN0cmluZy4KPj4KPj4gVXNl
IChieXRlc19yZWFkICE9IDApIGluIHRoZSB3aGlsZSBsb29wIGNvbmRpdGlvbiBpbnN0ZWFkLCBz
aW5jZSB0aGUKPj4gKGJ5dGVzX3JlYWQgPCAwKSBjYXNlIGlzIGFscmVhZHkgaGFuZGxlZCBpbiB0
aGUgbG9vcC4KPiAKPiBUaGFua3MgZm9yIHRoZSBmaXggISBJdCBpcyBpbmRlZWQgdGhlIHJpZ2h0
IHRoaW5nIHRvIGRvLgo+IAo+IEkgd291bGQgbGlrZSB0byBpbnRlZ3JhdGUgdGhpcyBmaXggaW50
byB0aGUgbGlicnNlcSBhbmQgbGlic2lkZQo+IHByb2plY3RzIGFzIHdlbGwgdGhvdWdoLCBidXQg
SSBub3RpY2UgdGhlIHRoZSBjb3B5IGluIGxpYnVyY3UKPiBpcyBMR1BMdjIuMSB3aGVyZWFzIHRo
ZSBjb3B5IGluIGxpYnJzZXEgYW5kIGxpYnNpZGUgYXJlCj4gTUlULgo+IAo+IE1pY2hhZWwsIHNo
b3VsZCB3ZSBmaXJzdCByZWxpY2Vuc2UgdGhlIGxpYnVyY3Ugc3JjL2NvbXBhdC1zbXAuaAo+IGlt
cGxlbWVudGF0aW9uIHRvIE1JVCBzbyBpdCBtYXRjaGVzIHRoZSBsaWNlbnNlIG9mIHRoZSBjb3Bp
ZXMKPiBpbiBsaWJyc2VxIGFuZCBsaWJzaWRlID8KClN1cmUsIHBsZWFzZSBnbyBhaGVhZC4KCj4g
VGhhbmtzLAo+IAo+IE1hdGhpZXUKPiAKPj4KPj4gU2lnbmVkLW9mZi1ieTogQmVuamFtaW4gTWFy
emluc2tpIDxibWFyemluc0ByZWRoYXQuY29tPgo+PiAtLS0KPj4gwqAgc3JjL2NvbXBhdC1zbXAu
aCB8IDIgKy0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9zcmMvY29tcGF0LXNtcC5oIGIvc3JjL2NvbXBhdC1zbXAu
aAo+PiBpbmRleCAzMWZhOTc5Li4wNzVhMzMyIDEwMDY0NAo+PiAtLS0gYS9zcmMvY29tcGF0LXNt
cC5oCj4+ICsrKyBiL3NyYy9jb21wYXQtc21wLmgKPj4gQEAgLTE2NCw3ICsxNjQsNyBAQCBzdGF0
aWMgaW5saW5lIGludCBnZXRfY3B1X21hc2tfZnJvbV9zeXNmcyhjaGFyICpidWYsIAo+PiBzaXpl
X3QgbWF4X2J5dGVzLCBjb25zdCBjaGEKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHRvdGFsX2J5dGVz
X3JlYWQgKz0gYnl0ZXNfcmVhZDsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGFzc2VydCh0b3RhbF9i
eXRlc19yZWFkIDw9IG1heF9ieXRlcyk7Cj4+IC3CoMKgwqAgfSB3aGlsZSAobWF4X2J5dGVzID4g
dG90YWxfYnl0ZXNfcmVhZCAmJiBieXRlc19yZWFkID4gMCk7Cj4+ICvCoMKgwqAgfSB3aGlsZSAo
bWF4X2J5dGVzID4gdG90YWxfYnl0ZXNfcmVhZCAmJiBieXRlc19yZWFkICE9IDApOwo+PiDCoMKg
wqDCoMKgIC8qCj4+IMKgwqDCoMKgwqDCoCAqIE1ha2Ugc3VyZSB0aGUgbWFzayByZWFkIGlzIGEg
bnVsbCB0ZXJtaW5hdGVkIHN0cmluZy4KPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3Rz
Lmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGlu
Zm8vbHR0bmctZGV2Cg==
