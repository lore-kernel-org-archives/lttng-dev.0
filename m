Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEE1C07E9D
	for <lttng-dev@archiver.kernel.org>; Mon, 26 Sep 2022 12:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1664196625;
	bh=pldSOXByadcnaGqTtvaXuVD1dKb0oUJUiXhqQbOcYic=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=JlDqna7U3wqev/hAtNisNJABnNO3jermZkR4hz0YNwnFzajZ2DFDgoxtC+GXqg5YD
	 8q/9SyMoapiqfB4suHTd2CRIkZWl085G5O2OhqQqP5NzgwzIhUun64WF3x1z7+XT5W
	 1/62Tylp2XM5v9i2wMxAUZNpihr270s/KvGY/rnztADG9aZu2RRSPBRke1tJFhUX5d
	 1xzDsVTUfHJNrEcbvNwkxSVEO1kvAN+XElGYaASwll/a7HYEQNWPI1yHMZ/+S0/21y
	 97g8Mc4VJKV6o5Y2hlWiPkwWSayIrcteqcPdouEfzITy4VFF9o74+1aXtbLZQGB5eW
	 AmeDY2ESM5mYg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MbjKD25YZz25Hj;
	Mon, 26 Sep 2022 08:50:24 -0400 (EDT)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2069.outbound.protection.outlook.com [40.107.115.69])
 by lists.lttng.org (Postfix) with ESMTPS id 4MbjKC3Vgtz25QR
 for <lttng-dev@lists.lttng.org>; Mon, 26 Sep 2022 08:50:22 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyZ6t6bDVWFJkWDFL93tRefIbFOQJgpWkGCK3rqdVGIq3SePrQ+K/lxMoBXEqEZPMzXw4lj7+caxfrfkhocLAdAIK7Lgtpo4H5Vv2XK8lgkohfqv+emRP4JiB8Emnd1SRWF/YasH2e4wqVHIBEaGP8Qm4FB0o3sOjNxEXR4MlJ+ayrdjNCclRJPGK79B1NAkrUCMgJG5W/sCmHAyaK8W7fJPicGQ566yWlV5PhBFsiNGB5FyHrcTsUqpgR4wYSXxplCHDGANEiU6rQd45PtGWGB8YcpJhLxn7T6aLZau3EKBU1W83VAgT8RygG1pTqceqOz3QbTrtz/NtE12nKELqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5fwncrR5VGZn535T/sOM5+nmYs0o1cU9MFkYI81VBE=;
 b=KjW7J85A/1WQ7iRqVNLqJvoV2rbKn+4o8og8Ys+UpIx5SjVonTv5iPiff753whLVVncKtXPqZ1Y/ARcoYdlDeJsHq86l6mrkV077oH0Ogi8UTfd8Tc/6zNNbElsvUEC31SlTfM+NRYVDPDbdihV9vA5d/clSRkCYrQvy9Tu0Gmhi0IhrFZ3UpI19lGKECTyuu1nKnAtcb4YJV9YwnGnK/dkFwx4zgqbMqv0rDX270giLbW0DKg1Pd/4a17utxEE9Az2BQVetHclNQb0Ex1EFFABw2oDOcigOCOUiEk2CFwk6pcWc4hGe7sjskPI4/khWX47vbD3m/V8lDxesFJlSTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB6228.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Mon, 26 Sep
 2022 12:50:20 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bd25:7243:1b45:3fb9]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bd25:7243:1b45:3fb9%6]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 12:50:20 +0000
Message-ID: <a0d4a174-c210-33d8-9e31-0d7d1b6900c3@efficios.com>
Date: Mon, 26 Sep 2022 08:51:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To: Eric Wong <normalperson@yhbt.net>
Cc: lttng-dev@lists.lttng.org
References: <20220922091536.GA4597@dcvr>
 <eb0bc02c-904d-1166-ddcc-39bbece70a67@efficios.com>
 <20220923175503.M564483@dcvr>
 <6db30f66-8237-fef3-d92a-2e36be9efdf6@efficios.com>
 <20220923220510.M990534@dcvr>
