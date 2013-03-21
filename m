From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC-PATCH] Adding trap tracepoints definitions
Date: Thu, 21 Mar 2013 09:28:38 -0400
Message-ID: <20130321132837.GA20025__36761.2141221345$1363872566$gmane$org@Krystal>
References: <CADcCL0j+_N-6b4QvbLRnpC_DvpH3K8U9G2yQsb1ACzqqz3vQSA@mail.gmail.com>
	<1363829793-7579-1-git-send-email-fdeslaur@gmail.com>
	<20130321025144.GC3874@Krystal>
	<CADcCL0i3RSr+NCgvMb94S28r+aDfDyWyghgWWwcGeMyQqh8QOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UIfXr-0003YM-KW
	for lttng-dev@lists.lttng.org; Thu, 21 Mar 2013 09:28:39 -0400
Content-Disposition: inline
In-Reply-To: <CADcCL0i3RSr+NCgvMb94S28r+aDfDyWyghgWWwcGeMyQqh8QOA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Francis Deslauriers <fdeslaur@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Francis Deslauriers (fdeslaur@gmail.com) wrote:
> On Wed, Mar 20, 2013 at 10:51 PM, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> > Subject change:
> >
> > "Adding trap tracepoints definitions"
> >
> > -> "Add trap trace event definitions"
> >
> > ->
> >
> > Add trace trace event definitions. It will allow each architecture to
> > instrument their traps.
> 
> How about this?
> Add trap trace event definitions
> 
> Add trap entry and trap exit trace event definitions. It will allow each
> architecture to instrument their traps.
> 
> 
> This way we dont repeat the subject and it is more specific.

sounds good!

With these changes, please put my:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu

> 
> >
> > I'm being even more strict than usual as you notice given that this
> > patch is targeting lkml.
> >
> > Thanks,
> >
> > Mathieu
> >
> >>
> >> Signed-off-by: Francis Deslauriers <fdeslaur@gmail.com>
> >> ---
> >>  include/trace/events/trap.h |   47 +++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 47 insertions(+)
> >>  create mode 100644 include/trace/events/trap.h
> >>
> >> diff --git a/include/trace/events/trap.h b/include/trace/events/trap.h
> >> new file mode 100644
> >> index 0000000..171b9cf
> >> --- /dev/null
> >> +++ b/include/trace/events/trap.h
> >> @@ -0,0 +1,47 @@
> >> +#undef TRACE_SYSTEM
> >> +#define TRACE_SYSTEM trap
> >> +
> >> +#if !defined(_TRACE_TRAP_H) || defined(TRACE_HEADER_MULTI_READ)
> >> +#define _TRACE_TRAP_H
> >> +
> >> +#include <linux/tracepoint.h>
> >> +
> >> +TRACE_EVENT(trap_entry,
> >> +
> >> +     TP_PROTO(struct pt_regs *regs, long trap),
> >> +
> >> +     TP_ARGS(regs, trap),
> >> +
> >> +     TP_STRUCT__entry(
> >> +             __field(        long,           trap    )
> >> +             __field(        unsigned long,  ip      )
> >> +     ),
> >> +
> >> +     TP_fast_assign(
> >> +             __entry->trap   = trap;
> >> +             __entry->ip     = regs ? instruction_pointer(regs) : 0UL;
> >> +     ),
> >> +
> >> +     TP_printk("number=%ld ip=%lu", __entry->trap, __entry->ip)
> >> +);
> >> +
> >> +TRACE_EVENT(trap_exit,
> >> +
> >> +     TP_PROTO(long trap),
> >> +
> >> +     TP_ARGS(trap),
> >> +
> >> +     TP_STRUCT__entry(
> >> +             __field(        long,   trap    )
> >> +     ),
> >> +
> >> +     TP_fast_assign(
> >> +             __entry->trap   = trap;
> >> +     ),
> >> +
> >> +     TP_printk("number=%ld", __entry->trap)
> >> +);
> >> +
> >> +#endif /* _TRACE_TRAP_H */
> >> +/* This part must be outside protection */
> >> +#include <trace/define_trace.h>
> >> --
> >> 1.7.10.4
> >>
> >>
> >> _______________________________________________
> >> lttng-dev mailing list
> >> lttng-dev@lists.lttng.org
> >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
