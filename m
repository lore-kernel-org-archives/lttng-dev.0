From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.3.0-rc1 (snapshot feature)
Date: Wed, 17 Jul 2013 21:44:53 -0400
Message-ID: <20130718014453.GA5776__10928.6177591004$1374111945$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UzdH7-0002cp-61
	for lttng-dev@lists.lttng.org; Wed, 17 Jul 2013 21:45:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id EB8FB14191A
	for <lttng-dev@lists.lttng.org>; Wed, 17 Jul 2013 21:44:54 -0400 (EDT)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id L1afW6LutnSv for <lttng-dev@lists.lttng.org>;
	Wed, 17 Jul 2013 21:44:53 -0400 (EDT)
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
2.x tracer toolset.

This release provides a couple of new cool features, but the most
interesting one is certainly support for flight recorder tracing and
"snapshot" command of lttng tools.

It also includes updates system call listings for ARM, PowerPC and
Intel, as well as an enhanced x86 kvm instrumentation.

Changelog:
2013-07-17 LTTng modules 2.3.0-rc1
        * Fix: kvm x86 probes side-effect
        * Fix: allow get/put subbuf in loop for metadata stream
        * Add support for kvm x86 specific tracepoints
        * Add mainline headers for kvm x86 tracepoints
        * Remove old 3.0.4 x86-64 extracted syscall info
        * Point the x86-64 overrides to newly extracted 3.10-rc7 files
        * Add syscalls extracted files from a 3.10-rc7 kernel
        * Improve documentation of the syscall extractor script
        * Fix: double length of __dynamic_len array
        * Fix printk instrumentation
        * Introduce __dynamic_array_enc_ext_2() and tp_memcpy_dyn_2()
        * Fix: ring buffer: get_subbuf() checks should be performed on "consumed" parameter
        * Fix: SWITCH_FLUSH new sub-buffer checks
        * Fix: ring buffer: handle concurrent update in nested buffer wrap around check
        * Cleanup: lib_ring_buffer_switch_new_end() only calls subbuffer_set_data_size()
        * Revert "Cleanup: ring buffer: remove lib_ring_buffer_switch_new_end()"
        * Fix: handle writes of length 0
        * Fix: ring buffer: RING_BUFFER_FLUSH ioctl buffer corruption
        * Cleanup: ring buffer: remove lib_ring_buffer_switch_new_end()
        * print warning and return -EBUSY on double get_subbuf()
        * Add header to fix compilation of syscalls-extractor on 3.9 kernel
        * Fix: don't do 0 byte event reservation
        * Document that payload size need to be greater than 0
        * Fix build and load against linux-2.6.33.x
        * Fix: add missing CONFIG_COMPAT around lib_ring_buffer_compat_ioctl
        * Metadata cache and multiple metadata channels
        * fix block instrumentation probe signature mismatch for 3.9.x kernels
        * fix: block instrumentation: NULL pointer dereference
        * Update rcu instrumentation to 3.9.[0-4]
        * Fix CPU hotplug section mismatches
        * Add system calls definitions for powerpc-32
        * Remove bashism in lttng-syscalls-generate-headers.sh
        * Update ARM (32 bit) syscall tracepoints to 3.4

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
