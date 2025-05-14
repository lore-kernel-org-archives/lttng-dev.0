Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9BCC3ABD8
	for <lttng-dev@archiver.kernel.org>; Wed, 14 May 2025 19:41:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZyNyR36gcz1093
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1747251711;
	b=GbwcB0BpgR8lpl7+BpDzE3RTgsTMrOdOChrdpmFJ6+/5qKMGxaX+VB4lteRtofPg02TT
	 rFMsd5SMSV+TUZB+xpMZsD63Mf1nBzj+6tBdPR5uurbr30ZnvKR2R6LjLm7vhkl7LY+lg
	 KRH5z95VzkbdHL3bIu3nwSy4yfIQ/534uwk9TpR6NW0X8HAjcLrgqiPA767G6RaPGVlOh
	 sLTXna0PXwlEqnepPjVDswllexMiX70A3Ycl3VWoZie/8Xt0HQ1aR/wDCaQ9cZVaT8bRY
	 sB+fYc7UbRU5u9KEI/JA7Nm9rQdRvwzsUwywMiQz7k9rDVOitx5jBCsmtU2vHbLuTQQ==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1747251711;
	h=DKIM-Signature:Message-ID:Date:To:Subject:MIME-Version:From:From;
	bh=RUAMBQVEYWhj4V5grxA2fORtghhplreP+Cdy5+h4wT8=;
	b=d8Cmz1+Td14DFCHBmbW1T9KDlv6OcDxsGhKcf9/qQ95uKoCX6NTy4sbf6C72TfpNkD7t
	 gEOZOU/RjVKJaMczzOzz7Yaey+YiC2gcqqxvVNFvAT3JVZ+jhMUVk/MrNBkgc0JR+gPhg
	 m6MQo+XV8Hqxf1426n5O0iZUZ3ZY8Jp5jbTocHGtKk9Dt1VJdq7pHKbkDr0wf0FNNDf0H
	 0mKLBJL/uMt0V5UnE3XMBjvxuVeP+kH95wrpw+nAFR9GAR/INu+W5QdcwkHav5b7jW+7z
	 SPWryEsIergjGVuaV9HUjC7+Rr6kdDUrs8lFv+xsZUL6ViMUc2JeWLxaLOM/tzuCX2Q==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZyNyR36gcz1093
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1747251711;
	bh=RUAMBQVEYWhj4V5grxA2fORtghhplreP+Cdy5+h4wT8=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=E3NfWChjpd/pDfLH9N1oIOePgle/xcoNp+tj2EQ0FxRxDH+s15lL1C8qEOMvmRP77
	 0Bmmek1Q5FO0DyGU8QPQIXjr7bIGlHhJjNu3bcr64zDPHGdTGd+f0sJaMeDeIQJIXg
	 7zFh8lkLLlNaNG7mmbwSR8hiUfbMqH4lD8g23yJvNhxgROtsAfCbow8e1txAPRceuh
	 nqB8WN5BOB0+QXfsd78Ka/nx1VTXMOvl9k83Rjla5d2bNEwJd216EkjYrC+gy0xJt7
	 cn3ZPTIo07mPmcHAZNwrS16RNRpJe5kY2xsch/7HtDr66/cwsbKiCMBM4yeEq7jI8b
	 XvIB3OzLladSw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ZyNyR36gcz1093;
	Wed, 14 May 2025 15:41:51 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZyNyP4STrz10kN
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZyNyP4STrz10kN
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c104::1])
 by lists.lttng.org (Postfix) with ESMTPS id 4ZyNyP4STrz10kN
 for <lttng-dev@lists.lttng.org>; Wed, 14 May 2025 15:41:49 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhzKj/KLtBR1o+lWCPfUj8PlFAkwkYjCZypnWOxrSjBF6RDbjLXg6gMn65B3aYRwywCkKwpU/o5Nx/fR6VcvgAD/ghfbMRqK+Bb7JVCQIvYBDjIi8yrD5eQup2mmZwkRA5CjiB81SVJ6Ue+Rx56xQvZplvQ8R1Ic7efCYoxNUZKLX431dWsJulquPnKA9E/BuDGN1KeKhto0ZPM0NmBPbI9bQLpypyDCnQuZ3OQSWfm1dnYnpzcpmjQOGEy6e61MnFp2DHncGQ9HlRuq5qVYfpJmohBbZUuhDU1vyVI+0Nq0sd7B3n4q8JhtBxPmU5jpcxDAyARCxz8MbqctHUF8UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/e02VIPSdVQFQWbg/hFj9ir9hkQb0ZQCJ1Ykp98Duxg=;
 b=X5dgQuucKezwTW2cootXTew/I6gSbt/ZPBzxOB28M1sHglunIPENJH8HH7XWtW0JDwKAzrOH2lO2Oc2kuTg9gKju87CtrBwQKz7B46MoZz9zHexiLfr78KThkBRoTdWlIeUKAbHvZUz3gpdgcElh9333pfb76PW6Ikcz4WFU2dxqA2Ptth2Oh3FSP7tTaZnvw+Bw8Qbu4ezGqB5PVpr75C1f5mZUleUqhYIxwJ3j3toqCMBOqHDm+YfoK3EhshuQtc6VdNpU42Wl5gMXlHJXbTGI4s3ZHjoKI57DkcYqSXKGkqKwp+1zzWmeN2Ga4E0ATcbW2tkZJlOyQ+FhTbsUlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PPF32182F264.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::51c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 19:41:44 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8722.031; Wed, 14 May 2025
 19:41:44 +0000
