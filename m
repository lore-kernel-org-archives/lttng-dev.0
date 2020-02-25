From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-modules 2.12.0-rc2, 2.11.2, 2.10.14 (Linux kernel
 tracer)
Date: Tue, 25 Feb 2020 15:38:45 -0500 (EST)
Message-ID: <1487536566.7003.1582663125006.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
Sender: linux-trace-users-owner@vger.kernel.org
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org, lwn@lwn.net, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

This release announcement covers all actively maintained branches of the
LTTng-modules Linux kernel tracer, namely:

- LTTng-modules 2.10.14 and 2.11.2 (stable branches),
- LTTng-modules 2.12.0-rc2 (branch currently in release candidate cycle).

The LTTng modules provide Linux kernel tracing capability to the LTTng
tracer toolset.

* New and noteworthy in these releases:

- Support for kernel 5.6 (currently at 5.6-rc3). It features changes in the
  tracepoint instrumentation, and changes in the timekeeping area in
  preparation for y2038. The plan here to handle timekeeping changes
  and keep backward compatibility is to add forward declarations of
  deprecated types locally in lttng-modules for the stable branches.

  For the master branch and future 2.13+ releases,  we plan to introduce a
  type compatibility layer within lttng-modules with typedefs mapping to the
  new types when building against recent kernels, and provide backward
  compatible typedefs when building against older kernels. Currently,
  lttng-modules builds against all vanilla and most distribution Linux
  kernels from v3.0 onwards.

- Fix NULL pointer dereference race in the lttng-statedump module. The
  return value of task_active_pid_ns() should be checked for NULL to handle
  tasks which have exited but were not waited-for yet, which are thus in a
  "dead" state. The statedump triggers at trace start and when the command
  "lttng regenerate statedump" is issued.

Thanks,

Mathieu


Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
