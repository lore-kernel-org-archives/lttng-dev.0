Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D189C77B7C
	for <lttng-dev@archiver.kernel.org>; Wed, 25 Jun 2025 15:50:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bS5qc35spz1Rf5
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1750866606;
	b=URrFQJXRYQa7qKruFO3ELonjcC2iLFgRRx0tf7P48Vui+8W0yPJtN7dvz4pZ0mOsSC5/
	 380GDXg3aHNggNn3wjxw0kEHQGvDf/IFvPe9Wb4V1tG2bN5BokatbPH0JGiJhFCNGxsTI
	 8GKw8MMKVjWdpMh8ANRnIvd5FccHZf1SPiHG7w6iSx2erDjxePLkBXz+Ws7lFOnS+ziPb
	 YoohYKnwD+qTG+0+UU0Xum0P90bueZS8lY+Qu+vOxQTBJ8huEf0E/KKKQYNMANX06NMmB
	 nZFM5POj7NK96AoEZXD8c7iStCenNGjI3S+h9NwTG1mq7WfoEfKo+oxwb9X+G9JGVPQ==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1750866606;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=50fqbzIAja/fv9yfRyF+2kDLq4ad+vndRGyc5kSmg8I=;
	b=bt8yycfzx6o9qQSLEsamzWDUybUmMLkBvaQXUTTi/xWGHFZS3+0dN07R+eV/HhMQ2x8s
	 c4LKa+I9/BXAfH4oSu87+3LHosZhdvlvjBlGd0uxRo242ZYrE98DdyF1JslIGDaMNlLOg
	 0T7oR+TQcaF8e9pttY81SQ/H9fjXFuHpy+5bwObBXvlxz5Sf0yNn9bv3+AZq+y6+LBG90
	 hROm20tMy541FqSe1mGf10pRZkY/n4v2hFUi1BvZgsORpheZ4WsLQMGWhEb698x6TgHDC
	 d+A5Inc18crhZ68n47BaQOFk1qmcVx1VWtD2ddGnTrvHA0Q7ZWhR1aVQKrAFgvQzpyw==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bS5qc35spz1Rf5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1750866606;
	bh=50fqbzIAja/fv9yfRyF+2kDLq4ad+vndRGyc5kSmg8I=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=oitlBeZssWpWrsanZ1pLrchUM1YWa5nHlKLIGa7xZpb1ZmBUEWU+rcKLXftMReaQp
	 hs/sLxWZ+T+1DZjYfuBC2sy7dLQB5PoKOZ0GgPSwPJqwudMr3jkXfpMdKxuuWzlcUW
	 Y+nkTz+RH6AEdeWreklVvyrqF4vwRm4kJEv5Zp2j9yNrxgHqi+fvNdKctWag3uKbKv
	 4rOTZBsBooZYa4g6sMrSrvOZwjPquBqZUAd6PKrf2VZ62j0lztJ0bdski0A4fQoW52
	 JnvTpJjH2rzUGZdCmrdfrKgtw1MMJUi0d9ZufUUVloqwf52J7tkzM1HTY1KTWNvn+5
	 KxvROmI7OP1kg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bS5qc35spz1Rf5;
	Wed, 25 Jun 2025 11:50:04 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bS5qZ59DCz1RZK
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bS5qZ59DCz1RZK
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2118.outbound.protection.outlook.com [40.107.115.118])
 by lists.lttng.org (Postfix) with ESMTPS id 4bS5qZ59DCz1RZK
 for <lttng-dev@lists.lttng.org>; Wed, 25 Jun 2025 11:50:02 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMKhCC0FjXwHrflnVcTWkoHM/eCbfXhUTsKdft4vM26z7Vs61owoFUhPmB7Nyc3YFBJQWwGy/egN6svYI82cXeBCogK5oFpVPs7VmJVpOq/r3NVXW5qzATa3FkzrmvvWaAnKYZNcqjYK0DxmKVzUItaw/aZ2at4oVf3vhbR1WXMvfelIwNbmgnokul1w1G1qM8T0Q6R6bdCd0+lw5VT83wcaAJ9gUCrpVMPK/NNIdBlUjtGvOOfW9VzczIZMkG1qQ0NjuraZj4MhbngJ/dHPPaANjSWMAzwFXtvMCk5KnWqeQ5DFIY7eBaurmdYT497ZBuKdik3nZXfS74L+1Le5Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pNPFMCdnkRJv5qiWD52abacKj8YCVedo+qwYC370ak=;
 b=DRknorswb8ov/47n56V2tMiIJ6X6IPcCA3mipV/UrBgEm82aZ194a9+mNcJd7dR8BHSUKEZ9dG4qbMkYhwO9lJq5o210Y4LkpIf7MsP8/Qpt3IHf3wnjhn3GLZE2GTmkr+uJTO04amjWgsSl9FhOUsGhGKbkcoE0l3yJF3daurM6AolzjtnKgoeMOLvIG24CvmfSlHa+keNRDKtnk8O9FiF2cDPLPnRVtm7fsvJ5LlX5a9vTcndH/GpjSMJ8waWQ+4ZTvX6fAQGPp9IrJElPdXUW3LM0XxdwRV08U+PRqfFd/Wpr/CyLRMBLa91g5CqlUWMQCkPJ90Qg1IPB4x50dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from QB1PR01MB2353.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:35::26)
 by YT3PR01MB6099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:68::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Wed, 25 Jun
 2025 15:49:59 +0000
