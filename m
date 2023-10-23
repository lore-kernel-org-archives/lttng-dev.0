Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFD1C25B45
	for <lttng-dev@archiver.kernel.org>; Mon, 23 Oct 2023 19:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1698089294;
	bh=KUDZCTu5/gwaEOYtouZZqK4jYdTi/sjJft6Pvk/rqr4=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=pIevbw20uyEACRL4XDbdz03Tn0DtTyjl/+uMGfMPBKi9XShIHnKMgIjC6g6vNBaeA
	 mswFvpNlkiYOkiWZatIdfdlXCRTYzTa0XMJh0K5P5kOXiE+dAqbHOqEbMbI/W7dLCs
	 LcmK/VNXFx1ZCHIq1Ubf++Wmu2qmLzKU1Ptla9Ms7lZJ9lBbXQXqGwSZsiCG7BpRGa
	 yV0oXVCti0/9C2K4Pr9hoRCA7EgQKV30O8MTq8R5ringqrc9LANdyrL0/th0A2lfDl
	 fpWfBhVR/8Cul6mgbGRJ+FquL+3h+Lns33hPjcDX386uVQvLCANMR/PIQe5wAJ2uCH
	 YF9NF+5TJWWYQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4SDlbK5fWcz7jb;
	Mon, 23 Oct 2023 15:28:13 -0400 (EDT)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2040.outbound.protection.outlook.com [40.107.115.40])
 by lists.lttng.org (Postfix) with ESMTPS id 4SDlbJ3G5jz546
 for <lttng-dev@lists.lttng.org>; Mon, 23 Oct 2023 15:28:12 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IF6IGpILJlupiGvQUpC1GvdmdvbPDNdFrcYBb1MfvFIljt8Apoy5beCQ4If6fU5jTRmTuqz3NrppV4rgkVaoy95s08VyPxUPh34x5MqdVHcKiLh1UXxUfTg0IzS9xvf/EiZIKVxMChSH9eUQFjkpT70Y7IqEwdeVG9aScg6dG9S9OEGsfPLvE1Yj5zVW4vAO3cp1bDB16Udg5e3GFVz6hPJuRAOkI+26275rDTGG2iwCdegBtwg6LEn0DXrKsCrUBX1qLWhU8YuirjSchD2RiZ5ZQr6UG2cdzH0wqRVMXPISfR4mNibpB0v80b+prp2ApA/Fly3kLVJqOi4nJFRGhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ht8is3r0UmRH98gWCyAmAQOqW1gJtJzv4+EYP5ZWodo=;
 b=B8lRADwq3hlPJRGYYd62xdHtxDh1w9kfjS5xbbbKIbR5XrG1lbAaTpntl3yyPZwIHBcISYza9AAwZDpOj57UPgwWHH4If42Lfthx/RhprP0LoFJwUaYlvz9jWsbLssiETjbI9O2ZSv8Fq4XSoLFCDn4ho7s4arqFwkIETizlIYrJy0UkdvUhUVbo+P+qfKxj17GI/YaB8c5NR9QbPGjPnmaj4LyblJcD4P3yhHSqIJc0Uh7ghRETIOeg7xnvOzJ3UEYmksxTLe8ZhjBxSnPtB5c5jPDhEYapOs8/Ypxk87JLvvnRNJ6kM4Z7tVjjsnIYlofw73+ABFKtSAzRZhGVJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:de::19)
 by YQXPR01MB5518.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 19:28:06 +0000
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::da47:621a:32df:13c2]) by YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::da47:621a:32df:13c2%3]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 19:28:06 +0000
Message-ID: <2eaa5b1f-c3b2-4790-bf45-dadb66f45d48@efficios.com>
Date: Mon, 23 Oct 2023 15:28:04 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US, fr-CA, en-CA
To: Lin ArcX <linarcx@gmail.com>, lttng-dev@lists.lttng.org
References: <CALBKf8Jv-QRwbZ0ATdPzj1KyzDQT6SqG9G_4-5-QfG35iJyetQ@mail.gmail.com>
In-Reply-To: <CALBKf8Jv-QRwbZ0ATdPzj1KyzDQT6SqG9G_4-5-QfG35iJyetQ@mail.gmail.com>
X-ClientProxiedBy: YQBP288CA0004.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::17) To YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:de::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9793:EE_|YQXPR01MB5518:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e77c80-840d-488c-7f25-08dbd3fe2ea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LrEo33BSakjTZE958XRQlfUmlhVqc8y3aqPLG1wkq4+PUAG3oJSHfHK58vk5+J8Il1savihiCGhtPqkL2YlwiLeL/ucQNCVxFWuUe9yJE4idBEOLvvX84I81DuFGzuWs/jsPURTCh2zLt6reLoaBK8WwCt46hJfyiJYgoRHTBWPI2j2AE8umuGw9jYpMecjaloDarcOJ78zeVbZ/09hovX+QIrba2FYmF4VFHxzFZmTYBHGdNqcrLT+5WZtQk3FQIhQC55h3AzgG3Dk5U2UDldtwvmz8lvCGMQ2S/uzAnzQcm1c4q6/B3eDcuXL1Jdyulw4Ws1WJ6T5U4iXq2yakgrJIvCfEU6yX4VBhmb6kp21kMGXN1nBz49H6VXmf/ANlZ+Yt85iA75VoohAOqxFjMZ0CX9y+zj8HtY/EwI3p0l16RwTXOhSvk9+xkDTHm7koW8zaizyvtWLELwZiuktvLa2vj9LJmttjJK/HbEBzfSpT2yI/hOFnDovjcNboy22U7zUBZXT/FX0hBD24mqjgoqGZ4AIom5oR2sXGLNfj+oawQ3AOnWgJ/gy5sXXch37XQ+lwmAGvPGiNU0Rk3CugyVDn1rh2UaPXZaD156iguH425IkS3hA4+LUtdhnrODL9tBN1lQc5f6bdJSGmfIzLiIe7pCM9YlA8edhKsttZlcA9rqHoTcKfqsnsJI9WoZWX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(39830400003)(396003)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(38100700002)(66476007)(31696002)(66946007)(66556008)(86362001)(26005)(478600001)(6506007)(6486002)(6512007)(2616005)(83380400001)(41300700001)(36756003)(316002)(5660300002)(966005)(2906002)(8936002)(8676002)(31686004)(66899024)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STNiNHY3RUpFYlJxMzVhY0RVdnc3ZTBjNE1zUXpjYTd5N3NpdjNLVmFCWkla?=
 =?utf-8?B?S2h1TS9kUW5PMExaeHhrUG9JdStabEx4VXNVMTByUlFxRjZUNFlNWnJyaWFW?=
 =?utf-8?B?SU9CRFhqYmpncUtObWkvZTlQZDlIWDcvZnFHNUZpbzUzUFc5MVJFRTRyV0dG?=
 =?utf-8?B?MGdQaUJCaDlaZWhyYXhqRzV0UlNPWStMNFdHY0wvcmM0RElWNTBDTzFFWTE1?=
 =?utf-8?B?NEZhaTcwTTJ3d3RGeDlFVjkzb1IwdUZ6Y2hQT3FwRCtKL3RRS0xvN1lQbURI?=
 =?utf-8?B?NWw4bHhyZWs2aGFqV0VFa3l5d3hXUmdsNjdaMWlTLzFnS05PeklwUWxRU01N?=
 =?utf-8?B?OWRqaVh2RGIrTGkxVDZ2SVlhaS9RdDU2Z1N4TDVEeXYxbmNmeXJUYlFTOCty?=
 =?utf-8?B?RkI0cWt6NGxFS3pxS05JdmpaanpkOWlkUjVPZjd4RUJ2UkRyTXNNUEdxR1VH?=
 =?utf-8?B?N1UzVGhlTmV5cjBRMWRBdEZyVTkzWDJRN1BmeEZoRkFuakRSWGpmQXVVSStZ?=
 =?utf-8?B?Z205b0NtRXBHc0lrdVdxdmhoYmxKSDRCRGFNSTNPbUI4dUZlNUQyeFNUTEVO?=
 =?utf-8?B?S0x6ZVlaZTFKeHVmcHhXTm83UHdXYVBrcmtTQk9IdnV2Q1ZiM1RIejV6YmRv?=
 =?utf-8?B?TVhmTXZIZEp1TC9iTzh6WjRPREdPTWFYeGpSaTVvT29maVE2QVpqL2N1cGRu?=
 =?utf-8?B?NXNTcDBkc2MwYi96WXFGdTRPQkxpeHV4RkMvTDhJRHlMaCt3WG42ZDEwQUZL?=
 =?utf-8?B?S2NWS1liSThPNFhZYnoxY3krNUtQQ2pwdGxLb2k1SEh6VVNMQXU3ZFJkYUY2?=
 =?utf-8?B?U3djdWZQd015UUtDRmJCaU5QMWwya3pQUlFVY3FUUmEvQU5LODQxNFJaRWxW?=
 =?utf-8?B?UXJzYncyZzcvMVRwR1M2eEJhdFVHTDFxcmlRMUpnUUc3eUpFbk1CY3VXZkJM?=
 =?utf-8?B?T1l6bGVlVldKcysxU3RyM1VKTlJKR1Z2OXhMNEE3bloybnFhNXo2SHVXeHYz?=
 =?utf-8?B?NXd2NHhQWWlTc01HTThXNm1JOFRURW1BYitFRkVvYXM0UHUwOTAvd3lYdzhQ?=
 =?utf-8?B?a2JoV0VJWVZnMHdWcGdLSHByK2s3TVBWaThnVlAvNkFZdEVFZllBcEJyL2xq?=
 =?utf-8?B?SlQ5cGJtenBqbTlmSy85d1lvSG1TcjllYkFiRFFoRlBxeWVCWkJhNXlicGE2?=
 =?utf-8?B?Y25YY2pSZlNTbGF0WENpSVA5R2x2endCNFNyV3JTR2Y4SWI5VG96YTh5Q0xk?=
 =?utf-8?B?T2xsUjFIWWZUT2RFQXpsb1RZRzcrRnh6eU11VkUyWTZDa2ZoeUNSSnBQVmMv?=
 =?utf-8?B?ZlZnR1NOSTJCcENoZThib0NSaXRrendLTlNvWTU4eVZRUDlhTkRJbVlxRU9R?=
 =?utf-8?B?NGhWSGpha1ZmbzhpSlV1SENwR0Yzb1NHdTJQNTZ5UWJLZ3h3R2V1MERFYzNr?=
 =?utf-8?B?dlFaNkhiQkNPNlBMYVRyQnRVYzNvcWYxSmNsME5MYmNJZENEd1VjMFVyNWZn?=
 =?utf-8?B?ZkU5R3lHWHlVL3g4V0x6MCt5WUN6SVpaNGpVTGxWaWd3YzExeVB1QzI3Rk40?=
 =?utf-8?B?aWl6aEVXZ1JianpFMWdCVlo1WGNqaXZtRkhveU1hZEQ4ODVhcmEzWjBpTXlW?=
 =?utf-8?B?RjhZSVpxY05qYVMwNE5teXhjZUh2M1k2d1ZZRHA0azZ4WW1yYkFHMjRJMVRl?=
 =?utf-8?B?SXBydjBxUUtKZjVxNjltL2dsZ2dXSXR4R25sQTF1ZGRRem44QlRCeVBCaVV3?=
 =?utf-8?B?NVN0TmxCcmN4Z2J3N0JHd01xZ0srM1pMMzlxSzR1bkpUSk1teFprVUZ1dFVa?=
 =?utf-8?B?ekJwTkM0VXdjNG9YbDMwaS9FWlpmTFFiZ01QdWRhZWJSRWNVbkovT29pcTc3?=
 =?utf-8?B?dHJxTnIzbVpiVy9CMXZ5THExUWxnNlkxZm1zVWJLWkxBOHh5KzNVSno1VUtH?=
 =?utf-8?B?SDl5a0ZVZkNFTEtqNENwWFRBZitvU1g1WkZycVJ0SCtWOWZ2YXl5dUh4VzNN?=
 =?utf-8?B?YUQ2RGtrbk80QktmdXUyQkw4SXB4SklCQVE5WUcvN2hFbUdzWmNYK1NPTGFy?=
 =?utf-8?B?NmVUenoyYW9MdklVQUlLb2ZkU0orS25qVnR6ckZEbXRUUm1rSndnVFdBVzl1?=
 =?utf-8?B?Umt3MzNNTkN3WVowK3NLNjRFY0kxOXd1K05KUjJ6eC9CWU9ob3B5aTV4ZWFw?=
 =?utf-8?B?TXc9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e77c80-840d-488c-7f25-08dbd3fe2ea3
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 19:28:06.1663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N8yU3BTq8eLV0Ut0c4eZHFzCtVAY4UffUYiZbIxvTz361XpO2oEC1tk+6uAATtqCoN3AhZNsPW5XHKUvYaLzYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5518
Subject: Re: [lttng-dev] Can't receive a lot of functions that i registerd
 as trace-points
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

