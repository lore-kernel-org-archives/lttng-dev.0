From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.2.0-rc3
Date: Tue, 18 Jun 2013 21:17:36 -0400
Message-ID: <20130619011736.GA20637__46996.0727300078$1371604694$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Up71l-0001jJ-QL
	for lttng-dev@lists.lttng.org; Tue, 18 Jun 2013 21:17:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id A5CD0141819
	for <lttng-dev@lists.lttng.org>; Tue, 18 Jun 2013 21:17:37 -0400 (EDT)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id LZqtR5qFlgHB for <lttng-dev@lists.lttng.org>;
	Tue, 18 Jun 2013 21:17:36 -0400 (EDT)
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

LTTng-UST, the Linux Trace Toolkit Next Generation Userspace Tracer, is
port of the low-overhead tracing capabilities of the LTTng kernel tracer
to user-space. The library "liblttng-ust" enables tracing of
applications and libraries.

This is hopefully the last RC before 2.2 final.

Changelog:
2013-05-09 lttng-ust 2.2.0-rc3
        * Tracepoint.h: replace assertion by fprintf and abort()
        * Remove unused assert.h from bitfield.h
        * Clarify probe registration documentation/errors
        * Add mising include in ust.h
        * lttng-gen-tp: Fix include guard name with file using non valid
          characters
        * Fix: segfault when print invalid command
        * Fix: Add --no-as-needed to the demo example's Makefile
        * zmalloc: attribute always_inline
        * Fix: liblttng-ust process startup hang when sessiond is stopped
        * Move include directive from CFLAGS to LOCAL_CPPFLAGS in examples'
          Makefiles
        * Add parameter -f to rm in Makefile clean target
        * Fix: missing dependency for liblttng-ust-tracepoint.so
        * Remove 0.x TODO
        * Add warning about default prefix and library paths to README
        * Revert "Revert "Fix (another) linker library order""
        * Revert "Revert "Fix linker library order""
        * snprintf: play nice with static checker
        * tracepoint.c: Add coverity alloc/free annotations
        * Fix: "fields" leak on register
        * Fix: memory leak for events without fields
        * Fix: memory leak on connection reset
        * Revert "Fix linker library order"
        * Revert "Fix (another) linker library order"
        * Fix: incorrect support for multi-context
        * Fix (another) linker library order
        * Fix typo in run script
        * Fix linker library order
        * Fix examples: add missing CPPFLAGS
        * example Makefiles: standardize on $^ for linking
        * Fix demo example Makefile
        * Move "hello-static-lib" to doc/examples and add non-automake
          Makefiles

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
