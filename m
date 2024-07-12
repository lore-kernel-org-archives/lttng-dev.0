Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E28EC2BD09
	for <lttng-dev@archiver.kernel.org>; Fri, 12 Jul 2024 14:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1720793836;
	bh=CngeGvCoydxz9dvlyuE/mCBuEicDeW5M5xsCFnsWbxM=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=HTiHITMVr/C8fO2DvvJNu/qtsMM9dceWCIlOv36YS4lRQKES8TLyzM7p0SPQKsI1P
	 Ab85z632b002BafqiTvvBORnDdescaIoEIbLJ7PbM7yjxz98WXtep+xmt8nhxt0afe
	 4Ku9uPValFdezTxzMdCQsEgws9wR/FpA5eFVPEuKdHJ7AtVvCVw4DQRr0qqYPflvWL
	 iMIhRl4dIIdSLH34q75HMM8BYmxH3tKLhAvGntGE4w6V+qfGXYtHyioKeuoKsohxl/
	 DVhMoOKGiixGwj5yVDKEgMmXaYmKtEqeTnXic1KyGgpPNYszEPxyEnTqR6WV3i7vqs
	 fh5kx+Ehdf4+g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4WLDF725nszBWt;
	Fri, 12 Jul 2024 10:17:15 -0400 (EDT)
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazon11020132.outbound.protection.outlook.com
 [52.101.191.132])
 by lists.lttng.org (Postfix) with ESMTPS id 4WLDF45zz8zBLP
 for <lttng-dev@lists.lttng.org>; Fri, 12 Jul 2024 10:17:12 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NoM5uDjVigDXEaA9qnNUFwmEs8Qfo1dH1tyZ7HfI1sVHqWhIMxml+AoTY1/kI9PjoXWpisTJrB7EsZcOrgFFuKaBrTuCEXAy/kNxVFaXVfcBB84rN7WN4BoEfmmFXb/2g6V+RTWhmjnXV5+QfOFJXeleOsE7DPmziC8zf6Q5AyWNiy/1TxpMDIYXb6Iswm6UMsvz946amhXqSKfNdUAw4Sua2qFBwGLD3eU8nkwW2EagBYAw4igTjntF5SZftCcm9jtKd0De0bq0CaH6Vi004bw8NVIO2xj23v5ylJ7Z1vKEDareV3+k8E+1nBoEQ+ak7rScYDL/pGH+4iBGz+k5jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+4MHIHGRjOyGxUO1SoR+0uJJe490hb25OzcNHmi3yQ=;
 b=xNrgZrGhxc+6eSSBJlgzi6OiiixnYnapOaX37VQptd77FfSCl5Ue2G+xYuWQMDa/RZwspTDJ4os5+NHxje/lG3wlo1uQhj6L7xJPV49/gxFWZc6uKM+scauXgpDoib+DHAmWJOOZfYdOy0i6hakMTS0F05LawbcXgdF7wOzlh0vw9gLU4/6TTwEmG8Ml8fzcm4A0eL3l5YcSEBvBOtd8N1+eDx1Mw/uPx1TA01xwzNDWk4oQjisMfQ8EGL+ew12qjxmq/Q7RaNOloSC8rdT6h3h5vpOQNUzTyo3Ptfp05l0sS0qNV3mft8vf1k2MS/YSxGBZyz44Cbwc+txw8uLuww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT1PR01MB8794.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 14:17:10 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 14:17:10 +0000
Message-ID: <4c310b50-e341-4c36-82b7-a023500c2b49@efficios.com>
Date: Fri, 12 Jul 2024 10:17:09 -0400
User-Agent: Mozilla Thunderbird
To: Brian Hutchinson <b.hutchman@gmail.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <CAFZh4h_wh01sjAar-QqHsQ=KY4zLjmpmXuJc83OeYue7YyYW3A@mail.gmail.com>
 <CAFZh4h9iaCGdnDhxik9Qtq82f0MGU2eL+8nBa8qoCCJrH-xsGQ@mail.gmail.com>
 <d30f1655-0efa-440a-ac17-fe82342f4556@efficios.com>
 <CAFZh4h9hyQj0JV5_pA4tQyoB8hTAfkmWbmZ2jJW2Vcwk4NMVig@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAFZh4h9hyQj0JV5_pA4tQyoB8hTAfkmWbmZ2jJW2Vcwk4NMVig@mail.gmail.com>
