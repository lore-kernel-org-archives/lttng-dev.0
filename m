Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFB4C3ABBE
	for <lttng-dev@archiver.kernel.org>; Thu,  8 May 2025 17:25:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZtfCb4jXpz1myG
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1746725116;
	b=hoGRv0+hmqR0SQWoxJwyMHGRkrOU577tBxUZLUoq+BdW/2nN9tcMSaCIYPDZUsVEcEGX
	 1ogwn7GsU3haIoJjHmtyjhwySMdAKcuINBigDdtcnL7+Fq+1heoaU3Mz+eTe3ZWUqw3IF
	 DTJD0OFGb6O/a2QhTKjhbBtEW09J/kiJOIh543oKVx5Oc/RdSjQ6XPXD4dQBMZ5B4nytP
	 e+8KjtXeahY028PZmX74+06GLh/j7qR+lP5TjA2iFarCC+vwj4F3A6ZdQHumadXVrK65i
	 l4otSW03rBAc2sP7nL5oJc7AlkAlbLrflf0F16a5Vrd9Qy+aU/NMwChW8gfs2ID3Xdw==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1746725116;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=UjAQincqxIRWSVT/8O/+/UKkGGMFkVvLJOJThfKFGEc=;
	b=JTACozoAoBIi90PtZWwud0VdTlcf4c24OqLCMKpdi8e0vt1AUleZc2RAzuSU0I4Eq2GK
	 xBRTsjN/PZsyg/48ItmBWKOzphIVIjEyQPaMgg5+YrOUJYRyWdotrMTAzQk63IEjs7SL9
	 CZ/8g0CUKruJiLketpTekX5bvFB+1ZGV8Y6ZU/TIQZTtGINq6bVzWfUynWXViiKCrdRXd
	 qFsELdtRsd+bZL7F/Dm+9IJrcuYHyyBzb2z6yQ7AyKDrFq9FwNeA8aSHG94APxMarGutf
	 OTZ1y1hUcfq1I0J1bj1UiguZkZuRPvAcgPiGEAhJG6W8xY1PaTKsNULvnWVqJebiNJg==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZtfCb4jXpz1myG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1746725116;
	bh=UjAQincqxIRWSVT/8O/+/UKkGGMFkVvLJOJThfKFGEc=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Rzj9TlNZBGlLtql9kdrw8YCm/48DwFAJHCgg8CpD0Z2e/I380m2Z5m7fYwS9PdLhC
	 4Zjm6g6ih58QfMXMMmZBH2VqnEAMXTgnx4G9ck7slZ/6sG9WRqCoqvRf32gNgOlgZ7
	 TxpTtetttd0aa3eHSTzWXVEnSVtuwpwN0HdHoUjVx7koEzfLuvwgBAMKUevKvtyc/n
	 Aoy8ZOGa5Pphn8DaipuiUoxrbYCc86CQwGI6HeeQDJK66otTrKxusbTDp6zzJjSo5A
	 fN/DMa8c++sAJUHd97GZW98ghNkNtXbOEZa8IVIKF6RRDMt8bGfUsRm+YV4BYkO8ie
	 4S+tHHDYKZcPg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ZtfCb4jXpz1myG;
	Thu,  8 May 2025 13:25:15 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZtfCY6xG1z1myD
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZtfCY6xG1z1myD
Received: from YT3PR01CU008.outbound.protection.outlook.com
 (mail-canadacentralazon11020087.outbound.protection.outlook.com
 [52.101.189.87])
 by lists.lttng.org (Postfix) with ESMTPS id 4ZtfCY6xG1z1myD
 for <lttng-dev@lists.lttng.org>; Thu,  8 May 2025 13:25:13 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvacNcsy2ZyitjZyATFhso4CmrwN+uy0GscpOZYwEUCoiFMR2n4Ysp0ux66SO+xIebKWsbwvxJJ+IERcbXpEvawHhC6Vk21CMA4NAB1CCWEZoSoG+1WNBNuPrubcOCBYEyo8xiEfr6MI2kM4gwEuitTapoj9UMfpShL//RRBqf/KusqDTsLGjJX/xvWp8adgZfwZeMme7zPs6QO+t8A/bSgYh2VdnUjSy+EQ87jgKkezf1G5/JVXAMLYdJ9iHiA4VrNkgzvZZ2pCkA9QzPUVSOGccbJjZljwa4TwBcy8TY2gpEOR9r9KNmHXZEWDnxAKMfrgnr6EtMJoYHEXirhzhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I14yXtXkGP1yTObQjxb2y6WQKlIIDrRxeRLNfAVJDuI=;
 b=mONt5s6Pbo9F9OpH7I+a1txCcnqOaL8owIo6DXgOsO0r9U7wNW3Fn9s6cs7xIJz1h34j0zJfyDa7+yBr4DlMYgEMaj+UwRDSLpoKfAYG86B+1jmjcTbMWO05r28z5fwYNtzcQPdMiYFVTXjrtM6OEK6UfJ/ZL1kGCuKpdAdd9UlSd5TPg8d3DOnZ5XxDjSbetJOdDb1LeM5NiZ1VyxFlR0tHhG9hq877dd+W2RafurC188vrkwIE3cxSaphgLsXnX1neH/teefkTI/Q6dxap4eIMDY3kB4+4GrE0BKc2Tsy+rj1JoisBzXpelXTVe4h9POetHuQIscM5YcQCcB5fpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT2PR01MB5367.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:52::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Thu, 8 May
 2025 17:25:09 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%3]) with mapi id 15.20.8722.018; Thu, 8 May 2025
 17:25:09 +0000
