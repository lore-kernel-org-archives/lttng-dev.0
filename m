Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED10C43458
	for <lttng-dev@archiver.kernel.org>; Fri, 10 Jul 2026 04:17:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gxJTQ5k1Kz10ZD
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1783657066;
	b=RDGfS0nEwKqRFy7gZ3h3lIjUtkCspkJygcbGIR+/sC40VT2C280deoQNbY8ebg3WxTSX
	 KPUv8TKz3uXV9MZUq3B/byFXWC6PMNXkThqiwPYNWdPxyKsGsYuKWx7+8I4MxgtZVrmPN
	 lvDGxG9+cqCX1q4XQEpoqM0u6dvXdPeNHLV8uctFwyqyuLf6tlnfCPv5kO5bYaLxay4YG
	 50csRjreV8jqIedkD+ljr+aIL5HUE8Re1iGeSrKplbLq1bPTLPGyioL5vXLignu8c4gTq
	 83l4jtMhhYeUOrx8nCIpiXEyuARtuJR4N6vQVUc41UKHWjTyhx0u1Gg/SuL4gEcepcA==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1783657066;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=MHzhB2PmOV5sGnDBo6VQoqI8notkqksNSM87CYHSARY=;
	b=OvkxYt78m8aNqg3hLZbzQh6VcLosOwOEy+1U89pK/AXifIcK2cIN0fPm1tn3/JkaZx0X
	 Xg/RvjGgsnc5gNu/AgdNh5/Ki5CV6yx+Jpj6stGkeMKeJpIxrJiexhia1sTy7FhRqvEXP
	 0cESR9jEtH+q6lS3FL0BEe2Ot2czi/HGJL71GQdITKaEI2oHEAH1WqKgvy7A1XQV/MyRp
	 POeVI4D/3m1pXac74JEoy5t44WzHiw/X1lXQmoS/nGDE+aG8SCfZE+5AXIyAbIb6eqzYD
	 5TSQiZ1rZTJrsTlJWc1XzyA/XOL+fffYVoJTV4Z3OHmEzSPE3CsPLt3A3fAznIv3Tqw==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gxJTQ5k1Kz10ZD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1783657066;
	bh=LHUJVK4Kqp6XcXD6ZN1StSc18kB/P0LF0mxKgdzjqC4=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=i5jBnqyktioWBW5gPwI9vGMAcyL0/kCmB2Ohu3t+I3FsAFZv3qNwJzH7e6/hfKDnF
	 +PmbQOeKZPGX7GaDLTqd6Afc/ilOwUYXDbKt0SN6iiZ8bJy0U4Do02smSvCOuOWccp
	 kHjsOM7apPonhyobCdRgZ6HKsZ8QOCM6fxbF4JjiQmgJB2wLXzGD58OTwK4iHKVxxE
	 4eIdxyohcO+LbrKFvLy17XAa5eKeGZZYsnR/oHW4dkvZtu1/ZQHnpcGjNfThe56NnU
	 Wp9+4BAFWJ0aUfyX7JPty1DCRQViqJl+GfuLpv2BYQjNdCQGVJnmCRGSFuewS6J51m
	 myDLxlUftqYvQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4gxJTQ5k1Kz10ZD;
	Fri, 10 Jul 2026 00:17:46 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gxJTP3CYzz10ZB
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gxJTP3CYzz10ZB
Received: from YT5PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazon11021143.outbound.protection.outlook.com
 [40.107.192.143])
 by lists.lttng.org (Postfix) with ESMTPS id 4gxJTP3CYzz10ZB
 for <lttng-dev@lists.lttng.org>; Fri, 10 Jul 2026 00:17:45 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHch8hABB7Wml4G4vkyG12irNaEYflPcSP/fZBvO7QJjONjR22QlIsKrpKsQs11ivLUu7a0jaFc9XkzZ3GsH8R6WXx5RULrYYmT+CCpVzqSoWYnvWhXmpk0TP/70h3q6iet29x8++RHn0u8CWD9o3AjZTNaKhcC3/7Am2A77OovTqfiLa/bkQZ43C0x1Aipd2K6MordMdsfVRc4KJDAFToQb90cvEAKe5SK8AU5MGyUi7JP7n2cbCUf0Av295yKKPx40oJLAyi3PsSJsbb2C6Qe6GmWomHm5IWqeScOkog64Lh5/Rx5MTJ7RECVRYvzLFW2yqwmayMadkZ7J8Rpl+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHUJVK4Kqp6XcXD6ZN1StSc18kB/P0LF0mxKgdzjqC4=;
 b=GELBUbjIuAXzhyZprEq4QHShSu0+fI7+bRKdPGaswyuPVTLY8z8TEY0alLztHFQxwcA915/Kh9xjLhK1OV/FpJvWLZcchd9w7ISdlUu4owk6Wt0desmatZDJgG1lwI0RZ+WsgIaGOIvC6Vq3VQWCPzrwgkOJ8eiwdirf8Peq9ylKYY6fHbV5a/USVuE01doi7jZ8Gqe90V96VJbtq9kLmvUhGilcIBmIakh5+Vj5EMacgLPvRlBaEb/vp69RON+/z684ghrXo0Q+XskcX95rvVrZsQxP+L41OeytPYAmyAj/UUJRw+qjyJ+qQBFg7NnFDWYoAvP6thFLy6urf8gLCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB9031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 04:17:40 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%4]) with mapi id 15.21.0181.017; Fri, 10 Jul 2026
 04:17:40 +0000
