Return-Path: <bounce+b7b410.602323-lttng-dev=archiver.kernel.org@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from m43-8.mailgun.net (m43-8.mailgun.net [69.72.43.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD74ECCFA13
	for <lttng-dev@archiver.kernel.org>; Tue, 11 Nov 2025 01:35:46 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=lists.lttng.org; q=dns/txt; s=mx; t=1762824945; x=1762832145;
 h=Sender: Sender: Reply-To: From: From: List-Subscribe: List-Help: List-Post: List-Archive: List-Unsubscribe: List-Id: MIME-Version: Content-Transfer-Encoding: Content-Type: Subject: Subject: Cc: To: To: Date: Message-ID;
 bh=IKwCH7Hb1RZBAPm5JmNL4OfogcYo+FwM7nYPS8SbiaU=;
 b=fJS0Clw4p4YANOE7OeFfk/uV92jQ0zkXUB0+10WjWRXqbd0toesw1dRyxGJVDXPlo75lfpvOdq8etudKMPAs1M+ruDAHu7dO+PCGl7VHT8k14HiT9/UGXCPCzQ/mW1nI95PJzl48fJpFmgsQPzKuUR+qHn/zud1oZIqO9WR3Y97VPK4lzzrbtOjzImnrGcgsjMfYkDWH1baBXj4soOWglEVMYv65a/QWn/0TjV5pcXvt25XYIgobGRvCXtCPkn6dT2vyzaxtvyJnQEpMn6Y4taxaI+fntUrWYaj393ayDjMWFKxPvdixuc5o9TUXUGFx/NZ3p7n55bvIbusujH6sIA==
X-Mailgun-Sid: WyJlYzgxZCIsImx0dG5nLWRldkBhcmNoaXZlci5rZXJuZWwub3JnIiwiNjAyMzIzIl0=
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29]) by
 72d185b9f79fa992ba96db41864d6e439656a86a7a2167f66ff052a38b3f5260 with SMTP id
 691292f10240c4c93e821247 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Tue, 11 Nov 2025 01:35:45 GMT
