From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.5.0-rc2
Date: Fri, 27 Jun 2014 14:26:03 +0000 (UTC)
Message-ID: <1014027905.5331.1403879163896.JavaMail.zimbra__31984.0494230904$1403879238$gmane$org@efficios.com>
References: <1917252705.5329.1403879121991.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1X0X6M-0007wE-Ni
 for lttng-dev@lists.lttng.org; Fri, 27 Jun 2014 10:26:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D2A2B3401A7
 for <lttng-dev@lists.lttng.org>; Fri, 27 Jun 2014 14:26:08 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id K20x5cTAOzYj for <lttng-dev@lists.lttng.org>;
 Fri, 27 Jun 2014 14:26:04 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8370F3401BC
 for <lttng-dev@lists.lttng.org>; Fri, 27 Jun 2014 14:26:04 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id n2l8Z9CnIfUy for <lttng-dev@lists.lttng.org>;
 Fri, 27 Jun 2014 14:26:04 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 174F03401B8
 for <lttng-dev@lists.lttng.org>; Fri, 27 Jun 2014 14:26:04 +0000 (UTC)
In-Reply-To: <1917252705.5329.1403879121991.JavaMail.zimbra@efficios.com>
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

The LTTng modules provide Linux kernel tracing capability to the LTTng
2.x tracer toolset.

Changelog:

2014-06-27 LTTng modules 2.5.0-rc2
        * Fix: statedump: check whether "files" is NULL, RCU semantic fix
        * Fix: statedump handle oom case, handle errors
        * Fix: correct typo in kernel version number
        * Fix: blktrace instrumentation for backported branches
        * Fix: statedump block devices OOPS

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
