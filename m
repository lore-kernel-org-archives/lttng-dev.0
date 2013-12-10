From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.4.0-rc2
Date: Tue, 10 Dec 2013 19:20:32 +0000 (UTC)
Message-ID: <780637021.83157.1386703232503.JavaMail.zimbra__3646.45119193501$1386703293$gmane$org@efficios.com>
References: <221118169.83156.1386703224401.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VqSrD-00083b-HF
	for lttng-dev@lists.lttng.org; Tue, 10 Dec 2013 14:20:41 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 919F334026E
	for <lttng-dev@lists.lttng.org>; Tue, 10 Dec 2013 19:20:38 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id bU4FkebhV-cd for <lttng-dev@lists.lttng.org>;
	Tue, 10 Dec 2013 19:20:34 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id D66CA3401D8
	for <lttng-dev@lists.lttng.org>; Tue, 10 Dec 2013 19:20:32 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id i6F_7mdYefVu for <lttng-dev@lists.lttng.org>;
	Tue, 10 Dec 2013 19:20:32 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
	by mail.efficios.com (Postfix) with ESMTP id B13CC3400AA
	for <lttng-dev@lists.lttng.org>; Tue, 10 Dec 2013 19:20:32 +0000 (UTC)
In-Reply-To: <221118169.83156.1386703224401.JavaMail.zimbra@efficios.com>
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
2013-12-10 LTTng modules 2.4.0-rc2
        * Fix: client_packet_header() uses wrong packet
        * Cleanup: fix typo in ring buffer backend comment
        * Fix: handle unknown event type parameter
        * Fix: eliminate timestamp overlap between packets
        * gcc blacklist: only apply when building with gcc
        * Blacklist ARM gcc 4.8.0, 4.8.1, 4.8.2

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
