Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C59C54FB3
	for <lttng-dev@archiver.kernel.org>; Mon,  2 Jun 2025 17:25:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bB1211NkQz1Jgf
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1748885114;
	b=K6Cxx9xabPAhazX2Z0+p+hNcgt0M6pQm+iFjyjdyy9vrMXxNxcERhSempHemGp9IDmz0
	 vvlhqbCy4wvQ592OlwLQKgzUVRt9P2liGmVxVhNRgNRMNThjdKBX+b83+rbKYG6GCDk5D
	 +fCf7FmU8+0zjK4KHBjh//PM+i3bl9zDRhZ9Hr9rKUThr+oM59Ei2LgUzQGvsQD7hKHnJ
	 rKn6+tYQhnr2dLZo0S7VIl3KLwcQUGplYWX7422XCbXz30gc+tmiWe8oBAd4VMAx1w4bX
	 cJgQ8d5O6YtVZMtbbr9c0HBGCmn8Afdv49w+Qnp8M1q38iz69n88EtfXyuX9+8kJxXw==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1748885114;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=uXvllItzZ1xiGoM8YddiZ80YX5KxAcoYTpfkWc18n30=;
	b=TtmvzKZXQESDEXYHKNIKTyfTDYuHrxjTMdOvsrmOhKqLyY487ofXtskGIFGPCQQ8K/w/
	 cuQSIN76Z7+U8amaS+MdE+XqgjJZzXXxY7zL9etaJHrGO0h7WB+bpfSiDzd64pK+ekRxO
	 5JaQnsKmn7lgFhp28QQ0B93ODngTkOwd+mDXaNWQ78795hg7QTpC7d48quIdfo4EcE+1C
	 y0qQZesyMpJY7XIQvBTJCVZaOX77tGbQlANmjOk/nwi58msyQ3uhml20rr3s8dhs52RXc
	 7G3WLaxXOr1clkt9oegtzXKTwFYklAbtjFn+Ce4Ev4gvEfVnt1VhP+XfkW5zkuWIrEQ==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bB1211NkQz1Jgf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1748885114;
	bh=uXvllItzZ1xiGoM8YddiZ80YX5KxAcoYTpfkWc18n30=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=FFVUlwoXSxCPWxdMDzwLIYaHsiRnoYtgZE4tHBe0WrIxet767/VXt7yjGTJXekfDO
	 lgopNhEOUg2dHF9kIecx/drwoNRZuz8MAuBNTxTp4VQR6sYNbd3YPdQ3ndjqNWAv2T
	 rMeOSOlE3dc2Icp5Lf1dhdXXy5MGYNGTne5LO9C07YKyPDLro0pE9q6du/RDJmhRiW
	 2xgbg3J/EbsZWiDnFLJzjlSwxFzzdjDLtemMbkw6ed+c6DXJwwZ8Ztl2gPyAneeFuV
	 DFTN87R/LqCNR00LM2cHG/Z1Zo4J0ew/qF1o1AYzE6t3ZKpSochHBpIXOibH9Je5rr
	 Vy3kJy50tMcVw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bB1211NkQz1Jgf;
	Mon,  2 Jun 2025 13:25:13 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bB11s58Zxz1K67
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bB11s58Zxz1K67
Received: from YT3PR01CU008.outbound.protection.outlook.com
 (mail-canadacentralazon11020135.outbound.protection.outlook.com
 [52.101.189.135])
 by lists.lttng.org (Postfix) with ESMTPS id 4bB11s58Zxz1K67
 for <lttng-dev@lists.lttng.org>; Mon,  2 Jun 2025 13:25:05 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUmL1qVv0zhHrj1OqYoCEplIn67MMXMohx5AzGpwar2aboX+bNvJdxNEndRoGmkE+Tj8gtEuN/u7wyz3sVibrT9LqWzkisGAOpUec66hOrrtV7g4g2zX9+xJv2ylsNRirIg0u9BN25GG+55uFpuo0kxFiY3IPxPqpR7LDKBvgCKLYjTiJBQ/2iJuXm2l2v1He3gf+5C82gxwnw8DkDbR96jesOIJSAFrbqoApxenq6EIFZeoZtlxB0zUACtOLbZv0EPeJ/ZeyIXvJZnAeAIdELM1LDB0cQ9r4/AT6ftDV2/K16H3/UI6vukLL5JgrPII9Q6fw3Rqbp0Qwv1Y9u1dOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQczCfilSVGNo20Yq48F5yIRbu+JeBgACQsPndqNm+Y=;
 b=c7JefdJUr9tMFuXlJB40Hmx/wbsK2UN9fTe0zKoiNFasAMdC6IqiXGQmaaCgTxV+TtDrOiLOD6OBipbS9Dz/1zbRLqPbQkfRu/wZnxlzrnKfQcsr1fRRExKAhZ/DbG4pWAmsJAN7haI3wuatl8BcD2pfQP38jPPrYVX/PX7foNm3OgI1pX+fP66jBGw+RlyL/dZAXOcYrSWLuOPjh+oc3r5+oo2YEYtOy3/Xo8qZB1b83oO0v/chQEA/hdWCSbeMnAbxeoxUgrRwOVWSIg1mI1WTBNHomNbK0tZjGiF/+cU7Go05N1Rc2Wr5DLCnd5udG6RriXRDKorip7HMy9VvaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB6109.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:59::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 2 Jun
 2025 17:22:56 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8792.034; Mon, 2 Jun 2025
 17:22:56 +0000
