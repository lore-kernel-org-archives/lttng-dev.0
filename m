Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57307E7E0BC
	for <lttng-dev@archiver.kernel.org>; Mon,  9 Feb 2026 16:37:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4f8r2c1qHjz1jk7
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1770655050;
	b=Ug/9ui2E15912+JFEzwGaFtJteTakhVB6Ab4gsbS8svN/4oOEx8ROhMgsFIA0wpsfSsI
	 MBLAWnL3jYAN6gTUhCCxPMFQxch6iscWj+vtJksAOLpeXFF61oth8ijK5v67qJd2apV/j
	 eOF9+PszAoyLouUqp2Px/hHuej7niG2rVIa6FsV4l+DXJf7FGdY6SNqcR8JS73t6mcECA
	 j0LQXXz9tk+lY6J/9AOb1/wrDpB36Cu4+nV7zPmWoGKcZaauR6ZJxQbbzPwazv/UpE60v
	 iZX7atv5DAHdb8HU5AwRdvgpQsLG1QX/vQm8VMKhs9EpGoQ5lkYjEpVjp3NOBnrkvwQ==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1770655050;
	h=DKIM-Signature:Message-ID:Date:To:Subject:MIME-Version:From:From;
	bh=bzS2Ox0TpX1qv47Hufr/21avKWm2rQ2EXZuf2Q77ysg=;
	b=H4bYarfODHPPDfUJ8XDPWXNx2T/Ao61y9An6g0bvoF3gD+EIBGkyS5TU6kaBmzH09SD8
	 UDmXBWCKz58jHVkPVpNHvVXIJTgFc+Qmz9+Ij9ujIYhb8fZi2+n8Emi4efY1G5VtFGSqb
	 bBE2gayi12UvnlEfjdT1aAweE/+OOBVzuAc+iL4BmZHjKkeQ74Icxl2HoA0fm/4QX/YL4
	 QcLNZW9xsRnUR7gZn8dU2fWIRazDYwvZrs8Wbazh6WmYBxEXhsh+dfU7b/avL/a85iqCQ
	 tCkU51P85ddpSCmvhNf2F1n84QnKYpsFjw7cnWxGEZ07MRlGmCbbAiAOMZz8N82MjCg==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4f8r2c1qHjz1jk7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1770655050;
	bh=mj3KZPJf3K0cD6s2ixaWand1CLoinSCffPzTHmmfb3Q=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=BYPSVO+8Ehol0zhPMNZzz24bnMIZBTIh1NEm/39rjLICGKWN+VXL1GX2QzX7r5g3W
	 WgZnl0Nve1ZjqCp2m+GGVhPNARU14FqZBY4z59O/tO+m/dogYbiuGi7lqD26o9IgFN
	 9fOwq6dgg28VffE+vq7i1Nl599yIleK71g1h1wd77lzGy+vP0QnyQVK9/xXKs38M7w
	 QuQlp3muW3D0KChWq6yHM7q2Xg7xKcRC8FwN+wIVxOOhJ2xgOqDgFsSU1D7clvY8xW
	 Xqd1aNFqN1v/xyxn5+CNzdoR/DO2oxylG9jheOorj0gpKYZFx2MH/Om7rFPPz6P4T4
	 6cSsybqtESZ4g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4f8r2c1qHjz1jk7;
	Mon,  9 Feb 2026 11:37:28 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4f8r2Z11q8z1k4R
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4f8r2Z11q8z1k4R
Received: from YT6PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::3])
 by lists.lttng.org (Postfix) with ESMTPS id 4f8r2Z11q8z1k4R
 for <lttng-dev@lists.lttng.org>; Mon,  9 Feb 2026 11:37:25 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwgLhQYqYGFfo4cJgp1tmZt4boX5rSHXLWnp7iL2qvB+T5yOCrHG8iyczVKMLnWgTOhonpQHEnH/2sL+1r3nfoLpzSQeOzXmUXCgiqReW8iu8JAf3ugXx5pcJ2+z+gRVrPnmTsNDS6R0yAR2GzIaK5Ken/vYdvia1L4FtrZsgdFgECHq33/9AwuKXEfTy1PjCkLk9GgQ7RqYO1FIkVWqbWLbXhnc7gSa90levgHTEE3Lhx1jKqDtfu7swIH6uBWV6FBBVaTjaVBLlllpMfC3MagzF4NdvYhqHz9oz2U66wSELi2Lq6pF/OwsGqqXamOp5lQSE4BeW+2sWh5KUq/FEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mj3KZPJf3K0cD6s2ixaWand1CLoinSCffPzTHmmfb3Q=;
 b=PMQmZcTj2UJlf9xWWbdGnEwK2+0bTtmfoISYv2dJ/BzqVUpqXrWRQzMBuF4IGNCwdq40dkmOyqKoO7PGky9JoLbyAJk8uOtoeL+XgHy7e+gTIHUdYyDRap/fZOWCAs49S5pIM1Gy/3G6aUh4eZamQehcndIOEOGcnS6nRdAr3ACZpNlg3DwD2eqV3r0Qkz2H7ENc1Ud5/YJVBFAZ9yTuSFrRFWlif26pc6niv43vzmhXETOmzb3FFHMrBhZ+Z6r+uZ41TBvSHs5/ukOoMNWnTiNnnMxaRa6y63rydjKTokzSaxTZaPkpKMJ5AR7qnh/mqBwzUWF4IhYHy02qzOOsMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB8711.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 16:37:21 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 16:37:21 +0000
