Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D6FC77B7F
	for <lttng-dev@archiver.kernel.org>; Mon, 23 Jun 2025 14:26:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bQr4V5pTNz28M2
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1750688810;
	b=HO78diBT+uiB/jUpsddpV2CQ3rh6iC9ONOzpplOQpZcHW3NRxGAPAqdA5utQvv/V6i2j
	 Eq+EBM8K920H7hsUljeERadWBrHAgcRelj4mvXLcAB6BL6wLb4w7/3u3sWRXDu4n8G/Oj
	 U0CWbECNnJfusCn55gLhEy9AYnCnJ4nl44QFwBkqPb+NSK5W/040HNAlGsJdnkE5eRqFd
	 b4dIE188ffaLlaAWebYKZizxk+NsLJPaq6bL0iq7W3XU3A3uzegxIIXJhO1r+KAWAUD2m
	 iT6HkfbKZs1lquXnBzS6zjiH6tW04vvPs6VjAqACl4dnbogLSESVrPip0fWxnlY/mww==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1750688810;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=xT+mv18icC/2i3NEJgFb8s+JCFt7YrML0c7wmj1FDaM=;
	b=hRw48JNT6aWyr73Iyf12dJhZH1ZKEmAn+j9V2+tI94MtQEmGWrUB+5+E2ltkrt90IOy7
	 AGacyIglH0uNwYeSM2L1JO3iw9KR5OKITGR6oAXDOtUUW7+dhx+KoKwVAnu03Sm4DOYbq
	 XbsuefkVLH9yuPRucTfYUin5/ppbsCl1TCY9j9bqpxHkwzw1EnWQfHZP+eFhBEQud9grL
	 wfDZfynsSWtUU0WiO8mr0u1/aafhvOdAXRs03eZOMYmAFi6MFw1lr8Tgr0pg6ZnW7mIxN
	 dZa5KdDzPiJlOt+O2jsWOmFIeqrteV8H1feoOUyXEDZdEbErUXv/fqIDk8aPL0L+E7A==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bQr4V5pTNz28M2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1750688810;
	bh=xT+mv18icC/2i3NEJgFb8s+JCFt7YrML0c7wmj1FDaM=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=FXPF6wpl7O/DHQsYrXNSsL/xvGqsD4R+SH2IBoHLsfAmKWc+dW3KnBfi/l6KavP9V
	 o8EggNVjsdZ18qHol0PRNiiuqvxC3dfcHarWZ4xIsvchWHgL0VvIID7Rl3tb3kCWmC
	 YsEWDR8Dtynqj5/OKz2b5Ghim747tq+ngnMeSM+ft7HAXJhoGWLS2ozYxkxZ5pOTOv
	 1V8s/kM24wwwapQqgZDki5+TqqaZklPslldua71nDkoNUvf8mcCf04SCtcIJbyoY/t
	 g+i12yC78AALHhKlD1EU5z8Kw0cbVG9rCsn5kUWAhvZ4VUPShrcltWB3L+xx9K9l52
	 KX27zvskFLayA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bQr4V5pTNz28M2;
	Mon, 23 Jun 2025 10:26:50 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bQr4T4N3qz28cd
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bQr4T4N3qz28cd
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:241d::724])
 by lists.lttng.org (Postfix) with ESMTPS id 4bQr4T4N3qz28cd
 for <lttng-dev@lists.lttng.org>; Mon, 23 Jun 2025 10:26:49 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZlAnBkjhihev1pJE9xrDBTbqAvlBPUm3Xz+/kJG92Y1cQfmXt0rbevzPDj5wFUh9rxWHxYeqdzW4feFGE6tLwk4d8i2oxT/G+q1vzn6EMWg9Ez3yu31s4X38M1M0JKu351vDy0D0aIlUXik3sQdixwcxlM+70WlU6mZ08bUAiW06lFggN/m3yfOIl/a5ttWDmci+L51ytiwSJw0ObDM5ZdmBw0ADKnO1KZcJgEf+UmjiXbsnrun7Q6SekhSi0xSR+1BFcZCkoDnOdpGqRfeLNi6694Dh0wU59rEBicQomv8YzBTdDU2eq2p0mrcW/6W0+ieoXIg9ETPwucSpi9mVVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OoqdRaNqU6p5rvBb8KICuKTvQ3QNrx5HpNM+qaHpds=;
 b=XyTQzRUFuq+tOpVcceOx12Gih7FLrb0A54IMboE5yjm2WZlNE4raWgbDDQFvMU97FiIgp025CzRo0m0AF3IRgrvFkMM99NINBjkPOTgNfbfIG9Pi2OFIoiTSC7rm8FFCeOdsSSuGUcA/LrA4TrF22GVKgJFZqEM261pOoZAjJlWUCEmLTTJdM9d+a9rcNnVEPCVY+mhNfw1CeiuQGdWLDinZ2+NA/1rVNR/yYGD+pSG5SiExGtB1Qw9MdAX9TPAV8G/58rILtFzq8uFaMjeM2mUNA/GNs0u6zE718PgS8bohzz++KfHArvQFooW6xDzfvcg4klIEhPRj6pj5h37kFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:5d::22)
 by YQBPR0101MB5482.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:45::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Mon, 23 Jun
 2025 14:26:46 +0000
