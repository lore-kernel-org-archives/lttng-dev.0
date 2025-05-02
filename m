Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D972BC3ABAA
	for <lttng-dev@archiver.kernel.org>; Fri,  2 May 2025 20:08:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4Zq2786pWXz1PH3
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1746216534;
	b=lFUivlMJUBngCu+v3nthIEnhPSpcKUk7bCQRZLusp01t4leM5hxHfXrLbVLk+EXAZzlR
	 EmcN4R6+jayOuLaot1cE9TyNghNWkvc9i+TDASHIMCK3vFNEZB5qYxkfVuI07GTUKXE3b
	 vpoVJI5HwXZoBx0qEHLERnaR4zWjisYFKsgO2p6hgdJLAjXNfpibb/05VNpakRZrkFKsr
	 A6/ye3DVOwzSuOJHwiBEWeFHT1CKD/2paE1KyNb9ECDSRSkrwZJewZcZNcxfxwKB//Cc3
	 NY3TYfEXEtYfXwFY19p92Jbhng4d/ZMeLAOSV7xbDRYTPvy76dweeC+I6lDkI9r5AGw==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1746216534;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=3RqIJZ3Qn52PyIEWcm6ViMMd/tDLdpyZ7W4OoRQ/kW0=;
	b=gYrgRUAgb/f1eepRr8xD+GeRKwXGXoWLowYsU+s4/biFpkXZV1vUm1zMBKS1bxQgqeNA
	 yeWlxSMqUsTZPJdmXcUTMp79nIIjqFiU+q2oFZt5Uf+weKrB5jiKOiEdYfJSlvFpG4wVU
	 G+Esune9jwONcuNG0tEIuYJUynLQg4pOXQhxoQkhLdS94Chayh2fuxHvCpkHQkuWNd4UT
	 AOsjSKRzK62L0NUPNCmCDRWv/Su9+KBh1hNiZgtCcCeBzIC1jscLXgebDUHyQiKPbqWo7
	 gF9XNfFkt2QwmdYL4ziawEn2uluW2PazXI5YJLScuPbFE5zUMbMubE3jsZNG74TSvIQ==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4Zq2786pWXz1PH3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1746216534;
	bh=3RqIJZ3Qn52PyIEWcm6ViMMd/tDLdpyZ7W4OoRQ/kW0=;
	h=Date:Subject:References:To:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=bEIELUEsKdilLHyLbmj+d+aqhNvvQG1tiOl8XeRglU7npauDJBzKz/wlRScX+O+tx
	 1gmTVA6UUQNFdC4quLDhcXigtHZSHOhnAsfCeswFXkFtdCUhdRdj8hIXwuolqtj7GG
	 h0BnOB3e+7HELL76WpAKNB/GRrPvuja8Qr2GN2n0dB1li5z3aG8ioUFsSV0we6sIWq
	 mKwoL8DowYL9QFDU1eLKwTzqxqJP5bQ3OPsccTmviI5diSAAnn9NYgiRxUnxaHP/pr
	 Gu4HSGdhAzI9DcUx5sxgqFCe9sOUfaqI7JVvHMY/lyJzDF7jJJYsED1RwRmaBw5Apb
	 zoT7prNGVBKTw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Zq2786pWXz1PH3;
	Fri,  2 May 2025 16:08:52 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4Zq2765m4jz1NrN
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4Zq2765m4jz1NrN
Received: from YT3PR01CU008.outbound.protection.outlook.com
 (mail-canadacentralazon11020141.outbound.protection.outlook.com
 [52.101.189.141])
 by lists.lttng.org (Postfix) with ESMTPS id 4Zq2765m4jz1NrN
 for <lttng-dev@lists.lttng.org>; Fri,  2 May 2025 16:08:50 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lllpfmh4IT83vm4F7puFenkVBHfvHCiWPS7lZYkWOpslV3ihlIRrW0IC2YcHW0oLdfJa8uCcCcySVB2idoaBlNq0JvEsrtpBfTFMvxaf7n0D93NJLDmEYh/LtI7+DhhlK9Z0OrhvTS7Rh52MvnPKBB7kMIOKTD/ntoOiGhe3tXnH660FUj1gY8bIPj15vZonD29hf2FFsgvYE9XtQ4kLWn/G/0r1cwDeMnq6/o0xDaYpYzc4nYDeq6mgIq6dBQy8oIYtybSS6BujI2sTgU0ANzgH9jcP1CUm4u3YCVafR+nlBL9+RPtynpIseOhpc4FooPzsgnEUMIpt8MEsizwX1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8AlWTqL5kE9UkUQ4rf8Te8TQnoGJu8OJp5Cbwv2Ysc=;
 b=amUYHtqEpXT/VOmaZj6U6q3Y/cbHGOLn+anBCOtpY1+As3DUkvXfUe9P7xfqc9fDyWOSHWMA8OuJmhEbaaWO74zwdSTpeMI6y2ohSpL6Q1MvprN0BU03c1KdN4dLmYp9GMwAHURa9AeTP55QO8hlpxwUWcnhKmmvI4XB7JgarWiRx2PNgwMby4uxCdzOFR8dYRqY2RFuYDkVFbMgrE/hstIPIGx1sG5BLCe0Q9NKoLIGyMtfIN/Pk9DWMORg/67MrOEbgXX1ETcnS5ByO9eqE1h/T+B6Y0IzBuY28pzcAom+fmWgAEpvIcVdrVOTEGUx/5uG1fhUTl7fsxb2cyhUWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB9381.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 2 May
 2025 20:08:46 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%7]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 20:08:46 +0000
