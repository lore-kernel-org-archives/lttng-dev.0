Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871D5C02182
	for <lttng-dev@archiver.kernel.org>; Thu, 23 Jan 2025 04:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1737607510;
	bh=tTUf4IMIm+Brs77+hG6s1yKFokJ1jy3ioWzk23dQcCA=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=m6kbl3QvnaS05/k8l5zNKD7vlbaE0DAHQVMs99D3B80gZw81h/QNp6qTZYHDHtV74
	 VrGVtL8Y/mjI6lrkQJATTV+XEdDDyy6M2AL/waCY2xQDI8tXKNJrM2MOXFgy5AAMRj
	 htYnHdLOYp5UG1rxMOM3A0Pp4hK2PeMycHSyApFsHzcxWubREn1QlbBNx37ULn6Bss
	 F2LYuXMIp2ZdJZNWJdxey0Lzgx0WPlbFDY+25uthAf+PAn9bxEvIU4PGJSBi12rKHU
	 JKQ/fpL7dcAyJbMtnPfDKQZ+yMW8ygrmGIRVRq/JIIAQWUuQwdva4jq9IvRZ/x7aHp
	 rg/XoKfoJ9eTA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4YdpK16d4wz1FKK;
	Wed, 22 Jan 2025 23:45:09 -0500 (EST)
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazon11020135.outbound.protection.outlook.com
 [52.101.191.135])
 by lists.lttng.org (Postfix) with ESMTPS id 4YdpK121H1z1DxR
 for <lttng-dev@lists.lttng.org>; Wed, 22 Jan 2025 23:45:09 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CE8d2PFDgMfBkakJoCE42aijskpIgRj0WCDIRIwuIMJMjrH3es72XixWvZhWDMYYF7rUvQuJShDvP5/MC85zzIIN5sIH8NjDCKuze6avCKvNOSEHblRkmbsfNvlhdSV3dpSbVfCx3hQ4V0KMNQJPLvzeHMFzamYJLu+A9jjhZrlHDV70IowWbtfyJPuzcyX6qJwudO57GiRVGzE6IwR9ri90TDDx9bnC4+vlhnHFmbpxJGdhyw+3PqJgstI2vGGCWnLmLc+h1+7oPnnDkDLm14biJp3Dg9P1MBfjr9pcv9fI+xLR3n/65zUxmnhj7qX+Z06HHl28ChOAUI8VxvYkWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFNBJIi3rKqqKiSV3Es83CaXZiCY/1AxDOlnpv+8eZg=;
 b=ZaliAtkxl4BAT0/VSK5pInYmyEZgOGqn92IqZJ+svjmb8A0DqT9SIua8qta7owu32pDcNK9WmveUJUfE8GWzlBkuSbAkqJLeyCnmkEZjDgim4zUAjMkbq1RdYxGeT9pM4M6FYVnnqzXRrwDuMM3RAEr2L2RsNsJnHASzp6ncylZVD1FeMPQkZZts2Et+s9QAv2B/NarDBQvQxRxmLwt2wfRASmVkYiyqyw/ScJhLXT2Fw4roiaO0EJ728dTPeMe60fx3Odu9W1ltEnFowVRxm8/SWvRpe9RqvVMgV3XyhBL1Kr89Cy82caT+CYvJ+ZhhrmPrg7I5X32SPPKA5Ssjdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:104::10) by YT2PR01MB9015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Thu, 23 Jan
 2025 04:45:07 +0000
Received: from YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5de4:ebdb:2bf6:ee1]) by YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5de4:ebdb:2bf6:ee1%4]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 04:45:06 +0000
Date: Wed, 22 Jan 2025 23:45:05 -0500
To: lttng-dev@lists.lttng.org
Cc: lwn@lwn.net, linux-trace-users@vger.kernel.org,
 diamon-discuss@lists.linuxfoundation.org
