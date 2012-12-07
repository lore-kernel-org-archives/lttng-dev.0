From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.0.6
Date: Fri, 7 Dec 2012 17:38:29 -0500
Message-ID: <20121207223829.GA24609__39170.2967849143$1354919952$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Th6Yw-0005f2-Au
	for lttng-dev@lists.lttng.org; Fri, 07 Dec 2012 17:38:30 -0500
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id 0526814029F
	for <lttng-dev@lists.lttng.org>; Fri,  7 Dec 2012 17:38:30 -0500 (EST)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id jXqf+s2FNEHl for <lttng-dev@lists.lttng.org>;
	Fri,  7 Dec 2012 17:38:29 -0500 (EST)
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

The LTTng modules provide Linux kernel tracing capability to the LTTng
2.0 tracer toolset.

The most visible effect of the fixes in this release is that time-stamps
for ARM kernel tracing will now be synchronized with LTTng-UST
user-level traces. This only affects architectures without
CONFIG_KTIME_SCALAR.

Changelog:
2012-12-07 LTTng modules 2.0.6
        * lib/ringbuffer/frontend_api.h: Include linux/prefetch.h.
        * Fix warning with 3.6.0 kernel
        * Fix: compat layer only on supported architectures
        * Fix ring buffer 32/64 bits compat
        * Fix cleanup: move lttng-tracer-core.h include to lib ringbuffer config.h
        * Fix ring_buffer_frontend.c: missing include lttng-tracer-core.h
        * fix timestamps on architectures without CONFIG_KTIME_SCALAR

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
