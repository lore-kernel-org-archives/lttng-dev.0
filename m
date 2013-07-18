From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.3.0-rc1
Date: Wed, 17 Jul 2013 21:50:00 -0400
Message-ID: <20130718015000.GB5776__46963.3431559943$1374112248$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UzdM1-0002g7-TZ
	for lttng-dev@lists.lttng.org; Wed, 17 Jul 2013 21:50:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id B62FD14191A
	for <lttng-dev@lists.lttng.org>; Wed, 17 Jul 2013 21:50:01 -0400 (EDT)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id 9EFDgkk9IeRu for <lttng-dev@lists.lttng.org>;
	Wed, 17 Jul 2013 21:50:00 -0400 (EDT)
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

As for lttng modules, lttng-ust 2.3.0-rc1 introduces support for flight
recorder tracing, with the "snapshot" command of lttng tools.

Changelog:
2013-07-17 lttng-ust 2.3.0-rc1
	* Fix: Unchecked asprintf/vasprintf return values
	* Missing NULL pointer init in tap.c
	* Disable doc/examples build
	* Add python3 support to lttng-gen-tp
	* Bump ABI major to 5
	* callsite: add "ip" context
	* Allow environment variable LTTNG_HOME to override HOME
	* Fix: libs order in Makefile
	* Fix: ring buffer: get_subbuf() checks should be performed on "consumed" parameter
	* Introduce ustctl_write_one_packet_to_channel
	* build: Fix out-of-tree build
	* Fix: SWITCH_FLUSH new sub-buffer checks
	* Fix: ring buffer: handle concurrent update in nested buffer wrap around check
	* Cleanup: lib_ring_buffer_switch_new_end() only calls subbuffer_set_data_size()
	* Fix: doc/examples: gen-tp path
	* Revert "Cleanup: ring buffer: remove lib_ring_buffer_switch_new_end()"
	* Fix: handle writes of length 0
	* Cleanup: ring buffer: remove lib_ring_buffer_switch_new_end()
	* Fix: lttng-events VPATH build
	* Allow #include in template (.tp) file
	* tests/hello.cxx: rename tp.cpp into tp-cpp.cpp
	* doc/examples: build gen-tp example by default
	* doc/examples: support BSD make
	* Tracepoint.h: replace assertion by fprintf and abort()
	* Remove unused assert.h from bitfield.h
	* Clarify probe registration documentation/errors
	* Fix: Check C++ designated initializers support before compiling 'hello.cxx' test
	* Add mising include in ust.h
	* lttng-gen-tp: Fix include guard name with file using non valid characters
	* Fix: segfault when print invalid command
	* Fix: Add --no-as-needed to the demo example's Makefile
	* zmalloc: attribute always_inline
	* Fix: liblttng-ust process startup hang when sessiond is stopped
	* Move include directive from CFLAGS to LOCAL_CPPFLAGS in examples' Makefiles
	* Allow tracepoint providers to be compiled with g++
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
	* Move "hello-static-lib" to doc/examples and add non-automake Makefiles

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
