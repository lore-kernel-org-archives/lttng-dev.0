Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB540C4332F
	for <lttng-dev@archiver.kernel.org>; Wed,  1 Nov 2023 15:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1698851502;
	bh=ZeYs7r/fAOgwMth7Z0CUhP9gO6YlO/3GtXBhYrkEvO4=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=B/7OQQKFe4TrSnuMxbqNhXlqeos5VjfVPx5YhoTxVOqZg/7TDaeLUhpsx4yWrOuVh
	 JVAr1vM3MopESucNsWa/6gdvb0vQ4kzOtg8y/HzI+biQVNTwKlvM7xf+ioq1BFQbry
	 TEBuR02YWuly2A42QU4p5g3LEJTIEmxlSaCaidI9Hy6fRA2Dtji9kkBrcAnwk+xI87
	 OCOB+//aS/4+BCmY0u7p2Re5YQI4wj8E/GGXQbojNiMJkB5uwzgbypCRDK4QR0YTmk
	 5JsQvZCHbMimn3fS45H5/OCHiG8odNwZPLzyHiWnuyGH3tONQhqJIN4Uj+Z9ynyio8
	 fFAfh8h18o6zQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4SL9T95dwLzBnr;
	Wed,  1 Nov 2023 11:11:41 -0400 (EDT)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:241c::600])
 by lists.lttng.org (Postfix) with ESMTPS id 4SL9T84PlBzBsq
 for <lttng-dev@lists.lttng.org>; Wed,  1 Nov 2023 11:11:40 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6w/0RZCaAxKafxlnU46ivGk3GDMksETJa5clD7gnXDumLY1o8s8NGIqWMH6dLPgwSIwnjskm2UpxSD2nAYeX2xwjWye/cZtdcdtNwuAaV78VkyLWmVi2UO2Ggt9YwpBx67jqeNtaRkGCpF2EFi8omsw/94mqjJpjX5mXUDl5ufhQ6SDE2dXjE5SyB11nLmIdygm0lWAaulRIzFgiSsaivsuxbLetorP4OWpIrha7onCppgVNTiNJBTJncZbkLdMb+rYkJhA8FmZnwhnXl5eoDNM0RzGWgXnCPfD6GmAwjvEUMMzbMwekN93szIT0prrXyAxhIlStwXs3rjRboCC9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5VlELJIanbe7StFCVztbjcJcwz+e6uGMNTMe/xrCWw=;
 b=cVWKPEhqXEd8mLTyyVA5T3Ut9BTM3EQ8LeWIiH2+Ez2LKPxvUAqvLZJQs3PnSzUPX5W9ckldaQLVumt0UFuvBvDkCTDsb3256yLCBKLUdQ4A46IApJb/9wCtJaK2ek5BbUsT3Md2fcnTqjq83eCUFJgwlvJLeAyn32PWaf3gXZqzHDybvOSmBVyv/nXoiIqnVkow36eQss7fIxanhnTgT3r6PPRcw5J8wDTIK7VKHnVcwv3BqfrIGg3Are8AJDMOB5gT4LfklugruFbNeooyARkdiKwtxsT2eNFKIuwSyaYqs7l1mNax9WZKY8SUSHyVJaz/fy+bhKNCmsxRrJJT4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:de::19)
 by YT3PR01MB8387.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:9d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 15:11:38 +0000
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::da47:621a:32df:13c2]) by YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::da47:621a:32df:13c2%4]) with mapi id 15.20.6954.019; Wed, 1 Nov 2023
 15:11:37 +0000
Message-ID: <055002f7-cd6f-434f-8fa0-4b97296afa22@efficios.com>
Date: Wed, 1 Nov 2023 11:11:35 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US, fr-CA, en-CA
To: =?UTF-8?B?5aec5rabIFRhbyhBRCk=?= <tao.jiang@jiduauto.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <ZQ0PR01MB1062ED24B7D2F6A14F06A92197A0A@ZQ0PR01MB1062.CHNPR01.prod.partner.outlook.cn>
 <abf9f8b8-059c-437f-a8d3-aa796d9564d2@efficios.com>
 <ZQ0PR01MB1062F47CF4B19FF30D81FAFD97A7A@ZQ0PR01MB1062.CHNPR01.prod.partner.outlook.cn>
