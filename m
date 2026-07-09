Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB05C43458
	for <lttng-dev@archiver.kernel.org>; Thu,  9 Jul 2026 22:02:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gx87r755Kz29Vv
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1783634521;
	b=g2oJEYcKnkub+jaf/fi6P/koVV/rMDT75O5XMMIOXr+kk0tWpOiVyM4og0dfnMr53KE4
	 XpWJLA/IT6keVtswBDr3uyeYCFJuo95POhKlWbxjNEgo6HBc+gcK06JBpnEy/RN8saF7Y
	 VQGckSgP7hS7H9D+aL5kXWi0eKHyY4O199un8qH0b+JEWPyiFCttqj9WAwiuIBj3T048y
	 1isAFJciIYmw/xspxMTZDasWUCQfLHuxY+6ZfyHnaaF7eESTVXFOwBPVsdArOu4m7GlXN
	 RqBt4hYOm3ZvnBZ62oxX3Hxv5CHBLe5H05KjDKwfjegAW3sdVUkGZeObl2I+wISQFuA==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1783634521;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=UG4ibcSM5GUbFEtL2BxPeWG1nvx7LXRUkZh3JkiMPXs=;
	b=PkzHkVgbshAI3WjITKgzM6qJ68EkLrzLPWbTKcIBQ6lJaVD4rLWeI4P0vgt+Vk9fnRK0
	 VyLuKVRt/w8wg4qEcktFCZpEAfKx+6COj48ALgGBXyQTis6mEYE+g15p/Tv6CWAsB47S6
	 1ZdPhhBBk0sHfcHuK5OBmRZUeTzEM2Dp1Zwt2XA+2/+ukAKbqc4fC+aM7dcHd5Lupvioz
	 73JGY0xvQ40ye2q1B3hthOlvI47mes3FZt5QOEdEeUvfuOrMeSIYWZMXJ1tKrG2S50v0c
	 n5Tp+oR1rg1RkjntjS15jPgvAxJyP8kuIaIyVLqY3w4PFVGTQb10SMNLt+B1cFGZ5yw==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gx87r755Kz29Vv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1783634521;
	bh=jv7WM2STHseRyT+LYBCjkjcLDU6mWe+yhS9LTeVU3PE=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=bAbqQwkZjBDBf9pRgLABy3KKFl8iws7KfqKkL75+eXCMBPgYy9et3htvkGP7lWTBO
	 bc+G6fTYqqcwDuE3EsgubkSUJ+uyvZDGj+K7tTC6x5oyHrTUVj81GYi2ewU9uL288+
	 gzPGWs4clNtB82XYuxhmQAJyDIImX6bVPuLIhiq9s5Nn1RTpCfqi/oGKIDsw4UF7U2
	 1SqvnvuYxY4914aItIiLwwsTQf3zE6ynaisHMPWDkDwof5nlvsJNsoFV4Xvk8qhMPv
	 YA/gJeIP4vT+8u8ME3E9nVUwMZGv6Abqn2calr8qQymIOj07s5mvOONw2vVIDSvqS9
	 gxQBHo3HVJDug==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4gx87r755Kz29Vv;
	Thu,  9 Jul 2026 18:02:00 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gx87r2kYPz292h
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gx87r2kYPz292h
Received: from YT6PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazon11022088.outbound.protection.outlook.com
 [40.107.193.88])
 by lists.lttng.org (Postfix) with ESMTPS id 4gx87r2kYPz292h
 for <lttng-dev@lists.lttng.org>; Thu,  9 Jul 2026 18:02:00 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+VDJqpAA7wLCTfx3trvT4/DSBFYIf7+LkwBpZ2zQOpBTrBEwBndN64GQx9vxMUA4s1gV/7kaU9GnL5fMXLKJ8CW/zLl6Pem5kesh53aysCl6GZEIhsO62doLJgDCTisC6AGDUwqY2l3k1GSh1MFQcBy0S01Bkic+hNlEhLyYHfEitagGgtvrt5ZFs443IGkuWcSCkCbFaOhBRWp+4l1yhMjT94+SxMMF6vE0vmM2Wx4v+QQ3PmeXGHtmaXbF9Sr3CgSx8oHNmhfWVvJjOHBWENIL0aTv3v4zfGOOn4/wd/GOtkPoFpXoWmxQA2aY2f45fuaGK2sd/3BsfYT+el5TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jv7WM2STHseRyT+LYBCjkjcLDU6mWe+yhS9LTeVU3PE=;
 b=bCzz4eizPSx07x0/cz39W5PkHCSqP4jqg6z16MmWZcnYiJwSVB6VwxCmfEae2VFVCxkwV7fP+YpSxuTdmSmJE2camQJJp8+EXTvfI5y/9FajVWztMerkGnlQblW88XIXVFrca4kDFfZqXCbpb+Nng7PF3pDFiNslmN7hDGSBzcuaLTMwpZk04z1CxZAp3h48RveUKmJxevV9Nvtf1Bb95DxYxcW99RFg+eH+W7Sd79H4n+Xlm5ipgUFdyQeox3MUt3dViFGtvzFkI6UVy3kZdFqc1NIi5GYwjur5srsTx/3OO6FBQGwYc1SZD8Zm9oPC3wUR0fUJGnbR/M3ejqm3Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB9979.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:8f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 22:01:55 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 22:01:55 +0000
