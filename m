Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DC4C3ABC3
	for <lttng-dev@archiver.kernel.org>; Tue, 13 May 2025 15:40:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4Zxgf95qbMz1yYx
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1747150819;
	b=IE6rK+K+4N5n/GGZ7CbCROLbB3nWNg1xs/4gXET0+EJyrInvqRLn9JJP886qNVTAqlbm
	 FFNqg/Ux0iB65rXSsfgOdTeeqctxbC1gYBIFxLx/ZSO8q1kSTIj5T5G1cq3DfEQKAAcoa
	 wZmQd0ovooZOU0El0ebTw55OXjLXno8ujcaDr51yFDfIezis1UfqsDRM2boGBX72mXMxm
	 IiUGXzLzeOrlZdcYuD3ZWayCRH0tKYsTc+uuNu4aBLtQ8NY8NNO2hyKAvKqtlcnYJumyh
	 qxVhBbVbKPUvmIokWcMHmD0P1Y/RtjW7vUQBsZ40lbeTcmfc9ST7DZBgfIztp10IdTA==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1747150819;
	h=DKIM-Signature:Date:To:Subject:Message-ID:MIME-Version:From:From;
	bh=DtXeYtGeUbGvsvjvbJ4mRm4CqgC5x8s+i0ZKPnt7+ic=;
	b=Wp3UnGIrY8gPLgH9e1DU8Zi5nE00h5GJwyfLIDzdwwhJsTTQgnLigm15yCh9Rcr4GF+G
	 JQL4rLT6qc9pZHfK7si26GnCpJRCyq5jXRP6KsoILTXtDf8HOk9ZDmhDrY3KKatFQR1+e
	 3Bqt1z8iTOp0OpBcBvRzr8KvqVyf1Hm/aB4kD0imQjf5uSPOeYot+5Aliy3tamgHOGXZx
	 PVbiljbbQs2u4WUSE3KAp8Qjn6nD4/J4r4MJqo3LDwS2qrFd7PF1mdTiY5cuXHxQWvqsE
	 JQ5lrUbaxR7yXXYXF97UBfjV/eicoD1TjXbjRE0qfqB2h0k3J9YggK1beBArGDKpwdw==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4Zxgf95qbMz1yYx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1747150819;
	bh=DtXeYtGeUbGvsvjvbJ4mRm4CqgC5x8s+i0ZKPnt7+ic=;
	h=Date:To:Subject:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=dfLRMkHVn9zpS///EqwsgZS3CTLuvOXfEtlb+9V8xqMd2XXHk/hLkHGhkypSjTatx
	 04+eNPJRp51cGdg1wpBTFJcFWd92+5ckx/Saa3J/hL0h17gKwaPTxJHFSH5nZGwiCT
	 Vis3OTe4h+8bnlkV5Rx29H6qVissfF4eEuEOx7D6WlXIUY1fI+qqQksmTgpFD3XZSM
	 JfXdkV98xNiqDP9axrEhoaJQMGh/Ff9AMga74MApHlDTOoVmCYrzev+NZK89yv8P5n
	 JMh4R1phJ+gKJbZZ/owRsEDRlm3HnB7IahP7mTwtyw+/GEz9f9cXO/aNLMslk8hEEt
	 BT5oi0cNWuWbQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Zxgf95qbMz1yYx;
	Tue, 13 May 2025 11:40:17 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4Zxgf73Rwnz1yc5
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4Zxgf73Rwnz1yc5
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::7])
 by lists.lttng.org (Postfix) with ESMTPS id 4Zxgf73Rwnz1yc5
 for <lttng-dev@lists.lttng.org>; Tue, 13 May 2025 11:40:14 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCHqnyXZ0i419XpM2tDhCZX9w5SPP7gBnVnzDdALApDD8RjUHCMLC4PPLng4wnJauHdn7pnCg/AP2pmb3Zm3tJq4d0t44DjOYF8lHEpY9JqEDQfA2ybdpxdzyS0BmevaQEr5DX/ZUjlSdpshz7P8tYfyuMmT6vUte9Psr/BOnjt/Cq3rd2wXltp9gnl12LhEgY9MlNKSEAKRj8/s2THEjwVyHU1KN5wysKAvf4w9ugqRNjZ2kYTstZ5MIEuQno6ZbDVdF6gpxYuYlU4K0XWqH6TqsL4Iv70Zwzgxf65jDXBxxxeDLCEpxZ7xqxiljLZQ8kOQNPmtS553PekAw1uYaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaXAJK3jdMZ8dWEYZR6ltFDFsuAq8Eg/rnWMI/XoFS0=;
 b=kv1C5p4zP7i7nZzvNTcnQwQvc8Y9nSSJlHMZ/h7TJRfSdkyurN2lvcQJ5eiRNLmzIETaf9AwDlZWOD/IIwTHrc1U+lKO7WtfjUQ3TXxZSAQHIodAcOanRBq2SV1dS/MGAoFDXCTmtAl9/rpmN5AhiB2BE4G2iWXIACjiLcZI3t9C3wwCB5Vw4IHJKd3r4KbWj/ifCi4nlQuk5YMn1FBYNyvl0Bc3WMnbHDTq797zZW2XuBG8mK/h38IjFqU/DiPkdQAv+aJItRexqjQ+PBxlXFYqVTqLBt81UTI3xIJiAem7RY/u54eYlzHT4v3bZyDyHljZ/Lle2nPVJzXHb2xsmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