In-Reply-To: <ZQ0PR01MB1062F47CF4B19FF30D81FAFD97A7A@ZQ0PR01MB1062.CHNPR01.prod.partner.outlook.cn>
X-ClientProxiedBy: YQZPR01CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::14) To YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:de::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9793:EE_|YT3PR01MB8387:EE_
X-MS-Office365-Filtering-Correlation-Id: 078aecb0-da11-4ad3-dbe5-08dbdaecd816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O+0xwB99ZbkRSDPsq5CanWufnFPfENfTS+KYkrutI41v6p//ShI2xwbka7gyYa7yGtwdbf9/oBeulUKD45CykrKok97a97Vswu2c2kwC5kqRpYmLz6b5Lv9fa+G1sF2/ALqrGItsLIZ4678Z6DIRHqnqWGO3GBIQj6dUBV0vgpdOqcTVpoi/8Uwj+M3mABIluFqToqO357SM3yNuFMZ0be12c8CQeCVEa95SkIhpx39fTAfiEfaqzokPWjNz+eEj7SNK2AFwE1WP0fiili2bj49YAgmkwoOGpNzZtWOcyoghEV6KoutSBaCMQ4mzWZZDGqtPl9y+BA/cH/HJkNZg8KjQs14q4FRJBULvkHo33Jt910SC/yr5s+9rFNn/MpzSWzI9oxx2u2NwEoWS2era5EcEVEA3yl18hzVYCIkZ2znpDFMJrLZQ+vgVGia7z4VFqvUsVExPJoEI+bvMcnhG5j2lnR9tDTI062olRBbCNgCj6FhWUxZz4S05SSct0MzE+GCGXjvBZ81hwrc8CComWcS9Tlq34SOpPfdb1rHI08hX7r67KaXJrfjqFs/Kg/o2bnwFrrrNg7yV+w+wvbkAEaRVb4/UujLY/IiVsdFHvaPhu/xRHXW1+uy+N0LDXNRFOKGSgl10rlASz5pWiFNMdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39830400003)(136003)(396003)(376002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(31686004)(26005)(2616005)(6512007)(36756003)(31696002)(86362001)(224303003)(38100700002)(5660300002)(4744005)(2906002)(53546011)(478600001)(6506007)(8936002)(66556008)(66476007)(66946007)(316002)(6486002)(41300700001)(4001150100001)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2JwQzBnWHM3dU4waUZoTGhMRklPS0JLN0c3K3lremQyRkpRR2VNN09NTEwr?=
 =?utf-8?B?TFI0dE4zZkEwVGU3ODQxTGR0M29Tc2pkYUZFV000SUxqdSs4Uy9RRWV2N2ts?=
 =?utf-8?B?THh6dXhOekRGb3A1eFNUeWhQeHkzK2pCOW54bGRhempQdjhURzZUS0FYQlJq?=
 =?utf-8?B?UFdheG9CM1VLV2NpeG1UVlQxM0tKOFpCT3UzNit1TSsrMkptbGtMa05FdUZN?=
 =?utf-8?B?UWdqb2ZoWUN1eW05ZUEvbEd3RVpvL0lURUFFY2lpN05TSEp6aEhaZGZzaDBG?=
 =?utf-8?B?WXVIU1NmZVl4NHpTbjFoYUIwWFU4RkQ2SDA5VFUyaGg3N1NobDZLQWRTdmly?=
 =?utf-8?B?TVlqazZPTzl1cE9GOTAxUVpDZEk0ajl5SWE3cWVQS1BFekc1SXVEQUlucjZp?=
 =?utf-8?B?a0tadlk0bWFkbVRGeW0vRVJJL0RDbFhvTE82cXB5ZFQ0cjArclh4Zmo2S0tN?=
 =?utf-8?B?dVJ3RHMxMnhsb2YreDBsNGp2NEZ2cXlsWHlRTGRVWGdHV2Q2MEN0Q29JTkpP?=
 =?utf-8?B?VEt3VjJ6SFZWWjkvQXFMVGh4NnNLQ1d4VFZlaTBtTnZ0bUM1L3R2V01tRk5I?=
 =?utf-8?B?clFmZms2eXBhMm1zVGh3Vys0ZXFscitMMG9yRnpjdFExUCtXWnZGQkdrOWJm?=
 =?utf-8?B?YTNVZGVOSjluYUxXM1UyTjdwaTZrZjdER0dDNElkSFFubmFueU5Ob1V0ZGZM?=
 =?utf-8?B?Z1lVeGQ1ZmJSSm9oRXU4WVpNVEVZR1YxREVJc2ZTeDNvdlJkb0VlOUxNUzVO?=
 =?utf-8?B?RCtGWitnR2NaZWtiQ2pjTVVCcGlNbnB1Zm5nNm8xaElKdnJYR0hWY2FRb0RD?=
 =?utf-8?B?NUU4OHg4cUhOS0tKa2RjNXAvYjg0SDhFK1VXTGFUcHRvUkN6WmE5VkFreWY4?=
 =?utf-8?B?ZUpMaU5PZ2NnY3FaTjk4VWdXS0tEQTJIcGZpbHNGZW4wSUVFYjIyWkNEK3dR?=
 =?utf-8?B?TzhlcnlRbzV2T1VidkIvQU5tVFZIbUFSTHJmWEJjYkNLaExXc3AvTFNwTGNs?=
 =?utf-8?B?bDMrQW5yaWswU0gwNnJ3dGpuZENvdkY2Qy9MWkxBL2pkbHpTemhYVm9zRlla?=
 =?utf-8?B?a3krait5TS9SY2JiUFFGdnpGN1BIeWpncTBKWkUzQTQ1Q3I3dnFZRS9QRXBY?=
 =?utf-8?B?OUx2RHEyeU0xMU11NnoxeW5QOVVRd1dXb1Z5cW9vM3lnUDVVN3I5QVNhRzY5?=
 =?utf-8?B?MkVvSjJTOU5NVUJiRjhDci9Sa2RtT2lnbEJiL0xvUWpLQzIyS2pEcjhybldR?=
 =?utf-8?B?VDF5b29ZZ2ZydG1QT0U4ZWUrNmxNWHQzU1lMTmxYUHJmd2tOSEhuY3dOcEJ1?=
 =?utf-8?B?ejhHQXROdkR6KzE1MWI5ZU9YTHpHY1hiTmZncGFiNVlUenZXcldlV3FHeTJT?=
 =?utf-8?B?OXZVL2xSMExBbm1pRm5SQWFtdjR5U1JOa3ZNdGh3K21RRzloMHAycnNKdDNa?=
 =?utf-8?B?MWJYZnFoTEh3M2lHUGNZSXJEMVFpYTRsMU1UbXFBL045anFudHBEbjQyZDRx?=
 =?utf-8?B?cXJqbGpVNnd5VUR2YmVxRnpPTk1aeE5SNjF0MmZ4UmF6czg1V2V0czRhZDl1?=
 =?utf-8?B?cGpHUmx2NS9jaXBsZ3pMUUNCRFN3ejY2S2h0WVdVMzFXcXEvUVRkZlhTWkJO?=
 =?utf-8?B?K1ZkZzFuV2hWYmJnVDNtMjYyMkhIOVBmU2ZZK2VwSGRzTExxS3NYTW5saUE5?=
 =?utf-8?B?U0xIK1E0K0VHcUw0TCs2elRkWTVXcVVxU0d2VG9Wby9idU0raVB3L0RHQXFZ?=
 =?utf-8?B?bXZsQXQva3JQOHk0ZTVXUzZ1TEk3UHZPRERoQmgyUVppaGZQcUhuVHB1MHU2?=
 =?utf-8?B?dkNkRzQ1UnY2TXF6eXpLNkRud0tDOTNLMkxRNWo4Z3BBZTdMQUtoU0U3dzZE?=
 =?utf-8?B?SkI2V3YzdjltVlBzRGhTTmczOHdJYnBLSUxjdjBxaU9wa3hvMEFZZUlhVXAv?=
 =?utf-8?B?bTNJMlNGYkRnTGJ3aDVwMWRMTGduSVhKbnExOTM1WGxHdmNub3RkclJnRXFw?=
 =?utf-8?B?TDZzM2xmRG1zWG5rVHR5UHEvNmMyS2lRZ3pjcFp6YnlkOWdXUDVGbEQ3Y21G?=
 =?utf-8?B?enRsYUhGRG4rbnhhM1E5U1NWbGROWmNwTk9TSjlHR2YzMTZhOHZ2d0dpNGFv?=
 =?utf-8?B?K2YzWXJYeUszUU1xYVZoTTI1QmpKTmU4T2dadEo2aDlLb2FpUTlXV2sxUnRi?=
 =?utf-8?B?U3c9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078aecb0-da11-4ad3-dbe5-08dbdaecd816
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 15:11:37.6720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hGneM8yBRZlSW0W9r2fq24NWCj4aq8O29JTRUeFGMu9N8P7i8Dp80bS4pbiLylHE57uGk1XVNZ34ziD13OGpDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8387
Subject: Re: [lttng-dev] 
 =?utf-8?b?562U5aSNOiAgbHR0bmctYW5hbHlzaXMgZXJyb3I=?=
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

