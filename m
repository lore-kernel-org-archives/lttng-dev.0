Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D616C43458
	for <lttng-dev@archiver.kernel.org>; Thu,  9 Jul 2026 23:31:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gxB713FBNz2B92
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1783639885;
	b=eOubAQAPNfENm763A3jH7nzQ3hvQhpdStQQWiweRfnPkyR5azh46jtIwDEhr40rtW4eE
	 kPFkbTZtM/wQwBl1JXhehh0M3e2jkEetFiso1zlr7abhkaN9amvGvIOnAdAy6Uc45f7sh
	 8DHOC3Nd7QGM2gCioxFLEiIdqMs7yBTjR4ry2fwr1NpWmNulPr7eqJHUWUlE4pK0zObt/
	 TNK6zeM3gGvF/vyrtD6yFSYnhKFeseshyFeJhJ66EvGcsm8KHCq7oaUDgJoLr7dwgQXG5
	 y8BlkFt7RpVkV774bisPk+t37u8spBPz3MvKSgArudBWqK5yd1tqGrRevgVq58xfDvw==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1783639885;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=1vS/7vQhJ9UohYcUIyQLE/C4opOU2Ir3bDPCURT0u54=;
	b=NivRbrHh8sCG5jE18dwbmy9c0mhQ8dLa6yfiC+ExCUCDEKIfoP37ClxNQVsstQWwGh9H
	 RSQ2I6LIW5ww020N3hqBu1RD0a9dQ9SDD2gTw4ggrOEf+YJ6H3VBQHq/UNLfu4WnvT9f6
	 dEcQDzvR+Ur0/NUt8+fUjFzBOsUfNBKrFcufTSzlB6hgB2Lg9g+rWiOJ5miWjiNZXTpj7
	 Ccm64bzLKTadBvxeuEwdQJvLtAJsWsr8R3VwxGYUpMYZmf1+UXB+ukGejTt1dn28e3yMf
	 s914RQ+4MyN6rkcD5atAi1j1nJoENJK9tHUWcBmDXLuWGBuvLax5nAy5nxcpnGNiNWQ==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gxB713FBNz2B92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1783639885;
	bh=FkqqOrFxSOhPWk8Cp7CM2T5pFN91UwcNSnLTKcFTG6c=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ZeHnHZm9Accd98Ca9ihVQTj+ohY2BMk5LlbQtXVwqPWof2aVWLeD1nFocvP6/3/XV
	 u7yHE1MX3R0AFtXtssRCOG9iTpRKodxAGryzVwTAbLV5FKWGwCVJBqUOFGzbCfsajl
	 S0hXENJL7F4nnDmauaIcJxNvOgIjl90c6awbns3xKmuGwhno8L9BfGhFwLAeqF7VoP
	 zxzSnDDqC0Umtp9UeUCr+Lb9vWzjb8HGQhOI+rbX2OKv4TKjkJko3x2wJskZgtNLm9
	 q/dEE0r8V5l/nqA7uWgaeqbwaqobo6ELEj2zT1AiZYhNJlI4qS7fQroPABUckPe2fZ
	 peEzwy98BJm9Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4gxB713FBNz2B92;
	Thu,  9 Jul 2026 19:31:25 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gxB700bRRz2B2X
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gxB700bRRz2B2X
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c104::])
 by lists.lttng.org (Postfix) with ESMTPS id 4gxB700bRRz2B2X
 for <lttng-dev@lists.lttng.org>; Thu,  9 Jul 2026 19:31:23 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkNYLwyJwWHHH3tzDsxBCSoG/S0XZ4tK3dHj3E+2q95B3RWhCM57h9tmEQxKMasru3yuGcXS+Dxv9SP5rtgBZL2433uXjVdAOz6VVAoFmB/olxhHJgkWZD66Db6I8RQvjdYrwR03X66jLBE0QF0+mLBvnWGf6Zpxs1T5fsGXNvq305+aAcXbJqQSC79T4tX5JBfEUK0PiMzu5eOncbh30ttlWnBudh54tcZPkbayI6gjZ9OrLboVZz0qc549zTagXa69PB9vfLc0kM3FNli/VqlGjlkvZir+/t/WyJKy3Z6JJXgZytxQebbnweHE60wawQCcnBVi/PNct0uWICclpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkqqOrFxSOhPWk8Cp7CM2T5pFN91UwcNSnLTKcFTG6c=;
 b=VjApoxGv7Mqi0jxmLW73Bo6XxCgx7Q7hF4GoZ43B0q1zutaEdlMylqyomdLC6diIYb/xkBYNOsjXPwWCpk+Wfe17GJnvmJoXPb/EVaoH40k6cq8i0KgWxXSEK2gHtabhncXsHYxTOCbXTD3Sjvl5RulnCkmIoyWz6ke9soc1PNB/h6lv/4dBcm6MvU0z2JTSnu4kODOee2/JnuySrHNm+fQsyKcOdLOwP++lqBhS4xMuq36KKQ6T3cnMtjOcPlQ49nsnCEx5tooCLJTDxX5LWWRstjbvU404qBQ4Y9tYasBnxARjRnxueOtErqdp5d0PdADbb1DMl68Oyq/vFS7mAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT4PR01MB11947.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:169::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 23:31:19 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%4]) with mapi id 15.21.0181.017; Thu, 9 Jul 2026
 23:31:19 +0000
