Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF389C77B7F
	for <lttng-dev@archiver.kernel.org>; Mon, 23 Jun 2025 14:21:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bQqy222Lwz28TX
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1750688476;
	b=n73epcPDhtbo3/R5lJBeUcuUW1lgIIQ+skeQYyYTJ+PGmjNT0lmN6vPYzMEB0yFXzyyk
	 dYGCKmzgQFYwiq7l+TAMQBB0LyxyZ+7yMYQAbSHdysA+eQBbeNn7LVHyEBkAsVAz5pYj8
	 NUoEZIQ418wNN+36gUWp4ejf35Y/B/t4otpSM+484WSunSOCaDtFbm4WYDGfXUkV4chWj
	 0IdP3m1KC0hgcxhYgUSYSgNmadIQ4CaNFfUG7pJMtQ+nZfJKOaJljJFEn4CXJB4C+zLzp
	 Vhvf9/71mNo6siDYZEaW9CtWX+2wHZLo+RA3yVUt/fe1wJvLkM9/Xcgx1AFPpeQrlwA==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1750688476;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=zRlxJbkQkKaTYYvN9kmLx2+8TqimIO7UJvRs639I7hI=;
	b=T1NrlOGLSQuP64x5uwlaC3PDITTgm/1ZLXQLpJJCEFtNYSR/cWUcjAU/zsLNgnz2KuaA
	 UjpygzQGfmVuJwwoQArXsYsquYYaNKrFAZfAPgJjnzWgrshBJRYZSJuZVsPHOxVwcSJyI
	 JTnsJ54CcXslJhbb2JL0BjYF+rNOYgqRSS4iQjSyE/OwckzpSP6pCWHeBpBkDvCrg4EUU
	 DdfF9fmXsooy9ZbdJV9issvGZC4NUnO8cmj6GpsClmvnY8PnQRfYUOhVVt5RPY6xxnsep
	 sHODz4E0eqfzs4FIZX+zUz3JDg8GoK5DlcvwebH4bCycd0AYyXlFNbXHpevUoMD7/yg==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bQqy222Lwz28TX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1750688476;
	bh=zRlxJbkQkKaTYYvN9kmLx2+8TqimIO7UJvRs639I7hI=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=BlgKxAkIijFyTP3fBhr6DBWjTGxDX+dVOQnsfBTZzqRKZPx6trNjc/U7CIu76GPEH
	 Kv9HJcpWpbrbI6tQVu9SYCkW8Ica0XyJq5Ko6lgGAlX/QML5p2oO9q+S69TkmHY0xP
	 nuNaW/ax1zd+nrtka7BlMN7AnrJgaoQMnX+hEfq1M1/jb2d1pkTYMx46FSVBuOGytu
	 72H2Qi9aryBzhvKdGBb76xzQQWByKKlTL0BLGaxSUdeMARCHME1IraBIzyYpuL3QxT
	 7Ve2oDRqGSZoIbqkspikvqwOkz/QcOmC/PQeoc84+k+hShkTtdQva24KITCK+CmUaq
	 i+2U/C7iFeMmQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bQqy222Lwz28TX;
	Mon, 23 Jun 2025 10:21:14 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bQqxz6MNKz28lp
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bQqxz6MNKz28lp
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2136.outbound.protection.outlook.com [40.107.116.136])
 by lists.lttng.org (Postfix) with ESMTPS id 4bQqxz6MNKz28lp
 for <lttng-dev@lists.lttng.org>; Mon, 23 Jun 2025 10:21:11 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bmu68wIBSGbXXd5wGwP9h5J+uhwefPAnYfzw4sxO+qB4QEDbOcSDRMUrR64WibgNpo2NAT431+KdQTdF0x93E/DR4gFW5JQvWixj/ZaT4FmUqNpTeJ/hS6OHcP+DYPDr17mj6IxWoCC4A0glBB8cOBCV6MMtX9qx08z2/8CzaZ6jT4N+Or8Fe9FaM18C9L0s8dqJIE806+S4nlbgev0KP9fXehWulv9z+/DXrDL8l5kwKT5F+ixqovoYDhXfItERjofih2y0ObD+Lj8kNJkSOw7YtkjWYPF47D5wLMFHZpWI/1r1VDPERdOz7Z4aMF7lZNjvyrTtzZ/vAwa2joyD3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48hVABmyfOnATJQRqBxKLpU8bznXNI06TneheYyK7ZE=;
 b=n4Uq13uhuK16+TBPlace3pFKuEealKClVCrVgSVoSOZHJlJY129lBLEEu5S0XJojhNqNFLjhqkY//edWjcqezsBS+7QlTUf8ZYUkwl+DTM2alm/3km/VnlXEDSuDE2lJwLD0EiqD2iFw+aKqJMEuFzsRgah8po2KdjacXNunAhx38Xt33WwOAvtSyBP+vd1GwLEgjXa4SHZWQ+qLF6nWkg6piXFnjIWSiBlXjuhI4leUapMj7PqSv3NXZWDvu91uRso/A6CIPL3r3m4GlLSuBWGFhdnEipseiXAm8rR3GcWqIO4/KvzV7nHRr4pygIT6JbD5xDwp+lpKBVRSn5i4+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:5d::22)
 by YQBPR0101MB5482.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:45::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Mon, 23 Jun
 2025 14:21:06 +0000
