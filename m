From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.2.0-rc1 (Cuda)
Date: Thu, 28 Mar 2013 16:24:22 -0400
Message-ID: <20130328202422.GA1499__23680.9087255553$1364502312$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1ULJN2-0003DB-Bj
	for lttng-dev@lists.lttng.org; Thu, 28 Mar 2013 16:24:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id 2E3CC1401F3
	for <lttng-dev@lists.lttng.org>; Thu, 28 Mar 2013 16:24:24 -0400 (EDT)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id t8Pf9rHIUjJV for <lttng-dev@lists.lttng.org>;
	Thu, 28 Mar 2013 16:24:22 -0400 (EDT)
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
- Per context filtering (vtid, vpid, procname) with e.g.
  --filter 'procname=="apache2"'
- Buffers shared across applications with same user id e.g.
  lttng enable-channel -u mychan --buffers-uid
- Implement --switch-timer and --read-timer options (periodical flush
  and RT-awareness).
- Function entry/exit tracing (see lttng-ust-cyg-profile(3) manpage).

Release name: Cuda

Description (Cuda):
Brewed at the Benelux microbrewery, this IPA has huge floral, citric and
resinous hop aroma, simply an amazing nose. The flavor is very fresh
with a light caramel malting touch completing a strong body. Huge
amounts of hops, lots of grapefruit, lemon and oranges. This is an
outstanding IPA!

Changelog:
2013-03-28 lttng-ust 2.2.0-rc1
	* Fix: tracepoint instrumentation constructor order issue
	* Documentation: update 2.0 to 2.x
	* Add demo test back as an example
	* Don't rely on explicit context for filtering
	* Implement per-context filtering
	* Fix: filter string comparison should check for literal
	* update tests/demo readme file
	* Add man page for lttng-ust-cyg-profile
	* Fix: filter string wildcard comparison
	* Fix: Remove test runner script
	* Fix: forwarding of call_site argument to field
	* Add demo README
	* Tests: Use Perl prove as the testsuite runner
	* Remove tests depending on consumerd
	* Convert hello.cxx test to a build test
	* Clean-up of configure.ac and tests/Makefile.am
	* Fix snprintf test and output result to TAP format
	* Replace same_line_marker test with same_line_tracepoint
	* Remove tests-libustinstr-malloc
	* Remove exit-fast test
	* Remove fork test
	* Remove daemon test
	* Remove demo test
	* Remove outdated test-nevents test
	* Remove outdated simple_include test
	* Remove outdated register_test test
	* Convert hello-static-lib test to a build test
	* Convert hello test to a build test only
	* Remove outdated libustctl_function_tests test
	* Remove outdated test hello2
	* Remove outdated dlopen test
	* Remove outdated test basic long
	* Remove outdated test basic
	* cyg_profile: implement fast and verbose .so
	* Performance: add unlikely to tracepoint dynamic linking test
	* Fix: _LGPL_SOURCE rcu dereference fix
	* Implement liblttng-ust-cyg-profile function entry/exit instrumentation
	* Minor fix: libc wrapper internal run script
	* Fix: ustctl_recv_register_event pointer mixup
	* Fix: allow enabling same events for two channels
	* Add channel ID field to attr
	* Remove useless else clause
	* tracepoint: move "probe" test outside of loop
	* Fix uninitialized has_loglevel variable
	* Fix clang warnings
	* Cleanup: work-around clang unused result warning
	* Cleanup compile warning
	* Cleanup: remove unused variables
	* tracepoint: Don't add NULL probes
	* Remove mention of locking issues associated with dlopen usage
	* Implement read timer (for RT)
	* Only flush when there are readers active
	* Add mutex for channel wakeup fd update
	* Fix: fields should be initialized to NULL
	* Implement ustctl_duplicate_ust_object_data
	* Add channel wakeup fd to monitor close
	* Fix: refcount issue in lttng-ust-abi.c
	* Fix: only consumerd should print errors
	* Implement ring buffer periodic buffer switch timer
	* Fix: ensure all probe providers have their symbols
	* Reactivate error printing
	* Unregister tracepoint probes when not needed
	* Cleanup: remove now unused metadata code from UST
	* Fix: notification timeout logic
	* Fix: don't print error in comm proto connect on ENOENT
	* Fix: return expected error return values for sessiond
	* Fix: set wait/wake fd to -1 before close
	* Fix: Only notify socket should have timeout/nonblock
	* Fix: ustctl: return -EPIPE to sessiond if connection is closed
	* Fix: Add timeout on notification socket
	* Remove now unused metadata printf code
	* Move metadata creation into lttng-sessiond and lttng-consumed
	* Add write metadata API to ust-ctl.h
	* Move UST registry into sessiond and implement notifiers
	* Fix: don't flush-final for offset 0 if reader is on sub-buffer
	* Use tp rcu link test in provider
	* Remove direct dependency of probes on urcu-bp
	* Use urcu tls-compat.h
	* Lazy provider registration
	* Always use lttng_get_probe_list_head to get probe list
	* Fix static build
	* Move LTTng-UST buffer ownership from application to consumer
	* Fix package: don't distribute generated headers
	* Fix: don't cancel already exited threads
	* Scalability fix: tracepoint.c hash table size increase
	* Scalability fix for many events: event hash table size
	* Speed up probe registration for large amount of events
	* Add missing demo-trace shell script to dist tarball
	* Documentation: add uuid package name for Fedora in README
	* Fix: missing test for lttng_ust_comm_should_quit in lttng-ust-comm.c
	* Add compilation support for Tile architectures
	* Documentation: clarify debian package name for uuid in README
	* Fix: comment in ust-ctl.h
	* Fix I/O-related error values in ustctl
	* Introduce hash table for lttng_create_event_if_missing()
	* Fix: don't build C++ example if a C++ compiler isn't available
	* Remove LIBFORMAT output in configure.
	* Document dependency on libuuid

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
