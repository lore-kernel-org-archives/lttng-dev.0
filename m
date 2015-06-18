From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.5.5 and 2.6.2
Date: Thu, 18 Jun 2015 17:52:08 +0000 (UTC)
Message-ID: <622668066.1956.1434649928158.JavaMail.zimbra__15572.9954633445$1434650041$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Z5dzE-0004iS-6B
 for lttng-dev@lists.lttng.org; Thu, 18 Jun 2015 13:52:29 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id CA97D34028D
 for <lttng-dev@lists.lttng.org>; Thu, 18 Jun 2015 17:52:18 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id BTo5VyFYPLWk for <lttng-dev@lists.lttng.org>;
 Thu, 18 Jun 2015 17:52:08 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A744F340498
 for <lttng-dev@lists.lttng.org>; Thu, 18 Jun 2015 17:52:08 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id wmdhQsmZHW-9 for <lttng-dev@lists.lttng.org>;
 Thu, 18 Jun 2015 17:52:08 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 74103340355
 for <lttng-dev@lists.lttng.org>; Thu, 18 Jun 2015 17:52:08 +0000 (UTC)
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

Changelog:

2015-06-18 lttng-ust 2.5.5
        * Fix: function instrumentation ip context
        * Fix: liblttng-ust-dl ip context
        * Fix: pthread wrapper ip context
        * Fix: lttng-ust-malloc ip context
        * Allow TP_IP_PARAM arg name to be configured
        * Fix: fetch caller address from tracef()
        * Fix: building probe providers with C++ compiler

2015-06-18 lttng-ust 2.6.2
        * Add aarch64 support to configure
        * Fix: function instrumentation ip context
        * Fix: liblttng-ust-dl ip context
        * Fix: pthread wrapper ip context
        * Fix: lttng-ust-malloc ip context
        * Allow TP_IP_PARAM arg name to be configured
        * Fix: fetch caller address from tracef()
        * Fix: building probe providers with C++ compiler

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
