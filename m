Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A24CD1284
	for <lttng-dev@archiver.kernel.org>; Tue,  2 Apr 2024 14:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1712067080;
	bh=3d15EvSgW8hUQZILA0/HQwn1u6CyXcC4TKpvtjplkUc=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=0vdR/VT0Z0N1f/aZ2DQrcwuLYrBU2tqUnG1t1gcZ+a6M3GfBCa5ijxWmMoaQJIsgv
	 +GHOflq2Fp6+k7ta6uUbP2x5d7oPHIgYz3SQ7Vf1wMzAibdYg55lnD5JQglF1VDuhl
	 tw8ibmA1IYp0K1uj0qdDniBx7H8EyjG4JKpK8MsGMIHiXNRk8F9hf0D84Fm4ROBcVe
	 g3bAdKhKqh0DsQt/PsRcP4WW3YaYwE6PxEmIY9+J9PENOawmmR5dzVyQGfh3bIrtoK
	 FCVdGix1oLhYJM2V/kqT/Sl7L8/dDLY8uhQBA5Lqa2VBfO0/6XUDlH/2IyhSml3hjO
	 8eCNKiNjjBR7w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4V88tw1N6Sz2ZcV;
	Tue,  2 Apr 2024 10:11:20 -0400 (EDT)
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazon11020002.outbound.protection.outlook.com [52.101.191.2])
 by lists.lttng.org (Postfix) with ESMTPS id 4V88tt0HG2z2ZZX
 for <lttng-dev@lists.lttng.org>; Tue,  2 Apr 2024 10:11:17 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HW3T30io4Q/HbCHZM6IiCU0vUl4d72vifRmmV8ALb9VfIVJm1zbK0TgcN0qp+38pJPKa9QSkaz7QV+ulV82H0MqLQqVwvOYWr7k4YDEWJiqOqSpXU3wSDV5SUHSbucaZE9q7P4pPTNvMsoZPaKes0QZVnQVrzNH/T/JRBRBVygbzKELs142AaORUL+3YZ5eyg5p1mUuHl2Py8w6ItLO6/O5ldbpbG7nZNiNCunLqlfyGa6RKLksK1sTTaq+vl3xJ76oaGqzp4iTcUV3Qr4T/+nNqzd9DbQvsH7jthruqi2UpKAquSUgVBzTgQ8zUtR1TpZdm3obtVEt1Zy91Qyz1rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/N/7Rv4WQIc8pSZxhelVf6RgWf9b6LkpgIGMd+Bs10=;
 b=MBHr/bKTeJNjPaD68ZBkeil3+6ntrPpm2CLaeuZd5P6S+GVK67fARInoRVSiKe9hgoCSaccK6w2TD7oK/j/tOH83PQc7gfn1dLEw4E5ZfLj/VYBLqqlGHyT9nj44JKOYuNsAEu4q3uArWB7aq7o0vFNnauUCfCBcO8FoEEQuXEnMPgWQSj5eY1Z5ykj59qoYe0kL3Cu0k3HAyrf3zyEwmOMiUxfhe8DQr96XfgFcX8sk2kUGCU+ColauJfODlirQ1Xfw6eDwxKJIyIuFMpW+6snnY4CUlBxmtCAKNoMeA+Wf5qQG1/UxUirYh0qcp5qi10H0HdsBgBCAmyJt4nCvwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT1PR01MB2730.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:3::10)
 by YT2PR01MB10761.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 2 Apr
 2024 14:11:15 +0000
Received: from YT1PR01MB2730.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ad7c:6193:524e:38c3]) by YT1PR01MB2730.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ad7c:6193:524e:38c3%7]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 14:11:15 +0000
Message-ID: <5d588684-17f3-4b96-aafd-9ff6728b2ddd@efficios.com>
Date: Tue, 2 Apr 2024 10:11:13 -0400
User-Agent: Mozilla Thunderbird
To: Zvi Vered <veredz72@gmail.com>, Christopher Harvey <chris@cwharvey.ca>
Cc: lttng-dev@lists.lttng.org
References: <CABRndgz2BHX9LubVXoaJxLH+KoYfgzQ0XzY=xHG60+HoO-Tm7A@mail.gmail.com>
 <a128a334-b2d8-4cec-ae40-91e1384a228d@app.fastmail.com>
 <CABRndgy8RJ-rkszYGpvnqJ6oth35ajJhWgF8T4aWFEFjZiBz0g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABRndgy8RJ-rkszYGpvnqJ6oth35ajJhWgF8T4aWFEFjZiBz0g@mail.gmail.com>
