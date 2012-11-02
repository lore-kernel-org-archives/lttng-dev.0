From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-tools 2.1.0-rc6
Date: Fri, 02 Nov 2012 11:55:03 -0400
Message-ID: <5093ECD7.5080805__10560.0308198065$1351871748$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TUJaL-0006tq-MK
	for lttng-dev@lists.lttng.org; Fri, 02 Nov 2012 11:55:05 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id B0577187342
	for <lttng-dev@lists.lttng.org>; Fri,  2 Nov 2012 11:55:36 -0400 (EDT)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QTgxkLgVukp8 for <lttng-dev@lists.lttng.org>;
	Fri,  2 Nov 2012 11:55:36 -0400 (EDT)
Received: from 127.0.0.1 (cable-13.246.173-198.electronicbox.net
	[173.246.13.198])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id BF8C418733E
	for <lttng-dev@lists.lttng.org>; Fri,  2 Nov 2012 11:55:35 -0400 (EDT)
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

The biggest changes was the lttng_data_available() API call renamed to
lttng_data_pending() with the returned code semantic changed. In a
nutshell, if data_pending returns 0, it means that all data was
extracted from the buffers of the tracing session hence the trace is
_ready_ to be read. Else, a value of 1 means that data is still pending
for the tracing session so the trace is not readable.

Apart from that, 30+ fixes got in mostly fixing memory leaks. Here is
the ChangeLog:

2012-11-02 lttng-tools 2.1.0-rc6
	* Tests: Add filtering tests for uncovered cases
	* Fix: Sync issue when deleting a data stream
	* Rename data_available to data_pending
	* Fix: consumer health state
	* Fix: Add the ACCOUNTING flag to ht creation and set bucket size to 0
	* Fix: Bad return error code handling
	* Fix: Use after free() of the rundir string
	* Fix: Cleanup UST app session on ustctl create session error
	* Fix: add missing pthread_join in sessiond
	* Fix: free running directory string
	* Fix: UST app clean list node usage
	* Add liblttng-ctl destructor to cleanup memory
	* Fix: Cleanup URIs on teardown
	* Fix: relayd memleaks
	* Fix: Memory leaks of allocated URIs
	* Fix: consumer output memory leak on creation
	* Fix: missing addrlen initialization before accept(2)
	* Fix: relayd trace file padding memleak
	* Fix: Remove useless consumer subdir string concatenation
	* Fix: lttng create allocated path memleak
	* Fix: Cppcheck memleakOnRealloc mistake
	* Fix: Synchronization issue for data available command
	* Fix: consumer relayd cleanup on disconnect
	* Fix: Handle the unary bitwise negation operator (~) in the XML printer
	* Fix: Possible memory leaks when creating filter IR root node
	* Fix: Delete stream on write error in consumer
	* Fix: Error handling when sending relayd sockets to consumer
	* Add stream lock comment for nesting
	* Fix: Mutex and RCU lock nesting in consumer
	* Fix: Uninitialized ret code
	* Fix: Remove bad condition and fix overflow issue
	* Fix: consumerd pthread error flow
	* Fix: Set a single return point and mutex unlock
	* Fix: Remove useless NULL and zero assignment
	* Fix: segfault on create session with two URLs

Please feel free to email the list about any questions/comments
concerning this release.

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.1.0-rc6.tar.bz2 (for
the PGP signature, same file with .asc appended)

Cheers!
David
