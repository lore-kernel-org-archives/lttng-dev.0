From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.1.2
Date: Tue, 18 Jun 2013 21:00:15 -0400
Message-ID: <20130619010015.GA20259__17296.8032457449$1371603648$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Up6ky-0001YG-Qw
	for lttng-dev@lists.lttng.org; Tue, 18 Jun 2013 21:00:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id A44D7141819
	for <lttng-dev@lists.lttng.org>; Tue, 18 Jun 2013 21:00:16 -0400 (EDT)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id 3ZW+jo1TrYW8 for <lttng-dev@lists.lttng.org>;
	Tue, 18 Jun 2013 21:00:15 -0400 (EDT)
Content-Disposition: inline
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
2013-06-18 LTTng modules 2.1.2
        * Fix build and load against linux-2.6.33.x
        * fix block instrumentation probe signature mismatch for 3.9.x kernels
        * fix: block instrumentation: NULL pointer dereference
        * Fix: 3.9.0 block layer instrumentation build
        * block: update instrumentation to 3.9 rc kernel
        * Backport block-related changes from "Update kernel probes to
          more detailed match to kernel versions"
        * Fix: warning kvm_trace_exit_reason redefined for 3.9 kernel
        * Fix 3.8 kernel support: namespace lttng_is_signed_type()
        * lttng-module: sched.h: Fix compilation on 3.9 kernel
        * Fix: don't flush-final for offset 0 if reader is on sub-buffer

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