Message-ID: <38f1f93e-3bfa-425a-96d9-3035c8ecc785@efficios.com>
Date: Thu, 9 Jul 2026 18:01:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: CPU affinity behavior of liburcu call-rcu per-cpu worker threads
To: paulmck@kernel.org
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Olivier Dion <odion@efficios.com>
References: <e8fa9744-74d2-4fae-8684-f1df59aec1c0@efficios.com>
 <0600b601-3edf-4897-b319-b4763943809c@efficios.com>
 <3573944e-3abc-48d7-aedf-3362ebd7ebe4@paulmck-laptop>
Content-Language: en-US
In-Reply-To: <3573944e-3abc-48d7-aedf-3362ebd7ebe4@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::25) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB9979:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ce4f3a-b9f3-4ce7-81bc-08dede05b056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10070799003|22082099003|18002099003|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 6kkHDBkiZlbGdgTJD/tu8zuXqjhyZCmxJ4JlaJrHIKpHCe5BhYTyq38LRpE9rmNEFT3gVyNkWgK+sPsedDGFUpD65aQbRhE1WQl0gF0erFMQHX7lH0OoU4vEpAHHBUhw/XeeaxGXSSw7Llo2B4eCMhHLJ+emnCFfWCxNs5feBnteJx4XZbeSmbfK2OPglTeAgFQrSBYuTlY9OxQ57BvS2z9ogjFxdsOPiJLs2wxu1QAMjcsyE0+7Dm3hbJe1VjIUf6jAmfZTg5+QA5OlJPnYLezB3Iy7c7YVAJ3KFcLPGOUahxqEQF52DFbN7L0j4K4X6Wt3gNAOtDq8RbqUoKGk8stCmFuBTc+kkS49Ryq2eN4rSJqc+ZptOHI04zh0EIQ8nkN0tcsq9jXMH1yn5gs5KcHT/GKkroNo8kcf15ZejEeTm7tDMF5AyOfs24k7LGHtlI7UsDhOYICDvMNIL8ZvB4GgkhSq2SAeRdOUUjPeWnIHgTpASjDiUf4kQvkoZ4zFw2fIa+ITRq1cRZzH7ScjQ3oO0f7/sgz9NeEi/tnyaRwKHPhruZqu7LqOLC3N85+0fxRk8ldF/RxJqT9wEv902gzamC8T9BUKMcIzfmlxezQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10070799003)(22082099003)(18002099003)(4143699003)(56012099006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anpkeHBpeWdRbzVtYnRiTjlVSkpTRW1BaERhTzBzQThlK1BCQlNEZytycnlR?=
 =?utf-8?B?T3VLZld3NWhBN1JGaXRTdDZwSW5GU3g3TU00YjRQZ3VEMCtNR2sxNit1VVVh?=
 =?utf-8?B?SFk3QUJGTjlBa3psaEVKK1J4UFBTaEFFZVVNR3FJMlZnOFdpUGdLUnB6MnJz?=
 =?utf-8?B?Qy9KRWFDSEtRcVJkekRuZm9CR2c3T2VsN1VUQXc4ZkhoNGVlNk1Ec0kzU212?=
 =?utf-8?B?YVU5b2J3UnBmSDBid2JPU21vWlR4cDNLTGNzK2dDVldwYTJ0cis1VGgrWWg4?=
 =?utf-8?B?MGR3Wk1hcHhnTDRyS2xFMzVSbjkzeWJ2WWhrMDdkMTg5dFJZNERYSTRwaUho?=
 =?utf-8?B?Vll5bU83TjhXRytlSzZ1Sy9yZmVZZVZCL2ZMVGdFWFRuSVhBaFBTTEVNRGRP?=
 =?utf-8?B?RWJseU9PZVpTS0xCU1NkTXc5YnR5VDBvTkJZNWRQWCs3RE5sK01PRGVzL0JP?=
 =?utf-8?B?blNpYU1tdHZQM3J2SE84WE1HWHJKMElFS3BnaGRZeXNZTFFkSjlybWp4dDM2?=
 =?utf-8?B?dXdhKzJHNGY1REgvQmN4djVlc296bktGTEZSUE1Kd0FCV25yMmszbjF2ZS8x?=
 =?utf-8?B?bEQ3TDM1T0NVTkQzRno4bWxSNGVRdCtZejJ6VWtYU1NOZVgrWk0xQVVJQnZY?=
 =?utf-8?B?ZHAwclV2ajRmbFVURWJLdTlCTDlTRSsxSW5JWFdGdXUwVFJpOHJBVEg5Rzcv?=
 =?utf-8?B?L0ZpZTJnVkJlZjFZdFo4NlVmS2pQS2FhR1BORmljU25PU1c2aTBkQUpyR1VQ?=
 =?utf-8?B?Y3J4azJzZ2xCYURab085bTdNSTNkbzlibkhTNkdOZkRxSFlBWE5KUUZ6VDBm?=
 =?utf-8?B?Ynpxa2IrSnN2T1VGamxIc1MxTS9xLzdGMXpmbXNXNXoxaU54d2tMb0d0ZE15?=
 =?utf-8?B?OWVlY0hZVTBYd3Z2RHdoQ2xlbjlUVEFIbkFTamV6cURHRmFjMHZPbzRHZ2FB?=
 =?utf-8?B?aFIxSEU1MGVQSEZ6UEZLRko5VW43azJLRGg4QlFGNFJlYkJ5enNENTdyZlFa?=
 =?utf-8?B?bjE0c3hmbU1zTUk3ZGV3Q2hDTGNEQ201SUhXQzhSam5ObTN4RmUwbWFDdXNS?=
 =?utf-8?B?VGZNUWxtN1laa3ArbkZpMjFPVWp6UXUwQ1pGSThyaGpXYkxnV3BTR0llWThL?=
 =?utf-8?B?MEVtY2lsUkNmVTd0ZUpGd0lZTHk2ZEtKQittTHlraXliVWoraDJ3VUt1SUxI?=
 =?utf-8?B?bk5ReHZIdm9kZ3RjcTZ5TGNxQlRHTnBYVHpNejNDREVkODZ0YWV1cHBzZ2Zx?=
 =?utf-8?B?RGhGdERGMCtheUFjK21USjV4Z1NWVWRJZGs5V0dlL0ZiSlR0Vi9KajZDVGpC?=
 =?utf-8?B?VW8zNUJvYTFFdUR5SWhUK0JCVzZsWSsyYlVYdmQ3RGQyUjMyZW4vZG8xdkk5?=
 =?utf-8?B?dWQzWDVTblZkbTd3VmQvWnNoU2prSDB4Y2VmQU5qd1VzSGVoUDZNVHV0VnlT?=
 =?utf-8?B?QWhQREZSY1dYY09QUUlibllnWC8wbkt5dlZGaGRnVzFramVsaXYwYjRLOW5N?=
 =?utf-8?B?bkNmYldmM1FxQkFmQ1ZUbDRDd215ckNlV0s3Zk83dHZJQ0VINzlwOGRPUXpR?=
 =?utf-8?B?RFpBTFVlNmpSN1V5R0JMdDc3clE4RGNQNEZoa3Z3NVNlT0FSWUZxc1l5Ym00?=
 =?utf-8?B?UHdvUmsyUmpDNmtoZVp3d0lDZDRSbWk3VEdyZm5rWDBnQ1hobGlGNHV5Mkdr?=
 =?utf-8?B?S1FtMHlPOVFEU2xaR1hXc0h6ZXQ3Ty9ZS1ErbnJZTGFBRnAvdnRpRmNKYjVy?=
 =?utf-8?B?emRjMlVoV0YybnRLcVo2NXdybEhwMG1lQkdIUm1qaVRXNWdSTmo2Unk2L0tG?=
 =?utf-8?B?MDk1Wnc4elFEZFlITnR2a0dqRTNZZ0VScENxZS82bFI1WmtWREVPOFlyNnFo?=
 =?utf-8?B?WnZ5SWFHNVV0dXhITm1Id0xLQ3pjWm9XSUo0L2tJZDYrWTFjczRBRWZPWFFG?=
 =?utf-8?B?TkpoMFQ4dG1mRmhhMGxKNU1ZN0srdUJqYy9qbkU5OElQaC96dUtPdi9jbGxh?=
 =?utf-8?B?ZXRBY0poYVI0c3lQVTdzaTMxdk1abTFDRlpySkFuMVpZNUZoMWhYcEpmSlly?=
 =?utf-8?B?OXNUR0ppK3RMY3NxOGFaRVI2V05IVU1zWmU5bW5ySUZtamFDMHdNMXc1bWJV?=
 =?utf-8?B?MkZkWm8wK01QMHB5U2ZZU0Z3SW52QkdJU2Z3Q2xWc3R1WWRDV0VpbVdENTEy?=
 =?utf-8?B?VzZpSGw4cXVrdmk0UHFNamZJQXd4SGF4TUVCeCt0T3o4VkhXK3JvajJ0TGZh?=
 =?utf-8?B?NHF0UVAwOGRCanlmT2xMNzA5QnJ6ZXBKcmYwSDJnRU4vL2xDQW5ZWDFTQktv?=
 =?utf-8?B?Y1FHVVhWSjRzQzYvbnJ6TjNhMmY2M2tOdU1lMWVFSzY5cFdicVJJT2p1eUFp?=
 =?utf-8?Q?/TG57RmFHq7PYCtaKpwb+yUEKtUigUswnxcUotfOsgGUf?=
X-MS-Exchange-AntiSpam-MessageData-1: Iv8CB4YnaEW18EKUeNsnkl9pWSgW89hd+L4=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ce4f3a-b9f3-4ce7-81bc-08dede05b056
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 22:01:54.9195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /MvuNbCT6Wew9lswyzx724cwCKi0U+ZLEvoMGoVRc5Ac8jE9ImYPu31a8t7NomEnSlhb6Yfkoul0h9WM65Ca6uq2UCVcT6oCi++8wbMvfXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9979
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

On 2026-07-09 17:45, Paul E. McKenney wrote:
> On Thu, Jul 09, 2026 at 04:00:17PM -0400, Mathieu Desnoyers wrote:
>> On 2026-07-09 14:48, Mathieu Desnoyers wrote:
>>> Hi Paul,
>>>
>>> I have a question related to liburcu per-cpu call-rcu worker threads.
>>>
>>> So far in the current liburcu releases no affinity is set when the
>>> worker threads are started. We have to wait for
>>> SET_AFFINITY_CHECK_PERIOD_MASK grace periods before the affinity is set
>>> (it takes about 2.5s in my benchmarks).
>>>
>>> This means that short-lived test programs will get poor CPU affinity
>>> for call-rcu worker threads at the beginning of their lifetime. So for
>>> short lived programs, this means poor performance.
>>>
>>> OTOH, if we have short-lived applications on a large machine, setting
>>> the affinity immediately when the worker thread is starting means
>>> we use CPU time on CPUs which may never be actually used by the
>>> application (no call-rcu activity), which can be detrimental to other
>>> use-cases as well.
>>>
>>> So I was wondering: is the choice of skipping setting the affinity
>>> on call-rcu worker thread startup done on purpose ? And if so,
>>> should we perhaps consider setting the affinity as soon as the
>>> worker thread is woken up for the first time rather than after
>>> SET_AFFINITY_CHECK_PERIOD_MASK grace periods ?
> 
> My approach when I first implemented call_rcu() was that the typical
> application would have lots of reads and very few updates, so the
> default was a single call_rcu() thread shared by all worker threads.
> I allowed for manual configuration and affinity of call_rcu() threads
> for special-case high-update-rate applications.

I'm currently working on data structures supporting scalable updates,
which highlight a broader need for per-cpu call-rcu worker threads
(at least if update scalability is wanted).

> My hope was that we would be able to use per-CPU call_rcu() threads
> with something like rseq allowing the worker threads to move around
> arbitrarily but still getting good cache affinity in their interactions
> with the call_rcu() threads.  Easy to say, I know!  ;-)

