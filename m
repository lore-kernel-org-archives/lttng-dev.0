From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.1.0-rc1
Date: Mon, 10 Sep 2012 17:34:57 -0400
Message-ID: <20120910213457.GA22400__9109.29353344745$1347312939$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TBBdE-00017f-4c
	for lttng-dev@lists.lttng.org; Mon, 10 Sep 2012 17:35:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id BB80B14042D
	for <lttng-dev@lists.lttng.org>; Mon, 10 Sep 2012 17:34:59 -0400 (EDT)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id cY5nBLbSDlwo for <lttng-dev@lists.lttng.org>;
	Mon, 10 Sep 2012 17:34:57 -0400 (EDT)
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

Major new features:
        - filtering by event content,
        - basic java tracing.

Changelog:

2012-09-10 lttng-ust 2.1.0-rc1
	* Fix make dist: fix liblttng-ust-java dependencies
	* Fix make dist: add missing filter header
	* Fix: backward compatibility with UST 2.0 app probes
	* Fix: Filter ABI changes to support FILTER_BYTECODE_MAX_LEN (65536)
	* Export "written" information about fields
	* Fix filter: pointer to string, not string, should be on stack
	* Fix: tracepoint float nowrite
	* Fix: accept 65536 bytes long bytecodes
	* Add hostname to env
	* ABI change: bump internal version to 3.0.0
	* Fix: threads should be created in DETACHED state
	* Fix: 32-bit x86 strict-aliasing warnings
	* Fix UST SIGPIPE handling
	* Fix: Libtool fails to find dependent libraries when cross-compiling lttng-ust
	* Cleanup: filter: turn bytecode linking error msg into debug
	* Make lttng-ust robust against -finstrument-functions.
	* Filter: keep aliased ax and bx registers
	* Filter: remove interpreter dynamic typing
	* Filter: add missing specialized op names
	* Filter: specialize double-s64 binary comparators
	* Fix filter: fix stack leak on taken branch
	* Filter: Implement stack-based interpreter
	* Filter: double comparator produces s64
	* Filter: use hash table to check merge points
	* Filter: split passes into separate components
	* Filter: cleanup macros
	* Filter: validate range overflow with end of insn
	* Filter: validate that field ref strings are non-NULL
	* Filter: ensure logical operator merge is always s64
	* Filter: we don't care if double/s64 are literals
	* Filter: specialize 'and' and 'or' ops.
	* Implement dispatch-table based interpretor
	* Filter: Specialize unary operators
	* Define switch use as macro in interpreter
	* Filter interpreter: mark float test as unlikely
	* Filter: fix bytecode validation typo
	* Filter: specialize comparators
	* Specialize load and unary ops
	* Validate registers, no need to initialize to 0
	* Filter: opcode for ref loads
	* Remove redundant validation from interpreter
	* filter: Add bytecode validation pass
	* TRACEPOINT_EVENT: add *_nowrite fields for filter
	* Only print filter errors if LTTNG_UST_DEBUG is set
	* Cleanup: remove debug define
	* Filter: add floating point support
	* Remove filter test printouts
	* Implement filter bytecode interpreter and linker
	* Filter: receive, attach and link empty filter
	* Filter: prepare filter stack data
	* Wrap dynamic len array into stackvar union
	* liblttng-ust-comm/lttng-ust-com.c: remove unnecessary goto in ustcomm_accept_unix_sock()
	* liblttng-ust/lttng-ust-comm.c: fixing typo.
	* Fix: remove unused texinfo dep from configure.ac
	* Fix C99 strict compatibility: don't use void * for function pointers
	* Fix c99 compatibility: tp_rcu_dereference_bp() should not use braced-groups within expressions
	* Revert "Fix c99 compatibility: tp_rcu_dereference_bp() should not use braced-groups within expressions"
	* Fix c99 compatibility: tp_rcu_dereference_bp() should not use braced-groups within expressions
	* Fix: perform TLS fixup of nest count outside of UST mutex
	* Fix: liblttng-ust-fork deadlock
	* Fix: handle pthread errors
	* Fix: local apps allowed should disable local (not global) tracing
	* Fix strict ISO-C compatibility for ust-tracepoint-event.h public header
	* Fix: support -std=c99 in tracepoint macros
	* Fix c99 compatibility: use __typeof__ instead of typeof in public headers
	* hello test: fail on old style definition
	* Fix: tracepoint.h should not generate old-style definitions
	* Fix: don't define variables in headers
	* test "hello": add boolean test
	* Fix: perform macro expansion on tracepoint signatures
	* UST check pointer/de-reference order
	* Fix list field: handle error
	* Implement event fields listing
	* Implement field listing command
	* Fix: Block all signals in listener thread
	* Add CodingStyle document to tarball
	* Add coding style document
	* endian.h: support cygwin
	* align.h: support cygwin page size
	* Add cygwin support to libringbuffer getcpu.h
	* Add "2x int" and "2x long" types to the Java interface
	* Add Integer and Long tracepoint types to the Java interface
	* Fix: don't SIGBUS when filesystem is full
	* tracepoint: include stdio.h for NULL definition
	* manpage update: document that probes need gcc
	* Fix: remove # in front on extern "C" {
	* Cleanup: don't use GNU old-style field designator extension
	* Fix: remove padding field after variable sized array
	* Use unsigned long type for events discarded counter
	* Fix: getcpu build with modern uClibc versions
	* Fix: lttng-ust.pc needs to specify -ldl
	* Fix: examples Makefiles should pass $(LIBS) at last
	* Build a jar for the Java side of the JNI interface
	* Fix: ustctl need to send the second fd upon error of 1st fd
	* Fix: Add missing fork test program dependency library
	* Fix: Make the JNI interface actually work
	* Merge branch 'dev'
	* Fix: stringify version description

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
