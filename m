Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B53C00A8F
	for <lttng-dev@archiver.kernel.org>; Tue, 24 Oct 2023 19:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1698177591;
	bh=Y8qcIKLWMtrLjvHC2GH29ErcsBHRgGinErmr1E4eBmo=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=pHuS/dFdCBIwhVeg1f6BFI3ahayNyVec8LNGWnidu8/FNPKTsfsBlvGcDH6xhdHBF
	 cKNHjiK4qT+RKjd1KX3faJUpsW9fRAAeEtIidxSa3h6vefVq4IHeJDKWaywhNYFfr3
	 /hph7gFFzglEdmYOg12pNYCYPp+JkaU2GgGwux7e9aIEAZpp93nYUqexOJs26huYcm
	 BNdRKK+56HDMjpSTNhIs1HlE8g8YztgOfsrCyQ4NGse753fBj2TrozIe7NsrDwMx69
	 xGMY2lgtvuW/cd8ghc/+4cTEZ4VbkZSeogm8dEMJsTGFyMTca/YIfaDGdvqb2xAVT8
	 ogzq/v+Ohcd0A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4SFNFL6t2cz8Gy;
	Tue, 24 Oct 2023 15:59:50 -0400 (EDT)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:7052::617])
 by lists.lttng.org (Postfix) with ESMTPS id 4SFNFK2Vnjz8Gw
 for <lttng-dev@lists.lttng.org>; Tue, 24 Oct 2023 15:59:49 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2e7ClJ0Hot1HaDjxLbp7qOfrqs9uhR/URy5+dfStDXqsw+K6TDLOMsFbTyBnt748M27jaDKlGRTqNIleo4TJuSmtohhwcayry+Gnwyat/ZCA6HqVCYTNUrPUa3DvB0/bMctaFPf6+BSkV2SDDgkNZ2wY3rrXLJP2gVr0yvXcrQjpvgw1ofkkpAJhWyDDXTlHLdHpTak0K1fGt6H15OQvo4mLmPQaoHvMvW9tKduzeFaaA160FdQGs8yYlWUmMUdyb+KpPYj8USf6tpWookGD4TDD8XEG15IaBWTFb5Fz0l2GKZ3PvgXuGSmu2lnXMn3OlLgnQtNM+GsFwwfOlqV8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlRDaR7qMsU4anR4lwlA5HPKXOElhp+rMp2sOMbj2Fw=;
 b=JLj4jvlEA7qyiiyzm2fwTDizWpxvUtGgi41tT1g1XEvkBgHHSCjlVqflU4D5yNbGNfYpuo8pmZX2s+FNYYKbkCOnSN3g+jD7A7g1KprJIocn8kEMf9ozLU4VkeWdqmLFZ5InJ8a4VeL5Ab/8nl6vHaIl+S2Vl7qpl1YoCBX016wLL6ho3WFlSXZ+NjC+LK07NNJswdxiPaJAV9oFaDk09cECTyIh57T1j8g4cRWueedvfnqptyxVC5c5C/qialZphkhISYJKqWvmjIvSwgehdTBT7tB/HRFWSCgEoIYduwHO724z6fdY7vAVry1vHzODSZtrHmXDFH5NMeolMyl9Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:de::19)
 by YQBPR01MB10696.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:76::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 19:59:47 +0000
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::da47:621a:32df:13c2]) by YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::da47:621a:32df:13c2%3]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 19:59:47 +0000
Message-ID: <5e8133af-acd3-4083-b061-34e7d6c42938@efficios.com>
Date: Tue, 24 Oct 2023 15:59:45 -0400
User-Agent: Mozilla Thunderbird
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <CALBKf8Jv-QRwbZ0ATdPzj1KyzDQT6SqG9G_4-5-QfG35iJyetQ@mail.gmail.com>
 <2eaa5b1f-c3b2-4790-bf45-dadb66f45d48@efficios.com>
 <CALBKf8JtZKGe5i9S0=zcU_7Qj8b_Z_FkbLv+hqcDf1BbBnZF7w@mail.gmail.com>
