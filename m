From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng Tools 2.2.3
Date: Tue, 23 Jul 2013 10:22:44 -0400
Message-ID: <20130723142244.GA17103__10372.4339431666$1374589432$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V1dUF-0005te-KI
	for lttng-dev@lists.lttng.org; Tue, 23 Jul 2013 10:22:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id 526AA1403AA
	for <lttng-dev@lists.lttng.org>; Tue, 23 Jul 2013 10:22:45 -0400 (EDT)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id vejRFwLfNFyZ for <lttng-dev@lists.lttng.org>;
	Tue, 23 Jul 2013 10:22:44 -0400 (EDT)
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

Changelog:
2013-07-23 lttng-tools 2.2.3
        * test: test_periodical_metadata_flush shrink timer period, kill app
        * Fix: format string type mismatch
        * Fix: tests: provide channel name when a non-default channel exists: per-pid
        * Fix: tests: provide channel name when a non-default channel exists
        * Fix: data pending race
        * Cleanup: ust-consumer: wrong indentation
        * Fix: print dots while waiting for data availability
        * Fix: push metadata on stop for per-UID buffers

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
