Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D5AC36000
	for <lttng-dev@archiver.kernel.org>; Fri, 21 Mar 2025 13:14:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZK2wH4L99z14Yq
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1742562863;
	b=RyxQhEiB8hfggdGyxR6aUH5JM/LNMWPlEOoMeV1LCB8czqyQ4SX8kQ3PXez//nsqcXlu
	 NSfiLwhTiGdZOXSaRPOb+tv61i1UFtwWvrrburaahs4S/BVLxq28dkDT3ypgAIFWK/qWp
	 pW9tJtFT1OodKYjjn6+4w+RCBL9it8+Ej5/PrFE8ENGPTUzZyA6V2+hox+rS6Ce8ItS7J
	 JtGxuBA3nNjerN+M+12t8OywAJP2JDckFdU86rO7swlaYsYGiGxZsLsqYqcRrOIi0Z1bd
	 m65hqNz60VtOmXQGL8dtIS6V7acc2WVvuw4YF1lSoARvW5VAabACRxhYyku3gLLQQZw==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1742562863;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=sJqzQbXUsHKqGde2fv/ThCAExdbhpM4BufIQfU+ZGRQ=;
	b=a2hYVme3J/Ive/yl4Awuu5+aXSrHNLeYJDaZ2vLhEeJ8OKdm6az4FPcDhrA92t8LFRJU
	 1IBdnyIaExpZJd1oCmWrdqwrRCWW6Dy+JXs67Ir/RlrvQcx4n5essJGmPQrlEJET7HUaB
	 vH+MtKujnkByc6LkUC0syEKEIhje1EsEsFSXXd5pYW/IOAN3jBnMUB9xZPZGYm1E8relo
	 dI5mKrH0Hpj2csrqj8cE728WKC3NtM839DZ5LTdnHPk1fZ36SSw9Xw8iXh5OBTKtE67ll
	 u4ZHEnQo9xALLPu+dfqtcYPPgftrbiiDfCSTW/tUWKzU41d/Fplhwp2svOr87PQVnNg==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZK2wH4L99z14Yq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1742562863;
	bh=sJqzQbXUsHKqGde2fv/ThCAExdbhpM4BufIQfU+ZGRQ=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=fWmWwd2KVxjBAYmf/XlVMifs5Fn7R91+e11weGCC0tBnsIYJJk+mOo4TouiiJOZ4K
	 uks69wwDNbKFViYsf3LrA4Od19Gr/Kq82wvsWayZM/zMIJLn8M5uvwvGrSayiFkVs4
	 MEOn+byo0HFazaYsqMtf+DW++J6mVKDl0Or4HonXeEtbUGGG51xMFOSc+MqmvKRLIp
	 PPlnn43eevr1nz/Wp2Bs3NiT8U1bZdd8dG3Zf7iLgG8VeNZAzbwysZ3qwOpBFe8/F/
	 0lpCI+kx0f0qKQy1+fyc8JrQ+XqGZrrOaRBEAVoQJXDzP9pGtCWyOSXJ0AcKsSOvdU
	 BusWGa/f6DRtg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ZK2wH4L99z14Yq;
	Fri, 21 Mar 2025 09:14:23 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZK2wG4fM2z14Vr
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZK2wG4fM2z14Vr
Received: from YT5PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazon11021072.outbound.protection.outlook.com
 [40.107.192.72])
 by lists.lttng.org (Postfix) with ESMTPS id 4ZK2wG4fM2z14Vr
 for <lttng-dev@lists.lttng.org>; Fri, 21 Mar 2025 09:14:22 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Inya7nu0RRiyxu81dkD8SWWewLYvtaEegcpYxx6/nycLYalawK0WMYHPvpJgUkRtrWqhMTOkawppQWc9XCje1wp2p99+PLnyQRsB2+DBfjn6ON52NO0KZW7RCvlFQHx7FUvDAMcllruz3LcS9qRa8sr4GMSs5lZHsQlugrAlupy/pCeD4anE6ma/ig1x7Uspd2izNNPs4HXI54YgQbMSpNZCdEakprZueX7XH67EsTFvbwTnQcZHuEqAj2SrJCDI49vRltGLSe5HV05ctErvsM8bvUERl+HXUyyAgFnWPiFg791J70+PFRdXxDTqCFr/MPANRV5zSIzvAu8RnIiSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ilutcaBfTX419TUv8W2GeP//cK4W+APFjJL2WY7F1k=;
 b=qTUFk47QsPGcq0aMPWmeMVwpxnw8JZyXCqL13/qI1OFZgFe+nSWXwzUDzTo4Dn5OfKXILqYi71z/+u0UgdrRzp43DKX6RO3/EPWgp8gqDlrH5usroo4JGKEGbtMwmqT7UpSMSJbfi5qEq6CO+9KnPtnShPDesdvtBEXMiqOQIgocEHG9VrO8+8czS+ZZCR6mE/P2L/XZb5YDHGo8FHqpGF5QkixpVGcVKvpo4Vq3X4RZ20F29NoxY6siGSmI7kfUJnPwVCAR14xN1lF4VI7/HKiFvxornI/K6tv1ie698uWtmpibFuAJknfYA/x+po5Iyu2xh8ZJZSi84wAplCRmsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT1PR01MB8635.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 13:14:18 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%4]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 13:14:18 +0000
Message-ID: <09086109-a0fd-4b38-817e-b5bd2cbd9c2f@efficios.com>
Date: Fri, 21 Mar 2025 09:14:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: lttng-dev Digest, Vol 203, Issue 7
To: Gour DEV <lakshyagour10@gmail.com>, lttng-dev@lists.lttng.org
References: <mailman.58.1741790192.282.lttng-dev@lists.lttng.org>
 <CAE9Jrzj_A8AwR80s-2_Wnv+vSpgqp4m6jKmJAAVg5VP4SKASEA@mail.gmail.com>
 <605bbc18-bb08-4a72-b470-fc0c34e67acd@efficios.com>
 <CAE9JrzgEisZUcV4ek+bUJriXj3=8ufMYDyHxWYaYVAV5OHor4w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAE9JrzgEisZUcV4ek+bUJriXj3=8ufMYDyHxWYaYVAV5OHor4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::17) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT1PR01MB8635:EE_
