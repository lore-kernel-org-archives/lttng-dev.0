Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FCBC83F27
	for <lttng-dev@archiver.kernel.org>; Tue, 22 Jul 2025 21:39:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bmrHk5lbNz1dFf
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1753220340;
	b=nuPWeWrfMINNu5ESznH7GXWUxrFoKQPI+R6jSjU3cYC8Gn05qqQ4/MlbmhV2o2zPrCg8
	 MVIdM0oJeIE/v5B3/vol05DsKirhp/PqfHxunBAa0nXG6JxqnHNTFSF+dpyoFq8Lk/dQr
	 fyDxpi9A/cmnfDIVI9SSdgmjl8mWw1y+hTKiOm4krbH0ZH9IndP/w5K1RCwLkqr1/GPAm
	 rVKSAN9yDZh70hgQIVIfmK2LoprudZTYjgWXfhr10xNF7sL64lZugGWTd2mrRYYvgkPXS
	 n9lKNpwrWsfZ85UyC3zcyTaIO4mSNwExXzvBzS3tfNcsqBfud10VNschT0VGCbIpcig==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1753220340;
	h=DKIM-Signature:Date:To:Subject:Message-ID:MIME-Version:From:From;
	bh=ThnqI4/4jDqdCD0h4F4tLtA/dczZmGxmr6YVnR15WWQ=;
	b=T6uCWk8L1uFr1qSMWVoD3Zcroa7jP3/eAmnr83kk7YiqNsjwaFi95/krLL4daOq9waBM
	 F+5kxwkPnZtf60blPpyYm5LHs1iMoY8SEPujX/DOn0p6jU1RjTIz/McghkFhgNMbXHaRl
	 2/sRblJNrryfab3GqNIeZw+pLSL8MSPPQK88jbeYMV7MHTQSm8InWwi8GFB59/zlwATVE
	 I+BOgAy9e+6vFKDLXm+1D4fCht4hSAfSi6dgXPnBw7ITJ3UJ5M79rE7sllzoNmSAa+J13
	 cZJ12VKae0716oyTokc8l/WzpDLLrzGjh2dBtHRuFFewuGxreIUxPk82vMBbzHZlqFw==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bmrHk5lbNz1dFf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1753220340;
	bh=ThnqI4/4jDqdCD0h4F4tLtA/dczZmGxmr6YVnR15WWQ=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=jFPXwUmH+3Nn+mrscH6FLQIu8Q0hrTFlmxxDc4fgkTu1fzSCEUEmsRd4fA4Z2iczH
	 hIYYlzmnWfm3vlr9eNiMnz7jJ1QUN+1V8SilJpWj0mJOkbw8whrJyAkuNpF8RJ3/Wv
	 +V/ydeh46Q2GOmO7XUeNDz411iOF8v89rhngVkn+xWiMa8mHAHKLRHoETXik0ipsbL
	 cNuwXxeT2gi/jj/olouTSupKrptKBjj4mIq9EP8kABaDzUekAiRhZo2F8uc8WCdXgy
	 DZVAOEueC910sosTAOJ6WjSAiza9YtL/yfWdLeWqTYMhk+bJWHwUyfly/tvVqTkasK
	 Q/8hBgajJ3g4w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bmrHk5lbNz1dFf;
	Tue, 22 Jul 2025 17:38:58 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bmrHh104xz1dFc
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bmrHh104xz1dFc
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2129.outbound.protection.outlook.com [40.107.115.129])
 by lists.lttng.org (Postfix) with ESMTPS id 4bmrHh104xz1dFc
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jul 2025 17:38:55 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOWhstyvUrLvZbMrqxC8FLO/Dh+L9494qsA2/jta2ygYscb0UBa40ZosMJZyty17hx2ovS6H5dI9s2p9RFeJ+UDhcJ6OA8v/YkDlXJ6woExHJbHNgMJOAClktlvmb8cqEPqua/2lDSJ278HtMUXr24hgaM1QIQdl4br8CePvBjCfhrPp5l0KOIAmlPlyF1EKiJ8NkEvZiYCnaXfRs7tgq6SQZ8zQ0UMj/LgV0EbNzqtTNOrOxp3vFDY/fgzVcuXyICLImUzeWMDfWUGkxSO8m+d+Euk+oLrnQQsyq6HpMiKApZ5HMz1UkWfz6Q2VDTIlFlkPxpKUeK/wDpvfAFvDNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viC9RTtgULR6ZixZaoJlLP9h28Xv9GkvoXCEsWa5imc=;
 b=gRBtP4+/omZL01fxPaBEd1FRNReDDZmQh9q8ooXXXsOas5MOTY6TT2/8BDQD6uxsd64a9VzOIEuCItwu9LAZYMgS0TjfsbZQof8SOHDPxy484v0vIiAI0BCUqMRI0lEjcwK0e8MdAe6nyNhHTTJ1NNsmYgdgaNEmPhvKrSEXowv9oqskWg77WfTHRH6JPpZazg1a6aMqYcsvPBa1Lc8XPtWOEAPuxMJOD9lsPxb4so65CXXwCfdWlY7NoB/hBwiRcKf7Qn7o2/+ytxHgtJ2cspG7LjiYddP3v/sYaiYqpTW4s04e0tlH2cl/rMgGOCNxG0hmIwdQRuDi8BZWR8VcQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:104::10) by YT2PR01MB9585.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:af::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 21:38:50 +0000
