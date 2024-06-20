Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AF7C27C79
	for <lttng-dev@archiver.kernel.org>; Thu, 20 Jun 2024 15:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1718898500;
	bh=J6xVr+CPpSwFtiDcydsv9iy6QOp8z9mBYr/mdC/ZQW0=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=nWdrPu4AM71PQSzx9JyT+w9e52oNXMcTPER+qJHVbPxd7zdWqxINt8wJ+PKpMBV2H
	 OYpVug/WyvXM/UrsvJktXfATuxDqi16ciP5Aues5NZxQmzSbAn6bz0BbGS6I7X/jmg
	 d0r+4Gvuvn6pfF6Tm1UMYrhzjYNzSwB7NXEvpWvqwYXAXWRNFJaMBYec/WDCmHkhpO
	 l+hv2Cyi+dKnNdfvq2RG6oJrym2K/lTQY+qDKc9kagHtEwLqZZ3cJ7jH1ycs+5qret
	 Wf2TdwgmEdEJ6sFuhThCQPOUNe2v3/mt7rsY/8wbtE27p+hNkpkU1i7Rm6xiV5DNhV
	 IyHW2gJy9+6bg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4W4lJN0SC4z4fJ;
	Thu, 20 Jun 2024 11:48:20 -0400 (EDT)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:241c::701])
 by lists.lttng.org (Postfix) with ESMTPS id 4W4lJM0sghz4fH
 for <lttng-dev@lists.lttng.org>; Thu, 20 Jun 2024 11:48:18 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0mpOt6nv7nSr7Puw3hDyOdcN8Bad5h3v2CDyL0Yinw8AO5GQhrZvLV9L16XEJsV7b1MeuutscFOtLVx4wagviMui/Gtk5fSv38egMs8dphpmcooKrvf6xUiulTip1pG4gN9NmPgMSRZywmJConJIX1gkbIAnQEa4ychtIAekZYK2irJt3LcvIkk1G2/sZ7NuVPCPa7J2ubLCLJ44+zXfWarzUqsEPXuZCrBEsV2X5o/U9cllsJKZxEbwg25OLiFwE4LjyWQU4q7VImQGoWsMWV3GyPa/fMzP7Bq+Pbvyu7JD5tGJY605gjawklRm5+xTgYa5eynlrB7a7T+amvI7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+BC42TNFYCbeL+TDvVVlFGhleMCCK1mswTT1HuLdhE=;
 b=QCpmHFDEK7DbjRjp0jI/lk33b/MAzxvE3zYeQ1vqUmyQVq8oeeI3AjrSxMhBaQo2lqFaTuPq8CrSwG52JByudx9RjAqfVty3GbAabQl6xkYFSjJgMBr1WSrCgWMH62RATsjx1Z3Upv4LmUf5XP+XlVdc1NPHMt3H0qCX+WI6/Tgnt10lG7RYSJEXDS/kPVshIo4SR8tH1NoV7pj49KCE26t3czALIuOBo++0/le/33EK4lwJntdk/GhfNeTemG0EuK6yfoiTCoKtU/6spHTGICEiQ+T16o8hYTE/uJjQpja2gq0E7EU3vhICCNQmN7kNWhVqrssMbgAxrxjB3vRo4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT2PR01MB9510.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 15:48:17 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%2]) with mapi id 15.20.7698.019; Thu, 20 Jun 2024
 15:48:17 +0000
Message-ID: <18dcf546-e7bf-44a4-b8ef-5ec5f109fa27@efficios.com>
Date: Thu, 20 Jun 2024 11:48:16 -0400
User-Agent: Mozilla Thunderbird
To: Jean-Marc Chevalier <jean-marc.chevalier@polymtl.ca>,
 lttng-dev@lists.lttng.org
