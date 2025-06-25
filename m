Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FE9C77B7C
	for <lttng-dev@archiver.kernel.org>; Wed, 25 Jun 2025 20:52:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bSDXH5g9Tz1Vrs
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1750884737;
	b=LiIy7hbxG/fMzyXHPJLIk1yHHFM8FbZEJx2VUcjWC0b1Mr3GQPFYiIYptZIgvdl0x6fZ
	 kx7ccrm85GbvOXo8CHE1ha+yjne0X+NlVTahn/Y2u8vhopN9/Gr114xoc10LGFHFb5jws
	 dPBmkgi6bH8lJHcy7WSOsXOexT1bxlDy7qtWfyeh6W9uiHE2u0nOI1/hYAtZDDI9yAlS1
	 8OErl8vNm+ua6tFvTvzuqkUV2QmX9SVq286jVR2cwAgMfsYWe0A1i6IGgaqkjtVilU34g
	 zJKPWWyTstz6ijVa81Bouwg1Z7ZugFFbCm1lU+PdS8DOCe7l+Lng/LymBUEyQm09Q4w==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1750884737;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=6TV/WdFgTNk8fjloihRmGN6gxMGK8kd47deczRywQJQ=;
	b=LxkQwnnSl53n3LUVGD4v73PmPSXhTkBj5PFu6bRGNI/hHRjz+1Pn/J697ivNrsOjnyoJ
	 gBplvm0O/yWZ+TuzlnBstjdz3YSoOou886EoNFN8jHOusvcVveCfgcwT00R2byK5d80nk
	 lJGT4sUicEqKwj5gNcIs8CfAKpXD2AgJQziEzlGGiwRxYlvc4pKipujsrpLPvHiu8X4+x
	 BfU8cG6CxW/JZ+VP+s9i4E4dkyTiDvlRWzPaWbbmhR8JIK8BuKY3FAUShnCjElApvgvV1
	 v3dSt7Pw80qSJgAicbggSDhdd8WYxl0fxQUxHH7m3HIHRlXljgcC+y9Dn9bBn99T/+Q==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bSDXH5g9Tz1Vrs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1750884737;
	bh=6TV/WdFgTNk8fjloihRmGN6gxMGK8kd47deczRywQJQ=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=iEij5RDVKvnFJxCkMUwtjqAalOw1nsJ+YEy1/c0yD2nDCXHUti1OaNqvcQZH3GT77
	 UHXHPGtWSNgFD0WEcV0c/lOP/d8cTraAp93nEbSYjsPZjWTiAisKxflALK8TbjWX1H
	 I81qI6bhD68CLWu8yiJbfreTOv1RAhTixyBrKCPBy1waK3YB/uNEGSSs9Z+nOxmX1q
	 dpvcGg+n/PwfVsUqZn5m/w87TFTOKJL6C4kXKhnHjFz/4xrAAn/RBhfSxqtAYC885F
	 xknGGgdZQkmQHoe8eUHjtvq8LakDq3hZ7ydhXtVIkrGOLIEyC1LAhY1lJBp8Hzgz51
	 eUv1kMw+uAQtA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bSDXH5g9Tz1Vrs;
	Wed, 25 Jun 2025 16:52:15 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bSDXG1GPFz1VT0
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bSDXG1GPFz1VT0
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2097.outbound.protection.outlook.com [40.107.115.97])
 by lists.lttng.org (Postfix) with ESMTPS id 4bSDXG1GPFz1VT0
 for <lttng-dev@lists.lttng.org>; Wed, 25 Jun 2025 16:52:13 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAr8MNrFIYeVkZfrqpNho6LyWasB9EbMY0zt40R36SLQUdmzpgJlbOZ1X+XcyvHeIeePxlqdZUeV9y9fg19bPKOQFHO/ujs7GUFyiO6/hf2I0nJ13ABUy7IGOpsjhePmZeFPSoELU4kLr2mybS2+LLA4YaLGlYglSQaqyjnQeVgQ8FeyN8Luc4dqcxbePTGealy0QfkLMjkmC0fJ5+p3sV9gA1Ze0omm+SoZjmiIpu4k1ZwStRv8LWEPd68zWpodWSzR7WflKIimYitjC1Vl/7x3vo6oSmfk/qVsdWXExgFCL0enX4/0tUR6tk2bBbXTMN3WtApcdeaAoaUm9U281A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6C5+va77gN3TrsVg961TA4kYt9fa2Tovv99OmW1wvQ=;
 b=vV9SI7cGNxO+L05PfZ59Tddqac52F2L5IDiTjjYI/NrrhRAkITTnNWSXqvmwLbAQ3fuuAhVz/JshegR3U+BzbEFaVEdDetstHEXhPT52FBSs/ojMC3ddyeTSAVpEy7RahHeQrfCLgVhRzBycim+pmFr6HrqkLbOfS6AVhc0RqA1HkeosXiVoTRvGXI0pS5fbvFUfBiQbYNgFNRCKtDPoPnh+tRZ7SKsm6fcbRhDrxR8C/YUGBBL91cJDOJ2AfYh4XskfonPypXtL8HfTnMxa5eXY+Vel8agUFzOsGC3bXcztDC2Kdi0FBe48CTx5TivHn2FOsYuAqfSTqmITVbrLKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from QB1PR01MB2353.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:35::26)
 by YT2PR01MB9604.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:af::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.18; Wed, 25 Jun
 2025 20:52:10 +0000