X-Mailgun-Sending-Ip: 69.72.43.8
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4d58Hf6MmNz24vB
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1762824944;
	b=Xkr7MMV1oVd8ERZIGkU+UZHGHklvwGOvpCobzbXaYR+0pHMCFlEaZG2gaIZs7Sr5aaWx
	 RjRNy8UQ2E9wD+PcaPiaqnxpRnhtUM/reHgHFeTOx8oVtaUO6rBdE3RtprX/qPlgxB3wy
	 nEldhyq3E/ZEV5EdwOL6oaDHa630RHdyF0QL4GVa3EW4sctI1ASwIrAYqcv10H+va2l/f
	 KWX7TF+TpPL/2r6GJiNsyF38mcRH8pFikS1wCGZOVqmhFvDPuucM73d9Xtn6T76OAmVOF
	 EpFG5V5iFcrJqLCk6akSX4qVswUO+IQAeI3mO9TOrjz5LNyNQTwD2lQ7ZwkSKuEHxRQ==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1762824944;
	h=DKIM-Signature:Message-ID:Date:To:Subject:MIME-Version:From:From;
	bh=Ja+9EktsKPiY+BcNnCoc2aRSLVDPdDDg9F7NGLrzP3A=;
	b=A7WyhlY1CAc1c+zonYwWP8JYFwLXQ/d8yfQN2+WM8u4rKhH+2pYJeyzsR496ZIFHmlFy
	 8/xKLNHSFHldngI/Eq4s1CAHxoU1hpWlDFWYUK5Yfueo4JTgRVVtRaMd7RyYpE6vjH7An
	 OQuH2UOdZZwvsbLyCTxTTunTVA8hMmLqL4jmHdTN9wR0xd7QWi3CQqzO+NiyvdlEJ9wxa
	 TrPeuaUSNw5gTAg23FD+2wDE0nMTPqJiVkLo86vQPdvg/Iq5VH0yA+0A2zIxA96O/1Fxq
	 s4vTYxajiJ7sblxdQHTKCUOr1BhQPa9QDsWguKnPpy5bxFLeONuIyE33p2Uli0vawzg==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4d58Hf6MmNz24vB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1762824944;
	bh=Ja+9EktsKPiY+BcNnCoc2aRSLVDPdDDg9F7NGLrzP3A=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=Q12Z/3rDqZoOuBbXWr5I8Q2eQdpDq73dXv1iWKqsOsUJMVmPmoKVtb5Uf3WTwqCQE
	 ciM7Do3TtPGOEH3KEXuSUet1brI0kMh8+3AR0Zg01clMNP4/7zrpM39yHHSjwY94At
	 Ra6CT3xLy3RHvlX4hrKSmgSCm90a5JU7KB2s2pFWIhUsMTguiu1Hwj4NwmK4A3BQbd
	 DcQJ8DHKcEVNYq9lMdqsbhkKK9MBLJtjBB/ayWN7gzfXyO0zxRIV7/eAT0zUGLK4DE
	 2c10Ffw5Jmk5yY8QEnm4Lj7beSwztpynf316i0KteNVwZKCTtlvo6Mv770TNbL7arp
	 6SXlSalltUX4Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4d58Hf6MmNz24vB;
	Mon, 10 Nov 2025 20:35:42 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4d58Hc5CTtz24r1
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4d58Hc5CTtz24r1
Received: from YT3PR01CU008.outbound.protection.outlook.com
 (mail-canadacentralazon11020122.outbound.protection.outlook.com
 [52.101.189.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4d58Hc5CTtz24r1
 for <lttng-dev@lists.lttng.org>; Mon, 10 Nov 2025 20:35:40 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqhVmQJoPwh+XMH+ORfC3wU9CjRVSwbyhr3h7GFCQHBHOfpDXvF3FyWsj5j3j1BFedrZG/v8lxizUpNPd9ktb0rSP+Mk1dOMNmMEZ6vLiwa0Bph2VBFlS7Rq1H4ssk3MCR1j2JOQQghVhH46IMQaf3c+q+BVutHm6mRCYAB699yo5Oxg0R5CVjDydM/TWOuiKXtLirDWlweON9sfkf+f1vYlHhE2JXgx8r/D0qSDUapWuc/Bql7aQdbfqUaEzI/lnHZOWjm+vrMQeECPJM0aGk7yzW5hfa2DOX7fLTbWc5HGJm62XLsSYgDOEfE2x+ERuIJlHGbUmqNJsAbQLIegcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKwCH7Hb1RZBAPm5JmNL4OfogcYo+FwM7nYPS8SbiaU=;
 b=d+lnNzM7aGeV131zx0Sg0u+U4PJNv81fYYXgbFldxs13jMfLPK9FsC2bfHjDaekUFSc9whShD6VuooAdHykpaG6w6vDTnwViE8G4TE1lXogT9cPmNRdchlrCkTftIOsS6Fn7xHkaVw2vhYZEPuZDID+/s+pQuYHkNw6Gvh5Av78JZWdwSeg/9VdN0SIpUzlK2XZl5xte7xY0jg6YQ7r+i/fUXs7its8lYjhNcXeoLISdIZR1anrEOpzzws6t9+F7/K4WiPiSKHRnx+SN1lUdpq6zSqMhgHRrovx2iRxU3xCrbZ6ebHcyqGCGTZ6lftqB87/4g8mA7ZCpu3WOCj3/jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB10388.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 01:35:36 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 01:35:36 +0000
Message-ID: <ec75a1fb-f8f4-438f-a302-3857940e1932@efficios.com>
Date: Mon, 10 Nov 2025 20:35:35 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Olivier Dion <odion@efficios.com>
Subject: [RELEASE] Userspace RCU 0.15.5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0348.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::25) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB10388:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec7d58a-a7ce-4148-bd65-08de20c29cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0FDNmQvN21ieTdGMytQTUFocU0rN0JIZStyVjM2M0pzT05xWnFtOFZDSUc4?=
 =?utf-8?B?WkFXMnNEb2xIb3NGNjhuTWtUSGZvdEFMejB5c1BzN3gzNUM0MFU2N3REaWVt?=
 =?utf-8?B?aHd5eVFYT2had29wNjQxTUFLdy9NbXg2SVhrQjcrZ0ZZTkxOYnhqbXE4cytl?=
 =?utf-8?B?cFNBa01RTldRdnk2R2xyQTM4UUk3eWtRamVQVjcwQ3JybEMvQmExSWdKZU9K?=
 =?utf-8?B?bkJteFgvV2tMV1FXOXROREphaTh1ZzFmVEJYZnVGNHJCUkVpNmRUZWRXUlB2?=
 =?utf-8?B?UmdYRGdyR0NENVNuQmNoVFBlQ0Q4R2xDaHdQYmpqZTlncGRlYjVrRWJGbEg5?=
 =?utf-8?B?YUFESjlOK3UrVVY2YjV1UWhHaHQvbFpBenFWWGZ4dDBXQkhWbUtsbEhPang5?=
 =?utf-8?B?UFdwaGh3bG9xV1crTVN2WURhcHdLUVM3UFVCeHlqc2p4MlVPN3JXanlwR2xk?=
 =?utf-8?B?WXdQUHpPenZPN29aTE02MXRYSlNoL1FLT2VLL3NFV2tVZTZibVFLU0NNRW9V?=
 =?utf-8?B?SXl6ZVh6SzNDbXI1S0pNd2d3aWc2NmxreEU3QUxsN1o5d0hWenp0TitVejRH?=
 =?utf-8?B?TjIvek9wcVgzK3I5bG10dldlZkQrVDRUcVJDcU11M3U5Q2NBcHQ3NTYrWCs0?=
 =?utf-8?B?ZzFEbmJEcSttZmZzWit5WUFLOHIwdmRoNUQrRFVreXBwY3dsN1h0UmNCaWth?=
 =?utf-8?B?TmovM1dvekpLL2l5QUlHeE16d0t0bFo1cVVmbzZQL2ZENWJKZTRKUU5FY3Nv?=
 =?utf-8?B?eGQwOE5VV1puN2k5RkFmYitmMWdBU3lIVVQ4L3NlU3ovOU1xS2NsdVNwcW01?=
 =?utf-8?B?QWxlaURRV3R0eWsyTFA5TjFpbkFBcmx1MFpnTTc5b2RrSDkybFIzL0NMVUVw?=
 =?utf-8?B?ZjNUTUxZWFMyQmVyaThMcUxGR09vZ2Y4Q3RrSFdGdUVmdElCMkRqa0w3QVZx?=
 =?utf-8?B?d0gyUEpPRktPMnFlMit4Z0NpVlQ0SnVWU3ZyTGxzdzRjUUtLaFZsYkFNdFUy?=
 =?utf-8?B?YmVRNjA4OEgrQXF1WXVLM2tTbzV4MmphZFhvM1Q2OGUwa1lKalFtS3gvK0Nn?=
 =?utf-8?B?VlB5ZHZaUmR3emd1YUZSL1ozZGJnMTcyemIyQ0Q4TC9jRHNmbUFKUkcwb3kv?=
 =?utf-8?B?V29KVEE4VnZzbjhQdVpSZUpYRzcxSGY0dVJFaS9pR1o1MjVzTlRCVzI5VGN2?=
 =?utf-8?B?K1RRQXRuYnloa0pqM2s5N3RLaDVRczBpUTZndnV2anZPVDdmNS9GYlhUV0J0?=
 =?utf-8?B?MzB1SVFla0lzK0M2Z0VwQkNmQjEwbXRPK3VZMEUrSk81NmdJMzhHRXFCRTVV?=
 =?utf-8?B?U1pveXUrR25hYlJ0MGlSNXNQczBvakZFY0dPVEY0dmJyc29NNU1tTXBrUjNX?=
 =?utf-8?B?b200K1p6NEdkVW9RbjliSWdyMHgvWWQrNEdVc0NSZmRPUW9vQTdaSGFLVzVU?=
 =?utf-8?B?Z1NzQUJFbjlUTUpkRHBtS1U4YWswdllKY1dudHpWSUd2U1lsSDV3NG1vYlFj?=
 =?utf-8?B?cVFydmk0NWZIZUR4UmkzSG1TUFNScGxWeTZGeEdBSjFzak82dVR5UVVPbm9E?=
 =?utf-8?B?Rld2OUIva1g5VFZ0UlV0MExyakZSaGpocFduQ2kvbnFaMWsyQUdYeU94ZWNE?=
 =?utf-8?B?b3ZoQmhiUXFTQnlqSXJac2txNWRMR3ZCUHQxaHBrQy9WWHJuSEh5ZVpYcHc4?=
 =?utf-8?B?TmtONFpEaGlSSTR0MG52aVJ0eVFFWk9MZEdyTlNsYk5xbDlHcjBDYVRoV2hj?=
 =?utf-8?B?RUNiYzg4azJkY0U5MFBPejY4SWNaaE01VWU2VHFpdlgxazFXVzMxZWNiMGF1?=
 =?utf-8?B?Y2N5cU1tSUVrckU1WUZrOVRZNzk0dE95TGtZVVp6RTJaYlRFUDhXYmxOU0dz?=
 =?utf-8?B?MUdUUGkrQzArMFhla2R2TnVPMDlvTjRRS05waVYvNXB0amc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXJYb2NIczl6cng2RzdxdjllOHMxK2lUQ2Y2Tk4xUlkybm5ua1ZWbERSSGYr?=
 =?utf-8?B?b3ZVUnJZQzRha2piVmJvNHpucDZjT0FNZjFVMmRDd1NhZDg5NDIxdEhUU0h6?=
 =?utf-8?B?Y1VOODNLS2RHYy9FT2U1cDBxMlorNG1udDB1RGRsRmRoblZobnRMa0N0S3hp?=
 =?utf-8?B?NkVlVkZwbStIUDJyTTZ2aUtYeG1KKzc5L2hRZGNOKyt5bStkWGpoM3ptNkZp?=
 =?utf-8?B?VVlEdmJxbURLa0dtc1ZhN29GaFcwVU1yckJMYnlrOVQ1aE5ZQWF5OERBcVY1?=
 =?utf-8?B?RWhxYlpHaE80NWNNeEFvS3pJYnJVNFMyOHU4N3hxbDcyWWVyS3ZRNTBhSjNz?=
 =?utf-8?B?K3h3Yy9YRU40b0N6VGxGajBaU1h2TktYdjRIN0JZVlNqZ0Q2cGFSWHVQZUdR?=
 =?utf-8?B?MTZ5MFczNmVNQTBxSEwwNE1sdWVZWk1TOFU0Nlg0c3ZDNExSdTZWUHAxVURO?=
 =?utf-8?B?SEg5MXJxVlEyOGg0SjREbXlwS1JBVjZtNXltdWVMSGE4QW5Sdy9EWE5kUEhO?=
 =?utf-8?B?K0toODFEb1l0L2h6MlFSbGZDamhwV1Z2UFpQeFpWMElVTklnZWxoNzE2dTRW?=
 =?utf-8?B?OGlMSGRrOGVhTG1LUFBDVjJiVWRTWDNEbXYzQXQ5TE14VVpmMkdIVXFCM1gz?=
 =?utf-8?B?QzBtOVQvT0hVQ3ZsNUpLTENneEVEdFlGYVZNckUwMUpQZ2Z4Vm96T3pVRGlX?=
 =?utf-8?B?R1VLbXRNazRaMTNjUW9oYkVwdFB0UUYwOE9TMGcrdjBGQlpoRWtjZmJQTktx?=
 =?utf-8?B?eEd1RS9YMDd1alJzU1FIWTBXZC9hKzlmK2JYckZlS0FsaTdzQjZzVHFBOGJp?=
 =?utf-8?B?d2h4K1QvSUxEK2F1eTRiem5XUm8vcW9XaWluQThkVjBabGF3NkwwRmtXcTU5?=
 =?utf-8?B?ZnJ6Ry9ua3NtZVFKZS9abHFVUmJqRklzeUU3QmhjYldLWGJUR1lMb0NWRnBJ?=
 =?utf-8?B?SG9HcjRzdGEya1ZlQlpFWTFjcjVOSEhnOUZ6QUJJdlUzNUlVVjFOeU1BREdW?=
 =?utf-8?B?cEhoOTN5NEI2UGJ2bWVMUjQ3TWpUYmdjRldxdjBtT3N2NTJWR01BQm5NdDVt?=
 =?utf-8?B?MjFXTmllNDNpdS85aTZ4OWFaZ2l6Ynp3SXQxQXcyMzlpNnN3dE9OdHVKN25z?=
 =?utf-8?B?SFhEQUtpYjBsenlMY1h4OFl4cUtUQVhqY0JqTnNmUTg1T3VGbWVBM2Q5ODlI?=
 =?utf-8?B?Ujk3dE9hUmVyU0huRVZ5U3JNY0xDaWdVUFBqR3RaZkxqZ0h5VTR4MjhMbHc0?=
 =?utf-8?B?OWVTY1RxQkw2aE5XcXFMcG9HdENWcFFteHZXRVowN1grd1p0S0l2eDFlUEMy?=
 =?utf-8?B?ZVBZazVBQ290dFBoUEp1b3VSSjcrT3NEOCtLMUNXQm9ZTHJtVS80RzNCc2h4?=
 =?utf-8?B?Y1g1cEFaaHFPZjROZG1FcWtmclhxTTFuMkVHV0NBRUxnOE1EYmdhYWl3VTdF?=
 =?utf-8?B?Z3Jzd3hzZkRkTTYxTVJXYjhXazlhOFBJVE8xNjYwa256U3E2dmdWU2VYSmhT?=
 =?utf-8?B?c3ArUnYwZXU5YXIzeWxVV2RmOFVHQjd3STkrVEJZSXJNc2NhTW1qNHVWaWhU?=
 =?utf-8?B?c1ZIS3VJYlRPNmN3bHUzRUJzT3JkRW9KK3dFWS9md0M3OXZZRzMzcU04Y2Jh?=
 =?utf-8?B?eno4Y2d1S1NScXNGMEQvVTEyYXZibjdSUE1WSVFETlhDUzZXRjdpZGFob1Ax?=
 =?utf-8?B?VTJvTlhRZTQrN21oOWdnaVhFeGh4cU9DcjBvREl3ajFIamhIVkl3VnlMMFJk?=
 =?utf-8?B?UGxpODZOeXFHREw4N3FKOWNnck5FUzQ0a0VzVytpT0JNeWhTNERkSDl3Nkt1?=
 =?utf-8?B?NlA5RnIvTFVwSVpmc1ltVXZIREM1MG9XeXZ1eWR4YXh3d2wxaTRvTUdVTmsv?=
 =?utf-8?B?SjdNVGRMNG1BUDlZZG9id0d4T1NUMHJsNm44WE5qd1lMQnJwWkF1aEtrN3Bp?=
 =?utf-8?B?biswWWRiaUxVUXNIM1FIWFd1cFVjdmJKVzB6bHNTallSOHdNZUdMNkQybGhS?=
 =?utf-8?B?ZmY2ZGJPWUdFOXNod0NDOWVZc0c5M0JkUWZrRzJGYjBiZzBtVm0xWkFPdmFX?=
 =?utf-8?B?OUF2MHFxb2VxUGlCWWJBODFJcE1mNHUyVDhmR2dKUFprVFNwd21JWTRMV0pM?=
 =?utf-8?B?RU5US3F3VlpDTkJHejJsTzdLZ0FScmJaSW5WenU4YlUxN0s3L3dTaTN4K2s0?=
 =?utf-8?B?b3NLbmdIM0h1b2d2azltOGRUUWRVUHYzbkFodXR0NHpGZm9LTERmcmtYOFlM?=
 =?utf-8?Q?cizN7AUodi3S6sALVW8DmkxPC61dvo1k8Q75i0zayE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec7d58a-a7ce-4148-bd65-08de20c29cd4
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 01:35:36.1541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSXaZ35NIBnczOmKCjcomSdJRK2ogBdfQuVs4KH/IjFn+v1uUhFs404qv7pi9mfLtI2UZhQn3m1nwRu6Yx/NYB/9V5lyW9owRn6oPQfEhIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10388
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

This is the 0.15.5 release of liburcu. The most relevant
change introduced by this release is the use of
"lock; addl" to replace the "mfence" instruction for
cmm_smp_mb() on x86-64 when users build liburcu without
"compiler builtins" atomics. Users wishing to synchronize
with I/O already need to use cmm_mb().

This is motivated by the fact that "lock; addl" is significantly
faster than "mfence".

Detailed changelog:

2025-11-10 Userspace RCU 0.15.5
         * x86: Define cmm_smp_mb() as lock; addl rather than mfence
         * Introduce barrier test
         * Add test_uatomic to gitignore
         * Cleanup: Remove stray space
         * benchmark: Add uatomic benchmark

Project website: https://liburcu.org
Git repository: https://git.liburcu.org/userspace-rcu.git

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

