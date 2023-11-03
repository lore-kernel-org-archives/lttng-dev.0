Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F35C4167D
	for <lttng-dev@archiver.kernel.org>; Fri,  3 Nov 2023 14:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1699021286;
	bh=G4iArf13DgELl6xr4yPq0OH98FfxXlABO/Up9/1usvY=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=i45pHYIVpzIwkIf5qOdg+XmB5wXq9F5MaFmrKT9XfgfaoioPAy8wx0zjazFyX+Dog
	 LwKT1qktP3zt4St1kQq/g/Y2eF69D/vwSDGiWMNzdktxIruwtT2prmFH/xNZgRACx3
	 Oe56DGorqfD70N7NUKGOhrUqknLoHFsBZhhAmPw76AR4X30yj47xujGhYIANOqrref
	 jUlNKnuQxYRebCx4wix2XJxEmiTv1Eb2Um+1zTH5rvYhEDk/Y7bpCwodH8f9lBSDDU
	 XYwoBIhTGrzwmby+zHoWhfqywMPFjdwIw0ghXFnuBORea8A8JvCUzxd6mjfCehGWhc
	 VZy2jTwNxg0Dg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4SMNGG1lNgzCj2;
	Fri,  3 Nov 2023 10:21:26 -0400 (EDT)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:241d::600])
 by lists.lttng.org (Postfix) with ESMTPS id 4SMNGD6tdHzCVt
 for <lttng-dev@lists.lttng.org>; Fri,  3 Nov 2023 10:21:24 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3PCfLCRBr9C1OiFep/f/X+nOtdcbhqI6OZc0+T20y7dYoYYlqFZHC9BX8JK79uA8eV3CVZJZVp2j8o89DM/v7iZEX+ppOZzoMAc1Cos5emMLR08s9QlnWUKwhobVjZ1mslSIjXP6OlSF4smrJcBL4fZqvtuPLzA1DH5vmRP1W+R79rycjK1pchpjhGtYTIspZ1IgznqPZ2tPfv9w4l9eE9WA8Wxm3EOmB4WOEx5zOJB8xagLm8Od68tipOIcDOojBkWcthHF2jY7p/R23B8TroTEsy54vKKyTCg3ZRmswaKKf5ukuCUMX1/QeD3x/66ClnIz/xPzKSJ0LsRRTsazQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InuNLaXWqqllLYTc3fovRmIDVjckT8TO8wQTFzUCIBU=;
 b=BMyWXG2yUWgC2RBNy1WIih5JGlvZX4MP414EtApFkqT0f1FFURo5puAR8gPAF8Oxsh6lWqxkQdr1IZCh3/2SbSPSMExhWmlNTF0fb2uf9QRHpUd7B94deaJK/m6CrnJ2icNT5HRHpGU7veIUDX4XLyvEkumiHYCyTZAxBoR7X14IBHk6x5+VxvJWgUFtVUDOnIgeMmvVrc3wg6iHBPv777j9G6rcfc+halwd0YBnBsM09hTJZ9w+p/hNjZzmb4PVaJrh5Ro+7bxNWp3GkEtDuuy3ZcEE60LoGD9Kvv80dWMym4JfDkOkATqKCR7JTlzkogXh+iFFdQiB7pi6bZMoCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:24::5)
 by YT3PR01MB6242.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:66::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 14:21:23 +0000
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5b19:d4b2:5ca1:9fa1]) by YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5b19:d4b2:5ca1:9fa1%4]) with mapi id 15.20.6954.024; Fri, 3 Nov 2023
 14:21:23 +0000
