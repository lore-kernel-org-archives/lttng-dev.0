Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568B0EF99C9
	for <lttng-dev@archiver.kernel.org>; Fri, 13 Feb 2026 18:48:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4fCLmQ1B7yz1B76
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1771008536;
	b=ZL5kL9oj5IZaDcriRXEkVdc/jZTafaz+M3zmbiI1crE+lyIjj8n5aZES6a7dG76nedmX
	 K3n//CDTPxPntfRDmnmXtVt4kSlP+RAqWBz/ItFdvTdZi+XWJmLqjMVTE7lT0T3pZnXtE
	 ru7G2tnb1NdpF/EHQntz8cyOoTaENhnexGJCqCVQWqPJ1VZzRAIC9tWOnmiY0pwb8S0WY
	 SiYnL2YXF3k/VW2VllrKx2H5ZYjOjREsSmksKc0zZxbwdn5pMsvE4JlkjJcA+fPv0Z/4U
	 MY74J+2Gn8V/BSkkd9xedaiHT3fp5eiEnlRVwGe4ATiqGt9SfT7qBTVzyRwj08wDC7A==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1771008536;
	h=DKIM-Signature:Message-ID:Date:To:Subject:MIME-Version:From:From;
	bh=/7ok3x0TMF7cgVsj/fdjM3U0395ImbkfZJCBUcqeH0I=;
	b=jxGVW4LvfV4hq/Nq9Mh3pAL1n0W+qtJHaCCbFy+1nOXNEcXDN36OzB6wVgkSAupPhvCa
	 z6yWX4RVoEFry4VDXbG14S5tusW78IwCSGVaml0JgPqDz6ny3HQDjDpYWuLSumPFQAaCT
	 jYOKGHFHk/HW9LRO1SCvIXCCRwsBkGNSkzT6b44auX0HNDd5fA8ZVgdHjGvhZgIAey88a
	 pARDcqc3dCyUBBz+8EvflWuAifMeT6FAgjsYMpO528RrbvtWcDP1cHLZzfXNwCiMNrOlr
	 Op7eU8HUaFCNNwc4y8PDorqe6ctze3FQkaiJy0L/N4iDAsw+He68bxWCPzKvKm+Wu1Q==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4fCLmQ1B7yz1B76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1771008536;
	bh=PO88s8HuPYJU+8vkxynriLoaRf4nAeKQy8w6tv3EAMM=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=VVynpkR2YkQPbH1OE+YGEk2W5EkJ0RQDa44xYM+G+eskS0I+694S5grXLclYGogkv
	 DG+h5x5OtSOg7/DIcwfp0bw1yXyEo7yNY6j0oaP5+oIErV2r+DDiLm9tXf8wb9QYli
	 kDPtdG6zz1o4uNGDxAGV2wORcDXIYqj2dUwXg2kMFNflZ+xzo/KZXCO/+mt2mfYlOS
	 5/T0IXK7s6sX1+fb3me+ntWVgq83NbSgA90EJVy52GYzMZHOeEiqgAUsJsbAwM0CTJ
	 Nm25I0clT5taA45w3w8lqCLFSHfGAs95jXZb1PSkD0wdx5NM0hUQkgLzC7FhDSPhv7
	 UVc7VgAHuuw0A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4fCLmQ1B7yz1B76;
	Fri, 13 Feb 2026 13:48:53 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4fCLmN4Hsrz19S0
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4fCLmN4Hsrz19S0
Received: from YT6PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::3])
 by lists.lttng.org (Postfix) with ESMTPS id 4fCLmN4Hsrz19S0
 for <lttng-dev@lists.lttng.org>; Fri, 13 Feb 2026 13:48:52 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnpeWI0tbSaUci15Lf8z5oko65QjE3VvwENmsXZggtCBfsc0gCk2tw/zYM6bBC7yexI0Cvia+xJ1g7vFC0B1zQeq1q7XthRhF2lmt5NlrdHmd+kElBy3263Nn93BT2FenUJhJNs8Aed+xocm1nJy7Q3fi2selV6GLLkomzm5eWvr2LE6APDhlyyQyAo6/6Fz00C7atgmrMoVDUXK3nxh7bR7VlUkTkYGBnAme4ovMoImCHvqW6HgB4NUMLHi0faCl+RLQFd5T2rzMZ6rjvcAXcmiAvflQyu4Yq8chhdqG9mxLNqaPuHrzFlxe9hnAeH+pFt1akswt/9s6hquEKVF5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PO88s8HuPYJU+8vkxynriLoaRf4nAeKQy8w6tv3EAMM=;
 b=g3ApHaBCOU6MEFxsnkdVbZKRF3sLwJumB6YbPlbW/sbDcRD2TI9d4hj1o1ivqMQo5l2fzDNz2Xj7QyihFsax3ailnY0dQKy+J6zpdjNSqt3hKiy65f021Rd4op/CKLsHnKrbi0vSFYPnRSusEpRnV8ov+1v8LdIS4B+WApCt45wOeEV2daqVhqOX8cvmCJY3mWNlwvBBxam7FSMWkZIls2JsgQlnOUDKRaN9o2INEettzIc+gjWgrQDdFumdJlTtBNEbHPXZTc5MpQp3IZW3MP1XeWIouPxKsxMIk6U0wmsrtxkgixJhJVI9v/1Qh/v6pJujR6riK0Ev0VkaaFe1QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB5586.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:54::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 18:48:48 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9611.013; Fri, 13 Feb 2026
 18:48:48 +0000
