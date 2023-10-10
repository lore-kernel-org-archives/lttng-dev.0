Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11468CD8CA5
	for <lttng-dev@archiver.kernel.org>; Tue, 10 Oct 2023 15:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1696953424;
	bh=bug86yHMDeU1DfXqlsAP9PsxlR+/ix0xE4jAEshJxmY=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=czgIwBNLgI+4GitYlxo8qxzQOSTIe18uEXP6DTRUMQP6c8r8Xm90LVP8f9qtchoii
	 xRjkAyeuNPZjraQl060OOP3UMuyxeP+dh90eBoAmXYHqDBKvmmV8mECKpcjB730K87
	 wxtDsMI4R+na9yvzugv4uMI8mVjxyVrm4alPPyfqk8J2h7Q+mHlpJYhdIqnKXhx85B
	 qZPrVbv4AtWHRPwG6Ouad4K97htDpLqzuaf0OGM8c86itA+PQrMpuXJOf5qGOSdzdi
	 rau2BVNzEz2yeFwyR8Mcoax6mwKMteZqoXmZTUCBPMkyY3NZh+Jc5qjS4APeXzEPcu
	 QI+tEX5oWxuEQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4S4gWg64p5z2wNC;
	Tue, 10 Oct 2023 11:57:03 -0400 (EDT)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:7053::61a])
 by lists.lttng.org (Postfix) with ESMTPS id 4S4gWd5hHQz2wN9
 for <lttng-dev@lists.lttng.org>; Tue, 10 Oct 2023 11:57:01 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaqyxzhOzr42fakrImwcJO3yKY0F3ipSehtZn1Q6bhTiiIuRGsOY57GxBjDcmy8Wuo13EOLPqDBnbqWjUYSdd1cYWfHB2OYsLVMhTOs0euOVyfh2H+X49anSw0LqbxvrrRNIwRzn3+ErHMiCjqdBt7XSRczex9XRYSYqxSWOzqB0aY/cOeObWWPXnN1EFAlnCt/22xsmBmTJYqWZ6Hfhgd1J+8bQrRRIs3yIFVJSePDA4NjnLIHjYn2pYqTAEudk6gRYPcuYxRmqTW8h3e3cSjga+0A9//6W7ZJ1/Dg0+4+KGFu5Ztt+5YJ4lRuI21tEgRIAhwEZ9V6sxu+Uw2qo5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGz2GGgNCrlakl2h8qOABtj4zAMwf9PuJYrVGTEL2Gk=;
 b=GowralOCdak081szj3eBSfo9q2U1CMwXeI1YBrdBJRlz+e4yn9pBNhV4h4s/ZwrpLXgG0Om4nf8vPlqfjl4gaKaFCvAq/igTF2zCTNwmv44W9FwUBUk4YmlGP3mzorZuvPCni3oKwjNrJfUlyII6/AvxPcbkSErHcsozxkQl9D5j72Y1WB8kFmGCxIO2ktu92z1qX+yTFRhnZfywC2oAdim/Yw99m6V/01i2Nj1C2aciZCG0Qy0BrptQzDP5I+ju1sXohLwjfgPLpxGARK2H5Uq+57fb4BvW0J4yxA74DnuwQnj7TL58Iu8bAoMHH8N+ZYe9M7jrvwcisNikiUTHtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT3PR01MB9804.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:8d::21)
 by YT1PR01MB8858.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 15:56:58 +0000
