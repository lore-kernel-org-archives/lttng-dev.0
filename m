Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26D210F9969
	for <lttng-dev@archiver.kernel.org>; Wed,  8 Apr 2026 18:28:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4frWmP1Dj9z1G88
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1775672935;
	b=nA1iHegTEorCCjk4CTaVi7JFIvrXf2DKOE80my7ybHQTW4HuoDaDfoY9pb9yD2gphzEz
	 sKJmK3srp2aDZxffN7OpnHsaIuXhDzDPksqRcVLJEevRbUiLhRK/L7R5UY2Zr3OBsnrw8
	 iymdWrAglDTKtAFMebZWsxHlo5Y1C3xyTbZAIeZnLk6FLDI5vPrbmTbA5zuMbqDM0nUMz
	 uyhn3hJvyp3TZiL85IGoN87yJSklWKSxsA3yWIadc4jZ4BNnjk4YqahPdFIuOE31TTlIS
	 6nDq0ztgCOcMdAWOTsgZFnC5lvdj4rWZ7DnkqrZ+uPEPtpMtvqrt5SdNoFC/Zfk6DpQ==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1775672935;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=zOdMyNslianbh/v1EIlj97LHocMvRqIHVku3zlfaPDg=;
	b=fhgJNAreq2sropRBCdSHrHB7PcVMEmmIP7YbOFjWgVKhGBaVKAYBHKYaBHhKGQwU9xMp
	 eKkdsTYgnm72tvWAPFqyOGXLPvpFhK6LTYN+d6PB7pIo3fWx97XooASJ8tqkQYDSZDxap
	 ZDwuzjN5VLZVbVNHQ652+Ovdhu9zrXvoP6hpTFM0maYVf3l9Abve5Ea9aT9UdbpKxL5jN
	 C+JtoXHNmrKd+cTDbore4TACBC+wW2LW76YUJSf5K1jBNZ5JFckJIFcBjYRJjfCz/0A3d
	 h/TFHggDZA4rhOo6753l5s+ikK/LA7KcV+o5zfL6vlV5y1BJBlbMXXbh0hTEwwBjADg==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4frWmP1Dj9z1G88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1775672935;
	bh=aGQyXMezIxIkI5hmvqqFKWglZTsqLcZ8YbYXHhjWor8=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=XHk8U/ZFqvu0qzoxDqXyqnD5cGSS2HR6XYO89BTeI/+eHUl+ukGA269q4e40QIbSl
	 xRsfj8DQ3RGO4Q0bClC1SnwMUJ7yybj+X4A5acbCjv1NpqDyXyDsTiaDk0e9gAkwYH
	 5FO/8MNHHXhsMZMlIfvDpyOu8g1Y8qZbm+DJiPXDo5nEqxz9obJ3q3k8As1Jy6IWNn
	 MGCLDs6LZweXLgnDKiRsFD1RBcDVJ3bIkr8Y50jJRp/dIQqymMKRPO/vcxs7rE+ZRk
	 mG4jGiHzbb9TqvMPmKsvamjjG62BanVhijfpakBMMw+po3VqqtYJf78qIexQQbAS8o
	 PDtXckN/4q0+w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4frWmP1Dj9z1G88;
	Wed,  8 Apr 2026 14:28:52 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4frWmL5MQDz1FbK
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4frWmL5MQDz1FbK
Received: from YT5PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazlp170110005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::5])
 by lists.lttng.org (Postfix) with ESMTPS id 4frWmL5MQDz1FbK
 for <lttng-dev@lists.lttng.org>; Wed,  8 Apr 2026 14:28:50 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIAbLYG2Lk5g4h4CkMoQ8SFeF/QbZU3Hb9k9G311pnNg2lhbtiGzSCFZaG6J0mTgSXv4z7YcXthKkTLfYnivNilIfJyLyBiU2S3f98wxxDU/BGQbVZepHm0M7l0TjFF4Wtc3cW61IK9Zi0gpEE5SmYAhrd4hkcvq0pNe8VjjDFeNu6OsjTNIBDEcC8kOKUoez9m6JzC4Zs0mYibopvJm8skV7+ehvMqAPF1pDCjdO8CHCIFLPQ1293kVJGcy6psJfnbWWBnI+HBgHkfrsWQSSwB7SOZ2Zk1O0DxUWOfPOdXJK8nqB0sHy8gfN4HVVCMu7Z8mQskLP7vtpvb9evzz2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGQyXMezIxIkI5hmvqqFKWglZTsqLcZ8YbYXHhjWor8=;
 b=xgv7yHwCknCWaWkoeaz/0NKGIvWQSgfh8xla8BiDQLhnwr6CdsDnkRrE3AcB3siUiU1/c0yLAHOPN+2VfM898V7lOExTVhGYY71XuBhy2PwUilRjhDH83BZvbGkdGRtcXqUHsIKpwJIulq+6F5r924vFbu/EG/YAfA5BB2r2D1dHArjC2N/uJHBYyhlCTd+0LB/clH0KDOt3UUThJjK70veB8WRSZO3Xd9c2N9ONIBEKVWWWKOLdHkai+YA/I6WD6fbIqdwjLEFEc5aRNaSooA5Q4O+CFEsimgTlI9xDx+LWJ459R02Ifr+fgXgfc28rbGlw5CSstwgUVjYfUe8pBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:42::24)
 by YTZPR01MB12072.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:175::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Wed, 8 Apr
 2026 18:28:47 +0000
