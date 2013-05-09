From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.2.0-rc2
Date: Thu, 9 May 2013 08:55:14 -0400
Message-ID: <20130509125514.GA26095__11186.4598504782$1368106252$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UaQNQ-0008CQ-4g
	for lttng-dev@lists.lttng.org; Thu, 09 May 2013 08:55:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id F1BAD14059E
	for <lttng-dev@lists.lttng.org>; Thu,  9 May 2013 08:55:15 -0400 (EDT)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id F9CG3s2jNoVz for <lttng-dev@lists.lttng.org>;
	Thu,  9 May 2013 08:55:15 -0400 (EDT)
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
2013-05-09 lttng-ust 2.2.0-rc2
        * manpage: Document probe provider compatibility
        * Fix: add provider ABI compatibility check
        * Cleanup: ignore mktemp return value
        * Cleanup: documentation: argument vs field
        * Documentation: document undefined behavior for NULL pointers
        * Cleanup: silence cppcheck error
        * Fix: add internal mutex for timer
        * 32-bit warning fix for cyg profile fast
        * Fix warnings for 32-bit in lttng-ust-cyg-profile
        * Typo fix in README
        * Fix: tracepoint.h incorrect assumption about constructor order
        * Cleanup: comment mismatch with code
        * Fix: ABI breakage between 2.1 and 2.2-rc1
        * Documentation: document that sequence len field is unsigned
        * connect: don't report EACCES
        * connect: don't print error on EPERM
        * Bump liblttng-ust-ctl lib version major number
        * Optimisation: implement callsite hash table in tracepoint.c
        * Optimisation: only update added library in tracepoint.c
        * Optimisation: only fix pending events once per lazy update

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