Message-ID: <a25cc916-2bb3-4133-afcb-230dd577726d@efficios.com>
Date: Thu, 9 Jul 2026 19:31:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: CPU affinity behavior of liburcu call-rcu per-cpu worker threads
To: paulmck@kernel.org
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Olivier Dion <odion@efficios.com>
References: <e8fa9744-74d2-4fae-8684-f1df59aec1c0@efficios.com>
 <0600b601-3edf-4897-b319-b4763943809c@efficios.com>
 <3573944e-3abc-48d7-aedf-3362ebd7ebe4@paulmck-laptop>
 <38f1f93e-3bfa-425a-96d9-3035c8ecc785@efficios.com>
 <1aaa979b-bad9-47a5-879b-b4fb2379ad20@paulmck-laptop>
Content-Language: en-US
In-Reply-To: <1aaa979b-bad9-47a5-879b-b4fb2379ad20@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::27) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT4PR01MB11947:EE_
X-MS-Office365-Filtering-Correlation-Id: f30f4f77-2f30-4703-e1a4-08dede122df9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|23010399003|376014|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ySL20Fd+0coK56ikKuo3J2MVProndCjDaTIANMKO/gv/1HRyE+xdGqSTly8JqB033D/gH+zuxkQPD8brTeDbu8if8SQQTBoQFszaRb/Fw7S6yJYSaW1DDIt6TdGl+qHAFo0OqamYyNd7/AX9ugOSy+rnckgyY8xwTeNXa23lqxh9yNBBAnPkZKZHe6FTS83ljMxYuzpHLidjVZMrZgoRsLbcl8X+xjKWSKapzm8pNZw8EwiqGr+u9Y/z91bzIOtn7mM98tiDgGxoLNaXie5V9zFFgXZguvVeMaLGlTxwxxzco9E0ez3q5J+J/fNfh4oQWc6+sUxno7jw48H8ivcgsuyztzJArUN16jq6H7ZtALwu1ohfbKgvTclDvEjD0KJDaGHMubI77klADERy6udfozIF68GNogjYs0MvqA1mxg7+B2Z4GIreptGvK2izphyK67Ye6mtmm583XjOpC2uzdW2jZu0XnXENov84ZPbxaj4w4nMu6YHTUTk9lHdKBnG10ZYjh9xkPNUQ1aYHyFPviPphSUcht7rC7w2ZJwmt66J3tSES17D6fjb66Mwrzw21y7eCVYcCoyzvndtbCBPARpMOX2H9iSnQpJMfQY2jrbM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(376014)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkhuUTBjTHVDang2dVd6YzN3bFdYdElvaVJjZnVFS0I5azk2ZU9oaS8zL2N4?=
 =?utf-8?B?UGtSbHRHSDdESDhUL25kUXozbnh6NE40TEluN1lHK0V5ZmRuQXVHa1E4Tktr?=
 =?utf-8?B?QzlNQkVIYW5ReUdSV3BvWTJKUDJvNU45N2JjZWJiZ0EvWFdKSFZ6S0V1Q2o0?=
 =?utf-8?B?cXZvMG9jVERWWFI0TFdra1gySXVYa2NvSTFFY2NBNnZWS2VpYlZDWUdpcDVF?=
 =?utf-8?B?UFVvV2l0OXdRaGhvclM1eXhhN285ZzVIajlLY2VBMXRVWVZQeXRDb24zV0p5?=
 =?utf-8?B?M3BGcWdkdUd0bktCOHMyMEFjTW9lWFh3bEV0Mk1NYmZQVnp0bTV4TEE0NlVm?=
 =?utf-8?B?QkZFZGlOMVg1cnNZbWRsYTUzMmFuQVJ6cnNpM1R4c3BESHdXa1BoeWtQQktZ?=
 =?utf-8?B?RmZpcmdDUUQzZ1dXRk5na216dE95QUwrYy8zbVJNRmpJUGtLbXVad1FObTZy?=
 =?utf-8?B?eTZUendvMlAyMldrYWFjS25vNElFVTliNnk4NU1RU0c1NjN4ZlpPLzFDS2FF?=
 =?utf-8?B?RDhJWTE2SDJoMW5YZnpBUWk5Q3RLZW9KWkFNKzcrOUprL2k0NGxmbnN6VTVR?=
 =?utf-8?B?WGtZSFBoMzk4WXU2MUVZdHZTMDMrRUFlTDNaSk8wTWJrcjhKckgxS0QvWHB0?=
 =?utf-8?B?K2FaK3hZWjhzZ0lWOGNLZENqcm1nVXV3S0JKdThPQnRnb3FpRXFFdHV1U2RO?=
 =?utf-8?B?d2tOa2FBMHJad2NDZEpqK2Y1Qk5DNVBMeHFwMFpaNWN0bkFQdFBBQ1UrdStF?=
 =?utf-8?B?eFVmMWhTR3lsYXBJS0lJblVvd2N6dDhSdVgyRG1tZjJxazZxR24xbGFJUHcr?=
 =?utf-8?B?WHhHcVByUnBsc29TNEdhZXBiL0h3Q1hQbG8xeXFIdGVtT0RIY3Zxd0NUVVdR?=
 =?utf-8?B?OHNUbTJnZlFaV2ZCMWxmTmdOdjIzS1ROLzIvbnZVV2RrRkFuNFJOanl6VUNS?=
 =?utf-8?B?akdJeGplSmNST2ZMR1hBZ1FGNTlnMG03RnpRdXJXUlNYaW9tRUx2R0RrSmc0?=
 =?utf-8?B?aEo5ajcxY09wQURINTl0bEFoY3pMM04rWmRib05nY1hVZGliTVlaUmdzcXNt?=
 =?utf-8?B?Ylo2empPUVZzYWxpWHREbWhWNEROd3BmV2ZsQUtuK3dvdnFuNnRqZS92N051?=
 =?utf-8?B?S3NINDlYVmRaUm1JQ05pWUJkeVpXeU9MSUsydzRIdDkrdk9leHRoUmU3N2NQ?=
 =?utf-8?B?UlZ1cHZZU25Zc0IwZ3BIeDUwTm1DUHBjOW1OQ3pLLyt0QnVvTTRyekh0bFlr?=
 =?utf-8?B?OEpHMzQ4MzVUcmFEV2llTWxQSUFsRERRaG0yZzZRYm1RR3ZmcklaWktiTHJk?=
 =?utf-8?B?U1RLN0F6S3JwRWh6SnJjeWdIR0xYa1d6VnFlWWJNV1UxbjdDWGR5bDcrNHd0?=
 =?utf-8?B?WGcxQkttaWVERjBTRHhmcTNYdVljekJQd09xQlFhMlQyVFFEMWdSMnQ5Z3R5?=
 =?utf-8?B?NWl0Z0w2K3NhUEgyYzYvbUNnZHA4NEthczd5YllxUDRmeWZGS3V0Q2JuSjNh?=
 =?utf-8?B?bS9IY2xSa2dXWXhNTTdubVNyRDdHTFBnRFloRUtlRHA4NVhrU0w4UVBJVUV4?=
 =?utf-8?B?WVZWODUwVFhVa1NkRGtzcHRZaTNKVkl6ZkpVK241N0c0bW5wUDF0cUduTjJk?=
 =?utf-8?B?Tk1FcEMyWU1VOWp0R3hEWUFKTlB2cklmLzlSN04wYnMxcEpDU0pRWWQrM1J4?=
 =?utf-8?B?YjVJNE5tTWxHN0MyeVB2R0JwMnFWZEdTL0d5bjNmR1kyckNKT2ZReVE5djdD?=
 =?utf-8?B?MlVpN1dGUXdWbXI1Uks2VEFjUjhYR0hjMUhqT2VXWG5jVVp6VGRzWUw0NGFr?=
 =?utf-8?B?RkM4VklIdlpGek1YYVB6aDBNNEdybFBSdG1rT2NhWkthMFp1bFVOaDhpaW9M?=
 =?utf-8?B?d29NdWczRVg0SGRpQ0F3bnBQeTBCbHNXd2xSVzlONktBVHFJQ1B2bGdteFZr?=
 =?utf-8?B?V2NyaGhJWWptRGhxT2VKVExTK1BhWkhnd091c0NjdzB1RU1QRlpOL1drd2N6?=
 =?utf-8?B?cXlxZU9uYVN3ZS83M0ZyL1VzR0d1OFJHTklLZXFCdzBmV09WdmlKd1pzczAv?=
 =?utf-8?B?QTFKRlVKdlhLV2VxRWpicjc0TnllZUlCVVVVT3lvSXBJWENGQUgzZkoyZlNQ?=
 =?utf-8?B?WW4rM2RMZGNOc0MxT3k3eW15enNtNmhENmI1bzV0VFBIMmIrTks1aWtBWjlI?=
 =?utf-8?B?ZnN4MjhUeTRGbjhaZ2lBbmYwMjBKZVNpNjBOaEZzYlBYbVgzNmp3RW15STlp?=
 =?utf-8?B?K3V5MmRSQWpiZ3NaN0pTNjdDSXMxR2V6cWZVM0didEs5K2tlakZsU2g3S1Bk?=
 =?utf-8?B?Sk16ci9KRmJqQXVxVTI2b1JxL0FISzdMdVBQRUVibzZSZEwrS0FvMlEzcUtJ?=
 =?utf-8?Q?cJMZ8RI63F5VAmD9Ohd6Az7gscRD344dtDJxXg/bH7rH1?=