References: <364622686.75839325.1718811716721.JavaMail.zimbra@polymtl.ca>
Content-Language: en-US
In-Reply-To: <364622686.75839325.1718811716721.JavaMail.zimbra@polymtl.ca>
X-ClientProxiedBy: YQBPR0101CA0344.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::28) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT2PR01MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5c2265-005b-4b69-484a-08dc9140671b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGI4cnpPeUhFcTZhNjhTdFY2QjJ0VzhPdFpKUVpxZ3lBS3A4K3g5QmVQYnZw?=
 =?utf-8?B?RHZpVjEyb0puMlhrYkcxTVRwaGRmVzdCd3N2UnhJNjBFNm1vcjdPMEh0Mjc0?=
 =?utf-8?B?R2lVU09ub3lHVCs3cXRqKzRhUlZVVHdob1k1c3FiZXp5ZGQxUm9yUG5TOStZ?=
 =?utf-8?B?cHNqbi81Qk5TVTVWMVNqNVVBR1pBK2RVUktDaFBueVNpeTFEU292Tis1WnJ6?=
 =?utf-8?B?K1FWNkdzNEs4aTZkN0lpK2hsVmFINVpXR2o2TGRBamVCR2FLOEx1U0RoWXkx?=
 =?utf-8?B?dlp0WTd0eFlKc3ZiUjQrSnJyTFpXYU5ZbnhGZ2Y3L2kvWWZoS2kzZVhXK1JV?=
 =?utf-8?B?ZjJlWWIwcE82UEE5WGFQZ2k2MHBxSnFSREJmMVROUlpvN01YR0ZEZ09ZTFBm?=
 =?utf-8?B?d2FlOXZpTWhHb3ZGWVRtMDR6YnZiL3c4eVhqOEJqTTFnZU5USCsvQktQaDNp?=
 =?utf-8?B?MEhLR1J0c2tDemxld0NtYkc3M0tBdlQ0cnhKaXFlSEs4bnZrNUFuSit1OEV4?=
 =?utf-8?B?d2pvZ0kyamg5RXozNG53dHhrZWJ3cllGbTFRUXl1c3V0c3pEQ2JGVWxlcWFy?=
 =?utf-8?B?M0lZcXVwM0gvQ3BrcldTaDRqRmZCY0tBMUVubDJBS2hNcmx3K25QQXF1dm1K?=
 =?utf-8?B?Y1BXSHp3Vy9zRXZhb3ZjWDhkWU1laWpUZFlIYkQ0S3lEWVM2aUMzY2VGQUtw?=
 =?utf-8?B?SHNTQ2VMeDBHNU9PYkRHaXpnQmFqdXNFVmRnRWVrbFJxNk9BbkFYMXN5bmhV?=
 =?utf-8?B?UDRBWFd0aGhvU1hldUdVc0NSVkhJK1ZjcElubUM0MlNEQ2tIQkl3Y2YrczJl?=
 =?utf-8?B?NjhKM0ZzRmc0Y05ienpab2NUWjVBSUxxNVpldDRiU21CVXJzWGZKcTVxSEov?=
 =?utf-8?B?NmdMRzYrZmNmYzQ3bGoyVHFtR1FrUzh4a0c5dUc5bml3NUpQR2xQUHQ4Qnlr?=
 =?utf-8?B?KzRYVHlDNFROVDB2SkV5OFdLd3dLVWM1cmRhZHVtRGFRRmp6czBLVjF6SkRL?=
 =?utf-8?B?enRPaFBRZVl3b0dSTXdScldHa3VubFYzWTBndVAzTEpGV01KMHk3SWd2VW1K?=
 =?utf-8?B?Y293c2hqRGRnVEdsTGJ3eE5EQm9HcWREMklYaW5Rd1F0UjFZSkFYS3lZUG4v?=
 =?utf-8?B?RVptZ0ZnQ3lsTTJNNUdaWmhUbUVVVzgycGlCajYvbUhjOXU0S3h6VVNDaTJU?=
 =?utf-8?B?eDhoemVtSXZEcXNPSjYwVkNQSkpDa2hTbEVXRmU1TEpHeEdiYVRFVUF6aFJY?=
 =?utf-8?B?V0d5UEhIUFBXTW9CcVZ6c0NSVTIwUnhGWEZ4ZEJ4OEd4TjRiSjgwaC8ySzJR?=
 =?utf-8?B?K3BRdm8vMitCNHQ4THdnT21SZytpT21WUVFqR3dSc25mVzlEbUNaT0doWFZ6?=
 =?utf-8?B?TEVYT1dleWI3NGRNVXFUUDcwcWs3dmlnTFd2eEdjRUFxaGdsZkZuRWRzMCtC?=
 =?utf-8?B?K1hBK0RTQlI5ZWZjN3hNL2NMVGhxTUc2UTRRWlduTk5GZjJhQURpTVB5MEFl?=
 =?utf-8?B?TTVGaE9LQlBrSDFqKzQ4aU5oLzFrQUZVUXNPRllmbXNVUFVxY0ZGelZlSWF0?=
 =?utf-8?B?YjRIamo0N1YvOTg0V1hJa2RLcUhJQ1ZYSkFWYXZTK1pmODNiTWtDU3YyTFVS?=
 =?utf-8?B?OHdGRThYeUhsOTNKd00xNHFOOGtHWkdrak1ieFlDS0IzNkZWZWk1RTVWVGRs?=
 =?utf-8?Q?OERD1N/xbpyI21dlVyDp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(366013); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVU5eHNvT213eXhWY1hGS2pJTmorb1Myd1hTMGc2Q0Q2WW1vdlBjQU80ZENx?=
 =?utf-8?B?N3FOZWdVYlJCUG12Y2FCS2lRcFFPdmJCOHU5bDhFOVM4SEw4NXl5NjVuN0dB?=
 =?utf-8?B?Y2RqL2tSa3pwU2JtdElPREwxVWNBb25yaVdKNFlzbXJzemJGMlFQa1hMMXVW?=
 =?utf-8?B?Q3NvUlh4cHhhTFF0WDF1ZkVTQ3pJVjJMVnYwTjl2Q1M5a21qV2NSWCtlVXN5?=
 =?utf-8?B?ZEczeHZEbWVZL0NNbE13dWpFRjdVTlF1QUYxaGVHdjRZUFdMQ1dZd3BPa21C?=
 =?utf-8?B?dDlHWitPY2NuTCtwU2tobHg1VkhSczJoSXBrZUs5b2FYM0k3Yld2ZWo3RFBy?=
 =?utf-8?B?UGQ0T1VzL2E2OHVmVVh4UUlXK04wMCs1ZzBSL253U015UnhIWUNTUXlaNERs?=
 =?utf-8?B?RVV6eE4yNzJDU1BNQytIWGtnSEZBeGhZd1k1SUZqRys2WEoxcm9SRnBpcmdO?=
 =?utf-8?B?RmpXL3RHRnJocGFtUVB2cklLSkRWT2NoWDA2OFh3Y1NjVFpMQjZiMGFTaUtt?=
 =?utf-8?B?NzRMNENPUldHVU9Ub0NRWFZIZ2FaaXpWc2RwdGVHOEk0MVJ6MTZveXhXWSsz?=
 =?utf-8?B?cHZUUGc2MUs3ZE1MRlVtVlhQVXhlWjlndUpyMTl6QWNsckZNODlMa08rT2ZL?=
 =?utf-8?B?ajlyVldja1NVYVZKM0hNb0ZQd2xEMVZuRjNZZ0ROa1c2L2NrTHR0RStrVHZT?=
 =?utf-8?B?N3lpbXhGMzJKcVhvUE5vZGpDc3doZ1c1TmNuaXBwdkhLTUZkR1hpWmRhVUZh?=
 =?utf-8?B?bWxUOVpVUDB2dTVvVkN5YUd4dDlybWJCMUxlQUhaQzA1M0RXZDlkZUpQTm9B?=
 =?utf-8?B?ZCt0V1VGbnNCS2s2ZVo1dU5wZDRFVzM4ellnbW4xR0dxTjcrdkdEa3BhRXl4?=
 =?utf-8?B?WDYvcmZEMXB1YmNHS2xLWkhTMmxyOG55STZJaHJWaWE5Tlo5UWJRU1FpR0VL?=
 =?utf-8?B?YXJ3ZHRicHozelJYcDNXZ2F2NjVQUWdpQm9DcU9UTXlLUkQxT09ma0ZtMXN2?=
 =?utf-8?B?SE5JbXNmVUgyVzJ5WjdUYy81eGo0UXRHdkplM3ZIeHk0TDBDTVdtYjFlK0hI?=
 =?utf-8?B?RGhYSHZZMmZ5cmJvQlBGaEdlRnhCTmpmOUpwSXhVVzBXM2JNNXZRQkZGSTRW?=
 =?utf-8?B?WEsxU205dmZMbHdQT3FYdWhReDl4MGM0ZFRESUtpYytmaVJralBmUnhZUVN3?=
 =?utf-8?B?TTdmU3NpYjErN0R5UllqNW9Jb1dTSDQxY3VzeDJYSXNGeTJDRVBCZTlSZGl5?=
 =?utf-8?B?SU9Rd1B4Vk1Pd0dOalYxZm44b1pHYmt3SW5ydUpEa1RyMzNDVDMvTEVmbWpr?=
 =?utf-8?B?bkY2WVhJQ0VMek1xRDlzMkM3S3YxenRROTNEcC9sOUJnMTV5V2RkeUUwTXEw?=
 =?utf-8?B?S1k5RGNNQzBsa1dzOHoxSVlnSy9Za2ZSTmE2Mk5IMUxWU1VYMEZXQ0J6WjRF?=
 =?utf-8?B?RkdDWkJwTFFvSjUrRjJoNmlFUURtZW52Rm84Y1lFWGsrN1U0SEhJM1dvTHlQ?=
 =?utf-8?B?azJGenNFQ1U0V3ZoUHJpZDA0bjljSTJVajYwdmU1UjV5VWltVkdkdml2NlNR?=
 =?utf-8?B?TU1FUFNGdnVhMG5uN0VJekc0L2tTZVljdmFMcWM2aElSUkpSaTJTZHB5dTNC?=
 =?utf-8?B?aGRvOGs2clNXSEhacCtjUnhhUFFEdWhVRFp5V0UyQURQOEJTL0Fva0lwcENS?=
 =?utf-8?B?VFdHYW9ZTFN4UXhFWUxqd0tjYmxXWnA1TnJqT0FpWWlkSjBNKytBOG9OMysw?=
 =?utf-8?B?bzNGTndpZGcxeGxra0FZaThmSm9NOGhoRk9xdjNtaHNSVUNLdjhpTENNNFkr?=
 =?utf-8?B?SjVoQi9scGRvcjBNYVo1bFZINTBpcGJ1eFAwTndXVW5sN05NZlNWaU5xZzlh?=
 =?utf-8?B?Z3FOM3RtcXV1Rk9Cb3hKd3Q1dlc0U3VWTWUrbHlWaVNvelVXTlJBWVg1ZkRE?=
 =?utf-8?B?RWRsR3U5NGZiQUtHUnBLbWszcjYrYXlCb1pyTE1URjhTUTBuZ0xBZjB2ZzFq?=
 =?utf-8?B?VnlkNlI5c1VkVXF6SHM3ditRNHh2Y0tlK2dNTU9RL1l4djQyMEV4RGhjb2Z2?=
 =?utf-8?B?clRURUNSNGR1eEMvNGpyMkRXcXNFcnk1ZkkrQ2tYMk9aQ1FxS0tHVUNXVG9u?=
 =?utf-8?B?T2oySENHZ2VGNU5OOFdiWk5QZHRQYU5ZeXZNZ2J2aExSdDk5eWJxbWcxR3d1?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5c2265-005b-4b69-484a-08dc9140671b
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 15:48:17.4445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nwLL+sSbeQxdffCEUyB/Dfs+/aazy/QGlZkAPoW6xbu7QPJX4DTIZ7INb+4E3+ip69DAieTPcmNnqwzW2um5Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9510
Subject: Re: [lttng-dev] Compile modules on Centos Stream 9
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

