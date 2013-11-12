From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.3.3
Date: Tue, 12 Nov 2013 17:31:20 +0000 (UTC)
Message-ID: <1018693349.65250.1384277480244.JavaMail.zimbra__26745.8942289979$1384277793$gmane$org@efficios.com>
References: <879286490.65249.1384277470478.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VgHo9-0000C2-QH
	for lttng-dev@lists.lttng.org; Tue, 12 Nov 2013 12:31:27 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id F29C1340104
	for <lttng-dev@lists.lttng.org>; Tue, 12 Nov 2013 17:31:21 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id tw9_wZRicC5L for <lttng-dev@lists.lttng.org>;
	Tue, 12 Nov 2013 17:31:20 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 955AC340239
	for <lttng-dev@lists.lttng.org>; Tue, 12 Nov 2013 17:31:20 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id VuVXZvr0-NYS for <lttng-dev@lists.lttng.org>;
	Tue, 12 Nov 2013 17:31:20 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
	by mail.efficios.com (Postfix) with ESMTP id 70F75340104
	for <lttng-dev@lists.lttng.org>; Tue, 12 Nov 2013 17:31:20 +0000 (UTC)
In-Reply-To: <879286490.65249.1384277470478.JavaMail.zimbra@efficios.com>
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
2013-11-12 LTTng modules 2.3.3
        * Update ext4 instrumentation to Linux 3.12
        * Update RCU instrumentation to Linux 3.12
        * Update btrfs instrumentation to 3.12 kernel
        * Update vmscan instrumentation to Linux 3.12
        * update: kmem instrumentation 3.12 kernel support
        * lttng-statedump-impl: Use generic hard irqs for Linux >= 3.12
        * lttng-statedump-impl: Fix lttng_list_interrupts for empty implementation
        * Import fix from LTSI: 3.4+ RT kernels use CONFIG_PREEMPT_RT_FULL

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
