Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83962E77184
	for <lttng-dev@archiver.kernel.org>; Thu, 19 Dec 2024 23:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1734650732;
	bh=h9IRhhXL/Y3tneY7bO/2D1JWnj1HPrZ4CFjQi/u4N/o=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=N1xSvv3LpcxOMS+lhdHynMJsk57etKeDz+I7KPHIOXTgjw6ZqByxsXis/3PxF4Iou
	 xt8pL7d0Oiin9j5xqY7ySISrzSGv+kVWy/mig/jRutxJC4TnfZl02zuv/f4Tlz/rGy
	 FQMahbpbOdJwImCjDOIxqCp4bkJ44xXkNT0pA7kWSV8zwgSzhJuCwHTJSd7KYillJl
	 W/l1dyHEQRVaP5cw6jEBGFyQ5W6DKLrnpAZONrw9B+1A9sBxzpe/RHWqfthdu7Xs84
	 PgL1ChMd/q6Pg+kZv6NLj3+vwmJJVlu+MA3/RCehs42BByQo43LIOMLK2NTHneQRBR
	 nu6aRfxDdYfZQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4YDmqv5m71z1ZxJ;
	Thu, 19 Dec 2024 18:25:31 -0500 (EST)
Received: from YT5PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazlp170110005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::5])
 by lists.lttng.org (Postfix) with ESMTPS id 4YDmqt4bb5z1ZxG
 for <lttng-dev@lists.lttng.org>; Thu, 19 Dec 2024 18:25:30 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hD2nkL17bcEwCE9pEbsSm1V0IsbyRlvQGigZ6woFx5dl5FgGlV9tfGH7fvQzxv0KV5i6leu8oqibDPPrmD0hlB36tB0ji1B56X9YWuajxE8GlrSY13Glc2TE1g0CRRc8dcheU6eipnZHuL4/1pCRhLpiCPDk1Ig3n3kB7C/6//uDDrg7nvXNGr+eJq7XeTWS0MydpY62VhLUZQZgHncPmXWIhVZRiLsdiK2WrqizMcLTNNLnpjpMX9tt1VS6EfO16U2mlVo5JRV9Qiz+A1oa8LRP+x6GH2uQRLvamANzOXlWf0plDj+c0k5a2qlz5GqC3gzCMmwk5lwSEszzcnHCbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQok9niPEbBRCiok4uTXgO8YDhtxxp0fi4Bw8OsZNJg=;
 b=Z2FBmt4cDdBHGVqt+e9gCAHDiOTE8672bbSq4w7WYh/BXu7uCL3yTZWLtpUGSChYERoq1cqQU8Za/x8dn97Le0fxV9smhwdT292ICucS+Q2QbqJcm5GSScMsaZ2FeFUgbrMOqHf3telbr/wCgsV1QW1S1S4Lc+v7Hn3mB3Av8t8b/avmw69M7OfPPsOG7qQCY+qywGtEqmCaCT8PN88K5AFM7wyS1BCTeuuGNxiFKTaMktQ+sdYB6erKcJrthAjqVgKcBCV+Lw0uT6zHmqoDUOKfbXkTrre9vBGSO4h1lLf9ry8Te0Z7po47vlrtjUAAU4plF9g+Yxm7FVSXa+cajA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:104::10) by YQBPR0101MB5990.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:35::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Thu, 19 Dec
 2024 23:25:28 +0000
Received: from YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5de4:ebdb:2bf6:ee1]) by YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5de4:ebdb:2bf6:ee1%4]) with mapi id 15.20.8272.013; Thu, 19 Dec 2024
 23:25:28 +0000
Date: Thu, 19 Dec 2024 18:25:27 -0500
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss@lists.linuxfoundation.org,
 linux-trace-users@vger.kernel.org, lwn@lwn.net
