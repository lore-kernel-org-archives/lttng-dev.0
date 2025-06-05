Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284DBC5B543
	for <lttng-dev@archiver.kernel.org>; Thu,  5 Jun 2025 18:49:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bCtlr26kyz12x5
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1749149370;
	b=E6xlM6bCk1qdq7MqVf5Gjogts86+/VnKfsMU38GFzBhVipMLShwGSfr2W8XYloasap6I
	 diYCyhbw9KsS4XQ1yG4GEr23R303dWrlo0V/1fMmsEpEoMZ1k9S05Y0n4ZD6E8kVsWVwf
	 DS6PA8jh80OGqcWJ5UIDdqeEkesUBXoN3zcwKQHBrlTe103F3H2L6Su0HVbTfaN0uwD3u
	 v38rAQQChM0/CZk95XLOgH+7VYNllShiRJQwZO97VGeOsj6xilmC4cz3U9dkDoPy/rUDP
	 uZJ4gyYvOus5Y7Qt5TH8x4oK80Wa/y59IacSm/AdSk3HKVVkY9Kuou06gWDyMTQhIMw==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1749149370;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=iLLkbhTIUh+V1eaXR9/RDBxXVAq6ZsxC429jln5pPVw=;
	b=S1PDhHVqmOrs5f553Y0tJHWpufH9V2DHLwjL3QAQDXQ0PwimEdJ091QRNre3WrWxMUDT
	 2yA1C7KQDOiAuFUw/QI+xAzRbikL51A+UQ7OeZJ9NKvOQcQPWIXlxJB2DhA5gWC9KOBuG
	 +VBsjiXjc9gFGNGxSNvnUFsXU1hNClpWiIweQngmbHGTJIf93hS8DQ+vz9ecqyCzbK7v/
	 6yPdFgBkJ+oLpDUjLAvv4yZ2XoQseZTXHrhqwrQjVwTxis1xnHpybHMiRpz7qJLOQORy5
	 u943MREn7gTZGdwW5XuwH2Rofgzg4y+iGY+KfW732p7fXU4U4d7lsP3WVwqpZBRk7ug==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bCtlr26kyz12x5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1749149370;
	bh=iLLkbhTIUh+V1eaXR9/RDBxXVAq6ZsxC429jln5pPVw=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=d2XkIdmFuThFiPnOWqtJMI7cy/MzzObYXcb7off4jnxx8pWdMgXQ+IXrFnQJ++fNt
	 kXGVyohJ43zsaG7jgfOpJm+Pl9tmC5E96Y7YlvFyiek3wSKTk1dCPT9Jj7wkzd1pd0
	 vA50FmnVUaZxEFT4cLA/plupqwxKvPxXDVhZESpjCCwE1fyD3yxN5qVSXUar1YJEpJ
	 vMRJJQKcNbwVbAJOa3HAO4fVBoAKXOU6QppMULDntthtKVDIN88HqLOUJxOsl4C6pE
	 J4sjBOuVkF65KLf0W6UgMQ6gGmAJdKlXXYnp6+8KXkANNo3lrEenB0VmAnwYkduUa5
	 9DWlNcLk1HgIA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bCtlr26kyz12x5;
	Thu,  5 Jun 2025 14:49:28 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bCtln4Szgz12wy
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bCtln4Szgz12wy
Received: from YT5PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazlp170110005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::5])
 by lists.lttng.org (Postfix) with ESMTPS id 4bCtln4Szgz12wy
 for <lttng-dev@lists.lttng.org>; Thu,  5 Jun 2025 14:49:25 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pb94Y3HTc2OMwEnwHnTS4I9tmhvDoXJVvzB4J9lhmiDeRNhnd86adxG41pMSnRYwfRiKuQ/hyrZNnROjCMxec3+3GumQN8FeC+xvtPA30GtrJVP2yczWzqhbhKzqjfXuW7mzNLLelLWkQGHdBZTMWNoNRYRyIKuaHESBqvprmyEKNIMWkPOZ6XmLSzVZNB+QsL7Wz4CPq02MPWITpAe9BVjrByQyDHUd0dpQgzUKqJWzkzyqXsvC6eu6lzUuV/mczAcjNE+7ooe69VwDrJdl7D+QnDEGa7sZCx7nhtiZfIELucJ1f0++LwqMA+SmcKT3yhfKDnGIUtwn5gK6THQyVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9uxte+1Ft4pOt79knyEn8hTZHyT1eWaEkhhzuE2qYc=;
 b=Z17+Y4VAztd7bYLmlqGeMDB48JvzXm1q55OhxpUc0WQKsbzl7agNK7naoh19HAqa+H5MRU9Ry4zIvCGuY9wFaqxok3WEu/WZUjOshW7/vwcuk92YvaH2GKhNbi/pLfO0ZVTCC9G48kplRZCQOq/0Wrv/6ZfK3Pp4EqoQgOYCOtEDQGKsroHpdpfOnlaurIHwKD2OQzuWF45My4mYY5jgJwzf2zuqF0lTX6ptA8547z+UJeeJmevaoQvypjeNreyA7BJepb+/NihIOcZ8RSzdbjks98tX5wVW2eo8Se9eh8/0dsgQt0nZ2UCqaPDcFn3S5zoHle4ShaDEWQkQ1z9+QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB6347.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.37; Thu, 5 Jun
 2025 18:49:15 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8792.034; Thu, 5 Jun 2025
 18:49:15 +0000
