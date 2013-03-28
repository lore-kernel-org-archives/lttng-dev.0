From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng Tools 2.2.0-rc1 (Cuda)
Date: Thu, 28 Mar 2013 16:35:04 -0400
Message-ID: <5154A978.80708__24838.9225489975$1364502959$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1ULJXP-0003Ko-V6
	for lttng-dev@lists.lttng.org; Thu, 28 Mar 2013 16:35:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 8AA821874F0
	for <lttng-dev@lists.lttng.org>; Thu, 28 Mar 2013 16:41:13 -0400 (EDT)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rpVF6CAMKHWM for <lttng-dev@lists.lttng.org>;
	Thu, 28 Mar 2013 16:41:13 -0400 (EDT)
Received: from 127.0.0.1 (unknown [96.127.207.22])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id CCBA31874EB
	for <lttng-dev@lists.lttng.org>; Thu, 28 Mar 2013 16:41:12 -0400 (EDT)
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

Introducing "Cuda", the 2.2.0-rc1 release. Use "lttng version" for a
full description of the codename.

We are now in feature freeze for 2.2 and this is the release candidate
1. Some bugs are still in the pipe in the bug tracker but the new
features are now usable and ready for your precious testing! The
following ChangeLog lists what was added in this version.

2013-03-28 lttng-tools 2.2.0-rc1
    * Add UST per UID buffers support
    * UST metadata generation are created on the sessiond side
    * Move LTTng-UST buffer ownership from application to consumer
    * Add a UST registry of events and channel in the sessiond
    * UST periodical metadata flush
    * Refactor tests to use prove and tap
    * Support for trace file rotation for the relayd and on disk
    * Support per-context filtering
    * Add channel wakeup fd to monitor close
    * Deprecate enable/disable-consumer
    * Multiple fixes and memory leak fix.

The major addition is the UST per UID buffers which can be used like this:

$ lttng create
$ lttng enable-channel chan1 -u --buffers-uid

From this point on, the session only support per UID channel. Per PID
and per UID buffers can NOT coexist.

$ lttng enable-event -a -u -c chan1
$ lttng start
...

Every application sharing the same UID will use the same buffers.

Furthermore, you can now set the attributes of the channel metadata.
This is particularly useful with the periodical flush that was added for
the metadata. For instance:

$ lttng enable-channel metadata --switch-timer 200000 -u

Also, the buffers for UST application are now created in the consumer
and passed to the application. Thus, the buffer ownership has been
transfered from the UST tracer to the consumer.

Finally, the new feature worth noting is the trace file rotation. The -C
and -W option are added to the enable-channel command and control the
maximum size of trace files and the maximum number of them. See man
lttng.1 for more details.

Please feel free to email the list about any questions/comments
concerning this release. For bugs or missing documentations, use
bugs.lttng.org!

Using it is testing it!

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.2.0-rc1.tar.bz2 (for
the PGP signature, same file with .asc appended)

Thanks to all! Cheers!
David
