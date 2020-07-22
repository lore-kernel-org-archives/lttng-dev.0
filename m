From: "Kim, Seongab via lttng-dev" <lttng-dev@lists.lttng.org>
Subject: difference of timestamp between babeltrace and python
 binding
Date: Wed, 22 Jul 2020 06:30:14 +0000
Message-ID: <15ed8d31ec16483db50928860aa4a4e5@HIMDWSMB06.ad.harman.com>
Reply-To: "Kim, Seongab" <Seongab.Kim@harman.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail1.bemta24.messagelabs.com (mail1.bemta24.messagelabs.com
 [67.219.250.5])
 by lists.lttng.org (Postfix) with ESMTP id 4BBR096l1Mz1dt5
 for <lttng-dev@lists.lttng.org>; Wed, 22 Jul 2020 02:49:29 -0400 (EDT)
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

Hi,

I found that the timestamps from babeltrace and python binding are different in nanoseconds level.

skim@d54030999178:~/ssd_work/traces$ python3 test.py ./trace/ | head -n 10
2019-12-12 13:45:40.098212096 (+0.000000 s): syscall_exit_ppoll
2019-12-12 13:45:40.098213608 (+0.000001 s): rcu_utilization
2019-12-12 13:45:40.098214632 (+0.000001 s): syscall_entry_ioctl
2019-12-12 13:45:40.098214888 (+0.000000 s): kmem_kfree
2019-12-12 13:45:40.098214144 (+0.000000 s): rcu_utilization
2019-12-12 13:45:40.098215168 (+0.000001 s): sched_stat_runtime
2019-12-12 13:45:40.098220776 (+0.000004 s): sched_switch
2019-12-12 13:45:40.098221312 (+0.000002 s): timer_hrtimer_cancel
2019-12-12 13:45:40.098221312 (+0.000000 s): kmem_kmalloc
2019-12-12 13:45:40.098223360 (+0.000002 s): kmem_kfree
Traceback (most recent call last):
  File "test.py", line 33, in <module>
    print(fmt.format(dt, ns_from_origin % 1e3, diff_s, msg.event.name))
BrokenPipeError: [Errno 32] Broken pipe
skim@d54030999178:~/ssd_work/traces$ babeltrace2 ./trace/ | head -n 10
[13:45:40.098211969] (+?.?????????) test-sys syscall_exit_ppoll: { cpu_id = 3 }, { ret = 0, nfds = 1, fds_length = 0, overflow = 0, fds =[ ] }
[13:45:40.098212481] (+0.000000512) test-sys rcu_utilization: { cpu_id = 5 }, { s = "Start context switch" }
[13:45:40.098213729] (+0.000001248) test-sys syscall_entry_ioctl: { cpu_id = 2 }, { fd = 24, cmd = 1075331408, arg = 547894601712 }
[13:45:40.098213953] (+0.000000224) test-sys kmem_kfree: { cpu_id = 3 }, { call_site = 0xFFFFFF800153B274, ptr = 0x0 }
[13:45:40.098214017] (+0.000000064) test-sys rcu_utilization: { cpu_id = 5 }, { s = "End context switch" }
[13:45:40.098215201] (+0.000001184) test-sys sched_stat_runtime: { cpu_id = 5 }, { comm = "Positioning", tid = 1056, runtime = 38048, vruntime = 2125241692 }
[13:45:40.098219681] (+0.000004480) test-sys sched_switch: { cpu_id = 5 }, { prev_comm = "Positioning", prev_tid = 1056, prev_prio = 15, prev_state = 1, next_comm = "Sensor", next_tid = 1061, next_prio = 15 }
[13:45:40.098221313] (+0.000001632) test-sys timer_hrtimer_cancel: { cpu_id = 5 }, { hrtimer = 0xFFFFFFC257807CD8 }
[13:45:40.098221409] (+0.000000096) test-sys kmem_kmalloc: { cpu_id = 0 }, { call_site = 0xFFFFFF80014A27EC, ptr = 0xFFFFFFC04EDFA400, bytes_req = 739, bytes_alloc = 1024, gfp_flags = 37748928 }
[13:45:40.098223361] (+0.000001952) test-sys kmem_kfree: { cpu_id = 5 }, { call_site = 0xFFFFFF8008164C58, ptr = 0x0 }

The difference is not consistent and Trace Compass shows the same timestamp with the babeltrace output, so I think something is wrong in my python code.
I just modified the example script from https://babeltrace.org/docs/v2.0/python/bt2/examples.html#get-an-event-s-time to show nanoseconds as below.

diff:

32,33c32,33
<         fmt = '{} (+{:.6f} s): {}'
<         print(fmt.format(dt, diff_s, msg.event.name))
---
>         fmt = '{}{:03.0f} (+{:.6f} s): {}'
>         print(fmt.format(dt, ns_from_origin % 1e3, diff_s, msg.event.name))

Full code:

import bt2
import sys
import datetime

# Create a trace collection message iterator from the first command-line
# argument.
msg_it = bt2.TraceCollectionMessageIterator(sys.argv[1])

# Last event's time (ns from origin).
last_event_ns_from_origin = None

# Iterate the trace messages.
for msg in msg_it:
    # `bt2._EventMessageConst` is the Python type of an event message.
    if type(msg) is bt2._EventMessageConst:
        # Get event message's default clock snapshot's ns from origin
        # value.
        ns_from_origin = msg.default_clock_snapshot.ns_from_origin

        # Compute the time difference since the last event message.
        diff_s = 0

        if last_event_ns_from_origin is not None:
            diff_s = (ns_from_origin - last_event_ns_from_origin) / 1e9

        # Create a `datetime.datetime` object from `ns_from_origin` for
        # presentation. Note that such an object is less accurate than
        # `ns_from_origin` as it holds microseconds, not nanoseconds.
        dt = datetime.datetime.fromtimestamp(ns_from_origin / 1e9)

        # Print line.
        fmt = '{}{:03.0f} (+{:.6f} s): {}'
        print(fmt.format(dt, ns_from_origin % 1e3, diff_s, msg.event.name))

        # Update last event's time.
        last_event_ns_from_origin = ns_from_origin
 
Could someone help what was wrong in the python code? Or is this a bug in ns_from_origin implementation?
I'm using below version.

skim@d54030999178:~/work/tmp$ babeltrace2 -V
Babeltrace 2.0.4 "Amqui"

Amqui (/_mkwi_/) is a town in eastern Qu_bec, Canada, at the base of the Gasp_ peninsula in Bas-Saint-Laurent. Located at the confluence
of the Humqui and Matap_dia Rivers, its proximity to woodlands makes it a great destination for outdoor activities such as camping, hiking,
and mountain biking.
skim@d54030999178:~/work/tmp$ apt list python3-bt2
Listing... Done
python3-bt2/bionic,now 2.0.x+stable+git4134+202007172102~ubuntu18.04.1 amd64 [installed]

Best regards,
Seongab Kim