Received: from YT3PR01MB9804.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::3083:e228:feae:7561]) by YT3PR01MB9804.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::3083:e228:feae:7561%7]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 15:56:58 +0000
Message-ID: <cb851cc7-9399-4c3e-8bb3-07e22d1d4f88@efficios.com>
Date: Tue, 10 Oct 2023 11:56:56 -0400
User-Agent: Mozilla Thunderbird
To: lttng-dev@lists.lttng.org, ushankar@purestorage.com
References: <ZSSa+ocJYtvulAwv@dev-ushankar.dev.purestorage.com>
Content-Language: en-US, fr-CA, en-CA
In-Reply-To: <ZSSa+ocJYtvulAwv@dev-ushankar.dev.purestorage.com>
X-ClientProxiedBy: YQZPR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::22) To YT3PR01MB9804.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:8d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9804:EE_|YT1PR01MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: e5451e0a-539e-4083-4802-08dbc9a988d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zpBX8uDo+DazUjnajzFoWNuABwjK3D5RqxPdlWzJStwLJjWY3fuiL5qBFiWN75+6KS43rChZObh97PHQd0Nwtn90jyc4uCufWYuCuxoQ5l4E6Gw+lbpSWxwqhXcQX0BYSdkajVn7wc646bXv/OLHogT5QEOS8zGvBAUihlHtuZFA/osdNj2m2pXivv4os328LuTBMFyB6F+n+gflDfHSWEs0CuWbQgY17BqsuyCq+nPGjTsG5cQ4mpN1CAvqOaPadw4haGFkm4HRTD3I2v23Sayt2iv8+gDjQBTqWD3RtQKw+BeX2hFOix9yXyfUxtKtucwCXg//7fNu6Xoz7cmhXysPGXB1sCrHpcl/7wwdSfGe3uPmRLSWmuggy4Q6lKe/9+XDr2JAA85AQiww2xaL8Lt0vx/fEXeqFNnY7jB0IBK6e6X+py1bOHeZRebdBAH1qL1EgYDqAqS92d53vWj3aEuao5FFmBXT3apgl4x+zhaz0DcOJK2LJKjZPxiMq56pU9xsJapwx96YhTKbR3+65hjO28nySVPFrA5SHUwB6sHJPkkLFwTqU0EGVNhkBOq1EsiI4xwKnauAQmx1ZvtvlxS5jhi8HsULOU0DEK3P9k21Yw7Xo1KplgAu0wEsvJZ6PKf+5T00fn9KulkUhKJ9nag4pFxyNibUMlxoGMIwYhRf9QG0skST87AVHWJOHFxs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT3PR01MB9804.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39830400003)(396003)(136003)(376002)(346002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(5660300002)(41300700001)(8676002)(8936002)(86362001)(31696002)(30864003)(66899024)(2906002)(53546011)(6506007)(6512007)(478600001)(83380400001)(31686004)(36756003)(26005)(2616005)(316002)(66946007)(66476007)(66556008)(38100700002)(966005)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T244d080OFFZZXpaQ3ZxM3poZmt0cE1NTVlQYm15c0pxVU9pa1owRTVCUkRY?=
 =?utf-8?B?czRQSVVPdm9KS3p0UHZtMzB2dlBmcWtJTW4xdk5qMERaWnZXSXVmbU9WVHJ5?=
 =?utf-8?B?OC82VWJJRk8zS2orTzRQZi91WkRmR3NteVQvSHBmR256VVNObFlKR0FPejUx?=
 =?utf-8?B?R2syTVArbWdIazFlNHpubzRDRlNmMVphQVBxdHdXRFJMRFh0ZGpSa0hTYXdT?=
 =?utf-8?B?US8wbXg4R0tTRys4WEh5WUU4em40c1FSdkY0dkhCeEdlNkhGQnNIMi83dkkv?=
 =?utf-8?B?bnlGVXdDVzhTcjd6UjR4Q0hMVlJiUUFNaGxsVXNmTGhWQ2EyTFlHT0hKUDV2?=
 =?utf-8?B?Mk5GcUJ0ZHV3TjUwQVg2TGlOR2I5R0M0QWxseTVyREdQMzZnSGVFbitUMVRk?=
 =?utf-8?B?VmRZNS8veGk5UzNsdHpuNFVtd1FCeVN4amFYQ1NldzhsQVdNbEw2bThaRk5l?=
 =?utf-8?B?R0tYWnZ0YVVTSFM0ZFBKaGxnait2K0xtZDIzd1dKVXdiQ251ZlcvNUdyM3lF?=
 =?utf-8?B?c2hIZzExb2lKVWJXdUt4dnVOMmJHK0RicmptWGtaa0wwTlEwR1dkQVlwN0hF?=
 =?utf-8?B?dVJWeTd5SHBwNjJhNHk1N1FZbStYcHRyVDVVTzVEREJjN1dNTFdhQWhwdXdU?=
 =?utf-8?B?cFJ2d1N1WFFmaU1TSS9nSEhIWTNMVGZ4T1NQcDlqUEl1TzBWLy9vOEFCdGpC?=
 =?utf-8?B?K2U3VTRuYVAzMUFNa1ZydHpsek5Lc3NIS3pGNkJqZ3drQ284K05HVGxJeE9k?=
 =?utf-8?B?Y3VRQ0RDMHcwR1l6eWlwbDV3QVNCZlQrTXhzODlMcmtIUm5ySFU1WStvQUZW?=
 =?utf-8?B?Ty9LcS9hQmllN3kyUFY2VEZUSTdXSkwwWGFqUlhIL0MyVXJqNGpWcnBDR1FB?=
 =?utf-8?B?elJjKyt5Vm1IM0haRVRFYWlnQnV4QTBoMVRyZ2JMcytPODdFbGlneDZiUFdh?=
 =?utf-8?B?U1lBbkVtdk1xSXk2SDBqcG9oMDI5WjJRWHgzK25lUkhZQlZnZ1Y5dWlLY2Zq?=
 =?utf-8?B?L2JRb2hCV05VZXhNVythQ2Z1TG1qWnpTQy82dGE3emFNTExBNzNGYnlDK3Ey?=
 =?utf-8?B?TXg0UGQwZUxwb2g5di9SaHBkV3VyNEVHcVhGMDhlVmRWY2VPaVNEYVlFQjlY?=
 =?utf-8?B?ak5QQ0dRM3Uwc2l2RWdLbE5WYVhzbGp3bnp5eXkyV2JNRTk4Vm5IbGh2VHhH?=
 =?utf-8?B?aHlBTU90N3dkRHREYnIzMVFMK29mREtrWkV6OUhPcVlqMHFJM1EyT253QTRW?=
 =?utf-8?B?OWpKM3JOUzFRNFVCY1RJY1VPTHlFZGRmYXBaV3RzTzUvQmhXd1FZQllzdUtk?=
 =?utf-8?B?US9Qdk1kSDdBN1R6czEzN2pMN3ZOcFg5S0N0eFkwUFhmVStLeXlWU2Y5MHlz?=
 =?utf-8?B?b21VQy9zMFZQNDBPTXJYMytIbzlCK0t0N29VRnMzTzZVZ2c0UzNZTDNmQ1FF?=
 =?utf-8?B?WHY2RmNrY2h0OUZna0Exb2RIc242YVYyUGI5eDhrTXF6RjBDUmsxempqWGx4?=
 =?utf-8?B?ekdvMGlpay9aMFRhS09xRUZneDhkdmJoK21Samc5blBwS0JNTzl6SFc3enBk?=
 =?utf-8?B?L0hlL3dlT1FKenI0TmUwNHFhK1ArQ29VVHpqMlRtWm9uZTJvelMwT2o0SXJY?=
 =?utf-8?B?T0JsSzRCdHRMNGJidHRRcG1EeXpxWXdGam9YMFpDQWw4YmRmV1RoVFpYbG9r?=
 =?utf-8?B?dXN0M2JnMVpwUG5Dc29taEZ2aDRuajM3NmdZR3RCd0k2OVd3ZzNiK050YUxN?=
 =?utf-8?B?VGJqb25zZjhQZGRtSDhaczNGd0YxVlNtbHovSC9NbG1XZE92SE0xMHN2T3hD?=
 =?utf-8?B?NXBWRjBmZ0FRc2o4VFZiQjhzejFRVFNRbUp3Tk5GWXdpWEVaK2c0MndOYlJy?=
 =?utf-8?B?eENEalV1NkZaVkFsYUpOREx1dkhEYm9BdCtGQVJmeEtTOXV2OU01VUJPOHgx?=
 =?utf-8?B?MlZoaER3ejFvb1J1SlkrYXFhQXd4bG1wbU53Y0FQQ2VjMkxadU8wMllhbkF6?=
 =?utf-8?B?eFlFNmF0MGJ4WWk3STY4ZHMrdXBrcC9GZ2xsN01LSk9uY1RxZkxhVnVTTXY3?=
 =?utf-8?B?c0lUVmhQblBzNktFRGdLOURxSFNuam1YdXBzU2tSeUs3NE8raXlxOW1xcnZU?=
 =?utf-8?B?TUc0aTU3bUVWTHcya1BNS2dWb29HZ3VISkVJa0RHbGc0cVNtWU9jdWVuREVC?=
 =?utf-8?B?R0E9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5451e0a-539e-4083-4802-08dbc9a988d1
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9804.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 15:56:58.6610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jO9IswTnQQNoSukanTk2Rrq5LmeKdrveWyMadAQymYfzRZjEPrSH9h3EiOlMel5q/XAWMGiVUczCH5c3eDtKVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8858
Subject: Re: [lttng-dev] lttng list -k is missing tracepoints
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

