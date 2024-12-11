Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD5EE7717D
	for <lttng-dev@archiver.kernel.org>; Wed, 11 Dec 2024 15:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1733931841;
	bh=pb33ZDxZQgSTUa6G4IQt4S13PfyQdoNvbl6vyYORJds=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=PD3RPvODxX9OW+VZU1w+oOilSphxilqn4J2Jf58XozfMJm4sgGs04WBFHnvxmFRYZ
	 S/+NpU0M1osE3bhH5sf9PS6p+64rngcuqwCdsEqg8fQm3IpYxOdQSnAmCiR9ixD4rw
	 Cstgfyn57/QEDyTNGuHWdqsE9RBeHEi2wVcZ/9/kOK4Z9SxQrT8IZtBkVYozrQJG7p
	 IYk3L/SvbKb5shqcFRfCf/OAWJ1eEzJVnyYzKmqV0nJVVS1e//QtDn9dTv95bZXguS
	 ZW0bFajF+kyM2RRAzzc8PrQ4NgZSHpC8B56wAn4Y2bA9EFRwp+taORNSCFG1Zkl3GU
	 r6aBeDEIitKLw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Y7fz46xmVz1KKt;
	Wed, 11 Dec 2024 10:44:00 -0500 (EST)
Received: from YT3PR01CU008.outbound.protection.outlook.com
 (mail-canadacentralazon11020122.outbound.protection.outlook.com
 [52.101.189.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4Y7fz34bRKz1KKs
 for <lttng-dev@lists.lttng.org>; Wed, 11 Dec 2024 10:43:59 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cwhj8AJT7RoMb6OhBaP8ujZ7AvqTv7zbh5fBJk5/NvVZm/fQvlrnyMEtmxlrmBSAuWC66PYWfuwF1MNWlOEY97DTzb2fsIpgoPK1rUvDv3zmiedTJboBpY76QQNndRj+m+XBryZOAChn1pewxMmvY5vUeG1WRzLGqxacsbyi8l7zW6Yjuhl6LjTVhFVllitgMsfSrvnoO4Ti2+LShsffG29TzhFVSjkbn4xG97txVBAXyb4twU0cL1MAB/622DRBMMjUohj6ksjJtk9GfA2LDz8zM4rNM19Prt+5PsuPuwZfjrbxhdlxAfi3W3kVX7PNrUq3QREHPWVpghSV1MNElg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCwOc5L2g1MxUAWDKNGWYGx3rkjFKjOPFWu1Uh00guw=;
 b=e9EJzy7T1nQUUGG3NHQHqzaQwFK/BKFq9T8n59HQFH9f7StYRkbmpJLgThNrBuvSRZ14wBjq4tX7E3pZwC4MSyV9UGm7rcy6mG93ZghAfSOKu/lOuGapL7ksGqDjvRSKB1nmsCevxYovtbFQcq0ycpgBY2SZg7JqnMY0Nai7xflCIhT1VfpRJEDOUdPlLYh+JfvDu+1cliQyiphRfCiTDO1lhcwfLl5OI/IlP2wpl6CeKiNmob0WjdRtJzL0VLV9rztpKGgFiiCZdiirTHX6avoGJMv8o5Qu1DNqCXZR7YzvskCb4zBsZ3Il++cJ03vDOlNgkcMmZHbnJgkroww5mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB5893.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:31::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 15:43:57 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 15:43:56 +0000
Message-ID: <8b3dc807-e512-4ea9-be7b-39abae58d886@efficios.com>
Date: Wed, 11 Dec 2024 10:43:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: AW: [lttng-dev] Record stacktraces at userspace tracing domain
To: Alexander Krabler <Alexander.Krabler@kuka.com>,
 Kienan Stewart <kstewart@efficios.com>,
 =?UTF-8?Q?Christophe_B=C3=A9dard?= <bedard.christophe@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <VI1PR01MB6845D1C81221547CEC94B3A782352@VI1PR01MB6845.eurprd01.prod.exchangelabs.com>
 <CAAS9dobC0wERGMQf9CLjhYY4ay_zSdAMAE9qxBezLtH-kL_1NQ@mail.gmail.com>
 <7f722802-752f-4cf5-ad2f-cb60264d8091@efficios.com>
 <VI1PR01MB684540CF33FFE72F69417E62823E2@VI1PR01MB6845.eurprd01.prod.exchangelabs.com>
Content-Language: en-US
In-Reply-To: <VI1PR01MB684540CF33FFE72F69417E62823E2@VI1PR01MB6845.eurprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0044.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::8) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b218bf8-a974-4ec6-ddd2-08dd19fa9f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VU5PY2l5dHZBOW9qQnlzd1BSTVdncDdXenlRaHdMbURmTC9lMk1id3FaTDFu?=
 =?utf-8?B?VkVVSlN3cFd0VVlUcHg4Vzg2dmFFa0ppdUxURGFMRXZOalJYMmxkUTZMZVlW?=
 =?utf-8?B?Q2RwNHRveDJCZmJrUUxkWjJ5WEtPdFpUVVBKWUM1VThkcDdZS1h2NUxNd0tN?=
 =?utf-8?B?aHlRaFRrRFNqclQwZXp6MDI5NTM1eTFiTGxQU3NZcnFyMXRpM2RXenNMamNZ?=
 =?utf-8?B?T1A4Yzd5UkIwdEZZbjUyNHI5MFI3UVdFRDhnWFA2TU9obGRCOXNlNitrTk11?=
 =?utf-8?B?Q0hISDJVeTh4NUFVbEY2a3ZxT2RRRHRpSFkvcDRoc3ViUUtmdUNiT2ZaaG93?=
 =?utf-8?B?QWVHdFp6a2x4UFVHM21iNUZ1M3kyLzg5bmM4NzNDdzJhYmhpNnNnU1NlTkxl?=
 =?utf-8?B?eEJIcnVVR0ZnRUJURlZza2RLRTVTbFpzSmk1RXJXQlUxa1N2Q3ZQdFVaRFJC?=
 =?utf-8?B?K0wvVXdDWVhjdlJBNWtjRVZTd1I3ZnFKNU55dXRCUzZMdWdqZ09NT1B6UnMz?=
 =?utf-8?B?dU9Hd3Y2cS9PVkcrK0thRzdZMGJrYklzR2ZuODA0TzRrSVlBRWQvNHIzZ0dl?=
 =?utf-8?B?Y01nNXJ3STM2RzkxSmE4dW5pb2FweFM4MENOSWluMWx3bkZQUVhxdHUvOGZE?=
 =?utf-8?B?VXF4Vk1YY1ArYUQ5UEtPL1ZYRCs1Rlo5L0FGYTYyQ2ZDcUpLNU1ETGcxMzVU?=
 =?utf-8?B?bFhvYThBb3lJOHREd1FQSVh6eGd0MG5veFozc2dXOFZCejhWM1VZOXZtSmdW?=
 =?utf-8?B?WUdiVENrRDRCL2xSajZoZnQ5aEZndkJzLzQvQUhwemI5MDZwdzBkV0dhTmty?=
 =?utf-8?B?cVJoMVRMNXI4U3lBU01sd0hibDU1d0l2bEJSQlBMVGtBVTcxYzhiNUtMMFJ2?=
 =?utf-8?B?UUZFR0VuRWM4UVJiL3l5NGF0Sm9TeHkrc2tKUlI3YmlaMG1pRUJreDBhVy9r?=
 =?utf-8?B?VENJZ3lHOEo3bkk5N09ZT2hSb015aVBtQ2U0NG5RM1J2eXptWWJlSXFKM0ww?=
 =?utf-8?B?MHNvUjAyaTFYRHRyRVJOL1BpN3d0NHBoeEhlSkh3VEFSeGVNSGsxdEY2MWZr?=
 =?utf-8?B?SUZzK2tReldDMXVNcVRFZUE1VXh2OUZCVDFZVHVyaC9sMXRKR1Fsd3ZqczlY?=
 =?utf-8?B?Tk82ZmQ0UWN2UFJ3czMxS3g4aUVic3p0Tmp2NVgyN3h4OFd3SVF3RTBQNXhy?=
 =?utf-8?B?VDM3dWFtaTRuS3Y4ZlFrbUw5V3FaVjFlZUM0enk4bStiRU5VSE9YR01ST0h3?=
 =?utf-8?B?SW1pZU5Pc2JVbkltckRHclVXZXlqUnVrY0tsUWthY1ZlUXd3b3VLeG85R2xy?=
 =?utf-8?B?OGVUYkoyZXFSanl3ME1tK2RJUks2M2tNdlo4ZUJXdXJUb0NCVU9oOXBJSWdF?=
 =?utf-8?B?RXpYbU4wc0FiSVlBS0cwTTZhSnpKQTAyeTRKN3hYMnJPVGQzT3ZHOHhMelVR?=
 =?utf-8?B?NnZ4NjVjSFJ4MTg5aU1SeWM1eWI2RVR5V3Y0WEx6YzBCelBDZFNtQW5PYVNl?=
 =?utf-8?B?MFlMQmRVakFacG1ZdjFGOW5mOGJ4NUVhL2UwaDhyckVLMFhIVVgwT1N1clhL?=
 =?utf-8?B?UlYzbXZOcndwWk5peFB3R2RaRzArTGsyOUdVcEFsaUtCUGpQL2pBdGZwb3Vl?=
 =?utf-8?B?RDU3dVZsVWwyNlA1QVc4Q3ZVOGcwZ1RidXhFUWF2cFloTmRob25zZWFiNGJW?=
 =?utf-8?B?dHdmU3ZNU1VTb3RuUGkzQVhiSHUvQjg1SUxReDc2ZmhNVnRBWGIyUjB3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEcrcjBReUl3Z1BSZkhEeGZRNlp4UWRuT2VRZGtBMVBwNURwczhsUVBJTTFm?=
 =?utf-8?B?Q29ub3I0U3RMc0FhcDJpaENVb1FUWVM3cjMvUDFtUVd2UU1jZG1PM3JRYVVQ?=
 =?utf-8?B?UEJtOEFCVGlYSWU4U2xmTlpBK0t0dU9ENDhNSzdVM1hEMmNpaUxvbW5QSGJi?=
 =?utf-8?B?Mk5TUytjLzBWTXBsNVQyS3Q2UndvTEJ2elVFSXBMYVdNYmNramJOT2pjQXBr?=
 =?utf-8?B?QTliQTFqclczWDZONDJZamZiRm5sZjR1dDdHM05GOE8vRGxyRG50Yy96Z1Uv?=
 =?utf-8?B?RHdUdjUzZXdORFY1UGdFNFdObmNvRVhIaTBEUW5CQUswQklSRVMzclBRL0ZU?=
 =?utf-8?B?VTRsUUJZZmo5VFlVNzRZZ0dFZXZaOFBrWnJiQXpkVHZxMnJKbmFQaUkyUjZP?=
 =?utf-8?B?VTZtV3VuTm4wc2sxaFkxV2x4ZHZDaDNaZWRGemRvUmcwaEV5N0xFWHlGdHFR?=
 =?utf-8?B?bVRQSUR3QmorZE94c0t2NlBIY0lTc3R4dlFkR2FwbTZVLytWVkR5ekMrU0hv?=
 =?utf-8?B?c2x1T2xJdFdoQ3NXRFc0b0EyUWZrSEI0QkRaTGZ2b1daM3VGNm8rTTdhOW42?=
 =?utf-8?B?TnMvRmQxTmZ0aC9Qa3ZaQjZTTmFnZEhOSi84Z2JFME14VWZlcWVXdFlGc1FV?=
 =?utf-8?B?Nm5ZMllpMjN1cEMwOStNV0xrUndiNVFhSW9ZbDYvRm1zZXo3cVllaXVKbjIw?=
 =?utf-8?B?RXoyZXlySHVoSGRpL2E5ZGw5aWVzRE01cnEyNFQ2K3lJeFkwU1lFSjduZ1Ja?=
 =?utf-8?B?MkRzT2IxL0dCMG84a2RLaXIrWlNROU5nYnVnL3hWZU5xeURaS2gvaW1Yems3?=
 =?utf-8?B?K1pSWGJ5WjR4emU5VkJMTm9PNWY1ODV5OWxENGFvUFZmZzdEUU1TR29oMGVU?=
 =?utf-8?B?ZE9mYXdaT0xTWG1OZXl2K0VFcG0xZEcvVUN0ZU5wM3VaVWJudkpyMytWNTYy?=
 =?utf-8?B?aWhVQ0YyQUFKVzVlbHg1cEhTKzJjRUI4SlRqT3NkTVE0Qmp4Mk5COTFzNmps?=
 =?utf-8?B?eEtodFF3Mk5KeCtLS3pCV0N3eHZ6TFZuRi81TCsxb1JhWXZ5eWJmK2RUZWtt?=
 =?utf-8?B?cFlIUlovclRqclNmREhnTEdSa1I5ZFlYLzZYQ2IyTks1cStnRWRqL1dvcURx?=
 =?utf-8?B?VHFUbktXQ2dtbDlVU3FWb0ZQQk8vT05xT29BVkgwT2dycTNMOGVtKzEwRDZJ?=
 =?utf-8?B?N1oyWkNySmhaQk5vTG93U1dWYUl1Q0Z5L2w0Zy82azdYU0txakQ0YlpNMDYw?=
 =?utf-8?B?NjRBclpZUk92NWZPMGRLM3RqUlRwelc1UmwxK2pqNzNrelZEdjZ3TExqY1k4?=
 =?utf-8?B?RHBaMGZWVjhnaDRoYUtTMW5OQndOVzBLc25renhWemJlZy9kNGh5YzRRNEhi?=
 =?utf-8?B?cmJ0ZHFYanJyNTQ1ckdOaUV2VEx2TGcwRUViVllGcW1mU0tLMnNRcTlwK2hr?=
 =?utf-8?B?SzR2ckdXZGJicWtZTVVCRWNIMHQ5bTBQa2RFUG5PelVVd3I4c1ZuQlVRemdT?=
 =?utf-8?B?THJObFRDMTlWQ0N3aEtQeFJIRi9UM3YxNW5OaENIaEhpZVh2Y3FVdU5hdE5J?=
 =?utf-8?B?K0lWeDhJR3hMTURwc2ZrbHdrc3cvR3JUN0JDVDMwR3JoWDFvS0MxU3ZHYjFU?=
 =?utf-8?B?Nks1UXo2Y1Bqamw1UHV3ajI2bUlBR05BMVBla1RQb2JvakRNR0FMN0d0Q1RQ?=
 =?utf-8?B?QmNaWGJPWGRiUXk5cXNodTZTRDl0WTZrTmNlM01GbGMwb1o0d2hDVlpHMm5U?=
 =?utf-8?B?NXBNb1czN3pERkdKZ2Z6SEpjQVNUalhMVU5FMHM0L3NDdjFxaXNxa2xyRFhD?=
 =?utf-8?B?RTRjQWt2SjJEMFpFMEYyUjU0ck54bkxzTkNablN5cll4TGV4YU8zZkhsVjhz?=
 =?utf-8?B?Y0d4bW1nRmRoaElWRkcrQnh6VXBKUTd6UjZIWXhMN2RwVTdUU2lZWGF6Zmx4?=
 =?utf-8?B?MmM5MDBoM1poU05Ra2JwNGYzM0NFUU1QTXJqaDFRSTlnUENZWGRxeW14T1h0?=
 =?utf-8?B?cUJsRUlFWG9JUk1qNFNOYzlpcU4wVVdrN1hROUluSUlKVXRFZ0xpY1NodXI4?=
 =?utf-8?B?WnlWaGdmckNqNFVXMU8zQjkrc2h4UStsbm9pNWZvak16OVpqeHhrQzRLNHhD?=
 =?utf-8?B?WjRLYng5K0FxZWpDYTM2dFYwWVlVZ1dCaS9pcXNEMll2M1Q2REk2TTc0eGtz?=
 =?utf-8?Q?eOtPaHcDNP6yunZzvBSANDc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b218bf8-a974-4ec6-ddd2-08dd19fa9f6a
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 15:43:56.4562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVn9Rsl2Q13lOjV1B9z0/K/tjP4m5jkB57RVfSmbHOxxLT2bnZtW27VYeF0Y++Z/T4rCAD79y1sE0/d8r3jpPB74dsQx48rUUtrm8tOLfzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5893
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

On 2024-12-11 05:32, Alexander Krabler via lttng-dev wrote:
> Hi Christophe and Kienan,
> 
> 
> Internal
> On 12/2/24 4:17 PM, Christophe Bédard via lttng-dev wrote:
>> I did the same thing a while ago, i.e., trigger tracepoints on
>> malloc/free/etc. using liblttng-ust-libc-wrapper and collect userspace
>> callstack information (so that the indirect calls to malloc/free can be
>> removed from an application).
>> ...
> Thank you for the information and links!
> I have looked into it, seems promising.
> 
> 
> On 12/10/24 11:41 AM, Kienan Stewart via lttng-dev wrote:
>> Depending on the type of information you require, it could be possible
>> to use the instruction-pointer (ip) context[1], the statedump[2] and/or
>> lttng-ust-dl[3] for base addresses, and the symbol table in-order to
>> resolve ip -> symbol name in the offline analysis phase with the help of
>> babeltrace's debug-info plugin[4]. While a bit more work for the
>> analysis, this process reduces the impact of the tracing on the program
>> at run-time.
> Thanks for the hints.
> This would be possible, but that would give me only the instruction pointer of the top-level stack frame.
> If malloc and free calls are wrapped inside of functions (e.g. think about std::string, std::unique/shared_ptr for C++),
> I would only see that it's called from that specific type.
> But, for me, it's important to see the context, too, where the string/smart pointer is used.

Another approach then is to add tracepoints within your C++ standard
library functions. Then you can use the caller ip of _those_ functions
and pass them to the tracepoint as "ip" context override. Here is how
it is done e.g. in src/lib/lttng-ust-libc-wrapper/lttng-ust-malloc.c :

#define LTTNG_UST_TRACEPOINT_DEFINE
#define LTTNG_UST_TRACEPOINT_CREATE_PROBES
#define LTTNG_UST_TP_IP_PARAM ip                        <------ this.
#include "ust_libc.h"

src/lib/lttng-ust-libc-wrapper/ust_libc.h :

LTTNG_UST_TRACEPOINT_EVENT(lttng_ust_libc, malloc,
         LTTNG_UST_TP_ARGS(size_t, size, void *, ptr, void *, ip),
         LTTNG_UST_TP_FIELDS(
                 lttng_ust_field_integer(size_t, size, size)
                 lttng_ust_field_integer_hex(void *, ptr, ptr)
                 lttng_ust_field_unused(ip)
         )
)

You can similarly specify which parameter end up being used to
override the caller ip sampling.

Are those C++ functions something that is under your control ?

Thanks,

Mathieu


> Therefore I want to record the instruction pointer of every stackframe (or at least the top N ones in order to be able to locate the "problem").
> 
> As stacktraces are only wanted/needed for specific events, I also consider adding new tracepoints
> like lttng_ust_libc:malloc_stacktrace to lttng-ust-libc-wrapper directly
> recording the desired information into the trace buffer as an alternative solution.
> 
> Best regards,
> Alexander

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

