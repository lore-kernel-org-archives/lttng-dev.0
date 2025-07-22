Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31AAC83F1A
	for <lttng-dev@archiver.kernel.org>; Tue, 22 Jul 2025 13:58:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bmf4Q6wklz1Xyy
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1753192713;
	b=kZv8ex7gXykXzoTq7f2gl3NsbuWfGvef8x8nnzIc55QgfjyiBFnc+IfGacSKyuw8IYZB
	 fxAJIBUkJG2q7Tohw8f1i34QbBXTVZ0aGPWrV8oOBx8E8ceRn9vMUHi3OYPX3gryjHM9j
	 sO6CJ8hBg0KA3zRld6J0pHCDegeDYgj6lhXcesqSVq/N9vdoKkETeqkvlzBxAnrT21om+
	 n7Hicrm1NjFSuxKcOE0lKzcAA/ocJ1t8xoxVdz3iYZyzq408FdWVx8xDsOUSpkAXZnW8F
	 Ing5HVGtP7oPAP+eBejl7VJZuT5QvpjueG39kBqN6blfNV8n2C9LsQtkiadNpeq+EIw==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1753192713;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=ip0ZF6rKnOFnb9RqY/samZUmJG7T3bOz7eisdTttWsc=;
	b=Uh683SEfC8141qTP5UJG4UHvszFjHrCHOXjcwL07Akl1+uYPbpFHx3AHTFUnE/V+n3DW
	 YvouDi1I1dg1C1mYxmdn+krj+DC33NYdRsiKqSPkSdx6DMALoNA2engLku01fzt506TLs
	 jqUMgQOgXYKhz3E4HNiKhrVf3FmYswtdudSphCrS+GpTv1GBYggYvRbYjxOfkBLU0rHIW
	 8eILlHc8aBOyMwz/yMaqTAIrUgl7JKBYxvKTiLOPIOcoyezf664LuH/yhTBFqR2uYnDxV
	 lpysgz7+b6r313ADKQGlpejeUm6s0WFU/UKiDxzd7jNk3SS6kJ5BEdXhcK0Ko6+xghg==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bmf4Q6wklz1Xyy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1753192713;
	bh=ip0ZF6rKnOFnb9RqY/samZUmJG7T3bOz7eisdTttWsc=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=ZE/Yz51jzj99DklWOwq4sQyM7e9P+MIiLpuEEN8YJZyasrowG/vCBsa7EJfDEHW7W
	 ltZlyUrjtB0/69j+rhsxeYJJbKXqeSHJo0ir3rjFK/iXYK+7ina/ns30+PLpO4hge5
	 cj8OZMZ4qttZlQqvm5OQu5cwIdDknj9IHqKL5jEVn7OY86Z9BnNdY3uOaJyBZ4WzcV
	 cHDlGuNuoobK28dxywYsUSsYqGC13/fNg02Tk1SRRMJZnilZrpi2KmjipRvU1FAq57
	 sVm7K2M/jxsMrvWH0bAU7Lf0eJxgDbHzzF/ykIWvzRZhmGFzmpt+Jhq1IKGVeW2sjW
	 J1NTpw7ctGm6w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bmf4Q6wklz1Xyy;
	Tue, 22 Jul 2025 09:58:30 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bmf4N53Ynz1Xyw
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bmf4N53Ynz1Xyw
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2099.outbound.protection.outlook.com [40.107.115.99])
 by lists.lttng.org (Postfix) with ESMTPS id 4bmf4N53Ynz1Xyw
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jul 2025 09:58:28 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQh2uWVZUbwuwqF0Uv4stK5XIt+lkcjp0f+/cpZNS13HgBVnsImG7Z4wQFtvkNCXEkhVt6yDpvrbsZOe6Qtv4TKlTPEace2TEgfZroaKncF6+/Oiytgkd3nFO/NAUE19MUHTsyZKNhSW9G1SksvKltL+iNLCxdJ1gmwxZFZybkStijCqnW0/FNGxpphPuIzUjTsURCjh0c2VQe70NrE/xIDAhG2h1Jflcg9MXlfjkChjyXUHMMM6UAu88jy3lUy/lvSlSEXK874ll75H50IJjScexhYFu7kYSWm4RCM8j8D2lr3fOkmWleH2VykGDEhZSEGCAi+u6WBNL6dzwCXArQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsXsigtwH0VDVqG75dNUgn5lUZyxvqBAfH5M6zQt1kk=;
 b=oGPD0d0WC6edAvdtwKbhLfKQTDwAS0CnsEUdsLlpn+nHGBm5qGAl2NIHYaBxUfIq9H26v3h7NxJUxEw+TI+7c+tN65ECB05wywUkNfwwEM8uTINPKoz+eXJYvW+0b+RtYmcrCV5mdTY79f6RpXkOlRxW3C7OTI/U08lp87QTYeNlpAhTKr2Ug9lkuEtiaSkOOpHBhWa7/X5GHIF8nUWvmqKDiCtrL9TVbIszYCqFfmrOKdiYlLlIJRljkBIKziO/x2NZZwtFt5a61vPv3vQA1cAatKAQFc+1UeERskqVkkHInItVUEz7YUht1X42c8GaId9M0UcGS35pKgc/skeOPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from QB1PR01MB2353.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:35::26)
 by YT3PR01MB9738.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:8a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 13:58:23 +0000
