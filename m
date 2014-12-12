From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.4.3
Date: Fri, 12 Dec 2014 15:45:18 +0000 (UTC)
Message-ID: <561758522.26687.1418399118178.JavaMail.zimbra__49157.5655215003$1418399170$gmane$org@efficios.com>
References: <434161235.26685.1418399107964.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XzSPA-0000r0-OD
 for lttng-dev@lists.lttng.org; Fri, 12 Dec 2014 10:45:23 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 2B11F340043
 for <lttng-dev@lists.lttng.org>; Fri, 12 Dec 2014 15:45:19 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id q9ok7-vBwVa9 for <lttng-dev@lists.lttng.org>;
 Fri, 12 Dec 2014 15:45:18 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A2C88340253
 for <lttng-dev@lists.lttng.org>; Fri, 12 Dec 2014 15:45:18 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id SagEUJ5LcKHS for <lttng-dev@lists.lttng.org>;
 Fri, 12 Dec 2014 15:45:18 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 814CE340043
 for <lttng-dev@lists.lttng.org>; Fri, 12 Dec 2014 15:45:18 +0000 (UTC)
In-Reply-To: <434161235.26685.1418399107964.JavaMail.zimbra@efficios.com>
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

Note: the stable-2.4 branch supports only Linux kernels up to 3.14. If
you need a newer kernel, you will need to move to LTTng 2.5.x or newer.

Changelog:
2014-12-12 LTTng modules 2.4.3
        * Fix: compaction instrumentation update for 3.14.x stable kernels
        * Fix: context alignment not properly handled
        * Check for stale version.h files
        * Fix: lttng-modules teardown NULL pointer OOPS
        * Fix: handle concurrent flush vs get_next_subbuf on metadata cache

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README.md files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
