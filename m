From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.3.0
Date: Tue, 3 Sep 2013 21:30:37 -0400
Message-ID: <20130904013037.GB25652@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: lttng-dev@lists.lttng.org
Cc: lwn@lwn.net, linux-kernel@vger.kernel.org
List-Id: lttng-dev@lists.lttng.org

The LTTng modules provide Linux kernel tracing capability to the LTTng
2.x tracer toolset.

Noteworthy changes:
- Support for Linux kernels up to (including) 3.11,
- Flight recorder (snapshot) support,
- Updated ARM, x86 system call instrumentation,
- Add 32-bit PowerPC system call instrumentation.

Changelog since 2.3.0-rc2:
2013-09-03 LTTng modules 2.3.0
        * Fix: metadata stream should not reference session
        * Fix: btrfs: support 3.11 Linux kernel
        * statedump: remove KERN_DEBUG messages
        * Fix: ext4: add missing tracepoints for 3.11 kernel
        * Fix: ext4: Linux 3.11 support
        * Fix: ext3: 3.11 Linux support
        * Fix: statedump nsproxy 3.11 Linux support

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
