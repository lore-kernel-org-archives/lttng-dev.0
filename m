Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99CAC71136
	for <lttng-dev@archiver.kernel.org>; Tue, 17 Jun 2025 18:28:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bMFkW5QDnz24Cq
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1750184932;
	b=huguSRMgXy2tZlA7L2HjNFLO0O+R0VCMXwHIsyYKXrQMmIBYcOrtZI9N7v3I5FS+nc1j
	 rykek3iIz0yBCrtVr0UuSczuLMJ+c3WzF30PxC7vb0g6/CXwTF/d1VWrRBX2lVfj+976f
	 uz34Gr2PGbNgRcnl+o+X1RVKspfxQ6Da/AdzFpmE7DKRFl0FS8wXRIEU7q1WnbYEw8I2c
	 rk3PhNK8NGoTWyFruYG+O0VtluWJ+rQ1CeY2vDlovOSms23pII0paYQhijL28ufiGpytN
	 Z8sUIqfDPbdOwVe1FeSJ9Asbx37qlvhVP7gjT5ixXbXKT/Ewj11pP4QM8ZxuywWzkAw==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1750184932;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=atO4KOG+DSQO7gWYPXWGF9GMZW2SVePIIH3OKr2VciY=;
	b=nCNreeVaBpmFYFJkmz87u9Ty/tdPCpR/hWKmqCgohj+o4tNo9So2zu8oI2f3etWrhOLC
	 GURFg6ikxG9cFEhT8VCPheNdUzZupTzWIW1oBR34XRgdr8IyfaKbas1hL4cnx2z8yHCgQ
	 0rAAd9YFzBP2KFOt47TchprMryNme1D56XHpReW1bpzb9UygcZExINoMt/BWrMi8b2Dv1
	 dcsz2H9u9PrR+M6LourZ8NyOL6JUCpGViXUly8Fc2e9Isb3VDH/gM8Zqy2NmEzHF8DKrf
	 W9Mi1xUYGiXKzIENpZVGmqrND0pq08shztwbK3dpn1un2i20QWJ90ad3dKK/2Qk3FpQ==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bMFkW5QDnz24Cq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1750184932;
	bh=atO4KOG+DSQO7gWYPXWGF9GMZW2SVePIIH3OKr2VciY=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=QYwkNMtGeAJauRn2vuDhBNtxLJQbgxH7k3QVLWXbHA9P5IAZFVDHEf/z3CO+fRPtW
	 P3Ji9IjWvGEMumuBoV9VbHeBK+hpvahCxN23D3PtyioeJKb4Iawp63CP1kZGmimKqu
	 /k5zfw2evWD9XCcXyI7rBywoOG4WIm4z7I8bJ1myjWSGnm/0q+sYHr6n2I5jI8Pe5Y
	 GI6f44A/tV/8G/88p7uEOsP4YKMp/lSpsf3bTgGb8qpglodbPeT1M1tONXTajGfcb5
	 Cd/olQVvQ2gOgiHuhKoY7ZEuYzMQSVREr9i7FTMmtC8HXPner7ZhZDGmCycNuU8Jov
	 H2ypnwIbx1b3Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bMFkW5QDnz24Cq;
	Tue, 17 Jun 2025 14:28:51 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bMFkV3B8Bz24HN
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bMFkV3B8Bz24HN
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2072a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:241c::72a])
 by lists.lttng.org (Postfix) with ESMTPS id 4bMFkV3B8Bz24HN
 for <lttng-dev@lists.lttng.org>; Tue, 17 Jun 2025 14:28:50 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSq+58ep3tUTk+j983cPh1/SIXfYrAsX9QKmz1yQapCBd6++t7vEEK3mVofRIBFDJQDqvCQVOy2GnLHN/KvSI04RCo261bhAj6scx9GP6VhARLkbWKUAH7pMYKknedXSd48J6R/mzvzPdI7uqhXPF5kmwB0c+yulUaJNpBeY5FzgDDz5tnPjDc2PWecFo7AezYujhR65k7ogklPi7eq6JrdRt5FSnb6NpbAKQbgTGOzKPU3jQwTN63lwHEM9o516axsTrWez5L/ls3IoYGGpFxfXJRuEtlmN4oUmHS0J0w1OvhLQ8TXbtArHMADfnXlOlIXzH+mx5zvWNVce9U7qow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZEaVJhu7yHog6M8ulzaygQ8633kPHxhoehHX8mGGc8=;
 b=uZLb/tYfAqXDqhUKDIsKA8ZuuD48Ve2sLXdMcdoOOyUzvxF7k2uFdbFFj6DlguNMBa+kpqac/640iW6/tBLwrCEq478TssKZYGi7/DEzKwYO5ADOSvlojuRca0x7ly1F3VrF1SQj/2GllP44I2YDuwrDqULZTSIhqTABccolhqPY0CEQpLTEhtB7I7dCMe1PRMWiutmYG3EgBzjo9nioGiWWleEZXzGty1t+3gStuGYnUVO1zN1YwNqRsy/qph9CuSqhc2Dloc3nI55nvwgzQx1/r2bVCZjBNIV9tyksci+XL6RaraVil5/y7zriHJhTsQqiKF2BYC/AEjasL9aU7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:5d::22)
 by YT4PR01MB10360.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 18:28:47 +0000
