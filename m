Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591F3C77B75
	for <lttng-dev@archiver.kernel.org>; Wed, 17 May 2023 14:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684334657;
	bh=SWh4NfQf/ifJdSxFy4M1o3FXlALlZCG/Pk/3dTIQH+w=;
	h=To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ddocp/+qC5iYsNYWwtm6qzGS5xjb96+MO4vJMpzQtvE2ru7sdlTCDbBHeUmt+I9Bu
	 9KbAqU8h1BFutUCYYOUS75ejURqighTcruVeHfdq7mwEy5AXpXCOz5yWlCv/dTSAda
	 3SyjOcT96UXJ786S6qxsuOlnuROSqLxLcmKgSWiP8LcDf3EvNN7wkjdVi9KeV0tMt2
	 YbiBXfX4cOCaosnO5Q1cwtKcTK8y6RyPywDcRVmNxp7IhfbIXSW3yF51tfSjLy4mfL
	 BhSbxJLK45IhXkOg5QKSgUX6FtcpyZHuQas756lo3NIo8rJXMEFt6R7cjJ/s0GeoDR
	 57MWwKX2e0tBw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QLwq33mzhz1FcT;
	Wed, 17 May 2023 10:44:15 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QLwq22RZHz1Fl7
 for <lttng-dev@lists.lttng.org>; Wed, 17 May 2023 10:44:14 -0400 (EDT)
Received: from localhost (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QLwq12lyHz12MZ;
 Wed, 17 May 2023 10:44:13 -0400 (EDT)
To: Dmitry Vyukov <dvyukov@google.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@kernel.org>
In-Reply-To: <CACT4Y+YFNRKTgA=s8+ntiwEsRVq9WAR2pBF3toyiGe08mUQ4Gg@mail.gmail.com>
Organization: EfficiOS
References: <20230515201718.9809-1-odion@efficios.com>
 <CACT4Y+b-THcfzGiXxu8Wc79GwiMsQREPnykffj52+sDLcDqHvw@mail.gmail.com>
 <874jocl1lf.fsf@laura>
 <CACT4Y+YFNRKTgA=s8+ntiwEsRVq9WAR2pBF3toyiGe08mUQ4Gg@mail.gmail.com>
Date: Wed, 17 May 2023 10:44:13 -0400
Message-ID: <87wn17j9vm.fsf@laura>
MIME-Version: 1.0
Subject: Re: [lttng-dev] [PATCH 00/11] Add support for TSAN to liburcu
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
From: Olivier Dion via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Olivier Dion <odion@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Wed, 17 May 2023, Dmitry Vyukov <dvyukov@google.com> wrote:

> Forking under tsan is a bit tricky. But I see we now take a number of
> internal mutexes around  fork (but I think still not all of them), so
> maybe it's not that bad. If  TSAN_OPTIONS=die_after_fork=0 works
> reasonably reliably for you, then export it for testing.

Works like a charm!  Thanks for that!

-- 
Olivier Dion
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
