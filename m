Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D86E7717F
	for <lttng-dev@archiver.kernel.org>; Tue, 10 Dec 2024 16:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1733848903;
	bh=8ikyj34nG96pbfQMk76K/fB2yMReN6vSmYUrG7w96BA=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=AMCjIcMqL0QvtDK45W4BlFpL1OihnZBcBG5ysWPQVwjTXAVjhJu825qwmP16AaNDO
	 n9VvKeUKMHKkDtrg4jgoXXejf6pEXuDRyqWBa9IDhEOlhC1VNHjfNKqEeNBdf0wxNf
	 z3UjMWs2ZYy2L1JeV+jKzfyj7uWpORCGOOeP1ji0cdi+7EV3H/qYX71TxD/JbOls9l
	 tswtayrqjVZm6hOhmAAM03JgcehN1JmYisKTQsZamCYLWY+CGbJg3V/1Zkkn0Idj1d
	 O6mSSbCW/tbbHvbQimcGSSUNUT59ygDEeRhdl027Dm9S0Qn/WWh/PhFNC00jHSYftu
	 qjcc1ScaN6fCg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Y74J64Tzvz178v;
	Tue, 10 Dec 2024 11:41:42 -0500 (EST)
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c104::1])
 by lists.lttng.org (Postfix) with ESMTPS id 4Y74J46GQBz16tG
 for <lttng-dev@lists.lttng.org>; Tue, 10 Dec 2024 11:41:40 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkwXkpnDEqRx9BDOj59DPZUQIO1rNAcFPgd7lcM19b3BHykZQt4ySvbtL8ns2KDGwRe0TwttX/iZPPIehVeHGbERH//bSbKMojbszJi1tyc/+n/wcpNOe8cDsH3GeGeOwRDyVCxWpicYBU8CzvBEdZDx4EL7jjctN5NG7TJfOeNhD44CIf39Sx2VJmXH2ZPP3csKQKJJz0GDKeV41BMUU0AbYzFq04QQUyZLr3+rBqF4aiyc80yUw7AB93bIRA9FTXK7HUS+vaGgdc7nFWJNeXBU5pQIw7Zqu6vEup46e3wxfHERX/5DBIgypRWnOmYG5N1/KU5H5k2/s+dggzw4KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLo9wMAJkLcdys4lC9fRBxhgJcmCnyFej33zseKQZjY=;
 b=nAp0wJ/k4he0rpKxJwIloh7vLO22rNhHMyBYdpqAAKrc/YiCjraHbyNQ7cTqRQChTfxUkqSxbJ3xrMaXSISvzDSooVNZAJQoGXEbm5JdJxr7tb3kWEGEgwo0YuUYiHALh2G4sz7f3vsPVmeHhekPN34Dcptf9fp38bLnSwuH+/2ENbPZsyVSooLL1epizY6YLBoplWyxi9kDXu9pi6obzsMT1mBKvWjXsZ0lFUel83npKyR0jL0SbXTcEYA3+DHigH6roqbxX83se08bJJz4ZfB3eG0twOnxuWYp08svqwt6vXDWK/WHaYjZTNuzNSy1NJFbtKO92KZGI3ycUaPsmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT3PR01MB8135.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:7b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Tue, 10 Dec
 2024 16:41:39 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%6]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 16:41:38 +0000
