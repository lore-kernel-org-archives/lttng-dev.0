From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.7.6 and 2.8.2 (Linux tracer timekeeping
 work-around)
Date: Fri, 7 Oct 2016 20:35:16 +0000 (UTC)
Message-ID: <1718003007.50531.1475872516861.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: lttng-dev@lists.lttng.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, stable <stable@vger.kernel.org>, Brendan Gregg <bgregg@netflix.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>
List-Id: lttng-dev@lists.lttng.org

Hi,

LTTng modules 2.7.6 and 2.8.2 are bugfix releases which
work around an upstream Linux kernel timekeeping bug. This
bug has been introduced in the 4.8 kernel, and backported
into Linux stable branches. It affects LTTng, perf,
ftrace with "mono" clock source, and eBPF.

All LTTng-modules 2.7.x and 2.8.x users with Linux kernels
4.8, 4.7.4+, 4.4.20+, and 4.1.32+ should upgrade.

The effect of this issue is that timestamps sampled in the
trace are not reliable, and may be off by up to nearly a
second, which makes correlation between cores, and between
kernel and user-space tracing impossible.

The upstream kernel fix is being discussed [1], but it has
not been merged yet.

Linux commit 27727df240c7 ("Avoid taking lock in NMI path with
CONFIG_DEBUG_TIMEKEEPING"), changed the logic to open-code
the timekeeping_get_ns() function, but forgot to include
the unit conversion from cycles to nanoseconds, breaking the
function's output, which impacts LTTng.
    
We expect that the upstream fix will reach the master and stable
branches timely before the next releases, so we use 4.8.1, 4.7.7,
4.4.24, and 4.1.34 as upper bounds (exclusive).
    
Fall-back to the non-NMI-safe trace clock for those kernel versions.
We simply discard events from NMI context with a in_nmi() check,
as we did before Linux 3.17.

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

Changelog:

2016-10-07 (National Frappé Day) LTTng modules 2.8.2
        * Fix: show warning for broken clock work-around
        * Fix: work-around upstream Linux timekeeping bug

2016-10-07 (National Frappé Day) LTTng modules 2.7.6
        * Fix: show warning for broken clock work-around
        * Fix: work-around upstream Linux timekeeping bug
        * Documentation: lttng-modules 2.7 supports Linux < 4.8

[1] http://lkml.kernel.org/r/1475636148-26539-1-git-send-email-john.stultz@linaro.org

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
