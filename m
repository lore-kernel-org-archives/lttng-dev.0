Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CEFC77B7C
	for <lttng-dev@archiver.kernel.org>; Wed, 25 Jun 2025 21:15:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bSF3P62chz1Vq3
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1750886145;
	b=k09CeDIx0+TwE0eeDM6ku5glyh4BTB1J9Gvs8XLmQfwPWTnj+UYnz4qwb60EoLzkzXUN
	 Gd/44WEtkqgSx0ByDFNgivfbJxl4AKAPdVvdx1QRHPoGLnhDECnnQfTqspITyDApDnyJk
	 Eh/G4vjwmf78jiW5aOyTkJCV3Orr9PZPB8mutXBLwiPTNwFh2qADyG0HvgsG/dofY+ttG
	 VM3bSrsOcLNkNVssHUCrnwvT92LcaOIIfvWxAkPt/3jgsZayoPhPuFYuP/EJ67pyJ/HmZ
	 UEZOVlrwaEnHp+FL0XbYmVLuJlHMI3iZClLYxEMUoLoPl7Hw5/RN/uYNklslqr5Y7BQ==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1750886145;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=XKrNmMC5X9l+8hQVCPWzwP56FqoLx9dOpadHb+NJ0Po=;
	b=XZNHSv/x0piEY4uVfAbDVUR516yT519vGYM4UVxYNvpjH38y7xkTfwuPBEU6mDJQpM+6
	 bLNiL2qSzWkoJ6yURZNNiQlDMMCW0xCxx79vmnlPvPO2MYXGgtBmppK24Ba1PA88PuM/i
	 9stZVPaEHLP8uekoTGgkUZm2FonxWEiD/Dfl7+NjL20tEsoTCmiQYcrijCAkH3Id5tXnh
	 Iwr4SQsB3Ir3IZFQi76w3yPyNv6bdun5eAYrouWXAhjx+RoaMEurlMb+vy9OKSHyqaj9u
	 VHWqu2SZ3xojFOCc1YWCKz9N9fQUlAnPgjUgX5njpudN69DqUEFXx+20X6lHbJxApKw==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bSF3P62chz1Vq3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1750886145;
	bh=XKrNmMC5X9l+8hQVCPWzwP56FqoLx9dOpadHb+NJ0Po=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ZcsQ2Bv1/5fv4Sitpl5alWq1NgP78AYvND7ti52h7aLNwtmldq7FDqDNrB9LwZDX3
	 kdns2SA8Kso2MfzkHRNOL3dZ/c0DcogdlCBngXIw0y7TQEJxRwajFlWRgKmiXr7hRt
	 CdsZETOVAGEGuu7c8usoDjHMIqvzN7aklairk1x8FPA5d0FNwvQOgNeobW0nq/6Pxt
	 fylPLSdIAmmIbD0voIXe2NWFEryTnYjizBD6ci8iJ6Ycyxz9JmhUCgyKnivI4Rlh/z
	 pv+eL9igMp9Nfy3yhXnoT6nlgvFtHw1wjReTQgcUyZLJ1WKkOKWIIBr/RoTvki6jND
	 6U1QwPDFKWVWQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bSF3P62chz1Vq3;
	Wed, 25 Jun 2025 17:15:45 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bSF3N5GRRz1Vk9
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bSF3N5GRRz1Vk9
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazon11020083.outbound.protection.outlook.com [52.101.191.83])
 by lists.lttng.org (Postfix) with ESMTPS id 4bSF3N5GRRz1Vk9
 for <lttng-dev@lists.lttng.org>; Wed, 25 Jun 2025 17:15:44 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqM3DKoA7z+vFaSh7TiB4f/8IQPLroh5CGggChbvYGI9uP1BMyivvCu1uIRdFZpytc/Rdp26AjCieLnhYI4Q956vKu7hdC1jSJo0jLmdO5m01EJI12crcSm9iL6QThP/yA+iRyNwABMRyK3dvyMfhis74l94qUxwfIbqI1Jsnj11u78QGNGd2mz/N5y5MI1UvKEeQqzaDQK8v+PNwnkJ+O58Dc1fuikBxQZ0ZQ6g7PXq1KYKk3lCQsPaIZHtSmAwIrvdhUHtlpLMkFNN+SNTwMtrCPb8/dRRIZ0+w4LZeIy74tYAsFeEGcgHSP558GuMaNoSPVxXU8eedEffKFka+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czZ2+4NLJVjy3Lobq7hd4cWF42oUp9LB+u0d2ePoGVI=;
 b=C8/HYL8ucE9hjFvU06yDAIG6wJdera/GqMvpU7j/BZC2BqY7FnrMGUvFq47SWT46r+k/twFYzDQQgnRSnwbBsnkg6oDtMYgQpGraj8sFPxbKF7+8S4J5Yp223gllB8eHdUGiuGq06VsZO/iwyzddgG6ywuBy7pgMUJDXl/eHrT8dZ25g17Rd5ozF9doGupzZe0HIoKDd+ZzeDs/BbeLv3oGRBK2gDjhRl4WdAHAkhMbry9DlvNE+Lxo42M6jsa42PiDtcWZF/aLqiZmrIo4+ldWdIzwW6EhAA0GS0Mz27N4ABYdZapfhQYCbTSLXnbusReQoz0/qemK6blqxAD3gSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from QB1PR01MB2353.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:35::26)
 by YQBPR0101MB9117.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:5c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Wed, 25 Jun
 2025 21:15:40 +0000
