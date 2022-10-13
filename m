Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245A7C433FE
	for <lttng-dev@archiver.kernel.org>; Thu, 13 Oct 2022 07:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1665644892;
	bh=AJFDBlMg/0Sym/Bs6mK4Llz1ZIYM0zXZh75W0eu9y/4=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=pHXvg4hPF0R/F7zpVVRqShkslMnNyOLoxe3rYOWAwNODJM4azT/rVdp6cY5fo2vW1
	 1wpDXzu9urX3KmvCd4nDL1ZDoLFPgeTZS2awnfjOO/9MI+MKwCc3qTR+EK0wkcv/3R
	 4pB/bWNftMmbY+1qLYssYno/8yA/dFLM13qCvFCRZAE39ejoPlQtR3/pZgui07Wfby
	 odYmPWj2VdOz6hnrvPDDHim8fqcKD+tZMvnHMJl4UCADCzivrAvPJbgNzL+aqKw1HF
	 wmfV8dmbabyL6uLbcIvwTPzgZoFHqxO+AU90hKYQJ26ZwAawZlTVvvj0J/HP4Jb0/i
	 vdhEM2FR9Vjeg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Mp0wX16Lwz7Gk;
	Thu, 13 Oct 2022 03:08:12 -0400 (EDT)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2087.outbound.protection.outlook.com [40.107.116.87])
 by lists.lttng.org (Postfix) with ESMTPS id 4Mp0wW2z44z7Bs
 for <lttng-dev@lists.lttng.org>; Thu, 13 Oct 2022 03:08:11 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zqb7xV/oYHYp5eF9cHrbAIqYCXchHQU7LId/GUuQB/udRQVSuWBSQZSVQ3YRv5KZ8nHvzkPDKltwYhSvadRTYTWBaJVXfqGoSeHSYIf5BrudMKfuWK+wWFZXBUCcGs7M2ylcYh7o1qvkvp03Xc32cuVdyb7VvGPyAZgc7zr6m4IvY++plvKhzlfTSg7reo4MBZjuSPWmPG9kHKak1Jsr0kTaSwgY6OYzrQc3/PHnAE1BOdtUPzz4SlzeWO2M+JwSs72LoTXsapbQJZaGnFXaT2NDVZctivZjYT6WHUicF9qnPnXSswpG5rY5tFlD4BNHp0xmzct4+tRLmMN5ulo5FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQPQefoTBt6j+punaCChOtol0dA3vCPkDJkF5O62CIU=;
 b=MWxaC83ZTcWBssi7dMamb5JAiljzOCVe6CqNOWtGVc4xEyEG1aKajw0V0fDwS2hVP2L7G9v7WB7OYyUp6eryIxxWwV0VcdU0zcTOINfoQHegoj9qz2tIk7xTmUZzSnWwDIpji8TG545KsbkG/2I/TakyHIcq0moYp8Z3eAovaBVG87BQ6uSaYqC2gSmYVCQkDD08Az581ecGCfuXDztEb3bNEdxZX2599qCclbdjD/EiQZ/IcdYPnTLW8NV+wqfuq4h2pJ0UsFoqZLc0pgofvX7fuUEEtsULGsMmYkrOdJ5DsmHYpWP/c08JYxppJwPIVYBEbizjUps9QFqFD6leQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4e::11)
 by YT3PR01MB8466.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:9f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 07:08:09 +0000
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a05b:5150:ef:dede]) by YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a05b:5150:ef:dede%6]) with mapi id 15.20.5723.026; Thu, 13 Oct 2022
 07:08:09 +0000
Date: Thu, 13 Oct 2022 08:08:04 +0100
To: Alistair Francis <alistair23@gmail.com>
Cc: Alistair Francis <alistair.francis@opensource.wdc.com>,
 lttng-dev@lists.lttng.org
