From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.4.0-rc4
Date: Fri, 14 Feb 2014 16:48:39 +0000 (UTC)
Message-ID: <2143198415.25140.1392396519384.JavaMail.zimbra__47525.9901294068$1392396588$gmane$org@efficios.com>
References: <1722995132.25139.1392396506153.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WELwP-0004W1-IV
	for lttng-dev@lists.lttng.org; Fri, 14 Feb 2014 11:48:47 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 3C7C53400BC
	for <lttng-dev@lists.lttng.org>; Fri, 14 Feb 2014 16:48:41 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id 0VK_KxUn8d3T for <lttng-dev@lists.lttng.org>;
	Fri, 14 Feb 2014 16:48:39 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id C4A3E34027B
	for <lttng-dev@lists.lttng.org>; Fri, 14 Feb 2014 16:48:39 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id wndsgmb6lCNa for <lttng-dev@lists.lttng.org>;
	Fri, 14 Feb 2014 16:48:39 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
	by mail.efficios.com (Postfix) with ESMTP id 8F9BC3400BC
	for <lttng-dev@lists.lttng.org>; Fri, 14 Feb 2014 16:48:39 +0000 (UTC)
In-Reply-To: <1722995132.25139.1392396506153.JavaMail.zimbra@efficios.com>
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
2014-02-14 lttng-ust 2.4.0-rc4
        * Cleanup: remove extra space in dlerror wrapper
        * Fix: work-around glibc lying about dlsym()/dlerror() leafness
        * Cleanup: add lttng_ust_malloc_wrapper_init prototype to header
        * Fix: malloc libc instrumentation wrapper
        * Fix: add LTTngEvent class to fix delayed logger
        * Fix: FD leak in liblttng-ust-ctl
        * Fix: liblttng-ust-dl Makefile flags mismatch
        * Fix: liblttng-ust-fork Makefile flags mismatch
        * Fix: out of tree examples build
        * Fix: C++: incomplete extern C guard transition

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