Message-ID: <c20e2419-9604-4184-bb28-ecf8c1970dc8@efficios.com>
Date: Mon, 9 Feb 2026 11:37:20 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev <lttng-dev@lists.lttng.org>,
 Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RELEASE] LTTng-modules 2.14.4 (Linux kernel tracer)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::27) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB8711:EE_
X-MS-Office365-Filtering-Correlation-Id: 45bec215-7872-4a9b-3e11-08de67f97ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1ZnUmF4S3k3R285SmZqOHlQUlhQd2ZKSXM1VEpRUDFWdFVpdDRVTFltTTlB?=
 =?utf-8?B?RzZlVGUrTXp0UTRweTFDOHpSMEhyREdRYVBRVTFkampLakVBQTNMdFFsMjYz?=
 =?utf-8?B?WEtKdE9ycmJFZnZ3bnFpU2VhTHlSdUkvLzhYTDdiNmNIL2ZjcnRiaGtPZ1JL?=
 =?utf-8?B?SzF2OWlYdFRlelR5TFMzSktHVWRTMEJTbWRJNXFzR2o5NVQrUnZaa3daQ21y?=
 =?utf-8?B?Nm9WeEIyU0JBS2dHYmdWQVVCczU5ZE1mR1RNVnNGQ0NLMVIyQUhTamV0Nk5v?=
 =?utf-8?B?L01JOUlFVmcydW03bWRtNVdhVGxOVWhNMWJkSjFEd0Fham4zZ3N3ZEdqNHZL?=
 =?utf-8?B?YjJSalFqNURQbUlOWU1WOVEwMHBQWm9oSlRvTTVrQzZGbm90aWVHTmVrQUhk?=
 =?utf-8?B?Y0FUUmphLzU5KzQ5SSsybSs2T1R6RXMvVXJjMkgzRnVKRE9DM0M2WFAyOHp6?=
 =?utf-8?B?T1NrWXRudENqRER6OGlJMndLd2thMmgrZWR4a0tKcU55S3YxdGFCZjh4YTVX?=
 =?utf-8?B?aVU1bFFBeHZnQm1aYVgydk5OSWdzc0RZQ1kvdlB0SXpRaUZnTUhxT2c1WElV?=
 =?utf-8?B?OWFpcVhCdzd6OGswTGtvRkRhanN2SzNrSXBITDA4a215VlBEWHd2Vk81Q0VV?=
 =?utf-8?B?Zi9GbE81NUF5ZFVYbVR5UXc4YVJXRkpLTE1qd2J2RTBIS2ZPekl3L2c3SVNi?=
 =?utf-8?B?WFRVeDVjaFZmZ2tZekRtditUbXQ5aUxlN3V2bnNRNFBiY2FUOUdCWDZUa0lJ?=
 =?utf-8?B?RGZWY24vb3ovcS84NE1makhsOFA1ZCtKcnY0dVBNQkNBc0UzaEZqbUprN3NE?=
 =?utf-8?B?ZjZoL2xZS0E5aFF4WUt0RWdiSmo5SFhseEEwTEJoajdiaHA2cURmc2dtdE1u?=
 =?utf-8?B?TmpuYWNBcnh4VXVpRFpCME43cno1ejhwT2crekE2dVgzMHpXclhZSVlxYWRk?=
 =?utf-8?B?ODhJc1JmeTFKYmtDWXY1d1RvZ0xKelg1NVg1dFNpNmc5dFVuaExwUlJsbHEx?=
 =?utf-8?B?TGU0b2FsQ0hjQ1ZXelJSaEp3ZHVaYU9MWk5QQWp1T2JXdjBUMVdoZTFBSVQw?=
 =?utf-8?B?cnpKMHArY2tZTWN3d1ZXc1YrUVBHYjlsak9ncjhkT2V6dmhWNHorNUxTZHlh?=
 =?utf-8?B?eHBZTUVKV1lXRXNiTWhyRjVRSUtCRHpWYmdGOGR2dnNJUkM5eWdSV3R4NEhP?=
 =?utf-8?B?TXNSOGFJcFdqNjRlZHcyM3FlT0VKd2p1UTZSc1Y0T2t0bWxkY1RhVEx5akJS?=
 =?utf-8?B?MVZ6TU5nZmdzekhaTldsZk55cHBjOTJWVFpNdjhpVFdZeXRQNXpRRjIxY0M5?=
 =?utf-8?B?WlFqUWxHU2NwMi9RZmEzajdMSm94RTVuUjl3ZkFUOXBJc243TkR6MlVlUGln?=
 =?utf-8?B?VzZGc3pDNGRtMCt5RGtHNmJ6RGpCM0pmL3pUbEMzeVd0WFE2UVFBVnRJUUEw?=
 =?utf-8?B?WU1HUFRUcndtaURzaEZhVHZFNWtoUVhrWmZrcTZkWlFvSG0wZ3dCcjNJelNQ?=
 =?utf-8?B?Ly8xV1RMRngydGZlRExWK0R4T0EyUXN2T2lwTTB5RjRNVVNNd1dYZ080RDNQ?=
 =?utf-8?B?U0xZbGpSYTlhZ3NqMG1lWTZTcG4wTlIzTmVPWlpKd1V1UkxkYkpZbytHcXl5?=
 =?utf-8?B?RFZ0cW1vdy95MTlXbWpQWkZLRTFNcFpNaWJoVU5BcDBBMzgrQ3o3Tm1BQm5i?=
 =?utf-8?B?RGJoTG5QY050cll2TjVhYVJQMlBIcDlmT1NmUzNSUk1Kd1g4QkFlQUp4SnFx?=
 =?utf-8?B?ZkMyYXZiSUZnSlIrMURHdmc4b3ZiakoyaEVqS1ozK0hCS3cva1NQbmloTkxu?=
 =?utf-8?B?NUtWa3R1T2lNVUh4cjY2Y2MrbVBiaXNnSkppYy93OE1HRG1tQ3N2Q0dtM25M?=
 =?utf-8?B?WUI0cEtZQXozdlA5b1BMbWtDV0xwUDdoK2ZxWlZHTG83RWFIVXhEazE0a0Ez?=
 =?utf-8?B?d2oxQkphTG5scFJOOUc4MCtqRE1adTR2R3NkK2RERHRMSzJoV0tOb1N5Q3NT?=
 =?utf-8?B?SzZkeG5uNElHdW9neWtMSlIvQ0VZT1AyczZRUHFaaFhmN2dJL2dIb0ViQmNS?=
 =?utf-8?Q?lnib8y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clFpNFd5NWZEL01HUmp0dng4QnY1RjA0NVJCMmlIa2hlSUxUalF0SW9URGd0?=
 =?utf-8?B?UnZSSEJQYWl6MHlQSGk2QmJJdjBqazNiU1pHUHVHVUZjYlluNFp3Qk45Q0ZR?=
 =?utf-8?B?YkFpNVNrRG1HbGNjQjFpOGY2djEzb3JQYW5xN1pnNEd2RWZMc0xkWTdCaDF1?=
 =?utf-8?B?TXdpYnNFVmc1QUZvUUxGa0xaaUpuUmtlbW9MWW9RdWFuYXFvUkgwc2JiZkJ6?=
 =?utf-8?B?OHlTYkRXUHRabkpnVVF1VExBTlRrUzkvTlJWV3EwNzBCMXl0amFoR3o5K0sv?=
 =?utf-8?B?anU2TlQ0cVRiVUwrSEh3QXdlVXd4WHhuM01vUEtBYUwyZVMwaEpqd0xKZUpR?=
 =?utf-8?B?dFNueGt1aGxLdG9RVjJrK0xQMm1ma0h0K2JiWTV0UVFEV3F1VnNva3J0V29l?=
 =?utf-8?B?Mk5scmthSDVoZ28zUjVtc0ZnSzZvc0hJSTBGZHVHSVZGN3lkSkxhMS9odVZE?=
 =?utf-8?B?eUk2SWJpcW56MkF2VjJLVzNxTU1yUUduRnBoNGlxcDQyQkp1NFZwbWFwNWxB?=
 =?utf-8?B?Z1JYajNhM005WXcwc1h0d3RwLzJpdU5nWTFiaEdTbFlhaDlHUXJOdjh1eklT?=
 =?utf-8?B?TDFtMXJXMG9oY3RHTGRmL3EwazY3eUtaMnc4NEZpWitscy8rVHVyN1ljM1ZK?=
 =?utf-8?B?Kzlxa3pIRi90Y3k0d2lCemxNb0RVYmZscmRIZTExMzhuZXVZdm5hancwZndJ?=
 =?utf-8?B?aVcxOWd1L2l5cU5RRHpwMkNxRktqQldDTDFHazJ4UXM3czArWXRzMjRlQjFK?=
 =?utf-8?B?dHdZa0N6RFBvU2labUx2N0RjMEZMTDk4RUN3ODBuUVlFbE9IYkJuVVhJTkkr?=
 =?utf-8?B?Nk5YS3FLTzlyMndvS2dJODBmdkJLL3g3SWgyT0pHa0dFMnlueDdGcUNoQnNV?=
 =?utf-8?B?RmhCc1A3VlZndFdSK3ZsTE9Pa2pWdFNQaU9FUWd1azNWRWpJQWJFbnlUZWpO?=
 =?utf-8?B?QWowdS9CRGdPaEN6d1JpYmNxSUZSYTZVL2t3WmR2ZmxHMlhRL0hCMyt3eGZt?=
 =?utf-8?B?NVRoUitnVjBkTlpwODlndk01N3hvekhLTVY4Y1NCcUtad1Bpay9hVm1LU0w3?=
 =?utf-8?B?bVFqZVczYWN0OHc5TmxBcFZrOUcwTW02M0J4ZFArQmw0RW9EeEl1T2xHdWEz?=
 =?utf-8?B?OHlsVmhxUFZ0RlNWKzJLc0tsdG5HeDc3V0lvaE55NWppNWlWQk5yR0IybzhQ?=
 =?utf-8?B?eDE2M2t1OTZzSm5wUGJtQW5rdmhqWWVDRXdvNFkwUXhWZXJnVk15UE9qQUxP?=
 =?utf-8?B?bjFoS3NVNkZCRkFwRE9ETWgrbmZLdzgzYkpuSU1wRjFjMWNCekFtc1ptSCtO?=
 =?utf-8?B?WGh1ZlFtc0U1SW5lYUpxb2NtMzlKbUc5TWp0QVo5bjUyTGo5Rk52cXFHU0lH?=
 =?utf-8?B?SWREUWJOZmYwK1QvU0FvaVBWVEN3blZCa3lLbmRNL1ZsRE1tc0M2cnpOam10?=
 =?utf-8?B?QmNWalBMZUNYNllGMTRMSUwyd2I1MTRYTG84WHhZNmo2akpSc0VYUXcrNUMz?=
 =?utf-8?B?M0FFOFNmcGszWXRQdGpRQkpqSEJZSHdZbmNnZEtLUjk2RG9iRkhiTDlkRE8w?=
 =?utf-8?B?WjlqUFNkVEtMaWdHTXJkZGlHQTJhcnJQV2xVb21HclhqYXdCWHI2SE94NlZj?=
 =?utf-8?B?VDlsN1VvMjg0OXJndWNjcVR0eGlLTjJSdkEzT1VNRDJOV29qYnoxWEIyN0Vs?=
 =?utf-8?B?MnRlaFAwRWVVRnptQnViNEhtV08yQUVHaFhYdm9adXVTeThINzVvWWRDOVh0?=
 =?utf-8?B?NENKeDZ0RFdXLytuZFV1MndYM0FQSCtsT1BZWk1QNURpOTJnOHh5VWpLUTFj?=
 =?utf-8?B?NFpZdEJmNEV3SGk5dXlPRnhmOGFBR0tzdStiemxEYlEvRWRGWmhBYTVOakFx?=
 =?utf-8?B?WmpLMWdOMEkrYlY4SEN6bEVPVU9rV3kzZzFYS081SFZnVkt4TzNVdFZUWG5v?=
 =?utf-8?B?aFRMMlVHbWZIRmZ0dkJDOFpEem8zNVI0RzdpMmtRWEpBdTM1M2VuSlAwMmd0?=
 =?utf-8?B?VWMxdENab1U5aEYwVExDMmxlMlBmZ1U5U2pPVnNhUGJwRzRtbGF0NDd0M3JG?=
 =?utf-8?B?d2ZzaHVOZTg1MjZxT2ErNWhZRTc4ZU1WVnZ3NkFsNHJDUEZ3dGNPNFhZTVp1?=
 =?utf-8?B?RXZHUVoxbU9QUW9IQUNWRXJsaHhZWUt2VkVOem43a09idUZsQ0xyK0Y4Q2hD?=
 =?utf-8?B?M3NUN1owYTl4UlYyUFpYamZTdWU1NXh0MHF6SjkyUjltL1RBYTRweHgwU2lR?=
 =?utf-8?B?OUVPQ1pDblRtcVVlN2dHTWc1N25IUDJraWhKNm5CaCtkc2NINVEwRDEwQTJI?=
 =?utf-8?B?OGpOWlVuU0FWdHpqdEx2aXlrUVVIZSs1Z3J3YnFXNEFyZmFrWlZYK3Z6RTM3?=
 =?utf-8?Q?ikPKDikS/bBF/U7s=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45bec215-7872-4a9b-3e11-08de67f97ef9
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 16:37:21.0701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aniuPFQlFxLhjYhywFX3l1gnmDhKxmsl8UTtodKdZFx9vEa92FQ4JuvpXGaF3fK6Ev+98MOh37LP+mWKmSFmE6/4rhB0QKPYz7aw1h4PAqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8711
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

This is a stable release announcement for the LTTng kernel tracer,
an out-of-tree kernel tracer for the Linux kernel.

The LTTng project provides low-overhead, correlated userspace and
kernel tracing on Linux. Its use of the Common Trace Format and a
flexible control interface allows it to fulfill various workloads.

* New in this release:

- Add support for Linux kernel v6.19.
- Bug fix for experimental CTF2 (https://bugs.lttng.org/issues/1434).

* Detailed change log:

2026-02-09 LTTng modules 2.14.4
         * fix: Manual conversion to use ->i_state accessors (v6.19)
         * fix: btrfs: headers cleanup to remove unnecessary local includes (v6.19)
         * Fix: Initialize syscall tables sorted entries
         * Cleanup lttng-syscalls.h: Remove extern on function prototypes
         * Make init_event_desc_enum_desc_sorted_entries public
         * Update .gitreview for stable-2.14

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

Enjoy!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

