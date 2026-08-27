Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CFFC61DC4
	for <lttng-dev@archiver.kernel.org>; Thu, 27 Aug 2026 20:29:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4hWCm000Fnz2PFn
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1787862546;
	b=RE3Tzt5WSypcKjEs5UGCpIqmbq7lRm0Z+xPGW2jlrTiZjrRTi/yv9M6IO9bNrTJYqogB
	 5CfX6dozWtN6DEM+iezGUMQcACSNhRXAiFFaDrGv8YgTINwUmj5pirCPmMzN/ynz4zjPd
	 pO62ru/U5v74iSaqyY/8qcgMBBmxrz+k1tDbaxXuG2KElIS6s48/9CuKMHmcGj4gLXpQR
	 prHw8KmBwWFPjLwJEbDrBrNCem1axj54WcO8EQwYKDbz1LJuoLemU1UR50+WJb5B6W8us
	 PZznCZILhY7VA1bGEsI/pockDCn7+SKd8IhSWHlbR4IGw66Ovx2t0HRQWv8SeYDSNrQ==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1787862546;
	h=DKIM-Signature:Message-ID:Date:To:Subject:MIME-Version:From:From;
	bh=JljJv9QVeq5dn3WOtd3e8dHPTL/HKIc0KuCv15ea/Q0=;
	b=L0RMeJA3tJPN38Vgol8SHe/pxgGIsBOnnGixtuBblGPHqifHBflH9JRs80hJlQIkb7Ms
	 dfSmWKltl1entwzdZ3VIF+6qRQMKIFg+OOV9D8v3U2wmmvE9x9egszN4ejHDmRupQ3EVO
	 2ZBU3sM+UH6M3EeX6ksCaDwkH0FMpz5mvotPre+LmYThX1X9X9rFPmwjNzvTCqa7RVkUm
	 dnr4JvycqyoobUO+mGfMPtbMhPgakX56YV8/TCRWeZGPg4Fma/c79q7IsL1J+XBAA362+
	 3bIHXmiLo5sy2jF9z6wCrN8FnCOYACOMghlifa0dRFlAHhIMtu++1Am2VCro+VoJvzw==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4hWCm000Fnz2PFn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1787862546;
	bh=wLfa9Q+k1/xuvgDxwivM43K5IlFKFxZgaOnHA5m8Gxw=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=CXW6QEUlnr/96OLg68+36DMR1mkaSZ9Z37gOHtX4Zbs7ZNHjTRIcUUuftCHw0bWHD
	 NWyoY/Jrc8yXH4zf9goEL6HDDB7ywaxv542jrezIdNpdTB9gPdODDSlGvHL7sCtFeb
	 3ElkWVEixlehMmf/XoPkmzjGPxmr6jlHeT/qRTKkL6wwdk84XBb6CINWKDYqn1w9ho
	 XOqW2TeHfwinEFYdRrZIoRstccUUDZQwU90tBhqaNEfh47QgUa2I7Kok4B8Ipp2Ewe
	 q9xdvgFNvUVQEI9GKUq+cWdYsegoCRZgcs9rVgEqWo0AA/OKL+9TuIEN7IKkBl5Ock
	 KkyT79jWec5Fg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4hWCm000Fnz2PFn;
	Thu, 27 Aug 2026 16:29:03 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4hWClx12KPz2PFl
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4hWClx12KPz2PFl
Received: from YT6PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::3])
 by lists.lttng.org (Postfix) with ESMTPS id 4hWClx12KPz2PFl
 for <lttng-dev@lists.lttng.org>; Thu, 27 Aug 2026 16:29:00 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXCaE1RgdsRiRRo6ijwEMAR+80mhhCzlh+tDnlILzaG7D8C/mHhCssuejMlsmzO6fyBUJzlBjX9FNuoOnN3FG5EchzYYj0m5Wq/+6RdTgCr7kuP2hZYyNvf7fAWzjLdEjFmYNZlA4ce2+wZefniv4demDcu/fr6BlQHnTdWeV9Rf36eyY06aTBhbh13bv1T8dRW0M4pC4xp076Hiwd2bMqZCING7RygnnBdFt7MSGoVNlDOcU70TSJbThW/XgCyrw3ez82Ow7Mfr2Tk7RlH/z1FccV61abXXM/VrkqvrUUv3yZ0HYrB/9qgpwblquJLt8m0EXGttZz9LBO8BxHN+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLfa9Q+k1/xuvgDxwivM43K5IlFKFxZgaOnHA5m8Gxw=;
 b=pkjPHU7W4xD98d1S2O3cVoPnlrX0m01G4RitaNWUAx9TsVOzIV7B0LAAFwBUDATWaQFty8Up2pVGfNrmjBEXcRvxNvk9dn4vVgAGZKD38zNJJNfqxTevEulUftyLXXkwSRJB6UwkUDxQyiYXIfn5Pi1j05S8sJOsE/eNnle0q/RbrRpA1AIaCAaDk7xj9S/eaACqU63WRcMfOB9B0XJWUeNOjwM5016kd9zFxkI2vpEOA+/u1/qXKzyaiJJGASewyHpudiJd+zeDD0/ky4YeQBjOoD4OkLPIoWB/X7XzcjaLj2cblM1SRR1wNrXSOBu2UrxMVagv+Y1di52euyhnlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB6619.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 20:28:54 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 20:28:53 +0000