Message-ID: <9e5aba04-2485-4807-92e3-980b62a29c29@efficios.com>
Date: Thu, 5 Jun 2025 14:49:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Function tracing not working
To: David Aldrich <david.aldrich.ntml@gmail.com>
Cc: lttng-dev@lists.lttng.org
References: <CAJK_ieigCAaowdcwmLbkdL1J3eFgHE7t1W=ZKRvoKhgABM46yw@mail.gmail.com>
 <cc6438cc-1836-4983-8f09-c569ee2cf11d@efficios.com>
 <CAJK_ieiG5yDoyg8TetipUJZNMhrpteZuY5CBv5eeUNE18AJq9Q@mail.gmail.com>
 <CAJK_iej5GwQm6pjRuMxDJeYLu+YBjp0NTjh3xzvOCvOJ8aft3Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJK_iej5GwQm6pjRuMxDJeYLu+YBjp0NTjh3xzvOCvOJ8aft3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::31) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 502d57fb-69e9-40ed-f2ae-08dda461ab55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emxkdmxHdlRmeEgrM3pWemNGcnZCM3ZJTjEvdG9TeG96THp2QkVDSEljSVBZ?=
 =?utf-8?B?VGdITEV5MCtEU29TMEJORnBzSDJ4YkhxQ3p3cUFYQ2VLZmJVMTNxbFkrbFps?=
 =?utf-8?B?K0ttUHdjRzNIc0dQUGxBZVRiZ2hya3NDS2xDaDZXWFExblBIWGpVOXR1VG5z?=
 =?utf-8?B?TDhjSU9ldDdVd2JrczROUzRjeXhTbGpUd0hjRGxDckhlaE9rbHEyU2lMK2Y3?=
 =?utf-8?B?TUNxekZqdTN5OG5rWnQ4N0ZFWVFBelpQQ1JraFRYOThkakZWTmNqY0ZMSVpQ?=
 =?utf-8?B?YVZWQ293ZmRrUzgwUkVhS09ZSFNXUnpVQmVzZEg4cys5Tm1sRmRDSkFVUHVJ?=
 =?utf-8?B?MG5hNHpQUXJ3aFhaSGQwRmxrNEZLTUowU2RVbFJSYnJTRnMra3hyWC9KK2ph?=
 =?utf-8?B?dGxKMDhpOUlxVktVT0IveXZ6MlRzbkl5TVRKenpYbDRvNlFaeWt3eFRESmlN?=
 =?utf-8?B?UnZ5NVJGTklmcVRXT1dWR3hpczU0VWZSTWNCaHo4amd2RDlkSG95bVNUUjQz?=
 =?utf-8?B?ZFBYWWxqUDI4T1NTbFVQWEFuSkNHaHBSL3RVV3AyaGpZam9EQmQzMUx5M2NR?=
 =?utf-8?B?SXlrNVR0clhqY2p1WEtZWlVNVzgyMWJEdXBaZitZRVVIK0hrTmYyalN0bVkv?=
 =?utf-8?B?c2puZ3cvUS8wT2lOcm1DelRVYmJ3TVJJbXRvNDlFYk1RaVpVY3BTa202d3Z5?=
 =?utf-8?B?TGVHY3V0QXlmNVU4QjJweFV1ZVV0eXBQTEF4NzJuaGloemtjMkhRR09Ka0w1?=
 =?utf-8?B?cGwyWEtCb1FqT2FjS3JsUktaRUlrK01wN1NYZzFDblRGZExTZmJoUHJCa1JE?=
 =?utf-8?B?cEFBL2NKYW9zanlWbkFVVWNlVXlZdVhoWVRJSWRVSDJISkdlRTVkcEdpaUo2?=
 =?utf-8?B?R1F2Q0prTlZMeVZhSG10VmpYTGNaRXZCQmhCZEl6Tk1tTmwwQVNCZG1NanZO?=
 =?utf-8?B?Q3JvS01wTklybVhQZFcvTXpONW9IUUlZanl1VUJXekxmQU9abEIzWEpDSm04?=
 =?utf-8?B?enl4WTBvekF2M3VYQTRoVC93aVBLLzJrTElzVW54QmQ2cGdFSWlkVUtYQ0Rv?=
 =?utf-8?B?d1N1YVI2S2hXbmF3RmVvQnd0K0Q5cVpYOXgrRHRYMmg3SGl3RFEzd2Uwdmxo?=
 =?utf-8?B?UUYra3o3bFdXT3U5Q3B2dWw3Qmh4aldSWGhtcTdaYVAxMnR4Tk5BaGpIQUJW?=
 =?utf-8?B?ak93NlBjWWEyZzdOdUxqcm9aUWVUYlVHME1tVEwyWGtmcStUQkR4QmUzbk0z?=
 =?utf-8?B?QXE0YWJEMWVrYkZrZkE3TDA1eG1ualZFTnpnckJPbmF6ajlXNUJ1Mm10QzJq?=
 =?utf-8?B?cDllUytUM2JYR1FwTGNnZjBzdytZSnBxSEhSNnJVdy9LRXBqL3ZaalkyMFNz?=
 =?utf-8?B?TnczTXAycE9uVnJ4akNXSEw1OE9qSUVDNE8yQjBTTXFRcHRpNHZKS2FYZ2pu?=
 =?utf-8?B?eWpTbndGaXRuRlYrMmp2d0dLWFBUY052ZlFMRUFuUU00ME1XR0sxS1BDdk93?=
 =?utf-8?B?VVVjRVpMUVNZVjlVZUZlMGNqbE9CSUNVekdyYSt1RUVLTjc2N0lBVTB2ZE1s?=
 =?utf-8?B?NHhYeGpSYkNRaTR6WnBGS0ZkVUZodWdBa0c1V2dWb016R2ZYN2FXM1pPRmZk?=
 =?utf-8?B?UDFCVWVLS28xT2krVk1icGVrS2NiUXRORCtWOW1jKzZpSEg2eXFWWnBIdkM3?=
 =?utf-8?B?YWxMWnY0T3A0cEprb1kxeFk3SEwzaThMSTNiMXVmWDNSZHJFSjNMMmQ2M01T?=
 =?utf-8?B?UDZiWktMSzJ6SnF5UGowREEwMlEwY3VkZ3Ezcis3WXJSd00wNGxNOXpKRUUz?=
 =?utf-8?Q?fUenNQX8+H/Lsni6BHPYHjXoQxY2nbUI9qRWU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2gzcG1YRmh1SXA5ZVo3WU1ucDQzeUhjSEZLSXh4NGk3REFWTDFFbGpDclVz?=
 =?utf-8?B?QmxZVG50RzZGQXdhRmhFZVJOR3BJa3BZbHZ1OGxsNElSZVg1c1VnbklGbVdD?=
 =?utf-8?B?b0tOWEdubm1XU3g5dWJLMWo2MUsrYnNvUSt3WDMzUVZIRHJ3THBXK2tONHo5?=
 =?utf-8?B?cXNkUkE3Q0RpTG8veTlZcFZVY25GWjMvSE8wUVlicEhWemNxdS9sZFdvdUl6?=
 =?utf-8?B?VzV4cUZEYjlDeGFmRnhCM3oybUllWlNES1dKSjdNWDc2OE5CVTRHdzNjdStJ?=
 =?utf-8?B?Y0d2U0htRFF3VjZldXRpRUdvU21Ca1RKeHRZazdTZDdlS3MxeStDT3k0ZGVi?=
 =?utf-8?B?VVNqblpzaEtXU21JVXY2N0VUMnkrTFpTSG56SXcrUWtBZHdxNVFNYnU5bGxM?=
 =?utf-8?B?RTZ5b2oxOUZ1cGNSM29TTFNYK3NUQXk2ZjRZdmZCU0NGclJrK05JTWRPdmRv?=
 =?utf-8?B?bG1LV1FrVnhkN1JIR2x4bEc0WGIrQmFNU0ZGV25Vd25LUzV0Znovb0I4NFQr?=
 =?utf-8?B?YXJCeVNwR2hRSU12MDB1QnNvdTJSbjZ1UG5PbXhBU1c1NjVodXpXRXk5V1c0?=
 =?utf-8?B?Tlh3bjFmTVJNbXYxSWp5ekN3VnM0Qll4QVhqL1ZFTVFaMWhlRFB0aWg1Kzcz?=
 =?utf-8?B?bWtja21qN2pUb3ZtM0lOMm85UW03TC9vTVZsRzVpNmVJd2tZRUxud2JzVnor?=
 =?utf-8?B?K1AvRkV6blc4TDljSG0xMjBXcjBhVkRzK1dnZlF1ZHBTSTRyN1N6bWRMRCto?=
 =?utf-8?B?Tlhaa2I3cmdDQVVBempVbFNTQjVDTzRHNEpUOHhSNDYzS3NHVElpNWNjUk5T?=
 =?utf-8?B?L1BSK3F4N3h3VkZhMWMraTJ3YU1xMmFQN3Q0YTc4RWRzakZTVldkWXR1QjVM?=
 =?utf-8?B?ZEhVT2ZOV2VtOEN5cVgxSzFRaTFoaHhLS3JRQkVya0F2Mmg5Z0hhSmpYYkFu?=
 =?utf-8?B?RTBKVnVNMHArbWZjMk5FQkZNdWZ5Y1RxUlpHdXBCRDducGRMRDMxUzFpc3Jq?=
 =?utf-8?B?Z25xWnBFN3VVdUIwSDdHaGdmWUNTTVlkNkUxQ0dCbkNvRHdTVFpPVTE5S2ht?=
 =?utf-8?B?WDFKaVE2b3FLTWtHMFliT2psWC9oWk1DKzdxN0EvanJ4NmdRa2psd2xWWG8w?=
 =?utf-8?B?L1VXUFA2S1k2S21Ic2lvQm5VOGQwNnRWcmo2c3VpNkFyZGp4Y3NXWE5TK0Vu?=
 =?utf-8?B?NmJLem5MTGVUZFNnN3RPRHV6ZTVxaUZnTS9lYmZMV0tqMTYyeWp4MDhqSkU1?=
 =?utf-8?B?T1d4TEJWcEV3UTJKZ3Z0RXZjU1pnRTZKNHVjY2hrcmFaZUtzQ0hYVEJwcXgz?=
 =?utf-8?B?bWxDbWFFNi85SlNYTmk1TzAxMzBuKzJ5a3dpRnlFQ3FITlAxNEpJUTlxeVUw?=
 =?utf-8?B?ZmdzT1ZvYlV6SFBpM3hJT3JML2gva1pqWWczNzNhY3l5cktwSEt4S2hwa1RY?=
 =?utf-8?B?anlLS0grcVEyT0ZpQTNBd0xOWUJ3cVV3TWo5YVNWOFgyeFVzT0RlRVAvWEdT?=
 =?utf-8?B?ajZMeHJRMmZEdnlhcXVuWmJ1R1F0VlFMN082M241WGZtUG9VeGc1Q0IvUHVy?=
 =?utf-8?B?VU9KNmJvS2hqeUtmcVRqbm54eUZ0a2dMSkhKWmR0VXlwMUFmT1hqQkgzSmlv?=
 =?utf-8?B?SEg1MS9ZY3FvdnJOOW1KQnV6aU4wZUZ3T0Nsb1NUWjNzL3VVRGxQS09IU2pj?=
 =?utf-8?B?aEE2Mjg5NUV2SUNISWVhRG1hcVNqdVhGTzZUclVGWCtPa01hdlN0bk9LUjIr?=
 =?utf-8?B?bU83QzZLblc0Ylk5UFNuQ1F3NEY2NURUc0NrazRFbDVUYS9zUkZjVm5ZUElF?=
 =?utf-8?B?d2JBZXkrSVl1Ui94QVgrMlRDd09kV3NUTE5vdXgwTW54M1F1cmRVK09CemtU?=
 =?utf-8?B?cmc5aWcwRFpVQWNwWWlOSGpGUXNUb0dyN0lFdGJjMHpxaWs5MVFPQ3JkeVlZ?=
 =?utf-8?B?YzJ1OVgwVTN6RDh3cEpmYTN5d3BvNThtaitaMXhUcDNvNWJxdHZibGhSRUd0?=
 =?utf-8?B?Ylg4Y2RIaTFuNlVlOUcrTElVdGs5aVZWUTYzczJVaHN5RHczc05MSU92Y1Rs?=
 =?utf-8?B?VXFSN2doUkh6SHB4enpuM2YrcEdiTGxzeXpVUkhCTFE2ZkhCd1YvS1UvOHZN?=
 =?utf-8?B?UUJCYjJodHpPb0ErZ1VuSkdiQUpyVHYzdGRNL25RU0gvd29ld000NFJEdzFv?=
 =?utf-8?Q?jzxHfFuTwhGoz4OJsQ3hagE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 502d57fb-69e9-40ed-f2ae-08dda461ab55
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 18:49:15.1230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/ovTBW5xUqtyrLUGNTaxKeUGLbAgnEc6F5W9oKla2dd7ernyNmopTHpyzYsUGEfWn/MOV+dwq4ZbScyQ1VUCxpXPE4xMgDnZzO4liJ38mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6347
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

