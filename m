From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: writeback
 instrumentation for 4.2 kernels
Date: Fri, 21 Aug 2015 16:31:44 +0000 (UTC)
Message-ID: <688252147.26762.1440174704317.JavaMail.zimbra__24515.5180492022$1440174777$gmane$org@efficios.com>
References: <1440123795-16823-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZSpES-0004SA-68
 for lttng-dev@lists.lttng.org; Fri, 21 Aug 2015 12:32:00 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 1C635340319
 for <lttng-dev@lists.lttng.org>; Fri, 21 Aug 2015 16:31:51 +0000 (UTC)
In-Reply-To: <1440123795-16823-1-git-send-email-mjeanson@efficios.com>
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

I picked up your patch into master and stable-2.7, but
did the following modif on top:

commit c7d89a6dc97f72013851ae94478a4c92e77e1f56
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Fri Aug 21 09:28:44 2015 -0700

    Cleanup: split bdi_dirty_ratelimit with ifdef into separate macros
    
    Makes the code easier to maintain in the long run.
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks!

Mathieu

----- On Aug 20, 2015, at 7:23 PM, Michael Jeanson mjeanson@efficios.com wrote:

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
> instrumentation/events/lttng-module/writeback.h | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
> 
> diff --git a/instrumentation/events/lttng-module/writeback.h
> b/instrumentation/events/lttng-module/writeback.h
> index 88b7aa4..b55d15e 100644
> --- a/instrumentation/events/lttng-module/writeback.h
> +++ b/instrumentation/events/lttng-module/writeback.h
> @@ -363,13 +363,27 @@ LTTNG_TRACEPOINT_EVENT_MAP(bdi_dirty_ratelimit,
> 
> 	TP_FIELDS(
> 		ctf_array_text(char, bdi, dev_name(bdi->dev), 32)
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,2,0))
> +		ctf_integer(unsigned long, write_bw, KBps(bdi->wb.write_bandwidth))
> +		ctf_integer(unsigned long, avg_write_bw, KBps(bdi->wb.avg_write_bandwidth))
> +#else
> 		ctf_integer(unsigned long, write_bw, KBps(bdi->write_bandwidth))
> 		ctf_integer(unsigned long, avg_write_bw, KBps(bdi->avg_write_bandwidth))
> +#endif
> 		ctf_integer(unsigned long, dirty_rate, KBps(dirty_rate))
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,2,0))
> +		ctf_integer(unsigned long, dirty_ratelimit, KBps(bdi->wb.dirty_ratelimit))
> +#else
> 		ctf_integer(unsigned long, dirty_ratelimit, KBps(bdi->dirty_ratelimit))
> +#endif
> 		ctf_integer(unsigned long, task_ratelimit, KBps(task_ratelimit))
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,2,0))
> +		ctf_integer(unsigned long, balanced_dirty_ratelimit,
> +					KBps(bdi->wb.balanced_dirty_ratelimit))
> +#else
> 		ctf_integer(unsigned long, balanced_dirty_ratelimit,
> 					KBps(bdi->balanced_dirty_ratelimit))
> +#endif
> 	)
> )
> 
> --
> 1.9.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
