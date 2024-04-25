Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6339FC4345F
	for <lttng-dev@archiver.kernel.org>; Thu, 25 Apr 2024 15:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1714059789;
	bh=Oe5mfa2FLd+2izgLYSpU+rkdOoF88fQTXgwp1r8MQPg=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=BOjJ7QKJU1ElucHuFNe5ua9NZCX6MRQJPUmpaGrX5WNJIGpZkyMOX0yUPsMg1J2WQ
	 cnS3hzQDrD3KvvY6NCzZaCbmrfJdumLYXrusJsxCOXX5GzzptVH9lUwKrPRur+mS8o
	 5MaBPnRxhgzHpp85XsgMTW+v0bQbfLk0JnR+1J/GeEFyrgp3N0X/Qvdj+34y5wWMlB
	 zAxQq5DnWSepS5ogNlgA9d5Z9gEOC0GvHVYTDU4GcvkpPaFZ88sPZY8QVSGohzdyhQ
	 +zKFUpNTb8RxpvoYFGJNl1sroKHCH+94DqfDj/EbxWApN3hGTFR2vJ9tUy04FMytYK
	 JDm5SxOAVd44Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VQKrF2yMzz2jll;
	Thu, 25 Apr 2024 11:43:09 -0400 (EDT)
Received: from YT5PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::2])
 by lists.lttng.org (Postfix) with ESMTPS id 4VQKrC2wRjz2k7w
 for <lttng-dev@lists.lttng.org>; Thu, 25 Apr 2024 11:43:07 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKMZYhYJmbATgX7w3Kyajt3kXu4YdcKh9uIY1L7PmihuLy2qIiUSHXKl+3FqviCAyGG4Pp9n58PIHAqKSZDk5KjWSyC/kViLVfByWEqHeu0GnJhrP1XxGimLAhKgZ9CMKjCU/bLFvl0O7m8ag64o9rOxb5QX0uAWxQ4XC20GomcUL6D9WMJk22dw9LEcRMdkSRLenP7tdnoKzMJ0JRkcNVdcS25tiZxb1PeV1xvBKyIIzwrvOhEobo7r9uW8hprkVHBBlUV/9wCYqSMvb5zOyMTFwj9Z4ajsoHvcETaxKcvMJy8Y2tptbhmqy/i62qsAC3H9rlPQp+0Z3B0Ew/Eokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PMAeE7AuCR9QlukiHMloKhpRcJK7w69TScQp8vU0pU=;
 b=Fdv+LFefSPdZ5xpX2GH9eNezEuWUEcMSA7m396nTWwBdKIv9E3Wqq1Rub+uUQy/QrrkzVGWVvG5JfkJUdWq+KzlDsJeCg4xSHT4bu465ZBh6ljGTh57ILmo21jKC0pUfQ4eBCFImXUuahH5ZsfqUNH+KBJVnULa6m9+fDQP83VvQdxdInMNUGbVyA0n+JcdelC/3QGQamXkRj+/zGnpKooDWLFJbIsjQl0vuilYR14GWOIAFb9mhxYhXGuNvOttBsjFQg3X+d43SwYjr9hwLoyOB1TNElFv6H1ptDfO3fWoaLJhRKLmWlUdi4Qmowk+lFwcmjdMldGXTIf80ne84LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT3PR01MB8354.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:9b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Thu, 25 Apr
 2024 15:43:06 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::17ea:ed8e:e437:46ed]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::17ea:ed8e:e437:46ed%5]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 15:43:06 +0000
Message-ID: <d00cba29-4ebc-4974-890c-ecf821b2fa8a@efficios.com>
Date: Thu, 25 Apr 2024 11:43:05 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Wu, Yannan" <yannanwu@amazon.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <03304ae9731e474db911b8ef6703cf69@amazon.com>
 <b8b2da19-5c08-4369-9bd4-8a3ae554ac4f@efficios.com>