Subject: [RELEASE] Babeltrace 2.1.0
Message-ID: <Z5HJUQn44y1CdS7M@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::21) To YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:104::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10709:EE_|YT2PR01MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba9ffe2-9bec-4f6e-5f57-08dd3b68b5a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3cza0QzcEpXaVlxUDdOVHJzeENCY1ZFWkozbm5BamY2ekIvdnZkbHJZb29x?=
 =?utf-8?B?TGRvdTlMYzRISVRUTkxsL1JvbTlFbThCTEd1TUliUlpYcytYdEp1ZDc2N3B6?=
 =?utf-8?B?aVZsckZWL3k1Y2l3dVdPazZJYzdNMmpRc3NjSk83MzlPMzdGM2tTMGFBVzRj?=
 =?utf-8?B?ZFZMZFZybDd1VVYzZ1hiMWh2UWtBNkt3clU1MW15Uno4NzB2RzZ2Z2VhRGJp?=
 =?utf-8?B?Q1RBUUJaNjQ3bmdrWDgyeWRMN0ZQVFhqSmQ0TENsNnE5ZzErRnQrZVdaaTA4?=
 =?utf-8?B?Q2tSbmFVVm8rdG5sbVYvby9LUXphSzB3VDhJeURUQmFhWUx3TFU2R0Y4Vkcz?=
 =?utf-8?B?M0hkcXJtaUVocEF2R3FCN3pMRDVoTndkNHV0MDNKcmxNYmpIczZmTUtOWXV3?=
 =?utf-8?B?Ky96V0txQzRVRE9WTWFFMUREdnFqU052K0pTc3dXTk51ZHByeWJPK1B4V29D?=
 =?utf-8?B?SEFIV1ByT0dwcTlLeVVUNW94S0xKcjdVNktYUFhmdDIyTllxYkR0elFLczlW?=
 =?utf-8?B?ck92MnVmK2IvSFNTR0ZNWkcwWXpEcmlJMGxnemVFcHdOZk1xeXJld3Y2RWpy?=
 =?utf-8?B?UkxmTVNIZGZNWVMzREpIbS9CT05UQWVkOTRIM0dHYkdaTkg3elJCUXhaeUNj?=
 =?utf-8?B?cDV2VlZlcEh6RmhGei9zVnlMUmczSFB6TXIvdGR2allreWE4Q1BzdmROWVF1?=
 =?utf-8?B?WmdYZjh6dlFTQWdOa1F3QitiaHEyQktyRytIdWordFRmaG5OV3RZVWJCOGFZ?=
 =?utf-8?B?OHlOZ3pLYVJkN0NIaE1MQWdxNUlCeDA0QmdYaTQ2emx0RlMzbkNMb2FrQ1Yy?=
 =?utf-8?B?OTVsNXh5b1piZFkrUzcwQXI0cnpWNy9sSzdFZmlSWjNDdHE4d2pMdFFHRldX?=
 =?utf-8?B?bGhKcXJReVpmUjRmTExEY0llbUtpL2lmQzNwYldoTjdDK2daUkpsSzdPWDdj?=
 =?utf-8?B?TDBRd0ptdjkxcnNUcDNZQ20xQnhLQnYxZDdGR253aTZYLytBbmtCa2hhM2VL?=
 =?utf-8?B?LzN2UWpOaGVMQ3FFZksrOE1sRDBPbG01NVNTekVCWVZQWW56MXFPNjhDMXhN?=
 =?utf-8?B?eCt1alpmYktOMnAwV3A4RnViT0V3Nlk2cDBuVm5kNkdVSTZBcGlNOVlHdktU?=
 =?utf-8?B?ZmVlWUw0K0kvMktHeGZwc3ppQlcrSHd5aUdZU0ExT1JZU3FUTStXdDhFOGt0?=
 =?utf-8?B?eGZWYURHazlWRERYMCtOekh6ckJUbGx5OTZwcDk2VGE3MFoweUtFT1FRaThs?=
 =?utf-8?B?eFJ2SUVxdWkyMUhXNUdFMG00Q2dDQmMvZUlnZjI0MWFhSjBGZW1FdmErM1pm?=
 =?utf-8?B?aXViOWNKeUFQVU9lTVV3QVNLUnk0cmxDWWc5eENBSVZjaEZMZ29lNFJpLzRO?=
 =?utf-8?B?ZnFEWEVvQTBkNnkvcUE0QzNDL0Y0bDJEY3lyR1ZDZGRHS01NaU5iRVZKZTY1?=
 =?utf-8?B?SlRtR1JZeFdaZ1BtRHZodkFOazFtSXR5bGh4Z3V6czZkcXpoZGcydElxNWhU?=
 =?utf-8?B?ZUtoYmcrelg4NnJJV0IrQ0xpbWozZXhraU1SRXFuZ09Yb1drOU93aGVjYjhU?=
 =?utf-8?B?Nk5hREFVbEt0Y1k3YXd4RWcxU2hwa0NOK2JVL2dTQ2lRaFZEbTJMZjNIMnk0?=
 =?utf-8?B?eFBwSkZBL1hEYUJCTU5qZUV1Y2VQWWp4aUZGc3JpVWxQalNqRGlDU3E2Vi9W?=
 =?utf-8?B?aStiY3Faa1pScEFXVUtVbVFqSFNFa0NaTGtTcmVFd05zV1RENjdmYlI3TkI5?=
 =?utf-8?B?akFsTFJzUXdueXhWY3hFYTlpS29vRTZVV3FMZ1lqb2ltZVBMK1JMaTd4WGcx?=
 =?utf-8?B?NlBMOGpHbFpGY2NSdjZodz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1ArM0t2ZTM3NDREWDNDT05lR3BEb3YxWUwwb3hKMHJyS2pKYS9LRVprRlAr?=
 =?utf-8?B?MFJtNmE2RU0wRXR6UlZmWE9nV0Y3R2x3RkdMTU9sd0ttRGswMlFuOVRXdDQ5?=
 =?utf-8?B?WWthSEVmZFJCRW9sck52d040U0p2cE1hcVZVeEp4YzZ4VExGeTh1M2VSY1Vu?=
 =?utf-8?B?K29wamhWb0xJT1F5eXFCK0h5SnIwNjBHU01pT2F1WVRoeWRuWGV1WW9UZkpV?=
 =?utf-8?B?NlZwMTJaVDhHLzZFcXN6dFQwOHlGbjlobnQzQmV2cHBhMEZ5K1hGdmV0cm1M?=
 =?utf-8?B?YTZqYVo4T0dqNENZZGZDY016Nmh4Rk85YVV5UjRWVTFKcm4wSjJPN093YzJq?=
 =?utf-8?B?U2U3UzFTZUdvMWhwSVFZMmNtdXp2VmRBVHMxQTlJRzUyVVIyaFNEZi9vbUJU?=
 =?utf-8?B?MFprdGZEWjFVbmdYYTBUOFFXaTB4MkpxcysrZlNGVmZXbU8vMnlNNGpxYmtY?=
 =?utf-8?B?TVUxbG9sZGkxbVZYd0ZSL2JNSG0xNVF5QU9wM3pKcXZJMi8zMTdxeWVsUkEv?=
 =?utf-8?B?Z0M3RHdzRjF5NW9qRlNnRE9lTVJRMGlMR1VIT2prVFRjMXJGc1RseG81NzJ2?=
 =?utf-8?B?bFNHNDUzZ3hGeEl1SGpUYXpsWmdVcEFERGNYcUxkbm1PcXk0NVZuWkFqMmpE?=
 =?utf-8?B?T1lYTGlUSThnODF4VklFZys2U0VXekEzSXZWNEN2eERxNXlXVlVibVdScW1x?=
 =?utf-8?B?ZmNZWnRiVEFOU0h1alVHQnhPR0w3RjlMV0NKc2ZCVnhMSXNXS2xEQTNtS0xD?=
 =?utf-8?B?VXh4dUVCQS96NmNQc0NUeXZPc3p3UjBLc2UxVStkL1dGdjgyaDhDVEpVbWFz?=
 =?utf-8?B?blM4M05OQy9WSUtlL0R5dlFKTmQ1VFpiZXRub28zSG92WHFZVE9tdk9GZWgw?=
 =?utf-8?B?dmhlVWtkUDRaZkV5d29aRUY3NXQwSDd2cTJwdm9ENGhRUU5FbTcwbkhLc1JR?=
 =?utf-8?B?MEgvMU1CeldFV3dIb1ZYYzFvZ0Y1U1RNM3pES2NWWklUU2x5cldBTno2anJx?=
 =?utf-8?B?b0VtelVHY1V3OVNneFJrMmZSdUliblQ2clVBRzRrUllxY0djYlo1WUtvV1or?=
 =?utf-8?B?d0pzRjJ5U2FGNVAwc0VnL0JNdjFGM3ZCNVRoMTNqRG5NYkhmZ21OSWphS1Fp?=
 =?utf-8?B?Y2J6d2Fjcmp4bHRHQXlVUnFYSG5KWThIaE1SOXcrVWRiZDNMNWdoQU1NTUgz?=
 =?utf-8?B?UUY2L1FDSWZjb2tYQjJROFpDa0FnUm00U3Y1VWJOQS9yNHVRSnJ2YkVwME9S?=
 =?utf-8?B?T3Fmek9VNmExcUVXRXlyUGxQRjNsQmY1cGtBVElLTHJ0aG1QOTkyVHh3bURm?=
 =?utf-8?B?WWFEYXN1K0xBMG9ralNYampXMWxhVjUrL2JPTDJQQkdFVHVoT0d5aUJMQmhj?=
 =?utf-8?B?aGhHSURIbTRDTzhvU21ENmZPRFNHcUdQeXIxWC9wUkVlcnZwQUt3dERRZzh0?=
 =?utf-8?B?djVVcXpZQyt6UCt5ZlVFczhYN3U0NVlvQUo5TldSbGJuMzVvbG9XT3pMMEYr?=
 =?utf-8?B?WEpydG9FR29Ga3E5OWlodmJncU9uUlNMbXUzMzkyL2t5U0ptSW9kTGVWdkJr?=
 =?utf-8?B?K0dUQkQ2NHZBcXUwREhaU3ZuUEl6ZFNyZVRjSU54blp2NklnckRNS2xRdHA3?=
 =?utf-8?B?WmRMb2hQbDlaRXYyMkl3NzVWOWxXKy9vaEFDYk80ZjJZQytnUW9ldFYxalJ1?=
 =?utf-8?B?T2xNUDBybFNTQ0I4aDhQZkpmejNIYnhqVjE3SkpXcDdYZndyMEd0dUtmQjJp?=
 =?utf-8?B?NkhlcW8wZW9DQlE0czBCZVNsV3Ryc1M2RmE3OWpyNEpmYUt6OUpFbkVpUWNx?=
 =?utf-8?B?SGx2bkNqamtEc0dBQmZYUzRjSjlsU1dndFNLTFRpME1YZFM0eldENElGUlNy?=
 =?utf-8?B?L2dWcDhSU25kSG13dVB6N3Z0Q1FKaU92SDNWL2lRczZrOUN1WWRmcEdmT09t?=
 =?utf-8?B?QVY3bWJBR05DSENkdGxJanRwMWp0MFMrWncvZGpuOERlR1dLMHhuL1o0aXAr?=
 =?utf-8?B?VDlNUCs1V2Z0dHkrbnZvNWR1S2pxeW4zMGNXQTFFbzJrUkVTZE1aV1kzRjNx?=
 =?utf-8?B?ckIwb3NnRk5VSE1KakFLQnlCdDZONVZzOCtIR3JWVkp4OEIxNVF5YUNWVnJY?=
 =?utf-8?Q?mMZkzNsOO9ZaLmJ8+kN1GFJkq?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba9ffe2-9bec-4f6e-5f57-08dd3b68b5a6
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 04:45:06.7937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abBLoJJcmoAgbQ9vbWbLWB2/L7nYqyAvKxi4cHald41UbbgVZSBSOWygdtgvOMrRIoHYp1f7r6vygAzQN5Zmew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9015
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
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi there!