Received: from YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b5fa:c0e6:e5b7:54a4]) by YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b5fa:c0e6:e5b7:54a4%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:21:06 +0000
Message-ID: <df98623f-172e-4e71-9592-cb864e239000@efficios.com>
Date: Mon, 23 Jun 2025 10:21:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Method to get LTTNG-UST version during runtime?
To: Norbert Lange <nolange79@gmail.com>, lttng-dev <lttng-dev@lists.lttng.org>
References: <CADYdroMBu0gocZXpeaMWqr3TG4p5FW71eeN1+y-XM_8bDxijzw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CADYdroMBu0gocZXpeaMWqr3TG4p5FW71eeN1+y-XM_8bDxijzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::27) To YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:5d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB6319:EE_|YQBPR0101MB5482:EE_
X-MS-Office365-Filtering-Correlation-Id: 629ac2d5-4011-4a82-7665-08ddb2613119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SS96VW9BRVd2dDJ0ZU4yMEZ0UWd0U1FkcE94NkdGTThVNVl3dzVhMEVkVFJp?=
 =?utf-8?B?dk1zM0FVeE12NEVuaFNac2p1MFVRbmIvenIrWXRRL3lWSmFSbVRzOTVVM3U4?=
 =?utf-8?B?YmNaLzVDLzVOaEZGQXJDZ0FyQmsyMlhJbzNJVkdoL3dLMHhYNHZPRjlBODMw?=
 =?utf-8?B?dWdHYkRMZHNYR2NDTDYxRE81U2N2Y04vQ3l3SFZpNkt6VHhEWk9ueE9Vdi9X?=
 =?utf-8?B?ZjZXQlBldkJCWnBGdkJGWGovb1BwSXJhVXNXTmM0eXhIZGZDeDhoMHQ5V2s1?=
 =?utf-8?B?eVMydzR0YWk0QWxjNTFiUjB5eTVkcmhMVXlSYTRVN3habTYxQnFJRnBvT0Ft?=
 =?utf-8?B?SVgrS0pVK1FlUTR4TEhWaHZQYUljTHBZc3JZeDVFVUVCeTU0UW55QTRmd0gz?=
 =?utf-8?B?S0NaS0ZuM3p1YlZFdGhMWDZpdElwU0xDUVNZdVlhdjl0UEwzZ2d2Ukg5VDFk?=
 =?utf-8?B?MTBtY0FrOFg5emxpTExvMm5uTTFDSFBsU0lQZFRFMlFQZGlwUWVSMFdKOHI5?=
 =?utf-8?B?QUFCZVFUbC84c3RKZVRjMmRCc1h1cExZRGlmYWdQQnBlVVB6ZC9hN1dJQWdp?=
 =?utf-8?B?d2RRU1dhU3R6bk9Ob256NmFhOGhJRnFRdjBvTzc1Y29zQ2NJR3VqenUzL2Fq?=
 =?utf-8?B?RVF4OWdCb0w1NjMwTjdUS3MvTWlFNk9QWEJLUTZ0OWludHFXNFZzWXV1Y1Va?=
 =?utf-8?B?by9SbS9PZzVTMnErZkpGc21VYXZPRjhhdXFhWUQzTERsWGxoMFhSRWNWMWRs?=
 =?utf-8?B?WUZZS1krUW5BcUg1akV0blFta2ZlSjZwNHkwZkkrMW9rK3Z1MlF2NTA0b0R4?=
 =?utf-8?B?dEZqaDk4dm56dW1KeC84cXl6WmhJZnN1TzdsTmVqNnh2ejlnS3gvNnp1ZHVa?=
 =?utf-8?B?bU14dlhzbmx6aWNEK3RYQTQ5bnRpSHFFVXNBUUhWUitUcDhybkZzZGJoWVg2?=
 =?utf-8?B?YlV3RVhQbkk3Ykh3V25ZdytiaGk2cmd1SndQV3h1Ry9KN1drYlBxWHBqdnJF?=
 =?utf-8?B?enNZaDk3UXBNUTFUOXJGQmhUeEVxUzQrRGhNNjNvSmUvVGlsb1cwS2t4bk9o?=
 =?utf-8?B?NTBRWHAyS0kyMnRFZEdwY2hiZkFSREdhOUgvSzY4UzRDZzBZNUR1UWNMUXZE?=
 =?utf-8?B?dVU5SktpS0p0Y3F2ZGJqUVBtbDh0M2RQZjF1ZmhRTyt3TC9GcGRLTjJOcC8z?=
 =?utf-8?B?R0I1TFlDUHlRTjZNV2hzWUxpYlZkZlpiRkJ6NzRWb1J3cGkreXVXMm81dita?=
 =?utf-8?B?dkpodi8ybUs4WWFHcGhyeXpHckMxYWpDdWdXTjdqc0NuNmxaZ3NNYVlZcTNK?=
 =?utf-8?B?UWNObXJhbHlJSEc4Zkt2S3FxYzduYWQ4UmRmMWg2WTRwL1Y0eE5USURmaG13?=
 =?utf-8?B?T3NVUEpNeVk0cW5qaFJCQ2VmSmdOZURhUDlmd2VxWjNwalVDajUxN0VYWGlW?=
 =?utf-8?B?emh5NmlrSERMQ09hTG5veElxY2k3NzlqWmhGRjZFMlhPT1ZYODZUbXdPWkVU?=
 =?utf-8?B?c1pJK0N0N0lJazhjKzluY1lmdklLRXVYRDArTGVZWmh1ZXR5c1Ixc2tLK09i?=
 =?utf-8?B?bko4UXZOUGFHOVR6c3J3MUxwdDUzYk5YaDNzQ09KVkkrOHVnSHM4d3ZMbDMw?=
 =?utf-8?B?Ky9rQUpTcUZ3a2hqbi9SeWJoZ00wQlZOTFFrVHFoRGpDc2pySFk0WktFeDJ3?=
 =?utf-8?B?anhQZWozR3NobTh6bnh3Y0J3Q2JYMndUbkZyTHQvZXV2SUJNclEwMVR2UzdQ?=
 =?utf-8?B?b2ZGVFB0QmxiTXovZnJiN2RucElZUHMzZ3pmeXVRM0RjZVFJRkluUlRscmQ4?=
 =?utf-8?B?TC80WkpORDAzYUxpTWdqT0lNRE5xSjZDVG1RYXlvMVdHMThWeWFSNld2SVRa?=
 =?utf-8?B?bDFaWElqREgrdmk5SXZuTHJhd0J4SlB1UzMzelN0aUIwR1NBVWlVRVRjTWRs?=
 =?utf-8?Q?1MIKYrREJBY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlRKVWNzaFllTnF5QjM4SWpveGlpL0pNTFRtems3YVRrdGpQRGVhZnhBOHhh?=
 =?utf-8?B?WjdIQ2hFSWpZU1FBRnlPdC9QRUE0NmdOSUIyYkticmxFdFdVcG9vU0hMQ3l6?=
 =?utf-8?B?dUY3VVVqRTNhcWhPOW96c1gvSWlVUmpuWEZaY050RllhbFZVcDhYRU4yREg3?=
 =?utf-8?B?NE1veWtsVXRyTi9xUnhpNWVVMnI0eWx1UlVOVmRjQXFlRlY1aTRHTmNCano1?=
 =?utf-8?B?aFJCbnNkb3phRHI2Wk1zcHkxdTFialhjbXhyeGlINmhvRmhrNjR3N1ZvYW5L?=
 =?utf-8?B?eWJoRlFKa3hUZEI1Zmw4dFpmSFJIVWNqOXZTR2lRMTB6REFlcENrMW5KZUJD?=
 =?utf-8?B?YXhuRC80TFdpaVBOYnNFd25PSk1DN21HenhDczROZWxSbEM2d3dpVE0vVHhr?=
 =?utf-8?B?ZERKZUlsYzdMRThWME5qSy9VV0NGcTRsbk5samxkbG1uckNEV1NDbWdkb0ZC?=
 =?utf-8?B?NzJ5SGZiL0RuNXlwTjZ6SDVEQ2owWVNXYWd2VDRoaDN4S2FPdHhGTXdsa2hV?=
 =?utf-8?B?N2RtTzlmOFdPbmRyQ204amxzWGNiTW9aZXhzQSsxK1FCbGVTTmdSYjdWMkM4?=
 =?utf-8?B?SmlOMnVuL2RLOUpicUZ5bFNoWUxxb3dvV28zK1JSNFpmVUdJVU1WOGZ0SWg1?=
 =?utf-8?B?RE40WjNEMjNXUkd1b3RXT2t1ZHBGRHdISm1NY1ZTZUoreGlydWxINXVDd1ZC?=
 =?utf-8?B?NThEdXlKdGg1Q1daS2V3T2daYjEvWEtxd0RmdThDY1dObDI4aWhZQ0trNEt2?=
 =?utf-8?B?b3Q1SERxMWlBeG9QQzJaTDdvdnVSU20zMVN1NVduL0FXanlrbDFtdGZYUmpo?=
 =?utf-8?B?YmR2L2czc3J6VXpyanZrM2dkQ1Nld0l1NUp5bEMyNTVUejdCNVhEZmphZkJ4?=
 =?utf-8?B?S0hLbEtZVFVJNkhwdjB1VkRXSGdtZWdxUTZjWVJSNUxQQnZVU2dGVXA0OUdI?=
 =?utf-8?B?R3B0YjZMK2E3UFBwdXZqeDlCbUdaMU1WUFJBRGZXUkZDVUpvRXROeEpQdlR6?=
 =?utf-8?B?M3hJSWI1OUNoeXJEQmR2TTdlVXNOSXJ1MWlpR0U3MDM1NjI1SThsQjY2SUhJ?=
 =?utf-8?B?TnZCOFJTY0dlbFZIK041TDdyMHNieERVZDZkS3lBUjNRdlhmT1NYc2JSRm9K?=
 =?utf-8?B?aU51WkJvWlBkMTdNeWpWazZlSmNPRTM2TkdLMlAwWFNLS3hZQ0lKb1JmTmpk?=
 =?utf-8?B?QjJLUVNFRWw3OXNIVjJ3YlEwdVZWSlpuRFNKQ3ZUMytUdEt4U2YyYXptdkM4?=
 =?utf-8?B?clhaaXZ3elNPR0VCdjZtNk9jY2tNb0RwNkVHS0hsdXFtR2RXeEZyZDNlRUwx?=
 =?utf-8?B?MGFNNHJuaExoYW5lcjZRdnVOWmpETEhETHcrOUZrbkN6RStwTUEyN2J6TXJs?=
 =?utf-8?B?Q1ZMV2NsOURIVDRFWnZoVUFITGdsbm1tOGU1OTNzQXprOENZRXFLb0lrc0M2?=
 =?utf-8?B?Rm5Ka1RrQ1dGUmxTTXFOWDl0dUxmZkRyUDNlb0c5cVA2MTdMZXkrSisycm0x?=
 =?utf-8?B?QVU4cS9Ga1VIQ1JPR0hlWDQwZ1AwQVVUUVNaeElIbUpza2JMV0l0OWcyL3kx?=
 =?utf-8?B?Z0hzZHIrbjhBQXdheUptcU1hVHZ1QlFLQWZ0TnE0dU1xUmNZa2VXV0tadHQ5?=
 =?utf-8?B?WlU4NklacTc5T2tRU0hGdVFhNHJhWGtYd1VhMURZYTZOUGhGWSsybVdIZEs1?=
 =?utf-8?B?TUhLQ00rQlZhSUtGWVY0SkQ4UDhiWmc5M0IrMVRxaTl4OWIybEVoTG5QbUJI?=
 =?utf-8?B?MmR5MUYvTjlFZkhIM0l0UnZEQVUwTml2NkZZaHZGY3RDQlcybTdtT0thdkFS?=
 =?utf-8?B?b3ZNRGtzdlBGNEtueXRIUVlDRW10YXlKTEp3Nk9EWFpOaWlNZkdVZm84ZGxJ?=
 =?utf-8?B?SDl0dUI1Y1kyS2M2UWpXU01HQ2Z6S25CZFFDanlZdGJsOHNnSHVNSjZBeVZw?=
 =?utf-8?B?Yy8raGZGQk82V3F3NkJxSkh3c0RwMHN0VnpRbWlpOGdzTVNrL3FkWkRnOFR3?=
 =?utf-8?B?SEpKQ3ZwL0dLMTFNQmp2MHVKbHJTdHZzRGR5WlJuK0l5azkrMU5GUXYyNWhz?=
 =?utf-8?B?ZzkvTVBQcFdEaGN3NVlGY0U3TTVRbFhCdkRmZWNjV1ZiSzJXNndldXI4MEpy?=
 =?utf-8?Q?ieyMy1j/YJD/XIIZf/lssc7cN?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 629ac2d5-4011-4a82-7665-08ddb2613119
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:21:06.3914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bN9kB3rzZ5LNB9fDkUG85ydjx7//1+jMgOwDCtsNh8jkjfgPqVdZRtssOxXNgBarrK6swmHnE4uwa6UEqXHSJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5482
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
From: Kienan Stewart via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Kienan Stewart <kstewart@efficios.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Norbert,

If you link to liblttng-ust-ctl, you can use `lttng_ust_ctl_get_version`.

thanks,
kienan


On 6/18/25 11:22 AM, Norbert Lange via lttng-dev wrote:
> Hi,
> 
> there are some substantial changes in 2.14.0 that afffect how/if
> tracing is possible.
> For ex. c246521ddcba1d1d28cfa0482aa500b9122e7264 allows doing more work upfront
> by calling lttng_ust_init_thread().
> With 2.13.x the same code will instead do various syscalls or
> allocations during the first tracepoints, violating realtime
> constraints and possible abort the process.
> 
> I miss an easy method to inspect the Lttng UST Version for checks or
> workarounds.
> 
> There is the lttng_ust_loaded variable that could be abused to carry
> an packed version instead of 1. (Of course that could always cause
> fallout)
> 
> Regards, Norbert

