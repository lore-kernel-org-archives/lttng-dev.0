Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE62C27C4F
	for <lttng-dev@archiver.kernel.org>; Tue, 18 Jun 2024 15:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1718724634;
	bh=eQow7vOp2vmXFknu8delegYwCNmYv5wSdmv/KPqB55Y=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=W5z6Rp3UNjRhHSt2Jo1kmhlnnL3QcuoSLqKbI/44PCKq4PXH48eHZHgb7Fzhij6lJ
	 mt+h2xzYn4IVLmQrThOZW97OuWSk2jHqpCxraajOycKdINGtrNvgYlkjk6Fk6O5ACN
	 9oJy6ATD8trJEAt3wLQAZkelX6wVNarhHGV8PQpkXT8GnkNX3UsdO7rAtRjYxSfOHS
	 tP64axRi2rkjBG7+qjzFe0MhJys1GIg9qjqbhafhjgPaRV2di+DMQY/lEtAZIvIgxG
	 akIkbDR9ZxBmp+wrrvJomU6h+b/1hW5lphyPVMDLgP2YM8fDwd04Z1s7baHblKF+O/
	 V+ziUKK0rRoZQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4W3W0n5dFDz47f;
	Tue, 18 Jun 2024 11:30:33 -0400 (EDT)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:241d::700])
 by lists.lttng.org (Postfix) with ESMTPS id 4W3W0m4YCbz43Z
 for <lttng-dev@lists.lttng.org>; Tue, 18 Jun 2024 11:30:32 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFUA+ItkrWhZH4bIjivdr/Hax2/1iENIOIq1tbWI2dUdMCcuy+4m7glDWhjRa9pRpB3HOiLaxf8jKh+ZhmFVOAHxMGtr5tDsXsgJbCuk/R2IVuPHzxZs93T8SlixP+hGITY8mMhuyIEAoSSEVh9m54HFkkoLfoNtYCOq7FeSrimmRTfQaNESFyYpVg0Bwl6YMHOOz6aFuYlf4WAzoy2TyTlYrGxGI4Okt86BMmcbC+CRQWtO1J9qNgs7m7NCKU5NLsbPGxoWcKRugPWIeuSNHOztp17mKrIgow3DhmO1huSiGhCf9yfUBzF7BB9c5QKQd5hOmAP+4hXulm5HVKEFRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4eUw+KZJK8Sya7JrjJSeGdN8h/RErm+Kyzti0el08Y=;
 b=jtvzeScitRJHcGk5FhqFs0RW8PbfMCGsLwhAOQftq83gjH7Qt0EloVYnDQcYFbbjnH6umQTLfQo7h/YXl2M7dk0mBqgijXfQQVqSLHof3ks2x9xUdgXl9A/BRauwRWxfCOEeQH1OTo7ExsCurTmOXCOJLm6ZnvOaKoqCJk+uMWfqBnWgPXRpnRoYmoCwxFPYplQVOpQAPbBjf4kWm5dqOcjOpC87h95pj4TKMaTHoAwmDRUZZLqKdgNjACB5EZ3sDRf9cX+jgMivPNc5BnXgKGrsj6r/anNJYR3ycd5d7U5JRUdeCrksMy0F3kz2f1NueD38/UzfW/4vwRa4SvMbbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT3PR01MB9283.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:76::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Tue, 18 Jun
 2024 15:30:29 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%2]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 15:30:29 +0000
Message-ID: <69070705-3499-4fdc-877c-6e9539c2c555@efficios.com>
Date: Tue, 18 Jun 2024 11:30:28 -0400
User-Agent: Mozilla Thunderbird
To: Aditya Kurdunkar <adityakurdunkar2@gmail.com>, lttng-dev@lists.lttng.org
References: <CAFV=bv=hp9n8fCxxWjHn_wKQZHyAizDzVbSkVhvjNJSE_LrmEQ@mail.gmail.com>
 <e55ebc81-d19c-405a-9c7d-26f266ecfffa@efficios.com>
