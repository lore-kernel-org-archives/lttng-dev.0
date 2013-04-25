From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Changed scheduling when using lttng
Date: Thu, 25 Apr 2013 11:12:13 -0400
Message-ID: <20130425151213.GC7970__49901.7670321793$1366902765$gmane$org@Krystal>
References: <CA+xJJ18hL16P3gvowveWVfg+ZNh=cjEFOoPisznU0y28YfCdbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UVNqL-0000yj-LQ
	for lttng-dev@lists.lttng.org; Thu, 25 Apr 2013 11:12:18 -0400
Content-Disposition: inline
In-Reply-To: <CA+xJJ18hL16P3gvowveWVfg+ZNh=cjEFOoPisznU0y28YfCdbw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mats Liljegren <liljegren.mats2@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Mats,

The ring buffer uses the standard "timers" in the kernel to flush the
buffers periodically, which prevents your kernel from going into nohz.
Originally, when implemented as a patch on the Linux kernel, the ring
buffer design had hooks in the nohz kernel events to disable this timer
when going to nohz. Now, given LTTng is a kernel module, it cannot
modify the kernel code, and no callback mechanism exists for nohz.

There are two ways to work around this issue that does not require
modifying the Linux kernel:

1) Implement RING_BUFFER_WAKEUP_BY_WRITER within lttng-modules ring
   buffer.

  it should become used by default if the following is specified at
  channel creation:

  lttng enable-channel mychan -k --read-timer 0

  It can be an issue if you want to trace page fault, and instrument
  code sensitive to lock usage (when using WAKEUP_BY_WRITER, the tracer
  is not lock-free anymore). It's the main reason why I have not
  implemented this mode yet: making sure the tracer never breaks the
  kernel in this mode is trickier.

2) use deferrable timers. It's a hack, but it should allow our timers to
   be inhibited when the cpus go in nohz.

Sorry, low-impact on nohz has not really been on our sponsor's priority
lists so far.

Thanks,

Mathieu

