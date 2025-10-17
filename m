Return-Path: <bounce+b7b410.602323-lttng-dev=archiver.kernel.org@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from m43-8.mailgun.net (m43-8.mailgun.net [69.72.43.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA19CCD199
	for <lttng-dev@archiver.kernel.org>; Fri, 17 Oct 2025 16:08:41 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=lists.lttng.org; q=dns/txt; s=mx; t=1760717320; x=1760724520;
 h=Sender: Sender: Reply-To: From: From: List-Subscribe: List-Help: List-Post: List-Archive: List-Unsubscribe: List-Id: MIME-Version: Content-Transfer-Encoding: Content-Type: Subject: Subject: To: To: Date: Message-ID;
 bh=UmqPJ5qdbPjMjHZRou+HWVvIygqTCaAE1UnGcpwdZnU=;
 b=jfF2dTdg07K/2vY4dqWPLsar9JWoCRok1Ssu82IMRo1GerEbvdGjc9+hCJDNxpxMhHiRJ+r/JIMcJaq6thONrh9V0Nz7U8Ur9G19o0+gJh0XcAiSMoAsGqzIFHmxAGXlDQPn55Z9Lfj1tv0zc09VCkcuqtn9URtZLRuq+Cj1UD58HrPM60Z1ELMhHruXnwfjeQ3EyALaEG+LZnmktsYBASWdVrKHxqBf3SsaBgI5mBpKoi/Q5njpQrCYAgueJlXVlJ08ltZUjUPovn60GnYrcH1K1vwQILyzCCwFsVHXsh/wrp1ranpYqDOVLpXC9khGJQmq6AakW5+iEywPjQ+/jw==
X-Mailgun-Sid: WyJlYzgxZCIsImx0dG5nLWRldkBhcmNoaXZlci5rZXJuZWwub3JnIiwiNjAyMzIzIl0=
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29]) by
 da2b2495b9919c2c1c256d43026932562654903382eac81d178b058317ddc125 with SMTP id
 68f26a08c703068c96dec0f5 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Fri, 17 Oct 2025 16:08:40 GMT
