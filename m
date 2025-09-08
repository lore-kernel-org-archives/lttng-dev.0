Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15377CA1016
	for <lttng-dev@archiver.kernel.org>; Mon,  8 Sep 2025 20:11:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cLJ4g2JTzz1vnD
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1757362293;
	b=BT7f+UL3BppehPzfDfp1Y6l0I12bhlVXgGVU9ap+D5kIphKDJ6+MqvBkFFaUA5Vnknna
	 t9gTijhqm5rngoXwRu9+lTGjblU5gqGN9OpT+Q3ytvo2bddBND8mbB+6UamcqM43bDX19
	 sZfOdRfwNs0rr7AY1JMrhjPlht1VDXMFprapdH4EfUAV7TiCOk0d2TDDh8Nfz2KZItO05
	 2I/LwesyWFAyyu8CvzqN8YGo/0xEJ/vr3LtgVyp6yxU2y321L8bGy5iYXMufT0az0okYP
	 1vqHLV8gj2l4BCcz8jvpHBr1qguaVRMtXp2W73WMqkRbvYr6SgQjCqJSyn2ohauLJsQ==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1757362293;
	h=DKIM-Signature:Message-ID:Date:To:Subject:MIME-Version:From:From;
	bh=e9Vq4nWjJ90wvU5Q6BZNHOlf9CY1XZ+HFMm+E02EVyA=;
	b=PCAEkCIlaYsmOiIg4ubutwFwTAH2bu98C+4u0C3oH5vaP3QWxy9VroJVyVmCWuwhdTU4
	 Tbi1CDeYth+WEdNtJmLbO2ouehZiEMKiMNoO1H+b0kprQERtt9LiCVQNQCbVGIGxImgrc
	 zOWraDTYSpMsByK7BQ5eEcDuIkksBxo0wMM+WwOxMPl3xib1CpZopfhBobijTNMfS3pwE
	 X0d3UYkzgEGS6Y3GP/wFFqy49oXAqwX7PwNgvOk0TEiz+0rpjFgvo0SNd0XvF8Z3QscUj
	 1lu9z7wfTYquhe52+RvbqMEae1xchPrcHnoG/RMAr6BWNqDj3nbWX09Ofjgg/uj5m4A==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cLJ4g2JTzz1vnD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1757362293;
	bh=e9Vq4nWjJ90wvU5Q6BZNHOlf9CY1XZ+HFMm+E02EVyA=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=Jy50I0O56sRRE+IPy//as8PDPPAb0nFG8HzR6PK9y9Xrcemt6MAyQz6iMtYk8ff1N
	 R6drrNoDawCHmZjz9rS4TDR/EA1B2nEkwh74O9wWCxIf8tvxgGhktl5loNucqRSUG4
	 SHNPRf08yzl6zvwkZteX1R98R+coE/wO0M3AidFeCrt4ESbINFbCJyUoJNAwa4anXN
	 GsEwHc4ZDJAecH5d3pbssJ3c9cHXGJQJ/SdwzDrXpsiHO1DBsJpA5ZuM2LyiZSWyG6
	 f9quFqoGqfVVtcaW8/3/l8P5QJoOWIvJ0oub28RaY1oyPcr6KWRzC34PecJhgOhZPn
	 8LXREX+bJWzeg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4cLJ4g2JTzz1vnD;
	Mon,  8 Sep 2025 16:11:31 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cLJ4c2rNmz1vn8
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cLJ4c2rNmz1vn8
Received: from YT3PR01CU008.outbound.protection.outlook.com
 (mail-canadacentralazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::1])
 by lists.lttng.org (Postfix) with ESMTPS id 4cLJ4c2rNmz1vn8
 for <lttng-dev@lists.lttng.org>; Mon,  8 Sep 2025 16:11:27 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWnN8dcH1UYw3K0P7wMkKKBrR83tkxqsf3S4Kon4Z9k+RO1cUEdwEFWwWHAxxsUAgEnFJebw4f8A3JX+P8sNTlpScl99z37XYmbmApllM0+KrN1vHl8XFHjEcyRsqLBhNjdY0W+FPazvVJjP8c5L6fEZd7HwhrsnI/mWuuo81BsmNSCQLhrIFBd1do8RJ41T/n2utkbP0Bz/yAeXHMla+GMWB6pBfFDjrW3J99QemBMEiyxgpWch1A45ls9mx/uBOSas4w+CaPqx10/bw9p5MRs97GnS+N2vuhIFYl6BluufQqvPSoBeeI0QJprh/pGLfDOvrG42r0UMf18A7vrsoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQ1RxfqUyr4nxrQ7d1UHaK81U/LnW0wItp9Qh7w9xdU=;
 b=cVwl3gquzIagrGDUlnB1WwnhbrWCOHUEvMzZ2nTlVCk/FhLHSucU849mLr9Bbfw2lRuMBn5sFi0aGIXRk5BP7U7cWnbpjUJSNbM5ZW07vRmyBH4O+IlIowdToNJXWPGN6ZhCO4yMpRJaMW8Tob1W67CnA0lMn7kOI3kt2bvqZW+439tgS53zEygm0QXj/oh18IxG20HNP+HH69INUlwtbIQ6DiMwmVLS8JBF7+yooKPRwGKe/RhqOzydRv08oB0uU+OhyGouyHCSZAsDeCHZGMqlZ7+EJtsNmeT4lrr6kVZi6yApTagJmB3GkT3HDt8K+SilIHi3D2IGByhKgp0ZMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB10356.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 20:07:57 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 20:07:57 +0000