Message-ID: <b9bffeab-bd06-4075-a556-b06aedc49ab9@efficios.com>
Date: Fri, 2 May 2025 16:08:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Fwd: Tracing Summit 2025 - Announcement and CFP
References: <2d3e5eb6de64590a1f22cc9d3.f4d1cc49be.20250502195610.30b5e4206d.f221fa3e@mail152.atl271.mcdlv.net>
Content-Language: en-US
To: lttng-dev <lttng-dev@lists.lttng.org>
In-Reply-To: <2d3e5eb6de64590a1f22cc9d3.f4d1cc49be.20250502195610.30b5e4206d.f221fa3e@mail152.atl271.mcdlv.net>
X-Forwarded-Message-Id: <2d3e5eb6de64590a1f22cc9d3.f4d1cc49be.20250502195610.30b5e4206d.f221fa3e@mail152.atl271.mcdlv.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0037.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::14) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB9381:EE_
X-MS-Office365-Filtering-Correlation-Id: 598d78b0-098b-4eaf-a274-08dd89b52566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|4022899009|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2pmL1hXcG9HN0pQNkRub3VLU1FpSTFKL29CcWFQZGVhY2FOL1JLc0hIMlVt?=
 =?utf-8?B?TUhGOHNLSUdhd0NHWlR5WTVIT200MVdjUDloekpFRGlHRVZvdTB6a1hsemwz?=
 =?utf-8?B?OUozN1lhMlk0WURHWG1RbTNNUzE3MkdsT21WcEVJOFV0UG1TY0UzMlBpenhu?=
 =?utf-8?B?Q2NPM1k5Ty9GSzQ3UE5xOTZZSmhuZjF1bXc0NXNYcTdxUnJLT3hWenlGTzIr?=
 =?utf-8?B?bGRnbGhUcjdJbXdOUmUvcjJaRVRrUWVVYk5JY0hFeXhqQitLaDM5TjR3SlVU?=
 =?utf-8?B?a2NDZ2JqYThqNmxKYmtZNUpiTU00VTdiYXZPWUg2SkVXb2plMUVRSzhVdmlm?=
 =?utf-8?B?NmNPd1VsMGpPR3pVMTV1WFZ4aUh0YWhtdm90c08yTFUvVmJ0eVNvalZQSmc5?=
 =?utf-8?B?SHNGRXQ2SUVuSGlUMWtMa1ZxRExDWHFNY0NieTZZdkllZmNVdTB3NGV3R0p3?=
 =?utf-8?B?VDNCMSsyc1pGbzVuRnVwNys0T1hRTXNzSWJIalpGWXlYMnYyUlRUendFekc1?=
 =?utf-8?B?SmNUK0I0L3p1SE9ibmF2aHNkZVVmL3B1M09TK2dvdkVQQ09rKzkzOGlpNUdj?=
 =?utf-8?B?NkdnRFRtY3QwbkNsUERaeHkwc1h2YkUzRUFKRGZ0UlVHV1Z2WFpJTklQSjRq?=
 =?utf-8?B?cXhCNFVRbW95MmtPazFESk0wNGtKZUFCWHR4R2txcFhIeThORFJkVWpRam1r?=
 =?utf-8?B?RUZzakN4dmNkQ013ZGNhcXJzQ3dCamM1VUdzYzRmb2dIRTloM25UbDYrM3lN?=
 =?utf-8?B?c3RoWW0zVFZHK1hTYlZCUnRVY3Q1akRtWkM4UTZxbEdrTjdkcnJjR245SVo0?=
 =?utf-8?B?VkppdE9nNURaQWdvTmxIVVhvT1I1VCtiUGtRZkNKS0hCZFJGQkt3SlpPL2FU?=
 =?utf-8?B?NXIwcGJiM0pKWFRXZzZPM2VRWElvMjBndGNxVXg4WjJRR2pwTVhSOWFtN1lo?=
 =?utf-8?B?K2U4T1gyRUQxNmNJaGYrMWhxSFI0ZGYvR2tHSngyYzBPbytmNUFZS0djME9S?=
 =?utf-8?B?cEFSL0FUQW5sZk1UbGNYNlhlQTZBL3I0Tjkycm1ZWjU0MUY2Njk4TzdXR2Rh?=
 =?utf-8?B?bjhsRXhhSGNjQW1LRkgveVVtWUdUeWRnM1hJZmV1OE5NclpXY0tUVWdzWXpn?=
 =?utf-8?B?dXI1clVWY1NjQmVlY09Wb2sySUtEa1JLYVBrcnhEUEtnYUdyK2ZXc05pZVpV?=
 =?utf-8?B?OWQ5ZUpwVHd3bW9WQ2h3dGNwSmNpU2lVQWIxMUVEZkVyOFp0Qll3SkNJWEdr?=
 =?utf-8?B?NGJISFFlbmFySzZIc0xlUDNOaHY0eVRQRWo0ZHdJNDMvVVlQbnBqZFNuTVVM?=
 =?utf-8?B?ZjRQUGRBa2YweE1BS3lISldwRjI2T2YwZGJMYjNncGtSWFQ4WGtvMlRERmFk?=
 =?utf-8?B?dk9lSVQ0Y3FISWxVZW1ncmsxMzdnM1Q2ZHlmTWsyZEJiK0FYL05zSmZLVGJ2?=
 =?utf-8?B?Mkw1aE1oZVorc2cxRU9KVDdxWjIzMGd4ZUtBZHR5MFFSdzkyYzNrY2RneWxt?=
 =?utf-8?B?aFFabmx2Z2VQcVdjY1FmelFaenJTSWs3NVBLb3dEWWlCVSsybnBXeDFBZk5m?=
 =?utf-8?B?UUdDejRSMFlzM3VGNGpqckcwcHJTamxYMFBQREhZZXltcEwxaXYxejU0ejNx?=
 =?utf-8?B?azFpQ1EweFVUeXREK1N6WjlsckdMdHlsamRoNXBKRlp0NkhscGp5czVld1Ra?=
 =?utf-8?B?N0dkNlN6WFovOVBITERBSS9aWThCSFZxT2ZyS2JMeSt0SkxSOUFCOHJZelIx?=
 =?utf-8?B?a2hia0ErZmEyb21ZSzBySGMxL0Z4Y0VHNzUxWXdiUzdsWkdXNUhoc28yT0Vl?=
 =?utf-8?Q?OLxZVnPFfIDiZI74UOlhbQvjJVo4HdsFQzueA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(4022899009)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUxGZ3R1aXJIVGM4Tjhzc3RIUVZ0ZUx1c2RJN3lWQjNxbDE3clFVM1lnUnNG?=
 =?utf-8?B?eUFQNjBMNmhQNDRrdGU2cDI0WWlXVHgzazgyaHJsK1J4aEtoaGxLSmhIZXky?=
 =?utf-8?B?ZCtpWWVYenR2RGsvT2FTbDRNL25qMFhyQVc5VHRWSXllTWNKTFBYd0VlQ2Nv?=
 =?utf-8?B?cEFBc0FmK29WbkRiZ01SOTlHTy9QdkVYdW5CYzNtdjE4UmdiWm8zY2tIQlJW?=
 =?utf-8?B?aXFRS0FFSlZINlJwYTBiNjRTWS8xTXFtSzloTFdHYklNM1ZhNGN4dmFuR2ZH?=
 =?utf-8?B?djhVUFF2aHBXTGx1MERHT2xoQWhTb1N2MVE3QUQxY2pLSU5sN2VIUkJMd0RO?=
 =?utf-8?B?WkFmQXZaazNIYkZKYmRhb2d1ZC9tQlUxdW10UXpXOE0zcFVkNjV5eml6TjVY?=
 =?utf-8?B?d1VHWVdtbklSUXVHVzV3QW5kTjYyWDI5dDh0YTB6a2hrUkgrTXpGVWwwYnVY?=
 =?utf-8?B?SVROZU4xZjVYSHNSeGU5QVhmTXM5cDJHVVVHTytCNG5YRzVvaGVLVWJHZ21n?=
 =?utf-8?B?cWJXRjFKMVdUN2FqR0dwMmNmOSt5cWNiZXhlNHdwYmZuRkNJV0pVb3JndlBP?=
 =?utf-8?B?YkI1K2E2ajQ0Q2xXajNEUE13VWFwT0ZPdVExZjZ6VTlwcUtNNE5TYkZ0WVhj?=
 =?utf-8?B?UXllaXYrdWRKT0IwVThGcmVtbStMNmFIRk9jYW9WL1VjZHZ6NGpUY2VURmx0?=
 =?utf-8?B?d2todUgzUDBreEY1M3IvKzF6ZDM5Q3RNeUUrQk10RU1kd1dHUk5Pb2FEY0h4?=
 =?utf-8?B?Z1pWS0pVbkMvS3BYeTh1RmdFZnpjcDlUQ1VMamFFbkpXa0VxS3BldGxDSWc5?=
 =?utf-8?B?eTBmaW9yRXFTOXVOKzk4UTNtYmF0bkFaalhESkpyOFpNREl5cFE2eWFIU2NH?=
 =?utf-8?B?QWJDOTVWT3ZSMFNFek5UaDhUSURFVnJ2QnlEeWpxb3FlM3BzblJjSjJjdHNl?=
 =?utf-8?B?K1BEYWkzUVY5VDY4SUtYeWdmcG14RFFxZnFGbHo4WGRKd1RRaVdROWtvVDNQ?=
 =?utf-8?B?YmgyU2I1QkpZa0JlUXVSdVdRVERINE5qSXJYck9GcTRoZlh6WjFsbElUaHlw?=
 =?utf-8?B?TlExQmZEalBLdk1LdjlZZXhwNzJYL0FTc1lQOFB3TFRPb2ErRnRVRVlEZ0wz?=
 =?utf-8?B?QytlZkFTTFkvRXg1S2haczJUTWpaNTIxbFlrbmFFVkNpTzY1dklTSmFZYlIy?=
 =?utf-8?B?b1ZmemQ1RzJIQ1d4RkJ6VTd0Z0NWVlBZWWVFWkhyYjFZYTQvSHlsVng3eVFK?=
 =?utf-8?B?blRqcWJWbDYyemd3TjF3Z0tldFRDdjg0ZklpVTRrdWFUMFFMbm5KUEppN2FX?=
 =?utf-8?B?V3I5Z3VLV1JPNXlHU0pHL2JmeFBiL2xESWVTYkNXdUlQcVBiQ0kwbS9oNWxy?=
 =?utf-8?B?V2NJeC9sK3FzamJBaE03S1JZeDJ3WEdVSVl5MCtWUFV5eTJva1Zjc2tGQUh5?=
 =?utf-8?B?WDRLTXhQQnd3QnUwMUtXY25KS21EQzhPWmUrc1pIOXA3VkhVZktFbURvVnZL?=
 =?utf-8?B?UGxXSlBqbGlQN0E3N2xZOVlSL3BUNlQvWGU3WFRKVHdzeGNkUFlVcWtEK0Js?=
 =?utf-8?B?dDh5Y3Iwc1hBclZTNUFXUEZnMkowelFoM2MxVzVDaDNKR3RiWnVOT2ZXYlhu?=
 =?utf-8?B?eEJHWE14eTFZUU5hUlBWbTZVbWtZS0k0dmZsazdwWEdCekJNTFVmRUlaLzJU?=
 =?utf-8?B?SHhTVkRyaFFOVlJpa25NMHVJQ1pyeDhYZFdNTjZuMVFZR2ErZXhIQWkzMWJX?=
 =?utf-8?B?NnBIWjNXOU5zTU1KTEI1U2RvMmpVSFRhTkN0MDJEeTBEbDZhSXFDMGgwZFIx?=
 =?utf-8?B?Vm5hb0tGT0o5cmFyemlFRXo4M2RIT1RUREhzamMwR2FIYzZHbWJ0cDZKYzdI?=
 =?utf-8?B?VXpLYUZvbXlFZVpySGNQdnhYZVJ0dEsxUEQwUDB2U1BzcXpCb0dwWWg2S0or?=
 =?utf-8?B?Y0ZDZldtbnhZYklkQXNhbjV2N2RFWWVnVkoyd1VoY2pxcEZucGF2U2dyd3VK?=
 =?utf-8?B?eE01NFdpZUMxMElzZHpyc0gybEx3aDR1N2ZDL3ZLa3RkM25GZmUvY3Q3Y3lx?=
 =?utf-8?B?T3VVcDRaY25QNm9DaHRtZmVFMTYwLzA5b0tRb2M1SS9MM1JhdHcwbEJPUkNL?=
 =?utf-8?B?aVYrcUZ2TmdWSDl1azU0ZXZUcjlTMmZTNnErM0g0Z2d3MWY1djN3RnE4bFdB?=
 =?utf-8?Q?tnuB8CibPtlsxH4zUyEAKr0=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 598d78b0-098b-4eaf-a274-08dd89b52566
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 20:08:46.7300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QuyPe1N6QZGTXf2z71vBnAa6cGqZGCxt+76aTGU6sk84qe4snxGc+FkR4fnt3iWEtUfIXlpAcw9EfBSJvWEbTNHiGpxiZu2dWreMYd2WhDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9381
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

