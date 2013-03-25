From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.1.2
Date: Mon, 25 Mar 2013 14:40:45 -0400
Message-ID: <20130325184045.GA26037__7355.8934302584$1364236905$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UKCK7-00015m-VN
	for lttng-dev@lists.lttng.org; Mon, 25 Mar 2013 14:40:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id AFC75140592
	for <lttng-dev@lists.lttng.org>; Mon, 25 Mar 2013 14:40:47 -0400 (EDT)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id 1A33KUpVZpLM for <lttng-dev@lists.lttng.org>;
	Mon, 25 Mar 2013 14:40:45 -0400 (EDT)
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

Changelog:
2013-03-25 lttng-ust 2.1.2
        * Fix uninitialized has_loglevel variable
        * tracepoint: Don't add NULL probes
        * Remove mention of locking issues associated with dlopen usage
        * Fix: refcount issue in lttng-ust-abi.c
        * Fix: don't flush-final for offset 0 if reader is on sub-buffer
        * Use tp rcu link test in provider
        * Remove direct dependency of probes on urcu-bp
        * Fix package: don't distribute generated headers
        * Fix: don't cancel already exited threads
        * Scalability fix: tracepoint.c hash table size increase
        * Scalability fix for many events: event hash table size
        * Speed up probe registration for large amount of events
        * Add missing demo-trace shell script to dist tarball
        * Fix: missing test for lttng_ust_comm_should_quit in
        * lttng-ust-comm.c
        * Documentation: clarify debian package name for uuid in README
        * Document dependency on libuuid
        * Fix: comment in ust-ctl.h
        * Fix I/O-related error values in ustctl

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