In-Reply-To: <20220923220510.M990534@dcvr>
X-ClientProxiedBy: YQBPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::20) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca3e4b3-bf0c-4ce3-be56-08da9fbdabbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XcWRZulYB1b7INahliVJ819sBc0mTslGZaK9KC0qM51fy7/FzKbqaE8NxDR3S9I1BZ99Yu3K/A6wagBD1LmfkK2TCL8spbEhxlKfPBCvFoEDIdVoHC1sadPadG9780cw7WW4MpfpqnNBk4ykfHGEDABDi5uq2VOlrzC3zFyWT8bRAKCwArN4qwhMWVRZEMBPV2+DnRhjbAfjoOc9EgcjaRUpK7aVdQjzfySdwTxyoTfXuCWmHqnk4wbQabV2V2oDQOKz9xLvY8YQkdrwp2MT+kQ1F5HghRUohSby/pBmMe7mOsdRpq2TMnBcnH7SCzpxOY0xbIphiZud7C8xWrZ2pTT2GEWIpn1EfvAxGnLcnQakhhfWQUtfelXpgll+XBcsF6E/y1qPo1tXqg9feGuIGlkdm5y+oGgGDfpbj/aiSlX3Sm10Gl72ujhNMWTA+8qG9ZGFu2SUPo4YXxxsfTEi+WQn5Yjr0covHHRx19nPt6fAEX7pY0kDqxUINmFEde+9EL2jD2hq99JIry5xISeMinMdHlF+IW6cdcl9w1riBYiY0L1fmc81HiVtvcsVGowMpQUFwwJcfN0O1Pd+ZWa6OAO1WVKpdipxlmGMsxAdkc595XeAjNdKwA52v7r7xsHjMaSmYZgUUHKtc3/WN69GB32V1xpoPjineu6LHUjdlSuzG2Jty/ttYnstMgAMU1EGCaJhN7VdUVqi2w9E8kunSJHFH6Zxg/XFjBctryssLZ6z9zMDSURnNxmhGoR6C1UrqAfcZgWKbsTVo9TdP6xhlndp/Fx/y3SdfJ1Sk85WD09G6SkYDutdbXrkOIvyoFEH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230022)(34096005)(346002)(376002)(366004)(39830400003)(396003)(136003)(34036004)(451199015)(41320700001)(31696002)(36756003)(86362001)(186003)(83380400001)(38100700002)(2616005)(966005)(8676002)(66476007)(4326008)(66556008)(66946007)(586005)(6486002)(38610400001)(498600001)(6916009)(26005)(6512007)(5660300002)(2906002)(44832011)(31686004)(41300700001)(6506007)(8936002)(6666004)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1d2S1U5V25XSnJWcHB3SHJ6Z1pjdEh3Q2pGeHp5bnlJNGp5a1RrRmZNUVUy?=
 =?utf-8?B?bnBYWWdKclplcFl3NHRQRmpLdXlDd3I3NCtmZGlOZGtqZzZ5Nm9RdkYwMkVC?=
 =?utf-8?B?NHVRanBCS3gxMmswVUphNjFnei9BS0Y3cHI1T05UbUoyckxUL0JWN09CNzNv?=
 =?utf-8?B?TlhSeTNKWnUzQlA5Y0xuUTBJOEFKUzEzMnozSEdQcUdlU2ZiN0JtNUtrSEhG?=
 =?utf-8?B?TGhldE1iRnlUNzlyWWltUTlJMVFpVFB3VkF1dVVwWS9UcnM0eHlBUHYrNENk?=
 =?utf-8?B?RFVjem1zLzAxT3lCUlplSytNaXhlbzd0SlBjU3JIN1V1QkR0MUFwdTVKRG1M?=
 =?utf-8?B?aFNUQXpzMDI0RVVOYmloelJEWTJtb3I2Q2ZlTGE3eGRUcnpoa1lmRXJEQk8x?=
 =?utf-8?B?T2MwMkJ3M1dYYkdqRGhCbWRFQXQzd1lHYkMwUHVjb3RHdytJMEFFNll3YStC?=
 =?utf-8?B?aE9qY0ZNdG1QcjQ2SytwYXRyZWlZaDV0NkhpNkFpdFNYVkxrRGx4aXlrTVFH?=
 =?utf-8?B?SlIzYzkvOE0rbllIU29HUmRxM2pJanpiWDdYcVlCSGJqNWlDdExUN0xSRjVB?=
 =?utf-8?B?U1Y0RWhxU2cxZ3dOUnBaOUVQdlFBYi95eE1oUnY0c0tCOGsyRTk4eHpSeUdB?=
 =?utf-8?B?Nmx4VXh2ODhSelRGMDJvSUQ2eHIwcjlYTUl1S3RkR3FDTFBucFZhYTc3L3Bo?=
 =?utf-8?B?cU5JbExLZjBjWWRwYVF0b1RoZlpySmVSNHhoVWRjNEJiY0dQajcvdHhQTE9a?=
 =?utf-8?B?Z2RTNlQ5UEs2TlhNZkY0Q2FxSk0zWlVRMERETVhnNDA1SDUxWEUvcG5HWVp0?=
 =?utf-8?B?ZXh3dXhnUkVRb2ZCUXZDcWludFoyUm5kbnQ2UWZFSkh1OFhhWEN5c2VDS2pa?=
 =?utf-8?B?cUw3NmlmbmFENzdQSHNzcUIxRTM2MmJ2MGhMdjg3bGlWNTBGT3AwcS9zM0pW?=
 =?utf-8?B?RW1mUmhZRlp6WjhNOEYvZUFNeWt3MHU3MzhEa0pTZUhsMmFuSnlBUVZlMGtz?=
 =?utf-8?B?V21OeVMxN2NwWFdIYS83MS9Cb2pzWFRWRkpIOU5mQThhbmFRYVZ5a1BLTEwr?=
 =?utf-8?B?MndJTnd0ekdkNHRQUHB2N0VEcGJJRmRIYWl4ZjZDSFExUkp5MjRDUkxVK2xZ?=
 =?utf-8?B?bXc1a0JHTmh1aXpDZDMwWWY4UWxsek9pY2sxSXM2Z2ZINVJqdjdSZ2JhOG9Q?=
 =?utf-8?B?VFovZSs1TEZTRGRBcFJ2eTZ2MkxzZ2dRYjA4b21JMUJVUmxabUhBOFdEOFFp?=
 =?utf-8?B?NmtwQjE1YVoydGZXSnFQYXF4TGV0ZlJwZGpiUE5QV084K1ZvWXg1Z1QwMlVs?=
 =?utf-8?B?NCtnMVVUcDErcWN1NnFEQkd0cWJ1Q1BoaFdVd0hFcGc0OEtNNWptSnMxWlcr?=
 =?utf-8?B?dWU3Z0JnZ0VwODF2U0JiKzV5N0xFQ1pMbFlSS3JoU09WRHZBNDNHVlpFaGw0?=
 =?utf-8?B?V09hcWVvSGtObitwUFBKUXZOY1A2QjVqM1JCaEhYemJXZmJpR2wzU0s5dXN2?=
 =?utf-8?B?SWllc3E4QTNXeGhqYWhYZlZ4NVQzUXlWZVdEM3ZsZlFyNWVxM0FJeHlLUVk3?=
 =?utf-8?B?Y3dUeWVuR0VUUTkzMDRxUm8wd09EbjAvU2FBVHk0TGpRbmFCY0JJN2FDaExT?=
 =?utf-8?B?ZlpocWk4RnhnaFVDN2dPa0hFWmRUYVRzK3BpakpCYittWjF3b1QrWmRVRldm?=
 =?utf-8?B?T2psckdtV0lkaHFnZWRrUTVRL1pKdHdGYlI0SWZKb2kvdmFyWW9HSWRQQ3Y1?=
 =?utf-8?B?WkkzM0paaGNQVFozV3dHajVXVDlicHJUWDlZMW5XK2JBV2M2YjA5VnBVL1NN?=
 =?utf-8?B?YnU4M1Y3aGdUWlBpaDBWdklYb3NacUJ5L3pjODViUlN1QkxPbFY0U3MxRWtk?=
 =?utf-8?B?NTFRZ253czRHKzZ0TmZGeVg5SUU3aVFncVJWM21Fb3JGMU1obHB4ZWlsajBp?=
 =?utf-8?B?bldRdTdGc0E4SUdTTUkrdkRIMEhOVFVxVE9LenU1WjI4dk53bHluL1pjY1dE?=
 =?utf-8?B?SjBWYWZYcGluOTdsVVFyTFJYWkUrbVYvVDdHcjl1NGVnZkNZVzN4aXo1Z0Jz?=
 =?utf-8?B?VTBDaUk5WGt5cS9YQVREMkYyOUFrN3laZTVySktsOXUyL2ZLenVtcWliY2kv?=
 =?utf-8?B?M056d3RZZDdpUS9zalkyWStvUkpvVGFYbml2UjczbkJVM0Q4YUxCcTdvaFJI?=
 =?utf-8?Q?JX/k+DzHgQVB2QriYFKnT9g=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca3e4b3-bf0c-4ce3-be56-08da9fbdabbf
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 12:50:20.6701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EM9b/yVmWoj5bTfk2zjIesyTe/AB6Bm5K1c0JdRwAekwjToRwr7K7suSt5cXE79pQ6n/qbIdZ5skUAdJOpMCIQFbebjM2kCsuNnyByzHpuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6228
Subject: Re: [lttng-dev] URCU background threads vs signalfd
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2022-09-23 18:05, Eric Wong wrote:
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>> On 2022-09-23 13:55, Eric Wong wrote:
>>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>>> On 2022-09-22 05:15, Eric Wong via lttng-dev wrote:
>>>>> Hello, I'm using urcu-bp + rculfhash + call_rcu to implement
>>>>> malloc instrumentation (via LD_PRELOAD) on an existing
>>>>> single-threaded Perl codebase which uses Linux signalfd.
>>>>>
>>>>> signalfd depends on signals being blocked in all threads
>>>>> of the process, otherwise threads with unblocked signals
>>>>> can receive them and starve the signalfd.
>>>>>
>>>>> While some threads in URCU do block signals (e.g. workqueue
>>>>> worker for rculfhash), the call_rcu thread and rculfhash
>>>>> partition_resize_helper threads do not...
>>>>>
>>>>> Should all threads URCU creates block signals (aside from SIGRCU)?
>>>>
>>>> Yes, I think you are right. The SIGRCU signal is only needed for the
>>>> urcu-signal flavor though.
>>>>
>>>> Would you like to submit a patch ?
>>>
>>> Sure.
>>>
>>> Is there a way to detect at runtime when urcu-signal is in use
>>> so SIGRCU (SIGUSR1) doesn't get unblocked when using other flavors?
>>>
>>> I actually use SIGUSR1 in my signalfd-using codebase.
>>>
>>> I also want to remove cds_lfht_worker_init entirely since it's racy.
>>> Signal blocking needs to be done in the parent before pthread_create
>>> to avoid a window where the child has unblocked signals.
>>>
>>> Thanks.  Anyways, this is my work-in-progress:
>>>
>>
>> Perhaps with this on top of your wip patch ? The idea is to always block all
>> signals before creating threads, and only unblock SIGRCU when registering a
>> urcu-signal thread. (compile-tested only)
> 
> Thanks, that makes sense.  It passes: make check short_bench
> 
> My original signalfd + urcu-bp case works well, too, with my
> constructor workarounds reverted. (I ported our patches ported to
> to 0.10.2 for Debian buster (oldstable)).
> 
> I don't know if the existing test coverage is sufficient,
> though.  Waiting on regtest...

Do you mind if I fold our 2 patches together with a Co-developed-by tag 
and use your Signed-off-by ?

Then the question that will arise is whether this change is sufficiently 
self-contained that we can push it to stable branches, or if it's master 
branch material only.

Thoughts ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
