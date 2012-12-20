From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-tools 2.1.0
Date: Thu, 20 Dec 2012 14:34:42 -0500
Message-ID: <50D36852.3040506__1083.79585803977$1356032120$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TlltF-0002F8-5r
	for lttng-dev@lists.lttng.org; Thu, 20 Dec 2012 14:34:45 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id F189C1873E9
	for <lttng-dev@lists.lttng.org>; Thu, 20 Dec 2012 14:37:05 -0500 (EST)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Wm_hXnnl-w3e for <lttng-dev@lists.lttng.org>;
	Thu, 20 Dec 2012 14:37:05 -0500 (EST)
Received: from 127.0.0.1 (cable-13.246.173-198.electronicbox.net
	[173.246.13.198])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id 21256187393
	for <lttng-dev@lists.lttng.org>; Thu, 20 Dec 2012 14:37:05 -0500 (EST)
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

Greetings everyone (especially LTTng elves),

The lttng-tools project provides a session daemon (lttng-sessiond)
that acts as a tracing registry, the "lttng" command line for tracing
control, a lttng-ctl library for tracing control and a lttng-relayd
for network streaming.

This is for real!!! The 2.1.0 stable release is NOW out! Code name,
Basse Messe:

Light coloured German ale whose style was named after the city Cologne
(Koln) where it was first brewed. It is a rather simple beer with
lightly fruity aromas and a delicate hoppy fragrance. The beer has a
pronounced malty taste with a subtle bitter aftertaste

New features now:

* Network streaming.
Introduce the new lttng-relayd component used to receive the trace on a
remote host. For this, we've added the new lttng enable-consumer command
that allow the user to control the consumer destination of the session
(disk or network). The lttng_set_consumer_url() API call is added with
enable_consumer and disable_consumer as well.

* Filtering for UST
A --filter has been added to lttng enable-event command and a new
lttng_enable_event_with_filter() API call.

* Data pending
Now, by default, the stop command waits for the data traced to be
written completely on disk or over the network before returning. This
means that right after the command returns, you are assured that the
data is available for any viewer. This can be override by --no-wait or
by using the lttng_stop_session_no_wait. Also we've added the
lttng_data_pending() API call.

* Health check
Using lttng_health_check() with the right health component (see
lttng.h), you can now monitor the health of the session daemon for most
of its subsystems. See lttng-health-check(3) for more information.

This version concludes more than a year of development which introduce
very exciting set of features. As usual here is the changelog:

2012-12-20 lttng-tools 2.1.0 (13th Baktun)
        * STABLE VERSION 2.1.0-stable - "Basse Messe"
        * Multiple minor fixes
        * Multiple memory and fd leaks
        * Fix: Off by one in seq num for data pending command
        * Fix: flag metadata stream on quiescent control cmd
        * Fix: prioritize control socket communication in relayd
        * Fix: poll and epoll fd set reallocation
        * Fix: add missing goto pending if data is inflight
        * Fix: remove ua_sess->started assert on stop trace
        * Set classes of traffic in high_throughput_limit
        * Fix: use the poll wait ret value when iterating on fd(s)
        * Fix: force the poll() return value to be nb_fd
        * Fix: Wrong check of node when cleaning up ht
        * Fix: set started flag of ust app after ustctl
        * Fix: memory leak in add relayd socket error path
        * Fix: add packed attribute to filter structure
        * Fix: Add missing health code update for consumer command
        * Add LTTNG_PACKED macro
        * Fix data pending for inflight streaming
        * Map session id of relayd and sessiond in consumer
        * Add the relayd create session command
        * Make the consumer sends a ACK after each command
        * Remove MSG_WAITALL on every recvmsg() socket typ
        * Fix: Add missing relayd ht cleanup and ht destroy
        * Fix: Relayd and sessiond version check
        * Fix: protect consumer_find_channel with rcu locking
        * Fix: don't steal key when adding a metadata stream
        * Consumer hold stream mutex for add stream<

Thanks to everyone that made possible this version!

Don't hesitate to report bugs on bugs.lttng.org or email us for any
comments and questions.

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.1.0.tar.bz2 (for
the PGP signature, same file with .asc appended)

Cheers!
David
