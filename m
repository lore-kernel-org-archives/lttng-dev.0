From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] sched instrumentation:	rename
	"pid" fields in sched_process_exec
Date: Sun, 25 Nov 2012 16:14:35 -0500
Message-ID: <20121125211435.GB13672__16648.9930045374$1353878107$gmane$org@Krystal>
References: <1353872354-19886-1-git-send-email-andrew_gabbasov@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TcjXA-0005pd-Ng
	for lttng-dev@lists.lttng.org; Sun, 25 Nov 2012 16:14:36 -0500
Content-Disposition: inline
In-Reply-To: <1353872354-19886-1-git-send-email-andrew_gabbasov@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Andrew Gabbasov (andrew_gabbasov@mentor.com) wrote:
> Rename "pid" to "tid" fields in new code, similarly to what was
> done earlier for all sched tracepoints.
> 
> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>

Merged, thanks!

Mathieu

> ---
>  instrumentation/events/lttng-module/sched.h |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/instrumentation/events/lttng-module/sched.h b/instrumentation/events/lttng-module/sched.h
> index ca46ed0..005f3d1 100644
> --- a/instrumentation/events/lttng-module/sched.h
> +++ b/instrumentation/events/lttng-module/sched.h
> @@ -326,18 +326,18 @@ TRACE_EVENT(sched_process_exec,
>  
>  	TP_STRUCT__entry(
>  		__string(	filename,	bprm->filename	)
> -		__field(	pid_t,		pid		)
> -		__field(	pid_t,		old_pid		)
> +		__field(	pid_t,		tid		)
> +		__field(	pid_t,		old_tid		)
>  	),
>  
>  	TP_fast_assign(
>  		tp_strcpy(filename, bprm->filename)
> -		tp_assign(pid, p->pid)
> -		tp_assign(old_pid, old_pid)
> +		tp_assign(tid, p->pid)
> +		tp_assign(old_tid, old_pid)
>  	),
>  
> -	TP_printk("filename=%s pid=%d old_pid=%d", __get_str(filename),
> -		  __entry->pid, __entry->old_pid)
> +	TP_printk("filename=%s tid=%d old_tid=%d", __get_str(filename),
> +		  __entry->tid, __entry->old_tid)
>  )
>  #endif
>  
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
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
