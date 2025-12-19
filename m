Return-Path: <bounce+b7b410.602323-lttng-dev=archiver.kernel.org@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from m43-10.mailgun.net (m43-10.mailgun.net [69.72.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40E4E64A92
	for <lttng-dev@archiver.kernel.org>; Fri, 19 Dec 2025 22:32:12 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=lists.lttng.org; q=dns/txt; s=mx; t=1766183532; x=1766190732;
 h=Sender: Sender: Reply-To: From: From: List-Subscribe: List-Help: List-Post: List-Archive: List-Unsubscribe: List-Id: MIME-Version: Content-Transfer-Encoding: Content-Type: Subject: Subject: Cc: To: To: Date: Message-ID;
 bh=/WOSsZXOgyC3KgDM0duCrudWIZvBg5K9I1TmafG9VWY=;
 b=BAvbjmHeML20azMKAWK7+6So4QaJwKlaPeg2DwQxbzUey4voVNGNmMQT+ivScqNQX0GpM5Qi10BvkDNy7aX7dfgBV8oteM9VeU7Q/FlpqaNASQToiPlH88FAEI2acUJQmopSd/Ivp4M7BQelAwX8RLEvBzwkqWIh9j+9c4M4Nk5jySiNzRg225QVds/j0e6l1WIuq2/WhJLptyoAIhRm4ksofp/Y65Prdo7hfPpqh6jiUSmt04hZp6iNaBog4q/56sbotjap7xZiWSXblWGws2RLlAVjbI7ZFt4XQxSojekQrH5tOcCGV2K1NR0HphrJaIfy0BPzYRlG4I2mm0C5Rw==
X-Mailgun-Sid: WyJlYzgxZCIsImx0dG5nLWRldkBhcmNoaXZlci5rZXJuZWwub3JnIiwiNjAyMzIzIl0=
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29]) by
 e53dc1c54fb02e9fc8e58dc836085b7cac956b9fa28ca5e984106468ff909ff1 with SMTP id
 6945d26c1804cccf5c553398 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Fri, 19 Dec 2025 22:32:12 GMT
