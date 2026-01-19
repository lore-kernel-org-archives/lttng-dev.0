Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809D0D29C4B
	for <lttng-dev@archiver.kernel.org>; Mon, 19 Jan 2026 17:03:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dvxbl5xKtz28Cn
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1768842181;
	b=KmDHdJdoEDhZkUahUhki//vfpAU+WRq1JuWDDMa103vd/Gg2zQ6wO5gV/p7o+XRNqGBx
	 33YJ/abeFaPSiJdDOP7OjPHPSi6bw6afFDeOz/uykuqkeg+JKRBcpZVw/g+zb/IJHsoe8
	 lORbaiimHGefXZBws9ygouzE54rXm2pmaVSlkSu9HoEsrpOYYZPRsDt/hpQyTAwGawwlN
	 xwtDYfh9UwUc8p5S32+FY+Gl459gNHuZM53sJmWd/WHyrWpkf2RqsX2VavQN8D7GPkV8x
	 OQU6JANd51dDgVW1UOUaTi9Tuj0b46snpBRalrbRXY3hTX8VUmOv9YQEa2b+iPy+30g==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1768842181;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=KFMPxs0QE2fLaXSXED06ZAaIvOdSqgpacOoJLq+pVac=;
	b=IYULr8eBnMQmRcnn/MF+e63oiKUCOdGWYVsQqI7khNpa0UnNCBbhp+4fMbc1jren9shM
	 WeiawAf+NyUPFW+jOZd7YgLj1Ke9WuHz8Pugu5xrnA1sPJ8LF8Pno3Q5fe3GGzjE3sA6y
	 68aDrqbNAZUUYMbHObdGAkcTDwD/Nkdoaove80hUgYAfPYrN3FNrVgvme/CevT+5M+U2I
	 NE3KUjboS16GIiFnwaI8X2ntnph0ejeE4WGUm0W3SGq6AeP9Uv2Nm60sO3Han5Iz3KfsG
	 F4EKKmvHIlW/UEh9yXXgSBmdK19/5K1EvDUHxuSAPB57LRu8DP8+2aG1D9z9pJqrgQw==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dvxbl5xKtz28Cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1768842181;
	bh=8wE7bOmIlveRkSLd1VsWrl7pteo3YqClc1y+deZlzOU=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=Qal0UmX6fQ18uo9RtE5GK7gt74yHJ/0JYXMoEPw1fGPStGHkH/pLkmN7G9vYecAkn
	 MFmQsRNblikhzHpBWsqXQPB22po31iWBjhh6eyx6q+pmlgelwLRfcTZNBBmCr20k9r
	 a+35jXwfv1EZi7znCQ7X0gsMlR47EWboICtE013HF9ml5DqcbmlKcrNJu9haYEnfp9
	 eSF0HY3XlmlBS+RjY4Znl4GsWLlMqvHsM1JlykLM4SgjS3NSFxp+8ITm+9fE+JF9it
	 XH5HQNwZi15EIbp3loMrbP3yeAojpDdsDwUlhFx8OQCSdfwysjNJ0MFkM/ZWR2htcf
	 vBihIvpPmRxCQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4dvxbl5xKtz28Cn;
	Mon, 19 Jan 2026 12:02:59 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dvxbk01dNz28hY
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dvxbk01dNz28hY
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c104::])
 by lists.lttng.org (Postfix) with ESMTPS id 4dvxbk01dNz28hY
 for <lttng-dev@lists.lttng.org>; Mon, 19 Jan 2026 12:02:57 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWI1Nn8+dVdC7WRaiGCkR9JhjvQaAyITQAn/HRC27sFUQnqkZOqs2AVX2WcUlRoA15vnBGDhAf6woNtvqmvzo+yveF9pvHexm+wRqVELPyDw1tT78j4AyAGz87eIg46AYArGcSaLmFIZE0i8BZRNGlK12zrI/7Irt7E1bbd1Oh76SWIPb05NfKzyDEfdDOtWOiIlYI6g9/SnTYu/Si6Cym5zZnkJyR7eLh/0TCsH2tnoBQIeBQa+NGv7C00MB5nc3U1hv7epZ8yNTdq2PdKnztr4xUCOUgRud3nSi/0myT3TmiVoBTOZPgU5dQ/HX+nIwzd6HDujMG7pHUDtj46Uqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wE7bOmIlveRkSLd1VsWrl7pteo3YqClc1y+deZlzOU=;
 b=fELW5vj83/HUBrvSueuGeigXLIBer416p0ikTyHlqnjXTGPc/mBDF8AAFqyGqgX4RKuT/yHeLgMmm0z1XakavrW3XbF+RSNF4ZGgw73XokAVubl3mKC3aEjZMETPyVxhJNeRQMsgduGJZmXJrorp+3k2CL2EltlmCg+fc/7N2rgn7gPiXb83w9bCnkHr/hqFDZbbowH1EXWziv5vopSJIWNuttDGJUvJt4AwI9UfViA62Rpx2hzJdiKw5q8ous6hD6A5KS7cbYstprIXu+UKVxrasZCVwu+lWBd7rRcjhQftsWQ7Ac5vRXMVW4t4PniuY2bnpmciMc7oWmowbzhTZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:42::24)
 by YT5PR01MB11142.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:131::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 17:02:46 +0000