Content-Language: en-US
In-Reply-To: <e55ebc81-d19c-405a-9c7d-26f266ecfffa@efficios.com>
X-ClientProxiedBy: YQBPR0101CA0168.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::11) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT3PR01MB9283:EE_
X-MS-Office365-Filtering-Correlation-Id: 152a3083-e26f-4a17-afc2-08dc8fab95ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlFEVWwxZ05MNFpSb2NmR3phalpKVUlieVh0TDhrQ1IzVlBVejlDVzJzbnR4?=
 =?utf-8?B?NmN5aW9VanE3OHBNYTBGdzRhRk5hTGRnaG9FVDJCNmJsNHkwa29FNUV1ODJX?=
 =?utf-8?B?UzJ4VnIzdTVxbVJQcWVNaldXMXlVWUZyZnM3ME1TVUE4MWFkTG5wT3hLZ1Jw?=
 =?utf-8?B?aWoxdGI3L3lPbWRERzZEcUE3OU52ZEwvQkV5YTE2NkFpQjNkdU5Ja3E1S056?=
 =?utf-8?B?OW5jUWtXNjUrYXh4ZUwxZHptR3cyMVFZM1J1cDQ4cEJ5dmJxV1B4Ymo5OGpw?=
 =?utf-8?B?U1NuazJxdW0rTW1ENDRHQnFVdU5ta2ZxQWMrajRXUUlxWTlmQmEvZ09SUzAx?=
 =?utf-8?B?bDhXeWl0L0RzV1E5dVh4bnNtbnhCOURTanBpT2M5a1U1SFQ5Z3IrczM1OU5Z?=
 =?utf-8?B?ZXB3QW5wSndpbVBoZU1GN0hETnlDU2FKSmZCZTI2dzdvaVRaeTVzOEUwdHNB?=
 =?utf-8?B?dXNvamlvN3ZZdHZ1N3pTZEtEQ0h1V3NKSmpQdFZSU01FQzNyZGp4Ykxvd2xv?=
 =?utf-8?B?TEFldDJiaGMxUDZRNjNOemQ5RHZJWG03UXI0ajRUV0ZDT2xsZkRPczhZMjRm?=
 =?utf-8?B?THpUa3FISEZ5QWU0dXkwd1JyNkgyazJyVVFXUjVSeXhLdjV1aDV1aUtVR250?=
 =?utf-8?B?TkdJa2VWR2YxbVY1YXlMNmJ3ZVA2aUk5YlRDY2YzVGU3cUhHSmt5MjdqcVZa?=
 =?utf-8?B?MWZvQmNXTy96NDJVYU9jQnRGOUhQbllSUnRpYnVFZzQvUDcyWGlLUkpvQ1E0?=
 =?utf-8?B?Q1NGN0lJalM2eGE3bEt4NU9UbFh3Q09CU1pRK0J4R0xvNE12b1REUnk5TVF2?=
 =?utf-8?B?bk9wbmpMeCt0UFM5RFREcHRyQmZiZTN3WHRrcjRkeXJ0YXNlT1ZKb200VVFn?=
 =?utf-8?B?eDYzcGVPTWJYeG1GeWJvU2ptb3cxTnFlR1VKOHZCMTdCWHUyVE5LMW1DaDhp?=
 =?utf-8?B?MThINDFudXo5TDhSM24zUHVGV3VLam5SYU5US3F6QnIvSkE1MUM4RWpJVFZZ?=
 =?utf-8?B?eCtBVEFOa1ByR0V3OVVQS0wxajdqR2loenkxMTU3QWtlN3FKczdEbTBTeXcr?=
 =?utf-8?B?dk4yV2ZkNkkxUlQ5WUl6SDh4RVY5ck81bkRiczBUYTJIRjczenNLaURRZzNS?=
 =?utf-8?B?cEVUcmczNE9rK1luZFNGRjZmK2UzamlaZ1FmK29KZXRXaWphSGZDOWpvTTdE?=
 =?utf-8?B?Q0VXUWFyaWYwenFGOFdGY0QvVG01NDBtcXVDQTdhbmlyZkovKzFsOTQ3UEt1?=
 =?utf-8?B?N1dYakd1aWdRNDg0VTUvTkFKdnU0aFVhemRLdDZGZ21tYWJJTFFKNVJYYlU4?=
 =?utf-8?B?L0RhV1JqTjBSSWUrTDNldjFtelNoc0NvVFdKQUI2L082Zk9CaWYzVlp2czJi?=
 =?utf-8?B?ai9FQWppaVRNZ1Z6Q21kTzBBaHdLM2lYN3pGQTgyU1ZpcG55dzEvQ0R6VXVL?=
 =?utf-8?B?YXB2V0dzVDhzK1Y2bEsrbHNHMEFXL1laZE5JUjZLQkJLN3E2WlM4MEhIaGp0?=
 =?utf-8?B?eDRzUDZjcmNJZ2g4VVo1b09KK3pqcFhnR2x6a3JMM3hkdW5NbWNDWTYyVXZQ?=
 =?utf-8?B?YkNQYjVOcWgyVjN2bHJmUnpPZUI4WldjanVDejNBRC85b2Z1MmRsTXcweWxU?=
 =?utf-8?B?VWJTaU9kQTRQZ1pRZUt3d3ZpaXdPbmtTbHRBa3B4RTBFZDFSR1ErNFNGdlFi?=
 =?utf-8?B?YVRwWGplRWtOYXJkekk5cHllc0F0S0ZOcXdMQnZ5YjdEQTJieENpT1FBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(1800799021)(376011); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1I4Ujhub09NWnBFMFZBb1ZLdkt5VU95eDJ1T3BQYmIzdkVSOGE2YXd4VTJk?=
 =?utf-8?B?UE5GeGpHU3prL3Jsa2ZMVGd2Z3RrRThudkROSGR3Ym5xQUpGTFV0T3phTC81?=
 =?utf-8?B?NWRDWFJKQUw2ZUdzQUZQN0d0RjRjd1RnREN1YUpVYmdNSUFSdEYyOS9nNWlL?=
 =?utf-8?B?UXpzc0hTeDN6TklLY2FCNDdzTmdIendPdis5TnVDYXBKRHV5RFU4eTZWS0dr?=
 =?utf-8?B?ZkV2NURqOVlneEFRaW9OYTNtelgzeVpYVDFhQ0dzVVRkYlFidlo4NnFKWlJX?=
 =?utf-8?B?MGVtYmExUHhNSUJxaFdCa3pZYmJjWmZmcmZFSXc2SGZWcktTSFV3MHZJSysr?=
 =?utf-8?B?NXVtc0t1dSt3WERxeUpKSzg0ZG1vdUkvVzNJVE9hRmhlWjdtMjZPTG5ZNWJ1?=
 =?utf-8?B?Ym04NExidnVJZW0vb2dpQUNVUnU3ckF4SzV4akZEaTJJcmdoNFMveHVZM2tj?=
 =?utf-8?B?Z0pWK2VxVmdPSEdpYnVkZWtXaGtwd1RieHA0ZS9vR0d6NHNGbkl5RUo5dDhk?=
 =?utf-8?B?WWtuY3BiOUhjejNUV3dvWldJV0RScjBKSVBvRCszUit2dGJ2R29HMlIwdmdh?=
 =?utf-8?B?bE5SR3JuTnlzL1RjbFVCWS8yek9uRlg0aElIRVJzaWY2VmVoMDN1NFpLNWNG?=
 =?utf-8?B?dmM1NVlUYjVodkw1eTJJZnJ3ZUt3dDhLdzB4YmkyS016eEVrOHd1WEw0ci9H?=
 =?utf-8?B?VlJ4b0UwR3FBdXJmYzhLUmlZUDBRUWhWQTU4RCtFQ1JBeUROSUFwaWpLUkIy?=
 =?utf-8?B?MlFVeDF6SUgrcW5GYWxhYzFiN05jRWpXR1pEQzBOaTdDYzFyVGxaeDNVSFVo?=
 =?utf-8?B?d0lWSktmTkgvNm1tOE95Z3pRbDkyOEtIYk1jYnp2YXhqTmJCcHByOTBVRUV5?=
 =?utf-8?B?clg0MGxISDk3VnJzREZhalpXS04rSzBNa0RnOTNEYklOREVrSmxIbUZXSFQx?=
 =?utf-8?B?VFF2M3BOSXQwbElSQXpITHNRSlY1SzZQR2d3OVdueW9qUGthTkZGTjBkK0ls?=
 =?utf-8?B?WGxGWkt3RGRLZi9acXNneTJmMTQySmNyajk5QkxsVkNRbzgxMy8wTlM1U3lQ?=
 =?utf-8?B?TDlobGJYMXFxRDJYaitvUS9KYVlidHlUN3U2YzhzbUF4b05TcmpFWHpnelBC?=
 =?utf-8?B?L3lRK1Z2c3ArUXl2V2JtN3lKbHBLaEp4N0wwaHZSeGFNbmh6WWJOdGVWUlNB?=
 =?utf-8?B?L2ZnNWlMR0NzVkgwK3MvTHdsT0l5QVZpelJvdzVWUGdPRXJOeWNKK0hucVpR?=
 =?utf-8?B?Y2w3TW9FL2RGcTVPVzgxVC90M3JGOWxGUUZTaHFCVTZ0Mkw4dUExNDk4dE5z?=
 =?utf-8?B?dVpEWXBCeklIUUgwOWpYUysya2RsTzVuME5xblY1K2tUajNZam45ek1ydHF4?=
 =?utf-8?B?L2JXOCs4ZnM4SDVMSU1pRUYycEttZzlNQUl4cnFqU2VvanZSZ0FNNXBGTlA3?=
 =?utf-8?B?eVJTYktEWHR6U0NWMjVEU2s1ZnQ5SUtGdVJZejhzMDAvYXBmb3o2ajYxL1p2?=
 =?utf-8?B?TmxzZzBKTmZvcTBtZGdWTHpEbm95bDB0eHlBOE05OXU3Wkp4MyszeSt1d2dD?=
 =?utf-8?B?QmZXNlVYVHRFamtTZ04wbXdvUzhlaDlkNnZwRVR2NHVTeFd4ZENvOW5tZnZ5?=
 =?utf-8?B?aGx2dHFSMzM5YzUxSXp0akI1cWdXMTJTRjM1emZYYWthNmhjRytiaksva2ta?=
 =?utf-8?B?TUJHTmg0TUYyYUdGY2lwN05BMzZPanRRZFBoR08zN3ZUREplRDlLVDdQdWpW?=
 =?utf-8?B?bmdUbmtWQS92L2FLTXg4SHBOSnJrZXVMd2tGOEtXR0NHd3RIWjNWS0FGcGdy?=
 =?utf-8?B?S3ZuaVlXdml2WGxtVnVISk15SnNvdE9YY2hVbDR1MzdIOUNKSU9BbGdwVEVj?=
 =?utf-8?B?Z0tYNHZHWjBqcmZUYnBEYzBYRWdsd2d6ZDlJS1d4NUR4REdEUFJRNnBoaS83?=
 =?utf-8?B?ZktEckgzU2dEb24xTnFWa3dIN0prSTJka09KVlNNcE9TcHNKcjVKWFhMdUwv?=
 =?utf-8?B?UXl1SFcxaWoxV2FmbmRvTEVvbURCS2V3NGZPSWtvYlAyNTJGTWM1Lzh0NlJv?=
 =?utf-8?B?dDJYYThiemYxZ1JwVFVyd3dIZURPdHNmMlJQREthVE5wMm51RERpYUcwdU92?=
 =?utf-8?B?U0ptZnpwVnJYWE5TSmJVQU9GOHJGdFQxeDFRTTdEQmZoS1ZPckhQeG9SSkVk?=
 =?utf-8?B?ckE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 152a3083-e26f-4a17-afc2-08dc8fab95ef
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 15:30:29.8608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUibwIDtMYS99BXd40Pj7liw6iFOHF+CKhW0i9iDG2x2uwsYesHdW9f+NEt5jp968eDf7oNUzCHvuzkVMILNRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9283
Subject: Re: [lttng-dev] Is it possible to disable recording the CPU id for
 USTs?
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