X-Mailgun-Sending-Ip: 69.72.43.10
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dY2Ms5CzFz1h1y
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1766183531;
	b=ZEav57q1slLjGQGGhKDgiMhSwEonwINUCjZzeC+qpSIgQ/aWx4LCejnzrahzLDrEw1Ia
	 3sBCiJMmJsnE+hFZWnid9am3tmMFuTmD9lPXe4KRosD4PP/lRKbD7GdLd51KzSpEeb3bN
	 lp/TumVrWiGs9XTmAvgemloL3zpLfn1svhXaiD1NnOLz4fISUOnKwnW3zH2taGnBhXm/H
	 Cn2gPoaqMTXmw81WegZLxufqTUDw7mdYXiJhDh8zFzZhJGpsii9ZjHxbQ96bXQ0eHRHG/
	 dV0ltpIs3oW3CXzukntCkr6yGjC4uAIztn/+FDJV6h5bmfyXuOT1ivBDRvIBqDjJKxg==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1766183531;
	h=DKIM-Signature:Message-ID:Date:To:Subject:MIME-Version:From:From;
	bh=ye9sQy7HeZb47akPQksVSJN/qUoBcDkVWyVYDbISXxg=;
	b=Wxn+/lqtSIgKnUrFPZCZ5tvPJvBiZ5o7JwffGVdO/zDky++R6vC3Jj2IJ1d/7WZRLU/m
	 T3kazDWpAMQGSgX7JqS9HyRlmZDAgIuU3POKhNvA2vgKUxDgWZdfrZb5M2X87nj8zBrPw
	 8C21e6RMTIE3kaU/ejWyZpQa/hOa5Z+DuijbbafLdoIHloos0FY6azVz5/lcnmfgAfJ20
	 Tv+bJ16F9uqZqYmLf7hTmnDHs5XsCJMRbfJhB1SsVhKAGM84sDJR3CK2Hr67AGRqqOYcy
	 CFe/K15vPHjEa1IEa10SvHQp94sLzH4upHHz8/n0x2PA/zpJ32wEOuolov+X8sEx0yg==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dY2Ms5CzFz1h1y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1766183531;
	bh=ye9sQy7HeZb47akPQksVSJN/qUoBcDkVWyVYDbISXxg=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=HeYq+EwKwovTvBxYtp1k04v9AgE/B2uaXUYFXi7WIWehSp6SRvHlXQbPk+A3PNKzu
	 a8GCA4ILHvuxGW7Xgu2lAlYwTQMEFJFLuV4UcmqQxBuFyhaf5qi1hZNUfsTGYD0g9Y
	 u7pxbjzIGQMPEQNU4lPXetkKGfp7QjIYAFS9SxNQXntB9pefkEsEBXLpaUau0IwaFZ
	 1akJr9HjDnZsLaZPreBdvI+5P353JaPmI2XllcNu52eQgpi0dLqNMSSWu8uAESu495
	 4KmNTMR4BvZXyke+KULjGQzBw0D/NPYcNYhWqEYhxPlKefIkR21k83bEah4j3T6BUu
	 rzATZgFxmQOdw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4dY2Ms5CzFz1h1y;
	Fri, 19 Dec 2025 17:32:09 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dY2Mq3dtQz1h3K
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dY2Mq3dtQz1h3K
Received: from YT5PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazon11021141.outbound.protection.outlook.com
 [40.107.192.141])
 by lists.lttng.org (Postfix) with ESMTPS id 4dY2Mq3dtQz1h3K
 for <lttng-dev@lists.lttng.org>; Fri, 19 Dec 2025 17:32:07 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWpH3jx2SGoyoZPl8FwgTiv8Cg7+g+/xnCaabXJFbAOndqkhjE6m3L6c7YC5YO3NaNGf2BnYWpfWwhG94EYfVRl23MvFCiqE84Lu8L16WZ1j5XxfXufDjfd1+s5ij2CohApOnMKxCJhAs72IabRFVFQcoGBsJYPNKAZHYm+/sQZXt7ij7y+V26dOikTqQiPr+EZ1pl2W5nnnR0+RPVGGuNqJCWq02TeGOxOGlhDDG+ivIF15LaLcIC5mynPbt4H/SaK1RFJ8snlsmxrLkmOHVdZwhyscK48j2GQWWlgFYvor+1qi/05meBA1z69MovtQciRR1dEGgxgdi0Iw8qweSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WOSsZXOgyC3KgDM0duCrudWIZvBg5K9I1TmafG9VWY=;
 b=XfMN0zWa5CocjtOQ7J7VOAGW+f5DR/OQ1fqQ+3yoQ0fak6WNv38vlVjWsFWJ+o42Yoxa9slVEknijlI0tltEIryPnqwUMTsd2Sz5++hO2kWL7qgyzBMf8DcrrYTF/eMHP1R40/yCG8PT8gFeDPjQq15CvXQvHjhnaQ6Pbsn5EJAbLiywsTjDuWovbMHddQY5zaCs7hG6CEBWBvN2OlRgERh+g5XRtvg6fgq8BW0bXxNcT4sGwGQAFtA/j5WMfcU20J3F0H5lJB+m1D+ab6ABkY4quoAxsnzwoR/3X0cm/ddZ0nGPDvISlgDLMVfK5NuQqh/VAeb9Rh8eMae2QL/HKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB9915.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:8f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Fri, 19 Dec
 2025 22:32:01 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 22:32:01 +0000
Message-ID: <0628c50b-8ec6-4f84-a051-52674c2e9c1f@efficios.com>
Date: Fri, 19 Dec 2025 17:31:58 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev <lttng-dev@lists.lttng.org>
Cc: Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>, lwn@lwn.net,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1JFTEVBU0VdIExUVG5nIDIuMTUuMC1yYzEgLSBQw6ljaMOpIE1vcnRl?=
 =?UTF-8?Q?l_-_Linux_kernel_and_userspace_tracer?=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0151.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::24) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB9915:EE_
