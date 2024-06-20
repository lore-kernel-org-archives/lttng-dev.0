Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D58C2BA1A
	for <lttng-dev@archiver.kernel.org>; Thu, 20 Jun 2024 15:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1718897191;
	bh=2lccLXTap0t+eNi6OpGhxc/kElM1KLVEk1TEKXqejKc=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=0cTDH1uh7PKtbDGb02AqlFSkIXvSgCESy8lR83IchN6cpxNLjsjDNp2cExdxVBI5e
	 eyoIE3/X0/0mE17YlzWP7FAn1bz36EeXDeacLlMN40N+iv/Ygs92D1pPencnnAdgRf
	 YvmU5QWSHfMHOkeMGps1fDJr+ipwat2vdYcL0F8+c/3jxBJaTdrXS3LgfzrvgWKSPW
	 n82qZPZWdJhGcwosqHYoeAQnJiIicXOFQ3tWSWtkSfgcKHMZn6GozdMIDahV7TPJ4b
	 1HFcZaoxPFbdFEGmK95eWBy9++HTsPOhwhzDUJicyQycM4kLqqYhWP3Yfl8rpYnmPn
	 Dok9Qk7Qt1rbg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4W4kqB5JFWz4nw;
	Thu, 20 Jun 2024 11:26:30 -0400 (EDT)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2108.outbound.protection.outlook.com [40.107.116.108])
 by lists.lttng.org (Postfix) with ESMTPS id 4W4kq84zhwz4rP
 for <lttng-dev@lists.lttng.org>; Thu, 20 Jun 2024 11:26:28 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6yU26sCFDvuen0vyYpZxeoxbCxKkegkOZPczN0iVBH8TCMwUVpKGJbLIYQcWRvS6x0e3T4s1T63wpjlq5Xt/SFLMmZdhc7C8L/W7xmONoZ5tsiO8b/npSRuwD3rGO512N2Hk3e6UOASFR6kr0cYaVHU/oUgoaQ8zpLDOU7QyKXfocMlAvMeHgKu/BaY9yiNseJQRIm3aY0R6sjrNdPE5hlaknvKRb/e5ZDXRMMQWJ7OLR00gEc6Vavl4IEP2O2oK2dZvJJxsvAZcXbGc+ssy9dkhPTkSttA97CExJHSSw/K6n3Y0BLy8saRLEwL/zzMDnRJyReZ14KFga/wgclN/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEWLc3L9AEQBckCSsk+HLBlh1afWD72EII8oZ/jvxxE=;
 b=QmLV10gFCNBMUzW21XLONdE3OeVXIXXAJPtEq1kbfC8P31gyVoX0uHCz54AZnNTdkQEGURwyueITHZdlmxAKbimDpeB4YVym+7+95yTdLFZNGFGtkQhQ0wMy3yaqXcYq5fHw7l+7IJqqxlovTUToekFVFjPm3zBmiuY7vPvylKFP8EjIzQDHDE4LjiwGCPJWUV6F7MF1pN/thsSHiqw1joBzZOjrg9HMt92k2dMuPtDXRlJI7RVn9+ig+LJzDpRhkku8hAMkREgk0RBsYnt0ROqXORJNOte4h+hBoStslOuTEBkl6r363uJ+sML8DHe39I6S+WhDFmyBoQouwNcTBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT3PR01MB9250.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 15:26:26 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%2]) with mapi id 15.20.7698.019; Thu, 20 Jun 2024
 15:26:26 +0000
Message-ID: <ff7f120d-8d44-427b-9c46-1809378c9203@efficios.com>
Date: Thu, 20 Jun 2024 11:26:25 -0400
User-Agent: Mozilla Thunderbird
To: Jean-Marc Chevalier <jean-marc.chevalier@polymtl.ca>,
 lttng-dev@lists.lttng.org
