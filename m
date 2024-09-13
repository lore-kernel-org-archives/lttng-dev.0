Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F92FA3736
	for <lttng-dev@archiver.kernel.org>; Fri, 13 Sep 2024 09:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1726221070;
	bh=LRogC3fo05S8R1/6iS+EnN/LVvNGiOyKvJrrQrma7gc=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=IBw5cF+bRxciBDohRB5YTrQ4zEP/XNH7J2O/7CjBWzfb1yR7KLRPFNAWTPVY41eRv
	 nLv1tPdUxIfr9QJ9Ko2Q2SHlQdETqHNX/qo00DX2gQqzQYBv3GcuNyhzqa6VMBA9e8
	 mvrU1P9H6t61e+qRsTvWkrCAqQgc5rcR2xQb1nAISWAaSBaMFm2NYaQaFEh1AmJwa2
	 nVcgJKGzxX8t7dRTOfG+knm1Vb4aZWyMuSC0X96t3LwcuZgWcXS13dC6PdC9UDM/kw
	 7gTxY9YFlx3OMOEDPyuYxuCAuUxuQ/Gkfm6/MmPqFfFg5/As5lkhUFd6IBIfRZg07m
	 hIyq3WcsIknQw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4X4qM21b2sz1Grp;
	Fri, 13 Sep 2024 05:51:10 -0400 (EDT)
Received: from YT5PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazlp170110005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::5])
 by lists.lttng.org (Postfix) with ESMTPS id 4X4qM0002jz1Grn
 for <lttng-dev@lists.lttng.org>; Fri, 13 Sep 2024 05:51:07 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vn4dMtacmU86X8CNdCE/7WCsk9xhXugq+dfysjLK9yCQtjLrthzzg6F9yvC8u6LPA5S3VQm+HXUUy2ytrho5mA8/ymmbkrJA7KJwmIyQn2GAGdYwgUzPB2OBpg3fyB3UPzUmsXVvZsbn3XmDF+QgH7p1cMKDtM0He5aqfQiwYdXmEW6Y6B0syREaep1tHUwOCVVxUZsbqRZgQpt/RhjzaeJZgU6p2q+5p2RNA4s0C7I4uopjpb5CKhF+18PPo9DCa9L3enOZQ0EQKEmi/lViiYegO1p1q2h9Id15RTNLLfm8qHtUCZxRXEna4+2EZzSjcSrjcuENaBW407l6cKfLow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpVVJdHTdHsKSzuKd29e/HKxGdVDlMq2H6cVEsptYjI=;
 b=UB8qBUObKK74Rssz9FGdFxS7D4ZuMSVHKD/qr0hRrONir5KnSt0qOrmzDA9akaX0FkRaJrFTK0iZh0jAXseA6y+p/lJ77LQy9hk1ybcWalZg9wl58ce7F6I3+uOokcU10z9HWkCQ5wz4Mj1BnzluuLTDcprIfVzNUP8ZH2zN09/s9wohA0+RUHBh+9J1ruXODWUVmrh/8s8xwscISPovaLK4ldguZqTcgLI+k9ZXBhAkzobp2ALJ4AUKuO9hAT9soaER9WkvgJ+uja2zQmu0xnLCHyp5wRDdECgqmaEN+m1SEQfCmGZkkMPpmpA/jBL4MWkVA5QYca0a2lHUxDbqPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT4PR01MB10263.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.20; Fri, 13 Sep
 2024 09:51:05 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%5]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 09:51:05 +0000
Message-ID: <bbb0732f-e039-4821-8777-829c9f49f010@efficios.com>
Date: Fri, 13 Sep 2024 05:51:02 -0400
User-Agent: Mozilla Thunderbird
To: Damien Berget <damien.berget@flyzipline.com>
Cc: lttng-dev@lists.lttng.org
References: <CAA1MA5f3JY7WCZbgKaC2gjagDY-eVdssg_iWEiWtop3zZM7WJQ@mail.gmail.com>
 <39b62cc1-66e1-4962-a3a8-0d3ad6e151ef@efficios.com>
 <CAA1MA5eTdaSt_fxuEFK1dbGZXZSFHwLRO22YiXU1hgsCDQKRLA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAA1MA5eTdaSt_fxuEFK1dbGZXZSFHwLRO22YiXU1hgsCDQKRLA@mail.gmail.com>