X-MS-Office365-Filtering-Correlation-Id: 453d1682-316d-440f-c341-08de3f4e6d5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejlQZ3lXYlY1bzdZVngweDR0dm5pOU95WkVEVmtUaGdTb3dzcFpldWVZVmhl?=
 =?utf-8?B?eXRxZk1tNGNiTHdHMk45VzdlcE80NjhDa3dJUzM5Wko3Q2tQYktYVWpVL0tZ?=
 =?utf-8?B?RzVJT251ajhDcEY2TVJkK2hvRG5YUWpjS3dRZDlmeGhhVWgrUGlLQ0pmRUQ5?=
 =?utf-8?B?RUNXWEdDK29EclFRQXBGMWt1cnVOSDdXc3YvMmFBd3hBSmtaUUNPQUQ0ajhp?=
 =?utf-8?B?WTRIUUx1NGxEeERBZ0tYU0UyVk5aMDBSdkhHMitwWDZDZExINWIxdXZYSVVI?=
 =?utf-8?B?YzFJbHdEWHVrT0JpWEV3MmpRaU9hNWZYbC91eWVwaU1uMTJCblFoYnJST0dV?=
 =?utf-8?B?bDhZNkhjSkE0Uk0vSTdTSjg2aFhuWU5RL3Z6UnVtTFpuOUNNdmZOVHpaV0VB?=
 =?utf-8?B?SG40UDdzWm9lRmV0bEpzbEY0aVU5bDZ5Q1FxVUJ2TFBGb0wwWUU4aFg5WjRK?=
 =?utf-8?B?UkJhdE5wZ2V1RCtmN3NUZ2djTis3TXdVZWNsSW9VMDNYUHFnb0l2N3M4T1dN?=
 =?utf-8?B?d3BFMERUeXZGSlJVamNqbFFETlI1N3dDM0dTaktLZHdBY1l6ZndlSTY2bmVx?=
 =?utf-8?B?NktyOWpuVGxIOEJXUzlPLzNTdzVIcHdhNEpOVktDRVlYLy9yQ0lrdGFVVGQ1?=
 =?utf-8?B?MitJNFlTUWlIMFpqNk1lMXZpa0wxTHdXbVhxWHBzU3puYWFYWlFRRlcrWlEw?=
 =?utf-8?B?c3VVRmM5bldxQ29HRURucW9sOGhPaDFjajliMlZqR041OEQxV1NNSjJPVHEw?=
 =?utf-8?B?ZnZzSXVXYit4dVNsT1Irc01YTGlmTTJRWWhleC8rSHRGSWpHY3pBL2ZlV0VR?=
 =?utf-8?B?c3E0Tng1azVxelNCSEhuTVUzSmZqYkU2cC9ZeDNlem9aR3VNWVliTUV0TVQ0?=
 =?utf-8?B?bjMxaFNjTkxpRXhINzJGMXBabTdXaVY3d1ZsUVBoSy9QVUxjZE1nZjJMR0k4?=
 =?utf-8?B?ZnBBZDhFWGFoT0hYNGVoOEU3TEZscmEvUEtMblQ2Qmw4aDFrWk5KZTZjSWE1?=
 =?utf-8?B?TlFESmJhY1lUZmU2dW1nMS9QMVRnTG5GSElOT0RaSVh0VHJ3cmFZcElGTjQv?=
 =?utf-8?B?TnY2MmhnT1JjWkVseUc3RzROcGw5Lys2dU5SdFlpOVg1RE1QOFpLY05nRTMz?=
 =?utf-8?B?SVVJLzRzRXpuejBJTitSdlIxYUFSR0N4VW1sWVJEazM0UlBYZnJTOWROY3Ju?=
 =?utf-8?B?TmJVT3FIVG5WOURCYW54TVlId2U4SU9rNDFCeks2OWhja3p0SFpmbmZtOSsw?=
 =?utf-8?B?T0tBQksySnpLZlNUQjNFcEc3U0dFVFdMS0Rpd0p4dUtJcVRUbUQ5Q01OYzc1?=
 =?utf-8?B?VEVyVVBZcEZ4NnI5QU81VXVZM3Y1UW03RnU2WDZGZWxQODNZaXdRbGJ1RDFM?=
 =?utf-8?B?bnE1ZjdNVWNEcFdWWk5ra0FMMDNNOTRDMEc1V1hxSkxLQVJ2cVM0c3VrcDIr?=
 =?utf-8?B?RkZDL0dZdm5tTUNTK3JrZ2Irbm45eFVlUzc5UWFQL3BacXhGSU1OMGR0UU1N?=
 =?utf-8?B?cVBja3RhTEdLRkhEaGk4Ulh0cTBGK3l2QWJuWWRVTDlsV3FWcnRMOWtSU01W?=
 =?utf-8?B?Q2dLWWpUb3AweGhzTGVWOUxPeURTalgwTGhYOTJONlNVT0M5TFJBUG45VmNZ?=
 =?utf-8?B?MkdEUGdzSVJ2NitnaWh3cEFXQUhIRGNNWUJhMjNXV1M5RFNta2hMZWxiaFZ2?=
 =?utf-8?B?R2hNQzdEVXgxZXprcmp3TzBITDVNa0VaY1I2dVRON1VyWDVDNDZ2Q3VyYXpI?=
 =?utf-8?B?U25sMGtOMlltNUNFZWlwUHYrc3I2bjBaL2x4N3h4dFR0QWFhdmtmazBJa2FO?=
 =?utf-8?B?U2l4NGxCWFk1YWZmakxXZnUvV3JrUmNJaTFHcEZPMVlnbXBvN3Q5SkE3UXRQ?=
 =?utf-8?B?YnNZQm9ERHBiaXI1V2RXM2xjQ0YycGgrUGRqWmd5Um9EcEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3hOaENaUGUyL21lSDVzK1NPRGkwOG1BVjBLOEp2Nm1Xc3hJWitnUzBBN0ZV?=
 =?utf-8?B?VWNOdXduOWVQSHJwYzdybjZFYTdlZ2w4RUpJV3J1aEluOGZtekJyVHBZbEor?=
 =?utf-8?B?QlE1c0Z5QmRENFQvNEpHUDY4YnIyOGFjT3RNazYxeDBjelNWZFRhZm8zK2ts?=
 =?utf-8?B?MGVON0duaE9oU1hKNlROemJYMVVxVEcrSmZsR3U3UnJJeGM1TE52OXVaYUNh?=
 =?utf-8?B?bkZacEFEa3U3OWFpWFdLY2JwLytYSDRtM2FPSWRha2s4ZXBvODVabkhsTmox?=
 =?utf-8?B?WUM2VzdoUFFacncybVFWc0YvR2c4YWJCSzlLcU16bXdGRWh2djljaWltT2lD?=
 =?utf-8?B?b3Y0eDVIazhSUS9pUksyNzNiTnp2M2M3RDkyS1JJdUhlMXdiQ3FhUHFjOWRk?=
 =?utf-8?B?bnJUMmZBQVRHcEtFbThCSy9KclBBNmJLcjFwby9EZEM3dTQxOTlJNHgzMkJU?=
 =?utf-8?B?MFhpQ3ZGOWhqUUcrNmVLMWpXZ0VTbVg0NHBBUjB6K0RLd3IzN1dsNER5QWtI?=
 =?utf-8?B?elVncXpWb0toUUtMcjhKUG5UY1cvNlFyTjdud3hXdWxQVVdJWHRTSnZJeTZW?=
 =?utf-8?B?Z1ZOMHIyR1IzdnB1ZFY1c0JLUjE3VDFlWExiakJBNmQvNFVwb1didlVOL3dX?=
 =?utf-8?B?TUtpWlRXRjZ4bUs3aFN1ZUFBUzVhYkxpVjJKaXJsZWxDZlptY0pNZ3AwcVBS?=
 =?utf-8?B?bFkxTUdBUVVJRXdid1JOU1Vha1FyK2RGaVIrMUhkcVYxck9kRFNSb2xKc3JF?=
 =?utf-8?B?bncvanJBN201TENqZlBJeWMxY2xWbFEwdU5uQ00ydEYra2t2ek1MYlQ0YS84?=
 =?utf-8?B?bUhJa2JKS3RPUGdJZkd3MU5pRENsUWg5Z0NleEpZWDhiSkFGbmw2MGxvYjZm?=
 =?utf-8?B?QlE2aTh1N3RYZG1vTmJ6Z0JKSjc0elppUnRjWTNOdDBIZVM1VWlPSEFJWXJ3?=
 =?utf-8?B?aE9VdmhiK0dLR3BGNEF3OHpsdkdLS1JXMzR2TjJhSk9ORU9Sd090WHNqTFlI?=
 =?utf-8?B?TXhXYUtGUUhVR0F6U0VvcW5jTktvSnUzY042RzlYTmFmS3JUNE9TNU42VFdO?=
 =?utf-8?B?aVllMkFqdExWbGdmK01SMDNoemhsdStJd2Mxb2xYb2hSaG9xSnE2bVNZRDZH?=
 =?utf-8?B?My9uRUF4UVA5Unk4SzhxWEJLUUMzTW8xcUpCZmgyNTZvbzFGcVliQzh5aGhI?=
 =?utf-8?B?Zjk2bGxUb01adlZTVEFMK2g0Y0hLZ2lGMmxjVXdYMHVFM2xIT1FTL21PbTVj?=
 =?utf-8?B?cUtHYzRWQVN3N200bERZNnp5QTJSV3IzYXEwWDd1emZob2ROQ2o5a29PaGpK?=
 =?utf-8?B?S3hVRkFmUkVBYUpBN3ZsRzhLd04zWnMxMUdMeUlWNE5VME5nV0w4RVd0Mmkv?=
 =?utf-8?B?KzIwL1llYkNuaWZuZmVraWpMNjhJVk81T1BoSnVGdVNESFJkcldDcWp5ZGdQ?=
 =?utf-8?B?L1dvcHYrVktlR2MzZlE3aGNXME5qdG91NG5kLzdNTnkyQk9uRzJDWUR4NHpu?=
 =?utf-8?B?bEtTSFY3cDFyaUJ5THBQWTNxSmJvVVQyMkxueG9hWnRSaUZLTHZOOEY3VmpC?=
 =?utf-8?B?Uko4RkRVeEtLZmdpMW93V0xqRmhMaEZGUDhCWExoSDVESlFPV283QjUrbmxT?=
 =?utf-8?B?dU0zZno0WUZqOVZBQjZidk1QYWM4WVFyckVSbzBZczc0MVhJVVI2MHkzMkYr?=
 =?utf-8?B?a05VT3pFUytmK0RPQnBZT1pCeTlQcU0zRTZWNzRqenBTcFhpTWlqRDRwdTcy?=
 =?utf-8?B?NEFNT3ExOUtuMVNXRWlXQTJWb0hqWmowNGlsMW1RWVRsWnNadjRRakkyRkw4?=
 =?utf-8?B?MmNSWEhWMEx2QnpWekdveGE4Vk0vV0pWL1FldGEzeUs0NFA0a085MW9IMWtH?=
 =?utf-8?B?cGpXSjVmMWZpcExGS282aWdEcDErRm1jSzhBTmxYZ2tIdDF0SlB5ZVRpalJo?=
 =?utf-8?B?RUsxcjBkWDRDelRSdWpoWktjQ2FzZ213YkZ6ejIwRk5lYm5DY05ka3c1WTM0?=
 =?utf-8?B?TW13QlU3QmtWVUFVQzZkMGpsRFYzYkxTS1JVaVcxdEw3UThHN3dFWjEzODJV?=
 =?utf-8?B?S28xejd1TjVGK2hNUUFKOXZwTFZCYTduUU1tQmMzU0dLN2oxVUtVZmZpY3p4?=
 =?utf-8?B?SkJob2poMm9Ec0d2N3JPMU9WZXhmL3gxcjUrS0FuY1F6U0R4K3RZYng4MTlt?=
 =?utf-8?B?ang2MVRtbS92MEhIY3cxVTNMSTNSVnlQcEpnSUh3Qk8rVG1paEo1YmQxNnpP?=
 =?utf-8?B?U000S3dQbE9KTEZ1bHNocHdKNjRveE1nQVZqS1RycU0xaG1rdWg4SWM5VTg1?=
 =?utf-8?B?cm1TcnlBSDFzTHNxWmsyNXNoV1p2aXBPT1ZHYTQ5U3p6VzhENVM1aUNtRGU1?=
 =?utf-8?Q?qUtgBiJqUMitKI+BsQ/pIaEcf/96pyvaclFho?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453d1682-316d-440f-c341-08de3f4e6d5d
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 22:32:00.9335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+JR/q8G9I5ttUGxQA6mj6lNwLacshRbjlKnmvdQhcy6X25qYmkluU5GfpRLasxFLt8SkbkOaf3Q0WR2IQb66Leul8Q+UtXIVmLPIEf1iMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9915
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