References: <364622686.75839325.1718811716721.JavaMail.zimbra@polymtl.ca>
Content-Language: en-US
In-Reply-To: <364622686.75839325.1718811716721.JavaMail.zimbra@polymtl.ca>
X-ClientProxiedBy: YQ1P288CA0003.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::25) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT3PR01MB9250:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ddde08b-8ea9-4011-48ac-08dc913d59e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVJOWVR4MlZMd01weWFKT3JYNS94TXhIU08vbVcrYmgySDBxUmFVN0N5Q2Zz?=
 =?utf-8?B?UWpGRis3ZXg0NUxjejJSMkhudWFUN282RGFoaUE2NmpjMVRyNTN2NFMydVZP?=
 =?utf-8?B?TVpYOWduaTRpWnJxTDlKc0JYOUw5K1dMRDlnaFV3cFFLUEZXQmllQjhBUFE1?=
 =?utf-8?B?dzExdFQzbW9DOG5SSE1mSUNUdzV1b0IyenBRUFRsbDBHM0RxL29IbTd6UldK?=
 =?utf-8?B?bllwTUd4TFVBNmZIT0ZaUTY2NTFmb1ZrVTJRb1FLUTVMZXpJMmNxVEx4M2wx?=
 =?utf-8?B?Wlh2VzBnY216WkpBbm8rdWZQbEY5MFdkQ2hCM21wbWJhRkpEZmxGcW9NUXg5?=
 =?utf-8?B?YlhWRFl4bExlczcxUnFDSXlDdkRNUnBSN0VJYnJjVVdZZVM5NXMwS1d1OU1O?=
 =?utf-8?B?REozZXVsdmg3SXBsOUtXb2JmcmNUM3lRK2V5TmJNNmpWYlZCNHFyS1pqYVRJ?=
 =?utf-8?B?TnZER3dnM25nNC9IWTh0N3JVY3N4MnJXYzBSQ3VmNkhDQmc3WTYyREdCbHI1?=
 =?utf-8?B?UXIzVDkyMlJEcmordm5NSnNncnRtN3pGVUhqUk9CVFV3UG5VN3JoMWh3TkN6?=
 =?utf-8?B?Vm9FbHZFRWxkNjl4NXNNTnNsamhiMUVNUnF6eksrRW43U3JRTnlsaEM5TjVY?=
 =?utf-8?B?L0pabUZlc2psMm1RRzByS1NPeTNuemIrUTlXbTAyM0VUd2dvdnh2T3lkL2Y5?=
 =?utf-8?B?RG9ZTzUxa0RoclBnMGRhU0dwTnV6d2ZUUHJmM3ZqbTViVVBXTlFWdThSaXg1?=
 =?utf-8?B?TjJHOHVFY29QZVB3bUtHQlJGM01YaFJPbyt2Zlp1TXRxcnlEOXk1dkxCV3Bk?=
 =?utf-8?B?VTJ4Ymh2NFhESlNWcTgybVMvYTg1UjZPeEt1d1NPY3JDcU9UdWhjR2I1cEdK?=
 =?utf-8?B?NDJVZURUNiszZHNMUWl5WGJVbVZTdEJ2ZXFlK1JSeXlXZHFMczVURkllOUlR?=
 =?utf-8?B?MEY5Y244Zy9CbmRsNTM1RTY2TFJJWDg5YUZDMWR2VXdDbnB5RzJLaDBQUGd6?=
 =?utf-8?B?cS95em9uUUVEMVBpYUZQRm11SnM2a2MzcUlobHJ1WUhEbDFWOWcyQmp3MzNJ?=
 =?utf-8?B?M0t0R3pyNFBIYVZkTUZnQmNwZ2tVVXZITHVxZk9aZUcwSVczZkdnQlZNVml4?=
 =?utf-8?B?L3BaK1RRTFkxY1RwcHgzdWhwVkJ1NklJWEw5WGJlaURVK2dFbktkdmtCUHBl?=
 =?utf-8?B?ZUNWNStoZEtJQmU4TUhveERYUzRTN3Z4MzhaTVBMMG9yZDdUekhEc3RVbXRN?=
 =?utf-8?B?TGVPUHNYUndOZ3pQZFFsTzY2cWw5U2dacFZMRWJaVEp2bFduUzhUR3NsaGRZ?=
 =?utf-8?B?Y0E4aWFGdDlNYS9KODhqRnM5bUZkK0lER2FpVDI4bUthSnB3RVY2aTlKVVlW?=
 =?utf-8?B?NkF3VzUybHk4RFVES1FESVZtQy9DMWo1T1dWazJJUFRtbXU0U0dQWUJGbmpq?=
 =?utf-8?B?R2FGUmxaS2xuWHkreE5HQ2N0c1QyOUdYV21WUkpoN3hoYkxueEs0S2FzcHpu?=
 =?utf-8?B?WW85NXRPbWhtZCsrNVBRTDg4SjFsbjRLTDNrT1lGaEFDSU90ME9pQ0x0ZUdO?=
 =?utf-8?B?bklBNjBqY0pIQ0NVczZzZFk1dmljaXBkVW54U3BxTFF1b3NlS1hoYzk1V0c2?=
 =?utf-8?B?ckVuMWhuRm5nZnZvdlNWVjNEdXl6MzVwUkNvSGZ4V3YrWDJWKytDQWJFNWdM?=
 =?utf-8?Q?0V6Cza9Md9Op/0BV56gc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(376011)(366013); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmFMeEswZTFjYlFOSnJHMTlldm1KdkNJeUY2NnZhOTBDemxVMUlQRi8rS0I3?=
 =?utf-8?B?akU3RzBacjdFaUhIMmRnOXpEcm9IOW9aakhZUDYwOXA5OEpRZm9iQkJHbWpj?=
 =?utf-8?B?UHRDeldWRFc3bTk2VFp0bFJwSVdsYmliNE5MY1JKbVJDdURnaGdpVEs1bVYy?=
 =?utf-8?B?em54bUQ5d25RZkNxOHhaZlRSakxPcGNSOHpnWFByM3JEUFhlejhieEFmeVVr?=
 =?utf-8?B?L0hqYU52NjJhWC9sRHE5UkczUVdkUFdETzRRZTVWeUZraEJHVVFxUWxxcDhh?=
 =?utf-8?B?VWR1N2tWT0dUOVZFRlB6SDJ6eW9lK2lNS1R2c3dDNmdYM1dPR3hsT3VVb2VU?=
 =?utf-8?B?NlVpNDZBbHh3UU5mV2NaZm5uOVFRZUdYL1NhRlpLK0pETzlZamRFUW1lTmJH?=
 =?utf-8?B?Ui9BSDA0elVsZHg2cUVEUXovM3FlRmI5aEJ4S2VCZ3o0djh4U2ZNMENDNXB0?=
 =?utf-8?B?RFF6WjV4TXI0dzZTblAxYXE4TkR5UGdHSCtQWnNTQzZSaU55RisrVEE0eHlI?=
 =?utf-8?B?bEZIdWdGdDFEZEpyUkhtbmNEWmlrakxmU0k4M0x2eVF6azBKdGtPRVZYSUxT?=
 =?utf-8?B?aC9iZ0NreHdMWkdoZDExdndCSnFwa3ZaWXY2YnM2enlPMFA3OHlYdi9nM1ha?=
 =?utf-8?B?a3UzMFllSzVkVFpSV2ZXa3FDMVVzby80cVVuaFVYVitEVE94b3ZDbXkvN3dL?=
 =?utf-8?B?WnNTWkNGT0xZai9Eb1J0MmJyaWRReHB2ZE1GaDFmaGNtTnBVanlXNkFrK0ZZ?=
 =?utf-8?B?dGhzTGVzVTVYN3pSOS9mckNjaFdDNFVZNVRVNXhBelV4ZFBsd1UvdDZLcVVO?=
 =?utf-8?B?bU1NZ0x6WVBPeitUaVVCdlJCd21kbHAzcG94ZW1QdEV6V1Z3eVlTaDRzT09y?=
 =?utf-8?B?QTRHU25TOW1yT1gzeDh2TElLUy9NSnphZmtvZjdUeHlCY1c2cnNDVWlRbWVU?=
 =?utf-8?B?dDVka1Z4S2xJZ1ZoYzE1OGhUK3ZHUlAzZDlCWTEzVlBwVnFxendkN2JDaU5M?=
 =?utf-8?B?aXlqNnVMY1RKQUJTMXRpNjRublhGZEhZVVlKck9kYUxQbWRwNWkvbk9nN0VK?=
 =?utf-8?B?TjZBYThUWFVRYzh4Qy84REhQRzZhSGljTElUWGN5U1U2cjRoTjhKV085M05y?=
 =?utf-8?B?MWpvYk1EZ2xIb2czc05iTW9QczlXZFB3UlR2MlhpMUZKVVFUTU51QTRjeHB0?=
 =?utf-8?B?Z005Z08zZlNoRVFhMEtiQXlKNkJSdnFuN0tuU3ZhZWlHTGUwQ2I1TWNCdytu?=
 =?utf-8?B?dHBySWRpYkN5ckZOWWhhYTNoUjdzSWowR2FDL2l3RFNTblUvcExnY1dRS0Mr?=
 =?utf-8?B?S0dXSDE3QUcwdUVHMzRQZVNUNENrMDU4Q1hPMHFTTTQ1TytoQldod2RHbWFl?=
 =?utf-8?B?U0NNQ2xrUlNLd3pzbGc4ekIvdzdBTkpKcm1IUmpHVk5XbHVDVDRoN1hUOThx?=
 =?utf-8?B?bUZPTnFTcEh5Y0Nqc1VJU2VRRm1YTFp0ZGpGVng0b2x6RlB3OUp6d0s1VS9F?=
 =?utf-8?B?eklvbEFrcDA2QWh6WWM5cEozTFBJU01KakpQb1VsWGQ0N2VlU1dieVZvZjNG?=
 =?utf-8?B?ak5IRXYyYXpUOTRRemRSZkxhV09uaklSQi9zT3llbHdkUTFVVWxHcjRJZlA4?=
 =?utf-8?B?WU1qYkV4QkpYMUdxeTVxSWtXM2pDb0NtTGp6Mm5xOVZhczY4YyttTjg3Myt6?=
 =?utf-8?B?dFlibGJCVDljOVJEOTVmOWs2OUM0VmxacE5OU1NUME5nWmJwRXE1dUV4cnRa?=
 =?utf-8?B?WTJWNm0yaXViWWtEUWhEMkgvNTNFRkdEQjdtMHhod3BPOE1nNFlQbStEVWI0?=
 =?utf-8?B?eUo2NnRVY2R5MnBwQ0lkTm54c3lmRXdmNzdydmtwRjlLdkdmQ1dHWlJPdWYw?=
 =?utf-8?B?V3VsNkFwUitTU1pQZlgwUlIxazgwZ2lKSUQ4NmRFdGYzSVgvOTY0VDNOVHlL?=
 =?utf-8?B?bTJrWEF1RHhZWEdPYmZML1p2WjhBR0thbkoxdnM2VUpWUy9KR2VoWWZtRlYv?=
 =?utf-8?B?WGFVSWhNTThUSzRRUi80dFF2cXVWaUxkb1hLV2VzTXlBYlhObnV6REhPbVUx?=
 =?utf-8?B?R3FCUlBvL0o4alFnejdhTnpJdXhQczhnb0plUDRvbjBUbGZCSWRNR1ZWcUlV?=
 =?utf-8?B?U2pFRHdabjdKdVI0Wit4blp1aVh2YVgvc0pRVHhnd0tPVW94ZXZzVzJnWkp4?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ddde08b-8ea9-4011-48ac-08dc913d59e5
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 15:26:26.7935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mgs1HYtK02UvcbPqmWPyDlxPKocH2YOr6ZNa7om1ihRbjX8nLNt2SU+0eyOML9W00YnvMlUVscwmeH0VF68iiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9250
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

