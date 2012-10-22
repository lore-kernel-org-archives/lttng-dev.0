From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-tools 2.1.0-rc5
Date: Mon, 22 Oct 2012 13:06:12 -0400
Message-ID: <50857D04.10705__2301.72023079849$1350925615$gmane$org@efficios.com>
References: <502EA58E.2060003@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TQLSC-00051e-D9
	for lttng-dev@lists.lttng.org; Mon, 22 Oct 2012 13:06:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id C12D61872FD
	for <lttng-dev@lists.lttng.org>; Mon, 22 Oct 2012 13:06:21 -0400 (EDT)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xJZ7H_z6gX80 for <lttng-dev@lists.lttng.org>;
	Mon, 22 Oct 2012 13:06:21 -0400 (EDT)
Received: from 127.0.0.1 (cable-13.246.173-198.electronicbox.net
	[173.246.13.198])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id A8668187251
	for <lttng-dev@lists.lttng.org>; Mon, 22 Oct 2012 13:06:20 -0400 (EDT)
In-Reply-To: <502EA58E.2060003@efficios.com>
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

This release candidate version contains a lot of fixes and especially
one that fix the lttng_stop_tracing() behavior by adding a new call to
the API (lttng.h).

Here goes. The lttng_stop_tracing() API call, once it returns, there was
suppose to be a guarantee that the tracing data is available for
processing i.e. that any viewer/reader could parse the trace files
without any problem or missing data. We've fixed that with a new API
call, lttng_data_available(). It returns 1 if the data is ready to be
read for a tracing session (for every domain) or else 0. We've added
this call to lttng_stop_tracing() in order for this call to return
*only* if the condition is true (1). It changes the old behavior since
now the stop tracing call can wait an arbitrary amount of time.

Note that, for now, lttng_data_available is called every 2usec on the
client side (liblttng-ctl). So, this call does NOT block nor makes the
session daemon wait for data availability.

We've also added the lttng_stop_tracing_no_wait() that behaves *exactly*
like lttng_stop_tracing() but will NOT wait for data availability.

This is of course integrated in lttng command line and works for both
local consumer (on the file system) or network streaming. For the lttng
UI to _not_ wait when stopping a session, the --no-wait option was added
to "lttng stop".

Here is an example of the expected output of the command line. Each dot
"." is a 2usec period of time.

$ lttng stop mysession
Waiting for data availability....
Tracing stopped for session mysession

We know that this is a big addition to the RC process of lttng-tools but
the data availability on stop tracing is a *very* important aspect of
the lttng tool chain hence fixing it before the stable version
especially with the network streaming support.

Apart from that, here is the ChangeLog for 2.1.0-rc5 which contains a
lot of fixes and tests.

2012-10-22 lttng-tools 2.1.0-rc5
        * Fix: Remove network stream ID ABI calls
        * Tests: Add filtering tests
        * Wait for data availability when stopping a session
        * Relayd data available command support
        * Lib lttng-ctl data available command support
        * Consumer daemon data available command support
        * Add data structure for the data available command
        * Change the metadata hash table node
        * Make stream hash tables global to the consumer
        * Move add data stream to the data thread
        * Rename consumer threads and spawn them in daemon
        * Fix: relayd close stream command was not working
        * Fix: Relayd and consumerd socket leaks
        * Fix: Missing -ENODATA handling in the consumer
        * Fix: Empty metadata buffer(s) on HUP|ERR
        * ABI with support for compat 32/64 bits
        * Fix: Stream allocation and insertion consistency
        * Fix: output number of bytes written by relayd
        * Add hash table argument to helper functions
        * Fix: Add missing call rcu and read side lock
        * Tests: Fix LD_PRELOAD library lookup path for health tests
        * Fix: Add arbitrary wait period for kernel streaming test
        * Fix coding style and add/change debug statements
        * Fix: Build out of src tree
        * Tests: Add health check tests to configure
        * Tests: Add health check thread stall test
        * Tests: Add health check thread exit test
        * Tests: Add a health check utility program
        * Add testpoints in lttng-sessiond for each threads
        * New testpoint mechanism to instrument binaries for testing
        * Fix: off-by-one in comm proto between lttng-ctl and sessiond
        * Fix: Metadata stream leak when received in consumer
        * Fix: consumer_allocate_stream error handling
        * Fix: consumer should await for initial streams
        * Fix: Missing rcu read side lock in consumer

Please feel free to email the list about any questions/comments
concerning this release.

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.1.0-rc5.tar.bz2 (for
the PGP signature, same file with .asc appended)

Cheers!
David

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
