Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948E1D13C1E
	for <lttng-dev@archiver.kernel.org>; Mon, 26 Jan 2026 14:37:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4f0B262Ydrz1JZX
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1769438224;
	b=BZU6gvAMMiKgT4Y3ok+Upv7iH0r5mjK7yH4kEVcd/L6YFLvSJeoW+4NO9R6W+8WdJ7Om
	 XnOzNdx++BD5IlTAShkOR00KwYX6lOs4wkVmqN3GFEVpPjLMvOMcmW8TFCeokk0MquKws
	 9SUGwvlq8OkVG+5ObmMJzurhNZlyuAIlJ8ioUMNvqYL4JHtf1C4uHRgLC9gb9+CSm0heq
	 /N248nOHIkcFATNH7Sj8MWhkoIUIRSSBUdap+03g5iC/H6rYCeElk6yNQsahTYbsl1Cz/
	 lGxiSNH4il46m3hl0HewpWyWAdKOAi1XCevZVRSeymqAcs1uc5hH/rSUFlY3Z6n7v3w==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1769438224;
	h=DKIM-Signature:Message-ID:Date:To:Subject:MIME-Version:From:From;
	bh=iP/eg7Xz6Cs24zvAj1QvpRrGxrQ97iFkMId48A00qhA=;
	b=bj3mUTB+6bj7VfgiISGq2Lslg+5AlDueyQ1FcgFaFaW19buIEY1uhzpdwNs0t+hpYbz0
	 /71cONVknvL23LAm13KpQt6Qy1iFnelkaK7kHybNBxmLVROj15fDnBfHyxGRucC17tENy
	 qyOzAzG133XEoArKSTXn9sHw1ErtM+GtC+f9TAQS2oN9wXQ9B2FRxc/1gMraJ/WEBYx2e
	 OM/x39Zb7AbIscn/GtSv7XG1lArMwc0z/oEV6LqUka8mOqHNnsxHsdcTpR/jW8TLo0dsD
	 mbzXT/paYz3FP5BleUIW8NOZ2CsMiQ5YpTFfGRT0JhV/C44SUJtT1NuaKus19kLIQmQ==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4f0B262Ydrz1JZX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1769438224;
	bh=HsG55ufMESVV/aiNrdZ2jfaKewg2gMWDPdftdVTh3fE=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=odoIBJYJ2WOkET4m2WkkG66hA6HPts5PVXPEcD/r/1tZIKN4gpu5Kg3soCybDO3eG
	 Zpx2nNFXNg0d+9+6gWQoe5IfPNQPWSxPWg+WnnYwReqoHcSg9yAOVXZzuPvtwpCStC
	 FSvNxn50eDObNRkH78Nuy9RGKpkTNNCHxEosBF02SIJzVxhfQwg2w+YRLnYX6yQRPp
	 S9YXGd0CLnWJ5eSjNs2rFRR7LCKGhpVHM27F18y0lCp+lnZplembnkXfhraHEGUPd+
	 MG/mrqeWyPxgatvSRWKDAiDcXN/Rz+FFSuwb5fbqQ5oh8q0594K41yvVU/EWAevLyY
	 nVqW3nuegztcw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4f0B262Ydrz1JZX;
	Mon, 26 Jan 2026 09:37:02 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4f0B241SzXz1Jd8
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4f0B241SzXz1Jd8
Received: from YT3PR01CU008.outbound.protection.outlook.com
 (mail-canadacentralazon11020102.outbound.protection.outlook.com
 [52.101.189.102])
 by lists.lttng.org (Postfix) with ESMTPS id 4f0B241SzXz1Jd8
 for <lttng-dev@lists.lttng.org>; Mon, 26 Jan 2026 09:36:59 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGU2CRXLqbBnTpNw2RUcGMPsnL7soil538gR5Rwg2Un1wkwSid5GTL2r75Tj6f9oDkw9Wh2zoUc+1pt3FrDbH76CywC5IW+oEV85d+MlEEJBwtV8k3ny0IAYuIxl0QJrbhtlZe29DliRxkY2T75kH24UwMSbSaax2897VBfmYk3ebkbT3IkK6ZUvY2cbJ8F8XpNlNcFkx1CQ+BHqgdwqTpze9oTyPubvUqNeKRThJcySZPWCNYoUcEdkIzKP9LmHCtslSQ5+6B46gHDlsSWgDA/pG5rCOzgs14hsCtPQk3brAfK3+EK7FdO5k79b7y0XrYjuNA3V7prNPSWC81AIvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsG55ufMESVV/aiNrdZ2jfaKewg2gMWDPdftdVTh3fE=;
 b=gN5XfCw53pYksvQTTiUVnMFFTKhZ0enU/j61HWa+gPstP1RXb6GQUG2/IOVTEJ1BJ0CstcYle+p6bDe6Os/1C+PdANjm60tUa5niqwSO7Nd/gOrzlt1pdOi037p6ipHiFswqVWd40o5r17fttwZkqFY56+3FUrW2VV+tYrpaolWGN4jI2smnlFxJObyDKLY50snwS6xHTLByvsTageV1ivOrBX61G9w47Y9f4IS/x+CP97xTBOBbz1524wDUQk4vQiHzcf4/v4yelDLr3Z0CQYw8SFpm/2nsMa2GbCA1KsGWp4FzvF4Fm5is0lD2I/3zXSaKglQ0WFQiKBH3LyS3tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB10748.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 14:36:56 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 14:36:56 +0000
