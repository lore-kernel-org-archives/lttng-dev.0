From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: Understand userspace events in babeltrace output
Date: Fri, 19 Jul 2019 16:48:39 -0400
Message-ID: <20190719204839.GA11115__18.776864611425$1563569351$gmane$org@joraj-alpa>
References: <CABRndgykKYN-OxyDKDp1Nn4J0Ta4p54_kB5Wh9B5-AUSsdxLsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 45r3500J0Cz1Gck
 for <lttng-dev@lists.lttng.org>; Fri, 19 Jul 2019 16:48:51 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 0718926453D
 for <lttng-dev@lists.lttng.org>; Fri, 19 Jul 2019 16:48:45 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CABRndgykKYN-OxyDKDp1Nn4J0Ta4p54_kB5Wh9B5-AUSsdxLsg@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Zvi Vered <veredz72@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Zvi,

On Fri, Jul 19, 2019 at 05:28:48PM +0300, Zvi Vered wrote:
> Hello,
> 
> Using babeltrace I created a text trace.
> How can I understand it ?

Here lies the heavy work!

> 
> For example:
> I logged userspace events. One of my threads is called: RSPOn3

As far as I can tell sched_* are not userspace events they are "kernelspace"
events.

> I can see the following lines:
> 
> sched_switch: { cpu_id = 0 }, { prev_comm = "RSPOn3", prev_tid = 27307,
> prev_prio = -58, prev_state = 1, next_comm = "swapper/0", next_tid = 0,
> next_prio = 20 }
> 
> sched_wakeup: { cpu_id = 0 }, { comm = "RSPOn3", tid = 27307, prio = -58,
> success = 1, target_cpu = 0 }
> 
> sched_switch: { cpu_id = 0 }, { prev_comm = "swapper/0", prev_tid = 0,
> prev_prio = 20, prev_state = 0, next_comm = "RSPOn3", next_tid = 27307,
> next_prio = -58 }
> 
> sched_switch: { cpu_id = 0 }, { prev_comm = "RSPOn3", prev_tid = 27307,
> prev_prio = -58, prev_state = 1, next_comm = "swapper/0", next_tid = 0,
> next_prio = 20 }
> 
> How can I know the meaning of each field in each line ?

You will need to understand the kernel state transition of the scheduler. There
is multiple ways to go about it.

You could use TraceCompass[1][2] or lttng-analyses[3] to ease/complement your
learning experience a bit.

You could dive in the kernel source code and understand the control flow
surrounding each events and understand the significance of the events payload.

Another interesting place to look is the kernel trace documentation [4]. Some
subsystems have clear explanation regarding each tracepoint [5].

> 1. sched_switch, sched_wakeup
> 2. prev_comm
> 3. prev_state
> 4. next_comm
> 
> If a task is blocked (e.g waiting for TCP) and then runs for some time and
> then waits again, how this will be logged ?

Babeltrace is a trace converter, it does not perform any analysis. TraceCompass
and lttng-analyses might have analysis fitting your needs.

Cheers

[1] https://www.eclipse.org/tracecompass/
[2] https://archive.eclipse.org/tracecompass/doc/stable/org.eclipse.tracecompass.doc.user/LTTng-Kernel-Analysis.html#LTTng_Kernel_Analysis
[3] https://github.com/lttng/lttng-analyses
[4] https://www.kernel.org/doc/Documentation/trace/
[5] https://www.kernel.org/doc/Documentation/trace/events-kmem.txt

-- 
Jonathan Rajotte-Julien
EfficiOS
