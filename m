From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng Tools 2.2.0 - Cuda (STABLE)
Date: Tue, 25 Jun 2013 17:37:57 -0400
Message-ID: <51CA0DB5.2050801__30997.2255178311$1372196319$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UrawA-0004yq-1G
	for lttng-dev@lists.lttng.org; Tue, 25 Jun 2013 17:38:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 11606A1DA0
	for <lttng-dev@lists.lttng.org>; Tue, 25 Jun 2013 21:37:56 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Lw_jX92fwNZy for <lttng-dev@lists.lttng.org>;
	Tue, 25 Jun 2013 21:37:54 +0000 (UTC)
Received: from 127.0.0.1 (unknown [96.127.207.22])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id F00A7A1D9C
	for <lttng-dev@lists.lttng.org>; Tue, 25 Jun 2013 21:37:53 +0000 (UTC)
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

This is the 2.2 stable release. Three main things were added being the per UID
buffers for UST, the periodical flush for metadata and the trace file rotation.

Per UID buffers makes every application sharing the same UID to use the same
buffers.

$ lttng create
$ lttng enable-channel chan1 -u --buffers-uid
...

The periodical flush for metadata is also added like so:

$ lttng enable-channel metadata --switch-timer 200000 -u

Also, the buffers for UST application are now created in the consumer
and passed to the application. Thus, the buffer ownership has been
transfered from the UST tracer to the consumer.

Finally, the new feature worth noting is the trace file rotation. The -C
and -W option are added to the enable-channel command and control the
maximum size of trace files and the maximum number of them. See man
lttng.1 for more details.

Changelog:

2013-06-25 lttng-tools 2.2.0 (National Catfish Day)
    * STABLE VERSION
    * Fix: if relayd is unreachable, disable consumer for the session
    * Fix: possible infinite loop in disable ust event
    * Fix: don't enable a channel if a session was already started
    * Fix: bad type for the relayd id
    * Fix: add debug statement in kernel flush metadata
    * Fix: destroy default created channel if add-context fails
    * Fix: clarify tracefile size/count in lttng.1 man
    * Fix: don't stop a session that was not previously started
    * Fix: update lttng.1 man page
    * Fix: bad protocol flow between sessiond and consumerd
    * Fix: kernel memory leak in error path

Note that there is still open issues in the bug tracker for 2.2 but they are not
release critical at the moment. New release of 2.2.x will be done once they are
all fixed or, of course, any critical bugs appears after this release.

Please feel free to email the list about any questions/comments
concerning this release. For bugs or missing documentations, use
bugs.lttng.org!

Using it is testing it!

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.2.0.tar.bz2 (for
the PGP signature, same file with .asc appended)

Thanks to all! Cheers!
David