Received: from YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5de4:ebdb:2bf6:ee1]) by YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5de4:ebdb:2bf6:ee1%2]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 21:38:50 +0000
Date: Tue, 22 Jul 2025 17:38:48 -0400
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org
Subject: [RELEASE] Babeltrace 2.1.2 - Brossard
Message-ID: <aIAE6K9uksn8l1jf@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: QB1P288CA0005.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::18) To YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:104::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10709:EE_|YT2PR01MB9585:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a6a573-bc18-4059-d9e8-08ddc96825a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzdSeGdHQlpsRzNGZ090MXl1dHJaZTBGL2dWRXlnNzJ5dldmVlpWczl0L3Bh?=
 =?utf-8?B?T214bWxIbUxYS2dlTUJtMnVYK2I0RHVVSzRGUnpTZmZyT2sxbnNLRllQT3pi?=
 =?utf-8?B?ZC9Ud2hFcVFnWGRtajNNdktSTEVlUTVyOUFuSU1Da3laQzFRdWthZGxPd1JE?=
 =?utf-8?B?eG0ydU1EclR2Q1V1WGRTYzVORGtNZ0RwK3NkbktlVUVRc0diejdpWGg0MG1n?=
 =?utf-8?B?VUNrZ3QxZ1hZNFhYT2RnUFJrOEJRdFRldlJSUUZrS0Q0Wmxnd1RzVlVIS3Ro?=
 =?utf-8?B?VS91Ym9wNWR5OUEyMjBLQjlWb213ekwyWENldTQ5Tm93STJYbXF0UTFiRE0x?=
 =?utf-8?B?Vlg0alFNL2lXaFQ4MHh4NXdscm80ZGx4cUJTMkYvU2d3WEpTVjZWQkhXRnBi?=
 =?utf-8?B?L1dndk0vU0cxSWxqZk90K2pkNi9pK2RUK2hVYmdkZ3dPa2hVWUxUV1FrazZ3?=
 =?utf-8?B?QlJtLzQzT1lFSHp2dmNWcG5WVmxnZTVRSkQ2TmNLRjg3T3RFV0VNdDJneklj?=
 =?utf-8?B?VytkYUIrZzZMYWRYVEdhTjR1WnJDbmkxTzlneDlWYzY0L2ozaWlDNUk0VFU4?=
 =?utf-8?B?K2pReFgycVdoZjlTVkFqYysrQWNubWJ6UGplbVhRNHNRTnZhZkZPaG9HUUVP?=
 =?utf-8?B?SmRKV2VpUVU3Q3B2Y2VZeERJaGFNeGhaNmgvaWYyRy95SFRxZWpSbnRRSkxo?=
 =?utf-8?B?R0lWVk1JeEtoSzVuVEtvZ1BuaWZIQmloalNiNUVKU1lwNENqS1JIRVdnZUZG?=
 =?utf-8?B?NmxHaFdoekVwYkNBODREZ2p4V0FQODJSTzAvcFc4a0ZiV2hhZWdDaUpLdC9F?=
 =?utf-8?B?Z3JZbzQ0dW9kdHB6c1oxdTVLcEQ5YnRlZU9BOUhaR2Q5NjYyQmNVY0pWcERW?=
 =?utf-8?B?aTVMRUt2VmE1c3RSTTdCQkxqVzBYclFKVGt3ZzJoM1ZOanNrRDh2OVV3dG9W?=
 =?utf-8?B?WUdkT1RWZ3BYOEE5a1U2a1BTdisxbURIbW5xcklzQ2FnaGkwWEFlWmZNSTBr?=
 =?utf-8?B?ZjljSTYyU3QyMEd1TEdaMXowTlA4TmRxZnNOek5VdHZob3VpR0NZN1l0a1Zs?=
 =?utf-8?B?TDlPcmJ0dTM2cURnd0JDTUt4REZ0QTdjaVl3M0FWN0VJc2VtRmNYQ2c1ZSt6?=
 =?utf-8?B?QXJHNTZRbTlIb0YxNFJ2NFp2QnpIb0pTMTV4QitTMmc2eXBaOGFER2RuTGxI?=
 =?utf-8?B?T3FGUjIrc016SXdOOUxkUXVsKy9sL2NYVWVUWkY4OFFCZDZGM3BHdGlqR1di?=
 =?utf-8?B?T3ByNEtzSXE3QXBLVnkxRDhKRjNlQUc2K3R1UlFKV0NwNjY1c1dNc3JMZ0V2?=
 =?utf-8?B?Y01NdXF1akMwN0oxQmFIdVZCc1JieEpqN1Q4TlVZaUI0ZGRhMzB5RTY5VldV?=
 =?utf-8?B?TW5OeHNzWTllaVVUNXFjSzFzb0NDaDhWdXhsaVk3MSt2Y1FRTndVRHdZdFYw?=
 =?utf-8?B?dW9VKzNLOVI5UG92U3NIanpoMEdlUWlJbzhGK3pvTFl6eGdNQlY3ZHNncDdY?=
 =?utf-8?B?Q01ENWZSUmVXMFZTYWtyOE44SmNNbVBOczJqdmFTcUVQa0NKUTh6Z2lDbG14?=
 =?utf-8?B?RHRkMmhsZXN0aXpXMkVwMmJIVG5DMDlpajMyT1RTNTZyc1k4MVl5THlJb0JB?=
 =?utf-8?B?QU82NjVsMi9ZY0V0T3VCM0lGc3UxdERCUjl2S281UnF0VjMwSVE1NGVTQVVS?=
 =?utf-8?B?WkVyWEM0T1JYUWlDTHZ4VzNDZXI4ckhlUGVQYVQ4ZDBqSXZ6QXlQcGtGcFhw?=
 =?utf-8?B?OUdleEdpcG92RnB2Q1loaDgya0FSZVMxd2lBVnhrZUI2aXlnWFRyWU5yRHkz?=
 =?utf-8?Q?0TpzSO3pmJZ3v4Oxqr3nEjFnwJH3QzxoSI/9I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXlWSE9pQlNlc2Rnc21wRUxRdk41K1pRWlRvcmx5RE9Vc0ZzcnBOS3ZnNW1B?=
 =?utf-8?B?U2RhSlVNWGNjUlpJeFh2cjFCY2FkL2lZZmFjUXF3WGwvd0xKOUQxVzFXc3B0?=
 =?utf-8?B?Z210WlhtYm80QjYralpFN2pVMTRXTUlmUldUeTZKeFVpbFA0eXpTNWluRlZ2?=
 =?utf-8?B?VXhLbFd6aytmcHNZYVdUWEltMTQ0R29LSkJqU3pHNlhYTm5GTHZGOVdFQjF1?=
 =?utf-8?B?RG4xSmlJbGxNajJVOHNvYm9talFRN0hPelpKVFRMQVZEZVZWR09nRXFtbmpU?=
 =?utf-8?B?V3JLTkFlM1NpUVlybGRJQXl1YWFmbG4wOHdtUWdrakt0MDQwOUdTT2ZMTzJI?=
 =?utf-8?B?cFdKd2xtTjFObVRTOGMxNEtzd0NibGFUeEE2WGJVQ2MxRUpKOFRJaUJ2ZlRR?=
 =?utf-8?B?MFNZS3F1bnVubFRhdkZQMjBnLzM2dkVUUlZrNHY3WWhGQVFpWDIvTHdCMEFL?=
 =?utf-8?B?bmhDT0lKZlJTNVFTTUJWc3RFUEdSSm9qQ0k5OE1hb0FLdWNNWHZlYTFEb3hF?=
 =?utf-8?B?WTFNTjVpZzhsenRiRzZsV3JSRmJseW5IeG12NWd4STdCcmVydVJwK25tcHVH?=
 =?utf-8?B?NnlOekIvaEp4U0h4WHhhZ3Q1ckU4OG5jdzNhcFdvekcyZ2pnYUtBckVGYTcz?=
 =?utf-8?B?ZzRtcUpaNmREME5uZWxjRUh0eGVlNDduUWxiK0plS1E5ZE9VeVhTQTBuTG1C?=
 =?utf-8?B?MmlBOTBMTjcreERxTkVPbi9WSGxmZGNKcTFNZGRxeXRteWY4cGhWYW1FYVlj?=
 =?utf-8?B?eVNtTGpCbjV2UXhOZW92TVVVMmYxU1JkWnQ0YVRZTWg5VDJkcXZUelhqYU5M?=
 =?utf-8?B?amkzdVJHVmYxbi9tejFHa1NuNmtDQkhOZHUxNlc1SG5FY2RRN0RwS2Mzb0hj?=
 =?utf-8?B?VC9kdjJMK3BMMTNOR2w1VVdGOEZ1eG1RNGtYem90ZXdyRTZQeE1Fb3M1T3hR?=
 =?utf-8?B?ZHpKL2svaitVSStvZzVGNDkyTlp6TmU5MXpCWnBxUWFkeFd0Um11cVhBOUhv?=
 =?utf-8?B?cGtPanFEa1pZSTIvbnB1RmhQVE9MaEZxWXA3a3JPelo1TjFpVkEwKy9obEJo?=
 =?utf-8?B?MXhaQ0NCNFpmQzZwbmEvSnBIVW9IS2Vod1dycyt3OUJnWi9nVjE1cGkxd2hP?=
 =?utf-8?B?dlRqUkgrT0kvL1RMS0dkaUt0OTVpd3cxZnhWUXFJMEUyOXRsY1RoY0lhTTVm?=
 =?utf-8?B?aS95V0lXbTlOcm5zQ2NZUVRwWjAwQ1dtNkJQRVN2ajNTMzdJWnhEOG4wcm00?=
 =?utf-8?B?Ui83ekNLekVjUEsvWmd2aVVnMjcyenIxYkYrL25kY0p1aFZqcWtTSWg0cEZr?=
 =?utf-8?B?MFhBYW5EZ1lJbjEzdTBGUWVNb0tOYXhwQjNWRW9qSERrVG1PVTN2R0JPM3dP?=
 =?utf-8?B?UUVPZTBtdUNnL1FJaWZTVU51Q3NDZ2txZW5QWmFMWHBGNlh1cXJRQld5ejJu?=
 =?utf-8?B?Z0xDZEtCc1IzZnE5eTVhTnRXM0IzSlJ3dkIxdy80VEp5ZlQzMEM4czRzRmEr?=
 =?utf-8?B?aXY3dTNka3p5WXFuQlFEQ2M1N1JhRzkxU0pmQVhkVnZYSlFNaThrckJTdTdw?=
 =?utf-8?B?Tkd3dkRmQzlwSmREQi8yTkl6Q2Q1YnF0RDY4V2V5Y0UzZmx6d3pVU3Urcnlw?=
 =?utf-8?B?L29QTUpzMCs5VUJBd1VuMHQ5WVdOdmZDQ1o5ak9Nd1U0cGtoZklYd0RTdzI1?=
 =?utf-8?B?dk14NEtzSDdkdHJYUy9xRDB5RnZiaEJPSFZPbUYrVHE5T0tqYTdRSVlWZWhW?=
 =?utf-8?B?K2JVU2g0RmNkSEduU1N5N0VRejREcnBGdG1NbVVDZUllem55SHBCSm40ZDNV?=
 =?utf-8?B?MXZNUVpXTWtnTGdkK1lPYXdteXRHUU9sb1VRdFN0QWtudlNhWXVJM2IwTi9I?=
 =?utf-8?B?OE9OTHY1ckxTUzZxbEY4d2EreHF1a0YwQzN6a0k3V08yYzEzUjJWSkl0TXlY?=
 =?utf-8?B?MGlvWGJYbE9HQVlNRC9URTJJbFdxY05IQjRzbUNIUFVxTEVrM2c4dFhrVzlP?=
 =?utf-8?B?a3pKaHB2RFMyRGc0TEM5blFjdElWb3E3VDZQTjA1SXE1dTlsOXhBT2pHMEhm?=
 =?utf-8?B?STZTUjM5dWhraWNkT0h6L2tabXFqZ2t5QjVZL3R6VVV6UWEvazhYdUNaNjZV?=
 =?utf-8?Q?qAMMF2ZKpay+oLcqa8snEgJF1?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a6a573-bc18-4059-d9e8-08ddc96825a1
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 21:38:50.4606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 930qtCYe0mmZ/Hj1I/y7gDJ1h7w9Y9SDviCbIifrqWwoLPX5oTXYEfr4tikd1a8s5GCqcGah63obANS1DCCeLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9585
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau
 <jeremie.galarneau@efficios.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi everyone!