We are organizing a Tracing Summit in Montreal in September. Please
read below for the CFP.

Thanks!

Mathieu

-------- Forwarded Message --------
Subject: Tracing Summit 2025 - Announcement and CFP
Date: Fri,  2 May 2025 19:56:17 +0000
From: Tracing Summit <info@tracingsummit.org>
Reply-To: Tracing Summit <info@tracingsummit.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Hello all!

This is a Call for Proposals for the Tracing Summit 2025 [0] which will 
be held in Montréal, Québec, Canada on September 2-3, 2025.


- Event dates: Tuesday, September 2, 2025 - Wednesday, September 3, 2025
- Location: Montréal, Québec, Canada and virtually
- Registration cost
     - In person & Virtual: Free
- Call for proposals link: [1]


Important dates:
- Call for proposals close: Friday, June 13, 2025 at 11:59PM EDT
- Call for proposals notifications: Friday, June 20, 2025
- Schedule announcement: Tuesday, June 25, 2025
- Event dates: Tuesday, September 2, 2025 - Wednesday, September 3, 2025

You can follow this link [2] to register to attend (free of charge). You 
can subscribe to the mailing list to get the latest information on the 
event: [3]


The 2025 Tracing Summit is a two-day, single-track conference on the 
topic of tracing. The event focuses on software and hardware tracing, 
gathering developers and end-users of tracing and trace analysis tools. 
The main goal of the Tracing Summit is to provide space for discussion 
between people of the various areas that benefit from tracing, namely 
parallel, distributed and/or real-time systems, as well as kernel 
development.

