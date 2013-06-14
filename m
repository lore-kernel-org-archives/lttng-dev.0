From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Simple and fast memleak finder
Date: Fri, 14 Jun 2013 17:16:26 -0400
Message-ID: <20130614211626.GA31790__17920.6769018949$1371244620$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UnbMB-0007Kx-S3
	for lttng-dev@lists.lttng.org; Fri, 14 Jun 2013 17:16:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id AB5D414025D
	for <lttng-dev@lists.lttng.org>; Fri, 14 Jun 2013 17:16:27 -0400 (EDT)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id A6gExervFcf5 for <lttng-dev@lists.lttng.org>;
	Fri, 14 Jun 2013 17:16:26 -0400 (EDT)
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

Hi,

A few words to let you know that I just created a simple, yet efficient,
memory leak finder library: memleak-finder.so. It's been useful to find
some nasty memory leaks in the current LTTng development cycle, and it's
generic enough to be used by other projects. It can pinpoint memory
leaks that can only be reproduced in stress-tests, where valgrind has
too much overhead.

Example output:

[leak] ptr: 0x18b2350 size: 0x160 caller: 0x7fae7943e28f <symbol>

There is also another very simple shared object (malloc-stats.so) that
will print the malloc_stats(3) of a program when receiving SIGUSR2, for
instance:

Arena 0:
system bytes     =     135168
in use bytes     =      19360
Total (incl. mmap):
system bytes     =     135168
in use bytes     =      19360
max mmap regions =          0
max mmap bytes   =          0

The code is available at:
git://github.com/efficios/memleak-finder.git

See the README file for more info.

Enjoy!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
