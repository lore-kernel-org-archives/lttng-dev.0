From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.6.0 (Gaia)
Date: Mon, 26 Jan 2015 20:04:45 +0000 (UTC)
Message-ID: <1224618254.53158.1422302685749.JavaMail.zimbra@efficios.com>
References: <314636431.53126.1422302376219.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <314636431.53126.1422302376219.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lttng-dev@lists.lttng.org
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: lttng-dev@lists.lttng.org

We are now releasing the 2.6.0 LTTng modules Linux kernel tracer.

New & Noteworthy features in the LTTng Linux kernel tracer 2.6.0: 

- System call filtering! Fine-tune which system calls you want
  to trace or not,
- We now gather in/out parameters of system calls at entry and
  exit of the syscall. Please note that the system call event
  semantic (naming) have changed in this release. You may have
  to update your analysis if they depended on the old semantic,
- Trace NMI handlers, using the new NMI-safe clock monotonic
  available in kernels >= 3.17.

Changelog since LTTng modules 2.6.0-rc2:

2015-01-26 LTTng modules 2.6.0
        * Fix: missing parenthesis in offset_align_floor
        * Fix: implement time.h wrapper for FD_ISSET
        * Fix: update sched instrumentation for 3.19+ kernels
        * Fix: update rcu instrumentation for 3.19+ kernels
        * Fix: update scsi instrumentation for 3.19+ kernels
        * Fix: update module instrumentation for 3.19+ kernels
        * Fix: Add f_dentry wrapper for 3.19+ kernels
        * Fix: introduce lttng_get_unused_fd() wrapper for 3.19 kernels
        * Fix: lttng_this_cpu_ptr wrapper for kernel 3.19+
        * Fix: Update btrfs instrumentation for 3.18 Linux kernel
        * Fix compile error on kernel 3.0.101 with CONFIG_PERF_EVENTS
        * Conditional compilation introduced by lttng-modules commit

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
