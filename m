From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.2.3 (end of life)
Date: Fri, 28 Feb 2014 17:21:29 +0000 (UTC)
Message-ID: <2002322606.32275.1393608089593.JavaMail.zimbra__620.62432193688$1393608157$gmane$org@efficios.com>
References: <2066668738.32265.1393607912199.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WJR7q-0005yh-Gb
	for lttng-dev@lists.lttng.org; Fri, 28 Feb 2014 12:21:36 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 8B43834024C
	for <lttng-dev@lists.lttng.org>; Fri, 28 Feb 2014 17:21:31 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id K5znlnMww9HA for <lttng-dev@lists.lttng.org>;
	Fri, 28 Feb 2014 17:21:30 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id E925E340253
	for <lttng-dev@lists.lttng.org>; Fri, 28 Feb 2014 17:21:29 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id bfZHceuADW6i for <lttng-dev@lists.lttng.org>;
	Fri, 28 Feb 2014 17:21:29 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
	by mail.efficios.com (Postfix) with ESMTP id C1FE434024C
	for <lttng-dev@lists.lttng.org>; Fri, 28 Feb 2014 17:21:29 +0000 (UTC)
In-Reply-To: <2066668738.32265.1393607912199.JavaMail.zimbra@efficios.com>
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

Please note that this is the last version of the stable-2.2 lttng-ust
branch. You are encouraged to move to either 2.4, or 2.3.

Changelog:
2014-02-28 lttng-ust 2.2.3
        * Fix: FD leak in liblttng-ust-ctl
        * Fix: liblttng-ust-fork Makefile flags mismatch
        * Fix: C++: incomplete extern C guard transition
        * Cleanup gen-tp: add quotes around AM_CC
        * Pass the CC variable to the example Makefiles
        * doc/examples/gen-tp: pass automake CPPFLAGS/CFLAGS/LDFLAGS
        * doc/examples: error out when a subdir make fails
        * Fix: check deliver now takes tsc argument
        * Fix: eliminate timestamp overlap between packets
        * Fix lttng-ust(3) manpage
        * Fix: move va_end to outermost label
        * Fix: add missing NULL check after allocation
        * Add missing copyrights to test scripts
        * Escape minus signs in lttng-ust-cyg-profile manpage
        * Fix spelling mistake in lttng-ust manpage

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
