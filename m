Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DABEC4345F
	for <lttng-dev@archiver.kernel.org>; Mon, 15 Apr 2024 18:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1713205534;
	bh=j8gWiHgx5OtbGW1LLrlyl48eVo8WQe1B9iMIejVkPSc=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=MSU2/6TQzVgcFubjQBehz/l+GfHtjb3kjcMFhCSbz4Uz5gxSwbjQvfACXj7vvm3t/
	 wwFlXyqa6MGx4cElCjfboFFceJAF2Y3fY4uYFudaLpFtSxjdBTxu1+DWhLC2e+9Zik
	 HcorZNEAppzRn/AfUa0DlfJwUZ21gO+Z0GNAW9Of0C3yN6AeydmbbI8+Q/Iri7pHwS
	 G1mz8igLYnX4e9Tj2KOo9vPqJ8W7PEvdRHkItLyahGk8iKslwwdNwrdENc3+HOdquP
	 zDDiIG9pc9DbMBACvygkZR4Rp0QcuBzR4eDb3eNDbS688fKrcdG7J3fhqzHjlCGyNG
	 pWA0Bu99HnfHg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VJFwF3V7Gz2hF5;
	Mon, 15 Apr 2024 14:25:33 -0400 (EDT)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2134.outbound.protection.outlook.com [40.107.115.134])
 by lists.lttng.org (Postfix) with ESMTPS id 4VJFwD3tGhz2hMc
 for <lttng-dev@lists.lttng.org>; Mon, 15 Apr 2024 14:25:31 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOWzdW6QgBsLydJi3b4DMzBk6z1CyY+kUQ67JO15dapQwDuMCJboDyaUAUL71nerbrcM2jNc1wkvhGpw1/hBm8Av31CVSXDXlHUuhZqwPSptC11xwMjlTcwXRstIDJpqBW1wjvivdPCY8gaCYQjg6cd+k95ACHPorknyYS2Qgy8nVkfARyxmo7/MmV/95Yp2CenQRaTaLJOPL4Zq+CuFGa7macPXjodVIi1r+C7r/hHcZz47Yg1ECcrrw9ydsnjYz2JmvWea3iLUyIFM0dyAmLNzjJmxPp7C8i8i4fkTIuzod5Aa6RLhvDewuxkEL/EsIx/JBhaR9gtvf5uPzrXPyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jya87e/qEPoPrbb5b8WbUko6/Zf3UEL94w8ElKp5pLI=;
 b=GuXiL+LGaePuq1c0/7FVM53fIhhjVC+e7bvBudWMTqd3UrcYko9FT+5oT2T8T8KXsl29mMqA+V5rJibsi9mXK5DwB1P/xLa3HLAgvuhivrIyFsqiAll9HI2hCzMkfZPezkcfnQyYV/Fs6AmsJbJ2IzRDtN8PmLaCdU8fE3EXZW/J1LJMukgJnefaxl/YvL+VWjT7OaY42ccNGhZ3q2pdMbC9AbY8k9l8AHiw5QFdYd6GhFdiF4xE9oxNXVKniw6JvClWjHi++9wlOO06yofCLozl7R0Km+wqd/DKdoJj3A15k5jjbNXUS1GtKZrydtOw32jDCxzkx/HLuA1IfUR+PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YQXPR01MB5380.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.29; Mon, 15 Apr
 2024 18:25:29 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::17ea:ed8e:e437:46ed]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::17ea:ed8e:e437:46ed%5]) with mapi id 15.20.7472.027; Mon, 15 Apr 2024
 18:25:29 +0000
