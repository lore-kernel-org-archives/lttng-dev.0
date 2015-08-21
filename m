From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules 2.6] Fix: writeback
 instrumentation for 4.2 kernels
Date: Fri, 21 Aug 2015 20:27:08 +0000 (UTC)
Message-ID: <993511977.26954.1440188828447.JavaMail.zimbra__45703.7076507278$1440188914$gmane$org@efficios.com>
References: <1440183449-14065-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZSsuG-0005eM-N9
 for lttng-dev@lists.lttng.org; Fri, 21 Aug 2015 16:27:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9B0B83403F9
 for <lttng-dev@lists.lttng.org>; Fri, 21 Aug 2015 20:27:15 +0000 (UTC)
In-Reply-To: <1440183449-14065-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

merged, thanks!

Mathieu

----- On Aug 21, 2015, at 11:57 AM, Michael Jeanson mjeanson@efficios.com wrote:

> Bandwidth related fields were moved by this commit:
> 
> commit a88a341a73be4ef035ca26170c849f002797da27
> Author: Tejun Heo <tj@kernel.org>
> Date:   Fri, 22 May 2015 17:13:28 -0400
> 
>    writeback: move bandwidth related fields from backing_dev_info into
>    bdi_writeback
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> instrumentation/events/lttng-module/writeback.h | 51 +++++++++++++++++++++++++
> 1 file changed, 51 insertions(+)
> 
> diff --git a/instrumentation/events/lttng-module/writeback.h
> b/instrumentation/events/lttng-module/writeback.h
> index 7ea3f8a..dc88886 100644
> --- a/instrumentation/events/lttng-module/writeback.h
> +++ b/instrumentation/events/lttng-module/writeback.h
> @@ -523,6 +523,55 @@ LTTNG_TRACEPOINT_EVENT_MAP(global_dirty_state,
> 
> #define KBps(x)			((x) << (PAGE_SHIFT - 10))
> 
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,2,0))
> +
> +LTTNG_TRACEPOINT_EVENT_MAP(bdi_dirty_ratelimit,
> +
> +	writeback_bdi_dirty_ratelimit,
> +
> +	TP_PROTO(struct backing_dev_info *bdi,
> +		 unsigned long dirty_rate,
> +		 unsigned long task_ratelimit),
> +
> +	TP_ARGS(bdi, dirty_rate, task_ratelimit),
> +
> +	TP_STRUCT__entry(
> +		__array(char,		bdi, 32)
> +		__field(unsigned long,	write_bw)
> +		__field(unsigned long,	avg_write_bw)
> +		__field(unsigned long,	dirty_rate)
> +		__field(unsigned long,	dirty_ratelimit)
> +		__field(unsigned long,	task_ratelimit)
> +		__field(unsigned long,	balanced_dirty_ratelimit)
> +	),
> +
> +	TP_fast_assign(
> +		tp_memcpy(bdi, dev_name(bdi->dev), 32)
> +		tp_assign(write_bw, KBps(bdi->wb.write_bandwidth))
> +		tp_assign(avg_write_bw, KBps(bdi->wb.avg_write_bandwidth))
> +		tp_assign(dirty_rate, KBps(dirty_rate))
> +		tp_assign(dirty_ratelimit, KBps(bdi->wb.dirty_ratelimit))
> +		tp_assign(task_ratelimit, KBps(task_ratelimit))
> +		tp_assign(balanced_dirty_ratelimit,
> +					KBps(bdi->wb.balanced_dirty_ratelimit))
> +	),
> +
> +	TP_printk("bdi %s: "
> +		  "write_bw=%lu awrite_bw=%lu dirty_rate=%lu "
> +		  "dirty_ratelimit=%lu task_ratelimit=%lu "
> +		  "balanced_dirty_ratelimit=%lu",
> +		  __entry->bdi,
> +		  __entry->write_bw,		/* write bandwidth */
> +		  __entry->avg_write_bw,	/* avg write bandwidth */
> +		  __entry->dirty_rate,		/* bdi dirty rate */
> +		  __entry->dirty_ratelimit,	/* base ratelimit */
> +		  __entry->task_ratelimit, /* ratelimit with position control */
> +		  __entry->balanced_dirty_ratelimit /* the balanced ratelimit */
> +	)
> +)
> +
> +#else
> +
> LTTNG_TRACEPOINT_EVENT_MAP(bdi_dirty_ratelimit,
> 
> 	writeback_bdi_dirty_ratelimit,
> @@ -568,6 +617,8 @@ LTTNG_TRACEPOINT_EVENT_MAP(bdi_dirty_ratelimit,
> 	)
> )
> 
> +#endif
> +
> LTTNG_TRACEPOINT_EVENT_MAP(balance_dirty_pages,
> 
> 	writeback_balance_dirty_pages,
> --
> 1.9.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