Message-ID: <f00f9f5f-813f-476b-a2a5-d7be4e9c0f7f@efficios.com>
Date: Thu, 27 Aug 2026 16:28:52 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev <lttng-dev@lists.lttng.org>
Cc: Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>
Subject: [RELEASE] LTTng 2.16.0 - Question de Perspective - Linux kernel and
 userspace tracer
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::9) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: ffc73019-392f-4216-87f7-08df0479cff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|6133799003|3023799007|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: mbuNzjCG2Lc5NKAyxHSozhDaJ0ol2Vc/1TQDEoR9gAbju3mg+ntEdZSAtSDuGQiEHGWJ2RcTg58dDZePduiMYvCDZGwtoHGujWh45CeVDRMgvpFUHduNlZaZJU3SyeZUHIYS/U2cEg+O2RJOsDQ91oJ+1Npia4lmzxp16o791u8j+voxMfddXdg4808xausrR8SM8mbphtn3QAqxDlwOgiem5rbhf3p3a4Yz6eg/o6LwWI2CZyhq0dA1GwEtin07lenLKf12oUHSew1aH76gwpuD+V7/LDGDJx9gMSzGPiHjA4yAt4+mrg2kpud6oW0X6r0l57DTo/C/AE8AULkeaK2RiazokIt9/DKXoHgyWe05E89HcHz62RywN0A5LpXH9LKCtXRUHavgvDpABw0wFhZDYs4nXRPeIIzUoYqf12SDaWe0jzRgNbl/0YlmvuEzEDkOY7pLaiCFZq5gsGB6YF+BYuLLbPt3DenV/brQprqZlG0wCS3jPkfIUhI+zTVlNSH8Zmdly5hvMVY17zXAR5bye73MYRHasYGZpRgpPS2kIeDQ/0quV4hjcqV9CS//f0gbo41ZTlMeCar3PxWjj7cPlV8AhKCRoBMzhzs2rSE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(6133799003)(3023799007)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3dHbzV6NmJDbThXbmhRems3ejFtVkRYTy9POHcvVVRsamxGb28vZ28vV2xy?=
 =?utf-8?B?QXZIaXZQTWo4QnN1c3hNZlpORy9KMDFrMTRva3RnSVlpSVJiZTVXVlpZSDlI?=
 =?utf-8?B?Z0pZb3ZPMC8rdVhId2k3Y3RjckN3WW9vRWZuZ3VVQlIrbDZaV05mY2tzYWF4?=
 =?utf-8?B?U21wcTZwd0JiWmMzVGxWa2doM2NxVjlGdDZib3hQWk01ZDNBRit6dmtLN1U4?=
 =?utf-8?B?ZkF4bHlBS0xHYVZUa2p2bHZSUlhwN2pxUkZvaGJiNU1xWWJYTVZQWnFNOG1T?=
 =?utf-8?B?cjlZMmlyRHRpK0tib1RoUFZqT2NMUklaMC93NDM1cVJCakdFVVF5T3NSL0ZJ?=
 =?utf-8?B?anQyUjNaWDQwR2IrSUZIQlljRFRmckd5Sld0L0xTMkJYeDdWZnFwMStxS1FF?=
 =?utf-8?B?YUpxQjYvbVZvelNOS2tod1pxOTc5Q3padHNRMjVPaWkwdzlHQlRvdFNUVm1p?=
 =?utf-8?B?QXN4RVAvL2dxSlNqZ0Q0aVdHYTNmOFR3Njh4NEY1YkhVUXBaMlNWQTZ2bXlI?=
 =?utf-8?B?UzB6M3pKMmxnRXVQT2FqNWN3N0QxN1ZKdHBsL0taSU1mWU5ya0lQeWZad1B4?=
 =?utf-8?B?bmtqejRBOUYrUnl4eXNpcDFsTUUxcG1EM2ZuNWhQQllZUW1rQW9YaytTcUth?=
 =?utf-8?B?OWprRFFlSlRZdnVXVnRDUEM5NVcwcFJ4elhGdGxNOEswRVlIZnEzVWZFdGgz?=
 =?utf-8?B?citObWxTVU03KzNGTjVjYnBZVDJUMXJ6Uy9kNkp2U3FyVmNhdll6SGVwSjh2?=
 =?utf-8?B?ZXkvTDJWU2g3d2ZDbjRPT0lHVE5oSnpiUzBUbGxtdERFVzVlT2dZQnRWMDU4?=
 =?utf-8?B?eW5xSUc4aDZEQUU4VVcraGhCZGRmeDR6NG1mZGdWOHlEK08wdEY1N3NoS25T?=
 =?utf-8?B?MUo3MCt0TlBIQ3YrdWlxM3dOL1ZBQSsvMUlrcWxpUVJYZHlaOUNTazJhb2hJ?=
 =?utf-8?B?aWxEQkdMVFcrMzRtWXl0bXdnZktGOExIVytEa0JiM2ZidFVpN2xDSnB6Nk5I?=
 =?utf-8?B?MG9QNmtpM2FuSHUvQXNmYTk5UjhkWjUvVDY5bkFRT3hnNU5ldEQ2NW5SaG1K?=
 =?utf-8?B?ZU9iaTliN0J0aHo2NUppOTAvZGgzNDlpTjJzcjFKU1g1Y3dEZFZycWNvTVVK?=
 =?utf-8?B?dW5CenhCZ1pTcHZmQVUwKzF1NlNtZVB5WG01cDRZVVBjVFJLUnVJZVlYLzZB?=
 =?utf-8?B?aGxWMUl3V2tSb3B2UVZFMlFjeHNBalorMzBjTjdsNkxWbG5FdThOTjlyUUpJ?=
 =?utf-8?B?MmhjMW5uRnUvM0lPZXpSVVNTM010K1VybTYrSHpTUE5TOXdQQjJET2V3Lyty?=
 =?utf-8?B?UGVrRHFJOGNVbDdmc0psNkN2dWFlL2xEVGU3aTJkYTlLWlorSFJRUjJoZm13?=
 =?utf-8?B?UUJycS9EVWhINWwvK2JnbkFjdnp0cUlaZnFoWVVlMEFCa0hpOXlTWk41Z3FQ?=
 =?utf-8?B?N1V0VVg2REY5ZjlpNzAxU3hMQytYOTgxejJpV1I1VllLZXBXUmNPQkxFOWQr?=
 =?utf-8?B?OU5Lc2V3Qk45TTFvejJWR1E2bHROblRpMitoWVNBWHA1QmZNT0JWb25weXI3?=
 =?utf-8?B?L3dkM0ZkSDBzbFNSK0JaWjFFNkVUZ1NQalZvTE9Id0E2aHNkL0FaS2wyck5s?=
 =?utf-8?B?bG5BVGN4QWNsbjhFYnBtdVpjeWlSVWFuNTlJWjBaYW5iVFhBWS9rMFFjMUZZ?=
 =?utf-8?B?M2ZNQ2ZYN3Y0Q2QzSlB0MHJ4bU1GTGgrT3NUcnB5eGpsZVVROG1WaVkyUnFH?=
 =?utf-8?B?Z3ZHdFIrRDRwSXEyeXUzd0YvdHhjaGMxajJUak5PZURZOWhtbkxZdFFkQnNR?=
 =?utf-8?B?c2l2MTFhVkRyMlhyR3JseHVvNXMyWThOVFNVSU04dDU2S25TdkV2WHVpeS9v?=
 =?utf-8?B?T0l6eUl2eDJ2QzN4NlRsNEYrVXE5ZkwvSFg4SDhQdFdnd2cxWS92R1dVRHZu?=
 =?utf-8?B?dUk2RUFzK29lZUkrN0p0T0U4NS9pSEVQQTdWeEV1NEdSQUUyTkhHSTlVbFEr?=
 =?utf-8?B?SDN5S093RmZ3Q3V2MG9BNldVU25BY1Q1K1RRZURJU3BGL0lYem50NVVKTXYx?=
 =?utf-8?B?QXZhWjhLT2VrWElENXdPeVR0UUlSSmFIRUFQSE42SE1sQjJaUDR1Nm4vejlV?=
 =?utf-8?B?blRFUnYvM29lcWNNU1RIK2dvenhRWTU1YUlKSHFtTUY1c0FIcWdMU1FmbUxK?=
 =?utf-8?B?V3FhWHhUVkRYdER0TlVtQjVzaWt5QlVNVk82ZnFQSXFTSGxYL1ZCL1BGSi9o?=
 =?utf-8?B?OS9yWXVOcjdmTnpiL3Fia01qZHdjOUJtSXpFZVdzSEtOUkdFUERqSm1yT1o0?=
 =?utf-8?B?MjZQbklvdVNLekxJQ25rVlpRL1BCRW1ucVl5RDlTWitmWkthVFVTUDdWakcx?=
 =?utf-8?Q?rTW7PxftxBQesk/k=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc73019-392f-4216-87f7-08df0479cff1
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:28:53.7895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNjBUBId3L1uKxWwKCVuKmGJv3YqkbrUe7rpgbPVvzF4MnQq2K2CewGxyrTx56b/1r232ye67zRLT8Cr2CyT9f6eA/QE3Yhdhxcjl7dBr08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6619
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

