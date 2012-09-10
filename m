From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.1.0-rc1
Date: Mon, 10 Sep 2012 17:38:33 -0400
Message-ID: <20120910213833.GB22400__17332.2463561364$1347313145$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TBBgg-0001A6-Vi
	for lttng-dev@lists.lttng.org; Mon, 10 Sep 2012 17:38:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id BE41714042D
	for <lttng-dev@lists.lttng.org>; Mon, 10 Sep 2012 17:38:34 -0400 (EDT)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id O0w+4jx6TYMn for <lttng-dev@lists.lttng.org>;
	Mon, 10 Sep 2012 17:38:33 -0400 (EDT)
Content-Disposition: inline
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

The LTTng modules provide Linux kernel tracing capability to the LTTng
2.0 tracer toolset.

The main change in this 2.1 cycle for lttng-modules is the newly
introduced support for kernels 2.6.32 to 2.6.37, along with MIPS
support, and added hostname context.

(note: kernels 2.6.32 to 2.6.34 require up to 3 patches provided in
linux-patches/ within the lttng-modules tree)

Changelog:
2012-09-10 LTTng modules 2.1.0-rc1
	* fix timestamps on architectures without CONFIG_KTIME_SCALAR
	* Support for linux kernels 2.6.32 through 2.6.37
	* Document limitation of vppid and ppid context wrt eventual RCU instrumentation
	* Cleanup: no need to hold RCU read-side lock when reading current nsproxy
	* Add env hostname information
	* Fix: lttng_statedump_process_state for each PID NS has infinite loop
	* lttng_statedump_process_state for each PID NS
	* Support the hostname context
	* Fix: statedump namespaced pid, tid and ppid
	* Fix: statedump: disable vm maps enumeration
	* Fix: ensure userspace accesses are done with _inatomic
	* Fix: vppid context should test for current nsproxy
	* Add MIPS system call support
	* Change mode of lttng-syscalls-generate-headers.sh to 755
	* cleanup: fix typo in syscall instrumentation header
	* Cleanup: remove trailing whitespace in README
	* trace event: introduce TP_MODULE_NOAUTOLOAD and TP_MODULE_NOINIT
	* LTTng: probe-statedump: add #include <linux/sched.h>
	* fix: signal_generate event should print utf8 for comm field
	* Makes write operation a parameter for tp_memcpy macro
	* Add coding style document
	* Update instrumentation/events README file
	* Add makefile target for preprocessor
	* Fix: free_event_id check should compare unsigned int with -1U
	* Use unsigned long type for events discarded counter
	* Fix: update signal instrumentation for 3.4 kernel
	* LTTng Modules ARM syscall instrumentation
	* Fix: generate header missing echo -e for escape chars
	* Fix: add missing uaccess.h include (for ARM)
	* README: Document that CONFIG_MODULES is required
	* Fix: README typo
	* Fix: document required and optional kernel config options in README

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
