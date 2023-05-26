Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF281C7EE23
	for <lttng-dev@archiver.kernel.org>; Fri, 26 May 2023 14:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1685112942;
	bh=ys4iUplO571HG5Lf+4I7feC5ICbJXJKEylu7YKUUdwU=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=KdVgRBwZsB9bpv/CRzljLgyLGiZpSqUDEa7rsb/lVCor0lnv46lbIZY0ZEoQ3SK56
	 lkWVBn92vesgin/092pX8nMzRomnuVxy4l7KhEwIGOQ+QS+JTBKKb0oG8mjgEXBSO9
	 ZXZxGz3nRqZixy3tjGZ/tvr/3MlOOR5RoW7kmo5mXf/JQTetCflmQscK1bOMKdur1u
	 jR/UX6uZG8QfL+8uxcvFe2/y7BjRoHJek77BpyvwpGbav1GRIWkQp00RsLnNpPj3S1
	 MQfDHVQo7PxADcowinSwZJuAMnNJNELu4VgwbLobzEPL0yLcXuTkunyVqrgzRCD2KP
	 RKW4ReEKRnoMw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QSSf60gSVz1TGJ;
	Fri, 26 May 2023 10:55:42 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QSSf22h8bz1SlV
 for <lttng-dev@lists.lttng.org>; Fri, 26 May 2023 10:55:38 -0400 (EDT)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QSSdz42vcz15h7
 for <lttng-dev@lists.lttng.org>; Fri, 26 May 2023 10:55:35 -0400 (EDT)
Message-ID: <e115cc79-e024-a16d-ece9-23a8a798d5fc@efficios.com>
Date: Fri, 26 May 2023 10:55:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: lttng-dev <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] Tracing Summit 2023 CFP and Registration (Sept. 17-18,
 2023)
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

Hello all,

Registration for the 2023 Tracing Summit [0] is now open! This year,
the event is co-located with Open Source Summit Europe 2023 [1] and
will be held in Bilbao, Spain on the 17th and 18th of September, 2023.

There are several options for registration:
- In-person ($80.00 USD):
     - Add the Tracing Summit to your Open Source Summit Europe ticket [2]
     - Register solely for the Tracing Summit [3]
- Virtual (Free) [4]

Applicant speakers may register now, and accepted speakers will have
their ticket cost reimbursed.

----

The 2023 Tracing Summit is a two-day, single-track conference on the topic
of tracing. The event focuses on software and hardware tracing, gathering
developers and end-users of tracing and trace analysis tools. The main goal
of the Tracing Summit is to provide space for discussion between people of
the various areas that benefit from tracing, namely parallel, distributed
and/or real-time systems, as well as kernel development.

- Event dates: Sunday, September 17th - Monday, September 18th
- Location: Bilbao, Spain and virtually (co-located with Open Source Summit
   Europe)
- Registration cost:
     - In person: $80.00 USD (Free for speakers)
     - Virtual: Free
- Call for proposals link: [5]


The Tracing Summit Call for proposals is currently open! We are welcoming
30 minute presentations from both end users and developers, on topics such
as live tracing and monitoring, investigation workflow of real-time latency
issues, and more. Please refer to the CFP page [5] for a full list of topic
suggestions.

Important dates:
- Call for proposals close: Friday, June 16th, at 11:59PM EDT
- Call for proposals notifications: Friday, June 23rd
- Schedule announcement: Tuesday, June 27th
- Event dates: Sunday, September 17th - Monday, September 18th

To receive updates about the Tracing Summit, you may subscribe to the event's
mailing list [6].

Please send any questions about this conference to <info@tracingsummit.org>.

The 2023 Tracing Summit is sponsored by EfficiOS and organized by Erica Bugden
(EfficiOS), Olivier Dion (EfficiOS), and Mathieu Desnoyers (EfficiOS) on the
behalf of the Linux Foundation Diagnostic and Monitoring Workgroup [7].

Thanks,

Mathieu

[0]: https://tracingsummit.org
[1]: https://events.linuxfoundation.org/open-source-summit-europe/
[2]: https://events.linuxfoundation.org/open-source-summit-europe/features/co-located-events/#tracing-summit
[3]: https://cvent.me/Gn0nkR (In person)
[4]: https://cvent.me/xywylX (Virtual)
[5]: https://cfp.tracingsummit.org/ts2023/cfp
[6]: https://eepurl.com/goakfv
[7]: https://diamon.org/


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
