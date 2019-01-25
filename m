From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH urcu] Add multiflavor compat identifiers
Date: Fri, 25 Jan 2019 17:47:05 -0500 (EST)
Message-ID: <21293291.1404.1548456425148.JavaMail.zimbra__30123.93274564$1548456450$gmane$org@efficios.com>
References: <20190125201554.25502-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 43mZ0J6QV8zn82
 for <lttng-dev@lists.lttng.org>; Fri, 25 Jan 2019 17:47:12 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id ED96CB69A9
 for <lttng-dev@lists.lttng.org>; Fri, 25 Jan 2019 17:47:05 -0500 (EST)
In-Reply-To: <20190125201554.25502-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On Jan 25, 2019, at 3:15 PM, Michael Jeanson mjeanson@efficios.com wrote:

> This will maintain buildtime compatibility with softwares like lttng-ust
> that used the prior undocumented multiflavor API.
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> include/urcu/map/urcu-bp.h     | 63 ++++++++++++++++++++++++++++++++++
> include/urcu/map/urcu-mb.h     | 60 ++++++++++++++++++++++++++++++++
> include/urcu/map/urcu-memb.h   | 62 +++++++++++++++++++++++++++++++++
> include/urcu/map/urcu-qsbr.h   | 62 +++++++++++++++++++++++++++++++++
> include/urcu/map/urcu-signal.h | 62 +++++++++++++++++++++++++++++++++
> src/urcu-bp.c                  |  1 +
> src/urcu-qsbr.c                |  1 +
> src/urcu.c                     |  1 +
> 8 files changed, 312 insertions(+)
> 
[...]
> diff --git a/include/urcu/map/urcu-mb.h b/include/urcu/map/urcu-mb.h
> index fa77a1a..f4e89b9 100644
> --- a/include/urcu/map/urcu-mb.h
> +++ b/include/urcu/map/urcu-mb.h
> @@ -128,3 +128,63 @@
> #define alias_rcu_defer_barrier		rcu_defer_barrier_mb
> #define alias_rcu_defer_barrier_thread	rcu_defer_barrier_thread_mb
> #define alias_rcu_defer_exit		rcu_defer_exit_mb
> +
> +
> +/* Compat identifiers for prior undocumented multiflavor usage */
> +#ifndef URCU_NO_COMPAT_IDENTIFIERS
> +
> +#define rcu_dereference_mb		urcu_bp_dereference
> +#define rcu_cmpxchg_pointer_mb		urcu_bp_cmpxchg_pointer
> +#define rcu_xchg_pointer_mb		urcu_bp_xchg_pointer
> +#define rcu_set_pointer_mb		urcu_bp_set_pointer
> +
> +#define rcu_mb_before_fork		urcu_bp_before_fork
> +#define rcu_mb_after_fork_parent	urcu_bp_after_fork_parent
> +#define rcu_mb_after_fork_child		urcu_bp_after_fork_child

For the above: urcu_bp -> urcu_mb.

[...]

> +#endif /* URCU_NO_COMPAT_IDENTIFIERS */
> diff --git a/include/urcu/map/urcu-memb.h b/include/urcu/map/urcu-memb.h
> index 33f9a9b..f15a645 100644
> --- a/include/urcu/map/urcu-memb.h
> +++ b/include/urcu/map/urcu-memb.h
> @@ -128,3 +128,65 @@
> #define alias_rcu_defer_barrier		rcu_defer_barrier_memb
> #define alias_rcu_defer_barrier_thread	rcu_defer_barrier_thread_memb
> #define alias_rcu_defer_exit		rcu_defer_exit_memb
> +
> +
> +/* Compat identifiers for prior undocumented multiflavor usage */
> +#ifndef URCU_NO_COMPAT_IDENTIFIERS
> +
> +#define rcu_dereference_memb		urcu_bp_dereference
> +#define rcu_cmpxchg_pointer_memb	urcu_bp_cmpxchg_pointer
> +#define rcu_xchg_pointer_memb		urcu_bp_xchg_pointer
> +#define rcu_set_pointer_memb		urcu_bp_set_pointer
> +
> +#define rcu_memb_before_fork		urcu_bp_before_fork
> +#define rcu_memb_after_fork_parent	urcu_bp_after_fork_parent
> +#define rcu_memb_after_fork_child	urcu_bp_after_fork_child

For the above: urcu_bp -> urcu_memb.

[...]

> +#endif /* URCU_NO_COMPAT_IDENTIFIERS */
> diff --git a/include/urcu/map/urcu-qsbr.h b/include/urcu/map/urcu-qsbr.h
> index 2b4d861..1af8c54 100644
> --- a/include/urcu/map/urcu-qsbr.h
> +++ b/include/urcu/map/urcu-qsbr.h
> @@ -126,3 +126,65 @@
> #define alias_rcu_defer_barrier		rcu_defer_barrier_qsbr
> #define alias_rcu_defer_barrier_thread	rcu_defer_barrier_thread_qsbr
> #define alias_rcu_defer_exit		rcu_defer_exit_qsbr
> +
> +
> +/* Compat identifiers for prior undocumented multiflavor usage */
> +#ifndef URCU_NO_COMPAT_IDENTIFIERS
> +
> +#define rcu_dereference_qsbr		urcu_bp_dereference
> +#define rcu_cmpxchg_pointer_qsbr	urcu_bp_cmpxchg_pointer
> +#define rcu_xchg_pointer_qsbr		urcu_bp_xchg_pointer
> +#define rcu_set_pointer_qsbr		urcu_bp_set_pointer
> +
> +#define rcu_qsbr_before_fork		urcu_bp_before_fork
> +#define rcu_qsbr_after_fork_parent	urcu_bp_after_fork_parent
> +#define rcu_qsbr_after_fork_child	urcu_bp_after_fork_child
> +

For the above: urcu_bp -> urcu_qsbr.

[...]

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
