Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19564C47422
	for <lttng-dev@archiver.kernel.org>; Thu, 25 Jan 2024 15:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1706197996;
	bh=Kq2EZ/58+CLk6K4vOdndvFk1JSDW+puzMkYZfyFd1Mg=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=qgXtfp1WxKV6Lyt6EjqHnYv2LMUgTb0KLIQPu0aiqh1tclLXJRzxlozAbmdLzGCB7
	 hGKE4oRZrnl5rxq6QkvjI6woRXSRw1PbEVUmY1rOJt+LiYp3aJJlnhWV/HyBTQTAXt
	 US9fxMrDd8JjYzH0+F+i5z/VsDnmywVDTqb3UEBiNdqy3Sad6fmUB7Jvlzg5JN9ECV
	 YGWmflzOXaSRS5uoFruYTVOFokwDg7QdKf4tQe+tVkzzL/k6BCTP8XfBOnWTX+5e42
	 sxoVoxAKlpknHx3iy+8/QYi8zYg4XV7RgkEwQhcCcPXT9Ltr6OFnLSmRcpdIayLqTG
	 Hvpn3Ytw/3R2w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TLQMv1vVfz1mDL;
	Thu, 25 Jan 2024 10:53:15 -0500 (EST)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2062.outbound.protection.outlook.com [40.107.115.62])
 by lists.lttng.org (Postfix) with ESMTPS id 4TLQMs0Fwjz1ltf
 for <lttng-dev@lists.lttng.org>; Thu, 25 Jan 2024 10:53:11 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/N72mOA9u4V/lpY1eMiqAMH4HROGBJBItIxFc/iBR9BpNZEvNCXWW98mL9IwKyrRNcN5qZElo6iIJ8krxPKSTVMdEbgCyqrQ4ceXUG85GIXTZdlst0MQr7z0QGDnZiv35ulTgNR05R+zrutMo/pHq42g9GljtSB27vVhJr4qO9Z2g+3SLhPnklWit9+A0BTOtq0rKyPy+yt+7NuPWXcqB1aYgXKGUSh51QkW2AsrNqqEYZILGX+bVphg3jNlFXLwR10lK9jRQ+jropX4DBhxLm3Lry+blzpBEwD8tM02a5jaPwNrreZOLmyIotp3Bz8sRuEzdSY4aV8Aer2E4rBAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDUUWtXruvGDRn+omp0xp/lDmC2FX2ti+OA3wG7GLQY=;
 b=Mg8QjWxGW7mWJ/l/z9C6EbPMyQKYWDHISbCb8eV1NjnvDrpEcxxScqaZyKxlxX47PqzoPjLnfDr5HU0ovBV0AM59/NJ7Htxb6I9URjvfmoqwScBn7xmhTwq8W6dldh726UafrLPGgHtKcbNmNhEADv4YAzhQPrm1XUQPprdq0I1Cu5JiNrdizvzwA13waQdZFzn6dUGK8kZc7dIpXllM7bHwwgQIBh9tqMtWYWIuAG23PblejVmKbxO/vRiHmDW9uwRG7PGEqcw5qe0MlZPRmOvZHQjaY5CFNnMDrhDAIFamLjIZLpdqAos3gnZwgZ7DqZ0tbSrv8TjaoG7OiKC2PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:24::5)
 by YT1PR01MB8346.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Thu, 25 Jan
 2024 15:53:09 +0000
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c711:83ed:d711:ea0d]) by YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c711:83ed:d711:ea0d%4]) with mapi id 15.20.7228.023; Thu, 25 Jan 2024
 15:53:09 +0000
Message-ID: <7f72017c-b12d-42af-9dfb-cf5d1898457b@efficios.com>
Date: Thu, 25 Jan 2024 10:53:07 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Olivier Dion <odion@efficios.com>,
 Xiangyu Chen <xiangyu.chen@eng.windriver.com>, lttng-dev@lists.lttng.org
References: <20240125093028.1883839-1-xiangyu.chen@eng.windriver.com>
 <87bk99sb7m.fsf@laura>
