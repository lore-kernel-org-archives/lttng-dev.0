From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.5.3
Date: Mon, 26 Jan 2015 20:14:51 +0000 (UTC)
Message-ID: <1068342351.53174.1422303291287.JavaMail.zimbra__22706.458104267$1422303322$gmane$org@efficios.com>
References: <211775457.53173.1422303274922.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YFq3e-0006fF-Gk
 for lttng-dev@lists.lttng.org; Mon, 26 Jan 2015 15:14:51 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 2FCD2340292
 for <lttng-dev@lists.lttng.org>; Mon, 26 Jan 2015 20:14:52 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id uKvtVVq5TrtA for <lttng-dev@lists.lttng.org>;
 Mon, 26 Jan 2015 20:14:51 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9E6F1340298
 for <lttng-dev@lists.lttng.org>; Mon, 26 Jan 2015 20:14:51 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id LrRnkqAUbAzp for <lttng-dev@lists.lttng.org>;
 Mon, 26 Jan 2015 20:14:51 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 858AE340292
 for <lttng-dev@lists.lttng.org>; Mon, 26 Jan 2015 20:14:51 +0000 (UTC)
In-Reply-To: <211775457.53173.1422303274922.JavaMail.zimbra@efficios.com>
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

This is a bugfix release.

Changelog:

2015-01-26 LTTng modules 2.5.3
        * Fix: missing parenthesis in offset_align_floor
        * Fix: implement time.h wrapper for FD_ISSET
        * Fix compile error on kernel 3.0.101 with CONFIG_PERF_EVENTS
        * Conditional compilation introduced by lttng-modules commit

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