X-ClientProxiedBy: YQXPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::49) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT1PR01MB8794:EE_
X-MS-Office365-Filtering-Correlation-Id: d1fd8c32-4906-490a-084c-08dca27d5197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bE1wMzgrT3J4dlpEN1JmUFhFUkhiaUYzLzk3N1hSbk1qVnRUZlUrczd5cEpl?=
 =?utf-8?B?UjFHMHQwNmUycEpPZklIM3IrbVJNZGpWaFdKUHZ3ZXFSb0N2emVnNmw0NzE2?=
 =?utf-8?B?SUV0Y2VvekpsNllZeDlSYy9ieEhIZnFkaTZ0Ykc0SkRFR21nVXVxckFjYmlL?=
 =?utf-8?B?cE5yckdTYm0rUEliS2xlUmVNeXYzc0NCNEZuMC9YelRuSFNiVENYRzlvRC9t?=
 =?utf-8?B?ODhzMDBMS2RVd05VTlFoQWZVaVE5NUZRWVoybzVrblZoOU9OdzZ3UnY3MFZa?=
 =?utf-8?B?T0dZbEtPYmdTYlRkK2tVUndYVlYzaGFXZlZVc2hHQUJoMkZ5VmdoOFlJb2ZK?=
 =?utf-8?B?SGVlUXQ2MzVOeEcxWVo3ZzNLLzlvNEVJRmMyZi9sM3FjeFE3bXA4am5mZFFW?=
 =?utf-8?B?MHE2YVBSTTZwV1EvWnBFQ3Vhalp0T1grUmszenlLZmNkb3YwTzNmeldOYWNW?=
 =?utf-8?B?NWNaek0zd3BiZEh1SS8wckRxYmovWnZBempzNlE2QmkwckU0Tk5PQUpKcmhz?=
 =?utf-8?B?c2pJNlRVYWx2ZmNrQmszc3dTamFrTFRxZnVJdThidy9ud1pEdmd0dWZzOEoz?=
 =?utf-8?B?TGdiNDgvSEJ1OEp3R2dtcVZ3QmV2V0R4Q09Oak56aE9NWk92ZGZnTER5bmd4?=
 =?utf-8?B?WGNLd2dOTFYyWEZLa2haRUx5dDdZTWRTRDZLditzYXA0RDk3YzVMaEVPdUJa?=
 =?utf-8?B?SElVU2c1TVFoanJ0UnBWN0MwMThJYWJ4dTZQUFNSaTlPbnJUcjVmSXJxMEdX?=
 =?utf-8?B?MG9pa2dpcjV5SHRRanBxV0V2Ny9wUEd3cFZ6WitCbnpJd1BYNHluM2IyR0dX?=
 =?utf-8?B?OERySmI3emJiVDFVTVZDdHJvdTA4bnZtdE1RaTB0OVdZN0JFVUFvZUFlQlhD?=
 =?utf-8?B?WkloWmJHK0lUOFlrTkRzQ3JHVk5OWm05SnpsekZpdVZyRDhDbmlmTnpnS0RB?=
 =?utf-8?B?ZmQydlJiY2IvaTZmNmt2UHdnaGEzREw4T0RTaC9VZ2RLVzAyRkFoSDFLRHQ0?=
 =?utf-8?B?YkRXUUdDdGhNZmFBUzBjNjBxUlVhTlpFdnhtdjk1eFR6UllPRXpSV3kyaml1?=
 =?utf-8?B?aktOOW55Y3pqeWVEOHE4Sm80akxhcnM1TTZQbUc4Wjk2TER1MHlGS1h1Sm8z?=
 =?utf-8?B?ejJXeGorZWpHSlhrdDlkNnJOd3RMNW1mY2RwUHVUcGZ3cnY3R3dLdXkzd29w?=
 =?utf-8?B?dGRGOWQ1dlNQOFN6aTJMbTFOZlZwcHVoOC9JYXdXakIyOTV1ZlFrcGgzOVdL?=
 =?utf-8?B?LzlCbThWeHFzaDRDaXBpam93MWxvR2JJSW1KaXNHbDMyaU90QXJDcE4wd0lQ?=
 =?utf-8?B?eHNmTno0YUhXbzRrUlA2Q0wwT0J6c2kzNVZacUx3WTB6RUNZaGVxUDJhUHJl?=
 =?utf-8?B?aU9Zb1RmNy8rZlJPcW90VUlSRVlqaXlPb2F3emtOY0gxY1RxQ0J5RDlFb0RW?=
 =?utf-8?B?ancrc1pLUEc2eUl6QlhDN2VrWlM2aFdubWxpQlBNbTQwR1JWK2JsTWNvUW1H?=
 =?utf-8?B?OWlhU25IaEN1VzdUcmhuTG82V1owRHFiM2o4RXEra1FvV21Db2piV2F3YXJB?=
 =?utf-8?B?UWRFdXcxMjV5UWxoWVBwUFYzLytpUnEra1g0Zk1YS1ZsQUMrMEVpb0VzVzJq?=
 =?utf-8?B?ZUVwVnZKSld0eFBzSVpnNFVDTWFRaHRPU2M2Kzh5YU04em9nUGRXUGtRaDYv?=
 =?utf-8?B?VE1OQm9aakNOZFQ3RFpZb0xZR2dFZnV2Z1lWR0gzOHpHQXNkaDZFenZqeCtH?=
 =?utf-8?Q?SxpcKnyayJCSZ51eMM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djdzTzhHU1h6QWVIQ2N4Ujlkd0JlWjdpUVBaQUk5TkJjL0w2azhlVmI4R3Rq?=
 =?utf-8?B?QnRrL2RCWHRBRWRpWlNVemV0ZWk1cldzVW53MmppSVcreHZaN2J1SXU1dWJa?=
 =?utf-8?B?ekJuYVUvWTNUWW5QWm5zTkQ2YzBYem5rRWRoV0NhUlBiMWJGR3dEbHJMaGI2?=
 =?utf-8?B?dmJaQ2U0ZysySG9qTGFMVll2SyszdkRsZ1BhdzFBQjBXdU5Sa3hIMGc5ZjUr?=
 =?utf-8?B?RTF2TSticFQ0TU1DaGJqQU9zM0VoMTlqTFNrMm1BMUZhK29XeXdsRGl4T3RY?=
 =?utf-8?B?cXhCZXlHaC9jcTh1bHJuYzE0WFRWTTlaUy96M1p1OTdDZGZuWkZhRHVNbFhY?=
 =?utf-8?B?c3VHSCtnaVFjdnFGNExwN3c4WmFZUnE5QzNOeXl5MFREM3JSY29QdmMyOHpV?=
 =?utf-8?B?UklBKzI5MURBK2lMWk00S2xrMnNWK0JqRzRLc01JaUI0QnRUa1hiUTRaMlBE?=
 =?utf-8?B?N21vQW5Ya1ZVSDBXS1h1R3cwZUxnbUdiTG9aV3puR2cxcG9TYmxCTllqRm1C?=
 =?utf-8?B?YUtWdExrcmw4ZUdUQ0RqaXdTdUYxbGVvRHgrV0xMVVFtMUM3eGFSZDFnd3Fv?=
 =?utf-8?B?QlY2dm5sbGtQSWs0ZXVNZy9EWGd3bFpsZDlBemtCT2dtUnk1NjV6bGJWdjBZ?=
 =?utf-8?B?RW4wQ2QwVWt2eWFKRlJXM205ME9JTXV2L1RndElObGkwMHhRM1JWbUw0bUZj?=
 =?utf-8?B?QyswUXJFU3FxbWlBS3VUSEx4MTJCRUNydVM1VXplT0hoRFZEL1JWQWYvL3VB?=
 =?utf-8?B?bmJwSDBTK3JGNzFZSWNVNFM2dUJXK0dJYXhFTmVOZ1ROWDI5RzFXT3JQOTQr?=
 =?utf-8?B?cVNpdjRVVnFJdEZndFl1QkpQaUJZUUpGZENmYjFndGtJMkgzNU5kWEpGOXF2?=
 =?utf-8?B?UUs4U1AwdVpWM1BBeGtZUjZwTm83VnVNNUtlelJkYWZ0RDRJc3FtUkFRTzA3?=
 =?utf-8?B?UjZKRW9KNWFpbDQwZWFRTGtPb0NEa2xqVkRGMUFORzBsQ2gvWmJXZXFRbDE4?=
 =?utf-8?B?TGJRcTRkMUREWEtGc1VMZnY5WkowR094ODYyc2dGS09jSjhBUThJWWp6cjI1?=
 =?utf-8?B?cGJaNjg2M2k1UEFPUmxYeUZpNmVuOU9WSVExTG1MZHcyZFFJQjVzMVZ4dDhX?=
 =?utf-8?B?OTIyZ3ZrNHBUVjJpQndvd3E1Q2hWd21sK1E2dHBnbjUxdnRIK2JLdzdsdHdk?=
 =?utf-8?B?UkdqNSs3dkljdTN1dWRjQm91cDFMRG8zZ0YvY0hEUmdHRUoyQmNRNnBGU2J2?=
 =?utf-8?B?SzFlWVNkekkxNldNUWpNMlVzOURTTkMvSXB6Zkx0eTZIeUNKdlBKWU5rVmdy?=
 =?utf-8?B?eHErbHp6T0RUMkMwZkdCWFNTR3JhWjlhaUFscnBiSWFzREt5YlBqVUZ0UnB2?=
 =?utf-8?B?dTBqWjQ1KzB2SU9UT1JOM1Z1SEVwc0dlTytjU0JxTU9IQjlScDR0cUtHYUUw?=
 =?utf-8?B?U3ZkY1BjKzlNaTJ2M1ZKb3lac3NpbUh5ZGRMUS95cSs3RVp0VmNqK29oQnZC?=
 =?utf-8?B?bGVadUpGZm9kdlBSNW11ZllibVZEeDdxZ3gxckpxcmp3WUJiNUUvWUNETTYx?=
 =?utf-8?B?WjcrNjB0ZE45akZIaWk5eDF5T2lNK1VWTjRQNmJoMVdWdGdlVTgrNmJ0Yncy?=
 =?utf-8?B?bFo0cDRFdlgweCtGdGMrNGM3ZjNGN1QrQzdtcEltY0VvMzhHdzVZS2NoN1RH?=
 =?utf-8?B?bHlhSXVVcFhQSkpnazFPOUhFV0srU3VtMzZxd0xGYUt3ajlQMGdKQmNHcjEz?=
 =?utf-8?B?b2ZnRnRzRzg1ckZ2WVpLdjdFL3d5ay85TjhLRFhHdlVuUUw1TTlCTTVNSS8z?=
 =?utf-8?B?bkhYTUNaTnozWi9vSFFHTDQzc29UQVFxNnZldk5RL2NBYklNREJPL000UE02?=
 =?utf-8?B?aTBncWxxL0hqK0NTb3ZpbmZMbnNCbk96b3p6UXYwT3Q1UEIzODdFMHUrVGRH?=
 =?utf-8?B?M1ljOTVtWWhySmFXOXdvTzBGYTJNcmR1YTRmNHh1ekRiSkh4WS9SUVlsczVt?=
 =?utf-8?B?MFBmWmZ2aFJYL0FuQzZoMjdabjgwZ0pyZzM4bUdSckdxVUlKRWZkVGl4WWJL?=
 =?utf-8?B?Q2N0Tml1YUdSMjI0bFZNMVA3a1I1U3ZRZlZneGcrSDVML3BYUFh5T1cybUY0?=
 =?utf-8?B?Nnk4dlEwTWxwQmZhdVR0TVljYzVWZHZneFNod2pERDBvZks1TzA2dlJNeXRZ?=
 =?utf-8?B?Zmc9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1fd8c32-4906-490a-084c-08dca27d5197
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 14:17:10.4125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJhxV8gfzT/UKIvyE36vZwzfj3RIARz6dOb4QlgiA3cPg9YONpST8u5y4oJuTdg3M6MxTq0zBBsGIeP7BgUWvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8794
Subject: Re: [lttng-dev] Using lttng-ust 2.13.6 from Yocto Kirkstone and
 getting weird segfault saying strlen_asimd.S can't be found.
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