Five years to the day [1] after launching Babeltrace 2.0 “Amqui”, we're
releasing Babeltrace 2.1 “Brossard”! 🎉

┌──────────────────────────────────────────────────────────────────────────────────┐
│ NOTE: An HTML version of those release notes is available here:                  │
│ <https://babeltrace.org/docs/release-notes/babeltrace-2.1.0-release-notes.html>. │
└──────────────────────────────────────────────────────────────────────────────────┘

BACKGROUND
━━━━━━━━━━
The DiaMon Workgroup [2] worked on the CTF 2 specification [3] from 2016
until its publication in March 2024.

CTF 2 is a major revision of CTF 1.8 [4], bringing many improvements,
such as:

• Using JSON text sequences [5] for the metadata stream.

• Simplifying the metadata stream.

• Adding new field classes (bit array, bit map, boolean, LEB128 [6],
  BLOB, and optional) and improving existing ones.

• Supporting UTF-16 and UTF-32 string fields.

• Using predefined roles instead of reserved structure member names to
  identify meaningful fields.

• Adding the attribute and extension features to extend and customize
  the format.

EfficiOS [7] is the primary organization driving the development of both
the LTTng [8] and Babeltrace projects. As of this date, the LTTng
project intends to add CTF 2 production support soon, potentially
enabling the addition of new features that aren't currently possible due
to the limitations of CTF 1.8. Consequently, it seemed important to us
that Babeltrace support this format and that it be released before any
tracer officially adopts CTF 2.

Although the visible impacts for CLI users are quite minimal, adding
CTF 2 support to the project required a significant amount of work on
the core library (libbabeltrace2) and, consequently, on all the
components of the project that depend on its C API, directly
or indirectly:

• The Python bindings API.
• All the official plugins, especially `ctf`.
• The command-line interface.

Of course, the documentation and testing of all those components were
also updated and improved.

WHAT'S NEW SINCE BABELTRACE 2.0?
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
See babeltrace2-intro(7) [9] to learn more about Babeltrace 2.

The following subsections list the user-visible changes.

Library
───────
• The most important change of libbabeltrace2 is the addition of a new
  Message Interchange Protocol (MIP) [10].

  libbabeltrace2 2.0 only offers MIP 0 which covers the message contents
  you're used to since 2020. Starting from Babeltrace 2.1, _MIP 1_ is
  available and adds many functions to support CTF 2 features. Moreover,
  MIP 1 introduces some important new concepts to the clock class [11]
  API, making some functions exclusive to either MIP 0 or MIP 1.

  In summary, the specific MIP 1 changes are:

  ‣ Clock class [11], event class [12], stream class [13], and
    trace [14] objects may have a namespace, a name, and a
    unique ID (UID) [15].

    The UUID property of clock class and trace objects is removed in
    favor of the new UID property.

  ‣ Important parts of the clock class API are changed.

  ‣ A bit array field class [16] may have flags [17].

  ‣ An integer field class [18] may have field value hints [19].

  ‣ There are new BLOB field classes [20] and fields [21].

  ‣ The field location [22] system replaces the field path [23] one.

  See the new “Add MIP 1 support to your component class” guide [24] to
  learn more about all the changes brought by MIP 1.

• Your component class must implement the “get supported MIP versions”
  method [25] to support MIP 1.

  This method remains optional: without it, the component class
  instances only support MIP 0.

• There are new MIP version access functions:

  ‣ bt_clock_class_get_graph_mip_version() [26]
  ‣ bt_field_class_get_graph_mip_version() [27]
  ‣ bt_trace_class_get_graph_mip_version() [28]
  ‣ bt_self_message_iterator_get_graph_mip_version() [29]

• The new bt_get_greatest_operative_mip_version_with_restriction() [30]
  function is like the existing bt_get_greatest_operative_mip_version(),
  but you may specify MIP version restrictions (a set of allowed MIP
  version ranges).

Python bindings
───────────────
The Python bindings wrap all the library changes in the same systematic
way as in Babeltrace 2.0.

More specifically:

• Add type hints to the public API to assist with static analysis of
  your applications.

  This is currently an ongoing effort, but we believe we've made
  significant progress in this direction to improve application
  code quality.

  The new type hints also serve as typing documentation.

  The `bt2` package has its own internal `typing` module to work with
  Python 3.4 as the official `typing` module [31] was introduced in
  Python 3.5.