X-MS-Office365-Filtering-Correlation-Id: a4e44d06-dc73-4670-735c-08dd687a493a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|4022899009|366016|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWcvd1E5Y2pFUDgxWE5kMmpjeHI5U0c4dU82eWpJZ2p3blVCQzZNT2YzQkNI?=
 =?utf-8?B?UjhsVWExOGtqZ1F2TlNHbnp1Z2pxeE9vUXNiTGZEZlZhZlFWWm1vWmt5Y0Rs?=
 =?utf-8?B?VFZabTFLVWppMTE3cloweStsM2xTRXpWNDdSS0RXd2FSZzZwVnMvZVM5Wmt2?=
 =?utf-8?B?cUJNZmFGUkMvaWd6Z2VOMWpDdkpnL1U3dTlGdlJZR2Urd3l1dTRNWVRJL05R?=
 =?utf-8?B?Uk9vVU4yZUR3TXBiOGtJcG9iRUhaNTJGVWdIcHlnZTdnekFkSUppdFRhTThh?=
 =?utf-8?B?Q2lLTURjNXdlekZnU1orZXRycGRnZFpyR0kzcWRoYnBpUmlsNnBNSEdYQWl4?=
 =?utf-8?B?UEFIWm1ubForYkZBbEtCWDRYbzZBOFhLdzhLRmRiV3lPQ29CYTczZlc3YW5r?=
 =?utf-8?B?bTVwSWRmd0s4MEN3MzVRM3h0RDkrU3JKcE5rSUxqTENqYUZQQ2M2aVJMOEND?=
 =?utf-8?B?V2RPVnljdVRzdzBMdllncjgyRnpKL1FsSWZFbXUzV3JJa2RPeVoxNCtKMk1V?=
 =?utf-8?B?WmRTZDR4dWxxWG5tK3hvMm51UG9GdGJ2MW56b21aNnMyakVmOGcvZWRlc0Iz?=
 =?utf-8?B?SHRuSDhXakEzcjlxY1Q5bFVQMnZCUFo0bThlaTlhT1NjTUhVRm8zSTdCR3JX?=
 =?utf-8?B?ZEx1Y3p0YUYrZGxEZTdyNVR2TmR4bHZMeG40VW9tdUpseHUxcjJxb0tNZzZm?=
 =?utf-8?B?MmdjRTdkS2NtOE4wOVk4ZGEvWTR4bkVYR0Y5VkNmUlFra3ZrQjNZQXFyQUgy?=
 =?utf-8?B?anVSb1NNOE9mcDdvemdpTXozNXNqR2EyaHdKSUhpRU1sK3hMTXJaZmVndXpn?=
 =?utf-8?B?amwwWU10RXFiTWU2TTV6R3p3b3NiZ01qMGN0OGNVQ3BlQ1R1bmpaTTdqakRM?=
 =?utf-8?B?MzNDLzBENG01QnNsYm1Db1pkN1JYd1Z3dnBpOEhNN21rd0lJams1NlpRbllS?=
 =?utf-8?B?cjJnNzJENDdqbjlYWlVDK0xVQ3hmREZBbW9sMVVmaklTVTEyMjU5ZEFySXoz?=
 =?utf-8?B?RHYxOFdLNHRmWHRqYWFYZ05Rd0N3eXBJMzNldEVJOVdZNFhPRWpOT3dpVFlJ?=
 =?utf-8?B?TU83RUYvTW1PV0dOYjhvVmhrRXFaL0VITnFCVGdCUVU3NSt4ZkN5Qm5xTFNT?=
 =?utf-8?B?dUgxVERjWUFhelZnUGdUVDJ3UUx1aXRBMHJYWkN1ZFAwNDNLZEphclE4dS9V?=
 =?utf-8?B?VStEeExSdXRnWmRmL0FYMDhkckRoRFJLVXpNaVNaRU9rNWlHMUFxaWZCMnJy?=
 =?utf-8?B?ZDFOeUJHSkhTcjZRY1hmeHVIS1BqTWRZOG40T1lvUkxac3lTUWxtZlNMd1BS?=
 =?utf-8?B?OHMxRlNrdVREdzJpS1lja2pUdUxza29qU1JWVEJ3MGg2WldFWGNEbFJVSlpj?=
 =?utf-8?B?MXBsTHo3eFJsVHlnNVJSTlZlcEtIQm50MTlWb1RJcGU0bWpmOGdnRDhYMnlX?=
 =?utf-8?B?anZ5d1hQRUovMXgzV29xdmFNWk5sN2NJcWZ3bklGUXVUZ0lxR1ZhMW9yVXE4?=
 =?utf-8?B?ZGpnSnN0SzVuMGoybHA3WDE3eHdyeFUwb1hQQmF2WjQxOEd5Z0NRUUswRjNI?=
 =?utf-8?B?WFZKekV4ODR3enEwUnN6YjNMQW1aTGJvcTNkR0NEcHRKa3UzM2ovQkcwSkRn?=
 =?utf-8?B?U3hBMmR3b0UzSXYzZng5dHZOTTF4SW11blByVFhhNi9KWTZKK050UWYxNHZo?=
 =?utf-8?B?WnV6ckVSK1FZU0N6Rzg4a3dJWmxyS3hNaDBYMnE2MEk0dlpVdGY5TDNKSHVT?=
 =?utf-8?B?MVJ5emtIVTNURC9ONTFqTk1QTHlBR0lobDh5YWpZeFdxUGtERVZlWHVZcUxF?=
 =?utf-8?B?amtwY1BEdFVMWnNpNTJxZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(4022899009)(366016)(13003099007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2NJNTVVREpNRUY4V3RtSjV4STdscFZJR0E3blYyZkpJZGhyeDEzTEl5SkFq?=
 =?utf-8?B?ank4MHhEUTllaEMra1IzeHdoc1RLdG54dVdaM09ZVThpYjhleHFtdFFKUTAv?=
 =?utf-8?B?cnhtUXlxeE9iSzVRSXJJTW1iSTJyZlhTRW4rdVVsVk1JTWJuWHhKb2xlWUJj?=
 =?utf-8?B?OWJPdXprN3VhbzU2c2JBZGJqeExRMG1UOTAvQU5wSWhHeUNvdUVQZG5nWFE0?=
 =?utf-8?B?TDdWT0xVbnh2MVcyY1gyaExrcHNhalN5S215QVd6UVVOQlVUcjRJcDNaVGh5?=
 =?utf-8?B?SmJBUk5kWGRDY2ZCNnhqTldPeS9jREZuRXJ4NlZpdWk0WHlrUnByd0dMN0tt?=
 =?utf-8?B?YlliZ0Y4R1VWSnpRMkRqVUNyd3lFSEF2TTVUQ0loc0pKRGwyMkZJNis1Tjdo?=
 =?utf-8?B?eXhDNmhMRmorUC9VQVUzbnFTN0ZEMGFXRkFOMlE0MENodHJ1bHhEZlJBaXNI?=
 =?utf-8?B?WjlTbnBRUXEwN3I4YTdUaUZ3SXBJK2RndTFSbWlhSjFSY3hidjJ5ZmlUY3hr?=
 =?utf-8?B?NTIwZHJXcjFsa0hLV1JXbjRFVEVNZ05Jak85clVJc2J2TlNiVU0zdkFXd2Qy?=
 =?utf-8?B?VjB5aExPUjN5ME81K1c2Nm5vSXNYUElOL2VnZkxSaFhnOGQzdmlxSHg4TVM1?=
 =?utf-8?B?RWdQYU10NU1wVStVSG1IUXNSajRaZE9mVUZmUEtxNkJYeFI3TWJPQy8xU3Vn?=
 =?utf-8?B?Yk53WGlnMDNnWEQ4MXJUTkxWMDl3dzZJL1BTRHNzR05NdGI5VDgzQUlFSVZE?=
 =?utf-8?B?b3ZjL1lZdWdVeU93ZEFZbDdWSnAwcEVxYmpkYzVubzJYVmFzbDVlbHlOb2dS?=
 =?utf-8?B?Wjlxc01TZ05jZ2JteEFmbGhVSEtRNGl1Nm5PTGRJSzFYdUV1VzFMcWErYlBa?=
 =?utf-8?B?SnNKclBQc0tFemgxRmU1bGh2SHI2bTRBZHJjVDYvbkZmT2NRcTQxNWVnOVJx?=
 =?utf-8?B?Y3VZcVNzSTU0dTlDWVJ6MFlxVEpZSlVpSDRZUHAwYnZ5VG9ock9pVXFWUzV6?=
 =?utf-8?B?aExiaXg4SDY0QlRuSlF6cTdsVVViMjREVENHS04yeWhHYVliNHg2QVJjNUxx?=
 =?utf-8?B?VzRkQ2I3QUNMOHRQQnJidWkvU0pXNVhYYXpla3pMSFlhWDc5Z21KZ3MvVWVL?=
 =?utf-8?B?YW5DQVNLT3NHaU5vNnlUTDFWcUltb3Q1VG1UVHpEK1RoekpzU0RBRjM5b0dS?=
 =?utf-8?B?T3gwcVdzMjN6TVM1WkQ0ZUd5OFdnYW9KRFlNcFlwMHFmM0Q0SnRUcFV5VVdq?=
 =?utf-8?B?bTdVMzhJbHEyY2hTY0V4aEZmVkEzNk4zaW5JeTJ1OVE4T0s5amNKdHNoWDcx?=
 =?utf-8?B?bWRZTkY2TnlnaUQ0Q0g0MS9tTHlQcldLMXkxNU12TXdKZnVVMEN6MVBkTThF?=
 =?utf-8?B?VzNzQ3JLNVkrS1hLRDJ5U2JISExRdUR2RWR0Y1hYci8vaFZUdCtJS1JuWktj?=
 =?utf-8?B?L2gyWklTTXBjN3hYODd6cm5pOGJ5YXBURzBDZXp0S01mWnRVNjJkQ2c0Rzh1?=
 =?utf-8?B?WE5Wd0oxRUl1dmRYRDk0bzhBUGJ5T0lYTDUrNXRLcThGS1pOb0paN3V5MzRM?=
 =?utf-8?B?am5QKy9NeS9ocnVYR3QvRE8vRHRha3dxWi9YbEhrY2lHZUJDSncxeHF5R1dW?=
 =?utf-8?B?aFpWWkpDL2VzR28rdGd0anRqNlZKM1Y4ays5eDRHZEZMaDJuV3B5a1B1MFlX?=
 =?utf-8?B?cWFYdi9KZktNNVM1b3RUTTVCRFBNbzZFUHJKdTNRcnN0NHRmVTBCOVVrMGFM?=
 =?utf-8?B?cVMvRjY3MjdSdEFYdVJFYWtVUHNya2ZDYmdmWWZEMDJGVCs3UHM5K2pGYmNt?=
 =?utf-8?B?MTdyTnZMaitrZ1pXdXRkL0dkUHpwQ3FUbWQ5UExnNjBiQ29NNm9pd1VFRGpB?=
 =?utf-8?B?WG9wK09peklENm9DeHhsOHV2SHg0QXV2Rmp6ZXVBdFpCOXRiQ1lQRVNaQkNQ?=
 =?utf-8?B?T3I1T3Q1alpHMVpLNmJmWWozNE5sc0NsSEd3aUpvK3JBdThDamU2ZTVpcTdF?=
 =?utf-8?B?ZEppT29MWUhaNDRyVW8yYzFsTWZNTlVHeDBHS2Rac2I2dVZibWU2cHpFbzNX?=
 =?utf-8?B?OHJyVmV4UDhvMXBSY0VWVWV3d0Fkc25GbVNhUDRob0pmbTE5VnpaTC9HSHlw?=
 =?utf-8?Q?yfzaxvf2GVcI6io/KlwLL/re5?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e44d06-dc73-4670-735c-08dd687a493a
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 13:14:18.2422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8r2niyhsy6QsFfunE8jbt7gcsFajjA/Vn//OEOE2NSib2Vj7/W+uyMjOkN7LKZAiB5aC4KwdVyf3anj52YraqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8635
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

Hi Lakshya,

On 3/21/25 8:52 AM, Gour DEV wrote:
> Thanks Kienan for digging this and explaining the behaviour,
> 
> Looks like this option is not present in the version I am using v2.13.5 and
> the MAP_POPULATE is enabled by default there
> /* memory_map: mmap */
> memory_map = mmap(NULL, memory_map_size, PROT_READ | PROT_WRITE,
>   MAP_SHARED | LTTNG_MAP_POPULATE, shmfd, 0);
> 
> I have updated to the master branch and have verified by setting the
> LTTNG_UST_MAP_POPULATE_POLICY=none, and saw that now the RSS consumption is
> not very high now.
> 
> I think using LTTNG_UST_MAP_POPULATE_POLICY=cpu_possible is better because
> here I will definitely know how much amount of memory lttng will use at
> start only, and allocate memory accordingly to my servers.
> 
> Also, I thought using --buffers-global
> <https://lttng.org/man/1/lttng-enable-channel/v2.8/#doc-opt--buffers-global>
> would
> be better for me as I could know how much memory will be required but looks
> like that option is only available for kernel tracking, it would be very
> good if this option could be available for user buffering also, but that
> could come later.
> 

Global buffers for UST is planned for the next release. The trade-off of 
using it is that tracing overhead will increase (as the buffers are no 
longer per-CPU), but in exchange for a potentially lower memory 
footprint particularly in situations where not all possible CPUs are online.

> 
> But again, thanks for the help Kienan.
> 

My pleasure!

thanks,
kienan

> Regards
> Lakshya.
> 
> 
> 
> 
> 
> 
> On Fri, Mar 21, 2025 at 2:21 AM Kienan Stewart <kstewart@efficios.com>
> wrote:
> 
>> Hi Lakshya,
>>
>> I did some digging around. What you are seeing is the result of the
>> switching to MAP_POPULATE by default in LTTng-UST 2.12[1] in commit
>> 4d4838b ("Use MAP_POPULATE to reduce pagefault when available").
>>
>> The purpose of this change is to avoid taking page faults which tracing,
>> reducing first-event in a page latency.
>>
>> In the master branch, this feature has been made configurable for users
>> who don't want to pre-populate the pages and would rather take page
>> faults while tracing[2].
>>
>> Here is an example from LTTng master with map populate per possible CPU:
>>
>> ```
>> export LTTNG_UST_MAP_POPULATE_POLICY=cpu_possible
>>
>> # Create session, channels, start tracing, and run test app
>> # top -n1 -b | grep -E '(MiB|COMMAND|lttng)'
>> MiB Mem :  32768.0 total,  21883.7 free,   1456.0 used,   9428.3
>> buff/cache
>>
>> MiB Swap:      0.0 total,      0.0 free,      0.0 used.  31312.0 avail
>> Mem
>>
>>       PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+
>> COMMAND
>>
>>    301117 debian    20   0  880176   2760   2760 S   0.0   0.0   0:00.04
>> lttng-sessiond
>>
>>    301118 debian    20   0   43856   1376   1376 S   0.0   0.0   0:00.01
>> lttng-runas
>>
>>    301133 debian    20   0  718616 263456 263456 S   0.0   0.8   0:00.17
>> lttng-consumerd
>>
>>    301135 debian    20   0    6996      0      0 S   0.0   0.0   0:00.05
>> lttng-runas
>>
>> # cat /proc/$(pgrep lttng-sessiond)/statm
>> lttng-sessiond: 220044 690 690 345 0 29900 0
>>
>>
>>
>> # pmap $(pgrep lttng-sessiond) | grep total
>>
>>    total           880176K
>>
>> # smem -P lttng-sessiond
>>
>>
>>     PID User     Command                         Swap      USS      PSS
>>      RSS
>>
>> 301118 debian   lttng-sessiond --daemonize         0      344      881
>>     2236
>>
>> 301117 debian   lttng-sessiond --daemonize         0     5676     6683
>>     9276
>>
>> 301201 debian   /usr/bin/python3 /usr/bin/s        0     8636    10086
>>    12936
>>
>>
>> # /proc/PID/statm for lttng-consumerd
>>
>>
>>
>> lttng-consumerd: 1749 0 0 129 0 130 0
>>
>> # pmap lttng-consumerd-pid | grep total
>> total kB            6996    1700     472
>>
>>
>>
>> # smem -P lttng-consumerd
>>     PID User     Command                         Swap      USS      PSS
>>      RSS
>>
>> 301135 debian   lttng-consumerd  -u --consu        0      280      563
>>     1700
>>
>> 301211 debian   /usr/bin/python3 /usr/bin/s        0    10048    11501
>>    14404
>>
>> 301133 debian   lttng-consumerd  -u --consu        0   262376   263177
>> 265480
>>
>> # smem -m | grep -i ust
>>
>> /dev/shm/lttng-ust-wait-8-1000               1        4        4
>> /dev/shm/shm-ust-consumer-301133             1   260756   260756
>> ```
>>
>> When using the none policy:
>>
>> ```
>> # export LTTNG_UST_MAP_POPULATE_POLICY=none
>> # as above
>>
>> Running test app UID 0
>>
>>
>> procs -----------memory---------- ---swap-- -----io---- -system--
>> ------cpu-----
>>
>>    r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy
>> id wa st
>>
>>    1  0      0  21875      0   9434    0    0    39   636 1105 2496  0  1
>> 99  0  0
>>
>> MiB Mem :  32768.0 total,  21875.0 free,   1458.2 used,   9434.7
>> buff/cache
>>
>> MiB Swap:      0.0 total,      0.0 free,      0.0 used.  31309.8 avail
>> Mem
>>
>>       PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+
>> COMMAND
>>
>>    301616 debian    20   0  880176   2756   2756 S   0.0   0.0   0:00.04
>> lttng-sessiond
>>
>>    301617 debian    20   0   43856   1392   1392 S   0.0   0.0   0:00.01
>> lttng-runas
>>
>>    301632 debian    20   0  718612   5416   5416 S   0.0   0.0   0:00.17
>> lttng-consumerd
>>
>>    301634 debian    20   0    6992      0      0 S   0.0   0.0   0:00.05
>> lttng-runas
>>
>> lttng-sessiond: 220044 689 689 345 0 29900 0
>>
>>
>>    total           880176K
>>
>>
>>     PID User     Command                         Swap      USS      PSS
>>      RSS
>> 301617 debian   lttng-sessiond --daemonize         0      344      862
>>     2188
>> 301616 debian   lttng-sessiond --daemonize         0     5784     6759
>>     9328
>> 301700 debian   /usr/bin/python3 /usr/bin/s        0     8632    10079
>>    12928
>>
>> lttng-consumerd: 1748 0 0 129 0 129 0
>> total kB            6992    1580     468
>>     PID User     Command                         Swap      USS      PSS
>>      RSS
>> 301634 debian   lttng-consumerd  -u --consu        0      276      536
>>     1580
>> 301632 debian   lttng-consumerd  -u --consu        0     5672     6433
>>     8652
>> 301710 debian   /usr/bin/python3 /usr/bin/s        0     9996    11449
>>    14328
>>
>> /dev/shm/lttng-ust-wait-8-1000               1        4        4
>> /dev/shm/shm-ust-consumer-301632             1     4048     4048
>> ```
>>
>> thanks,
>> kienan
>>
>> [1]:
>>
>> https://github.com/lttng/lttng-ust/commit/4d4838bad480d48424bddc686f5ad0089e28ac94
>> [2]:
>>
>> https://github.com/lttng/lttng-ust/commit/97572c0438845cee953ebd3e39615f78bfa405a7
>>
>> On 3/17/25 2:29 AM, Gour DEV wrote:
>>> Hi, Kienan
>>>
>>> Sorry for the late reply.
>>>
>>> Looks like in buster the memory is allocated by lttng-consumerd reserved
>>>
>>> I buster, the rss is less than the VIRT
>>> root@localhost:~#  COLUMNS=500 top  -b -n 1 | grep lttng
>>>    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+
>> COMMAND
>>>    4095 root      20   0 1003188  31256   4660 S   0.0   0.1   0:03.81
>>> lttng-sessiond
>>>    4096 root      20   0   44260    796      0 S   0.0   0.0   0:00.01
>>> lttng-runas
>>>    4440 root      20   0 5236020  10224   8756 S   0.0   0.0   2:56.25
>>> lttng-consumerd -- here the VIRT is much more higher than RSS
>>>    4443 root      20   0   48048    540      0 S   0.0   0.0   0:00.12
>>> lttng-runas
>>>
>>>
>>>
>>> In bookworm the VIRT and RES are nearly the same only.
>>> root@edgecore-40XKE-j2-101-32:~# COLUMNS=500 top  -b -n 1 | grep lttng
>>>    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+
>> COMMAND
>>>      4382 root      20   0 1098824  42600   8436 S   0.0   0.1   0:08.87
>>> lttng-sessiond
>>>      4403 root      20   0   48928   2116    996 S   0.0   0.0   0:00.00
>>> lttng-runas
>>>      5171 root      20   0 9879764   8.9g   8.9g S   0.0  28.7 108:23.53
>>> lttng-consumerd -- here the VRIT is nearly equal to RSS
>>>      5173 root      20   0    3680   1028    680 S   0.0   0.0   0:00.88
>>> lttng-runas
>>>
>>>
>>> Looks like lttng consumerd is allocating and reserving those pages, when
>>> any instrumented application starts.
>>>
>>> I am attaching the lttng status output in the mail, please do tell me if
>>> you need any more information regarding this.
>>>
>>>
>>> These is how we used to create the lttng channels and enable event which
>> is
>>> same in both buster and bookworm, (number of channels might differ)
>>>
>>> def enable_channel(channels, session, subbuf_size, subbuf_num):
>>> for c in channels:
>>> call(['lttng', 'enable-channel', '-u', c, '-s', session, '--subbuf-size',
>>> str(subbuf_size), '--num-subbuf', str(subbuf_num),],
>>> stdout=devnull, stderr=subprocess.STDOUT)
>>>
>>>
>>> def enable_events(traces, session):
>>> for t in traces:
>>> if 'log-level-only' in t:
>>> log_opt = '--loglevel-only=' + t['log-level-only']
>>> elif 'log-level' in t:
>>> log_opt = '--loglevel=' + t['log-level']
>>> else:
>>> log_opt = ''
>>>
>>> else:
>>> call(['lttng', 'enable-event', '-u', t['name'], '-c', t['channel'],
>>> '-s', session], stdout=devnull, stderr=subprocess.STDOUT)
>>>
>>>
>>> Thank You.
>>> Lakshya
>>>
>>>
>>>
>>>
>>> On Wed, Mar 12, 2025 at 8:06 PM <lttng-dev-request@lists.lttng.org>
>> wrote:
>>>
>>>> Send lttng-dev mailing list submissions to
>>>>           lttng-dev@lists.lttng.org
>>>>
>>>> To subscribe or unsubscribe via the World Wide Web, visit
>>>>           https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>> or, via email, send a message with subject or body 'help' to
>>>>           lttng-dev-request@lists.lttng.org
>>>>
>>>> You can reach the person managing the list at
>>>>           lttng-dev-owner@lists.lttng.org
>>>>
>>>> When replying, please edit your Subject line so it is more specific
>>>> than "Re: Contents of lttng-dev digest..."
>>>>
>>>>
>>>> Today's Topics:
>>>>
>>>>      1. Re: Memory Consumption High After Upgrading to 2.13 from 2.10
>>>>         (Kienan Stewart)
>>>>      2. Re: Memory Consumption High After Upgrading to 2.13 from 2.10
>>>>         (Gour DEV)
>>>>      3. Re: Memory Consumption High After Upgrading to 2.13 from 2.10
>>>>         (Kienan Stewart)
>>>>
>>>>
>>>> ----------------------------------------------------------------------
>>>>
>>>> Message: 1
>>>> Date: Tue, 11 Mar 2025 14:55:21 -0400
>>>> From: Kienan Stewart <kstewart@efficios.com>
>>>> To: Gour DEV <lakshyagour10@gmail.com>, lttng-dev@lists.lttng.org
>>>> Subject: Re: Memory Consumption High After Upgrading to 2.13 from 2.10
>>>> Message-ID: <38dab5ef-f106-4e57-9e36-b4b30015c019@efficios.com>
>>>> Content-Type: text/plain; charset=UTF-8; format=flowed
>>>>
>>>> Hi Lakshya,
>>>>
>>>> On 3/11/25 12:25 PM, Gour DEV wrote:
>>>>    > Hi, Kienan
>>>>    >
>>>>    > here is the requested output
>>>>    >
>>>>    > root@localhost:~# top -b -n 1 | grep  lttng
>>>>    >     4841 root      20   0   11.5g  11.0g  11.0g S   5.9  35.4
>>   8:39.93
>>>>    > lttng-c+
>>>>    >     4824 root      20   0 1098824  26456   5380 S   0.0   0.1
>>   0:07.25
>>>>    > lttng-s+
>>>>    >     4825 root      20   0   48872   2188   1012 S   0.0   0.0
>>   0:00.00
>>>>    > lttng-r+
>>>>    >     4843 root      20   0    3680   1160    816 S   0.0   0.0
>>   0:00.23
>>>>
>>>> This top output for `localhost` seems very different than the output for
>>>> `localhost` in your previous message.
>>>>
>>>>
>>>>    > lttng-r+
>>>>    > root@localhost:~# nrpco
>>>>    > bash: nrpco: command not found
>>>>    > root@localhost:~# nproc
>>>>    > 16
>>>>    > root@localhost:~# cat /sys/devices/system/cpu/possible
>>>>    > 0-15
>>>>    >
>>>>
>>>> You indicated the bookworm machine has 32 cores, this is showing 16. If
>>>> you're comparing a 16 core machine to a 32 core machine, it is very
>>>> normal that the memory usage is higher on the 32 core machine.
>>>>
>>>>    >
>>>>    > Most of the process are running as asorcs user but some are running
>>>> as root.
>>>>
>>>> So you have two users with instrumented applications.
>>>>
>>>>
>>>> Given the discrepancies in the information provided I'm finding it a bit
>>>> hard to understand what you're looking at.
>>>>
>>>>
>>>> In general, a channel's shared memory footprint can be estimated
>> with[1]:
>>>>
>>>>      (nSubbuf * subbufSize) * (nCPUs + 1 iff snapshot mode is enabled) *
>>>> (nUIDs or nPIDs)
>>>>
>>>> Note that the sub-buffer sizes you are using get rounded to the nearest
>>>> larger power of 2. See [2].
>>>>
>>>> thanks,
>>>> kienan
>>>>
>>>> [1]: https://lttng.org/docs/v2.13/#doc-channel-buffering-schemes
>>>> [2]:
>>>>
>> https://lttng.org/man/1/lttng-enable-channel/v2.13/#doc-opt--subbuf-size
>>>>
>>>>
>>>> ------------------------------
>>>>
>>>> Message: 2
>>>> Date: Wed, 12 Mar 2025 14:49:07 +0530
>>>> From: Gour DEV <lakshyagour10@gmail.com>
>>>> To: Kienan Stewart <kstewart@efficios.com>
>>>> Cc: lttng-dev@lists.lttng.org
>>>> Subject: Re: Memory Consumption High After Upgrading to 2.13 from 2.10
>>>> Message-ID:
>>>>           <CAE9Jrzg7qsabhPiO-0=B1DY3bVo-3FYu2tiJR2Bmb=
>>>> nqOHNZMw@mail.gmail.com>
>>>> Content-Type: text/plain; charset="utf-8"
>>>>
>>>> Hi, Kienan
>>>>
>>>> I am attaching an screen recording of the behaviour I am seeing in this
>>>> mail. The behaviour is same irrespective of the device i use, sorry for
>>>> miscommunication in the npocs output (I assumed it was 32), but other
>> than
>>>> that all outputs are same (except the hostname as there are multiple
>>>> devices with same lttng config but this memory cosumption is seen on all
>>>> the devices).
>>>>
>>>> I had few question
>>>>
>>>> 1. Does lltng allocated all the memory it needs and mark it as dirty in
>> ram
>>>> when any process which links/uses lttng-ust runs? (here i tried with one
>>>> process but it is same for any of my process)
>>>> 2. (nSubbuf * subbufSize) * (nCPUs + 1 iff snapshot mode is enabled) *
>>>> (nUIDs or nPIDs)
>>>>
>>>> How do we calculate uid in the system is it all uids in the system? is
>> it
>>>> equal to `cat /etc/passwd | wc -l` ?
>>>>
>>>> I will put my calculations according to the above estimate based on all
>> the
>>>> channel i am creating
>>>>
>>>> (4194304*4 + 262144*4 + 16384*4) * (16) * (30 if number user are equal
>> to
>>>> `cat /etc/passwd | wc -l`)B = 7.998046875 GB approx [this is based on
>> the
>>>> start_lttng.py please do correct me if am wrong here.]
>>>>
>>>> But since there are only two users which uses lttng i think the correct
>>>> estimate would be
>>>> (4194304*4 + 262144*4 + 16384*4) * (16) * (2)B = 546MB
>>>>
>>>> Please do correct me If I am wrong calculations here.
>>>>
>>>> Now, there are a few things here, according to my output lttng is using
>> 11G
>>>> which is much more higher than the what is configured.
>>>>
>>>> I am attaching the lttng status and the file which is uses to create the
>>>> lttng sessions.
>>>>
>>>>
>>>>
>>>> Thank You.
>>>>
>>>>
>>>>
>>>>
>> https://drive.google.com/file/d/1tS_ZWEsXDpHZXfWzZHXmWcT0igiIOIaa/view?usp=sharing
>>>> -- recording of the behaviour which is seen
>>>>
>>>>
>> https://drive.google.com/file/d/1PrU31oyEw1n9tKETlUtmNGO50s6ywx7p/view?usp=sharing
>>>> -- the file which is used to create lttng sessions
>>>>
>>>>
>>>> On Wed, Mar 12, 2025 at 12:25?AM Kienan Stewart <kstewart@efficios.com>
>>>> wrote:
>>>>
>>>>> Hi Lakshya,
>>>>>
>>>>> On 3/11/25 12:25 PM, Gour DEV wrote:
>>>>>    > Hi, Kienan
>>>>>    >
>>>>>    > here is the requested output
>>>>>    >
>>>>>    > root@localhost:~# top -b -n 1 | grep  lttng
>>>>>    >     4841 root      20   0   11.5g  11.0g  11.0g S   5.9  35.4
>>>>    8:39.93
>>>>>    > lttng-c+
>>>>>    >     4824 root      20   0 1098824  26456   5380 S   0.0   0.1
>>>>    0:07.25
>>>>>    > lttng-s+
>>>>>    >     4825 root      20   0   48872   2188   1012 S   0.0   0.0
>>>>    0:00.00
>>>>>    > lttng-r+
>>>>>    >     4843 root      20   0    3680   1160    816 S   0.0   0.0
>>>>    0:00.23
>>>>>
>>>>> This top output for `localhost` seems very different than the output
>> for
>>>>> `localhost` in your previous message.
>>>>>
>>>>>
>>>>>    > lttng-r+
>>>>>    > root@localhost:~# nrpco
>>>>>    > bash: nrpco: command not found
>>>>>    > root@localhost:~# nproc
>>>>>    > 16
>>>>>    > root@localhost:~# cat /sys/devices/system/cpu/possible
>>>>>    > 0-15
>>>>>    >
>>>>>
>>>>> You indicated the bookworm machine has 32 cores, this is showing 16. If
>>>>> you're comparing a 16 core machine to a 32 core machine, it is very
>>>>> normal that the memory usage is higher on the 32 core machine.
>>>>>
>>>>>    >
>>>>>    > Most of the process are running as asorcs user but some are running
>>>>> as root.
>>>>>
>>>>> So you have two users with instrumented applications.
>>>>>
>>>>>
>>>>> Given the discrepancies in the information provided I'm finding it a
>> bit
>>>>> hard to understand what you're looking at.
>>>>>
>>>>>
>>>>> In general, a channel's shared memory footprint can be estimated
>> with[1]:
>>>>>
>>>>>      (nSubbuf * subbufSize) * (nCPUs + 1 iff snapshot mode is enabled) *
>>>>> (nUIDs or nPIDs)
>>>>>
>>>>> Note that the sub-buffer sizes you are using get rounded to the nearest
>>>>> larger power of 2. See [2].
>>>>>
>>>>> thanks,
>>>>> kienan
>>>>>
>>>>> [1]: https://lttng.org/docs/v2.13/#doc-channel-buffering-schemes
>>>>> [2]:
>>>>>
>> https://lttng.org/man/1/lttng-enable-channel/v2.13/#doc-opt--subbuf-size
>>>>>
>>>> -------------- next part --------------
>>>> An HTML attachment was scrubbed...
>>>> URL: <
>>>>
>> https://lists.lttng.org/pipermail/lttng-dev/attachments/20250312/57f240d8/attachment-0001.htm
>>>>>
>>>>
>>>> ------------------------------
>>>>
>>>> Message: 3
>>>> Date: Wed, 12 Mar 2025 10:36:28 -0400
>>>> From: Kienan Stewart <kstewart@efficios.com>
>>>> To: Gour DEV <lakshyagour10@gmail.com>, lttng-dev@lists.lttng.org
>>>> Subject: Re: Memory Consumption High After Upgrading to 2.13 from 2.10
>>>> Message-ID: <0f819583-ea8e-468e-9102-e1410d886a6f@efficios.com>
>>>> Content-Type: text/plain; charset=UTF-8; format=flowed
>>>>
>>>> Hi Lakshya,
>>>>
>>>> On 3/12/25 5:03 AM, Gour DEV wrote:
>>>>> Hi, Kienan
>>>>>
>>>>> I am attaching an screen recording of the behaviour I am seeing in this
>>>>> mail. The behaviour is same irrespective of the device i use, sorry for
>>>>> miscommunication in the npocs output (I assumed it was 32), but other
>>>> than
>>>>> that all outputs are same (except the hostname as there are multiple
>>>>> devices with same lttng config but this memory cosumption is seen on
>> all
>>>>> the devices).
>>>>>
>>>>> I had few question
>>>>>
>>>>> 1. Does lltng allocated all the memory it needs and mark it as dirty in
>>>> ram
>>>>> when any process which links/uses lttng-ust runs? (here i tried with
>> one
>>>>> process but it is same for any of my process)
>>>>
>>>> I believe the shared memory for per-CPU data structures is allocated
>>>> when an instrumented application connects. There is no pre-allocation
>>>> for each possible UID on the system.
>>>>
>>>> You can run your instrumented applications with `LTTNG_UST_DEBUG=1` to
>>>> see when the connection happens[1].
>>>>
>>>>> 2. (nSubbuf * subbufSize) * (nCPUs + 1 iff snapshot mode is enabled) *
>>>>> (nUIDs or nPIDs)
>>>>>
>>>>> How do we calculate uid in the system is it all uids in the system? is
>> it
>>>>> equal to `cat /etc/passwd | wc -l` ?
>>>>
>>>> nUIDs is the number of distinct UIDs running instrumented applications.
>>>>
>>>>>
>>>>> I will put my calculations according to the above estimate based on all
>>>> the
>>>>> channel i am creating
>>>>>
>>>>> (4194304*4 + 262144*4 + 16384*4) * (16) * (30 if number user are equal
>> to
>>>>> `cat /etc/passwd | wc -l`)B = 7.998046875 GB approx [this is based on
>> the
>>>>> start_lttng.py please do correct me if am wrong here.]
>>>>>
>>>>> But since there are only two users which uses lttng i think the correct
>>>>> estimate would be
>>>>> (4194304*4 + 262144*4 + 16384*4) * (16) * (2)B = 546MB
>>>>
>>>> The estimate I gave is per-channel.
>>>>
>>>> small channel: (0.015625 MiB * 4) * (16 + 1) = 1.0625 MiB per-channel
>>>> per-UID
>>>> medium channel: (0.250 MiB * 4) * (16 + 1) = 17.0 MiB per-channel
>> per-UID
>>>> large channel: (4 MiB * 4) * (16 + 1) = 27 2MiB per-channel per-UID
>>>>
>>>> Now, you said you have 0 small channels, 6 medium channels, and 16 large
>>>> channels in your session. (Note: I see your script differs from these
>>>> stated channel counts).
>>>>
>>>> small: 0 * 1.0625 MiB = 0 MiB per-UID
>>>> medium: 6 * 17 MiB = 102 MiB per-UID
>>>> large: 16 * 272 MiB = 4352 MiB per-UID
>>>>
>>>> And if you're running instrumented applications with 2 users:
>>>>
>>>> small: 0 MiB * 2 = 0 MiB with 2 UIDs
>>>> medium: 102 MiB * 2 = 204 MiB with 2 UIDs
>>>> large: 4352 MiB * 2 = 8704 MiB with 2 UIDs
>>>>
>>>> Now this is just an estimation for the per-CPU ring buffers only, and
>>>> you numbers aren't hugely off so without analyzing your specific system
>>>> it doesn't seem to be that strange to me.
>>>>
>>>> If I take the number of channels I see in your script, it becomes:
>>>>
>>>> small: 0 MiB with 2 UIDs
>>>> medium: 136 MiB with 2 UIDs
>>>> large: 7616 MiB with 2 UIDs
>>>>
>>>> total: 7.57 GiB with 2 UIDs
>>>>
>>>>>
>>>>> Please do correct me If I am wrong calculations here.
>>>>>
>>>>> Now, there are a few things here, according to my output lttng is using
>>>> 11G
>>>>> which is much more higher than the what is configured.
>>>>>
>>>>
>>>> I have no idea what 'service start spyder' is doing. Maybe it's running
>>>> instrumented applications with an extra user that you didn't expect? I
>>>> can't help you with that aspect of your system.
>>>>
>>>> The above estimated 7.57 GiB with 2 UIDs would be 11.35 GiB with 3 UIDs
>>>> so maybe?
>>>>
>>>> I'd recommend you read your verbose sessiond log so see which
>>>> applications are connecting and with which UIDs.
>>>>
>>>>> I am attaching the lttng status and the file which is uses to create
>> the
>>>>> lttng sessions.
>>>>>
>>>>>
>>>>>
>>>>> Thank You.
>>>>>
>>>>
>>>> In any case, the information you have given to date hasn't demonstrated
>>>> to me in a tangible manner that you are seeing a difference related to
>>>> the version of LTTng being used.
>>>>
>>>> thanks,
>>>> kienan
>>>>
>>>> [1]:
>> https://lttng.org/man/3/lttng-ust/v2.13/#doc-_environment_variables
>>>>
>>>>
>>>> ------------------------------
>>>>
>>>> Subject: Digest Footer
>>>>
>>>> _______________________________________________
>>>> lttng-dev mailing list
>>>> lttng-dev@lists.lttng.org
>>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>
>>>>
>>>> ------------------------------
>>>>
>>>> End of lttng-dev Digest, Vol 203, Issue 7
>>>> *****************************************
>>>>
>>>
>>
>>
> 