Message-ID: <eecc93ef-8d3c-4b2a-857c-471295ee6ec3@efficios.com>
Date: Mon, 8 Sep 2025 16:07:55 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org,
 linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RELEASE] LTTng-modules 2.13.20 and 2.14.1 (Linux kernel tracer)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0346.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::16) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB10356:EE_
X-MS-Office365-Filtering-Correlation-Id: 9428475b-9f92-4b1d-8cae-08ddef13670a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDlGQmhjZXJzYlJPbzdwS2cwTGdxWUJnTTRENklnU1hQQVVkaDh0VjNjYXJS?=
 =?utf-8?B?TTBEQXFzZVRtQUI4VkYyaE95L2pMYTN4N3Q5SmY4bHhkRDhJNzVCNG5sdFE3?=
 =?utf-8?B?bm4yOWJITDA4TEtVa2FZeWpPNytwQkMyRlhMQjZLeTFzK2NhdW9XNWN3UjNI?=
 =?utf-8?B?S3pkdjFXeDVzb1VaSkRndDdReFlONXNaZjFJYXRWa3N5K05WQ0ZkVFl4eWRl?=
 =?utf-8?B?RDBPR3FJa3V6TGxES1orUzBSMm90ZTZhenVUT3BtVFNRQUVVOFA3bzZwQWpH?=
 =?utf-8?B?UUxXYjMrNjg2RUV4QnA5SVo0SWZhT1RMY290T3JDc0lBQ3RFMHJjR0lFU0Z4?=
 =?utf-8?B?K3E3MmNYeGp5VnZobDlUZ0xMeXpUUDl5M0dCUkxHc3AzcE5wOUlRd2NYU0Rv?=
 =?utf-8?B?a2Q4Nk50WDJ2TVM1T3IwdHZvbGk1ajhBR0NQUmV1bzlNYml4NzdVb2IwQlZG?=
 =?utf-8?B?ekVLVXcrNG1YU1laNkVZMkYrSWFOY1JMVWc1RHZuRWh5d1RUczA4UTNGUlpo?=
 =?utf-8?B?Q3RZclRNZXFJSTVKQ0NPU3M0VjVVSzg3cEJyeStRZHVCdlk3aFYrZ01wMUFi?=
 =?utf-8?B?MC9lUjV3Y3dkWU1Ha3RBVS9ia1daaExSdzBtd0R6NDNlcUxZbWxrMG14cDYx?=
 =?utf-8?B?bTh6UGJoa09EZkJFbHhPckRKTDd0eVVQYWgwNGJzQnJKK1czdkt5Q1Urbjgz?=
 =?utf-8?B?TlExNXdZZTE1eEJ6MysrM0VvMWdRbExmN2FjMVBFL2hZdExaQVdJNUZ1MW9l?=
 =?utf-8?B?RTJzY0REM0wrbTlOc1BKMXd6RE9RMkJWazBmYkxhaS9zR0VwVFY0TkhHU0lv?=
 =?utf-8?B?UjlCSHNvdmJ0RUN4ZUI5ejMwR3pWMnY4ZzJxWWk4eEN5dkdzN3Z5Ymtrc2g0?=
 =?utf-8?B?QUtuKzdmN1AzeHFKWXQ3WUg4bEhweDZLTjhqTENVNENwN1R4RjRTcFAvVkdx?=
 =?utf-8?B?UXJza1hZVE1QYW5PanUrRHNDcDBzQkJnSzlnaG82OG52WlBUM2VoN2pwSko1?=
 =?utf-8?B?RkxwaG9IK3VNSVRHOUMrc28rQ2dYZHVnWWZuc3pJdXlWMzdYQ2VQK3RQdkkz?=
 =?utf-8?B?YWhIWEZmaFgzOUFEWUYwS0o0alZPSzJRZm8zMXlqNS9maVh4ZGpUdmpJWEZi?=
 =?utf-8?B?NTdLSzJpeW9MNUhWRjRLY3libFNsT0dYNUt0U2pCVWFYTVMrT3FFR1FCY0NP?=
 =?utf-8?B?MEFlYnZwMkJEUFd3d1Vld0VocTRxY3BHdnVEd0doc1VreG5GOHVvcUJjeXRD?=
 =?utf-8?B?bVZsWENhalBjcklxUm9FL2dpSllFYkxWak9pMlFTRG1iNCt3Z3pLNmFxMStJ?=
 =?utf-8?B?ZkoyNTMzb3Q3TENXZ0Jtbmpqa0hVTWI3TEtjcHFLbG5rVW9OM3dqendIUnQz?=
 =?utf-8?B?MDlNVFV6N1B6d3B4eFRQK2htd3pCWDhnazVNMFcvSisva212dXlpYTl2Z0po?=
 =?utf-8?B?UjlhOUIwSUtWRzZFb1V6SXhOaWdOYnFLY1hkVDNYSzlacjlrL1JjKzY5NXBP?=
 =?utf-8?B?TVpQdkwwWU9hb0ZhbHdQeTlrdHJvT0llbENKOE1ENnM4ckRVbUZHcEZMVmYv?=
 =?utf-8?B?NVdTMStTNE1iazNPZzV4YXdsb3V0VTFjcElyZk1LK1hyQXJNaVhBdFozak1z?=
 =?utf-8?B?cnQ3QVRkUlg1RmdXQXAyVStwV3VqdVprWStWWDFJcWVGVysxdDIrRWd6UUJw?=
 =?utf-8?B?RERvaUJWdEJKUmZ3YUx4cndMemZ4SFM4UUtRWWRoYVpYbThtWEVlWkU3U1gy?=
 =?utf-8?B?TXNza05neUcyQlNtanV6Ri96clM5M3ZpQXQwSmJuRTVZYTZ3WHpUbk9BRmMv?=
 =?utf-8?Q?I9JWEEKbr/tnEHE4Aazsq1pGSa7PciLVm5H9M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWpKT2JaVUhYejNjVlhEa0paaEtDOFZZd050SnJJMW1veXpCNzJkTFpJa3pE?=
 =?utf-8?B?OGRuYlhYMlh1N3d0Rmh6cS8xay9tc0VrTjFRV1dkbytESWtBeUJERmZYcFNQ?=
 =?utf-8?B?VVNIcGk3WTF5L004WC9DZWQ3akhzeHVveXpiSWRMZVN1SzJObi9veEp5R0w4?=
 =?utf-8?B?VXhjNzBQK0dWRUl4VkJ2L204VUlsQVpQWVNYRHEvdTFZdlFDVmVMQjVpWHAy?=
 =?utf-8?B?K0M2ZGk4NEpXbnZmRFUvNFN1dTUreGs2VDlXbTZyeEtsTmFJdzViek80RlV3?=
 =?utf-8?B?NjZTZjl4TkhmK0hDcEdNeDhrV290MUxpZExVb2F2bmdPMHNtVTFyYTlINjFo?=
 =?utf-8?B?RWpQbndLNVV5eW5IckkyMHlQb1RjemNnb0NqUGpaNHgrMHR6M3RDVm8wak9U?=
 =?utf-8?B?ei8wVytBWXh4THVWUGxHeEhublNqK0VsZVhqR1ZPQS8yYXNLZk5BaXZKMCtw?=
 =?utf-8?B?ZFB5dWdiMVFTUjA5ZkowYlFXVm1Za3ZJenNVbHVaSzZLdGV5eHZERlFGVDdx?=
 =?utf-8?B?SFFSMU5sVG9NRWtiN1VUUDhmczU3djYyeEpTQ1lBQzNoa084dktkS0tRaFRH?=
 =?utf-8?B?YzhQNUdieGtLSGtjWFlFN3BSZ3N4NmxGY21oeXYxcm5Qd3QxL1RwM1hkZDRP?=
 =?utf-8?B?R010N2laR1hBUHc5QlB2ZWJqQ0lmT1RUemQ2V0tnU1AxdlN0Zllja080cW9D?=
 =?utf-8?B?VW1BaU9DbklPS1JyUDRObFhMTStkY1ZUdFF2aHR3QzdCY21ZanZPMkQzaDRF?=
 =?utf-8?B?WWtadmxMYjZOY25ENGs3bXRzTURySTh0d2RycXN0djJFc2diZGFQOXZHQTB4?=
 =?utf-8?B?WEtzMUV3YVJpVkdDUDBjN3FtTWtPcXhyNThGeWNIcXRjRDNnam5hTm5uQlhI?=
 =?utf-8?B?V3VXTnZYdTRjVHVGQW9leGx6c05hQVh3c3hhelJCVm1DM0JtRzV4TXJaQ3Bj?=
 =?utf-8?B?SlVmUSt4emExU3FTMXVVeEtvdWVEaUhORFk2UUZkVGJTUWFHMm81SFVkS2Zn?=
 =?utf-8?B?aFJWU0dVSGFMalJ0eUYwOUdnazZNN0dvU2NMaWZ0NzRaL3ZrZDhTb3c1TDN5?=
 =?utf-8?B?eFdQa2xKMmdqcjdCMTJkVXVmZkRyZEsrM2ZhVVpDNkJWbDlVNTVJUUc3VEJG?=
 =?utf-8?B?bG9sRUl3Q3dzaEVIUWIyS2RSQWhNNmVWdk5MK2Z2YzA5T0FKa0FrZjA5NmFo?=
 =?utf-8?B?WWlQajVkUVVyMTQwUVMzaWJ2MVV3T01BZkQxYit1bVM3eU9HajlocFd1K1da?=
 =?utf-8?B?YTdvOUE0c1lRa1JXbkxLdlhBUlE4d1B6MWZtR2hKeElOb2k4cGsxbG9FOGRn?=
 =?utf-8?B?YzBRUkVaSTE1MVdOQXhPZVVLYlRBMWV5a2R2TW9jMms3bmx0MHovb3JxUG9R?=
 =?utf-8?B?bWhTSDd5UFc3bDhJMytQTHoweCsvSFJlaUtydVZzelRMUitFU0kxemhiZkg3?=
 =?utf-8?B?QTV1ZkVOdG1iVTFBeUNUNlpZWm1CK01nOWp5ZUhBYW5ZZ2Izc1J2ZFJXQ3Rj?=
 =?utf-8?B?ckVyZ0UxZVppYlRXOUV4dnkyZ1BwUTBSdjNLbUE4MUpMRDdlSXE4bGJSVzFl?=
 =?utf-8?B?R3NLN0pDZnZCRXVnZmZUcXNpUjM4dERpSlQyeUVablhqWkIveE83NGZ3VTFQ?=
 =?utf-8?B?Vk00TXloYUdsUlVrRzhqa0hjVzUwMTl2Z21mUWxjTFk0dTBNSEtDd0tGVEhF?=
 =?utf-8?B?Q3VoVzBabVhGNUd3R0o2VG02dWdsUDFSTlNZa0gxY2lZTTN4SmE0dDl6Qmtx?=
 =?utf-8?B?UVlJVjZZL25yUStZa2pQZytHUUZzbzRad3d3dGJWMENFbmtKRkVGNVdQOUNp?=
 =?utf-8?B?ZXFyU2xGVWlGdVcvUU9ic1M1ejNzbVVjdG5iNC80eEgxTjBlODlmbVBJTXo2?=
 =?utf-8?B?UFBsOXE4elNreHdiUDY1bzVkbzVsNVJ6LzlvN09iN0VtYUFSS3BCSStCc2po?=
 =?utf-8?B?c0EyYjRxdkcwRlpRN01Ubnd0UXMwY0FFVS9VcWZVQml1ZnhFSUJVRmZLdWNN?=
 =?utf-8?B?NDltbmNjc2owUVVwMnc5UVNjU0FSOXZ6aDZEUkthRDdmN09SWXVrcC9tODdj?=
 =?utf-8?B?QmNEd1duRjB5YWJIRm9rN21IQ0Q1Q0RCT1RsczJQbHNkeDVnanRabE9WZXBS?=
 =?utf-8?B?MWtWR2M5QnJwYUNGNDRRZEZmOVdqdkQwUDNhdWtmUHlHSVkreGVLVXkwd1Ba?=
 =?utf-8?Q?3UdmY0vKH2on98D0bAKMlcY=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9428475b-9f92-4b1d-8cae-08ddef13670a
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 20:07:57.2145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/1uAy5yBM2764Kz64NlMeSBZGXJ8n133PW0ET8DOOz7N3ba8ekwu7yUJMowtKBzOQzTwgtn0la7f2HT2X9Wd9TJIM3V/HlTkhvUzWWVhNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10356
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

