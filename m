From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.4.0-rc2
Date: Tue, 10 Dec 2013 19:21:19 +0000 (UTC)
Message-ID: <907035884.83161.1386703279213.JavaMail.zimbra__2869.45691700584$1386703390$gmane$org@efficios.com>
References: <174530350.83158.1386703262382.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VqSrt-00084H-N3
	for lttng-dev@lists.lttng.org; Tue, 10 Dec 2013 14:21:23 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 486753401D8
	for <lttng-dev@lists.lttng.org>; Tue, 10 Dec 2013 19:21:21 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id 6YPnd-SyyEGS for <lttng-dev@lists.lttng.org>;
	Tue, 10 Dec 2013 19:21:19 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 8EC8D34026E
	for <lttng-dev@lists.lttng.org>; Tue, 10 Dec 2013 19:21:19 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id 0etp16bN2vfh for <lttng-dev@lists.lttng.org>;
	Tue, 10 Dec 2013 19:21:19 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
	by mail.efficios.com (Postfix) with ESMTP id 6B8E53401D8
	for <lttng-dev@lists.lttng.org>; Tue, 10 Dec 2013 19:21:19 +0000 (UTC)
In-Reply-To: <174530350.83158.1386703262382.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

LTTng-UST, the Linux Trace Toolkit Next Generation Userspace Tracer, is
port of the low-overhead tracing capabilities of the LTTng kernel tracer
to user-space. The library "liblttng-ust" enables tracing of
applications and libraries.

Changelog:
2013-12-10 lttng-ust 2.4.0-rc2
        * Fix: baddr_statedump tracepoint registration
        * Fix: baddr deadlocks and RCU races
        * Fix: lock exit mutex when creating threads
        * Fix: baddr deadlock with lttng-ust destructor
        * baddr: include missing header
        * baddr: get session under lock
        * Fix: take the ust lock around session iteration in statedump
        * Fix: baddr_statedump deadlock with JUL tracing
        * Fix: client_packet_header() uses wrong packet
        * Cleanup: fix typo in ring buffer backend comment
        * Compile liblttng-ust-baddr c files into liblttng-ust
        * Allow suppressing of base-address-state tracing
        * Integrate base-address statedump into lttng-ust
        * Fix: eliminate timestamp overlap between packets
        * Fix: lttng-gen-tp to build out of tree
        * Fix: compile doc/ after JUL/Java
        * JUL: add Hello.java in doc/examples
        * Fix lttng-ust(3) manpage
        * JUL: fix enable all event for delayed Logger
        * Fix: typo in JNICALL for the JUL tracepoint
        * Fix: move va_end to outermost label
        * Fix: add missing NULL check after allocation
        * Fix cleanup: all spaces before flags
        * fix: lttng-gen-tp: add missing spaces around flags

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