Message-ID: <d08df9ca-65d5-4873-9205-8b58311c3859@efficios.com>
Date: Mon, 26 Jan 2026 09:36:55 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [RELEASE] Userspace RCU 0.14.2 and 0.15.6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::19) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB10748:EE_
X-MS-Office365-Filtering-Correlation-Id: 4589c504-d386-4b3a-bff1-08de5ce85af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zk1vZGJ1Ny92d1JNTTN5U3ZHUzZFQWlyeWFqL3V3MWF5emZQSUE2WlRMcEtZ?=
 =?utf-8?B?ekwxVFo4N2N0VFJjclFHVGtpYjRjN3R4RU9IS2dYOFBLRjV4Ym42dDhNNDd2?=
 =?utf-8?B?WjU0alRYdEF4c0RlelBxUVh1L3l0T1A2RlhwYmpjWTJVaVJ3TU5ybWwrYWN0?=
 =?utf-8?B?WVNWN0NKQzh5RklWb29KME9vQXRGY2VtZlBVd0N1bWRqVFJTUlBVWFhyYlNx?=
 =?utf-8?B?aVovOFlqWVhBQ3IyeUxPeGp1R01JYnc1ek9CRURrT0tYSmNYM1NaRE45b1lX?=
 =?utf-8?B?TG83S2ZhV3VJanpNYTJXbGpWczdBWUZpYWx0T05lR2RRQW1HdU1VYk5SVUpK?=
 =?utf-8?B?RnAwdTY5b2VUdzhsUjZSR1VYZGZTdG9sV2VIRzdaWlE0NmVUVjVoblNyaWlz?=
 =?utf-8?B?T1ZGa0JSczdTWW1TS3owUG5jT3Fyb3NiYTVlRlFqL2x2WFdZRWhPa25qcGJT?=
 =?utf-8?B?aHZwaFRTMDJDVHc5WUJRUzdEYUlVazIvSng0a1djVWFMOFVmYXdqSnFzaTFS?=
 =?utf-8?B?Wi9DMEVxS2Vaa1VPamZ5eVhKUUEyRk5vdjUvb1Y4VzUvRUJEVkxta0QzRU9V?=
 =?utf-8?B?dDBTMWplV093VlZIa3ZCbGxLY2FJY0JaWHZ6L1N6UXBqWFk5TjNydHltT2lC?=
 =?utf-8?B?dGd2dHZrakhPSlFxNFB0TkJoNXpkN1pFYkd0T2xFU1dhRXgyd2RnSVJ3ZVUx?=
 =?utf-8?B?RXZwTnNjVURER2hoT1hINU5KQnh5cmtjbmVlam9KNXBEVlA4OFp6R1V0eEJV?=
 =?utf-8?B?bDYyMlRRNUNGVStNekZIQWtUbjA4L0VhZVFLUEU2ejhyWklzSjNKK0xUNXRT?=
 =?utf-8?B?ellJQ2FRbDI2QjNmUHpEblRKb1ViQld3cGFOa2xoSHNtNjhSYzRUU3hrZVRa?=
 =?utf-8?B?dmt1b2hreFU2aTYyZzRpaU5iQzlTS0VmUEFEbS8yM1ZzbjNtWmxnRkg0VGtO?=
 =?utf-8?B?Ulh2dkhKQ0xhMkJWZ0R4VURBT05GUVJVMWhkV3I0bDZwVnBPWWVTb0ZXVGhU?=
 =?utf-8?B?WVZCZzI4Y2R0MThyUVIyS0dWM2lLencveXp1RWV0UFM3WnZqdDBmNlRDUVE3?=
 =?utf-8?B?K3NKYmN5eDRMZVJDZjJKQXI0SW9ycHZRVXVUMUdZZFNDU2QvNGRYMk5USXhr?=
 =?utf-8?B?MFczdjBvQ1VnSDlGb3JhTnF5UE9xaW44QXYxMXkxUmkyb0d3dVorTGswVFlm?=
 =?utf-8?B?SXlyRUNocVFwRnJnTGpUbXptalRBOHJsbldpT3pnSFMraGdzTXdMamMzRW1n?=
 =?utf-8?B?Vkg3S2MvSGRLWUJmMDF5QkZaSlJEZ2FOTlVPSlh4RjkvU3R0RFJnWDFCbDE3?=
 =?utf-8?B?RlJTcTRYTGFtK1lNWXI0c0h6Sm9FVEE0cm5sQURoTENiaVVoUWg3d1VDZmpH?=
 =?utf-8?B?dm5nSU1qcUpNUlVXdit5T01XdWtJWmtlMnNLZW90MTcvNnh4YkphZGhld3ZI?=
 =?utf-8?B?OGNUcEVsODBvNWQ3U2QrN3h3Zjh5WStqNDExSXVmd09HQnQ0cFQ5RzNRRjVL?=
 =?utf-8?B?MW1lczNqVWEzYW9zQTlmaHV6VWI1UWhlcE1DbVAvUnB5UHdYSC9Ma1p3SkRX?=
 =?utf-8?B?SmQrbVlqV0NhY1krMFcyekQ5ZkRJTFRqRkV5VnZLc3pLSnRvaDFxZU5rWGNH?=
 =?utf-8?B?YW5FWWxLSDZ5djBIc0psazhLUVJmd3lsUlY1TXJRbkN6NnRmczlySGpvS1B2?=
 =?utf-8?B?RWxqZnpqdzN2dWgxNDB1NXhXTVNnRUovU0hMZWIrY3VSWFVFYmo2cVdTVXNC?=
 =?utf-8?B?WjZpdjVKYnRJQllVR0o2ZWplcWF1ZGs0K01pTVhwaXVVaHE1R2NjTkxrVTM3?=
 =?utf-8?B?c0Q5YmZ0aXlhWDd5TG8wVjhONHpLczEwYXVuL2hPRFlBYUFpdE9CTW5ib3FP?=
 =?utf-8?B?eXdEVzhkWUZPcGNvazd3d1ZsMVg3UkdENGR3SmVITTk3TEdNbGZoS0MvT2gy?=
 =?utf-8?B?TDV3TTgwY0FSZFNXTUpOWGVJQ0dNcCtXMHlydi9HaDdyL1JGTDNFa1ZJTmF5?=
 =?utf-8?Q?1d9CHM9bQufiEZN3eoFD0Ti0xUhsTk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2FiaThOYUFKcUF6cDRwbVNaWVhoZUVSaVBUYkUzcUwzcFNJa25ta1ZzQjVp?=
 =?utf-8?B?QlVmdFdpTER6S0dkZHM2SXF6MXFzZXYzNERIZzRJaXVFUlMra1RhWHdnWGNY?=
 =?utf-8?B?TmFNenM2eTZCNk1kNFlOVjZzeWdTbGtJaUxSWUl6TlY1VXd0L08yMFNCTkNJ?=
 =?utf-8?B?aGczUnNBdzdYYlQyeWoyNmVMdU9DcHZmdkJXOGdoVDUxanF3U056eWx6amtW?=
 =?utf-8?B?ci9Rams5SnpsYnVhWE5HZnZDUk0rVVFiQUpZYis1bi9iNUxleHpyaVRMeUwx?=
 =?utf-8?B?TG5NenlOY1J5U2QzcTh2N2puNFdaZWYyakh5YW5TSW04QTEvU0FZRzJ0V25Z?=
 =?utf-8?B?WGFOc0U3MzNoMlJLTHpROGVXNExxZTRUSENnYWdDRmNhR051QWZWV0hzYWEy?=
 =?utf-8?B?dlMrYWhZUmJUUU9RN3EzNUY1WWc2LzJZNG5kNzNkNDdWVmN1WnBOSWplWkI1?=
 =?utf-8?B?c0FyaGhJd2NsV3o1d2l0dmtxNWJwUysrV0RmTWtpTWpFRlU2ZWVyamZtOFFl?=
 =?utf-8?B?SjY5dWVQZkJ0OTVaRHYrSXRzbE5YR3hTeGZ6TkVEaVBMWVV1cXdGVzFFaHkr?=
 =?utf-8?B?Y3lZL2VIMVBKTmx5UU1TR0RyenVwR0gyeUlsRTVpKzNPNnp4M2JKUTJ1Vjdr?=
 =?utf-8?B?S3oydHlkM2V1Q2RrRElKc1JBUzMvSkdKcWVzSjRJSEpDWkljSW9iK1E1c1FM?=
 =?utf-8?B?eVF2MTVxUEtzZkxvNWtMUm5OMU9KMWczZFAycVhVdFRuU2lJUzN2WmxYRXBj?=
 =?utf-8?B?cGE0a2psaVhxbHlXSmZKWjZxTTNISzFobXYwcjV6a21WNFhBdEIyUkRZMTBs?=
 =?utf-8?B?dldwZUtWeldQYVlkNFdML2duQ2FvRjJqMjRnRXJVNHZZSzJoOWRsTmVwMldT?=
 =?utf-8?B?dVVyQk02UEZRUy8zcmJ4bHUrZjhpQUlDWTVtSDdaY052eWRSeExETmhQZDNO?=
 =?utf-8?B?YjdxbDkxbWNqZHJMd1VmRHFzWVR4UEVJbGZYWGVMYndhVlphSUtHUFZUelJJ?=
 =?utf-8?B?STd3dHliVFlMSUFzTVFBMlJPUWcvWWR5bWFzSmJTZTdyQ0dFMTVsem9pTDc1?=
 =?utf-8?B?UlF4RnY5dnY5dkJ5S1p6U1VwNmxuN2NIUHVrL3hKVnhVYkE5VWphRGRTU0dI?=
 =?utf-8?B?MkVjT1pvK3hTcE4yVG5BMGZSZDluWUhFVjNBZ2pNZkFSc1ZKU0M4ZUJIQUhl?=
 =?utf-8?B?blBpcG5rSkJuVUdYNFdxQTRJK3hLMUlQbGpTbFAya2hSTzVlNEpLcVRzWVBK?=
 =?utf-8?B?WERwVDAxYmorWWFsWXBTQ1JxVkd5WGlDZHNldVMxc3NlVHNNWng5RFIrMzFQ?=
 =?utf-8?B?RUdXd1NnT1RuU3NvRHA0U2Urd05JRkphdDlLZWt1R05EcDJTZ0VWU2kyYjR4?=
 =?utf-8?B?RDVUUUdKbmlDMTdiMnp3M2pETVRXWFpwVS8ycGN0clJ6LzEza0VheXFTcm91?=
 =?utf-8?B?TUpmbjVzemhJMWNMKzlMdytSdVU1L1gzRlNYYUl1YUhRMFhEdGxGaktYMWll?=
 =?utf-8?B?aGw5cTVQbWRjbElKUXRKd0dBMTlqSHdVVHpCMkJxbk11L0pubVpHNk9hOXZT?=
 =?utf-8?B?clM0ZW0zMXNUTVowbjhpRk5GK2p5N3pBaVUvV01NbWJ5MVdsVW9IVk02bUZT?=
 =?utf-8?B?SG85MlM0ZFBtZml4bER4d3p1ZG1SMUdaTlU0bEVKcHo1N2QvRkh4QUtnTEhx?=
 =?utf-8?B?RmVDR2d6YlVaeUxRcUNkbnE0UkNxRmxQRWhiQTJFQjdydXphbW5MVk85aTFt?=
 =?utf-8?B?Mm9pOFlza0NPc2hudkkzclBYaXRpbjRKLyt3dnM1emt5VGtyQzY4M1Izamh6?=
 =?utf-8?B?c1RlcFRtWU5SSUpXSkhFYk40aVlFUStCQlVmL3Bzb2pweTFuREc2N0daMDRL?=
 =?utf-8?B?djRTbjNqdG44WGRJYjVoSnJLTTFVVVk1V3d2MldMb3hvRUEydmo3cm03WjFi?=
 =?utf-8?B?dXRqUjZUcXRwNFhERXJnREZzV1BCWWlvSWczQk9lQ1J5OXYwVG0xTUN4aUF2?=
 =?utf-8?B?SlNuYlczcFZTYlVhYmtHWmVUeFluY2JvcEJjSnVnTC9vdnM2bitIeVI4THJ6?=
 =?utf-8?B?SzlPQWFHR3ZNbldoQ1FZVjB4RUZ4RkVlKzRmdHJ2YjZrb3llTytVdXRLSVUr?=
 =?utf-8?B?Y0Z3Tk5YVk9lR1dMR1d2Z3l5RjcrQjhiRlg1c1NXdTZVL0g0OWZ0M0l5aDJl?=
 =?utf-8?B?YStBek02T0w3MGZYVkJodEFHdVNvUkhDc01ib0hhSjRneVNBdG5mZEZiVjUz?=
 =?utf-8?B?OEt0eXRHZHA4a09DQVpsc0Eyb3YwaVZoTmVVTkpTZVZYZ3hqb1RoTmE2K3NB?=
 =?utf-8?B?YmJqcVdjSTFFOFhOQUpRbG1DMWo2NXQ1WjdCRklsREl0ZWgxRlFSMVBOWVo0?=
 =?utf-8?Q?UdCyoNOX990fAExJKj35QTwX2gBkSHcLgSCg9tK24QIPz?=
