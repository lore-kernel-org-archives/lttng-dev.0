From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-tools 2.0.5 stable
Date: Wed, 28 Nov 2012 11:33:34 -0500
Message-ID: <50B63CDE.5090108__45871.9495371499$1354120468$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TdkZu-0003Y5-0e
	for lttng-dev@lists.lttng.org; Wed, 28 Nov 2012 11:33:38 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 2BE61187391
	for <lttng-dev@lists.lttng.org>; Wed, 28 Nov 2012 11:35:07 -0500 (EST)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TsZhn6OWpYKX for <lttng-dev@lists.lttng.org>;
	Wed, 28 Nov 2012 11:35:06 -0500 (EST)
Received: from 127.0.0.1 (cable-13.246.173-198.electronicbox.net
	[173.246.13.198])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id 6557018714A
	for <lttng-dev@lists.lttng.org>; Wed, 28 Nov 2012 11:35:06 -0500 (EST)
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

This is a the release of lttng-tools 2.0.5 stable.

The lttng-tools project provides a session daemon (lttng-sessiond)
that acts as a tracing registry, the "lttng" command line for tracing
control, a lttng-ctl library for tracing control and a lttng-relayd
for network streaming.

Here is the full Changelog.

2012-11-28 lttng-tools 2.0.5
        * Fix: Change the type of enabled in lttng_event to a signed int
        * Fix: Returned code when listing kernel channel
        * Fix: Wrong returned error code on UST enable event
        * Fix: consumer recv command error path
        * Fix: Missing libs dependencies in configure check for
lttng-ust-ctl
        * Fix: Libtool fails to find dependent lib when cross-compiling


Please feel free to email the list about any questions/comments
concerning this release.

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.0.5.tar.bz2 (for
the PGP signature, same file with .asc appended)

Cheers!
David