Hello, fellow tracers.

The LTTng team is proud to officially unveil LTTng 2.16, codenamed
“Question de Perspective”!

Please refer to https://github.com/lttng/lttng-tools/releases/tag/v2.16.0
for the web version of this release announcement.

Highlight
───────────────────────────────────────────────────────
This release introduces _maps_, a brand new way to aggregate live event
counters directly within a recording session, along with BLOB fields,
trigger persistence across session save/load, and other
thrilling refinements.

Aggregate live event counters with the new maps feature
───────────────────────────────────────────────────────
Maps are the main feature of LTTng 2.16: they add a new live aggregation
path alongside event recording.

Maps let you count event activity live, such as how often each system
call fires or which events your application emits the most, without
recording a single event record. You get a high-level view of the
observed system at a fraction of the resource use of recording
every event:

     ┏━━━━━━━━┯━━━━━━━━┓
     ┃  Key   │ Value  ┃
     ┣━━━━━━━━┿━━━━━━━━┫
     ┃ read   │ 48,201 ┃
     ┃ write  │ 31,944 ┃
     ┃ openat │  8,127 ┃
     ┃ close  │  7,930 ┃
     ┃ mmap   │  2,615 ┃
     ┗━━━━━━━━┷━━━━━━━━┛

A _map channel_ configures a set of per-CPU _counters_: named integer
values, keyed by strings, which accumulate over time.