SGkgVGFvLAoKY291bGQgeW91IGtlZXAgbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZyBpbiBDQzog
b24gcmVwbGllcyBpbiB0aGUgZnV0dXJlPwoKT24gMjAyMy0xMC0zMSAyMzozOSwg5aec5rabIFRh
byhBRCkgd3JvdGU6Cj4gSGkgS2llbmFuLAo+IAo+IFRoYW5rIHlvdSB2ZXJ5IG11Y2ghIEl0IHdv
cmtzISBCeSB0aGUgd2F5LCDCoHdoaWNoIHZlcnNpb24gb2YgCj4gbHR0bmctYW5hbHlzaXMgY291
bGQgaGFuZGxlIHRoZSDigJhwaWTigJkgZXJyb3I/Cj4gCgpUaGVyZSdzIG5vIHZlcnNpb24gb2Yg
bHR0bmctYW5hbHlzZXMgYXZhaWxhYmxlIHRoYXQgaW5jbHVkZXMgYSBmaXggb3IgCndvcmstYXJv
dW5kIGJ5IGRlZmF1bHQuCgpUaGUgcHJvamVjdCBpcyBleHBlcmltZW50YWwgYW5kIGlzbid0IGN1
cnJlbnRseSBiZWluZyBtYWludGFpbmVkLiBJZiAKeW91ciBlbXBsb3llciBpcyBpbnRlcmVzdGVk
IGluIHN1cHBvcnRpbmcgZWl0aGVyIHRoaXMgcHJvamVjdCBvciBvdGhlcnMgCnBsZWFzZSBkb24n
dCBoZXNpdGF0ZSB0byByZWFjaCBvdXQgdG8gRWZmaWNpT1MuCgp0aGFua3MsCmtpZW5hbgoKPiAq
5Y+R5Lu25Lq6Kio6KktpZW5hbiBTdGV3YXJ0IDxrc3Rld2FydEBlZmZpY2lvcy5jb20+Cj4gKuaX
peacnyoqOirmmJ/mnJ/kuIksIDIwMjPlubQxMeaciDHml6UwMzozNgo+ICrmlLbku7bkuroqKjoq
5aec5rabVGFvKEFEKSA8dGFvLmppYW5nQGppZHVhdXRvLmNvbT4sIAo+IGx0dG5nLWRldkBsaXN0
cy5sdHRuZy5vcmcgPGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmc+Cj4gKuS4u+mimCoqOipSZTog
W2x0dG5nLWRldl0gbHR0bmctYW5hbHlzaXMgZXJyb3IKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZA
bGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9s
aXN0aW5mby9sdHRuZy1kZXYK
