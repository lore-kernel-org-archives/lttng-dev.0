Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54173C25B6F
	for <lttng-dev@archiver.kernel.org>; Fri, 27 Oct 2023 17:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1698428848;
	bh=Ud+FhsSbWX16sAhigrnegYCXMzNFUnPzJOz3cWxjGGc=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=0hwiSyKljgFedBiWTgmoMjsKk/+R1aVxRLe6bNSEYZdzqk/liDesaPoCW87hCinFX
	 zstqPoagB64/aES+ke1zl2xsmRx6Z25W4HelQuOWodJAQoGeIOfSt8tZT5iz+RKHBx
	 a8cZAGx2B+25LCZEmqja/J+FIhZfdGaDietD5RAMBDbw/OPL8eL07IZQf0obt4WPDf
	 fu+8juiUhvzGxMI2a6teQa+ZHM9dECajAm39ehC6YGfC78LtDNBYKoRTmwBtYcGXAH
	 DQaBvBjsQphZUj6o03qnkQmaCF7tmFbyC9q/9VGb+hNwVUY5vasevbyDBL0KeHI+bJ
	 a/8JoKeL44NKA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4SH99D0NJRz9gv;
	Fri, 27 Oct 2023 13:47:28 -0400 (EDT)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2053.outbound.protection.outlook.com [40.107.115.53])
 by lists.lttng.org (Postfix) with ESMTPS id 4SH99B2sR7z9gt
 for <lttng-dev@lists.lttng.org>; Fri, 27 Oct 2023 13:47:26 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1PkrvsauuDTJB6oq/17Gq9xw4cc1eudVITy4V09SJP7Q6+iifa2WERqVvvvvN9uOl5DSxDYjZUqIq7QhIN+RFojwo8V+8EcEX8CqlJEov2OULyoaDu97eanEMdzWZ60LJofF/MLEvps0Ritvcwbr8HnteP9mxQDnqENQ6RVebQf+tvQT1oo46yanAQBo0ubfSjAPQxaQrIyPwu16LpZtuhhJNDIaLUjaZISxDqQyc2RZfgATMxIYglw9z7RZZRySXlI2VjP+I22Sjl+PRM7dG8whxR/RzFVVw+hTcgSOAZPWbMfi23mL9ibfxA1Q2U0hmYImS/88Kz/OwJgLOlZIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5XK67sO/JNqVhrChslV0t5FfjklTwDHY8iIbh+DLRM=;
 b=L473OLjpO6SJC16Iwe7wUrpHY20dsnBasPSeVJCwWPAlIhKkM88TX4noitKRhbxm9jXi4hhLwuZNjpNfp6JqhIbaIsitx3t/hI4Sul7Bzmc3tlQw/ODoFyW+F2dizUGii90FwXApwcN9Pl63aC3Z14SHD3qVxfpgnKDpaOCNdkismrIOaK281by9j49qM3ffDXpc5jzuzxuDnrbeuFcvUipnv1I5I7ON6AMuQgPEQXVv0xBHrb5YtkyvEojBVqxnxSq6+UStSuy1g156VitHDWWMWdUKEWXVLJj5E7ARk4Pif2Gh0CiJm5sqG81NMmC5XVEItJhQ+Oe/N+9pJ6SONw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:de::19)
 by YQXPR01MB5537.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 17:47:23 +0000
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::da47:621a:32df:13c2]) by YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::da47:621a:32df:13c2%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 17:47:23 +0000
Message-ID: <bdef3e80-d299-40f7-8281-13d94fa21e5a@efficios.com>
Date: Fri, 27 Oct 2023 13:47:21 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US, fr-CA, en-CA
To: =?UTF-8?B?5aec5rabIFRhbyhBRCk=?= <tao.jiang@jiduauto.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <ZQZPR01MB10609C57DF7FA0C7CAF3AC6297DEA@ZQZPR01MB1060.CHNPR01.prod.partner.outlook.cn>
In-Reply-To: <ZQZPR01MB10609C57DF7FA0C7CAF3AC6297DEA@ZQZPR01MB1060.CHNPR01.prod.partner.outlook.cn>
X-ClientProxiedBy: YQXPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::40) To YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:de::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9793:EE_|YQXPR01MB5537:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c97b1b-27a9-4b9d-dad0-08dbd714c674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cnaFh2Q0gt1HTVBv6eGcNoKuZNBz4P9xICRAZCQt9kcVkt29pvzIFIqIN+ZpDWsk9A64vGs5iUBDmA9JPA/lIAIhyOgCltPzuoEMQhifXLygf+jJAa8pdArvAMO6qKxsz6j58D25L0fGXoacYYddJ2DBCVxSETRQJ0Sw2fr5shPTk0HOC8EcqwhfhwexoE/0zwdPRjMfPz/qrqq3Pkd5rri9Fp+49zn6Ma6SM/oV8jeWqRJNpOFXhXlnFiJUTb6GQjM3Vgoq81glT8wJdw2k2giVAyNCh+V2ZKK03J+Bnxryx1etrkPjpQComKL6pR5GasBRLBQLrfelAojgO3brhJIfSwiiDCceVaaSH+QB+xdJpm2gpexG9hWbr8Vh0sxkHZ0Jz+R6ziONPoLiL2NkTIQsOfC1csMKqhXDfthYUDwKrTqF2aIoizHR5bZwFIHnXtGa4uS4LAyZK0YSQv1rnNwrFH0FqwFzzT0KpvwmEJt3rVJSd/1KKMtfzk686aq0K3pfGMA8LUQ6msPdwI20qz6bqBEHK46tsz/AT7jTfjo75NljcBeBvpCPs5EMNvHHzpZHR4In5n5lsgP5uu/deUWv534EwWojF1NneFHaP2JB23BJjUz74FFYyXbT/BKqoEur2D/oCS9XG6rOsDr3JNy86HKeZ/jwCfhj/PZZJ5tzUBEODU0OKuXNAtpFf8cfQ2GKEpUKU+ogDDm2gtLisw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39830400003)(136003)(366004)(346002)(396003)(376002)(230473577357003)(230922051799003)(230373577357003)(1800799009)(64100799003)(186009)(451199024)(966005)(6486002)(36756003)(66476007)(26005)(110136005)(66556008)(2616005)(66946007)(6506007)(53546011)(6512007)(316002)(8936002)(5660300002)(8676002)(41300700001)(2906002)(4001150100001)(86362001)(31696002)(83380400001)(478600001)(38100700002)(66899024)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWMyNE1Sd2ZGSkVNNloxQXVyeElFQTdVamdlYjJFWGhEYVhiUXNrVXRpdkFS?=
 =?utf-8?B?a3R1OFB5MUZMY0dEbmdMRFlvVExiaTBLT2RMZlVhRXMyTFcwYVR0Yjh2cVBt?=
 =?utf-8?B?TDFkM0xxT2FBTWUxQ2NMdGIvMTJKZytzK0dYNUZwa2hDVDcwbVQ2amNsRDRh?=
 =?utf-8?B?RGUzbFEwclc4WVVRWG4vRTNBOE8rWElFZXVIVlVuMXRSRW1PbS91NDJxUWFX?=
 =?utf-8?B?Q3V4RnhmdVpqRFpzdEFtb09sT05zWCtmeWVqcWtNRG4vTFcyOGVrbmk0a2ZG?=
 =?utf-8?B?ZzdLYmQ0TkdRVDFRUWdLUDYrcU1xcS9ocmxDQ3VXVXc3RXNNeXB0SFFSejFs?=
 =?utf-8?B?aGk0dVFYZXp0UkN0M29zdEpDNWxtOWhSV1dxZmRqTnd4dnRNOU9QSmR1VlJj?=
 =?utf-8?B?VnU4Rk1taHd3Qi95aythci8rcUszUEl0clFtUWIyRHRwQkhzTzhUZWtqNlRI?=
 =?utf-8?B?c09lemZqRktudUxhTmh2RG5uRDRlTDZxd2dodE5DZU5BNzVpOXhhaVFhbCtJ?=
 =?utf-8?B?UE5BaiszUXZ5K0lRendkVkxuVE5mNitnTkZ3V0tLQTIvdVQxbHppdjkyekhi?=
 =?utf-8?B?cnlVN2ZrTFZEMXBRcWlZVC9CcGRzL2JoY3lRbmZBZ1VYdGRlak0zaFhOSUNR?=
 =?utf-8?B?YWVsQ3JFcEY4cUo4R3VEeXNZaDhPRGpSdnJUN1oraHFxNS9veE5qYmIvWkZt?=
 =?utf-8?B?TXFPbkM1RS8xUXBLNHprVGMzNlFmbWI0dWhGSmlBNGJmd3F5Rm1Jdjl0ZEJY?=
 =?utf-8?B?dm5DM0x0N2tyNld6b2xsNE9GaHpxWXNTdW01QUtQRlJYV1dNZzI1c0pLcWs0?=
 =?utf-8?B?Zi9xUE9TQ2tBbEtxa05oaHhmSXdxTjkzb0NOcmlvR3o3S3ptSldHTWxWdnRp?=
 =?utf-8?B?c0JuOFZsUFl1ZUo1cHcxVUZ1OU1QaDFUV1dBYkJRN2Rya0Uzck40MlhOOUVW?=
 =?utf-8?B?VEdZOTFZRDBSSUlqbU41UDE0YjkxcU0waHJsZ3dpNVpkb1E2blBQTGhiVTQv?=
 =?utf-8?B?NHBpeVJmZ1JRK1R0Um1Zem9KTnVENmFNZXJOeFNTT3Z2THY3WDlzN3pEVlcy?=
 =?utf-8?B?UXZrbXMwQWdTZEtFV1oxZDh5QnhlTDV1UDdkWksyZFBFQVhKNVV2aktRdjBR?=
 =?utf-8?B?TVFoT1NVVDFBbjhoMzFqVjBBZk90MytMaTB5L0J3TUduZ2h2L0Zvcjd5Tlg2?=
 =?utf-8?B?NTZGQkdPK1FxcFVMTitWUGtxWm9UYnprZ0p2cStiSjhqc3VzR2tpZDgxRldw?=
 =?utf-8?B?b3dRVG1XUjBicTZjcHMweHVjUTRJUDdLZERsa0xtSVJNK000T0JndUcza25r?=
 =?utf-8?B?aHJ1T2VNcHhHb29LT1F2MUJVNk5MTXFiZ0QwZHJxcGw4VHRSV3RwNzB2aGU1?=
 =?utf-8?B?aEt3OGJWcWtBcmsySDBrWnhyU0s5L1VlTURqa3l4ZTZNRWVycmErdlZCQzRi?=
 =?utf-8?B?Z3NTQVlJQ2xWdnF4OFBHS2diWlMvZ1U2RXNIN1RzZnBQeU5IdDFDSDZEOTFR?=
 =?utf-8?B?K0pBSVplSmhFcHpuaHJFVFR3ajZqVmlJTW5DWkg1cTlBaSthUnlDUGx1cjdx?=
 =?utf-8?B?MUxJbGpnY0VoZUphYnFPZFc5NE1NWWh5MW8vdTdxK2JTeldlejU1QXZxNC96?=
 =?utf-8?B?ejBQbFhNOThaVVgyN2ZhT0lwbFpPbXdBQzV2YkZmSXJBTGs3c2QvNzhmdEp1?=
 =?utf-8?B?bHAxc1VUTmN2a29kREZkWEJuVE1XTkUyNDBNSXFkaU9CR2EzM2p6cjR5RVNp?=
 =?utf-8?B?RjdRZWVyVmVRSUVLeW1TYzRjdjBoQ1lzWVE5M3V0eGd3ZThRa241NWsrZE5P?=
 =?utf-8?B?Tm12UmtKVWNYb1N2R3NHVjRJOFJES3U5OThzWVU3a092VlVXRThCNXBFNmFo?=
 =?utf-8?B?N2s0SkxCUU5Idm9abFo5UVFWMnFYaVN5TEdUSEc1bCtSb2lUVUxsK2dscXF4?=
 =?utf-8?B?d3hUaFhQeGVaKytPZXNISjk3dmxmUGRtUkNQZHQ3bHVENzB4b0FodGJBWXRk?=
 =?utf-8?B?Q09JUVFzWkZzU251QTNZVGRWM0NBaGpMTUhURTRDamQ5R0RDR003WFZYNFJ5?=
 =?utf-8?B?QTNyMmxqMFAwazlFS3BhSVZhZHNodzkvbkxvZ2pMNk1tb2E5T3NTbDhMZERO?=
 =?utf-8?B?U25pdFRTUmtMbUUxQXh2SlhpZGkwd2tuUkw4aGVUVWZSNUp5TlluOTJpM2I3?=
 =?utf-8?B?RVE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c97b1b-27a9-4b9d-dad0-08dbd714c674
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 17:47:23.3039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4o3cB0IexOXw8n9lu8g0roIaLW7ZbKxMPF2xXvZscoRuMRXkOS7sJADvRIsZ0wj+hzssfy6NPj1WieWbtbGhQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5537
Subject: Re: [lttng-dev] Need help: Kernel tracer not available and can't
 find the lttng-probe-latency_tracker
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