Received: from QB1PR01MB2353.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::2e56:55d7:d22d:5de2]) by QB1PR01MB2353.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::2e56:55d7:d22d:5de2%3]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 20:52:09 +0000
Message-ID: <df4912fc-ccc3-442e-96cb-9d8de791b284@efficios.com>
Date: Wed, 25 Jun 2025 16:52:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Malformed Tracefiles
To: Georg Muck <georgmuck1@gmail.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <CAEobtPOhc8K3c-Qcymm1m-pRpHSZyDSarAKoGKeiKqZfUqXOCQ@mail.gmail.com>
 <34912d84-7750-454c-9f96-fb8d865ba8d8@efficios.com>
 <CAEobtPN-Yq_zpu18FsbS-2s4WhJhpEgjK2yuQ+NeOxcGFuaENg@mail.gmail.com>
 <6914656f-9b7b-43fa-9dd1-9b27506c6d2a@efficios.com>
 <CAEobtPPKOTgJKObVg2hFe2TPR15gTybut=QqrgFhzkPAF3qe5Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEobtPPKOTgJKObVg2hFe2TPR15gTybut=QqrgFhzkPAF3qe5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0153.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::26) To QB1PR01MB2353.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:35::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: QB1PR01MB2353:EE_|YT2PR01MB9604:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a3004f9-fe69-4afc-fb76-08ddb42a2723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUVCSDBnbFhoVnBOK2kzM2hVcXlpVWljTGNUaElObWhBNU13QVIzSG1rSDBE?=
 =?utf-8?B?VitsMnBadmdPdi96VUppdkhqcUJsK1ZTNHVQS2RDbU14c0hKYjFMaWppRlpu?=
 =?utf-8?B?WXNoSGl3MnlLQmg1Vm9IVy9rSXN4N21FdGJsWkdwamdDTTNOY2JRQlZPemRY?=
 =?utf-8?B?QS9KcUMyR1dyWHZMekJ2UkRpblUwR2xDK2lqM09RdkFSeGFXem14YkxGRmw0?=
 =?utf-8?B?S21tRHB3SmRFK2FTNWJ2UkVZbUIvOEV4M2xRZzB0eXo2cVZQa0hQbTJlT25F?=
 =?utf-8?B?WmZnV1diQldqQnYyTlBDdGZuenJFN1orYWtEQUQzWUJlMFdOQXlmTUlYNUt3?=
 =?utf-8?B?K3BOWWVNLzc0dVRCbFFJRTNCYmFabW05RVprMGxtVDd4ZzNRYXpYQy9zSVFL?=
 =?utf-8?B?VE8vWmJscU03YXRELzMxMUo3VkZSYWtJc2MvaDcyQkZJQmhmQ0NYNFZkTTIz?=
 =?utf-8?B?M2RXemFMSDBiYm43ZlJ1WG0wdWswak1kYXF5dWthYTlRcTUwTGFoN0tDNGo5?=
 =?utf-8?B?bU5HbTNkRkVKN09kK3BIWXpwSnpCMm4zZW1rTmpGU2VHRTgwWmwxTE4zR1Qz?=
 =?utf-8?B?dnU1SmdLY2VOZlhmOVJ4Z21yWTlHakw0V0k5SDZrd0ZhTFlZRE5JMTV0clBR?=
 =?utf-8?B?c015R3ROaWh5em8relZCU09lU0N6VjNRR0p5dHZGZ1Z4eW53Z05VZkVZc1pq?=
 =?utf-8?B?ZHMzejRnZXhHYjM5Ny9CVnJJVGpwYkxqSE54dkIvekpKblR4eHFKNDN5U1oy?=
 =?utf-8?B?Ni9iYzNJM2xFWHc4VzF4TnRVYmc2cmJYYXUrUDhBRHNRMGtXK0pONFFlOGpN?=
 =?utf-8?B?UzNzT0w1Nzd4dHNLQVRFczFQeHhVdlVvQzZwOVl2MFI2SWFLYzVBVndsTXlN?=
 =?utf-8?B?WEdkWmx4SUVxdTFTZTJUanRKa2VMQjIzM1NZZDBVK3JscHdUenoyY1dSd1RJ?=
 =?utf-8?B?eURmUjVRU0xnSHRlMytxMkdwTjFJS09sZEFTdUZFdW9xcUdreTZhaVgzTElU?=
 =?utf-8?B?ZEViUzVlYy9ndFlFY0s5S2l5bFlPNnZpOTU1bHQ4Ym9tYUpzVGdFNXlKYXFB?=
 =?utf-8?B?UTJtcmEvUE0xczkzejNhZEE3Vmo2RW5VNkRya3RFQ0llTjNzVGszeTl6L2hn?=
 =?utf-8?B?d0hpNVhxOUw0bHMrUGxsRnVZVnZJdmpZL2dEbDd3a04zdG81WmpPaUxUeDdP?=
 =?utf-8?B?K1N0RldzdzJJYmx4TmI1OXdMcWJuUWlDYUVGTHhnRndFamhuM0xOM09CTUMy?=
 =?utf-8?B?dktqbjVQelVRaW5wQnNTc0FIMitGRWNJcTlPeVlsSmhWWmxaOS9aeGZDNW9R?=
 =?utf-8?B?OFVvaTZLeHRJQktkVS9uaUdjaXdaNkF3QTM3QWhmeGEvUVVwZEhYOWg5Wm8r?=
 =?utf-8?B?VDhMU3hoSUJkTWRWUUYydVRUQ0RnaTZmcnJ1VFpuSW1SSzVoYUoyVGE4ajFs?=
 =?utf-8?B?eFZGbDhWalVOekRETm93RzlBOEtLZ0VMRnFWSGY2YnNEVHZHd0RUQzlkOFlR?=
 =?utf-8?B?Wk5yUjY5SUY1eXVOZkpZN3Q4dVExNTVpQktkcU1JcmdUNTJqNjhpMm8vd1Nm?=
 =?utf-8?B?YmtwNWIzU09HMDRUdG1KQVFYNzB2S1dBbHN6YXE4UWFqNml5VnVuWnpsbzky?=
 =?utf-8?B?ZHpPcWFwUmREOVk1Q0phamhaalA3VE5vK2IwYmd1T2drdjZVc0VVdXRoYzFu?=
 =?utf-8?B?SVRGSzhJbmZydFVadmhhQ0l1Y2ovZlM2cWpQNFhyVXAySVN6UCtSVUcyQ1dr?=
 =?utf-8?B?dXJDbHU3TVh0Y01RSG96alFvSStJN1JpN3ErOGRERk1kVkVjNjJuRlJ0OEQ5?=
 =?utf-8?Q?XJl+hcTUrO1LEmwhA7tCE4ZGaQrLs08CgGOww=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:QB1PR01MB2353.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUJtMFExRnRTRkxUSTFMS2o1NUZVVEJwTldmYmZYQnRvM2orRkx1Tmt6ZFll?=
 =?utf-8?B?V3VsaDZWWXBxNzdxQU5Pa3dLd09yeld6V0liWkxkenlqNjJRdmNiMHg5U2N0?=
 =?utf-8?B?d3RteDZqL084TGF4UW1XbTRsM3NDK2xkaEpkWmQvMmorL1lIVU1FdE94d240?=
 =?utf-8?B?MjU1UmVHMmVRWGc4U0VvdGZNSG9mbE5SS2lxUnlsU1hCaWlQRHRJa3k3V3hF?=
 =?utf-8?B?QXZGY1A2NWEzZVV1U09rS2o4S1AxOC8zblRqdGk2ejZOSjJoRVlKL1c4Vnps?=
 =?utf-8?B?TGF2cytrazYrTHdiVmhtR2pmZE9HSHZDcDZJMnJKNk94S3hIRUVqUmthUGlW?=
 =?utf-8?B?emZOUzExQ2tmTzZyenp3TzA4cklVOHZBdHpIaVBOVVdhVk00SzFzeDZLenMv?=
 =?utf-8?B?R2ZIems5QkZ5dFBPL2ptMkNvRkorbDV3L0xlL0ZuTFNMdWRoWDhhV0V3UXQ3?=
 =?utf-8?B?VGV1R3FJWXQ3bElOSlZNSHd6QXhzR0paRkJLY1BaTHNVT3NwTk9sMjl1dWg3?=
 =?utf-8?B?V2dCdU02Sk04SCtKNnYvajljVFNQUjkvUzhxS0FhemhLdU0xalNTaGFjcEpj?=
 =?utf-8?B?V2NibWRtYnZVYldEcW1QeE41Znl0RGR4QitCTnAyOG0va1FvcFlzdDFJakw2?=
 =?utf-8?B?eGdQYzl0bm5wMGY1OThiNnN2WmVZR3JXb2lIWXEzQUxxanBCd0xlTlZvYTdr?=
 =?utf-8?B?WlBJdWtWRitWSlVwcGxZM3FQTlNmL2w1M2NhaytSdkFHL0hmZkI0cW1OUHFG?=
 =?utf-8?B?QUFoLzM2bmZld1kwWjVZQUhCY29WWlZKT0l0cWM5U294dHVRaVlPRy90MDZr?=
 =?utf-8?B?TytkTXVmUkJpTXhldWx2dmU0STVzNzJaT05JMWZuSW1zQXgrMnVwY0grMVpv?=
 =?utf-8?B?dnI3R0NxbzRKa2hINTlIYWVuK1hRT0dUZURqM3hXMzMvK21QQTdKK2gvaDdi?=
 =?utf-8?B?V2ZkU2pGaWw2dmhKdVZlMEUzdU05UXpvYVJIUU04aGFGQVRYYktJMXo3WHlL?=
 =?utf-8?B?SVk5ZXVacSt5MFFzc3Z4RUtJSVRBS0RDTGY5NUFEZVZyODFKZnNkK29lT0dC?=
 =?utf-8?B?YXd4YlJ4bU42a2JtL2xZSmlnc0JjOGc3dE85WERVUHBFTERaR04yRjdmYndS?=
 =?utf-8?B?cHJZY0Fpem5VSzFmd01UWCtaY3d3bzUrTGkxT1oyNGVPWDV3THZCNlFQanQ5?=
 =?utf-8?B?Rjc0a2lJWm9yM2JaUzgwZVZKL1hENnVITXFUc0R0TFVtZEhOeXlMTHFJeWNX?=
 =?utf-8?B?bmwrTGRKczZTQkJ1SE92Q0REbXdZVkxGNlZBQlpRbUxnM2RITEFSckJ4dGNU?=
 =?utf-8?B?TUhkRTdDS3pJRUxCcEtscDVEaWJ3S2tXMkQ5WGJsYld3T0VrZmtobDJFOEZw?=
 =?utf-8?B?RkhYWlVla0pORzAxczkvSDBIdzZPMWJ0enNDN0VrNFpvNm9ab0NNcWdYNkhB?=
 =?utf-8?B?ZnlKMmtZQXBQZittV2l0MEQySVl2aXFoUTR3Mk5TaE5TTll2ZkY3NHJNYUZN?=
 =?utf-8?B?TEdneXduY1J2TCtSRSthTlBhSVdDZXlPclY2TS9uRVhTTGJ1K0FKOFZkVEhv?=
 =?utf-8?B?cXE0aEsvWTNCQXdKMnlUanNKN2Jmb3hrNUlkUUZpMXVhYmprUkQ3QU9QbDdN?=
 =?utf-8?B?My9YMUp2YUZnZXJVN1FQd2Z1L0NVRTdRMzNDVmxXOURlUG9Jb3QvQXlqZ3pq?=
 =?utf-8?B?cHZjRlRESDd2T013cllmVmtnNDdvSlZpM01EYUdXbm1XdkYxWkhwaUtFZEpp?=
 =?utf-8?B?b3lZOU13dlVBdEdNcnBsdFd4WWpvU3BVemFlL1d4MjNiN2k3UEpOcTViRmUx?=
 =?utf-8?B?RDV4VjZaWFo1OGZiUW1kenNnVytHM1JJRndnY1ZzZUJqTUFORlE0SVcvOUY0?=
 =?utf-8?B?NlBqNGw3RUppU3JzZVZKWG5vdm9KSmdnNG81M2tJeTBzUDRXd2lKejZUZzg2?=
 =?utf-8?B?WHp0eG8wRWU3aHVPQ0UvUmxwZGh6QmtDTGFMa2hpS1dkQ1krb0Rvc0hTQXRL?=
 =?utf-8?B?bnE5eUJ5VGVtSkF2RVdmMm5ZelhOOW9NRUIraU5CRk15VUlXTDlrN1AzUElK?=
 =?utf-8?B?c3E4SGprenpzVlRrOTlhNk81aG5RR1YwL3lqdDUzMW9nTkMrM21KS0NWaUQ1?=
 =?utf-8?Q?o7gpogJQBMtsn3HJKBspvqNY/?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3004f9-fe69-4afc-fb76-08ddb42a2723
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB2353.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 20:52:09.8278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0B9DhFsJ4o+jCsJIgOkJWZnIFcnKJryR3yY+lbF4Ruj0S/4uHM+oZDeAvCGE0CA80VI3oYk+LUyqNCKD2YNXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9604
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

