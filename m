Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD69C71136
	for <lttng-dev@archiver.kernel.org>; Tue, 17 Jun 2025 14:19:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bM8BR0sHtz222b
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1750169951;
	b=UehcmpnuDtA94qGamXYrVkGuJJlY9UgJa9jmuvgcDsP2ksBplV8mXbP9WzcibfoEhaX4
	 PEQnejhW3Z1ihHq/K9qHpwWn1aEHYwuYQhAQWe4aGYbCnSZHN3tzskUbrrNjlUowBRIxk
	 tapVVSy7ByqakycoN9nB1Y8mUWrI2wDLSJbCKBRxiusxARn+Kda3QOrfx+K6dt94WsQ3v
	 ruUwDaMki87LiAqYu9MjrtvONpfZZNd5vChI6V5eT84q+rXk4EXyEiZKJE0bpnY7uxPrp
	 pIvmgrqUnFpb5sAtb0xjwLFuI8C7nLFSphKYW83C4Vs4jWvAcf5Ef0vLg+M1M88Qy/g==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1750169951;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=hOBnvRZqm4oD8ohW5d7/rvcc8w/gNhevViKK4dpqoTc=;
	b=gI1imX3QulwLmMFFfPppA3DEIrIJQBkcU54fcn8D3HLS24pi4wTmhqCLQF1QbP6PXpug
	 B/5FDq2GN8Db1EXqoAl4vDtIPU7im//BIxrNFb986QUpJHOlsM0se3+je3n13/tYBk5uU
	 3hWrh0F63Wo+fsh1W+oLPD26z4bcwLEpAug4FngPY4HPbXfNn1pAm5qxjAPzb9W1DiZd7
	 dXMfp9/7cA/nNfN9OiAcEoI3N/B83Gvo/GRQGVWoSblh5vPDb7e272DkZYF158+EoyHKI
	 uiD6/dNCwf6C20pUhX6RAKusREp/6Fy0E3HnB5po3jymg+YshdKQHdLGFMUflYNQU7Q==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bM8BR0sHtz222b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1750169951;
	bh=hOBnvRZqm4oD8ohW5d7/rvcc8w/gNhevViKK4dpqoTc=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=yUzI59bKDaGqVzPU0xXhlWRKLJy3w8LdwxqmdAaYzeOYgIBIG+VSyB1W0801gcmZP
	 80UTZDTw+nK6rQhlhR2HVJmOPSgdsTa/32SotnnBWhBGsmK0LT1biB7TX0SKVY0kDn
	 DO1jM+4tMC4WYKDDax/Bh01mrGLhIpIPIXxH1NIyladmwribgp6lMzq9Nm6eWhjdoD
	 xsiSphlYalcJwn4EowFND45GZlqpe5FpnhNIp1zL0mHkfG8ykk1LnmfKHJYmq8KFgf
	 HvYD/R3Ne0Mf/mnaONTX+xMTojuAUJqz2Zzb3BlOqnGg6SuylP+rTLVg1QSLNqxxU1
	 6sDx17jQmvEQQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bM8BR0sHtz222b;
	Tue, 17 Jun 2025 10:19:11 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bM8BP6Pmjz227s
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bM8BP6Pmjz227s
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2110.outbound.protection.outlook.com [40.107.115.110])
 by lists.lttng.org (Postfix) with ESMTPS id 4bM8BP6Pmjz227s
 for <lttng-dev@lists.lttng.org>; Tue, 17 Jun 2025 10:19:09 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dnb/egmqazVORfcEZ32PGBoNtAGg9nCDIiKQZNnYDxk4aG/Tkf2opIDTz8xYEij2AhFERgypIE0Ni2Z8e0JFm4jo4hAls72YNBsRWdlk8rk+pHSQ0aSQ3V+iVjm0rbqCmSvA8b8lxvQ8/lG3SKAf0C8xD5tVp5a4eXNq/ls/af92K1Et/W0slqz7luAN78XDQ64ypJbw8wXlMWjwAwN8gAvgdlm6gia3k1Qre3fC7a0K3QNKCJlTjQtCqH4kFmeMJ/TMi6K0wXYKLCm6gjvYbeclmGuQmA/eWH4pzcxlsGvi0ATDTbplWfVMzTSoDLY6B5cApyi6SIbIuPZI2126qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SxRqIoSd+vOzOaKdn6utOkPtKrsLk2UyQED7hSp2FI=;
 b=ZNdHfvdFuwvh07ea8m7sQ5B3EBJgpYWCUlC9GTGmvc30tQao9ldCgkgZ0Vcb/zBgq2Eo6F27/rOPJ9qaP0x68TixuyrKSL4lR1GSjMPwgFO4Vy1LpnAIT+RdHki41vwQYyAFgVKwvuZ0CGNEpT1aWulNIfN3SMw81THAx18qnFHLUVowe45BJkOehZdaRKuDio5snA1ZN0Z7qwHYUrtxlEaLLvK8bcEpLGw4GQ7BiMvh47gI+QgzGVIRqxvjBjEP8FltFZPq/tIEqPGd3msBZROIayuTobzr5wRsZ00oZH1wks07Fb4YyQ9sVLyTNr1YmE1yt8CjA1tjRq/f1zHaWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:5d::22)
 by YT3PR01MB8930.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:7c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.18; Tue, 17 Jun
 2025 14:19:05 +0000
