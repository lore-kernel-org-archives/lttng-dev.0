From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.1.0
Date: Thu, 20 Dec 2012 13:45:25 -0500
Message-ID: <20121220184525.GA28486__44864.8733472966$1356029170$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Tll7W-0001lb-Jq
	for lttng-dev@lists.lttng.org; Thu, 20 Dec 2012 13:45:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id 44225140278
	for <lttng-dev@lists.lttng.org>; Thu, 20 Dec 2012 13:45:26 -0500 (EST)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id PbQGnEUDTui9 for <lttng-dev@lists.lttng.org>;
	Thu, 20 Dec 2012 13:45:25 -0500 (EST)
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

Highlights of the 2.1 UST release:

* Filtering by event field content is now supported. Example:

  lttng enable-event -u 'myevent' --filter 'myfield > 50 && otherfield < 100'

  (see lttng(1) for details)

* Applications built against lttng-ust 2.0 still work with
  lttng-ust 2.1, but it is recommended to rebuild the tracepoint probes
  if you want to be able to use filters on those events.

* It must be used with lttng-tools 2.1, which supports network
  streaming over TCP.

Detailed Changelog since 2.1.0-rc2:

2012-12-20 (13th Baktun) lttng-ust 2.1.0
        * Bump liblttng-ust-ctl lib version major number
        * Bump UST proto version minor number
        * Helper to debug: add object name
        * Tests: Fix rundir not created in ust-basic-tracing
        * ust test: add missing return -1
        * Test: update ust tracing unit tests to 2.1 internal ABI
        * Tests: Fix rundir not created in ust-multi-test
        * Adapt internal files and examples to TRACEPOINT_INCLUDE
        * Adapt tests to TRACEPOINT_INCLUDE
        * Cleanup: tests remove hello.cxx/ust_tests_demo.h
        * Fix: don't do macro expansion in tracepoint file name
        * Fix lttng-gen-tp: Template file must end in .tp
        * Pack structures in comm protocol between UST and sessiond
        * Cleanup lttng-gen-tp: Help not showing when using -h,--help
        * Cleanup lttng-gen-tp: remove leading underscore before include guard
        * fix memleak: ustctl free shadow chan on ustctl_unmap_channel()
        * Update license text
        * Fix: check if event enabled for bytecode-less events
        * Fix: handle enablers without bytecode
        * Print probe provider mismatch error even without -Wsystem-headers
        * filter: Add missing padding

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
