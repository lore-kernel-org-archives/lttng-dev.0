Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C8DE7C4EF
	for <lttng-dev@archiver.kernel.org>; Wed,  4 Oct 2023 19:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1696446285;
	bh=pq+17Zr2tq2zJajLjvmP7z9a94zDV2jq5BZKnKDNuIM=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=OO0SenaOK+Tzi52j5X1qT9SJo/dYh6Hyf+G6aTMoZvorDHf/GNGUAN5yb+tmtEbQ+
	 GzN9IVy03AS9Ewn99huYyXNFKFTEUE42zhYb446TZqLn5dV5aFUxzS8mns1CeM/3JO
	 z0Wm24yQ9YZ1oHzawkEFOzt+Z5+yNRi+ckT3+IoZ0jK54rHQE1pm6ETk6u/jWbrJVS
	 r7NjzETsbN5gpOwJOXi1DnuC5XX9CgdoYxZOo+t3yATYdTm0O4Ve1DdzpRFqqoOug4
	 WRkLhVUkcvfqhGffQcS148TQv2SwGtBgqRjzLH+Wrtj8sCcpRH4qiOatfOk8/CSKWe
	 3qvK8MT8GuSsw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4S13z10JMCz2s8D;
	Wed,  4 Oct 2023 15:04:45 -0400 (EDT)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2071.outbound.protection.outlook.com [40.107.116.71])
 by lists.lttng.org (Postfix) with ESMTPS id 4S13yx2WS7z2sXc
 for <lttng-dev@lists.lttng.org>; Wed,  4 Oct 2023 15:04:40 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ej19/Q0c16eLCsySYqiCaAGS0sKYx2xlfX2UMj3RaNG0jyADP5FkOtJW9xe32gnkPr4IqLPlfbEz3z8U2Edcx1PjTemunrr9x4bC9C01lzdtc/2yq4s+nDeb7NVe30sZiK33u7iVO3eA0rXRFwQU+h3z2csxd1SoCp9EWcMKn7t4serW6f2VKbfVNPItZ5dVguUrG5hu0jlpWqCZ62GVC249OnlJcVEQ7BAwEd0DD6tmfU3PAIHS00hdL4YdnfIUi34v9uRIkAFBBD2RVa+5cG34txIpjK8cbEkdwHAmxowZCrqo0EIGbUyUtwLSBQCVjHwm5bbYx8X3b6IdE/fcgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNYWFQBkHmi//0k7XCGyvfQxhip1cUNa24y6E1kP3vY=;
 b=QT9dd2OcO4kZZgvmrZRHBJKSv0GBeEFSM/6Ac/aYclFZvdsE/5TIoIM4z12HBlkV7XCPtTPdEAfBh8D1mX4qDqaSxYbSIFpX5B0UgTFIx04k8mfblda/D5Z2J+qK2qAjsIBdgKRzdApMdiP3F+Sic6LT3diIkF1cJ/nioTLkZ22Ah3s5x/01qIZ/FrM/s6jTwn5GiYdtOhY0sFsw86DsRBJTnD2odo6UmfM8EGKU5Hj9RHmFQq2eiLiYdYZc4y8Virt8N9uRwLl7Pb9BhREDbgZq0IUdd/i10+wy1ruMF7PXchwiSTJY7cpcm1rDzVN7W+0vGz+CvUUWNyfTWXz28g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:de::19)
 by YT2PR01MB5869.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:55::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 19:04:38 +0000
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ff6e:51dc:2551:82dd]) by YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ff6e:51dc:2551:82dd%6]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 19:04:38 +0000
Message-ID: <2795ad9b-acbd-460a-bfcb-61f0101180d4@efficios.com>
Date: Wed, 4 Oct 2023 15:04:36 -0400
User-Agent: Mozilla Thunderbird
To: lttng-dev@lists.lttng.org, chris@cwharvey.ca
References: <0c1fcf2c-c061-4074-a20e-44b870fbeef5@app.fastmail.com>
Content-Language: en-US, fr-CA, en-CA
In-Reply-To: <0c1fcf2c-c061-4074-a20e-44b870fbeef5@app.fastmail.com>
X-ClientProxiedBy: YQZPR01CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::6) To YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:de::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9793:EE_|YT2PR01MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: ee7016c8-63e9-4b95-22a5-08dbc50cc199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XJwE2UXGyXsRLx1ZpuWYehqib9yawRmcQx7NN6oEzSEY4ah8P566RL9rZhD4MQuSTFgrVRb6Pl8qizdLGwSbv0kdXNl3OFKhUGMJQOJ+39zPUwovX6If0SjX3nJkKfEQfDqWiF3SQpCIpGqhyiS8JsCu0A4bfOWroC9k91UbKnqsN5OLF0piJRqkE6qslMqts6QvP6brmzGeiKUngWJUSNA3XA5URnCelA62vlWb5IgU6OYrLs+bpVN4OKTLJKRK0mNlFcceMc5jL8csIB3fYuO6wuFqdhPP4CfdjQCsr5YgHNRU/jMETm2pVkHjUQiMZpPwgd9MLd/9VFMAqVOTxtsd+H6YLoTwu+uAHZ5NgRaDkJugt+W3cKNkSZ74ci+TPpa24ZYRwXhPTtb3mB7D3App/T18AG82vnJM75UnSWms7K3bUo19Ltt+OdHQfqprVzIP/BvIh9l24WR2oOpnls11Hta2Jj8czB3Ewvgu2X4Wu+AwL4O+l24CstwiV9ZYUIkjRfrGhtfTUPiaMxXiyUusvY5jUTGuLpto/k2SvND5075Hk6hdT4udZVCaOTMDlPzHxicWZIeHBCmgXfDH1VG3Wn+Jxvlo0A4bDN6Ku5qcLpN6HWLm1X+g2WBpX9847CcbypF1q/Xvok2pGgrMAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(39830400003)(396003)(376002)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(83380400001)(5660300002)(2906002)(38100700002)(31696002)(6512007)(86362001)(6506007)(53546011)(478600001)(6486002)(966005)(31686004)(36756003)(26005)(8676002)(8936002)(66556008)(316002)(66476007)(66946007)(2616005)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0Z6aUt2MDRWaWFudHM3WDFRM3BEQW1DM1BnRU1wd3ZENTF5cWV0bW8xTUdr?=
 =?utf-8?B?R2xOUnBjYWFxS0JmeUowZlBOV2IybDhGUU9FdEdPajY5d1ZpZWFJRHBlcUpZ?=
 =?utf-8?B?c2hBd1plZnQvdjNLQlJCM2hFQmQ0YmpzNk5nc2FrVkJkQm0xa0VuS3FveEp2?=
 =?utf-8?B?Ukd0Mk0xWUhzZzVHY3NDSFB3N0l5NnhoVzRNV05yK2tnYjNjdmVhUFdWdEFI?=
 =?utf-8?B?dDJNRW5HRzRVM0tGSW5IOTFjTFgxZUE1SnpvSVVkdXQ4cjA3RTZjbkdTVGhB?=
 =?utf-8?B?b2tQRkVaMFI1WTBlVnlRdXpCYUhmSE5VQXkwMk54R2tETTZwZ2VhZURwSWJz?=
 =?utf-8?B?VUJ3a25lQ2pJc0FwMUtvc3I2d1FuVjd5SWpPU09BN3AyTnFvWHU2aGxPcHVn?=
 =?utf-8?B?dG80ZmFQVHJsalJMaFFBZ3QvVTRNRElQM0V1NkFDbGxLd3ZGUzQ2YzlubXBi?=
 =?utf-8?B?RmZMdUl4Q1N2b1VQVWJlRHl3bFNJSjN5RnI5RncxRDVlbXlPL1Bnc2lWQ0xn?=
 =?utf-8?B?anBhOE9tR0p2MkxXTEladlZyak1pcHBZd21vOVh6Z004QmxzREcxRDFUamFR?=
 =?utf-8?B?R3JUdEFvNG01dE9HZ3VNd2U5SWVhdnZWQnVOSnBSVXJnVE9DRGZvMXBWWTMr?=
 =?utf-8?B?WU1rOXZtUWVRKzhKRXpyclYrNkZDMWRBam55R2tJQXFrcXU2VlNZVFVobUpG?=
 =?utf-8?B?S3lFZEdkOFlrUW1LNFJOTjhrVWdtNURVdWsySUdGSHFzaXBpa2E4L2U4cVk0?=
 =?utf-8?B?VGNMY21QS0R5VEtaamtWdlBaQks3eHQyQVc5T1ptMHliTjdXaFcwcVpPcVJs?=
 =?utf-8?B?dUs1QlNIaDE2UUN4NzhyNXNSaFJ1WjBMQkZvazRKSk5EaCtmSk9LNlI1K254?=
 =?utf-8?B?a1dHb0VUVDQ2VHVjNjV0cVNaZ1VleHU0T1VFWVJ2ZCt0RnorTkhKYjRYYU55?=
 =?utf-8?B?ZSt5NDVuSDR5Qi92QlU3K3dyVkdsZURXKzFsSUdwYXpjTUFnclFKd1Y5Tlp1?=
 =?utf-8?B?SVI3S2FOOEN2M3QzTXJuVjZkWVhqQkovNHAyUEdXeUV2T0tDZ2J5aitLRDla?=
 =?utf-8?B?azJYNGFndnhWdmF4aEk4M2FUaVJaUUJjUkh6cWZRSThhcThOcUFvWFA0ZnZG?=
 =?utf-8?B?THQ0ZUZscDNpNTVyMlVBOFpBMkRINDRnZ2hXVlIyd09INmx6M1hMazhyRFBn?=
 =?utf-8?B?UklLVFlqdEpaTElsN3RuUHc3bUNpclpNNnRBVmVXcldRRkxkelVUMGdmUkJp?=
 =?utf-8?B?UHRhdnkvcTc1Y1A5bTlsdGZnK0p4U2tpOUZrQUZISGJ2NXQ1anhuUDViYnhH?=
 =?utf-8?B?THI3OXkvaFhJZld2SHhhbkp6OHg0VkpnLzR6dWsvSjZWQk4yRU9YN1hHY2x6?=
 =?utf-8?B?REhkaXhDY0o1VXhNVmpEVHJKTFdTclc2TUU1NGZzWDljMGVNN1hMTStuRWxM?=
 =?utf-8?B?VjJzTDBoWnNkdmwvWExucS9NTm1TZkJoVk85Nyt4Y2pzcUF1TnlnNDYxWUVa?=
 =?utf-8?B?WkhJVFV3RHFvcW9qYUswNWZLU0dRb1BhUUF6NUt6L05SOWN4L3I5UlVXRWRT?=
 =?utf-8?B?VkhJUWZRWTdaUU9wcjI4MW9uTi95d3J3eEgveVc5QVpJWmVNWGtOSDd3VlZH?=
 =?utf-8?B?SjZtcXdwWU51bFozL0tOc0czaDRNM3lPR0RQMXI2Tms3Q2J3Z0tOZHFQd0hu?=
 =?utf-8?B?b3RCczdhcFBlNVZaMi9pbW56K3kyZkFLeTZCcG1qSXNzajRIaGlIN1hjMmpl?=
 =?utf-8?B?bmxqaWpUYXAwQlMra0ZrdXBpUGlPMjdETW1ybHIraVV1UmVwS1VPZEJYN3BK?=
 =?utf-8?B?c293QjNuRWpXZWNIMjdCTW1NWUJWMFpzbXIvckNlNktyektrUWx2bk5mZnB3?=
 =?utf-8?B?UlZzRU1PTUNocldqZG9uSy9tb0doSldyQ2NYTnBFRFZ6bW9LRXh1bllWSmxv?=
 =?utf-8?B?TFBkRTlxRWF4N3pLUExTdG1GUXd4YlBkdkZZTTY1M240NFNKTGF4OFF2ZWNZ?=
 =?utf-8?B?dzlmTG1sbENmZnpaTDBKR1R6Y0VOWGhLbTF3STNMMFduNStLblQ0OVZHTDgz?=
 =?utf-8?B?OS9iWUpJM3ZROTQwTDdCUys5THRDZDIvK1ovaXBwK0x0NWNBMnRhZkg0Z29z?=
 =?utf-8?B?YzZmaGdSN2RKbldYVlNOMkQvSk96VU0zQ0NKL2hUOE0xbllPRUM5bDRteU9F?=
 =?utf-8?B?T2c9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7016c8-63e9-4b95-22a5-08dbc50cc199
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 19:04:38.2505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGo8b6jFfmhra3mPR36g8QtA9fRIWHIeWFu7f8ZC/xJfXtmW20eXNop3F/DUm032Xy0c4PBnWNmBSXDyvBo0/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5869
Subject: Re: [lttng-dev] What is DEFINE_LTTNG_UST_SIGBUS_STATE for and other
 beginner questions
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