Received: from YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4c7b:7dec:7e59:918e]) by YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4c7b:7dec:7e59:918e%3]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 17:02:46 +0000
Message-ID: <c3a11b9b-5cd1-4a0c-b15c-d86a5f0d3924@efficios.com>
Date: Mon, 19 Jan 2026 12:02:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: How to build lttng on RHEL 9?
To: lttng-dev@lists.lttng.org, David Aldrich <david.aldrich.ntml@gmail.com>
References: <CAJK_ieh7GpnMBe-J3ktiU4EmE2puqafgx4pmEBoJsbqKz9LEEA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJK_ieh7GpnMBe-J3ktiU4EmE2puqafgx4pmEBoJsbqKz9LEEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::7) To YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:42::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQXPR01MB2357:EE_|YT5PR01MB11142:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d2cfa4b-72c1-4370-575c-08de577c9127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEt0U2k4ZUVOZUNqMDJBbCtxR3l2WEQ0eU13bzVZMzZSVUV1R0d3elEvQ1NL?=
 =?utf-8?B?dGZHM1pGbWtwRU5KZjJXd0dqeWVXdXVKeXBPdDg3R1diN0RjclRMTEJqTm5W?=
 =?utf-8?B?VmZNd1FBbXp0ajdLcmdpNVFEdFNnTFhyNWRBSlZCUjVaRUc3Y2M5RTExUk4r?=
 =?utf-8?B?US9MajZLN0t2djRXQkpHalFwTzYwVi83Y081U3poMlVrK1BsVnRFa2ZVYUlY?=
 =?utf-8?B?NGhKZXhjVU4xQlcxbjFYOTZHQU1UVlNIWU1JRDYxbVprMExiZ2h4d0xDNHp1?=
 =?utf-8?B?dXRsVUIwZ1Q1UGIwb1hqb1V6V0FyK0FjVStkTzdVeko5ajhkVlJjUW9XNzl3?=
 =?utf-8?B?SlRaa3gyNUlxUlRVUVlxU1RFclIwSkVpdktITitpQUx1Q21Ed05sbUwyYnU0?=
 =?utf-8?B?SWN5MGl5QzR6N2tOeEE1eGJtRFcwUStLYVN1b2hudjNPNFo2Y1k0NXYyeHpU?=
 =?utf-8?B?eHg5V3FMTGx6QVVRbWZxM2hNU0JuOCtzMlMxVVBTem9jV2hYSU5jTzNBR3R3?=
 =?utf-8?B?aVNMMjJETWQ3cnhQT0ZFeVRKby9kR1MvZ1VzMjhWV1RMNWg1TERiRzhSR0ZB?=
 =?utf-8?B?OGxLWXZvb1Q2Z3JrK3Y3NHRxUkN5WlhmNnBNTlEyR1ZYYXpJOFI5N1lXL0N6?=
 =?utf-8?B?T0xIK0ZmNlVUbUluNlVrejBTakllanp2WnNaa1l4SDJlWGc0bFRveVJYaWdV?=
 =?utf-8?B?cWxFVVhlS3k4V0lyVmJ0MndHUWt4ZDYwQ3A1bmtQMGFUZGFpRjZ3cW1mOG5w?=
 =?utf-8?B?Q0x0bk1wRForakR5N2EzZWEvdTNpNUQvVlE1M1FqZ2MrYlVXMWE4WThSekl3?=
 =?utf-8?B?UXowQmFSYlQxQWQzcmNpMExrQk9XaU9EdGdMZnN1Qm1ZdDVGWHd0Nm4rZC9u?=
 =?utf-8?B?RklMeWZTVVpOQ3hmNEsvTHVXUVdPSEE1WnBJa3hodkdJMFpSYnl2V3VzbE4y?=
 =?utf-8?B?dHNLNVo5cU96MVQraFEzZHF5QW8wcWE1MFMzM1hWTGI4M00xY015QTR6MXNi?=
 =?utf-8?B?Vm11aFFYVWY0YmtvQ0tVTG5pK2JwL1BPeVgzVzBJRjNxSzRtYTBtN2lCc0xy?=
 =?utf-8?B?VWdiZjhiVmExMVh4dzZnbU1CbHdmY2NHTnhoTU9kM3A2T3RRRDlCZC9QeVUw?=
 =?utf-8?B?TzZxZHhlU3NkUW4xb0RXUlU3T2hRdm1ka1g2cmUxcXhLWWtjMGZLMzZQWXRQ?=
 =?utf-8?B?cGxwaVdDdU9UcDI1b0NDdWE4WFhtUDZPNDBQaUZoV1lDWk9mN1hCZEphekZ3?=
 =?utf-8?B?S3dVMUZGcWpwQWR5cWVBYlc2Q3dNM0UwZUxiUDBlcnQyWm5FRnBPTnBHQ2Y5?=
 =?utf-8?B?MGZsYWp0ZWh0VWJzSDR3dzBTd2lUYnI1UkpQamdBbEJ4U2dxUkp3Wm1LaWdz?=
 =?utf-8?B?NGxtc1ZPdnVLOVM0VzlKRXlpTEpYY2ZmQkZ5aUkxampiTGw4ci9sNjBvVVc5?=
 =?utf-8?B?VHZFNkhVNkpKVnJhajIrbkcySUdQOXNMQThaL2orVGtPZG1DanovUldrTy94?=
 =?utf-8?B?U1hudVhBY2hlOTBYN05NMkw1eGlEMlZzY0o3TG9iby9MS25nQnFqZXB0K0dR?=
 =?utf-8?B?S2liUXN2Q0RhVHFMRzdHa2JwUGtqTGRCWmJhZXB1VVVvZngwZVFQTXBrTEpl?=
 =?utf-8?B?NnlERzhJYXNNWU5IRzlrYldJaW5naU5ZcytnWlJNdnpDZGZ4NWhDRUFxZUJl?=
 =?utf-8?B?WTVtUmpKakJoRGIrUnN1U21iL3Jib09qckFJUEF6ai8vOEpoL1RBMXFveWY2?=
 =?utf-8?B?MDdPYU9ESUhpN2ZlRzBsbWNHNnNIZ0hBT3F4RldkdVBYa2w3UWsvMGZlcDhV?=
 =?utf-8?B?N1IwUU4vb2had2ZQcStLNVlNR0UxeDVuWU1YTHJlNlFuekp4a3l4YUFjMXk5?=
 =?utf-8?B?MGpDUGxOSzNqd1A5bWFyQ0pqbkpkU0hWS2J2WFNBQnlyTmVwKzJPNlJ5ZWl0?=
 =?utf-8?B?QnVvSHhFaHBtUFhyS2FqOFBxZ0JUektOcThmWSs5WU1XYUJ5WFNiOTJOc01a?=
 =?utf-8?B?MitzckptcHVpRWtCZklCY2Y2dXBHeEd5MS96UFRwRjNDRXJqeTY5V2hTUm9s?=
 =?utf-8?B?TU96WFJqd240MThIL1BNMTdvUjBmeE1JQ2h2RjM2ZjcyaURud3FKQmIvdG1h?=
 =?utf-8?Q?rlMOmKXD6JmOGUoehjlQJEbg9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUJkWDcyNWlleTEzdXU5M3dVSHFRZyt0eExuc25TZ1RpSWp0YmFJOEZQRlQy?=
 =?utf-8?B?V3RNQzd4Rkd0VFVON3dQV0dPQ0tMMmJFSklyZW9pUWg0bEh6ZUxhNFVjRDhM?=
 =?utf-8?B?MWZvWXZGZElzcUtZN3RQMjA2NHR5NGwvSzRPZWoyZnhTbXo2cTcxVU9PTWZ0?=
 =?utf-8?B?ODM4RDdtcWJ3QldaUnlNNGdrY1pTSWxpMkVuQzlaaU03eWwzc1VETnhRa2tv?=
 =?utf-8?B?QytOOFRaU1AxaXpMUm93QytUaFN1eWJsMDNYNU5YVkNESUpOa2tLbHpXdURR?=
 =?utf-8?B?SllsK0VmVGw3RERTQkNzRmZoMkN5OC8xWkZ2MThqUnIxc2JvYmZLK3hjUTZL?=
 =?utf-8?B?Q1pPK1JVVlU3citnbUlZTndwRVJVNEdvZGFXaTlxUktMSW80ZnNWaWU5SjFC?=
 =?utf-8?B?ZEVKU0UzSUdxMDR4YlBPZ0ZsOVJKUmVLbTVNOWt2VEsxYi9EQmVmc1oyVHM3?=
 =?utf-8?B?UjZTQU50T1dpcy81VVk2M0EzdDR3eVYzMHNieFVtbUM0cFNFWi84RVd5MDA4?=
 =?utf-8?B?YnJBRUk1NTNuK0poMDNudlpwZnhsVFZsQlBRYWkreXQ2RzBuR0hyTmJ6bHpq?=
 =?utf-8?B?U3FvbkYzNURlTnJHd3QwMFZMMDVMTUhoS2duR0cwV2pIZWdSN2JTZk03NnlY?=
 =?utf-8?B?TUtRak00OGd4cVMvWU5xUWRnZ1BQcW81a2dpbWRSdXo2ZnFHZkJzZ05rTytO?=
 =?utf-8?B?MHNtZTdrTmdFdkNjM1FyMCtMeWdmbURkVnFJYm92ZFJFZWd2bjBRemsvU0tX?=
 =?utf-8?B?VGRvYnJ1M1dlc1plT0t4SDlyUi9UNnlSMHRLMXRVdmRaSG9TSGVyYUNVUkJU?=
 =?utf-8?B?c2dtcUNhOGVIMTBnTzJBNll1a0xWVncxb2NCRVRzVUxtZzVPc0tDT2lUbWNI?=
 =?utf-8?B?TlRiSkJsditXdHZ1bnVLVHNPaUlnUWJsV0VvdzNlQUpaLzdZdzBkbCtVd1FR?=
 =?utf-8?B?cUpVYk1KdDBkeE9WdzQxdHk5aTBwSnA0RFhpRlIyZTc2T2IxSlFvdzQ2K0VS?=
 =?utf-8?B?ZXI3YzlmWlo5NytBa0VSbEwrcEFIWjhCR2VjQWtBL0VBRXdWUWw4S1pKRmZv?=
 =?utf-8?B?dE4rL1VzQTUzRWVqSEUzZU5tOUNLK0VZVXdvT3IxRmN2WHhKcXZOVk5XNXha?=
 =?utf-8?B?NlFlV1I0b1A4NHZ5L0JTaEUyQzZEa2h1Z0hzSlczZUM0V05jUzRtVDVnWk5J?=
 =?utf-8?B?QU9Fdm9YaVRZazY1cCtEbHVOQ0JkY3dpVlRsVld5Q0xzUGlUd1ZadklpSWhh?=
 =?utf-8?B?QnhDQkVVRm5YL0RybXBiRUFzWElzRVVQelRtdS9MbEtNeUkyYWpyM3hRaWVN?=
 =?utf-8?B?bzlLZURzZUpaMU5VK0tIQXRDdlJhUko0SmhpWng3US9HU3hwa1dFeUpmVUcw?=
 =?utf-8?B?M2tlQWZYMm00ZXV5aTlIb1N5VWU4LzNoWnJhcXRmYU15dWwwOG1JOUp4RkVP?=
 =?utf-8?B?Nk9jUlU0VG1EQ2x4encrQm1iTkhqNTBMVjhOK2pRVS9la2Vsd05rU2MrMUhR?=
 =?utf-8?B?cExHWUJJQ015Z1RlV01XSkQ0V09GMnoxNWJNLzltME50REFJSXdEdTVtaVR3?=
 =?utf-8?B?N0p6TkttWnZhTXpVVnVZZlFGUG9oMllFalVPRHpVUzNsenlnTG9ObEJFTk8r?=
 =?utf-8?B?Skc5WEhsL1ZEYW5QTHE5eHpsSGJzM3ZydEdVMk5mOWJoN2s3K1FPOTNqNncy?=
 =?utf-8?B?VDlQamFFZ2EwM0JUL2wwbnlydEtkWGpzWDJzMSs5WVp5Snh1M0g2UWZ2UWt5?=
 =?utf-8?B?TWNNNkl3bkYxZEVQRmV5UEVjcnNDU012Tzg5Z3htb3VFeUdqU2xEbDVVb003?=
 =?utf-8?B?endCZDRPK1pSMUMwTGd2UkNETGpHUWx4TERBaUs2UFFCVkRnQklCcXdBd25w?=
 =?utf-8?B?SVF0UkdQRGF4YjkxbkFHNi9zbGRja2FSdDBMMnhzeEpTajdueGlkQ1VzdHlK?=
 =?utf-8?B?Rm1XSlg1QWw5TVdmMzlyVlorT21wUkU2cW5lcmxkTFNSaGg4OFBwOGU1ZjhW?=
 =?utf-8?B?TEFuT2JpMGZMTGNwRXJQTU1YRkVRSHFNQmJVc0huZlRRd01jL2lrOHprTnF3?=
 =?utf-8?B?SDlQUm1mNWlsZkpwUm1vSUFiNjgxd3NwUGlsTWFsUVRIeisvZEhGanU1elRh?=
 =?utf-8?B?S09yZXpGZGZ5U2lEaG1qS1kvem9OT2NQdWZPVFRnc01pNlJybHgvYkgrUVV3?=
 =?utf-8?B?MzRndzYrYUg2SHJtUE5Nd0pyWW1aZk1ocEFqNXhWWVlCa3dKTS9ydFJNZ3hR?=
 =?utf-8?B?WFNJc3FPUzJQL1ZVMmRlT2pWSzhuekhuMUI2b0d2cUtjenJVeVdYc2lsUmdS?=
 =?utf-8?B?ZlNnbTBJS1hXVkhOYWVyWFp2NWRGTDZNWFNQQUNBNHQ4U3d2akdVUT09?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2cfa4b-72c1-4370-575c-08de577c9127
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 17:02:46.3152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Zjn/R190ej+ZuyOjsHG+rCAV/ohi9nTKP5w/CSl7yVxv+CXeKYYuzSCJPOkrwiyMQQj0C2sLlScWrZrePx29Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT5PR01MB11142
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