Received: from QB1PR01MB2353.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::2e56:55d7:d22d:5de2]) by QB1PR01MB2353.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::2e56:55d7:d22d:5de2%3]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 21:15:40 +0000
Message-ID: <0e5563b2-b0a8-4669-ace1-19740c56da38@efficios.com>
Date: Wed, 25 Jun 2025 17:15:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Method to get LTTNG-UST version during runtime?
To: Norbert Lange <nolange79@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
References: <CADYdroMBu0gocZXpeaMWqr3TG4p5FW71eeN1+y-XM_8bDxijzw@mail.gmail.com>
 <df98623f-172e-4e71-9592-cb864e239000@efficios.com>
 <CADYdroMtZ8qYToUF+GF8ZbgAzjHu5yMv9+dtk8Hjki_FMx=PWA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CADYdroMtZ8qYToUF+GF8ZbgAzjHu5yMv9+dtk8Hjki_FMx=PWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::21) To QB1PR01MB2353.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:35::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: QB1PR01MB2353:EE_|YQBPR0101MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: 753fe519-b08d-47a2-40f3-08ddb42d6f49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFZEaE9ZcHFUWGlTNTdGdTVzTDFLRmpXQU9IRXFTcUVyNFdMQVV4aldEYnBo?=
 =?utf-8?B?am9iRThTRG9ZSU9hWDBPa1BlOEdKLy9Gc1NCT3pmUGpwRHl6QlI2dmJYdTM5?=
 =?utf-8?B?ZUNvT2xvR25rUXZpLzBmeFZzSUdndFVNYzN6ampUb0s3dnZVcFREZkJZRE9U?=
 =?utf-8?B?eGZXMStid0hHakRGbm81NFNjNnJEK05PcXJHRURRNEtXMjJURVloQWtpNnJC?=
 =?utf-8?B?NFAvWXNsYkhzUkhIb01TZjhyTEZPcTRJVmRVb3pBbVJjMm5MKzdqWkE5MzZL?=
 =?utf-8?B?Qzk1SmZ1Ymdsd24wMURmTUhNOHduVWd4blNPRGtEMFNZMlBUdVlydzZXam9y?=
 =?utf-8?B?OWpTeFYxaU1VTW0rRTJVTVMzOVREUXR5YkdEQVRvaE93cWpzTWZpbklFMGll?=
 =?utf-8?B?bGQwZTZHZ0VHMElBeDBEUStJZUhlMmxsWUFkUEZEQXJWQmp3a1oya2ZiWXFz?=
 =?utf-8?B?N2gxVjYvU0xzSVN5Nk03Q2pMUDBjMjU0RjlyUk9LUHFGVWo1TTZJOEpUb25Y?=
 =?utf-8?B?SUpLNldNbzJkYXU0L1g4M0t1bGpKNnBVRlVCOHRheExMakNvZk9CMTZoTklq?=
 =?utf-8?B?NVBHZ3NUU29Pd2JDT0pERC9JVWl1cHh1bktqR3VPenRKUncxVmtUNktsaTJC?=
 =?utf-8?B?VCtBTnFxazR3aFRHeDgweEgzVGdCd1ptM3l4WWJ2R0Y1VnBySEVjdm00bXM5?=
 =?utf-8?B?aHQvUEdFeTNzVjZhSmVXMlRVUktpRERWWTZUTi9tU2I0TEtRT200dzgyZlFD?=
 =?utf-8?B?NXhoRnpFckt1K0NaWnhCcCtWTmJTVnRqTlBzMEhWRlZVaWhZUVRWZU9DRUZJ?=
 =?utf-8?B?ZmIxMUx5QVpqT3F1WHZEb1lsajRMVXZFMnRnWjFZSWk1dUp3cEIwRm95eGdH?=
 =?utf-8?B?SVkwMlNYRzVNMnAxaUJxZHBHN2VFN1R5QlFVSWNMUXNJckpWaHJXYWN3OGE3?=
 =?utf-8?B?Uklha3lTS3c5VWFiekQ2Q0dkb29rd0NrUWYvT0JSZHNJNXlRRDRzcHlGN3pM?=
 =?utf-8?B?eG50V01TTnlJMVZHQk1TTGhsQlcwejcxeHA1WTFoOEE0ZjRBN2dubzhoazdk?=
 =?utf-8?B?ZFRVd3pFblBHWWZHZTRGQk9JUnV3a21IbUpNMG1jbW9CZmNVTm4xMCtsajZO?=
 =?utf-8?B?MG5TNGtndVQxdVV0Y3hkNzdCRmFhRmhNVERReXpTN0RYNm1MQk10WHZRSnVY?=
 =?utf-8?B?K0xTaStyeThFR3A3d004ekVDR2FkdjQyYkpJcmQzMU1EVzRLeG8vcFMxSnRv?=
 =?utf-8?B?NU5pSHpjTUFsUFU1ODdnaTAxYVN5WGF5dDBIMDY4ejl0c3NGcE40Qk5FRHpq?=
 =?utf-8?B?ZzBXcEZzSUM3YzFVRjc4cE55ZThleW90Z0J4bEdsMkR1VDZyVkhiR1Nha0gy?=
 =?utf-8?B?UUFiSkRoQU5wRlBYNjVLWC84MXo2UEluOGNjc3RtdWRMdE14aTZmU25SdkRS?=
 =?utf-8?B?b0h1SmZKaWp5N3BHVW1OcjgvM0NvUFI4Z1ZkSTJUVjM2ejVQclFScUdVS2FL?=
 =?utf-8?B?RVFUZHRsSVYrQlhGbEdrcUVwbHROMGhuNEVYa3N6cHJPampkdk5QUC9TVTR4?=
 =?utf-8?B?TFpEaVZqZzhmeGFveXVVdXBSVnNPN0VxOHFnNmtNL000bUNXSElEL240bHpx?=
 =?utf-8?B?ZHUyQ1hGTEJWeElycm40SHVzMG1ERTFMQzlHRFYzZGpFZERmWVpPU2IxZk0x?=
 =?utf-8?B?dXNVVURBeTQxc0NCZWZDSVFmMFppUXg0blExdHRubnppWlJ5NGsvSGtIM1hC?=
 =?utf-8?B?ZmtHV3NFZHBidkY3QTJPS1J1d2tYM2JaLzFmLzZGTHhWTUJBeWh2K1Jyd0dZ?=
 =?utf-8?Q?tbomu/Zg2zS9ZXT1uzMZzTQi/F0RoNIP93mBA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:QB1PR01MB2353.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3JHeXgrWWFRQ25xRGNISUZFTTRYUFZ5QVpLRVQ2bDk0d1oxVy9hK0U1Z0hP?=
 =?utf-8?B?VWZDa1BmTCt2d3hUY2g4MUpkMzBLY3FKMjRCb3JZUXBNQlAxMlV0QkFmMEc0?=
 =?utf-8?B?WDBFNzBCZHB6OWxQREcvd0M4L25CTTZmdmVUNTluTGpneW5ESGxxZS9vYStE?=
 =?utf-8?B?b09PRElWTEpuMDFUd0FYWHkyNGFMNmRidGVRTXJvTVRKMVhLRUdKZ2UvNytL?=
 =?utf-8?B?eDJrNEVtNW1rKzIwVXRWbG5ubkpwcVF0Q0crUXVTcGluT1pkSFdhR2FpT2ll?=
 =?utf-8?B?VjR6b2tIS2w0RUZ3ZWxSTkorUGJ4YUJRcUYwa3JGd21GWms3bXo2QytZTWg2?=
 =?utf-8?B?enpNR2NQUm00RXI5NFlTOGI4R3J2MlRFeERoS2JNcTBweDFWaHJCUTZSUjFR?=
 =?utf-8?B?NGt3eHZSNXNOeE4wbVZqdmVQNjd1RFZpTEJUWS8vYUp4NnFPK2NjT1ZjWmVw?=
 =?utf-8?B?UWVUYzhUSWNuNmlTNVpZeDlwNGxuOFpkYURsWTYydFN3ZXVYRksyMGtmcW92?=
 =?utf-8?B?WkVNb0lySnpEaU9CTUFyd0tsT0VSeXFCNjJvQ2F6V0JBL0VscGZoSU9peWRz?=
 =?utf-8?B?SU4wYXhVN2kzR2wveFRkVWExQnFKNmJYNGhkRFhvMEZ5c0FDVVExb3dLUjJy?=
 =?utf-8?B?cTlrcld5MVQrUURIbmh2MGpQbVc0NWNad1JHUzhmUHZpUUhFVVRGTlVtM3lU?=
 =?utf-8?B?YlIrdjd0QXVsSERDRUQyMHZLa0p4LzdIWVlJT1JzY2pOTkhxZWxnNU12V01r?=
 =?utf-8?B?amdFS09QdkNzNHJpWHU2ODJWbGFLRzhQNldHMVh0UEJwQkV6Tld4WHM5c1Aw?=
 =?utf-8?B?U2NreUxKVFI2emlQSVJqSllBWnJ1OHRCZXpXMW05UzAxSjN2cE54SzEvT2dP?=
 =?utf-8?B?TGRZbHNRUGYzZnY0N3RWZmhtc1JsUmJrMFlSWlMyako1djUyWkFsaDN2RWN3?=
 =?utf-8?B?TlFQMkFtbm5VUXp5SnhIbVdQZUNtRXhLdzR2QnJHeXdwVDEwSUpudElybXcw?=
 =?utf-8?B?TEJ4YUNXQlFMU3NjalRZVENMVmNsbUpsdnVPaG1Na0tWeXBCWlBENUozTlA0?=
 =?utf-8?B?R004WHVJMWhrUGh2bncwQWhhQSt0TnNaYWZtbE11THpackM0ek9kcnlZQkM0?=
 =?utf-8?B?NGVMN0Q1UDM1aGRQeUxPejFWT3BNNW91MDlqK2N1WG5iM1F3SmdrZ2Q1Ly9y?=
 =?utf-8?B?QzF4SkZHZ2VFQUlnd0p2aFlEYWxCNGVFbGcvdTArWjJEaytxYjFWQVRremFE?=
 =?utf-8?B?bkUxNlBLbE5CUjZ1L01TWlltbFRrNGQwL1pLQ09MTUo5aGJwbGxyWXUxd3ZO?=
 =?utf-8?B?VWpkcTlWTHE5Y21QT0JGS202aWZSR3ExME1MVUlnT0hOWFJ5TUZzd3hTQUVo?=
 =?utf-8?B?a2o2c2w1U1k0aHpPOFMvMGZyd0xOc0l6cG1DaWhRb1RHOFc1VlgrcHEvdGlJ?=
 =?utf-8?B?c0lySHJ5OUhwSHVtNGsyMlJBNDdCU2xBWXZzeVh5dFdDMVhBNTVBazgzWUlG?=
 =?utf-8?B?cHd2TUhUeHdVdUpCOU1VbjRzQTRjMnQyQTdyMVZwMDNmZ3BHbmZQWFMzWHZT?=
 =?utf-8?B?eWVjT3laUWp2S01ZU3NlNjI2RmxoMnMrbGJqWHNHcUlDS0ZwOXAvM0Rsb29E?=
 =?utf-8?B?aE1nZWZwWElOWER0YmlHcVZPcGxZL3VLU09rbVhpaHZJQzdXWUYzN3ZMeStm?=
 =?utf-8?B?emFWUS9hTmVFRDhad3Yrb2ZLNTVINFFYZVZiT3dqdU5TV1kvcDVDS2VwN1oz?=
 =?utf-8?B?VU5iK0ZqVFg5emIzTFRleUdPMVRKYTZUSld5aDBpL01VRERVZFV4QlJTU0ZE?=
 =?utf-8?B?OGVXK3ByNm1EdWxScUhaSjQ4aVJsdWExTGw4MDlBQm9UeWdXRExQS3NyKzBK?=
 =?utf-8?B?WnN2S0lFUUpLNWRCUjdzVFJKbE1INnBYeUtXcTdydy9PVmZJMHZudFhwbEdn?=
 =?utf-8?B?bXRiTnMyNi9iczcrTmptVGlxWnZjRDUvTXV0d2VBSFdETS9Jb3V0VGVXbkxB?=
 =?utf-8?B?dzBXSkpLU3FNL0xHb2hQTE9FTGdBbXNTR3VjUEhwU2hrU2pLVnFSYU56WGxm?=
 =?utf-8?B?T1d0SllBb2cxUm1PVEFzNnM0cEsyS2VTNUtFU0l6cjI2ckMwM3QyaXo1TmRu?=
 =?utf-8?Q?A/Yw/HzBCMgGDQsg+FDbToyKk?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 753fe519-b08d-47a2-40f3-08ddb42d6f49
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB2353.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:15:39.9530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HA0WgdUxsmga/auoGB9Wngv1DOSP8CWpz3bR0UgPBRoMINAAe3DZ6AlAN4HiDg37bbgvewHuWQxONKQvDDIOMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9117
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