Received: from YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b5fa:c0e6:e5b7:54a4]) by YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b5fa:c0e6:e5b7:54a4%3]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 18:28:46 +0000
Message-ID: <9ebcf017-6276-4465-9ef0-27ea005d9106@efficios.com>
Date: Tue, 17 Jun 2025 14:28:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: lttng-tools-2.14.0-rc1: Not possible to disable babeltrace2
 dependency
To: Norbert Lange <nolange79@gmail.com>
Cc: lttng-dev@lists.lttng.org
References: <CADYdroN6cD9sLE-8QMqFQiVB=RzPFav8owkuihZ-o7JxyK5uuQ@mail.gmail.com>
 <52a0f346-47d4-454a-8696-c5f0be73b43b@efficios.com>
 <CADYdroPaw5bMAinD203xd3mOO001izA==UDu+C1Jso32jFAEOQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CADYdroPaw5bMAinD203xd3mOO001izA==UDu+C1Jso32jFAEOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0083.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::19) To YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:5d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB6319:EE_|YT4PR01MB10360:EE_
X-MS-Office365-Filtering-Correlation-Id: adcb7ad9-6d07-4906-4223-08ddadcccc1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2l5SGNpWWE3V2hENkZCOTdLWXhYWkNQUCtGclc0cVZKdm9LWWtuRk9ZMXFr?=
 =?utf-8?B?WG9wMHgrRmZjMTFMb0wvancyZENTMXp6SjBvSnVHM2xaTXhsV3pWSUlnU3dx?=
 =?utf-8?B?MitvWEgrWkkxc0JPZUtzcFo0cDVlZFppL0E3SHNQZ3hDV1dGdjZRMFdkU3Rr?=
 =?utf-8?B?T1Q1QTcyS0d4SWpNbjllREl0bUdLSlRpcmxERjhEQ1h5bGVpTzBHUVZQY1BJ?=
 =?utf-8?B?ZWxiQmFuS2M5cUdzUlBpWlRYQVlTNEdZbHhrMEV3YThSeUd2QW9Wa3dKcVpY?=
 =?utf-8?B?dHhoWEt2VHoxdXV0OEZnS21zNi9HY05OMzBMOWJ3elFMNFFCV3pJalg2bm5R?=
 =?utf-8?B?clcrWTk2NVhYejU0enh2Z3g0RG5tWTlwVEgycWxvNUZZdWs0ZGFlM1ZQaWxG?=
 =?utf-8?B?VnRBZHRENFZNcjhyM1hERGx4d21xWVVHMVBqRWRnbjNtQkx1TkFqTS9xTW12?=
 =?utf-8?B?cVJ6M0ZKL1V4U05WZnhMaVFQVDVCdjh0b2dUZHcveFFxU1FPallESjgwdlcw?=
 =?utf-8?B?UFNjNlZadzNQRVd5TjZtbUNSSnQ5OThLcUJsUVlWSVQ5VGUzQ1dnN0REVCtC?=
 =?utf-8?B?VXN0Vm1hN3VrT2RWbENGQlpNTmlxSWFCalFpUm5tOXRsclE2WWZJMTgzelkw?=
 =?utf-8?B?ejk0ai9oQTdYZ1JIOXpBQ3V0WFVhSk40ZFhhelR2SXU4YytwNjA4ZS9RSWF6?=
 =?utf-8?B?d1Z5VWthV2N6YUk5bXFERWRsTEVNT3lXcXBLcWs2MXg1a3dKejc0dHhXSksy?=
 =?utf-8?B?UjRJRjV5US9KQUFPRENUWEErdEw5L1dUbXgrU0hETXpaVURUcmFWcG1nZXNL?=
 =?utf-8?B?ZEx6L3BENERVL09ENzFFVW03UVFmc2NMOFJGMWlDdC95b3Z6MWtoQkJsNC81?=
 =?utf-8?B?MVVSY0NOKzJNTmZjZ2tPaXRReEZlZVJGVS8xUVZZL2l0a0cxM0ZPUVJuRTVB?=
 =?utf-8?B?TjAxK1FyeFVFMjMvVGJFUkQ4VnJsczlPdlAwQzJmZ1pWRjVsQ1JzTjVLQTRt?=
 =?utf-8?B?YWQ2dk9FSnc4WTRJQXh3d2F1ZjA5Ty9iY2ptZWxPL3RyZ0NWcUZUNCsxOFpv?=
 =?utf-8?B?eDV2STZPY0dUdWxmSFRCaWlVbWMrcVRQR1h6RWw1TmZpYWh6ZjgzN0xsL3Vq?=
 =?utf-8?B?ZzRiaFZnaG1Mbm9MaTh2WmtKUTBzamFwS3FSOElnWGF6U0cvZ1RxN0FPR1Q4?=
 =?utf-8?B?WHRDd0ZtZThOeTZxMUxRYTgrYzBjVWlCQzcvZUxVWDBZYjVNaUIzRC8xcG5N?=
 =?utf-8?B?VW4zUS8wemRteEJOYndKajFjb1J3Mnd0ak11M0RndGx2Rzd6M0puaHJldk9O?=
 =?utf-8?B?Sk1Nb2VsQUxXNFBFMjRtZXNEVmE2NGVkaGtHWlF3ekQxVlpXRlIzZlNGT0dB?=
 =?utf-8?B?b2VtTk12cnNmQkVRWFlQcDhPUTRscXZyQm93ZjlLK0hOK0pMWkdxOHlXbXhi?=
 =?utf-8?B?WXpsRWZpaE1WYzNBUU03K2svYzRpY21TZ0RrSE9UL0pZaFE0ZXBUZGduL3ZX?=
 =?utf-8?B?L2lQMjRoWHBuK05mVTBRR1NwSEwrbzlZUUh4aktKUUZnRUpkODRQSDAzdVgw?=
 =?utf-8?B?VEFXQWluZGJLSlBPQ3VWMUlKQ1h6QWY1cmtQb0lBSW8yWWdtOEdwNXN4Y1d0?=
 =?utf-8?B?cjJ1ZjFPWDdYZFdZNW5oZktHSEgvRFJWSDBhM2hEekQvZklXUEtwUEFtRnpI?=
 =?utf-8?B?eGFJYXRRU1VxNmFReDNZQWs3eC9NQnRhUHZEcTY3K0FkckEydTMwbi9JK3M1?=
 =?utf-8?B?SU9SREFwSFY1MldvVFRBbzJUaVdDOHdONUMvci9HSithNVdMUVRJN1R4TlFB?=
 =?utf-8?Q?/m2MvK+G7fILtgP/U+GByUB1BjPlxfPtctXIw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnJTRVVDZnFFWVlrb0RiWU1RWmhUMlBYMVVBMHJPTCtCV2g5UC9wK0VrNTZi?=
 =?utf-8?B?L2srdWpMRjBTOUZjcldmendOWkwxdlZpTVlJSE5ySko0VlJNOUozODBMZFIr?=
 =?utf-8?B?cHZ1SUMxcHpoUDk0YUFvQ2NHZ0RtbG1WRktDQzZYZ2UySWNZczRjY1lXSDk3?=
 =?utf-8?B?c1YyNWFLMHZMMFNqWG1rRzBBeUhQZ3Fqak5PbERWM2NVUVUyTG1hd3BNcEJt?=
 =?utf-8?B?RjhGT1B6SFZ5THlnbHU2L0Jid0YzU0xOT3IxZmtCSXpVaXNFbE5iMW55b1dB?=
 =?utf-8?B?a0oydVNiTzFQSkN0SnI2SzcreHVuMHNpNlV0VzVIeXNHa3JmdE1RUk9SdUg5?=
 =?utf-8?B?Z21PZkt2NHdQTSsxYnhTSGpjUWJ0UlRYQUFrZUw1dUxYOSs1dkJpa01EMXYr?=
 =?utf-8?B?cFA5SGRRdVZHTEMxU01mT3lUTFB4c25lZkJGUVR6eHpIT1dGU3hCdWJOanZG?=
 =?utf-8?B?azBrRHF0S1RrYjlTRnRwc0w2S0laOGRPL2Rvb0IvVXllNW5LN2xaN3RjTlhZ?=
 =?utf-8?B?UGQzWkRPMWlmVlNUb3JFbC94WllIQS9lV1Zyc08xTUFSSHpNdkRSMjlrMnNB?=
 =?utf-8?B?RURIVmhoVkpjTE9EcFhtaWFZNHVTTXk0V3hPOE9mb0Ric214a3l0R2FlbzJ0?=
 =?utf-8?B?ekxHcStDVkNQZS9LUkdKZGFkejlkKy9ZTnkxVnd1TEJQSlhJUlFzblNxeWhj?=
 =?utf-8?B?QjNoNHM5Um1Pbndsb1dQT3hEWDdPM0YwcTFYakhRd2w0eHZOemE1eURFeCtI?=
 =?utf-8?B?ZWVMUm9WcVI2MkpCZmFHTXNYWXBmanZmMWZ0UEQwV0ZrcEwzYllqQWNIam5K?=
 =?utf-8?B?ZStJN1NrSWpXSDhRTitkRllOcUIwOHNZcVpncVZsK0ZhTE9XUEY2ZzVubm1p?=
 =?utf-8?B?cXZyZFhXU085NWJSOWszbTA3SW5LbFRyZVBQcVEwdW85K2VEcnY1Ti9Rdkwx?=
 =?utf-8?B?ZENqK1ZwNEpZM0xJVlo4L1o1S0RuWGh1YVpYS1ZOSnYyRVB0RStqbExMMUxU?=
 =?utf-8?B?cEpCeHJCK1lOKzIreUQrd3Z1Wm1WNlVXWkFWUDF2b3VlcjIxL0NhWGprcSsw?=
 =?utf-8?B?WGFueW1icU5lZm10NnNUSWNtYWkxWXpOOWZyNHJJTTRhaWJzVEFNTWhjYjQ3?=
 =?utf-8?B?QmNaRUVJa0Vmd1hMcXc5SVpWcWNVbEVSMW4wUkY4NWFoQTQ0NHByU1NVUnJU?=
 =?utf-8?B?YUlvakg0aWlMSHVNRWVrb0UxQnhMOVRkaHdrL21LaElOa3BEVUpGTnhBcVJ0?=
 =?utf-8?B?ZkVRYnNadHJMM3V3NWQ2bjlZbE9xTFRJdjlNSmhkUXh5NjNaSFc0Q2ZRcm1N?=
 =?utf-8?B?RHhmcTQxTk44bHI4LzVSb3NrUm5xYVJoRS9CUFEvOWRlbXBiMlYyZ3dmTW52?=
 =?utf-8?B?ZVoxOThvNWFJRlp4dmYrampLMHpXd29tekFoV25GUnFhWWJ6dlNrak9Eb0Qv?=
 =?utf-8?B?Umo1c0xFWGNWT0VkcjhpTnh3eXdBRm5NMDBYc2ordjFOOXhORXQzQUZOWnYr?=
 =?utf-8?B?U0s0QXk3aXVkczMvZTA5Kythc0MyNUIyNGRGb1BDVzNXNWlpN1BxYlhsRlJ5?=
 =?utf-8?B?dkUraS91ZTVuTG1Ta3p3TXVLRElWcGU1YzhER2s5VXQzNTcxRkhUZWFFdXJM?=
 =?utf-8?B?Rm1YME1uRjBjelNhRS93V3ZuMWFGcWNsRkdzVno3c0ZucHFieDNXTGJ1di95?=
 =?utf-8?B?ekRUcHBPVGxJb2E3dVhBa0NNUklSY2tDSVUrSExGTGNTNG5SUjRWdkVzMEhu?=
 =?utf-8?B?dEZONW9kUHVqdjZUNkVIeFk5eGZMbmo2MGZPUlZ6M09RekRLbFZqSkpvdVF5?=
 =?utf-8?B?bHZPb05oMU90QU94KzlXZ3VtSU9OY214bUhsMFY5NlJyMTBqd0J2SjRHOEZw?=
 =?utf-8?B?dWI0bXc0ZDgxTmRwdDVSakcwZlBYMFd6cDFpRVBEMlpoaEdsYlFOZTVjbmFm?=
 =?utf-8?B?TjFhbUNERW5TOEZOUXNlU2poUFhXVDgzYk5ZZis1b1I1dFozYTlrdTRsbDVi?=
 =?utf-8?B?U09wWGdTOW9uRFJqWjJxWXY0Yk9qaktpYnppY2VrckdSZ29VWmFwYitzVEl2?=
 =?utf-8?B?VlZWZUJyTDQ4Mkc3Tkk0Vi92aGo1eDNXZlR2TTAycHZhMVMvbW9QN0hETW9S?=
 =?utf-8?Q?UcsZ53z+4q8KTxBTctFX7ZHKD?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adcb7ad9-6d07-4906-4223-08ddadcccc1e
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 18:28:46.7611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQJmizIwPC8MofPvhvLgTsOZz0PtlMZcnsK/LZ1R9Xbx10q4ledAimf9/zeb/fVKJfpUFp0oa76kKYy2nQKO+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB10360
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
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Norbert,

thanks for the reporting this issue! I've proposed a patch[1] to handle 
the case you've described.

thanks,
kienan

[1]: https://review.lttng.org/c/lttng-tools/+/14829

On 6/17/25 10:18 AM, Norbert Lange wrote:
> Am Di., 17. Juni 2025 um 16:13 Uhr schrieb Kienan Stewart via
> lttng-dev <lttng-dev@lists.lttng.org>:
>>
>> Hi Norbert,
>>
>> could you describe more about the context of the system you were
>> building on, and which version of babeltrace you had installed?
>>
>> thanks,
>> kienan
>>
>> On 6/17/25 6:54 AM, Norbert Lange via lttng-dev wrote:
>>> Hello,
>>>
>>> I had to add babeltrace2_CFLAGS="-DA" babeltrace2_LIBS="-lm" to the
>>> configure line
>>> to be able to build.
>>>
>>> There should be a --without-babeltrace2 switch and possible automatic detection.
>>>
>>> Regards, Norbert
> 
> Its a crosstool-ng toolchain based on gcc 10.5.
> There is NO babeltrace2 available, and that is what is not handled, I
> have to define babeltrace2_CFLAGS and babeltrace2_LIBS to make it
> through the checks.
> 
> Regards, Norbert