X-ClientProxiedBy: YQBPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::33) To YT1PR01MB2730.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:3::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT1PR01MB2730:EE_|YT2PR01MB10761:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 976/QAqr9+8rdaeEPIc5YQmq6vsT+q5j8A7RX1vbruWOEsCCgkPFeR9bLTNjk98i9U/+Zal4kZnf4QWDaNCDd8Iph44kFdgv1zq2vCYkJr4uVtUB1B1Ff20T4YfLK9LLDfY4tHAxy/wSqkrt2FfOKwP3FbfnX+8m2k6OBjtTSQHy9zny1B60OVKYWoXul79MecXizq3cFHq6EFrX5L+GAjEbZTLi9TN/tFcanzWgBjCqe98G8WdY4HDcx+uUJL3OuTizljrh7fcBjiWbkq9+SX9QqTnyoYwThesue0dztOtGqcLvjQCGU63Xi5lV3I55e6IjhDgp4X5PqPbyTfgqZrB+ZNlCMaQ2b63v2kJA9cFXxSz9vEr5njBdrK1ceSfrh0lxLXf+Pwrh0cjhdG+gDUhM4wSb2bVUFEtiblKzzY6X4vxx1be3PP70JPd3pTQLL4TU/YZObn5M1Z0qJqYPJVBsfUtFQSDJXiA5vws5BpKBa1vlUKOHlwoAUW5AqwVTOA7Mu2+PZFIsm1nexjaaU4nwPPmxWiCfB7JmxIUVaSne8Ojm6lQS31tbFbLrJyUeQnGHaeJfX5n3tXlmml2Rl3vpLMQHxBKuJ3V6F9N3xbQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT1PR01MB2730.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWdQR0RSZjZ3TTRVZGRWRjVTaTQvSFpLbmNLNmRQeUFBbWhwQkRJL0t6YVpB?=
 =?utf-8?B?czNGNjJzU2RUckFPbTExTTBVK1RudEhzaGFscThoanpQZ0M0bU8xWS83TFhD?=
 =?utf-8?B?ajBna2VjT3g5UklGclRjTE9adUpLREltakdpL2ZwRXNVcFlYTXVZMkhKRmpU?=
 =?utf-8?B?UEM5SUNXRllGTGFsU1c2R0lyQzV4M2ZUUzkyMVg5QjdqakthRHkvbk9aN1Yv?=
 =?utf-8?B?N3BIamg0WHA3cm5JcTE5eDF4RmFmSzlGYVIzdzBkbms4Q0lTd283N1BpWnEr?=
 =?utf-8?B?V3J4NVZ0c1RQYnEyOEl1cFRpV1RuRWVUYUlGY0pNenRWc1FZV0hnclVmVXZW?=
 =?utf-8?B?c0FMakIrY09SL2xzY3A1OVluTWlCTjhqZVAvMTVEVnRLSlo2Wi81YUN2Ullw?=
 =?utf-8?B?b3Y1QzlZNXJqMWUwU3lxaXgrN0xMT0o2L2xQRk5sUW10L1JWb2cxcWJuYU44?=
 =?utf-8?B?amtYUnp6c0FNSUdHYkQvWG02MmhHSEx0eDdSTldYbXhJdk9BcTJGaDNyME04?=
 =?utf-8?B?ZGcxMWFRK0NDK3ZPZXlGOWc4cThwa3lqZ1pEajBXT2ZJMVQ3cWZwQng1Y2hh?=
 =?utf-8?B?eFc2dFZvNm4raDdhaytKS1lyT0Q1emtGeklraGtQbG00dU8rbWlnaVlBaGNY?=
 =?utf-8?B?RHhyRW4rdUJXdW1OYTZVVTQzSFkrT2FZbXBnaWhMb0JiS3FucjBVeEgvdWwr?=
 =?utf-8?B?a1VEbUc1Q0RORTVZcmQ4c2lSb1Nxd3o4NTQzRVJtY3JDZXFwYjJNRjdJK0Ji?=
 =?utf-8?B?dGZaNE41UHNQWjE5cDRqVWZCeUdEMEZiOGQ0MDRDS0UxcHlFREJVa1J3SHZs?=
 =?utf-8?B?K2Qrdm9tbVJ1VW40K29XcHNseE80V0JHVEgvMWl5VWlmWGVrSXFmaW0yTTYr?=
 =?utf-8?B?QTVtTWpzeEd1bDVrVlBXUER6VlZSUDI5b2ZkRm96dmNOdEUxeXkvdjBrcXhC?=
 =?utf-8?B?OUNXWjlFTE5taVlkM2sraHRPNy9yMHNmSkhNWTBwb3hjTHYwcHQ4MEtaaGVu?=
 =?utf-8?B?V2ZkbUk5dGptbjNKa2NGalgzU1dOOFBUK1JEb2tiRkQwN3U2bi92bXlGeHFJ?=
 =?utf-8?B?cG5OQUo2VUFOVEw1cGNBSmRvQ2tUQ2VCWUFwMU8vaEF0Z3F0MStrTWs5Tits?=
 =?utf-8?B?clpTZVdaZzVGM0YzU21aZ3phejRyOFRGWitKUWVERElUWndjOFNCbVBRb1NS?=
 =?utf-8?B?VFJwZ0dhQ212R29HWTIzTkJwN3lqSGo4SytTaDhydmxCaTlsUU1RZzk4OVZS?=
 =?utf-8?B?WWRLWHZKdElCcDg3c0lTVDY2eU9Md1R1Sll0cWtaN0JLUlN5cFZseFQ2TXho?=
 =?utf-8?B?T2t4MDZwcTdXVzNvTDdiSFBJMXZNMVdETjdraEJ1eUN3UTgrajlqc0RhU2lQ?=
 =?utf-8?B?R2JQZElxSjNCMnY2TmxyQWt1ZzhOM21SVktZckN5YUlYT1BXcmVNeENvNXBD?=
 =?utf-8?B?OTJSNmlYckJwaytLWXNvekozVzM3RXc2WFJ5WHBIQXdYQWRySFY3UEtDZGVi?=
 =?utf-8?B?a3cwNjlGV2hkZmFEcS9PU1ZuTU5lQ1Jtd2xhaGc4dERjd0p4TVpDOGJRVU9U?=
 =?utf-8?B?R080Z2JpcGpjczVSUVRXcWExTG1JUUV1bnhIY1o4KzBsazJ1L2x2QlBrWEhJ?=
 =?utf-8?B?MWxheWtwRXFUUHFLNDdBL3hSTmk4RXhkbUhwbm9HWlpWSTByQysyNERxUko4?=
 =?utf-8?B?czlPN2djbXphS3gvakk1dWpEaDFCelAwTmZtekY5V3ZSOWdPdko5OFhxZkZB?=
 =?utf-8?B?YUFJVEFlWDh5V3YwS0J2QW5YMVhxVmcwTmNGYnhtNHFoVjB2ZXEwbjJYQXQv?=
 =?utf-8?B?M3VEc2lJVFVoaGJPWVRVa3pEM2dUdkQxVzU4NmxHdS84dnN1NjJPcWs4UkNw?=
 =?utf-8?B?U2hrOVIwVFZVM1hWem5qZEZqNFJiS2dXMlFweUVOVVlsV3puWVEySmtIS3li?=
 =?utf-8?B?elFRZmkzcGJrTE9JdC80WHM4NEtpUksvbEJ1QVY5Z3pZT3JFcFRRZUZUczdN?=
 =?utf-8?B?ckR4MHRWbzVoWGVCa1QydVo1ZGhDanBTVndGWml5czROdFJ6QnJyaFVuRS9J?=
 =?utf-8?B?bTcrN3Rlc013UW9iWk1sK1hEa3NjNnBqNS84VXJyWXQ1UzQwdG1iZmk3bHlx?=
 =?utf-8?Q?G5amG6sE9h2aMFOgCJuU8aZj/?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a9a017-5c38-40b9-a10a-08dc531ec243