On 6/23/25 3:04 PM, Norbert Lange wrote:
> I dont want to use anything else, I just want  to add instrumentation
> for dynamically loaded tracepoints that does next to nothing if not
> activated (see [1]).
> liblttng-ust-ctl is not even ABI compatible between 2.13 and 2.14
> (different soname), so that's pretty useless since it already binds to
> either 2.13 or 2.14 at compile-time.

I hadn't considered that the soname for liblttng-ust-ctl had changed 
between versions. Thanks for pointing that out.

> 
> [1] - https://lists.lttng.org/pipermail/lttng-dev/2021-May/030004.html
> 
> Norbert
>

Then, it sounds to me like there's not a way to do the check you're 
asking for with the public API at this time.

If there's a way you would like to address it that matches your needs, 
you're welcome to propose a patch to introduce it.

thanks,
kienan

> Am Mo., 23. Juni 2025 um 16:21 Uhr schrieb Kienan Stewart
> <kstewart@efficios.com>:
>>
>> Hi Norbert,
>>
>> If you link to liblttng-ust-ctl, you can use `lttng_ust_ctl_get_version`.
>>
>> thanks,
>> kienan
>>
>>
>> On 6/18/25 11:22 AM, Norbert Lange via lttng-dev wrote:
>>> Hi,
>>>
>>> there are some substantial changes in 2.14.0 that afffect how/if
>>> tracing is possible.
>>> For ex. c246521ddcba1d1d28cfa0482aa500b9122e7264 allows doing more work upfront
>>> by calling lttng_ust_init_thread().
>>> With 2.13.x the same code will instead do various syscalls or
>>> allocations during the first tracepoints, violating realtime
>>> constraints and possible abort the process.
>>>
>>> I miss an easy method to inspect the Lttng UST Version for checks or
>>> workarounds.
>>>
>>> There is the lttng_ust_loaded variable that could be abused to carry
>>> an packed version instead of 1. (Of course that could always cause
>>> fallout)
>>>
>>> Regards, Norbert
>>

