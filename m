Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377DBC25B48
	for <lttng-dev@archiver.kernel.org>; Fri, 27 Oct 2023 17:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1698427120;
	bh=4yvdm5ebw1ch0FEiidhoW1m8RvO5ONfJXvRg1nXDZBM=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=UNPcYqCS4fQtLPikeESXjvRjvV1HRavUGlkAHU6C+4+tgR5sd4D5Z54oAClnjGTDg
	 vNwrKnk/lGhDsrmK9EVrKKOHPV8PSu+hpRC3ErMLBcQbwMNVKR8e4ULpXGtGDRz2ne
	 Q+8HqD7RNUVB8dEUQRcxgVHFy+ins8Es+t6Y/IcbxEi2bVSyvf5ETCFnW4f0xnuHy9
	 kXxoG7fyn769VhYD0cYdIYc6l8RqN5wUTTVcaJu1o/rBw8YpzMR8Bcc8lFVPzAkB+/
	 ykj+/Irua2rtLJPmkwYIwOI5lazBMibvilqTIWUtJpziqajn+D+8I7taC9JxgVSy7I
	 C/9YPZxDdPtjQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4SH8Wz2dGvz96k;
	Fri, 27 Oct 2023 13:18:39 -0400 (EDT)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2077.outbound.protection.outlook.com [40.107.115.77])
 by lists.lttng.org (Postfix) with ESMTPS id 4SH8Wy1Rs2z9S6
 for <lttng-dev@lists.lttng.org>; Fri, 27 Oct 2023 13:18:38 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ci9v2FmN7YaFd/EMhZsx+jgCsdf/x9VHPm0T+GMbU4yALQQY3MNEM97+hgERWLBBkcZHkdva3McQnZyJPQcaSqqIbGIG4hw+oFRILH76wDRggZ47l9GVy+Xm19KFKaf1qx7l4JWkLqzAFmWMVHlE/y+0E9FgRGrbTkY+wgVTfVKeJ7iPOYlx1fM8vk0A0nZ6cZ8RTA0sTx0ns+fJ4VhJ79FHm934slBCqtd+TskrTJe7AQ0OCC3eXhxaotpTS8g0SNObgRjHzKVpPhMSMyvk76VBv4pf0bnI4bk+OW2Ej9qphqSGaspu+hP8ungdVkFmNsFraClwTXZR1uJ2lzlFiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3SxteAweWp9KIh7VZNJOdvIDzwKXwJBiI1jKjkyYB8=;
 b=DmGNg+tiq8tbY0aRMfUE9U22cE6s3gstDyb+633N3tzzUgDUpifnQY/Knxy7qV7dil3PY6ofb7hWS2pI3Rn7FwosBoRLoBhTOceXGqHbEeQuFZqyEkHElBoWGfcIubF62dvvEaNVto47DJaEHrnUIr1t0jLosk77dSe1GUTcIbP+2b/oYVp1JoZMz4G41CcxK0CY2MPd0BKZip5rj2tLdAkqg12OH4FjNyJsZYkGRN97Q++kRHxN0wV+ETmrBuJdZ+rJAxO+KSh7h+GMNEjXBS3PyCSyvm/D5O0IQf+QktEJfsl9d/ivOkxbujH9f2TGqRSNXJ/RxECQytoLjs0wOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:de::19)
 by YQBPR0101MB9088.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:5f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 17:18:36 +0000
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::da47:621a:32df:13c2]) by YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::da47:621a:32df:13c2%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 17:18:36 +0000
Message-ID: <833d916a-4bed-4802-94c1-5f39853c527e@efficios.com>
Date: Fri, 27 Oct 2023 13:18:35 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US, fr-CA, en-CA
To: Lin ArcX <linarcx@gmail.com>
Cc: lttng-dev@lists.lttng.org
References: <CALBKf8Jv-QRwbZ0ATdPzj1KyzDQT6SqG9G_4-5-QfG35iJyetQ@mail.gmail.com>
 <2eaa5b1f-c3b2-4790-bf45-dadb66f45d48@efficios.com>
 <CALBKf8JtZKGe5i9S0=zcU_7Qj8b_Z_FkbLv+hqcDf1BbBnZF7w@mail.gmail.com>
 <f59560b2-550f-4423-8428-5116fb1c6ad8@efficios.com>
 <CALBKf8JHM1xDf9L3m+4p-2eNQ2s6yGJw0fxWpv_U3f2uDoFJEQ@mail.gmail.com>