Hi Georg,

On 6/25/25 1:27 PM, Georg Muck wrote:
> Hi Kienan,
> 
> thanks for your quick response. :)
> 
> I replaced "--daemonize" with "--background".
> 
> I guess I should briefly describe my goal to avoid confusion: I want to
> trace a ROS2-session online (tried LTTng-live, but it costs too much
> ressources, hence the aggressive rotation of 1s). LTTng gives me the path
> to a newly created trace-file as soon as it is created. This path is
> forwarded to a Thread-Pool that does the rest (analyses each tracefile by
> itself)… . However, the tracefiles are removed in the end, cause I'm not
> interested in them, only the program should be interested in them (forgot
> to remove it in the example). The problem only occurs when I start to many
> ROS2 instances at once, meaning gathering too many tracepoints at once (at
> once meaning in a very short amount of time). It works fine for 1-2
> instances, but it doesn't work for 16 instances.
> 
>> 1. *Before any traced application is run, babeltrace2 has the following
> error output:* Ah ok, thought I would be on the right track.
>> 2. *After a traced application is run whether is produces enabled events
> or not, I see the events recorded*: What do you mean by that? There is no
> babeltrace2 error if traced instances are running, even tho they are not
> creating events?

This is what I observed with a fresh start:

before running any traced application: bt2 error with no traced content

