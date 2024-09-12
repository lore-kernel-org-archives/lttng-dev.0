Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DA6EE645B
	for <lttng-dev@archiver.kernel.org>; Thu, 12 Sep 2024 07:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1726127869;
	bh=jb63nlis6Gyu+QWWHH3eSscxAjeO7H0WF/YgftLXdzo=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=b+fVd5vpIIc3TR5dKul7e00lbEo1kYDaTe7kme99mTwtOQLiT5P215e7zx3stRkiO
	 SGeyX4p/L6MqS2X5/kEGt9emy6+Zw/z7pgOGPAdsgA3f038GtgiPZydQCtqsrkEmV+
	 gEN7RohniIq7f/FIKMdlP1e/NMw0nr9281SyHmtDT7T0B1HvJhKCBXvRssBpxPqxPs
	 pUMv2nf+yQ87yE+INjf0glgFf9PsvvjUMGVvpbpNtREfIe+VU8vnlsLWQO2Texspwu
	 3bVBxBNM8oj/YOXBRUD0/latYo1feEduI1tq0AZEOciXxK+ANzGlOdg9gtj6JO3gL1
	 eJYuyBKGfrQtg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4X48th1T32z1Gc2;
	Thu, 12 Sep 2024 03:57:48 -0400 (EDT)
Received: from YT3PR01CU008.outbound.protection.outlook.com
 (mail-canadacentralazon11020105.outbound.protection.outlook.com
 [52.101.189.105])
 by lists.lttng.org (Postfix) with ESMTPS id 4X48tc6S07z1Gc0
 for <lttng-dev@lists.lttng.org>; Thu, 12 Sep 2024 03:57:44 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LH+2yuf2RTbA1u4vNk5oDXvFCxYp/rimPpVvXe6K2Cftp8mtu2h4WiqFAJJtVTgUE+HFDJjkthpbCOiWQThQaeNhZBB+9uvzwr8A/idj8ESTWuw1lwY/WOlDCv/tlKcSiU/c2hfj2p8bcTMN04pNuDhLgr/rI5JODYB3COFj14faZt5MX3SPNiJ5JfyPrEmdSIHNKNlPtBT2mB8BzME03CGcaYBOCsPcOuRAbao9GvrylWFOMnpSMkK3srmMUYf/9LwBj1pV8LX9JlZJrsGIgM4Sx4tRosbAsQrHvN8U5JqfvwH/PpsK+nu2QF+eNfVdR95UkGakg0tlRGHWqqcZhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y04np6dTol74H+YuVJGKkH3VrHjQYWuRK1owQxkAIOs=;
 b=R7OX2qBodXPczHPIUzzVaGs2qk0jJLb9Fy73X2oYgbQOlR13tj7pxuqQHkzuUnhP+4KTjtEpXJAua5h83tjRtZv6JeDN5bl/dUY9nISCo+rFeMCH4GRw6WoP6Rfc4j2TA9dovYULNAl14K3hA3o+1+y0txLCqHmRdF2hqxdLKPvgIoyhiudbjvUFuzpq7sYjmeb0W0/VDp+8DISd8b7egVPWa4ihHoYd6XbPLKbING3poKyR/RlXGLxrskM7zVVDH9DWT2SG+PRi1wGpAq9M7eLYOpqQKdPGKww77V5ooosps2dt/4zwhQW1cWFgvNlJQQUwWOMXSlfX+MXfaLrr3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT3PR01MB9785.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:8a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Thu, 12 Sep
 2024 07:57:41 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%5]) with mapi id 15.20.7939.022; Thu, 12 Sep 2024
 07:57:41 +0000
