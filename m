From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.4.0
Date: Fri, 28 Feb 2014 18:42:09 +0000 (UTC)
Message-ID: <239077444.32427.1393612929206.JavaMail.zimbra__48554.4305331588$1393614178$gmane$org@efficios.com>
References: <1025970793.32425.1393612903792.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WJSNv-0006rE-7L
	for lttng-dev@lists.lttng.org; Fri, 28 Feb 2014 13:42:16 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 5CD9A34017A
	for <lttng-dev@lists.lttng.org>; Fri, 28 Feb 2014 18:42:12 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id 1PqzF0jDw277 for <lttng-dev@lists.lttng.org>;
	Fri, 28 Feb 2014 18:42:09 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 87490340212
	for <lttng-dev@lists.lttng.org>; Fri, 28 Feb 2014 18:42:09 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id dA-PZ4W_8wg4 for <lttng-dev@lists.lttng.org>;
	Fri, 28 Feb 2014 18:42:09 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
	by mail.efficios.com (Postfix) with ESMTP id 577F334017A
	for <lttng-dev@lists.lttng.org>; Fri, 28 Feb 2014 18:42:09 +0000 (UTC)
In-Reply-To: <1025970793.32425.1393612903792.JavaMail.zimbra@efficios.com>
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
2014-02-28 (Public Sleeping Day) LTTng modules 2.4.0
        * Fix: load state dump even if work-around lookup fails
        * Cleanup: fix comment
        * Fix: correctly version kvm events to build against v3.0 kernel
        * Add extraversion (e.g. -rc4) to lttng-tracer modinfo

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