In-Reply-To: <87bk99sb7m.fsf@laura>
X-ClientProxiedBy: YQBPR0101CA0170.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::13) To YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:24::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB5080:EE_|YT1PR01MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 16848418-0aaf-47b0-ff56-08dc1dbdba18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xUXtRz5D4m3+dU6Ui04tQiyZPe5dwZScKqFpLEbhPALIjKTPfUWn+TNpEvofceTXOH0iqhH6DNdxC1zXYwMNLsa5u6KTLcX4d9WlnrorxVhpfpksKpzWcP9RQx/dhCVAGktnyEB+BHxCIXfcfAfPjjm2dXMDw/b9eLI6DrpojWwFsmDS61LE2G1ybKsWmnOj0a1CZ4C0Gg0YxADofIcq7V7f0jRAzzm2n2oqtpYm5Tkt/z7E/6Y0GM+JhcWpbFoSk9n/Srp0N0AU2A+bhVV/BvFRI2j1ouJLHNzxSeYBIJBsdKZmxW4jiM7NM+IcamG0USRJoj/pXaP4bXcjpXPTez3BswMNv3ZFxqAAcDt3a2VeI9e8gdy0aGUjGgdPH/4Jz2qvrXb5jIBcdDICYQAPawpZygPHUddN3gCiNI6oFSleu8ZNLW3GWLxS/xky+8GxzzEiapz/1BlCoqFizHKpQNuczcgGE/CpFU46J2UiSX9Ohxgjcnw1htkxYzoLEvzpchfvPiI+wXIrqCKdecSNMv0LlmdHeyq25BIQkzedUsWnkjzWzDFmP5nFnFtzLWqmS8F2szCjyPtFIaPlQ2xuCHsqi7qg7AwgsN0Da2neSUcf+EwmeL1Bop787e9I00+Uj9Cn/p+bwYa60YOaxk9jdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(346002)(366004)(39830400003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(36756003)(4744005)(8676002)(8936002)(5660300002)(6486002)(31696002)(316002)(86362001)(110136005)(2906002)(66476007)(66946007)(66556008)(38100700002)(2616005)(53546011)(6506007)(6512007)(478600001)(41300700001)(26005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkFnU04wdE1IZE9TZHFmQWJxL21sUldCbWd0QTgzYk12eWFLQ01XczRRc3Mz?=
 =?utf-8?B?RlBabTdNMFgzMyt6akl6bDVRcVczYUs5NzJxWGFTMkZJMThEL2ZhTGZRZjFM?=
 =?utf-8?B?OGhvZmgvZjhLNDNTa3BubWFUQlpycXF2bTFGOTcybThYRTRpSXpzOFB1L044?=
 =?utf-8?B?bDZ3VnZEeUdvUVN0WnhPS05keVVTZ3RTWHBMc2wwcXBUMlNudUwyT09saTBX?=
 =?utf-8?B?VTArenZnUWR2T3o5bE9OQUN4SGZRSVQzVkxlUEtTKzFJNXpVRmg2TFU1M3F0?=
 =?utf-8?B?MTJtTWpNeHpVSjNPZkhQSG5hZUo0ODJNT1I1VmJsc3JrWExDYjA3UVk2SC9x?=
 =?utf-8?B?TXdOdDhiOEVJcTluQ3FidTNGM3plcDB0SmZuUngydEZvcHNIVUlGVm9LazJo?=
 =?utf-8?B?bHFtWVBhancwSDRqRGxLdndYb1JUcXBoaDNmRGlNVTNNWTliV3NLMkZHMCt4?=
 =?utf-8?B?bjAzVkZ3SHdQM1dnbjJzcHFsOGVFMFJqcUVhbnptV2pCWktQREsxc1hmZVJC?=
 =?utf-8?B?TkdxOXRrWE5vaWtMalA1dTJGSFo3Q2FQZFZtRWN3UWRPMFplTXdPWklldUdH?=
 =?utf-8?B?c1IvZDVidDFaWlJPTXA0WStMY2JNeFRpcjY2UVFSeHl1cW5oNWNmQUJkbHJy?=
 =?utf-8?B?OFNEWTA3K0xKQ1lZOXVLbm0ybHF5WnRhYkxFV0FweGR2eWhLSW5iUFovS2pL?=
 =?utf-8?B?YVU0NUhEdnhKb0Yyck1XdEMrRklSVy9BMk9ZdGRFSGlqRml6c013NUVXODJQ?=
 =?utf-8?B?cUUzS3Njb28xUHpaM1BMTVErWXNJTDU0SGtBUGlsNFNrNFEvNnp6UVF0NUR4?=
 =?utf-8?B?My83U2F1cXZ0WUtDMUtISnROSXhZcUlYZ3paNXVOaWRDRXkxQ3JBaXFCRVZp?=
 =?utf-8?B?SkswRVQ5N3c5NGlodVk0MXR0U0tiblRNVmNSTlpCdk1xR1lDNkJLSEt6YTBT?=
 =?utf-8?B?Sm1wcFNPS28rSWd0S3VobXFUbkxsek9VK2VqcXRMdXJCWUM0RG02S2hidGE4?=
 =?utf-8?B?NjA5TUVtaDBXcndMVnRyYWRubk90Z0xGclJWSUhCSVEySlJDK3Joc05MYmNK?=
 =?utf-8?B?QVhGeEIyK3lNcC94cE5Lc0pyd0NhVVI0Nzg3d1N2T2MvQ3FlZUhxVlFIQlVD?=
 =?utf-8?B?cEpXSXMvbm1KYTcvT0k0RnBXSzhVUTh4eXFqUTZ0R05GUVI5TzRzV1VEUzZG?=
 =?utf-8?B?OHpiUGoyUGFKRDBGeTBxbG1XaFgvRGJZRWRNK3AxbTRqS3p1VmhmVXFVVFYx?=
 =?utf-8?B?NzE0ZDJnbTk4MTVyeGF1YThscHg3c3BJd3lCVzRwZEpacm1ldWE5b0ZFM00v?=
 =?utf-8?B?S3BubnZWc29VMGxNT0ZWa0JGNWRHZHRjbXFSbVI3cWltaWxIZWRWeW41SUVM?=
 =?utf-8?B?dlFqc3l2TkJRbHRZYXJ3Si84blZqektJQTNyMHJPM3BxNi9HWEpEcUVheEM2?=
 =?utf-8?B?Rnc2WS9taS84NzVucDkzZ2V1YVE4RnZaeHhYVGR3WEZDOHJPRjNmdDcxRkh2?=
 =?utf-8?B?VnY3b2NTNUdkUDlWRGhpWTR5WnBmS1VaMGowemVFTUY0amxoM0c3dzFLVHI4?=
 =?utf-8?B?YjdKQ0tnNzZDTTYweWw0ZDlUUWkrVEp4eC83aGxQdkxrcWk4TmdZZWs4dDRP?=
 =?utf-8?B?ekdtZlNuZ2F1VVUzNmtYRXZ5RSsxeHZteHR5Z1JURDBkMFZWaTV2cEhJQlZo?=
 =?utf-8?B?UDhZdXFFWnpZZ3NKR1lwdEM0RDhpT1dKN3BkOHRtb01leDZwOWdoSE5aRlVo?=
 =?utf-8?B?c1NaZXZuS2hBbGRCS1lka09FcFQvc3A5Q2huMTBIODFLVTROQ0pkOUxrdlhn?=
 =?utf-8?B?M29uRjB1V3dHYjQxQUtoSExrMU5WeG1CT296YUlpZUlhNFhQQXRpMEYvUkR4?=
 =?utf-8?B?VUdWZ3JTejJCdVp3OE1MTnhmMWY0aDl5VWR0YXBCaVFsQitUc1UrVk1HY0F2?=
 =?utf-8?B?dmFoczBmN2hQUXFJamtqM1FhVWcxRDlVT1Z3eDRGWU1iMmJQZlJTbVIrMmZr?=
 =?utf-8?B?dGZRS2tWSjRSdVN0YXFuUTZYVkFkWUc5bDdjcnRBSEZsWExRWDl4R1BZRmRR?=
 =?utf-8?B?ZXNDY2VGS0VwSG1aMEdqRG5NNGo3dnA0dVF4TWNPREdQdGpDTTg1MUtxSGhM?=
 =?utf-8?B?UHRvNG9yL2pWaml2WWx2dHBwT0JQTU1NYSs1U2ZKY2x3bzZqRWV0bFlHa1hP?=
 =?utf-8?B?SFE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16848418-0aaf-47b0-ff56-08dc1dbdba18
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 15:53:08.9774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4c594N+E1wVDloccJ9n7IZxqIULhPB/6Eii4W3Wos39INQm1jefxC0OzhjiLE1FBBW+dSlnOKMPxlHwIrZIWfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8346
Subject: Re: [lttng-dev] [PATCH v7 lttng-tools] tests: add
 check_skip_kernel_test to check root user and lttng kernel modules
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
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2024-01-25 10:07, Olivier Dion via lttng-dev wrote:
> On Thu, 25 Jan 2024, Xiangyu Chen via lttng-dev <lttng-dev@lists.lttng.org> wrote:
> [...]
> 
>> Add LTTNG_TOOLS_DISABLE_KERNEL_TESTS to skip the lttng kernel
>> features test, this flag can be set via "make":
> 
> Is there a reason for this to be passed as a make flags instead of a
> configuration option like `--disable-kernel-tests'?

Because it doesn't change anything in the built artifacts, you could do 
multiple test runs from the same build with or without running the kernel tests.

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
