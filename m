From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.5.5 and 2.6.2
Date: Thu, 18 Jun 2015 17:53:08 +0000 (UTC)
Message-ID: <1910490539.1961.1434649988649.JavaMail.zimbra__2301.66544574804$1434650155$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Z5e0B-0004jY-8c
 for lttng-dev@lists.lttng.org; Thu, 18 Jun 2015 13:53:30 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id EAC58340355
 for <lttng-dev@lists.lttng.org>; Thu, 18 Jun 2015 17:53:17 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id PdxR_wXtOpMR for <lttng-dev@lists.lttng.org>;
 Thu, 18 Jun 2015 17:53:09 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3C3BB34028D
 for <lttng-dev@lists.lttng.org>; Thu, 18 Jun 2015 17:53:09 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id zh9FKF02Uvcy for <lttng-dev@lists.lttng.org>;
 Thu, 18 Jun 2015 17:53:09 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 02D94340499
 for <lttng-dev@lists.lttng.org>; Thu, 18 Jun 2015 17:53:09 +0000 (UTC)
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

The LTTng modules provide Linux kernel tracing capability to the LTTng
2.x tracer toolset.

Changelog:

2015-06-18 LTTng modules 2.5.5
        * Fix: Incorrect Ubuntu kernel patchlevel
        * Fix: RHEL 7.1 block instrumentation
        * Fix: add RHEL version macros
        * Fix: add missing parenthesis in ubuntu version check
        * Fix: missing statedump end event when block device listing available

2015-06-18 LTTng modules 2.6.2
        * Fix: version checks for kernel 4.0
        * Fix: Incorrect Ubuntu kernel patchlevel
        * Fix: Update kmem event for Ubuntu's 3.16 kernel
        * Fix: RHEL 7.1 block instrumentation
        * Fix: add RHEL version macros
        * Fix: add missing parenthesis in ubuntu version check
        * Fix: remove regmap instrumentation for kernels < 4.1
        * Fix: Update kmem event for recent Ubuntu kernel
        * Fix: missing statedump end event when block device listing available
        * Fix: don't generate incorrect macros for debian/ubuntu version check

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