Unlike an event record channel (new terminology for what used to be
simply called a “channel”), a map channel doesn't record individual
events to ring buffers; instead, it maintains running totals that you
can read at any moment.

Map channels and event record channels are independent and may coexist
within the same recording session: you don't need a dedicated recording
session to start counting events.

A live tally like this is a great way to guide your event recording
setup: once you know the busiest events, you can pick which ones to
actually record, size the buffers of your event record channels
accordingly, and pinpoint the real sources of tracing overhead instead
of recording blindly and sorting it out later.

Add a map channel to a recording session with the new
lttng-add-map-channel(1) command:

     $ lttng add-map-channel --type=user my-counters

Then, populate its counters with the new `incr-map-value` action of the
lttng-add-trigger(1) command.

The example below increments a separate counter for every user space
tracepoint event, using the event name as the key:

     $ lttng add-trigger --condition=event-rule-matches \
                         --type=user --name='*' \
                         --action=incr-map-value \
                         --session=my-session \
                         --channel=my-counters --type=user \
                         --key='{event_name}:count'

The `--key` option is actually a _template_ above: LTTng substitutes the
`{event_name}` and `{provider_name}` placeholders for each matching
event, so that a single trigger can feed many counters.

Read the current counter values with the new lttng-show-maps(1) command:

     $ lttng show-maps

     Recording session `my-session`:
     User space map channel `my-counters`:
     ┏━━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━━━┯━━━━━━━━━━━┓
     ┃         Key         │   Value   │ Overflow? ┃
     ┣━━━━━━━━━━━━━━━━━━━━━┿━━━━━━━━━━━┿━━━━━━━━━━━┫
     ┃ myapp:request:count │    12,043 │           ┃
     ┃ myapp:error:count   │        87 │           ┃
     ┃ mydb:query:count    │ 5,920,377 │           ┃
     ┗━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━━┷━━━━━━━━━━━┛