Hi everyone,

We're excited to announce the availability of the first release
candidate of LTTng 2.15, codenamed “Péché Mortel”!

Only a few months after LTTng 2.14, this release delivers an impressive
number of features considering the short time frame, in particular:

• CTF 2 (Common Trace Format) as the default trace format.
• Reduced memory footprint for user space tracing.
• Improved resiliency of shared LTTng-UST buffers.
• Redesigned lttng-list(1) command with memory usage reporting.
• Extended automation capabilities for the lttng-add-trigger(1) command.

Read on for the details.

WHAT'S NEW IN LTTng 2.15?
━━━━━━━━━━━━━━━━━━━━━━━━━
New features and changes in LTTng 2.15:

• Choose the trace format for each recording session with the new
   `--trace-format` option of the lttng-create(1) command:

       $ lttng create my-session --trace-format=ctf-1.8

   Select between CTF 1.8 [1] and CTF 2 [2].

   CTF 2 now is the default trace format for all newly created recording
   sessions. Babeltrace 2 [3] supports CTF 2 since version 2.1 (January
   2025). To keep the default set to CTF 1.8 for your application, use
   the new `--default-trace-format` option of lttng-sessiond(8).

   The LTTng project adopts CTF 2 because it has many benefits over
   CTF 1.8:

   Easier decoding:
       CTF 1.8 requires parsing TSDL metadata, a CTF-specific language,
       which increases implementation time and limits tool integration.

       CTF 2 replaces this with JSON Text Sequences, readable by standard
       JSON parsers, significantly reducing new decoding code.

   Cleaner trace streaming:
       CTF 1.8 allows partial metadata items, forcing parsers to detect
       item boundaries manually, increasing complexity and bugs.

       CTF 2 separates metadata fragments with an RS byte, enabling
       simple chunk identification without decoding.

   Better trace readability (not in LTTng yet):
       CTF 1.8 lacks semantic annotations, so readers rely on external
       domain knowledge to interpret event record data.

       CTF 2 introduces user-defined attributes to describe semantics,
       enabling automated analysis (recognizing IP addresses,
       for example).

   Broader type support (not in LTTng yet):
       CTF 2 adds native field classes that can improve readability,
       performance, and trace size, unlike CTF 1.8's more limited types.

       Examples include a BLOB type for binary data, richer string
       encodings, bit maps, optionals, and LEB128 integers.

   This per-recording session configuration replaces the mechanism
   introduced in LTTng 2.14 where setting the
   `LTTNG_EXPERIMENTAL_FORCE_CTF_2` environment variable to `1` at
   `lttng-sessiond` startup forced _all_ recording sessions to produce
   CTF 2 traces.