Received: from QB1PR01MB2353.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::2e56:55d7:d22d:5de2]) by QB1PR01MB2353.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::2e56:55d7:d22d:5de2%5]) with mapi id 15.20.8964.019; Tue, 22 Jul 2025
 13:58:22 +0000
Message-ID: <545d23d6-c9fe-4428-96c6-9a323e2d333b@efficios.com>
Date: Tue, 22 Jul 2025 09:58:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: tests/regression/tools/clear/test_ust fails occacionally
To: "Yu, Mingli" <mingli.yu@windriver.com>, lttng-dev@lists.lttng.org
References: <5fd7be0d-a6dd-49c1-b59b-34735e69b1f6@windriver.com>
 <d3c56122-9c05-42fa-9d76-b32aa5f7a6fb@windriver.com>
Content-Language: en-US
In-Reply-To: <d3c56122-9c05-42fa-9d76-b32aa5f7a6fb@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0131.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::34) To QB1PR01MB2353.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:35::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: QB1PR01MB2353:EE_|YT3PR01MB9738:EE_
X-MS-Office365-Filtering-Correlation-Id: f471124e-792d-4755-9abf-08ddc927d219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTFxVG1tUEdIWDQzRE1UWDZvVW9Zalh0Y3BHaGdoT093VkJYbGovMjEzMmpx?=
 =?utf-8?B?ZTY0SG15TEZ1VmMzQ3g2a05iUmpTMW50dURNbmkxN3FYT2JXK1U2QWZNdGZa?=
 =?utf-8?B?bFZyd3VtN3VzaXVQeFJWOElrSGZWeEV4R1N0QmhhVDJEVVJjaE53VmwyTklE?=
 =?utf-8?B?ZklYRnJnV042UXI3V3pERi85M0dXQUdFMmZmd3EzdU0yU045WjZXZFJEbzBT?=
 =?utf-8?B?cTBXa2c4Q1ZrUm9TOGI5b05OQzFZWWplODYvQWtGMjVMRUpIeENlV2NxaXJ5?=
 =?utf-8?B?NEhtalhNc1daeGhLdnB4QmpVbFNFdUYrWitpUUhwMWhQYjNaWmdDKzQ5Sk1u?=
 =?utf-8?B?RVhDdkEvY1VkclVwQTBKajI0elNVaGpUQXhZRFNOdHdTT3VGVGFpZFROTjNk?=
 =?utf-8?B?eDNHd0N6amNSeDdhVEgwcm5KTmkyV2lyK1pZcEcza0ErQXdJK3ZIRU1XbXlH?=
 =?utf-8?B?UzM3TzNEUnQyaTBIeWNwSU9sMkhoVmMxNEVlTFJ6RmhmVHJFTFlidHRkeHJB?=
 =?utf-8?B?Qkx0N1R3dmRidjFOWGVMQ1JBRFc2bEZYbGVqS3FpMzIvU3BLaTJiMTgvOFVT?=
 =?utf-8?B?RDhiQk9HL2R5Z2g0d1gybDZHL0w5TVljbnQwYzBDYWdZMXFCZlVnSmFUSDdU?=
 =?utf-8?B?YmF4SkNldm5HSXd5VjFZYlhPeDB2MEU0eFgwaXlaenlQWGRpcnpTeGpoWVd3?=
 =?utf-8?B?WG43bDQ5d09tVGQrMnQrTE1HbTIyalVQMGVBUEh3RDRSOWNOL2FxYnNKeHl2?=
 =?utf-8?B?OHFaOW1iQkRib2RQMGltWFJRZ05mb3VGdmRTUkFwSHBZNWtoTzBQaHNOYy9R?=
 =?utf-8?B?b09SZDlLK2VzTHo2WENKTFRtZktna0NjQTZ3NjVMU1FaTC9JVHBkZnE3MktE?=
 =?utf-8?B?ZTBDN1Qya2NpWm44NExpS2VvakZKbTlIUk8xaXZob2Q1VXMyRS81ZDFDVWZx?=
 =?utf-8?B?Q2VmUHY1Q2Zac2ViSUFTRG1HYWxYbWYzQTVoblRuZi9xZnJLeTJZT21SOVRD?=
 =?utf-8?B?aXo1K01FZkFiMVZ1cEdIYndScWI1eVhwcXVMZ0JjRENMRFQ2T0M1bU5DYXRG?=
 =?utf-8?B?emJIaVFpQXB6Z1hPRFJ1T1UzbUF4M2JkUDM2cVk5YlZFdGJZaWhWMlhNekFk?=
 =?utf-8?B?bkJBV3EyTlZpdFh3QWg1WE5WMDNjZmZxTjg1L3V2aWQ1MzhiYXlmTDJaLzlj?=
 =?utf-8?B?NndEUFEyaXVzN1B1cGl4VlpkSHgwK1Zmb2RTSmZaVXFsMVFVUDFVa0FVS1BZ?=
 =?utf-8?B?Qm5ZMVh4Qms4Y25VMWIrWFQrbCs0SkRGbC9pbGNaeENmeTRuYWhyZXh5L2x0?=
 =?utf-8?B?R3ZlbElYVG5GUWhsMFBEZzRDb2Rtdm1JNWoyZHJEd2toRVhZajExYVBoQ2Zx?=
 =?utf-8?B?NSszWlpFQXNHdXRibDJ6RUg0c3grSzlLUXpSWlFCMjdma1ZLV3ZYcmd4djZF?=
 =?utf-8?B?dFdmRzByQ3gvZy9JR0JnZHVOY2hIYWJrM3d6N2oyTC9SV3pEeVAralhIaDYz?=
 =?utf-8?B?eTFqUk0waXZ6TkVzVFNzVmR4cVpMUFZ1U2xRSmpsbWx4TnduVFFxQ3FGUldJ?=
 =?utf-8?B?bVFIYkFwRnEvMkppd0YyVnBtaW1TWVAzZEV5MmRxZ2JLeEFFVDZtR0Z2dXUy?=
 =?utf-8?B?RWVjZDUwTkdEZ1NrdEZzQWJxWHgyY3dlMXhjKzkxU3EvajZkRUxoZGpBVjVW?=
 =?utf-8?B?SkluNklDNWVKdEFMT0R1SlRaLzNvcW1zZk11T3Z4YVlqeGpZNFJCQ0ppcnBw?=
 =?utf-8?B?OGMzS3BVbVlxZzRVeitEcnB5VENIc0ovbyt3RGRvQVU1TXVlR0RkeGMxYWhC?=
 =?utf-8?Q?1MaL5dWjDAzYHQik7I2StNxPJAS68gliMW9kA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:QB1PR01MB2353.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVV3REI2TlFTVWU1R1hYWTQrVzFqaTgyTktMd1hvaC9FRWlyQzdnd3d5SjdW?=
 =?utf-8?B?L0xhM2hQb0t5UGtWa0MwUHMwTlRWenJvQzVVNTVHbEwzZERTRFc4ZVByVk9N?=
 =?utf-8?B?VkN4NW45QWovUjJrTzczUXBSQys5YnlSSUIxeC9IbVorMCtndTdvZkY1YTBl?=
 =?utf-8?B?WHpMenlrWnV1dVJaNm9JNW5OWGMzREI1TG9iWC90azdYSjZINTJnM1JrVERa?=
 =?utf-8?B?U0dpMXBVTTdubnN2YTltTDRqQXpYZzJGSnJNM1Z2QUNIblJCQUZxQjNkSUxE?=
 =?utf-8?B?ZEtNY3haTCtUNEN5ZTBpR2lPclNFWkF4TTV0Vmc0Y1FCRkdwZ0lxMERUOHQ2?=
 =?utf-8?B?RFREYzQwV0VmS2pUWjJUU2loSG1KT0tSdkIvZnVLYmNMVEphN0E3b0dIWlVZ?=
 =?utf-8?B?U3JJdDAvRGhXODNtOEZzcnlWRTdDZVdPOWZmUE5RS1BmUnJBV2trSE9scFBM?=
 =?utf-8?B?TnVkLy83aFA5Q1c3M05QTXZnNElKeEI5TW5jdnhxeHhvck1kVkJ1bHlWUUo1?=
 =?utf-8?B?dGo3ZXkvWXhKVTNubUlxa2FIWUk5bWFKYlpqaXpMMklEWVFiVVF3VW5DdUgx?=
 =?utf-8?B?TlZlSXJ4aFhqNW5tQmh3TFhBeWtuZEVscU55T3pjU205bzNKcTRNNnNzSTRG?=
 =?utf-8?B?Y0R1K0xNZkduOUw4VHBBM1B0NHZsek1lejFOQVJGay92Qi9tM0V6clNGNWc4?=
 =?utf-8?B?eVBLY0kwKzU0RTd5UjdNV2VoVGdsUlZkRnR2V1QwYkdZSjJHTEU0QXNLRER5?=
 =?utf-8?B?R2NlT1JNSEszbVpTQkpISUdnSGZjSVlkUi9PV1BsUnEvZENTSndCM2NwKzhI?=
 =?utf-8?B?ZEdQbVphdXhJTmxFZWpnOGdCckN4TFU3Ly96VWwrOTVpYnZ4RmpPcUxZZ0FD?=
 =?utf-8?B?eEpOdG95UWxsSDI0S0wzMVE2a2UyeVg0K2l2dUFvUjFkVHpBMkM2K203RFZp?=
 =?utf-8?B?NGNLdm1tRzYvV25XREVQOWlVUWIzUyszVUduTStTR01sbWl1SVpvWUFhUWF3?=
 =?utf-8?B?NzhOcWMzSHpGVWxTcnkyMlBBa0JVazhMMDlVVzZCdUQ2aHFoQjNFWG82NWZa?=
 =?utf-8?B?L2s4aVpwQWpvOFdURnJKRHl1RGpGSFhFVVRRUTFFbGVNR2JLcnpNamhudjdV?=
 =?utf-8?B?aEVBQWhyYVlCZnBjNWtHOUFwWlpWYWlEQ3QyQ3RvbHZCOG1aWVVUejRwK0RY?=
 =?utf-8?B?RktyZ3k3SmZZNTlGM0N3aDBqV3FKVDNEYWE0WkIrNVE0YTJvQ3ZKM1ZkM0pM?=
 =?utf-8?B?aUVSZEpPTGhKek8xQVB2Z0RMZEkyRDBvMEVqZlh4VDFiTHNacUtqOFo4MEc2?=
 =?utf-8?B?NnRXOVFIK1RaZ0x2UWI5cEZ3U0tFdnFBMk5XcHNHenBrTm5WTWxpVlNFaklT?=
 =?utf-8?B?eUdRVHp3TmtKRzI1dXpNd2h6emtTRFlPR2ZqalBFLzhWUHdXWWlkRDFKOGtS?=
 =?utf-8?B?MHBLSTFjeEpaVG1pZ3hROE9Oc1hUdndNWllTa3NWMG9FSy9ZdkdMWE82eElX?=
 =?utf-8?B?LzRCVUdPWDFvUUlBNUd4VVVZR1dhUnhobHF5TVpqTGlsc0I1N3cyV3VOMVVp?=
 =?utf-8?B?Q1dqSlp6NEkrZzB0SkV1djFnUXJSSnY3bVpEYVZtYi9sVEwrajVmaEV3SXhG?=
 =?utf-8?B?S2gydExRZFBBNjBtdzhZeTkwb05ua3ZTbU5HTEZkajZyTXpaeUVmdnRMMFI2?=
 =?utf-8?B?TU9maUxzTnRpWENUSWlmanNNRmtKYndIT2Y5TFI1N0t4bHBmaTYzTDNWVzd4?=
 =?utf-8?B?ZU9xRFllZ3FmbVFlNGNFYzhiOFA2clVBQlZwV0tKcjNBM2tqZVZOdkVZNHc1?=
 =?utf-8?B?R091SGpKalpDdVc2NFZMT25uODVCVE1BU2QxRXlxQnBnaU9zaTdUOXZuem1x?=
 =?utf-8?B?emRlY3JKZWEvSUtNNUkzSTdKRVRoVHBIbm1UMmttM3FqbUVjV0cwMXVXOWha?=
 =?utf-8?B?TXNyL0VXeWtHRjM1WWprOWpzSHBkdlJ1cDRneW5ET2dWTktzRVNrUExDUDRl?=
 =?utf-8?B?WkdnaFFQMkVSVkpiRzlRR205Wm9zc3kwM3p5VzY5NEViUGo1anpta2d6dXdk?=
 =?utf-8?B?c2Fqa0xXM1lKV2NnVzVuS1JMYUs2TE9XOTM1MGJvR1VNTlkyckxIdWxhUitq?=
 =?utf-8?Q?HIZ2hTl1DmmpGikGpg7R0X9GA?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f471124e-792d-4755-9abf-08ddc927d219
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB2353.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 13:58:22.7586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qaJ4+Vuw28hdUiyGJAxKeQbQu7NnwZjVN8ptpsMG8jJPvPB4ciawyIdO/Q7wFpJ1NhBX4XCRTKLGJAVYad6cMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9738
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
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Mingli,

