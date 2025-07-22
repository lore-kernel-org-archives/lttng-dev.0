Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E43C83F1A
	for <lttng-dev@archiver.kernel.org>; Tue, 22 Jul 2025 14:05:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bmfDX1Rx9z1YPF
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1753193132;
	b=eG/AOy4BWfv0s4YEvEvtXOXfMngqFSA+5wTmTXjClNx8sH7PC7Sw/5CWW6NonKbsUHz3
	 5IZa4k2J1pV/tSBP2OleuYvW386ESHx0WZ4OL0XiymfKIXNfHh3oppQwk3HYbiExjQnSi
	 QQv1nvp6XeWd74HldYw1Qd5ofYFPtK836TNkJ7hS6mUFyLwrjecFDK1wwvWkw1S6KjHAF
	 EzYvnUDNVZ+mC0pSj4ZIIhBSSjthyftSjzDUfV+Q8y1TrHGfX2vMx2L+uouLJl7Le48nw
	 Xjc1S0zxSEeRgvnII+s5Fqb2xZFuSxv73yothdiq12MI/Z4TuYPcbuUcfrI6VXs8fMg==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1753193132;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=GezCmeE23buzaw40j0okfuKQMte71dj4pulKaMQFM8U=;
	b=qCfAptgALxkUG7th1lyfseoXspdEWgPODJLtx7vYP40p6NrEZO86E2n8EMmWlU43WprU
	 XwtAhd/SRSYOwm/7QT3H3Zq1F9VtSGIBRMteZk5MPfyRcnHoTg7M7XASkqaRI+tp4p8oa
	 14ZqIfM6/Fo7WNqMNidItPXMPm3n0rv+VH0oo/IkYUTZYp5+FDTL592EkYnGhxnbxuFCx
	 bS7heasw4DhRn6n6gG0rBDpdrVsgKPSvLRcLiYPp8/PNlbPkM8OnOSxDkBmxfTc1Sm9YH
	 yQuAK+OVNwSWXHwaNoELTgkw0qcr9fOj9GaxLLgDl28uhEAMlK4hENyhj75DiRZOtCQ==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bmfDX1Rx9z1YPF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1753193132;
	bh=GezCmeE23buzaw40j0okfuKQMte71dj4pulKaMQFM8U=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=JS67/i8a1aHlTKf0plRb9jra9BIQPdD6OKjg391vDyvJTeNHSoteyKd9moBSuu5MR
	 84838LcCWsqfzq9UTpcKfpPA7XW9hD2rvBF+O1+Z2Gq0NBokLwByxnHAEGlj1GlfF9
	 FqPMdikUQ1h86IQEpIo+RZdzXKFBPInW4XWzqbAVv3PJHLJUx8+4pGVYlWgn+hhnXE
	 5GHOSmuVGd7NwqMcQWWHPlSrN53BmqnG2hg7ipRClUhVgdcYucMT2FGGa55mwB8P6m
	 7JkSldBDgNKWlCUpdfZjVEUSTNukEdj9h0w0jfGqQswKwMbO3DgxR1RujHpC6H8fRv
	 //UB2z0G/+N2g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bmfDX1Rx9z1YPF;
	Tue, 22 Jul 2025 10:05:32 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bmfDW3hHrz1Xks
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bmfDW3hHrz1Xks
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2113.outbound.protection.outlook.com [40.107.115.113])
 by lists.lttng.org (Postfix) with ESMTPS id 4bmfDW3hHrz1Xks
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jul 2025 10:05:31 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+ypOmeVOkOwKucNx4vJHBYdHJrhAIvaDpTiV6qrVnVjUNUMfm2S2KvrDXA9YRZzCRytA4khdl+/iqtC2aU+dWh+DSNwsX4Sn02D0N5MzYo9TqngeK9TiRAUuoV586kYPvZpwwMu0fYLric7mRKxspWaGEODYtwjRXMpV7Zg7JVsxJPNs6k1Vf95RGNwQOpcb8GAJDUZgLiedT15b7LV6BgjmnrIMgH4gOdYw48jkssBpV39Ag0nvNbjvfukQ4FKp7TPLa5QQjB6MrOmOSLFRK9buHX7wCXVIdhCmRIIfbL7ASeUvOgOsv0kufRlwNbIOjnzRq9P6MMxq0oGPEwOdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnXNn08MoGf+ExZDlwfHUd6JA5Vdo3CMcPpgh/+oL9c=;
 b=qab41zIs81jGECiO2zIvLI+WGplIAXbKIV81bRHnMPvajcSGosOg0wooHP+8hB+0tPBA2imlakXyKCSAIvbgwRkksNodIhdERekNgNljIJjgms1V+47ddKTzgFHxRHW8EFsYMue8zGn0GhSus58Aj+pIedhuyUJ7YAUK1vGmHgaK8AGJK/ovo8xijhf/hS7hvdmB+5VJOejjJQwBeaEUJLAhiSyFlZ3pdMcfTB+yWshGwblTLGKlRgN9sbi2O+2LkGyzDk27t6S+KCNVs138iJ71ZK6idSf+AbUC1RyCSbHGh2UYStlW5sOd40nX4p5zz3DGET4R9ya5u+GUn7uWRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PPF75F8989C2.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::550) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 14:05:27 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 14:05:27 +0000
