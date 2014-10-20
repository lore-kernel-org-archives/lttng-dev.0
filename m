From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.5.1
Date: Mon, 20 Oct 2014 21:16:26 +0000 (UTC)
Message-ID: <67314013.12448.1413839786147.JavaMail.zimbra__29001.9101849341$1413839951$gmane$org@efficios.com>
References: <171237392.12447.1413839767387.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XgKJi-0006aW-H7
 for lttng-dev@lists.lttng.org; Mon, 20 Oct 2014 17:16:44 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5B201340309
 for <lttng-dev@lists.lttng.org>; Mon, 20 Oct 2014 21:16:32 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id KNWiT10ndSMG for <lttng-dev@lists.lttng.org>;
 Mon, 20 Oct 2014 21:16:28 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 1A31734031B
 for <lttng-dev@lists.lttng.org>; Mon, 20 Oct 2014 21:16:28 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 5xwOrE3E-c9t for <lttng-dev@lists.lttng.org>;
 Mon, 20 Oct 2014 21:16:27 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 066C8340309
 for <lttng-dev@lists.lttng.org>; Mon, 20 Oct 2014 21:16:27 +0000 (UTC)
In-Reply-To: <171237392.12447.1413839767387.JavaMail.zimbra@efficios.com>
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
2014-10-20 LTTng modules 2.5.1
        * Print build warning when writeback probe is disabled
        * Fix compilation on Ubuntu 14.10
        * Fix: compile lttng_statedump_process_ns on Ubuntu
        * Reverse version check logic in lttng_statedump_process_ns
        * Update statedump to 3.17 nsproxy locking
        * Fix block_rq_complete TP on Ubuntu kernel
        * Introduce macros to check Ubuntu kernel version
        * asoc.h: fix build with v3.17 kernel
        * Add atomic.h wrapper for before/after atomic
        * Update vmscan instrumentation to 3.16 kernel
        * Update compaction instrumentation to 3.16 kernel
        * Check for stale version.h files
        * Fix: statedump: close_on_exec flag backward compat
        * Fix: lttng-modules teardown NULL pointer OOPS
        * Fix: handle concurrent flush vs get_next_subbuf on metadata cache
        * Fix: OOT lttng_logger tracepoint not visible with signed kernels

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