sorry I missed these messages last week.

What version of babeltrace are you using when running the tests?

What distribution + version are you using?

There is a fix for hangs that may occur during the test, which is 
included in stable-2.14 - 
https://github.com/lttng/lttng-tools/commit/55d3f5e528059267f44fb24b179b992bf2b0cfa6

I've been working on replacing the test. I'd be curious to know if you 
also see intermittent failures with the new version (e.g., is it a 
detail in the test harness, or is the issue elsewhere).

https://review.lttng.org/c/lttng-tools/+/14959

thanks,
kienan

On 7/16/25 10:27 PM, Yu, Mingli wrote:
> The more detail around the error as below.
> 
> 
> [warning] [Context] Cannot open_trace of format lttng-live at path 
> net://localhost/host/qemux86-64/ggpndHBBanTXM3EY.
> [warning] [Context] cannot open trace "net://localhost/host/qemux86-64/ 
> ggpndHBBanTXM3EY" for reading.
> [error] opening trace "net://localhost/host/qemux86-64/ggpndHBBanTXM3EY" 
> for reading.
> 
> [error] none of the specified trace paths could be opened.
> 
> # Wait for viewer to exit
> not ok 486 - Babeltrace succeeds
> FAIL: tools/clear/test_ust 486 - Babeltrace succeeds
> #   Failed test 'Babeltrace succeeds'
> #   in ./tools/clear/test_ust:test_ust_streaming_live_viewer() at line 324.
> 
> 
> Thanks,
> Mingli
> 
> On 7/14/25 17:37, Yu, Mingli via lttng-dev wrote:
>> CAUTION: This email comes from a non Wind River email account!
>> Do not click links or open attachments unless you recognize the sender 
>> and know the content is safe.
>>
>> Hi,
>>
>> The lttng-tools test fails as below, is there anyone meet the same issue
>> and how to fix this?  Thanks!
>>
>>
>> FAIL: tools/clear/test_ust 486 - Babeltrace succeeds
>> [snip]
>> FAIL: tools/clear/test_ust 706 - Babeltrace succeeds
>> [snip]
>> FAIL: tools/clear/test_ust
>> [snip]
>> # Wait for viewer to exit
>> not ok 486 - Babeltrace succeeds
>> FAIL: tools/clear/test_ust 486 - Babeltrace succeeds
>> #   Failed test 'Babeltrace succeeds'
>> #   in ./tools/clear/test_ust:test_ust_streaming_live_viewer() at line 
>> 324.
>> [snip]
>> # Wait for viewer to exit
>> not ok 706 - Babeltrace succeeds
>> FAIL: tools/clear/test_ust 706 - Babeltrace succeeds
>> #   Failed test 'Babeltrace succeeds'
>> #   in ./tools/clear/test_ust:test_ust_streaming_live_viewer() at line 
>> 324.
>>
>>
>> Thanks,
>> Mingli

