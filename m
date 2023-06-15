Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9830DEB64D9
	for <lttng-dev@archiver.kernel.org>; Thu, 15 Jun 2023 20:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1686860767;
	bh=leqLwSZpJ9nVyw5W1Q7/uAjuwziH/deWjMKfDeoR8a8=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=I/X/qN6xxAiMF1YNTBqtT5RvxTxXj1JLYpiQ3F/0Yp/Yt6skBkBbWc6wPZ2z5Sfmw
	 1uqxubDz88+T51i/RHimLes04mZAbBx6wlBlcnJUwnQWc6BjxDHQL4O89VviqmZ29n
	 CiUXr2MnIG5RWvsBszb1Wq0dvwcG8q8oJw7rAB0qZ5O5VwO+/V/ZeBDM09yUgEn/ds
	 h7XJOoej66Se/BLHiXqWW5Psghm+VKZolKWbKqfWR89z2zhrU60RZU1Xq2Yg18ewn9
	 TpMu/DN6ZknUnjMmyxw2ZajmFb8XgtEE9XWbyUsSGqIm7Z1t4Ax7GWH3Hn6bvZQ4Eh
	 m80p6Ln9pbXqg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Qhv264mqKz1ggm;
	Thu, 15 Jun 2023 16:26:06 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4Qhv246X3Kz1ggl
 for <lttng-dev@lists.lttng.org>; Thu, 15 Jun 2023 16:26:04 -0400 (EDT)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4Qhv241KHvz18Zx;
 Thu, 15 Jun 2023 16:26:04 -0400 (EDT)
Message-ID: <55e5ace4-7e85-3f54-c7b8-23d157b556f2@efficios.com>
Date: Thu, 15 Jun 2023 16:26:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Li-Kuan Ou <k777k777tw@gmail.com>, lttng-dev@lists.lttng.org
References: <c43cf89e-99eb-9287-c46a-6ee936e910fc@efficios.com>
 <20230614015148.12974-1-k777k777tw@gmail.com>
In-Reply-To: <20230614015148.12974-1-k777k777tw@gmail.com>
Subject: Re: [lttng-dev] [PATCH] Fix: revise urcu_read_lock_update() comment
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 6/13/23 21:51, Li-Kuan Ou wrote:
> Read-side critical section nesting is tracked in lower-order bits
> and grace-period phase number use a single high-order bit
> 

Merged, thanks!

Mathieu

> Signed-off-by: Li-Kuan Ou <k777k777tw@gmail.com>
> ---
>   include/urcu/static/urcu-bp.h     | 6 +++---
>   include/urcu/static/urcu-mb.h     | 6 +++---
>   include/urcu/static/urcu-memb.h   | 6 +++---
>   include/urcu/static/urcu-signal.h | 6 +++---
>   4 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/include/urcu/static/urcu-bp.h b/include/urcu/static/urcu-bp.h
> index 8ba3830..b163a90 100644
> --- a/include/urcu/static/urcu-bp.h
> +++ b/include/urcu/static/urcu-bp.h
> @@ -137,9 +137,9 @@ static inline enum urcu_bp_state urcu_bp_reader_state(unsigned long *ctr)
>   
>   /*
>    * Helper for _urcu_bp_read_lock().  The format of urcu_bp_gp.ctr (as well as
> - * the per-thread rcu_reader.ctr) has the upper bits containing a count of
> - * _urcu_bp_read_lock() nesting, and a lower-order bit that contains either zero
> - * or URCU_BP_GP_CTR_PHASE.  The smp_mb_slave() ensures that the accesses in
> + * the per-thread rcu_reader.ctr) has the lower-order bits containing a count of
> + * _urcu_bp_read_lock() nesting, and a single high-order URCU_BP_GP_CTR_PHASE bit
> + * that contains either zero or one.  The smp_mb_slave() ensures that the accesses in
>    * _urcu_bp_read_lock() happen before the subsequent read-side critical section.
>    */
>   static inline void _urcu_bp_read_lock_update(unsigned long tmp)
> diff --git a/include/urcu/static/urcu-mb.h b/include/urcu/static/urcu-mb.h
> index b97e42a..253d29b 100644
> --- a/include/urcu/static/urcu-mb.h
> +++ b/include/urcu/static/urcu-mb.h
> @@ -63,9 +63,9 @@ extern DECLARE_URCU_TLS(struct urcu_reader, urcu_mb_reader);
>   
>   /*
>    * Helper for _urcu_mb_read_lock().  The format of urcu_mb_gp.ctr (as well as
> - * the per-thread rcu_reader.ctr) has the upper bits containing a count of
> - * _urcu_mb_read_lock() nesting, and a lower-order bit that contains either zero
> - * or URCU_GP_CTR_PHASE.  The cmm_smp_mb() ensures that the accesses in
> + * the per-thread rcu_reader.ctr) has the lower-order bits containing a count of
> + * _urcu_mb_read_lock() nesting, and a single high-order URCU_BP_GP_CTR_PHASE bit
> + * that contains either zero or one.  The cmm_smp_mb() ensures that the accesses in
>    * _urcu_mb_read_lock() happen before the subsequent read-side critical section.
>    */
>   static inline void _urcu_mb_read_lock_update(unsigned long tmp)
> diff --git a/include/urcu/static/urcu-memb.h b/include/urcu/static/urcu-memb.h
> index c8d102f..f64cb57 100644
> --- a/include/urcu/static/urcu-memb.h
> +++ b/include/urcu/static/urcu-memb.h
> @@ -86,9 +86,9 @@ extern DECLARE_URCU_TLS(struct urcu_reader, urcu_memb_reader);
>   
>   /*
>    * Helper for _rcu_read_lock().  The format of urcu_memb_gp.ctr (as well as
> - * the per-thread rcu_reader.ctr) has the upper bits containing a count of
> - * _rcu_read_lock() nesting, and a lower-order bit that contains either zero
> - * or URCU_GP_CTR_PHASE.  The smp_mb_slave() ensures that the accesses in
> + * the per-thread rcu_reader.ctr) has the lower-order bits containing a count of
> + * _rcu_read_lock() nesting, and a single high-order URCU_BP_GP_CTR_PHASE bit
> + * that contains either zero or one.  The smp_mb_slave() ensures that the accesses in
>    * _rcu_read_lock() happen before the subsequent read-side critical section.
>    */
>   static inline void _urcu_memb_read_lock_update(unsigned long tmp)
> diff --git a/include/urcu/static/urcu-signal.h b/include/urcu/static/urcu-signal.h
> index c7577d3..707eaf8 100644
> --- a/include/urcu/static/urcu-signal.h
> +++ b/include/urcu/static/urcu-signal.h
> @@ -64,9 +64,9 @@ extern DECLARE_URCU_TLS(struct urcu_reader, urcu_signal_reader);
>   
>   /*
>    * Helper for _rcu_read_lock().  The format of urcu_signal_gp.ctr (as well as
> - * the per-thread rcu_reader.ctr) has the upper bits containing a count of
> - * _rcu_read_lock() nesting, and a lower-order bit that contains either zero
> - * or URCU_GP_CTR_PHASE.  The cmm_barrier() ensures that the accesses in
> + * the per-thread rcu_reader.ctr) has the lower-order bits containing a count of
> + * _rcu_read_lock() nesting, and a single high-order URCU_BP_GP_CTR_PHASE bit
> + * that contains either zero or one.  The cmm_barrier() ensures that the accesses in
>    * _rcu_read_lock() happen before the subsequent read-side critical section.
>    */
>   static inline void _urcu_signal_read_lock_update(unsigned long tmp)

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