Message-ID: <0e6f9c3b-8daa-43ae-a3ee-6d7917b05b2e@efficios.com>
Date: Thu, 8 May 2025 13:25:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Not capturing ust events
To: David Aldrich <david.aldrich.ntml@gmail.com>
Cc: lttng-dev@lists.lttng.org
References: <CAJK_iejrz-U0-XK1hmoH9=TCLcErZTVE16XdyKzXX0buJuuoCQ@mail.gmail.com>
 <90aac2a4-0a4f-4d2a-a90f-c96c9be820af@efficios.com>
 <CAJK_ieibZJjJus6PdOnWAiLFOymm6D8AmkG3vdpDnuazG1wAbA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJK_ieibZJjJus6PdOnWAiLFOymm6D8AmkG3vdpDnuazG1wAbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0271.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::32) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT2PR01MB5367:EE_
X-MS-Office365-Filtering-Correlation-Id: 019ebedc-d4bb-4873-188a-08dd8e554824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkJBOXpBd1NaNUhlSGNDQ05CUEVhYk9jVm1uUUgwRTU2RlhjVS9ncENqd29t?=
 =?utf-8?B?eHV4Sk9NYjdLZE1tY00yaXl2WmZHdmFWaU1wQ0h2SDZkZ1NWeGJ4UnozT2cw?=
 =?utf-8?B?b0wzeXJjbmNyOEpyMUpNK09rVEs2VzhuOFIvREs2cDgzcC8wdTVYZ3Z4cU1N?=
 =?utf-8?B?QWk5eUhBRmUxOUdnVTU0Mnc5OTE3Q0RwS3RMWXlrUmNxYkVNcEFVSndwSXJy?=
 =?utf-8?B?bTRCOVBMNzNzcUtSYkREbXRmclRZWitobG9velFmZ3o0Q0pTS21MNWx3eWxU?=
 =?utf-8?B?a3FnZlhXZ04wMDZhaE9OT0prM051UmFkYmo5RzVGRTh1ZWlkTTM5a0xONXRN?=
 =?utf-8?B?TElrOUZISmN4TGVsWDQ4bmdYMzg4bXhsNDNMaTFNVWcxcEhjVHN6ekJIczVY?=
 =?utf-8?B?UTArUWF2NXFiamVSK0J3OFd2bUNtMVdGMlFySWZFcWRzY3UvT3c0cVBnN0hH?=
 =?utf-8?B?bnZXdkYrWFRNV2UwQmRNSDB2L2VKaVRDWC9QazduUGsxQTRBRkVlYWI2djdD?=
 =?utf-8?B?YkFNc3dNbDd2WVBJdlVra3IrQnQ1OHBVZnVoSE0vRTNUTm9ZMzc5QVBBWGdX?=
 =?utf-8?B?T3VHZFE5cEJxeDF5VVpReE9DcTdocXgwL0srMlRweHcwZkhPSDhNYldPN2Nh?=
 =?utf-8?B?eDlKNnRmcmovai9FRmN6bmF4UEREdkpWR0ZHR3orWDZSdlNsNlkzTVQ5SHI2?=
 =?utf-8?B?Z09SM0xCV2Jjc2UzMFZ3OE1wdHNva2t5cklRR2JhWGU0NnFTR1k3VU5paEJ3?=
 =?utf-8?B?MDBqV0lSNUNzSW80bElzZmlBNm5BVTlqYzRXWHl0WEo2ZHlwWWxQNFJLVnlr?=
 =?utf-8?B?L2tqdis5ejRlbHpudkhFaEZIc2Y1MHlqbzdGMlFWRzBUdFptVWt3RWtQWVUr?=
 =?utf-8?B?cVUwRnBkeEdsTlV2ajhiQU9JbDI4TVFpZk9wR243NlpjNDJnSi9xaW1EUUNV?=
 =?utf-8?B?T3dkem8zMTRqVFVNVVNteHZUYXJKalRweG9qcmdzVUJxaUJvaURUYTVxNk1F?=
 =?utf-8?B?K3VxREhLR250RzlOK0FHZjd1VkNqTjVaUDlUMnlIOW45d2pwdlNiODFleXcv?=
 =?utf-8?B?amoxWGJnT2JSaDhDMmRiSjRLYXVQcXZLRVhxNHkrUFhDNUNZNjVNOXFFdStO?=
 =?utf-8?B?aSsreGI3TWZkTnoweUE0VW1iMXZxSWlkZ25xdGt5RVJFanRuRVhkUC9zUVFn?=
 =?utf-8?B?cXgxU3J1WmZDWTlNTkptUkE0RTlDNkNCaXNrTHJBekVLbnFLQ010RExJTnpR?=
 =?utf-8?B?U3YzOE1zd1g2N253dzRCOHR0QVdJYy9vWCt0eWw2VW9JMkFPWVNpSGZUSGR4?=
 =?utf-8?B?RmhLeUs3VUhnZHMrcHFpT0ZxM3dTSWxqQmxQak1vbkhsN2FNbW5lam5GVHlL?=
 =?utf-8?B?UGxsVnlGRW5id3k0c3N6NXhxSUJHczBGcE5lMFB1T21CdWk4dUxqZThpZlB1?=
 =?utf-8?B?T2plaVNnZXo0ZEhFMVNCOHY1NzR3UFdKZE15ek41alJZYjhDVGxvcVhxOFN0?=
 =?utf-8?B?MVV5R0lZUTVaaVJmZitDTk40czFFa1JGdzN2RzJpU2RsaUdvSkhkNGtwSlFU?=
 =?utf-8?B?YVN4VVk0SXV1L1NDRzJRNHZsMnNyNVFTWVpMV0tPRG41SFFWTWNxUUJHVmNQ?=
 =?utf-8?B?ZHRQWHMxVG1sZVpKYUVOeTh2elV3Rno2ckoxcGdhZ2VnTEk5OTlMTUtkRzc2?=
 =?utf-8?B?a2Zua2pvWFc4bXQwYmtVZUZTOUR0V3FleFJaQUF6K21sVndON1U5WHJEZTFa?=
 =?utf-8?B?ZlpCUkE2emlOOVhDcGV1aGl1Ly9DNFVCdTVIS2RnT3NiWkIrWW96SzR2SlNM?=
 =?utf-8?Q?IZq7hLksHssD/NfwtwX+E6eWZ6sBEZK92An28=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTgxNTlTRytRamtJOTVrSExWcTdEYkxrNTR4Q090ZVFFclhNdXd4VXNLOUl2?=
 =?utf-8?B?WjU3THdNaFZmelA5ZWFHVGloaS83dUJOdjBoaVVtbmlTQ3M1MWFOMk9EelhX?=
 =?utf-8?B?REhSa3B0cnE0bFI4MG0xTHhaazdHU3Z0SkVaKzlnQXMvckpYY0lZMWpRWkpm?=
 =?utf-8?B?MmxYTkhVbnZJcmNxRTF2dTN3WEd0NDVzcjJlQXgwOEFJSDRkWk4xcW9HQW5T?=
 =?utf-8?B?NlVTeEJ3dFF4cVNybXAxaVhhZkVjbnZQUUJLTVpZWVlmLzlseE54cmZYa0ZP?=
 =?utf-8?B?UUNKVkhpSWJ0S3FSaHBTcHVpa2tLRkRsWEV4ZERRaVFpNDIvZDR5cFpRNVJL?=
 =?utf-8?B?VDU4UFBrc2xLKzBvMzVDaVNKQWhUdEcxdXhjOWJ1ZXE2NkhvSk0vZjBUdS9n?=
 =?utf-8?B?emxGZWpURFV2U255dklTOCtlOGVpamE0ZW4vNk1GVTVMUi9tRUszT1o4cmZY?=
 =?utf-8?B?SjBUQmFUdE5NUWFRQ3NxVGRXNWJOSHBpU0tEcDV0aStZQlJEWWpOT3E3eFJH?=
 =?utf-8?B?cThZb3VqWUtCdWNDZytqVlAvb1ZadjhDenlVMHZKam9vK2hnN3FDbXlWVXRO?=
 =?utf-8?B?dklZS3BPNUVjRVZCQnBiWng2QXFUaU5TV2Q2Qkh3aHZpVzhTaXBSRWluQ0ly?=
 =?utf-8?B?NWMxUHd4ZXJESDBOSkc5NzlOVnBkMEx0TmNZeXg5OWR4bTQxNkpzbkdhMnFX?=
 =?utf-8?B?dGVzbWluZEJQYVdsaTI3d2ptb0FNejY0NE5qdUdvZXJ5MHhuQTRKcEJZVW8y?=
 =?utf-8?B?M2FrU3dIbW1YQTVHbkNPNEJ0OUtzc2M5SENHTUlNRnNNUGNvT1dyOFNHYXM3?=
 =?utf-8?B?UDRaWlN4NjFYTW44K1ZUUi9TTlc3bU8va1VVY25VbVRGeDZoYVdSc3ZzRG5P?=
 =?utf-8?B?Y1A1bUtyVVQxeUVLQ293SksxNE1Mb25ueDVya2x2aGRSWG5NMUt1M0NOb21L?=
 =?utf-8?B?RE9wZGQyOEJlSldlaWR4ZEJCZmozSkRRdHZ0TU5YUDl0RWlzSUg5VC8xcWVn?=
 =?utf-8?B?em0wN1hQWFE2RzlUVUc0TzRhTU5SRUhZTmxoWFJVNit4YTdkRmlmcmhsRCtI?=
 =?utf-8?B?WHhsVGE2Z3RGdUVZZFl0YkFFSTNIcnh0RzNabVUycEpZbnQxK21ka0RCZW5t?=
 =?utf-8?B?UkU5OHpxczhmdldVakV1dzRzbENzSDdVQzYvQzFvZEZBYUpOOFphRjhLczQ4?=
 =?utf-8?B?TWdCL0JUemhsMFQ0OWt6aGZwc094TlhxTldCNnJ5L0YyQXZvNzcrckVkb2x3?=
 =?utf-8?B?aXBIeldmUmZaemM2TitHRlZIVFB6WExqYWZ1ZVFXV0FHN3p6b0FZc3RibVFx?=
 =?utf-8?B?aXdRVGNVcHBEd01IUHk2RDJZc3dTTFU1NjQ2N2xTQXU0bGdvZjJxb3gvN2I0?=
 =?utf-8?B?TTFKRi9XOHdYN2U3em9JNkt3ZWNyYjhSMHhubFNYYS9wV0hQeTBrdllwWmt3?=
 =?utf-8?B?QWUzeUM3N0JuWGdyNWR2Uk5QZnZ2TEdIc0ZUVVNZS0xMNHpvZjB6cUlSbSsx?=
 =?utf-8?B?OGZucVFZeW9vYnR1MHo2cmdZTDNxWkF4bFhEcDVGMVgyYmdQN2NZTndxYklW?=
 =?utf-8?B?NHBIQ21CWkRjcVJReGNZWHRnUzNRSG9IQllpVDB3VGYzcTdWUHFWa2FiM2hq?=
 =?utf-8?B?QmdrQk8vVFh5TUtkcWZ6U2lOSEZ2NWEzWVlROXdEZFFSYTllNCtmbVFpVGZr?=
 =?utf-8?B?bmcvOCtHVWtRSDZLVjhJMWFLbW5ySzVGY2VrbGlzNFM4QVNxcUdqbnptSExl?=
 =?utf-8?B?RU03bEVTN2RkUG1maTNQZUdCYTdSN1JmaWJhN0dPSGNFTUxhdGs2MGx6RDRw?=
 =?utf-8?B?cDRuR0R5Zk9HcnBIaUpGc0hLZkVVNllkTytGMnRxc3lRSTZteXhlYXREelNR?=
 =?utf-8?B?VXM2NUIxRG9RTVFYZzJnN0JJM01iSDZ5dXBVYUtlQm1nT0FPS1BjOERVVEho?=
 =?utf-8?B?QjBBOW40QlhNM1pBU0VWWkFUNm5vWFk4Q0FOSDBmUmtRakk4d0lCREQ0aUdm?=
 =?utf-8?B?aFZXQ1JIc1FQT1JrbkttMUR4NWNoMSt0NWZ1Z0ZMQTlJUVVPVnM4NHJUQVRN?=
 =?utf-8?B?VW9NL3ZPK3FMQnZDSGlXVEhFK1V5QTRHL0ZiYWFreDFUeFV4UnRXS0k5ZTA2?=
 =?utf-8?Q?HcO6TcHJE1Hkx50m8azfr1Gfa?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019ebedc-d4bb-4873-188a-08dd8e554824
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 17:25:09.2201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVKCAkiifwt0uHpcaNaaRYf6oqj6gxu9joYdJf47UScXnjBaxyGx50j5k8VcXlI5qy5LpOwJ+CMAqg0B+Dj+sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5367
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