Sort, filter, and slice the output in many ways, for example to show the
five highest-valued counters of some process:

     $ lttng show-maps --channel=counters --per=owner --pid=2860 \
                       --sort-by=value --sort-order=desc --limit=5

     Recording session `my-session`:
     User space map channel `counters`, process ID 2860 (`myapp`)
     (64-bit int. values):
     ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━━━┯━━━━━━━━━━━┓
     ┃            Key            │   Value   │ Overflow? ┃
     ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━┿━━━━━━━━━━━┿━━━━━━━━━━━┫
     ┃ myapp:request:count       │ 2,481,005 │           ┃
     ┃ myapp:cache_hit:count     │ 1,938,712 │           ┃
     ┃ myapp:db_query:count      │   842,330 │           ┃
     ┃ myapp:cache_miss:count    │   220,118 │           ┃
     ┃ myapp:error:count         │     1,204 │           ┃
     ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━━┷━━━━━━━━━━━┛

Or to break a single counter down for CPUs 3 and 9 of Unix user `paul`:

     $ lttng show-maps --channel=count --per=cpu \
                       --uid=paul --cpu-id=3 --cpu-id=9 \
                       --key=myapp:db_query:count

     Recording session `my-session`:
     User space map channel `count`, user ID 1002 (`paul`)
     (64-bit int. values), CPU 3:
     ┏━━━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━┯━━━━━━━━━━━┓
     ┃          Key         │  Value  │ Overflow? ┃
     ┣━━━━━━━━━━━━━━━━━━━━━━┿━━━━━━━━━┿━━━━━━━━━━━┫
     ┃ myapp:db_query:count │ 612,489 │           ┃
     ┗━━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━┷━━━━━━━━━━━┛

     Recording session `my-session`:
     User space map channel `count`, user ID 1002 (`paul`)
     (64-bit int. values), CPU 9:
     ┏━━━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━┯━━━━━━━━━━━┓
     ┃          Key         │  Value  │ Overflow? ┃
     ┣━━━━━━━━━━━━━━━━━━━━━━┿━━━━━━━━━┿━━━━━━━━━━━┫
     ┃ myapp:db_query:count │ 229,581 │           ┃
     ┗━━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━┷━━━━━━━━━━━┛

