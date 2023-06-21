Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A688EB64D7
	for <lttng-dev@archiver.kernel.org>; Wed, 21 Jun 2023 14:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1687357304;
	bh=GezqUhX4mlsglmr9OtDTUAdZ/sVihOJp5DJnck71lkQ=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=SF4RuE4Vh2FGFeGnCVbIuwe8epd2noMrUIqsfao7S6WtGB5bxUEtMB6y78rljA4nc
	 kifKoAsT4D5ORSRg05OB13u8CgZwWClnoHSDAknSz9xsOQ3WVVf50IbTUWb0jjaUMh
	 1u0h2UwJy4m+vBv91K9lE026kAP9VZ+oEZZX5bgW2GTK8Tmh+XsKD7q6BdoXor0wld
	 +Ip8Gk0lD7MOjKrXW32I4izqZnsi4IEctPr7N+TuHqRM6AXkXTtX4clUVD5aoIurI3
	 bDoD7ZRqC7PdzTh8XURlSBhoH0CHDug7Usd5ZlopO0oGpWNJ7okEzd37ljh/6OFMal
	 bZhz+GSGvn+Fg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QmQfv5yYnz1yNm;
	Wed, 21 Jun 2023 10:21:43 -0400 (EDT)
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com
 [99.78.197.220])
 by lists.lttng.org (Postfix) with ESMTPS id 4QmQft1lmhz1yNk
 for <lttng-dev@lists.lttng.org>; Wed, 21 Jun 2023 10:21:41 -0400 (EDT)
X-IronPort-AV: E=Sophos;i="6.00,260,1681171200"; d="scan'208";a="11551510"
Thread-Topic: [lttng-dev] Profiling LTTng tracepoint latency on different arm
 platforms
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com)
 ([10.25.36.214]) by smtp-border-fw-80009.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 14:21:37 +0000
Received: from EX19D008EUA001.ant.amazon.com
 (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
 by email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com (Postfix)
 with ESMTPS id 10628804A9; Wed, 21 Jun 2023 14:21:37 +0000 (UTC)
Received: from EX19D007EUA004.ant.amazon.com (10.252.50.76) by
 EX19D008EUA001.ant.amazon.com (10.252.50.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 21 Jun 2023 14:21:35 +0000
Received: from EX19D007EUA004.ant.amazon.com ([fe80::d9f5:ab17:b5c0:4f4d]) by
 EX19D007EUA004.ant.amazon.com ([fe80::d9f5:ab17:b5c0:4f4d%3]) with
 mapi id 15.02.1118.026; Wed, 21 Jun 2023 14:21:35 +0000
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Mousa, Anas"
 <anasmous@amazon.com>, "lttng-dev@lists.lttng.org"
 <lttng-dev@lists.lttng.org>
Thread-Index: AQHZo4Jo2UvfndaaQ0q9vbzVbuFXz6+T/AIAgADBwXCAAIkDgIAACSSA
Date: Wed, 21 Jun 2023 14:21:35 +0000
Message-ID: <618d035e059840d3a32b75633aa378f5@amazon.com>
References: <6e06b605ec9f446da5dc8948c8621518@amazon.com>
 <63288a1f-59b4-80f9-2a26-bc252ce9cd1f@efficios.com>
 <900fe19a-5642-9124-4d83-0716e0d11a22@efficios.com>
 <bb2ccac8e296450c96d0863937fc8db8@amazon.com>
 <fb397173-040c-9370-c6c7-3c7b1535becb@efficios.com>
In-Reply-To: <fb397173-040c-9370-c6c7-3c7b1535becb@efficios.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.85.143.178]
MIME-Version: 1.0
Subject: Re: [lttng-dev] Profiling LTTng tracepoint latency on different arm
 platforms
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
From: "Yitschak, Yehuda via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Yitschak, Yehuda" <yehuday@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>


> On 6/21/23 01:39, Yitschak, Yehuda wrote:
> >> On 6/20/23 10:20, Mathieu Desnoyers via lttng-dev wrote:
> >>> On 6/20/23 06:27, Mousa, Anas via lttng-dev wrote:
> >>>> Hello,
> >>>
> >>>>
> >>>>
> >>
> Arethereanysuggestionstorootcausethehighlatencyandpotentiallyimprovei
> >> to
> >> n*platform****1*?
> >>>>
> >>>> Thanks and best regards,
> >>>>
> >>>> Anas.
> >>>>
> >>>
> >>> I recommend using "perf" when tracing with the sample program in a
> >>> loop to figure out the hot spots. With that information on the "fast"
> >>> and "slow" system, we might be able to figure out what differs.
> >>>
> >>> Also, comparing the kernel configurations of the two systems can help.
> >>> Also comparing the glibc versions of the two systems would be relevant.
> >>>
> >>
> >> Also make sure you benchmark the lttng "snapshot" mode [1] to make
> >> sure you don't run into a situation where the disk/network I/O
> >> throughput cannot cope with the generated event throughput, thus
> >> causing the ring buffer to discard events. This would therefore
> >> "speed up" tracing from the application perspective because
> >> discarding an event is faster than writing it to a ring buffer.
> >
> > You mean we should avoid the "discard" loss mode and use "overwrite"
> loss mode since discard mode can fake fast performance ?
> 
> Yes. In addition to use "overwrite-when-buffer-full" mode, the "snapshot"
> session also ensures that no consumer daemon extracts the trace data
> (unless an explicit snapshot record is performed), which allows comparing
> the ring buffer producer performance with minimal noise.
> 
> If you really want to benchmark the discard-when-buffer-full mode and the
> the consumer daemon I/O behavior, then you need to take into account
> event discarded counts and the actual trace data size that was written to
> disk.

Since you mentioned this, is there any "stat" command which lists events such as discards and disk writes, etc ? 
I looked this up in the past but couldn't find anything

> 
> Thanks,
> 
> Mathieu
> 
> >
> >>
> >> Thanks,
> >>
> >> Mathieu
> >>
> >> [1] https://lttng.org/docs/v2.13/#doc-taking-a-snapshot
> >>
> >>> Thanks,
> >>>
> >>> Mathieu
> >>>
> >>>
> >>
> >> --
> >> Mathieu Desnoyers
> >> EfficiOS Inc.
> >> https://www.efficios.com
> >>
> >> _______________________________________________
> >> lttng-dev mailing list
> >> lttng-dev@lists.lttng.org
> >> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