Message-ID: <Y0e5VMVzJ1HBGe3M@efficios.com>
References: <20221007003918.344922-1-alistair.francis@opensource.wdc.com>
 <20221007003918.344922-2-alistair.francis@opensource.wdc.com>
 <Y0a+yByE6vUtFc2P@efficios.com>
 <CAKmqyKM=EN0NnKPcysDdUk+yPR6D=69G8pLTkrUYKHGj_47cpw@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CAKmqyKM=EN0NnKPcysDdUk+yPR6D=69G8pLTkrUYKHGj_47cpw@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0682.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::7) To YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:4e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB5984:EE_|YT3PR01MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 024e6d21-81f5-4632-4b7a-08daace9aef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Fpd7ohZe2B0exa2rOZwjkaS23Ox7HOj2gmkKI4eqi1BRMxDvPyGoePAj/jjzc34oGNDuvRThBkvpa45r5hiitKSGoKllQcJMYjXbYaCZCIhWq8N1RqTkZ2/d6yt4hsTwUHMROrZGgKZI7Rs8jvLid/nyWPjUwPasSoTHYksUR2bASH2sNtoSBCsJGDttq2+hzKc6mGIKRcZ+VMVYFnIKALMRII4TdX2wBlFNmQ9crCHO448+CWj4+/ntz9DoRzVPJMuni7D78i61xE0k2dte056bndHqEaC6Zc5ACV8mzOym7KzTgRR80j3lnpH0oK9Vc8C4hWBa/tGMpNS7vovP6QuPsViLEXK9VKhQZpmZfCbH1wW/FS6Gkp2cHNwiqBE8E7eGo59zteG4rBw7kxpQ5bGUhK2parMcWYCqu+orZQ70DpgZJeAVas+8A8emRV1zPuP7kDQsQbZnBHsj7b8lZlEh4evx5DAeSKNbfp4KxGN6MaHiJxMtrX1BcvK0V0GfGWyElnxNwCGIzXNFSufID3XAuje92zLES5g4ySxI6yTuvc9RpUws5kzBYyH3XumqPn1q7qBB2UzVNToVFOEqw9XecdQxIWMQILReb25itpluyCj2u9xtVLNe2ErUHXLRTrmjTXkAevJQcg8WrxCWgrWQm829t3prrNVe8IquKPTpFQiDukvKLTQ54Ny9MW8ObWbZN0zcJVWtUs9EkVXgJ6e/vka2qxfhDaneaZ2tvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230022)(34096005)(42606007)(376002)(396003)(346002)(366004)(136003)(39830400003)(451199015)(6916009)(26005)(6506007)(36756003)(53546011)(55236004)(66574015)(2906002)(6666004)(2616005)(83380400001)(316002)(41300700001)(66946007)(4326008)(8676002)(66476007)(66556008)(5660300002)(8936002)(186003)(6512007)(38100700002)(966005)(6486002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUMvU2xXWUg5L0h2akc3OWlFNEx3RGtjREk4VHBnU29vZWttY2RPc2lPZThh?=
 =?utf-8?B?TjZORE9VdlU0ZEVVeThSOHpPdSthWElaL3R2R0pXR1pEY3lMUWl3MEM5MEMv?=
 =?utf-8?B?QjYyTHd5M1hvZzFxQmVGWXhhL2tqL2ltQ1kwMExTSUlWbUVrZ1htTUhLZ1lK?=
 =?utf-8?B?UkppekRleWRuVDlpTnI5VkdxNkVtQ1JIcWxyd1BaQS8vZm5DMHgwcm1uR1ZB?=
 =?utf-8?B?bi9ld24xUEgxRVFrbWtwMnVaT0RPdm5icjZGY0JjSHFXemtyME1WeTZSQ3R0?=
 =?utf-8?B?MnIwN2hzZ2htU2F6WldqSkVRbmJ3OCtiMnFZVUkrdDhLMUF0eGVjNm1MeGdm?=
 =?utf-8?B?L3pGVGtvcmpBeEtwUDFnSzFLeEtwT3dFdEhWTHFieU5ETkhaNldQZHhTUklW?=
 =?utf-8?B?KytaUzczMGZ1V0U3WVF4OExuSXFXemcvQ0hmbkhIZFZrTVJpVzRQQ3pXdmY3?=
 =?utf-8?B?dmZsTzcyemJTMGlGbGRjSkVhZS9BQ2dKd3BIYlZHVFJiTWt0ZWVmS2kzNHFz?=
 =?utf-8?B?TVZTWElwMFBoUmQ2Rkg1M0tPN1pXcnBleEVScEdhVTNMNTQrUVc4Ykc1Y2ZQ?=
 =?utf-8?B?cWk4K2xKZFBkNWlpRTcxNXo5R1FaT1UwSmFMYk9EcDl5Qjc1cmQ0Sk1NeHNk?=
 =?utf-8?B?NFZmalNNenc1bEszYWpJc3JyenJKazk0WHkyQTNRaVROd0FXbWJ6L213OGhn?=
 =?utf-8?B?ZUxoNVV3b2NUZmhNY043RFNrQVZ5ekNpNDdPUDNsR1Q5RCt1TnVjT0Nja1Ar?=
 =?utf-8?B?RThmRFBLVVo3QXJBYzFiUmpUQjI3QVdUMjY1WlRMWHd4RkdEUTZub0RsOURs?=
 =?utf-8?B?cUpRNDNpQmNSNEhFQXV3Y2trZHFqcTFYcHJRYVlzK0FmcVJVVW5qM1JSQ1Ri?=
 =?utf-8?B?Q0tQdDBVc3kzb2I4RzI0ckxUMDJxQWxCalZkY0MvWEwvOGQ2bmRjUGw2ZUd2?=
 =?utf-8?B?d1k5QjBCQUM4dVYyS2JqdjBmN09CRkU1SjJFNWU5U1VpTUcreFZidHRzN0xs?=
 =?utf-8?B?eWRTOUNmLzlhenhCckNySjNCTncrK0FMQkl4cHh0K3FNUmZnNitONUxNRWNz?=
 =?utf-8?B?YjVBdzRWNWc4N2hZRE5BY1Rud0RiZkNxZnMzeHBzWk9GZDdGWitMWlAwajNz?=
 =?utf-8?B?S2NDeHFyQysvZWNYVnFPTC9hK3VIRjg1ZTd3TExnTzVNUDd3anRUNTZEcFBl?=
 =?utf-8?B?MHlNTkpiVitBWnEzNlJsTGdJOFQ1SnFEOWRPTzZqUGp5TGhMZ0RuSHdabWRq?=
 =?utf-8?B?YVpmTFVwWnJqb3lyWThPNVdTcHd3aGl1emFpaGtWYlpvNkIxVGxuZmNmclpX?=
 =?utf-8?B?MUZzMW5zbU5hc05kMCtPRWZGc2JWZDI0RDU0VmJLRkRvU1pyNUdGTXp6S1dw?=
 =?utf-8?B?L1pEaDRoQnVoR2Z0V2JVQmkyN1VRN3didDg2RzRsZzV6L05TZnpEVi8wWEd2?=
 =?utf-8?B?ZEJWVWdSVXlYNWI3c0VibHQwaHdXejROdUFtbCtML3p2MDMxdFNPTDdQTEJn?=
 =?utf-8?B?M08yVE81VWNnMDNGa25WWnJCeWc5bzJkQ29LdVVIL0h0SkdKVGlZNFdwLzdZ?=
 =?utf-8?B?WEVreHNmUW9teFJmWkUwUUtLUnZsRXdoV25PVkcyQ2FITWNxZUgybWRuUWgx?=
 =?utf-8?B?Q2R2SFB4QmJJNzRoUTRzMlFUbC95WVc5c3NiSUN0UnpZWUZSdzJCYlE2Q2Ny?=
 =?utf-8?B?NTIrYy9ZWjNNVDladUxHWXNhejRRMXMwKy9INnJGd2g2bmkvK3VPSVVoREhu?=
 =?utf-8?B?V0hsUFFOWjloRnZQSm1mSjg0aFYwTTdhbkl4MGpEOTNld2tsc0k1NWVqUU5Q?=
 =?utf-8?B?U1p2eXl3WXlQYThTTFFFWGdjeUxXTmZSYjVBd0hGb3hBdVg1RlZRZWh6cjl2?=
 =?utf-8?B?ajBqR3pMYmZ3d25GVkxWTWloa29leWpBTFVtRDMxL3pzUXhlVUNtRVB5SU9o?=
 =?utf-8?B?clNueTRPYWU1MmtuTjdnemprcDZPWHNmM1B0b0VFc2JTdkJMZTY5dVlCaWFM?=
 =?utf-8?B?cC9VZkxpQ0pTelNlS2NJOVMrK3lNWm1xYk1uYmF2NG15ekpqTmc2UC83RGxT?=
 =?utf-8?B?SjhpK0tQR2IyLzREUDIvYno0QzE3L0JjbmthVERjbUhuYmFQK1MyQ0VLa093?=
 =?utf-8?Q?mxJpG1MjJ5Zoeb00aKuv9eAEb?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 024e6d21-81f5-4632-4b7a-08daace9aef7
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 07:08:09.1177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nh2pUQUDULj6GXDdP+TVwdkwP80tUIZMQbv30pfkj9p0jBqVhyyVvLtRiyYvxhhoXk/5k1TmX7zqMZWiLsl/Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8466
Subject: Re: [lttng-dev] [PATCH lttng-tools 2/2] Tests: select_poll_epoll:
 Add support for _time64
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau
 <jeremie.galarneau@efficios.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gVGh1LCBPY3QgMTMsIDIwMjIgYXQgMTA6MTI6NDhBTSArMTAwMCwgQWxpc3RhaXIgRnJhbmNp
cyB3cm90ZToKPiBPbiBXZWQsIE9jdCAxMiwgMjAyMiBhdCAxMToxOSBQTSBKw6lyw6ltaWUgR2Fs
YXJuZWF1Cj4gPGplcmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4gPgo+ID4g
T24gRnJpLCBPY3QgMDcsIDIwMjIgYXQgMTA6Mzk6MThBTSArMTAwMCwgQWxpc3RhaXIgRnJhbmNp
cyB2aWEgbHR0bmctZGV2IHdyb3RlOgo+ID4KPiA+IEhpIEFsaXN0YWlyLAo+ID4KPiA+IFRoZSBm
aXJzdCBwYXRjaCBpcyBnb29kLCBJJ2xsIG1lcmdlIGl0IGluIG1hc3Rlci4KPiA+IFNvbWUgY29t
bWVudHMgb24gdGhpcyBwYXRjaCBmb2xsb3cuCj4gCj4gVGhhbmtzIQo+IAo+ID4KPiA+ID4gRnJv
bTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPgo+ID4gPgo+ID4g
PiBBZGQgc3VwcG9ydCBmb3IgdGhlICA2NC1iaXQgdGltZV90IHN5c2NhbGxzIFNZU19wcG9sbF90
aW1lNjQKPiA+ID4gYW5kIFNZU19wc2VsZWN0Nl90aW1lNjQuCj4gPiA+Cj4gPiA+IFRoZXNlIGFy
ZSB0aGUgc3lzY2FsbHMgdGhhdCBleGlzdCAzMi1iaXQgcGxhdGZvcm1zIHNpbmNlIHRoZSA1LjEg
a2VybmVsLgo+ID4gPiAzMi1iaXQgcGxhdGZvcm1zIHdpdGggYSA2NC1iaXQgdGltZV90IG9ubHkg
aGF2ZSB0aGVzZSBhbmQgZG9uJ3QgaGF2ZSB0aGUKPiA+ID4gb3JpZ2luYWwgc3lzY2FsbHMgKHN1
Y2ggYXMgMzItYml0IFJJU0MtVikuCj4gPiA+Cj4gPiA+IEZpeGVzOiBodHRwczovL2dpdGh1Yi5j
b20vbHR0bmcvbHR0bmctdG9vbHMvcHVsbC8xNjIKPiA+ID4gU2lnbmVkLW9mZi1ieTogQWxpc3Rh
aXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPgo+ID4gPiAtLS0KPiA+ID4gIHRl
c3RzL3JlZ3Jlc3Npb24va2VybmVsL3NlbGVjdF9wb2xsX2Vwb2xsLmNwcCB8IDUzICsrKysrKysr
KysrKysrKysrKysKPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1MyBpbnNlcnRpb25zKCspCj4gPiA+
Cj4gPiA+IGRpZmYgLS1naXQgYS90ZXN0cy9yZWdyZXNzaW9uL2tlcm5lbC9zZWxlY3RfcG9sbF9l
cG9sbC5jcHAgYi90ZXN0cy9yZWdyZXNzaW9uL2tlcm5lbC9zZWxlY3RfcG9sbF9lcG9sbC5jcHAK
PiA+ID4gaW5kZXggYzBiNjg4MjE3Li40YTZkMzk0ZjQgMTAwNjQ0Cj4gPiA+IC0tLSBhL3Rlc3Rz
L3JlZ3Jlc3Npb24va2VybmVsL3NlbGVjdF9wb2xsX2Vwb2xsLmNwcAo+ID4gPiArKysgYi90ZXN0
cy9yZWdyZXNzaW9uL2tlcm5lbC9zZWxlY3RfcG9sbF9lcG9sbC5jcHAKPiA+ID4gQEAgLTUsNiAr
NSw3IEBACj4gPiA+ICAgKgo+ID4gPiAgICovCj4gPiA+Cj4gPiA+ICsjaW5jbHVkZSA8ZXJybm8u
aD4KPiA+ID4gICNpbmNsdWRlIDxmY250bC5oPgo+ID4gPiAgI2luY2x1ZGUgPGxpbWl0cy5oPgo+
ID4gPiAgI2luY2x1ZGUgPHBvbGwuaD4KPiA+ID4gQEAgLTQ1Niw4ICs0NTcsMjIgQEAgdm9pZCBw
cG9sbF9mZHNfYnVmZmVyX292ZXJmbG93KAo+ID4gPiAgICAgICB1ZmRzWzBdLmZkID0gd2FpdF9m
ZDsKPiA+ID4gICAgICAgdWZkc1swXS5ldmVudHMgPSBQT0xMSU58UE9MTFBSSTsKPiA+ID4KPiA+
ID4gKyNpZmRlZiBTWVNfcHBvbGxfdGltZTY0Cj4gPiA+ICsgICAgIC8qCj4gPiA+ICsgICAgICAq
IEFzIHRoZXJlIGlzIG5vIHRpbWVvdXQgdmFsdWUsIHdlIGRvbid0IGNvbnZlcnQgdG8vZnJvbQo+
ID4gPiArICAgICAgKiA2NC8zMi1iaXQgdGltZV90Lgo+ID4gPiArICAgICAgKi8KPiA+ID4gKyAg
ICAgcmV0ID0gc3lzY2FsbChTWVNfcHBvbGxfdGltZTY0LCB1ZmRzLCAxMDAsIE5VTEwsIE5VTEwp
Owo+ID4gPiArICAgICBpZiAocmV0ID09IDAgfHwgZXJybm8gIT0gRU5PU1lTKSB7Cj4gPiA+ICsg
ICAgICAgICAgICAgZ290byBwcG9sbF9mZHNfYnVmZmVyX292ZXJmbG93X2RvbmU7Cj4gPiA+ICsg
ICAgIH0KPiA+ID4gKyNlbmRpZgo+ID4gPiArCj4gPgo+ID4gVGhpcyByZXN1bHRzIGluIHRoZSBm
b2xsb3dpbmcgd2FybmluZyB3aGVuIGJ1aWxkaW5nIGZvciBhbiBhcmNoaXRlY3R1cmUKPiA+IHRo
YXQgZG9lc24ndCBoYXZlIFNZU19wcG9sbF90aW1lNjQgZGVmaW5lZDoKPiA+Cj4gPiBsYWJlbCDi
gJhwcG9sbF9mZHNfYnVmZmVyX292ZXJmbG93X2RvbmXigJkgZGVmaW5lZCBidXQgbm90IHVzZWQg
Wy1XdW51c2VkLWxhYmVsXQo+ID4gcHBvbGxfZmRzX2J1ZmZlcl9vdmVyZmxvd19kb25lOgo+ID4g
Xn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Cj4gPiBzZWxlY3RfcG9sbF9lcG9sbC5jcHA6
IEluIGZ1bmN0aW9uIOKAmHZvaWQgcHBvbGxfZmRzX3Vsb25nX21heChGSUxFKinigJk6Cj4gCj4g
QXJnaCwgSSdsbCBmaXggdGhpcwo+IAo+ID4KPiA+Cj4gPiBBbHNvLCBpdCBpcyBteSB1bmRlcnN0
YW5kaW5nIHRoYXQgYm90aCBzeXNjYWxscyBjYW4gYmUgYXZhaWxhYmxlIG9uIHNvbWUKPiA+IHBs
YXRmb3Jtcy4gSW4gdGhhdCBjYXNlLCBpdCB3b3VsZCBtYWtlIHNlbnNlIHRvIGFkZCB0aGVtIGFz
IHNlcGFyYXRlCj4gPiB0ZXN0cyBhbmQgc2tpcCB0ZXN0cyB0aGF0IHRhcmdldCBub24tZXhpc3Rh
bnQgc3lzY2FsbHMuCj4gCj4gU28gYWxsIDMyLWJpdCBwbGF0Zm9ybXMgc2luY2UgdGhlIDUuMSAo
b3IgNS40Pykga2VybmVsIGhhdmUgYm90aCBzeXNjYWxscy4KPiAKPiBGcm9tIG15IHVuZGVyc3Rh
bmRpbmcgdGhlIG9yaWdpbmFsIHN5c2NhbGxzIHdpbGwgYmUgcmVtb3ZlZCBvbiAzMi1iaXQKPiBw
bGF0Zm9ybXMgYXQgc29tZSBwb2ludCAoYmVmb3JlIDIwMzgpIGFuZCB0aGVyZSB3aWxsIG9ubHkg
YmUgKl90aW1lNjQKPiB2YXJpYW50cy4KPiAKPiBJZiB5b3Ugd2FudCBJIGNhbiBjb3B5IHRoZSB0
ZXN0cyB0byB0ZXN0IGJvdGggc3lzY2FsbCB0eXBlcywgYnV0IEkKPiBkb24ndCB0aGluayB0aGF0
J3MgbmVjZXNzYXJ5Lgo+CgpNeSBmZWFyIGlzIHRoYXQgb24gdGhvc2UgcGxhdGZvcm1zIHRoZSB0
ZXN0IHdpbGwgcGFzcyBpZiB0aGUga2VybmVsIHRyYWNlcgpzdWNjZWVkcyBpbiB0cmFjaW5nIGFu
eSBvZiB0aGUgdHdvIHN5c2NhbGxzLgoKSSB0aGluayBpdCB3aWxsIGJlIGVhc2llciB0byBzaW1w
bHkgaGF2ZSBzZXBhcmF0ZSB0ZXN0cyB0aGFuIHZhbGlkYXRlIHRoZQp0d28gaW52b2NhdGlvbnMg
aW5kZXBlbmRlbnRseSBpbiB0aGUgdHJhY2UuCgpUaGFua3MhCkrDqXLDqW1pZQoKPiBBbGlzdGFp
cgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1k
ZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5s
dHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