Message-ID: <a822b4bf-47a8-4396-a82e-af8589e165b8@efficios.com>
Date: Fri, 3 Nov 2023 10:21:21 -0400
User-Agent: Mozilla Thunderbird
To: "Seidl, Aron" <aron.seidl@zeiss.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <AS8P190MB10771A3EB2AFC92E4540399E88A5A@AS8P190MB1077.EURP190.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <AS8P190MB10771A3EB2AFC92E4540399E88A5A@AS8P190MB1077.EURP190.PROD.OUTLOOK.COM>
X-ClientProxiedBy: YQZPR01CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::23) To YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:24::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB5080:EE_|YT3PR01MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: 59fe3f46-9c79-4c44-17f8-08dbdc7827fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E6fBCm3lBHdj0AAmmeC1wfdjXwvQ07Ah7iZZoYiTfLlxU0rqxjupJ02StgnBqbWBSPylQYm3/Mg67aIqd12RrJKcSzZ6OmkPbFYlB0Z2Y0sOUnpAx2PyfH1HfXa/ChP9LDNau8yrZNKnsF2Y0VBx+uIspDGqOU13haOiMbbgQfI2kk0nmKHfyjfB2bDbWT7JSQmZ2pB3KPt4DS+b0NmtMiJox9noamvaE355PIe5i8fLoDBIOW62V3hiNpsx0SwLxWhZq1mmpVIxu5OEeXLnmsS6DiKwK+btr0E12m0xRvJVfvmSKDIpPLzDatEioHn1o1s73KfVWwNL7WYBaeZAfsWa610Glqar5AzmijWZ8L5rcwKnodyW+sdM4tRlxhEbB0gFXbOno9nFcJTj9BZMhPBrT1TciKbz2OGuclfE1O4ZyHUiyDWcZZ73AryFMkY8fhLng8SVXicuCU8dX1WRM6NBQECP58DJuLqVflaY/sdnbVl8XU/8/Ii84LtsIQl+eKwgnmMh8s6fUPpshS7Po9VVFtHZT2QAq5PSwnJRh4+XeaL+/eh7qn7u3aso3rC1n4CaMjogjMBDcVW3xXa7F1Nll0V2W262ZlGF+MzNnZZKrPymmLEHD1xFPbQuWYJzB6fAqc3a2mqlt3VVkeSJtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39830400003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6512007)(26005)(2616005)(6506007)(478600001)(2906002)(5660300002)(66946007)(41300700001)(110136005)(966005)(66556008)(66476007)(6486002)(8936002)(316002)(8676002)(38100700002)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHhiL29FblQwbDVDcU9uZ3MvcGZkRjlPbzA4akMrbDBiUncxaFh2cXRGQW0z?=
 =?utf-8?B?T0UydC91eDdtallMbGt0SmVvTUR1YmJaOFFtRlNaN016dlM0QzNuWGpIU3cz?=
 =?utf-8?B?Y2s5V2JVVVZ3OW5HNXFQSVdWYWl0WXgwSUtBK2xBcmxFOWZZbjVzcm1teDJt?=
 =?utf-8?B?NytTcXdqUHVYeUF2V3BTaDB0V0pqdlE1Z3R5ZnRGNlFOSjlvMTkvc1duL1Iz?=
 =?utf-8?B?KzZVQWs5MGQrRTdQRklLdERPSEVGeEVKenMyWWpGYUN6bVRZZVdrNkJFTmIv?=
 =?utf-8?B?RW94blFGU1JtZlhkWlhGd0gvQnVJL1hCaVE3RkloUXNhTlZIdFNWQXNHSHVu?=
 =?utf-8?B?bE85ZHdGZFIxbk0xNGJ6ZzRFN0xsQVJJYmRnUEdqSVhVNkxRckdaNmQ2Mkdy?=
 =?utf-8?B?OEFGaTUxU0NmUWZtS3VSYnBjTmo0bDhkNkh1Q1hCeXFmcXd2WlNuZ0w3SitL?=
 =?utf-8?B?QVBtK0wyZ2pZV3lzN21adXNGcXlZSzNOeVV3MmZZc0VOd2VOVFI5MnV6bkF5?=
 =?utf-8?B?WG9IcWNOTzJ4MUhjK2svVHI0bnVlbFFHTWJxT3o0eUhMK2MyQk96SjBaMzFC?=
 =?utf-8?B?TVNoKzE4UVU4ODdlYlFrZFVPTVNNTTdWbXphUHpBdHo4VG5nK3lCSDg5RTNk?=
 =?utf-8?B?amVtcFFFdkFneU45cGR3dTVNVG1ISmNMblhiMDBmVTVYenhjQlR3eFlKcnVC?=
 =?utf-8?B?RkxOVDg4eWdsOEJxeW9MNG5YOGQ4eGJIcU1aT2lhTXVTN0hYeXRWKzhQT1ZI?=
 =?utf-8?B?c2FYbjZEY1ppQzgvU3RwaWZ3U2JGUjdLNFBCRGFsL0JJcWl5SVBTTk92Tkxx?=
 =?utf-8?B?MkgyemloWEdNS2xEbDhRd2RHSktoejRtWFRMYW5HdVVrRHhJMkpmSVdBcHdV?=
 =?utf-8?B?RzB5UHhuWGNtaWxNSVVUTU5hUTczTnlmbjdDSzQ2N3BEam9WU29VQWNkc096?=
 =?utf-8?B?UjE4S2VwMVFTT1BOWGJrMDlBVjV6Nk5VWUZPWmNBUEtLYnl5NHB0V2xzazkz?=
 =?utf-8?B?cXlwNXVIZnYxeHBhWURISHhzOEQ3MUdpWGdyd1cydzdLRkQ2Q0F3elZJN1lQ?=
 =?utf-8?B?dXRwTU9BOGgyTjZ4ZVNzN0liSjVHaklNVHFoNDFQaVZUODVmVjRNUUdLU0xw?=
 =?utf-8?B?eTRKU3JwajgrMCtwU0RvNXVZMytXdlZwOUpDd2poYWFvbGxnNk55blM1ZXkr?=
 =?utf-8?B?VFhvS0pSODFtM1hHQXM2Zk56VTlQWXdPNzJVMWZzU2dTdkt2aENnQWFiK0Vq?=
 =?utf-8?B?S1Q5SVJVN0FGSDMxcVJpVnJTWDMxNktFT3Z5RDYyejFjNEhuc3RJQ3dETkxk?=
 =?utf-8?B?eXE2ZzJyU1luODlPMUpOZlJQN1pwQTdOR1lPdjBhY0c4aXd5bXVDc0pZNThv?=
 =?utf-8?B?OWg3RzZCQVlJckVlTm9kK1cveW41cmRxSVg4SWcwNTA4WmdOQTF1eHlpQVcx?=
 =?utf-8?B?VXR6SFQ0ZHJGTjVRVjQyK3FRY2xBbVQ4S3dzV1IxVTBvVVM4VXRtdGxzVWZ5?=
 =?utf-8?B?eGxTVmt6UW1yRGhESjdhV21IRnowOTB0dlRIT3JPdXE4eml2ZURBdk9IV2Uy?=
 =?utf-8?B?Z3ptdmYxVzZUcTEzMG8wVW91S0FzZ2lacXk3S1JmdmJaMHZLR0wrakQ0WDRh?=
 =?utf-8?B?ZW5YSWt1ZWs2R2Y3aHFIMm1kY0txMmV6cHhxSlNYY05xK01xWHU2S2p3cnN3?=
 =?utf-8?B?QVlMYUNGUE5Ra1hzVmRwdmxwTlh2STRXdklLVGVhK2R4VzJTejdJODhHNTZN?=
 =?utf-8?B?bDRRU1l6TldocitFeitnNVk0N0VHMVJFVE9jQ0N2K21CaDJWZEtSNXJvMkFm?=
 =?utf-8?B?emVCNWM0QTEybHJEelJyWVA0a0c5Q0h1dk5ZYkorQ2lWZHdway8yOFBxTCti?=
 =?utf-8?B?TTgyakVXb0RsV3NMQWlDcXRZVy82UUVOY250UXZyY0RUUy9QZVlzeEs4bUNR?=
 =?utf-8?B?UWhKM1R5T1dYTVBEbWdJMkhyZTdSdGhFcE43UE1CR2xXSS92SER4Ny9WNDJr?=
 =?utf-8?B?a2ZYRUJ2Y20wcFlISXlZRzFIcG1NL0dUbXEwRU1aYkZUZEZBdUtTV1oyZGth?=
 =?utf-8?B?b1VwYm1Lc1ZzWWhCcjBtYUVQT1RsQzM2eW9jVURQQWtQVk5GdkRDR1dqdlVj?=
 =?utf-8?Q?mac3DJdxgdnvhwSO0wJ+RKki9?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59fe3f46-9c79-4c44-17f8-08dbdc7827fb
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 14:21:22.9477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLUTznUSxi4428e1gFoXIEiYe361Hr2U0DA/UR0LEhSPFCBTDYqculrPm63btlyv++v01kLmoWQLBrKmgHlkUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6242
Subject: Re: [lttng-dev] Building the Babeltrace-Libary for Windows?
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

