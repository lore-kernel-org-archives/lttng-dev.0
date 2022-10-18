Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CDFC4332F
	for <lttng-dev@archiver.kernel.org>; Tue, 18 Oct 2022 18:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1666118055;
	bh=j/BFQtkG7KGpPlgDlntQ1QUDhB+xXQD/09Ivh0MH5Vw=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=VrSo1nprSg8cZ49puRWJ3sOuE54NaUQZfLVxRPAiwLWGi4QSkRubCLBqn/W8E6mAS
	 M0ULA8j2AAokE3koet97swW/40WisdwBYQ0YRx6TJeXZxkselxvbIKziVDZ49cUayK
	 3fySoSctCbR7Etg0J9s10eYTeYBiaZUeBRvKajpmEdm4pbLIe/ME2QCZa0S89waxTB
	 fcEUAvmio+3OQVSbsa6lDQl8cE2JIzqnR0yElzzSdGb2NkS2fTXh2G9CYj54EejLGp
	 0/tBSExQeA2mjFraorSgmiHETpuYdqWXdSd1CI9yVnuC0rM82Y5HyfejcgI/s67Nbn
	 JF+qAc4VGublA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MsMvp2yrWz8mj;
	Tue, 18 Oct 2022 14:34:14 -0400 (EDT)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2070.outbound.protection.outlook.com [40.107.115.70])
 by lists.lttng.org (Postfix) with ESMTPS id 4MsMvn1Vjbz8k6
 for <lttng-dev@lists.lttng.org>; Tue, 18 Oct 2022 14:34:12 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nf906ODWrgJJPxdpmiA0byttlq+ftguZqVf1bv22EwNpznZZE5gfxxVemOUVNBAlAN+1dYxunDb+epM+tx/w9hohwDJu9970yLtRCpMH6ZSQsiI3drVNnMTJIIPfdSyvunHvzHoMcn5m9ttY4gRgUg3slhrv1ZOlMzjIDvgvYbpxf+wgKg1dE6Rsq4K1Iyr7DB5gpWRG2v6G6219/NBFzzZl506eusbN36iM4hIVxE2ihcPwNAVFRHsXGMKd19FZOydOtHkfRPu8/NRexXW79SKIMWsb1jzpth3jMtWtPRwM5VKVFfgbslpHfNoeU2A3KLfpfC4MtekLV4m2K7K7Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/OPJ7bH9SHjKFI3hHQjMIPtoRdQ9ac8EkR7a4GUaTE=;
 b=MbsX5h+VBjdc1K0Z1waQgIXvCMntB8PmyuaR2m4sU7Q84WXqmbj6vEoJNFlnUDpUMS2ntibdtSdONZIN7EZf2AJfy5gEqR10+D23bcCuFoFKFTud2bdLUN9f1aifGTtMPo7CVBT4p94XJV5b56FCNJHgyq4LXmdoxlgAfQ4suTKuw7oPfAdcpBlBiR3+9Eow4X7LrO7I4IoDAWsbo3WYNTiCp9G7hu5eJVSWtMxiPJhTtWctek+tb0+9JuLwffuEdkTjjadRw9ua4HDBBTJ0aT6P85GTUWSMeb1lgDbaSGAVZj5pRGgokHPEnZenq1ZlTzizl86zw5/rjq1qsmB83Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4e::11)
 by YQBPR0101MB5989.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:34::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 18:34:10 +0000
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a05b:5150:ef:dede]) by YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a05b:5150:ef:dede%6]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 18:34:10 +0000
Date: Tue, 18 Oct 2022 14:34:09 -0400
To: "Lemay, Paul" <P.Lemay@dell.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Message-ID: <Y07xoexhESiFtJTy@efficios.com>
References: <DS7PR19MB637575A3329444AD675C12379F289@DS7PR19MB6375.namprd19.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <DS7PR19MB637575A3329444AD675C12379F289@DS7PR19MB6375.namprd19.prod.outlook.com>
X-ClientProxiedBy: YQBPR0101CA0304.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::7) To YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:4e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB5984:EE_|YQBPR0101MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: ad7fc49d-543d-40bb-6349-08dab137593f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3H9wU4sQ5+YNjCDlpA5x4DYpcdF9nKXvrakYyxtur5q8PlSBq0mwn7rNOvQn5FOnyELp2fPaYYiQm2ReB6OxD6h4HIcwb/09mHZ6khnX7Q31WEbqklDUq7iN1sBNw8WdTBYIudmHDVCMpQGHyX16f/iZytG1QHDDsxuSJkGbJzIRcS2MaUVcQzwHSeK5lB7LkuzZbnA7G8nVFTv5ylYJ0nbKPhYzM0R8ADikIOPhqP/vQLVLNYMOFiqP30gY8UCAGWXL1Xvv4hYFUm46jhxgfcLHnlgqO94MVMcCb14QFkFeG6cBjlUDY077KieqyeqcKER20+WWQYtoSxR1guoJue27aWPQYfBoyTHHOgg99QKQIF85UAMqpXIawA8mvJvpArE9pm9qfM81EVWn92dwmyWPGndF2VKgDfzSKuBhzAyxKel6g0ZS8hFqAGXk8v6Vsb00Yimv3XBVmEtyzphx6V/trrGtcSWrV+jL8Vlau1tUt5l4EC4oHQqEa+cSVhMsJLhDytqrnmcOWU5TxOmEcPvpifJYyySSsDpRJ+B0YAtVDSmejg2ZiN0/IybwjnlF2+vJHgDyOytEqKR4SxCmcuzJSPCgZoasjkHcCMGe+fdUe49mrSCKfnpgJaw3jOWHeMSXTQizs4VTL8K1+p37SYB+Xe9SdYELv4j8SaYz1VLgXb5CdP0vfaO1zVotzt6/UZCVMtJ1mvj71lU8WTPPFTNcMVxCo2kIT1K7RHDLyo4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230022)(346002)(39830400003)(376002)(366004)(396003)(34096005)(42606007)(136003)(84040400005)(451199015)(41300700001)(5660300002)(2906002)(8936002)(316002)(6916009)(6506007)(478600001)(966005)(66476007)(66556008)(66946007)(6486002)(4326008)(8676002)(36756003)(83380400001)(26005)(66574015)(38100700002)(6512007)(2616005)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUw4djJzeWw1T09aTitkaHZJL09jM0lrS0QzRG5iZlcyL2w1aWxLRTZBbnhZ?=
 =?utf-8?B?K1kxZTFnQURjQkNhMGdtSjdIaTZaQU0ycjlURWpab0xsZG9qVWxMWTJSU0F4?=
 =?utf-8?B?UWZudlpWVVVPVmhLMTJ6dUFYalljaFFUN1lWY1E1bVZ0ckU3dVl1ZjNLUmp6?=
 =?utf-8?B?U0xNWWxCOGZhNGR0cElSMmxnTGNJcjhJc1BzYjhIa2JJM1c4ZmMxMkg5VzUy?=
 =?utf-8?B?WU5SYTZLM253amQ4VmxzNUY2aDdCZ0RrOVJjODlGR3grMGdhSmZwMXVOWmZ4?=
 =?utf-8?B?VkhzV3VxQ3RpV0lYcGMyTFdWSG1pZUZoOWhiQVh6TXBkNUxqUkloNURFNnB1?=
 =?utf-8?B?clA5Vmc3Y3dGa1VUdzFBTWVjYURjd2NTbXF2cFdCUHFwTzhud0tHVDBBMlN1?=
 =?utf-8?B?QjEwS2ZpM2ZhZ05rd0d4cWZMeE9wNlpWL2ZoeW1LeFhSbWx1Zk5hc0FrQ3VS?=
 =?utf-8?B?WWlOc3B2TmFUYzJyVUdlK3NSZC9Td244L01mZGd6ckdlVHJXcDZyUVltOTZv?=
 =?utf-8?B?cVAyRGJJSjQ2RExPTnFXNWQvdEFyeXNwNXhiQkRyeWxPcStEOGVlbWpCd3V0?=
 =?utf-8?B?MTd4UHJSaXkydVVnSmRLbEtEaHV6TFRMUHhDSE5UWXlZeVdlakJxTzQ1dDRD?=
 =?utf-8?B?aXAwODRFMnAzT3U2dGFpNFhZYTVscmx3L2pvWXlhYUxzcWZXcFRXQTRaWUhZ?=
 =?utf-8?B?VytzanoxLzBSbW9BL0dDL0NmRDZEWWo0YWRkZkF6Q3pZaGlrdWtwVkdPaDh5?=
 =?utf-8?B?bDMyWm9nb25NY3lyZFo5OENXczhBbW5FMGhiOGUyUVV1Y04zM3BTdzZXd1RP?=
 =?utf-8?B?dzlBUE5EeG1BYTVaTkdzbUcxcWs3Tm5qdzNud2VyeTdoQlBMOEFEZnpranlv?=
 =?utf-8?B?N1BCM2U0WEIrYldCQlB0TUVJdWUwSlVnSVZqbzFqT01weWlLT003ODVlR2da?=
 =?utf-8?B?akRuc1NPcWNUalUxdnRSdFZGOUJYTDdPZVVIOEhqSFVSa0xVempVNW1VeE1p?=
 =?utf-8?B?aHFJemtVN3B0aytIaUZFSTBwcjJhZDZPajJIOStHZ29nK3VwdlZoZkswK2xP?=
 =?utf-8?B?eUc3bm9GcVk2UHNoVjd4Z01FMDBLUG1yZVFhSlJCcWMxVDY3VkJEaVQ5bG5P?=
 =?utf-8?B?V2RIV3FmV21kd0t6VFRzUnpERTFtR05WRC9uRmhqZWdmRnpZMjNRVitBMzYx?=
 =?utf-8?B?bWtGL3NYK2s3dFJmelBxbHYzSjhvc3Z5VFFia1JnMk42TVNxYUJ5U2NlOCt5?=
 =?utf-8?B?YmR1Tzg5Rm1YM3NZQlMrejFWd1pPTG1aN3o3aDlVMGMvaS85YlVXMjdiZ2NT?=
 =?utf-8?B?SG1MOU0rSjlENUhiMEcrZWx2NnRZRG1YcnJ1c3FkWWtnNmV2RnBZQmtOSGRi?=
 =?utf-8?B?T1lIQnROK0xERHBVbHE0T2sveTBNcEpzZjVMakVZWUo3ZkdVYU9GRmp1OEF1?=
 =?utf-8?B?djd2NW1Sbk9uNE5XVlo4LzFkSXB5UVhhcXNQdzNGT202cklBekFTN3NxWnFw?=
 =?utf-8?B?K2pYUEVCeDhRYXIyK1Y5VUdzVXlyZDhIMjE3MUFXc1ptZFFJMlZIQ05hWDhP?=
 =?utf-8?B?aS8zUlBVMmVsQmcxZ1VscnViNXBOSlFiRjFDdlNUVG9pSnpEWmNsZW1NRnJw?=
 =?utf-8?B?SmY5Y2d1NEFQeDF2YVNwRnZrOEIrYlJXTzAvaGdUMUlFYVh6KytwUWM2d2RE?=
 =?utf-8?B?Z2tkdzZKQzVLS1hhVGNxQWw4cStMOEZhOE1CMDltU3F0V0txZzhEZXJza1lP?=
 =?utf-8?B?OWIvQUxPQTkxREcrSjQ4bTZCa2cvbUZLazZJLzlYR1BQUC9DVGEzTzk1VUQw?=
 =?utf-8?B?NFV5SytBQXdGWENNMHJKTVdSbitjakVvak5EQ0pFaVRCcDg3bU9lQkJBL3Fh?=
 =?utf-8?B?elFVbTJrVUVWc1ExK1o0MlJvWXNhMFJlVU44dG9lMzVKUTVvNFl6QUhLUU5h?=
 =?utf-8?B?a24xVnJNL1Qyejd3TnQyL0JCZ2ZOUmx3YW1JUnpPMU9HTVUvazdNNFFRcVZw?=
 =?utf-8?B?UVdvMFJlakJZSjk4NmRuc2FrM3VNVWIya2pJSEF4T1Y3emtyU3NYNDl3ZzAr?=
 =?utf-8?B?SUw2MkdMUHJYQWUvZUp3U1N4MUo3cGh2elVLaE1GMWczNE1TOWREZTFOeXU5?=
 =?utf-8?Q?sKQovBW6zWZdOhARPf9NnkN4+?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7fc49d-543d-40bb-6349-08dab137593f
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 18:34:10.6708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xHEZhgUhJAzPOSBIogDhqOulxGrrZrtrH3oAdwyPRS7mT/olzsMSt+lxft3F+FJDrhuWybZeTqhkKplwj7pcdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5989
Subject: Re: [lttng-dev] Shared memory circular buffer and K8s pods
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGkgUGF1bCzCoAoKV2UgZG9u4oCZdCBoYXZlIG11Y2ggZG9jdW1lbnRhdGlvbiBhYm91dCBkZXBs
b3lpbmcgaW4gS3ViZXJuZXRlczsgd2XigJlyZSB3b3JraW5nIG9uCml0LgoKSXTigJlzIGhhcmQg
dG8gcHJvdmlkZSB2ZXJ5IHNwZWNpZmljIGd1aWRhbmNlIHdpdGhvdXQga25vd2luZyB5b3VyIHNl
dHVwIGFuZApjb25zdHJhaW50cy4gU2luY2UgeW91IG1lbnRpb24gYXBwbGljYXRpb25zLCBJ4oCZ
bSBhc3N1bWluZyB5b3UgYXJlIG1vc3RseQppbnRlcmVzdGVkIGluIHVzZXIgc3BhY2UgdHJhY2lu
Zy4gVGhlcmUgYXJlIHR3byBtYWluIGFwcHJvYWNoZXMgZm9yIHRoYXQuCgpGaXJzdCwgeW91IGNh
biBkZXBsb3kgdGhlIGZ1bGwgTFRUbmcgc3RhY2sgaW4gZXZlcnkgY29udGFpbmVyOiB0aGUgZGFl
bW9ucyBvZgpMVFRuZy10b29scywgYW5kIExUVG5nLVVTVCArIHlvdXIgYXBwLiBUaGF04oCZcyBw
cm9iYWJseSB0aGUgc2ltcGxlc3Qgd2F5IHRvIGdldApnb2luZywgYnV0IGl0IGdvZXMgYWdhaW5z
dCBLOHPigJkgbW9kZWwgb2YgaGF2aW5nIG9uZSBwcm9jZXNzIHBlciBjb250YWluZXIsIHdoaWNo
CmNhbiBiZWNvbWUgYW5ub3lpbmcuCgpUaGUgb3RoZXIgYXBwcm9hY2gsIHdoaWNoIEkgd291bGQg
cmVjb21tZW5kIHlvdSBsb29rIGludG8sIGlzIGRlcGxveWluZyBhbiBMVFRuZwpzaWRlY2FyIHBl
ciBwb2QgdGhhdCBydW5zIHRoZSBzZXNzaW9uIGRhZW1vbiwgYW5kIGluc3RhbGxpbmcgTFRUbmct
VVNUICh0aGUKdHJhY2VyIGxpYnJhcmllcynCoGFsb25nIHlvdXIgaW5zdHJ1bWVudGVkIGFwcGxp
Y2F0aW9ucyBpbiB0aGUgb3RoZXIgY29udGFpbmVycwpvZiB0aGUgcG9kLgoKTWljaGFlbCBKZWFu
c29uIGhhcyBhIGRlbW8gc2hvd2luZyBob3cgaGUgZGVwbG95ZWQgTFRUbmcgaW4gSzhzIHVzaW5n
IHRoYXQKYXBwcm9hY2guIEhvcGVmdWxseSwgdGhhdCBjYW4gaGVscCB5b3UgZ2V0IHN0YXJ0ZWQ6
CgpodHRwczovL2dpdGh1Yi5jb20vbWplYW5zb24vZ2Nsb3VkLWx0dG5nCgpUaGVyZSBhcmUgYSBj
b3VwbGUgdGhpbmdzIHRvIG5vdGUgaW4gdGhpcyBjb25maWd1cmF0aW9uOgogIC0gQSDigJxtZW1v
cnnigJ0gdm9sdW1lLCBkZXZzaG0sIGlzIHNoYXJlZCBiZXR3ZWVuIGNvbnRhaW5lcnMuIEl0IGhh
cyB0byBiZQogICAgbGFyZ2UgZW5vdWdoIHRvIGFjY29tbW9kYXRlIHlvdXIgYnVmZmVyIGNvbmZp
Z3VyYXRpb24sIGFuZAogIC0gdGhlIGNvbnRhaW5lcnMgc2hhcmUgdGhlIHNhbWUgcGlkIG5hbWVz
cGFjZSBhY3Jvc3MgdGhlIHBvZAogICAgKGh0dHBzOi8va3ViZXJuZXRlcy5pby9kb2NzL3Rhc2tz
L2NvbmZpZ3VyZS1wb2QtY29udGFpbmVyL3NoYXJlLXByb2Nlc3MtbmFtZXNwYWNlLykuCgpUaGVu
IHRoYXQgbGVhdmVzIHRoZSBxdWVzdGlvbiBvZiB3aGVyZSB5b3Ugd2FudCB0byBzdG9yZSB0cmFj
ZXMuIFRoZXJl4oCZcyBhIHRvbgpvZiBvcHRpb25zIHRoZXJlLsKgQnkgZGVmYXVsdCwgTWljaGFl
bCdzIGRlbW8gd3JpdGVzIHRoZW0gdG8gdGhlIGx0dG5nLWhvbWUKdm9sdW1lLiBZb3UgbWF5IHdh
bnQgdG8gbG9vayBpbnRvIG5ldHdvcmsgc3RyZWFtaW5nIHRvIHNlbmQgdHJhY2VzIG92ZXIgdGhl
Cm5ldHdvcmsgdG8gYSByZWxheSBkYWVtb24gKHBvc3NpYmx5IHJ1bm5pbmcgaW4gYW5vdGhlciBw
b2QpOgoKaHR0cHM6Ly9sdHRuZy5vcmcvZG9jcy92Mi4xMy8jZG9jLWx0dG5nLXJlbGF5ZAoKT3Ro
ZXJ3aXNlLCB5b3UgbWF5IGFsc28gYmUgaW50ZXJlc3RlZCBpbiBzZXNzaW9uIHJvdGF0aW9ucyB0
byBtYW5hZ2UgdHJhY2VzCnByZXR0eSBtdWNoIGhvdyB5b3Ugd291bGQgaGFuZGxlIGxvZ3M6Cgpo
dHRwczovL2x0dG5nLm9yZy9ibG9nLzIwMTkvMTAvMTUvbHR0bmctc2Vzc2lvbi1yb3RhdGlvbi8K
Cmh0dHBzOi8vbHR0bmcub3JnL2RvY3MvdjIuMTMvI2RvYy1zZXNzaW9uLXJvdGF0aW9uCgpMZXQg
bWUga25vdyBpZiB5b3UgaGF2ZSBtb3JlIHF1ZXN0aW9ucywKSsOpcsOpbWllCgpPbiBUdWUsIE9j
dCAxOCwgMjAyMiBhdCAwMTowMDo0N1BNICswMDAwLCBMZW1heSwgUGF1bCB2aWEgbHR0bmctZGV2
IHdyb3RlOgo+IEhlbGxvIFRoZXJlLAo+IAo+IFdlIGFyZSBsb29raW5nIGF0IExUVG5nIGZvciBh
IGRldmVsb3BtZW50IGhlcmUgYXQgRGVsbC4gQXMgSSB1bmRlcnN0YW5kIHRoZSBMVFRuZywgdGhl
cmUgYXJlIHNoYXJlZCBtZW1vcmllcyBvZiBjaXJjdWxhciBidWZmZXIgdHJhY2VzIGNyZWF0ZWQg
YmV0d2VlbiAgYW4gYXBwbGljYXRpb24gYW5kIHRoZSBjb25zdW1lciBkYWVtb24uIEFmdGVyIGxv
b2tpbmcgYXQgc29tZSBwcmVzZW50YXRpb24gdGhhdCB5b3UgZGlkLCBJIHNlZSB0aGF0IHlvdSBo
YXZlIHN0YXJ0ZWQgd29ya2luZyBvbiBjb250YWluZXJpemF0aW9uIGFuZCBwb2RzLgo+IAo+IFNv
IG91ciBhcHBsaWNhdGlvbnMgcnVuIGluIHBvZHMsIGFuZCBhbSBub3Qgc3VyZSBob3cgdG8gb3Jn
YW5pemUgdGhlIHBvZHMga25vd2luZyBhYm91dCB0aG9zZSBzaGFyZWQgbWVtb3JpZXM/IENhbiB5
b3UgaGVscCB1cyBiZXR0ZXIgdW5kZXJzdGFuZCBob3cgb3VyIGNvZGUgc2hvdWxkIGJlIG9yZ2Fu
aXplZCBpbiB0aGUgY29udGV4dCBvZiBLdWJlcm5ldGVzPyBBbnkgZG9jdW1lbnRhdGlvbiB0aGF0
IHdlIGNhbiBhY2Nlc3M/Cj4gCj4gQmVzdCBSZWdhcmRzCj4gCj4gCj4gSW50ZXJuYWwgVXNlIC0g
Q29uZmlkZW50aWFsCgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmcKPiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
dHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9s
aXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