after running a traced application with no events: bt2 no longer 
produced an error, but output 0 events (as expected).

In this case I expect that it is because the consumer started and basic 
metadata was available so that was written in the snapshot. If I recall 
correctly, the consumer daemon only starts when the first application 
connects

after running a traced application with some events: as usual
>> 3. *When your session script stops, the output folder is deleted*: like
> described, forgot to remove, but it is on purpose
> 
> I tried *tp**:tptest*, but there is no output shown by babeltrace2 (is that
> intended?):
> 

I had the 100 events produced by gen-ust-events binary that invoked. You 
ran it but the events weren't recorded? Regardless I think we're on the 
same page that the session setup program you are using is fine right now.

> [georg@KARTOFF8xE-zenbook /tmp/structural_traces]$ babeltrace2 archives
> [georg@KARTOFF8xE-zenbook /tmp/structural_traces]$
> 
> 
> However, I figured something out:
> When I trace the "ros:rcl_node_init"-Tracepoint and start 12 ROS2
> Instances, I receive the following output for the entire archive-directory:
> [georg@KARTOFF8xE-zenbook /tmp/structural_traces/archives]$ babeltrace2 .
> 
> [19:01:41.474172508] (+?.?????????) KARTOFF8xE-zenbook:listener:(24897)
> ros2:rcl_node_init: { cpu_id = 1 }, { procname = "listener", vpid = 24897
> }, { node_handle = 0x5CCBD0EFA280, rmw_handle = 0x5CCBD107A420, node_name =
> "saturn_listener", namespace = "/hallo/saturn" }
> [19:01:41.493613263] (+0.019440755) KARTOFF8xE-zenbook:talker:(24898)
> ros2:rcl_node_init: { cpu_id = 4 }, { procname = "talker", vpid = 24898 },
> { node_handle = 0x5A8E10DFC6E0, rmw_handle = 0x5A8E10F8AA60, node_name =
> "erde_talker", namespace = "/hallo/erde" }
> 
> All coming from archive-file number 10:
> [georg@KARTOFF8xE-zenbook
> /tmp/structural_traces/archives/20250625T190141+0200-20250625T190142+0200-10]$
> babeltrace2 .
> 
> [19:01:41.474172508] (+?.?????????) KARTOFF8xE-zenbook:listener:(*24897*)
> ros2:rcl_node_init: { cpu_id = 1 }, { procname = "listener", vpid = 24897
> }, { node_handle = 0x5CCBD0EFA280, rmw_handle = 0x5CCBD107A420, node_name =
> "saturn_listener", namespace = "/hallo/saturn" }
> [19:01:41.493613263] (+0.019440755) KARTOFF8xE-zenbook:talker:(24898)
> ros2:rcl_node_init: { cpu_id = 4 }, { procname = "talker", vpid = 24898 },
> { node_handle = 0x5A8E10DFC6E0, rmw_handle = 0x5A8E10F8AA60, node_name =
> "erde_talker", namespace = "/hallo/erde" }
> 
> However, looking deeper into that file I saw that there are all 12
> instances (+some of ros2 itself) I started within the trace-directory
> number 10!
> [georg@KARTOFF8xE-zenbook
> /tmp/structural_traces/archives/20250625T190141+0200-20250625T190142+0200-10/ust/pid]$
> ls
> 
> listener-24897-20250625-190141  listener-24903-20250625-190141
>   ros2-24447-20250625-190131  ros2-24887-20250625-190141
>   talker-24900-20250625-190141  talker-24916-20250625-190141
> listener-24899-20250625-190141  listener-24914-20250625-190141
>   ros2-24451-20250625-190131  talker-24896-20250625-190141
>   talker-24902-20250625-190141
> listener-24901-20250625-190141  listener-24917-20250625-190141
>   ros2-24834-20250625-190134  talker-24898-20250625-190141
>   talker-24904-20250625-190141
> 
> BUT:
> I looked into the specific directory of a traced instance (underlined it)
> [georg@KARTOFF8xE-zenbook
> /tmp/structural_traces/archives/20250625T190141+0200-20250625T190142+0200-10/ust/pid]$
> ls listener-*24897*-20250625-190141/
> 
> index     structuralChannel_0  structuralChannel_2  structuralChannel_4
>   structuralChannel_6  structuralChannel_8  structuralChannel_10
> *metadata*  structuralChannel_1  structuralChannel_3  structuralChannel_5
>   structuralChannel_7  structuralChannel_9  structuralChannel_11
> 
> and of a non-traced instance:
> [georg@KARTOFF8xE-zenbook	
> /tmp/structural_traces/archives/20250625T190141+0200-20250625T190142+0200-10/ust/pid]$
> ls listener-24899-20250625-190141
> 
> index                structuralChannel_1  structuralChannel_3
>   structuralChannel_5  structuralChannel_7  structuralChannel_9
> structuralChannel_11
> structuralChannel_0  structuralChannel_2  structuralChannel_4
>   structuralChannel_6  structuralChannel_8  structuralChannel_10
> 
> Turns out: There is no metadata file within the second one. Therefore
> babeltrace2 is not able to parse the file. Do you have an idea why?
> 

 From your later e-mail with the updated sessiond log which shows the 
