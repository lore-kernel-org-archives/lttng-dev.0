From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng Tools 2.1.2
Date: Thu, 11 Jul 2013 17:30:01 -0400
Message-ID: <51DF23D9.7010807__16220.1893552721$1373578243$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UxORH-0002Js-6t
	for lttng-dev@lists.lttng.org; Thu, 11 Jul 2013 17:30:11 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id CD869A1DA0
	for <lttng-dev@lists.lttng.org>; Thu, 11 Jul 2013 21:29:58 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Gq8rPGWjnhCs for <lttng-dev@lists.lttng.org>;
	Thu, 11 Jul 2013 21:29:56 +0000 (UTC)
Received: from 127.0.0.1 (unknown [96.127.207.22])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id CEF9FA1D9C
	for <lttng-dev@lists.lttng.org>; Thu, 11 Jul 2013 21:29:55 +0000 (UTC)
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

2013-07-11 lttng-tools 2.1.2
    * Fix: don't create a channel on an enable channel
    * Fix: remove double consumer_del_stream in error path
    * Fix: handle invalid ops pointer in relayd_close()
    * Fix: lttng create default name check
    * Fix: add missing error output
    * Fix: minor errors in lttng.1 man page
    * Fix: kernel function event was listed as probe
    * Add unsupported error code to lttng cmd line
    * Fix: typo in the create command help and man page
    * Fix: session name max length was not handled correctly
    * Fix: lttng UI failed to report error 19
    * Fix: put session list lock around the app registration
    * Fix: add poll entry/exit around relayd_connect()
    * Fix: set relayd sock sent flag per consumer socket
    * Fix: change health poll update to entry/exit calls
    * Fix: support duplicate health type
    * Fix: remove consumer health poll update on startup
    * Fix: add missing unistd.h for fdatasync in compat-fcntl.c
    * Cleanup unused health state reference
    * Fix: health subsystem issues with shared code
    * Fix: poll max size should be checked during resize
    * Fix: wrong variable type for read() return value
    * Fix: add missing rcu lock for UST lookup
    * Fix: add missing rcu read side lock
    * Fix: UST returns -LTTNG_UST_ERR_NOENT and not -ENOENT
    * Fix: add missing fd put on stream creation error
    * Fix: change function name for better meaning
    * Fix: improve error handling for UST stream creation
    * Fix: remove duplicate set ust event filter

Using it is testing it!

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.1.2.tar.bz2 (for
the PGP signature, same file with .asc appended)

Cheers!
David