Message-ID: <c5d648cb-1f10-494b-8cdc-8e37adf5ed1d@efficios.com>
Date: Fri, 13 Feb 2026 13:48:46 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org,
 linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RELEASE] LTTng-modules 2.13.23 (Linux kernel tracer)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0159.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::32) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af82cf3-55fb-4ba1-2c8c-08de6b308595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkphOGNwMnZHZVdCR3F2NjlId2xTYytrR2NVeHRrbHhxU0tQYVdMU1JwYmUx?=
 =?utf-8?B?NktxRTJBeW1NRzBFbDd2bkN2MHQ4Z000NWdyMm1TS1B5bmJWNmhDQjBLZ1p6?=
 =?utf-8?B?UHlJMWpjVko2dnlyMXpuMmpoa0svd21uR1RIV0cwSEpLR2dqQ3lKZ0tPWVBt?=
 =?utf-8?B?bGRrQ0FWVjl4MmpRVUpKczdxcVU1Nm50ZkRjY2h0MUZxZStxWnZOU0VPOUkz?=
 =?utf-8?B?KzN6RE5IampGekFJU011WllUSVFpRGpHcDFMWmxEQ2R0RG56RXF2c0hDSXk4?=
 =?utf-8?B?dEF2Q05vTVVhQ0YyL1pLelE2RXkvUTZlOGpGY3FBNjh2d3NNZkgzQ0lKRWh2?=
 =?utf-8?B?ekRkME5ha0tzMnM4TU9sQ2hOMDVmTjdZQkIvRlh0dVlyQitPaUxOVnI3SjMx?=
 =?utf-8?B?WTNRZjcyN2xRblFzV2lDaTcvbU1JVHNnemx4QThhZml1RC8zWURqNnF2enJU?=
 =?utf-8?B?RENiOTU0VUloUDNPMTMvNkNsZ0xYbHVoVTBHd2gwMEFrcWJBWmFibmt3aG1J?=
 =?utf-8?B?K1drUjd5aTdJckNKUVlPdmN0ZlZ0ZFNYNHo2eENLU0t3QjFBWWt2YUc5aklW?=
 =?utf-8?B?UlRhMGVBTUdqYUJhNEhZdlFmWDNDak5QY3RhaUJiRld3NFRZM1Z2WmY2dlNW?=
 =?utf-8?B?L0I1cEtHOEl2Ums2TWRyNEtvb0JCdkF4WWczWDdUWWNIWU9XbHNBV25PcGl4?=
 =?utf-8?B?RW5jQUR1RVJMVDMvMURlcEF6RVZSVVZMSkV0LzR0Z2R4c1ZaNy9ZRWx2cDc1?=
 =?utf-8?B?cjhwWW5zeUN2NlV5STgvc1Z5QWhPS0pycnE0Z0k4QzRmcnY2OStSR2VvMy81?=
 =?utf-8?B?NkZSTCs5MTRCcHNRWUlYZkhiTU83WWYyckI2WmFWd05UTlg0OU13bGoxdllU?=
 =?utf-8?B?OFVUb1o5NlE4WFl1ZHhPWjd6WXNEMTZ3TmlVQlpoenlWRmdqUi9FTkJzTnEv?=
 =?utf-8?B?cmlzb2hyYmxjbkI3bVBVaFdqVm5BOEw4Skw3aXBINlU0STJkanhwdTlJK3ZE?=
 =?utf-8?B?RmhnR2NBT0lUallsVW5Pbzk5cXFoeHp1dlJwamtzSEtYQ0ZGNTRpck0xVWNp?=
 =?utf-8?B?MGpOcC9seDNZZHYvUktQUFlPRm9WemNNYVJHcldWQkxTb0lZRUZzcnZYd2pw?=
 =?utf-8?B?aXBOdUpGNkE1OFdaQzJHcllmVzVEWlVPM28zV3B5L3pmYUg4RGZWNythVXdB?=
 =?utf-8?B?blRWcVpRMy9BY2FXV0F0NEFUcmg4WnhvWnBTeUJFUW5mUnpad1ZDOTNSaHlv?=
 =?utf-8?B?T0l4S25xekpIWFVRSUlnMlZvZXJtOTVBdmNUaGFqVkdKRUF1ZEtBQWNEb0gr?=
 =?utf-8?B?SndXZEhXekhBVWUwME5yWFhGUTdJZDRxNXgzRHRnOFFVbGx5NUQ5Zm1KVFdO?=
 =?utf-8?B?anJLdC90L3VMMEFVUzJtTHNiYzc2c2RwMjYraTV6dmhUb3BPcDhucldEa3VW?=
 =?utf-8?B?cGJNeVE2MVd6aW5UZUxBSTVHM0QzOVlBN21SSnFsMGY5WUl2a1VVaWFOSVFC?=
 =?utf-8?B?bXE2N3lLZXRyUHFiMENQSWtyREp5YUVmUFJiN2U4WXNydllTTlhlSmQ5U1Yr?=
 =?utf-8?B?NjFXSXU4aGhZSk42UHdqb3gxbUxzY21veDNSNkppTWtFMnM1bWJ4SVVGT2xE?=
 =?utf-8?B?alVKTTVzc3RiYkJtV2h1Q3hud3hwOWk1eS85VS8zZTBTRjRiTllGK0IyYmp3?=
 =?utf-8?B?NG0zelVPcE1WUmRHK2t5UEMzSkNXRm95Sk9WV0k1QmNOQm4wbUM4K3l6Lyt6?=
 =?utf-8?B?R2FhUzZGdDBNc1JYZW5SZStvazh6MEtLV0F4TDRIak0rYS9VZjVWVXpMNjdj?=
 =?utf-8?B?bWVRUHFjMGVNSG8zUG5oT3NRTEs0d2duYit1SEprbnZvZXVqT0tnNVJjUmhK?=
 =?utf-8?B?Z2FpdExHVWJVOFdZTmk3bnRHNlRCQkVidDNhckJET1F6aVlZMGxXWjR3VFhP?=
 =?utf-8?B?bmdQTTlwbnNjTlFpa3NOYlRleFA1dk8xeHN5aHVCSUd5aGNvZkRnUUNUV0Vn?=
 =?utf-8?B?bVRqNzJkaWZqWVlRb0VHb1FQY3FURWV2K1RxaWdOMmZRaThhQjRTK3Q2bnVF?=
 =?utf-8?Q?xxk/Tl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SklmVU1qWG9UMEZoK1NwcGJFNnZDTjJHcDRGTWxoRFowWkJmUGdqWS9JMFZD?=
 =?utf-8?B?QmovZVRHUHVUWGVIZ3dGWkpuTFlZYmNWL2RKOE9pNXlTNXhJa3ZrQXhSak0y?=
 =?utf-8?B?MGVWZ0prcmRWR2JKaS9ST0hROTZzdmJ5U3NoVHVZaXpWQzRoaVFLQlhJWVQz?=
 =?utf-8?B?MHRPQ04xazNzRkZvbWgrYnBHRXdnVjVTbkJRYW1ubDl1V3BYVWlQMEpXb3hX?=
 =?utf-8?B?ZEtxeHhUbEJKOXBENjRyTkozK3pVUDlGQXJ1NkVFM0RYRC9GcTFTN0tTVytW?=
 =?utf-8?B?c250Q09UTFZmdHZ2byttaHh6cWltQll1dExaMDR3YVV4NmtxUDN6OUpRUVFE?=
 =?utf-8?B?NmcwWUorSEgySTdTWXJpRXdpSkZLT2ZGZTl3Y1FoNHlpM0hOMmZ1cjA2NXoy?=
 =?utf-8?B?TnNXYmJiWjhOcER6ZGllOFd1S2lWNmtiRTNrRFVVTHpLZFdBRjlLK1pBUURi?=
 =?utf-8?B?NmEwaVloVkNSd0lRUm5FdkVxbDViN3lMYkZSS1ROdWpKY3dwOTVPTjh2MnI1?=
 =?utf-8?B?aW9GYjFuSnpISVZaODVmSmhNbi91M21jYkFoS3VCeS9VWjl6OWU4NkVGdG5Q?=
 =?utf-8?B?aTU1RUhPS2t2RTA0eTlKd1FoQVd2ZkNiRTFpUVZkTmxCWWtFNjVITksvU0lW?=
 =?utf-8?B?ZXBnYlVTYTJ5S0NZQVgzT1lObis3NjRpY1VkanYxUy9raUUzajk4QVRpMTEy?=
 =?utf-8?B?ekh6c3l4WS9HMndBTmlGdXNGZm9USmZrdmtEUEQ5TXEzRjlabkZjdlFqVFVM?=
 =?utf-8?B?QVpWMjY0ZDFJZU5SdHlrdjg5SHI5b3Yvc0piZ1JHVDRXUktNZXY1OWpQZFJ3?=
 =?utf-8?B?WGxPVTdSR20vcXFCNCtJV0FGVjhkeW1KS2o2QnZZRllvNGxVNkk1UmR3elU3?=
 =?utf-8?B?YURUM3VuN0JUT1dVVnJJb2IzaldBbng4Wjh1SWpKNzlGSlBJc1JDd21YOTFt?=
 =?utf-8?B?a3BjOFpFdzhUU3BONmhOYnFCYXp0SlJUMUJIZm9sZmY4RjgxdkpxQ2F3dHY0?=
 =?utf-8?B?czVGQy82SUNkNlRLeGo5VTZtR0ZGbTNLVUhVdlAyb1pNbXVMV2Ixdmdsc0Ex?=
 =?utf-8?B?UWtrdlpTYkFvaUZpN1lWd2dPamtBeVBROG5mU1d4UXUwTG1XeW1BSU82dTd0?=
 =?utf-8?B?SXk1M0w5MEtYckpEaEh0Snhyd1NHQ1FEMzhBZS9CVE5kUWo0YmYyZXRpdVU2?=
 =?utf-8?B?TnB6dzYvVTJrQWtybUFobkxMZmJSU3lIQVZzYXpGbXRCMUM2TkF4UDVWTitX?=
 =?utf-8?B?NnVHWkhERmcvYnM4aFhDQll3T0hwb3duSmN5NDNOY3lnd3V4ZjlUbXEzZ3BH?=
 =?utf-8?B?OHo4TkJrT2tpK0xvbWtrd3BTZjVXNEVmZnpFcHFiK0hQS0FZM0ptc052LzdG?=
 =?utf-8?B?bG9PazRMZ0lsQ2xOVzNicFUxOGczMFpBUjRwZHVKYUFjYjhueVpWUU5tamw2?=
 =?utf-8?B?bVZTSjk3SWk4b0ppSjJJRklkYkhpK0c1bWM4NFJ2NFpSTlBOTWlYODdheDNT?=
 =?utf-8?B?aEhDKzAxQUJSc2NJYmI1d3lqbjNMWUNFb0RuSU5CbUZjK2RPMDFoWjFuck1h?=
 =?utf-8?B?Zm1wYjJORjZJYlk1U2RsMUV5MFRVZ1lKalhXT2RrbUJFRDN3bFJFRlNKc3gy?=
 =?utf-8?B?VTBCTStDeU9zZWRFRldMcEF2NGNJZXR1bFdQdjAxS2dnTjVkdWUwSmJGK3RU?=
 =?utf-8?B?RW0yYmtJZVhTY2llc3RUNVduWkxIUHVIVVV0Q3g2eDhrcEMxNFdsV2lST3da?=
 =?utf-8?B?bS9obGVNWCtRQkhwbm4rOWc3dHRJTGViY2x2WDNPUFRFQmdza2xKbG9zVHgr?=
 =?utf-8?B?cEwxcU0rZmFFSVhKV0dXMGI0VG1aWkFZOGlldW1CVGxUVHhrWW01WkpzNFNN?=
 =?utf-8?B?cFMwbndVMkVJUldMUzhyRHNNRTVaK0xjLzhEaEFLaEVFMUZkU0FHQ0RFd3VM?=
 =?utf-8?B?aWxQdmhPSzJVbCtRbkFoNzQ4N1NOOHRJL3NHTmVnVDB5K1hBUnRzS2c1MmtZ?=
 =?utf-8?B?WGZGK1A0a3NkaHVJRURYS0lXU1huUjV5Z3BWQlhoS1FvZUtzNlM5UjJobm4x?=
 =?utf-8?B?akJ2ZHVNWkFySEQwUzFMbTdjL3VVeGxMNkg3KzBwZ2cyM21XdHFaMWxCSmRp?=
 =?utf-8?B?dnV1MGNza1V6WG5VZHVOd3g1UGppWUVMSGVPb2RsUVlmTXZFU0xKUGRXRXFD?=
 =?utf-8?B?ODdzd01kcE4yRlBQS282aWpGaWpNY05CbmllN0VVci8yUmltMmFNUHMwYSts?=
 =?utf-8?B?VHJoVVNhTEloRTU4Q0czc3hoNXZmQ21rT0dpRzRoblpKdXcrUlhLS0w4UUcr?=
 =?utf-8?B?UEFsc3BXR1FrbmtISVhXSkJNV0ZuTEZrL1lIUGFoM3JJM0YyWDQ0MVhwZDdF?=
 =?utf-8?Q?F9+zM+Wzufwnu9/0=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af82cf3-55fb-4ba1-2c8c-08de6b308595
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 18:48:48.0072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHdWNcHoF+U7Eb8bqhUh97zNp/Wfjp5VoOeY9JO8fYfOCKcElOJbwl0WJxIKCZqpwRC51bQYYVVf2ryzUx193fzF0iXPG1z9FhVDJNlVq9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5586
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

This is a release announcement for the LTTng kernel tracer, an out-of-tree
kernel tracer for the Linux kernel. This release targets the stable 2.13 branch.

It includes 6.19 kernel enablement commits. With the upcoming release of
lttng-modules 2.15, the stable 2.13 branch becomes EOL, and
lttng-modules 2.13.23 will therefore be the last release of the stable-2.13
branch.

* New in this release:

2026-02-13 LTTng modules 2.13.23
         * fix: backport of: Manual conversion to use ->i_state accessors (v6.19)
         * fix: Manual conversion to use ->i_state accessors (v6.19)
         * fix: btrfs: headers cleanup to remove unnecessary local includes (v6.19)

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

Enjoy!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

