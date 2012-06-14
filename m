From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.0.4
Date: Thu, 14 Jun 2012 11:24:06 -0400
Message-ID: <20120614152406.GA2306__48693.3755143129$1339687483$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SfBu4-0007R4-AC
	for lttng-dev@lists.lttng.org; Thu, 14 Jun 2012 11:24:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id DF7D814022B
	for <lttng-dev@lists.lttng.org>; Thu, 14 Jun 2012 11:24:07 -0400 (EDT)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id DarUM3buFqTK for <lttng-dev@lists.lttng.org>;
	Thu, 14 Jun 2012 11:24:07 -0400 (EDT)
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

Note: the "liblttng-ust-fork deadlock" fix is an important fix. Anyone
using the liblttng-ust-fork library is encouraged to upgrade.

Changelog:
2012-06-14 lttng-ust 2.0.4
        * Fix: perform TLS fixup of nest count outside of UST mutex
        * Fix: liblttng-ust-fork deadlock
        * Fix: handle pthread errors
        * Fix: local apps allowed should disable local (not global) tracing
        * Fix strict ISO-C compatibility for ust-tracepoint-event.h public header
        * Fix: support -std=c99 in tracepoint macros
        * Fix: tracepoint.h should not generate old-style definitions
        * Fix: don't define variables in headers
        * test "hello": add boolean test
        * Fix: perform macro expansion on tracepoint signatures
        * UST check pointer/de-reference order

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