X-MS-Exchange-AntiSpam-MessageData-1: at7/4V4eX4GuKLKthDW4WpGd7cUlCRL4cU0=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30f4f77-2f30-4703-e1a4-08dede122df9
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 23:31:19.6717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6uGwrBkgwNHfTmnUmhNEbWmPYr2Y/jCzZTFNtbcIujdzaKv8DGo3eaP0JySk4fZS5RsOP0W+03JBYFHTdbEiQNPqSaVSW7oWS8JzI4TyHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB11947
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

On 2026-07-09 19:13, Paul E. McKenney wrote:
[...]

>>> I am reminded of a DYNIX/ptx feature that allowed you to say that a
>>> pair of userspace threads were related, so that they should be migrated
>>> together.  This idea did not go over well during the initial Linux-kernel
>>> scheduler discussions a quarter century back.  ;-)
>>
>> I don't really need to have the call-rcu worker related to specific
>> tasks, but I do care that it's local to (at least) a core. I have a
>> high-churn workload which quickly recycles per-cpu slab memory, and
>> in order to get good performance with it I need:
>>
>> - Per-cpu slab cache,
>> - Per-cpu (or at least per core) call-rcu worker threads,
>>
>> Which keeps all the alloc -> call-rcu -> worker -> free churn local
>> to a CPU.
> 
> So tcmalloc()?  And extensions to rseq to allow something else to use
> it concurrently.  Or modifications to tcmalloc() to play nicely.  :-/