Received: from YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b5fa:c0e6:e5b7:54a4]) by YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b5fa:c0e6:e5b7:54a4%3]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 14:19:05 +0000
Message-ID: <d7e4f68f-2942-474b-96f5-9dc669b1d109@efficios.com>
Date: Tue, 17 Jun 2025 10:19:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: lttng-tools-2.14.0-rc1: fails to compile with libxml2-2.14.4
To: Norbert Lange <nolange79@gmail.com>, lttng-dev <lttng-dev@lists.lttng.org>
References: <CADYdroM27zgM1RWHoCocru7VY6kHi1=g3PK4QJ0D67Wra1tc8A@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CADYdroM27zgM1RWHoCocru7VY6kHi1=g3PK4QJ0D67Wra1tc8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::29) To YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:5d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB6319:EE_|YT3PR01MB8930:EE_
X-MS-Office365-Filtering-Correlation-Id: fd7a2052-93cd-4927-504c-08ddada9ea92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTNRbGRuVkk4aWU2MGQzN2JMdEZwR1RiZjY4cWQwS3UvME5Xbjd6RXlsK2dp?=
 =?utf-8?B?MFVqaHdTNmFDZmNUek1KTHJaNnJMSFFtZWM3Y3dJdnk4MTgrYTdvQjNnRUFt?=
 =?utf-8?B?V1FDM2tIbHZOU1NUZkdjUWtma0JrY1drSlFZUDVrYm9LSnJMakcrYmRMeHRn?=
 =?utf-8?B?NURSYzlDYzg5VlhwWDVxKzBORlFWVERoYlVDQXpDMW1mNjZhYXZxV20zbmFm?=
 =?utf-8?B?NGlqVFZvajQ2cXZHSFhXalRFWnVSUTBBRHY0YUlhSlBhQXVMdXdPdmdFdTdj?=
 =?utf-8?B?SG9KNVZOdVpKVHVjNXpNQzlvcnpwTllWRWVUSjhpck9zdE9uUU5Zd3l1VWFh?=
 =?utf-8?B?ZDJOK2d0WENxQ254YWlyTjU5dGx1VmpXM2NkRmtOVUZ6dzNyalpINGxZTUoz?=
 =?utf-8?B?cXVTekIzaTkvWElTL3FJWnYreTYyejlIRGtFTkgvYXkyQUludHNTTW5vNjdi?=
 =?utf-8?B?SGN3aUN0OHJSYU9tSFNzcFFLMUlXdVE4T29kSlJzZGZ4OVp6dGhmaVI3OXpG?=
 =?utf-8?B?emdUS1VVaDRJWjJkQTlxZS9MRGdNZ2ZqdzVnWVJoTVVLMWZlaVlIVU91M21K?=
 =?utf-8?B?UU4wSDhWaGpQWEpPSkNYd1JuN0psK05NUDk3Qzh4empLTlQwcFB5R3Rpakpi?=
 =?utf-8?B?SmV3Q250K0RvMmNnMTd2NFVTZWxJanAwaWZpOGlaaXhHRlljdkFqQmIxTzhq?=
 =?utf-8?B?NC9lUVh2WU9laVRveDVaaDlFZU1RaTBtb1pIVC9TMGVhdnF6MU5sMW9SVmxS?=
 =?utf-8?B?c3dSVnZJTGZ5RFJ6ckZac1NLRjVFSUNDbC9RZzZXcDZCL3VhQ3QvSmtiQVpo?=
 =?utf-8?B?UHZMOFhTZHZMalhvK1JJelVPS3lNV2FIYnVETVk0MXg3WDZjMDUwdG90QjJO?=
 =?utf-8?B?UmNkUUJFcUg4Wm5QMzh5TVpwR3BxOVpnMzBTYmVNaEtvTUVjZTVlU3BQdURa?=
 =?utf-8?B?a25tQlBXYkpZVTRvTDd3cDUyZXlCVUY1S0NwZXE0OGtwWU1hUzBJdjBCY200?=
 =?utf-8?B?RllnZ2IxUzUrajBpM1VSRitMdEUwU0FrZjlzUGdES2RqdXRlanRKUkRqdEJj?=
 =?utf-8?B?d1NNWGFQN0UrcmhOcGIwM1FaTXp1WTd0ZVQxMUZhaFkrbUxUMW11UlZoU2pE?=
 =?utf-8?B?YllDcThJZ0xjNjFuTUxjei9DS0VRWitscDNZWFFmYU9IbmdRVTBBakZJdFIz?=
 =?utf-8?B?NVhLRVpwb1paUGd0aEtZdnFWL21DU243N3E3QXBWNEtpaWdvckljNG51emV6?=
 =?utf-8?B?Yk5tRG8rR1p2RFQ3ZzJlWXlFQVk3TkRGcnVMem5RK01lS3FxeXNwMzUzQTY5?=
 =?utf-8?B?ck5Pb2twU0VUUHpxNW1XOGxkUU52Rmd6TGxrVGJsUTQ0bnM2clFjY0tHMEtL?=
 =?utf-8?B?WGhKUDJVc1JMVDdSVndPV3JPaHFIdVYyaEJzTlFmQzZ3ZHBrakJDYlNnM2tN?=
 =?utf-8?B?NEhYeDhCSHVMV0NKNEwzd1ArbTJHM1J0R091bFgvZThzRWdlREVOZFV4aHZr?=
 =?utf-8?B?NUErTkNvRmFRdDkyUlgwbzhwZG45akFYRVRuZnpOaUdHYlRtcDlDMk85YVI2?=
 =?utf-8?B?cWZqblNoTmdHbW1sMlptc0I4UllZWUhrZEU2R1JiTm9vWTk1d2JrMm1Bdnln?=
 =?utf-8?B?blBHQzkzMzVtSHN3RGh2RWZYNzZ0bi84bHgxMUpjMGpvUkhoQ0h6bHhyK1li?=
 =?utf-8?B?M0ZlR0pGVFJoajEwTFpZalFieXlHNXpxVWgxMGQ1RTBaOGVhcnZrT1VNMC81?=
 =?utf-8?B?cThiTjJVbGQxVVZRdUtMQmdiazN4cVpqRDZmcVlJQVhleHFHbEkxVmlDazR6?=
 =?utf-8?Q?K4VeZAq/O2qfZOONhkeOiq0rh19AZlm82Wn+I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVliQkpmU1hRTk1KZzU0RnowMGxNUEczck1rMGkwc0Z0dzY0anJaQ2pPVjBw?=
 =?utf-8?B?KzZjMy91ZHk2ZitDQ0lhM05kZjgxQit2VDlhcUNVUHRFU3cyZXdhQ3EwdmdD?=
 =?utf-8?B?UE5Ecnp0TVhlM3pTWmo1c1pLTzhJYlo1K1VxQUhOSkIzekI0R1d3bW81d2Mz?=
 =?utf-8?B?bE91NEtHSE8wSkRpbFVNUGRUclFrU25zNnlHWnlKRW9pTUlsc0hjNFBTZ3dv?=
 =?utf-8?B?Mnl1ajFkS1lwR3UzMFBzdGFkdlVZenY0VGlIcEIvYW9NdkJoeXJCUXVyR3Fz?=
 =?utf-8?B?VkkxNUVzSGRuVGxGYXlVRzlkeGd6cXdwNUhHR3BhVlVxbTl3UVVvcm1STDBj?=
 =?utf-8?B?Vkp5a3NuQlg1VVV4NVNJR3ZLRUJQbnVETFFwUy9XckJkVnlKRUxvS0o5WHpE?=
 =?utf-8?B?ZW1tdFdrOXFwRnBuU0xRVFRXeWhLWWtZVE5nZlFjNXBYZDZQQXpCUnc2WENm?=
 =?utf-8?B?a05qOUFQQ0UwTFM0WkU3NFRHb3gvQzJneC8yWng4UFRsQTgwMUN5anU5VUkw?=
 =?utf-8?B?bnMzd2VXVmhPQVdEN1BYcGlTUUlFZzcybGtwalN3eWJFaERyUkZJWHRYaEhj?=
 =?utf-8?B?Z0dZcFlqUEdjNkh4MTNkMzBNNU03OHBPeEVlOFJmRCtuTVo4SUdZaElrWkdD?=
 =?utf-8?B?dmtXQUhQc05ZNVdNcmVYeFphZmlhYUJoU0s2Wjc3djdyMk9Pd3BjTmhEd1pU?=
 =?utf-8?B?N0dXTzZjQWgrSnE2YnBXQnlDdmcveXdoa1lDRkNncDA1ZVNreDVLc254ODgw?=
 =?utf-8?B?MVV0SGFiN05KcFZPYm9KaGRvZXNmSFNNaXd5RnNBSzl0NktGWXkzTWtuaHl0?=
 =?utf-8?B?V25pZnorSDJYclQ4OFJRVzJCTGZGL0tydjBscndqOTZKQk92RFJtS0MwQXpR?=
 =?utf-8?B?VHl2ZHhLcHpJdHlHQkJNKzRmRXpjT1MyRjZHUTdXNkJYVlRlQ0xlN3Y2MkZU?=
 =?utf-8?B?RTZaN0ZKOE51UHJ3cytBYUtwM2taMzJWRFVZSVF5bTgwanMxOGJnOGF4UHVy?=
 =?utf-8?B?cDFJSVI5NkdCd0RjOCt0cmhUYjFTTzZHQ3hvbEcvNXFqYmFOU1BXd2Q3OGM3?=
 =?utf-8?B?emRWRWlmTWtqUjRINVZBaGc4OG9DLzVHT2kzaU9mNUpZZ0ZHN1VoZVdHb0VT?=
 =?utf-8?B?MmtDQVg2eEJETjhGNEh2bDZTRElpVFFQT3dqYVp3N1huajJDUG1RdE5oaXNl?=
 =?utf-8?B?NDA0UjRyOUZmVkhKNEhUQ2lQdjJyUEhSWTFxNUtabzlTdWZjbTR1SmEvSFF5?=
 =?utf-8?B?VHlJZHY1UnUxTGd6N1RWTU5zZ3RGV3REVkxCeWpIUnlXVXpTSUFESVRkWVhF?=
 =?utf-8?B?YkthZ3RYNnloMVlqMm45c21ZNEhobVJuYldXZlVyb0NXeENzZGE5dTA4Q1JQ?=
 =?utf-8?B?elV3OThPeFRZcXEvR1FPMngweEdleHhBNGhqYmxlc2gvMHRUYS9aNHVCdnNI?=
 =?utf-8?B?YWw2c2Mrek1ibzhlZTNJTGJ5R0tUQUdwUjlJSGxacTlmY0VYZllqdms1Z0c1?=
 =?utf-8?B?aDdQRGN6dkFmemlQd0E5cHZOeFZSUk1TbVNLTmx4dm4zZTVidlVsZTFuMzNY?=
 =?utf-8?B?anhRNUNhS05reUIwZlAwVTM3WUpoRU4zYlVKRC9kcUxhM1dEWk5HUzVjYXhC?=
 =?utf-8?B?M04rS2tmcXd6dzgrNnFJeURCSHA0cHpFZHZRaGJ6TmJ2cTJ6U2dZeGZ6bzly?=
 =?utf-8?B?QXhwN2RLVmpDVUdld3ZvV3RFRGd4Umh1a2hWT3hpdlVraWQrR2xocmRlT2cz?=
 =?utf-8?B?VkpheHA2cUVFZmZ2SmMzR3ZaMXdkeVlvVEJhWDdtTGNJWXp6T1ZHOThtc2NU?=
 =?utf-8?B?TGZ4QnYrcDBhQXlxUUFQNkZnUTA5QnBqb29vVEpQV1A4TTV0UDJRVlM0ei8x?=
 =?utf-8?B?bVhFcllkckUyNTByVk8rbFJ0eGZyYU1JNjNzNCszWFlSMjV3bU5XQWloVUxm?=
 =?utf-8?B?MkMzTi9SWHpvZWtMTFI5b2U3Y0lWUFN0Ny9YUmlOa3FrMzdwSTlVTXBWb2NC?=
 =?utf-8?B?eE1lL0NuT3NlUFBHWmNOVzZyVTRYQjNROUhvUEtseEIySm9YTFN5ejIzZWFr?=
 =?utf-8?B?Q04zVVhrRUJHazR4b3RWK2ZWN1hTaFNlVjhtSHZ0TjA0NjJrT29iQ0s5cDc2?=
 =?utf-8?Q?PvIuiKoRBaa+YkRUIG/nDd8Kw?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7a2052-93cd-4927-504c-08ddada9ea92
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 14:19:05.4869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSd6Disn/DS/EWUVBxeQ0HgyBahyjGp6MsRyGt2Eyb1ClasxDGOXpKPsjN8kKeaKbLaA2q8JthZaMDRgYkFV5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8930
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

Hi Norbert,

thanks for the report.

The libxml build failure is fixed in 
2d2e77ddc9e3e63c3c658e824fb754f5a534a6ab, which in the stable-2.14 
branch[1] post-rc1.

thanks,
kienan

[1]: 
https://github.com/lttng/lttng-tools/commit/2d2e77ddc9e3e63c3c658e824fb754f5a534a6ab

On 6/17/25 10:15 AM, Norbert Lange via lttng-dev wrote:
> /tmp/dev_develop_libxml2/usr/include/libxml2/libxml/encoding.h:173:7:
> note: declared here
>    173 |     } input XML_DEPRECATED_MEMBER;
>        |       ^~~~~
> ../../../src/common/config/session-config.cpp:297:75: error: no match
> for call to '(_xmlCharEncodingHandler::<unnamed union>) (xmlChar*&,
> int*, const xmlChar*, int*)'
>    297 |  ret = handler->input(out_str, &out_len, (const xmlChar *)
> in_str, &in_len);
>        |
>             ^
> 
> Changing the call to handler->input.legacyFunc seems to fix it.
> 
> Also lttng seems to need libxml2, but doesnt add the necessary flags.
> 
> Regards, Norbert

