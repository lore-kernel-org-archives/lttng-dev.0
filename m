From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-modules 2.8.4 and 2.9.1 (Linux kernel tracer)
Date: Fri, 17 Feb 2017 17:23:54 +0000 (UTC)
Message-ID: <2014569414.67331.1487352234782.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lttng-dev <lttng-dev@lists.lttng.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, diamon-discuss@lists.linuxfoundation.org
List-Id: lttng-dev@lists.lttng.org

The LTTng modules provide Linux kernel tracing capability to the LTTng
tracer toolset.

Those are stable branch releases for stable-2.8 and stable-2.9 lttng-modules
branches. Version 2.9.1 adds support for the 4.10 version of the linux kernel
release candidates. The rest are various bugfixes.

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

Changelog:
2017-02-17 (National Cabbage Day) LTTng modules 2.9.1
        * Fix: nmi-safe clock on 32-bit systems
        * Fix: only include linux/cpuhotplug.h for kernels >= 4.10
        * Fix: 4.10 hotplug adaptation backward compat
        * Adapt lttng-modules to Linux 4.10 cpu hotplug state machine
        * Fix: 4.10 btrfs instrumentation update backward compat
        * Update btrfs instrumentation for 4.10 kernel
        * btrfs instrumentation: update to 4.10 kernel
        * timer instrumentation: adapt to ktime_t without union
        * Fix: asoc instrumentation for RHEL 7.3
        * Fix: SCSI instrumentation for SLES12 SP2
        * Add SUSE Linux Enterprise kernel version tests

2017-02-17 (National Cabbage Day) LTTng modules 2.8.4
        * Fix: nmi-safe clock on 32-bit systems
        * Fix: asoc instrumentation for RHEL 7.3
        * Fix: SCSI instrumentation for SLES12 SP2
        * Add SUSE Linux Enterprise kernel version tests
        * Fix: preemptible and migratable context error handling

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