• A new channel memory reclaim operation, exclusively available for user
   space channels, can free memory used by eligible sub-buffers by
   deallocating their backing memory when no longer needed.

   The two ways to reclaim memory are:

   Automatic reclaim:
       Configure a per-channel, automatic reclaim policy which
       periodically tries to reclaim memory for sub-buffers older than a
       given age, or as soon as they're consumed, with the new
       `--auto-reclaim-memory` option of the
       lttng-enable-channel(1) command.

       This new option is only available in discard mode (without the
       `--overwrite` option).

   Immediate reclaim:
       The new lttng-reclaim-memory(1) command reclaims memory
       immediately for eligible sub-buffers of one or more channels.

       Only reclaim the sub-buffers older than a given age with the
       `--older-than` option:

           $ lttng reclaim-memory --older-than=2m

   Both memory reclaim modes are possible because channel ring buffers
   are now backed by sparse files [4] when the file system supports them.

• Choose the buffer _preallocation_ policy of a user space channel with
   the new `--buffer-preallocation` option of the
   lttng-enable-channel(1) command:

       $ lttng enable-channel my-channel --userspace \
                                         --buffer-preallocation=on-demand

   LTTng can either preallocate all ring buffer memory up front (pre-2.15
   behaviour; still the default) or allocate as needed. Choose
   preallocation to ensure predictable memory usage and avoid run-time
   allocation latency; choose on demand to minimize the initial footprint
   for low traffic, for short-lived recording sessions, or in conjunction
   with memory reclaims.

   This feature is also enabled by sparse file-backed ring buffers.

