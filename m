From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-tools 2.1.0-rc9
Date: Mon, 03 Dec 2012 15:17:31 -0500
Message-ID: <50BD08DB.6090002__25132.0457122803$1354565892$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TfcSN-0000S2-Uu
	for lttng-dev@lists.lttng.org; Mon, 03 Dec 2012 15:17:36 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id A6F4818739B
	for <lttng-dev@lists.lttng.org>; Mon,  3 Dec 2012 15:19:17 -0500 (EST)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id e7dBqcHIp3hP for <lttng-dev@lists.lttng.org>;
	Mon,  3 Dec 2012 15:19:15 -0500 (EST)
Received: from 127.0.0.1 (cable-13.246.173-198.electronicbox.net
	[173.246.13.198])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id E80F118738C
	for <lttng-dev@lists.lttng.org>; Mon,  3 Dec 2012 15:19:14 -0500 (EST)
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

Note that 2.1-stable should be released at some point this week
(hopefully). All major changes and features are now stable enough to
release. This will mark the ending of the 2.1 development cycle and
2.2.x will start after that. However, of course, 2.1.x will still be
supported! :)

Mostly minor bug fixes and documentation updates.

2012-12-03 lttng-tools 2.1.0-rc9
    * Fix: set the stream ht static in consumer file
    * Update sessiond man page with new env var
    * Update lttng.1 man page
    * Fix: enable-consumer for all domains missing dir
    * Fix: Add missing fct prototypes when disabling UST
    * Fix a typo in lttng-probe-module name
    * Assign values to enum lttcomm_sessiond_command
    * Fix: run health test only if root
    * Clarify empty string/NULL filter errors
    * Fix: add missing padding for UST filter

Please feel free to email the list about any questions/comments
concerning this release.

Using it is testing it!

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.1.0-rc9.tar.bz2 (for
the PGP signature, same file with .asc appended)

Cheers!
David