Received: from QB1PR01MB2353.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::2e56:55d7:d22d:5de2]) by QB1PR01MB2353.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::2e56:55d7:d22d:5de2%3]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 15:49:58 +0000
Message-ID: <6914656f-9b7b-43fa-9dd1-9b27506c6d2a@efficios.com>
Date: Wed, 25 Jun 2025 11:49:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Malformed Tracefiles
To: Georg Muck <georgmuck1@gmail.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <CAEobtPOhc8K3c-Qcymm1m-pRpHSZyDSarAKoGKeiKqZfUqXOCQ@mail.gmail.com>
 <34912d84-7750-454c-9f96-fb8d865ba8d8@efficios.com>
 <CAEobtPN-Yq_zpu18FsbS-2s4WhJhpEgjK2yuQ+NeOxcGFuaENg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEobtPN-Yq_zpu18FsbS-2s4WhJhpEgjK2yuQ+NeOxcGFuaENg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::17) To QB1PR01MB2353.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:35::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: QB1PR01MB2353:EE_|YT3PR01MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 77d225c2-efbf-4795-3271-08ddb3ffef88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXBNb25RSGNiWStQc0g1VENEZzRjYVFPb2JHSmMrb0J0REc5Z0dxd25GdERM?=
 =?utf-8?B?eFozSGtxZzRwZzFtQU1mYjlpYjVDcm82WjVKdE1RSDJIcU1IaDhTeGJyYWg2?=
 =?utf-8?B?dzZJaHRrRmo1V3hUQjNwcThqcGZ5VEgwdGl0Z2JORCtGRE5YeFcycTlBZmh3?=
 =?utf-8?B?TklnR1pPanE1QmxDcFJxQzRIbkZLUUhpSE45dElzaTJmMHhpRTBVbmg5V1Fo?=
 =?utf-8?B?OE9uZzUxWjQ4MVp1YTZMUDFhRk4xOStRSGVlWVQvSTAwTGtrVVd1WHcxYXc1?=
 =?utf-8?B?VDRTK0xSYUlReTZ3aHhFYTlJditJZEtQK0kxUm5lY2srN2dBZ2ZYbWsrZ08y?=
 =?utf-8?B?NVgxTlNWaDl1S3VXWW0vYmc3NTY5eDAwaS96bWZWOHhJVzcyamd6REM3azVP?=
 =?utf-8?B?SkdDQnU1NDJqbHFkRGI3ZVZNZ05CenIxZkQ4UEV4MlpKUVdEZy8wZVBlalJZ?=
 =?utf-8?B?bm84RXJjQ3pJZmhJdjBTVkRqY1lnMDRhNWVxZ3JTUSs5NGg1UDRsbXNOV3Qz?=
 =?utf-8?B?d0Rhb0VPQTV2ZHR5T3RiOG9sc1YvZUJLM3NtL2VLd2tuRGVBbHZLSWtvbzFr?=
 =?utf-8?B?TldjbnNMZ3IzalF6Q3psYjEyeENRMW1zYmxuNHdzUDZ6NkFUUnlQKy9yZURz?=
 =?utf-8?B?UnRSYWRzWXFHMGtrRGFxNk42U3MxaDJCYkIrQTEzNS9FdExCaENTL3NUTUp3?=
 =?utf-8?B?Lzd4SmJtVURIVHRNTHlOZy9iWk5aVHFtNEJ0UkRxY1RPNHRuRmE0c1lTTS83?=
 =?utf-8?B?cFpuSVhqdU5VZ3ErbXAyM1BwVkZZUThqV1pRR3pkRzZUNUVKTnJkTVpLYWxL?=
 =?utf-8?B?VllGMFBNYU9jRkR0bFIrS01ZOHVUNS9ETVIzVjVRZU1Ca2Vab2NLM3AvWVEv?=
 =?utf-8?B?QWtKMDZhVU5TVVB3aHMyc2JGUHVGWFovY3ZsSVB3Wng2bVU0NW5FSzdLN1Fw?=
 =?utf-8?B?WnJ1anR6NEVmbysxZU8zQWZ2bGllSTFwODRtdXorNnJIVWVMTXZVdkJDYXVY?=
 =?utf-8?B?bk9tSVkrQ0NHTzhaMlJ0RG96WG53RkpxZy9MeExuVHFTNGdiZDQzSTNZUDlL?=
 =?utf-8?B?K21VcitQWVRMalROUGZRL2ZmSGMxSWpuYlI3aHFOaHVzMmI0aTJwa1J4elEy?=
 =?utf-8?B?VWk4UFg1UWdxN0JTOUw0anA3VFowUnJXelNucDFvZ21rbnh4YmRONkF3dmwz?=
 =?utf-8?B?cFN5akFNYzkrZUYxdTFyRC92bmxnV284dXM4aFZFUGFCMmVJQ3JVTU52cXUw?=
 =?utf-8?B?UW9zMjlBRlNIUE56ekxDTzhJL3hyUkNPZksrMkpodWg3ZENoWStjUExLbHBW?=
 =?utf-8?B?aE1wRCt5VkR1bUsxbFNncm5XMGYyMWJjMnpxM1hqSjhEdkhSK3hteE9helpy?=
 =?utf-8?B?SkRnOGZ3cm4yOFpibGNLUUVST2hlYlRzVjZpTnNEWmh5WGdLaEhuZnJKTVNx?=
 =?utf-8?B?d0l2dWJiQmFDR1FxU2JEditpcU40YkRodHA1MHIxdUVJb0dFMmNtdmtENisz?=
 =?utf-8?B?ZDFiRnFmSXFzeExFYVUyZkN1Qnc2dUZna3E1MnJjSnUrQmZWK2E4d0I1QWdr?=
 =?utf-8?B?OVhEbTR0SHU3UTFBODVIU1pmSVNuZm0weHY0YjJvYkRhQVhqeVk4Szhva2JN?=
 =?utf-8?B?NjV6cDJxYnFTb2FMS0hJU3dFS3NUWFRsaWwxNVNVNTdjUE9UMFdQOFkvK1lm?=
 =?utf-8?B?bWUvUVBhLzBSTDBCd3drK2JydUdUQmdjUzR3bW8yY2hRalUvakJZbWdOUHAx?=
 =?utf-8?B?NEdmRm90WGpjVzlDdXhBM1R4ei9GN2Q3d1JmQU44V3pWMVkvNmY4Y2dXa2FP?=
 =?utf-8?Q?X30YcgPWoD7jsXYz0KkyvVPX0yXDtzT4Un6d4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:QB1PR01MB2353.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnRuT0FqZEJUeUZ2VnlESEJlK2EvamsvbFZoTTNPQ3duY3BBdEpKQkVkWDV3?=
 =?utf-8?B?NjF3ZDh3NnQvTEl4cUFpNXlEYXpvSU9PRmJnRHlQc3g0S0hGZ3pMV2JvalRX?=
 =?utf-8?B?QXF5YXdpNDY1WGRrZVhVSERuaVhwaXNnNjgybmdhUHRvVzhSNkUrYUx3aE91?=
 =?utf-8?B?YkloMEc2UEM4Qk5tUmMxdDNVdkswSHQ0bDN2Q0tJVURIQWZuRlJGaFRkT0Fo?=
 =?utf-8?B?RmszeVJuU2tvQXQrWndQQS9yQ2ZtMTdGbHNjbERjb3JIZjNZSzdtYjZmRjZB?=
 =?utf-8?B?a0VUMnRoNlBqVU9OZWMxa1ZRNU1iUm5wKy9sWGFxbEZackRScmR1bjNaK2hh?=
 =?utf-8?B?OU9Ja1dFa1ZBQktwbDV5QndiK05mVVk2bU51alNBSVRUcS9wTStYM1U1eXhW?=
 =?utf-8?B?NXFzQjdQUjZjL3dNZVF0WHNsd2FPeXFoZnl5Z1pnNzFmcXJ4T0Uxdk1EaHcw?=
 =?utf-8?B?WjBvckZmMEdkQ1VwU2lnbnpIWXk2OGM0QnhIRHdnTzExZE9kMGFGUVozTUg5?=
 =?utf-8?B?dEdub2RYemNIM0VkZzh1NnBKcXlycmFEbjBGSVEyM3JGakhqRmlrWTRqSy9B?=
 =?utf-8?B?RTZuR1VaOTRVMlRuT3JwZ1NEK0Jzdkhua0JYZS9PcTF3ZEwwWTVPdkNFdlQ0?=
 =?utf-8?B?ZlZUdXBTcWx1dmJqNVhiTTR2aytra0RocHkzMEV5RkFSM0lnemxZQ0tvWEpV?=
 =?utf-8?B?bzlvWE1XT0RHVGlZVE1sWWp3VHpNeXlYYnpMaFVPV3JXR2JieHVsdDlJbXJH?=
 =?utf-8?B?cVRVRUVBK0llbUdUQjR0VjRHWGQwVC93ZEpSU1RnTklpS1I2VE1pQTR2ZVBC?=
 =?utf-8?B?TmllZ1Q1YWVRTjh5eGc3a29sL21xNUhEMmthbU9KZDVzVkNIQ1kydG43cHZj?=
 =?utf-8?B?VUFqZzNNTUpZNnhFU3Bya1d3RVV2UGhuTWtsUDRZZXFCcldsWEt2RUNObVFK?=
 =?utf-8?B?VTRDSFdacU82UC9jWjFnZGVGYnFmS01tQWE3ZjFBZC8xS2krMUdDcE9OYjRm?=
 =?utf-8?B?VFJVYUhSUnJJcUVaNmFXWDFJSDlIdENDb2ltSFFMZFN4M05QT2syRExoS2VE?=
 =?utf-8?B?dmhyN1NUY1ZxZ040MGQxWkxwRGxQT2RtcVZvQkFyRHpVVTFZRXNOS1kvd3FW?=
 =?utf-8?B?cEpvaUxOUlpSYk1WbzFQZ1FuRWRUelZaemV1SWFSSGdVNlYzMlZpSEdid1Y5?=
 =?utf-8?B?S0tzSEU4RUhrU0tiYmdndkNvTUpWV25KUGRqc1orTk9wT1kxYllrL3MvWk9N?=
 =?utf-8?B?eGx5N3Qwc2FoL2NrTWEwNEFjWDBmQit0YStpQlprMTIwQy90UzNMQTN0L3l4?=
 =?utf-8?B?VExkUDMzNXhyaFNyVWNjODVtTnBXZU40cEdyRFA0aTRobW8vSkxvRDJlWm1i?=
 =?utf-8?B?MnZ0NTFNbEwxdk5MdXNuemtnNXpWYUIyQWcxbWduUDViOFB1RjErVFJrelh2?=
 =?utf-8?B?VjM5Z2VocldTZVBBMjRwU01VQ3FYZlJEeWE0ZDdaR1JudVFWWXJMMXR3SE1j?=
 =?utf-8?B?SXR3dzY5TUpyMVlPWUNleDN1Z3NnUkNlTWZoRTBWS1BHQlduVmliL2h4Z01W?=
 =?utf-8?B?TXBZalJSc3Iyb0o5ckRoQ01YYzlEQmh4bjhWSzkvVFVHdUxtS29KWTVBYWd4?=
 =?utf-8?B?OVUyNkFZOUMwVzBtc0FzdWJXZDhXbnorV1VFR2h1dkRxaGluTzh2VDhzVzdI?=
 =?utf-8?B?R096ZXBNUDdrcDRvR0xsVTd4OVNqb0REZ0NyZnVPMDdKNlJDc1BIU0ludElh?=
 =?utf-8?B?YkVnVGZraUxkbDl2cU0ydUorVlVPQ0FBM0xvWTVGQ1BYWisyUysxVVFiMHZE?=
 =?utf-8?B?MjJRWG1Ob3owRHdjb0N0RkdkRytNc1V6NHd3VnhqZHFyNnVjMDZVREZQMzRZ?=
 =?utf-8?B?WFpwam8yeVJLSkRZMXgyeEVYdGlka0JPNFVCaHNISzZ4S0R1SDZPbElKT2NR?=
 =?utf-8?B?ejdpSldhOTlMSmFMakhRbVZqd0Raajk1R2NRVWFPcDNsUmozVWxOZmZUSUxI?=
 =?utf-8?B?V2xGOEhUMTc4dm9uYXMrTHcxMkc4azJKeWhpdDdMY1dUaW1sMHkybmtvMy81?=
 =?utf-8?B?NzRka3l3SFFOSUgwdExzMjZnM01rQzJRN3gwUXhBMHV3UkJST2lTeFlUVzlL?=
 =?utf-8?Q?EeDing6H4gQVVPO78KfcNTS4c?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d225c2-efbf-4795-3271-08ddb3ffef88
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB2353.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 15:49:58.4590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oX4L9KPibVNBrqxZJJrS9mSOWVSx4UoSVMqJNeGEriBtzEdg7edavOD6SNX8DWaEWvd2C6t2c2fWFa1+ftQDBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6099
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

