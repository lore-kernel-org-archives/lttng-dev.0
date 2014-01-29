From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.4.0-rc3
Date: Wed, 29 Jan 2014 17:04:46 +0000 (UTC)
Message-ID: <225199525.14901.1391015086986.JavaMail.zimbra__14387.7955888913$1391015156$gmane$org@efficios.com>
References: <1387734468.14900.1391015075560.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1W8YZI-00074L-2D
	for lttng-dev@lists.lttng.org; Wed, 29 Jan 2014 12:04:57 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id D16EF3400CB
	for <lttng-dev@lists.lttng.org>; Wed, 29 Jan 2014 17:04:49 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id cEX3L_Zt8wx1 for <lttng-dev@lists.lttng.org>;
	Wed, 29 Jan 2014 17:04:47 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 8433D3401F1
	for <lttng-dev@lists.lttng.org>; Wed, 29 Jan 2014 17:04:47 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id S-kfckfpnuWP for <lttng-dev@lists.lttng.org>;
	Wed, 29 Jan 2014 17:04:47 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
	by mail.efficios.com (Postfix) with ESMTP id 48D253400CB
	for <lttng-dev@lists.lttng.org>; Wed, 29 Jan 2014 17:04:47 +0000 (UTC)
In-Reply-To: <1387734468.14900.1391015075560.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

LTTng-UST, the Linux Trace Toolkit Next Generation Userspace Tracer, is
port of the low-overhead tracing capabilities of the LTTng kernel tracer
to user-space. The library "liblttng-ust" enables tracing of
applications and libraries.

Changelog:
2014-01-29 lttng-ust 2.4.0-rc3
        * Fix: add missing JUL loglevel handling
        * Cleanup gen-tp: add quotes around AM_CC
        * Pass the CC variable to the example Makefiles
        * cleanup ust_baddr and ust_baddr_statedump doc
        * baddr: add ust_baddr and ust_baddr_statedump doc
        * Fix: baddr_statedump tracepoint registration
        * Fix: baddr out of tree build

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
