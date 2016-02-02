From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: Remove not
	used	PREEMPT_ACTIVE in Linux 4.4
Date: Tue, 2 Feb 2016 13:38:48 +0000 (UTC)
Message-ID: <523443816.10171.1454420328647.JavaMail.zimbra__27188.4856898852$1454420404$gmane$org@efficios.com>
References: <1454417813-19236-1-git-send-email-eu@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aQbAa-0003EC-T5
 for lttng-dev@lists.lttng.org; Tue, 02 Feb 2016 08:39:04 -0500
In-Reply-To: <1454417813-19236-1-git-send-email-eu@felipetonello.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Felipe F. Tonello" <eu@felipetonello.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

In instrumentation/events/lttng-module/sched.h, there are ifdefs
checking the kernel version against which lttng-modules is build.
Please ensure you don't remove this flag when building against
older kernels.

The mainline/sched.h file should be removed from lttng-modules,
it's a leftover of initial porting of instrumentation from the
kernel.

Thanks,

Mathieu

----- On Feb 2, 2016, at 7:56 AM, Felipe F. Tonello eu@felipetonello.com wrote:

> This flag was removed in Linux 4.4 as it is not necessary to use it any more.
> 
> Check Linux commits:
> e61bf1e43b6f ('sched/core: Kill PREEMPT_ACTIVE')
> da7142e2ed73 ('sched/core: Simplify preempt_count tests')
> 3d8f74dd4ca1 ('sched/core: Stop setting PREEMPT_ACTIVE')
> 
> Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
> ---
> instrumentation/events/lttng-module/sched.h | 8 ++++----
> instrumentation/events/mainline/sched.h     | 2 +-
> 2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/instrumentation/events/lttng-module/sched.h
> b/instrumentation/events/lttng-module/sched.h
> index 4f3676bf54ea..53edd2af0e06 100644
> --- a/instrumentation/events/lttng-module/sched.h
> +++ b/instrumentation/events/lttng-module/sched.h
> @@ -51,7 +51,7 @@ static inline long __trace_sched_switch_state(struct
> task_struct *p)
> 	/*
> 	 * For all intents and purposes a preempted task is a running task.
> 	 */
> -	if (preempt_count() & PREEMPT_ACTIVE)
> +	if (preempt_count())
> 		state = TASK_RUNNING | TASK_STATE_MAX;
> #endif	/* CONFIG_PREEMPT */
> 
> @@ -68,7 +68,7 @@ static inline long __trace_sched_switch_state(struct
> task_struct *p)
> 	/*
> 	 * For all intents and purposes a preempted task is a running task.
> 	 */
> -	if (task_preempt_count(p) & PREEMPT_ACTIVE)
> +	if (task_preempt_count(p))
> 		state = TASK_RUNNING | TASK_STATE_MAX;
> #endif
> 
> @@ -85,7 +85,7 @@ static inline long __trace_sched_switch_state(struct
> task_struct *p)
> 	/*
> 	 * For all intents and purposes a preempted task is a running task.
> 	 */
> -	if (task_thread_info(p)->preempt_count & PREEMPT_ACTIVE)
> +	if (task_thread_info(p)->preempt_count)
> 		state = TASK_RUNNING | TASK_STATE_MAX;
> #endif
> 
> @@ -102,7 +102,7 @@ static inline long __trace_sched_switch_state(struct
> task_struct *p)
> 	/*
> 	 * For all intents and purposes a preempted task is a running task.
> 	 */
> -	if (task_thread_info(p)->preempt_count & PREEMPT_ACTIVE)
> +	if (task_thread_info(p)->preempt_count)
> 		state = TASK_RUNNING;
> #endif
> 
> diff --git a/instrumentation/events/mainline/sched.h
> b/instrumentation/events/mainline/sched.h
> index ea7a2035456d..790085190a4b 100644
> --- a/instrumentation/events/mainline/sched.h
> +++ b/instrumentation/events/mainline/sched.h
> @@ -100,7 +100,7 @@ static inline long __trace_sched_switch_state(struct
> task_struct *p)
> 	/*
> 	 * For all intents and purposes a preempted task is a running task.
> 	 */
> -	if (task_thread_info(p)->preempt_count & PREEMPT_ACTIVE)
> +	if (task_thread_info(p)->preempt_count)
> 		state = TASK_RUNNING | TASK_STATE_MAX;
> #endif
> 
> --
> 2.7.0
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
