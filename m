Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579C3C77B7C
	for <lttng-dev@archiver.kernel.org>; Wed, 10 May 2023 21:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1683753039;
	bh=rsIDzFVJqMlGF9PI8Q9isLUdgmYSvDCOCP+BHr3NWns=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=GZA6IWOAGazYyS+iqwnh/PScptv9s6pG2QFIyv/7U6ChVf7vySp/aGO8fxZzACfwk
	 VEx6pTd+v4G4C6UhAx19ZCr3RyPU5DxbBJH1GZD+vmC9XLlqOQ1hdk9J+4EER/aTD5
	 A7lTRgmFSk8nx1Ger17ZPhxysJd82ECJVF9Gs0o7Lmqp22Sn2blwbsCh7l6njXAbnG
	 ib20LhGdBtZRp+6vjuRvEaFN4JhwOzImIeYIrDs/vobNIqwNHBHpaEoofCwQiOWO0K
	 DaLjvCXgvlntQMnscOwqDjIe+tQ0qR/j7dhhr65Ru8tYR0ICu5mC6+WrE7jISj4Dlj
	 Ll2hNlsaMA9dQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QGnk63GkqzSfX;
	Wed, 10 May 2023 17:10:38 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QGnk30lTZzSbX
 for <lttng-dev@lists.lttng.org>; Wed, 10 May 2023 17:10:34 -0400 (EDT)
Received: from localhost (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QGnjv6Vq1z11sy;
 Wed, 10 May 2023 17:10:27 -0400 (EDT)
To: lttng-dev <lttng-dev@lists.lttng.org>
Organization: EfficiOS
Date: Wed, 10 May 2023 17:10:27 -0400
Message-ID: <87v8gzuc3g.fsf@laura>
MIME-Version: 1.0
Subject: [lttng-dev] [RFC] Deprecating RCU signal flavor
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
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi all,

We have the intention of deprecating the urcu-signal flavor in the
future.  We are asking users of URCU for _feedback_ on this before
going any further.

Part of this decision is that we are adding support for TSAN in URCU and
the signal flavor deadlocks with TSAN.  It is also my understanding that
the urcu-signal flavor was historically made as a fallback for system
lacking the membarrier(2) system call.  Nowadays, most systems have
support for that system call, making the urcu-signal an artifact of the
past.

The following is a proposed timeline of events:

  1. Asking for feedback from users of URCU (this message)
  2. Disabling the signal flavor by default and adding --enable-flavor-signal
  3. Removing the signal flavor

-- 
Olivier Dion
EfficiOS Inc.
https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