Hi David,

RHEL kernels often backport a variety of changes. It is likely that 
lttng-modules needs to be updated for the exact kernel you're building 
for, which is usually just updating version range checks similar to this[1].

Based on your error message, I think the version range check that needs 
to be updated is here[2].

What's the exact version number of the kernel you're trying to build for?

thanks,
kienan

[1]: 
https://github.com/lttng/lttng-modules/commit/924b0ab5ad13570c4d4a305839684b37538064d7
[2]: 
https://github.com/lttng/lttng-modules/blob/b1a23b9733ce6217659bc5e62961d128794a2beb/src/lttng-statedump-impl.c#L389




On 1/19/26 11:00 AM, David Aldrich via lttng-dev wrote:
> Hi
> 
> I have a build error for lttng-modules-2.14.3 on RHEL 9.6:
> 
> lttng-modules-2.14.3/src/lttng-statedump-impl.c:408:20: error:
> ‘dev_base_lock’ undeclared (first use in this function); did you mean
> ‘device_lock’?
>    408 |         read_lock(&dev_base_lock);
>        |                    ^~~~~~~~~~~~~
> 
> Please can you advise me how to fix this?
> 
> (I am only building from source because I assume lttng packages aren't
> available for RHEL 9).
> 
> Thanks in advance
> David