Message-ID: <7f722802-752f-4cf5-ad2f-cb60264d8091@efficios.com>
Date: Tue, 10 Dec 2024 11:41:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [lttng-dev] Record stacktraces at userspace tracing domain
To: =?UTF-8?Q?Christophe_B=C3=A9dard?= <bedard.christophe@gmail.com>,
 Alexander Krabler <Alexander.Krabler@kuka.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <VI1PR01MB6845D1C81221547CEC94B3A782352@VI1PR01MB6845.eurprd01.prod.exchangelabs.com>
 <CAAS9dobC0wERGMQf9CLjhYY4ay_zSdAMAE9qxBezLtH-kL_1NQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAAS9dobC0wERGMQf9CLjhYY4ay_zSdAMAE9qxBezLtH-kL_1NQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::11) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT3PR01MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: 06cdb157-9db7-444c-433d-08dd19398476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2tWQythMWFFUHZYZ2ZsZnVmeDIxUGp2dUJaMmI3NzRPK2VHcC9XNlBoMWcr?=
 =?utf-8?B?ZGRwN3E1YlhhdzkveFpGb0pkT2t5aFJmRkE5WUlGZ0xtaDY2KzVCbWd2QjRJ?=
 =?utf-8?B?NmQ2K2twTkVLSHhSR3BiVCsvTjkvV3FnUTdPOC8zVVBBdHg4NjVYT2xuSzVZ?=
 =?utf-8?B?MXYxdzlqdEdQNTZwaVNOUk54eGE3Q2g5ODRBdVd5cmVjNGgyWXdpbExBRGlN?=
 =?utf-8?B?aHpCMkJjVUhNbUxSNTV1UHQ5bHJJbGloNTNuT1ZqWmVIOUdIeElvYXBKWG9L?=
 =?utf-8?B?QW52Mkh2R0wzb3hUWXRDVG9jbDFBNmRmN3Z1eDM0SGxRbm9ON3ovVVNpQ2xZ?=
 =?utf-8?B?dFI2MjIrb0VDU0NNWGtoclcrT1k3ZC9rMkw3bFZMN2FpajRQMFF0aFExWnFG?=
 =?utf-8?B?L01sUmxDNXRId29Xc0RXVXk5Z0Z4MllZL2FZY0tEN2VvVDlJdGRLR2R6TWFu?=
 =?utf-8?B?WEF6c1Z5cmRva2pHZ0FNbk1JOUlYbnZlZEJ6QnBSZ2NBTGFtcXhVd1VHMi9F?=
 =?utf-8?B?S1dxYlJHcFZUOVJCc3ZkTmNWKzZJWnFpTWhKa3VDYTg3YjF1UzJUaHZpNUli?=
 =?utf-8?B?ZTBtcG1ycW5wNUg0R3J4blg2NTBaSi9WZmtVOXZSUzZmUjdxVDZ1M0YyUDJq?=
 =?utf-8?B?Q2cvYVVoaDRRUWRSOTV5djVQalRCSDJySXZjMFRVcHo4YWFFa0Y4Wmd5V2xz?=
 =?utf-8?B?Mzg1RE9YeGZNdjRIVVYzYjVyUnM5QjlWcVJ3Y2J4cXBmZlhKeGFWNEJqQ3pK?=
 =?utf-8?B?aUx5NURNNkdXb2JkSElKaitYdGZFTHBhL3RUckRpZlZKcXdrck92RHMwb3Fs?=
 =?utf-8?B?c3hkSzZYYWVaTDBWVFZvVjhHaTNtOFQwZ1drZDVjbHZtbFo3TDRFTEkrdWlw?=
 =?utf-8?B?QlptLzZRVC9vdzZTaUV2UjQ4dWE4dGVuWGlRdXBGSXJBdVdJeGpFUTBOMkxu?=
 =?utf-8?B?TUhGd20zTUJuL2JWczVEUlRxT0gzYk44SlR4UFJCa3p3WHJ3RzJlZVptYWcy?=
 =?utf-8?B?K3JRc0RQbngwR29za3M4YVozdksyWGhjNyt4dnhuRzJhMDNNeENaUzNrVnNk?=
 =?utf-8?B?Y0g4V050QmFsTXltZ0VqeGZiTGREanBSekNjZHRlNDVVbVptc3lyUUY5NkVi?=
 =?utf-8?B?N2NiSE8zNlRHUkI1WFJhRXN4Qk4wVWtFZHRNaWtFc08zTWI2T1J4eENGZnlJ?=
 =?utf-8?B?b0gvRCs5bWNhbzBoRHZjMHpCZUs3bE55RVRwQTNJeGp6eVUxRlJ4dXp4QW5F?=
 =?utf-8?B?VXNhbmxSY05yVEFPWE9mKytZQmlGVC9VRnFTRUhkaXhsWWRSUWZMMmhhWE1P?=
 =?utf-8?B?OHNSUm9aU2RQS1FoL2ZXcFdlRlUwUmd4ZnIwR1VINFBzSHlHc2pEMzI3Y1pW?=
 =?utf-8?B?YVpwalZoZUhuRW11akhuZmxYSmNlUHdGVDJIWktnbk84WDMweHJCVlJSek1O?=
 =?utf-8?B?cUNYR0NYcDhrankrcThjeWxQdnFiamlsY3JueUhyVjA5bENQQWZWUmJHa0NG?=
 =?utf-8?B?c1NzMUtjaU1mUzNleEhaZW9qZGR2NTlRTGs2YVV0Z3p0QUVsbFdDbFoyTi92?=
 =?utf-8?B?bFVhSzY3KytkczZUNmllVEk3NE1Tb2RNZUljeFRXcm1hQjdBYTBnMm5KUEhD?=
 =?utf-8?B?aTNqblk4WVlxOGJQUS93MGxFU2x2MmU1YWdEcDU3aWtXYWlody9UN1M2bHAz?=
 =?utf-8?B?bWtsdkNOL0c3dGdDZGVDQzFSTEJVVW92aVFLYnpLa1JEOWFEbzZ6d3B0RGVz?=
 =?utf-8?Q?xG+WZQte+FstymFXmw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUpxYmh6cklGbjhQZTdPamxQa2JwSGwwSXdmWGRTa1owVERSWUV0bzg4ME8w?=
 =?utf-8?B?dzVLZERZdnBMN2xldTRoa0dlbWtkaTJSZ0pEbzJ6aXQ1b0VpeVJmK3FwOHlO?=
 =?utf-8?B?cU1uQkRuajZzTkVSMmhkejhHcXlyL2VWaXlBQ2JKRFROU2tzNGNvbXYvRjlI?=
 =?utf-8?B?UGxMN3hwTnBFWGRQdXROcFRDb2dpWHJIejREUjVUQ2dJeTZkUkErN3crazYr?=
 =?utf-8?B?RWMwSUVobjAyb1Zvejh2Z21NcXRKc2RsZ2V6d3NiOERuY0RFMlgvdmJRMWVr?=
 =?utf-8?B?d082NHpobVhJcVMxWStxM2ZXbWw3QVJyWW51ektxSmNhSnNoNWdoV2JKR0NP?=
 =?utf-8?B?Wkp3Z2F5dHFHcXdxNkZGeFNtNndOT293WGFsbHJUb1RzQVNZRS8rRjFDcGRC?=
 =?utf-8?B?ZXdjZS9BZm5obzdWdTFLYmhzcXc5Wi9TV0I1Z2ROMmRNZWZVc1V4QTZiV21J?=
 =?utf-8?B?Y2p3QjB2ZnUwK0JFRmR0NXQwTzJ4K1JZbTB3R2NYRnUxVFNoMVREV2tyRWV6?=
 =?utf-8?B?UEI2c2cxdWFjZUVBYWJOanEvR2k2b20rekZmMzVqT3ZXOUVkVWozbGhIckVo?=
 =?utf-8?B?U1RvY1JQRGlCc09mMmNBblk4YkM5czBJK0lER1dnWDlZQ29vMkVNbzl0cTVM?=
 =?utf-8?B?dGtMR0Rya2o0cTFQeEZUdXZUVS95ckNnMGNsdVloeUhyK0haQzg1Qll5eERG?=
 =?utf-8?B?RDlXT0tPVElGcEt6dDVVTkJHL1FWdDRjMHdZOEgzQXBxVjBJdlBwMmJNQVNE?=
 =?utf-8?B?N2QxQTZEb0p3T3NhYm9PUHpmcGRPL0VBQ3FLYmgwYlA1czF5akJpMzlOWjdP?=
 =?utf-8?B?Y3ZDVEpmWVFMR0VNRkNMNHFqWnY4cmVQSEdCS3RRZ1o0bE1rQzNJbDRSdjFx?=
 =?utf-8?B?TzVpUkRTbWxKTnZyTEVVdzl6aUI5bHJYQll6YnVMY1oxRzFwUjlhMlJyWm8z?=
 =?utf-8?B?eUpjTElOdkRVc0ZnWFdIaXB6RG1FU2k3dkFjZUhHNW0yby9ua0dtaUZXTFVO?=
 =?utf-8?B?ZHhpOWJvdmZzZXJiNWF5THlaVXozb1FqQnlJUlVMaHpWbEp6OW9rWTd4T2VV?=
 =?utf-8?B?bWxnUDRtMHpERTVkRlQ5d2Z2R0x2TjJ2ZjdtdVhad1R4ZTB5Q1NiUjVLRHJ3?=
 =?utf-8?B?UkllcWpWczlzSkhUVXovT29pYU55US9ZTkpWdnpSTlYvSzNhZDNyWGM0TGtu?=
 =?utf-8?B?bmNoK240c0dvb2Y3Z0Q4Z0FMYmpkak9BcFFrckhjS1FKMmI0ZXhiaE9BU0Vh?=
 =?utf-8?B?aWs1enQyWWFZY2dvaFdzeUlGNFo5M3orMG9SODRzU0xXUnVmdlNTRVhwZlVM?=
 =?utf-8?B?OXQ5QVdnUStPQUx6RnBYMmZhMnJtaGxiVU5RaGt1cmhWRzFIMm5VZVE1TzhQ?=
 =?utf-8?B?YXhHNDNJT1ZxMi9nY1NRRHVsZ0tLditERUxOblpnbG1NaGU5eVRrWmRzSzhX?=
 =?utf-8?B?eFNaY05zd0svdG05YVE2ampyUkoya1V2cWJFcGU1b04wdHlFS0J3S0duY0RK?=
 =?utf-8?B?TlNoczdNdzZLVUVmdmh2WS9ybkdBSGVzRklLQVpKWXQvUVZwOW5PdTFyc0RR?=
 =?utf-8?B?aUZKNnJ1RVdMRU51VnoxMFNRWkN1dWpIVzVjeDJFcDRtcVBiYmJDSzRkYUdP?=
 =?utf-8?B?SWZhaEx5SmZ0dm52VGc0dGxQc2NVVktWdTVCS1l3L2habEJic2FhSWxRWWQ4?=
 =?utf-8?B?VVNrTUEwZ2ZkL2lMcHA0bzkxeHFEVitmV01VdXY3YjgxbnpNUnNxVW5uT095?=
 =?utf-8?B?aFJwc24wYm8xZWhORHNJWUprN3c1ZldOR0M3ejJJT043cmliN0xheG5xK2cx?=
 =?utf-8?B?UVV6dVZJdk8xenVIUTcvQUdJMWtzTm82TUQvcUUwNk82TVZoSUVJYkNCTGVS?=
 =?utf-8?B?WnE0ZXFwek5YTG5qSkR2K2htaUk1bUtoYzBRZ1F0UnlwbERFSGlxbW5DZUww?=
 =?utf-8?B?cWNFdEtYb2hHTW5WcHZHTTZsTG1OUkk5dEI4N3pMNVpCNzRzbDVuUVZLRG1t?=
 =?utf-8?B?dHViM2lyUDd3cnVzc0p2blkweDNuQ3lYSmZBNU9EZkJrU2FQZ0ova2tIWDBZ?=
 =?utf-8?B?V1VQdWNFZFBzQzFnV1ZkSUVBTjFCNXJCSEFEM3RhT1QyT1h3RllzSmd3NjlD?=
 =?utf-8?Q?PyiM3VVZ7SDhCkNCBlTW0pVGo?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06cdb157-9db7-444c-433d-08dd19398476
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 16:41:38.3990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNVfqIOI+VjSFk/z2zWCGOMT2VAUg8oMnjAj0CxOQv7wAdPQRQeEo20PzdM5lSiJpNGpmE1RlpS7hUjgIqbIrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8135
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

