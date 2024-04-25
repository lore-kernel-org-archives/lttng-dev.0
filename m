Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C33BC4345F
	for <lttng-dev@archiver.kernel.org>; Thu, 25 Apr 2024 17:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1714067613;
	bh=Qhy/G/wnvpyMve/Lue4IG0UhA9zasoZzXUMExWrglJA=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=kVpE+WGfLB9SAE2z4C1m+lYERaJq8xF+7Dia1bmXrwKr4eAWWO1JQ+yoxYzaZfsnJ
	 ur4s4z9qz3aEYmI87kuRijn7Sztg6WtgPatHrteTTCh0z/KR5pKqr8Q19eEqlFTUSm
	 f0kUGvFx/Zjh72jqdkSITTFh20vZjGa8h7CRucMDCq0Y2mgwPCYTXC7uEwqdCjtpsd
	 pKA387SKvkF/BGp2bfZMJHTfkB2YSiffBaQpx5A/LbJsb/KilQs7aZFu5uFRiZx/GU
	 hUpMT1hXClsrRsFmwzB/XPVOuUYcT2Y37DGhIeftilR/cySJOnA22A85QoIbW6RkDP
	 5dghdO3faZoOg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VQNkh62QZz2k2x;
	Thu, 25 Apr 2024 13:53:32 -0400 (EDT)
Received: from YT3PR01CU008.outbound.protection.outlook.com
 (mail-canadacentralazon11020003.outbound.protection.outlook.com
 [52.101.189.3])
 by lists.lttng.org (Postfix) with ESMTPS id 4VQNkg2SGxz2k86
 for <lttng-dev@lists.lttng.org>; Thu, 25 Apr 2024 13:53:31 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCu26nRFe84sZ/txCdfLfrkARQ3S1J9BD1KW1NgHYajPBXdukarf5KhUx0Fzn7ioFtG+7Wh3haJcCt1kajJU2OmbKc7NIAyBy8w7QdjaNB/q3Cc+oxl3suKbLv6+v6a7cN1+8/0XF0n3i7CuLLO2HKNtFsBwsPwulMi8furhgZq4clP4nH0xeXRH9vuWMHTyq7UtVuXheCsnDV1h4rk6ndFKeMBT7nrAPBevjSXjAvHmk8Flt4ZIOzYoQ7+4A2obRZk1mpiHe49VLOciGKxnBUJEBmVczm5IADGZqB/yB5OVSHMsVCHuW9sF7zO2klZdLaU5DEx6PKkPXdpgd9Paug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x02qhDOc3B38e5KBSc1o5d3IqbsjYmonN6MJr6NziCc=;
 b=O+zL5+TxU7oH+E/U7ebSVoUjNS/rTA2ZfdeELVOUXu8oCxTCPHZLoxofqrGVuWy2rPlSjfVSHs5gfEw3PRnowXa6AatJwADe0D4NDja9UAZ7n1Nja5VMxyTLxHw6vIyq3H7YLOo52uaobHSoW2hzX+sJcV+qzQDcLJQ2WFjzErB1LXV2btZ09EnE0Hxi9Zw879n/4BKCUN+c+9hKOoKeQlqhp7hrag57Ou9jAZIZuKq9DBKnNLhiPDEAXUhQg34emGZvSAKBdKirhspb835+P3aLVZURj6TPjA3oYn5QD6c2R9zg0jwZdkYAQD7zyLCHGG0SEje1p60TzzFkRxLDiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT2PR01MB9908.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 17:53:29 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::17ea:ed8e:e437:46ed]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::17ea:ed8e:e437:46ed%5]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 17:53:29 +0000
