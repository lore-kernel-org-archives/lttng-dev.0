Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7D5C4167B
	for <lttng-dev@archiver.kernel.org>; Tue, 28 Nov 2023 19:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1701201351;
	bh=3IqwnrTJdrXlOpSYqVaYTSruK0zM+fzn6bzhO1JtV4s=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=I7/q0E7KnQZ403cx3VS/CuImbg26XQiyggpdJqC0+A9D4BBiBlyrKJ58YiWx6+iw1
	 WJw2fVq8oDj55VRLLRzkqUPR/T6z8QOtxHmCFt7BMe6lIJYS1aKlTzH2MtevMldwBa
	 hDDvDCtI4nF6E2P/i7jklSYYUlG/MHB8O8WiMp3gf45qWnrsA34XpTbNGXsL9Xmcgl
	 hVkbZCIEdRM6MYYs++g0YXP1uVJdKd6OfmENmvngBP6W5YMNJ+RqyhH1IMd9zA9Mgd
	 0Hc7Cd7LM21xCzAXu7H0kUnVW01vTRfs4YIhXOHqFdPkV/Fpj+g0nZkiBcIFPalLRL
	 84sEqV+xcehPw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4SftVZ1HN2zN3j;
	Tue, 28 Nov 2023 14:55:50 -0500 (EST)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2071.outbound.protection.outlook.com [40.107.116.71])
 by lists.lttng.org (Postfix) with ESMTPS id 4SftVX59sRzN3g
 for <lttng-dev@lists.lttng.org>; Tue, 28 Nov 2023 14:55:48 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+Hc56QwmXH0mNd32AuhfISamKMebWejfrLL7NAEQxcOri4V8ZbsMIIt3t5wGLKFWKrbnEcChrJhlw+ZgVtc1H7Jw7kaM7Xf2qC+UfdSzdLRddOPh594tmnv7k2yl955ptyxWQqemYCYdPkYlzB0/gIicW4s16ynhSjEn6Af5T0YEyEKfe7x6Zbmdubz6PebWydU4xx+uSKrqNZM5hXisIK7PMi1YyiwtAgq4rLnwXXUWrt1N68p2IB8jcgD5EeIBcMiqiH60wQAx9MSkgh02Du2o9K9y0dIgLV4my4FBxyxQsRj0/NsQ4d6HQEmp8a4MKzvp/eC53+fgfVG0Ozadw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPVShrnnzRdrNvh43eWm8oZr16ipL8me2Uk8mrMbbg8=;
 b=C4OedupWi0YVmg/AV13fZUcY4ZiJO19LRgG+n46JnPaSyv4WSiXBG32yPVHRLRqXQQ7DPJghF7JHYxtmXKCRfPzyC+NDaotdIwOlazZsKTaJL/xnCAGF1jO1EcEdemiVa+0UpiVhYP4461bhvqjXTCzl4VcFa9IfRz15MnSdUDndfT8nSSmcIVC3fXCHxHoLbvXUmFU65m4HvtP7PVJrbXpf9rzROEyGdInorwIEH1/kNhaAKSvnE1clInGbKBYGrEdAgO75GFdbzlmBU4ls/iZ3ss02fdmqTPElF8tsSzgqacbnM04vwP/1crFaeq+CmGYTlSvDuyxRmpxICB+7Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:de::19)
 by YT4PR01MB10552.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:105::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 19:55:46 +0000
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c37c:acd3:88f4:feab]) by YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c37c:acd3:88f4:feab%5]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 19:55:46 +0000
Message-ID: <24b4fcc5-5faf-4a44-8a43-64bcb64e29d0@efficios.com>
Date: Tue, 28 Nov 2023 14:55:44 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US, fr-CA, en-CA
To: Bruce Ashfield <bruce.ashfield@gmail.com>
Cc: lttng-dev@lists.lttng.org
References: <20231123193249.3190764-1-bruce.ashfield@gmail.com>
 <20231123193249.3190764-3-bruce.ashfield@gmail.com>
 <2c0e2bb6-470d-45b7-af19-cbe0bd7eb280@efficios.com>
 <CADkTA4MJwtamzZxaV9tY56aCM5NdKvWj9tAiNW9nhuez6VLJDw@mail.gmail.com>