On 2025-06-05 06:49, David Aldrich wrote:
> Hi Mathieu
> 
> I'd like to add some more detail.  I now run our app using this pattern:
> 
> LD_PRELOAD=liblttng-ust-cyg-profile.so ./app
> 
> On importing the trace into TraceCompass I see:
> 
> "null analysis for LTTng-UST CallStack"
> 
> Could the reason be the lttng commands I am using to capture UST and
> Kernel events:
> 
> lttng enable-event --userspace 'lttng_ust_tracef:*'
> lttng enable-channel --kernel --session app_trace kernel_channel
> lttng enable-event --kernel --all --channel kernel_channel --session app_trace

Indeed, You will also need to enable something like this:

lttng enable-event --userspace 'lttng_ust_cyg_profile:*'

See "man 3 lttng-ust-cyg-profile" for details.

Thanks,

Mathieu

> 
> Best regards
> David
> 
> On Wed, Jun 4, 2025 at 5:22 PM David Aldrich
> <david.aldrich.ntml@gmail.com> wrote:
>>
>> Hi Mathieu
>>
>>>> Any idea what I am doing wrong please?
>>>
>>> AFAIK, the "LD_PRELOAD" environment variable is cleared by
>>> sudo when running its child process for security purposes.
>>
>> Thanks for your answer, that does help. However, I have now adjusted
>> the code so that sudo is not required, but when I import the trace the
>> UST-CallStacks are still strikethrough.
>>
>> Any thoughts why this is happening?
>>
>> I don't see any runtime errors whether or not I specify the prefix:
>>
>> LD_PRELOAD=liblttng-ust-cyg-profile.so
>>
>> Is that expected?
>>
>> Best regards, David


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