Hi Uday,

thanks for the question!

the syscalls have associated events, which should be visible when 
running the following command:

```
$ lttng list -k --syscall | grep uring
       io_uring_setup [enabled] [32/64-bit]
       io_uring_enter [enabled] [32/64-bit]
       io_uring_register [enabled] [32/64-bit]
```

The availability of those events may depend on the architecture of your 
system.

For the rest of the tracepoints exposed by io_uring, there's currently 
no probe for them in lttng-modules.

For each system that exposes tracepoints (in the linux kernel source at 
`include/trace/events/`), a small kernel module is required on the 
lttng-modules side in order to create corresponding events. These kernel 
modules require some work to create and maintain since the defined 
tracepoints aren't stable across kernel versions, and the current 
version of lttng-modules supports linux kernels >= 4.4. The probe kernel 
modules are defined in 
https://github.com/lttng/lttng-modules/tree/master/src/probes

We've noted your interest in having a probe for io_uring. If you need 
the io_uring probe within a specific timeline, either patches and/or 
financial support are welcome to create and maintain it. If you're 
interested in funding this, please feel free to reach out to EfficiOS.

Hope this helps.

thanks,
kienan




On 2023-10-09 20:29, Uday Shankar via lttng-dev wrote:
> Hi,
> 
> I'm trying to use LTTNG to trace io_uring tracepoints, of which there
> are many in the 6.5.4 kernel I am running:
> 
> # grep io_uring /sys/kernel/tracing/available_events
> syscalls:sys_exit_io_uring_register
> syscalls:sys_enter_io_uring_register
> syscalls:sys_exit_io_uring_setup
> syscalls:sys_enter_io_uring_setup
> syscalls:sys_exit_io_uring_enter
> syscalls:sys_enter_io_uring_enter
> io_uring:io_uring_local_work_run
> io_uring:io_uring_short_write
> io_uring:io_uring_task_work_run
> io_uring:io_uring_cqe_overflow
> io_uring:io_uring_req_failed
> io_uring:io_uring_task_add
> io_uring:io_uring_poll_arm
> io_uring:io_uring_submit_req
> io_uring:io_uring_complete
> io_uring:io_uring_fail_link
> io_uring:io_uring_cqring_wait
> io_uring:io_uring_link
> io_uring:io_uring_defer
> io_uring:io_uring_queue_async_work
> io_uring:io_uring_file_get
> io_uring:io_uring_register
> io_uring:io_uring_create
> 
> However, lttng list -k does not show any of these tracepoints. I'm using
> an lttng-modules built from the repo which I cloned last Friday:
> 
> $ modinfo lttng-wrapper | grep extra_version_git
> extra_version_git:  v2.13.0-rc1-316-ga62977ca
> 
> (lttng-tools and lttng-ust are older - whatever version came with my
> distro - but I don't think that should matter). Am I missing something?
> 
> Here's the full output of lttng list -k, in case it's helpful:
> 
> Kernel events:
> -------------
>        lttng_logger (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        compaction_isolate_migratepages (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        compaction_isolate_freepages (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        compaction_migratepages (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        asoc_snd_soc_bias_level_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        asoc_snd_soc_bias_level_done (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        asoc_snd_soc_dapm_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        asoc_snd_soc_dapm_done (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        asoc_snd_soc_dapm_widget_power (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        asoc_snd_soc_dapm_widget_event_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        asoc_snd_soc_dapm_widget_event_done (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        asoc_snd_soc_dapm_walk_done (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        asoc_snd_soc_dapm_path (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        asoc_snd_soc_dapm_connected (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        asoc_snd_soc_jack_irq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        asoc_snd_soc_jack_report (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        asoc_snd_soc_jack_notify (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        gpio_direction (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        gpio_value (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        block_touch_buffer (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        block_dirty_buffer (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        block_rq_requeue (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        block_rq_complete (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        block_rq_insert (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        block_rq_issue (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        block_rq_merge (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        block_bio_complete (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        block_bio_bounce (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        block_bio_backmerge (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        block_bio_frontmerge (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        block_bio_queue (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        block_getrq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        block_plug (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        block_unplug (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        block_split (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        block_bio_remap (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        block_rq_remap (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_free_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_request_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_allocate_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_evict_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_drop_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_mark_inode_dirty (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_begin_ordered_truncate (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_write_begin (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_da_write_begin (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_ordered_write_end (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_writeback_write_end (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_journalled_write_end (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_da_write_end (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_da_writepages (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_da_write_pages (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_da_write_pages_extent (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_da_writepages_result (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_writepage (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_readpage (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_releasepage (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_invalidatepage (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_journalled_invalidatepage (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_discard_blocks (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_mb_new_inode_pa (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_mb_new_group_pa (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_mb_release_inode_pa (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_mb_release_group_pa (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_discard_preallocations (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_mb_discard_preallocations (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_request_blocks (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_allocate_blocks (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_free_blocks (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_sync_file_enter (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_sync_file_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_sync_fs (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_alloc_da_blocks (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_mballoc_alloc (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_mballoc_prealloc (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_mballoc_discard (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_mballoc_free (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_forget (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_da_update_reserve_space (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_da_reserve_space (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_da_release_space (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_mb_bitmap_load (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_mb_buddy_bitmap_load (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_read_block_bitmap_load (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_load_inode_bitmap (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_direct_IO_enter (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_direct_IO_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_fallocate_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_fallocate_enter (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_punch_hole (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_zero_range (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_unlink_enter (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_unlink_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_truncate_enter (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_truncate_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_ext_convert_to_initialized_enter (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_ext_convert_to_initialized_fastpath (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_ext_map_blocks_enter (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_ind_map_blocks_enter (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_ext_map_blocks_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_ind_map_blocks_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_ext_load_extent (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_load_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_journal_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_journal_start_reserved (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_ext_handle_uninitialized_extents (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_get_implied_cluster_alloc_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_ext_put_in_cache (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_ext_in_cache (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_find_delalloc_range (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_get_reserved_cluster_alloc (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_ext_show_extent (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_remove_blocks (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_ext_rm_leaf (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_ext_rm_idx (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_ext_remove_space (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_ext_remove_space_done (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_es_insert_extent (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_es_cache_extent (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_fc_replay_scan (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        ext4_fc_replay (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        irq_handler_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        irq_handler_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        irq_softirq_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        irq_softirq_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        irq_softirq_raise (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        jbd2_checkpoint (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        jbd2_start_commit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        jbd2_commit_locking (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        jbd2_commit_flushing (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        jbd2_commit_logging (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        jbd2_drop_transaction (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        jbd2_end_commit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        jbd2_submit_inode_data (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        jbd2_run_stats (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        jbd2_checkpoint_stats (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        jbd2_update_log_tail (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        jbd2_write_superblock (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        i2c_write (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        i2c_read (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        i2c_reply (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        i2c_result (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kmem_kmalloc (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kmem_cache_alloc (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kmem_kmalloc_node (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kmem_cache_alloc_node (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kmem_kfree (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kmem_cache_free (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kmem_mm_page_free (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kmem_mm_page_free_batched (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kmem_mm_page_alloc (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kmem_mm_page_alloc_zone_locked (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kmem_mm_page_pcpu_drain (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kmem_mm_page_alloc_extfrag (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_userspace_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_set_irq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_ioapic_set_irq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_msi_set_irq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_ack_irq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_mmio (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_fpu (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_age_page (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_try_async_get_page (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_async_pf_doublefault (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_async_pf_not_present (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_async_pf_ready (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_async_pf_completed (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_x86_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_x86_hypercall (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_x86_hv_hypercall (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_x86_pio (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_x86_cpuid (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_x86_apic (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_x86_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_x86_inj_virq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_x86_inj_exception (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_x86_page_fault (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_x86_msr (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_x86_cr (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_x86_pic_set_irq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_x86_apic_ipi (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_x86_apic_accept_irq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_x86_eoi (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_x86_pv_eoi (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_x86_nested_vmrun (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_x86_nested_intercepts (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_x86_nested_vmexit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_x86_nested_vmexit_inject (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_x86_nested_intr_vmexit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_x86_invlpga (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_x86_skinit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_x86_emulate_insn (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_x86_vcpu_match_mmio (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_x86_write_tsc_offset (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_x86_update_master_clock (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_x86_track_tsc (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        module_load (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        module_free (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        module_get (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        module_put (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        module_request (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_mmu_pagetable_walk (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_mmu_paging_element (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_mmu_set_accessed_bit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_mmu_set_dirty_bit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_mmu_walker_error (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_mmu_get_page (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_mmu_sync_page (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_mmu_unsync_page (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_mmu_prepare_zap_page (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_mmu_mark_mmio_spte (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_mmu_handle_mmio_page_fault (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        kvm_mmu_fast_page_fault (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        napi_poll (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        net_dev_xmit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        net_dev_queue (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        net_if_receive_skb (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        net_if_rx (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        net_napi_gro_frags_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        net_napi_gro_receive_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        net_if_receive_skb_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        net_if_rx_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        net_if_rx_ni_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        net_if_receive_skb_list_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        net_napi_gro_frags_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        net_napi_gro_receive_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        net_if_receive_skb_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        net_if_rx_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        net_if_rx_ni_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        net_if_receive_skb_list_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        printk_console (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        power_cpu_idle (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        power_cpu_frequency (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        power_machine_suspend (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        power_wakeup_source_activate (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        power_wakeup_source_deactivate (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        power_clock_enable (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        power_clock_disable (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        power_clock_set_rate (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        power_domain_target (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        rcu_utilization (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        regmap_reg_write (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        regmap_reg_read (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        regmap_reg_read_cache (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        regmap_hw_read_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        regmap_hw_read_done (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        regmap_hw_write_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        regmap_hw_write_done (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        regmap_regcache_sync (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        regmap_cache_only (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        regmap_cache_bypass (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        signal_generate (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        signal_deliver (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        sched_kthread_stop (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        sched_kthread_stop_ret (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        sched_waking (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        sched_wakeup (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        sched_wakeup_new (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        sched_switch (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        sched_migrate_task (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        sched_process_free (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        sched_process_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        sched_wait_task (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        sched_process_wait (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        sched_process_fork (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        sched_process_exec (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        sched_stat_wait (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        sched_stat_sleep (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        sched_stat_iowait (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        sched_stat_blocked (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        sched_stat_runtime (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        sched_pi_setprio (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        sock_rcvqueue_full (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        sock_exceed_buf_limit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        scsi_dispatch_cmd_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        scsi_dispatch_cmd_error (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        scsi_dispatch_cmd_done (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        scsi_dispatch_cmd_timeout (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        scsi_eh_wakeup (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        skb_kfree (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        skb_consume (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        skb_copy_datagram_iovec (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        lttng_statedump_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        lttng_statedump_end (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        lttng_statedump_process_state (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        lttng_statedump_process_cgroup_ns (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        lttng_statedump_process_ipc_ns (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        lttng_statedump_process_mnt_ns (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        lttng_statedump_process_net_ns (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        lttng_statedump_process_pid_ns (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        lttng_statedump_process_user_ns (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        lttng_statedump_process_uts_ns (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        lttng_statedump_process_time_ns (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        lttng_statedump_file_descriptor (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        lttng_statedump_vm_map (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        lttng_statedump_network_interface (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        lttng_statedump_block_device (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        lttng_statedump_interrupt (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        lttng_statedump_cpu_topology (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        rpc_call_status (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        rpc_bind_status (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        rpc_connect_status (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        rpc_task_begin (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        rpc_task_run_action (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        rpc_task_complete (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        rpc_task_sleep (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        rpc_task_wakeup (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        timer_init (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        timer_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        timer_expire_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        timer_expire_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        timer_cancel (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        timer_hrtimer_init (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        timer_hrtimer_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        timer_hrtimer_expire_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        timer_hrtimer_expire_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        timer_hrtimer_cancel (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        timer_itimer_state (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        timer_itimer_expire (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        mm_vmscan_kswapd_sleep (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        mm_vmscan_kswapd_wake (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        mm_vmscan_wakeup_kswapd (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        mm_vmscan_direct_reclaim_begin (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        mm_vmscan_memcg_reclaim_begin (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        mm_vmscan_memcg_softlimit_reclaim_begin (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        mm_vmscan_direct_reclaim_end (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        mm_vmscan_memcg_reclaim_end (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        mm_vmscan_memcg_softlimit_reclaim_end (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        mm_vmscan_shrink_slab_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        mm_vmscan_shrink_slab_end (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        mm_vmscan_lru_isolate (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        mm_vmscan_writepage (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        mm_vmscan_lru_shrink_inactive (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        udp_fail_queue_rcv_skb (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        x86_exceptions_page_fault_user (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        x86_exceptions_page_fault_kernel (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        workqueue_queue_work (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        workqueue_activate_work (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        workqueue_execute_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        workqueue_execute_end (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_dirty_page (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_dirty_inode_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_dirty_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_mark_inode_dirty (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_write_inode_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_write_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_nothread (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_queue (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_exec (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_written (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_wait (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_pages_written (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_bdi_register (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_nowork (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_wake_background (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_wake_thread (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_wake_forker_thread (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_bdi_unregister (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_thread_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_thread_stop (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_wbc_writepage (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_queue_io (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_global_dirty_state (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_bdi_dirty_ratelimit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_balance_dirty_pages (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_sb_inodes_requeue (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_congestion_wait (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_wait_iff_congested (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        writeback_single_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        x86_irq_vectors_local_timer_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        x86_irq_vectors_local_timer_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        x86_irq_vectors_reschedule_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        x86_irq_vectors_reschedule_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        x86_irq_vectors_spurious_apic_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        x86_irq_vectors_spurious_apic_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        x86_irq_vectors_error_apic_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        x86_irq_vectors_error_apic_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        x86_irq_vectors_ipi_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        x86_irq_vectors_ipi_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        x86_irq_vectors_irq_work_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        x86_irq_vectors_irq_work_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        x86_irq_vectors_call_function_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        x86_irq_vectors_call_function_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        x86_irq_vectors_call_function_single_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        x86_irq_vectors_call_function_single_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        x86_irq_vectors_threshold_apic_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        x86_irq_vectors_threshold_apic_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        x86_irq_vectors_deferred_error_apic_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        x86_irq_vectors_deferred_error_apic_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        x86_irq_vectors_thermal_apic_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>        x86_irq_vectors_thermal_apic_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