X-Mailgun-Sending-Ip: 69.72.43.8
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cp8rN5XsSz1T8g
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1760717319;
	b=KYwY/4ZpINbaf8OlvR5sh6hPV6p8gPRa/f1eAqtPMUOiWnRZQ80FHiqA0jFN2sK/+XJx
	 ZmeAL59prjJgHbdzr7WAxxyzF9DGNsRv4mVKnpYae3UxXFspOVtEvzSV+0vcb24m080ba
	 N1ARjrrJUebMCmhYUDeCa70k5x5M1DoYZYHneMjZ+qY/MzEQmP09R8XchhjCsUxthmBLM
	 DOciVqglDFzUDD3X4EYk4T3UL4/HSJ5PvOCnVAASRBnhHoKQaNCW8MHep56wlwaPyCdP1
	 jq6v7HqFCKBOTbiOU4cqNszGbxzLidOhXCa1SXARsgB1AWFmS1F5skn2pxNga2nQb3g==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1760717319;
	h=DKIM-Signature:Message-ID:Date:To:Subject:MIME-Version:From:From;
	bh=x3z7Xu1AhbwLR+BsdPn9olLsHgT3HJLYP/l5Vo6DbL0=;
	b=J4qfbU898+xLtvcd3rOAyEqbCROuNaKzqp8EynI9YXTj4ZcOgohCvfKpWXRzt5o2B8K7
	 12oWfNH7Cx+oNmfV2SFmgh1n+ZORQD1DTFFbp5f+rhh9TarhhBk46gAcXI7y+2ZU5fRtP
	 EVB2zQ0PIJOysPFATW/omptQybxfyEh0TJYipQu9fyFtMMt0ZZtcJZnWEz5ISAOiMh/0e
	 WvolzY5K1NQrBofmkNu+f1QrwtYC1yTwLtxwp6eC+r3MF6xCqN332e/XKr4zam5NNwESN
	 Rhd1FG+uw5b2wvp04HQAs8zG0cMrvUmEikgQNmkp/Xy2mW4IUjooDjFEjUhKThwA+ng==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cp8rN5XsSz1T8g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1760717319;
	bh=x3z7Xu1AhbwLR+BsdPn9olLsHgT3HJLYP/l5Vo6DbL0=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=F1JATzlZBZHoz0Zp71dTfopuEYk18dSWHLZYZpTmVfHRjwWOP5Dj5WIDgJg8HBXW5
	 I9UiVYfa8C3tArdg2wS1Y4z7QpHFR/25VKOHegAxKcBE9SPzs52lr+a/KzznpYUalJ
	 9G6TxwrV12FY/39+u4YeegiV6fXHmzZAoN+geLCjg0CIkjTm9Owb9d4Z/vBbsVQ9Xv
	 wYLzagc+OPG0R5OwSfMdLMsaZs3KwSLHrCsTGKRrWlYwOzhkEPOwxbAJHxaYaZr6z0
	 tgDAaI/SDFbQTWxbo7qHEspUUWESkNICtYYNG9f1ooykenpfMMf/O46jfevqdbDefi
	 HOMcIYuX8Z5SQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4cp8rN5XsSz1T8g;
	Fri, 17 Oct 2025 12:08:36 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cp8rM0TVCz1T69
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cp8rM0TVCz1T69
Received: from YT5PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazon11021131.outbound.protection.outlook.com
 [40.107.192.131])
 by lists.lttng.org (Postfix) with ESMTPS id 4cp8rM0TVCz1T69
 for <lttng-dev@lists.lttng.org>; Fri, 17 Oct 2025 12:08:34 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kpv3+b+tmZ95KJK7TnKrZ16/aD7ATJhqtla9UqTaTRgnxskKXrG6NDYStHj5+BDXFfhaKjf4WfKsop7pXzNptF0v/CHO2WCcn942NqkoIehzKubVX2Ememp5BO8Lar7qkmQElbr9nIy/mX2g1OflEPaEEIUiLkmh/RAZG5aPS2e7cpd5eQjvf6LlRf/xOsiklCW2fHV+qNV9u5JU+21sOCAlBd0Z5xygdpIIU60/S8iqggmyU/tDnQx3oRl3AEfNp+7TycRdBXzaS/dQP+ZmScpXvDfGAb2AIMV83Yf1jBotaSs5DSMXheLWANOH2Ko17zkfjYvowoIYqD0Xm80H9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmqPJ5qdbPjMjHZRou+HWVvIygqTCaAE1UnGcpwdZnU=;
 b=V2XPurHbgk4Y47dM7Z7s9+FX7wii2v2I1LQSRwH4OQR0sOE6t+M4BbEaNU6+abvogGEVU32KAjwypM/h4jySMwBHlxrAZuWWcDKWN55Fg/AjoyWONw66JIp+RD5q0jIUGVC07e+ZattghrjsNHwjz6z7L9Gmdkhk3ces8gs93yCqvKWAczLlkFUPtZegyy7gsysnqfayfG2sKH7knTt4QP46fzO0J6aCiqdLhdg2P40thg3Cu0jhToPZFBAkIuK4/dgjdaEBoomgisxE9ZMkovxiYmal16xfLKiOCQk3vE3SrfvADZPRWi4UOWgr0V535hHBV4VLe62dbKjwmnT3PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB6447.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:43::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 16:08:29 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 16:08:28 +0000
