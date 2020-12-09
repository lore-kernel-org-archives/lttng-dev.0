Return-Path: <SRS0=Hq7A=FN=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB738C433FE
	for <lttng-dev@archiver.kernel.org>; Wed,  9 Dec 2020 19:43:52 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0274F233A1
	for <lttng-dev@archiver.kernel.org>; Wed,  9 Dec 2020 19:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0274F233A1
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CrnY21LCYz1WFV;
	Wed,  9 Dec 2020 14:43:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1607543030;
	bh=xlJRxejCd3pSEuBc3bBqtlZXhQtHnk6D4mAutEiQfnU=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=nclMshgGY8I6UwVDPP7voOh/lETbcizd+z/T2r0cmrkUln8ghaRmU7Z5y38i1O7n7
	 J90keqP5T1hURxeKTcRBCmdkJBkO43NvQ4tP+S+IX16XjxblTQK2e/zHHge3UtfsKz
	 +7vY/4QwNIpJxmc1a8JEnS4j9vmfFT7Lxn0zhHbTVUgq+7B8cZP3WGXaTg/d23ePLY
	 flkip5/IuvCHQpQd1Ee1lBsrWO2PyeN79WkRQjvmX5VkVtThDrDCr4KhtlBo4jwhpC
	 rAhP2EVHtRS8MekScv1VUrnoCWhKHMQTaFoAcmc1hiU+Anj1CYmkEpl2+3Da7Z864D
	 rLu28vkKVtsEQ==
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by lists.lttng.org (Postfix) with ESMTPS id 4CrnY050PZz1WFT
 for <lttng-dev@lists.lttng.org>; Wed,  9 Dec 2020 14:43:48 -0500 (EST)
Date: Wed, 9 Dec 2020 11:38:18 -0800
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Message-ID: <20201209193818.GF2657@paulmck-ThinkPad-P72>
References: <20201209181537.444048-1-mjeanson@efficios.com>
 <1681186936.97276.1607538587190.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1681186936.97276.1607538587190.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Subject: Re: [lttng-dev] [PATCH urcu] fix: bump tests thread limit to 256
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Wed, Dec 09, 2020 at 01:29:47PM -0500, Mathieu Desnoyers wrote:
> Hi Paul,
> 
> Should I merge this temporary fix for liburcu tests, or should we go
> for dynamic allocation of the array right away instead ?

Getting something running now is a good thing.  I have occasional access
to a system that could use 512, though.  (448 suffices, but powers of
two and all that.)

Longer term, I agree with dynamic allocation.

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> ----- On Dec 9, 2020, at 1:15 PM, Michael Jeanson mjeanson@efficios.com wrote:
> 
> > Machines with more than 128 CPUs are becomming more common, the proper
> > fix here would be to dynamically allocate the array which we will do,
> > but in the meantime bump the limit to 256 to fix the problem on a 160
> > CPUs ppc64el system where this was reported.
> > 
> > Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Change-Id: Ib3cb5d8cb4515e6f626be33c2685fa38cb081782
> > ---
> > tests/common/api.h | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/common/api.h b/tests/common/api.h
> > index 2b72ec5..b15e588 100644
> > --- a/tests/common/api.h
> > +++ b/tests/common/api.h
> > @@ -108,7 +108,7 @@ static void spin_unlock(spinlock_t *sp)
> > 
> > typedef pthread_t thread_id_t;
> > 
> > -#define NR_THREADS 128
> > +#define NR_THREADS 256
> > 
> > #define __THREAD_ID_MAP_EMPTY ((thread_id_t) 0)
> > #define __THREAD_ID_MAP_WAITING ((thread_id_t) 1)
> > --
> > 2.29.2
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