Message-ID: <6e1feec7-7b25-4654-af4b-7ed942e4accb@efficios.com>
Date: Mon, 15 Apr 2024 14:25:27 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev@lists.lttng.org
References: <CABRndgyC1hMY5vkJjBpPc_GSaSwCaDBc0KhmykOF4Sjthk_FLA@mail.gmail.com>
In-Reply-To: <CABRndgyC1hMY5vkJjBpPc_GSaSwCaDBc0KhmykOF4Sjthk_FLA@mail.gmail.com>
X-ClientProxiedBy: YQBPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::15) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YQXPR01MB5380:EE_
X-MS-Office365-Filtering-Correlation-Id: bc62fda5-7536-4442-9af5-08dc5d796d8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a27fsNermkGR87PPT6IsMSNtdmdEMzV/G30SyVa41iNDndxpWIuhkwf2nKThY0dDiewMvKtUSCxE8n3FalDEXhKTR5yBP23IpqHNErUGJD2n1OM00A5ppJwHvSQfW6Wfz/Sp9eO7kWD44yt0Fpugu2kLTuyXDlaCTBPdilDhwuCZhBO7LUphZKfPlAb4hVndb+3S131FK/JgHtMozKamBucUaQ8A/u3tSiXax7AIeebRdS1DSSRvEqvFeXS7HkKvPBOdifKf1/lucTMMFxNFKL3Bx5aBsGelgD05W77ZWID8po941xTxqmFt5eBGCoq9J0AWdV6l0Bccn64kgkxP8/wSTJQSWhw13c0ZlInsWojH0dfXLO9JqNy/8GFbt2MIPJq2hB700i4Ek5AvXePr3OFK+3hwKxA0AV3zPXfQeD9AIQ2FIJYXzxzVYiurwOxezQinAq6bVtOWLhafjq+niYj1Tc0/7V+UGXaazOovcRUv2Vo6CxqhO+1iYZaoePgOOUk2PwfIkPKKbDeaghQsMTWZSQBpCRNPKqhShqLNKzXaZ5oTYhDJNVbNpslFiYjXYXvkUxKIsHn6Rwyx/jmZRZ3Mz5PDt3mc2Yp8cFxBimY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk0xcVFxZ1Ard0tiK054MUUvUGg0NTdDb3pMeUNyRXRlRm96dmJ3N1d3Q2Ny?=
 =?utf-8?B?Z3ZWTHpwQ295b0g5ZUNHVnhDSUZFTzZWVXA5QnZieTFzOTBUdEhGbmRnV3Zi?=
 =?utf-8?B?TVJqY1JnWGtNS25nclMvZGs0VFVwVGJHTmRiR1ZGSXV1S0NzU1dvZENMZmUr?=
 =?utf-8?B?M3VjdGo3RmtXQUJDZWZNR0xiNEFjQk4yTHVYVDUvNDhRZ0FnSzBXS01VR21r?=
 =?utf-8?B?NHZ5Sll4OHRKYlVVa3pDMWg0cXpza2VOcThkeXcxeUxyQmJoN3NFSFJxcVF0?=
 =?utf-8?B?NVFmT3ByMlhDY09rcFBBRG1RQ2ppL3V4d2pBamcxRjJ6VThTbmZzbGhlYzBY?=
 =?utf-8?B?ZklGNmpvOTdYbmFZM2VmZUFxenp5SWhuVHZRbUt6aGw2Q3B3SHBwVmVqMVZT?=
 =?utf-8?B?bU9TbUFZTG9vTGo1NGVTdkE3c0VjWkIwNkc0eVJtY1dvRWhhWHpRa0V5MFNk?=
 =?utf-8?B?eXJVYzdyeWtHaGZBeUpDK203UCtJTVppUzF2K2pkd3dXeTNMQmV1REI1N1Z6?=
 =?utf-8?B?WG95dlpyb0ZNS3ErcXA4ZmR4YnRtQ2pnL0k2MGZGMzBkMW50OUE5T0gvWDNm?=
 =?utf-8?B?QmlzVG4yR3Z5MlppZ0o2R0V2TTdtWjRvYlpxRVFZQ0E3d2NZM0dnOGxXWGhU?=
 =?utf-8?B?T09EK1hvaGZwSjExNGM0eHVOUzNsTUYrWlRNaHJLdERLM1lrUTRXejVxSSsv?=
 =?utf-8?B?WEJWSy8vNW1pVXBVbnBETTlYUlY0VDJOUURsMC9TbkhTOG9LcXkzTnFQU2Za?=
 =?utf-8?B?SXRMQlgvU1JlencxMWxDQXMzK2hDRHNzVDFHN1FmUVNFT2pSM2dBcUg1Skh1?=
 =?utf-8?B?WVlKeWlDMW44TGI4WitCQzdkb21HUjIzTDcyS1lXZklUWU5ncXpSenExZk1m?=
 =?utf-8?B?Y2VOWi85RFNVMmZBZ2RFdmxES2NqQTlNUzNMMHNQVTIyQzFOcjJBc1I3QklW?=
 =?utf-8?B?VmR5YXFxdlFpYjF5SjUrWlg0bDF0eXdNakx2UnBqWVBWQUpGU0NFeXNwRXF0?=
 =?utf-8?B?UEVkbVNGMFVISzRhTDJ0VXA1d0VQU0xGdkY3QnpiajYxNmJRSmcvWCtLQXhO?=
 =?utf-8?B?TGw2cy9nc0NqS3loWXhXWmlQVDlWak1JZXpveFhvVXpra3hLU2Nxbm5CbExR?=
 =?utf-8?B?YTFGdWRzLzYyNXAwRkNyV2lkbUx0ZS9QcnJWQkJwdThZSFoyRlh2QldUa3NW?=
 =?utf-8?B?TWpkRm5ERGRJUHlTNWlzdm9PMWxBcW1PSlZ1cDlhODBocUUyMzd1SFcyemdZ?=
 =?utf-8?B?T1FTM0FTYzNiNWRyazZkVkVCOXd3TFk0dkFWaVQyL05JdEhRWVdWZGVKMy9m?=
 =?utf-8?B?OEt2Q1IrWmRacG83dlpJRGJuRGc2Mk9kU1RlMmRpOTBDMmdBRjU3M3VlcHVI?=
 =?utf-8?B?a0lmb090aFVYb2ZQNWVnU2V4WjRzUjRrRjJCbHVJQXo3SHdvMTYyeXQ4RkVH?=
 =?utf-8?B?bWl6R3E5TkhsVGU2VzVJKzFUSDZiS0pHK2twb0tOMTBidDZZNmZnTlpud3pk?=
 =?utf-8?B?dU9qRWlWYlFQRzFuZXd5SFVMcmtIdDVtcE1kSmdOZkNaK2dmUzlDQmdlSVk0?=
 =?utf-8?B?S3FDK3crd2M3VW1MMzZQSk9YbTRobnVCVVdVcGxNeFBUNVdQODRGbHNack5W?=
 =?utf-8?B?RUhmNXkwS3FMYldRN0VNQ1dtY0dpbzNpa0ZiYWRHQ1ZSUU5JWDdUUWQ2WXNn?=
 =?utf-8?B?YjdncjRRM3pCRFNCZU5lQUhvOTJpS1Vva1R1UW1hOU5yV1B4Z2VhMGFsbzZC?=
 =?utf-8?B?Kzk1R1ZIeEFnK040Z3RDdFhydEtxeWRZVzc1VHhjU0w1ekFEWkppbXpoY1JD?=
 =?utf-8?B?TklPblZoR0JrQ1NwRlRZNEY3T1FaQ3hzUWdHY1ZNNGhrWVc2MFg3MTVLbmxY?=
 =?utf-8?B?M3o1SHpobmE0RUVVRUJpMnlxZ2ZzNkxMdC9hR1pwTWh6Q2xVbXZwL2NiSit5?=
 =?utf-8?B?R2pTYm95ck05SWlvZDZqcEtsditIdHA1cExmRkljOWpvZ09sZWE4VDdLVS9v?=
 =?utf-8?B?WGpyNjBPcWFXVERsTVVJQWRwVnFqNURyTCtNQVR0MzlBWWRXQW4vbUVSWDZV?=
 =?utf-8?B?MDczTFAwdm43My9VVmFsUGxWVFRPdGJTOXl1Y0tBc1V5c0RXNm5SeFNWbGRi?=
 =?utf-8?B?SmtTRDdXUzhPMEtub0R3Z0VhaHBjcVFNUUtJYmlXMkNJM1lBMUtCOStBNHQy?=
 =?utf-8?B?ZVE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc62fda5-7536-4442-9af5-08dc5d796d8a
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 18:25:29.1794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AmRod1+CaON/PSYas8ogauFh/CXLqpDO23DRprMl3rdEBLNaiX7igrztZvPZN7V7X8cJlNsfN+vJxk59i4ROzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5380
Subject: Re: [lttng-dev] Monitor user space threads without user events
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

