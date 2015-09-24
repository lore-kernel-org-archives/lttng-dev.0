From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.6.4
Date: Thu, 24 Sep 2015 20:40:57 +0000 (UTC)
Message-ID: <557479491.4127.1443127257765.JavaMail.zimbra__42121.337055187$1443127337$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZfDKK-000886-46
 for lttng-dev@lists.lttng.org; Thu, 24 Sep 2015 16:41:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 61F9234048A
 for <lttng-dev@lists.lttng.org>; Thu, 24 Sep 2015 20:41:07 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id ii5lVHqppB7G for <lttng-dev@lists.lttng.org>;
 Thu, 24 Sep 2015 20:40:58 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 20EB2340494
 for <lttng-dev@lists.lttng.org>; Thu, 24 Sep 2015 20:40:58 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id EEd41qP4ejkC for <lttng-dev@lists.lttng.org>;
 Thu, 24 Sep 2015 20:40:58 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id EB7CE340490
 for <lttng-dev@lists.lttng.org>; Thu, 24 Sep 2015 20:40:57 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
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

This is a small bugfix release of the lttng-ust stable-2.6 branch. It
includes fixes for bugs identified by static analyzers.

Changelog:
2015-09-24 lttng-ust 2.6.4
        * Fix: don't dereference NULL pointers
        * Cleanup: Remove unused values
        * Fix: Value stored to 'has_waited' is never read
        * Fix: Argument with 'nonnull' attribute passed null
        * Fix: sysconf() unchecked return value

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
