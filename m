From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-tools 2.1.1
Date: Fri, 11 Jan 2013 10:59:51 -0500
Message-ID: <50F036F7.5010305__48810.0552619018$1357920035$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Tth1R-0000GL-GF
	for lttng-dev@lists.lttng.org; Fri, 11 Jan 2013 10:59:57 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 40EBC18743A
	for <lttng-dev@lists.lttng.org>; Fri, 11 Jan 2013 11:03:05 -0500 (EST)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QqqX017R6Gcn for <lttng-dev@lists.lttng.org>;
	Fri, 11 Jan 2013 11:03:04 -0500 (EST)
Received: from 127.0.0.1 (cable-13.246.173-198.electronicbox.net
	[173.246.13.198])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id 490B1187439
	for <lttng-dev@lists.lttng.org>; Fri, 11 Jan 2013 11:03:04 -0500 (EST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Greetings everyone (including LTTng elves),

The lttng-tools project provides a session daemon (lttng-sessiond)
that acts as a tracing registry, the "lttng" command line for tracing
control, a lttng-ctl library for tracing control and a lttng-relayd
for network streaming.

Some important fixes went in for network streaming.

2013-01-11 lttng-tools 2.1.1
    * Fix: update next_net_seq_num after sending header
    * Fix: wrong loop continuation in metadata thread
    * Fix: lttng create session memleaks
    * Fix: remove unused session id map
    * Fix: wrong session id used on relayd lookup
    * Fix: add missing UST abi header for make dist
    * Fix: add missing rcu read side lock/unlock

Don't hesitate to report bugs on https://bugs.lttng.org or email us for
any comments and questions.

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.1.1.tar.bz2 (for
the PGP signature, same file with .asc appended)

Cheers!
David
