From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.3.5
Date: Fri, 28 Feb 2014 17:56:12 +0000 (UTC)
Message-ID: <887267261.32325.1393610172798.JavaMail.zimbra__29709.5282738612$1393610232$gmane$org@efficios.com>
References: <971876077.32324.1393610161793.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WJRfR-0006LD-8y
	for lttng-dev@lists.lttng.org; Fri, 28 Feb 2014 12:56:18 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 7D29D340247
	for <lttng-dev@lists.lttng.org>; Fri, 28 Feb 2014 17:56:14 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id ybYsACcgGRjS for <lttng-dev@lists.lttng.org>;
	Fri, 28 Feb 2014 17:56:13 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 27832340275
	for <lttng-dev@lists.lttng.org>; Fri, 28 Feb 2014 17:56:13 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id eQ5ftpevNwof for <lttng-dev@lists.lttng.org>;
	Fri, 28 Feb 2014 17:56:13 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
	by mail.efficios.com (Postfix) with ESMTP id EC8A5340247
	for <lttng-dev@lists.lttng.org>; Fri, 28 Feb 2014 17:56:12 +0000 (UTC)
In-Reply-To: <971876077.32324.1393610161793.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
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
2014-02-28 LTTng modules 2.3.5
        * Fix: load state dump even if work-around lookup fails
        * Cleanup: fix comment
        * Fix: correctly version kvm events to build against v3.0 kernel
        * Fix: Add statedump exit so module is not permanent
        * Fix: OOT lttng-statedump tracepoints not visible with signed kernels
        * Fix: tracepoint event name mapping at unregister
        * Fix: tracepoint name remapping
        * Fix: enable event error path memory corruption
        * Update kvm instrumentation to Linux 3.13
        * Update sched instrumentation to Linux 3.13
        * Fix: provide more precise error report for enable event
        * Fix: quote event name in metadata

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