In-Reply-To: <CADkTA4MJwtamzZxaV9tY56aCM5NdKvWj9tAiNW9nhuez6VLJDw@mail.gmail.com>
X-ClientProxiedBy: YQBPR0101CA0249.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::7) To YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:de::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9793:EE_|YT4PR01MB10552:EE_
X-MS-Office365-Filtering-Correlation-Id: e1472869-229a-4778-f32e-08dbf04c02fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hvIYvKrk9uDIrsZ+wUpKOuMXM9iDBha0T8sJeZ0m90t71bThECddpwVy1IEVa/0hUmmU6KIiqEAoa+df+WvfKnGEL+1CJ887wkaND4P1Km8sBa6BmQrcF+PjDRB9rdbVTbWtO0ZcQEaLWK4zVJOQ+k/7V/OG3ecqya1PgmVDWbRj2WULV7dOknfVomguqpehULoGS4POChv7xhprrN0SMBhg0JLGJ+GOwl2GaxZCJGFKR0ANPdfFtwm5yL7e5XCNMFGgRCrnFWmBKRNSpMPkEFVIF4nlEiQgGskf2iBZ+01D2oNxHB7qhtytp/HJo0b+5LU2es8D8Ekkp2HcPayyi1M+yldeqrwdYSk1LmxwxTZax28yCurG9Xg/CxIgEX9dVhr90X74uxjFP2bPUprA8yx2rEfyLIA5PX4v7jViQMCagbd38O1aOcq+NJAaPizPNR8dU9xcd5rSSvrpCAGRMhZPefd7ctlB/AkInALxstwiSeiBENOg2YNpOMtpNla+/a2kGaSIYAZAtVtoF1xQbIrZ7fDaObp/2M8jOzZXtdCkk+dfTxZ/kUb3Wl2QLwMr2wRk19aaZgwWOOUN2YSSFp3ntuXLcPaeYSKZVSdND/UN4IBoUB1UeEdgzJX/vVRTqItfZxhFcJO34tRWvOhpng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(39830400003)(346002)(376002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(5660300002)(31686004)(4001150100001)(41300700001)(4326008)(8936002)(8676002)(2906002)(316002)(66476007)(6916009)(66556008)(66946007)(2616005)(6486002)(478600001)(53546011)(6512007)(6506007)(36756003)(26005)(86362001)(83380400001)(966005)(38100700002)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGZvK0pvNXI2cWhtUjNUdmJBMVdaMGJQSDdJYXhjNjI5QTdkM2xCalJxaWZU?=
 =?utf-8?B?T3Jwa0E2bFQzbHRJNTRNSGlIaWR6VUFKMllWUUcyYmlscGFQMEpubCt2N0F0?=
 =?utf-8?B?SXBDMHdRYmRXbWs0MjUxc3Jlc2o1M0hWM2ZTNm9GRGc3cjJsSmMvdFhDTy9R?=
 =?utf-8?B?Y1VvN2k5ZmN2UE9BZm9OdFZ4UUxxblBJb3dOZDRXbHdhOHFUQ0tYUTA5dHND?=
 =?utf-8?B?dC9laDlJSTFVZzUxVWlYUEc0ZHdJQlAzY2lCczVKOHc2YnduTXl2WVNiVXFQ?=
 =?utf-8?B?dUxVL2ZRYVRwMURKTFNMOEJUYTdqWmFYa1RiK1ZOSTcrSE9nZWU5WVBUcW5j?=
 =?utf-8?B?R09vcDVsZVd3Q09McldEYWlLcWtLdU9QTEsrRllIWUtTdC9CUlVnS1lrZk5R?=
 =?utf-8?B?aDlwZWlTVlB1a1puSFZHQzI5YXB0QUpQUUxYeVh4a0hIeVo0ZXBEdFFaTGRa?=
 =?utf-8?B?Y2kwQVlqbEZwckNoT25OaCtOR0ZydVJKY296aGJMY3ZFa0lkQ2FrRFhyWXlr?=
 =?utf-8?B?clVaWFZ4SWw0eVFIZ3lVYUg1a1lqZXp1NjYrL2VpeTJTSGZya3lYSEVVcmp5?=
 =?utf-8?B?RXZVaXoySlZuMnNISnRYMEx0V3dSQnkwV3N1L1hJTjA1OThxSjhTbEtOL1J6?=
 =?utf-8?B?WjBnZHNKNlovSzNBYW5WZGl4ZWlSanc2emtzWDZNVzN1QkljcTR6WVlzeEdC?=
 =?utf-8?B?SjlRdVBnOTJaNjBIRGZTaVo1c1AzdlZqL1k3dzRLQkkvLzNpSkttTEJDUW42?=
 =?utf-8?B?RW15V05VY0JOS1hCUDNEd2tWaG9Uclh5cFBuKytDSnJnWTN5M0pjdFJ2TUFO?=
 =?utf-8?B?aTQ1S2NGSm0zUnRpMnF0QlFBTnNqZzg4dFlJTEw5SWtSS0Z4MDdVbkR5TU5O?=
 =?utf-8?B?QVBXUVZ4L0RXY3RBa2JaVlQ3TlVKbkcyUWRzeXRyWWFOaEFVZ2drc0xPbGlz?=
 =?utf-8?B?NEEzSnJyL25meGdlZFpKQ0tNTWpDcWM3aU5rMnI2VXpsLzRXRW1qQzlaNmtJ?=
 =?utf-8?B?dFBuTnBqZmMvVDkwNWVobU04SUZ2a0Jacnh3U09EbTg2OGdKRDFBVDQ0dmNL?=
 =?utf-8?B?d0EycngvOUpRUjJXU2o0dDVCKzZrSC80ZzdLd2hDRHBaYk9JVVc3cU5rV2Zk?=
 =?utf-8?B?YjdDdkE3NEUrQlhtSHZBUnViZHU4ZFRsOStZTkk0Qzg1UVZxcEdoSXFyRzZm?=
 =?utf-8?B?aEV3eGNUUXBWRzBFNTl6cVNGY3lQb0twclArNmZ4bnBueWErOVF2ak9kT1Vx?=
 =?utf-8?B?RmVaS0gvY2I5YTVtN1R4THBtakYvRW1sYkJzdDlsclZSek4zcS8zMlBFeEtK?=
 =?utf-8?B?UDN3RHNvUXVrYVVIZ3NIWmdqSWsxU0FsTVYydWFiM1hvU0ZxVGpWSWpXVkx1?=
 =?utf-8?B?aklYc3M4b3JWalRHaXAvNnp2d0pvTzdmOTczVE5vT0paSkpHVnQ0bTRrMFg1?=
 =?utf-8?B?U0k4ejR1eDBpdXdaaG13dk9UYUdQc0t3SlVCMGZFbGx4OENhVUVVWjR4WFpP?=
 =?utf-8?B?Nyt2RmQ0a2hHaFRnK2JsTmo2UGJmWnBTUnNWS2ZGSGhlVmNtMjBGS2Z5NGhW?=
 =?utf-8?B?dHlEV0orMnYrd3U2b3BZZzVKNmlsM0pBNjRuWXVPRktqYUhsSEtTWkxuVUVH?=
 =?utf-8?B?N2Z1ZSt1MTBIdGlQOXdKVUZsb3BBVnF3TWlqOXhhTkxiNmE4anh4NHBzN09U?=
 =?utf-8?B?STFuTlRDaGNyYXF0NDlTc3ZFc3NEejlrT2d3eFl2STY0NmEyV29EUGFZaWtj?=
 =?utf-8?B?dEpGWEhBQlVKSUlvMW5pTUI3Q0VQWkZkRDRQNEpCenpHQW81cTI1QnlmazN2?=
 =?utf-8?B?NFp2VkZzcGc0SVcwUVMrWXl0dUkzMU9WYmZRRXBDTnlMZTFmR0tNUk1VVStD?=
 =?utf-8?B?Szd0V3RRVnkrc2xMbWgvWnJCRExReEhZcXJsNnRKTEM0d0ZBbTY5VnNIVDly?=
 =?utf-8?B?cXZQa1ZjZ0J6RXpqcUMwSzhmL1NjNG5rNmFQc1NkcWNXMWMzWndyWkg4WnJR?=
 =?utf-8?B?NjJEZHZGakk4K0tOWlNpWGI5dC9DaVJTRnpQdWJpOWJIVk54dlZHMWtrWnR5?=
 =?utf-8?B?NHZLQ0VpSjdXRTBXc0hYb0E0cTdCZDNwNytrTnpaQ0lpMG10alovWVpCZW92?=
 =?utf-8?B?cTdWRFpEd0ZWYVFSb1JyRkMvKzZTb3d5Nm5GVUdQcEJ2YU9WM2czN1BabEdw?=
 =?utf-8?B?aXc9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1472869-229a-4778-f32e-08dbf04c02fc
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 19:55:46.2471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHDT1JeWU455PPwKKKVFBeTYr7kpLZQmJvGGW3pfbxWBXG9drkR2VP6vH4vHA0NvrucIe0JyHigQh+zN7+COtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB10552
Subject: Re: [lttng-dev] [PATCH 3/3] vmscan: drop isolate_mode (v6.7+)
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

SGkgQnJ1Y2UsCgpqdXN0IGEgcXVpY2sgZm9sbG93LXVwIHRvIHNheSB0aGF0IHRoZSBmaXhlcyBm
b3IgYnVpbGRpbmcgYWdhaW5zdCBMaW51eCAKNi43IGhhdmUgYmVlbiBtZXJnZWQgaW50byB0aGUg
bWFzdGVyIGFuZCBzdGFibGUtMi4xMyBicmFuY2hlcyBvZiAKbHR0bmctbW9kdWxlcy4KCnRoYW5r
cywKa2llbmFuCgpPbiAyMDIzLTExLTIzIDE0OjU2LCBCcnVjZSBBc2hmaWVsZCB3cm90ZToKPiBB
aGEsCj4gCj4gU28gdGhlIG1haWxpbmcgbGlzdCBpc24ndCB1c2VkIGZvciBwYXRjaCBzdWJtaXNz
aW9uIGFueW1vcmUgPyBJIGRpZG4ndAo+IG5vdGljZSBhbnkgdXBkYXRlcyBpbiB0aGUgUkVBRE1F
cywgZXRjLCBzbyBJIGp1c3QgZmVsbCBiYWNrIHRvIG15Cj4gZXhpc3Rpbmcgd29ya2Zsb3cuCj4g
Cj4gSSBqdXN0IHdhbnQgdG8ga25vdywgc28gSSB3b24ndCB3YXN0ZSB0aW1lIGluIHRoZSBmdXR1
cmUuCj4gCj4gQnJ1Y2UKPiAKPiBPbiBUaHUsIE5vdiAyMywgMjAyMyBhdCAyOjQ54oCvUE0gS2ll
bmFuIFN0ZXdhcnQgPGtzdGV3YXJ0QGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4+Cj4+IEhpIEJydWNl
LAo+Pgo+PiB0aGFua3MgZm9yIHRoZSBwYXRjaGVzISBUaGVyZSdzIGEgc2ltaWxhciBzZXJpZXMg
d2FpdGluZyBmb3IgcmV2aWV3Ogo+PiBodHRwczovL3Jldmlldy5sdHRuZy5vcmcvcS90b3BpYzol
MjJmaXgtbGludXgtNi43LjAtcmMxJTIyCj4+Cj4+IHRoYW5rcywKPj4ga2llbmFuCj4+Cj4+IE9u
IDIwMjMtMTEtMjMgMTQ6MzIsIEJydWNlIEFzaGZpZWxkIHZpYSBsdHRuZy1kZXYgd3JvdGU6Cj4+
PiBGcm9tOiBCcnVjZSBBc2hmaWVsZCA8YnJ1Y2UuYXNoZmllbGRAZ21haWwuY29tPgo+Pj4KPj4+
IGNvbW1pdCAzZGZiYjU1NWM5OGFjNTViOSBbbW0sIHZtc2NhbjogcmVtb3ZlIElTT0xBVEVfVU5N
QVBQRURdCj4+PiBtYWtlcyB0aGUgaXNvbGF0ZV9tb2RlIHBhcmFtZXRlciB1bnVzZWQsIHNvIGl0
IGlzIHJlbW92ZWQuCj4+Pgo+Pj4gVGhpcyB1cGRhdGVzIHRoZSBldmVudCB0byBtYXRjaC4KPj4+
Cj4+PiBTaWduZWQtb2ZmLWJ5OiBCcnVjZSBBc2hmaWVsZCA8YnJ1Y2UuYXNoZmllbGRAZ21haWwu
Y29tPgo+Pj4gLS0tCj4+Pgo+Pj4gUmVwZWF0aW5nIHRoZSBjb21tZW50IGZyb20gcGF0Y2ggMSAm
IDIgb2YgdGhpcyBzZXJpZXM6Cj4+Pgo+Pj4gU29tZW9uZSBlbHNlIG1heSBvciBtYXkgbm90IGFs
cmVhZHkgaGF2ZSB0aGlzIGluIGZsaWdodCwKPj4+IGJ1dCBJIGRpZG4ndCBzZWUgYW55dGhpbmcg
b24gdGhlIGxpc3Qgb3IgaW4gdGhlIGdpdAo+Pj4gcmVwby4KPj4+Cj4+PiBJIHJhbiBpbnRvIHRo
aXMgZmFpbHVyZSB3aGVuIHdvcmtpbmcgb24gdGhlIHY2LjctcmMKPj4+IGtlcm5lbCBhcyBwYXJ0
IG9mIHlvY3RvIHByb2plY3Qga2VybmVsIHVwZGF0ZXMuCj4+Pgo+Pj4gVHdlYWsgYXMgbmVjZXNz
YXJ5LCBhcyBJJ20gbm8gZXhwZXJ0IGluIHRoZSByaWdodCB3YXkKPj4+IHRvIHZlcnNpb24gdGhl
c2Ugc29ydCBvZiBjaGFuZ2VzLgo+Pj4KPj4+IEJydWNlCj4+Pgo+Pj4gICAgaW5jbHVkZS9pbnN0
cnVtZW50YXRpb24vZXZlbnRzL21tX3Ztc2Nhbi5oIHwgMTAgKysrKysrKysrLQo+Pj4gICAgMSBm
aWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pj4KPj4+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2luc3RydW1lbnRhdGlvbi9ldmVudHMvbW1fdm1zY2FuLmggYi9pbmNs
dWRlL2luc3RydW1lbnRhdGlvbi9ldmVudHMvbW1fdm1zY2FuLmgKPj4+IGluZGV4IGU3ZTliNjEz
Li5hM2U5ZGRmMiAxMDA2NDQKPj4+IC0tLSBhL2luY2x1ZGUvaW5zdHJ1bWVudGF0aW9uL2V2ZW50
cy9tbV92bXNjYW4uaAo+Pj4gKysrIGIvaW5jbHVkZS9pbnN0cnVtZW50YXRpb24vZXZlbnRzL21t
X3Ztc2Nhbi5oCj4+PiBAQCAtMzQzLDEyICszNDMsMTggQEAgTFRUTkdfVFJBQ0VQT0lOVF9FVkVO
VChtbV92bXNjYW5fbHJ1X2lzb2xhdGUsCj4+PiAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25n
IG5yX3NjYW5uZWQsCj4+PiAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIG5yX3NraXBwZWQs
Cj4+PiAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIG5yX3Rha2VuLAo+Pj4gKyNpZiAoTFRU
TkdfTElOVVhfVkVSU0lPTl9DT0RFIDwgTFRUTkdfS0VSTkVMX1ZFUlNJT04oNiw3LDApKQo+Pj4g
ICAgICAgICAgICAgICAgaXNvbGF0ZV9tb2RlX3QgaXNvbGF0ZV9tb2RlLAo+Pj4gKyNlbmRpZgo+
Pj4gICAgICAgICAgICAgICAgaW50IGxydQo+Pj4gICAgICAgICksCj4+Pgo+Pj4gICAgICAgIFRQ
X0FSR1MoY2xhc3N6b25lX2lkeCwgb3JkZXIsIG5yX3JlcXVlc3RlZCwgbnJfc2Nhbm5lZCwgbnJf
c2tpcHBlZCwKPj4+IC0gICAgICAgICAgICAgbnJfdGFrZW4sIGlzb2xhdGVfbW9kZSwgbHJ1Cj4+
PiArICAgICAgICAgICAgIG5yX3Rha2VuLAo+Pj4gKyNpZiAoTFRUTkdfTElOVVhfVkVSU0lPTl9D
T0RFIDwgTFRUTkdfS0VSTkVMX1ZFUlNJT04oNiw3LDApKQo+Pj4gKyAgICAgICAgICAgICBpc29s
YXRlX21vZGUsCj4+PiArI2VuZGlmCj4+PiArICAgICAgICAgICAgIGxydQo+Pj4gICAgICAgICks
Cj4+Pgo+Pj4gICAgICAgIFRQX0ZJRUxEUygKPj4+IEBAIC0zNTgsNyArMzY0LDkgQEAgTFRUTkdf
VFJBQ0VQT0lOVF9FVkVOVChtbV92bXNjYW5fbHJ1X2lzb2xhdGUsCj4+PiAgICAgICAgICAgICAg
ICBjdGZfaW50ZWdlcih1bnNpZ25lZCBsb25nLCBucl9zY2FubmVkLCBucl9zY2FubmVkKQo+Pj4g
ICAgICAgICAgICAgICAgY3RmX2ludGVnZXIodW5zaWduZWQgbG9uZywgbnJfc2tpcHBlZCwgbnJf
c2tpcHBlZCkKPj4+ICAgICAgICAgICAgICAgIGN0Zl9pbnRlZ2VyKHVuc2lnbmVkIGxvbmcsIG5y
X3Rha2VuLCBucl90YWtlbikKPj4+ICsjaWYgKExUVE5HX0xJTlVYX1ZFUlNJT05fQ09ERSA8IExU
VE5HX0tFUk5FTF9WRVJTSU9OKDYsNywwKSkKPj4+ICAgICAgICAgICAgICAgIGN0Zl9pbnRlZ2Vy
KGlzb2xhdGVfbW9kZV90LCBpc29sYXRlX21vZGUsIGlzb2xhdGVfbW9kZSkKPj4+ICsjZW5kaWYK
Pj4+ICAgICAgICAgICAgICAgIGN0Zl9pbnRlZ2VyKGludCwgbHJ1LCBscnUpCj4+PiAgICAgICAg
KQo+Pj4gICAgKQo+IAo+IAo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5n
LWRldgo=
