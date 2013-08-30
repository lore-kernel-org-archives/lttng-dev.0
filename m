From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.3.0-rc2
Date: Fri, 30 Aug 2013 14:41:03 -0400
Message-ID: <20130830184103.GA12134__17477.4748193615$1377888117$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VFTd2-0003rE-N4
	for lttng-dev@lists.lttng.org; Fri, 30 Aug 2013 14:41:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id 820DC1401ED
	for <lttng-dev@lists.lttng.org>; Fri, 30 Aug 2013 14:41:04 -0400 (EDT)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id QUxTPNSRRrWe for <lttng-dev@lists.lttng.org>;
	Fri, 30 Aug 2013 14:41:03 -0400 (EDT)
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

We plan a final release on Monday, September 1st. Please let us know
quickly if you find issues!

Changelog:
2013-08-30 lttng-ust 2.3.0-rc2
        * doc/examples/gen-tp: pass automake CPPFLAGS/CFLAGS/LDFLAGS
        * tools/lttng-gen-tp: honor CPPFLAGS and LDFLAGS
        * Fix: doc/examples cross-build
        * Fix: liblttng_ust.la should depend on liblttng-ust-tracepoint.la
        * Introduce configure --with-lttng-system-rundir
        * examples: tracepoint probes don't need extern C
        * Tracepoint probes don't need extern C
        * Add trace support for memalign and posix_memalign
        * malloc instrumentation: remove dependency on pthread
        * Add trace support for calloc and realloc.
        * Fix: allow make check to run in VPATH build
        * Update .gitignore
        * Update obsolete benchmark test
        * Cleanup tests (2nd commit)
        * Cleanup tests
        * Fix: doc/examples VPATH build

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
