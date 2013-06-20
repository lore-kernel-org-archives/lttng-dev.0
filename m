From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng Tools 2.2.0-rc3 (Cuda)
Date: Thu, 20 Jun 2013 14:48:28 -0400
Message-ID: <51C34E7C.8030305__44066.4762318649$1371754150$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UpjuN-0003Vp-Tg
	for lttng-dev@lists.lttng.org; Thu, 20 Jun 2013 14:48:36 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id BD190A1DA0
	for <lttng-dev@lists.lttng.org>; Thu, 20 Jun 2013 18:48:26 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id j6XVjnEFq2MQ for <lttng-dev@lists.lttng.org>;
	Thu, 20 Jun 2013 18:48:26 +0000 (UTC)
Received: from 127.0.0.1 (unknown [96.127.207.22])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id DE3B9A1D9C
	for <lttng-dev@lists.lttng.org>; Thu, 20 Jun 2013 18:48:25 +0000 (UTC)
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

Here is the release candidate 3 and hopefully the last one before the final release.

2013-06-20 lttng-tools 2.2.0-rc3
    * Multiple memory and fd leak fixes in sessiond and consumerd
    * Test: stress test added to the repository but not in make check
    * Using LTTNG_HOME environment variable if exists, with fallback to HOME
    * Implement health check for app registration dispatch
    * Implement health check for app notification thread
    * Revert "Improve channel listing output format"
    * Fix: use lttng pipe to send new stream to thread
    * Change consumer_metadata_pipe to be a lttng_pipe
    * Change consumer_data_pipe to be a lttng_pipe
    * Add wrappers for pipe
    * Add --version command-line option to lttng.
    * Add --with-lttng-ust-prefix config option.
    * Fixes from coverity scan.
    * Stability fixes
    * RCU hash table are now destroyed in a seperate thread in sessiond

Please feel free to email the list about any questions/comments
concerning this release. For bugs or missing documentations, use
bugs.lttng.org!

Using it is testing it!

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.2.0-rc3.tar.bz2 (for
the PGP signature, same file with .asc appended)

Thanks to all! Cheers!
David
