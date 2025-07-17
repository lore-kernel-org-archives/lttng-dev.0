Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7678AC83F1B
	for <lttng-dev@archiver.kernel.org>; Thu, 17 Jul 2025 02:27:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bjGzH1W1Cz15cT
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1752719245;
	b=gXCDo4BwKTPWLu9wL8M5/0oHwnxdEQ4T9MM02XjGFqWfOrMgyGW8ErxR7IvxCRJHb2/z
	 kCz9LTJ13+rkGaMksbGTj9SFr8RKqlwfSwVjAmd8jbiUN7Hi1DJbJYNHhfbsHaMXT3ORw
	 tEzfydLPvJC0dTEyYOUhhERiIKdPUyFciqeWqSLjBY4wdKG/iTGOHwDPINmAJ66wMeW2/
	 dwkrnZYJSvworhNwZ6I72SjeKMqWP8nogOl+UKx8bzMJTsd0FzodQXETaoWKaHSG4zbka
	 9hc5/u6o4nbg0EXWIIgoqpWnayfSQbeYnj2dp7Y69FDwB24D6QIiGKCR2hI7wmw0gYg==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1752719245;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=2hfIt5Vxb7ksb7hHHpKhBJWd0Jlq/So642D+Kbimna4=;
	b=QBuSRPou1r/a2sRAPxQbUrMRK8skvmfD5uklgDVbEXsXq+GvYD9Pjkm5w1mh4qmB8ncF
	 t+nZQYwmqzC7GTl6UuNHqBp308ZhfmL8ZcoOs11olD+aLuDEIN+C3tLC+YA7mtOoYRjl1
	 wH4ABB2jSnzswX8qpjGlQPyqbbwwKYGJRxZRjeoZh49AkUU4Vyeg+0PZldRaBykRMb6cp
	 d7+uUZjwqBuT9Jer+8Gudl6kHMwmYiARwAsAuxjyPoOjhuK2vH8BKnwwXM273mXHc9ewC
	 NlwfzoGdyu54iKk7dBJSyDmK9f4/HT3oJUke0+mER1vVGDMM06/fOJxh9YOfVHUbPjA==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bjGzH1W1Cz15cT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1752719245;
	bh=2hfIt5Vxb7ksb7hHHpKhBJWd0Jlq/So642D+Kbimna4=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=NUPrfLi/PrcfX5mJkFd6raA0oIH5kSCoy8ZcNqd/lpgEo5pRvc0Zdttoi3ixx7y2j
	 uDll5SG/S20KUyY5ejpN6zlpAiqUSbQ0Vzc2TDjBLw1l+/kXYVYdhtWtLNzR+2BmnQ
	 Bx7sTAwaVUgGTPKru4HKDxLGhfM97EMc/6hkFQuIhCBlpd8qwC3iFw81sXJ8AVfOUN
	 6TGpr97TNWdwid6X50WuNE4VN8AaZw8cGpYNumjWmRP8Xzl0P7McdnljywJvvQVlbR
	 V+doq95Pdh3kh2DLbsm4eTcG8h7S/hSEAKqP0yvaYKtl4kzg5B393lt/k/8jK3obE6
	 sbb7LdFkx/ptQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bjGzH1W1Cz15cT;
	Wed, 16 Jul 2025 22:27:23 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bjGzF51ztz15s8
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bjGzF51ztz15s8
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by lists.lttng.org (Postfix) with ESMTPS id 4bjGzF51ztz15s8
 for <lttng-dev@lists.lttng.org>; Wed, 16 Jul 2025 22:27:21 -0400 (EDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id
 56GNM8343690972; Wed, 16 Jul 2025 19:27:15 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 47wdvdtm20-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Jul 2025 19:27:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRRQXGR4YtFkWvmGbFTiJ4DK4wYrOjejbgwD3BjPo6TVUG889ietdkdXNZrKhuKbiMoOassuVQ1XUpqVpz+q4f1lfSifJFeOVakx56NBEiq2guwLPEPoYjzCODn7n1PWJlTzTx4fyIkIidAP4Eaq9r6SNaKHwmYG3ckUvDeBArp4MO7U3/cGdDf8y+/547ECtNZi6fY17uZPoSqn//wk2vu4BUKyJHiikjftqNfJvrSGUn6et4QC6HIrhNDpTAX5/sUv3w4UG6kce/xRoK5HbZb4qGMw2T9BpSy1G2UW6szMSq1Nj0lRKHQukz/a1QrCL9JPt02/UvVZ5L3fjZk6Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITfX6DEH5H0Msn0zRCE6QCCwsWJa4igq0cnJrmD/04w=;
 b=qXo/UhFr8WuUsQ7wAUIvmjaJNi+9FVVjHETbM12QHvSiImfLQvwuL3msWvCy42F2C3mi0Sddz9TzANbfxLYxmiSZsjds/ptzK0npBUL3Reb0UIZNkZVAxXniveeMURk/Spkv81eCw8YDC8ZRdZTbBADHkxWPeKi8Jbgr1eWeqTNZlqIbDJRnGgFUcxMsIQnpzrNb1do9+Pyh4DuJ4Qjl+pVImOkP2gcP/iZwtSxDkXNfyqfEe93tu6/70MvPTarqkET8hvYj8Dw/M7zvNmHQmRFIB4pyTx4D2K2kFSQjVtM+aAYwWpO49fN1jTs8+xf8//zO86eOMlHCgQ0lQJH0yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO1PR11MB5009.namprd11.prod.outlook.com (2603:10b6:303:9e::11)
 by SJ2PR11MB7575.namprd11.prod.outlook.com (2603:10b6:a03:4ce::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.37; Thu, 17 Jul
 2025 02:27:12 +0000
Received: from CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::7ff0:a398:beba:1ce7]) by CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::7ff0:a398:beba:1ce7%4]) with mapi id 15.20.8901.028; Thu, 17 Jul 2025
 02:27:12 +0000