Message-ID: <b37eebf7-1500-4b41-bb65-074473b35cd9@efficios.com>
Date: Fri, 10 Jul 2026 00:17:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: CPU affinity behavior of liburcu call-rcu per-cpu worker threads
To: paulmck@kernel.org
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Olivier Dion <odion@efficios.com>
References: <e8fa9744-74d2-4fae-8684-f1df59aec1c0@efficios.com>
 <0600b601-3edf-4897-b319-b4763943809c@efficios.com>
 <3573944e-3abc-48d7-aedf-3362ebd7ebe4@paulmck-laptop>
 <38f1f93e-3bfa-425a-96d9-3035c8ecc785@efficios.com>
 <1aaa979b-bad9-47a5-879b-b4fb2379ad20@paulmck-laptop>
 <a25cc916-2bb3-4133-afcb-230dd577726d@efficios.com>
 <02709be9-d7d8-47cc-8032-ed2e3a714fb0@paulmck-laptop>
 <14541751-5104-483b-b60c-415d791b4bf4@efficios.com>
 <95f2d189-ebe2-47f1-91db-c964f2cda8a7@paulmck-laptop>
Content-Language: en-US
In-Reply-To: <95f2d189-ebe2-47f1-91db-c964f2cda8a7@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0022.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::20) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB9031:EE_
X-MS-Office365-Filtering-Correlation-Id: beeba1b9-6af4-4246-75a4-08dede3a2e6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|23010399003|366016|1800799024|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: JcVR2Yc8+mXyQuil/hlUz2e1WQfBiVpa+JA7ZxEasOnR/n4zsJd1ZDamTVXhJKCdavY2XJEGXgTeC+5JKpovKJyydG7zHPYUwTGxzp59wi6Ayw6w9XZ1iiQ7TZch+bs5WyASYBmweUn2/c6q5EK21rWYJdJbcjr6tx8AugfHr+qaaJr74thotJKfDtMF0NzP/JpyK31aAC+JEFztkay853KNxBmPi79FwFVoK+y4OlYo2HrQNu9yP+IMwXI5FsHZiKWt4T/pDYyYX03/ClEdvM/2D8y2PsHbytYF/3kZITc6g5xpnVjxSmN5LVl7D/yFArp0PG9UHG/D5TWYrLLS3f/um3G7d9M5gf2OOyA5471mXNPYPcywQxmz74sIvC/jr+kKjEvgWGOxphpvUzW3tSjDI2KhmbzNgXwvSXyyGCxK0qxfdbd8gZPCgiMzYEiduhtuxTIwiu+KHSCX19R823wOQwR+CZK+x7abwUqXKOnJCV1Sxmn3UqVRLqRyI6nznwHRtKGXtfImhqo7vqphORw3mKHkcis/cpew37IkH2qAJHjm3r/Da0XhNbkr+zexyz8PqzxmWMO0bQJNKFDeu0fR/XUYFst8J/WuwHm+jlQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(23010399003)(366016)(1800799024)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1NGZGM3NHZ5VjVVdUFNdGVkaTBWRks1TTZEbmowWFpNSmNHUDhvRHBza1Ax?=
 =?utf-8?B?UEhBNjIvdUtIaUhQOFRGN1dsSXNzQmVkVFdtd1I4U0hBRUVkc0pxVVMxZkVk?=
 =?utf-8?B?N0tFL29PR0h3OWVJVkM4ZFRRWWtzK2VEMTc0NGoycVg3NVpzZVZEa3NDSGJR?=
 =?utf-8?B?WGtIWkFiRVdsU0lnQVMzODlVNnZFd1Jtcm5IQStIWXlIZlVnQ0EwQmp0UXhy?=
 =?utf-8?B?WU9kN3l3YkxSS1RJOGhHdCtDMlRGc1loSkw4VjhOdzBiUWQ0cjdKOGpnSzRR?=
 =?utf-8?B?dUdSV2tIVWZ1Qi9sSzJoaFE0QXNCZXU2Qkw3Z1dzbVdIQ1JwZURFRCtQbmZM?=
 =?utf-8?B?REVyQS9RdEpjK1E0alQrTEJERDRLY1dvUFBtOUFqY1RkOThURmk4Ui80bElj?=
 =?utf-8?B?V0tWZjlpUHFNNFZveFZYUjRSK3hqelIxS04vcWd1ckcyVDBQYVlIaE9QYmU3?=
 =?utf-8?B?TWJ1STJwcis0UXZNSlpxYkpScFBGd0pTd1lIbTloaXRUL1RLTVpyTnJCNnRh?=
 =?utf-8?B?bTdmREo5cEVPTkVRK1pQTGNaeVh2MFFaWC81UXZDeXZEVlM5UElyZURlWWpo?=
 =?utf-8?B?Nlp2ems3RXVuWGxDcm9oVFp5b0hMQkRzU2YrNzVDM2p1NFlvQi9PSXh2ejJN?=
 =?utf-8?B?NURBWUlORWltU2xjczhSV05uc2JURXFHNWtFekZSQ0R3SFpMdlViYzE3OS81?=
 =?utf-8?B?SU9IYlBYSjY1K3F4NXBTZW14djFrQ2VEM3VJYitVK1BvbVVjZ0wwWG9rZVBZ?=
 =?utf-8?B?RStlRjNGRituejBXQncyeDdhWjVJRTUrNm1pVVYvVU1UM2ljZ2ZSMTBRMEhm?=
 =?utf-8?B?Ri9ZRDRQMDIvK2g3Wm1yN1luRE9RZmNwM2JCK3FiTjBrbUh0QjgrR3UzQVhO?=
 =?utf-8?B?VFkwK2didXVjV1dFcEVudFprQXNBV2dmNTBkM2tuM2hmVU9BeG5sM3FBZGcx?=
 =?utf-8?B?N0ZvSk9lWEtqVmdsVEJhZmtMazdYQ0o2ekoxc0tmS3c3bGJqblZ0QkRQTHlo?=
 =?utf-8?B?blpyVE1PM1FhRXc5bzNnaGNVbXFTb0JRTnFGTU9PQ2xxVFJhU1MyQUhQUW1I?=
 =?utf-8?B?bzFIWjhDK1J3RGR5MEs2M3NkZmwrNUhjVWY1Z1VONk5JVHJ1OGtpZFNUOGd1?=
 =?utf-8?B?bkFhcldxV0hoVENQTVVrbFBWd0Z1M1ZUek8vblJJTEZjdUZnemVxMzdoWUY2?=
 =?utf-8?B?aHVzbnNDTWhMZ3FvY0lmUFNkeTlCd3pBVDNmRy9WYWxlSG5zOEpvZTlpeDlo?=
 =?utf-8?B?MURFZDlpRU13dHltTnFzNlBOdUhNczdkK2QzeDNoeWRONGE3VG9jWlpoS0Nw?=
 =?utf-8?B?SlcwUXMzbU43VGNxQzBXOFg2SE5ScGVBaGZvM015NUZBWHY4UlpyMUxkVUdv?=
 =?utf-8?B?djNoRXVBQW9qQ1U5UU9GT2FKV2xpUXNMWDA0UnFaLzFRV3g1QzRlSk1qNzYz?=
 =?utf-8?B?Wmx3Wi81cHE0dUNrMDRRLzAvUnltY2x2dUlaNzZhZVBqT0ZkeHRZQ0NENnpp?=
 =?utf-8?B?cURrNlJmU29Vd0hjY3IrMHF1WjBTbGJUM2hLSlBkNy9vQzBLOHQrUnRJZy9K?=
 =?utf-8?B?VjJoU3hxU0hYM082QnJBMG12aHZBcGFucExHU3ByT214c2hENEs1T05oaWYv?=
 =?utf-8?B?bUpSc3A0RnJGbDRiS2NlVndOKzRuTGFuU21keWFKWnEvUU04Tmx1bERXVGtS?=
 =?utf-8?B?OWNDUExlWkJFWmF2MWF4QVIrVXRIZUJpNXRsT1lxM1hiUjJuTVd6V2xNWDVz?=
 =?utf-8?B?bTI1M2JXbTFFZEpoeHVzV2dOSVBHQUZoQWlnMU9JNFNQazhxUW5vOXg5aGJV?=
 =?utf-8?B?VWJoZjNZN2xLVkJEUGFkSmt2RTI5SFk2aW9aZ1EzLzhUT2Nib1NnQmV6SVBE?=
 =?utf-8?B?YzBZNVNsaHBZTng4U2FmZjJMWjEzb1NTRnkxYkhOdXFZaEdJcWsvRUo3NDhj?=
 =?utf-8?B?c0tUK0RtenpoeDhoUVpyck5kZlB5RzJRL09ROC8wVEgySndNTnRzNnZHR0E3?=
 =?utf-8?B?cVpLMDB5cFQ2Z2ZoSnRmWGhSK05ycWVtenN0eDZ3YnIrNnpEQXIrbEV1ZkYy?=
 =?utf-8?B?SkREMHd4UDNiTnRKaEIwOUdFSTErYUl0bG1kK3lEYlFsSGZyRXNwRnlXZmVE?=
 =?utf-8?B?YVEySEl2WktBc2E0M2tiTTFUOUw0QmNTVHpudlo2L1A5V01iTkVraGlFcXpm?=
 =?utf-8?B?UXFYSnkySTFDMWF0b1FWV1NtMEQ0bUYzQUhVQ3Vva0J3aVkxb1ovRGpvRjRw?=
 =?utf-8?B?UERldEZNWWpVeTZ0ZGIySTl4RVFUOTNZUHovMHY1QkNHRkNEZTRiNzN4bW1M?=
 =?utf-8?B?ajJvQlJqOXZhRXV2QmwybGYvUURndVJueGNYWkgzbTBqcDJJM29yOFRIN3Iz?=
 =?utf-8?Q?kJ+g9Y/8iY8T10oeLppu4zhV83+cHhj9akWjXPoFibDzU?=