I created my own per-cpu "cache" with a wfstack list in a liburcu
feature branch. It works with all allocators :)

And unfortunately, for me, tcmalloc is really not a viable option,
because it needs to own the RSEQ area registration, and because glibc
cannot use it at the same time as tcmalloc, my benchmarks suffer because
glibc has a slower sched_getcpu() implementation.

So jemalloc it is. tcmalloc is not usable for me because they don't
compose with the rest of the world. I warned the tcmalloc developers
many times, but they did not listen. :-(

> 
>> The task pairing you hint at would be great for the per-thread
>> call-rcu workers we support in liburcu, but as you say it's easier
>> said than done.
> 
> It worked great in DYNIX/ptx!  Which was admittedly way simpler than
> Linux currently is.  ;-)
> 
>> Another approach which would be interesting to look into is to
>> somehow attach the call-rcu workers to rseq mm_cid concurrency
>> ids.
> 
> So that a given invocation of call_rcu() queues to the current CPU's
> call_rcu() worker thread?  That sounds like a way to obtain what I was
> asking for above.  As you said, easier said than done.

Yes, the advantage is that you would only need to keep around one call
rcu worker thread per _concurrently used_ cpu, rather than per-possible
CPUs. And you would have one call-rcu list per concurrency ID.

Currently the max number for concurrency ids in a process is limited by
min(nr_threads, hweight(affinity mask)).

And I still have future plans to implement a cgroup cpu.max.concurrency
file, but I did not get there yet.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
