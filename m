Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1E4EB64DC
	for <lttng-dev@archiver.kernel.org>; Thu, 29 Jun 2023 16:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1688057343;
	bh=9+AwGk1TL8khZEVmIt5VRpCFSrCXpPhRL3HzW8LpZSc=;
	h=To:In-Reply-To:References:Date:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Ivpdy9OKalSPCTsGztYNI/rp9w3zQZGyG3wYKxzKBqXYhrEud8oNgQWzk72FAK7CP
	 dODgcozyaV3xciXiC/+FZVxuFMGLWbs3CiLNiTg7xHMr34eZXMlXQH7pAZIU9SNN+A
	 cmh4r3xDiB48fEN+WQABNgK2ZRPXAsV5OmDKsVW4iL+sHwN9agb7x75DtDkN8nT0KF
	 loYCzCreXabh32kIwQg/qyepGzk+gGZP6hdT0092qg5vFd3tlcwrvxhKEQUKXD5IIg
	 noriA4QKRxJXH5wRHDWiJLOEhDsU3E+my3Op64BFzjWCz1liJ8Xj0wa0TZAFbSNB29
	 bXIdO9C8IYHMg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QsPYB5Clhz22ST;
	Thu, 29 Jun 2023 12:49:02 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QsPY93091z223w
 for <lttng-dev@lists.lttng.org>; Thu, 29 Jun 2023 12:49:01 -0400 (EDT)
Received: from localhost (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QsPY839LCz19Rn;
 Thu, 29 Jun 2023 12:49:00 -0400 (EDT)
To: paulmck@kernel.org
In-Reply-To: <b669606b-74bf-4a07-8094-babbd829d9e8@paulmck-laptop>
Organization: EfficiOS
References: <20230515201718.9809-1-odion@efficios.com>
 <20230607185359.8125-6-odion@efficios.com>
 <b669606b-74bf-4a07-8094-babbd829d9e8@paulmck-laptop>
Date: Thu, 29 Jun 2023 12:49:00 -0400
Message-ID: <87bkgyjjsz.fsf@laura>
MIME-Version: 1.0
Subject: Re: [lttng-dev] [PATCH v2 05/12] urcu/uatomic: Add CMM memory model
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
Cc: Tony Finch <dot@dotat.at>, lttng-dev@lists.lttng.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Wed, 21 Jun 2023, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> On Wed, Jun 07, 2023 at 02:53:52PM -0400, Olivier Dion wrote:
>> -#ifdef __URCU_DEREFERENCE_USE_ATOMIC_CONSUME
>> -# define _rcu_dereference(p) __extension__ ({						\
>> -				__typeof__(__extension__ ({				\
>> -					__typeof__(p) __attribute__((unused)) _________p0 = { 0 }; \
>> -					_________p0;					\
>> -				})) _________p1;					\
>> -				__atomic_load(&(p), &_________p1, __ATOMIC_CONSUME);	\
>
> There is talk of getting rid of memory_order_consume.  But for the moment,
> it is what there is.  Another alternative is to use a volatile load,
> similar to old-style CMM_LOAD_SHARED() or in-kernel READ_ONCE().

I think we can stick to __ATOMIC_CONSUME for now.  Hopefully getting rid
of it means it will be an alias for __ATOMIC_ACQUIRE for ever.

-- 
Olivier Dion
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