SGkgSmVhbi1NYXJjLAoKZm9yIHRoZSBidWlsZCBlcnJvcnMgY291bGQgeW91IHRyeSB0aGUgZm9s
bG93aW5nIHBhdGNoOiAKaHR0cHM6Ly9yZXZpZXcubHR0bmcub3JnL2MvbHR0bmctbW9kdWxlcy8r
LzEyODg1ID8KCnRoYW5rcywKa2llbmFuCgpPbiA2LzE5LzI0IDExOjQxIEFNLCBKZWFuLU1hcmMg
Q2hldmFsaWVyIHZpYSBsdHRuZy1kZXYgd3JvdGU6Cj4gSGksCj4gCj4gSXMgaXQgcG9zc2libGUg
dG8gYnVpbGQgdGhlIGx0dG5nIG1vZHVsZXMgYWdhaW50IENlbnRvcyBTdHJlYW0gOSAKPiBrZXJu
ZWxzPyBJIHNlZSB0aGVzZSB3YXJuaW5ncyBhdCB0aGUgdG9wIHdoZW4gYXR0ZW1wdGluZyB0byBj
b21waWxlOgo+IAo+IG1ha2VbMV06IEVudGVyaW5nIGRpcmVjdG9yeSAnL3Vzci9zcmMva2VybmVs
cy81LjE0LjAtNDUyLmVsOS54ODZfNjQnCj4gL2hvbWUvdG1wL2dpdC9sdHRuZy1tb2R1bGVzL3Ny
Yy9wcm9iZXMvS2J1aWxkOjI4OiBGaWxlIC4vbW0vc2xhYi5oIG5vdCAKPiBmb3VuZC4gUHJvYmUg
ImttZW0iIGlzIGRpc2FibGVkLiBVc2UgZnVsbCBrZXJuZWwgc291cmNlIHRyZWUgdG8gZW5hYmxl
IGl0Lgo+IC9ob21lL3RtcC9naXQvbHR0bmctbW9kdWxlcy9zcmMvcHJvYmVzL0tidWlsZDo3OTog
RmlsZSAKPiAuL2FyY2gveDg2L2t2bS9sYXBpYy5oIG5vdCBmb3VuZC4gUHJvYmUgImt2bSIgeDg2
LXNwZWNpZmljIGlzIGRpc2FibGVkLiAKPiBVc2UgZnVsbCBrZXJuZWwgc291cmNlIHRyZWUgdG8g
ZW5hYmxlIGl0Lgo+IC9ob21lL3RtcC9naXQvbHR0bmctbW9kdWxlcy9zcmMvcHJvYmVzL0tidWls
ZDoxODE6IEZpbGVzIC4vbW0vaW50ZXJuYWwuaCAKPiBub3QgZm91bmQuIFByb2JlICJjb21wYWN0
aW9uIiBpcyBkaXNhYmxlZC4gVXNlIGZ1bGwga2VybmVsIHNvdXJjZSB0cmVlIAo+IHRvIGVuYWJs
ZSBpdC4KPiAvaG9tZS90bXAvZ2l0L2x0dG5nLW1vZHVsZXMvc3JjL3Byb2Jlcy9LYnVpbGQ6MTkw
OiBGaWxlcyAuL2ZzL2V4dDQvKi5oIAo+IG5vdCBmb3VuZC4gUHJvYmUgImV4dDQiIGlzIGRpc2Fi
bGVkLiBVc2UgZnVsbCBrZXJuZWwgc291cmNlIHRyZWUgdG8gCj4gZW5hYmxlIGl0Lgo+IC9ob21l
L3RtcC9naXQvbHR0bmctbW9kdWxlcy9zcmMvcHJvYmVzL0tidWlsZDoyMTM6IEZpbGUgCj4gLi9k
cml2ZXJzL2Jhc2UvcmVnbWFwL3RyYWNlLmggbm90IGZvdW5kLiBQcm9iZSAicmVnbWFwIiBpcyBk
aXNhYmxlZC4gVXNlIAo+IGZ1bGwga2VybmVsIHNvdXJjZSB0cmVlIHRvIGVuYWJsZSBpdC4KPiAK
PiBJIHRyaWVkIHdpdGggbW9kdWxlIHZlcnNpb25zIDIuMTIuMTcgYW5kIDIuMTMuMTMgYWdhaW5z
dCB0aGUga2VybmVsIAo+IDUuMTQuMC00NTIuZWw5Lng4Nl82NCBhbmQgSSBvYnRhaW4gdGhpcyBl
cnJvcjoKPiAKPiAvaG9tZS90bXAvZ2l0L2x0dG5nLW1vZHVsZXMvc3JjL3Byb2Jlcy8uLi8uLi9p
bmNsdWRlL2x0dG5nL3RyYWNlcG9pbnQtZXZlbnQtaW1wbC5oOjEzMzo2OiBlcnJvcjogY29uZmxp
Y3RpbmcgdHlwZXMgZm9yICd0cmFjZV9zY2hlZF9zdGF0X3J1bnRpbWUnOyBoYXZlICd2b2lkKHN0
cnVjdCB0YXNrX3N0cnVjdCAqLCB1NjQswqAgdTY0KScge2FrYSAndm9pZChzdHJ1Y3QgdGFza19z
dHJ1Y3QgKiwgbG9uZyBsb25nIHVuc2lnbmVkIGludCzCoCBsb25nIGxvbmcgdW5zaWduZWQgaW50
KSd9Cj4gCj4gQW55IGhlbHAgd291bGQgYmUgZ3JlYXRseSBhcHByZWNpYXRlZC4KPiAKPiAtIEpN
Cj4gCj4gLS0gCj4gLSBKZWFuLU1hcmMgQ2hldmFsaWVyCj4gIMKgwqBUZWNobmljaWVuCj4gIMKg
wqBHw6luaWUgaW5mb3JtYXRpcXVlIEfDqW5pZSBsb2dpY2llbAo+ICDCoMKgTG9jYWw6IMKgIMKg
IE0tNDAwMgo+ICDCoMKgVMOpbMOpcGhvbmU6IDUxNC0zNDAtNDcxMSB4NDI2Ngo+IAo+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1h
aWxpbmcgbGlzdAo+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBodHRwczovL2xpc3RzLmx0
dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QK
bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmlu
L21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