Message-ID: <d3c56122-9c05-42fa-9d76-b32aa5f7a6fb@windriver.com>
Date: Thu, 17 Jul 2025 10:27:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: tests/regression/tools/clear/test_ust fails occacionally
To: lttng-dev@lists.lttng.org
References: <5fd7be0d-a6dd-49c1-b59b-34735e69b1f6@windriver.com>
Content-Language: en-US
In-Reply-To: <5fd7be0d-a6dd-49c1-b59b-34735e69b1f6@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SEWP216CA0094.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bf::11) To CO1PR11MB5009.namprd11.prod.outlook.com
 (2603:10b6:303:9e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5009:EE_|SJ2PR11MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c1929a2-a3a6-410e-8cef-08ddc4d96fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGVMWTBuUkJPaUlzN0dCVzRMbG5UMzlDNm40VWYzdTUrbHNNbFVWOFVyRWdU?=
 =?utf-8?B?ZUl3djJiMDBCanY3ZU1NUGtyS1hUdDhWNDBXWTI4Vm5iR0xGRlNHampmc0pS?=
 =?utf-8?B?NHA3UlZnWW1pK3h5TUN1RjJYT2tkUGdINFQ2NmdOdnRsSU9xcjF1Qi9SUG9Z?=
 =?utf-8?B?cnk0WUhKaTN3dnpkRjdMNGloNUhNTWhaRFFZSzVNY1FFWk1FZkR0Y0NqcFdI?=
 =?utf-8?B?M1hFT1FDUGV2QTNDdXkrY1h6bVVZWS9maDNMNm5rdDB1UjJjODg2ekJoeFpP?=
 =?utf-8?B?L0xvWTdHUEc2UEovMG9Rb1ZSeVZQT0EzVmpjZk5CZWJkOW0rY3pSY09Va0FD?=
 =?utf-8?B?SXMzU3dkTEl4Z2xHcVMra0RCUUZIR0pUcXBJSlN5OStOTnlHOCswRElMVVkr?=
 =?utf-8?B?NjdwRDYzRkpCaWdGTEJRQW9jelk5RTRRRFYyR3dqUzlDSVhEMUY5NmxzNjdT?=
 =?utf-8?B?VFVhditYSGptODVNd0ZMTzdSTEVhOENCNUwvV0NSRCtzRmt4MXNSYjczSXIz?=
 =?utf-8?B?QVFWRGJKbXNGZGd1RUxNTjBZNDVKSHRQa1dLN2VJTVB5L0dLOGE1Lzc3amFB?=
 =?utf-8?B?UjJBMGx2cTZGZzAvZlRJNjQ0OG5heVE2UG45QzhkQUliWjNsVi95aTRuVW80?=
 =?utf-8?B?NzdvTkR4aExUUnNTcFFOZFVKT2JTVHVUTTFydTQ1RFR5MVhuUStaSnFYSXo2?=
 =?utf-8?B?SjJKOUR5Q2p4NXhKYnkwUlpZNU9sWDdkeFlQOUxsV2FUTkpMQlNidjlXTzV1?=
 =?utf-8?B?ZWcxRVRrTmtPVGNKY0NMVTBsUDdSODBOZ2J1SU5vVjZXL2tISllRTVFkL3Zs?=
 =?utf-8?B?NnVYK1VkN3B5TDE4ZndPanllQ1libERVZzhha1JzOTZDbHlSUjdyMmowYUU4?=
 =?utf-8?B?UXllbExqcUNWcVI4b1U5dEsyL0RocWV4RkFjTzBRekF5OTJ3aWh6RmN4V2p3?=
 =?utf-8?B?bGZVYzBVL0RlK1FkZGJQelQwZnpTcklYRFRSVDNyUWpXUHdKaytrRlgvV2xr?=
 =?utf-8?B?dUJWWWJEeGszUlp4U2UxaUR1a25TY0ZKNWllbUtTYXZYckwrbzhISFVPRWdV?=
 =?utf-8?B?bFBiazE3N24xbVJFa0VOUzlpdFVNNVc4cG5kcjlZRG9wQzlMQktIaXBmSkN4?=
 =?utf-8?B?bk12bkdPS012Y25EUGgrRTdTQy9NQURiWlhtZDgwM253YkJaajN0UTdIS2Mx?=
 =?utf-8?B?K1I1bzAyOE1HOWFYdUUwR3hkbW9Hb3BOMzNRK3A2ZXNCcnFEZzhzTHNLYVJy?=
 =?utf-8?B?cXgzdmZwc1J6ZGIzQlNuNWlGL0xWMm9nWmVxTE5LblJsdDZla1RjMldRT0JB?=
 =?utf-8?B?STd5WFJhVXU2V21JL05VVVgyQWNnREtCMjZGSjkrK2hsRGJGZitUQzVaSU9z?=
 =?utf-8?B?Mk1UWDdlMkdSWUJaZG5GTXJUZFFuL1pvQm1uSmlrUlVwSXZ2eDB3eHBoNnV0?=
 =?utf-8?B?U1ZEL1NTdkppeitBNGlWTCtRVlQ2aXVVL0d4cXBDSWZacThMc1dCRnhrRXhF?=
 =?utf-8?B?K3E3cWRvT1BLNVp2REhEZTJjV0ZIb2o5V1B6eXlRT3BlL2l1NjdKaVVoZXdx?=
 =?utf-8?B?cS9ybW9RSDhqcCs3WDNST1BCK2VpdUJqeDdaQzR3SHIyYUl0T3VvbkE4MVQz?=
 =?utf-8?B?a2RJUWM2UEl6cDFITHNEdTI5b2I5amRScEZrbER2UjN5S0dITVlydi9FN1BO?=
 =?utf-8?B?eHpERm8wSVdxZHNtN3VrTVp0NkZIRHdMSjFjMkJpUlprc0EvTDNKYVltYWll?=
 =?utf-8?B?Z3pYZXgxQndnNitQZUloVlo4UFNoTUhmWTVDZmJYYlJSZk1pYkdibXdCQS9L?=
 =?utf-8?B?WlRIY0lRWmdRQjRlaysvandYekIyNmhJSHRta1czd0xyQmdISDZNcGpnM3BE?=
 =?utf-8?B?WUlKbFBwY2VzdnhmanU1amVyWjVUcDZ3WHVjcUgzU0pFU0ZIdWRvUGhJS1hH?=
 =?utf-8?Q?nFGa9IKHDYI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5009.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU55ZXZRUEhZWmFwVmplVUdJQVlwYVdHa28wWFA3TmJqZXA5SGp4MHJaaXV2?=
 =?utf-8?B?Q2JmN2RybmVONVdLNjR2OXBoTU1OZjJ3MngxVFN1MnM1UkcyVWhadTNDNWhy?=
 =?utf-8?B?d29CejlRQzVxOVpwSC91NGdXa2s1UUc5YmRZYW93NzBmYmNEMUF2aE9JZDRy?=
 =?utf-8?B?a3VaM1VCN0owamdZd2RjVXYvNmhVZFM0ZFlkZTJWVDJJMklhSE10cytWT05R?=
 =?utf-8?B?b3lhTTJKWVJxWkxpbm9ubzZTS1dxUXM3YXUwdXN0VjZhTEgrSHRHZVl3RVVj?=
 =?utf-8?B?NC9NOTlLTmtUcVdRVnhST2h1Y2hMRzZJNkZLdGdwdzFMS2dwTmlPTzdGR0to?=
 =?utf-8?B?SForLzQwMG9Wbk10MkY3R1h6RWIxUnhZVnFkUFRibTc1Rld4VmNSSTl4azNk?=
 =?utf-8?B?dHhnekFTNEdiSXc0Q0dVbWptUDJNZ0tybUhNZWtaQ3RXdk1CRUZCV21xRUxH?=
 =?utf-8?B?SDMvZFFnejJQK3hLeEFsOWNLbUREbXJ4RjdGSXZEcDZPdUhZY3lzM09vVkxy?=
 =?utf-8?B?MFpuQWlqMEJycGtaSDdtcXhDNmljNm9YM09IS2tJMXlsMCtkTGwrazY0Y0pY?=
 =?utf-8?B?cWFsN3FmK2VrR28vZGtXUTU5Z2VxVG1UQndWT1pCWHFQOFZDaGlxWHlsY2RU?=
 =?utf-8?B?emE1VURsMVdRQ09BZnZhekxQTWdrNi9HZytxdzk0alFleG80K3JML1VZRzJm?=
 =?utf-8?B?UXEyTUpqUit2RmxvQnpORlpEUDJtTTc0eTJYZDVNN240cTJ4VXpXZXdjd2pH?=
 =?utf-8?B?Q3NLcGMzeDY2VTBlN2xyUkxwV3FQUHI2R280M0Z6aExjY0dLRlByT1NHajND?=
 =?utf-8?B?TW83UDZORGpHdWRkdWNDbWtMTWZqS2E2T214eHE1b25JTHFaY0pWeWhFTjhz?=
 =?utf-8?B?bjkwMkhjb0x0bC9PU3hRUkdvZnpaZ3Jib2FvTjQvbXkxUlNRZkFjWXhPdzd1?=
 =?utf-8?B?ZXJaY3A3d244VXZFR0k2c09nUkVnLzJBa1JBYUgrODMxTkxGUTNqYmhxRHMz?=
 =?utf-8?B?aHFIb21NTmdpdFFOcngreFpJU2taVmpwUkYvcUxKZHpLM1hIWjVra3BBR2pI?=
 =?utf-8?B?dy9iaU5sWVRFTXpJeWFBVm5sY253Ykk4Y0FkcTQ2VGU5Nmt1N1g1MlpzZEpT?=
 =?utf-8?B?M052VW1DdHQySUZRQ0h2TjNjdFpWby9HZ0lSTnc3ckk2TktKTEZ3eG5mQjJw?=
 =?utf-8?B?dW0zY3R1QnhxQnVxWDhhaXRibEZWLzJhbVVlUERhVmNKWXNvZG90L0JJV0RU?=
 =?utf-8?B?Y0ppQkl2UUdsNGlvWXRJK0JTak9VTmtneVZzOHR0a1VsSWZkY2xqaGEzTWlJ?=
 =?utf-8?B?VFFWWW9iOUUzc1RiZGk4NVpQdGxrb0Q1MnJSS0VQelhEeE9aRjJ6TDE5aEp4?=
 =?utf-8?B?THRhVnl4ZmZPVmtQRk56eityanhyQzdVc2RjL2pCcWlJUnVDV1lFYm5tVUc5?=
 =?utf-8?B?c2dkeHBIbjdHR1hDN3d3N2NSN2tLeEpzaC9WczEza0JGZlQ1bGExNG1uSVM4?=
 =?utf-8?B?RGpqUjdybjdoTjVuOUJGdDg0enJzV2NvYmliVDA4KzM2NmNhNEVBR2MvV3VS?=
 =?utf-8?B?Y0VoMElPMFZMNi8rdjhEM1piS3FPWFhGMmg0bUIxY21mbUU5MTVxTUVGaENH?=
 =?utf-8?B?VUNXTkNvbldoaW1IT3BVK3BDN1M3T2hyL0czbnhoZDdqUzNDM3k0Y0x4ZHlN?=
 =?utf-8?B?ak1KbzBKeXdQcXB1dHhjNVowYzU5dElUYlhmUGw3TTdzNWFIbWNCaVpqS08z?=
 =?utf-8?B?cFN3dTN6bU1iWERmM0ZQM0Y1RGZVQkxNTzF3OVY2SGU5T1c3Q0swUFphS2o0?=
 =?utf-8?B?a2NRMTBkK0U1bm5NMFNmZTBybnp6OXE5bThrUmhsQkFEYjF0MkdXVEp4ZjhO?=
 =?utf-8?B?TWVsUGorYndPc3U3eEZrUy9NNW5jZjRvVlNheEg2NldkTkxTNkduTnpVekdX?=
 =?utf-8?B?RS8wNzM4Q1JMRUZGOWdYRW0yMjFVM2dScUFQcEl4YVhubnRHTEh5ZWxOOUp5?=
 =?utf-8?B?TGtYdkQ1eTd6RWJ4RFIwZXM4dWVuS09uYUJPanlxbjY5MVk5SDNHQTV2ZkRN?=
 =?utf-8?B?ZHlaRFR0T2FwaHM2c0xkS0pncXRZSTF5QTU4WHpqRTBPejdZRU9RcVg0TUlO?=
 =?utf-8?Q?BiDcruM784cWETORCsz4ug3fC?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1929a2-a3a6-410e-8cef-08ddc4d96fdd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5009.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 02:27:12.2495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOngXk3tad3eF6JO0xyywkl+viAoG0aHpxPuuClcmY8QRf4iDRSCPJ4/qhXcaFeiszLmnupa+jGQGres5rYcqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7575
X-Proofpoint-ORIG-GUID: sFNFF7_nyo5RHqUEK24gnxEhiFoSKPrZ
X-Authority-Analysis: v=2.4 cv=JbC8rVKV c=1 sm=1 tr=0 ts=68785f83 cx=c_pps
 a=k3z6I4pdfs0t3+GLVInSVw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=u8MPRc98t8yoIFhwJ-IA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: sFNFF7_nyo5RHqUEK24gnxEhiFoSKPrZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDAxNyBTYWx0ZWRfXwgIaVALSRNmg
 2kydmY1qqTF/02yMG6o1gAzTTsUZsy6pwFhqfUBOGGV63FDzW8OFZwIDmVDc3X5hIxJ7IGjkZNl
 KMXz79aIIvMOlKSz0y6zKWmON6zoQDjC5ANZAdTQSzunmf+jRiEUHqpb8FE1faAWT/1EaAde/h3
 X/iz56TKbIkEpt96EMw0e+T4ENlajIdIivVCkD4WWbbYU/2hKAsm7AiMjYdGC8jnz8DwUj1Kt94
 xjFHZkHlRXYqomJ6HN2iGLjhgai2ghEHkIWMQXlR2/lvj49ytY6Ak5bTGDuNlJnPgiy3zH/T5xY
 O5+mEgIuQM2bJ9NLx/Q+MU5pvTFO1m59mvRVh7cvdL4Uc1afWUUDQYmy0oF6pR41nmCw4KKpjFK
 BvapQtFe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2507150017
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
From: "Yu, Mingli via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Yu, Mingli" <mingli.yu@windriver.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

The more detail around the error as below.


[warning] [Context] Cannot open_trace of format lttng-live at path 
net://localhost/host/qemux86-64/ggpndHBBanTXM3EY.
[warning] [Context] cannot open trace 
"net://localhost/host/qemux86-64/ggpndHBBanTXM3EY" for reading.
[error] opening trace "net://localhost/host/qemux86-64/ggpndHBBanTXM3EY" 
for reading.

[error] none of the specified trace paths could be opened.

# Wait for viewer to exit
not ok 486 - Babeltrace succeeds
FAIL: tools/clear/test_ust 486 - Babeltrace succeeds
#   Failed test 'Babeltrace succeeds'
#   in ./tools/clear/test_ust:test_ust_streaming_live_viewer() at line 324.


Thanks,
Mingli

On 7/14/25 17:37, Yu, Mingli via lttng-dev wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender 
> and know the content is safe.
> 
> Hi,
> 
> The lttng-tools test fails as below, is there anyone meet the same issue
> and how to fix this?  Thanks!
> 
> 
> FAIL: tools/clear/test_ust 486 - Babeltrace succeeds
> [snip]
> FAIL: tools/clear/test_ust 706 - Babeltrace succeeds
> [snip]
> FAIL: tools/clear/test_ust
> [snip]
> # Wait for viewer to exit
> not ok 486 - Babeltrace succeeds
> FAIL: tools/clear/test_ust 486 - Babeltrace succeeds
> #   Failed test 'Babeltrace succeeds'
> #   in ./tools/clear/test_ust:test_ust_streaming_live_viewer() at line 324.
> [snip]
> # Wait for viewer to exit
> not ok 706 - Babeltrace succeeds
> FAIL: tools/clear/test_ust 706 - Babeltrace succeeds
> #   Failed test 'Babeltrace succeeds'
> #   in ./tools/clear/test_ust:test_ust_streaming_live_viewer() at line 324.
> 
> 
> Thanks,
> Mingli
