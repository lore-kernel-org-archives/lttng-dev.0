From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.2.3
Date: Tue, 12 Nov 2013 17:30:31 +0000 (UTC)
Message-ID: <1982866603.65248.1384277431608.JavaMail.zimbra__4285.37719785726$1384277677$gmane$org@efficios.com>
References: <80875994.65247.1384277423134.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VgHnM-0008Rd-Se
	for lttng-dev@lists.lttng.org; Tue, 12 Nov 2013 12:30:38 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 1848A340104
	for <lttng-dev@lists.lttng.org>; Tue, 12 Nov 2013 17:30:33 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id uNaDt4NXo5ZL for <lttng-dev@lists.lttng.org>;
	Tue, 12 Nov 2013 17:30:32 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id E2971340230
	for <lttng-dev@lists.lttng.org>; Tue, 12 Nov 2013 17:30:31 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id CSrXHzg-FuiC for <lttng-dev@lists.lttng.org>;
	Tue, 12 Nov 2013 17:30:31 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
	by mail.efficios.com (Postfix) with ESMTP id C127B34022F
	for <lttng-dev@lists.lttng.org>; Tue, 12 Nov 2013 17:30:31 +0000 (UTC)
In-Reply-To: <80875994.65247.1384277423134.JavaMail.zimbra@efficios.com>
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
2013-11-12 LTTng modules 2.2.3
        * lttng-statedump-impl: Fix lttng_list_interrupts for empty implementation
        * Import fix from LTSI: 3.4+ RT kernels use CONFIG_PREEMPT_RT_FULL

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