Today marks the release of Babeltrace 2.1.2, coinciding with
"National Hammock Day" – the perfect excuse to kick back and relax while
this new release builds.

What's new since Babeltrace 2.1.1?
==================================

Below is the full list of changes in this update:

2025-07-22 Babeltrace 2.1.2 (National Hammock Day)
    * src.ctf.fs: be less strict when encountering trailing byte at the end of packetized CTF 1.8 metadata
    * tests: add bt_test_cli
    * tests: make bt_cli accept non-positional options
    * tests: bt_diff_cli: don't pass unexpected extra args to bt_diff
    * tests: remove unnecessary nonlocal keywords
    * Fix: Python: set local `typing` version to that of 3.5.2
    * Fix: Python: missing __contains__ method for _PluginComponentClasses
    * Fix: tests: Add explicit items method for Mapping compatibility
    * Tests: sync normand.py with upstream
    * Fix: tests: Add explicit __iter__ method for Iterator compatibility
    * Fix: Use local_typing with Python < 3.5.3
    * Update working version to Babeltrace v2.1.2

We've worked hard to address issues and enhance the Babeltrace project, and we
appreciate the community's feedback and contributions. As always, we look
forward to hearing about your experiences with this release and how we can
continue to improve Babeltrace!

Happy coding, and treat yourself to something pecan-related today!

Important links
===============
Babeltrace 2.1.2 tarball:
    https://www.efficios.com/files/babeltrace/babeltrace2-2.1.2.tar.bz2

Babeltrace website:
    https://babeltrace.org

Mailing list (for support and development):
    `lttng-dev at lists.lttng.org`

IRC channel:
    `#lttng` on `irc.oftc.net`

Git repository:
    https://bugs.lttng.org/projects/babeltrace

GitHub project:
    https://github.com/efficios/babeltrace

Continuous integration:
    https://ci.lttng.org/view/Babeltrace/

Code review:
    https://review.lttng.org/q/project:babeltrace
