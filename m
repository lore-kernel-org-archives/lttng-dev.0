From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [lttng-dev] Clarification on SCHED_FIFO support
Date: Wed, 28 Jun 2017 15:05:26 -0400
Message-ID: <20170628150526.3f54c3f7@gandalf.local.home>
References: <CAJ+0M9Mh8DOmSD41iY2Ds46YfWn4q+-UQpdV08msv7k4PdSvSQ@mail.gmail.com>
        <57299872.4472.1498674158120.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57299872.4472.1498674158120.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Sukanya Sekar <ssekar@andrew.cmu.edu>, lttng-dev <lttng-dev@lists.lttng.org>, Julien Desfossez <jdesfossez@efficios.com>, linux-kernel <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, bristot <bristot@redhat.com>
List-Id: lttng-dev@lists.lttng.org

On Wed, 28 Jun 2017 18:22:38 +0000 (UTC)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> ----- On Jun 27, 2017, at 7:36 PM, Sukanya Sekar ssekar@andrew.cmu.edu wrote:
> 
> > Greetings!
> > We are exploring the LTTng Kernel Tracer (version 2.9) on Ubuntu 16.04. We are
> > particularly interested in real-time applications. As far as we explored, we
> > couldn't find support for SCHED_FIFO events. Also, we found a comment in the
> > source code (.../sched.h) indicating that the sched_stat support to
> > SCHED_FIFO/RR is yet to be added.  
> 
> > So we would like to confirm if SCHED_FIFO isn't supported in the latest version
> > of the tool.  
> 
> This is a problem in the upstream Linux kernel instrumentation.
> 
> I am assuming you refer to the sched_stat_template event class, used by 
> sched_stat_wait, sched_stat_sleep, sched_stat_iowait, and sched_stat_blocked 
> events. For those specific events, LTTng modules has the same limitation as 
> the Linux kernel scheduler instrumentation, where we find this comment 
> (include/trace/events/sched.h): 
> 
> /* 
> * XXX the below sched_stat tracepoints only apply to SCHED_OTHER/BATCH/IDLE 
> * adding sched_stat support to SCHED_FIFO/RR would be welcome. 
> */ 
> 
> This is not specific to LTTng. Ftrace, Perf, and SystemTAP have the same limitation 
> when using this scheduler tracepoint. 
> 
> In the past year, Julien Desfossez proposed enhancements to the Linux kernel 
> scheduler instrumentation [1], but there are still some disagreements on how
> to expose the new interfaces to user-space. 
> 
> Through a follow up IRC discussion we had with Peter Zijlstra and Steven Rostedt,
> we found out that they have opinions on how to evolve the kernel ABI exposed by
> Ftrace and Perf (keeping a single event for sched_switch, not having unneeded
> information in the event, exposing multiple numbered event format files format,
> format2, format3..., cumulative enabling semantic (enabling format3 enables format2 and 
> format), and so on), but the set of requirements is still unclear, and they have not 
> formulated an ABI proposal that those involved generally agree on. 
> 
> IMHO, part of the issue here is to mistake kernel ABIs for end user tooling interfaces. 
> If, for instance, trace-cmd exposes the new sched_switch_{rt,fail,dl} events as a single 
> synthetic sched_switch event from a user perspective, what do we really gain by
> complexifying the kernel ABI to still allow enabling a single event instead of 3 using
> "echo" from a shell ?
> 
> As soon as the Linux kernel adds the proper instrumentation to deal with those 
> scheduler policies, we will add support for it in LTTng (only for the newer kernels 
> that contain that instrumentation, of course). 
> 

You can propose settling this as a [TECH TOPIC] for kernel summit in
Prague.

-- Steve