SGkgWnZpa2EsCgp3aXRoIGEgc2Vzc2lvbiB0aGF0IGhhcyBrZXJuZWwgZXZlbnRzIGVuYWJsZWQs
IEkgdGhpbmsgeW91IGNvdWxkIHVzZSB0aGUgCnNjaGVkX3N3aXRjaCBldmVudC4KCnRoYW5rcywK
a2llbmFuCgpPbiA0LzYvMjQgMTI6MjAgQU0sIFp2aSBWZXJlZCB2aWEgbHR0bmctZGV2IHdyb3Rl
Ogo+IEhlbGxvLAo+IAo+IE15IHVzZXIgc3BhY2UgcHJvY2VzcyBjb250YWlucyAyIHRocmVhZHM6
Cj4gCj4gRmlyc3QgdGhyZWFkIGlzIGJsb2NrZWQgdXBvbiBhIGtlcm5lbCBldmVudCBjcmVhdGVk
IGJ5IGEgaGFyZHdhcmUgCj4gaW50ZXJydXB0IGhhbmRsZWQgYnkgdGhlIGtlcm5lbC4KPiBUaGXC
oCB0aHJlYWQgaXMgc2VuZGluZyBpb2N0bCB3aGljaCBpcyBibG9ja2VkIHRpbGwgdGhpcyBpbnRl
cnJ1cHQgb2NjdXJzLgo+IAo+IFNlY29uZCB0aHJlYWQgaGFzIGp1c3QgYSA1bXNlY8Kgc2xlZXAu
IEl0IGRvZXMgc29tZXRoaW5nIGFuZCB0aGVuIHNsZWVwcyAKPiBmb3IgNW1zZWMuIEZvcmV2ZXIu
Cj4gCj4gSXMgaXQgcG9zc2libGUgdG8gc2VlIHdoZW4gZWFjaCB0aHJlYWQgaXMgcnVubmluZyAo
YW5kIG5vdCBibG9ja2VkIG9yIAo+IHNsZWVwcykgPwo+IEkga25vdyBob3cgdG8gZG8gaXQgd2l0
aCB1c2VyIGV2ZW50cy4gSSB3b25kZXIgaWYgaXQncyBwb3NzaWJsZSB3aXRob3V0IAo+IGFueSBl
eHRyYSBjb2RlLgo+IAo+IFRoYW5rIHlvdSwKPiBadmlrYQo+IAo+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+
IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2kt
YmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxp
c3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlz
dGluZm8vbHR0bmctZGV2Cg==