Received: from YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4c7b:7dec:7e59:918e]) by YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4c7b:7dec:7e59:918e%4]) with mapi id 15.20.9769.020; Wed, 8 Apr 2026
 18:28:46 +0000
Message-ID: <b2f2c847-95da-4dac-b294-0b5e21d912c0@efficios.com>
Date: Wed, 8 Apr 2026 14:28:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Question about LTTng Kernel Probe Tracking
To: Amir Najafi Zadeh <anajafizadeh@cs.stonybrook.edu>,
 lttng-dev@lists.lttng.org
References: <CAOQX81c_1OGMybWoc3axCVZGk58q9aefxpNS2XTny2K8cy_65w@mail.gmail.com>
 <4a6fd540-da30-419e-b311-1fdf17306cef@efficios.com>
 <CAOQX81e-YGCktrjYwdwDAe_5uRmP5=GaYPBbWm1EiMDnuG0aaA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAOQX81e-YGCktrjYwdwDAe_5uRmP5=GaYPBbWm1EiMDnuG0aaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::35) To YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:42::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQXPR01MB2357:EE_|YTZPR01MB12072:EE_
X-MS-Office365-Filtering-Correlation-Id: 4926ba14-6cb7-4a3d-0a2b-08de959cab76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|56012099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: SyOreJPibsgxsE51qtGi6lkuPKeRmvbioDdM+dOGiqKKcB0FWhKNyDHJyW8aBKf+SBDrdUa/K6w0axaYy4DWd+yByKF9SCWsYd+o9TkYmY0qW6VtUYgvvLUa6/lAJjhu8Tv0ziqGggveBG6tAMe8fNW90irwQZhsfStc6hcHCjNWgDlJ4s2/QSLSYVxGF7vkVDJFSCBl6zysieKpXpgAdHpO0oXJsMti/nzi9uU6ALHif44Q515uUV7qcZQDd1EnBqdMsNPpjKO+si+9wCPh3jia/Qqt43hAqx0uukqcMMuVRK+/psAWSZ79Rqng/Bp94UhBzECu8g8qvZ8EjGJsKtq1dyNyHswHFZFn2wiVtbJ1OqUmsPzn8l0G/Ldb9q/hG/ajQMdfjoGMppLpHFn1p04De2I75O44ZyXerVoZO39N+vz4Nqvdp++Yw5JCoXRHf7LjCAhob+N0jKmcNeB36+OhXPsDsqI3fuJTqCloH312v7T+Hm/ALUga9HaOlztvATTrfBJ38bMd+yBRue3ItcIirt7PzGTFMPI+JjdAoq6Dukytv2b8GMnYKLpR8ufEaW+K61Tat93cwFwXwMl+ma9TdI0cA/p8E828c0zLFDmotjdvNPBQ9eEuFuMaBu4rog1Bws+m92On27wlMYoZHlYCA/AvJ4UjYOX8O/LFToI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(56012099003)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2xWY2h2V3lyTUl3a28vQy9RbUsybDR5blBhc2hNMG1FQ2hpd01kc2U4azho?=
 =?utf-8?B?SXppZGpVMnJzMk10citZTWZjSXN0YjZpVzFnSnlick95LzJjQW44cTVXZ3Y3?=
 =?utf-8?B?N0xCY0g2enVYMm9zU3hrN0lDNjAxZUVCakY1bkR6UmJaRnRaOXNkUjBlVHlS?=
 =?utf-8?B?REFGQkVnK2o2SkJBVlpvVC9pdTlxbGRROEJ3SFhMNWNGdjlsL3lZb2Z6K2Fq?=
 =?utf-8?B?TUxiTWRPajlVZzhXcmZ6US83SlFHMGd0VXZ2TEhqcitGMkJONks0bzMycGFI?=
 =?utf-8?B?Sk01NEMva1VPcklvcWpqWjYvcXFoVUwrOVNNVWdFVnU2MFpNVWVCemk0b0lk?=
 =?utf-8?B?V2N3R0VOMTlWcjQraURQU0tHOFRodUpnVHhSQWtIbUtzNmNGQ2xHN01ubGxv?=
 =?utf-8?B?cGthMWtjNDVxenpWSUwzZXJDa3EwWDhGaGlyTzJPQUFZQk5DWm51aUlyNE1w?=
 =?utf-8?B?NU9XZEVJWjJpUGh5c0pjcHF6MWRsdHlhaS9ESEtuZFgyUEZzbDlLenpDcDVa?=
 =?utf-8?B?ZXNpdTVsMXdRbUsvR1djZWZVYW1SbXdLa2ZSZHF4WkN4bEo4ZGRsekN6cnFC?=
 =?utf-8?B?dzFhS3BvVHduL3lMb25EaFVlZ2V2YmVacy9tN3ZDSUZ1a29FOTR5K1A5RU1M?=
 =?utf-8?B?Q2ZiWlBxTnRsSVdQYmZadWZsdGh3NG5ZZHJRWHdaSDlZa3huN0JiNzFyeEJJ?=
 =?utf-8?B?TVFxVFVTZnowYURtbnNTblZmam9oM01BVVVPLzZOUGlkaTd1QllzTmZFWHB4?=
 =?utf-8?B?dG9sVHhydnlwblE0SG9tQ29qOEtIYThFbXJMUVhXNG91RzZWNEFUTHBEdDFR?=
 =?utf-8?B?MnF2NUR4VVJwejNZNTRCUEcrT3VBT1pUWG54RlErRUlQeVgyQ2p1bWxpR0po?=
 =?utf-8?B?WjlNOHh4d0oyVnlLQmlGZzQ1RjZjMjJIeTJnRXBRQ3MxWThZSEhwdyt2TGU1?=
 =?utf-8?B?MUZhbzBEenhXZUI0WVIzSEZHUWVkMCs1elF2K2U1bDhEeHdXS2N4ZjRoV3dK?=
 =?utf-8?B?U0lyanNwT0pSUXk3U1RXcEFHeWtxMGFGRzY0RXZMN1crSnlpR1dCSXFGbUVt?=
 =?utf-8?B?M3Ercmt3L2xUTFZYVWUrMGhIOFhSTjAwUTEvTFZqZ24wZnVBZ3RZaG8zYWxu?=
 =?utf-8?B?akJxdGlwZVB3dFQ2Q2JvTlRQWFhLb0plWm42Zzl0QThaOVRGQzlMeFI2U0xP?=
 =?utf-8?B?QjRmNWJiY1NxQkE1ZWxJbzd2cE4wcE9lcHljejJsVGZ3OUNGVDI5dThlQ2NE?=
 =?utf-8?B?aTlRMXpCZEszWHk1WVJ5dFF4U1RpYjVWR3ZQQWNtQmQrcUo1OGd6UlNwdi95?=
 =?utf-8?B?V3lkM29jNUh3TCsxOGV2UlgwZ1hIWUZuN2xHZkRMK3B2U3ZGbkRFRjQ0M2RJ?=
 =?utf-8?B?ZTFMQ3BJMXEyWm1Nb0M3TStiaGxucFgzZjRKSzNiVDBUMXB5dlk5QUJnWStQ?=
 =?utf-8?B?cXJEN0dxaDI5WmEyeW9TK3JrNUlRQUxNUExGNjZqVDZjbXdRQ3ArZTRoWUxZ?=
 =?utf-8?B?L002OXhzQU4rYVV1ZEs1SnVrblNybzhNczJBSGlXclE2S0ZSYXJuSmdhZXZs?=
 =?utf-8?B?RVY0dHpVWjdEb2JuM0ZTaitwZzkrSGhKd3pXdldIUlVQQldOTHdxNXpBRjlD?=
 =?utf-8?B?Nm5sbVk5bXBoQkhwQ0hmOUFNWXR2bzZEenBxYmF2cDNJa0NmVEhoUjMyVHVj?=
 =?utf-8?B?Tm9weHBLd1RsRyt4cDNlMEhhZDdJdnZZTjVUdW04a0c5T0hwejJoeFhSSFVl?=
 =?utf-8?B?dHZLM3hqUGVRcmVmQ0hSZGF2YW1lQ1c1QmlYTnRUMnNXanNnMEVIRFdaMjZs?=
 =?utf-8?B?NmdEMW9UMytTWW1JbTN5N2htQWZzMkdXc2x2V0h6ZTVidUNERjdhaG5SbzVL?=
 =?utf-8?B?UGVZWjNtR0pSQzNWcmJwM244WHM2ZXJxUmt3VzFMV0s5NEQ4WHdXYk9BNGIv?=
 =?utf-8?B?TXkvQUNUbW9yem54Ryt0R1YxYjJmZTA2RUtkQjViaG1EbEJsM0NLeTRIUzVS?=
 =?utf-8?B?d2hwaWhRU09GbHRPajdZTytveGw2Qmp4VER0WWd1RmRzc2lVMXpsQlRYU3Iw?=
 =?utf-8?B?MENvdFExcTJ3MmwzWGpyb3Q3V3BwNWRWT05TZURtbERTZFdYTkZhWFdmaFJZ?=
 =?utf-8?B?ampHUWU2MzZ6RnhHWnpjTXBWYnljem55WTlETGREdjlEWVdPTEhFN3RZUkZm?=
 =?utf-8?B?RTRZa1picTliNUVPVjFnaWc0L2svMFpYUDgzM2YycUJZbmZtb1ZMOFFaUER6?=
 =?utf-8?B?b0pOUFFKVENzc3p2cGl0L0hYdGZlR01RelNZemU2Y1dKRGpkbkxyZ05UVkZp?=
 =?utf-8?B?T2N0Qlc1QUFuRkNWbU1GZnp4U3NDdmZuQTd3Q1hGUk9VTHVKRmJIY2s4Yjh4?=
 =?utf-8?Q?086bSQ4xdJzRThc4=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4926ba14-6cb7-4a3d-0a2b-08de959cab76
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 18:28:46.5338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1XFtQBKG1rNmursoudIhIKf3NT3nCISibtxoq/Nysy9LdCK0YGZ3E2aZQHa91jDpA2Ja+YwZO/CrEHOulPlfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTZPR01MB12072
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