X-MS-Exchange-AntiSpam-MessageData-1: jC47PMuSFUR24VjbcXIQYVxFFdfIqmNWEZ4=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4589c504-d386-4b3a-bff1-08de5ce85af3
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 14:36:56.2714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJmgtx3OHyBNATHdS2JR6h8OCmntEyYA06KN7kuy6WTVLIq2ndOc3i8alJN89cvdNdqXNFUElRPv+pdSXsdKk214iSugya8aeqaGVBdAKiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10748
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

This is a release announcement for liburcu 0.14.2 and 0.15.6,
respectively for the stable 0.14 and 0.15 branches.

The most relevant fix is for the 0.15 branch, where urcu-qsbr
and urcu-mb flavors were missing a barrier between store to
update the per-thread reader counter and the following relaxed
load of the futex waiting state.

* New in this release:

Changelog:

2026-01-26 Userspace RCU 0.15.6
         * urcu-mb: Add missing TSAN annotation to _urcu_mb_read_lock_update
         * lfstack: Coding style cleanup
         * urcu-qsbr: Use CMM_SEQ_CST_FENCE for _urcu_qsbr_thread_online
         * urcu-mb: Use CMM_SEQ_CST_FENCE for _urcu_mb_read_lock_update
         * urcu-qsbr: Use CMM_SEQ_CST_FENCE for quiescent state update and offline
         * urcu-mb: Use CMM_SEQ_CST_FENCE for _urcu_mb_read_unlock_update_and_wakeup
         * Fix: Only include linux/time_types.h when __NR_futex_time64 is defined
         * Use __NR_futex_time64 in futex syscall wrapper

2026-01-26 Userspace RCU 0.14.2
         * Fix: Only include linux/time_types.h when __NR_futex_time64 is defined
         * Use __NR_futex_time64 in futex syscall wrapper
         * Cleanup: Remove useless declarations from urcu-qsbr
         * src/urcu-bp.c: assert => urcu_posix_assert

Project website: https://liburcu.org
Git repository: https://git.liburcu.org/userspace-rcu.git

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

