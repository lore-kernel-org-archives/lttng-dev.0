From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.3.1
Date: Fri, 20 Sep 2013 15:01:15 -0400
Message-ID: <20130920190115.GA23578__13471.2929292165$1379703741$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VN5x8-0002p1-0z
	for lttng-dev@lists.lttng.org; Fri, 20 Sep 2013 15:01:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id D5A09140008
	for <lttng-dev@lists.lttng.org>; Fri, 20 Sep 2013 15:01:17 -0400 (EDT)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id oWJaGqaLg7kK for <lttng-dev@lists.lttng.org>;
	Fri, 20 Sep 2013 15:01:15 -0400 (EDT)
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

The important change from 2.3.0 to 2.3.1 is that kernel versions in
these ranges:

- 3.10.0 to 3.10.12 (inclusive)
- 3.11.0 to 3.11.1  (inclusive)

are blacklisted to ensure lttng-modules is not compiled against a buggy
kernel which can lead to hard system lockup when enabling LTTng tracing
of some subsystems, including but not limited to workqueues. This Linux
bug is timekeeper related. See latest lttng-modules commits for details.

Changelog:
2013-09-20 LTTng modules 2.3.1
        * LTTng trace-clock: shrink kernel blacklist
        * Blacklist Linux kernels 3.10+

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