* Mats Liljegren (liljegren.mats2@gmail.com) wrote:
> I'm doing a benchmark application which intends to benchmark the
> effects of using the full nohz mode. I initially tried ftrace, but it
> had too much overhead, so I tried lttng instead. While I'm happy with
> the overhead in lttng, it has another problem: My application never
> executes in full nohz mode.
> 
> In my investigation of why, I came up with the following two logs,
> first using ftrace with sched_switch event enabled:
> 
>        testapp-2048  [001] d... 50744.932281: sched_switch:
> prev_comm=testapp prev_pid=2048 prev_prio=139 prev_state=R ==>
> next_comm=kworker/1:1 next_pid=25 next_prio=120
>      kworker/1:1-25    [001] d... 50744.932312: sched_switch:
> prev_comm=kworker/1:1 prev_pid=25 prev_prio=120 prev_state=S ==>
> next_comm=ksoftirqd/1 next_pid=14 next_prio=120
> >>>  ksoftirqd/1-14    [001] d... 50744.932343: sched_switch: prev_comm=ksoftirqd/1 prev_pid=14 prev_prio=120 prev_state=S ==> next_comm=testapp next_pid=2048 next_prio=139
> <<<    testapp-2048  [001] d... 50747.789948: sched_switch:
> prev_comm=testapp prev_pid=2048 prev_prio=139 prev_state=D ==>
> next_comm=kworker/1:1 next_pid=25 next_prio=120
>      kworker/1:1-25    [001] d... 50747.789978: sched_switch:
> prev_comm=kworker/1:1 prev_pid=25 prev_prio=120 prev_state=S ==>
> next_comm=testapp next_pid=2048 next_prio=139
>        testapp-2048  [001] d... 50747.799103: sched_switch:
> prev_comm=testapp prev_pid=2048 prev_prio=139 prev_state=R ==>
> next_comm=kworker/1:1 next_pid=25 next_prio=120
> 
> The line ">>>" is when the testapp is starting its benchmarking, and
> "<<<" when it has finished. As can be seen, the execution is done
> uninterrupted by any schedule switched for the whole 30s period.
> 
> The second test was with lttng with sched_switch tracepoint enabled:
> 
> [07:20:04.813293457] (+0.000823975) pandaboard sched_switch: { cpu_id
> = 1 }, { prev_comm = "swapper/1", prev_tid = 0, prev_prio = 20,
> prev_state = 0, next_comm = "testapp", next_tid = 3027, next_prio = 39
> }
> [07:20:05.062438964] (+0.159973144) pandaboard sched_switch: { cpu_id
> = 1 }, { prev_comm = "testapp", prev_tid = 3027, prev_prio = 39,
> prev_state = 0, next_comm = "ksoftirqd/1", next_tid = 14, next_prio =
> 20 }
> [07:20:05.062469482] (+0.000030518) pandaboard sched_switch: { cpu_id
> = 1 }, { prev_comm = "ksoftirqd/1", prev_tid = 14, prev_prio = 20,
> prev_state = 1, next_comm = "testapp", next_tid = 3027, next_prio = 39
> }
> [07:20:05.312438964] (+0.249969482) pandaboard sched_switch: { cpu_id
> = 1 }, { prev_comm = "testapp", prev_tid = 3027, prev_prio = 39,
> prev_state = 0, next_comm = "ksoftirqd/1", next_tid = 14, next_prio =
> 20 }
> [07:20:05.312438964] (+0.000000000) pandaboard sched_switch: { cpu_id
> = 1 }, { prev_comm = "ksoftirqd/1", prev_tid = 14, prev_prio = 20,
> prev_state = 1, next_comm = "testapp", next_tid = 3027, next_prio = 39
> }
> [07:20:05.682434082] (+0.369995118) pandaboard sched_switch: { cpu_id
> = 1 }, { prev_comm = "testapp", prev_tid = 3027, prev_prio = 39,
> prev_state = 0, next_comm = "kworker/1:1", next_tid = 25, next_prio =
> 20 }
> [07:20:05.682464599] (+0.000030517) pandaboard sched_switch: { cpu_id
> = 1 }, { prev_comm = "kworker/1:1", prev_tid = 25, prev_prio = 20,
> prev_state = 1, next_comm = "testapp", next_tid = 3027, next_prio = 39
> }
> [07:20:06.282440185] (+0.569976807) pandaboard sched_switch: { cpu_id
> = 1 }, { prev_comm = "testapp", prev_tid = 3027, prev_prio = 39,
> prev_state = 0, next_comm = "ksoftirqd/1", next_tid = 14, next_prio =
> 20 }
> [07:20:06.282440185] (+0.000000000) pandaboard sched_switch: { cpu_id
> = 1 }, { prev_comm = "ksoftirqd/1", prev_tid = 14, prev_prio = 20,
> prev_state = 1, next_comm = "testapp", next_tid = 3027, next_prio = 39
> }
> [07:20:06.682434082] (+0.399993897) pandaboard sched_switch: { cpu_id
> = 1 }, { prev_comm = "testapp", prev_tid = 3027, prev_prio = 39,
> prev_state = 0, next_comm = "kworker/1:1", next_tid = 25, next_prio =
> 20 }
> [07:20:06.682464599] (+0.000030517) pandaboard sched_switch: { cpu_id
> = 1 }, { prev_comm = "kworker/1:1", prev_tid = 25, prev_prio = 20,
> prev_state = 1, next_comm = "testapp", next_tid = 3027, next_prio = 39
> }
> 
> and so on...
> 
> As can be seen, the scheduling is changed when lttng runs. It seems
> like lttng makes the non-migratable kthreads kworker/1:1 and
> ksoftirq/1 busy which totally destroyes measurements in my application
> since nohz mode is never entered.
> 
> Is there a way around this? What is causing this behavior?
> 
> /Mats
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
