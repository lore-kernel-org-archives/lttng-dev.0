Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659EDEB64DC
	for <lttng-dev@archiver.kernel.org>; Thu, 22 Jun 2023 19:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1687463620;
	bh=3KCRPBEZdE+LCAtLgIPMWiXski8DhD/X8eGBwSVvvZs=;
	h=To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=CM3VH7w4TSQxPzOf6vd9lSbY5DDBrnKJ5/8TylthGosi/IK4kbja/QnvKRuVqHc+B
	 OA0scV22MZ+5j6CEZz3aCHqNMwN3W+D6bEZ6BPq3gEv9m4Xp43veJzqGMVXOzY51H/
	 vLFuqAsy1r+6M/k6URirCIpKXsOdI0mma8a4FJPi35qC/zskwKlybgxQ5oBjCEUhZN
	 U3LTInzhPfd6Xlrs1+AVFvrrXn1kxOj1pOXvdEaL7ZjVWKchi3abM78K0bepCIP0dX
	 dZoU85XtJ3ZLiYL71GfUyeRBswXayGNHDHUfM15RbHKeqEY1dTQ0BSn9aaFVYlVDmI
	 aD65nbNGxLj2g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Qn9zR1rrDz200l;
	Thu, 22 Jun 2023 15:53:39 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4Qn9zM3xHsz200j
 for <lttng-dev@lists.lttng.org>; Thu, 22 Jun 2023 15:53:35 -0400 (EDT)
Received: from localhost (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4Qn9zL1KVFz19FR;
 Thu, 22 Jun 2023 15:53:34 -0400 (EDT)
To: paulmck@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
In-Reply-To: <105bad2a-9fed-4353-a434-a571ce9da7ac@paulmck-laptop>
Organization: EfficiOS
References: <20230515201718.9809-1-odion@efficios.com>
 <20230515201718.9809-3-odion@efficios.com>
 <c7834f41-c033-4c53-96e8-0ad728c2a285@paulmck-laptop>
 <ffec193e-7060-3fe2-6526-c54e89e992e6@efficios.com>
 <105bad2a-9fed-4353-a434-a571ce9da7ac@paulmck-laptop>
Date: Thu, 22 Jun 2023 15:53:33 -0400
Message-ID: <87zg4rl1du.fsf@laura>
MIME-Version: 1.0
Subject: Re: [lttng-dev] [PATCH 02/11] urcu/uatomic: Use atomic builtins if
 configured
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

On Thu, 22 Jun 2023, "Paul E. McKenney" <paulmck@kernel.org> wrote:

> I suggest C11 volatile atomic load/store.  Load/store fusing is permitted
> for non-volatile atomic loads and stores, and such fusing can ruin your
> code's entire day.  ;-)

Good catch.  Seems like not a problem on GCC (yet), but Clang is extremely
aggressive and seems to do store fusing on some corner cases [0].

However, I do not find any simple reproducer of load/store fusing.  Do
you have example of such fusing, or is this a precaution?  In the
meantime, back to reading the standard to be certain :-)

 [0] https://godbolt.org/z/odKG9a75a

-- 
Olivier Dion
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