PERROR for too many open files it sounds like you have a thread to pull on.

You can try using the per-uid buffering scheme to reduce the number of 
FDs required when running 12 concurrent instances of ros.

> Best regards,
> Georg
> 
> Never burn the bridges before you
> If you've burned the bridges behind
> Never burn the one that you're walking upon
> Or you're sure to hit the water in time. *(Savatage, Streets, 1991)*
> 
> 
> Am Mi., 25. Juni 2025 um 17:50 Uhr schrieb Kienan Stewart <
> kstewart@efficios.com>:
> 
>> Hi Georg,
>>
>> On 6/25/25 9:36 AM, Georg Muck wrote:
>>> Hi Kienan,
>>>
>>> I did exactly that, without success.
>>>
>>> The log of the lttng-sessiond (lttng.log) did not change after starting
>> the
>>> ROS2 instances. I have also added the output of "lttng list
>>> structuralSession"
>>> I start my tracing instance as follows:
>>>
>>> At first there is a bash-script that sets everything up, it does the
>>> following:
>>>
>>> lttng destroy -a # to destroy all existing sessions
>>> lttng-sessiond --daemonize --verbose-consumer -vvv &> "/tmp/lttng.log" #
>>
>> When started with '--daemonize', the file descriptors are closed[1]
>> after forking which is why you don't see any further output to
>> /tmp/lttng.log. Try with '--background' instead.
>>
>>> starting a new session Deamon
>>> ./exemplary_tracing_session # starting my exemplary tracing session
>>>
>>> The exemplary tracing session is written by the help of the c Api
>>> (appendix).
>>>
>>
>> I modified your script to add 'tp:tptest' (a tracepoint from the
>> lttng-tools test suite program gen-ust-events) and did the following:
>>
>> ```
>> $ lttng-sessiond --background --verbose-consumer -vvv &> sessiond.log
>> $ ./exemplary_tracing_session &
>> $ lttng-tools/./tests/utils/testapp/gen-ust-events/gen-ust-events
>> babeltrace2 /tmp/structural_traces | wc -l
>> 100
>> ```
>>
>> It seems to be working fine for me. A couple of notes:
>>
>> 1. Before any traced application is run, babeltrace2 has the following
>> error output: No trace was found based on input `/tmp/structural_traces`
>> 2. After a traced application is run whether is produces enabled events
>> or not, I see the events recorded.
>> 3. When your session script stops, the output folder is deleted.
>>
>>> I started the the same procedure on another machine. The same fault
>>
>> The fault is that the babeltrace2 has an error, right? Are you willing
>> to share your trace that has the problem and/or show the output of
>> babeltrace2's error?
>>
>>> occurred. I think I need to configure more within the `lttngDomain`. But
>> I
>>> don't know how, would you have an idea/hint?
>>>
>>> Thanks for your help.
>>>
>>> Best regards,
>>> Georg
>>>
>>> Ps.: I also added the log of my tracing tool (structural.log)
>>>
>>> Never burn the bridges before you
>>> If you've burned the bridges behind
>>> Never burn the one that you're walking upon
>>> Or you're sure to hit the water in time. *(Savatage, Streets, 1991)*
>>>
>>>
>>> Am Mo., 23. Juni 2025 um 16:26 Uhr schrieb Kienan Stewart <
>>> kstewart@efficios.com>:
>>>
>>>> Hi Georg,
>>>>
>>>> a good first step is to run lttng-session with `-vvv --verbose-consumer`
>>>> and inspect the log file and `LTTNG_UST_DEBUG=1` in the environment.
>>>>
>>>> It may also be useful to run your traced applications with
>>>> `LTTNG_UST_DEBUG=1` set in the environment.
>>>>
>>>> Do you have steps that reproduce the issue? E.g., all the commands to
>>>> set up the tracing session and so forth.
>>>>
>>>> thanks,
>>>> kienan
>>>>
>>>> On 6/19/25 10:58 AM, Georg Muck via lttng-dev wrote:
>>>>> Hey,
>>>>>
>>>>> I am using the LTTng tracer (2.13.11, C-API, rotation=1s) to trace my
>>>> ROS2
>>>>> system (userspace only). Everything works just fine within my Docker
>>>>> Container (Ubuntu 24.04), but if I start the same procedure on the host
>>>>> itself (also Ubuntu 24.04), it does not create a TraceFile if to many
>>>>> tracepoints occur (speaking of roundabout 1500+ per second) (sometimes
>> it
>>>>> malformed the tracefile, but I was not able to recreate that. If I
>>>> remember
>>>>> correctly, Babeltrace2 threw an error that said that there was no
>>>>> metadata-file). I played around with some configurations (like
>> increasing
>>>>> the buffer size from ~16kB to ~512kB or a less aggressive rotation),
>> but
>>>>> the problem stayed.
>>>>>
>>>>> Would be thankful for help. I guess I delivered to less information,
>>>> please
>>>>> reach out what is interesting at this point, I am not sure about that
>> :).
>>>>>
>>>>> Best regards,
>>>>> Georg
>>>>>
>>>>>
>>>>>
>>>>> Never burn the bridges before you
>>>>> If you've burned the bridges behind
>>>>> Never burn the one that you're walking upon
>>>>> Or you're sure to hit the water in time. *(Savatage, Streets, 1991)*
>>>>>
>>>>
>>>>
>>>
>>
>> thanks,
>> kienan
>>
>> [1]: https://lttng.org/man/8/lttng-sessiond/v2.13/#doc-opt--daemonize
>>
> 

