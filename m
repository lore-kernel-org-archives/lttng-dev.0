Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D32EB64D7
	for <lttng-dev@archiver.kernel.org>; Tue, 13 Jun 2023 20:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1686687374;
	bh=TV7PmsnPqc4oSgfLC13pAiyHYd35uSgYYqnOdmFnNjs=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=ZuThHfJTfAa1SkiqM6Js+ZqcGXgu9CsG07RoLcJOkNwBnyLCAB+1+nftu6M1CRXbX
	 0pl17Z2SSHSDMyHYvTpXvgvVkYqtG1LQJHsaNn7ANGo9lfXrIFcJjzriOW0QCBBuVl
	 b1THPm84rhT5go7k2fEL5UWUeQI5J/l+kzGemQbzoMqVZLeLhv378tIJ9IQYAAuCPE
	 G8yAvMTZMSP5S+4taICoGdmwms0qJSMoLqd4OZEJojAjN7SE4JPvm+q1CrY42/n18h
	 XR75RlBwi5oHeTYCLVp2UmTEmeyjNeEgDBCKcHNrVBBQ+U0LlcKy2/XCXjyqTqZH0X
	 EfNYsJu5RjnqQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Qgfvd2Jxmz1gDm;
	Tue, 13 Jun 2023 16:16:13 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QgfvY27PQz1g5V
 for <lttng-dev@lists.lttng.org>; Tue, 13 Jun 2023 16:16:09 -0400 (EDT)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QgfvR5JNGz187B;
 Tue, 13 Jun 2023 16:16:03 -0400 (EDT)
Message-ID: <c43cf89e-99eb-9287-c46a-6ee936e910fc@efficios.com>
Date: Tue, 13 Jun 2023 16:16:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Li-Kuan Ou <k777k777tw@gmail.com>, lttng-dev@lists.lttng.org
References: <20230613154523.17184-1-k777k777tw@gmail.com>
In-Reply-To: <20230613154523.17184-1-k777k777tw@gmail.com>
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

On 6/13/23 11:45, Li-Kuan Ou via lttng-dev wrote:
> Read-side critical section nesting is tracked in lower-order bits
> and grace-period phase number use a single high-order bit
> 

Thanks for the fix. Here is a comment below,

> Signed-off-by: Li-Kuan Ou <k777k777tw@gmail.com>
> ---
>   include/urcu/static/urcu-bp.h     | 4 ++--
>   include/urcu/static/urcu-mb.h     | 4 ++--
>   include/urcu/static/urcu-memb.h   | 4 ++--
>   include/urcu/static/urcu-signal.h | 4 ++--
>   4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/urcu/static/urcu-bp.h b/include/urcu/static/urcu-bp.h
> index 8ba3830..c90c9f1 100644
> --- a/include/urcu/static/urcu-bp.h
> +++ b/include/urcu/static/urcu-bp.h
> @@ -137,8 +137,8 @@ static inline enum urcu_bp_state urcu_bp_reader_state(unsigned long *ctr)
>   
>   /*
>    * Helper for _urcu_bp_read_lock().  The format of urcu_bp_gp.ctr (as well as
> - * the per-thread rcu_reader.ctr) has the upper bits containing a count of
> - * _urcu_bp_read_lock() nesting, and a lower-order bit that contains either zero
> + * the per-thread rcu_reader.ctr) has the lower-order bits containing a count of
> + * _urcu_bp_read_lock() nesting, and a single high-order bit that contains either zero

I think it would be clearer to state:

Helper for _urcu_bp_read_lock().  The format of urcu_bp_gp.ctr (as well as
the per-thread rcu_reader.ctr) has the lower-order bits containing a count of
urcu_bp_read_lock() nesting, and a single high-order URCU_BP_GP_CTR_PHASE bit
that contains either zero or one.  The smp_mb_slave() ensures that the accesses
in urcu_bp_read_lock() happen before the subsequent read-side critical section.

(likewise for similar comments in other files).

Can you submit an updated patch please ?

Thanks,

Mathieu



>    * or URCU_BP_GP_CTR_PHASE.  The smp_mb_slave() ensures that the accesses in
>    * _urcu_bp_read_lock() happen before the subsequent read-side critical section.
>    */
> diff --git a/include/urcu/static/urcu-mb.h b/include/urcu/static/urcu-mb.h
> index b97e42a..218e2f3 100644
> --- a/include/urcu/static/urcu-mb.h
> +++ b/include/urcu/static/urcu-mb.h
> @@ -63,8 +63,8 @@ extern DECLARE_URCU_TLS(struct urcu_reader, urcu_mb_reader);
>   
>   /*
>    * Helper for _urcu_mb_read_lock().  The format of urcu_mb_gp.ctr (as well as
> - * the per-thread rcu_reader.ctr) has the upper bits containing a count of
> - * _urcu_mb_read_lock() nesting, and a lower-order bit that contains either zero
> + * the per-thread rcu_reader.ctr) has the lower-order bits containing a count of
> + * _urcu_mb_read_lock() nesting, and a single high-order bit that contains either zero
>    * or URCU_GP_CTR_PHASE.  The cmm_smp_mb() ensures that the accesses in
>    * _urcu_mb_read_lock() happen before the subsequent read-side critical section.
>    */
> diff --git a/include/urcu/static/urcu-memb.h b/include/urcu/static/urcu-memb.h
> index c8d102f..b923f73 100644
> --- a/include/urcu/static/urcu-memb.h
> +++ b/include/urcu/static/urcu-memb.h
> @@ -86,8 +86,8 @@ extern DECLARE_URCU_TLS(struct urcu_reader, urcu_memb_reader);
>   
>   /*
>    * Helper for _rcu_read_lock().  The format of urcu_memb_gp.ctr (as well as
> - * the per-thread rcu_reader.ctr) has the upper bits containing a count of
> - * _rcu_read_lock() nesting, and a lower-order bit that contains either zero
> + * the per-thread rcu_reader.ctr) has the lower-order bits containing a count of
> + * _rcu_read_lock() nesting, and a single high-order bit that contains either zero
>    * or URCU_GP_CTR_PHASE.  The smp_mb_slave() ensures that the accesses in
>    * _rcu_read_lock() happen before the subsequent read-side critical section.
>    */
> diff --git a/include/urcu/static/urcu-signal.h b/include/urcu/static/urcu-signal.h
> index c7577d3..00588b8 100644
> --- a/include/urcu/static/urcu-signal.h
> +++ b/include/urcu/static/urcu-signal.h
> @@ -64,8 +64,8 @@ extern DECLARE_URCU_TLS(struct urcu_reader, urcu_signal_reader);
>   
>   /*
>    * Helper for _rcu_read_lock().  The format of urcu_signal_gp.ctr (as well as
> - * the per-thread rcu_reader.ctr) has the upper bits containing a count of
> - * _rcu_read_lock() nesting, and a lower-order bit that contains either zero
> + * the per-thread rcu_reader.ctr) has the lower-order bits containing a count of
> + * _rcu_read_lock() nesting, and a single high-order bit that contains either zero
>    * or URCU_GP_CTR_PHASE.  The cmm_barrier() ensures that the accesses in
>    * _rcu_read_lock() happen before the subsequent read-side critical section.
>    */

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