Message-ID: <cf3fa94a-fcf8-430e-83eb-b93fa4788a43@efficios.com>
Date: Tue, 22 Jul 2025 10:05:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Integrating QSBR with libuv
To: =?UTF-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>,
 lttng-dev <lttng-dev@lists.lttng.org>
References: <FBE0CAA6-64F4-48A1-9F69-ECDB6B5E809C@sury.org>
Content-Language: en-US
In-Reply-To: <FBE0CAA6-64F4-48A1-9F69-ECDB6B5E809C@sury.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0009.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::7) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PPF75F8989C2:EE_
X-MS-Office365-Filtering-Correlation-Id: ca273b85-523d-46f3-df87-08ddc928cf4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGxIVkZWOEN3T0wzYjh6MHQyRXI1akVUdlhoK25pdlFocEt5all6UjVOU1lv?=
 =?utf-8?B?MVlsVkVNZVFlNVdoR2lNY1hzZFdLRnlqSE1zSDByUmdOUmRTdURKNFA3YTBP?=
 =?utf-8?B?Mm1WSzRJNy9aRDNjWndWS1JwbWxZQjhNTVdEbnBrUlQxTDgwVGN2UkpqbWVU?=
 =?utf-8?B?RWM4OWt1bnBOUzlSM0lmWlovMGUxZHJteUVYektOWTVwaGRBbXBzYU80a1Vh?=
 =?utf-8?B?QTNRc2pKNGhqQXRqUm9qKzhscjNIcFlkZ29TVlhDN0hFZE11ZG1leXdEcFd5?=
 =?utf-8?B?ZHdCUEs0a0lYN1JHbnY2YkFUL2lEOHBIQ1RQYTN3MytsOVVZK2dsQlJoS1dO?=
 =?utf-8?B?VWlCVTFZa2xnemloa3dvQzdSblI4cHJrOXUvb3V1Y1BOckRWN0ZDQ1l3Q2pi?=
 =?utf-8?B?aHFuanpKRkJTWXNVMm0yL3R1YmhybGUvSENYdU40TkFVSFpXSHhHbDFKNEo1?=
 =?utf-8?B?REZ1RmwvcndRcWZ1RHZyd0h4d21xdmV0WkZDZ0hvTE5oMy8wRjRKamNnbjZp?=
 =?utf-8?B?b1VDVUEwaGZ3aGtwVHVIZGlMeURJYlFiTWpnejdHV3N3MDkyaGV6S2ZUMkRT?=
 =?utf-8?B?YmRKbGpXM3g2OTNpclA5TXZCa0lVZWUzL2RFQTJYeXhSVDhLZHhTT3VNNkEr?=
 =?utf-8?B?NHBvbUMwS0hsdGN3eTZiMmwxZEVmS2c5NC9PQ1NZdkxibENJTmdaVEhJeEE5?=
 =?utf-8?B?V3RpRXBCNUY2cHdnRFNycHV1VEk2VG0zNS9ENEpVWGJ2UHV3d3UzZDE5SjM5?=
 =?utf-8?B?UmNrcCtUTGREdUt5ZHZKRDhsUm15L2dQTGdUZUpQbEpwVnpvVk9JTENUSUFk?=
 =?utf-8?B?d09LckFDa25nS2ZQMmVyZDJ5WXY3ZG1pZ1JXeDhPdkJlbk1iZjBDU1JkQmN4?=
 =?utf-8?B?cmZGcGpsQ0tUYm1ZK1VFalFOa2Q0N3FlbHk1QTFUalE4b1lYQTdIOWF0U2Fl?=
 =?utf-8?B?LzQxRS9qVUQzczhlSFhkcVRCcjByNklLN2JEdW9yQldWUEZ2dnp2dk5jK2x4?=
 =?utf-8?B?T0VMd2dHQzl2aEpOUUg1bVpWMWlzRGxONEFBYkMrQ3pIc0ZpVEFxSG1jR3pK?=
 =?utf-8?B?YUk1dm00MnZLK0lLcXp2eHdPSFBqUFVnL2QxN1JRS29zRmw2Slk1ZDk2bDU3?=
 =?utf-8?B?Z1hYVCs5Z1JtRmc1YXpnTHpqNmNBWVlsNTc0eHExVEhQWituWmx4elRXN01n?=
 =?utf-8?B?a1NaWmI0OEh3aXNISy9DUCtrMllDTjRFTkVlSHlULzJySlVzbVduQitCY3RF?=
 =?utf-8?B?K1FVd0c0MElkeGRiY2YycEZpTmpzRWgvaG9rVnJtc1BTUzZId2oyanhTQy9s?=
 =?utf-8?B?Wm1KQks5M3E4WVAzRXlpVkY3UmYyUGhhVWw4TzZNYncrdnQ4ZVZ3ZFRFMFNx?=
 =?utf-8?B?RHFzaERJNWE4MTgzS0RRWE5vUXkxUFk2MDlIV3Z2ZXJVY1VkMEFzVVFuODZk?=
 =?utf-8?B?MXN2T3luSFpyYnJuUWIzdlBtSFlQbW9GQzFnaXFwNWxRbHpNdlhWWnhNMnFH?=
 =?utf-8?B?RTRJL0g1MDNjUUNTdUtXUjQycUpSRGxvREx3Qm5ML1ZOYjZhYmlvL200N0Jr?=
 =?utf-8?B?bnUvbDB3STFCTjFwckI0d2lmMnRxTGJQazl2akpxWlZ4T2JGa05MNU9NU0Ur?=
 =?utf-8?B?cWE5ekZNMDFlYlBqVmdyUld3Qld0bE9hWERCRjFHbzYzMW9LRXJaL1MzdTB0?=
 =?utf-8?B?L3VMVmluOFJHcnhEVjBUU2tOdnJ0MmpBYmVTTTBScUxrYy9RTXQ2NWpKM1Jv?=
 =?utf-8?B?YlJha0FLUUxWVDVhK0JHWE9sSmhINENNQjVXcWs0emhhOEI4Njd2SGgyenJ1?=
 =?utf-8?Q?1cbovGVyaVO/QDssw7cGhZu520Qd0Kz0xM4L4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGxibE1iaEFLbVRtT3dWaGlFejdDR3p2Sjd6c2hFb1pxNUU5K1lxWUdGVzNs?=
 =?utf-8?B?MVpKSGhxb0hKbTJreWxnNXBVdW5rVDcxNldOU0U0SG1lWXlDdUdyOEt4dWZu?=
 =?utf-8?B?M1RFV05vUDd6b1lpNFVqcXNnWk85d3BteGx2K2VWV2J5SHRWUmU1d3dwb1Ir?=
 =?utf-8?B?THl6VDNFVXJYS3c5TTIyOWxlQWsvRFcvTHNnSldSTFNsL3BCY1RoZUd1T1ZR?=
 =?utf-8?B?VFlpcTF5eldxWnRWSkRuYzdPb3lHa0YreVdEbnEzaDZ2WVZhRC9YTzMyZlNt?=
 =?utf-8?B?VmVzeGkyZk5BU3pyM0xQc3J0UmVJcUJTbkVqY2Uya3lTdmhyeExVNjl6eU13?=
 =?utf-8?B?RTNqZXpWSFU1dTNtS0hRQXRYUFBDR1VFcjZJVWdQTVpnTEJ6M2xyKzlyeWl2?=
 =?utf-8?B?eXpLUytYc1NuYkhWVUJzcU5YQy9rQzR5akdVbzJiTDBqeEZFb2szYTFTU1ov?=
 =?utf-8?B?ekJRaE5ZUWNuV3pMNWdGbUMySXBvS3VvU3ozaytvWmppeGxxTENLRkNsd1pi?=
 =?utf-8?B?cGxLMVRMelFhQXFUMXBnb0VhMUh1YWU1M2gvQnl3ZjFkLzNhdmN4a2xPTlJX?=
 =?utf-8?B?SjF3WGcxSXplSkZESitaWVkrTWVscWxmcmR3THRzdXNGWEpPb3ZtWGlNT2R4?=
 =?utf-8?B?MkJ0SUNFUTVaS0JnWWVTZlFGdTZUbHp4NVF4UmZPc1dUaDVuOHBQbVM3S3Vs?=
 =?utf-8?B?K1docFZwT3ZwYTM2YXArYlZoaTQwOHVsRU1hSmxYMTduREo3bHRjYXg3U3BG?=
 =?utf-8?B?MmZtV29LNm9ZVmtHdS9aSExjOVQ1Y2VkTnNYTTMyRkU0TlZYTXpzaGpaM2lk?=
 =?utf-8?B?YWxEREZZODFtTnNCcTNUbEFJUnp1Y0RJZ3RycTR6VHFwN2txQ1B3d1R0eXQ2?=
 =?utf-8?B?SnBzNVFRVTRicjlBbitwemlzV1Y4K2tORE9wbm0ycXhvT05DUGJKeGwyeVVW?=
 =?utf-8?B?M1ZXdGkzSVRtdklxbCthVjdHcWxqU1dtM2J2bVViUTJ3K2h3MkFQU3RETDhY?=
 =?utf-8?B?RVVnb1FML2NpOUV6eDVjNVJyY0lReGFRbzZjRkY5M0FBMDVIczZoek5veGZI?=
 =?utf-8?B?bHFtQS9yMzV4Tm1uYml0Uk0zOTAzMGhPUzRaUXRxQjFwaVZ6MVAyN2tYa3VO?=
 =?utf-8?B?Rkx4WC9xL3l4eFNMbUR1N1pRM0dzUWFBbmlVbm9OK2t2eTlQT1lXTjVBc3ZK?=
 =?utf-8?B?dEFOS1hoSWpGZ2xFT0RYTGQ2eVFYdFptV0pCd3EvTEMweVdaUzkvcFk4NjBG?=
 =?utf-8?B?RkdsWGFUd3pTT082NW5PbHJGamxmZ1B1WDFPYXQvNVBGdGJwMEVwRS91dDMz?=
 =?utf-8?B?Y1Y4S09wZWJKOFRCV05Vekt5SzdZYjVqdUxRcmM5L1NncUFablJBTnZ2Rmwr?=
 =?utf-8?B?VkdpQlczdmRtZlpBc2lOSlZGL01adklJYVhsMmlybk5IVDdZQWtoVFZKZlhG?=
 =?utf-8?B?Nk9XQzVzV0hYdm9hZ29qSTdvTnJBVEU3K1l6dGgzTFpHVTBycUd5WEw4azNm?=
 =?utf-8?B?MmNDTFY2NVJsRjlzYVowNHhIWG9FZjdSaGJDa3FkZGhxK0Z2dUFhSGVFMW1N?=
 =?utf-8?B?ZkxqUlJNVkJZT0dTcHRwL1hXWm4zSWQ5c1lLODVYN1FQZHlZTVRHNkE4TnNj?=
 =?utf-8?B?a1dHYWE3N3lmU1FXTEhEcnJvOXZPb2VMR24zVno4TGJNQ1hhY0pkZlVNd3NQ?=
 =?utf-8?B?aENsVlA0WFNJTVhhcEhPd216WG93TGthU2RHWDZYdDlrNlpTQUFGOUdwRlhK?=
 =?utf-8?B?VTFnZXM0Z3ZFdzdXVHNXa3RzVTRuZG1rQ3lWckQ0cjhqMHprN2NwVjJEV2Fv?=
 =?utf-8?B?VHpyTUVMT1pxaEtWd1FBUkVSRW5qOTljNEZzVWF5cThONkhIVXdDUzBhTmZQ?=
 =?utf-8?B?bWFablF0UVZjeVgwRFlMOUtRWE5Cc1FKb3BHbTFCcEdWWWtpNitjRlBndnVx?=
 =?utf-8?B?VnpWNEVrRDBXNk1JRXhIR0FEWG56VUw5eVVEOGo2VlVUcjFyem1IallBYVdn?=
 =?utf-8?B?d2tuUDhHczloeEZEZFdGRHJ2dDYzTnJtbkFIY2daL3NILzVSWURWU2hPZDJ4?=
 =?utf-8?B?QWhpQkJqcXpsV3FTWTIrb0piR3NaRmZLWG9JTjZKOUp6L1A1UklpdGlHNUdL?=
 =?utf-8?B?UTBDeGMrdlp3NTdUdkN3dWI4eWxuK3c5ZnRxYnRwZG5KZkR2cTF2MmxiWFBk?=
 =?utf-8?Q?AWQi52BIYcNj2l350kE7AhQ=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca273b85-523d-46f3-df87-08ddc928cf4e
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 14:05:27.2392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Ekl15Kk328jCp5klWjGv8zu8iqtP5tv9GsojszlsB672icZAa+Z9nVhURWJBFWrCXqqniZraABF9hZbwpGHl7t8g678cx5mjTbWHfavIJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPF75F8989C2
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

