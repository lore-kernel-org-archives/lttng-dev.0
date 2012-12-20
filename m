From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.1.0
Date: Thu, 20 Dec 2012 13:51:11 -0500
Message-ID: <20121220185111.GB28486__22547.3767998212$1356029516$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TllD7-0001oo-0R
	for lttng-dev@lists.lttng.org; Thu, 20 Dec 2012 13:51:13 -0500
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id CFC8E140278
	for <lttng-dev@lists.lttng.org>; Thu, 20 Dec 2012 13:51:12 -0500 (EST)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id ESKTMJPQhD7p for <lttng-dev@lists.lttng.org>;
	Thu, 20 Dec 2012 13:51:11 -0500 (EST)
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

Highlights of the 2.1 lttng-modules release:

* Added ARM system call tracing,
* Added MIPS system call tracing,
* Some enhancements to the state dump,
* Support for older kernels: 2.6.32 up to 2.6.37 with up to 3 kernel
  patches in linux-patches/ directory of the tree. (in addition to
  2.6.38 up to 3.7.1)

Changelog since LTTng modules 2.1.0-rc1:
2012-12-20 (13th Baktun) LTTng modules 2.1.0
        * put_ulong calls in lib_ring_buffer_compat_ioctl() should be compat
        * wrapper/perf.h: Fix kernel version condition
        * Fix possible kernel build errors with linux-patches
        * Add missing MIT license text to 3 files under this license
        * Check if interrupt action name is not null in statedump
        * Fix exec instrumentation: only for kernels 3.4.0 and higher
        * Add TRACE_EVENT(sched_process_exec) to sched.h
        * lib/ringbuffer/frontend_api.h: Include linux/prefetch.h.
        * Fix warning with 3.6.0 kernel
        * ABI with support for compat 32/64 bits
        * Perform calculation on bit size in 64-bit
        * Use uint64_t for packet header content size and packet size
        * Fix: compat layer only on supported architectures
        * Fix ring buffer 32/64 bits compat
        * Fix cleanup: move lttng-tracer-core.h include to lib ringbuffer config.h
        * Fix ring_buffer_frontend.c: missing include lttng-tracer-core.h
        * Fix: statedump missing check for NULL namespace

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
