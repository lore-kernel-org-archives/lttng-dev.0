From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.4.0
Date: Fri, 28 Feb 2014 18:41:14 +0000 (UTC)
Message-ID: <1755134602.32424.1393612874314.JavaMail.zimbra__33559.2650030323$1393612951$gmane$org@efficios.com>
References: <1351390393.32411.1393612762407.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WJSN2-0006q5-7c
	for lttng-dev@lists.lttng.org; Fri, 28 Feb 2014 13:41:21 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 5EEA6340212
	for <lttng-dev@lists.lttng.org>; Fri, 28 Feb 2014 18:41:17 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id KA6VzmImOdBS for <lttng-dev@lists.lttng.org>;
	Fri, 28 Feb 2014 18:41:14 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 9826634017A
	for <lttng-dev@lists.lttng.org>; Fri, 28 Feb 2014 18:41:14 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id dZQtXsvH_coA for <lttng-dev@lists.lttng.org>;
	Fri, 28 Feb 2014 18:41:14 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
	by mail.efficios.com (Postfix) with ESMTP id 75D8934014F
	for <lttng-dev@lists.lttng.org>; Fri, 28 Feb 2014 18:41:14 +0000 (UTC)
In-Reply-To: <1351390393.32411.1393612762407.JavaMail.zimbra@efficios.com>
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
2014-02-28 (Public Sleeping Day) lttng-ust 2.4.0
        * Fix: JUL test: update to API change
        * Fix: Cast from pointer to different integer size warning
        * Turn base address dump into experimental feature
        * Fix: JUL support multiple loglevels
        * Fix: Skip lttng-gen-tp example build if Python is missing
        * Fix: dynamically fetch the session daemon port
        * Fix: JUL agent connect to user and root sessiond
        * Fix: handle registration done command
        * Fix: Unsynchronized access in LTTngTCPSessiondClient
        * Cleanup: fix comment
        * Fix: Dump executable base-address with readlink
        * Fix: add assert for NULL dereference
        * Fix: tracepoint out of memory handling
        * Fix: dereference before null check
        * Cleanup: remove logically dead code
        * Fix: handle sysconf errors
        * Fix: java-jul/Makefile should not be marked as a binary

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
