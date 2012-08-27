From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.0.5
Date: Mon, 27 Aug 2012 08:27:10 -0400
Message-ID: <20120827122710.GA2172__28663.6396930136$1346070460$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1T5yPQ-0001th-SD
	for lttng-dev@lists.lttng.org; Mon, 27 Aug 2012 08:27:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id B987914021C
	for <lttng-dev@lists.lttng.org>; Mon, 27 Aug 2012 08:27:12 -0400 (EDT)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id wY-6tGuZ0d7d for <lttng-dev@lists.lttng.org>;
	Mon, 27 Aug 2012 08:27:10 -0400 (EDT)
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
2012-08-27 lttng-ust 2.0.5
        * Fix: threads should be created in DETACHED state
        * Fix UST SIGPIPE handling
        * Fix: Libtool fails to find dependent libraries when cross-compiling lttng-ust
        * Fix: remove unused texinfo dep from configure.ac
        * Fix C99 strict compatibility: don't use void * for function pointers
        * Fix c99 compatibility: tp_rcu_dereference_bp() should not use braced-groups within expressions
        * Fix c99 compatibility: use __typeof__ instead of typeof in public headers

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
