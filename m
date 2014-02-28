From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.3.2
Date: Fri, 28 Feb 2014 17:51:59 +0000 (UTC)
Message-ID: <620693392.32305.1393609919634.JavaMail.zimbra__20663.1560846747$1393609988$gmane$org@efficios.com>
References: <1932625465.32303.1393609888925.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WJRbM-0006H3-Pn
	for lttng-dev@lists.lttng.org; Fri, 28 Feb 2014 12:52:06 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id C6A04340247
	for <lttng-dev@lists.lttng.org>; Fri, 28 Feb 2014 17:52:01 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id AuTc1fFme_QV for <lttng-dev@lists.lttng.org>;
	Fri, 28 Feb 2014 17:52:00 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 12C89340270
	for <lttng-dev@lists.lttng.org>; Fri, 28 Feb 2014 17:52:00 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id WS5ySbzN48Bv for <lttng-dev@lists.lttng.org>;
	Fri, 28 Feb 2014 17:51:59 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
	by mail.efficios.com (Postfix) with ESMTP id DB3AD340247
	for <lttng-dev@lists.lttng.org>; Fri, 28 Feb 2014 17:51:59 +0000 (UTC)
In-Reply-To: <1932625465.32303.1393609888925.JavaMail.zimbra@efficios.com>
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
2014-02-28 lttng-ust 2.3.2
        * Fix: Cast from pointer to different integer size warning
        * Cleanup: fix comment
        * Fix: add assert for NULL dereference
        * Fix: tracepoint out of memory handling
        * Cleanup: remove logically dead code
        * Fix: handle sysconf errors
        * Fix: FD leak in liblttng-ust-ctl
        * Fix: liblttng-ust-fork Makefile flags mismatch
        * Fix: out of tree examples build
        * Fix: lttng-gen-tp to build out of tree
        * Fix: C++: incomplete extern C guard transition
        * Cleanup gen-tp: add quotes around AM_CC
        * Pass the CC variable to the example Makefiles
        * Fix: eliminate timestamp overlap between packets
        * Fix lttng-ust(3) manpage
        * Fix: move va_end to outermost label
        * Fix: add missing NULL check after allocation
        * fix: lttng-gen-tp: add missing spaces around flags
        * doc/examples: error out when a subdir make fails
        * Add missing copyrights to test scripts
        * Escape minus signs in lttng-ust-cyg-profile manpage
        * Fix spelling mistake in lttng-ust manpage
        * Fix tests/benchmark

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