SGkgQWRpdHlhLAoKSSB3YW50IHRvIGFkZCBhIGZ1cnRoZXIgZGV0YWlsLgoKV2hpbGUgbmVpdGhl
ciBhcm0zMiBub3IgYXJtNjQgaGF2ZSBzdXBwb3J0IGZvciBxdWljayBsb29rdXBzIG9mIHRoZSAK
Y3VycmVudCBjcHUgaWQgaW4gdkRTTywgSSB0aGluayB0aGF0IGlmIHlvdSBhcmUgdXNpbmcgYSBy
ZWNlbnQgbGludXggCmtlcm5lbCAoPj0gNC4xOCkgd2l0aCBhIHJlY2VudCBnbGliYyAoPj0gMi4z
MiB3aXRoIFJTRVFfU0lHIGRlZmluZWQpIApzY2hlZF9nZXRjcHUgc2hvdWxkIHVzZSBSU0VRIGlu
c3RlYWQsIGFuZCBpdCBtdWNoIGZhc3RlciB0aGFuIGdldGNwdSAKc3lzY2FsbC4KCkMuZi4gCmh0
dHBzOi8vZ2l0aHViLmNvbS9ibWlub3IvZ2xpYmMvY29tbWl0LzZlMjljYjNmNjFmZjU0MzJjNzhh
MWM4NGIwZDliMTIzYTM1MGFiMzYKCnRoYW5rcywKa2llbmFuCgpPbiA2LzE4LzI0IDEwOjAwIEFN
LCBLaWVuYW4gU3Rld2FydCB2aWEgbHR0bmctZGV2IHdyb3RlOgo+IEhpIEFkaXR5YSwKPiAKPiBP
biA2LzE4LzI0IDg6NTUgQU0sIEFkaXR5YSBLdXJkdW5rYXIgdmlhIGx0dG5nLWRldiB3cm90ZToK
Pj4gSGVsbG8sCj4+Cj4+IFBsZWFzZSBiZWFyIHdpdGggbWUgaWYgdGhpcyBpcyBhIG5haXZlIHF1
ZXN0aW9uLiBJIGFtIHdvcmtpbmcgb24gYW4gCj4+IGVtYmVkZGVkIEFSTSBjaGlwICgxR0IgcmFt
LCAyQ1BVcykgd2hlcmUgSSB3YW50IHRvIGNvbGxlY3QgdHJhY2UgCj4+IGV2ZW50cyBmb3IgYSBs
b25nIGR1cmF0aW9uIG9mIHRpbWUuIEZyb20gdGhlIHJlc2VhcmNoIHRoYXQgSSBoYXZlIGRvbmUg
Cj4+IChtb3N0bHkgcmVhZGluZyBwYXBlcnMgb24gTFRUbmcgdHJhY2luZywgY29uZmVyZW5jZSB0
YWxrcyBhbmQgCj4+IGRvY3VtZW50YXRpb24pIEkgaGF2ZSBzZWVuIGl0IG1lbnRpb25lZCB0aGF0
IGZvciBBUk0gdGhlIG92ZXJoZWFkIGlzIAo+PiBncmVhdGVyIGJlY2F1c2UgdGhlIHN5c3RlbSBj
YWxsIHRvIGdldCB0aGUgQ1BVIGlzIHF1aXRlIHNsb3cuIEluIG15IAo+PiB1c2UgY2FzZSBJIGFt
IG9rYXkgd2l0aCBub3QgaGF2aW5nwqAgdGhpcyBpbmZvcm1hdGlvbi4gVGhlIGN1cnJlbnQgCj4+
IGJlbmNobWFya3Mgc2hvdyBhIDMgbWljcm9zZWNvbmQgb3ZlcmhlYWQgb2YgYSBzaW5nbGUgdHJh
Y2Vwb2ludCBvbiBBUk0gCj4+IGluIGNvbXBhcmlzb24gdG8gCj4gCj4gSXMgdGhlcmUgYSBzcGVj
aWZpYyBkZXRhaWwgdGhhdCBsZWFkcyB5b3UgdG8gYmVsaWV2ZSB0aGF0IGdldGNwdSBpcyAKPiB0
YWtpbmcgdGhlIGJ1bGsgb2YgdGhlIHRpbWU/Cj4gCj4gQXJlIHRoZSBwZXJmb3JtYW5jZSBvZiB5
b3VyIGVtYmVkZGVkIGFybSBjaGlwIGFuZCB0aGUgeDg2XzY0IHN5c3RlbSB5b3UgCj4gYXJlIGNv
bXBhcmluZyBhdCBhbGwgc2ltaWxhciBvdGhlcndpc2U/Cj4gCj4gUmVnYXJkbGVzcyBJIHRoaW5r
IHRoaXMgY29tcGFyaXNvbiBtYXkgbWlzbGVhZGluZy4gSXQgc291bmRzIGxpa2Ugd2FudCAKPiB5
b3Ugd2FudCB0byBtZWFzdXJlIGlzIHRoZSB0aW1lICsgcmVzb3VyY2VzIHJlcXVpcmVkIHRvIHJ1
biB5b3VyIAo+IGFwcGxpY2F0aW9uIHdpdGggYW5kIHdpdGhvdXQgdHJhY2luZyBvbiB0aGUgc2Ft
ZSBwbGF0Zm9ybSwgcmF0aGVyIHRoYW4gCj4gY29tcGFyaW5nIHR3byBkaXNzaW1pbGFyIHBsYXRm
b3Jtcz8KPiAKPiBQbGVhc2Ugbm90ZSB0aGF0IHRoZSBVU1Qgb3ZlcmhlYWQgKGUuZy4gc3Bhd24g
YW4gYXBwbGljYXRpb24sIGxhdW5jaCB0aGUgCj4gVVNUIHRocmVhZCwgY29ubmVjdCB0byB0aGUg
c2Vzc2lvbmQsIHRyYW5zZmVyIGNvbmZpZ3VyYXRpb24gYW5kIGJ1ZmZlciAKPiBwb2ludGVycykg
aXMgY29tcGFyYXRpdmVseSBsYXJnZSBmb3IgYSBzaW5nbGUgZXZlbnQsIHJhdGhlciB0aGFuIG92
ZXIgCj4gdGhlIGNvdXJzZSBvZiBhICdsb25nJyBydW5uaW5nIGFwcGxpY2F0aW9uLgo+IAo+IFRo
ZSBkZWZhdWx0IGJlaGF2aW91ciBpcyB0byBibG9jayBtYWluIHByb2dyYW0gZXhlY3V0aW9uIHVu
dGlsIHRoZSAKPiByZWdpc3RyYXRpb24gY29tcGxldGVzIG9yIHRpbWVzIG91dC4gSW4gbWFueSBj
YXNlcyB5b3UgbWF5IHdhbnQgdG8gCj4gZGlzYWJsZSB0aGF0IHRpbWVvdXQgZm9yIHF1aWNrZXIg
c3RhcnR1cCBhdCB0aGUgY29zdCBvZiBwb3RlbnRpYWxseSAKPiBsb3NpbmcgZXZlbnQocykgcmln
aHQgYXQgdGhlIGJlZ2lubmluZy4gQy5mLiBMVFROR19VU1RfUkVHSVNURVJfVElNRU9VVCAKPiBp
biBodHRwczovL2x0dG5nLm9yZy9tYW4vMy9sdHRuZy11c3QvdjIuMTMvI2RvYy1fZW52aXJvbm1l
bnRfdmFyaWFibGVzCj4gCj4+IDE1MG5zIG9uIGEgeDg2IG1hY2hpbmUuIEhlbmNlLCBteSBxdWVz
dGlvbiBpczogSXMgaXQgcG9zc2libGUgdG8gCj4+IGRpc2FibGUgcmVjb3JkaW5nIHRoZSBDUFUg
c29tZWhvdz8gQW55IHN1Z2dlc3Rpb25zIGZvciBkZWNyZWFzaW5nIHRoZSAKPj4gb3ZlcmhlYWQg
b3RoZXIgdGhhbiB0aGlzIGFyZSB3ZWxjb21lLgo+IAo+IEl0IGlzIGFsd2F5cyBlbmFibGVkIGMu
Zi4gCj4gaHR0cHM6Ly9sdHRuZy5vcmcvbWFuLzMvbHR0bmctdXN0L3YyLjEzLyNkb2MtX2NvbnRl
eHRfaW5mb3JtYXRpb24KPiAKPiBIb3dldmVyLCBJIHN1cHBvc2UgeW91IGNvdWxkIHRyeSB0byB1
c2UgYSBjdXN0b20gZ2V0Y3B1IHBsdWdpbiwgZS5nLiAKPiBodHRwczovL2dpdGh1Yi5jb20vbHR0
bmcvbHR0bmctdXN0L3RyZWUvbWFzdGVyL2RvYy9leGFtcGxlcy9nZXRjcHUtb3ZlcnJpZGUgdG8g
cmV0dXJuIGEgZHVtbXkgdmFsdWUuCj4gCj4gSWYgeW91IGRldGFpbGVkIHlvdXIgdHJhY2luZyBh
bmQgYmVuY2htYXJrIHNldHVwIGl0IG1pZ2h0IGJlIHBvc3NpYmxlIHRvIAo+IHByb3ZpZGUgYWRk
aXRpb25hbCBndWlkYW5jZS4KPiAKPj4KPj4gUmVnYXJkcywKPj4gQWRpdHlhCj4+Cj4+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+IGx0dG5nLWRldiBt
YWlsaW5nIGxpc3QKPj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+PiBodHRwczovL2xpc3Rz
Lmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cj4gCj4gdGhhbmtz
LAo+IGtpZW5hbgo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmcKPiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0
dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xp
c3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