SGkgQnJpYW4sCgpPbiA3LzExLzI0IDc6MjAgUE0sIEJyaWFuIEh1dGNoaW5zb24gd3JvdGU6Cj4g
SGkgS2llbmFuCj4gCj4gRG8gSSBuZWVkIHRvIHVwZGF0ZSBsdHRuZy10b29scyBhbmQgbW9kdWxl
cyB0b28/wqAgSSBkaWQgYSBiYmFwcGVuZCBhbmQgCj4gcHVsbGVkIGluIDIuMTMuOCByZWNpcGUg
ZnJvbSBtYXN0ZXIgYW5kIGdldCB0aGUgc2FtZSBpc3N1ZS7CoCBJJ20gZG91YmxlIAo+IGNoZWNr
aW5nIHRvIG1ha2Ugc3VyZSBldmVyeXRoaW5nIGJ1aWx0IHJpZ2h0LsKgIEhhZCB0byB1cGRhdGUg
c2RrLCByb290ZnMgCj4gYW5kIHJlYnVpbGQgYXBwIHdpdGggbmV3IHNkayBldGMuCgpJIGRvbid0
IGJlbGlldmUgc28uCgpEbyB5b3UgaGF2ZSBhIG1pbmltYWwgcmVwcm9kdWNlciBleGFtcGxlIHRo
YXQgeW91IGFyZSBhYmxlIHRvIHNoYXJlIAppbmNsdWRpbmcgdGhlIGJ1aWxkIGluc3RydWN0aW9u
cyB5b3UgYXJlIHVzaW5nPwoKQWxzbywgd2hpY2ggdmVyc2lvbiBvZiB1cmN1IGlzIGJlaW5nIHVz
ZWQgaW4geW91ciBlbnZpcm9ubWVudD8KCnRoYW5rcywKa2llbmFuCgo+IAo+IFJlZ2FyZHMsCj4g
Cj4gQnJpYW4KPiAKPiBPbiBUaHUsIEp1bCAxMSwgMjAyNCBhdCA4OjM44oCvQU0gS2llbmFuIFN0
ZXdhcnQgPGtzdGV3YXJ0QGVmZmljaW9zLmNvbSAKPiA8bWFpbHRvOmtzdGV3YXJ0QGVmZmljaW9z
LmNvbT4+IHdyb3RlOgo+IAo+ICAgICBIaSBCcmlhbiwKPiAKPiAgICAgT24gNy8xMS8yNCA4OjMz
IEFNLCBCcmlhbiBIdXRjaGluc29uIHZpYSBsdHRuZy1kZXYgd3JvdGU6Cj4gICAgICDCoD4gLi4u
Cj4gICAgICDCoD4KPiAgICAgIMKgPiBJJ20gbm90IHN1cmUgYWJvdXQgdGhpcywgc3RpbGwgdHJ5
aW5nIHRvIGNvbXByZWhlbmQgZXZlcnl0aGluZywKPiAgICAgYnV0IEkKPiAgICAgIMKgPiB0aGlu
ayBteSBpc3N1ZSBjb3VsZCBiZSByZWxhdGVkIHRvIGFsbCB0aGlzIGdjYyBUTFMsIGhlYXAsCj4g
ICAgIHRyYW1wb2xpbmUKPiAgICAgIMKgPiB0YWxrIGhlcmU6Cj4gICAgICDCoD4KPiAgICAgIMKg
Pgo+ICAgICBodHRwczovL3d3dy5tYWlsLWFyY2hpdmUuY29tL2x0dG5nLWRldkBsaXN0cy5sdHRu
Zy5vcmcvbXNnMTM1ODQuaHRtbAo+ICAgICA8aHR0cHM6Ly93d3cubWFpbC1hcmNoaXZlLmNvbS9s
dHRuZy1kZXZAbGlzdHMubHR0bmcub3JnL21zZzEzNTg0Lmh0bWw+Cj4gICAgICDCoD4KPiAgICAg
PGh0dHBzOi8vd3d3Lm1haWwtYXJjaGl2ZS5jb20vbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZy9t
c2cxMzU4NC5odG1sIDxodHRwczovL3d3dy5tYWlsLWFyY2hpdmUuY29tL2x0dG5nLWRldkBsaXN0
cy5sdHRuZy5vcmcvbXNnMTM1ODQuaHRtbD4+Cj4gICAgICDCoD4KPiAgICAgIMKgPiBSZWdhcmRz
LAo+ICAgICAgwqA+Cj4gICAgICDCoD4gQnJpYW4KPiAgICAgIMKgPgo+IAo+ICAgICBZb3UgY291
bGQgdHJ5IHVzaW5nIGx0dG5nLXVzdCAyLjEzLjgsIHdoaWNoIGluY2x1ZGVzIGEgZml4IGZvciB0
aGUKPiAgICAgZGlzY3Vzc2lvbiB5b3UgcmVmZXJlbmNlZC4KPiAKPiAgICAgaHR0cHM6Ly9naXRo
dWIuY29tL2x0dG5nL2x0dG5nLXVzdC9jb21taXQvNWRiNzE1ZTgwMGQ5YjcyMWY0ODQ5NWE5ODdj
ZDI2YzI1OTY1ZTgzNiA8aHR0cHM6Ly9naXRodWIuY29tL2x0dG5nL2x0dG5nLXVzdC9jb21taXQv
NWRiNzE1ZTgwMGQ5YjcyMWY0ODQ5NWE5ODdjZDI2YzI1OTY1ZTgzNj4KPiAKPiAgICAgUGxlYXNl
IGxldCB1cyBrbm93IGlmIGl0IGRvZXNuJ3Qgc29sdmUgaXQuCj4gCj4gICAgIHRoYW5rcywKPiAg
ICAga2llbmFuCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRw
czovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