• Add new names and functions to address naming inconsistencies:

  ╔═════════════════════════════════════════════════════════════════╦═══════════════════════════════════════════════════════════════════════╗
  ║                    Deprecated name/function                     ║                           New name/function                           ║
  ╠═════════════════════════════════════════════════════════════════╬═══════════════════════════════════════════════════════════════════════╣
  ║ `_DynamicArrayWithLengthFieldFieldClass`                        ║ `_DynamicArrayFieldClassWithLengthField`                              ║
  ║ `_DynamicArrayWithLengthFieldFieldClassConst`                   ║ `_DynamicArrayFieldClassWithLengthFieldConst`                         ║
  ║ `_OptionWithBoolSelectorFieldClass`                             ║ `_OptionFieldClassWithBoolSelectorField`                              ║
  ║ `_OptionWithBoolSelectorFieldClassConst`                        ║ `_OptionFieldClassWithBoolSelectorFieldConst`                         ║
  ║ `_OptionWithIntegerSelectorFieldClass`                          ║ `_OptionFieldClassWithIntegerSelectorField`                           ║
  ║ `_OptionWithIntegerSelectorFieldClassConst`                     ║ `_OptionFieldClassWithIntegerSelectorFieldConst`                      ║
  ║ `_OptionWithSelectorFieldClassConst`                            ║ `_OptionFieldClassWithSelectorField`                                  ║
  ║ `_OptionWithSelectorFieldClassConst`                            ║ `_OptionFieldClassWithSelectorFieldConst`                             ║
  ║ `_OptionWithSignedIntegerSelectorFieldClass`                    ║ `_OptionFieldClassWithSignedIntegerSelectorField`                     ║
  ║ `_OptionWithSignedIntegerSelectorFieldClassConst`               ║ `_OptionFieldClassWithSignedIntegerSelectorFieldConst`                ║
  ║ `_OptionWithUnsignedIntegerSelectorFieldClass`                  ║ `_OptionFieldClassWithUnsignedIntegerSelectorField`                   ║
  ║ `_OptionWithUnsignedIntegerSelectorFieldClassConst`             ║ `_OptionFieldClassWithUnsignedIntegerSelectorFieldConst`              ║
  ║ `_TraceClass.create_option_with_bool_selector_field_class()     ║ _TraceClass.create_option_field_class_with_bool_selector_field()      ║
  ║ `_TraceClass.create_option_with_bool_selector_field_class()     ║ _TraceClass.create_option_field_class_with_bool_selector_field()      ║
  ║ `_TraceClass.create_option_with_integer_selector_field_class()  ║ _TraceClass.create_option_field_class_with_integer_selector_field()   ║
  ║ `_TraceClass.create_option_without_selector_field_class()       ║ _TraceClass.create_option_field_class_without_selector_field()        ║
  ║ `_VariantFieldClassWithIntegerSelector`                         ║ `_VariantFieldClassWithIntegerSelectorField`                          ║
  ║ `_VariantFieldClassWithIntegerSelectorConst`                    ║ `_VariantFieldClassWithIntegerSelectorFieldConst`                     ║
  ║ `_VariantFieldClassWithoutSelector`                             ║ `_VariantFieldClassWithoutSelectorField`                              ║
  ║ `_VariantFieldClassWithoutSelectorConst`                        ║ `_VariantFieldClassWithoutSelectorFieldConst`                         ║
  ║ `_VariantFieldClassWithSignedIntegerSelector`                   ║ `_VariantFieldClassWithSignedIntegerSelectorField`                    ║
  ║ `_VariantFieldClassWithSignedIntegerSelectorConst`              ║ `_VariantFieldClassWithSignedIntegerSelectorFieldConst`               ║
  ║ `_VariantFieldClassWithUnsignedIntegerSelector`                 ║ `_VariantFieldClassWithUnsignedIntegerSelectorField`                  ║
  ║ `_VariantFieldClassWithUnsignedIntegerSelectorConst`            ║ `_VariantFieldClassWithUnsignedIntegerSelectorFieldConst`             ║
  ║ `ClockOffset`                                                   ║ `ClockClassOffset`                                                    ║
  ╚═════════════════════════════════════════════════════════════════╩═══════════════════════════════════════════════════════════════════════╝

• Make some types which are useful for type hints public:

  ‣ `_ClockClass`
  ‣ `_ClockClassConst`
  ‣ `_DoublePrecisionRealFieldClass`
  ‣ `_DoublePrecisionRealFieldClassConst`
  ‣ `_DynamicArrayFieldWithLengthField`
  ‣ `_DynamicArrayFieldWithLengthFieldConst`
  ‣ `_EventClass`
  ‣ `_EventClassConst`
  ‣ `_Field`
  ‣ `_FieldClass`
  ‣ `_FieldClassConst`
  ‣ `_FieldConst`
  ‣ `_FieldPathConst`
  ‣ `_FieldPathConst`
  ‣ `_FieldPathItem`
  ‣ `_InputPortConst`
  ‣ `_ListenerHandle`
  ‣ `_MessageConst`
  ‣ `_MessageIteratorConfiguration`
  ‣ `_OptionFieldWithBoolSelectorField`
  ‣ `_OptionFieldWithBoolSelectorFieldConst`
  ‣ `_OptionFieldWithSignedIntegerSelectorField`
  ‣ `_OptionFieldWithSignedIntegerSelectorFieldConst`
  ‣ `_OptionFieldWithUnsignedIntegerSelectorField`
  ‣ `_OptionFieldWithUnsignedIntegerSelectorFieldConst`
  ‣ `_OutputPortConst`
  ‣ `_PluginSet`
  ‣ `_PrivateQueryExecutor`
  ‣ `_SignedEnumerationFieldClassMappingConst`
  ‣ `_SinglePrecisionRealFieldClass`
  ‣ `_SinglePrecisionRealFieldClassConst`
  ‣ `_Stream`
  ‣ `_Stream`
  ‣ `_StreamClass`
  ‣ `_StreamClassConst`
  ‣ `_StreamConst`
  ‣ `_StructureFieldClassMember`
  ‣ `_StructureFieldClassMemberConst`
  ‣ `_Trace`
  ‣ `_TraceClass`
  ‣ `_TraceClassConst`
  ‣ `_TraceConst`
  ‣ `_UnsignedEnumerationFieldClassMappingConst`
  ‣ `_UserComponentInputPort`
  ‣ `_UserComponentInputPortMessageIterator`
  ‣ `_UserComponentOutputPort`
  ‣ `_UserFilterComponentConfiguration`
  ‣ `_UserSinkComponentConfiguration`
  ‣ `_UserSourceComponentConfiguration`
  ‣ `_Value`
  ‣ `_ValueConst`
  ‣ `_VariantFieldClassOption`
  ‣ `_VariantFieldClassOptionConst`
  ‣ `_VariantFieldClassWithIntegerSelectorFieldOption`
  ‣ `_VariantFieldClassWithIntegerSelectorFieldOptionConst`
  ‣ `_VariantFieldClassWithSignedIntegerSelectorFieldOption`
  ‣ `_VariantFieldClassWithSignedIntegerSelectorFieldOptionConst`
  ‣ `_VariantFieldClassWithUnsignedIntegerSelectorFieldOption`
  ‣ `_VariantFieldClassWithUnsignedIntegerSelectorFieldOptionConst`
  ‣ `_VariantFieldWithSignedIntegerSelectorField`
  ‣ `_VariantFieldWithSignedIntegerSelectorFieldConst`
  ‣ `_VariantFieldWithUnsignedIntegerSelectorField`
  ‣ `_VariantFieldWithUnsignedIntegerSelectorFieldConst`