SGkgTGluLAoKU29tZSBvZiB0aGUgZXZlbnQgcnVsZXMgeW91IGhhdmUgbGlzdGVkIGFyZSBmb3Ig
aXRlbXMgdGhhdCBhcmVuJ3QgCmluc3RydW1lbnRlZC4gT3RoZXJzIGhhdmUgdGhlIHdyb25nIG5h
bWUuCgpJJ3ZlIHB1dCBzb21lIG1vcmUgc3BlY2lmaWMgaW5kaWNhdGlvbnMgYmVsb3cuIFlvdSBj
YW4gY2hlY2sgd2hpY2ggCmV2ZW50cyBhcmUgYXZhaWxhYmxlIGluIHRoZSBrZXJuZWwgZG9tYWlu
IHdpdGgKCmBsdHRuZyBsaXN0IC0ta2VybmVsYAoKQW5kIGZvciBzeXNjYWxsczoKCmBsdHRuZyBs
aXN0IC0ta2VybmVsIC0tc3lzY2FsbGAKClRoZXJlIGlzIGFsc28gZG9jdW1lbnRhdGlvbiBhdmFp
bGFibGUgb24gYWRkaW5nIExUVG5nIHByb2JlcyBmb3IgCmV4aXN0aW5nIGZ0cmFjZSB0cmFjZXBv
aW50cyBhdCAKaHR0cHM6Ly9sdHRuZy5vcmcvZG9jcy92Mi4xMy8jZG9jLWxpbnV4LWFkZC1sdHRu
Zy1sYXllciAoZm9yIDIuMTMpIG9yIApodHRwczovL2x0dG5nLm9yZy9kb2NzL3YyLjEyLyNkb2Mt
bGludXgtYWRkLWx0dG5nLWxheWVyCgoKPiBIZWxsbywKPiAKPiBJIGhhdmUgYSBzaW1wbGUgdWRw
IHNlcnZlci9jbGllbnQgYW5kIEkgd2FudCB0byB0cmFjZSB0aGVzZSBmdW5jdGlvbnM6Cj4gCj4g
IMKgIMKgIEV2ZW50IHJ1bGVzOgo+ICDCoCDCoCDCoCBuZXRpZl9yeF9uaV9lbnRyeSAobG9nbGV2
ZWw6IFRSQUNFX0VNRVJHICgwKSkgKHR5cGU6IHRyYWNlcG9pbnQpIAo+IFtlbmFibGVkXQo+ICDC
oCDCoCDCoCBuZXRpZl9yeF9lbnRyeSAobG9nbGV2ZWw6IFRSQUNFX0VNRVJHICgwKSkgKHR5cGU6
IHRyYWNlcG9pbnQpIAoKSW4gTFRUbmcsIHRoZXNlIGV2ZW50cyBzdGFydCB3aXRoICJuZXRfaWZf
Iiwgbm90ICJuZXRpZl8iCgo+IFtlbmFibGVkXQo+ICDCoCDCoCDCoCBuYXBpX2dyb19yZWNlaXZl
X2VudHJ5IChsb2dsZXZlbDogVFJBQ0VfRU1FUkcgKDApKSAodHlwZTogCj4gdHJhY2Vwb2ludCkg
W2VuYWJsZWRdCgpUcnkgIm5ldF9uYXBpX2dyb19yZWNlaXZlX2VudHJ5IiBpbnN0ZWFkLgoKPiAg
wqAgwqAgwqAgc29mdGlycV9yYWlzZSAobG9nbGV2ZWw6IFRSQUNFX0VNRVJHICgwKSkgKHR5cGU6
IHRyYWNlcG9pbnQpIAo+IFtlbmFibGVkXQo+ICDCoCDCoCDCoCBpcnFfaGFuZGxlcl9lbnRyeSAo
bG9nbGV2ZWw6IFRSQUNFX0VNRVJHICgwKSkgKHR5cGU6IHRyYWNlcG9pbnQpIAo+IFtlbmFibGVk
XQo+ICDCoCDCoCDCoCBuYXBpX3BvbGwgKGxvZ2xldmVsOiBUUkFDRV9FTUVSRyAoMCkpICh0eXBl
OiB0cmFjZXBvaW50KSBbZW5hYmxlZF0KPiAgwqAgwqAgwqAgc29mdGlycV9lbnRyeSAobG9nbGV2
ZWw6IFRSQUNFX0VNRVJHICgwKSkgKHR5cGU6IHRyYWNlcG9pbnQpIAo+IFtlbmFibGVkXQo+ICDC
oCDCoCDCoCBlMTAwMF94bWl0X2ZyYW1lIChsb2dsZXZlbDogVFJBQ0VfRU1FUkcgKDApKSAodHlw
ZTogdHJhY2Vwb2ludCkgCj4gW2VuYWJsZWRdCj4gIMKgIMKgIMKgIG5kb19zdGFydF94bWl0IChs
b2dsZXZlbDogVFJBQ0VfRU1FUkcgKDApKSAodHlwZTogdHJhY2Vwb2ludCkgCj4gW2VuYWJsZWRd
CgpsdHRuZy1tb2R1bGVzIGRvZXNuJ3QgcHJvdmlkZSBhbnkgc3BlY2lmaWMgaW5zdHJ1bWVudGF0
aW9uIGZvciB0aGUgZTEwMDAgCmFuZCBuZG8gZHJpdmVycy4gQXJlIHlvdSB1c2luZyBhZGRpdGlv
bmFsIGtlcm5lbCBtb2R1bGVzIHRoYXQgYWRkIHRoZSAKaW5zdHJ1bWVudGF0aW9uPwoKSWYgeW91
IGFyZSwgcGxlYXNlIGVuc3VyZSB0aGF0IHRoZSBtb2R1bGUgaXMgbG9hZGVkLCBvciBpdCBjYW4g
YmUgYWRkZWQgCnRvIHRoZSBsaXN0IG9mIHByb2JlcyBsb2FkZWQgYnkgdGhlIHNlc3Npb25kIHVz
aW5nIGAtLWV4dHJhLWttb2QtcHJvYmVzYCAKKGMuZi4gCmh0dHBzOi8vbHR0bmcub3JnL21hbi84
L2x0dG5nLXNlc3Npb25kL3YyLjEzLyNkb2Mtb3B0LS1leHRyYS1rbW9kLXByb2JlcykKCklmIG5v
dCwgeW91IHdpbGwgbmVlZCB0byBpbXBsZW1lbnQgdGhlIHByb2JlcyBhcyBtZW50aW9uZWQgZWFy
bGllci4gSWYgCnlvdSBuZWVkIHByb2JlcyB3aXRoaW4gYSBzcGVjaWZpYyB0aW1lbGluZSwgZWl0
aGVyIHBhdGNoZXMgYW5kL29yCmZpbmFuY2lhbCBzdXBwb3J0IGFyZSB3ZWxjb21lIHRvIGNyZWF0
ZSBhbmQgbWFpbnRhaW4gdGhlbS4gSWYgeW91J3JlCmludGVyZXN0ZWQgaW4gZnVuZGluZyB0aGlz
LCBwbGVhc2UgZmVlbCBmcmVlIHRvIHJlYWNoIG91dCB0byBFZmZpY2lPUy4KCj4gIMKgIMKgIMKg
IG5ldF9kZXZfc3RhcnRfeG1pdCAobG9nbGV2ZWw6IFRSQUNFX0VNRVJHICgwKSkgKHR5cGU6IHRy
YWNlcG9pbnQpID4gW2VuYWJsZWRdCgpUaGlzIG1pZ2h0IGJlICJuZXRfZGV2X3htaXQiIGluc3Rl
YWQgb2YgIm5ldF9kZXZfc3RhcnRfeG1pdCIKCj4gIMKgIMKgIMKgIGRldl9xdWV1ZV94bWl0IChs
b2dsZXZlbDogVFJBQ0VfRU1FUkcgKDApKSAodHlwZTogdHJhY2Vwb2ludCkgCj4gW2VuYWJsZWRd
Cj4gIMKgIMKgIMKgIG5ldF9kZXZfcXVldWUgKGxvZ2xldmVsOiBUUkFDRV9FTUVSRyAoMCkpICh0
eXBlOiB0cmFjZXBvaW50KSAKPiBbZW5hYmxlZF0KPiAgwqAgwqAgwqAgbmV0aWZfcmVjZWl2ZV9z
a2JfbGlzdF9lbnRyeSAobG9nbGV2ZWw6IFRSQUNFX0VNRVJHICgwKSkgKHR5cGU6IAo+IHRyYWNl
cG9pbnQpIFtlbmFibGVkXQo+ICDCoCDCoCDCoCBuZXRpZl9yZWNlaXZlX3NrYiAobG9nbGV2ZWw6
IFRSQUNFX0VNRVJHICgwKSkgKHR5cGU6IHRyYWNlcG9pbnQpIAo+IFtlbmFibGVkXQoKVGhlc2Ug
YXJlIGFsc28gcHJlZml4ZWQgd2l0aCAibmV0X2lmXyIgaW5zdGVhZCBvZiAibmV0aWZfIi4KCj4g
IMKgIMKgIMKgIGluZXRfc29ja19zZXRfc3RhdGUgKGxvZ2xldmVsOiBUUkFDRV9FTUVSRyAoMCkp
ICh0eXBlOiAKPiB0cmFjZXBvaW50KSBbZW5hYmxlZF0KCkkgZG9uJ3QgdGhpbmsgdGhpcyBpcyBp
bnN0cnVtZW50ZWQgaW4gbHR0bmctbW9kdWxlcyBhdCB0aGlzIHRpbWUuCgo+IAo+IEkgc3RhcnQg
dHJhY2luZywgYW5kIHdoZW4gaXQgaXMgZmluaXNoZWQsIEkgd2lsbCBvcGVuIG15IHRyYWNlIGRp
cmVjdG9yeSAKPiBpbnRvIFRyYWNlQ29tcGFzcywgQnV0IEkgY2FuIHNlZSBqdXN0IHNvbWUgdHJh
Y2VzIGZyb20gdGhlc2UgZnVuY3Rpb25zOgo+IAo+IC0gaXJxX2hhbmRsZXJfZW50cnkKPiAtIG5h
cGlfcG9sbAo+IC0gbmV0X2Rldl9xdWV1ZQo+IAo+IEknbSB1c2luZ8KgwqAyLjEyLjE0Lgo+IAo+
IERvIHlvdSBoYXZlIGFueSBpZGVhPwo+IAo+IFJlZ2FyZHMsCj4gCgpIb3BlIHRoaXMgaGVscHMu
Cgp0aGFua3MsCmtpZW5hbgoKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwo+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiBsdHRuZy1kZXZAbGlzdHMubHR0
bmcub3JnCj4gaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZv
L2x0dG5nLWRldgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6
Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
