From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: sched_process_exec
Date: Thu, 11 Oct 2012 10:58:55 -0400
Message-ID: <20121011145855.GA11726__30880.7755624459$1349967565$gmane$org@Krystal>
References: <50769060.7070309@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TMKDx-0008LP-B2
	for lttng-dev@lists.lttng.org; Thu, 11 Oct 2012 10:58:57 -0400
Content-Disposition: inline
In-Reply-To: <50769060.7070309@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Woegerer, Paul (Paul_Woegerer@mentor.com) wrote:
> Hi,
>
> Is there a reason why instrumentation/events/lttng-module/sched.h does  =

> not include TRACE_EVENT(sched_process_exec) ?
>
> The patch below adds the missing tracepoint definition (tested with  =

> kernel 3.4.6-2.10).

Hi Paul,

The only reason is because it appeared in a later kernel than the one
used when generating the lttng-modules trace event instrumentation.

A couple a details to fix before I can merge this patch though:

Please also update instrumentation/events/mainline/sched.h to add the
original mainline TRACE_EVENT, so we can keep the files in sync.

>
> diff --git a/instrumentation/events/lttng-module/sched.h  =

> b/instrumentation/events/lttng-module/sched.h
> index b68616e..ef791ac 100644
> --- a/instrumentation/events/lttng-module/sched.h
> +++ b/instrumentation/events/lttng-module/sched.h
> @@ -314,6 +314,32 @@ TRACE_EVENT(sched_process_fork,
>  )
>
>  /*
> + * Tracepoint for exec:
> + */
> +TRACE_EVENT(sched_process_exec,
> +
> +       TP_PROTO(struct task_struct *p, pid_t old_pid,
> +                struct linux_binprm *bprm),
> +
> +       TP_ARGS(p, old_pid, bprm),
> +
> +       TP_STRUCT__entry(
> +               __string(       filename,       bprm->filename  )
> +               __field(        pid_t,          pid             )
> +               __field(        pid_t,          old_pid         )
> +       ),
> +
> +       TP_fast_assign(
> +               tp_strcpy(filename, bprm->filename);

Please remove the ";" above.

> +               tp_assign(pid, p->pid)
> +               tp_assign(old_pid, old_pid)
> +       ),
> +
> +       TP_printk("filename=3D%s pid=3D%d old_pid=3D%d", __get_str(filena=
me),
> +                 __entry->pid, __entry->old_pid)
> +)
> +
> +/*
>   * XXX the below sched_stat tracepoints only apply to  =

> SCHED_OTHER/BATCH/IDLE

A newline has been added by your mail client, which causes the patch to
not apply correctly.

Hints on how to configure mail clients for sending patches can be looked
up in the Linux kernel tree, under Documentation/email-clients.txt

Thanks!

Mathieu

>   *     adding sched_stat support to SCHED_FIFO/RR would be welcome.
>   */
>
> -- =

> Paul Woegerer | SW Development Engineer
> http://go.mentor.com/sourceryanalyzer
>
> Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
> Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS
>
> Android is a trademark of Google Inc. Use of this trademark is subject to=
 Google Permissions.
> Linux is the registered trademark of Linus Torvalds in the U.S. and other=
 countries.
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- =

Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
