From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.1.3
Date: Thu, 11 Jul 2013 16:33:19 -0400
Message-ID: <20130711203319.GB23681__19826.4939398088$1373574831$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UxNYG-0001qX-I0
	for lttng-dev@lists.lttng.org; Thu, 11 Jul 2013 16:33:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id 5ED0E140236
	for <lttng-dev@lists.lttng.org>; Thu, 11 Jul 2013 16:33:20 -0400 (EDT)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id ETRM9dRczFtH for <lttng-dev@lists.lttng.org>;
	Thu, 11 Jul 2013 16:33:19 -0400 (EDT)
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
2.x tracer toolset.

Changelog:
2013-07-11 LTTng modules 2.1.3
        * Fix: ring buffer: get_subbuf() checks should be performed on "consumed" parameter
        * Fix: SWITCH_FLUSH new sub-buffer checks
        * Fix: ring buffer: handle concurrent update in nested buffer wrap around check
        * Fix: handle writes of length 0
        * Fix: ring buffer: RING_BUFFER_FLUSH ioctl buffer corruption

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
