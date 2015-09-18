From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [benchmark] lttng-ust with membarrier system call
Date: Fri, 18 Sep 2015 22:36:56 +0000 (UTC)
Message-ID: <577633406.11739.1442615816778.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lttng-dev <lttng-dev@lists.lttng.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Josh Triplett <josh@joshtriplett.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

Here is a benchmark update of LTTng-UST [1] tracing lots of
events [2] from a single core to a flight recorder ring buffer.
It has improved from 200ns per event to 150ns per event on
x86-64 [3] by enabling the membarrier [4, 5] system call. This
is a saving of 25 ns for each of the two memory barriers thus
removed from the tracer fast path.

The master branch of Userspace RCU [6] now uses the membarrier
system call for the urcu-bp flavor [7] whenever it is found in
the system headers and implemented by the running kernel. It
also assigns the system call number on x86 even if it is missing
from the system headers.

For reference purposes, make sure your system uses the TSC
clocksource [8] if you plan to do high-throughput tracing,
because using HPET makes lttng-ust performance crawl to a
mere 3000ns per event. Unfortunately, this situation can
trigger in virtual machines due to the clocksource watchdog
not expecting preemption from the host OS [9].

Feedback is welcome,

Thanks!

Mathieu

[1] http://lttng.org
[2] 100 million events, 32-bit integer payload.
[3] Intel(R) Xeon(R) CPU E5-2630 v3 @ 2.40GHz, in a KVM guest.
[4] https://lwn.net/Articles/369567/
[5] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=5b25b13ab08f616efd566347d809b4ece54570d1
[6] http://liburcu.org
[7] https://lwn.net/Articles/573424/
[8] cat /sys/devices/system/clocksource/clocksource0/current_clocksource
[9] http://lkml.iu.edu/hypermail/linux/kernel/1509.1/00379.html

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
