Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73021C3DA45
	for <lttng-dev@archiver.kernel.org>; Thu, 11 Jul 2024 20:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1720731347;
	bh=TFvCt0rtSvf3cttbeBLA9dpsXRia7naOr0cySF0e5uE=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=RLjPqiyg/VkC/JZpzZwpFzG1cw3WhKJq9Xt7glBv/eW9y5SuGsG2l1cy9lcVEjdhs
	 JoMym8fmS/PBGyqTm5mX0uSKO252bDikRcBlYBo1zMtyC5BZLXlXbjhgF7AmdOmkjx
	 VX6/aeM9tUlT/4NLqN07kDDyLb5NRYx83itfhdGvAfQNSZ1dMURyHyvcUbMCHdnwvE
	 ccNYTd39DVTFWdCttd+jgIuUHcEdJhJdBY+9+VUe1HcvtKJTQK+2Y5jmudkv7jPbSF
	 Gn5ysnQIXLypxFh7kJ6tudHEsA6WfTIMJw+PgTveSS8/p+yKlL4TuyZB1TjyFA5bCs
	 DHj7qDx5tOSkw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4WKn7R2X9LzBfd;
	Thu, 11 Jul 2024 16:55:47 -0400 (EDT)
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazon11020126.outbound.protection.outlook.com
 [52.101.191.126])
 by lists.lttng.org (Postfix) with ESMTPS id 4WKn7Q1z71zB9V
 for <lttng-dev@lists.lttng.org>; Thu, 11 Jul 2024 16:55:46 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZaLiyRgytZGa63AbhnXBSwb/rSWLY+isH3P9z0NKb58m8u8KeWEOfdLtbXee/6NDZU6B+A63ZEt+XLcJoKOWs3wWoqK0K3jBHcVC80qqnHhQuaGc5q9K9W0gL649fr/jQHsK7xWdnavLn3HDyTqyz5+d3aqNP+Oe/IM0rMLC2+JmMlFrIdkbpqyyBC22/VVWT7xSo/sybJpL9KCK/drfbfGTEbqnX+eF2eYGadMMz4Te4OkjT9HC//gwKuC5fBPGKoph7W9txwpGL0FrOeCTelFDENKrvIPFqypOOIM9gGb+YJP2zTqeX6QFM/ImDkAdfDVcrV03owKYg+ptVmL/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19FyP7BSZFsBttXVds+b3Ai0G5fzJOWcNNO9ypd8DaU=;
 b=tkmmHDDejxzfsVovYzABs4R5L/PZkA+DYwb1qAy5SFiXFqI/OVFyyv/bfc5ZLWmCinWjCIAMiGHPCMlJjFdzi/n9sxcBNWqIAUBhxxmWyPLYzajBnrwHTHMdrtaHrrVZ0/kqHDpaNO0UVA8D+Q4sXp7VKo7NXLnh9rZ++a5f9723pi90l46LJPAE/xBFhOLZHNN9WOLbecl1MREFkGCXqhCFthhPMy+TMr8yEc3qcUXea6gNv3AQEL2712XqFuVLvzK61QeJCnZaH38AFAiypfP3uBPjL3gWpYtF9MAlWT3glytMjz/jQao4mbgfNO9YrgHMe0WBykxw5XG0bXJD0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT5PR01MB11196.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:137::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Thu, 11 Jul
 2024 20:55:44 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%4]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 20:55:43 +0000
Message-ID: <003921f8-df16-4573-ba6a-7ef8821f4863@efficios.com>
Date: Thu, 11 Jul 2024 16:55:41 -0400
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Fran=C3=A7ois_Belias?= <beliasossim@gmail.com>,
 lttng-dev@lists.lttng.org