• Before this release, an application terminated while writing to a user
   space ring-buffer could leave a sub-buffer stuck in a
   partially-written state, making it unusable.

   A new health check mechanism, the _watchdog timer_, now periodically
   monitors user space ring-buffers and makes stalled sub-buffers
   consumable again to keep trace recording running smoothly.

   This mechanism is enabled by default and can be controlled with the
   new `--watchdog-timer` option of the lttng-enable-channel(1) command.
   As of LTTng 2.15, it only applies to user space channels with a
   per-user buffer ownership model.

• We completely revamped the human-readable output of the
   lttng-list(1) command.

   The command now has a clean tree structure. Colors help improve the
   readability of objects and properties when the connected terminal
   supports it: the `LTTNG_TERM_COLOR` and `NO_COLOR` [5] environment
   variables provide further terminal color control.

       ✔ Channel `channel0` ❬42 event rules❭
         🞂 Auto. memory reclaim policy: None
         🞂 Loss mode:                   Discard newest event record
         🞂 Preallocation policy:        On demand
         🞂 Ring buffer configuration:   4 sub-buffers of 512.00 KiB per CPU,
                                        per Unix user

         🞂 Timer periods:
           🞂 Monitor timer:  1.00 s
           🞂 Read timer:     Inactive
           🞂 Switch timer:   Inactive
           🞂 Watchdog timer: 2.00 s

         🞂 Statistics:
           🞂 Discarded event records: 23,182

   By default, the command:

   ‣ Adds empty lines between blocks of related information. Remove those
     empty lines with the new `compact` setting of the new
     `--style` option.

   ‣ Truncates lines, adding an ellipsis, to fit the current terminal
     width. Avoid truncation with the new `--no-truncate` option.

   If you still prefer or need the previous (“legacy”) version, set the
   `LTTNG_LIST_LEGACY` environment variable to `1` before you run
   lttng-list(1). Please note, however, that the legacy output will never
   show anything related to features introduced after LTTng 2.14.