Message-ID: <cc6438cc-1836-4983-8f09-c569ee2cf11d@efficios.com>
Date: Mon, 2 Jun 2025 13:22:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Function tracing not working
To: David Aldrich <david.aldrich.ntml@gmail.com>, lttng-dev@lists.lttng.org
References: <CAJK_ieigCAaowdcwmLbkdL1J3eFgHE7t1W=ZKRvoKhgABM46yw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJK_ieigCAaowdcwmLbkdL1J3eFgHE7t1W=ZKRvoKhgABM46yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0220.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::17) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c359337-778f-4bcd-15b6-08dda1fa1d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b016VVhYQmRwZFpmUlZGYVRRYXFGQllsSGVSWm1XQU9GdVd4dC9TV0pFVGRH?=
 =?utf-8?B?aEkzWkpDN3VLaFliSUFnd213Ti84V3Rrd1VieW9sekVSVDdLMllNMEc2bnVU?=
 =?utf-8?B?UDNWRTdGOFVINUpDZjNWV1J1WW9tWWNvV3BXd1NiTHhiVUVmT08wWDZnQzFQ?=
 =?utf-8?B?Rk9nSGQ3Nmk2TnNPbUtxNDlyYUN5VkJLdFBwVyt5blk5N1k2YTJyTlVsOFZk?=
 =?utf-8?B?bEJPVHlJV2dXNXdSaFl5V0p2cG9SamtDRWJYd2hCd3RjOTg4Uk1VNUNUWFlN?=
 =?utf-8?B?ZS9mMlhBcnFXb00yK3hvVGc3QUMveGZnRmVQSHFBTzZFb0NnUEROUzBxV1No?=
 =?utf-8?B?TkY0VnpGWVBaYTRPeEFWUFpFR0pSdkZNM3BvNFg4U3lncCtORnVsdFM2VnRx?=
 =?utf-8?B?SGZ1NGd4R1RTNkNhcjd4NHJ0aVN6U1dPM3dVTk9KQm80d1U1NThLZzl1Nk1x?=
 =?utf-8?B?aERjZjVMSHZ5YTBNcjZHdHBvYWtZNmV6VXpES0xyR0FJeTlwMHlPdzF4K054?=
 =?utf-8?B?OVFKem9MN3QzZ0xzQUFDR3VFZjJYRWd2UkFVemJidFhOcnNPd3BpenM1Qkdr?=
 =?utf-8?B?UTMxZUJyWWcyOGlKMmY5Vm1nQ0N5ckRwZ1ZYYnlvQ2R6QXZTb0xjQjdENlZH?=
 =?utf-8?B?aHRRdUhXZmdWckZ3eU9vWW9MS1BUUElMWTFydmphVjlBcGRUejR3UWVMZUhU?=
 =?utf-8?B?WURVZ1RwWmsxQ1l0Qm5qblhzZm5ZRVkvSmM5QVdIUkNtTEVsY0F3dERwR2tq?=
 =?utf-8?B?YmdWenZodlBxMGMvQUdBaDhUbmx2NU1Lc1ZzUXdNUzc0UnVDSEs3eENyQUZs?=
 =?utf-8?B?WjJLNXprOUdkZkFTZkZETkE1RVQ5Tm1PdndKMXJ0SFpZK05zMEpQbE5WbmFX?=
 =?utf-8?B?Zi9jbUZwUXJMQmNObER2M29GdzhDZEZNMXd1UE9JU1JNc2o3SWYyd2pLSlF0?=
 =?utf-8?B?ejNkZFZEdXBLeElhdFVWUERoNzFiUGZxbmM3UDc4cnhlUkMrU1ZyaUcwUVdK?=
 =?utf-8?B?a1ltVi9nQWZQVG8wcnliS1gxbkNvQmZBSzBISytZYkxVT1YzREZGSTFOTUNq?=
 =?utf-8?B?SnI5R1RkS29zOTFrT2V5R0FpbkdhSldPV1B2SkJZVFRwa0s1YWJ2Yzk0OGdH?=
 =?utf-8?B?TGliZENubG9IVEwzeGJLUWtYekVyanJGS1JBZW9jd0lvdEJWbTFqYVBmeGx2?=
 =?utf-8?B?Tk5HR2RVTGdBOFpla0dVSDJUWXpvWDhNMmF4anRkVTIvQUI2RWh4aXVEOTU3?=
 =?utf-8?B?Yk9WWDZDK003bkNiVExVZWZCYWQ4THA3bGVHekZvYXZaNEhDaHI5cUhGZFpG?=
 =?utf-8?B?YTlUanRqcVdBclFQcTYwclVseWl6L0FkM2pLMWQ3RWpHZWlUYTJwOWxTV2Vj?=
 =?utf-8?B?ci9QbkxGMVRGOGREK21jYjRlVFMyL1BJdnRSeTA2c1hNNW8zL2xrTUpvcmw0?=
 =?utf-8?B?N2FoSjJvK1VTdUJ2eUJJWHZPUG5XMnBIdHAwcnQ2dTJ0ZjZiTVo5U3BNV1U4?=
 =?utf-8?B?UHoyKzQyS1JaVFJSajRnS3pHYVhvQlZmUDNDZVFvUG85VHI5b0ZJWUZNWXVX?=
 =?utf-8?B?a2c2aGU4TCtBRjhCZG41dWN6RUdYdkxDd3UyeDluTzJMMWd4ZUhoYktUSjNH?=
 =?utf-8?B?MDdWd1RhdEJSdFZYNjA2Y2Rsd1VrdWgrMjhocVVBZXRpSDlkdERMbmtPY21U?=
 =?utf-8?B?ODRWYm54RGxGQVBhald6RzFnMFcvOEVXMUE1ZDhaRDlTTEJqaW5LVldYbDFP?=
 =?utf-8?B?Qkx0SlFiRDhlOUptWlpJZEpKQ1p3QVRaVzl2aDRDYjM2bHBuUGlGTDNkbUcy?=
 =?utf-8?Q?g21XZYhS9Q1fULmlxov2F72joFmIB7CBTMAZ8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am0vcjRWenNSQ3ZwSVQzVGZtOUk5d01nWnU3U2N0TXd1QXZxUWp4MC9JWEor?=
 =?utf-8?B?eGVVVGFyYWJBdVNsOEttbVJ5d0hITGp1azFlbUl6Wi9QVDAyTnRsUytSRENJ?=
 =?utf-8?B?aGg1ZHU3dmN4d1ZIVWp3dGUrWVlhUTBXL0R3TmtZd1dLNVFJTDZqTTVSRjhm?=
 =?utf-8?B?WXdGMXNhWE14bXgzelZNaVBCcll6cVp3M2JydERFZmw0ejlicGVjSU5vdE1K?=
 =?utf-8?B?a2gzRHdNeVpmZmlCczEzeXExYWs2RWNrWHUvQjJja2lzbEpaUmRmZFdXZHc4?=
 =?utf-8?B?SXNaSVNHOVgzSHl5WmFQS2JnQXRWZUoyTWF1TTd0T0t2V0ZvMldCOHNLNVY1?=
 =?utf-8?B?ODJESTdadlBud21NdzhXV3lIanNyN2poSmFCWFNDMEdjZi9sckgwMFRqNlNP?=
 =?utf-8?B?cTVSdkl5aU11YkJSRHJTZ0dhR0owWTBhYTNhNEk0c0VGN0RpY1ZBOE9mNFJt?=
 =?utf-8?B?QXl5ckxDUWVnQ1BMR3FxcDZnUDVMclVudGRHZXowY29ZRExZT1A2Vy9KYm1N?=
 =?utf-8?B?ZitEaHJTL1JUbXlheEk5dE5aRUVHZlpQWktpcC9mampZcHBZdzZ2b29ZVS90?=
 =?utf-8?B?VTZFNlVyaHlIODAxZHFZblpRUzdhckpLS2FOd2VTREl0YnVJU2ZQWmtmYzhP?=
 =?utf-8?B?TEY1UjlVaEZMUUg0c0tVZmp3UFQzYzZlR2JRbUIrOUxRdjZnTDEvZEkyOFA1?=
 =?utf-8?B?UVhDczlXTFZtUndNKzhFSEpoQ1FzZzMrMFNuS2lzN2FlRTJWQXl1dWpDSy9n?=
 =?utf-8?B?ODdteE0xUFlYeE1xdStYY3M4SFh0bmVLMTJxRmdubkxVVjBHRUp4eklkdGYw?=
 =?utf-8?B?SHRqNGdCMi9aOGNrMHRLRnZLLzJOcEpGUFRYR0xQMndmTWVnVVMvRHo0eHZQ?=
 =?utf-8?B?R05mRTBRclVCU1UvSW8rWG51N2lPc2cxdTF4T2Z3aUJ6cWk1eERob3MvSUxP?=
 =?utf-8?B?RUQvcXU1cjM0Z29FbDZ2YlV2RCtrRXo1Y2I1WVZZRFdEcDl1OHdYTkhhSEJY?=
 =?utf-8?B?TUQ0SUpyRjlmdE15T09ub2Z1UmM3NFdwRW5QbkhDMHpOelB5WjBXVlhrbFBQ?=
 =?utf-8?B?Tis2R1lYT3BDR1QreDVUQWhZVnREc0U4WnlDQ0Z6dDlRd3hkSVBaUVZiSlla?=
 =?utf-8?B?N1ZoM1ZMWnZJaGFJdXR2eXNRbEtOKzNvdVBiajAvK0NNNVl6dE90RVhlVDNs?=
 =?utf-8?B?U0c5ZHhDY25xakdTQXdIRTFYKzNkS3QycEcwc2d6aFVmZjNtbStkdGhVTnlr?=
 =?utf-8?B?dUI4TDdsbVQwLzF0UVhoZ2Z3L2w4M1BDZzFXaUprQjVUNUlwUjhqWDVLTjBz?=
 =?utf-8?B?T0hLRnlaOHZwdEZ1bnVGeUVCQy92aEFNNE8zZW5BeFJMQ1VYb1J5RG95Q25s?=
 =?utf-8?B?aXpCYmRtNDVGWVkvN1JVN210RWFReVdYSnBrY3F2TWdrSVkzbDFaSk9tN0VB?=
 =?utf-8?B?N0t0Mk5hNmo0dWhrcXl5V2lMRXkxdnhwYWE4UmFYNFlSS2JJVlZCcWswZUFU?=
 =?utf-8?B?U2dicWxIS1ZucGc0RFlnbCsvcVlYNjE5VEdVaHlUZDltT3Bwc1NMeWJ1WS9R?=
 =?utf-8?B?Q3JSVVJiVk8wZmZLQmxwcHMxeWdxMnFTbVVXZ01WZDJNSXU1NjYwWG1sS0Ru?=
 =?utf-8?B?RWRyVTJ2UHZjSHgrR3VuM2Z0OXBpMlllYUNpWEhqSlplV25ISno2MzlZQ2JS?=
 =?utf-8?B?ODIyNUZ1QjF2WHBvNGhlWHRwam56Y2RUWGhFUVQ5dUJRV1FGclYwc05rK25B?=
 =?utf-8?B?cWhURk9Dei8xa3lkWUIvRWxJdnNSMVVvUDBpWnpXbE4rV1lJL1hPVXhJdDdH?=
 =?utf-8?B?cmdNSjFFRFhsVjBHTUF2Z2xFUkFTQ1BOL0RTK2RFb2MxV0RkUUNuekVnOENq?=
 =?utf-8?B?dEpLWThSUlpudlBlVHNaMUxDczB5ZVEwVWU4anY2bVh2QzhtaGpYRVpIamdj?=
 =?utf-8?B?L3Ewd2NQOVI5S2R1OFBESURNZFY5bFhOajZiZDIzdnVKS2NBRDNUTnBLL2VN?=
 =?utf-8?B?UzNDc0UxZ0kvelB3U1JNVEEzYU1idnpPT1d6NVRtWnVJWm9pdlRicHdiYkd2?=
 =?utf-8?B?OXRTOG9jTTBheFJRODREREVzY1VjSlpEQ0ZjS0o5RENWZmdJOW1HeTBYY2Vp?=
 =?utf-8?B?QTJtUlBhb2dvMG9GZFFvL21majMzRy94L3RWQW5MRXFYWmhxWlFWcEo3TGJx?=
 =?utf-8?Q?CXEgOl+e1/DtQ7WO8HwvbQI=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c359337-778f-4bcd-15b6-08dda1fa1d31
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 17:22:56.1847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5jr68UIvUyPKd9QzEVZQKllAIjHYET9c7WxeV6oR+883eZ4lbfjDj4s2sA6B1f5pIU3AraNfmIshbWg3QKix8vPcCik7OS2lheRrR0b9nWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB6109
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2025-06-02 10:37, David Aldrich via lttng-dev wrote:
> Hi,
> 
> I am trying to use lttng-ust-cyg-profile.
> 
> Our application is large so, so far, I only compile main.cpp with
> compiler option '-finstrument-functions' (I don't specify option
> '-pg').
> 
> Our app must be run as root so I run it, and capture with lttng, like this:
> 
> lttng create app_trace
> lttng enable-event --userspace 'lttng_ust_tracef:*'
> lttng enable-channel --kernel --session app_trace kernel_channel
> lttng enable-event --kernel --all --channel kernel_channel --session app_trace
> export LD_PRELOAD=liblttng-ust-cyg-profile.so
> lttng start
> sudo -E ./myapp
> lttng stop
> 
> I notice that many events get discarded:
> 
> Warning: 198522 events were discarded, please refer to the
> documentation on channel configuration.
> 
> I then import into TraceCompass.  I see the traces in the Resources
> View, but when I expand Experiment > Views, all 3 'LTTng-UST
> CallStack' entries are striked through so I can't select them. So I
> can't visualise the function calls.
> 
> Any idea what I am doing wrong please?

AFAIK, the "LD_PRELOAD" environment variable is cleared by
sudo when running its child process for security purposes.

Thanks,

Mathieu

> 
> Best regards, David


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