References: <CAHD10UjRBLgAWAAfgOLVgxv3zMYkedtWjquOdC60XTPDifEeJA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHD10UjRBLgAWAAfgOLVgxv3zMYkedtWjquOdC60XTPDifEeJA@mail.gmail.com>
X-ClientProxiedBy: YQXP288CA0036.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::38) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT5PR01MB11196:EE_
X-MS-Office365-Filtering-Correlation-Id: ba14d99d-5f6b-48b9-5ff9-08dca1ebd4ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c25xOHBpM0t4MWFPcmJVR0ZqUlBOSnRCTG5qZEZZcFduRllXWUcyMkhFQ00x?=
 =?utf-8?B?VmV4Qk0yeWFsSHprSXFuYzM2MUREVnF2M0ZnUUxuOVBidGNWRUw3SmtiMUh3?=
 =?utf-8?B?dTFScytYZHpyMk1EQVFjN29MZHh0UnArTDhTbktpR1pqRTJxUzJzOWw3RUtp?=
 =?utf-8?B?bXpVSytyWnBGUENEOWNuaHp4aDhyd2phbi8zMWtNVHlqY0VVcFI3VjRaTCtF?=
 =?utf-8?B?RzVYVG9BSE1JTTlXZ1lLQ0ZMNHN2cUl4WnVVQjhyOUZ6Q05NWHR4VFdUNDdz?=
 =?utf-8?B?SHlQUld0R0JsUzdRa0xtZ0Fnb1JVKzNNL1JOSzF1T2Z4UlhkYkV2enczVytn?=
 =?utf-8?B?aHdMemNqaTZZckpxeXlsLzRuZFVMUXpZOTZ4OFdna0tleE1saDdZRDBYc0sx?=
 =?utf-8?B?L2Z2eU9NclZNeVpBUG4zUThlaHJrU3ZkYk5nYVhBWFRSWm5iaXA1UjBsclVi?=
 =?utf-8?B?MUVXeTlocWN6UW8vT3p1M1Y2UTVuYVJ2UXE0Mkd6eXl3S3RUMWw0R09oM2dL?=
 =?utf-8?B?ZVUzSEpHczROTFB0cExvRHdVenJsbW1iQzl2SFV6cEZkTklBc1I0ZVZwOXlZ?=
 =?utf-8?B?TUY4NFIvbys5cUtnNUVjbC9JNjU3Z0pzWG5HSTZxQlFBT3kzbzRqeDVCOHly?=
 =?utf-8?B?cVVrQ3BLd0EyR2xtcjJIVVFxcGs2VXErb09Yb292VDhFSzlPVU83L3VoaUM1?=
 =?utf-8?B?T3VjU2RaeE5qd2c3RXp6TFQyZEFYdzNpcEhjZ2dMM0Ivd3NmTE9kT0dTMmcr?=
 =?utf-8?B?cFhOTW1wZERORmxpLzJ6QWxhM2hkWWZXbXZJdnlRN2x3SmRpQklPV3dON0ZD?=
 =?utf-8?B?bExqajVKbGdJblRUZ01zeTBPeC9GTmRwQjFuYmVzbnNqUjFrbWpBc1BrYm9P?=
 =?utf-8?B?S0RoSitqOEdNNmI4cE9USmk1dy9zSENJT2hJTEg1b2d5U1cvbjZpaUFwWXFa?=
 =?utf-8?B?V291bGlJZWNaMVpCZ2Y1MWd3eGxRZnI5MmZaekdBL0RtZGVRZjVUOEFhTVV3?=
 =?utf-8?B?a3p1Unh2U01oUGFvQ0VYUkRIY21VeUVta1VsK3RlV21tMXFYU2FpTkxvdG1z?=
 =?utf-8?B?SndyRHhMa0pMSWVRdEVqTmlhYkx4Tmk3QS85YjlPdFdNUm5QeGRuUzdnVHho?=
 =?utf-8?B?bUdYS1ZJZDY2ZVgzZE9XQlZEdGcvZ0Mza3k3MElDZlJOeWJONGg3V01PUm4w?=
 =?utf-8?B?a3N6Ly8yTGtoMnZKOTY2WWk4WnlQbmkyTWZqb0EyV1FJTnRUOVNVUDR4VzBs?=
 =?utf-8?B?MEdtaUpPR0d6QUkzekR6elMrOHFJSEJmenY1a01QMC9FYXF3VTlEckVaMmN4?=
 =?utf-8?B?bE9paU9naXdxRlp0SFoyOCtEMmtiYVpkQjJYU04rWFArNGRnY1c1WXhYQ3M2?=
 =?utf-8?B?WW9iTnNSWmZhaHplNktBdE9MWG50cjc5emVVaUNDVzZYVE5rTU9EcUNSWEEv?=
 =?utf-8?B?OTEyZkxaRE1SdCtUb3dvWFg2R0dTdDI5S2pycFZJcHlTc1ROVkRNZUxTckpw?=
 =?utf-8?B?RzVoTGQ4UCtlaWN5NkhBdGdvZE5VMWJsV3RsWDNzbmFObzFPUlZrWjEzdkRV?=
 =?utf-8?B?cW9aekY2bitwcm5TNjVBaXRxdkNqMkszc3ltQWZPR2dGZlFqK090U2ZKcy9s?=
 =?utf-8?B?LzcxUi9zK2YwQVY3a01KZ2h6M0NSYnNRRmpERWtaQVRMbUdycWVmSnY2UDdo?=
 =?utf-8?B?RysrdCtwTkFLcjZzMnlyOVVqRFNSSmdKMFVJVGhiYUI4NTJHcnlmTDNvS1Q0?=
 =?utf-8?Q?fP1HgoF8gTpTfzc7pE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0kwbG0wcXZzNjdBQmk1TVI2YTVTQnhFK0x0RWJEVEpkSytPTDhtWjI3V1RI?=
 =?utf-8?B?Ynh4WHVScWxsQUN5b2toUi84RFgxMHhUOVNHckZBTVhqcEFmc05FY056OEdt?=
 =?utf-8?B?d3FHNVZXTkUyREt1QzMzNFNyZ0lpT3Q2ZkN5OENicVJGRzRuN09ON2dpRGli?=
 =?utf-8?B?c3pCekJwZnpTaW1wUE5zY1ZLTDRaU2ZnTTQ4cWthNzF2WENQeDlrVVpsM1U2?=
 =?utf-8?B?Z0phM1UrQVB2OFVJQkoybmhXTDRjNHE0WkY4cTY1bFl4TXFJS2tHdUlrcWRR?=
 =?utf-8?B?SXJkeGFjZDRHVkxreGEwNFczZmpMMlZidnFrNmdxUGhRUW9uc2VJMEs3bCtQ?=
 =?utf-8?B?dXp0Qk1SQnlSSGszRmlkbGkxTk9oL3FhTFpxNXZWZUF4YjlBOWhDdSt2VDlJ?=
 =?utf-8?B?cWJ4RUhwQ1JibW1FZGFMMXJWN2RDQmNwS0JHTHNNSGQwU09WakdHQndaZzJ0?=
 =?utf-8?B?OFNlVlhhc2NvNStZUU4veEFmUVcwaHZHR1VQN1FWcmM0bjRYOFJ3NFZYZm9N?=
 =?utf-8?B?TXN5cUhZSXQ5NDFxdXdLQk9rcHY3SnNBVUtQdS9wTG8yaDBnWll2b3p3NXFJ?=
 =?utf-8?B?WTA0ZW9tSUxERDZUejRoekFadnVBazNKNEhBZ1ZIdW1iYkN4d3d0UjJQWlBT?=
 =?utf-8?B?S3d3ei83a1I4a2lQQkZ6WkVJZW9tS2RNZUJKdWxZVjFzajhhczhISHJRN3VK?=
 =?utf-8?B?N2tQcmo5NHZnN2tuN2NBQzBIeU5PeVBrdE4rOFZSM0pCVm0yWTNZTUpqM2ha?=
 =?utf-8?B?Q0VpTUt3UXUyb1gzc2ZReldvdnpGK2REK2lnRk9BYzVOdTBXdkZrZFZJU1Fl?=
 =?utf-8?B?TUFNOGQyMGdKYWtGazEvbEFoVUF0UGZnUkxXT3RXVTlFMmdVbHVXVFBsaE1p?=
 =?utf-8?B?Y3R4bk9vVUNZSWxPSkhIWS92S0g5S25WU1hmeHkxOVNwZmFnN1NQU21LNmJE?=
 =?utf-8?B?andzM3hSZVY0Qm9JdVZPYS9SckFJSFF0Ull2SVJIb0dYbStseFVvVzFpOHpk?=
 =?utf-8?B?SDFMUjlrbzdUQ0VRWWJOOFBQYm5HcGxDaEY4V0ZRNEFGTHVTUHFJOWcrcEQw?=
 =?utf-8?B?RU5wVHEzZmd6VmZtSnJZQS9td0dZM3Vzeml3RFhvY2FTcW5IcWlvdmJWcGlM?=
 =?utf-8?B?Y2U4Rmx3TTRiZFpVaUo0TWxBMkdGQlBBWTlxTzVUNzVidXZkSFpnYVEwcUxL?=
 =?utf-8?B?N2ludm5YVUZoVG9XeURNNDkzNGEwN1lFd2R0bngyNHJEUjZlUTArbTZ2UFhl?=
 =?utf-8?B?OXBJSE9KSzdtNDI2d2I3MTNQMmFuT3oxeEtGM1pPSDRwYmxTaUNoNXhLOVBn?=
 =?utf-8?B?RjFUTnpyVjhBQXhIVlBvMFluRlU5a3hEYXJOcVN3aGI0SmVIR2hvbm1NbXcr?=
 =?utf-8?B?bEJoenJWV0RxVnUrTUpmcVNINlAvMExySzhlSDFHcjJFVnc2Y0Y0UjlrMWYr?=
 =?utf-8?B?cjZoR050VXAzcmZXckpnS1RyZnlvZktrVG1zZUIvRld6Y013ditYamp0Qm85?=
 =?utf-8?B?cnoyR1JzUWs1b29oT2FpWFVtYnl3Vk1PV1ZIb3ZBK2c3NWhHdWt3TkRiME9W?=
 =?utf-8?B?ZTZTeVU2MUZjenFTbmpWWU9XQzY2dGVZK2htaUhrdmRFaU4raVJxN3pTR25h?=
 =?utf-8?B?bXN0aFN4R0p5cjBUa0g0K3MwdXE2QVNuQXpUOUR3VDZsenIyUHBJaWpsRkVx?=
 =?utf-8?B?aEpBZ1B0aHFKaUFrcHhNTSt1SmwvKzVXdk4rMWJncTJpdkhKelY5ZFRrbi9L?=
 =?utf-8?B?Sy83dThhSlR2RU5lV0hQQnN5VXo3UDhCSUJNa3BOZlBBbDh0dW9CTFVVYXpw?=
 =?utf-8?B?c0N4eWxhUUYyWURuZzU0NUlMNTQ1SjBoQjZYd24wdXA5ZkRvY1VDSzdNZFZs?=
 =?utf-8?B?TitFL3BYWlJsTk1XbTNleUhqWjBZQmJEUWRad3hWNjN1a1Vqdk1TSGI4Yk03?=
 =?utf-8?B?VzBwY0I3TmlYaENYNEpLd1lSS2RlT0tJMDBTN1NnK2VxcWFVWUJsY3c4bE1q?=
 =?utf-8?B?VTF2bU96ZU40YjQraW9CRFpsS3VUOGtjVWtrUzJZSXIyODlFNFM3d291S2tp?=
 =?utf-8?B?Y25wWVJxUkNLNkZPRTNYNDAyNHJKejJuVis5b050VG04Y2FQcm1XN0RzT0ZQ?=
 =?utf-8?B?YnRqN0M5Mzk2NGd3TGhHRStURzUxUTdFNEx0cFVJU1dOVzIrRmZCekR5eHYw?=
 =?utf-8?B?S2c9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba14d99d-5f6b-48b9-5ff9-08dca1ebd4ae
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 20:55:43.8395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VNATqAk+ugJoTEpKo5L4heJhT1CVgcI72kNwSUaImEmQaaCgAmTqCVNDr3OP0lLjbOUM3XnToQZxi3x6aSlO5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT5PR01MB11196
Subject: Re: [lttng-dev] Undefined symbol error fix
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

