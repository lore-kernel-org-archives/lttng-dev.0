Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D172C7EE25
	for <lttng-dev@archiver.kernel.org>; Mon, 15 May 2023 19:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684178455;
	bh=37AW8NvzRzhxhZOEN4anCTy34ToFNcsRMGzkIjuSMFk=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=SkxLITP7qPZx1kwakf/J0tDQvq0gffv+NhfouaRDbT4NQxUckNXBGtwTcWTTi3+yx
	 +Khas2tyP5qd0rm2g+oM+PVLQZHjMbufzCWrEuXAvmou6GZdQLT+Qy+e0wRzVWFgYx
	 maz03tpH46KnZ2yUhZpNgfUaUpnsRgqM0rcwtMbYoS4dNIgYJYIkS1Z5FobTFbSy75
	 92vttg3nsDrup2jtNpRDbkhATBOYkyDcLHzA4ChyN7hHSz/pEHa5csrAkh5WmcJ2Em
	 Xdsn74Zdzy0TZKVeXHE1YmwB9sdrhvdUDJIbSCTRXshSuKJksZbnAL4i6m2btFzitz
	 XrYJbdC54SOxQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QKq3C1qGLz1DS2;
	Mon, 15 May 2023 15:20:55 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QKq376F1vz1F43
 for <lttng-dev@lists.lttng.org>; Mon, 15 May 2023 15:20:50 -0400 (EDT)
Received: from [172.16.0.99] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QKq361sNlz12KS
 for <lttng-dev@lists.lttng.org>; Mon, 15 May 2023 15:20:50 -0400 (EDT)
Message-ID: <cf6c44a7-70e3-edfd-d728-11cd03b8a91e@efficios.com>
Date: Mon, 15 May 2023 15:20:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: lttng-dev <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] Tracing Summit 2023 Announcement and CFP
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
Reply-To: info@tracingsummit.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hello all!

This is a Call for Proposals for the Tracing Summit 2023[0] which will be held in Bilbao,
Spain on the 17th and 18th of September, 2023. This year, the event is co-located with
Open Source Summit Europe 2023 [1].

- Event dates: Sunday, September 17th - Monday, September 18th
- Location: Bilbao, Spain and virtually (co-located with Open Source Summit Europe)
- Registration cost
     - In person: $80.00 USD (Free for speakers)
     - Virtual: Free
- Call for proposals link: [2]

Important dates:
- Call for proposals close: Friday, June 16th, at 11:59PM EDT
- Call for proposals notifications: Friday, June 23rd
- Schedule announcement: Tuesday, June 27th
- Event dates: Sunday, September 17th - Monday, September 18th

Stand-alone registration is expected to open next week. In the meantime, you can subscribe
to the mailing list to get the latest information on the event: [3]

The 2023 Tracing Summit is a two-day, single-track conference on the topic of tracing. The
event focuses on software and hardware tracing, gathering developers and end-users of tracing
and trace analysis tools. The main goal of the Tracing Summit is to provide space for
discussion between people of the various areas that benefit from tracing, namely parallel,
distributed and/or real-time systems, as well as kernel development.

We are welcoming 30 minute presentations from both end users and developers, on topics
covering, but not limited to:

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

Talks can cover recently available technologies, ongoing work, and yet non-existing
technologies (that are compelling to end-users). Talks covering interesting or challenging
tracing use cases are also welcome as they can reveal future directions or tooling needs.

Please understand that this open forum is not the proper place to present sales or marketing
pitches, nor technologies which are prevented from being freely used in open source.

Please send any questions about this conference to <info@tracingsummit.org>.

This event is organized by EfficiOS on behalf of the Linux Foundation Diagnostic and
Monitoring Workgroup [4].

The organizers of this event are Mathieu Desnoyers (EfficiOS), Erica Bugden (EfficiOS)
and Olivier Dion (EfficiOS).

[0]: https://tracingsummit.org
[1]: https://events.linuxfoundation.org/open-source-summit-europe/
[2]: https://cfp.tracingsummit.org/ts2023/cfp
[3]: https://eepurl.com/goakfv
[4]: https://diamon.org/

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