X-MS-Exchange-CrossTenant-AuthSource: YT1PR01MB2730.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 14:11:15.4302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iABv1Fm21Gr+VSYKJs9UjA1EnOwlDMzyMmJdyrVNXoIxuicN6cwuG8NVcSDyeIKVa4CqNkBiIALYaw8EL1/pgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10761
Subject: Re: [lttng-dev] Lttng: display active threads in multiple cores.
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
From: Erica Bugden via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Erica Bugden <ebugden@efficios.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGVsbG8gWnZpa2EsCgpPbiAyMDI0LTAzLTI5IDAxOjA5LCBadmkgVmVyZWQgdmlhIGx0dG5nLWRl
diB3cm90ZToKPiBIaSBDaHJpc3RvcGhlciwKPiAKPiBUaGFuayB5b3UgdmVyeSBtdWNoIGZvciB5
b3VyIHJlcGx5Lgo+IENhbiB5b3UgcGxlYXNlIGV4cGxhaW4gd2hhdCBkbyB5b3UgbWVhbiBieSBm
dHJhY2UtZW5hYmxlZCBrZXJuZWwgPwoKSSBiZWxpZXZlIHdoYXQgQ2hyaXN0b3BoZXIgbWVhbnMg
YnkgImZ0cmFjZS1lbmFibGVkIiBrZXJuZWwgaXMgdGhhdCB0aGUgCkxpbnV4IGtlcm5lbCBoYXMg
YmVlbiBjb25maWd1cmVkIHRvIGluY2x1ZGUgZnRyYWNlLiBCb3RoIHRoZSBmdHJhY2UgCnRyYWNl
ciBhbmQgdGhlIExUVG5nIHRyYWNlciB1c2UgdGhlIHNhbWUga2VybmVsIHRyYWNlcG9pbnRzIHRv
IGV4dHJhY3QgCmV4ZWN1dGlvbiBpbmZvcm1hdGlvbiBhbmQgdGhlc2UgdHJhY2Vwb2ludHMgYXJl
IGluY2x1ZGVkIGluIHRoZSBrZXJuZWwgCmlmIGZ0cmFjZSBpcyBpbmNsdWRlZC4KCk1vc3QgTGlu
dXggZGlzdHJpYnV0aW9ucyB3aWxsIGluY2x1ZGUgZnRyYWNlIGJ5IGRlZmF1bHQuIEhvd2V2ZXIs
IHlvdSAKY2FuIGNoZWNrIHdoZXRoZXIgdGhpcyBpcyB0aGUgY2FzZSBieSBzZWFyY2hpbmcgZm9y
IGB0cmFjZWZzYCBpbiAKYC9wcm9jL2ZpbGVzeXN0ZW1zYCAoYXNzdW1pbmcgaXQncyBhbHJlYWR5
IG1vdW50ZWQpIG9yIGJ5IHRyeWluZyB0byAKbW91bnQgYHRyYWNlZnNgLiBgdHJhY2Vmc2AgaXMg
dGhlIGZpbGVzeXN0ZW0gZnRyYWNlIHVzZXMgdG8gY29tbXVuaWNhdGUgCndpdGggdXNlcnMuCgpN
b3JlIGRldGFpbHMgYWJvdXQgaG93IHRvIGNoZWNrIGlmIGZ0cmFjZSBpcyBlbmFibGVkIGFuZCBo
b3cgdG8gZW5hYmxlIAppdCBpZiBub3Q6IApodHRwczovL3dpa2kubGludXhmb3VuZGF0aW9uLm9y
Zy9yZWFsdGltZS9kb2N1bWVudGF0aW9uL2hvd3RvL3Rvb2xzL2Z0cmFjZQoKVGhlICJNb3JlIElu
Zm9ybWF0aW9uIiBzZWN0aW9uIHBvaW50cyB0byB0aGUgcHJpbWFyeSBzb3VyY2VzIChMaW51eCAK
a2VybmVsIGRvY3VtZW50YXRpb24pLCBidXQgSSBmaW5kIHRoaXMgcGFnZSB0byBiZSBhIGdvb2Qg
c3RhcnRpbmcgcG9pbnQuCgpCZXN0LApFcmljYQoKPiAKPiBCZXN0wqByZWdhcmRzLAo+IFp2aWth
Cj4gCj4gT24gV2VkLCBNYXIgMjcsIDIwMjQgYXQgNzozMuKAr1BNIENocmlzdG9waGVyIEhhcnZl
eSB2aWEgbHR0bmctZGV2IAo+IDxsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnIDxtYWlsdG86bHR0
bmctZGV2QGxpc3RzLmx0dG5nLm9yZz4+IHdyb3RlOgo+IAo+ICAgICB5b3UgY2FuIHVzZSBhbiBm
dHJhY2UtZW5hYmxlZCBrZXJuZWwgd2l0aCBsdHRuZyAobWF5YmUgZXZlbiBqdXN0Cj4gICAgIHRy
YWNlY29tcGFzcykgb3IgcGVyZmV0dG8gdG8gZ2V0IHRoYXQga2luZCBvZiB0cmFjZQo+IAo+ICAg
ICBodHRwczovL2FyY2hpdmUuZWNsaXBzZS5vcmcvdHJhY2Vjb21wYXNzLmluY3ViYXRvci9kb2Mv
b3JnLmVjbGlwc2UudHJhY2Vjb21wYXNzLmluY3ViYXRvci5mdHJhY2UuZG9jLnVzZXIvVXNlci1H
dWlkZS5odG1sIDxodHRwczovL2FyY2hpdmUuZWNsaXBzZS5vcmcvdHJhY2Vjb21wYXNzLmluY3Vi
YXRvci9kb2Mvb3JnLmVjbGlwc2UudHJhY2Vjb21wYXNzLmluY3ViYXRvci5mdHJhY2UuZG9jLnVz
ZXIvVXNlci1HdWlkZS5odG1sPgo+IAo+ICAgICBvcgo+IAo+ICAgICBodHRwczovL3VpLnBlcmZl
dHRvLmRldi8gPGh0dHBzOi8vdWkucGVyZmV0dG8uZGV2Lz4KPiAKPiAgICAgT24gV2VkLCBNYXIg
MjcsIDIwMjQsIGF0IDU6MjYgQU0sIFp2aSBWZXJlZCB2aWEgbHR0bmctZGV2IHdyb3RlOgo+ICAg
ICAgPiBIZWxsbywKPiAgICAgID4KPiAgICAgID4gSSBoYXZlIGFuIGFwcGxpY2F0aW9uIHdpdGgg
NCB0aHJlYWRzLgo+ICAgICAgPiBJJ20gcmVxdWlyZWQgdG8gZGlzcGxheSBvbiB0aGUgZ3JhcGgg
d2hlbiB0aHJlYWQgc3RhcnRzIHdvcmtpbmcKPiAgICAgdGlsbCBpdAo+ICAgICAgPiBibG9ja3Mg
Zm9yIHRoZSBuZXh0IHNlbWFwaG9yZS4KPiAgICAgID4KPiAgICAgID4gQnV0IHdpdGhvdXQgdXNp
bmcgdGhlIGx0dG5nIHVzZXJzcGFjZSBsaWJyYXJ5Lgo+ICAgICAgPgo+ICAgICAgPiBJcyBpdCBw
b3NzaWJsZSA/Cj4gICAgICA+Cj4gICAgICA+IFRoYW5rIHlvdSwKPiAgICAgID4gWnZpa2EKPiAg
ICAgID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiAg
ICAgID4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+ICAgICAgPiBsdHRuZy1kZXZAbGlzdHMubHR0
bmcub3JnIDxtYWlsdG86bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZz4KPiAgICAgID4gaHR0cHM6
Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo+ICAg
ICA8aHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5n
LWRldj4KPiAgICAgX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KPiAgICAgbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+ICAgICBsdHRuZy1kZXZAbGlzdHMubHR0
bmcub3JnIDxtYWlsdG86bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZz4KPiAgICAgaHR0cHM6Ly9s
aXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo+ICAgICA8
aHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRl
dj4KPiAKPiAKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4g
aHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRl
dgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1k
ZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5s
dHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