Message-ID: <39b62cc1-66e1-4962-a3a8-0d3ad6e151ef@efficios.com>
Date: Thu, 12 Sep 2024 03:57:33 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Damien Berget <damien.berget@flyzipline.com>, lttng-dev@lists.lttng.org
References: <CAA1MA5f3JY7WCZbgKaC2gjagDY-eVdssg_iWEiWtop3zZM7WJQ@mail.gmail.com>
In-Reply-To: <CAA1MA5f3JY7WCZbgKaC2gjagDY-eVdssg_iWEiWtop3zZM7WJQ@mail.gmail.com>
X-ClientProxiedBy: YQBPR0101CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::41) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT3PR01MB9785:EE_
X-MS-Office365-Filtering-Correlation-Id: 609a7813-754d-4b9c-3762-08dcd30093a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjRKYVNwcEFVd2E0S2p5TExISWdRZ2FLazlUMit3V1hYMWpFbkh0cjg0RGZV?=
 =?utf-8?B?NFp6YXZQSkszbjhhOU8wVVYwTm03SDYyb1pYN0thRFJvS0YvVk1Xc2pkVEVM?=
 =?utf-8?B?czBoVXdNZE92WG1JQXYvT3NQL2xBZDRBSUtQMm9hQ2tKb0h6WkRwYXltZDFv?=
 =?utf-8?B?ZHplV1RUOGlWRGpwYnR3UmpBWklra2FjdUFGQlhzTjU0RC9Sdlc3Vy9TSDBi?=
 =?utf-8?B?SFhaeHpEMEVObndldEJXdkw0c2hJOU9qQVptc0JyRnEzR3c0VGgxR255VG96?=
 =?utf-8?B?M2RkTExpRExvN3gvYVFBYjJxd3kvYmJLSG9SdGEyWVptYVc1TkJ4TWdtcncv?=
 =?utf-8?B?ZWNtV3FVYlE2UHQxL2h4c1VrWlUzaUVteUI1dS9SZTc2U0poMnBjZkEyQXpS?=
 =?utf-8?B?MkNRSFBuN2VKemNrS3Zqb29zT1pWTTBuMW02dFduZ2Npek42OVNjS1RQZXFX?=
 =?utf-8?B?NGp3c0w2ZGpHaHRaTFFHQkxkNkhaM252YU1LQXp0YlNtdkl1MEMraDI3b1BJ?=
 =?utf-8?B?NHdoWUZQMFlXdHN6SG9yd2JMeVlxUWNRcmczaHlqUWkraWVpOVd6RkE5TWFj?=
 =?utf-8?B?UGVsMEZ1VUdiek5oREp3VkNOaTNnL2hvYmR0K1g2WUNzb0d0eUdWR0xIUzl3?=
 =?utf-8?B?L05ZK2pIQVdUS2dtcTVmcGUrZ0J6ampYQnRsRVkxNGx4TWx3NW5qazNqY3lT?=
 =?utf-8?B?Y0xsaWRvZEo0WWhkbWpFb0hPczdkeG1VWHhDODlsRjdwL0x2ZUFhT2xPNEtP?=
 =?utf-8?B?SzBrazk5OXpqVlFFT294Q1djMFgyVDI1Zm1DRXc4OHo0Q2Y5aTNQWVhvV0E4?=
 =?utf-8?B?VVJIZUcrZHA4V1RiRm9HMTJIZkgxNlE0T3lrUERReUQ0U2w4N0s2MVRQNXp6?=
 =?utf-8?B?b3JJVDNzSno2eFRxdmNValo0U1RSRGNBbkNXdi9DQVdGQVNVS3poNkN2eWdF?=
 =?utf-8?B?RHl4QzJvU0ZteFBLOWQ2NjdLaE5wdHkyRi9pVVN2N0xneWpMdXpVWkVFOTNC?=
 =?utf-8?B?Q2IwejVRQWt2M0FnSWo0Q05mRnpWSmtkbWtKTDU0NjNnYTJKMFBkWk93Y1JC?=
 =?utf-8?B?NHVwQ3VrbmZmcWgzWWlPOWpsNllucmgyOGFCVmNYNHVEY1lzT1lQV1JGelps?=
 =?utf-8?B?KzZFTSs2eFJPN1FRamE1U3Y5eDhKdGNZUzltRFBBOENLZU5QeXo0T0FQVTVZ?=
 =?utf-8?B?ZmR1VjRndTZocHZvZW04TjJObUo2cUV3NUN1YUNLTGphTDNHMFJ0c0RFaStX?=
 =?utf-8?B?QzFmRWRtVDBrNE1xaHdXcEN6RGtERDZyZjdpVHU2VS81YVVvcGZXTDZRRUxv?=
 =?utf-8?B?VGdwQWtFYjZRQTZLcEFOcEs1YnpSeER5VHBRTVRhSFVRdUxwaVlIRC9wcmxK?=
 =?utf-8?B?TG1NS09PVDFlOGdOaURUYkJPc0s3UFFPbTRUZTdMTVBJQVl0alZtMFdidld5?=
 =?utf-8?B?THNXOXpPbVVNNDJSY3VRc3lrTVZKeEZuVStkOC95Vnp6SVJrWFJNNlk3ekVh?=
 =?utf-8?B?U2o3NHppVnBWaUhuT2JQZ3FVc1NlTDllSVZjbkVrL3BkYTVNMnFDZXg1Qzlv?=
 =?utf-8?B?Z09XaEQ2OVZKMjQvK251akhLY2hzMkNOZ0UyNkZuQm9oYVpsQmJwS2taeVl6?=
 =?utf-8?B?Vno5NS9sSEVLNFVOM09JeXQ5Q1Q2WXIyN3Vsa29oc0dHOGJDc0lXWGg2dWZX?=
 =?utf-8?B?R01NWlI2TVp2NXlnTFdJOFVrUWpLQXNiZWxTUVN2ZTZacWlkemFJc0NYMGJH?=
 =?utf-8?Q?iLBGA3Wr2E2TwrjQNw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NitnNWx3dHIxWGFwSXZ6SHRoMlhGR0lLZnZNVkpVdFhyMkNvWXpDNGxPTXNP?=
 =?utf-8?B?YitwYU1MRzlUUzB5TytWK3h2M3Q4dXZBbmNZQlQrekFHV042d3VPYzdRUmlt?=
 =?utf-8?B?RVovdUlsZ1VTLzlPaDFEWHRBN2VTbCsyczF4bE9FWkFZUi80cjNaV21qYzUy?=
 =?utf-8?B?WmFDd2tYVkowNmFOeEJCaWhDcHU4aDhRMVRFWVptMHFVSnNKZVg1S0RzckRQ?=
 =?utf-8?B?NTF4M2daOWFjaHZzaXNYRUx0VWRSeWRWOGt3OEkwMVFybEpMSmgwSTBzQnNq?=
 =?utf-8?B?bEVITEgwTzJFbVZ1M2V4R2hLbG9Md0R0MG1la3ZwSUUwcDEyT0l0RmxkbjQ1?=
 =?utf-8?B?dFZFb3JEaDFyZkRHWG1UR0VoU1lYQnVQSTVHN3FTQVJWUEtuWllDK2dZWnFU?=
 =?utf-8?B?Q0EvNU9za0d2T204TlRWcFJtaVN4K3BoRGhlcDRtdElxNXZ3bks5Q3NBNnMw?=
 =?utf-8?B?VUZBZDNnZnFabG1Na3BOaEJzalZMZUUxMG5tckhHZ3BvZmtCTFNzOC8xZkZy?=
 =?utf-8?B?M294UFFCejRWZGd2VVlqd1VKYm9tWVlJTHFKSVJoYzhuMk9JQ0V2Y0FVbWRy?=
 =?utf-8?B?VkZQODA1ejNUcmhjQVFxMlhkSUtzb3VsL3gvb0U1Zm5JbjZ1VkVyWmNpc1ZR?=
 =?utf-8?B?NGxtNDk3SDhSR0IzU0NoLy9wU2lWQlRrLzVRRDdUTDg2ck1wSHp1S3k3bGFl?=
 =?utf-8?B?YmpuYVlucHl3Wkl5enRaZzhPeDJ1QjVJRU9MKzFMa0dpSVJHMFd4bThmdy80?=
 =?utf-8?B?N3Z5L0crcE01UWhyRmE1ZjlOakluRndIcjF4a3p4QW5iMGpKQXBQYVlvTk5n?=
 =?utf-8?B?ekhzY1dZRnUvelo3WWg2RUVBWmVxTGt4ZTlWSWtjSGU5ZW5zK2JzWG9paXpL?=
 =?utf-8?B?dFJ6cWhRYkVSWU5hekhvM2R1VnF5cmFnTy9VU05YL2J4MEVOQUc4ODJyclpn?=
 =?utf-8?B?UjR5ZFh4SktCT2g3UUhpS1VENkxtbDFFbTVoWVU4aU1rL1U1ODBtV3ZDcC9q?=
 =?utf-8?B?UVZjOTBJOXoycXNvUEh4Y20xdWY4bTFJSkEyUFhpNU1rWEZaK0pnZFBBR3Zy?=
 =?utf-8?B?aE1EdkdlazlJQVMzd09xSStLYWlMU0IxMFlhWGU4WXpIaXFWb01zRmxtcDdZ?=
 =?utf-8?B?eTV1QVdQMWRPU2FyVjBhbXREKzJqSnVCbFZuMTN0UVduT1JRSW12aUgvUWlu?=
 =?utf-8?B?SS9sbEJiUjJqS1RJQkxNMmdzY0hEaXo0U3V5c3ZvMFRhNHlsanFvYUFDUm5L?=
 =?utf-8?B?aHozSHpyOTNmMmVFSVRhcVZhMUFyVExrYWxEYVNkcEZNdUFZamNFeUZndkFZ?=
 =?utf-8?B?cldCamdlNjZNY2dUcFBaa0J5RVNjQVpER0gxQ25TRWI0enVnUFUybVhSa0VQ?=
 =?utf-8?B?SGZSSDRrSTdTRjN5YS82ekp1TUF4bHZ2SDRhLzY5NEZTZ2lzaFIvV29Ldm1C?=
 =?utf-8?B?MGRjNnEvNE1XTnRqaGZiTzV5MDc5TmtMMVdXem5zTk9hOGZJYkZ3TzNzdFlh?=
 =?utf-8?B?RDlrVUFXOU53YVJwdUhZNlE2Z3RzTDBBU0xnd01hbkdnRjh0eTRHM0plRU00?=
 =?utf-8?B?aGJnaFU2R1FpRGFjZHl1TkNMczRKMzJWWTdoV0U1b3pWVlVrOFYreXJMbVl1?=
 =?utf-8?B?T1lrczhLMmcrNUhYOHRCVE5xQjlJazVWVUpiWHRWSkp0UDI3MGdUNmUwa3Zk?=
 =?utf-8?B?ZndKUkY4Z3kyVW1IeEk0WTlQY0lCYkYxMEZoaVhnTU9Ocm5rd01MenorNXVl?=
 =?utf-8?B?N3JQWmRuYlJ0U0J4QXBaMWc3OWlFRndtQjRKY1pvL0lCcFJQYkdvOGhETXl4?=
 =?utf-8?B?SU1CSERoQThOd1lTNnNzTGpuNlozbVNQZ0wwUVNVTjBuL25IaWx2eHNZOXlm?=
 =?utf-8?B?c05LMTJLelZXU2IxOWhNd0t3bE5jY0EwTHFiR1hVUUpoYSsrejZ1bUZRMDVi?=
 =?utf-8?B?U0hpelRvSGoyKzRYcWFwcUpqL1BzSHVlOFVYbkh6ZCsyTm9PWk9BUW5ITW0w?=
 =?utf-8?B?TkpjdVNxZ0pKc2ZISFhxV0JUTzFkWE5MdWIyZGZJU1hKTEozWHVMOUh5QnQ3?=
 =?utf-8?B?S01zditPL1RsM0hpSGdvOXVvRVNKbFVUdVlmejgyZ0JEWnRNbFdsY1A4MG5Z?=
 =?utf-8?Q?GwEyp9L5o96fBKiXVWXAoit9l?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 609a7813-754d-4b9c-3762-08dcd30093a5
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 07:57:41.3411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APUB9hyE15bhXD044W34/nChjTTZIUmv5PQOx2lTQi3QHr9bVGRIIFC9Vycy8KDCddvKS0It7ejxIj94BrJPRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9785
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