In-Reply-To: <b8b2da19-5c08-4369-9bd4-8a3ae554ac4f@efficios.com>
X-ClientProxiedBy: YQBPR0101CA0295.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::20) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT3PR01MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: f77d0b9e-9782-45e5-afbb-08dc653e669b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NG5ZNzAvODhhZXRvQ3lZWEp1dTQ5YXdIYW5xb2tXcUE4WThiMEVrRVV3K0l5?=
 =?utf-8?B?aEJKZWt0RnF5Zkg0OHhuaWUrWWZybmZQd1l3bGZxSng2RXA2UkxOOHNKL0Nw?=
 =?utf-8?B?R0ZJeCtXQk5Kc3dMd1ZmWUFuZUxNRG11RG9MMnZJclp5c1BwZGxtaWY3SmFT?=
 =?utf-8?B?VENaOHVhZkp0SVVFdlpjajlVaDRPRDdSTWVFMG5nR2FtdkYxUjBXM2o5Z2hn?=
 =?utf-8?B?TTArdXh5c29iYk1BcmJkN1lzRkZWZGMwdTFiOHhjQ0tqWjhwSnZzYW1UWElK?=
 =?utf-8?B?bkZEVXRQb2YvK25rb1RXd0FsYnhXNS9GNTZ5TERPRTVGU2NTd203cmgzd20w?=
 =?utf-8?B?QWFBTTJYSWVWeEx5T3ZqM2NBOHlnd2dpLzJBWWNwVk0xV0UzS0ZlQWJMVlhU?=
 =?utf-8?B?elh0MUZobTl6Vm9mUnAwM1RuR0t0dTZLOFFLakF3RDBzbklBQUdkbGE5cGh4?=
 =?utf-8?B?R2RQYW1TYjNNVVBqcXNOSGs3OXRVMStoU1YvY3VhYXgzUHh6WWE0eDIxb1FX?=
 =?utf-8?B?cWJaVXVkM2ExUGtjREhNUDJFUVJpWGVLMFQ0amV5Vmdxcm5tMnhtSDBVTEow?=
 =?utf-8?B?bFRWTG5zdW8vWVNOQTQzc3dtVlpLbHQxZ3BrVDdXa3hib29Yei85b1YvZTJW?=
 =?utf-8?B?OW1yRHJyWDhPYVl5clhjWjdzWkMvUGZRRUluQnhlZVplS2hkN2RESVBINmNr?=
 =?utf-8?B?Y3RDUEc2T2YyUE8yenRGZ0w4MWhsKzljU28vUEl1VXJ0T1BhRE5Lcy9aUEVQ?=
 =?utf-8?B?YXFDYzBIdXNRck9rL1dsVmNJblNzaE5vOTQ2VkVlQW05ZzdsSW9JRk5rZWlU?=
 =?utf-8?B?LzNKb2ZSbEF5ZEZsbEFtV2xxYThVaVhPZ1F1STdjeFdkdHRLU05GTzRuMEs2?=
 =?utf-8?B?aVpWNGRyQUo4aG5BUE5ZVENKeWtuZ1RQWmJCek5aTFZoN3YyTWdTTEsxRnA4?=
 =?utf-8?B?MGhvWTdmK3VjR1IyajFMVjlSWWtiUHh3YXVrQmdPN255eTl2UUFXcUg3R1Bt?=
 =?utf-8?B?ODd6U3I4dEdsYkJGS0gxb3ViU0J1bVBmRDRLckFqS2pWUVA2V2N3RjFoRCtl?=
 =?utf-8?B?MklBYVJ1QmRHZ3k2Y1UrcEYvT0lSTTd5d0FtdXEwNUNLaVpNd01oc21ReXlI?=
 =?utf-8?B?Y1FWWGdYWGJnNVo0cUxLQW56MVVBTXJFaW9iSmpaY2s5dFR4aGVVQUhUVk9q?=
 =?utf-8?B?ZlJZTlh4NFo0UVhBT2kzdjV1N1lyd0JTUG5OUlhmdHpvY3VSMnllZi9ORHgw?=
 =?utf-8?B?Z1BuanVkN1JWMGZCUXVGQ2lDb2sydXlNWXl5ZVhyeGVkRTVTVFk4ODd5QnlL?=
 =?utf-8?B?L0xZWDZBUElGekVneWticjA2MXBNVDJLelMyUUYwaWxNcHBpMlIyNmpXc09q?=
 =?utf-8?B?OXJQUTgvanp4ZlZ2dDRiMVlXaHpGaWJPcXpUWkZ6dHF5dHNhVXhzc1o1Rm1v?=
 =?utf-8?B?eDUzVWRDU093RDYzRDd1OFZ4ZDNuTWZSMFg1eUtpM1ZNai9wV1llMW1UdUhm?=
 =?utf-8?B?OVRQeTZTZEZqaFB6UVVPeUo2dzQydmNJN3VCd09iWlY5M0pxVzJVdGxCRGxF?=
 =?utf-8?B?aEc4SjZheTBTcGJBbjBSZ05MN0VCWnJBSGFGN01tYTZjUC9UaHJ3TmVzV3lu?=
 =?utf-8?Q?q2pSDqCEpZAsR5fiC0bCE9RgDjPxE7tfu5D0nn8z7yOI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0ordVhKSHNCOGdOVDdBbjJZT3Y5emo1U1ZOL29JdzNaek81bzY2K2ZmRzlC?=
 =?utf-8?B?TXdWZkV4NDBJTk9PNG5yZHpOaGJaUE9IVSthQWF0SnljTnZ3Mi9QMXBaVGdE?=
 =?utf-8?B?cmFBSG1ZM1J6S1FlVE54UDJMWEJXWndFY1NLeTl6MXcwVmFlVnNMNmVVU1RO?=
 =?utf-8?B?ZldINnhQWld3U2dFeWNadHFtVnJkYnoycmQrazZEbnZRTjRkRGhPNWdHRkpl?=
 =?utf-8?B?cDVUUTVLN1BBR3RPZ3Y1WUV2WXEzNHA3Y0ZiWTczQlRsNEdzTEZYQTNUWDg0?=
 =?utf-8?B?bjVQcXYzcVJiNDJDZHdPYmp3WHR1ZDFJZDZNOXpXWkxDcFhhSk16L1F1dW1U?=
 =?utf-8?B?TEc3S0xHTFpnR1g2SDhPNzU1T09CeFZkYzFyQkwvR0hjdHphLythYmIvNXJL?=
 =?utf-8?B?NWs4VlcyK1U4TkYrS3lnNDIzRGVHRnlBTmM2MzlpaXBBZStDR3Back50Q2tH?=
 =?utf-8?B?eEtpcTRZQ09kZ2VHbFNZSnk0aVd4U0ZqOGRJbGJ6amY5SmJVcmxhSE8zOUZY?=
 =?utf-8?B?MVF5VGpHQU01SGprK1d2MTUrQUVkOGd1R2JnVTFFcUJRRkQzamx4MFByVlZG?=
 =?utf-8?B?YlQvbHVkLzdZaDVmNHMxRCs0K2xQZ1Q1alg4SG8vQ2VlY25hSVdRd0FUcDVW?=
 =?utf-8?B?Z1JjejM1OCtGdUpTL0RmOXNGS3JON2w3SVBNRDk5RUpZbThKUzdiWDduR3hy?=
 =?utf-8?B?Um41aXpNYVY2SFIrdFVzbmI5M0tCS0ZZV3dhZjBZWVZ3ck84M1ZBOTNkOHNP?=
 =?utf-8?B?cUIxWEhGVWx1cHRra0lpZzdwbTZ6OE9zMEx5am1zU3VTT2s0NUZZUFRlSWZn?=
 =?utf-8?B?QTdvaG1yUFdnRFZmWXFyTnM4Qmx1YURJb21US1F0WWZ4cFVMcjIzOTlWUjZL?=
 =?utf-8?B?cWtFa0F6OC9ScE1iVzlBUE9Ra2trL1M1VHdGdWFvTVJxWXpVeGFQdkdqcTVB?=
 =?utf-8?B?N0d0WmFkNVZrSStvWmd4cUpiTVhaTzRENml3OXYvZWlQOVl1N01vbjdpK09x?=
 =?utf-8?B?NUtOaGFyM056S2lXZzF1dFRkNS9BZ2JaSndsQWxOdXQ5TnArRjZYbW0vRE5G?=
 =?utf-8?B?K1hPMjg4YXUxZ2tZdmpVd1hmWTgrOG5zVFlGdnlHUjZnSmZHKzhhbVNSWWZv?=
 =?utf-8?B?ZEEyNHM2TFI3WUdNV3hra0hPbGxEVUlOMlF5RmdxYXdmS3I0RmR6Zi9BcGFu?=
 =?utf-8?B?TGY4eXgreTFQVTJQa3JFdmh0cjdmZzFRblhrT1pKaDBuam1IekhVd3YxTzlP?=
 =?utf-8?B?OS9HeHpJaTIxZk42aHRYT0k1YmhieWlza2RjbkZaRWJSSGpxNUlTQzVDMFlH?=
 =?utf-8?B?OE9kdTZCYy9JOEprWFFxbTE1ZlFFYXhaQnZHamJkYWVYSm5MdXU3cWFTWXI2?=
 =?utf-8?B?WGtjWTRsSnpxZzV5Vm5qcDVqRVFSTU83em1zRjVFb2ZEaXROTWtmS2gwRWo1?=
 =?utf-8?B?TWNSLzFhWThldktVUVVxRldJbmtBeXc0MEtRUmYzTnd4b3pFeXdPWWpnVWZM?=
 =?utf-8?B?RFByKzNyOXRsMzNzOXZTSU5qdGRZRFQxM2RYSWlMTHBuZWcwUEc1bzlqanVi?=
 =?utf-8?B?Q3BDNkVPK0swM2FoYjVQYk5VNkFGVW03NnN5Q2VVNDFVc2xUVEo1UjVHK0ZQ?=
 =?utf-8?B?V1RkS1FlYlArVjVnSnVqdXpMbW5pK0pWNzB6VGVFb0FoeXBMK0cwci9RYm9p?=
 =?utf-8?B?b21MNUtka3pyNWlvM0lhZ3F2U0U1NFJwZGtrWEpWeEpETnY5SWN2cy9RUmo1?=
 =?utf-8?B?TFEwcWZjakk3MzVSS3NaYmxNZkRsVG5QNk9aUVpYUldpcG84bkpvbXh6MlZC?=
 =?utf-8?B?ZmE4OE9mRGxWUnNjSjhsNkhnT1BhYzVuSFBvSU9HelpLSENpZU1RU253QTJE?=
 =?utf-8?B?aFhDRU9pTjdDUy9DdE43L205L3hnMFJnMnlSMnVKa2RSQXdZYVdiZjNPeW9x?=
 =?utf-8?B?THpTc0dGbDRuaDhENUlLQ2h3QXQ1dkp0blFNZWUxVFpSbllxRFlsUHFJaDJM?=
 =?utf-8?B?QXVkU0ZiRWE4UXdQNzIzR3A0YzJ5VXdHSUdKTHczeC9xU3FRcENFOE9zZDcx?=
 =?utf-8?B?V3dmUEdUMmdxVTRJK2MzVXVYbURDZzhnS3cwZ2RzY2ZtSW1qT2NoK2dxZmRi?=
 =?utf-8?B?dG1Xc0FOcUtQMUtKd21QUHBRRkdvNTZVM1hZdmkwTWNIMHd2Z290NDEzNXp3?=
 =?utf-8?B?MVE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f77d0b9e-9782-45e5-afbb-08dc653e669b
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 15:43:06.4571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/gZR2kw3I9fGOU+Ei2z3Ixe9B41eUSvRJsYRW0K/80yO41StB1m1wTNlc+PiFcRKu/POrt2pfu0lAo3UUcKBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8354
Subject: Re: [lttng-dev] [babeltrace2]about python self-defined plugin
 loading
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