Hi David,


On 5/8/25 1:02 PM, David Aldrich wrote:
> Hi Kienan
> 
> Thanks very much for your reply. I can now capture UST events. (My
> actual problem was that I was not linking to lttng-ust).
> 

Glad you caught that. I had assumed it was linked in :)

> I am now using the method you described:
> 
>> lttng create my_proj
>> lttng enable-event --userspace 'lttng_ust_tracef:*'
>> lttng start
>> ./my_app
>> lttng stop
>> lttng view # [Optional]
> 
> This works and captures UST events but I am not capturing Kernel
> events.  My reason for running this experiment is that occasionally
> our application shows glitches where a task takes longer than
> expected. So I want to see what happens in that occurrence - perhaps
> an ISR is running or something like that. So I assume that I need to
> capture Kernel and UST events.
> 
> Can you please advise me why Kernel events aren't being captured?
> 

In the setup above, only a userspace channel is created.

Assuming the user you are running the `lttng` commands with is a member 
of the tracing group and a root lttng-sessiond is running, a complete 
example might look like:

```
lttng create my_proj
lttng enable-event --userspace 'lttng_ust_tracef:*' # this will 
automatically create a channel if one doesn't exist in the session
lttng enable-channel --kernel --session my_proj kernel_channel # [1]
lttng enable-event --kernel --all --channel kernel_channel --session 
my_proj # [2]
lttng start
./my_app
lttng stop
lttng view
```

> Best regards
> David

thanks,
kienan

[1]: https://lttng.org/man/1/lttng-enable-channel/v2.13/
[2]: https://lttng.org/man/1/lttng-enable-event/v2.13/
