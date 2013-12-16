From: Ming Liu <ming.liu@windriver.com>
Subject: [PATCH] x86-trace-clock/preempt_rt: move async_tsc_lock
	out of atomic condition
Date: Mon, 16 Dec 2013 14:23:46 +0800
Message-ID: <1387175026-22197-1-git-send-email-ming.liu__44360.1412502632$1387175077$gmane$org@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail1.windriver.com ([147.11.146.13])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Ming.Liu@windriver.com>) id 1VsRat-0001w7-3d
	for lttng-dev@lists.lttng.org; Mon, 16 Dec 2013 01:23:56 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id rBG6Nnsu011244
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <lttng-dev@lists.lttng.org>; Sun, 15 Dec 2013 22:23:49 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The following call trace is observed in preempt_rt:
------
BUG: sleeping function called from invalid context at
/opt/platforms/atom_prj/build/linux/kernel/rtmutex.c:707
pcnt: 0 0 in_atomic(): 0, irqs_disabled(): 1, pid: 5928, name: kstop/1
Pid: 5928, comm: kstop/1 Tainted: P           2.6.38.6-rt_preempt_rt #1
Call Trace:
[<c102d101>] __might_sleep+0xe1/0x100
[<c15a6cb7>] rt_spin_lock+0x27/0x70
[<c159e4e7>] hotcpu_callback+0x13/0x102
[<c1060155>] notifier_call_chain+0x35/0x70
[<c106023a>] raw_notifier_call_chain+0x1a/0x20
[<c15969ff>] take_cpu_down+0x2f/0x60
[<c107ef25>] stop_cpu+0x95/0xd0
[<c1056550>] worker_thread+0x110/0x230
[<c15a4f9b>] ? __schedule+0x22b/0x6c0
[<c106ccd2>] ? rt_mutex_adjust_prio+0x32/0x50
[<c107ee90>] ? stop_cpu+0x0/0xd0
[<c105aa30>] ? autoremove_wake_function+0x0/0x40
[<c1056440>] ? worker_thread+0x0/0x230
[<c105a71c>] kthread+0x6c/0x80
[<c105a6b0>] ? kthread+0x0/0x80
[<c1003336>] kernel_thread_helper+0x6/0x30
CPU 1 is now offline
------

To track it as follows:
------
stop_cpu()
  local_irq_disable()
  take_cpu_down()
    raw_notifier_call_chain() <-- CPU_DYING
          |
          + hotcpu_callback()
            {
                spin_lock(&async_tsc_lock);
                ......
                spin_unlock(&async_tsc_lock);
            }
------

Since spin_lock is actually rt_spin_lock under preempt_rt, a call trace
will be issued when it's trying to hold async_tsc_lock when interrupts
are disabled.

The fix is to move async_tsc_lock into switch cases, allow the CPU_DYING
handling fall through without holding the spin lock.

Signed-off-by: Ming Liu <ming.liu@windriver.com>
---
 arch/x86/kernel/trace-clock.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/trace-clock.c b/arch/x86/kernel/trace-clock.c
index 47539e2..a7a51ce 100644
--- a/arch/x86/kernel/trace-clock.c
+++ b/arch/x86/kernel/trace-clock.c
@@ -145,7 +145,6 @@ static int __cpuinit hotcpu_callback(struct notifier_block *nb,
 	unsigned int hotcpu = (unsigned long)hcpu;
 	int cpu;
 
-	spin_lock(&async_tsc_lock);
 	switch (action) {
 	case CPU_UP_PREPARE:
 	case CPU_UP_PREPARE_FROZEN:
@@ -159,6 +158,7 @@ static int __cpuinit hotcpu_callback(struct notifier_block *nb,
 		 * the CPU_ONLINE notification. It's just there to give a
 		 * maximum bound to the TSC error.
 		 */
+		spin_lock(&async_tsc_lock);
 		if (async_tsc_refcount && !trace_clock_is_sync()) {
 			if (!async_tsc_enabled) {
 				async_tsc_enabled = 1;
@@ -168,12 +168,15 @@ static int __cpuinit hotcpu_callback(struct notifier_block *nb,
 				enable_trace_clock(hotcpu);
 			}
 		}
+		spin_unlock(&async_tsc_lock);
 		break;
 #ifdef CONFIG_HOTPLUG_CPU
 	case CPU_UP_CANCELED:
 	case CPU_UP_CANCELED_FROZEN:
+		spin_lock(&async_tsc_lock);
 		if (!async_tsc_refcount && num_online_cpus() == 1)
 			set_trace_clock_is_sync(1);
+		spin_unlock(&async_tsc_lock);
 		break;
 	case CPU_DEAD:
 	case CPU_DEAD_FROZEN:
@@ -182,14 +185,15 @@ static int __cpuinit hotcpu_callback(struct notifier_block *nb,
 		 * active even if we go back to a synchronized state (1 CPU)
 		 * because the CPU left could be the one lagging behind.
 		 */
+		spin_lock(&async_tsc_lock);
 		if (async_tsc_refcount && async_tsc_enabled)
 			disable_trace_clock(hotcpu);
 		if (!async_tsc_refcount && num_online_cpus() == 1)
 			set_trace_clock_is_sync(1);
+		spin_unlock(&async_tsc_lock);
 		break;
 #endif /* CONFIG_HOTPLUG_CPU */
 	}
-	spin_unlock(&async_tsc_lock);
 
 	return NOTIFY_OK;
 }
-- 
1.8.4.1
