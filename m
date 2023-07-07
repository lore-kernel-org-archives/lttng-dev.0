Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8FBEB64DA
	for <lttng-dev@archiver.kernel.org>; Fri,  7 Jul 2023 18:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1688755073;
	bh=mdQaN6sg3p263My941kRYYFiu6wO3oGiUd0W/R5yrLc=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Px0rDMLIOPs5PAtmEA/YWlqaerlAvRadXakC1TPop0860CuHRHoRMB9FlOOTjP29F
	 zCOhflfM9bEFU2+zAHo0tRGmEjrfkY+GPsrob0w6xvdaPNgDayA1yGrMuU8ddEQb4m
	 c4KKwt/kii07gLvKDTfrx484sHtIlIwm8cz/5PVxccj+tRx+2mdcT9Gx6JA8EyZqPs
	 PQnODnkQWwy16cpHUvahKs4idCGZV04cEF8F/7z/6bJRI5Cpg7n47YlPO04EeCP1Aj
	 xGRntWMMH7rHLy9PReALGXG7la49hYmJZHevRXafEKk2qcAKfPUudcNGiVaRoGk57c
	 KCTNb0FVVBVHQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QyMb44RNNz24Sn;
	Fri,  7 Jul 2023 14:37:52 -0400 (EDT)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2086.outbound.protection.outlook.com [40.107.116.86])
 by lists.lttng.org (Postfix) with ESMTPS id 4QyMb24mLnz24b7
 for <lttng-dev@lists.lttng.org>; Fri,  7 Jul 2023 14:37:45 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRvfm/ULrpHbj31A+XDSrN62rLpat4G5cS+lV9E1XVzU0ejmZq4sKTPrOquca3SkBIVZWsKluQZS/iLc9Y2sroWVgZNakV0IS5jiEdNmfb7e5HVvJKHEcl9sx9z5LCFRPLlSXB/DkX/sua2FZLBD8k1nvcv5ovyIWPyB1UHNDJiyDegdAxkO5kUJyYaNhJhoGcP7egMJepsipIrodS7QtSY5pscO8SgD8eRnHxPTHvhiSfwOGhL006kYNTUxLfDYL2e8kh/ILaslMoR5cYBHytYMiPIBsN9CNj77Q9J/oJFTzCAjCdIh1CJi9YL9EWlqg2mNhX4QekdmjOZ3Q4BngQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPBK66MwLP3cjKRNR3Qhhxn1Qe/jmUkXIXdOTLiMBNo=;
 b=cUzVR2G8TbYqsQFWYy2RT6JqZ/tlLmHPjmyVjWMTFuehUMPiOBxpvKw4cPHrowpVI5M5PNZH0aCjIuZ196jkBEY1KKbUNPoLdpcKaQZX5thZdnwsWhx6z59H86NZjfR5q5OzcVKb0iTPZNrtQNFhqzoC9DQqXOSdRn9e7AC2uwiFKLdD589hc4P+/4KDdPEnbUO5+mtLfw9rhm7YcC6HwxDKfbmK35EzIIQO5vxQDkeBQvWkq1i6wbT1sOAaEpk480WeLYFSYJGuo9obbn67EeEt1X/v+XfQiG1eFpDh1MaQ1yQbxnhyrAPpq8P/7CJ11Nwc8yke/RWUAVEmM5bsLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:24::5)
 by YT3PR01MB9250.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 18:37:43 +0000
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9da2:5a9:2be6:8616]) by YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9da2:5a9:2be6:8616%7]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 18:37:43 +0000
Message-ID: <9b8f3bca-61f9-998d-3215-48b974a04bd7@efficios.com>
Date: Fri, 7 Jul 2023 14:37:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Roxana Nicolescu <roxana.nicolescu@canonical.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, lttng-dev@lists.lttng.org
Cc: =?UTF-8?Q?St=c3=a9phane_Graber?= <stgraber@stgraber.org>
References: <20230703182859.49731-1-roxana.nicolescu@canonical.com>
 <01b221fc-05f8-ac1f-0c88-9875fd945e9c@efficios.com>
 <4a1b6647-3870-41c7-7335-862983e60346@efficios.com>
 <ecbb3bbf-b61c-a777-2ee5-c81231a2b8c1@canonical.com>
 <2c6e0b29-0e88-4dc7-6691-7a89a5428932@efficios.com>
 <ee4ab50c-9847-7bd6-b0a9-479f6d06fe32@canonical.com>
