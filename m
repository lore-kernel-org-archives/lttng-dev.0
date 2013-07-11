From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng Tools 2.2.1
Date: Thu, 11 Jul 2013 17:42:38 -0400
Message-ID: <51DF26CE.9050004__42797.8769796484$1373578998$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UxOdS-0002QV-9S
	for lttng-dev@lists.lttng.org; Thu, 11 Jul 2013 17:42:46 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id DED42A1DA0
	for <lttng-dev@lists.lttng.org>; Thu, 11 Jul 2013 21:42:33 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mDWuCUtO-hiv for <lttng-dev@lists.lttng.org>;
	Thu, 11 Jul 2013 21:42:33 +0000 (UTC)
Received: from 127.0.0.1 (unknown [96.127.207.22])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id 122EBA1D9C
	for <lttng-dev@lists.lttng.org>; Thu, 11 Jul 2013 21:42:32 +0000 (UTC)
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

2013-07-11 lttng-tools 2.2.1
    * Fix: consumer err_sock cloexec
    * Fix: possible consumer sockets double close on cleanup
    * Fix: add gpl and lgpl files to tarball
    * Fix: don't install libtap system wide
    * Fix: close consumer sockets in sessiond cleanup
    * Fix: print errno message on connect() error
    * Fix: possible double-close on stream out_fd
    * Fix: session ID signess to uin64_t in sessiond
    * Fix: consumer_add_relayd_socket() report errors to sessiond
    * Fix: UST per-UID channels persist across application teardown
    * Fix: add missing enum lttcomm_return_code entries
    * Fix: detect the correct version of LTTng-UST
    * Fix: sessiond: use uint64_t for all session ids
    * Fix: consumer: use uint64_t for all sessiond_id
    * Fix: periodical flush check trace before stop
    * Fix: consumer: 64-bit index for relayd rather than 32-bit (v2)
    * Fix: send per-pid session id in channel creation
    * Fix: consumer double-close on error
    * Update URCU detection to correctly check for a 0.7 version
    * Fix: set hidden attribute to utils_* calls

Using it is testing it!

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.2.1.tar.bz2 (for
the PGP signature, same file with .asc appended)

Cheers!
David