Having a call-rcu worker thread moving around and sitting on a different
node than the call-rcu users on a big NUMA box is somewhat detrimental
to performance unfortunately.

The telltale sign of this behavior (which got fixed by pinning call-rcu
workers early) was that benchmark results were mostly binomial (high
variance, some slower, some faster). Those benchmarks happened to run
many 2s instances of processes, all falling within the missing affinity
window.

> 
>> I've implemented this compromise approach here:
>>
>> https://review.lttng.org/c/userspace-rcu/+/18257 call-rcu worker: set CPU affinity on first non-empty dequeue
> 
> The idea being that the call_rcu() thread checks its partner and uses
> explicit affinity to follow it around?

Actually, the per-cpu call-rcu worker thread already has all the cpu
affinity information it needs. It's handed over at creation. It's just
that it applies it rather late (after ~2.5s), and only if it happens
to be running on the "wrong" CPU at that particular moment.

Those two factors are not really great for benchmark reproducibility.

> 
> I am reminded of a DYNIX/ptx feature that allowed you to say that a
> pair of userspace threads were related, so that they should be migrated
> together.  This idea did not go over well during the initial Linux-kernel
> scheduler discussions a quarter century back.  ;-)

I don't really need to have the call-rcu worker related to specific
tasks, but I do care that it's local to (at least) a core. I have a
high-churn workload which quickly recycles per-cpu slab memory, and
in order to get good performance with it I need:

- Per-cpu slab cache,
- Per-cpu (or at least per core) call-rcu worker threads,

Which keeps all the alloc -> call-rcu -> worker -> free churn local
to a CPU.

The task pairing you hint at would be great for the per-thread
call-rcu workers we support in liburcu, but as you say it's easier
said than done.

Another approach which would be interesting to look into is to
somehow attach the call-rcu workers to rseq mm_cid concurrency
ids.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