Message-ID: <815cab3a-b61b-4f6d-ba85-137fdd7bc313@efficios.com>
Date: Thu, 25 Apr 2024 13:53:27 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Aditya Kurdunkar <adityakurdunkar2@gmail.com>, lttng-dev@lists.lttng.org
References: <CAFV=bvmbx3_k=f13R=NTEADbiVdaT0q8Z9cMwixcs76vuBg_Jw@mail.gmail.com>
In-Reply-To: <CAFV=bvmbx3_k=f13R=NTEADbiVdaT0q8Z9cMwixcs76vuBg_Jw@mail.gmail.com>
X-ClientProxiedBy: YQBPR0101CA0346.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::16) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT2PR01MB9908:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a5864e-d9ec-4fae-6bd2-08dc65509d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UU9sdDBLUlEyaTQxeWFDT1czcHh0RnQrWWlQcFJ4eWRabTZLQ0VjeldDNGM3?=
 =?utf-8?B?a2hsVTBnZ3JDM1Bkc3ZPcVNCOEJ1WmZRTmFBRVNGWjdsR0lxc0Q0TGpOOW9r?=
 =?utf-8?B?ZUIxcUJ5dGhkYjBNK3dvOUtHcFRhZzMrNzdzaHk3WVFUUkNNRW0yZE5TUE1P?=
 =?utf-8?B?TkNld2dCZVpLOTNoRUU3WE1hejlxSDJYMWI0ZENPRjYrYjF3VGVHSmFiRGtS?=
 =?utf-8?B?Q3hkS2p6dXhJQ3FiK21lQ2RVRU5RZFdTOW9oazlMVDJGR3h5eWtBSkswaHdP?=
 =?utf-8?B?QWV1aXR6Z29wUHkxOUNlY3JUODRxWjNVRmdsOUN3Zk50SmllRy9ndWdvRktL?=
 =?utf-8?B?U2o5bWkyLzY5YnNTSThSaGRDcFpsLzB6cHZBVllZOVI3NlpIQ3VLUEdVdzhK?=
 =?utf-8?B?dlVyc3ZvcVBkNFBFU3R2ejE1OGFZc0Vndk1tTlJ3WE1HbjlDTEFGRFBIM2Zs?=
 =?utf-8?B?QTdFZVJHa1E5WlNDdWZDVmFpZmhFV20xeENDeUVtL3BaNHE2NVlJY3ZKMDhm?=
 =?utf-8?B?clg5SW1CQ2dOQ1lVaTI5RWpxN0FROG95TUhlMThIbTVEK2ZJZ09mRXF4Qkwx?=
 =?utf-8?B?Yld5M1M3eUNpWFFQSE8xRHVRSHlWMXJ3alBHOVorUEFRSU03U2pBQ2VLWFM0?=
 =?utf-8?B?Y0svQXNiVWtWSW9xY0tQb0tjNk5KMXNIU1p3TG5WK0N2elVhTUx6dUQ0NWZp?=
 =?utf-8?B?a1F2OENRa1JjWGkyNFRrcXNHNmpnMmswT1hZOHRRdFV2QXF3SERzWkZyL3Nu?=
 =?utf-8?B?d0EzQWpLbjFTNzRET2p1TkhKOCt6R2xVSGIxeEtzMEF4SmZwczNpUzZoS3hB?=
 =?utf-8?B?K1JRT1Z5VW5sMUNlaG9PQU05YTdRL1RNUHJKUnk2dW9FdmkvNFpyRVNZMjhD?=
 =?utf-8?B?dTZhZHhReVc2MjF5WVAzUmQ5NEM3MjdqSllrZlh0MDUyWG5HQTljcWRBMFp1?=
 =?utf-8?B?VkM1UmZSTnVLWXRFSnV2bWhwUmlvakcvdDV3Tmg3dXZHNmhYWmpwbmhaNFJK?=
 =?utf-8?B?YStYUmt4bS9LQWFVb3IxclpZN0k2bG9PcktXWStZSXZDUjZvbUt6QVVXL1k3?=
 =?utf-8?B?eWZkL0RpRVRYK0pMVGpueEJkUzZIaGU4UGkwUDNhR2d5bnpwWFRhZ0hUQzg4?=
 =?utf-8?B?ZXJYTXVkQnB1bUtUYlJRbkRrdTRGNDFkdVVCZDdkYXpaeDNlZmRDVmhuWGEr?=
 =?utf-8?B?bU1TRGlIeUd0TG5TNTJWcThwTXMvbitnL3ZXblZEWGhCZ29LNFBoeUhNa05i?=
 =?utf-8?B?WmZ1eWpsOGFXVmVsOEVINGdHWXVCaURPSFhWa3djY2Qwd0VXanlvakx1TU81?=
 =?utf-8?B?MjlUb0NPNXFPa1lYNGd1SXpLNVhGejVaSjVNSzdOWThLTWdFT1lBeWFSb3hK?=
 =?utf-8?B?bk5vV1Q3MHJ4ZlRtZmFzb2U2aTVOUmdhWldYbHRFdjMxZnlLZE5WZGpzaEpx?=
 =?utf-8?B?M2RuN202Sk93NDgydWhTbUVCYmdkaktSdDFwSVhhRE9QVXBURFl3NFM3VTlN?=
 =?utf-8?B?ejBhZngzbmllT1RNY2kxUi8yZVBESlFXMXR3eEpEbWhjc0Zjc2IzdFRnaHpa?=
 =?utf-8?B?dk96NEFaSjd3WlJjdlROdHFVSmNObXE4VjQydjltTXdjcGNldUNvdE05OU03?=
 =?utf-8?Q?GE3gVcvAJkpXS5Np0kuH3XqYGBdXYQr3FIyN4LVwFebQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0FPcTdIN2xhVm53OTFUS2tSdGlDWnJ4VlgrVkdtblB1N3J1bThWaHFDcU9N?=
 =?utf-8?B?M3FTWmoreVlkeG5Zcnc3eTRVekZ1Um0rMjZZSEJhemg1RnhFd3RNTVgxR3Bk?=
 =?utf-8?B?YXNmZWkvb0VXY2E2Q25HeENBaFF2L2JrSnUyQlgxRmZOU2hwelZvMTE3N1NE?=
 =?utf-8?B?Y1V1MU1rSDZNZytOeEUvNUlvRkdIRlpsaGNrQnlzb3VwdnFFeDBNbnlzOTNH?=
 =?utf-8?B?cWhyaXdXV3J0WkJ2MlpKcWhvVGhpUGhYNy8zbllqc05aN3BpZkVUMDVjWE14?=
 =?utf-8?B?Q0tQU3Urc3NVc1VaUGZWT0wzWStzOHNNZHlQUDliUERKdng2Qi9rK09iVm93?=
 =?utf-8?B?Qmk3YnpGTHlwcnI0Z3VvZ3dhRndjamZ2S1Y2aUc2Y1ZITGFqMU92Unp0ekIy?=
 =?utf-8?B?bW1pbWhHVzdXM0FQYXA1OXlnc1A1VG8yK05UZjVaRnFqNWtETEdSY1pYb3E1?=
 =?utf-8?B?T0FDRTVWRkVmV2wrNWNKUmUrc2R1UXhRcnBGUE81WUFTb0M0dlNUZVlIMW9J?=
 =?utf-8?B?RUpycXIzYnFxcENMVTJHVFdPQ3hOazJEbHJRMzN6U2VhaWpXODdmc1ZET0Nh?=
 =?utf-8?B?TDk4RE5ha2hhUDIrd3pVckgrM0Fhdmd0TTJqVVB6ZFJtdE44YjRiY283RmZl?=
 =?utf-8?B?ZGhOR2xqcVlXc3ZUTVRjaTdKMGs3UGtJQTl2eG0zczllWlZ3dWlrSEcyZUNI?=
 =?utf-8?B?aVR1MzdVbmMydG41aFFKWWVnQkoxTGw5dmRjS1EwSHg4UHh0aG56Y1RpMFpB?=
 =?utf-8?B?V0ZHekVSdVVHRkd0cGhIQzVUV1NraHN2UnFuM3g5RDVHN1N3Rjh5SWNQNHdG?=
 =?utf-8?B?RTJXZStwcytDZkthOHBmc2JJRHY3SDdVWCtTM05CU0QydlFERTM0VlFuY3Nn?=
 =?utf-8?B?SS9pTWk1aEYwUXBmYmFDOWU2dStKdmNwMFBhZC9HcllDcWd6RWNOYzlVRlFn?=
 =?utf-8?B?MVcwaS9PKzJCeTZ4RXJlOXJRUXpHZEZPby80dDJWNU1TVHVETmNKTG9qdzVM?=
 =?utf-8?B?M1M0MGlpUkg2K25Oenh0S1ZNWTFMaStyQkJLRk1obFNVeEEzdDdvbndESW4z?=
 =?utf-8?B?cXFZZHRnWEJNbUhUUThhTGE1RXNaWitzaSt1Z1k3VzBqMGdCWW44aEhGcHVN?=
 =?utf-8?B?MCsxR2xCK0h0eGZ1U051amhld3JkUFN3d052SGMvOUpES3hWU29neXlKV1Vh?=
 =?utf-8?B?Mk1mbE52b2NtTFd1SU1CNXJmODk2ZThPMmphVW1GbTN2V0Y4OHppYnVURzJ6?=
 =?utf-8?B?Zm1nWTkyZUFlcitHeWllVGxOemJOaTBKRFZEVDloSFhWb1NrZCtiZEdneGhm?=
 =?utf-8?B?eVNQVVE1TTFFS2sxcjRWWlRocUpVVGlEd1N1L2FsSkxEYXVWMVljNnhNeGFk?=
 =?utf-8?B?SG9FejV6QklGYkIrYUlzWkw3Zmk1UTEzU1hYWFBzTUxZOEI5QUtyWEdDRzZT?=
 =?utf-8?B?L21sRXp6K1lTUnRiLzhNYmcxTFhCWjlsSmNnSGY3ME5BS0FHR2ZadGJsOVp6?=
 =?utf-8?B?aW0wWjIrTGRsYzU2dVdOUXl0a0dFd1lyV1l6bG5RdHNpNjVRbUNoSktlWjh2?=
 =?utf-8?B?NVp0cTZsQ3ByYU1GZTM2OGx0YzVKNHpWaU1MQm1HVTltTTlidGQwNWtsUzB6?=
 =?utf-8?B?YjQ4TVVyc295aTlQYjhmYWVMdHh0QWFCalNJb0pQSWQrUDNYaHExbmYraXZu?=
 =?utf-8?B?WGp3L0tLRFppczdvdmYzK3JlUXZsVTBWWUgyL09ST255MW0rY0hxS0pIWlZ3?=
 =?utf-8?B?NmdiOE8xSTFMdTc3cS9zdzBlZkV1UkY3NzVMZDJic04yb1Q1TWdwQTRSd3Rn?=
 =?utf-8?B?NlkxYjlsdFhaaElCazBsMkhJaXBQRERqaExka2tBT1R4anJGd2NEQ25OQXpm?=
 =?utf-8?B?djlZWk9BTTJoa2YrU2ZtRkcvSnh6VkIrSnA3MUNJcHB4K0FqZ2hwdTdWMllN?=
 =?utf-8?B?M0dPekxjVnpxWVJMWFdzOFAvSi9jbEhRaHhUWlNhTlBxcy9WcnhINit6VmFm?=
 =?utf-8?B?T25TTEdsZ0c3VjhxTUVRa1ZaRmNhSTJWNURWV0Z2Y1k3cjFyeHJtb0lZemlt?=
 =?utf-8?B?R2d2R0dERUlOUFVtaGI3VDk4NzQ3SDB3MXEzdXp1QW8yQkxxNjliUDZ1TGpp?=
 =?utf-8?B?ODRwbGFIaWpyemg1L3BXai9vT1dTRU5BaGdFeUNMbXZWVS9CcGwzZ2pvYWRo?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a5864e-d9ec-4fae-6bd2-08dc65509d69
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 17:53:29.3358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F97jj1JmSPGJPzDmQj3JxRss9FcjKacoWo9z8fw8QrdNXfSjooYbSlJUEsnVDZvI8Bnv9vbZeaiJtg3Vn+a6EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9908
Subject: Re: [lttng-dev] LTTng UST Benchmarks
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

