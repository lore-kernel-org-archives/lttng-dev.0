From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.4.0-rc1
Date: Fri, 15 Nov 2013 21:10:00 +0000 (UTC)
Message-ID: <661952664.68956.1384549800533.JavaMail.zimbra__41294.9404716075$1384549863$gmane$org@efficios.com>
References: <1031736026.68948.1384549673024.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VhQeR-000594-Dg
	for lttng-dev@lists.lttng.org; Fri, 15 Nov 2013 16:10:09 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id AA5313400CA
	for <lttng-dev@lists.lttng.org>; Fri, 15 Nov 2013 21:10:02 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id hk3BDSmD3_9x for <lttng-dev@lists.lttng.org>;
	Fri, 15 Nov 2013 21:10:00 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id CEA4234011B
	for <lttng-dev@lists.lttng.org>; Fri, 15 Nov 2013 21:10:00 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id lj5VaiUmo4P6 for <lttng-dev@lists.lttng.org>;
	Fri, 15 Nov 2013 21:10:00 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
	by mail.efficios.com (Postfix) with ESMTP id AAD303400CA
	for <lttng-dev@lists.lttng.org>; Fri, 15 Nov 2013 21:10:00 +0000 (UTC)
In-Reply-To: <1031736026.68948.1384549673024.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

LTTng-UST, the Linux Trace Toolkit Next Generation Userspace Tracer, is
port of the low-overhead tracing capabilities of the LTTng kernel tracer
to user-space. The library "liblttng-ust" enables tracing of
applications and libraries.

Main changes: Java Util Logging support, live streaming support, event "excluders" (courtesy of Mentor), base address tracing for symbol lookup (courtesy of Mentor).

Changelog:
2013-11-15 lttng-ust 2.4.0-rc1
        * doc/examples: error out when a subdir make fails
        * JUL: fix out of tree build
        * Java/jul: fix make dist
        * JUL: install documentation and jar file
        * Add missing copyrights to test scripts
        * Escape minus signs in lttng-ust-cyg-profile manpage
        * Fix spelling mistake in lttng-ust manpage
        * Fix tests/benchmark
        * Implement base-address-state tracing
        * Base-address tracing for dlopen and dlclose
        * Add a check against excluders
        * Add handler for LTTNG_UST_EXCLUSION in UST ABI
        * Store exclusions to enablers
        * Add excluders to enabler structure
        * Send exclusion data through ustcomm
        * Define exclusion structure for UST ABI
        * Define a new command LTTNG_UST_EXCLUSION
        * Fix: package of LTTngUst.h was renamed without renaming target in makefile
        * Fix: check for java .class in package subfolders
        * Fix: java library to use user define JDK at compile time
        * Add liblttng-ust-jul for JUL support
        * Fix: application SIGBUS when starting in parallel with sessiond
        * Fix: Minor corrections to the lttng-ust man page
        * Documentation cleanup: Overhaul of the lttng-gen-tp man page
        * Warning cleanup: add missing padding initializer
        * Fix: socket connect hang on heavy loads
        * Cleanup: fix typo
        * Fix: ust-comm recvmsg should handle partial receive
        * gcc warning fix: -Wextra
        * Add usage reference count for tracepoints
        * tracepoint.c: Move add_callsite/remove_callsite further down in file
        * Store the callsites into the library callsite list
        * Fix linking warning
        * Per-stream ioctl to get the current timestamp
        * LTTng ringbuffer ABI calls for index generation
        * Specialize lttng_ust_lib_ring_buffer_client_cb
        * Add tracing instrumentation for pthread mutex lock functions

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