SGkgRnJhbsOnb2lzLAoKV2UgZG9uJ3Qgc3VwcG9ydCB0aGUgZm9ya2VkIHZlcnNpb24gb2YgTFRU
bmcgbW9kdWxlcyB0aGF0IHlvdSBhcmUgdXNpbmcgCihodHRwczovL2dpdGh1Yi5jb20vdGFoaW5p
L2x0dG5nLW1vZHVsZXMpCgpUaGUgY2Fub25pY2FsIHVwc3RyZWFtIHZlcnNpb24gYXZhaWxhYmxl
IGF0IApodHRwczovL2dpdGh1Yi5jb20vbHR0bmcvbHR0bmctbW9kdWxlcyBoYXMgdHJhY2Vwb2lu
dHMgc3VjaCBhcyBrdm1fZW50cnkgCmFuZCBrdm1fZXhpdC4KCkUuZy4gCmh0dHBzOi8vZ2l0aHVi
LmNvbS9sdHRuZy9sdHRuZy1tb2R1bGVzL2Jsb2IvMDZhMWZjNjM5YjEwYjQwYzBmZmM0MTJmM2Zi
NjYzNjMyZTQyZGFlNi9pbmNsdWRlL2luc3RydW1lbnRhdGlvbi9ldmVudHMvYXJjaC94ODYva3Zt
L3RyYWNlLmgjTDIwCgp0aGFua3MsCmtpZW5hbgoKT24gNy8xMS8yNCA0OjA2IFBNLCBGcmFuw6dv
aXMgQmVsaWFzIHZpYSBsdHRuZy1kZXYgd3JvdGU6Cj4gSGVsbG8sCj4gCj4gIMKgIMKgIEkgYW0g
dHJ5aW5nIHRvIGFjY2VzcyB0cmFjZXBvaW50cyBmcm9tIHRoaXMgd2Vic2l0ZSAKPiBodHRwczov
L2FyY2hpdmUuZWNsaXBzZS5vcmcvdHJhY2Vjb21wYXNzLmluY3ViYXRvci9kb2Mvb3JnLmVjbGlw
c2UudHJhY2Vjb21wYXNzLmluY3ViYXRvci52aXJ0dWFsLm1hY2hpbmUuYW5hbHlzaXMuZG9jLnVz
ZXIvVmlydHVhbC1NYWNoaW5lLUFuYWx5c2lzLVVzZXItRG9jdW1lbnRhdGlvbi5odG1sIDxodHRw
czovL2FyY2hpdmUuZWNsaXBzZS5vcmcvdHJhY2Vjb21wYXNzLmluY3ViYXRvci9kb2Mvb3JnLmVj
bGlwc2UudHJhY2Vjb21wYXNzLmluY3ViYXRvci52aXJ0dWFsLm1hY2hpbmUuYW5hbHlzaXMuZG9j
LnVzZXIvVmlydHVhbC1NYWNoaW5lLUFuYWx5c2lzLVVzZXItRG9jdW1lbnRhdGlvbi5odG1sPiAo
a212X2VudHJ5LCBrbXZfZXhpdCkgZm9yIG15IGFuYWx5c2lzLiBJIGFkZGVkIHRoZSAiYWRkb25z
IiBmb2xkZXIgZnJvbSB0aGUgImFkZG9uc192bSIgYnJhbmNoIG9mIHRoaXMgcmVwb3NpdG9yeTog
aHR0cHM6Ly9naXRodWIuY29tL3RhaGluaS9sdHRuZy1tb2R1bGVzIDxodHRwczovL2dpdGh1Yi5j
b20vdGFoaW5pL2x0dG5nLW1vZHVsZXM+IHRvIHRoZSBjdXJyZW50IHZlcnNpb24gb2YgbHR0bmct
bW9kdWxlIGdpdGh1YiByZXBvc2l0b3J5LiBIb3dldmVyLCBJIGFtIGVuY291bnRlcmluZyB0aGVz
ZSBlcnJvcnMgd2hlbiBjb21waWxpbmcKPiBFUlJPUjogbW9kcG9zdDogImx0dG5nX3RyYWNlcG9p
bnRfcHJvYmVfcmVnaXN0ZXIiIAo+IFtsdHRuZy1tb2R1bGVzL3NyYy9hZGRvbnMvbHR0bmctdm1z
eW5jLWd1ZXN0LmtvXSB1bmRlZmluZWQhCj4gRVJST1I6IG1vZHBvc3Q6ICJsdHRuZ190cmFjZXBv
aW50X3Byb2JlX3VucmVnaXN0ZXIiIAo+IFtEZXNrdG9wL2x0dG5nLW1vZHVsZXMvc3JjL2FkZG9u
cy9sdHRuZy12bXN5bmMtZ3Vlc3Qua29dIHVuZGVmaW5lZCEKPiBFUlJPUjogbW9kcG9zdDogImx0
dG5nX3RyYWNlcG9pbnRfcHJvYmVfcmVnaXN0ZXIiIAo+IFtEZXNrdG9wL2x0dG5nLW1vZHVsZXMv
c3JjL2FkZG9ucy9sdHRuZy12bXN5bmMtaG9zdC5rb10gdW5kZWZpbmVkIQo+IEVSUk9SOiBtb2Rw
b3N0OiAibHR0bmdfdHJhY2Vwb2ludF9wcm9iZV91bnJlZ2lzdGVyIiAKPiBbRGVza3RvcC9sdHRu
Zy1tb2R1bGVzL3NyYy9hZGRvbnMvbHR0bmctdm1zeW5jLWhvc3Qua29dIHVuZGVmaW5lZCEKPiAK
PiBJIGFtIG5vdCBzdXJlIGhvdyB0byByZXNvbHZlIHRoaXMgaXNzdWUuIENhbiBzb21lb25lIHBs
ZWFzZSBoZWxwIG1lPwo+IAo+IFRoYW5rcy4KPiAKPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwo+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiBsdHRuZy1k
ZXZAbGlzdHMubHR0bmcub3JnCj4gaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWls
bWFuL2xpc3RpbmZvL2x0dG5nLWRldgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRu
Zy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0
dG5nLWRldgo=