Hi Georg,

On 6/25/25 9:36 AM, Georg Muck wrote:
> Hi Kienan,
> 
> I did exactly that, without success.
> 
> The log of the lttng-sessiond (lttng.log) did not change after starting the
> ROS2 instances. I have also added the output of "lttng list
> structuralSession"
> I start my tracing instance as follows:
> 
> At first there is a bash-script that sets everything up, it does the
> following:
> 
> lttng destroy -a # to destroy all existing sessions
> lttng-sessiond --daemonize --verbose-consumer -vvv &> "/tmp/lttng.log" #

When started with '--daemonize', the file descriptors are closed[1] 
after forking which is why you don't see any further output to 
/tmp/lttng.log. Try with '--background' instead.

> starting a new session Deamon
> ./exemplary_tracing_session # starting my exemplary tracing session
> 
> The exemplary tracing session is written by the help of the c Api
> (appendix).
> 

I modified your script to add 'tp:tptest' (a tracepoint from the 
lttng-tools test suite program gen-ust-events) and did the following:

```
$ lttng-sessiond --background --verbose-consumer -vvv &> sessiond.log
$ ./exemplary_tracing_session &
$ lttng-tools/./tests/utils/testapp/gen-ust-events/gen-ust-events
babeltrace2 /tmp/structural_traces | wc -l
100
```

