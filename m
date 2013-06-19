From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.2.0-rc3
Date: Tue, 18 Jun 2013 21:33:25 -0400
Message-ID: <20130619013325.GA21560__1654.82327943227$1371605637$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Up7H4-0001rk-Rs
	for lttng-dev@lists.lttng.org; Tue, 18 Jun 2013 21:33:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id 9EA93141819
	for <lttng-dev@lists.lttng.org>; Tue, 18 Jun 2013 21:33:26 -0400 (EDT)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id nonQDMEmr0EX for <lttng-dev@lists.lttng.org>;
	Tue, 18 Jun 2013 21:33:25 -0400 (EDT)
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
2013-03-29 LTTng modules 2.2.0-rc3
        * Fix CPU hotplug section mismatches
        * Fix build and load against linux-2.6.33.x
        * fix block instrumentation probe signature mismatch for 3.9.x kernels
        * fix: block instrumentation: NULL pointer dereference
        * Update rcu instrumentation to 3.9.[0-4]
        * Remove bashism in lttng-syscalls-generate-headers.sh

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
