From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.1.3
Date: Tue, 18 Jun 2013 20:37:49 -0400
Message-ID: <20130619003749.GB19766__25137.1620259762$1371602302$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Up6PG-0001JU-B3
	for lttng-dev@lists.lttng.org; Tue, 18 Jun 2013 20:37:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id 2AF1F141819
	for <lttng-dev@lists.lttng.org>; Tue, 18 Jun 2013 20:37:50 -0400 (EDT)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id VBk8F+xLDwAL for <lttng-dev@lists.lttng.org>;
	Tue, 18 Jun 2013 20:37:49 -0400 (EDT)
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

Changelog:
2013-06-18 lttng-ust 2.1.3
        * Tracepoint.h: replace assertion by fprintf and abort()
        * Fix: tracepoint.h incorrect assumption about constructor order
        * Fix: tracepoint instrumentation constructor order issue
        * Performance: add unlikely to tracepoint dynamic linking test
        * Fix: ensure all probe providers have their symbols
        * Clarify probe registration documentation/errors
        * Add mising include in ust.h
        * lttng-gen-tp: Fix include guard name with file using non valid
          characters
        * Fix: missing dependency for liblttng-ust-tracepoint.so
        * manpage: Document probe provider compatibility
        * Typo fix in README
        * Safety-check: only call register_lib if found in
          liblttng-ust-tracepoint.so.0
        * Fix: filter string comparison should check for literal
        * Fix: filter string wildcard comparison
        * Fix: _LGPL_SOURCE rcu dereference fix

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