Message-ID: <a6f4bd3c-30dc-498f-93e3-815bfd474d13@efficios.com>
Date: Wed, 14 May 2025 15:41:43 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org,
 linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RELEASE] LTTng-UST 2.14.0-rc2 (Linux user-space tracer)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::40) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PPF32182F264:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f68f67-54e4-4951-a310-08dd931f5b3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVh3RGhNdVFTVTdFMFkwcUdmTlpuNG9GM3B6YjVERW5ZazFyWjFmS3R5SitZ?=
 =?utf-8?B?d1F2ZGVOR3p6ZnlPb3o1cXIxKzNkT1JQNGJWREYxR09UcUY3UVZsL2ZnSXBG?=
 =?utf-8?B?UmVLRjRoays5NkYvZ1h4L0hwcnRVT3hCN0hBb0lPV1ozR2tJdm9uMTRib1FV?=
 =?utf-8?B?T091OTJTWHZla3hRUjdiVXRZbXdkWDJUbEl0UHVYamdxM0dLbE5XVjhBUDJi?=
 =?utf-8?B?aVBQL2pjcmg0WUVBUmJGNFJWelhkdzgxVEJ5N3cyTUhWb3lYOVJZTVdUOCtu?=
 =?utf-8?B?YlV3aW1uWUtKS3V2azNiQ3VnNVJGMUt4UGNobFVlQ09BZVdPU3ZtYVZaTkxW?=
 =?utf-8?B?S3IrVVlHOFoyb2JSdDJ4VEwzZmc3d0NDdjQ2VXhpQ0N3TFluRHZLbmU0b25Y?=
 =?utf-8?B?KzlvbyswTVdwNVRJV2pwVkpRdE1pMjNWSUlvbHk3M3lMRVd6dDZWVkRaUW52?=
 =?utf-8?B?eFpadm80V1Z4eHFVZXY3MWo2RjRQRTlWOElDVlY0Y0tjeFhjMmZHM3BYWjlT?=
 =?utf-8?B?UXJRTGM0TXlTbnN5cVdDTVM3VjVHdDEvU2l1TmQvVUE5Q043dWM3c2RnUlhF?=
 =?utf-8?B?eUJ3NjFCbFlyaWtIK1pDVWp3WFV4Y0RZT2ZXQzFRd2M0aVNRMDNFL1ZYd2VG?=
 =?utf-8?B?eXdheDNLcEYwSU91SzI5dnBMc0FZRHF5SmpsWE82N2pFUG1BTGxsQUYrQ1Vq?=
 =?utf-8?B?RzFuRUxrcDhDVEpTa2VPcG9yUnVxSkVtdUh3M1JSM1diVG9WazVOM0s5NTFU?=
 =?utf-8?B?cVJlVnVzR3JYMUdsME1FeFowRHd1aXdCNkdwckJTcVg2YXdpaFRqRUdmOFFj?=
 =?utf-8?B?eFRSRGxyc0pUU01raUZ0VHRTdHNKejYxWTJDdFRVWE5MYS9xQVJObGhZenpE?=
 =?utf-8?B?UWVZVzM0QXlRMmNlanNDOG1ldVplU2RNZm1lSXYrQStSV09MeFhncmNUenJx?=
 =?utf-8?B?SUlkVHpLdm9zT1FxRVdJMkV3VEdTcit6dGhkNHJoeVZOU3VURXI3TUxVcTYx?=
 =?utf-8?B?YkNzNVhwV2hSa1VvSkRBcXJvdXJlM294MDU3ckh2ZVVlYm9jdXZsTDNpeFFX?=
 =?utf-8?B?bU0xZTJDNVZOL1NMYUhtMzFTT3k1SWQzbVpPamdvbWF5dXJoL3pZTW10RHNW?=
 =?utf-8?B?TXdaL3g4RTZENm5rdjdRM3ozTGtxWGtXN0NOQk1hTFpzMTFoZmVZeG5TTVk5?=
 =?utf-8?B?TnlGRTRVTGs3K2tnZW5wTVpSY1JaWTNhV2xVZ0czTmhtcjBGa1pSVzV4V0dl?=
 =?utf-8?B?Vlh2VmlnK3pPc0hTa09SeU4yVmJzTEFrTDlvblNrNzgydWpLVSt6dWV5VDhI?=
 =?utf-8?B?K0J6bm1sT2ZuM0hScVZmNnFFRXJZTDBqVjdld0FxdWZ0cUpad0QzcHYxM0Uy?=
 =?utf-8?B?UVNyekxUeFRvNFc3eEZucnVvZ2ZQeHJOU1hhWXNrMmh1aTladlEyd1lCUXln?=
 =?utf-8?B?NmY0WW0xck9CWTI0RE9BQkZQclNEOEsreUxkcmNlL0NXUE1QU0VuZUNiWFFU?=
 =?utf-8?B?UjZIZGcwa3MrSmlHeUFROE56RCsrVy9zR3pkZDBpaEdqSDNkMk5TMTcxWFMx?=
 =?utf-8?B?bDNjejVkQ0ZnQUIwMThnOW5qTlpWb1BZTVFhOTRqaFFiTUk4cFpXRFNJa1Bi?=
 =?utf-8?B?MWdzZE9CejBvVm9sSVk0cjlXUXdCdVh3QjVSNjA4UC9qYnVFNnYzREJsRnVk?=
 =?utf-8?B?RXVEbGlwUVJTWmVFbk9pelFQU0I3cmxqY2tmZTMvZU5sMU1CclJkMEk5eGR3?=
 =?utf-8?B?RkJtUkRzdkhnMDJBaTllMFdEeTVBbDV6aWx2eFJGcVN4czNjL1lxbTZlS1ZG?=
 =?utf-8?Q?PmFTwysIrBqJUrUfpVdOK8MeNe8drvQnifPwo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEw0NmVYZDJ2VjJmNnZUOWR6QTlqWnpScGFuOXFlaHI4QVNMRlFNVGpqWkY4?=
 =?utf-8?B?bU96WnBsNldqNE90MzF4cnpxWDhjenBhZzd2VzJOSVFGNk4vYS9ORFJqL3M5?=
 =?utf-8?B?RUZDdGlvTERMcmR4NE1KUXdDMVNqdHlMeWdYTWM0b1JBRGVsa0ZqRzI0cS94?=
 =?utf-8?B?TDIxWVU0dVZFbTNxYUFjWU5yN2V0dVdad0t6WHY3YmJ0L1BXOU5YblhoeDZq?=
 =?utf-8?B?TkR3eGtmZzV5a3d3RUJjbEhJRzRLTWkxeWRBRTc2NVBjZC9SVUZLRW5WWEFm?=
 =?utf-8?B?VmhEaXJiek1LWjU0N1NsTjhGSExaUUEvaXVRdHowNlF3UGdveHp6MEIxd0Fu?=
 =?utf-8?B?clBsbXA1eU5pWGFpN2dia0NaWWgwdDIvL255ZnAxb3ZObmFTWjNLRjlMMjRY?=
 =?utf-8?B?V2dxd0Y5azlNNWZ2OHJPNHc3TVh2K0RGMGg4c24zY0xsOWVhZmlIZE5hY0Rv?=
 =?utf-8?B?a3VOc045SkxVRGl3NTlQMmMwT1lSYjc3YTFCUk53dnN2dnQxRWdUclFNb2dj?=
 =?utf-8?B?UXJFRGQ5ZmdmdjB5ZEcvUXZWa3dFT1Y2aXRaSExKa2VRa3NuWDVnM2NzclpG?=
 =?utf-8?B?Vm13QUdKa1lHYzNuVTdLUDhSd0RyUVNjQ1ptR0VhdHBkemRHeDZGTlBNL0tH?=
 =?utf-8?B?OVVCYkg0UUFEZHBVVkpkSnNwRUlTK20wMmcrNThyRk1vdDAxVC9LZ0Rtd1ZJ?=
 =?utf-8?B?YVVDN283cWUxQW1CZ0JxUnJ1SVZWcXVNVXJ0d1pzQm93UTNrc0pVSDBjSTdM?=
 =?utf-8?B?cG9md2ZXMFIwTU4ySmlVci9CRzFFYWFwMDROMVFqMjlhZG4wSUJmVytMWVFQ?=
 =?utf-8?B?dEhFNEllREFYbGYwM1VPaW9JTHRyaThlL1FlN2NoMjRRTTVuQmtxSVJscmFZ?=
 =?utf-8?B?TEVBRXdScXJ5cUFmQTNBczlVTlAzNk9NRWNxNW5OOEszUHRCdHQ3Z2thcHM4?=
 =?utf-8?B?eWd0Z3U1dmZLVXd5elZIR3VoVEpZbDJuVDcwNFdSbk9CQ21HY1NsbmpSc0Rs?=
 =?utf-8?B?VDVHUUpmY3d2TVJnaHIzTFpZdTYxOGNDK3ZVMFBZM2cyL3oyWW1UZkdmYnBO?=
 =?utf-8?B?eTBmd1ZyY3hJYXFyWUlRaFFGbVRhTlVzQW5qekxsZ1o4bHBIeHVod09iallG?=
 =?utf-8?B?M2tIcGdHSHZ4R1lJMndxY3gvZzVlTUJTMFpZZGNzMGNCM2VQbEQ5TVIrakJ2?=
 =?utf-8?B?Vys3L3N1NktmcU5TSndBSzZqNWtpMkNadVp5bVRyYWx1d2F1NjB3V2puL1oy?=
 =?utf-8?B?ZUsvamRHRTE3TmRTVll4dWcycm1KYk55cksvK3llcnd0b0N2K3VjSk9McnFp?=
 =?utf-8?B?NFQyM2crTTg5YWErUGFsQ2NZdThGQTJUempXUzRJcWg4NnE1R0dlT0xreWVI?=
 =?utf-8?B?UytVY0dXbzVoQW5XWGp3UkZyNVk2REN1aStFM29QVHlUajVlT2xlejd3UXAv?=
 =?utf-8?B?bVRmeW5ldWQ4WGJtVWp3dmROU1ZPaHM5ZW5DeE1aeWpUc2tqWGoxdDVXQmZk?=
 =?utf-8?B?NzA2V1Q3VHVFb0FwRUdGdzJaRGVzdFdsV0ZGSnBkbXZLTzBpMzIrVm9TRUlI?=
 =?utf-8?B?V3dBZVpVOURFZUk0bFE2a1JjdnBaQ0p3S1BMSFk4aTBBbXJnK3lqQnFIeFdZ?=
 =?utf-8?B?VWNqVzB0MGw0cGhTR1dMNk5yK1ZmOTBCUElHb1hqMDRoNjBBcWtkZklETVN2?=
 =?utf-8?B?ZndmOE9tUlQrdHd6Z2FyOW8yc2xXMlhuQ1ZCK2JYNXliRVJDUDByZ21BeEs1?=
 =?utf-8?B?OVJPblRuT3pNcWpvSVhUaDVIRkFVaFpxS3o4YVVSQ1hOSWF2Rm9KQUovdjlU?=
 =?utf-8?B?UTJLMjVnamVHMnFxTEl6Y0ZvVE9GNVd1VEsxVWpRcXQyUnNWV2FLU2RITjl2?=
 =?utf-8?B?M0RJd1NsM3ZoUU9nNjVLTEg0Z0duQ09DYTcvdXJ3a0FGZ0YwQlliZE9CbUha?=
 =?utf-8?B?Tk5uZDVHeWdObk54NjJRVS8zRG56alM0RVBQYmxxOUI5VmsyYTAyOUJBR3Fn?=
 =?utf-8?B?YU15Ylk1dnpyTmpjcStuR2ZwU2ZxYlJVb1ZkMi90WFFiNE1NRmRnclJ0bjB2?=
 =?utf-8?B?NExyRWdWT3Qyamx3cDZqMnpuUGdkV0pqM1N2OHVHNktYMytpS3lLNldxNldX?=
 =?utf-8?B?azhEY09DQmMwM0FWMzFpMCtiRHR4dy9lR1FVZ282SkpHbkx2UVZ4aW5CTU90?=
 =?utf-8?Q?hw0bDKIv5EI9FUt9q0s9HgI=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f68f67-54e4-4951-a310-08dd931f5b3f
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 19:41:44.2419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQfsRZITuuu6qr2+mrNi+QbtO3h+AGq8NBYYJIZ/s2LMyGLnpLenMuQjNTntxR39syr8wyVrlwEUpHVQ8TOfUL6NBtuZssIPsttpx9Szg2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPF32182F264
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

Hi,

This is a release announcement for LTTng-UST 2.14.0-rc2. This release
is done in preparation of the final steps before 2.14 final. It mostly
contains changes that prevent building unused code and hide symbols when
experimental build defines are unset.

LTTng-UST, the Linux Trace Toolkit Next Generation Userspace Tracer,
is a low-overhead application tracer. The library "liblttng-ust" enables
tracing of applications and libraries.

* New in this release:

2025-05-14 lttng-ust 2.14.0-rc2
         * Only compile trace hit counter code with experimental define
         * Hide experimental counter symbols

Thanks,

Mathieu

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

