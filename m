From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.6.4
Date: Thu, 24 Sep 2015 20:36:01 +0000 (UTC)
Message-ID: <1952995958.4107.1443126961004.JavaMail.zimbra__26008.5851340138$1443127025$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZfDFW-00084c-IJ
 for lttng-dev@lists.lttng.org; Thu, 24 Sep 2015 16:36:15 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D0BB0340357
 for <lttng-dev@lists.lttng.org>; Thu, 24 Sep 2015 20:36:09 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id gbAeD9TBkoJj for <lttng-dev@lists.lttng.org>;
 Thu, 24 Sep 2015 20:36:01 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 54C23340489
 for <lttng-dev@lists.lttng.org>; Thu, 24 Sep 2015 20:36:01 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id hDh1plP3qnvF for <lttng-dev@lists.lttng.org>;
 Thu, 24 Sep 2015 20:36:01 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 27EC3340357
 for <lttng-dev@lists.lttng.org>; Thu, 24 Sep 2015 20:36:01 +0000 (UTC)
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

This is a small bugfix release of the lttng-modules stable-2.6 branch.
It just includes changes required to build on the 4.3-rc Linux kernels.

Changelog:
2015-09-24 LTTng modules 2.6.4
        * Fix: writeback instrumentation update for 4.3 Linux kernel
        * Fix: update sched wakeup instrumentation for 4.3 kernel

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