Subject: [RELEASE] Babeltrace 2.1.0-rc1
Message-ID: <Z2SrZ9ciEYNtKCdr@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::17) To YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:104::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10709:EE_|YQBPR0101MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: d67e3826-3230-42db-cfd1-08dd20846c95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YW14dG5YcG9UdHEraURURW9sOW5MNGhCdzg3cll3ZWhnK21FaERKMDNvVjIv?=
 =?utf-8?B?c2ZLQ1QzcnJyUzJTdGxPRld5ZUk3M1hmaFlTV20zNDgzQkJOT2hIbTJJUHg5?=
 =?utf-8?B?SzZkeEQwN24xWXhOclVqNnF3L0ZPL2owZnFpQTRscWc2Rzd5WjhJbDlYc3BZ?=
 =?utf-8?B?Q05ySDM5SWt4ZmxWUUNrL1F2T3hlZ2V1QmIyM3I2QTgvY3VuWFdjWmZSY3Vm?=
 =?utf-8?B?bXBHQWIwcGJpSTZSMjl4a3ROZXRWN01zeXN1bWhLdTRjS3VBQWphQ1dSL1Ux?=
 =?utf-8?B?dElyRHlveTlXQk5DMUpFZTRxQ1pvSWNtb1NCbVpOSGp6ZldYaXpLY0FOL3ht?=
 =?utf-8?B?c0NNOURWWHVGUTlsK2xlMG9nZ0ExSVlnT3Yxalo5NUFxa2dUNUd5eURzSnNR?=
 =?utf-8?B?WlNQeVNjaUhYczBKZTlNRmNSK0xhUEdMYXZTeEthazExVC8xNmRZQXV0V3dF?=
 =?utf-8?B?TUQxbmVRd250MElkRTJBWm9xY0Z6Zk93aW81S0hhbnlUR3h6Vld0SzdyemxE?=
 =?utf-8?B?RGpNYmFjNUV2c09nUkMvRVZYUkNpVVhjU3piWVAvRllxUlJyWHdpOTA3WElx?=
 =?utf-8?B?TExhcWhvcGdsRkJuMnBSbVFvZnVGYll2a29qdlN5WmJPeENid2h2SW5DZk1I?=
 =?utf-8?B?UW9KL0pjRFBiZkk0TTFSYk1waVpMRTF4U1pKZ0hyWm1qaTRJaVhwcEZnc1ha?=
 =?utf-8?B?SVUrVDZyWXJWSVFqMnpsZ3A4M2RpTDZhcHd0d0ZxR1dmN0pGdk9WOFYybTRl?=
 =?utf-8?B?ZTRFUE5aTUxlc3ZvcXJLR1E5UVpFTjU1N3lMZkJ6dVpENCtYUWtJMVdsNW5l?=
 =?utf-8?B?UXZoUVpIdFZkalNReHdreVU5Y2JCSVM1RFR5OTdzM3RXUEdzZWQxalhsQTVR?=
 =?utf-8?B?eWduRXg4Kyt3TnBuZmw5ZlRoREtqYTdRaTVCVEsvTFpEcmNnUzRLRmhSQk9x?=
 =?utf-8?B?clVudUcxMzJhbG9ncmpKa1QvSkdLTExnZUd4RWdKLzhFTFFtZ1VJczkxY0hU?=
 =?utf-8?B?S01zNFp3QmR4OWhNZ28vRmtkVklZdnpCdE1LV2tXOWVjQlRIbk5DRUdLZDdq?=
 =?utf-8?B?NFNCSFBQRGh3ZEdGcmJ5R1FwUFFnUUxhZWx3STg5eFJ1ZzcvREdPeFE4TG9W?=
 =?utf-8?B?L1hUcG1UY1E0VlVtSG5GMXpWeWlYY2JvMDFGdDBLMDQreDhZc3FFV2F0S2Y5?=
 =?utf-8?B?b3JtSTd6ZmwzQ2NYWjNnNE84SXlYWmRsNjUrTVJ2VDJXVXdEOCt3Q0tDRkgw?=
 =?utf-8?B?R3hVVGM1Wnd6SUM5MzB6TjZrbUpmc042V3RoOU1IWElxQVZnZU10c2h5djds?=
 =?utf-8?B?alJGeWNmOW1TZ3RCbm9UY2NVMUt4Q0Q2LzBQZGw3KzZ5ajU1QTVPcHhKTW5H?=
 =?utf-8?B?V3o5Y0ZlVTh3ZTNzVCtIQzlxbVl2VU9uZjgzK2hKQ2d4K0dPRG95cWlZMTdQ?=
 =?utf-8?B?NHFqZVhVRzRIUFF2RVdycUdHUmc1d3VUN2hlMW5BNWIzNisvNFdtZDlMR1hj?=
 =?utf-8?B?WldTT1JDV2lXZjNsWXhDRk1mMHY2U05YM0Y5QitJeUg0dWZWZ1YzT2kxTko4?=
 =?utf-8?B?NXpjb2hRTU9XMTBEUTVYMUlvRENwd25SL0N0enVTZWtOSlJwOGM5SjlhOUM5?=
 =?utf-8?B?R1ZTRncxdnhETnFBcm1hZnNmRjY3U0lPVXB2WFVnck0rdTV6MDNBekpiTWx4?=
 =?utf-8?B?QkFWUEFEOFdid3JmUWlsOU5DN0p1bXRydVBZTlRUL0krSlZJZHI3VnlKcWZJ?=
 =?utf-8?Q?cMsaAWl3K0/VlzmUTXts5Dyfw3zLie6fsBsGF24?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yi8wSG1pS2taekEycG83amtzVWg0d3R2V1lyTUxnQ3FBNUdsYmtJL3F5Wk9i?=
 =?utf-8?B?ajcvN3Q0K3BKb1NjeUN4aVZWWW5aS3BCcjg5V0dQT29rNDN2bDVkN0dhZ2dl?=
 =?utf-8?B?VUpTMHhteWFsdlpkeisvYlgwbXMxY0MyUTBzUTBUSWtQdXl5T1ZvN2ZrTjNC?=
 =?utf-8?B?b3I3bXFqT0RZS09OSys1Zk9Ec3RwRW1LU2dFMTFMU0VoM2Jka3RXeUo5VC9S?=
 =?utf-8?B?eXNwVWQyYXAzSktqbTlyVXpNUWgxYmtXK0ZNenpmYjhnTlVDOE1TeXZ4WFZQ?=
 =?utf-8?B?NTJka2tUSE5hbUdNZ0gxbDNlN1FoZzh0bXRxYXpYd0FYcFd0dzFqdkdkQkRQ?=
 =?utf-8?B?VFI3SDQvbXpPSGYxVlVKUmVmb1RRWThaakd2ZzNHdWJDTGREQnlvNllMWDlJ?=
 =?utf-8?B?VnBlcW4reGxYM2FZNStHWkh5WUJZeTBZNHlPNi9kdlAzTWdLTlVQMGRRRGdo?=
 =?utf-8?B?N0VXOXVsSUkwbVk2ZnFjWjdmY29SQ1d1TWs4amhod0RpbWdabHJwclBMcTd0?=
 =?utf-8?B?bW5IUmRMQmpwaDVjamhQekpYZHc3aG5RQjg4VEVkYlJWbG5UQmRhQTl2TEVx?=
 =?utf-8?B?S28vN3RSaWxNeU43M3R3bTlhekZoZnp2cW9lNVFMSkJGT09LTFFXYXUwbUEw?=
 =?utf-8?B?ZXp0WVVFbFN6aVdqaG1SeFl4emtPamhiM2RGSEJNdi9pNmJPKyt0aHJta2hZ?=
 =?utf-8?B?Qkg0ak1KR3owTXVEY2Z1MFMwMkpkdmVRbEhHNlh5TzNCTC9RNmdRT2tuMU8w?=
 =?utf-8?B?Rmc3cFRaSi92NXczYzFTeGpwSU9IWXhLZmRtTEdHekExVEp0SkRmdG9aWmV1?=
 =?utf-8?B?WW4yeTl0b3lIeEtQRGs4dnZ0VnJJc0xSVTN0UzloUjlCNFlKWEdnS3hsZzRI?=
 =?utf-8?B?UHphRXlhbnM4Umw5a1lld1VwcWg5S3JJTElqK1lmRlBWRTF1VW5heWs0WEI5?=
 =?utf-8?B?YkdXN1U4UXN0WkZ2VWNNWWZ1Zk8yUUwzZUJWbHJuRTQ0aVNhZFU0M3dQQWp0?=
 =?utf-8?B?ZzdENUVIelhROUQvcFk3QktuODZabEpGMlZFR0NoRklMZDBENSt3cGNJVExO?=
 =?utf-8?B?eDNpd1QyWlFtcytaY1Raa3pRRzQ1Y0tWOCtqMFNrNEUwSUdwK3dWL2lqcHZO?=
 =?utf-8?B?eWl2bzJudGZmNDc3V1ZlTEY1dXV3WkdGZll3MmFLaHpScjVRMnYrLzl3cFU1?=
 =?utf-8?B?b25Kcm1ROWo3OFpLLzZ3SUU2eW1xQndFSndzVVRzWjExQ1E2L2drNkdPZmg1?=
 =?utf-8?B?QkF0MEY3STgyWEFGTzJpNEhMbTF6RCtQZ1JrUGNrdFRQcFk0bVlsZDdLbkt3?=
 =?utf-8?B?b1FVdGdBdHNkNDl5VE9TMXgrSnpqVkEvTnlkYXNEOE1BY05qOFdiQUlJNEUx?=
 =?utf-8?B?RTFwNUxrTEhrOGRjWVdqSXlWR00wS012RkF4Z0RwVzVFOHY3NnczN3h1c3FI?=
 =?utf-8?B?cGh5cXg3UGQ4a0R1OWFRclE0aTJGUXAyaUY3ZlZqQWVFOHIvZlY5cGdxcTFL?=
 =?utf-8?B?OVk0aHIzVUVqM2QwNmc4bi9DYVF6VWJHVGVBWG5OSmNRU0Y0QUY3VFYzZzhh?=
 =?utf-8?B?RWZlSVV2Ym9KbjhHU3Exc0R6REV6dTBIL1p3TGtyYzcwRGxkS3F4cEw4VW1I?=
 =?utf-8?B?ZDRlZEx3QlhPOFN3bWZkQ2tZd056cnc5RUtmUEc0S1VlVDhtK21wc2gwRWU2?=
 =?utf-8?B?Y2p1SmtxTmdhWklRLzlKZVRrWlo3ZkRFSXVUL3IwWDFTcm9HTTZIWTdVd1NO?=
 =?utf-8?B?RW5oNTk2UVVQeFl2RDZwZm1kNUF2VlNNSWJjdWZqQ0tvY1MxSjRVTHhTVGxw?=
 =?utf-8?B?ZUx2K1JkUVZZRmFOVk8wZFZ4OEVmUE1Cdm84aWFLWldHMjBsQXlBWmIzR0Ez?=
 =?utf-8?B?K1BuVDdiRjBQSmFKaGh4ZTlwRlA4aXdIU0JjRHE4eE1RSjZ6MWZRTTFsbWRB?=
 =?utf-8?B?Z2E1alFHeXN1eWE2TDNieDMvamNZd0pKV093NDBVTmx2d1N0eEkyNEZmNlps?=
 =?utf-8?B?REg3OGR3NWVIdnZFcC9lSmFJRjhaN1dSU2lrelBpY0dXeGp1SmpIZncyRjBX?=
 =?utf-8?B?Y1ZNOHQ1U3QzbE4wcmFUalpObXF4V1ZRZnMyem1kUmxkRjVwZTFsN1RGdDhM?=
 =?utf-8?Q?FiRUjs8mZL/IytJ1LHrLhGl/k?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67e3826-3230-42db-cfd1-08dd20846c95
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 23:25:28.7082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLPawoSX8FrTdeL4iDLShC+zrlnQAwP/GEhpPj9BZ0hbvnRRBWbIALr0W2KuggEZ39OxxcT3tTu8EqfMQw0QAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5990
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