X-MS-Exchange-AntiSpam-MessageData-1: nJp9N3FoQjX62NSkMil2gfwbXjxbwa+8B3lnd1ncMjmnO2xTvKec5/6r
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beeba1b9-6af4-4246-75a4-08dede3a2e6f
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 04:17:40.3002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WGID52xIqnH58e2b0mur1x/6sYOjPsDin59wxc9B45XBR+7iRXNS3avOXNFp3Gyt1zGervbHvR9LQrFbPG6wK+vBFcNbHXy2mXaJSarJP9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9031
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2026-07-10 00:07, Paul E. McKenney wrote:
> On Thu, Jul 09, 2026 at 10:56:51PM -0400, Mathieu Desnoyers wrote:
>> On 2026-07-09 22:53, Paul E. McKenney wrote:
>> [...]
>>>
>>>> And unfortunately, for me, tcmalloc is really not a viable option,
>>>> because it needs to own the RSEQ area registration, and because glibc
>>>> cannot use it at the same time as tcmalloc, my benchmarks suffer because
>>>> glibc has a slower sched_getcpu() implementation.
>>>>
>>>> So jemalloc it is. tcmalloc is not usable for me because they don't
>>>> compose with the rest of the world. I warned the tcmalloc developers
>>>> many times, but they did not listen. :-(
>>>
>>> So an alternative rseq for the rest of us?
>>
>> I'm not quite sure I understand. Since there is only one rseq
>> registration per thread, this means that tcmalloc require their
>> users to use a GLIBC tunable to disable rseq registration at the
>> libc level, leaving rseq solely to tcmalloc.
> 
> Could an independent thing very closely resembling rseq be brought into
> being alongside the current rseq, so that tcmalloc gets the existing
> one and everyone else plays nice and shares the new one?

That would unfortunately roll the clock backward about 5 years in terms
of glibc integration, which supports rseq out of the box since version
2.35 (Feb 2022).

Moreover, if we add a second rseq area, this means the kernel now need
to have code to support both areas in key performance-critical code
areas (scheduler, interrupt entry/exit).

So no, as far as I am concerned, this is really not an option.

The "simpler" option would be to implement the rseq extension tcmalloc
need, so they can finally stop doing their odd games and become
compatible with the rest of the world. But the last time I offered to
help them on this front I've been told that they would not even have
time to try my patches.

Oh well.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