In-Reply-To: <ee4ab50c-9847-7bd6-b0a9-479f6d06fe32@canonical.com>
X-ClientProxiedBy: YQZPR01CA0173.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::16) To YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:24::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB5080:EE_|YT3PR01MB9250:EE_
X-MS-Office365-Filtering-Correlation-Id: 944e00b6-ec83-4021-4ad2-08db7f194078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qmBwcC7C0vQd8zi2j/T7C4eUHhg3E9PzH7voipVzTdtzNLjhtvFdm7hLXSUF8/mb+F72PRCbdpkcL3D+BJDw/1/Z68qpEKTRVJO1hEKsh3jndZ65x3PX484FbCMHVIBXbB1UKOLQPEBbFFGA2C/vOTzfttyvFwhNSKmaEEcRynHGt9MbvxEw+zlsWEpaFOXH6lXJmDwwN483OO+EfOBebPkM4aZUf8iaboDOB312xWtoEDfI2dkGGEzJNgqNu96r7XB3RxvwAP+G4JL62/IChvYarF+bs3ri8NB6JFRczE9hBpU4tmLGJHeqpjfjscAFX4Sr4b0FDfKMJ9emjn2mbaEBHWLidczqBn8b69viRudejk8mWQJcH6ANsZZrTCxBZ8qEef6bsOxaP7lLLBz2yjK2Ln71yEkfgje5DLmh64P5nf/gq+FA4RjZO7Ux3E74hS53VrAEdYsLMAL2yIz1QRBUSmp7XMkobJd6aqA6uSO595IWFfV6QQK0/CtaBJYbv/a7omKun1LECGQnU7Cc5l+C8o0OXKsjGuOhGiaHFXX/uQ0vw9mL7j+WUBcVYUyRcC1tsgp8q+kzWiaxf1fCYdNuUTnFv1GxfQBwzTykVAQc44jrsLg3qbBkoqvhszBOFaz85j2J8ljEB6cg0EDoZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(136003)(366004)(39830400003)(346002)(376002)(451199021)(8676002)(83380400001)(2616005)(2906002)(6486002)(66476007)(66556008)(4326008)(966005)(66946007)(316002)(110136005)(478600001)(5660300002)(6512007)(6506007)(186003)(53546011)(26005)(41300700001)(8936002)(38100700002)(36756003)(31696002)(86362001)(31686004)(66899021)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmx0emF2c1dSZnZYaHpGTGpQNmd0K3d0cTR0THNJY0M2akEvVE5aZmlySCtv?=
 =?utf-8?B?SC9CMS9zUDhvWWswdUxpQ1kySEFmN0cyUnNtMDhaaXB2aHBNS2MvQVp4L2Uz?=
 =?utf-8?B?RWtrd1lPY1pDcjFtdFJXYTF1RVl2U3Q3MXNjbEwxcGpmbnRiU3MvdGFUN2RT?=
 =?utf-8?B?OVg5RnhQVUMzY2lJemh3MjdMYXJkMGFWaTlQL3NCTFpjRlZpYWhEZVozS0NI?=
 =?utf-8?B?bDdnQTVZMVZXajh3OFdyaHFoeGxVV2hTRkc4RmtENnRKMFc3UkhCSGJGUU9V?=
 =?utf-8?B?QWdnWGNwMG44YVltUHB3ZW02SzNiZjlrMnhwdnZsSGZLV082UzRLNmVjdUtX?=
 =?utf-8?B?dnAyN0Zob2RRaFY0NjNVV3c4V0xpRFZIVTd5cWpCekNwTVRxVlkrN0JkTUlR?=
 =?utf-8?B?WHl5VmhsN2hCQ0hubzRWQVoveFd4WnhJOW1GVTZPa0hxZ2pEbldFaWd6MnFK?=
 =?utf-8?B?TVFRdllwYTFkRTZiQVM3Y29KZlVWUDdVbGVvVjdvMGhLSlprQXlDSnRJbjQx?=
 =?utf-8?B?ZlZ3MWdOY3NuRlNSdUxuNzhvbTFnYWNLUko1czY3WVpxL0dNRkdEbnd5WXFj?=
 =?utf-8?B?cjVNUitOMlRIT01VOUlMR2Q2Umx2YjZIcHN2Ny93Mm5IcTl4STJRQ1o1UWhR?=
 =?utf-8?B?WXR2Qi9xVVlBUVQwSkxoMTV1ZmZhVFd2dHhLejBTaG9sU3U2RFUxbmVhbHlt?=
 =?utf-8?B?WkxQbzlra3N3T0RGc1ZNd1lsYUVPWklycWFKYkRFUVJZVmRmYUJHMVk4MXZU?=
 =?utf-8?B?aU5WWWhyNkYzOWttMnVoRFVUd1FoTU1lL1pSWkJ0STdQQ0I5T2NELzFRM0FF?=
 =?utf-8?B?cFFXa2pUaXlyekxnVWpQRTQvdWJ5aEx4NjZwdDVoQTA2VU1EVGpXa0RmT0Nm?=
 =?utf-8?B?YWNORjFBbDZySlVheFVlc093c0pBejNycUd0UHhCc2lVTGl2Q21ZRE16VVpI?=
 =?utf-8?B?Qk5IaGpTam5VVkRvdlhSWkJDR2xzYVdQa0Q2eHd6MDkweTFLY3dBKzZ3YU1k?=
 =?utf-8?B?M1JxSEJUNmlBMzl4QzVZVlRTNGxyL3pFY1p6aWZHWGowRkt2dy9uUG9hQlpL?=
 =?utf-8?B?TlpqSFVLT2VrenNIUHVYSnNueWxzTzViMWdHZWxmRnFkVUpCN3RTZmI3dy9Z?=
 =?utf-8?B?alNRSFlpZitkYzVxb3QxT01oajRjeHVwYk16MnZaMndiNVJhZlg0S2VtUHps?=
 =?utf-8?B?RlZOVGtYTG9SQnF2NzBRY3ZlVFFlVUpWY3hZQ3ovSkZyaVJJMktSL3lYZ3pw?=
 =?utf-8?B?RURyNVI4NDhmTXVicTFBNTN3RDJqQVVvbmMybXEwcDBUa3kzaUoyZU1DTFli?=
 =?utf-8?B?U1BZVnEwbWZObzdKK240OHBNZUJUREEvdmNqMXI0SHFhKzJpQ1dEUXZwNFFP?=
 =?utf-8?B?THp0WU14OVBQUHc0cTlIVnhRek9WenJmb2pkMjNzVkpicDJGYVJuejB4UzJM?=
 =?utf-8?B?TW8vS3JpTGh6eFk3bUM0SStXKzdVWkJhQktjMlRKeEpVWDZUNllHckFBQ1FF?=
 =?utf-8?B?clQ5S1Q3TmlHN3ZEOGtjc1RES0pwNFRuMUk3UndLWDRMdHZ4cGE2SDdOTTV6?=
 =?utf-8?B?bzdyVjM1dHBlSmJBc3YyS3FWSDY3SVZJQ0F2dHlSM0VMNDNIMU5TQkE1Rjg4?=
 =?utf-8?B?b3U2aVlxSGtIRXdUR3ljajkraVpyYk5mSks0aktaTy8reEhkekFIRzdrcTdi?=
 =?utf-8?B?NnZ3SzlmM25XdWwvcVdJZFprNW5EdHlwamdvWDJoT3VtZ2dRYW5VTXlkdEZw?=
 =?utf-8?B?UG5hRVhxaHU2RDlGazg2V2dIOGdUVisxU3dpSWlIOUJDd0NwREdYU1dJK1Ix?=
 =?utf-8?B?cEYyeHowZ3NMcUpxandWYndGTUVyYkZQMHNHZm0xZE1DTUZEaUphRkJuLzNr?=
 =?utf-8?B?dFRkV3dqRWg1NW9rc1p3bkl5aWN5cHRERVEvWCtTNWVySHREVEYrZnZCRVA2?=
 =?utf-8?B?TlZXaml0bDQydmtMOEVaTzN6V1lCd2lNSkE2Q1gxaEQwUTYyNmNaRnBSbmRU?=
 =?utf-8?B?RjZGOFFyUEdNbk9qUVdwbC84blh2SDZUcm1kYTlwdUNqd2Eya2hmcy9SZFZW?=
 =?utf-8?B?ZzgyT3JyeVBZc24vQnNZMm9rVFM4ZzdrTUxRWko4dmhPSGFTUEFNUkZ3WDlD?=
 =?utf-8?B?MnRZcUpZU3hOS3NsMDlrMmRBd0tJNGY3VUt3VGwzWENLVUtETkxBZWduY1d3?=
 =?utf-8?B?cUE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 944e00b6-ec83-4021-4ad2-08db7f194078
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 18:37:43.6581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +B69+auJzw3s0ofIMbiKS7gSxtFifm2tRy8xCO/HdS+lU3jdB/LWZj9GfvVGhCnr7u3NAGlpes2Z7FCVZmQv/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9250
Subject: Re: [lttng-dev] [PATCH lttng-modules 0/1] Introduce configure
 script to describe changes in linux kernel interface
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
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2023-07-06 17:10, Roxana Nicolescu wrote:
> Hi,
> 
> I gave 2 derivatives as an example, but in fact there are more than 10. We 
> will end up with a bigger if condition that the actual function 
> implementation. And this is also not a sustainable solution in case there are 
> new derivatives coming after the fix. It will be hard to maintain. Plus, to 
> achieve this we have to release a new kernel version to expose the suffixes in 
> utsrelease.h and getting the fix on the user side would require a reboot to 
> upgrade their kernel version.
> 
> While the current solution based on versioning may be easier to understand 
> from the developer perspective, it adds technical depth to the implementation 
> and in fact it requires more maintenance than expected, also on the 
> distribution side. When there is a change on the kernel side, you need to 
> check if it landed in older kernel versions and based on that you need to add 
> a new interval in the if condition.
> Now, looking at the configure script approach, while maybe not as clear as an 
> ifdef, only one change would be enough to solve this problem. The LTTng module 
> does not have to care about each distribution's way of versioning and the 
> distributions don't have to deal with issues on their side if they use a 
> version that the LTTng module did not take into account because you were not 
> aware of it.
> I think maintaining it won't be that hard if it's readable and documented 
> properly. I am more than happy to improve it and help with maintaining it if 
> you agree on this.
> 
> All the best,
> Roxana

Hi Roxana,

We are still not convinced of the benefits of a configure script over the 
added complexity since the issue is specific to Ubuntu where you choose to 
maintain 10s of different kernel branches with diverging code and overlapping 
versions.

I made a patch [1] with version ranges that adds support for all kernels from 
the kinetic "linux" repo [2] including 'generic' and other flavours and 
'lowlatency'. It however doesn't cover 'linux-aws' or other repos which share 
ABI numbers with 'lowlatency'.

You can of course use the configure script approach in the Ubuntu package 
'lttng-modules-dkms' by adding your patch to the packaging code.

Regards,

Michael

[1] https://review.lttng.org/c/lttng-modules/+/10485
[2] https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/kinetic

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