On 2025-07-16 00:09, Ondřej Surý via lttng-dev wrote:
> Hi,
> 
> currently, the BIND 9 design involves multiple threads with per-thread 
> event loop from libuv (uv_loop).
> 
> We are using the default rcu variant, but it seems like an ideal place 
> to switch to QSBR as we can call quiescent state periodically before 
> polling on the loop.
> 
> This comes with one trouble though. The incoming traffic is distributed 
> using SO_REUSEPORT load-balancing in the kernel and if the hashing 
> algorithm is too simple or the traffic just hashes only into 1..n-1 
> threads, the memory reclamation will never trigger (means indefinite 
> wait for synchronize_rcu() or indefinite queue in the call_rcu).
> 
> Now, I have basically two solutions I can think of:
> 
> 1. Bring the threads offline before polling and online after polling. 

If the threads block when polling, the QSBR URCU flavor would indeed
require them to be placed in "offline" state to prevent arbitrary
grace period delays.

> This has two problems: a) there’s overhead related to calling 
> thread_offline/thread_online and it is unclear to me how big overhead 
> this is;

Making a thread offline is cheap in qsbr. The overhead is somewhat
similar to marking a quiescent state. The offlining is pretty much
this:

static inline void _urcu_qsbr_thread_offline(void)
{
         urcu_assert_debug(URCU_TLS(urcu_qsbr_reader).registered);
         uatomic_store(&URCU_TLS(urcu_qsbr_reader).ctr, 0, CMM_SEQ_CST);
         /* write URCU_TLS(urcu_qsbr_reader).ctr before read futex */
         urcu_qsbr_wake_up_gp();
         cmm_barrier();  /* Ensure the compiler does not reorder us with mutex */
}