SGkgQWRpdHlhLAoKT24gNC8yNC8yNCAxMToyNSBBTSwgQWRpdHlhIEt1cmR1bmthciB2aWEgbHR0
bmctZGV2IHdyb3RlOgo+IEhlbGxvIGV2ZXJ5b25lLCBJIHdhcyB3b3JraW5nIG9uIGEgdXNlIGNh
c2Ugd2hlcmUgSSBhbSB3b3JraW5nIG9uIAo+IGVuYWJsaW5nIExUVG5nIG9uIGFuIGVtYmVkZGVk
IEFSTSBkZXZpY2UgcnVubmluZyB0aGUgT3BlbkJNQyBsaW51eCAKPiBkaXN0cmlidXRpb24uIEkg
aGF2ZSBlbmFibGVkIHRoZSBsdHRuZyB5b2N0byByZWNpcGUgYW5kIEkgYW0gYWJsZSB0byAKPiB0
cmFjZSBteSBjb2RlLiBUaGUgb25lIHRoaW5nIEkgYW0gY29uY2VybmVkIGFib3V0IGlzIHRoZcKg
cGVyZm9ybWFuY2UgCj4gb3ZlcmhlYWQuIEFsdGhvdWdoIHRoZSBkb2N1bWVudGF0aW9uIG1lbnRp
b25zIHRoYXQgTFRUbmcgaGFzIHRoZSBsb3dlc3QgCj4gb3ZlcmhlYWQgYW1vbmdzdCBhbGwgdGhl
IGF2YWlsYWJsZSBzb2x1dGlvbnMsIEkgYW0gY29uY2VybmVkIGFib3V0IHRoZSAKPiBvdmVyaGVh
ZCBvZiB0aGUgTFRUbmcgVVNUIGluIGNvbXBhcmlzb24gdG8gCj4gb3RoZXLCoGF2YWlsYWJsZcKg
dHJhY2Vycy9wcm9maWxlcnMuIEkgaGF2ZSB1c2VkIHRoZSBiZW5jaG1hcmtpbmcgc2V0dXAgCj4g
ZnJvbSBsdHRuZy11c3QvdGVzdHMvYmVuY2htYXJrIGF0IG1hc3RlciDCtyBsdHRuZy9sdHRuZy11
c3QgKGdpdGh1Yi5jb20pIAo+IDxodHRwczovL2dpdGh1Yi5jb20vbHR0bmcvbHR0bmctdXN0L3Ry
ZWUvbWFzdGVyL3Rlc3RzL2JlbmNobWFyaz7CoHRvIAo+IGJlbmNobWFyayB0aGUgb3ZlcmhlYWQg
b2YgdGhlIHRyYWNlcG9pbnRzIChvbiB0aGUgZGV2aWNlKS4gVGhlIAo+IGJlbmNobWFyaywgcGxl
YXNlIGNvcnJlY3QgbWUgaWYgSSBhbSB3cm9uZywgZ2l2ZXMgdGhlIG92ZXJoZWFkIG9mIGEgCj4g
c2luZ2xlIHRyYWNlcG9pbnQgaW4geW91ciBjb2RlLgoKVGhpcyBzZWVtcyB0byBiZSB3aGF0IGl0
IGRvZXMuCgpBbHRob3VnaCB0aGlzIG1pZ2h0IGJlIGZpbmUgZm9yIG5vdywgSQo+IHdhcyBqdXN0
IHdvbmRlcmluZyBpZiB0aGVyZSBhcmUgYW55IHB1Ymxpc2hlZCBiZW5jaG1hcmtzIGNvbXBhcmlu
ZyBMVFRuZyAKPiB3aXRoIHRoZSBhdmFpbGFibGUgdHJhY2luZy9wcm9maWxpbmcgc29sdXRpb25z
LiAKCkkgZG9uJ3Qga25vdyBvZiBhbnkgcHVibGlzaGVkIG9uZXMgdGhhdCBkbyBhbiBleGhhdXN0
aXZlIGNvbXBhcmlzb24uCgpUaGVyZSBpcyB0aGlzIG9uZVsxXSB3aGljaCByZWZlcmVuY2VzIGEg
Y29tcGFyaXNvbiB3aXRoIHNvbWUgcGFydHMgb2YgCmVCUEYuIFRoZSBzb3VyY2UgZm9yIHRoZSBi
ZW5jaG1hcmtpbmcgaXMgYWxzbyBhdmFpbGFibGVbMl0uCgpJZiBub3QsIGhvdyBjYW4gSSBnbwo+
IGFib3V0wqBiZW5jaG1hcmtpbmcgdGhlIG92ZXJoZWFkIG9mIHRoZSBhcHBsaWNhdGlvbnM/Cj4K
CkknbSBub3QgcmVhbGx5IHN1cmUgaG93IHRvIGFuc3dlciB5b3UgaGVyZS4KCkkgZ3Vlc3MgdGhl
IG1vc3QgcGVydGluZW50IHRvIHlvdXIgdXNlIGNhc2UgaXMgdG8gdGVzdCB5b3VyIGFwcGxpY2F0
aW9uIAp3aXRoIGFuZCB3aXRob3V0IHRyYWNpbmcgdG8gc2VlIHRoZSBjb21wbGV0ZSBlZmZlY3Q/
CgpJdCB3b3VsZCBiZSBnb29kIHRvIGhhdmUgYSBkZWRpY2F0ZWQgc3lzdGVtLCBkaXNhYmxlIENQ
VSBmcmVxdWVuY3kgCnNjYWxpbmcsIGFuZCB0byBwZXJmb3JtIHRoZSB0ZXN0cyByZXBlYXRlZGx5
IGFuZCBtZWFzdXJlIHRoZSBtZWFuLCAKbWVkaWFuLCBhbmQgc3RhbmRhcmQgZGV2aWF0aW9uLgoK
WW91IGNvdWxkIHB1bGwgbWV0aG9kb2xvZ2ljYWwgaW5zcGlyYXRpb24gZnJvbSBwcmlvciBwdWJs
aWNhdGlvbnNbM10sIAp3aGljaCB3aGlsZSBvdXRkYXRlZCBpbiB0ZXJtcyBvZiBzb2Z0d2FyZSB2
ZXJzaW9uIGFuZCBoYXJkd2FyZSAKZGVtb25zdHJhdGUgdGhlIHByb2Nlc3Mgb2YgY3JlYXRpbmcg
YW5kIGNvbXBhcmluZyBiZW5jaG1hcmtzLgoKSXQgd291bGQgYWxzbyBiZSB1c2VmdWwgdG8gaWRl
bnRpZnkgaG93IHlvdXIgYXBwbGljYXRpb24gYW5kIHRyYWNpbmcgCnNldHVwIHdvcmtzLCBhbmQg
dG8gdW5kZXJzdGFuZCB3aGljaCBwYXJ0cyBvZiB0aGUgc3lzdGVtIHlvdSBhcmUgCmludGVyZXN0
ZWQgaW4gbWVhc3VyaW5nLgoKRm9yIGV4YW1wbGUsIHRoZSBzdGFydHVwIHRpbWUgb2YgdHJhY2lu
ZyByYXBpZGx5IHNwYXduaW5nIHByb2Nlc3NlcyB3aWxsIApkZXBlbmQgb24gdGhlIHR5cGUgb2Yg
YnVmZmVyaW5nIHNjaGVtZSBpbiB1c2UsIGlmIHRoZSB0cmFjaW5nIAppbmZyYXN0cnVjdHVyZSBp
cyBsb2FkZWQgYmVmb3JlIG9yIGFmdGVyIGZvcmtpbmcsIGV0Yy4KCllvdXIgY2FzZSBtaWdodCBi
ZSBhIGxvbmcgcnVubmluZyBhcHBsaWNhdGlvbiBhbmQgeW91IGFyZW4ndCBpbnRlcmVzdGVkIApp
biBzdGFydHVwIHRpbWUgcGVyZm9ybWFuY2UgYnV0IG1vcmUgY29uY3JldGVseSB0aGUgaW1wYWN0
IG9mIHRoZSBzdGF0aWMgCmluc3RydW1lbnRhdGlvbiBvbiBvbmUgb2YgeW91ciBob3QgcGF0aHMu
CgpJZiB5b3UncmUgbm90IHN1cmUgd2hhdCBraW5kIG9mIHRyYWNpbmcgc2V0dXBzIHdvcmsgYmVz
dCBpbiB5b3VyIGNhc2UsIApvciB3b3VsZCBsaWtlIHVzIHRvIGNoYXJhY3Rlcml6ZSBhdCBjZXJ0
YWluIGFzcGVjdCBvZiB0aGUgdG9vbC1zZXQncyAKcGVyZm9ybWFuY2UsIEVmZmljaU9TWzRdIG9m
ZmVycyBjb25zdWx0YXRpb24gYW5kIHN1cHBvcnQgZm9yIAppbnN0cnVtZW50YXRpb24gYW5kIHBl
cmZvcm1hbmNlIGluIGFwcGxpY2F0aW9ucy4KCj4gSSBoYXZlIGNvbWUgYWNyb3NzwqB0aGUgbHR0
bmcvbHR0bmctdXN0LWJlbmNobWFya3MgKGdpdGh1Yi5jb20pIAo+IDxodHRwczovL2dpdGh1Yi5j
b20vbHR0bmcvbHR0bmctdXN0LWJlbmNobWFya3M+wqByZXBvc2l0b3J5IHdoaWNoIGhhcyBubyAK
PiBkb2N1bWVudGF0aW9uwqBvbiBob3cgdG8gcnVuIGl0LCBhcGFydCBmcm9tIG9uZSBjb21taXQg
bWVzc2FnZSBvbiBob3cgdG8gCj4gcnVuIHRoZSBiZW5jaG1hcmsgc2NyaXB0Lgo+IAoKVG8gcnVu
IHRob3NlIGJlbmNobWFya3Mgd2hlbiB5b3UgaGF2ZSBiYWJlbHRyYWNlMiwgbHR0bmctdG9vbHMs
IHVyY3UsIApsdHRuZy11c3QsIGFuZCBvcHRpb25hbCBsdHRuZy1tb2R1bGVzIGluc3RhbGxlZDoK
CmBgYAokIG1ha2UKJCBweXRob24zIC4vYmVuY2htYXJrLnB5CmBgYAoKVGhpcyBzaG91bGQgcHJv
ZHVjZSBhIGZpbGUsIGBiZW5jaG1hcmtzLmpzb25gCgpZb3UgY2FuIGFsc28gaW5zcGVjdCBob3cg
dGhlIENJIGpvYiBydW5zIGl0OiAKaHR0cHM6Ly9jaS5sdHRuZy5vcmcvdmlldy9MVFRuZy11c3Qv
am9iL2x0dG5nLXVzdC1iZW5jaG1hcmtzX21hc3Rlcl9saW51eGJ1aWxkLwoKPiBBbnkgaGVscCBp
cyByZWFsbHkgYXBwcmVjaWF0ZWQuIFRoYW5rIHlvdS4KPiAKPiBSZWdhcmRzLAo+IEFkaXR5YQo+
IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gbHR0
bmctZGV2IG1haWxpbmcgbGlzdAo+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBodHRwczov
L2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2CgpbMV06
IApodHRwczovL3RyYWNpbmdzdW1taXQub3JnL3RzLzIwMjIvZmlsZXMvVHJhY2luZ19TdW1taXRf
MjAyMi1MVFRuZ19CZXlvbmRfUmluZy1CdWZmZXJfQmFzZWRfVHJhY2luZ19KZXJlbWllX0dhbGFy
bmVhdV8ucGRmClsyXTogaHR0cHM6Ly9naXRodWIuY29tL2pnYWxhci9MaW51eENvbjIwMjItQmVu
Y2htYXJrcwpbM106IGh0dHBzOi8vd3d3LmRvcnNhbC5wb2x5bXRsLmNhL2ZpbGVzL3B1YmxpY2F0
aW9ucy9kZXNub3llcnMucGRmCls0XTogaHR0cHM6Ly93d3cuZWZmaWNpb3MuY29tL2NvbnRhY3Qv
Cgp0aGFua3MsCmtpZW5hbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcK
aHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRl
dgo=