SGkgSmVhbi1NYXJjLAoKT24gNi8xOS8yNCAxMTo0MSBBTSwgSmVhbi1NYXJjIENoZXZhbGllciB2
aWEgbHR0bmctZGV2IHdyb3RlOgo+IEhpLAo+IAo+IElzIGl0IHBvc3NpYmxlIHRvIGJ1aWxkIHRo
ZSBsdHRuZyBtb2R1bGVzIGFnYWludCBDZW50b3MgU3RyZWFtIDkgCj4ga2VybmVscz8gSSBzZWUg
dGhlc2Ugd2FybmluZ3MgYXQgdGhlIHRvcCB3aGVuIGF0dGVtcHRpbmcgdG8gY29tcGlsZToKPiAK
PiBtYWtlWzFdOiBFbnRlcmluZyBkaXJlY3RvcnkgJy91c3Ivc3JjL2tlcm5lbHMvNS4xNC4wLTQ1
Mi5lbDkueDg2XzY0Jwo+IC9ob21lL3RtcC9naXQvbHR0bmctbW9kdWxlcy9zcmMvcHJvYmVzL0ti
dWlsZDoyODogRmlsZSAuL21tL3NsYWIuaCBub3QgCj4gZm91bmQuIFByb2JlICJrbWVtIiBpcyBk
aXNhYmxlZC4gVXNlIGZ1bGwga2VybmVsIHNvdXJjZSB0cmVlIHRvIGVuYWJsZSBpdC4KPiAvaG9t
ZS90bXAvZ2l0L2x0dG5nLW1vZHVsZXMvc3JjL3Byb2Jlcy9LYnVpbGQ6Nzk6IEZpbGUgCj4gLi9h
cmNoL3g4Ni9rdm0vbGFwaWMuaCBub3QgZm91bmQuIFByb2JlICJrdm0iIHg4Ni1zcGVjaWZpYyBp
cyBkaXNhYmxlZC4gCj4gVXNlIGZ1bGwga2VybmVsIHNvdXJjZSB0cmVlIHRvIGVuYWJsZSBpdC4K
PiAvaG9tZS90bXAvZ2l0L2x0dG5nLW1vZHVsZXMvc3JjL3Byb2Jlcy9LYnVpbGQ6MTgxOiBGaWxl
cyAuL21tL2ludGVybmFsLmggCj4gbm90IGZvdW5kLiBQcm9iZSAiY29tcGFjdGlvbiIgaXMgZGlz
YWJsZWQuIFVzZSBmdWxsIGtlcm5lbCBzb3VyY2UgdHJlZSAKPiB0byBlbmFibGUgaXQuCj4gL2hv
bWUvdG1wL2dpdC9sdHRuZy1tb2R1bGVzL3NyYy9wcm9iZXMvS2J1aWxkOjE5MDogRmlsZXMgLi9m
cy9leHQ0LyouaCAKPiBub3QgZm91bmQuIFByb2JlICJleHQ0IiBpcyBkaXNhYmxlZC4gVXNlIGZ1
bGwga2VybmVsIHNvdXJjZSB0cmVlIHRvIAo+IGVuYWJsZSBpdC4KPiAvaG9tZS90bXAvZ2l0L2x0
dG5nLW1vZHVsZXMvc3JjL3Byb2Jlcy9LYnVpbGQ6MjEzOiBGaWxlIAo+IC4vZHJpdmVycy9iYXNl
L3JlZ21hcC90cmFjZS5oIG5vdCBmb3VuZC4gUHJvYmUgInJlZ21hcCIgaXMgZGlzYWJsZWQuIFVz
ZSAKPiBmdWxsIGtlcm5lbCBzb3VyY2UgdHJlZSB0byBlbmFibGUgaXQuCj4gCgpUaGUgbWVzc2Fn
ZSByZWFkcyB0byB1c2UgdGhlIGZ1bGwga2VybmVsIHNvdXJjZSB0cmVlIGlmIHlvdSB3YW50IHRv
IAplbmFibGUgdGhvc2UgcHJvYmVzLgoKVGhvc2UgcHJvYmVzIGRlcGVuZCBvbiBpbnRlcm5hbCBo
ZWFkZXJzLCB3aGljaCBhcmUgbm90IHNoaXBwZWQgYXMgcGFydCAKb2YgdGhlIHB1YmxpYyBoZWFk
ZXIgcGFja2FnZXMgZS5nLiBrZXJuZWwtaGVhZGVycy5ycG0uCgpPbmUgd2F5IHRvIGdldCB0aGUg
ZnVsbCBzb3VyY2UgdHJlZSBpcyB0byBleHRyYWN0IGl0IGZyb20gdGhlIGtlcm5lbCAKc291cmNl
IHJwbSwgZS5nLiAKaHR0cHM6Ly9taXJyb3Iuc3RyZWFtLmNlbnRvcy5vcmcvOS1zdHJlYW0vQmFz
ZU9TL3NvdXJjZS90cmVlL1BhY2thZ2VzL2tlcm5lbC01LjE0LjAtNDUyLmVsOS5zcmMucnBtCgp0
aGFua3MsCmtpZW5hbgoKPiBJIHRyaWVkIHdpdGggbW9kdWxlIHZlcnNpb25zIDIuMTIuMTcgYW5k
IDIuMTMuMTMgYWdhaW5zdCB0aGUga2VybmVsIAo+IDUuMTQuMC00NTIuZWw5Lng4Nl82NCBhbmQg
SSBvYnRhaW4gdGhpcyBlcnJvcjoKPiAKPiAvaG9tZS90bXAvZ2l0L2x0dG5nLW1vZHVsZXMvc3Jj
L3Byb2Jlcy8uLi8uLi9pbmNsdWRlL2x0dG5nL3RyYWNlcG9pbnQtZXZlbnQtaW1wbC5oOjEzMzo2
OiBlcnJvcjogY29uZmxpY3RpbmcgdHlwZXMgZm9yICd0cmFjZV9zY2hlZF9zdGF0X3J1bnRpbWUn
OyBoYXZlICd2b2lkKHN0cnVjdCB0YXNrX3N0cnVjdCAqLCB1NjQswqAgdTY0KScge2FrYSAndm9p
ZChzdHJ1Y3QgdGFza19zdHJ1Y3QgKiwgbG9uZyBsb25nIHVuc2lnbmVkIGludCzCoCBsb25nIGxv
bmcgdW5zaWduZWQgaW50KSd9Cj4gCj4gQW55IGhlbHAgd291bGQgYmUgZ3JlYXRseSBhcHByZWNp
YXRlZC4KPiAKPiAtIEpNCj4gCj4gLS0gCj4gLSBKZWFuLU1hcmMgQ2hldmFsaWVyCj4gIMKgwqBU
ZWNobmljaWVuCj4gIMKgwqBHw6luaWUgaW5mb3JtYXRpcXVlIEfDqW5pZSBsb2dpY2llbAo+ICDC
oMKgTG9jYWw6IMKgIMKgIE0tNDAwMgo+ICDCoMKgVMOpbMOpcGhvbmU6IDUxNC0zNDAtNDcxMSB4
NDI2Ngo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBo
dHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRl
diBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0
dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