Hi Alexander, Christophe,

On 12/2/24 4:17 PM, Christophe Bédard via lttng-dev wrote:
 > Hi,
 >
 > I did the same thing a while ago, i.e., trigger tracepoints on
 > malloc/free/etc. using liblttng-ust-libc-wrapper and collect userspace
 > callstack information (so that the indirect calls to malloc/free can be
 > removed from an application).
 >
 > There is a userspace callstack context implementation here for lttng-ust
 > 2.10, see the last 3 commits:
 > https://github.com/tahini/lttng-ust-1/commits/ust-callstack-2.10/. Here's
 > the corresponding lttng-tools 2.10 branch needed to enable the userspace
 > callstack context:
 > https://github.com/tahini/lttng-tools/commits/ust-context-callstack/.
 >
 > I've rebased it on 2.11 here:
 > https://github.com/ApexAI/lttng-ust/commits/ust-callstack-2.11/.
 > lttng-tools:
 > https://github.com/ApexAI/lttng-tools/commits/ust-callstack-2.11/. It
 > shouldn't be too hard to rebase it all on a newer version.
 >
 > Hope that helps,
 >
 > Christophe
 >
 > On Mon, Dec 2, 2024 at 8:32 AM Alexander Krabler via lttng-dev <
 > lttng-dev@lists.lttng.org> wrote:
 >
 >> Hello,
 >>
 >> we want to record stacktraces at specific userspace events like e.g. 