It seems to be working fine for me. A couple of notes:

1. Before any traced application is run, babeltrace2 has the following 
error output: No trace was found based on input `/tmp/structural_traces`
2. After a traced application is run whether is produces enabled events 
or not, I see the events recorded.
3. When your session script stops, the output folder is deleted.

> I started the the same procedure on another machine. The same fault

The fault is that the babeltrace2 has an error, right? Are you willing 
to share your trace that has the problem and/or show the output of 
babeltrace2's error?

> occurred. I think I need to configure more within the `lttngDomain`. But I
> don't know how, would you have an idea/hint?
> 
> Thanks for your help.
> 
> Best regards,
> Georg
> 
> Ps.: I also added the log of my tracing tool (structural.log)
> 
> Never burn the bridges before you
> If you've burned the bridges behind
> Never burn the one that you're walking upon
> Or you're sure to hit the water in time. *(Savatage, Streets, 1991)*
> 
> 
> Am Mo., 23. Juni 2025 um 16:26 Uhr schrieb Kienan Stewart <
> kstewart@efficios.com>:
> 
>> Hi Georg,
>>
>> a good first step is to run lttng-session with `-vvv --verbose-consumer`
>> and inspect the log file and `LTTNG_UST_DEBUG=1` in the environment.
>>
>> It may also be useful to run your traced applications with
>> `LTTNG_UST_DEBUG=1` set in the environment.
>>
>> Do you have steps that reproduce the issue? E.g., all the commands to
>> set up the tracing session and so forth.
>>
>> thanks,
>> kienan
>>
>> On 6/19/25 10:58 AM, Georg Muck via lttng-dev wrote:
>>> Hey,
>>>
>>> I am using the LTTng tracer (2.13.11, C-API, rotation=1s) to trace my
>> ROS2
>>> system (userspace only). Everything works just fine within my Docker
>>> Container (Ubuntu 24.04), but if I start the same procedure on the host
>>> itself (also Ubuntu 24.04), it does not create a TraceFile if to many
>>> tracepoints occur (speaking of roundabout 1500+ per second) (sometimes it
>>> malformed the tracefile, but I was not able to recreate that. If I
>> remember
>>> correctly, Babeltrace2 threw an error that said that there was no
>>> metadata-file). I played around with some configurations (like increasing
>>> the buffer size from ~16kB to ~512kB or a less aggressive rotation), but
>>> the problem stayed.
>>>
>>> Would be thankful for help. I guess I delivered to less information,
>> please
>>> reach out what is interesting at this point, I am not sure about that :).
>>>
>>> Best regards,
>>> Georg
>>>
>>>
>>>
>>> Never burn the bridges before you
>>> If you've burned the bridges behind
>>> Never burn the one that you're walking upon
>>> Or you're sure to hit the water in time. *(Savatage, Streets, 1991)*
>>>
>>
>>
> 

thanks,
kienan

[1]: https://lttng.org/man/8/lttng-sessiond/v2.13/#doc-opt--daemonize
