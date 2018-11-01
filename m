From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-modules 2.9.11, 2.10.8, 2.11.0-rc2 (Linux kernel
 tracer)
Date: Thu, 1 Nov 2018 18:56:22 -0400 (EDT)
Message-ID: <60988959.4070.1541112982406.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

This is a set of bugfix releases of the LTTng modules kernel tracer.
It covers the three currently active lttng-modules branches: the
2.9 and 2.10 stable branches, as well as the 2.11 branch in release
candidate cycle.

Those releases add support for kernel 4.19.

One important improvement is to prevent allocation of buffers larger
than the available memory, which can cause the OOM killer to trigger.
Even if the OOM killer end up having to trigger, the current OOM kill
target is set to the current thread while allocating buffers.

Enjoy!

Mathieu

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

Changelog:

2018-11-01 (National Men Make Dinner Day) LTTng modules 2.11.0-rc2
        * Fix: update kvm instrumentation for SLES12 SP2 LTSS >= 4.4.121-92.92
        * Fix: Add missing const to lttng_tracepoint_ptr_deref prototype
        * Fix: adapt to kernel relative references
        * Fix: implicit declarations caused by buffer size checks.
        * Prevent allocation of buffers if exceeding available memory
        * Fix: btrfs instrumentation namespacing
        * Fix: Convert rcu tracepointis to gp_seq (v4.19)
        * Fix: tracing: Centralize preemptirq tracepoints (4.19)
        * Fix: net: expose sk wmem in sock_exceed_buf_limit tracepoint (4.19)
        * Fix: access migrate_disable field directly
        * Fix: out of memory error handling

2018-11-01 (National Men Make Dinner Day) LTTng modules 2.10.8
        * Fix: update kvm instrumentation for SLES12 SP2 LTSS >= 4.4.121-92.92
        * Fix: Add missing const to lttng_tracepoint_ptr_deref prototype
        * Fix: adapt to kernel relative references
        * Fix: implicit declarations caused by buffer size checks.
        * Prevent allocation of buffers if exceeding available memory
        * Fix: Convert rcu tracepointis to gp_seq (v4.19)
        * Fix: net: expose sk wmem in sock_exceed_buf_limit tracepoint (4.19)
        * Fix: access migrate_disable field directly
        * Fix: out of memory error handling

2018-11-01 (National Men Make Dinner Day) LTTng modules 2.9.11
        * Fix: update kvm instrumentation for SLES12 SP2 LTSS >= 4.4.121-92.92
        * Fix: Add missing const to lttng_tracepoint_ptr_deref prototype
        * Fix: adapt to kernel relative references
        * Fix: implicit declarations caused by buffer size checks.
        * Prevent allocation of buffers if exceeding available memory
        * Fix: Convert rcu tracepointis to gp_seq (v4.19)
        * Fix: net: expose sk wmem in sock_exceed_buf_limit tracepoint (4.19)
        * Fix: access migrate_disable field directly
        * Fix: out of memory error handling


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