Power users can go further. When you'd rather query the counters
yourself instead of relying on the fixed, human-readable presentation of
lttng-show-maps(1), export every counter of every map channel as a
self-contained SQLite script with the new lttng-export-maps(1) command.
Where `show-maps` filters and aggregates for you, `export-maps` does
neither: it hands you the raw data so that you can slice, filter, and
aggregate it afterwards with the full power of SQL.

Pipe the script into `sqlite3` and query the convenient `vmap` view. For
example, with a shared resolver library feeding `resolver:cache_*`
counters across every process which resolves names, rank the processes
by their DNS cache hit rate, combining two different counters into a
ratio that `show-maps` can't express:

     $ { lttng export-maps; cat << EOF
         SELECT owner_name AS command,
                ROUND(100.0 *
                      SUM(CASE WHEN key = 'resolver:cache_hit'
                               THEN value
                          END) /
                      SUM(value), 1) AS hit_rate_pct
         FROM vmap
         WHERE channel_name = 'my-counters'
           AND group_type = 'user-per-process'
           AND key LIKE 'resolver:cache_%'
         GROUP BY owner_id
         ORDER BY hit_rate_pct;
       EOF
       } | sqlite3 -box :memory:

     ╭──────────────┬──────────────╮
     │   command    │ hit_rate_pct │
     ╞══════════════╪══════════════╡
     │ nginx        │         54.8 │
     │ chromium     │         71.2 │
     │ postfix      │         83.0 │
     │ redis-server │         94.6 │
     │ sshd         │         99.1 │
     ╰──────────────┴──────────────╯

See the lttng-export-maps(1) manual page to discover the full
SQL schema.

Other map highlights:

• A map channel may hold 32-bit or 64-bit signed integer counters, cap
   its number of keys, and follow a per-user or per-process buffer
   ownership model for user space tracing thanks to the `--value-type`,
   `--max-key-count`, and `--buffer-ownership` options
   of lttng-add-map-channel(1).

• With a per-process buffer ownership model, choose what happens to the
   counters of an instrumented process when it terminates while the map
   channel still exists with the `--dead-process-policy` option of
   lttng-add-map-channel(1): either discard them or, by default, fold
   them into the _shared counters_ of the map channel so that you don't
   lose any contributions.

• The lttng-list(1) and lttng-status(1) commands now list map channels
   and their configuration; filter them with the new `--map-channel`
   option if needed.

• The lttng-clear(1) command resets all the counters of a recording
   session to 0, without removing any allocated keys.

📖 To learn more, read:

    • The new “MAP CHANNEL AND COUNTERS” section of lttng-concepts(7).

    • The new “Map channel and counter” concept section of the
      online documentation [1].

    • The new “Count events with a map channel” online tutorial [2].

Save and load your triggers
───────────────────────────
The lttng-save(1) and lttng-load(1) commands now serialize and
restore _triggers_.

Saving a recording session configuration also writes every trigger which
exists at saving time, and loading it recreates those triggers.

This matters for maps: because the new `incr-map-value` action targets a
map channel, saving and loading triggers is the only way to preserve the
configuration which populates the counters of a recording session.
Without it, the saved configuration would have no record of which
triggers feed which map channels.

Skip this behaviour with the new `--no-triggers` option of
both commands:

     $ lttng save my-session
     $ lttng load my-session --no-triggers

lttng-load(1) doesn't restore the original owner of a loaded trigger:
the Unix user running the command becomes the owner of every loaded
trigger, regardless of which Unix user owned it at saving time.

📖 To learn more, read:

    • The lttng-save(1) and lttng-load(1) manual pages.

    • The “Save and load recording session configurations” section of the
      online documentation [3].

Record raw binary data with BLOB fields
───────────────────────────────────────
The new BLOB field instrumentation support of LTTng-UST records an
arbitrary sequence of bytes tagged with an IANA media type [4], for
example `image/jpeg`. Previously, LTTng-UST could only capture binary
data as an array of integers, with no way to tag its type.