So it mostly stores to a TLS variable, and evaluates a "waiting" state
from another TLS variable to issue a futex(2) FUTEX_WAKE system call if
there is a grace period waiting for this thread.

> b) currently, there is no way to bring the thread online before 
> libuv callbacks are called - https://github.com/libuv/libuv/issues/4839 
> <https://github.com/libuv/libuv/issues/4839#issuecomment-3076493238>
> 

Figuring out a way to make the thread online again between the
return from polling and execution of user callbacks would seem
like a sane approach here.

I have not looked at libuv, but perhaps there a simple way to mark the
thread offline and the online again just around the call to poll or
epoll.

> 2. Add short per event loop periodic timer that would call the quiescent 
> state every <n> ms, but I have a vague recollection that unneeded 
> periodic timers mess with the power management as they wake up the 
> process even when it would be otherwise completely idle.

Indeed, this will likely hurt your power consumption. Also, you'll
end up with a quiescent state emitted from a signal handler, which can
nest over any code that does not have signals disabled, therefore
requiring RCU critical sections to disable signals. Probably not what
you are looking for.

> 
> The bonus third option is to give up on this because there are lower 
> hanging fruits to improve the performance than the membarrier vs QSBR. 
> That’s certainly true, but it is an interesting software engineering 
> problem, so I am not ready to give this up easily ;). And coming up with 
> a solution to this could lead to at least a blog post that more project 
> could benefit from a solution to this. (For a moment, pausing from the 
> grim world we live in now where every idea gets sucked into LLM and 
> venture capital.)

That's also a good option to keep in mind! :)

Thanks,

Mathieu

> 
> Ondrej
> --
> Ondřej Surý (He/Him)


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
