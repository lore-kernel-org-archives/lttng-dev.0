From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng Tools 2.0.6
Date: Thu, 11 Jul 2013 17:24:52 -0400
Message-ID: <51DF22A4.4080708__10297.097991179$1373577936$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UxOMH-0002G3-Vu
	for lttng-dev@lists.lttng.org; Thu, 11 Jul 2013 17:25:02 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 3B22BA1DA0
	for <lttng-dev@lists.lttng.org>; Thu, 11 Jul 2013 21:24:49 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id K73kvx6Ky4qd for <lttng-dev@lists.lttng.org>;
	Thu, 11 Jul 2013 21:24:47 +0000 (UTC)
Received: from 127.0.0.1 (unknown [96.127.207.22])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id 62260A1D9C
	for <lttng-dev@lists.lttng.org>; Thu, 11 Jul 2013 21:24:47 +0000 (UTC)
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

2013-07-11 lttng-tools 2.0.6
    * Fix: Delete UST app session on ustctl create error

Using it is testing it!

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.0.6.tar.bz2 (for
the PGP signature, same file with .asc appended)

Cheers!
David
