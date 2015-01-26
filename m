From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.4.4 (EOL)
Date: Mon, 26 Jan 2015 20:28:34 +0000 (UTC)
Message-ID: <1008409158.53226.1422304114796.JavaMail.zimbra__16030.3166638643$1422304142$gmane$org@efficios.com>
References: <1811350620.53216.1422304062630.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YFqGw-0006mZ-37
 for lttng-dev@lists.lttng.org; Mon, 26 Jan 2015 15:28:35 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B43343400F9
 for <lttng-dev@lists.lttng.org>; Mon, 26 Jan 2015 20:28:35 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 6EmTIGVL4NuM for <lttng-dev@lists.lttng.org>;
 Mon, 26 Jan 2015 20:28:35 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 1C1B3340122
 for <lttng-dev@lists.lttng.org>; Mon, 26 Jan 2015 20:28:35 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id FhiaygunA9_z for <lttng-dev@lists.lttng.org>;
 Mon, 26 Jan 2015 20:28:35 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id EE6A83400F9
 for <lttng-dev@lists.lttng.org>; Mon, 26 Jan 2015 20:28:34 +0000 (UTC)
In-Reply-To: <1811350620.53216.1422304062630.JavaMail.zimbra@efficios.com>
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

This is the last bugfix release of the stable-2.4 lttng-modules branch.
This branch has now reached end of life.

Changelog:

2015-01-26 LTTng modules 2.4.4
        * Fix: missing parenthesis in offset_align_floor
        * Fix compile error on kernel 3.0.101 with CONFIG_PERF_EVENTS
        * Conditional compilation introduced by lttng-modules commit

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