In-Reply-To: <CALBKf8JHM1xDf9L3m+4p-2eNQ2s6yGJw0fxWpv_U3f2uDoFJEQ@mail.gmail.com>
X-ClientProxiedBy: YQBPR0101CA0288.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::8) To YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:de::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9793:EE_|YQBPR0101MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 325d3aeb-d9dc-417d-1109-08dbd710c112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PfT8RV05UpOjZFabQecZdUY0vh6b0dR7jh7GIHCCnZTPsyG+50E9ygnguoCjdT9PbitelLfr5U05tKSxb1Rn2xZnYcthDWEDtcEpylhTtaRFhPwlcTUGNmh2/G5zPEEMbjPcStrq5BvkXTV6rwRlNf1MuWvWvonsDP65Pv77PfkcLuuji/znicjMOBKuYass98cGQArMBQZCzudrSm7gNFXBvDkGURYusBXvSEyMJLeh2Lalmwp6AHSHpBaXJhlcvCkxl/YFpsnSJe0o7wxscvWuMOT33TL1fpiuJBbXcR4O9dX6doL0dTvAiofNilnrRPTflZAhIdZckCHHxl0YnyNPN6sXDUVkzvuuhalEyIuRj2EC+nPWAf+MDglmIm+a87J3XG0f6iG6PpSSDoFYkQ/bd0YuJU+7R5gmFxvNXspRMp58lgeIOY4Dq8Bo0qp3EmVp46/j+0jRI/+5UdlTE+Cs8hN9h085InlpCtUIekFkJJWJvgB1xiELiiIMQ1vGn72jYByErc9IrbelYY1BRkfS1jQtgNle5YcCZJwaOx+IBajx30fiAus3Lw1tW3FEdwfvi2/wMNXiKDYCO0MQ+HMQLNwQeVUnP3p1qKQZDaz5OMZzmPJ2SsH1+6RUqogBiFLTv53t9sHxCWoLqbL0LA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39830400003)(396003)(136003)(376002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(4326008)(31686004)(53546011)(2616005)(26005)(6512007)(86362001)(36756003)(31696002)(38100700002)(4001150100001)(2906002)(4744005)(6506007)(6486002)(478600001)(316002)(8676002)(8936002)(5660300002)(6916009)(66946007)(41300700001)(66556008)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVJrVm5OYmZ3cTNzcjRRWTRBb2NkdjRHZ1pEdndWcWJDbDVoUFVBUVU2UlR6?=
 =?utf-8?B?NlVRZnNWOXFCaFlBNWcyWjBtRHppUE8vWE5wOUM0UmZnWEpoRm53dGt5YVB0?=
 =?utf-8?B?bW03czBUditZVVA3WlZadWowVkZzaGJFd3BnR3l4ZlIxaHRDNW9SdGVGNnUr?=
 =?utf-8?B?TnpqczBRak5OSjJMeGNxOEVTZjV5QUJpdFExdEZKUENFbUNUUnRRUzdBZ2FY?=
 =?utf-8?B?aEFBMkNQQS8wcHU3d0N1Tk53cklweElWUHI1U1lic1RLc2ZaQjFyZXNhNFIz?=
 =?utf-8?B?OWlPRE5ENllZWTJwVFIxOEEzV3JBdDVISUU3REp6STF5R2VxMW5WeDJLdDRt?=
 =?utf-8?B?Q1FMV3lJVEt4dmlwaUZBQ1dKbkloSUtRbDJGdmVCMmhnUDRYZUQ1cHhPMDZm?=
 =?utf-8?B?WEJhUnpvdTVYTGF1OWJvTTRBZ0pzRFJDYVVvRWJ0SThNRHZOcllDbzMzNFlO?=
 =?utf-8?B?MlphM09UN1Y1Q1h5QlZwQ21oSjhUb2xWK3VVSW1NR25BenBnMThyYjZldFoy?=
 =?utf-8?B?b2NBSjdFWkxVZEtyU1RMUVBBMTB3d3lCZFBTdTh5bVpBRlprZEw0SW1NVjEr?=
 =?utf-8?B?WTJ6ZW5jeGV2ZEYyQWJnc0ZIV3J3SEVKeUVxZ2dYY2R2RGtEdTg4Vlg0YnJv?=
 =?utf-8?B?TWk3anBDek5xZlBZTGtFcmNwS1EvR1pxY2RSRmxYUTVvZE1SQW5qRXRoLzQy?=
 =?utf-8?B?SDFpeFlwVzB6NkhtbXlTaXZMbDhYQXdzK0NXdCtoQ3NsenhNZjkyR0Y5b3cr?=
 =?utf-8?B?eXgvYTAxMjd6eW1FckhPT3M5emI1WjE4MktaRTZVU1RUZmpPU2VQZkc0YTJ4?=
 =?utf-8?B?R2RRTC9rbldiSEVtbnpSYjRWL09LdElCaWhPeFFnaGl0SjBVUjB3MEhwQ2F4?=
 =?utf-8?B?KzJtWWlFTVhTd2ZBRWhFOFpFdm1MaCs4Q0dWQXVHak5zWWtyU2l3MzVvTWRZ?=
 =?utf-8?B?UDA0dkVsWW5hSHNialRnWk5peFBSb3pHM1Z3WHVyMDBXNUNNTmh2UG5PcTVu?=
 =?utf-8?B?ZjNKSTczRVpxbHdGNjhvdHZ1S2pUb1BNYlRiS2tTQWZuNVdrdVV1R2l6OXZi?=
 =?utf-8?B?MkRyMXM0bkRzWXJDM2s1VjhOVCt6UEJ4ejl6dWxETEs5N3o3UDhXazJUbm5u?=
 =?utf-8?B?TllER3lxV3F5cTBKWlFINFJOV21BdUpoTHpJUGFnMFZRTHBBYmVXVHJxUEY4?=
 =?utf-8?B?QW1RU09FWmRMcnJkdERGZFlmWVZpajV4TTVEeU1BaUJDUWpSSTlRQ0lqMThJ?=
 =?utf-8?B?ZHVOcmdjelJKTG9wODZjcHZHY3RNeHhMSHdXY0IrVFlxdkd1dWZvVkFFbTM4?=
 =?utf-8?B?QUdhd0ZDTFFUZ1lJSkcwTlNNVEJCaHhwR1lQVWJBdnZWMXRXNUh0UUx2Z3BF?=
 =?utf-8?B?T3NqTVY1V3JNVXlUc3hxVHErbytHYWpZb0JsQlBqQ0t5d285RXBnZ2ZPcW5i?=
 =?utf-8?B?WWRacDJWVDNtMFMrejJPZzFPZTMybi9MREhrbzhLb3I3VmlKZzZzRHkvSFZ6?=
 =?utf-8?B?UU9lSXY2a1IxaDd1OWo1WkpIR3dIZ3FZbVI0eFNwb0JoQ0NnaE1JSGZzYVR1?=
 =?utf-8?B?V0ZLV1NQNGg5Mkp4d1owQ1kvaktmb244cVVDZjBDSC9vazhIdFlvSGRlcGpL?=
 =?utf-8?B?aTVranREYmg0Qkp4THpXTGp1OHBXUnBZbC9kNFNMZkxOaG92WFVMbDhjZmdP?=
 =?utf-8?B?TFVvZEkwV0NDRlcyVEpjTHZ1Q0pZQmhROHZyVG1wTzRuNzBNd0pnUDZiUlNT?=
 =?utf-8?B?ZVY1QnQwZ0tLTkNwNVZCOXYrOTBmVTgxNlV3ZlRBblFkaHRCaFpwWlQyeDY0?=
 =?utf-8?B?ZEVhb2I0eHAxeGZtY0JjcHNobnBvVy9mb2hEUXpKWEdvbWQwQW14a1BsWkdE?=
 =?utf-8?B?OVpWellUTnV1MXFrRkExam43cktsM2tQSUROZFZKeDh5ZnVqbENZV0JkYWcw?=
 =?utf-8?B?QTlyUkgvU1IzV21sVjJWTXpDWFNES1ZhTmd0MndScUt2UVZ5YU9yb3BPdjAw?=
 =?utf-8?B?bUZRb09pVFBqcnJXK3hqM1NicVJJUXd5THVtR213S2MvRlhqcWh1L0RCaU5s?=
 =?utf-8?B?R0pyZUJzRThoUmhEdVZwZlpWTTRaSXFDcGVIcDFOUklMWDM5UTRlSktQaTl6?=
 =?utf-8?B?RjN1SCtuUTZoRzhxYUlGYVJFZE1uYWl1ajZVZXN6dXgrVXIvQ0tnYXcweVBa?=
 =?utf-8?B?YXc9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 325d3aeb-d9dc-417d-1109-08dbd710c112
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 17:18:36.3640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2x2yNZYgTLKc5KPrtGO23DNku2DYiOqUqLKkzKX8f+TJE6FbYC5OyLqkvnRQSVSr4Pr/CrM4sqe50o7DLvA20Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9088
Subject: Re: [lttng-dev] Can't receive a lot of functions that i registerd
 as trace-points
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Lin,

On 2023-10-25 04:54, Lin ArcX wrote:
>     Are you seeing a situation where another tool is recording occurrences
>     of the events that you think aren't being seen during your tracing
>     session?
> 
> 
> No, nothing, I'm running my client/server application inside wsl and no 
> other tools are running.
> 

Perhaps your test program isn't causing the WSL kernel to hit the 
`net_if_rx_ni_entry`, `net_napi_gro_receive_entry`, and 
`net_if_receive_skb_list_entry tracepoints` during your tracing session?

I recommend using `perf` to double-check that there are indeed none of 
those tracepoints being hit during a tracing session.

thanks,
kienan
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
