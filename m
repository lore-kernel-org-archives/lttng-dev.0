Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44593EB64DA
	for <lttng-dev@archiver.kernel.org>; Thu, 22 Jun 2023 20:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1687464660;
	bh=mtX84/pgKFtIE/28HQ8DGYwKdkuSRFh9KOSrqfnrVL8=;
	h=To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=J2sx/NIxVpga2+eNYLUCBKHyibOO1Jds3cEuRgZ2BuhtUuMn0tTO3gtURr7igzjGg
	 RA5KHfrjWwNNKdvUR9SqOqqghnZt/36tFhSQ+nAdrD5PSAFMx+6llZji2/6NhjVJr4
	 Vm6flHW6OFIh3nVX1HcvrG6PcDnQdfI0+IqiIiwXzyC6osmT89yIuUHF0L+MH90rTN
	 CNBnEVx62dAkL0zI1Cyfg4hL0dKwme+gl0cHeaRtvmC66bNMmHErEbMrL4jywDmMzj
	 e1G4gBeWfZ7QjzPseNkxhWFa4plhDSIdaGnZOn58IjLbggTtNHQFrlNPEnFMQyhOfr
	 44EUh9jiicmGw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QnBMR6KS5z20Qc;
	Thu, 22 Jun 2023 16:10:59 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QnBMR15qHz20QZ
 for <lttng-dev@lists.lttng.org>; Thu, 22 Jun 2023 16:10:59 -0400 (EDT)
Received: from localhost (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QnBMP2nXjz191Z;
 Thu, 22 Jun 2023 16:10:57 -0400 (EDT)
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, paulmck@kernel.org
Cc: lttng-dev@lists.lttng.org
In-Reply-To: <9e5fbcf0-bf3d-c0b3-c45b-2e440e8276e1@efficios.com>
Organization: EfficiOS
References: <20230515201718.9809-1-odion@efficios.com>
 <20230515201718.9809-3-odion@efficios.com>
 <c7834f41-c033-4c53-96e8-0ad728c2a285@paulmck-laptop>
 <ffec193e-7060-3fe2-6526-c54e89e992e6@efficios.com>
 <105bad2a-9fed-4353-a434-a571ce9da7ac@paulmck-laptop>
 <87zg4rl1du.fsf@laura> <9e5fbcf0-bf3d-c0b3-c45b-2e440e8276e1@efficios.com>
Date: Thu, 22 Jun 2023 16:10:57 -0400
Message-ID: <87v8ffl0ku.fsf@laura>
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

On Thu, 22 Jun 2023, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> On 6/22/23 15:53, Olivier Dion wrote:
>> On Thu, 22 Jun 2023, "Paul E. McKenney" <paulmck@kernel.org> wrote:
>> 
>>> I suggest C11 volatile atomic load/store.  Load/store fusing is permitted
>>> for non-volatile atomic loads and stores, and such fusing can ruin your
>>> code's entire day.  ;-)
>> 
>> Good catch.  Seems like not a problem on GCC (yet), but Clang is extremely
>> aggressive and seems to do store fusing on some corner cases [0].
>
> I don't think this is an example of store fusing, but rather just that 
> the compiler can eliminate stores to static variables which are 
> otherwise unused, making the entire variable useless.

Indeed, that is not store fusing.  It is however interesting to see that
the dead store elimination is avoid when casting one of the &x with a
volatile qualifier.  TIL dead store can apply to atomics.

-- 
Olivier Dion
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