Content-Language: en-US, fr-CA, en-CA
In-Reply-To: <CALBKf8JtZKGe5i9S0=zcU_7Qj8b_Z_FkbLv+hqcDf1BbBnZF7w@mail.gmail.com>
X-ClientProxiedBy: YQBP288CA0024.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::28) To YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:de::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9793:EE_|YQBPR01MB10696:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f6ebb1-769f-45de-72b5-08dbd4cbc621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fKmDCSMYMw9zXeCa0CZVtya7Qm3I2D2oTT3KarWeHiLpXjDbAbVncpPWnzELm7DbXug5xII3iK2tKk3vHuUEMrGTMIGOdU6tni2lFV0JrOHa5B2sXu6kfI3Hb7vxZjQzPDLT9sWGOAEBkXCpth8VYands6ZAYp6qrfhb9zWGhkgy4H2j8XgoK2reCqjBDK0DZdf5HVFCaNMMy6rW3GJyOLkSMkgi4PUGyRFpZv/2UW4MZBkKKQkpdmMvckazIAYRlGSCjS6DXSgrheXsx6T9BUyldF+F5uNclFJYBVxZLjFm7JGh6hXQHYyN4cWj3gsZHt4T5u899nroDkAp4qpgUQtMRW39SkHvZ1pP5ucxrSMIx+CfOFSUg1sOG7c8OejKnN79AXVxxOUuaiZGQpqVkMotZgckaH7/F6t75ZoI8LxwxRzqSvVhe3WVs1uXTAMhY8446HzLSNRlFt0i/YSeJbXXxbopJc9jw94JqJh1rfkJTYXJyV0Dfw9ErsFJQ57q3jfF5TW3714ljcF5XVfkEjjoQKtI9pzbuARcdRfS8ELhRBf6MWpiosIlBJ2oS79rq1RkHR9pPJIPTVXocak5GxJvYbh4klEhLDs0yXOSDUdNCK4vTd08F/Pu4SHeDm5sKYCuJlg1u7T9FAhBUB6ASw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39830400003)(396003)(346002)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(31686004)(2616005)(5660300002)(8676002)(2906002)(6512007)(38100700002)(6506007)(53546011)(83380400001)(26005)(8936002)(41300700001)(86362001)(36756003)(31696002)(66476007)(66556008)(4001150100001)(6916009)(66946007)(316002)(6486002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTh0NVlFREhTVmx0N3FnVklzbTh6eitlMXZMc1FqaGliNWVtYUNPWWRnd2RZ?=
 =?utf-8?B?OHZndldibUludExxRGxaMzhhK3phdGl1QkNZejhBZG5MZU5idSt0MEs1UjNZ?=
 =?utf-8?B?TWlqYXN6VXd3dnpwdndIbG9wTlpZdnRFdSt6UnZGYUlCdE9aZ0ZpbGRMQ1Bl?=
 =?utf-8?B?MldHU2FIdStjT2VaNVZTcUgreFBHSENSV0tKT2xldzdmRjc5dnlFMVYyR212?=
 =?utf-8?B?SUtiVEhlOUlJRmhTcDRPYXhIZTYrL290SEdyc2pSOGRUR0tPRUU1Z09vckdR?=
 =?utf-8?B?blUwWHIyT3hadEUxekEwYUowVmtVWHVtK3B4enRIbHVWVVhhSzdTNE52YUNT?=
 =?utf-8?B?TzUxckQxclpKblBISGRKWTNWVFh2YU9mOVNXbHc4R0ZzcEtOL3FRRUNIdFN1?=
 =?utf-8?B?dVo1L2lvTnEvd1VJd2hya2djUkFTNDAwN1FTdlVZRHlIaUdabUgzYXd6a1Fm?=
 =?utf-8?B?WHJGS2g4d3dYb0Q2dXF3USt4dWY2c1Y3QThha2FYenVYcm5oUjJQSTB2eGZL?=
 =?utf-8?B?M012Z25nc2pxLytHbkdpTmxmLzVHZ0xybWt4UWhtclR0TXJ3MkRUU1V5UzBE?=
 =?utf-8?B?azFQWDVoeGdNbkNvckRuZ1VOcko5NVRiWUlWakREbE9oK1NnTVh3ai8zZkQv?=
 =?utf-8?B?MnlwQU5hWGNKam9XOVZrZGRnZ1BRL0RZRzU4SWE1VUtXK0YxVzB4M0o0MHdV?=
 =?utf-8?B?Mi95L0ZmMDFrRHFzMmNUbU9QWXhVZ21jWFgrZmVMM3ZYRUM0ajlOWW5HcXFW?=
 =?utf-8?B?anpKZFZyS2FTaEpBUzV5bjJVdmJQK01HdUFsdTRyU2tFeVE0NEM0eFBuc0VQ?=
 =?utf-8?B?VmJpN2o3TlMrR1lZRGdRZmtWRHd0T3ZxQVRqdWwyQWRYbnJaUFRlTjAvWE1i?=
 =?utf-8?B?REFFRG1hYTNkWGNrcmdhbElYenp5MVFUVUd1SGF3VXBHZGhjYTdQZUNqdm53?=
 =?utf-8?B?OTc2KzVjWmpLWWxFcGRGUy9CRDBkc3JpdmZraUhrdFdJeDY3Y1VTTmFzUFlh?=
 =?utf-8?B?dnJPVmxJR1RTTDlpdFBoaEhCZG1QaS95ZUE0Y0s0U0IrRFZFb0t3eTAxY1ZN?=
 =?utf-8?B?dCsvRDhKUm9rOGRHVWloS3dmdHZ1S2FDZ2F4RlNNVEJJdnVYQ04xT28vREla?=
 =?utf-8?B?bFh2Mi9kNkwza2J4aFhiQ2g5QjdYYnc4elJjZVRhZmR1MFVCUS9POWdWT21F?=
 =?utf-8?B?NHdJYVRZVndrb1k4d2xCaTdMU1FuaU50dWxlZGl6bkRJcWRVWUJRMEJkZnVH?=
 =?utf-8?B?SHViYjFPQldlaDl2MERtMzJtV3oxSHVsRFJQVGxVQXJHOXVKcW9jM2FmTTl1?=
 =?utf-8?B?V3RnaHhyR3NXOUplSnhyTzZXS1VSRm5xOGwycEZSUnNxZHRPczlJNFdFR0Q2?=
 =?utf-8?B?TlhRdlE0NG9venFQajd2T1lGblB1TUFYWm54VTg2cHVaTm1RTC9QcExDUUI0?=
 =?utf-8?B?ZXpaMElYdENpSytZU2hiWG0xa3l2amZyckpVSlhPNTMydjJxQ3lLY1BPUjRJ?=
 =?utf-8?B?ZUFqTVFIN3FqeEtDOGpoWFFvUWt0ZXFQTEowRWF1YXhjSEd1TVpoSDBKZDJq?=
 =?utf-8?B?Z2RFRFZOV1ovS1M5NGRwQ3BKaE9FNnhYVHFkVFNwV3FBOVNMcExvOGVHSTdJ?=
 =?utf-8?B?WWFjcDJVa00rRXhQdXdUd29FZSt4RU1qYjIwVm5xVm5BWXY1bERZVDNZMUhl?=
 =?utf-8?B?aGU2QTVDTTNLM2hlMkg4VnZIOVZuMW13cHlFcXowRWVtWXNVakJGWmFoWnFz?=
 =?utf-8?B?MEt4NFl4MEsyVC92Nll5MGVtcFRvOXVOSGxIWW5GaEVOUXFsc2RjSldLaWVk?=
 =?utf-8?B?SHQvT3ZRbEh1MWNMeWRZUGpSZnQvd2tibkNPaWY5dURzWGtZMUFORHRjdTJk?=
 =?utf-8?B?YzhJd0V2SXQrSjdxRmdnQkJyZktqM2dxQlZXcW0wTk4xakI0N2tYNGlSNG9B?=
 =?utf-8?B?d0pKNHk0STJneExwSU9jWjlBVVlPSkpNRGxsR1U5ZmpKdnpObk84K3QwZzlN?=
 =?utf-8?B?MDViRDZSYU5zSlpGTnBqUXVVM3FRZDZBaUg2QW1OS0cvOHpEdXRhZEd2WXps?=
 =?utf-8?B?K2U0NWxrY0loSW5HL2h5dS9WV25XM1RnYWJTclNQSGdIU1J6QWxpcmJjUEI5?=
 =?utf-8?B?Y08zK3JobEk5SEtsVGVyL0tidHovNWpwdGtUcU1jZDZqR2ZIM2tVS2lyNUs5?=
 =?utf-8?B?cFE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f6ebb1-769f-45de-72b5-08dbd4cbc621
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 19:59:47.1650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kT5CHSxo/0tbSiGtJkhHkWk9QBKNYA8MnX1zmKZuwRqKp4Pd2HDXULfVGptaOQ4I0Pr0pK1oYYymrcKDEyQANQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB10696
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

SGkgTGluLAoKY291bGQgeW91IGtlZXAgdGhlIGx0dG5nLWRldiBsaXN0IGluIENDIG9uIHlvdXIg
cmVwbGllcyBpbiB0aGUgZnV0dXJlPwoKCk9uIDIwMjMtMTAtMjQgMDk6MjUsIExpbiBBcmNYIHdy
b3RlOgo+IFRoYW5rcyBmb3IgeW91ciByZXNwb25zZS4gaSBmaXhlZCB0aGUgbmFtZXMuIGhlcmUg
aXMgbmV3IGNvbW1hbmRzOgo+ICMgZW5hYmxlIGV2ZW50IGZvciB0cmFjZWQgZnVuY3Rpb25zCj4g
c3VkbyBsdHRuZyBlbmFibGUtZXZlbnQgLS1rZXJuZWwgaXJxX2hhbmRsZXJfZW50cnksbmFwaV9w
b2xsLG5ldF9kZXZfcXVldWUKPiAKPiAjIGRpZmZlcmVudCBuYW1lIHdpdGgga2VybmVsCj4gc3Vk
byBsdHRuZyBlbmFibGUtZXZlbnQgLS1rZXJuZWwgCj4gbmV0X2lmX3J4X2VudHJ5LG5ldF9pZl9y
eF9uaV9lbnRyeSxuZXRfbmFwaV9ncm9fcmVjZWl2ZV9lbnRyeSxuZXRfaWZfcmVjZWl2ZV9za2Jf
bGlzdF9lbnRyeSxuZXRfaWZfcmVjZWl2ZV9za2IKPiAKPiBOb3cgSW4gbmV3IHRyYWNlZmlsZcKg
aSBjYW4gc2VlIGEgbG90IG9mIG5ldyBldmVudHMgY29tZS4gYnV0IHN0aWxsIGNhbid0IAo+IHNl
ZSBhbnkgdHJhY2UgZnJvbSB0aGVzZToKPiAKPiBuZXRfaWZfcnhfbmlfZW50cnkKPiBuZXRfbmFw
aV9ncm9fcmVjZWl2ZV9lbnRyeQo+IG5ldF9pZl9yZWNlaXZlX3NrYl9saXN0X2VudHJ5Cj4gClRo
aXMgbG9va3MgZmluZSB0byBtZS4KCk9uIGEgbGludXggNC4xOSBzeXN0ZW0sIEkgcmFuIGEgdGVz
dCB3aXRoIHVzaW5nIGx0dG5nLW1vZHVsZXMgMi4xMi4xNC4gSSAKc2F3IGV2ZW50cyBmb3IgIm5l
dF9uYXBpX2dyb19yZWNlaXZlX2VudHJ5Ii4KCkluIHBhcmFsbGVsIHdpdGggdGhlIExUVG5nIHRy
YWNpbmcgc2Vzc2lvbiwgSSByYW4KCiAgIHBlcmYgc3RhdCAtZSAKbmV0Om5ldGlmX3J4X25pX2Vu
dHJ5LG5ldDpuZXRpZl9yZWNlaXZlX3NrYl9saXN0X2VudHJ5LG5ldDpuYXBpX2dyb19yZWNlaXZl
X2VudHJ5CgpUaGUgYWJvdmUgYWxsb3dlZCBtZSB0byBjb25maXJtIHRoYXQgdGhlcmUgd2VyZSAK
Im5ldDpuYXBpX2dyb19yZWNlaXZlX2VudHJ5X2V2ZW50cyIsIGJ1dCBubyAibmV0Om5ldGlmX3J4
X25pX2VudHJ5IiBvciAKIm5ldDpuZXRpZl9yZWNlaXZlX3NrYl9saXN0X2VudHJ5IiBvY2N1cnJl
bmNlcyBpbiBteSB0ZXN0LgoKQXJlIHlvdSBzZWVpbmcgYSBzaXR1YXRpb24gd2hlcmUgYW5vdGhl
ciB0b29sIGlzIHJlY29yZGluZyBvY2N1cnJlbmNlcyAKb2YgdGhlIGV2ZW50cyB0aGF0IHlvdSB0
aGluayBhcmVuJ3QgYmVpbmcgc2VlbiBkdXJpbmcgeW91ciB0cmFjaW5nIHNlc3Npb24/Cgp0aGFu
a3MsCmtpZW5hbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6
Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
