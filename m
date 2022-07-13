Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11465CCA47C
	for <lttng-dev@archiver.kernel.org>; Wed, 13 Jul 2022 19:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1657740003;
	bh=Y3M8Q7SL/+5N82Ba+qcYKcpCqxnq3Fl0ME1TKZiBw0I=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=kj3xNlxpvudU4uXoarqU7DmNPAp8aVFHWRC0lEda899xC4KHo98aKnDi8KD331JPl
	 XvL6OI1TrUtEovDMotPb+J/pUBxZN59VBQ2PMvhH3FQinys6GpN5IAXwjyztHgAArB
	 056wfAP4SqmGYRp2B1H7+KiOhFm+2wtKEbm7vNRdA4xrA+5IL8Fv2dZopb4P5+jHcM
	 SAQtvFovSb3B5a3OQ9VJHcL/c4ag0O586kqVRVILdEfFMjRzrX2HfoCFpWgjHkUDWW
	 l2m7diBG8EehE/IxZEDhl3C+o5dkJQaIwmaHbG8LBTtihsy7NeHH2nVQc7dzwNXmGh
	 Np+3PdFY+i3Dw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LjnWQ3h7mzMfd;
	Wed, 13 Jul 2022 15:20:02 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4LjnWP1RZDzMwh
 for <lttng-dev@lists.lttng.org>; Wed, 13 Jul 2022 15:20:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A39FF42685F
 for <lttng-dev@lists.lttng.org>; Wed, 13 Jul 2022 15:20:00 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id kKbS3WRHe1BQ; Wed, 13 Jul 2022 15:20:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 112C0426C13;
 Wed, 13 Jul 2022 15:20:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 112C0426C13
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id LbT8Uuda7r0a; Wed, 13 Jul 2022 15:20:00 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id DBA664268F3;
 Wed, 13 Jul 2022 15:19:59 -0400 (EDT)
Date: Wed, 13 Jul 2022 15:19:59 -0400 (EDT)
To: Diamon discuss <diamon-discuss@lists.linuxfoundation.org>, 
 linux-kernel <linux-kernel@vger.kernel.org>, 
 linux-perf-users <linux-perf-users@vger.kernel.org>, 
 linux-trace-devel <linux-trace-devel@vger.kernel.org>, 
 linux-trace-users <linux-trace-users@vger.kernel.org>, 
 linuxtools-dev@eclipse.org, lttng-dev <lttng-dev@lists.lttng.org>, 
 lwn <lwn@lwn.net>, 
 Trace Compass Developer Discussions <tracecompass-dev@eclipse.org>
Message-ID: <1084656607.67311.1657739999848.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - FF100
 (Linux)/8.8.15_GA_4304)
Thread-Index: GhFp6sgYm5dGm85QpgTZYdYT1/wVUg==
Thread-Topic: Tracing Summit 2022: Announcement and Call for Proposals,
 October 11th - 13th, 2022, London, United Kingdom
Subject: [lttng-dev] Tracing Summit 2022: Announcement and Call for
 Proposals, October 11th - 13th, 2022, London, United Kingdom
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi all,

This is a Call for Proposals for the Tracing Summit 2022[0] which will be held in London, United Kingdom on 11th to 13th of October, 2022.

- Location: Google, 6 Pancras Sq, London N1C 4AG, UK
- Event dates: Tuesday the 11th to Thursday the 13th of October, 2022
- Cost: Free
- CFP link: [1]
- Register to attend: [2]

Timeline:

- CFP Opens: July 13th, 2022
- Registration opens: July 13th, 2022
- CFP Closes: September 1st, 2022
- Registration closes: October 3rd, 2022

You can subscribe to the mailing list to get the latest information on the event: [3]

The Tracing Summit is a three-day, single-track conference on the topic of tracing. The event focuses on software and hardware tracing, gathering developers and end-users of tracing and trace analysis tools. The main goal of the Tracing Summit is to provide space for discussion between people of the various areas that benefit from tracing, namely parallel, distributed and/or real-time systems, as well as kernel development.

We are welcoming 30 minute presentations on topics covering, but not limited to:

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
- Programmable tracing (e.g. eBPF).

Those can cover available technologies, ongoing work, and yet non-existent technologies (which are compelling to end-users).
Please understand that this open forum is not the proper place to present sales or marketing pitches, nor technologies which are prevented from being freely used in open source.

This year tickets are free and seating is limited to 80 people.

To register use the following link: [2]

Please send any queries about this conference to info@tracingsummit.org .

[0]: https://tracingsummit.org
[1]: https://docs.google.com/forms/d/e/1FAIpQLSf65-LaD5EiYSxSN6D6XGRazExSur0SW7oG6ZIpGpDN4ra_rg/viewform
[2]: https://docs.google.com/forms/d/e/1FAIpQLSdq4whieesZeoHJq1h2CDbWeO5FuQnPk6G257hfSLgnWRenvg/viewform
[3]: http://eepurl.com/goakfv

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