Hi Chris,

On 2023-10-04 12:56, Christopher Harvey via lttng-dev wrote:
> Hi all,
> 
> I'm just getting started with lttng and have a couple of questions. My target is getting userspace tracepoints to work in a c++ application I control. I don't need kernel or system tracing. The target is running in a docker container I have control over as well. Running with --privileged is possible in my setup. I could run lttng inside the target container, outside on the host, or in another container on the same host. It's all the same to me. I don't know which setup is best, or if it even matters given that I don't need system or kernel traces.
> 
> I am using:
> lttng-tools-2.13.11/      and       lttng-ust-2.13.6/
> with userspace-rcu-0.14.0/
> 
> There is a slight version mismatch there, I just downloaded the "-lastest" from the links in the guide.
> 
> Here is my tracepoint provider header:
> -----
> #undef LTTNG_UST_TRACEPOINT_PROVIDER
> #define LTTNG_UST_TRACEPOINT_PROVIDER my_provider
> 
> #undef LTTNG_UST_TRACEPOINT_INCLUDE
> #define LTTNG_UST_TRACEPOINT_INCLUDE "./myLttngUstProvider.hpp"
> 
> #if !defined(_TP_H) || defined(LTTNG_UST_TRACEPOINT_HEADER_MULTI_READ)
> #define _TP_H
> 
> #include "lttng/tracepoint.h"
> 
> LTTNG_UST_TRACEPOINT_EVENT(
>      /* Tracepoint provider name */
>      my_provider,
> 
>      /* Tracepoint name */
>      test,
> 
>      /* Input arguments */
>      LTTNG_UST_TP_ARGS(
>          int, arg1
>      ),
> 
>      /* Output event fields */
>      LTTNG_UST_TP_FIELDS(
>          lttng_ust_field_integer(int, arg1, arg1)
>      )
> )
> 
> #endif /* _TP_H */
> 
> #include "lttng/tracepoint-event.h"
> --------
> 
> and the cpp:
> -------
> #define LTTNG_UST_TRACEPOINT_CREATE_PROBES
> #define LTTNG_UST_TRACEPOINT_DEFINE
> 
> #include "myLttngUstProvider.hpp"
> #include "lttng/ust-sigbus.h"
> 
> DEFINE_LTTNG_UST_SIGBUS_STATE();
> ----
> 
> I'm suspicious of a couple of things in my setup.
> 
> First, if I omit the DEFINE_LTTNG_UST_SIGBUS_STATE(); line, my program fails to compile with the following error:
> liblttng-ust-ctl.so: undefined reference to `lttng_ust_sigbus_state'
> 

I wasn't able to reproduce the compilation error you are seeing. Could 
you describe in more detail how you are compiling and linking your 
tracepoint provider and application?

> The getting started guide doesn't say anything about needing DEFINE_LTTNG_UST_SIGBUS_STATE so it makes me wonder if I have done something else wrong somewhere else. I ran a find *.so | xargs nm -D | grep lttng_ust_sigbus_state and nothing in lttng-ust provides that symbol, so it looks like the target application has to define it. Is that normal?
> 

If the application is actually using liblttng-ust-ctl, then it would be 
normal to do the define. The header file explains that this is done to 
avoid unnecessarily pre-allocating space in the thread-local storage.
https://github.com/lttng/lttng-ust/blob/master/include/lttng/ust-sigbus.h#L39

Traced applications typically don't link against liblttng-ust-ctl.


> If I leave DEFINE_LTTNG_UST_SIGBUS_STATE in then my program compiles. If I run lttng-sessiond in the target container, then run lttng list --userspace I see no tracepoints in the list.
> 

Is your application actively running while you run `lttng list --userspace`?

`lttng list --userspace` will only list the userspace tracepoints of 
applications which are currently registered to the running session 
daemon. If an application disconnects, the tracepoints it registered are 
unloaded.

> I tried looking at the lttng source code but there is a lot there. I'm looking for some next steps for debugging this setup. What are some things I could check to make sure the lttng daemon is running properly? What is the mechanism for advertising tracepoints to the lttng daemon? Is it possible that docker has somehow interfered with the lttng ipc mechanism? It would be a tiny bit more convenient for me to simply deploy lttng-tools as a separate container, can I consider doing that instead? I'm not running anything as root, just a normal user.
> 
> I appreciate any and all guidance. Looking forward to using this neat looking tool.
> 
> -Chris

thanks,
kienan

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