Hi Amir,

On 2026-04-07 11:14, Amir Najafi Zadeh wrote:
> Added LTTng dev to BCC to avoid spamming.
> 
> Hi Kienan. Thanks for your response. I tried specifying the session 
> name, but nothing changed.
> 
> Here is the output I get after adding the tracker:
> 
> |Added 1002 to the group ID tracker inclusion set|
> 
> I don’t think the session name is the issue, because I also specified 
> the session name when starting tracking. This is the session state after 
> creating it:
> 
> |$ sudo lttng list lttng-gid-test Recording session lttng-gid-test: 
> [active] Trace output: /tmp/lttng/lttng-gid-test === Domain: Linux 
> kernel === Tracked process attributes Process IDs: none Virtual process 
> IDs: none User IDs: none Virtual user IDs: none Group IDs: 1002 Virtual 
> group IDs: none|
> 
> And these are the logs I get:
> 
> |[11:01:51.222277079] (+0.000004846) dhcp15 ext4_get_inode_loc: { cpu_id 
> = 3 }, { pid = 403653, tid = 403660, procname = "lttng-consumerd", gid = 
> 0, uid = 0, vpid = 403653, vuid = 0, vgid = 0 }, { ip = 
> 0xFFFFFFFFAC804940 } ...|
> 
> There are many logs like this from systemd, kworker, and processes 
> belonging to other groups. Note that the GID 1002 that I want to trace 
> currently has no active subjects.
> 
> Do you suggest switching to the recent version of LTTng (current version 
> 2.13.11)?
> 

