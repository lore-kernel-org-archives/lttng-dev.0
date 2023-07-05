Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7B1EB64DA
	for <lttng-dev@archiver.kernel.org>; Wed,  5 Jul 2023 19:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1688585342;
	bh=uVJaXQ1in/VK7VCY8Bia2j4v0AH5IAewyuXF01TrWck=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=PisA33vpCsQnyzNdOTj2azu2f2nZxAAZkEfU2qg26ooTOAh8vghUxv5g6bK/tqArF
	 ufcOYoD0QMrNXm5WAZKfBn+F1mTAUEeQTxCd+7ZzCt2Q4HICYNn9XVxPbQImFmtb2s
	 jPDQYLq6UixpJdzb8PBH3WiWJ1GJbBFwCkCueGm1526Szb7TwQAoSpBAIc/R8cZVt1
	 hLj6MllMoMtAfiAaXy2ruB4uBENRqqLkFLZAg5vP2lxd1XcwcwUtOLY8SM3M9PyFHh
	 XoVt6ni9T1qeJYRT+V5/6QW1pi5GxgHV9per2UhWt0fMyPbo/0lJFfYKvgSUh7O8eg
	 W95XynPvZh2zA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Qx8q13Gsxz246F;
	Wed,  5 Jul 2023 15:29:01 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by lists.lttng.org (Postfix) with ESMTPS id 4Qx8q02lFDz23q6
 for <lttng-dev@lists.lttng.org>; Wed,  5 Jul 2023 15:29:00 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6DAEC615E6;
 Wed,  5 Jul 2023 19:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E296C433C9;
 Wed,  5 Jul 2023 19:28:59 +0000 (UTC)
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
 id C5764CE27E7; Wed,  5 Jul 2023 12:28:58 -0700 (PDT)
Date: Wed, 5 Jul 2023 12:28:58 -0700
To: Olivier Dion <odion@efficios.com>
Message-ID: <d0645415-f325-4f89-b9b4-e77cb0c56c94@paulmck-laptop>
References: <20230515201718.9809-1-odion@efficios.com>
 <20230607185359.8125-5-odion@efficios.com>
 <81bdddb0-0a8e-4ce7-a40d-789bba0a74e2@paulmck-laptop>
 <87o7krd9fa.fsf@laura>
 <116221bf-33e0-4517-bee6-0dbb9cb69f26@paulmck-laptop>
 <871qhmchae.fsf@laura>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <871qhmchae.fsf@laura>
Subject: Re: [lttng-dev] [PATCH v2 04/12] urcu/system: Use atomic builtins
 if configured
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
From: "Paul E. McKenney via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: paulmck@kernel.org
Cc: Tony Finch <dot@dotat.at>, lttng-dev@lists.lttng.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Wed, Jul 05, 2023 at 03:03:21PM -0400, Olivier Dion wrote:
> On Wed, 05 Jul 2023, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > On Tue, Jul 04, 2023 at 10:43:21AM -0400, Olivier Dion wrote:
> >> On Wed, 21 Jun 2023, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >> > On Wed, Jun 07, 2023 at 02:53:51PM -0400, Olivier Dion wrote:
> >> >
> >> > Same question here on loss of volatile semantics.
> >> 
> >> This apply to all review on volatile semantics.  I added a
> >> cmm_cast_volatile() macro/template for C/C++ for adding the volatile
> >> qualifier to pointers passed to every atomic builtin calls.
> >
> > Sounds very good, thank you!
> 
> Maybe a case of synchronicity here, but I just stumble upon this
> <https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2016/p0062r1.html>
> where you seem to express the same concerns :-)

Just for completeness, my response to Hans's concern about volatile is
addressed by an empty memory-clobber asm, similar to barrier() in the
Linux kernel.

But yes, this has seen significant discussion over the years.  ;-)

							Thanx, Paul
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