Hi,

This is a stable release announcement for the LTTng kernel tracer,
an out-of-tree kernel tracer for the Linux kernel.

The LTTng project provides low-overhead, correlated userspace and
kernel tracing on Linux. Its use of the Common Trace Format and a
flexible control interface allows it to fulfill various workloads.

* New in this release:

The changes in those releases are mainly kernel enablement updates
to allow compiling against recent kernels and building against the
full kernel source, which allows building additional instrumentation
such as ext4 and btrfs.

* Detailed change log

2025-09-08 LTTng modules 2.13.20
         * Add missing prototype for wrapper_get_pfnblock_flags_mask()
         * fix: mm: remove the for_reclaim field from struct writeback_control (v6.17)
         * fix: btrfs: use refcount_t type for the extent buffer reference counter (v6.17)
         * fix: percpu: repurpose __percpu tag as a named address space qualifier (v6.15)
         * tracepoint: Have tracepoints created with DECLARE_TRACE() have _tp suffix (v6.16)
         * fix: treewide, timers: Rename from_timer() to timer_container_of() (v6.16)
         * fix: mm/writeback: Convert tracing writeback_page_template to folios (v5.16)
         * fix: mm/page-writeback: introduce tracepoint for wait_on_page_writeback() (v5.2)
         * fix: btrfs: use the flags of an extent map to identify the compression type (v6.8)
         * fix: btrfs: update the writepage tracepoint to take a folio (v6.12)
         * fix: btrfs: tracepoints: add btrfs prefix to names where it's missing (v6.16)
         * fix: ext4: Change remaining tracepoints to use folio (v6.5)
         * fix: ext4: Convert invalidatepage to invalidate_folio (v5.18)
         * fix: sched/tracepoints: Move and extend the sched_process_exit() tracepoint (v6.16)
         * Fix: `fast_page_fault` changed in RHEL 8.7
         * Fix: `kvm_exit` changed in RHEL 8.7

2025-09-08 LTTng modules 2.14.1
         * Add missing prototype for wrapper_get_pfnblock_flags_mask()
         * fix: mm: remove the for_reclaim field from struct writeback_control (v6.17)
         * fix: btrfs: use refcount_t type for the extent buffer reference counter (v6.17)
         * Fix: `fast_page_fault` changed in RHEL 8.7
         * Fix: `kvm_exit` changed in RHEL 8.7
         * fix: percpu: repurpose __percpu tag as a named address space qualifier (v6.15)
         * writeback instrumentation: Add missing provider name prefix

Enjoy!

Mathieu

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