I just tested with stable-2.13 and stable-2.14. I was able to reproduce 
the issue you saw in stable-2.13, but not stable-2.14

I recommend updating to 2.14 or later.

thanks,
kienan

> Best,
> Amir
> 
> 
> On Tue, Apr 7, 2026 at 10:57 AM Kienan Stewart <kstewart@efficios.com 
> <mailto:kstewart@efficios.com>> wrote:
> 
>     Hi Amir,
> 
>     On 2026-04-04 21:02, Amir Najafi Zadeh via lttng-dev wrote:
>      > Hello all,
>      >
>      > I hope you are doing well.
>      >
>      > I have a quick question about LTTng tracking when using kernel
>     probes. I
>      > mainly use LTTng to trace file system functions in the Linux
>     kernel, and
>      > for that I use the LTTng kernel probe feature, which works very
>     well.
>      > However, when I tried filtering logs for a specific group ID, I
>     noticed
>      > that filters are not supported for kernel probes.
>      >
>      > Then I attempted to use the tracking feature to trace only a
>     specific
>      > GID, but this also did not work. From what I see in my logs, it
>     appears
>      > that for kernel probes all events are captured and recorded,
>     regardless
>      > of the tracking options.
>      >
>      > I wanted to know if this is a known limitation, and whether there
>     is any
>      > in-progress work or reason why this is not currently supported.
>      >
> 
>     I just tried on the master branch (since I had easy access to it), and
>     wasn't able to reproduce a situation where I added the gid tracking and
>     had results for a different gid in lttng view.
> 
>      > For reference, here is my code. I am using LTTng 2.13.11 with kernel
>      > 6.8.0-101-generic:
>      >
>      > ``` #!/bin/sh
>      > SESSION_NAME="lttng-gid-test"
>      > OUTPUT_DIR="/tmp/lttng/${SESSION_NAME}"
>      > GROUP_ID=1002
>      >
>      > # create the lttng session
>      > lttng create "$SESSION_NAME" -o "$OUTPUT_DIR"
>      >
>      > # create the lttng ring buffer channel
>      > lttng enable-channel --session="$SESSION_NAME" --kernel channel0 \
>      > --subbuf-size=16M \
>      > --num-subbuf=2
>      >
>      > # add pid, tid, proc, and gid for tracing collection
>      > lttng add-context --session="$SESSION_NAME" --channel=channel0 --
>     kernel
>      > --type pid
>      > lttng add-context --session="$SESSION_NAME" --channel=channel0 --
>     kernel
>      > --type gid
>      >
>      > # enable the target probe
>      > lttng enable-event --session="$SESSION_NAME" --channel=channel0
>     --kernel
>      > --probe=ext4_get_inode_loc ext4_get_inode_loc
>      >
>      > # disable all tracks # NOTE: untracking doesn't make a difference
>      > # lttng untrack --session="$SESSION_NAME" --kernel --all --gid
>      > # lttng untrack --session="$SESSION_NAME" --kernel --all --pid
>      > # lttng untrack --session="$SESSION_NAME" --kernel --all --vpid
>      > # lttng untrack --session="$SESSION_NAME" --kernel --all --uid
>      > # lttng untrack --session="$SESSION_NAME" --kernel --all --vuid
>      > # lttng untrack --session="$SESSION_NAME" --kernel --all --vgid
>      > # only enable gid 1002 track
>      > lttng track --kernel --gid=1002
>      >
> 
>     Could you check the output of your script after "lttng track --kernel
>     --gid=1002"?
> 
>     The rest of your commands specify a session name, but this one does
>     not.
>     I wonder if  it's selecting a different default session that the one
>     you're expecting?
> 
>      > # start lttng lttng start $SESSION_NAME
>      >
>      > ```
>      >
>      > Thank you for your time and guidance.
>      >
>      > Best regards,
>      > Amir
>      >
>      > --
>      > *Amirhossein Najafizadeh*
>      > *PhD Student, Computer Science Department, Stony Brook
>     University, N.Y.
>      > File systems and Storage Lab (FSL)
>      >
>      > *
>      > najafizadeh21@gmail.com <mailto:najafizadeh21@gmail.com>
>     <mailto:najafizadeh21@gmail.com <mailto:najafizadeh21@gmail.com>>
>      > https://amirhnajafiz.github.io/ <https://amirhnajafiz.github.io/>
>     <https://amirhnajafiz.github.io/ <https://amirhnajafiz.github.io/>>
> 