Message-ID: <52d5784e-cb07-4519-9c13-d7585bd5a9e7@efficios.com>
Date: Fri, 17 Oct 2025 12:08:27 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org,
 linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RELEASE] LTTng-modules 2.13.22 and 2.14.3 (Linux kernel tracer)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::24)
 To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: bb6fbec0-e29e-4d1e-6492-08de0d9768db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDgyazFqMEp6Vk1sUmZhRHA0Ly8rZFQvN1ZsRCtwcU1pZUlUMGs4ZUJBa0s0?=
 =?utf-8?B?WkpuOXZ1Y0dIVTZSaUd0MCtrbU84NEhHcXdvTFZWNzh3cHdYWUVKTmZOS3Vh?=
 =?utf-8?B?RnZxVm0xZ3dQb3BzY3ZacmNiazB6a29yeUFJMmxmbDEvODJpWEh3RjdrUWpU?=
 =?utf-8?B?TUxkcjY1S2M1SEpSd3RBVE9ZaVZoOVVoTEtza0FxZ0l3bnh2ZnpUMXJCTEtL?=
 =?utf-8?B?Y2Q1YWVzTFJUTHlxNWQ3RldjUFloMzlTVUNGS2xyZkk3TmNyUzZzbTlmR2l6?=
 =?utf-8?B?QkhwS0ZlTTVzTXZ0RmhzUFgxczgzbDI1L1o5aVp4Mnl4STloanA3ZWpPdGJs?=
 =?utf-8?B?bUtFSnBxMGQ3eVVhdUZBSEtlc0NlYW1MNDE5MHJIK204MVdWSEY5VUgvYWFR?=
 =?utf-8?B?SUxmelVqSXJXK3ZqR3lGcUxVZldrZzNSbVd5YmRvajErS0YxMDJKUlJMMnVS?=
 =?utf-8?B?eHhCYy90dHVPREpsSWxpaG91WGdYdUN0dzcwWWp1ejM1bW1VdStyL3BKbUx3?=
 =?utf-8?B?MWYwK0NiVm1sQ1NBbzdPeTRCelM5Y2xCNGY1dlAyU3dYOTlkUjVVT3hlc21u?=
 =?utf-8?B?dklZakpqTXliYzFBSmQva0RHbzhPTE93RE5nSEZSNHdlQnFMSjNVWnNYKysz?=
 =?utf-8?B?RnN0UGNGaWZ6RFVXeHFrWmRhUXU0THdGL3hFNHFsaGJ6WGxmMXJYWkt3V2o2?=
 =?utf-8?B?bkF0QTl2M3pUS2JpeWpmZHREMktaVCszVExiTFRTa2lRdTVZbk5sM1h2MWxp?=
 =?utf-8?B?NTYzdFo2eWovdU43eUxkVmJiZWM2NUE4OU8wSk5pZU9uSWtSd0lmNGpOYnlp?=
 =?utf-8?B?Z0hlUnB6Z1JDWnF4eU5lNldDUVpHZzBsYnRHbTRUNS9Xc29zNTBPVjNrblNi?=
 =?utf-8?B?VFJHZUVKeFBaTXpQWnBuQjE4bXp3RTVkb25sQzdOSmttQjZGbXJneHRCZXVJ?=
 =?utf-8?B?WGgyZFFlbGMvSXZkMFh4dnlBYjF6Uldqdi9NZDYrQk9lU0VhaGxUMFNlYU5Q?=
 =?utf-8?B?OXEwMVVlaHl0Q0RmK0UvdndvTmFZL0FJeFhGWE4va01YT3VrVS9LTnFIMy9T?=
 =?utf-8?B?aDZ4SVVtNkdpT09FUFJmZm95WnNtUDBrN2RuTDdJNHBCL0V3REFqMk1vOEht?=
 =?utf-8?B?aCt4dzNtNGZid2QxTE5XWHdycUxIbjN4NjNGeTZLdmU1TW9MeG9ZS0VuUklZ?=
 =?utf-8?B?c2QwMEFteWpyZjA0dURLL2hJeVl0SVR3Sy95MkxwOVdoMVV1cWRGaDUxZjhR?=
 =?utf-8?B?bnRzUGVrMUJ5clYxNElRMUM2VFBjQnBBVWJzS1F4dEZhYTNxZ3h3cGorNlVK?=
 =?utf-8?B?bmgxVFUrM09MNTFvcm93dDhXZEx3TzExY29Vamx0elFkZmJsQkZzRVk2VnZ2?=
 =?utf-8?B?Ni8yZE8rWVE1WExtTnkrcFlvN2M2cmdEOHdTVEoyR25uOHIyUlAwNWFSeVVH?=
 =?utf-8?B?bXU2SGt0bGdJbGhQanZva0JSTnN1YnVVcjN3NnBoUThrSHJtTkxXT01nMjNF?=
 =?utf-8?B?SGJnd056RTg3SGVZdThPR0xEVHdYWnlzb1l6U1NNdi9LNXFBNzZGdGFwMkZE?=
 =?utf-8?B?cTRzVnN5YlRHQ1BpaU0veVdydXhLd2VFcWM5aTVRUHVVM2VaWkRNR1ZDd2FX?=
 =?utf-8?B?YUU1NngvREZUUWpwUUFKZXpuUFcwTFhtUVFuZDZmcXhxZWk1UHdOVTQrR0Vj?=
 =?utf-8?B?SzN4TE5pQ3Bld3V2NFRyOUZ0d3h2UmUvSzJHMlRqVzNkM1FPUWNlNy9jYmVM?=
 =?utf-8?B?UHNpT1R6MmVCQXR3T29jclNBWnNiTmtueHhQUG1yd0h5ZENTSDlTV1lxcmMy?=
 =?utf-8?B?OUJsS245cGZBRUlsY25WcE5ObWdPWVIxODdreTdKWGpDRmhUTW8xaWgrQjFm?=
 =?utf-8?B?SUZMNTVLOGp1NWV3MnV4U0RFUmlmdDBGdWUyTFBPejBYSXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlNQTktoVnYxQldJb0lNZXJXQ1k2WW9CaVZYUjh3Vks3Sm9nZ2dHQmVGdEdo?=
 =?utf-8?B?R1FseWJ5UGVUQWVod3krOXVwbkZqRURJN2FCaGtRSUgxRThLYTAxdEhoOVhq?=
 =?utf-8?B?VVErdnRRSmwxYUhocktWUldBbkVaRTFqRXhSbnJHSmp0SkRYRDdoaVM3WHBO?=
 =?utf-8?B?YWVTdHB0M3UxamZ0SGpRd2xHYWVrZU9DMWc5elE4clRybmJnZTFYTmlqYVNy?=
 =?utf-8?B?dzdIZWZnOEF3SDByOCtObEJDR0JONXAxOW5xVm53MVZDV09mR3NmNVZZVUdY?=
 =?utf-8?B?VE5sM3ljcFFRVkhSa2s4cSszaURJYXBSQ04vb2w3Y0J3RE9VMlBYOEdPN2VM?=
 =?utf-8?B?dDFWZmMrZ3R6UDJ4cDNBRzZpS2xrdG1ndXdtQVFsZ0M2VXJScUVtak9EVG95?=
 =?utf-8?B?emNVTVhodGxTZEZUeGFpdW9GdFFodUhUOTNKTWdOTG80NlUreUZRaUROYWZj?=
 =?utf-8?B?NmxRT1g4RDRNNkM2ME5zaHdYbHg2Q05YOGZaOFdVa0JhNy8xVUZmM0N1L3pS?=
 =?utf-8?B?QVo2TG54WEFLbW9jd1VlR2UzUk5TK21zZWNPZFF0ZHFUNHNpN3Uxc1FaMFVj?=
 =?utf-8?B?elZ0QytlL2ZwSG5CVEtJeFBxaEhmRis2Z1AzNnNCTUZXcWMyUVI1OVM5VWE5?=
 =?utf-8?B?S29LeDZSU0NxYUFuSkxvTzVhZ0RHNWFBczhocVVIeHQ1UDJkUnRtV0pBWHlz?=
 =?utf-8?B?dUduQ09VTWtKcVArNjEwMFM1ZklhZ2d5eVNEdXNNeEJ2OVpvb2RHeExzYmJP?=
 =?utf-8?B?bUhXeUlTR1NxQzJjTzNSOC9CNFVvd2lyc0pseFRHZS9GOFJMR2x3ckgzQTVt?=
 =?utf-8?B?dUpHaDJzbzFUVzlZdTJYdTRhTUR6cWZqbFZGQThhZmxISVdnQU1XODhUZVpN?=
 =?utf-8?B?TGJiZzRWTWU5Vnd2YTdPbnE3Mi82MmI5ODFxam4vMWtBcTVsUzErYXd6YjRi?=
 =?utf-8?B?d0FoSjIyWWRZeEZzSVAvM1FzeXAyZGNlUnJWMEtMUUkrajN5UEwrdUlsM1Vl?=
 =?utf-8?B?VE9hUXlkMnE3RmNYamFJWTQyeWU0TEVhSnl2ZnYyQ3FqWTdvY3NYbnBNaDVq?=
 =?utf-8?B?cTMwUXlMb09PUXY3MlNVVFFCS0pXNFo2MUdqbGJQNGE0TGFmVnd1YXNBMU9l?=
 =?utf-8?B?aGc2QWZ5VTdJSXRwdFVYUG9TRHF0QmFGVmNXUldTTXA1QWJycVFLSXkyNEJm?=
 =?utf-8?B?SFdXSFl2S2VDRi8wZCtpM29BcGh3dHEzTGpoU1o1TGpYVU5ydEp1OG5mRzdu?=
 =?utf-8?B?R3hqQXBRWVNHZUtKTnZoSWg1eENqZ1NBd1dVYXRGT3R2cCtuazg4RHFzSFEv?=
 =?utf-8?B?YU1xSzNIT0x5bHpPWjl0QTY4L3JTemMyckJzUWVIZWlnM2MzQVdPSXBuNkRX?=
 =?utf-8?B?dXBuUTZzdDYrZ2ZwT0pJUTdZa2ZNTWF1RDhOLzJXVXZYaEw0TXVGdWx6dmpw?=
 =?utf-8?B?cWg4M2p6VDRxVzFPVWdUbmZSamFQQndLVXl1TEY4OGVHam9XTFlqSmd4S0ha?=
 =?utf-8?B?NlZMVUQ4aGtlcmYrajNRa0gzSXBEa29pdkVMVVF3bzZsQSttc21LTEZyK1A0?=
 =?utf-8?B?QzgyYXNXc0RoUkpMZGhrSlhUcGg2dHdPMi9qNzB6ejhENWE1QlRJUmozNG41?=
 =?utf-8?B?LzAvWGVibzREbC93NXVMNWMveGZ5VFZUK2taUENFVy9FbjJ4Q09RRnlrMDgw?=
 =?utf-8?B?Qkhhd1VMenFjd3FCZzdRejdtZDF5NEs5NERhWTNSWVJUc1Z1bXNNRS9WeDY4?=
 =?utf-8?B?d2RXSkFBS2NqV2NGQjRWQUlsWWRQMlJBQW1jeEhwRVY4V3YweUx3VFFDc2tI?=
 =?utf-8?B?T29ITVVZR3FXN2pDRGV3MGdkM3lqdXlTam1EbExXTVpZd3pHa3pJVVZYV1g3?=
 =?utf-8?B?TXJGSEM4TDFsK1JxRm15VTlzTXRMSE4xTmFBc1ArL3haaUN4MGJ4M0ZWRFlu?=
 =?utf-8?B?bVk2bURseWJyUVBtWnRBcjdWalhJTkY1RURFM0Q5bmFzMi9tY01VWVp1UGZF?=
 =?utf-8?B?Wi9BOHBrbUp4Z1ZSbjBhazVveitCNHdva2hGUmNhb2NwVTI3S0tCRlJ2YlZV?=
 =?utf-8?B?MnNURXJoWldzUXdhVVVjcnNuaEE2blhtVXV2VkNzRzN0cTZDdGliSDE3REM3?=
 =?utf-8?B?RWtWNlpLcWFFNFd6UUcrZURSVkdSM285VlRNUHR6RjZEekNhMXQxdnI3Y01Z?=
 =?utf-8?Q?mcUz7B9BB7LoZByGG/3gmbw=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6fbec0-e29e-4d1e-6492-08de0d9768db
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:08:28.6144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jABX7reqo45g3aq2ptBLl1KUImWuUCHWMLqVzKP6q0Uxniszvvj9VzzYPhmKCLG0b6/HKpwk+5sBxLxLSB+LiMfcKG9VbEuaY4oeUSYShA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6447
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

This is a stable release announcement for the LTTng kernel tracer,
an out-of-tree kernel tracer for the Linux kernel.

The main change included in both 2.13.22 and 2.14.3 releases is a fix for the
get_pfnblock_flags_mask / get_pfnblock_migratetype wrappers for v6.17.

It adds a version gate for the get_pfnblock_flags_mask wrapper as the
symbol was removed in v6.17 and thus initialization would always fail
preventing the modules load.

The fix of CTF version in metadata packet headers for CTF2 should not
have observable effects for end users, it's mostly for consistency.

* Changelog:

2025-10-17 LTTng modules 2.13.22
         * fix: always print to kernel log on module load failure
         * fix: get_pfnblock_flags_mask / get_pfnblock_migratetype wrappers for v6.17

2025-10-17 LTTng modules 2.14.3
         * Fix: Set CTF version in metadata packet headers for CTF2
         * fix: always print to kernel log on module load failure
         * fix: get_pfnblock_flags_mask / get_pfnblock_migratetype wrappers for v6.17
         * fix: remove duplicated MODULE macros

Thanks,

Mathieu

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

