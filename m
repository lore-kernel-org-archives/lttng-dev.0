From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules 2.6 1/2] Fix: make
	sched	instrumentation build for 4.3 kernel
Date: Mon, 26 Oct 2015 18:40:09 +0000 (UTC)
Message-ID: <827189911.130715.1445884809767.JavaMail.zimbra__9093.6089669869$1445884885$gmane$org@efficios.com>
References: <1445859632-20147-1-git-send-email-rabinv@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Zqmgz-0001G5-L8
 for lttng-dev@lists.lttng.org; Mon, 26 Oct 2015 14:40:26 -0400
In-Reply-To: <1445859632-20147-1-git-send-email-rabinv@axis.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Rabin Vincent <rabin.vincent@axis.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Rabin Vincent <rabinv@axis.com>
List-Id: lttng-dev@lists.lttng.org

Both patches merged into stable-2.6, thanks!

Mathieu

----- On Oct 26, 2015, at 7:40 AM, Rabin Vincent rabin.vincent@axis.com wrote:

> The backported patch "Fix: update sched wakeup instrumentation for 4.3
> kernel" (c93180196ea8) used a newer definition of
> LTTNG_TRACEPOINT_EVENT_CLASS which is not available in v2.6.
> 
> Signed-off-by: Rabin Vincent <rabinv@axis.com>
> ---
> instrumentation/events/lttng-module/sched.h |   24 +++++++++++++++++++-----
> 1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/instrumentation/events/lttng-module/sched.h
> b/instrumentation/events/lttng-module/sched.h
> index f6b65ae..d2e03f9 100644
> --- a/instrumentation/events/lttng-module/sched.h
> +++ b/instrumentation/events/lttng-module/sched.h
> @@ -142,12 +142,26 @@ LTTNG_TRACEPOINT_EVENT_CLASS(sched_wakeup_template,
> 
> 	TP_ARGS(p),
> 
> -	TP_FIELDS(
> -		ctf_array_text(char, comm, p->comm, TASK_COMM_LEN)
> -		ctf_integer(pid_t, tid, p->pid)
> -		ctf_integer(int, prio, p->prio)
> -		ctf_integer(int, target_cpu, task_cpu(p))
> +	TP_STRUCT__entry(
> +		__array_text(	char,	comm,	TASK_COMM_LEN	)
> +		__field(	pid_t,	tid			)
> +		__field(	int,	prio			)
> +		__field(	int,	target_cpu		)
> +	),
> +
> +	TP_fast_assign(
> +		tp_memcpy(comm, p->comm, TASK_COMM_LEN)
> +		tp_assign(tid, p->pid)
> +		tp_assign(prio, p->prio)
> +		tp_assign(target_cpu, task_cpu(p))
> 	)
> +	TP_perf_assign(
> +		__perf_task(p)
> +	),
> +
> +	TP_printk("comm=%s tid=%d prio=%d target_cpu=%03d",
> +		  __entry->comm, __entry->tid, __entry->prio,
> +		  __entry->target_cpu)
> )
> #else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0)) */
> LTTNG_TRACEPOINT_EVENT_CLASS(sched_wakeup_template,
> --
> 1.7.10.4
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