calls
 >> to malloc and free using liblttng-ust-libc-wrapper.so.
 >> There is the callstack-user context to achieve this in general, however,
 >> it seems like tracing of userspace stacktraces is only available in the
 >> kernel tracing domain.
 >>
 >> Is there already a solution to achieve this goal?

Depending on the type of information you require, it could be possible 
to use the instruction-pointer (ip) context[1], the statedump[2] and/or 
lttng-ust-dl[3] for base addresses, and the symbol table in-order to 
resolve ip -> symbol name in the offline analysis phase with the help of 
babeltrace's debug-info plugin[4]. While a bit more work for the 
analysis, this process reduces the impact of the tracing on the program 
at run-time.

 >> If not, what would need to be done to achieve this?

The proof of concept suggested by Christophe has some limitations that 
may make it unsuitable for use in a production environment notably lack 
of testing - including corner cases such as emitting callstack traces 
from noexcept regions or signal handlers. Run-time stack unwinding may 
be expensive when frame pointers or hardware mechanisms aren't 
available, and the typical work-around to that is to sample the stack 
and unwind in post processing which is not a desirable solution in the 
case of LTTng-UST. Future work could also include integration with 
sframe[5], which aims to provide the information necessary for callstack 
unwinding with a lower code-size cost than DWARF and without the 
run-time cost of frame pointers.

If your intention is to use the callstack recording in production, it 
could also help to reduce the sampling rate. E.g., only sample every N 
time units or every N calls, or sampling "overly large" allocations - 
whatever that may be in your context.

What is required to get this into upstream UST?

  * Funding to work on making it production grade (robustness, testing, 
performance, and integration with the other LTTng features)

thanks,
kienan

[1]: https://lttng.org/man/3/lttng-ust/v2.13/#doc-_context_information
[2]: https://lttng.org/man/3/lttng-ust/v2.13/#doc-state-dump
[3]: https://lttng.org/man/3/lttng-ust/v2.13/#doc-ust-lib
[4]: 
https://babeltrace.org/docs/v2.0/man7/babeltrace2-filter.lttng-utils.debug-info.7/
[5]: https://www.sourceware.org/binutils/docs/sframe-spec.html

 >>
 >> Thanks,
 >> Alexander
 >