We are welcoming 30 minute presentations from both end users and 
developers, on topics covering, but not limited to:

- Investigation workflow of real-time, latency, and throughput issues,
- Trace collection and extraction,
- Trace filtering,
- Trace aggregation,
- Trace formats,
- Tracing multi-core systems,
- Trace abstraction,
- Trace modeling,
- Automated trace analysis (e.g. dependency analysis),
- Tracing large clusters and distributed systems,
- Hardware-level tracing (e.g. DSP, GPU, bare-metal),
- Trace visualization,
- Interaction between debugging and tracing,
- Tracing remote control,
- Analysis of large trace datasets,
- Cloud trace collection and analysis,
- Integration between trace tools,
- Live tracing & monitoring,
- Dynamic instrumentation,
- Programmable tracing (e.g. eBPF).

Talks can cover recently available technologies, ongoing work, and yet 
non-existing technologies (that are compelling to end-users). Talks 
covering interesting or challenging tracing use cases are also welcome 
as they can reveal future directions or tooling needs.

Please understand that this open forum is not the proper place to 
present sales or marketing pitches, nor technologies which are prevented 
from being freely used in open source.

Please send any questions about this conference to <info@tracingsummit.org>.

This event is organized by EfficiOS [4] on behalf of the Linux 
Foundation Diagnostic and Monitoring Workgroup [5].


[0]: https://tracingsummit.org
[1]: https://cfp.tracingsummit.org/ts2025/cfp
[2]: https://pretix.eu/diamon/ts2025/
[3]: https://eepurl.com/goakfv
[4]: https://www.efficios.com/
[5]: https://diamon.org/


==============================================
Copyright © 2025 EfficiOS, All rights reserved.
You are receiving this email because you showed interest about Tracing 
Summit.

Unsubscribe mathieu.desnoyers@efficios.com from this list:
https://efficios.us18.list-manage.com/unsubscribe?u=2d3e5eb6de64590a1f22cc9d3&id=4e5381866f&t=b&e=f4d1cc49be&c=30b5e4206d