SGkgRGFtaWVuLAoKT24gMjAyNC0wOS0xMSAxODozOCwgRGFtaWVuIEJlcmdldCB2aWEgbHR0bmct
ZGV2IHdyb3RlOgo+IEdvb2QgZGF5LAo+IFdlIGFyZSB0cnlpbmcgdG8gc2VlIHdoYXQgaXQgdGhl
IGJlc3Qgd2F5IHRvIG1vbml0b3Igc29tZSBhcHBsaWNhdGlvbnMgCj4gbm90IGhpdHRpbmcgYSBk
ZWFkbGluZS4gSWRlYWxseSBzb21ldGhpbmcgbGlrZSBhIHdhdGNoZG9nIHRoYXQgbmVlZHMgCj4g
dG8gYmUgcGF0IHJlZ3VsYXJseSBhbmQgaWYgdGltZW91dCBpcyByZWFjaGVkIHRyaWdnZXJzIHRo
ZSBzbmFwc2hvdC4KPgo+IEJlZm9yZSB3ZSByZWludmVudCB0aGUgd2hlZWwgYW5kIGNvZGUgc29t
ZSB1c2VybGFuZCBhcHBsaWNhdGlvbnMsIGlzIAo+IHRoZXJlIGEgY2Fub25pY2FsIHdheSBpbiBM
VFRuZyB0byBkbyBpdD8gSSBmb3VuZCB0aGlzIAo+IDxodHRwczovL3Jldmlldy5sdHRuZy5vcmcv
Yy9sdHRuZy10b29scy8rLzk2NTcvOT7CoHRoYXQgaXMgc3VzcGljaW91c2x5IAo+IGNsb3NlIG1h
eWJlPwo+CkkgZG9uJ3QgdGhpbmsgdGhlIHRoZSBwcm9wb3NlZCBjaGFuZ2VzIHlvdSBsaW5rZWQg
dG8gYXJlIHVzZWZ1bCBvciAKcmVsYXRlZCB0byB3aGF0IHlvdSBob3BlIHRvIGFjaGlldmUuIFRo
ZSBwYXRjaCBzZXJpZXMgaXMgYSBjb25jZXB0IGFib3V0IApob3cgc29tZSB0eXBlcyBvZiBVU1Qg
cmluZyBidWZmZXIgc3RhbGxzIG1pZ2h0IGJlIGFkZHJlc3NlZCBieSB0aGUgCnNlc3Npb24gZGFl
bW9uLiBBZnRlciBhIHF1aWNrIGdsYW5jZSwgdGhlIG1vbml0b3Jpbmcgc2VlbXMgdG8gYmUgbW9y
ZSAKY2xvc2VseSByZWxhdGVkIHRvIHRoZSAnbW9uaXRvciB0aW1lcicsIHdoaWNoIGlzIHVzZWQg
dG8gc2FtcGxlIApzdGF0aXN0aWNhbCBpbmZvcm1hdGlvbiBjaGFubmVsc1sxXS4KCgpUaGVyZSBp
cyBhIGNvbmNlcHQgb2YgdHJpZ2dlcnNbMl07IGhvd2V2ZXIgdHJpZ2dlcnMgcmVhY3QgdG8gdGhl
IApwcmVzZW5jZSBvZiBldmVudHMgcmF0aGVyIHRoYW4gdGhlIGFic2VuY2UgdGhlcmVvZi4KCgpJ
IHRoaW5rIGEgc21hbGwgdXNlciBzcGFjZSBhcHBsaWNhdGlvbiB0aGF0IG1vbml0b3JzIHRoZSBz
dGF0ZSBvZiBvdGhlciAKYXBwbGljYXRpb25zIGlzIG1vcmUgdGhlIGRpcmVjdGlvbiB0byBoZWFk
IGluLiBUaGVyZSdzIGF0IGxlYXN0IG9mIApjb3VwbGUgb2Ygd2F5cyB0aGF0IGEgc25hcHNob3Qg
b24gdW5oZWFsdGh5IHN0YXRlIGNvdWxkIGJlIGFjaGlldmVkOgoKCiogVXNlIGxpYmx0dG5nLWN0
bCB0byB0cmlnZ2VyIGEgc25hcHNob3QgZnJvbSB5b3VyIHdhdGNoZG9nIAphcHBsaWNhdGlvblsz
XVs0XS4KCiogSGF2ZSB0aGUgd2F0Y2hkb2cgYXBwbGljYXRpb24gZXhlYyBgbHR0bmcgc25hcHNo
b3QgcmVjb3JkYFs1XS4KCiogSGF2ZSB0aGUgd2F0Y2hkb2cgYXBwbGljYXRpb24gZW1pdCBzb21l
IHNvcnQgb2YgImhlYWx0aCBzdGF0ZSIgZXZlbnRzIAp3aXRoIHNvbWUgZGF0YSAoZS5nLiBoZWFs
dGhfb2theSwgaGVhbHRoX2JhZCwgLi4uKSBwZXIgeW91ciB1c2FnZSAKcmVxdWlyZW1lbnRzLCBh
bmQgY29uZmlndXJlIGEgdHJpZ2dlclsyXSB0byB0YWtlIGEgc25hcHNob3Qgb24gdGhlIAoiaGVh
bHRoIHN0YXRlIiBldmVudHMgdGhhdCBoYXZlIHRoZSBub24tb2theSBzdGF0ZS4KCgpEZXBlbmRp
bmcgb24geW91ciB0cmFjaW5nIGNvbmZpZ3VyYXRpb24gLSBjaGFubmVsIG92ZXJ3cml0ZS9kaXNj
YXJkIAptb2RlWzZdLCBidWZmZXIgc2l6ZXMsIGJsb2NraW5nIG1vZGUsIGFuZCBudW1iZXIgb2Yg
ZXZlbnRzIGl0IGlzIApwb3NzaWJsZSB0aGF0IGV2ZW50cyBtYXkgbm90IGJlIHJlY29yZGVkLiBJ
IHdvdWxkIHByaXZpbGVnZSB1c2luZyAKbGlibHR0bmctY3RsIG9yIGV4ZWMnaW5nIGBsdHRuZyBz
bmFwc2hvcnQgcmVjb3JkYCBpZiB5b3Ugd2FudCBhIHN0cm9uZ2VyIApndWFyYW50ZWUgdGhhdCB5
b3VyIHdhdGNoZG9nIHdpbGwgY2F1c2UgYSBzbmFwc2hvdCB0byBiZSB0YWtlbi4KCgpJIHdvdWxk
IGxvdmUgdG8gaGVhciBpZiB0aGVyZSBhcmUgb3RoZXIgaWRlYXMuIFJlZ2FyZGxlc3MsIGhvcGUg
dGhpcyBoZWxwcyEKCgp0aGFua3MsCgpraWVuYW4KCgpbMV06IGh0dHBzOi8vbHR0bmcub3JnL2Rv
Y3MvdjIuMTMvI2RvYy1jaGFubmVsLXRpbWVycwoKWzJdOsKgIGh0dHBzOi8vbHR0bmcub3JnL2Rv
Y3MvdjIuMTMvI2RvYy10cmlnZ2VyCgpbM106wqAgaHR0cHM6Ly9sdHRuZy5vcmcvZG9jcy92Mi4x
My8jZG9jLWxpYmx0dG5nLWN0bC1sdHRuZwoKWzRdOiBodHRwczovL2dpdGh1Yi5jb20vbHR0bmcv
bHR0bmctdG9vbHMvdHJlZS9tYXN0ZXIvc3JjL2xpYi9sdHRuZy1jdGwKCls1XTogaHR0cHM6Ly9s
dHRuZy5vcmcvbWFuLzEvbHR0bmctc25hcHNob3QvdjIuMTMvCgpbNl06IApodHRwczovL2x0dG5n
Lm9yZy9kb2NzL3YyLjEzLyNkb2MtY2hhbm5lbC1vdmVyd3JpdGUtbW9kZS12cy1kaXNjYXJkLW1v
ZGUKCgo+IFRoYW5rcywKPiBDaGVlcnMKPgo+IC0tIAo+ICpEYW1pZW4gQmVyZ2V0Kgo+IEVtYmVk
ZGVkIFBsYXRmb3JtIExlYWQKPiBkYW1pZW4uYmVyZ2V0QGZseXppcGxpbmUuY29tCj4KPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGx0dG5nLWRldiBt
YWlsaW5nIGxpc3QKPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4gaHR0cHM6Ly9saXN0cy5s
dHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0
Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJp
bi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