The new lttng_ust_field_fixed_length_blob() and
lttng_ust_field_variable_length_blob() field macros do this:

     lttng_ust_field_variable_length_blob(payload, buf, size_t, len,
                                          "image/jpeg")

LTTng records the bytes as is, without interpreting them: think raw
network data, memory regions, binary protocol data, or whole files.

CTF 2 [5] supports the BLOB field class as is, including the IANA media
type. For CTF 1.8 [6], which has no equivalent field class, LTTng
records the bytes as a best-effort array field of 8-bit unsigned
integers; this loses the media type as CTF 1.8 has no way to encode it.

📖 To learn more, read the lttng-ust(3) manual page.

Start the consumer daemons up front
───────────────────────────────────
Pass the new `--spawn-consumers` option to the lttng-sessiond(8) command
to start the consumer daemons immediately instead of having the session
daemon spawn them on first need.

This removes the one-time delay of spawning them on first need from your
first recording session, which is handy when the earliest events matter
or when you're measuring startup latency.

Control the new features from the liblttng-ctl C API
────────────────────────────────────────────────────
The liblttng-ctl C API gains functions for all of the above:

• Add and enumerate map channels with lttng_session_add_map_channel()
   and lttng_session_list_map_channels().

• Configure and inspect map channels and their keys with the
   lttng_map_channel_*(), lttng_map_group_*(), and lttng_map_key_*()
   function families.

• Build the new “increment map value” trigger action with the
   lttng_action_increment_map_value_*() function family, along with
   string key template utilities.

• Capture and filter on BLOB event fields from triggers with the new
   `LTTNG_EVENT_FIELD_VALUE_TYPE_BLOB` event field value type.

   Get the IANA media type, length, and data of a captured BLOB field
   with lttng_event_field_value_blob_get_media_type(),
   lttng_event_field_value_blob_get_length(),
   and lttng_event_field_value_blob_get_data().

• lttng_register_consumer() is deprecated and now
   returns `LTTNG_ERR_NOT_SUPPORTED`.

📖 To learn more, read the liblttng-ctl C API documentation [7].

VERSION NAME
━━━━━━━━━━━━
This release is named after “Question de Perspective”, a stout brewed by
Ayawan in Val-Morin that the team adopted for its name. It is a
thoroughly standard stout: dark and roasty, faithful to the expectations
of the style, and remarkable mostly for how unremarkably it conforms to
them. An `std::stout`, if you will. Whether that counts for or against
it is, fittingly, a question of perspective.

IMPORTANT LINKS
━━━━━━━━━━━━━━━
LTTng tarball:
     • <https://lttng.org/files/lttng-tools/lttng-tools-2.16.0.tar.bz2>
     • <https://lttng.org/files/lttng-ust/lttng-ust-2.16.0.tar.bz2>
     • <https://lttng.org/files/lttng-modules/lttng-modules-2.16.0.tar.bz2>

LTTng website:
     <https://lttng.org/>

Mailing list for support and development:
     <https://lists.lttng.org/>

IRC channel:
     `#lttng` on `irc.oftc.net`

Bug tracker:
     <https://bugs.lttng.org/projects/lttng/>

GitHub organization:
     <https://github.com/lttng>

Continuous integration:
     • <https://ci.lttng.org/view/LTTng-tools/>
     • <https://ci.lttng.org/view/LTTng-ust/>
     • <https://ci.lttng.org/view/LTTng-modules/>

Code review:
     • <https://review.lttng.org/q/project:lttng-tools>
     • <https://review.lttng.org/q/project:lttng-ust>
     • <https://review.lttng.org/q/project:lttng-modules>

REFERENCES
━━━━━━━━━━
[1]: https://lttng.org/docs/v2.16/#doc-map-channel
[2]: https://lttng.org/docs/v2.16/#doc-count-events-map-channel
[3]: https://lttng.org/docs/v2.16/#doc-saving-loading-tracing-session
[4]: https://www.iana.org/assignments/media-types/
[5]: https://diamon.org/ctf/
[6]: https://diamon.org/ctf/v1.8.3/
[7]: https://lttng.org/docs/v2.16/liblttng-ctl/

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