Received: from YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b5fa:c0e6:e5b7:54a4]) by YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b5fa:c0e6:e5b7:54a4%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:26:46 +0000
Message-ID: <34912d84-7750-454c-9f96-fb8d865ba8d8@efficios.com>
Date: Mon, 23 Jun 2025 10:26:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Malformed Tracefiles
To: Georg Muck <georgmuck1@gmail.com>, lttng-dev@lists.lttng.org
References: <CAEobtPOhc8K3c-Qcymm1m-pRpHSZyDSarAKoGKeiKqZfUqXOCQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEobtPOhc8K3c-Qcymm1m-pRpHSZyDSarAKoGKeiKqZfUqXOCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0315.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::16) To YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:5d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB6319:EE_|YQBPR0101MB5482:EE_
X-MS-Office365-Filtering-Correlation-Id: f7cf49e6-1685-4db3-643d-08ddb261fb8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXczRzNDWGpaUGhoSkpsZ2FBL05vb0NmR0ZXaWk2WXNCOU5saVkvZkc3TVJx?=
 =?utf-8?B?RktIZS9FSkYvbENORnBBbm1ib2tYUW9GNHU2bFIvc0NqY2xsNEJDZC9veVRz?=
 =?utf-8?B?VE9LYmQwWHd0Q2xjT3VQazQ3NHFPK09MVEo5MncrZEJOUFdNOGcvN0g1L2J2?=
 =?utf-8?B?NnlLbTkxenpEVUQ2TWpqWUs1VzlTN0c5T3dvc1Y0OUlYRGxCR0RVZTdZVUhV?=
 =?utf-8?B?TGpmVGkya2lZa0g2Zkg1Yk8wb2NCY3F3NVFmUmFWWHA0RGJpNUxNTTFRNEx3?=
 =?utf-8?B?blpSY1o1TnY5aDExNTBHS09MWDZHU0xOaXJ5ZWVpS0xpR1MvbThYR3MwaXlU?=
 =?utf-8?B?bmFielFhZEVMY0w3SEJ6RTdyYnlVRG50bGt5Z1U0RndORkFqVFUwQjNPRHVF?=
 =?utf-8?B?U1RNZmJmbXVTMk5VMStVbVpNMC85N1JvRTlUSDNkTTQxZFJYQlphc1ZLM2F3?=
 =?utf-8?B?YU1ZYkRldTBwYUxpdlFBeTRDazJVWkxXUWNQMExFR1RiSzdXaFo4bThVSHpx?=
 =?utf-8?B?WWpGaVBqbS9UZFlYQ0JldXVLdklrbVREaGFaWk95QmMzYWQyVXMxeG1LTTdr?=
 =?utf-8?B?VG1KSmRjZklLVCtSTlNCWGlJR1ViN21uMmI2czdxem9qSldkL0gvdVF4ZWE3?=
 =?utf-8?B?WXlvdi85Ryt1djV2N1V6QURsQXVCeDlyTUFSUHF6UFdad2htQTJSc0JUNnZ5?=
 =?utf-8?B?VG8xSmh6MDljVzF3Uk9Jbk1TcUhpL2dlbEpNcldrbXpUVWhsV0N6VjR5Snox?=
 =?utf-8?B?Y0NpNE9mSzhYZ1ZnWHJHZjBqenRYb1lZUmpUQ2dmMVMxMGNzSTVDdVFOMTNS?=
 =?utf-8?B?KzhneFBERE5QTnpYdFZHYnp1N0tpN0VIY1NJTUthRlBvUXhTOHJ0eVFwOU5D?=
 =?utf-8?B?TFlWVGdSY0thSndDc29BQjYxdFFmUWw0dml3Qzdkb0I5dXZFWjE0Ly9wNUZB?=
 =?utf-8?B?UFdlSFloait6cnRiMGVpOHoweUNRenNVODY1dHhaN2xhR1hTaWF0VDVDN2ZR?=
 =?utf-8?B?elluT0lCeHlZUnhka3RDMUQ3d2VYYXFvbVVzVXQwdkJ2WXU2eFM4K1BOcTdt?=
 =?utf-8?B?dmVKZE5wRWcvVFZvTHZRWGloOUhSRVAvbm14SGFMdXcwQmp3OFdESmdsZmRY?=
 =?utf-8?B?QzVmdFdYQ05vZmVOeXo2NWR1bTQwWG91WEhhTlVnZXdnbmFKU2Q1Q256OE5n?=
 =?utf-8?B?eUVSY2UzOC9vb2RIMEtiSUVzUnJrMjc4d2p5Q1AwaDgrb3JaT1JnV0xsUnZh?=
 =?utf-8?B?Mk54YVZUdzhjeXdsT1dTRlhndy9oYU5GWi85UTFCWitMOXNFSElPSjBPMlpr?=
 =?utf-8?B?VTJ2U2l0Q3h1QVI4MDQ0OEdNa3JYSm96SkJjb0JUQzJ5L01UR3NvVUV3Ymdu?=
 =?utf-8?B?eDBhK3REUC8vSkdoK0EwU0NqZ1VVUEdzY05OMVM2YUlvRlhlNkdydHJoUmRt?=
 =?utf-8?B?RW1HYVFRdE5rL1J6bUpNZjZyRlY4Y0dIMUExdnByVnd5ZlFwNW56YjhFMUlw?=
 =?utf-8?B?Z2pCZTFVcGsxRzdHejU0TkJyVnE5RWlEQWM0T2N2bGRxVDhLeXRLOG1Qd1Zs?=
 =?utf-8?B?Rng0dlgwYTYvUEsrM3JIa1kxWmV3dElLcDF3d3NIbUJkeFFaMkM5bHN5aEtT?=
 =?utf-8?B?U3FsNkRyc25wbWZMTWVnUDUyRU1YRm9PeUY5UlM5R0JJSHExYk1vMGJCcm44?=
 =?utf-8?B?VXNxeVZSLytxTk9UcHpHUWlHeTMrUTlwck11cTJVSWJ3dTIxNHdzNitkM09Y?=
 =?utf-8?B?T2VzMXdGczZXUG45VjVQb2RIZjc2WDRoUTV0b0c4dHg0dkdzb2ZvUXljcU5K?=
 =?utf-8?B?VWM1Y1J4cCtrM1U4U0lraHoxc0QzejR2SDNhOWQ0enJjYk56RDhlcUtJYU1h?=
 =?utf-8?B?d0tvQzdvYXRnbGtjVWlvdFZoMkdpN3lGWjFqQ08xcVBxSjN5RzdyU3ZKb3cv?=
 =?utf-8?Q?0BFN7g7pNZM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGsvODcxREZUdTltVjJ2N2YzSXk2LzVkamRFRDAyUVBRUnhUaEt5RTJHUHZl?=
 =?utf-8?B?NTY0dkplVy93NkFMWlJUd2RuY3RRNFRLWGRBdWp6RFR4Y1Nvckt2dzRxcERw?=
 =?utf-8?B?em93MUc3RXdQcHI5ZFF6SkREcWNxQUZFeTJleWI5bzVkK0UzcnMxOHErdURV?=
 =?utf-8?B?NnI4YXZwSWdsREpOWXhxRnJDNFhrdGUwdlpJTk1uWFR4Sk00SERUenFuTGgv?=
 =?utf-8?B?UDRnTWZJTnN1T1g0cDZOdmNzMW8xaUdaa1hBODgrYTRHRG50TTc5Zk1VZVJt?=
 =?utf-8?B?QWp5cHIyMUk2aGp6aHlMYU9ZcTc3NkxNZWc0eTcvN0hPbkQrY050eHlnOGNo?=
 =?utf-8?B?SW9Ga3pKZEFYcURIaS9zUnJhSFZjbnE1aXMxMForcXFHdlUwRDlwVU1nWTNY?=
 =?utf-8?B?VzQ5Mnk2ckRmRkdqWFZidkdTN0VwcDdaN2JFQ1dnZXZ0TW5OdUlBOTFvZUhx?=
 =?utf-8?B?VWNpSERic0JjY3RHWFZ3ajZZZWpwN2pXd0FXRCswTWlVWmZuNk90ZWdpWndS?=
 =?utf-8?B?ZTA1UnY2bjR4YTFmUFRoRnhEOWZ3YUJLSGFoZnRVTkVsQ0JvTjVwaGZzVysr?=
 =?utf-8?B?KzVvcHRvQTlWZWcyVWpSVzFNUmZ3TW5RdDlyb2tTbm5PU1l1dFVRemJqMjE2?=
 =?utf-8?B?dkxEU3pmeG10Vm5YZjBBUDFpSnJ0NmRrSXBreWM4d1JuN0M0V1VvNXIycGU0?=
 =?utf-8?B?eksrQkxQL3Y5VjE2d1pONlNSbDZUdGlDZWR3a1NnNUFwVUpBSEd5SVpoQ1I2?=
 =?utf-8?B?eG9FRFA4d0pFUmNkUnA0VlNVUEJsbEpsNzNWNGRlSDJpWWw4UFd6eFNpM0VZ?=
 =?utf-8?B?K01NV1U2MWIzVVVmUDROWUZVUGVTQytlMUFYYTJUSGd0aHkyWjlzcXlQVlpK?=
 =?utf-8?B?aWpYRU9lNk83QjZIY3RsU2lQTDA0ekFBUmJoT1hEcFZCYXF4ZUpPZzVQNVZV?=
 =?utf-8?B?cEFIcUFrcGpLZnJXTmpjNWJWYVdoZEk0bmVyUXhWb3REcUt3ZHNTa25HcE1l?=
 =?utf-8?B?RFVTbDFWM0VrYkgvald2NkJtVVZxUStUR0YzYUJkNjhwZXVFUkRDRjB3dlZD?=
 =?utf-8?B?eklkWHBYYnJGVFY1YjIwZDRqOUFoVjlrQUhrMlA2MG5HeStqZUh3VllYaEk2?=
 =?utf-8?B?YW9YN2hIYzJrS215OEpOQ25idDlwdGhQaDc2VGluUmFQL0xXTnNSK1pQRVd1?=
 =?utf-8?B?cktHY0NOd3AzazExSVZ1UEJSeE93QU1XRjVucHUrdTBRR3RaRS9pQUdGWkdr?=
 =?utf-8?B?OXF2bDVueGx4WFB2Q2VJdjBZbTk2SHBBQURudFZSSFlBemRyOEdUaDBjZWJ2?=
 =?utf-8?B?eE1kMDZlTkNjdFIzWTJWZ3VDNWtJcXFsem15ZXZMN1BGK1JCd0JTbC9kNTZ0?=
 =?utf-8?B?eXRZTmpnUmVQVXFOSVdiYm1sd0FVMUlqeFZ5TUtUNFBtaUJkTVFWR3FGV2RJ?=
 =?utf-8?B?VU0vOUVFRkh1dWwrWlpmUStxRDNwRXdlTE1UdXg4T3JXbmVZTG83aDZGV09l?=
 =?utf-8?B?MW9VQjU0Ly9jRXFlbk1nR1RXenVaL1UwRDR3d1UxajIxdk1yWlM1UnFxM0ZZ?=
 =?utf-8?B?UlBoWWpRZXFNMXRiT00wUDQ3MWpNWlgzL1JnTHJBNE1vVG81cytDMWJ4dTUz?=
 =?utf-8?B?bjBnTHFwY3JoVW9EcHQ5cW5CLzRSVE9Nd3Jxa2lqY2tkQ3NIMENkZi81dnNM?=
 =?utf-8?B?UzdsVUJ3SzFtZzNzOS9OQlZpL003Rkl6Ti9IT0xFWm5WVm9VQXVLVmIvTVpD?=
 =?utf-8?B?bENhODVwK3lEOUdnVVpMeExrL2x4K0FyZ1FzYmZjbHhNVStjb1paYWhzUEdQ?=
 =?utf-8?B?WnM0NnFTeDV1NW9tQXdnYVMvdUxRYWZ2ZGYwVG96a1diZVNQdG9PYXhqS09k?=
 =?utf-8?B?MlZmTktNMUVxOVBGcmpQL3RuYXRPMUhHNzBFU25lSnRLSEFsNjlkakhHSmpr?=
 =?utf-8?B?WVV3UFNTQkthdGxlZVZicStoWFk1NnRwTWErSTZEMWlmVGk3dk04TitYWEdD?=
 =?utf-8?B?Ym56SWlUbWVhMnBUVDMydWJDdU9DYVlMQkxVcDZzMTVQNmxMY1NTeEZCcExV?=
 =?utf-8?B?ZWNHUTE4ZkhreDBxcTVCTElsL0JMV3ZiYSs5dFhHeXJmMk43T2RzMFR6bHpi?=
 =?utf-8?Q?mjdLN2EigWN6yKOc0N5G4ncBn?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7cf49e6-1685-4db3-643d-08ddb261fb8c
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:26:46.1053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLuCGvnQkRSE0E+eK7LT9vzQMYl4JcTjpxTBVXwmPDbqL3VsQdh0EwTuDhZTFeYPbEoxc/IiAKK7D6YvwRjN6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5482
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