• The lttng-list(1) command now shows the total memory usage of
   each channel:

       🞂 Memory usage: ❲●●●●●●●●●●●●┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄❳   19.07 MiB /   40.12 MiB

   The new `--mem-usage` option controls the display mode of memory
   usage: `compact` shows the memory usage for each Unix user or process
   while `full` shows the memory usage for each CPU (if available):

       🞂 Memory usage: ❲●●●●●●●●┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄❳   13.30 MiB /   40.12 MiB
         ┆ For UID 1000 (64-bit): ❲●●●●●┄┄┄┄┄┄┄┄┄┄┄❳   13.30 MiB /   40.12 MiB
         ┆   CPU   0: ❲●●●●●┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄❳  540.00 KiB /    2.51 MiB
         ┆   CPU   1: ❲●●●┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄❳  360.00 KiB /    2.51 MiB
         ┆   CPU   2: ❲●●●●●●●●●●●●●●┄┄┄┄┄┄┄┄┄┄┄┄┄┄❳    1.30 MiB /    2.51 MiB
         ┆   CPU   3: ❲●●┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄❳  256.00 KiB /    2.51 MiB
         ┆   CPU   4: ❲●●●●●●●●●●●●●┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄❳    1.20 MiB /    2.51 MiB
         ┆   CPU   5: ❲●●●●●●●●●●●┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄❳    1.07 MiB /    2.51 MiB
         ┆   CPU   6: ❲●●●●●●●●┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄❳  768.00 KiB /    2.51 MiB
         ┆   CPU   7: ❲●●●●●┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄❳  524.00 KiB /    2.51 MiB
         ┆   CPU   8: ❲●●●●●●●●┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄❳  792.00 KiB /    2.51 MiB

• The lttng-status(1) command now accepts the same options
   as lttng-list(1):

       $ lttng status --mem-usage=compact --channel=my-channel

   lttng-status(1) forwards its options as is to lttng-list(1) for the
   current recording session.

• The lttng(1) commands won't emit multi-byte UTF-8 sequences when the
   `LTTNG_NO_UTF_8` environment variable is set to `1`, making a best
   effort to find alternatives.

• New trigger conditions are now available for the
   lttng-add-trigger(1) command:

   `channel-buffer-usage-ge` and `channel-buffer-usage-le`:
       Satisfied when the buffer usage of a given channel becomes
       greater/less than or equal to some threshold (size in bytes or
       ratio of the total channel buffer size):

           $ lttng add-trigger --condition=channel-buffer-usage-ge \
                               --session=my-session --channel=my-channel \
                               --domain=kernel --threshold-ratio=0.75 \
                               --action=notify

   `session-consumed-size-ge`:
       Satisfied when the total consumed size of the tracing data of all
       the channels of a recording session becomes greater than or equal
       to a threshold:

           $ lttng add-trigger --condition=session-consumed-size-ge \
                               --session=my-session --threshold-size=100M \
                               --action=snapshot-session other-session

   `session-rotation-starts`:
   `session-rotation-finishes`:
       Satisfied when the rotation operation of a recording session
       starts or finishes:

           $ lttng add-trigger --condition=session-rotation-finishes \
                               --session=my-session --action=notify