TXkgYXBvbG9naWVzLAoKdGhlcmUgaXMgYSB0eXBvIGluIG15IHByZXZpb3VzIGUtbWFpbCwgdGhl
IGxpYnJhcnkgZGlyZWN0b3J5IHNob3VsZCBiZToKCmA8bGliZGlyPi9iYWJlbHRyYWNlMi9wbHVn
aW4tcHJvdmlkZXJzLycKCnRoYW5rcywKa2llbmFuCgpPbiA0LzI1LzI0IDExOjQxIEFNLCBLaWVu
YW4gU3Rld2FydCB2aWEgbHR0bmctZGV2IHdyb3RlOgo+IEhpIEFtYW5kYSwKPiAKPiBjb3VsZCB5
b3UgZG91YmxlLWNoZWNrIHRvIGVuc3VyZSB0aGF0IGJhYmVsdHJhY2UyIHdhcyBidWlsdCB3aXRo
IAo+IGAtLWVuYWJsZS1weXRob24tcGx1Z2luc2AsIGFuZCB0aGF0IGBpbXBvcnQgYnQyYCB3b3Jr
cz8KPiAKPiBUaGVyZSBzaG91bGQgYmUgYSBiYWJlbHRyYWNlMi1weXRob24tcGx1Z2luLXByb3Zp
ZGVyLnNvIGluIAo+IGA8bGliZGlyPi9iYWJlbHRyYWNlMi9wbHVnaW4tcHJvdmlkZXNgCj4gCj4g
dGhhbmtzLAo+IGtpZW5hbgo+IAo+IAo+IE9uIDQvMjQvMjQgMTE6MjggUE0sIFd1LCBZYW5uYW4g
dmlhIGx0dG5nLWRldiB3cm90ZToKPj4gSGksIFRoZXJlLAo+Pgo+PiBJIGFtIHRyeWluZyB0byBj
b25zdHJ1Y3QgYSBjdXN0b21pemVkIGZpbHRlciBhbmQgc2luayBiYXNlZCBvbiAKPj4gYmFiZWx0
cmFjZTIgcHl0aG9uIGJpbmRpbmcuIEhvd2V2ZXIsIG5ldGhlciBtaW5lIHBsdWdpbiBub3IgdGhl
IAo+PiBwbHVnaW5zIHNhbXBsZSBJIGNvdWxkIGZpbmQgb24gdGhlIGludGVybmV0IGFsbCBkb250
IHdvcmsuCj4+Cj4+IEZvciBleGFtcGxlLCAKPj4gaHR0cHM6Ly9naXRodWIuY29tL3NpbWFyay9i
YWJlbHRyYWNlLWZ1bi1wbHVnaW5zL3RyZWUvbWFzdGVyL215LWZpcnN0LWNvbXBvbmVudHMgPGh0
dHBzOi8vZ2l0aHViLmNvbS9zaW1hcmsvYmFiZWx0cmFjZS1mdW4tcGx1Z2lucy90cmVlL21hc3Rl
ci9teS1maXJzdC1jb21wb25lbnRzPgo+Pgo+PiBJIGp1c3QgZG93bmxvYWRlZCB0aGUgcHkgZmls
ZSBhbmQgcnVuIHRoZSBleGFjdCBjb21tYW5kLCBpdCBmYWlsZWQuIAo+PiBUaGUgbG9nIGlzIGFz
IGZvbGxvd2luZzoKPj4KPj4KPj4gYmFiZWx0cmFjZTIgLS1wbHVnaW4tcGF0aCAuIC1jIHNvdXJj
ZS5kZW1vLk15Rmlyc3RTb3VyY2UgLWMgCj4+IHNpbmsuZGVtby5NeUZpcnN0U2luawo+PiAwNC0y
NCAxNjo1MjowNC4zNDkgOTE5ODA1IDkxOTgwNSBFIENMSSAKPj4gYWRkX2Rlc2NyaXB0b3JfdG9f
Y29tcG9uZW50X2Rlc2NyaXB0b3Jfc2V0QGJhYmVsdHJhY2UyLmM6MTcyMCBDYW5ub3QgCj4+IGZp
bmQgY29tcG9uZW50IGNsYXNzOiBwbHVnaW4tbmFtZT0iZGVtbyIsIAo+PiBjb21wLWNscy1uYW1l
PSJNeUZpcnN0U291cmNlIiwgY29tcC1jbHMtdHlwZT0xCj4+IDA0LTI0IDE2OjUyOjA0LjM0OSA5
MTk4MDUgOTE5ODA1IEUgQ0xJIAo+PiBjbWRfcnVuX2N0eF9pbml0QGJhYmVsdHJhY2UyLmM6MTg4
MiBDYW5ub3QgZmluZCBhbiBvcGVyYXRpdmUgbWVzc2FnZSAKPj4gaW50ZXJjaGFuZ2UgcHJvdG9j
b2wgdmVyc2lvbiB0byB1c2UgdG8gY3JlYXRlIHRoZSBgcnVuYCBjb21tYW5kJ3MgCj4+IGdyYXBo
OiBzdGF0dXM9RVJST1IKPj4gMDQtMjQgMTY6NTI6MDQuMzQ5IDkxOTgwNSA5MTk4MDUgRSBDTEkg
Y21kX3J1bkBiYWJlbHRyYWNlMi5jOjI0NjUgCj4+IENhbm5vdCBpbml0aWFsaXplIHRoZSBjb21t
YW5kJ3MgY29udGV4dC4KPj4KPj4gRVJST1I6wqDCoMKgIFtCYWJlbHRyYWNlIENMSV0gKGJhYmVs
dHJhY2UyLmM6MjQ2NSkKPj4gwqDCoCBDYW5ub3QgaW5pdGlhbGl6ZSB0aGUgY29tbWFuZCdzIGNv
bnRleHQuCj4+IENBVVNFRCBCWSBbQmFiZWx0cmFjZSBDTEldIChiYWJlbHRyYWNlMi5jOjE4ODIp
Cj4+IMKgwqAgQ2Fubm90IGZpbmQgYW4gb3BlcmF0aXZlIG1lc3NhZ2UgaW50ZXJjaGFuZ2UgcHJv
dG9jb2wgdmVyc2lvbiB0byAKPj4gdXNlIHRvIGNyZWF0ZSB0aGUgYHJ1bmAgY29tbWFuZCdzIGdy
YXBoOiBzdGF0dXM9RVJST1IKPj4gQ0FVU0VEIEJZIFtCYWJlbHRyYWNlIENMSV0gKGJhYmVsdHJh
Y2UyLmM6MTcyMCkKPj4gwqDCoCBDYW5ub3QgZmluZCBjb21wb25lbnQgY2xhc3M6IHBsdWdpbi1u
YW1lPSJkZW1vIiwgCj4+IGNvbXAtY2xzLW5hbWU9Ik15Rmlyc3RTb3VyY2UiLCBjb21wLWNscy10
eXBlPTEKPj4KPj4gYmFiZWx0cmFjZTIgLS12ZXJzaW9uCj4+IEJhYmVsdHJhY2UgMi4wLjcgIkFt
cXVpIiBbdjIuMC42LTEtZzgyNWEwZWQ2ZF0KPj4KPj4gQW1xdWkgKC/Jkm1rd2nLkC8pIGlzIGEg
dG93biBpbiBlYXN0ZXJuIFF1w6liZWMsIENhbmFkYSwgYXQgdGhlIGJhc2Ugb2YgCj4+IHRoZSBH
YXNww6kgcGVuaW5zdWxhIGluIEJhcy1TYWludC1MYXVyZW50LiBMb2NhdGVkIGF0IHRoZQo+PiBj
b25mbHVlbmNlIG9mIHRoZSBIdW1xdWkgYW5kIE1hdGFww6lkaWEgUml2ZXJzLCBpdHMgcHJveGlt
aXR5IHRvIAo+PiB3b29kbGFuZHMgbWFrZXMgaXQgYSBncmVhdCBkZXN0aW5hdGlvbiBmb3Igb3V0
ZG9vciBhY3Rpdml0aWVzIHN1Y2ggYXMKPj4gY2FtcGluZywgaGlraW5nLCBhbmQgbW91bnRhaW4g
YmlraW5nLgo+PiB5YW5uYW53dUB1ZTkxZTk2ZjI5NTFiNWM6fi90cmVlcy9sdHRuZ190ZXN0X3J1
biQKPj4KPj4gSXMgdGhlIGNsaSBjaGFuZ2VkIG9yIHNvbWV0aGluZz8gSG93IGNhbiBJIG1ha2Ug
aXQgcmlnaHQ/Cj4+Cj4+IEJlc2lkZXMsIGlzIGl0IHBvc3NpYmxlIHdlIGNyZWF0ZSBhIHBpcGVs
aW5lIGluIHB5dGhvbiBhbmQgbWFrZSB1c2UgCj4+IHRoZSB0aGUgcHl0aG9uIGRyYWZ0ZWQgcGx1
Z2luPyBDYW4geW91IGFkdmlzZSBtZSBob3c/Cj4+Cj4+IEFtYW5kYQo+Pgo+Pgo+Pgo+PiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBsdHRuZy1kZXYg
bWFpbGluZyBsaXN0Cj4+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPj4gaHR0cHM6Ly9saXN0
cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1haWxp
bmcgbGlzdAo+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBodHRwczovL2xpc3RzLmx0dG5n
Lm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0
bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21h
aWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
