From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng Tools 2.3.0-rc2
Date: Fri, 19 Jul 2013 18:54:36 -0400
Message-ID: <20130719225436.GA2488__44466.3281007253$1374274532$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V0JZN-0008LU-Gc
	for lttng-dev@lists.lttng.org; Fri, 19 Jul 2013 18:54:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id 3FE78140D90
	for <lttng-dev@lists.lttng.org>; Fri, 19 Jul 2013 18:54:37 -0400 (EDT)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id qtoHfqPuJTYm for <lttng-dev@lists.lttng.org>;
	Fri, 19 Jul 2013 18:54:36 -0400 (EDT)
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

The lttng-tools project provides a session daemon (lttng-sessiond)
that acts as a tracing registry, the "lttng" command line for tracing
control, a lttng-ctl library for tracing control and a lttng-relayd
for network streaming.

Since David Goulet is currently on vacation, I'm acting as backup
maintainer for lttng-tools.

For this rc2 version, you will be pleased to find a complete cleanup of
the lttng(1) manpage layout. We have also fixed a couple of races that
were affecting the behavior of the data_pending check, used to make sure
traces are written to disk before the stop operation returns.

We have also added an example coredump handler that shows how to hook
flight recorder snapshots on application core dumps. See:

  extras/core-handler/README


Changelog:
2013-07-19 lttng-tools 2.3.0-rc2
        * Add core-handler README to dist tarball
        * extras: core-handler: simplify, allow usage from tracing group
        * Cleanup: add missing dot
        * Fix: documentation: create name and options
        * Add core dump snapshot handler script
        * Fix: sym name len (kernel)
        * Fix: tests: provide channel name when a non-default channel exists: per-pid
        * Fix: tests: provide channel name when a non-default channel exists
        * Fix: data pending race
        * Fix hang in make check snapshots/test_ust
        * Cleanup: ust-consumer: wrong indentation
        * Fix: print dots while waiting for data availability
        * Fix: remove sleep(1) added by "Fix: (slight UI change) refuse missing -c if non-default channel exists"
        * Fix: (slight UI change) refuse missing -c if non-default channel exists
        * Fix: push metadata on stop for per-UID buffers
        * README: update python documentation
        * Manpage: other layout cleanups
        * Manpage: cleanup layout of view
        * Manpage: cleanup layout of version
        * Manpage: cleanup layout of stop
        * Manpage: cleanup layout of start
        * Manpage: cleanup layout of snapshot
        * Manpage: cleanup layout of set-session
        * Manpage: cleanup layout of list
        * Manpage: cleanup layout of disable-event
        * Manpage: cleanup layout of disable-channel
        * Manpage: cleanup layout of enable-event
        * Manpage: cleanup layout of enable-channel
        * Manpage: cleanup layout of destroy
        * Manpage: cleanup layout of create
        * Manpage: cleanup layout of calibrate
        * Manpage: cleanup layout of add-context
        * Documentation: create --snapshot in manpage


Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