It's been a long journey, but here we are: today we're announcing the
first release candidate of Babeltrace 2.1 “Brossard”! 🥳

┃ Brossard (/ˈbrɒsɑːr/) is a city in southwestern Québec, Canada, on
┃ the South Shore of the Fleuve Saint-Laurent, near Montréal.
┃
┃ Home to the Quartier DIX30 lifestyle complex and the Canadiens'
┃ practice facility, Brossard is defined by its suburban sprawl and
┃ stroads like boulevard Taschereau, seamlessly blending commercial
┃ hubs with car-dependent design.

Our main focus for Babeltrace 2.1 was to bring CTF 2
<https://diamon.org/ctf/> support to the project. This required major
changes across the C API, the Python API, all the official plugins, the
command-line interface, the documentation, as well as several internal
aspects, including the tests. This is because CTF 2 introduces new
concepts which are incompatible with the libbabeltrace 2.0 API, and then
this library is the foundation of all the other parts of the project.

Rest assured, however: Babeltrace 2.1 can still read CTF 1.8 traces and
will continue to.

We published CTF2‑SPEC‑2.0, the CTF 2 specification, last March.
Therefore, as far as we know, there are currently no tracers producing
CTF 2 traces. As for LTTng, we plan to add CTF 2 support in version 2.15
(we're currently wrapping up work on version 2.14).

For you the users, this means there isn't much to try out immediately.
However, it was important for us to release Babeltrace 2.1 well ahead of
LTTng 2.15 to ensure that both will be available together in
distributions, and so that a CTF 2 producer author has a stable reader
available for testing.

NOTE: We'll publish the full release notes as well as the online
documentation (manual pages and C API) when releasing Babeltrace 2.1.0,
most probably next month.

Feel free to reach out if you have any questions or comments.

                                                   — The Babeltrace team

LINKS
=====
Project website:
    https://babeltrace.org/

Download link:
    https://www.efficios.com/files/babeltrace/babeltrace2-2.1.0-rc1.tar.bz2
