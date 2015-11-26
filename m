From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.6.5 and 2.7.1 (Linux user-space
	tracer)
Date: Thu, 26 Nov 2015 16:59:37 +0000 (UTC)
Message-ID: <1269034815.158478.1448557177076.JavaMail.zimbra__2058.91178125075$1448557244$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1a1zta-0003iz-4s
 for lttng-dev@lists.lttng.org; Thu, 26 Nov 2015 11:59:48 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 054F0340470
 for <lttng-dev@lists.lttng.org>; Thu, 26 Nov 2015 16:59:42 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id y6Ajo9cRZ2HJ for <lttng-dev@lists.lttng.org>;
 Thu, 26 Nov 2015 16:59:37 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5F68A34056B
 for <lttng-dev@lists.lttng.org>; Thu, 26 Nov 2015 16:59:37 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id fjk1HJJqQjct for <lttng-dev@lists.lttng.org>;
 Thu, 26 Nov 2015 16:59:37 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 37B5B340470
 for <lttng-dev@lists.lttng.org>; Thu, 26 Nov 2015 16:59:37 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

LTTng-UST, the Linux Trace Toolkit Next Generation Userspace Tracer,
is a low-overhead application tracer. The library "liblttng-ust" enables
tracing of applications and libraries.

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

Those releases are bugfix-only releases.

Changelog for 2.7.1
2015-11-26 lttng-ust 2.7.1
        * Fix: header size larger than 256 bytes
        * Remove stale tests/java-jul test
        * Fix: live timer calculation error
        * Fix python agent build/install/uninstall with DESTDIR specified
        * Fix: Don't (re)define STAP_PROBEV

Changelog for 2.6.5:
2015-11-26 lttng-ust 2.6.5
        * Fix: header size larger than 256 bytes
        * Remove stale tests/java-jul test
        * Fix: live timer calculation error
        * Fix: Don't (re)define STAP_PROBEV

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
