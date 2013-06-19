From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.0.7
Date: Tue, 18 Jun 2013 20:33:22 -0400
Message-ID: <20130619003322.GA19766__22409.3035482385$1371602044$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Up6L0-0001Gt-CZ
	for lttng-dev@lists.lttng.org; Tue, 18 Jun 2013 20:33:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id BDB51141819
	for <lttng-dev@lists.lttng.org>; Tue, 18 Jun 2013 20:33:23 -0400 (EDT)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id sUP6WsLSDVeI for <lttng-dev@lists.lttng.org>;
	Tue, 18 Jun 2013 20:33:22 -0400 (EDT)
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

LTTng-UST 2.0.x is getting closer to end-of-line. If you experience
issues, please move on to the newer 2.1.x or soon-to-come 2.2.x.

Changelog:
2013-06-18 lttng-ust 2.0.7
        * Fix bug introduced by backport of "Clarify probe registration
          documentation/errors"
        * Clarify probe registration documentation/errors
        * Add mising include in ust.h
        * lttng-gen-tp: Fix include guard name with file using non valid
          characters
        * Cleanup lttng-gen-tp: remove leading underscore before include guard
        * manpage: Document probe provider compatibility
        * Fix: don't build C++ example if a C++ compiler isn't available

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
