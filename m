From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.0.6
Date: Mon, 26 Nov 2012 15:47:50 -0500
Message-ID: <20121126204749.GA31733__22801.960577681$1353963050$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Td5aq-0008Ce-5q
	for lttng-dev@lists.lttng.org; Mon, 26 Nov 2012 15:47:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id D6EE8140003
	for <lttng-dev@lists.lttng.org>; Mon, 26 Nov 2012 15:47:51 -0500 (EST)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id 1sLe1SqDsNuD for <lttng-dev@lists.lttng.org>;
	Mon, 26 Nov 2012 15:47:50 -0500 (EST)
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
2012-11-26 lttng-ust 2.0.6
        * Print probe provider mismatch error even without -Wsystem-headers
        * Fix: Conditionally disable tests requiring shared libs support
        * Cleanup: don't spawn per-user thread if HOME is not set
        * Fix: Fix self-assign warning on struct ustfork_clone_info init
        * Fix: memcpy of string is larger than source
        * liblttng-ust-fork: override daemon() call
        * Build out of src tree
        * Fix: manpage typo "-lllttng-ust" -> "-llttng-ust"
        * Manpage update: document use in daemons
        * Fix: get_wait_shm() ust mutex deadlock (add 2 missing exit calls)
        * Fix: get_wait_shm() ust mutex deadlock

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
