From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-tools 2.1.0-rc7
Date: Tue, 13 Nov 2012 14:00:30 -0500
Message-ID: <50A298CE.30301__44828.198318328$1352833279$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TYLir-0000ha-5Q
	for lttng-dev@lists.lttng.org; Tue, 13 Nov 2012 14:00:33 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 9ED56187385
	for <lttng-dev@lists.lttng.org>; Tue, 13 Nov 2012 14:01:28 -0500 (EST)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1HBqFCuTKNHh for <lttng-dev@lists.lttng.org>;
	Tue, 13 Nov 2012 14:01:28 -0500 (EST)
Received: from 127.0.0.1 (cable-13.246.173-198.electronicbox.net
	[173.246.13.198])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id F0C9C18737F
	for <lttng-dev@lists.lttng.org>; Tue, 13 Nov 2012 14:01:27 -0500 (EST)
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

Please note that this is the release candidate 7 and we are currently
fixing the last bugs and updating the documentation for the stable
version. I think we might have two or three other RCs before the
official stable in a few days!

Here is the Changelog. This is mostly fixes from the bug tracker and
other encountered issues during that time.

2012-11-13 lttng-tools 2.1.0-rc7
    * Fix: Add pointer check when freeing poll events
    * Fix: FD leak on thread error
    * Fix: Wrong fd used by kernel_wait_quiescent
    * Support new lttng-ust error code
    * Fix: Don't set filter if enable event fails
    * Fix: Wrong data port when listing session
    * Fix: Enable event after start command
    * Fix: Teardown of thread_manage_clients on failure of
listen/create_poll
    * Add a timeout to UST application socket
    * Fix: Consumerd error socket connect race
    * Fix: Set CLOEXEC flag on every created sockets
    * Remove consumer poll timeout in data thread
    * Fix: RCU hash table seed
    * Fix: Do not install health tests helper libraries
    * Fix: Create default channel on add-context if none
    * Support new liblttng-ust-ctl error code
    * Fix: Add EPIPE error handling on buffer splice
    * Fix: Channel creation error return code was not set
    * Fix: Wrong poll events on UST application socket
    * Fix: Remove dependency to urcu-cds in tools tests
    * Fix: Missing librt dependency in configure check for lttng-ust-ctl
    * Fix: Don't append datetime to default session name
    * Fix: Deny session creation name 'auto'
    * Fix: Add space for stream name CPU number
    * Fix: Add output option to enable-channel command


Please feel free to email the list about any questions/comments
concerning this release.

Using it is testing it! :)

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.1.0-rc7.tar.bz2 (for
the PGP signature, same file with .asc appended)

Cheers!
David
