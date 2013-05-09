From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng Tools 2.2.0-rc2 (Cuda)
Date: Thu, 09 May 2013 10:17:23 -0400
Message-ID: <518BAFF3.5030207__6487.55407096377$1368109087$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UaRf1-0000XH-FB
	for lttng-dev@lists.lttng.org; Thu, 09 May 2013 10:17:31 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id E6D4FA1D9A
	for <lttng-dev@lists.lttng.org>; Thu,  9 May 2013 14:17:22 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3P4qpjmSzfTe for <lttng-dev@lists.lttng.org>;
	Thu,  9 May 2013 14:17:22 +0000 (UTC)
Received: from 127.0.0.1 (unknown [96.127.207.22])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id 13AA3A1D99
	for <lttng-dev@lists.lttng.org>; Thu,  9 May 2013 14:17:21 +0000 (UTC)
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

One thing worth noting is that now the lttng UI will round up subbuffer
size to the next power of 2 if needed and warn you about it. Here is an
example with enable-channel.

$ lttng enable-channel --subbuf-size 15000 chan1 -u
Warning: The subbuf size (15000) is rounded to the next power of 2 (16384)

I won't print the full change log here because it's quite big. Most
patches are bug fixes and documentation improvements. You can see the
complete change log by looking at the ChangeLog file in the code base or
by doing a "git show" on the commit id below.

commit afeab1758cb2d7c7d672bddcaed6ab41fec93b92
Author: David Goulet <dgoulet@efficios.com>
Date:   Thu May 9 10:05:44 2013 -0400

    Update version to v2.2.0-rc2

    Signed-off-by: David Goulet <dgoulet@efficios.com>

Please feel free to email the list about any questions/comments
concerning this release. For bugs or missing documentations, use
bugs.lttng.org!

Using it is testing it!

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.2.0-rc2.tar.bz2 (for
the PGP signature, same file with .asc appended)

sha1sum: c5c43f604fa9099c5ee124511925ee875f58bf29

Thanks to all! Cheers!
David