SGkgVGFvLAoKZHVlIHRvIGxhY2sgb2YgZmluYW5jaW5nLCB0aGUgbGF0ZW5jeV90cmFja2VyIHBy
b2plY3QgCihodHRwczovL2dpdGh1Yi5jb20vZWZmaWNpb3MvbGF0ZW5jeS10cmFja2VyLykgaXNu
J3QgYmVpbmcgYWN0aXZlbHkgCm1haW50YWluZWQgYXQgdGhpcyB0aW1lLgoKQW5vdGhlciBvcHRp
b24gdG8gZ2V0IGluZm9ybWF0aW9uIG9uIGV2ZW50IGxhdGVuY2llcyBpcyB0byBoYXZlIAoiX2Vu
dHJ5Ii0gYW5kICJfZXhpdCItc3R5bGUgZXZlbnRzIGFuZCBwZXJmb3JtIHBvc3QtcHJvY2Vzc2lu
ZyBvZiB0aGUgCnRyYWNlcyB3aXRoIHRoZSBUcmFjZSBDb21wYXNzIEluY3ViYXRvciAiaW5hbmRv
dXQiIHBsdWdpbi4KCmh0dHBzOi8vZ2l0LmVjbGlwc2Uub3JnL3IvcGx1Z2lucy9naXRpbGVzL3Ry
YWNlY29tcGFzcy5pbmN1YmF0b3Ivb3JnLmVjbGlwc2UudHJhY2Vjb21wYXNzLmluY3ViYXRvci8r
L3JlZnMvaGVhZHMvbWFzdGVyL2RvYy9vcmcuZWNsaXBzZS50cmFjZWNvbXBhc3MuaW5jdWJhdG9y
LmluYW5kb3V0LmRvYy51c2VyL2RvYy9Vc2VyLUd1aWRlLm1lZGlhd2lraQoKT24gMjAyMy0xMC0y
NSAwMjo0MSwg5aec5rabIFRhbyhBRCkgdmlhIGx0dG5nLWRldiB3cm90ZToKPiBIaSBldmVyeW9u
ZSwgSSBoYXZlIHJlYWQgdGhpcyBibG9nOiAKPiBodHRwczovL2x0dG5nLm9yZy9ibG9nLzIwMTYv
MDEvMDYvbW9uaXRvcmluZy1yZWFsdGltZS1sYXRlbmNpZXMvIAo+IDxodHRwczovL2x0dG5nLm9y
Zy9ibG9nLzIwMTYvMDEvMDYvbW9uaXRvcmluZy1yZWFsdGltZS1sYXRlbmNpZXMvPiwgYW5kIAo+
IEkgdGhpbmsgbGF0ZW5jeV90cmFja2VyIHByb2plY3Qgd2lsbCBiZSB2ZXJ5IHVzZWZ1bCBpbiBy
ZXNvdmxpbmcgbXkgCj4gcHJvYmxlbSB1bmRlciBsaW51eCBydCBwYXRjaCBrZXJuZWwgNS4xMCwg
YnV0IGl0IGRvZXNuJ3Qgc3VwcG9ydCBsaW51eCAKPiBuZXdlciBrZXJuZWwsIHNvIEkgZmluZCB0
aGUgc3Bhbi1sYXRlbmN5LXRyYWNrZXIgcHJvamVjdCBsYXRlci4gQnV0IHdoZW4gCj4gSSB1c2Ug
bHR0bmcgY3JlYXRlIHNlc3Npb27vvIxJIGdldCB0aGUgZXJyb3IgOgo+IEVycm9yOiBFdmVudCB3
YWtldXBfbGF0ZW5jeTogS2VybmVsIHRyYWNlciBub3QgYXZhaWxhYmxlIChjaGFubmVsIAo+IGNo
YW5uZWwwLCBzZXNzaW9uIGF1dG8tMjAyMzEwMjQtMTM0MjQyKQo+IEVycm9yOiBFdmVudCBibG9j
a19sYXRlbmN5OiBLZXJuZWwgdHJhY2VyIG5vdCBhdmFpbGFibGUgKGNoYW5uZWwgCj4gY2hhbm5l
bDAsIHNlc3Npb24gYXV0by0yMDIzMTAyNC0xMzQyNDIpCj4gCj4g5paH5pysIOaPj+i/sOW3suiH
quWKqOeUn+aIkAo+IAo+IEFuZCBJIGZpbmQgdGhpcyB0aXA6ICJUbyB1c2UgdGhlIHRyYWNlcG9p
bnRzIHByb3ZpZGVkIGJ5IHRoaXMgbW9kdWxlIAo+IHdpdGggTFRUbmcsIHlvdSBmaXJzdCBoYXZl
IHRvIGNvbm5lY3QgTFRUbmcgcHJvYmVzIHRvIHRoZW0uIEEgcGF0Y2ggCj4gcmVhZHkgdG8gYmUg
YXBwbGllZCB0byB0aGUgbGFzdCBsdHRuZy1tb2R1bGVzIGlzIHByb3ZpZGVkIGluIGV4dHJhcy8g
Cj4gPGh0dHBzOi8vZ2l0aHViLmNvbS9hZGVsLWJlbGtoaXJpL3NwYW4tbGF0ZW5jeS10cmFja2Vy
L2Jsb2IvbWFzdGVyL2V4dHJhcz4uIFdoZW4gaW5zdGFsbGVkLCBjb21waWxlZCwgbG9hZCB0aGUg
bmV3IHByb2JlIG1vZHVsZSB3aXRoIG1vZHByb2JlIGx0dG5nLXByb2JlLWxhdGVuY3lfdHJhY2tl
ciIsIGJ1dCBJIGNhbid0IGZpbmQgdGhlICJsdHRuZy1wcm9iZS1sYXRlbmN5X3RyYWNrZXIiIG1v
ZHVsZSBpbiB0aGUgbHR0bmctbW9kdWxlIGNvbXBpbGVkIG1vZHVsZXMgb3IgaW4gdGhlIHNwYW4t
bGF0ZW5jeS10cmFja2VyIGNvbXBpbGVkIG1vZHVsZXMuCgpUaGlzIGFwcGVhcnMgdG8gYmUgYSBm
b3JrIG9mIHRoZSBsYXRlbmN5X3RyYWNrZXIgcHJvamVjdC4gV2UncmUgbm90IGluIGEgCnBvc2l0
aW9uIHRvIG9mZmVyIHN1cHBvcnQgZm9yIGFueSBjaGFuZ2VzIHRoYXQgaGF2ZSBiZWVuIG1hZGUg
dGhlcmUuCgo+IAo+IEkgYWxzbyBjcmVhdGUgdGhlIGlzc3VlIG9uIHRoZSBnaXRodWI6IAo+IGh0
dHBzOi8vZ2l0aHViLmNvbS9hZGVsLWJlbGtoaXJpL3NwYW4tbGF0ZW5jeS10cmFja2VyL2lzc3Vl
cy8xIAo+IDxodHRwczovL2dpdGh1Yi5jb20vYWRlbC1iZWxraGlyaS9zcGFuLWxhdGVuY3ktdHJh
Y2tlci9pc3N1ZXMvMT4uCj4gQW55IGhlbHAgd2lsbCBiZSBhcHByZWNpYXRlZCEgVGhhbmtzIQo+
IAo+IOWFjei0o+WjsOaYju+8muacrOmCruS7tuaJgOWMheWQq+S/oeaBr+WPkee7meaMh+WumuS4
quS6uuaIluacuuaehO+8jOmCruS7tuWPr+iDveWMheWQq+S/neWvhuaIluS4k+WxnuS/oSAKPiDm
ga/jgILmnKrnu4/mjqXmlLbogIXorrjlj6/vvIzkuI3lvpfpmIXor7vjgIHovazlj5HmiJbkvKDm
kq3pgq7ku7blhoXlrrnvvIzmiJbmoLnmja7pgq7ku7blhoXlrrnph4flj5bku7vkvZUgCj4g55u4
5YWz6KGM5Yqo44CC5aaC5p6c6ZSZ6K+v5Zyw5pS25Yiw5LqG5q2k6YKu5Lu277yM6K+35LiO5pS2
5Lu25Lq66IGU57O75bm26Ieq6KGM5Yig6Zmk6YKu5Lu25YaF5a6544CCIAo+IERpc2NsYWltZXLv
vJpUaGUgaW5mb3JtYXRpb24gdHJhbnNtaXR0ZWQgaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBl
cnNvbiAKPiBvciBlbnRpdHkgdG8gd2hpY2ggaXQgaXMgYWRkcmVzc2VkIGFuZCBtYXkgY29udGFp
biBjb25maWRlbnRpYWwgYW5kL29yIAo+IHByaXZpbGVnZWQgbWF0ZXJpYWwuIEFueSByZXZpZXcs
IHJldHJhbnNtaXNzaW9uLCBkaXNzZW1pbmF0aW9uIG9yIG90aGVyIAo+IHVzZSBvZiwgb3IgdGFr
aW5nIG9mIGFueSBhY3Rpb24gaW4gcmVsaWFuY2UgdXBvbiwgdGhpcyBpbmZvcm1hdGlvbiBieSAK
PiBwZXJzb25zIG9yIGVudGl0aWVzIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lwaWVudCBp
cyBwcm9oaWJpdGVkLiBJZiAKPiB5b3UgcmVjZWl2ZWQgdGhpcyBpbiBlcnJvciAsIHBsZWFzZSBj
b250YWN0IHRoZSBzZW5kZXIgYW5kIGRlbGV0ZSB0aGUgCj4gbWF0ZXJpYWwgZnJvbSBhbnkgY29t
cHV0ZXIuCj4gCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+
IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1k
ZXYKCnRoYW5rcywKa2llbmFuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5n
LWRldgo=