• Make some types inherit `enum.Enum`:

  ‣ `ComponentClassType`
  ‣ `EventClassLogLevel`
  ‣ `IntegerDisplayBase`
  ‣ `FieldPathScope`
  ‣ `LoggingLevel`

• Add a `members` parameter to
  _TraceClass.create_structure_field_class() to be able to create a
  complete structure field class at once.

  Also make _StructureFieldClass.__iadd__() accept a tuple of three
  elements, including optional member user attributes:

      my_struct_fc = my_trace_cls.create_structure_field_class(members=[
          ('uid', my_trace_cls.create_string_field_class()),
          ('count', my_int_fc, {'context': 'bz.994', 'max': 2**16 - 1}),
          ('names', my_trace_cls.create_dynamic_array_field_class(
                        my_trace_cls.create_string_field_class())),

• Add an `options` parameter to _TraceClass.create_variant_field_class()
  to be able to create a complete variant field class at once.

  Also make the various __iadd__() methods of variant field class
  classes accept a tuple of three elements, including optional option
  user attributes:

      my_var_fc = my_trace_cls.create_variant_field_class(options=[
          ('i8', my_trace_cls.create_signed_integer_field_class(8)),
          ('i16', my_trace_cls.create_signed_integer_field_class(16)),
          ('i24', my_trace_cls.create_signed_integer_field_class(24), {
              'unorthodox': true,
          }),
          ('i32', my_trace_cls.create_signed_integer_field_class(32)),
          ('i64', my_trace_cls.create_signed_integer_field_class(64)),
      ])

• Add a `mappings` parameter to
  _TraceClass.create_unsigned_enumeration_field_class() and
  _TraceClass.create_signed_enumeration_field_class() to be able to
  create a complete enumeration field class at once:

      my_enum_fc = my_trace_cls.create_unsigned_enumeration_field_class(32, mappings=[
          ('meow', bt2.UnsignedIntegerRangeSet([34])),
          ('mix', bt2.UnsignedIntegerRangeSet([(3, 17), (99, 101)])),
          ('🐻‍❄️', bt2.UnsignedIntegerRangeSet([(1, 2), 13])),
      ])

• Add the `graph_mip_version` property to the `_ClockClassConst`,
  `_EventClassConst`, `_FieldConst`, `_FieldClassConst`,
  `_StreamClassConst`, `_TraceConst`, and `_TraceClassConst` classes.

• Add MIP 1 support:

  ‣ Add the `namespace`, `name`, and `uid` read-only properties to the
    `_ClockClassConst`, `_TraceConst`, `_StreamClassConst`, and
    `_EventClassConst` classes.

    Add the `namespace`, `name`, and `uid` parameters to the
    _TraceClass.__call__(), _UserComponent._create_clock_class(),
    _Trace.create_stream(), and _StreamClass.create_event_class()
    methods.

  ‣ Make the `precision` parameter of
    _UserComponent._create_clock_class() optional.

    The `_ClockClassConst.precision` property may now return `None`.

  ‣ Add the `ClockOrigin` class, which you can instantiate directly to
    make a custom clock origin.

    The `unix_epoch_clock_origin` and `unknown_clock_origin` names are
    two provided, well-known clock origins.

  ‣ Add the `_ClockClassConst.accuracy`,
    `_ClockClassConst.origin_is_known`, and
    `_ClockClassConst.origin` properties.

  ‣ Make the `_ClockClassConst.uuid` property and the `uuid` parameter
    of _UserComponent._create_clock_class() exclusive to MIP 0.

  ‣ Add the `_FieldLocationConst` and `FieldLocationScope` classes to
    wrap the field location API.

    Create a new field location with _TraceClass.create_field_location().

    Field class creation methods of the `_TraceClass` class which
    accepted an optional length/selector field class parameter, except
    for _TraceClass.create_variant_field_class(), now also accept a
    length/selector field location parameter:

    ⁃ _TraceClass.create_dynamic_array_field_class()
    ⁃ _TraceClass.create_option_field_class_with_bool_selector_field()
    ⁃ _TraceClass.create_option_field_class_with_unsigned_integer_selector_field()
    ⁃ _TraceClass.create_option_field_class_with_signed_integer_selector_field()

    Both parameters of a given method are mutually exclusive.

    _TraceClass.create_variant_field_class() is now exclusive to MIP 0.
    With MIP 1, use one of the following specific variant field class
    creation methods:

    ⁃ _TraceClass.create_variant_field_class_without_selector_field()
    ⁃ _TraceClass.create_variant_field_class_with_unsigned_integer_selector_field()
    ⁃ _TraceClass.create_variant_field_class_with_signed_integer_selector_field()

    Make the
    `_OptionFieldClassWithSelectorFieldConst.selector_field_path`,
    `_VariantFieldClassWithIntegerSelectorFieldConst.selector_field_path`,
    and `_DynamicArrayFieldClassWithLengthFieldConst.length_field_path`
    properties exclusive to MIP 0.

    Add the
    `_OptionFieldClassWithSelectorFieldConst.selector_field_location`,
    `_VariantFieldClassWithIntegerSelectorFieldConst.selector_field_location`,
    and
    `_DynamicArrayFieldClassWithLengthFieldConst.length_field_location`
    read-only properties to access length/selector field locations.

  ‣ Add the `_BlobFieldClassConst`, `_BlobFieldClass`,
    `_StaticBlobFieldClassConst`, `_StaticBlobFieldClass`,
    `_DynamicBlobFieldClassConst`, `_DynamicBlobFieldClass`,
    `_DynamicBlobFieldClassWithLengthFieldConst`,
    `_DynamicBlobFieldClassWithLengthField` classes to wrap the BLOB
    field class API.

    Those are similar to their array field class equivalents, but the
    only specific BLOB property is an optional IANA media type [32].

    Create BLOB field classes with the
    _TraceClass.create_static_blob_field_class() and
    _TraceClass.create_dynamic_blob_field_class() methods.

  ‣ Add the `_BlobFieldConst`, `_BlobField`, `_StaticBlobFieldConst`,
    `_StaticBlobField`, `_DynamicBlobFieldConst`, `_DynamicBlobField`,
    `_DynamicBlobFieldWithLengthFieldConst`, and
    `_DynamicBlobFieldWithLengthField` classes to wrap the BLOB
    field API.

    A BLOB field has a `data` property which returns a `memoryview` [33]
    object and which you can set to an instance of `bytes`, `bytearray`,
    or `memoryview`.

  ‣ Add the `_BitArrayFieldClassFlagConst` class to wrap the bit array
    field class flag API.

    `_BitArrayFieldClassFlagConst` is very similar
    to `_UnsignedEnumerationFieldClassMappingConst`.

    Add the _BitArrayFieldClassConst.__getitem__(),
    _BitArrayFieldClassConst.__len__(), _BitArrayFieldClass.add_flag(),
    and _BitArrayFieldClass.__iadd__() methods to access the optional
    flags of a bit array field class.

  ‣ Add the `_BitArrayFieldConst.active_flag_labels` and
    _BitArrayFieldClassConst.active_flags_for_value_as_integer()
    utilities.

    Those are similar to `_EnumerationFieldConst.labels`
    and _EnumerationFieldClassConst.mappings_for_value().

  ‣ Make the `name` parameter of the append_option() method of the
    various variant field class classes optional.

    The `_VariantFieldClassOptionConst.name` property may now
    return `None`.

    Make _VariantFieldClassConst.__iter__() yield an index instead of an
    option name with MIP 1.

    Make the __getitem__() method of the various variant field class
    classes accept an index instead of an option name with MIP 1.

    Add the _VariantFieldClassConst.option_with_name() method to get an
    option by name, or `None` if none.

  ‣ Make the `_TraceConst.uuid` property and the `uuid` parameter of
    _TraceClass.__call__() exclusive to MIP 0.

Command-line interface
──────────────────────
• Add the `--allowed-mip-versions` [34] option to the `run` [35] and
  `convert` [36] commands.

  This option makes the trace processing graph only honour a specific
  version (0 or 1) of the Message Interchange Protocol (MIP) [10]
  instead of allowing both versions.

  The main purpose of this option is testing the implementation of
  project plugins for specific MIP versions.

• Show the trace format when printing LTTng live sessions:

      net://localhost:4859/host/salut/meow (timer = 100, 10 stream(s), 3 client(s) connected, CTF 1.8)
      net://localhost:4859/host/salut/mix (timer = 10, 42 stream(s), 4 client(s) connected, CTF 2)

Plugins
───────
This section shows noteworthy changes to the project plugins.

In general:

• The version of all the project plugins is now 2.0.0 instead of none.

  For example, here's the output of `babeltrace2 help ctf`:

      ctf:
        Path: /usr/lib/babeltrace2/plugins/babeltrace-plugin-ctf.so
        Version: 2.0.0
        Description: CTF input and output
        Author: EfficiOS <https://www.efficios.com/>
        License: MIT
        Source component classes: 2
        Filter component classes: 0
        Sink component classes: 1

  This is useful for a user application which uses such a plugin to know
  its features and default behaviour (see bt_plugin_get_version() [37]).

  ┌───────────────────────────────────────────────────────────────┐
  │ NOTE: The plugin version is unrelated to the project version. │
  └───────────────────────────────────────────────────────────────┘

• Make all component classes support MIP 1, albeit sometimes
  conditionally to the initialization parameters.

Component class specifics:

`source.ctf.fs`:
    Add full CTF 2 support.

    CTF 2 support is only available with MIP 1.

    As such:

    • Merge physical CTF 2 traces into a single logical one, to support
      the LTTng recording session rotation feature [38], using the
      namespace, name, and unique ID of traces (if available).

    • Set the log level of a libbabeltrace2 event class from the value
      of the `log-level` attribute, under either the `lttng.org,2009` or
      `babeltrace.org,2020` namespace, of its corresponding CTF event
      record class.

    • Set the EMF URI of a libbabeltrace2 event class from the value of
      the `emf-uri` attribute, under either the `lttng.org,2009` or
      `babeltrace.org,2020` namespace, of its corresponding CTF event
      record class.

    • If the namespace NS, name NAME, and unique ID UID of the trace are
      available, then the trace ID part of an output port name is:

          {namespace: `NS`, name: `NAME`, uid: `UID`}

      If the namespace of the trace isn't available, but the name NAME
      and unique ID UID are, then it's:

          {name: `NAME`, uid: `UID`}

      Otherwise, it's the absolute directory path of the trace.

    • For the `babeltrace.support-info` query object, if the namespace
      NS, name NAME, and unique ID UID of the trace are available, then
      the `group` property is:

          namespace: NS, name: NAME, uid: UID

      If the namespace of the trace isn't available, but the name NAME
      and unique ID UID are, then it's:

          name: NAME, uid: UID

      Otherwise, the entry doesn't exist.

    When reading a CTF 1.8 trace with MIP 1:

    • For an LTTng trace:

      ‣ Set the namespace of any libbabeltrace2 trace
        to `lttng.org,2009`.

      ‣ Set the origin of any libbabeltrace2 clock class to the
        Unix epoch.

    • If the UUID of a CTF trace is available, then set the UID of the
      corresponding libbabeltrace2 trace to the textual representation
      of the trace UUID and its name to an empty string.

    • Set the UID of a libbabeltrace2 clock class to the textual
      representation of the UUID of its corresponding CTF clock class,
      if available.

    • Make the accuracy of any libbabeltrace2 clock class unknown.

    See babeltrace2-source.ctf.fs(7) [39] for more details.

`source.ctf.lttng-live`:
    Add full CTF 2 support.

    CTF 2 support is only available with MIP 1.

    A `source.ctf.lttng-live` component can connect to an LTTng relay
    daemon using the LTTng 2.4 or the upcoming LTTng 2.15 protocol. The
    latter is required for CTF 2 support.

    The “get supported MIP versions” method [25] always reports to
    support MIP versions 0 and 1. If you attempt to make a
    `source.ctf.lttng-live` component read a CTF 2 recording session
    within a trace processing graph configured with MIP 0, then the
    message iterator will fail at initialization or “next” method
    call time.

    For the `sessions` query object, add the `trace-format` property to
    each map of the returned array. This property is either `ctf-1.8`
    or `ctf-2.0`.

    See babeltrace2-source.ctf.lttng-live(7) [40] for more details.

`sink.ctf.fs`:
    Add full CTF 2 support.

    CTF 2 support is only available with MIP 1, while CTF 1.8 support is
    only available with MIP 0.

    The new `ctf-version` initialization parameter controls the CTF
    version of the resulting traces: `1` or `2` (the default starting
    from Babeltrace 2.1).

    With the `ctf-version` parameter set to `2`:

    • The component sets the `sink.ctf.fs` attribute, under the
      `babeltrace.org,2020` namespace, of the preamble fragment
      to `true`.

    • The structure member class names of packet context field classes
      having a CTF 2 role have the metadata stream UUID as a prefix to
      avoid clashes with user member classes.

      For example, the packet content length member class could be
      named `afe9ed0e-ce73-413f-8956-83663bab2047-content_size`.

    • The component translates an event class log level to the
      `log-level` attribute under the `babeltrace.org,2020` namespace.

    • The component translates an event class EMF URI to the `emf-uri`
      attribute under the `babeltrace.org,2020` namespace as a
      JSON string.

    • When the component needs to generate a length/selector
      field class F for dynamic field classes _without_ a
      length/selector field:

      ‣ The structure member name of F is unspecified.

      ‣ F contains the attribute `is-key-only`, under the
        `babeltrace.org,2020` namespace, set to `true`.

    • The component doesn't translate trace and stream user attributes:
      a CTF 2 metadata stream has no way to represent them.

      To write CTF 1.8 traces using the `babeltrace2` [41] CLI tool:

          $ babeltrace2 /path/to/input --component=sink.ctf.fs \
                        --params='path="/path/to/output", ctf-version="1"'

    See babeltrace2-sink.ctf.fs(7) [42] for more details.

`filter.utils.muxer`:
    Improve performance by using a heap instead of an array to sort
    messages by time.

    Our own experiments show that this version is slightly more
    efficient than the Babeltrace 2.0.6 one for a four-stream CTF trace
    scenario, but the performance gain improves quickly as you add
    streams (“RT” means “run time”; average of two runs):

    ╔═════════╦════════════════════╦════════════════════╦═════════════════════╗
    ║ Version ║ RT (4 streams) (s) ║ RT (8 streams) (s) ║ RT (40 streams) (s) ║
    ╠═════════╬════════════════════╬════════════════════╬═════════════════════╣
    ║ 2.0.6   ║              39.99 ║              45.28 ║               24.14 ║
    ║ 2.1.0   ║              39.06 ║              39.51 ║               12.16 ║
    ╚═════════╩════════════════════╩════════════════════╩═════════════════════╝

    Thanks to the Argonne Leadership Computing Facility [43] for
    sponsoring this feature! 🙏

    See babeltrace2-filter.utils.muxer(7) [44] for more details.

`sink.text.pretty`:
    • Add the `print-enum-flags` boolean initialization parameter (false
      by default).

      This new parameter makes a `sink.text.pretty` component try to
      print enumeration field values as a `|`-delimited list of bit
      flags, if it applies.

      When printing the value of an enumeration field _without any
      corresponding mapping_, the component splits the value into its
      individual bit values: if _each set bit_ has a corresponding
      mapping, then it considers that those mappings are in fact
      bit flags.

      If a set bit has no corresponding mapping, then the component
      prints `<unknown>`.

      For example (`block_rq*` Linux kernel event record; structured
      output to make it more readable):

          [13:15:49.024354958] (+0.000003868) wilbrod block_rq_complete:
            { cpu_id = 4 },
            {
              dev = 8388624,
              sector = 375490176,
              nr_sector = 360,
              error = 0,
              rwbs = ( "RWBS_FLAG_READ" | "RWBS_FLAG_RAHEAD" : container = 12 )
            }

      This parameter is false by default to avoid any
      unexpected behaviour.

      To try this using the `babeltrace2` [41] CLI tool:

          $ babeltrace2 /path/to/trace --component=sink.text.pretty \
                                       --params=print-enum-flags=yes

      Thanks to Geneviève Bastien for contributing this feature! 🙏

    • A `sink.text.pretty` component now prints a comma-delimited list
      of _all_ the mapping labels of a given enumeration field value
      within curly braces:

          enum_field = ( { "bit0", "range1to3" } : container = 1 )

      Thanks to Geneviève Bastien for this contribution! 🙏

    • Print the data of BLOB fields:

          my-event: { my-blob = { 23 69 6e 63 6c 75 64 65 20 3c } }

    See babeltrace2-sink.text.pretty(7) [45] for more details.

`sink.text.details`:
    • Don't write the value of a trace environment entry or of a value
      object when it's an empty string.

      This is mostly to avoid trailing whitespaces in the output.

    • Print field locations in a manner similar to field paths, except
      structure field member names replace indexes:

          Length field location [Event payload: walk, deep, surprise]

    • Print BLOB field classes:

          my-blob: Static BLOB (Length 32, Media type `application/mathematica`)

    • Print BLOB fields:

          my-blob: Static BLOB: Length 32:
            44 6f 5b 50 72 69 6e 74 5b 22 48 65 6c 6c 6f 2c
            20 57 6f 72 6c 64 22 5d 2c 20 7b 35 7d 5d 20 20

    • Print namespace, name, and UID properties of traces, clock
      classes, stream classes, and event classes:

          Trace `radical` (Namespace `chrysler`, UID `imperial`):

          Default clock class:
            Namespace: lttng.org,2009
            Name: monotonic
            UID: boot-id:7d19f00b-f1c7-49ea-a0a1-5f1a6a062a29

          Stream class `real` (Namespace `scion`, UID `tc`, ID 48):

          Event class `genetic` (Namespace `manic`, UID `gt`, ID 334):

      Add the `with-stream-class-namespace` and `with-uid` boolean
      initialization parameters to control the visibility of stream
      class namespaces and UIDs (both true by default).

    • Print sorted bit array field class flags:

          Bit array (8 flags):
            Flags:
              MAP_ANONYMOUS: [5]
              MAP_DENYWRITE: [11]
              MAP_FIXED: [4]
              MAP_GROWSDOWN: [8]
              MAP_NORESERVE: [6]
              MAP_POPULATE: [15]
              MAP_PRIVATE: [1]
              MAP_SHARED: [0]

    • Print new clock class properties: unknown precision, accuracy,
      and origin.

          Default clock class:
            Namespace: lttng.org,2009
            Name: monotonic
            UID: boot-id:7d19f00b-f1c7-49ea-a0a1-5f1a6a062a29
            User attributes:
              lttng.org,2009:
                tag: provigo
                original-index: 4
            Description: Monotonic Clock
            Frequency (Hz): 1,000,000,000
            Precision (cycles): 0
            Accuracy (cycles): 1000
            Offset from origin (s): 1,564,079,206
            Offset from origin (cycles): 484,157,338
            Origin:
              Namespace: quebec.ca,2017
              Name: referendum
              UID: 1995

    • Print the field value hints property of integer field classes:

          Unsigned integer (64-bit, Base 10, Expect small values)

    See babeltrace2-sink.text.details(7) [46] for more details.

FUTURE WORK
━━━━━━━━━━━
Without guaranteeing anything for Babeltrace 2.2, here are some
improvement ideas that often come up in our discussions:

• Make the plugin provider API public so that anyone may implement their
  own libbabeltrace2 bindings.

  Currently, there's an intimate relation between libbabeltrace2 and the
  official Python bindings.

  As of this date, a patch set [47], written by a generous external
  contributor and which adds this feature, is already under review.

• Make it easier to create an efficient filter message iterator which
  needs to modify or augment event messages.

  Currently, if you need to modify an event message, considering that
  you cannot change an event class once you use it, you need to create a
  new event class, which means you also need to create a new stream
  class and a new trace class. You also need to copy all the metadata
  and data objects you don't alter. This is what
  `filter.lttng-utils.debug-info` [48] does.

  We do realize that trace-transforming filter message iterators
  represent an important Babeltrace 2 use case. While it's possible to
  write one for Babeltrace 2.1, it is cumbersome to do and the result is
  not as efficient as we'd like.

• Add a filter component class to drop messages (like events) based on a
  filter expression, similar to the `--filter` [49] option of the
  `lttng enable-event` command.

• Optimize specific project component classes, especially
  `source.ctf.fs` [39] and `source.ctf.lttng-live` [40].

  For `source.ctf.fs`, implement the “seek ns from origin” method using
  packet indexes to make a message iterator seek a specific time faster.

STATISTICS
━━━━━━━━━━
Since Babeltrace 2.0.0:
    Commits:
        1438

    Changed files:
        1741

    Diff:
        227,712 insertions; 88,376 deletions

    Significant contributors:
        Simon Marchi, Philippe Proulx, Michael Jeanson,
        Francis Deslauriers, Erica Bugden, Jérémie Galarneau,
        Mathieu Desnoyers, and Geneviève Bastien

Programming languages as of Babeltrace 2.1.0:
    ╔══════════════╦═════════════════════════╗
    ║   Language   ║ Effective lines of code ║
    ╠══════════════╬═════════════════════════╣
    ║ C/C++ header ║                  50,437 ║
    ║ C            ║                  84,504 ║
    ║ C++          ║                  78,620 ║
    ║ Python 3     ║                  12,035 ║
    ╚══════════════╩═════════════════════════╝

IMPORTANT LINKS
━━━━━━━━━━━━━━━
Babeltrace 2.1.0 tarball:
    <https://www.efficios.com/files/babeltrace/babeltrace2-2.1.0.tar.bz2>

Babeltrace website:
    <https://babeltrace.org/>

Mailing list for support and development:
    <https://lists.lttng.org/>

IRC channel:
    `#lttng` on `irc.oftc.net`

Git repository:
    <https://bugs.lttng.org/projects/babeltrace/>

GitHub project:
    <https://github.com/efficios/babeltrace/>

Continuous integration:
    <https://ci.lttng.org/view/Babeltrace/>

Code review:
    <https://review.lttng.org/q/project:babeltrace>

REFERENCES
━━━━━━━━━━
 [1]: https://babeltrace.org/docs/release-notes/babeltrace-2.0.0-release-notes.html
 [2]: https://diamon.org/
 [3]: https://diamon.org/ctf/
 [4]: https://diamon.org/ctf/v1.8.3/
 [5]: https://datatracker.ietf.org/doc/html/rfc7464
 [6]: https://en.wikipedia.org/wiki/LEB128
 [7]: https://www.efficios.com/
 [8]: https://lttng.org/
 [9]: https://babeltrace.org/docs/v2.1/man7/babeltrace2-intro.7
[10]: https://babeltrace.org/docs/v2.1/man7/babeltrace2-intro.7/#doc-mip
[11]: https://babeltrace.org/docs/v2.1/libbabeltrace2/group__api-tir-clock-cls.html
[12]: https://babeltrace.org/docs/v2.1/libbabeltrace2/group__api-tir-ev-cls.html
[13]: https://babeltrace.org/docs/v2.1/libbabeltrace2/group__api-tir-stream-cls.html
[14]: https://babeltrace.org/docs/v2.1/libbabeltrace2/group__api-tir-trace.html
[15]: https://en.wikipedia.org/wiki/Unique_identifier
[16]: https://babeltrace.org/docs/v2.1/libbabeltrace2/group__api-tir-fc.html#api-tir-fc-ba
[17]: https://babeltrace.org/docs/v2.1/libbabeltrace2/group__api-tir-fc.html#api-tir-fc-ba-prop-flags
[18]: https://babeltrace.org/docs/v2.1/libbabeltrace2/group__api-tir-fc.html#api-tir-fc-int
[19]: https://babeltrace.org/docs/v2.1/libbabeltrace2/group__api-tir-fc.html#api-tir-fc-int-prop-hints
[20]: https://babeltrace.org/docs/v2.1/libbabeltrace2/group__api-tir-fc.html#api-tir-fc-blob
[21]: https://babeltrace.org/docs/v2.1/libbabeltrace2/group__api-tir-field.html#api-tir-field-blob
[22]: https://babeltrace.org/docs/v2.1/libbabeltrace2/group__api-tir-field-loc.html
[23]: https://babeltrace.org/docs/v2.1/libbabeltrace2/group__api-tir-field-path.html
[24]: https://babeltrace.org/docs/v2.1/libbabeltrace2/guide-mip-0-to-mip-1.html
[25]: https://babeltrace.org/docs/v2.1/libbabeltrace2/group__api-comp-cls-dev.html#api-comp-cls-dev-meth-mip
[26]: https://babeltrace.org/docs/v2.1/libbabeltrace2/group__api-tir-clock-cls.html#ga8da11f39e67bab58848c71671c8192f0
[27]: https://babeltrace.org/docs/v2.1/libbabeltrace2/group__api-tir-fc.html#ga3a3816edfcb31177574ddea4f456d657
[28]: https://babeltrace.org/docs/v2.1/libbabeltrace2/group__api-tir-trace-cls.html#gaedadf9f5626f5466b30653b47027d3ae
[29]: https://babeltrace.org/docs/v2.1/libbabeltrace2/group__api-self-msg-iter.html#gaa2767e72e6b86835898c9030884be77c
[30]: https://babeltrace.org/docs/v2.1/libbabeltrace2/group__api-msg.html#gab39e215853c38692cbc62a53d6107df9
[31]: https://docs.python.org/3/library/typing.html
[32]: https://datatracker.ietf.org/doc/html/rfc2046
[33]: https://docs.python.org/3/library/stdtypes.html#memoryview
[34]: https://babeltrace.org/docs/v2.1/man1/babeltrace2-run.1/#doc-opt--allowed-mip-versions
[35]: https://babeltrace.org/docs/v2.1/man1/babeltrace2-run.1/
[36]: https://babeltrace.org/docs/v2.1/man1/babeltrace2-convert.1/
[37]: https://babeltrace.org/docs/v2.1/libbabeltrace2/group__api-plugin.html#gacbb8a7f96cdb85e5f5361289a133c8c6
[38]: https://lttng.org/docs/v2.13/#doc-session-rotation
[39]: https://babeltrace.org/docs/v2.1/man7/babeltrace2-source.ctf.fs.7
[40]: https://babeltrace.org/docs/v2.1/man7/babeltrace2-source.ctf.lttng-live.7
[41]: https://babeltrace.org/docs/v2.1/man1/babeltrace2.1/
[42]: https://babeltrace.org/docs/v2.1/man7/babeltrace2-sink.ctf.fs.7
[43]: https://www.alcf.anl.gov/
[44]: https://babeltrace.org/docs/v2.1/man7/babeltrace2-filter.utils.muxer.7
[45]: https://babeltrace.org/docs/v2.1/man7/babeltrace2-sink.text.pretty.7
[46]: https://babeltrace.org/docs/v2.1/man7/babeltrace2-sink.text.details.7
[47]: https://review.lttng.org/c/babeltrace/+/11716/
[48]: https://babeltrace.org/docs/v2.1/man7/babeltrace2-filter.lttng-utils.debug-info.7
[49]: https://lttng.org/man/1/lttng-enable-event/v2.13/#doc-opt--filter
