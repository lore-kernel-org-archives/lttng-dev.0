From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.4.0-rc3
Date: Wed, 29 Jan 2014 17:05:29 +0000 (UTC)
Message-ID: <385831107.14904.1391015129684.JavaMail.zimbra__48163.2161107429$1391015287$gmane$org@efficios.com>
References: <78298069.14902.1391015112520.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1W8YZx-00075B-Uz
	for lttng-dev@lists.lttng.org; Wed, 29 Jan 2014 12:05:39 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 3F6E63400B4
	for <lttng-dev@lists.lttng.org>; Wed, 29 Jan 2014 17:05:32 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id 63ftMEWo21Vm for <lttng-dev@lists.lttng.org>;
	Wed, 29 Jan 2014 17:05:30 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id EBD873401F1
	for <lttng-dev@lists.lttng.org>; Wed, 29 Jan 2014 17:05:29 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id oM1Zi1f-lqEX for <lttng-dev@lists.lttng.org>;
	Wed, 29 Jan 2014 17:05:29 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
	by mail.efficios.com (Postfix) with ESMTP id C92953400CB
	for <lttng-dev@lists.lttng.org>; Wed, 29 Jan 2014 17:05:29 +0000 (UTC)
In-Reply-To: <78298069.14902.1391015112520.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
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
2014-01-29 LTTng modules 2.4.0-rc3
        * Fix: tracepoint event name mapping at unregister
        * Fix: tracepoint name remapping
        * Fix: enable event error path memory corruption
        * Update kvm instrumentation to Linux 3.13
        * Update sched instrumentation to Linux 3.13
        * Fix: provide more precise error report for enable event
        * Fix: quote event name in metadata
        * Add version info to lttng-tracer.ko modinfo

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