a good first step is to run lttng-session with `-vvv --verbose-consumer` 
and inspect the log file and `LTTNG_UST_DEBUG=1` in the environment.

It may also be useful to run your traced applications with 
`LTTNG_UST_DEBUG=1` set in the environment.

Do you have steps that reproduce the issue? E.g., all the commands to 
set up the tracing session and so forth.

thanks,
kienan

On 6/19/25 10:58 AM, Georg Muck via lttng-dev wrote:
> Hey,
> 
> I am using the LTTng tracer (2.13.11, C-API, rotation=1s) to trace my ROS2
> system (userspace only). Everything works just fine within my Docker
> Container (Ubuntu 24.04), but if I start the same procedure on the host
> itself (also Ubuntu 24.04), it does not create a TraceFile if to many
> tracepoints occur (speaking of roundabout 1500+ per second) (sometimes it
> malformed the tracefile, but I was not able to recreate that. If I remember
> correctly, Babeltrace2 threw an error that said that there was no
> metadata-file). I played around with some configurations (like increasing
> the buffer size from ~16kB to ~512kB or a less aggressive rotation), but
> the problem stayed.
> 
> Would be thankful for help. I guess I delivered to less information, please
> reach out what is interesting at this point, I am not sure about that :).
> 
> Best regards,
> Georg
> 
> 
> 
> Never burn the bridges before you
> If you've burned the bridges behind
> Never burn the one that you're walking upon
> Or you're sure to hit the water in time. *(Savatage, Streets, 1991)*
> 

