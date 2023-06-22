Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1585EB64D8
	for <lttng-dev@archiver.kernel.org>; Thu, 22 Jun 2023 03:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1687405453;
	bh=NlNFGRjRjwMCGgB8mk+o2P/gohDfsMNwanJecWL6Mzg=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=lad4d5TMmvFkRaVX9KA0jmG+ymknPInBAglzpxQ+Rc/7+yNS/Jn44xPkpUCUph6vq
	 BZfU3BIEykG85OpHGxj/xpOgZUt4ue9HlAOQrgQUV8JsoBeKxsvsxXYy+wTP8UecVc
	 82P8h71j6Raoy5FxHIJiQh7K4Sq0umeYxrwvFdt12pT0OK27wwIeY9Q4INkbnL3zBG
	 vb/DzDDTT6HQDhfditBUHYSqeX10WKH/DSHaxVclCU/ZSd5cLvobikFI/hLEWT5YoV
	 CSk/i06bmLK1pLZliF9LIDN8sNIwQkQljfmAX6K+1p74E1wA6Wz1jdrA5ZrDSnE2X9
	 jcPL6/4r3GLAQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QmmSs0xC2z1ykg;
	Wed, 21 Jun 2023 23:44:13 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by lists.lttng.org (Postfix) with ESMTPS id 4QmmSq5TSFz1ykd
 for <lttng-dev@lists.lttng.org>; Wed, 21 Jun 2023 23:44:11 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 747CE61703;
 Thu, 22 Jun 2023 03:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0338C433C8;
 Thu, 22 Jun 2023 03:44:09 +0000 (UTC)
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
 id 62404CE007D; Wed, 21 Jun 2023 20:44:09 -0700 (PDT)
Date: Wed, 21 Jun 2023 20:44:09 -0700
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Olivier Dion <odion@efficios.com>, lttng-dev@lists.lttng.org
Message-ID: <639e2d14-651a-4f1c-a121-eb227c3abe15@paulmck-laptop>
References: <20230515201718.9809-1-odion@efficios.com>
 <20230515201718.9809-5-odion@efficios.com>
 <bc031f8e-8380-4a1d-bfe2-9e8204e06283@paulmck-laptop>
 <877crwmi54.fsf@laura>
 <9ca1c2ca-a027-7178-f552-e0f8fa8f2d2f@efficios.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9ca1c2ca-a027-7178-f552-e0f8fa8f2d2f@efficios.com>
Subject: Re: [lttng-dev] [PATCH 04/11] urcu/arch/generic: Use atomic
 builtins if configured
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Wed, Jun 21, 2023 at 09:48:10PM -0400, Mathieu Desnoyers wrote:
> On 6/21/23 20:53, Olivier Dion wrote:
> > On Wed, 21 Jun 2023, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > On Mon, May 15, 2023 at 04:17:11PM -0400, Olivier Dion wrote:
> > > >   #ifndef cmm_mb
> > > >   #define cmm_mb()    __sync_synchronize()
> > > 
> > > Just out of curiosity, why not also implement cmm_mb() in terms of
> > > __atomic_thread_fence(__ATOMIC_SEQ_CST)?  (Or is that a later patch?)
> > 
> > IIRC, Mathieu and I agree that the definition of a thread fence -- acts
> > as a synchronization fence between threads -- is too weak for what we
> > want here.  For example, with I/O devices.
> > 
> > Although __sync_synchronize() is probably an alias for a SEQ_CST thread
> > fence, its definition -- issues a full memory barrier -- is stronger.
> > 
> > We do not want to rely on this assumption (alias) and prefer to rely on
> > the documented definition instead.
> 
> We should document this rationale with a new comment near the #define,
> in case anyone mistakenly decides to use a thread fence there to make it
> similar to the rest of the code in the future.

That would be good, thank you!

Ah, and I did not find any issues with the rest of the patchset.

							Thanx, Paul
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