X-ClientProxiedBy: YQBPR0101CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::33) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT4PR01MB10263:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dc9e622-3b42-4466-fcae-08dcd3d995a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0NNdVUxUG90M1JRdDdtdUUvOHRaWTZyd3JBTzRFSVBtV3M5MTdXdDJEWmgr?=
 =?utf-8?B?dnZpVENjaHpxQ2x3V0o1cjVLSjlPNk1kYVladHJEUEtuT2k5NitrdWtSTW52?=
 =?utf-8?B?S3lqMXVlV2txcFBQeTNEWW50c0VZdEN0b0NBWVJtSFpEMW1FVXhZa28wV2d2?=
 =?utf-8?B?NU8xazNiZWFiRnRuTC91czdabTV1dFpZWC9PaUpJbTlJSFF2TjJqRUVjdDEw?=
 =?utf-8?B?OVB4UzhXSlZRS3VLK3BqQnorVXI1b3crMjE0VWcyZUNoU2xtNitGd3RmRi9t?=
 =?utf-8?B?SGRzQUd3SVJmR3M3UXVZd3d1Nm9uUDFiNU1nMVNsZDlRL0Z5bEdtc2FEd1FE?=
 =?utf-8?B?b3lGd2xjMXZ4V2taQVhVcmtEaEZIdmQ3WTVvV1IxNDdhbWdEQW5LL2tEOTVH?=
 =?utf-8?B?eEhPTnFpbGZyNSt1RW1lVVBscmx6M1ZqeXFYRzlJQXNCYnUvd1NtV1k0d3lz?=
 =?utf-8?B?cXlmcVhNdE01TFlBZE5SUWp3ckFaMHoxbjQ1SmI2QnNLaGtXYXBRejN3RFla?=
 =?utf-8?B?UUJWaFF2aTZHTjJiUld5Wnl2L1FGelBVYnlIZ0diSDNDOUhSMklXQWZQUEFu?=
 =?utf-8?B?OTRKUUVqYjB3QVhCTmltOGRYU1hnYndiY2JibnFjdGEybnRzTy9sV0laR0I3?=
 =?utf-8?B?WCsxdlNYYlV0ZytkaEs3R2crNnhGQWFHR29oemQxZWZqTzVuc0xoeGVzdVMw?=
 =?utf-8?B?bHZGaThzK0o5c2FFRkxYOTlhNFZYTFlWdUk4WS9GQzBNYXhFUkJXTGF5Zi80?=
 =?utf-8?B?Y1V5RE5EVis1UkQ1L2VkcTJKNU51ZkVoU3lQdDR6VU5BV1E3WEwrNk92WTA5?=
 =?utf-8?B?VVRHcFF3NHV5V2p3UkxMWElndjd2ZEVJd1VFNW43QVcrVCsvRHdPYms4WGN2?=
 =?utf-8?B?RnpqRittd2N6eG04SURYSE5QZWk2dzBXVWt2eWdQb1k3OCt4V0RqWTluY1dP?=
 =?utf-8?B?TXNndFhRS3FPSmpuc1NySUpZcGFqc3kyQk5xaDdReVNCTHJ2K0o1MVI2NFgy?=
 =?utf-8?B?NDdFTGpCWlQza00xQ3lsN3Q0MmpIUVZVNll0OHNReWN5L29raW1Wem9jcWFv?=
 =?utf-8?B?TXVWLys3WmIxdHdDek40MzIrVXdqUVhXWEZRWkp1Z0Jvb0JwbmVjbUV6d0d6?=
 =?utf-8?B?aDFBamZ6bDZSN1hrT0N2dGFXSTZBaDFxa0pFN2xrbkVpYVJ6QmUyN05ubUYw?=
 =?utf-8?B?VXFOQlYvVWdyMWRMd25TeDhvUXpPeVdaWEo0b0ZVSUk5YnlaSkVOd0xNZkhS?=
 =?utf-8?B?cGtkY3dtYS9EaGpWanM4QmJTVHZkbS9LVWhKVjFpcUt3dW8ya2ZsR3RiR0NJ?=
 =?utf-8?B?K2hQSUdYdzk5UG9JZThzM1ZFbEoxN0VLa2U2d2MvWmUzNGlnV1RubnVjV1Y4?=
 =?utf-8?B?Z1l4VUtmSG1aRldJTUJPTjNLTFdTRWNISWdya293cFRhZXNkREQwZndCMDNK?=
 =?utf-8?B?TUU4cExPU095THBjZGxXRm9WZE9ZclJlZitjUkNDVVNDYXdtNEJGK1FqT3lu?=
 =?utf-8?B?cWtQUVR4WGdVbFFYVmFMZEJqQ2FQMkJYeTkzOVF1SUZNT2VTWTRTV3l5cnVt?=
 =?utf-8?B?SGE5OVVGYW4rUStVZGxIaGpicW5ER2V0RkMvcW1qMUtKWTZnTFJWM093M3dk?=
 =?utf-8?B?eDFuNG05K3orVTBNWTc4RTIrYWdBMUhaalFndjJ1SXhNQ28rTzRDakN5dWRK?=
 =?utf-8?B?NFlTNEtoemtXSTFhaFptL0lBMDdwRTVBZ3ZsN0ViMFMydzJhMnRxWkNpaThN?=
 =?utf-8?Q?C5s4KvOBiYL56yvEQI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkhPOStuUFg3UFpqSkZ2eVhUdWVjVEJCazdOam9oQlJKZitFeWhOK3hyMVhl?=
 =?utf-8?B?d3ZzZ1l4dEk0MWpYTU8vd3lzdXVHNkM2UzRrcnlmTklvVDgyamlSM3dLZVpj?=
 =?utf-8?B?V2doTGo2SEM4c1QwTGpBdXJHUnVLcU5MRVU2TUVXOWlVRXo4RnlVVFh0K2NM?=
 =?utf-8?B?alhzeUtNY3prWEJrMFQ3VlV0MUpjU1d5NlNMK0FCMkJQRFN0dUZ2eGJ5WEpk?=
 =?utf-8?B?ZDBsVkk3Z3VDajVOKzA5ejB6ZEJqRzZPdmFXb05DeTVIS3p6OExuWm9zbjg2?=
 =?utf-8?B?K1FBWDVxUmRLczNEWFc3bWJhR0VKSXViYzFGYVVkQzk2Q3VoYWl5S01nL3J3?=
 =?utf-8?B?d0xCei80d1IwbG5RSVlBVTNWMUw1cmFrRnQ3blJMZ1pYUDV2aTFmZEpXalFt?=
 =?utf-8?B?Ny8xVm1wTTlOVGg3VUU2cHRFNTdoa0FwdjJYaDZyRGtueWh3QUVUT3Q3eU1U?=
 =?utf-8?B?ZWdMdGNPa3VRODhSRmtSZWtaUWtyejl1cVM2WENQbGxKMUxBcFZkT3NRbDNR?=
 =?utf-8?B?eHhnT0RlWEtMeVV3bklnWS9Ucmt1eEhGemkxTmh3cTZDQjhTRjFYNmZMYXZo?=
 =?utf-8?B?cXlEZStUdzZGbW5ydzRkdnBPTHlYVC9jZ3V4L2NKb0k3ajFtZEFWYWdEVUpj?=
 =?utf-8?B?Z2JQWml6dGl6UDRLZ1cwNHAyNmlaNFE1QWpJVzQwbDBvS0M0RDVYTUJvYnVh?=
 =?utf-8?B?UXFFT2l2NlE2Zk10ZmJvUWJTODQvSUphdjNVTVVjRWw0dDZjeVJBeHdWVHFK?=
 =?utf-8?B?L0lnTUZFdU55d1dWelRSZ2h4TGI1QWNmR0tIUys3NGtmSU5RUW9pbjBDc21M?=
 =?utf-8?B?QUE2eVErcE55SysyN3pZUFhnakhuQWlEM2w5WHF2OXdGbW5vTTBjQXVKSTls?=
 =?utf-8?B?clBidDdBdW1zNWF6eC9WRGE4WTZaVktjdnMreUdObFBQTjJsWTZrNlZncURj?=
 =?utf-8?B?MjJ3MmNTK2dCMEpBbG9ESzNEMk1MaDZuNTBkMlJpWU1UL2NrNFVXOGprTmlR?=
 =?utf-8?B?emdvNVdSdHhGelJJR3NoM2NBM0N6QTM1T05oR0JUUTFMbVJqMjdEN21vdklL?=
 =?utf-8?B?aHNOQ0xrS2pTc1hBK1JGb2ozWG5HV3l6blJjRTlyZ21tR2NleFNXdHpPbnBS?=
 =?utf-8?B?eTIzOGY4Mnp5SDJub0t5TlErTEFhSDl4WFVuZVc3K3o1WW9zSVh6QzlJOGFq?=
 =?utf-8?B?NTZnbGt0TXdkS2dWZmQ3WXorNGZka1J6RmZvZjh4UHNFVGpsYmNnTVBCSWdW?=
 =?utf-8?B?ZThRVkIwTXgyT3Bzd1BGSWpwTWlIZCtKS1V4UGNvVkNaYUxDZE01NGxDaStr?=
 =?utf-8?B?K0RFV3BSejUzMUtiSGpNOHdycFR3MFFpdnJwWVZCWEE5MytHczJETDZzUmUv?=
 =?utf-8?B?M2xvckZRRlJWWWFQUHBYRFNyazdEVVF5L2NQQ01yWEJhL25KOWJkUVNETXNU?=
 =?utf-8?B?TDh0OGp2NWlzZTdhQ3BPMVVrYXl6aDdSNU16aEtZL2JST1dBampGMnFKcFJH?=
 =?utf-8?B?T1pmUzV2cHZMU3BuUHQwaE81czhqNUJ1WVRzc3lvc3ZFaTdzcWUyMDhtWUY5?=
 =?utf-8?B?K09ZOFg0K0hrTVgzTmF3c2R5c0lnRFZkSm5OK2YxU2gxdWhKY0owNDVIYWIr?=
 =?utf-8?B?WGFKTkRkUXF1Smt0SWFnRFNlRVVaYU9oT2gxRS9UbitlZmRSODkxbVE0ZEc4?=
 =?utf-8?B?dFdabzN5NUdkd0Z2WHNBR1IrRXBSbGswMnlzbVIvQkticXBNaGQ0SkdkNlRP?=
 =?utf-8?B?ZXRqZmJyWjRqV0E1b0VMNEtBWlRoZHlHMlVtajRXWGxzTGh5ZHpyMnJraDk5?=
 =?utf-8?B?ZnozeGlLOVEvdE5uM1RtRUVadW1LU2lPQ1hKVEExR2RjdkZIWDRSQ294aGs1?=
 =?utf-8?B?eTlGSSt2Q1hZNG85eHVzeEg1aWh1c2l3U2lkODBhNVpEQTRPdTk5YmY3ZFNo?=
 =?utf-8?B?UDlYT2xvR3dHanV1UnFxSzlyU0xlR2hkY1oxcXRWUmRkZXBXTWRQdkpHSVlT?=
 =?utf-8?B?aTZaS2xiZjJzaHdIaStSU2NYQkltTU82UmZaa0hIU085OUk5NzVoL1VSY2tP?=
 =?utf-8?B?T3RpWEhqT25sV21DUk1HOWU3Z3gzUUlzanVUUDJIclVBUzgxdUxiT1NuOVd6?=
 =?utf-8?B?MnhScDRnYkFtcFdDdU4xRWsvRjIyQmdzbGV4aHBtTlRRS2tGVXVOQklyNlR1?=
 =?utf-8?Q?jInT1a8FftWCNR6oLKmQvb97j1pqCYXCHKUvI6DGqVGA?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc9e622-3b42-4466-fcae-08dcd3d995a7
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 09:51:05.3591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/VilRKFGGAw5oPRiFzA7ySw0cxvsadrOuawQCPIk/niLWugfNcQFDvaNWllUYZ737rGAQNeECiWuHoQ0KC+ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB10263
Subject: Re: [lttng-dev] Trigger snapshots on a watchdog
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

