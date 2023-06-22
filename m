Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A26EB64D7
	for <lttng-dev@archiver.kernel.org>; Thu, 22 Jun 2023 00:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1687395243;
	bh=Jpu88xAKoy/l17UPyqC0AM+QrR/366KOjC1uebjTb3o=;
	h=To:In-Reply-To:References:Date:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=oldCO82HtWWz0PXHNPglMRMZ9GoMN5ef6cGHbUVi1UuPnt7XzDsLUAz5n2Jh1a7lB
	 tfsJB4smCxm3prd0WAbhEmEmBnK8mAWHlhvRexJK4kk1ZGgkLxnuXioJlioAnFz64u
	 Q8pc9ePgEnL8Yf3f73TtL9GDAbRimQqnHfKNRODKKU3WAv6CnLhuctXpuYKPzWU1yF
	 82R/VsG1HpxzPTYUPPyKsuw26EYKHvfMVAPeIAz1WZPoOGThonpeOSYd7/wj5ZPsvM
	 Llnmtlte5AbCAbct7EfhhGlHdJElIslVgwbh3jAiZ4r5L7U9ukN8l5mehOP4mkNdwm
	 doJysgs42gbtg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QmhhV3Dzvz1ynb;
	Wed, 21 Jun 2023 20:54:02 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QmhhT2JcVz1ybb
 for <lttng-dev@lists.lttng.org>; Wed, 21 Jun 2023 20:54:01 -0400 (EDT)
Received: from localhost (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QmhhR5h7xz197Z;
 Wed, 21 Jun 2023 20:53:59 -0400 (EDT)
To: paulmck@kernel.org
In-Reply-To: <bc031f8e-8380-4a1d-bfe2-9e8204e06283@paulmck-laptop>
Organization: EfficiOS
References: <20230515201718.9809-1-odion@efficios.com>
 <20230515201718.9809-5-odion@efficios.com>
 <bc031f8e-8380-4a1d-bfe2-9e8204e06283@paulmck-laptop>
Date: Wed, 21 Jun 2023 20:53:59 -0400
Message-ID: <877crwmi54.fsf@laura>
MIME-Version: 1.0
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
From: Olivier Dion via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Olivier Dion <odion@efficios.com>
Cc: lttng-dev@lists.lttng.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Wed, 21 Jun 2023, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> On Mon, May 15, 2023 at 04:17:11PM -0400, Olivier Dion wrote:
>>  #ifndef cmm_mb
>>  #define cmm_mb()    __sync_synchronize()
>
> Just out of curiosity, why not also implement cmm_mb() in terms of
> __atomic_thread_fence(__ATOMIC_SEQ_CST)?  (Or is that a later patch?)

IIRC, Mathieu and I agree that the definition of a thread fence -- acts
as a synchronization fence between threads -- is too weak for what we
want here.  For example, with I/O devices.

Although __sync_synchronize() is probably an alias for a SEQ_CST thread
fence, its definition -- issues a full memory barrier -- is stronger.

We do not want to rely on this assumption (alias) and prefer to rely on
the documented definition instead.

-- 
Olivier Dion
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
