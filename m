From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.2.2
Date: Tue, 12 Nov 2013 17:27:24 +0000 (UTC)
Message-ID: <1300734981.65242.1384277244852.JavaMail.zimbra__43585.4988907979$1384277325$gmane$org@efficios.com>
References: <1152169813.65241.1384277228593.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VgHkN-0007YO-N5
	for lttng-dev@lists.lttng.org; Tue, 12 Nov 2013 12:27:33 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id E4F283401F3
	for <lttng-dev@lists.lttng.org>; Tue, 12 Nov 2013 17:27:27 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id Md4Jkvzqb7yA for <lttng-dev@lists.lttng.org>;
	Tue, 12 Nov 2013 17:27:25 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 3817634022A
	for <lttng-dev@lists.lttng.org>; Tue, 12 Nov 2013 17:27:25 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id PpRwLtw2myJA for <lttng-dev@lists.lttng.org>;
	Tue, 12 Nov 2013 17:27:25 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
	by mail.efficios.com (Postfix) with ESMTP id 0E3CA3401F3
	for <lttng-dev@lists.lttng.org>; Tue, 12 Nov 2013 17:27:25 +0000 (UTC)
In-Reply-To: <1152169813.65241.1384277228593.JavaMail.zimbra@efficios.com>
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
2013-11-12 lttng-ust 2.2.2
        * Fix: application SIGBUS when starting in parallel with sessiond
        * Fix: Minor corrections to the lttng-ust man page
        * Documentation cleanup: Overhaul of the lttng-gen-tp man page
        * Warning cleanup: add missing padding initializer
        * Fix: socket connect hang on heavy loads
        * Cleanup: fix typo
        * Fix: ust-comm recvmsg should handle partial receive
        * gcc warning fix: -Wextra
        * Add usage reference count for tracepoints
        * tracepoint.c: Move add_callsite/remove_callsite further down in file
        * Store the callsites into the library callsite list
        * Fix linking warning
        * Fix: doc/examples cross-build
        * Fix: liblttng_ust.la should depend on liblttng-ust-tracepoint.la
        * examples: tracepoint probes don't need extern C
        * Tracepoint probes don't need extern C
        * Fix: doc/examples VPATH build
        * Disable doc/examples build
        * Fix: doc/examples: gen-tp path
        * Revert "Disable doc/examples build"
        * Fix: Unchecked asprintf/vasprintf return values
        * Missing NULL pointer init in tap.c

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
