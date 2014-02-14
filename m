From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.4.0-rc4
Date: Fri, 14 Feb 2014 16:49:26 +0000 (UTC)
Message-ID: <1164404918.25142.1392396566252.JavaMail.zimbra__3543.58709087155$1392396687$gmane$org@efficios.com>
References: <1749761650.25141.1392396546824.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WELx9-0004Wx-Sf
	for lttng-dev@lists.lttng.org; Fri, 14 Feb 2014 11:49:33 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id BDA013400BC
	for <lttng-dev@lists.lttng.org>; Fri, 14 Feb 2014 16:49:27 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id gBG0PlpkuKdi for <lttng-dev@lists.lttng.org>;
	Fri, 14 Feb 2014 16:49:26 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 8DF6A34027B
	for <lttng-dev@lists.lttng.org>; Fri, 14 Feb 2014 16:49:26 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id UMfQPo8DSe5y for <lttng-dev@lists.lttng.org>;
	Fri, 14 Feb 2014 16:49:26 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
	by mail.efficios.com (Postfix) with ESMTP id 6BCCF3400BC
	for <lttng-dev@lists.lttng.org>; Fri, 14 Feb 2014 16:49:26 +0000 (UTC)
In-Reply-To: <1749761650.25141.1392396546824.JavaMail.zimbra@efficios.com>
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
2014-02-14 LTTng modules 2.4.0-rc4
        * Fix: use after free in ring buffer clients
        * Fix: Add statedump exit so module is not permanent
        * Cleanup: move callback init to static initialization
        * Fix: OOT lttng-statedump tracepoints not visible with signed kernels

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