Received: from AM6PR08MB5013.eurprd08.prod.outlook.com (2603:10a6:20b:ef::21)
 by PAVPR08MB9698.eurprd08.prod.outlook.com (2603:10a6:102:31d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 15:40:10 +0000
Received: from AM6PR08MB5013.eurprd08.prod.outlook.com
 ([fe80::2277:ee89:28ee:ac0a]) by AM6PR08MB5013.eurprd08.prod.outlook.com
 ([fe80::2277:ee89:28ee:ac0a%6]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 15:40:10 +0000
Date: Tue, 13 May 2025 17:40:09 +0200 (CEST)
To: Kienan Stewart <kstewart@efficios.com>
Subject: Re: Problems with arrays of floats (lttng 2.13)
In-Reply-To: <6159fd56-a363-48f6-a3a5-b829fbaf313a@efficios.com>
Message-ID: <a6cdd4fc-0454-3004-613a-ab7a231fc4ff@kuleuven.be>
References: <00f6c849-e4f6-396f-9f71-4b58bd203eda@kuleuven.be>
 <7078c448-41bb-4ec3-be56-cfd93ea94ce7@efficios.com>
 <c25050a5-9e48-1042-5428-a33c4602fcdf@kuleuven.be>
 <6159fd56-a363-48f6-a3a5-b829fbaf313a@efficios.com>
Content-Type: multipart/mixed;
 boundary="228850167-1891789462-1747150809=:19123"
X-ClientProxiedBy: AS4P189CA0013.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::16) To AM6PR08MB5013.eurprd08.prod.outlook.com
 (2603:10a6:20b:ef::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB5013:EE_|PAVPR08MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: 297475af-7e95-44ac-7151-08dd923471a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFhWRlR0eTY5VXdDSjJ2SWlLdEFHQnBrWXIwVkZ0d2tJbTM1dDNJM3JKeCtp?=
 =?utf-8?B?RHlZTlY0ODBGR0MxQkp3WUQ0L3VuMjI3a0hjdXJVSnJHaXA2bHdieWJFT0Fl?=
 =?utf-8?B?NVoyYzcrdGdRUGYvbG5xUEJsSjJYYkE0WlpGT1N4YmFJZ0xlRkRXbUxXdEwv?=
 =?utf-8?B?Vjl6UFRpR0h2UkhFUlRNaEJBN2dJbTJsb3BYZmdYUEZ3TTlkaDlYdFcraUUv?=
 =?utf-8?B?SGZzQ1lSUUI1aDNFYm5rVnZOL1kwdWgyaGRjbE1Ib0R0K0x5K0Z0M2pVVXNX?=
 =?utf-8?B?MTVvYVY2aitSK3dEcnRINFpDNm5GSWc3ZUxJcXBObWdvWjdma2xDS1U0R05v?=
 =?utf-8?B?THF5eUp3Q1FOVXZuT3RMSW1NNzFkQzV6NHoxaU1TbXQ2WVVycW5RN0Y4U29L?=
 =?utf-8?B?ZzZMK3E2cGpjNFJvd3ZERlBQOXM4N1dVZWhZbzA1RzBjcUlxRGhQZ3RHM0JH?=
 =?utf-8?B?TG1TUzBqSVJxaGdpRjI0N1BFN3kvREdpWkphNFZlcmZHVThDT2lMeGM2ZTRG?=
 =?utf-8?B?ajRDSm5FOXFoUFIvYVJUY1NxNU5PY3BnM1hjSFNYR1lJam5pN2xYUCt0eWxM?=
 =?utf-8?B?alI1Lzl6ZU1jMkNWblhoRlJGemlaS0hCWnNlRmFMNU9MU2dYODdEZXYzWmoz?=
 =?utf-8?B?SnlHU3diVS91L1g2dTJwTUNPUm1hV0IrQXBFbjVOb1J5N00xTkhjNnZDMlE1?=
 =?utf-8?B?bmtTRmF0Vk0vMHU4R1ZyQnYwengzZTJxaXcvbjZNTVlMRGRBYmFvVzZMcGZv?=
 =?utf-8?B?ZGhQYWlUQms4by9iMHlKa2ZpT1dUYkdzc1Vja21abzlnMnpvY0V4R2t3ckty?=
 =?utf-8?B?bGpvRzl3MCt6VUluQzkvU2I4dVgyUnU3S0tkMjZrajVwcHd4amQ1cFZZMktp?=
 =?utf-8?B?TGh0RUltczJzSU8zN0twZWcvbmwvNm1PSlNsdzBEMWpLbENNUml6bnY5SlVq?=
 =?utf-8?B?bS9LZEtPM1VTSHhZalN5YjkxU0pNdFJFUmJUMm5EZzd5Z0R1U0NSLzJQTlFo?=
 =?utf-8?B?VlNIcmVLeHFKanBuTUFOdFpUOE93MmlYOWd6ZldSSHFCSEY1UmdKTDFNMExI?=
 =?utf-8?B?WjIwZmZhaDB0UmtiQlQ4NHZ5UnlTRXNhekVNQ3ZyWklBSnFXTlNadHNCMjlh?=
 =?utf-8?B?MTNlb3lNemgzWk1SeU9FTzRjMUNSaG02dXBOczVlTVl6aFE1S3JiMnlodjVE?=
 =?utf-8?B?ckJXLzV2MEZwNGgxRTZyaTZOcDFnOFUwQlQvZklsbGREbEJzdTlLWnVkTWsy?=
 =?utf-8?B?bmlEZStCVmdSaDBuM3pRcERpYnpCUGdRWFh3OUMwYnVtUjJlV3YvZ1QvTGNa?=
 =?utf-8?B?MjBGeTZEOVVrc2FaaTRvdElPN0MrTXh3c08xR213UmE0UHYxSzlFKzkxRUF0?=
 =?utf-8?B?QlJsd3pPaUxyc3oyY1RzdEwranhtR3ZsWnRNcldycU1hanA5UXhTQVJkT2V6?=
 =?utf-8?B?cGNDazVyTUQ5WUtPSjBNZW5WTVV4UFdzY0ZuQTlKaFRINFM1NXg5L3RqZVI1?=
 =?utf-8?B?Uk5WMkc3YVFQUHJZRWtqeVBTTkVIL1I2QklhVkNZcjVYL1ZuMXdhVDY0Z3hi?=
 =?utf-8?B?aG9Pd1Q4ck43NmR4UEJMWXZ6aUFYVW5WdUVoeUdoeGFtWXJPQjVieVl6dVBy?=
 =?utf-8?B?RjNHTWRXb2tlR09EeFhVWHNmdEdGWk9sQTZaeXp3YURzbFBnMFNXZ2Zsd1l1?=
 =?utf-8?B?eGR1R0Y3dWhXVXNMS3F0WXVBbDQ5aklEelkyMktPV2tZZVhXM1N5RGlQOFB2?=
 =?utf-8?B?MEIwdlAxSHJGSmhiRU8wT20rZnpER0NxNnlrdlNtYjNoSDVUVnpqdGw4MUN0?=
 =?utf-8?Q?HFACWSCsze57FLy34XyLGnvqR3U8L1csXEFmg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB5013.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGtaWTJ3bzJvRU9xbVFicTYxUUVMVHFrenB4SEpRWkFkWTJGRCt5djExcEJ6?=
 =?utf-8?B?Y1RJck1nUHNtamNnT3RHNURPM0U5ZWl1MU5jVyt4azRxWEk2cUFCV1FMSUxl?=
 =?utf-8?B?c3pJR2ZZZDBJSnJvVUNzcHpScU9idExPVGY3SEl4YXZnU2MrckI2WGY5eHFt?=
 =?utf-8?B?dFZYVG9LRUxBVXNlN0pUSlhiYUV3TUttMisrNWUzVnpQblJDQ2R3WHVBczRQ?=
 =?utf-8?B?SktmTFkzUVZTMWQ5L2psODBkUHFZWm9yUmpabjNUVUtSYlFUUWdzbEFCUGpT?=
 =?utf-8?B?TVFyUkxINWJQVjlqYi9TdGRlNFB6b1l4KzNhRG5BcTRnSFhZSEFWZWVxYVJN?=
 =?utf-8?B?MzllQStBaERYTnpmbGtHK3lMMmZPaTdqcEJ3VmhwenI2dXlvYzVFM1MzMnVC?=
 =?utf-8?B?MGxBSUx4OUQ1RFhxMlBxWUVtQmd2eWN4RE8zeFJGU1ZuYWhHWVB2eURaS05Z?=
 =?utf-8?B?Z1JYY2ZPT08vaVBnR29uK0V5MEtoTHFNaGh1WkUrZ0wySEJHOTZGU29VRE9o?=
 =?utf-8?B?SEMrMVhxVlh3ZzhKT1RBS3JINXJ4VEozYW9WR1VFOG9aNVpyV0xVdkFZSVRx?=
 =?utf-8?B?SVJFL3RHNlNsYUQ3bmloekovOW1aYUFKYjVpY0VXVUlpalFQQzJOdEJ3aUgy?=
 =?utf-8?B?UWw1cEJPTTE2RnlraVN3VDV6elpqbysycnJ6ZGdHUWYyUmFMOVN3Vy9BWTBl?=
 =?utf-8?B?UWpyV1RzZXoweldGS0Q4YXhqNk9Xa3A3ZnhOckNJZldScUZkMXQ5K0RjTm45?=
 =?utf-8?B?U014VTVXR0QyRkhDZmxzbTFhUHFmZHFla255bXQyUVNrZEpKV1Q1SHJWcWN4?=
 =?utf-8?B?R0RwTlNDc3ZuVENtQ2xWWGJidUlITXEzNVhuclJ1Z0l4RmswcFBtZVRIYWFL?=
 =?utf-8?B?NHNFaVBzcGdrVjJSemFQWDROYzYrNlhlT2ZhVElJeWJDQWQ2VWRNYzZYeDVO?=
 =?utf-8?B?NHAyUXR4LzBwbytHZWFEbGJyZ1lBK0FKbGIraTBQMFE0eUJ5OVJLVnVVZEQ3?=
 =?utf-8?B?TUQ3REdkbGtzT0pCWFAxa2tVWWI2U3FEQkFxSEIxazNDdXpJSWtJQlJuRldz?=
 =?utf-8?B?a09JeVBkdW8zOE4wWGRmR1ZCb3VxQmdCNkJocFRKYWtoK1JocmFrVnZxU1JR?=
 =?utf-8?B?T3NvZWtoc1dTK3dRdkwzOW5GUTRXbzdiOHBXR3I3SHpYbkZqTTZuT3VMTFU5?=
 =?utf-8?B?Zm5SZTR4dUZHOWxsTU8vWC92RitJT0VSVnR6T3dPUkJMSkFLNXNoclNHY0Z6?=
 =?utf-8?B?M0ZZeTVvMDhQeHZCWUZHVFZQbjBxUHNSZFcycVNmMkdXS3h6emgySGtaSTd5?=
 =?utf-8?B?N3VnUlhyOXZ6enkyTFNTU1IrV212cUtBaFo5MTB5UnBKdHB2cWdSSjJLZ200?=
 =?utf-8?B?R3NuRi9aQWZsRE1RWWZHU2NSNnRIQnY4dnMzRzBZQ3lhM2E0VFhuVURZZzJK?=
 =?utf-8?B?SU9rcVN3MUJocnJqM2d0RU9CUzV1Ym5UbjJFek5nTkFaaXVIZC9NdzVZZU1C?=
 =?utf-8?B?ZERzN0ZSYnl3cDNSVkFEYUZSUHlaeTAxYldCUVFDY0ZWMzkrL3hqOWNPbmFu?=
 =?utf-8?B?Ky9oL1JKMXpKNzlEa0FQcnVqQ0VvUXBDc01mdVFEb0ZaNWFNd3JoTEJnbmh5?=
 =?utf-8?B?MitZeW13d1RHZENHTm9zZmpYem1tMlZIMlJPa0JaQ1pKMHBSNVRzc2lDcjV5?=
 =?utf-8?B?Uk5RblNVWXcyVlNDSnpDRlN4RkVJRGhMMU1PbzA0Vm9ETWhmMWJ2NFhHYmhv?=
 =?utf-8?B?OU01TEc0VDU4cnQxRnpFWGgyUm5xa01NbldrYXdDcVF5d3JNYzVSZkNEajF5?=
 =?utf-8?B?WlltZUpVamxXMW1qeGZqTnovZThlUnR1OE92Sm9ZYmdzelpIVXh5RUN4Wmhh?=
 =?utf-8?B?dHhiWXM2c1dzekdRRXJ3bDlMbnNsV3E3YmF3L1dMdFQycUIrbXJhSEF1M0hi?=
 =?utf-8?B?QlVHRmc1dUplcVV2RDRGLzhyT3EvVXMzUHNabGxURDV4UjV3VmM3R0RmN080?=
 =?utf-8?B?ZkVGYjM3UFNmZHhWT1BVVVRsQW1UNU51Vng4WWNqRXQ3R2lkVDlGbEZXUjlH?=
 =?utf-8?B?NGxJNDllUEJOSXhjVmFKQk5oMXVoak5DM2pGOEpmbVFDeVpFZ20wQ3R2aVN5?=
 =?utf-8?B?SlBoL2VZWmJZVE0vUXYvWmRtMHAxWkJ4TDZZS3pueEdXS1NUZlFVY3VYUktU?=
 =?utf-8?Q?aB9Cxv8kfG+JF4s/k1/CpT7V6hc5lVhjBe30SCnRxXdW?=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 297475af-7e95-44ac-7151-08dd923471a6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB5013.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 15:40:10.0830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5mFTTdUDpv0DBgXzm5D3x4yeLk/wlsn7LjsSDJ4Tev5Cy35zaum7vEcTGav4+vgtI/ODKjzYLZO7Z29HN6ocmH7H5tgqrdD5VuKtlfY2wg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9698
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
From: Herman Bruyninckx via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Herman Bruyninckx <herman.bruyninckx@kuleuven.be>
Cc: lttng-dev@lists.lttng.org
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--228850167-1891789462-1747150809=:19123
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 13 May 2025, Kienan Stewart wrote:

> Hi Herman,
>
> On 5/10/25 4:14 AM, Herman Bruyninckx wrote:
>> On Fri, 9 May 2025, Kienan Stewart wrote:
>> 
>>> Hi Herman,
>>> 
>>> On 5/9/25 6:03 AM, Herman Bruyninckx via lttng-dev wrote:
>>>> Dear all,
>>>> 
>>>> I want to trace an array of floats, but I always get bogus output at the
>>>> (Python) Babeltrace2 site...
>>> 
>>> could you give an example of the tracepoint you have setup in your code 
>>> that doesn't work, with the corresponding output?
>> 
>> Thank you for your swift reaction. Much appreaciated.
>> 
>> First of all, my apologies: I should have provided the required information 
>> the first time around already.
>> 
>> ---
>> This is the information about the installed versions of the relevant 
>> software:
>> 
>> $ uname -a
>> Linux SET-L-ME-P22061 6.11.0-24-generic #24-Ubuntu SMP PREEMPT_DYNAMIC Fri 
>> Mar 14 18:13:56 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
>> 
>> $ lttng -V
>> lttng (LTTng Trace Control) 2.13.13 - Nordicité
>> 
>> $ babeltrace2 -V
>> Babeltrace 2.0.6 "Amqui"
>> ---
>> 
>> 
>> ---
>> My application code generates a trace as follows:
>> 
>> Tracepoint "-tp.h":
>> LTTNG_UST_TRACEPOINT_EVENT(
>>      comm_activity,
>>      range_scan,
>>
>>      /* Input arguments */
>>      LTTNG_UST_TP_ARGS(
>>          int *, distances,
>>      ),
>>
>>      /* Output event fields */
>>      LTTNG_UST_TP_FIELDS(
>>          lttng_ust_field_array(int, distances,distances,5)
>> )
>> 
>> 
>> int testmeas[5] = {1, 2, 3, 4, 5};
>> // double testmeas[5] = {1., 2., 3., 4., 5.};
>> // (one array for test with integers, one with doubles):
>> 
>> lttng_ust_tracepoint(comm_activity,range_scan,5,testmeas, "range_scan");
>> 
>> ---
>> 
>>> Could you explain what you mean by (Python) babeltrace2 site?
>> This is the Python code I use to display the trace generated above:
>> (inspired by <https://babeltrace.org/docs/v2.0/python/bt2/examples.html>)
>> 
>> ---
>> file tt.py:
>> 
>> import bt2
>> import sys
>> 
>> # Get the trace path from the first command-line argument.
>> path = sys.argv[1]
>> 
>> # Create a trace collection message iterator with this path.
>> msg_it = bt2.TraceCollectionMessageIterator(path)
>> 
>> # Iterate the trace messages.
>> for msg in msg_it:
>>      # `bt2._EventMessageConst` is the Python type of an event message.
>>      if type(msg) is bt2._EventMessageConst:
>>          # An event message holds a trace event.
>>          event = msg.event
>>          # Only check `range_scan` events.
>>          if event.name != 'comm_activity:range_scan':
>>              continue
>>          print(event.payload_field)
>> ---
>> 
>> and these are the resulting traces (for int and double, respectively, and 
>> with the C and Python versions of Babeltrace):
>> 
>> $ babeltrace2  ~/git-repositories/communication_5c/build/test_session/
>> [12:19:11.381152129] (+?.?????????) SET-L-ME-P22061 
>> comm_activity:range_scan: { cpu_id = 6 }, { distances = [ [0] = 1, [1] = 2, 
>> [2] = 3, [3] = 4, [4] = 5 ] }
>> 
>> $ python3 tt.py  ~/git-repositories/communication_5c/build/test_session/
>> {'distances': [1, 2, 3, 4, 5]}
>> 
>> ----
>> 
>> bt2$ babeltrace2  ~/git-repositories/communication_5c/build/test_session/
>> [10:04:51.068836215] (+?.?????????) SET-L-ME-P22061 
>> comm_activity:range_scan: { cpu_id = 6 }, { distances = [ [0] = 0, [1] = 
>> 1072693248, [2] = 0, [3] = 1073741824, [4] = 0 ] }
>> 
>> $ python3 tt.py  ~/git-repositories/communication_5c/build/test_session/
>> {'distances': [0, 1072693248, 0, 1073741824, 0]}
>> 
>>> Are you instrumenting python code, or are you instrumenting a C/C++ 
>>> application with lttng-ust?
>> 
>> The latter.
>
> thanks for the extra info, it's much clearer to me now!
>
> When you're passing the pointer to the array of floats, you get the weird 
> values because there's not an explicit type conversion so the raw data of the 
> floats is being interpreted as integer values.
>
> As there is no lttng-ust function to handle an array of floats at this point 
> there's a few other options you could try.
>
> In your example you're using a fixed length array, so it's possible to define 
> a tracepoint with 5 floats like this
>
> ```
> /* note, this version isn't doing any bounds checking */
> LTTNG_UST_TRACEPOINT_EVENT(
>  my_provider
>  my_tracepoint
>  LTTNG_UST_TP_ARGS(
>    float*, my_float_array_ptr
>  )
>  LTTNG_UST_TP_FIELDS(
>    lttng_ust_field_float(float, float0, my_float_array_ptr[0])
>    lttng_ust_field_float(float, float1, my_float_array_ptr[1])
>    ...
>    lttng_ust_field_float(float, float4, my_float_array_ptr[4])
>  )
> )
> ```
>
> Here's a couple of ideas for a more general approach
>
> 1. Define a tracepoint with an integer length, maybe the base pointer 
> identifier (for correlation) and the offset. You'd have to have a smaller 
> helper that calls the tracepoint one or more times depending on the length of 
> your array.
>
> Something a bit like the following. Note that I didn't do a full test.
>
> ```
> LTTNG_UST_TRACEPOINT_EVENT(
>  my_provider,
>  my_tracepoint,
>  LTTNG_UST_TP_ARGS(
>    float*, my_float_array_ptr,
>    size_t, my_float_array_len,
>    size_t, my_float_array_offset,
>  )
>  LTTNG_UST_TP_FIELDS(
>   lttng_ust_field_integer_hex(void*, array_ptr, my_float_array_ptr)
>   lttng_ust_field_integer(size_t, array_len, my_float_array_len,
>   lttng_ust_field_integer(size_t, array_offset, my_float_array_offset),
>   lttng_ust_field_float(float, float1, (my_float_array_offset + 0 >= 
> my_float_array_len) ? 0.0 : my_float_array_ptr[my_float_array_offset + 0])
>   lttng_ust_field_float(float, float1, (my_float_array_offset + 1 >= 
> my_float_array_len) ? 0.0 : my_float_array_ptr[my_float_array_offset + 1])
>   ...
>   lttng_ust_field_float(float, float1, (my_float_array_offset + n >= 
> my_float_array_len) ? 0.0 : my_float_array_ptr[my_float_array_offset + n])
>  )
> )
> ```
>
> 2. or, use a structure with N floats and a process similar to the above.
>
> It's a bit inelegant until there is support for array of floats in lttng-ust.
>
> 3. Use the int or char array and rebuild the float values in post
>
>
>
> Hope this gives you an option to work with for the moment.

Definitely! Much appreciated :-)

> thanks,
> kienan

Herman

>>>> I have no problems with arrays of integers, though.
>>>> 
>>>> Is the float array feature not yet implemented in lttng 2.13?
>>>> Will it be in 2.14? (Also the "BLOB" feature is useful for me.)
>>>> 
>>> 
>>> I don't see any changes in lttng-ust for 2.14 that allow for tracepoints 
>>> that have float arrays or blobs. lttng-modules 2.14 does add support for 
>>> CTF 2. The support for CTF 2 in lttng-tools 2.14 will remain at an 
>>> experimental level.
>>> 
>>> From the release notes:
>>> 
>>>      CTF 2 output isn't enabled by default and is intended solely for
>>>      preview and feedback purposes: having an experimental support will
>>>      allow users to test and evaluate CTF 2 until we make it the
>>>      default output format.
>>> 
>>> 
>>>> Thanks for your help.
>>>> 
>>>> Herman
>>> 
>>> thanks,
>>> kienan
>> 
>> Herman
>> 
>>> [1]: https://git.lttng.org/?p=lttng- 
>>> tools.git;a=blob_plain;f=ChangeLog;hb=11f963148df9597de6d891d96d748bae5ced7149
>>> 
>>> 
>
>
--228850167-1891789462-1747150809=:19123--