SGkgRGFtaWVuLAoKCkkndmUgYWRkZWQgYSB2ZXJ5IHN1bW1hcnlmZWF0dXJlIHJlcXVlc3QgaXNz
dWUgaGVyZVsxXSwgcmVmZXJyaW5nIHRvIAp0aGlzIGRpc2N1c3Npb24uIElmIHlvdSB3b3VsZCBs
aWtlIHRvIGVsYWJvcmF0ZSBvciBhZGQgb3RoZXIgZGV0YWlscywgCnRoYXQgd291bGQgYmUgbW9z
dCBleGNlbGxlbnQuCgoKdGhhbmtzLAoKa2llbmFuCgoKWzFdOiBodHRwczovL2J1Z3MubHR0bmcu
b3JnL2lzc3Vlcy8xNDE2CgpPbiAyMDI0LTA5LTEyIDEyOjE0LCBEYW1pZW4gQmVyZ2V0IHdyb3Rl
Ogo+IFRoYW5rcyBmb3IgdGhlIHF1aWNrwqByZXNwb25zZSBLaWVuYW4sCj4gWW91ciBwcm9wb3Nh
bCBpcyBleGFjdGx5IGhvdyB3ZSB3ZXJlIHRoaW5raW5nIHRoZSBtb25pdG9yIGFwcGxpY2F0aW9u
IAo+IGNvdWxkIHdvcmssIHNvIHdlJ2xsIGdvIHdpdGggdGhhdCBmb3Igbm93Lgo+IFJlYWN0aW5n
IHRvIGFic2VuY2XCoG9mIGFuIGV2ZW50ICh3YXRjaCBkb2cpIHdvdWxkIHJlYWxseSBiZSBhIGdv
b2QgCj4gY29tcGxlbWVudCB0byB0aGUgZXhpc3RpbmcgdHJpZ2dlciB0eXBlcy4KPiBJdCdzIGEg
cmVhbGx5IHVzZWZ1bCBmZWF0dXJlIGZvciBhIGZsaWdodCByZWNvcmRlciBpbiBlbWJlZGRlZCBt
ZWRpdW0gCj4gcmVhbC10aW1lIGFwcGxpY2F0aW9ucywgaXMgdGhlIHRlYW0gb3BlbiB0byBmZWF0
dXJlIHJlcXVlc3RzPwo+IENoZWVycwo+IERhbWllbgo+Cj4gT24gVGh1LCBTZXAgMTIsIDIwMjQg
YXQgMTI6NTfigK9BTSBLaWVuYW4gU3Rld2FydCAKPiA8a3N0ZXdhcnRAZWZmaWNpb3MuY29tPiB3
cm90ZToKPgo+ICAgICBIaSBEYW1pZW4sCj4KPiAgICAgT24gMjAyNC0wOS0xMSAxODozOCwgRGFt
aWVuIEJlcmdldCB2aWEgbHR0bmctZGV2IHdyb3RlOgo+ICAgICA+IEdvb2QgZGF5LAo+ICAgICA+
IFdlIGFyZSB0cnlpbmcgdG8gc2VlIHdoYXQgaXQgdGhlIGJlc3Qgd2F5IHRvIG1vbml0b3Igc29t
ZQo+ICAgICBhcHBsaWNhdGlvbnMKPiAgICAgPiBub3QgaGl0dGluZyBhIGRlYWRsaW5lLiBJZGVh
bGx5IHNvbWV0aGluZyBsaWtlIGEgd2F0Y2hkb2cgdGhhdAo+ICAgICBuZWVkcwo+ICAgICA+IHRv
IGJlIHBhdCByZWd1bGFybHkgYW5kIGlmIHRpbWVvdXQgaXMgcmVhY2hlZCB0cmlnZ2VycyB0aGUg
c25hcHNob3QuCj4gICAgID4KPiAgICAgPiBCZWZvcmUgd2UgcmVpbnZlbnQgdGhlIHdoZWVsIGFu
ZCBjb2RlIHNvbWUgdXNlcmxhbmQKPiAgICAgYXBwbGljYXRpb25zLCBpcwo+ICAgICA+IHRoZXJl
IGEgY2Fub25pY2FsIHdheSBpbiBMVFRuZyB0byBkbyBpdD8gSSBmb3VuZCB0aGlzCj4gICAgID4g
PGh0dHBzOi8vcmV2aWV3Lmx0dG5nLm9yZy9jL2x0dG5nLXRvb2xzLysvOTY1Ny85PsKgdGhhdCBp
cwo+ICAgICBzdXNwaWNpb3VzbHkKPiAgICAgPiBjbG9zZSBtYXliZT8KPiAgICAgPgo+ICAgICBJ
IGRvbid0IHRoaW5rIHRoZSB0aGUgcHJvcG9zZWQgY2hhbmdlcyB5b3UgbGlua2VkIHRvIGFyZSB1
c2VmdWwgb3IKPiAgICAgcmVsYXRlZCB0byB3aGF0IHlvdSBob3BlIHRvIGFjaGlldmUuIFRoZSBw
YXRjaCBzZXJpZXMgaXMgYSBjb25jZXB0Cj4gICAgIGFib3V0Cj4gICAgIGhvdyBzb21lIHR5cGVz
IG9mIFVTVCByaW5nIGJ1ZmZlciBzdGFsbHMgbWlnaHQgYmUgYWRkcmVzc2VkIGJ5IHRoZQo+ICAg
ICBzZXNzaW9uIGRhZW1vbi4gQWZ0ZXIgYSBxdWljayBnbGFuY2UsIHRoZSBtb25pdG9yaW5nIHNl
ZW1zIHRvIGJlIG1vcmUKPiAgICAgY2xvc2VseSByZWxhdGVkIHRvIHRoZSAnbW9uaXRvciB0aW1l
cicsIHdoaWNoIGlzIHVzZWQgdG8gc2FtcGxlCj4gICAgIHN0YXRpc3RpY2FsIGluZm9ybWF0aW9u
IGNoYW5uZWxzWzFdLgo+Cj4KPiAgICAgVGhlcmUgaXMgYSBjb25jZXB0IG9mIHRyaWdnZXJzWzJd
OyBob3dldmVyIHRyaWdnZXJzIHJlYWN0IHRvIHRoZQo+ICAgICBwcmVzZW5jZSBvZiBldmVudHMg
cmF0aGVyIHRoYW4gdGhlIGFic2VuY2UgdGhlcmVvZi4KPgo+Cj4gICAgIEkgdGhpbmsgYSBzbWFs
bCB1c2VyIHNwYWNlIGFwcGxpY2F0aW9uIHRoYXQgbW9uaXRvcnMgdGhlIHN0YXRlIG9mCj4gICAg
IG90aGVyCj4gICAgIGFwcGxpY2F0aW9ucyBpcyBtb3JlIHRoZSBkaXJlY3Rpb24gdG8gaGVhZCBp
bi4gVGhlcmUncyBhdCBsZWFzdCBvZgo+ICAgICBjb3VwbGUgb2Ygd2F5cyB0aGF0IGEgc25hcHNo
b3Qgb24gdW5oZWFsdGh5IHN0YXRlIGNvdWxkIGJlIGFjaGlldmVkOgo+Cj4KPiAgICAgKiBVc2Ug
bGlibHR0bmctY3RsIHRvIHRyaWdnZXIgYSBzbmFwc2hvdCBmcm9tIHlvdXIgd2F0Y2hkb2cKPiAg
ICAgYXBwbGljYXRpb25bM11bNF0uCj4KPiAgICAgKiBIYXZlIHRoZSB3YXRjaGRvZyBhcHBsaWNh
dGlvbiBleGVjIGBsdHRuZyBzbmFwc2hvdCByZWNvcmRgWzVdLgo+Cj4gICAgICogSGF2ZSB0aGUg
d2F0Y2hkb2cgYXBwbGljYXRpb24gZW1pdCBzb21lIHNvcnQgb2YgImhlYWx0aCBzdGF0ZSIKPiAg
ICAgZXZlbnRzCj4gICAgIHdpdGggc29tZSBkYXRhIChlLmcuIGhlYWx0aF9va2F5LCBoZWFsdGhf
YmFkLCAuLi4pIHBlciB5b3VyIHVzYWdlCj4gICAgIHJlcXVpcmVtZW50cywgYW5kIGNvbmZpZ3Vy
ZSBhIHRyaWdnZXJbMl0gdG8gdGFrZSBhIHNuYXBzaG90IG9uIHRoZQo+ICAgICAiaGVhbHRoIHN0
YXRlIiBldmVudHMgdGhhdCBoYXZlIHRoZSBub24tb2theSBzdGF0ZS4KPgo+Cj4gICAgIERlcGVu
ZGluZyBvbiB5b3VyIHRyYWNpbmcgY29uZmlndXJhdGlvbiAtIGNoYW5uZWwgb3ZlcndyaXRlL2Rp
c2NhcmQKPiAgICAgbW9kZVs2XSwgYnVmZmVyIHNpemVzLCBibG9ja2luZyBtb2RlLCBhbmQgbnVt
YmVyIG9mIGV2ZW50cyBpdCBpcwo+ICAgICBwb3NzaWJsZSB0aGF0IGV2ZW50cyBtYXkgbm90IGJl
IHJlY29yZGVkLiBJIHdvdWxkIHByaXZpbGVnZSB1c2luZwo+ICAgICBsaWJsdHRuZy1jdGwgb3Ig
ZXhlYydpbmcgYGx0dG5nIHNuYXBzaG9ydCByZWNvcmRgIGlmIHlvdSB3YW50IGEKPiAgICAgc3Ry
b25nZXIKPiAgICAgZ3VhcmFudGVlIHRoYXQgeW91ciB3YXRjaGRvZyB3aWxsIGNhdXNlIGEgc25h
cHNob3QgdG8gYmUgdGFrZW4uCj4KPgo+ICAgICBJIHdvdWxkIGxvdmUgdG8gaGVhciBpZiB0aGVy
ZSBhcmUgb3RoZXIgaWRlYXMuIFJlZ2FyZGxlc3MsIGhvcGUKPiAgICAgdGhpcyBoZWxwcyEKPgo+
Cj4gICAgIHRoYW5rcywKPgo+ICAgICBraWVuYW4KPgo+Cj4gICAgIFsxXTogaHR0cHM6Ly9sdHRu
Zy5vcmcvZG9jcy92Mi4xMy8jZG9jLWNoYW5uZWwtdGltZXJzCj4KPiAgICAgWzJdOiBodHRwczov
L2x0dG5nLm9yZy9kb2NzL3YyLjEzLyNkb2MtdHJpZ2dlcgo+Cj4gICAgIFszXTogaHR0cHM6Ly9s
dHRuZy5vcmcvZG9jcy92Mi4xMy8jZG9jLWxpYmx0dG5nLWN0bC1sdHRuZwo+Cj4gICAgIFs0XToK
PiAgICAgaHR0cHM6Ly9naXRodWIuY29tL2x0dG5nL2x0dG5nLXRvb2xzL3RyZWUvbWFzdGVyL3Ny
Yy9saWIvbHR0bmctY3RsCj4KPiAgICAgWzVdOiBodHRwczovL2x0dG5nLm9yZy9tYW4vMS9sdHRu
Zy1zbmFwc2hvdC92Mi4xMy8KPgo+ICAgICBbNl06Cj4gICAgIGh0dHBzOi8vbHR0bmcub3JnL2Rv
Y3MvdjIuMTMvI2RvYy1jaGFubmVsLW92ZXJ3cml0ZS1tb2RlLXZzLWRpc2NhcmQtbW9kZQo+Cj4K
PiAgICAgPiBUaGFua3MsCj4gICAgID4gQ2hlZXJzCj4gICAgID4KPiAgICAgPiAtLQo+ICAgICA+
ICpEYW1pZW4gQmVyZ2V0Kgo+ICAgICA+IEVtYmVkZGVkIFBsYXRmb3JtIExlYWQKPiAgICAgPiBk
YW1pZW4uYmVyZ2V0QGZseXppcGxpbmUuY29tCj4gICAgID4KPiAgICAgPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+ICAgICA+IGx0dG5nLWRldiBtYWls
aW5nIGxpc3QKPiAgICAgPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4gICAgID4gaHR0cHM6
Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo+Cj4K
Pgo+IC0tIAo+ICpEYW1pZW4gQmVyZ2V0KgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5s
dHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZv
L2x0dG5nLWRldgo=