• The `liblttng-ctl` C API is updated to support the new features above:

   ‣ Set the trace format of a recording session descriptor with
     lttng_session_descriptor_set_trace_format() before creating the
     recording session.

   ‣ Immediately reclaim user space channel memory for eligible
     sub-buffers with lttng_reclaim_channel_memory().

     Get the results with lttng_reclaim_handle_get_reclaimed_subbuffer_count()
     and lttng_reclaim_handle_get_pending_subbuffer_count().

     Optionally wait for pending sub-buffers to be reclaimed with
     lttng_reclaim_handle_wait_for_completion().

     When done, destroy the memory reclaim operation handle
     with lttng_reclaim_handle_destroy().

   ‣ Set and get the automatic memory reclamation policy of a user space
     channel with lttng_channel_set_automatic_memory_reclamation_policy()
     and lttng_channel_get_automatic_memory_reclamation_policy().

   ‣ Set and get the buffer preallocation policy of a user space channel
     with lttng_channel_set_preallocation_policy()
     and lttng_channel_get_preallocation_policy().

   ‣ Set and get the watchdog timer period of a channel with
     lttng_channel_set_watchdog_timer_interval()
     and lttng_channel_get_watchdog_timer_interval().

   ‣ Enumerate and query the CPU ID and memory usage of the data streams
     of a channel with the data stream info API:

     ⁃ lttng_channel_get_data_stream_info_sets()
     ⁃ lttng_data_stream_info_sets_get_count()
     ⁃ lttng_data_stream_info_sets_get_at_index()
     ⁃ lttng_data_stream_info_set_get_count()
     ⁃ lttng_data_stream_info_set_get_uid()
     ⁃ lttng_data_stream_info_set_get_pid()
     ⁃ lttng_data_stream_info_set_get_app_bitness()
     ⁃ lttng_data_stream_info_set_get_at_index()
     ⁃ lttng_data_stream_info_get_cpu_id()
     ⁃ lttng_data_stream_info_get_memory_usage()
     ⁃ lttng_data_stream_info_sets_destroy()

• The session daemon and relay daemon now support systemd's sd_notify()
   protocol, enabling proper synchronization with dependent systemd units
   by signaling when the daemons are ready to receive commands and when
   they're stopping.

• The internal v2.15 communication protocol between LTTng-tools and
   LTTng-UST is incompatible with the LTTng 2.14 one: you cannot use
   LTTng-tools 2.15 with LTTng-UST 2.14 and vice versa, for example.

• The lttng(1) Zsh completion function now fully completes the
   `add-trigger` command.

   From now on, the Debian/Ubuntu packages of LTTng-tools will contain
   the Zsh completion functions.

VERSION NAME
━━━━━━━━━━━━
This release is named after Péché Mortel, the iconic Imperial Stout from
Montréal's Dieu du Ciel! and a long-time team favorite.

Deep black and unapologetically intense, Péché Mortel pours with a
dense, mocha-tinted head and an aroma that immediately announces freshly
roasted coffee. Decadent and dangerously drinkable, it is the ideal
companion for long, cold winter evenings.

IMPORTANT LINKS
━━━━━━━━━━━━━━━
LTTng tarball:
     • <https://lttng.org/files/lttng-tools/lttng-tools-2.15.0-rc1.tar.bz2>
     • <https://lttng.org/files/lttng-ust/lttng-ust-2.15.0-rc1.tar.bz2>
     • <https://lttng.org/files/lttng-modules/lttng-modules-2.15.0-rc1.tar.bz2>

LTTng website:
     <https://lttng.org/>

LTTng 2.15 documentation:
     <https://lttng.org/docs/v2.15>

Mailing list for support and development:
     <https://lists.lttng.org/>

IRC channel:
     `#lttng` on `irc.oftc.net`

Bug tracker:
     <https://bugs.lttng.org/projects/lttng/>

GitHub organization:
     <https://github.com/lttng>

Continuous integration:
     • <https://ci.lttng.org/view/LTTng-tools/>
     • <https://ci.lttng.org/view/LTTng-ust/>
     • <https://ci.lttng.org/view/LTTng-modules/>

Code review:
     • <https://review.lttng.org/q/project:lttng-tools>
     • <https://review.lttng.org/q/project:lttng-ust>
     • <https://review.lttng.org/q/project:lttng-modules>

REFERENCES
━━━━━━━━━━
[1]: https://diamon.org/ctf/v1.8.3/ (CTF v1.8.3 specification)
[2]: https://diamon.org/ctf/ (CTF 2 specification)
[3]: https://babeltrace.org/
[4]: https://en.wikipedia.org/wiki/Sparse_file
[5]: https://no-color.org/

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