T24gMjAyMy0xMS0wMyAwNyBoIDQ4LCBTZWlkbCwgQXJvbiB2aWEgbHR0bmctZGV2IHdyb3RlOgo+
IEhlbGxvIGd1eXMsCj4gCj4gYWZ0ZXIgaXQgd2FzIGZpbmFsbHkgcG9zc2libGUgdG8gZGVidWcg
QmFiZWx0cmFjZSBwcm9wZXJseSwgSSBzdGVwIG9udG8gCj4gYSBuZXh0IHByb2JsZW0uCj4gCj4g
SSBhcG9sb2dpemUgaW4gYWR2YW5jZSwgYnV0IEnigJltIG5ldyB0byBMaW51eCBkZXZlbG9wbWVu
dCBhbmQgZXZlbiBtb3JlIAo+IHRvIGNyb3NzIGNvbXBpbGluZy4KPiAKPiBJcyBpdCBldmVuIHBv
c3NpYmxlIHRvIGNvbXBpbGUgbGliYmFiZWx0cmFjZSBmb3IgV2luZG93cyBhbmQgSSBoYXZlIHRv
IAo+IGRpZyBkZWVwZXIsIHRyeWluZyB0byB1bmRlcnN0YW5kIGl0IGJldHRlciwgb3IgZGlkIEkg
anVzdCB3YXN0ZSAzIGRheXMgCj4gb2YgbXkgbGlmZSB0cnlpbmcgdGhlIGltcG9zc2libGU/Cj4g
Cj4gTWF5YmUgeW91IGd1eXMga25vdyBhIGxpdHRsZSBtb3JlLgo+IAo+IEZZSTogSSBpbnN0YWxs
ZWQgZXZlcnkgTWluZ3ctcGFja2FnZSBvbiBteSBtYWNoaW5lLCBhbmQgSSB0cnkgdG8gCj4gY29u
ZmlndXJlIHRoZSBwcm9qZWN0IGFzIGZvbGxvd3M6Cj4gCj4gLi9jb25maWd1cmUgLS1wcmVmaXg9
JFBXRC9pbnN0YWxsIC0taG9zdD14ODZfNjQtdzY0LW1pbmd3NjQgCj4gLS1lbmFibGUtYnVpbHQt
aW4tcGx1Z2lucyAtLWVuYWJsZS1zdGF0aWMgLS1kaXNhYmxlLXNoYXJlZAo+IAo+IFRoZSBjb25m
aWd1cmUtcGhhc2UgcnVucyB3ZWxsLCBidXQgdGhlIG1ha2UgcHJvY2VzcyBmYWlscy4KPiAKPiBJ
IGhvcGUgaXQgaXMgdGhlIGxhc3QgdGltZSBJIGhhdmUgdG8gYXNrIHlvdSBzb21lIHF1ZXN0aW9u
cy4gSSB3aXNoIHlvdSAKPiBhIGdyZWF0IHdlZWtlbmQhCj4gCj4gU2luY2VyZWx5LAo+IAo+IEFy
b24KCkhpLAoKSXQgc2hvdWxkIGJlIHRlY2huaWNhbGx5IHBvc3NpYmxlIHRvIGNyb3NzLWNvbXBp
bGUgYmFiZWx0cmFjZTIgd2l0aCAKTWluZ3cgb24gTGludXggYnV0IGl0IHdhcyBuZXZlciB0ZXN0
ZWQsIHNvIGEgbG90IGEgc21hbGwgZml4ZXMgdG8gdGhlIApidWlsZCBzeXN0ZW0gbWlnaHQgYmUg
cmVxdWlyZWQuCgpXaGF0IGlzIHRlc3RlZCBob3dldmVyIGlzIGJ1aWxkaW5nIHdpdGggTWluZ3cg
aW4gYW4gTVNZUzIgWzFdIAplbnZpcm9ubWVudCBvbiBhIFdpbmRvd3MgaG9zdC4gWW91IGNhbiBo
YXZlIGEgbG9vayBhdCB0aGUgQ0kgam9iIFsyXSBmb3IgCnRoZSBkZXRhaWxzLCB0aGUgY29uZmln
dXJhdGlvbiBpbmNsdWRpbmcgdGhlIGJ1aWxkIHNjcmlwdCBpcyBwdWJsaWNseSAKcmVhZGFibGUg
aW4gIlZpZXcgQ29uZmlndXJhdGlvbiIuCgpDaGVlcnMsCgpNaWNoYWVsCgpbMV0gaHR0cHM6Ly93
d3cubXN5czIub3JnLwpbMl0gaHR0cHM6Ly9jaS5sdHRuZy5vcmcvdmlldy9CYWJlbHRyYWNlL2pv
Yi9iYWJlbHRyYWNlX21hc3Rlcl93aW5idWlsZC8KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYK
