From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.4.0-rc1
Date: Fri, 15 Nov 2013 21:12:06 +0000 (UTC)
Message-ID: <1022030442.68961.1384549926154.JavaMail.zimbra__40460.8118733906$1384549986$gmane$org@efficios.com>
References: <1108250135.68957.1384549854147.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VhQgR-0005rK-Go
	for lttng-dev@lists.lttng.org; Fri, 15 Nov 2013 16:12:13 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 11A9034041F
	for <lttng-dev@lists.lttng.org>; Fri, 15 Nov 2013 21:12:08 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id txkKO5KiNWst for <lttng-dev@lists.lttng.org>;
	Fri, 15 Nov 2013 21:12:06 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 7A497340420
	for <lttng-dev@lists.lttng.org>; Fri, 15 Nov 2013 21:12:06 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id dAhuj7w6hjCT for <lttng-dev@lists.lttng.org>;
	Fri, 15 Nov 2013 21:12:06 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
	by mail.efficios.com (Postfix) with ESMTP id 5244634041F
	for <lttng-dev@lists.lttng.org>; Fri, 15 Nov 2013 21:12:06 +0000 (UTC)
In-Reply-To: <1108250135.68957.1384549854147.JavaMail.zimbra@efficios.com>
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

Major changes: live streaming support, index generation by consumerd support, 3.12 Linux kernel support.

Changelog:
2013-11-15 LTTng modules 2.4.0-rc1
        * Update ext4 instrumentation to Linux 3.12
        * Update RCU instrumentation to Linux 3.12
        * Update btrfs instrumentation to 3.12 kernel
        * Update vmscan instrumentation to Linux 3.12
        * update: kmem instrumentation 3.12 kernel support
        * lttng-statedump-impl: Use generic hard irqs for Linux >= 3.12
        * lttng-statedump-impl: Fix lttng_list_interrupts for empty implementation
        * Import fix from LTSI: 3.4+ RT kernels use CONFIG_PREEMPT_RT_FULL
        * Add new tracepoint in KVM
        * Blacklist kernels 3.10.13 and 3.11.2
        * LTTng trace-clock: shrink kernel blacklist
        * Metadata flush writes data from the cache
        * Per-stream ioctl to get the current timestamp
        * LTTng ringbuffer ABI calls for index generation
        * Prepare LTTng override of ring buffer fops
        * Blacklist Linux kernels 3.10+

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
