From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.2.0-rc2
Date: Thu, 9 May 2013 09:05:05 -0400
Message-ID: <20130509130505.GA26208__48875.1808683903$1368106303$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UaQWw-0008Ka-8u
	for lttng-dev@lists.lttng.org; Thu, 09 May 2013 09:05:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id 1575714059E
	for <lttng-dev@lists.lttng.org>; Thu,  9 May 2013 09:05:06 -0400 (EDT)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id S9B9LhXnO7en for <lttng-dev@lists.lttng.org>;
	Thu,  9 May 2013 09:05:05 -0400 (EDT)
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
2013-05-09 LTTng modules 2.2.0-rc2
        * Remove useless lttng_metadata probe
        * Fix: warning kvm_trace_exit_reason redefined for 3.9 kernel
        * Fix: 3.9.0 block layer instrumentation build
        * Revert "Stop build if CONFIG_TRACEPOINTS is not set"
        * Stop build if CONFIG_TRACEPOINTS is not set
        * Add comments to endifs.
        * Fix: remove ARM set_tls system call override
        * Cleanup: arm sys_mmap whitespace
        * Clean up using global_dirty_limit wrapper for writeback probe

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
