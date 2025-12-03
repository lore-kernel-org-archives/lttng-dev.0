Return-Path: <bounce+b7b410.602323-lttng-dev=archiver.kernel.org@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from m43-10.mailgun.net (m43-10.mailgun.net [69.72.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C464ED12691
	for <lttng-dev@archiver.kernel.org>; Wed,  3 Dec 2025 09:58:31 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=lists.lttng.org; q=dns/txt; s=mx; t=1764755910; x=1764763110;
 h=Sender: Sender: Reply-To: From: From: List-Subscribe: List-Help: List-Post: List-Archive: List-Unsubscribe: List-Id: MIME-Version: Content-Transfer-Encoding: Content-ID: Content-Type: In-Reply-To: References: Message-ID: Date: Subject: Subject: CC: To: To;
 bh=+v433r3zh1jVOUlWQKc/L35/IGtGirAPRZfv1an4Upg=;
 b=CDHLpRNkwgze5c1aNIEV1XdF9Ohc9N0wM59NGXH0aZx3/LsppQxJdLDZ8o44t07psLhue7t9DCdC/xEVRaGrqtLH3h6IIdGZz3Hw3M7F2WX09hv49w4LtjjMIKhQlXzGcmRwxGcbpQKsI35HDPoUGa0GKsHtqTbQ8vEXgtLVGbZ3mQgSPg+QEmFQHcyaDXSj65usaRKzDpZC/17EbMVol5W+GmFg2Jq5bKuOFDTkIBFINhYmyrOAwTbiZJ8MaW6mnnWdI815eTOJSuP+b5xInF59raeas9sjH6BznpTH0Z5jqLrtTCZiYhP9AXY3pMMQGcWFwOOptxuVumgRoQN6ng==
X-Mailgun-Sid: WyJlYzgxZCIsImx0dG5nLWRldkBhcmNoaXZlci5rZXJuZWwub3JnIiwiNjAyMzIzIl0=
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29]) by
 132f431f4c8e9587dccf8c53258228023a2131a88151b390cf253b9b09a0abdf with SMTP id
 693009c6daf495524b3d5ffd (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Wed, 03 Dec 2025 09:58:30 GMT
X-Mailgun-Sending-Ip: 69.72.43.10
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dLtPc59g5z1xFD
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1764755910;
	b=MeJTRnG9ube0sDFnTtHcwUhcQY4N+5t+A9xKl2r2osEzzUKy2I4rWEwUxiL/0VwyGPug
	 ScTTfasjePXechW/c3bOtGXIzFndabl+EtdLhZvsrT01L9mIRWtziVPnn+sp0f9zboLh4
	 s1maXthvHVcuG0H1klEqTJSAzWnoPzOy6LLrzJ6XorrmqoiTOBWR8nRuZdnQ1hv4rfeyQ
	 Qjj2TI4zpyTTqIBaiaQ3f/5DgZlAyJ/UL7OxodFyLHvdbZiNMNanDvb0Q+La61S1BsPnV
	 jxxZ5d6mazIsU9IRtlEfujN72xKalhYVyB2rObRTbm7SjNeEepGWOMxAcyxfu1jo95Q==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1764755910;
	h=DKIM-Signature:To:Subject:Date:Message-ID:MIME-Version:From:From;
	bh=+v433r3zh1jVOUlWQKc/L35/IGtGirAPRZfv1an4Upg=;
	b=lQobssAeca6Y+IyKmwKd5AeqGa3w7uUra9Dzd+XgQJ2gB5f9GetN0Sz3MiphsoQHmvOi
	 GkSpTbYPedqRhNazSUI2KrMaNDsmd0TGXYRJOX1lwf3JUVbkGn+97BX1MXGVB6bLwzKJz
	 M2Sbb2Va9iSvGph+5yrbchacfhhUTkoNyyfyT5WuC1bCxOwEFXh87TOGKb6mUN8kuHpyY
	 Dnj9Waz+9mbUng1XpUDbPIIRbS8r83Cmp3Nmf0XFSWjYYo8vMSE3UaejAE06oaNU619MQ
	 SMxpj9kIjWOhvI60U9N9sRP2T5rvjL/FdCAZKYsopdvX+jYtSLijzFOKk9e6tAc0Q3Q==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dLtPc59g5z1xFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1764755910;
	bh=+v433r3zh1jVOUlWQKc/L35/IGtGirAPRZfv1an4Upg=;
	h=To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ET6wQvwg6NR1fYIP0GwZjCktCsYRCo82Sbc8jWcqmL1VZUG68wLpLec1vPiWTLMpC
	 emw8/yxJM9ulhxfCz2hzu1URLwBU3gdihBYYoXIbfvJo0wWJws3H8eF955v8suqlXE
	 7iYPI6PyBFDvsMQVFwNXVUMho70TYRfrERD00p20XubSELmhAICm5YjS/DRXIUl3bR
	 1E+Z+3u7/dqQpSbB+t81cOiUCErPOVjXfy4oGAPR7ixKKSEDzNUXMZV4lDMnWu9Qjc
	 nAoPC7Qo7fI4teQCtIUrXTzoZYuV7iKAFkFV2Cgwwchp6XB9olhM5aGfeA+s0M6Vue
	 oY/RaW3bZyjcA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4dLtPc59g5z1xFD;
	Wed,  3 Dec 2025 04:58:28 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dLtPb10kyz1x3w
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dLtPb10kyz1x3w
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
 by lists.lttng.org (Postfix) with ESMTPS id 4dLtPb10kyz1x3w
 for <lttng-dev@lists.lttng.org>; Wed,  3 Dec 2025 04:58:26 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPCRHedq8e/NYBh0ZILBPtFlow6VFjuMyyRZbYfMvAikMxZThipfvpD6nwk/aCBtT+JZ9PeVxDBHHNGrY/ElfD8u7Ffn+Avb/ovZWWV9FENhL2yG3D6p9RQXaU7yAhFWLhP+4T8ruubIGcTFeyhisUAQfoQG+Ht9fLbk7Eu+ulEDLTRKvnT5pg7x2R+I56SNdrlQUBkyR327MOCSoiIqqwWUvVBnai47MbNftU/W312tQZ24qrfPDv+kVttLTP6EudnQJaQ6f/jbdHiz2jw9iN7YnfYeuIuZAIUi9IJ/zE97cAVIIGSeW7M4zln6RBXCZFJS0JjFVuYvTEULu9cJ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+v433r3zh1jVOUlWQKc/L35/IGtGirAPRZfv1an4Upg=;
 b=SVT2asJSIZqoMxEiWdSr9snjuxVkgrTej/B1h9k6k+wm2lSVjtmOAo+Oz85E+0FJTgSbhcacvI90NUn0sigdele3m11yyfC96oTX2maI17Ka+uyEC2I9wYr7arGUz/LPGEY45ssUPM4J4kqbnX1c5cDRj1f+YIoahGCHqLP1w07nIIcmH1onxiKPbRdpexLMDxHip1PHbn03NYqsKFTQYk76DM0VPZzx6FNiX6UEGpmQmAndAKEkKXiMlXIwESrUJXVtp+5BKDCl/y67KFl8ea4gF6Cn/wgEoMM5bNJpiDTP6cRsjcX908k9MjMO5tppJeVWUfWvIJf8oXufJbfihA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by AS2PR10MB6750.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f1::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 09:58:23 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 09:58:22 +0000
To: "eeppeliteloop@gmail.com" <eeppeliteloop@gmail.com>
CC: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Subject: Re: babeltrace | sink.ctf.fs: add support to create LTTng index
Thread-Topic: babeltrace | sink.ctf.fs: add support to create LTTng index
Thread-Index: AQHcYqWtcyrB96cmi0G5chrH4BvgJ7UM2vEAgALWd4A=
Date: Wed, 3 Dec 2025 09:58:22 +0000
Message-ID: <3140f317060df66442077e0be78104695c873aca.camel@siemens.com>
References: <cd2f473df84132beca2d926819e15de514e10589.camel@siemens.com>
 <CAB4xu_0SBjk5xKXt_Q5gYWDC+iHg=oi08MyGyFhcBvvVmoAfvQ@mail.gmail.com>
In-Reply-To: <CAB4xu_0SBjk5xKXt_Q5gYWDC+iHg=oi08MyGyFhcBvvVmoAfvQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-7 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|AS2PR10MB6750:EE_
x-ms-office365-filtering-correlation-id: 275ba3af-ed5d-470e-3ea6-08de32527e7d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VVg0R2pwa0ZETkRiUjZkUTJiUnlsNlhSdGE1bHdFWW1oR1VGTWlxeDNoeFFT?=
 =?utf-8?B?bDhlR0hLUlN0d2UxNmNaT0FYQTcvODduclRoYUg3VU4wbGlSMGxkSHc4SWg1?=
 =?utf-8?B?cDZsYUs5ZXVVUTZkQ2JJU0FLVFQ1SWhkaTBia1o1RHhKYzNXRHZla2hOck5H?=
 =?utf-8?B?cHRmd2lOUkJrUmJwSlFlZnpNQjJERjB5UWl1VVpqTDdDdjJpTHBxNi9VVGJD?=
 =?utf-8?B?OFdjY01obG1xSmpvSnp0QzVzMDVkOUpiN3JXZTZPeFlYbzJuMUtxalNraUJu?=
 =?utf-8?B?a3YzK3YvUWNGcTJYUGpWWHh0bU1qSnFIOHpGZXBLcjZmVVdYcjd5UFF3dTRX?=
 =?utf-8?B?SDZ4bWU2bkZVcG9scGR3T1Zvc1FYSC94RXJaakNCRU90aXl3RmhlU0JGRE5x?=
 =?utf-8?B?NEg4emNwVFdjMW5JQXpSSUFNS0tyOVJiUk1kTVBCejVxWTBiR0hnN2R5eXNi?=
 =?utf-8?B?dnZtMm9Wc1pCOHMxMFhWVk5WVGRDZXVJVmZXMkg2TWVnRi9tYjZCR3EvSUJT?=
 =?utf-8?B?bTVJOWdoenZIc2dEV3ZqZHh4b1RJU3pVZUxINXhuMVJzMVdFMkdWbDZNUk54?=
 =?utf-8?B?eGYvRGtXa3VORjgvaFhBVk5jQmRhWlpFeGdMTk1Db0F1SXRLTHBHc29kOU14?=
 =?utf-8?B?cngvNlh5SE9FMWFzSUQ3Qlo4TUR1bEhTU2d5Z1UwWlZPV2RpY0pDZ1VFWmJU?=
 =?utf-8?B?QU5hcmk2UGVHKy8vRjJUSjh3RW9tbTdDUTFtQWh6ZFJsZzdPQjNrWkhDQS9J?=
 =?utf-8?B?TlNTenowdGI4SGFxcVZpd0ZpRDY4OGxRY0JVVnhpN3ZjMmRZUEhJcHJQUVhi?=
 =?utf-8?B?S2ZhNDlzaDNCS0dFb0lMMGZUaGpwOXV1TnltK1c3WG1pVmFwSzEyTm1tRkV1?=
 =?utf-8?B?czJ6bUs3TGcrZ0JOOGZzMGllUnlTVWFxWmlxNHBkKzl4SWx2em1xQkZYMnhp?=
 =?utf-8?B?VjJvRWNyKzhwSDRVQkFjNXIzalM0NENEa2dJdmhsSEFISVVUWUhlWHY4bkRW?=
 =?utf-8?B?TzVaNnNjak1lYUxicUQzSDYrbytUTjArd01UR2ZvNDU2LysxWGNTL1VsTTk5?=
 =?utf-8?B?QzRUU2YwOUlCVDU5ek1iWTNZRlc2V0JSRnhnKzBkVDVnRXNpVXl1V2hMUXZo?=
 =?utf-8?B?cFNmVHVIT2JXTDJhVUJVa2VMbXZBSkFrZGZZM3FTSnJzS0RrMlp0QjVWRGZl?=
 =?utf-8?B?VnQxSEpPejFza2lFWFZBVGhuS3ErQUNqMmRQTjR1TEN2a2JwcEJzVUJlKzJF?=
 =?utf-8?B?cUpaalplanJyNUV3RmdlZ1k0SjV0K05GSVYwMm9VeExtV2hOM0JBdnMzNUJa?=
 =?utf-8?B?OW1sWnAxTUpUZ3ZMZldyclRlSGJpbG5DLzlLRG9IOVZFcm9JRFFQWVVycUVI?=
 =?utf-8?B?dFR4Q0RCN1Q4TVpRR0hLemUrTzNXQ0lwVVkyQjYvQ0thaWZteDhYSzRNWGdi?=
 =?utf-8?B?ck9DQ28ra1lLKzJlcFhkRi9PRm1UTkEram9qKzFtNFNaZ2U4blFBQ1VrWDFE?=
 =?utf-8?B?R1BuYyt1VnRpZ1gzMkFYOTRKZ0RqbmN3dXY4Z3BYaDlwR1IreGUxRExRY1Ex?=
 =?utf-8?B?c3VIeFppZ3hSN29zQWROWkJRNW1xRWcyTjZTMHlGb2JqRS90V0Vjd2t4WmdU?=
 =?utf-8?B?bkpHN2ZSby9hSWdYSXJENGJaakRsY2xiZTJJQUgzbGZTOVlQcEV1Y0Q0Ynhz?=
 =?utf-8?B?ZWdTcmc2dmxFaW9hSXNmV1dGOGZHQm9adzl1M1orSWNabFNCckNuRVZQdG1F?=
 =?utf-8?B?SlRUM0ZMVjl6R29kTHUxOFBIWDlKQTR5RjhPam9ydjRPMEptUWdIekUyenc1?=
 =?utf-8?B?YkQ0ZDJGbCswUzZIK2gyZ0ltSS9kcmhtQ1AyeW5WT1VkZUNxWXpFM3BDbE5h?=
 =?utf-8?B?OGUyZXdQM1VvZTRVZmxQMndSQTlPTU5JYmx5ZDNhSnYvVTdaeWJqOUhaVjl1?=
 =?utf-8?Q?At/RxsnlSj1ZeYZ+P9nKUWn+Wk7epUAj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWhpck8yakJkR3ZBR1dPQW9DVDJJTVJtT2tSdUpZbzZBd3I5TWdDbDdZREhK?=
 =?utf-8?B?M1daanpNa013OUdJeGhXUWdXN1p4ajFPWlZMa0pPODI3RUZmVnNuNDMzVE45?=
 =?utf-8?B?aUd3QUZoUjhURDFnT1dxekgrTWZpa0RNUlQ3Z1dOUHZZVXpLeUw4M3FuOVVS?=
 =?utf-8?B?TFQxZkhCNUJhM21TTmF2VEdIdFU5WU82Z2w0RDZQckZLYVJFUkdVN0c3RHBL?=
 =?utf-8?B?QmQ4TEFzbUJ3N29NTDh4ZDdaZzU3YUthTW9hamg5OFhuazJuTklBQ1l1UkY2?=
 =?utf-8?B?WURtVmZ5aEkyVmtDMXJSSDdMaHVESndPYisrc2w4SEFEZG9PQjFWOEQrTU9C?=
 =?utf-8?B?bEtZclpyNkVEUlVtc25yaDk4TXZlSlR1anBZUUtCcjJDOTJMdlovYVhzQldP?=
 =?utf-8?B?UEVNTFhkYmJ2ZVlOR3REVFpEU0FCWllZbXRXcFBXMW1UWFJPbWhyZW1uTlU4?=
 =?utf-8?B?SWFLUlA1bXhzK3pna1R3MitGNjhKRksxUktUaDlEVUd6eUZ2Q0xMMGZJbVRi?=
 =?utf-8?B?TTZIRjAvcTdCSHUzVHl0VVRJdWtWSi9IQWxVNXYzRmlFbnFheVYyMVU2aEJx?=
 =?utf-8?B?cHFoRTFqNytRM3gwM201K1JCNzBYajIyUklORXM2cXIxVEdwak8rNk8yazEx?=
 =?utf-8?B?KzFSQ1ROcFpRNUowRjAxdVM2UlZlVXZobVR0WjZOeDRkdmpOdFZHZDY2Y3NI?=
 =?utf-8?B?bVl1a2hwL2ZmeEQ0UldWWHBVUkNaSDRpQ1N2MkFnZUdsWDRxaEpsa3dtVDhw?=
 =?utf-8?B?S1dUTHZNM21CSTNWZTVqQ0xUbmdBRC9WQk1PUWdTVSswMitVUGEzZXY3YkJx?=
 =?utf-8?B?VmY5MXBHVEw4b3pLaE11MEpyVFFhL3ZGUzMvWS9DVWpUdWsrZFlqamVmTzI4?=
 =?utf-8?B?T3cvQm5xeWpXekhvWm41L1JXTXFQUlJ3K3JxSUx3Q1o3T09zR3ZYMkpjUFh6?=
 =?utf-8?B?VzVOK1pDSU4xQzMrV0NuVWxHdW52ajNVNjNqZlRxMjk5NlBkdGZ0KzhTalZR?=
 =?utf-8?B?NGoxdC93VHllVTkraTcxN2Q1R3g2QXJFZUZKWnBhSUx2V1hkQW8wZTgyNGNO?=
 =?utf-8?B?QVJHNVZwa1VzN0dZc01qakJVSFJ4VWJoeDBaeldLZGhpYzF4YWRuQkJiTlRY?=
 =?utf-8?B?MTl5RjliSklSd3pvcGx6NDRUQzZVYmxnRi94bC9CYk1Gb2FieEpPWURjV1hv?=
 =?utf-8?B?cjF0ZTBpdEJUbHAyVXVqVFp0Vi9oZDIzRjRnR0Z2cEdLN0JBb2xWbjVtMVV4?=
 =?utf-8?B?ZzE5Q096U2oxS0RnUHhoSTg3cE9MeHJoQWxJTDVMWWlqZU00RWRnTi9KTzlC?=
 =?utf-8?B?aEl0OHVtTXdSUVlJeTFZbmU1dUgzYVp0cHZxVU9obUt5M3oyL2piWE5MT2Qx?=
 =?utf-8?B?QnY5RExnWGtlL0pCT2V0T21YMFRNWUdleTZIL1RmRVhlclRvWGxFQ0RhdlNr?=
 =?utf-8?B?QVVkUjE1Y1pCNGlKU3RKMTE2UFBNeHovTkVFcVdRSTl6cFJDamxUOUxScHd0?=
 =?utf-8?B?ZGQ4QTJlanFnODhHZVNoT3JYQ0xFeVhsTGljZlZwVkNabStSd0ZkYWJ2MlV0?=
 =?utf-8?B?RHkwa29xd0xDeFFDY2ZRd2xIZXZRc0Vld0QyamZUR3NpQjIwcDNmakd2eksy?=
 =?utf-8?B?OGxaSEhkcUdlV3RuVGlreUFXWHJXc2VNOTlCTEYxMFMwQkxXbzBsVGZTeUxW?=
 =?utf-8?B?R1pIZmpWME9mWDQwZGhaTmwxWE5TRUp3QlN4TzA5eE9zaG50MDZsS1BBQzhF?=
 =?utf-8?B?alVkWkNGVkNGQm5vVDBhMVlMS1BjaDRnd3dDSXUwVWdycWtjWFFXa0xVVlF0?=
 =?utf-8?B?cGQxWndUQmt6TjFhbHpPamtzeXdwbm1IanVQdXRseWxBU2t4TWxEK3U2clNM?=
 =?utf-8?B?S0xXYlovY3lnWW5VbHVyV2pjM2RPZk9salNsSzdScGJpektGdFV1VlZUYUFY?=
 =?utf-8?B?TEZ5azRPcFhIbEtyMlpxRlJKUGhueHdEbGxRUnc2cVlpK1c0QnlvaHpCMUNl?=
 =?utf-8?B?QlozeEJIa0NEQzNCMzc1Zmk3b25vaWErRWtmT2s4WkRmMWNqdzh1S1NlR1p0?=
 =?utf-8?B?UzV4MCtHZ01qcXdwM093UGQ3M3AxUmZQN0liZlQ5clZTbGFzNTV5R3AvbW9x?=
 =?utf-8?B?UERSVURzUSs5N2JXVzlsdnE4NmNJV05JZkYrc0lqTkdaZE9YcURndEhwR0VX?=
 =?utf-8?Q?f/GRyRTzBicgGLYpNa9q4mc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65F9497BDCD57E459BA2FCF8DB305F36@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 275ba3af-ed5d-470e-3ea6-08de32527e7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2025 09:58:22.3502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KbNtNXFVxOfQtedMH+DuH5QpkEi3xyP8GL/T34lNGNUJJVl3V+cg4C/9wSjXp+Luh9n9PT05NpqzAm8y3EBZeo0V3hSMXxuv0J1WsEYKW5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6750
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
From: "MOESSBAUER, Felix via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gTW9uLCAyMDI1LTEyLTAxIGF0IDA5OjM4IC0wNTAwLCBQaGlsaXBwZSBQcm91bHggd3JvdGU6
DQo+IE9uIE1vbiwgRGVjIDEsIDIwMjUgYXQgNDozNOKAr0FNIE1PRVNTQkFVRVIsIEZlbGl4IHZp
YSBsdHRuZy1kZXYNCj4gPGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmc+IHdyb3RlOg0KPiA+IA0K
PiA+IEhpLA0KPiA+IA0KPiA+IEkgcmVjZW50bHkgY3JlYXRlZCBhIGJhYmVsdHJhY2UgcHVsbCBy
ZXF1ZXN0IHRoYXQgYWRkcyBzdXBwb3J0IHRvDQo+ID4gY3JlYXRlIGFuIENURiBMVFRuZyBpbmRl
eCBmaWxlIGFsb25nIHRoZSBDVEYgZmlsZXMgWzFdLg0KPiA+IA0KPiA+IEl0IHdvdWxkIGJlIGdy
ZWF0LCBpZiBzb21lb25lIGNvdWxkIHJldmlldyBpdC4NCj4gDQo+IFRoYW5rIHlvdSBmb3IgeW91
ciBwdWxsIHJlcXVlc3RzLg0KPiANCj4gSSdsbCBuZWVkIHRvIGxvb2sgYXQgdGhpcyBpbiBkZXRh
aWwsIGJ1dCBJJ20gbm90IGFnYWluc3QgdGhlIGlkZWEsDQo+IGVzcGVjaWFsbHkgaWYgaXQncyBn
dWFyZGVkIGJlaGluZCBhIG5vLWJ5LWRlZmF1bHQNCj4gaW5pdGlhbGl6YXRpb24gcGFyYW1ldGVy
Lg0KDQpUaGF0J3MgaG93IEkgaW1wbGVtZW50ZWQgaXQuDQoNCj4gDQo+IFRoYXQgYmVpbmcgc2Fp
ZDoNCj4gDQo+IOKAoiBXZSB3b24ndCByZXZpZXcgb24gR2l0SHViOiBwbGVhc2Ugc3VibWl0IHlv
dXIgY2hhbmdlIHRvIG91ciBHZXJyaXQNCj4gICBDb2RlIFJldmlldyBzeXN0ZW0gKDxodHRwczov
L3Jldmlldy5sdHRuZy5vcmcvPikuDQo+IA0KPiAgIEkga25vdyBpdCdzIGEgYml0IG1vcmUgaW5p
dGlhbCB3b3JrIG9uIHlvdXIgc2lkZSBpZiB5b3UncmUgbm90DQo+ICAgZmFtaWxpYXIgd2l0aCBH
ZXJyaXQsIGJ1dCB0aGUgcmV2aWV3IHByb2Nlc3Mgd2lsbCBiZSBtdWNoIGVhc2llci4NCj4gDQo+
ICAgU2VlIDxodHRwczovL3Jldmlldy5sdHRuZy5vcmcvRG9jdW1lbnRhdGlvbi91c2VyLXVwbG9h
ZC5odG1sPiB0byBsZWFybg0KPiAgIGhvdyB0byB1cGxvYWQgYSBjaGFuZ2UuDQoNCkl0IHdvdWxk
IGJlIGdyZWF0IHRvIGFkZCB0aGlzIG5vdGUgdG8gdGhlIGNvbnRyaWJ1dGluZyBndWlkZSBhcyB3
ZWxsLg0KDQo+IA0KPiAgIEZvciB0aGlzIHJlYXNvbiwgSSdsbCBjbG9zZSB0aGUgUFJzIGltbWVk
aWF0ZWx5Lg0KPiANCj4g4oCiIFlvdSdsbCBuZWVkIHRvIGFkZCBhIGZldyB0ZXN0cyB0byB2YWxp
ZGF0ZSB5b3VyIGZlYXR1cmUuDQoNClN1cmUuIEkgd2lsbCBhZGQgdGhlbSBhcyBJIG5vdyBrbm93
biB0aGF0IHRoZSBmZWF0dXJlIGluIGdlbmVyYWwgaXMNCndlbGwgcmVjZWl2ZWQgd2l0aGluIHRo
ZSBiYWJlbHRyYWNlIHByb2plY3QNCg0KPiANCj4g4oCiIEknbGwgZGVhbCB3aXRoIHRoZSBkb2N1
bWVudGF0aW9uIChtYW51YWwgcGFnZXMpIG15c2VsZi4NCg0KVGhhbmtzIQ0KDQo+IA0KPiDigKIg
R2l2ZW4gb3VyIGN1cnJlbnQgd29ya2xvYWQgYmVmb3JlIHRoZSBlbmQgb2YgdGhlIHllYXIsIEkn
bSBub3Qgc3VyZQ0KPiAgIEknbGwgYmUgYWJsZSB0byByZXZpZXcgdGhpcyBiZWZvcmUgMjAyNi4N
Cg0KTm8gcHJvYmxlbS4gRm9yIG1lIGl0IHdvdWxkIGJlIGdyZWF0LCBpZiB5b3UgY291bGQgYnJp
ZWZseSBjb21tZW50IGlmDQp0aGUgY2hvc2VuIGludGVyZmFjZSBpcyBPSyAoYm9vbGVhbiBpbnB1
dCBwYXJhbWV0ZXIgY2FsbGVkICJjcmVhdGUtDQpsdHRuZy1pbmRleCIpLiBCeSB0aGF0LCBJIGNh
biBjb250aW51ZSB0aGUgaW50ZWdyYXRpb24gaW4gYnQyLWZ0cmFjZS0NCnRvLWN0ZiBbMV0gYW5k
IG9uY2UgdGhlIGZlYXR1cmUgYmVjb21lcyBvZmZpY2lhbGx5IGF2YWlsYWJsZSBJIGRvbid0DQpu
ZWVkIHRvIGNoYW5nZSB0aGUgcGx1Z2luIGFnYWluLg0KDQpbMV0gaHR0cHM6Ly9naXRodWIuY29t
L3NpZW1lbnMvYnQyLWZ0cmFjZS10by1jdGYvcHVsbC8xMw0KDQpCZXN0IHJlZ2FyZHMsDQpGZWxp
eA0KDQoNCi0tIA0KU2llbWVucyBBRw0KTGludXggRXhwZXJ0IENlbnRlcg0KRnJpZWRyaWNoLUx1
ZHdpZy1CYXVlci1TdHIuIDMNCjg1NzQ4IEdhcmNoaW5nLCBHZXJtYW55DQoNCg==
