Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1396AEB64DA
	for <lttng-dev@archiver.kernel.org>; Wed,  5 Jul 2023 18:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1688582929;
	bh=iQGXSDyxuBrOLrINNN+pu2c9nPwcwxRYqlhax0LVd0M=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=i0R/u1VAc1xF2U2RDJ1M9Bh9b65FgsCOiQLyY0KL9TSrRyJFKeSHt0UzEY4L8XpoL
	 cJMJxVQ+HYCnX+IkxVbrWEiNjtW3K7NV5Rw7zlmaM9LiEOu605rPpeicHeSe+B1fEN
	 VPo75oze1/XI+8vK66HaDzAASlJjdReiw4dFbeIdY9BSbHHPRErA3M8AVZKKdt9dAT
	 qsVebX3tY3/rczk4jo7moLNs/hKYbOsAKyXhY85hQsiYoqfk0rlCDvznkmznezCsQt
	 flLWMSbEbdBqNWoDh5CFcF7r8WrQpK+PkHWfyo2dlCiITHhH7iFB7uVD7L0heQnuSo
	 4Av6Y3wGN+ikA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Qx7wc700Dz246B;
	Wed,  5 Jul 2023 14:48:48 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by lists.lttng.org (Postfix) with ESMTPS id 4Qx7wb044Mz23xb
 for <lttng-dev@lists.lttng.org>; Wed,  5 Jul 2023 14:48:46 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 11CAE61642;
 Wed,  5 Jul 2023 18:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755F6C433C7;
 Wed,  5 Jul 2023 18:48:32 +0000 (UTC)
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
 id 1A46CCE0BB2; Wed,  5 Jul 2023 11:48:32 -0700 (PDT)
Date: Wed, 5 Jul 2023 11:48:32 -0700
To: Olivier Dion <odion@efficios.com>
Message-ID: <116221bf-33e0-4517-bee6-0dbb9cb69f26@paulmck-laptop>
References: <20230515201718.9809-1-odion@efficios.com>
 <20230607185359.8125-5-odion@efficios.com>
 <81bdddb0-0a8e-4ce7-a40d-789bba0a74e2@paulmck-laptop>
 <87o7krd9fa.fsf@laura>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87o7krd9fa.fsf@laura>
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

On Tue, Jul 04, 2023 at 10:43:21AM -0400, Olivier Dion wrote:
> On Wed, 21 Jun 2023, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > On Wed, Jun 07, 2023 at 02:53:51PM -0400, Olivier Dion wrote:
> >
> > Same question here on loss of volatile semantics.
> 
> This apply to all review on volatile semantics.  I added a
> cmm_cast_volatile() macro/template for C/C++ for adding the volatile
> qualifier to pointers passed to every atomic builtin calls.

Sounds very good, thank you!

							Thanx, Paul
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
