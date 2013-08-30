From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.2.4 stable
Date: Fri, 30 Aug 2013 15:06:33 -0400
Message-ID: <20130830190633.GA26151__28029.7377882109$1377889772$gmane$org@ev0ke.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VFU2U-0006Jw-Ld
	for lttng-dev@lists.lttng.org; Fri, 30 Aug 2013 15:07:28 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 19DB0A1DC5
	for <lttng-dev@lists.lttng.org>; Fri, 30 Aug 2013 19:06:20 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id M5anyFMRZMAz for <lttng-dev@lists.lttng.org>;
	Fri, 30 Aug 2013 19:06:19 +0000 (UTC)
Received: from ev0ke.net (cable-10.246.173-146.electronicbox.net
	[173.246.10.146])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id 049A8A1D9C
	for <lttng-dev@lists.lttng.org>; Fri, 30 Aug 2013 19:06:18 +0000 (UTC)
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Greetings everyone (including LTTng elves),

The lttng-tools project provides a session daemon (lttng-sessiond) that
acts as a tracing registry, the "lttng" command line for tracing
control, a lttng-ctl library for tracing control and a lttng-relayd for
network streaming.

2013-08-30 lttng-tools 2.2.4
	* Fix: hashtable: take split_count_order into account
	* Fix: remove wrong doing asserts in sessiond
	* Fix: delete the trace directory used for the test
	* Fix: remove bad check after epoll wait in consumer
	* Fix: consumer data pending for empty streams
	* Fix: hash table growth (for small tables) should be limited (v2)
	* Fix: run_as gid/uid test should return result to parent
	* Fix: remove health test from fast regression
	* Fix: set the health delta tcp timeout aware
	* Get the maximum TCP timeout in sessiond
	* Fix: don't report error if UST app dies
	* Fix: improve error message when UST support is disabled
	* Fix: remove calibrate syscall option from code
	* Fix: check UST float field mantissa length
	* Fix: add UST context in the same order the user enabled them
	* Prepare for automake deprecation of missing subdir-objects
	* Fix: channels can be _enabled_ after tracing is started, but not created
	* Fix filter parser segmentation fault with bison 3.0
	* Fix: typo in error msg
	* Fix: imprecise error message about root sessiond/tracing group
	* Fix: LTTNG_ERR_NEED_ROOT_SESSIOND error message
	* Fix: don't skip chmod if tracing group is not found
	* Tracepoint probes don't need extern C
	* Fix: reset out_fd_offset when we rotate the trace file
	* Fix: kernel ctl error codes are based on errno

Using it is testing it!

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.2.4.tar.bz2 (for
the PGP signature, same file with .asc appended)

Cheers!
David
