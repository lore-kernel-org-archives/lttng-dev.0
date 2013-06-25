From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.2.0 - Cuda (STABLE)
Date: Tue, 25 Jun 2013 18:01:11 -0400
Message-ID: <20130625220111.GA16785__34729.0727928796$1372197705$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UrbIY-0005EF-NI
	for lttng-dev@lists.lttng.org; Tue, 25 Jun 2013 18:01:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id 751BD1418CE
	for <lttng-dev@lists.lttng.org>; Tue, 25 Jun 2013 18:01:12 -0400 (EDT)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id Ah8YzNg8e6UB for <lttng-dev@lists.lttng.org>;
	Tue, 25 Jun 2013 18:01:11 -0400 (EDT)
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

LTTng-UST, the Linux Trace Toolkit Next Generation Userspace Tracer, is
port of the low-overhead tracing capabilities of the LTTng kernel tracer
to user-space. The library "liblttng-ust" enables tracing of
applications and libraries.

Noteworthy new feature in LTTng-UST 2.2.0:

- per UID buffers for UST,
- periodical flush for metadata,
- trace file rotation.

See the lttng-tools announcement for details.

Changelog since 2.2.0-rc3:
2013-06-25 lttng-ust 2.2.0
        * Disable doc/examples build
        * Fix: lttng-events VPATH build
        * doc/examples: build gen-tp example by default
        * doc/examples: support BSD make

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
