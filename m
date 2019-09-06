From: Kjeld Flarup via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Kernel tracer not available with lttng compiled in
Date: Fri, 6 Sep 2019 07:30:54 +0000
Message-ID: <086e7eb8fb4a40e786d3cd0bebe9ca3c__49275.8830006764$1567755073$gmane$org@deif.com>
References: <94d50c14661146d4b8dcf57123c12c8b@deif.com>,
 <20190905134826.GA15223@joraj-alpa>
Reply-To: Kjeld Flarup <kfa@deif.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.deif.com (mail.deif.com [87.54.42.111])
 by lists.lttng.org (Postfix) with ESMTPS id 46Pq3h6Qgjzrdy
 for <lttng-dev@lists.lttng.org>; Fri,  6 Sep 2019 03:30:56 -0400 (EDT)
In-Reply-To: <20190905134826.GA15223@joraj-alpa>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Thanks for Your reply

I didn't notice the buildin support in the Readme. I think this will bring me further.


Regards
Kjeld Flarup
R&D Platform Software



________________________________________
From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Sent: Thursday, September 5, 2019 3:48:26 PM
To: Kjeld Flarup
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] Kernel tracer not available with lttng compiled in

Hi,

We will need more information.

What version of lttng are we speaking of here?

What kernel version/tree?

Exactly how did you build your kernel with lttng-modules built-in?

Did you follow this?:

  https://github.com/lttng/lttng-modules/blob/master/README.md#kernel-built-in-support

Cheers

On Thu, Sep 05, 2019 at 12:23:40PM +0000, Kjeld Flarup via lttng-dev wrote:
> Hello
>
> I'm trying to get lttng working on an Power PC board
>
>
> ~ # lttng create my-kernel-session --output=/tmp/my-kernel-trace
> Spawning a session daemon
> Session my-kernel-session created.
> Traces will be written in /tmp/my-kernel-trace
> ~ # lttng list --kernel
> Error: Unable to list kernel events: Kernel tracer not available
> Error: Command error
>
> Now ALL that I can find when googling this error is that the kernel modules is not loaded.
> However I'm not using modules, but compile everything in.
>
> Here is a small extract of what is enabled in my kernel. I have attached the full /proc/config.gz
> Am I missing something?
>
> CONFIG_NOP_TRACER=y
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_TRACER_MAX_TRACE=y
> CONFIG_CONTEXT_SWITCH_TRACER=y
> CONFIG_GENERIC_TRACER=y
> CONFIG_FUNCTION_TRACER=y
> CONFIG_FUNCTION_GRAPH_TRACER=y
> CONFIG_IRQSOFF_TRACER=y
> CONFIG_PREEMPT_TRACER=y
> CONFIG_SCHED_TRACER=y
> # CONFIG_HWLAT_TRACER is not set
> CONFIG_TRACER_SNAPSHOT=y
> CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
> # CONFIG_STACK_TRACER is not set
>
> CONFIG_HAVE_KPROBES_ON_FTRACE=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_FTRACE=y
> CONFIG_FTRACE_SYSCALLS=y
> CONFIG_DYNAMIC_FTRACE=y
> CONFIG_FTRACE_MCOUNT_RECORD=y
> # CONFIG_FTRACE_STARTUP_TEST is not set
>
>
> CONFIG_EVENT_TRACING=y
> CONFIG_PERF_EVENTS=y
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
>
> CONFIG_KRETPROBES=y
>
> CONFIG_HIGH_RES_TIMERS=y
> CONFIG_TRACEPOINTS=y
> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> # CONFIG_TRACE_SINK is not set
> CONFIG_TRACE_IRQFLAGS=y
> CONFIG_TRACE_CLOCK=y
> CONFIG_TRACE_PREEMPT_TOGGLE=y
> CONFIG_TRACER_SNAPSHOT=y
> CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
> # CONFIG_TRACEPOINT_BENCHMARK is not set
> # CONFIG_TRACE_EVAL_MAP_FILE is not set
> CONFIG_KALLSYMS=y
> # CONFIG_KALLSYMS_ALL is not set
> CONFIG_KALLSYMS_BASE_RELATIVE=y
>
>
>
> Regards
> Kjeld Flarup
> DEIF A/S, R&D Platform Software
>
>


> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--
Jonathan Rajotte-Julien
EfficiOS
